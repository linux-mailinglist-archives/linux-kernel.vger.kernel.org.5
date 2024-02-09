Return-Path: <linux-kernel+bounces-59333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C184F58A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D57288346
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB237700;
	Fri,  9 Feb 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6qovwkH"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BB374FB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483757; cv=none; b=aYSQJScq/AMxrQjyk1rYKbeYvqB09iivneDqVsGEO+7dBqq5p+g5F/B4vM+zqxvJW1N1bVwS2iHtYf5U0FU9QagJgH0AYjeGk+Svo9SbQm68cl0gYq7B1KOHtlWagdRDB9u4r2pQpy7+itvhPAi1od2K4C59JELfd19Ncbu77Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483757; c=relaxed/simple;
	bh=yfjOm9OlKOJe/SxbVFHkHIrM3sEjiI1quLMBsdxIywk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8sY5cCH4ppIntBo+riUI3sN7LTLaFKZZcTa1cc1GxcL9qG0vKmddHueFMILiRGfZVelT9FuPATtFPUvCbSV+zpECCU1KS12+PWpysJU7QBmNUGzpzK7uVDcj9M89dseosBF5iOj8GtHA8h66eGyE6Zq9ra7jmFI/J/p9OQCWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B6qovwkH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-604c16ffa80so3909137b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483755; x=1708088555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfjOm9OlKOJe/SxbVFHkHIrM3sEjiI1quLMBsdxIywk=;
        b=B6qovwkHP18f5G0xx+vVahkomcGVvCjRRE+JYPoBEJYfipj2rVIGOAZIbpX2I99EBY
         VbnHCJERHqFKjhCJ7JxwukMvwwdGktTDyyWRxNsVETJ916Wt711gGSqnufEsnLypnTxj
         LxgxKkisE13CiVRPo1N2TMJKmR8it2gaO8IcDpDn8ETA0Mra4t1Bft7dPYATMU/mhw5c
         FB7m/E5U8OxgQ2N3PSkavD54Tgv6LFb4OhOJ+ypsWbTndG+LymFjsqflunIBrriLJfka
         ALHalvgT1xDhfzjJ7GfUHLl0h5VdB8tJjd7NO7IwFfUXZaMiQ5rRwBuwY1UhiNemY5Q6
         hPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483755; x=1708088555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfjOm9OlKOJe/SxbVFHkHIrM3sEjiI1quLMBsdxIywk=;
        b=YT5mn0tDO6y56jHvZ0jg3bYCSL8N04bmXQcK3Yh7Q/0mTYP5rmGskNRuMZaadH45s5
         42Lx9hIc0FuHzCcUmkltxDd1PghmJXMjmuCkxvOwwH3sTbIFqqgAeijlZgmbL5IBZRoE
         zfYnaHDkqHcZp6qwoUlA11iCbQo85iyB8wa7dU2MrrRzAGVE1sYpplk6aNBsiBkuy9Ns
         w9PRINadkBEqAxPdRJQamlMQZ4+PBGR6HX0N9v6GFlm6doyjvf0iOhQ1Mxi+JcWevlP0
         1H4wPZ94/u4javURzIb6BsW1FqwzYtumugrqkO2uSebOtvm3Dm4+vkOppTbUbEe690DQ
         XdkA==
X-Forwarded-Encrypted: i=1; AJvYcCXJI+6dSvNA6pElP4g7q2B23X+kiw/evkxvhIARDW8rTOC4sKGQE3vRmAY3jIDdH5Vy7ACs5Frn927ryxXMnQv2lLX5AD6FlSw8P0bD
X-Gm-Message-State: AOJu0YzxdkVKQctAU4JQsZEBVLx6hMOLCApsS4JkJNH7W3tG0ogTR4Et
	EXveInRSA2PTrrkodibhvLzP3gyyhxGlfvliSBNLawBPv455oWWJXVIhsvcmVJiTj/cY00291mK
	rLuC0w8NHuDLZr01Bj7N7c3IQ1cIT6nxVVke2UQ==
X-Google-Smtp-Source: AGHT+IE25o/8XJMpfAt8Wi9d3bxn8cnefB0R/bCv6TnDzwqcKort8OCzDemDlavAEuxfd87kMd2CsQMIfvIQnHbxoBg=
X-Received: by 2002:a0d:eb4d:0:b0:604:a856:3b99 with SMTP id
 u74-20020a0deb4d000000b00604a8563b99mr1474583ywe.17.1707483755149; Fri, 09
 Feb 2024 05:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209112807.1345164-2-ole.orhagen@northern.tech>
In-Reply-To: <20240209112807.1345164-2-ole.orhagen@northern.tech>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:02:23 +0100
Message-ID: <CACRpkda=b-uZmSfqRLkkC6Lp-JbSoi+YZpwhVn9-RMOPxiXszA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: vexpress: Set stdout-path to serial0 in the
 chosen node
To: "Ole P. Orhagen" <ole.orhagen@northern.tech>
Cc: linux-arm-kernel@lists.infradead.org, ole@orhagen.no, 
	kristian.amlie@northern.tech, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>, 
	Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:29=E2=80=AFPM Ole P. Orhagen
<ole.orhagen@northern.tech> wrote:

> Specify v2m_serial0 as the device for boot console output through the
> stdout-path in the chosen node.
>
> Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>

It's also the right way to do it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sudeep: are you queueing Vexpress DTS changes or do you want me
to handle it with other Versatile-ish ARM DTS stuff?

Yours,
Linus Walleij

