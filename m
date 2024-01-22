Return-Path: <linux-kernel+bounces-32544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82B835CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821C91F224DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E338FB2;
	Mon, 22 Jan 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GYMwIiNA"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3F364D9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913052; cv=none; b=b5PMPtoIGjErzb+oW62hMmvq+qwUQ37eZ+AYix5tf9ln5Rw8FAZYIG5PN2A5iMxjrn1tks8+YlUwRow9dITYAk/3cTfoPombNeoisluQXUxDexbtmzEiDhRiCDCIzhkpU1o3RAJywrQqzg3gJma4gaOPw0g4B3+dDuNcBv6APKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913052; c=relaxed/simple;
	bh=6Orpfk4kCHRKM48wIGB/ppp2sheE0CmDME8PTpB+BKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXp2G/fl55DtVK+7PA+WkOdczdIBS2GAowpZTF75n039Jv1odmdxZjyT0CDQf4vY6EgXCmeb0uzuXKqYIcpJci9wBxvyfsZTXScpsjVuWa3ND1NMdWRLqI8GiOj7SPv8zoSZbsOQbbWg948siuwiiEGSFLhHk4993QVoSJNje/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GYMwIiNA; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2df9d1976so349722241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705913049; x=1706517849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Orpfk4kCHRKM48wIGB/ppp2sheE0CmDME8PTpB+BKI=;
        b=GYMwIiNAQvkOP0dn6eEhrLGrSlVfmlpIWmEbF1X1xTy22P/ApN4A8B4tXF8Zh53TeM
         h/ZLZj+LiL7vPqCW81WJQFAKSsFTYhgX3QAHNkc/ZgnxIb7A5OyZ5xIdxItZIlYDJ9S+
         tMedu881iHQ63p/qSps+IbM9j/jG8oTDj6bdRn1exmOAIIATd4Sg6qRT9iYpzXZM3/v3
         fEsjZ7ej0V2HsmLwaB//szPKaUgBooTx4sAHTtJ1yW2AxGCAhcbusO2mtNGDkdGgI2WK
         bVFGyaRRbxsRggzCzTf6NwXuxzl4WcOQwQLDI0I8xJAXGsJ/iUG06vwMHIoT5ZHc9XZ+
         HB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913049; x=1706517849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Orpfk4kCHRKM48wIGB/ppp2sheE0CmDME8PTpB+BKI=;
        b=Ei58kbEtf0hcT1tujDIDu7v5Vt1yVfocCP3EfyfI/98W7vIrqe06D95AgWd05a9xf7
         DZ8eT//mupLMYQ+XJoB9PHEv3CblGsETczoyNKNEtl5cnWrjfmqgGlAixPYxpyh7axVi
         XE8uY5eTEqH7GxLH/j6OAS5aPVB6lc7Sc0X1eD1g8me+CjIlkxg5BrZqtOUQX50+eBJQ
         l0L45RHUZBxb3u9VFYFcWbQzyFl5UCI9WCbNq6IJ14T9LcZIxCXv4nOJZbnipliTznp9
         nak9RFVowTEbud02IlmoeHGynQ7FE/+kvuyadCQHf6H7/383lu6KP03Ipfoa8mUIiHFr
         b3UA==
X-Gm-Message-State: AOJu0Yylt3KucKqunT4EjU7ymLgsUgJ23MmzqAusgQG3PTxU1PilZCwe
	/K91iLmSNk8vlNpTnLqeqa2bJeFqKaXDSTqk1UqsamomRBpRmcXAaV0Y3JlAZr0p9Zc7A9ZhXc8
	cZZD4/m87uITCMW8lZpANOJxZawonlK5ZGz3KBw==
X-Google-Smtp-Source: AGHT+IHnC8OABMnzxXq7v/L+d/1b3g83T0UGg9Qx3zA4qUFauCR/yg9IM8eJP2r42iRpZs8+qJcH6lLe8x6g8NJMOt8=
X-Received: by 2002:a67:fd8c:0:b0:469:c143:3d53 with SMTP id
 k12-20020a67fd8c000000b00469c1433d53mr37187vsq.26.1705913048867; Mon, 22 Jan
 2024 00:44:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104182034.61892-1-brgl@bgdev.pl>
In-Reply-To: <20240104182034.61892-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 09:43:58 +0100
Message-ID: <CAMRc=Mc3A-UV7x-YJUOU1zJQmDt-o5ckkbXWVM+trzesT3CaJQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: legacy: mark old interfaces as deprecated in kernel docs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 7:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We've recently had someone try to use of_get_named_gpio() in new code.
> Mark legacy interfaces as deprecated in kernel docs to avoid any
> confusion.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied.

Bart

