Return-Path: <linux-kernel+bounces-100841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A55879DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D752F1F22532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B8143C67;
	Tue, 12 Mar 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeIf8Pf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485B143737;
	Tue, 12 Mar 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280439; cv=none; b=Pgji74tFFKbBW+FYVGoFAjynE9Z0f2tbEVeBhaMPZ6kNDHb/AkImVWvtwHGYBol/IKlMGqnYCjM0Xhochxi0dy7qyvVesIrV3HlsVUO9vIIOtvDJr/umOiC5mDANxK83wNiQ+nQtcxFAgwmTZsGfy8bNyG/btUKoKM9Sv5cwTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280439; c=relaxed/simple;
	bh=Tc348j2ztBETv5vIUAMjzjQsx1Ha/CAwf8R18X+E9Zk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=TOIq+xCBzsj8meCyY23zUM9xEfyGAuhbQlUC9jAMjcuXy3rDbpMS2tjnEsdafZwc2rbvUwveBnA7tL+UVTrvPC+ACGIn0X+b7RiFQsPcEaR6D1qidI2KtCQOw37ycQNQRSz9irtyP4cTFnoTrP+qGlQaTBOgc88/cNAH7bjlHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeIf8Pf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB27DC433F1;
	Tue, 12 Mar 2024 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710280438;
	bh=Tc348j2ztBETv5vIUAMjzjQsx1Ha/CAwf8R18X+E9Zk=;
	h=Subject:From:To:Date:From;
	b=qeIf8Pf6yWuog9kMOm0eatpzHJxSwPhXNSfVz9x+XRWSFp+FmI5MVnBiL0AnObfFJ
	 YpHQ61u27aMB8hCB/lsjDtcN+jiLflhDUTKj6G3S5CG29HOsEE47O1P5f4zMEPrhW2
	 t23KXHn4zqKKfUMeVOHTjN27x0WkGMrPfxnKYciIwodC4rCgpbF87p+Cl4qNxPKas0
	 ESypucrs1jL9qESu/mJI1l/pWeYUEE3dU/rCZJKJJxzDTMMOb17qqIWik1hy/i0CmU
	 SS2kpsskGa91WW5MlcgZ5GQm88ywv3gfwOtujBbKgR59Py24mtqQ06UUSUu6HFPLNf
	 6vdSBwvXtds/A==
Message-ID: <56d1878f04b83c3f681260557fade4fcd7a87b04.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.271-rt89
From: Tom Zanussi <zanussi@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John
 Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <wagi@monom.org>, Clark Williams
 <williams@redhat.com>,  "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tom Zanussi <zanussi@kernel.org>
Date: Tue, 12 Mar 2024 16:53:54 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello RT Folks!

I'm pleased to announce the 5.4.271-rt89 stable release.

This release is just an update to the new stable 5.4.271
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: cef72c43e133263183674cd4dc449511432c8d91

Or to build 5.4.271-rt89 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.271.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.271-rt8=
9.patch.xz

Enjoy!

   Tom


