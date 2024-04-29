Return-Path: <linux-kernel+bounces-162739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCDB8B5FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C37A1F22D43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5F86636;
	Mon, 29 Apr 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kP4I71W4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foUbY+h1"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0C2AE93
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411067; cv=none; b=M440XRZKMcdPF2N/B3Z5pBGS+byQCdK6jw5UwcamQW966nSeX/kZIsxKhphx5CcjcqB9chdWTrQzJ+przaw6oNS40dg9YehUN2Pcun03cFvr0U0GbE2QCcPAsxhbVY6m6qLiDGl8oQQf1X+AHh7g8JyVkSPpt6crkylHf7M6jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411067; c=relaxed/simple;
	bh=/AcgWBI1kWNeHnrawu01Ad+zBIAqb/wlbcn9c4qFU90=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KfzdyFa5vTcg7T/amYyZbJocPmyIS3GHXYiXV2T9JHAfyT13y4pF1BB7D0Uq5AECYR0MQ0mfSHaU+RFKghzKK4dwaulX+ZUJOflh5ACCxw8lgPuilpQZ/sP3rNtxg0YdEW4I2MkXDyIjaP5u4ZPhSqDeTYSPzj+jJt2kOyR0P/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kP4I71W4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foUbY+h1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1F6DB18000AC;
	Mon, 29 Apr 2024 13:17:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 13:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714411063; x=1714497463; bh=xekhz3+nyZ
	m8Ea8jq2BOw2Y9kIUDt9YpLlTFfRvHFOE=; b=kP4I71W4xDoQDx+BkSQ7yea4f4
	hfvD72bRwVQrY3vX0+/EyVSSPv3PEXNxCceFghMU9Z0jQ87MY04AqgO9emTp6wpD
	rgHB1lAVNNquGzL+j1n+BaEmoJuVdojvyX088SAGGkOIEvfk65WWwXIRcPcC9tS+
	hCepCeNjgvePBEhhNeih/bPG1mmtLjpqvHGRFFgqX1oPiZ3FihR/TXT2n/MSxodU
	rFxYXtvu6VKyORHUd62WDMM2uE8yHNlJBkJYSrvWRg/FMBTx1LONi3/FanWJx7G4
	nsX0A516+1NExfE3suXN6YN2bamHkng3cZ4FNTot1gFsOt24KvaQTVOgoIyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714411063; x=1714497463; bh=xekhz3+nyZm8Ea8jq2BOw2Y9kIUD
	t9YpLlTFfRvHFOE=; b=foUbY+h1Kw+2NJhyj+bbbpjLzOVliM2psSbkGJSnPVxZ
	eDVqOM8bvNui2udA8VZYNCEUhTLX7Ag96mwjAgzc1MkLxsb76D7d31SgR7+FWpeB
	blC1oHfCwH/xDvszqvU6saKH0dn22GcE/utLcbbr1OpSOyVJYDfmP1hsNvVL4WTi
	9yTabR3cc7NNezoflDqOta5ncWNSaMRb+Z1xGjKeNxdtb8Aerk9q59if7Yp//AIP
	2jU/Uiby0dRxSJp4WP9HvdKcLtMYSJYwzLoAGKva0zV5Bv63dwdT62ffb9VHEORp
	KhAKJwPIuHg+wEXCYppQAww9PXUxl4TRwRik8M/12g==
X-ME-Sender: <xms:N9YvZuQujlCHRkVFDk_Ko3pQg-gFWocstXL4Q4E_pdmKWyJacD3ThA>
    <xme:N9YvZjzr0ESm8KCFwN9Ng9l0D7QeErVoqBRUBzVL5U-aEShP6hfodq4XVbNcuprMK
    IRo9-lMcDiyHEDDLEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:N9YvZr1o_NrUNjHjlr3JIGPMz4BQRgqQ_ztoQg_WsF7foMfIuyyUGQ>
    <xmx:N9YvZqDSsbw-4gVUu7s70n6jXlXtCoQrtewarN4HQ0exaM6DD3c0uQ>
    <xmx:N9YvZngytkJyRGexyKWzG_aXcHP8FB3RCcJTZrpZOpEY9CYiNrrbxA>
    <xmx:N9YvZmrpcTBv2hLIRMe07DA8k1rBtMoyBoGWzT1KPz42DRZ4FjiXLw>
    <xmx:N9YvZsZSbss71b3R2D7NJiqPPmnCX5Q1ubWXFQwkNgSJ_9wXXEEbNdqn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 68916B600A0; Mon, 29 Apr 2024 13:17:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91dacd68-fdbe-4cb4-92c0-e5d6bc777658@app.fastmail.com>
In-Reply-To: <8de32257786d3f062c479a8b10dcf17b775d563b.camel@nvidia.com>
References: 
 <CA+G9fYu7Ug0K8h9QJT0WbtWh_LL9Juc+VC0WMU_Z_vSSPDNymg@mail.gmail.com>
 <c819df1c-4215-41bb-b24b-563a912d160f@leemhuis.info>
 <8de32257786d3f062c479a8b10dcf17b775d563b.camel@nvidia.com>
Date: Mon, 29 Apr 2024 19:17:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Timur Tabi" <ttabi@nvidia.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Danilo Krummrich" <dakr@redhat.com>
Subject: Re: nouveau: r535.c:1266:3: error: label at end of compound statement default:
 with gcc-8
Content-Type: text/plain

On Mon, Apr 29, 2024, at 19:08, Timur Tabi wrote:
> On Mon, 2024-04-29 at 17:30 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> TWIMC, there is another report about this in this thread (sadly some of
>> its post did not make it to lore):
>> 
>> https://lore.kernel.org/all/162ef3c0-1d7b-4220-a21f-b0008657f8a5@redhat.com/
>> 
>> Ciao, Thorsten
>
> This doesn't fail on x86-64 when I build it.  I also did a cross-compile to
> arm64 with the arm64 defconfig, and it doesn't fail there either.
>
> I'm guessing this is a compiler version thing.  I'm using gcc 11.4.  Is that
> just too old?

It's too new: this is valid syntax in c23 and accepted by newer compilers
as an extension to gnu11, but older versions don't like it.

gcc-11 and clang-16 are fine, while gcc-10 and clang-15 as well as
earlier versions produce this warning.

      Arnd

