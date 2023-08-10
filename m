Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E5776F80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjHJFWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:22:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A648E6B;
        Wed,  9 Aug 2023 22:22:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A5MLji008891;
        Thu, 10 Aug 2023 00:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691644941;
        bh=MNzwKYOwNi6OoiUYJlqgxTSFunc3swGesn3+QdyDvh4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ckq0Ej9s511N5hRCmDHJ2ZVgwLG2sABii3WstkehBk20HE0JE4SKcaIQZU10ao8d/
         VmzPjXYp8rx0xGyV+KImqYrjgvhZ9udVRQA1gCiuTjulkdjN9dVkjeoEZyZ9PLx/Lg
         V44gn+Am8Bq6nXgy0WK/d+EJWy21gC50GqsX7jFs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A5MLCC121927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 00:22:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 00:22:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 00:22:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A5MKOL013946;
        Thu, 10 Aug 2023 00:22:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <kristo@kernel.org>, <vigneshr@ti.com>, <d-gole@ti.com>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 00/13] Another round of K3 DTSI disables
Date:   Thu, 10 Aug 2023 00:22:20 -0500
Message-ID: <169164489346.20171.9690910658096738938.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230810003814.85450-1-afd@ti.com>
References: <20230810003814.85450-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Wed, 9 Aug 2023 19:38:01 -0500, Andrew Davis wrote:
> Similar to a couple previous series on this, we disable by default
> nodes that cannot function standalone.
> 
> This helps prevent folks from forgetting to disable unused nodes
> in their boards. One benefit of that is you can start out with
> an almost empty DTS file for a new board and have it still
> function without warnings or misbehaving hardware. Adding as you
> go, this helps ease bringup and upstreaming of new boards.
> 
> [...]

Thank you for doing the cleanup.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/13] arm64: dts: ti: k3-j721e: Enable SDHCI nodes at the board level
        commit: 6fbd1310f99fc95d063b64d42addf701309663d6
[02/13] arm64: dts: ti: k3-j7200: Enable SDHCI nodes at the board level
        commit: 013b7dd32c75ad3db218aa7a2d63f541304ac3b6
[03/13] arm64: dts: ti: k3-j721s2: Enable SDHCI nodes at the board level
        commit: 5f715be31638b62de560acab7fdc7ff3d9e01bf9
[04/13] arm64: dts: ti: k3-am65: Enable OSPI nodes at the board level
        commit: 46d0c519e44bf31f45dd0a62654c75cae76215b8
[05/13] arm64: dts: ti: k3-j721e: Enable OSPI nodes at the board level
        commit: 73676c480b7286cb528170de73a7c03e19a5ade2
[06/13] arm64: dts: ti: k3-j7200: Enable OSPI nodes at the board level
        commit: 1a576c89168422b0658f7831d6e1bad63252eaea
[07/13] arm64: dts: ti: k3-am64: Enable OSPI nodes at the board level
        commit: cd9f6b324277d324ae056ffd8dda6287bcb649ab
[08/13] arm64: dts: ti: k3-j721e: Enable GPIO nodes at the board level
        commit: 8757108b59e1490062d3c6a55ceccbafbee50e35
[09/13] arm64: dts: ti: k3-j721s2: Enable GPIO nodes at the board level
        commit: 578bf4d09ef5d6e6707682ef0ae9d954ef77b8fb
[10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the board level
        commit: d9fe476d39f62719adb805fc8c5668a3e21570d0
[11/13] arm64: dts: ti: k3-j721e: Enable TSCADC nodes at the board level
        commit: a5a4cddad9ff71c55494328d0e39f051fe5905c2
[12/13] arm64: dts: ti: k3-am65: Enable TSCADC nodes at the board level
        commit: 1228242df12ec1b7cd099c8e57a35940f32b89c3
[13/13] arm64: dts: ti: k3-am64: Enable TSCADC nodes at the board level
        commit: bcd8a3f28ad6baec7f4d8cbb0fe7cbaf6e351567

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

