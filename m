Return-Path: <linux-kernel+bounces-95584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F0874FD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13F128359D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44312C7E4;
	Thu,  7 Mar 2024 13:20:01 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3284FD5;
	Thu,  7 Mar 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817601; cv=none; b=P7Df5xrvmytX2CA9hd/wD/4GkYieMRN/c9D+oQ+atwyRqXWo0yZKnIO8jcL/EZfM2ZLOFm52HmI3J4GHwGdQhjy3eW6QmnlgIyuJfsqGPjf1plqPubOx0KtOBJO+9zsk4YQgIcaqQjj9Vef7jZmBw8Kn7JrzANLQOwONytndDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817601; c=relaxed/simple;
	bh=XdyRbsIb6pG2jeGtOXK+SlTPRnhDtH1vytwJZq+aHgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekhNrObNZepMnuSw1LSo06lboi9AbwyFNvN0Ct+FrE1l2Q7NPqp/UCc8+wxCKsmqqUcygLM37hE+4WchAYKhChMvQwvX3ALiBCxW/vauN13BQMw//njshaWkLqGBen6hMa6OKmpmRNvWl2Qrz8/3c5jroKWtfsKizQn/lDMtG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6094a87c4a7so8554177b3.3;
        Thu, 07 Mar 2024 05:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817598; x=1710422398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qMsMQn9F0MZ0xZLxTSXRgknQ2DR10UkoNa/fQj/hno=;
        b=koh6pa5h2jWksdLJZdozqgPBV7EgBwxT5NSTyM5hIMqIK3XLwbGroRgXbJ1Oz5bVIW
         A4/MQVET/UtXvHBDHwWtJmRZBZxfih3qQG5zjkhEHnLF4Lo/ZMRTHs+9Osuw3gxaDmMs
         0Bux8y1j2pzkwfJaWfzXc3T/QkTiaQFL4s4n5+eZiGryIaLkPHj7+xers1yBR++jT9Ky
         wsLlVYguzt1i7K6SF1ajd47RB5QpliSatfIphbI7Fvco8rRA5UHru8bTEXmSL3vq3myD
         YwQvmjxtwLwWlJM8FlIeKExwWrLf3toUuzFIthheVZRuayd9kKVn5YG6PHxhXzjVhd2w
         MYtg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVX2iM4sqEZiH1PjFnYl2LW2qHH3VdnsXfjLz3/COOszYllOvBDXyqYLhWKj7Cl5pM8PnkWVtRsXtnCG6Xzmo5hUE0fnCOzOHosSB6qLl5TEdUhbhYK+IlQ1vYwW6f8z235P4Rg5O1oThzJ8sRqxss+EKYC+f3Q9/oTdCDffuEV+iH46ZPHdK9MRcmlojOdBrAziAkbxKdKwvqAfJnaXyn8onRdQVswMa
X-Gm-Message-State: AOJu0YyEfewKC6kLMlclL526WkqYyU1Gcgw+4HN9pONUuwcrU2ZixmLA
	G3StQ4uGf4FEPAnnpT01pDbCOImhavVOjywjaisAXSyNtuuYZtzsI7nxFUlrbyg=
X-Google-Smtp-Source: AGHT+IEMG0bt+c+X29KGNewoGCkSaXD9GOn7kZtzf0V38QWQr2nXcx4HN85e1KgBtBwxuUfrrjGZKg==
X-Received: by 2002:a81:4ac2:0:b0:607:850e:7583 with SMTP id x185-20020a814ac2000000b00607850e7583mr16757549ywa.38.1709817598487;
        Thu, 07 Mar 2024 05:19:58 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id s17-20020a819f11000000b006096e718ed2sm4045497ywn.103.2024.03.07.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:19:58 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6094a87c4a7so8553967b3.3;
        Thu, 07 Mar 2024 05:19:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSsiXc7POa7quMc0Vvp/ryn8dg+tenS9drFt074NVwlfbjjZrC6v1j4aIwj9ew8cw3fsSWmXxBLpnZy2WUhJ5PF9+/m+L3+CVx/FOwiqx44oN5hGnSSAiQD7CWHlunuvbL5BBggO6vmX0jR9/NIJcfLOCOtkyUg43vLQGA0KlyIw2yq5NTgCzqdWqaTEtIEWZ8ao/M7pGIxt0AThYWl98U3Gq/+6Eh735z
X-Received: by 2002:a0d:d645:0:b0:607:d285:4d7a with SMTP id
 y66-20020a0dd645000000b00607d2854d7amr17511039ywd.52.1709817597978; Thu, 07
 Mar 2024 05:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 14:19:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSYzU6E0cBPmqR+RBk-WFEWQBkyj9KjePJZq-EXJ62og@mail.gmail.com>
Message-ID: <CAMuHMdVSYzU6E0cBPmqR+RBk-WFEWQBkyj9KjePJZq-EXJ62og@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:43=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This commit adds support to validate the 'interrupts' and 'interrupt-name=
s'
> properties for every supported SoC. This ensures proper handling and
> configuration of interrupt-related properties across supported platforms.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Defined the properties in top-level block instead of moving into
>   if/else block for each SoC.
> * Used Gen specific callback strings instead of each SoC variant

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

