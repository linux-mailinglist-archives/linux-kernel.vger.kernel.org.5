Return-Path: <linux-kernel+bounces-167593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF68BABB4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DFBB22386
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF6152781;
	Fri,  3 May 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="QIAhxCij"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B38C2E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736245; cv=none; b=TcjjrotEf87LXKtpWBCs9/3SMCHnk+rughrEXgO+CQx3pF2LMEzAeAi98HI/N9SMYELUe7Hy5EqxnTexYSXQnNa4ZYD1M2ipX5U1UEqRvVNAByCuvwuTR7W5ZIS6Q2+32w7YE2JEbM5Z47XGjGsNh31ZII59tCktxWOZIabvrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736245; c=relaxed/simple;
	bh=ovvpZtA9Sqmx0FN7EsTrKN/CiL5vmokMEuCX7JrSClo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF0C3cDAO/bb7cbGnq3bXktTd1oC4lMSJjJc8H0H92HjZsB571JnEI94AZVrTDkeQ9BzETwQtkdhOMSVvb7J2Go7J9nNl4AOKxPldhcEFcUkm1xBAJqOjMzZyqFm/3w8ahQzd60UJFRML8ZsVlAlW8I2xC1OiwHJErHmyTtb18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=QIAhxCij; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E7B511C0BCF;
	Fri,  3 May 2024 13:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714736242;
	bh=ovvpZtA9Sqmx0FN7EsTrKN/CiL5vmokMEuCX7JrSClo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIAhxCijngJFfXNvrSGwWdLpSsgG3+PHsd91CUqlJofGDSJsuxldCb64LQbl8Fuhf
	 Ii47bjitgT+MbR5xyFSHmN/EZ0zIj+XFkEWRwNx2B7qzXMchTxSRaLgoxuwCubuU62
	 PR2WV5Kb/0vbR6oi97031EM+r0h6TuMnfrGrBmukpYgPvNkzuVmqZWFm9F9X6RbHr+
	 u8wRrcs3wyOS0upwjcV46dvHA8uDILHRu7/fEKJ6HaQ/BVdC0zdzIfCFRBTL3FTw8D
	 s9fu0YZCOPOtMUWdL+wbCQMFyt5lIrO2Wmk7BMkI4Tw0fUuE9TYjeDidZ8omAOfy4s
	 WuaIuAHuaVmhw==
Date: Fri, 3 May 2024 13:37:20 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Roth <michael.roth@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [svsm-devel] [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution
 when an SVSM is present
Message-ID: <ZjTMcC7KTP9xRAqk@8bytes.org>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:11AM -0500, Tom Lendacky wrote:
> +static void __init report_vmpl_level(void)
> +{
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	pr_info("SNP running at VMPL%u.\n", vmpl);

Nit: Can this be formated more like "SNP running at VMPL-%u"? That makes
it easier to parse for me when looking into dmesg :)

Regards,

	Joerg

