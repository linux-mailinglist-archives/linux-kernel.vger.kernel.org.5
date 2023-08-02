Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803BE76C48F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjHBFF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHBFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:05:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EDC2D71;
        Tue,  1 Aug 2023 22:04:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37254mlQ030350;
        Wed, 2 Aug 2023 00:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952688;
        bh=wNYAtgSpz4QsACX9gr546ZwReJXxZ+edcxt6G6J4Z1A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wiTcJrdJEgcmDF2supVrW21ogs+kKsAZ4dLF3u0aPb8uTA3oWxCUOh3Xs8p0pXHwk
         BVLowvpRvL1sV4RtdKXTtuvWTd1JTMQ14nsddl30tDfPrPyrMujKH7TTVrs5635BCj
         d4nuY1yZ6MjLXDjiCE620qvCJZ3SGA6euRKCmL2I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37254mV9002199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:04:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:04:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:04:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37254lv6014667;
        Wed, 2 Aug 2023 00:04:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v6] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
Date:   Wed, 2 Aug 2023 00:04:47 -0500
Message-ID: <169095267501.2813054.18243898064074580857.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230725085939.536766-1-b-kapoor@ti.com>
References: <20230725085939.536766-1-b-kapoor@ti.com>
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

Hi Bhavya Kapoor,

On Tue, 25 Jul 2023 14:29:39 +0530, Bhavya Kapoor wrote:
> CAN instances 3 and 5 in the main domain are brought on the common
> processor board through header J27 and J28. The CAN High and Low lines
> from the SoC are routed through a mux on the SoM. The select lines need
> to be set for the CAN signals to get connected to the transceivers on
> the common processor board. Threfore, add respective mux, transceiver
> dt nodes to add support for these CAN instances.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in main domain
      commit: 98f3b667e1de99dc670e12563eae03e15c668d95

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

