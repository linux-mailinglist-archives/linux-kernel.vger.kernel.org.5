Return-Path: <linux-kernel+bounces-61264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3B85101A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49C1B235FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532317BC7;
	Mon, 12 Feb 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9ZD9ecT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40018036;
	Mon, 12 Feb 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731732; cv=none; b=F1KspBZ1z30G7eBbQI6xxwZpzRqFMvwVIB5KOTMtrsNvi+/sy3C5T/lZdncBRjso0KdG6YrZ3P7aJGke9dvgCgMBddI2iE94nUV2FDes4szjrmBvvfWbB3c/EjsFNaI/tPdc8ssg0qdgrE2++udb1trww8/hu8YlrgkI+IIUooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731732; c=relaxed/simple;
	bh=uQq4CbKJxGMQSgFVkzKkkQfK2+8jYuus2rLp3fv1zug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzdl6arReAJexobZVbSOogb+lJSq9ajKO7DsWyrFfTKApjhRzNInkG0lW4ii2FO8AJ/LZurvwzx1jiW8PlZWFx99XtZz/2eJlFtfRGK8S+P/vmy4eOb0LchQcddaLiN8GdvLSRlVMeM3kMqTaxyKf1oAY2jsRSegueiu5l4VhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9ZD9ecT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso39952566b.1;
        Mon, 12 Feb 2024 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731729; x=1708336529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQq4CbKJxGMQSgFVkzKkkQfK2+8jYuus2rLp3fv1zug=;
        b=P9ZD9ecTGiBJ7MCB8CEJ7Uts8qZGZ4ZmCQtRCxoUeqsO71U04f5VNuZHWamWWP/vVS
         K5S5qWZt7JpeE/tneLyeHlCQN07TykoSKaaZHzHQpGObNXhjdxWgWyD7/x96wSz1vthP
         2/YqPn2dF6i/n31cEmEYx/s0NlfURQ4A9U4ES+6m8QPDZTC86WJgHizPPI5qRK5v1BIw
         0hmaGTi8U23JgFRVm9MQ2zor9/MJdx+QipU013dwQAbE9yZcOtGwP3kQV7NEKuVw7R4x
         S9YR4Krmh7lEmV75k6caXrhV8P0jo/NlJr388YQjbZ9ixyV2HIccCSsXpA6hObiak2/a
         NGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731729; x=1708336529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQq4CbKJxGMQSgFVkzKkkQfK2+8jYuus2rLp3fv1zug=;
        b=v+Z8il64U1ytqjqqGlZwYkAQiWV3mxb+fx/ofW3038KFPNId+Nj0gmrDnGj9IROw4l
         O11hDoBKE14htKI1iLjj1xhbYRDrCMnqr5pBXiH+o9DoKo+H2fM7KyPlgOcIVB8399Tj
         hDh/ZcgytpN5lAV0NwxHdChEgFzWEY7cYyHVNZ3xf9QsizajDJwiqnnioD0cOby4VlvH
         J29AD65EYN+WRO8U8Ltl2qVHC0FJBuJFlfhufMko8rWA71SYcoVdxtlRTlvaVMr+t4w6
         TxlksYhxx9A3B2THsTIi1NMuRV8IhfO2o6S2ReAUoO0crMQmj+vUn7iuFj20mjhLfqH+
         lvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXZV5tW6Olc8hG10cMRX6otD4c6mknb1SS31BhRw27fITtNQitv4N/jWlozVg/nVrw338lwXSqItMD2N3NTJvnM/u+t/wSCiQfci0isT/O+ea/+IOC9KrxGrLPBehIskYLgzZNLsg==
X-Gm-Message-State: AOJu0YwYW3SA13zqLfjtapmjy0LcbUiM935rOKtzoOjp/0pjJRVr1yrr
	rydq4gDtDkmXbcFXH4WpBB0QpRr1g7PSdhe6eRGzvPc8asl207kL+deDhv38/BbDQBd6vIBJpl+
	F2Hhq9J1gc/mGNojtpsiwrDH05VY=
X-Google-Smtp-Source: AGHT+IECAT/cXgpg8e5MpXFQXkt5GjHL2TMJTma0M0sqlzPQC4ZKAqwAO1dm0i4lzBQbQya00Eo2SAIeCbW5h+vbo5U=
X-Received: by 2002:a17:906:6849:b0:a3c:c8de:7a66 with SMTP id
 a9-20020a170906684900b00a3cc8de7a66mr684151ejs.13.1707731728539; Mon, 12 Feb
 2024 01:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212093420.381575-1-warthog618@gmail.com>
In-Reply-To: <20240212093420.381575-1-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:54:52 +0200
Message-ID: <CAHp75VezERVckBBuMV0SSTVQjz_UAJ3jUFv1N+ZLYn3va7aMgA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: clarify sysfs line values are logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:34=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> Clarify that line values are logical, not physical, by replacing high/low
> terminology with active/inactive.

For this
Reviewed-by: Andy Shevchenko <amdy.shevchenko@gmail.com>

But as I said there are much more...

--=20
With Best Regards,
Andy Shevchenko

