Return-Path: <linux-kernel+bounces-9946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32681CDAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C928B23F76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E828DD5;
	Fri, 22 Dec 2023 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJkjV8KH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A228DB1;
	Fri, 22 Dec 2023 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccabf5a4beso8911961fa.2;
        Fri, 22 Dec 2023 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266733; x=1703871533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZARMDRQx5b0ETS4xAtKMNDsGnlh68sgD0DmPNz7BzDE=;
        b=iJkjV8KHVUwVKkOh36CQo6sHLLzDb8o57VBXl0UxOrZhOuK9/DBkY1DyhnbMXGl3KK
         tYksL73snXL0yVeM9K/JqlLHi/5+LUMCTLA5C9zoH9HzFYAn9bQL5rTHffP3PAncaNp5
         gb8edY98+B3vOHEihEt72GccJuO3vPEU4/uOidOBfMsmcUsiszKM42kzQjnXO/hGL1mJ
         jhK6dZX7eOmE0um9l3V6zmo7VyXUO44X6KhOe1q5aDAvrLQmULd1+CyNQFNsyyHcN8K8
         GwZFN99I5kcHR6FZM6RaJwbYLZ15Q3xntmsgwBw+GV1BJvF0QjzY17D6Yc+iasVWpSMi
         7bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266733; x=1703871533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZARMDRQx5b0ETS4xAtKMNDsGnlh68sgD0DmPNz7BzDE=;
        b=hfb6012nAfxMpsGAKgJ8o7sgnSjbDjZtQpGcLWvJj+VnRXYzjZhPnZ85Qc7fQ1n1vy
         P95zOOHvWbOyZm4KQRjnEIG627sYaui5Vgjf7jaxkz53TFOkroY8X3CaSvv0JXMI24a1
         KjMLCXYkB+6ynjpJ+osvi4jSAWnu540xiJ4493w+kG1vPxX3MqoLOFRq3Ac7uouUiifW
         D7EJsYsWkpa/t6hTxvhlXiTLaVxOCeCjw+ebdNqmKmogzzfGVXKCJ4yiKx9XKpXSlInc
         ss2Z9fXfbL1aAEqCvxQ9vgoDNWz7G8ZvOrMFY2ims7az2J7d1yDK7ltcoaG4S2qYKjRO
         gy4w==
X-Gm-Message-State: AOJu0YwWbjyveZo9l//4K73R3/fAukEkBR5y7TnOgNrvl/zroQ+pI8c0
	wy0mGMIHlJpksbRWRczXTvQ=
X-Google-Smtp-Source: AGHT+IFitbiEtObvIgZ8YFSZlxcT1run3aqP/QniDplelOunrALumtAevl0i6lijHxZcs9W4mmdI2Q==
X-Received: by 2002:a2e:81cf:0:b0:2cc:65dc:b724 with SMTP id s15-20020a2e81cf000000b002cc65dcb724mr435931ljg.189.1703266732599;
        Fri, 22 Dec 2023 09:38:52 -0800 (PST)
Received: from ?IPV6:2a01:c22:76fe:e700:90c7:5d23:5f70:b2c6? (dynamic-2a01-0c22-76fe-e700-90c7-5d23-5f70-b2c6.c22.pool.telefonica.de. [2a01:c22:76fe:e700:90c7:5d23:5f70:b2c6])
        by smtp.googlemail.com with ESMTPSA id da21-20020a056402177500b00554768e8773sm296161edb.97.2023.12.22.09.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 09:38:52 -0800 (PST)
Message-ID: <e8dd259a-85d0-4c9f-9382-ae8f3097939d@gmail.com>
Date: Fri, 22 Dec 2023 18:38:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] r8169: Fix PCI error on system resume
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231222043410.464730-1-kai.heng.feng@canonical.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231222043410.464730-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.12.2023 05:34, Kai-Heng Feng wrote:
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
> Trial and error shows that increase the loop wait on
> rtl_ep_ocp_read_cond to 30 can eliminate the issue, so let
> rtl8168ep_driver_start() to wait a bit longer.
> 
> Fixes: e6d6ca6e1204 ("r8169: Add support for another RTL8168FP")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - Wording
>  - Add Fixes tag
>  - Denote 'net' in subject
> 
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

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


