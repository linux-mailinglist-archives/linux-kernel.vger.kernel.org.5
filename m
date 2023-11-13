Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE57E9461
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjKMCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjKMCFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:05:04 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D91BF7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:05:00 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77bb668d941so249366385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699841099; x=1700445899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJWo13UKNLMDttCk33gveAPxz0D02eQXsHeSZKSi3hY=;
        b=GSBTIaru0U6NpX0gQT7vbEtN3x2rc2zBLrb2IWxtV+RqXfFnj8wZJNxqWpuM+Ofl0k
         X8tPChuXreu1jnTX/oGq/9fs23DCJdp7I64He5vdahcmmHwDpxjyM0+t4B0mz4+g+dGx
         hHcLLeNyz/DZbRzNmH5iZz+Sgym9HGsTC5ClxeZBNRLoNaS42d0JqKKJadk7L9QWUZFt
         iSoUqYwYRbCKUsCpEFPSlZZRo1D2vL31E1NcteolucpC7sicsMWNUKLzjmFi2tw44fnP
         KsKhaOLaa9fb2T7BPcwZ3Rn+0aLGhUHD8C/zLDh+B+EpEjsMKwnaPjvcws7D51EH/9mR
         PT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699841099; x=1700445899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJWo13UKNLMDttCk33gveAPxz0D02eQXsHeSZKSi3hY=;
        b=d1IXbA6UB2ebcaz0C52cHQHTdSs8GvcMuwgSAGHFlvMbqf0/DghO5fwcwd186RIVTK
         zSvFC5zbysngtYqEsJPafMFLuLYJNXYVgub6VwVWgm59sga4LmI9Aj9J+aE3BTtM98Xf
         bLANugsTsH5wrGa0W2qt/X7Zs8RCu5HoRR/R1/zyy4Spi8ZONict1/jlXHnl+hVlCFYa
         KgoYIT/DPdvrfVs12RiRz8ZjMMZ04rOUmPNZYOSjF2OCCVUmb2rk1R3lOnXR6LEWj0xz
         o0vSTZUtqj/hUENjsj06UW6hNb+3cFi3g33cTZkeqQVDFsPzfrabM0r9dBvj+QSp1kla
         Yz5Q==
X-Gm-Message-State: AOJu0YwDm1opdvyDz6+p3SddovBDvNvX8JlGbPw9ewE3iKTVk0DPc6J8
        6Rv7Fqx371TC5pvpqwnfcDsYwQ==
X-Google-Smtp-Source: AGHT+IEPHxntb1pvsllyCXGWFQ2YICunJIfNoVA7c0uv4cM3EuMU8D3byNxr+RwsNPBD0UMdKzLS/g==
X-Received: by 2002:a05:620a:3192:b0:77a:1cc0:6e41 with SMTP id bi18-20020a05620a319200b0077a1cc06e41mr7361386qkb.33.1699841099543;
        Sun, 12 Nov 2023 18:04:59 -0800 (PST)
Received: from [192.168.142.156] ([50.235.11.61])
        by smtp.gmail.com with ESMTPSA id bl6-20020a05620a1a8600b00774376e6475sm1530427qkb.6.2023.11.12.18.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 18:04:59 -0800 (PST)
Message-ID: <95c20c6c-66cd-4f87-920b-5da766317e19@sifive.com>
Date:   Sun, 12 Nov 2023 21:04:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] riscv: dts: sophgo: add reset phandle to all uart
 nodes
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-5-jszhang@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231113005503.2423-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 2023-11-12 6:55 PM, Jisheng Zhang wrote:
> Although, the resets are deasserted by default. Add them for
> completeness.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index 4032419486be..e04df04a91c0 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/reset/sophgo,cv1800b-reset.h>
>  
>  / {
>  	compatible = "sophgo,cv1800b";
> @@ -65,6 +66,7 @@ uart0: serial@4140000 {
>  			reg = <0x04140000 0x100>;
>  			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc>;
> +			resets = <&rst RST_UART0>;

Since it's not obvious: this breaks devicetree forward compatibility. An
existing kernel will fail the devm_reset_control_get_optional_exclusive() in
8250_dw.c because it has no driver for the reset controller.

This may not be a concern yet, since the devicetree is still "in development".
But it is something to keep in mind for the future. To avoid this sort of
problem, it's best to fully model the clocks/resets/other dependencies as early
as possible, and not rely on the firmware setting anything up.

Regards,
Samuel

>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";
> @@ -75,6 +77,7 @@ uart1: serial@4150000 {
>  			reg = <0x04150000 0x100>;
>  			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc>;
> +			resets = <&rst RST_UART1>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";
> @@ -85,6 +88,7 @@ uart2: serial@4160000 {
>  			reg = <0x04160000 0x100>;
>  			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc>;
> +			resets = <&rst RST_UART2>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";
> @@ -95,6 +99,7 @@ uart3: serial@4170000 {
>  			reg = <0x04170000 0x100>;
>  			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc>;
> +			resets = <&rst RST_UART3>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";
> @@ -105,6 +110,7 @@ uart4: serial@41c0000 {
>  			reg = <0x041c0000 0x100>;
>  			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc>;
> +			resets = <&rst RST_UART4>;
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			status = "disabled";

