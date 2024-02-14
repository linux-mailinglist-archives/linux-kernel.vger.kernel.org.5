Return-Path: <linux-kernel+bounces-65704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFD855099
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4101F228A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D58527F;
	Wed, 14 Feb 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Hil2HR"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9684FC9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932590; cv=none; b=R1UZw2Src7vS7v26z/71Qhr+1e1zd7XpSWlSpvumuJNrMKxAPt6QiigwKX0QqWsITG4P/Z+yx8VhsefINl6JNu5F9pJF6RZ9G/KT2vzWYt+g/qNTxMP2SIzHKoojh8lXNfkRdEu435FQWE7/pg9i2ob0J7G4KlklvMRTo/hhmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932590; c=relaxed/simple;
	bh=ox4KLy3IPuK35mXYc9E/pewt0RGezSJgULityeM994g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0B+ykXkYBfDjXcfj3iDKFx19Nbevdi76accxhPcByuHKl5Ge3dg6LMSrOzyT7edpbMChs/4hnqHxjwxJ56M5FxrCopgZfcTg19BhnF09J5AFM4cc0oc1sEWitZFjzVu/atpJmr0aGXMAr1xilb1bcIk2s/c16Lfa/yAM6kuQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Hil2HR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso3006738276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707932588; x=1708537388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox4KLy3IPuK35mXYc9E/pewt0RGezSJgULityeM994g=;
        b=U8Hil2HRrI+HkkCheCaMtpdczCK7IPeS1LMeDlxqIPp2xHO9bX6QWZbRK55srhqtUF
         i1JDYJHN8IKQD3ih473dtxeIq6i6u7CEb8NZUYamWOaU2KgegdH5whyY9ukfXRnN0bRi
         vAdDMhr6s6B3HVtdooM0wv6T7efbPyq3RWprcV6PWhCnGWR7JnHrM8sJtW/voZ1CtWBH
         2rIK4xVMxJXs20wJSLf7YfaeJ4373SRBQLt1oB0e7IS/3t2uVsiFD8MjTbdtUkAAoxQ9
         DmyGIiOMMMlAqtMuisnMXT51EkEAAF77iWPU1M3aI0eDRfppSd3JXU466f/vbTJ3Pkwa
         y+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932588; x=1708537388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox4KLy3IPuK35mXYc9E/pewt0RGezSJgULityeM994g=;
        b=SYdViLd/FOVYvi501Fc2irL0P/KbVBCQIp0wWkw3+aEC0Fv8hb7bEgPECHV+0CRJ4f
         SpHk/7HilPDMwnJkD3RXw2YeRFl5bS2TEfMliGyceUWSS+OD/VfSAY/CSKH7hd1H2k35
         suqah07pJ+ZgbYoSByyMgZwSxvJvai3T6DO06FJgladdi3dV3ycwamzsFlWOh4cZOScf
         Wj+5cJEPBvh5UKpR+5sgJkGKcVpcD3CGnOZnr75h/48tTr4LY9ak7IcDrJMTtVbjbwfm
         UjL1feZkYhfLms6piCWZDt1Skc9LefI9oJEX+ldYA45x3Uk9PV9AonYeSZXYsnmVh1H8
         ALHw==
X-Forwarded-Encrypted: i=1; AJvYcCVuE9nMwr+01NFIHWBzHqUV7nKIopTbtwxSj72feq0F9VOeWonTZUhXhew/TJjwIxNjMtJVZyfAA94yH40tM0G8AypCl335SzkL20A5
X-Gm-Message-State: AOJu0YxaNhCWCxvHLic8k9KN+EmNAo3YpK7AWNqHkmdV0+VDZj2zzfF3
	TQ0nFp3pYLsrWUgUtWyZJjJ7Z/2EuJwQcsV1Jlal9kMWdP0sas5eEvl1b7H9xmaaUF7EQLy1CNR
	iTSRPs8AsiJMb3YyNj/KXfgd1U/w=
X-Google-Smtp-Source: AGHT+IEALHFIQSOcyIS7mBLLhRFSe/OmDG6ZSCDquoFMnGZlKz1oyzdV08hCaQOpxi1xHxrHj8F6kJP4raEGhW6J5Dg=
X-Received: by 2002:a25:8051:0:b0:dcc:44d7:5c7f with SMTP id
 a17-20020a258051000000b00dcc44d75c7fmr2492401ybn.62.1707932587988; Wed, 14
 Feb 2024 09:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com> <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com> <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com>
In-Reply-To: <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Feb 2024 18:42:56 +0100
Message-ID: <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I don't want to rebase, esp. taking into account the proposal below.

Why do you not want to rebase?

The proposal is orthogonal in any case.

Cheers,
Miguel

