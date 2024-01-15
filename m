Return-Path: <linux-kernel+bounces-25708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC682D4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C3B1F218EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8725380;
	Mon, 15 Jan 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvnP0Qvk"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BF440A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f70c085d64so69962637b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705306012; x=1705910812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywYykjDVyDnhqbLmXPItjXd9rDMfaLAcvVbMcZlWrMc=;
        b=qvnP0QvkzWtxmFT4sJm+qrZ1oTqFFwj3e7eNb3a0BDycCCpMd3sthK5EywcEIvvY1d
         AI9F7q3WaAKYXclJcHXZUAVWeIKYZABJA3edn/AoQDFhWYfcrhw2EswchiJKmNGHs2TO
         aQ9S9iQ48a6tBRcWfN6SrstQg4d0UsA/TOZY8gUK4yAea0WoNg0DqxXDzvjJMSQI9KQH
         nbecYPt549M7zvNZql4m+VOUJcN8B0c4j0YMDEx8lqKCs5Vs6hROUX3/Io4pdJpNMOdO
         ym4H+MR5I5E+U4FxalmT1i9IQkf3iyynZSa2VBRw0JNLR3K+M7/EOWSMrwsH0ktlOd7t
         GuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306012; x=1705910812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywYykjDVyDnhqbLmXPItjXd9rDMfaLAcvVbMcZlWrMc=;
        b=w33MWC0OdcrRtH6NttxkOPj9nP+16YSfoBAkEA2ekRp3dWTz8BpLmecGXAVZHyYALF
         gbUPmd7z0QKHRW+AEKv4UMt1D7sOAaW7rLjXE/92l8TcE/araJvnkifjOrRZetxtZlZS
         Sfi0vWCPvDiXmvuyBLaDV/UpqYO0PPpnwjRGp1/5yKSaVWwd0/5fka33wPXiC4Qsg+Ln
         9cMveTM7bJIg3mzEZgU96uq8x9GkSFz52zs2zRu4rsx+iQhuZj6Uvv7RJlkf0ynDJiMt
         BUt4apJj7zf+KjjN1fNbAT5wuzdt9OXlHxXtq7j3XSlOWki+Hh5TqpDQCjMvn3L5A7Bd
         Kqxw==
X-Gm-Message-State: AOJu0Yyc8l1kJInASbGXlGYhK8c0W1FQyZ97+DgI5/9r1HaIsRHB/UPi
	OizBklDAPSU8r2+r6cQBp0eMzPJPW0HKsDjn2Evx35hcbnfSkg==
X-Google-Smtp-Source: AGHT+IEgxY63K6dbPNqe5t5aKdNJqQSwAdV8H18tEikus5hYJB5ntbSFPEOJ/eSEo3wY99CHUxcx0Iz77QWl+1X7qYI=
X-Received: by 2002:a81:b3c8:0:b0:5f7:590b:cffd with SMTP id
 r191-20020a81b3c8000000b005f7590bcffdmr3657129ywh.72.1705306012083; Mon, 15
 Jan 2024 00:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115010117.8383-1-rdunlap@infradead.org>
In-Reply-To: <20240115010117.8383-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Jan 2024 09:06:40 +0100
Message-ID: <CACRpkdZ16H==9RAtyy6ZxTvtjpm8e4pMtiN1TRNVrW8qNcyFwQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: db8500: remove kernel-doc notation from data
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@stericsson.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:01=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Don't mark data with a "/**" comment. kernel-doc does not support
> documenting data definitions. This change prevents a kernel-doc
> warning.
>
> db8500_thermal.c:27: warning: cannot understand function prototype: 'cons=
t unsigned long db8500_thermal_points[] =3D '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-pm@vger.kernel.org

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

