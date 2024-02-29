Return-Path: <linux-kernel+bounces-87561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680886D5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF01C23CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BA13E7FF;
	Thu, 29 Feb 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzs6N6p3"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835613E7ED
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240945; cv=none; b=Ut9VemH6s+hHcU2clXJGGaISvxniT1G4yH8YNjf+PRNp+B2z0VLVpvTX2N/2jqDyUDQOnR+w2KvGiRGgeFqkNji/Yi7ruWPw7VS3H+BBoKehTR8cIl5fTtfwtgnX/8xRi6gkJTqeMJ9qjQd5RuHKux3jqNsMMmOWilsxsywOz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240945; c=relaxed/simple;
	bh=abpgfmAPNQgCdMPNqKx7nKf6Y9+2suZjGsQJq2RC0wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVo6GCVtkwj7wvtzoaFnHChOFJrw4MQPkEAt3CzoEVW6GkDOLnyjpYgOhnDIrT+C3BWUNSwiVn9cr+Sk+H3GYZkOKLhAKP9dGTn8KGlKSKM5ThjqqkaLXYJAaQreBWCQNbOK/qrt5ZRzHv0UTaWhi/JkWsXmxYWYLfvbBTaEnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzs6N6p3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1345056276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240943; x=1709845743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbAUk2ubZXSXJfkn5aB8LTduIIAz+YJ7H6WyL+sPl1k=;
        b=fzs6N6p3MIg9WyyNS/K08SDeuPHhxJvs9w2saj2KHNSUQX9caSXKndd5QOx59lN+Fh
         QdgnGKWSk0zpI6bh3O8f6wd4m/ygBg9LTx+OlybMm1S4SfkDucnwo7ca7gXzLekzHHYi
         n6WiVUMFVBsRTHSr775WytAB1PrryURQgoGWp6wn2XBBMnnbr1uvEQOS8fgHKiqcFHpP
         heeWJw6dyL+6jZbNJU8FmliUIWZtZxw/6847n3lrhxeI3/xw7Ts3iabQxZECh6FOkbmM
         2jfdV/yie4/2k+K4gaooYS0MjnMWiA0qpKbZcWRxl2nzQcTlQrDzcbvyLs7UP9Ucv/CB
         PoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240943; x=1709845743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbAUk2ubZXSXJfkn5aB8LTduIIAz+YJ7H6WyL+sPl1k=;
        b=Ta0/5vIvi2ZT/KfG2jQv9hpwQfYwDNOj/8Ya9+35+5L3j18xTyEBTzUUTtPXIwgiA/
         n8tY12UtMy9RRabJKpmNA6BBfrH9fu5alQrqGw0pfe5DUQjFlVHS6djFVGgyjckCxNJ8
         0EyQRUprCpTK2KDimEmUOFvyMoEwH6XH6Lng1jDcJ1WKqE+HiqB8egRb9O4UB51kxtSR
         HlWt07pqKFcLAevgZ7e/3FFpuyLTzgn/L1op6X4r84YHIifff4+PKGYXLL289vxgxtGP
         PEPEEfuE2rv6f2YIlTDCwXikhvI2ZQdvPLiAW2OyNGKv8K1SOdlht7Ou8EvzD3xT3FWf
         wIng==
X-Forwarded-Encrypted: i=1; AJvYcCWuWvg6t3/e8iBtaCV8sa7kpPpgjuEaLhpeWyKSJ0YXM8M2BrczJ0+HAZlCOyV3bwQw18tMD9xeOTHCh/FagWBeqCM3sUukAW5FyLea
X-Gm-Message-State: AOJu0YyE8geuAolezrkvRxGnINKxp2ovjyErlLBiO4DJ8SnI7loUE2Cw
	5Hl3rI+4Ae3GyvNJ6AiAWzEqIsbw5IsWxfYJ+s76G7ocsEmuTa4yNbaq4vRYdceAvx+8mqCReiS
	ekJTiA+VteUF8Uslfi+q7vb1BEuNW9FUBJ7ZJaQ==
X-Google-Smtp-Source: AGHT+IF8ln7WLyekvHJT3gKVoSoapL6K1womt5rWIbJrJz0MFoc/wyxR7h/qIOW5MqZBupdkc++ChmM9DDb81ZIyLKM=
X-Received: by 2002:a25:a2c2:0:b0:dc2:3279:fde5 with SMTP id
 c2-20020a25a2c2000000b00dc23279fde5mr3677872ybn.22.1709240942644; Thu, 29 Feb
 2024 13:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-mbly-i2c-v2-0-b32ed18c098c@bootlin.com> <20240229-mbly-i2c-v2-9-b32ed18c098c@bootlin.com>
In-Reply-To: <20240229-mbly-i2c-v2-9-b32ed18c098c@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 22:08:51 +0100
Message-ID: <CACRpkdbaRy-=p63Hq=ykSUeQ-R2S=DjqSBV6-GQWK4BRJNy+iA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] i2c: nomadik: support Mobileye EyeQ5 I2C controller
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:10=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Add compatible for the integration of the same DB8500 IP block into the
> Mobileye EyeQ5 platform. Two quirks are present:
>
>  - The memory bus only supports 32-bit accesses. Avoid writeb() and
>    readb() by introducing helper functions that fallback to writel()
>    and readl().
>
>  - A register must be configured for the I2C speed mode; it is located
>    in a shared register region called OLB. We access that memory region
>    using a syscon & regmap that gets passed as a phandle (mobileye,olb).
>
>    A two-bit enum per controller is written into the register; that
>    requires us to know the global index of the I2C controller (cell arg
>    to the mobileye,olb phandle).
>
> We add #include <linux/mfd/syscon.h> and <linux/regmap.h> and sort
> headers.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

