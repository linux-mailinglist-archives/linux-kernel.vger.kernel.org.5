Return-Path: <linux-kernel+bounces-154565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6058ADDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F59DB20B21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC52C6BC;
	Tue, 23 Apr 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rhPQ2CV+"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FCC4779D;
	Tue, 23 Apr 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854724; cv=none; b=Lja9G0JpMYyXgpDGjSMO/yq4kFMdD83CQMFjwE5EfyXar+Q8v7xOIXbIqNl0YY1iDuVvKBht64P4coC2fT0YMapG5qHmydBE0ur3Gz1ZIKcJZxLk6QVG0YAQZbJasFbkraxFR0rlu88nmOe2CYvdaw/5ROXLhWOeoO6SpEHQMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854724; c=relaxed/simple;
	bh=/8UG4gXHPEjzqQauQjn7i+cz8eMeT4m/eMNC5CnSkI4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IVERTG1cIR0LlWP8Xm4k2OHFXRiOMbu0MkI0Cp03tU4sQnfgCjhwUuf20CfOAhFNrwR4LVbqzb0z36mgk3TkohiWPN9JlyPExO3DiMVr8Flq1oup6MYlRu59WONTc+wOJHBp/REbrteJVpxayX3VxUrWSI9qKlA+YT+c2t1PMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rhPQ2CV+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713854712; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=2Bh4K1u+LZbAykGU6w9RgWH0PLEDjVXql/jyM2G15cE=;
	b=rhPQ2CV+JZYFooyDt2EV76dDmv6+oLP86ViNlpwSeKlQ5xZq/4YeaC/2xN/WsZhpZkG1SeD65+5Jh2MgqCJJungfJ2be1hcqiLLVZdXgEztiIhncWh2jE0T/2SKulbzkSSigISJPJDx1ngQCHdw3vLS+zW4R8aFMgq1SaztvZNU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W580vZc_1713854701;
Received: from 30.221.129.150(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W580vZc_1713854701)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 14:45:11 +0800
Message-ID: <6907c23c-a9b4-4366-99e5-b175319f9061@linux.alibaba.com>
Date: Tue, 23 Apr 2024 14:45:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <3bc12c1e-c36c-4b34-8bc4-57ebb07038c2@linux.ibm.com>
In-Reply-To: <3bc12c1e-c36c-4b34-8bc4-57ebb07038c2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/17 23:36, Wenjia Zhang wrote:
> 
> 
> On 14.04.24 06:02, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
>>
>>
> Still need some time to review the patches.
> 
> Thanks for your patience!

Hi Wenjia, is there any update on the review?

Thanks!

