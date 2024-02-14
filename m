Return-Path: <linux-kernel+bounces-65034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351ED8546F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE7D1F21458
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133AF17581;
	Wed, 14 Feb 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xOdXveQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUvDXvKg"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274917580
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905850; cv=none; b=OWdKo1lAyhRpuIfcgUEK61PNxOMzp3W3smxMzJvvUihYNNsQ0qpxTwks3Nu/XrTnTa9ao+S0515m2w14O8NNrn2fxGyJhmTlfXsILl2pEJe1g0cXQju87GKW+QpYbZtbjpKwGCMFy/TzhbjQNK592LhtxBFZ0yGHJD9FFul0hVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905850; c=relaxed/simple;
	bh=tF6IXKCqjxbLzL3JRjtaAZAl1feEOlArq1Zm4Hd+t98=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XMJVGgWgdnh8CD99mlfl9bnuXS9O0JL2R2bFeNphQoKkFrhxhcMwVeL0qkUpqoRiuZj3s7/8XcpNF6I6sVCiGWcw3bYo+hs93ejhe+7BpJxZjddB65FwD5fzeHmibE1JqlPbd5XHZ3zctZnPOUtNhhR22AqV6LglIgaoI5QDSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xOdXveQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUvDXvKg; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 78AD75C0080;
	Wed, 14 Feb 2024 05:17:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707905847; x=1707992247; bh=OMZ0Sc6KnY
	WJsxgi2D/x8hr/I1TaVgo4y22K7hhj+hA=; b=xOdXveQNMsq7u4FVs5F8YI0X1M
	74d4/YxDVQRkkd3qcLRz9GYEJDtOI5w76zxrfYrDjCpgZy4VZWeSrhbi+4G8hfbj
	4jjhhMcJYJ9fc+m91HV7mT642czzIdfuzdntjepmDVzweYZTM9FuQuMnOfTYTg+/
	w5g71fF0KrmBeZ147rlBnndEIYMbPLeCnZw47wGr/kcSsumuBK/ZEEIWJulvmBOz
	3Bv2+XwJnKbtG6ZoHHA9TyryDgw5Wgzht1GUcEjgpS+zBvUVDycmMCr5G0jsOXnu
	GFgC11g2QLAljjZlCLmLj2j3DkW8k2ocxqYWDviof1T6frLbmOd5m7FOveMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707905847; x=1707992247; bh=OMZ0Sc6KnYWJsxgi2D/x8hr/I1Ta
	Vgo4y22K7hhj+hA=; b=MUvDXvKgZRqBuVe13kS9n0to3u0OvqWI2OEvgxFz6GFi
	3Ojb4iUAoHerooqhOAXz12Xr8WpPWhJqECC8Mg2k3HCkywtUFPW2x6VsvmTDoN2q
	3KUQkaYSj2lmwkSKKEHSf1DeB47C1iPN+cR6KQQ0RYJDGCWQG5F15uy/zQahCmLU
	7fwkkB2KiHB6tdeYyJ1RCqQUAshA5Gjkn08LPOoZLB0JXtYG+MuEb89fLm4vQkAJ
	hTyl5Smcfy2F4qXuF6fMX/hblPGAXOSqM/dUuSCxpDHp+EElhnJTzoEPSYlcqDaf
	Z+YoDaYP4Wy8ip4wht4w/rA06i3lO12BRHJBfuVZ5g==
X-ME-Sender: <xms:N5PMZcdRhdbXUICO1PAgAcRpD31z7FDms29Ob-HYZh3i9tX86LE_eg>
    <xme:N5PMZeO3pluNBa5Xincskk608P2mI1HqpkZNtTPJtlvzKwn1Ii_gceSGWycLMUt3z
    YrkxDRjH1kVsoerD1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:N5PMZdiV1iVxn7X1zPHnTsDbaOp-vDBHB38QvaIdBVPDxwdA2ufvkA>
    <xmx:N5PMZR9JAZ9lhyACZZmPqd8YDqZq0wya8GT6wKGu63NuYzsGbVuQaw>
    <xmx:N5PMZYvAFWJiIKaZpqss_riXY0IVJwX9EHSTHN4QfRFVL_gxKm6Vfg>
    <xmx:N5PMZaKdFHdTYJgvBAztyAeJvVWjWFlvBapqPoG1EEk1KOkE2rgL2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 05A3AB6008D; Wed, 14 Feb 2024 05:17:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2780b965-02fe-41fd-ae16-98f7619aeed2@app.fastmail.com>
In-Reply-To: <20240131033028.3099156-1-dawei.li@shingroup.cn>
References: <20240131033028.3099156-1-dawei.li@shingroup.cn>
Date: Wed, 14 Feb 2024 11:17:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dawei Li" <dawei.li@shingroup.cn>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Serge Semin" <fancer.lancer@gmail.com>,
 "kernel test robot" <lkp@intel.com>, linux-kernel@vger.kernel.org,
 "Dawei Li" <set_pte_at@outlook.com>
Subject: Re: [PATCH v2] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Content-Type: text/plain

On Wed, Jan 31, 2024, at 04:30, Dawei Li wrote:
> Kernel test robot reports following sparse warnings:
>>> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse:
>    incorrect type in assignment (different base types) @@
>    expected unsigned short [addressable] [assigned] [usertype]
>    memaddr @@     got restricted __le16 [usertype] @@
>
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
>    expected unsigned short [addressable] [assigned] [usertype]
>    memaddr
>
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
>    restricted __le16 [usertype]
>
>    .....
>
> For data structures needs cpu_to_le* conversion, their prototype need
> to be declared with __le* explicitly.
>
> Declare data structures to __le* explicitly to address the issue:
> - struct idt_eeprom_seq::memaddr
> - struct idt_csr_seq::csraddr
> - struct idt_csr_seq::data
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

