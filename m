Return-Path: <linux-kernel+bounces-112443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562658879EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C32821B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB257314;
	Sat, 23 Mar 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK/ZlfD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D718E20;
	Sat, 23 Mar 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218346; cv=none; b=XIfZiErwla++J4Cmu2f2/BVlVQ+Fj3W/ynFIgzILdVoXz5h78s03oEJYfp9zGQeLwN6MyznY5ZzKP3cqiJi8kgRCxT54k+X96gdMdN4kqmDh2sab4KjzbYIHRGWCUJkFVQLJ7qnyVQk8+vmrSOWi+kAU3/XobDcWmr2uf8tM4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218346; c=relaxed/simple;
	bh=liGVbDAsKW05xQZWyPF9ufbQ+IFVrk7BJ/aTDcom11U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AJOgTjQp858BmBD1pLaE//LxrYjGOR78BmPg810Rr6ue2svUZ3rGIm1k40jb0iRjBsoaQLG255935aaA08dv5EtF+WMCU59sPggMgqYJLLz72hnci22lJRJOQHfmyLeuKscRTuaCMLptXNAf4W6qz+NIASijQ1Sa8nnI6DR2QKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK/ZlfD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B5FC433C7;
	Sat, 23 Mar 2024 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711218346;
	bh=liGVbDAsKW05xQZWyPF9ufbQ+IFVrk7BJ/aTDcom11U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rK/ZlfD0NtDP2c/9by3JyZldEIeJRBqiSvSPA07dDtJmp7nTfB3z7xyhKXqx7Ja5U
	 0HEDoU3tsXF1p+GZyypFyn619zT1zPV1yd9jO9TdNKK21z4PJdsinV393Qi0GoNtNs
	 NBvHvTkiM2jus72h0Dytd6TXoQ5VthzqBu+QbxxwJ8q8/YUgRwgZ7Lk3jRob8LTuG6
	 ycISZFbAu7W1A6D73SAxKR/nr3gkpJvAljLBnYw4+zS4XuBBq3BdekudEi5j82BQ3U
	 LVHh/LUf1T/a4t7tnrQK3gPYDX95watSDP0TI+m4s+jQJa1q6Q+XQn4TTiBE6luHDN
	 uprcW2KcupLyQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Mar 2024 20:25:41 +0200
Message-Id: <D01C9XMYRA1M.N94CPODMQSXS@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Daniel P . Smith" <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v4] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240322123542.24158-1-jarkko@kernel.org>
 <20240322155233.30422299@kernel.org>
In-Reply-To: <20240322155233.30422299@kernel.org>

On Sat Mar 23, 2024 at 12:52 AM EET, Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 14:35:36 +0200 Jarkko Sakkinen wrote:
> > +TCG PTP Specification defines two interface types: FIFO and CRB. The f=
ormer is
>
> Could be worth spelling out the PTP part here, I'm guessing
> get_maintainer made you CC netdev because it thought it stands
> for Precision Time Protocol. And one has to read till the end
> to see:
>
> > +TCG PC Client Platform TPM Profile (PTP) Specification

Thanks! Good remark.

BR, Jarkko

