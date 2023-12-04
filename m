Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4E803A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjLDQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbjLDQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:29:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8399
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:29:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97740C433C7;
        Mon,  4 Dec 2023 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707364;
        bh=vhrxUvsCwsaGYvyyei5h55J9yp+nmIcuFyO/lJGVsJM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nlfqs1xKZp32xjV/6EKDBJ2qWN4k1GrusvYA6y+pDG1Nj3WAKnOLkUcGrPOZ0OGXz
         G3GpcOBo/LbTOymRzzN87kHGm/k9MEmu2KVNhy+o0ANyGkKUPya2AQF1H4vW3ZOJqJ
         hWr/bdZvrddYY7MeY6IAo/X9/v7xnSTZ9vj6VfispDV3rz3aQUHdFTYPjwuXB6KzoZ
         RMslHsfXUZZL/2rLamNH2sudBW3P7VJyae7PSnKlRrawgvr6wNMZRFf9tRu3rjxX6S
         ygYFPc/AcGJOf5wewz6kWRLZs4+R39dje2xLi6wgmnMF/f+XA68ImNDZmAOIdINyn5
         shTvUc2qSCt+A==
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231204074158.12026-1-dinghao.liu@zju.edu.cn>
References: <20231204074158.12026-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
Message-Id: <170170736133.96782.15219793902912289690.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 16:29:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 15:41:56 +0800, Dinghao Liu wrote:
> When wm_adsp_buffer_read() fails, we should free buf->regions.
> Otherwise, the callers of wm_adsp_buffer_populate() will
> directly free buf on failure, which makes buf->regions a leaked
> memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
      commit: 29046a78a3c0a1f8fa0427f164caa222f003cf5b

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

