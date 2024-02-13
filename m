Return-Path: <linux-kernel+bounces-63659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99F8532E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7EB1C20C98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404358137;
	Tue, 13 Feb 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTPhxXNp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B65788F;
	Tue, 13 Feb 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834005; cv=none; b=r1cJUTKXg9y6U5QgzNLmdLiKusA3M1l19nrBTte3gZ33UPQN2zkK0whKfj+tldi7fKU0SmZ19WTnyMXtKbSQ1cS/+gUJRgoggUysxFjhHBa5Y+5b+/SX4evyDGb0HOpBvIqtwXywCZ6HrDQxhxpP0XhyCkgBcA/Xzue4KBsqG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834005; c=relaxed/simple;
	bh=AFbeRrxsHJyfgxyacddgJUuR0lX3pyIP1w4eaUhlR28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNqC4vXWwF2lJBuly5A0w7F2sxc+EgGB0rwQZKHs/JsRGs0L2wpZyFnVOrhdDoxJyJmAU09zevciXdku0dgkDGFfxMCTnDxkC55Bj4sx/9+gxVbwm0DCuVnMuojvciemDjO2oOoDqGFhvD2V8iyxq6hxWeQ3L1rV3aLxijdOL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTPhxXNp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3cede53710so114629066b.2;
        Tue, 13 Feb 2024 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834002; x=1708438802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFbeRrxsHJyfgxyacddgJUuR0lX3pyIP1w4eaUhlR28=;
        b=RTPhxXNpcV3Cx/FQqx/vPztBHTKNYrKqn1278PEg/lMZz4/1rjmATV/nmjbLxBA0bK
         JGGSic4OoB9a3JZYCUZriKhy2J6q5r5z9Z2WiX7F6T/E5TqsLR/XTkWuSxQBKE509VQm
         a22T8hJVC28MgYY6LmwbeSeOF85mIx71/Je6liAg6U5F+fOLsMvmS4YcSPp9/QlOQKui
         8zKzjlAjtiVu4rQVRFrw+eyfE8NHpF8E2h4A/5vxb+FFlgV/TNn51ceHPqG2sg3yoCq+
         U3xSuCUKvxN5pWoqKDCa8dBqoUEwWeCTC6MUA9HH9yu1SbbSNlGO05UpjHZvf3AGIpuo
         OPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834002; x=1708438802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFbeRrxsHJyfgxyacddgJUuR0lX3pyIP1w4eaUhlR28=;
        b=GeJofc6OnNoJKg0nLq4R4CLD3pyvRAiQCNddUzTP3T+E+Gl2qFkDauRPqd6jLFFSAx
         C5HrmIerbAEEHWc5nOAgiyHDw5uz727M0e6+AUS+6gnwuxVIWoxk+s57L6YEBWUYfLqA
         6Ma112hwhl3UT6sX391sw9mbpwujF0Xf2ARhproKF+PBGuiRozebVP7Cwc+9sZBVB4aX
         3DysKjcfUzi7GCyYVJgkRkg7P3ZO2xsI+diiPNzWr5axsGkx1snGTP+3bajO6VU8Z2fo
         /h/dSoO5XS7mPrnd71hM1LKXSxqwunCny8H0AlVo+MJRjZs320XI6xXN8RcZYmMqqiiA
         UiPg==
X-Forwarded-Encrypted: i=1; AJvYcCUyUO44hfHk0T4zLRzjsuXQYcyu8YBMXqG3/V4K11b/CWBqoe8l8E/mmwqU4WjjJ9GCgwPwLskI0k1P4AB2d+jQB2qNQxJxoexBn1BBPp0+ZgaAjazOWpOvLEYnri7ip4ogAsKlcw==
X-Gm-Message-State: AOJu0YxjPSqaAaRTi4peQoApJKN3VyDXYbHVkt4ZFRLK+mCxBO+hNkqU
	uhE96kY9GXlpZOkjJOopLCRzhKuzRo9yN8mJNy0fAd+ak25qbB9MJY5YArkkgr6XoHOvdJ8fW34
	tznfEsenB2qb5WUsJNxG/V4fwEys=
X-Google-Smtp-Source: AGHT+IGG7ejTKYW9wnso1dtmPoPrZ3/Y/CV8IAV4NFIB/ZXAyN4azULaBOoIxwWrwRUdnGkppmC2A6x4MoU036U2WZM=
X-Received: by 2002:a17:906:8c3:b0:a3d:1d06:e4a0 with SMTP id
 o3-20020a17090608c300b00a3d1d06e4a0mr613853eje.7.1707834001762; Tue, 13 Feb
 2024 06:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213141222.382457-1-warthog618@gmail.com>
In-Reply-To: <20240213141222.382457-1-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 16:19:25 +0200
Message-ID: <CAHp75Ven1gb7MzvoY8DJhu1E-4hVe4AJ4x0Vc1vQFj-3OXmBVw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: consistent use of logical line value terminology
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:12=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> Consistently use active/inactive to describe logical line values, rather
> than high/low, which is used for physical values, or asserted/de-asserted
> which is awkward.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

--=20
With Best Regards,
Andy Shevchenko

