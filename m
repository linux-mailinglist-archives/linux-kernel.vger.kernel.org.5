Return-Path: <linux-kernel+bounces-21065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22591828946
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870E91F25811
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2103A8C5;
	Tue,  9 Jan 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLypg5GB"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89523A297;
	Tue,  9 Jan 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e89ba9810aso24792167b3.2;
        Tue, 09 Jan 2024 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704815262; x=1705420062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iq9+BPAn/FzkMzpLSI81D5gJEH0V/XExU3YR5f63LHU=;
        b=SLypg5GBkVYcbeoOM1Vgctv4rWmZeNILc6vPxR8rDZAhofY5Df6KqAUoLij4z+4a5o
         a+llltjvgiCNvZabdQEoaEjcyQT/FoEIdzCOJWznrhKYwcHre9dcmBCTJuaH6UUqHXfi
         8E1OCs0AGqMfJYdPCyNp5KpQ/BqME5UR6JfTC8xqFV0b7yt9klYuLHuqqBiF7WzOoMGl
         unmbvn4B5RMqwzPHRGgcz46sX5zgMwd8q1DIvvBzR0tat5XSlUvFuU9dlIC8gOJvXcVT
         xXpo9lir+7kd6m2AK78o487ndafrQb9ZkIR11vIpomg0ck0Seis6HBnO8zUrh2z0pxkT
         I2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704815262; x=1705420062;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq9+BPAn/FzkMzpLSI81D5gJEH0V/XExU3YR5f63LHU=;
        b=WtP3UXsER5M6UNA2X/NIvldMEGKNSUN8kC00tFEMIdE8BZS8Tl78/GgjpmYjkbcU7j
         kZ3aiy02WBfRt0T3W6AlaKyB2YLdX2KL7g3lvq82PKY88e/X4LQaabxIDxA/aNSJVp3c
         xFx3DB1JYrBRV0pd+8nzasG48FDF0rF4SrbjJPEWRNMX6GAocfecHuAg/ykBBJgaJTTA
         1AcdOMSjeBo97MehXDjd36KNDRCo7eiUbbeeefmka+u8jvZH+vwZJ3mPM8RiAxJSnPqZ
         eDeo8IjEH2zdkIHAHrHdzzikf2t/0pMVAyx61seYZKiH8ei6AcP9QJr4K6uBcYh6Et1q
         yZ4Q==
X-Gm-Message-State: AOJu0YzjNK92OyzH48rkCMkaOrshzIFPdpF0QpMO+SzpWrruDW4O84ak
	Lrfey0nSLcSxH8vsok0VUiAfxkrg+Ds=
X-Google-Smtp-Source: AGHT+IHpR4oPu6yXgvLmk6PNDfqi/dJksmLI62y+lSvUkX52CzNHyniwBvd+yAcGfm2mFBCwdorKGw==
X-Received: by 2002:a0d:fa84:0:b0:5de:7ec5:808d with SMTP id k126-20020a0dfa84000000b005de7ec5808dmr4016996ywf.77.1704815262594;
        Tue, 09 Jan 2024 07:47:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a81b403000000b005d36f6c7836sm821477ywi.104.2024.01.09.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:47:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5004d63d-905b-4297-aa8e-23c9ccaa3444@roeck-us.net>
Date: Tue, 9 Jan 2024 07:47:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
Content-Language: en-US
To: Suniel Mahesh <sunil@amarulasolutions.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, USB list <linux-usb@vger.kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Da Xue <da.xue@libretech.co>,
 Da Xue <da@lessconfused.com>, Da Xue <da@libre.computer>,
 Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>
References: <CAM+7aWvmmyyLN5YHuJhg_X402OFmP_sVe6h_mr5tURjv0Ti5vQ@mail.gmail.com>
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
In-Reply-To: <CAM+7aWvmmyyLN5YHuJhg_X402OFmP_sVe6h_mr5tURjv0Ti5vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 23:17, Suniel Mahesh wrote:
> Hi Guenter/Heikki/Greg and all,
> 
> This email is a narrowed version of the earlier discussion at:
> https://lore.kernel.org/all/CAM+7aWt7hJSmJQ78Fes0jMcrF9E8yhN=sDgYuU-hBxO0+1Uj0g@mail.gmail.com/T/
> 
> Please guide/suggest on why the FUSB302B port controller on a target board
> is getting reset(hard reset) on reception of a 0x0 packet from source(PD Wall
> charger 100W - 20V@5A).
> 
> log when reset:
> 
> [    1.599049] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
> [    1.602836] FUSB302: IRQ: 0x00, a: 0x40, b: 0x00, status0: 0x83
> [    1.606210] TCPM: tcpm_pd_event_handler: in TCPM_CC_EVENT
> [    1.968179] FUSB302: IRQ: 0x80, a: 0x00, b: 0x00, status0: 0x83
> [    2.133140] FUSB302: IRQ: 0x41, a: 0x04, b: 0x00, status0: 0x93
> [    2.133704] FUSB302: IRQ: PD tx success
> [    2.136046] FUSB302: PD message header: 161
> [    2.136392] FUSB302: PD message len: 0
> [    2.136845] TCPM: PD TX complete, status: 0
> [    2.139382] FUSB302: IRQ: 0x51, a: 0x00, b: 0x00, status0: 0x93
> [    2.142192] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> [    2.142804] FUSB302: IRQ: PD sent good CRC
> [    2.145274] FUSB302: PD message header: 1a3
> [    2.145674] FUSB302: PD message len: 0
> [    2.146072] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
> [    2.146478] TCPM: PD RX, header: 0x1a3 [1]
> [    2.147042] TCPM: tcpm_pd_ctrl_request: type:0x3
> [    2.147435] TCPM: tcpm_pd_ctrl_request: case PD_CTRL_ACCEPT
> [    2.146309] TCPM: tcpm_pd_ctrl_request: case SOFT_RESET_SEND
> [    2.148266] TCPM: tcpm_pd_rx_handler: done
> [    2.158196] FUSB302: IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> [    2.158600] FUSB302: IRQ: PD sent good CRC
> [    2.161283] FUSB302: PD message header: 0
> [    2.161710] FUSB302: PD message len: 0
> [    2.162092] FUSB302: fusb302_pd_read_message: to tcpm_pd_receive
> [    2.162608] TCPM: PD RX, header: 0x0 [1]
> [    2.163181] TCPM: tcpm_pd_rx_handler: done
> [    2.179843] FUSB302: IRQ: 0x41, a: 0x01, b: 0x00, status0: 0x83
> [    2.180314] FUSB302: IRQ: PD received hardreset: interrupta: 1
> [    2.181125] FUSB302: fusb302_pd_reset:
> [    2.182597] TCPM: tcpm_pd_event_handler:
> [    2.182937] TCPM: tcpm_pd_event_handler: TCPM_RESET_EVENT
> [    2.183292] TCPM: _tcpm_pd_hard_reset: Received hard reset
> [    2.183770] TCPM: _tcpm_pd_hard_reset:
> 
> Let me know if you need anymore details.
> 

AFAICS the wall charger sends a hard reset request, which is honored.
This seems to work as intended to me. What is interesting though is that
I don't see a "Unrecognized extended message type" in the log,
suggesting that the message id is 0 and matches the previous
message ID. This would cause the message to be ignored.

I don't really know what do do with this. All I can say is that
the charger should not send a message with header==0x0. It looks like
there is no response sent to this message, which is possibly the
reason why the charger sends the hard reset request. But that doesn't
give us a hint what we should or even could do in this situation.

Guenter


