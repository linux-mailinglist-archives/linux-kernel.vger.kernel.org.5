Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BC7BBDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjJFRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjJFRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:45:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EDFDF;
        Fri,  6 Oct 2023 10:45:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5453EC433C7;
        Fri,  6 Oct 2023 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696614346;
        bh=m/31zFx7p634FZoa2MB8a6EcMoxskB9XZBiy1PLjgOk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B/PJGyD+If0/sLWCL2ewd9s8znH0Je7ZO5+re0LHtj7XzzuvsVufHlboeIqrHBQRZ
         94EFi+GRwgUumEo1a+eflgD7LxuOmA5E7ANj8kferjRHD4a2SatqVCgV/deBJ7gKTe
         dL2wTNr3oBwbl6IDRcnq702GUzEttpKZAYHF8817Kc0dCt4Wt74DEr1Ot5W4wU3SBa
         5x74Qy4C79KKvo6zApL28n25Txfsp2C/CooZENn6rfhshAACPr2JIfc/C9B/tlWmYH
         ob/CnqqSSf/Ed48cVFsgmzSfCGd6TpBcuVHuMsxWpyMy6zKP78invleSwFpQRICv+g
         uWTkYnxGd63VQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <2023100639-celtic-herbs-66be@gregkh>
References: <2023100639-celtic-herbs-66be@gregkh>
Subject: Re: [PATCH] spi: spidev: make spidev_class constant
Message-Id: <169661434501.222776.95310349603374179.b4-ty@kernel.org>
Date:   Fri, 06 Oct 2023 18:45:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 15:58:40 +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: make spidev_class constant
      commit: df22568ad8ed317db95acc11e1c08bae7a0fba5d

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

