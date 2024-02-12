Return-Path: <linux-kernel+bounces-61744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA7851607
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98D31C22824
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A683F9F4;
	Mon, 12 Feb 2024 13:44:53 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B84DA01;
	Mon, 12 Feb 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745492; cv=none; b=ZV5UZohz2v785vt/SKl1Fzi89b71kvIBHEImRtPp0pYadQOHdMtkrKsdqnykshPVU7+g1Mfc+cIoI+prMeTDSJOoRWQXQABOjhzueNirvTwu/1IlwJ+oxt0QMSKJA6opQGZ5reRhGuAu3dKGqYD6ypg436WqRo59Qbh26octUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745492; c=relaxed/simple;
	bh=nZPTXrHA+LiHsIqTB7cqFMevHhP2LgtPPFZtTgHvFeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm8QKGrSa8DoGkVk8UREZu948HbglOxsRGFtEyHHwZd0ivK7uvAx/NNltv9VvOn4p4cjHKJNLQbpF5Vqt8onpcXruQazdGWYJYfjAtyPGqrKjt7J1AvRKY995oRb0hoY4mfVhDFzDxFpyOXAeexFiB9rHLe9zxN9nd2gsPAd1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604ac794c01so21359517b3.2;
        Mon, 12 Feb 2024 05:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745490; x=1708350290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxNfdSF8cpbhVpSppcYCPitW0TR0qg+YicV9toMfXd0=;
        b=BIa7A79rCBp7AVdUvbG1JX1+A5h3o13CTB8Spnowuz4wHU4LUdpTHXqFL+E2d1YuuH
         d/8D04uMo3LCCJV6S4ICEYd1LQml1K2R0WBaOoVS33VcrsCXKP3/TSYj/YXStUj5I6Y2
         32kXoSTXIbgYpOvwMywrP8u09HPTYZr09V98TaYFRCiOqt8j+hmTP0MJqoq6MYSCwzI7
         AAy1iP7EjcBGZEthAv2xiTqaH13ZuxkBt0Y21s2gDuwezfGBWjSLEr619EICUflTIcMx
         8eybqIKUZOsqN7z2MhRN41M1NdQsU4+qlMeqKUTUorOFxf2nYuj3HbX5YW+Zy1IQpdSo
         bL2g==
X-Forwarded-Encrypted: i=1; AJvYcCUsbWdhUBHNAOkMygB7xdlWyhP57WK0mbU/8m9EKIl3c4NbZT3yFfll4Pi3vo+gzWNszd1gubsZO51TGZmKKrP5XE3EUxLTIo7IAW80VZjFydoE5Tsr1qy3OIJlIeU9/NwX5CTBLEJsgQ==
X-Gm-Message-State: AOJu0YzKNLdXm8nLgXlA8s2LgAk4LLbJgQxM9atPrnPo+6FhyeHSwocf
	sx0Ozowdp7GnKN84AF4GphyqKAJ0Mwt4ZFEIx0eXaE2QAG+CVCaDRlagnmMriWg=
X-Google-Smtp-Source: AGHT+IGZ1SkhWtU0gb41eZu5IEQqbYguh+NOgE5PoWUUpwyGLYdBx5eJfbWLzGdFP86SyyFoRtOo6A==
X-Received: by 2002:a0d:e543:0:b0:602:ce22:7079 with SMTP id o64-20020a0de543000000b00602ce227079mr5017973ywe.41.1707745489730;
        Mon, 12 Feb 2024 05:44:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOLR+1zvsVgHS+WoSJiKbjFiuQ3Gx2h/YlCCxaJkN2YxbJbClx3n6yU+o7z5IkR4J2Eiw91jgYzY8l9B8XAj4CoLHrQ9mYVmYCNmohqSV1tdLfXA+a51T3is9MH18l+73Gpu7D71iHCw==
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id c128-20020a814e86000000b006047d63bc78sm1178465ywb.72.2024.02.12.05.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:44:49 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc742fc3b68so3590012276.2;
        Mon, 12 Feb 2024 05:44:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW133KchhwDlpEkynmey4riEIiqfHd7Tfp3nlZQKl3UtfxKMJkS743YoH2kOyIrQ6JnaJ60PKdrx/6Gngi9VXlbXa30JH5nQQbFuzUk1sG8KNwmLeOkwEesRclJmUVGf7wOl047wSgxug==
X-Received: by 2002:a25:b128:0:b0:dc2:4397:6ad3 with SMTP id
 g40-20020a25b128000000b00dc243976ad3mr5620552ybj.44.1707745489315; Mon, 12
 Feb 2024 05:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com>
 <20240129212350.33370-2-wsa+renesas@sang-engineering.com> <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>
 <ZcogWgtQ7hZ-5aj0@shikoro>
In-Reply-To: <ZcogWgtQ7hZ-5aj0@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 14:44:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAPN=DML7BOwRgLX1Z9NZmtCZY9ARZupKV9JELmb0rdg@mail.gmail.com>
Message-ID: <CAMuHMdXAPN=DML7BOwRgLX1Z9NZmtCZY9ARZupKV9JELmb0rdg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: dts: renesas: ulcb-kf: adapt 1.8V HDMI
 regulator to schematics
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Mon, Feb 12, 2024 at 2:42=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > -       hdmi_1v8: regulator-hdmi-1v8 {
> > > +       t1v8: regulator-t1v8 {
> >
> > "t1p8v"?
> > Or "reg_t1p8v", as the former is a rather short name, causing conflicts=
?
>
> Agreed, I'll take the latter and resend.

No need for that, I can fix it while applying...
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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

