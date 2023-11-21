Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04E7F2593
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjKUGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjKUGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:00:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F336CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:59:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a0039ea30e0so168624966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700546395; x=1701151195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nTCzjxHp//sooNwCtarftLG+pat2FAqXZlC2XWtJQA=;
        b=YQ5BbQEygTDEAAqt8gqHhaP0XOc5VuN+JX47Bu0g6V7T+3ueAL27xBmNQ1mA9QIt8W
         XrdsfnxnS5ggukDm3RBgdhlHezBGcItLGOBg6/zD6513Y5byhP7aPhUOcH0dhb/Usx0G
         EvHwkjkXrPiwfIGf5fCkqMyxIMsX8WzCuJ/Myx/17vLPuS5B2S0lbNFNS/QJlvTjOU9+
         AHgy2yp6XT2csVkQYob/FL0D0j+utO8wkwbonrxYTvnbqmxo6ECIYd9vQSuvOGU8Labk
         YEaqlZiFhEd/U2lb/Qwzeq3MsP0Zl1yMJT06TIRhqO40N9Sk9Byje2AnsRv5sZ1hkbLH
         Rh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546395; x=1701151195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nTCzjxHp//sooNwCtarftLG+pat2FAqXZlC2XWtJQA=;
        b=r9QcQQ+tbrGFzpfqk/IUTGjaL+mkqlIkLVNV7h0Y3c6J5seFygSoPH0sE2nSmA80Kx
         HD/B48CigoaQ8cpPL5zco2P8ILYmshXNiADajhyf6cEUNtbBraieYi1L96aDIiejicSi
         EKcEyaQ9+0kSyF2cLXtj2PP8DCVq4ygwxpufnqMc6G99pXIaY+am1hK0U9ucdoGSpKMv
         6sJ1nuvXPDuMEXs2G1U9B3BQAwijNuOFFPORx9Epp7689hovkJbzufz/TE0NzAO+mC+2
         lKd+e5RfVxOMyki6q8RfvLJk3lB9tzlQklFaCvusYJ7hGB4ZCSfH9vrX0TqnFCuE+yQN
         klUw==
X-Gm-Message-State: AOJu0YwnF+EJ1CD4dXlGslAxgyXsu9IH8wl4XZiuzzmoykePgAVf3KYd
        U3RjOMg0hhiMaNk/z4h2AoOGqQ==
X-Google-Smtp-Source: AGHT+IFAEyQW7kPsn7TNdi+eaMRv89fKiODQ+1UVosx0dNnfCjK0Q8BtCqOnvE/mYe8ir0feNDQtgA==
X-Received: by 2002:a17:907:a18d:b0:9e2:8206:2ea9 with SMTP id om13-20020a170907a18d00b009e282062ea9mr5951111ejc.60.1700546395392;
        Mon, 20 Nov 2023 21:59:55 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906c19800b009a1b857e3a5sm4800689ejz.54.2023.11.20.21.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 21:59:55 -0800 (PST)
Message-ID: <12e63ae7-bc25-4790-883a-ee0eaa28317d@tuxon.dev>
Date:   Tue, 21 Nov 2023 07:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] net: ravb: Check return value of
 reset_control_deassert()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-2-claudiu.beznea.uj@bp.renesas.com>
 <2ac71d8d-84d8-2092-70b4-9ed21e78541f@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <2ac71d8d-84d8-2092-70b4-9ed21e78541f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.2023 21:03, Sergey Shtylyov wrote:
> On 11/20/23 11:45 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> reset_control_deassert() could return an error. Some devices cannot work
>> if reset signal de-assert operation fails. To avoid this check the return
>> code of reset_control_deassert() in ravb_probe() and take proper action.
>>
>> Fixes: 0d13a1a464a0 ("ravb: Add reset support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index c70cff80cc99..342978bdbd7e 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2645,7 +2645,12 @@ static int ravb_probe(struct platform_device *pdev)
>>  	ndev->features = info->net_features;
>>  	ndev->hw_features = info->net_hw_features;
>>  
>> -	reset_control_deassert(rstc);
>> +	error = reset_control_deassert(rstc);
>> +	if (error) {
>> +		free_netdev(ndev);
>> +		return error;
> 
>   No, please use *goto* here. And please fix up the order of statements under
> the out_release label before doing that.

This will lead to a bit more complicated patch, AFAICT. I tried to keep it
simple for a fix. Same thing for patch 2.

> 
> [...]
> 
> MBR, Sergey
