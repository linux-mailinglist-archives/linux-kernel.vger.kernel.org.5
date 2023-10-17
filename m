Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAA7CD0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjJQXln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbjJQXli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:41:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0B101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:41:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B77FC433CC;
        Tue, 17 Oct 2023 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586096;
        bh=GgAN2u+O2ZjYC6HU50yCWeKI21hjZm/S1N0mP+E0JuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c7AZYHcxxDGuOjMFaaWBXGwqm9Dvhn1Qew70acoOa+3vqq7/HeNyrw9HkILn78kqh
         m7/UuOWWcjC8voeLN+Q5GFyWGWDnj50VGsblo5PQCI8boi6X7ZmUY1QWJ/EBHup/Pe
         JHiJvnflKmPUTxBtL7764aRgkZ3b60ONEfb1hzEmib/sXBu4e2GBdERfwbtRu1KB6D
         XSaQ7p1aV0eXKiXAy5AeMz7pQzszlmsoCPAc6HRkV4f19Okf6MNaxTHqGNqk2CVjbb
         RGQ3Dl8K3tW/qOdCNvVQLYY4l6hw9VSs+9B6cUxAC5oHjSUCCqgxAVe3qlHbFeDxpz
         c9k64RjItflLg==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231017203507.2699826-1-robh@kernel.org>
References: <20231017203507.2699826-1-robh@kernel.org>
Subject: Re: [RESEND PATCH] regulator: Drop unnecessary of_match_device()
 calls
Message-Id: <169758609503.3230422.4118827670408969959.b4-ty@kernel.org>
Date:   Wed, 18 Oct 2023 00:41:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 15:35:06 -0500, Rob Herring wrote:
> If probe is reached, we've already matched the device and in the case of
> DT matching, the struct device_node pointer will be set. Therefore, there
> is no need to call of_match_device() in probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Drop unnecessary of_match_device() calls
      commit: a8b4962fbd004d7d4fcbf01ce7dc27fcef406199

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

