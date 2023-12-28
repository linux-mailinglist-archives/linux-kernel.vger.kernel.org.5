Return-Path: <linux-kernel+bounces-12330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132681F37B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B29C283E01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A98EA5;
	Thu, 28 Dec 2023 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aykBkaDf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E510E4;
	Thu, 28 Dec 2023 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e05abcaeso26234565ad.1;
        Wed, 27 Dec 2023 16:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703724592; x=1704329392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bgeaAk0wjakFWXH8x1gkpYZCJkAnW3C2smy5PZQoqqc=;
        b=aykBkaDfGky9oW+eW2wv6rT2ZCZXgrTkPivA9BBEQjufCk30d88cY7HnXxOeiwflBB
         hMQ3S2QkIgnrMx2kGb/Va96+3d6WS3fwG56rksuJD3TaKfKjcZZQ8W5U+qUUF1R51MSP
         /N0PUTJqR3RlnnbF6EJ927eioRIp3eUtYGGwyOD+25VVH8igZ4p8+JIqUzwwOqxjXMfa
         YaFrQUARiXZUKVyw5Fz/a3NTBw+zoUxSkeB/gxnNA2jCcTHSLCwq1h8HApYVpuArq81x
         Qf2m3DMaqnwwNWqcy92j0WYUXHJWn1CqYZpmdvfV3GPh5elbfaprlg3j1LnuAyULiq/p
         8vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703724592; x=1704329392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgeaAk0wjakFWXH8x1gkpYZCJkAnW3C2smy5PZQoqqc=;
        b=n0mwO+ixWxu2UhSHC1pwtXc7ChHcDK+uMHLj7DsRPW/xJC3Lnvg429wzYSIvxzAIT9
         XU0rLKlzxhjsFXir8l/ll12gSbv7BGx/V0ZHvL4hZeEK6+9qUXmJpfxfMt59q2Ri+ajy
         PgzS3EjzJ5Ijk1siDWlCu9K4Nw7WSxBJTrCd9JnIWObh868aWPRROBB0dHCIl4Ccqgus
         0SV4PFNjzPJQ8Jj/BivN0PJIGNV2lEj3hqlpCz+AstxxSHSjIVbtJuu1UZXpyoTYgPoi
         AjQgvNeFVoPmqM3L4M7wWqtgK2XE2fLaRU0rU0LYFFzFKyS4jln4CdEDtpO6eJCbQwFs
         GQNw==
X-Gm-Message-State: AOJu0YynQhJQg/OGQtQvhNuHZYzzWxCA3jSarhDR94pZaeMfBtc6tMMg
	r+yBVGN250stoYwNirnTbw7WczjFtIU=
X-Google-Smtp-Source: AGHT+IE2Y1UQbfVKIe0QW+Mr5bxzT1ZxN5V32PCI/WdrFg0lZaSnmoOGiEMMScOGTjuHK3hLRWk/lA==
X-Received: by 2002:a17:902:ee4d:b0:1d3:e474:b863 with SMTP id 13-20020a170902ee4d00b001d3e474b863mr4256701plo.88.1703724591867;
        Wed, 27 Dec 2023 16:49:51 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902a61100b001d43872309asm8736093plq.286.2023.12.27.16.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:49:51 -0800 (PST)
Date: Thu, 28 Dec 2023 08:49:46 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <20231228004946.GA21793@rigel>
References: <ZYTihbWMcHMHSkC_@rigel>
 <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel>
 <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
 <ZYWYZ6Ys3hSb4IOe@rigel>
 <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>
 <ZYWZ4yhqzTF8rShe@rigel>
 <CACRpkdZrnOJ-Sjj4VpuVU0Gvzca_uGN9Um5Zj=bRMH2df4kRZw@mail.gmail.com>
 <ZYZBDu1HjtU23fnB@rigel>
 <CACRpkda9j+5zT58vqip-JjtNQEZ+dWFLxdCmmLN8GpS8R8e7zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda9j+5zT58vqip-JjtNQEZ+dWFLxdCmmLN8GpS8R8e7zA@mail.gmail.com>

On Thu, Dec 28, 2023 at 01:26:13AM +0100, Linus Walleij wrote:
> Hi Kent,
>
> On Sat, Dec 23, 2023 at 3:08 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> > There is no escaping that my fingerprints are all over that so it does
> > make sense to list me over you. Given that patch and git-tree management
> > will be deferred to the GPIO subsystem/Bart, there isn't much distinction
> > between a reviewer and a maintainer, so I'm ok with being listed as a
> > maintainer - I'll just have to pay a bit more attention to the list mails
> > than I have been.
>
> You're doing fine with responsiveness and feedback is always timely
> and verbose, so just keep doing what you do :)
>

I endeavour to reply to direct mail promptly, but I was thinking more of
mail directed generally to the list and there have been times I haven't
checked the list for months.

Cheers,
Kent.


