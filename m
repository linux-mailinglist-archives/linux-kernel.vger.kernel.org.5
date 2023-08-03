Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D395A76E3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjHCJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjHCJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:01:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C1E48;
        Thu,  3 Aug 2023 02:01:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B8566607197;
        Thu,  3 Aug 2023 10:01:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691053299;
        bh=/beArnWlCuMXu/k9SA9MRUypw7KINtPz1kEXHPoWXrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hZ2CbI4c62e5ug7vRpYzmey/E7TRPHXlb7y6k6uu4bX8/Ec0yjAuXD3Ri/CAMEt8G
         m+631p88RgzG/wfnOG+d7UDlTGWQ+ny4DldMFEFpwPCj2RSL4H9SK5hfThSZNtuBcI
         dJLG2ftVh46++C7d1OUpjg4IxEsqM7U8HzXpAzoWxQm1xHFQ49UPdL+nlSfRCNWv2P
         3Z8SajfQy44eTjgeXXttMgy2X/NU+b7Ka81cMjIrLvNnZd3bLsayPvbjWB9FXMfFgB
         XooDfJKQQy/ZNql7yLORHai2z45elWrAves3HuMPMpJsiq/49IOVJw2Okmwc47BUBf
         aXEwvI2KCpYHA==
Message-ID: <d9aea8e1-133c-c536-2605-36a6bce33368@collabora.com>
Date:   Thu, 3 Aug 2023 11:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/9] regulator: mt6358: Make MT6366 vcn18 LDO configurable
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
 <20230803074249.3065586-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803074249.3065586-7-wenst@chromium.org>
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
> The VCN18 regulator on the MT6366 (only) actually has a wide
> configurable range of voltages, even though its name suggests a fixed
> output voltage.
> 
> Convert it from a fixed LDO to a configurable LDO. Its range of settings
> is the same as the VM18 regulator, which is missing and will be added in
> a subsequent patch.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

