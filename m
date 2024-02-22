Return-Path: <linux-kernel+bounces-76183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1085F3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0491B26D98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43E37157;
	Thu, 22 Feb 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y70OeTvl"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E1B59E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592842; cv=none; b=aNGYjhOvrlMpjQucxC8H3M+i/PymIRqDsKIM2auPJq0tifk62J5DdIyAdBOxxgRpXzkXQux+TxfLWG692qEFqJsvsw7fMDpJUMA5yBFBIJkDzCC5ExKfcd1mFeNC1NPtA1Kom950QLOZP++cwayyieV77li8tURqfm+7DaVFxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592842; c=relaxed/simple;
	bh=0ivX57rX4D6yQirT/8PQLMD0kbXDO3CjM8WXX9zJugs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhlfvBbxCaKplXCfsuWkMBS/bA2WdbPIkHA2ff2X8FBxw6SX/+0fjXrLaMjIn0jggU0M/NiUrzSdw9kIfDTmrzkb3+tHM1/WBqO0kj11j7V6VOgB0BY77rKeCGe2JZ35yPfpi7m2k82oWE/8B8MXgmLS7oOdcIOSDCPtlNoDPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y70OeTvl; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c8a8f59ad0so534121e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708592838; x=1709197638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ivX57rX4D6yQirT/8PQLMD0kbXDO3CjM8WXX9zJugs=;
        b=y70OeTvlobdNShQOP0URGKThzG7SAILy19sYZI3vYxrZtmyEV53Ik93D8XeOYOAu2j
         zz6ibkEuuBp9gAyK7eHi8neRaE3Uoq/6fLYWHXuhkDUfrC3rDc8wjvvIfXyFbhQ3zml1
         UAErxSivKYt0DTgPO3dzXEWiDwM0Z/GiJvF+zHG2NH6ktoWjoRnODlNGypg+okOhnWVP
         80xzWEuYDj3ht1fyjlws7D3G4hXZENjbVRFWAWdqCuKUNmfLtBud9X//Mocme2YgQEYh
         DZu76VCTIMZIIp9Ox0VN5lQewcC0sTyP3J6/ed+hQFs9UH7bZD3yzanNUXYVzuXtjPEv
         XXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592838; x=1709197638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ivX57rX4D6yQirT/8PQLMD0kbXDO3CjM8WXX9zJugs=;
        b=ZGBm1iZ+sSaa+S4+mbyk+7siSrW4sgAYWUtJrAtwpB6K7wP6b98jP8XRb6ELvoCR0V
         iDQEFl3jNgulcGP+c1Bb7Hu423o7+xox/mARc3NgjvSaMJFM7GDWfvmMzLhLtYUzOvzn
         hRDSLol+LoyAfqD1gSHTIu7fVyNGd6sBc8/r2wefOuh8WIgqFCm6COvSOzbCI90sgsq6
         a4IlsCLNXE6wxc9fVa7ugnzmvtUT5RZU3yGZWAQM++BPnDW73WPCsnKePLb51Gx53YKD
         hAdASmAwsu6wTwONQkEtEiHe8/NOjdq2ZMGpqehhowWEC2OuDwaP9TuexyjFmUeID6i9
         qleg==
X-Forwarded-Encrypted: i=1; AJvYcCUrNKu+91ZaSakXwYlQdXjREMbxUSeMVcargojXuHnbL1JSQOLxDohRxb4PTcv4DsP3X6wMULQJLKfUGsGm7FZ7Qz+6lBAyejS9guHB
X-Gm-Message-State: AOJu0YzaymlzhzdauGJBbWaoD6JYiGgu5S7Mo7ZrIBPwmJ7xzWNx8SRI
	h0vP5Hku8JevS9NoZQJPNKJ1aTXi/NdIbAcuAjR9AEe2urTNvUy3Y1z9DP1qjnR6YYCcTmk2q5e
	aOZrzmbUiBOodrzFjuoO5mHn3z2/sWWnyYDzSMQ==
X-Google-Smtp-Source: AGHT+IEzNIzKomd5sSPDpfbxWEG7uTeLUWfG3kKODuO1/Xi5ch980Lu/eOzY6is24+DoB2nnNLrbbKdcQHKLcvZgz6A=
X-Received: by 2002:a1f:dbc2:0:b0:4c8:ee1:5a0b with SMTP id
 s185-20020a1fdbc2000000b004c80ee15a0bmr10447535vkg.15.1708592838437; Thu, 22
 Feb 2024 01:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220232328.1881707-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240220232328.1881707-1-andy.shevchenko@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 10:07:07 +0100
Message-ID: <CAMRc=MeDE_PpmzGrJhfmXZJo180X3uM5uvrcEf1D-7RHmo8ezg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mmio: Support 64-bit BE access
To: andy.shevchenko@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:23=E2=80=AFAM <andy.shevchenko@gmail.com> wrote:
>
> Use ioread64be()/iowrite64be() for 64-bit BE access.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Applied, thanks!

Bart

