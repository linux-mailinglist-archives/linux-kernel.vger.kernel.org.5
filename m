Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F67B6CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjJCPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjJCPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:20:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0FB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:20:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5ff5f858dso8046385ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346454; x=1696951254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fi0GvVL1UlJlWvA6+wPBTvjnYAhizI6Olhrf8X5QnE=;
        b=jYWxL9eXcRXRPLUxOd7IetRBizK/L8Wos1jlIpu8XpdOntEIg096Nqtl0/ArP/BPpJ
         2EWTeBf1zZo4ZH0cOE9v9EesI5H/EkG7/2Q0RlJmjpCNAFPu2CEHtshC8IcHoVJzqTUw
         b2F1iVKbbrAVby/eotyeJSBeMMCYLCNHxbxk1fTqdO2UtczNQYsx4ksJq8goNd9euZ81
         RXH+30LAzuWbhiSY2LOm59o/bmEp3IUfOM9XtUNVGXtSX2c7s+CFVort8qv3TZTM7QFB
         yiWwQQhP2aI1U+yuGbaC4OLSIwygP5zhlSpDKUUMvuxHXk2e7StSyLe/Xor51PBZRyaf
         14cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346454; x=1696951254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fi0GvVL1UlJlWvA6+wPBTvjnYAhizI6Olhrf8X5QnE=;
        b=T08ShdbVqJzRL7IwsU6f7FuVNUJa/NceASzuEgZP0Ii6zjEmojSFCv4C5rcz3UyDak
         Nv1TbBnTMMQhK46+0CEkLbRlj7qVq02UmcXlwi8EKtN+Z0HObdCi4/H5MtDrYsCdpMf8
         gIGhnyBS2yU12I23YEEMKGebY5TfN/42Q+VwAmJJTFKE4ekj/H8RYNi1Mtj06LOp+28m
         cAMrnANPd6FAO5XG1c9XXB6AQTJzUzYhoGu+9IDQv4g2EvR+VOcVLA4GNjQEE+l5TdDF
         sIbaqz5NIqKWMXsYSBj7nUuvaKfmyESog5mqYmgDjkKMICt0jEsXWnS/lYX3Jp4bxtlj
         oEbQ==
X-Gm-Message-State: AOJu0YxseoaB2rl5rz4XNDkDnGy3UzrH2zXqmscQ/1QIyU/hsLWSa5X8
        roEbSBtjbslJPFl8yOtYqwUjng==
X-Google-Smtp-Source: AGHT+IHbk4360AQXMEM8OHKJjDDmSkblY5FgQIBA5Fra9XDJdxKFPKgQIzSaAMDLRapNNLqBYtu7wQ==
X-Received: by 2002:a17:902:d512:b0:1c4:c5d:d7fa with SMTP id b18-20020a170902d51200b001c40c5dd7famr13112626plg.45.1696346454478;
        Tue, 03 Oct 2023 08:20:54 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9379:e1e1:dd3c:a271])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001c74df14e72sm1684106plb.212.2023.10.03.08.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:20:53 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:20:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jieyy Yang <jieyy.yang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>, soc@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
Message-ID: <ZRwxUz+K1SwGVQU3@p14s>
References: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
 <20231003-mediatek-fixes-v6-7-v1-1-dad7cd62a8ff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-mediatek-fixes-v6-7-v1-1-dad7cd62a8ff@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:13:43PM +0200, AngeloGioacchino Del Regno wrote:
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
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Link: https://lore.kernel.org/r/20230929082009.71843-1-angelogioacchino.delregno@collabora.com
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..57f82fcea1e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2327,7 +2327,7 @@ F:	drivers/rtc/rtc-mt7622.c
>  
>  ARM/Mediatek SoC support
>  M:	Matthias Brugger <matthias.bgg@gmail.com>
> -R:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
> 
> -- 
> 2.42.0
> 
> 
