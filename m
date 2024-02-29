Return-Path: <linux-kernel+bounces-86343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F7B86C428
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E081F228BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C815535DE;
	Thu, 29 Feb 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="N3PpXAZK"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD353E0E;
	Thu, 29 Feb 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196552; cv=none; b=txZ81Vh6vfg/b05us7kEwuBpqpVojNsN4kPDsVSRY6WMRA7EHX36jwpwRFCX7ynIh8PbdSvTRZ0x5FNioi8r7qOnK+bdBICCcvpT8cmywBhioiLzDXnyqnFKgMDNTBPZA0id+fGiadBfds+ctjlhWRshnm1a3y57NcHvOyw7thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196552; c=relaxed/simple;
	bh=4/3+nGo1+U3HuGGlHQWBB2FCEmUbzJiJT/q38cbjCXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WPx2R00kp+9EGbcYrpf5eVNMWcZ5ZX6GCugzwN/XEcIkH7iNTrJuruBeoPK+n4b+IYH4uKUKbXYoQhQhxGLdC3HJg6On31cAyaCRzg+bjj2up8MXTNQOQqEZgT/Y/sUnNYUsc0jz+3bFZZCPg0mtjRPbuGjVjnsDVYosZOvAsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=N3PpXAZK; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=4/3+nGo1+U3HuGGlHQWBB2FCEmUbzJiJT/q38cbjCXE=; t=1709196550;
	x=1709628550; b=N3PpXAZKTVaI/EqOKmZPPbd4G8FucOT4aAy5upzK5eiIs/0d7rBzPqvRTwToq
	aYGjJAFU8v5Z2VjADDopxTac/VUo1ji3IMnOVEzOuK+9qaFNNDDb0Ua/KJxf8PvjsbHxj3h38Y0ao
	Fd4EwikH1PINVclhxK7oiXz3Wbs2bnChikOJhOZDjo1WAppeJSGOHhl8hjG+U7/ReBjhu8xIdWpZR
	94E9vZt4ATLD2ildqzLKxS6f7WCQ5kOxBsoWXSBuA7EmS2pQ/ZpD2vomTg5w4wbdbqGhJ88BGBL6T
	8R9MQbWTQbrJ8UwzrD53dGYUIEsrCFjTpqhCxE9eEfymR94VLw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfc6G-0000N3-Ge; Thu, 29 Feb 2024 09:49:08 +0100
Message-ID: <f7f6bcf7-c919-4077-88f6-bfffe112ba72@leemhuis.info>
Date: Thu, 29 Feb 2024 09:49:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Continuous ACPI errors resulting in high CPU usage by
 journald
Content-Language: en-US, de-DE
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux x86 Platform Drivers <platform-driver-x86@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Stable <stable@vger.kernel.org>
References: <Zd2bsV8VsFJMlbFW@archie.me>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zd2bsV8VsFJMlbFW@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709196550;e1254115;
X-HE-SMSGID: 1rfc6G-0000N3-Ge

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 27.02.24 09:22, Bagas Sanjaya wrote:

> On Bugzilla, danilrybakov249@gmail.com reported stable-specific, ACPI error
> regression that led into high CPU temperature [1]. He wrote:
> [...]

#regzbot ^introduced 847e1eb30e269a094da046c08273abe3f3361cf2
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218531
#regzbot title platform/x86: p2sb: Continuous ACPI errors resulting in
high CPU usage by journald
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

