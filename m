Return-Path: <linux-kernel+bounces-98734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25838877E89
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BA91C216EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06263A1BF;
	Mon, 11 Mar 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evVksw/R"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906639FF7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154867; cv=none; b=L4feECUOHDNPmqYiTM77/0Ux5qlYPwxhJSQBsmhPvaoH1BtSecVHF9qZaelC7oWDljS4QSib+YyKU2Ns/s9e8BsvgDAVPi+J1KJjsfFqmQzUuHWeT+SOAnvjJ7eJNpKMbhiCgoNcGO5ngYejxhxLmVPxnX9VS5Ih+lkR91gTsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154867; c=relaxed/simple;
	bh=fAjEWASOcvzkRnUw6xezzj5HnL43BJmAQOHi2d403CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1CjIaFNm8/JMqqOZvZjZKMNtdk6yWYWj9zUr4dYMSVJe3w/z3yyGsnqKs6bY6Xia5Xt3s8tvlOjENsvO47ljVLOk4eC24GiNYtclxYTO8XC//NrM0QLPNyhAwPMGKONecaByWYXMS0XCuLaS13fkRMTybiDm4FtP6EuCTcwNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evVksw/R; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c2313de2ceso1534880b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710154864; x=1710759664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8BY+YO3if2lvYNHvMPH3qE1q2AnqB9hh6Oit0y/824=;
        b=evVksw/RwNAWJ3OcxClIMJFHjuC29HO7AIgBvv34IAfxFwqhQTMNcCg1tdE3y34IxS
         gN2C4o/S8TowpmLuT2ua/6YTr7OBvDHQitFRaXoOPwLtwqCpaQuIFESSkbsgU/47bg3o
         szaSbpmBHAOF7eC5A2kaCKnqJm6IaXa6CyncJU86Uaikf+Uq4edSDvAxBJWxTIjr0PO+
         h/CoUBqAh71sQh6XR+d6R67/s8cBbwReKOOdVSRnwS8ThZlByEB9MgezyETXSatqKrIK
         iT7CIbMKIjLtP2I022sQunVq/BChoCTUY2H4ATKtOhCrQouzw67IDif2L8Yj67cSCctg
         n9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154864; x=1710759664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8BY+YO3if2lvYNHvMPH3qE1q2AnqB9hh6Oit0y/824=;
        b=euz9RFf+fzFX0DHc4nlqNSzORr9awxe1hgNJ8BSLo8H//LtC7Q0JQxTJcewVjmHxm/
         XKNzVAHm3zQM8ojWU2A5zITl65qFv+8u8fSLGomiL5/sh9eF6ifA6X4IQ6bb2CcAKZ0f
         ckaI1L3FBFCUEMf64JkKLhbBbZxPfXoisWEAp36ySgp6AQsH0l68WXjYQR94cKHa+oOh
         ny+RiAoKIyzqDb4TAmONeKfdNwGn9E+A91NXA7MklzYu3pvFug5RYdvP2KdYxM4dKwc6
         vIN8leC1r9FfJdH7F5hUrjpUacVWsDmCtZBipZOCASQQ6jqanfLsYERSgJAkYmUZ1Bx6
         Cmhg==
X-Gm-Message-State: AOJu0YwnNgRSeg1tV2vgw/EWh1vgeqMxhaidpUmNuE78swxiG5z5Q+a+
	LYi6ClWH5jLsSog21kvdRSuFuLKZLIa7GyBNVxO2uwnShYf4N2X9QlLdU42Y0CzZqnpoPnzqtSm
	8cud1JV6LjE3zFNcs7hbe+CvhMQV/V/9qfcKg2Q==
X-Google-Smtp-Source: AGHT+IHbbuVIG+1MZi+oJqz/D8yV/jdYo7caCm1gu8b8zftneCGuZdTmvPo+cStcFkBmT+2xvPHhFu0FEoP2R4PD0QU=
X-Received: by 2002:a05:6870:1197:b0:220:fffc:e085 with SMTP id
 23-20020a056870119700b00220fffce085mr5304400oau.18.1710154864524; Mon, 11 Mar
 2024 04:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307092104.937440-1-jens.wiklander@linaro.org> <ZerVwbT8cbXuzviy@lpieralisi>
In-Reply-To: <ZerVwbT8cbXuzviy@lpieralisi>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 11 Mar 2024 12:00:53 +0100
Message-ID: <CAHUa44GVSFhdrsULSnn8KjG2LJJWEUVdVyaJwCOgH01QLaVFTw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_ffa: fix ffa_notification_info_get()
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Marc Bonnici <marc.bonnici@arm.com>, 
	Olivier Deprez <Olivier.Deprez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:09=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Thu, Mar 07, 2024 at 10:21:04AM +0100, Jens Wiklander wrote:
> > FFA_NOTIFICATION_INFO_GET retries information about pending
>
> s/retries/retrieves/
>
> > notifications. Notifications can be either global or per VCPU. Global
> > notifications are represented by the VM ID only, or 0 in the absence of
> > a hypervisor.
>
> I would just say "Global notifications are reported with the partition
> ID only in the list of endpoints with pending notifications".
>
> > ffa_notification_info_get() incorrectly expect no ID at all
> > for global notifications. Fix this by checking for 1 ID instead of 0.
> >
> > Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INF=
O_GET interface")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Thanks, I'll update the commit message accordingly.

Cheers,
Jens

>
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_f=
fa/driver.c
> > index c183c7d39c0f..ff1f37a4b28c 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -790,7 +790,7 @@ static void ffa_notification_info_get(void)
> >
> >                       part_id =3D packed_id_list[ids_processed++];
> >
> > -                     if (!ids_count[list]) { /* Global Notification */
> > +                     if (ids_count[list] =3D=3D 1) { /* Global Notific=
ation */
> >                               __do_sched_recv_cb(part_id, 0, false);
> >                               continue;
> >                       }
> > --
> > 2.34.1
> >

