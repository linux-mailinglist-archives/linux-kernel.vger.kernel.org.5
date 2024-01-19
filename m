Return-Path: <linux-kernel+bounces-30750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016E48323EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB88E1F2269A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08C1FD8;
	Fri, 19 Jan 2024 03:57:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398020FD;
	Fri, 19 Jan 2024 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636673; cv=none; b=Y4dGJ1h/PIXsiyZ3cvrQFUGFCAtoGOFYH67/ra/vAewgC3nrbrtc/h8tLxq5400MqSyg4Qgx2GSuaypM8W8gsBhsSRCNXGVZ6d1Mh6AKUo/nC5E04tnrBWBCQVtdKuWJ6gvdeEVovME5Wfhu4jRd/rHVSUqxHT/rEacNdX0dw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636673; c=relaxed/simple;
	bh=NBKvgI5HSxtduWQiJb/Ch3YQr7bTq4KrbWIfuRq0X50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQKo6ChzPWBJJzPUdzg+1XgwyCesN5AeR5vP390cct9zh0dBEIcgSPgRnwapuxnbjzLTLQRpvtEiARvz7drvn5NnYgOIO8JJXf/l7w5TP01426JJF86gwGaYFNv4kYE4cqb/uW/2wcrStYtMERXkh1yS1IxHN4FhJv2LtIQpXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TGQlS1k6kzvTqp;
	Fri, 19 Jan 2024 11:56:20 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id A95A51800C4;
	Fri, 19 Jan 2024 11:57:46 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Fri, 19 Jan
 2024 11:57:45 +0800
Date: Fri, 19 Jan 2024 11:57:35 +0800
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
Message-ID: <20240119035735.y427wcmsm7dow6h4@M910t>
References: <20240118041224.2799393-1-changbin.du@huawei.com>
 <20240118041224.2799393-4-changbin.du@huawei.com>
 <5766b575-e2db-4a56-9808-31a64bc72402@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5766b575-e2db-4a56-9808-31a64bc72402@intel.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Thu, Jan 18, 2024 at 09:49:41PM +0200, Adrian Hunter wrote:
> On 18/01/24 06:12, Changbin Du wrote:
> > In addition to the 'insn' field, this adds a new field 'insn_disam' to
> > display mnemonic instructions instead of the raw code.
> 
> 'disam' seems an unusual abbreviation, and the 'insn' part seems a bit
> redundant.  Could this be just 'disasm' instead of 'insn_disam'?

Personally, I'd preserve the insn_ prefix. So we have two related fields 'insn'
and 'insn_disasm'.

-- 
Cheers,
Changbin Du

