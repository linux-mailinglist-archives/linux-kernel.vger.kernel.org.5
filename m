Return-Path: <linux-kernel+bounces-101449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A811F87A749
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C9AB23535
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A73D0A9;
	Wed, 13 Mar 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZYnQM7p8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZUqb3sU"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB03EA72
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330813; cv=none; b=Vl9UoxCwYbo+xFHuWlDfWWqV7g0tjQgkRScA5b1JttaOsjWjEwaeIVPzR6P0DYgIFlHXO8JScWi9/PFnzpuAFkTuPEq/rtOofITZeQLrkei5Bi0dHEheJARdPU3i/xqfcWU2FoBHuDiCC5lmB3h7V66hfOfuT3f0B01+tbCW2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330813; c=relaxed/simple;
	bh=6Y76AgpBre4SyVMFQz8Gz8vJ7A93p7tmbyD0hs1nla8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rAGM9s3KTOlJPpwFp6ZXHywvtUBDvR7xBe+k6nwvcoqPACL557kjwMzZglDN0eGe3TEQ4jDfC0Tt2zf5ZwyIcq/RkFJ9BJXvfmmgkh8Zbxqhlh3wrS8HqTf7sOs8Sl57wy6RGLGlY/nx+Eo7nGDkLQih1KpPDITVRIN/t7RX2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZYnQM7p8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZUqb3sU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D6D621380134;
	Wed, 13 Mar 2024 07:53:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 07:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710330809;
	 x=1710417209; bh=gn0b2WKvEfTg/FZ9LXq190CVS7p5sTA5MQLvPVDkM3s=; b=
	ZYnQM7p8x/dP3H+5hWC13tUah5T99wlcWE8gOwezOGhcibshahMJ5psB/nXpI11J
	kjwEu3VUBPQfU5TCmCNMNFZGOcQ0xO3MDxzIK/2kd5Bo6v1BnO4AT5IqU3GO5iby
	M27nshnCWSa7JyT6usf/0VIXG+DYDnrknzaYcyFg1oUXziIClTElvL71abMRpRDK
	H7gvKtv4XpEedSnH0rBSy55tQUq/eQcmP+JqQV1ZiljN0N9r0IAlecQHVscQRSyt
	GkCv31l1hX8AW6X4vgbIW5husbH5zCyFiTeXJQlDP0DNPveoTMD0rf1qwP+K/7k1
	5VhecXmy3tGx5ZOVquwoNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710330809; x=
	1710417209; bh=gn0b2WKvEfTg/FZ9LXq190CVS7p5sTA5MQLvPVDkM3s=; b=e
	ZUqb3sUkme8YY7sunqMcd7kgqEWfeQZ4GfUpMMuwqPWi3qZC7uCjmrk3AUvXF5I6
	sCzYembUcddX4rNT4jppC5CJa9geTUpG2MUT8Tt3jzLwTHlr9cl8wTfDl+BLYfS6
	7IAxclCPexIrBG2BVnePeiPOFON5U34KRQEvpF6iAGRdrF1nimJbq1gKm8jgYWbJ
	QapwtZ3LBd7JWtkrq7TQmYlb21d6CDah3Uf3FgZ8DyMW6jb/fhLiAXkUHkF77uWS
	U1xrPo7H6Qu/ds46blGaA+7yIFSIWUzr5CzwupSlXBNEthYy//0L0cBEo25Iaf9a
	wGDf9Xeuuux7gvDqb72VA==
X-ME-Sender: <xms:uZPxZTU141cMxAzB1qC7B0IRPSUJwJG3UNsdiYYw8SRtDWUf4XWvXw>
    <xme:uZPxZblhXdjQvRXBBwmSjLSK0xXK7OkgwgQ2ImSOV_QTSRzIRhgb1OK8kgux-9EuX
    b2R_iw3t1KOaxewfi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uZPxZfYpe4EJPrxNTPVtS-AjAzTrDk7bd2mdHCVE-zQn1igwJ4sWHQ>
    <xmx:uZPxZeVNzxCRcItYmAYR83vxJAjKHCOls9zlkWWdj1qZeq59iPhI4A>
    <xmx:uZPxZdmsnwm7NkJDATBGK1wi7cn3sv_gkrMacb0qxQsLeW2P4sK2_w>
    <xmx:uZPxZbcqOpW6nUb74efVXhKe6YWnhc2z9lhxGOnHcF3yDXRdmIL8fw>
    <xmx:uZPxZf57wFFPJfrIxMya7jtFJn6lO-PNwRuFGUxiwAbWrwE71s4_pQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 46CCEB6008D; Wed, 13 Mar 2024 07:53:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
In-Reply-To: <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
Date: Wed, 13 Mar 2024 12:53:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Richard Weinberger" <richard@nod.at>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 12:29, Zhihao Cheng wrote:
> =E5=9C=A8 2024/3/13 16:46, Arnd Bergmann =E5=86=99=E9=81=93:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The use of do_div() in ubi_nvmem_reg_read() makes calling it on
>> 32-bit machines rather expensive. Since the 'from' variable is
>> known to be a 32-bit quantity, it is clearly never needed and
>> can be optimized into a regular division operation.
>>=20
> Do you meet a performance problem on a 32-bit machine? There are too=20
> many places invoking do_div, why do you optimize this one?
> Have you tested the influence on a x86_64 platform after this patch=20
> applied? Looks like that do_div is more efficient in x86.

This one was just introduced. The call site looks like a fast
path and it caused a build regression that Daniel addressed with
an suboptimal commit b8a77b9a5f9c ("mtd: ubi: fix NVMEM over
UBI volumes on 32-bit systems").

The way it usually goes is that someone adds an open-coded
64-bit division that causes a link failure, which prompts
the original developer to either rewrite the code to avoid
the long division if possible, or add do_div() after showing
that it is now performance critical, e.g. only called at
probe time.

     Arnd

