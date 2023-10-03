Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4831D7B66FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjJCLBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbjJCLB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:01:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B529B;
        Tue,  3 Oct 2023 04:01:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B1IgJ089750;
        Tue, 3 Oct 2023 06:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330878;
        bh=qBTy0JATJk++8UogQ04Q4Tt3EI8iQmg8anAF9xb4KKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D1JOypT7ktu6QzytGqDcRC0q89Inh09DRpVlqU9d9jqUbgpYEt16beKpV/YP8TLJI
         z148qqiMLy+f9Ufug9v19DKQIIE62AcWxh4OLZyyAa2ETwfNRtYudYmWhOBaU4H4uY
         MRBkFT1mvufG7+rYkNo5BEvrxsmppjglVwbvaieI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B1IQr096637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:01:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:01:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:01:17 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvf129223;
        Tue, 3 Oct 2023 06:01:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 0/9] Add R5F and C7x DSP node for K3 J721S2, AM68 and AM69 SoCs
Date:   Tue, 3 Oct 2023 16:30:42 +0530
Message-ID: <169633065057.2221719.1284860999650506339.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001181417.743306-1-a-nandan@ti.com>
References: <20231001181417.743306-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva Nandan,

On Sun, 01 Oct 2023 23:44:08 +0530, Apurva Nandan wrote:
> This series adds the R5F processor nodes and C7x DSP nodes for
> J721S2, AM68 and AM69 SoCs to align these nodes with other K3 SOC's node.
> 
> The first three patches adds the remote proc nodes to the SoC device
> tree, remaining patches reserves the memory for remote proc IPCs
> on K3 J721S2 EVM, AM68 SK, AM69 boards.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/9] arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes
      commit: bc1a339df22013761fc8cda603209cb9f5eb291f
[2/9] arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nodes
      commit: ce43999a6f2bb556d3a4526fbe73dcde58817ce7
[3/9] arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
      commit: 10e9c99259ba183224199b41f455aa2c357a531a
[4/9] arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for R5F
      commit: 69411bc675242bf998f88daddd5f3ae1293a5818
[5/9] arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for C71x DSPs
      commit: c0e346900bcb9f833d96a9b1da1fe45848046247
[6/9] arm64: dts : ti: k3-am68-sk-som: Add DDR carveout memory nodes for R5F
      commit: 1dd5b602c9b3d9762f29eab861238e1333c0c73c
[7/9] arm64: dts : ti: k3-am68-sk-som: Add DDR carveout memory nodes for C71x DSP
      commit: ecbc784801d78fd000723d24197c9172aa5d3449
[8/9] arm64: dts : ti: k3-am69-sk: Add DDR carveout memory nodes for R5F
      commit: 61a779412cb7a752ad15c6dae9b2c69f94486dc5
[9/9] arm64: dts : ti: k3-am69-sk: Add DDR carveout memory nodes for C71x DSP
      commit: ee89d4e60ba7f9fa91fa73e1af3e2c1461700449

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

