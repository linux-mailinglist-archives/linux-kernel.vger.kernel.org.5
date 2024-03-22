Return-Path: <linux-kernel+bounces-112080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FB8874F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497DC281554
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123608289A;
	Fri, 22 Mar 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu+/ScIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094D1CD00;
	Fri, 22 Mar 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147955; cv=none; b=DyH7dD0Vxq+oSZH2oFX20DSJEggmcNEyKfrfEIn1KuRuzPzpqjHSndbe/6sM86R+mWwc/1/QAyDm+TCh9SrMgH6fra/ST28d8uHpFovLUPbDccq4QvI7Xkg1Qwe46wY/tVc4HGDWE8VJwWKAxeWeyTlCNOe3x4LbA5tlBb35QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147955; c=relaxed/simple;
	bh=hKZFEeKpoc/pNzTRJQzWbV56PN2qw+KOa9bJztyzp6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYgkKxXIVvF7OqFznrrC0fosBoQ7A7SRczFYkZCuT3kw5IXkmvHVLHpM8KQLsI2pr2t0Nli7jNEmfitrTjzMGsvPn/p88YxpGHNtSPYCxC7uxjF1p37mMvJQPSYbLGawsn3P1u3MckGSJutauDRfDvFAOCw5STHXRRVv8TTx8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu+/ScIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8ACC433F1;
	Fri, 22 Mar 2024 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147954;
	bh=hKZFEeKpoc/pNzTRJQzWbV56PN2qw+KOa9bJztyzp6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xu+/ScIrlTsDPj9UZG+4uKHIoNFjGpxlEEKAPyt8hzlwWBqmd9SC5LWiFETpdCD2Z
	 bozJduZe+PexSYCRHYN8JJJamnREaem1a5BobeKYSC0oeacyV3q+zlA6ll4b8nvgu1
	 8MjjpGReyCeTdeF5wLun5k9YdDuT3GvU1ZZz7oGEaOtEEBAZ+GuF7VNJ9cZExGQrdG
	 xVBDfk/w8i7jA3IXPFtcOqhoFQ9FgXl1NiRYTp6fvLLfUSWLZQJ7xgXWocc9kYRYKs
	 u2d5siRZu10W3+lAmKuKsyceRI8BkwvuYKil67YqiDiFsWmQdnfsPEatSfdXsSegBB
	 Rcq+CQ6M/8aNQ==
Date: Fri, 22 Mar 2024 15:52:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 "Daniel P . Smith" <dpsmith@apertussolutions.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe
 <peterhuewe@gmx.de>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Alexander Steffen
 <Alexander.Steffen@infineon.com>, keyrings@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK
 SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))
Subject: Re: [PATCH v4] Documentation: tpm_tis
Message-ID: <20240322155233.30422299@kernel.org>
In-Reply-To: <20240322123542.24158-1-jarkko@kernel.org>
References: <20240322123542.24158-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 14:35:36 +0200 Jarkko Sakkinen wrote:
> +TCG PTP Specification defines two interface types: FIFO and CRB. The former is

Could be worth spelling out the PTP part here, I'm guessing
get_maintainer made you CC netdev because it thought it stands
for Precision Time Protocol. And one has to read till the end
to see:

> +TCG PC Client Platform TPM Profile (PTP) Specification

