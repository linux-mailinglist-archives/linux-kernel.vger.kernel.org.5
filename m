Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA8D8007CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378178AbjLAJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbjLAJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:57:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720C2198C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:57:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BAC433C9;
        Fri,  1 Dec 2023 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701424661;
        bh=ccXiUANYmPCB8NhMfkOx6I/A0dGnOoIhG/1n4IleSEM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nN6G/CmkDMIyNYHBFUEVMe6YyKjeJeDlcTkISZVgbTI/pqNUsFklKLjjSBgAOK7ww
         F+Z2KwQWVong0wXXQ8+V0ZSGFvWiaDZ5h4sS4XJxLIbZ2fFZIxPTaoxOuGtDiqqk2p
         5POm7Fu6D+GW5UvL7JwKYwMpdLwg7Fk9VuapkM9/kKP1TSnKEolwx2DF7Si7mSRIrd
         sOsKsJcq3KHr3/WfnhQjoqUbxvkfzKhwu5tV0eQub0nvw/FciJHAai10aBfmejDR80
         AtrxvFKdZX8LBzEx5XRqDkXsRxFcCYz4AbrgoAwnqroScmdHvFihxmVOAjnqug+A/B
         0tyQAf6oAtP6g==
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sbinding@opensource.cirrus.com, lee@kernel.org,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
In-Reply-To: <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-Id: <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 09:57:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> In preparation for adding multiple CS support for a device, set/get
> functions were introduces accessing spi->chip_select in
> 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> spi->chip_select and spi->cs_gpiod")'.
> Replace spi->chip_select with spi_get_chipselect() API.
> 
> 
> [...]

Applied, thanks!

[01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
        commit: dd636638446c87c95c5beddcd367d95ac6764c6c

--
Lee Jones [李琼斯]

