Return-Path: <linux-kernel+bounces-137323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF489E0A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE4FB29EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013B14D458;
	Tue,  9 Apr 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L7qfT7V4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE514D281
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680297; cv=none; b=G7Ux37cqK+R+YYF51UhrBUzqpKa3pEFHY1gqhkER6R8ib/UxElOfggxtdKI9ydR08iANFWS4bdpZbssE+u7KFW8PranpCRKxK4oVLr+S19k1UZwNgf+igkj2suMRxToGMpFrxHfCOX3KBv1gmdA+anXzzE5QaNHSIjIfhMjjQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680297; c=relaxed/simple;
	bh=ApwdW8JBFGi6r1KB3HXNvgP7VIEHAah5RIdbQPP76EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1OtyfMxMD8GyxpJnBNz6J+t/WpSIkrUw2kqJgNL1x6akfVFpxzjRODr9CRExFsctcwfqeJJyFFqaY+jyVRH6ppzwhsMQ1GYIw07YDc/P6+0ni9eMiYFHQp2KhP4MrdiYx7hHGJGTE7nvNIeAMyXQpTx+dj+iYAR/UFLiiM2VVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L7qfT7V4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so72271331fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712680293; x=1713285093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGaWIK6Rz0jcvvBzmUvZymJLZNxNC0Jm+nT1TGr/ewQ=;
        b=L7qfT7V4YiDItzOmMbHhuWQgypt+58s3ZohIduCFs3V6jCuKgMB5PzUsZ3oShAp5ol
         bWV2eVaQzC2h/jR+OBbcJ1AwarGI+ka7vBakh4LBdlnQlT5YVNklDdomTirWp4jT7lMJ
         GbYhsoLUlkYRL5Vo6RKzh2oypG/nb8nC6T6k26ZJdZXFwmRchBPQN+e157jPb1p296ow
         rykbjs4YcqZHlZDNTzxn7TjrDBcFu93gPBR7ZzwnQU7FPezxTYiRKBda+preEMPSE0MU
         eSH1SXRiP8LC8YYkKPrtcu+u9BCCFhZ+gUf8w+/lz5fjX7pjzPRbBLjia37TtYb/Jzld
         4EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680293; x=1713285093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGaWIK6Rz0jcvvBzmUvZymJLZNxNC0Jm+nT1TGr/ewQ=;
        b=iHgH12OiTn8SSt2Op25CfKeLKYyf9+lGuzNL4TySWvMQh/EY6/AH9IsX0PynEcDeNg
         3d/tHGDx99vo4HFtLS/2JmdCbkvjN2Dl0c6I3N2CR7jFlfDsm1N589cYlcn4+rpQVoUS
         jQqvJhFnLhJ1bmIPg84XakgEFcD9kxT5nD22T4zYwfOPbOWch8HoZjxC8b8mKMsnvRdE
         iwPj9z3kSSWjwu+Xm3ei2aIihMWvWXQtNNVD1WjUKY2uxVk8GrpJoQ1Vbmp9bUQe1B9q
         9ZUuCOfQHZlsVsKP5gqJVj5/04W6PzGfNl5ZS4SXyzJAXAlvBbfCDkNqv7H6dVpaDRDO
         R1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB17QABUrSa5Zw0Eqbyyfa9j9nqE/iQ6avu4IXaIH2cXwnwNvpQBcofdQN8zyhWkTWh7Z2MRG/d2sgXx1n7m5MpXyVbnbReF5Ii/aB
X-Gm-Message-State: AOJu0YzkSEpvkjz0ab0YCvKFor5Buyk7x43sbF/wH7daCVsKzMXSFT4v
	JnON1MREjiWlKrt8tpSCknQLEfFQBQdnd5EzCnxFkvDgeYWy98xHYaojPObbBKMhh3utFEl1w4g
	4V8hfREY0mc4qlydDGH/y3NHeUqi+gL83pMHpUw==
X-Google-Smtp-Source: AGHT+IF3Rz2KQSrmOgUW+wAwlyAXsvBQbr+RQcLNjG/BGKAP1GIQB7pfKVDpaGJttOGNhyw7HwMY32/9aVBhxt+JTjI=
X-Received: by 2002:a2e:9912:0:b0:2d8:5859:ee7 with SMTP id
 v18-20020a2e9912000000b002d858590ee7mr215843lji.49.1712680292607; Tue, 09 Apr
 2024 09:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com> <ZhVX76dVt-TrC0NX@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <ZhVX76dVt-TrC0NX@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 9 Apr 2024 11:31:21 -0500
Message-ID: <CAMknhBHRuZRkDh5hy1+oaSDWAOakpJ+eOd+a5p1jC4g+WRENLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for AD4000 series
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:59=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/08, David Lechner wrote:
> > On Mon, Apr 8, 2024 at 9:31=E2=80=AFAM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote:
> > >

..

> > >
> > > - Why did not make vref regulator optional?
> > > Other SAR ADCs I've seen needed a voltage reference otherwise they si=
mply
> > > could not provide any reasonable readings. Isn't it preferable to fai=
l rather
> > > than having a device that can't provide reliable data?
> >
> > In the device tree bindings, making vref-supply required makes sense
> > since there is no internal reference.  In the driver, as discussed in
> > V1, it will fail if vref-supply in regulator_get_voltage() if
> > vref-supply is missing and we use devm_regulator_get() instead of
> > devm_regulator_get_optional(). So leaving it as-is is fine. We have a
> > plan to clean this up later anyway.
> >
>
> Not sure I understand the idea here. Should the driver use
> devm_regulator_get_optional() instead of devm_regulator_get() because
> the optional call would fail immediately if no vref-supply while the regu=
lar
> call would only fail at regulator_get_voltage()? Why? This looks very cou=
nter
> intuitive to me.

Right. I'm saying just leave it the way it is for now.

(I have a plan to simplify it later, but still working on that.)

