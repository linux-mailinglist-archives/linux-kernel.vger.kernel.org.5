Return-Path: <linux-kernel+bounces-104567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9587D009
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FED1F2236D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4233D560;
	Fri, 15 Mar 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa884i45"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F3C470;
	Fri, 15 Mar 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515875; cv=none; b=C8YXi5CZkvPcLicFYiXyfpHg3LUL1BOl6hK8JFEB4jyMEdlA9QuAIgRg90A/JeMAmOkC549Zy5hSz9bKexgJUkYtyxK/+no7UUAQvVkuWzMfCVl2OHKXCdUqyWTCUD5Ev3YwQxs5k3DLtViQuA5dwD5Tb8mukNyrAjAETY/Kpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515875; c=relaxed/simple;
	bh=uTrMcFCburtM5gMQYq+sgTQ/3X5irzj8OXkqsXBrsR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfgG91Zup1I9VZeGZWToLcIkKmEUxc0JwVc9mB6ejrK0F0YhS/dMuXAeMzW5zMJpkRxagngUQiSpkSFD6ZhOiE9tr1BOfyAR2KwTrvHnAD51aIeomQJNvufPjD/D2SOFzqaPNz5rixjdNrS9+pGQmu0tEFo1dgGGfjcCBve0K0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa884i45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F1C433F1;
	Fri, 15 Mar 2024 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515875;
	bh=uTrMcFCburtM5gMQYq+sgTQ/3X5irzj8OXkqsXBrsR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pa884i45IW1enWqmRUmGWoDWLOsWK/N+CfwBmzCpYaLKPVVRNaVvXqR7mJPqbUIAz
	 bi6p+tmxqMk/LfBhjX/6RAZnHa+bf9rBoycYw/NGzX6q00uG/O6eFUkHsXjogmTsaT
	 l7NkMMsQuZhH8lHJknrR0agFl9yCxLBaCL/PKgfNJwW8B4D1kcC2EOLHNlfomB8s3G
	 qCtLL6iyofCrykK8CXfJPD5wQci47EwgksFzw/rM25YhmKWaFMLDRX4+ikCN/1kvwl
	 Rv88AK7aIiivXAa6zC18zoyhPTJpL6X2S7rwrZnulATpjrrtfjwF/f9dnFPCGzmyM5
	 t8pQ7qDMuWMPQ==
Message-ID: <2c79bcb0-3ef5-4cf1-91f3-d1f0bc1f6465@kernel.org>
Date: Fri, 15 Mar 2024 16:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] tools/tracing: Use tools/build makefiles on
 latency-collector
Content-Language: en-US, pt-BR, it-IT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, John Kacur <jkacur@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1710512430.git.bristot@kernel.org>
 <f2851351a1561a59a273a64de561022b1af4edcf.1710512430.git.bristot@kernel.org>
 <32958f50-b713-40ba-9e12-2a1b5667a91f@kernel.org> <ZfRg8CB5xXL2Y-zC@x1>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <ZfRg8CB5xXL2Y-zC@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 15:53, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 15, 2024 at 03:48:58PM +0100, Daniel Bristot de Oliveira wrote:
>> On 3/15/24 15:24, Daniel Bristot de Oliveira wrote:
>>> Use tools/build/ makefiles to build latency-collector, inheriting
>>> the benefits of it. For example: Before this patch, a missing
>>> tracefs/traceevents headers will result in fail like this:
>>>
>>> -------------------------------- %< -------------------------------
>>
>> Oops, b4 is interpreting these ------ as the '---' separator, and is truncating
>> the message. I will fix this in a v3.
>>
>> sorry.
> 
> Yeah, that confuses scripts, that separator.

checkpatch did not point that as an error, and git am works as well.... but it
indeed confuses other scripts...

Thanks, Arnaldo.
-- Daniel

