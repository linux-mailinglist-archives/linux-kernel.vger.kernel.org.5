Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4157A0267
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjINLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjINLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351D1FEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8DC433C7;
        Thu, 14 Sep 2023 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694690382;
        bh=ecaTzIFO43R+JdO9sreiQ6O5aV7ggwAdyxXyH65zNL8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ucop6zmJGTt+OBbpAjlJAu9AJF2JHDvoExkPbQRRhWe5OK1y0UgFPyIlG5yhb9aeY
         bZCkB6rSQVcjP7Is7UcQsVuzV+eI2nceYg6h7clbaPe0SnV9t1FKcuPnVCDB7hXNDL
         iRLERa+8QWlmONKAYWk8YqBr9LUMu0q7dlMbGLfQahB2NlDzZGXUGOkiy/RDRzG/of
         4w7wrUw/bRkrCOxteII2DtXfIz5UD+n1Epq1l6TlaqlfR61+C7LZM2/S2Etvdc9ogi
         NbgC1F2ZvIEm4GjJ59ClODcHwDn+DwR1MwI+o977iikUmfcOLmyl+26uHwQR983EGG
         nrrh3yfaotaYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230913160250.3700346-1-rf@opensource.cirrus.com>
References: <20230913160250.3700346-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix missing locking in
 wm_adsp_[read|write]_ctl()
Message-Id: <169469038143.23670.735867835837223806.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 12:19:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 17:02:50 +0100, Richard Fitzgerald wrote:
> wm_adsp_read_ctl() and wm_adsp_write_ctl() must hold the cs_dsp pwr_lock
> mutex when calling cs_dsp_coeff_read_ctrl() and cs_dsp_coeff_write_ctrl().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()
      commit: 781118bc2fc1026c8285f83ea7ecab07071a09c4

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

