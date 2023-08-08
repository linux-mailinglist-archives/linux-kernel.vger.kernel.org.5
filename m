Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B08774151
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjHHRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjHHRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032AB1DCAF;
        Tue,  8 Aug 2023 09:07:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DRloi024385;
        Tue, 8 Aug 2023 08:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501267;
        bh=6xAGgK/MigkE5KWfV/hAVgjmFCVnQ7u5G9JT9oYRb0I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j7+wuQPIf1bix76cCyniysJ7WM5rU85RS8WNoC/DkeQlZDsmy9kj82VQJlaqgbOSB
         yKhUZsX4fXjbRH9aLJvL4O3ESz42CIq3WkSIpVHlz/dE3QdRWAcmlmKnWjDFD1VNjb
         T0AUZaYl57LMGv6aCxTnYY4YFTB/7TRK9+Zh4rHs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DRl3j109453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:27:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:27:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:27:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DRlWd054823;
        Tue, 8 Aug 2023 08:27:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] arm64: dts: ti: Enable Audio on Verdin AM62
Date:   Tue, 8 Aug 2023 08:27:46 -0500
Message-ID: <169150111130.1366102.11500838433744762037.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230807202159.13095-1-francesco@dolcini.it>
References: <20230807202159.13095-1-francesco@dolcini.it>
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

Hi Francesco Dolcini,

On Mon, 07 Aug 2023 22:21:55 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add AM62x AUDIO_REFCLKx to AM62x SoC dtsi, and after doing it, enable audio
> support for Toradex Verdin AM62.
> 
> DT bindings updates, related to the audio codec used here, are already merged
> in next [2][3].
> 
> [...]

Note: wlf,wm8904 converted to yaml and #sound-dai-cells fixup are
present in linux-next next-20230808 tag, and the dtbs_checks is clean
there. while the syscon cleanups need to take place, the expectation
is that the changes for syscon should keep this node and driver
functional. if anything changes, please let me know and we can take
appropriate measures.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62: Enable AUDIO_REFCLKx
      commit: 6111ac92f93415eaa680e7ef43ee4fa78b1eb7f2
[2/4] arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
      commit: 0bf6d62cb5173d85113f4f759cad3191845e15fa
[3/4] arm64: dts: ti: verdin-am62: dev: add sound card
      commit: c90658201cbeb7aae072ab3da4e255f47d9e25b3
[4/4] arm64: dts: ti: verdin-am62: dahlia: add sound card
      commit: f5bf894c865b26ea8ec43186e87bb08d092b6fa1

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

