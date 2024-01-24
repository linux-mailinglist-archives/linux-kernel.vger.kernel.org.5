Return-Path: <linux-kernel+bounces-37295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEEC83ADE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F83FB24192
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633F7CF0E;
	Wed, 24 Jan 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e4bZFius"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22B7A725
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112070; cv=none; b=lhNj/aRdW0IbF8AEOQEOnoQ42FEnwPTMD284EuJTXmHxtsnee3+kTF73Kgio6oHSRDnoBRQkJhJMGrraVQMxh1P4E5cIcGhplMY+08Cy9i2AiA2TC+tVA5uPNUht4nj6A0SC/yyCp/ijGuie2v7isJgDQCVcHz5pVWFqlyl3whM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112070; c=relaxed/simple;
	bh=39iyj2JdQ9w0MtrsAND0HiyJapfr9hcRNh+jzlPp8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf6gaQ2Eo+17uZFnWLeFpXWcXuA00RjzyyWO6I+e45W/F7BaSUIrFSScUj5UkHj5jnl5nJ0+QhHb/6yys7MaTI29jyMVa0cvQ5kN3wCdO1nHDstoKbheQi4zl4NSQOwmDr12dMHXBwtxQNC30tfJ/G8hpc2EL+wLeePc1izbZvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e4bZFius; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E6F740E01AE;
	Wed, 24 Jan 2024 16:00:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EGu_OVX8qWon; Wed, 24 Jan 2024 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706112056; bh=3bBYh+GwfglWvi3037W1jLdF84shQepN/efeZnJUuRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4bZFiusLlNyiFM5hEN8lE8JSy8ihxa62ofjuBrOtnhyq8sM7szd0qORSF3H7k7Vj
	 tehdYXObVAZ6am4LVDH2AeyvZy5G8uGf4zHwIUYAJEWphpbdMDVN59jxmk/aT+DBup
	 TJpoQGSPTAR/qIecdiLaiQIzQhUZ757l2JCWee3/1eFa9MSSkpjmCw3yYaSBtkSeBr
	 OyEdkJ9ZRcxijwEPVnky/+64vHm3QtKk1pWmi9ZChIfm8IXdiBiDk3I4EiSDCNWLK/
	 EKAj7w+34GtAssGnsuzDXZHUCyvWseaQwGJMwXmwtODDdnS2PVeo6Ed5c1MTbS9wl7
	 shcPqIFjCjRh+5dxh1Xzau76qXN6YwD1XirogZsniy+MQHl9aOSkZ8MZnfMWoXlo9w
	 S77/uzLUTTLqXB2VTpmpnH7G/SEBmOz1LFhOh9f/XbcE1AVL61yS3h3hDiK4MQzkFU
	 AdjmRx5ijjUTPEa0IOPSiq5Tpogjged3d/Kr1IMcN5bk6YJnOcSfe7kv2i67VTCGrh
	 cNP0kvoQu/RVBYQFj8gPW6WCXZrRCjrJZNYHZERpnK62jHPk/kvplxvz15Xand95mb
	 2nNWwGRcS7K63/XjRNGISLCLJn2xb3cnp5gtm/U/cV6Q723ycxepE2EmOQv2cm/H0N
	 iEK6TU6BcdhTFqKyDE9mCvjo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2DE040E01A9;
	Wed, 24 Jan 2024 16:00:47 +0000 (UTC)
Date: Wed, 24 Jan 2024 17:00:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [tip:x86/cache 3/3]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret".
 Return " 0" on line 1655
Message-ID: <20240124160040.GEZbE0KEUwGMdhVi_x@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <20240124105555.GBZbDsu-zsQ8YTgXjS@fat_crate.local>
 <0578da80-db4c-4c0b-8677-2875a65afd68@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0578da80-db4c-4c0b-8677-2875a65afd68@amd.com>

On Wed, Jan 24, 2024 at 08:58:27AM -0600, Moger, Babu wrote:
> The following patch should fix the problem.

Obviously.

> Let me know if you want me to send the patch officially.

Yes, please send a proper patch and add the Reported-by: and the Closes:
tags from the robot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

