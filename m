Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82137771200
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHEUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:06:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637A1735;
        Sat,  5 Aug 2023 13:06:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375K6XVi054271;
        Sat, 5 Aug 2023 15:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691265993;
        bh=VoQN3FGklpzU4X8rPKnZTC9k8CQSpU/RiftCcrBUIGA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NeWyLC7alfp6/Y7B5+4J7NwDyU0BYKWXKXaWAoqbevzOjiTTCuVfKxf6n2UZDCQLZ
         X5i46bNNuR6l1CZAvH4fAMFhH9idb1hdsyvXMELx1V/1l4q57pW1mtzCK3mw0UCr5d
         i0UGxK5t9iMxO1QCF0VT/MoIZ46q8qlObvMt7TnA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375K6XYQ037306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 15:06:33 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 15:06:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 15:06:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375K6XPZ041714;
        Sat, 5 Aug 2023 15:06:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] Add HDMI support for AM68-SK Board
Date:   Sat, 5 Aug 2023 15:06:32 -0500
Message-ID: <169126592443.93814.13094587862313989114.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230803081800.368582-1-j-choudhary@ti.com>
References: <20230803081800.368582-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,

On Thu, 03 Aug 2023 13:47:58 +0530, Jayesh Choudhary wrote:
> AM68-SK base board has one DP and one HDMI port.
> This series add support for HDMI peripheral for the same.
> 
> Jayesh Choudhary (2):
>   arm64: dts: ti: k3-j721s2-main: Add DSS node
>   arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2-main: Add DSS node
      commit: a1f62d114c8ce64d1273c308228b43de8bf45171
[2/2] arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support
      commit: dfe5ccf2359f70d36bf7e64711a46fbff2126ca8

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

