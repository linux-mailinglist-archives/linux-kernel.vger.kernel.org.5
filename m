Return-Path: <linux-kernel+bounces-65268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A845E854A64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A691C209CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34854F82;
	Wed, 14 Feb 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pRFGKv/B"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDA54BE3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916951; cv=none; b=B9VP35upw09DEYXpRvhcrN/Sq7MYT8Zjy5fn6FJVpqhZLmS9Hrg5ohfUR32Fnzo39ekxx8tVGPAdo/mfBCLWcJSnZPVw9L7o0jI7EggBJFvuWI/TWAvf10WHnX47WYMvCBn8LtPe7NFVte9MZcA9pAvbR8Y4fyB2TvourEUt/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916951; c=relaxed/simple;
	bh=JIIHujTmuNmPvcv5WrQT88yXfMgmxMBanVLER3dOT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja/+fZANUAI8n3Fkwy+7LEJG5tlEpSrnTyjKBdGxl2+9q9BgR4LJVZtlXKkX/sRjwnU+O7JBApyAqyBqCAkO4r2XSTun3xjCn+JkHrlvkvpQQSGL1LLaXCkk1IgTgu4URO6nwMircu73UtWbBCcnPOrSqN72IGkFfEoGgqN58xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pRFGKv/B; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso2657155241.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707916949; x=1708521749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjBEKrgeEwXWHoh08s3OWJBUnSrSJdPA6Ijs0tf9KrU=;
        b=pRFGKv/BYk4sEjL78sHr60Or1CfUcbg0xhbn62q8GDSEr/v5O5ZzrfODmKMrX+AZTi
         eSnh51HSjSjAEmRNO1rKVFgtIQZ8a7DS9NWWx7FQDPrvLt2DFs2C01RFtQjkf2I4BDug
         ttT5pjY/F04llJnUs55u2b+qEdHZui+cBqZEv4yKfMbzsRxC+HLJBBpADQIXGjLVw/P8
         //VYoW3IMmQDgphY049e+RiiIpaEKkqMHZV3vFS6U7yBET+c3Nu1D+pooWMYXkJpmwC6
         h7MWM5nncT0hC/4qrPO3IU9q0YONuuCvrtvH51BO1r3kBNTlCTsvm3HVQB9AUWkxsSgH
         DMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707916949; x=1708521749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjBEKrgeEwXWHoh08s3OWJBUnSrSJdPA6Ijs0tf9KrU=;
        b=BJ1m2HdgsmyHfPd1R65iRw8gDwrNtz1mzmdc5yyjL3uTRA/EFESOJ6fAmCm8Gea+Ih
         Gf0Vk98REY+VlAPhBDVEaAnGoOpxdu8TRJaABLtm5OgFxSzZqgZg+yDuVtS6meHQDKOs
         /v210/klMtgJindIJIGULzf++mq4/AELw2XbUCG5JZuiEwH7i/eBXm/j0OMf2uLtE34+
         6XQL5+etWfC7AC3pAbNjLWuus4fPPf3wrMCUCPDXFzS6JoXkKkTajGYLIwoNPu5QkNOR
         AXlkRMKtq7zr+CHNSW538gDanRuje9mOZJqTFWQIofbG2pkgdpXg3FC3tn7iJY5tp4Ol
         FaRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwcmikZ/dH+D6dPhntHXuU92SdP4CD8h9tBZF1ZGYdXpY85Mn/09MnMCR+5fEzVLjIr8LnDz9SESWQfzLNtK+RRcsxeVK+MyPecUrD
X-Gm-Message-State: AOJu0YwNOG3AuHo8T5Re2VzJberqxDZtqYzILHYh4UBoAoeCsbgct1MD
	e5Tizb7Wuw76REYyucuSXQ9NwaV2HQMxtHmK/NvDRX+j7ygfrMPIdeFEAqXg7ZNkQR2oeP8HC1Y
	157tIW7aKbcjDBq4n0+NiNKG+RygJChtd645CWQ==
X-Google-Smtp-Source: AGHT+IEFGq1RRcXIagmX2nBK9C31e7Sglnc1k31By4l7faAODo93O6gnyZPFsYIDmKxmovbracfFaZpE2jFQTyt49iE=
X-Received: by 2002:a67:f61a:0:b0:46e:d8b5:a186 with SMTP id
 k26-20020a67f61a000000b0046ed8b5a186mr2554485vso.11.1707916948940; Wed, 14
 Feb 2024 05:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214084419.6194-1-brgl@bgdev.pl> <4c629a0b-95ff-4ad6-af04-61b25d437f89@sirena.org.uk>
In-Reply-To: <4c629a0b-95ff-4ad6-af04-61b25d437f89@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Feb 2024 14:22:17 +0100
Message-ID: <CAMRc=MejLVegawqZWiG5bhEA5pusvbW-OOrT-ij9h4GZDMgf2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa@the-dreams.de>, Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:17=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are four fixes to some bugs in recent SRCU changes. The first one =
fixes
> > an actual race condition. The other three just make lockdep happy.
>
> This doesn't fix the issue I reported yesterday when applied on top of
> today's next:
>
>    https://lava.sirena.org.uk/scheduler/job/585469
>
> [    1.995518] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000078
>
> ...
>
> [    2.176162] Call trace:
> [    2.178610]  check_init_srcu_struct+0x1c/0xa0
> [    2.182974]  synchronize_srcu+0x1c/0x100
> [    2.186904]  gpiod_request_commit+0xec/0x1e0
> [    2.191183]  gpiochip_request_own_desc+0x58/0x124
> [    2.195894]  gpiod_hog+0x114/0x1b4
> [    2.199305]  of_gpiochip_add+0x208/0x370
> [    2.203232]  gpiochip_add_data_with_key+0x71c/0xf10
> [    2.208117]  devm_gpiochip_add_data_with_key+0x30/0x7c
> [    2.213261]  mxc_gpio_probe+0x208/0x4b0

No, the fix for this issue is in my tree as commit ba5c5effe02c
("gpio: initialize descriptor SRCU structure before adding OF-based
chips"). These are mostly fixes for lockdep warnings.

Bart

