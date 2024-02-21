Return-Path: <linux-kernel+bounces-74196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A980B85D0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1CB1C226F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41D3A29E;
	Wed, 21 Feb 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRmn43fF"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AF3A8C0;
	Wed, 21 Feb 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499589; cv=none; b=kqS158d7JZi0vIpgOJoYyBEWW2NqyZ/20A5lXRVs/CqBEp1K1wAZB+tSEcSvfy8zUajupaspJnfZLHt8vvQE6c97m2sC1fblcqmwKt2YZ3BA4tLzUEHCpvbzUFXsOwDOaX2TdfnHQ/LSDvuZHwHDtUARAHypI8CrUwNuVGfhe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499589; c=relaxed/simple;
	bh=BYlt0yJ64/STqFM6+6BFOkQp8WSF3CmfQfcqtetiEOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEouptVRmdlt0ljvxdtDAjWCxh0fQH03MltfaV779sMyC62cPJAaAcVsrpaZZht++9I4FdfrGhNQ/PWD3UqlcqBojODNoEWkes/qRz8/HIsX9E+eoobb6JULyhjMW5Fuv6pQGVQ/fZFSSuo1T0IJmjox96OPx5JUBGcHwNp74iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRmn43fF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso6479406a12.2;
        Tue, 20 Feb 2024 23:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708499586; x=1709104386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYlt0yJ64/STqFM6+6BFOkQp8WSF3CmfQfcqtetiEOM=;
        b=BRmn43fFOTrccA1HYQmBohjAsaLsMaZKGKPqRvbde84JP5H2QvGdmFpzYw4+6Z6HKV
         XSxxs7cgCy+OaPbGv/JT38YU517O7QbQ/M0b77nmbEthWZBsDwlrH6XxCQy40TdNcxl8
         Advi6edJfMxwc3E5H5JMgwe642X6nfdPua066VCioJND5MLC8eXCwlWlWR3SYpzCQsVC
         XZMJMMg2XyrqDDhBfM7EDXr37AYsFtK73lSqMaX7a+e9kk3MA3ZoIlhR8N5DSXLAhl+E
         Jmg9OzQMsJ//ix82QTDZBkM/iwHCLry43RxpjlqBFM4c0uoj/itjs9RMaCfvXz+LSV/2
         TMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499586; x=1709104386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYlt0yJ64/STqFM6+6BFOkQp8WSF3CmfQfcqtetiEOM=;
        b=ioGOhZYgKYI3m9d0p9mf9Vhi9TUvN4cYd8QN5/AJvcxMyxp/o6KR8ScLY+OxX0BCGa
         tiNRJ44kxcf7e+v3Pg3iT41TCUr9IKdfZhjg0EfZkPnBSfwb8JKzLTbOKMahlA/hT0cM
         noaiilxLOHxyzarD7MuQVEPMFOuWamk5mNVw4Sf5IaP3HalhJwTu/NvH75UiYGcEueAK
         ITtY9vXwHRbhm1sNZBAtmeI2mNOv/+KZrvZr7j9FRSNq+nUBFmkdS3IgjWOLcnWbfspn
         xI42K1Ja+wXuGapVohoAIHPP/LZQ4hiQo2bRzxJftKZ5gxHAZgkWTX/QontgIylwDYjh
         Q6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVc4kolil0NMtNJ3SJmVXCJ2niJFnIGbYm9Q1J9bym/q0SfZzH+Y+dIdaYKuekXlPZxhobAaPQB3r9nWH6/nJW7ZBTvXRU5QmK8oXR+c+LCy1YFLxOuxy378iJzYtJFzvPwaOfCaznfdAssk9NX4qeipeW3LzjdHhVk2LnqnOpZgpucC9c=
X-Gm-Message-State: AOJu0YwTmJVgvUxU013iqBQqgO5Mh66fUxow1NtGpAxrzRgKAGEBO/85
	9IXzdHYUY1ErwwD3oNzd+3/aoBolYSLCfJlEWrmywMhb9ckMl3dfaDFlv7Iv+7BibQ==
X-Google-Smtp-Source: AGHT+IHih9H/kOAHi1jgRty14z6Wg6Wf6dyGnRbDr1Qq7YpRnBeCqaZTGERYL55l3oahk5qu3N+Cug==
X-Received: by 2002:a17:906:7c4a:b0:a3e:72ca:700d with SMTP id g10-20020a1709067c4a00b00a3e72ca700dmr7765191ejp.45.1708499585861;
        Tue, 20 Feb 2024 23:13:05 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907890600b00a3e1b4575dfsm4337061ejc.2.2024.02.20.23.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:13:05 -0800 (PST)
Message-ID: <17baf0c5e1ce19a1bc930fd439c27d9ef8cbe6a1.camel@gmail.com>
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
Date: Wed, 21 Feb 2024 08:13:05 +0100
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
> I replied to a similar patch series that Herve sent out last year.
> Chose to reply to that because it had fewer issues to fix and Herve
> sent it out a while ago.

Ehehe, FWIW, I did sent it out before I believe:

https://lore.kernel.org/lkml/20231127-fix-device-links-overlays-v1-1-d7438f=
56d025@analog.com/

I just got no attention and it took some time until I got some feedback (I =
also
pushed for it with resends). If you follow the links in the cover, you'll s=
ee I first
started (and spotted the issue) the effort in May last year.

That said, I'm more than fine with whatever series is taken. I just care ab=
out the
problem being solved :)

- Nuno S=C3=A1


