Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C05779AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjHKWlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjHKWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:40:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D91FED;
        Fri, 11 Aug 2023 15:40:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BMenRS112913;
        Fri, 11 Aug 2023 17:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691793649;
        bh=E+li038v80M5x83ozknZ/GExvphowmHPkqb5PSWrtHI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zEdVXk59iw/Dp4XsctwdDaj8RXC33co+RuvXoU65qBbXOYoZGS8VhEbepOHF7LCGv
         Me4MZwSoWJlHtiGd9RUxod5k+Q4uimxK/g/SfQRw3KAbYcImJadBOGixosL7C0FAzM
         2pgKw3jySMDWeKePbPPMsENWpY6eWkHzd0O1SQjs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BMenMW044370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 17:40:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 17:40:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 17:40:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BMelCt101044;
        Fri, 11 Aug 2023 17:40:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>,
        Apurva Nandan <a-nandan@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 0/3] arm64: dts: ti: k3-j784s4: Add phase tags marking
Date:   Fri, 11 Aug 2023 17:40:44 -0500
Message-ID: <169179345464.1343033.3077217105589722982.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230811192030.3480616-1-a-nandan@ti.com>
References: <20230811192030.3480616-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva Nandan,

On Sat, 12 Aug 2023 00:50:27 +0530, Apurva Nandan wrote:
> bootph-all as phase tag was added to dt-schema
> (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
> This series adds it to Linux to be aligned with bootloader requirement
> for TI K3 J784S4 EVM and TI K3 AM69-SK EVM.
> 
> This series will be ported to the k3-j784s4 u-boot support patch
> series for syncing, and was requested in its review process:
> https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/
> 
> [...]

Btw, Udit had given his reviewed by Reviewed-by for the series [2] and
I see that you have incorporated the requested change. I have applied
his Reviewed-by as a result (just a reminder for the developer to be
responsible for carrying tags from previous versions as appropriate).

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j784s4: Add phase tags marking
      commit: 3a4086985696295577c20ae558f99d974067e316
[2/3] arm64: dts: ti: k3-j784s4-evm: Add phase tags marking
      commit: c74d8de338a553da7b0084bab2554b042375625e
[3/3] arm64: dts: ti: k3-am69-sk: Add phase tags marking
      commit: 68501d3cc16a7828b05ee24bdb037f697e207854

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
[2] https://lore.kernel.org/all/f41102bb-134a-50cc-bb98-7950260c7aa6@ti.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

