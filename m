Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1093976C499
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjHBFGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHBFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:06:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53078210A;
        Tue,  1 Aug 2023 22:06:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37256YN6103294;
        Wed, 2 Aug 2023 00:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952794;
        bh=evjebhYdH2LI/Q99fUNOcGgnlaE3320TV3NF3sWB3uY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Gm9/2awvm+PQXsieel5vAj7svKASKzeD3WCa+w0QgZ5zAmwb4S9UInXTNAdc0zItp
         RN/AU4Cvb8m8hOvPDaEolbJf3FiHRBpDHJDFo03I7mQwflV3G2DpCHz6wdzsyFolf3
         1HnZghN7j1meCnodq+bX7Z2Ci+RcTVWxf/+JOwoA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37256YYb027271
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:06:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:06:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:06:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37256XcF121459;
        Wed, 2 Aug 2023 00:06:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH v3 0/2] Add MAIN CPSW2G DT support for J721S2
Date:   Wed, 2 Aug 2023 00:06:33 -0500
Message-ID: <169095277513.2814264.13300458144857654810.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230726065407.378455-1-s-vadapalli@ti.com>
References: <20230726065407.378455-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth Vadapalli,

On Wed, 26 Jul 2023 12:24:05 +0530, Siddharth Vadapalli wrote:
> This series adds devicetree node for MAIN CPSW2G instance of CPSW
> Ethernet Switch on TI's J721S2 SoC. Also, a devicetree overlay is added
> in order to enable MAIN CPSW2G in RGMII-RXID mode using the GESI
> Expansion Board connected to the J7 Common-Processor-Board.
> 
> Regards,
> Siddharth.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
      commit: d6ffe1b4b8c1cdc0ae36b6bc65b11d336aecbb72
[2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI
      commit: cac04e27f093c3cafdc10c03b6f50e1578ef8cbc

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

