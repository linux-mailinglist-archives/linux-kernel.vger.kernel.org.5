Return-Path: <linux-kernel+bounces-74176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3585D0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F43928634B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3B3A1DA;
	Wed, 21 Feb 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBlnul1p"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AD365;
	Wed, 21 Feb 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498718; cv=none; b=hr/8HUV//QbP6cSyC23xrZ0K6TlarcgRlJouzjxpi9Hi/VW5hT5/4iHEhRjasU6sG4JaXaXr/SUZl4oLupJi3cmGSwqnhJabeuFF+TGC5vnxfv5aaZ6VJ+QYQF5W33blwNkBw2mpklXconve7Bojytef/oTiY7iEHkg9UUYX/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498718; c=relaxed/simple;
	bh=1jd6QMoE2ejlyiU6SG9p9X9CNmYrm38X2akkykt93dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXX86owVyBQz4LqZnwwHd9ZirXARPyesY6rw9UCk2wOc1sZ76TcBjLPgiYTbPwjVoE4ynk1+gO0LRpS5ZmoEkxC70Wc/kTEHbrCvh36H0kQDmk1EiToPS2/AqEG9ux44hGel6wLCSxo8EZ5QEHDVs6dNoHfvMFudpeuYJLotAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBlnul1p; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so892247366b.0;
        Tue, 20 Feb 2024 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708498714; x=1709103514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1jd6QMoE2ejlyiU6SG9p9X9CNmYrm38X2akkykt93dg=;
        b=nBlnul1pJfdkPAP2OKhFeCC3E8KZJqIpAbzaYkDzpR9a8GhGrc7Gnds3H5lOhmEx58
         8qBWYFczb6wsHT9qHBu9YT5/gb37QMHGpFEWRO4znHpoME6+CqfeRahyzfmhLc8ownib
         6kwklYqjRajtc2Mpz8oBPB7bnJln2FIisMI0ITlsZyqsgAprF8Z3SCbKAJ+1rjnYgzMe
         ZsGME1BNmzCcy6syb6zjCs3Y1A9whbOaj2Lu4IntVQ8DL1+CpwoToQPJLLTBBSspNGYB
         c6rDHfnnfY2gvON4f+58NstRa/F3TUFFSxflueW4wOF1imuUsJdlLOMD4XQ5R+jmCLl3
         IbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498714; x=1709103514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jd6QMoE2ejlyiU6SG9p9X9CNmYrm38X2akkykt93dg=;
        b=FCumL/e0gHTvCdeB0vRLqhU0SlgeFb72uaavwVFUm8XVnwQFpQVO/MDCOLhZexiBoO
         DnR+eKt1bQBghXmEhmRMvKqp0U2pzHQRuP0rcD0pwKXWLiNROr+7VxRx0jrL1WW5KQy/
         DddpCvtWwMTKsX4Oxj+ECClNLAW8FMDp+uzzfhMOzY/Iak3x2gFffc2837hWlgcQfpiV
         P5gv1B9qyOLFJsaj97XDEFQKOJ6xUjxi5t+NgcFMv0FR/Rlm/c/KSsJjVVNyKoF7alSK
         UCIeWvrQ8MempXjGDECFz4crQ1fiu6PdqMZy2kKXOrsYoVEbkDsXz5HjUg4YIKDRbOSz
         jUyw==
X-Forwarded-Encrypted: i=1; AJvYcCX6CmIrogE8Zh+uqS66rpKM/z+AmLQygZ/p5jJTfrzTmnr6xf00JKgI9/LVl1gXXEfwhxH0IN1hx0mM5uJARvW6RUjhfL1/0NhYb2So7+iCNKl9jSpUWozmuq+KF5ZrNNm3fQNZSsI5IKgtMWZ3hWzPSVV7qKRI96NNdhd8cMDfK+8UWi8=
X-Gm-Message-State: AOJu0YzrZ500zKEr+QRi2da2vNey2tDnQeaKCCd0cFsVDALgiFeu9S36
	kEAqdHOdAkfVxofgGkqmaJ+H3aug+fpZ2Zdyunhy2lI/P/gm03eP
X-Google-Smtp-Source: AGHT+IEdq9MC0zgE7wqEf/VS52ohHkOx4ge1L7oe+1hYC8s/S2/omVx3tnQ/BdcSwepvqOW0PZjRAA==
X-Received: by 2002:a17:906:80d7:b0:a3f:5576:d7b9 with SMTP id a23-20020a17090680d700b00a3f5576d7b9mr10387ejx.5.1708498714028;
        Tue, 20 Feb 2024 22:58:34 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id pk27-20020a170906d7bb00b00a3ee20b00d0sm1672835ejb.4.2024.02.20.22.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:58:33 -0800 (PST)
Message-ID: <96b3f77d6ed4a03030743b93bce144523accd585.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Android Kernel Team <kernel-team@android.com>
Date: Wed, 21 Feb 2024 07:58:33 +0100
In-Reply-To: <CAGETcx_kjmZypvhjGED5V3C4E=NzffD2=8cn5Hh-tEHTMVKsiQ@mail.gmail.com>
References: 
	<20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
	 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
	 <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
	 <20240213145131.GA1180152-robh@kernel.org>
	 <48a86fa6908a2a7a38a45dc6dbb5574c4a9d7400.camel@gmail.com>
	 <CAGETcx9xgLykm7Ti-A4+sYxQkn=KTUptW9fbFxgTcceihutwRQ@mail.gmail.com>
	 <71fa22870246c4ed6ae9cbb2cb93db557dd855f7.camel@gmail.com>
	 <CAGETcx_kjmZypvhjGED5V3C4E=NzffD2=8cn5Hh-tEHTMVKsiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 16:39 -0800, Saravana Kannan wrote:
> On Wed, Feb 14, 2024 at 4:48=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Tue, 2024-02-13 at 19:44 -0800, Saravana Kannan wrote:
> > > On Tue, Feb 13, 2024 at 6:57=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Tue, 2024-02-13 at 08:51 -0600, Rob Herring wrote:
> > > > > On Mon, Feb 12, 2024 at 01:10:27PM +0100, Nuno S=C3=A1 wrote:
> > > > > > On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> > > > > > > Device links will drop their supplier + consumer refcounts
> > > > > > > asynchronously. That means that the refcount of the of_node a=
ttached
> > > > > > > to
> > > > > > > these devices will also be dropped asynchronously and so we c=
annot
> > > > > > > guarantee the DT overlay assumption that the of_node refcount=
 must be
> > > > > > > 1 in
> > > > > > > __of_changeset_entry_destroy().
> > > > > > >=20
> > > > > > > Given the above, call the new fwnode_links_flush_queue() help=
er to
> > > > > > > flush
> > > > > > > the devlink workqueue so we can be sure that all links are dr=
opped
> > > > > > > before
> > > > > > > doing the proper checks.
> > > > > > >=20
> > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/of/dynamic.c | 8 ++++++++
> > > > > > > =C2=A01 file changed, 8 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > > > > > index 3bf27052832f..b7153c72c9c9 100644
> > > > > > > --- a/drivers/of/dynamic.c
> > > > > > > +++ b/drivers/of/dynamic.c
> > > > > > > @@ -14,6 +14,7 @@
> > > > > > > =C2=A0#include <linux/slab.h>
> > > > > > > =C2=A0#include <linux/string.h>
> > > > > > > =C2=A0#include <linux/proc_fs.h>
> > > > > > > +#include <linux/fwnode.h>
> > > > > > >=20
> > > > > > > =C2=A0#include "of_private.h"
> > > > > > >=20
> > > > > > > @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> > > > > > >=20
> > > > > > > =C2=A0static void __of_changeset_entry_destroy(struct of_chan=
geset_entry
> > > > > > > *ce)
> > > > > > > =C2=A0{
> > > > > > > + /*
> > > > > > > +=C2=A0 * device links drop their device references (and henc=
e their
> > > > > > > of_node
> > > > > > > +=C2=A0 * references) asynchronously on a dedicated workqueue=
 Hence we
> > > > > > > need
> > > > > > > +=C2=A0 * to flush it to make sure everything is done before =
doing the
> > > > > > > below
> > > > > > > +=C2=A0 * checks.
> > > > > > > +=C2=A0 */
> > > > > > > + fwnode_links_flush_queue();
> > > > > > > =C2=A0 if (ce->action =3D=3D OF_RECONFIG_ATTACH_NODE &&
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_node_check_flag(ce->np, OF_=
OVERLAY)) {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kr=
ef_read(&ce->np->kobj.kref) > 1) {
> > > > > > >=20
> > > > > >=20
> > > > > > Hi Rob and Frank,
> > > > > >=20
> > > > > > Any way you could take a look at this and see if you're ok with=
 the
> > > > > > change
> > > > > > in the
> > > > > > overlay code?
> > > > > >=20
> > > > > > On the devlink side , we already got the ok from Rafael.
> > > > >=20
> > > > > Didn't Saravana say he was going to look at this? As of yesterday=
, he's
> > > > > also a DT maintainer so deferring to him.
> > > > >=20
> > > >=20
> > > > Yeah, I did asked him but I guess he never had the time for it... S=
aravana,
> > > > could you please give some feedback on this? I think the most sensi=
ble part
> > > > is
> > > > on the devlink side but I assume this is not going to be merged wit=
hout an
> > > > ack
> > > > from a DT maintainer...
> > >=20
> > > Sorry for the delay Nuno. I'll get to this. I promise. This week is a=
 bit
> > > busy.
> > >=20
> >=20
> > No worries. Just making sure it's not forgotten :)
>=20
> Hi Nuno,
>=20
> Thanks for nudging me about this issue.
>=20

Hi Saravana,

> I replied to a similar patch series that Herve sent out last year.
> Chose to reply to that because it had fewer issues to fix and Herve
> sent it out a while ago.

I think it's fixing the same issues but as he sent first, fair enough :)

> https://lore.kernel.org/all/20231130174126.688486-1-herve.codina@bootlin.=
com/
>=20
> Can you please chime in there?
>=20

Already did... Please look at my first patch. It already has an ack from Ra=
fael and I
think it's fairly close with what you want (it might need some naming impro=
vements
though).

- Nuno S=C3=A1


