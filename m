Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CA7C6A41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJLKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjJLKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:00:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10688D40;
        Thu, 12 Oct 2023 02:59:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C9whSI055983;
        Thu, 12 Oct 2023 04:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697104723;
        bh=+pkqfBVOhXgvLDsWbv5ktMbvR4NSyNBC9Ey1Mkig3UY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=N3Z0kYcIZvI3cCLP7r54FYgi/mXNAN5wbeaPJHLeqMRCS+28MD1PUTzJ6SAQhAomo
         tMUfcXEekvbR0bAVRwyuhX1zEkhRdWY9Z1l29//QdVktFGsN2g8UwhVhM7ryQYXhrZ
         MEQ0VwOCd/+8coWgcPwOromhVA4YVQ7MuEj5qdX4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C9whGO010652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 04:58:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 04:58:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 04:58:42 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C9wZ47064962;
        Thu, 12 Oct 2023 04:58:36 -0500
Message-ID: <f0c1e8fa-8558-3dc8-da63-8cd60a6e0a78@ti.com>
Date:   Thu, 12 Oct 2023 15:28:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/4] Add AM65x ICSSG Ethernet support
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Peng Fan <peng.fan@nxp.com>, Udit Kumar <u-kumar1@ti.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <linux-omap@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231003105539.1698436-1-danishanwar@ti.com>
 <625f462e-d0d9-4abd-87db-178674f02cb9@ti.com>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <625f462e-d0d9-4abd-87db-178674f02cb9@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 12/10/23 14:48, Vignesh Raghavendra wrote:
> 
> 
> On 03/10/23 16:25, MD Danish Anwar wrote:
>> Hi All,
>>
>> This series adds support for ICSSG ethernet on AM65x SR2.0. 
>> This series also enables TI_ICSSG_PRUETH as loadable kernel module.
>> This series is based on the latest next-20230925 linux-next.
>>
>> This is the v4 of the series [v1]. This addresses comments made on v3.
>>
>> Changes from v3 to v4:
>> *) Added RB tag of Andrew Davis.
>> *) Added LAKML to the --cc of this series as it was dropped in v3.
>>
>> Changes from v2 to v3:
>> *) Changed comment of icssg nodes in device trees from "Dual Ethernet
>>    application node" to "Ethernet node" as asked by Andrew L.
>> *) Applied k3-am654-idk.dtbo at build time to the k3-am654-base-board.dtb
>>    in order to not have orphan DTBO as asked by Andrew D.
>> *) Modified k3-am654-gp-evm.dtb to have k3-am654-icssg2.dtbo as well.
>>
>> Changes from v1 to v2:
>> *) Moved ICSSG2 nodes from k3-am654-base-board.dts to new overlay file
>>    k3-am654-icssg2.dtso as asked by Andrew.
>> *) Renamed k3-am654-base-board.dts to k3-am654-common-board.dts
>> *) Added "Enable TI_ICSSG_PRUETH" patch to this series.
>>
>> [v1] https://lore.kernel.org/all/20230911071245.2173520-1-danishanwar@ti.com/
>> [v2] https://lore.kernel.org/all/20230921060913.721336-1-danishanwar@ti.com/
>> [v3] https://lore.kernel.org/all/20230926045337.1248276-1-danishanwar@ti.com/
>>
> 
> Wit this series applied I see build failures like:
> 
> arch/arm64/boot/dts/ti/k3-am65-main.dtsi:897.25-916.4: Warning (unique_unit_address): /bus@100000/pcie@5600000: duplicate unit-address (also used in node /bus@100000/pcie-ep@5600000)
>   DTC     arch/arm64/boot/dts/ti/k3-am654-icssg2.dtbo
> arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:14.6-85.3: Warning (node_name_chars_strict): /fragment@0/__overlay__: Character '_' not recommended in node name
> arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:87.12-125.3: Warning (node_name_chars_strict): /fragment@1/__overlay__: Character '_' not recommended in node name
> arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:127.14-145.3: Warning (node_name_chars_strict): /fragment@2/__overlay__: Character '_' not recommended in node name
>   DTOVL   arch/arm64/boot/dts/ti/k3-am654-base-board.dtb
> 
> Overlay 'arch/arm64/boot/dts/ti/k3-am654.dtsi' is incomplete (4096 / 1346656301 bytes read)
> make[3]: *** [scripts/Makefile.lib:402: arch/arm64/boot/dts/ti/k3-am654-base-board.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:480: arch/arm64/boot/dts/ti] Error 2
> make[1]: *** [/home/a0132425/workspace/k3-next/Makefile:1391: dtbs] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> There probably is some race here as I see this with make -j32 dtbs 
> but not on my less powerful laptop
> 

I am running -j20 and I don't see this build failure whien applying the
patches and running 'make mroproper' before building.

Please try with a clean build.

I just did applied this patch on linux-next with a clean build and the
patches got applied without any failure / warnings.

> 
> 
>> Thanks and Regards,
>> MD Danish Anwar
>>
>> MD Danish Anwar (4):
>>   arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
>>   arm64: dts: ti: k3-am654-base-board: add ICSSG2 Ethernet support
>>   arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports
>>   arm64: defconfig: Enable TI_ICSSG_PRUETH
>>
>>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  36 +++
>>  ...se-board.dts => k3-am654-common-board.dts} |   0
>>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   | 145 +++++++++
>>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso      | 296 ++++++++++++++++++
>>  arch/arm64/configs/defconfig                  |   1 +
>>  6 files changed, 482 insertions(+)
>>  rename arch/arm64/boot/dts/ti/{k3-am654-base-board.dts => k3-am654-common-board.dts} (100%)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-idk.dtso
>>
> 

-- 
Thanks and Regards,
Danish
