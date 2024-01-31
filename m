Return-Path: <linux-kernel+bounces-47054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6684489C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2847F1F24ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40D3FB3D;
	Wed, 31 Jan 2024 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFLOS68i"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CC3FB10
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732193; cv=none; b=tOY1IsG5Zhw6V8qaIP8/Z0u44qDKMp2+Qz9AbRLhGSRhGiLZ5tb/K93kbyXgNrywTTx3oyFCftYS9Cu25GiHeQ8EYyO8Tru8EzKiy5IUTepapREi/psiEy3Th95bTPX8X4V6R8RrjSxh7dqxzxnEBFCp4j3ZmfAT2FoUtiFvVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732193; c=relaxed/simple;
	bh=JbKC+73posjGFpYb9gcbTa9LruZ7n6Vqx9LSCaLAvaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scVH6AEKmFprUOhmR1LI8imr9CTnASlgg2hJxNf126qbvJ5sIX6bukZewx8gjSUUwzTFAPADXinkGZkr+/fCFo0fvEEN4akUaBT/3WFDoimVtW2NITjc12mFVLo3ljNM6t/7PQq+U9IlauAaq7HEu9bAScIEaTbMPXhUcCALVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFLOS68i; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5edfcba97e3so1903537b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706732190; x=1707336990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbKC+73posjGFpYb9gcbTa9LruZ7n6Vqx9LSCaLAvaY=;
        b=uFLOS68i/yyrVqC7VDAnP6ksgbG4HLyLifc/V0kmd2Gi4kvUcbqagat7WEUvA5eYNf
         vUE4zX93cyvIn79qtesy0ZwQ7z0N8cmuca3ucB5HFk/W7XJgBezZmI9f8Iv9QaRe3DGO
         Ir2nnCrWKhQiu9zEfXxYutSBXBH3s+MS7+Yesm/Wi+0s7w/YtAqcbnlTj5ZNapUwDJT0
         /9vj2LXQbyiLD+iS3lPP4NnVmjvPCPfxFL9Te8fcCjJ7AXDto+emsliwu9q/rmTi0UJo
         zfhXQQsR4mKj8emMjuypeyvpmxzUTyXqpKhO5kcc3r2gbuJJZ2HnbmviU5sBcHwZuTHU
         hCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732190; x=1707336990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbKC+73posjGFpYb9gcbTa9LruZ7n6Vqx9LSCaLAvaY=;
        b=XHmfqu5llzNn7LHl+H7RWpIWhYVk5sawmqlqpCqFBu3q4hYu1eRhklusUqhEpju8Js
         Beyjnup+5LQrKeEHrwuNc5m51lKIBANqNNOoySYo/xvEFYFkG1ntVineA6wvoaa5EUta
         pqS0besbl/wyBvAoo+LkngC7myK8nWVsZma4msUfqmwjUmNqMQWo4qs2liT7l7rw7JQu
         3hEX7JjBZt5DbxAOxAx0fXjxtPD9LgFoLt4uOHLzrGL06wCOkv6A7pPD8ABOpCH0U+hh
         SSOgFRUq1f36v+lcfOH91mfe5jDfMQw3O9R9Numq/v/LAGJi0iMWRLrLxZT8h/0sRv5r
         OvSQ==
X-Gm-Message-State: AOJu0Yz2/u4mBhNXvzukm+vnRufhlpMGWEBubLhV1ph6kWId1wxnN39P
	iEzyKDDkkZMP+Hgrc50T3Klyf2U5CDNiUazcvIWPmLUucsPpx1FxZtIcVQMzX3ebyy6nUAexmsM
	OQ2ao5Ccsiw9RDQpF7i7lYms3SMxdZIOuj1ZdPp9p6HuHvvEQ
X-Google-Smtp-Source: AGHT+IGTOhv4lmVR+cLSWJktEaFcD/NzFyonVYAm8q2ESuuHXU+x0IeRbHQ3KE2sm5LhZkzlbQEePXGUJDnai2ccI8k=
X-Received: by 2002:a0d:d60b:0:b0:5ff:83f7:57e7 with SMTP id
 y11-20020a0dd60b000000b005ff83f757e7mr2547764ywd.31.1706732189732; Wed, 31
 Jan 2024 12:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-17-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-17-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:16:18 +0100
Message-ID: <CACRpkdbCBe+HH5uuh94tx9ezV0xtBO-=DZp22bUBbbYuEtJ3Vw@mail.gmail.com>
Subject: Re: [PATCH 16/22] gpio: reduce the functionality of validate_desc()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Checking desc->gdev->chip for NULL without holding it in place with some
> serializing mechanism is pointless. Remove this check. Also don't check
> desc->gdev for NULL as it can never happen.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I don't know if I agree that it is pointless. It will work on any single-CP=
U
system and 99.9% of other cases.

On the other hand: what it is supposed to protect against is userspace
doing calls to a gpio_device through the character device, while the
backing struct gpio_chip is gone (e.g. a GPIO expander on USB,
and someone pulled the cable), i.e. it became NULL, and this is why the
error message says "backing device is gone".

But I want to see where the series is going, maybe you fix this
problem in the end, so I can come back and ACK this.

Yours,
Linus Walleij

