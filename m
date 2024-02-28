Return-Path: <linux-kernel+bounces-84263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18886A451
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDA7B21F10
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B3810;
	Wed, 28 Feb 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msR4Gebd"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF3364;
	Wed, 28 Feb 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079165; cv=none; b=T4ceAshHsBFO6tzOdwe0xKiXnIhLUsfdMFZ+DhTc9xxbGddsFxj3H0qzpsvEVWAlWHrAKXx2NZcy18ZE8RBfYYZWjncme9OIiXOchV0U4w9nBZ9H6yLqpZSnLQ+3teRWY0Bf8G9PdZKEPLW3aIO3HBSRpHgCxtB2M07WCYCZy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079165; c=relaxed/simple;
	bh=TmIFyigf/ZMZjUA8SywESkEOJGopXhXt5s4PxKBnra8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCTd8J6iD7O7G966L2ajaVfPJR02J5kJQeayV00Y56NBdNQ2XudlgWWrDcQ9GXuKP+a9fY0W0mN5sFPRGcd8KI7frfRWgrnxVukNlBW7lK/4Jpp5f9gvW/hhbJMEzeKEg6Q6XDPmjugCUKrDgoNQk+knEWxWRBlRkXQfiwuPKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msR4Gebd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so780714666b.2;
        Tue, 27 Feb 2024 16:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709079162; x=1709683962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmIFyigf/ZMZjUA8SywESkEOJGopXhXt5s4PxKBnra8=;
        b=msR4GebdPzca26S42v9jGpwUyMyJiqKfjfXBY6CNh2nbAFv+Z9KQ+T9r8Utlc2naSD
         3aBGbxSeeSsOtVX+lCqKlZDbRydNqrUGq92e+FIbO0g3VDmIj0/QtUZH/ZHxYvj7ttD8
         cmQ34hI0fTf8lZWG4P13mQ3tMs4aujdPZwdiNsM5e4Sp+J9/uHplbiclbpGS9WkRzWW5
         wb0Wd9lMMC+JKRR9imhx+LJDNA8kJOw4vXAEssoiKlqtpW3METasJmTmzog9A+b2hQqo
         BbHJg9P5aYMPbtg1yW7nI6hZKup9zcpnRGDZEYAzb2Ac7QlcjNNShyZB/wd5v/6uRgHD
         EehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079162; x=1709683962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmIFyigf/ZMZjUA8SywESkEOJGopXhXt5s4PxKBnra8=;
        b=wSldPbsy52jEk1MiEssqTe4wGQfDi4Z04/QX6j6UZro0CTZ6NIaXLz+YFjtitliLBv
         KztN11xac1GaNsZPuRaLrwXQC4L7sdvZ/OkCzVO3nLrnU3dUSbiMnWudAVycLj5pQk9Z
         PCO88yiFJ0Pey19OhP31MpGzaE2K2034h28mZulYq3QFXmXZNqlkSrnEtDsUJ4scrQ/m
         /YvMjy5lkQ/NgLG0JjFvXpPc1x8/TDERZT6RBnH5Dm9Ae6LbSon3DtoMTjjWLwTktMPf
         JACdpebXyXfRY5GpU5nye0AU5q8w8uLUPcGrNpLEDHbfgyUEpT8QqOvKAAaOAM/cJjlm
         TYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGMfivt+aWiYtb/lUfBV6Qi+qg840qbffmC40M9VSV6VkkM1bnQSMiNpqAoYxHDzcyPFKXbMQHZcGCta0qM4z+7RTYbw3qNpC9pKkOmdGY1dCVlHtokhTW0hcvUUxRyFjXeUkO66B0/GkGHMUBwGXU8mF7wdn/9mxzvhSvwjGa9YIFEaQ=
X-Gm-Message-State: AOJu0YxoQzIeUNpkfjs5E2cKnYYmpsDveoIf4pTJqFNzfHzpNkLg6FGa
	zJRqWiFnGcSbJvgxyPdGBGTxebXPP5+VCCbrcIz4o2PrqDRe96oOEtYScERmoIFqvV/kdFcE5HP
	BFoHIpDMYphjcJYi41JEhGrH0h6g=
X-Google-Smtp-Source: AGHT+IHMuIoIbs+fTTvUQHBpcVf3HBHjS8afQmL3SoVNVCdAZGQQPlvFSyl5yyQ8O7LasC4BnO/UwxcICHTWQcqX8iQ=
X-Received: by 2002:a17:906:36db:b0:a3e:95b8:4c7a with SMTP id
 b27-20020a17090636db00b00a3e95b84c7amr7529421ejc.23.1709079162016; Tue, 27
 Feb 2024 16:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz> <20240227212244.262710-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240227212244.262710-4-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 02:12:05 +0200
Message-ID: <CAHp75VdXfCp1FRd6JKTB==MkywjPQCvQru=Y02bjSn5nu-WGFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: marvell: Add 7 segment LED display on x530
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
> The Allied Telesis x530 products have a 7 segment LED display which is
> used for node identification when the devices are stacked. Represent
> this as a gpio-7seg device.

Please, be consistent with naming and references. I think the
compatible / driver name are the only two that should be used.

This also needs an Ack from the respective maintainer (I don't know
who that is, you might find in MAINTAINERS, though).

--=20
With Best Regards,
Andy Shevchenko

