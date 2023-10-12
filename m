Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3887C6950
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjJLJTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJLJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:19:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F8891;
        Thu, 12 Oct 2023 02:19:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C9J7Z8031420;
        Thu, 12 Oct 2023 04:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697102347;
        bh=zwId/HcYkweim0UL2ERsyjzp1tilLsP4HSd8GawHTYQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=d8SQZk/w7+MiZT2CnAEJ8s7HDQHi8WEIdCbpmXjZ8y68Nflpjdp3fCEAA5l4xlUrs
         KRA0mhivfp3ZtrqLCI5bfadDkD8+uLq8WDaKZy6jCmW+Y0xQH1t4Tv84+q1sDy02Km
         22OfdF+4HsKbVUizBbh89WnkmNyC/llWLbsW+xhA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C9J6U4080207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 04:19:06 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 04:19:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 04:19:06 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C9IwdN016481;
        Thu, 12 Oct 2023 04:18:59 -0500
Message-ID: <625f462e-d0d9-4abd-87db-178674f02cb9@ti.com>
Date:   Thu, 12 Oct 2023 14:48:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add AM65x ICSSG Ethernet support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>
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
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231003105539.1698436-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/23 16:25, MD Danish Anwar wrote:
> Hi All,
> 
> This series adds support for ICSSG ethernet on AM65x SR2.0. 
> This series also enables TI_ICSSG_PRUETH as loadable kernel module.
> This series is based on the latest next-20230925 linux-next.
> 
> This is the v4 of the series [v1]. This addresses comments made on v3.
> 
> Changes from v3 to v4:
> *) Added RB tag of Andrew Davis.
> *) Added LAKML to the --cc of this series as it was dropped in v3.
> 
> Changes from v2 to v3:
> *) Changed comment of icssg nodes in device trees from "Dual Ethernet
>    application node" to "Ethernet node" as asked by Andrew L.
> *) Applied k3-am654-idk.dtbo at build time to the k3-am654-base-board.dtb
>    in order to not have orphan DTBO as asked by Andrew D.
> *) Modified k3-am654-gp-evm.dtb to have k3-am654-icssg2.dtbo as well.
> 
> Changes from v1 to v2:
> *) Moved ICSSG2 nodes from k3-am654-base-board.dts to new overlay file
>    k3-am654-icssg2.dtso as asked by Andrew.
> *) Renamed k3-am654-base-board.dts to k3-am654-common-board.dts
> *) Added "Enable TI_ICSSG_PRUETH" patch to this series.
> 
> [v1] https://lore.kernel.org/all/20230911071245.2173520-1-danishanwar@ti.com/
> [v2] https://lore.kernel.org/all/20230921060913.721336-1-danishanwar@ti.com/
> [v3] https://lore.kernel.org/all/20230926045337.1248276-1-danishanwar@ti.com/
> 

Wit this series applied I see build failures like:

arch/arm64/boot/dts/ti/k3-am65-main.dtsi:897.25-916.4: Warning (unique_unit_address): /bus@100000/pcie@5600000: duplicate unit-address (also used in node /bus@100000/pcie-ep@5600000)
  DTC     arch/arm64/boot/dts/ti/k3-am654-icssg2.dtbo
arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:14.6-85.3: Warning (node_name_chars_strict): /fragment@0/__overlay__: Character '_' not recommended in node name
arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:87.12-125.3: Warning (node_name_chars_strict): /fragment@1/__overlay__: Character '_' not recommended in node name
arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso:127.14-145.3: Warning (node_name_chars_strict): /fragment@2/__overlay__: Character '_' not recommended in node name
  DTOVL   arch/arm64/boot/dts/ti/k3-am654-base-board.dtb

Overlay 'arch/arm64/boot/dts/ti/k3-am654.dtsi' is incomplete (4096 / 1346656301 bytes read)
make[3]: *** [scripts/Makefile.lib:402: arch/arm64/boot/dts/ti/k3-am654-base-board.dtb] Error 1
make[2]: *** [scripts/Makefile.build:480: arch/arm64/boot/dts/ti] Error 2
make[1]: *** [/home/a0132425/workspace/k3-next/Makefile:1391: dtbs] Error 2
make: *** [Makefile:234: __sub-make] Error 2

There probably is some race here as I see this with make -j32 dtbs 
but not on my less powerful laptop



> Thanks and Regards,
> MD Danish Anwar
> 
> MD Danish Anwar (4):
>   arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
>   arm64: dts: ti: k3-am654-base-board: add ICSSG2 Ethernet support
>   arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet ports
>   arm64: defconfig: Enable TI_ICSSG_PRUETH
> 
>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  36 +++
>  ...se-board.dts => k3-am654-common-board.dts} |   0
>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   | 145 +++++++++
>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso      | 296 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  6 files changed, 482 insertions(+)
>  rename arch/arm64/boot/dts/ti/{k3-am654-base-board.dts => k3-am654-common-board.dts} (100%)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> 

-- 
Regards
Vignesh
