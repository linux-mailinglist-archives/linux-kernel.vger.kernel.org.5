Return-Path: <linux-kernel+bounces-27580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F482F276
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C511C22661
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954B747F;
	Tue, 16 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUwSJJaj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854331C698;
	Tue, 16 Jan 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705423028; x=1736959028;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=77nS54MaROJiIoDfFd+wUBsSSwYQIdsUnuLBX+XNu74=;
  b=GUwSJJajJc3QBmaYrEmUpB9jm9Dd0svo7rR1uO1H4Di9Ldo6ioDRpwQM
   6UZvTDLacbXSVxaHwyNXj2pzMXqsPUzkNO1ekI+kvUvh61ljoG1H3BtG8
   4n4GdgCg/cjHt1noHrPdgtAePS+K1vLf+lyyhwY/sTtJmc2yV/RK9ccpt
   IyXVKPTnuSitCJ+9StSCtlMJz79QAcaepdR0K6QRzbxZsbDUO4YuQIwcO
   Oc7haUtgqJLW3zuRkE5WRMZuJn3a9RknDduyQAiO5/SI1DYOImmOkufXh
   QlhzY6klnhZA9sHw7RQB9IUELwzefs8qNEEPFFegk8F6R68IZrsu/x8ur
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6630183"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="6630183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 08:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="18530291"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 08:37:07 -0800
Received: from [10.212.74.53] (kliang2-mobl1.ccr.corp.intel.com [10.212.74.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3BFB2580DB4;
	Tue, 16 Jan 2024 08:37:04 -0800 (PST)
Message-ID: <a0540796-1933-4057-8282-aa219ddda4fe@linux.intel.com>
Date: Tue, 16 Jan 2024 11:37:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] Clean up perf mem
Content-Language: en-US
To: kajoljain <kjain@linux.ibm.com>, acme@kernel.org, irogers@google.com,
 peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
 will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
 leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
 renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com,
 atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
 <befb6acd-86be-4255-af96-38865affc56c@linux.intel.com>
 <8bfadc86-e137-4a9f-a9ce-0bc62464c195@linux.intel.com>
 <057a1c19-3117-1aec-41d6-4950c599b862@linux.ibm.com>
 <692e16f9-062c-4b3c-bd66-a16bac68216c@linux.intel.com>
 <cd7dc93f-ade9-6403-a732-2daca8e6cff9@linux.ibm.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <cd7dc93f-ade9-6403-a732-2daca8e6cff9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-16 9:05 a.m., kajoljain wrote:
>> For powerpc, the patch 3 introduced a perf_mem_events_power, which
>> doesn't have ldlat. But it only be assigned to the pmu->is_core. I'm not
>> sure if it's the problem.
> Hi Kan,
>  Correct there were some small issues with patch 3, I added fix for that.
>

Thanks Kajol Jain! I will fold your fix into V4.

>> Also, S390 still uses the default perf_mem_events, which includes ldlat.
>> I'm not sure if S390 supports the ldlat.
> I checked it, I didn't find ldlat parameter defined in arch/s390
> directory. I think its better to make default ldlat value as false
> in tools/perf/util/mem-events.c file.

The s390 may not be the only user for the default perf_mem_events[] in
the tools/perf/util/mem-events.c. We probably cannot change the default
value.
We may share the perf_mem_events_power[] between powerpc and s390. (We
did the similar share for arm and arm64.)

How about the below patch (not tested.)

diff --git a/tools/perf/arch/s390/util/pmu.c
b/tools/perf/arch/s390/util/pmu.c
index 225d7dc2379c..411034c984bb 100644
--- a/tools/perf/arch/s390/util/pmu.c
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -8,6 +8,7 @@
 #include <string.h>

 #include "../../../util/pmu.h"
+#include "../../powerpc/util/mem-events.h"

 #define        S390_PMUPAI_CRYPTO      "pai_crypto"
 #define        S390_PMUPAI_EXT         "pai_ext"
@@ -21,5 +22,5 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
                pmu->selectable = true;

        if (pmu->is_core)
-               pmu->mem_events = perf_mem_events;
+               pmu->mem_events = perf_mem_events_power;
 }



However, the original s390 code doesn't include any s390 specific code
for perf_mem. So I thought it uses the default perf_mem_events[].
Is there something I missed?

Or does the s390 even support mem events? If not, I may remove the
mem_events from s390.

Thanks,
Kan

