Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF709770636
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHDQp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHDQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51727170F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDD562097
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402BDC433C8;
        Fri,  4 Aug 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691167526;
        bh=7+gWNziMZJLQ50L0hoYRp07zf6H+KFMObSEdgv+Zufc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pgni9VcjXGpgSV4cdmWNVdppvuvmmSbdViK/8DaIptORSL62ZsFMZUVB0XDFLncom
         XrGoQxbBOdPxLjJ5tNgPPT6qgUXIlA1Ska55ccu8go4NaS8bxlv7wOVrqPDsHOYznn
         BQe3jxSxUNir7qlW7zwj7JMhOEJq+nXuwSR3k+BXz8ZM1z8GKZjAQln/H4cDh1QUPb
         mhijGuHdH4kfK+SKOIqGwkyUakOCVrt8r4O+5z0ZifsJI5CR+ZmA5kr2tAY0Dhyl98
         XnEbQcNALxvXmu72RFTVsNfUmURm5V5qGB6GiFJCr1Gp5ib7GpyWEtC5GNX+R8YS/9
         VC8HQ7EhwgUDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230804083514.1887124-1-martin.fuzzey@flowbird.group>
References: <20230804083514.1887124-1-martin.fuzzey@flowbird.group>
Subject: Re: [PATCH] regulator: da9063: better fix null deref with partial
 DT
Message-Id: <169116752497.109025.2270208458219621904.b4-ty@kernel.org>
Date:   Fri, 04 Aug 2023 17:45:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 10:34:30 +0200, Martin Fuzzey wrote:
> Two versions of the original patch were sent but V1 was merged instead
> of V2 due to a mistake.
> 
> So update to V2.
> 
> The advantage of V2 is that it completely avoids dereferencing the pointer,
> even just to take the address, which may fix problems with some compilers.
> Both versions work on my gcc 9.4 but use the safer one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: better fix null deref with partial DT
      commit: 30c694fd4a99fbbc4115d180156ca01b60953371

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

