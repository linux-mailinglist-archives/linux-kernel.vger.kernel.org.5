Return-Path: <linux-kernel+bounces-76901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29C85FE61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877E428226F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B366153BD6;
	Thu, 22 Feb 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh20xNac"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F1132C1B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620368; cv=none; b=K7HAoI5ZamUJbYcYhUwb1YADdVVMQ1FDky+cGiBTPelG1dCi8rzfM+HSIKnihzxd4CiJqnBQ4368pEe+9/1asr/nBIEkhFmzcl0CMYX9Qqmx536wGLekOIMIJ3xg3QdoTUOsDj8RxpKNvasrBfZH+dYMm6bK3fhlt3gMkfDZTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620368; c=relaxed/simple;
	bh=/ZxGVQIgNU60+X6ZhcB1CqepEyXK/I+U/TXpvkzgqzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjLG3iB1eQa/y4X9I8Lc9o5ByqM0eIXaqQSLZpz9Cb8az2UZz0z/WsU90tz1zB83rpZ9AE46go/R+pWZlI3kQ1lyXSAm89oRnwf7rZufLegjjletREnQdYx0wqaTD5jHmcUpj+joAiZz/hRtFh4PC6Zu7nmTHqXq2u/z5HJA/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fh20xNac; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41277b9ef37so65135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708620365; x=1709225165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1ou0Mr/3PF/316RdFkzM/d90e2Dm+AxF27+aafT9VM=;
        b=fh20xNacMsZX2nOdiaRukZ3tRhXpzhYb5Ms69Bf1G1saoSCpLuZohUbZOvfMSB/xcw
         ZGdPx+NpaqypZKr+JSaFyWz0DCT8rCYei55+qa62cpR7haUtSuFw3nV+M6sQSWyQXTan
         rAA3eROT2tq0bhhlg0PmLd+54W/qpWgGFZj4+shYoWtp9dHYLWgHCPqVPNvhid/IdKCm
         ZJR9Mcuw3Bl26Ec32ZSCTBkCW1CRw+tUfdGbwLgCUIhm6p3rPydOq7GMS+DZ9ESU35KL
         UKtfPyQaTiKFVyuk+VQ9S0ROa4LSbA3THHhQVnBajyA7QjD3G8Kot5YgUJRQhN4rRMZD
         V9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620365; x=1709225165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1ou0Mr/3PF/316RdFkzM/d90e2Dm+AxF27+aafT9VM=;
        b=liIEAvbXjDh9ioBBamUVVqwM68lGZB4qcQaxMVuPR3lkAjl8nWG1J320PjjHQSNpJ5
         dO4H3SShGszIi9R+PQisJqQ3iK5aMJoBAf4P3P+UnBfLO42FRTEyVNjLKAu9XidooxWI
         lAicQtm3e7dk9DbK2yF4B3Z2fp64Pa1foAE1RZJQZRt9jce6usbfL5th9fXYXPgpClx/
         R+qjx1pTOSbFi9ZMCWdNoC/dO9zLeh27vKbkbdWBRDlXDE8wfxHdbpD6560kN5xyCCd1
         TtAqj/iwQ1ERpjw0DMQIq6faPnJ9x6sDumShd5keTW/n7tWkHekaP1Bdizh1h/LATZBR
         sASQ==
X-Gm-Message-State: AOJu0YxSDo9hKIFA++DLQC5G5eifv1QFR1p5S2NGCRTah0u5vNiFjtjv
	acuVKzoNIXGB5y9YQgZ93MZus1SzUMs7L1Nru3+8sV2PEf74CIjeFm8QtXhu9vka6d8GZFghmoD
	eCWVx5KwcPEhcT5QKZ817HwsgJHAVzkWC2vA=
X-Google-Smtp-Source: AGHT+IGf+z+7+K55Wqvir814EhjJuJx1V8C2xONW3Oyog2jTyHWIKEi7H6gXXpn15MK1AWjImaPNpH2IIQv0E3KhmRg=
X-Received: by 2002:a05:600c:5026:b0:412:8ed2:b6b4 with SMTP id
 n38-20020a05600c502600b004128ed2b6b4mr53102wmr.4.1708620364657; Thu, 22 Feb
 2024 08:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051253.1361002-1-jstultz@google.com> <8734tkfrzz.ffs@tglx>
In-Reply-To: <8734tkfrzz.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Thu, 22 Feb 2024 08:45:51 -0800
Message-ID: <CANDhNCoHqX9fo5e=K7_74YSmV8-T2tE-Obu+phhqy+n2bqc4QQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] hrtimer: Use printk_deferred_once for
 hrtimer_interrupt message
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com, 
	John Ogness <jogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:17=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Feb 21 2024 at 21:12, John Stultz wrote:
>
> Cc+ John. Keeping context intact,
>
> > With qemu, I constantly see lockdep warnings after the
> > hrimter_interrupt message is printed:
> >
> > [   43.434557] hrtimer: interrupt took 6517564 ns
> > [   43.435000]
> > [   43.435000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   43.435000] [ BUG: Invalid wait context ]
>
> Do you have PROVE_RAW_LOCK_NESTING enabled?

Yes, I do. Let me know if there's anything else you'd like me to try.

thanks
-john

