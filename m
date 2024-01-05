Return-Path: <linux-kernel+bounces-18289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70F825AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D21F23CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AD35EFF;
	Fri,  5 Jan 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpyFAEGu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E135EF3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e82f502a4cso17360967b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704481796; x=1705086596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrAeK3fI5+fkw/MfPT0L/lkhR0LlF0AAtGrWaqYVcY8=;
        b=jpyFAEGupNaWNmndX+MRFpzOsK5wCBdhlmqxOs7xlDRM0CmY/1FjlQK1BVH88Qyp3M
         kqYUmGhEufzuIDsVj+sRE84JvCRDgZTDVQzHCcT58+2uGlowsyi8k0tpYkxk+QaX+BBx
         oB+86odsvkIP/rnbwgFF7gyx8slnbNIpTfxwtfVuryNg7iA1JOlqq+9oAGjvo1UYqcus
         xzXR66HkbWkVd2FAiDCVzYTRUm0WbGkgxM8Y9jXIIBXuUVDx5ZQX9tGX3DH9oDWwd7no
         ZkgA6kVHtu8EdNn4+VfyLJPgt4hsd8f1vxDV3b+RDPG10P0nvMby/QhTwunoJ6ww+ih/
         AKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481796; x=1705086596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrAeK3fI5+fkw/MfPT0L/lkhR0LlF0AAtGrWaqYVcY8=;
        b=jf3Atin8gUnVTX2H1JtThg0nJhEhE6G4OrIe2EWF39ijv/c8/qF7T9SCNwSyGSF3Ht
         raOAlGJXTOZpZFShqBywaLSdqLHgXNYWmpfWfXcAUCf7YRRcbx/BMbPhxQMCiYCquIfG
         9gieH5fXPwFTKnLlwD7xjmqC8RUlKgWcDPRywbFOmlX5U20JO2tQQSnKYv09Mdix91bi
         /hkRoB0w5DA4EDGxOi59FB+r3DDdBJw2j0j3RtwlXHYhnvINvwow1HuC9cpaux1l5eCo
         Rej7A0B5SHqt430fMpIWRuA8wXgFa/Ac//KpW+DieZ2u80UyLHARtZVYQVrFis+Do+rr
         c0MA==
X-Gm-Message-State: AOJu0Ywy5b8m2Xi7aBA6NEyPOB9nLs2z5SEn5/f7m7kfz/zE8iOtN3Pl
	b60VAcrgRYxYk4RjzUVBUHoiwyCuaF+mKcYKRVkkG4GRQZpn2A==
X-Google-Smtp-Source: AGHT+IEOxPfPUR7AAT8oWCL2I4+vSTsXN91XU9CFGSMnOrEEBSllv/Qs7i4m/mjmgo1ty9KHe7vUeDd7Bmv2OIYctTQ=
X-Received: by 2002:a0d:c404:0:b0:5d7:1940:8df8 with SMTP id
 g4-20020a0dc404000000b005d719408df8mr2539262ywd.95.1704481796596; Fri, 05 Jan
 2024 11:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com> <20240104084206.721824-9-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240104084206.721824-9-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Jan 2024 20:09:45 +0100
Message-ID: <CACRpkda+=Zq+v-505O3pHazKzukSifBnNx_CPKbKd2JH-KYpYg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
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

> The initialization commands are taken from the STMicroelectronics driver
> found at [1].
> To ensure backward compatibility, flags have been added to enable gamma
> correction setting and display control. In other cases, registers have
> been set to their default values according to the specifications found
> in the datasheet.
>
> [1] https://github.com/STMicroelectronics/STM32CubeF7/blob/master/Drivers=
/BSP/Components/nt35510/
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> (no changes since v2)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
(also tested to not regress my hardware)

Yours,
Linus Walleij

