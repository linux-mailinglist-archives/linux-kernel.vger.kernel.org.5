Return-Path: <linux-kernel+bounces-105334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5B87DC62
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41A61F2133A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C8C142;
	Sun, 17 Mar 2024 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gf1YIOAN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9E5258
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710655675; cv=none; b=Z5jYppgMeqg9z6PBu72y19DX7MSZ54dBPwcd5zdJ9RW20tJyN/OQj08E6ntm48DSEyWt6yUp7G9gJ4nH/iwIE8eHSUuKgkDCrSKTMYDipZ22IaWJPIEzDPOLP7cSMa5qaR7CM/khGmkFULtkJajt8YlmEPE9hl6dZQwWZXllWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710655675; c=relaxed/simple;
	bh=ZaDPm++GyMRwUZIEI7h9rCqXoHqayakxowhyAmKwVuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUzcGTVWbO2cn+/fgLhnr4+ZZGcp1fyIXK2to/V5hK1gZZvDjxK634GeoXZ02aVmUWkjzlK+D2pQ7h5Q0FlpB75XW7brgcYQ/2qy7H426/8vtfbv7UgkKl+q1RmwZO1OcAlxtiH0XjIrG/ktku03RVKRaxVsvJPehfvwahFTkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gf1YIOAN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+I6WdkjZLSbw7UdlnnziRO5yrCCd5ug4GJrBrvk8xw8=; b=Gf1YIOAN4Qv8aG9/9Rv0gsm7Jf
	Ock9+ZPRKvkgZZTCFNPrygH+YqgbJR8yUwtbhM5RH3ftPHS0FtFrSiXEwORBESTG3gM69x+yUiz+c
	bgafRiGWcx7sv8mO4Y2R1QJlq44xfGaxQ4gbncV21j0CnWyssrw+KYQK3Y1V4UCxBsgy5Ii61EvFZ
	jEiCWAOM4JQAhV94pavHgzCEc9eCir9Kn4ly7nWm1rG/5ki64HxfMD1X373IpenP9db5UrmOdbHfg
	SrP11y+3tFdLYJYi3+KFr4OK9BlZJK3c0+RBHUbHij20MynxNNVSuib5faI7ffYPwJ8bhXkq5FChT
	GkWvjmbw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rljgW-00000004Xvp-30hS;
	Sun, 17 Mar 2024 06:07:52 +0000
Message-ID: <b9a6044e-c1d1-4d8e-88ab-43dbb9e2fa31@infradead.org>
Date: Sat, 16 Mar 2024 23:07:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: typo in comment for get_f64_reg
Content-Language: en-US
To: Xingyou Chen <rockrush@rockwork.org>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ajones@ventanamicro.com,
 cleger@rivosinc.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
 paul.walmsley@sifive.com
References: <20240317055556.9449-1-rockrush@rockwork.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240317055556.9449-1-rockrush@rockwork.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/24 22:55, Xingyou Chen wrote:
> Signed-off-by: Xingyou Chen <rockrush@rockwork.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/riscv/kernel/fpu.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
> index 2c543f130f93..327cf527dd7e 100644
> --- a/arch/riscv/kernel/fpu.S
> +++ b/arch/riscv/kernel/fpu.S
> @@ -211,7 +211,7 @@ SYM_FUNC_START(put_f64_reg)
>  SYM_FUNC_END(put_f64_reg)
>  
>  /*
> - * put_f64_reg - Get a 64 bits FP register value and returned it or store it to
> + * get_f64_reg - Get a 64 bits FP register value and returned it or store it to
>   *	 	 a pointer.
>   * a0 = FP register index to be retrieved
>   * a1 = If xlen == 32, pointer which should be loaded with the FP register value

-- 
#Randy

