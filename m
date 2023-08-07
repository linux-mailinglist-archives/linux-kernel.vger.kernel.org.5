Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E177301E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHGUGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHGUGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E5E66
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847F6621BE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B1DC433C8;
        Mon,  7 Aug 2023 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438791;
        bh=SSM1IW9jKdCIrVPUXQN/lCIYbxBOIelAOuIFACndReQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qpQuyHFiZ0vcaEA5cpm8LQkCiuFbG4tzEERJkcL+NkMWX5DgFIVrytPbJhIN6on08
         LtQDbgcbHAIDRec+zT+VgPTBYhqF1lCbGv6ySiXWFQFvdzqd+tZ7QM44V+GZt5ReEH
         9caAtZ6mNbfV/HEeLKwEjiTIeCaSTgur5ZuEbVL5lEKLb/g2dGFbbQz9FWGUshY6Xv
         3nRq6IDa4HDIenU/7EAHtTJJUYLBfn36yRzy55eXUksEzSRsGR3Bg4eNfkr9xvXYvs
         TdJXF5vicWoSi8SbN7bad6qrRGov4x6Cn2K1h9KnMb5TQwDwy4bvQMpVxYBlDPMxsa
         HvLF3AzGogJKg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801102453.1798292-1-Naresh.Solanki@9elements.com>
References: <20230801102453.1798292-1-Naresh.Solanki@9elements.com>
Subject: Re: [PATCH] regulator: max5970: Rename driver and remove wildcard
Message-Id: <169143879055.313569.14143955536925488547.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 21:06:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 12:24:52 +0200, Naresh Solanki wrote:
> The previous version of this driver included wildcards in file names and
> descriptions. This patch renames the driver to only support MAX5970 and
> MAX5978, which are the only chips that the driver actually supports.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max5970: Rename driver and remove wildcard
      commit: ed2f4c745fb2bc51bb1b402ff2294587cb0b207a

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

