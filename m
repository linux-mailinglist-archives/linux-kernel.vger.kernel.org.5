Return-Path: <linux-kernel+bounces-110457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34020885F31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E380028387F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872479E0;
	Thu, 21 Mar 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqvgQXKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1E1353E8;
	Thu, 21 Mar 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040473; cv=none; b=V5DKk/u2M6OAyVofw3F9lLBLm5eVjGZ209RihSNnB/pp56kCTq3KxqWQek5woiXa6PnAHNAIEkdQO5R2uN8N7uXfe6Mwg0rhlsJ36IBgX+7bC4T1M/487NoIMVGp2bhHRaWaMJn9vD1ntCjcsDnNeYv2Cy42oyIL2tpA2PfmtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040473; c=relaxed/simple;
	bh=cQKiNExA0cMrOaMRBdkCkHV2+MZQz2AfhTZE1Ga4pMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GNG10wNLIweQ0sESBVyXzf/cQqwMac8wD9eZMIKWpp0uVeDlaJcEf5gIntKotcDRNt+ud50wV/41Vf1uP5iSru2QJFGQ5Iirqf6s3lq0z0YLlSUtVL6X4R+5jMxzLdgYNU/NTP61KsJR46wMj0PWZZydA9NprFNXHLkcBFmfEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqvgQXKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55E4C433C7;
	Thu, 21 Mar 2024 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711040473;
	bh=cQKiNExA0cMrOaMRBdkCkHV2+MZQz2AfhTZE1Ga4pMo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fqvgQXKRVQEAvqtNO6LmaZbdV++IEjv7Q3j3+mQcD1J9Ao43KYEbPxkdIsYmWif0F
	 TxF1MUdV9jj7wrCjpJHSRhUHmSfN49wnpCFIkb5NxE9JvmXi01QUXLKcgSc8KThnpk
	 nn9gfRcqc8iVgyKlhbmwniOvFMdb5ACth9hI9MIHpDLjtq0wBlxk9unfE3qqT5PCQc
	 YzC3AHJm2/MBBhKsnz+RugTvk/h2Homw/vnm6+PDN/m1OYiQTxwbxsmP3WS564iMh6
	 GmQMVFnKbjkr/1Ij8UmtZUJsk4J+nYO+o0GvN8I8XYegkC3WRBfak/6QH8ltrTQeuo
	 Q394v0E8Mk29g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:01:09 +0200
Message-Id: <CZZL841RSX3V.3SZOJNMC136O9@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Daniel P . Smith"
 <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Peter Huewe"
 <peterhuewe@gmx.de>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>
Subject: Re: [PATCH v3] Documentation: tpm_tis
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240321164314.14732-1-jarkko@kernel.org>
 <CZZL2SXZSRV0.2MGG3O8JXBFC5@kernel.org>
In-Reply-To: <CZZL2SXZSRV0.2MGG3O8JXBFC5@kernel.org>

On Thu Mar 21, 2024 at 6:54 PM EET, Jarkko Sakkinen wrote:
> On Thu Mar 21, 2024 at 6:43 PM EET, Jarkko Sakkinen wrote:
> > Based recent discussions on LKML, provide preliminary bits of tpm_tis_c=
ore
> > dependent drivers. Includes only bare essentials but can be extended la=
ter
> > on case by case. This way some people may even want to read it later on=
.
>
> $ pdftotext PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r1=
4_pub.pdf
> $ grep -ci 'FIFO interface' PC-Client-Specific-Platform-TPM-Profile-for-T=
PM-2p0-v1p05p_r14_pub.txt=20
> 55
>
> $ grep -ci 'TIS interface' PC-Client-Specific-Platform-TPM-Profile-for-TP=
M-2p0-v1p05p_r14_pub.txt
> 2
>
> 55 > 2 so that pretty much nails this terminology.

To add, this documentation *clears* the confusion in "FIFO vs TIS" by
documenting where TIS comes from (i.e. from the original TPM Interface
Spefication).

If you read the current standards you bump quite often (55 times in the
current spec) to FIFO interface, so it is good to clarify their relation
in the kernel documentation.

BR, Jarkko

