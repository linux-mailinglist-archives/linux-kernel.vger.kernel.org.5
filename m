Return-Path: <linux-kernel+bounces-21808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F63829491
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F228A702
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D53C461;
	Wed, 10 Jan 2024 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ZxeCzBw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101783A1CF;
	Wed, 10 Jan 2024 07:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F50C433C7;
	Wed, 10 Jan 2024 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704873539;
	bh=lE9/mgHGGaw+iCzOhrYVTWyL3krx3bVGhgsCRq2dNtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ZxeCzBw1fNktCiKJyKjgyS1UxzrXlwuino0MaqulPIBcDECORT42uxKZ4B3u1Jkw
	 Mus5ASEYcxCX750f2SqbaRWiJHc4krjZOiLhebpeLF7rZSk8CurOosheNz19o2wDfW
	 iWKW62iH1b8nQtmX6+MrVfi8C9gP0kJ3VQp8AE/c=
Date: Wed, 10 Jan 2024 08:58:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Lieven Hey <lieven.hey@kdab.com>
Subject: Re: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Message-ID: <2024011043-unearned-manned-12b7@gregkh>
References: <2024010711-skeletal-material-15e8@gregkh>
 <20240109214955.451513-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214955.451513-1-namhyung@kernel.org>

On Tue, Jan 09, 2024 at 01:49:55PM -0800, Namhyung Kim wrote:
> From: Adrian Hunter <adrian.hunter@intel.com>
> 
> When a program header was added, it moved the text section but
> GEN_ELF_TEXT_OFFSET was not updated.
> 
> Fix by adding the program header size and aligning.
> 
> Fixes: babd04386b1df8c3 ("perf jit: Include program header in ELF files")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Lieven Hey <lieven.hey@kdab.com>
> Link: https://lore.kernel.org/r/20221014170905.64069-7-adrian.hunter@intel.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> [namhyung: use "linux/kernel.h" instead to avoid build failure]
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/genelf.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h

