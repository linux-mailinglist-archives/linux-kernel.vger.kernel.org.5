Return-Path: <linux-kernel+bounces-29212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A03830B02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97CC287F83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9342233C;
	Wed, 17 Jan 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2a1b2O4"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9A1A279
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508776; cv=none; b=Pkekf5Pw1tePDcUGbeKgqfdRAvv7cFqM/SkEVbtaPpBWN8+ZIdPY3/jWsJWj1o40KwU/CBE9ygwNHYxVCnlARmuKbtBkjP+mor00lBDQVGupMJJjCbih2nvSLxcejOlX6BVKRTXzEUwHBAtORfbUyzN1By6Qdad41TM5p+udv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508776; c=relaxed/simple;
	bh=55HKiHT9VhXQDcvhsVYui2uBU7EYV5t4AI48/DT5ybQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=LJLRqunXP+PrFpOoMskMBpJSR5iQt+rCxKwlgGR0OTdRkTRnS0PG8/0Ggo4MBg8affzKhkGrwANgjX8K810BrxLPGuyWtPUNiAt2Vtv3AQ74cno07AQVh34/Ebq8lhptbb1SB6qwEB1UBKAAy6seKe8RvXpmL8KmfK3H1Ty7p84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2a1b2O4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28db4f860easo4774387a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705508775; x=1706113575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwDfdGSK5tbIitnnChIc4CkmHS3deC+kI8bko4f+KI4=;
        b=C2a1b2O4V8WeJlzJiOI0kVD1b/7+GXNSDx+tstsJaQMqng4UYDES2dYqHq5/BGpBQZ
         VCCS6MDBi4TPKlryCbdDz6Nnh7LR0ZU2eQUfpZ1vF0nidVQJrAX/6XibkQiVMy+zV9Iu
         rLDxK+eP69VYlj4QnIUauGAPPjUWbeiFyEFGWO4uAvUHail4vUpFtQM97YqaAS2whjzE
         LFC64KszKzVO93rD9dxccfrzeOW098bSYjK4/xGdrqKxgeHr39kE2vLGPj6tzIivsz8L
         lyQ5jZOiVVrgDVVYzzIsMR9E5GmfxSpCjlVMj2xCFufXV8+FxKN0zPCV3BaRgtjtR98f
         uGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508775; x=1706113575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwDfdGSK5tbIitnnChIc4CkmHS3deC+kI8bko4f+KI4=;
        b=Cx7F+gZgTPwgdrEgw8EsACIi9tdmpe0f8kW5laJbCOjZmkll7LMeMzpOwkQArT5q1s
         mtZn2KYSjqgxNAZmf9ncbQFj8DwzW3t416doErVMNtFoUE/JJv9wxJMg/RP2ohkjJADS
         0DeHxrTz9x3bmfSSR1eeX4ZIFhSC4wMeaQ+DBRJL9rvBuDoJKyADbmWFQg11E6C3KqQD
         LR5T5G3IxuqaKgQzZqnnHFYNRFGY7QOe1GbpS5c4egE8He2uFH2jRD/9TZnBcxjZj1Ba
         /j1FkKI5ZXllVhf1xTkeYlmvfe/4tMCrxnylqIn+m8L2YphlwVi4TmQi8W6/pPr6jcZZ
         /1kA==
X-Gm-Message-State: AOJu0YxYpq4xRss82SN8dc1GepiUzj+lAEUNdfFm0WwF3qYXrLa924uR
	dIQWsQp7KBLfp2aRhBw/QcsT/b6EEj/T+hNjnHaFt7BFczdwxNaeaBXdh/OD
X-Google-Smtp-Source: AGHT+IHtz96i192wuHbHGDlX8ymOFFRVWDC3NtgoZ8FjqGRAy/Ibw6ttfpwcK2tiXMCHQca0amVpgrIuJz3W6RfsGUg=
X-Received: by 2002:a17:90a:b30d:b0:28c:fec9:f205 with SMTP id
 d13-20020a17090ab30d00b0028cfec9f205mr4686711pjr.29.1705508774764; Wed, 17
 Jan 2024 08:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-11-tudor.ambarus@linaro.org> <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
 <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org> <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
In-Reply-To: <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 17 Jan 2024 10:26:03 -0600
Message-ID: <CAPLW+4=G0+Vuwm0Jdp4wxbL9aUTaM8S+srXYwYkm10K+=hXbOg@mail.gmail.com>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:38=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> Hi,
>
> On Wed, 2024-01-17 at 15:21 +0000, Tudor Ambarus wrote:
> >
> >
> > On 1/16/24 18:21, Sam Protsenko wrote:
> > > On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@=
linaro.org> wrote:
> > > >
> > > > ``max_count`` negative values are not used. Since ``port->fifosize`=
`
> > > > is an unsigned int, make ``max_count`` the same.
> > > >
> > > > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > > > ---
> > > >  drivers/tty/serial/samsung_tty.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/=
samsung_tty.c
> > > > index 90c49197efc7..dbbe6b8e3ceb 100644
> > > > --- a/drivers/tty/serial/samsung_tty.c
> > > > +++ b/drivers/tty/serial/samsung_tty.c
> > > > @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(=
void *dev_id)
> > > >  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port =
*ourport)
> > > >  {
> > > >         struct uart_port *port =3D &ourport->port;
> > > > +       unsigned int max_count =3D port->fifosize;
> > >
> > > What if port->fifosize is 0? Then this code below:
> > >
> > >     while (max_count-- > 0) {
> > >
> > > would cause int overflow, if max_count is unsigned?
> > >
> >
> > good catch, Sam!
>
> Does it matter, though? As this is a post-decrement, the test is done fir=
st, and the
> decrement after. Therefore, it'll still bail out as expected.
>

Good catch on my good catch :)

> > I'm thinking of amending this and add at the beginning of the method:
> >
> > if (!max_count)
> >       return tty_flip_buffer_push(&port->state->port);
>
> This will not help with overflow. It'll still have wrapped around after c=
ompleting the
> while() (always, no matter what start-value max_count had)
>
> Cheers,
> Andre'
>

