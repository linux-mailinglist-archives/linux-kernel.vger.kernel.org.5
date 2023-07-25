Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4D76168A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjGYLkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGYLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:40:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383D10C7;
        Tue, 25 Jul 2023 04:40:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PBdnOS130110;
        Tue, 25 Jul 2023 06:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690285189;
        bh=/fa+z+CUWBeCBalWhS3n0PD609rlDIlHp3Fx7siEkOY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PtHM3Him0DVTFvhELrCAh/ohVkHl3IRsCQtYyytH1r117BXkyftmeroDOzpssBqcj
         rG3DLKwHrXeonYH1nqpnG7TEPFIU3wLmDZtSEWzlrWYSFp/0e5WVA/+01fHCKDNm3J
         LnNdHk/QnfsHGbH+NHaG8wx35oKcxmEAecUso4NE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PBdnFO002980
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 06:39:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 06:39:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 06:39:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PBdnIZ045291;
        Tue, 25 Jul 2023 06:39:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Tero Kristo" <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/2] Remove power-domains property for devices with compatible ti,am62-sa3ul
Date:   Tue, 25 Jul 2023 06:39:48 -0500
Message-ID: <169028509342.1718778.15078093695331558450.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
References: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

I am going to assume that you are ok with me picking this series up as this
results in a few broken boots for various boards. Let me know if that is not
the case, and I will drop the series from my tree.

Hi Kamlesh Gurudasani,

On Fri, 14 Jul 2023 14:42:40 +0530, Kamlesh Gurudasani wrote:
> SYSFW don't allow access to power of devices with compatible ti,am62-sa3ul
> from main domain.
> 
> Power-domains property, if present will try to access the power of the
> device, which will result into failure in probing of driver for that
> device.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: crypto: ti,sa2ul: make power-domains conditional
      commit: e1f7d17a734c5c617d05c3d188939d5032d3d5a2
[2/2] arm64: dts: ti: k3-am62-main: Remove power-domains from crypto node
      commit: b573bf35ef3f113c1717fa22cefdfdfbb83aec70

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

