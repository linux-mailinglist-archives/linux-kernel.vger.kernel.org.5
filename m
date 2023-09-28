Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9C7B183E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjI1K1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjI1K1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:27:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B31180;
        Thu, 28 Sep 2023 03:27:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1A776607330;
        Thu, 28 Sep 2023 11:27:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695896868;
        bh=vyqtGkPk6PukXN65NbvwhvWD0HwSXHn79AF28WiHhVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jGlOLv1s/LU7KYiSJu/xUOAY0nUqM/mdTJbTkoj+pZAAW0i2rFzePBZhTNICEb5ob
         zgfCwOiYK9CCBDM4zO5EyZa3b7DQQhC75E4xQX/8uQ94IxvBjUk5NJtmWN3k+vkNjg
         ddhawPmX2NG+MsaKmnZjwgclWSgKCAWKkdyI0D+XPX3ClQELOwlOgOvmUZbYqt8PJV
         FfZUpTOsRUdRg8+sC1WvLSLbJiCEGBA4ztl2dJZ4g8N2q6WH82p3DFcrdw8TQ1hodz
         qKF2i8WOfOrFF9r0gsV7Kl71683SZXjYtDLxbZrevrDPEqEpGW6hbjtTc8GJ0B1BP4
         mSbierKK8Habw==
Message-ID: <1fa77502-eccf-219e-2641-a2d72a6dedcc@collabora.com>
Date:   Thu, 28 Sep 2023 12:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: dts: mt6358: Drop bogus "regulator-fixed"
 compatible properties
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230928091415.3253698-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230928091415.3253698-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/23 11:14, Chen-Yu Tsai ha scritto:
> Whether a regulator under the MT6358 PMIC is a fixed regulator or not is
> derived from the node name. Compatible string properties are not used.
> This causes validation errors after the regulator binding is converted
> to DT schema.
> 
> Drop the bogus "regulator-fixed" compatible properties from the PMIC's
> regulator sub-nodes.
> 
> Fixes: 9f8872221674 ("arm64: dts: mt6358: add PMIC MT6358 related nodes")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


