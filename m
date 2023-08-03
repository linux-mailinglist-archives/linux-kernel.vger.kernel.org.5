Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8B76F065
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHCRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHCRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD6211D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6EA61E4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C906AC433C9;
        Thu,  3 Aug 2023 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691082793;
        bh=wqRU4la2I1zAVvojcwQ8ciMbUWGKh+voan3Z4ZjmsXo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QM3qzZcYvFjGqoFN+n7FRwOEmpdl240onbLdOI8wwB+LA/VycBm5jwDOpc7od64RE
         8GS6gCmhUfJOJEtbAJ8Ys+niEPh5uPQHrWo+SHU7SvczdOaJgnFNlMZWJC8YCM+Yj3
         Aw2eij9iuFFbCk7FBlEGTBKsuRAISqR3KcCPFAGdA71Fzp2JJKkp5oFrHqsqEha55t
         cmxW8YFYMGQPd35stSdYO3s8XeL42yoWQZ3dwOy2HIcSdenNdxOlu8NpVZtRt7jd/I
         X+FllddXEgSORgZ5lWAXsy8FGQOCBsjijCfgmkO4c/D9nTJ9+bambq0ah40osdEDAB
         k5O410ysdtLXw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     lgirdwood@gmail.com, okan.sahin@analog.com
In-Reply-To: <20230803113654.818640-1-yangyingliang@huawei.com>
References: <20230803113654.818640-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] regulator: max77857: fix build error in
 max77857-regulator.c
Message-Id: <169108279253.101361.17554873393558395381.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 18:13:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 19:36:54 +0800, Yang Yingliang wrote:
> When using low verion gcc(7.5) to build the max77857-regulator driver,
> got the following error:
> 
> drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not constant
>   .ramp_delay = max77857_ramp_table[0][0],
> 
> To fix this by introducing a macro RAMAP_DELAY_INIT_VAL to define the
> value of max77857_ramp_table[0[0].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77857: fix build error in max77857-regulator.c
      commit: 93083725e1ed86c07ea9846bb573b9340985853f

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

