Return-Path: <linux-kernel+bounces-130166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B228974D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78E21F2117C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674C15216F;
	Wed,  3 Apr 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lysfZgIV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF614C5B7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160189; cv=none; b=lHQpMPMQkFIq67iLnPVE4XFhMUrvdz+K4opiGjpfJupUyrnf3lyg2hbE7IZXkxbLBlr8uXrLHqfZN4GlKNnm0sz6B3S2ijZ2xYT8rQzs1u+OXJcfEdeMKqikNqsvJvIS+fHYnJmn6lBlNWq8e75P+tCFQdqInFxbgZUAzjp2lVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160189; c=relaxed/simple;
	bh=bTvBBqvM+g5SfRgI5quUH3wnImmHOZ6hz4keoRzRwYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQOQ6IjsopQGIIkPFYeIlMh7SGyhBVR0ULWYQQPzHXA3oNfZPDyvM4GYX9Bn4S99dncKUuq1AE9BNMjr3XMAl109ePc+/T0hDMpfcDk+ruJ49g3QyWkl+vjRXnAuNC6UD07uo05h7c6zRUvWkVPa/74dS+av1CfkA1U+eEX+SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lysfZgIV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d83dddcd65so10502691fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712160186; x=1712764986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTvBBqvM+g5SfRgI5quUH3wnImmHOZ6hz4keoRzRwYA=;
        b=lysfZgIVx3yGO4yCEHgHksvCJyLZJOSKNM1o51kCRsFcKt0ffydgvcacs+e2CJhalE
         amAe2kB1J0l62vqS481GGm6zr5P6H6fPT+I23+9CLsuu4DIzd2D37pU6C9y/8PirFQsu
         lPVlCpg0pegWs+hsQlR2ox+noaCGJ7xCpyCuBtYb6PSBnkmfkMBwel9LJrlJoDpibqQD
         haJURm+RDc8MLLnWFmKejOIKGH53qLC1WOggov0G9wLXqQ6rjgFUw5ymVDlkz5uTotE5
         jOgHXEJsvOkP5H89oJD4KQrxdbIam1zNMspBuXUy+vtL2p7Qz1XeTHHtz9VSAKxdIiaQ
         OmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160186; x=1712764986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTvBBqvM+g5SfRgI5quUH3wnImmHOZ6hz4keoRzRwYA=;
        b=hIwCxsHGsCJZXaCnTQOnBHaNcy3kzYylnTM7s+blELgtQh0swoF5NlbbntgFb2I91o
         HmfZdRGGVzMAoZyp+X7cRJrF8qjoG28BVaBsjw8NhkBBb46qIlVECMXOVLvvhJxQq+T+
         c0N7HQeWqVeMxYc0BAmyfuMd7ALsnV8JFPh9pnwm/auEGJl0nctHTjJRgvt7p0KCtJQw
         XgtYLFhWh7I23jC1tEbg1JR0sLEr5wQoum/sgWTHJLCjPpgkDH+c+IZODGJnu593w8FA
         sJjvcYMTU4DkMA/WKhtYtnmkYQnHl7Xxmmio5NI8fTU4NmcUccDW0mriTx2KxG/Z4Pmv
         xsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3YrGbovR1VsjkkjOPQahQv++cAC9pcQ7H2mSCGwNFpSODQsXQgCKxqmH09iVoK63F3/Uzudqp2MpQTTyfPc/Ru1GFs01HfcDPMm1A
X-Gm-Message-State: AOJu0YwkAywODcpo4LyHcY1zGDgfXCyiGgZOiz9syFLwc2LVzGdSIo9y
	pK303N58V6DAaIEABwyQyisswVhJ7FzUswFq1usG1/KxYOX3sbgdMVdDB75COu/bPE+JFofnVhj
	kQZHr9fwkaz21Uwd4+uSZQEoIxngIGQdML4FT+A==
X-Google-Smtp-Source: AGHT+IEfI5ofSa8HbRO6qzAuEu/QevNBSZtDcMguGLWWWkpuGtfcQ39NMJwhn9Ea552v6Z/oXcGuYOl4UC7bwCiesso=
X-Received: by 2002:a2e:a68a:0:b0:2d6:fc0b:f122 with SMTP id
 q10-20020a2ea68a000000b002d6fc0bf122mr9938lje.18.1712160186030; Wed, 03 Apr
 2024 09:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-4-34618a9cc502@analog.com>
 <CAMknhBH8UEPSyYiyMPo4en4vcjnJ7_W5q+iJtMOhdp5eNmP=8w@mail.gmail.com> <78cab1a4-e085-4df5-bb8c-277fd5ec3d70@gmail.com>
In-Reply-To: <78cab1a4-e085-4df5-bb8c-277fd5ec3d70@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 11:02:54 -0500
Message-ID: <CAMknhBGZ7jUjCk65v54ayGSUA2-qcaCEmKm69TcJA+Ups_r=ZQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:03=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
com> wrote:
>
> On 01/04/2024 22:40, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Move validation of analog inputs and reference voltage selection to
> >> separate functions.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >
> > Same as my comment on PATCH 3/6. We would like to know why this change
> > is being made.
>
> Move validation of analog inputs and reference voltage selection to
> separate functions to reduce the size of the channel config parsing funct=
ion.
>
> Good?

Better. But it still only says what is being done and doesn't answer
the question "why?".

"to reduce the size of the function to make it easier to read"
explains why reducing the size of the function makes it an
improvement.

