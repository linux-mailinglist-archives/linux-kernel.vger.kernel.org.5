Return-Path: <linux-kernel+bounces-74152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6F85D086
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2814286D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0479282E3;
	Wed, 21 Feb 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MiMaUeQs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAB3C1D;
	Wed, 21 Feb 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497415; cv=none; b=MDt2tuv5gNCBLiV9897OpUyNnRWaa8RE74rD1ZkiyrBp9ZiY80eF4QtdnZGD8vLnVtNC63Q14b/d8B14XIcw2CEDuZ+Z6JsnUuUc6Eh2iv0B/dBpwFuR3l9no7lGmZfDgzsWgbMp4gfPTt/qbgICRC3F8qN2QeWM3vWO+a4NXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497415; c=relaxed/simple;
	bh=qDF44gt3Fq/BNLOvTiOwHcFefken+2uuLlwPGYuZscE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BTJ5rAFNYQx7Wlo4vCmIAbocxS7nB3SkZQNZJ+69k4SZLtzr5fq523R3VPhLZ4wbTM8XaeYM9UIM20azylOMiph7nngQbGN06wfZSjOgAuHrcfLjXDBYEu6FlXjAMnHd1KPfs6HkVD62yVR4fm9oMUSw5wMZMO8aisZjdvWkY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MiMaUeQs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708497407;
	bh=+82uQoLkceRgKbxGlEkXq+B7W0mzbgQAW4yN2l9aHw4=;
	h=Date:From:To:Cc:Subject:From;
	b=MiMaUeQsp9E9H/tv31GHjliJYGJLM/oBIxDwcW8kkdH7pJDMANjVwrUBdhKbMmFTY
	 dTKcPmO+o2wfdw2wGwo2aPSGjZVjhmYUYValnBenklUpj/sXjDOSRyf1rpwTZHwFWY
	 pxd4G0ys0uRTcIUcMPINupyr/RrpDXeG2/kAm4SF+jMgR6JGm7J7ZIrGycaEFFu4Ex
	 +5MWjA2FSRDCr6uc/EtIkiJu7xgdwaPrYBY2rjHibnNnA7cNmN/Kt527WFncG9srYt
	 FI4z/Po/TBUmBHInhQe+JfP8X3x61BfjE0AvteTL+M6dgLt9/NucH1IAI59OWJL86R
	 XvUfNpwfUm5GA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfmlM27wwz4wby;
	Wed, 21 Feb 2024 17:36:47 +1100 (AEDT)
Date: Wed, 21 Feb 2024 17:36:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the drm-xe tree
Message-ID: <20240221173645.225a979d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mzEsM7U0WXpWoo+ElKPohiw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mzEsM7U0WXpWoo+ElKPohiw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  ddc3c0877e16 ("drm/xe: Use kstrdup while creating snapshot")
  fe761f3465c0 ("drm/i915: don't make assumptions about intel_wakeref_t typ=
e")
  0eb16fd26795 ("drm/xe/guc: Use FAST_REQUEST for non-blocking H2G messages=
")
  c5be725eb09d ("drm/xe/xelpg: Extend Wa_14019877138 for Graphics 12.70/71")
  6e2546131750 ("drm/xe/kunit: Add GuC Doorbells Manager tests")
  90ad6f301789 ("drm/xe/kunit: Enable CONFIG_LOCKDEP in tests")
  29d52c9c1b9d ("drm/xe/kunit: Use xe kunit helper in WA test")
  d8ba1ede4cbd ("drm/xe/kunit: Use xe kunit helper in RTP test")
  0b75475723b1 ("drm/xe/kunit: Restore test->priv when done with fake xe de=
vice")
  5095d13d758b ("drm/xe/kunit: Define helper functions to allocate fake xe =
device")
  4ceb8645bd85 ("drm/xe/kunit: Set SR-IOV mode of the fake device")
  587c73343ac7 ("drm/xe: Introduce GuC Doorbells Manager")
  e8b9b3097ca8 ("drm/xe: Report TLB timeout using GT oriented functions")
  b2e1f97fb418 ("drm/xe: Add GT oriented drm_printers")
  b130289b2324 ("drm/xe/vf: Add VF specific interrupt handler")
  aef4eb7c7dec ("drm/xe/vf: Setup memory based interrupts in GuC")
  9a30b04f15f0 ("drm/xe/vf: Update LRC with memory based interrupts data")
  a6581ebe7685 ("drm/xe/vf: Introduce Memory Based Interrupts Handler")
  f15de1936f8d ("drm/xe: Add XE_BO_NEEDS_UC flag to force UC mode instead W=
B")
  35c933f68048 ("drm/xe: Define IRQ offsets used by HW engines")
  7158a688935c ("drm/xe: Update definition of GT_INTR_DW")
  e3408839dd27 ("drm/xe: Update LRC context layout definitions")
  54020e2b406d ("drm/xe: Define registers used by memory based irq processi=
ng")
  6901f732691f ("drm/xe: Add command MI_LOAD_REGISTER_MEM")
  4e124151fcfc ("drm/xe/dg2: Drop pre-production workarounds")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/mzEsM7U0WXpWoo+ElKPohiw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVmf0ACgkQAVBC80lX
0GwfKwf+Ocv32KpR8cKprl1bmr0CmsvgqK8QqmR9dp8zmPkKyUhRBFZmJT3Ni6Ju
HQF7CkzoZvcvbdlGGIfykrheBfSTSaCLlTPN6nw1uk7y96+sfdH+OfTZBqRj580f
wD4q9eZG+EZRN6YB6aqbsEWTA2Fi5ZatSuCnn7BGw5vG/dscjYoSgZpCKQH/Rzxw
MqW942mtWJxtXNxnwEkBvhPZjLb7NiFXNVo9IAzexjRJZ8JI7q4RH9JlnPXtu08S
UwETOt4rqPDPRKXHMkht0VPorzTIG0udiS6nwphACugNEZAWKPfyE0J6QuToQXQj
xvD+zb6w+g5Dytn8HpZuP0a7R9RZwg==
=nCuj
-----END PGP SIGNATURE-----

--Sig_/mzEsM7U0WXpWoo+ElKPohiw--

