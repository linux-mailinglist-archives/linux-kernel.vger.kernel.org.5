Return-Path: <linux-kernel+bounces-86894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F121A86CC61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEB71C226E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72223137C51;
	Thu, 29 Feb 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4J5prwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08086275
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219287; cv=none; b=CDkckHQKRubXRkl7lSvzRhRVO1GelD/18i02Pnlac63T6aTTB5K8gM1lZXJBfsIJjA4JogvRqVp3wcjYij9VydmAYR/W6XDviDkrd3HLrhPGeBMzo4bQk0oK+N4+Dw+HRXE/poGHmlEzn33hi7pUrxjbL8/WytbN7dlY/UPc2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219287; c=relaxed/simple;
	bh=lBDBaBERrzACqhYXwzu/Sj58z0LxwVylnhvGh6A+/JU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R9xV5cZYIItNsqENerMFlPm8NVgJl64MXA3QYbRpI302niCAfU3YPNk385sNQg/29pWruEatLBAm8JDIcBYQr1gHLFkPPNjCkD3DnFNbMis1ECur3kYshsWywrI+DqmfV8c7onbAiQM7cVOUD3UdCXMNJbkqsu7l9OWX4/e9clE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4J5prwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E6C433F1;
	Thu, 29 Feb 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709219287;
	bh=lBDBaBERrzACqhYXwzu/Sj58z0LxwVylnhvGh6A+/JU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B4J5prwttaI07jDMSPEOwBHhRwAQhOExvOhHsDXghy8PzhyTj4BY4QSTOQ1MpNt7R
	 /DlQZg3DTWuRkwIg1ZZxZknUErNXbQdGc9ue0SKNzwxzqlj6xhW1yP+2zIX/JgEnSD
	 PdJgxWrFFk1X0gM9VAkVfXw/T4C/pLjvLtVsztB6U+gC9GAjWXtVWI95UJaJUhWH3i
	 n8F5hQo1WGKzz5VJhcBz20uJboXbuxfvi76XG++O05+5Y/6W0x8RNjVQUFwxDy4ByO
	 98McptLLPYs5l17FUgFmqRehHKL3lywAz22G/sxU/Bw/DeTqHZvE/Rmuvk9/uvHK4U
	 lYJTEa/jfgX+Q==
Date: Thu, 29 Feb 2024 07:08:06 -0800
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Hocko <mhocko@suse.com>
CC: Kees Cook <keescook@chromium.org>, cve@kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_CVE-2023-52451=3A_powerpc/pseries/mem?= =?US-ASCII?Q?hp=3A_Fix_access_beyond_end_of_drmem_array?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2024022913-borrower-resource-ecc9@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh> <Zdylmz28rZ-mCeiN@tiehlicka> <2024022639-wronged-grafted-6777@gregkh> <ZdytVTOgfvKBBvtn@tiehlicka> <202402271029.FD67395@keescook> <Zd8hPpP_6q_o8uQW@tiehlicka> <202402280906.D6D5590DB@keescook> <ZeA-281OudkWBhd_@tiehlicka> <2024022915-dissuade-grandson-ebd4@gregkh> <ZeBRZqJd5HAKaOfC@tiehlicka> <2024022913-borrower-resource-ecc9@gregkh>
Message-ID: <D06F40E5-0DBC-4FF2-BAF5-2373BDF3815C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 29, 2024 6:18:36 AM PST, Greg Kroah-Hartman <gregkh@linuxfound=
ation=2Eorg> wrote:
>As part of the requirement to be a CNA, we have to announce everything
>that we think is a potential vulnerability, severity not be judged at
> [=2E=2E=2E]
>Again, none of this has anything to do with "severity", it only is an
>identifier that says "this fixes a vulnerability"=2E

The language here can perhaps be improved for better understanding by folk=
s since "CVE" and "vulnerability" can mean different things to different pe=
ople=2E I would say "this fixes a weakness"=2E

CVEs are for anything deemed a "weakness"[1]=2E It doesn't need to rise to=
 the level of what many people would consider a "vulnerability"=2E (Modern =
attacks traditionally chain many weaknesses together to form an exploit, so=
me of which look harmless when examined in isolation=2E)

I find it helps to keep in mind the "CIA" acronym of what makes up a secur=
ity weakness: "negative impact to Confidentiality, Integrity, or Availabili=
ty"=2E (Not to be confused with the US Gov intelligence org with the name a=
cronym, ironically=2E)

-Kees

[1] https://nvd=2Enist=2Egov/vuln

--=20
Kees Cook

