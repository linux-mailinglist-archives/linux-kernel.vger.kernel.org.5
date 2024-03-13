Return-Path: <linux-kernel+bounces-102374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8E87B158
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E98828C17E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFA63134;
	Wed, 13 Mar 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b="KrKykjnW"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2001A38D7;
	Wed, 13 Mar 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355201; cv=none; b=JJGGste2srWiX+VyiJfw69h6Ro6LHWYemOaAKSIHcn9gN3G6D8/6vBkkRquMu0YNZBpMtWaq025n/pjiAxKxGdq7w+45uSs/RtIai3o71NCAHSAgAMdotYCS1/9aP8LVps8ena/ERqaLSDZaaJ6af1JoBzCJ7HZuf3KJEcMaNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355201; c=relaxed/simple;
	bh=Yrv8K3dsh6oQe0fjpFm5hJusnOC8JMbr41ioJIneLpA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc0NpeEDlggxn1bcKNuZKkT8DgCIsCiEUtfEMOQaTgqLmRiW0l+9l4vhVACimjf1tfTJf0SbB1oCLvFNsFcIjHZnN0aaDfMN0L2XK9YdsWpDYg/BtbmwMvMeNOYW64eEQznBvdJwlcricRUw3FBhj2HQ48sfCNYbP4bsZRqaxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no; spf=pass smtp.mailfrom=yartys.no; dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b=KrKykjnW; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yartys.no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yartys.no;
	s=protonmail2; t=1710355183; x=1710614383;
	bh=Yrv8K3dsh6oQe0fjpFm5hJusnOC8JMbr41ioJIneLpA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KrKykjnW5eFDDULKUiFGV+s7Y+Nvz+Tnn1yTw8HC6fXQ/B7Rtcrn2a8Ufw+mPREHg
	 tDi5RZEf/D4wxLWLBwp7V3gLFSq8tXkbySxgQr2KYOahuHzApZ9UDBdvCRux+zbUHp
	 Qu4mZhaiGHYR51PP5aQqM7dbTt45b4iXu1UUYuHKZT/huLEF1M8T21JdBBw3ACqjJF
	 ero40e4Ujk7NiLh/mTpB5ymvd1WFOyQxNb5h2wrc0e0PaNQJjhJQpRiObxFh3NSW0Q
	 86BST8cig9RaTNJs4OkBmi5tzkM90F0goJTer1YWD75PRnS7+1uNfwcc+o9uybvspB
	 5EAMNwiSk8PyQ==
Date: Wed, 13 Mar 2024 18:39:27 +0000
To: Johannes Berg <johannes@sipsolutions.net>
From: Michael Yartys <mail@yartys.no>
Cc: Karel Balej <balejk@matfyz.cz>, dimitri.ledkov@canonical.com, alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org, mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, iwd@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Message-ID: <NbWQKmrYDD20KKHeq9TMda2MJFE00-weepZGuSIRzO5BOgMlTbWBkDlNNweA2dhbvF8TK1F_cHbMxblLVNREZa1HZEFt9TVCkTB1jo_5ppc=@yartys.no>
In-Reply-To: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz> <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Feedback-ID: 77365699:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

This came in via the iwd mailing list, and I would like to add some small a=
 detail as I also experience this issue on my university eduroam network. I=
've verified that the certificate chain doesn't contain SHA-1 signed certif=
icates, so the update breaks more than just SHA-1.

Michael




On Wednesday, March 13th, 2024 at 09:56, Johannes Berg <johannes@sipsolutio=
ns.net> wrote:

>=20
>=20
> Not sure why you're CC'ing the world, but I guess adding a few more
> doesn't hurt ...
>=20
> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>=20
> > and I use iwd
>=20
>=20
> This is your problem, the wireless stack in the kernel doesn't use any
> kernel crypto code for 802.1X.
>=20
> I suppose iwd wants to use the kernel infrastructure but has no
> fallbacks to other implementations.
>=20
> johannes

