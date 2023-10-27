Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF87DA3C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346736AbjJ0WzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjJ0WzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:55:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460F1B5;
        Fri, 27 Oct 2023 15:55:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB71FC433C8;
        Fri, 27 Oct 2023 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698447300;
        bh=jpoAMGT0r13NE2Y4M1CX9RBspLXKW8zxy8LzdHWC3/c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R+rTmGoz4czPipBCmyBDRkBGAhN8cP+Yv1fvU9kEahWmdgSNuuUaPiroCEN13UQQw
         3MhGKnvSDySPglPOcULAhG/4BFvwdNIf7FEnVrZfM4VhMC4INU5b4yaNyfKHMKpb6y
         zsCMgv3F9XfxRk462si9JjYAfiQeh2D+stJuXQfLXNBKbArproUvRJRg9BtR+wG8LB
         u7qTF1VLnvrBJKQKB52sMQPjKRvb3ASR2NLYV+3o2fpsPdJyaeM4eaDjNHk1vdmBYr
         fIvOUsB6rd6U+OUaW3ufbaL+mIiE9XxrK615dJvnvjX5V7Rv5t1esidBhhiQS9A03K
         zz2v1aMoFE+Kw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20231027152830.1269895-1-naresh.solanki@9elements.com>
References: <20231027152830.1269895-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v6 1/2] regulator (max5970): Add hwmon support
Message-Id: <169844729861.3013735.16623433333003690278.b4-ty@kernel.org>
Date:   Fri, 27 Oct 2023 23:54:58 +0100
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

On Fri, 27 Oct 2023 15:28:28 +0000, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator (max5970): Add hwmon support
      commit: f5afdd13ed6c643c7243e685fe3cf5484b3fdfae
[2/2] regulator (max5970): Remove duplicate line
      commit: 804bf07a1f726d4fe391d21b24a68ffc2381ba89

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

