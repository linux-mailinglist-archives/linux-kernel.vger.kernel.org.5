Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E97B11A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjI1Ekv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Ekt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:40:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDE121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:40:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so1308766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695876045; x=1696480845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhNjgJLO3psdT40vxaz4v6qba6rjpNNWRaCJEnQpK0s=;
        b=F7sYy79iZKfzfTga13dOTiabGak6L659KciMIXAOgEpgA1zXTKn20F38XH6+F5Xo7H
         KY/Hf8BZTX32tf/95zvzoAoPRv6HWDyCrjxsA4ITZaLok09+Y15C8RdChKEd8naxaxZL
         buSJTAKF4hy9ncIV/eDNEQtmeizFK9nrreZ85LX+kV+bA9AhJFflioU8/9O7/I/xJLCg
         oTqqsvlCMOVlVZM1qr7WcX2tbl/wbSi/SVYuHIVzHuXjWt3RkwJ9okrf4sCQnSi7CMjp
         smLPgC/a1F0iH/DZTs0sJaV3aXpqf4eWYO4aLJ66uDoBURBfBObJV1OJosd+ehSWo+KN
         +SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876045; x=1696480845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhNjgJLO3psdT40vxaz4v6qba6rjpNNWRaCJEnQpK0s=;
        b=Jkkn8TLd79sNNwqTt7w+QmZ91ULFbVFeC5cKuhtxEa2mIyOdSDBiSSTdXSniXvoj7h
         junGwGqa6q2iHobNm80ExMRytinb/RhKH764/6/A77YIUTgaQD6WYCPoygjga0AYhr3g
         vxkN9jzHmHEMNUFVnzjMzr5/Wig/NNj8ei6EQTyqX4bk73+0ig/Hu75+cUHWpkWBPlwm
         tdF5wohOIGAQKMMaL6d8dBe4bySd+aCevl1kVBTzvSJHu0MI9iM/hv6A6LXXCmIyuXiH
         /5GJdMdZQB7lZpNK93spxJGIdLCwD+VbxV60wFCddzmZujO3I/9PAlxW49mky8PP9vLh
         hjnA==
X-Gm-Message-State: AOJu0YyG39OtWjEL8r/QMT6uZTPwVqJcgHzNesrMr3YibI6PoCDYp0W+
        m1ZUnqzRdKCEJuun73Q/MpQ=
X-Google-Smtp-Source: AGHT+IGaU7XMelu4ZAxTB8eQWtfgME7OwgcWlUF/J14/jA882F+DTdCRRsf1txJAy547LRwzvpKGEQ==
X-Received: by 2002:a17:906:74d4:b0:9b2:b149:b816 with SMTP id z20-20020a17090674d400b009b2b149b816mr125767ejl.7.1695876044617;
        Wed, 27 Sep 2023 21:40:44 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id mc1-20020a170906eb4100b009a5f1d1564dsm10085395ejb.126.2023.09.27.21.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 21:40:44 -0700 (PDT)
Message-ID: <d9a089f9-c439-97bd-5abc-18390c3ec0cb@gmail.com>
Date:   Thu, 28 Sep 2023 06:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] staging: rtl8192e: renamed (3) variables
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230928000225.27912-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230928000225.27912-1-garyrookard@fastmail.org>
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

On 9/28/23 02:02, Gary Rookard wrote:
> This patch renames the vaiable in staging/rtl8192e
> HTUpdateDefaultSetting -> ht_update_default_setting
> in (3) files of rtl8192e:
> 1) rtl819x_HTProc.c
> 2) rtllib.h
> 3) rtllib_module.c >
> Linux Kernel Coding Style "cleanup", no change in runtime,
> staging/rtl8192e builds before and after.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Hi Gary,

your subject is to general and also wrong as you change just one 
variable. Please find good examples in the in the kernel log.
Or here:
https://lore.kernel.org/linux-staging/20230921032515.96152-2-tdavies@darkphysics.net/T/#u

Omit the file names in the description as this is redundant.

You need a version history for all four versions of your patch.
See example:
https://lore.kernel.org/linux-staging/ZQGiqA2GoDp%2FWiPK@ubuntu.myguest.virtualbox.org/T/#u

Bye Philipp


> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index a7e356e90d0e..832f595d36c2 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
>   
>   static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
>   
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee)
> +void ht_update_default_setting(struct rtllib_device *ieee)
>   {
>   	struct rt_hi_throughput *ht_info = ieee->ht_info;
>   
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index bdbd27e382b9..ec1eef7486a2 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1785,7 +1785,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
>   void HTSetConnectBwMode(struct rtllib_device *ieee,
>   			enum ht_channel_width bandwidth,
>   			enum ht_extchnl_offset Offset);
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee);
> +void ht_update_default_setting(struct rtllib_device *ieee);
>   void HTConstructCapabilityElement(struct rtllib_device *ieee,
>   				  u8 *posHTCap, u8 *len,
>   				  u8 isEncrypt, bool bAssoc);
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index abd6bfd4dfa3..859241af617c 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -126,7 +126,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>   	if (!ieee->ht_info)
>   		goto free_softmac;
>   
> -	HTUpdateDefaultSetting(ieee);
> +	ht_update_default_setting(ieee);
>   	HTInitializeHTInfo(ieee);
>   	rtllib_ts_init(ieee);
>   	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)

