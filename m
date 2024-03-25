Return-Path: <linux-kernel+bounces-117590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8A88B2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37A4B341B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0812CD97;
	Mon, 25 Mar 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bRWZkVTC"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1D76401;
	Mon, 25 Mar 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387477; cv=none; b=iWzf5IddlpESiOAXf0FbMw8OkEOzYW7LK1IneM/ypKvVhRaJ8Xng2JjJ9I5qJZPsELqVrCOA3I+ito7cmrqT113QlRELyO5UixVTOEKqfTOAAd8SX7LDAyKX7VeivD0bP58esKklNSGQtUK0mTAm2f61X4tCpgSaqPnUQ2zfppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387477; c=relaxed/simple;
	bh=U0tpeTPOyTpPTe351qE8OA5AoJGCat0VCds9PVfXYDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oFPpFxy7eLSc3RBBNX9IekYhUYMiHcJ3e34U29IMcfy74qDB1bEs3RCpef4PO2hMqMrmSJBbuQQ6+Sk5yG5WTf+loiW+ZsWE4FIil+S3lUoKfMcIoMfOnCmkEIUpVjbmmQxiXIyU8rUQIG2uAAGDjDgVQUkGhhYaYlbcD7vgu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bRWZkVTC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711387398; x=1711992198; i=markus.elfring@web.de;
	bh=U0tpeTPOyTpPTe351qE8OA5AoJGCat0VCds9PVfXYDQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=bRWZkVTCzppdEH7uqzBNqYMs/I+Wvd1v3zhBOlzHh3JvP7VRPM7M14eaJdHwffT+
	 gAH4F3Ndy2JRndaz0L++yVp9mVuezqn8yAisWi+T/7ZgpRVDpmmgygh6AjolOIvit
	 kNb2ajA0LVr2iMG7p2dRzNlzS7KKaTG/7k/H9gJhARf9pzh47AGEYI19RP0OsWRVN
	 7MZx3FHo/G8doNCDXvdMO3q2X4WytGjKYFc6BVjpNz2G8suO1gq1/n0fe5ADPBlll
	 uqD3ntomL9G/wqtWWVR8a0kcq7740Q1sbGpaIZHGqyIe+Zw4JfmDK3UzuDFfaDaUk
	 57ZRDApFvkWovxo26Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1sExm83qRV-00QmJk; Mon, 25
 Mar 2024 18:23:18 +0100
Message-ID: <8bb50ff8-ff26-45a2-a35b-956c81eb7e80@web.de>
Date: Mon, 25 Mar 2024 18:22:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] perf dso: Reference counting related fixes
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>,
 Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
 Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
 Andi Kleen <ak@linux.intel.com>, Chengen Du <chengen.du@canonical.com>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240321160300.1635121-1-irogers@google.com>
 <20240321160300.1635121-13-irogers@google.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240321160300.1635121-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pskIHGf+C3w8pWYXN3g6cdHPcoa+SpW+UpkcrSPDmFidRUj6+xn
 88ySkN74QP0NtfTP2Lmo2qRkZZ3BIeQXWNFyJxVA8ZeybIhJNLIdyR2Sahum1O43vMwyRuw
 OOV0NDeDZFiJWzgDjCoOtKCVV901Od+NWE8VGMLlycV6fJOfYdsBeBGYjgWmaqRr/bj0TAS
 6rlKrKSuiM/YlNuiwzFlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v95kMyinJlk=;E5e5fyRIagm+9ibeKx83xJAyNZz
 MG0zuOKI+XCLrx6OgP0qgokntj0JnQvTBvQMTa28oqFle6B2qKuHjYsmjjHJXabJaj3sc9vyl
 KUMIK4mTV6o8l19R43uwNK5OVqgZWnfPTCJ2OheBT7420/Rl2RxCFWs4DThYp9PvswCsD4Dqv
 xRujJQTCA6/0kj6hMF18p/71h3RtcIj26TquPK9RoZ1lv2n0lYS+/UON+7JmV+k2dDUUlx1pa
 qFftIZa+lXY2qx0aKqrWSBD72WMwtM4k/C1OEfWjhNkwFwGppH27Yxd1Spq7/A1GBKXl4CYFC
 l8RnDUTn9vb04F7DiJkxD+elzKO3u0fHvMyLsG/NxRINlHa52v+PWa6RKncIiPSUwudlJj3Fz
 vhz2Eyzr8ERTSI7brjkeJiIDMnw/XySuFb/0sGgy7VLOFGZ2m7U9cmHuVj2GpaEhrasRNkuDM
 KVSzDv4PvTqmWOgfNF3BKsR77kJgkHsYKQ1PN9aPDL3vxThLNvuCCVn8Swc45NHTn1bxx5e6Q
 byy17MQnYuxpepr3KpGJg3y8n/4WFVzJgeh/yBZ1Ivb0L0cac+DU596y7PoCfAT2kK31Yh9SA
 NMpv8qZBaQLFKB9JPbQMbMGJDRG88rF4YvS/Rj7o3ke7RFiqp5CiP17gDFupq3TQe76Bu2Ena
 4z8FnxaUz5WpJnZYrTu1rCdKApYJJtIDUFRhjwBxdI3KTKLKtKLcyCRFkaEP+Grfu1l23C8RC
 /waejXJa3cUUWHC5CQsf9NbKpWlVuR2Otbnve4TYOMgbDH/nF9HDqLLr2CclBx4v8R5AM6TcX
 It4mU2lidzptegDjpdnhsHBkJivLO5bFhDrJKRH5J5Y4I=

> Ensure gets and puts are better aligned fixing reference couting

How do you think about to avoid a typo in the last word of this text line
for the final commit?


> checking problems.


Regards,
Markus

