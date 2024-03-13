Return-Path: <linux-kernel+bounces-101234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A287A45F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB81F228C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB31B7E8;
	Wed, 13 Mar 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxVkhMvK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FD1B27A;
	Wed, 13 Mar 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320280; cv=none; b=HiMlqFtrPkyjen3+2Ax8iMYl6iaRBpzRdR2L70liY1BgVt3xEoFPJISr711MGcxR4gOn2hRX2qmrc2sDD6Ooigmzeua1SihA3B4d4XJOc/5hg0wIeASepUcE2gy7D1MVJW7qE/Tk7i28aT6zLxnQBqjWp/Ahp/sTy7B3jz1NoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320280; c=relaxed/simple;
	bh=s7+fgObpIOx6HshdN1tW6HAOi0pdOY42DQeJ2Strb4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrsVZoSD7+rToxEsMKFr7xBOyI+SOm30pwEFIDKogG8uSfd/ymYkTaiDbdrevm+NoYXZeo0EBE60ERvJwcO2mAoSI2zYzz0ccIkEtB9qc5TLSyi5lejgymSUZ4KnbutvZ9vJyyVdFWaPh6/ety9SZ/uJd2O2QXGMOLo0dXunj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxVkhMvK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso6761429a12.2;
        Wed, 13 Mar 2024 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320277; x=1710925077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOJUltz1jPa2YKWNkmxWqwgxi+jWLdkVr9/pG4YKEK0=;
        b=YxVkhMvKyBlpMlUcxT398ZpcMroJhtm+Kw0zW82aEJaTJ/Z4fDE5so1PvcbHqOAYlN
         1G5Ek3a0eH8jHr0VyzMQdRcBYg2EjbrvvHqcJnjL+Uqb6v9eYiaElqAzCtE9FVLyk0ol
         672Oj7UGcYLpdCwS4111MK/IBK6TeaDxeB5nQ96mVhk7KZIOatgujyeszzEjmOBj86gc
         v0PrlQm1q0lXBYJ+BgF2gywscpT2fiEoEVEVSwwM6AmSieCsGWwMm5GKPS/WewGJUb8t
         l3N/bhMgtUWBuktnZuVM6yf+LrDvzAGGzZIiwuMm/IAXS/pMMgJ72zEj1eTqYtJqrCyn
         jKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320277; x=1710925077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOJUltz1jPa2YKWNkmxWqwgxi+jWLdkVr9/pG4YKEK0=;
        b=xM9d8qw1f5p1RE7WkpAa8YFs75T+3zK82AtGgFg48J8Jw6PVFK5UO9CBIYx2n+X/4k
         JX1LE02Urn0DwYPeUmcFMBY43h9Ny0xQartfGp95rioUIHnpr3UQZZgmgFrjXug1ajTL
         UEruIXZQp1GEGykP6/5PDbIf8iDVm0xDMqomGXnoKd+UvuJVxkTOdvdaNK9FL/GtyCXN
         S0NnjZwz+YmM0ZtVvh8cCKiviziaEMws+SyiZMRcqUe/luoQPzn/1kTGupYc9+SF91Ya
         DdNLuqzSOsimykyeTWuxku2pXiBFqijXkneUVALmHwXzwCXj+FEI9J+2/rKiELyu21mI
         eqVA==
X-Forwarded-Encrypted: i=1; AJvYcCVRFK+hs4Mi93gCiWGW+JSHppjTmyYw0QVRSLil27TegIVfhQHyHvBqHZa7SrDWGzV+MQNTwqbM0dOdytAoSiaFXRxDIUy576ghmrolQpn/0JfI0y2HTbIvoX/+/IP1sJ9+NRYbwwcGrQ==
X-Gm-Message-State: AOJu0Yx59C9EYH3SZcQCuQ5t6UqSC9RcKqjCjnvGp4R3p5U/bTF8N2E4
	af5SzUb7ou06WoN4P6+R8iiqcFnRSkYqQ3hVfuvJ+xvIUBfDaxHUYELXjSwgV1i9Fa/vRa3zbQU
	uOZOHAWdgOlKeASAFuf4DohYqvUE=
X-Google-Smtp-Source: AGHT+IHuRq24Z6UPMOUOEbiiPZso+RBek3gYcWiaotlT4ZQE1rY1AdloFRWh00KZQ4p7D703LPjZh6G802XG5O2IdaQ=
X-Received: by 2002:a17:906:22cf:b0:a46:2b4d:e3f8 with SMTP id
 q15-20020a17090622cf00b00a462b4de3f8mr1652131eja.19.1710320277221; Wed, 13
 Mar 2024 01:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313081425.2634-1-xingtong_wu@163.com>
In-Reply-To: <20240313081425.2634-1-xingtong_wu@163.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Mar 2024 10:57:20 +0200
Message-ID: <CAHp75VeXTWiSvChTwm0BqSDxG0HmX4F0++oAO0ZpMbqDC3U6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Patch Resent: Enabling LED Support for Siemens IPC BX-59A
To: Xing Tong Wu <xingtong_wu@163.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Xing Tong Wu <xingtong.wu@siemens.com>, Gerd Haeussler <gerd.haeussler.ext@siemens.com>, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, Henning Schild <henning@hennsch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:15=E2=80=AFAM Xing Tong Wu <xingtong_wu@163.com>=
 wrote:
>
> From: Xing Tong Wu <xingtong.wu@siemens.com>
>
> This patch has been resent to incorporate the necessary changes for
> enabling LED control on the Siemens IPC BX-59A.

> Based on:
>  eccc489ef68d70cfdd850ba24933f1febbf2893e

Use --base parameter instead of this.

Note as well that a single patch doesn't require a cover letter.

--=20
With Best Regards,
Andy Shevchenko

