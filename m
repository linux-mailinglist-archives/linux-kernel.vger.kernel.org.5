Return-Path: <linux-kernel+bounces-21184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561A828B71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E900C286991
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A6E3B79C;
	Tue,  9 Jan 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gi6YF23E"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632D39FFB;
	Tue,  9 Jan 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4B33D221;
	Tue,  9 Jan 2024 17:47:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B33D221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704822450; bh=119owvPStRXntC0wVTBP44oZiyFcNzr43pqlePEwSko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gi6YF23EcusM9gK54kKwwcSuDjx/c+MAthsNbVx1BsvwHgFTOfqTHeIwpAQe+Jz5P
	 rnVRxBKE8an8+NRzAVSq2nsJ+jxK4vhEpZZJ8eGakGJRg9hPYj8UBhYY3o6jLijsuD
	 2p4J3emgywpDQ7U+e1ABfMMoYQVTSUHcs67dSDCXdn1bAim9NfVvf7ImwORSdNrcuD
	 vfchFLJo3HxSuKWqimfcBovSVqwx7PyQm+dn7qtJ6txowb98bhuiYxoARV57eFvV12
	 5enM4xpdgWTDVSlX6qPkvUZ+gmOldkl9DCYvHutAFqA5pvyRH3if/xAf2qnVQ0RQFR
	 AzfzDtBV42cKQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Yazen
 Ghannam <yazen.ghannam@amd.com>
Cc: Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
In-Reply-To: <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
Date: Tue, 09 Jan 2024 10:47:29 -0700
Message-ID: <87a5pes8jy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Nov 02, 2023 at 11:42:22AM +0000, Muralidhara M K wrote:
>> From: Muralidhara M K <muralidhara.mk@amd.com>
>> 
>> AMD systems with Scalable MCA, each machine check error of a SMCA bank
>> type has an associated bit position in the bank's control (CTL) register.
>
> Ontop of this. It is long overdue:
>
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 28 Nov 2023 14:37:56 +0100
>
> Add some initial RAS documentation. The expectation is for this to
> collect all the user-visible features for interacting with the RAS
> features of the kernel.
>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/RAS/ras.rst | 26 ++++++++++++++++++++++++++
>  Documentation/index.rst   |  1 +
>  2 files changed, 27 insertions(+)
>  create mode 100644 Documentation/RAS/ras.rst

I wish I'd been copied on this ... I've been working to get a handle on
the top-level Documentation/ directories for a while, and would rather
not see a new one added for this.  Offhand, based on this first
document, it looks like material that belongs under
Documentation/admin-guide; can we move it there, please?

Thanks,

jon

