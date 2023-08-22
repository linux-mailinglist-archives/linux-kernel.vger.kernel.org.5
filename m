Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF67847BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbjHVQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjHVQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD491BE;
        Tue, 22 Aug 2023 09:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F191D65CCF;
        Tue, 22 Aug 2023 16:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B73C433C7;
        Tue, 22 Aug 2023 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722023;
        bh=UX+Nwzp7y9yri/oe+EMe5TKeoQhdMDrPriA7Sa39xhU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CO7I/vG7R7dpRvE3rtRh50sc0mXDd4XcCYgUo4nVdqZMXtebaP3N4chd8rfv9cdYK
         16utyVAy0X/wdbI3ZWfzmf8XInK6n/YfL+e4mFPwRZfuNsAUtoCvZ2ivJa6i63dlEu
         BYfUsnZFite5w7ytnJodvTzYVCJUr3KSMCvF4tC+EhycmE9rSr2pbJ9FAC9UK+e++n
         lZaBy5Z3PjRG37vp9e0VOjTZ979hiKgZDM3K0rqsPyyhngo2UaxRHZB1eal/hrS8YY
         Da0DwkLhRdxKvMakbygDboWD8onH761rnqYmgHuSrhi8fxGFDYVi3xgUwIAOxI0Jq9
         c5t0kQ1Cx12ww==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        like@awinic.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
In-Reply-To: <20230821035355.1269976-1-like@awinic.com>
References: <20230821035355.1269976-1-like@awinic.com>
Subject: Re: [PATCH v5 0/2] regulator: aw37503: add regulator driver for
 Awinic AW37503
Message-Id: <169272202114.71818.13706933583974169859.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 03:53:53 +0000, like@awinic.com wrote:
> Add regulator driver for the device Awinic AW37503 which is
> single inductor - dual output power supply device. AW37503
> device is designed to support general positive/negative
> driven applications like TFT display panels.
> 
> v4->v5: Delete the unnecessary '|' in the awinic,aw37503.yaml.
> v3->v4: Correct yamllint warnings/errors.
> v2->v3: Switch to use the dev_err_probe().
>         Keep the Kconfig and Makefile sorted.
>         Correct yamllint warnings/errors.
> v1->v2: Remove unneeded fields and correct yamllint warnings/errors.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: aw37503: add regulator driver for Awinic AW37503
      commit: 2796a01cdf2c639e605088c53a1ac36923ade93c
[2/2] regulator: dt-bindings: Add Awinic AW37503
      commit: 86a1b61a0c7316febecd03d47eaf893eb5a57659

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

