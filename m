Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230147D745C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJYTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:32:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88BD13A;
        Wed, 25 Oct 2023 12:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A68C433C7;
        Wed, 25 Oct 2023 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698262338;
        bh=ZEC6SiD956fvl4s5yXxFlRFIaaeMysUnrTT9R0rL6uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NNjzDaSGX6Xm/ojy0S9ANDFMlr6eKMq9gQjnX+RSpD7B6pmXp9N1HZQcj7PnMXOaI
         FPlk4cYKswApKmXKwZtFkLHe8Wd/MGYdolE+3ljriPunliyXP8I6vwS6kAryW675n0
         w/YJ6ecaLbusz7GPBlZLWXa9nVVhQt+FCaqUj3I0522oj4hgjjsfiT7CU/6YwIxKv6
         OBBMTyKRN8L2N3992/sREdR/vhMVZ/pCX7XS1EACF7/FZ1FaIqIV7XziFecwMyGOws
         k2n7E3UYYAEQWd4eT7A7Ot5Gnu5jV3LmcJLia/oW/bjKXaWWcLXjfbX3XZgi/vuvgS
         jaj/Vm8Qz315A==
Date:   Wed, 25 Oct 2023 12:32:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer
 infrastructure and PEF2256 framer
Message-ID: <20231025123215.5caca7d4@kernel.org>
In-Reply-To: <20231025170051.27dc83ea@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
        <20231013164647.7855f09a@kernel.org>
        <20231025170051.27dc83ea@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 17:00:51 +0200 Herve Codina wrote:
> > Which way will those patches go? Via some FSL SoC tree?  
> 
> This series seems mature now.
> What is the plan next in order to have it applied ?
> 
> Don't hesitate to tell me if you prefer split series.

FWIW we are happy to take the drivers/net/ parts if there is no hard
dependency. But there's no point taking that unless the SoC bits
also go in for 6.7.

Li Yang, what are your expectations WRT merging this series?
