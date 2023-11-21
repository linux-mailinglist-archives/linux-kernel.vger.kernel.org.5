Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE87F33AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjKUQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKUQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FBCB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:29:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914BEC433C7;
        Tue, 21 Nov 2023 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584148;
        bh=I7rTz58KR+S4gPSJUCHMuvvrAgbVHDd5w5snGcC6fmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=akn0TQ1tx9tIwVVjKiVUiShOxIyrgDS6HtWnmTgRUnnSklSjnfnhzl6+GuCsg5RjU
         9SptLlLrBWaCEUXZt0ADSJ8CEKkqk2wF9KzP8cpzH4Gx09Owg9SZqDfyLEIg5QoKtl
         yQghzy2Lc/VM67gqmGXGWcz4FaVbhGzQPssRmIrwgDrV26t4om/KFBJPyKHznpDeiP
         wuqu+EX+sVaxwVH4N3+S5L9cHSc3CZb/Ev9j42UeMW/BbZmfG/VtCndmMqUDv495E7
         YkCJYcWckqEaSJD5gcvnhn23OD3MEoSCXL9FZ8InCUW36S86FsgcPUYQUVaL1QHMTK
         eeh5PRJrW3VzQ==
Date:   Tue, 21 Nov 2023 08:29:06 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <20231121082906.354c9a7e@kernel.org>
In-Reply-To: <20231121084330.4064bf14@bootlin.com>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
        <20231117164746.0589e955@kernel.org>
        <573c9ca1-a560-4f7a-ba21-80673a2e162e@sirena.org.uk>
        <20231121084330.4064bf14@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 08:43:30 +0100 Herve Codina wrote:
> I plan to send the v10 with the patch 23 fixed.
> Based on that v10, some patches (21 to 25 at least) could be applied and
> I will remove them for the future v11.
> I think it will be easier to follow if I iterate on the series removing
> patches as soon as they are applied.

It'd be helpful if you only reposted the patches you expect
to be applied, as a standalone series.
