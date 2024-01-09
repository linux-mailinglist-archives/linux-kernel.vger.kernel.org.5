Return-Path: <linux-kernel+bounces-20856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80EC828651
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6861C242BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013F381D6;
	Tue,  9 Jan 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BtLss2aG"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836A364AE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed4b03b48so1898464276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704804883; x=1705409683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uINQIAiQq6opaJwfh+dSsKqfttMGu6VRZEEKvqx2fC4=;
        b=BtLss2aGfAjKNOe2k2r/c6vQK9O9bJsqDZQc+FGNtDGSYMfnJfyX1jkriDbGXJz2yh
         7PeFvSmdaBLCDKy0Fj86EJE7jZM55kDmaY/mm6TJ6yWK8VrQdBP6skf2ElamtXnxqXAH
         jw9oCrp83FHmUPo+TNckUzEOuKKo4pcDUo3Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804883; x=1705409683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uINQIAiQq6opaJwfh+dSsKqfttMGu6VRZEEKvqx2fC4=;
        b=UiQE2rLnCH68ySQdaybNK5YSCvEZciQiMwmxVA1qjExh9Mi2H3faUDl8LZNtpRNFTp
         uQDSI2F3V3mcVFJaP6MvVmdzvgnrNpW4tpOKGw1Q0KzJi1aHdlWAulvKyJLjZElHJnKR
         O+gcJbj6Yl0QfNCvAC0JqbJsZsBfMdON+LPfl//8KPyd4Y2I/a3lyTD6RwZRrFAfd+38
         UJgjGYumSy0CQ5dvsrdp06CpnLsgbinR7HdXZQwDvM03eD/xf3hFfKcx0rKoMkgHzr+t
         kB0cwtunwPQR84dFz/OOd0rODHhnBLYbfX1HilSb3HHDX8igz5D/VzoOU7rBu1BrPAj/
         e3xw==
X-Gm-Message-State: AOJu0YxRcL0y7nJ9y4OEGa0um99+mM8ogCjSxedNJiK/1NyqKIIcPIM4
	eP5LXf6twSkYOw/1R3NGFUn5efGtkTBT31zGndDrz2gt6c2Oqw==
X-Google-Smtp-Source: AGHT+IFx65iGUYcVspn/xUO0KxzMABmp//fRhiLdAyGbwggiEorVZIYs2zzC9P5dcI/pwcKtYSoedhuuhdimn6SekEM=
X-Received: by 2002:a25:9b41:0:b0:dbe:d45d:1253 with SMTP id
 u1-20020a259b41000000b00dbed45d1253mr2578201ybo.92.1704804882276; Tue, 09 Jan
 2024 04:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
 <20240108201618.2798649-6-dario.binacchi@amarulasolutions.com> <CACRpkdb73Qrs6MuiC427f=RnyD=rydH_4xVhBx-2bS8bX0mJCw@mail.gmail.com>
In-Reply-To: <CACRpkdb73Qrs6MuiC427f=RnyD=rydH_4xVhBx-2bS8bX0mJCw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 9 Jan 2024 13:54:31 +0100
Message-ID: <CABGWkvq0kbjDZTZj-PN+Sj3jo7SAx0G5PcTeA9KDfceh4D8_yw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
To: Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

On Tue, Jan 9, 2024 at 1:51=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> Hi Dario,
>
> do you want me to apply patches 5,7,8 to the dri-misc
> tree?
>
> Yours,
> Linus Walleij

Yes, I would appreciate that very much.

Thanks and Regards,
Dario Binacchi

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

