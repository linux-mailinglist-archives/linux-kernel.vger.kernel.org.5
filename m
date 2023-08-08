Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA52774847
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjHHTaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjHHT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:29:56 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41810F5;
        Tue,  8 Aug 2023 12:05:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378C6R0B080107;
        Tue, 8 Aug 2023 07:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691496387;
        bh=qkIndM7dqcJoDWN+Ry0lMJkHswMCbqKil4C/JiFX1xk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=G5TzuTIsOcgLcSnabX2mnWZhKv7YMOqnEH1j4v65YqD22/djndK3yyl54TX1BKBtM
         nw7i3QTWOl0fGwdAN1jFRyZ4zn5m8busG9IIjDfmvaFt7GFzDTEupkbVTE1dckAgF9
         61lDQaeHrXTMfhAYSBujwcJ09TuOvxyt/FOLpSu0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378C6REa049555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:06:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:06:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:06:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378C6QRG031642;
        Tue, 8 Aug 2023 07:06:26 -0500
Date:   Tue, 8 Aug 2023 07:06:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] TI K3 M4F support on AM64x and AM62x SoCs
Message-ID: <20230808120626.bfw5hl6hzszhccsg@spectrum>
References: <20230808044529.25925-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808044529.25925-1-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:45-20230807, Hari Nagalla wrote:
> The following series introduces K3 M4F remoteproc driver support for
> AM64x and AM62x SoC families. These SoCs have a ARM Cortex M4F core in
> the MCU voltage domain. For safety oriented applications, this core is
> operated independently with out any IPC to other cores on the SoC.
> However, for non safety applications, some customers use it as a remote
> processor and so linux remote proc support is extended to the M4F core.
> 
> See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021) for
> further details: https://www.ti.com/lit/pdf/SPRUIM2
> 
> Hari Nagalla (3):
>   dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
>   arm64: dts: ti: k3-am62 : Add M4F remote proc node
>   arm64: dts: ti: k3-am64 : Add M4F remote proc node
> 
> Martyn Welch (2):
>   remoteproc: k3: Split out functions common with M4 driver
>   remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem
> 
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  12 +
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  19 +
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi       |  12 +
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  18 +
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  18 +
>  drivers/remoteproc/Kconfig                    |  13 +
>  drivers/remoteproc/Makefile                   |   3 +-
>  drivers/remoteproc/ti_k3_common.c             | 513 +++++++++++++++
>  drivers/remoteproc/ti_k3_common.h             | 108 ++++
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 598 +-----------------
>  drivers/remoteproc/ti_k3_m4_remoteproc.c      | 333 ++++++++++
>  12 files changed, 1213 insertions(+), 570 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
>  create mode 100644 drivers/remoteproc/ti_k3_common.c
>  create mode 100644 drivers/remoteproc/ti_k3_common.h
>  create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

Please keep the device tree seperate from driver changes.
ordering of patches should be:
a) binding
b) driver updates
c) mark device tree changes in the same series (if you are posting) as
"DONOTMERGE" to help driver maintainers understand that the dts come in
via SoC tree (most maintainers do not need this, but it keeps things
sane and adjust your expectation that this will hit the same window as
the driver changes).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
