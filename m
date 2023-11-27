Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D87FAAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjK0UDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0UDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:03:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE91B4;
        Mon, 27 Nov 2023 12:03:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b34563987so26852535e9.1;
        Mon, 27 Nov 2023 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701115426; x=1701720226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrenRkYX5OlKn+U0eAbEsoDGW+6wabmBKzhiSthE5gY=;
        b=ZcW0nrI2nh+ZtsMpZWRQmlHRgdb17MNO+O1uiBXONhKAwD1coUB8nzJkxIl2uEuNs7
         DuKtfyhRtC4XevzU2YzfX6oP9Hh6omookaMHc3jdNrjKQ3aNdYxERVjEMwzc5rbZaPUj
         Uuqgz575Qga7xEE0Alr/aWTU8mnZp9eT6goqmUO048/3orbx5LeuH+Iw0wzoT3K4mYJM
         pKCCyRDLy5Ipvn+07rLLiIF4/fWlg4dQlIFxNb0IOnhLUMF4OxI/FLGMLANL6IX70Jqh
         xxgBuiGCVRHhtCEuqo2M6g6kJmVRTWvLegPW1p/8dE/1XsL9eQDuA4RiQys7jN8auYrj
         UA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115426; x=1701720226;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrenRkYX5OlKn+U0eAbEsoDGW+6wabmBKzhiSthE5gY=;
        b=oS3nIq9SV+yZbZLb2IPWkRJMg1qIp/E6XqxwyMyl4CUSFOoKlz/KFuvEAZuatSs+3g
         f5u/3HF2jsA9KTSk6/5edFslCdQ56+quIkZPIuD6XufsgqwXPH1NFk0G383O8GdKs9YB
         RaCPPLun2a4xwTRo5/1c7sAEcFBNs5YXc+jnZvxaVt7xCiYA0j0sBy/XuGrd1uEe5nTD
         09tAYsVUn9SWt7qVMSNZUEKOcktMIdjTbo8f5oRrTf1lu6P8EJ0Lwf/CfId5Eb2XVu3F
         Z0q2XvssjMDfTV+jcwoD7rjyHQkLtT2jyd+d3r9tkcNFjY6033dTDW9z7xhc4UDFb+eH
         v5DQ==
X-Gm-Message-State: AOJu0YwmFpeB+fPVZTswi/yGkWPjUoaBHDCeXTJTMU9bs1laZo5xwYri
        NcuvTPZPQPmDZlyyYsx/QW6GzkmauyQ=
X-Google-Smtp-Source: AGHT+IEJ1puNxDQbBpthZ8s68hP716s8Man2JGUTm2nrlJZdNZh/bCiCUPYEaAFE0kp9VRCwBzjLMg==
X-Received: by 2002:a05:600c:1c89:b0:3fe:d67d:5040 with SMTP id k9-20020a05600c1c8900b003fed67d5040mr14688007wms.5.1701115425969;
        Mon, 27 Nov 2023 12:03:45 -0800 (PST)
Received: from ?IPV6:2a01:c23:b815:5700:a463:59a7:865f:2563? (dynamic-2a01-0c23-b815-5700-a463-59a7-865f-2563.c23.pool.telefonica.de. [2a01:c23:b815:5700:a463:59a7:865f:2563])
        by smtp.googlemail.com with ESMTPSA id t15-20020a5d6a4f000000b0033169676e83sm12862466wrw.13.2023.11.27.12.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 12:03:45 -0800 (PST)
Message-ID: <a5f89071-f93b-4a30-a0c5-f9dfda68367c@gmail.com>
Date:   Mon, 27 Nov 2023 21:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] r8169: enable rtl8125b pause slot
Content-Language: en-US
To:     ChunHao Lin <hau@realtek.com>
Cc:     nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, grundler@chromium.org,
        stable@vger.kernel.org
References: <20231127175736.5738-1-hau@realtek.com>
 <20231127175736.5738-2-hau@realtek.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231127175736.5738-2-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.2023 18:57, ChunHao Lin wrote:
> When FIFO reach near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reach near empty state.
> 
> When pause slot is disabled, if there is no one to handle receive
> packets (ex. unexpected shutdown), device FIFO will reach near full
> state and keep sending pause frames. That will impact entire local
> area network.
> 
> In this patch default enable pause slot to prevent this kind of
> situation.
> 
Can this change have any side effect? I'm asking because apparently
the hw engineers had a reason to make the behavior configurable.

> Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 295366a85c63..473b3245754f 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -196,6 +196,7 @@ enum rtl_registers {
>  					/* No threshold before first PCI xfer */
>  #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
>  #define	RX_EARLY_OFF			(1 << 11)
> +#define	RX_PAUSE_SLOT_ON		(1 << 11)

Depending on the chip version this bit has different meanings. Therefore it
would be good to add a comment that RX_PAUSE_SLOT_ON is specific to RTL8125B.

>  #define	RXCFG_DMA_SHIFT			8
>  					/* Unlimited maximum PCI burst. */
>  #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
> @@ -2305,9 +2306,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
>  		break;
> -	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
> +	case RTL_GIGA_MAC_VER_61:
>  		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>  		break;
> +	case RTL_GIGA_MAC_VER_63:
> +		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
> +			RX_PAUSE_SLOT_ON);
> +		break;
>  	default:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
>  		break;

