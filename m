Return-Path: <linux-kernel+bounces-17241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF85824A52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877D1B231E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0562C6B7;
	Thu,  4 Jan 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TpAPfgSV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084F2C6A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbe39a45e8eso834781276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704403849; x=1705008649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liy/6VgmB8kWQ21CUUxI99uteVuJGjbMlq+ZYGusDy4=;
        b=TpAPfgSVWJVfKtYMhiLgLlhVGYSDAls75B+o9NAX0XXbP4VjTM79OxQyZbANiCX6KR
         r8+QRbK7qdFHCt0bJsznJH1DDV3AjLl/jAfnShvBiWI8mnIaGnhkAbI432RU4vs62U75
         xdRxaRRiuIu7tsnIdkJ29KJD0J2aZemVzj1haSdyTQgsFMCsfmWUNcOCnepPyznbHOB6
         nJpuxSVTmndW37VGHrRFly38OSGMnZ2Z5jLfHotYAa9OvSH5XYMudr+otQ9j6oXSIPxQ
         LvV5M6wdHVqrqHpzBr15PX/aDbcVjAGrmpmdFrWqaaGItkza2WeZ9FclIHOBzdxZU3QA
         capA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403849; x=1705008649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liy/6VgmB8kWQ21CUUxI99uteVuJGjbMlq+ZYGusDy4=;
        b=XAe8bfSgtRUgFM+NN71RHDW0eCU8MR9vxkSXPT+GDfBWCbfRSQwcxiuu4DEkKuUPWv
         TA8nTuq+M6YyefdbsQa0mThTqw2u616lhy1z11zNrf64Eiub6eOaQzE7gVxaM5M70eO3
         dSpUDRvRTJfjSTn1IgOs8Y1TEjWysHx7JeEywBlvTmjTzLGw/ElaRyKp2p5/TE+VuAq0
         trWkyE7NZl/hAc0LZ7w1T7Lx1SLdHSrQ15DPnW2xHSxtM80Q5G9ONspPnZZYOyUXiAu5
         hxoWpjX6J+c65w+EZSkukUtdKgx+NFSMDtZe756mOUZgN4FJVG6dZ/MO36KC2DyigB3t
         cuRQ==
X-Gm-Message-State: AOJu0Yz2ZulV0Aq7SDwRmv3qyaY8xKhEZvTCGBYrpwtvMa49dY+esZPi
	pimbXzY8tWK2Obbn82L71ICIRaXPNc2lSXlOf0A89wToQ5tP
X-Google-Smtp-Source: AGHT+IGO3ioXEu7cVqjO87v37TXJrp8J3GLOmGblye3xoIpyF8rofmlFADs+B13Sfn0nvFbUDvhyIHzTX2mXfIu30ro=
X-Received: by 2002:a25:8043:0:b0:dbe:a236:d6a4 with SMTP id
 a3-20020a258043000000b00dbea236d6a4mr1051292ybn.53.1704403849633; Thu, 04 Jan
 2024 13:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228025600.9796-1-zeming@nfschina.com>
In-Reply-To: <20231228025600.9796-1-zeming@nfschina.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jan 2024 16:30:38 -0500
Message-ID: <CAHC9VhSjxWR9fy2Dq8-sgP=1bkPmDjFH-QehZ4eow1U=sEpBzg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_kernel=3A_auditfilter=3A_Remove_unnecessary_?=
	=?UTF-8?Q?=E2=80=980=E2=80=99_values_from_ret?=
To: Li zeming <zeming@nfschina.com>
Cc: eparis@redhat.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 9:56=E2=80=AFPM Li zeming <zeming@nfschina.com> wro=
te:
>
> The ret variable is assigned when it does not need to be defined, as it
> has already been assigned before use.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/auditfilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch, as this is not a critical change it will be
processed after the upcoming merge window closes.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 8317a37dea0bb..be8c680121e46 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -788,7 +788,7 @@ static int audit_compare_rule(struct audit_krule *a, =
struct audit_krule *b)
>  static inline int audit_dupe_lsm_field(struct audit_field *df,
>                                            struct audit_field *sf)
>  {
> -       int ret =3D 0;
> +       int ret;
>         char *lsm_str;
>
>         /* our own copy of lsm_str */
> --
> 2.18.2

--=20
paul-moore.com

