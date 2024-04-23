Return-Path: <linux-kernel+bounces-155471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2698AEAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D0283F04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04F13C3C7;
	Tue, 23 Apr 2024 15:26:38 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4307F499;
	Tue, 23 Apr 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885997; cv=none; b=ji2ec1nfBsV0IGBjho9YZEDUI07vXpYiAQ623jfiRLC2+lYbh1BIihpst/pUIqsUuxiNGCEYXqCxl7hdCwDgudSHxys6AluSgZ4vssx6Qp85sd4I2kifyz63suIhnygu98Pvovwok+0Ai5g8cTIzLCW9xlFbD1R2Xe4kly9wnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885997; c=relaxed/simple;
	bh=uCo81c7NqpaHrtM3w4M25GPfHs/o0/4Pdo36zQIn/VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVFEqpap9fzQucB9sWjDQX1VqdhSJis0cEDX/CNiN1up+j4SJPV8qeEI5cmblnXJZJUjbV0nXVo8zs4QpSKBNuxQ9KG6yfvWt+jsDns0gf0UmA/nTom9DldNAPsQ3tTOJWg30byYElQ6kvqt00xawMDebRenkoSPyxbSf66X8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617d411a6b3so49327177b3.3;
        Tue, 23 Apr 2024 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885994; x=1714490794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YimF/eZqmWZ6uuj34sVeSUCGbUx5gv9fJoo5+qsG1kA=;
        b=GMC7NO/vKhU+cPmk1vydrhaggp+DuvJFEg0RX/e5ZW+VuqX7vxgwu0xk0+e1mzVgre
         5bXYAdEXkcuh4b2lt1HvMo9KNlUGmTVhArOuVF0ApEbNdewtY3pP0/hpvUKdvzPKEe9Q
         pjpN1FaZVv4BtW7w++CkMp7U/hkx582lKz9sefGnjHuiBsQZedwC76oDbjXRook5NKga
         jVLIwuh28dMJoZSEZq9yrXNLGtkkQnMu3FFd7OWKFH0ve2eotu8ZqU/IvKbL/KagKer4
         1ab135KvyNqlDCvJxQZAWvRRQMSqYlXkwCAnP09/0B/Ez2Jv03o5Z4toeoCEYIIbRWGT
         uNsw==
X-Forwarded-Encrypted: i=1; AJvYcCUW0sS7W9pOJaNC/nasMhsFlQyAuTCwL9UP7wpVUr8Ss/TsWfHR/uXF5+Kd8tgz6WF09w6s0IzK49qe3iiLlLCQ0xXPGaw5gYGqNDZpJCOjqRLlkCkcZe11jNT32kPbwsZiiAnHY24009KJP8gZUhlsQusLo7fl5KLVqbLq4MeMIThU
X-Gm-Message-State: AOJu0YxvEomC0KuksXzLRSwrh0dTDELkfQBitF3vzQCT9grbkfb6DrXP
	XcmwEwL5AsSIZwcCGBt0CAPb7gnlm5Tv+ySZ9joZEtdc0hGWJ9cLJN8ymU2d
X-Google-Smtp-Source: AGHT+IET83aFdE/rsR2KXzMcOfZfrdXtPsVKsRvambMMFVCBumNYd6mvmTe7ch4rSe8mrVHFhV4M0g==
X-Received: by 2002:a05:690c:6e02:b0:61a:cf94:97a6 with SMTP id jb2-20020a05690c6e0200b0061acf9497a6mr16278436ywb.8.1713885994400;
        Tue, 23 Apr 2024 08:26:34 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id w2-20020a814902000000b0061ac30230bfsm2534794ywa.49.2024.04.23.08.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:26:34 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de46b113a5dso5422101276.3;
        Tue, 23 Apr 2024 08:26:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqgl9b2gzY8V6kZgmuk9Qgyd4qjxJ5vVpE6NydtUvZE38BroryNhYS1JPCzto5yPGeLLPLpR5LUHrHAZxPovupnES634fJ2/qUDxNajGY49ur/j20EyGmB752ACP/iU+3W40LWipQ3AOR69Dq3EpjRE9e4mQDER7Z7qIMq60kYCXjm
X-Received: by 2002:a25:800a:0:b0:de5:64b9:1021 with SMTP id
 m10-20020a25800a000000b00de564b91021mr372901ybk.24.1713885994055; Tue, 23 Apr
 2024 08:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com> <871q6wrw12.fsf@intel.com>
In-Reply-To: <871q6wrw12.fsf@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 17:26:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGiXYtRCof=JTBa=EwVEaoNCkUkwtq_ZEGkYdG9QKp6Q@mail.gmail.com>
Message-ID: <CAMuHMdXGiXYtRCof=JTBa=EwVEaoNCkUkwtq_ZEGkYdG9QKp6Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
To: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani,

On Tue, Apr 23, 2024 at 4:31=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
> On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> =
wrote:
> > The recommendation is based on the following rationale:
> >
> > - it makes the commit messages much cleaner and easy to read, especiall=
y
> >   on the screens of the mobile devices;
> >
> > - it reduces resources (memory, time, energy) to retrieve all these
> >   headers, which are barely needed by a mere user, as for automation
> >   they will be still available via mail archives, such as
> >   https://lore.kernel.org, assuming the Link: or Message-ID tag is
> >   provided.
>
> I find the information in the commit message useful, and it tells me who
> were explicitly included in the discussion.

Contrary to popular belief, it does not tell you who was explicitly
included in the discussion.  Git history has lots of commits that
state I was CCed on a patch, while I had no active participation in
the discussion, or even any interest in the patch in the first place
(scripts/get_mainter.pl considered harmful).

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

