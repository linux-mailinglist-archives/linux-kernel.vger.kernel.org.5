Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCF75B39F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGTP4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGTP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:56:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0F123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:56:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso728073f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689868609; x=1690473409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUaGgshK7tSiuDfJWDqXManELi0SbVivYa4vNiVvwLk=;
        b=2kcjbWMtu5jkuZoM1057ogV1hCQNF9qQlFv7o7laX7Ec0UwJLiOXiXvPAMcnw+Ooua
         f1cgN0aaXzZuZKlDjK9nH3dFJ3nsMOFHTGZdG+xtxCm/jVu+mHExxhO0vwlg8KwMNGA5
         rga8y6hyrnV66S+kdowSnLuBDzYK+sKIDNk+1AOgyluurTwkrK8ensBP3eO5b+Xkd7dO
         qskxwpKBNT+tyQuUjcRZxwXAgH8KOb3gWINGJZ3731hAPTPWJmsZfcJRqp0edDdL++Kz
         o8ArBZDyuXu64wFuQnJ4hbgsRUJu5y//L7oO99mpWNrPgBxKcfBVPX4u9BcsZHfFHR/x
         Ss5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868609; x=1690473409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUaGgshK7tSiuDfJWDqXManELi0SbVivYa4vNiVvwLk=;
        b=XPdXDfVJXOgK32ubINPfSQFbZ1xq3JRXBMq64QtS7LKWaYYeW63ofR7S6SanJYv3Li
         XipG+84h8BqbAlsDxMVTzhaz4MTgxFLdFgDiAIM/VeJVp/dg4qFUa7cSWd3GF9P2tDVj
         INtZEVJUlrvFl7URqKqJj4OH1G7XIs+P8/rOLADLl/sSEmuKwQ+EUcbnGBR3p/PMB7Rv
         HiqbLfVx0+w2631xPfHbMPYd2FKwY0lXnYl+mUMf5FekU6pj52LagaYgY0eBg7ZbVAjV
         O+JgYFLTHJjfbaxynFW5nALUUU2zf2gkQENE/V+/Md9ezqzrmcPzbzL4E8ZcuynBVBty
         WBsw==
X-Gm-Message-State: ABy/qLbktaCTwC1HD+yEZYODK/MnCO8CMoM4yBowQBlxNPwijJCBveB4
        iUyP26K3XdAhEBGVANziK0yyvA==
X-Google-Smtp-Source: APBJJlGA2DkEn0lhUqKt4dNDb8D6rF5QRcat3WvydSedezoT3YXG+1Wl3ACqrb3xpAk1dprZGpXTQQ==
X-Received: by 2002:a5d:420f:0:b0:313:f61c:42b2 with SMTP id n15-20020a5d420f000000b00313f61c42b2mr2628545wrq.69.1689868609309;
        Thu, 20 Jul 2023 08:56:49 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q7-20020a5d5747000000b0031434936f0dsm1698149wrw.68.2023.07.20.08.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:56:48 -0700 (PDT)
Message-ID: <ef08ffa7-436a-5da2-ff46-5697cab6d299@baylibre.com>
Date:   Thu, 20 Jul 2023 17:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 02/11] drm/mediatek: dp: Move AUX and panel poweron/off
 sequence to function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
 <20230717141438.274419-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230717141438.274419-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 17/07/2023 16:14, AngeloGioacchino Del Regno wrote:
> Everytime we run bridge detection and/or EDID read we run a poweron
> and poweroff sequence for both the AUX and the panel; moreover, this
> is also done when enabling the bridge in the .atomic_enable() callback.
> 
> Move this power on/off sequence to a new mtk_dp_aux_panel_poweron()
> function as to commonize it.
> Note that, before this commit, in mtk_dp_bridge_atomic_enable() only
> the AUX was getting powered on but the panel was left powered off if
> the DP cable wasn't plugged in while now we unconditionally send a D0
> request and this is done for two reasons:
>   - First, whether this request fails or not, it takes the same time
>     and anyway the DP hardware won't produce any error (or, if it
>     does, it's ignorable because it won't block further commands)
>   - Second, training the link between a sleeping/standby/unpowered
>     display makes little sense.

-- 
Regards,
Alexandre
