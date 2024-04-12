Return-Path: <linux-kernel+bounces-143151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2148A350F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AB0287364
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C114E2F8;
	Fri, 12 Apr 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Im0iVk8f"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F05491F;
	Fri, 12 Apr 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943842; cv=none; b=bwSSqlIiqirlNos7U7JzyxjFkXCR5LbEibmxgn0pJ5Cno7MCWnip2wD7pOQeRwaeQj/32LhDSTjDRG26JHMW59Ny86YB3lNx7HzQuo3iyhq6W03owMk7MMZbNDSuhwwilLUcrpQwswnwRlMVkCF9jGVe5K2ezSQIwVCY1FH3o3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943842; c=relaxed/simple;
	bh=9jVpBA4jgJ0UG7XI8lXz3tsBG24mQMEc1vToCewTYO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBkShjob7DM6eL4mY7OI2oE8SXvfyS11UwRffEkb3NSZ6lkfFDKcBRy8XGicN0ZCIUxnHNRBwS2iZX+MlhadTWhmPooWEFmwhBXqe4i8KnGKseux+5HgOsR2qS5LHKkTG74nBVI/7OFpedhC2XDvDWSdcq6LeL5xnUIrf2LWbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Im0iVk8f; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VGP7R5WBkz680X;
	Fri, 12 Apr 2024 19:43:47 +0200 (CEST)
Received: from [10.10.15.20] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VGP7R12RYz67yx;
	Fri, 12 Apr 2024 19:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1712943827;
	bh=rz6jPUrsijT1INaAxqASzjJlCA1E00oo2UxdhuDoHkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Im0iVk8feRxQgKlsQWaCXv3LUGHwDcqreNg4bxaJ3/IOrXfx2QiN1rnYBfEc+f2u5
	 8MbqJsx4mJ8FaAweR4s/LxS3LCYE612Agy+eKqOKsD0gLkupmeXqyp8GmT5sJHqtiZ
	 kRuaHnbzajuZP5Rptmhe/G5mAFIlHj5p1NxY+ApA=
Message-ID: <1b48be5f-bcc2-4cc0-8a23-85c472168082@gaisler.com>
Date: Fri, 12 Apr 2024 19:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build regressions/improvements in v6.9-rc1
To: Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>
 <20240325200315.3896021-1-geert@linux-m68k.org>
 <8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org>
 <20240326181500.GA1501083@ravnborg.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240326181500.GA1501083@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-26 19:15, Sam Ravnborg wrote:
> Hi all.
> 
>>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
>>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x18), (.fixup+0x8), (.fixup+0x0), (.fixup+0x20), (.fixup+0x10)
>>   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>>   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
> 
> Looks like something is too big for the available space here.
> Any hints how to dig into this would be nice.
> 
> Note: this is a sparc32 allmodconfig build

I have a patch for this. I'll clean it up and send it next week.

Cheers,
Andreas

