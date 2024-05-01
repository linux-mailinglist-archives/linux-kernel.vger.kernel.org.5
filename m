Return-Path: <linux-kernel+bounces-165257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D158B8A23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A991C21660
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9D3FB3B;
	Wed,  1 May 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em9AMGad"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D081DFF0;
	Wed,  1 May 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567151; cv=none; b=nAtznRuEL569mvYKrY3VeTfK/lyuu18tov+BqbJoOZ2IMROhfS4Nkl1vsUNm8KnE/xYEF7xINY0+fa6oDPSFIh2+lU+QoVqZ1doabGv2r+LmOZqbB+exhbXvhw/glDkaowgAlZRGtrVOo7EwHv/IGQKNpwUgkr1omDzztoUG1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567151; c=relaxed/simple;
	bh=krYCDOguIwma0VoI3TPYxTTL9mU1DyfOtRfnO+iW3U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edWp+xMMq5Dgz7brTIGsvK0X5n/PiJnduwa/tW0ugsQS5pbuyeTib9oaoKGclbc0OTPAW1ze+of39B499vhKouFSdhDNhHBdXkaA9O5fFzIndCIiy2OhLf70QM87hAPzCibPGhv0No/eHoOomokzq6cnhvrLJYMFxu249xm7EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em9AMGad; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e651a9f3ffso34054255ad.1;
        Wed, 01 May 2024 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714567149; x=1715171949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9PKc+MR71uJgnzPpxJ70qMFfLvHTXjO7g7sk5/G6yY=;
        b=Em9AMGadx+eVGy/M306/CroHYeKQWRNWFh7Exl1J8fTQq0qbEo4LKFW9IrHcFCyaSE
         hVGdtA66v5yaxCVYYKi88YcJNxMnwSlolDZlbKMm3uv99KQuBTLYzS0XWCHop5LELSEO
         k83zThDJVq4PycLHnHiC5srPkhULhTRmLnslTNGbYueZa9tZtYPWDl++d1C5yQ/gx5cA
         4eBpGMWVW/MgV97BZN+VBIYcE5zVAOe0MJ6QVNPf8heht6miaVMvjDu/8HEnhKctNomP
         NUJDzC2BGaHUQ8ze4F2DzmIJ+L4yC3TEuZUo8zeA2F7rYwrfilLA8g+fZNDvish7sgGA
         JqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714567149; x=1715171949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9PKc+MR71uJgnzPpxJ70qMFfLvHTXjO7g7sk5/G6yY=;
        b=V/WGQg0qIPenlLShVCKZgLYeCMy00/nmNK2Qf8di1dHtBhjaNJlyd9qwiynrCC6QGa
         +kRc481HE/QP/SoHIT7FZ/AQq08K8jt/7aleoBqldOBa5BRDymJvy4XZWzJAZkSAiLxw
         ZEG3aVU/QJ5PRPAN9/rW+xlHcGbia6MBUvV+i62uaXpXzIZ6KaWrfoqWVd1PoLC1RAnP
         vqo3mLqGBlnQCsNnHwkytVvgW6sDNXX2yNN6HxjfnQuxWjXiDjJomXUm0Ljl9O/CIDe0
         VqT/B7tYqFk4+4/WCgGQByoz+pz1eJ05tW/8JqBlOrOR3USlrbgyXtLuPJiSx8xSHnE9
         Gktw==
X-Forwarded-Encrypted: i=1; AJvYcCUc6MNuEomduJJ3hLzUHuPy4cuv+Jbl4U9UKhXTE6DKCt2uw5J8KDw3pygv3Eb9cHlivRfL9orhQjnRRGfZpDIjoCvMKTh/26hJv8q2vvKk2ABoTxPUpqkO4LmDRSijHTAk59oxk62AXwCY
X-Gm-Message-State: AOJu0YwJOx66qT7C0YLmdK0aaRONIUd5p1JUK2KxY7cNWy8mioe8uPIa
	nDQKbuqo6+CmkQSek72E+zqP1dEmEtz6BEAEhUSJbc9du3WE0PvJ1B5DHr2HTo+Jl3RI948tGOF
	ZB7cHMpxcRV40JqZ8YOXZhkq+GlA=
X-Google-Smtp-Source: AGHT+IGAENrbCQ0TtjO2IsnDL8uuyj1jHYiSlVThdMHeDeVQ/mA1jGdKkSV045kItXbVxuLqnBrMkKy/hv5CHo1Wwbs=
X-Received: by 2002:a17:902:ee44:b0:1e9:9fdb:567d with SMTP id
 4-20020a170902ee4400b001e99fdb567dmr2110616plo.68.1714567149305; Wed, 01 May
 2024 05:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <20240430031105.GA10165@sol.localdomain> <ZjB2ZjkebZyC7FZp@hercules>
 <20240430162632.GA1924352@mit.edu> <ZjEf2VV4igcCtkRE@hercules> <20240501022201.GD1743554@mit.edu>
In-Reply-To: <20240501022201.GD1743554@mit.edu>
From: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Date: Wed, 1 May 2024 14:38:52 +0200
Message-ID: <CAGiyFddFb1yZ3kC5MP+UgqsCATcAcFvZLTXm_bCv3MsSnwAWcQ@mail.gmail.com>
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Aaron Toponce <aaron.toponce@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My 2 cents:

As a cryptanalyst, having discovered the 2008 attack on ChaCha that's
only been slightly improved in 16 years: the 20-round ChaCha20is a
clear waste of CPU cycles, but ChaCha8 is admittedly risky, though
more in terms of PR than pure crypto merits (plus, afaiu the threat
model of ChaCha in the Linux PRNG doesnt allow the kind of chosen-IV
"attack" known to work on reduced-round versions).

Switching from ChaCha20 to ChaCha12 might still raise eyebrows but I
dont think any respectable crypto/security expert will suspect a
JiaTan situation.

On Wed, May 1, 2024 at 2:28=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> So first of all, my apologies for giving you offense.  I really didn't
> think you were a shill for the NSA or the MSS, but I have to admit
> that when I get large set of patches which removes "unnecessary" code,
> which is _technically_ safe, but which reduces the safety margin, I
> find myself wondering whether it's part of a binary payload.  (This is
> especially when I get patches from someone that I don't normally
> receive patches from.)  Unfortunately, in the wake of the xz hack,
> we're just all going to have to be a lot more careful.
>
> On Tue, Apr 30, 2024 at 10:44:09AM -0600, Aaron Toponce wrote:
> >
> > The goal is just to make the CSPRNG more efficient without sacrificing =
security.
> > Of course most reads will be small for cryptographic keys. ChaCha8 mean=
s even
> > those small reads will be 2.5x more efficient than ChaCha20. The dd(1) =
example
> > was just to demonstrate the efficiency, not to be "fun".
>
> This is a philosophical question; are we going for maximum efficiency,
> or maximum safety so long as it meets the performance requirements for
> the intended use case?  From an academic perspective, or if a
> cryptographer is designing cipher for a NIST competition, there's a
> strong desire for maximum efficiency, since that's one of the metrics
> used in the competition.  But for the Linux RNG, my bias is to go for
> safety, since we're not competing on who can do the fast bulk
> encryption, but "sufficiently fast for keygen".
>
> People of good will can disagree on what the approach should be.  I
> tend to have much of a pragmatic engineer's perspective.  It's been
> said that the Empire State Building is overbuilt by a factor of 10,
> but that doesn't bother me.  People are now saying that perhaps the
> Francis Scott Key bridge, when it is rebuilt, should have more safety
> margin, since container ships have gotten so much bigger.  (And
> apparently, cheap sh*t diesel fuel that is contaminated and the ship
> owners buy fuel from the lowest bidder.)
>
> Or we can talk about how Boeing has been trying to cheap-out on plane
> manufacturing to save $$$; but I think you get the point of where I'm
> coming from.  I'm not a big fan of trimming safety margins and making
> things more efficient for it's own sake.  (At least in the case of
> Boeing, the CEO at least got paid $22/million a year, so at least
> there's that.  :-)
>
> Now, if this is actually impacting the TLS connection termination for
> a Facebook or Bing or Google's front end web server, then great, we
> can try to optimize it.  But if it's not a bottleneck, what's the
> point?  Making change for change's sake, especially when it's reducing
> safety margins, is just one of those things that I find really hard to
> get excited about.
>
> Cheers,
>
>                                         - Ted

