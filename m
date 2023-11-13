Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94817EA3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjKMTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjKMTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A71988;
        Mon, 13 Nov 2023 11:40:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A35C433C7;
        Mon, 13 Nov 2023 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904439;
        bh=gzrsBuaaq7Ias+HTVjBwYIEOSVwB/9IrgcrQUdiriGg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WpBa+rX06OyELpVg6hWTYXfcQyMZi9S66lVJvk0TRBPg2CKFE+4Emb61IfX4W2h1K
         Zreo0uyfm1CrZKXal7GlHztFwz7eAXQih4xji15328MKeKcKMM5lgp3qvPm3WYLlOs
         BI9ZKnBprFk6RrPDqboCiUSpHIq5QQENBMJUe1nEFH2kIeObPQmCnn50F1rRBEIpep
         C6GlmAv2tALYrOpucaSFKFhwC1gPnHHc2KnTUSzEcNX2d+daLiL9cBsaY4//PNUfXi
         LONDxbF1/7LbGde+MHazELjFZSk4fL0oIeg4SL0V/x4mrD235bJcPP+f5LfWIg43e4
         M7/QkbeSmn9NQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-omap@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231111195330.338324-1-colin.i.king@gmail.com>
References: <20231111195330.338324-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: palmas: remove redundant
 initialization of pointer pdata
Message-Id: <169990443689.3294075.9581324276633996428.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 19:53:30 +0000, Colin Ian King wrote:
> Pointer pdata is being initialized with a value that is never read. It is
> being re-assigned later on with the return from a devm_kzalloc call.
> Remove the redundant initialization, cleans up clang scan build warning:
> 
> drivers/regulator/palmas-regulator.c:1597:36: warning: Value stored
> to 'pdata' during its initialization is never read [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: palmas: remove redundant initialization of pointer pdata
      commit: 1fc2e768ff28f096e9fb6438f0d01c3851c7cd68

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

