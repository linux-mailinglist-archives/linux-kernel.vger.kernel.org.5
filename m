Return-Path: <linux-kernel+bounces-63969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74488536F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FA628664B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B25FDCA;
	Tue, 13 Feb 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="miI7WoeS"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2055FB86;
	Tue, 13 Feb 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844452; cv=none; b=bkPbiXFeK+yz/2L4T/vmsjH7xOxJFQNKxRb6leu19tKQ9b59xU/k8t4vcWZ5o5jvgsxNCCErQ6DLPnvdiTrNmhcq3Id1XuVrX5w5b/oRxJ960dYbb/AifyySP3E0DsT6cgM3esi+aVpez1YIBBERlHSOSSIexEm5aJ/B+ZDemBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844452; c=relaxed/simple;
	bh=Gy7C4I6z7AT0zGaXz9VQounxugoEpPbmpJ5GMuEODFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnPyevWoV9ni+B9Iw2t0KEGJS+++AHIsMH3KfMbeRXtQT/Ekl1QTIb1e5oj2/4SN0bOtej0MzSstJf86hTE8bQuHNu1ym3o9VIJj/u/Sa9jS6/cCrEtbsKLvJtrYL/rj2z3l39H9wbfIeftLFYy+ygVm6rJMxD0gVBgEjpX94SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=miI7WoeS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Dmp6vyT5JrL+eTyZVDd+aIs2asoct4AJGRKHR/LXHLw=;
	t=1707844448; x=1709054048; b=miI7WoeSDg0kwq9yVr1KicLooEkI4mH9llUQ0P8EAjQxMTw
	nIv/hfn4UyiUkWEiak6B44A+l1nVSOq7hnEzznmRSg3JNZnAWQ19VCfsvFj26onwe5SvJAWhEzWFF
	5G5mIrn8EScPYg/MyYZ5KTFfKdpEnfhdLhbtAqWtKas81D6W47MJHvnR9tJNEFNdi2Ew3e4065D65
	lNc5AxAqjJmKPoT0z5Z6vNELiyOhUvv9RLf+VLc/O0Xe/mdQkt3TGKB4ee3iNpc0xg/jFdopdbE9M
	id+ZIDAzJNgewK81062AEcIwis9dypwbzxrYVkj92is3FQOQFTSt6ivO2zB21k9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZwM2-00000007rTN-1xmS;
	Tue, 13 Feb 2024 18:13:58 +0100
Message-ID: <82e78ebf5f84314e3fc1e6b8b1a76f948c9aeb22.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the pm
 tree
From: Johannes Berg <johannes@sipsolutions.net>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Stephen Rothwell
	 <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>, Wireless
	 <linux-wireless@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 18:13:57 +0100
In-Reply-To: <e15b25c2-2ced-4f79-b541-61980a31f947@intel.com>
References: <20240213110852.51524899@canb.auug.org.au>
	 <4044e07e87af766f643f89f839b332973819e048.camel@sipsolutions.net>
	 <e15b25c2-2ced-4f79-b541-61980a31f947@intel.com>
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

On Tue, 2024-02-13 at 18:03 +0100, Wysocki, Rafael J wrote:
> > >=20
> > >    2e171a57c312 ("iwlwifi: mvm: Drop unused fw_trips_index[] from iwl=
_mvm_thermal_device")
> > >=20
> > > from the pm tree

> > I guess we'll have to live with this conflict, unless Rafael you have a
> > feature branch for this I could pull in and resolve?
>=20
> Well, not yet, but I can add one if that helps.
>=20

Well if you have a branch that has the above commit and not too much
else, then I could pull it into wireless ... but chances are the common
base that we have is divergent enough that'd pull a whole bunch of other
things into the tree so that'd not be great.

Pretty sure even if the conflict survives to the end Linus could figure
it out? :)

johannes

