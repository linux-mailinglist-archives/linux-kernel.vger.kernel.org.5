Return-Path: <linux-kernel+bounces-9766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95081CB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4343C1F224AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E31C6A5;
	Fri, 22 Dec 2023 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai/Z29l7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4B19448;
	Fri, 22 Dec 2023 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3dee5f534so21487435ad.1;
        Fri, 22 Dec 2023 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703254124; x=1703858924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALri2eMSESu+FgTwD0iwT9uF+Jqz1cm7mO+PL715Tss=;
        b=Ai/Z29l7WYvVzaLEnOm1wl3G/Nb20TOm8OR7C2/QF0T+nvuCggmHOSc4U+cBhAGY1R
         LYnkhsGbsFN6YqY9uY5/VyZa1dbGqm9mWJjF4/28V5INEE/Zu8/aA5qWaQoTGr0euOSl
         02bDesMhz4JelADAsvTaQJbzcSHvMalD1x7g3x1xdO7WW02PpJ/C4T4hGCmgHcKaRLNO
         e7piWJf0dDgbBQt6Q0FLsJN6QT/dDMPdFo38R77r5SPpXsIc8MU5CHKmmvD1YXbgTbS2
         o38qHe593e4UqWA3/NYopSIqr7Kv+uHT9j6xXYp9P0lejobEQ76Z6c4C7d6HSvkbOx+q
         YMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254124; x=1703858924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALri2eMSESu+FgTwD0iwT9uF+Jqz1cm7mO+PL715Tss=;
        b=Z8pgEC12U8d4OV7Ud7hO2sM6rl4eRlS+l9AEyN6iCppJFKjV5btltFGrGxEB6xcnLd
         532Lz2345KXVewYeyB615x6vq5IW8APfLBZbTyqNljiZ3f3Z2Igo27O9JoQTIbOwYbyt
         zJ9uu8NJt0c+scd9ZPpkSJRjM92xAKS9asNgU0+4vT/0VhCklOJT51YDrOyFj97EmTm6
         zmGqbwP1pxymVbCzaXuSfOec8oLgb2rlWkuEuZhLh4K30tWncGDUu6Yn8+HCXRyizx8H
         PTee6iIhaTv3e31fqwurZwI5mj2Zp1jeB5QlAVqEuHFZbbkct8hc5fRtTG5KkVWFGPVM
         Fl8g==
X-Gm-Message-State: AOJu0Yyhx9OniwrWJQwDS7lDOr265dqnIgkH8I8iuu+q9YZVZMS1oM0A
	lqdsvmoZYsr/wbbN5aiSunk=
X-Google-Smtp-Source: AGHT+IHzzMZem40KBCv6EJ4U7muqnzhfj16KAMldZC/4rUKFXF0d9SOhmKwZiAqiGeq2sparunHHwQ==
X-Received: by 2002:a17:902:7048:b0:1d3:da9c:e5d7 with SMTP id h8-20020a170902704800b001d3da9ce5d7mr1638505plt.33.1703254124246;
        Fri, 22 Dec 2023 06:08:44 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902a50400b001cfd2cb1907sm3459858plq.206.2023.12.22.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:08:43 -0800 (PST)
Date: Fri, 22 Dec 2023 22:08:39 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYWYZ6Ys3hSb4IOe@rigel>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
 <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel>
 <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>

On Fri, Dec 22, 2023 at 02:37:43PM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 22, 2023 at 1:56 PM Kent Gibson <warthog618@gmail.com> wrote:
> >

> > > > And you could've included me in the Cc so I didn't just find it by
> > > > accident.
> > >
> > > Maybe it's time to add you to the MAINTAINERS for this file as a designated
> > > reviewer?
> > >
> >
> > You are patching my recent change that you yourself reviewed only days
> > ago. I would think that you would Cc me whether I were a maintainer or
> > not as I'm very likely to have relevant feedback.
>
> On that note: do you see yourself as a full GPIO reviewer or do you
> prefer I split out the uAPI part into a separate section in
> MAINTAINERS and nominate you as its maintainer?
>

Not sure I'm comfortable with either.

Definitely not full GPIO.  I don't feel sufficiently familiar with GPIO
and the related subsystems to qualify.

Splitting out cdev and the uAPI makes more sense to me, but in my mind at
least even that requires a level of commitment higher than the rather
spotty attention I've been providing recently.
I'm more inclined to leave it as is.

Cheers,
Kent.

