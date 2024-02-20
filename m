Return-Path: <linux-kernel+bounces-73760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A185CAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD12840FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A61534EB;
	Tue, 20 Feb 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozWJDAjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68041AAC;
	Tue, 20 Feb 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467974; cv=none; b=nT9KKKXid0+ToQpxA2uuqrxBlktijqISzAm+jHuACiUiL7ldI6mhOgKOHlRV6EDBHLcV/LsT7KqOW6wth3DkMSl0Cl41AILrBpP1MMVUmYQGhjraXUtMKIAcjn2YAPQTOM5pm2QYH0FU9trHvZmZfSHofx5RbEjkC8LEURUzBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467974; c=relaxed/simple;
	bh=CFH2DJXMwok2pTz3ACcx/Zwt8Fa4lJXAomr5cxWf22A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rd8QUT5Mt4gNQQgE9w+FrUbj6OnemTXGL0ObXq5QclW11OHjpaeCn+3bySsorMSNF2s65qWodUOg6J0p/315wTuNjqvnzwA1q8gppU/8Y+anp9eyHPl2XVTH5U/LMl1pTlOMUxQI3DwSakCHemjiT2DAUGSJUrcXRasK/uoOASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozWJDAjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AE6C433C7;
	Tue, 20 Feb 2024 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708467974;
	bh=CFH2DJXMwok2pTz3ACcx/Zwt8Fa4lJXAomr5cxWf22A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozWJDAjvvoeVyb/8KnBMU1Pkis6bj/XrzlmuyuesoM9dSBUqjhqd12BhwzvnxOyrH
	 989Q9PfaUYrI1K4ig8wXQwcmVmDv7aSxIioXq40La128GEgiOAdK4jDA3kd9r44tR4
	 tfVUqdX3SDJv9cJluNmwTqD3HdbtT6olOYasMFeb2j1wZYfYdqIbupzSzLQ8EgXPtd
	 mBn661qtvUmzV1acROpE9cLfXPPAbpLN2MD4H4s4R/e33rvefQ5267D38M0/HR0WdJ
	 cEYHxtgOMxufPB+5WVPJdf/MFtkxUVfR/JB4deIM2QsjvvWH75Bwgiw6nyojx6ToeQ
	 ySSkgSpSCBpdw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 22:26:09 +0000
Message-Id: <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
In-Reply-To: <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>

On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> 	__tpm_tis_relinquish_locality(priv, i);

I'm pretty unfamiliar with Intel TXT so asking a dummy question:
if Intel TXT uses locality 2 I suppose we should not try to
relinquish it, or?

AFAIK, we don't have a symbol called MAX_LOCALITY.

BR, Jarkko

