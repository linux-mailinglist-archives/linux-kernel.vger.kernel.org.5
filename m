Return-Path: <linux-kernel+bounces-131322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE089864B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D899B263BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733DF84A3E;
	Thu,  4 Apr 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CGoMWAsM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFUVoPzS"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E383CA2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231035; cv=none; b=nZQt7Iel8GofToEs0quMhutOX98vUzMhzj6LOy/ya1h6y4fDQe/VvcrVIhWSf/xSfvJ8txIOw4DybLM3hVnzUmiRpAEuOHd+tTmfu5qd4Sd5RpD/HMmatwHJhqYjIV8BA0XkcekpXCgjOCNu5HXpZykv1Jgu1BIbQtPziHGsmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231035; c=relaxed/simple;
	bh=JS/gyrihL+kmuZx19if6yfZwNbw5WpGkmW5rUpwhV1c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mwnWsXR4xep8WwqEgVEihW+QzVFuDFhjIqFux6v1ksTF5iLuxE+kPtWfmkLRHNzYI1zIrL3TFruRguW+iDhatYePoaVVNAejaDlCb6gnKTNSvyXM8w/RHX7Yh1f8ULpHEJEjxFbmUGwSlLeshycLpuIh4MSCxg1Ua9d7xMwBdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CGoMWAsM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFUVoPzS; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 87EDE1C00089;
	Thu,  4 Apr 2024 07:43:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 07:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712231031;
	 x=1712317431; bh=1CDCHaWEhOkiYy29sYtgzdL6T7tUW4lcGYamlcwuiRA=; b=
	CGoMWAsMcxnS91IP2ezijTguxET+DbB/PlHjKKDN272tv37GjDpNXaOywim5Gsrk
	aqx2Wt0nZorSAPAr1yQaGdruX5+7A+UkkwGNNA/KZwX471xoSuV5qNuK5RjVx9if
	0Mn9lWFi2NgjfmobKQ56bGyOu3vaUhuXNDCRLza3BtXLE5XIVycUZ96LvI4f6daM
	QGwB16ScbhKDW2J/veuk50i6C4HmckL6Wvoi+5JwmyjoZp7CxgTzU+Vd7XLLuz6F
	2Bs7E6XFGMReQUFLAWoJ42B6uV3+UZSrASFlk/qJBxssqonexDaFNGAWLEhX88UK
	RFixypeC9SgfjnuvHGb5Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712231031; x=
	1712317431; bh=1CDCHaWEhOkiYy29sYtgzdL6T7tUW4lcGYamlcwuiRA=; b=l
	FUVoPzSYVN/yp8KUfA519NK13OXcwH7OOVsJuD1VxLqrM9Gty33ekJSFhWRMfK4Z
	RWumwKWHpEKYNQJj2MLL9x51COonCbzikphr22HegyCOQoom7DGwlrzMtQQ67q7g
	IK9edbvGig74BPRXMRoXp0ECZMmAjluSmH0G4zlZ5y9fI3XatkZZcHwkk3R19sxl
	RUqN1F5loLbFfeCjDaiQhYtXwyiyYHghZpCak6cdanKjdjDTGfPoCK2FMnIbqfFf
	B804BMqlVaC73DElyBQ9XjZA6bQHDKk/NoIOptn6YIIllNvLmJrxaP9UQbNJb86/
	NbUZFPdE0T+RqTo6Xg4xw==
X-ME-Sender: <xms:dpIOZsaun6lL6Z_HQrLFY8iRRUxKheisiZNKOEvsWZS9FbRN8DxwLw>
    <xme:dpIOZnZqgcp9t3lfD3zA7NTrErVcbC_iC7zdn9Z3EBxYO4-K7sy5bdBHxadj5feME
    uwp5nOTty0iVenB0rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dpIOZm-w6O5WJDGy6ekJBo97oK0jK393UnL7miSQNgbighTr0mphVA>
    <xmx:dpIOZmpFzvTXNxVEEGHfw_1fiu0ZXEAKdPMXUmnYfhJRd3m4Zv7Ixg>
    <xmx:dpIOZnqOLLQ-SekwYwmYhItplWqUr90MNfHorFFJKk6yXvoVXyiniw>
    <xmx:dpIOZkTiWGR6LNeoeUa6gYlG4pelZbeskkjI7q9F14BmoSefCf86gg>
    <xmx:d5IOZreScETdub_vsHYl7SRwbhsBu1vlv38LI8O-ULfptkFCl9LF-zxX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 57F08B6008D; Thu,  4 Apr 2024 07:43:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f79f3bd-e60a-484a-92b7-f6a26f845809@app.fastmail.com>
In-Reply-To: <2ffc8633-6ed8-4641-bd9f-313645dfff51@csgroup.eu>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-19-arnd@kernel.org>
 <66a1d5f1-d9b2-402c-826d-955370288037@csgroup.eu>
 <bdcabb75-f9a5-4905-90b4-2c9c2cf0588a@app.fastmail.com>
 <2ffc8633-6ed8-4641-bd9f-313645dfff51@csgroup.eu>
Date: Thu, 04 Apr 2024 13:43:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Palmer Dabbelt" <palmer@rivosinc.com>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Noah Goldstein" <goldstein.w.n@gmail.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>
Subject: Re: [PATCH 18/34] lib: checksum: hide unused expected_csum_ipv6_magic[]
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024, at 11:03, Christophe Leroy wrote:
> Le 03/04/2024 =C3=A0 10:58, Arnd Bergmann a =C3=A9crit=C2=A0:
>
>> On Wed, Apr 3, 2024, at 10:41, Christophe Leroy wrote:
>> Yes, I usually prefer that approach, and I think I tried it first
>> but ran into compile-time problems because csum_ipv6_magic()
>> is declared conditionally. Let me try again, maybe I misremember
>> what I did or I can remove some more #ifdef checks for this.
>
> FWIW, before replying I did a build check with pmac32_defconfig=20
> (powerpc) with CONFIG_NET removed. I was able to build=20
> lib/checksum_kunit.o and objdump shown there was no reference to=20
> csum_ipv6_magic() inside it.

Right, got it now. I was confused a bit by CONFIG_NET vs CONFIG_IPV6
given that the common definition for csum_ipv6_magic() is in
net/ipv6 but unlike other files there still gets build when IPV6
is disabled but NET remains turned on.

I've done a little more randconfig testing to verify it,
sending v2 now.

      Arnd

