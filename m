Return-Path: <linux-kernel+bounces-46365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EC843E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7880C295CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6B79DB8;
	Wed, 31 Jan 2024 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GZD+0sX+"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBE7690F;
	Wed, 31 Jan 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701035; cv=none; b=KN5+EX5haVJ2vAgh93QUfOTY2TbUN09PFbstbmIjuHzaWRoav7NXD1eamTMWFu3mVy9Nv9s3PlWgiIyBxh+Yb0i75djNtlR0UJtmNU0TxyLU+x4O348JW7teqO0RSef0pO9cn0xfP7rmCO+alQMz1Fyd+lVUEQwHpfRqZ+8PHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701035; c=relaxed/simple;
	bh=fFbc15+K2Qav/6GvAmryoyTekn55HxMsdu5gO6TwTVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGUOhrQKRTLMSA5P9jbO1MXHVHr0vlaQ6HfWxKoDEbkLdvG9Pj3itt8QxrjYmfTDqk5rkjd1pnOOpqk4K/9qlPEZZ6NiXvy/kwfHoas8AZOdkxb0jBpA5uFk7YtQzjiAgj6CSXx6dIICXrMy4Ra0izAMD+Wu7BAxOQTruUTwSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GZD+0sX+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TQ0PW5mzlz9scH;
	Wed, 31 Jan 2024 12:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1706701023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLdVKzfkBFpCzA9kGmWBnb9BEFZztaCIrV8XEwSA+Qo=;
	b=GZD+0sX+taUmUdUncO0tuYCboiWCnF1psp0ttA/urd3Xvax9m3UurLIvYHGcE2abNKfpNZ
	AmovK8eyJDoGFrhrAVMNny6Hk7406JyrW9en2FTk2iu+8/xszo9VroUzfvYOMIAIzKE0Ul
	tUmpXihCyxfoqBBSerFbeYJB/LyVQ3O0BjMGZRED/aIufEGMHJrqr2nzcfCvtyWEVEVtBB
	WdAMjS3hMuqgY+s1GmMWrhOVX5q2G1vhE6Ps0sPu9RJubFcE2kA+82BR4EtH+y7tJFv4ZC
	B7xuQenifHTrkmxh3RABOTZkWIXZntoo9608jIQSJ5MYohVrgZCq0UsoF9ueGQ==
Message-ID: <63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org>
Date: Wed, 31 Jan 2024 12:36:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] AMD Pstate Fixes And Enhancements
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Mario.Limonciello@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <cover.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wdcjkumju7x6umxw1zdk1a4zoyw6ct5y
X-MBO-RS-ID: be195d3a5e1008a8685
X-Spam: Yes



On 1/31/24 09:50, Perry Yuan wrote:
> The patch series adds some fixes and enhancements to the AMD pstate driver.
> It enables CPPC v2 for certain processors in the family 17H, as requested
> by TR40 processor users who expect improved performance and lower system
> temperature.
> 
> Additionally, it fixes the initialization of nominal_freq for each cpudata
> and changes latency and delay values to be read from platform firmware firstly
> for more accurate timing.
> 
> A new quirk is also added for legacy processors that lack CPPC capabilities,
> which caused the pstate driver to fail loading.
> 
> I would greatly appreciate any feedbacks.
> 

Hi Perry,

Which tree or patchset is this based on?
It doesn't apply cleanly onto either 6.7 or 6.8.

First I had to revert [1], then apply [2] before applying this patchset 
and finally reapply [1].
I did not apply the "prefcore" patchset which I keep in a separate branch.

Is this correct or did I mess up something with my branches?

---
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.8-rc2&id=febab20caebac959fdc3d7520bc52de8b1184455

[2] 
https://lore.kernel.org/linux-pm/cover.1706255676.git.perry.yuan@amd.com/

Cheers,
Tor Vic

> Thank you!
> 
> 
> Perry Yuan (6):
>    ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
>    cpufreq:amd-pstate: fix the nominal freq value set
>    cpufreq:amd-pstate: initialize nominal_freq of each cpudata
>    cpufreq:amd-pstate: get pstate transition delay and latency value from
>      ACPI tables
>    cppc_acpi: print error message if CPPC is unsupported
>    cpufreq:amd-pstate: add quirk for the pstate CPPC capabilities missing
> 
>   arch/x86/kernel/acpi/cppc.c  |   2 +-
>   drivers/acpi/cppc_acpi.c     |   6 +-
>   drivers/cpufreq/amd-pstate.c | 112 ++++++++++++++++++++++++++++-------
>   include/linux/amd-pstate.h   |   6 ++
>   4 files changed, 102 insertions(+), 24 deletions(-)
> 

