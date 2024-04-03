Return-Path: <linux-kernel+bounces-129643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9767896DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB50B27522
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53F1411FA;
	Wed,  3 Apr 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LpGzvPrl"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF006EB68
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142567; cv=none; b=QAGqDg6kQTkZUgtswP1NBvMxu4A7BeYY0GokjV+611dG/5N/TZM11YL6m4UjROkgtV9PnSrrxujAHLCz+MAI2brpOu3X2zEh6StYNlsMUib2qsx1WHeC+ot+yO8kzj6vFXyE0BHNR2cO4YHyhNGaAkNNIf6NDY73zN51Thg8ZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142567; c=relaxed/simple;
	bh=vMMeEdF7q5Dslk3ESkUVY4C2xbbVVOS/LDLiQqYUrzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx5eH0W6JqXw8b8YyQh/kklvxLkI+wQFf2TrerQ96+Yc7GY1lBwmT0I6zOUcJaCqHr5aFOy7dd392MosNZSs7FJqzWOxdHR3kGNVjhEJk7dSxjpQbWN7SPodcafkAlju08rkiBUqQXGmuG+qtqN32UfxlGV2874P9QY623aN7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LpGzvPrl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d212f818so6825390e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712142564; x=1712747364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMMeEdF7q5Dslk3ESkUVY4C2xbbVVOS/LDLiQqYUrzE=;
        b=LpGzvPrlS13OoUqmgHOaTiqK7sYd2b3XHXwWCIjK44+dTBhv4aIRWjyw9u8RI0WW44
         hNvN2IoNtKUzMxAqrO0RjEHvZPfvLvCUb/WcK38jwV86gCY5f1ZNn2wz6jP3oaAfcOaZ
         JEM75pTC2jemuSfai9r4/mbrawNB+Ah+ntyNjtPY1m9MnZmFXoS9FQNQl28mwDVIi6yp
         BYBDa+6AhlXCLUFZJiIknKkU/Yzd19luq5LZVPG6Za02HjRQQZg8Kx9Ip78I1rZhKSeg
         5X/2a3BL+uDd+mUqNdsTW/8aNI9Gy1oqUQ85odQB9c9SEZ8gQpCRvECtdkBmi5pNyY1g
         TDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142564; x=1712747364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMMeEdF7q5Dslk3ESkUVY4C2xbbVVOS/LDLiQqYUrzE=;
        b=leURm/Kqlql2HlZlWZ45/hCHjIIu04pW8BSh6WGNsALIcje5al/ZGDDzoMjGZjY/pA
         rPESsobIhbGMfiv7KeLWsqnVSYSy9Np8oNIw6tXvylLHRZxIqK4PvP2o9am3dL2gP/+D
         v8du1I67oRCjV/1kQTKyWjMqm5jZiFucwlFBneeUOct2wwjLd8R0tHul52MBaYFO9Vjq
         /Y/PiBvIJ75GtVzZU6RuHRZtkj7iBu4cNlbCxYZaPpyQ0RbrBvo3km5kwSyGqL31Y2Fr
         3932dgInOXx0XxxKOzu9D/Cy6pqJ9OFZUKfJiU7avkJ77cJOzmmOp+UNXmoLCdENliqN
         AanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnuUZjyAwIJ6ymLA0rIZe03StYDWDWvSlRWwtV0CwP4MchvMbYgPaicC+m1hO9X14EUiiqkmyKA1PuPsuK9Px/G7w1zDQqd5ZrSYG
X-Gm-Message-State: AOJu0YzvqUR1vPOrS/2uddzMvELVhF3XWJL4ZUwoY9GdKrLOm+vtzkbs
	qAAgDJNQidt6nrx6qAYUZkqMuiJPLOQ2/dGPXp69qXL3WuF/T38OFJHNSGldxykzC77RFdkma2Z
	FKhTgabQU9FZ+hZctbhrP3cHlrl/GzUFS1h9uyA==
X-Google-Smtp-Source: AGHT+IE+KSmXFhVMcyJZLEkbye0ZYJjFaJcaj51lNhC7WdFyAu+ZtqEyfZmnsslyKb2iSISSTnL1654PSvzdq5Z6Gns=
X-Received: by 2002:ac2:41c8:0:b0:515:95cd:6802 with SMTP id
 d8-20020ac241c8000000b0051595cd6802mr9184531lfi.64.1712142564017; Wed, 03 Apr
 2024 04:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com> <ZgxRzyQGeSAl4MzX@smile.fi.intel.com>
In-Reply-To: <ZgxRzyQGeSAl4MzX@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 13:09:13 +0200
Message-ID: <CAMRc=Md_81qY02=XPmQA5_EWRC1eU0zYAjRwjbAGxvGg2kOL+A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpiolib: Get rid of gpio_free_array()/gpio_request_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 07, 2024 at 03:49:02PM +0200, Andy Shevchenko wrote:
> > There are only two users left of the gpio_free_array()/gpio_request_arr=
ay().
> > Convert them to very basic legacy APIs (it requires much less work for
> > now) and drop no more used gpio_free_array()/gpio_request_array().
>
> Any comments on this? We really want to get rid of the legacy APIs.
>

I applied the patches, they only touch the GPIO part in legacy
platform code. It's not very controversial IMO.

Bart

