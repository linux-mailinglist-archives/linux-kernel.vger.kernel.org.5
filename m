Return-Path: <linux-kernel+bounces-135355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A989BF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7CF1F227FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0D6F08B;
	Mon,  8 Apr 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Z8MIPen1";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="MBFcVCR4"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058B1C0DE8;
	Mon,  8 Apr 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580595; cv=none; b=UcR7g931y3fiwRZAm80eKT3aouTDPRbkb8oC2HzIkNPUcaDnLUJBnu85CgYpt8QWNJydRee90cC6S4IGX+qn41R9XudthGqBUZcZb7kHNLdY9i23jlIVe2WSXaCog6+h0PEhFmyTYDaHga9+czy3zaK1xynYaNAucPCBJb2jNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580595; c=relaxed/simple;
	bh=UeYcGq37CDN7VKkwoTNLCUWAOzA2D/z/oBg4gvur3Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiQROK1cc48CNoyTDEdp7haqOQsjTxwbBbWGeSZCcxfOSUD4KUNWh/T2dEyY6QMAv5Ss6xZO6IB+pTRSHMGe0vbd5h4osyPmSD83PszemJLjAyZNv3x/U8jGRVJSg69UUmlbyyaic3jWJANUyIHdapu/4/OwjTPqRJ/BXsfCAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Z8MIPen1; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=MBFcVCR4; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 5BF32C020; Mon,  8 Apr 2024 14:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712580584; bh=sW0O3UuAkGmxozVYNCUjZ+LwPS0GlqwCSzkatBIT1fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8MIPen122SH9rqCIV2PrBZ3woCMKx0UKV45OUZgp55pN7WjL84rWv3t/aFe7eKV+
	 tQNZ9zTV+MHZo1OVGggsjC92v9tPJx5KWgIGDFCVhzrVd8UnWz5D6zVQiF7J+kTKjk
	 azy4h7dMpO8vlliYwRM5wz6OAT4qH5n1v5+zYoBB8dW6Yes9vp2CcVfR8j7jqzr3QY
	 BxiQy6h1yvf/S4nMfp3iHgunvvcAX+iVWqBR13Js+yibjZCJ+rjepGgLnF8urG7Kpg
	 Np7Y9Metd1evUvZ8qyyV2s3xGA10HHVEc9CVINkgG501k+2P3s0NNVAn7+qnhBzNuJ
	 FhCDuSn5AjRwg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 66B77C009;
	Mon,  8 Apr 2024 14:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712580583; bh=sW0O3UuAkGmxozVYNCUjZ+LwPS0GlqwCSzkatBIT1fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBFcVCR48YIr43oJzAY9jvP0rmb/Mn9UltewHdcjnRllg8qvcclMu/lReqeQLY3IM
	 3iw/WuXyWHTMdpHDaHItNT0hPRot6rpIFl6tIOho2byvD1LirPj48V0lDJ0FvKALGn
	 6KtChdABVtFcF9Xg8VP6SzIcchRcoqx7SOISgAunUaErFHccViyPRbP9nxVQHar3Qi
	 aIA7f2LF0H8fUkzOC89sxfxkX/B1AN4BH4IAR8m9tg8KETFhXcqOBDXpzpCmBhbCZ1
	 1EBvxkGvbARLJbnTORtA4DkHNcRXOACbcYoVERJy/SEyrOzconLmUsz+yTNbZQpIJC
	 ovaxRF2ZeHITA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id dc276578;
	Mon, 8 Apr 2024 12:49:35 +0000 (UTC)
Date: Mon, 8 Apr 2024 21:49:20 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf parse: Allow names to start with digits
Message-ID: <ZhPn0EwXf_bPBj-p@codewreck.org>
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
 <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org>
 <ZhKTrUPbUnBviQYK@codewreck.org>
 <CAP-5=fWT4=yT9rxKmR4ing9i-EffRQnjTP355wU-fFN1Mfnezg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fWT4=yT9rxKmR4ing9i-EffRQnjTP355wU-fFN1Mfnezg@mail.gmail.com>

Ian Rogers wrote on Sun, Apr 07, 2024 at 11:32:31AM -0700:
> Try adding PARSER_DEBUG=1 to your command line, I need to do the following:
> ```
> $ make EXTRA_CFLAGS="-Wno-error=redundant-decls" PARSER_DEBUG=1
> ```

Thanks for this hint!
I tried with that earlier and couldn't reproduce either (e.g. it works
with this patch as you observed), looking at my shell history it turns
out I was just sleep-deprived and I had forgotten the '-e' preceding the
probe and didn't grok the error message...

So this patch is ok.

> I think Jiri's e-mail should be jolsa@kernel.org.

Ah, right -- I used the mail he actually sent the diff with a couple of
years back, but the address in maintainers is jolsa@kernel.org so you're
probably correct that it should be prefered.

I can send a v2 with just this address changed, or whoever picks the
patches up can fix the commit messages for patches 1 & 2, just tell me.
-- 
Dominique Martinet | Asmadeus

