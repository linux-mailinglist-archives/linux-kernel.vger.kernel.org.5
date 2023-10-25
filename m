Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE857D64F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjJYIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjJYIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:25:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFA12F;
        Wed, 25 Oct 2023 01:25:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D3FA660733F;
        Wed, 25 Oct 2023 09:25:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698222333;
        bh=1lSLOD1SNY62x2kvty7CxHvQhFKkLJODoGmO9QGF/io=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TMFGAD8vGD1PMKqywCxbp6nFDvBack73i11WS9XPAnMg6zvEtJEr58Rj2bYmPbK+l
         xNAxPLq9DGk/gYMWCTPYwIxSO7Q0mceqSbdbY/WioXa+6OCbjpVWitNyCAERe21Nqr
         m8RnJ+3pPU+KW7nSZcFZbOkCNjh8uuBS6UhhhG413t/J86Pf95yd6neIzQi+6Q3Gwp
         U4G1b8Z5QubHtC7tIkAa2AFXr7u1550vTao8rf7CCVdriR5tBwvrU/h9csBm6iq9T5
         fnp9hnqhy15oNR1K3QmU/ys32HUrfaAVpsOrLe5XXddlhLAhKm5+xOCXGg7Y3UyICF
         9v7FWPX5TYsQA==
Message-ID: <1239aa95-aa4d-4465-ab91-c239e4c1eff8@collabora.com>
Date:   Wed, 25 Oct 2023 10:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: mt8183: kukui: Fix underscores in node
 names
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024212618.1079676-1-hsinyi@chromium.org>
 <20231024212618.1079676-2-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231024212618.1079676-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/23 23:22, Hsin-Yi Wang ha scritto:
> Remove the underscores in node names.
> 

You're not removing the underscores, but replacing with hyphens...

The commit description should therefore say something like

"Replace underscores with hyphens in pinctrl node names both for consistency
and to adhere to the bindings."

... reword that to your liking, of course.

P.S.: This is a fix, but has no Fixes tag?! :-)

Regards,
Angelo

