Return-Path: <linux-kernel+bounces-145904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B994C8A5C95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D133282BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB614156988;
	Mon, 15 Apr 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArcM9Ors"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBE15696E;
	Mon, 15 Apr 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215088; cv=none; b=pw//VxsJ6g4ALsIFBwDZjHJtx3LlPd/wwTV4aHkWW/cHCZxck7ED5ZRHMkpeQa9J4Bhc7Uw5gtRyC0DqYj7cQWZ7lGJAm1I3Lc9OpNpYk2f09Fs+26kpdSbx1JqE17XDsKnCURwKo5tIq3GZKfgUtTrUTH7SL5aH8LlqM86PH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215088; c=relaxed/simple;
	bh=97xpVeSkjoCm8WD/aULES1/pfpLnChuVXu2gEYOb/ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhvUeXpS90be49woJICKCzBOUlzv2VAx4LeGrnFt7dDW/uxWQFXM8Y1gja9l6xHqkTMy2wlmw/AkTgn+DmIdXp8bTlf/74P+eiTnQ3a1TJdug2RVZSbdTMs0dUPdYomrI8tVRn0I79k7SBRW7z6urbkhqxpH/FlCnyp+fWKyNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArcM9Ors; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4187c47405aso5304515e9.3;
        Mon, 15 Apr 2024 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215085; x=1713819885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97xpVeSkjoCm8WD/aULES1/pfpLnChuVXu2gEYOb/ts=;
        b=ArcM9OrsRRN4S3pRvYOFJ0/6z658tHM3Ue60v/ZlLdRaJfjckxL5YKAxW4SLgXmIcL
         tpVWehgmC5UhIAJ+aq9Rd/DIiLQ/6tv4ou57vn8zxsipewsaUBZiljHfzDvjGPis8HL6
         pxDQ5ahEV7+2kxxTXXwubtlQRuSvY1XGGkGApeG0ocSncvfhjGCNrJ3Q/SxCiIJOUqS5
         u9ds4qM2RyhHpe62kKg+LPec4dKbwTJBlY+Terraf0DYYuUUDc1hJbwlB4ykIyqL1emD
         WBG9s+hZBMLvM50jsMm+CWaIVTcWX82L5skrx7u+JCyA5c/nwVtZ9y9ci/C2zk3HYI/H
         ulAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215085; x=1713819885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97xpVeSkjoCm8WD/aULES1/pfpLnChuVXu2gEYOb/ts=;
        b=Oa3HY1eorr8lr8E8X5YbvB7Vxm/pvWOkB6nB2Ylh+f8wnsYXZYGP9n+tIwMqih/Z1n
         Vd4V8i6bsL6rZqBFSV+qAUb8u078USGv9pGDwGfJhCJ6av+HPc8rOulFYMeWp+GBrb2j
         kCUXO1H13iyeP3T8COJWZONIV/6Apr/G/W0S09eWjFGl3QXaU4Ch83mhVtQUjCkQ4r0u
         VQzoq2jjzIFzySUp+sZk131/Pjn3Q5uSjuU01oUdRwBpemdEleCfhpR/OISC61y0tZn8
         1q1Dwbk3XbjLxAA94QzGFHISZjQU7rmkFQuM0aoDowupcZVQyN0BIlOiIStD6UamC46f
         0SPw==
X-Forwarded-Encrypted: i=1; AJvYcCV8UMGj00Oucq9RKO2VzO49Xchg9HZFn1FbXGPQ0QZTzn1xtlIqvtiFQ5VPFkXJpZWkLkUEXvZhKLNa0pJW9tKbcC25qudF/C63+hqCcbJAINglzU3+uGKFcOBX9UgHcx/3aygNmoVu
X-Gm-Message-State: AOJu0YwOWyEBBG6T4g1Byz06ORIpthPTGq/IEv8G7cbD7zf3vq+E0E9a
	kpeHn7ew9yuVe6GWd0UJzTjUmYgGI/dXNgHlCpPn8+NaYC3tC//c
X-Google-Smtp-Source: AGHT+IENL+o6WLoa1B8krTaz77tBzWXU8btV+nzk0jjj8+LBP0PzHiHWy7wFv8qmW7Yq9JylgKtHog==
X-Received: by 2002:a05:600c:3582:b0:416:9cf8:cf05 with SMTP id p2-20020a05600c358200b004169cf8cf05mr8226650wmq.18.1713215084928;
        Mon, 15 Apr 2024 14:04:44 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c3ac500b0041888577f1esm857952wms.10.2024.04.15.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:04:44 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: samuel@sholland.org, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Chad Wagner <wagnerch42@gmail.com>
Subject:
 Re: [PATCH] clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change
Date: Mon, 15 Apr 2024 23:04:43 +0200
Message-ID: <2929835.e9J7NaK4W3@jernej-laptop>
In-Reply-To:
 <CAGb2v651T28yrkaAbX3ckV8gEsYXdGgHMgCb3Jdmbej2OnNyLQ@mail.gmail.com>
References:
 <20231013181712.2128037-1-jernej.skrabec@gmail.com>
 <CAGb2v651T28yrkaAbX3ckV8gEsYXdGgHMgCb3Jdmbej2OnNyLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 2. marec 2024 ob 12:42:11 GMT +2 je Chen-Yu Tsai napisal(a):
> On Sat, Oct 14, 2023 at 2:17=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gm=
ail.com> wrote:
> >
> > While PLL CPUX clock rate change when CPU is running from it works in
> > vast majority of cases, now and then it causes instability. This leads
> > to system crashes and other undefined behaviour. After a lot of testing
> > (30+ hours) while also doing a lot of frequency switches, we can't
> > observe any instability issues anymore when doing reparenting to stable
> > clock like 24 MHz oscillator.
> >
> > Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 C=
CU")
> > Reported-by: Chad Wagner <wagnerch42@gmail.com>
> > Link: https://forum.libreelec.tv/thread/27295-orange-pi-3-lts-freezes/
> > Tested-by: Chad Wagner <wagnerch42@gmail.com>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>=20

Applied.

Best regards,
Jernej




