Return-Path: <linux-kernel+bounces-38878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C383C7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC25C1F2738C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70428129A81;
	Thu, 25 Jan 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKYpGvnU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F774E14;
	Thu, 25 Jan 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199409; cv=none; b=P+W6sMOYvRNxW7WNaFHK5uESQpwhw0tZB14nFw1BsnRsZNICd2Q2LyYxAHg0lbE1ZFH3F5lRVJB9sD7ursbrzTLDbDlVgeKKRrVOs6ghLwh2iu56/izBEaB367cIfFbsVx+dPFKN4yoWxlm9Re7QswHf6x3fwyOGm44tKtlWRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199409; c=relaxed/simple;
	bh=SOChC/MwDt3yY9Hnrc2SMSYk6kd7rXDA21UrHJAZuOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZSnKUgKDMzPRd768gC9I/3l8c/PJIXTJfXQcRwjCnjCYTSrk5kvP5cyco/o0zp5MLmXArrAwlhTFhx4hemi/u7/Uc9npN7kn73fGbFaGjV1C+fXpOcBijVb3TxOR5wg9p1VJyhCMkOvgALWd4MdbiIpE8wt8KtzXnoXsNq5yg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKYpGvnU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7859efea5so12470765ad.0;
        Thu, 25 Jan 2024 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199407; x=1706804207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tae+F9lY+aHs4/EHPRCM15YBEDNHUjktfvCoYHe9kVA=;
        b=NKYpGvnUYGSd2OT4JSglAF37v2cJdDBNdJ2n2kpcU/BAycwy3jy8TIq0ixUAphWDUw
         kNbrfA/7c7Y3PiTbL1wF4jrw1HQJB25GiGN9rpznA7GxXkpYQAudVgIhoOXlwewf25ic
         l+rK+B5UCR+6JcuF71BDMKizQh2lDW3ocuWlEWSdlVcNW3q97z/NJz54YjDjC0TU9c3/
         lKUV5w0MhJfqASc8977LMl3zMECeBzYz4YoFxriyXeTESp6JPDPilhJtCHWxMlmJB/7J
         4oFCmRG+qX3bvIT45rDRiQ+z11rkdWaSSy9EVhH79krNKwB2G5AbQS/SqI4EHeoiChr6
         EfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199407; x=1706804207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tae+F9lY+aHs4/EHPRCM15YBEDNHUjktfvCoYHe9kVA=;
        b=ayzKc2kK0Tl4A9ZI6arWcUSurEUhhHzcPulSkpUMxmlvOlNjWKN1h1iHQtwJFPrvhm
         QTGxq1SsqefhWPztOOavZ/JH44nwrGk22ABBSGrhKjXdrGCjusEitxrFiinq173vEi8n
         GSvKYFgk7WDO1TC5XKomRKKliuHzc4mkff10/KUkEsDj+ybH93QXp9GUnQUK0tRDXAUb
         //Wi/4sQhcYZTDljjrcU2ApmMHroLPZg6xucYK8rrdaVU1Kq+nYpt5wCwlG3CtxsizC7
         /o/btaqfcxKg4TiPmY3QP0vODJUb19JqXiNbcvAeuoj5jqM3+HIXADg2JJSdSp+h2hVM
         c32A==
X-Gm-Message-State: AOJu0YxBUti4dIeUwEAWiHPQxMooq2Mc3Hx3cyupfisqRArbUOrlGxpz
	MtzhgBpCGRfK/NT49V4s6ZtTL6XCboD1KdiSjFVonQwYLX54Hghh
X-Google-Smtp-Source: AGHT+IFYgQuRD2Ury8ZHLdeHDhSsPYvcp8/fXzSTTuQ8vHC5sd5+IEXhAdBSzQ1HS9WR9xLPiXZvHg==
X-Received: by 2002:a17:902:c942:b0:1d4:3ea9:63b8 with SMTP id i2-20020a170902c94200b001d43ea963b8mr1072464pla.25.1706199407248;
        Thu, 25 Jan 2024 08:16:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ab8900b001d49a08495esm6800235plr.118.2024.01.25.08.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:16:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da42560b-32b2-49c6-9aeb-b7fbd5b5577c@roeck-us.net>
Date: Thu, 25 Jan 2024 08:16:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "groeck7@gmail.com" <groeck7@gmail.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <540cf4b3-ebf6-4a85-84c4-c012a69db416@roeck-us.net> <ZbKHpFRGoaQpWX16@pluto>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZbKHpFRGoaQpWX16@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/24 08:09, Cristian Marussi wrote:

> Agreed, but it seems that indeed here the attempt is to make sure that
> an accidentally disabled sensor is turned on.
> 

 From the patch:

+static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
+					  enum thermal_device_mode new_mode)
+{
..
+	if (new_mode == THERMAL_DEVICE_ENABLED)
+		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+	else
+		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;

This clearly contradicts your statement. It leaves the sensor in full control
by the thermal subsystem. If the thermal subsystem decides to turn it off,
it is turned off.

Guenter


