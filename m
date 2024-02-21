Return-Path: <linux-kernel+bounces-74839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3285DD03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DB61C23A17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49697E57B;
	Wed, 21 Feb 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KjHA62cN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6sHylUr"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6778B4B;
	Wed, 21 Feb 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524000; cv=none; b=f+DK/RF4wCKG4Mg/6KcZjb21P8OcydGU0OgEeIVYZox4J7/ku/1Q6anRKIjMMY5fNw5CKkd0FODZRHsNugk2pdUOq9AZUTnb1KvDCPpll/uGk00ow1WzEqLimIjDJ0H82866jVRIF+EDQlOh+Vk6u/Kl5R2aCzM784nWPjJGua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524000; c=relaxed/simple;
	bh=UfVoiNEIYsbLpMEbykUi8R7DRApQ5LdQp6AqEhWwq44=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ABy1GyYLRhRn6iY19H6ABsOo5pnoDRo+PmPsBPb9EKZ8FnvuR4FsnGO5qPVzDyzzEPRijZWJmkgUQjr2gESmWfXm5dveQKzdnKkbvFqG6JxDbqQxGML/0AsR62/HxJ4NCK4czdZEsT9r5VqzkrcIxsexVb4q6YiYPfMEq6Zxf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KjHA62cN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6sHylUr; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D488B3200A4E;
	Wed, 21 Feb 2024 08:59:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 08:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708523997;
	 x=1708610397; bh=lCqLbTkRqvWoHbwM+Jq1WD6BnkDkMXqUOkgyLNO9i4U=; b=
	KjHA62cNvV8wq0zHeHB8bt/yfnrM7ig8IaP1ulx2DM62dKQVRGFUgvFMtzNUU6X7
	zr1nVCsUQHSyryk/TuIRUidKpbCDDIQ1X8+lsaZmZqV5NKUoz5e5PkBwCm6QLW1D
	doxYlWRmcJle1DW+IQ2lwh0qMq/FCk2kmFx/nUATwX27Sp1T8uWJB1nbKC8YOrpL
	hrHKqGSgJElGsrNe2T3k8wtSAxlCzf9zaPSyjT+2HJlrAuk7vw/kqX+DhyFXcZBX
	lFhiB3rkoSVWOmQUr6ixlKntUvCoMa+He3oGkESY7egf6SbcI/hmgu7qjULej9ud
	sB8qOOz3cXVJjbTLjWXAUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708523997; x=
	1708610397; bh=lCqLbTkRqvWoHbwM+Jq1WD6BnkDkMXqUOkgyLNO9i4U=; b=j
	6sHylUre7avg4v1SUChjKnv7m1q7EXXfDD20c7ke6mC+z1mkPfpJI/3M9ZjRSznL
	nZ/v1NY1GZy7T5Qif2EULoNClAKrerBDX3zKGxLa9pit8hDKL9hmdEQtkrVPN2r2
	aIVDPV+r7jhpfVL+GPdYQKNrKcG7cO6nKs5dAN/isCqwpDY5+1s9slWJWD3yVnGo
	dzDvpuDHXKvAPPnGwMSG2PB7cJH0aiD2UhA7eq5U3ipTT3andi8fds75G/u4gCe0
	wXxH3fIXAD4wSJObtKDaM8DA+bKxQS8ue+D16vV6z+g3hV8/sEFqmsHYJiikPpzH
	amREV/gWyx8wsogSwxGXw==
X-ME-Sender: <xms:3AHWZeJ_sIf2ys2hhzAE0jsqGrqHWfKP2m04RB1bHhRUmwybWihBVw>
    <xme:3AHWZWKbWYH54JHIafcFS7RQ0TCJiotdmJ35ohcJNNEFBoDV7PaGsagHVk8WlkKJQ
    EU0elm2Q6aQlypkejU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3AHWZeuMecalP8bTKayZVDIthdoCQKox007Gs4MePnbgVVHsNq2wKA>
    <xmx:3AHWZTaO4623tZab6Wp9qHAODYC3_14N7WT0XyRBLu-6CmbycdFlCQ>
    <xmx:3AHWZVbVs6Vg4uZOs3-x2CJ3bO_MGJNvo6WsxHWNmWGI1cn6yqPw4Q>
    <xmx:3QHWZYyJgRF7lRT3-WyKTyVQsN813cuR2FKmUss_OJpCb6Mod_6nxQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C85F4B6008D; Wed, 21 Feb 2024 08:59:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com>
In-Reply-To: 
 <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
References: <20240221092826.748e70c4@canb.auug.org.au>
 <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
Date: Wed, 21 Feb 2024 14:59:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rob Herring" <robh@kernel.org>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: "Olof Johansson" <olof@lixom.net>,
 ARM <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
> On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auu=
g.org.au> wrote:
>> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): =
Failed prerequisite 'interrupt_provider'
>>
>> Introduced/exposed by commit
>>
>>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
>>
>> I guess you missed some :-(
>
> No, Geert separately posted fixes for already.

I did make the mistake of applying the final patch "dtc:
Enable dtc interrupt_provider check" to the arm/fixes branch
for 6.8 along with the other fixes.

Clearly that should be separate and only go into mainline
after there are no more regressions, but now I'm unsure
about the other patches -- did you intend the dts fixes
for 6.8 or for the coming merge window?

      Arnd

