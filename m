Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12A7C9184
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMXqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjJMXqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:46:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D956B7;
        Fri, 13 Oct 2023 16:46:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF9EC433C7;
        Fri, 13 Oct 2023 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697240810;
        bh=I0Ybzefpb0f46pCoW0lXoe0QVolFQKp1by7iMXMV2ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lC51rbW1gspwCMSFrJZZKpFXg7hwiUBH02usnJhD4v+VeActrNiPIFdHj9RlFhcIO
         OrnL8HaWjePfytoVvVqKd/HhDiXPeYY7lk1ZxdWxEXyatr1hXgkp9n7IUYwlypwC4n
         0M3CV7Pq+jjkV3gaxEHD0prKTp+saM5DxkDMl3AaXnHCsGYqbgbk2l/TbdBO63wZif
         7/CkacxbI+QhT3KnrqbGwNLiScxjQskkwXtU7yvDQsgk22IKrukuEL2XzEi104Npny
         SQbjMVZC/WNa2BVJiSItinrMu0FI0V/yIfzrTnEqNw9u6gyALZLXMsA+Y7QwuYWImc
         jms88xG498QjA==
Date:   Fri, 13 Oct 2023 16:46:47 -0700
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
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer
 infrastructure and PEF2256 framer
Message-ID: <20231013164647.7855f09a@kernel.org>
In-Reply-To: <20231011061437.64213-1-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
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

On Wed, 11 Oct 2023 08:14:04 +0200 Herve Codina wrote:
> Compare to the previous iteration
>   https://lore.kernel.org/linux-kernel/20230928070652.330429-1-herve.codina@bootlin.com/
> This v8 series:
>  - Fixes a race condition
>  - Uses menuconfig instead of menu and hides CONFIG_GENERIC_FRAMER
>  - Performs minor changes

Which way will those patches go? Via some FSL SoC tree?
