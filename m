Return-Path: <linux-kernel+bounces-148730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316798A86B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3886B22CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD2142648;
	Wed, 17 Apr 2024 14:52:13 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2138DD3;
	Wed, 17 Apr 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365533; cv=none; b=MqWFWpqoWXgdrz3hgikboExCjo1Ry3aY8PC4UHMVckuL17hsxiBElj3rIMV9k3AXQ8znqsXCOB8Svu3kXYANTR6UfnmjQOO1EIEXLsbSUBS0fS/CBYsfPjLlWglpAnZW3oFhaxVnF+zp7xSP8Qczb/8irSRaGZUNlT5dCXB6Nho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365533; c=relaxed/simple;
	bh=ns7K8uQ8uC8NFTMTiEiwqxwnLZ/spdSlLaZ/lCi4ruA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tn2pyCeG0pZV4WiZaYOGIqspCkNFVw7I76K9HV+xCFrlgTPUCOhf9K2qE/YyG4YUddJOFmxOmsGkwLuMznTBvsEDuyL55u9qjHj/rASonRuau8vLOzWFhCT0IuFfUZ9jszcKIgGjvzjkAWyWS3isGKWlfhlEoztxHZIZOMwmUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc742543119so5044612276.0;
        Wed, 17 Apr 2024 07:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365531; x=1713970331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4rFLFMP7uhBZnwM9rYpM+VdFgfW6XVyJZ9NVk6uI1k=;
        b=gCESApHYwXkc8EFXFgu0SZG/WB6Siy+pjee8Lw8u6IKoqT8yuO4Jh98eo4qVpvDVZ+
         TeVyqFbj8ZZS4NldTE3cvJ47L36EQgXDrJedpE9AvGd+lLEZeEl1FpRA/0R2qI3ITHK+
         Mn8rfW7ih3u5Fwf94XoivE0dbxVJ0eSShEPqJmwyughOpP8EnGdmF+wUZEwC0MoPpCKt
         11R2mXcW8Iz4OvyCJps4AXunzurmh5mG5ri3dIeBjfMtP1gAB5ahmrMZ3kqUi671LugK
         Pbyiaai6dk+77R++lcFURk8PpRw6rSb+ivhYe/uSsiW2c+avRFrqLf8ZVsyp9iq35Wmx
         5obQ==
X-Forwarded-Encrypted: i=1; AJvYcCVobZJ2JrM88zzwm3J/kAC8P/NFZHc5Dgc2iGafNQEbjyjPz1qXrtM1JbQQKjDe6YVchnEP9Gf8hTqMV+gsmqk06Cy4nyV/Y3u1G5avtFrukjmmS13k1owKVh0/4ybBdz0QwIHs9qE6GrnrgvDS44snDbPWAeBzPTmWTeple67fzJvLc5C8narzJ26F/JRnXUuX54/eSviBFNqtuWHo4ZrE1BFBRg0m0jLn
X-Gm-Message-State: AOJu0Yx9l5Ucy3bg9WfoeJeZzIDZfUZdV7bWq3MMO5ecS1w99/tk+7zr
	1lL/twqzT2F4VtzoeYqwAUUzHK8qoScFXNnI9Zq1arT+Sh7VgeyI0VxCA0NLt4U=
X-Google-Smtp-Source: AGHT+IFKKi9klGLYTQg9HEkjQKa/7JPlPlA9FAXgS1pP4VDcZe62kmmi0QczEMVM877cxX6ucFYZZQ==
X-Received: by 2002:a0d:d60d:0:b0:61a:c19f:fc4c with SMTP id y13-20020a0dd60d000000b0061ac19ffc4cmr8882978ywd.3.1713365530719;
        Wed, 17 Apr 2024 07:52:10 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id m124-20020a817182000000b00611213d62adsm2989372ywc.124.2024.04.17.07.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:52:10 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61816fc256dso50555137b3.0;
        Wed, 17 Apr 2024 07:52:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqK/8V4XZ47dviTvvk64ftnO35leWjYc3bJuzQUS5y+QLxoPd86u+w/mZjywTqx07rJXAMcBXCDiBi8CiEGpxjt+0GYocneiw8vEq42cmSrfb1vcULeFuDmI/MXa1PAjqcEd5hDf4R2OYsFw67/llFG1dCpTbQNxQRgmP5zJA2t6qUVOQbIJzRFYkN09nYgWKDKJx8+ZCOm8JMg/FnBA3Kdc5CIfAa0HlB
X-Received: by 2002:a81:4ec7:0:b0:615:21e7:6bf6 with SMTP id
 c190-20020a814ec7000000b0061521e76bf6mr14888644ywb.14.1713365530376; Wed, 17
 Apr 2024 07:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240322144355.878930-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240322144355.878930-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 16:51:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaCAkQ3BdjR-iUookW2o5jd3KHc_AC5MHxLKaYZTikpw@mail.gmail.com>
Message-ID: <CAMuHMdXaCAkQ3BdjR-iUookW2o5jd3KHc_AC5MHxLKaYZTikpw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: serial: renesas,scif: Make
 'interrupt-names' property as required
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:45=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> As all the SoCs having multiple interrupts have 'interrupt-names' propert=
y
> in their respective DTSIs, make 'interrupt-names' property as required
> so that we can validate them using dtbs_check.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4
> - New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Note, we need patch [0] to be applied or else we might see
> dtbs_check warning.
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240318=
174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

That is commit 7db74b65a93bac5a ("ARM: dts: renesas: r7s72100:
Add interrupt-names to SCIF nodes") in renesas-dts-for-v6.10
(next-20240327 and later).

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

