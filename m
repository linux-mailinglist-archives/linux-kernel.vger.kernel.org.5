Return-Path: <linux-kernel+bounces-82-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D8813BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809A72819AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E206ABB8;
	Thu, 14 Dec 2023 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBdcEXaV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685382112;
	Thu, 14 Dec 2023 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so10074943e87.3;
        Thu, 14 Dec 2023 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702586662; x=1703191462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj5QgxOwhDWBvTm9vxK5Z1lgrdLIjZvRtMGMPF+PgGc=;
        b=RBdcEXaVp1bTfjkiw6RraKhJgmQXXMf72PwfUpj2G4g1Q4FJ9stlcZqzaFlLBixjnt
         qH+VvE0QMPaWtYpLHBmeIHUxa0Pst4iXUc/ENQmrtnULU/X866jLhQHL903BRWADc31Q
         yoGwb3zoei8pHSaaKDMzoZ/gYa2fd++ihHdW7mLBoOZOhoq2+K6p+SWpP2X677tz3/20
         p6lF+j3du71pbT9g85QRCIh+yZqPXv/7kXDebVYZfIEdlmsfd+P0iEuMRaAdCIlHj65e
         As2GHPid3s8NYoNa0w8VR22w8tR1P9UWsQlLi2wnYqHkgrsegFxzH5fU78tNybQQ2uEK
         EYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586662; x=1703191462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj5QgxOwhDWBvTm9vxK5Z1lgrdLIjZvRtMGMPF+PgGc=;
        b=GnOqn42Pec5NHjLmRh/Q4z/gOqYR8ELS7ZNQk+FYFfom792st/uxMD/8reXjw+4Q2o
         f32YOUrRdt3uvEsA7yG3945z7rVIfqyxF2ZM1s5UD/hUNwglOzrawNVwS5UuhxsWmQk9
         jerEYMcgaAbUB1JWkZCIZFhCAb4dLSWCXhUKvZ7lRb0IGRS/O2U25KUOt07xP4YYV3zk
         jNvSUlpQDDUsbJwE7cq2U2wpmCLG8Y5q6EqtvXqdeQIJRxY3O2C8QlECj2Zk3vpAIhJo
         0hV16ma2ZD/xXzj9wM6gKwn5tej1EtN8qsGvlimIRXNmw13k035c8EPCN0HfOVxto+Ko
         k2Hg==
X-Gm-Message-State: AOJu0YxsCr0j0EjZZfXURx05myikk1o9JoM6+sy2NiHxMOh1cVcliTnA
	DLa00ZVIW0fbOsW5OGGFnM/dKp3PgIFe1o3Dzhg=
X-Google-Smtp-Source: AGHT+IGBqIAtb6+8VTNfpHR6FGCc/cZYdZbYmzN3hSytXmOJqgzRF8e7YKVJvSJgDhI+ImDcoEYEldUEhOQKSREYATk=
X-Received: by 2002:a05:6512:308e:b0:50b:fd6f:1e2b with SMTP id
 z14-20020a056512308e00b0050bfd6f1e2bmr6127000lfd.3.1702586662163; Thu, 14 Dec
 2023 12:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213210644.8702-1-robdclark@gmail.com> <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
 <ZXsKzsij3Xb50Ap9@hovoldconsulting.com> <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
 <ZXsMoFiivUCWA0yr@hovoldconsulting.com> <ZXshe83quTE0jO_Z@hovoldconsulting.com>
 <ZXsojADuspUVLbIn@hovoldconsulting.com>
In-Reply-To: <ZXsojADuspUVLbIn@hovoldconsulting.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 14 Dec 2023 12:44:10 -0800
Message-ID: <CAF6AEGtQ-73voz3Wc6YkQ-UipbM9JsmZ06C_W_zKH4Qy8v-biQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:08=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Dec 14, 2023 at 04:38:35PM +0100, Johan Hovold wrote:
>
> > I took a closer look at this and indeed we do have code that triggers a
> > reprobe of a device in case there was a successful probe while the
> > device was probing.
> >
> > This was introduced by commit 58b116bce136 ("drivercore: deferral race
> > condition fix") and the workaround for the reprobe-loop bug that hack
> > led to is to not return -EPROBE_DEFER after registering child devices a=
s
> > no one managed to come up with a proper fix. This was documented here:
> >
> >       fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")
> >
> > But please spell this out in some more detail in the commit message, an=
d
> > add a Fixes and CC stable tag.
>
> And please update the commit summary as I've been booting with QRTR=3Dm
> all along just fine. I guess the issue is if you have pmic_glink
> built-in or in the initramfs but forgot to include qrtr or similar?

I do have both QRTR=3Dm and QCOM_GLINK=3Dm.  I'm honestly not sure what
started triggering this issue for me.. it seemed to have started after
merging msm-next + drm-misc-next on top of your
jhovold/wip/sc8280xp-v6.7-rc5 (the merged branches were based on -rc3
so this shouldn't have really brought in random non-drm things).
Maybe there is a timing element to it?  I felt like the problem was
obvious enough, and the exact details of why I started hitting this
were not important enough to spend time tracking down.

BR,
-R

> Johan

