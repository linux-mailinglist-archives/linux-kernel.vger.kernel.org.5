Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFECF75F5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGXMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjGXMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609A10D8;
        Mon, 24 Jul 2023 05:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEE66113A;
        Mon, 24 Jul 2023 12:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03528C433AD;
        Mon, 24 Jul 2023 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690200848;
        bh=bGBRTBKOATzDrEOLC9veX6A/VYAHXhkdefmlUImW9tU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o2scgzlSqub0MwzcjE1YF2PBthEw88BjAeDWf84QFg0ANrTZu0+TOaCqxd0tWSACW
         JfIqaWP9UXLSbbSRGW1qnCFcf6vzvXIYXSXU2SZH6ZJxaUvi2Wt5Lpe3C36HktZZAq
         Sd3O7EynHqvMKuoyGHjzjjvJdQlWzOnX9eURPJq0zSqABfjfJ7cqBz0R9JPBNDojmO
         qpmo1wXfjD9pkmgthCGUSMKYJKg4ggnPykOgIPs0O+9zZnV+KLQ4BoNVG2iI5anqn/
         XWhp5QKpbBR/MKkQg7N4uJ95xHNmT4qoayu0sGkoYFifHW7QX1sqNX8SAlmtIAhG8F
         pcHzS8P0w/FlA==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230721082903.2038975-1-wenst@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH RESEND v2 0/7] regulator: mt6358: Remove bogus
 regulators and improvements
Message-Id: <169020084572.59430.14695443221622565365.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 13:14:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 16:28:52 +0800, Chen-Yu Tsai wrote:
> (Resending with Lee added to recipients)
> 
> Hi,
> 
> This is v2 of the remainder of the MT6358 regulator driver cleanup
> and improvement series. v1 can be found here [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/7] regulator: mt6358: Sync VCN33_* enable status after checking ID
      commit: 649fee5a17a7f96152fee2fb9111d9a4db535f35
[3/7] regulator: mt6358: Fix incorrect VCN33 sync error message
      commit: 67cb608838e0aac8efb48828b1165156f99c1af9

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

