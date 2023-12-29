Return-Path: <linux-kernel+bounces-13189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27498200E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CDB21769
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099BF12B85;
	Fri, 29 Dec 2023 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJotHam+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65A412B6B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso5998896276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703871803; x=1704476603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NksR4Y0NrUvy+Rxpg9VzrCsku+YIs4s2MG0gMgIvcUc=;
        b=TJotHam+BKNSdFJnwV7PM6HwuRpj02wcB/otHqA6bJQ8WMu3fPZPS9g1BNO5ZzRPdi
         hvciOwb++SOw9XC8zHz7mte3RqdQNfivLmdKYEP956V0s0QxOGdYBNLBE0Q6WGcPploW
         OF4wq0gziggD3V4u4PiRcPjv0O3UiLSlrM1s/MjXETJwIX1SYm3OsQAQsKgDZkP/xxge
         AOexerPioGaeDQI/69TcEQV67LSN4ct51eDYQ+JQDgJ15GAKvuAxn3Ze0pGyZHSscKB9
         CLx2qVU9dUA9kNGO9DCh08JdHnMWjoPkvOfhPwCUMtfplVRfbcVNmiGcF1OriBMHloxB
         pKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703871803; x=1704476603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NksR4Y0NrUvy+Rxpg9VzrCsku+YIs4s2MG0gMgIvcUc=;
        b=qA/4TGVdMPYYIyPf4BglCalJC4U+aa8UFn/B6A/R1WkLU1dCXNmV/96jGzaFjr55gv
         5uCb0VV+mCtHqv3ll97xhb9tU/J4bVCMsDKpVuh4OrwMpKXKmgg53n2IHCBnCJGI8rjJ
         rhenbP6jXwvaC23LZJnuU2FEz06tHCwgl7DP6O6uZ5auKSGoTDa5U3ttNxbVtBs4lEcE
         +JRzzbrDFJSrI24sv0xeoSgYq0jV0HyEY4m0+E2UyDfA+7CZwX6voyVNdopvl/zd824t
         Hl166hwB5ZQWtbO2HxtOu0skYcneXR9v4tJQ0RKj0xWlq8wcwGz0j2z/Gat6MbGUy/uZ
         CSjQ==
X-Gm-Message-State: AOJu0Yxt80cYn+le6CdEkD2GM9vNaZQScA79Y0s2j9u9wRM9VgjUschQ
	AqW3Nl1HBOD9BvcOpAeJKRIYhrDAIZRyFt/9hCFfs6bUKJP0GQ==
X-Google-Smtp-Source: AGHT+IFnWHAjBL3ppmZayDtDj98vb3SmrehR/QcRTr7cVgxlTrwqWX5c8SlCfehL2vjo/b007G6ikA2wwqzr7RJ6klE=
X-Received: by 2002:a25:9f0b:0:b0:dbe:3259:770f with SMTP id
 n11-20020a259f0b000000b00dbe3259770fmr2678598ybq.71.1703871803682; Fri, 29
 Dec 2023 09:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com> <20231229135154.675946-8-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231229135154.675946-8-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Dec 2023 18:43:11 +0100
Message-ID: <CACRpkdbHodbAwoaTyxTX4LxYm6ZrBV6m6ht31Y2OaUPxS0Zhrw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/panel: nt35510: refactor panel initialization
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 2:52=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> The previous implementation did not make it easy to support new
> NT35510-based panels with different initialization sequences.
> This patch, preparatory for future developmentes, simplifies the
> addition of new NT35510-based displays and also avoids the risk of
> creating regressions on already managed panels.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

The idea is to have the driver adapt to different panels, and encode a deep
understanding just like we do with all hardware drivers.

NAK.

This patch:

- Deletes a lot of useful documentation on how the panel works.

- Deletes defines and replaces them with magic numbers

All it achieves is a bit of "magic sequences because we are used to
magic sequences" and that doesn't look like an improvement at all,
instead it creates a dumber driver which has no explanations at all
to what is going on.

Please rewrite the patch in the same style as the original driver.
The fact that you (probably) are not used to writing display drivers
in this way is not an excuse to destroy this nice structure.

There are things that can be done, like create an abstraction for
sequence encoding with less open coded command issue
statements, by adding helpers to the DRM core, so if that is what
you want to do, then do that instead?

Yours,
Linus Walleij

