Return-Path: <linux-kernel+bounces-135270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B127F89BE31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C36328497E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7E69D3A;
	Mon,  8 Apr 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1MRvaI9V"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CF657C4;
	Mon,  8 Apr 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576024; cv=none; b=jcmir31eUJrCpNlXqQBuY/TMR6N7iGqS006pfg699Lk50/2oblPFqh+NXp9J30vO4dcv2j2IY0ufRks6Q1wd3zAWjuUufS+kQCVC+MLdkZbGFuGC9DdM1DvctCsKigJ303kyepJskPtwy1Ezh7Z7QsC4tJw0Gx92kq45Hy9nyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576024; c=relaxed/simple;
	bh=Wo/fnT4vrzEdJzsfaOrBfM3t1EYcWSQcfI+sddFhP94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B/iPL4SIvp6EYEQ/TaVCq825r7KGC/l9kmNtcC4HqGYYN4dbQeF9ikWQqdsPzlASfyakNo7ISlBzAWoHcorcg7eqNWbQv/plk5QCzybeXI/BItRBD/Gj0dv6Hnw0FiWFAPnQ5Mj8Dfsg6dleiK23vFvVx+4wPl2KL7PuivXNX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1MRvaI9V; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712576022; x=1744112022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wo/fnT4vrzEdJzsfaOrBfM3t1EYcWSQcfI+sddFhP94=;
  b=1MRvaI9Vxv4becgs+ORWqyQ7d1yLZqnFQYG4J9Dwed3/mGf9wl0U1BOK
   GnkWdVuY2H9lDbQlSskYD+Mm4Gje86iuC6D9WpTM2NPcmGVZjbotxb5RX
   jZUglB5duSGjdUQC6RbjCdeKb7LlW95LVKVIB5DCQz1t4Ap93q6kdqu6a
   hKqkRf8qRgXlSUPEf4890mQqw5qIkbO6oS22G2cAyVnYcix2oBZ8pk4qQ
   3FaBozDiB1J+h9EIwEUuiP220G3xQLfEyaG7LhRYdbq0Tec8iizPZ1qbK
   AGFxZ7d6GDXjTDrSjKdyAAJWoZ+Z46hWGww6qzxdVX3FnFhIO7oSlFP8w
   g==;
X-CSE-ConnectionGUID: 8UDBYYxJQwS+kRlQNe0HGg==
X-CSE-MsgGUID: dSm+3HjYRNyanz2ynRLD9w==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="250791766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 04:33:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 04:33:22 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 04:33:21 -0700
Message-ID: <d8f2d9ab-3c68-4ba1-8733-7ae9754011ed@microchip.com>
Date: Mon, 8 Apr 2024 13:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: mailmap: update Richard Genoud's email
 address
Content-Language: en-US, fr-FR
To: Richard Genoud <richard.genoud@bootlin.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240408101329.9448-1-richard.genoud@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240408101329.9448-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 08/04/2024 at 12:13, Richard Genoud wrote:
> I'm working now at bootlin, so I'll use my bootlin address for kernel
> development from now on.
> 
> Update also the yaml file for atmel-serial accordingly.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Thanks for the update Richard!
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   .mailmap                                                       | 1 +
>   Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 +-
>   MAINTAINERS                                                    | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 8284692f9610..71e28f4e0d4a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -524,6 +524,7 @@ Rémi Denis-Courmont <rdenis@simphalempin.com>
>   Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
>   Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
>   Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
> +Richard Genoud <richard.genoud@bootlin.com> <richard.genoud@gmail.com>
>   Richard Leitner <richard.leitner@linux.dev> <dev@g0hl1n.net>
>   Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
>   Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> index 65cb2e5c5eee..eb2992a447d7 100644
> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> 
>   maintainers:
> -  - Richard Genoud <richard.genoud@gmail.com>
> +  - Richard Genoud <richard.genoud@bootlin.com>
> 
>   properties:
>     compatible:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aea47e04c3a5..0dbdc81e46c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14363,7 +14363,7 @@ F:      drivers/dma/at_xdmac.c
>   F:     include/dt-bindings/dma/at91.h
> 
>   MICROCHIP AT91 SERIAL DRIVER
> -M:     Richard Genoud <richard.genoud@gmail.com>
> +M:     Richard Genoud <richard.genoud@bootlin.com>
>   S:     Maintained
>   F:     Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:     drivers/tty/serial/atmel_serial.c


