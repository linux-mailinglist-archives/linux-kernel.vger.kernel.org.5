Return-Path: <linux-kernel+bounces-106973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAEA87F62C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9E31C21AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16207BB15;
	Tue, 19 Mar 2024 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jEicmtQt"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCB7BAF7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820194; cv=none; b=E3waSoSn/4affXl/mzm9TX+5WThN7QWgoiNuIld2ZUqQE8FHlkwMV8wS3O3E76GNIbx7Ls/SDInj6rzlDo+bkMs841ityTW5DfyF8C876RF5LEYwyaXITRbyOlkfbK6lG6kaqrsQuBArOiXy8LqTXHytCRidLqSbqPgMGG9IpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820194; c=relaxed/simple;
	bh=hNPVXYOhJcoLVTEV4WarZkDlgxg2epWF1bGQ17SmhQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bK76vvpmaNulzrLpFmkVisg+UJrTcxGh6mCaQOii+RyEjY2TbvI4urL+VAL5nDn6zDAlSxPcR7ZY4tx0B4Z/qAMChLskcWkPE/fO3//OPjgSXp86WVkmeztl0qkdI7GPZMRkBHElVS2rJSsYmUe3DeoCqeuOpIxQgwef2xf8UvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jEicmtQt; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id mLXZrnOJdHXmAmQTyrPsg4; Tue, 19 Mar 2024 03:49:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mQTxrUevXybtzmQTxr7zfo; Tue, 19 Mar 2024 03:49:45 +0000
X-Authority-Analysis: v=2.4 cv=RsAOLzmK c=1 sm=1 tr=0 ts=65f90b59
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=cm27Pg_UAAAA:8 a=VRTBL-XNDjFAICBfogcA:9
 a=QEXdDO2ut3YA:10 a=1F1461vogZIA:10 a=5kKzt1m56AEA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=SLz71HocmBbuEhFRYD3r:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W2zZsoQWdc3rKe29I0hrlQr5HJTS/IblWppWq5S0AJA=; b=jEicmtQts4e0AtILeFpXWu2//o
	XkPK7qH3ksyoQlXvWjiqhJJ0D37F5LNTRknSJacYIF0CgkjjBKpCi42DTexuHIfvpD9mvCMTBAoNa
	5l/7bZr58+hPt6kxjNYFLNM3OqYGgnDaXZ1NLYFcDlT5odz0e5fzgugptaq1/IxIpgNoR8fnVtLoS
	IXXJBZnfV01ZEWQJlPxtfLIVSkNHBdosWCBLIx5YeTdglM774IuqpNDgf/mjEM9O6ZvwDoo7D0rtL
	/7d1J8NzTLTqQQgxuzGunUlyKabpg3CBetfp23D4WAgrHGKU6zZYiI2j52zCBkfgYSZFsoOoaECMU
	FpRAC2IQ==;
Received: from [201.172.174.229] (port=34604 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmQTs-004HQs-1n;
	Mon, 18 Mar 2024 22:49:40 -0500
Message-ID: <38c7e956-9161-41d0-94a1-5f55481fd8a3@embeddedor.com>
Date: Mon, 18 Mar 2024 21:49:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/rapl: Prefer struct_size over open coded
 arithmetic
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Erick Archer <erick.archer@gmx.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240317164442.6729-1-erick.archer@gmx.com>
 <202403181635.46CBABD994@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202403181635.46CBABD994@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rmQTs-004HQs-1n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.229]:34604
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPeC3Q+a6JAGVCmCpxVMEP6gVjMCp+26LSdZd3NFZIpJeE8WMu5CdPhFV7dziUnqNXmcyaatJ6epKXiCo2f/ez0wb3WstYIrUc0jlwKXpTSLKqt7U63E
 HQ6Hq3ox/txlJxn36Vge4TPDD9q5tG6JSyGGt3aa71wkkg8xs7cD0wh27PHkNixYQVhUDlQWtbmDFVS5xixscv9tRvHogFES6gY4wfMkXNS1e00utTyBa9iq



On 18/03/24 17:40, Kees Cook wrote:
> On Sun, Mar 17, 2024 at 05:44:42PM +0100, Erick Archer wrote:
>> This is an effort to get rid of all multiplications from allocation
>> functions in order to prevent integer overflows [1][2].
>>
>> As the "rapl_pmus" variable is a pointer to "struct rapl_pmus" and
>> this structure ends in a flexible array:
>>
>> struct rapl_pmus {
>> 	[...]
>> 	struct rapl_pmu *pmus[] __counted_by(maxdie);
>> };
>>
>> the preferred way in the kernel is to use the struct_size() helper to
>> do the arithmetic instead of the calculation "size + count * size" in
>> the kzalloc() function.
>>
>> This way, the code is more readable and safer.
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
>> Link: https://github.com/KSPP/linux/issues/160 [2]
>> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> I was inspired to come up with a Coccinelle script to find this pattern.
> This seems to do it, though it also removes the blank line. I'm not sure
> how to stop it from doing that. I'm running this treewide to see if I
> can find others...
> 
> // Options: --no-includes --include-headers

with --no-includes this one is missed in arch/x86/events/:

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cdf28fa..213fe48f9391 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -350,12 +350,11 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
  static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
                                                  int node)
  {
-       int i, size, numshared = type->num_shared_regs ;
+       int i, numshared = type->num_shared_regs ;
         struct intel_uncore_box *box;

-       size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
-
-       box = kzalloc_node(size, GFP_KERNEL, node);
+       box = kzalloc_node(struct_size(box, shared_regs, numshared),
+                          GFP_KERNEL, node);
         if (!box)
                 return NULL;

Funny thing is that in this case it's quite convenient that the script removes
the blank like. :P

--
Gustavo


