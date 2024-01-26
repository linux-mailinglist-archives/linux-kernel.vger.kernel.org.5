Return-Path: <linux-kernel+bounces-40176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614EC83DBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A551C23B52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6D1CA9A;
	Fri, 26 Jan 2024 14:25:03 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C772030A;
	Fri, 26 Jan 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279103; cv=none; b=e+Ev/roHu/FiGq4f4q5nwW9FqJrZUnpj2XeghkzpSdeBVy58wTm1YE9abtgNokfxf67hk3lvEVx1tL7miaBHgzZkK/DxWkfZ+BmYXA2J1xsxY2E0RggIxokOyvHDE/fZOFzExz/1YN9Gf+vfR3kAopMSZQnnptprfoE5v/tkOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279103; c=relaxed/simple;
	bh=lGOt20atkVEg9U8C7LSGX4rCm3axcdD6rMU6JLeU+Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLTClqRn/UhbjYul5lwdZCKdC2ZxuB2jfYIPnSmB5Icbs7g8geLY0YAszn+iIURXepf/YG/8jgJxhwHvVriSyxxnrjK07jIfIGxmxX/aKVq51ixr/WzORi494SlTXxVV3Ljv+yiVDdqEz9jqYlGH8y1673kAegpA1x9UTd6kZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff821b9acfso4051057b3.1;
        Fri, 26 Jan 2024 06:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279100; x=1706883900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AobresbOLLicv0OGCL/TB/MYyPZSt0c9M3tIrPkCdUo=;
        b=lGeXrvtd4F2oN121ttLZd82BYYbRlP+myEPE/aXmrjwMPwZOOekPH70dBpP+WtwcbD
         vnqRjKb6nZ/BKlwYhVJ/jB68zSsHJQ1rkv5wNaWSwMSG8LkvBAk+WZbIbWoQH2j2/SRh
         hTKF/cLEpC3GaeGfFKdmSOsXbLkqiBeOP0oR+c1+oEy+2m1E6WDeyT3aIENGRVMhTdCE
         OMyFr3d67XzmHaC546ENtbUAXKUo1XIH6r1UXdm0VaQ+UhPHnXE4ebHFCp1tyyUQGIu7
         99E9XWWXGCVF5qK7b6mWQevKxZ46hRyu5TZjVjL2TUNx3k72wd9LQtjnltkNw07FO01B
         zuaA==
X-Gm-Message-State: AOJu0YzxKdYarRdabX/gILdacPTyWOptmN3CZuSRm+GbWz5TffXH6gdY
	1yGh94yHiJF68huH3ZFGsX4eqT5i9p+/GAMK6SJ4q7Mo4vXz14Uv6eHzOIluecM=
X-Google-Smtp-Source: AGHT+IHSyl7ChSwD8TQvLm8DRI5o+x9RWRc3RQhHs0SU/W7/JYTnogKIIAfB5D3GnkEROxLImLqUtg==
X-Received: by 2002:a0d:d895:0:b0:602:b24c:2321 with SMTP id a143-20020a0dd895000000b00602b24c2321mr1329450ywe.62.1706279099987;
        Fri, 26 Jan 2024 06:24:59 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id r12-20020a0de80c000000b005f900790763sm416158ywe.49.2024.01.26.06.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:24:59 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ffe7e7b7b3so3919657b3.3;
        Fri, 26 Jan 2024 06:24:59 -0800 (PST)
X-Received: by 2002:a81:a10f:0:b0:600:ec7f:5442 with SMTP id
 y15-20020a81a10f000000b00600ec7f5442mr1174685ywg.70.1706279099354; Fri, 26
 Jan 2024 06:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117131807.24997-1-wsa+renesas@sang-engineering.com> <20240117131807.24997-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240117131807.24997-3-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2024 15:24:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7Z8w0JykKuboP__ZE4x+LeKSQAGdyrUezERxysPUCKA@mail.gmail.com>
Message-ID: <CAMuHMdX7Z8w0JykKuboP__ZE4x+LeKSQAGdyrUezERxysPUCKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] arm64: dts: renesas: ulcb-kf: add node for GNSS
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Jan 17, 2024 at 2:18=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since last version:
>
> * use 'reg_3p3v' instead of custom regulator

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -392,6 +392,13 @@ &scif1 {
>         pinctrl-names =3D "default";
>
>         status =3D "okay";
> +
> +       gnss {
> +               compatible =3D "u-blox,neo-m8";
> +               reset-gpios =3D <&gpio_exp_75 6 GPIO_ACTIVE_LOW>;
> +               vcc-supply =3D <&reg_3p3v>;
> +               current-speed =3D <9600>;
> +       };
>  };
>
>  &sdhi3 {

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Before I queue this, I have one remaining question.
The device is also connected to I2C bus i2c@7 aka AUDIO_S{DA,CL}.
Can it be used over I2C too? Is there some strapping to select the
interface used? I couldn't find that in the documentation.
(It does support clock stretching! ;-)

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

