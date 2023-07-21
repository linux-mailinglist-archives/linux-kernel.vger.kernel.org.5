Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679975C21C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGUIyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGUIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:54:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E530EA;
        Fri, 21 Jul 2023 01:53:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2406660709B;
        Fri, 21 Jul 2023 09:53:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689929634;
        bh=ffw2ebh9MH9Vj8Efzuv/Nuu595JTYxBbopA83mVf6zA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=orGIBjYu+/go1gVsfDbth2LtGWUYY62TI6MVc6tGgJbFb2EvtgzoT4COfPU8kmCxT
         PZcQvDUjGyKaPSNmaetkwhh/txGhaHDPnRNnK8ON2/vfuoq8EkRAVeiRwWd+mDAYvw
         9b1CiZn+r2L2AJVbhoyRrZ99USPYwSnyWldw8p/G24fldbKKSv69oCUkVW2QjkNCxG
         8JtvsneNK6GsTluXVAXrHazPKlDMNP6Tq0ChzZb3kB8UzHMkgQN6DPfz4OMKAk32c3
         3EajEW8Hxcg+t05oeazMWceeL6YaKmn36nqbJOOwTycYotnOWAb6d8zOMwTentrOS0
         oKpLnfqgriJwA==
Message-ID: <fac4a7e7-55bc-10da-fa8c-223a2b716caf@collabora.com>
Date:   Fri, 21 Jul 2023 10:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v2 3/7] regulator: mt6358: Fix incorrect VCN33 sync
 error message
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fei Shao <fshao@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
 <20230721082903.2038975-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721082903.2038975-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 10:28, Chen-Yu Tsai ha scritto:
> After syncing the enable status of VCN33_WIFI to VCN33_BT, the driver
> will disable VCN33_WIFI. If it fails it will error out with a message.
> However the error message incorrectly refers to VCN33_BT.
> 
> Fix the error message so that it correctly refers to VCN33_WIFI.
> 
> Suggested-by: Fei Shao <fshao@chromium.org>
> Fixes: 65bae54e08c1 ("regulator: mt6358: Merge VCN33_* regulators")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


