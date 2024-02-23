Return-Path: <linux-kernel+bounces-78327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E78611F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C63B2820B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145C8C0A;
	Fri, 23 Feb 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbw1DeUE"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2C7BAE3;
	Fri, 23 Feb 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692661; cv=none; b=DUMTSpLTq/binFin+Jv3STbRILxT/oUyaYPWPnx6jcvGE8iwoVvTlpRTx1hKAqK0ZSa12odrlcqyp676rh6FtoD1JDzDIl8fF5EW8yP5A9rZJPPse1JsX3rVAcB62QuuabrUyr5fXkXLZSJ4DLcdGKR0WKaRSR3Z7WK25BDevAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692661; c=relaxed/simple;
	bh=AVRT8j5RaCn/BZf0gVyzpkugvUL51cHt0DCa7hvPaXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEgwhczmue+oSVLZmCaNaQjrTM5jiB1qrZURWyxH31++LXakEIFfqDaKwq47unw/TyibxTHHH6q25w5PLeJZHZ4TM9A1cE9wIIKmwblQUea6rZNQGEvba+ovsgWHLfIrbANf+muEeHK5L4wcRALP67SIpjeP6mz68WWProAEhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbw1DeUE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512b29f82d1so426805e87.1;
        Fri, 23 Feb 2024 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708692657; x=1709297457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUQgrMlkxXtdk899rnSTIJQcALfRj3OIxVsQ4kgw0cA=;
        b=Dbw1DeUEfT9408bUJ84YxJ6WRaLnkfjPWh8aeEmy2S8Frz3oO0f83JkJydOUG9Z1GQ
         pXk8EcrhZxkBF1cQoy8ok4W4s9LLm423cAEu2vZPh2mfi8Pdmor8tkMEswUR9+eV5Tun
         L84XAjmuislsX+qUbNorFqCc54TJO5PKpIZvpuRpzvJsvL0go73hqb943TG2Ji63rk9t
         62tSZUsr4IuPlMt5dZhmmuBkUu+VcoGddE2jNJPacod0eTb73b7IcUZq+wrah2A3qJvf
         harfhMXRgUjO7xopTLnU/Q5IY413X08VoMMMTjlB0B4tKGB7mCTjl60LRqgyWLvbfGFl
         mHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708692657; x=1709297457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUQgrMlkxXtdk899rnSTIJQcALfRj3OIxVsQ4kgw0cA=;
        b=wlBLQyk/efIA8iOuDeSpIbWkC48FDYhe/nf025zrbJDfA/y81wZj8FrbVBOMWcsbHf
         Dw4r4ZEUT5E2Fn6wfc4pXNfulIDssha8TpFS2Bi639J8JqdgDQRaZwwFnMzsCXHX6Tl3
         dsRHXfi1mzk175wij5V5lbiZScDHLxiG9Rd3WUBxOIOisLJJeWNOLCyhjWYieZtiowXp
         m7SNteLWKo1ft8TrpTUkQ7JOCIdRnYo+cJt4GWhjqVA3fi2VtJ/2VMn0qOK6DJ0OxWRM
         dv3+JaoYXu2GQfNLWEwtOiOZpKMMH2vZQAamIXZeWWTMfGdXrkDlHs/HZcdsGumgumCs
         d3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVQrgqUGCGAnq5WDlShTUaaF7LU53ctnSnww15hQwX3xtDaN1jXSDK2hFb3gElxNaEDfFD56lXJ8VMdY8+t2vrYY1q1hmteQFJm7qFDMWNm4gH5vZjByqerJfxQzWP/FptZqAoa4w==
X-Gm-Message-State: AOJu0Yy9YQuLEPwXKSfhJJaIaIU5CjVzOwVxwFs2XHxXqBOAJB8RCClZ
	kauBMr59AVksAvwUoHylymelgtLZaa3br3rrCiF5XBlCWKuXh7fD
X-Google-Smtp-Source: AGHT+IGyxqZbZALpef/feNcgy99jXbBBv5LDTEdWJz/Xr+7J9fI7cV8HCU4wHYzxgYTrRBp0/rf7/w==
X-Received: by 2002:ac2:4e06:0:b0:511:7259:370d with SMTP id e6-20020ac24e06000000b005117259370dmr1625621lfr.33.1708692657238;
        Fri, 23 Feb 2024 04:50:57 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id h17-20020a19ca51000000b00512d863919asm633177lfj.275.2024.02.23.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:50:55 -0800 (PST)
Date: Fri, 23 Feb 2024 15:48:41 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <ZdiUKV7JJQ5TglYM@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20240222011341.3232645-1-megi@xff.cz>
 <20240222011341.3232645-4-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222011341.3232645-4-megi@xff.cz>

Hi,

On 24-02-22 02:13, Ondřej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
> 
> Add a simple IIO driver for it.
> 
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/iio/magnetometer/Kconfig   |  12 +
>  drivers/iio/magnetometer/Makefile  |   1 +
>  drivers/iio/magnetometer/af8133j.c | 524 +++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/af8133j.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 38532d840f2a..cd2917d71904 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -6,6 +6,18 @@

I've tested v4 driver again on 6.8-rc5. Works like before.

-- 
Best regards,
Andrey Skvortsov

