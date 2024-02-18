Return-Path: <linux-kernel+bounces-70432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC948597A8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA30B20C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F346D1BE;
	Sun, 18 Feb 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXRhXdkN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKS1tbyq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22A56B82;
	Sun, 18 Feb 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708270812; cv=none; b=RtI6kQdZ7zoAHw3dg44Ck5vC1yAxlKNFXA6TtNLWcIqrs0MXoJqsMwmy2pq5DvvgIijCM8wXNeLUgryGbPiL4z9ajeZfecNJY0PPATNWdySDB7/+4Y699kxCxCm0dit6LFG3Z1SFnL4P1U+mVVbKiC8u8rciKbPHA8Obq0IjIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708270812; c=relaxed/simple;
	bh=6rUpqX4bUrq80t7K1JngTnzTStgOb4lJQguGBluapJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vF2QwG+BNyW1C+rsf7/po+EXAHc6CCQrcparAS7ehukvKZ83M+Haweewc2qPupdLfM+B56mqbdrVyGOwXEwhvwvr2EitohwbGEisC1SevqVmjDmPjmitS04BfO78+re6ICYPnXQBbdXyTHaom37VvhIeorbyszR+FnePQknzgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXRhXdkN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKS1tbyq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708270805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEJif3hMj92kb73ceaBTohocvuUtcBAZTK7BGKOZE+Q=;
	b=lXRhXdkNdX+ISAqP2fFGBkuHzVWodImWzUguCT8cle1stmPgXETAOQYQyGh0kJsfbdVZlH
	lP5umO5oA48ugDMs54GKgfUQ8rj+gJ6Wn4tqCvewsvNY2p04fJm3S4fbK3Mal/rqL9POof
	/W0uQ8HUehEETD+zCL66+fWZAwmW2KXZzY7S1/8gFeUH1C3cz8vo/NOhBNhuMVzUgeGcaB
	vOaxK6Pfwy15tPB8MDNvtNuheqMIAAwFzsFJtN0Kh/ggThzy498k0xZT0qhArITDZ1kBbO
	chbcpG8ou749DBAoj1OkKZBvEH4tYO06y2Bbl73GLsDSpoq1TleMvx1Ftn9YUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708270805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEJif3hMj92kb73ceaBTohocvuUtcBAZTK7BGKOZE+Q=;
	b=YKS1tbyq22HqyyPxlEs22q4Kv+dF6I+VqD5o5wqbJhV903xAPd2nf8NeyryEr09JsIxLak
	Nxz6OGQ6PbMfdJDA==
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: sasha.neftin@intel.com, richardcochran@gmail.com,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [iwl-net v1 1/2] igc: Fix missing time sync events
In-Reply-To: <20240217010455.58258-2-vinicius.gomes@intel.com>
References: <20240217010455.58258-1-vinicius.gomes@intel.com>
 <20240217010455.58258-2-vinicius.gomes@intel.com>
Date: Sun, 18 Feb 2024 16:40:03 +0100
Message-ID: <87y1bhok6k.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Fri Feb 16 2024, Vinicius Costa Gomes wrote:
> Fix "double" clearing of interrupts, which can cause external events
> or timestamps to be missed.
>
> The IGC_TSIRC Time Sync Interrupt Cause register can be cleared in two
> ways, by either reading it or by writing '1' into the specific cause
> bit. This is documented in section 8.16.1.
>
> The following flow was used:
>  1. read IGC_TSIRC into 'tsicr';
>  2. handle the interrupts present in 'tsirc' and mark them in 'ack';
>  3. write 'ack' into IGC_TSICR;
>
> As both (1) and (3) will clear the interrupt cause, if an interrupt
> happens between (1) and (3) it will be ignored, causing events to be
> missed.
>
> Remove the extra clear in (3).
>
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

No obvious issues found while testing.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXSJNMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgqkID/9avd4FGLjcAGfKe3PWGU1PuFudMwS2
Vz9yhldxyFlslH+r+ZfuTj4M86zxqisARzwRUMJnYeTL9cMsvNeJawndgmj4C95G
eivrJ5Rb8hq7E3+9GYUa83MJSI6o10fl6/ITV2Aj2aia/tayNO+BE2OjedzCScRi
b3euEN2EmD6kknJNSXj4aPMew4ZJHAjBxZBC6O1uHCGA8W17TVi/MsGUn0j4wmZj
WcaLhjHVS+hWB+1GPDIc/zJiwb8/ngz5XMJEEd00CLqaSSyVxpJN3K6Vlh8DlSoJ
SFw6m341bWupluxys8jNO6dV7cejuRMZER11EjY8FeU2BJzclnHDGGikLEvy9JEn
fQyfuOx/9WlQmHS1paP4Tddq+vqOEn0rrHKrAxuKPn5kE4Opy2RNgLfTzsolKGMb
zv5LPKqV17VdY5kx+6nh3/Ii2OksoyR/7BUquc+X0A33DE3sBfNe1TuYHpQ0PAqR
soq9P0JH8GWySm69txSje5I2kcCVcrHIZPw6lXoRuFxhzUi9h/NCGMuRHYvt8fdo
ll0lb2nB2DO2tRhhijN4ZvHPMtkAse5BLMNN6y6qzinOnt70VmSOi4uk5W2/lBQ/
vkeT8pnbvLNxpSkx94tKDuFwgOBVScgzLXYCgav+5GWn9dSAFBVXJUWdlQak7gDO
EtiRovM4mz0W/Q==
=qF6P
-----END PGP SIGNATURE-----
--=-=-=--

