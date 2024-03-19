Return-Path: <linux-kernel+bounces-107503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF087FD64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE40B223F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA607F7C1;
	Tue, 19 Mar 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F02muasM"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42ED7EF1C;
	Tue, 19 Mar 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850364; cv=none; b=pnK2UT3ZwTmbJmdj0XPKmOdHmSu9quyrxfpR1yA1kecNmsSVL8+kZ5CmTR+BC0bFXHHaDaaO0JelRkOkw4ewEkUk+mJlxAEdZ87Su9SDTMtTDEm4GM6Z7aCCpgQECYpvAbdiGDyUwmDsuN1cVRG51kXDyNNVbCmYSb66hmqyGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850364; c=relaxed/simple;
	bh=czGExUm0Q+tTwI/oKFl4wc7Gw2rZFQVWLA/z3hJt3iU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YV7Fg3vX3cqqA2JUgu+VR6psZ/QfsJry+slLIPD3Q9yLIKp3nnT+XZD5FdrSmibLzE3AYXYx0XXlxtXuHefGG3iQ8kwBrO1lkWVQKOhlgZkrxkoWNyxQjmgaBtLczsLuM5nwARtQc5RVDnyULclj5DgcN5jqJ2U8eVIKVxUEmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F02muasM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=czGExUm0Q+tTwI/oKFl4wc7Gw2rZFQVWLA/z3hJt3iU=;
	t=1710850360; x=1712059960; b=F02muasMMkcZERr0OHDIWRhFNUoVeE1mY4l29BXyMwfmuDJ
	c8UTtFevh5/2nrwm3P0Gtj2BRks7RJT/SmYnSYiHbjcn85LwdoPBusoe6pxm2biDFEDRZR0p8UaBc
	GZNoZ+y4+ZndS6jaQ05E7dXs0Nj2KpxCAW1CjPENcc5Pu7M2LpEPqeo08gcxkf9j3yWER0XFzLABG
	g4ZaPIus//dfWDpAj2RKQU9taLZTwdsfW66QLnIRXW/UqoJMtTdbnd4ndcGc3YoCbENcDMcHM8/yK
	5xGYBLnuWgA9tkGe3z5OXUZMxjBKM1zxS+3vaEW+HfYOFiNJhvEKWNaaoYaq3t/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rmYKV-00000005deo-2fEz;
	Tue, 19 Mar 2024 13:12:31 +0100
Message-ID: <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	 <francesco@dolcini.it>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
	tsung-hsien.hsieh@nxp.com, rafael.beims@toradex.com, Francesco Dolcini
	 <francesco.dolcini@toradex.com>
Date: Tue, 19 Mar 2024 13:12:30 +0100
In-Reply-To: <ZfTspRKFgrO9xCTH@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
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

On Fri, 2024-03-15 at 17:49 -0700, Brian Norris wrote:
>=20
> Now that I've looked a bit closer today: I'm realizing this may(?) be
> one of the first "full MAC" drivers trying to implement its own MLME --
> or at least, the auth/assoc bits.

Hmm, yeah, why _is_ that? mwifiex was originally "sold" as a "full MAC"
driver, i.e. doing things in the firmware.

We've said that "soft MAC" drivers should be using mac80211, but this
thing can't seem to decide?

Also decl.h should probably _shrink_ rather than grow, a number of
things just replicate ieee80211.h (such as MWIFIEX_MGMT_HEADER_LEN
really is just sizeof(ieee80211_mgmt) or so? Not quite correctly.)

So yeah, agree with Brian, not only would this be the first, but it's
also something we don't really _want_. All other drivers that want stuff
like this are stuck in staging ...

So why is this needed for a supposedly "firmware does it all" driver,
and why can it not be integrated with mac80211 if it's no longer
"firmware does it all"?

johannes


