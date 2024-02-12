Return-Path: <linux-kernel+bounces-62311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6482851E63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BECB255D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E584E1D5;
	Mon, 12 Feb 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZpTXpOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAA4E1CC;
	Mon, 12 Feb 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768317; cv=none; b=cQW/DQM+c5aJSDPQTmriKgIrMI18VEBg8WwfBQCgWIUuidScvD9d0NLnlN0cGlCBkUHLNDZu6Xn38qHRZ5kjbT48r4Ru5f05lYhFXqdRprbgnPQRgkeF3SalULuf6iNRnSVPPcmxRk9OcFfLIHeezAuQhMhK4IHfQIIzDtXizSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768317; c=relaxed/simple;
	bh=C1Uur93VzozDJB1KDcwGTxWQyeDZHRrmkGuViNEdyC0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XlFzEC1GAyAQ6TPTPN6/OyxW5jvkUI57xF4t8GPbPTvB8YvG8ZQ2imFKqHoXwzZeFg2hI7yI0PB0L1J8hEsIzlyJF48RmM8JtlxmtxFIwq+2bknsKg/5s2DRJnWPNeno0Z1OqBqkRDuox8HlT6HPn6laNgLtTxUMym6+qtikOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZpTXpOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD81BC433C7;
	Mon, 12 Feb 2024 20:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768316;
	bh=C1Uur93VzozDJB1KDcwGTxWQyeDZHRrmkGuViNEdyC0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=DZpTXpOz1RyoE8E/G7bw6IT9gly+udU4s1xI7qjMCtGzBHP62ttJOFB3VKlf7AD8o
	 Rvnj6sSVQCyuPyOf65o85ntiHPbJB9KsrEfMBEJULZCua637zPW8bQK3IA78+MOZev
	 WUXHCI83iYvPJ0SQQOVFII/VZa/bmLpDcirv9rH85vYG/Lecg1GI/b5z/trmqAZDpD
	 vlUt6HRtgELgdIZ9NG8/6NaORNYyFMnmUU1AndX+FUUmJwKvqrhKchIIWEV5FvSeXL
	 agBrXS+kW/KmI71d2zfz7z77WJ3UFiURTP9+sNwPRgzi1/OLCy+XkTlBnKI2olXj4e
	 kLB+O9PbnETRw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 22:05:12 +0200
Message-Id: <CZ3DCC8JHNLK.3MGE70MQJT5XM@kernel.org>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
In-Reply-To: <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>

On Fri Feb 2, 2024 at 5:08 AM EET, Lino Sanfilippo wrote:
>
>
> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>
> >=20
> > On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >> Commit 933bfc5ad213 introduced the use of a locality counter to contro=
l when a
> >> locality request is allowed to be sent to the TPM. In the commit, the =
counter
> >> is indiscriminately decremented. Thus creating a situation for an inte=
ger
> >> underflow of the counter.
> >=20
> > What is the sequence of events that leads to this triggering the
> > underflow? This information should be represent in the commit message.
> >=20
>
> AFAIU this is:
>
> 1. We start with a locality_counter of 0 and then we call tpm_tis_request=
_locality()
> for the first time, but since a locality is (unexpectedly) already active=
 check_locality() and consequently
> __tpm_tis_request_locality() return "true". This prevents the locality_co=
unter from being increased
> to 1, see=20
>
> 	ret =3D __tpm_tis_request_locality(chip, l);
> 	if (!ret) /* Counter not increased since ret =3D=3D 1 */
> 		priv->locality_count++;
>
> in tpm_tis_request_locality().
>
> If now the locality is released the counter is decreased to below zero (r=
esulting
> in an underflow since "locality_counter" is an unsigned int.=20

Thanks, Daniel, can you transcript this to the commit message?

BR, Jarkko

