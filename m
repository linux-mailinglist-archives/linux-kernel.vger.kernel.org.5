Return-Path: <linux-kernel+bounces-100476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2B87985F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A651F22D13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51017D08C;
	Tue, 12 Mar 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3hLq7tm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A87CF2A;
	Tue, 12 Mar 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258782; cv=none; b=o0OaHR9lgXlbVBfXZPm+HMMKWpIabk/areoad5nKz4eXaIdp2im6xo8ZcyaBSm79P9+IJ9d7AzhVnPvkoAZbqFa8jivyYk/rnXwQLziT2CMHUUwjGYtQ7SqLMYbRKvBTSyjuGsDAChn62IupZ3nvItkgMdouMA6Y91KOOkcUM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258782; c=relaxed/simple;
	bh=W4547WbRCvwF1NrgSJ+HFYlSmHPmUaJuvTwISWCX+Wc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VlYz4SraumZXhwGn+gIj9/KzMivNIRMQeRWY1REsablY+Cg02ZsCHeReCXJjXHZUjUCedzWy8zC3RRhOt2hXqvKlNoxDXCuczDPwLnMkFnkL9uVjfDYF4d6ysocaH944NxmGnmfC7RmcW0fOH76QDmcM2dVaFBNr+wkTgAQdHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3hLq7tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6BDC433C7;
	Tue, 12 Mar 2024 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258782;
	bh=W4547WbRCvwF1NrgSJ+HFYlSmHPmUaJuvTwISWCX+Wc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=K3hLq7tm12VIejaWDEb1c1SwckRzmCYiZ5DlLewh1U7oMxp4qzIaEhNcxYQYWRn8r
	 w3gqYmmj1fkc+9x4C9LfZZQhg6Xloe3+lwxkvWtaJiM7CD4L7KPt9qK5bMbJ+/4wd+
	 BTPlyedZQujtvNcyCBos9NfbjXzKlj4sEDTxHb27Sfpf+VYG61nV0L0DkZlEoJW7hX
	 buCoo5iSBN7dDsqIMrdRQtgTI6kWYuGpVu1YVMs0tKMk69NnNC5D2jy2S+Dz1fTZ6V
	 a/9OEBl1VqjgdZVUKCwvcUTertBjR+kGijsKdj7PQXSplB7tYYY5pQsEXJuEv6t8QP
	 /YUu0KE74buHw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 17:52:57 +0200
Message-Id: <CZRW4ZZEH3BK.80W6O7YT5HH5@kernel.org>
Cc: <mpe@ellerman.id.au>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rnsastry@linux.ibm.com>, <peterhuewe@gmx.de>, <viparash@in.ibm.com>,
 <devicetree@vger.kernel.org>, <jsnitsel@redhat.com>, "Nayna Jain"
 <nayna@linux.ibm.com>
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: tpm: Add linux,sml-log to
 ibm,vtpm.yaml
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>, "Stefan Berger"
 <stefanb@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-3-stefanb@linux.ibm.com>
 <ZfA4TZspY7oOQ4vz@wunner.de>
In-Reply-To: <ZfA4TZspY7oOQ4vz@wunner.de>

On Tue Mar 12, 2024 at 1:11 PM EET, Lukas Wunner wrote:
> On Mon, Mar 11, 2024 at 09:20:29AM -0400, Stefan Berger wrote:
> > Add linux,sml-log, which carries the firmware TPM log in a uint8-array,=
 to
> > the properties. Either this property is required or both linux,sml-base=
 and
> > linux,sml-size are required. Add a test case for verification.
> >=20
> > Fixes: 82003e0487fb ("Documentation: tpm: add the IBM Virtual TPM devic=
e tree binding documentation")
>
> The Fixes tag is confusing.  The patch won't even apply cleanly to the
> v4.10 commit referenced here as the conversion to yaml happened only
> recently with v6.8.
>
> Why is the Fixes tag necessary in the first place?  Same question for
> the other patches in the series.  This looks like feature work rather
> than a fix.  Not sure whether it satisfies the "obviously correct"
> rule per Documentation/process/stable-kernel-rules.rst.

I'm not yet sure whether these are bug fixes and or improvements because
I did not fully understand the scenario where TPM corrupts the event log
so that part reminds to be seen.

Probably once I fully understand what is going on, it is possible to
argue on that.

BR, Jarkko

