Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C87C0377
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjJJSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbjJJSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:33:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BCD94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:33:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B6EC433C8;
        Tue, 10 Oct 2023 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696962812;
        bh=men6Wwkv7/TKQYnqRezdvTojzHpVL+WgvG2tg1k2L9k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G82dDx8ZVosZ4YpJULHQQGTHciFzpRkRuwllcAxqR9+m8qLIWzSSTXMsARDEpBJnn
         1ZWsnU6cckAfluy6Wr1P8lbFpjYHLrZ52qD0giScchSwSujTzvKjrH0uix3f9Y9Fz0
         e7fFvcQOQrKkAucFeFoiA99CL+tkVYqyRPE6ooS0hZWK8hkLA9xfr8xm0FHdTcCZ2B
         0hSJbSYIjyA18rRl9bOP7dyvT3s2ps90lXQ/llp7pLeziQyvH8Mg4NLfu6gUqDcUxa
         RWQD8YUendklehp9uryDzJrsazV4apLMOSj7PheWofCph59IMp/0YECRz+QnuBqFbI
         q/bYY7Bsr/bqw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20231009153412.30380-1-rf@opensource.cirrus.com>
References: <20231009153412.30380-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: ASP1 DOUT must default to Hi-Z when not
 transmitting
Message-Id: <169696281081.221758.5630336947565213531.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 19:33:30 +0100
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

On Mon, 09 Oct 2023 16:34:12 +0100, Richard Fitzgerald wrote:
> The ASP1 DOUT line must be defaulted to be high-impedance when
> it is not actually transmitting data for an active channel.
> 
> In non-SoundWire modes ASP1 will usually be shared by multiple
> amps so each amp must only drive the line during the slot for
> an enabled TX channel.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: ASP1 DOUT must default to Hi-Z when not transmitting
      commit: 1bba0badff0ede8dc51641cff4b153422baa3369

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

