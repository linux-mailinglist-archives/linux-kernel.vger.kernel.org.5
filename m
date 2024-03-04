Return-Path: <linux-kernel+bounces-90365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063CA86FE30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10701F2166D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023E224F1;
	Mon,  4 Mar 2024 09:57:37 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458518EAD;
	Mon,  4 Mar 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546257; cv=none; b=KD+jNf3Isdz0dum5qF0W9QqzI8sXwXDbnUgd6eJldTp3gUjvYtplIC4Pah7ySOvQi6OmDtSM+aESBH7nUDtGpc5J8cdNvto71bSmdz4XQnMGk8MhWaFl1gqbknS1Jzc3k/Q1RWFR5/STINRiTyYYz6jlELFeUCmkwF8b2brMXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546257; c=relaxed/simple;
	bh=VQUbdknHO6RkXDQ0UrVgddhCbWDC7HI+5GWyQhFlF4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcVmLT0InOA2eAO6QTr2tO3SlUGapZfqAzB/wOLOWleK0Erc3frkj2L6g55O9m2DUleWgzNAZm/5NpToxPjNRykyOBIZwZnhq2gJnN/tQZonIz8DtY3nmbkx7lTCFM6ziF5eVXr3X8uhq0OGSdF+hnqQepUyNZhrEjI7omGZfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609acac53d0so6095337b3.1;
        Mon, 04 Mar 2024 01:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546253; x=1710151053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEjmMieOpm8/C+3ZzaHx+WpaiZP/Z9Je007UZUtRBSI=;
        b=TinfLoicUEwE0zzS4HIQqB9PJBtpcteMNZ3gNKOhSkzhgPiZTxzOLKiyfqqq6sF1pW
         8NpDq2ygrdgE64k6J+hGRlH/FX3hNw6m7+lwSLTm2tVQHouJ+zQdBttdPFX+n0W+4ow6
         Y2TjhUSGhoJdV4WR7FHJHWEVSZcWGq0JUM2y3QmpED1HH+fGJqv5a3s2vpXohFwkPxFh
         QTVzW5l8aRF6BLh6PfgaI0y9bE5kIdxsTJTuk9fYl/hEONs8h2TlP7u6e8Wrxsa6LlgF
         GN50t3tEvwCTmm43xcI2MmfCNrzi39wP2FRxqa8MGuHSsmDFdX+MWL8X6yXkhZ4rsyf5
         KOFA==
X-Forwarded-Encrypted: i=1; AJvYcCUnKEf9zAPeODraa7bF1iInSMwhuD6io/SSIehge6nmnZ0GDVyAwwPK6Mv1EDEyyTvNcpgDlK1vP3SIdlhultaIyYGWUUMuC6rB6dey9l6ddb8lC1CQsr04xL2Eud1gkmuHxXYi96C0bQb0VxwzyYyEcBegzo99LNyZ2S7ppsVAOpfua0I=
X-Gm-Message-State: AOJu0YxLfQDYxtjeuTn2MqNS1/SAgLQE6L019eG3u2SGqVbtBJFIW2Ty
	wRfL7iyzba2fCtPk6h6wg15GEvZdz/SEHiNZ3Smkco3025Jwtw/RxkX4V/la8Ss=
X-Google-Smtp-Source: AGHT+IE0fQgo/0LEf3P6bzQWQDRjzR5S0ydJWD4k49e/n42lvR+uJ8e4QB+MimBcyNvIxhBstp4KcQ==
X-Received: by 2002:a81:5f09:0:b0:609:7f97:de2f with SMTP id t9-20020a815f09000000b006097f97de2fmr10014079ywb.36.1709546252983;
        Mon, 04 Mar 2024 01:57:32 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r7-20020a814407000000b00609498508acsm2538495ywa.42.2024.03.04.01.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:57:32 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60978479651so37263977b3.3;
        Mon, 04 Mar 2024 01:57:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwI0PTQ7P+EDolcnAfo0oRBfL4PKbChEX1q9VcYjGTB4csDzY0lfnyvPsZf+n0ZEcPsETG440gGLidSyysuNjTjG/J/MJWZ0ZDZT33S3xeed7LZTZ4K0QtmDICarct1Jyh17NFMDiuZju7nMve4knkxy+ZKJgPATWCS4yTyL6TfLRYoVU=
X-Received: by 2002:a0d:d6c2:0:b0:609:8710:570d with SMTP id
 y185-20020a0dd6c2000000b006098710570dmr8364187ywd.12.1709546252552; Mon, 04
 Mar 2024 01:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com> <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
 <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com>
In-Reply-To: <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Mar 2024 10:57:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com>
Message-ID: <CAMuHMdXjqVQeQF6TFr1nQmUCLrEbY1gq5OdCcz6T60W33QO2-Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Mar 3, 2024 at 9:43=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Mar 3, 2024 at 11:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Fri, Mar 1, 2024 at 7:24=E2=80=AFPM Andy Shevchenko <andy@kernel.org=
> wrote:
> > > The problem here as I see it is the future decision on how DP should
> > > behave like.  If you put this into DT, we will to support this to the=
 end
> > > of the platform.
> >
> > As there exist 7-seg displays (and wirings) with and without DP,
> > the 7-seg driver and DT bindings should handle both cases.  How to
> > wire/use the DP LED is up to the hardware designer / DTS writer.
>
> Right. But my personal statistics for now is: 100% has DP (out of
> about a dozen of different chip + LED combinations). What's yours?

It's indeed hard to find contemporary 7-segment LED assemblies that
lack the DP.  But they do exist[1].  There's also no guarantee that the
DP is wired.
And don't forget custom or home-built assemblies using discrete LEDs,
especially for huge displays (e.g. using one LED-strip per segment).
So IMHO it would be a bad idea to make the DP mandatory.

[1] https://www.alibaba.com/product-detail/CC-CA-188-led-display-0_60626228=
913.html

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

