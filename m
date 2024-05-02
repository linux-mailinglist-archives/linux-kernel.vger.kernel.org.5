Return-Path: <linux-kernel+bounces-166082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0A8B95F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B4F1C21253
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7D4E1C9;
	Thu,  2 May 2024 07:56:55 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39327524B8;
	Thu,  2 May 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636615; cv=none; b=evm/wruWXwR95OROGV4Kr9riTNR/DX0LQBs7Q+t0kvCVAYFBpn7D5Z6mZuePPozXWYvlTW9aKra+H2/ndmgcEnQvhYzfk4ZKWkltfRIOX3qQBu9xRV1e8H3xGD+TLeSQyRJbB5Jf6NhEmhsOWexrndqCZHzx66l4QvddG1nMv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636615; c=relaxed/simple;
	bh=ypJWL7x/X6X6oULQbgFITZTwqrdEjdeGT/HY2pn/rb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR0YXVuT1qEUXLhSvjkmiZgz/PMO0xqrKJB8h2pLtNqTTLpZST7GyjhLV1NuT/cpkX35nQ5Ahb8kbk4ZAUKCIes2kv4nbhhOwthg0nGcQlgD2NJ10N/+Gc5EYM2K2ZUvHZ+C0CUNOntinh048WlzOEwKPjEo0eP5bSmO0MVp6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de6074a464aso3571135276.0;
        Thu, 02 May 2024 00:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636612; x=1715241412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izYgKy1POKCUq3cIGK/Mh2mBGgIcZ6Da6ueKIohPZtg=;
        b=hxX1TvBzX6xKRcW5qn1b9Mvb0J8g6fR8lvyPd59+IsWmP35ZHRqvHXx8ud9Hr6n4eT
         xLTjEPlXQdy/nh+RFs/G56Mx9von0g99ZsfjGA4rxll/iavCZnaoBfSj4yeMIc/jkXnR
         a3i1tUKgscMBo/RTWD9zmGaIKOTACeBUBK/XfnMy44p4qbFPLt9kKBa/MKw6T/FkfdGM
         MUmt35cIENYdEBBOadRry/pPSf45ps6UNCNMYokxuDrtbfwirQSpfD2oS77Weceibmcd
         o8aKOAySpdUGIXny0hqqLWbks68XBnUrwlvKgoEp3bBkBvHopJF3u28olTRM9XYrZzG7
         TmZg==
X-Forwarded-Encrypted: i=1; AJvYcCXBCPGUU+RHNEH0QkUdfjW+HAZ8kkoQiyrUEM9JQc94deO4//UOalCOps0FoQcjiFgISpvwi+8wAdB0kpps0APtsedC9Aeif5SRy8R43wngGvT288RbINS/lgpHGgSXKgL/JaeUdXIpdgs9I3vCtnU8sOMLupVZWgVfM333rFNXF2iDfK2PPGdbEx+g
X-Gm-Message-State: AOJu0YyWMiTn5TqwypQ7cJ8nPlVjBV4ZZWbAl8F0oY8ejWVUHseTDANv
	Pp/sdmsD/IkSORyrLzAYMea37k00p8X46dPEIjEbzJKszWk4SlvPu4cNQT8c
X-Google-Smtp-Source: AGHT+IFoyhiad9yaMA8qlGFA6eE7zUQTP6bhNtz3wSNg7UElhdASCMH3Mk+wymtUdF8+ypzkP197zA==
X-Received: by 2002:a25:d347:0:b0:de6:37e:e103 with SMTP id e68-20020a25d347000000b00de6037ee103mr5695750ybf.7.1714636611690;
        Thu, 02 May 2024 00:56:51 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id g21-20020a25b115000000b00de8a9ba531bsm86009ybj.60.2024.05.02.00.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:56:51 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61af74a010aso75863757b3.0;
        Thu, 02 May 2024 00:56:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNWekZ7+DkGVhBSItrnj6AKENd21/vaHe3uhkIwe1wfKSCPaH6WEzcYjr7xTd/2O4FqumGSxe/qFfOYtCo/5g+AupTZqPHoAXtQlaWkCeeauESnFjJAjMv06WnYgor5FXCgpq7xwxfUzOkFXBWrlkkniJa085xfTXr10Ju/1j3qZ590mz8O6aMptnD
X-Received: by 2002:a25:d041:0:b0:dc7:5c37:5420 with SMTP id
 h62-20020a25d041000000b00dc75c375420mr5690048ybg.60.1714636611197; Thu, 02
 May 2024 00:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb6b85722d80d665779e3043d1499c4fc38f0ff3.1714562004.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <bb6b85722d80d665779e3043d1499c4fc38f0ff3.1714562004.git.mirq-linux@rere.qmqm.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 May 2024 09:56:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUy+e1vQRBUfo2paBJi4pro-tKf9hOe3YaddcB=OtRfJw@mail.gmail.com>
Message-ID: <CAMuHMdUy+e1vQRBUfo2paBJi4pro-tKf9hOe3YaddcB=OtRfJw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas/sh73a0: use rdev_get_drvdata()
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Wed, May 1, 2024 at 1:16=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-linu=
x@rere.qmqm.pl> wrote:
> Replace `reg_data` access with the official wrapper. The field is going
> away soon.

Thanks for your patch!

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404301218.URkWO6dj-lkp@i=
ntel.com/

I am not sure these tags are needed, as the issue is not present in
any tree yet?

> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Do you want me to pick this up (for v6.11), or do you want to queue
this with the other patches from the series that removes reg_data?
Please let me know.
In case of the latter:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

