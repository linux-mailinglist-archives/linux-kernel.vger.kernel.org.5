Return-Path: <linux-kernel+bounces-91210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE1B870B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF1C1C21FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30C7A159;
	Mon,  4 Mar 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TVgOPoQn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4B62160
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583181; cv=none; b=qZYeJ7NQpoIr6Z5AH1b9f/3Fd/egSKajbGOgJWQwtyeH/8BnWir88g0YjURl7CUD5owaChA+LToZ8FDQFYYRANrnNf6TqtCPOZchx1WTEf4ZzOwtb/373B06/WQmh4zyAba0GYqpKBU+r2A4eE0uH4y5Uf11gHXWqGqlQa+b1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583181; c=relaxed/simple;
	bh=2dZWQKT9+VI4fN5HG83hCe2KIo74Iq/neyDLmBuYqs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrs0cnWWwjfAvxTTyhd/p8EZd7j7eEKL19KgljQHV5/X5QsRsd62AWjB40UqGWhpC0qkbNCUdC821/d2G9Ox9G6F9UuJLghIqX7Y4i7Pyiu072fLGRWsa33kgHI0b1juC56CeaPChDZmzMywG39IFSiDMpc5gbo6ya79klKsOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TVgOPoQn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8BF940E01A2;
	Mon,  4 Mar 2024 20:12:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6J3TiTwB9LEu; Mon,  4 Mar 2024 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709583167; bh=7AAnRCmUw6WY5dqLo5Ulda1PXQ665OL1WDw/NItN5FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVgOPoQnrP7Ef3bPuHU9FCZXF1Nt5Xa5euDTlgjgpPP54KtRwJKY3UybEf2m6T3Ja
	 2lXVliEWZibNzheT0OCdLuPqZk8D6v/+KRWhd3+NqkW58bMaesTpe8Yv8gyt3XOaJS
	 GLwHWBpnxIM+Ont41u2YJInqy295yAZTFt+gv+l1GczAb9Tahw3PxMnUTIls1BV9UT
	 7VsPXc62PXXX6yWFhNfGne28TuPReg77cofrtaPtYXtzS6Eak15iHLYs3/bUCv4IKO
	 gfaBIvq9e2TOTFUdfO6u5A13I4CLZOkpcAFNRuRq8pG5+Gdt3bA3BrVacmF9RUmiQJ
	 3FHmwrZSvp1HY8uiTuemUhujJ3T5g3NjouQ6Aa9x2CIh/0W6T3zbFdBATNW8ocAcyy
	 v7krF+ako+2tA2t7yESGUCmcFjhPBQ+Ymmq/JcIIXmI5XxYROJlSXzL+4/gP566fzI
	 ZXxYmFH2ub+Nen92EQ2yyPthuPaYViMMfmN7CPvJcj+dKDufghrNsyS6+DLWhvvQy/
	 CX7LePeOVOmctQldS5SqmUTqPcZIcwiBSBu5EBp1uCY5HMDZeY9suBUqtMAxnzwNqw
	 2vc5Jq1JOZAi2ykf6PfgcH/WEvsOFFluNu3zQa4pcpoGQZgP+PN9yfmyNEhI6WIWGf
	 vvus8piHLBIGsJtGb0H+7wbI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CCD340E0185;
	Mon,  4 Mar 2024 20:12:40 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:12:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: x86-ml <x86@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
Message-ID: <20240304201233.GDZeYrMc9exmV21PFB@fat_crate.local>
References: <20240304181841.GCZeYQgbZk6fdntg-X@fat_crate.local>
 <b16add91-30c4-43e6-bcf8-11ca8aeaa783@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b16add91-30c4-43e6-bcf8-11ca8aeaa783@linux.intel.com>

On Mon, Mar 04, 2024 at 02:22:50PM -0500, Liang, Kan wrote:
> The number of available CBOXs on a SNBEP machine is determined at boot
> time. It should not be larger than the maximum number of cores.
> The recent commit 89b0f15f408f ("x86/cpu/topology: Get rid of
> cpuinfo::x86_max_cores") change the boot_cpu_data.x86_max_cores to
> topology_num_cores_per_package().
> I guess the new function probably returns a different maximum number of
> cores on the machine. But I don't have a SNBEP on my hands. Could you
> please help to check whether a different maximum number of cores is
> returned?

Yeah, the topo rework looks at fault:

before:

online:              1
initial_apicid:      0
apicid:              0
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             0
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              0
max_cores:           4
max_die_per_pkg:     1
smp_num_siblings:    2

after:

online:              1
initial_apicid:      0
apicid:              0
pkg_id:              0
die_id:              0
cu_id:               255
core_id:             0
logical_pkg_id:      0
logical_die_id:      0
llc_id:              0
l2c_id:              0
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         32
num_cores:           16
max_dies_per_pkg:    1
max_threads_per_core:2

I'll let tglx poke at this.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

