Return-Path: <linux-kernel+bounces-102981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08387B96D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F791F23ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517C6BB37;
	Thu, 14 Mar 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqE2nXnH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3215B5B3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405753; cv=none; b=gfNhOenCuFVY6giVHiUVRJIzcoW/vSbZ/+MoSKy+niRp17cNcWLm2JnkgoqwOqg6fi+6X5G323UIevrvsa8Cj8bpGXGjPOZy5+ml+IhweD7ZgZPBLWCEq1GCnNEMZKLLCkFMQC1dRdRTGQStha9VXMzk2isU/+G8dsZktxh8mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405753; c=relaxed/simple;
	bh=t+RewDLamWAHMrg+3ln/QPQ9cqYlQ0kzaDhyZsJynB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNiH9RwBM+pkqthJ3KRHIL3PxMlZ3GiArPLzmv7G1zKckXw9MwnKvsp8DMztEWxOG2sqjBr8A7Kuc6Qc2oVMgFXFVwyjlsBn/E/57JpsrVpGp1cV0ES2Ua+DoSEQb9pKB8BJf4/JFW+5lIetongpki1cdvxAHU/hWYzhYQkty4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqE2nXnH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e70d71756so1065602f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710405750; x=1711010550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+RewDLamWAHMrg+3ln/QPQ9cqYlQ0kzaDhyZsJynB0=;
        b=IqE2nXnHv5f4IYG5IZiyJWlLuo+bsCEHhafgJ+9BptFE3TQjySGofxBQ5Pj+7CXAPN
         xHUlhX3AzW/rVvDRSu2OgszCejNcXIcDHXTOuZlRn3HMWHCfUeXvYgeFjHQw064HcFSC
         RBDzx2Y13EBNZNxAC9wbNblKEoqjzhUocRnvjyhjb80AgDVYgLjEfLXBc47w6LWlSQbU
         D7a1cMxrEtkLs9scGtaqpmsa4pqPG25/SAl/cXbKzzs0WCYVmPGD+2HrqiBCKJlVKpbx
         cqbKG/GcgID6zW1SGWv6OqPukc2iZT5Hr/2/W+A5r8H/oB7q5RkqoGDA62tG7vLfz/Kg
         1HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710405750; x=1711010550;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+RewDLamWAHMrg+3ln/QPQ9cqYlQ0kzaDhyZsJynB0=;
        b=SXQpnwYYUGSJdvOjQ9/XQzaY1C3bvJ0bmpTi9myG5P6cEhWnV77328JtwBvJW6rZKd
         GxPCQRDj3Vp7a+mpvWM+tJf8meRn7a42h8T2dSEH1b/mLrVBSUIRIcJyQa4lJlXNR7EZ
         4ObZLsvVlzwCniCEwbglLQr1GjXyRbJO0AO0Ds1CLGYmcLRKn8HMaqiUblsz3tboeQYj
         by0sGtSNWMhfRkprZhK2OTanS4SLf9bB6YhMk+JVI7D039I3w58dCkXGlrwITsHWZDY4
         y0nDTp2hMZimaixaShoXWh66Jjtcn6ETLk4UhxZ6n9poiAjZKkVXPRKXDQGb4IE+WbDW
         G0oA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+eO/7e1q9Sj+t/aO/QSCC2NTcrawOdDGh7JUtlQ87DMAZ8UsFu14694er/UK1XBk9ahboolL7ZQXqSYIdZFRNXy7RcjqLQRvmyXw
X-Gm-Message-State: AOJu0Yzoc/zAAJzyxdsrIs5gMhZdE5G21QYiWF5aYyYdJZ+xKA4gKhSL
	tWdfweN8om30alYbrOz5OvfJ3CaV2KSWvkSOsuc+L8Hi6OXV4ScJ
X-Google-Smtp-Source: AGHT+IEBcVWVFLr1B4Rx0huyUVfFAYckB81wUe3geHmWYTUVzUCKbrfYsyeGLHGDPnyd2uF+Wgtuxg==
X-Received: by 2002:adf:e6c1:0:b0:33e:7bac:7b18 with SMTP id y1-20020adfe6c1000000b0033e7bac7b18mr896819wrm.5.1710405749946;
        Thu, 14 Mar 2024 01:42:29 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id f10-20020adffcca000000b0033d640c8942sm221081wrs.10.2024.03.14.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:42:29 -0700 (PDT)
Message-ID: <cf6624d65f313bf5e94f25866d4473e9bc0f6aae.camel@gmail.com>
Subject: Re: [PATCH v8 02/38] ARM: ep93xx: add regmap aux_dev
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: nikita.shubin@maquefel.me, Linus Walleij <linus.walleij@linaro.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Mar 2024 09:42:37 +0100
In-Reply-To: <20240226-ep93xx-v8-2-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
	 <20240226-ep93xx-v8-2-3136dca7238f@maquefel.me>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikita,

On Mon, 2024-02-26 at 10:29 +0300, Nikita Shubin via B4 Relay wrote:
> The following driver's should be instantiated by ep93xx syscon driver:
>=20
> - reboot
> - pinctrl
> - clock
>=20
> They all require access to DEVCFG register with a shared lock held, to
> avoid conflict writing to swlocked parts of DEVCFG.
>=20
> Provide common resources such as base, regmap and spinlock via auxiliary
> bus framework.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

I've applied the whole series onto ef6069f3f6577b2e5bdf223d2f6d09f23bed8c6c
and tested GPIOs, SPI, DMA, sound on EDB9302, looks good to me:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0include/linux/soc/cirrus/ep93xx.h | 26 ++++++++++++++++++++++++++
> =C2=A01 file changed, 26 insertions(+)

--=20
Alexander Sverdlin.


