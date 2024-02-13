Return-Path: <linux-kernel+bounces-63613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867F853242
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C99B247DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958A56740;
	Tue, 13 Feb 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="unuQtDVq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBNToM04"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBB56469;
	Tue, 13 Feb 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832242; cv=none; b=no1YgM8gWTK2P+wXfeEb2djvv9WY3ZZ4b2q69BzLz5oAfX3M2tQ4FHpsjC/0I8RrPz+tiVMgbrWTJ3YME1N7Kzu332n7MDUJ5w6lin1gZ+i9q6OSF+ZZ3UdCcBCWWNxD56p3Kx9p5BKM26rYWBcBhNE4HMx79+jlAAR1+UkEjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832242; c=relaxed/simple;
	bh=hAI/RtEnxz5YO+rPHDkMMWqK1f5rZxIZeNF15xQSoXw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dnDAIyds1uyyqarR9yQMf350gz1NrZzSKbFcdTPNVn/BPD49myB675bRm5ycRgomFLbhWINVObLp7xKTrrE62Eg6LaihnzKU06WyxmALrRc57hL+bu5YA7HPm75oOCXl16+nLLIq1ncnSJ5NDxFr8L0WtFAoIyTiN3iBVlDmlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=unuQtDVq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBNToM04; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8DB8D1800159;
	Tue, 13 Feb 2024 08:50:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 08:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707832238; x=1707918638; bh=ynqNOXjR8y
	1dh2yr8HydRPsWc2KYj/UPS0GSPXcZdiU=; b=unuQtDVqNTuLd6eR2KOS9x0LUa
	ZCnOyrORrLf47R2Tgml79t8CZkluHqTLMsw4dhk5tii8gYRUf3DEvArA3SkRWidH
	vpR6JtHOdPP+stRDcRlNEDBwkrMrzhTD68vgbVIepwRAYRMYisKH5f66xTu8xWsD
	GlN8ZfrNPa4mzUzVxd1yXOG5dDTPEkVfuA/0Fiqz0NQ48g4nKLfm3mLDbq6N9os5
	ds+H8egFdKNLln1eHLr51ElJ346MN2D000wCPT5YoPFAjyum3p198FYz/1s3mFoh
	C8RIGC8+jmI++U1iOnCQ5HMNE5lVSXv/nuGrtmST3GaLq2VQmC1OEm4xR1+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707832238; x=1707918638; bh=ynqNOXjR8y1dh2yr8HydRPsWc2KY
	j/UPS0GSPXcZdiU=; b=kBNToM04RVX2Ij2JpbIfoJ6QwfFpbpKWHnmUi9nd1AAV
	s3dqGhehPGlk2GVYGaWeZsnNN60xBbtzaYcdqU3tqUGnTMNkvWaVE9VLwxRFZLm2
	WbH2eHGoSmu8MGS9+dBpiuN3SvJEHDmTvcBMY/wIJNKYjMzqnGGKrC7kDmNIVESE
	6MTZH4l8rp0Pf8HlgHcMBSh+Fx30zm2b/CjkEYzdRpg/tNAzEYvU0JUomweM+CXV
	Vf8gegPYy4zit8xsi5Ilx9FkqrEKhIXZGYOK0y7NS1klbSAibus2FVaxk/E/0KMv
	DIv+pM9Cf61JQZLqA8NwrnDaAIwTJBkfxTaO2DqIqA==
X-ME-Sender: <xms:rXPLZTuuIJ6_uqEaURGdk9XkQn6yzrTx6IcZG8wBk_V-aVhQXPNBQg>
    <xme:rXPLZUdNzcC6L6GQoEgRDL0G-BM7DnGJKViCAgw9urucfXZqwVONlPdR1uEHeVUu1
    brNeeADpJQFMaAmNMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rXPLZWwJrFEthMhfx_oM0euiMJpFtXF0iPQWKZrRavmgfZ-5dMc58w>
    <xmx:rXPLZSN3KvNojttHd3sO1J83PKScqN6hj7ZOyCTTotB82NkcO8vwBQ>
    <xmx:rXPLZT_wpRotExbw2dy8ZYsqyZHu9OC7aOaMyPuhtAyyybkYIJc4Yg>
    <xmx:rnPLZZdgV-r18e77g_zOU7xbwlKtxWt0K8NW36AXEJhYE9JADAZ-gYqVvC0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 12A16B6008F; Tue, 13 Feb 2024 08:50:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3370c551-f24d-4d00-999a-99c229d693a9@app.fastmail.com>
In-Reply-To: <Zctb8QOtMuIfMvDT@gondor.apana.org.au>
References: <20240213101356.460376-1-arnd@kernel.org>
 <Zctb8QOtMuIfMvDT@gondor.apana.org.au>
Date: Tue, 13 Feb 2024 14:50:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Russell King" <linux@armlinux.org.uk>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Jussi Kivilinna" <jussi.kivilinna@iki.fi>, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] ARM: crypto: fix function cast warnings
Content-Type: text/plain

On Tue, Feb 13, 2024, at 13:09, Herbert Xu wrote:
> On Tue, Feb 13, 2024 at 11:13:44AM +0100, Arnd Bergmann wrote:
>>
>> Rework the sha256/sha512 code to instead go through a trivial helper
>> function to preserve the calling conventions.
>
> Why not just change the assembly function prototype?

Good idea, sent v2 now.

    Arnd

