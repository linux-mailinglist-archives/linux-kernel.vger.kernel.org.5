Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965B080C559
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjLKJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:58:23 -0500
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 01:58:29 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9503CB7;
        Mon, 11 Dec 2023 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702288708;
        bh=1vlSK61ii6pQc79okCP27W66WIn+LTj5UCblxB38Mfk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ANF8p3bmTSe1oyq1j8/nMQZPiEBKmqnkdumu9FQ3n8r7DSpesjoFU41LxagEKoIHh
         AmMNwVFjNWSrELd7vJ/BmmOnj9EVIU32JtNs/QAdL17mk2CjM+wShseFcnwO5YwEbL
         OWVFATxMpSeXmV0KaSp8UN7A7p1l3XnchrFEcbZMHYon2ThFd8X/3Inw/H9jEuBYTr
         7yocIgbtCIujcv5aGNcH5M+r88HmoEgruhXp1ylMY9kHFiNDHNjgRTFYJOY7KJKdM3
         qjRxJsHVnSc/gsWemI2RlQDpycingDlpbXyPETOK9Iv2HCUBajb5rfb/4jKgze2m8G
         8OP6WN5t4hHCw==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DDF73781410;
        Mon, 11 Dec 2023 09:58:26 +0000 (UTC)
Message-ID: <0695179a-6dea-4a68-9a2a-195d3a4ffa10@collabora.com>
Date:   Mon, 11 Dec 2023 10:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: mediatek: add MT7988 clock IDs
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
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/23 22:55, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Add MT7988 clock dt-bindings for topckgen, apmixedsys, infracfg,
> ethernet and xfipll subsystem clocks.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


