Return-Path: <linux-kernel+bounces-13939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB630821542
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9191C20E20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4FDF4D;
	Mon,  1 Jan 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHDMVyJS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8DDDD1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7810827e54eso878754585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704142061; x=1704746861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMNhsLNc6JH9BXxdcz3QKLU0dw4+NL8hfWK4BqvCMdk=;
        b=pHDMVyJSYFQhf6bFAh8xTzc060pebQunTJvIN6GyJLKHV5SxF9qFFtAjPhQsqW9ExM
         ac6sJ6e0fo5smdeDU8e8zoGpGc2Ynwj9eUoHKvFQX50w+XFpHJpwduKqospw+KgZCjGf
         wnn/8LfJ+623wEfaH6MA74n+7PghyI/pM042UuThY8zOZdCJtYoN7skkOBxamGVukvzf
         g5bOq0B8i6RLFBAIHKnywNUCDoM5ADG1iVXpAu1TzpGtpjroPcgymtbr+XCKQzPtGMYq
         P5nFnUkMdIxMYZprL2NpFNpNz3wE9fsq1jRirKY24Ewc+K2nhzdAvl/spZMsIjzBTwov
         Gdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142061; x=1704746861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMNhsLNc6JH9BXxdcz3QKLU0dw4+NL8hfWK4BqvCMdk=;
        b=b3gpdFPud5wX0mPPpdXLnCmfAawLgNHrj6ZRBbBlh+RNcOu3fQDyG4DMYKatsHimAy
         JgJi2WM5J4tViX1e/hJoeE8T2sGi89NpgfNaXzdVqC+t5Tfkh1tXUSx2SYlJhCidItkp
         t3MoVnr91m7Muys1dScH19zvMK33JcmPopQDxqM5U9uUxEQv/Z+RHtYFyAmWlKqRZmvz
         C8e3Tazs8dxp7OzwfAQRpTnhjlN0T+1R2xj2bu9yXOXQeJ4e9AvLb71flc0bkEKn+EZv
         8bHzq8kWExKyX9wt0C1NHY5hNcD78pQqA6cMoD79J8kX1HrAjbjAdHgLWI0gCU7uNR99
         PB/A==
X-Gm-Message-State: AOJu0Yw0+mXsTJSEo127Hp8wqhbGt8jJJb6RaFjUWEmAMrcfPmJq1uqj
	ESvJUCBShcX25oV9V/UJ45bBZxNMue8J8mTvmEUmV2LRWzNwUQ==
X-Google-Smtp-Source: AGHT+IGMZWwx9wRdBBgtWnhlfZlEube5GQnbCSOBm+J8RbjRpT4yUEx7cGRRlsuthan29DxTW0sY1BWDFrfyh1/zX7Y=
X-Received: by 2002:a05:620a:55b4:b0:781:d96d:e132 with SMTP id
 vr20-20020a05620a55b400b00781d96de132mr426264qkn.157.1704142061002; Mon, 01
 Jan 2024 12:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com> <20240101161601.2232247-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240101161601.2232247-6-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Jan 2024 21:47:30 +0100
Message-ID: <CACRpkdZrbfVLNMxf9jXMJNEEtk242FW6msUHBBh+X99dNKS4Tg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 1, 2024 at 5:16=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
> Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

