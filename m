Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB21780895A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441940AbjLGNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442005AbjLGNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:38:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2410E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:38:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E5C433C7;
        Thu,  7 Dec 2023 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701956337;
        bh=LrKFalPpX4ro1UCj+XeZRPkOqxKYC9UU2FyCF0mGy08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjLPZIg8FFgsaWRJGrgM6lwAFRaMTuWNUEdoEZvWuxAYsk5rD+M9zXvKHaXN1xlrS
         hXU/HzHP6fXanl92P/HT69g0DluwYbE+xs8k7PpcJ2g50JRXKnct5IOFVJ0TtPo+dm
         pLPZxW2WmIq67oYfevuMMtKStccsxVUdN7fZqGVpgksCsyRPTkrDtHNZyG2ODFUjsw
         1mcvjtPeWPGKEj4DxkbdpVd4shxELDPBf+Uq9viCxEFQid8zyP1ekkbsfPmESx8jna
         /On7CAGQCWJntcZabaDryMMDMWorCO6m+gEZjEAQ6MIGGThmYxQ2cfF5IQHlPzG4Bh
         TS2sianKt7+dQ==
Date:   Thu, 7 Dec 2023 13:38:49 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
        tiwai@suse.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
Subject: [GIT PULL] Immutable branch between MFD and SPI due for the v6.8
 merge window
Message-ID: <20231207133849.GB8867@google.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
 <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Mark,

> Is there a signed tag available for this - without this change the
> subsequent SPI changes introduce a build breakage.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-v6.8

for you to fetch changes up to 4ae08845db4c1f759b8382bc7527ab8249230e7f:

  mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select (2023-12-07 13:36:29 +0000)

----------------------------------------------------------------
Immutable branch between MFD and SPI due for the v6.8 merge window

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select

 drivers/mfd/tps6594-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
