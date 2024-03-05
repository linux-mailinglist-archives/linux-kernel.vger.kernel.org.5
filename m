Return-Path: <linux-kernel+bounces-92173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE3871C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07399B2344B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462D55C2E;
	Tue,  5 Mar 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwF4nEhc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483C5F85E;
	Tue,  5 Mar 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635442; cv=none; b=LuaryV6FyXo4urvBGygXmjbO0AkpooTa2VDgfhV6Z+kNWoSPMAv8ecETVgUEF7jpgiSLRED+W6tFrf1tiLSmaTCIQpfsW7F7woRD5nm7F/XY5gDS6zK9jkFYTQCBTOtl45Pi8EEl00SJx2uNFQrub8i8a9IcTGEJnDFZF+BRkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635442; c=relaxed/simple;
	bh=4vNNl7f7W2h0k3Q0Zqs0r02kCg6N1kQ9A0IS6U2AKKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVPiMDQXu6H2gaRKu7Y2am+kkXZy341M2IUGxoUMsaO41/B3Yrtx8nGhwtQYr/pUfW5Wp21p6agOixDlBCruSo2+alaHGzohkP5RXBW98PHxskwXZAbd6aY+fnoSGGKl5siaJL3U2amLVKcYJp8NUrDWdXakeyMHmHd4DqNl0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwF4nEhc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512ed314881so5075888e87.2;
        Tue, 05 Mar 2024 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709635438; x=1710240238; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFIWP6Y3k14brl4GsqcL1DZL+SHGdhktob9S00FRdmc=;
        b=dwF4nEhc8+bnSdmpOcyMFXM9goIn4mTqt4CwIgMTw66ZY6qdgl22XDZa+yXqW36tWo
         vqABreAbnaEAPdeVvWtb5lOLFkjUbt8Fks2zz4M9NT2OvAzygGqrj4hPkiFPLl4ivGcy
         K3atyxt3s7qBQB34uqQeZTw+gUyb/DXqSnChwJJicLrSoR+fEW/pcflcPT1GHHtmpmmf
         Kmn4KQnRN2mC3jK8lTqJdxcGB8akh576ej6zvRzg1it8Mk/tAcvLTOhrl9SVbVrB0mMD
         OIxfXaDIil3XrnQjWsUrLP697GbpPuuGFCTS0ywd2m1+wmR1wNRcufjyefWHFvhPlUaI
         V52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635438; x=1710240238;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFIWP6Y3k14brl4GsqcL1DZL+SHGdhktob9S00FRdmc=;
        b=dVCaftf9giJzEnaIa23u6yZt+9i1z8UU/GL6Dzo2pwIhcWLNybl7RrNeyX14CQRY39
         XLkXvR5sZuX6dD3UO5bXv3UeLP1cFTVbRS+SYm39Z4pvXsJthE3XW02UM8MN5jKEONhd
         F6oCDuGLxiB8AQ2P6PFd873sI1h3TYVJJ2NrosHHpu1fL4MyGcs/YyiH1h3QRsiO5hnt
         XmNEWbuPMocLes+yJjseu1YfFnqFcKXCGGMZjBeWXmtMWVe6wckocPMMP54EiF062qqs
         Nye7P3Kh2zk6WM+xoVWY4TYuDiffIRt7ZCFFQM/ZMAhdYVju/Nk6t+OF1ILT98rESEc2
         6W2A==
X-Forwarded-Encrypted: i=1; AJvYcCXWOoc9xi/3Dmi0aX/b1Yc1p7QIRUOkgi7udCbX3qwKQBo4oyVf0sUt1g4w3IoSVGeSZrg5vOkiAgtrXXwan67YXB2DUwflHE7lWW1nZjDTwbVz+ZqDPNEJVR+kLB6fR9KFcra/UJrdCXOjPTgL+0sx73yOCA7JHm6j8472c4IGiQ==
X-Gm-Message-State: AOJu0YydkY5cgVPUCwKeYae5NvRJ/CNOXG2qCO36sY5waYjtKEAR5wVY
	FM9Dgg3jdX+4OW6IpxAgPdBS2edKCxfU651w/2KHPhnYOiw6yApQ
X-Google-Smtp-Source: AGHT+IEohCwW1gdUhHQ+HBsjrH8e2X3IGAvkp7NbycEOs16kUhC+glys47qLNrfAVIC+ZfFra+qU8Q==
X-Received: by 2002:a19:3846:0:b0:513:3e1a:75af with SMTP id d6-20020a193846000000b005133e1a75afmr843373lfj.16.1709635438124;
        Tue, 05 Mar 2024 02:43:58 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a444526962asm5803196ejc.128.2024.03.05.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:43:57 -0800 (PST)
Message-ID: <c2be9a4cbbe6946e2f98a69d915c22bc52c9f1d9.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
	 <saravanak@google.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Tue, 05 Mar 2024 11:47:22 +0100
In-Reply-To: <20240305112708.56869e4c@bootlin.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-3-herve.codina@bootlin.com>
	 <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
	 <20240304152202.GA222088-robh@kernel.org>
	 <20240304174933.7ad023f9@bootlin.com>
	 <CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
	 <2f497783da939f13d8c8faeab931cac0ef9c98eb.camel@gmail.com>
	 <20240305112708.56869e4c@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:27 +0100, Herve Codina wrote:
> Hi Nuno, Saravana, Rob,
>=20
> On Tue, 05 Mar 2024 08:36:45 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-03-04 at 22:47 -0800, Saravana Kannan wrote:
> > > On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Herve Codina <herve.codina@boo=
tlin.com>
> > > wrote:=C2=A0=20
> > > >=20
> > > > Hi Rob,
> > > >=20
> > > > On Mon, 4 Mar 2024 09:22:02 -0600
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >=20
> > > > ...
> > > > =C2=A0=20
> > > > > > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struc=
t
> > > > > > > overlay_changeset *ovcs)
> > > > > > > =C2=A0{
> > > > > > > =C2=A0 int i;
> > > > > > >=20
> > > > > > > + /*
> > > > > > > +=C2=A0 * Wait for any ongoing device link removals before re=
moving
> > > > > > > some of
> > > > > > > +=C2=A0 * nodes. Drop the global lock while waiting
> > > > > > > +=C2=A0 */
> > > > > > > + mutex_unlock(&of_mutex);
> > > > > > > + device_link_wait_removal();
> > > > > > > + mutex_lock(&of_mutex);=C2=A0=20
> > > > > >=20
> > > > > > I'm still not convinced we need to drop the lock. What happens =
if
> > > > > > someone else
> > > > > > grabs the lock while we are in device_link_wait_removal()? Can =
we
> > > > > > guarantee that
> > > > > > we can't screw things badly?=C2=A0=20
> > > > >=20
> > > > > It is also just ugly because it's the callers of
> > > > > free_overlay_changeset() that hold the lock and now we're releasi=
ng it
> > > > > behind their back.
> > > > >=20
> > > > > As device_link_wait_removal() is called before we touch anything,
> > > > > can't
> > > > > it be called before we take the lock? And do we need to call it i=
f
> > > > > applying the overlay fails?=C2=A0=20
> > >=20
> > > Rob,
> > >=20
> > > This[1] scenario Luca reported seems like a reason for the
> > > device_link_wait_removal() to be where Herve put it. That example
> > > seems reasonable.
> > >=20
> > > [1] - https://lore.kernel.org/all/20231220181627.341e8789@booty/
> > > =C2=A0=20
> >=20
> > I'm still not totally convinced about that. Why not putting the check r=
ight
> > before checking the kref in __of_changeset_entry_destroy(). I'll contra=
dict
> > myself a bit because this is just theory but if we look at pci_stop_dev=
(),
> > which
> > AFAIU, could be reached from a sysfs write(), we have:
> >=20
> > device_release_driver(&dev->dev);
> > ...
> > of_pci_remove_node(dev);
> > 	of_changeset_revert(np->data);
> > 	of_changeset_destroy(np->data);
> >=20
> > So looking at the above we would hit the same issue if we flush the que=
ue in
> > free_overlay_changeset() - as the queue won't be flushed at all and we =
could
> > have devlink removal due to device_release_driver(). Right?
> >=20
> > Again, completely theoretical but seems like a reasonable one plus I'm =
not
> > understanding the push against having the flush in
> > __of_changeset_entry_destroy(). Conceptually, it looks the best place t=
o me
> > but
> > I may be missing some issue in doing it there?
>=20
> Instead of having the wait called in __of_changeset_entry_destroy() and s=
o
> called in a loop. I could move this call in the __of_changeset_entry_dest=
roy()
> caller (without any of_mutex lock drop).
>=20

Oh, good catch! At this point all the devlinks removals (related to the
changeset) should have been queued so yes, we should only need to flush onc=
e.
=20
> So this will look like this:
> --- 8< ---
> void of_changeset_destroy(struct of_changeset *ocs)
> {
> 	struct of_changeset_entry *ce, *cen;
>=20
> 	device_link_wait_removal();
>=20
> 	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
> 		__of_changeset_entry_destroy(ce);
> }
> --- 8< ---
>=20
> I already tested on my system and it works correctly with
> device_link_wait_removal() only called from of_changeset_destroy()
> as proposed.
>=20
> Saravana, Nuno, Rob does it seems ok for you ?
>=20

It looks good to me...

- Nuno S=C3=A1
>=20


