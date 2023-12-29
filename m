Return-Path: <linux-kernel+bounces-13187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BE8200DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F28CB21769
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C212B7A;
	Fri, 29 Dec 2023 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Myk8aPh5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CF12B7C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbdb124491cso5338027276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703871275; x=1704476075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bgoZanEJc0MVxJH2BDSMbBMEAKcJk5zfc5k6GcxfOA=;
        b=Myk8aPh5ozIYsHGmlHmlNWZqfZ8c8qq+EVLEiWr0UAF8m67R1xY5ArWwi6GicAFSGl
         fNTgRQAKwxQztZJIz4ujmK/NzFYAeVekcOgFz75eErA9vGvBamrF0fnTnTTjDftG8Rga
         UtqKLpDWHCiAPjjLpN6H1P/2mwWTLdXN7LA0jbhe0ubR5bb+0J7uL50dIyIlKoE6Hd4u
         vXBZgUWm+DuqsC7uhcozlgpT+/TDDWrAr1CAyHnIt6syPF/S6WXESYW6UoebO7q2TrFy
         xnRDicbHYS1WrrShtcU6mprqaqs+rZAbbNNzaBvr4rykp+DrE1Sw7aC6a6Y5N4e4mHcG
         Cp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703871275; x=1704476075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bgoZanEJc0MVxJH2BDSMbBMEAKcJk5zfc5k6GcxfOA=;
        b=tsyVkE50OdxF7CE1EvHHKB0wJrILckq2vY1EFf0I/oZUWROXPQX81Z4OpjLjk3ZX9E
         rwAX2g6jY7sR7IgqgS0e+Q7LCZna52EiWoN3V7wttEnMNJJkw0x1Jqw9JWRTUFJOplG3
         kpR1jQXBMOJgWZmuKK6Q8NCZeMeoRZ+v1k4IDOVNCkTQc8jsP1pziWtwtX1oeaX29H7D
         FBhMb7jW8e6LIsc4rk1aNlW/eHISUOY42pgPhYjl36GYXWrGN3BNBg8lzoKPHRzgXkI8
         8tbF1/Ij2byf6uuyFMZ93jto0ckiKLD182f81uDglbGHXzut0uFru5LJccTCcnUmPvkP
         VJ4w==
X-Gm-Message-State: AOJu0YzWHcQqalyWFBa2lp9ek6iUzKXEh/m1rCikkORN/qq39iF/KfSf
	tx1pbHCMSWJWNJMZOPYtXpJVRz3qZCagKMgyAPdQNGJqTHOnsg==
X-Google-Smtp-Source: AGHT+IFSKk3LElC23rghumLsGQN44wIVKMmgnZ+4F9zE0vmvJUX+M2f//YN6JsyIMAeHJLG0lr44MKU3n7AuX9e1S0k=
X-Received: by 2002:a05:6902:1782:b0:dbd:d003:3c16 with SMTP id
 ca2-20020a056902178200b00dbdd0033c16mr7305225ybb.9.1703871275630; Fri, 29 Dec
 2023 09:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com> <20231229135154.675946-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231229135154.675946-6-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Dec 2023 18:34:24 +0100
Message-ID: <CACRpkdbBBQ96qfdmNHrbOdV9hhFheyTwTkwATFZRPBRiRcN4tw@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
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

Hi Dario,

thanks for your patch!

On Fri, Dec 29, 2023 at 2:52=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
> Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
(...)


> +    oneOf:
> +      items:
> +        - const: hydis,hva40wv1
> +        - const: novatek,nt35510
> +      items:
> +        - const: frida,frd400b25025
> +        - const: novatek,nt35510

You need a dash in from of each "items:" for that to work.

Yours,
Linus Walleij

