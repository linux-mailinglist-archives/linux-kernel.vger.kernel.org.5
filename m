Return-Path: <linux-kernel+bounces-140237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA6A8A0F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF6287473
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADD146A70;
	Thu, 11 Apr 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="U/7SjFkV"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164C1465BF;
	Thu, 11 Apr 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831019; cv=none; b=neWJqg0oMjvfDS9lBWPBpHaAAZq5ZS8h2VQhlOX8Op/mylp0ZlqHM+EM7gLFXzfmBvsJXKfZZ1yDWQNHzlwmFTIRRRckPgJVeyObqP6DOh7jVwtfWyzLHQHTi+0uPz3floKRsJVOo6EvjuOOx98eI4bF53ysmQWLf4gc4z/HiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831019; c=relaxed/simple;
	bh=ecbjjoOy5F39eQ9WgUqeBFNeP6wtXPnotCRhHM79jgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLn0DwbJYl9AcG+Zmr3QJ84WkIpzOg/oG5ACTXa3Kp/fR0HqoGK9G44nzrwRIeZsL/9vb6rxnS+4MkAroS4jU2X96RfOaPOfjY0JA9Hfn45SMX3f+H+tx1eSl56Aa8HISznPIbqKz/hWzftbmd6Q9nA7fH5LoF9M8g6WQE2i8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=U/7SjFkV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=1jo3RySe4FCzmCdABXkocaJOOLEAMkP9JkEnosbLYV8=; t=1712831017;
	x=1713263017; b=U/7SjFkVjwpkb9gE4ThXFi3ZEdyxNrPapoYyiXkTgdHOhI+XdGZNrSwhVV1n1
	KezT4sffna395BbIzZe9eBXcHRunwhpFJkK9MM/XTee7QFagsxhrcEaP/O99/zZ+jsNHjB7ILp6pn
	hOa1yB5qW4DaAsDV8OkI5dfiLJ5clF9GWqK2Bqw20RkoHQ224aRfi+p0rMNCfoPsAx7hgdrPBnKdX
	vRtzI3176AWVBdJoaDe+z870oJg2m+dg0m3IRzXZ9juY1Eohs8FCTLumpXuSkrfJJBzxMxsoaB21k
	aHAu0HCZiF+sub+vL8T6BiMA20ggrcNAhffO218z7UqixDoKxw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rurag-0007kl-9Z; Thu, 11 Apr 2024 12:23:34 +0200
Message-ID: <9e2dd9ae-7c1a-4a7a-af6a-9c4aa1776a92@leemhuis.info>
Date: Thu, 11 Apr 2024 12:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org
References: <c274500b623b83c00c0460383cbe1cdc7490eeac.1712658693.git.viresh.kumar@linaro.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <c274500b623b83c00c0460383cbe1cdc7490eeac.1712658693.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712831017;f1b96ca3;
X-HE-SMSGID: 1rurag-0007kl-9Z



On 09.04.24 12:32, Viresh Kumar wrote:
> The required_opp_tables parsing is not perfect, as the OPP core does the
> parsing solely based on the DT node pointers.
> 
> The core sets the required_opp_tables entry to the first OPP table in
> the "opp_tables" list, that matches with the node pointer.
> 
> [...]
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218682
> Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>

s/Bugzilla/Closes/ here please. See submitting-patches for details. And
ideally it should first be "Reported-by" and then "Closes".

Ciao, Thorsten

