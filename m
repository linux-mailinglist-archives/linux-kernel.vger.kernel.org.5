Return-Path: <linux-kernel+bounces-117215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDFD88B31C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97FBB33D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A255E12B163;
	Mon, 25 Mar 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMydQKiD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96774C63A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376099; cv=none; b=HWY6W9Lq7D7M+n2anm0MOxpEnlewg1JKOpVfxpcpwcE+h+nb3uenILDAbffpxpu7kkTPlHU+h35Ji8Q2KI6DkM+9Kb5pF6czR0MCV5FwTzL4MUdM4ct6PnniuI0dyPv3Y8mWATAAOIdqGoyB2q4IcEfv5OhQH4uz4G27HlfNDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376099; c=relaxed/simple;
	bh=+MN35LfFWjPF5vSaIYz6fTe7dxOZ73WsvEV6oMFCNb4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nyXeMsDJ2lndJQBbaCpZRRQ3wH8ZqMAqJr4wQRBtSrwmZMOhJsRvWQQgU+J9fRm1WmYoCgQE+lHByCAkBrNmwAGwJD+deIeP1WAUZbtAuOPkeKgUQievKzFqKgeRXTjeRVYdLUM+GAbCMPUon97iKmRS0JZT8CXbIeVbUAVzxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMydQKiD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e10a4083so4918176e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711376096; x=1711980896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qt/0XGoAZ8t0mfKWvAzt9mb6uEidcJPFQo67Ml6oNt4=;
        b=PMydQKiDaY2ewhv6E1lwEUtqOpiIi8SiJPNbb7hSL+veb1IyJqGRKXzc/mpe9KXELS
         gx8qIluus2c6PIfiWBd0E+Ip7QQza7xESAYPQ3tEiOEgr6OFmky0R+haHYnqeZib9tN0
         W5z2MoiaYh5fFaEVZ38oIe078zCEAgTgCh++FePAP3E5L07u1ZnWL3j8JiMEIJADUH0S
         Of63zbdWDkavTr/ITxKalfCOgJ31/JLRdTVpF70oMvP1XHSsQ2g7slqPQiEo1bryFbqo
         AQkIt8xoW+RkuFDMNhlTUIsQiyOFi6I1mC3q8C0tLZhIewbmMM9iCXCjfrtuRnqbtX+6
         bLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376096; x=1711980896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qt/0XGoAZ8t0mfKWvAzt9mb6uEidcJPFQo67Ml6oNt4=;
        b=iR8kZ3JGjaQxWlA/iS3Jf7XaYihvxiZSgd9sFGHMIuszwgQ0weDQ0EfsQwQFo9OgRO
         sUsIYl1wu4K14kBavQZ4bMrx4OVjTF29dedWuJC6JVWEIYKJ6cmLSybscUzSQdHA5U4B
         pnYaQF3sPnNZeTNMCseI+nPyWAz6E1MlDd7PejXNFm8qb2S9sYRnRBA2GA4CFd/NK3Zj
         DqWrw68rKA8mNclpMBOTgB6c7mrOh+xbokn39FE0+/toGIkkHj0DtSFLOWXb4jRNYuw0
         rahUgSLcAHVGX9oxWpBayEFtXtVjlb5Udjq16SQJEJ37ecPNAl+1XLzpkwnjc2Omz+Af
         G9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb1ZrV032W2T4k8nt3ApDagJlLlenbZYGse0XSwEpnJDnUkZjw90bfZw6rpTDIXSnfgIW7qCG8LcmUBdn2VZGqwscmxs+ZfQw4lAoG
X-Gm-Message-State: AOJu0Yx6d5MG/rMWg/P3gBat/WCOeBbVXsMDMr7kKr3yCeOc7mcX+wf7
	h3Jx+xUtty0HfDR2BshDh89Omvdl1KimspjjWyqFZxPAaz7ZfspCIsyfgSTMAV4=
X-Google-Smtp-Source: AGHT+IFexrqaXNHt0cRrFp3/XbxcHYhkejQscLuwDwa5MdyepA9vGAQ5lNzK0+SYQ2n1pDcYsLfgKw==
X-Received: by 2002:a19:6917:0:b0:513:a39e:ae45 with SMTP id e23-20020a196917000000b00513a39eae45mr4689250lfc.62.1711376095721;
        Mon, 25 Mar 2024 07:14:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5176:2c0a:cfc0:1ada? ([2a01:e0a:982:cbb0:5176:2c0a:cfc0:1ada])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d66c8000000b00341ce4a3bd6sm2384247wrw.13.2024.03.25.07.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:14:55 -0700 (PDT)
Message-ID: <ee3496ce-7c42-4074-b6d0-18fc14c6a767@linaro.org>
Date: Mon, 25 Mar 2024 15:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi: Check capabilities before cable
 and identity discovery
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com,
 Jameson Thies <jthies@google.com>, pmalani@chromium.org, bleung@google.com,
 abhishekpandit@chromium.org, andersson@kernel.org,
 dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
 hdegoede@redhat.com, rajaram.regupathy@intel.com, saranya.gopal@intel.com,
 linux-kernel@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240315171836.343830-1-jthies@google.com>
 <20240315171836.343830-2-jthies@google.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240315171836.343830-2-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 15/03/2024 18:18, Jameson Thies wrote:
> Check the UCSI_CAP_GET_PD_MESSAGE bit before sending GET_PD_MESSAGE to
> discover partner and cable identity, check UCSI_CAP_CABLE_DETAILS before
> sending GET_CABLE_PROPERTY to discover the cable and check
> UCSI_CAP_ALT_MODE_DETAILS before registering the a cable plug. Additionally,
> move 8 bits from reserved_1 to features in the ucsi_capability struct. This
> makes the field 16 bits, still 8 short of the 24 bits allocated for it in
> UCSI v3.0, but it will not overflow because UCSI only defines 14 bits in
> bmOptionalFeatures.
> 
> Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
> Link: https://lore.kernel.org/linux-usb/44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Could you queue this for v6.9-rc2 ? So far most of the recent Qualcomm boards are waiting
this fix to be unbroken.

Thanks,
Neil

> ---
> Confirmed a device which supports GET_PD_MESSAGE, GET_CABLE_PROPERTY and
> GET_ALTERNATE_MODES still requested identity and cable information.
> 
>   drivers/usb/typec/ucsi/ucsi.c | 34 +++++++++++++++++++++-------------
>   drivers/usb/typec/ucsi/ucsi.h |  5 +++--
>   2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cf52cb34d2859..958dc82989b60 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1133,17 +1133,21 @@ static int ucsi_check_cable(struct ucsi_connector *con)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = ucsi_get_cable_identity(con);
> -	if (ret < 0)
> -		return ret;
> +	if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE) {
> +		ret = ucsi_get_cable_identity(con);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
> -	ret = ucsi_register_plug(con);
> -	if (ret < 0)
> -		return ret;
> +	if (con->ucsi->cap.features & UCSI_CAP_ALT_MODE_DETAILS) {
> +		ret = ucsi_register_plug(con);
> +		if (ret < 0)
> +			return ret;
>   
> -	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> -	if (ret < 0)
> -		return ret;
> +		ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	return 0;
>   }
> @@ -1189,8 +1193,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>   			ucsi_register_partner(con);
>   			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>   			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> -			ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> -			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> +			if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +				ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> +			if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +				ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
>   
>   			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
>   			    UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1589,8 +1595,10 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>   		ucsi_register_partner(con);
>   		ucsi_pwr_opmode_change(con);
>   		ucsi_port_psy_changed(con);
> -		ucsi_get_partner_identity(con);
> -		ucsi_check_cable(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +			ucsi_get_partner_identity(con);
> +		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +			ucsi_check_cable(con);
>   	}
>   
>   	/* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 32daf5f586505..0e7c92eb1b227 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -206,7 +206,7 @@ struct ucsi_capability {
>   #define UCSI_CAP_ATTR_POWER_OTHER		BIT(10)
>   #define UCSI_CAP_ATTR_POWER_VBUS		BIT(14)
>   	u8 num_connectors;
> -	u8 features;
> +	u16 features;
>   #define UCSI_CAP_SET_UOM			BIT(0)
>   #define UCSI_CAP_SET_PDM			BIT(1)
>   #define UCSI_CAP_ALT_MODE_DETAILS		BIT(2)
> @@ -215,7 +215,8 @@ struct ucsi_capability {
>   #define UCSI_CAP_CABLE_DETAILS			BIT(5)
>   #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS	BIT(6)
>   #define UCSI_CAP_PD_RESET			BIT(7)
> -	u16 reserved_1;
> +#define UCSI_CAP_GET_PD_MESSAGE		BIT(8)
> +	u8 reserved_1;
>   	u8 num_alt_modes;
>   	u8 reserved_2;
>   	u16 bc_version;


