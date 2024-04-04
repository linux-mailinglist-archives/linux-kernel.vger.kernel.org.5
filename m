Return-Path: <linux-kernel+bounces-132272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB51899251
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11DF28A5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542813C69D;
	Thu,  4 Apr 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYhKdE8N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05213C69B;
	Thu,  4 Apr 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274796; cv=none; b=ctU7JskkkXgjHspq3kTT/HaQNu3PxNhIj1veaP1fFffKroHpF3Ch+tfH5ltRCczsdQWYcMD6mXrnD8sCwKzJapuB00Z1HVlFqFnZmrb05UZykjHzbUVdKu6OJbhce60bB54/kPfQZClQrNwnhXEYDMi6sCVTe4m9K+eP6WgqOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274796; c=relaxed/simple;
	bh=rZzwjWtyUphcJtTixoWoiJCkeVaQWPwljeLjuKiBHBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPBq8ToQYgTPEpoGiLRc2cqAD2llcq9mbJCcYULSl/QiePTj6nq3KN7t0G5RFiW2l5+cysZKsU109E+vKAd4kD8+V6jpWMA81AZsDZiIwh4hvXLNV+BGDCSpC4lJlL4IndMJIMA+Fn+h58y/4EKyNbgBrTqoYDFkzUQfK/T6Tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYhKdE8N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712274796; x=1743810796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZzwjWtyUphcJtTixoWoiJCkeVaQWPwljeLjuKiBHBU=;
  b=YYhKdE8NUhyooH2lsrwsozdBDtZh1YAELifSHyKGYtedbWzLFv5vwvVf
   l1LeWsnabCjJK51YjASLjtLUqU33d7ecPwycmetuM/rA50FHuGnFoarer
   aijGFqIW6PGV1gBBaz41m3f5FOi33N/vh154xLYiF+Y4rRk+oMBhASlDh
   iPC+qJ6Ikrtk7Z6k8MtYHR6gifpk8iCV/BVKVHU2orwnUawEngprX/atG
   JY8O6LXpeZTVNDIvwJ97SnKCquBMbBGzIPBBt+dAPYjTnYk6qgXre9i6J
   mhuzgHpwHT8/SjXLB9ml8jwybGntLYGb7nOb0FwLHkwftYNI097gbXjhW
   g==;
X-CSE-ConnectionGUID: QSZADmuWRaqM5RUU638alg==
X-CSE-MsgGUID: RJOLWnItSS6BVTNvN12gjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11408397"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="11408397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:53:14 -0700
X-CSE-ConnectionGUID: dvwQ9SdSTlyVSVAZURuiAw==
X-CSE-MsgGUID: QLjY7BfTSWqN4xfLksvHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19385191"
Received: from vzaharie-mobl.amr.corp.intel.com (HELO [10.209.26.243]) ([10.209.26.243])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:53:14 -0700
Message-ID: <c806bffe-6e87-4c51-ac99-4b2612d3c334@intel.com>
Date: Thu, 4 Apr 2024 16:53:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] crypto: x86/aes-xts - wire up VAES + AVX10/512
 implementation
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "Chang S . Bae" <chang.seok.bae@intel.com>
References: <20240329080355.2871-1-ebiggers@kernel.org>
 <20240329080355.2871-7-ebiggers@kernel.org>
 <f5461df0-6609-42db-850c-de6a32728fe2@intel.com>
 <20240404233600.GA746@quark.localdomain>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240404233600.GA746@quark.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 16:36, Eric Biggers wrote:
> 1. Never use zmm registers.
..
> 4. Keep the proposed policy as the default behavior, but allow it to be
>    overridden on the kernel command line.  This would be a bit more flexible;
>    however, most people don't change defaults anyway.
> 
> When you write "Some folks will also surely disagree with the kernel policy
> implemented here", are there any specific concerns that you anticipate?

Some people care less about the frequency throttling and only care about
max performance _using_ AVX512.

> Note that Intel has acknowledged the zmm downclocking issues on Ice
> Lake and suggested that using ymm registers instead would be
> reasonable:>
https://lore.kernel.org/linux-crypto/e8ce1146-3952-6977-1d0e-a22758e58914@intel.com/
> 
> If there is really a controversy, my vote is that for now we just go with option
> (1), i.e. drop this patch from the series.  We can reconsider the issue when a
> CPU is released with better 512-bit support.

(1) is fine with me.

(4) would also be fine.  But I don't think it absolutely _has_ to be a
boot-time switch.  What prevents you from registering, say,
"xts-aes-vaes-avx10" and then doing:

	if (avx512_is_desired())
		xts-aes-vaes-avx10_512(...);
	else
		xts-aes-vaes-avx10_256(...);

at runtime?

Where avx512_is_desired() can be changed willy-nilly, either with a
command-line parameter or runtime knob.  Sure, the performance might
change versus what was measured, but I don't think that's a deal breaker.

Then if folks want to do fancy benchmarks or model/family checks or
whatever, they can do it in userspace at runtime.

