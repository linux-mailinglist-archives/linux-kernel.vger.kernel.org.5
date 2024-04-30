Return-Path: <linux-kernel+bounces-163931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA28B7618
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A46B223BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AF171641;
	Tue, 30 Apr 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg3da07r"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0217592;
	Tue, 30 Apr 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481278; cv=none; b=UbSdPeEsr9ulgke+flH32HkviJdoIGcy9KuRQZJiLJwe4k7q2WeIUPFjQPlDNbEx4nwpmniJMiFeMx0N/255U5VBm8XRv1vOeSvcuINxvbPQJqQ5Ba3Q3xLeuq1Yqe5DVR2nA5tqjZ0znfdOTlh126MGoU3MAmKgxGa5RQwJOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481278; c=relaxed/simple;
	bh=Vx2HDwioP7peM3ybXUghDUkmAaCsk3IUVZemvfs29EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ8txOJrY1g5uxOqmB43DqZnmKscrhn9MkBT6MdTLsXERwTqrX8WcIIvh1K6SOyi7OJREjXmUGXTilD24RFVomkwnOuqy+pnRjgufGg/CfT+c5s9cVTgQXwh3gipqaYNb/w4KuKUxrTcR6y8uc2tQG0SqYvOtC/SZ1vS5q0m2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg3da07r; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa27dba8a1so3471526eaf.0;
        Tue, 30 Apr 2024 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481276; x=1715086076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx2HDwioP7peM3ybXUghDUkmAaCsk3IUVZemvfs29EA=;
        b=Pg3da07rU6NKGhn/DusqCTIbV/nboQDHJnYj10GpIIusX9bLjxvGzGU5GvMeyW8feg
         g2+q6CfdpaMxSs2Gn/qaAhiwW82capJQAGgZjLTTZhbV5uuRg87RvSLFErg3fnmaQ6h5
         L1kzXH2XcDk7G3ar9o3Ti7Q+OYC6KQuplttT8PlYrGB8qC6MpcE0qJCNZyBjuj19Qof2
         gNVYnkyQ2ZLj3tVJNXUq+5aWSS4hzmXl5ihIebEFaIvMPftejJTSC8yS+s9Nnjdp4LrP
         tndjmA0v/PbP4dJVgsFPTdk5JqXYrPtrecZvV2o/9djRLLGogZCNrEAP/KtZGYMAB4uC
         h7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481276; x=1715086076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx2HDwioP7peM3ybXUghDUkmAaCsk3IUVZemvfs29EA=;
        b=hoc5Df8jSgcfm+6hY0NRwNSlaUWcRE8E4g6ti1uUyDkSjzU43x45FIRQDI0LTkeLb7
         LTxNjj2Kngl4sSe1WpESBXAUh9kzNKbtrwJB8XRwd4ybc2CwRmIaVarGyJody6RrBlIE
         KfbmIxEspTbN7YqJQvWPvhiYGtQE73nqwbBgV9BW6wwn8OTNy+mSADt9ff0Pzn08SHMj
         1GKALOiypTaovpZK8iyPtzM4K9N8cj6nKUpcyZcNyRtBv61J1PTjXo6RRtXUX3sNNrRf
         24bJoZNToPLAjP61gcxrGphGuywEK3urRfRkJC3vb+dD8/7jitfNWD7wgvp2Mnw4TKLA
         +dMw==
X-Forwarded-Encrypted: i=1; AJvYcCVOoCTkxyDNAH8p043CfCralSxUWZIE073PDwNhoNVDuuw0nVn6ObqcEMv24mTBMoKPbROZI7ZXZtbGgftGv3/frOVRmTBbbssOAv4wb857R55bcA59nAe2voxGnEU2A2NysBfP1vfM4lx9YrgQTA3fssSCRMI/B3S3sIGKwwjlLJrP4w==
X-Gm-Message-State: AOJu0Yw/OCiPmj4y8a4FutMTgE35FG4ySrDKWWNyVZUpD7oLBC/Ru2hq
	qIxayOHOr5UNmlsa7hWf/bjtk045WmzP/JibDApZqoPgMfhuLK6bvgX83rsU2eL3MjCeC3rnQBD
	i1DWxazS2zBMRutHEBS2zy9k43tY=
X-Google-Smtp-Source: AGHT+IHuU2EFqO3qBtDOYpGlwBQry7VD96vfjBoybk6US74z5b+idG7yq5Aj41hjxx25uwbHdcArZcpU51UaP9ZGscw=
X-Received: by 2002:a4a:98ab:0:b0:5a9:cef4:fcea with SMTP id
 a40-20020a4a98ab000000b005a9cef4fceamr15127289ooj.1.1714481275480; Tue, 30
 Apr 2024 05:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
 <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com> <njsvev4dxjln2guw3lr5zwvytzvvmj7qcuduo2v56dhvuxujs4@eqm4cmh6ddva>
 <CAJRtX8So3PifNFfsnq1BmP3+8kevhM6Fk6moMp=wFX4o8q89SQ@mail.gmail.com> <vxolfkvbquiy2jllncjy3vbfl2jr26wkdvpxv65uz4dneln5jb@ozg6ejzgmj6f>
In-Reply-To: <vxolfkvbquiy2jllncjy3vbfl2jr26wkdvpxv65uz4dneln5jb@ozg6ejzgmj6f>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 30 Apr 2024 20:47:44 +0800
Message-ID: <CAJRtX8TOSXey0Q3ZZ_GRSMYg5CgX1trHXu7+2bAMWBuN5d9aTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:06=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Jingbao,
>
> On Tue, Apr 30, 2024 at 12:36:56PM +0800, Jingbao Qiu wrote:
> > On Mon, Apr 29, 2024 at 10:54=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Sat, Apr 06, 2024 at 02:34:13PM +0800, Jingbao Qiu wrote:
> > > > + * Limitations:
> > > > + * - It output low when PWM channel disabled.
> > >
> > > Just to be sure: the output is low independant of the POLARITY regist=
er?
> >
> > When the value of the POLARITY register is 1, the PWM outputs a high le=
vel.
> > When the value of the POLARITY register is 0, the PWM output is low.
> > Should I make this point here?
>
> So that's: The hardware emits the inactive level when disabled.
>

I will do that.

Best regards
Jingbao Qiu

