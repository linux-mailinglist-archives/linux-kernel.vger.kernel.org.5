Return-Path: <linux-kernel+bounces-18167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE582599C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC09C1C2324A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85730328DB;
	Fri,  5 Jan 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGR860DV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F135288
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f6b77c4743so72147b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 10:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704477748; x=1705082548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3KinRLo165j61fa4NsbUi17jBU/PExxRI33z/4AFbs=;
        b=rGR860DVqh3+GpWRht87WWzIYA6U9+zY3BNv/1bDKFoRdcxrdRt/gFpmJoJTc0IMdh
         Atm+d5WWGFYiRQIz4KsYrIYnm/Sg1e5ddTMKe0J5729+F/+eE63OpKi4jzfEI430QrEc
         kpeifl7NfUJ3bcvNd0rn9gZhiiph0XaPJVZLUII2lkUSKC7yqF1+LSTeNuraRl/6xw+f
         8W84tUFq20CTLc6Xb79EAY6vIHUaOQZrrpwVfod1lMTYG5lOgYJN6wAJmWsgVfdaM5w6
         GFxAe7sExYGuzuy5hrwPiNq6/FgSy5tdUfXBF0lckGpEsagCbJ09BljD+nvtgOOHhdm0
         42QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477748; x=1705082548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3KinRLo165j61fa4NsbUi17jBU/PExxRI33z/4AFbs=;
        b=ksuFfqIrIprFHH/yXnYoBK+JkX2oRbblC2CpCFT8NDwWiZBUvPEfnU6SPcs6MWGfqj
         OqxBtAt2mVdpM8RywCyXaTHnOtScK2gM4IUDhroBccIYHKmoORjXrprO5rfIrWo+D3Nv
         wGJi2WXrSnWZ/u9diQWqjO+7mb7vQqe5EhrB3nQaVZ3ElguPAjRrgUGoM89d7/D/tCQn
         9wwlNF5dM93MOmkp4RM2ZuNmgtDuyExAOVYCP6yJf/5HG9PN4hOnae+jPSNnxwJTyxUe
         UsfyNUtS+79L15wX7Hk1K+Q+jXVzkjuLIqnrvNBBDELItZZKjED694qK5CAhEUfKZgQP
         Qq8Q==
X-Gm-Message-State: AOJu0Yxjjm0lUD0xKSLl0HgwYmYQOmLt78jW/sJ90p+L+tT8g5Zr62xu
	rtGMILLH/eyezKeicb8Fg9NWOd5ch0He2sX0UOnmDsSjkFsa3Q==
X-Google-Smtp-Source: AGHT+IE2vBxHKyLGiNcmtNrg0CxcHLyYuO06CAWql2Vi8SPqJKnsxistIiKgFoDsYTIgSm/0y7GTNErYq8doY+/T6Pw=
X-Received: by 2002:a81:5fc6:0:b0:5d7:1940:b37b with SMTP id
 t189-20020a815fc6000000b005d71940b37bmr2624844ywb.71.1704477748240; Fri, 05
 Jan 2024 10:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com> <20240104084206.721824-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240104084206.721824-6-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Jan 2024 19:02:16 +0100
Message-ID: <CACRpkdZ5988n84Z+G8UccQDdwzj=+BXvUkEHomY1fgMrc6=OAA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
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

On Thu, Jan 4, 2024 at 9:42=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
> Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

v4 looks very nice, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

