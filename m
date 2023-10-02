Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5F7B502E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjJBKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJBKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:23:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383F9B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:23:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so2215932466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696242208; x=1696847008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47dOvMvPNeJUzh6fLv1kzerhmf6KWlMeYd+nlCsqcNg=;
        b=M6yE8cjc0JoCVOjq21+ZtZRURXX6LnTeACL2lsbBngwQEUwXx8mM8ifIv1Trdv+GGv
         jjVkg/SAoo8+4L5d0oEe5hb2aJJaXt/fHPMgODO3t11D8lQFx7lZCYPYHlilE4cdci5L
         gFDeYjSxnzpILid6wuxGCmLQx3C6Dx+ce/AvxSOS5qcxf9bbYKQTEj0TL5r2waliSsMq
         Vfo76cb8wL3YjogbzVwtesP+rMgURVny6w3Z3mtQ4k6sEUPDoCyVvYcvDIxwP9zAUWgB
         H4in/Cw6x0vj6KTLEXDqghm+rzpv/GUTcN7X9A0233+7/YSHzB4ML9XG3ChhJ6M/ANql
         RG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242208; x=1696847008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47dOvMvPNeJUzh6fLv1kzerhmf6KWlMeYd+nlCsqcNg=;
        b=Z4nlqbXx0j0cqMMeE5RojdeHBEIQkrljwe3hIV5ISDSAUmJElP40fENbZEaM0J40j2
         V2Zdg9p89+G6Ryc3NQL9re3dZPWDganhVT/WcbwKPqUP3XUZ6NzJCFcTpJxPlHiBxwpY
         46fY5R9+etxqof/njBBdiN6SI1QBqcsnlCANPWP46jaD5gpJp5yf6DrLfx1NlBPXsT/i
         4eneKozVmLFqcof/iN7QxLpp+1R5EemaurN/c+z4afkHwQ18Cx2/lJJ3OkSCs0yqYmHb
         24Qb84v4HaohfNxElkU0OtQTpxBvutyOOvaqIXRlNLS2q+kaOazvs8TJucakUI5fLsqa
         uhHg==
X-Gm-Message-State: AOJu0Yyy6Gn4Wi8kjYYka4uhF5+d2WhJ84hNV1S8FDoEOCmI7t1rtnyD
        wnZj6us+E+ZTtrjXhVOOS7U=
X-Google-Smtp-Source: AGHT+IHRH2LrjXW9Lu/WWNqI+7jo8bUD8PnSg9TNeQ2CyGGAs90FPr4hir+qru1BkGlx4W5bhbRZrg==
X-Received: by 2002:a17:906:7695:b0:9ae:3d7b:6f46 with SMTP id o21-20020a170906769500b009ae3d7b6f46mr9183734ejm.46.1696242207597;
        Mon, 02 Oct 2023 03:23:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906b09200b0099c53c44083sm16737870ejy.79.2023.10.02.03.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:23:26 -0700 (PDT)
Message-ID: <d4528015-eda2-e089-1e2b-1de4b54c1408@gmail.com>
Date:   Mon, 2 Oct 2023 12:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org, robh@kernel.org,
        amergnat@baylibre.com, arnd@arndb.de
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2023 10:20, AngeloGioacchino Del Regno wrote:
> I am a top reviewer mainly for MediaTek SoC related patches in most
> subsystems and I've also been upstreaming both improvements, fixes
> and new drivers and devicetrees when required.
> 
> The MediaTek scene saw a generous increase in number of patches that
> are sent to the lists every week, increasing the amount of required
> efforts to maintain the MTK bits overall, and we will possibly see
> even more of that.
> 
> For this reason, and also because of suggestions and encouragement
> coming from the community, I'm stepping up to be a co-maintainer of
> MediaTek SoCs support.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Forgot that in my previous mail. Obviously:
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
> P.S.: I tried to reach to Matthias for almost two months, but I couldn't
> find any way to talk to him and he has been unresponsive on the mailing
> lists as well.
> 
> P.P.S.: This also comes after Rob Herring's suggestion to have myself as
> a MediaTek SoC co-maintainer [1] and support from other people.
> 
> [1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org/
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 208cfcc1aee3..211a8322c801 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2330,7 +2330,7 @@ F:	drivers/rtc/rtc-mt7622.c
>   
>   ARM/Mediatek SoC support
>   M:	Matthias Brugger <matthias.bgg@gmail.com>
> -R:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>   L:	linux-kernel@vger.kernel.org
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
