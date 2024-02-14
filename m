Return-Path: <linux-kernel+bounces-65831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B8855299
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17931F2D00A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F221384A0;
	Wed, 14 Feb 2024 18:48:27 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA175C605
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936507; cv=none; b=DZfN2hBONpoYvDsIEH6S13pHdS+HdTOMdyQUNssetqE0shSASAqVEa33JQIGvpxwIal+UGJPhQYIBlCf7+2ANDEuDpZw1EjisreOH+NIg1JozcL4+n3Uz3zn5y/eZsp2vQ4IN2cZqXd3B2mDUo441t8BsxrfTa+Q4HKt5RSeJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936507; c=relaxed/simple;
	bh=ffzC+GT1XkMW9JLINw9Rvta5c4VPLZnJJBasvRXjLBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfYsZPe61FWaMpU8yW4Z4g6TSweawW9wy+v+jIyyr59dCMNwSyf6LHqrLIhiRGgsm0Cjz98f8x2SmgGDPJ1HysEETSgYJyAiWLjXsSI1zpupIU+zTAs0Q+g8Y5lgenQBHR7Br0YzOY12EUzFDeoro0sYJz0MmTydjvSwfXwDMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60779014458so941587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936503; x=1708541303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQAt50T9c7g+J3x/tLQdiBHqHkoy0RbrOV9gm6BoB4s=;
        b=vkHy5SgAqvUC1pdthMW8ZBsAQcBqvg3rE1UI8udSu/brcJ8C54bDiI2REuDJZIPgvx
         E4Gt+vF1MNn9lq11No/yuhDKY/G6zuUZliDRu8ISzPYqYVzu1hjx37JupAz3X5LQUoBx
         8UiyyUBGeE6aVHPSTxwVJmPLQZT6W9Hqt6ZybW9svN4VGnVAM4WIVzKKMO/lIOxIECgm
         u3kKpLOZbX7YiXho885D0U5zrfjrMHzquhW/DaZjXZzDCznRjNZ3RuITtuvvDYyeSJQc
         Zi26Tm3o9gkf48kVzaVnrK9I2pzKowtSL3Bc3igznxolLn7t2/80njziR8YZaEzNjzee
         EwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDyafx/0nJrmaP1NQah/Ro1aZPaE6leN1WZL4lJTfn9T/kxgvy7BaDBzoIqRYjymFdK6mmkHL3q1LDEOWD8g/qTIfSk+SJv5pdbBxX
X-Gm-Message-State: AOJu0YwnNCLpYRIa+COEheVOm4pWbDb6ZYm4q4okVTkTj8gQ2iUyzXLx
	XLh57ijCOToJPsS/ZzCjXcVVHPHeAIcjaFtf2JJq4vjVHO0mOyopEl8R5DSdmYA=
X-Google-Smtp-Source: AGHT+IHWG/ONlwbUxbxNLJn5JiOaDLDU1AggFfiVCiwK2UB9LlquhxgO7a+c48UPXU2lvlaEEakxLA==
X-Received: by 2002:a0d:d788:0:b0:607:7c26:7e14 with SMTP id z130-20020a0dd788000000b006077c267e14mr3718749ywd.34.1707936503402;
        Wed, 14 Feb 2024 10:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWZpjMVvXLMReIogMY5LDWruONNDlqOh5DgK7JFBoRLW8lWbYFW/IWtb6xZc7h+4NtsgxTPo0Sw6Oy3DoDQFfzQoQ4wor921j3a64+
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k82-20020a816f55000000b006046bd562a5sm2304911ywc.128.2024.02.14.10.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:48:23 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4342047276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHhxvuUL3qDhWhbdcbOt36ngyZMf+ganibESG09JvC/2PK6mp5Z/as8rF9JUaYhw/R4MbiXRPrBI3ok5m+SSiseMaWn8aDQaGwEyzF
X-Received: by 2002:a25:d3ca:0:b0:dc7:43fe:e124 with SMTP id
 e193-20020a25d3ca000000b00dc743fee124mr3440358ybf.11.1707936502887; Wed, 14
 Feb 2024 10:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com> <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
 <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com> <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
 <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
In-Reply-To: <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 19:48:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpf_cuGaoE_9y5wf7yS_XbgcstcgJM8NAgRpCHirr4_A@mail.gmail.com>
Message-ID: <CAMuHMdVpf_cuGaoE_9y5wf7yS_XbgcstcgJM8NAgRpCHirr4_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Feb 14, 2024 at 6:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Feb 14, 2024 at 06:42:56PM +0100, Miguel Ojeda wrote:
> > On Wed, Feb 14, 2024 at 6:40=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > I don't want to rebase, esp. taking into account the proposal below.
> >
> > Why do you not want to rebase?
>
> It's a standard practice in the Linux kernel development.
> If it's not a so critical issue, why should we rebase?
>
> rebasing will break SHA sums and it's not appreciated especially at the l=
ate
> rcX weeks. Linus can even refuse to accept a PR based on this fact.

Come on, we're only at rc4.
Given the (lack of a) gazillion of auxdisplay users, I doubt anyone is
basing a tree to be pulled in some other subsystem on your auxdisplay
tree.

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

