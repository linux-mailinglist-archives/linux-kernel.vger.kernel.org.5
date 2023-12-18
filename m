Return-Path: <linux-kernel+bounces-4349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E5817BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525F3282203
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9BC7346D;
	Mon, 18 Dec 2023 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVXLP8iN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9674087;
	Mon, 18 Dec 2023 20:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF75C433C7;
	Mon, 18 Dec 2023 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931311;
	bh=kpXVz9PvRV+yBmv+nia5KSt6ZJ4jUse2LKadXu0V02A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVXLP8iNFWufEbY2HI3n0/mtxhbcgCKJZpodg8x1LWUzhXUG+iVuFf7JAYfWrdiCo
	 xLYOOwjwGZQFSfTZYtkZpcNARwl88o1B9tmvYiSgLjXwEqJFGLdVPsNbtizrHTmjW1
	 O8S7KJnEapCIW29DsOmoZJhPZs0jhnDwTYwweOaGajV/thyLCnMifmIXCWtxbpb4Kz
	 +1RjXp0GCSMs7CEXaNeIB9kJOB+ZC3ZgfqMZ9xV9e5E2PwwwW+V+w3doufDh/gQnBk
	 4yv6OmAzs3ZB1gBZxZad7obdk7E+D2Cn6OO3vy9qyV45xSKlbjFdDPj8Ryt6+5SzYV
	 HQrCx3wTFcbzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 013C5403EF; Mon, 18 Dec 2023 17:28:26 -0300 (-03)
Date: Mon, 18 Dec 2023 17:28:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ruidong Tian <tianruidong@linux.alibaba.com>,
	Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Tor Jeremiassen <tor@ti.com>
Cc: linux-kernel@vger.kernel.org, james.clark@arm.com,
	coresight@lists.linaro.org, suzuki.poulose@arm.com,
	mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 3/3] perf scripts python: arm-cs-trace-disasm.py: do not
 ignore disam first sample
Message-ID: <ZYCraiG_hpwBg9CH@kernel.org>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20231214123304.34087-4-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214123304.34087-4-tianruidong@linux.alibaba.com>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 14, 2023 at 08:33:04PM +0800, Ruidong Tian escreveu:
> arm-cs-trace-disasm ignore disam the first branch sample, For example as
> follow, the instructions beteween 0x0000ffffae878750 and
> 0x0000ffffae878754 is lose:

Leo, Mathieu, Tor, Al, can you guys take a look and provide an Acked or
Reviewed-by tag?

Thanks,

- Arnaldo
 
>   ARM CoreSight Trace Data Assembler Dump
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000ffffae878750 phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
> 
> Initialize cpu_data earlier to fix it:
> 
>   ARM CoreSight Trace Data Assembler Dump
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
>         0000000000028740 <ioctl>: (base address is 0x0000ffffae850000)
>            28750: b13ffc1f      cmn     x0, #4095
>            28754: 54000042      b.hs    0x2875c <ioctl+0x1c>
>             test 4003489/4003489 [0000]     26765.151766034  __GI___ioctl+0x14                        /usr/lib64/libc-2.32.so
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000ffffa67535ac phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  .../scripts/python/arm-cs-trace-disasm.py     | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index c9e14af5b58c..b1eb4293cbef 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -190,6 +190,17 @@ def process_event(param_dict):
>  	dso_end = get_optional(param_dict, "dso_map_end")
>  	symbol = get_optional(param_dict, "symbol")
>  
> +	cpu = sample["cpu"]
> +	ip = sample["ip"]
> +	addr = sample["addr"]
> +
> +	# Initialize CPU data if it's empty, and directly return back
> +	# if this is the first tracing event for this CPU.
> +	if (cpu_data.get(str(cpu) + 'addr') == None):
> +		cpu_data[str(cpu) + 'addr'] = addr
> +		return
> +
> +
>  	if (options.verbose == True):
>  		print("Event type: %s" % name)
>  		print_sample(sample)
> @@ -211,16 +222,6 @@ def process_event(param_dict):
>  	if (name[0:8] != "branches"):
>  		return
>  
> -	cpu = sample["cpu"]
> -	ip = sample["ip"]
> -	addr = sample["addr"]
> -
> -	# Initialize CPU data if it's empty, and directly return back
> -	# if this is the first tracing event for this CPU.
> -	if (cpu_data.get(str(cpu) + 'addr') == None):
> -		cpu_data[str(cpu) + 'addr'] = addr
> -		return
> -
>  	# The format for packet is:
>  	#
>  	#		  +------------+------------+------------+
> -- 
> 2.33.1
> 
> 

-- 

- Arnaldo

