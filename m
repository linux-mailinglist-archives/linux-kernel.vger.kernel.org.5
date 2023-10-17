Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540A7CD0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjJQXlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjJQXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:41:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E35C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:41:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471F8C433B9;
        Tue, 17 Oct 2023 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586091;
        bh=gEpsAedoVQqbK/cPBT6V4Nnnu5GxUH06Rj7iKV2gt+w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=toTIKffmLaScVl8xvPIEY7lbXF8fcYoHtYrgm5TY98tdQSHUMKhmYtCVvG2F0rsKd
         xgaj1Zovo6RUtTg85Gf0Iby/vAQlafAQ46dDmDubU4uQw6HA+Q0hFNYy+CYY/+D1U4
         DqDZbUq47/J2Ua87DUFvuY7ERScbtcDRhzmzrp+LI9AxwOyELaNRgLH9dXmT5/p7C2
         6n8ABm800kaF7wBYzcRn5OJkPRWanAJcZ7cSuDlW0ylXAh3N7FLmYoygFv4yuhl8Jp
         YProLznewgw/upLDtWwDG4RbTmOndc7ImyKosPH3Z0osVhJEBXd+4DZeB6xy3gVFWY
         vnX+2Jl2HL2dQ==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231017203429.2699039-1-robh@kernel.org>
References: <20231017203429.2699039-1-robh@kernel.org>
Subject: Re: [RESEND PATCH] regulator: da9121: Use i2c_get_match_data()
Message-Id: <169758608999.3230422.1301041830416356282.b4-ty@kernel.org>
Date:   Wed, 18 Oct 2023 00:41:29 +0100
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

On Tue, 17 Oct 2023 15:34:28 -0500, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() to get
> the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Use i2c_get_match_data()
      commit: 46537a8676d6555141c4b98ec1bf5f3eea971128

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

