Return-Path: <linux-kernel+bounces-142745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E388A2FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3781284527
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FF84E13;
	Fri, 12 Apr 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSMaEXef"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06E84DEA;
	Fri, 12 Apr 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929076; cv=none; b=mF4eMCiau9rs8lRFvFGXn3BAnJjvDkmD2qJ293Ike8J2zJMW3bVnbPedqN0P+HliBnMpWWX1MFlPmAOmYPjvvIHU/7Co+9tt6+dwUwALiokpYhkf6VZyT7G00KbSchqBr2zVM3RS+DHFZha+BjQTsPakHLp+0KuqeVZdi3ZLoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929076; c=relaxed/simple;
	bh=RtPHTSwAiDMZibFKSA4Jdowqk+RE3EK7sCxTQ9Eflpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj0w9KeUCW2XKk0m8rwCv5wFDnZJ4UHFZzIJ8vjK9zu5g336rZrUuj82ZDyq2aKUP4Zmqs5Mvtok/BTmxE+6cSIEOEY+dO8ZNgumDPwbSyQl54I3Yz/e4lycujlTSBKGuYO/FJ9/8g9ysQS6TzQ2zRzmTfT2FbuzQ5ijGFoEr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSMaEXef; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d04fc04bso1502109e87.2;
        Fri, 12 Apr 2024 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712929073; x=1713533873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBZ/trnMtit0L5nOLjCK4i4uNbzRJ+y85cwstMMxmcc=;
        b=MSMaEXefpKDDc2uYMIpOFc2i2hOxYu0eSZTRHqnSxo7CNMytbY79q2YBxCdcwMDP3v
         x4Mj4nCuoEgBXE/1FhIJnV3qq65+FwY3z/9ZOer636GPaF2hrA5qUZZHESbkYm8kqp3k
         g7+/B8TwTkHdqHbsmW16C5KBMdzueFFfwvQb1OiI08FvoCvFc+19KUaLrxWQPUW5Qiqb
         ZikI0L5Q/GUH3sV1VlSmil9lLJbazMfI6ujoRkGQVuThMFcjoFbSJHDoCpyKWC4QAQ7F
         TOea65qFLHtxL0ywCMJXt+jTsdegEI72D5s9KVWvo4Oa/RpP1h0Ge+zF3z/8pdINMedA
         cOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929073; x=1713533873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBZ/trnMtit0L5nOLjCK4i4uNbzRJ+y85cwstMMxmcc=;
        b=W9Pp6LQYh1iAEa3FGoUmiVeO5YB0X3aapLBKwUwCqQ3KNEC/A7Bgs/LcKALLyhlz75
         AUiiG2bj8/WnoynGgIQf3kWwF+qKYoqM1S9zM35vMrY1kXrJqdV9sz0apvrKCksc/4sL
         5LVn9ZIggXqjZGw1ktBEmkQ8Hn/L8cvibXaz47ENnjr+hwJUc6wqh+kinrlslNzptytl
         +OKwm8yjRy3RCSXv1j3AKVU63FsFHvxM+2HacxUp6AAgCZcJNr6PXJqdutXKX9Gr9yP3
         bxCLCNmTu1TqY30bmnq3hG6Go7BKpvEdfKNpYSyhxFS8CgSeYja9uzjk8Tl8E6CO65M/
         FR1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqa9C0zhFDF4QAzmgDLOEmWjg6SXDjHeCCjGyaYXLXq7nfS7lUzDVqZnhbzdnXx/pbexNzBjDxX/0bHCXEGEGtb3wqj/JbKaTg6f2rl2gLO7ObW3dja+DufzufGHAVdc8nD/IGeDQPvdXilsWQrkOncEwOmG6NZtQJA4eYbfuVAIuNmx8=
X-Gm-Message-State: AOJu0Yyopy9yiP4kGBgCOJNHKpyzc/eqsUtDZgR+mOr8iOquqAKVz2o7
	WR/yNp6tfSTbL2EtRUWED/jqcEJLqJgXIeE4mDSagVmwx3z22P74ZDX0QOC0PTuBY3bxNvIU+83
	uI7BA3zu5fIR7SeStUg6tMxqyxWg=
X-Google-Smtp-Source: AGHT+IHNCOxpEcg7kq0YLqhVyBPLSvQx/KccK2KXiNpUI+6rMUuNO8y0wPk5vLRyn20x610DSEMMlhpS/tWB09yu4rg=
X-Received: by 2002:a05:6512:21d1:b0:513:d5ec:afb with SMTP id
 d17-20020a05651221d100b00513d5ec0afbmr1556007lft.40.1712929073158; Fri, 12
 Apr 2024 06:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
 <CAHp75VfBaU+F-+3zte66mxgJ+gW9N7j8E+0gw9_T9J5DHTnsBA@mail.gmail.com> <DU0PR04MB9417DF1519C59AEBE156BC2488042@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417DF1519C59AEBE156BC2488042@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Apr 2024 16:37:16 +0300
Message-ID: <CAHp75Vch7TzevZQK4CE_WSVOgUdzODkJXiv0=OuqrmDfgevV+A@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dhruva Gole <d-gole@ti.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:01=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH v9 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontro=
l
> > protocol basic support
> > On Fri, Apr 12, 2024 at 3:13=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nx=
p.com>
> > wrote:

..

> > > - Because "pinctrl: pinconf-generic: check error value EOPNOTSUPP" wa=
s
> > >   applied, so pinctrl-scmi.c not convert to err return value for
> > >   'pinctrl_ops->settings_get_one()'.
> >
> > Because it's there it does not mean we want it right now. I pinged Linu=
s about
> > it again.
>
> ok, let me include the diff[1], is this ok for you?
>
> [1]https://lore.kernel.org/all/DU0PR04MB941754A6D751E80840F9A79888012@DU0=
PR04MB9417.eurprd04.prod.outlook.com/

Yes.

--=20
With Best Regards,
Andy Shevchenko

