Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C287EA3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjKMTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjKMTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A0D71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB5DC433C9;
        Mon, 13 Nov 2023 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904422;
        bh=IpoByWBgnZ9Y8umDh6gPWEOFaahmHU+Z8NZH/wvPrfw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WsZZWhUEDO4PUvCFOo5OHTpP4UlgIaMQIpl/D1KTsHPqSIRhNdzVVUMRtnC3gto5s
         pkYdqgXWsc0MAfzBqcIkZDBFTtsF0jqsg2FZ0BJnYru8kfR+4z4Nh71iU+S3TrYDJI
         Z3vsGd0G/kyJ1JS1W+oPUXt5GUJ6w7w9G5mB2+8C8HUgbU5xPPBsiWZ3KDrOTraSb5
         kjj8xEECk8oJai2IlYAvsjPQjIOTdVAPcD+IVOr1gqFmPKzaFR4SHDuQB1iUUG8aLk
         54vRPr4r5byc2SRWk1IyyIV50WHIS0RGwgxIV/slPpM7mOzWtG1wQPnrGWns2zjh1F
         JMbI668pdIQbA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231026144824.4065145-1-o.rempel@pengutronix.de>
References: <20231026144824.4065145-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v4 0/5] regulator: add under-voltage support (part 2)
Message-Id: <169990442012.3294075.3943279581886493793.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:20 +0000
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

On Thu, 26 Oct 2023 16:48:19 +0200, Oleksij Rempel wrote:
> This series add under-voltage and emergency shutdown for system critical
> regulators
> 
> changes v4:
> - rebase against latest regulator/for-next
> - drop mainlined patches
> - rename regulator-uv-survival-time-ms to regulator-uv-less-critical-window-ms
>   to fit it to actual use case
> - avoid some of words in commit messages
> - us switch case to parse critical events
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: dt-bindings: Add system-critical-regulator property
      commit: 0e1c8dcbdecefea93dee19419b2f67dca591dd42
[2/5] regulator: Introduce handling for system-critical under-voltage events
      commit: 8156c7dd47b92fc4a70c9ea58e7a9e88c8bc32be
[3/5] regulator: dt-bindings: Allow system-critical marking for fixed-regulator
      commit: 633cd1c0a9de7609f97c0c86e3ac81153e8263b0
[4/5] regulator: dt-bindings: Add 'regulator-uv-less-critical-window-ms' property
      commit: 759e2bd96971763db1cfaf6cafc07654b12aa21e
[5/5] regulator: Implement uv_survival_time for handling under-voltage events
      commit: 1e22152aa59d793743fc53051dd7a042f362aecb

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

