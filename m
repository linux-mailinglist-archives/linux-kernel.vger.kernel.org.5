Return-Path: <linux-kernel+bounces-103932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AEE87C6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FB51F21A98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8E7EF;
	Fri, 15 Mar 2024 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nz/OGJNh"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA05635
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461578; cv=none; b=izH+qXWvEDUbJz7LaZKSQq0d9Ul5xFiitMJCAfkv7g2Fvs5Uv1bwemHXTEQG+z5oM2+uKO+20F1Mb7/URvnhftkeVDgX9iyWzSqi5xjwi1dNiEMU8FokhmFSwbhYH6xXRMSEXpqEhg/bp3bDVxvayRiJuDwo3w5sWNcDTJ814ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461578; c=relaxed/simple;
	bh=P4m2dsseP+4iTdTkg6tKHfmzPfdv3ozhhUNPWD1ibvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgUohu7A/fMy2qdurttfMogE+uF1I5NY7Y/GBqp8xg7Tt9l6mHW0M+dJY2vj2n1BkHmTn0hOx7J7FrA41PapS3/zK2i3MEo1F/gr5GauMo/dL2Ml5cMczJEaFbkVMnrR6HRRpWY+dtP9dQ98OmUUQSD8g7O+xgs5RVxfyljxxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nz/OGJNh; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710461574; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mzxcmPBrvejvzoRxjiUi2yf+SzWzLw/PHTLUQHWHyr4=;
	b=nz/OGJNhGXoPyI0dGTZLEkJl8B7dF5bkf4xHcnqX2WjIYqjmpljbptTeZpO84P5ZTpKXG4VDbwdjTWyWT8GdsMfMroedY9Dnjq4OtPEdJoO46abho/cE/UqH1s84N9BH/nf2QF7Hgik5YlUVuYaVil9/uXHwFYJozt/8DGOKR9w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2U7MPG_1710461572;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2U7MPG_1710461572)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 08:12:53 +0800
Message-ID: <7f2b1110-fb31-4512-a16c-be1b2fd434e4@linux.alibaba.com>
Date: Fri, 15 Mar 2024 08:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
References: <20240314231407.1000541-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240314231407.1000541-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/15 07:14, Sandeep Dhavale wrote:
> I have been contributing to erofs for sometime and I would like to help
> with code reviews as well.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Looks good to me, and thanks for taking your time on erofs project:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

