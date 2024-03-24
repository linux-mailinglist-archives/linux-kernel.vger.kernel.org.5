Return-Path: <linux-kernel+bounces-112549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F9887B68
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8029E1C2105A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2424439;
	Sun, 24 Mar 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc96guzj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464D81E;
	Sun, 24 Mar 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246483; cv=none; b=dKN3vc6aYyRMFRGtImvbk4vt6GzFLQACYyFHMCorlkMqMLrMBIAW5XowM3Jl2VG7QdxwYrFASpDz7Pi4DRqL4sL+23Xc7pGgNxI6KWicgNFfp5/njxMEm9V0+5+lX8j0/bGqWmnlNnhiliWSyBTgVMXhDSmzieK2rfdD9whP3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246483; c=relaxed/simple;
	bh=4i4BgjkutHOyxQNBbaoCLs26rtfvwXtsWOZ6p4wy4TA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=CUP/7swT3ngGLTsqr23LDxt25j+WMjXUJJtMsTCRiUw495DQnykwp7gL7d5VJd/K1aIHo1isfSNEtqsVLVpN6/xZE8LkzX8Al6Ay0KJFELrGKFiFbSEcd/CQxuQaQXh30G51jU1YBhf7Y+6m9hCD+heR2wLC2ho1+WisZA4Nrqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc96guzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775F5C433C7;
	Sun, 24 Mar 2024 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711246482;
	bh=4i4BgjkutHOyxQNBbaoCLs26rtfvwXtsWOZ6p4wy4TA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bc96guzjjAsYjbVDO+YyU4yBxKS1Ck/FggYXeZl8u1pK2+3HPIawKkdEbN36ROUbo
	 YGU2GFGInWBVOFdVyTJDlTNuPrT91E2pX0y8TTX5xnRHSV1A2rGBDLgITEGDb6EiET
	 wklKd4ULsv3bZNePrujdNvd4G2Vx5803sOW97gUJScFhMUFpIgssAC4dNUUO0Tp1aF
	 GtbitDPA26U/a3WdxcbNexfQ7CTjKAAmZDh2VQrgE/XbQ4YlIrIGoYqu6b8sGLATfJ
	 PHf6jQPq5JDl9H80ylo0VTLYIomQobjwN5p8oi7muAzHeSmYpvR+SGyrtFS4BmO5p+
	 7ITEHSUQTNmcg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Mar 2024 04:14:36 +0200
Message-Id: <D01M8YKG5ZG0.287OTMCUU2KP5@kernel.org>
Subject: Re: [PATCH v4] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, <linux-integrity@vger.kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)"
 <netdev@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240322123542.24158-1-jarkko@kernel.org>
 <5a494de5-b004-440c-bcdf-7bdfa3a8c508@apertussolutions.com>
 <D01CLI2TC5SZ.1A48PDHM5F3UA@kernel.org>
In-Reply-To: <D01CLI2TC5SZ.1A48PDHM5F3UA@kernel.org>

On Sat Mar 23, 2024 at 8:40 PM EET, Jarkko Sakkinen wrote:
> > Would it be worth clarifying here that one of those interfaces is=20
> > defined in the Mobile TPM specification, which also refers to its=20
> > interface as the CRB interface. In the past, this has caused great=20
> > confusion when working with individuals from the embedded community,=20
> > e.g., Arm. The Mobile TPM CRB interface, which can also be found being=
=20
> > used by some generations of AMD fTPM, is a doorbell style interface=20
> > using general-purpose memory. I would also point out that the Mobile TP=
M=20
> > CRB interface does not provide for the concept of localities.
>
> I don't necessarily disagree but it is out of scope for this. I'm not
> sure tho why "mobile" CRB would ever need that sort of separate
> dicussion.
>
> Some CRB implementations have localities some don't, and also fTPM
> implementations on x86 vary, no need to state that separately for
> mobile.

I.e. the variance exist but it is not "mobile" specific.

E.g. when I developed tpm_crb in 2014 at that time Intel PTT only
had a single locality (AFAIK later multiple localities were added
to support TXT).

In all cases this tpm_crb discussion is not really part of tpm_tis
discussion.

BR, Jarkko

