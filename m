Return-Path: <linux-kernel+bounces-2940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E4816504
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A227B1F212DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF326134;
	Mon, 18 Dec 2023 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAHbWKY8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091B440A;
	Mon, 18 Dec 2023 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e23a4df33so2149782e87.2;
        Sun, 17 Dec 2023 18:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702867443; x=1703472243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Z0YdFoXKobRPklUZUaPLQDZ6N1e0RWZ8GkPA3Z6Cw=;
        b=dAHbWKY8y42WblC5TdAM76RFO//68g34JTWRcJhJ+lnCneb36Ch8rtA5+eUGxH5fGU
         JM/2Bk7JwuXV1wC+XScGOSEirflZBSumP7xJo7PR290hUWUm2eh/4JClutbX9WqMeQEG
         i4rDb8e7I8P4jcU6DU3mj8sJVFCP3+K0+ZWxzrVzxrcNRSlpnISODx18oa+JvUy7bbYe
         XF6zro5f02irIcOiJ7g+4a3aTSYoOndwX7aq2EFvtA2qPQ0EOPhG7s+zZ8oFMDKgZxPX
         3OckxA52mLakIwkHlspwe2zy5YhXtmHCDjeCLm6geeW4pna38O7Tg+dk0DJlesYlt9nz
         qlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867443; x=1703472243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Z0YdFoXKobRPklUZUaPLQDZ6N1e0RWZ8GkPA3Z6Cw=;
        b=PsSQDOWOyh/Kl6ydPYj7Pcy4uqk1WtxaBW7CvTNFY98tqFU+CatM3+UvVZMnjA/i7R
         Dm9gNywcYriihqNHlF0EKo8O2bXLCuWOD7MXxhzkpnAO9PKrSXNwcbHZY/aeKWrfwYMW
         sRMJVxPCHuGqbqrPUw8CIUmglYaPgPmIAu8tx6jzZo2RURg1RChyXTCc4ivgRX+H2uOG
         ubD1Fn3oWvmAjf4dnVREVQWVaXxal8axPRGOkcnj1qK+iiWjF0TeP3zXMXq1K+zjMq6K
         lNMltpB6ltJCI4LrqLs0JqmmMDHUURV8DrujrOu3bouBYMUwxQ+MQuqYwdULY8KGpIDx
         6whA==
X-Gm-Message-State: AOJu0YxwhRj0RTOeQdJ9uXuT1lMmxD9Y8tjteL6H9Qc9r7c8JAhFWSdt
	Us6B1PbXyUzGpX1Jrgwyxxr7DQbriZhjdLZis1Q=
X-Google-Smtp-Source: AGHT+IFmazdQohWb855+eNoYKPzieuisdCcCVUvwLaEA8LxarAZC6ObJtAL07qXPwxeoKqqSIyqP5QCJV6Zu3Znpw7A=
X-Received: by 2002:ac2:43d9:0:b0:50e:23db:3d31 with SMTP id
 u25-20020ac243d9000000b0050e23db3d31mr1275113lfl.76.1702867442608; Sun, 17
 Dec 2023 18:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211160519.21254-1-potin.lai.pt@gmail.com>
 <20231211160519.21254-3-potin.lai.pt@gmail.com> <9abe3c01-f6ba-4791-9cf8-d73dfe44d899@roeck-us.net>
In-Reply-To: <9abe3c01-f6ba-4791-9cf8-d73dfe44d899@roeck-us.net>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 18 Dec 2023 10:43:51 +0800
Message-ID: <CAGfYmwXMHO7zYc0pzaexO4L5gXzCODEAd4Zxm8LmVL6USrrOwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp2856/mp2857 controller
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Peter Yin <peteryin.openbmc@gmail.com>, 
	Peter Yin <peter.yin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:33=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Tue, Dec 12, 2023 at 12:05:19AM +0800, Potin Lai wrote:
> > From: Peter Yin <peteryin.openbmc@gmail.com>
> >
> > Add support for mp2856/mp2857 device from Monolithic Power Systems, Inc=
.
> > (MPS) vendor. This is a dual-loop, digital, multi-phase,
> > modulation controller.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
>
> Applied, with reservations (because due to lack of datasheet it is all bu=
t
> impossible to validate the code) and several fixups. So this driver comes
> with even less warranty than usual.
>
> CHECK: Alignment should match open parenthesis
> #671: FILE: drivers/hwmon/pmbus/mp2856.c:413:
> +       memcpy(data->max_phases, mp2856_max_phases[data->chip_id],
> +               sizeof(data->max_phases));
>
> CHECK: Please don't use multiple blank lines
> #673: FILE: drivers/hwmon/pmbus/mp2856.c:415:
> +
> +
>
> CHECK: Please don't use multiple blank lines
> #707: FILE: drivers/hwmon/pmbus/mp2856.c:449:
> +
> +
>
> Fix those, and use i2c_get_match_data().
>
> _Please_ run your patches through checkpatch. The above is really
> completely unnecessary and creates unnecessary extra work for others (me)=
.
>
> Guenter

Apologies for missing the style check issue, I will add "--strict"
when running checkpatch.pl in future.
And thank you for fixing the mistakes and applying the driver.

Potin

