Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8FE76C495
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHBFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjHBFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:06:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE11BFA;
        Tue,  1 Aug 2023 22:06:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372563pf019669;
        Wed, 2 Aug 2023 00:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952764;
        bh=6JEuWc4f30IuqUU6XKRgm84QAg2VlhvFZkxR9ff0p/w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n54IXrxR1wOT4556mNZjSF12Zyz0J661CpZaEqhfTO7rnRMkOeVetLAscGvklSyOC
         WdKZRmPwNFBdXL7QePnmYOMWPUiHyI/NIr1mKbiVjaSCngzuvcrPtTEXS5IdoEJJfj
         35f2iAo6TAw7Jjowqb9t24zXDSa+HK6dE0KvVDiQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372563uJ026209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:06:03 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:06:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:06:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372563NF120612;
        Wed, 2 Aug 2023 00:06:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Add UFS support
Date:   Wed, 2 Aug 2023 00:06:02 -0500
Message-ID: <169095270125.2813863.16614506862321546595.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230725133607.2021379-1-u-kumar1@ti.com>
References: <20230725133607.2021379-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit Kumar,

On Tue, 25 Jul 2023 19:06:05 +0530, Udit Kumar wrote:
> This patch series adds UFS support for J784S4 SOC,
> UFS is kept disabled at SOC level, and enabled in EVM where
> UFS flash is present.
> 
> This patch is tested by enabling below configs on top of defconfig
> CONFIG_SCSI_UFS_BSG=y
> CONFIG_SCSI_UFS_CDNS_PLATFORM=y
> CONFIG_SCSI_UFS_TI_J721E=y
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
      commit: f33f5e4c801b7f1838f05aae81eaed8189a1eac4
[2/2] arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral
      commit: 5d55545cc2da8ad320b73705b26a5c0a837b20da

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

