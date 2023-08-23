Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56773785CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjHWPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjHWPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:54:35 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08497E5F;
        Wed, 23 Aug 2023 08:54:33 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1ccd5b1b9d0so248582fac.1;
        Wed, 23 Aug 2023 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806072; x=1693410872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2VDLlTrw+KZAlR49NajxO5L4C9/jMnmujffHvdDJcQs=;
        b=TWPitcP3YEZUukBZVunu8PzCPZoXcWsM3TV5NpvSYmWBc5Q4V6dH5euWfnbPlNUwM8
         0nmbAAI16t5gbAkcMdIVZ/sqI0DwwQNHeokEs3kB0gi6u2VuwS0bc4K4KhPccpYM7/h9
         CQc00tM3fzAIad7IHy28H9jMyW0oNLTJqIdk5vNzIdK70Ej+kstomGCF1/D7gYsVUI75
         Rr9G/yPdaJiMTgYBVDspcUwfaIKo1lQKbqdM06R3vN1hswZT+mbTqlGlothZ9rToLdKo
         OrtCqh54LQD3p9fTfkMS9EqvxnqCh9jFwyC156WolI8aDK9d7YIF0lkQqpEMWPXAK07p
         /ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806072; x=1693410872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VDLlTrw+KZAlR49NajxO5L4C9/jMnmujffHvdDJcQs=;
        b=Mggkhln3+gSmITcB3r7S7dJltXf/LP7SEWQeUkHMTa4OoDBl+ydI9jZsECoxjCJLb2
         BGMnlgW9h4IbZqdb0DqwGe6svGfofMhoE7Xcs1o8ll4UVHSHTLIAG+Lc3SVc9Bqc9o+o
         girjs/zxT/zc1bErHlFVhHoXpvqCdq2B+DdnxtMJP3BNl+6E9WONstEbzu517Y8vz4DY
         FzQfshJ6fKKtnfOJEMfe1CPFqLmmMan0Doecj2xgBOH6vDkqfPgiSOfBugFJDZmGOT0/
         VT0VD9PCZIjTl/i+Qg5eqJpAO1GqDztGhEATO6xz41/bYmmN1WH7VKsbuKy/tw/4436a
         aL4g==
X-Gm-Message-State: AOJu0Yxm2/v+tOMDz7y/pNfML7SalZcRcTGlidniNLWUB6/yNuuFYsc3
        50G1ezQU02GCT1wL4gX4zpM=
X-Google-Smtp-Source: AGHT+IF61HSy033UpFh/6+Ke2kdywsHMIGweM8p3uBkmXG7/0UnB78wpgxYLgPqQ/ckE32rss1aOhw==
X-Received: by 2002:a05:6870:e2d1:b0:1b7:4655:2ac9 with SMTP id w17-20020a056870e2d100b001b746552ac9mr16134185oad.6.1692806072168;
        Wed, 23 Aug 2023 08:54:32 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870734700b001c0e840ebcfsm7059351oal.35.2023.08.23.08.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 08:54:31 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ffe7cc73-d2c7-d6d7-69e8-438a4a2f7be6@lwfinger.net>
Date:   Wed, 23 Aug 2023 10:54:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: rtw88: usb: kill and free rx urbs on probe failure
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Ilgaz_=c3=96cal?= <ilgaz@ilgaz.gen.tr>,
        kernel@pengutronix.de
References: <20230823075021.588596-1-s.hauer@pengutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230823075021.588596-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 02:50, Sascha Hauer wrote:
> After rtw_usb_alloc_rx_bufs() has been called rx urbs have been
> allocated and must be freed in the error path. After rtw_usb_init_rx()
> has been called they are submitted, so they also must be killed.
> 
> Add these forgotten steps to the probe error path.
> 
> Besides the lost memory this also fixes a problem when the driver
> fails to download the firmware in rtw_chip_info_setup(). In this
> case it can happen that the completion of the rx urbs handler runs
> at a time when we already freed our data structures resulting in
> a kernel crash.
> 
> fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Reported-by: Ilgaz Öcal <ilgaz@ilgaz.gen.tr>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/net/wireless/realtek/rtw88/usb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 4a57efdba97bb..875a61c9c80d4 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -844,7 +844,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   
>   	ret = rtw_core_init(rtwdev);
>   	if (ret)
> -		goto err_release_hw;
> +		goto err_free_rx_bufs;
>   
>   	ret = rtw_usb_intf_init(rtwdev, intf);
>   	if (ret) {
> @@ -890,6 +890,9 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   err_deinit_core:
>   	rtw_core_deinit(rtwdev);
>   
> +err_free_rx_bufs:
> +	rtw_usb_free_rx_bufs(rtwusb);
> +
>   err_release_hw:
>   	ieee80211_free_hw(hw);
>   

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks Sasha,

Larry

