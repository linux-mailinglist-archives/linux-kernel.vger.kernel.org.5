Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B77783EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHJXDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJXDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:03:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C5272C;
        Thu, 10 Aug 2023 16:03:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AN31Yj057055;
        Thu, 10 Aug 2023 18:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691708581;
        bh=+kLM1UzR4fH3ODACFz9Th3FY/JzVSzSBYJtEkhtd5fk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UfE3vN+6gGoO36hwrMGyF7yT5q5JCR03VaU86EHJjl5fRaH03wN/AnLzG4ja/GYiV
         V+N4O7WMV5ecX3YPODgR858e5L36hvLQuDwf9caD1XPOGMKWgXbwdLpnwnfABsA1j/
         kU8bG7h+QUlWqi3ym3sFXNjBDiERU1DvakrPRq5k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AN30iN010495
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 18:03:01 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 18:03:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 18:03:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AN30uK107599;
        Thu, 10 Aug 2023 18:03:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the board level
Date:   Thu, 10 Aug 2023 18:02:59 -0500
Message-ID: <169170856188.691570.10924319644191966142.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809180145.53158-1-afd@ti.com>
References: <20230809180145.53158-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Wed, 09 Aug 2023 13:01:43 -0500, Andrew Davis wrote:
> C7x DSP nodes defined in the top-level J721e SoC dtsi files are incomplete
> and will not be functional unless they are extended with both mboxes and
> memory-region information.
> 
> As theses only known about at the board integration level, these nodes
> should only be enabled when provided with this information.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you for doing the cleanups!

[1/3] arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the board level
      commit: 35dba715971733d5fdfd98f4772ccc679d4989c2
[2/3] arm64: dts: ti: k3-j784s4: Enable C7x DSP nodes at the board level
      commit: c23b203b929f22fb22f2b07c1e5d658a7d455263
[3/3] arm64: dts: ti: k3-j721e: Enable C6x DSP nodes at the board level
      commit: 00ae4c39cd16ef8b1662c5915dda08eb28eed762

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

