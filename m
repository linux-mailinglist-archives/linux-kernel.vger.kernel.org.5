Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F579EA48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjIMN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIMN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:59:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DE19BF;
        Wed, 13 Sep 2023 06:59:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DDxRTY073550;
        Wed, 13 Sep 2023 08:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694613567;
        bh=+cicwCaXuC7mIR3p0+RFuO35Kt1qPJV+S2mwgjtFGCY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=inPIakf6vYw/ioSQ/ELGXLBN/pbefNNh0EHMNTOYyUOGK6luCezQcI7kebZfIJNjy
         kMdaQSQnzbMp7D+Ts+NbAAPqNJ3j8KGhrNQXWs4LIalL5dfxqPiDX15qxPTTwacSPq
         RzeKnBEn/gGkXF7VQ2pKsgWMgs9jrl/U4p1hGwkM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DDxRNn041432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 08:59:27 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 08:59:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 08:59:26 -0500
Received: from [10.249.48.175] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DDxQgs077390;
        Wed, 13 Sep 2023 08:59:26 -0500
Message-ID: <b8305681-9fa5-e506-b8c7-03338b5ed4d8@ti.com>
Date:   Wed, 13 Sep 2023 08:59:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-2-hnagalla@ti.com>
 <052be57d-4081-43ca-6c9f-9afedb030a58@linaro.org>
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <052be57d-4081-43ca-6c9f-9afedb030a58@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 06:32, Krzysztof Kozlowski wrote:
>>   - Removed unrelated items from examples
>>
>> Changes since v4:
>>   - Rebased to the latest kernel-next tree
>>   - Added optional sram memory region for m4f device node
>>
>> Changes since v5:
>>   - None
> Hm, why none? There were errors in the binding to which you did not
> respond. Did you just ignore them?
> 
I do not see any errors in my builds. Am i missing something? Please 
excuse my lack of knowledge here. Thought the bot errors were outside of 
the patch submitted 
(Documentation/devicetree/bindings/dma/stericsson,dma40.yaml). 
Appreciate your kind inputs..

$ make -j`nproc` ARCH=arm64 V=1 CROSS_COMPILE=aarch64-none-linux-gnu- 
DT_CHEKCER_FLAGS=-m dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
make --no-print-directory -C /home/a0868345/temp/linux-next \
-f /home/a0868345/temp/linux-next/Makefile dt_binding_check
make -f ./scripts/Makefile.build obj=scripts/basic
make -f ./scripts/Makefile.build obj=scripts/dtc
make -f ./scripts/Makefile.build obj=Documentation/devicetree/bindings
# LINT    Documentation/devicetree/bindings
   (find ./Documentation/devicetree/bindings \( -name '*.yaml' ! -name 
'processed-schema*' \) | grep -F -e 
"Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml" | 
xargs -n200 -P$(nproc) /home/a0868345/.local/bin/yamllint -f parsable -c 
./Documentation/devicetree/bindings/.yamllint >&2) || true
# DTEX 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts
   dt-extract-example 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml > 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts
# CHKDT   Documentation/devicetree/bindings/processed-schema.json
   (find ./Documentation/devicetree/bindings \( -name '*.yaml' ! -name 
'processed-schema*' \) | grep -F -e 
"Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml" | 
xargs -n200 -P$(nproc) dt-doc-validate -u 
./Documentation/devicetree/bindings) || true
# SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   f=$(mktemp) ; find ./Documentation/devicetree/bindings \( -name 
'*.yaml' ! -name 'processed-schema*' \) > $f ; dt-mk-schema -j  @$f > 
Documentation/devicetree/bindings/processed-schema.json ; rm -f $f
# DTC_CHK 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb
   gcc -E 
-Wp,-MMD,Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.pre.tmp 
-nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x 
assembler-with-cpp -o 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.dts.tmp 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts 
; ./scripts/dtc/dtc -o 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb 
-b 0 -iDocumentation/devicetree/bindings/remoteproc/ 
-i./scripts/dtc/include-prefixes -Wno-avoid_unnecessary_addr_size 
-Wno-graph_child_address -Wno-interrupt_provider 
-Wno-unique_unit_address -Wunique_unit_address_if_enabled -d 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.dtc.tmp 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.dts.tmp 
; cat 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.pre.tmp 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d.dtc.tmp 
 > 
Documentation/devicetree/bindings/remoteproc/.ti_k3-m4f-rproc.example.dtb.d 
; dt-validate  -u ./Documentation/devicetree/bindings -p 
./Documentation/devicetree/bindings/processed-schema.json 
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dtb 
|| true


 >> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
 >> +%YAML 1.2
 >> +---
 >> +$id:http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
 >> +$schema:http://devicetree.org/meta-schemas/core.yaml#
 >> +
 >> +title: TI K3 M4F processor subsystems
 >> +
 >> +maintainers:
 >> +  - Hari Nagalla<hnagalla@ti.com>
 >> +  - Mathieu Poirier<mathieu.poirier@linaro.org>
 > Are you sure Mathieu has this device and is a maintainer of this device?
 >
Earlier, Mathieu suggested he can be the maintainer. Beagle play is 
based on AM625 device.

I will look into the other comments for the 'ti,k3-m4f-rproc.yaml' 
binding doc.

Thanks
