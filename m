Return-Path: <linux-kernel+bounces-105545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5181D87DFF3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0368528178C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC0200C1;
	Sun, 17 Mar 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="chE3YDMe"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B231EF0D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706456; cv=none; b=M1mM6cEtGPmAT03x8hbFC7qCDzlTle255vjpHL3jlxdMXVU1d1CLUSdAuq4PX+V3q2n5E71XggL06f38DrON0ZhXa+PmXIkysX7i+TDiZrsqx4lHQxb42rU0DAdPX2CzzhdB+3zcEF3/7XRtx1EyH9ia02OxzszXzuDW64D2MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706456; c=relaxed/simple;
	bh=fPiplitVgmnYD5UAzfgYB5Z1+L6aE6sJAxOn2eHdJ7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czEyLmtRuqTqSLCm5NjAl3ngvAFW9zUPEqAsQucty2y7llOoWMloih7PjCW2HWnWQz/IXrcitEaQdcN9YRXVMN8PAULWu2ldySDyk+/hTCybZ87aV8HH8afq6A0llt647hEHu8T5pCm2MwpV29LX9mDIobO+w8tVIrZDXwkSS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=chE3YDMe; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id lwrcrYxG3PM1hlwtUr9QAV; Sun, 17 Mar 2024 20:14:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lwtTrLsf796g6lwtTrEWbk; Sun, 17 Mar 2024 20:14:07 +0000
X-Authority-Analysis: v=2.4 cv=CM8sXwrD c=1 sm=1 tr=0 ts=65f74f0f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=NXnYlt0Z4WHhSROVkRAA:9 a=QEXdDO2ut3YA:10
 a=1F1461vogZIA:10 a=5kKzt1m56AEA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TzB4OhMPZk/xYK2rPN0NNIIkS4DdL0xQaAXEDHa0Lcs=; b=chE3YDMeY1qMi8v2yT0h6U3zEr
	TE8rw0Xwr8uHqIUr16KChkwjr/W9i9TQZ7sOI4HEWJPuZJcZvgy4HXjrJMT0TlfU2aAbWR4CXpS0L
	CJyBwU++Wp7AQDwj7fMyZz02raB5s6nSYS0+qr2zMsFqz52VIpqomKE36MmCqsBpx9NPQj6GO1iUD
	4hFl1RO/SDXW0FHymG5HOJ/860bfznb8eoSdmIPjU1HAiC9fluLV012onOiriPXREXMSevxh6wZJ6
	4sHeug2vlENxlPKzuILwbFEBGCY7B5gnuTcL8bqt1yhWlvgkl7KDSUzsIH2duQBicc4/qG7B/wpZh
	E55GcNzQ==;
Received: from [201.172.174.229] (port=37922 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rlwtQ-004GeV-1v;
	Sun, 17 Mar 2024 15:14:04 -0500
Message-ID: <9849d742-a712-4369-8db9-8804e71be3bb@embeddedor.com>
Date: Sun, 17 Mar 2024 14:14:02 -0600
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
To: Erick Archer <erick.archer@gmx.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240317164442.6729-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240317164442.6729-1-erick.archer@gmx.com>
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
X-Exim-ID: 1rlwtQ-004GeV-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:37922
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFonJGDL23JNb5LMLBtOOBQ1KmwMKSsfUruxeVaHe/X0siHq/Iq5QIWufhMgy/Hrpu8+N+XoBZ37ZgaX5c0QbrQZmzMYThH10cKN+wv0E0DxvTvwvHhK
 3um+uT7Ej+m+eKqsEk8xIDKqkavPLftiKG36DcCqhP1du5M04OYOjvuVsZoVQGBKo6fd+7QECj6+Yk51/cb7FlF5md8kqh2p5PmgXrsjAkLQUB1sSLnHVeGp



On 3/17/24 10:44, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "rapl_pmus" variable is a pointer to "struct rapl_pmus" and
> this structure ends in a flexible array:
> 
> struct rapl_pmus {
> 	[...]
> 	struct rapl_pmu *pmus[] __counted_by(maxdie);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   arch/x86/events/rapl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index fb2b1961e5a3..8ef08b5d55a7 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -675,10 +675,8 @@ static const struct attribute_group *rapl_attr_update[] = {
>   static int __init init_rapl_pmus(void)
>   {
>   	int maxdie = topology_max_packages() * topology_max_dies_per_package();
> -	size_t size;
> 
> -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
> -	rapl_pmus = kzalloc(size, GFP_KERNEL);
> +	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
>   	if (!rapl_pmus)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 
> 

