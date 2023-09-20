Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C57A7981
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjITKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjITKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:44:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F4AC;
        Wed, 20 Sep 2023 03:44:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 111756607084;
        Wed, 20 Sep 2023 11:44:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695206657;
        bh=qYDv4UmMS35eowUXXzmtkFsA7eJUiQCM8vMVF/nTK64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZAD1dEJ1+YyBkqVSC/7hBtnGxVL86hiumckiBEh+QZzbKipI8e0RLLVH7hlGGp1vW
         RhA7SCmbuBXlzQVQF+TPAdIGsMbxcL0uecE+mzQyUA2J1pgszbVzp8iWL5O7rXP1oW
         jcNPI+FyE48vZRV/uKlKghj1EPuCdKHFbYMCkfjhKQ90cUmdO39y9ZfPg0jAchJGhS
         7m5yPvLw3oKf0VSkZIRwbAunQ/LtOdKEJLjn6JsuvRSBdzGKIJn4Gu1SLm7qf2wTqh
         IPYMbjBl94Akb0JRrRzP2DdQRu5kwhnh9H3F1qz0vErE/YG/SdJQe1A0BnnlMI739D
         nZ1OrUWwCkRng==
Message-ID: <10fe286c-7168-6454-4ac6-bc9a8fe50004@collabora.com>
Date:   Wed, 20 Sep 2023 12:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 06/12] regulator: mt6358: Use mt6397-regulator.h
 binding header for buck mode macros
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
 <20230919104357.3971512-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919104357.3971512-7-wenst@chromium.org>
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
> The (undocumented) possible values for the buck operating modes on the
> MT6358 are the same as those on the MT6397, both for the device tree
> bindings and the actual hardware register values.
> 
> Reuse the macros for the MT6397 PMIC in the MT6358 regulator driver by
> including the mt6397-regulator.h binding header and replacing the
> existing macros. This aligns it with other PMIC.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


