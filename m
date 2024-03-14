Return-Path: <linux-kernel+bounces-102947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F287B8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0921A289211
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29A5FB9D;
	Thu, 14 Mar 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="hBoLVHzW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khkqkkxh"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB85F866
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402578; cv=none; b=cI4L2/jPAMte0lmJ/A3J3dBXFTjylSLyzGLrb50JWUXYveYLyYbPJz9DnyageIBBcIZqPLsuFHGHpp3/JaYUc7fHnxPc88+5fCWUhqVUFdXYCcL2u4N1iX9SbKtekZIH2PipLrrtO8pFqPhgXnHqvzN0DYh2zPQuZmWKLIlR704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402578; c=relaxed/simple;
	bh=eFzKJGcTUwYXn5hAxNPYqKluD4AtrRYvx3RqPw+fqD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a9UDTkZZT1DXSB5BA2Da4rnO4CKYYviGp+HLxX7YMJjd+f8BlfuawsyVexPUQvrUatm405pB3D715huCUSm0OlN/AwGOA7GtNwIuIbf59CpeXCzRt0bynxcePzbbMEWuOeAsi5F1brFvs51PaYEUhEn54vkX+oIzMhiWILkkNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=hBoLVHzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khkqkkxh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4B594138006A;
	Thu, 14 Mar 2024 03:49:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 14 Mar 2024 03:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1710402576; x=1710488976; bh=eFzKJGcTUwYXn5hAxNPYqKluD4AtrRYv
	x3RqPw+fqD4=; b=hBoLVHzWZMOW7v8w3KEqmi7MJDckEd0KLubqQak0nNxGSLq6
	EZjdIkaPCTmXAOWQT4sEvg3UHwQ9Smq/9SS625opDwlDyr86wTdqKZq3UdpHrapf
	y+tAjTXcSoMbmhO7i+Ar9DqYq+k7HPZSfLvpJDKLAcUFSQZsnzJj3Fsp+5gUwwQB
	W2yKieZN30BFt4X5EOqrsiAid24owuJLgY7v5jC8qQhNLfFCTW/FsxYw8GRmxSvW
	047rhipyCWqqntVCxKLyia/y+X/7eOwgPbdo2gaS4jgXJjGgM1FD/kY0VlEHMthk
	MVg87RKwwvqYEnyUmUBlae7idkBG5DLf3cIbMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1710402576; x=1710488976; bh=eFzKJGcTUwYXn5hAxNPYqKluD4AtrRYvx3R
	qPw+fqD4=; b=khkqkkxhzgn+acuDvZ1+DmOf+Rlf7+40P5Uhd8HOdUmUkk342Mr
	9/k6p4Ozp2XwoYQ29/U4fE+n9cBInFYeGgzkz+NaCBXbo94ZW2+54xseriUD/Ydy
	Ms17bGa93b+tPku77xZAIJ4qv/OpoIHOjWAVENayNGwsFGmgjpVegpKSyXcMiBb/
	AAUhA3wAXHzYHuANXfiUg9DWZvINPhYhf+R3aM0B7jgvCkSh0vPn37Ej7vh3cPiJ
	+We1UcQXsHw7WzpiXETSYSuKmLu92xOVBI7YyWQUXzi+WPf8ESOnU8bFk2HZGIGj
	zRuwxP3cjuDEfkG4I18z6Kd7K7YzdxfNmng==
X-ME-Sender: <xms:D6zyZQkJ9AA3DlC3svyrzUugBLtt_FT4RysFrQaqoy8jGeTMEp45Jg>
    <xme:D6zyZf0KSBIXsAkhz46Ml9rXi_hacXR-DL5O27vU_xoV9tQZPOkt9nwUPg-Ao0tNr
    VK1ng4bljfums_daQM>
X-ME-Received: <xmr:D6zyZepTKAFwQK6p5VbGSs6pAa9D5wZS5xwDynvjMUbeonyJ3L-64gSMEGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomhepvfihlhgvrhcu
    jfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvghrnh
    epheekvdehveffvdefudefiefhveetieekvedvleetfedufffgfffhgfeggefhkeetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:EKzyZcliK0at3ljym3fy80BdOMQBixcPJlD0_c2CDNbSzPXkwI92WQ>
    <xmx:EKzyZe1pyXaEBXBDQomJEKwCkUpHlabv833CgJxR_bZ-6oQiSYEYeA>
    <xmx:EKzyZTukTzZhp3spMjAHDWY1XlVk3RnRX7ltdiDDG2fB6AmV7v2M8A>
    <xmx:EKzyZaWAd7Dbbjpt9mGSGQWa3RG7N98NZB4b7_6eDUwBxCr1zaIMmg>
    <xmx:EKzyZXtRwisssyDxdyzPRwVU3UyD1DcWf8TA1Z1MjIYVXOJqlE2Uzw>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 03:49:35 -0400 (EDT)
Date: Thu, 14 Mar 2024 02:49:20 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <ZfKsAIt8RY/JcL/V@sequoia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Given that drivers are only optionally asked to implement the .shutdown
hook, which is required to properly quiesce devices before a kexec, why
is it that we put the ARM SMMU v1/v2 into bypass mode in the arm-smmu
driver's own .shutdown hook?

 arm_smmu_device_shutdown() -> set SMMU_sCR0.CLIENTPD bit to 1

Driver authors often forget to even implement a .shutdown hook, which
results in some hard-to-debug memory corruption issues in the kexec'ed
target kernel due to pending DMA operations happening on untranslated
addresses. Why not leave the SMMU in translate mode but clear the stream
mapping table (or maybe even call arm_smmu_device_reset()) in the SMMU's
shutdown hook to prevent the memory corruption from happening in the
first place?

Fully acknowledging that the proper fix is to quiesce the devices, I
feel like resetting the SMMU and leaving it in translate mode across
kexec would be more consistent with the intent behind v5.2 commit
954a03be033c ("iommu/arm-smmu: Break insecure users by disabling bypass
by default"). The incoming transactions of devices, that weren't
properly quiesced during a kexec, would be blocked until their drivers
have a chance to reinitialize the devices in the new kernel.

I appreciate any help understanding why bypass mode is utilized here as
I'm sure there are nuances that I haven't considered. Thank you!

Tyler

