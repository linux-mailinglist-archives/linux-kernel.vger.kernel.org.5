Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354D7CC4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjJQNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjJQNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:39:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05496F0;
        Tue, 17 Oct 2023 06:39:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39HDdO2g044792;
        Tue, 17 Oct 2023 08:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697549964;
        bh=zcTmoQI5XOd7YSgPhdwywqy2VG0q705HIlmnAOctNUE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NFmbL+gUvmprNcJ9LsQkgLvg6g5gCaC/+H9Gq09iZm1OR8MS14MJL/Z890V12cU2O
         ks8bhgqlg3wcKvMPK0wF2tveadJyZHUzNMi9rHveR2VLfoEZ4RycSjSZqfZsx9L3LT
         +dtHM2Rtv+doDY2NKv2zM0krk4dC5giepaMUALLQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39HDdOEn071153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Oct 2023 08:39:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 08:39:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 08:39:24 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39HDdFKM105476;
        Tue, 17 Oct 2023 08:39:16 -0500
Message-ID: <4c557cbd-33e9-a0df-3431-04ade12b6f07@ti.com>
Date:   Tue, 17 Oct 2023 19:09:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c
 codec IP support
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     <linux-media@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        <kernel@collabora.com>, Robert Beckett <bob.beckett@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Darren Etheridge <detheridge@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Bhatia, Aradhya" <a-bhatia1@ti.com>,
        "Luthra, Jai" <j-luthra@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        "Brnich, Brandon" <b-brnich@ti.com>,
        "Pothukuchi, Vijay" <vijayp@ti.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Krzysztof, Rob,

On 12/10/23 16:31, Sebastian Fricke wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> Add bindings for the chips&media wave5 codec driver
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  .../devicetree/bindings/media/cnm,wave5.yaml       | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
> new file mode 100644
> index 000000000000..b31d34aec05b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cnm,wave5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chips&Media Wave 5 Series multi-standard codec IP
> +
> +maintainers:
> +  - Nas Chung <nas.chung@chipsnmedia.com>
> +  - Jackson Lee <jackson.lee@chipsnmedia.com>
> +
> +description:
> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cnm,cm521c-vpu
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: VCODEC clock
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The VPU uses the SRAM to store some of the reference data instead of
> +      storing it on DMA memory. It is mainly used for the purpose of reducing
> +      bandwidth.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +

Is it possible to keep interrupts property as optional given HW can still work
without it if SW does polling of ISR using registers?

The reason to ask is in TI AM62A SoC (which also uses this codec) there is an
SoC errata of missing interrupt line to A53 and we are using SW based polling
locally to run the driver.

We were planning to upstream that SW based polling support patch in CnM driver
once this base initial driver patch series gets merged, but just wanted to
check if upfront it is possible to have interrupts property as optional so
that we don't have to change the binding doc again to make it optional later on.

Also note that the polling patch won't be specific to AM62A, other SoC's too
which use this wave5 hardware if they want can enable polling by choice (by
removing interrupt property)

Could you please share your opinion on this ?

Regards
Devarsh

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vpu: video-codec@12345678 {
> +        compatible = "cnm,cm521c-vpu";
> +        reg = <0x12345678 0x1000>;
> +        clocks = <&clks 42>;
> +        interrupts = <42>;
> +        sram = <&sram>;
> +    };
> 
