Return-Path: <linux-kernel+bounces-9981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6681CE18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE32289812
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A22E652;
	Fri, 22 Dec 2023 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3DMJsVq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70052E820
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7f0bf46a2so21291637b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703267355; x=1703872155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utm+2yHkG3fZSiIHEUczkFxwCnfccH1LyLjodi1y870=;
        b=V3DMJsVqD3poFGsdZPDxaA0VZAXZ0g7FY63+XBwb34p7a8SRB4sZjzbX4z7+mFMqxx
         VqH4WAzfEIPccs8eZXBn4tz5sPFK9KEyssVBGyZZ3MdsJL9DAbv4XXTPa15asDOi9jql
         CVjdS+HT42JkJ/mMh9IzS8h2zDeaeKrRhV9eYlff/HLrf6PGW+a/1kxznwUlEbKwEPii
         NQPNqMe3p16mo7oAGR+Hla6b/IXwiQQmyx+8jlfHGULJNV8D2AXgOOa8lxffTen2s+3e
         2DCYt7BiKmxvv+cFi5b1N+/jlzFQTi3LQn0SXmS190DrP+p6qv8Tx7lCSRHVXpQJsqkR
         Q+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267355; x=1703872155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Utm+2yHkG3fZSiIHEUczkFxwCnfccH1LyLjodi1y870=;
        b=D+AYDZCi+wS/J7kjOz9Q8daNXR8w/uqrma3zbsDcTpz06eMYdwzLwJMocHT9kUkshE
         VQ9vCnS3OkNEHlFte0GqVH5r6g4yrsMH5AETsKE9EtsasrfzlU8M5ygnnQhGxqwDiQSt
         lF86U3V4XC1Sb5nzSDWD+6t17U3akA/A7TX4+j494rKbK8kY6+w7zemPmfVzM5HxyuhO
         6slY6wUFx+ohWNBa4XzRjaV849LYj1NOyOQlHwVNRb2aQqjmXyfXAGlJvXjoEB+xPsaF
         ipLtkj4IK9MC/+b/U6o1U/gqbzxYVb5jEYPHHM+L7nGqi3dr8NJiqO3XWjg6d1kjj8vm
         6JyQ==
X-Gm-Message-State: AOJu0YxYaiFHtXLjWgm/s7YY+VLKqXuogSZ5fTKF/Bn9YwnU2JrfNssc
	WczGtNn986GSyqVIdjwRTgoh1nWgyfudwfpnHy5gR+XS6gssuw==
X-Google-Smtp-Source: AGHT+IFD8DHS9ixaA6LWB1+W401PUdDSE/BUGM5RkXc8LBSOg92SuxWffRwD9VeK6wNjEMwVp7gvdTv/Ep2A4HiW3LQ=
X-Received: by 2002:a81:8603:0:b0:5d7:1941:3560 with SMTP id
 w3-20020a818603000000b005d719413560mr1778094ywf.71.1703267354970; Fri, 22 Dec
 2023 09:49:14 -0800 (PST)
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
 <ZYWZ4yhqzTF8rShe@rigel>
In-Reply-To: <ZYWZ4yhqzTF8rShe@rigel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:49:03 +0100
Message-ID: <CACRpkdZrnOJ-Sjj4VpuVU0Gvzca_uGN9Um5Zj=bRMH2df4kRZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:15=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
> On Fri, Dec 22, 2023 at 03:09:54PM +0100, Bartosz Golaszewski wrote:

> > I can still split the uAPI files into their own section, make Linus
> > and myself maintainers and make you a reviewer, how about that?
>
> That is closer to the reality, so that would work for me.

Hmm I think of Kent as one of the main architects for UAPI v2
so I would like you as maintainer, and me to be dropped, I already
responded to that patch though.

Yours,
Linus Walleij

