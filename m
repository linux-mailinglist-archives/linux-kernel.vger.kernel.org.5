Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7277658C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjG0Qdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjG0Qda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95A30FB;
        Thu, 27 Jul 2023 09:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBE8761ED4;
        Thu, 27 Jul 2023 16:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC5C433C8;
        Thu, 27 Jul 2023 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690475583;
        bh=0bmDrqdBNU+lM91YHrJx1FgQFfSmuEoLzE5acnoZ0AQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DTpkLFxlOF/4kUszccSnhwYDsaiSoP7K8U/SJo34OeH7WZcC+0rgIrQ3Sv0sQ+uj7
         Kk4ZS0QIJaSs/ugCAFEZAzzxL8YEH1+SIi9ln6mk7lUsK/EXNeItW1AEmISnPjnREN
         odyrHyvPuV7qubm8agHpQxXaUlIoPg4zIvH1oVMMdhw+8eOR5Z22JFh6xFGlXH0TWx
         apBfXxXx7DwKcO+ki3B2zKLKM1HxRefh/YB6Hb2NwwNCMSF/9bQ2kiUnTt9zRnG/JT
         mubfA0vLd7fuZQzs4ALxSwAdbseLD+nsdsRHCjRfayOI6LBCnxM742250Y1dpA0QU3
         oGvVN6XFlh/bg==
From:   Mark Brown <broonie@kernel.org>
To:     alain.volmat@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230727110558.2904084-1-ruanjinjie@huawei.com>
References: <20230727110558.2904084-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: stm32: Remove redundant dev_err_probe()
Message-Id: <169047558136.125328.1094627140074117868.b4-ty@kernel.org>
Date:   Thu, 27 Jul 2023 17:33:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 11:05:58 +0000, Ruan Jinjie wrote:
> There is no need to call the dev_err_probe() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Remove redundant dev_err_probe()
      commit: b505e2ecf31b6a2a62c76203558384d7646ab02f

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

