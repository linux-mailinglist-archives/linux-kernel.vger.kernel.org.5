Return-Path: <linux-kernel+bounces-57747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0484DCF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D4F1F2654E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683856F519;
	Thu,  8 Feb 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S98ifgzx"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317366F089;
	Thu,  8 Feb 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384504; cv=none; b=SvgtrgBMwZ+3X7Ko2aG3FbEVVlZhQ1nwjfnEHFhGMu/dn+q0jn2GRS4+YwH1ks2NwqX5DDxBiYDOR1VFYAJIib70WZEB88+u9UoB3/6zh89D2vKWU9p8Z/Xti3tt250Rl2l4Yvh77nO3WpVauL1VndB1fxwy9TYV8a7r2KKQ790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384504; c=relaxed/simple;
	bh=Wb4JGwKLfWWPG7DIhiiVPbRr/kNqSr22iA1W+mVC3bo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGlMHU13YawMyS8fA1RKz908TfdJuOc1AhhnezZOn8022FoPFFLSqI47Mw7FvdoGYpuU6cAa2vDmBgl2Q4rSxlQYQXguSExwat+4HRQXivVcU2utyxetiuJWQDxLhyT4+l3lE5YHF5U7PDXI90cGB1D7aUumz7CPDr3mgfs+QeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S98ifgzx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wb4JGwKLfWWPG7DIhiiVPbRr/kNqSr22iA1W+mVC3bo=;
	t=1707384501; x=1708594101; b=S98ifgzxISSGX11wlc3vXWCP9jT8sNW0qsgls8ui29E6ujy
	ETlys9p03XXMnBkOkmiHSjNcz5vU8oKQ2EeB0H2pD6DdRjFv/t9U5KNK6lCq8uZ/ZrPV1dRJAblR8
	4POQhZj44oJktDbAs40J+6OvUUr5Cf/SQW74J/pioONJdam/pTkclUu6wx+TCzmMjLn4dpR1/zIwJ
	pFDKxFvuYq8NTDiSkfZviRWPv7PmtbfyHFYyetKi+DeEkRXAxDKkvnpO3VQRdW4ux+D3SemWZBTvP
	5nkngHZFQlECXm1b3isU3VCTPLKpexEtjO3NtxUJJgOAO66PbLYHgLNhufUpveDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY0hW-0000000HJC4-0f6e;
	Thu, 08 Feb 2024 10:28:10 +0100
Message-ID: <9e740b50d7798b5d01c0a3c9e328ccf90978d30c.camel@sipsolutions.net>
Subject: Re: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
  Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Date: Thu, 08 Feb 2024 10:28:09 +0100
In-Reply-To: <875xyzh4ah.fsf@kernel.org>
References: <1892445.tdWV9SEqCh@kreacher> <875xyzh4ah.fsf@kernel.org>
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

On Thu, 2024-02-08 at 08:13 +0200, Kalle Valo wrote:
> >=20
> > If possible, I'd like to route the $subject series through the thermal =
tree,
> > it is requisite for the above one.
>=20
> iwlwifi is getting a lot of patches lately, though I don't know if any
> of them touch the thermal stuff. But if this patchset goes to the
> thermal I am a bit worried about conflicts.

Should be OK, I checked now and apart from the trivial change in mvm.h
this is contained in tt.c, which isn't touched (even in our internal
feeder tree) after commit 0106cce5ad0c ("wifi: iwlwifi: mvm: drop NULL
pointer check in iwl_mvm_tzone_set_trip_temp()").

But I'll let Miri send an Acked-by to go through your tree, since she's
the maintainer :-)

johannes

