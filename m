Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3125C803A49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbjLDQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjLDQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:29:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634999
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:29:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC935C433C9;
        Mon,  4 Dec 2023 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707359;
        bh=kXALvUUA7C60RTiEvlmbNaLVBTs8Swam2ASKbF/SNa8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aE9JBFdKF0xPlg3i222eHc8zIytY35eCO0X4W70DEc7oWgBixullGaC8zJU5lSEDS
         TQZces5L21wq1mYm3b6HatKYGl95A5naY8e3Unq3A8op4DbfpCqzI2wjFfIiotLjtU
         s6kakKRXyOI1azUCmEAJ+vq6ILYHhWzMVkrxS+gBoIN1l4VskcAfbttWB9i0ERGNVJ
         xNDBdjLz1GrFwybIVXsK2yOR0yRYz16sw+cuvO+jRvDz/gVNaNNVGRl1TBjHPdT+tq
         RN93Zh/W2GUQCZJt8IMoDQmG2IvsJI1/NsfI6XlBwQ7m2STP3eMjsk8wxJHv4SsAu7
         efygr/RUpdH6w==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231201042933.26392-1-David.Rau.opensource@dm.renesas.com>
References: <20231201042933.26392-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Support low DC impedance headset
Message-Id: <170170735755.96782.4583489004118751914.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 16:29:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 12:29:33 +0800, David Rau wrote:
> Change the default MIC detection impedance threshold to 200ohm
> to support low mic DC impedance headset.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Support low DC impedance headset
      commit: 5f44de697383fcc9a9a1a78f99e09d1838704b90

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

