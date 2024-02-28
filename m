Return-Path: <linux-kernel+bounces-84256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C189186A43D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE0B22712
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A5653;
	Wed, 28 Feb 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIX4445j"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF884652;
	Wed, 28 Feb 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078758; cv=none; b=nqf9s383K2I4uH0FuRFxtv0FzsVDRwShDKLYrww1U2z40fK/DQUgSVzxF55DJUDoQl0fzkY6llR4BiVmY6rw03E9g23+nqb1e8QsXZ8CsqB2bw1ltZmkxIiZgHFA7L5GU/emsp4gGOw9Jxm2sKMbNiotccT5uwZXytgDCbrvZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078758; c=relaxed/simple;
	bh=fQrjpUiO/b0V8LS4BOg2HTg+U5iCNUhX7oh7UIby5Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzninHzlYCKPZvoaFM02BHz2y8itHJzxaAJKc0irFal8IZ2erJ1g6UXnwGjPn8Cuw3lXtcRq6WAg4WhhPOfa35nEF7BvKn9VBbaDiB3c2YY/CrFOeCOdb2DUxYfYoVOGaL1+wMDs6Tzb++IqxJ7ts7/T/TTIasnsHz/5y6Y+FNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIX4445j; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so54965166b.0;
        Tue, 27 Feb 2024 16:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709078755; x=1709683555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQrjpUiO/b0V8LS4BOg2HTg+U5iCNUhX7oh7UIby5Ec=;
        b=QIX4445jqCh0QH+FrefHYMVevNigabWsDHibDW4njs4mcwRqjAg8nqAHP1wsluYRJ4
         nchOKsqSc+637Z4+kHSGMFt3xQlOAbsoMjyzE5psj3zPc9UofTAXeX5xk4qExEJIGlxI
         OhThv0J/CxRq92tHNpIfVkheCaFfWBDqCtI80XpOtxIXy1ll1Z/a3SOH6zJyiSbfYm6P
         CX/jy9QA5lzRuawE26PxuQNhtwhZu6QDt7c3P/usC2OX4nBasMQRRe2g8119MR99r8a4
         tP2TQDYxxu+GEEOFJIAJD7U4mF9DEFjXeVPf8qF2p9NsGIOi2Brl4jWZbTtzqWDJIMkz
         +LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078755; x=1709683555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQrjpUiO/b0V8LS4BOg2HTg+U5iCNUhX7oh7UIby5Ec=;
        b=L0B+KHdr+V8Pqe4xYMDAYInVBMVlrva1pXWLZR3p8+ByMwit5ir60Ds92edhLp1a9u
         D3xwvEstY9Gm2SzpCO1HvLTzyklT6u5cubR5HoH7iBRLirAdlHJJvI6irweZlpzUECqt
         HCLPMqPKQl6TTIWveRHvGK0KvGVL3taf+klKndFBQoH+T+HzKICJ+RnPEbCY/4h+vMLF
         N6R7BkYdJVBF5v5v3MVAsZe3Vo3uA30yl9t0PaO1HyfdZylHcEtSwO9WOlZ+UGFwVJ3a
         S1dzQQ0krq+cyBxCj//VAUtBfzU0YhzZd6fmjC44tzyD1wZRpRznyYslnGkCyYpCmR9D
         CXmw==
X-Forwarded-Encrypted: i=1; AJvYcCUsI7COYan74QG6n3ui0Xqw2QiQq6u+WmFs/Vn8I8nBfsf38fWONtP1Nb4EpQTeJ91TrQonhU7X/x2/zBeVII5T0Nms3K8ClfyGpsQ3+06zYGvQye0UA93aldFratZOPFaU1YjGv4HysJj9KSa9K3rGNNrUpR7eJLMlIXoLzv6pO6LJr48=
X-Gm-Message-State: AOJu0YxRCIUwyXbLAx+BOrlTcbaJmoQgW53J26rT00VEK9bxpDqxZpBA
	9D5WxpJMTzoVPwlpYmQsaM/T6j3Gx+5SLjz25NySNHUW8d1JIMxusdAQoSrqsb2H7o4EODzVXRs
	98LZKu7nsn7cmGD/ZHKq9Ie3pPIk=
X-Google-Smtp-Source: AGHT+IHk5a22uZjA3SffOzOTnftl0o3zL9rERV2evtzEqXlumrTLFMUgGFDqnttKp++T73Jo9gpKMv6R8xJttZFrZ38=
X-Received: by 2002:a17:907:7d86:b0:a3f:f8a7:e1f7 with SMTP id
 oz6-20020a1709077d8600b00a3ff8a7e1f7mr852395ejc.5.1709078755219; Tue, 27 Feb
 2024 16:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 02:05:19 +0200
Message-ID: <CAHp75Vc7yFX6TLhc0ADx+76_+2Li=WgQiSqpcwkFSpP3pPdC5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] auxdisplay: 7 segment LED display
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, geert@linux-m68k.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> This series adds a driver for a 7 segment LED display.
>
> At this point I've decided not to pursue supporting >1 character. I had
> a look at what would be required to add a devm_fwnode_gpiod_get_array()
> and got bogged down in OF and ACPI code for counting GPIOs.

Out of curiosity, why did it happen? gpiod_count() works in an agnostic way=
.

--=20
With Best Regards,
Andy Shevchenko

