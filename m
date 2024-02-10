Return-Path: <linux-kernel+bounces-60356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420338503A7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D3B1F24767
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42E364AC;
	Sat, 10 Feb 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7mAoGW9"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF6364B3;
	Sat, 10 Feb 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707557522; cv=none; b=dnmmxnaDPSh6+mwajhb1sd1Ez55xoJNOuDnMAzXehPUCpXG6hc7uumeUmdnqJ9eT1K7Up/7brjVh5R8TCxCysyKaIpMlrL6elDUupS0cdYuY2n5dwcxrUq5XxzSDYVD53XdZnDkos0qb0mV9v5+6bNyBXs56Oas/RZBsiBoFNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707557522; c=relaxed/simple;
	bh=TP9W4qCq8hgSVWD+ohqGLyVeD4l5sBB7DBV8tYBFOBA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aKoQSpcyjdMwIZTu9JS4dnDDSG2zpgu19iB1YYNtj8mFgDBu1w/HrN1nNQ4jYM7VES7j+6F3dN2SqY81ohd803A5NOB6ftYOt7T5fTrnwKDaWri9gtpuZAJRCZoJsTC6NVThGCcUv0EOLcCHxKQo80nZqgWRHs3hGK9LtPZQmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7mAoGW9; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B1F445C0077;
	Sat, 10 Feb 2024 04:31:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 10 Feb 2024 04:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707557518; x=1707643918; bh=we3+CNIp/sCmExVts2CpdGbhGFMZ
	ZEqrf8Zzk61UqYw=; b=k7mAoGW9Pzm6fLDCrX/8udswlMtlLI8f16Z0dsWLV1aw
	6UEH6kq3mLRz/9T93kjud2ONbUAAQ6U1fsd0PM00d+YuVfF6IiN+RHi/yS7MfGnQ
	d1iT2kRdK7jnvjXNckVx4Wgs/c0VTo2pLRYnNlupWwtm1ZJaoPK3kqquTaqn88Di
	CcgdwidBw7lZ9uhAyRHlw5gvX2HtZcj0hGBTIoSew8zMEY7nD/3zJ6XJfROQ9Yiv
	0tMEU3QRnqAf699kzuAZryF3fhBSafwrzqH9ifbjtPUr15zZiA1Jsg2xTv4soSoR
	IQ7w45GG9gkyY1q5PlhpQ+xj5ihstfFfmUGCi/7SSw==
X-ME-Sender: <xms:jULHZQyfUifbzIt4LZvH6rY4CqmoZsdGDyzHgfKw4dEkpLKqtNyRcQ>
    <xme:jULHZUScGEiDsXxsJyx8I38K8F31t32CBfMDWgiwGvYI8YN3HPxMHY0t5IfhcAnHw
    566Ddfd__Df7DCnXPs>
X-ME-Received: <xmr:jULHZSX578yw010Lg8RVAMN9gayfDBtMKo16DyqyvdrXuWlhZfgSeJQaARScsSwu1ND0FD2bN3SHU4PDwWHp-3n1R9cgjzJX6pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdekgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:jULHZei-A-VewmnbNE_NrtBkSvzwRkLiOl-2pMjazrDO2EnrQE-l-w>
    <xmx:jULHZSB9QEoMCcHSE1PvprqZvDi4_lu11w368Kb5WxyFSWH64OeUYA>
    <xmx:jULHZfKiRijmbauWA9RIS5CnlPYW1KA487OfpSXGhMjx0CB34JBffg>
    <xmx:jkLHZe10U-Wb1gXUvZUpvxpOAuzcEaJVaiQiaurh3Yjsi-dO3aRuCA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Feb 2024 04:31:55 -0500 (EST)
Date: Sat, 10 Feb 2024 20:32:18 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Lee Jones <lee@kernel.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>, 
    "James E.J. Bottomley" <jejb@linux.ibm.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, drew@colorado.edu, 
    Thomas_Roesch@m2.maus.de, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
In-Reply-To: <20240208102939.GF689448@google.com>
Message-ID: <0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org>
References: <20240208084512.3803250-1-lee@kernel.org> <20240208084512.3803250-4-lee@kernel.org> <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com> <20240208102939.GF689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thu, 8 Feb 2024, Lee Jones wrote:

> On Thu, 08 Feb 2024, Geert Uytterhoeven wrote:
> 
> > 
> > Confused... The return value is not used at all?
> 
> Future proofing. 
> 

Surely a better way to prevent potential future API abuse is by adding 
checkpatch.pl rules. That way does not generate churn.

James or Martin, if you can find some value in this patch, go ahead and 
apply it. I'm afraid I can't see it.

