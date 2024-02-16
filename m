Return-Path: <linux-kernel+bounces-68938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909F858224
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AD5284166
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5212FB35;
	Fri, 16 Feb 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="mMqOpFPP"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0C12C809;
	Fri, 16 Feb 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099881; cv=none; b=tmGLpyHxiC3vccB/Qifo6Lrgyj/HmVeh0V2fwTunNb7yyEf0e2GhsBWaCzjNvArHtt4KJYMV7tFVJcZHStRJMbNsuMIYqgjhEVI38bbnZYPbvcoftYujmgG9wmGtHyFd5l1tuc9iHv3KPfRdHZ/V5nd2Pu2Z/SZEwZifBXAfZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099881; c=relaxed/simple;
	bh=LfFXnYQiTBQreCbCIUgw5DkCddIa8FMvbEkDGAEoilQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmSZCrX7uYwvatHX8xVkhhC4buID4Ok0nLD5zQq1NaOq4TccUtF8VyZ/Px6vskiPxVT1+5LciTsj9Wh0j58l37gjfSULbsSBiWYJCBS4IGuKJmxJHz6jEngSl/0DeeR9DU08n3sB9vLkSA6jZ+QcCF2m29h8rQtUo3Et5YpE9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=mMqOpFPP; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TbxkL6XtHz67xs;
	Fri, 16 Feb 2024 17:11:06 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TbxkF18p1z67tH;
	Fri, 16 Feb 2024 17:11:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708099866;
	bh=iq3rmFuuuB7xfOB9MLC9H3wTH6FDafTnULPqIUiclBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mMqOpFPPzvHKU+0qKjlWlkP9FbzfmsEjTHyy+/n6utaukdD0LUi4eDr2UJv8QYKMp
	 FeiZWMuReqd0XTzFqfSEX4IyCP+t5jNzVk0vCiKByM82ru54jb9ZYMl0c0/Ef1G0N0
	 rVDjXJBV9q36if8PmUK72lEHfNeefjnVyoOzrjJ0=
Message-ID: <60ce7f04-ef19-41e5-a9ce-002ae5921541@gaisler.com>
Date: Fri, 16 Feb 2024 17:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sparc: remove obsolete config ARCH_ATU
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Christoph Hellwig <hch@lst.de>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231211083029.22078-1-lukas.bulwahn@gmail.com>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20231211083029.22078-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-11 09:30, Lukas Bulwahn wrote:
> Before consolidation of commit 4965a68780c5 ("arch: define the
> ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig"), the config ARCH_ATU
> was used to control the state of the config ARCH_DMA_ADDR_T_64BIT. After
> this consolidation, the config ARCH_ATU has been without use and effect.
> 
> Remove this obsolete config.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to my for-next branch.

Thanks,
Andreas

