Return-Path: <linux-kernel+bounces-47040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44C84485E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1141C23872
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3683F8C0;
	Wed, 31 Jan 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQFT8LE+"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE873EA9D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731376; cv=none; b=nioWJsSweVLB+9taIyjcsnV+qeKQ7wV3YIHOHhWqnaS1eYxfHDspEwWCll2iUTBF1pmcvKQvP/nuhVZHyKfBDoyaTrEvOAMiqAk4vrpT/rEKy9N/x/SbonbKq+x/rdZAcuzsZ3T1WXRsxpt6MplwpJSiQD5+pfLavQ6HIMv79jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731376; c=relaxed/simple;
	bh=zprpkozM0tCVIALr5Eipl7GRJJSdJxZD1T2oe3B17e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta7XFx75xoyDdLI5qZsQRmQPqBuaaHkJPfMW/Zf8coBfO7ONj3c7WHB6MYLEWDiu4jI91zH7sgtsckBB96c1lECY6+1QO8OMhcfIgoeNnyEpaOR3t6VUOOBJakHIsSSVY24u47COeUc4pd/pJOLq5RNFZrXkakK5FcbO5VAvo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQFT8LE+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60406dba03cso2108367b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706731372; x=1707336172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zprpkozM0tCVIALr5Eipl7GRJJSdJxZD1T2oe3B17e4=;
        b=gQFT8LE+hXsMJf8MNDJkrJWOBiD5JMqccbtkb2YhWekF/ONUzRABqQTr6mq1luPmvp
         TiARxOOgcPus1ejXpOzQd2zO5283HBLspmoa7NwpEle+mitGNhbvF0R0TF5ZUvVjPihY
         2GhUIYmcQpOc6frqN1vF0VrX3t0PlMLX2gbEdlg0tLe7fKALNpSMUwvG/hX34M7Op0BP
         kRuh9WqJGKj13R9d3ZNEgiM30WpaxaDDTa7oVg806/vxg7+fig4vJfBLPp/8ODWUVHEi
         MiwjUVUGk9xJsxmZfESNHM3PPiC57YWCTZvw/cD0vgS3AcbWdpO42vAUXZMBHbY0d6lB
         ubjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731372; x=1707336172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zprpkozM0tCVIALr5Eipl7GRJJSdJxZD1T2oe3B17e4=;
        b=n6hF7dBc+jENVddc17mCgNGGx8U0vXiVBvaCTdm8dlJM3HdbBiY/dG69V105XOV9qK
         0pqDCrCZGDPKdqOwy99JWUon/lZORIW1J3qGfihpZvi+VH7cRZkrMmJnK2ZrgpJ5t5ve
         pGN3ifzcmGXXhor74MPEi89M7hpp9rLoniWRoutmZAH3j7onDaOsJoxIb/qLW9MD/EVF
         up5prQdjUfWP+4PxCrJpnrRo4U6rLN5NxzCmvrbR5NVJtMUNIK/+g5ylis+WHcj0hABR
         notLQRKdu+HQR2l0a7pR+OYR2F7shEBPeUj6kzcpOCTwx6mtNseE/NnhZIY4QgjIEwIA
         Id1g==
X-Gm-Message-State: AOJu0YxMzv+01RCDyX1FtesDY3MH/5UJwYdeGIvSIIYzNYCZ3inWyWl/
	sUCno0rZBDgVJo5SW7eUDaQvl8nyTLVGi09cBxQFhMWr+Rw2bDxhDBX5BhTVl5xSXh0FJGbGqz5
	X7E9jMCxBRpu9BhEG+CNNDH3tIDxAQrs/XtsX+w==
X-Google-Smtp-Source: AGHT+IHsBOqnKl8Q3AQ240lIC1W7B/6kxdi89ryEJu/r1AOMlJmIiwcyKebUqH3V3E9ZJtNO+TOiXEg0rZALWMSztBA=
X-Received: by 2002:a0d:db55:0:b0:602:d2e8:93ec with SMTP id
 d82-20020a0ddb55000000b00602d2e893ecmr130081ywe.26.1706731372679; Wed, 31 Jan
 2024 12:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-12-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-12-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:02:41 +0100
Message-ID: <CACRpkdZjpSDsTdnk79gmvCKfugKg4xFMC4m9RLaJXypFNSUotg@mail.gmail.com>
Subject: Re: [PATCH 11/22] gpio: remove unneeded code from gpio_device_get_desc()
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
> The GPIO chip pointer is unused. Let's remove it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Oups I think it was used at one point but we probably factored
ourselves away from using it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

