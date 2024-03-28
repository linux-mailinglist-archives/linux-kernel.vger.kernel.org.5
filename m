Return-Path: <linux-kernel+bounces-123446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039FE8908CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347A41C2B589
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49DE137911;
	Thu, 28 Mar 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9u58JFG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2481849;
	Thu, 28 Mar 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652379; cv=none; b=jlOZMXnYj2ti1ndNJXg+yLc8aHzMNDRMlUsrl1tyrKIHpuxcnRyC8gATTtFa62b94xDJudmSrfF5gT5d3tC3yxZWyVyliOn2il9Ff39hLw341t8WqRKcOQLthbBi5JxLxryA6v2mcfka5USfnY89Uopisyir5EayfZ7Gar1MQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652379; c=relaxed/simple;
	bh=SV03oY6mA1k7yFAqo606Edki3tImpf784xBEQW1rWUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyoUWhfi60KeOqK8BclinA4MqpokkdBe8Gnv6bShdMC122SqqxzjLywMuK4e+/HQrXvtlRbg+gQ++LxVJU8A49Q5M6wQO1EBm5VKJumgUmDWpCOEZuJIO/CqjCBc48hwgovtH1sdkCMoRhwlZpCbD6rWGx0s97LHsvcS3nYXJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9u58JFG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2322947a12.0;
        Thu, 28 Mar 2024 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711652376; x=1712257176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV03oY6mA1k7yFAqo606Edki3tImpf784xBEQW1rWUc=;
        b=B9u58JFG3gzjtgdJbP9dBCyQEATHBsfco6Bz+Lb1lBNmXxCBGmzpq+zlUEOqOQ05dU
         mW/UIKuSB258b9aXoFfyOsAmzskmtPTIySaGz+BJ+Yzrr4KKlRRTjLtdxAnmpI1kbpWi
         wvud5MpXYhxFzEpMLrKZWxQhxJ0wepfJvaLuPktGNBlfgGyovTZg+YHO44tLahKxNBWV
         x3U6CGtoaA2KpY8MTKTNqvAn0ksqwuLRNzBEZ/N22CJdrStySC0cqUCsySnvJsS4UNg8
         qeJwoeGbICE16L4quaXFB2Wv4/hdk7EGFMx5fpP775iOlPSdRAPTahR7kvCD9zy2CirP
         8J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711652376; x=1712257176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV03oY6mA1k7yFAqo606Edki3tImpf784xBEQW1rWUc=;
        b=I7aOOQVCKip9eYK2bMOCSR+fzMwQI+bLkahkjd1cUoLRajMXmKNG/dClLGmRzwLu94
         IL7j9OfwSF26aSlaOUjl2CyECDVOUqJ/df0qLFXxiWTLqDmGy3VkFQ0spNuih20Rl+6D
         m2fjXpgU88uxqOiLJO0pquO1V5W/eHYBfON8aQx/Bmly1e+lt7apmO2Ar/wtoeypLA5D
         /6u4ISXLikV9K1lvYc19T1XaCtGg/ykhTtX1J+BrVAce5iCCh7DHrSeTwkjUAGo3DXrd
         fJlDESyhlH4YzCmTK3KURsMLrzD+VErOtrMygWuSS6ImCkb+QWOSNcTepvoKDpIdM14G
         2rOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLPEC4F5SGkewNHX4rKYE1F2cuhJd+8Bgw66UYAChEo9lag1dWVuptSDz8VrU3bWrKlE4t8HT0xWzzsydSl+L/BJoWJWWHNI/ymeBMBm8SQpc50CJJw+tjBKKBS7nGY4INXuj5U/7C0nk=
X-Gm-Message-State: AOJu0Yy+NWmxJPslO5V6yYCurcxyocG+DPdH6nRdJtn+KEM90AIOGlKu
	ayfvujzR+rN4WV4UKzcj3BzDON/deCMYH5z8SnsNoKRTQ03h95O7vW2KUxjr56NEkqsniLtzftY
	UfiqQiBuePBCivHy2b9IsKDhQ7mE=
X-Google-Smtp-Source: AGHT+IHH6kALHqnYmeUzkijmT2flDCiOXUQodFJ0YRAefUwzLtPQNiMfdrwYHt0+Y04OzFPVBmxtNxsdJW80RtmOanA=
X-Received: by 2002:a05:6402:5107:b0:56b:d013:a67e with SMTP id
 m7-20020a056402510700b0056bd013a67emr243546edd.18.1711652375798; Thu, 28 Mar
 2024 11:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322214801.319975-1-robdclark@gmail.com> <1Wwj_q3RYer6np0Orz0wJd9dlF82iBSX-PIVSlhCgJbpfVBMHF_CF04gHojkvqnvz9NXH6kACZGXQG9yXwtkbjIzLmdi-GNDkO5Nz2E-J9Y=@emersion.fr>
 <CAF6AEGvUsP7fjqFH9Co1vE0ZGRmMXmFBCrNc3hCQwxky3mME3A@mail.gmail.com> <y5mjLoUp9fKwSNrAEOQJtfqfDZ5cYtsf_KcbNCWQieZE-uJXQJE6bQhC6oLfS6aBZRimZSarDjUmeakjwYZmtQZWPM_3lAENdY17K-VyGsc=@emersion.fr>
In-Reply-To: <y5mjLoUp9fKwSNrAEOQJtfqfDZ5cYtsf_KcbNCWQieZE-uJXQJE6bQhC6oLfS6aBZRimZSarDjUmeakjwYZmtQZWPM_3lAENdY17K-VyGsc=@emersion.fr>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 28 Mar 2024 11:59:24 -0700
Message-ID: <CAF6AEGtCcrjBG=EMgc0NrsR75qd8jJL=-kFYoVBur+L3PY64Dw@mail.gmail.com>
Subject: Re: [PATCH] drm/prime: Unbreak virtgpu dma-buf export
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Dominik Behr <dbehr@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:54=E2=80=AFAM Simon Ser <contact@emersion.fr> wr=
ote:
>
> On Thursday, March 28th, 2024 at 19:47, Rob Clark <robdclark@gmail.com> w=
rote:
>
> > any chance I could talk you into pushing to drm-misc-fixes?
>
> Oh sorry, I thought you had access=E2=80=A6 Pushed with a minor edit to r=
emove
> unnecessary parentheses to make checkpatch happy!

Thanks!

BR,
-R

