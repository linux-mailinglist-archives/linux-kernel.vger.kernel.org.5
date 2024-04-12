Return-Path: <linux-kernel+bounces-143257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE518A3660
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F81F223AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181915099F;
	Fri, 12 Apr 2024 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pnVaRNS1"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F0150990
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950174; cv=none; b=H/3xTk7+SF7zAJVZmjdiuhZTJA6mbFwKXc1O+tkbXYzZbk1iiETdWyLSBllFkRKSOVq+nM3FZz1OzIPq+KYYjuw4RNGtfN22TlPcWq8okuQLYFmii28D6LYDmj7VkIr4AREMXbrDJpww3bpEB1VPjPxaTY1ht2F9GEFLRDfwbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950174; c=relaxed/simple;
	bh=dMU3YTqYEj6Pq0v0+vb73IdcglOkFpGJFmjvvfyr1GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBrKziHalK1VvUsN0Vf0uyAvCNXrWQ6Da8dStOxcSUwbn9Nlw38ZkTtYi3UK06Bybj8OWF1JMG3XZ0cFZ4XbhT5FM/RHgkSkFtaCewmtXtciTgXl6UzJcHwfJZgEhRjpB0b60ubhjF1vqySICgUaH5eT2Wl9tBaq8o1zLYJ/POM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pnVaRNS1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d886f17740so24114351fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712950170; x=1713554970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMU3YTqYEj6Pq0v0+vb73IdcglOkFpGJFmjvvfyr1GM=;
        b=pnVaRNS1SIhV6qcMvXag+Ts1k+LJs1E1TkQHB6wDhvW/HnYkCnXjgO5br3fjDwzAgz
         04yet4YmlPsb03hSaGAB6ogU5sVvu156av8irkeszqCK5VLM77s1/B+KtzI0IRro/yxi
         Y0uS34W7RhgJb8nDRPFPSbavEz43RhNkfACjQHDrU0kJAxba0ysSGQZuZpsbnCFJA/IY
         P61fFVM2DiaUkb5piD+EjJOmxPJzMSvOXqsiVvDRNyvqWU8eJxu2iW1kmJTtwmSsybaW
         tSQok7e1uvX1vBhifiyhGtYkHHh+Av1DO+cAACcxkU4NcJEuyhECU54IVMi36uZRQSGq
         OVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950170; x=1713554970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMU3YTqYEj6Pq0v0+vb73IdcglOkFpGJFmjvvfyr1GM=;
        b=LZ4HQO8Tr4ldwOnuX/Y5VtkY2jPR0wPOHmtbtunT8uu4iU0r3pJCn6oQVxIzkCAb00
         6rNJ9j7B4V5TKnJKt8wDgOcO5mNSYIpS7IC3V+hruodWd1dRQH30m3cZ4xrRIAO9xSOW
         LudH6t4/xUYwnYUO3E3XLeMPIPp+UcIPzqf5syFa0Rloqy9KNw7lBFWaxNlEZs18JZuP
         pBJBishtqh/jlfFwsYtqAPDlH40IAbr5oZwk4evtDNEg++WM7kQ9vwOqOPY5DFYXjgD2
         3K475VUYNWPyjJciW3Bye9z6yvcMCTjzUoLbfkqhFIzaTpMitjof3L8jfP5juy0ZvpaB
         Dheg==
X-Forwarded-Encrypted: i=1; AJvYcCX+CbsaY05wu56FKrexN1kBMLiHyy/unRpy6lkzwO7wtwF/vjQAXhOqUKYA214o6WXFClJ+UxkuicGI0EYGgiRFJLyZP2cuP0CC0MEc
X-Gm-Message-State: AOJu0YzvGPZrDheAlGuKze8rEoDsfm8D6bfK8OL/S/yje2eOdqLJpOVl
	1nsmc5YbGAcHYbo5AMZkP7hhJwDEK0JMouIV0YlBeEzBMXmpzBo8qVfbqqlusg81mpCua2L9++5
	PqNj22j+Ee7feTjjSVOCHfbAjKCE+Jt+pvujFLg==
X-Google-Smtp-Source: AGHT+IFPPr7frvWajQHGbkpxINHZewvW3o7jH7+UGGjVYe6zp1bkg8rR8QuGlvgmrYeG+47sm5i6VRjBLlopWWTUIBw=
X-Received: by 2002:a2e:a70e:0:b0:2d8:cea3:85e7 with SMTP id
 s14-20020a2ea70e000000b002d8cea385e7mr1073208lje.12.1712950170486; Fri, 12
 Apr 2024 12:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408233201.419893-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240408233201.419893-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Apr 2024 21:29:19 +0200
Message-ID: <CAMRc=MfnAYFPtk-pwtd496c-qry0aQs1NJCkTEQ+jLF+JGyxNQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: gpio: Replace leading TABs by
 spaces in the code blocks
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:32=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The code blocks are indented with two spaces, if the leading TAB
> is occurred the syntax highlighting might be broken in some editors.
> To prevent that unify all code blocks by using spaces instead of
> leading TAB(s).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart

