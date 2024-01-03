Return-Path: <linux-kernel+bounces-15810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A28382339B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DCC1F211D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3901D698;
	Wed,  3 Jan 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S8cBOPo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qYLe51Oe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DF1D52E;
	Wed,  3 Jan 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 564E43200A5E;
	Wed,  3 Jan 2024 12:39:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 12:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704303557; x=1704389957; bh=AmXiwz8LUM
	E91m64esk/QdAtIjEuLeDqTmwpf180Hkw=; b=S8cBOPo0YUOXhtfvbQl/dKlMmp
	spGNpNrq0X7DR1Z/N2hHrSSWtspS3rLy+YRxi9aSMRpk8ZPLpp7QD4TyNdsbYYF2
	xyHxbFVOjHXs1qwFkxfeN81PJMY8b/c/UeyQT2++d22Ogz5AJFDbDK6m0yhSLTi7
	Z3DKTDpP7gYaqZ43iO+3GqL/P12TWhnzS4giFFA9GZZaUHSihyo8Qq6JR3f23Yu2
	XpwGpv4MWaDuHi+M1OTMD7dNisZmF6tYhY886XPY+QqtOCqbC+nPprV6OehWLU/r
	IwIyN+cHfo60HZOL/DRVslfA+ymQFslUDwYDnadol3xnU19WtbGNNdk5HZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704303557; x=1704389957; bh=AmXiwz8LUME91m64esk/QdAtIjEu
	LeDqTmwpf180Hkw=; b=qYLe51OejE4O8CPjq4w8PpeRfhYj45FIxb0C37utI4XQ
	pmVsKLnU95WUUBarcRSTOYBC1C/1nXBlflucmE/1v6/BE2d8cQ4u2NNHLWv/4eUf
	tNIokEP/dyylTacQw4rfGTJI5WNfF68Te8kAsP97qZqWeEInoDwkZQZd+pOg4hl7
	ULCCh0XDsPRhLilaB8BFwRFpDhyK1G7smD9hfMadk9tS33Ma/FyZ5NQbWhJH7o5T
	6SCRAmRXtzgYAglvgzZfp20aEfMx8ng1b24bHHBcjTQqjQ0/4wf+nczqDK/633cf
	2fNEOZYpcvPELfsi6Ogv/VB1QyMaYyi896ADrF6Cbg==
X-ME-Sender: <xms:xZuVZVUhuJar-8WeWKnC-YYGCex-mx5ofyIVScjpIJhelXn7EiM5pg>
    <xme:xZuVZVmrqlKHo8FsOqJPCLwUS8W7L2Y9rsZyl7a4YYzNOz55TK-daxd8jldeCa2QY
    VchgGpZMg444-0AVV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xZuVZRZDCaQsfdqKc0n7CNRjOxD3FrUw3WFcHqXHMTJ6cXpjlYfqXA>
    <xmx:xZuVZYXAYlvSxmRai9aXpDhcI9B0pqRw69UbOeT2HSwtw4fxlAJT0w>
    <xmx:xZuVZfk64679EPjiLJ1Hh0n-QtEqmesaxgITzZKKHOb0mpFiOWr8LA>
    <xmx:xZuVZataAukvJIIRcVXi_OasVXWMDl0eNZeB5Mg0VGgatBo6hEaOTg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0C337B6008D; Wed,  3 Jan 2024 12:39:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a6d441a-54bb-42ed-9ab7-3a7f24c8a14b@app.fastmail.com>
In-Reply-To: <20240103173018.GD5954@willie-the-truck>
References: <20240103100324.05f47bb8@canb.auug.org.au>
 <20240103173018.GD5954@willie-the-truck>
Date: Wed, 03 Jan 2024 18:38:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Will Deacon" <will@kernel.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "Olof Johansson" <olof@lixom.net>,
 ARM <linux-arm-kernel@lists.infradead.org>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with the arm-perf tree
Content-Type: text/plain

On Wed, Jan 3, 2024, at 18:30, Will Deacon wrote:
> On Wed, Jan 03, 2024 at 10:03:24AM +1100, Stephen Rothwell wrote:
>>   static int armv6_map_event(struct perf_event *event)
>>   {
>>   	return armpmu_map_event(event, &armv6_perf_map,
>
> Thanks, this looks fine to me (just remove all the 11MPCore code).
>
> Arnd -- anything you need me to do in the perf tree here other than mention
> this in my pull request?

No, I think we're good here as far as I can tell.

    Arnd

