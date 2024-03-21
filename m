Return-Path: <linux-kernel+bounces-110450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E726885F17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605B41C216C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F5133423;
	Thu, 21 Mar 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8ekIH4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A71332A1;
	Thu, 21 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040057; cv=none; b=TyrE75oT839QXgNvucqKBJWHnrAe3sId90kzB7pzAddZ1bKGLv+oRgA6UcJClA2tDXHQwGD2W/GXGo1SBz17j2bEjRjThUXE4Po/gi+6Uon0vIzlhIuMwpAwP3KniKJjYZG7O5aML9VfefcTAnpWt7yhIAyr+zZ7MmX/x4OJoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040057; c=relaxed/simple;
	bh=em8npsP5TRLXP8z7MrWac1dI0o9nJYKSt1+DzV4vxn8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bzyIl3qJzUUj6lCFngRyRDGC6KxGDUdJi8jHv/s0smkMvjXa7cmx2XiDeBv4Bf566o6qMvfEU8/bb2RmUvmjqa8S65nFELpWUYnBFLipUElN43zoJAaC4yXxRR7B/iSUDI5S3ri//zHQ/VTqs3neXCjCzJfUp10khlflDmriKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8ekIH4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA39CC433C7;
	Thu, 21 Mar 2024 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711040057;
	bh=em8npsP5TRLXP8z7MrWac1dI0o9nJYKSt1+DzV4vxn8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=S8ekIH4hsj/trg10VRDeDAnxuZdvBgg2HKZ/x34KzSJtfHtlQbzmXEWDB2XW8tuw/
	 meEeqhIWPwLvLnSCyuKE4nUS0hDRH7E2h9tn31NBmM9DApHQaTaANglzZE8hvO18vT
	 cMCPs/LUOKLaEoBYLxVKsNrUa12R0pmWwu6c24aHWD5Udc4FlSgYauCEYnsE6PrTDw
	 3tKoiBRe6L4NG1QhDubHE7/Km4Nm7RQcw4Jd4dB2uSQBAeE/YE/aKZ+020NtPBSsWu
	 Snu1GT60Q8UQ479pIMPQcByLmJvc2ALvcF/REx/t7donD7iEc6mOkwL4Bh0albTdOP
	 KvE9hMdLeMavw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:54:13 +0200
Message-Id: <CZZL2SXZSRV0.2MGG3O8JXBFC5@kernel.org>
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
In-Reply-To: <20240321164314.14732-1-jarkko@kernel.org>

On Thu Mar 21, 2024 at 6:43 PM EET, Jarkko Sakkinen wrote:
> Based recent discussions on LKML, provide preliminary bits of tpm_tis_cor=
e
> dependent drivers. Includes only bare essentials but can be extended late=
r
> on case by case. This way some people may even want to read it later on.

$ pdftotext PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_=
pub.pdf
$ grep -ci 'FIFO interface' PC-Client-Specific-Platform-TPM-Profile-for-TPM=
-2p0-v1p05p_r14_pub.txt=20
55

$ grep -ci 'TIS interface' PC-Client-Specific-Platform-TPM-Profile-for-TPM-=
2p0-v1p05p_r14_pub.txt
2

55 > 2 so that pretty much nails this terminology.

BR, Jarkko

