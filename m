Return-Path: <linux-kernel+bounces-97761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFAF876F0E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EF4282533
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FD3612A;
	Sat,  9 Mar 2024 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VzYDZ7BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIJFWJKB"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09E241E2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956909; cv=none; b=VzGMklnPkWVLnMgCmzCuM147tiX18zCm/VQqEsaIdxesyeR18+G/qvc11H7mppXUYGaJ0GbmVQiqqKoxndlLovFaU1tnw3rMpIkYspWX2gaP0ysDTh29HbOxu23ujEnjxnr1Fo/WBrcl7fP22d4pfk4bBm5UN9sg8QCJqF6Rxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956909; c=relaxed/simple;
	bh=SucOY6V7qJGIyXc8BNbSKmH7vuzAK4gLF5MBjFJlcnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+mhpQnXGDXagTXz1QBuK5nmpgkTq6nAgDFTX2LiqTvXXvh6nocFVuKcYR3Wy7MW+W/xdOBwvojir5TDql0jVlE+UWcQ9hl1JksP2n6Ef3thsOORVHqJZdZIAbV8F6Y2nb8G8+09pX4PF4hEYrPD1kl85RGiOJhjf7ChdBpuRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VzYDZ7BH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIJFWJKB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A050C11400A0;
	Fri,  8 Mar 2024 23:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 08 Mar 2024 23:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1709956906; x=1710043306; bh=Qx7fz/R63vzW9OILGb/IE
	jlw534bBxOVv5yQFYs8O0s=; b=VzYDZ7BHPLm0nZ35XUOXJ2JCr/7+6c8AYXiCR
	LDkpacIsJwsH7cbAK0i6Nnyu58ksPrQ8XA30lEXBad63g3LTkhhHQRX0k7DvPl2B
	ch8Hv7Eyq5G8sBO8ZQtfdMcdB0SPIFMQnLZnEQu8f+S31NlKMtvOZmW1JZRVfeoT
	Y0/+NuWRK8aD29SlqNDSiM/+8XL6MTi1c1FqGz2YOiEqkPbYN7zz+ItZvWeZVXDY
	eNc01oODZBkuw/aCKHUMSb8geCKY4gqVNrPnbexnO4WtNB/pB9zMNpamOEImN5A/
	pfPf61HIuYeNBPiMeVCdjpV3tvli70cFhItwpVDpf7um8mkyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709956906; x=1710043306; bh=Qx7fz/R63vzW9OILGb/IEjlw534bBxOVv5y
	QFYs8O0s=; b=nIJFWJKBwpOH46tGNTxB05JY5soPs9drD4S4RIKCyPdOk20Hd/E
	xD69ra7y1blMLJatIiyE25yGUHDki+cowfnZcFA/vi2Eg3hqbAbl1vPkfUnURJYk
	41ibSGfytOFV1xCaAywmM4WWPFmyJWTlRep8cOQ7qrUd/VlTTJAFIZNUp2KQw//6
	2PHNtMDNozzYu2lYGArp2uKrYP/2iyyxS5AHKEeYpF1QVw9pLThkeicCgE0YBnPT
	LmxOfVDG8n6ydpv8UtbDrjuwk+MLTDhWYHtYLDI+rWeeqaufxDcWNjojQi5lSOoK
	QiSKKSAVncs3u3AkwIH6Rx875q2xMRPsB0w==
X-ME-Sender: <xms:Kt_rZcyH1AbceXt2pFICLn7fQ3bLzYCBDsB2V5FHgkEcS1GVY7uEMw>
    <xme:Kt_rZQQ2hTqBx3ZXjdDuO20qi8EpN2T2bHxMXGeTpD1QMl_N1JUkFTDMU-E_2u1Bj
    jbZv9PyfPwrN5IPhlo>
X-ME-Received: <xmr:Kt_rZeXvT9SplMoEoJGJoH9euqeehhakY7htt9-FDixS5orKdbFkZ7ps6Sm1rFJoxQ0QWtOzFkR9lZ-Tx2GTXaW_NtHYt_hU6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Kt_rZahOkDlhFnnZqc_oK1HqHnsl5e6C08Gt-1nGQbh_JWlCE5I6zQ>
    <xmx:Kt_rZeAxQJidvgT6os6me5AWpOEwZrdfHlSRG-ACAQHtsHqV6VGE6g>
    <xmx:Kt_rZbIYizvmLYJGCmO3pIaHF6wQqfdob5H122G8b8g8UB-Usqx_NA>
    <xmx:Kt_rZZMipxYnGUnL5jw6HDGkTr-ogUVZ9s7E8HdPHtVL3Oc9Se78Qg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Mar 2024 23:01:45 -0500 (EST)
Date: Sat, 9 Mar 2024 13:01:42 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, edmund.raile@proton.me
Subject: [GIT PULL] firewire fixes for v6.8-final
Message-ID: <20240309040142.GA126658@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	edmund.raile@proton.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please accept this PR to your tree. It includes a bug fix relevant to an
allocated IRQ in PCI driver for 1394 OHCI hardware. The bug appears in
kernel v6.5 or later, therefore I expect the maintainers to apply the
fix to stable and longterm kernels as well.


The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-final

for you to fetch changes up to 575801663c7dc38f826212b39e3b91a4a8661c33:

  firewire: ohci: prevent leak of left-over IRQ on unbind (2024-03-06 22:35:22 +0900)

----------------------------------------------------------------
firewire-fixes-6.8-final

A fix to suppress warning about unreleased IRQ for 1394 OHCI hardware when
disabling MSI

In Linux kernel v6.5, a PCI driver for 1394 OHCI hardware was optimized
into the managed device resources. Edmund Raile points out that the change
brings the warning about unreleased IRQ at the call of pci_disable_msi(),
since the API expects that the relevant IRQ has already been released in
advance.

As long as the API is called in .remove callback of PCI device operation,
it is prohibited to maintain the IRQ as the part of managed device
resource. As a workaround, the IRQ is explicitly released at .remove
callback, before the call of pci_disable_msi().

The pci_disable_msi() is legacy API nowadays in PCI MSI implementation. I
have a plan to replace it with the modern API in the development for the
future version of Linux kernel. So at present I keep them as is.

----------------------------------------------------------------
Edmund Raile (1):
      firewire: ohci: prevent leak of left-over IRQ on unbind

 drivers/firewire/ohci.c | 2 ++
 1 file changed, 2 insertions(+)


Thanks

Takashi Sakamoto

