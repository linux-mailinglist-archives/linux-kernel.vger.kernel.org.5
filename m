Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D67CD0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbjJQXlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjJQXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:41:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF6FE;
        Tue, 17 Oct 2023 16:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1EC433C8;
        Tue, 17 Oct 2023 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586094;
        bh=ud63s7V4RrXt+rW3zpF4iPUqjo7I9N4Q+XHSbTsG6tM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DVfW3DeRZWsaQ7wfguaPYMMtlTZX0TmcHy6XUS6c0fvpvhRvI4F1UAROKr+EVxPfH
         IxMOo/0MMMipu9JkLPDO24slywOLANWynkRGuPC2nKb/bHkPxwOb6UKDRPALZjStU+
         9jYlmPcgslTQKTeGSVvS9CZh2mlW/HFGsJm9C5jB0qSWea6L3g+GXEEr/XN/Vbu3+4
         rfig3YVkm87i+PZScYdg7seCZAQD9bMIFtj09rLIiBdaff6QSGfqKlk7Rq7T9xLU2d
         TdySJ+I1PW14hcJvUQZjq/WCMx6fGClCORQUoiEf64ToUy8vZtrM78x/+g1ug/XZ3C
         jeEq4zRpBpCXA==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231017203442.2699322-1-robh@kernel.org>
References: <20231017203442.2699322-1-robh@kernel.org>
Subject: Re: [RESEND PATCH] regulator: Use device_get_match_data()
Message-Id: <169758609148.3230422.9069339982126384846.b4-ty@kernel.org>
Date:   Wed, 18 Oct 2023 00:41:31 +0100
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

On Tue, 17 Oct 2023 15:34:41 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use device_get_match_data()
      commit: 8f7e17d847edf6bc02d0813b123b9d78ba504098

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

