Return-Path: <linux-kernel+bounces-140016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E18A0A60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E727283A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37113E8A1;
	Thu, 11 Apr 2024 07:45:43 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8013E04A;
	Thu, 11 Apr 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821543; cv=none; b=j4Wpn99/9SobHdR0k5oAu3jehOOhZSRYYheKaqS2yW+9WTeGtS1rRk1kHI0Ep9Jyi1g3T39RV6xt1QjZtgvOORB5A+BDHyksRZUEv8I766Y6dFSM8uakHVYhvgr5Qe7w7Wo+6UPoP0ausPw3UuFjj5d38Eicfpkg7l04/xN483o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821543; c=relaxed/simple;
	bh=r+uHfO6nhURoV/pkGignKxKYOu+ttuewlNGxARe0TkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6VOOQebcHmAXwsLeLOrW2VypTo+HdJ9iGl1XJsktEWzrCsjnMJp2r4NBGFeU7AtNCJx2acWHLzN8VfyOXoNZ/0iXJxDPOWXJAGOTbY2+0l9tiYCnl9EIZd2Rn5mosOu6HnTRzuBfqvKzurSXV8I2PprC+gOKzrZiYycrtA8V7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6154a1812ffso80578817b3.1;
        Thu, 11 Apr 2024 00:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821540; x=1713426340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLCbqACAEmw1RFUJ3MP/4fcprBXm3Vbx6jGa7VJAGWQ=;
        b=OdBrqMC8rgyGSRr1LOisp9C30R/Zv14t4gB3XDE1ukbQePjv1EH1l4rZeKsQ9VzK25
         Bgv+lYObqDSHXccnpaM/BlcRO9HOK8exXzcSAroSrHZXiAB52uDC86v0GHUw1XlePn3g
         I0ib0nLy3FkHlPRQtnV03/ZD5cGNg0aLz8kuN846Yb66lmvlA41n+GxP8VoheSxOX1aw
         rXOyxUOjmMnKjEibmxzGwqEIKkW/LAmKs5vUM31cTsbR6PvrEEpCdliQj27MiXJnxuFz
         HjRqAgSPs4YS+3VJLcfZBk1QmDjbe5gciRXAABPQ8LXmJahUZ4na5Ps9dED9C+6GoPd6
         dw5w==
X-Forwarded-Encrypted: i=1; AJvYcCVKQnDNZ9feocadqAyDBtrkJYdFTMoIzxkcyIUDoOijN8H3DyiclH45UrALlgud/vhYQXTQ+yPl+biCcvuBav0RR/9cZmcKU5ybsY7gzWgAqD7uwLUA8cfUABqITzxwcHvcLtRPtYMVxSGfvToj8l5OBCieJm/u0CggIgxuV+wEck+PvHTT6nH06q1s4QRVIsmD8Ea332HMICWp25cmCTFvGRBZ
X-Gm-Message-State: AOJu0Yy/Msn/+5Q2gxOUmxYlsZjXOC5Ykew2/VCYP0wmPWG9rfHVZCA7
	wqz+hcSb79pcULm81rZdt4twCdEpXr4QcJfEwICxTblqcaNeCv+22O5UEBqU
X-Google-Smtp-Source: AGHT+IGKOjCRJkfXoOUxCfYnLsPI278dml6c6tmCPCYSOIZxVLfSUYlod+COy7K/iibLYcAICafx8A==
X-Received: by 2002:a25:ed0b:0:b0:dc7:6f13:61e2 with SMTP id k11-20020a25ed0b000000b00dc76f1361e2mr4843231ybh.58.1712821539691;
        Thu, 11 Apr 2024 00:45:39 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id g36-20020a25ae64000000b00dcd2c2e7550sm184862ybe.21.2024.04.11.00.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:45:39 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso4969494276.1;
        Thu, 11 Apr 2024 00:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHYsRRfFzE46a8v1BVVF/E4cXEeVYYKzbi/2Q81Ll0wfIS6aXURBHTjdWmWggumJ9cT1ETJWOZjVr/QrfcJy7oj0ZaZNzD7L+sg6tV2ZkD8BbPF0A6ei+npHBs4w2U5oYHovw6gLvRdv+9BLjfqOAXz8kEwO9BwazYUbtYZjaQHUSDv9mNQzMpHbN8653Q9CIxe22sHcf9mwnOLP64d9WFCMUa
X-Received: by 2002:a25:bac9:0:b0:dda:abbd:7395 with SMTP id
 a9-20020a25bac9000000b00ddaabbd7395mr4287330ybk.51.1712821539199; Thu, 11 Apr
 2024 00:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
 <20240409-rzn1-gmac1-v2-4-79ca45f2fc79@bootlin.com> <CAMuHMdX-F8LXWx=Ras4f+Dt_r485HKjRDLydDXZsnZBW8HJzxw@mail.gmail.com>
 <9bd8eee4-952d-d5b2-c462-45c1466c54d6@bootlin.com>
In-Reply-To: <9bd8eee4-952d-d5b2-c462-45c1466c54d6@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:45:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAB8CuSkrnp+b7-+s3v0eHLr0Lvm1=MveGMVRW3T9T-A@mail.gmail.com>
Message-ID: <CAMuHMdVAB8CuSkrnp+b7-+s3v0eHLr0Lvm1=MveGMVRW3T9T-A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: stmmac: add support for RZ/N1 GMAC
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Romain,

On Wed, Apr 10, 2024 at 2:24=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> On Tue, 9 Apr 2024, Geert Uytterhoeven wrote:
> > > +config DWMAC_RZN1
> > > +       tristate "Renesas RZ/N1 dwmac support"
> > > +       default ARCH_RZN1
> >
> > Why default to enabled?
> >
> > > +       depends on OF && (ARCH_RZN1 || COMPILE_TEST)
>
> The kernel doc states this as one of the possible cases where setting def=
ault
> y/m makes sense:
>
> ```
> Sub-driver behavior or similar options for a driver that is =E2=80=9Cdefa=
ult n=E2=80=9D. This
> allows you to provide sane defaults.
> ```
>
> In the case of DWMAC_RZN1, it is a suboption of stmmac which is "default =
n", and
> I think it makes sense to enable the RZN1 ethernet controller driver if b=
oth the
> stmmac driver and the RZN1 architecture were explicitely selected.

Thanks for your answer, that makes perfect sense!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

