Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9E7F64EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbjKWRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:10:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C0CB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:10:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so1559674a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700759421; x=1701364221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SFIzPt7TEX9nsF6CmEt2y+2kFBYceN5ADYmICOYrZM=;
        b=WQ8S3eSst8h2CA0I6RYvHHQJtkMlslcg6CGqLiYHLzuhUfvfx+EuVzaBGn9xUqH93X
         okddBTfi4TyXRbKtstu8Fr8er+QJHSPmACeeV8+f6Q0vnu7JBy8lGNl58XOSoJpJ4FUJ
         TCLVkybbdBBsBqjYK95uzzEvREKEr5GvAuKx5nJRw9+1c/caiBsJErGlhGNdJhbttlR3
         phzvqnBeaaga2JxTlry2/AgDOr4mZCJpOswXXiuEigxGwAfMQbFVCD3Re2al7mBHpJBn
         hnjmGekwrCZLltIfwS6f8vECsYomq5tCRFPE6e3PAWtruOOX6l+YxIvFB3RFh2fMSwMI
         w35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759421; x=1701364221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SFIzPt7TEX9nsF6CmEt2y+2kFBYceN5ADYmICOYrZM=;
        b=jtIayD5eq3MRBMO5YcGCZMGM+1kTjnsl8KtvfQd+k/Jq6+hfQeKcngeJyPeILRgjnW
         6Ul2B87J7/VOQuyTJBsnKw2NW5foEKn+eUiQueABjq4VBsTKYKBR8hKXEJJCxF276W2A
         XEJRlaSMXeHBYKmbwORMEEDISDg1pTQbhX9YAPW+0VmQ9Euk/uEW5t+U0olG8ckE9Sfp
         ItNqwqOFnh7LwGpvNjzxTptRaUsHGifJri/ecsp7SxgJTlft1jDRhnttiTUukWlrBCkx
         g4oKCwcClhhgFkNHVZb0JVNOrrYtgWVcqTPPgRA/swYcm0wHC24abNfaga5dkUWCAfQF
         x4/g==
X-Gm-Message-State: AOJu0YxnxbWwPeF3hrFI15EwfnbHnblT3Z2lPW8Xqca47HpQxsSknm5x
        +vmZ5Q+lru2Tjs+SNTT6VpqIUA==
X-Google-Smtp-Source: AGHT+IFCYKgtF3mjNW4AH91q6HDmr7WR4otmQC45N+hCgGoUwH/B1qJH8bZX7d0ZE0lapIiwwntAaw==
X-Received: by 2002:a50:d747:0:b0:54a:b02e:1ffe with SMTP id i7-20020a50d747000000b0054ab02e1ffemr1648458edj.20.1700759421101;
        Thu, 23 Nov 2023 09:10:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640210cf00b0054847e78203sm840661edu.29.2023.11.23.09.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 09:10:20 -0800 (PST)
Message-ID: <a9760bbb-d06d-4914-b0d1-48a224f74858@tuxon.dev>
Date:   Thu, 23 Nov 2023 19:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] net: ravb: Rely on PM domain to enable refclk
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV=2_h2PW9K7zT3Hwqjdk6D2m_Dd09bqHtifAvVTM7Lrw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdV=2_h2PW9K7zT3Hwqjdk6D2m_Dd09bqHtifAvVTM7Lrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 23.11.2023 10:48, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch (which seems to have been delayed by 3 days, ouch)!
> 
> On Thu, Nov 23, 2023 at 5:35 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> For RZ/G3S and RZ/G2L SoCs the Ethernet's reference clock is part of the
>> Ethernet's power domain. It is controlled though CPG driver that is
>> providing the support for power domain that Ethernet belongs. Thus,
>> to be able to implement runtime PM (at least for RZ/G3S at the moment)
> 
> Why only for RZ/G3S?

(I'm copy pasting here what I already replied to Sergey)

The reasons I've limited only to RZ/G3S are:
1/ I don't have all the platforms to test it
2/ on G1H this doesn't work. I tried to debugged it but I don't have a
   platform at hand, only remotely, and is hardly to debug once the
   ethernet fails to work: probe is working(), open is executed, PHY is
   initialized and then TX/RX is not working... don't know why ATM.

> 
>> w/o the need to add clock enable/disable specific calls in runtime PM
>> ops of ravb driver and interfere with other IP specific implementations,
>> add a new variable to struct_hw_info and enable the reference clock
>> based on the value of this variable (the variable states if reference
>> clock is part of the Ethernet's power domain).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/net/ethernet/renesas/ravb.h
>> +++ b/drivers/net/ethernet/renesas/ravb.h
>> @@ -1043,6 +1043,7 @@ struct ravb_hw_info {
>>         unsigned nc_queues:1;           /* AVB-DMAC has RX and TX NC queues */
>>         unsigned magic_pkt:1;           /* E-MAC supports magic packet detection */
>>         unsigned half_duplex:1;         /* E-MAC supports half duplex mode */
>> +       unsigned refclk_in_pd:1;        /* Reference clock is part of a power domain. */
>>  };
>>
>>  struct ravb_private {
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 836fdb4b3bfd..ddd8cd2c0f89 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2502,6 +2502,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
>>         .tx_counters = 1,
>>         .carrier_counters = 1,
>>         .half_duplex = 1,
>> +       .refclk_in_pd = 1,
>>  };
>>
>>  static const struct of_device_id ravb_match_table[] = {
>> @@ -2749,12 +2750,14 @@ static int ravb_probe(struct platform_device *pdev)
>>                 goto out_release;
>>         }
>>
>> -       priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>> -       if (IS_ERR(priv->refclk)) {
>> -               error = PTR_ERR(priv->refclk);
>> -               goto out_release;
>> +       if (!info->refclk_in_pd) {
>> +               priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>> +               if (IS_ERR(priv->refclk)) {
>> +                       error = PTR_ERR(priv->refclk);
>> +                       goto out_release;
>> +               }
>> +               clk_prepare_enable(priv->refclk);
>>         }
>> -       clk_prepare_enable(priv->refclk);
> 
> Is this patch really needed? It doesn't hurt to manually enable a
> clock that is also under Runtime PM control.  Clock prepare/enable
> refcounting will take care of that.

I agree with that. I chose this path to not interfere w/ the comments
ravb_runtime_nop() which I didn't understand. Also I fail to understand why
the ravb_runtime_nop() is there...

> 
>>
>>         if (info->gptp_ref_clk) {
>>                 priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>> @@ -2869,7 +2872,8 @@ static int ravb_probe(struct platform_device *pdev)
>>         if (info->ccc_gac)
>>                 ravb_ptp_stop(ndev);
>>  out_disable_refclk:
>> -       clk_disable_unprepare(priv->refclk);
>> +       if (!info->refclk_in_pd)
>> +               clk_disable_unprepare(priv->refclk);
>>  out_release:
>>         free_netdev(ndev);
>>  pm_runtime_put:
>> @@ -2890,7 +2894,8 @@ static void ravb_remove(struct platform_device *pdev)
>>         if (info->ccc_gac)
>>                 ravb_ptp_stop(ndev);
>>
>> -       clk_disable_unprepare(priv->refclk);
>> +       if (!info->refclk_in_pd)
>> +               clk_disable_unprepare(priv->refclk);
>>
>>         /* Set reset mode */
>>         ravb_write(ndev, CCC_OPC_RESET, CCC);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
