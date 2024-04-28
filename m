Return-Path: <linux-kernel+bounces-161392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89808B4B73
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5171D28176A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750256B6F;
	Sun, 28 Apr 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AkJlo2HI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F28480;
	Sun, 28 Apr 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714302374; cv=none; b=n5ozn7QuwEVP47WmPuXrfGX1n/gh94poV9BIUrlZzq8dfDKJmSljB4C2k+aBe07VxHynZbamEftomocodeUVuozUkuhIaSVbgIfFwj2bNXdgjyQ52U2+5VuXAJcSucQI8wkLICGepDtagq0B6DVWnuyZZjmAtSNqI7r5ZhNWACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714302374; c=relaxed/simple;
	bh=UU8SgdFGNOdhG65xRQTliPs03k4M2ugcfAJrcZTffaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtqVMDVdNz4ZmFtqg9q4mhQ54oaVpkQXSecg91fyXx4MHZrPOZuik0Ov12NgtvoXcz+XlLtCTT+mrHJxfi5z3F3Q/dJ8Y0QhbStSPZEr7DhikdlIfvVv3Z3T4oay7a+0KndLf20wouQUBJdraABEXAcxAzTZGK6RaRwNZPCrOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AkJlo2HI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BA68A40E0205;
	Sun, 28 Apr 2024 11:06:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gcN8NC6Ho0lk; Sun, 28 Apr 2024 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714302362; bh=nek46uYbbUwLxdWyYg2mscjnkdU3uUJznYeFluV5IIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkJlo2HI0N39m8wdNo6Msjt2VwdAK2LL7lR/d42d3MuLFw6ecUTuHSBAC0iBD1P9f
	 500SVzdxU8UZ6mTzwCohUdm5WmuT0kZERam1wWDn7YdF4oh85OpernTS3arBreLmxJ
	 SZHKKsphzN1axwtD92p1ovlvuxSOjHk9En//pFeS7pIJFr1vWn5t6GkK9B+VbjTm/0
	 Y+mfxDkXmr/GYv1Owp7JnsXroCgA/XEZMy9dRnbInXKv4zJM04WDYlZPaCp4aQEcKq
	 k+FmgdnH6qxGnIxMcEZSvx83YMLl+KVIjh7rZtCN/tOMr9pgr06l7g0bGxK2X1JMK0
	 eFPGey2C1WnRvhLJwWs8EcMxUdut9Hq26rxgk07RvoIeQC3B1jPxmQGE1EmovylQkr
	 XQN6u+627g0DsdJkBDb8OuBboLt8msVpEUgjlTeGzwAF3a+VIZuPAv41hHvrl4xj5p
	 6qW0dQKFAMxBMvPHSLSdXmyW+meQbqJzwmUTCoLCv3Ih9K68rlJ2DJiOFJ7NDmoJnF
	 rNfv7m783F502CWZbn9D/EM9gljdqXWrHliNR3NeVZIQ5V3UeEW5HryJB1oXwHqDgR
	 AA/M1xpNlWndwezO9dIvwLQxkdq5I0sPtV39kIfPKNA5lQ+4HGAHVyhSLxaaT3SlrK
	 XlWpUTGkEpk5eo3BDwGDp5S4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2160040E016B;
	Sun, 28 Apr 2024 11:05:55 +0000 (UTC)
Date: Sun, 28 Apr 2024 13:05:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Yuan, Perry" <Perry.Yuan@amd.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Message-ID: <20240428110549.GAZi4tjadYAYgOBhEX@fat_crate.local>
References: <20240428091133.592333-1-Xiaojian.Du@amd.com>
 <20240428095409.GAZi4cwYxRwQGW_WFq@fat_crate.local>
 <DM4PR12MB5136052EA0F1930B49F91BBCF1142@DM4PR12MB5136.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5136052EA0F1930B49F91BBCF1142@DM4PR12MB5136.namprd12.prod.outlook.com>

On Sun, Apr 28, 2024 at 10:59:50AM +0000, Du, Xiaojian wrote:
> Thanks a lot for review, I will modify before submitting.

Thanks.

Also, please do not top-post on a public ML but put your reply
underneath, like I just did.

That's also explained in those docs I pointed you to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

