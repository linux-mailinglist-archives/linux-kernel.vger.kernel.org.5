Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEE75969C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGSNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGSNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:25:26 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DBF123;
        Wed, 19 Jul 2023 06:25:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1ba5cda3530so3639962fac.3;
        Wed, 19 Jul 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773119; x=1692365119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vwI6kexQ3nCLrkSp8D5XbBNR32OWR5f2InG3XH4JK6A=;
        b=rp/EGIDSt50eNXwMC8AL+h4Y2CMyWUkJHoZGGGWQm2ed6u/crnWbDQjg9yQVSVpv6R
         d+YMO9H60tIDPhIHKxXskAu+hthKP9CVAKYtGohADYi29dCfC7dLV1YOOwbm7Ec0zjDo
         gxZc9GQbQ8HIFZYR7kRRX0mxTupfTh1PEDxueKj9RhjQpvmd7VQL5+jeeujN97XyFIzx
         yDN2spSCPl6eI79DFlrq8GAz4C6vTxcDDaBG2kArcrwDwgthmatJQebB0cGuCdznWXhv
         bdn41NqSIBiwxKnLwyLqVcjFuRg0CH5DZvRWKnlS9KNuLuwZctvHohWx6tjJ2S36mEIV
         G0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773119; x=1692365119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwI6kexQ3nCLrkSp8D5XbBNR32OWR5f2InG3XH4JK6A=;
        b=Bb7cDhJhJ8vWZqadSYYFvjLMtXRoAkQb92W5LyhuQznGAIhMPkQOMfWJ0u4GMaDaaf
         5HbL5emUUIUL2MwBAnDHAih7+RWJLnLmBWhD3d3SUZwpQ9cftdt3CDPwADVF2Gv759CN
         Ty52SIwy25Diw+Z2QebdPd5udLp8oVpJDVsK4aNKXIzxj/y6+gDq9hidiILp0jfMIqLa
         msjwAYtpBn24XTFM2KgGfMfTBPaKVtRLv49bkEJ0XbGU7OYTrzcEKm4DiUyV6/jRnMZM
         16vDK0sLUy2Bs5ImG/is35WWqluyk7ygOzyHWwRW+8NgNXACsi2s1kGi1IEA77xIfd69
         UaAg==
X-Gm-Message-State: ABy/qLb48aBAIjoPGq5Hcs8Czcw+fADmGBnMNeAb8XkFalbEJNuEqqIW
        S1yuo0WkqaCvreoNOAFKUXQXvFDqBUM=
X-Google-Smtp-Source: APBJJlFJX71eb0BRhfpiwI8I+lH5atCgYCWT5lq/WL3dRDFdseAlr/4kcf1k4gokGCRw/PH5ugETBA==
X-Received: by 2002:a05:6870:3306:b0:1ba:5464:774d with SMTP id x6-20020a056870330600b001ba5464774dmr13992175oae.19.1689773118816;
        Wed, 19 Jul 2023 06:25:18 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r76-20020a4a374f000000b0054fd51435efsm1878709oor.8.2023.07.19.06.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:25:18 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <660f59ed-b936-1667-c7ab-ba21bac60836@lwfinger.net>
Date:   Wed, 19 Jul 2023 08:25:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rtlwifi: rtl8192de: phy: "foo * bar" should be "foo *bar"
Content-Language: en-US
To:     hanyu001@208suo.com, pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_56B12E143DA8D1D6A9C3669E04C963914905@qq.com>
 <8ef50a4e96014949bbfde956edd07108@208suo.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <8ef50a4e96014949bbfde956edd07108@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 04:54, hanyu001@208suo.com wrote:
> 
> This patch fixes the checkpatch.pl error:
> 
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c:2434: ERROR: "foo * bar" 
> should be "foo *bar"
> 
> Signed-off-by: Yu Han <hanyu001@208suo.com>
> ---
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c 
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> index d18c092..27b029b 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> @@ -2431,7 +2431,7 @@ static bool _rtl92d_is_legal_5g_channel(struct 
> ieee80211_hw *hw, u8 channel)
>   }
> 
>   static void _rtl92d_phy_calc_curvindex(struct ieee80211_hw *hw,
> -                       u32 *targetchnl, u32 * curvecount_val,
> +                       u32 *targetchnl, u32 *curvecount_val,
>                          bool is5g, u32 *curveindex)
>   {
>       struct rtl_priv *rtlpriv = rtl_priv(hw);

The preferred subject would be "wifi: rtlwifi: rtl8192de: ...." That can 
probably be fixed at merge time. I will let Kalle decide that part.

Reviewed-by: Larry Finger<Larry.Finger@lwfinger.net>

Thanks,

Larry

