Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0E8113EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379224AbjLMOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjLMN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:59:41 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE71AA;
        Wed, 13 Dec 2023 05:58:39 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDwXul083864;
        Wed, 13 Dec 2023 07:58:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702475913;
        bh=ZPa0O7YiR9CkUahenUG0yZpWNB69T/p2oEzwqmF/fD0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B9pRj2YTUMI6k3LvUJjuEwSgAfjJda8UCK1MGrcsrAr4c79r9/+zlnlsTZpcrhU1K
         1HjxArFTD7tdFNiXX5310ZnpZOMdP+SFGCQVFgYi1KGa+MPvwlhW2VuVOFt2jAL1jF
         BEACEMsyfIiVAFjRdhMZECLlPHYn62onLNCWugLY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDDwXKA046298
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:58:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:58:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:58:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDwXvc042362;
        Wed, 13 Dec 2023 07:58:33 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH v3 0/2] Add PCIe Endpoint overlays for J721E and J721S2
Date:   Wed, 13 Dec 2023 07:58:31 -0600
Message-ID: <170247588949.2577332.11579176748260902766.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211115535.1264353-1-s-vadapalli@ti.com>
References: <20231211115535.1264353-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth Vadapalli,

On Mon, 11 Dec 2023 17:25:33 +0530, Siddharth Vadapalli wrote:
> This series adds device-tree overlays for enabling PCIe in Endpoint mode
> of operation on J721E-EVM and J721S2-EVM.
> 
> NOTE: This series is based on linux-next tagged next-20231211.
> 
> v2:
> https://lore.kernel.org/r/20231115085204.3578616-1-s-vadapalli@ti.com/
> Changes since v2:
> - Rebased series on linux-next tagged next-20231211.
> - Collected Reviewed-by tag from:
>   Ravi Gunasekaran <r-gunasekaran@ti.com>
> - Updated Makefile based on Andrew's suggestion to build the DTBs
>   corresponding to the overlays only with an OF_ALL_DTBS build config
>   since the generated DTBs are not required except to ensure that the
>   overlays apply on the base DTB.
>   Reference:
>   https://lore.kernel.org/r/20231128-csi_dts-v3-9-0bb11cfa9d43@ti.com
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE0 Endpoint Mode
      commit: 3942697901eb5340dc51202352f035ae191c37f2
[2/2] arm64: dts: ti: k3-j721s2-evm: Add overlay for PCIE1 Endpoint Mode
      commit: 729cfcf8ac2447f175eb4b6a0604983618ba07d5

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

