Return-Path: <linux-kernel+bounces-6281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C198B8196B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62694B24CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40088486;
	Wed, 20 Dec 2023 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIUcbNcR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6587495;
	Wed, 20 Dec 2023 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so3487229fac.2;
        Tue, 19 Dec 2023 18:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703038111; x=1703642911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjeS8X3fmdqPGuemVYfVj9DkgcxhP7o4H7pZnv9xxF8=;
        b=hIUcbNcRt4z9TPvlRY17a9d+Zs2K/Sm2gutLK7bBA7hMM2sH7xw9k8RiijOpAulg+L
         K86LBh9y/3IZoQ1DNEEZXiOgiFjz6hygSpnT7lhhNPSm0G9WMxRc5aUhAF8wvRk/vQqq
         BHH2NsZTz41f+2kc3hhL7fPBgaaxupAouhIt3L4eOwBcgpf1dcVoho0cqqB3vnlo0ZYD
         zoPMJslq27+Wze2C+goFiasY9nohlInQKgqsEYyXB0UGWl/fpIywpjD07RFVNllXs0xp
         9KIbplJsAedynhXbH2Y5va1rAJN4LG5G6R9Bg4TEQlzusFgr3IR9kBkkJd+7ZM43lUw9
         IUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703038111; x=1703642911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjeS8X3fmdqPGuemVYfVj9DkgcxhP7o4H7pZnv9xxF8=;
        b=UmNthNZQIPBnnQXV2vNvAY5TuHB7CDZP/4i0ecoBkPapRGZhXHPhx9Rm02YT+NPYoG
         0wI+Tz8mCWqOFP9TgTzh+k4L17y+XIpenDclprgqr2lCWdssTRgXnh4Emkp/JQnOwS4m
         0Bi0vyVrj814MfCX83w6zopxOKWr7WGN4pzIwDB2F6LEcvpDpqgCzd0AhIAE+6FbYwQI
         lvtKKO0azcBmRzvsaNCzzZTH1n4pioCqec9rOz6E5Z75rvoktMXMsezbh5uEIxAifj9y
         /YJczPpc+3hfRudoUzah4f90TB0QZQZqOnd2AIJ80281t4pIaVvYRY4IMg1va/iFEAzq
         zyLg==
X-Gm-Message-State: AOJu0YzVIix5M/7M6Up5OJbQEfUWStFDJwUwtsAwTkJ/mn8Q1DZfPWEY
	nSHtO6w4VUHUa+M5Zk728aoPDDm1F53yfnR8KW8=
X-Google-Smtp-Source: AGHT+IFc5SlSNo2vXdyZYhV5piQDmMJOO3RDpB1gO55nP4APrFg18udSPPQisdqt78xRYNjYWTzX55LmMk06P5SRgDM=
X-Received: by 2002:a05:6870:cb87:b0:204:de5:a581 with SMTP id
 ov7-20020a056870cb8700b002040de5a581mr151122oab.35.1703038111578; Tue, 19 Dec
 2023 18:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129110853.94344-1-lukasz.luba@arm.com> <20231129110853.94344-24-lukasz.luba@arm.com>
 <CAB8ipk_Zx5NtSpNXHsAqpZSq2yVHGAni5sN=ot5Lkc0jGZxoxA@mail.gmail.com> <cbb2ae63-eb51-451a-b202-2a1c447a93e9@arm.com>
In-Reply-To: <cbb2ae63-eb51-451a-b202-2a1c447a93e9@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 20 Dec 2023 10:08:20 +0800
Message-ID: <CAB8ipk8jsgUufoMB+z8=YQyOXyia91L-QGCTNuFeKngVBx5ZWA@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:31=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 12/19/23 06:22, Xuewen Yan wrote:
> > Hi Lukasz,
> >
> > On Wed, Nov 29, 2023 at 7:11=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
>
> [snip]
>
> >> +
> >> +  -> drivers/soc/example/example_em_mod.c
> >> +
> >> +  01   static void foo_get_new_em(struct device *dev)
> >
> > Because now some drivers use the dev_pm_opp_of_register_em() to
> > register energy model,
> > and maybe we can add a new function to update the energy model using
> > "EM_SET_ACTIVE_POWER_CB(em_cb, cb)"
> > instead of letting users set power again?
> >
>
> There are different usage of this EM feature:
> 1. Adjust power values after boot is finish and e.g. ASV in Exynos
>     has adjusted new voltage values in the OPP framework. It's
>     due to chip binning. I have described that in conversation
>     below patch 22/23. I'm going to send a patch for that
>     platform and OPP fwk later as a follow up to this series.

I understand what you mean, what I mean is that if we can provide an
interface for changing EM of opp fwk, it will be more friendly for
those users who use opp, because then they don't have to calculate the
new EM by themselves, but only need After updating the voltage of opp,
just call this interface directly.

BR
---
xuewen

> 2. Change the EM power values after long gaming, when the GPU
>     heats up the SoC heavily and CPUs start increase the leakage
> 3. Change the EM for long running heavy apps, e.g. video conference app,
>     which is using camera w/ image AI and filters (so some heavy stuff)
> 4. any other optimization that vendor/OEM like to have for

