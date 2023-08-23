Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591DA785D31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjHWQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjHWQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C88170D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 108CA6463C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9A7C433C7;
        Wed, 23 Aug 2023 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807993;
        bh=8Xz6d0pCiUX4KhFmORKGtMWROmdOQ3gU3+kJBggSQS4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YUHOeWi0Z6XaAUuJzg/WmoT+EukUSIPeOpFqtRzVLd6qRFDm5xt6aOEFEhE0vw82j
         JF7vBeZQpr+gte+lOn4nI717EP09IJVkQlzP0/Fy4g02NDo+u+e2RMPMGZwL/BFtG4
         dEZ0lSEzXEL0D3HGCa5ZzmdStlizbzPqRG+Qri3foNQaR4PsNuRohOgcqBUBC8t3YU
         wf5nGfaJQYlhvnknUjzGSh9jVooHAb+sn2e3/LxFfqXnVqkOQVtG7uObYWpIUVVF8t
         LeO9zmMjV7XC+TgKfyoiq02XFTpVB0GBS0J4mS0wIoHTsCQJj8dA+gW0evXOgh0wNV
         bZCrsmYii/vfA==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230804083514.1887124-1-martin.fuzzey@flowbird.group>
References: <20230804083514.1887124-1-martin.fuzzey@flowbird.group>
Subject: Re: [PATCH] regulator: da9063: better fix null deref with partial
 DT
Message-Id: <169280799204.53966.2725365832263200294.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:32 +0100
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

On Fri, 04 Aug 2023 10:34:30 +0200, Martin Fuzzey wrote:
> Two versions of the original patch were sent but V1 was merged instead
> of V2 due to a mistake.
> 
> So update to V2.
> 
> The advantage of V2 is that it completely avoids dereferencing the pointer,
> even just to take the address, which may fix problems with some compilers.
> Both versions work on my gcc 9.4 but use the safer one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: better fix null deref with partial DT
      commit: e4eea71222725b7366d61ce7a9ce35202d8a6dfa

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

