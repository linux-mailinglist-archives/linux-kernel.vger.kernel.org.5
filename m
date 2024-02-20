Return-Path: <linux-kernel+bounces-73401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F385C203
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946511C22049
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB167690F;
	Tue, 20 Feb 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS/+V8Sb"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0676419;
	Tue, 20 Feb 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448841; cv=none; b=oJSBfUazqKz85t9AX6G6WfyXcHaYQ3jXmUBBzHw7WHfcTlsTqSGKb+1Dy3rrEJPieGt8pPYFszfSO9ixWyTk2Vyd3sYlFYJM3NxOcB/3dlS7ezL6Bc6hOLpu09PmSg956xr/KhMRYiWuf3LjQjkgGtvskSgztQPcdZJ9nWBgj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448841; c=relaxed/simple;
	bh=X1f6yVZGvSqGIjaMOSQQn5bXgJzLy/DlO5pJJScO/L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmjjWhm0OFCTLl3UwhE9Tj5HSKw9dHX7jIYFzpwCTYSenHJU5cn5RkHVXfHYEn7hQonrB/5WKp7j+rKsLo6ZM18zkvgpfb0CwIE8CoeG38CqXRGHJvJBDx3Ek1fFZbvPHcM7zgWb5k/YkC70XiF2pQGnCQjkmZIaIN91l2trJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS/+V8Sb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290ec261a61so3447753a91.0;
        Tue, 20 Feb 2024 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708448839; x=1709053639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1f6yVZGvSqGIjaMOSQQn5bXgJzLy/DlO5pJJScO/L8=;
        b=gS/+V8SblJJWqLY/JqPTiPkpY70kC6fAkRgr7G9boPB7/wovKrAUXBS3r7dCTjJbfY
         I904xGzcZyoGE9USEmDDHUqYoizRB7kAQoJSsBYmsx1qHgAa/AFRG620TKQVw2TQnBZT
         WaWeooSuZ28YPw2kLu94Iae1zSDuK+DgfyT/3aUdUC7ndNwPtlrcXZ12nplMTcCfHZet
         GWJnEwkQfzSp1OXtRuZ51VtG6yQM873P/sRaQhyr4i4+7KtEgUqVxeHMUCi58OTC20an
         7y7u97V7o0JUaEuQXLNVDXDfGdbZGVhn2ji9WcgCHCfXDCtPsyXec2LRADMtaWNeYgvR
         bE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448839; x=1709053639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1f6yVZGvSqGIjaMOSQQn5bXgJzLy/DlO5pJJScO/L8=;
        b=WcATCyTyRE0JFRgLCkwfGzafdK90WsYUSCzFmZpNa2ngIY5swclyZW2CoWR5LuQ9rR
         jY/J+FRijlrPHTwyny8w+d7vWFmv+MaAYV8RzAsqT7OyiaRAS2sDVQGaP0CU9CH+5JdM
         l0xCu4BlTz/msHzYiDEjmDkOfuVxpKuoM0inL94aAmr3xSMMhxTFHvZOghxv++bdpyIC
         OCxOk2ego6kjPTiRjs7rC5+mffUmBWrS2ZEJ8hbn3P4mZwzReuHaJFgWHB/mqf71/VBR
         K5EZIiTnDBxlKrDG1cyJ0P/jMMS4psxxGqYJ0Pkr4vMdmr1htCQhSJFYifvtPtpgpTin
         TJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVANFMexxGRVG5mHPQiyVZTbz58LfvnO1OHMzKMCt2D9tnO4g6VLHqRhp5JVFvHbFfNsbkOaWc/yV27kK/FK5dsATcoMMKdpZIsX+U8kFtrq7r8jmbtozbwyvXaE07Ay5R5rGBHQRm1u5EOuIg=
X-Gm-Message-State: AOJu0YxjqeKvM6He6J0hgC9uQ1T57eiXRZJR3cstHo+q8qx4zcx8ng8K
	eUIZRC3/E4jcJ9TxwQBDBHr+daaUj5pik7O5jvO0GkCMifJvTvyGYGLPFgyTDYIe+wvRv60JD/p
	2wbgVMc7I4OqxIAjy2ZuYt/gsUlpQxC+N
X-Google-Smtp-Source: AGHT+IEKbzTmxxOipF1JjBIyr6jX91Z7VIXgg+4jlXs41dWyjRETYbjgAHo18r/2l0/L1N9leaHcak/6vvU/zZUfI40=
X-Received: by 2002:a17:90a:1c17:b0:299:544c:4933 with SMTP id
 s23-20020a17090a1c1700b00299544c4933mr7056810pjs.14.1708448838958; Tue, 20
 Feb 2024 09:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com>
 <Y9ES4UKl/+DtvAVS@gmail.com> <16641a56-9139-4396-a5a8-89606bedd1f1@app.fastmail.com>
In-Reply-To: <16641a56-9139-4396-a5a8-89606bedd1f1@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Feb 2024 18:07:06 +0100
Message-ID: <CANiq72meap5C9bkj5rNDE=0U5gb5OKwDrrTSrVRwJbkAPWgUsg@mail.gmail.com>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
To: David Rheinsberg <david@readahead.eu>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Masami Hiramatsu <mhiramat@kernel.org>, John Baublitz <john.m.baublitz@gmail.com>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 11:39=E2=80=AFAM David Rheinsberg <david@readahead.=
eu> wrote:
>
> The current workaround is to just disable CONFIG_X86_DECODER_SELFTEST, wh=
ich I thought is a sad state. I can gladly use `256 + KSYM_NAME_LEN` and ad=
d a comment ala "room for insn-encoding and a symbol name". Would that be a=
cceptable? The alternative would be to try to dyn-alloc a buffer and increa=
se it to the actual line-length?

John independently hit this issue again. Could we fix this? Going for
the `256 + KSYM_NAME_LEN` sounds good enough for the moment since it
would be a clear improvement, though I agree this could be cleaned up
further.

Sergio took the approach David suggested in a related patch [1], but
perhaps it is best to submit the fix on its own so that it is easier
to put it in. David, would you be so kind as to submit a v2 with that?
Hopefully x86 can pick it up, otherwise with an Acked-by I am happy to
take it too; and then Sergio can submit his patch on top again.

Thanks!

(Cc'ing also Masami who wrote this originally)

[1] https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-sergio.c=
ollado@gmail.com/

Cheers,
Miguel

