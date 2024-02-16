Return-Path: <linux-kernel+bounces-68627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79092857D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0939D28882D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2773129A6D;
	Fri, 16 Feb 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="V4kKaAhP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606878695;
	Fri, 16 Feb 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089260; cv=none; b=DgRoUUjlEIYggB14RTeHQD0NFOLGotN3BKMO69U3MDuBwj7V0qFnBHS44ji48DR1GwOZH8bMe3LNd2vVieSyt47Ip8CFW4POmOxHhpNpjD51/hbuVvAjYwTuhK/nUUdwQyLgsx5hMphvzX/ZGK2cRIpsMUGJzgvRI3xCuL6lZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089260; c=relaxed/simple;
	bh=f0LUsS9SDzP69bj7Fmp7ctSUX2hl6rFEkJO/i6dzlZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FOjdtX3cFRIK5osdgx3+pM0mGEsfjv1xFRhVMld1y1Ktg2gvZqFoannx7pgaailOWDjvcLLYfEhdAzClGOCjCavH9HZ+dh0J6qGx1n2lBNMfsOYBQyPXSWEzbj3zf8S5j9fJjJzXGE6D0TUsVnOuKFnQBfn7qvJLs1J4B8aaoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=V4kKaAhP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708089236; x=1708694036; i=deller@gmx.de;
	bh=f0LUsS9SDzP69bj7Fmp7ctSUX2hl6rFEkJO/i6dzlZc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=V4kKaAhPbVZ5jB0TiDaes3SlMfjWRvJ4pZ25o6HFjeXnfmKKpqFJIwkSdrB1Ogke
	 bWRWvZzR9EBWnbf/oHHYaUVywBrf4g3Ze5+ZGTDrf8Spyp9a4zQkdJLVTrzgiRZBh
	 OmKf+dHPiPiHhmqhU8jXDJ/2FNF4p8WRutFIJj3BMTCW3PRGlqT0WJzC0QEVLglGo
	 pGLK4vvzYp6U7IH3T1ziofzhXsBMAwiMOP8fWhqi2Eh93HabA0mO9oulRTTi1Dd63
	 OPKvCcJzCZPTABn0qLUSlm8egbwH+NuihLPWYwWCkyYmNsAV0kEP2U1nzJgug5Qfp
	 DDUmJFSOYpgJiXoq5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1qvWVA3Z27-0164q4; Fri, 16
 Feb 2024 14:13:55 +0100
Message-ID: <2eac5921-1bf4-4013-8002-f62a96d71829@gmx.de>
Date: Fri, 16 Feb 2024 14:30:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com,
 James.Bottomley@HansenPartnership.com, linux-trace-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211224314.169314-1-max.kellermann@ionos.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240211224314.169314-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lp3J+gk+fOmyD1YDJc2WUVnFI0sDL9yYEI89g3O1Z/HwLiqp5D6
 niRcNqXUi9ZDjEag6L1hF0qBAGHsW/6dD0pCSV2ZwOpa9kMbYiHAc371hE3usDlBPlq1E0U
 TItUW741aD9oe7w+O3okXpz6DW0ZlFHXO8OlMYCel7qejjQst3NUPS46NG4PPlStxnCt+A+
 77ifW3Kor/IXyfauP/h+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:whPwJXuJBm4=;4ST2qXZ2d/a/PxkhogzX1I3vrw2
 m27z4gJeBYQF/1tXxcUKSuZSx0nRsHI6sfa18ZZQ95X46RgzkygFBl6D2S+Q2w8jJDzENV6P3
 PxcirTUAmHXlKj0Q8H8eu4BLALD0bOfVjaHNPXbH7NHzkUT8CLAWEZWtdg2V6pGarweaEIwpY
 aJFimgaQ6FqxwDrR5SJrkyC3yjpkz5p8RFsUIiZqRwJWOkyyQe8bEuZtXU/N3b3kQnWRZxNsZ
 F0uosfueK6yFKMaRUoHIYaplw4SznCMWg89YKLWgchtUuE6iignm5NS1fRsvil2HgB9foHiGm
 6LH9MEDYprVpPVS1UV1u3iqiWIpS+318eE8fyVAQI5jrJiSC8+eyTEj8K0sz25v768s4eWnLM
 OV5N5w0v8d0TFqjt879x+uSE/HsN3TIEHwHuIo/IcnseWEnlwCeeY3fsVc/IY7hvDIAXZPj+8
 5kzfy0G2KYZ6WYXl842/1Pnzc95sgzOTpsZbFy1QudhPXXAWkTSw4hLy1GoR5ixABNPWaXghv
 VK+1YtG1b1QZhrSDIWta9T3gbZCvSJZZx6bbL7CUzrUulP8a8J4ApPPKJGTn1feWTl7bJRW15
 qQ6d0F+IezU2LouzluLfRzMxTqNAUt30y6vDvi4dH/eOAps9BgxvuyyuGhmNV/0VNVKeZxZke
 tvzLEUUAxss9VAzTD64JifYf+1l95HpVlFdY4dRsjorosle9yKeWAc/5BPkIf2JUsGLJ/ZIWM
 xSiy3ibXo8jmaUvVppSjbI1H68j4DPfcVrsKwFPXLKlHXrYStviKCqSTiFAqFlhqtU9SiHwEb
 OaIoizpmkBT03C/DoduCWFYUrPE8umGTI2KQew7fd4CUE=

On 2/11/24 23:43, Max Kellermann wrote:
> Fixes a bug revealed by -Wmissing-prototypes when
> CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:
>
>   arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ft=
race_enable_ftrace_graph_caller' [-Werror=3Dmissing-prototypes]
>      82 | int ftrace_enable_ftrace_graph_caller(void)
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ft=
race_disable_ftrace_graph_caller' [-Werror=3Dmissing-prototypes]
>      88 | int ftrace_disable_ftrace_graph_caller(void)
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>


applied to parisc git tree.

Thanks!
Helge


> ---
>   arch/parisc/kernel/ftrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index d1defb9ede70..621a4b386ae4 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoli=
ne(unsigned long parent,
>   #endif
>   }
>
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRA=
CER)
>   int ftrace_enable_ftrace_graph_caller(void)
>   {
>   	static_key_enable(&ftrace_graph_enable.key);


