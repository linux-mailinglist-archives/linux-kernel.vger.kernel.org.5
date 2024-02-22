Return-Path: <linux-kernel+bounces-76221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF485F45D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642921C210BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F1374F0;
	Thu, 22 Feb 2024 09:30:06 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E831799E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594206; cv=none; b=qX595mlQUg16VWWQjhBd417n8rAoUewv9WCgFGlkA/PYxfzBICj0+cQQ0u6G95DBQtqvGqMBnhaI4tGCJsWpomlEaJhER4fPOvqHPGEcz/a87YgxTfCjFDWYy1fxBdtaeT3BLBMUHsksBoXCfxe11+rDcYuLMTglRytoslBghiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594206; c=relaxed/simple;
	bh=ATirct5j7/UgsL9VN4sLML1TugObK0awfmxeDDWVl90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VejhjYjFrjdCUKNFUWz8TrSac7oyJvOppqUP2A79FYz0vJ1+0Db5q4wLAKRR4n7Y9CeyuZirjTBAOPmiiAmZObeSSWaV6HPjpFCR1njGhu8Gw0TbORO4/NXHj1M2++ZWfYUbocpXFP4uatotHCzzLJsROpke5BS15ipZocrXt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp76t1708594089t42g9cme
X-QQ-Originating-IP: uZaBuuerpbJedRsEZ9jUaaSGJG/JYymkPiqjq0p+6Lg=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Feb 2024 17:28:07 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: 3M0okmaRx3gdSYb9a+Tphtc3Dda53QAmBlIcXrph1tt42jwojHxNbzZD7xKxg
	g+uQRHeIjFmHCcdPMzARVUbEXsQpx/v6H3ZGKT58h98y81+rzCeRiWIvtfXWJARYv6qFWxc
	EbNRwuFQBe/Gkkw+4rPdb6HRI2d6F2gZMgBI0GTvr7O2Uz+7qtrRZBzTfOmaSVeqMcGm+pN
	1wqtwslDeayVEPpufm0KPdSinxM5r9kgFLsLYiiRXO2zpjyJi/YkRyIp/AFqJy9volIEgoJ
	Ds0bqpwoZe7ELFfIcx0vNB46VWlD1JvBAmTSUiV5eE9pVVwtLXlwwddOs0aFXOATOtDuo35
	Pwme0gg98J2Z/YquPZjSGr5M8JgGNmRz9uW9ogqZXlVcl+VN9edy9vyVHKqEg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11809283143458204403
Date: Thu, 22 Feb 2024 17:27:57 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: catalin.marinas@arm.com, will@kernel.org
Cc: mark.rutland@arm.com, mcgrof@kernel.org, jpoimboe@kernel.org,
	j.granados@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: remove unneeded BUILD_BUG_ON assertion
Message-ID: <A12F96370D84BE9F+ZdcTnYkBf/5n/DlT@centos8>
References: <20240202040211.3118918-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202040211.3118918-1-dawei.li@shingroup.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

On Fri, Feb 02, 2024 at 12:02:11PM +0800, Dawei Li wrote:
> Since commit c02433dd6de3 ("arm64: split thread_info from task stack"),
> CONFIG_THREAD_INFO_IN_TASK is enabled unconditionally for arm64. So
> remove this always-true assertion from arch_dup_task_struct.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

Just a gentle remainder:).

Thanks,

    Dawei

> ---
>  arch/arm64/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 7387b68c745b..4ae31b7af6c3 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -290,9 +290,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  		fpsimd_preserve_current_state();
>  	*dst = *src;
>  
> -	/* We rely on the above assignment to initialize dst's thread_flags: */
> -	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
> -
>  	/*
>  	 * Detach src's sve_state (if any) from dst so that it does not
>  	 * get erroneously used or freed prematurely.  dst's copies
> -- 
> 2.27.0
> 

