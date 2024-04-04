Return-Path: <linux-kernel+bounces-131657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B18898A75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A778F1F21A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C81C694;
	Thu,  4 Apr 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks+2N8TU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AADDBC;
	Thu,  4 Apr 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242499; cv=none; b=YtKFz4bScNqTx/KmJeb4XDGo3miqx7ybVsYrqFDblDfjHd+ehT2gB1s82iNlGwpGXQ1MNhx3X75tJzeDPWTfp6CqOtDpggcRduzVtHgkQpEtTbY75AnwDqN0yL6rOGi5LZXKeRn+uBaiGRi3w9+Oqn9Fkg197RD/kQ955oPECnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242499; c=relaxed/simple;
	bh=x78rj90TFRZ7cOjs3pNg4nRwg+XPusDjo2DznyCzO2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+agLvvNyNjlnqGJr/+U81y+i4AUhS0GaWE+1TWT5uUDUo4YAC/M9vQcxeQYM1L/Hq1fvxWMbKavSThhoO1b0ChSjQJp239v7jlXLbPkO3Tinkk+MM2PRx9Mf/KJS/MGslcwgcTg6b8bjFEovVR5N9xXdHFFQipmhNXFBpYYNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks+2N8TU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162bac959cso4018085e9.0;
        Thu, 04 Apr 2024 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712242496; x=1712847296; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glulz4AZ62PEl1FtV867d3/xaAkvpKKca8G8SD97D8A=;
        b=Ks+2N8TUYpRAhjzGJikLruvc75rlHWsOMiVPPg7isgygq7Slj+LaPdKmat+CiHPx1b
         MYfpRY5mFn7jouCLcVQj7MF3m4V2ANPP6cTRXyulcu2GiZkVdKhVqOn74UD48dv5ZUcQ
         a7zbJxmKdXmvQXk/nSTXgGuL5eUtTyYlkpjW/6WAbQ7ibJwgAfccRgl8HRPl+t0mvrM0
         g/5H0KkZnjzQRIThgS1sGvsTrzlay4TMVYf0kDXNuFJjzgkGUceNtqBe+zl5AFwU3npm
         gy3O2qaAHo6AhA7LTZE2SWUUuAnsrgl+m1EdizRk5k40v+i7Fa4ea6ZD5IKLoK+3yfyd
         /NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242496; x=1712847296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glulz4AZ62PEl1FtV867d3/xaAkvpKKca8G8SD97D8A=;
        b=JVYPozf4UZriv4pMfl83z4/6Z14Qf8xlkMv+Ny4qggHqCJRtq5+oVqsuswP6yewKsz
         PhhqA2lCVWWimYNCKSBdPvuSjwBpe96uxXCz2XfF03nPmu1gF8EAagHcDQrdc2f1ktz2
         POFu6NgCryYLt3SHya82NAS72Rqpl5dDNN61dQOKhTpYAeB18fpSDEEMq3wMTNAro4OO
         8pwHD20Cle2ZOA2gm63QrD7YxVJQRIkNn+aAZvV/byxeefBv6qUv9yFxZHuVL3jozBtp
         tFfttm3y7xL+gMUILAGY27hhw2Mp3po14wzB3dS+Sbn/15DikmZFOXF1uBYHn80/HY1k
         yFeA==
X-Forwarded-Encrypted: i=1; AJvYcCUBSV0z9PjKOF6BYKRF46yuJXGtn/+CHq7MRAmvjkEJK35CKyyeV/U5G3oPZ2NyNN56tiKCkRg/Q7lFsUZBTn/x2XMOWQes7vSXZ4GUq4+YSrO/Eq3Ob2W8r4CMJD8My7IU28FQHoRB
X-Gm-Message-State: AOJu0Yx39f7Xyoah5hz87qI0Fi5t5p+t2Pi9GjdQ1ZF5OKx3WI/Ga+xF
	+2Ndj545hEgpO8MiJZuFmzyCOfVzqC4iXqxqxTsWOKoSDr5I+uKd
X-Google-Smtp-Source: AGHT+IE/IrvuvbWC2KToqhYIKbLS8TuFoPDm6Z5Y0Js0av+z/qFyTnmMZGDwD+Ok2+gD0JTz8TdGlw==
X-Received: by 2002:a7b:c450:0:b0:414:ff4:5957 with SMTP id l16-20020a7bc450000000b004140ff45957mr2153060wmi.5.1712242496120;
        Thu, 04 Apr 2024 07:54:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0041493aae77esm2963505wmq.23.2024.04.04.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:54:55 -0700 (PDT)
Message-ID: <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>, Chris
 Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 04 Apr 2024 16:58:27 +0200
In-Reply-To: <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
	 <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote:
> On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:
> > Using dev_errp_probe() to simplify the code.
>=20
> ...
>=20
> > +	if (IS_ERR(fwnode))
> > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot get Firmware reference\n");
>=20
> ERR_CAST() seems quite good candidate to have here.
>=20
> 		return dev_errp_probe(dev, fwnode, "Cannot get Firmware
> reference\n");
>=20
> (Assuming dev_errp_probe() magically understands that, note you may have =
it as
> =C2=A0a macro and distinguish parameter type with _Generic() or so and be=
have
> =C2=A0differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_match()
> =C2=A0implementation, but also keep in mind that it doesn't distinguish N=
ULL/0,
> there
> =C2=A0is a patch available in the mailing list to fix that, though.)
>=20

Do we care that much for going with that trouble? I understand like this we=
 go
PTR_ERR() to then comeback to ERR_PTR() but this for probe() which is not a
fastpath. So perhaps we could just keep it simple?

- Nuno S=C3=A1=20

