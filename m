Return-Path: <linux-kernel+bounces-6854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F4819E89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334971F274B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6D21A17;
	Wed, 20 Dec 2023 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZCFzj3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34E2232C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbd4608121fso2594089276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703073361; x=1703678161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoU9Jsp7eaiJ/AocK9g8uZTZIG/z7L3SRiAFrDPyw/I=;
        b=aZCFzj3LMVCB1ysxNChD+IjYxypcHEwIduKzZhK2s2qmn+7sMfbuM5cQhV6KsDHCJp
         OfT7FNGDRQ4TEDGQjDuddJkI0kSc0RPJ608SNcCfkBfuTh1RBvb6OifDmbAOVJfV3yuq
         8/ThSNLxA8xHqFZYIzJwerhfVvg+Q8+P+Rd/tLttx81O04AIWocKZad6IwX0mKW2aWKo
         d7fciy2HLEEShRRAVY6hJ4PelaeYCiqggPZwZYXB6hzouttoIVmKv9fijiqB8LTVJsQD
         JRlCf7eVmzVhDV3yUMgLsMhqaLGM8VuORKoQ/+7rc7mddAcZjqZAFDqaaSw0Y7sJTh2F
         hT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073361; x=1703678161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoU9Jsp7eaiJ/AocK9g8uZTZIG/z7L3SRiAFrDPyw/I=;
        b=Wn4E8IQlmCxSm1NRZRhRn8s6xiBA0Ht9IG4f4W5/Pyc2Isc5LRHcafusRiwvsxN3zz
         1ceQapv++oLYm2jxHdIvbfrC0e2MlykH8P6oJt2csqp5AhQVuVxh6ovJnPsmDyjdyZOg
         QyhtFfYkfwRB8XhL6bkdJYTFa715Ir/8AsAiMLonDQ9ggfV8h7LK/skEznm1y9qGfJHK
         FcM8FKVFcfB5q3TRhqDd4KP2G/ehscDbKi3so1AuPS7A8QaWVCVSti75pENiWghnC6zt
         tZhYmcM6/BZ12E3Rd/csN1m/gxxBC5BxEdkWhU1E0oifhQLrDu5lnIHzDv0G0Lc44l2y
         qygQ==
X-Gm-Message-State: AOJu0Yy2HH2e9XPriQ+hFZrvzGGWgA4YyYn8G+yaQPns7Yq5RFhEBH1U
	ret37Egoc3/NCTn+ikiUTIiGDyPfCqcpk5472NAvwm9t2VZ+7sG9
X-Google-Smtp-Source: AGHT+IGGxsfCRVmbm+Co88VpTfAbvKAxcCWJJn2U+M20G3pfXTLtJkpGvskb9ntouVMcht0C4akANZ6X5zt5fmDF2L0=
X-Received: by 2002:a25:aa2e:0:b0:dbc:d38f:da48 with SMTP id
 s43-20020a25aa2e000000b00dbcd38fda48mr6920174ybi.28.1703073361472; Wed, 20
 Dec 2023 03:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220015106.16732-1-warthog618@gmail.com> <20231220015106.16732-5-warthog618@gmail.com>
In-Reply-To: <20231220015106.16732-5-warthog618@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:55:50 +0100
Message-ID: <CACRpkdZ5HzOxtbexQNE-A-bKhiUW1nHjvJQA_CCnmVXf+R6dbg@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
To: Kent Gibson <warthog618@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(+PeterZ)

On Wed, Dec 20, 2023 at 2:52=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:

> Replace the wrapping functions that inhibit removal of the gpio_device
> with equivalent guard macros.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
(...)
> +DEFINE_CLASS(_read_sem_guard,
> +            struct rw_semaphore *,
> +            up_read(_T),
> +            ({
> +               down_read(sem);
> +               sem;
> +            }),
> +            struct rw_semaphore *sem);

Isn't this so generic that it should be in <linux/cleanup.h>?

Otherwise all the patches look good to me.

Yours,
Linus Walleij

