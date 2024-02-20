Return-Path: <linux-kernel+bounces-72924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E385BAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AA1F21B00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60A67754;
	Tue, 20 Feb 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O1eOv0N1"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904C664B9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429231; cv=none; b=lz74wpVl6EXdGOPv5jfwHJk9xMf7Q6OqBc7Q6ejH/v1uqzX08l4tx+LRhu17OzfqPjdVQsMXyBwlL6pHkaAyn4k2knnrDMvap8k/8Aatgr1N4vXNPCBgH5ezuHitBC59z2gEt/qtBivngeY62ScMHB0Rq/rDW1Po/fp4yqFMyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429231; c=relaxed/simple;
	bh=EOcYrWm1+NauBgC3lSaTQ7qlBHF8JkenBew6u07l8cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HESchfcQYO0VCXebAxJK69AbQ1anIkgs5rcKVlphdXlX33Nnq6oAQ5qZapzShnoWBTxxcOHnOGkb5XC9VYPf/YTnsWLhR5NaJmwVbANp/TnpXwY0RIC79Zjj1oBjhRnTAC0robAO6B7Cve/nOomJ+ZQGXBvXopO28z49o8CRxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O1eOv0N1; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4cc13005119so429340e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708429229; x=1709034029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+xBZIAUjX1A0dsBqbDIysno1PWQf+ejZu36ux2KMh4=;
        b=O1eOv0N11oUjB5/U46PsUPQa4vdC3OSJHmDYlt0/X9NHwdbizv71rodxBf7LornUw3
         20QE3ecaaMAWorkfW4jmMtQynJY4VS37rHUnHb4/ZmgM4bPKg2TsZ7FlUbxfGH22ptQ5
         9U+k04nNnJJ6ZNBxdnXirneMsqYJY867dnOUw4RJay6hjYRZKA0gpRXAFA2vg7V7BUA4
         ASjdJDqgPnxPEKpTUdhlILWPiEcmCXfUlR1K10sAhwtJeRdq8AwQI7NTZMifcb0LgntL
         b7KVCibGwV1y+8VdjWcyLLzqVqhXn+Zk5BymJEJ0p5pwZpM8ci4nlz6m28aiL35VWw3W
         bpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429229; x=1709034029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+xBZIAUjX1A0dsBqbDIysno1PWQf+ejZu36ux2KMh4=;
        b=McqJLHjTh67i1j8WsJUBXeOg99j9qdMpzPkYCu29+kU9iubTALUBLlta65qYCGbDjl
         sRi/ptsmtAKBJ2RY0qdhZWwU7TxnswJy1O2enoyoZ+/xWtM3idCFBMMbLrGs8Rrcm7wC
         CBEvznrWJjR5xr7ROkKGSWPDcC0b7DmriHam+TCcHtq1X2eE2O9sqD1hfpAsMkKEVwRN
         FtdAnwFfuV+G2YfXvPIeXZbEpYH4Iyu0rEMxuO0/zDhD/z+LViEC25l01/6B7Mn7JerL
         /SZUjCja0SC0BaxnHBsfAcdp0dU5wCJMrdm7/Uo6nRufEvcWlhNIzPVGNWyh72FV5CTy
         4Cng==
X-Forwarded-Encrypted: i=1; AJvYcCV0yeTl0A8sb0KPo+THuDwdCW22NbKU1W6F6BxCs9Jm0x5wurBwYzU6LO7rABkyBytVkEI7k7xSLz60ONgZ3lF3HYByWWwBSTLiL7Ba
X-Gm-Message-State: AOJu0YzrxAgN97MlbznG+m4e0RQEnYZWXx44vIz4gMVfo3Zh8AzP8D8b
	qjr2o6u7JPrRcXFOD6DNG+ZzDwuiu9c8Rg6l3GKMblJnt4jJtZj1JKua8kYXhPDgN0BQiiNe7Zj
	6o+SkBLQuDzRI/WUK/kigKXTUKpDk7MZvBPB5Lw==
X-Google-Smtp-Source: AGHT+IFbZl5hbuuMQii/BE5aac/5cljvrbV47GrghK/Rn9aatSKrWO5GhJLvx57WdFJAoBTkKSy0uAQrzQTQ2Ker3UA=
X-Received: by 2002:a1f:ccc1:0:b0:4c0:28c6:ae5c with SMTP id
 c184-20020a1fccc1000000b004c028c6ae5cmr9397485vkg.11.1708429228891; Tue, 20
 Feb 2024 03:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111111.133826-1-herve.codina@bootlin.com>
In-Reply-To: <20240220111111.133826-1-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 12:40:17 +0100
Message-ID: <CAMRc=McjoC5iWWOwX2_3XG-e3W6Tb1Zp6jub71ArHsod6UhNug@mail.gmail.com>
Subject: Re: [PATCH 0/2] leds: gpio: Add devlink between the leds-gpio device
 and the gpio used.
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan <saravanak@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:11=E2=80=AFPM Herve Codina <herve.codina@bootlin=
com> wrote:
>
> Hi,
>
> When a gpio used by the leds-gpio device is removed, the leds-gpio
> device continues to use this gpio. Also, when the gpio is back, the
> leds-gpio still uses the old removed gpio.
>
> A consumer/supplier relationship is missing between the leds-gpio device
> (consumer) and the gpio used (supplier).
>
> This series adds an addionnal devlink between this two device.
> With this link when the gpio is removed, the leds-gpio device is also
> removed.
>
> Best regards,
> Herv=C3=A9 Codina
>
> Herve Codina (2):
>   gpiolib: Introduce gpiod_device_add_link()
>   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
>     device
>
>  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
>  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
>  include/linux/gpio/consumer.h |  5 +++++
>  3 files changed, 52 insertions(+)
>
> --
> 2.43.0
>

You should probably Cc Saravana on anything devlink related.

Bart

