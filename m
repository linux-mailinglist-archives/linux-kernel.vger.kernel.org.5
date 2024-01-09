Return-Path: <linux-kernel+bounces-20976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D877828801
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2572FB2444C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882E39AC4;
	Tue,  9 Jan 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWAUjpmX"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41139877
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f2aab1c0c5so29349217b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704810312; x=1705415112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0jRmYFxyXqqyod1EILUSU0d1jpB9EyuAxZzGSyEy4U=;
        b=GWAUjpmXLgTriEEiLRrVxfrU2wZjaOkjPeMk5FO4Q3lvYBUdDBXH7vKUZmcImjLPcU
         sPSWBFq6u42KqiUAFEMqYgkI8oyBW7foJYsfcZN9C3PvTYX7R7AK+xrfO6fj7PS39tvp
         SETQqrtbjkk7XsNEoYEivGVdZh15NO1MRxmOPDO3GZbAyUdxSY4gPEf4J+x9e25qEBCI
         UeTukPGhDxe8wgt+q+0tK8EARS84fbkMEBNZWWesEpPwA5LtJSMAbeC9+Pk+CBihEtz0
         TwiwYF4pZEw2WLhQKtoNcB2WArKS55YiHL0kMZoDLKVa6h2TFlt+gsYoZwP2h5kHZE6o
         8miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810312; x=1705415112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0jRmYFxyXqqyod1EILUSU0d1jpB9EyuAxZzGSyEy4U=;
        b=xGbn4uvsDuKatCfSWDNYw/BleN7514g0ETcDb83mLhP2hvVcwAYVNS6M/r5k1woVtM
         u+CQne7EIzMVmoqXzdWRHBkHBC1AI+xQeK2q8JyJZLCyxAJpUmXhAsVlMRxzeZQWnPgo
         0JOv9MtkD6shlHW+Pv3WKzz2uP/MiiKUS703L/8q2UY6WGtOPLJvGYoR1EGzIBrMsn43
         erK2K1/37dWchJMSZ5yNqDKlAspHhMaf0omhGLtM4M8+7A1Pcu6SdTzqIsZ7SEGgh2av
         HSUA+rnvDUZBap8bupwKkTcME5zlteoMkJ3UA6TPIM1hRHkmfTL2T8tXVe27Nys/Lm9N
         SBMg==
X-Gm-Message-State: AOJu0YwhsKsEOU33f7ani1ja0y49FECLFA7F1MTSr/5S0gAeWL5gMtAZ
	2tXT7Ncyg1ZZhIgsa8V5dcYiJapYsOwyE1/Ebgwf803QpGGIfQ==
X-Google-Smtp-Source: AGHT+IFurq3cBuNOgcehIXjqiUCCcK6/Nxe5gbiowFcxxVVg2NwMw2ej6jKJBwkmx6aYWD46obc91hznYms/cHNMqqM=
X-Received: by 2002:a05:6902:220c:b0:dbd:2ae7:f363 with SMTP id
 dm12-20020a056902220c00b00dbd2ae7f363mr474571ybb.4.1704810312262; Tue, 09 Jan
 2024 06:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
 <20240108201618.2798649-6-dario.binacchi@amarulasolutions.com>
 <CACRpkdb73Qrs6MuiC427f=RnyD=rydH_4xVhBx-2bS8bX0mJCw@mail.gmail.com> <CABGWkvq0kbjDZTZj-PN+Sj3jo7SAx0G5PcTeA9KDfceh4D8_yw@mail.gmail.com>
In-Reply-To: <CABGWkvq0kbjDZTZj-PN+Sj3jo7SAx0G5PcTeA9KDfceh4D8_yw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 15:25:00 +0100
Message-ID: <CACRpkdY99si4+KZAVdHBTYr-3=jDBsphTgUNi9NMhZekEpXsEA@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 1:54=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> > do you want me to apply patches 5,7,8 to the dri-misc
(...)
> Yes, I would appreciate that very much.

Pushed to drm-misc-next!

Please submit the DTS files through the ST SoC tree.

Yours,
Linus Walleij

