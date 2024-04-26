Return-Path: <linux-kernel+bounces-159718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0308B3317
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274B01C20F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBAC13A879;
	Fri, 26 Apr 2024 08:39:10 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370420317;
	Fri, 26 Apr 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120750; cv=none; b=jhBejO/IlJcRI0pIUarNJ7knOR2e4sBckyRLg2hqODLGTizTQh2lGazPQL1C9v7vMDUD6j+7DjRJTMS4aiq0UHEhy9Q8PtB4OJrouCYvB8AiGBU36DpM46027fZxK0htR1rHdZXFH41w5OOmVcsuwuELCrIK7yj/pNYpKMiUDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120750; c=relaxed/simple;
	bh=mxHlfRZVmoVJnUAx5dxOnpcf0RH0ieiocgXdOdOeC9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMKZ/WKZAUUQUetyX8alfGZCLi4ibHuMAgY17wuQTIVh0Cq5Y1Kzcv/XGWsfLYg54RCV6iAWoCbkcdjfrjFF/bS8iDliaYUsoPFIXreo85KYkQObaEmYnQ6dqdWaVETpc7o4xsoVSVD8LsgMmgLJUTE5ifg+FQneO47tDWp9kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so21597251fa.0;
        Fri, 26 Apr 2024 01:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714120746; x=1714725546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxHlfRZVmoVJnUAx5dxOnpcf0RH0ieiocgXdOdOeC9A=;
        b=ur0IiqPKDmJt4xuRB31jVy60dfRZQMrEeQGmdRyNeDNS3chubWQQsdBikRh70q+f2S
         sNsx1OW//jvh+eyKnYMxZsnb4gOUduqPyGdrvXGnu5+ILyX3LAgcdOrHLsEv6OZH2/me
         DJConP1mxnP8kUV8Y3L4VS0QGNgl0IVhb/N7kYeON4AScTYt7ceDx+y2GbfikSO9yp26
         Alw2/yCsHPrdujwi4LtPC9KnAn8EOp4o2rfYbtjJ/JOcWAPxUyZUuWmp1/7+N/1laHWJ
         H+yU8UWR2byQ070JjAIVsYoZLyJwwOyjitO0bIcYCKKN0bku9QdjARtC70vWySBFUpfA
         PgEw==
X-Forwarded-Encrypted: i=1; AJvYcCXIuCvLRiYKu7erKfcImRHsWW0qXRWVx9VFDqWIXX8xQJhj/msTsnPIqmyEQ6PnUt6GO9c9dF210cn2PN3xpJS297rz9d2BGgySE1b1qNQAcC0e1FngELlycOfzELV3qjR/tXHew++zXZmIIWMi
X-Gm-Message-State: AOJu0YwBE6qC2U0y+VLMtzJaEMALBrmbALkSAA2mFHLjE22+1fSy3FxN
	v0NLvo3m1IO9/N8jMYGaX/9HOK+cbtCEJLzht7ToNx8PVx4m30fWHhCPZXvlnaM=
X-Google-Smtp-Source: AGHT+IG+V9jxBMf/hVt6W9MO2l3EQQSxqIFZDsGtzSg9jvvlGMK/TYHFOJV50rpPKC7rhFvXrfvLRg==
X-Received: by 2002:a05:651c:150b:b0:2d8:2761:a90f with SMTP id e11-20020a05651c150b00b002d82761a90fmr1429006ljf.33.1714120745853;
        Fri, 26 Apr 2024 01:39:05 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k4-20020a2e92c4000000b002d808b86073sm2604511ljh.78.2024.04.26.01.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 01:39:05 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51967f75763so2192924e87.2;
        Fri, 26 Apr 2024 01:39:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaXMUiTXlm7iUJcCmGiwO3U9qH6j5oAdJTKKYaTU8Za4Mjyrvmfc2ftIxNPyi3Sl8ID8+oMwEuM1myozSb83mDsGhakG8klx6K8BWOJTw6Q10qc0LKdtJtFWtOOX9SSZMFPK6iUu/3EZolr5Mj
X-Received: by 2002:ac2:5104:0:b0:51b:15b:d262 with SMTP id
 q4-20020ac25104000000b0051b015bd262mr1192105lfb.33.1714120745348; Fri, 26 Apr
 2024 01:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426072006.358802-1-iam@sung-woo.kim> <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
In-Reply-To: <964b0005-3a9d-499b-91d3-171a3c917b4a@web.de>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 26 Apr 2024 04:38:24 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com>
Message-ID: <CAJNyHp+WFONaNbZVK3tPcT=9obEiuE3MvQzJK++HP-ffNdfX0w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, "Dave (Jing) Tian" <daveti@purdue.edu>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:26=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> I prefer that you would put recipient specifications also into the messag=
e field =E2=80=9CTo=E2=80=9D
> (besides =E2=80=9CCc=E2=80=9D).

Okay.

>
>
> > Hello, could you review a bug and its fix?
>
> I suggest to omit such a question from better change descriptions.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n45

Thank you. I'll thoroughly read this.

>
>
> =E2=80=A6
> > To fix this, this patch holds and locks the l2cap channel.
>
> Please choose a corresponding imperative wording.

Okay.

>
>
> You would probably like to improve your patch approach further
> so that provided data will be kept consistent.

I will.

> https://lore.kernel.org/lkml/20240426073142.363876-1-iam@sung-woo.kim/
>
> Regards,
> Markus
>

On Fri, Apr 26, 2024 at 4:26=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> I prefer that you would put recipient specifications also into the messag=
e field =E2=80=9CTo=E2=80=9D
> (besides =E2=80=9CCc=E2=80=9D).
>
>
> > Hello, could you review a bug and its fix?
>
> I suggest to omit such a question from better change descriptions.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n45
>
>
> =E2=80=A6
> > To fix this, this patch holds and locks the l2cap channel.
>
> Please choose a corresponding imperative wording.
>
>
> You would probably like to improve your patch approach further
> so that provided data will be kept consistent.
> https://lore.kernel.org/lkml/20240426073142.363876-1-iam@sung-woo.kim/
>
> Regards,
> Markus
>

