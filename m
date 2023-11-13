Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86777E9446
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjKMBvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMBva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:51:30 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8745CF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:51:26 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788db95652so270035785a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699840282; x=1700445082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R378FExkHzP2VzkDzW+qUJ+cmJ8zn3bLFBB62/9VsOI=;
        b=NCoZiwMblU9oYsTOUGuMZ/S9N+idK4BRoc3JZLZLNikCCZzcYnN9+kBNyK4iUNb8HS
         FqiRQQKanI8skdA6HjBDekWsymwmpD92mduLu5BBVQmt0n7ZGxwf25iCiLvjEjAVD/6x
         Hn4vWJKx+BIWG8ESFsbSvrwagLoSf/oPNyYPUgaBA89STBtGm4K0RJeLd/Nx2LA6L8jd
         wGpTyVInC4Aq2DEN8Qkui/0mgAgDLtXIrGD55cLt9tm29yd8h41UTqtTHXF9biDhvhMd
         5QRLePHnDdnJZJEGa0NMJPsJ3ZS/S18UupEYhwL8Vdq4phXn7N3c18nClopcjFL6y0sa
         PH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699840282; x=1700445082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R378FExkHzP2VzkDzW+qUJ+cmJ8zn3bLFBB62/9VsOI=;
        b=p1DWYsV9MCYzkntGL+aZ5O71GWcDoPcdw/1k2tUbG/pWLazJ9n1IW3YMYMVnU30R3q
         5pnVbtYltHzFvEjiB/+vrUOoNdWh0G6/E3NYQCU5KweV4a+REmbPrssWAHsBoHVyFqQY
         E8kEVxyddNQm9rQDnmY16/sMrLITlhD3yxjMt/1F7hXEZp+6CMReW9linzJOR+iBLepb
         4CDOnOFhQgJod3Qbodiu1N5gX78LXpmEFvucLKz251qE8PC7KJkwrspAniJq8Fvf9hXE
         GF5Ojq0a2pQp9nLTMEag65WnHzDtXRKPdPqW69Do9LqHC70+9Lhg/BAvjcT3UT49WrhE
         dceA==
X-Gm-Message-State: AOJu0YzChzZ/4vaZ+WQCZNSnuJ56CRk8zr+tiIotrXQXnR9tXlGNAfdM
        6Zk02640YGGocCNMFZHIsF5msQ==
X-Google-Smtp-Source: AGHT+IEpsIM39+Xr+deRLACCKfM/ZtDIBoL1z9PFUA6Uub4QcFPMTkbCpis5giJAUWzMah7AijAvFg==
X-Received: by 2002:a05:620a:d93:b0:774:131c:854d with SMTP id q19-20020a05620a0d9300b00774131c854dmr6521604qkl.72.1699840282224;
        Sun, 12 Nov 2023 17:51:22 -0800 (PST)
Received: from [192.168.142.156] ([50.235.11.61])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a131100b007659935ce64sm1507945qkj.71.2023.11.12.17.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 17:51:21 -0800 (PST)
Message-ID: <58a99001-8260-4970-9fc7-25fe81e557a5@sifive.com>
Date:   Sun, 12 Nov 2023 20:51:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <20231113005702.2467-2-jszhang@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231113005702.2467-2-jszhang@kernel.org>
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

On 2023-11-12 6:57 PM, Jisheng Zhang wrote:
> Add the reset device tree node to cv1800b SoC reusing the
          ^^^^^
          I assume you mean pinctrl here?

> pinctrl-single driver.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> new file mode 100644
> index 000000000000..ed78b6fb3142
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h

A couple of questions: Should this go in include/dt-bindings? And is it worth
including macros for the actual function mappings, like in the vendor source[1]?

[1]:
https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/pinctrl/cvitek/cv180x_pinlist_swconfig.h

> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for pinctrl bindings for Sophgo CV* SoC.
> + *
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +#ifndef _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> +#define _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> +
> +#define MUX_M0		0
> +#define MUX_M1		1
> +#define MUX_M2		2
> +#define MUX_M3		3
> +#define MUX_M4		4
> +#define MUX_M5		5
> +#define MUX_M6		6
> +#define MUX_M7		7
> +
> +#endif
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index e04df04a91c0..7a44d8e8672b 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -6,6 +6,8 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/reset/sophgo,cv1800b-reset.h>
>  
> +#include "cv-pinctrl.h"
> +
>  / {
>  	compatible = "sophgo,cv1800b";
>  	#address-cells = <1>;
> @@ -55,6 +57,14 @@ soc {
>  		dma-noncoherent;
>  		ranges;
>  
> +		pinctrl0: pinctrl@3001000 {
> +			compatible = "pinctrl-single";
> +			reg = <0x3001000 0x130>;
> +			#pinctrl-cells = <1>;
> +			pinctrl-single,register-width = <32>;
> +			pinctrl-single,function-mask = <0x00000007>;
> +		};

From the vendor driver[2], it looks like this peripheral block only handles
pinmuxing, so indeed this looks like a good use of pinctrl-single.

[2]:
https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/drivers/pinctrl/cvitek/pinctrl-cv180x.h

> +
>  		rst: reset-controller@3003000 {
>  			compatible = "sophgo,cv1800b-reset";
>  			reg = <0x03003000 0x1000>;

