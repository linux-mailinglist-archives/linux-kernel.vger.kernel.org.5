Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8907EFCBB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjKRAry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKRArw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:47:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714F93
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:47:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8519BC433C9;
        Sat, 18 Nov 2023 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700268468;
        bh=t57+RslQFeKnJM3h8s2TI3ZEoZEyxEDagVoPEqzUmqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQs7w7qtKk/3FDjQkfTHKofphFehwcjkn9sjAVqiiHlSDHnFUcUkqWO8Pgy3/zFmE
         AYMxPhjIt2GLa120lU8rpSUpci65qybU5kUTOhFbIfkFH3RLmL0sN3R9pYs16YqCSF
         XRxSzYGV2+s2rvQbEXVZ4MHsne/RFlWGj9KeEMZjxZdhMEnzuEyTkQv/OnyofsMWZZ
         CaTDitfbHF8ZXhHsP7bVr9bMIlJ4g2xPv9dMUPOon34EIUZXPEStD4TybsNM0X4xAW
         O8zkdi3a45WxLIZPa8lYBeydEX+isHSwUwieWbWg0ggRi230gqABIRCwmK0BxaEy1j
         Q5HjtqnDzNerw==
Date:   Fri, 17 Nov 2023 16:47:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
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
Subject: Re: [PATCH v9 00/27] Add support for QMC HDLC, framer
 infrastructure and PEF2256 framer
Message-ID: <20231117164746.0589e955@kernel.org>
In-Reply-To: <20231115144007.478111-1-herve.codina@bootlin.com>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 15:39:36 +0100 Herve Codina wrote:
>    - Removed Patches 6, 7 and 8 (patches applied)
> 
>    - Patches 7, 20, 21, 23 (patches 10, 23, 24, 26 in v8)
>      Add 'Acked-by: Jakub Kicinski <kuba@kernel.org>'

I thought someone (Mark?) asked for the networking stuff to be put 
on a branch. If that's still the preference - is it possible to factor
these out as a standalone series, too?  Will they build on their own?
