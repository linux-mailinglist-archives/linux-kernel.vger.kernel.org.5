Return-Path: <linux-kernel+bounces-89537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0E86F1B3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B5F283597
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806242BB14;
	Sat,  2 Mar 2024 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqVdyMiW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A17179BC;
	Sat,  2 Mar 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709400991; cv=none; b=j1DONSzanjr4/qkVqn4rVh7Mo1SRnODEZnLsEfLYbr/Kkc41RXK6nWOoHNuDWvdQAOeEBatMiVtirmUW0/Sjx+AV5epnnmcLLySlrB0HHH4st9r6hfTT9kpvOPpoKbFEJOWTrtVKzqUK6PzDGnVr2RBrZWQOdAGfR9tl5aYAF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709400991; c=relaxed/simple;
	bh=RLdzpXnFmAtgrD2Zfzq+44gRPLSpIDew0PVRbaP61CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb5/p5SODK2vMcQ9qeSRpPAa4Eo+hlJPJ7KirLDlvuU2tuDhcg+bSi6k29Z4913FtNS/2WpQ386nHZwvjPEn/hHVEJ8kZS0GtNTEk5bQGfc6GBAvnCk8HUIc0bdSoLWRopfdceS+cZtn7o0p3Qp3tejjQXutPncpsYwKcZ3bEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqVdyMiW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so7151023a12.1;
        Sat, 02 Mar 2024 09:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709400988; x=1710005788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLdzpXnFmAtgrD2Zfzq+44gRPLSpIDew0PVRbaP61CI=;
        b=EqVdyMiWy9FlMUsHc3EX5QToTRvL4ChW19+bjYkQxSfWK6kxQLXvajgp/Xs/nrMuXV
         L9Jv5Qqa8L7BCZX8NqUP0TcdY2BmzrNZa3P7RExUbLC8n5VqPbTL1shdBR13wEWKxANx
         oSjMH33WkkyYsIrpcwV9togSlQead611Ae7XPbK4aLel56pc7tdvClNai0ea8mJsl7T3
         /5env0txyeFplZc0/lJx0GiC3PR7KcuPPQQAF713h5LU3E63YWs788esi+nH/kw4fK5e
         SvlgEH+NK7eqr62ErZv+iEmE+KEximjnXXI1YCbp3ZaOIdHImc36lO4mVk3oPC20eTbG
         MLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709400988; x=1710005788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLdzpXnFmAtgrD2Zfzq+44gRPLSpIDew0PVRbaP61CI=;
        b=HJvfhOcP8LpeyNIpDaRBjNmTxbuo9T9XCd3Y24HTa4rgI7/XVD2nCn6Y55DOqe3Rnl
         HQbSHBMJVUtFNE8/p3NaDgzM3Pm/yw/uVfipjZdRC5uS/QxJFZsP1kwqhf7lAB/aIw36
         ZGqWxt/3E07oDf3KGIqjGfnIwaD7cd478jVPanhaJZFCA+dvtr/sRh37e8LSdSogNrp9
         7Cy8eg25sYYU5WeZFUqwZPGP+689TCZK7S7Us+tJ6mLvulb4n5khxAF8Iy9SItSTymUA
         SnmYb4zd5Y4IGOexarpVBzjZkcBv06OGT+xgglUjWKJz6tU6L1Eq8fCYAYeFI4Z72Rja
         51vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxPcqI4AhMeGXlUNHgj+Ip+Wwht9/9up5SZp3nugEakjDnxOj34kEiUlahGI+yCZdSIwR8eG3COxWRJwWxKufoS7cPgianEWhanF5x+Sv85OIp5ip2473b9IH92iTa5vGdrcd3Hf9/6g==
X-Gm-Message-State: AOJu0Yy/NqP4JZ+UtP2LBhOHZaV+fEdBjctUIK2AWNcfpeIxoT0oun7X
	9KxnHUMzsKM2pJb4byzNpP1DKn/AW6FtD1yCX6BQlmcUnuEySx3xeICbXOtiHyOy1ARvXhUHkkb
	1h5EC67CNASAtahYFM//npHsiPkNi97w4mu0=
X-Google-Smtp-Source: AGHT+IFrrxEVYIkJAO4igQyninAx7J7D4sivKYKMg5FuAvVo7ovBXEvLmAE+w4HWscVfJBUqb9lAyeafiY8eNWiYEAs=
X-Received: by 2002:a17:907:101b:b0:a44:591:a3d8 with SMTP id
 ox27-20020a170907101b00b00a440591a3d8mr3752629ejb.31.1709400988430; Sat, 02
 Mar 2024 09:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302004439.197232-1-andy.shevchenko@gmail.com> <CACRpkdadN6gQvbAEDc8fjhucB2JmSH25HP+gKC0vS1vic0j1GA@mail.gmail.com>
In-Reply-To: <CACRpkdadN6gQvbAEDc8fjhucB2JmSH25HP+gKC0vS1vic0j1GA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Mar 2024 19:35:51 +0200
Message-ID: <CAHp75VdvWEhJGtv+V4TG1TCzqBGggy3pwnaGQVLT3M++bzVvAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nomadik: Finish conversion to use firmware
 node APIs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 10:41=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
org> wrote:
> On Sat, Mar 2, 2024 at 1:44=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

..

> > v2: also update necessary parts in the respective pin control driver
>
> Patch applied on top the rest, thanks for this rapid cleanup!!

> If the test servers are happy and my manual tests also work I will
> merge it all down to next and send a pull request to Bartosz
> soon.

Thanks, but it seems I made a silly mistake with types (forgot to
replace them), and LKP wasn't happy about it. Hence v3 has been sent.

--=20
With Best Regards,
Andy Shevchenko

