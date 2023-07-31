Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87A7769270
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGaJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGaJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:54:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8F1B3;
        Mon, 31 Jul 2023 02:54:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V9s2H4017246;
        Mon, 31 Jul 2023 04:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690797242;
        bh=M4kurL0krUI/VoC/6+ZREpjmoi2fExunt2SmgJRPaf0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vQNaqFOy5rPUxZClxaQrTfnCM2n1iYn2RQ4PIER0j91Euku2qhsqpUK2JjUvYBnwf
         3D9SIRr04aGJRqbCcTuSJsN5lHO2ZHlXY6dXiOGzXMZbIWYX3/+CyodkcVkMq6crug
         7LWSJwNJPAHAxbLF8pDpY/poI3F43ZioibIZIXk4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V9s2SC010827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 04:54:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 04:54:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 04:54:02 -0500
Received: from [172.24.227.147] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V9ruFF028228;
        Mon, 31 Jul 2023 04:53:56 -0500
Message-ID: <903337d5-2421-be7a-8b0b-9b684944f6a6@ti.com>
Date:   Mon, 31 Jul 2023 15:24:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 15/16] media: dt-bindings: Add TI J721E CSI2RX
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <nm@ti.com>,
        <devarsht@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com>
 <169079588075.2176682.10224087620577481487.robh@kernel.org>
From:   Jai Luthra <j-luthra@ti.com>
In-Reply-To: <169079588075.2176682.10224087620577481487.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 31/07/23 15:01, Rob Herring wrote:
> 
> On Mon, 31 Jul 2023 13:59:33 +0530, Jai Luthra wrote:
>> From: Pratyush Yadav <p.yadav@ti.com>
>>
>> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
>> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
>> parts together.
>>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> v7->v8:
>> - Drop "Device Tree Bindings" from title
>> - Rename "Wrapper" to "Shim" in title as that is the name referred in
>>    the TRM and other places
>> - Update maintainer to myself
>> - Drop items from compatible as only a single element is present
>> - Rename compatible to "ti,j721e-csi2rx-shim" to distinguish from the
>>    SoC-specific CSI2RX bridge compatible
>>
>>   .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 100 +++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: ticsi2rx@4500000: csi-bridge@4504000: False schema does not allow {'compatible': ['ti,j721e-csi2rx', 'cdns,csi2rx'], 'reg': [[72368128, 4096]], 'clocks': [[4294967295, 26, 2], [4294967295, 26, 0], [4294967295, 26, 2], [4294967295, 26, 2], [4294967295, 26, 3], [4294967295, 26, 3]], 'clock-names': ['sys_clk', 'p_clk', 'pixel_if0_clk', 'pixel_if1_clk', 'pixel_if2_clk', 'pixel_if3_clk'], 'phys': [[4294967295]], 'phy-names': ['dphy'], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]], 'bus-type': [[4]], 'clock-lanes': [[0]], 'data-lanes': [[1, 2]]}}}}
> 	from schema $id: http://devicetree.org/schemas/media/ti,j721e-csi2rx-shim.yaml#
> Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']
> Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.example.dtb: /example-0/ticsi2rx@4500000/csi-bridge@4504000: failed to match any schema with compatible: ['ti,j721e-csi2rx', 'cdns,csi2rx']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731-upstream_csi-v8-15-fb7d3661c2c9@ti.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.

Sorry I missed this warning from v7.

This patch depends on 9536cc949235 ("media: dt-bindings: cadence-csi2rx: 
Convert to DT schema") which is part of linux-next.

The base for this series should be linux-next/master 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
instead of 6.5-rc1.

> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145
