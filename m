Return-Path: <linux-kernel+bounces-135047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5589BA5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10D128991A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8F38F99;
	Mon,  8 Apr 2024 08:33:07 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFD2E651;
	Mon,  8 Apr 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565187; cv=none; b=rjpLrMWQBzPMPK0BDfsvo2m/Nlg7i8OJPu6lTzvWktQfkwOF1E4//1OWEJt9/ypAlxxdrcMoSHCPgGnotffK7W4xlBWSQi8IE5Nsrhk1xJ3rXLn7Szk/Fhd9g58akyhm2kshvW/YMygrd4QeyqZOWLjB6QkAAPF2dpHBGpa0mjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565187; c=relaxed/simple;
	bh=qsWHvJLZoBirAJa2z/xDxSXcE2fWSyxa1yYwt5wP1MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTk9oHIRJaU0wXDz+FjQ3fZHxiQGZYXzdhbZ3qrQbtqPOJe39UYDmrcWMdNicB3kLbcYgi3h6P4CWjF4RHnEIb1YKeQSHK7E2+TG0BD6Ka9IEOx3/aCQWv3Fw2cj8MWPPdceAi21hVH8hd/oImRg5aLUmv3jwl6zLL44+JTJfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-615053a5252so36839257b3.1;
        Mon, 08 Apr 2024 01:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565183; x=1713169983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bnKadFFQKfZtqlQN85uKX1QN2funm0jGKmok0O/bf4=;
        b=dUzdt4MhnR1IljF9xG74P9+YDENL21c4zX2MWtmZ22M0C7WxTJoMS0aMlxbQDCXsR/
         GA1hEF9Yjf9+iCq4lJt02tK6orYoDsHCoxJ9ICoUsYBTfjqEEr8BKEpgvnbQgP39ECny
         m0rch22TFYSUwsm6iAzCQao5F0sD4yJD/z1Pz+j/VEbL4om5d++vNcrFdkNoBQCpSkv9
         H+gzki7CQjR/sP7faTW+a94EVLp2KtOx/MaMG9xNA5Cgszisri/SIXbId4sbWP6fiYLv
         7l1qqjcp2a4FQveqVKvXz4i2qREhMAiX3bSvIAsJ4sTgdL/NDg8Ec8vdisDA7m3C8SdV
         12VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ShezvXw54tEd5q08XQAqHiFD7uk1WYafhT4wt20rCbVk9irWoN9fR9T1o5AOjRxo0J3qYL9FtR1azWHUIPtrJBrocD7EzvPVH6CVd+x1bNkDL4EgpKCGn7u2pFo82EtfdpDJx/RfNUQ6
X-Gm-Message-State: AOJu0Yy6A0UZQP2rURdPytT4ludfTXwyfjA2jQij49BaOV/qvKoxJzvL
	VsSXBJoJgSRjDnlDwUTZjEZaFIArwf/OXnOYve0qTZImP3mkw1N3aDg/0rUrUL0=
X-Google-Smtp-Source: AGHT+IHP4F2Tm6N/5OxE+D+ej5jOfAnCXKW6QxdTGze+i/qVOJkz19OpI5GAxPOlZnSVD+rwaTqfyw==
X-Received: by 2002:a05:690c:ec8:b0:610:b545:6605 with SMTP id cs8-20020a05690c0ec800b00610b5456605mr6293070ywb.26.1712565183270;
        Mon, 08 Apr 2024 01:33:03 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id u82-20020a0deb55000000b0061449082d4fsm1615114ywe.52.2024.04.08.01.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:33:02 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-614b02f8ed6so45147377b3.0;
        Mon, 08 Apr 2024 01:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHeqyXZrJ0tH0UgPLdVxNDKqWCbR6G0x2gBifEzUWyHPxUmK1+D10pVDG9H5m1EEG8W1RnYRKNoHG5qnSkeSBODINiDlno/6KQOuOL2H2kYFjH9Y4iwK0gzsmV7NDzu2jitJjwUElyITx3
X-Received: by 2002:a25:ab2f:0:b0:ddd:7a62:59b0 with SMTP id
 u44-20020a25ab2f000000b00ddd7a6259b0mr5993867ybi.15.1712565182435; Mon, 08
 Apr 2024 01:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
 <87y19s7bk6.fsf@mail.lhotse> <4bddf8ec-97f1-07f6-9c0a-523c102c0a1b@linux-m68k.org>
 <87v84sbexv.fsf@mail.lhotse> <b1553164-18db-4f5c-b1a5-28a393d64941@kernel.org>
 <3adf561b-2d6b-47be-8fca-2a26ee738670@kernel.org>
In-Reply-To: <3adf561b-2d6b-47be-8fca-2a26ee738670@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 10:32:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+sZCUs7a-z07y-27t7RFqRg6y8M98XqExLy0qU=aVOA@mail.gmail.com>
Message-ID: <CAMuHMdX+sZCUs7a-z07y-27t7RFqRg6y8M98XqExLy0qU=aVOA@mail.gmail.com>
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq flood
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Finn Thain <fthain@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, Apr 8, 2024 at 7:37=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
> On 08. 04. 24, 7:32, Jiri Slaby wrote:
> > On 08. 04. 24, 7:29, Michael Ellerman wrote:
> >> Many maintainers won't drop Cc: tags if they are there in the submitte=
d
> >> patch. So I agree with Andy that we should encourage folks not to add
> >> them in the first place.
> >
> > But fix the docs first.
> >
> > I am personally not biased to any variant (as in: I don't care where CC=
s
> > live in a patch).
>
> OTOH, as a submitter, it's a major PITA to carry CCs in notes (to have
> those under the --- line). Esp. when I have patches in a queue for years.

(Good to discover I'm not the only one carrying Very Old Patches ;-)

> How do people handle that? (Like rebases on current kernel.)

Keep them under the --- line in the actual commits, just like your
changelog? All of that is retained when rebasing.

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

