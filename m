Return-Path: <linux-kernel+bounces-134703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5B89B5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C747B2813E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165715CB;
	Mon,  8 Apr 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HBLhlmvO"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5641366
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541537; cv=none; b=P7np+D7666Qs/B0RHgEcDv2seMgTOj2MaOQSdIaEazp2PZUT48IZ5oJVGBg9vF0pIfsTwiaSuYXWWHWvVJ2KS5PFjiDRGoXRZX9fP64LujXevYkQ9jkGbDRbcGs22Ng1CNhRT8D6VOneQZEdtjAKn/HRJSNNHe5iPorrZjUWTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541537; c=relaxed/simple;
	bh=NogsxUnEAdj90yc3/f77xUk7fjnNwWsfaH/oJdNsVsQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2W0A1p5iR3j3Gwqry2hTrmJNL92oSyXDpmFJbuxGk8TN2WDQaLjkyKugHjt+B3biwNLhE9ueCnSNawvRkWmpV7nL0OeHK1VokvQcF0o6aJXI//OP5fUh2oIATLDUJtUUtlDmEO+7zoH3wcMSb9Gu495sjdL92YPNO2UmadkftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HBLhlmvO; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712541515; bh=CBUFjmQH02WIVVvbnA0sbD5Cd/bzgRPVp2hhqoRa7fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBLhlmvO6PZnfmMOivNFPuND7pVhM4ZgrVSVLfmwXQ6z8pAsOeJcmU+uf85K2x3k7
	 DV0w6aD6HfnBKYVK/4AqHG9urHKsUPJPgw4iDp6w1ONoioP3vkpbxvFrPcgLmJCznM
	 JwOCP9X88CJgUHVVpzNzC++YeJ0qt1GKxFwbp8Pk=
Received: from Yangyus-MBP.lan ([2406:840:f99a:b03c:2d0c:df10:d60b:b517])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id E94B6A38; Mon, 08 Apr 2024 09:58:20 +0800
X-QQ-mid: xmsmtpt1712541500t8xhrqula
Message-ID: <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
X-QQ-XMAILINFO: N89bjyf9tBCObQqorC6TmpG61JDRuwj2CWcRR7S5bVfN11Qe4R28wWfHwuCwqB
	 UKfETuVhFAulq5d1gWbEgv/UqCrVQD8I71NoR/8HzpHppqoEuUXdZ7i7ftgSAG0WtV+i0OlTFLf9
	 elMnuaFi/jeBIIvWair+MENdAtmXfpCzAjC9EkyewF3zh9B9HfgIk7eV3B5UUPjLRqYaiqbTR0DB
	 qwwfgkgfFHEMJA3f0M+GYsjq1GOoV0+66vfS01X2IFlDHILV0uF54i06aE0h7bZx8xw0iKkWvcus
	 1rrZAoXL7lcHTXpSShHg6OZbcnVeRrO6EMeiwUJI7IIEcKC6fpVYQcM8VmOS76kpMsKMDCNrPfQp
	 lJlHw/OHfhSw8EC+dsDavmCHlnRaJ8BWB1/dOCLx2+Ye/MPwvAzy+qTJI6UpwTKKRfqIh/tYfkLQ
	 BKwb+Lku1LX4MlP7pHbvaRg0wM5EY/HmilJjYwhbphJMuNAYQzDZUMSriZSWccjR/uIlsOC6PNM1
	 3CddQGegYlMD1sf1Y/s/2hR4JyD6ypESJ+X+l8dshg35Igw3+po2Jbnc1gwEJCKqGVw12Qc4Bor0
	 hqELX097YW30mJun5j0U6Hxw/iuIkHtyLxsFJf6b/6UJYc5hprm7A5w3IifwM3GKtwFlAMxSo6Jb
	 gmV7F7MlZoE2wlChRhHZ+JjGWWCirZEL24MbNRY/LDlnhchKY5/JQ6OwBBE0HoyCdYxaZdd129ju
	 Bn5fVHNYkwLBkIEqeq42pGM0BW7friLnl4r14KBLmKZnYD+yp5FupfjvulVaUDRXOMVJNK7eE4Dh
	 ZUBFoHJEJf8hmVCTI9wv2olGqXgajDpzZbnA6gs/eDgRGR1nBAICsdhgdYVevNCbzI95nyHEkTWb
	 tL7spMtzPLrGIwsT3ZcyhGefg/1C/0d3s3sRKgCXv8Ql6tc4OszG/UldUo8KOWmGuDEjQlgw+Xwc
	 epZ80ENHYnAGKFFDEOwnuIpKt6GVqXt9Ro1UIMtme7R1y1eWCEIT6MXdJOd8DA
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: christoph.muellner@vrull.eu
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	alistair.francis@wdc.com,
	aou@eecs.berkeley.edu,
	bjorn@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	cooper.qu@linux.alibaba.com,
	dbarboza@ventanamicro.com,
	dqfext@gmail.com,
	eric.huang@linux.alibaba.com,
	heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	philipp.tomsich@vrull.eu,
	samuel.holland@sifive.com,
	zhiwei_liu@linux.alibaba.com,
	guoren@kernel.org
Subject: Re: [PATCH v3 2/2] riscv: T-Head: Test availability bit before enabling MAE errata
Date: Mon,  8 Apr 2024 09:58:17 +0800
X-OQ-MSGID: <20240408015817.19081-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/4/8 05:32, Christoph Müllner wrote:
> T-Head's memory attribute extension (XTheadMae) (non-compatible
> equivalent of RVI's Svpbmt) is currently assumed for all T-Head harts.
> However, QEMU recently decided to drop acceptance of guests that write
> reserved bits in PTEs.
> As XTheadMae uses reserved bits in PTEs and Linux applies the MAE errata
> for all T-Head harts, this broke the Linux startup on QEMU emulations
> of the C906 emulation.
> 
> This patch attempts to address this issue by testing the MAE-enable bit
> in the th.sxstatus CSR. This CSR is available in HW and can be
> emulated in QEMU.
> 
> This patch also makes the XTheadMae probing mechanism reliable, because
> a test for the right combination of mvendorid, marchid, and mimpid
> is not sufficient to enable MAE.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   arch/riscv/errata/thead/errata.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 6e7ee1f16bee..bf6a0a6318ee 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -19,6 +19,9 @@
>   #include <asm/patch.h>f
>   #include <asm/vendorid_list.h>
>   
> +#define CSR_TH_SXSTATUS		0x5c0
> +#define SXSTATUS_MAEE		_AC(0x200000, UL)
> +
>   static bool errata_probe_mae(unsigned int stage,
>   			     unsigned long arch_id, unsigned long impid)
>   {
> @@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
>   	if (arch_id != 0 || impid != 0)
>   		return false;
>   

I would raise a little concern about keeping this "if" statement for
arch_id and imp_id after we have probed it in this CSR way. I would like to
remove it and move the CSR probe earlier than RISCV_ALTERNATIVES.

I added CC to guoren for more opinions.

Even T-Head C908 comes in 2023, which supports RVV 1.0 and also keeps MAEE.
But it also supports Svpbmt, and we can perform the switch by clearing the
MAEE bit in CSR_TH_MXSTATUS in M-Mode Software.

Moreover, T-Head MAEE may not be removed in the future of T-Head CPUs. We
can see something from the T-Head C908 User Manual that adds a Security bit
to MAEE. So, it might used in their own TEE implementation and will not be
removed.

However, C908 has arch_id and impid, which are not equal to zero. You can
see it from the C908 boot log [2] from my patch to support K230 [3]. So, if
we have probed MAEE using CSR, you confirmed that this bit will also be set
in the C906 core. We can only probe it this way and no longer use arch_id
and imp_id. And if the arch_id and imp_id probes get removed, we should
also move the csr probe earlier than riscv alternatives.

[1] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf
[2] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176
[3] https://lore.kernel.org/linux-riscv/tencent_D1180541B4B31C0371DB634A42681A5BF809@qq.com/

Thanks,
Yangyu Chen

> -	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
> -	    stage == RISCV_ALTERNATIVES_MODULE)
> -		return true;
> +	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
> +	    stage != RISCV_ALTERNATIVES_MODULE)
> +		return false;
>   
> -	return false;
> +	if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
> +		return false;
> +
> +	return true;
>   }
>   
>   /*


