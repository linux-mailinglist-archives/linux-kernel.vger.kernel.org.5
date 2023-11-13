Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B67EA3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjKMTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjKMTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB91715
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D043C433C9;
        Mon, 13 Nov 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904428;
        bh=G6PKgQtz8805hVqW0i5l08lx3FN3h99bg9hgAh05Jb0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P6ekzNSYhH7hv6W5fZHpM/A5HHPn9wiYmuCUJgPvKHYZvggnqwhgbIHcWFFIcSK6i
         HKqzveB/3XKPiMdOL7W1UbJK/ChXyoPRrBFHmbtpRYzuw2Wg1ienI98h129A7AQvb5
         yLdl98kGElQbunj4TqZIe8+tsMyu1Y/o6R91tjBwfTUXCTV/k9bVMpL0o6+ta/jg46
         za8h77owDDcZc7hJLWsmb/qlVQDt5FAOF6Q3SncAr8dtSPY7vX64BIb5vyYGBbr9PK
         bnh8n8/2B/ULzxvy4zKdaWtqJ7EMYWFYlHH+qENKlpBGJUMjyScawdW3yvNaPMPojY
         9WlJ9WS/Z6Ggg==
From:   Mark Brown <broonie@kernel.org>
To:     Rui Zhang <zr.zhang@vivo.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        opensource.kernel@vivo.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231103074231.8031-1-zr.zhang@vivo.com>
References: <20231103074231.8031-1-zr.zhang@vivo.com>
Subject: Re: [PATCH] regulator: core: Only increment use_count when
 enable_count changes
Message-Id: <169990442645.3294075.15451821190104431010.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:26 +0000
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

On Fri, 03 Nov 2023 15:42:31 +0800, Rui Zhang wrote:
> The use_count of a regulator should only be incremented when the
> enable_count changes from 0 to 1. Similarly, the use_count should
> only be decremented when the enable_count changes from 1 to 0.
> 
> In the previous implementation, use_count was sometimes decremented
> to 0 when some consumer called unbalanced disable,
> leading to unexpected disable even the regulator is enabled by
> other consumers. With this change, the use_count accurately reflects
> the number of users which the regulator is enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Only increment use_count when enable_count changes
      commit: 7993d3a9c34f609c02171e115fd12c10e2105ff4

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

