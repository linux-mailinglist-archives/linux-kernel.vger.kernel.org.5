Return-Path: <linux-kernel+bounces-155151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F058AE5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09472281944
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF9484A2E;
	Tue, 23 Apr 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BbXKUfsv"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AFE576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874929; cv=none; b=Q/tbjfASh+euWdTqf/wZ5juK7MofouH1m/brjzLET0Gu3gH7PWgl3K3eHnJxeuu6OycurHBUrT8OZFfCOBw3nTeAEapF/UBAKGopfvLBZuBZeiAOwAloJWeGcWtATGvDahOid8OhZQ7e5/xjXeEzxHhif7oPce/s7qdkdwWUfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874929; c=relaxed/simple;
	bh=QfxAecxSklFDaQtgLbxplA0r+fnYSsdh2xRpjUn6uy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4kHtcs/uG39CvwHeaZBhhSys5B4THZ8MvIJZc0kt/hXS8vKqRgn4CuktUuurdhhMt2GMb/M/Y5j7ZV+GNMm5PCoy7367NsCJ7Zg5rJAjDKrrHUeKy4qr8bbJ8XrAKAG3AEGPwWCYojU/ObB4DfMpc5lYWAC7qIOrl8LxfgZuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BbXKUfsv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sOweXI35fJEX7TaL1KY6lKJ4Ci7OIE04l9EyjKhOXZM=;
	t=1713874926; x=1715084526; b=BbXKUfsvSBzlUUgK0cRUmlPFc5e4GS84pcJ4UsYW4/pdLR7
	dk+PWBs9B/VrqIFN6hYhhsoCD4rAN6G47BwYTiaDLtkQoadaBtm4aGz0z2vxsXKh6q/qhFfECtNw/
	p0xbf7a/pD4h+vHBMAZ4aMtVDmyLuEvRxHsuJLTjItK2AghyzTHzk8C7CfxcSWGCYR3oU4DslUpnq
	TPTDY2IH0IttIC1K55HY9tlY7NbKwrbe62cOX5fk/hH5kJd8IKKIpb9GyAs+nxHsufLSzVkmxCP0J
	hk9jYz+YL6y6gYXG0lI/VbFUQU02jvEJXKLQ6zSirs2id5OHlWl+aywmyJ6HaHAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzF9t-000000027hu-3mGu;
	Tue, 23 Apr 2024 14:22:02 +0200
Message-ID: <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user
 code
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 14:22:00 +0200
In-Reply-To: <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
	 <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
	 <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-04-23 at 20:09 +0800, Tiwei Bie wrote:
> On 4/23/24 7:30 PM, Johannes Berg wrote:
> > On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
> > >=20
> > >  $(USER_OBJS:.o=3D.%): \
> > > -	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/i=
nclude/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
> > > +	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/i=
nclude/linux/kern_levels.h \
> > > +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(=
CFLAGS_$(basetarget).o)
> > >=20
> >=20
> > Why not just include it explicitly?
>=20
> I think it might be more convenient if we include it implicitly,
> especially since there are two levels of directories under os-Linux/.
> But I don't have a strong opinion on this. I'm also willing to
> include it explicitly.

Yeah, ok, dunno.

> > We do have the warnings?
>=20
> Yeah. Without this patch, I can get below warnings with `make ARCH=3Dum d=
efconfig && make ARCH=3Dum`:
>=20

Sure. I meant, we don't need to hide the include, if we need to add it
to some other file, we'll have the warnings as a reminder. :)

I don't think anyone today would write the code as it is now ...

johannes

