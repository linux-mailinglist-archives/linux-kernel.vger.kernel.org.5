Return-Path: <linux-kernel+bounces-74801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7585DA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2211F22CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50317FBB8;
	Wed, 21 Feb 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpCSp0C4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFA7BB02;
	Wed, 21 Feb 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522208; cv=none; b=JqHyO7l6+dfEGRW0ZCfn+BCkN8lya3OB31HbyMABG1XEFdFcNKz8Ns8ohSgY/e4PgjyW9pIzRwVFHOOTrCaU3KEySJj80zIVNBnzz037KfB9Y03+wE5ljwlM/zG9pm242QKk8ULuKtLBgrke+JeciGAPOR+rCE66KI7V3bRrYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522208; c=relaxed/simple;
	bh=MKnx+HXKlirFBLUQ2I+mJ953wzPrfYFshtnekzUBBAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSM+OmRTYpe40rwwb939L6VmKOKFMJtCmWKMe2ADhimfCPt/pb1bY+WKYTKP0/S5DazpkMPns09xoszFKfEfrnFa2bnZK8ZLSdwsx+t3EmpdgPfhTZ/YeW0ZTUKxKB/2HIM7Xj2BEW1RJTWrPrVNFFxQtN+daOBau4v94N/8KeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpCSp0C4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso6953086a12.2;
        Wed, 21 Feb 2024 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708522205; x=1709127005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sMk7pCc4KFEHJ/2shHIB1CnrDU0xlIevri3Vo/5ORI=;
        b=HpCSp0C4HoYYvTB5JHc+W5LCtL4FLIAo8jR+iOJYYznkiUw60eV1cNUBrZ6LZwZ2xx
         sUHl/8d4znmq/iLNoNplet49kTaUPzJ9DM5WW2MRPuHLOg9kglIr1F9XLZ8EMXlGOuFd
         OJPjfqI2uPST/OxijqaAwUHimRairqt46yWvhOtLUSkCEhEkvBBL8kqkezar+w4BIB+5
         RryW0wUhibNUTL6Ytv/Jzgb7H24f+hqrpY3UDRKRBJIpcVKZcH2wqcLXifsWY9VW1lrr
         hHKR5pUQApynksnlzaJ4S7HXzRtnXtSylM7eHJGwYqjgte0OD9879xPbGdizWJiRR4r2
         6+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522205; x=1709127005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9sMk7pCc4KFEHJ/2shHIB1CnrDU0xlIevri3Vo/5ORI=;
        b=b86YykqfplxnGRvyrkrsFT/mbzvBpKKJvEW1nZsV83lTi7pSH76bKW56WXkf1vJzKB
         yvOoZonAbOfOpJWTQNeCq7ltKXD+5QDHCc7ysMhBHcSBvXnK5BXwOS77s9iiqmIwydp7
         NS6AQ8Ni2USRcX7JEzpwFIOqSMo8Y1U5Jjv/RuHqn2yIpET9vsJbSNx0wVUvJ5lM4v2d
         pnFxTK9fxAuc9zAJLa0YbY7LGqR21ZK/1oVCgcrm5wbUhKD0O5KaxHrp7yZ4aP851CoK
         FNF0XeIUimgC6lyKUBmUftlW6CFHjf18sZHdLawkXtog7YQc0sBMCxYfqOxozXYXvpwo
         ZnCA==
X-Forwarded-Encrypted: i=1; AJvYcCVBJf1U4kRT8+2xR5RM8Y6ZFgCXnwNDZAKLfjNx1NqZQZ0fP/DzpyyaEGDwkYK6wwwLxNOO08WLIE+Co9oh4rXH3Gk3IAlDczcU0CaOTbkj5Q9WbJQMK/UNhjkg6KHmgg0GXL1DPyHt
X-Gm-Message-State: AOJu0YwxeCUlfL3WaEn0pqm8eQQU/EYuse2hygGnjg2wruX1gmWSVpXr
	9ZCGcS9pkumtvKozmmCLscJPMeJ8JnFBI2iQn3T5L4dyM2c+N03bqZBYO/3BkUsHeg==
X-Google-Smtp-Source: AGHT+IGFjfW9XLQYDQFYluJYn0eYpzaN4sblNQQWTap+w3Hdd/Km5Gn3+nyTi8maDIRWk9O3JRDJuA==
X-Received: by 2002:aa7:d4d9:0:b0:564:4f6f:a7ff with SMTP id t25-20020aa7d4d9000000b005644f6fa7ffmr6659629edr.20.1708522204138;
        Wed, 21 Feb 2024 05:30:04 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id v7-20020aa7dbc7000000b00564e489ce9asm891449edt.12.2024.02.21.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:30:03 -0800 (PST)
Message-ID: <ca7d78f6cffc49eba7bb44134c85e94279f1ce95.camel@gmail.com>
Subject: Re: [PATCH] rtc: max31335: fix interrupt status reg
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 14:30:03 +0100
In-Reply-To: <20240219091616.24480-1-antoniu.miclaus@analog.com>
References: <20240219091616.24480-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 11:16 +0200, Antoniu Miclaus wrote:
> Fix the register value comparison in the `max31335_volatile_reg`
> function for the interrupt status register.
>=20
> MAX31335_STATUS1 macro definition corresponds to the actual
> interrupt status register.
>=20
> Fixes: dedaf03b99d6 ("rtc: max31335: add driver support")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/rtc/rtc-max31335.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
> index 402fda8fd548..a2441e5c2c74 100644
> --- a/drivers/rtc/rtc-max31335.c
> +++ b/drivers/rtc/rtc-max31335.c
> @@ -204,7 +204,7 @@ static bool max31335_volatile_reg(struct device *dev,=
 unsigned
> int reg)
> =C2=A0		return true;
> =C2=A0
> =C2=A0	/* interrupt status register */
> -	if (reg =3D=3D MAX31335_INT_EN1_A1IE)
> +	if (reg =3D=3D MAX31335_STATUS1)
> =C2=A0		return true;
> =C2=A0
> =C2=A0	/* temperature registers */


