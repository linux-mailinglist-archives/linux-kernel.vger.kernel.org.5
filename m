Return-Path: <linux-kernel+bounces-63128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A139D852B45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B3C1F23B19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BB1E4B7;
	Tue, 13 Feb 2024 08:34:41 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FB1C68E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813281; cv=none; b=dQr/4WBWvZREwwc/yE+J5HoQCSLPEFlDNSrGbf/t3FuUy54qQgjjm04hp+Cz3H0UAWIKwxRbYScWKU5l6IOR3GJKDLwoL56KNL4PKszRgvw3+S/wUx/BBaRCXeV2WXUXWrmC+WCnj9RVOpbdIMxn0jwJDSu63UFGTuEULIcc2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813281; c=relaxed/simple;
	bh=HqPYQ+zsjcZOWRBBytHB8HWtSgCBpznpAaCHBm+Cb54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnbSEoszCrqA2ilfntOiPL1DW2tspHxLRjh1QAXNSAsVRiRgUEHZ6c5Gau2HDkrgzV5Oq796FyEUFnrG2EKhMRDx6IYFc230HMOChgHKobL829tXqYezKbQ9RJpeV9DU40P7GlJ448qdxlVkWS3YMSa69UyWoDovj7H7N/4SLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60777552d72so10552707b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813277; x=1708418077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oszfPiwftmlqbkX1OEMlJrKegtX/lCyCD6csLVGg3Lw=;
        b=imK/reHDI4m7BqwEezuPxN3v8T4cPbbt+6/J0GLG0vndjuw0HXbLNcj6+JEbys/lpa
         uZ2u/tIXPHcGY1y/sdg90PupZuUPERQw3FQH2CYtTg0JEu6pEegjy3Ki/Ol4gH00JmQE
         SetLA9ki9+euKW+B4BXACSDa/gUx1w0OqAGpWBpEuE/l4aHN8hdBG48p4RWHl+yUFGef
         3WLXy56w/EmtjVp9OQodHWcdR4PUFdQm5m4zvGih3VdwZ+GByKWSa10HefztXABdpKQi
         pDB35UD5NBHLAfLSYM8FoC86QbEMDfkpMfgRXRiyvVXnmr4JSpSRc/KSo3icHgwe2OLg
         lzdg==
X-Gm-Message-State: AOJu0YyC9MHFUBE6Ugf78eS76Fl1fh2CR3RqKQCnGhrn/9jDI5tf6VPJ
	Aw0n88s3w8EB6jZMmnIDxnbNv3FoJUC15elb1vzSg4wcaYyRpKlv9DeP/CvSgLM=
X-Google-Smtp-Source: AGHT+IGFuxPlg0xDeq6E2Z2tJZdQBYsou36MDzCLARNgIXvzLUee5O32MQcdmJAdHStkniq6n2DV+w==
X-Received: by 2002:a81:4985:0:b0:607:78b8:2a57 with SMTP id w127-20020a814985000000b0060778b82a57mr2397018ywa.24.1707813277492;
        Tue, 13 Feb 2024 00:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzw07au0yXAlnZPobg93Y81HmEmSNoYfIkI/oxBpCl4ehH+542t8OXTOlgiVm2ydJtOPHAcSPCewRZJd58nsLL/Jybek61T5x8q1sg
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h124-20020a816c82000000b00604ad97f2d9sm1663567ywc.110.2024.02.13.00.34.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:34:37 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3715182276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:34:37 -0800 (PST)
X-Received: by 2002:a05:6902:228e:b0:dc7:32ae:f0a with SMTP id
 dn14-20020a056902228e00b00dc732ae0f0amr9167396ybb.65.1707813277028; Tue, 13
 Feb 2024 00:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de> <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
 <17040808-89ca-41f9-a584-789f000c8e0a@suse.de>
In-Reply-To: <17040808-89ca-41f9-a584-789f000c8e0a@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Feb 2024 09:34:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3GCocE3+k-6o7j76wVxvAqjM_N+PSgOyRUAK2bQdYPQ@mail.gmail.com>
Message-ID: <CAMuHMdV3GCocE3+k-6o7j76wVxvAqjM_N+PSgOyRUAK2bQdYPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Feb 13, 2024 at 9:28=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
de> wrote:
> Am 12.02.24 um 17:42 schrieb Andy Shevchenko:
> > On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
> >> (cc'ing Javier Martinez Canillas)
> >> Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
> >>> I have no time for this, but since it looks like I'm the main
> >>> contributor for the last few years to the subsystem, I'll take
> >>> it for now. Geert agreed to help me with as a designated reviwer.
> >>> Let's see how it will go...
> >> A few days ago, I talked to Javier about how auxdisplay is a hotchpodg=
e of
> >> various drivers that seem to belong into other subsystems. Could we at=
tempt
> >> to move all drivers into other places and then remove the auxdisplay
> >> subsystem?
> > Can you be more precise on how it can be done? We have at least two clu=
sters of
> > the displays: line-display and HD44780-based ones. Moreover, the latter=
 might
> > use the former in the future (in some cases).
>
> I see. Taking a closer look, it's not as simple as I implied.
>
> We noticed that cfag1286bfb and ht16k33 are fbdev-based drivers. They
> seem to belong into video/fbdev. But OTOH ht16k33 appears to drive
> 14-segment displays and fbdev appears to be an odd choice for such
> devices. And as Javier already noted, we wondered if these charlcd
> displays aren't just a special case of TTYs.

HT16K33 uses line-display for 7/14-segment displays, and fbdev
for dot-matrix displays. And input for the optional keypad.

I started working on splitting the functionality, at least
CONFIG_*-wise, so you can still build it for line-display with
CONFIG_FB=3Dn, but I was distracted by more important work...

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

