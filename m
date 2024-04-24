Return-Path: <linux-kernel+bounces-157615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE28B139C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FB71C2293B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F078C7D;
	Wed, 24 Apr 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SagS6lmb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9E1BF37;
	Wed, 24 Apr 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987282; cv=none; b=uSsFr6f+Ae/KmKm0nTQZR0Ynk4LHf9GUTY5/+zXhmrPb7Esp/JWN7wY93hD+DNzzLGVZw2rLgicNNcrtto0+79UxiE0/q9xRHWEVjXR1DYX+zY6NqvcM3n5hWo9BCmOR418K6pkOryUkLtCZljVHpjWsm20yN/eX4HNLEWJZA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987282; c=relaxed/simple;
	bh=wfF+FDHckmjkhq+qdDlc3OgjECCMttM3jUqX9p2DoSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNzyF3IvBr8tJuykEL+0fI4a7LeqBZB7yk3jbHbVl2339I4Ta546LBvfoYSQfls98mZV8NxLT2e2RHas+T4N3RdjqURfnPVKGx7Uromz0CcKl7BkFfxEmsFEeH4obLDfLRrAyZhtw/QV329WqjXBeHZCWRdtxvyzCmGdTs+jWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SagS6lmb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d872102372so10289641fa.0;
        Wed, 24 Apr 2024 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987279; x=1714592079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfF+FDHckmjkhq+qdDlc3OgjECCMttM3jUqX9p2DoSY=;
        b=SagS6lmbkOjV0RwrXfTU6NIAxzyHTWWmpNpusuoX2UCdIaRbpUjz6enjz5npfgfrQv
         O7Qgi9Lm9UkPrn1zcsBKB/WFb5edoSx28fBdrsIPNwH8SIpsyKLptpsxauPDljvZDa8E
         XHzti/4qTkfAoCkECJSu1aE0nd8STP5pJ+jnh+fDTkp2WhzmJktDxvxj9Li9A5JnsctX
         thi3YKJqHg4tGjagn17Zusul74XZESVAwoSDIOd/Q3SPS5dYAVa5/kzngKcF9nGypMNm
         UkuF+65pN32FArpuC/p1hIUMLLIATm0edRzikhX3bXLxYBZ+jC5kP0E36DWc9wZQq384
         s80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987279; x=1714592079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfF+FDHckmjkhq+qdDlc3OgjECCMttM3jUqX9p2DoSY=;
        b=GAyKV2OCZWkrQS5l24FQ6Br5Waoh4TJUmHLQah2Sh1ynwqkJtZNJv1Af8+IewCmC7+
         Plqcf11EHkNJV5dEqyTCZwzLmeqUPd46Nmkho2i3BY2YziHxUCehBdUot5nd7Kkh2Lzh
         F/ZyB8FH/HRt/Pi1aSRQWYUxeu+Ze+B5uuOCg0oezGiwSHMVH3JzUAkhYIQOI+cnCbxf
         iaUybmYaPYzqiF7qHls1T/MM80rYZJTCgu0sh6DkAIWaA81086KRDIa9XlRvWB9joSqF
         9/6y5WQzjwtm1tpKXX1tlBQSojLYI+Kqy+9G+RZ6fk778RAtlLZhYyc7Ji/mXVrJCOgy
         wO9w==
X-Forwarded-Encrypted: i=1; AJvYcCXUwXaNE+fyYbuKy+9t/cSDKToneh/hhb+5Z4o66BRlYYhc4Aa8uUiEiljQ11mAVk749xWwOf31qCrh6kcIqdIbFGCOcCFV6R7p83r3WKDgfKYV5OTOiPnCWTmS6bpga+Q6AGNLO54M0GefCDRbE1Ao8F4N4lJpRt5E+MsmrHWnLEjXefCbIQ==
X-Gm-Message-State: AOJu0YyRmTiu8O+MfCfc6xXqIJ1bs62ZGyUMX3iG9TsraNnW2Ij93UTH
	hGCPzTMQc0guAxYbc89FcYCfsOO61HeygKlhjSHGxwDxYgP2okgAV2lMonrbuR5otQCNLT7X2xC
	9VEjRVg+NbwkMzC9rWprE9nNGdMQ=
X-Google-Smtp-Source: AGHT+IFMApIwhx5ko50hk0xr9EG7PO0+/kGNPoVAuKIg1YIgInmwfl0P8KCk4XZJVr9KGrFtww/7id9xXA9p2eAXvMU=
X-Received: by 2002:a2e:9592:0:b0:2d9:f829:d2ab with SMTP id
 w18-20020a2e9592000000b002d9f829d2abmr182557ljh.2.1713987278518; Wed, 24 Apr
 2024 12:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424191908.32565-1-rilian.la.te@ya.ru> <20240424191908.32565-3-rilian.la.te@ya.ru>
In-Reply-To: <20240424191908.32565-3-rilian.la.te@ya.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 22:34:01 +0300
Message-ID: <CAHp75VfpRBDTjnZCdOKK+YWZKJ+wbjsg-n4wxjA7qVE0L1WSxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com, 
	robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, 
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com, 
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Konstantin Pugin <ria.freelander@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:19=E2=80=AFPM Konstantin Pugin <rilian.la.te@ya.=
ru> wrote:
>
> From: Konstantin Pugin <ria.freelander@gmail.com>
>
> EXAR XR20M1172 UART is mostly register-compatible with NXP SPI UARTs.
> It will be handled by same driver, so, it makes sense to add DT
> definition for these block into driver's documentation.

blocks

..

> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Hmm... Did I? IIRC I only reviewed patches 1 and 3. Am I mistaken?

--=20
With Best Regards,
Andy Shevchenko

