Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E38752B96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjGMUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjGMUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426B2120
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C2B61B5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E24C433C7;
        Thu, 13 Jul 2023 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279870;
        bh=kkxEVsFpxLFmkOIaEjOsbvsOMuhsZT6M+GMCb45RIWI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kneg8zHx+hczlkdbDOAlLG0jYulwZU1z+mURlVFWmx7JyAb4ld/rKScR3tUXjsqgT
         vlgXkyDllZZH3Ey5KqxAP6Eb8lxIjHsNab1aqXL24ykRHzibYALxafv/p9IpEMRNX6
         pCNIO4CrlQcfjMI7SIFOhWg5NgLsgOdgcORbvKyt+a6UQIGI7n37QAgbWZaUxnbn2V
         jX9ScytDLiWd+/Vgzmt+PFV+HlKYPuTMhssfbsODRBvmdbfQCsvb12QFubnsggYL7x
         g/wS9Q5VbTiTJus5jCRfmpgB5tRyJlvVufM5kVJ9hDh8MR/XoaELqoSbzlJXeFk0GW
         f6Fzj+Xe2YIVw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230713151744.86072-1-minhuadotchen@gmail.com>
References: <20230713151744.86072-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH] ASoC: q6dsp: q6apm: make g_apm static
Message-Id: <168927986901.272917.8038940288958107240.b4-ty@kernel.org>
Date:   Thu, 13 Jul 2023 21:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 23:17:43 +0800, Min-Hua Chen wrote:
> This patch fixes the following sprse warning:
> 
> sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: warning: symbol 'g_apm' was not declared. Should it be static?
> 
> No functional change intended
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6dsp: q6apm: make g_apm static
      commit: df43fba7c75545094639be42a85502634f075a19

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

