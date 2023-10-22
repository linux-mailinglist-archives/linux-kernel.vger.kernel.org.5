Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464007D2194
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJVGi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 02:38:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E02114
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:38:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso595144a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697956732; x=1698561532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN+K7djNf+LUAL45GOvKxbnMR4ijDhW80HufDhemqvg=;
        b=j2GeFSKZE21RyrE96SYlZ/vPYKHGJkWM8AKleSvC6vP2lXBy0aJa14cffmTS411pIX
         j6wpsZ8EAoxGLzRdCY9bpXZVDUWvKHVTOttTiyDQedL6Ecpdaf5gL8Q3Rq3YlO3kbxXp
         vIjetI9WmzJyYGuuxbFl1TRbi35j7SmkVYyyX6oYbPSA93/O/Rd2O4ABk2lV+aMFshtv
         G2pMsODfKy+Ne2iOamV9fAc+iRCBRaDvMneNbyZSnwcnUoLboUuh0VYDJ9+rwaM4jozA
         eop2tHMiRvv4BT0ynQhZ/RdUxwl53dgy4dJjp6oL1nANrIFMrnnbSEx4k3CQxEHLmpbG
         2eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697956732; x=1698561532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN+K7djNf+LUAL45GOvKxbnMR4ijDhW80HufDhemqvg=;
        b=ZSY0g3Kq9M6mjhoQrfH2fJOLuxxibrAse21OnjHDg0IMZHBLhYb+sgghYk52jgFRf0
         VpV3O5f3ZnDu7Y2i0wRh3oWKkg0CQzQtqbQKAOGdC6ndv80s6cFQeO4mcLIQCCExdNp9
         ugqUVS/MILY4fQC0NqonAjDi+ZK1Abi6tTADL5z7eHKKstwMinbje4EWYvilSXzhzglE
         VF4a34atS8WbzGnlt67eCiyzIIjhQo/bIpw7yWyI7hmx8Ywr2AvkjwRUQX0jsoYU9o5y
         qRAEYILeIzlxplgaUEESJEnM2nQOB8z8heHbav+E0miCeR3w1VCumnFHVrfbBufTDYmY
         JV5Q==
X-Gm-Message-State: AOJu0YxxWRQK06KEX1AMMzUOGdVlr8szdN2QnHkeHziPv5ssBWg8TrO6
        /td3O6xkDH56ryyUPccZ+ZU=
X-Google-Smtp-Source: AGHT+IGkwx4ierVeDcl7EC1HxuWGhK+SwxMe0UEdJcCFgvcY2KDP80wEjG8/MR0XYiDUPvOE/u51+w==
X-Received: by 2002:a17:906:10c9:b0:9c4:4b20:44b0 with SMTP id v9-20020a17090610c900b009c44b2044b0mr3677698ejv.1.1697956732447;
        Sat, 21 Oct 2023 23:38:52 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b0099bccb03eadsm4507054ejb.205.2023.10.21.23.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 23:38:52 -0700 (PDT)
Message-ID: <e475d553-5cbc-4cca-89d1-09a587a99098@gmail.com>
Date:   Sun, 22 Oct 2023 08:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231021215440.6584-1-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231021215440.6584-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 23:54, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable
> TxCountDataRate, TxCountDataRate -> tx_count_data_rate.
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
> Removed parenthesis alignment, and removed corrected spacing from
> this patch. Only contains renaming variable.
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
>   drivers/staging/rtl8192e/rtllib.h            | 2 +-
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 00b21542ddc3..8070a152712e 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -114,7 +114,7 @@ static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
>   	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
>   }
>   
> -u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
> +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)

tx_count_to_data_rate

>   {
>   	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
>   				   0x24, 0x30, 0x48, 0x60, 0x6c};
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 9d141aad8cd5..6a9550eaf148 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1784,7 +1784,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
>   u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
>   void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
>   bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
> -u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
> +u16  tx_count_data_rate(struct rtllib_device *ieee, u8 nDataRate);

tx_count_data_rate

>   int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f32584291704..28aba1d610f7 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -208,7 +208,7 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
>   {
>   	u32 tmp_rate;
>   
> -	tmp_rate = TxCountToDataRate(ieee,
> +	tmp_rate = tx_count_to_data_rate(ieee,

tx_count_to_data_rate

>   				     ieee->softmac_stats.CurrentShowTxate);
>   	wrqu->bitrate.value = tmp_rate * 500000;
>   


Hi,

name of the function are different.

You need to do a compile testing before sending in.

drivers/staging/rtl8192e/rtllib_softmac_wx.c: In function 
‘rtllib_wx_get_rate’:
drivers/staging/rtl8192e/rtllib_softmac_wx.c:211:13: error: implicit 
declaration of function ‘tx_count_to_data_rate’; did you mean 
‘tx_count_data_rate’? [-Werror=implicit-function-declaration]
   211 |  tmp_rate = tx_count_to_data_rate(ieee,
       |             ^~~~~~~~~~~~~~~~~~~~~
       |             tx_count_data_rate
cc1: some warnings being treated as errors

Bye Philipp

