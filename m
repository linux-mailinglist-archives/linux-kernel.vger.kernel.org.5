Return-Path: <linux-kernel+bounces-119556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C888CA69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5593B286CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7D1C6AE;
	Tue, 26 Mar 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="l8bnMJH7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEy2AotN"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3117BA0;
	Tue, 26 Mar 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473057; cv=none; b=bbClJaACa3tu6dhjN2Wex65gzvxpVSgxi3HBwq9t3T94NNFIfHuJM1BWkTzhpjFa9CFzDS0ce9GS92IoiQp5dm7ekCYrPaYeSTs85riXJGpln2DnlHRnkBxcrNkFuveJ5BaoYZvNNwp002hvYLyFw4uikeGyBuGnntqWIMHaCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473057; c=relaxed/simple;
	bh=80jd1OM0DPKB0ZHLY6XE8+mL/8W0WhAcOu/YBlVELGE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TzllBUrTo5AXJ6xTQixICJscaWI71bY17sxlIhLSfkVpOozMj60rHL6uCWYzieoyHkVGCjAf8YzZKcf7co54/L93186kfZvdsik55G9ZUnoidZBypBxFiEhLTv/jvV9DpMabpEC5B4sPjQuk55AkiQr/13Ym/ECQcqckUKD1WX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=l8bnMJH7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEy2AotN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DCB81140127;
	Tue, 26 Mar 2024 13:10:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 13:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711473054; x=1711559454; bh=52dnMPHzEu
	6IHQ/9AU3OAfVPLFSNsoup+66vLokUHSI=; b=l8bnMJH7gWp7dTGLqLG4q7nyPX
	ZSutsf8+bN+5Jw/XZYFp0votPDUK4/ZRwNpC3yzNXrfZcY08RvbUU/sFxjJta5Af
	/BAv51LnAMjhdFyPeJdBYJtfUD6V279meMgR07QvchH8FZRHPIAXaLmZgHoLigoG
	R0Dux0lskgmnpZHxRUtrVFARZjnX9DMwy20fcauilsRChyqB7YkhT402ISK4Pq85
	+is0NpGdHluaAWMeSi9a5SiJZBMflIN6Ta6vCmoVYXlJcrMNKV/v4W+CfJ88OJs6
	CQBAiocSVpTHOaQtvKwdnuwbDcMuiohNJyOjBgcZAzOB/B8uI5Mj8ANLtkSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711473054; x=1711559454; bh=52dnMPHzEu6IHQ/9AU3OAfVPLFSN
	soup+66vLokUHSI=; b=hEy2AotNdk4tfs2/Ualepk74pmsHfeoOk1BhLH/8ZEUd
	aMvxJ3W+0dlKwyfQxMfMYAwG9O4FxCw+gXArMGIWjXLGMap7oGf8+WML2lvArZQR
	S/BclxWlqNQHjknB9hivQXFS17RrOdZ/syOPBuFP/hTvExpjIfZxfElBHoQs7cOW
	nfuef6zo0Xi9ZkomTo20fkgRzi8X8M+STuEd3e4UrftHFhrgjWt5Sg8oc5rBtPGE
	UhTxZadD31ravTdA/3Qh/8cNHdk8tLuZve9P3jDMtB7GKwvok8rtDs9abE+JfQKR
	TxrkoMnRjRCxrUTtPzUCl6zkE3LHEEDaIZQxxdNNiw==
X-ME-Sender: <xms:nQEDZuPyYWmllRZXVuHR3FgLMjh3Ot2kJoF0CFtdnlJnbW6ti0x-Dw>
    <xme:nQEDZs94JurkJCLqcH76QddhOH1HfFjaTJHmRclI4t1RHuerQ8mOrBgUl3JVZnNfU
    TvRihSddEH9jy40gjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nQEDZlTCHxug5ZVhGWiF04DUY0etbW2NNQWG_s5lHAgLgu63Z4-47w>
    <xmx:nQEDZuuhcFex9DoJb_wOTTm0iHepgJCctECDzO2Zf-6mrYgKsPOBMw>
    <xmx:nQEDZmfXVbe9lvhdzFYhEG3AJuyNTy4sb51-lhfa61wjzVTD86il6w>
    <xmx:nQEDZi3d7ZT4x5w85YpaqRW3I58-M7bxoveMxlxUcfhB-ft3qvEPSQ>
    <xmx:ngEDZjD_zNvLiOWPTjyuMhDSuCPU58uPTYWECwQVqDOwBhoTTGFjzQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0B5F4B6008F; Tue, 26 Mar 2024 13:10:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8e28bc4-f7b9-4e17-ae6c-bbe6166190b4@app.fastmail.com>
In-Reply-To: <20240326130647.7bfb1d92@gandalf.local.home>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145348.3318887-2-arnd@kernel.org>
 <20240326130647.7bfb1d92@gandalf.local.home>
Date: Tue, 26 Mar 2024 18:10:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Nicolas Schier" <nicolas@fjasle.eu>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Kees Cook" <keescook@chromium.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH 11/12] [v4] kallsyms: rework symbol lookup return codes
Content-Type: text/plain

On Tue, Mar 26, 2024, at 18:06, Steven Rostedt wrote:
> On Tue, 26 Mar 2024 15:53:38 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> -const char *
>> +int
>>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>>  		   unsigned long *off, char **modname, char *sym)
>>  {
>>  	struct ftrace_mod_map *mod_map;
>> -	const char *ret = NULL;
>> +	int ret;
>
> This needs to be ret = 0;

Fixed now, thanks!

I'll send a v5 in a few days 

    Arnd

