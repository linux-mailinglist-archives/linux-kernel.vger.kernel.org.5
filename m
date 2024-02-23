Return-Path: <linux-kernel+bounces-78170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F97860FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78E91C2290D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692AB7A722;
	Fri, 23 Feb 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNXUAdlz"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82F5FB82;
	Fri, 23 Feb 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684904; cv=none; b=OpxC+MP6aKlSfrkIxNisIXXE0lH0anGf5Pxt0qgVFMyBzUnTfbCug85og/fgDAZgspT8z4gtLX57tS0K3WBnGNqfA+c8PM7uD+RfOYhOyNaczPIw8VufLTS0gGHDZSml+lRu3WKfR+rZwSRxH8fexDNBGQ3kpZLVfw5O+Rc4M1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684904; c=relaxed/simple;
	bh=pMA/M1Wst7tXkYIO5GIr1rjeX1F/9HHGrY1Lxy8EC3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYDaltaPLpq5zNpd3+JNM4LNnEH5/teblyXxTT/37c21tPX01PGJW5r6k0dbE8xSoX2e0hGxdHSNwqKFyI+Q9fdy6Gf3hW5ktUZa9Heq32SLLZX/4+h/4s1hy1VkcHo+aDvT80NauSrgI8Qpzb+tX2qQlrDXaSfgaQys0l0BwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNXUAdlz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso128235366b.0;
        Fri, 23 Feb 2024 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684901; x=1709289701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMA/M1Wst7tXkYIO5GIr1rjeX1F/9HHGrY1Lxy8EC3w=;
        b=nNXUAdlzppPpKfGM+9uUXwTErhlOIWOEuIIycM5iubmq6LkmexL98e41OsNy+L8qDe
         yrV0hi618880HngsiGM+Zg8HCnkGimOHdp/QZen5W71FFV3LvKYc7YBMbjhar/+eyZGY
         Ad3AECKIxoa9Hqrhh2knV8qRLDy9Q8OfkkhsxSdLkJDJhZsQ+vLljKhMzoNn6UKjYBsA
         NSKHgNsSnqu1dMls+GHOKI4lW3eHVA9Xi6MvAPcK9/rCbWnxWQ3+rEx51rj2sOvXXp7Y
         WGNBxtDVmhFmGOZKNgkDT1iuE5Mcleu6DqRhoZ7FYpgFdwGX5CKOx0gaSrYDkT1po3DB
         bkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684901; x=1709289701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMA/M1Wst7tXkYIO5GIr1rjeX1F/9HHGrY1Lxy8EC3w=;
        b=Vda7QvdLes8BW4WLCprRLOHrrirXF7Y64xBXOWHNbGJOzbIuXqCToVOpbT2K5t6ua8
         xhhANJ4Qnwq8okg3rZMNSaJTmScoToN0SRfbu0hEjaoWinDZVzzAGTs/UAvb+vkmXTEO
         3MWIMHNca4cu2Y8d7z9XMC6xhFLuNUkPDUQ2uK7MruQ/zCqBF8aCHNhBjgaZiRA8Wi0N
         Wb5ckVjjTYNq4Ml7vUbtog6inCBl3OQF0iF6gloGgvSzPha6K6XHJyd+hJDX29iF9dAI
         tzD5OmOqV5FISQpOtdMpaabmNO/oWo8RzSye4WvE08WsJzCXPX/OOfnJMM7JvmsyM2RT
         GLaw==
X-Forwarded-Encrypted: i=1; AJvYcCWTZyMP29Kzo4jXJqKUZDzq9EXd4yaWyb5yhhuiaJnTjp9boHC0beCS5iPZuLgqd74wM549jziqk/lWzHTJkGZJUgGCBfofNJKRqlEZOdXZmLOLo134gEN9k8bRh2zIC8AvBVHpbcJD/w==
X-Gm-Message-State: AOJu0Yx8fwGP6tvSPi+tVDfcPfSZVFX5Qh3HeJQ4rwGLZXckCId8RRLR
	ZQgJbYHglmSBOe3McYvEILV0bxXJVswz9Nz5/eo5UXLQwW3nC9Zb
X-Google-Smtp-Source: AGHT+IGUCCSCQV9rw4wx/ZhCMSmgrPlnVN15HXlKN/MbnKUIkrgqLVKR3L5lMpuFeA3d/5nKzSSAzg==
X-Received: by 2002:a17:906:5c9:b0:a3f:4800:1fa8 with SMTP id t9-20020a17090605c900b00a3f48001fa8mr4270726ejt.26.1708684901141;
        Fri, 23 Feb 2024 02:41:41 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id ty24-20020a170907c71800b00a3ee41cbe87sm3762669ejc.153.2024.02.23.02.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:41:40 -0800 (PST)
Message-ID: <cdf0a9facd95a2b7ee618e6130dedb9aabf4ed09.camel@gmail.com>
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
	 <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Fri, 23 Feb 2024 11:45:02 +0100
In-Reply-To: <20240223101115.6bf7d570@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-2-herve.codina@bootlin.com>
	 <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
	 <20240223101115.6bf7d570@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 10:11 +0100, Herve Codina wrote:
> Hi Saravana,
>=20
> On Tue, 20 Feb 2024 16:31:13 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> ...
>=20
> > > +void device_link_wait_removal(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devlink removal jobs ar=
e queued in the dedicated work queue.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * To be sure that all rem=
oval jobs are terminated, ensure that
> > > any
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scheduled work has run =
to completion.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drain_workqueue(fw_devlink_wq);=
=C2=A0=20
> >=20
> > Is there a reason this needs to be drain_workqueu() instead of
> > flush_workqueue(). Drain is a stronger guarantee than we need in this
> > case. All we are trying to make sure is that all the device link
> > remove work queued so far have completed.
>=20
> I used drain_workqueue() because drain_workqueue() allows for jobs alread=
y
> present in a workqueue to re-queue a job and drain_workqueue() will wait
> also for this new job completion.
>=20
> I think flush_workqueue() doesn't wait for this chain queueing.
>=20
> In our case, my understanding was that device_link_release_fn() calls
> put_device() for the consumer and the supplier.
> If refcounts reaches zero, devlink_dev_release() can be called again
> and re-queue a job.
>=20

Looks sensible. The only doubt (that Saravana mays know better) is that I'm=
 not
sure put_device() on a supplier or consumer can actually lead to
devlink_dev_release(). AFAIU, a consumer or a supplier should not be a devi=
ce
from the devlink class. Hence, looking at device_release(), I'm not sure it=
 can
happen unless for some odd reason someone is messing with devlinks in .remo=
ve()
or .type->remove().

- Nuno S=C3=A1


