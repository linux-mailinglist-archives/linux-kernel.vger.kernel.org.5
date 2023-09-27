Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D517B7B04CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjI0M5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI0M5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:57:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF45E6;
        Wed, 27 Sep 2023 05:57:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RCvSqF072572;
        Wed, 27 Sep 2023 07:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695819448;
        bh=h+tEKzQtBYgB6RyJ9jHxJwCUuyu99tI9nMrV0KGAbNE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xBdIHONvnjcQYKYlydRxVrCqgLGAC4AZn4gBlfjCnK0ABX6kbERQrYxP9twut52qn
         kLbuQRtWUQh5Pf3/52qkohE/B/l4FF7PbqnmBqIK1Ywcac5ZCFv7qdaNrMSFhq9p3W
         AghQQzOw49Kr3n99onhlFPa9IkNN9xlscxXFnvHc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RCvSfs125200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 07:57:28 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 07:57:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 07:57:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RCvS64017464;
        Wed, 27 Sep 2023 07:57:28 -0500
Date:   Wed, 27 Sep 2023 07:57:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <afd@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: Re: [PATCH v3 0/4] Add AM65x ICSSG Ethernet support
Message-ID: <20230927125728.fctjhf6kzh2i7ajj@granddad>
References: <20230926045337.1248276-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926045337.1248276-1-danishanwar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:23-20230926, MD Danish Anwar wrote:
> Hi All,
> 
> This series adds support for ICSSG ethernet on AM65x SR2.0. 
> This series also enables TI_ICSSG_PRUETH as loadable kernel module.
> This series is based on the latest next-20230925 linux-next.
> 
> This is the v3 of the series [v1]. This addresses comments made on v2.
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
> 
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
> base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
> -- 
> 2.34.1
> 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n2878

You have ignored get_maintainers and dropped LAKML.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
