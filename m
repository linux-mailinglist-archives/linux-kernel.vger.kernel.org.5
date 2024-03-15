Return-Path: <linux-kernel+bounces-104539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA05087CF69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C341C21315
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93E3A1CA;
	Fri, 15 Mar 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+VG1sbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4DD182AE;
	Fri, 15 Mar 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514143; cv=none; b=O5qPzPsoEcU6LnQK5VFd6mcREan/aXlcbdjlifrVknxlqNfAlvCXFkQu5aY5BLd1Iu0fGN5wgp0CLOnPSrAmjrLeg6FJhyn/HAZ1C7TmCNHZlYJI0wwZfQQhQ2vAfxM4cpnG/Oe2TzsTflvxoJmMkUA2IwOJWAokKuoPJXAX1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514143; c=relaxed/simple;
	bh=SmLsNeaSHfqy9oNwOgDm4ZXuYHqlYA4QDtsm+mo9gc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF7etxJbLeRtSKVQuZlrtRQibhZSAAUfnwUFczQ5KTmhdYoCy9BP9DAJ+jznkg3bK2o6gaB74UJ2Zl+PUuIVHdvD+YnyAyZk43YptsxGq+pE+Z09P5CxRKB5IWeMvFp++3LmrWi801Ui264zDxZr4tE6EvZv3WdRrF6ONbuueJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+VG1sbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36AEC433C7;
	Fri, 15 Mar 2024 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710514142;
	bh=SmLsNeaSHfqy9oNwOgDm4ZXuYHqlYA4QDtsm+mo9gc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+VG1sbP28NZspUKIL65n/kqQ1T10GleAfJsuxsUriwBJJNCKxDzwZUhnF3vlA8Em
	 IRjJjLQarZbOaT7qbLXLEFvZb8oW7Uhq87mz6p8tuVfl6iQGPRiLiETr64tBqdcT/2
	 +UMQ83QOcdweelhxVONjFEUbkAzVqHD1uV1pxzA3awLR11+KU+8w0q3JXzRtTvMCUK
	 458Y62s5tHAdcSXkXKKluf/qFk995vFJPEurLmDBGabAng8DRMNCGItTC5ctuNrvIK
	 ceOSvoUPYesQaq6zrhrjJNuMS8VpfGKyAiS5pJmA77A1oDOgza6YNrpNNba1J6LSZx
	 /oO5fnD8UfAYg==
Message-ID: <32958f50-b713-40ba-9e12-2a1b5667a91f@kernel.org>
Date: Fri, 15 Mar 2024 15:48:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] tools/tracing: Use tools/build makefiles on
 latency-collector
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, John Kacur <jkacur@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1710512430.git.bristot@kernel.org>
 <f2851351a1561a59a273a64de561022b1af4edcf.1710512430.git.bristot@kernel.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <f2851351a1561a59a273a64de561022b1af4edcf.1710512430.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 15:24, Daniel Bristot de Oliveira wrote:
> Use tools/build/ makefiles to build latency-collector, inheriting
> the benefits of it. For example: Before this patch, a missing
> tracefs/traceevents headers will result in fail like this:
> 
> -------------------------------- %< -------------------------------

Oops, b4 is interpreting these ------ as the '---' separator, and is truncating
the message. I will fix this in a v3.

sorry.

-- Daniel

