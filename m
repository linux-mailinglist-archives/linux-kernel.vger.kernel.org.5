Return-Path: <linux-kernel+bounces-97964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FAE87726B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466211F21BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E922F00;
	Sat,  9 Mar 2024 17:15:00 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E015B1;
	Sat,  9 Mar 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004499; cv=none; b=fXPPL9Scb0NOMDLmVE6mBkRS/mw0M7jUamLVQhiW/enJJWrGBPP1GHf8o+3pr/aQ2rTjWkTIgBF4mwclde8Gh8FPXdPI8L+XPzEK/ayNEwQlyqoMbXHaVPs5jMjchLw/kBkvESxObpyALvOdLTYikywohlTtO3Dw3QdQhwhfVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004499; c=relaxed/simple;
	bh=arDQvDyK7md1Fb8Q4rngcsTKX5H+otUlJid5ZPYEJkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpgDEDVNpTPzAKeov0rTaFl0++X4E5Zaptvky3VakQLxWiDxuz0tVk/FD1a9HhafgjM+igGQVRKzXEJJjIeCqm8I307++R38zqTMyEV8UKoTPx0seYEh9CezoQHSf9RAAHikCCb6GFHiIaXxsKvwKbHhGYQuMzeLoPz4NNymmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2A31C120B7C;
	Sat,  9 Mar 2024 17:14:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id DFCD320027;
	Sat,  9 Mar 2024 17:14:51 +0000 (UTC)
Message-ID: <eeabbfd72b3c3a354838e889ee6602774e67cbef.camel@perches.com>
Subject: Re: [PATCH net-next v2 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
From: Joe Perches <joe@perches.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
  Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,  Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Simon
 Horman <horms@kernel.org>,  kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Sat, 09 Mar 2024 09:14:50 -0800
In-Reply-To: <20240309090931.16d8d58a@hermes.local>
References: <20240308104725.2550469-1-o.rempel@pengutronix.de>
	 <4f38500b4d798ad8effd59fef41353439f76fec3.camel@perches.com>
	 <20240309090931.16d8d58a@hermes.local>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DFCD320027
X-Stat-Signature: hqp6zgkq4ewyg6n851mrjr1rxn15533k
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+qWDvD5DA3oWCVK+ewd/j4pO/UV1ZSfMY=
X-HE-Tag: 1710004491-813056
X-HE-Meta: U2FsdGVkX1+y1UweAg9/CqOgeya4f02D/elRycsl7yRGht3OCGiW7fdc9B+uywvbqd+Xgpd2h8UbokKkrVN0PAQhQJYY+8yv6JztEoTPN+RKYDMEyyC/D3wYHBiSHvB+1gaDJ+Rq/UUvpqtRD02fIQld8DmyrYoAcF0kkJYLc+xXB9Mcfq2OKhYQqVjKSIl2LJ3JQbDXiX0iLUt9RTpgoP5nkUgaBaGvGszL4I1xakjKEhE7JB88n0K0ARQ2Uc09wfQnDSooixS+pCs9WXo4xvLl4YcIFuKZY3UFF5JQlCQVlD6zs4xFF9MNa7beBPiD59+qxCsj5o0mCPN8tsBVrhCgMjyEHxIk4/nGzmKEtecPriHz2a9tyZYQ6sPA4DJm

On Sat, 2024-03-09 at 09:09 -0800, Stephen Hemminger wrote:
> On Sat, 09 Mar 2024 06:26:28 -0800
> Joe Perches <joe@perches.com> wrote:
>=20
> > > +		problem =3D "Attempted operation is undefined, indicating a "
> > > +			  "possible programming error.\n"; =20
> >=20
> > My preference would be to write
> > 		problem =3D "Attempted operation is undefined indicating a possible p=
rogramming error\n";
>=20
> ETOOWORDY.
> Be concise please.
> 		problem =3D "Operations is undefined\n";
>=20

Concision is good, plurality matching is too.

