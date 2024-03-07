Return-Path: <linux-kernel+bounces-95881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92B875471
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DF21C217A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CE12FF6B;
	Thu,  7 Mar 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vulfB8oD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5TTTBKR"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C01DA37;
	Thu,  7 Mar 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830101; cv=none; b=TMlPRjpvOZXdRqvuIMzOx1V/TUSl/TgZN6AXfNCDN5z+X1DiwN1A4dqHdqOWd6k5gursvTqRsTlrwcpuopGwnXizC89Rpxj9PJXwMWA+qm4Arlb2yR6lBOCh+Te6oDLjqYgFRzjGMxjwPcszLcDaGcNquVO+mMxR7YkAtxmBUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830101; c=relaxed/simple;
	bh=ha6KNAPit9v7EieX9EpAiZFqUT1Qcl+5YYJweXchLUk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HTa5eV8umuSmJ/DaN8uEVMVQbBdtg4xqqFxWjwBwIUtLSgPyM8d3a+dHjyqnWBwPNdgE3pKlgEe66u/kZCTbKBAteyGLA64IucIyVYBmdOv1liJFcnmtLXWV4cNbXKGX2513l3UmPrD+763GA0+/W9v8/bKgK+Asa9TueeK3/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vulfB8oD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5TTTBKR; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 629831C0006E;
	Thu,  7 Mar 2024 11:48:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 11:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709830097; x=1709916497; bh=WVCGOo2s7f
	GNwjUl/6M3XK1yP4t35yFLPsJJVJkfebc=; b=vulfB8oDcJCnxjDBjJ31OC6/PA
	XGOnDjl6BbVVNq/YpNTPeHJ3N/8/QaHuu+CEcua3P0hDjyabRd18cUsnuZ28/oMw
	FapFH09qjKWjR+vayYNplQ7VOl2MXm36YRt3Lr0Kl4b/2tkFoYtz45rZ8sCsnbgd
	zgKKIsegpwu4HoqW/VvCdn5HZYhKHff8/W9ikOEQPO8pE0071UmIlgv929B1Iasc
	AN6eb/qsYNUEQfi9SuviqQP6x64wja4Lx6OORk0lwyD8PmyZVS/J6FSDSkVihC9b
	ubgMzDrNKzYJPibw1f3GeD/yii8lOVhY83FU0/3PPAy7oxbgyWblvuRyhcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709830097; x=1709916497; bh=WVCGOo2s7fGNwjUl/6M3XK1yP4t3
	5yFLPsJJVJkfebc=; b=G5TTTBKRRaoMs8uI27KsdHUrLGvHWoHJ/awQOS/+ZSBi
	Qc6uVdaT3UYzmnj58w5l9Owk4SvWJwODrmWuDEEmeY8zcetY1Viid9aUo4c2LC4f
	0udFCFnIOyQ+I0zVdlSeWbIG+FrjyzeHH1vSU7Uey6dGBtV47ps0jfb8ibGj7NB8
	ZosZ7xrG6v/E7ikYTDpU7SDMVt7uDj+C+lsZcmCS/ZFneRfbEJMDnn6AI4DVl1be
	4QQWuQs7DIyLfgx9cs681J/1K34xYoNkhHplEcISTwRQGXkm2Fh9CUzXC6TyFR+r
	VvIBa+R3bLvVJr3i/bZEIDDLtCyxoHfU5JUmwA/ZqQ==
X-ME-Sender: <xms:0e_pZQrkVBOxMOrpDvHGr0A0uoMGrhNjrfmVJStFWpOzooUlaOQMNA>
    <xme:0e_pZWowNK3sRm87qvk3uhfN68Md0L8rTrFQLr8WZAEpmcihziFa0BPgkY3RZjpfA
    aulfhmXL-0B_qD-qw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0e_pZVMx0CeDdj1Hf072tY_ITaqWMs-bZajxioRKHiF2CQeQpE4dZg>
    <xmx:0e_pZX7-XLf7C3Jv-uJ9thrOVmajuNDqrEHLpqBo8IPyYI2C0XoWuQ>
    <xmx:0e_pZf5TqbsXd6jDiPv_Ruv33GpIMmhEaY41DZDraF_peyW9lQ0n5w>
    <xmx:0e_pZZsUim1Lij3eL4aDmjtmOe4fqZbt3LKbtNtaRvze9kxCL5ElLZA6tS4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 312C7B60098; Thu,  7 Mar 2024 11:48:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd47619b-e61f-4d89-af4c-5c967fa1ec2d@app.fastmail.com>
In-Reply-To: <ZenuatjkgVhAAybv@smile.fi.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
 <1e2581ba-f7ce-43ad-8e32-c62601c8f5c9@app.fastmail.com>
 <ZenuatjkgVhAAybv@smile.fi.intel.com>
Date: Thu, 07 Mar 2024 17:47:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>, "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Content-Type: text/plain

On Thu, Mar 7, 2024, at 17:42, Andy Shevchenko wrote:
> On Thu, Mar 07, 2024 at 05:30:10PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:
>> >  	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
>> 
>> I think the normal interface these days would be
>> platform_device_register_data(), which does it all in one step.
>
> I'm not sure how is this related to the SPI board info registration.

It's not. What I meant is that you could use
platform_device_register_data() instead of the
"platform_device_alloc(); platform_data = info; platform_device_add();"
sequence.

It should be a safe conversion, but it's also fine to stay
with the existing version if you are worried about regressions.

      Arnd

