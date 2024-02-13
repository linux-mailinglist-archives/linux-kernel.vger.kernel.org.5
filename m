Return-Path: <linux-kernel+bounces-64496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B379853F30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD1C1C23434
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D562814;
	Tue, 13 Feb 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ4/gT4j"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709E61686;
	Tue, 13 Feb 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864739; cv=none; b=pMyW3Psj2lbpB4tnotje4/Ji8MbaULX1LN36tWGe4+0rXN/4N8ffNRxAbtrmf8oKOOXsePyiQz525H8R9WH6N3e71xiPRWBsNpHPtFJgxj+onKaUz6T9SY11DlRiqP+cgpRP9AZYJ0UqPRHyuS+abf4O+Vhc6WKTSt9m+GvUyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864739; c=relaxed/simple;
	bh=fCE38Ot/LYirlQfCii8VT6ufFOtv+sHaVcCjpCxyguk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIeTbfNx2THCF2MRQdi+2GeeyrfM9lyjont3sk7u/u4gPV+stGlr4dOdoO6+xD4HD1R58iQloTt4lVxo/1OOGNUelW+j5N5QaKWrvPgiH4o+ORxOJQ6GsfUt52LHaDZqOHqVVvuzTajFxkp9BuBJ+l+rjfOhdnaDTQENElq7Oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ4/gT4j; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-214def5da12so2970953fac.2;
        Tue, 13 Feb 2024 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864736; x=1708469536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=beoO8TXO5tck0Ut41LsdcMam0jCDe/xp7+xH/ECCYWU=;
        b=CQ4/gT4jGFqG4wZA0QQ1p++41N9By7/WeNgBKFij/wZ8cYgrCA9crv0aVvJ9vvTlnt
         Ntkk/Uo6l4VXet2UYoUS/mMDu2PEFPkQQNKBwD5JwSPhcH6TCIldDhvim/Fojo1PDmK8
         DnullwQBZyvWgXyJ2iae0VYSVhCeHQNS/5npLqn+HF12kEh2D+5Y+lMEOr3wx++bHwBm
         Lxmj3nle2Kvcz1eDXQaJ4lhoP0ptYWNYDqodZXcOVho2Gn6oSv6deYADGZxTUOWKICHQ
         4NXpUrSCBPUyJTyxRP49pe8AmPF0QfV3JwP6enIK2xuHTS3nvkQsh66yMYroNmxFydqu
         xSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864736; x=1708469536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beoO8TXO5tck0Ut41LsdcMam0jCDe/xp7+xH/ECCYWU=;
        b=RFWeK/nWwIMCtrLHff+XVlFO6451IU+OhNkgFd1F2t3YoUBiP5mUK+FGTbWubmJebx
         7Y77D8e48gGk6m5MkfW1Zi2fUCyPeKpvQ6j0ZCscWUJp5oVPjATtkhGNFYlbw9hl4tR1
         J3LxQ3svh89KFfpoMNGDrpMdH3F89tzCeiVMOYJqYTboJ737iZdNfiEM1GDIc+lEzRRk
         i3u7O4EITIx3rzSxessk4TuKfQwiDxnnSQdu87dJS8PUPOZBDiX8Eb0SRujqsrqvEdQQ
         JEl7yRkoHbWKzKJNITLPns/Mqo82PFPiSRWWqrbHc59Ih49SYsEnrmnVN6T+4+WM71hn
         t25g==
X-Forwarded-Encrypted: i=1; AJvYcCUOEM2jxmplJ7NPbnmxmh9okt1rP35u5ggOiMvZyui8GryqLCN+D6bje3wJp2aUj6g8baMpJ1nbKwsuBrsxh6WUEtqGc60GFThqc0iOcBCn9mGzH3R089WoqgZLM0sisRkGe7YHfArJuksfDlawvtIBpe0EgqTriF5F3JIrCSwwg6w=
X-Gm-Message-State: AOJu0Yyixtry6ugCeLE8yvbdBZtQTPZpCl5sSjqoUjxPbdHBgUzmp64U
	RlUXTFGHZ0zgI08hsYQjcBuoIv8mQF9qFaimP4DUhOOOiULZ/Dds
X-Google-Smtp-Source: AGHT+IE78SmSSSv6Toje+QMskhxjls3wSSVJ6lrSIu4ESOTx+no684RgHO/zw0EKoYEFN4Vm0m8d4Q==
X-Received: by 2002:a05:6870:ce48:b0:218:a29f:1f5a with SMTP id xd8-20020a056870ce4800b00218a29f1f5amr727238oab.22.1707864736488;
        Tue, 13 Feb 2024 14:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZkGA74aU6XkBl7/gjQG8CeT1HvpD2fmwIf6BJaLUUpr/i+5PCglnQWDyvy+u1Txhporay+6u7UTAMKpya6R/q9PZp3TCytlBJ1l+H8UG4agKllFgmhV6anoA+cI1edvGSIoEUIgsIZ/gnQSVjngeBpUoBmizQjNzvUc0drXoj+vzTz0sxj3UhEm4pj4Jj6MZrzVfBTNL2CpZQTIGKwuODRzRLgjX3dAxXN+n08DGYm+Mx/vFMF3BFzSlOGmbxC3Lmv+4Krjf2im6/A4cX8eX/TC7H46VcsbwfvLisTR0I36GY3Oo9MZxadR5efgt33sGXptXR76sHnfbf0UluaS/HJpJ6eVE/+0s9kK7xJ5OO35k5HDEE4tpKGdHGbzFMkoVgwQ==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cb5-20020a056a02070500b005dbf22d6e1asm2561585pgb.56.2024.02.13.14.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:52:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e278d411-6795-413b-84a9-08fc6ffb4a20@roeck-us.net>
Date: Tue, 13 Feb 2024 14:52:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 08/14] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Content-Language: en-US
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jean Delvare <jdelvare@suse.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-9-dima.fedrau@gmail.com>
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
In-Reply-To: <20240213213955.178762-9-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 13:39, Dimitri Fedrau wrote:
> Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
> support for this sensor.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter


