Return-Path: <linux-kernel+bounces-153357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3908ACD17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13523B23E57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580648787;
	Mon, 22 Apr 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MB2WIfh4"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB121482F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789651; cv=none; b=q+6Pf8sf+tSqiTCxA8RY30ftYNp6Akv36n/psRskXcPdGwkQfPTgogPgPK0ZYBKGeBQa2cDfRLcpckn5UdrP035ISCqFWTK+VGtxslAyVvL046SrCnCT7OY4pvCz7V+EJlPxyPl7BH0KPzlcjQb4GemBOOoF3IN4l/6+zYZl++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789651; c=relaxed/simple;
	bh=rHwtqOJ7hfOxjOvIBhN3DOgNQntQgRNTBmHT3TVb85g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsXNhREMIj9OxIIipVXlc6BG1kNKFCG03E4E+aSdBe8QFneYQfRIyezI+ttPRZBeeQUmz6t0IyD+xUl/kwGHtui3HVYPAiwRXofYqxT1tN2ocloihP7yyEiwBgwYagJxK741qydVDIuvxoJqN/ZOOtWtoA0eSiGZ3hQLWnJixw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MB2WIfh4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c7510d1bacso1115773b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713789648; x=1714394448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG4hPexSWedosu3J2N32I42487kxLi51E4WCYQ7z86Q=;
        b=MB2WIfh4rnpQvPmiUpr5uUnAIHibvLzy+iAN3xVwvrhEaW0XYXtPsUEb+iP/lShDmH
         dtlFEsrvpKGphAw5yaIjDYshejPLgxIQiJYL+WWO4Pdmh2nIqbJoIl2xygXzgocgpx92
         dMH8Oypugo07UY7vrx+JMOtxIHtet4Ecl6Zr1LkMCLo29tX3ypPgmmiTAdNbR/KYB1+s
         KFVky1O5yt7228LjC2k+7AyRUv9N4AyJStrzgWziosLnrhA0Qs68qGgowC2rjSW8x+jX
         ON6rah4tqFo1KZ+8IijvfUGbY8IdSpUl227PawVTzkwib7eyPaHenxFXln/JIl4P9R/n
         O5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789648; x=1714394448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG4hPexSWedosu3J2N32I42487kxLi51E4WCYQ7z86Q=;
        b=qrrywFkh41OL7sb3RacNXh+b2NYjsM9R6opYufoEApIwelHbNf4fQEuiyKC0IFjfqi
         G8JwE+okY8NhgeE/p1+lT7/yIWdXlsJw0yk1DLVc6m1nFcx4/80IKm/CBFCqoonkir0r
         AZFz9spNlckK2ma+2h+ygUcvp2cYaELcYyrv5DNCRgd3wpPO9j7mX8sqLXjT6wdJDPWe
         forZ4pWyQ3p36XIDSzZhhnwHXjaQrWUajIvJ1AIWDZ16AcFByEf68EQoF4n9crTjjdsM
         zOc69nFL8X12p6NEs8kLxWUug0C2Q2f5ADe/sRgGRDzl8VDwGdajK+ZIEs2Gj1N+/pvs
         Xxvg==
X-Forwarded-Encrypted: i=1; AJvYcCWF0GL36BL7t67nHijygkvW8AF+iyFaA4hb+PY1NQQKr0jbdb5ECuU8tvv3xYpKAbFq9LUr6dD46dxpHYR3ssKysQMMio+oMD7klQJw
X-Gm-Message-State: AOJu0YwR7hlBHoeD+YyR4Y6wEnhwqbAwxaSTP4nq8/ujcMCbvshBqk5O
	ICT3P1X9dhu9QfkMhQ0qWGuxo4s6V/RjPyDHaHCnm5JfbKYCJvs/DC5tzhv/IgYWJJ+m9i8qp4Z
	yO1FyVpi6/jXs5yv+7ZaaIgkVymzFERRHlH342A==
X-Google-Smtp-Source: AGHT+IEMfGJHMTEml1VRNaAfoa4qnzNHZkeLKuW9Vl9je272KzGmuVy0hJtkx+vfLt1IPHkVf/BJiDOJlfCqo09Adjo=
X-Received: by 2002:a05:6870:b601:b0:233:5557:c6a2 with SMTP id
 cm1-20020a056870b60100b002335557c6a2mr14543327oab.34.1713789647808; Mon, 22
 Apr 2024 05:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-10-peter.griffin@linaro.org> <95bcdc942cba564f78a6f2fe4cde892575838d5c.camel@linaro.org>
In-Reply-To: <95bcdc942cba564f78a6f2fe4cde892575838d5c.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 22 Apr 2024 13:40:36 +0100
Message-ID: <CADrjBPrnWzT6raAtuswC0AE6EEwtQ7sTUkm8SjpBh=3nibcmSQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle()
 to obtain PMU regmap
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review feedback.

On Fri, 5 Apr 2024 at 08:04, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> > This allows us to obtain a PMU regmap that is created by the exynos-pmu
> > driver. Platforms such as gs101 require exynos-pmu created regmap to
> > issue SMC calls for PMU register accesses. Existing platforms still get
> > a MMIO regmap as before.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/phy/samsung/phy-samsung-ufs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsun=
g/phy-samsung-ufs.c
> > index 183c88e3d1ec..c567efafc30f 100644
> > --- a/drivers/phy/samsung/phy-samsung-ufs.c
> > +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/soc/samsung/exynos-pmu.h>
>
> You can now drop the include of linux/mfd/syscon.h

I'll send a followup patch for this.

Thanks,

Peter

