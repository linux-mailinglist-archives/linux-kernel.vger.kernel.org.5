Return-Path: <linux-kernel+bounces-26189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92682DC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF88B21531
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0A1775A;
	Mon, 15 Jan 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="NibfqV5Y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC01774A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e8004628dso4440145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1705333578; x=1705938378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yJEZxzOzncv1QTVfRspOT86NVOhhPss/crA1KTOsfTg=;
        b=NibfqV5Yfxu4BAV7W0H7G2cYqD5BOWLMs92JqjnvG9fTpD01sD4S6vMxk+hoODu/t1
         XlJUr5ByeoYQLRrdDzfLjH+F6gpOMVQkU+wpahr6IwT2VcNiDJlu/M4QLSseHPJtqUzG
         LJU3wgFUFWSyLyGBnoDcb6SQpkasMNU3OVJc/Jv0B5JLmM3zi8SkStNYSR/vVqRKOq9S
         K1YaYM/waZUGfycXPEqKmgMCPu3MmDA7oKdUgRd3eew3lyt/4glxJGEPzR31eCW7eOZO
         DkYmgmFf/UDz/djkj3UtZJe+olIvXRWQmfyoPOslkUqOL5bhrRAUrJ7YHPuRHCrL9ah8
         8PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333578; x=1705938378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJEZxzOzncv1QTVfRspOT86NVOhhPss/crA1KTOsfTg=;
        b=aC5fYoNyRt+VkpVktIcNZ7bURHLuE3da7JKEa3Ue2za5TTawDTQtTPLARvk89c/63a
         8q7qngcSrPaI4TgwD3kCWZEv9t9l6X4eSboPV0qHeHLNVYHmfclm+iX46rKhlJdH9Pwi
         bOpz7/aLuzK2dHYFYUqWaxDD84ndJtqZ8URv4rfPSFb9gkGF9MfKi6/kqlx+BtDyNGY4
         +1LzcZY0lD2HqKDD0SA4GTth9RWRw5zX2G2DIxm/EAg9q+h7haMemEoNv5k+GXq664LX
         /PE/J0GlaiRuITW4dqVPDR8R3+3/sz9EPmKyXOTSsXx/+FC+7f4A3hp7dh4/v3YrHz41
         0asQ==
X-Gm-Message-State: AOJu0Yx893ILHbe3DVyLhc1pzPQdln6uqR0UBgxeCApsFrSbwM0bxLWi
	iqrnxYI4owUoIQpxgvg5qn0jbtbNaiK9Dg==
X-Google-Smtp-Source: AGHT+IE4Dm6sXrNHWBvvv49O1+4ZjHQ+czCsBSqDjST+9zXk1PRfk8HFLb751anMBW37+qKALcDaAQ==
X-Received: by 2002:a05:600c:3111:b0:40d:8794:8535 with SMTP id g17-20020a05600c311100b0040d87948535mr2962745wmo.160.1705333578032;
        Mon, 15 Jan 2024 07:46:18 -0800 (PST)
Received: from electron.fritz.box ([2a0a:a549:33a5:0:44e2:8957:612:a313])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040e77ce8768sm4450228wmr.16.2024.01.15.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:46:17 -0800 (PST)
Message-ID: <20be7b9d5b8c0bef2a35da3d207c15eae75bfd4d.camel@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
From: Antonios Salios <antonios@mwa.re>
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Deepa Dinamani <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Henrik Weinstock <jan@mwa.re>, Lukas
	=?ISO-8859-1?Q?J=FCnger?=
	 <lukas@mwa.re>
Date: Mon, 15 Jan 2024 16:46:16 +0100
In-Reply-To: <caa041d27b0fa45aad09a9a262038e3ae4099ca2.camel@mwa.re>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
	 <ZYEFCHBC75rjCE0n@google.com>
	 <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
	 <491250ba57be2ab983048ffcf5ffd2aec2bedb9e.camel@mwa.re>
	 <1a528414-f193-4ac0-a911-af426bb48d64@app.fastmail.com>
	 <caa041d27b0fa45aad09a9a262038e3ae4099ca2.camel@mwa.re>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 14:38 +0100, Antonios Salios wrote:
> On Thu, 2023-12-21 at 12:28 +0000, Arnd Bergmann wrote:
> > On Thu, Dec 21, 2023, at 08:56, Antonios Salios wrote:
> > > On Tue, 2023-12-19 at 13:53 +0000, Arnd Bergmann wrote:
> > > > On Tue, Dec 19, 2023, at 02:50, Dmitry Torokhov wrote:
> >=20
> > I don't know what __TIMESIZE is, this is not part of the kernel ABI
> > as far as I can tell. __USE_TIME_BITS64 should be set by any 32-bit
> > architecture if the C library defines a 64-bit time_t, otherwise
> > the
> > kernel headers have no way of picking the correct definitions based
> > on preprocessor logic.
>=20
> Okay, I agree that this might be a libc problem then. I'll ask the
> glibc maintainers.
>=20

According to a glibc maintainer, __USE_TIME_BITS64 is not set on
architectures that use 64-bit time_t as default such as riscv32.
This can also be seen here [1].

Perhaps the kernel header needs to check the size of time_t in some
other way?

[1]
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/li=
nux/features-time64.h;hb=3Dglibc-2.37

--=20
Antonios Salios
Software Engineer

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

