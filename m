Return-Path: <linux-kernel+bounces-8960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7281BE87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486F51C23010
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F36518A;
	Thu, 21 Dec 2023 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g+fGhbfg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D064AA0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WoXHIo/jfntcprqU+dpG7UpTPTeb3KW7V8bWH6zsf9o=;
	t=1703184918; x=1704394518; b=g+fGhbfgz5qb/271HOQvEKAQOxUYJ1xiRCGawAIiwAozNf2
	gpS9MiiNsnU13Tge3Sr3QxyXYm5w32dr6T0Q6ve0HN6NhPj1IX1xXHvh++ilMph7AicvxkOvTEP3F
	D5q1brhKitwZquVZf2NO6RcUMvYiYvTVpjLp+NrtjrJTA+mTL5/GZzWtXhnmbB1BrLgBfhugdzsCF
	t1xRsKbsJlSYMyB+6c/1oSukSDr2qnAJp4i+7UqcZJbC8lZjQR3LPnETA5V/UM1NDSLC6ntQEIYPk
	0iPbTIDzfUt4dmlE6gH4g0HZ4quxyufqOdwcyImnaWMdre+jN6FFTJVcpAGN0bJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGOCQ-000000033XD-0uxt;
	Thu, 21 Dec 2023 19:55:14 +0100
Message-ID: <2d760360e1f47783166365110f8473fadfbc80a3.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: initialize cancellations earlier
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Tetsuo Handa
	 <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, 21 Dec 2023 19:55:13 +0100
In-Reply-To: <2023122129-distress-sanding-8449@gregkh>
References: 
	<20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
	 <2023122129-seclusion-qualm-3084@gregkh>
	 <4b2fbac42345acb21ac2bdfe6abd4fb4a00bb8c6.camel@sipsolutions.net>
	 <2023122129-distress-sanding-8449@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-21 at 18:17 +0100, Greg Kroah-Hartman wrote:
>=20
> But this doesn't apply against Linus's tree,=C2=A0

Hmm. It does for me?

$ git checkout linux/master
...
$ curl -s https://lore.kernel.org/lkml/20231221150444.1e47a0377f80.If7e8ba7=
21ba2956f12c6e8405e7d61e154aa7ae7@changeid/raw | git am -
Applying: debugfs: initialize cancellations earlier
$=20

> or my driver-core-next branch now,

Right, it doesn't apply there, that was branched out from v6.7-rc3.

> where should it go?

I think/hope to 6.7 still, since it fixes something that only got there.

Looks like you routed that other debugfs patch (the lockdep revert I was
talking about) through char-misc?

johannes

