Return-Path: <linux-kernel+bounces-127510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351A894CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA1281FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBD3C471;
	Tue,  2 Apr 2024 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSBKhc4J"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365AD36AEF;
	Tue,  2 Apr 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043419; cv=none; b=PYlSxJFrHFpN8aUx0o374fCA4Lcn26cxazdA42Ewa5EsrZetFfdqu0z0+uZsr3MW49ukRpClnUbxWT7ydnGLfQTiFcOqnb1Shybcf4xJpc92L+FcQj3ikV/lh+3A95RSwnHcH2c8tPhhCrI6irXqtZMqnSdF4JZY4yJRt2Q0BCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043419; c=relaxed/simple;
	bh=nQuUXMffA4WwM69FITwsN2YbrcKETHbVPRcQPamcnj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/nUP44Ia5atEEnVZ2PSqp0gAOklpo2Gat9Ev88NRW17TsVFu0UVVuqIktz1dhkgwFBG7k8dR8uxdVgxm6CVhsqjuKb+GsoX/g+yFyRpt+noISVsHwqcsSAfWHpJKlArf5qcvXOJ1o7m+SRREGxILCsWXWXbxbRA6nYzHKGwRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSBKhc4J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3667831a12.1;
        Tue, 02 Apr 2024 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043417; x=1712648217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvA4XlQG31Oac/CL2P251TxTxsp49nq3BgjpTreKMJo=;
        b=iSBKhc4J0fLiZHJFzTEsrZoYb911aMeYgBp97QuH3W5IsnFLAShnCWTzFobouO/DJo
         EvPWVNaysKbRLrpj4ykfWIxd+ICqdiyCBodZsX7vhXdIQ/QK2EVPe7YTRXPPzqf/gWAg
         1sk2Ru3Ht/AR7WwgeRP874olMDOnrXYqWLuMRK7fWakQFBfHsvkIo2QNCIY30i/iyBi6
         q5jy6ITCxVyMn2OSZPIsKYThlTJBLh53of2tk/CjW0KETvMTgJWuPR+sbrZwq+L3r1S8
         6BoEamGG7LRpkK9hlBhZaqOgn9tQxyWF58/wSb4CsDjIvN3rSdle24Hvx42891rI9+ti
         2DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043417; x=1712648217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvA4XlQG31Oac/CL2P251TxTxsp49nq3BgjpTreKMJo=;
        b=U9BBRf8GxcZ+K43ZCaYcPwI1UI41p9eQCTAZpb/5RNmPSkFNsYsuTqlmqWkwrPYTHj
         anWyZBHvcDJfEGAsFmMeZofT8EMrT/kS9Mj3oTjUmWX0ZrLS/ZYF4lIz5u0F+gCy1Rd0
         QZxHEv62IUYDGA2EulS98/cryDJKcoS7SCSv7NdcMrljv4iKTadVxvo/Ka2VGO/jPar5
         sAl83S00Yn7QnOMndEDHfWfbWMBXZtA0M2X9p/dMT1O4/ruCnnZUCINURzPb8ed9VlOJ
         BrFmV+CHDRHEE5z+h8Y2sH2UzowgsOVKrNV9bTsRQoeiaTRjjWkN0leaRC07na9d0D66
         hxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF/SMVWsLoJ2rKmYWhTSZoYLes1m7bJRbn4q2SDD62Fh42LZU93ldnFj05zyRbgXvUBo0Ab0T5GdcihwyzOLB+Yi9frr9egR1BmSAVIgeSytTTrIEQbJEwFfXERPSH819K7BPSaRWSha34Y2t99THb7kSarEzed9BbXrXarZgj7jGQq0Q=
X-Gm-Message-State: AOJu0YwX5BKOpNxnHtF6BpLVmmXihOckRgRVRNpjoyWo+54DJK8dg2dp
	9kUQ7dZHzFJkdo6fdi8eKK85VwVzC+r3ha6wKBbeexuVA+Kq3Y4sNI9s8hykpl/helS4iA+5H5Y
	6UTjoDXZa9G8LrqZ7v4v1EIzKPUk=
X-Google-Smtp-Source: AGHT+IFEUvd1yE1nbw06r4wTEb1sXFYeMkMQN2S0bow6ijv/7I5Tx828lFINSC7g7909AWI8L2qEgfI3K3LGOORaszA=
X-Received: by 2002:a17:90b:3907:b0:2a2:40c4:5175 with SMTP id
 ob7-20020a17090b390700b002a240c45175mr4290548pjb.14.1712043417507; Tue, 02
 Apr 2024 00:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9D0C95D2-6239-4A3B-B9DD-66299B9911EF@me.com>
In-Reply-To: <9D0C95D2-6239-4A3B-B9DD-66299B9911EF@me.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Apr 2024 09:36:22 +0200
Message-ID: <CANiq72n72jO9v5Yo380VXTyaKiKG58U67f8XCP_--g2fHzeAzw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: init: remove impl Zeroable for Infallible
To: Laine Taffin Altman <alexanderaltman@me.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:53=E2=80=AFAM Laine Taffin Altman
<alexanderaltman@me.com> wrote:
>
> A type is inhabited if at least one valid value of that type exists; a ty=
pe is uninhabited if no valid values of that type exist.  The terms "inhabi=
ted" and "uninhabited" in this sense originate in type theory, a branch of =
mathematics.
>
> In Rust, producing an invalid value of any type is immediate undefined be=
havior (UB); this includes via zeroing memory.  Therefore, since an uninhab=
ited type has no valid values, producing any values at all for it is UB.
>
> The Rust standard library type `core::convert::Infallible` is uninhabited=
, by virtue of having been declared as an enum with no cases, which always =
produces uninhabited types in Rust.
>
> The current kernel code allows this UB to be triggered, for example by co=
de like:
> `pr_info!("{}=E2=80=9D, Box::<core::convert::Infallible>::init(kernel::in=
it::zeroed())?);`
>
> Thus, remove the implementation of `Zeroable` for `Infallible`, thereby a=
voiding the UB.

Do you agree with replacing the last part here with "avoiding the
unsoundness issue" or similar instead?

i.e. there is no UB in the kernel (related to this), so it isn't
avoided in that sense. Of course, you mean that we avoid potential UB
to be written in the future, but I think it is useful to distinguish
between patches for "holes" in the extra layer of "protection" vs.
patches that actually triggered UB.

> +    // SAFETY: These are inhabited ZSTs; there is nothing to zero and a =
valid value exists.

Typically we would add an empty line here, and we would put the SAFETY
comment below (i.e. closer to the code) while the rest above.

> +    // Note: do not add uninhabited types (such as ! or Infallible) to t=
his list; creating an instance of an uninhabited type is immediate undefine=
d behavior.

Nit: this could use Markdown (`!`, `Infallible`).

Otherwise, apart from these nits and the formatting bit, it looks good to m=
e.

If you could send a quick v4, that would be great, thanks a lot!

Cheers,
Miguel

