Return-Path: <linux-kernel+bounces-34306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE058377D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE3AB24985
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DB4F206;
	Mon, 22 Jan 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=dan.martins@zoho.com header.b="Vu5Hi9qy"
Received: from sender3-pp-o97.zoho.com (sender3-pp-o97.zoho.com [136.143.184.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307E4EB21;
	Mon, 22 Jan 2024 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967581; cv=pass; b=rpmKVO8nAJLyhG/aE4AdcxYmQAu/i14up1X/wo2p6rBYPWpSdTmF2/cLFsN1Y4T2gpiHkxDPqBRB6WUNa3qryx1yk9/LrpZeXHxC+41Ybb9lcF25qd9iGPLjy911E8xvmK5RROsGusvSrk0ISqIJSS0Mxf5L5gFWaCrHUahc2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967581; c=relaxed/simple;
	bh=F+BthcYS7rPv7wyW5LCcvsLu8G5opQadpCyRRS+fEPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs5i8QqwwyLk+5Xsb93uYpYbZ3Rt/yp3DRfDQnEiiLjA8BVrBqK1YDL/8NCH8tW+/uAHxfxawkOALKja3/FPM5+TBlwghKfU2gR4UZiVe8EPtzKIH42AhbXtJkbIsabcKHuEu8IMwTMwBzLjJFmm60EGkHqJpC7LoEYVWhocCm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com; spf=pass smtp.mailfrom=zoho.com; dkim=pass (1024-bit key) header.d=zoho.com header.i=dan.martins@zoho.com header.b=Vu5Hi9qy; arc=pass smtp.client-ip=136.143.184.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1705967572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KwpzLOTUcANGxin5ZaE+roo7zRUFTgm92q3U33ruraTupUcJDt2hyx+Y3nkloJ2AHFkPm2lU/2TlrfrG0VHuYgR9093mT9vBVfhcZgDH/d4bUr0nquCNRE3FAt32N6ytecPsR/67kvlL5+OxXWji/YvLMdbiUPDcuKpNMkg1MrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705967572; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rLJP6Vx7qrjR1VmFZBYANXrusW+ovjxxuJzHQHu7wV0=; 
	b=GEbPjeqMdwtffUiWme6eg4M063A2RZ695Jom5N1Cme6C//Ny2THDoY152XpzLN1Mf0gleKR4q08JHS3E47YnFxb5wALryamaTDApMlt4EMWyOOwztLjE+FcaSlqPlN6UykeGk2mkoBlj/qBf2E4FRVcKgyJ5HDfVv3ZF1SrNy2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zoho.com;
	spf=pass  smtp.mailfrom=dan.martins@zoho.com;
	dmarc=pass header.from=<dan.martins@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705967572;
	s=zm2022; d=zoho.com; i=dan.martins@zoho.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Feedback-ID:Message-Id:Reply-To;
	bh=rLJP6Vx7qrjR1VmFZBYANXrusW+ovjxxuJzHQHu7wV0=;
	b=Vu5Hi9qysqP8ZnwagMdQgcZCa1Xe4RHa5Z9z6LvqQYhIksSaSrbFI8CypceX310N
	/OsIDrIkP1gQFhWHtxGERUQltGvFtMlxeFII8R5vswuUAObmlF/Sl+eo0wckPIzDOM9
	FNP6Z6ApCCQ5Ykvhf18fDrbdESCr9nXhxyIjIdGU=
Received: from draconyx.localnet (24-52-246-67.cable.teksavvy.com [24.52.246.67]) by mx.zohomail.com
	with SMTPS id 1705967571694704.2488183367262; Mon, 22 Jan 2024 15:52:51 -0800 (PST)
From: Dan Martins <dan.martins@zoho.com>
To: ray.huang@amd.com, rafael@kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 stable@vger.kernel.org, wkarny@gmail.com
Subject:
 Re: [PATCH] cpufreq/amd-pstate: Fix setting scaling max/min freq values
Date: Mon, 22 Jan 2024 18:52:50 -0500
Message-ID: <2263414.iZASKD2KPV@draconyx>
In-Reply-To: <20240119113319.54158-1-mario.limonciello@amd.com>
References: <20240119113319.54158-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Feedback-ID: rr08011228c4d23cc6ead3bea5099e72db00006c4b3724f29c5bbc477d7a2934471d3702b533a5981206e5b5fa:zu08011226df8b965205c05624cf8859df00007b21fe0c0d763776009e3f1d295e05561023dfd195a9276a:rf080112325c1086f76a58161ee12f58e20000555e5ba39e401679e75548f003e1e0d0261abcd215cdd5ba042258c9479ffa77968a1c7b:ZohoMail
X-ZohoMailClient: External

On Friday, January 19, 2024 6:33:19 A.M. EST Mario Limonciello wrote:
> Scaling min/max freq values were being cached and lagging a setting
> each time.  Fix the ordering of the clamp call to ensure they work.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Cc: stable@vger.kernel.org
> Cc: wkarny@gmail.com
> Fixes: febab20caeba ("cpufreq/amd-pstate: Fix scaling_min_freq and
> scaling_max_freq update") Signed-off-by: Mario Limonciello
> <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1f6186475715..1791d37fbc53 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1232,14 +1232,13 @@ static void amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy) max_limit_perf = div_u64(policy->max *
> cpudata->highest_perf, cpudata->max_freq); min_limit_perf =
> div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> 
> +	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +
>  	max_perf = clamp_t(unsigned long, max_perf, cpudata-
>min_limit_perf,
>  			cpudata->max_limit_perf);
>  	min_perf = clamp_t(unsigned long, min_perf, cpudata-
>min_limit_perf,
>  			cpudata->max_limit_perf);
> -
> -	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> -
>  	value = READ_ONCE(cpudata->cppc_req_cached);
> 
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)

Tested-by: Dan Martins <dan.martins@zoho.com>




