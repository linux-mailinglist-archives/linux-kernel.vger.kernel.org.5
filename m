Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA317B671C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjJCLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjJCLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:03:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9DAD;
        Tue,  3 Oct 2023 04:03:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B37bW047965;
        Tue, 3 Oct 2023 06:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330987;
        bh=dVSOtarwSKuMqEl24CC2N5aB61RAvBmmSqr2vURC+CA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=go3ngZ4I/Aw79meAzCj5nxcHttdGWyhOH7LnE6krMll7LKtAGlat2J6n8oU7DmBJi
         JBC7P7P7IIqTt1IS7qZLvYSmKD1WNgEgI6zu4rd0mIzgs0dniioohzSQeSR/H8AXtP
         cBk7e9qL9EbtAflaHxsQ1tLdooJ98IZGvZpKIVVs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B37Ne001420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:03:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:03:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:03:06 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvl129223;
        Tue, 3 Oct 2023 06:03:03 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sinthu.raja@ti.com>
Subject: Re: [PATCH 0/3] AM68 SK: Add support for PCIe and USB
Date:   Tue, 3 Oct 2023 16:30:48 +0530
Message-ID: <169633065057.2221719.8622080260354356937.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921100039.19897-1-r-gunasekaran@ti.com>
References: <20230921100039.19897-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi Gunasekaran,

On Thu, 21 Sep 2023 15:30:36 +0530, Ravi Gunasekaran wrote:
> This series adds support for PCIe and USB interfaces.
> 
> Sinthu Raja (3):
>   arm64: dts: ti: Add USB Type C swap defines for J721S2 SoC
>   arm64: dts: ti: k3-am68-sk: Add DT node for PCIe
>   arm64: dts: ti: k3-am68-sk: Add DT node for USB
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: Add USB Type C swap defines for J721S2 SoC
      commit: 97bc20997109590bb17f96f00dbde15cfda9a4b0
[2/3] arm64: dts: ti: k3-am68-sk: Add DT node for PCIe
      commit: 70beb4c1ab8613356ea3d6ae9f7e8a143e1474f0
[3/3] arm64: dts: ti: k3-am68-sk: Add DT node for USB
      commit: 562fc2b011e213b5a127cda523110f0698770606

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

