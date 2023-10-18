Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B177CD5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjJRIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjJRIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:03:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D029FD;
        Wed, 18 Oct 2023 01:03:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D53566072F7;
        Wed, 18 Oct 2023 09:03:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697616185;
        bh=W7GxTlEixMdAxKZq0tsZum0HrzgUBhC6N7AdE2HVxoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lNnitz0XmCeTy8Vlxhor5LzFCpex8bro109TuG0Gd2Y+yHii47AqBwdp4g0aDFeBO
         5zR481K72GHnXqwRyrz0MgU3Ivru+nrJwGOn716mt6Ggxpfc1Ypl7XtgnUMBm0s9Vv
         42O9Q1yz/vGbM23gNa+uUD00g+Quf4gMU0FQ0npzXzEThgKc8AF6N5XE2gI79HwoXE
         mkjizcJoIZoVCFk4wuCLMilPl69peRWPIK1zrsy6X1RmqdU1bBT49QcLUxk20VHU2+
         fU9EDRLU6/6SjG9hWctROeVSbSNxjiyNoMP5lYXE2z49TEznnH8fdyCKIR42B+ZU9G
         fzGL5l9WNqpkA==
Message-ID: <64dcbd70-7553-4a86-91a3-6986854c51ba@collabora.com>
Date:   Wed, 18 Oct 2023 10:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192
 support
Content-Language: en-US
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
 <20231017190545.157282-4-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231017190545.157282-4-bero@baylibre.com>
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
> Add LVTS Driver support for MT8192.
> 
> Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> [bero@baylibre.com: cosmetic changes, rebase]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

