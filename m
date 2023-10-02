Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3F7B57A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbjJBPli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjJBPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:41:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7430AC;
        Mon,  2 Oct 2023 08:41:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB66C433C7;
        Mon,  2 Oct 2023 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261293;
        bh=IJef45iiSUwLCelIrGKpbPKJ/a6DbHY9R0upJa+MNeE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ow1PcRfVyHawjKORotYFEWxM6PAuElIiWDWCKb4PZ9yyTp34Fc7KrcyKj4pXY2d8F
         XNsWFwI9ucKXXJFSbcODXuQlkNl6e7N7heRHHBpwoPTgj9t6kCuDwsjOQIkgss5S2t
         RlWh4g9jYKCt6twutLUxNAXmsAdCjXwEWu23A/Q9LD1ISMwRsJ9uoPBfz2FD4/b+3O
         PIh5MOkPtZNfx2svGVlgCllcOMLIoyjX65qaOGU8eIf6VXyEsOQn3hCDDDpkPl+6UC
         3EOX8SiVjXw/QddL6Jq1oJlBE6u9xNcJ4Qw+0LnQY9aqHNRevtziz547Bz3cESatan
         VDqvt20nv67sw==
From:   Mark Brown <broonie@kernel.org>
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        joel@jms.id.au,
        "William A. Kennington III" <william@wkennington.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922182812.2728066-1-william@wkennington.com>
References: <20230922182812.2728066-1-william@wkennington.com>
Subject: Re: [PATCH] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
Message-Id: <169626129142.73782.530918104356513259.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 16:41:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 11:28:12 -0700, William A. Kennington III wrote:
> We don't want to use the value of ilog2(0) as dummy.buswidth is 0 when
> dummy.nbytes is 0. Since we have no dummy bytes, we don't need to
> configure the dummy byte bits per clock register value anyway.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
      commit: 2ec8b010979036c2fe79a64adb6ecc0bd11e91d1

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

