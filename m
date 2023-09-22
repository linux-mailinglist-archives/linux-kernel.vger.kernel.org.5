Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21757ABA12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjIVT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjIVT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:28:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8BAF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:28:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19029C433C7;
        Fri, 22 Sep 2023 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410915;
        bh=BmLdFY3csgfqTb8wY8hnwUjYc88tC6pnnfwcHwWy744=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c4X9IVj5ZCTlN3JowoTT1iu9wOIGAfe2JNj1xmhLSDFN+T6cdp84L+H/6RD+uyRG7
         QizXM4rVwZ9XrHbdfRLDbMjM2Gb6Lx4eOtR1oRf9Y9mQ5oNaJUj2SKynVsA7YawIKb
         3GpvKdFzXgqVyXAbqyd2ESg59pwb5L2zXHCkn8yxVmdy9eqqZaGtSo/huCt763kjlg
         9UdvqF0L231b4zA/F1hGN63zOW1JuRLK2yTMDIMRWBbGGI35PzK8c5TkjTCblnHsn8
         9n2ryWLA6Ex1tFXGWHcVL7XyHKN7iur4v/R3mmWT2m1F1NTZc2gwvHvKkcTKAdGeeK
         ih5v+XqFbPWDw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230922153711.28103-1-rf@opensource.cirrus.com>
References: <20230922153711.28103-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: rbtree: Fix wrong register marked as in-cache
 when creating new node
Message-Id: <169541091366.56362.11146940742767135456.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 20:28:33 +0100
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

On Fri, 22 Sep 2023 16:37:11 +0100, Richard Fitzgerald wrote:
> When regcache_rbtree_write() creates a new rbtree_node it was passing the
> wrong bit number to regcache_rbtree_set_register(). The bit number is the
> offset __in number of registers__, but in the case of creating a new block
> regcache_rbtree_write() was not dividing by the address stride to get the
> number of registers.
> 
> Fix this by dividing by map->reg_stride.
> Compare with regcache_rbtree_read() where the bit is checked.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: rbtree: Fix wrong register marked as in-cache when creating new node
      commit: 7a795ac8d49e2433e1b97caf5e99129daf8e1b08

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

