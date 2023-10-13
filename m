Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA87C9177
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJMXog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjJMXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D42DC;
        Fri, 13 Oct 2023 16:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416F8C433C7;
        Fri, 13 Oct 2023 23:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697240672;
        bh=ijje59ACJtXkV0PV4ct/39uK254k7vq/jxYbdX4CDko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lkg3GJVLxAFEblDKDAbGOX3PPSz/Ohni7SKs69PJULcZqfl9siFQDYH6F9p3koTpk
         Y8Rv/OCUkPNLJa6VlZAVE+4TCrVKJSY25ix+4pEjYDdDn1qur8kLVyUiN6M3snOiiR
         txCLYu+RUcbqonpin8jPSXTY8E0sgJfIvxffMExnx4l64YtiqeECwQib5YLbrtnm1/
         3Wgd3BPp+gJNUWFiqK6NReQwMAt3g0/xwkPjWja6VkTP6rK+jlEF2akKVqgzTD3x0M
         BfDgrrBGcfku17AkV5gdT+usndxTkXyXKqrGrHlqIj6GT/LbtUeNNinKrFZGkD/n9/
         bhRZOiWIFPxtw==
Date:   Fri, 13 Oct 2023 16:44:30 -0700
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
Subject: Re: [PATCH v8 26/30] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20231013164430.7a57def5@kernel.org>
In-Reply-To: <20231011061437.64213-27-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
        <20231011061437.64213-27-herve.codina@bootlin.com>
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

On Wed, 11 Oct 2023 08:14:30 +0200 Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.

Acked-by: Jakub Kicinski <kuba@kernel.org>
