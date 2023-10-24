Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78D7D5AED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjJXSxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbjJXSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:53:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E016A1B3;
        Tue, 24 Oct 2023 11:53:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79C4C433C9;
        Tue, 24 Oct 2023 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173610;
        bh=3tIsULG9clFoEJihk8khIpm9lSY2diH297dFAOUkrp0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RBUDhfwN9muAxF9xHPSrmeWIBOMABgsoM5bUwNFdPaoV/H2b1RQNoQC94B2nLzDPH
         iiiyrSuMI3AoktCE5eXXlRiJfT0LYydLAygxJV7W1maa0ekfiYHVQIOgz/cRLIh02G
         1uweraEHM8DADam8IiLpeeNOvxvl9vyx+NLTtSHoDnY0V3BnMQ8Eo9V/pxWNef1s8D
         GQMud0ALBpvyxnytlpzWWDZjLOAFN1lrrI4YkWx4jGcmdtoiE8gkp29Ynsrh50gRLd
         dd/zzcVNeYQWPK5wXeqpeBrrg2/ikkfTPjrpnwAx8r3BRpW+eiX2LwFqIknxJ7bSdq
         hC25blxVAMseQ==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231023154917.671595-1-colin.i.king@gmail.com>
References: <20231023154917.671595-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: codecs: rt298: remove redundant assignment
 to d_len_code
Message-Id: <169817360865.82257.4197167510702272746.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 19:53:28 +0100
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

On Mon, 23 Oct 2023 16:49:17 +0100, Colin Ian King wrote:
> Variable d_len_code is being initialized to zero and then re-assigned a
> different value in all the valid cases in the following switch statement.
> The only place it is not being assigned a value is on the return for
> a default case and in this case it does not need to be assigned. The
> initialization is redundant and can be removed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: rt298: remove redundant assignment to d_len_code
      commit: 91e174fc04b1975b0e4d431a7020779635ff7c05

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

