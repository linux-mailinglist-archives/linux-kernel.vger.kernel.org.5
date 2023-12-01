Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99BA80063A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377917AbjLAIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377837AbjLAIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:51:46 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C6A84;
        Fri,  1 Dec 2023 00:51:52 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B18phUd126451;
        Fri, 1 Dec 2023 02:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701420703;
        bh=9ui1d+7rj/ZHYz3ASmxCksLX8kM2w9ENRHHVaVCL4+c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w39ELqPUB81jTG9vLOo3Yuo7wAdCxJ5bmttriBzTVnrneARIozJGf7QEL6Wd+JLCb
         rSvhwgfLEfpDf5p3Y6JlHN1E9z5+FPqmWUI2Uji8zsFKWpGcCAs+VZXB57IjAUkfvt
         ylY6H3KXwvQvuuman+78ozkToEOzEIn9MW56ur3k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B18phZL030228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 02:51:43 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 02:51:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 02:51:43 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B18pgEo015363;
        Fri, 1 Dec 2023 02:51:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
Date:   Fri, 1 Dec 2023 02:51:40 -0600
Message-ID: <170142068081.922136.12853419416211333002.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231106-am65-dss-clk-edge-v1-1-4a959fec0e1e@ideasonboard.com>
References: <20231106-am65-dss-clk-edge-v1-1-4a959fec0e1e@ideasonboard.com>
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

Hi Tomi Valkeinen,

On Mon, 06 Nov 2023 11:57:48 +0200, Tomi Valkeinen wrote:
> DSS irq trigger type is set to IRQ_TYPE_EDGE_RISING in the DT file, but
> the TRM says it is level triggered.
> 
> For some reason triggering on rising edge results in double the amount
> of expected interrupts, e.g. for normal page flipping test the number of
> interrupts per second is 2 * fps. It is as if the IRQ triggers on both
> edges. There are no other side effects to this issue than slightly
> increased CPU & power consumption due to the extra interrupt.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
      commit: b57160859263c083c49482b0d083a586b1517f78

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

