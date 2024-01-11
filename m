Return-Path: <linux-kernel+bounces-24112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33682B740
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A43E1F250AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427712E4B;
	Thu, 11 Jan 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Yl/h6qon";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ksNAdE+0"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A484FBF3;
	Thu, 11 Jan 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705013226;
	bh=9WAr7c4kgfmq52d/ewPgk5MVWR5LQuNK5v1qLLaXob4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Yl/h6qonNxWgmWAcdpn/zbVaC1/+H2lgsBqymddTbTkm/zWMWkwpjMIHS8yix2Abu
	 bwWE47MOQlkkO9lrw+Fyf4KAQVrUzzQZK7IkfKVV6fRif7RUZf/N6x9w+y+IRzJASf
	 AFC6QopQSqVApdGfiSeWkU8ZLV3TSgTJtmXc21is=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2BA7112808E8;
	Thu, 11 Jan 2024 17:47:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id r0fszx2ltciG; Thu, 11 Jan 2024 17:47:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705013225;
	bh=9WAr7c4kgfmq52d/ewPgk5MVWR5LQuNK5v1qLLaXob4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ksNAdE+0z5qrNA6I/vFeNBDkwLd/9wqI8QphWcv6n6B2Tf1wBQc8SjrkTtV7unRdd
	 8WSCtr0oGY3aG/8hzi6qFcMBcEgZ3HuoqssnmtyzjUbpk9tiG/wg/Tz5fXuk5hKIQz
	 Fl6xNTh4Sxbl3Al2bNXaf3megb3pD4E7395jJfIg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6049112806BE;
	Thu, 11 Jan 2024 17:47:05 -0500 (EST)
Message-ID: <3b5b650fa3c6ed6dc7f296eb7258c722a699147d.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 11 Jan 2024 17:47:02 -0500
In-Reply-To: <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
References: 
	<c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
	 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-01-11 at 14:36 -0800, Linus Torvalds wrote:
> On Wed, 10 Jan 2024 at 12:48, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-
> > misc
> 
> Ok, I note that this has been signed with ECDSA key
> E76040DB76CA3D176708F9AAE742C94CEE98AC85, and while it is currently
> available and up-to-date at kernel.org, it shows as
> 
>   sub   nistp256 2018-01-23 [S] [expires: 2024-01-16]
>         E76040DB76CA3D176708F9AAE742C94CEE98AC85
> 
> note that expiration date: it's three days in the future.
> 
> Can I please ask you for the umpteenth time to STOP DICKING AROUND
> WITH SHORT EXPIRATION DATES!
> 
> The pgp keyservers work *so* badly these days that refreshing keys is
> a joke. The whole expiration date thing has always been a bad joke,
> and only makes pgp an even worse UX than it already is (and damn,
> that's saying a lot - pgp is some nasty stuff).

Well, I did already tell you that I bypass the pgp keyservers because I
use a DNSSEC based DANE entry instead:

https://lore.kernel.org/all/1564171685.9950.14.camel@HansenPartnership.com/

And I'm sure there was an earlier one where you confirmed this worked,
but lore seems to be missing it.

> When you make a new key, or when you extend the expiration date, do
> it properly. Give ita lifetime that is a big fraction of a decade. Or
> two.
> 
> Because your keys constantly end up being expired, and they are
> making the experience of pulling from you a pain - because I actually
> *check* the keys.
> 
> Stop making a bad pgp experience even worse - for no reason and
> absolutely zero upside.

I can concede that if I'm the only person with a DANE updateable key
then it is a pain to remember because gpg doesn't automatically do it
(although it can be configured to), so I can certainly set a longer
expiry date.

James


