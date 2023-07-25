Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251947620A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGYRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGYRyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1F194
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABDFF6185A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCBC433C8;
        Tue, 25 Jul 2023 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690307657;
        bh=YkISHSyIeF3JhoFBt0QAqdn9Ybp3taqN3sO4QdGsZgE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FKq8H8kMTZzQrIRYssRzxP7R3/zPQO+3GGCWlPpA64Un0TIhypM8O1gUXuxz93jue
         zuo+It9hvh1juAXTMEOMA8EberOKxq9HEaJ5V+Mr6UCs661eqmWvC57ga2+M09KUIl
         qQuwpT1C9KVKlJXwBCoEHZuuIIin9q8Y4F1tBD3JCtSJFp1roX+FLZbAM03tirwf4p
         Yuf7MwuXCbSqG9C1ejF0FUnG2vwNCqo5TeLaZeDAqo9MpDvI5+TY9yTr4rp4uI66+F
         +GvW79PNNryqgs9QAJ1OOXTtqwoxwchf+LNVeDlQDpts6d/6qNpCo1fw/XyR0eOKlW
         A7uMPnf3BSa0A==
From:   Mark Brown <broonie@kernel.org>
To:     codrin.ciubotariu@microchip.com,
        Guiting Shen <aarongt.shen@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230715030620.62328-1-aarongt.shen@gmail.com>
References: <20230715030620.62328-1-aarongt.shen@gmail.com>
Subject: Re: [PATCH] ASoC: atmel: Fix the 8K sample parameter in I2SC
 master
Message-Id: <169030765461.1533302.9555599767367617746.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 18:54:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 11:06:20 +0800, Guiting Shen wrote:
> The 8K sample parameter of 12.288Mhz main system bus clock doesn't work
> because the I2SC_MR.IMCKDIV must not be 0 according to the sama5d2
> series datasheet(I2SC Mode Register of Register Summary).
> 
> So use the 6.144Mhz instead of 12.288Mhz to support 8K sample.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: Fix the 8K sample parameter in I2SC master
      commit: f85739c0b2b0d98a32f5ca4fcc5501d2b76df4f6

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

