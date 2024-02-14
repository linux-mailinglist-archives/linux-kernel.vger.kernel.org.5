Return-Path: <linux-kernel+bounces-65210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA14854981
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA411C21D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178352F73;
	Wed, 14 Feb 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/mBddbj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09E1A731;
	Wed, 14 Feb 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914894; cv=none; b=pp3GKgoXMraQZl6nyW463TBTLe+ApB0L9c2wQBKgPxF2EyV1G99Y+kYhfvQMLcxRqv/7qr2DXquFHnZ980/cfDcVg3z+WzurfbR20U256+07/fiJvVu0vS3NKSxkrhsdtP4F7J6CoZDSMCX9vDMWJ7kPAWv372TXy7X6DTbz9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914894; c=relaxed/simple;
	bh=DR9oD1vhlP0vc3JPAqFuhWP9LjrRHFpS5jANBMn3sSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTIPhzZEeYpCtKMehisVMhIOi8hGsYpD7bFlD1NrTeiX9LQHrBtQp+GqF8Lko05ka4d7IKJfBH40DR/PNFa89WE8HCrzZxKYul6pzflCxnnORrAYuGRxu32bx1C7BJur2sysTW6c/Puk1TcRSUrylbgHxh30lksUVQYds3s1RpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/mBddbj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a34c5ca2537so699366266b.0;
        Wed, 14 Feb 2024 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914890; x=1708519690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DR9oD1vhlP0vc3JPAqFuhWP9LjrRHFpS5jANBMn3sSE=;
        b=A/mBddbjY5uThLIimlGXhZCcjpxuAgvZ9tylwMXkIEzGHnUlo33ks305yOyWrW7rpq
         YAdrWT48j+S1QXK+rRnyXe2Y5K7t/6D0UGDPVaaHPvHdJvfgVlRhdcrx9Is5od/F3oAt
         kO7hIbkBFIWpSDEknBmD3TC4TPJrYa6JxsfeueqmaWn+ERElCsuwGWLN/d4ps6ImI4ph
         A86YqAtKv0BG7nJPSYXBvLmZCByLEHPvn2YCReA2RpexQDKotfxMuTJkfKxkunMwZOB5
         mvGVv90Lkltxs9/iCuYm+6AGJold/1ihygwkgbhxCHnzONHC5A9IGqIYzbeM7BOIquaI
         zeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914890; x=1708519690;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DR9oD1vhlP0vc3JPAqFuhWP9LjrRHFpS5jANBMn3sSE=;
        b=AqMvlGpMXIgUVtl8o62/D2e44GwyBYzubuXItL+TJRlptj82js3CDzJ50zevZaxPAp
         1obcoOcGop6TePvi2NlOyzxnAazl6N5yZlakBsn9wEuBMiNq4OkWOyCAR9D6mZTntcFE
         kWvvPRE7ypXAHTU/yJsH6JUmdXB2Qxjj0bo2puxt2yz/ANch4G9BYo2lYadC3IFVlaGj
         Lvt7V2uMp6Wg2YkRXDrChX0ZYdxJpUbLBeO3Yi4xH5RLi2s1cB2HcZuW1/1rOljyJCkJ
         y9pZoJmzzTG4vUrWdC9AzQFtekTzm1geLS3adqXDNlNktT8V+SaeCPRgvc2XOlIxFR6R
         ydQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLGQ5W2lMJ0YTw+Xn9aU9uob108oK7BtR//FB0WmlRhVkSkOpf8akDU0u2c4AcGyrv93Pru4K66OFRSBFg9CtcMWpMFXHYRNhC42sgz0VA9MNLFrFaK9RvsgwdvWsPyTYLY5U7FUap175XpQKlDTk4KejqlQh0N61RlFvJNAzh7AqnZU=
X-Gm-Message-State: AOJu0Yw+OPlAlGu6mXyPAzdH4L6TxCoL5B5rqfNCNKtnK4ZF9rVQtRJ0
	QtoW5CdwyIwxKc6DN1k/3tTBIxSD5rmFJSjLMGEgF9gcgVnOHbyF
X-Google-Smtp-Source: AGHT+IEegKSAQFOUPzMSNOuf2C8AnGjL8nXFejPi9Vp2cIOBbNkVpvxcH4iJcmb+xLaYqTxRhwFNfA==
X-Received: by 2002:a17:907:7653:b0:a3c:f045:a516 with SMTP id kj19-20020a170907765300b00a3cf045a516mr1538013ejc.57.1707914890398;
        Wed, 14 Feb 2024 04:48:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6PwgYAS1wBsdNItpTgnbAL/LcHw7GQaolP+YXvl6K5d1+ONW4LpZ7FQ6gnnAUTKXjnhL9x3DxmkJts5ckoZ3iQJobuLRXsBhVudUu91Azarp4zXPHlwtytk8YPCOnFvwHRHdCEBo6GzdeKI6D02xmLS0bG9U3c8TwJYBjz728eAOnX8cgIf3y84V1jc9KW/N7u7o7MOpazGotf0Xqt3jkn3V9jT6FXoZbDupwtWQvyyqiAEumhyPcPWN/ShCsR8Bjnc9YKlAJAFTCcXnKZlsZPMOS2bqDIBaECjT0XxF8U6HsHQQXAEuo8tnr9a9+Hddlm4CgLvi9vqpxHftVO90GuukHXv3QZ4mIZx3108ICpXL8hGTO5cweHSkdL+dIWP/gDsVR0o3KhpbTP6PY5ruJbsarojyIW8D4Qj6co237TfthBfrYhvjy4WdlWulQecjEHWsDKMzU+w8Z7lYneAHDqS8JzlFS1gHIzuUloW2QIwMkdjlJ6TkJ5leVAW5/Gag=
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id h2-20020a1709063c0200b00a3d1ea6134dsm1155253ejg.197.2024.02.14.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:48:10 -0800 (PST)
Message-ID: <71fa22870246c4ed6ae9cbb2cb93db557dd855f7.camel@gmail.com>
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
Date: Wed, 14 Feb 2024 13:51:29 +0100
In-Reply-To: <CAGETcx9xgLykm7Ti-A4+sYxQkn=KTUptW9fbFxgTcceihutwRQ@mail.gmail.com>
References: 
	<20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
	 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
	 <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
	 <20240213145131.GA1180152-robh@kernel.org>
	 <48a86fa6908a2a7a38a45dc6dbb5574c4a9d7400.camel@gmail.com>
	 <CAGETcx9xgLykm7Ti-A4+sYxQkn=KTUptW9fbFxgTcceihutwRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 19:44 -0800, Saravana Kannan wrote:
> On Tue, Feb 13, 2024 at 6:57=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Tue, 2024-02-13 at 08:51 -0600, Rob Herring wrote:
> > > On Mon, Feb 12, 2024 at 01:10:27PM +0100, Nuno S=C3=A1 wrote:
> > > > On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> > > > > Device links will drop their supplier + consumer refcounts
> > > > > asynchronously. That means that the refcount of the of_node attac=
hed
> > > > > to
> > > > > these devices will also be dropped asynchronously and so we canno=
t
> > > > > guarantee the DT overlay assumption that the of_node refcount mus=
t be
> > > > > 1 in
> > > > > __of_changeset_entry_destroy().
> > > > >=20
> > > > > Given the above, call the new fwnode_links_flush_queue() helper t=
o
> > > > > flush
> > > > > the devlink workqueue so we can be sure that all links are droppe=
d
> > > > > before
> > > > > doing the proper checks.
> > > > >=20
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > > =C2=A0drivers/of/dynamic.c | 8 ++++++++
> > > > > =C2=A01 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > > > index 3bf27052832f..b7153c72c9c9 100644
> > > > > --- a/drivers/of/dynamic.c
> > > > > +++ b/drivers/of/dynamic.c
> > > > > @@ -14,6 +14,7 @@
> > > > > =C2=A0#include <linux/slab.h>
> > > > > =C2=A0#include <linux/string.h>
> > > > > =C2=A0#include <linux/proc_fs.h>
> > > > > +#include <linux/fwnode.h>
> > > > >=20
> > > > > =C2=A0#include "of_private.h"
> > > > >=20
> > > > > @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> > > > >=20
> > > > > =C2=A0static void __of_changeset_entry_destroy(struct of_changese=
t_entry
> > > > > *ce)
> > > > > =C2=A0{
> > > > > + /*
> > > > > +=C2=A0 * device links drop their device references (and hence th=
eir
> > > > > of_node
> > > > > +=C2=A0 * references) asynchronously on a dedicated workqueue. He=
nce we
> > > > > need
> > > > > +=C2=A0 * to flush it to make sure everything is done before doin=
g the
> > > > > below
> > > > > +=C2=A0 * checks.
> > > > > +=C2=A0 */
> > > > > + fwnode_links_flush_queue();
> > > > > =C2=A0 if (ce->action =3D=3D OF_RECONFIG_ATTACH_NODE &&
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_node_check_flag(ce->np, OF_OVER=
LAY)) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kref_r=
ead(&ce->np->kobj.kref) > 1) {
> > > > >=20
> > > >=20
> > > > Hi Rob and Frank,
> > > >=20
> > > > Any way you could take a look at this and see if you're ok with the
> > > > change
> > > > in the
> > > > overlay code?
> > > >=20
> > > > On the devlink side , we already got the ok from Rafael.
> > >=20
> > > Didn't Saravana say he was going to look at this? As of yesterday, he=
's
> > > also a DT maintainer so deferring to him.
> > >=20
> >=20
> > Yeah, I did asked him but I guess he never had the time for it... Sarav=
ana,
> > could you please give some feedback on this? I think the most sensible =
part
> > is
> > on the devlink side but I assume this is not going to be merged without=
 an
> > ack
> > from a DT maintainer...
>=20
> Sorry for the delay Nuno. I'll get to this. I promise. This week is a bit
> busy.
>=20

No worries. Just making sure it's not forgotten :)

- Nuno S=C3=A1


