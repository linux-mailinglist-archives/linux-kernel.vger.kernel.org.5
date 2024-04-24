Return-Path: <linux-kernel+bounces-157534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009B8B1273
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103E21F21999
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D31772F;
	Wed, 24 Apr 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A0qyPPgA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAC568A;
	Wed, 24 Apr 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983694; cv=none; b=i53wJB0Er1X9zjRNv4zjhxbG7VWswFIBt4IjFS8JRt//l1K7e4fFyc2OHC81peX8c72ZTfnGocUYHKBA/ANAHczSmIHF9STrgnu5/sDbBsm/W/oV94TO2K9uvW9BTXoWx/jbAwRhrB5BtrtqajkVVlzi9E1X9AqbuQhE4TFGPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983694; c=relaxed/simple;
	bh=oCVgc8+y+x5fGR5TsGfG0er7opagmP5XkKqOTf2aT8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQbgL4V7S1zpCTtNSx+M5Fx0JEYaOeai/zD5a+OZot80R1IbDsBpk0rF+bvj8W30muOk6gnWH1YXyr+bsjnbVhLsmpFcPKR4A4q/db/08Un+Zr+5JigfOduKcWfMNB+fg37F/C0Bjxcfy8/v1pN226OpROIoN0pkXug92wKnF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A0qyPPgA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E02140E0249;
	Wed, 24 Apr 2024 18:34:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l1nWQHHUdBYV; Wed, 24 Apr 2024 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713983682; bh=FG75FcCiem2JbZ6KSePc6u6dCPqsNWw2QYqFUaBzuCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0qyPPgACV7iQcsfRBB6k21KrwTs5zRrI26jR4Zu/5XDMuISbDs7sKXnX8XUya/55
	 RwWclRe7Y2YbqnybkJMauceHVYOEuVI0+viBsOtmDCfNUnrJXumOQMaH7KL1jA1ZmB
	 QQLUNKhH7FaoXlGEz7sXAAfYXuayR9/wgF4npoBD4Xhhh3IYe+Dm0lX9uYaWN/xL8/
	 253Kir+YZXCNvBGq94BW0rEgN1jLh95v1U/Yeib8EAamTkAYgF/4grr+8NjTLH91al
	 LdcXNfM0ru6+JZFqu7IsKS2Rai6L0SLjSkxuPSkaxJyIChaRB0ijwwHYt+VEMVkG5/
	 ISgutzRhAC/hJhYvAG8kYxNlJhxRvuNzhPMtu7/hoULcHGigK27YQDQEKCar13X1ng
	 cM3ISXXGuTmfxBQwXHovMJInzYez+ksnDjvZbWnaDqXGNCaAOQFiWY6+Cde01IYGvy
	 FS7tIgeTxGUXr5LwhmxOluXbYGnKy2/Xh7INT+ajCNOI0XIlVG4yMN/qP/hD5Zl/D6
	 Li1S4Cbeq61y1N7bgHeT0nGoC+ipm6nsXKXf6ufiFSHoyikP1NHMUnGH66TOrkxkHo
	 fNfeVkEq0IPCsAyNjXOwJi5NW5XtKmZmMtHNCmV4wpp7xXYAETXNcKd3wBoBKDqqCv
	 SM/Y6uOqKSQXZfa5dhGazQJA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5730540E016B;
	Wed, 24 Apr 2024 18:34:35 +0000 (UTC)
Date: Wed, 24 Apr 2024 20:34:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce/amd: Prep DFR handler before enabling
 banks
Message-ID: <20240424183429.GGZilQtVJtGhOPm1ES@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-7-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:49AM -0500, Yazen Ghannam wrote:
> Scalable MCA systems use the per-bank MCA_CONFIG register to enable
> deferred error interrupts. This is done as part of SMCA configuration.
> 
> Currently, the deferred error interrupt handler is set up after SMCA
> configuration.
> 
> Move the deferred error interrupt handler set up before SMCA
> configuration. This ensures the kernel is ready to receive the
> interrupts before the hardware is configured to send them.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>     Link:
>     https://lkml.kernel.org/r/20231118193248.1296798-11-yazen.ghannam@amd.com
>     
>     v1->v2:
>     * No change.
> 
>  arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 3093fed06194..e8e78d91082b 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -589,6 +589,9 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>  	u32 low = 0, high = 0;
>  	int def_offset = -1, def_new;
>  
> +	if (!mce_flags.succor)

Does succor imply smca?

Because you have now this order:

	deferred_error_interrupt_enable(c);

	...

	configure_smca(bank);

and that one tests mce_flags.smca

Now, if succor didn't imply smca, we'll enable the DF irq handler for
no good reason on (succor=true && smca=false) systems.

If the implication is given:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

