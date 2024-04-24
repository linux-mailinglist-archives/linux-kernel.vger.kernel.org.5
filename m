Return-Path: <linux-kernel+bounces-156127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E88AFE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192BA285AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B72419479;
	Wed, 24 Apr 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e7uwacfc"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36F17758;
	Wed, 24 Apr 2024 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924831; cv=none; b=swDvAqdiXUdd26ikhApkUbLdznAXSj/LB8kCthMwv0vlqPJpGfL6jYHrXDTcw1omLPozOvNnKS6y2QMPbR55twKm2A4L76rr4g4KUElhVGNty9e1eXnd3Ih0fQqUquT23cgg2QanFWIxtv2odLTMKL9hFvrIv5Ra9JxkHtmKpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924831; c=relaxed/simple;
	bh=0AjE9zP4E8Flvw9iwoz9dgNwzuUo5I8ra7phX+VJgQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KViKyh2Dsnh7ZZcFyppsXrxIq5u4ZcZ3+5++WvYnwJKEcyXvDM90JXY2N5vvyoaHWX08ys2VvFVCmJDzaaAnUWIW6FaTgETo9tJT7Lh9440407iKfJTKEZEs1NsfeUKdQbZbx5nz6WXPGDs+F/d2NH7KdbZ33qm4I3mbyKBqAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e7uwacfc; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713924826; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eCwe0kYBKJC6Z0H3THeSf/hbnrkxhxMDDPQARlCbV2U=;
	b=e7uwacfcEvjEB27k0X/VOSN8UbGcp9WV9+H7dHAanWHki8W869XhinOLXc+ljhOsUCL7NZlwe1bILjJHlb67fkM6TMkkNtGT99e/RlPe7bd7d8EqKHVp705ogSPHUXr9ymnGSaTPSpll2ETZagBgRrGgBX3IvdYf/XLm0TXcZQ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5AWppJ_1713924824;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5AWppJ_1713924824)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:13:45 +0800
Message-ID: <0dbf63ba-026c-41a7-93fa-55a7a216e627@linux.alibaba.com>
Date: Wed, 24 Apr 2024 10:13:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 erofs-fixes tree
To: Baokun Li <libaokun@huaweicloud.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240424102445.53ba5ba2@canb.auug.org.au>
 <b7332fb7-4c49-3af2-7095-e728a6af8ff7@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b7332fb7-4c49-3af2-7095-e728a6af8ff7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stephen,

On 2024/4/24 09:26, Baokun Li wrote:
> Hi Stephen,
> 
> On 2024/4/24 8:24, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>>
>>    fs/erofs/super.c
>>
>> between commits:
>>
>>    ab1bbc1735ff ("erofs: get rid of erofs_fs_context")
>>    569a48fed355 ("erofs: reliably distinguish block based and fscache mode")
>>
>> from the erofs-fixes tree and commit:
>>
>>    e4f586a41748 ("erofs: reliably distinguish block based and fscache mode")
>>
>> from the vfs-brauner tree.
>>
>> I fixed it up (I think - I used the former version) and can carry the
>> fix as necessary. This is now fixed as far as linux-next is concerned,
>> but any non trivial conflicts should be mentioned to your upstream
>> maintainer when your tree is submitted for merging.  You may also want
>> to consider cooperating with the maintainer of the conflicting tree to
>> minimise any particularly complex conflicts.
>>
> Christian previously mentioned that the fix from the vfs-brauner tree
> was an accident:
> 
> "An an accident on my part as I left it in the vfs.fixes branch."
> 
> So the two commits from the erofs-fixes tree are the final fixes.
> 
> I'm very sorry for any inconvenience caused.

Yeah, Christian was picked this fix by accident as mentioned in,
https://lore.kernel.org/r/20240419-tundra-komodowaran-5c3758d496e4@brauner

I guest that was due to his local work at that time since the
original idea to fix this issue was from him (thanks again!).

Currently I tend to submit these two fixes on my own for this
development cycle in order to meet the test plans.

Thanks,
Gao Xiang


> 
> Thanks,
> Baokun

