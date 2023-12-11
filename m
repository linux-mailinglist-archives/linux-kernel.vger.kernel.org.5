Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648080DB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjLKU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344986AbjLKU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:27:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01A98
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:27:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53CBC433C7;
        Mon, 11 Dec 2023 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702326463;
        bh=0S1qcmFu0ot2qIJIbBAUlGdCvp0nNqJnrHVXivPbU94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+qwQD4FyTSqvzMROJOE8/18WEiwpkzkWCtha9VKx14sf0JGKBFsucEBL+S7EvsV0
         S4dabO3IrXfnehXnl7oxftQRK89TG6nRJUgPCfewgHJZF3sz/Vm1lRfJP8rww8sCiz
         NCWDJnV5pcAjOLfO+7XU9uk8lwg18v6MWzV4007OtENPdRb796Ff2n4EfCD2nYDGSW
         icxWFtHdCQz0I/iHidYcWa6ZP6vMOLgD4UNJJsZIFcGV/iKPzaxFyCuPoP2vx15Cq8
         gZTiaMaxwi2ALQ2W//5mR9qROn8VFrST9TdgJh5Xg01C00OKvc+l0qMIjFgZxxbwzd
         /RCsfe7EOpXvg==
From:   Will Deacon <will@kernel.org>
To:     broonie@kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joey Gouly <joey.gouly@arm.com>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 00/13] arm64/sysreg: System register updates from the 2023-09 XML release
Date:   Mon, 11 Dec 2023 20:27:28 +0000
Message-Id: <170232143745.1863680.1175789910135449342.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2023 01:02:46 +0000, broonie@kernel.org wrote:
> A number of serieses on the list have updates updates and additions to
> the system registers, and as a result of the work being done on KVM
> (especially nested virtualisation) there are overlaps and duplication of
> work between people unaware of other pending serieses.  This series
> collects together all the work that's been done on updating the system
> register definitions that don't have pending review issues which I'm
> aware of with the aim of at least making it easier to find things.
> 
> [...]

Applied to arm64 (for-next/sysregs), thanks!

[01/13] arm64/sysreg: Update HFGITR_EL2 definiton to DDI0601 2023-09
        https://git.kernel.org/arm64/c/256f442895ed
[02/13] arm64/sysreg: Add definition for HAFGRTR_EL2
        https://git.kernel.org/arm64/c/41bb68fbd016
[03/13] arm64/sysreg: add system register POR_EL{0,1}
        https://git.kernel.org/arm64/c/c0c5a8ea96b8
[04/13] arm64/sysreg: update CPACR_EL1 register
        https://git.kernel.org/arm64/c/35768b23d830
[05/13] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
        https://git.kernel.org/arm64/c/9fb5dc53a117
[06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for DDI0601 2023-09
        https://git.kernel.org/arm64/c/6e3dcfd13975
[07/13] arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
        https://git.kernel.org/arm64/c/b5aefb668701
[08/13] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
        https://git.kernel.org/arm64/c/9e4f409b07df
[09/13] arm64/sysreg: Update ID_AA64SMFR0_EL1 definition for DDI0601 2023-09
        https://git.kernel.org/arm64/c/8afe582d7700
[10/13] arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
        https://git.kernel.org/arm64/c/a6052284a9f9
[11/13] arm64/sysreg: Update HCRX_EL2 definition for DDI0601 2023-09
        https://git.kernel.org/arm64/c/126cb3a60d35
[12/13] arm64/sysreg: Add definition for FPMR
        https://git.kernel.org/arm64/c/e3a649ecf8b9
[13/13] arm64/sysreg: Add new system registers for GCS
        https://git.kernel.org/arm64/c/e94e06d8a796

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
