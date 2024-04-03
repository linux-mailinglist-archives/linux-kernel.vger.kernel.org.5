Return-Path: <linux-kernel+bounces-129770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53684896FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3461F212BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F5147C6C;
	Wed,  3 Apr 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZwPuMl"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB146A7E;
	Wed,  3 Apr 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149327; cv=none; b=ebzxUMT/Y+aeeX/296Kz/JxExnx7XUrVeSX5JYtX0rPej7pT1ine1Mc6DN7lNpkY/JOKSCRFTkzAacTiVSKEqC58I3IxpEnI0ncZezGaVGGTa/vjnjPUycANLlSx5bZqynS7Gz/TjO+H8ykZRgpKTiBZRG+HWhs74AFOtNB/2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149327; c=relaxed/simple;
	bh=Kg6xkDoIdkFQ/OcS/14OvJToIEE8kBErgEbWYH3b2+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1mITPUfLbNjD3ja08bVuVBKgh6njLSrTt39Hn4wQj7EwU2C7wcs5SgHnNLroio2VhONCq5rj5rIFXJhG9Z/S8I5ShGoTtGKHy2cS5kiWiAeWlRRj6rLTAZ6mwhY9W+YDe0LAx0KlifOjgr6Rq2YZwtoRhdm1xAyFpPBxkMv85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsZwPuMl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4317aed91baso40571731cf.0;
        Wed, 03 Apr 2024 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149325; x=1712754125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JsIhv9PFZD1JBfDzPu9uaWZvsaLK724whHEFTgxHUgM=;
        b=UsZwPuMlHl5/hwYN1JFhKJycmweygfwvhGif7SQJk5tVr3t9NIEBALyfi1fVfhJqIo
         gWDH9rWFaXEnAMORR/GSN+NHRj+h1Y0sKPX/NMuV2MgvklGVF0gSOvi7wMG4wz/Nm8M/
         xOCSQ258+ssSg8/zolS5fg+a9EW7UxQ/rsMvJjIJImhF4bQruOI5n5u4/RyDCEA0nCjo
         dLNAPHU6na5LnmKc9c5M2TniotAxWdnDNw2jyUTNajctJh910ycXT3Bt+jbnlJAavzml
         CNUkIvq2nDozU1+hW50n9FLJcNJBdUC2AbfroflS1pXvUKrLnCY5pXTklVn+xAeOwghE
         FM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149325; x=1712754125;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsIhv9PFZD1JBfDzPu9uaWZvsaLK724whHEFTgxHUgM=;
        b=bB544VgxIwSzK645oqu2aL4w9rOBrKNC6plDbPwj+h9Q1ZUJVBsHdHA8/IjRGlLSdY
         vY8pi/UfuGHc6bJ6cclG7BwPl6R1ADHbWCI5WTfyQTIXSSUGIZR/2ZBE21RxIXJtS/Wv
         6SobBQDRlm+JQpchbMtxNTjzgMp/ATUpT66TPvglDV4AjXoKy7wN1bUAo6pumdFgGE3S
         si2vadx77BKmHXxbkTf7RwnvHU3tdzupIddGSQErN8nEj/BfHTVHysdyyJ1QkDNqDK4f
         +fp8vw5mXO+RX+sif5QxTVmGKjXFttCpgSLLAhM+e47HnuCy8G9qwdXOVz0NjlTgi4DE
         +NFA==
X-Forwarded-Encrypted: i=1; AJvYcCVHW6p+RRFrHAlZ7JJp91L4cCpD5A4vY2UQ7Y0j7PHrgHSYVME941XRbFK59AJuRbBrff18skLQ4Wba+vbeSzmVCUTAH+KswQY0E9Qu5y80AvE6kJe7XPFIr7kqj8TuqKphNNKo
X-Gm-Message-State: AOJu0YyB+PNbI9bBTUKDy6M8evS5TqlAex5OVpvou7uFh6ILXeBzy3Rr
	62fGPXaFGp3DYkau4IHnVLI2//hkGB9G2cAQj0r+fYur2DHQyqvOwQ1lxMcZ
X-Google-Smtp-Source: AGHT+IE2Bqhf+p+qE8CVOni/EpZmhYiKFoqaNcBV75AL7W7mjuR7IiCls8+R6XN4wfMFo/4sJ3IL4A==
X-Received: by 2002:a05:622a:295:b0:432:b6ae:f68a with SMTP id z21-20020a05622a029500b00432b6aef68amr19977825qtw.53.1712149324976;
        Wed, 03 Apr 2024 06:02:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id bn7-20020a05622a1dc700b00432ffdf1b38sm2104452qtb.10.2024.04.03.06.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:02:04 -0700 (PDT)
Message-ID: <31521d1f-0080-4a18-99ca-78d2e9c64e37@gmail.com>
Date: Wed, 3 Apr 2024 06:01:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/8] net: dsa: microchip: ksz8: Refactor
 ksz8_fdb_dump()
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
 <20240403125039.3414824-4-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403125039.3414824-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> Refactor ksz8_fdb_dump() to address potential issues:
> - Limit the number of iterations to avoid endless loops.
> - Handle error codes returned by ksz8_r_dyn_mac_table(), with
>    an exception for -ENXIO when no more dynamic entries are detected.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

