Return-Path: <linux-kernel+bounces-135268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6889BE2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06DB1C219B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB3F69D35;
	Mon,  8 Apr 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/O4cwmq"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA56657C4;
	Mon,  8 Apr 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575928; cv=none; b=m3i9am2yJJnumkAekcTtPa4Kad3xIIk1VGrBHQcFI/qbleDKQRgqSp6jjYUUaynnHMK+jac8r2b/AI9ZJT9oBDEbVc2+KOAyGIseCWcGoVB93Bm0rqwpyi1/basw8Cl68q3KAZIrs/B9lV4LCXcKUT2qETU3bLCFN3QVnbE2yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575928; c=relaxed/simple;
	bh=NMC3WWzWIj1cVvm+tSzJA8DZM1+0DETwbcajhb95PCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLBvDgKnEvI2bN20ecZU7YTShnnfcuzSkYyc/U3z0AG2SnswznSNLDl812rYHM5bLJkkZB/eRDp6uGzgS8xFYLbuIRzg5Rev6/Iei7Qnr6s2s1rwFcgO6k+iTEL5qeVbaW84qV0eswUpGUlrNHyI7vGq6cFxFQNnnyVRu90Okl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/O4cwmq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so1227044a91.0;
        Mon, 08 Apr 2024 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712575926; x=1713180726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UCdmzeMLSBkXEEXH5D1ENzq3ZEPECLv63bbf/w1/YSc=;
        b=g/O4cwmqBorEqgKAGD25+ZoJVaxSdI4FsN6MhDkowUWpCRtO5jYWlksrk2ws4Gmhm8
         24Kdi5gxa/O075RhW8ZZePNCBXLrB2pml3LOCY+EjstFh8TIFndvji6bNvxxsYy7Omyh
         sw5b67dQ981ct+pF67KVBCqaEoPrsCnR2kNSIYu5CYmN3XdOb5Y523rHunA/JsLKBcMf
         CIXq7jMtgQPZqHGDijIQNd3rP2raVVGPOH35beiWIUsPkuR6fV1oRN7Hf4tfqi8ZEbrI
         YqECCOwWukq0OlVqbkh40Lf7JtxRkPKG+PTPfURYTph9KO/bFkGwJKI5p41bkiF2rsAX
         zeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712575926; x=1713180726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCdmzeMLSBkXEEXH5D1ENzq3ZEPECLv63bbf/w1/YSc=;
        b=IMiamVKKw4nUlaoGdhxtynHlJCpsqo4mU/eeJ5CcQBVNz6Vyq+7yu1OCDqNeMfM3bb
         dxLI/67tcLFP9q7uUTzmZjF0bh6LxOgO0Q3dMqZduXY/VhOhV8yhshtz2MIznNsqUa/W
         6VeuDhr7CXUZ6bcS0KKWDVPKfW94At4MTmBGJ2KYKoF3vPeZBLz/0xoXb2HEy/zxxerR
         d57fzROjMKOLQyNje9SbUB02e+xryL4sp1UhRQ6aQrap8Kl7MWUr8BVFUsJJdiybhoad
         SefAaWzpY9UBPnZA07xIngo2PlAqfKskVA9VOqzoaqjulFvGa85zOQFiDvEGOL7vyfu8
         npfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK3yz1GOKxcrmn15Yg9QwptTNTYP7KZDiwt+yYp3N8BdTvoOb2L9NasxGADG+at0rR0MgLktmOS9vwXWJRdHlzYdNBeTGVAQ76Y8+N+RAtAYmh0OCJTyMHvGEEhSMSNQl75nuculFj5Q==
X-Gm-Message-State: AOJu0YxI1PWPKxI08EDDmQOGzlC4vtTYF0H4I1R+jAGRAnwu6IuCYyEm
	4w+RxN8LCjeJU1KEGVswWL+XKAyDqs7nJZdAdPBhn5PsTWKOfUwOXSkyt2EVnc+pdD7TGuXPwZj
	jR9OvAYCsPMklnrX2FEEirLq3tJ8=
X-Google-Smtp-Source: AGHT+IHtRrXqvgdQjO1xoCVveYgBS1g2kOJwaGacmWBBIY8sfhWT2cTP4+14GnDQVQW9yZRcH+Pwi+i4RsN3e7/vicg=
X-Received: by 2002:a17:90b:2292:b0:2a2:afca:c635 with SMTP id
 kx18-20020a17090b229200b002a2afcac635mr7399934pjb.0.1712575926321; Mon, 08
 Apr 2024 04:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408092449.6-1-ian.ray@gehealthcare.com>
In-Reply-To: <20240408092449.6-1-ian.ray@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Apr 2024 08:31:53 -0300
Message-ID: <CAOMZO5B-vTRSfi=tNc_iZxnxYstL8JJOd_1rMf4ps9WHyfx0GQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ian,

> +       pinctrl_i2c1_gpio: i2c1gpiogrp {
> +               fsl,pins =
> +                       <MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14              0x400001c3>,

The Sion bit is unnecessary in the GPIO mode so you could pass 0x1c3 instead.

