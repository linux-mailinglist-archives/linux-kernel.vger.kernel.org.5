Return-Path: <linux-kernel+bounces-159510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF78B2F90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2DA1C22C88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A813A24E;
	Fri, 26 Apr 2024 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MP4XCCc4"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB73139D1A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107164; cv=none; b=ft4KL+zmwXA7o3HyaX5BOVgQNl0QfLWkUjlEHTUUVGWNMS0EnqP/o8kl4PJPrpIG11yP8HoTORYUR1Jb9PTA7FEUvzT6U/nf16y9VGcBmBeRoROX0d9YT7qDBgnMZRaIHhraBsFNjQ7KCUrKpZqb/gT85oHuCc+wcSwxH6IXHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107164; c=relaxed/simple;
	bh=qs6/3ZC4W1D5T8cAYs3RgXncpbBS3HYrCBKH4ql2Mp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayjYbXAOJWo06H1sYVPd2wG5R7NIp9EV8ZvyNWywuINM/igzWRRePWbRciiTbRuqiYFC+zfTsTiNbSkkwEnVvnf8vSNcUtrCQQhcPjx5gg/fO/AiksJ5YvCZ4Cpoy4kHd4RuN93VcujX6awt77b8P/+Pk0zofZIaorzA5AsOR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MP4XCCc4; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so1966314276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714107162; x=1714711962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZXe12WaAyX3gAwfbassFJFxdqFUc47BWiVX4qU4iLo=;
        b=MP4XCCc4wV5QhA7ccpyaJMa69wXKYE1c+R+yYpyqQJhGUydEntoHRoHPF/U2xIzy0A
         vbCMJYEH93QgPGz26ZvqJW2A1hfzT1Zry3enkQtm5tCIaDOln7jlqf+t7dawYcLDZaKH
         TTgf0kBi5rs6ZpjEymnyt7LwZ1FnbOVygYFRFaOs1cFUwDcqCFuVT9T6hxwU4NNicM5y
         p35TijH9OR4lhI8Vj+Hq7xo5wd+cNkMqN3PoaT6hFt+DSuUCUU1DLhjIsizexqyPHuf8
         EcUfte9PfVgF4YTM0BHWrwFeR5L6edT0W8n68zgv4kavqcWMh4+UxHH2yqxn8HAgLNvJ
         yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714107162; x=1714711962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZXe12WaAyX3gAwfbassFJFxdqFUc47BWiVX4qU4iLo=;
        b=LxgQj8+AvvKW3TDtz7QPDXhpQrWh62lNPDMEZPQMsBsAjXjEk5TOPpVJbe0D/lZ64h
         IAoORDN0p8KW7EOpCcpQbPHtEBWHwJKFywKL7o0GZ2Eq68ddrs+1pb/hoy1cO9V8Ku+L
         pxMts6gnltO2/9tokgvGN3l7qyGCv4BUdFCpBMntoNMEFHBYvyvhks9DHlpgU1HAMqaE
         QlDd1X+NbEa73OvI1EgVZ1Oazto/cYODfKbOkC4own3dUjvXum0AFVHuXD1Tf8S3GdkD
         6usk+3Oc1nMPd639WJcvUmNJMUz7wTSsO9tvzywtzh3+XuZc+E8AWVLvzKm2d+FiUuF5
         o37g==
X-Forwarded-Encrypted: i=1; AJvYcCUZPRBc9StxHCg71eLGQm9kFBKFHIY2NROq31LJn6ngbuX76eZMZNpizrua7UeXdMjofvuju1szGPRKz59SCXZmsB2NOl9D38nFeWw5
X-Gm-Message-State: AOJu0YzWLtaLTzjTTuMEacRxScaZXNZUEBe9Tt1jr0OcHDIg5EPeZ+SI
	bOecHGYnUhgn6rk2gE7F9HbeHbv2RjtHJjRcXJmdjwl1tV9bR3QLZxImqEK/1ioHiFiacJkAuAh
	P7EAry8yojEQhDUr/pBTesdh/sZV2xcZ2gV8QzGcz69EomIbm
X-Google-Smtp-Source: AGHT+IHiQzSgWICcRFbEEOtxtKCstKdz/LyMwtHklak68j+S5RDCxyNlviHiAzD377LOAzv/LKfA3QtAhqcZ0I4x8ZQ=
X-Received: by 2002:a05:6902:1a41:b0:de5:5a39:2cb0 with SMTP id
 cy1-20020a0569021a4100b00de55a392cb0mr1936117ybb.31.1714107161875; Thu, 25
 Apr 2024 21:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Apr 2024 06:52:05 +0200
Message-ID: <CAPDyKFpc=1bF5t1DHHDjGVq_xRh4W3yJp0PkGf_pn2T4teH2mA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: atmel-mci: Get rid of leftovers and clean up
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 19:09, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I used to have some patches against the driver, but it appears that part
> of it has been applied (in different form as done by someone else).
> However, there is still room to improve, hence this spring cleanup series.
>
> In v2:
> - dropped applied patches
> - fixed kernel-doc issue (LKP)
>
> Andy Shevchenko (2):
>   mmc: atmel-mci: Incapsulate used to be a platform data into host
>     structure
>   mmc: atmel-mci: Switch to use dev_err_probe()
>
>  drivers/mmc/host/atmel-mci.c | 72 ++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

