Return-Path: <linux-kernel+bounces-123773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64D890D90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E4928D894
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9A13AA3A;
	Thu, 28 Mar 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l+yscp6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCVMfMXR"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CB44C67;
	Thu, 28 Mar 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664724; cv=none; b=GDbSFzpWsd1AGQp7FiZRJmzdkFtJHj4sf561QhK5UIiCGyPCy0VcG4BywwfAv1jpcxv3O8tcbDCbpBkEeSz0d9IAWZUJw/9P+75of/j++6QsnUpD224ob/gJnBbVFjWWbmU3kPsXn8AsIlIF6/upWbrBgpnPnnVYKjyf9JjZ6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664724; c=relaxed/simple;
	bh=ppizF28GJ3LdnDD74TLR2TBswWgmrok26AkI6XA+GvY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qfxlD1jueBlkocGXQ5Y0lpztQ7R4IEk+KgTxY4RdKz8ybPeQzVUvaza1Y/D9AHI7m/QPlLa/q2SF2qrAn3othCr4aFp+RQm4aXhQLiohGivTGL7VzuWh1awaN6Rt4BcDs6WoEhycyhsgVedGiPL+TobV50mKHZollmKZ9qLnqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l+yscp6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCVMfMXR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F2E611400B6;
	Thu, 28 Mar 2024 18:25:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 18:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711664722;
	 x=1711751122; bh=V1Y8NL42FRYoNz9ofpzM8dhY+4wahoNvVAvwDhLdbSo=; b=
	l+yscp6TuHF8ctQPM7YN4/r6EBiPGAVFL8OnAVBc0fM9vQrbW+wP4gLU2BKF6VOM
	8iMUsSCaxSFjrBnOqmyWK5AZio1bTniTaKYqLIRHkxEwxsVxOQ+Bo0P61c4hSVkx
	dIp7bLkLOCig152y/g9kUdQOGE52iKeR8KqGdYLOx5xN1llSBYoPeE7gCiSnle1j
	JyG8b59yJK7GANGRn1wffVEii8YAWUzpKoJR8tVraTIG5+VT6LuM+J9lEEE24an2
	pagvEak42n2XwmcjkFQZ25M4/ayfi4RVbSBl197XvR7d/FBcj4r27xqM6jz1GJhl
	X+uq7fFDxWowL6RCp49IUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711664722; x=
	1711751122; bh=V1Y8NL42FRYoNz9ofpzM8dhY+4wahoNvVAvwDhLdbSo=; b=e
	CVMfMXR+DryLyC83NzLZuRcZOjzDgdQmFMkmnapaPa3G3HQEFvrepNIiomYykBEF
	qhEvXwEGoGnoUrcxqgp9nTcvvyvDdVGRHCgdc129uD0WTzg7MxNuvkdpBDFhVMP6
	D7su0MrQXVWH9FXTzFulqMaF3nk7/9BHDQ4qdq828HLYoT8R5uetZjUq6Y6u/ORg
	cvJPe7yQ9nvUH/hGCLG940Z7S3FsosoP46h7+Nn8T8SYVvm8FQo4j1eep4h1NmJt
	Uvzv5eVhKQRzwjlFcPf1cGCs5MwJ+GTfbb41ud31PJ+iPIFsZ53C1lk9enBwf6OG
	PL3eS/9G+OVZ1Xizqc9+g==
X-ME-Sender: <xms:Uu4FZhxgakoAbyH5Q7hDADDY7-O5D1vSKafJXvGqETUBFTQVV_kxIQ>
    <xme:Uu4FZhQwamuOD9Bg0c6VSbXJc90AFS9C52iUI2KQ1PSSZjTDR4_NtIJsDzdWZ2GRH
    n6KH5o1dWXJbjcrQic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Uu4FZrXIOMXxK8B67rZEhkHYa-f0yEE9zbulKQh0KOp291ZVT7MlsQ>
    <xmx:Uu4FZjh_Pz8qD4PMjMQoFHcEqbVdNU4DznteJDbp3vWe7UmWMYW7bw>
    <xmx:Uu4FZjA_OQ5FZqd6uHWgiuVZ2DP5IuSrGu9shoDKWVXzBGTgSY4vmA>
    <xmx:Uu4FZsKjS95zQaTa74NwjNe2pQbYYhGiksNlLKiw1n2H4WDFKf91SQ>
    <xmx:Uu4FZrY6-mJd6e4vZkG19-Y8vkQbuNkDVpC5dk7oi-khCwClUNzyoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0518BB6008D; Thu, 28 Mar 2024 18:25:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f93c474d-dfe4-4c10-a908-613be10ac265@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8oJ5trNE7na9jCDbEt5kox1rg0mia59EHj+XikHUnay5w@mail.gmail.com>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-7-arnd@kernel.org>
 <CAFhGd8oJ5trNE7na9jCDbEt5kox1rg0mia59EHj+XikHUnay5w@mail.gmail.com>
Date: Thu, 28 Mar 2024 23:25:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Philipp Stanner" <pstanner@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Thorsten Blum" <thorsten.blum@toblux.com>, linux-nilfs@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH 6/9] nilfs2: fix out-of-range warning
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024, at 23:04, Justin Stitt wrote:
> On Thu, Mar 28, 2024 at 7:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> clang-14 points out that v_size is always smaller than a 64KB
>> page size if that is configured by the CPU architecture:
>
> Is this only with clang-14?

No, it should be every version since then. I checked my
randconfig tree and found that I originally committed this
patch in September 2021 when I was first testing prerelease
clang-14 builds. I sent a couple of fixes for this class
of warnings then, but for some reason not this one.

      Arnd

