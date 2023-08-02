Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA676C488
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHBFEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjHBFEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:04:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754548F;
        Tue,  1 Aug 2023 22:04:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37254Q4p102564;
        Wed, 2 Aug 2023 00:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952666;
        bh=4P7A4akXNk/eAjN9A1gWPF94ji932RUzuBZB9lVbRHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VoE6aFEWQuPdZzmw1+0hpj0D7SOD7wzWSc4bGgqRBI3WaTWGl9AfPN1JT/LPhOkPj
         csxw9zyS56WVgUZ3p2IAa+lJs3F8GMRuaboblZIs8EAjnLE2roKEiBIWuBcIC7VCCt
         wHEu4+4dmCEmE2Osd6wqKi8UF6APJ0Gm/ZXgPC8Y=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37254PNq042392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:04:26 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:04:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:04:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37254Pk0118748;
        Wed, 2 Aug 2023 00:04:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with GESI
Date:   Wed, 2 Aug 2023 00:04:24 -0500
Message-ID: <169095264878.2812972.12994012568376936591.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230725073057.96705-1-s-vadapalli@ti.com>
References: <20230725073057.96705-1-s-vadapalli@ti.com>
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

On Tue, 25 Jul 2023 13:00:57 +0530, Siddharth Vadapalli wrote:
> The J7 GESI EXP board for J721E Common-Proc-Board supports RGMII mode.
> Use the overlay to configure CPSW9G ports in RGMII-RXID mode.
> 
> Add aliases for CPSW9G ports to enable kernel to fetch MAC addresses
> directly from U-Boot.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with GESI
      commit: 7815b2816d146f302f3884ee8e87c7b39fea1ecc

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

