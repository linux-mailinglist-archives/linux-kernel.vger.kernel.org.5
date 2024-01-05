Return-Path: <linux-kernel+bounces-18288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88F825AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E04AB217C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871D35EFF;
	Fri,  5 Jan 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHC8hzGo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3135EF4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e784ce9bb8so7189557b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704481736; x=1705086536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC2bJp2abkUAY3rCEbXohtWXjxySOLDcFj8N67lxtGk=;
        b=FHC8hzGoU0OSp8rw5AfoHRxydi3dPezdiBrIqcnFLKKF+HyTlGv2sibtE5GKCTgEHH
         ALjAlr4uZztrdBVx+KD6ozKwmA8VorOYY93+sU60dJJnfwrFvD97+hV+J90h30ZQ0wRD
         1lbOBdbHdCHfB9IVmVb/9BIZjSS46Da6Wbx9VKiPkWW8pSeXEFjO8vXRhXRlU/Xn+EIy
         EjHsttgnC812cpK7GFSxA9J0EPkL3Nrus/AmI2IBqRXUpACy2aYX/UZeCyWrPMDQbIPX
         3bnvAe7XRNYGenh+DCVuQphMcICzcT/vldkrAoiklU6VFdxJHDbdnZLBdVDzA8MM2292
         sqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481736; x=1705086536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC2bJp2abkUAY3rCEbXohtWXjxySOLDcFj8N67lxtGk=;
        b=k5li4XdN0Xbrrtk7+yW5zr2kcMdogX0G2oKJdKgsXHCYhj4ZDaEES/01+ZTbIg1w3/
         Ug6BMwNefwGUCr7uw5i/1R2eBLPGalKHOZLQXoe7ITopeoESgW5LpP4pmP1PKhnAlQka
         Fsv3viHEB1e1d1h+9vcvoFrPMjh9itRT6sogXyrHS9HcwhmzyBBhmb1sYuIxbKyI4F0s
         BGF1ATk9czW9AaNre8zKTND8qml06dDYL9VcidZMbSi9o01iTQnG3N+p7DFqvyptPmCE
         YCBzNNoFow5gOJnzXKA7dv4oxChXndg4UPphmvPxvWDP03iWW6b8M5zu0fT7+/VGdlXO
         hthQ==
X-Gm-Message-State: AOJu0YzbfwQUH82UvHPNFdOwHLp8KRsyTJhknBtgF+TncNzkT1MuExZq
	vxgSz4Y3l0mBqHY5ixuk7Wj4uO/xD5StEaOohSQA9jiKtv7i3Q==
X-Google-Smtp-Source: AGHT+IEK0/3LJwUV4kqP2Gt6f/UKalZkGldGSpBhIQzQfzQExxk3vB697yusXLa/RW7IA6p/kyNMnVIY1v5ZBsrbO1k=
X-Received: by 2002:a0d:c785:0:b0:5f5:cdbb:534f with SMTP id
 j127-20020a0dc785000000b005f5cdbb534fmr1479204ywd.24.1704481736301; Fri, 05
 Jan 2024 11:08:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com> <20240104084206.721824-8-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240104084206.721824-8-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Jan 2024 20:08:44 +0100
Message-ID: <CACRpkdZ9uYj6geL+_NijdCP3mem-Lr+9RB1Nm4_hL3U480merA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] drm/panel: nt35510: move hardwired parameters to configuration
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:42=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> This patch, preparatory for future developments, move the hardwired
> parameters to configuration data to allow the addition of new
> NT35510-based panels.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

I tested this patch on the NT35510-based Skomer and it makes the
whole display mirrored around the Y-axis (text from right to left instead
of the other way around, penguins appear mirrored upper right
etc).

+       /* Enable TE, EoTP and RGB pixel format */
+       .dopctr =3D { NT35510_DOPCTR_0_DSITE | NT35510_DOPCTR_0_EOTP |
+                   NT35510_DOPCTR_0_N565, NT35510_DOPCTR_1_CTB },
+       .madctl =3D NT35510_ROTATE_180_SETTING,

Changing this to NT35510_ROTATE_0_SETTING makes it work
fine again.

With that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

