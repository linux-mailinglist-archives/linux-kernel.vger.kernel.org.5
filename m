Return-Path: <linux-kernel+bounces-66116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ECA85572F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCB0291421
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59F1419A6;
	Wed, 14 Feb 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWm3GjoV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599413472B;
	Wed, 14 Feb 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952974; cv=none; b=XwOeCbqzhLb9c/F4R3cMZO/Qp7Zp6nIbyeZwQNaTEMOZzkr15qHTUeZT+eL9xmnyaOrMF2pnqtaVUHIu2lxAEbs9pNk99etkZOzEwH52qT163dgy6QgfFayYdHcPVpYAjDbp6+FrRi5OSuElEBqYpjoWweGOYd20axrfDMG0DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952974; c=relaxed/simple;
	bh=3EQISA5BWKfjM0TIHlpP5btzvK3B1+UPqI77iwEpkJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCJHZI8sMXra0W1qigyDA81lfDRK99BJjIhrrHxZ15ozd1YL91zr1qoVZs4v+LyB+6iUH9RyGtMyBwKU3bVBBOXdzl2KgZFH+hTdiDrQ3xzfHwhcgDBPPxngtN+wt40yr6GkEJPmFLMhzPZJxCT4nxAIbhCE68C0M3KeR8l4jLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWm3GjoV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso271629a12.3;
        Wed, 14 Feb 2024 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952972; x=1708557772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWY3HMGT42kRA4mnl0XJ+CvSiYyESAW/yGq2N3G+inI=;
        b=QWm3GjoVICtC5j8mPP4dQz0oGqQQvWKtup7cHtkQFL9f49NJtzgYFCQlEEUWZr6H5N
         hJhYyDLb5eQqb4VQnZlRpy0SnA195XKFAr3KHGUZaCqq2pgjR+CC7HxbGEO986CG6GaB
         6G1JwtqvTf+QmoBdsm99Ux0ncE23dxj+B8VrKDxmFWzMOKGxdAFuwEyzyeiPPMm9DXc2
         5E3F++JBOTW09+G7wsap/2GJXfc1y5b/H/LPnxwcIxBhoW4mQPNc3umM6hvAafMEx/hZ
         7/Gecf5thrOCNss50ff2ViC5xgZddov7ubf4EPXBI/CUpERL4ZCVU4FC88B9QLVjBV7/
         qsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952972; x=1708557772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWY3HMGT42kRA4mnl0XJ+CvSiYyESAW/yGq2N3G+inI=;
        b=HzqP491vlWRg3373f4kTQn4SaocEJZaKlHtvpq3pAoKN4mx0yDxZlUlgfjHGXcN8D0
         Actc9wPHzg1kMIirkhfqIVv+Oc1yBhWsEXEjBCAeE9R+4lUTdDEkrM4cGGyL40nEhuTc
         EXHqNkjRePGXZxNc8sSn9UOCiR6bvRIFQgUU29T+qTrI3FkJxhMum2LHrqsl9ccmEOBH
         CYJIqsA6DhEgUCgqT0xmuYRoFIdauEGdU1uESAuUBEV1KeszGuzi6jx9AzZRklYNOR9p
         jjElmCuroei1lxe2/07Pfaj9pr5nKciW5v2PFamyr0+Gw1MLyYiXoMEuppdUBigxSURv
         WHIg==
X-Forwarded-Encrypted: i=1; AJvYcCWoRCo8f6PeJEUpfbyRfNoeMQX10Peodzr2K4EYmc2kWAcMG5byGBOBFWDEYgcAU7xWGjbJL2NPo5ANwmRj+rMlJ/DyrdK8cyWHonIx+LuyaoXt0r9S9fQZ8kB7dEr5EgU4gLuGvM6gFzKItlikxH4C/w==
X-Gm-Message-State: AOJu0Yz9ntfZSsHr//M8cTYeRPPt9O2erCbYLa5iCLOBGjZSzNEJxXDC
	5nYenwJAyfcnIh1TAICPl6MS5Z+IpqlMB0yK+FOs3PTfdfj6rOnqdc8PAbuErkVq9din+YU1Xcp
	tquplAtQTJHJRChar14wyPUPr1XU=
X-Google-Smtp-Source: AGHT+IG7heeIkiLqqDHkQmGM67TUlop3OpYhIX4M6gsvIW7nfJ3isFBoGMca+QVZ7YMu3uhsyPCQ47xP4oNldYFP3bk=
X-Received: by 2002:a05:6a20:d046:b0:19c:ac7f:c3e4 with SMTP id
 hv6-20020a056a20d04600b0019cac7fc3e4mr247735pzb.42.1707952972287; Wed, 14 Feb
 2024 15:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214052959.8550-1-vishnuocv@gmail.com> <20240214052959.8550-2-vishnuocv@gmail.com>
 <97fb005c-92bc-790b-80b0-75149a799b4b@linux.intel.com>
In-Reply-To: <97fb005c-92bc-790b-80b0-75149a799b4b@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 15 Feb 2024 08:22:13 +0900
Message-ID: <CABxCQKs98pTbJF+EyP4HdEd+JOTvGdfkRgvYGLNOHoc0DX0A3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: thinkpad_acpi: Fix to correct wrong
 temp reporting on some ThinkPads
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ilpo,
Thanks for the review.

On Wed, Feb 14, 2024 at 7:23=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 14 Feb 2024, Vishnu Sankar wrote:
>
> > Added non-standard thermal register support for some ThinkPads.
> >
> > Some of the Thinkpads use a non-standard ECFW which uses different
> > thermal register addresses.
> > This is a fix to correct the wrong temperature reporting on
> > those systems.
> >
> > Tested on Lenovo ThinkPad L13 Yoga Gen2
> >
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > ---
> > -Improvements as requested.
> > -Improved the readability in case TPACPI_THERMAL_TPEC_12.
> > -idx < 8 from idx idx <=3D7 to match idx =3D 8
> > -KILO used from linux/units.h instead of 1000.
>
> >  static enum thermal_access_mode thermal_read_mode;
> >  static bool thermal_use_labels;
> > +static bool thermal_with_ns_address; /*Non-standard thermal reg addres=
s*/
>
> Comment is missing spaces.
Acked.
>
> > @@ -6239,6 +6267,20 @@ static int thermal_get_sensor(int idx, s32 *valu=
e)
> >               }
> >               break;
> >
> > +     /* The Non-standard EC uses 12 Thermal areas */
> > +     case TPACPI_THERMAL_TPEC_12:
> > +             if (idx >=3D 12)
> > +                     return -EINVAL;
> > +
> > +             t =3D idx < 8 ? TP_EC_THERMAL_TMP0_NS + idx :
> > +                             TP_EC_THERMAL_TMP8_NS + (idx - 8);
> > +
> > +             if (!acpi_ec_read(t, &tmp))
> > +                     return -EIO;
> > +
> > +             *value =3D tmp * KILO;
>
> Hmm, MILLI would be much more approriate here? But if this relates to
> degrees, there is MILLIDEGREE_PER_DEGREE?
Will Change to MILLIDEGREE_PER_DEGREE from KILO
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

