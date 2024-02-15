Return-Path: <linux-kernel+bounces-67328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD18569F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B611F21453
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20396136659;
	Thu, 15 Feb 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsCArCfC"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8E132C10;
	Thu, 15 Feb 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015869; cv=none; b=k/gjCKjy0xzWu1PMdm0cBkKpnn37kOyjVrhiHmnuXJvRzTRGl3O6wp2NGvYxnve1NFMM2kZlcth1K8zxcp5/B0svAJOaHKB7EthK85lQzXXWv3WXQ5m9rzZ7jX3HddiOp9XT9IvVudox7HsdnRGKckHKvEzWShtPKZJewJrryE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015869; c=relaxed/simple;
	bh=ZTNKs342W8J0RINeS6cyL6H9EKrFTjDnEdCGDzi2b7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRcIqNPMPVuN+7uJWzPAEIm5sQZypEIDT7eFxplU38T9TUqUyS1JaP2bqlWdBA90bJdOCINapg8WKi8KdCzHE3lspHWOa4F44/D7n8kg1qeDXIxgLRAvqTGSCoNfqmhTA1MJWcapHDDRvRItWvcLsdShs2yBcWYNReJePPOBg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsCArCfC; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso992953276.2;
        Thu, 15 Feb 2024 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015867; x=1708620667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWbTPSA/om6zR+aNxMvSfqC1qzBEfL0EEjQgcRv0csU=;
        b=nsCArCfCRBz+o4+rn4OPXKLm7jcGqg+/826nZArCIJ6iUELpUUbf1y4spBn77qK9FO
         /UMVqedawu9yz0IEafsuVR5jeOdlTcQOgWbqGfL2R7013F+szjFIOtgxS9kXY2462mjb
         ro1RtJhU9TA63g09HrPm1UN/nlMYsWVHcs0S/kEUTeXUzaXBF3mFiR7Rb7Jco2vY0DIi
         yDQ/Oi140Wx0hAHu+W9erY4gveEH9HNGoReRX49VlEgze7bdReByDr6resbv0Jwewhrd
         +dHkQyGvHg5SgjCIvIEZHPYwNfrhtt7VZ2GBTQL3B+o6EDl84HdS6I/v/7e4B8UQ6eie
         7TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015867; x=1708620667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWbTPSA/om6zR+aNxMvSfqC1qzBEfL0EEjQgcRv0csU=;
        b=GQPCK9XM6tZYq/6GAYEcYmvexaR+H+M5FXzJikyx6b3sUSuCXU7+X8crH1Qq4Xuof/
         p1YUqhy3odBpkvoN59077F5OjWk2pTo+a+irWdTuKywPRthhmJA9RJikXf7G8bRW8ROm
         MZde+cAgDqsNAjh2t4/bA3u8ZXzpvPw5lqorRkzcNTppocyLSKEWoK70qGZVZlzdKTAA
         UBJm7ogjRRLkqJ5BoTvH6mDNHIes1EQEPmLOoy7JGpzZ0pIhto+wYzuby9mMRLb9FVaN
         t3KkYgm54laJaBrGGh0aS7bPBYJroIxyTge6lBeIyg9lOn0RYcrZcysKnlNOR/6faeNA
         vCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg2uQq4XOjppCtN8DCaG1Xhx6YAdzjd+eLY/VWEkUkazNt4VhHfdAgwI5wDYS9DOo23e1dayxxjgrWXUrUEk3Al6IFrKTIKq67MzBI6Z4yCZYRds4cAbPIBOuqORNJ5GeMbx7OqT5Qcq75gI0=
X-Gm-Message-State: AOJu0Yy5xcJhSPIQoCYOsb6Tleq9H77J7NqzaIaDmSCogT1QS3oHn7rT
	Zuf5d0Po9FnwDRNRccsMCIWdViT6XkC55VoriJLv7vDsI2R6HpBeQgBlMhaGPmOtxr5oBGgk3Vp
	AV5Ixj9LVpDhe815als6HsjaxyW4=
X-Google-Smtp-Source: AGHT+IGsSb79cMuHoz6HBxDYQX0a/FVmzQpTFve9OQZ+ugc/+Zp15WIR5mxYXbWMRZbjv4096l74Fp6GATXyNPowGlo=
X-Received: by 2002:a0d:cc48:0:b0:607:855f:599d with SMTP id
 o69-20020a0dcc48000000b00607855f599dmr2296378ywd.14.1708015866785; Thu, 15
 Feb 2024 08:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com> <CAH5fLghTKpLs=Wb03cjx0LRQbZgmXRoMNy1cyheb7cQRL0mjsw@mail.gmail.com>
In-Reply-To: <CAH5fLghTKpLs=Wb03cjx0LRQbZgmXRoMNy1cyheb7cQRL0mjsw@mail.gmail.com>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 15 Feb 2024 13:50:58 -0300
Message-ID: <CANeycqqwGE_eyFSDWkmHCBOMZ6+Ty-XK_hKixMtOYqc9_46j2A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: locks: Add `get_mut` method to `Lock`
To: Alice Ryhl <aliceryhl@google.com>
Cc: mathys35.gasnier@gmail.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2024 at 11:22, Alice Ryhl <aliceryhl@google.com> wrote:
>
> On Mon, Feb 12, 2024 at 3:13=E2=80=AFPM Mathys-Gasnier via B4 Relay
> <devnull+mathys35.gasnier.gmail.com@kernel.org> wrote:
> > +    /// Gets the data contained in the lock
> > +    /// Having a mutable reference to the lock guarantees that no othe=
r threads have access to the lock.
> > +    /// Making it safe to get a mutable reference to the lock content.
> > +    pub fn get_mut(&mut self) -> &mut T {
> > +        self.data.get_mut()
> > +    }
>
> It's impossible to call this method. You can never have a mutable
> reference to a Linux mutex because we pin our locks. At most, you can
> have a Pin<&mut Self>.

Perhaps you meant to say that it's impossible to call this method
without unsafe blocks? From a `Pin<&mut T>`, we can call
`get_unchecked_mut` to get an `&mut T`.

This is addressing issue 924 opened by Bj=C3=B6rn some time back. The idea
here is that if there's a path where avoiding the lock/unlock calls
(which are expensive because of the memory barriers) is performance
critical, we can do it as long as we use an unsafe block.

