Return-Path: <linux-kernel+bounces-30993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EE832738
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B723CB2277C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60E3C68C;
	Fri, 19 Jan 2024 10:05:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CC3C6AC;
	Fri, 19 Jan 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658704; cv=none; b=QVXz1uhVu+XBJAHTpvlanfI1ZUXk+RTgPnZZ93nwA9VImCA8VAQFdYDXtSoyRpvJC0KVl9riKTCuG2dzuHoLzkcibgnGRtnOVJ6WNIZ7aFy8vrjxbGk5itpe3gbXkKPPnb32mUtuyOw+ApnCVa4I0yTDkD49lmnUntTAKzkGo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658704; c=relaxed/simple;
	bh=kTR62PRIsIjb0kyOWB/ZybWnMwSIFSFSrTKpQs34dl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFzi5C++zLin2q2ZJrcIlqhLjI+YyThXwapZKylfvnqnNuE5awEDNRCpSFueR2rtS2Ak/f9p8b/wuoRBnOkeeHfj7/07NRqu6K7ap91BeNEtD0YQ+GGOoZHeUYB2RNtJhxd5fpMabcEboiqTiB4cLhuQlVJ9GMRNg2B1fgWelJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TGZvj4vQDzsW49;
	Fri, 19 Jan 2024 18:04:01 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id E8DA2180077;
	Fri, 19 Jan 2024 18:04:57 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Fri, 19 Jan
 2024 18:04:56 +0800
Date: Fri, 19 Jan 2024 18:04:46 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, Andi
 Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
	<changbin.du@gmail.com>
Subject: Re: [PATCH v3 3/5] perf: script: add field 'insn_disam' to display
 mnemonic instructions
Message-ID: <20240119100446.c3wtdskilcg4epwt@M910t>
References: <20240118041224.2799393-1-changbin.du@huawei.com>
 <20240118041224.2799393-4-changbin.du@huawei.com>
 <5766b575-e2db-4a56-9808-31a64bc72402@intel.com>
 <20240119035735.y427wcmsm7dow6h4@M910t>
 <3d5266d5-e5e1-49f9-8fb3-b736dc79e5e6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d5266d5-e5e1-49f9-8fb3-b736dc79e5e6@intel.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Fri, Jan 19, 2024 at 08:29:08AM +0200, Adrian Hunter wrote:
> On 19/01/24 05:57, Changbin Du wrote:
> > On Thu, Jan 18, 2024 at 09:49:41PM +0200, Adrian Hunter wrote:
> >> On 18/01/24 06:12, Changbin Du wrote:
> >>> In addition to the 'insn' field, this adds a new field 'insn_disam' to
> >>> display mnemonic instructions instead of the raw code.
> >>
> >> 'disam' seems an unusual abbreviation, and the 'insn' part seems a bit
> >> redundant.  Could this be just 'disasm' instead of 'insn_disam'?
> > 
> > Personally, I'd preserve the insn_ prefix. So we have two related fields 'insn'
> > and 'insn_disasm'.
> > 
> 
> 'ip', 'sym' 'dso' are all related but do not have a common prefix.  Also
> most of the field names lean towards abbreviation.
ok, fair enough.

-- 
Cheers,
Changbin Du

