Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F476E3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjHCJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjHCJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:02:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8745B2D68;
        Thu,  3 Aug 2023 02:01:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 623B36607196;
        Thu,  3 Aug 2023 10:01:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691053310;
        bh=mFbVLS4BQ5yM0rCdKvzXd40KW58VQZxdeWGxz8gwKuk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WfBv8hznVFnvTQZfLg1sLKKfhUDJhf4I89wQtJikB0/hJWM0RdmcXWrCBcVv+kEWG
         nQRsrJuUA38WR+NyHanO0qTrsGEIqErFQ8EaI5Iywcd1uYyQ0oLyJTE0bd2r3Mx1gY
         mfgTzhJ3sGi6+mtGUFGqVVYH/tAfL2CWoZjFwLcBA2a06Hryex5oIvs14BH04naE4p
         495FxFRW6TQFGkYuXNMKd0OrEA4mCjPS1AhTT6LazDt8PNem05LMptsg9lmIrWzXRx
         d3iL3R5+hWg3iqvN9aUfYk8OUd1dwuwTHo/+E8qLS+Fi7y4J3YNeO5Rp9yDubE1+OJ
         HqGxjBdeew5Pg==
Message-ID: <41ef7216-3884-9e72-f45c-a31838ce83f3@collabora.com>
Date:   Thu, 3 Aug 2023 11:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/9] regulator: mt6358: Add supply names for MT6366
 regulators
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
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-9-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803074249.3065586-9-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
> The DT bindings for MT6366 regulator defines the supply names for the
> PMIC.
> 
> Add support for them by adding .supply_name field settings for each
> regulator. The buck regulators each have their own supply whose name
> can be derived from the regulator name. The LDOs have shared supplies.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


