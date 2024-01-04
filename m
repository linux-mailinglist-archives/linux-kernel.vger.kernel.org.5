Return-Path: <linux-kernel+bounces-16889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52994824579
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C581C21E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E71249FF;
	Thu,  4 Jan 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P2WvEIgS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C1249EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd715ed145so548398276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704383698; x=1704988498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLqJo44VuyUw8MJch6t3PsF5TyAUQI8Tm5Zx7iuRPos=;
        b=P2WvEIgS5ZYA51KjWYF1mXbpummCO3ePiPEFnrNdmKgkHCN2jcbD76LAgEVU5hJthj
         7A6HXmfgldVZBV8eK61IhrD6FiSOL09UPBmRwIzQyguLrsIzjisttxRx6m5S/faDQE4U
         aLR5qHW3U0l2lyHRDqf25DoU04EIBQKljU8516m2Ll0j8dS+i0txZIs8cJjUdOAJvqJc
         mTsyEr1znIlM1zNiYpxv5e8bV7s9H3WkkeY3zYlYn+b0eC1jmix5VoqIU6gt/F+do0LF
         /uv7Lw5iw7nzIQya54ca9ggRBA7a+h2NgbKPiY2Ct8mXC2LY5EOqjIwHCjqTEpJcYCog
         BMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383698; x=1704988498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLqJo44VuyUw8MJch6t3PsF5TyAUQI8Tm5Zx7iuRPos=;
        b=RNM/GHWCUzsqdr608itjb9O9xuo6Vvvqo3Al1BbkkAqUqjhtuxwwBxYyMieFM/0CVe
         fX0sXD3MI7Whfxzo5blXc38+PB5zO1AB6n5/7ZDt+9T66Iz6nnmYHUw59YSREqgdxS0A
         xmDvPrPt7eyWbWKEepqAh/9Nhjc73TruULdzqkXnmzRf22cG491nYpg054Jwy6g3kC6u
         kKHG3zFe5tJJD36qDozjXz0ca59WIRMXTdLblez4G0jPFYO4WdhL07G8sNZBJ2yUipkr
         3sjbOSkguT544IQSvBaN9BVKjwSczOe+4vHTHme0pB7aNEXosurV49ioxbMDt08vhwvs
         80ug==
X-Gm-Message-State: AOJu0YwXfg1TxbdbsQWODDckMXb6B3df/4ZW0flcpxuM0x9aGZoeATOw
	6YT2Y6ZEvyndFan626yJHfBiu1vXKtGrhqYrnBUIhzZKBEGj
X-Google-Smtp-Source: AGHT+IFy2mnx3oXos2pR13M1nFq0SGOOGRWe/9M47++wXkY5A4g9tH+dFdPm3+T8rBq35nuH8KZ3eS74dp1pysSFLAs=
X-Received: by 2002:a25:ad95:0:b0:d9a:4b0f:402b with SMTP id
 z21-20020a25ad95000000b00d9a4b0f402bmr741926ybi.38.1704383698532; Thu, 04 Jan
 2024 07:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-3-greg@enjellic.com>
 <ZNKN+ZK6Lfbjb4GZ@jerom> <20230811202254.GA9401@wind.enjellic.com>
In-Reply-To: <20230811202254.GA9401@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jan 2024 10:54:47 -0500
Message-ID: <CAHC9VhSBnKor21HKiLuvn1kPmtHzNZW2j6FfEQ+cab5R1=_Bdw@mail.gmail.com>
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: Serge Hallyn <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 4:24=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Tue, Aug 08, 2023 at 01:48:25PM -0500, Serge Hallyn wrote:
> > On Mon, Jul 10, 2023 at 05:23:08AM -0500, Dr. Greg wrote:

...

> > > +of a model.  This allows a TMA to attest to the trust/security statu=
s
> > > +of a platform or workload by signing this singular value and
> > > +presenting it to a verifying party.
> > > +
> > > +In TSEM nomenclature, this singular value is referred to as the
> > > +'state' of the model.  The attestation model is to use trust
> > > +orchestrators to generate the state value of a workload by unit
> > > +testing.  This state value can be packaged with a utility or contain=
er
> > > +to represent a summary trust characteristic that can be attested by =
a
> > > +TMA, eliminating the need for a verifying partner to review and veri=
fy
> > > +an event log.
> > > +
> > > +TMA's implement this architecture by maintaining a single instance
> > > +vector of the set of security state coefficients that have been
> > > +generated.  A state measurement is generated by sorting the vector i=
n
> > > +big-endian hash format and then generating a standard measurement
> > > +digest over this new vector.
>
> > Are you saying the TMA will keep every meaningful measurement for
> > the duration of the workload, so that it can always sort them?
>
> Correct, every unique security state coefficient.
>
> The approach isn't unique and without precedent.  Roberto Sassu is
> using a similar strategy in order generate a time/order independent
> PCR value for unlocking TPM sealed keys by parsing RPM and .deb
> distribution manifests.
>
> Paul Moore, in his comments in February to the V1 series, even
> seriously questioned why we would expose the classic linear extension
> measurement from a TMA.

To put my comment from the first revision into the proper context, and
with my understanding that TSEM's security model does not consider
event ordering/timing, I questioned what TSEM would expose an ordered
list of events to userspace in addition to its unordered, sorted list.
Either ordering is important to the security model, in which case you
expose the ordered list, or it isn't, in which case you expose the
list in whatever form is most convenient for the tooling/model; it
makes little sense to me to expose both.

--=20
paul-moore.com

