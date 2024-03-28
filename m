Return-Path: <linux-kernel+bounces-123589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D2890B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EBE1C2F1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C813A3EF;
	Thu, 28 Mar 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRJtWg8p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FC1849;
	Thu, 28 Mar 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658176; cv=none; b=SXDhEzuI9PTq8gTz712+aOk8miOo2/gpMBpDU98rOYDyTfoOoxOfg4xOYwDdGd7E3xYn/fxf/6z2EKlFLTkfU0IYVGvXxmDRFPnxLzkGoao1KOzXNZsmF0VpQstn24HyDrNKm8HVaL04reYbprsRS1yLINCJowB0xV4N2ZBpWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658176; c=relaxed/simple;
	bh=SsY0lErYnKoP8ZzYMd9Gd75kk+sED7eEk6p0jqXABP8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X1NQHlx19rXTe7I59j+tIIWv2I2YFV1/WfinL53Bpmky+R6Nxj6VzS5hWagFwGajAc7OQXfkCCFjTpcudCpJtoUb/W2JTlA52UzbuqQzrrRoEVhvXlOS5o1gBhSToGAWfekVW2aYL9PC+zTSy8mw4zemOzWdEWHsyg76AxKXxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRJtWg8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1D3C433F1;
	Thu, 28 Mar 2024 20:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658175;
	bh=SsY0lErYnKoP8ZzYMd9Gd75kk+sED7eEk6p0jqXABP8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iRJtWg8plLpE36aezR0aiTBqaMV7IPIeoxz1iKvE0BwrZ2uagndDaOO349iknA8Jq
	 TQ4+DMAZbkIJaio4SyKIRbbqgKj2JfP1TwqoD9UKxKT4PYNMeG4fN94S3wqX7sfxJ/
	 i6Ku7lini1Pt/Ud7oZ5L1gX4+KnqteCffeObvEDPLEubIvdv6JVKNFdBZTJaE/4dyM
	 rLdj5nXUG1mxTwYHG4+0LloleAJ9OvTzxV51o+BQsek63Z97E3IuKHQyHLkm5SPGHL
	 t2n/O8grNx9cMVkzPwCdHsOnxi9gc3n8JlhYbxW6fT4e6u9D5Gsvyv1LOj6+F2zxZA
	 w6bbtrGAOsfBA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 22:36:09 +0200
Message-Id: <D05O6JVMMZY7.5ZUBAPJH22FC@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16 00/20] Integrity Policy Enforcement LSM (IPE)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <tytso@mit.edu>, <ebiggers@kernel.org>, <axboe@kernel.dk>,
 <agk@redhat.com>, <snitzer@kernel.org>, <eparis@redhat.com>,
 <paul@paul-moore.com>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>

On Thu Mar 28, 2024 at 10:17 PM EET, Fan Wu wrote:
> Overview:
> ---------

s/://

It is already a heading.

>
> IPE is a Linux Security Module which takes a complimentary approach to
 =20
  Integrity Policy Enforcement (IPE) is a ...

> access control. Whereas existing mandatory access control mechanisms
> base their decisions on labels and paths, IPE instead determines
> whether or not an operation should be allowed based on immutable
> security properties of the system component the operation is being
> performed on.

What is "a immutable property of the system component", or even,
what is "a immutable property" and what is "a system component".

These should be defined per context of use as there is no unambiguous
definitions of these "properties".

So can you add a paragraph before this defining these concepts?
Otherwise, it would be pretty hard to review any of this.

I.e. I have to make my own imaginary definitions of them and possibly
make completely false conclusions what was meant.

/Jarkko

