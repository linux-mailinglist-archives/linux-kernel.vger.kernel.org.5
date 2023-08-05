Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3D7710F6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHER2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHER2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:28:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C247A7;
        Sat,  5 Aug 2023 10:28:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375HSU1C095751;
        Sat, 5 Aug 2023 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691256510;
        bh=Un9g7ddVnkaPOt/fEXcEd1Wur+JweDvbvL6sKOqyn08=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z9/XnQp9V+m5JH6G9ZNlxYwmvQRhmEvnbN1RFaidDZKJpucHdezIdh7Cx0mZ+iPGU
         8Y4FEu4ITPchnTvECdX6SZIDQ06xW8vfnUhq9z8DbOwJPkfPWuhD1iN5rKVQShgxKF
         gQJY+sd5XRGCZ/uDgeFT0c9RYRkadh6y6EqebSJU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375HSUEv087042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 12:28:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 12:28:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 12:28:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375HSTKa006044;
        Sat, 5 Aug 2023 12:28:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@ew.tq-group.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM family and carrier board
Date:   Sat, 5 Aug 2023 12:28:28 -0500
Message-ID: <169125644830.34185.18064797362674618189.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <e4283d6af59c77d2f690e070eb948dd9142a2276.1690463382.git.matthias.schiffer@ew.tq-group.com>
References: <e4283d6af59c77d2f690e070eb948dd9142a2276.1690463382.git.matthias.schiffer@ew.tq-group.com>
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

Hi Matthias Schiffer,

On Thu, 27 Jul 2023 15:21:18 +0200, Matthias Schiffer wrote:
> For now only the MBaX4Xx carrier board is defined.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM family and carrier board
      commit: ee1ada53846b6ff4154ac7a78b74a12cfd6a8639
[2/3] arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier board Device Trees
      commit: 4717a36f31ecc7c090ce4459a6ed220869d27eca
[3/3] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add SD-card and WLAN overlays
      commit: 5e52cf6bf3c7216de1ee4a74ee002cb99b3f6c11

Couple of minor notes:
Documentation/devicetree/bindings/eeprom/at24.yaml has compatibles that cover the checkpatch warnings
DT compatible string "st,24c02" appears un-documented
DT compatible string "st,24c64" appears un-documented

/scripts/dtc/include-prefixes/dt-bindings/mux/ti-serdes.h: warning: "These bindings are deprecated. Instead, use the header in the DTS source directory."
I have locally updated this to #include "k3-serdes.h"

You might want to cross verify if all good.

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

