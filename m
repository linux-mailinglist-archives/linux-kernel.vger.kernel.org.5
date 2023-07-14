Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199C575436D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbjGNTxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA22D57;
        Fri, 14 Jul 2023 12:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21C661DD3;
        Fri, 14 Jul 2023 19:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FC2C433C8;
        Fri, 14 Jul 2023 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689364373;
        bh=aCtJZwdnYdveK7w96u7CzEpfFedk2qMy8RTje+UnQ9E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hi4UCmMjUqaKNUHGbk3U/lIlmSPBWXeTRR082V++0rTBccTr7e0BjbyEJPJwlnE06
         2m5o6rFGtgd5QYSUfsGNN2xFHX7nO7EMPDyIXcMowb8fHgs/kPT1qk7G/j9ojK90HR
         rmeZJCdZn7VCuaqe94nHi3spwTSHtYVTmhhINVi1dW0SWjrRiY9OY18uQZs5y6C4V7
         8D8UhieQq+NbYPjJX7Yfslgu8o1TJP0TxVw89O/OIiyZcgE6qd51thhZv3G6NGI7Yl
         OLgxWCi4dCoSGx4ODOM3gQ1qmN9KDpBkoeRXdNIPmCWGn+K0tNWN3OrEfDRgBXlwSn
         0q9ZP72SYfHqg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
References: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 0/4] spi: Header and core clean up and refactoring
Message-Id: <168936437204.83695.7127947393052645191.b4-ty@kernel.org>
Date:   Fri, 14 Jul 2023 20:52:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 12:17:44 +0300, Andy Shevchenko wrote:
> Various cleanups and refactorings of the SPI header and core parts
> united in a single series. It also touches drivers under SPI subsystem
> folder on the pure renaming purposes of some constants.
> 
> No functional change intended (with some subtle shortcuts which are
> explained in the respective commit messages).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Remove code duplication in spi_add_device*()
      commit: 36124dea164cf684869e856b2ada23e8adab5f03
[2/4] spi: Kill spi_add_device_locked()
      commit: 7b5c6a545b3491fb785c75cee60e6b0c35a4de1b
[3/4] spi: Use BITS_TO_BYTES()
      commit: 169f5312dc46deb986e368b6828bedbedd297f6e
[4/4] spi: Use struct_size() helper
      commit: 75e308ffc4f0d36b895f1110ece8b77d4116fdb1

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

