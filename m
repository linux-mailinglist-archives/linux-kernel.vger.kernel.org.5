Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48E7D0350
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjJSUrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:47:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C59E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:47:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B65C433C7;
        Thu, 19 Oct 2023 20:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697748469;
        bh=Xb8ykcuVXNXGLau7z0fj9oajuN6SQh3G7Mj8m91Dv94=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TWoVxoim6NNp6OOszT+ei/DEY6Rvy554zghlaTs4UpksXTep31g/IWOc4vLSYi8ZE
         1EaslWKC+Odf7Opuq1Jqq3LJf43BibPsEbaxVC11SFGbI9tN98CzzMBWr9loovTxbG
         k53aaH1o7rEXQqlPBfa5CAKbbD2ZfA4/dSZfoSOQKHHn1W3JATpKYO8s6rAt1ECY9b
         NEctmBdbuVut61apvmWjEQktpIvfzetJcdEgmpDNB9poYgZMyus64qAuZ/Wy5oowwt
         l2sXqoY4JZJTExCkunb4pHPEyAxRBoW53Zaie9STZV7oAuoIrTKhKTruIsrN7n3iGD
         aZvwLqSOABEuA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        perex@perex.cz, trevor.wu@mediatek.com, jiaxin.yu@mediatek.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231019100322.25425-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231019100322.25425-1-xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [v2 0/2] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: add
 rt5650 support
Message-Id: <169774846545.93224.1171196773910297821.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 21:47:45 +0100
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

On Thu, 19 Oct 2023 18:03:20 +0800, xiazhengqiao wrote:
> To use RT5650 as the codec and the amp, add a new
> sound card named mt8186_rt5650.
> 
> Changes in v2:
> - PATCH 2/2: Modify the code format in line 1058
> - Link to v1: https://lore.kernel.org/all/54ec6435-e69b-444a-a31a-c878a4b3564a@collabora.com/
>               https://lore.kernel.org/all/8de0772b-3145-44e3-8174-702c7dc729bb@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: mt8186-mt6366-rt1019-rt5682s: add RT5650 support
      commit: 8a79ff9e46beee03dfc2ce9cc80f7090f57d64cb
[2/2] ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: add rt5650 support
      commit: d88c433831015a4ad4597885cef8f048808cd94d

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

