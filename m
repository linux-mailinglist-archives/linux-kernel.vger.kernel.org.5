Return-Path: <linux-kernel+bounces-29151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B88309AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E840C1C218C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2A21A06;
	Wed, 17 Jan 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/QcRA+H"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF7210F4;
	Wed, 17 Jan 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505139; cv=none; b=o4sAtXA2cMm9V0+A3AhFnQghkVMj8lcC4uvIJ5QteouCmmTxDlyHzRRo0aUW5hA4VOE8jxXQD2spfm/zNqcmJueshGQz1q+AAQgyxiIMg83Xw0YDmPqlYgfaH7u1JESCS0TIsZjRj5KZPpD/VEM4+i/MTfjxLq9yChnG9wgm/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505139; c=relaxed/simple;
	bh=Rcs+b1DhIDaUE+WOqZ4ASK9U+kRcwL+nmYcX0OBTNI8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=kLPKBtXVlbdZXh1AToLxgyL7zOrgmG7zKAiFiKuvOe7OfnO47YEYgHFQhZMTYgveRrAC0vB6KGavMc+2tNkfYCA+e2aUcUdoTCMPN+8eQVfkv7aSdFHfhHa1Kz4t3X49GGUq/tOI+GL2OVF0Ld51lVSC657rdngiuprimkQBEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/QcRA+H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4414ec9c7so56853065ad.0;
        Wed, 17 Jan 2024 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705505137; x=1706109937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nS6nMmsu/9xE5EGiCBV7dIp6aXfPWddYayi2QGOSCU0=;
        b=Q/QcRA+H/Htuf5Crx+HjfnK2OS2g+BWRJZozH+n917A2/E+LZLHxHpwES+VRnhYjJa
         +5RP/f1+eZTzclPuCe0k8JPif6YpyePBcgRfm4zb4qtsxVbtUHBANuX+Zxo1KrR2ZD7q
         uzmMEI8oJ4G9Po1Oeye3unPawZA6eMEjKj2aVmx4Vzz8HmrffkO8Jau/172lk6qsxcwH
         4Odbfu0sZiIrgX58wa3fP/ddC3PRj0z86ZJrcb0wIc9+KmgPTX98ajRv2Cm/WqSQPhjd
         gRemyBkT5DwEgNZNhUTo4arQmXSZuthKhH5Z3Z3ENFWCLHtw2T1Ue7rH6CR0RGeaDLra
         xgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705505137; x=1706109937;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS6nMmsu/9xE5EGiCBV7dIp6aXfPWddYayi2QGOSCU0=;
        b=Xms9/dRYUEbtSc8VarGuZNe1loHeH8z+7dKp2DQDJ03llh3aAC3kSI7PQua408Tv7J
         yWGIMs48an7mqi9AC25wmhb1HqDlE49VtlDqg2xM6354IHsAlj2YoUEC5mpl6vMoXur6
         21NzyUXbCAD0Xv2hZV1UCGGGR6gT0jjZHjWuBSj4Ku6tj4njl7p0hHUhpajXwAAKqagi
         S67qIRc0j4i5NOvbOoe6Ja1Ix0oettHUuG7UFqs8AXp27EPhC+UNOrv9NVAnt7mDLAwg
         8CP7CsxacMPF3kvl7sgK4x6UsY7Ye2Fcfn2H304FxsFDia8F6vpKEn1gId2uTV3tEmRX
         1tLA==
X-Gm-Message-State: AOJu0YyGZ6TM6RgWi5FvTdLVdo81nB7syAJyDmdI53zzRx6XQe6wcEuO
	zWjwBSkcowWbB2tfAQYSnfYNukXCY6g=
X-Google-Smtp-Source: AGHT+IHS6BjT658xRAftbMO4VXSqxB/OZZCC4i+Zjs+fptjEmBRN6x1Qr3gkziPOnZER1wnmoIdoSg==
X-Received: by 2002:a17:903:183:b0:1d4:c2a9:ad34 with SMTP id z3-20020a170903018300b001d4c2a9ad34mr6598766plg.113.1705505136991;
        Wed, 17 Jan 2024 07:25:36 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001d3d8c04331sm11147048plg.64.2024.01.17.07.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:25:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <803e93ac-dda1-41a0-a973-34f9449ccae3@roeck-us.net>
Date: Wed, 17 Jan 2024 07:25:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
Content-Language: en-US
To: Badhri Jagan Sridharan <badhri@google.com>, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com,
 stable@vger.kernel.org, frank.wang@rock-chips.com
References: <20240117114742.2587779-1-badhri@google.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240117114742.2587779-1-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 03:47, Badhri Jagan Sridharan wrote:
> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
> 
> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> the CC pins, setting CC pins to default state during PORT_RESET
> breaks error recovery.
> 
> 4.5.2.2.2.1 ErrorRecovery State Requirements
> The port shall not drive VBUS or VCONN, and shall present a
> high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
> 
> Hi-Zing the CC pins is the inteded behavior for PORT_RESET.

intended

> CC pins are set to default state after tErrorRecovery in
> PORT_RESET_WAIT_OFF.
> 
> 4.5.2.2.2.2 Exiting From ErrorRecovery State
> A Sink shall transition to Unattached.SNK after tErrorRecovery.
> A Source shall transition to Unattached.SRC after tErrorRecovery.
> 

Makes sense to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> Cc: stable@vger.kernel.org
> Cc: Frank Wang <frank.wang@rock-chips.com>
> Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5945e3a2b0f7..9d410718eaf4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		break;
>   	case PORT_RESET:
>   		tcpm_reset_port(port);
> -		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> -			    TYPEC_CC_RD : tcpm_rp_cc(port));
> +		tcpm_set_cc(port, TYPEC_CC_OPEN);
>   		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>   			       PD_T_ERROR_RECOVERY);
>   		break;
> 
> base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00


