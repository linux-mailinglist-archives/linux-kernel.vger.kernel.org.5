Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C48782B91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjHUOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjHUOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59833DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846DB63964
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08FFC433CB;
        Mon, 21 Aug 2023 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692627637;
        bh=ZTiyrFRES0C6jjS2YggRyQ77P4AYbTu3g1kOaPAlESA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZGLZjQbLYOeU80r+tBvdx8mVReNzg2nldyAA7mZq9nx/YUm8VqymzOaWsqB0neckZ
         yTDx5vnDBO28utGVQKVmvhk7xmuFO2uPxhdpRkb+A0vTudPKqhP4TKx0EitYVqkcwm
         sfiSqthcjjwJvtALwmb2D7fKtWjyfUdru5z6HbdkmJZd0vCSG3DK9p3ffXKCxRR7y6
         Dd/U8fy/BGXDJlkWa49Ov/y6c6ZZq/gIebpxrDwcf5625DmrR8bqa7+vl5QjjFNqRT
         56tv9upB43eDOScqVd+2sm870sdEVATmodwkEH2mWi0tTo6n19br4Uf+SbDW27oSxX
         WvEovYMKvXa5w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, lee@kernel.org, werneazc@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
In-Reply-To: <20230818083721.29790-2-andre.werner@systec-electronic.com>
References: <20230818083721.29790-2-andre.werner@systec-electronic.com>
Subject: Re: [PATCH v2 1/2] mfd: (tps65086): Read DEVICE ID register 1 from
 device
Message-Id: <169262763557.266290.2836572378120379457.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 15:20:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 10:37:21 +0200, werneazc@gmail.com wrote:
> This commit prepares a following commit for the regulator part of the MFD.
> The driver should support different device chips that differ in their
> register definitions, for instance to control LDOA1 and SWB2.
> So it is necessary to use a dedicated regulator description for a
> specific device variant. Thus, the content from DEVICEID Register 1 is
> used to choose a dedicated configuration between the different device
> variants.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] mfd: (tps65086): Read DEVICE ID register 1 from device
      (no commit info)
[2/2] regulator: (tps65086): Select dedicated regulator config for chip variant
      commit: 3a5e6e49855661ad39b8fbb1dbd041178af98e00

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

