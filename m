Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D244276BA09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjHAQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjHAQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426892700
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA492614B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598B3C433C7;
        Tue,  1 Aug 2023 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690908867;
        bh=IAFDNF23zItXD9QC0XG9KyzM54Kbd0OXqlAs/NOfeIk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tli89NBX8RzJ/S4nkyO5qPX2k3tCvB+DZbmvbAhKLcxGPyXm/Yr49WuQyFJoAFOP9
         UnIXZ2gXpiu8GMNe/v7fAKqzhajO77e2LGtlB1LLgn3UV0aufaOkdwHohTCX2lV5IW
         +OAg/c7bzBf1U1afBNsndVs4p+akPwSww+VlMc+JeonTGYbcy8hu1T/dTtWZzzss1H
         YBkG0W+fA1ZyKTkd8P6s0+XMcdVxJ1V/D9trOscjyeaBVJQFoGy0AV2POsKu0zuoJt
         QeQcsOS5980Nx986lCq0MA+PsZ/c4EcBHAGDBYck3J8/qyDJplHPIV5IxbOMJI6Yj+
         pjR8BnWRC5mhQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     lgirdwood@gmail.com, okan.sahin@analog.com
In-Reply-To: <20230801130354.552243-1-yangyingliang@huawei.com>
References: <20230801130354.552243-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] regulator: max77857: change some variables to
 static
Message-Id: <169090886609.70332.15831728784398037433.b4-ty@kernel.org>
Date:   Tue, 01 Aug 2023 17:54:26 +0100
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

On Tue, 01 Aug 2023 21:03:54 +0800, Yang Yingliang wrote:
> max77857_regmap_config and max77857_driver are only used
> in max77857-regulator.c now, change them to static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77857: change some variables to static
      commit: 39b5ba6cb56962d2ac83e4dd89f68538f7861efe

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

