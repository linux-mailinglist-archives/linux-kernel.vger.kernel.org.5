Return-Path: <linux-kernel+bounces-93658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FC8732FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86961C20F43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433085EE89;
	Wed,  6 Mar 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDzaenik"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C15C904
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718304; cv=none; b=eiBIb/psWD/QFIp8MirH7ebJ3OfenbuBPB3hsSj4CfNAaSvAqG/ZpdMcrbjwnGGAf4hR2pb0pzpbYkesBTR5WN3JGADdD8GjajEauYF3a0I50Nm+b5YCDEUqANszg0ZYay+iRh5d+vsdX3UQCtnLTugzJeZrupMoYk+aSEMd988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718304; c=relaxed/simple;
	bh=HOZAMW/H6iDoUqklncDGbTIw5V9afaXH/RbYAT/6KBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox0mZ97TwRJb645m2Zo+LybeLqz5wDirXqZzCPorRax8a8Yq8SwDwiJJ+pVwUdj+Ki0/Jk0UGvLGn2NZRItokPXKmIEG3KUicprrEcMIzvpFDZKXEEVIYx2kdzD7sNtoYmVUdKwf1My5CDmU1MIdIooHiPfzcUOW1VkZKZcjd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDzaenik; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso808293276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709718302; x=1710323102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQP1wgCpBBioFokr90QAK5gY3jqGey3mX1zxKrDnCL8=;
        b=WDzaenikIh72Ul+Pj4kWeS/tODp7Fh74634i0vjJkzTIfMwqB5QpAqsn1vUvJCBt5U
         OasuSZgk7SInxlcLEW78TcROBRiiP57hZso6F6vjpaw9gHBcNsBjjmQmIGtTA2xSUH7W
         kX7OSFVgQNVnndxwNFt3S+DWyKe4jPoImBhi0rQTIOhYvsVmNlJQ+Mk9HOsS0Mlh8kHX
         Nk8mXhwL8EspfyIk45HnPqj/UFvRShhnyURFtKnIkiXM7rS/qXK6f2+rTbIVsQ3PY8xi
         tXAVuFMm20CV7enzIalcwPMKM7QqKL7YSAVX24ZZiMaqh3gXrCtMiEb2NlsLab9cR/fE
         Tgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718302; x=1710323102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQP1wgCpBBioFokr90QAK5gY3jqGey3mX1zxKrDnCL8=;
        b=RCmyYXvRI/4L/aE0eK4sOwXG4SC1QEvZBWWhufkuS8RUG4TdaDiELRrWQ7mpzTIK1p
         PV5yrxFbM+rF/xzrUCWe/ALoRZd+lypK6s1w0hfkNbJqFC5wbZtZaVSCRxLB581gEl9K
         ePAhKiaEM4awplcm28zGLysTDkRRcFEH2Q9npb54BfyVKpKJ/f5ZuBe5nOnkt1KksQhM
         PtJwrL0K2h3nh6zG1yczv5wZoml+fQrZrT7mMWjxRsOLL4Jf1L/DsAe5M89GA9aUZ2zU
         kxCwl/t9tTp8WC288Nl9vrdC5O+cGHFZehkMaaFxvm3hdoRwsSw3EUZdPpf3cGvBdSjX
         bUww==
X-Gm-Message-State: AOJu0YzYKa503UkpDJ52n77ZCkIdh9Rbox9QL3DXt2PNIskUHpf0aTSk
	BPvUpdhMH8CKhR/mn1oyzo3uT0xyV9m5vvwJgG7lwy1vxTNhQJwCpC1GLt7ZmB3447/JAXdcuIV
	hxCzSq6xxX3E8ytrP1/cYejjpgvW4FacXbVTYcA==
X-Google-Smtp-Source: AGHT+IHWT6I+snMD+D9zIeDpZ6WEp58iDCV+aplCIJiyTv3e4e4154r40sk77XmqDRXyrrx892Y7VbpFM0ogd6KQsNY=
X-Received: by 2002:a25:868f:0:b0:dc7:776b:5e4a with SMTP id
 z15-20020a25868f000000b00dc7776b5e4amr11676441ybk.56.1709718301925; Wed, 06
 Mar 2024 01:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220171457.703-1-kprateek.nayak@amd.com>
In-Reply-To: <20240220171457.703-1-kprateek.nayak@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 10:44:50 +0100
Message-ID: <CACRpkdbxjU0r+PDTxJwrgzuJgaKnOCHtkaZtm4jO6bmFQ0SPiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Introducing TIF_NOTIFY_IPI flag
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi K Prateek,

I trimmed down the recipient list so we don't bounce.

On Tue, Feb 20, 2024 at 6:15=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
com> wrote:

> Same experiment was repeated on an dual socket ARM server (2 x 64C)
> which too saw a significant improvement in the ipistorm performance:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Test          : ipistorm (modified)
>   Units         : Normalized runtime
>   Interpretation: Lower is better
>   Statistic     : AMean
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   kernel:                               time [pct imp]
>   tip:sched/core                        1.00 [0.00]
>   tip:sched/core + TIF_NOTIFY_IPI       0.41 [59.29]

Is that a 64bit ARM64 system or really an ARM 32-bit 64-core system?

I'm confused because:

> K Prateek Nayak (10):
>   arm/thread_info: Introduce TIF_NOTIFY_IPI flag

There is no arm64 patch in the patch series.

I can perhaps test the patches on an ARM32 system but all I have is dualcor=
e
I think.

Yours,
Linus Walleij

