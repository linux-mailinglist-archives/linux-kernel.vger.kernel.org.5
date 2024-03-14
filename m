Return-Path: <linux-kernel+bounces-103543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44687C0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F3A1C221A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0417350F;
	Thu, 14 Mar 2024 16:02:05 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453407318B;
	Thu, 14 Mar 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432124; cv=none; b=G1ZG52jIMyaA8Z1GluICcfnhBwbegH/CCM6NcHxostwvTj3MnWsu1tonqualhLHlJhiKEx22lSQggjLhyq1NfVEQWWOumd4AyGnZFT52KgPfbo6+j0bqnwyHbmestVTt3uW/H/M8LtgFlz/UUdXON0Yzzf9ONJ5vfT4dtSsI3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432124; c=relaxed/simple;
	bh=DUIYZnXu2Mm1Kg/9XSVb0v3QJ3MxwDKn84xBc5L/Yi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3m5TtYLE1FYtKeNJ84iURXIe2FdIKRmdTSa3+H30fq0gBZG7jyKiBPADeYhVd6NHP9jpyJnLBm920LwV1dq3YJXNu1RLRrOlZLPvFU9o/JEaVaYzr9+bCZPfELp1pxntZ5PzhllFFPwFt1QVwVyNLhQ14v3ymlaksO2vNeRdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0599f631so10303757b3.2;
        Thu, 14 Mar 2024 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432122; x=1711036922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEs5JyZeiqBb9NRnkfaUIumwSMHIf4KhfQ6tZfz8uxU=;
        b=Sb/rHzGHdDYgcy3oA0wY8PhyMKcaTxc/RPClcYRHI4CL+5QSlBJBofYgfXQ0G349/+
         MWA93a7vV41g8hICCgEsE9cRy83bv4PK0LdlKIHbeN7cY1bjP976aV4Bx/26H0bEE7Gl
         0UOGlCS+/xwJ/PkQoIACe3SfmXncjuqCXtxMg8GTD6DB0YA4lrA4gt/8zxa0GEfxqpOO
         qxfKYfYSKLp320I8dptzhMjWwc1Vl9xUmpyyQZsLIG7V/BbhQgud2U4WCpWmF8z9EheR
         90GXViJTuttvxmw6cTQZ+9sG91R3DrU5jfMADjIe11+ZaFBweVjJBgCMRzwv908jxclw
         uHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmZT8xI1pXFhvbaya3THvl326EkgX75DKGgi6KAoiXaO7VRWHsMDL8cro/NDKZ+Baqnt5c/Kz1eQagsgMyoBizpmXw0k2df4WBsdpFZbfAokZt/JW6A3O27QiFIk1F2NjLMJXKM6XC+CCcHPRua8/m4LoIrIEJ+sM/CZElhk9Ol8OvB/ftiZvaH8jQ/lT+kKIVYoSDBckOQQDMHn9jhGf2PgizIJnt
X-Gm-Message-State: AOJu0Yyvr4FWj7s5VREpVavAJMQCOX+P3LItOpRu+Fb4MyX0wjYC9VKv
	Ua+TPXXHq6dEPTKDD/z4/Rj0ZyUuEZDE4l6qefwrKxyCUXWtdL2QMlTk/G0PE4s=
X-Google-Smtp-Source: AGHT+IEDJa5R53bNJM0PaQ/08L6F322KWapRE0i6uJPJ9wYMHPBahqm3XcV2sQSpNFqHGwHkQ2uU1w==
X-Received: by 2002:a81:918a:0:b0:609:6994:15f4 with SMTP id i132-20020a81918a000000b00609699415f4mr2170277ywg.6.1710432121680;
        Thu, 14 Mar 2024 09:02:01 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id ej7-20020a05690c2a4700b0060a00700c81sm320019ywb.10.2024.03.14.09.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:02:01 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1019660276.3;
        Thu, 14 Mar 2024 09:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6T9/Pisff0Zsj8/ubUdHKWZwrqmvU3N4dCEGhRa39qzdG0Q0vPZj+7tNSL1z6IZstg4UvlbW+Odxz5js0iRizAKrau2FE4MNv7QweKm+zNL7YkXTBAfcI3SBSzXdYBp8odwTL0/fSWxph39InFYsIGIqnt0bGcZPzWFxNpp9Y5mqPp6fFofMk2XGnFsJS+c2HkOCKeX/LFKo/4MVPPfEG2NzdF5zO
X-Received: by 2002:a25:83cd:0:b0:dc7:6f13:61d1 with SMTP id
 v13-20020a2583cd000000b00dc76f1361d1mr2117885ybm.20.1710432121235; Thu, 14
 Mar 2024 09:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-11-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 17:01:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWd45zJyU5QoTENbBexRBZ4A-S9X8MJ1n+eSPn=gkYZJA@mail.gmail.com>
Message-ID: <CAMuHMdWd45zJyU5QoTENbBexRBZ4A-S9X8MJ1n+eSPn=gkYZJA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part of=
 the
> IP specific power domain as the driver has been modified to support
> multiple power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used proper domain ID for IA55 interrupt controller

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

