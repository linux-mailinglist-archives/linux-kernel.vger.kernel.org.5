Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101AA7F538B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjKVWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjKVWoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:00 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7718E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:43:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-357cc880bd8so1041165ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700693037; x=1701297837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uQWLtXvGOw3ykzrrU4k8v24BV7qfGLjUcROVaGJI+0=;
        b=tTXLEysy7dHrGxlhqbekOvGqQR03prQlWP+0xXIVauxfzUVRc+rMX7usSl2YyhJBCR
         WQSIiiQgOu8IWfoX7v4jHgYoXAWHPS8hOS6z59BoHDHn1Xn3DjVljAVo1gRoK+viT1me
         uNROZu+JY0hGynMvjvKK6Lq45bgYv7ITh+ITdtrBTkq6T+PeOu6Cq7Njis1QYO5+eDiJ
         47iN1QXga9nBHLMVPK/5WnDiLNwexprvmC7lpDlpe4pjF5Ax1RrbfWg5FXC9YszyEhnp
         US/SyPxKlbT53Ik9GwMqiRpdRa6D7JXqLgQ1mNFy1fiZSXu9Kh1xLcTGvG7iji0gkggg
         Ss2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693037; x=1701297837;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uQWLtXvGOw3ykzrrU4k8v24BV7qfGLjUcROVaGJI+0=;
        b=CjMF9am628hq4avDRH/2xHPvm3j5HuEeXtztwN3X7UGI5OTevcVU63Uj1y0TDVis8H
         /2EVK5XjwfxcUItwoHI9OGshwiTIZOupq80LsOi9680xSvtV68p1jYQGghmSB3v7vTPp
         wG7JuEKXyl99MSIMt1yAle415bEZAwA4M7nRnRUswR3hH84KSdKG65yUZGBpiwqgDOd3
         4zOyIupnNKlwGAx81xeyrsZsIh2G620QbrA3URAfyPn8am0T+FYcUojkUkD8tanfUxT8
         AaJznscq0eN30ktQ037KwFXyRuchlaq4SKj3Wj4jui766hlTJyc7Jr/lfY9joyjtizKc
         utfA==
X-Gm-Message-State: AOJu0YzImoym+c4vpf5e3VE4sthcvAOJK2pO5Q87oUBjK80KiVBiZIJp
        H+QYA9MA3q6VuwWCP4XtN3DTCw==
X-Google-Smtp-Source: AGHT+IFOPvtZpcwPXuq8eUu58wUK/6nPgwmjHf3787rZ+5lhZhoC3jeRFLZhZtUkV1G97+aBxx5dbA==
X-Received: by 2002:a92:c56f:0:b0:351:5acb:281 with SMTP id b15-20020a92c56f000000b003515acb0281mr4482037ilj.31.1700693036861;
        Wed, 22 Nov 2023 14:43:56 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id eq25-20020a0566384e3900b0041e328a2084sm101532jab.79.2023.11.22.14.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 14:43:56 -0800 (PST)
Message-ID: <90d55f78-c31b-4764-958e-4ad88374518b@linaro.org>
Date:   Wed, 22 Nov 2023 16:43:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipa: fix one GSI register field width
Content-Language: en-US
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122212504.714276-1-elder@linaro.org>
In-Reply-To: <20231122212504.714276-1-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/22/23 3:25 PM, Alex Elder wrote:
> The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
> is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.
> 
> Fixes: 627659d542c5 ("net: ipa: add IPA v5.0 GSI register definitions")

All is well on this, but I put the wrong commit hash on the
"Fixes" tag.  I'll send an update soon.  The correct hash is
faf0678ec8a0.

					-Alex

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
> index d7b81a36d673b..145eb0bd096d6 100644
> --- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
> +++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
> @@ -78,7 +78,7 @@ REG_STRIDE_FIELDS(EV_CH_E_CNTXT_0, ev_ch_e_cntxt_0,
>   		  0x0001c000 + 0x12000 * GSI_EE_AP, 0x80);
>   
>   static const u32 reg_ev_ch_e_cntxt_1_fmask[] = {
> -	[R_LENGTH]					= GENMASK(19, 0),
> +	[R_LENGTH]					= GENMASK(23, 0),
>   };
>   
>   REG_STRIDE_FIELDS(EV_CH_E_CNTXT_1, ev_ch_e_cntxt_1,

