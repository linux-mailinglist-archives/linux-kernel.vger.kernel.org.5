Return-Path: <linux-kernel+bounces-37669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1A83B360
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCCB1F239E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFA1350CF;
	Wed, 24 Jan 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFdr8iTK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE557C091;
	Wed, 24 Jan 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129762; cv=none; b=mK08f/5UMzz7yNL81xsHt3Ryp9TBp3i49WEYccu10ava4twZgggXU2Y02VRsiMNsJ4zjw2kDyt7ZVbdtgJrHGEdx+tI/doVspEd5qfYJLkyAsK6rZGO5snob0S3cugjZvbQ7UoDXQk8fykN3+LeIWKfvBXkc6RHlHoj45D66CRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129762; c=relaxed/simple;
	bh=EDHQeGWw2KK9XnP3e2EPmCu/YDjFEOll/3JQtrVan0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaVc6IzEP7IywzL8AjSFF2+SECq9d48k977xPSCP609gEKPOBd42NQIZO2wTR6bG29BmvpfD+RSofxjB6fdqpRgh4g/IP3KG6ner0EDWl/LmcIBpuniyXnqIMoMwiXxh1TMSSLoSC8M5copeEpAoZkAomsC/2DvRRPCAvv6vG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFdr8iTK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3150c9568bso61186566b.1;
        Wed, 24 Jan 2024 12:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129759; x=1706734559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDHQeGWw2KK9XnP3e2EPmCu/YDjFEOll/3JQtrVan0E=;
        b=FFdr8iTKRgrVaGxvwqvWG3s1BX6NX4JaxSC4g7oHwv9lC1mWF2UB/+aSCdkVDUYrbO
         f0wuoNaCmuLwhA73tarmdaYo1dAzGIipbVdQKlIAsPjETJYFwZoa30O4GW4nWvWdo/qj
         ximpkcYYdMLIC8rDu5YBngqBOpQm3XmazJU/BcIQCrq+Ly3w6wA9T9MzmMtGY1pUo5+u
         A4K0Fe9mQYM8EDRYeBW5BmEugRvDLirWVCh0bE4Ae1nPO18SaU5yuJNMylxKvBVdibHb
         S1TdFEQVaqcEHz7zMJTTnTzFIZgOwtfHLF1UE1RKFrsGLhVu4bGkHsZn4TiyTDohB/ml
         ITRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129759; x=1706734559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDHQeGWw2KK9XnP3e2EPmCu/YDjFEOll/3JQtrVan0E=;
        b=ct/0vL0klrNjEBOoS2BsqbNfxWTtZTxcqC8chjkASQNIJHjOfgBHKhT2cdg650kOeN
         aOL/jH5MdxOHDyiBykS7nj9VPXJekWDWCyhMWgI2SCleB7pouTcuvRBh2UnRBhkjrxQq
         WPzu4KGsLfAZg8Tf9omVOyucAqtS/nPZZR7Brlodss3uQe2zVej0149tkNRtZ6aYF9nH
         qOLXtp6pfDgrOo4EY3HQuozS214pdVrgvrGwtFFoxPk0t+dJZHt3tEM22mXb4xcKimCV
         OVN+3sG5lljJkZxVVXRapdtY9fqIuTp53AoMVkgs0CprFeDqT8uhKAZ1TBaUAak4Yei+
         kw4Q==
X-Gm-Message-State: AOJu0Yw+c8N0RuAE0YjbwHV2tsm3HdE80XuL5RP1WpQtQ7he7sM6KThu
	qciS8d6bxN1+guMX9A0/ojAwsUwZ7GFKuDQ0B4WAvscWqmh05ARFvIELyVcKe3zazsjEHikdszN
	5siKYD4ELvXGIgPLPLQVGvLXvWuE=
X-Google-Smtp-Source: AGHT+IERU1DA/JNy3wLWaxZmghF/4O+PYmGIT9ozpVlxL9VJhq6FopNrevl1H2VZzhjHBqoEvs9zzyKbU3FPk1vY6Pg=
X-Received: by 2002:a17:906:f8d4:b0:a23:7576:3552 with SMTP id
 lh20-20020a170906f8d400b00a2375763552mr778380ejb.45.1706129758888; Wed, 24
 Jan 2024 12:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com> <20240124153016.1541616-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124153016.1541616-5-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:55:22 +0200
Message-ID: <CAHp75Vd2EO97Tn1QapB+dSUhioZo23+6x49q+c5zJ5aAZWY85w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mfd: cs42l43: Add some missing dev_err_probes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use of dev_err_probe was missed in the i2c and sdw parts of the code,

We refer to the functions as func() even in the commit messages. It
makes it easier to distinguish that one talks about function and not,
e.g., variable. (It applies to all your commit messages where similar
is needed)

> update the missing parts.


--=20
With Best Regards,
Andy Shevchenko

