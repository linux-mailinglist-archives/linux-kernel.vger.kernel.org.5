Return-Path: <linux-kernel+bounces-157569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE98B130A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68856283D91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602B1CD3F;
	Wed, 24 Apr 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yprv+1+e"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D522EE8;
	Wed, 24 Apr 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985099; cv=none; b=LtRL7/VMjNhN/sw+hTgiZ1Kkqyk8v5pupSa1ZmOqHq1kXeWgYdIiBpCqWDutSmfuKYfZfvtfuWPqp7sTe2WOXxmBwCfASfECRp1EFGwEJLJLenXgVYqkV856wTbRvj7lGeSGoCa/kb3APM/gjKLS4v5+7041CIdDuOQ8PwQOISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985099; c=relaxed/simple;
	bh=HCt7b5jZVpt+S9X/iE7IN+XtRTt3TR+LfOAu0uJIZiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVfKRYAJQRHl+fLk8WVwbXmSf84HYBSs+FJLb0epcOUhG6O4v2bSaW+utWFV7mujjMFGDKhdvAcsTz2Xj/YM56lsMmI6koVXhNrsUk+elRAXhc5/0WX0tlo5jrjiepZw6qm+JQ2fKrjbKwdoFldd1jDbmgZIM5K8qZWInnFnVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yprv+1+e; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so118310a12.2;
        Wed, 24 Apr 2024 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985095; x=1714589895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwvbZeXK2LmNo0b/liHJV6gTDtg1IGPQpDm4DyK4ylU=;
        b=Yprv+1+e8+ujPy0aDRTmZO9DAzufwGqegg/fuXgCSsSf5zAADwVFulJ5NMtwgitUyL
         9B+4JHOee3LgYQmx8mVRDpScREdeRsAfBu7219tz1c5clLpKBk7uZczUcdC/bBlfqy6e
         82uIeDXCyw3q5dYF/fBq+Cn9X0YYrTrMKfXFdJskJ5oEh8PUuSPSw6jPhjVRxIdUOSkP
         VNqQjQIZPoVvzo2X420t+q9FI1MMvMXoncSB+DNPKsQgfqHHcgaLK0cUwjbBOT5o/A7p
         Cw21VSHEtWBw8/8/2LYVlxC8NnLhzWBTzzCrqJIMNl4MTrqLiNf4gXdv9+qfuz0sy+CV
         8Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985095; x=1714589895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwvbZeXK2LmNo0b/liHJV6gTDtg1IGPQpDm4DyK4ylU=;
        b=A4G61tfoSsxsxKvbYYN5cZJWNg/rNcJllq7lleNeQpZtmcOh3KEKR3w7VMlWFgI/Px
         sFvlkdvJPwfu+MRb64BpErXKLCMNkUSzYB0fNP9SONOc/ED40ArxW9CkK/wZbGL2zUVI
         WyGD3GhP6E4TvgU7gO+l4R5GGKm+qrApLjYH6FPhdkxvdl9EChaDuC50pAwOYp+f0xpD
         GMe8viogl9o/ei5GWU2cGttWE37pue+Qvakui5bJManxcOTBjrK/fPBm261NfwTs4wTQ
         CpGIK85mBSCBIfWwzoFgeH8wPhBhIzCv9TmmW7jjr+/XRf2rilzorhvIrL8tAug3akFD
         HBHg==
X-Forwarded-Encrypted: i=1; AJvYcCXbCXhXlr5EfVVvjVxfO7t+WXT+5nvnD+xRm/0Grr7phvWXXhCNWYm4o25vMluhIYURjTTegdBvizEyy7SYJVQdjUzb44UD27g7ho+hIYszbxd6wMNlF56mmPL8dtjSj+MNZhAHOmvEOA==
X-Gm-Message-State: AOJu0YxtV/azBbPUfXhqwjrh33Uw5/KecZTwxvsa84UbPMetyD8Rs7+G
	rPSBBgaoeaamLXiWqOr2MF24pbJYo+R6qw9xfG2Ibrp59AnXYV0bDRZ8ERbs
X-Google-Smtp-Source: AGHT+IFFeaRzMd/7Smdm00f104rcu/P7ErgzU3rDoChCfzP3EQsfV2DOJK5NtUDrizGxdpXgYZNMBQ==
X-Received: by 2002:a50:c90a:0:b0:572:3cc4:2dcf with SMTP id o10-20020a50c90a000000b005723cc42dcfmr95098edh.14.1713985094787;
        Wed, 24 Apr 2024 11:58:14 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b005705bfeeb27sm8103284edb.66.2024.04.24.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:58:14 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH] dt-bindings: mfd: allwinner,sun6i-a31-prcm: Use hyphens in node
 names
Date: Wed, 24 Apr 2024 20:58:13 +0200
Message-ID: <2320577.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>
References: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 24. april 2024 ob 06:55:21 GMT +2 je Krzysztof Kozlowski napisal(a):
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  This should have no impact on
> known users: Linux MFD driver does not care about children node names.
> DTS was already adjusted in commit 0f47ef3ff1bd ("arm: dts: allwinner: drop
> underscore in node names"), so without this change, we observe
> dtbs_check warnings:
> 
>   sun6i-a31s-colorfly-e708-q1.dtb: prcm@1f01400: 'ahb0-clk', 'apb0-clk', 'apb0-gates-clk', 'apb0-rst', 'ar100-clk', 'ir-clk' do not match any of the regexes: '^.*_(clk|rst)$', 'pinctrl-[0-9]+'
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
> index 8789e3639ff7..ca0e9f1f2354 100644
> --- a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
> +++ b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
> @@ -20,7 +20,7 @@ properties:
>      maxItems: 1
>  
>  patternProperties:
> -  "^.*_(clk|rst)$":
> +  "^.*-(clk|rst)$":
>      type: object
>      unevaluatedProperties: false
>  
> @@ -171,7 +171,7 @@ examples:
>          compatible = "allwinner,sun6i-a31-prcm";
>          reg = <0x01f01400 0x200>;
>  
> -        ar100: ar100_clk {
> +        ar100: ar100-clk {
>              compatible = "allwinner,sun6i-a31-ar100-clk";
>              #clock-cells = <0>;
>              clocks = <&rtc 0>, <&osc24M>,
> @@ -180,7 +180,7 @@ examples:
>              clock-output-names = "ar100";
>          };
>  
> -        ahb0: ahb0_clk {
> +        ahb0: ahb0-clk {
>              compatible = "fixed-factor-clock";
>              #clock-cells = <0>;
>              clock-div = <1>;
> @@ -189,14 +189,14 @@ examples:
>              clock-output-names = "ahb0";
>          };
>  
> -        apb0: apb0_clk {
> +        apb0: apb0-clk {
>              compatible = "allwinner,sun6i-a31-apb0-clk";
>              #clock-cells = <0>;
>              clocks = <&ahb0>;
>              clock-output-names = "apb0";
>          };
>  
> -        apb0_gates: apb0_gates_clk {
> +        apb0_gates: apb0-gates-clk {
>              compatible = "allwinner,sun6i-a31-apb0-gates-clk";
>              #clock-cells = <1>;
>              clocks = <&apb0>;
> @@ -206,14 +206,14 @@ examples:
>                                   "apb0_i2c";
>          };
>  
> -        ir_clk: ir_clk {
> +        ir_clk: ir-clk {
>              #clock-cells = <0>;
>              compatible = "allwinner,sun4i-a10-mod0-clk";
>              clocks = <&rtc 0>, <&osc24M>;
>              clock-output-names = "ir";
>          };
>  
> -        apb0_rst: apb0_rst {
> +        apb0_rst: apb0-rst {
>              compatible = "allwinner,sun6i-a31-clock-reset";
>              #reset-cells = <1>;
>          };
> 





