Return-Path: <linux-kernel+bounces-61676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00A85153E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D8C1F20F44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B83EA87;
	Mon, 12 Feb 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="2IDabaR/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qu3c62fk"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAC3B289
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744145; cv=none; b=W4HOseCb1W4xquOUFO4viLE36sc6v9Y/uDwMupBEY4bHgapvnBsneDeZeeJXaBrcaSlNpdzJvHlOkEGwHcJu9F305msCirIZZ2tqnGcp9lzZGpBq0wKQJeLbJ6prHyaoBH8sLtrkfjVVBBLaiIBLGT1t7j3dJO1RzCnEdOzkTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744145; c=relaxed/simple;
	bh=r+wkHhx//o+42koojDql1BGXd7+/Km/wxdmeRtnEm0Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OjVb2ov9FcDG7JSWsoy+vC+hR0UNA0MkuBz2CfDZ2Qu1ggDg6m4E2MvbT3b3ffaBCNpyNKQDT3FftojpNFL4+Um7LrqK0qoVmWdGeJX2jxeCAJCrJK9SViKjNNVMwdb0u045ekWwmW2e0pSnpe2nGdk9acRW2aMOitR2qSWxkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=2IDabaR/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qu3c62fk; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 4768A5C0091;
	Mon, 12 Feb 2024 08:22:22 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute7.internal (MEProxy); Mon, 12 Feb 2024 08:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707744142; x=1707830542; bh=tYVEFq3KKz
	S37pkWyX/NsqZeEFJtfC+Kq3xqJ9xTUUw=; b=2IDabaR/c5r7d0u6aFiFX+gumQ
	jMW8jt0nS+HZAdZ8nxsX2VdAaY8xI+1WhfLuLcSK5r53s7Ki/8jsrqiH4bWs9NsV
	CgcZiMYo7rkHxDJsxDmWpNhj7Z9CaqrReRR0A79n1YnW+nI1PbVHpWjoWlUo7vh7
	FQNOamToROwO8i7cFOGr/9csN2cLgcvIvWinycxy8BMTBqwxkUjP8SLBwWUT3u2a
	XilQw2JP/x5FOKCMPsd7cl9k1CmieeZwcaWT0jI1G5XiiGUaehLEXLbrTBhiTBsW
	wSG6WaEjMHLzdVsmoclglJNuE/Nirz67QF5K2NKr7RJIsDMRDI2Dr5h++YlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707744142; x=1707830542; bh=tYVEFq3KKzS37pkWyX/NsqZeEFJt
	fC+Kq3xqJ9xTUUw=; b=Qu3c62fkEzwLe4zVsFeTcyfEPKecebSJOt9Ijws3FKK/
	nlX8GLbVeA/SFcc92j7tfxoC+ZqlEMom/zXQa4OzOiAa3LrTK0MefB6hmrhDtUFo
	5CbnVo7UA2Y6CP5cfPzaFils8r2Jk3BqV4IZREI8ccMKwyK8Nw0tHueUvmGjwRx9
	h6T5jKo3QAhHPabjdecrdOA5e0X0lz/eOU4p+ePrSjXAN+hA1O9952q1RanGiYmU
	FNzWKpSUD8nCbsiTCEsdxsbbvhHo6wjxdJuXWS+VLhZe9id538OqaVxsR+/bk7k3
	ACw2Ydu8dVB5C83yFfKZVfZiBVUz/0ZZvpRnbcA1Fw==
X-ME-Sender: <xms:jhvKZU_Z3l9oXS-8vieFhUr2clmUpfXFw9mpQHArVcLerTt1K4XcNg>
    <xme:jhvKZTn8VEqFD0kHe8dg-SA7lJMHrMPENVXBjlSS98NKhAeGBgm6uxTh0is4uVtx0
    WJ6CMJsPrrgJDzKAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueegtdfh
    heevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhesfhgr
    shhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jhvKZW8b6P0WMstMn4TE8hgAytgqMpybfxscv8mrDCQJl3kDhGvRgg>
    <xmx:jhvKZRlyoJ426oqFfB_wyZjGy_fyZewuoPV9nLFRngBgiOmbzFpYhw>
    <xmx:jhvKZT3LDfEg7ERXsYiIIQ2O7fN_9qsoTUI28-EBuo_KlCFyh4nMAw>
    <xmx:jhvKZU5OPiOkLZOwMGT-L4EMv3Yu6RGdfdchJlPA88gCFUSudcpuCQ>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1F8501700093; Mon, 12 Feb 2024 08:22:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1d370c1-a7d8-4240-a15a-a55616f5b4a6@app.fastmail.com>
In-Reply-To: <20240212022642.1968739-2-samuel.holland@sifive.com>
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
 <20240212022642.1968739-2-samuel.holland@sifive.com>
Date: Mon, 12 Feb 2024 08:21:58 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Samuel Holland" <samuel.holland@sifive.com>,
 "Andrew Jones" <ajones@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Save/restore envcfg CSR during CPU suspend
Content-Type: text/plain

On Sun, Feb 11, 2024, at 9:26 PM, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
>
> Because the [ms]envcfg CSR is part of the base RISC-V privileged ISA
> specification, it cannot be detected from the ISA string. However, most
> existing hardware is too old to implement this CSR. As a result, it must
> be probed at runtime.
>
> Extend the logic for the Zicsr ISA extension to probe for the presence
> of specific CSRs. Since the CSR number is encoded as an immediate value
> within the csrr instruction, a switch case is necessary for any CSR that
> must be probed this way. Use the exception table to handle the illegal
> instruction exception raised when the CSR is not implemented.

We support non-conforming extensions, so we can't assume that if an
implementation does not provide the Ss1p12 extension which defines senvcfg,
the corresponding CSR number will not be used for other purposes.

-s

> Cc: stable@kernel.org
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/include/asm/csr.h     | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/suspend.h |  1 +
>  arch/riscv/kernel/cpufeature.c   | 23 +++++++++++++++++++++++
>  arch/riscv/kernel/suspend.c      |  2 ++
>  4 files changed, 49 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 2468c55933cd..daff95feb817 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -542,6 +542,29 @@
>  			      : "memory");			\
>  })
> 
> +#define ALT_CSR_READ(csr)					\
> +({								\
> +	unsigned long __v;					\
> +	__asm__ __volatile__ (					\
> +		ALTERNATIVE("li %[v], 0", "csrr %[v], %[r]", 0,	\
> +			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
> +		: [v] "=r" (__v)				\
> +		: [r] "i" (csr)					\
> +		: "memory");					\
> +	__v;							\
> +})
> +
> +#define ALT_CSR_WRITE(csr, val)					\
> +({								\
> +	unsigned long __v = (unsigned long)(val);		\
> +	__asm__ __volatile__ (					\
> +		ALTERNATIVE("nop", "csrw %[r], %[v]", 0,	\
> +			    csr << 16 | RISCV_ISA_EXT_ZICSR, 1)	\
> +		: : [r] "i" (csr), [v] "rK" (__v)		\
> +		: "memory");					\
> +	__v;							\
> +})
> +
>  #endif /* __ASSEMBLY__ */
> 
>  #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> index 02f87867389a..491296a335d0 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -14,6 +14,7 @@ struct suspend_context {
>  	struct pt_regs regs;
>  	/* Saved and restored by high-level functions */
>  	unsigned long scratch;
> +	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
>  #ifdef CONFIG_MMU
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c5b13f7dd482..934090270ae5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -954,6 +954,27 @@ void riscv_user_isa_enable(void)
>  }
> 
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> +static bool riscv_cpufeature_probe_csr(u16 csr)
> +{
> +	bool ret = false;
> +
> +	switch (csr) {
> +#define PROBE_CSR_CASE(_csr)			\
> +	case _csr:				\
> +		asm("1:	csrr zero, %[csr]\n"	\
> +		    "	li %[r], 1\n"		\
> +		    "2:\n"			\
> +		    _ASM_EXTABLE(1b, 2b)	\
> +			: [r] "+r" (ret)	\
> +			: [csr] "i" (_csr));	\
> +		break
> +	PROBE_CSR_CASE(CSR_ENVCFG);
> +#undef PROBE_CSR_CASE
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Alternative patch sites consider 48 bits when determining when to patch
>   * the old instruction sequence with the new. These bits are broken into a
> @@ -974,6 +995,8 @@ static bool riscv_cpufeature_patch_check(u16 id, u16 value)
>  		return true;
> 
>  	switch (id) {
> +	case RISCV_ISA_EXT_ZICSR:
> +		return riscv_cpufeature_probe_csr(value);
>  	case RISCV_ISA_EXT_ZICBOZ:
>  		/*
>  		 * Zicboz alternative applications provide the maximum
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 239509367e42..fe544f12a5c5 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -15,6 +15,7 @@
>  void suspend_save_csrs(struct suspend_context *context)
>  {
>  	context->scratch = csr_read(CSR_SCRATCH);
> +	context->envcfg = ALT_CSR_READ(CSR_ENVCFG);
>  	context->tvec = csr_read(CSR_TVEC);
>  	context->ie = csr_read(CSR_IE);
> 
> @@ -36,6 +37,7 @@ void suspend_save_csrs(struct suspend_context *context)
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
>  	csr_write(CSR_SCRATCH, context->scratch);
> +	ALT_CSR_WRITE(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
>  	csr_write(CSR_IE, context->ie);
> 
> -- 
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

