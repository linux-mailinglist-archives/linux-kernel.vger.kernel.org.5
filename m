Return-Path: <linux-kernel+bounces-5342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F581899C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C21B236BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC01B29C;
	Tue, 19 Dec 2023 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrbHC6cv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256641A73C;
	Tue, 19 Dec 2023 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9f069e9b0so3656860a34.3;
        Tue, 19 Dec 2023 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702995473; x=1703600273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljrRBMnlh16OHGX7758wO6bL6cdZsS9ay9gaLHzUAb4=;
        b=RrbHC6cvTsuCgONTCFv/aDoXxavfQX6QFCSqEqQq0h3GL3dMsfKp3zAowtrxniLCRF
         tlMU+sRnc60F9Zqa9hdkSB8CFKdVy4ujtz593SqPN3jbjMMjZYvbxjsiDvraEGJO9A0z
         8rdyJGAyqKjS5IxDUweKEBdR7YvHVY7RnxDIiI17O6dG3lbRSjXiZ1v/2dmLU3vEeFmP
         ZUALfkaoUI5uKWbrZNGGyH4OdNg+AYQppOR1ThYXZPC2sBMes4jcFct2ty3hsFEBna0g
         c+Oq2byy5DYf1YXSapbtFG0gYdyd+A0m2nNCp8ch/SyqTcsw07CzCJXJUhfg3XpTYNxb
         lC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995473; x=1703600273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljrRBMnlh16OHGX7758wO6bL6cdZsS9ay9gaLHzUAb4=;
        b=LIzCiG0nCkJEhRYWuvAmyPDvvve1Sl092bMKZPzb3nR8jECKHn5Fo917OJDsMd+iOj
         W5PEEQ7uQ02RG4qP/0eo60IyRFEm/Wt+gQ5h6PAT2T4hl/vSz3bGDR6KJVxhLqA3b00Y
         Ybq9AQaH3qZeFdJ3Slri0RkPCXZR/7nNW45iMPkLyi71H97AqVOsnXt6RLda71ZEsUOQ
         E1W1hBuQiet5TNPyZ2ubESszOu85AAwIo1YtjuZZx9dMc49W7Og64BWdZOWlcbSYB+jE
         +LnG4EpxeRjSprVs1JYt5q+bEBbFOEt0wos1LcLoQleWGZW+NG4jSxPp8jP3gR0an8kU
         7PJA==
X-Gm-Message-State: AOJu0YwaLyZoecfKW9l561D5CqXKoETLVE1oA/9+UI5AZVLWYZiLV3Mu
	DSziWMEm/PNScI4omGS5FWcIDJEnrR+kl22s/dQ=
X-Google-Smtp-Source: AGHT+IE0rG9seHB58w6n7hrtXZhdhRpo5fgXrjXWSA1QE2ETljm/UhcFW6RCsor8X9EVQPUcQ4z5JqmktWX2RHbX5/s=
X-Received: by 2002:a05:6358:339e:b0:172:8a22:9df5 with SMTP id
 i30-20020a056358339e00b001728a229df5mr12315536rwd.24.1702995472972; Tue, 19
 Dec 2023 06:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219013751.20386-1-xiongxin@kylinos.cn> <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
In-Reply-To: <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 16:17:16 +0200
Message-ID: <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
To: Serge Semin <fancer.lancer@gmail.com>
Cc: xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:14=E2=80=AFAM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
> On Tue, Dec 19, 2023 at 09:37:51AM +0800, xiongxin wrote:

...

> Also note all the tags you've already got must be preserved on the
> next patch revisions. One more time:

> Acked-by: Serge Semin <fancer.lancer@gmail.com>

I recommend using `b4` for that.

it harvests tags from the email thread, so no need to care about
possible misses.

--=20
With Best Regards,
Andy Shevchenko

