Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DB807119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378527AbjLFNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378554AbjLFNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:45:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338F12B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:45:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4B2C433C8;
        Wed,  6 Dec 2023 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870326;
        bh=OOXRFN1r525T5U/njmTicMNcjvpIFxjy3A/HJdvfhfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMJkqtlg1H/lfcxRidEk7JS2+6JHsSK8Oaipk5bLara6T7MNPhJC5VKPOjx+SdPno
         uCWxbS/TJs4f1gWuxZaeIOW5th2aEFpvQW+ZfG1wYPG3+aGkgOk6PL04zy4ogMMzHa
         Z/8+KlmxPAFiM+m3P77xxqPF/sqPECISOroDNxmuAQcwNidGj8XcM2g8hxB5TxyhI5
         TiOGQVFmnoACjmtlMexS14HQGlqjYOp3G92DQhq1DYKE/GaNESYN+tO+JaIRg61lrJ
         Kd7vldTl89+fLxEoXKq9BpOq5YbQu60A3cz+84jEz5gyXwM2Uuvzt0l4cMkDwUW7lo
         gTVdXRPV9JMBA==
Date:   Wed, 6 Dec 2023 13:45:18 +0000
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
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-ID: <20231206134518.GE3375667@google.com>
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

On Fri, 01 Dec 2023, Mark Brown wrote:

> On Fri, Dec 01, 2023 at 09:57:36AM +0000, Lee Jones wrote:
> > On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> > > In preparation for adding multiple CS support for a device, set/get
> > > functions were introduces accessing spi->chip_select in
> > > 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> > > spi->chip_select and spi->cs_gpiod")'.
> > > Replace spi->chip_select with spi_get_chipselect() API.
> 
> > Applied, thanks!
> 
> > [01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
> >         commit: dd636638446c87c95c5beddcd367d95ac6764c6c
> 
> Is there a signed tag available for this - without this change the
> subsequent SPI changes introduce a build breakage.

Not yet, but I can get around to making one.

-- 
Lee Jones [李琼斯]
