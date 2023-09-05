Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C679313E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjIEVtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjIEVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:49:07 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 14:48:30 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A70E42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:48:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66EDC433C7;
        Tue,  5 Sep 2023 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693950123;
        bh=2Iajz7evUFqefJ+Ul0Dd22EaqRmY10gsQ1dCN3caeg8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h0ECxCYhZL6DrKXu08nzNYIMTmvCxCGQ4K7ruSgE55Mn6fy0xifArqhGWNAAqA8Ne
         +88ZqFzExO51dLZtLqOfLDAI/5gXr5tC3yZFdojfpM7vK2zubAaSk57N38nV3FGThb
         IjTBZ/eHgpPb77pq4C91EQd5uX2pB53yk+4CbKKycwu1/Sc3tYj4xX+TN5DHv3QA2O
         auHGnWm+VxOt5cLXnCiQ5hvVSrLEU6xqaRwh2Y9kEag2hZutW7mMoSAvmY9lyag8Ci
         +sZX2069xJUs81UwSgiSp+zqbpnlXxoRo+fKdAXfwhEoUFf6nJMRp6DTq8d9FIuqc1
         rP+grTXvU3/CA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, u-kumar1@ti.com, jpanis@baylibre.com,
        khilman@baylibre.com, s.sharma@ti.com, aseketeli@baylibre.com
In-Reply-To: <20230828-tps6594_random_boot_crash_fix-v1-1-f29cbf9ddb37@baylibre.com>
References: <20230828-tps6594_random_boot_crash_fix-v1-1-f29cbf9ddb37@baylibre.com>
Subject: Re: [PATCH] regulator: tps6594-regulator: Fix random kernel crash
Message-Id: <169395012139.75721.16869885332079252742.b4-ty@kernel.org>
Date:   Tue, 05 Sep 2023 22:42:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023 16:07:34 +0200, Jerome Neanne wrote:
> Random kernel crash detected in TI CICD when regulator driver is added.
> This is root caused to irq index increment being done twice causing
> irq_data being allocated outside of the range.
> 
> - Rework tps6594_request_reg_irqs with correct index increment
> - Adjust irq_data kmalloc size to the exact size needed for the device
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6594-regulator: Fix random kernel crash
      commit: ca0e36e3e39a4e8b5a4b647dff8c5938ca6ccbec

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

