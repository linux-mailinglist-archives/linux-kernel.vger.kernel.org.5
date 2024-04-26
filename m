Return-Path: <linux-kernel+bounces-160335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E303D8B3C17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC122836DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9F14A4EE;
	Fri, 26 Apr 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agSlqEzn"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4B1DFFC;
	Fri, 26 Apr 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146927; cv=none; b=U5mq3GaMMO5GxkT2w4Uv/qpqRRZcQM0NNF2OlxOKY6lFYzJgqfvBHguOVbcPoObvKzjfytd//hJPtWlRirCb+Iy/++Ewl9o3rUnmCqc3fBadK7cQsxdy3QgzhD/QaqKAhOnccC6mBWFl6hzkYpdEmwOBc3UtE9LzoS4DAebfyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146927; c=relaxed/simple;
	bh=R552gqWNJHZn9L65Cyy8omEewrrApbUPGnkr7rZCQRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cm2TtdQtZwfTNdmZbaELh9L8jEeph6NRg29JUN1UhVbLseaANd0AIxWTbQU3TaLGIFoJfIW2JthaNdJ28Ckq35AUnkhTR7mUmf6TEhqPHVZq3/kqtUYAIfh8ckvr9ptdcOown3X3svo4IvRtqjZBzkWjs4qMDLmzM9akqkB6qaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agSlqEzn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a58872c07d8so615784866b.0;
        Fri, 26 Apr 2024 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714146924; x=1714751724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuLZ5h4UDTyIGwOk9Qx6MEQfh9GVeoIO6Zvp7oy1X30=;
        b=agSlqEzn2Oi0G/ioSsIRavibGHvURImrO0tGINDJitcyA1+/iIURtV/HGo6zDE4G6b
         8uXWO9p9+67+J9sBJaPjyL11dhxWDesTiqweFD9qlxqaTHAxT6cS6Y8BEamMpbAwycJ8
         CW2BQojQGY9nh+/uzNBSB85i/2sfqz3H1v+e1lTU9TZ7vNnWlfYk/y/By3917kELoPUc
         Hg/5xUZo7tiXlIkf6qDcbOi5wGsqbcfGM9qftzGbWs6aCIwJUGVzrJvUnFBC/YwhurkC
         eddOk0ORMoK4EBDAvSBPl3+FC9ftXbOL2jv6PfN+GSaEKyi7f7KGJ3BYdfJgV5wsgaKm
         wc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146924; x=1714751724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuLZ5h4UDTyIGwOk9Qx6MEQfh9GVeoIO6Zvp7oy1X30=;
        b=AZVhoXwtd5/UtzpYts6oLzigzcIdR73QdlGAxqExzM4ok0C7HmGSo41fDqHrEJ9UzF
         y1Ud1Ysp3nxEm0svNYc+2hUaxYaQ6BLJDLcV5Qbtxw+h5TVXp4ZLWXcVTham9peKt1FH
         uYkw6seUoouCe/KE19ltHP5lXpO8w7vEpf8uBminaNHHDOgG/S3pxoGNZyDoHhDKDVxT
         qLBrSA+AkNryOjIm61OyZfIbyrkvQ6lW8mYneYUw+x5Gfx/ibRGUxn0HOeBOYJD8Ba+J
         kzPwQKKyCigLXrGP9xfCyImnMBtVNJq+edJMoLxqEuId04vBhereiJvZdpQjyO1wKDxY
         eNGA==
X-Forwarded-Encrypted: i=1; AJvYcCWRUDyRxeIb4HXzykthGCJ7S/GYORO3lL0j66B19AXgqGOdj1lM67mi0OMPisYCK2Ew1pedN12zCTubb0WutWUhLBJ/LTgvtPXczIXwaYgZwxCV0qOPHrWbAMxOq3/FtDJ29kshG4K5jQ==
X-Gm-Message-State: AOJu0YyyxCk9B8KZtS2QWGKL1ssUwBG8s9zIStRAP6CaExWIiuKy8Rhh
	FthwdZDk4A1+UZpP/qqyTh2oa5fUCJM/Vu+3aZcJBA473b6USAby
X-Google-Smtp-Source: AGHT+IFj8fUr2cSimby0ODgwi6aNH+15SSzp6GftKON0Zrzpl9KfbD23xqMHzKHbC/gJf0xZhOMNrQ==
X-Received: by 2002:a17:906:7181:b0:a58:a4d2:372d with SMTP id h1-20020a170906718100b00a58a4d2372dmr2463265ejk.10.1714146923980;
        Fri, 26 Apr 2024 08:55:23 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b00a526a99ccecsm10655843ejd.42.2024.04.26.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:55:23 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject:
 Re: [PATCH v1 1/1] leds: sun50i-a100: Use match_string() helper to simplify
 the code
Date: Fri, 26 Apr 2024 17:55:22 +0200
Message-ID: <8403927.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <ZivMCljzog7z_SgZ@smile.fi.intel.com>
References:
 <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
 <3557566.iIbC2pHGDl@jernej-laptop> <ZivMCljzog7z_SgZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 26. april 2024 ob 17:45:14 GMT +2 je Andy Shevchenko napisal(a):
> On Fri, Apr 26, 2024 at 05:37:42PM +0200, Jernej =C5=A0krabec wrote:
> > Dne petek, 26. april 2024 ob 17:25:15 GMT +2 je Andy Shevchenko napisal=
(a):
>=20
> ...
>=20
> > > +		return dev_err_probe(dev, i, "Bad pixel format '%s'\n", format);
> >=20
> > I know that old code used dev_err_probe() without reason, but could you=
 change
> > it to ordinary dev_err()?
>=20
> First of all, it's out of scope of _this_ patch.
>=20
> > dev_err_probe() is useful only when return code could be -EPROBE_DEFER.
>=20
> This is simply not true. We are trying to have a uniform output in ->prob=
e()
> and even documentation for dev_err_probe() was changed long time ago to
> encourage using it for non deferred probe cases.
>=20
> > This is clearly not the case here.
>=20
> Is it a problem?

Sorry, I missed added note for non -EPROBE_DEFER cases.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



