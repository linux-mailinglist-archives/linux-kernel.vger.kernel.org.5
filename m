Return-Path: <linux-kernel+bounces-166097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C288B962B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7C41C212DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF292C190;
	Thu,  2 May 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch5h/kyy"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7428DBC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637465; cv=none; b=JaTPIC2FczR/gi0esgbmowglMFHyKNSAN5FCi9F/l4tDc6xWPdJsCax0S+5kDE75KfKlRSk+VmclZQdtbnn8DyySKiw3BkdO9vg+dvwXqtY3jVHWztdspLlmF7CA8mEQTMO4EPRwK/JaXdeS7n9fPYFp9z50OBzl8NHSriT7HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637465; c=relaxed/simple;
	bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V21xd3A/gkIE3/ySlgSrP1GwCtONWF/uJPfFbdbjTLf6ZiiXC/xwHytui3GDyl3hcLGQ2hOitTGa+JwDC+NMAFXjxxP1+/q4tqHDyQtMUE7hWZW5k0f2kGAZSmDt3rXrGrzCrpWSkAQzw1QGvW6AYatEewziE/RbZTAKkQ5itRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ch5h/kyy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61bec6bab2bso27002607b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637463; x=1715242263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
        b=ch5h/kyylHh2JrLwyt0ns/RmnDlP9zGRCN7UFDSpQdAYuh35HElUpacFykwTGrfE/f
         Y/rydqbIxGfeRkn/uVd9bEXO0ZNUss4NWFGhRhXd9ukHQS1HT0sfhqWwIy5b6LlT0J25
         rRZA6MGv1smDetOF+9OzEp/Jrx+/GvGHKDbn/mh18bRljmuXTG8mcs0KmIz5MfPc9ito
         OTLmhYCVrDmP11UiiY8KWZ851m10ATgCPxngPavyQNtXRFUhWH05QOBQt5XJVVOo1y5T
         SMszRe14CYemMUGZWwA234oGNJKGrZND1pugCX0fwx+YbiIcJp7qvN8xXpraCaNqubVU
         wOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637463; x=1715242263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
        b=vjzyIZ67Efs1C/0Qg9N24k+DyNtY47Z1cKKPQhRfqa2GSwA24kTLEw8Mxm0iFQ3o4G
         gZK+VM8Vn5wWRF1ogDLsTdGvnl6KzG43LgxO2A3mz4R8LQ22mDOns/JifjCr4Y+UIDrR
         qOMBpjplQrP3jLhQGYHF6kw6Wug5SGiwZ2fsmvSBrUWK/WoMiyBrKczQ4kPpg16aQPc8
         OS54TIH8SLEqwJU6KFs2ps5jKm+oiPZSn2w826iBR2kNDF3on+ffCF/TjZGOCA75LkVJ
         ef+iEPyqSyJrYwgMopA7vg7KVK65UnOWGHtnIMnrQn5JZCKCTTRanVx7FKDltb16vH/K
         nQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUtDo4OmNZt/i9sDOzgzQS2er0jvJ6GH2Iiq6adxLXhSwxyLCCFTRd91a83io1sMITC3lPGOMq9fkYCujgULxNiVY2cN/uu6QPu0gAE
X-Gm-Message-State: AOJu0Yz45iuzvgl+LUpWT/HJhv1g73AfXG8tQf0H6q95kt41JmVnL2CX
	yez1UGBmlZdvqgdowmgofW2S4Z610u2ncmpARtD6QcdhJLW73xHFI0zsgXt5Xqcnc9IT/zXrWQO
	5Gj0wIkBUQ+GrgC84XtMLjalvrGpOw94XqKsacg==
X-Google-Smtp-Source: AGHT+IELqyMyqyzg09IrYvqrEqiCMUQniz6sembxGAS2bHsbIU4J3x4HWWEdOSmTklmyLQzOFUrRw0gCe4JHBOgAVy0=
X-Received: by 2002:a05:690c:e0f:b0:614:c76:26f1 with SMTP id
 cp15-20020a05690c0e0f00b006140c7626f1mr5701128ywb.21.1714637463127; Thu, 02
 May 2024 01:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-7-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:10:52 +0200
Message-ID: <CACRpkdbNk=yMO7m4O+FohxmB5eL5bMovskjU22JV__N4VhZL4Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] spi: pxa2xx: Drop struct pxa2xx_spi_chip
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> No more users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

