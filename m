Return-Path: <linux-kernel+bounces-63745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E48533E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D391C22114
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDD5EE76;
	Tue, 13 Feb 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axsbd6Ky"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD505EE62;
	Tue, 13 Feb 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836280; cv=none; b=HOxMmZ4dHAHa8MqUiX42FhBrDFu87ahuHgEM2OD7nhbZCKWiN7UJTSjKIvOT+fcS348p5eJZLVEppmDNxBoj6BGtEjwRJJ2e6JLHCeWOu6wcMcBQpCDaAp/DUhsE7AVH2o+C0USFHdpSWCz0HL6dkgudX27xNqBEcb2d0LriE3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836280; c=relaxed/simple;
	bh=Beylajy+OD5xwTFO0kWRd7nCaF7rx/fnxJEH3rZBbAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMF0TIYOUdgb2w3hd/k2Bcizi+TE6SXK3oS/ScmoKfNSZQ7L0XVyNBXYBlpwOnvbfR0fb48UGbmULfjuY9entyanndIz4CR6T2R6O6KAwKZkBHWMXJ/8m3m+4Daa46rgwFJ+2qm2rkTviXhBJvf3ngsVn3SKk5nI+swer5mc+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axsbd6Ky; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-562131bb958so201105a12.2;
        Tue, 13 Feb 2024 06:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707836277; x=1708441077; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hx/0sTmo97XnxiVkWjsDz4DVqW2/rhqvFLAhp3VXV20=;
        b=axsbd6KyEK/QxePkWDzeP82DJgLqa9oz6YxBcF/hao+ZgoTUncU4PSSH4VVyf9Sp0A
         Mi1zLHXXPJgAsU3Hwlc0L7dISSuLmrtEN3M0rNTcT6vct4LLmnsR310+ognqxChEbEyM
         8gbnA3amZLEYmuTUC0IUeF5IMtK4IV/ueL7abKG6QI/WOnWkrXL8sTFct5Y2lc0ZBrNy
         3I+Jptk8WhKlE4I+BgnI8qiUEDJ9zhQhy0JV4/Xb4ckcpnu92MEMNOoV4sdBLSreifIu
         ymzhA1pGASzbbCvvDJTPWojU/4kUjMkPj+L2arWL9r4NoWAt3UEH276muDeFkUbyzaSS
         khtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836277; x=1708441077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hx/0sTmo97XnxiVkWjsDz4DVqW2/rhqvFLAhp3VXV20=;
        b=d4JH23ugE9zOq9dsCSOcA3jcT8afhZKwkp3FioF4b45Yg2Jp1XG0pyKCwH3CpJO4wc
         1IeGCgsYvwM4mU9bgU3tViVpYggFPcQZSTd6cy4Rk1NRAR/pEmwmHFD7PtFMihO1Nzik
         HYEYrcq36acCD8bgh+Sxx91GRmwx5hrlGjOwBWJ9kgycrP+6SIEn1/9Ydi622zphWpzq
         wqg1vA8uas2TlPqdU43JW5azXdGEZY89oQCIWLUun1JxsQlTYB9rZrmXbx+0EWq6wUDV
         iv/VANq7EQmdb2pYaf4vUlPMcf3Z3UpUDPsao/BNBvreM4qpomgO7QMJXLyOwQJq+nBQ
         jdNg==
X-Forwarded-Encrypted: i=1; AJvYcCVygQ+j/Qu3D6noTJbEG6+bgwle3gODbImLMi4va4qSRAUkgWneBDhm5O1fR3zfI3h2df5AUa/qzKniZTRSUhj9nHm1q31laC6yP5SYemAeigFVeEK9iu5FdF6uZ968gLFeYRn5Sfjx2M2PVrNFb+OJLy/pMOW4Ae15KboOYvVIUgU8+rI=
X-Gm-Message-State: AOJu0Yw+BJklzn3RemBTKtzapxdfpDH4hZ5ll6Mnf6J4sy6RnffyU5Lh
	60xMrXOncfSvHd/LGLSX/ZcjQoHRUo5T0q167OEI3L4JQ9m0w1vJfG3D759OX94IUo76
X-Google-Smtp-Source: AGHT+IFQ/tL3dvPNh3W0cUOuqyBlE6gW5LNl+XlyXHBhQJpI07z8Sq1dDKE9jE5kNBCmlfhbs0VpHw==
X-Received: by 2002:a05:6402:1812:b0:55e:b942:aaab with SMTP id g18-20020a056402181200b0055eb942aaabmr7519608edy.23.1707836276969;
        Tue, 13 Feb 2024 06:57:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWypHjMnO1tuyvO0Jc8gaeeWc89Zuvx2zLZzWB9TDSem3tXpVAThl8CHhQYulq2/2yQCS0Nt8wmITLnzGh4+rkW0TcuFFTipUkXZSYYtlWUBOAe4ThIDtifOrhsakG9Gf4Cku2+3TeIkDN8rVe+UPQgFcmziApfKPiZu2mDmA5dxEv1gwU7AXNaW6dO1PJnEvgusgDxxoN5s7Nb6OrvalNhi6Wu5W+ciCH9JLxI8rJPSgQc63dU0vKBFWH+60OyCFMS/IxHwo2+sZEnjGY6ECzb58cIn9XBTRFWEZS4DWJNiwlymS8GwG7MG6IsHv8+ylVbeEHshOOerpTk8xvbwJ66Yd+BFyQqsEiEMiCcOa6ZWrcVVPRpLL9t8Tg4SWv0tgXgl68xosRYeV39r6thwo8P49L8YYJq/nUtXUWsYarb9wuSydGbtM3vUXIoFC1IeMBCjH8pJkiPcJyjMyd9gGD/+ibYAIWjnUPQ
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id cb18-20020a0564020b7200b0055f50417843sm3755120edb.22.2024.02.13.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:57:56 -0800 (PST)
Message-ID: <48a86fa6908a2a7a38a45dc6dbb5574c4a9d7400.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 16:01:15 +0100
In-Reply-To: <20240213145131.GA1180152-robh@kernel.org>
References: 
	<20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
	 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
	 <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
	 <20240213145131.GA1180152-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 08:51 -0600, Rob Herring wrote:
> On Mon, Feb 12, 2024 at 01:10:27PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> > > Device links will drop their supplier + consumer refcounts
> > > asynchronously. That means that the refcount of the of_node attached =
to
> > > these devices will also be dropped asynchronously and so we cannot
> > > guarantee the DT overlay assumption that the of_node refcount must be=
 1 in
> > > __of_changeset_entry_destroy().
> > >=20
> > > Given the above, call the new fwnode_links_flush_queue() helper to fl=
ush
> > > the devlink workqueue so we can be sure that all links are dropped be=
fore
> > > doing the proper checks.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/of/dynamic.c | 8 ++++++++
> > > =C2=A01 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > index 3bf27052832f..b7153c72c9c9 100644
> > > --- a/drivers/of/dynamic.c
> > > +++ b/drivers/of/dynamic.c
> > > @@ -14,6 +14,7 @@
> > > =C2=A0#include <linux/slab.h>
> > > =C2=A0#include <linux/string.h>
> > > =C2=A0#include <linux/proc_fs.h>
> > > +#include <linux/fwnode.h>
> > > =C2=A0
> > > =C2=A0#include "of_private.h"
> > > =C2=A0
> > > @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> > > =C2=A0
> > > =C2=A0static void __of_changeset_entry_destroy(struct of_changeset_en=
try *ce)
> > > =C2=A0{
> > > +	/*
> > > +	 * device links drop their device references (and hence their
> > > of_node
> > > +	 * references) asynchronously on a dedicated workqueue. Hence we
> > > need
> > > +	 * to flush it to make sure everything is done before doing the
> > > below
> > > +	 * checks.
> > > +	 */
> > > +	fwnode_links_flush_queue();
> > > =C2=A0	if (ce->action =3D=3D OF_RECONFIG_ATTACH_NODE &&
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 of_node_check_flag(ce->np, OF_OVERLAY)) {
> > > =C2=A0		if (kref_read(&ce->np->kobj.kref) > 1) {
> > >=20
> >=20
> > Hi Rob and Frank,
> >=20
> > Any way you could take a look at this and see if you're ok with the cha=
nge
> > in the
> > overlay code?=20
> >=20
> > On the devlink side , we already got the ok from Rafael.
>=20
> Didn't Saravana say he was going to look at this? As of yesterday, he's=
=20
> also a DT maintainer so deferring to him.
>=20

Yeah, I did asked him but I guess he never had the time for it... Saravana,
could you please give some feedback on this? I think the most sensible part=
 is
on the devlink side but I assume this is not going to be merged without an =
ack
from a DT maintainer...

- Nuno S=C3=A1

