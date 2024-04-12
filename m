Return-Path: <linux-kernel+bounces-142189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A938A28A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3383287DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B14E1DA;
	Fri, 12 Apr 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2N7oNR6"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF81CD04;
	Fri, 12 Apr 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908791; cv=none; b=Fhzt7MW/u59TnlhYGzaLrIBgn5Wev1F+1P9777uLfD3il7Wc5DzSVMH4VrZk64QT54rj8NQJGvqaTaaZ/6u4FR1rh37F64+tcBtfz7F95AXlsq9TeV9mfQOE3A99AQPtpI0orTuicJVIsqn9vRPUT0SUW3Zu9xK3vUdef1WJXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908791; c=relaxed/simple;
	bh=9kpc36YLxfEtad6uDI4ebX5d/dPQszIr4wDX8T1iaos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAu/PcBKnR1B+qBcVo8aAfz5M4dpyNmwu78aMNG9rP1fispPxiY98Htgw9NEAlLiuJCBY1YqIcGr52G5RQnAs5sXAxYwNWVbPj0fSqVjh1fiH8f5FRo7fc3NQRUqfOn9PJYvkwg0xvFhorcIJRa7oVAvYmr+Es9rkch2LGcPigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2N7oNR6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so339095a91.3;
        Fri, 12 Apr 2024 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712908789; x=1713513589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kpc36YLxfEtad6uDI4ebX5d/dPQszIr4wDX8T1iaos=;
        b=J2N7oNR6XpowICMG8bhO7Q3ua1q4zYr8DrMHQK/wpzUE6DNe/J6r1xh0WdNMDUxnm0
         29KPL6S8R/v5SCZugx66tsb64MSMNr8JrkpnOze+nDs/1/z8FAz1My/cAp/iAWw8DPnu
         3GmYuT9BDpepnRIhFxWLYEVPWZIm38lgdCJSbeMacibUfKoxqHumbDvrkymaFwLWKwos
         2OczxTNHAWOlsMZkvkg4PXFrOoGJO/TX5qqv6FHkZzl5J0Y8dqHMLiuCfI8csISBjyZT
         nfwGlJWXVkz5i7N3vwnm34QH2BOLAQaLeHfjbfVmdAjmfd1TftOfHuVkWpTmOObQQSkm
         mjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908789; x=1713513589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kpc36YLxfEtad6uDI4ebX5d/dPQszIr4wDX8T1iaos=;
        b=NTUYuO5FKE3nhzmV1rrda7aNnoBnZTGm21KGXBBMGXWxgw9KuW/Kis0A0BZSxh6ynX
         7+nSjrmjWwdLMOnBh877KWlkgt0zhkago6Tksk0gHdedlOfjj2IUiP+m6C1KuWO0gEjZ
         dJRaraTMmsqc1co1yF34dj/YMAEWT2opFSTQ+idNlbCWOEyja7qV4r+BhVradhtvxiqh
         7pNjHD9i+FRrjKLZuOlcgFNx7SDq78kznp8JfDIkyf2jyo16exiyhqzUhdSDgUpwOFOG
         GBJLoYhS2h9kgzwrImeqfzE+gZYYoYXN7Dcz3NzkbuTQ+dZ/lTvjutqMuYa4fJwgxDOx
         Cz6w==
X-Forwarded-Encrypted: i=1; AJvYcCXSGm1gPVDGmnEhWPwnw5aEKtD6roYa6PCsxXc0dSWJiigIbRLKjn/vSP06meMOkVZ0Vdp/dq6zLv/2lNMlCsEgWWfLeyMZ9HPeRUC8Nz3U3eN1leZQhjOWYZn/FFLMG5D7Rku54QPlCEtHc1Y=
X-Gm-Message-State: AOJu0Yw87YTKmOCvcEz3G50wkf0FHMtf0U63J4BvE+W42T3kA8fxPxmT
	N0Ij/T+XZUC0mYmIkbjtKFNdgCNMIVUXAty53i6Ux46xWspVjS33Wzq9zuMEEGgZFgQ/u5M7uss
	C43uLAjtriTNYqlge05GN6NprnHw=
X-Google-Smtp-Source: AGHT+IF0LmnrUMH1fIRVp//RBL8ny0hZaULM61m5B+UVkT149AnGKaI8tyLWdVG+hmnpUnRermOk7Cz9D1ANXmmDu60=
X-Received: by 2002:a17:90a:c397:b0:2a4:9836:aa2c with SMTP id
 h23-20020a17090ac39700b002a49836aa2cmr1681059pjt.28.1712908789034; Fri, 12
 Apr 2024 00:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com> <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
 <f08c06a4e8361f2cb55cd0dc1fa2bc2b0a046049.camel@redhat.com>
In-Reply-To: <f08c06a4e8361f2cb55cd0dc1fa2bc2b0a046049.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Apr 2024 09:58:57 +0200
Message-ID: <CANiq72kMZ6mpK+LaL9Xfsp032CZOfAEtr6Dp9A2R-m6dC3gkWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Philipp Stanner <pstanner@redhat.com>, Kees Cook <kees@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:43=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> Is that going to remain enabled by default or what was the plan here?

The plan is to ideally keep it enabled by default, but I defer to Kees
with whom we discussed this back then (Cc'd).

The goal is that Rust code, since the beginning, has all wrapping
operations marked explicitly as such.

Cheers,
Miguel

