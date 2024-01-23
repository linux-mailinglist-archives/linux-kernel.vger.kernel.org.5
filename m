Return-Path: <linux-kernel+bounces-35132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF37838CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B841FB23AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D05C90B;
	Tue, 23 Jan 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v4ZjgPin"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446EC5A117;
	Tue, 23 Jan 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007273; cv=none; b=UMED0ri3TOXGFxzTAWpQCSNunxIibxwL1uiJ77AHi6j0fci4+elCPvOa8o2eRCViZx1rRWDAN3X9Y4zRwQjSYKaQ9zM0NmvCTqeKUKoYgllAzlvYr1j8srRV5BhBR37QlSOQoEziFKgl1QqSNWcIG5rofJVpTx76LBgjomWFIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007273; c=relaxed/simple;
	bh=9fuGklmKHGIDBITeyJhohHRwWbW9LwpJhkLb3dVONxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLKyxnV0kZOaeoIA+lHL53vd9RtGdvDMObRleXmE+yOxq57ehsklNGkFTk2I+BvgTtRdRu8SMqT5pypLjMltcC74c0OAJQBhjJprRnj8fFcnQ3/guPs8bje8CW6JKi+omFBCmYiakkMoPtmQg3RBUOB1j1GLEXKjm7lA3MGkm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v4ZjgPin; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9fuGklmKHGIDBITeyJhohHRwWbW9LwpJhkLb3dVONxM=;
	t=1706007271; x=1707216871; b=v4ZjgPinhwrRyURSMgJVKHTjzCOZnqNL423q5JFPbsvp2X7
	3eAdCKfv9YB7Vt5W1l9dgR9OHK064sm2b9ubOgS77gisPpU52UbWqkPljIs6VTgVMLpCB2tRlGgSz
	JIPzLh4bw1UF8FHTTXQurCuaAhZe8sRl1AzJiXPhfrcHL/+Y5guPIL1ObNCBd0/c9ln1NGzho3Smr
	/ZuexTJbf+9GguaVcgwzhywn/OEL5njll1XkFcQz9eYS2R2o/dNQuZOU4HvoqaQmGxVA/sEw64NdP
	J56aYmO7tWVorOD/xV8wSptfL3PUCrO8zQRvbMD36Ml6O/nB9T8u+E+GfiUhmm8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSEPp-0000000EyuD-23sF;
	Tue, 23 Jan 2024 11:54:01 +0100
Message-ID: <c0fd30e8e6d175eab50d7d5212117107e5251e4d.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] kernel-doc: Remove deprecated kernel-doc option
 'functions'
From: Johannes Berg <johannes@sipsolutions.net>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, Mike Rapoport <rppt@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
 Shuah Khan <shuah@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,  Dipen Patel
 <dipenp@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 linux-kernel@vger.kernel.org
Date: Tue, 23 Jan 2024 11:53:59 +0100
In-Reply-To: <20240122132820.46633-1-anna-maria@linutronix.de>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-01-22 at 14:28 +0100, Anna-Maria Behnsen wrote:

> the kernel-doc option 'functions' is marked deprecated and is simply an
> alias for 'identifiers'

Is it actually a good idea though that it's deprecated and an alias?

I mean, we have a problem today that sphinx/kernel-doc/whatever cannot
deal with having both

 - struct cfg80211_rx_assoc_resp
 - cfg80211_rx_assoc_resp()

I think at some point I found there's some kind of ticket open against
that, and while I don't hope it will be fixed soon (and we renamed that
struct because of it), maybe doing these changes will make it harder to
eventually deal with such a thing?

johannes

