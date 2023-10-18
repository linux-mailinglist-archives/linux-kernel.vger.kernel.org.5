Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158687CD5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJRIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjJRIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:03:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA7BB6;
        Wed, 18 Oct 2023 01:03:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8164C66072ED;
        Wed, 18 Oct 2023 09:03:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697616187;
        bh=NZBceo1UrDJC+0U1E84JTtwh8BxlG/3QVtT5mYfLMpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GIt28U9eLenzBpXXEt4AQF62FAgGQ+kccHKXchztEJ02I/fdsVPEyiSXmEy2lkC+o
         LyVdOJijQFH3QzkO3Rao+dFnrwOK70SgsWUTP9+9s2XsWxa0H/LvqolBb8ja1XGIbR
         /QIFt+8j8JT3+EMidl2ZDH114wR13fhRpJW33b9yuUuFSxSp1cS1xmLezOEWIvpQCE
         QDPxGycsNT6ojiLm5FqM6D3vQkpxNNhY6Pjskhd8f75V7SZGx3ctUk6MpWqWO40dBu
         CD4qp2eRtrSh67TLMNTvWxyXkcXTJR7N+BgMi+ZtPTKpDY9aBFH4i9/4DlKRGuBLs+
         oeonPHBNIN97A==
Message-ID: <8a045940-3125-47a2-86ca-c4dee5e7a87e@collabora.com>
Date:   Wed, 18 Oct 2023 10:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend
 and resume
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
References: <20231017190545.157282-1-bero@baylibre.com>
 <20231017190545.157282-3-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231017190545.157282-3-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/10/23 21:05, Bernhard Rosenkränzer ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add suspend and resume support to LVTS driver.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> [bero@baylibre.com: suspend/resume in noirq phase]
> Co-developed-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


