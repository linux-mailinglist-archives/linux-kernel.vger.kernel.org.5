Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736267EA3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjKMTml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjKMTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D51731
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3EBC433C8;
        Mon, 13 Nov 2023 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904435;
        bh=nx7dxtYmjGRBmy753Kk0BhkvpRXqbIqSxx3MC3Ik8I8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T/22qNo46KR1wKRMTgq3Y4HCmF10vBRyry/NV7lYdqiNZ26YUU6WfdC63ZNiIvAMN
         lHdSYG9rrViPgc5ZhSfWx0eRjk0dNv/qklW8QjRImxLo+MGweTuD1HmkB2cW8QGL17
         QkF8DU8K1gy5/jbiIC1e99b4OXi1MX5B2AsUiMWEisYmFF8a696/js4AoGbFjQc2aN
         Wi1ZMbTOJyqayvShm75TGkGo5JFD+LoNs0sse5rPlccij1k/qO8oD0Fzlo6P5Db/H5
         WEqwCaJqpwKuhnPNT9zfv1teJ3YZOcZAzFqPmKeO3zABQFuIQ0ixmmS12KeWLIcVjx
         4HgJ14r4LjMqA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20231107190926.1185326-1-javierm@redhat.com>
References: <20231107190926.1185326-1-javierm@redhat.com>
Subject: Re: [PATCH v2] regulator: core: Add option to prevent disabling
 unused regulators
Message-Id: <169990443197.3294075.4873136953876130203.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:31 +0000
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

On Tue, 07 Nov 2023 20:09:18 +0100, Javier Martinez Canillas wrote:
> This may be useful for debugging and develompent purposes, when there are
> drivers that depend on regulators to be enabled but do not request them.
> 
> It is inspired from the clk_ignore_unused and pd_ignore_unused parameters,
> that are used to keep firmware-enabled clocks and power domains on even if
> these are not used by drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Add option to prevent disabling unused regulators
      commit: c986968fe92f20f2db26fa6bce27795b2e9ebe22

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

