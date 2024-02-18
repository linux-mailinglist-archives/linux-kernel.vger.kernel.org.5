Return-Path: <linux-kernel+bounces-70595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC18599A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F509B20DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02396745D3;
	Sun, 18 Feb 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFAYK2mi"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4AEAD7;
	Sun, 18 Feb 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708292844; cv=none; b=V7bFo2p20KNMGorIF5N9DeYaK5/xYCcd/XFBRIITreyIJK7DRdmkxf59hPH2nmIcg1kelhqKukLsoraSHxZiO7EHCg0g7U2R5xJGl3sBzAM6G05hHUB8+zBoqnagVIyn/dXHVZi4JREV4MeasWZXUd/QUktSbv1C5PeCjGHUpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708292844; c=relaxed/simple;
	bh=He296CGuCmElTiY1KTWvPzuztsoIaHP2KjB4JkUw2Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioi260F44trRg2u7kVIZM3fLOS9rnqNzSa+NSayuurIEjtvoty2BHSHmz2O+o7YIdCrwuMI1RMLL6wDKZUf/27T121F6NkMSgYTDFKJz7q+GPlTS1zA0KPrZtp4UaH0SCdE1F/WeUtVw36DK7A95VpjY3Z0KzCQHUWS1/00BQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFAYK2mi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3080258a12.1;
        Sun, 18 Feb 2024 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708292842; x=1708897642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2h7w3PICpgc66DOd0GBlKCF5dayhoEba8xQNx0hBJWY=;
        b=QFAYK2mi3NROshGtkgi2zYr4bWZzvWrcRK4kVVlcFJijJvUUK+J/fTx19zkztEcquj
         IJOgTI00OQglpNwrxsG+epvY5ldH+uzltgbS7EvI6y+SYM2N/iUg5wXsz+iipTW42fjZ
         u6fSKJbbO60UwHZGhDaz+MWotuhdwXmH8wqsBHbKZTQZp3tca+IV7AMXwy5MvX1TxWZJ
         xYbuDE34XHz19yqp7TITQUjkyRufy07pzHfnY737HwlOwsYXH47llBNbmUq/u6dYTleG
         1vQQkLkO0Tp97wVRR9skbY32OTMqv+W6osSFaci3h/XJLXksf1RMHdXfCgCU7FOnXT1p
         4wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708292842; x=1708897642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h7w3PICpgc66DOd0GBlKCF5dayhoEba8xQNx0hBJWY=;
        b=hqyjJcOOrxPOkumJWN6XUh42gRtE4zFj2r/LJR1D9dEXeXCbS078xrJzeEPCz6bFE6
         Rbde9DipI2AySfnOHup7RO9eHkbKFl+TWi2QNLJ6t1P8zwAlLh7ofrv97hIYSBmFl2XJ
         v33yk+X06/4uJYHr+L6t4pNOJ1L/Ay9IQrv5U39D1BYwVXOaG4ItxvhtfHIGE9DUzbAu
         cjbR+DOEHVwIzozVUD/wfNQ9rjkv+WZhCvTlgfTjLZs9LVI2jnV0nBavaF4CUd+0em1s
         INaHX/73O9yX/svj7bKvqGN1mw8a+qtcC4B3KH3MDCsf/dlDOFZ9hY06UUC9+Kx/s8y/
         KfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWVv2GBPt/bT1WbVdvaneNvv2bVsl9hwxFk+fIrILjHs5WPm3k9dsOxdmaT6frDZTMNDraVvBFwBihQ6MbugqlOteoOqnJWWQFXDdu3RhCowme7rnC97pR2t98UfFkRmKyvo++Ayc0ZhFXpfTdqomKBfdupff+GhSGKJdiuy2Lhmo87
X-Gm-Message-State: AOJu0YzZ/iIYISkFGbTQWBktWuVenJ6me58qZH2n5Ea+sHApZ1J7z+US
	M/FZOc3w+FOGXpWOngovVMxHjqaoAZT5jWO+AaCLRdsk/1jmSQz7
X-Google-Smtp-Source: AGHT+IHHsrNNaqhzpWEb7ZSZlMvmO/EGN3DdEK1PReUEdPvWQ75O4Nwi52lCklFmN/BpftZW2qDLAw==
X-Received: by 2002:a17:902:76ca:b0:1d9:b739:a5aa with SMTP id j10-20020a17090276ca00b001d9b739a5aamr9080407plt.42.1708292842210;
        Sun, 18 Feb 2024 13:47:22 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:b1a2:78a5:4a29:e334? ([2600:8802:b00:ba1:b1a2:78a5:4a29:e334])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170902fa4e00b001d9558689cfsm3107629plb.111.2024.02.18.13.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 13:47:20 -0800 (PST)
Message-ID: <ce36b9ac-6a32-4b97-98e5-dde72ef2b99b@gmail.com>
Date: Sun, 18 Feb 2024 13:46:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] net: dsa: constify the struct device_type usage
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Oliver Neukum <oneukum@suse.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-2-1eb31fb689f7@marliere.net>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240217-device_cleanup-net-v1-2-1eb31fb689f7@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/2024 12:13 PM, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the dsa_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

