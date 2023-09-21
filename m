Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F687A9922
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIUSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjIUSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05E35A3;
        Thu, 21 Sep 2023 10:28:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3FFE66072E9;
        Thu, 21 Sep 2023 08:59:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695283199;
        bh=ey5W+Sdk5cYFx0SpuDyLNMLly9gNgQcl9KZF+Hs7Q3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DUp4O18ORCwaBC4JEDWvmA28I6oVL5oekiq2Gl2O/Of+Cl4OjfquAG9qsVYC5qoMr
         BYIQ9lPFIJEqOCnZO68P99AhTNdyanMSD6IMixj7eydBklxRuiRiLCR6qUTMR1ZMgx
         9G8c+51+k9VVFf6+ue7kh6EMgkpemHseCPwtYP3PgrZdNutDY/ujy9wiUIA45GcUi4
         btnRRTEUAtZwDv/xfhVERmXmp3/MCwqzIslni4swqZq60BqIf0x8V/cp2RQZ1cLuVN
         iOgvFicl15QZCvkPzDAEO936AWvM98dKEz/JjNzn+NMYoPN0O1z5JGTzD5VbgtghmG
         6ZDmYXuD5Zlzg==
Message-ID: <83993f62-76d7-78ec-4711-b65e95e3aed9@collabora.com>
Date:   Thu, 21 Sep 2023 09:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: remove extra
 error check in lvts_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230921075518.3016-1-duminjie@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230921075518.3016-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/23 09:55, Minjie Du ha scritto:
> As per the comment above debugfs_create_dir(), it is not expected to
> return an error, so an extra error check is not needed.
> Drop the return check of debugfs_create_dir() in
> lvts_debugfs_init()
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index effd9b00a424..171ce25fddf5 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -213,8 +213,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>   
>   		sprintf(name, "controller%d", i);
>   		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
> -		if (!dentry)
> -			continue;
>   

This is fine as it is: the `continue` is here in order to avoid allocating regset
if the debugfs dir couldn't be created.
NACK.

Regards,
Angelo

>   		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
>   		if (!regset)


