Return-Path: <linux-kernel+bounces-7164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBD81A281
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB94B2726B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17C3FE33;
	Wed, 20 Dec 2023 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W03/Qc6D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B047F5F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3222679276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703086092; x=1703690892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7gRsnGK/98vqBcsCXhR92alkXxNhTCIZpp/DaIxwxU=;
        b=W03/Qc6DiZ9M5AEqYCbf56BpRCY1qPSlkNH2IkrU2lC6zhIxQ3rHitPnk351jdBwp5
         zIz+FgtEM6Zt4HBwgGL2nT5dKWTdBS4ggVZp1RliG3Nplnb3s4LOc3+9jOST4cpiLDQB
         qSWQR1LmkSOvrJ973LuL22xik2cD9IroSPT199BhFBdotNP7ZfGdhRBprAK3herbLy62
         ZJe+utp/qyB3ReQkSOT5gV6D0uHd8cJLMfgCNY7TdcwQXvrTos62VnAl6eXYMPTJ0cju
         HW7w8pCkC8Hmp6m3rsV5MVqlyA/wuR8wUD6Q0OEnBd1s6VZ9H/a0f7G/McNQA0Ub+weg
         LMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703086092; x=1703690892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7gRsnGK/98vqBcsCXhR92alkXxNhTCIZpp/DaIxwxU=;
        b=nNjotn1Mhe1B1fUeOdBy3Nlga4Qk3wMg6iSf041Q8ncB0Bwtqo29FGe+Hx9ISo/gUH
         /c/grg4mRPqgOiWkgQovi7o7ErBITjfTRKiyo2veXWA8znD3M86gNSEDWCnO0rGab61c
         MI9IJXi9xsMdG5IrADOrmkhr07PBe8DFOGgOPnvPhO3Z7NtPjwVHQzo6y5/EzItLNRbs
         mz722Y6ih5j3bvlZB24aZWfwuauUMNiH/Oi4mz+YjHlWxpj/w/5CgYoBQOBGcUCTQ3H7
         3Iyb149kPRRqQ8cmfoErmmPIj24xSOuehWC6BX7035qgUYkOWeVmmEPuCiOz8Bv1b+IS
         a6/A==
X-Gm-Message-State: AOJu0YwqedjeCI/um/gVK4dSr0G6UHxX7ER1tJVvbk96/BeoPnJLp1ib
	NjqUZeDFYHkEpeCT5wjJ/Izyi3AHyDJnq5UyzNoRcA==
X-Google-Smtp-Source: AGHT+IHvLkJ6Yg8dTs7bidAxdL9xHex4/uIhS8hfLIfdr0GXHNzu4uRJv+qfme+slkFJoK416zFCj/8x8mLra8uNxak=
X-Received: by 2002:a25:ae1f:0:b0:dbc:d6ad:616c with SMTP id
 a31-20020a25ae1f000000b00dbcd6ad616cmr5779335ybj.24.1703086092356; Wed, 20
 Dec 2023 07:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219201102.41639-1-brgl@bgdev.pl> <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
In-Reply-To: <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 16:28:00 +0100
Message-ID: <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > extra_checks is only used in a few places. It also depends on
>
> > a non-standard DEBUG define one needs to add to the source file.
>
> Huh?!
>
> What then CONFIG_DEBUG_GPIO is about?

Yeah that is some helper DBrownell added because like me he could
never figure out how to pass -DDEBUG to a single file on the command
line and besides gpiolib is several files. I added the same to pinctrl
to get core debug messages.

I guess Bartosz means extra_checks is =3D=3D a non-standard DEBUG
define.

Yours,
Linus Walleij

