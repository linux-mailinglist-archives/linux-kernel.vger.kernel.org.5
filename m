Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D67DC04A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjJ3TUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJ3TUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:20:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADEA9;
        Mon, 30 Oct 2023 12:20:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928E7C433C8;
        Mon, 30 Oct 2023 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698693633;
        bh=hvnFWiwDyeUV5ubEK9oHUg2sWcW5EpgpZngLeQIpoMY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EJzgFNmYO53E10LQkruS2JsXQZtLvvKbm9vj7nl/74BTKiDlxt0soP8CJX9uB060J
         tOMtLpXUyM8O3fIowI/N34vI8ucBg4vcI/2tznGIUHvECCTN9kqVA/1Vkf9+M4V5jo
         yAYV2jA60EBQzZJv35lejkGjN3jcnaHb+ZbVODCOZok34TYymzvVPM/RUbT5iFjPmv
         fwLgubHrrQ5LuE1jIrkz+oFFq50M3mxyaHaAA0bdwajqz4oP7fPNMFoLuypgpqtwKR
         /aSMJNaDF505q5+Yc6P7RUHcw5b/jZeECUlw4Wz7enpXLdUlxVXnUZmjRBQLWCh0RY
         7hx91YEjzQJtA==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231030142337.814907-2-robh@kernel.org>
References: <20231030142337.814907-2-robh@kernel.org>
Subject: Re: [RESEND PATCH] ASoC: rockchip: Fix unused
 rockchip_i2s_tdm_match warning for !CONFIG_OF
Message-Id: <169869362917.44249.630029762300338773.b4-ty@kernel.org>
Date:   Mon, 30 Oct 2023 19:20:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 09:23:38 -0500, Rob Herring wrote:
> Commit 9958d85968ed ("ASoC: Use device_get_match_data()") dropped the
> unconditional use of rockchip_i2s_tdm_match resulting in this warning:
> 
> sound/soc/rockchip/rockchip_i2s_tdm.c:1315:34: warning: 'rockchip_i2s_tdm_match' defined but not used [-Wunused-const-variable=]
> 
> The fix is to drop of_match_ptr() which is not necessary because DT is
> always used for this driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: Fix unused rockchip_i2s_tdm_match warning for !CONFIG_OF
      commit: 04f8c76de983a5c1e8913e442e791a9e8d0e0dfd

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

