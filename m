Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9287E6EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjKIQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjKIQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:37:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7830C0;
        Thu,  9 Nov 2023 08:37:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c2a0725825so184114966b.2;
        Thu, 09 Nov 2023 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699547827; x=1700152627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELLAT455rlK2Wp5mHeL2SjOOXY/6fk9G0bSVgD3Qnzw=;
        b=V2Yf9BsyCakucvL1HxDpF09L0xyqclGFqFUnfKKeHHiCkGXopzYz/j51rfB236PiRa
         oTSVSPjdZ/53FcW+2GKMsN2FFIv10SEBcs26vWWCz7Yhs0c6BArBrrIsMemZ5zqKBCBJ
         R7iS14Bi+D2WRsinPfeZjAbx2s8JxX4ysNL0fXGjJd0KlM1qYzOCvpvPILSIOKzzKk2V
         wHrteAnn/UOE8waDjns55eUpFMQgPkVv4elpvSC6Rvi9rT0ok/tSG35eVY06ZEp+GZAS
         Zms643Fo5dp7IkFfFHvsoUFpfvPgIgBaG5Yv+YybdXqb4l8yP0nsSfSvHRrj7PDM5rml
         518A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699547827; x=1700152627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELLAT455rlK2Wp5mHeL2SjOOXY/6fk9G0bSVgD3Qnzw=;
        b=ZnFaTobp6yb7oysGpFP+5/r0vXQmNkqxEtezwzIyKpeFnFHHlZIsXhfwJ4fjz3ggwR
         TqAHWYKnOvG2eNKHvUMHa57DriBBcB45mFAFd+63266m0BxbQUmLp/wSVE9bgt0z/edZ
         qPabBSgX80EDaO4ZFZAYTxTgJDKJDAbGFCsRCPiu2QlXR08v+F8FXCavxuJibjzR7sKk
         4aoLSMLgVgKviKClnsNci4h7nP/YIr9HJgo12tu4Al/JuQQOzOnktDbTz4w4C4A30afL
         u50d9p8pGBPi6NH46Tnosmn3M/WuxcClHoOEuPP6aPotGaAuBLWT8IUZh9jzgW7gXeJW
         4pDw==
X-Gm-Message-State: AOJu0Yy+I2oOqhzTeDXoMQYDzL9xhK++tRgAnRVGXD3TVceuoHwThGkh
        Ys0DEgYk+Jqle/3qvcbptKo=
X-Google-Smtp-Source: AGHT+IEotSTzQvzd5+jXTLfTdEibaXwQ0HxGDF+VbzVQMHI4nRfvyL7IOlRMU9KjY3xqJEDWBNsFRA==
X-Received: by 2002:a17:906:fe02:b0:9ae:5370:81d5 with SMTP id wy2-20020a170906fe0200b009ae537081d5mr4371522ejb.41.1699547826372;
        Thu, 09 Nov 2023 08:37:06 -0800 (PST)
Received: from ?IPV6:2a01:c23:bd8b:e400:ed81:899c:b431:d0cc? (dynamic-2a01-0c23-bd8b-e400-ed81-899c-b431-d0cc.c23.pool.telefonica.de. [2a01:c23:bd8b:e400:ed81:899c:b431:d0cc])
        by smtp.googlemail.com with ESMTPSA id g17-20020a170906395100b009de467a25d5sm2813466eje.13.2023.11.09.08.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:37:06 -0800 (PST)
Message-ID: <64c6614b-d585-46e0-867d-2704a15c8f8c@gmail.com>
Date:   Thu, 9 Nov 2023 17:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] r8169: add handling DASH when DASH is disabled
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, ChunHao Lin <hau@realtek.com>
Cc:     nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231108184849.2925-1-hau@realtek.com>
 <20231108184849.2925-2-hau@realtek.com>
 <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2023 12:49, Paolo Abeni wrote:
> On Thu, 2023-11-09 at 02:48 +0800, ChunHao Lin wrote:
>> For devices that support DASH, even DASH is disabled, there may still
>> exist a default firmware that will influence device behavior.
>> So driver needs to handle DASH for devices that support DASH, no
>> matter the DASH status is.
>>
>> This patch also prepare for "fix DASH deviceis network lost issue".
>>
>> Signed-off-by: ChunHao Lin <hau@realtek.com>
> 
> You should include the fixes tag you already added in v1 and your Sob
> should come as the last tag
> 
> The same applies to the next patch 
> 
>> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> It's not clear where/when Heiner provided the above tag for this patch.
> I hope that was off-list.
> 
Right, so far I added my Rb for patch 2 only. Will have a look at patch 1
again once there's a version with your review comments having been addressed.

>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++++++++++++-------
>>  1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 0c76c162b8a9..108dc75050ba 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -624,6 +624,7 @@ struct rtl8169_private {
>>  
>>  	unsigned supports_gmii:1;
>>  	unsigned aspm_manageable:1;
>> +	unsigned dash_enabled:1;
>>  	dma_addr_t counters_phys_addr;
>>  	struct rtl8169_counters *counters;
>>  	struct rtl8169_tc_offsets tc_offset;
>> @@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_private *tp)
>>  	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
>>  }
>>  
>> -static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
>> +static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>> +{
>> +	switch (tp->dash_type) {
>> +	case RTL_DASH_DP:
>> +		return r8168dp_check_dash(tp);
>> +	case RTL_DASH_EP:
>> +		return r8168ep_check_dash(tp);
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>>  {
>>  	switch (tp->mac_version) {
>>  	case RTL_GIGA_MAC_VER_28:
>>  	case RTL_GIGA_MAC_VER_31:
>> -		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
>> +		return RTL_DASH_DP;
>>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
>> -		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
>> +		return RTL_DASH_EP;
>>  	default:
>>  		return RTL_DASH_NONE;
>>  	}
>> @@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
>>  
>>  	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
>>  
>> -	if (tp->dash_type == RTL_DASH_NONE) {
>> +	if (!tp->dash_enabled) {
>>  		rtl_set_d3_pll_down(tp, !wolopts);
>>  		tp->dev->wol_enabled = wolopts ? 1 : 0;
>>  	}
>> @@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>>  
>>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>>  {
>> -	if (tp->dash_type != RTL_DASH_NONE)
>> +	if (tp->dash_enabled)
>>  		return;
>>  
>>  	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>> @@ -4869,7 +4882,7 @@ static int rtl8169_runtime_idle(struct device *device)
>>  {
>>  	struct rtl8169_private *tp = dev_get_drvdata(device);
>>  
>> -	if (tp->dash_type != RTL_DASH_NONE)
>> +	if (tp->dash_enabled)
>>  		return -EBUSY;
>>  
>>  	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
>> @@ -4896,7 +4909,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
>>  	rtl_rar_set(tp, tp->dev->perm_addr);
>>  
>>  	if (system_state == SYSTEM_POWER_OFF &&
>> -	    tp->dash_type == RTL_DASH_NONE) {
>> +		!tp->dash_enabled) {
> 
> Since you have to repost, please maintain the correct indentation
> above:
> 
> 	if (system_state == SYSTEM_POWER_OFF &&
> 	    !tp->dash_enabled) {
> 
>         ^^^^
> spaces here.
> 
> 
> Cheers,
> 
> Paolo
> 

