Return-Path: <linux-kernel+bounces-24148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5B82B840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1853E1C236F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE845A0E5;
	Thu, 11 Jan 2024 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J/FvfmTi"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A057870
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27733ae1dfso676844266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705017051; x=1705621851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XuSRZauKm+2jfpyhgJr6xb3ul4ghcXQgBZWsFpIGPbY=;
        b=J/FvfmTiLrFKQm2DCQY87MpEHLMG8Otqv8fblpX+xyZ5yv9D/VOXzW6LVMQqxPy9P6
         imKq1btIq97WUuznx4+9j2Hxv4fl43QXB8TQolVaTUt177eZwx+hwuOQXZ03FHKRkGrx
         HQ3bTRJMtUpCA2gq+6UkJtiJjZNX6XZC1qtXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705017051; x=1705621851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuSRZauKm+2jfpyhgJr6xb3ul4ghcXQgBZWsFpIGPbY=;
        b=vqJBMB54phjLiAnSSF+oZAvtGQgc+odnnnTF/U5rNjNLNhfDI4l69/+seXXfvlwDNP
         61Uvk752TsC0fshlwgF00PhcZDrh/UwRKzAqe0Zhdi4AsFDC92wXZo2j5vwI7XZLMgOA
         QuJyNN+J2bQ+51Mv12M1F6nccUsMl33GfH28cXE4HBF/xo0+HBsBAPJd2XKD4mnFUuZe
         Dn9U1kq4uXf+J0rl/PEL/WxayJCKPIw1lgTMAeptSwDzRoks4ePNkafcoOeRPo004sGq
         u5tpzREN2ztJASoToUgmeyvY4mo/19W+ydjf/XLOV72JdmCA4SzVIuDqNpNe2+3Sj77B
         sHLg==
X-Gm-Message-State: AOJu0YzrPM/zSvlfY8Pr6WDZXzZ7fzLmdiW9nB7Ar0IPOlCoUBmTIZ93
	m9Q0+/HxXk5OCe1YPpbbdhSIGCGHcwDIGnykxYI2w9X0qLG4Thek
X-Google-Smtp-Source: AGHT+IEYoJPaAwhppZKKvpwsTSUhXMSSFenffcJXdFwbs3eZhcYJ+HcS/NKIV5gTZqKvQdgNZgm6cQ==
X-Received: by 2002:a17:907:31c4:b0:a1d:ffaa:cf5f with SMTP id xf4-20020a17090731c400b00a1dffaacf5fmr149397ejb.262.1705017050875;
        Thu, 11 Jan 2024 15:50:50 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id af1-20020a170906998100b00a2c6aa5e374sm993191ejc.12.2024.01.11.15.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:50:50 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2c67be31edso134811066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:50:50 -0800 (PST)
X-Received: by 2002:a17:906:2592:b0:a28:c638:40a0 with SMTP id
 m18-20020a170906259200b00a28c63840a0mr102186ejb.77.1705017049672; Thu, 11 Jan
 2024 15:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
 <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com> <255e3328bd48c23fbaae0be6d927820d36e14404.camel@HansenPartnership.com>
In-Reply-To: <255e3328bd48c23fbaae0be6d927820d36e14404.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 15:50:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6PenRqDCuumMK_5+_gU+JdUqrBEDS-XwFiaNdVRZAHA@mail.gmail.com>
Message-ID: <CAHk-=wi6PenRqDCuumMK_5+_gU+JdUqrBEDS-XwFiaNdVRZAHA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:28, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> You installed the special "make it even harder to use" version didn't
> you?

We call that the standard version. Because "harder to use" comes with
the base package.

You have the same one:

> Because for me (gpg 2.4.3) it gives
>
> jejb@lingrow:~> gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85
> pub   rsa2048 2011-09-23 [SC] [expires: 2026-03-11]
>       D5606E73C8B46271BEAD9ADF814AE47C214854D6
> uid           [ultimate] James Bottomley
> <James.Bottomley@HansenPartnership.com>
> uid           [ultimate] James Bottomley <jejb@linux.vnet.ibm.com>
> uid           [ultimate] James Bottomley <jejb@kernel.org>
> uid           [ultimate] [jpeg image of size 5254]
> uid           [ultimate] James Bottomley <jejb@linux.ibm.com>
> uid           [ultimate] James Bottomley <jejb@hansenpartnership.com>
> sub   nistp256 2018-01-23 [S] [expires: 2024-01-16]
> sub   nistp256 2018-01-23 [E] [expires: 2024-01-16]
> sub   nistp256 2023-07-20 [A] [expires: 2024-01-16]

Look closer.

NOWHERE there does it mention E76040D.. Nowhere.

Really.

Yeah, it says that a key that I didn't even ask for has subkeys.  It
doesn't say what those subkeys are, nor does it say which one matches
the one I actually asked for.

Yes, you clearly have Stockholm syndrome and think that this is all
normal and exactly what you would expect to see.

I happen to think it's unbelievable garbage, and I think subkeys are
something that makes gpg even harder to use than it would otherwise
be.

Here's a clue: if I ask "ls" to show a file, do you think it would be
ok if "ls" instead said "here's the directory the file is in, and here
are the dates of all the files inside that directory"?

Or would you say that such a program is crap? Honestly now...

And the above is actually being *generous* to gpg. The reality is even
worse. Try this:

   gpg --list-key 37AAA9562C5CBD0C

and notice how it doesn't even list the subkey I asked about. Not even
with '--with-subkey-fingerprint'.

And no, I'm not just making up particularly bad examples. This is the
reality I deal with all the time when people use expiration dates on
their keys.

The above "show my the key" is *literally* the key you used a decade ago:

    git show --oneline --show-signature 233ba2c5ffcf

and this is (one of millions) reason why I despise gpg and subkeys in
particular. That key was valid at the time, and as far as I know
there's no way for git to say "was it expired at the time", so now all
those signatures flag as invalid.

Plus the "--list-key" thing NOT EVEN SHOWING THE KEY I ASKED FOR.

Christ.

Ok, I'm over it now. I just wanted to rant about my least favourite
program ever, and how you trigger all the worst parts of it.

           Linus

