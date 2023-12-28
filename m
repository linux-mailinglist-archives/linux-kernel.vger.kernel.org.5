Return-Path: <linux-kernel+bounces-12321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17C81F35D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E2C1C210FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA7637;
	Thu, 28 Dec 2023 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFS20mxK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57181368
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e7f0bf46a2so46620767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703723184; x=1704327984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LrHXPwrA94UWexKglXOYSXxae6NHDJXHVO3uKsVohg=;
        b=dFS20mxKpwqlFCs0f+RNV5oteNpLb8cMAC1P1Vt3b1wRDC254PeX8xVx51YRVBLnuT
         WWUP2cpkayUnLg5BwqGRvZKpptq8GKFew6Mui3f3TMb/awQvASY00/mSKLUKGWCtapme
         UdxA+2lizII+r8fdBQg7hmA5RSB5KOCaZBgsOzBTm30wr7LKja8NiGfN3g7MbGNdUajD
         52vbykjmc3y5jYETb79OPX0NAfzYA9IVN7hGI96QXsU3ovnRfY5znbFMgoqinRoOfPhO
         wtJh3Ne8/qxuoC7W+972jr2QAN/YEJIapHWLbv43BpeILMNeAwgkeK1A1trdGRBQ4bGb
         Q5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723184; x=1704327984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LrHXPwrA94UWexKglXOYSXxae6NHDJXHVO3uKsVohg=;
        b=C44XXL3HDO2WmgAQy9g0ilcAzU+o/4vDFK09BwLCoqo7HMsB7+kZGwdWGSQOcziqKb
         vtTLH2XmXr71Fax3FvUUWworWGPU5JG5kRvUIUDsOXOXvvLKrCqSZLrr/1xYCmkyz8Wc
         Ry7op9dQejDhx46q5BD88gM3eVbeTd4peAggibKTmYa6MoQtcXUQauBkq+EhH6fyChPN
         /qe0CFd8JWHeey8dJuK6baE5uRznr7dkZtNjbOxymBJsMk6rGq9wV+xEFZ9uBt/D8l2n
         mTK712jCZECz90ftBjyGCuR8nIEJuce6EPwpsdaq+35a4q2usAYy5X4PvVOINF9nG3kZ
         vmSA==
X-Gm-Message-State: AOJu0Yxr4RcfDYfWA31UqEdILXYTUyevon3M7DTy03sdb6vWfVEQqbbw
	tYSj1gkJj5pN3NBT/3BnHDgMHgPx1G5kNPBbxo5oLxsN+wHcVA==
X-Google-Smtp-Source: AGHT+IESVq5n0e7oP1b/tJTd29cZ1WSG2HZHIL3RRYJg92NdYDbTPukugI9kwpvhkgABC5ifi5MghjbOCgoyfMySJxs=
X-Received: by 2002:a81:b722:0:b0:5ec:f73b:711f with SMTP id
 v34-20020a81b722000000b005ecf73b711fmr2249196ywh.31.1703723184389; Wed, 27
 Dec 2023 16:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel> <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel> <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
 <ZYWYZ6Ys3hSb4IOe@rigel> <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>
 <ZYWZ4yhqzTF8rShe@rigel> <CACRpkdZrnOJ-Sjj4VpuVU0Gvzca_uGN9Um5Zj=bRMH2df4kRZw@mail.gmail.com>
 <ZYZBDu1HjtU23fnB@rigel>
In-Reply-To: <ZYZBDu1HjtU23fnB@rigel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Dec 2023 01:26:13 +0100
Message-ID: <CACRpkda9j+5zT58vqip-JjtNQEZ+dWFLxdCmmLN8GpS8R8e7zA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Sat, Dec 23, 2023 at 3:08=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:

> There is no escaping that my fingerprints are all over that so it does
> make sense to list me over you. Given that patch and git-tree management
> will be deferred to the GPIO subsystem/Bart, there isn't much distinction
> between a reviewer and a maintainer, so I'm ok with being listed as a
> maintainer - I'll just have to pay a bit more attention to the list mails
> than I have been.

You're doing fine with responsiveness and feedback is always timely
and verbose, so just keep doing what you do :)

Yours,
Linus Walleij

