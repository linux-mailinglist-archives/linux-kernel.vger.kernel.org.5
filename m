Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E42779AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHKWt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjHKWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:49:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E62130;
        Fri, 11 Aug 2023 15:49:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BMnkf8039849;
        Fri, 11 Aug 2023 17:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691794187;
        bh=DbELkESq5NLWSVtDBIugfxfa1NLs+K4yNXxiZMX0r1Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N7ufjd/+UZUAJriYK9qBUeeG9Cp8qc9ShvpqgMwNeDEptvSg4W0KJ5tIOEMINpiBt
         jk9ESYcYj/BL4D3c0qGybz+t64W9So07u8tY2l1JaRyl1pepYmpN+6sI+HiHTFCm8z
         /zt4SAPiaB8bNFy3Ugs0w8sdJKXXWgXLvHCjEOUU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BMnk6g079666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 17:49:46 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 17:49:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 17:49:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BMnk3f045154;
        Fri, 11 Aug 2023 17:49:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
Date:   Fri, 11 Aug 2023 17:49:45 -0500
Message-ID: <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230811184432.732215-1-vigneshr@ti.com>
References: <20230811184432.732215-1-vigneshr@ti.com>
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

Hi Vignesh Raghavendra,

On Sat, 12 Aug 2023 00:14:29 +0530, Vignesh Raghavendra wrote:
> This series adds basic support for AM62P family of SoCs and specifically
> AM62P5 variant. Also adds AM62P5-SK support with basic peripheral
> like UART.
> 
> TRM at [0] and Schematics is at [1]
> 
> [0]: https://www.ti.com/lit/pdf/spruj83
> [1]: https://www.ti.com/lit/zip/sprr487
> 
> [...]

Note: since the changes were trivial, I incorporated the cosmetic
fixup suggested by Andrew locally when I applied. I have also dropped
bootph property from board's reserved nodes inline with what we did
for j721s2[2]. Thanks for the bootlog.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
      commit: b57fc5cbdbdfd04d44697800a9d59aeb3be2f273
[2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
      commit: 29075cc09f43a024d962da66d2e4f9eb577713d0
[3/3] arm64: dts: ti: Add support for the AM62P5 Starter Kit
      commit: 935c4047d42e53a06ec768ddc495a44f6869209c

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
[2] https://lore.kernel.org/all/20230811192030.3480616-1-a-nandan@ti.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

