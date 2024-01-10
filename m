Return-Path: <linux-kernel+bounces-22685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2E82A18C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1991283650
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38574EB22;
	Wed, 10 Jan 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NngQGyCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8134E1D2;
	Wed, 10 Jan 2024 19:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016BC43390;
	Wed, 10 Jan 2024 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704916467;
	bh=G/7hgYXNJihtqEGK7wf7YlXvXrRVOT9oUMyOaFQcpCk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NngQGyCX1jxlJKb0CtcVKw89DboFowUBRbga16rY/xFOUOQfyO5ngYWMXi1PTH9zL
	 c0gHz89Ug8rvZrOqDUdhGS6oGvI8cqAzV4Cd5xFKKg70iaoKnVORlBGevOo320hY0I
	 v3JWOjyqB2uh97VZsJ0VwfhrIuO5NWcfjlJKUt8ah0F0OXVOnwtlAX4FiSmRpOF2vh
	 XTTNaWLHtJ+GuhHeG++EaZOYYzDsaVydM6ZCeuCTLJXsaLnRHkI13p8Ye+rcdU0e1S
	 S1NrPOuzy3kIpjhj4YRGfv0OOn1AzJOmpw+KFp6SLeUZiKiGNWvVFQ/455x3h22O2w
	 daV8wkd6Irt3Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jan 2024 21:54:23 +0200
Message-Id: <CYBAG2X330P5.2SIIYCQ1GN44G@suppilovahvero>
Subject: Re: [PATCH] KEYS: include header for EINVAL definition
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Clay Chang" <clayc@hpe.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240107132842.4024084-1-clayc@hpe.com>
 <CY9E6M2BYETA.1VE73N3UHD4B9@suppilovahvero>
 <a77797fd-cbe4-42be-abd6-54cc815d360a@hpe.com>
In-Reply-To: <a77797fd-cbe4-42be-abd6-54cc815d360a@hpe.com>

On Tue Jan 9, 2024 at 4:10 AM EET, Clay Chang wrote:
> Hi Jarkko,
>
> The issue was found when crypto/public_key.h was included, but
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled. If
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled, the
> public_key_verify_signature simply returned -EINVAL, which was not
> declared without linux/errno.h being included.
>
> Thanks,
> Clay

Do you have .config to verify this?

BR, Jarkko

