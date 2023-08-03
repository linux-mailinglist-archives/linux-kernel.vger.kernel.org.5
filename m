Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25A76EF00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjHCQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHCQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7751BD9;
        Thu,  3 Aug 2023 09:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 075F361E2D;
        Thu,  3 Aug 2023 16:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9585C433C8;
        Thu,  3 Aug 2023 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691078828;
        bh=2ysWTyQQDcDgRN4umSoNYqrm4bVY3O6jpAhY0GjhzaM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bgkFejYMRDUhw6Ck0ycUTLUMc0VWt7hRnbN8D0EyQ/SVxJVOMtzPCUonOyB2se9kh
         hi7qAJc6JxOMW4uEDWY3cBvQYIAt11Q4nNVE2wh3xZYm+ldy+iaLb1YnAjF6FB91Kk
         s/HR1TaYiN2XAfMX8K2Ev0q1qP03vVDQLuSVTFD1CPq7nvNhrFiG0h/zYdniB23oG6
         3H8jl9qeT9ihDeVvwJW2LUQbAg8198Kl0rHalhpfjfg5bm+Ypk6DtqdBA7aK47HNJi
         HInIuIzV+/dBGypGH/Z2VpAwBNdwTU1oWqMtZQ5R0kGTdj6ARJmndgscRcsUi3YFXN
         Gn/1h2/FkUWCg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhu Wang <wangzhu9@huawei.com>
In-Reply-To: <20230803083944.21501-1-wangzhu9@huawei.com>
References: <20230803083944.21501-1-wangzhu9@huawei.com>
Subject: Re: [PATCH -next] spi: fsl-spi: Do not check 0 for
 platform_get_irq()
Message-Id: <169107882741.87002.3144423833085038986.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 17:07:07 +0100
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

On Thu, 03 Aug 2023 16:39:44 +0800, Zhu Wang wrote:
> Since platform_get_irq() never returned zero, so it need not to check
> whether it returned zero, and we use the return error code of
> platform_get_irq() to replace the current return error code, for that
> platform_get_irq() may return -EINVAL or -ENXIO.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-spi: Do not check 0 for platform_get_irq()
      commit: d8736266ae960504110e812994f555bf7cb8740c

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

