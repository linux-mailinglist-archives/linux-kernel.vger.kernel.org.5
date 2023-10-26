Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07E7D8819
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJZSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjJZSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:16:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA85D47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:16:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58676C433C8;
        Thu, 26 Oct 2023 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698344208;
        bh=AxyGiD4aSX0ErVADYQj+QyBUZVw0Kt3fsV0F31roehY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=pUd66WAUanTw/Tah58DX7A89uUaA0SZ5MEnFrZVirAYYT31BhHrAUVkFHS/QCOEzw
         QTsdC7hgcYF64WrufRfsuW5cYqaU1ds99qa7lH3HoTe1NVRREIXmCRHuqm0bwmssb+
         DSo2M3TmGbwBq+AFg9rkkMmjIHUTvMN6HWIWc7ZxZs8/GqLi4FvnEHsB3nw40vyeBa
         axE0jk9YkHq87nA+05RUh6M6sLVdwywD6CBdtvN5ALKBcx8WjGXIwCCLVWOQQfQEF/
         MAZ/llv/DX0xnBkh222g1vatrmcVwStBx2riikORZWBfyErW+JXyjKsSgyytZAvE3S
         DH5mfCzknUknw==
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
References: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
Subject: Re: [PATCH 0/2] regmap: kunit: Add test for cache sync interaction
 with range selectors
Message-Id: <169834420703.160082.7535557805517818126.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 19:16:47 +0100
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

On Mon, 23 Oct 2023 18:19:10 +0100, Mark Brown wrote:
> Add a test for a bug reported by Hector Martin, plus a fix for a thinko
> in the tests that I spotted while adding that test case.  I've not
> included a fix since I believe Hector either has or is working on
> something and I don't want to invalidate his work.
> 
> Hector also reports that there is a similar interaction around cache
> initialisation from device defaults.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: kunit: Fix marking of the range window as volatile
      commit: fabe32cc1eca7857837abcb56b242bc4845b7067
[2/2] regmap: kunit: Add test for cache sync interaction with ranges
      commit: 6a2e332c2cbddd17d7dcb8f334953593f1324c8e

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

