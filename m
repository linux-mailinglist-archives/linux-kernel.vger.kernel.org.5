Return-Path: <linux-kernel+bounces-13417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B48205E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41371F21B49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2085883C;
	Sat, 30 Dec 2023 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTe2xLIg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D18F44
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f0629e67f4so7858747b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703939347; x=1704544147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi9JGb5m/P41q0mbnGu3AJyPrO2SRA6tp9e9eIe+k6U=;
        b=aTe2xLIgFvVLdijVNg36ZdmsjWmtTxWFm22rR5pJ1FVweg1ezARmcwnVN1e4BN0VAZ
         NIrRpOkKtdMJ7QxckiAqly/8Npu8oVi/fsKHUM4qYcIzPAZKVtCDp+yVjPVU/mpqLOz7
         i8xDnh+NOGjeRYR4qeGZN7bPM0RZHFo+SNnBd5sOMnegKPZThCtz39g9dIbtmUOOCF+8
         SqlNfuYLCjyrtB1TG7BwHx7OzotnAXDUZeAdJ5xewUKVYipMvfHRohQJEiNm5ENjxANW
         wvaNJ+00E4svGQOyrHH3AiDUER8RXMTRE/SKkcqWeAnsov3JPoCsq/hLcg9RvEdsISOn
         MaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703939347; x=1704544147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi9JGb5m/P41q0mbnGu3AJyPrO2SRA6tp9e9eIe+k6U=;
        b=V6PiIL1fArvUpok6eSE7zF6aYyaAGmLQ8IH5B958kmodqnm/09EA9fr2d/qUSZAidg
         HdQZZ2qpLbfgQmSg4EDQVA0zmWaEJp9eM4srE7h8Z2BbsjsD2ZbltwUYc2WOkDiJsyqs
         fTDH2K3C2F3EPPjgk0Sjrs8gTTRPlSuunJCOFpvIT555IlJ3O9Ke/shMs1QDvrYUHkNK
         0L3zmlKcUsmEC5Az4x7B0sPjca894oSuYtjxNX6EDahlmI8OpDHhIyLEXHu4V/osKbgG
         NAoOwCcGg72a4pLWRSZP+jBxNY1GuuEOz+6iD0aMNFN2Q/zWMDBll3iyJaWnZSkBy+qU
         THog==
X-Gm-Message-State: AOJu0Yy+t04x5+BwIejXPWevtrfRa28gL4i2tVcYhgBSRTZKnMIeyZft
	t8tYoVjfUyKyvDZQkigzMiZWgyRxCMJwDaBLHZvMB9JguymVcg==
X-Google-Smtp-Source: AGHT+IFfrvzH9/iGLgpKmPh41MR5pwawKxrdLCjllXDkv3P1+Zj26CtfQfMdkxm8SoP/n2aXquXlDe2uJhXqR8pjIFg=
X-Received: by 2002:a81:9987:0:b0:5ed:d4c8:df55 with SMTP id
 q129-20020a819987000000b005edd4c8df55mr4148754ywg.2.1703939346587; Sat, 30
 Dec 2023 04:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
 <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com> <CAJq09z4YSGyU6QuZL1uEB9vH39-WbR2dZhy7MiD=5yZb0Urz1Q@mail.gmail.com>
In-Reply-To: <CAJq09z4YSGyU6QuZL1uEB9vH39-WbR2dZhy7MiD=5yZb0Urz1Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 30 Dec 2023 13:28:54 +0100
Message-ID: <CACRpkdZOKz-DdZgwwxj9FsJZ+GNMCXUjTDLo5wVgjw5OrfOZQA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Ansuel Smith <ansuelsmth@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 6:19=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> I took a look at the LED code. It looks like you got it a little bit wron=
g.

You are right...

> If LEDs are not disabled, it will use the RTL8366RB_LED_FORCE for all
> 4 LED groups. That RTL8366RB_LED_FORCE keeps the LEDs on. I would use
> RTL8366RB_LED_LINK_ACT by default to make it blink on link activity
> (or make it configurable as the comment suggests) but it is not wrong.
> I cannot evaluate the RTL8366RB_INTERRUPT_CONTROL_REG usage when you
> disable the LEDs but it seems to be odd.

The problem is that since I don't have a device with LEDs connected
to tHE RTL8366RB it is all just dry coding.

I would suggest if you can test it just make a basic patch that will
at least turn on the LEDs to some default setting that works for
you?

> I though that maybe we could setup a LED driver to expose the LEDs
> status in sysfs. However, I'm not sure it is worth it. If you change a
> LED behavior, it would break the HW triggering rule for all the group.
> I'm not sure the LED API is ready to expose LEDs with related fate. It
> would, indeed, be useful as a readonly source or just to
> enable/disable a LED.

The LED subsystem supports hardware triggering etc thanks to the
elaborate work by Christian (ansuel). You can see an example of how
this is done in:
drivers/net/dsa/qca/qca8k-leds.c

Christian also extended the LEDs subsystem with the necessary
callbacks to support HW-backed LED control.

This can be used already to achieve HW triggers for the LEDs
from sysfs. (See callbacks .hw_control_is_supported,
.hw_control_set etc etc).

I was working to implement this for the Marvell switches but Andrew
wanted to do some more structured approach with a LED library
for DSA switches.

Yours,
Linus Walleij

