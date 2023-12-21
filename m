Return-Path: <linux-kernel+bounces-8410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8981B6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF37282F55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E879965;
	Thu, 21 Dec 2023 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKXPFz4q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC5740BB;
	Thu, 21 Dec 2023 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so89984466b.1;
        Thu, 21 Dec 2023 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703163335; x=1703768135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEbMK9xuhcVgV7c3YqDiWD2jNh0hvbrRAI7AYOQ2W6A=;
        b=MKXPFz4qMKs3axT2e10j/c3Jvt2IeZ2dPF4mvDQFzMwL5gVrR7jaqI0RrSr3SXCwkJ
         hPubyaH6SgnZJi1kau2QBqVExX0wBkA4vhqbZ1FEVR3Y8nePcYCH6YHsrReAZsE6D+FM
         j8LaaWuy9xwYH/AuZ7GNOqHwXDs6JdA2g9U5S+ofiwnw+kSq13JNvmHqNAtqwfBkDiSJ
         V5d+33cEzPf3haSwzlXR4yZjgrZxWzap6+m4CSFrtOr0j3T13nxmzm7YqZsCi4JB7Qxh
         At7SaGD1uOcTL/m0+RCLTwP8ZphIAt3Mu7B3NFclclxxrTOQui3y2qk+UlldGqt6lotq
         1E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163335; x=1703768135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEbMK9xuhcVgV7c3YqDiWD2jNh0hvbrRAI7AYOQ2W6A=;
        b=htbVQfwzHVANObIfpaXaq+XArDzrYys6kPx8Zr+i8oVPSdMevPowXqQoQSw7ERt16k
         sNi7omWkdDzxnzeTRGP+SoSUbcjgWxxPO3PuTLbCeoL8V2fqr8KDBrSjdCs1Lt6ciLKe
         k3E+o8F2cKW2qX4lLs8e78UafhI5PHy4iJ7MzEEpy36/9Q8pEgbWF6AmgzXZYrwbgdCP
         5qNeBG6Nh+mrjmnkEGhMk3pzLmoechgQSIu4Kp5xAqehWBloj8HU4WGB4MsXmIsUKMei
         2jgz+oOwl6j0/H04d/uVtdzWY2LR+Uc5TrSuRwZ42B0dKq6nk/JyqAayBAdTfbQ+uTKT
         RRNQ==
X-Gm-Message-State: AOJu0Ywoqr4E+uxNSieLvcYF7bjeJPhs4L9nhyhkDVz313g0WUGbrvAP
	VyKvkDovNRVoB0+L1NIw7E6m+xiPIgM=
X-Google-Smtp-Source: AGHT+IEdbnO9pJQltMwNTWpHRYKwH/rpW/SG162vA+X1ki+tS+DqD3PNklJDamk6Wr+akjGE+q6fGg==
X-Received: by 2002:a17:907:160c:b0:a23:748e:f3eb with SMTP id cw12-20020a170907160c00b00a23748ef3ebmr1831280ejd.286.1703163334468;
        Thu, 21 Dec 2023 04:55:34 -0800 (PST)
Received: from ?IPV6:2a01:c23:b8a5:3600:c010:4b2f:ccc7:a870? (dynamic-2a01-0c23-b8a5-3600-c010-4b2f-ccc7-a870.c23.pool.telefonica.de. [2a01:c23:b8a5:3600:c010:4b2f:ccc7:a870])
        by smtp.googlemail.com with ESMTPSA id az16-20020a170907905000b00a26ace114ddsm228013ejc.49.2023.12.21.04.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 04:55:34 -0800 (PST)
Message-ID: <5fff816d-e2d6-4632-a6c8-b6c4045058db@gmail.com>
Date: Thu, 21 Dec 2023 13:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: Fix PCI error on system resume
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231221052510.443674-1-kai.heng.feng@canonical.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231221052510.443674-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.12.2023 06:25, Kai-Heng Feng wrote:
> Some r8168 NICs stop working upon system resume:
> 
> [  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
> [  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
> ...
> [  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)
> 
> Not sure if it's related, but those NICs have a BMC device at function
> 0:
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Realtek RealManage BMC [10ec:816e] (rev 1a)
> 
> Since increase the loop wait on rtl_ep_ocp_read_cond can eliminate the
> issue, so let rtl8168ep_driver_start() to wait a bit longer.
> 
As this fixes an actual issue, the patch should target net and have a Fixes tag.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Wording
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index bb787a52bc75..81fd31f6fac4 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1211,7 +1211,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> -	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
> +	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>  }
>  
>  static void rtl8168_driver_start(struct rtl8169_private *tp)


