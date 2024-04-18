Return-Path: <linux-kernel+bounces-149508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A28A922A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A331F225FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405A35427E;
	Thu, 18 Apr 2024 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kmAm/FmR"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8E4C600
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416087; cv=none; b=LM/hW63XZc0OvT/ft3jpNqsTHYKi+FC1a1kNRGblUL+dGgMyt5vczwwMirZ368xSWAytWB3NRvQ9apDoHDVvNfGX8pxAXcQ5hVqpIBZQGB2+UQMGQHUIzAoJZkn8uHHkNMS2Ht0HWGW33XWN0Ca0BvHzkp8dJSt0xXAl1RLflyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416087; c=relaxed/simple;
	bh=l+eY8tTDyqWyVXlISC7VFjgtUEuZI+FUR4T3V7xK5Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHBhhUYF9f/6q0pC9COrePQUemf4p2EzGIy65sg03ZkUKMb5rCSJl+1KoALZ+tg5HN0PzATWx3Ap0WvNPQg2eNN2QqK12JQlcjRKJHejCJilVqajyobDRcXHTSIsL1+wbu8SloIjIqSWDe8mAeNKZeUek0BYvnayLpYZ6gXuNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kmAm/FmR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3481bb34e7dso146069f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713416083; x=1714020883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEV1/iFjpmWtEmSKqFgeoYjXuzkyg2NXZjtp9IdqTXI=;
        b=kmAm/FmRb+83zYtuzhRcXZ6V79W1gOX9lY4UaGfhutfbdAnoHgr7BDEUlB4AHRijEH
         731Y/4Y5mzepyveuubE66lGeMr9XHYmS9zDtEZ+8tE33DJZP2yGUPiIXLtlgM35U1mSc
         gJk8a5Rij1jaEkp8oKnZ71wZcunqzJP15gN6mdo0C+e6sSPpXsdzjiazebwG0XQT+dzy
         vXEUzU/KOUUHLJH4ii0HsyZpacIl8xoMxDaWP/5gxc+lyc/OJDCyQjM1tD/VSgHp2aLd
         uRyfZhpefs6YWHU3ZxXmGN0V1L3FyAIBEwdtGZXEeSaItwHpSVqEURvZWftjXv2HG2yU
         LKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713416083; x=1714020883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEV1/iFjpmWtEmSKqFgeoYjXuzkyg2NXZjtp9IdqTXI=;
        b=JH8/LTzL10J7nOz9SDk9u1Gb2wu5D7AxniICBxWB/hNDHnNdL6vwsIU0OgVIr8F5V7
         hpmv7W3gTsEboQ4ayBUg3ZBLEX2211QzUlY7WrzZ4NkM1KsmeWd5zc9Ai3Mm2AQ7/ePr
         PvGK+4Kk7ei79yEXTtqqdYWZWmycjMGt/SqP5p0H6BiOZWVRHiktp0KHSGoHOgKLms9Y
         7Nhu/vxiVVBcb5kfEGjT5v6zDpLH+pTcB+nuPwyzl1cKXwQwbFtgth0n+uCBMbgo9ki7
         Ki3/5c+kQeN4AtH8XpZAa7TpIhP734Zk22aDbBOPVwt9u+HsIMH6AVwRWVzN43O81Cq2
         DCzA==
X-Forwarded-Encrypted: i=1; AJvYcCXrLHdYCCgNDYjAXJFOExxRl9jfJznXYmsZkbJfoLH6TVWAAaHXKNsO1Ii4c4Q+vknwpRtY74kgHaG8lMSgMiTxXdDRR8/TYpHvAZHX
X-Gm-Message-State: AOJu0Yx6O4jd4z1O1e9gg64JwVHORCzKbR6sXOL4OccUqzzileIoW6v+
	zZz8rtRcHAkEbAtjAke8OmtMa/DCwimy77PnThgmOBykTtIqOz/HtoLV7a8Zmtk=
X-Google-Smtp-Source: AGHT+IFxe6+PaKuJ6n6lY0fFBN+EBx9jVKZ5r9lFREaHx80p6pKJXX/SI+I0pB85FB7OsDWzDIJXGA==
X-Received: by 2002:adf:f851:0:b0:345:223:2dd8 with SMTP id d17-20020adff851000000b0034502232dd8mr718339wrq.23.1713416083033;
        Wed, 17 Apr 2024 21:54:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b00349e2fab2a2sm799118wrb.12.2024.04.17.21.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 21:54:42 -0700 (PDT)
Message-ID: <dd231ad2-06e7-4f8d-b7ed-d0e374a9561f@tuxon.dev>
Date: Thu, 18 Apr 2024 07:54:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: renesas: rzg3s-smarc-som: Enable eMMC by
 default
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240417112003.428348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240417112003.428348-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.04.2024 14:20, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Enable eMMC by default on the RZ/G3S SMARC platform, as previously done
> on RZ/G2L boards and other Renesas platforms.
> 
> The SW_CONFIG2 setting selects between the uSD0 card and eMMC. By setting
> SW_CONFIG2 to SW_OFF, we select eMMC by default.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 1f87150a2e0a..8a3d302f1535 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -25,7 +25,7 @@
>   *	SW_OFF - SD2 is connected to SoC
>   *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
>   */
> -#define SW_CONFIG2	SW_ON
> +#define SW_CONFIG2	SW_OFF
>  #define SW_CONFIG3	SW_ON
>  
>  / {

