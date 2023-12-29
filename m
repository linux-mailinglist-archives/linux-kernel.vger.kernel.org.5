Return-Path: <linux-kernel+bounces-13190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003558200F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B916B282251
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519D12B86;
	Fri, 29 Dec 2023 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArIQTrje"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516C12B7A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd73ac40ecso5227499276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703872001; x=1704476801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW/8qnQVOuCrpelBOhL9bBZ5oe2cPmQUpD0VXBVorkw=;
        b=ArIQTrjeqOU62WiMI9FMCw79OP+MODMUtzsP39IfY6DBo4eAMx+FcCn8ANfF2jzqQc
         uDkHZCwrfwPmNOsu3AMH6mGfWiLDV9n4147F4FJYDvHago9yWDrDw29gd83ljEvswqHO
         RDPovKbOtqcCqRnVTOxAtm2E9rUN3gHUER+w6rxV9WgsNeXhPrP2RkoySqY0Zg38q97i
         bhgaA7Gl5n4YA/932RhzO3Z3HtZNqogLn1SIw4u1l3KNcfZlZ1uJ+YnRzUuVA0D/m8vq
         vVqL2DITCkAeIB8Fti9MtpDe2vr/8/AM0cMug6fogDOmzezaqkWw6rrCCTIomL8MIx3F
         ZwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703872001; x=1704476801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW/8qnQVOuCrpelBOhL9bBZ5oe2cPmQUpD0VXBVorkw=;
        b=GzXB2PiTxXXW0aKZGXrPZnreXK4xLeKuZ8WOxJkpoQRb5w/3MjYzwHQR18s8FCsVma
         9HWyr5Qe07Va+eIaj/C3iiTLE35D/OqTzYPnFJamNUFptrx6JpB4WMx9MvNQlu+iyi3o
         mDk+kwwvlKKGrqKWEzcoHYicXhVpOOsD3KckW4BCKlWK0yCjA/eXJnwcngyAeW9DO3Fb
         PRUOQi7VVVGSmmB4XNEz/Nrn8NeBNwQmUCI2sn1qEjxg0AhpuHO3hxaGCQjs9RliITcw
         VP1GLx1Ot40woIBZg99fDcBOYis0xpnW5mYEeRzA2JCGNW/5dl5CHW+WGV1QmkOzlrfR
         z3Vw==
X-Gm-Message-State: AOJu0Yy7p10vIhDo/d71bo89/wGvF7CLlj7W3X+VAoixxSXcMt38xorJ
	c2QSUmc6pYCVsMWcoIfkb+uxiFDc2Imy4w0eXguhhJ3j28+2hQ==
X-Google-Smtp-Source: AGHT+IGLODEawCuJpoVcBVXIkKKkBjBq8qoZWCqtUWJ3Y7AZ05fBAjMAbbu202fTig97uet5lOUKFj54M3tLy989Hr8=
X-Received: by 2002:a25:664d:0:b0:dbd:c1ef:bca8 with SMTP id
 z13-20020a25664d000000b00dbdc1efbca8mr6857806ybm.40.1703872001727; Fri, 29
 Dec 2023 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com> <20231229135154.675946-9-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231229135154.675946-9-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Dec 2023 18:46:30 +0100
Message-ID: <CACRpkdaEPGonc_pDiApEN2XNn3R4hdUtEp0TZqWjBOmbM_Gimw@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dario,

On Fri, Dec 29, 2023 at 2:52=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> The initialization commands are taken from the STMicroelectronics driver
> found at https://github.com/STMicroelectronics/STM32CubeF7/blob/master/Dr=
ivers/BSP/Components/nt35510/
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

NAK.

Please rewrite the patch to use the detailed instructions with clear defini=
tions
about what is going on the same way as in the old driver, and add #defines
for all the magic commands, and break down the commands to what they
are actually doing with the display hardware.

Magic display init sequences are not OK in this driver, and not in general,
it is all the other drivers that are just unaware about what they are doing
and this driver actually isn't.

Yours,
Linus Walleij

