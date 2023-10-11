Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0A7C5B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjJKStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjJKSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61490;
        Wed, 11 Oct 2023 11:48:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6046CC433C7;
        Wed, 11 Oct 2023 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050137;
        bh=XHEtZuBQzbjCxojtRlaEulj66fepVyDltxO7B6EGdog=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bzeWAnYrNgets3frA7NxmKuL3/WfLWhFxi7KnnWu3ri0wp+WDKJXO5KUtznFmeRv4
         ZWiQsVr9/zD+NL5hh8USePrDvnUg7iXOlwEhnzYMxGEh5iSjuLQzS3qGICAnuTxeCu
         eAwKTCZfZAM/rTShn/XntfZ5UKRlGn3fZLdIE9t9CF0gE6lLWXdU8MTRNVZVlillR2
         W5v+H6OSGfD2gIEnz4CRg/CzjLCKDi+BXdQEe6aSr0wmnFaCNlvMOKiGdH4wTnoen1
         B+n7lUpfkc+wi52BWor8KTIjsXivno2LwCp+5AqbhJuF5iDuLDCPnsAlUuw0XjWWXX
         qXlOdqRojOjZA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20231010163100.89734-1-andriy.shevchenko@linux.intel.com>
References: <20231010163100.89734-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Don't use flexible array in struct
 spi_message definition
Message-Id: <169705013611.94724.313317243886665063.b4-ty@kernel.org>
Date:   Wed, 11 Oct 2023 19:48:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 19:31:00 +0300, Andy Shevchenko wrote:
> The struct spi_message can be embedded into another structures.
> With that the flexible array might be problematic as sparse
> complains about it, although there is no real issue in the code
> because when the message is embedded it doesn't use flexible array
> member. That memeber is a private to spi_message_alloc() API, so
> move it to that API in a form of an inherited data type.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Don't use flexible array in struct spi_message definition
      commit: f6d7f050e258e3c71e310f5167c4d65bbefaeb31

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

