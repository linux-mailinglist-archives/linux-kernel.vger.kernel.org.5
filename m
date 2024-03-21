Return-Path: <linux-kernel+bounces-110784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756958863E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30314283110
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45785125BF;
	Thu, 21 Mar 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+z2xijF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738929A9;
	Thu, 21 Mar 2024 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063083; cv=none; b=fpgAVXSYhc09AMJxElFr7hyFjUEwY0GRh3if63Q42bKjWBmidj+3DMqwKw/viwL6pA480VtgKO8f23n/SJ+mmEUjIW3grJ9i1suarzvqh/Re6R3RZH9mMSF2mCl0iHhXPPyCAl5MvevJX3WLUgd8rEwDgqA1znOxDqqwdNrDLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063083; c=relaxed/simple;
	bh=ZoOkFJsh+uSSpKYXxzFr4KIhoY4cpuANvOnEsGOE1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqGQE7rjzKqywZpU1/l5UOTDnlEy2Mtvmmj4fvq5ktqbIPboUxHwLtiNB1nwBYPJuiV9JeTfjf054JsxPIK3f83IBQEIwUpwYFabb3RFer5iRGFAG8eSCy3RMH5wZ9IEkAJPJxGZeElmXE5gw5p1h+zSapa6C59DQpZDAv0DMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+z2xijF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3227C433C7;
	Thu, 21 Mar 2024 23:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711063083;
	bh=ZoOkFJsh+uSSpKYXxzFr4KIhoY4cpuANvOnEsGOE1TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+z2xijFTomwPiOET33PGAmxnIXIDkslIUIJF325ALk9fgQU0becdXZHk5JeAPtSd
	 Y4qlajUsDco2WuRCSrsB9R0K9MwtZJhW0dz6zkIQTnPr7dGeFmQwGg4p+Q+Urg8Vu/
	 yPwHEaLVYa4uhBgGNI6CrBjpI0TIC15xl3MmmLxs7bUjyWhp8mTYMgy7IEQ9Wz3Zxr
	 vAJvpllC14h3boNMIGhIksJMPMHMmHgWE+RBpm/Ia6jIgHa6M4JsZl6P/j7T+ulBDd
	 eGvuPUVKKI7FpFylG361YZEjo10vnrWGmDt8KbZmGVEZJ5ZWCJ2aA6oEwzbyvdw+dC
	 sn1vzbITDybZw==
Date: Thu, 21 Mar 2024 20:18:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZfzAKMlYY7IkWXUg@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322084131.2316eb8f@canb.auug.org.au>

On Fri, Mar 22, 2024 at 08:41:31AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
> 
> make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.  Stop.
> 
> Caused by commit
> 
>   f122b3d6d179 ("perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument")
> 
> Are all these new commits today really destined for the current merge
> window?
> 
> I have used the perf tree from next-20240321 for today.

Ok, maybe I opened perf-tools-next for the next merge window too early?

For this merge window I think Namhyung is switching to perf-tools,
right?

From your reaction I think I made a mistake and should have opened
perf-tools-next for v6.10 stuff only when the v6.9-rc1 gets released...

- Arnaldo

