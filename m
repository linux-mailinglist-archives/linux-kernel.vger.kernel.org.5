Return-Path: <linux-kernel+bounces-152400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044E8ABDDA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81A61F21813
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EF51FB2;
	Sun, 21 Apr 2024 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0FKU9NI"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBD38C;
	Sun, 21 Apr 2024 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713660246; cv=none; b=dKI1+gIlK1jqDWAJ32EiVRHexfZLPx59ZakPOeTDjF1m+vNbV9Qd3WVy8Qjq7XPx76rPSOEgbNbVNwq1jtHMm0I3N73mt/ss3xWBI8WNgx/OptHpyZ85sSDhNXoBkVEZXCMsQvU3sK2ZntudU7k5t/K9/gbq/LNaH8P2Ec9hP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713660246; c=relaxed/simple;
	bh=AkmDJNolmM7wPaYgHd3WpQaHQw/9R3iPToYNDR99ORo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/O+HKKZwIM3DF55R/PUWdoAJicITYZ2g7Kq9QMnSnDae0vhUQL3OgisDUMq3vxR4J5dr/zXqfFqwYdwOnavjI6TuuHpaee/w6C+fdOpiFLyYGW807aQWl3pFIb1tOeAP9qyQDQtdo38sqf3LwVE35ycoi/5c+1qriYI/FAfWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0FKU9NI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea26393116so2107889a34.0;
        Sat, 20 Apr 2024 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713660244; x=1714265044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAsVjYOyjzTtZC7MnvrCJ4WfRb9GfbVJNM9uCTjrYjk=;
        b=l0FKU9NIDu1MKrFmey3aJ4BwQKLodK0eER0GpbHJlPnUiYc3PxXR5i8gH67VXUMjoY
         NyBuOeDOo6RzS5bCf+AfzDZgA/DlkU7KEOgLWwck0S/B3het3eDBtOVJIqk0TjzYyqIF
         aLT0n35lP1TNLK+Z+H9+/uI59xNqFxI5VDjWrloWfg+WJTmaq4/WaQnTfEcHceZ58X12
         np9ucMToxQyDkBzYA/LuMIiJp/IRK93vl4n00NSxAp8RAGH9MqEPvh+Wq9mkieyGlie7
         Jo65Zugiu1jaPJy4j5CpJl3uLd58m8uT3b1oYI07bnrkxgN3XQiJ8INlPp/60pE+1TmH
         63mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713660244; x=1714265044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAsVjYOyjzTtZC7MnvrCJ4WfRb9GfbVJNM9uCTjrYjk=;
        b=sEYLDDx7N8VYMjyXYJsKrVn1SmbhBdF4asL38eZKoSVP7M/yDDYIlaCs9EcaMkMyTN
         xBIVs7RBNxIXRUaigMRGt6wSWRnXA5ii18/cn+jQ3gft8T0ZkJbJUMEKtaOa9ND0BsvT
         exlFaM8kWEDv77avMAAzG14MYVaXoTR7kD+h2mAtPT5hgzkU0WwMQVwbA9IhjiIRIrVV
         RadP30jfkWKRPhCKOXXXsuIsd8M6RZb2rU2FaSqWrzfrWl+u/hJGBTtPdrK+n1p4FuMC
         G39ffn/IyxtAU/mNKjrFD3RGfl1dcFZXU/oCnI2pRD0SgR3S1r9DWnZKs1J6scjPqHgH
         Yi9w==
X-Forwarded-Encrypted: i=1; AJvYcCXddSQAMEfPM0f9qsKU7T+2MWaLHM3H/xsj/REZvkyXBQsXpcDMAWFOzUfTPN68KtEp7vMn7yLio0v4pqpL9DTp353qeiDvYkArw3BY
X-Gm-Message-State: AOJu0YwZF8I9j8LL5WW4nVa7zd9H7UVNs6t/b9bvMeraoYHpXiOX3R2/
	hdIQQYZ5Sxw9E4j9/ajdIgi1wgLkEKy7SWWfDT2R1NF7Ymegsymc
X-Google-Smtp-Source: AGHT+IH4bMqnRbSVa6t+3CI8gJXfzLZPMf4nlvhngC+qDZVFboq9H12L//vFsOeHIxZpHjJaqR6m0A==
X-Received: by 2002:a05:6870:a495:b0:22e:dfbc:4d90 with SMTP id j21-20020a056870a49500b0022edfbc4d90mr7230338oal.5.1713660243751;
        Sat, 20 Apr 2024 17:44:03 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:f91:84f5:d87e:d36d? ([2402:e280:214c:86:f91:84f5:d87e:d36d])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b006f260fb17e5sm1769305pfh.141.2024.04.20.17.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 17:44:03 -0700 (PDT)
Message-ID: <b6f3d628-077e-486a-97f2-267324a76e9c@gmail.com>
Date: Sun, 21 Apr 2024 06:13:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remove indentation for common path [linux-next]
To: Joe Perches <joe@perches.com>, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240420164927.15290-1-prosunofficial@gmail.com>
 <a51f703d4f8dc3b0917002c520ea6608ac642b75.camel@perches.com>
Content-Language: en-US
From: sundar <prosunofficial@gmail.com>
In-Reply-To: <a51f703d4f8dc3b0917002c520ea6608ac642b75.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/24 22:37, Joe Perches wrote:
> On Sat, 2024-04-20 at 22:19 +0530, sundar wrote:
>
> 
>> ```
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
> ```
> 
> 
> Not equivalent code as the out_error:
> 
> 	of_node_put(ep);
> 
> isn't done
> 
> 

Hi joe perches,

If ep is null,  I believe we dont need to call of_node_put.  Because 
passing null pointer to of_node_put() make no difference.

In of_node_put() definition, if pointer is null, there is no operation.


Thanks,
Sundar

