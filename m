Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D4805F27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjLEULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjLEULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:11:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D95D53;
        Tue,  5 Dec 2023 12:11:35 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5KBLaY070414;
        Tue, 5 Dec 2023 14:11:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701807081;
        bh=tykLgFAN0sBT/vZntrlheG7q4aoOYiXjvXxIPINHQbE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BJgOONCfowq1kcoBHDUWwNilYmJjkaeP8ezneBLiINgca8ukIQLLIzDq8j8odgFns
         UpIhEfL1qxRtciTPYM7AjryfCI51e76LNOQ8Ngp65s6cTDOtytrNXXJByLGKS1L2MR
         4J1PyHOGrXh52Ou8AUm3/3GM2mqYjootuUIq2QH0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5KBLcd008887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 14:11:21 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 14:11:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 14:11:21 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5KBLhB110808;
        Tue, 5 Dec 2023 14:11:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jai Luthra <j-luthra@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH RESEND v3 0/9] arm64: dts: ti: Enable CSI cameras for AM62 family
Date:   Tue, 5 Dec 2023 14:11:14 -0600
Message-ID: <170180697250.3345832.2524014147786723166.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
References: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai Luthra,

On Fri, 01 Dec 2023 10:39:15 +0530, Jai Luthra wrote:
> This series enables CSI camera support on BeaglePlay, SK-AM62 and
> SK-AM62A, now that the dt-bindings and driver support for CSI-RX related
> IPs is merged in v6.7-rc1.
> 
> Along with the device tree nodes for CSI-RX, add new DT overlays for
> different camera modules like RPiv2 (IMX219) or PCam5C (OV5640).
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/9] arm64: defconfig: Enable AM62 CSI2RX
      commit: bd62d91f42d015e173809214badaf750b75be2d1

I have applied the following to branch ti-k3-dts-next on [1]:

[2/9] arm64: dts: ti: Enable CSI-RX on AM62
      commit: 2017f5a610a998cd414c7d9e8b19051014f3126b
[3/9] arm64: dts: ti: Enable CSI-RX on AM62A
      commit: c45e3b54ad1e84f59b3193abc6f451a8cdf7d69f
[4/9] arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
      commit: defa1438c5b34af13fb56c7faefaeec648805530
[5/9] arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
      commit: fed1e53ecf9f0ecf04bd931428287fd1002899ef
[6/9] arm64: dts: ti: k3-am62x: Add overlays for OV5640
      commit: 635ed97151945a7fdf104ef1227d86f0a9e3678e
[7/9] arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
      commit: 00d7f8f9efdbdf551e92683f5cd274145dce2c4b
[8/9] arm64: dts: ti: k3-am62x: Add overlay for IMX219
      commit: 4111db03dc05c49ded2d9ec21b52c0ca45b59303
[9/9] arm64: dts: ti: Use OF_ALL_DTBS for combined blobs
      commit: b0044823a6607e535fdb083c89f487fbf183b171

with minor $subject and formatting updates to stay in sync with existing
changes.

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

