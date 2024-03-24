Return-Path: <linux-kernel+bounces-112824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA4887EB0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6055A1C20CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91078F9DA;
	Sun, 24 Mar 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn15ZB+G"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376CD2F0;
	Sun, 24 Mar 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308059; cv=none; b=KS0FljZKzrV3QphllArU/kVZ0fInSHwhDfnb5jgxEveUZdQCz4pxSDsGBXs3mFfsK8rRWgK9IIrMPfR48t7UEhSr44tOGTQnwYgjjff+Dy6ZuoDdbVi6MJYrvyjLJfwzGn9lz7y3LdWbpPDucG3ufXlq0P9NnS3J+g/RnZ5ih3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308059; c=relaxed/simple;
	bh=ec6zwogSWF/fNWpt7FhBFrY0oM7pYPI9+xA6DMEzQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8YlDnis9Ka48HgcDArM1Uw8hAPPXaQJkMHa0TDa3cNmWOnb6hJYKVKV9gQNUo7Iarcd8wduz9DPUHfmKR8HtTtFpUdm0g8/pujIH3nQ1wGddB7l0vI3zN8TJOxxsaJ7wcneEKutz00WWwhL3PXG1qR5E6Fmk4xOZZYMJy1h7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn15ZB+G; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2582565276.1;
        Sun, 24 Mar 2024 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308057; x=1711912857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM41Gvbk/e8sGiRkw6qJG8CwCqLe6A3OEvT8If2DaWc=;
        b=Nn15ZB+GFEjAe2+7qHiYfU9Uczo0EduWDf4CHdb7C9LuwgTJxswaCb2oEelu3RMJ0S
         DPqfeR2hTly0kuKHpzfmNVy3khC19Mz3ZpK+AvBl1ZaUzN99o88fWEqz8NEBOaVLe1Jy
         3RsR52xjT/8wihgT46CgRNTSdfIfYu2eTfIea8oK5kely7ailb6Cm3U8czixtOQgxm/n
         ikbMQbxsLHHx0U2eQlE9Umh/qr8+861WoqUf2J42ln6U5QPtp+GVBUM+/Zlp1qqPZnYs
         hV2pv6rV1ezbHXJ1lOKWBxcuut9pcMzQSA8VxFvDVxRinMPzNxu3vVeeZhWnOmzSY/zE
         MbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308057; x=1711912857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM41Gvbk/e8sGiRkw6qJG8CwCqLe6A3OEvT8If2DaWc=;
        b=ri2mvKxagvO22f3wJaHVHmab0T+ONIQdK8moHNLVjLQprmGKwzYRVLpNFUKdX4x3S5
         LrrmxTFERsSg/jqah7Ia+Bv8qCp3IpRTSWb2A+UzmpOtW9bdZ6gaSoz+N6jtSuB6JRDJ
         RSbjPGyV6lnrJaO1dZuone7hLyRFgMmzjyzDXqqq/tSkq8VfMhT9wF2gSkBbifH3kBOB
         mbKKQT8zgxKvli+js2+ghRmhGjq1IoNf+D2y0uMyEtUXDB/WzUhp9uheeL9xMG7TQlFf
         ZVbtYx4oI1qSko9QZw6huxR2X+jqqpK5CverZJBQWWC+ewlR9PP+Kc7NfmW1S6pBZvAd
         fSdw==
X-Forwarded-Encrypted: i=1; AJvYcCVYYG0YougOlxMqlovvnP7NMjh1F/LZF7r7pbKIY8iwdkbVAgQ5qUOnQpt1xxnv3Uga90YI8wCHNlcQi0l+MoDzba+y5BFDL3n0ob2eNbs+E+S+zT1q0fBZTic237MFg47ybVAHHAEHHX11IUubEMpttZMdDANnYCVELXVgpKRQoUHcFw==
X-Gm-Message-State: AOJu0Yw5A/25xr5ly1CYUvPNs7s0FT9k+9Gq8qbUQoMdD2yjvGCB+7q2
	no+zwp/AuS9XVHhyZOTaIc0QoPqdXjuJUoZzx4ERzw8B2Y89zMHLY9UyVMZ252GOpXH5n73XPza
	1zky14wLGnYv9a7QwsBsDd2mWY0o=
X-Google-Smtp-Source: AGHT+IFqS2ZrdA2FD6/G+AAuimC5bFbLStYreahpfIPEM7iKtBZgsTv3B+AHsdqSrVywsyX/zsswbjSc0Ql17Gj6gmI=
X-Received: by 2002:a5b:74c:0:b0:dc6:c2b2:c039 with SMTP id
 s12-20020a5b074c000000b00dc6c2b2c039mr3588945ybq.41.1711308057020; Sun, 24
 Mar 2024 12:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323122030.21800-1-l.rubusch@gmail.com> <20240324133941.26814432@jic23-huawei>
In-Reply-To: <20240324133941.26814432@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 24 Mar 2024 20:20:21 +0100
Message-ID: <CAFXKEHbvdQoqyirUC8ueihfTcCs7m5CViP27S1sNDA0VerUVYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] iio: accel: adxl345: Add spi-3wire feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 23 Mar 2024 12:20:24 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Pass a function setup() as pointer from SPI/I2C specific modules
> > to the core module. Implement setup() to pass the spi-3wire bus
> > option, if declared in the device-tree.
> >
> > In the core module, then update data_format register
> > configuration bits instead of overwriting it. The changes allow
> > to remove a data_range field, remove I2C and SPI redundant info
> > instances and replace them by a common info array instance.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> That patch break up seems reasonable (one minor request for a split
> in the relevant patch), but normal convention would be do do
> refactoring first, then functionality at the end. Also removal stuff
> and group, before adding things.
>
> So roughly speaking reorder as
>
> >   iio: accel: adxl345: Make data_format obsolete
> >   iio: accel: adxl345: Remove single info instances
> >   iio: accel: adxl345: Group bus configuration
> >   dt-bindings: iio: accel: adxl345: Add spi-3wire
> >   iio: accel: adxl345: Pass function pointer to core
> >   iio: accel: adxl345: Add the spi-3wire
>

Ok. If I split "Group bus configuration" into the grouping of the
indio_dev in the probe() and adding a comment to the core's probe(), I
will end up with something like this:

$ git log --oneline --reverse
 iio: accel: adxl345: Make data_range obsolete
 iio: accel: adxl345: Group bus configuration
 iio: accel: adxl345: Move defines to header <--- new
 dt-bindings: iio: accel: adxl345: Add spi-3wire
 iio: accel: adxl345: Pass function pointer to core
 iio: accel: adxl345: Add comment to probe  <--- new after split
 iio: accel: adxl345: Add spi-3wire option

I feel I have to add the comment after adding the passed function
pointer. Bascially I liked to add a comment mentioning especially the
new function pointer there. So, although being a comment, the commit
will be in this "high" position. Is this ok, or am I doing something
wrong? Should I split into setting the comment first, then inside
"Pass function pointer.." also update the comment?

