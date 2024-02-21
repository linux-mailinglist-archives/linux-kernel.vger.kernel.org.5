Return-Path: <linux-kernel+bounces-74701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C385D7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FFE282592
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A2B69317;
	Wed, 21 Feb 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xuzzuTvm";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZQJ8zySG"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A65231;
	Wed, 21 Feb 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519031; cv=none; b=lZm1LOLD0FR66B657L9o6KP/mw97QFGCPXvdfcZqKGvGr/sbZjdLB1fTlfw7ILtL+czUU4ZRseMqzvK2kGdcHcPJvmo1Q53AjVUSmj9Ft4OSVH8H12zOVS9yCKvsIBh1Xfliwg1Luuqh3D8lqxCDECmHSYdCZ1jMLPnql5tGn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519031; c=relaxed/simple;
	bh=EV+8Kdakk6AUMifVeF8z7XA54mjPMAluhchCZOLm3/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lisx/ECAEzKVRcHQT9xwtswNO3NdAWBid21lTOZuSMXSygsI6Aipv1PCXKeJcETjVLWA8Y6wcniGqMSlA0id+pAK8JaSYmJOfzjiwxwCTOddLO/O39mF2dqx8FGlrvfQRPxaG9BELjEpauEAdjbdxiYLkGcCiBSkGpVEVLtTAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xuzzuTvm; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZQJ8zySG; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708519028;
	bh=EV+8Kdakk6AUMifVeF8z7XA54mjPMAluhchCZOLm3/0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=xuzzuTvm6nF01WesnQGCDzKx1NS0plnC01JXB3KzQsul1SXVPJi9NZvClHTlSEbpU
	 PK2BDttotg9F/cTYu57RLsNpiEPgLXQDfxzDyVopwL1s0QmVYC84KJPyQuamUPuV2G
	 eJtIphQq//f936I6JCOH0ACIyI1lK/x3rZhD3lvA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B0CAE1286FEF;
	Wed, 21 Feb 2024 07:37:08 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Vh-XjcP78zjU; Wed, 21 Feb 2024 07:37:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708519024;
	bh=EV+8Kdakk6AUMifVeF8z7XA54mjPMAluhchCZOLm3/0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZQJ8zySGRzcl9/AjAaICWwBgktjf/1jS/VaDXjwb8czaHup+1YPaP3P9ITE3mpiBh
	 D38BlCMMblK81NYGhciptL9QmyApl3JrTRukzhyBOjbNX0FF8POh0BOnH8U05EnOKU
	 oK4mJRRMnRvNm9WrouTkGEpHPmbbxg0vVHhxwxZg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C93151286F61;
	Wed, 21 Feb 2024 07:37:03 -0500 (EST)
Message-ID: <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Alexander Steffen
 <Alexander.Steffen@infineon.com>,  "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin
 <sashal@kernel.org>,  linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>, Kanth Ghatraju
	 <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
Date: Wed, 21 Feb 2024 07:37:01 -0500
In-Reply-To: <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
	 <20240131170824.6183-2-dpsmith@apertussolutions.com>
	 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
	 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
	 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
	 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
	 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> 
> 2. Because localities are not too useful these days given TPM2's
>    policy mechanism

Localitites are useful to the TPM2 policy mechanism.  When we get key
policy in the kernel it will give us a way to create TPM wrapped keys
that can only be unwrapped in the kernel if we run the kernel in a
different locality from userspace (I already have demo patches doing
this).

>  I cannot recall out of top of my head can
>    you have two localities open at same time.

I think there's a misunderstanding about what localities are: they're
effectively an additional platform supplied tag to a command.  Each
command can therefore have one and only one locality.  The TPM doesn't
have a concept of which locality is open; if you look at the reference
implementation, the simulator has a __plat__LocalitySet() function
which places all commands in the just set locality until you change to
a different one.

However, since the way localities are implemented (i.e. what triggers
_plat__LocalitySet()) is implementation defined, each physical TPM
device has a different way of doing the set (for instance, for TIS
TPM's locality is a function of the port set used to address the TPM;
for CRB TPMs it can be an additional tag on the buffer for command
submission).   I think the locality request/relinquish was modelled
after some other HW, but I don't know what.

James


