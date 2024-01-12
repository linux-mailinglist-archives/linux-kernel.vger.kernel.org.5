Return-Path: <linux-kernel+bounces-24526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8B82BDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D36D1F2741C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312695D8F4;
	Fri, 12 Jan 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ok5R+uLD"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7760EC7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5574feb7958so7303815a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1705053120; x=1705657920; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlNYofu3r8i2ZCiashKW8Im9PXJC4O/VU7zX1cqDADg=;
        b=ok5R+uLD6ZTnei0DVPWInfSJ85n49ghZCKD3glCaQMa+f//WmrikyFRrLtuYKf724v
         x4F8ajGuLYjagd++ZzM2jU808PNxVdVE1yty5NEh/d+JJzE13S7JgptnV7E8Z2SyETg8
         Y4LnyvFBnsrx9bVwEEYjN385B0e7TSkxuje0S6nd6YtFjGEmNPSrPEoU+/DmCM3fwtns
         Y0f6jBK8kUxRgn7pCTYWaGdiGszKtB6MCGhhTA8M0dlYRYrcBRM9eExzqPN2+Ru9p2s2
         nb9Cdo3LKOc/b4KjCYy+9rpcCxE6Xv8vwwyDeMdK5XfCEpaSNmWS4+knq+gun2J4XWYu
         h7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053120; x=1705657920;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HlNYofu3r8i2ZCiashKW8Im9PXJC4O/VU7zX1cqDADg=;
        b=Spe+TI++BUnPni0ApjMFb+OgHyHUL181913z2oCTmW58qsaX664IoHbKDQruNzMpOj
         HmFFOSmoaLWyV8JLueHZ0vXMMVvmmBUGFXZXJEDjpdv4npMEsy6KqbxXhoAtGRsfbD+A
         CdRrEdJ7L4VfiITvG791J5ccg64QcZ8F94UE0cyf1GZx55grF7ahZ1fdOGHcUU1PU3Zh
         isFuhE5yu+9Ef0zK0nZUbj0Zupo4CP1XuDHetZ/Xzr+WrNYFX2ncSpZ18xnd6eYZjFzi
         iPCVtrskFYh02Gs+iuL9rI0GTK/Y2OloFz0fKxi7Zm9bFWGL1ofuwPCwZUKEQmySRveX
         JvFg==
X-Gm-Message-State: AOJu0YxhfcNdZpBriXkGnyOm5FD54YdfW/aEKqKu1I4AvCoC7JR2LaUi
	UNJzUw5hhhQYSxwgzQwdUZjufnghxDbNvQ==
X-Google-Smtp-Source: AGHT+IH6D9hm2y3kaGCs5RwJQn2m/6/TZIAhrZDDw5invkLKwXZ/IILZ+DDyExfQK5cF5FyfT3lihA==
X-Received: by 2002:a05:6402:1d1c:b0:557:aa16:1e44 with SMTP id dg28-20020a0564021d1c00b00557aa161e44mr489041edb.79.1705053119939;
        Fri, 12 Jan 2024 01:51:59 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id eg7-20020a056402288700b0055515b40464sm1616621edb.81.2024.01.12.01.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jan 2024 10:51:59 +0100
Message-Id: <CYCMVXHYVDCI.HVH1TR8MWEUK@fairphone.com>
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for DJN HX83112A LCD panel
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <neil.armstrong@linaro.org>, "Linus Walleij" <linus.walleij@linaro.org>
Cc: "Jessica Zhang" <quic_jesszhan@quicinc.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter"
 <daniel@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, "Andy Gross" <agross@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
 <20240110-fp4-panel-v2-2-8ad11174f65b@fairphone.com>
 <CACRpkdaWTfPDCin_L6pefHsokjNyO8Mo6hWPdzPLLi1EUkKUuA@mail.gmail.com>
 <CYBZEZ4IM6IL.VR04W7933VI@fairphone.com>
 <CACRpkdZQbVXfBa70nhDOqfWPbsh-6DgX-uvZOxr19pzMmF2giQ@mail.gmail.com>
 <CYCLSCKPPBOC.1B1MP3VOOC0Q8@fairphone.com>
 <cdc18e2a-b7eb-4b54-a513-481148fb3b0d@linaro.org>
In-Reply-To: <cdc18e2a-b7eb-4b54-a513-481148fb3b0d@linaro.org>

On Fri Jan 12, 2024 at 10:14 AM CET, Neil Armstrong wrote:
> On 12/01/2024 10:00, Luca Weiss wrote:
> > On Thu Jan 11, 2024 at 8:05 PM CET, Linus Walleij wrote:
> >> On Thu, Jan 11, 2024 at 4:28=E2=80=AFPM Luca Weiss <luca.weiss@fairpho=
ne.com> wrote:
> >>
> >>> In some internal documentation it says "LCD Driver IC" "HX83112A" and=
 I
> >>> don't see any reference to Truly 5P65 anywhere.
> >>
> >> In the Android directory I pointed to I see this file:
> >> HX83112_Android_Driver/Truly_5p65_module_fw/UpdateFW.bat
> >>
> >> (Notice the 5p65 fw dir is *inside* the HX82112 dir)
> >>
> >> And in that file:
> >> adb push TRULY_5P65_1080_2160_HX83112A_D01C01.bin
> >> /system/etc/firmware/Himax_firmware.bin
> >>
> >> Clearly indicating that they are pushing a Truly 5P65 firmware into
> >> the Himax display firmware directory.
> >>
> >> To be fair, that is the driver for the touchscreen part of HX83112A,
> >> but ... Truly is a well known manufacturer of display controllers?
> >>
> >> But... given that you have a @fairphone.com mal address and
> >> a working relationship with them, can't you just ask?
> >>
> >>> On their website they have this sentence:
> >>
> >> All OEMs want to look like everything is their own product. It is
> >> business as usual.
> >=20
> > I can't tell you anything there that I don't know, sorry.
> >=20
> >>
> >> Further on the same note since I guess you have a datasheet)
> >> please bring in #defines for the commands (the first byte in the
> >> write sequences, for examples:
> >>
> >> +       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x02);
> >> +       mipi_dsi_dcs_write_seq(dsi, 0xd8,
> >> +                              0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xa=
a, 0xff,
> >> +                              0xff, 0xff, 0xff, 0xff);
> >> +       mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x03);
> >>
> >> Clearly 0xbd is HX83112_CMD_SETREGBANK?
> >> (This is easily spotted from the similar structure in the
> >> existing panel-himax-hx8394.c.) So please add #defines
> >> for all commands you know, especially if you have a datasheet
> >> because we reviewers don't have them and "it's just magic
> >> bytes" isn't very compelling. It adds a lot to understanding.
> >=20
> > Right, the register names seem to match more or less the ones from that
> > driver, plus some new ones and some differently named ones. Will send a
> > v3 with that.
> >=20
> >>
> >> I strongly suspect other Himax displays such as HX8394 to
> >> be using a Truly controller as well, hence the similarities.
> >>
> >> In a datasheet for their TFT800480-84-V1-E display controller
> >> Truly kept the init sequence name of void LCD_INIT_HX8290(void)
> >> for example.
> >=20
> > In that datasheet (assuming I'm looking at the same one?) it says
> > "Driver IC" "HX8290-A[...]" so there the display driver is manufactured
> > by Himax and not Truly to my understanding. Truly is assembling togethe=
r
> > Driver + all the other parts that go into an LCD.
> >=20
> > For the panel used on Fairphone 4 that part is done by the company DJN.
>
> Looking at the discussion, this seems to confirm the Display+Touch IC is =
HX83112A,
> and Truly is the panel manufacturer and all assembled by DJN, so IMHO the=
 initial driver is right.
>
> Perhaps the compatible should be djn,hx83112a-truly-5p65 to reflect that =
?

Since there's zero indication Truly is involved in this panel in my
documentation - much less the number 5P65 - I'm not going to add that.

One other number I'm certain of is from DJN's side the model number of
this panel is 9A-3R063-1102B, which I assume is the specific combination
of components + frame and everything for Fairphone 4 device.

That one you can also find in this document (Ctrl-F for DJN)
https://www.fairphone.com/wp-content/uploads/2022/09/FP4_Information-for-re=
pairers-and-recyclers.pdf
. or on this picture:
https://guide-images.cdn.ifixit.com/igi/HgTquQPABg1mAMHD.huge

So something like djn,9a-3r063-1102b would also be somewhat valid I
guess?

So in short this panel is the model 9A-3R063-1102B from DJN, which uses
a Himax HX83112A driver IC.

And there's also AU Optronics listed as =E7=8E=BB=E7=92=83=E5=8E=82=E5=AE=
=B6 ("glass manufacturer"?)
fwiw, though the display also uses Corning Gorilla Glass 5 so not sure
who's supplying what.

Regards
Luca

>
> Neil
>
> >=20
> > Regards
> > Luca
> >=20
> >>
> >> Yours,
> >> Linus Walleij
> >=20


