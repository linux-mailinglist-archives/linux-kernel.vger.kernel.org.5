Return-Path: <linux-kernel+bounces-103177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660F87BBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837FC1F23B54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171D6EB6A;
	Thu, 14 Mar 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pUVMmRFT"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A16E61E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415770; cv=none; b=rxsS7jeIOboft/tIqOHdrufa2Cl9QtZd4Gzx9s/iPTamy02PQHtB4EjjEB3SZRPc5sWGSpMME47bbr/GjtbY8OS6RVfo3TTU+zR5tb90cHbJTsxMw/JddOTvWmSkoIH61IpXa0VtheZpxQLqStAE80IHHfVIiPme1dqfYyA5rE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415770; c=relaxed/simple;
	bh=DiE9EEVgFjio7zvrWO5a1XtVxji/hH4q6/j8/ifn8DE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=UQOOOIpivufqY8KWrrlqUVc4YuxeYPeZs0XGKYHSJwFLZMMLCLn92c2Xbv23/Mv2xrtVjoi/xhtGUjLlUu5C+T5SykNHvQF8cHTXQOoVbqyhZ/B2FDvKQnT381hbEznufMBWoT6Hcyl9eGRx0k95VCi2VU3EC3D3jfz6d+j3t70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pUVMmRFT; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-33e1878e357so331518f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710415767; x=1711020567; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiE9EEVgFjio7zvrWO5a1XtVxji/hH4q6/j8/ifn8DE=;
        b=pUVMmRFTtQhao619MEMQwCBYD5o2nLXE6kyKPiRxn6aPQTsDWuQYk/Jw/47It5ZbqX
         xar3GZccRXpmNdBD/J+rFZAWd+xxsWAxzw8jNX/ge9arw3/fCnF4NvS9OcEzWOhEAnoM
         92oHsdV9HKyXuENsFa5hid0TvFnD7LlZr2frvFHRHzehEhW/WPuH3HQxEeMDeKXLxX7V
         6/N/9LXx2nfTIKLZs2T5GIBT4j7fnSzVxtFrUuVYoL5b6hGtlvn2P5qRG6vtUr271HAg
         LSt/fD5QOXvwiWxaQtplKPDpuLdrPa/fTzdONIem30qerhIQsjo+rz4AVg83KxpByw/6
         RneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710415767; x=1711020567;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiE9EEVgFjio7zvrWO5a1XtVxji/hH4q6/j8/ifn8DE=;
        b=YPLqlkj2D+TbW9a3b7/ZeouIQLrp9++4xHD/tPnWRbqMO7dYgZnnibKMcbyihjd8PU
         YZwh+xjiUvr/ciXBqjphCDeSquyT+7AY7H6xMX2vG3QDOfeVs5pgvyHN0Vh+UeDnXlcD
         hTBpyvcOUAAmMJHJJc0NDNbOfwezxA492nWecJ3K7JqaNJCjgTActO0q9GXkqEcoGJpx
         xY9f4nu7v2NGQ26b6ZfQECS1JI2IGQpwWHhFEBSZw8koABPRgwqUBxDkq6uILF+bpLya
         rRprCN2IyGL7UtmyvE/nDvZk+LoGxKMFsIjiWoyGWJkpSL+HprLtSHmOxdCjwCN/GeKl
         Hr1A==
X-Forwarded-Encrypted: i=1; AJvYcCVZjMBGLdnDSdXMqSfF5JC2jrmfu3HJCLeR/+JWf1NQUcXftAaOVp0YjmzQO6qUWYG8htWxCwXr3tm3fnJozZbTbxqnGJUWL4PbG3cT
X-Gm-Message-State: AOJu0Ywwx5EzNAEfrvxjiVWnAqo2FIhNIuqX+QY8X9IJqMp3N+g7+5u8
	EtGYaeVeRTyoBapketHYZqMVzncc9DjFilx7lE2yL0hQ0du2b7Dz8Ad8fLlqYbY=
X-Google-Smtp-Source: AGHT+IFlvfFShWc43gizRgqbXtLxPN837uXmBEtemv4L9dx6zk39jQ3uF7UInFSgzfVMY1ONsju8pw==
X-Received: by 2002:adf:cf08:0:b0:33e:7f67:5dd8 with SMTP id o8-20020adfcf08000000b0033e7f675dd8mr1035572wrj.54.1710415766841;
        Thu, 14 Mar 2024 04:29:26 -0700 (PDT)
Received: from localhost (alyon-651-1-22-137.w82-122.abo.wanadoo.fr. [82.122.123.137])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0033e756ed840sm543934wry.47.2024.03.14.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 04:29:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 12:29:23 +0100
Message-Id: <CZTFSA2OG09N.3V2KR7KS6GU1W@baylibre.com>
Cc: <m.nirmaladevi@ltts.com>, <lee@kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <jpanis@baylibre.com>, <devicetree@vger.kernel.org>, <arnd@arndb.de>,
 <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>, <vigneshr@ti.com>,
 <kristo@kernel.org>
Subject: Re: [PATCH v3 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC
 pinctrl and GPIO
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Bhargav Raviprakash" <bhargav.r@ltts.com>,
 <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.15.2
References: <20240308103455.242705-1-bhargav.r@ltts.com>
 <20240308103455.242705-11-bhargav.r@ltts.com>
In-Reply-To: <20240308103455.242705-11-bhargav.r@ltts.com>

On Fri Mar 8, 2024 at 11:34 AM CET, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>
> Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
> significant functional overlap.
> TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
> dedicated device functions.
>
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Hi,

What changed here compared to the previous version?

You might have missed my previous email[1] since I don't see any of changes
I suggested.

[1] https://lore.kernel.org/r/CZHM5FYHS6G0.295L6AYUNZCT@baylibre.com/

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre


