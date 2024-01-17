Return-Path: <linux-kernel+bounces-28671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BB8301A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F9E1F21E31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD714266;
	Wed, 17 Jan 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L6DWNNi4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AC1D553;
	Wed, 17 Jan 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481733; cv=none; b=MFHzs4odWE5xF+kUdm2uOH33G8ze25MUN6pxHYKLccCm7ep41rZ/buDH4S8V3drvFpZ8rKxpPxDVChc54YRO2VbtspK/B+EL1ID874U0HDgGTn3v8whzc+6oqK+0eN2k8QNNhFHYCdDR0+QeHa15LCUFxwm/rWnkVg9yLbt5H6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481733; c=relaxed/simple;
	bh=ywn2BheWF/SgKkCn9EgM/xMM+cdHtAD0lJTccBaS+aQ=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=qsV0ThjdoZ5Bk4K13wxQjqQEl1t28H6vw4+Dg+8i98wqZj3UZIeu8lUa617k0dvC5lMctvMOkPrNIGKmEolKDeurR4wzNhIoy+rHwNVvKTdLnsgIcEtIbc2kjxvnataaIAby8NmHLt0I18s2w5JaObs9NyxFjyWwiiPaiNFoqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L6DWNNi4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40H8MuDa016556;
	Wed, 17 Jan 2024 08:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jh7nVMDwJONksYZIJ6Xb1p4mNbMBUI3UkGlJwPGZ2cI=;
 b=L6DWNNi4eLkMMQD+mEdcdm7f+nfY5BlsfXjQJQxt1Wo7nk4JW8oNK//4+U/6HwIPwlw/
 FCjr4vzygNbf6rk6WwoayliT0nHTdaGxr8RnRsFOIm0aixaA4BVhkf6jiZecpb+50kYm
 LfB+HtSpf4VoGGc5auRvyw5GxnkyDplc5OY/wvapLWGu8hTn+yBcy9Tk5ZHDUKhotRw2
 Qlvp82Fjj0sFJezC/CeDa2d8koY0beTPQmWaIdoOpbeeQ8IuJ7jovbZD1dP58uTK5MLV
 3OjFB5Z23WAJZycYfUr3gnXpMHzqtZHUphU91VJBhFg6rwtBNOYyfUjr8yE3FzGBjyHh Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpbb0rs47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:55:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40H8W9tX004472;
	Wed, 17 Jan 2024 08:55:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpbb0rs3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:55:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40H8d2Fi019538;
	Wed, 17 Jan 2024 08:55:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72k3v21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:55:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40H8t0F565470824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 08:55:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F18120040;
	Wed, 17 Jan 2024 08:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8272004B;
	Wed, 17 Jan 2024 08:54:59 +0000 (GMT)
Received: from [9.152.212.51] (unknown [9.152.212.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jan 2024 08:54:59 +0000 (GMT)
Message-ID: <240dd956-5f72-4330-b7d8-5c3f8711cb37@linux.ibm.com>
Date: Wed, 17 Jan 2024 09:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
To: Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        changbin.du@gmail.com
References: <20240117051104.2147643-1-changbin.du@huawei.com>
 <20240117051104.2147643-3-changbin.du@huawei.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20240117051104.2147643-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NyC2iOBd7ExhZMbVgQUUS8HoaGkXnGx1
X-Proofpoint-GUID: VGCL7Eh4lXeZMD5qGM7szBJpCzgCRxa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170060

On 1/17/24 06:11, Changbin Du wrote:
> Currently, the instructions of samples are shown as raw hex strings
> which are hard to read. x86 has a special option '--xed' to disassemble
> the hex string via intel XED tool.
> 
> Here we use capstone as our disassembler engine to give more friendly
> instructions. We select libcapstone because capstone can provide more
> insn details. Perf will fallback to raw instructions if libcapstone is
> not available.
> 
> The advantages compared to XED tool:
>  * Support arm, arm64, x86-32, x86_64 (more could be supported),
>    xed only for x86_64.
>  * Immediate address operands are shown as symbol+offs.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-script.c  |   8 +--
>  tools/perf/util/Build        |   1 +
>  tools/perf/util/print_insn.c | 123 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/print_insn.h |  14 ++++
>  4 files changed, 141 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/util/print_insn.c
>  create mode 100644 tools/perf/util/print_insn.h> 
..

> diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
> new file mode 100644
> index 000000000000..fe035efe8cf6
> --- /dev/null
> +++ b/tools/perf/util/print_insn.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Instruction binary disassembler based on capstone.
> + *
> + * Author(s): Changbin Du <changbin.du@huawei.com>
> + */
> +#include "print_insn.h"
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include "util/debug.h"
> +#include "util/symbol.h"
> +#include "machine.h"
> +
> +size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	for (int i = 0; i < sample->insn_len; i++)
> +		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
> +	return printed;
> +}
> +
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +#include <capstone/capstone.h>
> +
> +static int capstone_init(struct machine *machine, csh *cs_handle)
> +{
> +	cs_arch arch;
> +	cs_mode mode;
> +
> +	if (machine__is(machine, "x86_64")) {
> +		arch = CS_ARCH_X86;
> +		mode = CS_MODE_64;
> +	} else if (machine__normalized_is(machine, "x86")) {
> +		arch = CS_ARCH_X86;
> +		mode = CS_MODE_32;
> +	} else if (machine__normalized_is(machine, "arm64")) {
> +		arch = CS_ARCH_ARM64;
> +		mode = CS_MODE_ARM;
> +	} else if (machine__normalized_is(machine, "arm")) {
> +		arch = CS_ARCH_ARM;
> +		mode = CS_MODE_ARM + CS_MODE_V8;
> +	} else if (machine__normalized_is(machine, "s390x")) {

        } else if (machine__normalized_is(machine, "s390")) {                 

> +		arch = CS_ARCH_SYSZ;
> +		mode = CS_MODE_BIG_ENDIAN;
> +	} else {
> +		return -1;
> +	}

I have debugged your reworked patch this morning and discovered that
it was not working. The issue turned out to be function machine__normalized_is().
The first parameter is passed to several functions before the comparison.
The calls executed are

   machine__normhalized_is()
   +--> perf_env__arch() --> called for first parameter.
        +--> normalize_arch() --> always returns "s390"

We need to change the second parameter to "s390" without the trailing x
as indicated above. Sorry for the confusion.

Thanks a lot.
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


