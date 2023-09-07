Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A689797A91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbjIGRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbjIGRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:44:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05FB210E;
        Thu,  7 Sep 2023 10:44:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 345B266072E2;
        Thu,  7 Sep 2023 09:39:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694075963;
        bh=5HAuUKmxIJjg4VBaguLk4I4c+d601rOrY72YVF44X0M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ckA0g9vdfCDOuObnUptNofe71ykQGSYqCxS/zNk0qiHFM/fWOi8hP6O782zIyHZTu
         2KXFJDGyGJRHV6zVGjLgpikCK+iI3Q2+Z3a7VRK/m+JWeU2/0u9iXhPGR3lprRAGvU
         YpDGz60C8YWZkLhW1z8RnG+GPO6hXmTv3HFVYFqsM2KF0umWeLtu1YtoIMilRnnVD9
         kAUj9pnizAshMgEIDrqlnr+/sN8Ygc0eaKxnxsDvPzcQrgABidAn8DcwP88fn778j4
         AvAUYch05oFXm6U2RI0oKtpItlQe5EKLa9+//Kk6xhe4P5Msy4saKe6rHdMUj9+kMl
         6Ne+quxCRDvDQ==
Message-ID: <a3221a0c-a638-ea06-e8d5-9252fd95a032@collabora.com>
Date:   Thu, 7 Sep 2023 10:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230906114425.31187-1-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230906114425.31187-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/09/23 13:44, Macpaul Lin ha scritto:
> 1. Add compatible for MT8395.
> 2. Add bindings for the MediaTek mt8395-evk board, also known
> as the "Genio 1200-EVK".
> 
> The MT8195 and MT8395 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
> 
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


