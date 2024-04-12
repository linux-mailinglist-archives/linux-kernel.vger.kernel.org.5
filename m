Return-Path: <linux-kernel+bounces-143009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BF8A3327
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC9B2408C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49771148852;
	Fri, 12 Apr 2024 16:08:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651F1474DF;
	Fri, 12 Apr 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938089; cv=none; b=G07p0GnRlAkgW+T7cYTqMUJVl7JpMDeXtLJGnQS3KMOSxU9huVke6n882mkmkBgMqVqbZrmeIPtQdVFciovqg1KtRFR2jsVaoh9cKSX+0cRvjEON47A3lrJzHL4b3Vi5A6+39q+VuBJJtyk/MAWQili/SdjHEvdrvEbDeJGS+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938089; c=relaxed/simple;
	bh=KqGVur9Ye2q6dNqvzw3oeYhfgRsaaL049KXc3Dv2nBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX9jIndK8yb97on7wE5si7ExpMlpaSX8khAqZYDRxP4YKyCvuZYoCTcTOHjpe5mL/qmNVEPBa52aKH7sDnHDWsztp4newgvKoZ114+sTdeMmhbkPE7FBluzpBiwq4hmIY5dNOXK8O0YUmjYf7zJcpsJjGjhmmtkxFSBstr5ZmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9584339;
	Fri, 12 Apr 2024 09:08:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2092C3F64C;
	Fri, 12 Apr 2024 09:08:04 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:08:01 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
Message-ID: <ZhlcYRolZwm7UwJu@bogus>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com>
 <CAEEQ3w=+C2J0ZS227-1P-B+pe_NRp_3i4c4CxGssiKqbpXx_qw@mail.gmail.com>
 <2cde00c8-7878-45c0-8621-fca4e70c75e7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cde00c8-7878-45c0-8621-fca4e70c75e7@arm.com>

On Fri, Apr 12, 2024 at 10:03:14AM -0500, Jeremy Linton wrote:
> Hi,
> On 4/10/24 21:28, yunhui cui wrote:
> > Hi Jeremy,
> > 
> > On Wed, Apr 10, 2024 at 9:30 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
> > > 
> > > Hi,
> > > First thanks for working on this.
> > > 
> > > On 4/7/24 07:38, Yunhui Cui wrote:
> > > > When the type and level information of this_leaf cannot be obtained
> > > > from arch, cacheinfo is completely filled in with the content of PPTT.
> > > 
> > > I started reviewing this, based on what I understood to be the need to
> > > generate the topology entirely from the PPTT. But, it was raising more
> > > questions than answers because the PPTT is far too flexable in its
> > > ability to represent cache hierachies that arn't logically useful. For
> > > example multiple I or D caches at the same level, or I or D caches
> > > higher in the topology than unified ones.
> > > 
> > > At least for arm64 (and I think others) there is an understood
> > > simplification that there will be N levels of split I/D caches and M
> > > unified levels. And from that, the number of cache leaves are computed
> > > and allocated, and then we go in and largly skip PPTT cache nodes which
> > > don't make sense in view of a generic topology like that. (see the
> > > comment in cacheinfo.c:506)
> > > 
> > > Both of those pieces of information are available in
> > > acpi_get_cache_info(). The missing part is marking those N levels of I/D
> > > cache as such.
> > > 
> > > Looking at this code I don't really see all the error/allocation
> > > logic/etc that assures the cache leaf indexing is allocated correctly
> > > which worries me, although admidditly I could be missing something
> > > important.
> > > 
> > > In summary, did you consider just allocating matching I/D caches from
> > > the number of split levels in acpi_get_cache_info() then removing or
> > > invalidating the ones that don't have matching PPTT entries after
> > > running cache_setup_acpi()? Thats a fairly trivial change AFAIK if the
> > > decision is based on the lack of a cache_id or just changing the
> > > this_leaf->type = CACHE_TYPE_UNIFIED assignment to the correct type and
> > > assuring left over CACHE_TYPE_NOCACHE entries are removed. I think much
> > > of the "significant work" is likely fixed for that to work. Just
> > > tweaking detect_cache_level()/get_cache_type() to set
> > > CACHE_TYPE_SEPERATE if the level is less than the acpi_get_cache_info()
> > > split_level value probably also does the majority of what you need
> > > outside of having unequal counts of I and D caches.
> > > 
> > > There are probably other choices as well, thoughts?
> > > 
> > 
> > First, I think the current state of the ACPI PPTT specification meets
> > the requirements and is logically complete. Otherwise, the PPTT
> > specification needs to be updated, right?
> 
> The specification is capable of representing all the actual physical
> topologies I'm aware of, its also capable of representing quite a number of
> topologies that don't make sense to (cant be) build and are largely
> nonsense. There are some further details around replacement and allocation
> which could be represented but were AFAIK not considered worth the effort
> because it makes the representation far more complex.
> 
> So, except for minor clarifications I'm not aware of a need to update it.
> 
> > Our discussion is best focused on the existing and usual case, even on
> > ARM64, which is as you say "N-level separated I/D cache, M-level
> > unified".
> 
> I understood this was for RISC-V when I reviewed it, but i'm fairly certain
> the general cache topologies of RISC-V machines don't vary in their core
> concepts and layout much from the wide variety of possibilities available
> elsewhere. So its roughly the same problem, you will likely have one or two
> layers of split I/D caches and then a number of unified private or shared
> caches above that.
> 
> 
> > 
> > And then, the problem we have now is that the RISC-V architecture does
> > not have a set of registers to describe the cache level and type like
> > ARM64 does, so we need to fully trust the contents of the PPTT table.
> > Please check the patch:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20240407123829.36474-2-cuiyunhui@bytedance.com/
> 
> I don't think "fully trust" is something you really want, or is helpful as I
> suggested above.
> 
> I suspect all that is needed is the construction of the missing I/D layers,
> as the existing code will create the Unified layers above as it does today.
> On Arm64 the unified system level caches aren't usually described by the
> core cache registers either, which is why there is that existing bit of code
> to change unknown caches to unified. But it also turns out the pptt walking
> code is capable of providing the information to create the I/D layers as
> well, if they are matched (ex there exists an I cache for every D cache at a
> certain level).
> 
> So, more clarity about the kinds of topologies you expect is helpful to
> understand where the current code is failing.
> 
> AKA, As I mentioned I'm fairly certain that its possible to construct the
> entire cache topology from the PPTT by changing get_cache_type() to return
> "CACHE_TYPE_SEPERATE" when the level is less than the value returned as
> "split_level" from acpi_get_cache_info(). That tends to ignore some edge
> cases, but I might put them in the "don't to that" bucket.
> 
>

I agree with Jeremy's analysis. Can you check if something like below
will address your issue. Not compile tested but you get an idea of what
we are trying to do here.

Regards,
Sudeep

-->8
diff --git i/arch/riscv/kernel/cacheinfo.c w/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..92ab73ed5234 100644
--- i/arch/riscv/kernel/cacheinfo.c
+++ w/arch/riscv/kernel/cacheinfo.c
@@ -79,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
        struct device_node *prev = NULL;
        int levels = 1, level = 1;

+       if (!acpi_disabled) {
+               int ret, fw_levels, split_levels;
+
+               ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
+               if (ret)
+                       return ret;
+
+               /* must be set, so we can drop num_leaves assignment below */
+               this_cpu_ci->num_leaves = fw_levels + split_levels;
+
+               for (idx = 0; level <= this_cpu_ci->num_levels &&
+                    idx < this_cpu_ci->num_leaves; idx++, level++) {
+                       if (level <= split_levels) {
+                               ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+                               ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+                       } else {
+                               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
+                       }
+               }
+       }
+
        if (of_property_read_bool(np, "cache-size"))
                ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
        if (of_property_read_bool(np, "i-cache-size"))


