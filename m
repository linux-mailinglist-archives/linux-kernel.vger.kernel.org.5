Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0416B8040D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjLDVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:12:15 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51A90
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:12:21 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4LC1Gh106358;
        Mon, 4 Dec 2023 15:12:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701724321;
        bh=iFMaGFTVH7HtvqJFV0m6SQSOlpT+ySN/QyXSir4ZpuU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k1CP88mcpIfU9csDJsU1Bd9Qg9UKPUOFa8OThXymvw6RpZiezi4FfXzkb/keoh78L
         i4bdnLKbmD2drhVunks/kMtVIqyTWfoAqj0WboHWBzDf4zqc5EblOyQfqwQPpdeBki
         zhntV41YPxNv2X+F8dZ0LAJmEyruoYQdKySk2CZ0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4LC17V060848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 15:12:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 15:12:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 15:12:01 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4LC0PL002948;
        Mon, 4 Dec 2023 15:12:01 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Date:   Mon, 4 Dec 2023 15:11:58 -0600
Message-ID: <170172431132.2630525.9449114798176700175.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201195732.4931-1-francesco@dolcini.it>
References: <20231201195732.4931-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco Dolcini,

On Fri, 01 Dec 2023 20:57:32 +0100, Francesco Dolcini wrote:
> Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> is not adequate for embedded systems that use SoCs where it's common to
> have a large number of serial ports.
> 
> No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: increase SERIAL_8250_NR_UARTS
      commit: 7bb7d31d9e454fc0b13cb0df44c2b4d953b4a152

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

