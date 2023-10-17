Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F287CBDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjJQInM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjJQInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:43:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1963F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:43:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so869051066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697532182; x=1698136982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mWE3ioyQaxDSod4iM87Tqs0+a3jEsBLfvJyNoNblIM=;
        b=tF9iloDL0t/HWB9JL9Ck7DJkZxdjUa/X5j2/p2NIpPHklBxRJzZfiKvaOlLkBsGAYh
         OcHRVsI5YP09w3xdnO1vMxyvwL24d99KN9k/CsTH7yX8PN7x2m8xyXHoJAB3NZstWBu+
         0tzlPysYF8LfOSi5E1kAVA0OHTpsrzDbCuKp7n99YEtZ3WOIgHgYKAFM+pJqTl3lNytd
         V2R/+145GQj1xzdK8uSG9wSmHl9+96DbRL+lynd7jxf21lDo5ykjvbaUIFdkPMilkAcZ
         vHEzHAVxvL4fIut3OeFQlL2eEYJH3ih7M6kXDGlHO5PXpRh/f91lGZmy4+J5BQ4eNgpu
         xVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532182; x=1698136982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mWE3ioyQaxDSod4iM87Tqs0+a3jEsBLfvJyNoNblIM=;
        b=K5bH1qxHbCHnGh/P0yRvhDZSExT5WKlDDGm6buvlXdSe5KH2KAIJmyDJB4+MEQB+dL
         yiAA1Vbbt026Pz/P2W4cpnaLrIKrNlr9IP7CQbyoOkuM9ZgoTcQUoj1nCZbZZRGoXxW4
         GmWeG2pNEMk+8FxVFPFeWtE1habcJck+Qdhq2Z903fyj7GUVDTtN0LFtKNRfKpgH5XLJ
         wMM7zjLqYvhimMTYewTBiP635feMyqAPLVJ4qPFJg2WGA/AeAHHDNf/1kQ4n3+DCly3s
         5zVH6eqQWW4q1gujMcp4s9JWHc/8w6f7aUuamZAn3Y56mCPZjKyu3Eq71xIKb5VkwKYj
         VHNg==
X-Gm-Message-State: AOJu0YxUC8/pZaLC49W5sMMHpYfBdToA0V2hVMP0YYyYL5PMMd4Fjf9M
        kIlsFmpEKzYIw2LSIK+mmL9ThQ==
X-Google-Smtp-Source: AGHT+IGqNGsH0DhEU+PTpv1aQpuhvhpsLwVB8CXj5e5ZEBB+NTCBmRB3K2VAr1Lf6lDIB8I9SInX3A==
X-Received: by 2002:a17:906:c105:b0:9be:aebc:d479 with SMTP id do5-20020a170906c10500b009beaebcd479mr1140349ejc.19.1697532182082;
        Tue, 17 Oct 2023 01:43:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906474500b009a1c05bd672sm789525ejs.127.2023.10.17.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:43:01 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:43:00 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix probe for THERMAL_V2
Message-ID: <20231017084300.c6wsozaqg7ztgkf2@blmsp>
References: <20230918100706.1229239-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918100706.1229239-1-msp@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Sep 18, 2023 at 12:07:06PM +0200, Markus Schneider-Pargmann wrote:
> Fix the probe function to call mtk_thermal_release_periodic_ts for
> everything != MTK_THERMAL_V1. This was accidentally changed from V1
> to V2 in the original patch.
> 
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Closes: https://lore.kernel.org/lkml/B0B3775B-B8D1-4284-814F-4F41EC22F532@public-files.de/
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Closes: https://lore.kernel.org/lkml/07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org/
> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Did you have a chance to have a look at this fix and the other one for
auxadc_thermal?
  https://lore.kernel.org/linux-arm-kernel/20230907112018.52811-1-linux@fw-web.de/

Thanks!

Best,
Markus

> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 843214d30bd8..8b0edb204844 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1267,7 +1267,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  
>  	mtk_thermal_turn_on_buffer(mt, apmixed_base);
>  
> -	if (mt->conf->version != MTK_THERMAL_V2)
> +	if (mt->conf->version != MTK_THERMAL_V1)
>  		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>  
>  	if (mt->conf->version == MTK_THERMAL_V1)
> -- 
> 2.40.1
> 
