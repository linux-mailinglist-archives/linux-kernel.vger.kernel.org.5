Return-Path: <linux-kernel+bounces-129452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06EF896B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0C9B207EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224A1350C7;
	Wed,  3 Apr 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IrxgW6gg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDD136650
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137656; cv=none; b=oYt4aAUyh/30QVbkTMFYk6lx7NAOojbZDDh4RkE6ZRtDT3IvVEzleKHrScRIi8RhQhNqnTGevwZF6GWuFXw3rLwCATv53xf995jL8DfIj5AtRpzszSADa1pI6sURmzmISu1HrXxS0dKBIq8lbDJ/H0C/LrMun1uJwKWE7Wok5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137656; c=relaxed/simple;
	bh=qPteIPghEmNaFbFbiFtmdDCR/LlCAmuK8ocfUthHuZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctkqWSGMJc9VIj12sVrIWfINJl2aksDNsSfayy9hjaa3bp51ppQ2vxkqNK3hGqe+n2AY28sohzxJgMUgauq8JImjuhMDc+iw6O1KPaj3A7HIKpoThSfufNpz7ZCvx6OAjmuRrQRDloDGixprbarwrPKnIbLXWVbQS8H8YVMs8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IrxgW6gg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-515b43b39fdso662728e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712137653; x=1712742453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KABiyoA6kqLcaNOPFvDrUfGOgcIyRMqYJlYfREBWxQ=;
        b=IrxgW6ggp2laH/3u5v008fpHxZreyR21hYxus/LRUiAvd2IgTPhRUeu38SaK9I0Ddh
         mxUwKooL1kgXVcQ00aVGT7TK3KQZ4Q4Fmtge/oLlRp4aArlkZf4JDGJoZGTdQac9fIfm
         TQ0S03cX2SSGsCKhjWN89PiE/jafHfQQIh/OuvzGW5GmII8fMr+AaLrMm5hBRvqWm7mg
         9xfCRrqfIqYxUI5NJNiw1TmOPxPFNF2a54yK1iGOAh3rRY1RZi4b8g3gKi3sZw/L/LjR
         ydUvmXuL0qvz3J4mkfsVDDM24TEafweqaP1NWEGUMGoH1nAZsZl1U0a3WruvmWq3nI7S
         x1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137653; x=1712742453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KABiyoA6kqLcaNOPFvDrUfGOgcIyRMqYJlYfREBWxQ=;
        b=CWOUJ7QO2u8BZKfWnsG1z+MDnc1XjOJhOf8WP4a7kLC16wXOrFL4R0ezD05uweBSdN
         qwMDV1lKwV3mIW3oJlxWoW8CzD+d7+IuL3kol4f9wFqpTLobZ6iM9cxt+1V5HbNpiudV
         r2gPz0Aq37Jr2zrlDUwwH2TRlkHQldlfmKhDSnRweoZyxIh9NQooJDOcIQdtOI//a3FP
         raKEuhTSlXzMqrXqpPwyLxC7xrGlPfhgIUMxjQzcgaywr2OHYPLu31yBB9gPdF1ePHyS
         vwwIogr5IcmfW5MCvtqsgZ99jUfKuKvxjoQz26biSVBOIx1aLLMSy0rbFzxUqiOw7sX0
         U32w==
X-Forwarded-Encrypted: i=1; AJvYcCVrWgJLWCri9N6vlD6Vy8+zLASvCFqfoLVcnjgCM/If2PlHrEtlenzbsGfqr0HgQn2bHIlldkXnQ4DFsbzI9uEPgrOJohM4kWDb86J1
X-Gm-Message-State: AOJu0YwamKnp+tpHI9/6OYv5xjTT/hUd0lKGoMl7m7iBKNq5//RhzJvR
	ilykPVkb+8ItVNg7uLQvLqtjU1OvzuJe8dlcmb5nw7aD/cxpbxMCQbfd/oJRrfOVsdvITtCBPhm
	Q1n8NRKayoVnupfYBOSzqRIAbsoSO7XFDk1pp7w==
X-Google-Smtp-Source: AGHT+IG3Db0aH5fVKWMjadssHxAGVYgs1vlEPlw4hlOgGoFOBb8OwTQCY0tQE/dJH4EGfGfs4wf5rTdQTC65LycruUs=
X-Received: by 2002:ac2:5399:0:b0:513:e1b6:40b9 with SMTP id
 g25-20020ac25399000000b00513e1b640b9mr721023lfh.28.1712137652596; Wed, 03 Apr
 2024 02:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402114159.32920-1-brgl@bgdev.pl> <20240403094205.GA158151@rigel>
In-Reply-To: <20240403094205.GA158151@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 11:47:21 +0200
Message-ID: <CAMRc=MePwq_rnWZUA6skVqiqjxTKNLXR7cdfrrVeeaxz8Osxmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: check for NULL labels when sanitizing them
 for irqs
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:42=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
>
> It occurred to me that none of my tests cover this case, as they always
> request edges with the consumer set, so I added some and can confirm both
> the problem and the fix.
>
> In the process I found another bug - we overlooked setting up the irq
> label in debounce_setup() - the alternate path in edge_detector_setup()
> that performs sw debounce.  That results in a double free of the
> req->label and memory corruption hilarity follows.
>
> I've got a patch for that - the unfortunate part being that
> debounce_setup() is earlier in the file than make_irq_label() and
> free_irq_label().  Those will need to be pushed earlier, so it is
> sure to conflict with this patch.
> How would you prefer to proceed?

Can you take my patch and just make it part of your series?

Bart

