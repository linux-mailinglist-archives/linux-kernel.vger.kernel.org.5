Return-Path: <linux-kernel+bounces-75571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9285EB35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE97287D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D589128394;
	Wed, 21 Feb 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmgKXD4Q"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A1128817
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551970; cv=none; b=M4juUwm25JmeuftaoE6dUKHQFZUq7mnG22uBxxfHfggUYCKjFC72vcN0q/yVv9+dWHl/ETYSz3kQLmD1fUIlRsg1WumRBrB2N5/XyFDtOiks0uS9Fzhn8Glm3YyTQ9hr/BfqJv/SBIh751Aq5pRh0DPHap/cMZ9EdgIEe9ETxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551970; c=relaxed/simple;
	bh=ApJiKKxB8Nyth68y0DtWmEyhbZzJmJ7hb4rk78a9X3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMrLaKx5eDBwsI/5AJ5OCxNRpjW3j49GKYks3mOK4SsB1nM0KHtJFckbMOlvFVnqcUUwr6w6rfWEZGe1cDv4mX+Y9GVB01hsbibHpXLjNIoO9T5eh+dJxUMeHrKT4KNRVQcOTNqIR7PiSfRmzpjq2dzRkVf+yo+x352D6zTQ8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmgKXD4Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607f8482b88so55755967b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708551968; x=1709156768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApJiKKxB8Nyth68y0DtWmEyhbZzJmJ7hb4rk78a9X3k=;
        b=ZmgKXD4QqBpUGTTOaClU1KEg7SESooeNJvUqz50ldEDb4DMDj07do5q5ckq6e76baV
         iH9JC9m2Li2u9fAg06XwUavptLrozxORGEzzgfD7YUb+v31o6VCO83OO/K/Bi4K48sLj
         Egyd4CB0D5zQ7oYdy8RhbR+5G2oOGDW89oFHNPJXeaEgJJxAqzmkuITnTFLyIlRGwzfA
         RahxWx6l0DBmwHAifjfNhlqUIPWj3zX2bpwVghKKPzkQFag7VcK+iMcDEsRN/nBpHbN8
         VunW2vcpAnHmZJCTdIfW6RBmI/EmU6yEc0GzHH8Jt45IBZhaEGr0qCVsXxjSga/Ic11M
         njnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551968; x=1709156768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApJiKKxB8Nyth68y0DtWmEyhbZzJmJ7hb4rk78a9X3k=;
        b=FkhbHgS9DdmRDUtNIJy+ggRje8BDGPqE2g0/qMRoQCuCnXjvxOsAn/GAHEHFyY2Au/
         lPkqtyrTGqA+EYOJbEDJAn9/6+qMtmzr5DNOjP2/EX72s43uiIBc8uGg/sPi3CSXalDx
         XcehkjZUgPbAl9Q3RHwgBKYsc1qDLkVnp0aa0phTdDzdFrkPRuApgLiruOVXlj1emUCa
         tKGj6t6JOqN3D0ahRGk6tl7L6OiBH1zV3H6hg8D0/ZqLwjgjeCO7K6JheYqJxjIOoCRJ
         Jv4Rs745yVHTguDDlmlMZ7NoAYr/cjcRp9DX4ZPTUlcd0SzX+pDfyci9OymS3HyQnNEL
         AIqw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdWyd+RlPJADzYbxPPdIZi+1tF6l4N/DmjxG+cUC/T7MUFNY/bpGJBmPxbiCPiha/eyeZt4WO72P+kAbHUQB7GvLEzD+nSasNV7j1
X-Gm-Message-State: AOJu0YxgGHdDhswjVuAFnibR5OR1LVyhFO6IK+psiUp9hq0ENid3lQEs
	PH/Oy/9l0AhOKFEc2vRdyZZJXiR32/n+lVrFI0HoqmtiBjEizSFKBDBuWeUQxK+aIRYcKkANDqI
	oviSTZ6FXGszfxlgOYe1kjpUXcYfEK1YN1V50cQ==
X-Google-Smtp-Source: AGHT+IG35FL34FRkreasSN16iQ0A7ZizHlYBrbzNgWJgEIvCTWPg+r3aAeiuFzNZX9nNiJhrUEFDNT+VQtzT44Ma+pc=
X-Received: by 2002:a05:690c:82e:b0:604:b08c:348d with SMTP id
 by14-20020a05690c082e00b00604b08c348dmr17415466ywb.1.1708551967845; Wed, 21
 Feb 2024 13:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl> <4a08c610-c249-4b56-b09c-09e1fd07f723@paulmck-laptop>
 <CAMRc=McXr_3OD6Uf+PKD-wLQfJKJSWes3fh_ZD9fnrPyF9GoSQ@mail.gmail.com>
In-Reply-To: <CAMRc=McXr_3OD6Uf+PKD-wLQfJKJSWes3fh_ZD9fnrPyF9GoSQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:45:56 +0100
Message-ID: <CACRpkdZd0FVSee-PbNdW8+fmkvV802jS45xLk4Of8-+WseiZxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: paulmck@kernel.org, Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Unfortunately, it's hard to fix 15 years of technical debt. :(

If it's any consolation I didn't create this one technical debt on purpose.

The actual mistake creating it goes something like: /dev/gpiochipN files ar=
e
nice and we can clean up after a file handle is closed or terminated,
I wonder why people insist on using sysfs for so many things.

All the file semantics of handles going away by being used etc, that's
why sysfs is good. I was too inexperienced to understand that, or I would
have paid more attention...

Yet I think we ended up in a reasonable place.

Yours,
Linus Walleij

