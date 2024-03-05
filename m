Return-Path: <linux-kernel+bounces-92698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FA872479
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AC41C25036
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4914946F;
	Tue,  5 Mar 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="y867hByO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFTJ1q3f"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0878BF6;
	Tue,  5 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656674; cv=none; b=FvpzV5DO5x0rnNGC3JCu8a4HFxPn9BwjkQAnS2Uq17IEF0MokZ9mX4BfERK1lU8xc9YJXLds+d3aQ1IkKX1nVpd606oSzWkGZfa/2pmCDrB+IYPcA+0YmGW7uy39bE3bh/FyAut/NPexjTD5W2ws9TU509rfGQoKTm9lE3mp264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656674; c=relaxed/simple;
	bh=47j0dzSAzW5MEYKvxBhKLHXT49ngHPXkavyrh/wLtwE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uQ93rbOQs5satx7nI1ave47xobHNwSLe65PODT5buWMqGHPcy72RrgwhLq0ixOG2Yq8Vi/Q4C8QmY2Yg96l/SxHDYHLr0vKfsjjzC8GUoZY/Adv27HmXDwqOVIpQjHRASNTD8eLnwI2eDzPFGIXL1eUfzvACkdnzzXjngecBdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=y867hByO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFTJ1q3f; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C347213800DB;
	Tue,  5 Mar 2024 11:37:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 11:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709656671;
	 x=1709743071; bh=4+MYy7OZrk0mn8GWXY4I8q6DUEbRnqfsGbwPSkxAdSE=; b=
	y867hByOENgGFnknD+qxt6Ld/N3IMCjlyvyKCoZ3sIGZ8wTAi1a6mnPsxuq8KMq1
	CdODqy244HYamI/6S6Y8HasndG17kRb5ZE1c/TIHw6NhIkO4gmSjdVNIdNQkW9M4
	BdvcfbHPUhXiN3MtXgrVN/+rPakw/OOfgwXThwFbP/Os+pGnRQ8NrKlUemYuQSiR
	vwRcGVWnfEBjBo99bI7oB7XB94pViyoVyhfy94bSwMH9n4oLY8kkhqfX/842Jdt0
	aUKlP/gEFMwYFwNXp7SRKo9gx08vxznpzfbaCcoyOjMulNqGnPPQhW5KuxEqp8Oz
	bRJkKxFebPcpbgpse5oTbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709656671; x=
	1709743071; bh=4+MYy7OZrk0mn8GWXY4I8q6DUEbRnqfsGbwPSkxAdSE=; b=R
	FTJ1q3fzCgrr8z5nU3v5Ct6180xNjeq0/DUbMPBZS4TdrzVJl7jPpNLHyFy4gzs1
	3UQ/JkN/y55NEVyhZsOcg4lP6COl0CBjMt/wlpwKEeQiMTlxw8hQEnpJnMaAOPsQ
	lJbFh1dZXHB92Uyy5Fb+eiP7tiWHjBIRHpt8SxZ2FwESX2YC6mvW97nF3kLrTLD+
	IQOeeX7I/qSe+8FjoNLFzknjUUkCc5drBUv76BB4LqM9oedtrbU8tiBP7gOJoMxj
	Noh3DOJYviBJNvUeAOSPc6c8veW4YbpJcNcyzd6CmnvcQjS+IQ8fVyjcZaaff90o
	oMKZ60RA2ooSH5p5nuNgA==
X-ME-Sender: <xms:X0rnZd8c4n7AeOviEvoWHK3P4Wo5VuiwQ29r8ENvMaEtKCzqleeUAg>
    <xme:X0rnZRvBwHNYnkc0D7XU0bW70HliKsbZa0trDgcxMWOA9opPNflL1_I4eIgGQCrt1
    eOV2YCKy5TmwYHPr9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:X0rnZbDS1Nz_xHjQg_GNHoHvLXN-uPoPzfCTcckATpolIxpmtjLk3Q>
    <xmx:X0rnZRdBC1vJcCAuGF4U_OZwfShPUE6C-9fJRhc8JYEE4M-A95YHIw>
    <xmx:X0rnZSMlvQ88KLM-elNG2nbnAwAbNhUPJiWScd_q87DdQTS4rM89fg>
    <xmx:X0rnZXfgUEKc4_IsZHD2BemYzbNeYCCbfgg5JTaF6KNPgXb4LJ453w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6DFC4B600BF; Tue,  5 Mar 2024 11:37:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1859f2a9-b3fa-4d41-86e6-aa0a18fddad4@app.fastmail.com>
In-Reply-To: 
 <DM6PR04MB65759DF9CAF6ECB5BA78E138FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
 <DM6PR04MB65759DF9CAF6ECB5BA78E138FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
Date: Tue, 05 Mar 2024 17:37:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Avri Altman" <Avri.Altman@wdc.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Jens Wiklander" <jens.wiklander@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
 "Shyam Saini" <shyamsaini@linux.microsoft.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Jerome Forissier" <jerome.forissier@linaro.org>,
 "Sumit Garg" <sumit.garg@linaro.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Bart Van Assche" <bvanassche@acm.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 17:33, Avri Altman wrote:
>> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklande=
r@linaro.org> wrote:
>>=20
>> I would mention in the commit that the subsystem is currently only us=
ed with
>> eMMC but is designed to be used also by UFS and NVME. Nevertheless, n=
o big
>> deal so:
> Moreover, as the years went by, the differences between mmc and ufs=20
> grew:
> In mmc there are 7 rpmb operations, in ufs 9.
> In mmc the rpmb frame is 512Bytes, also in legacy ufs (up to including=20
> ufs3.1), but in ufs4.0 onward it can be 4k with extended header.
> See e.g.=20
> https://patchwork.kernel.org/project/linux-scsi/patch/20221107131038.2=
01724-3-beanhuo@iokpp.de/
> In mmc the rpmb sequence is atomic, in ufs not.
> In ufs rpmb is a wlun in mmc a partition.
> Both protocols support in multi-region rpmb, but there are some=20
> differences there.

How sure are we then that the user-visible ABI is sufficiently
abstract to cover all the hardware implementations? Are any of the
changes you mention going to be noticed by userspace or are they
only visible to the kernel driver?

      Arnd

