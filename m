Return-Path: <linux-kernel+bounces-35187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5C838D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B0CB26DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6845D74C;
	Tue, 23 Jan 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBijgEJP"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AA5D8E4;
	Tue, 23 Jan 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008831; cv=none; b=OeMmD7Lj+yJ9wqbKWKk2DDRi2BzahQEbojihDhecNK0FpU8uJKqghK5l0dQZlP/1wsLY7DiroVAJVWcU1cLFxDIqDgW+5HGKDRu8j3QI6yAQ6CoJzslAqX6Tx5eJgIxYT2aZjqoXAfNLphtxncGXGNHu+XWiUXjLn3AbHn16JBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008831; c=relaxed/simple;
	bh=IisEDnr+p0PvkSItO7KxH/POXpdIe2NGTC+4LQBQ9ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgRrQQW3TLCEq9/qHJBkonmPaadcc1zLvz3exRnNi30t5p3zhLc3QwVZCW9sTwIQaXoBDYUKaUnFlEALDHnOR7T5C3c5PB1bZtOAkY8tao1drY8tpyE1i566dcs/+XJ211bYcpHd+u8tbr0gbW/tFI4Myt+Pl+JLOjxqqy2ow4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBijgEJP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-600094c5703so16494477b3.3;
        Tue, 23 Jan 2024 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706008829; x=1706613629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IisEDnr+p0PvkSItO7KxH/POXpdIe2NGTC+4LQBQ9ps=;
        b=kBijgEJPME7gdEUt34NulXDmWBhtfdubuv50n9xk8hO13j5xgZDuQcVwWq/AJfF3QC
         wek2AoKoOqgKgQTpRFAgZytudOTE+E1LHSgy4W2HAS4zu7r2NRjcqizzFEebIammQuaD
         l//TZc85tTAs76+PoVHs5CRZntIkk3RlGYtRHcw69dhK/BffJ6X/OY0JZ1X9SPTwdyN2
         NixzCiXvfzE5mbNNVRXtsTX/DTJmv7lN16q6Fc0WNKtvc1BLgHYusp4qhBbmrtCNUH8r
         lFArGNoVbr6ah+98iYgM6bX80JhxgZfLXGuleY3KtWGwsu/RcQ4DmJbUh11b8apApq4Z
         2kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008829; x=1706613629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IisEDnr+p0PvkSItO7KxH/POXpdIe2NGTC+4LQBQ9ps=;
        b=RSZ2d6Uo5UKLulZSvKPT9nohgfBPN8a12lmUqg3hisIhYbKwatOm1yJSrsKF0fPTm2
         q3dZkPAThkKuNoQa/jct7frk/I7n9RyXdpbKxgEgEh+gwzC9a+E7eRJvu51Z/ahtLllv
         vuWZJrMvdJr1nxTQZTdSiIMG34wOrcS93iHd+SycR7AbaV1DyYQLSeYS2Z2w8IqETkiK
         AeB7AXlK3OYAOHT2lBkNWaamUXyQFYTYNNVNX93tw/ZYLdAUbO5/x1ZR7g5TFkBqe9/B
         vAqfmsGu7j24q5fWjpC2R3lq396M1EmFfArTp1LqON7s7IxacsbfeXT8In5yMCuW9RAG
         Lw5w==
X-Gm-Message-State: AOJu0YyGdV0IP13sn3viamDOI40hvYrFZvYxsuqkw9wvXL1jEOpCdo1D
	CiAxrNfST7wefsRxoU1qkgIlG2zhaQxVrnpeGc7wZjZDPdOggNnqgLwgt9YgwviU1+cBvs78my/
	dTP/OD1wZNrgoqrA98NWRRnY6T0o=
X-Google-Smtp-Source: AGHT+IH4IQpUe/K+u333LaknVexj1p6gtLA26l3nnEZTIeJfvnH371BjAwUrxox7EyMtb6d9YE7r9aefRN/hzusUOWg=
X-Received: by 2002:a0d:d582:0:b0:5fb:d2da:63d1 with SMTP id
 x124-20020a0dd582000000b005fbd2da63d1mr4295362ywd.36.1706008828795; Tue, 23
 Jan 2024 03:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-6-keescook@chromium.org>
 <CANiq72kWTu_1YcmSP=1sB6CmrdbQcksxFvLci6VC2u8_Bb-Exw@mail.gmail.com> <14B4D24C-4CBA-401E-8111-CF74482CA956@kernel.org>
In-Reply-To: <14B4D24C-4CBA-401E-8111-CF74482CA956@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jan 2024 12:20:17 +0100
Message-ID: <CANiq72=K2Ux9obd6fP3sMhRxRpRs6_ow_5VbG0kjkw8vpx75_A@mail.gmail.com>
Subject: Re: [PATCH 06/82] overflow: Reintroduce signed and unsigned overflow sanitizers
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>, Hao Luo <haoluo@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 5:45=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Yes. We removed this bad behavior by using -fno-strict-overflow, and we w=
ill want to keep it enabled.

Yeah, I only meant that the wording of the commit seems to say there
is something special about the "overflowing behavior", i.e. I was
expecting just UB with the usual implications, but given the extra
text in the parenthesis, I wondered while reading it if there was
something different/special going on.

> The stack usage is separate. (This may even be fixed in modern Clang; thi=
s comes from the original version of this Kconfig.) The not booting part is=
 separate and has not been tracked down yet.

I see. Thanks! In any case, if the sentence means only 32-bit x86,
users couldn't still see it. But since this was already in the revert
now that I take a look, I guess ignore this :)

> I wondered the same -- they were this way when they were removed, so I ju=
st restored them as they were. :)

Makes sense :)

Cheers,
Miguel

