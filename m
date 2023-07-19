Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCD759A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGSQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjGSQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567EE75;
        Wed, 19 Jul 2023 09:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E476178F;
        Wed, 19 Jul 2023 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DFC433C8;
        Wed, 19 Jul 2023 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689782731;
        bh=/tb6Lbrwdhatp+AsYZjp6uY0cMgxTGbIbMh0XQFsrTo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N2UPtybDErSj5om1oRoCxeCA3sUT7indVYN8NR1oCsM87Mdcuqvzj4kZU52PNTNQO
         0H7F2gzr9y3ffXwMXEjT79fkuQ0Q+JG4/BWPRBgDAREZtuDO+CP8qU8AtEU1rPgeIs
         UWVCqoV38XVrMtKIlXanYa2QI43OY81OryviP0SIkh6uoaz/EWtBCiFzVb2w7zUoRc
         41DQFs9i0doO5Kf48UoPIM7JbjxHoOLOy3WRx7QBZOJpgY5p4sV/W5N8kgBC3kni3n
         3+p+6GKOEqK5s4Kmr7jOjJUackkYFRZWmxEssnNqEAjnIzxf0l7EjbC2AYbXZvjE7z
         bhndMVUaCQXoQ==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v2 0/4] spi: rzv2m-csi: Code refactoring
Message-Id: <168978272902.92263.3160901473000080563.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 17:05:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 20:24:49 +0100, Fabrizio Castro wrote:
> I am sending this series to follow up on the comments received
> from the first version of this series.
> The first 5 patches of the first series have been taken by Mark
> already (thanks Mark), this second version only addresses the
> remaining patches.
> 
> I would like to highlight that I have dropped patch
> "spi: rzv2m-csi: Switch to using {read,write}s{b,w}" for now,
> and maybe I will send a follow up patch later on.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: rzv2m-csi: Squash timing settings into one statement
      commit: d5737d12779a171e76ad07635d1ed06a22009da7
[2/4] spi: rzv2m-csi: Improve data types, casting and alignment
      commit: 8dc4038a026a79b6222a43ccf7adf070c4ba54ea
[3/4] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
      commit: 7b63568fce9cb34cb0ad4caf9231555eb768c8e6
[4/4] spi: rzv2m-csi: Make use of device_set_node
      commit: c5a7b66811d22a4901bd358447e59160dbda8f65

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

