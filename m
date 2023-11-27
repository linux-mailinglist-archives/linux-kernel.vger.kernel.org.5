Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615F7FA807
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjK0RdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjK0Rc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:32:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700381AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:33:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7EEC433C8;
        Mon, 27 Nov 2023 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701106382;
        bh=alHx18ub8WTEqASpWQ5inqB+lbZ40Y9nPQczGy8nvOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XF/sdnisZg5P3UdX9lpfV8/unxqPZQmM/dCGAeIDzbVSZaGt4AVio7waFnEI04Trv
         D0Ud60uSK2DvLDNRs1XzgQ1ZohG7BhA7JFTmUHbQlcDn7qgrXL+b28CWvqFYX8wsgi
         5JOa/NkIo2rmk59YxfwX0VOzi1bOw0oZAzN4rq4sUqsEuaDBjUpSeTUfyP+HwkWXFD
         p+BFx+EYdcuhehek2dqrWL/wXE92yj+nQdMxf1BBuHOGbr8BsmoIyo+P1O5iNaF5Nt
         ALrpJfB0+RZujK1i9upWojc4lPe+ITYNU5BR59GmYnLDr35TlklihCiUuQEhgajDE+
         BO8RJCUDlQ1TQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sound@vger.kernel.org
In-Reply-To: <1a837f96f056fa3dcb02a77afa5892d40b354cb1.1700417934.git.christophe.jaillet@wanadoo.fr>
References: <1a837f96f056fa3dcb02a77afa5892d40b354cb1.1700417934.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: sh: convert not to use
 dma_request_slave_channel()
Message-Id: <170110637716.2700573.7780212475414653746.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 17:32:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 19:19:14 +0100, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: convert not to use dma_request_slave_channel()
      commit: 076357cd57c294fb185ac452b9ce5536b2853839

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

