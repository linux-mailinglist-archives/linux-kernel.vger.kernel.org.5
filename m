Return-Path: <linux-kernel+bounces-160915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BA8B447E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C21F228C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614940BE6;
	Sat, 27 Apr 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ5ayPCb"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166503BBF8;
	Sat, 27 Apr 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714198725; cv=none; b=lN3zWZEbyS5vLwlsswnodWemfEWwq9+dlF4Wf/rpzLbABnee2bqnv17yzvCKPpFDkRCjwBSB1wN9wM1ZWhuIs/XFRimqGqsXHdDiftHgqrJNSBTQ4+NCF2ZhmsrBo7jFpKwmC34Sve3oZ5HpdeDR0tQYbFRWXOpkiMfQdpT85gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714198725; c=relaxed/simple;
	bh=1xBwb33HlEHKam4na4z1hGgvPpLWrtVUW6QBYk0mW/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3+X9FBpFT4agryTV+Fl0gg8tRGv8d7eE+0UHH8CoxBTtEUTEcppXEMQkQM8p7SU0hQtBBgn0pJ/H0swyk5Tnk+rLjrKHEr97qXdhHDRGb7PlxJt+gSCP18TZKPWTRlkFUKOgGTdDCHQp67MKb/P5s8sO/G4hCVR44Q9UseqKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ5ayPCb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46da8ced2so3250872276.0;
        Fri, 26 Apr 2024 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714198723; x=1714803523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xBwb33HlEHKam4na4z1hGgvPpLWrtVUW6QBYk0mW/U=;
        b=TQ5ayPCbiLGt26T3w8AAWr2P7efHFOlWcHaXNBcdJJbevBB7Rbry1Tq46yaZ66SuqX
         dsTzAzIgsqJZPZ5JV/+DP08c3I7lkB0Bmf9Jg9KR5IX34Fxb6xRbcRrXjz6eJ3ReDiz1
         F1YSlmP5ORnbkH5+tUHKoDvXW2UowVha7afN2z4Z3Yls7anMDNv7r5gC6WD+uwsGcTp6
         bcJ/JNaRJqPv2nI2bu0TAkO93jK3BGgcSroLeOlbRZMhbRIfni6P3qKJby91WUayzno8
         wdKJtwK9A1y++HIZc65vYxO6ObahF2kEYqggi0jjnQRQXwxFomWe1O2jcWdHbUJ6uD+T
         lL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714198723; x=1714803523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xBwb33HlEHKam4na4z1hGgvPpLWrtVUW6QBYk0mW/U=;
        b=nEneHyVZ5WR50+GKvQ17xI7ENrrzzFG6W3vLEPN77ecjGBg0StXn/wL2FDbuyOWC1F
         dR7c2InyIG0pEHQ/Ygxa14gm71eBY9QcDqbyEoBTBRzXsP/RNgMw7MJiirbwAi3A0Fb4
         /1dvbcH1dJFBQrdVwsqE69C2Nuj0Q41vvZtAQaWF6KBYshN9PlNp79prV7FtjcD7/znh
         f0IU6XLC9MFibsQCg0IFdksc3WJGNG+rkBdDw8XSwlTSxqZbRwdavEMtMP1+gYPI2M9B
         jGuZKhWDhLRC4v42NkHzG4E2+5m5r+u21zA/F17vSGDWD2n898VgP12uGq9n1/APUwGV
         jgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/n7GZSXxZhS9p5sONgx0jRUOyZpJ9jwl2Cov/F0tWSps5It3GQAjVhWw9TUWNmUGgD+1/SnhfXecaEUAwtd6VPXqJjY83Sqy9uPYuXRL+VhHnGxeSmLThXmdHNGcPJ5qsTJSM2MUGs8TJcuqYNynj6PRXnmh0POYKR4CPudKPgFKpkCvK9Q=
X-Gm-Message-State: AOJu0Yyzft87sl0GlycLlx0xwmsTLDXmit9O3JY6pSNFZ9wK0e5NtoiL
	1a7Iojo3qCptuAdLq4v6KK30FuS4CaMxgqkv5LmjUeIWwKl3XqhNhP0Uc3RcjHWhdBPHOqDkRQI
	DDL3s4c+xGYNOnl7zz07/vXfT+3s=
X-Google-Smtp-Source: AGHT+IEVxJ68zZMIzHXBo3PSf4c3WY5+F8RxzZc+WGrryo08YQZtfE5HR2Cm05xzld7nXaGlOWGgAtYPlmEyceHeumc=
X-Received: by 2002:a25:d68b:0:b0:de4:6046:acb1 with SMTP id
 n133-20020a25d68b000000b00de46046acb1mr5306938ybg.16.1714198723084; Fri, 26
 Apr 2024 23:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
 <ZipGRl_QC_x83MFt@hovoldconsulting.com> <CAN8TOE_Vd9c2eYgomhu_ukofTeO9eK8Yhrtt-8BQckmJnGfj6w@mail.gmail.com>
 <Ziw8OrNS55AtyDkI@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <Ziw8OrNS55AtyDkI@hu-bjorande-lv.qualcomm.com>
From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 26 Apr 2024 23:18:30 -0700
Message-ID: <CAN8TOE-o7Sq-ZugRfKEQfkzjozhMS=LZ0Ogj_r3dyUuNO4974A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain support
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jaiganesh Narayanan <njaigane@codeaurora.org>, 
	Doug Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Apr 26, 2024 at 4:44=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
> On Fri, Apr 26, 2024 at 03:08:06PM -0700, Brian Norris wrote:
> > Apologies if I broke something here.
>
> False alarm on the breakage part, I got lost in the software layers.

OK! Glad it's not causing a visible problem.

> > But I can't tell based on subsequent conversation: are you observing a
> > real problem, or is this a theoretical one that only exists if the
> > gpiochip driver adds set_config() support?
> >
>
> There is a problem that if a non-ipq4019 device where to be pinconf'ed
> for open-drain, the outcome would be unexpected

Well as observed elsewhere, that's not permitted in most MSM bindings
;) But still might be nice to remove the landmine.

> and I have a concern
> that someone one day would implement set_config().
>
> So, I'd like to fix this, but my argumentation is at least wrong.

Sure.

I haven't surveyed the other pinconf types well, but how does this
driver handle all that? Are all other types supported uniformly by all
qcom pin blocks? It seems a little weird to be treating bit 0 as a
NULL choice, but clearly it works for now, with only a single non-zero
bit user.

> > https://git.kernel.org/linus/99d19f5a48ee6fbc647935de458505e9308078e3
>
> Perhaps we could convert that to yaml?

Ha, sure, perhaps. I don't have time for that soon, but there's a
chance such a patch could materialize in the future.

> Thank you for taking a look, Brian. This was valuable input. I will
> rework this to have a valid motivation - at least.

You're welcome! Glad it's cleared up enough to help move forward.

Regards,
Brian

