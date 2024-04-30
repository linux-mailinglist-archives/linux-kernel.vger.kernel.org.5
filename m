Return-Path: <linux-kernel+bounces-163947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A78B7671
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BC81C21050
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FC171E70;
	Tue, 30 Apr 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzlf4t4v"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5B17106E;
	Tue, 30 Apr 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481784; cv=none; b=cZpAlL7lH1AXZU+1Vyot8ni0Y7Jkf4fgaxpWQbTQPmviIafp1Bi+QJAxdX7zcA/1dtWdDZEOakYh0MWipGpSH3HTOvYkld8aGw/+sO/lLs8cKV+dkJD+QwUnqOMgUA43PSvjA8YA6Eni+xS2etSNGiMeHIIYhx8B24hMv0jlIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481784; c=relaxed/simple;
	bh=tEcbumoG8mFeFOR+Sn33r5OH+UDAizNlcDv3WNfEWC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/pkAAO/zl3wBeLHa9+Y+YlVlW53NBkNY2p6E6SgSy+ENyk0lK45YmgU/yOMR/26vljw+i5ldDeFGFqmDrJZbrvo6TdSR1oZ9tWdDhaAWOUlWfRIHDnMkh7TKSdSXC+fJ3oef0l7SrTlBSkCEQPFXILFOsirPrI0bIIDdznQmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzlf4t4v; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acfba298d5so2595745eaf.2;
        Tue, 30 Apr 2024 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481782; x=1715086582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEcbumoG8mFeFOR+Sn33r5OH+UDAizNlcDv3WNfEWC4=;
        b=Vzlf4t4vHK0aaSl3ENjTkxTGaK8luEjMxgqKpjB2GAp9Nu/zYSsnd6LxUXhXY1j0qs
         TBNIDgf4q+S3lYkwEHG3BPvV10oH/g3MAyOL4JEqtyoWRTl1FH8xVXI1pLSaxfJbQkHm
         jFdvFg99Rw1e2XCBNN9BIwo9bSqqkaoCgKbGTCn9Loe/RGGewQoEd26wbXnax9z90VOz
         ooDs56Z4mvrj6vX3zFTNuLGTgrDFkoDa+ELXF+yPKQsdvReV7MwhZ+bzmr6nmNqntn5d
         oDLpxS1yKnjV9umbnG/acmoEQGunAu/A4CZvBvrW09wPNg018u4rVB4Brg8o0mFl4bJB
         XEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481782; x=1715086582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEcbumoG8mFeFOR+Sn33r5OH+UDAizNlcDv3WNfEWC4=;
        b=UGAsIm9sChkH8rB9S+UO1z7jkvXjmQKiKIgnPjAHKS41TFURMa/bqvC+snagN1bLem
         orjkIrqf5aFB1By9kc/aI0EFwUAtGIJaW6G0akL4m4EIAYKBFd78vcU31hAn+y/A0HXm
         nWv1DwLNCeL1HjVYK4GN/MikJjfVV619tYo90te/CwT6dOmIj6vubOhn5RktMaO6aIUV
         epHmNkrXqAPAEtTekwfqUISOR4CHgzEHDCkOkdwSyP/FAP/X0nHw9fIaQ//iWXL9ngJ7
         NM2WtddCqjvpn01zTZD/aB9Sfr54z67JKHtMRVJq8DluR6bZUMVa3t+zBRGnWIB1iOgq
         fm7w==
X-Forwarded-Encrypted: i=1; AJvYcCWYkdxt7w/pYdfctz+lk7LSrWqywvyjPhJUQHU1CVBCcHbVJyDqaVIz9sd8frJnMEytONZmBnBPJnS9gJs/0lGLCKdfhJHLDS1gTo33kxG1WvBWhkBR+Ju+zsI+aGVNydnTjZ/P2Lx6C7M0yR5HxsNTht1OxsqtJQ6urOLCzFSMxaYihQ==
X-Gm-Message-State: AOJu0YwdFtg+NIVJCWQbuU+wZLcxqnhXRbLvkvenpw8uBK6W2cAWtqL/
	SbSL8CZWnB9vmbcq6vt9FcyUI0zRgVluN2fp6A7c/BKaL8zBtoEu7mEK7yXy9Q3bnOgBRPGB5cX
	bBEBUrFCUUmIfVyVP2VEqCIfTXk4=
X-Google-Smtp-Source: AGHT+IF+ruW2UX4tVSwBkTDBiX4l0tD+RB0RfwdY8OJLUdxLApCl0RjcoXttol9jI7EFco4FlLDXPiCU17ikG32Zs04=
X-Received: by 2002:a4a:ae8d:0:b0:5af:36ef:27d1 with SMTP id
 u13-20020a4aae8d000000b005af36ef27d1mr15155871oon.3.1714481781673; Tue, 30
 Apr 2024 05:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
 <20240427075426.662671-2-qiujingbao.dlmu@gmail.com> <D0XEVRFIP18W.2QSS5RI8KJT03@kernel.org>
In-Reply-To: <D0XEVRFIP18W.2QSS5RI8KJT03@kernel.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 30 Apr 2024 20:56:10 +0800
Message-ID: <CAJRtX8T=Rni-gyUxVmf7_AB0vUn4m9eFQ-0Ca6oYLjjv_zmDcQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: add sophgo spi-nor-controller
To: Michael Walle <mwalle@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	dlan@gentoo.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:13=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> Hi,
>
> On Sat Apr 27, 2024 at 9:54 AM CEST, Jingbao Qiu wrote:
> > Add YAML bindings for cv1800 spi nor controller.
>
> nit: SPI NOR

I will fix it.

>
> Is this really just an SPI NOR controller? Doesn't it work with
> SPI NAND? Or in general, any memory like SPI device.
>

Yes, This hardware is only suitable for NOR flash and does not support NAND=
.
This is a detailed document.

Link: https://github.com/sophgo/sophgo-doc/tree/main/SG200X/TRM/contents/en

Best Regards
Jingbao Qiu

