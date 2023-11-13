Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA67EA3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjKMTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKMTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2ABD6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82143C433C7;
        Mon, 13 Nov 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904426;
        bh=6Ey5FD6cD8DD07OuQnycttxlCN15n2sNu8xYKDtX44k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ot1GGpWSqbRHsMZ4H0AmB0kiKmsncGDemrMZgeUANDBqxnSBsPlXtVHNLwWUVepvE
         OGLKYHaHTW8chhxYUPnrTeL0dVPOUOLAKo4OGZtAN1GUP7+RRGploR6exNXPragTHM
         3KSpPjzAWkqVfQQCJVwMZ8lfCOuAHOZxCo+jUm1E7kgAJo7/lJdO8/OQ7IuxhFIMNX
         Y8Cz7wfeu02bISpUqd2zeENEg9g0yPjpyqk0oSG7C/2sH19CKNwy207VADeVb0U9yS
         3gr4N/imrTDW8teHJTTUtxxx7envW4iJrCoAZaUZ91qC2wcqwFH2Z1rnmiZnZ+hFRi
         HcEKzbE9rKgVg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org
In-Reply-To: <20231028102423.179400-1-javierm@redhat.com>
References: <20231028102423.179400-1-javierm@redhat.com>
Subject: Re: [PATCH] regulator: core: Add option to prevent disabling
 unused regulators
Message-Id: <169990442285.3294075.7217773943260715696.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:22 +0000
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

On Sat, 28 Oct 2023 12:24:03 +0200, Javier Martinez Canillas wrote:
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

