Return-Path: <linux-kernel+bounces-93057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A1872A33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC871C2234D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32513FEA;
	Tue,  5 Mar 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4oWTXX6"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF21E86C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677815; cv=none; b=ua6/hAZI+nP4fkomwP5eKMMF23B3cVjHGJBmcprYCHikba0+YI/Dgfzn26q07+YvZ2duFv+Xvw6rzM9OoyAk9LUB9efjZo/bmFvsQyIZG1L1wVLq6iERgDIigGTsNQSX2nTfS19htyXsvG6GbD/5O5p39t3eUBNjQErrsvppG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677815; c=relaxed/simple;
	bh=M9jh5WEb5IW5tRz7dceyYVvVzGkNBzoZVU9ALfghlYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBwz1w/OZzFanWwFjJi69wGawty0qJMwCJDv8aoIB8YgiQs43vwh3h2c51chW7yfuTBl8CjTYOpEWb1YW9jTOL4CCUX3xudHpNchHdJ8ynxBhJfaIyZB+vcbbl0rQ5JruC7AAzG2gKaiVu3XU5vqvjH0FhJahryVcVDwYzrLwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4oWTXX6; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6682853276.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709677813; x=1710282613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sstiXCgtxh1I1WdeLd29OT6yXthQI1YxVvocUUKixik=;
        b=S4oWTXX6LTGupEY05zss1sf0zwdg7w+oUhUDWkLk2U2M6BTxZmSvuDOoilCSxT5ZgJ
         2SU21eTLdCkMzsSJf9v3H6mywYdZ/7Iu1ZNzwwICkbGv17qNk5CY0kwcFd242xhMUoMv
         QUTlHGAdnocLy9RMnBiYnozUp/KA+CioIrCgUSR8DLc6SN5K5+GToTGhFgIU9T7vUljK
         pyDksT/ebEFpFJswtal9UFbQKK5uK5sktEUj/QTuNTku5Q7DBZx3skRrGnMcUW7qfG6r
         JJna/ICoJ9P67Xs8vSVAzkp5cIJ/Uxso9K1m1VE7n5Z123bv/IlHDAaI2gDGjd+Tf9lV
         +5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677813; x=1710282613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sstiXCgtxh1I1WdeLd29OT6yXthQI1YxVvocUUKixik=;
        b=xVcaHxjhcIFjTQJvv7QQR1L1Kc3qR0Apt6OcRBBlycfa2uB82XHI/FWxJX25zc0zMC
         krNORodT9Eh1ms9VJGA4+/G3xH8N0RqOJLHJnMkisw1xPe1kO2UG2evK5adj7teAMJzw
         GKIUqRBGy1RyxNETwT1H09mJEUEEZrGBj8/e28ns4CuEDTmtReyneH/HmcF5Q/0bM0ii
         UzaP6MQNL8F1XD81y/F9urzWHhnqWeWpqG8hlZbTBlTToBYsYgPtVYwdjbFc7M3vVGzL
         VorgCfQccjhOPk7DEqFefwdbrpVi1FnA2i7KwNnZ7wE2LBphi2+pqpGugmy4BYmkJcL/
         vwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyoY88Ka10myYH/wUYDOio7/HZDfg8E1MB0Xl15u840j4Vm6TANdIS25h9+h6U55zKkROqP5TP08yzqtzFGkw+90CfJq+UEfrJu47y
X-Gm-Message-State: AOJu0YxO8FMmct3IVnycibZyDcOxTBZHgH/deojLJEKxnITu/JkSMmcP
	z3gLrMJ8yNifl07xiznHiMggy5aSb+6NQFdmv5moV7ay24NJQDgVING0fGqNHQiZmKOV8M0e3ZE
	BRK8fF2ElZ9BW1UJk1h6ON6Qen+zzxdcS0tZLag==
X-Google-Smtp-Source: AGHT+IFS0PD9/FUIwQ1baCjGkvctBDIFcmKONCKsI6xrDtthFJ7zqv3OPuHcb7o1XyrIBRTmFE7jCYgjzyUM4/XGYTI=
X-Received: by 2002:a25:1441:0:b0:dcd:3d0f:1ba2 with SMTP id
 62-20020a251441000000b00dcd3d0f1ba2mr9711276ybu.33.1709677813220; Tue, 05 Mar
 2024 14:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305143859.2449147-1-andre.przywara@arm.com>
In-Reply-To: <20240305143859.2449147-1-andre.przywara@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 23:30:02 +0100
Message-ID: <CACRpkdYnFrB87T9Pq_kFDL_x399haA1n2hxPN0aSYO=KQSQQ6g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinmux: Suppress error message for -EPROBE_DEFER
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 3:39=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:

> EPROBE_DEFER error returns are not really critical, since they cancel
> the probe process, but the kernel will return later and retry.
> However, depending on the probe order, this might issue quite some
> verbatim and scary, though pointless messages:
>
> [    2.388731] 300b000.pinctrl: pin-224 (5000000.serial) status -517
> [    2.397321] 300b000.pinctrl: could not request pin 224 (PH0) from grou=
p PH0  on device 300b000.pinctrl
>
> Replace dev_err() with dev_err_probe(), which not only drops the
> priority of the message from error to debug, but also puts some text
> into debugfs' devices_deferred file, for later reference.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

That does cut a lot of noise.

Patch applied!

Yours,
Linus Walleij

