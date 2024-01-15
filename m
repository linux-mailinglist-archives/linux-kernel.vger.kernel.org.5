Return-Path: <linux-kernel+bounces-25578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BC82D2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2D1281558
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC415C4;
	Mon, 15 Jan 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bat/l75Y"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42890137C;
	Mon, 15 Jan 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55956ca6e4dso300894a12.1;
        Sun, 14 Jan 2024 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705281645; x=1705886445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSQyV00wQ85s4kXvZGL8rknI1QXxX9VbxwjY9ciBx4M=;
        b=bat/l75Y817lhjKn+nWeRhjQst0V3tzW4X7qRRTgbjWIae+/iLAiyfXOP28cnTiepE
         417f825AXm7ExODojvyF5mZGOhXWE5jw9P58PeYipWx51iq3+KKmlJAlf91z/4uOAiOZ
         H53Jc7UQl9EaR/MDXBEBzeR0MWyaF7hdffw+/s/Ca6x8KFphh1iZj+Vi0Ney9GaUXmHJ
         9bJgIah6Cj9oJb+hrt4h0YMSfOib6XJUC1yokjgdMdmKmWQr3zGTePyund3BF1Fal7ZD
         GM028STKOHCfkUVwuGtufBtitIysNDzdMDQcsnm3DwLqH4zvBkjrXI4pSp/23we4WvjK
         +UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705281645; x=1705886445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSQyV00wQ85s4kXvZGL8rknI1QXxX9VbxwjY9ciBx4M=;
        b=hbpQ2CHrqD2J6yUSdJon6k74OotC7xMiklWhkOzJkxRqBJG0dbK2aizc/UtJZQHBIx
         hbV5s1Ta4aKAYh4iJIcI0sJd8I4Er7grQwEkqW9KL2dA7I/YTadg+8m4lTLUqy5DQzen
         MP/L+GzcacSEBL99HyL0ttdcJaHvwWKWGWE+/E5NIBSWU0NYlJdOKvN1veVunprkkUn7
         2WkaQgZPP9f6NvZPfHQiJ8rZUrk7df39zRPwxdmeoiiPnGgo8w2gBwkaWle8GOn6Q2mL
         XxC6/JOncQu+cdrsmoj4P86EkOFcXTyv+SrcMfH36Qa/nLyMVFnRTZtv2VnhgEKYIvcA
         y2dw==
X-Gm-Message-State: AOJu0YyLdVs4mwryvvqyiiTI67JeHGxEuIPD3jhFUqUZiINGCrkyfLeH
	aCHue6vramM12AIIevqToKWWWiK4pJGoEyh4vWU=
X-Google-Smtp-Source: AGHT+IGEOk7rim+3D5orb8+7R2RKKnvLvUmoc3lhcz7wXUIVgZsP2NTTYJAxSiJXri0b/qrihRXqLebLWCkJSVB2D+s=
X-Received: by 2002:a17:907:bc3:b0:a28:c8bd:2592 with SMTP id
 ez3-20020a1709070bc300b00a28c8bd2592mr3628351ejc.54.1705281645215; Sun, 14
 Jan 2024 17:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115004847.22369-1-warthog618@gmail.com> <20240115004847.22369-10-warthog618@gmail.com>
In-Reply-To: <20240115004847.22369-10-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jan 2024 03:20:08 +0200
Message-ID: <CAHp75VccZmEVLWkGYZGGYbsGsvfWzPs3ERiABEV1CF3+TLUcOw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Documentation: gpio: move gpio-mockup into
 obsolete section
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:50=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> The gpio-mockup has been obsoleted by the gpio-sim, so relocate its
> documentation into the obsolete section of the admin-guide book.

..

>      Character Device Userspace API (v1) <../../userspace-api/gpio/charde=
v_v1>
>      Sysfs Interface <../../userspace-api/gpio/sysfs>
> +    Mockup Testing Module <gpio-mockup>

Not because of the alphabetical ordering, but
historically/semantically shouldn't this be in between?
(I'm fine with either way, just asking)

--=20
With Best Regards,
Andy Shevchenko

