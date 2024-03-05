Return-Path: <linux-kernel+bounces-92192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56D871C88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9408285A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DD5733F;
	Tue,  5 Mar 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZhdRbGP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bsu6cyvk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hNE3TfRM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9RKvI0Ye"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7C1DDF4;
	Tue,  5 Mar 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636171; cv=none; b=lnC2D1jWfZIBazvM0k3dhLGGcwcQ6clOCnR3ygiKLFsTTRkPx/DUM4uR2Kp983laJI6n1OGPkSU9+NPLSQriyMGtoJlnJa7ji+KWK+ojvfzxy5JdPFy4KqUPxKSzzZGHKF3UTONFNYyHWcnlfPR1XVmJ5V4cSdbSnAsWpI2HNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636171; c=relaxed/simple;
	bh=6zTJKCs/LiRl+e1EgZBrXxHh0+0Q7evrHJ9ZMxfH5Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScVppITccDUweg2NJUuLhW+GgumIFP5efz211V1a7hXLRbVx65NtqGm21Zf7oNKXOUv2JOAWdlyuy0OXmHW8HhsGUs2cEsRopsiLJht9WEUuMm/H2adqHlqkStWgDvOihgNLp+p7JJNoQkAPtZ/rfVb59qUBNIcRE+uHBehdCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZhdRbGP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bsu6cyvk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hNE3TfRM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9RKvI0Ye; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECF26767C2;
	Tue,  5 Mar 2024 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FNpbwf/Kd2K6dwYnw6gac//GPVMgX+mgVMBZa1f57Q=;
	b=sZhdRbGP11tYX1Hs1zl37OdKGHJCVJOfLFmA5cMKFT95KWhpxDBqtTxUbgy2Ky9F7rlvzz
	EzL2Gy+/gTcqVSAs2NHjTJ+Hadx0vajC5AqROepMMTjEU2i/FhpR6VXPOoIOZHqVkelq6j
	XsNB+KqSXtIsKRrREaC6gPn30Tp9kjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FNpbwf/Kd2K6dwYnw6gac//GPVMgX+mgVMBZa1f57Q=;
	b=Bsu6cyvkv+DgWW8aXCAdbl2VoyAnKfTMmlGRXcCTnBYZDjEmuG5PUeHmU4/zKt3ycseeC6
	dPXqCSROq/+4dYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FNpbwf/Kd2K6dwYnw6gac//GPVMgX+mgVMBZa1f57Q=;
	b=hNE3TfRMSXwY63+QnZjvh1CAvBbxFEoGhWr2Ud282dTWjPHLGoBQQ1QEIDnsSIWOrdmqYu
	50TNuZ3ovCIxcsHSThZPwiw/rNKntDNqL0/ssupLSv5PL+qLx6iN8ZvwMtQTiivncqR89k
	Okbyz0cWTC7Cp6dndWFkp2uVH/l4Mjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FNpbwf/Kd2K6dwYnw6gac//GPVMgX+mgVMBZa1f57Q=;
	b=9RKvI0YeQLL2//ciZ5iSbZZzt/QoYxvS3pyUmL0TmS/xQGGOxjO8iCBLB9V50A2rxLxOUq
	JofBGjCPa2BaJaCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E4C13466;
	Tue,  5 Mar 2024 10:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nNeEMUX65mVoBwAAn2gu4w
	(envelope-from <aporta@suse.de>); Tue, 05 Mar 2024 10:56:05 +0000
Date: Tue, 5 Mar 2024 11:56:05 +0100
From: Andrea della Porta <aporta@suse.de>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Add the arm64.no32bit_el0 command line option
Message-ID: <Zeb6RX2wpBvuJiIZ@apocalypse>
Mail-Followup-To: Andrea della Porta <andrea.porta@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240207105847.7739-1-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207105847.7739-1-andrea.porta@suse.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hNE3TfRM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9RKvI0Ye
X-Spamd-Result: default: False [3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[100.00%];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.29
X-Rspamd-Queue-Id: ECF26767C2
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

On 11:58 Wed 07 Feb     , Andrea della Porta wrote:
> Introducing the field 'el0' to the idreg-override for register
> ID_AA64PFR0_EL1. This field is also aliased to the new kernel
> command line option 'arm64.no32bit_el0' as a more recognizable
> and mnemonic name to disable the execution of 32 bit userspace
> applications (i.e. avoid Aarch32 execution state in EL0) from
> kernel command line.
> 
> Changes in V2:
> - fixed the order of appearance of arm64.no32bit_el0 entry in
>   kernel-parameters.txt documentation.
> 
> Link: https://lore.kernel.org/r/ZVTleETzfFUchs77@apocalypse
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  arch/arm64/kernel/idreg-override.c              | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..fa7cdf2f4f3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -415,6 +415,9 @@
>  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
>  			Format: <io>,<irq>,<nodeID>
>  
> +	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> +			32 bit applications
> +
>  	arm64.nobti	[ARM64] Unconditionally disable Branch Target
>  			Identification support
>  
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index e30fd9e32ef3..642cda19e42d 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -86,6 +86,7 @@ static const struct ftr_set_desc pfr0 __prel64_initconst = {
>  	.override	= &id_aa64pfr0_override,
>  	.fields		= {
>  	        FIELD("sve", ID_AA64PFR0_EL1_SVE_SHIFT, pfr0_sve_filter),
> +		FIELD("el0", ID_AA64PFR0_EL1_EL0_SHIFT, NULL),
>  		{}
>  	},
>  };
> @@ -197,6 +198,7 @@ static const struct {
>  	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
>  	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>  	{ "nokaslr",			"arm64_sw.nokaslr=1" },
> +	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
>  };
>  
>  static int __init parse_hexdigit(const char *p, u64 *v)
> -- 
> 2.41.0
> 

A gentle ping about this patch... any thoughts about it?

Many thanks,
Andrea

