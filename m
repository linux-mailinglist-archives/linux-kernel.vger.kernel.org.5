Return-Path: <linux-kernel+bounces-13396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1F82048F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B18B2113B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E108F59;
	Sat, 30 Dec 2023 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QYh7HljN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A828F42
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5edfcba97e3so32103267b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1703935650; x=1704540450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqmTg07L9Xjis/7k4DxCa7tRnJDtPkHV1RraDq6khcg=;
        b=QYh7HljNqJi2+YWvh+1Dp38x7LSvF6zCIzaNGPmCR4dSb4aYcbzZXfxtjnhwt+D3HI
         f/HgeSCNfW0Xzl8fDv2gdPMi7+sPkU0ChVV1V/7LtbD/uNKI5Cjl3G3TsdC/O1pWZQ1f
         rTKb7EgVPYFrAMEjVAfYNbMEJLlSAIgglBgq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703935650; x=1704540450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqmTg07L9Xjis/7k4DxCa7tRnJDtPkHV1RraDq6khcg=;
        b=Gz4BTUANFUBdcByHp5ZMVoj7F4T4ANYtAiTX8OUok1yxlN80/OKomeAYyPRrvFmB5f
         XNbeW0vbdQF7XV3pVhYg6RrIHuArTl9avVdz4LQOE/0eLD85fgN385gtd21E2mAUd3vQ
         tvvsxlt0yVdTOpVL5KuuetMlN0maUKiPBK8ndzKMx+OIkWgzyessioo8AmhVQki+fLBI
         6ODrxzjQoSM5sFh9g3e6MY3b9p6HicZ/qXKmyNcuRGxDUcLKTN1HCvxH+okCkgRqf0Xc
         oHOgOlg7FvW+C7Fy5KYgb6dIG1XTH3XQiBAcwEqdoR09jIfT3Pr6xYgnsQ7/mwSMpDqF
         Fh7A==
X-Gm-Message-State: AOJu0YwqePSdcS0z7oAaez1boqaR5mZauAYta5nI32DM7VixL1nyu3Xk
	yK+dzopwFou4/Zquej1BX7kCB4nFz1js9V3OsFIQqMt8cPXYAQ==
X-Google-Smtp-Source: AGHT+IE1r0S0LAjVTcbxxyQYJGt6YexIbq2As4b4Kc1EgXx/p5ebd2qlHzqdVuAFQXXYksM4upWkuU9Jq0EgWSNg4pI=
X-Received: by 2002:a25:ada5:0:b0:dbc:ec6b:3e47 with SMTP id
 z37-20020a25ada5000000b00dbcec6b3e47mr7826906ybi.33.1703935650320; Sat, 30
 Dec 2023 03:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
 <20231229135154.675946-6-dario.binacchi@amarulasolutions.com> <CACRpkdbBBQ96qfdmNHrbOdV9hhFheyTwTkwATFZRPBRiRcN4tw@mail.gmail.com>
In-Reply-To: <CACRpkdbBBQ96qfdmNHrbOdV9hhFheyTwTkwATFZRPBRiRcN4tw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 30 Dec 2023 12:27:19 +0100
Message-ID: <CABGWkvrs+yqCC64Hugmp8jd-+Co7_oakYuMX36zpiFDJ5bvy=Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
To: Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

On Fri, Dec 29, 2023 at 6:34=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Hi Dario,
>
> thanks for your patch!
>
> On Fri, Dec 29, 2023 at 2:52=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>
> > The patch adds the FRIDA FRD400B25025-A-CTK panel, which belongs to the
> > Novatek NT35510-based panel family.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> (...)
>
>
> > +    oneOf:
> > +      items:
> > +        - const: hydis,hva40wv1
> > +        - const: novatek,nt35510
> > +      items:
> > +        - const: frida,frd400b25025
> > +        - const: novatek,nt35510
>
> You need a dash in from of each "items:" for that to work.

Thanks for your help.

Regards
Dario

>
> Yours,
> Linus Walleij



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

