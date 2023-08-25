Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD678832D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbjHYJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHYJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792621FC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183C6672C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB13C433C8;
        Fri, 25 Aug 2023 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692954789;
        bh=B+VjRHqsEjAeOSECY4FvbLFZFh5M1dyRTYeH5Vx1VRI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OyqFugPjkPFP2X03Uk2HURr9/hbDKlcx6BlbnvDzCS9Je/dtOD5svfzr7sBJ10Hug
         xo7yNaH6ETtxs3zU5N4up8iqozUPcujZ140L/MT9I5t7Nn/jz4C45MQdGwwkVIe52A
         xKFAS9V8bAQE8zDcHBDECO3WEoJ1N/yJHlFFWxvZeYLcGQ60rjO26FAwdJz1Fal8VQ
         a8FMYE7cXV12gxvvVg5s8Me+lxpyhNtw+lFRXAV2oT30jx9pfpthAUSdHqUvgNGtwe
         hDMXwz+OfZe324ETF0EMCIKNNIFdkiCUO30pARSSL5DRjrtxHsBy7SplRG9F6xSckF
         6yJFfh39q44CQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Zev Weiss <zev@bewilderbeest.net>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230824-regulator-remove-status-sysfs-v1-1-554956e8c1ca@kernel.org>
References: <20230824-regulator-remove-status-sysfs-v1-1-554956e8c1ca@kernel.org>
Subject: Re: [PATCH] regulator: userspace-consumer: Drop event support for
 this cycle
Message-Id: <169295478515.3002371.7286702124585709391.b4-ty@kernel.org>
Date:   Fri, 25 Aug 2023 10:13:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 23:48:22 +0100, Mark Brown wrote:
> Drop commit 22475bcc2083 ("regulator: userspace-consumer: Add regulator
> event support") since Zev Weiss points out that it leaks the constants
> we use for notifications out as ABI which isn't ideal, we should have
> something more abstracted there.  There's a definite need for this
> feature but it needs some more work on the interface.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: userspace-consumer: Drop event support for this cycle
      commit: b96c22476ff4bc3459933f87ba52cbb7910ffc6b

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

