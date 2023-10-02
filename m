Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAD7B4F38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjJBJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjJBJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:41:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F3B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:41:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso15190814a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696239705; x=1696844505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwQS1I2S/UPYL/Sf2BTeKAyKxjWoqdfF0azKmWY199s=;
        b=AMAjV1GfbJPJHVoHIXUh2oYRBgs8M/+2XLKzfVekVupIG+xe/Np7M91nLveQuB0Km4
         U/drtyYD4P7Eh6ObSFdYNbJY+r2PJUqNk9O3PessA64MQavp39m+rsDm9Sxld6kO00aS
         5IDnYBsmBRcQjEi1KsZPn5XnkSnP4QJYdk+K6cFchcqgIvnuv0fDbMCcmKuouzkWSlz4
         03qSBNBFkHG5sXXa4X6BlTVrEtEI64yNG9WyxGjVqyPFrqJCorn5r774XOQqoN1V75CM
         SZnDx/GyqyMtbL1OLj0djY24kK98QX0Ka+FDck09plKEFCTMTlDxTFtbSM7BgOylBN9O
         CLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239705; x=1696844505;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQS1I2S/UPYL/Sf2BTeKAyKxjWoqdfF0azKmWY199s=;
        b=AlydsDicRuFS/1VpFz3O3xhyOOrZocvyPjtKgQmpqvsi3NDJ+eUpzjznutt90bPcCM
         JGdbmOHiSiORXk+SI1q1gOM1SzlO/FhE/ZpFZLwVVbWk1IKUiN73TNC9baG/EDRVJlMC
         MDyhsBZxoyATLjkUiyUIf2QKgkVesxhIAlAhm7y5TqrLRzOfoqRu4n+XKkRRQS2EotLM
         vL3yKqrt00JqHod2RVAg6wuwJsjDT1mVmqMVbFDn7sKKTgwjqabsvg+VGbZRj+WCsoLh
         /PrKU2GrgzyLmcp7Psg026hrMAIfomIx7YgPxvUXotoPdguf6yWQQoASQUG9TaXCk+0j
         6VNw==
X-Gm-Message-State: AOJu0Yyun4hIsYH3vTZBANoWEt8irk5X4qtg3WlXyu4CTug6+/LCMuun
        EP1vxNhpU4+RAvlzqz2yMck=
X-Google-Smtp-Source: AGHT+IEo7YjT0mHXU+8kOwIQ0etcMXrU15cDO31hE8GbdKC1lD5TANXkhm2jyPryZoGR1Fn9McKpiA==
X-Received: by 2002:aa7:c2d7:0:b0:534:2fd8:a9e1 with SMTP id m23-20020aa7c2d7000000b005342fd8a9e1mr8947588edp.22.1696239704650;
        Mon, 02 Oct 2023 02:41:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7cd12000000b00537efd5f1a8sm4454057edw.69.2023.10.02.02.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:41:43 -0700 (PDT)
Message-ID: <d26ee3f8-d5d3-e46d-4d79-098992d13790@gmail.com>
Date:   Mon, 2 Oct 2023 11:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org, robh@kernel.org,
        amergnat@baylibre.com, arnd@arndb.de
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
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

Thanks Angelo to volunteer on this. It actually was on my list for the last days 
to ask you to help me out as I'm not able at the moment to cope with the review 
process. That's unfortunate and we missed one merge window (August) where I took 
no patches but after holiday situation didn't get better. I don't want to be 
break in the MediaTek upstream development, so it's great to see you stepping up.

As I read in the thread, I agree the best will be to have a share tree at 
kernel.org. It seems I can't share my tree with you, so hopefully you will get 
access fast.

My idea is to not disappear and create a collaborative process for us on the 
maintainership in the future.

> ---
> 
> P.S.: I tried to reach to Matthias for almost two months, but I couldn't
> find any way to talk to him and he has been unresponsive on the mailing
> lists as well.

I think you didn't tried matthias.bgg@kernel.org, but that should be no excuse 
from my side for being unresponsive. Thanks for your help!

Please contact me on IRC for any coordination.

Regards,
Matthias


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
