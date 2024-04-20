Return-Path: <linux-kernel+bounces-152306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F48ABC1A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFA51F2128A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501228373;
	Sat, 20 Apr 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf3YEHTl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE170B669;
	Sat, 20 Apr 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625158; cv=none; b=pkJg2l37PzM/JtHTKF2u/rt/pzNbuHC/zICCCLrgTgHNAWpLXC7YM5pSCCROqYUNgf2ntsKsr8FbP+U/jXaiRILy0UusjEbbo0aW8LC2Sv+TokB/STxsXOwiCaMfXbvirsOY8Z0iBTueOj1xCxB76j8QG/TzT2tlu6A0/OikZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625158; c=relaxed/simple;
	bh=ZoRlFE5J5G8ckPXCLvGe8muE14HexCVV8sCY1Rw6n0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ep09jivBxryvjv3WYNfZ1reurI6EN3e0Yw7z2JPlLMYth8oIuN5vS3kcOflz0yFTYjZ/6BXJLnhrf2D8aoRyvq8Hdd2xNkTjs2MrTulHoGQBoqX9/9KwwsPfvzHxaO3nG5MwNAA72NGe4M8sMqpEVgASjXX3HBVFY6wZtCed3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf3YEHTl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4f341330fso25702275ad.0;
        Sat, 20 Apr 2024 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713625156; x=1714229956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWUGCu0vb+jde+SJIWql6L3zeM6XBEriGk4p2Z1iijk=;
        b=Wf3YEHTlBlq2cKHgrFdiLUE450KGFus1XOnTW94DdoxkFAqb1wW6+bR03J/Yh3Y2qx
         /K5E9FMdy/dFoVYfkIpuhi0IRXZx7zXINJeVvF6lqMQbV3s3T3au07cXaMURK5gxGPKg
         uZPYOQ/xqPMs31Tdsnkr8pTkO81gunRUFsxvsX4x3QWJSWGSOc47+2JbNc3IFZI/OyxD
         5Lo00GyfESNykZ0lYLUrNtgxvR0abflMIwcyFfg34ji6p8mNA0WBuaTatReGfiNZ5Fal
         7KyHB9xq0MrHk+jHpCKTGMVOGc5iGJkn1k522g73+ehoJyQJi+60eio1c1l+wFGujl2h
         gp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713625156; x=1714229956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWUGCu0vb+jde+SJIWql6L3zeM6XBEriGk4p2Z1iijk=;
        b=GSdO4/HfBC/7snibm9B0N4x8IbpK89YbiGnfDYXWb2o2cxzaigt32sSR11NQrRBwWE
         KmESQEPZcNKdYe6LD12z41rvQBDOIaAIRtUE4JN//XD4RKjI0fwc4SURT5LsG6+EiXid
         lDIyJy30SNbYD06RjY26oPa1Dp40WyDD4HSUhD7kXR4EDB4X1OkFVEtRYt0cSpNJhRY2
         dTlpXbLkArZVGvByvqWBXWGA01SDKxebxn7jBw0X1F/3wJWa2r5KI4w8KNxphI+3Qs4d
         WpaLveJAxlBCtiDEqQj/y917jLbXJiTALTe3wEXnzklqppNU5AcEe2x58vfcA42QoIHI
         41iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+JSXplFrOsQWT1+59v+vuws+qf3SwuK7WUXRjFrmNc1qMyQEKOpAX+WitlvAtChN74e/wi1U/JPXIW71gjC2OQ3zZq2mReXxgJ6UB
X-Gm-Message-State: AOJu0Yx7nb808RsjR4Y+BU3TpkmrkDACtdf0TSDwr5kvDQFl2EhzrfBE
	xKvlanrF1N8rzqELxXmsp8fVQruFoar7tLMHxWF11bOdrPL42cWI
X-Google-Smtp-Source: AGHT+IFat4PMHHSrKmKxA4Op5BYngmU09Q8TXT2KHIpZZ6jCEoOG0UFyS0dUeE2qlPhLrzHX3PsG5A==
X-Received: by 2002:a17:903:18d:b0:1e4:2451:c2b5 with SMTP id z13-20020a170903018d00b001e42451c2b5mr6917020plg.13.1713625156117;
        Sat, 20 Apr 2024 07:59:16 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:2549:4e11:d9ed:4a8a? ([2402:e280:214c:86:2549:4e11:d9ed:4a8a])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001e5331a0b91sm5142198plh.218.2024.04.20.07.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 07:59:15 -0700 (PDT)
Message-ID: <98f301b5-0161-467a-be2f-d2554a2265a1@gmail.com>
Date: Sat, 20 Apr 2024 20:29:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove identation for common path
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
 u.kleine-koenig@pengutronix.de, christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240420145522.15018-1-prosunofficial@gmail.com>
Content-Language: en-US
From: "sundar.R" <prosunofficial@gmail.com>
In-Reply-To: <20240420145522.15018-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/24 20:25, sundar wrote:
> Added check if pointer is null and removed identation for common path
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: sundar <prosunofficial@gmail.com>
> ---
> 
> Fixed nitpicks in code according to comments received on other patch.
> 
> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
> 
> goal is to get rid of of_node_put,but sending this patch first to do one
> thing at a time.
> 
>   drivers/usb/typec/mux/nb7vpq904m.c | 49 +++++++++++++++---------------
>   1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index b17826713753..fe0257840dd5 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>   
>   	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>   
> -	if (ep) {
> -		ret = of_property_count_u32_elems(ep, "data-lanes");
> -		if (ret == -EINVAL)
> -			/* Property isn't here, consider default mapping */
> -			goto out_done;
> -		if (ret < 0)
> -			goto out_error;
> -
> -		if (ret != DATA_LANES_COUNT) {
> -			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> -			ret = -EINVAL;
> -			goto out_error;
> -		}
> +	if (!ep)
> +		return 0;
>   
> -		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> -		if (ret)
> -			goto out_error;
> +	ret = of_property_count_u32_elems(ep, "data-lanes");
> +	if (ret == -EINVAL)
> +		/* Property isn't here, consider default mapping */
> +		goto out_done;
> +	if (ret < 0)
> +		goto out_error;
> +
> +	if (ret != DATA_LANES_COUNT) {
> +		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
>   
> -		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> -			for (j = 0; j < DATA_LANES_COUNT; j++) {
> -				if (data_lanes[j] != supported_data_lane_mapping[i][j])
> -					break;
> -			}
> +	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> +	if (ret)
> +		goto out_error;
>   
> -			if (j == DATA_LANES_COUNT)
> +	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +		for (j = 0; j < DATA_LANES_COUNT; j++) {
> +			if (data_lanes[j] != supported_data_lane_mapping[i][j])
>   				break;
>   		}
>   
> -		switch (i) {
> +		if (j == DATA_LANES_COUNT)
> +			break;
> +	}
> +
> +	switch (i) {
>   		case NORMAL_LANE_MAPPING:
>   			break;
>   		case INVERT_LANE_MAPPING:
> @@ -360,7 +362,6 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>   			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
>   			ret = -EINVAL;
>   			goto out_error;
> -		}
>   	}
>   
>   out_done:
Apologise,  Forget to add info.
This patch is for linux-next repo.

Thanks,
Sundar

