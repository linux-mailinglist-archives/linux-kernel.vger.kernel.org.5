Return-Path: <linux-kernel+bounces-109374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1F881835
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE08C285371
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CE85927;
	Wed, 20 Mar 2024 20:01:09 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD269DF4;
	Wed, 20 Mar 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964869; cv=none; b=qVaegnLhw78zT/vM9g+UZ1VEEseOWrXV9cjJQWusvP/5PM/56BdZZc6/Ysxl39HJAh4vCRHi1355WnECH9jTxj/tmZyutCVaOJPmILJYfBHbL21SrWaPm1Uol18lCB4TTsuLwJX6UzLaFmCp7Jr+2jspyfGeboQ4eKvtkz5PNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964869; c=relaxed/simple;
	bh=PEJK4d4YdMXR0AsXMOStldl4zFxOtfPf3D5VxkkFrQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px2Y7l3100tnOXhSiucwD7ZiWlRYjT3x3CIoDtyMw2MLObPQp3bMiWo7hyJkRGJ961XQVXB4XhSRRHduleAPoU235PlUDyn636SK7jhZ70owKM9nemnSQI+e3I4RyiypuHoTK9N48LGKORC2XxtQB0sZJwkIFa1wJaEzr6aTISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e681fad78cso23122a34.0;
        Wed, 20 Mar 2024 13:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964867; x=1711569667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEJK4d4YdMXR0AsXMOStldl4zFxOtfPf3D5VxkkFrQI=;
        b=p3ljatDvBRhQtYEnVvvHyLQZvWYsUnESO+DHzzNVPU8AWvLxnw90lHsbdynD/Ib7x4
         EJoGJTwsQTMplwOwrGtGTX3w3PWE1UMZxS+53dg5VEpye/TiFqwc6xFJxCDfuYufsmbM
         mitzIaadTmVY9rG0ueySRo9W5Xo0nxj4YBRx6Gr7vMb7CTPybXDlGCklVJxEE6MEIoYs
         JniCN+sjmoflUHloMPJDs2qn+nIQ7SU9Peou2Xiu5kavGnnAu+MQDdRIF3sxOBmb9Jyq
         MmOs4fiXyZ30nuj5zlwnVGWjysADzRr63vDaJM1kmU+gQnLGfg+WdjrjBK41bOknqHXz
         d/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDZsPKyP5WEWBDZMC4wZvQAyErUM4Belwl7EQNDoY77yme6YLYB6mPKQJLNY0u/5Rj3H8E/n+oPt+UdVUDkn01ODBDwv81H45yy40kGEW1zQx/WETco3eCZaFEl7alVl935FNwnzbs+g==
X-Gm-Message-State: AOJu0YyG806hAMhvSfNGuvJKzX7BqfZxbskncmVAfd+eAQrnWovtO6Mf
	HkeiCoK9zZRuJav6BGvdnq2u+i+qF/roI8/IofvbragnIlXgo4UEytXREfveC2n+drZNKlMdDFi
	MFsQkAQweMOomDwDI5w72O6cKSDI=
X-Google-Smtp-Source: AGHT+IGaGoBeSE4UB6667YOwykswCxISQ0gVBli2Vn788iB4Dqf6sqyahEi3HmxP+DcD2/+PLFxqL2UZjfCiiiTR9kI=
X-Received: by 2002:a05:6871:580b:b0:220:cdfe:cdde with SMTP id
 oj11-20020a056871580b00b00220cdfecddemr6367101oac.1.1710964866655; Wed, 20
 Mar 2024 13:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180302.143707-1-arnd@kernel.org> <65fb3fee96ec7_aa222949b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <65fb3fee96ec7_aa222949b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Mar 2024 21:00:55 +0100
Message-ID: <CAJZ5v0ivpUuKGx9pW+QeQPSSXNWSSbJwN2oN9p_hmE-nV5VQKA@mail.gmail.com>
Subject: Re: [PATCH] acpi: EINJ: mark remove callback as non-__exit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Avadhut Naik <Avadhut.Naik@amd.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:58=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The remove callback of a device is called whenever it is unbound,
> > which may happen during runtime e.g. through sysfs, so this is not
> > allowed to be dropped from the binary:
> >
> > WARNING: modpost: vmlinux: section mismatch in reference: einj_driver+0=
x8 (section: .data) -> einj_remove (section: .exit.text)
> > ERROR: modpost: Section mismatches detected.
> >
> > Remove that annotation.
>
> Looks good, not sure why the build robots missed this while this was
> sitting in -next. Yes, this was a side effect of reusing the former
> einj_exit() as the device remove callback.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> Rafael, can you pick this up?

I will, thanks!

