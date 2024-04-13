Return-Path: <linux-kernel+bounces-143610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A038A3B66
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F131F227E1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DA1CD2D;
	Sat, 13 Apr 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="ML95mva9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2263101D5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992471; cv=none; b=kFxMcAZ6Vt6NAWxyKvyg+jSlJEN2ZM/lHoAQ9wqK0lKCcCvbSwkuREusNAH0CLghrtV/YlVuPY2YfVZZhn/S+UKRXIAtwO6VqdYHokXVM4N0OBlU+9hVTpCt470W9hmcq9ctBrzMEHw1sZLbRFuAQrzzT3aqSqS8BIgjY22e7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992471; c=relaxed/simple;
	bh=o3+z2gjvWYe3ycjNtnxQBlBPcTLvyVZ3uulsKyfAvvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD/oNel5kAxEnMvBT5yZkhCHKbk8r1OmYmvh6W2nRq75hMVql10a5IIo19DWhF6EA8ui27EN8lJVAfcp9VkOKnpZ6y6g6U7DR13WQ/hbvFAqSNFMN0AEbTxHaPxM9Zfgjf21ECzLxypBl0F1S4TsUbeFVjeM2qYxPpK4cRUuo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=ML95mva9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so479540a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1712992468; x=1713597268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HHtPvGouLUwNBinHLkaycjej5YlmhYQaDzE3CvXbqE=;
        b=ML95mva9yTzx2l+b/6u3g9jWv5UDHCZzA6zJfTAlo9Pr1MrKAg2F8ScGGRSZJOe0og
         tDTrhpDvAIJ5CJT1bEziN6OYQ0Jf8gMMQwbEISNdapdXDBOh3S+bYdr3lOh3kVRvwBKW
         8JK37gisChfFtkttjg0SNHShiIq36n99kagrSDcNhjQ3Fj1Y4vUjcy0/d2HFl1qk0Gic
         0YPYPn9t4GqKKXYEWlW4SqBBHm0djueYhbaeMbyKLCRIsICg9QdGjGtrwrIIS3BXUVQL
         2hgj0I3q5nArW/C/2RBZPXcBlT6mAruhuRd/q3dgvM+Nq1iniiQXqKiBVscVkdZfX/Kx
         gNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712992468; x=1713597268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HHtPvGouLUwNBinHLkaycjej5YlmhYQaDzE3CvXbqE=;
        b=WUlQIhN24KVUg4RXS+GEniRDvbC0vlA7gyilTkrh3Q9pjAeQpvFK3Q7y/5FBcpPedC
         6MA/cf6Im50B2w8EeRnhpcTj8eyHtp8m1e5Z+7bdIe5CBfLJn+9ssTEd2F15ZJKTZq/j
         9p2NL0R6SqPZQDs9mBF12o896H0QCTRNWCgLAPKUknWQCLewlVSXFFrjvRz2QjkaRpWm
         Ij0pkVeyq92mwc+3SWAa3xNm0nuQbr4JrMaFAySOuoXRZaCRK2CauATzRruTYNO1D2Ja
         gmGjJYzZVzKsgtww0p6GMsH0qn2Eqw3O8YCuYR7B1ZZtTnJueEMYSfFRX2tU4nO0sqxJ
         /PNg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpg+boojrNqV+n0QLCOAH7T1/hnpWNlJ7+xsnYRyehaVB1uRZwSpLHtsTnPgZFkO5cViQwMn/uhF/lnDuvch3tVBaMcYKBg/HT+JH
X-Gm-Message-State: AOJu0YxoYn0MyRKtTIveGDBkU2pWTVAPceLJ4xsdAyTWfP5eQNQgECwx
	jAJlbkUhAjQXIr5bY63yWgEF6QRH1bw/rWv/QeMr7UPgum3NBB65WM+kwj1ZJ8KF8q1og0Fcvmm
	Ed4/JS0B20V4S/TyPBwirgARfM/lwbTC4p2t0GA==
X-Google-Smtp-Source: AGHT+IGjKQPBWk3zY4ooVWSwwjx8svo3iMnk4hrUD8lrSsQHtU9YoU3a9b5yDiFZBd6peTfPY9ZB3ENbAOeulzcfskI=
X-Received: by 2002:a50:8754:0:b0:56e:2a38:1fb3 with SMTP id
 20-20020a508754000000b0056e2a381fb3mr3884604edv.4.1712992467646; Sat, 13 Apr
 2024 00:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413064225.39643-1-jenneron@postmarketos.org> <20240413064225.39643-2-jenneron@postmarketos.org>
In-Reply-To: <20240413064225.39643-2-jenneron@postmarketos.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Sat, 13 Apr 2024 02:14:16 -0500
Message-ID: <CAKXuJqg43-QVWAANyt3_z3fEVrHtXqVuJy5OFNMEZz=STDZQ0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] soundwire: qcom: disable stop clock on 1.3.0 and below
To: Anton Bambura <jenneron@postmarketos.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Sanyog Kale <sanyog.r.kale@intel.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

On Sat, Apr 13, 2024 at 1:43=E2=80=AFAM Anton Bambura <jenneron@postmarketo=
s.org> wrote:
>
> This patch returns back the behavior of disabling stop clock on soundwire
> 1.3.0 and below which seems to have been altered by accident which
> results in broken audio on sdm845 + wcd9340. For example, on AYN Odin and
> Lenovo Yoga C630 devices.
>
> Fixes: 4830bfa2c812 ("soundwire: qcom: set clk stop need reset flag at ru=
ntime")
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---
>  drivers/soundwire/qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index a1e2d6c98186..bc03484a28e8 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -628,6 +628,9 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>                         }
>                 }
>
> +               if (ctrl->version <=3D SWRM_VERSION_1_3_0)
> +                       ctrl->clock_stop_not_supported =3D true;
> +
>                 if (!found) {
>                         qcom_swrm_set_slave_dev_num(bus, NULL, i);
>                         sdw_slave_add(bus, &id, NULL);
> --
> 2.43.0
>
>
Tested on the Lenovo Yoga C630
Tested-by: Steev Klimaszewski <steev@kali.org>

-- steev

