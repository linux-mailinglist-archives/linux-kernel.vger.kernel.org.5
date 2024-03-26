Return-Path: <linux-kernel+bounces-119673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87B88CBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708CBB2303D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7608627B;
	Tue, 26 Mar 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="nyeOTCdX";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="rL+ukD2Q"
Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D24CE09
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476974; cv=none; b=lOvGL8+cj6v5jN/o9bUrSOmnY4pXRvLwN4gv92m/BwDMA2M9yz1sfYU16wRgY77CxfqJCP9dhYKSh8AWonxtRnYZtLcyxi3J1EbNnKtdzwUKeu6desBDhcwsJ4VbFsga/nw/XUZIvc967uZaEnGrYVSvtVaP/hOOLtQWlROf6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476974; c=relaxed/simple;
	bh=OQxXZfgehtfbFagTkSKRUD8y2GHLUHk2uynjOfd4oRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chajFYIPzXgkR6dunbQLOWt4jFOn4Kd9R8HwcL/3KPo/om2KvhxjmQFyJvfkKnOTNQPCx8vO1Od43YAStVqK/CNttebA4Zb1koM/MAkPtiS1PE9v7wY2zb7H+kZxs8MT197GliprKpXDmA4YduBNCSB1LQzHfCRxIlBWJxUERHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=nyeOTCdX; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=rL+ukD2Q; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8cfX7j0cZTLxYnTUI6w58EoQmIDSw6kaORCfZyfLSls=;
	b=nyeOTCdXkrX+AnYb2SH2o8UNaN7MEL/eLOuR/HxjUcCojfmUxEf1IYSvFe57aGwCXPRpwJnc2eKvF
	 IgVer08UY4ywfd6yHdwNmVKKsRplrooqtKDG3xkplHga149okVZxGGy9GInR2g3HT1EKFlEQgQiI6/
	 UskNZ+kb3sCMlzUq7OWUJ8PNQG9121mKwNR04NB58zJFOYpyjgEF4Bal4nwnL9WKEfF5dYXjMgU4fa
	 ufj3SWJcgNd/3HKna6TzqZNQOCM8nFm4hnfFS26/dBKYNRmJso1M4n6mF9Sl0icrUSk6rEE+NCUHfW
	 Ff2IMnIPUeikUZZpj8PhtuY9h0mersw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8cfX7j0cZTLxYnTUI6w58EoQmIDSw6kaORCfZyfLSls=;
	b=rL+ukD2QXe4F+m5MLDkbUa/qyyilhQ/TiMT4rGWt3HqeijcmTmhKSIz4EVkcvr5PlEK0+Oj/0biOq
	 Ngc23tKDA==
X-HalOne-ID: c19233ce-eb9c-11ee-bd8a-9fce02cdf4bb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id c19233ce-eb9c-11ee-bd8a-9fce02cdf4bb;
	Tue, 26 Mar 2024 18:15:01 +0000 (UTC)
Date: Tue, 26 Mar 2024 19:15:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-mips@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc1
Message-ID: <20240326181500.GA1501083@ravnborg.org>
References: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com>
 <20240325200315.3896021-1-geert@linux-m68k.org>
 <8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org>

Hi all.

>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x18), (.fixup+0x8), (.fixup+0x0), (.fixup+0x20), (.fixup+0x10)
>   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

Looks like something is too big for the available space here.
Any hints how to dig into this would be nice.

Note: this is a sparc32 allmodconfig build

	Sam

