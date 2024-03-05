Return-Path: <linux-kernel+bounces-91816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA078716FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6636283D60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7E7FBA4;
	Tue,  5 Mar 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvHocoeL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673327FBC4;
	Tue,  5 Mar 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624005; cv=none; b=cFQ0enIUrzSWMWRXRTyG8r3P/7Y+aHWbOMjCWyrBk4x3NUZbnxdI4HDp/rWfSykLFinL/eWWVPxNuKsIKGke2bG0tC6eu2QLYPU4Z2cVjEa5q9IA7gjxuC91uNsZ+XmD+gK+SXe/9HmUDEWOEXyM/y/E6XaAQKt1a6ZPnpvyqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624005; c=relaxed/simple;
	bh=YGTFf+aFcxTPkfOtBdEs9262UzHkIoYVYZfRjmj18Zs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tOGxqgsDc+IfngWmzNaySQbX/fdQRMSX4myBk3uP58jFwFWb8vN4vqq/Zam9MZU20v/8YDhYiNJGZ5rixjHHSaFYkMQiNO3XDmp1nkDF09a+WbSmLI5Qve++eCNcWHTvcEFExl0rhIUEz99lhmbeKle3CSCMKw/R0RKMarS8dro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvHocoeL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56698eb5e1dso6933988a12.2;
        Mon, 04 Mar 2024 23:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624002; x=1710228802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gx7QPTKJai6jSFkj9+TJZzVP3EDqUm9KDYf3uq99HxA=;
        b=OvHocoeLnu7NNeIOgtC+6nhcTERVmhmXLuwguQg923YZsLWykgjbuEj/06nHMN/ndz
         8SIslbj6D72Sp4HYhH7slzZii8MXbZFbGqSY28AQS5L4qpKAFoa9u2y0m85LaXSSoiD2
         1sX8xF6AM6mm+b/ghL75ZWS5hTOnjYZwLs6tdLo4UCJi1+3e/jfBracxkx4AfDPx7KPZ
         VrCup5eec9TXLSNMPO0IXMhQjsD5gIOD8QzIEhhdn55TCVMbAKk0Rnib/PUbOIq2a2Nz
         eOC6q/yDsBefuISs2rmmcFJLogpzn7Q2NDW+6ekdCcjX589o7UopyMs/cDKqAm72iqBz
         Avsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624002; x=1710228802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx7QPTKJai6jSFkj9+TJZzVP3EDqUm9KDYf3uq99HxA=;
        b=M0VTJ+IeJfiC90rt+lNgPOLaHZYalgADoSykDHu3+YCO2lTBfVJaK18/J429+Nqbil
         Q0RvuNdwyeDQegdVWvKWAtokKFLT5FxmN4qV536Arzlt5SA7MTJLH8Dc+7m/hho7edTC
         wgj8SQ0ktqQA60WRUu5z/XM6YFCisJVYM1AXRlH/f0es0yGsuq6KY4WDLQlDmOxW/ATx
         BZaEbGNOFS8d/ykJodKPwuAi4ix/5UXQJdzAmtGAS88uXLOLUcmA2d5Jr+NAvkrXhJd2
         QYTQUA9lhXuKa6iIGEel1S5UOuejD9dZ0e3BwixBnKofN5XNRN6/xe+0eddDX7r+ASQo
         PdOg==
X-Forwarded-Encrypted: i=1; AJvYcCVozzgaDL3iwUxVKAS8Ki98F1mQ6vrmqtdu94UuosMcdnbg+hzBjRDg7HeRIwjPR6MP/OChLHn5JUA7wcw6jIoR18Z0P3LTg0eB2MPhVYHT9jMbTmSJQAxf9k5esniHVQG4lP3TogS5zIfZpBOKTtVJSxWDiKwqrvzSywCztQYQ/w==
X-Gm-Message-State: AOJu0YxbiqIphfTthVxlLoR0DUggeh3LrhKBIAVMw85nVBdfWoSNdWWn
	/xrZ8Ppb7F9JWbZqQxV+SrB+hWKjDEFXw4hltcaAz4bvLJFr7KPw
X-Google-Smtp-Source: AGHT+IHPvQtZwLezKjsSpiunSzo1ozz5dPp4RlMChtiuv+1LJpDBG7d+OgVW72CZXGBZnTesbmAcZQ==
X-Received: by 2002:a50:fa83:0:b0:566:51fa:3647 with SMTP id w3-20020a50fa83000000b0056651fa3647mr6914461edr.10.1709624001492;
        Mon, 04 Mar 2024 23:33:21 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id f16-20020aa7d850000000b00563f3ee5003sm5443887eds.91.2024.03.04.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:33:21 -0800 (PST)
Message-ID: <2f497783da939f13d8c8faeab931cac0ef9c98eb.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>, Herve Codina
	 <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>,  Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Date: Tue, 05 Mar 2024 08:36:45 +0100
In-Reply-To: <CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-3-herve.codina@bootlin.com>
	 <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
	 <20240304152202.GA222088-robh@kernel.org>
	 <20240304174933.7ad023f9@bootlin.com>
	 <CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 22:47 -0800, Saravana Kannan wrote:
> On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Herve Codina <herve.codina@bootlin=
com> wrote:
> >=20
> > Hi Rob,
> >=20
> > On Mon, 4 Mar 2024 09:22:02 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >=20
> > ...
> >=20
> > > > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > > > > overlay_changeset *ovcs)
> > > > > =C2=A0{
> > > > > =C2=A0 int i;
> > > > >=20
> > > > > + /*
> > > > > +=C2=A0 * Wait for any ongoing device link removals before removi=
ng some of
> > > > > +=C2=A0 * nodes. Drop the global lock while waiting
> > > > > +=C2=A0 */
> > > > > + mutex_unlock(&of_mutex);
> > > > > + device_link_wait_removal();
> > > > > + mutex_lock(&of_mutex);
> > > >=20
> > > > I'm still not convinced we need to drop the lock. What happens if
> > > > someone else
> > > > grabs the lock while we are in device_link_wait_removal()? Can we
> > > > guarantee that
> > > > we can't screw things badly?
> > >=20
> > > It is also just ugly because it's the callers of
> > > free_overlay_changeset() that hold the lock and now we're releasing i=
t
> > > behind their back.
> > >=20
> > > As device_link_wait_removal() is called before we touch anything, can=
't
> > > it be called before we take the lock? And do we need to call it if
> > > applying the overlay fails?
>=20
> Rob,
>=20
> This[1] scenario Luca reported seems like a reason for the
> device_link_wait_removal() to be where Herve put it. That example
> seems reasonable.
>=20
> [1] - https://lore.kernel.org/all/20231220181627.341e8789@booty/
>=20

I'm still not totally convinced about that. Why not putting the check right
before checking the kref in __of_changeset_entry_destroy(). I'll contradict
myself a bit because this is just theory but if we look at pci_stop_dev(), =
which
AFAIU, could be reached from a sysfs write(), we have:

device_release_driver(&dev->dev);
..
of_pci_remove_node(dev);
	of_changeset_revert(np->data);
	of_changeset_destroy(np->data);

So looking at the above we would hit the same issue if we flush the queue i=
n
free_overlay_changeset() - as the queue won't be flushed at all and we coul=
d
have devlink removal due to device_release_driver(). Right?

Again, completely theoretical but seems like a reasonable one plus I'm not
understanding the push against having the flush in
__of_changeset_entry_destroy(). Conceptually, it looks the best place to me=
 but
I may be missing some issue in doing it there?

> > >=20
> >=20
> > Indeed, having device_link_wait_removal() is not needed when applying t=
he
> > overlay fails.
> >=20
> > I can call device_link_wait_removal() from the caller of_overlay_remove=
()
> > but not before the lock is taken.
> > We need to call it between __of_changeset_revert_notify() and
> > free_overlay_changeset() and so, the lock is taken.
> >=20
> > This lead to the following sequence:
> > --- 8< ---
> > int of_overlay_remove(int *ovcs_id)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&of_mutex);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __of_changeset_rever=
t_notify(&ovcs->cset);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_tmp =3D overlay_notify(o=
vcs, OF_OVERLAY_POST_REMOVE);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&of_mutex);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&of_mutex);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_overlay_changeset(ovcs)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&of_mutex);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > }
> > --- 8< ---
> >=20
> > In this sequence, the question is:
> > Do we need to release the mutex lock while device_link_wait_removal() i=
s
> > called ?
>=20
> In general I hate these kinds of sequences that release a lock and
> then grab it again quickly. It's not always a bug, but my personal
> take on that is 90% of these introduce a bug.
>=20
> Drop the unlock/lock and we'll deal a deadlock if we actually hit one.
> I'm also fairly certain that device_link_wait_removal() can't trigger
> something else that can cause an OF overlay change while we are in the
> middle of one. And like Rob said, I'm not sure this unlock/lock is a
> good solution for that anyway.

Totally agree. Unless we really see a deadlock this is a very bad idea (IMH=
O).
Even on the PCI code, it seems to me that we're never destroying a changese=
t
from a device/kobj_type release callback. That would be super weird right?

- Nuno S=C3=A1
>=20


