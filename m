Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF57B11DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjI1E5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1E5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:57:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926D8F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:57:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a1bcc540c0so322304666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695877025; x=1696481825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjnVhTmViUFUS8jPDfsX5EBBj4w0ohMdGnL+g6iEKxk=;
        b=NDhldVO0cYL9BAv6Emb2a34CrQoZlwtOxJw4FBe3wxOm4p1lzLrG2VTWDqKzfgBBvh
         HfVKoS5IUKnaqUB2Z+HN3lvLQg0AVEhoi65BXVONJdY1O7y02Jy+FEfh6IM7WzviNxdv
         a6qga1pLPSrrEY899VoH1WsPpxjA8Dy1Y1jTzQQpcEF2PP9QwRJMfLPC4rAbwaWUCK4X
         oHnyXPX4CQfLw1lSz2sU3m5Lh08zUD4zsAQVv2u50289j/6dcAsN1qBoxB6za7pYvhRL
         kQUs1h9G1QjUxBy1xL+AqAMiZhezZLpmCc5fP8ZBaEv+ESA3QRFyoie7grAFfxH7TbmT
         x5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877025; x=1696481825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjnVhTmViUFUS8jPDfsX5EBBj4w0ohMdGnL+g6iEKxk=;
        b=QtAw3VqkydQ6+0PWI0YADIqz3KLFx/ISPotHj3rGZvXCvUBwBHV7ILUIpSqWvqXlOr
         tD26+fR9B1z2n0SmmWIefxF7BlsNwGjWQvXM98lPMwfQV6PtSy8a3fJfLFqV2Jelx4a3
         l9ZxnBbE25h++5j+jqtv3m5S1OwGulYydcV4HP4ETk3wTNd7E18D6UuG5NhM0n+mn8Qp
         ivCS9oQxOTj0knyxbvCi3PFv1jQwaxCpjARKaAp3x7MZlA+Ds0/Tg4Gy9eiLCs0ePjBc
         XkpJM4vw8PEHt6zQj5JgWqKWMx4fqQqcoYGgcEow6uzLh6pwie4aU/SqkrqoPX/OAstP
         lp4A==
X-Gm-Message-State: AOJu0YxNRditYxz/nqhuhFZV3KZsIL+PmeyBFWDVLeKF1i+Gxmau3afX
        OCpZLIZHUFxBI8O4LyKmy1w=
X-Google-Smtp-Source: AGHT+IFl8dxrPg/Ls8y0D5pASvHo2j7uZbw0BIxs5Owu8m9CsYgTEmSYxkVAb08p94lWyCyEKvdRYQ==
X-Received: by 2002:a17:906:74c1:b0:9ae:3ee2:6feb with SMTP id z1-20020a17090674c100b009ae3ee26febmr122922ejl.2.1695877025015;
        Wed, 27 Sep 2023 21:57:05 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906168c00b009737b8d47b6sm10161717ejd.203.2023.09.27.21.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:57:04 -0700 (PDT)
Message-ID: <b3317aa5-e26a-227b-e0f4-9c98d10aad4e@gmail.com>
Date:   Thu, 28 Sep 2023 06:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] staging: rtl8192u: ieee80211: renamed duplicate
 variable
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230928033220.31783-1-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230928033220.31783-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 05:32, Gary Rookard wrote:
> This patch renames a duplicate variable found in both rtl8192e and
> rtl8192u causing the preprocesser/compiler to compile without error
> when in fact it should throw an error/break the build.
> 
> Prototype in files:
> rtl8192e/rtllib.h      remaining as ht_update_default_setting
> rtl8192u/ieee80211/ieee80211.h   changed to __ht_update_default_setting
> 
> Function in files:
> rtl8192e/rtl819x_HTProc.c remaining as ht_update_default_setting
> rtl8192u/ieee80211/rtl819x_HTProc.c  changed to __ht_update_default_setting
> 
> Referenced in files:
> staging/rtl8192e/rtllib_module.c  remaining as ht_update_default_setting
> staging/rtl8192u/ieee80211_module.c changed to __ht_update_default_setting
> 
> Linux Kernel Coding Style "cleanup", no change in runtime,
> staging/rtl8192e and rtl8192u compile/build before and after.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---

Hi Gary,

this patch cannot be applied. I cannot find the variable 
ht_update_default_setting in this driver.

Bye Philipp

>   drivers/staging/rtl8192u/ieee80211/ieee80211.h        | 2 +-
>   drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 +-
>   drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index 4e598c7f0d31..ae2fb249eaa1 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -2293,7 +2293,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString);
>   
>   void HTSetConnectBwMode(struct ieee80211_device *ieee,
>   			enum ht_channel_width Bandwidth, enum ht_extension_chan_offset Offset);
> -void ht_update_default_setting(struct ieee80211_device *ieee);
> +void __ht_update_default_setting(struct ieee80211_device *ieee);
>   void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap,
>   				  u8 *len, u8 isEncrypt);
>   void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo,
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> index 6f6813899e31..f35765167e1b 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> @@ -146,7 +146,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
>   		ieee80211_networks_free(ieee);
>   		goto failed;
>   	}
> -	ht_update_default_setting(ieee);
> +	__ht_update_default_setting(ieee);
>   	HTInitializeHTInfo(ieee); /* may move to other place. */
>   	TSInitialize(ieee);
>   
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> index cf9400859700..d5354147e7ae 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> @@ -56,7 +56,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
>    *  return:  none
>    *  notice:  These value need be modified if any changes.
>    */
> -void ht_update_default_setting(struct ieee80211_device *ieee)
> +void __ht_update_default_setting(struct ieee80211_device *ieee)
>   {
>   	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
>   	//const typeof( ((struct ieee80211_device *)0)->pHTInfo ) *__mptr = &pHTInfo;

