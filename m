Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDD80F44F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjLLRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F738E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ADCC433CA;
        Tue, 12 Dec 2023 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401671;
        bh=5E05OTck5q9FmBYGpl4V5F7c+f7l7TcBKvljuUu5T9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL7CxijelPXUYHUwP/G07d4Dv54xSud8+XusGtqMRaqTmf1mjVf1YCVuRe4SwOLwN
         iWj2dJiNtim6C21vFsfi2V9oSxaRh1sDjfpoCVXOCwziQ9LckJ8q5QhH8u7YWq3d8+
         49xdHxff+m1AT6Eay8YtakAR+yIO9NX/1Pz1gySrZ6hWN97V4gYziFqYHY3L5JpiKP
         RftUgpkvGA7ngOcXTK6o2rAo9acMWx5Fbo/Ce2IZazsihWbBuQBsYd7/bZtpG+UEnP
         OHfCKl7xk3zqPpmhrBXWNvP8CF5ovgkIEpsX6nD/cJDBIPYNERa6VhSP8uq7hN90c7
         s7k1/GW+n0Oww==
From:   Will Deacon <will@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: Remove usage of the deprecated ida_simple_xx() API
Date:   Tue, 12 Dec 2023 17:20:52 +0000
Message-Id: <170237283916.1645846.8049910363792099274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <85b0b73a1b2f743dd5db15d4765c7685100de27f.1702230488.git.christophe.jaillet@wanadoo.fr>
References: <85b0b73a1b2f743dd5db15d4765c7685100de27f.1702230488.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 18:48:18 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Remove usage of the deprecated ida_simple_xx() API
      https://git.kernel.org/will/c/79c03ed4b896

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
