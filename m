Return-Path: <linux-kernel+bounces-119530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4B88CA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61BD1F8240C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0E13D28A;
	Tue, 26 Mar 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6zriJyu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800611865C;
	Tue, 26 Mar 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472308; cv=none; b=V9aR13ydGZSkHUJb8GAFCS2cKK8DLPTw6J+oylz2IkC3/EOndNDMVcWekm2rh2U3Hn8pqy07Rrq+7QDb4c1S0eFJdVQEogmtTMVUHbfngTGP9kcxMOYfDxgLZIkyhT9eIcqn4XHAVpt0PE821sMAS3RFLNwikbktqY45hQrJT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472308; c=relaxed/simple;
	bh=50BqQDcDVQNITuDK3eJNa0b+mguy7/AkzhyNXxuLwAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIQuEmo5Z0GEqGR9YD2tP5IF4wddFGRUmRi3Szq28+ENRrNtoejjJpT0xeQ3Amn6l50xUYLUErV9tY8l+bFipNTqhEUuM6h17ROwtRmv3SmEepfpuup3jrHX+kzzJPhqoTq8WseS/WcVxpL1NMEG2izE+mTiy1Auk8VrB/oMbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6zriJyu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so6454431fa.1;
        Tue, 26 Mar 2024 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711472305; x=1712077105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50BqQDcDVQNITuDK3eJNa0b+mguy7/AkzhyNXxuLwAs=;
        b=E6zriJyuOAgFrT6Sr+C6C19vUFvatjLmIpfKFaUs9M1mjP3KmEct4vfmvQhHDZs6Qc
         xiK2CH9QvNh2wxtGMcExn1naF0AFMrhqZ7OX3RRf6JsL1L30AohNjl9ON5Qd4O56BRJy
         XmN6VKJHbO7AsNe8O1Gl9OqtZ/ooMKf0CJUS5JGhuvPyZdm0o7dOyt82/2CRcPayyz1y
         34iV+OuAQgFXmvoeuhhAF8Fma6AxLRdgOqkYaeDZ4O+iBuMyR+I/KKcguzvSEGv3eU/S
         l3e2kMCeGlKxNOifCEmjTnph0RVW1kEdQnUJ9+7BrUI5iOeRjx+TcIJmnMD8fkCYiOQM
         J+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472305; x=1712077105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50BqQDcDVQNITuDK3eJNa0b+mguy7/AkzhyNXxuLwAs=;
        b=oh501KOeghLRTzk20Iq6SGTunOAy5VMpRXP71NJ6/dUoXk9RBefv2lxWdOdM1iUZQf
         GOpQdpxpu40meCxYEJoYW86A1/PeiE3HRBbcb597sd4zL0RGSnEyIKrzkZ8cYvpkMk7e
         /R3+4l64oP1HvYKdeCH+nONDTJ179waQWLbbuYEyXBtoPwIW9YAig9nLUHl6cqJBoWVm
         FsOD/YaLbgeWatwC4h9Pjx0q/41jSEllSSF7u0QsbH49VNzLYigUY2BA+/16Hrlimg39
         Yt2L2CM3rw1vRnN2lPzPnlxeGb9sLTgtojNg+EYIhDoqRZV99rKwEBAPdODq6yA8cauz
         r4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWJM/+hNpPVl5A7nidcwFMHmV17sFGyOJKWq3XC3yjsoWbrINbkvncoLe7eNGADXqqhTzZvjtPUfzPc5Wv1daNxRKsToQIiolGAghSV+z2eQD64KbVMScZYqj5dFMiIzuDpUpVmDttPmCIxnO3JoL0evwXrcYTcevT3O/MnJB5ooU9DclIV
X-Gm-Message-State: AOJu0YwNve6HyfLmD4bNj5DygkNJPq0zyr2sOE9Zjr7PzKuXnjfYpzHt
	gWQXcZZMOfMgL1fMCjT1PFQVRjSvSHLkIRMi1bA9P7Giq2YZ71G9AuFIZ0JQiqi7QHBLfkRNSK4
	xu9h/Cn3m8o2gJGEpqQwkTRk3ng8=
X-Google-Smtp-Source: AGHT+IEuCe2UdhWsZ9pv7297ZbfrjwO9PvFFV1b1MMnC3eyQey151SCgwgx3p7p9BMN5BYGkpdafNnXXiZTJJYvS5Vg=
X-Received: by 2002:a2e:a374:0:b0:2d4:6d2a:2df7 with SMTP id
 i20-20020a2ea374000000b002d46d2a2df7mr753307ljn.18.1711472304649; Tue, 26 Mar
 2024 09:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com> <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com> <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
 <ZgHbPo57UKUxK7G8@hovoldconsulting.com> <CABBYNZJFzDaLdXsdNEP1384JaJEN5E78cgmWfOus_LGOREGsWA@mail.gmail.com>
 <ZgJ0okobGv5nPreG@hovoldconsulting.com> <CABBYNZKJJuPHEwyXFRi8Z=P0GyaY-HdamsxmV8sR+R97ETTmEg@mail.gmail.com>
 <ZgLnOHiCzo5AQzra@hovoldconsulting.com> <ZgL10ur0825LgWVK@hovoldconsulting.com>
In-Reply-To: <ZgL10ur0825LgWVK@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Mar 2024 12:58:12 -0400
Message-ID: <CABBYNZ+1vXi51YbcfqaHTwW+z7OL=yDCuab6X8eDB-q+CoO+7w@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Mar 26, 2024 at 12:20=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Hi Luiz,
>
> On Tue, Mar 26, 2024 at 04:18:16PM +0100, Johan Hovold wrote:
> > On Tue, Mar 26, 2024 at 10:17:13AM -0400, Luiz Augusto von Dentz wrote:
> > > On Tue, Mar 26, 2024 at 3:09=E2=80=AFAM Johan Hovold <johan@kernel.or=
g> wrote:
> > > > On Mon, Mar 25, 2024 at 04:31:53PM -0400, Luiz Augusto von Dentz wr=
ote:
>
> > > > > All the
> > > > > CI automation is done on bluetooth-next and if you are asking to =
be
> > > > > done via bluetooth tree which is based on the latest rc that is n=
ot
> > > > > how things works here, we usually first apply to bluetooth-next a=
nd in
> > > > > case it needs to be backported then it later done via pull-reques=
t.
> > > >
> > > > The revert fixes a regression in 6.7-rc7 and should get to Linus as=
 soon
> > > > as possible and I assume you have some way to get fixes into mainli=
ne
> > > > for the current development cycle.
> > >
> > > Yeah I will send it later today to be included in the next rc release
> > > and since it is marked for stable that shall trigger the process of
> > > backporting it.
> > >
> > > > The series fixes a critical bug in the Qualcomm driver and should
> > > > similarly get into mainline as soon as possible to avoid having peo=
ple
> > > > unknowingly start relying on the broken behaviour (reversed address=
).
> > > > The bug in this case is older, but since the bug is severe and we'r=
e
> > > > only at rc1, I don't think this one should wait for 6.10 either.
>
> I just double checked the bluetooth-next branch and everything looks
> good now (revert + endianness fix series). Thanks!
>
> Did I understand you correctly that you'll be able to get all five
> commits into 6.9 during this development cycle (e.g. 6.9-rc2)?

Yep, I will be preparing a pull-request with them later this week,
there are some other fixes that I want to get in as well.


--=20
Luiz Augusto von Dentz

