Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C280E7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbjLLJbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjLLJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:31:32 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBE107;
        Tue, 12 Dec 2023 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702373495;
        bh=63BaG8+UnODbNllY/PE5UFPUBy6aPrVHxXNq6unqZyY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Dm+Q7ExCKkKTJuhUnjwEyNwJM+krOm1JuYCk9nSgkwJSCWzdxuOm3EVOK3+CSPIM9
         qk8iCFiBNEKWBR5WNHU+85HGJ4fxI/uOUqwHmiQw2ubrzMMZU2WpyoUY19aKaxRRBR
         W8mV6t8z6BIb9L5eD2cjzsz1K5J7n9PLPVKkVghu/pzAPHU7CmyEi+TwLOqjM47BcV
         spCfjrfAor/pVbCOW5LCKdXmD9fjxmISwcwU3P+6JVG12PJLf7mhyYMrRzPJLbYYbd
         V0cz4CXasjsdSAAS7ErqxNmz2OtAtK9V6PRi25JCAdLASQQyfh8e1vGpmv7hvkW6kS
         61XB5S+uwBNoA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B23B3781423;
        Tue, 12 Dec 2023 09:31:34 +0000 (UTC)
Message-ID: <1cd5446a-37fd-4fbb-8c17-e0046e58c29b@collabora.com>
Date:   Tue, 12 Dec 2023 10:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] clk: mediatek: add drivers for MT7988 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <152b256d253508cdc7514c0f1c5a9324bde83d46.1702350213.git.daniel@makrotopia.org>
 <14b00d8c9d1fcfdf8cd6b9b02e5a19566d970e6b.1702350213.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <14b00d8c9d1fcfdf8cd6b9b02e5a19566d970e6b.1702350213.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/23 04:19, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Add APMIXED, ETH, INFRACFG and TOPCKGEN clock drivers which are
> typical MediaTek designs.
> 
> Also add driver for XFIPLL clock generating the 156.25MHz clock for
> the XFI SerDes. It needs an undocumented software workaround and has
> an unknown internal design.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


