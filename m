Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280B67CC9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjJQRjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJQRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:39:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC890
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:39:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A258C433C8;
        Tue, 17 Oct 2023 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697564384;
        bh=tbY7wgGRlO6v5IUjQhW+hckUTRT1IP/RqORMcLcgk+8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SwIVnnEeSl3s6cGRsKx8rDN9O6cfILhT9uiTQpr4+svVReYz3okZbW6PfgYQMJf1t
         hKZAZNxjj8ersJiDzQoE5PFs8vUL+zpznTSuDprjCVQQ3ZI3fadEJ7VgD7qxTj6CnW
         2c6On+F5wHiovG2jjc1ye3vC5heV90Y0CkXbFdvnI5p8Oqa/MYjaGnfFDQNuQO8cKW
         Anbb7VaLIV2t6N9Etk15JCVoX9ZSmP6oUfqk3pBHVsmVJX4Lbpax8hPVcq/iLMx6p3
         +Q9X9hDttPCdj7BTRjY4iiTDqJj9UowiDqhORG6r2xKD0WpkxugEpyRLI0dXpyBt+e
         t+pwuWqzFJUfA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231016155547.2973853-1-robh@kernel.org>
References: <20231016155547.2973853-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: tas5805m: Disallow undefined
 properties
Message-Id: <169756438301.1863854.2005606398222182933.b4-ty@kernel.org>
Date:   Tue, 17 Oct 2023 18:39:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 10:55:47 -0500, Rob Herring wrote:
> Device specific bindings should not allow undefined properties. This is
> accomplished in json-schema with 'additionalProperties: false'.
> 
> Examples should be last in the schema, so move additionalProperties up
> while we're here.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tas5805m: Disallow undefined properties
      commit: 086357275fc7635c5a2856c667b3d2f7604403fa

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

