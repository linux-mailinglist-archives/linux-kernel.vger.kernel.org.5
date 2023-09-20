Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F07A7988
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjITKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjITKo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:44:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB5C2;
        Wed, 20 Sep 2023 03:44:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F15966020EE;
        Wed, 20 Sep 2023 11:44:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695206662;
        bh=v6OXoORpooHQSXX2uzSECYJDG7gT9Gv+5nUaIefwooM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N8OnldgrfVAP1gPm+4lEweW46+KBWAASsSFF0cvTBnF2Y5wLGdgve1HstxTroceg8
         4h1Kvw+RK+NRmL1EOVHB5avww3XNrtPBbxuDPHAFha0ty67hY4QlYzwBe59qda41G/
         a/ywvx2teWbb4EDcRN1dRhB7de48lVZMT1+3jrrGfgdYxOXQaZhTgJVWsiEqDr9H3E
         vBS5ArEOlnZwcZV4Qf9YnxdtI+kgeB94IDgnm1day26RVdqx/5GqeEervS1vMQeHkL
         JzGOQ9pB3kXyJL9VUYsDGZ1JcswcTiYJFdy1L5fs7RO5PrlQXgX2NLC43SrP8lyTAI
         SDOy2rabeep+w==
Message-ID: <e4a6d5c7-fbc5-23df-c91b-e433d8d05eb8@collabora.com>
Date:   Wed, 20 Sep 2023 12:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 10/12] regulator: mt6358: Add missing regulators for
 MT6366
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-11-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919104357.3971512-11-wenst@chromium.org>
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

Il 19/09/23 12:43, Chen-Yu Tsai ha scritto:
> When support for the MT6366 PMIC regulators was added, it was assumed
> that it had the same functionality as MT6358. In reality there are
> differences. A few regulators have different ranges, or were renamed
> and repurposed, or removed altogether.
> 
> Add the 3 regulators that were missing from the original submission.
> These are added for completeness. VSRAM_CORE is not used in existing
> projects. VM18 and VMDDR feed DRAM related consumers, and are not used
> in-kernel.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

