Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387B7ACF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjIYF3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjIYF3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:29:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E465DA;
        Sun, 24 Sep 2023 22:29:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P5TIVk126664;
        Mon, 25 Sep 2023 00:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695619758;
        bh=lcO/fVluxHl1soRdHSkiD6yfVkOlWW5O2VYj33gaqHM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jf7dO/nbH7JhIUAyysU+l8W4L3t/pzCRvZ898JiYSEsXHQrXBKGs2OARoyD0ub/m4
         DIBXqWQhvuru+HQpZKcGbGqWdlrbLGZ0bQztcZosRdVBkjU+x0vD5r5HdlsygsG954
         gzMapH6EbAfUXro7N7ggbOl2SQ4QYNzYEs17Fylg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P5TIwK025984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 00:29:18 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 00:29:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 00:29:17 -0500
Received: from [172.24.20.156] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P5TE84096023;
        Mon, 25 Sep 2023 00:29:15 -0500
Message-ID: <2cc9060f-b44d-a870-6b98-20f17b2feac1@ti.com>
Date:   Mon, 25 Sep 2023 10:59:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/7] arm64: dts: ti: k3-j784s4: Add ESM instances
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230911040942.31031-1-j-keerthy@ti.com>
 <20230911040942.31031-3-j-keerthy@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230911040942.31031-3-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/2023 9:39 AM, Keerthy wrote:
> Patch adds the ESM instances for j784s4. It has 3 instances.
> One in the main domain and two in the mcu-wakeup domian.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  7 +++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index efed2d683f63..02d549a2ca06 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1568,4 +1568,11 @@
>   		firmware-name = "j784s4-c71_3-fw";
>   		status = "disabled";
>   	};
> +
> +	main_esm: esm@700000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x700000 0x00 0x1000>;
> +		ti,esm-pins = <688>, <689>, <690>, <691>, <692>, <693>, <694>,
> +			      <695>;
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 4ab4018d3695..f1dfa4144168 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -700,4 +700,16 @@
>   			status = "disabled";
>   		};
>   	};
> +
> +	mcu_esm: esm@40800000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x40800000 0x00 0x1000>;
> +		ti,esm-pins = <95>;
> +	};
> +
> +	wkup_esm: esm@42080000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x42080000 0x00 0x1000>;
> +		ti,esm-pins = <63>;
> +	};


Please consider adding bootph node for esm,

I understand these nodes will be used in R5/SPL

Thanks

>   };
