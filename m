Return-Path: <linux-kernel+bounces-154880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFDD8AE267
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66792282135
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250B63099;
	Tue, 23 Apr 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuEZ9wEq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A34D527;
	Tue, 23 Apr 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868696; cv=none; b=GKx8vo7y/SBBjeF0in/6L+bgL3FjfpxO527obyAu+qUelhr0S8mvZ5or/u6amvxkB0N4bpJgv4X9uPyM4PWIeal3GhBGaRxHs8WvYYalHRDJ6K+iGjUHgbyobyw13WecxvHwox/6BMDkipRkmbT2s8Ss0csQbnPtsSanKqIRQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868696; c=relaxed/simple;
	bh=JAz7ER0hZGqzGBLVqaDpWG4vvxgxtMzsJmpoGWXMAhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imYInmZ5G+vwFS4uMF4ead17nuWsqcxdGE86see2QwFZOellDKROYNSXIXhoK6BVmhHe9I1nm5FQqAlC0ApyTbMZKfi6iYwY2pcl8hFfpA68ORHZ0fbOnJAvMJSrOLQUFX7r1KLZg5eU3fb/4gKOgmDEZa6kh1DYZ+ggMOZyjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuEZ9wEq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso899056166b.1;
        Tue, 23 Apr 2024 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713868693; x=1714473493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAz7ER0hZGqzGBLVqaDpWG4vvxgxtMzsJmpoGWXMAhw=;
        b=RuEZ9wEq+A9HATfJUD0us+R0R5ax70p1emmpSB4ss1kfEIptM00t4V2sy9YZwdasxq
         0sLPR42INh4usplkOPLgYyIZWgYHJMVvc6xuPATyhcjpc3emMkDIg4XXzcQZf7tdQU4J
         64il3H4LCYhNAkgvRGi3C/6sPFc/HQVoi0qYKOZ0CvqYAYPhiDnhjBhey2gUpQHETURd
         3jALrn9zM/0ELN8R8SAW3shXLdf92heD8CLSjPmUr73Xvu4yQKmWudrtzis/z7oeLQV5
         Jj1UyCKo0I37WTkzM7bz0oc955a/LFl79arsNljCee8wzBSzoM8NVWPFRODa/YCC18rm
         tODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868693; x=1714473493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAz7ER0hZGqzGBLVqaDpWG4vvxgxtMzsJmpoGWXMAhw=;
        b=sP3J/vjmLtifIuKXJue2hHbG4oHgC2ti2l0q+rxFOjkVFOMaNc4YeL/DM9Av68iiq7
         Ycpu63JpLzb4l7uIONS52S2BfmhF8oi9HfrL+BN1ktynLqEHShyw/7iFthiSfS1YaA9s
         YpPecYEgYnkuthFmu9+fePnlCeNZVVUjXAQAiuwukRBetiLIlG2tMXWQ3/+5mjfRYS/f
         IJZuTfU+B05riHoJ1CNCRy4KuRDYAhofh8NpdYVXB1yXEwUUV+RDwOIT6Q5CcIC7qpM2
         kNt6q/449KDus8mfkuUcaQ+JR2fGcQeHSaZ3Ep2O02DE96bluTS85la4/Pl++2sxmJdR
         8pZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZR+8ZcM9hBFazW4gBpup9PNh12UYcY1/Nct8OafxC9c2eoeVBJV+hI8iOBN2VRl+aT1AUrprIemW6e1SPRixLFpRpYCf8v8xB8kaB32OOxs4nu2NNoHVpdJM717OprolJ57AwmRXpRRD
X-Gm-Message-State: AOJu0YwvwZoOCcGt95uCFnTBl8tHkey3caRLV3i1JzU7OiVdu74UsjNC
	kkfkz71ZW1FBIksT+c02IGKmChCDFygBiEIM3vsO2YOfH6Wi664t+UiNiVoA8iFuELXdnakO/xW
	Qd3wJ61x/jBqCHfBbT5krpA+Q6Pc=
X-Google-Smtp-Source: AGHT+IFrqgWWS9JIN68LmtwbLNmr7fA1cTZcoVscVjnKA0fjeltVIh3nTSG2ZuJ6OcxPWQZdlmlFaaMh9qM/8rbpQAE=
X-Received: by 2002:a17:906:46cc:b0:a58:847d:4817 with SMTP id
 k12-20020a17090646cc00b00a58847d4817mr466084ejs.18.1713868693032; Tue, 23 Apr
 2024 03:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com> <CAMuHMdWBYnhVvDMditnf9bh17TeBhrZmuz--7x9QEejivCCyJg@mail.gmail.com>
In-Reply-To: <CAMuHMdWBYnhVvDMditnf9bh17TeBhrZmuz--7x9QEejivCCyJg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 23 Apr 2024 13:37:37 +0300
Message-ID: <CAHp75VcB0LH6pBHfJ4=N4s6Q_=pGhW6MHEHWkB7E+A5m758AnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 1:03=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Apr 23, 2024 at 12:01=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:

..

> Or just rename SERIAL_SC16IS7XX_CORE back to SERIAL_SC16IS7XX.

Since we do not know how many configurations elsewhere rely on this
and we have a real use case this suggestion seems plausible to me.

--=20
With Best Regards,
Andy Shevchenko

