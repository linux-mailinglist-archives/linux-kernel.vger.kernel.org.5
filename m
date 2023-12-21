Return-Path: <linux-kernel+bounces-8522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283381B8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2FBB27168
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAD6351B;
	Thu, 21 Dec 2023 13:47:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEA62815;
	Thu, 21 Dec 2023 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1ff010595f6so24904fac.1;
        Thu, 21 Dec 2023 05:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166448; x=1703771248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I18+KHcYU9LVNWT1j7IeCdABeIX+wJlsSl36dw3cVlY=;
        b=bvJ9zBDH1AWPQE3nj7DT4Kfrz7PGax5ZxG/NyGFsh/1QPvHZZsCpJmqIMh71g68SAL
         45xRY40DSJitBHDP8zNm38sQ78bqfOm+DKGefi7Vbl10peNbyoUyK9QoUE2ncjHhR4EA
         PGV5gkAyNBtoSiOI4WvM/Sx5tuvsGpvKOgX44+Oi403iSB0glIjlsDRwgnttHf8tmhUn
         obiYc0BjLdDhdcW52jRtjrnZasKZHFTYtcw7bOuWcMZUel4nnMy54O4vSIOnsBwVAeJv
         b5IrQQ+VkKI5Jv2LPkzRTfK9Af5RiDHO4tebAbrwXkDomSdm2uSdCtFHwhy2iagmz0jI
         0J+g==
X-Gm-Message-State: AOJu0Yw3lQrkm2npPKEnatv3M2ULLCm5sT6iL4tehNyAv8p1sn8Gjpre
	Wi620yqIdgP0/VPWF7jKNmwhG2AnYvOtKhdlRWg=
X-Google-Smtp-Source: AGHT+IGycU/rvF2NFQOBvNN7qjABSTsNMm2yrNgLN4uoMxiE/BM8qZZhhBVbQ3EDbrA1Avz3Q6swQf6aZEwjAeXf3+E=
X-Received: by 2002:a05:6870:b028:b0:1fb:e5f:c530 with SMTP id
 y40-20020a056870b02800b001fb0e5fc530mr39465533oae.4.1703166448497; Thu, 21
 Dec 2023 05:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <918945b6-8959-4228-b642-396ae346b20a@kernel.org>
In-Reply-To: <918945b6-8959-4228-b642-396ae346b20a@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 14:47:17 +0100
Message-ID: <CAJZ5v0goP-468FT0pw5AeAYd8sQamdc1-64pyrEdFwbWHO4WfQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.8
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:03=E2=80=AFAM Chanwoo Choi <chanwoo@kernel.org> =
wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.8. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.8
>
> for you to fetch changes up to aed5ed595960c6d301dcd4ed31aeaa7a8054c0c6:
>
>   PM / devfreq: Synchronize devfreq_monitor_[start/stop] (2023-12-19 07:5=
8:27 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.8
>
> Detailed description for this pull request:
> 1. Fix buffer overflow of trans_stat_show sysfs node on devfreq core
> - Fix buffer overflow of trans_stat_show sysfs node to replace
>   sprintf with scnprintf and then replace it with sysfs_emit
>   according to the syfs guide.
>
> 2. Fix the timer list corruption when frequent switching of governor
> by synchronizing the devfreq_moniotr_start and _stop function.
> ----------------------------------------------------------------
>
> Christian Marangi (2):
>       PM / devfreq: Fix buffer overflow in trans_stat_show
>       PM / devfreq: Convert to use sysfs_emit_at() API
>
> Mukesh Ojha (1):
>       PM / devfreq: Synchronize devfreq_monitor_[start/stop]
>
>  Documentation/ABI/testing/sysfs-class-devfreq |  3 +
>  drivers/devfreq/devfreq.c                     | 80 ++++++++++++++++++++-=
------
>  2 files changed, 62 insertions(+), 21 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

