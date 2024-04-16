Return-Path: <linux-kernel+bounces-147392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9728A7349
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1D1C22561
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E11134403;
	Tue, 16 Apr 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZCvNwOHt"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9BE555
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292441; cv=none; b=MsFYzz2mjg0ZtVzKA5fj6O3MTzNC/2ZQKPKD0LzJamKZ9tRMy6v7DQGd5r7WgtuB6S277pbTowSxQJfG4xTRVQnQIkf1EQM6HLbtJco0sUIYwPY/REzcteqB6JOxdtx4dXYt8mZ/9TfMq5e+IZbo3DPD8/lhJr0sbt3wJhjwOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292441; c=relaxed/simple;
	bh=z+Qy7MqedSftcJcNd6pnd4i7pyqOLOVd04WWCsMoxBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCS2MI4ACQLFddEubtzcnxRtr9AfDW/rvAiAis9YVw5xIdKN7P6ietUpMZUjPx/ev6eYTwqdQ6eBNIjYMVdu/tGp3b8YnKJXeC1cJs1x0a/AwehyHY7+divPj4ptM7yyjTFf+q6uqbckB8BsJN2npzY7+UA4R31Ms/vXWR8yFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZCvNwOHt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GIXZt73350356
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 11:33:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GIXZt73350356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713292416;
	bh=X/dUYE6ul4KnmAoEDI/NpMbtivgGj7MgZeeqmosFbKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZCvNwOHt+PCJRRvu8w0SBdyNyoK0KPdrFZmsB0YJBT3VrbEhyx1XywPjzyp4J0a9t
	 EauoPllGxlZFosPlFH3/qjXg8knxDBxvkoulEQ186zRPDAyCqykvSXJXiosQ7U8yMr
	 q3B3jLPICWHt4IH7ba2oHaVK0XLTxwe8FqGwBJRdrqzpJgDAZ6ENssgTeDUv6eEEYt
	 kcx9VDnRfMeZaYUE6OrSCm96qpHjuoWx/XHxQRPmmzDpqk5s+VYtFiAMMGGU0HD1U7
	 0Ac47WAavH/oTuknOO5YiXQT3ikZKJh3sjUXJ/AY5cS+FSkBhQvG9TvOLw3w3UX+zL
	 hkQWKsr+16QAA==
Message-ID: <5a8557e3-4289-4d6b-90d6-5bb23a636f66@zytor.com>
Date: Tue, 16 Apr 2024 11:33:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240416175804.3328999-1-xin@zytor.com>
 <ece31eca-37bc-4b39-9fc9-7e6fda741729@zytor.com>
 <20240416182803.GIZh7DMyPNHphpa9JA@fat_crate.local>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240416182803.GIZh7DMyPNHphpa9JA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 11:28, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 11:23:24AM -0700, H. Peter Anvin wrote:
>> (I think there is actually less than half the code left. This could be
>> further cleaned up by inlining the common code,
> 
> Yeah, was just thinking about that too. I'd say, though, let's let the
> FRED code settle, we start using it and then we can always unify common
> stuff later if it turns out that it won't diverge anymore.

Good plan.

>> but if I were still maintainer I would not want that for x86/urgent.
>> This patch has the very nice property for x86/urgent purposes that it
>> doesn't touch non-FRED code at all.)
> 
> Right.

:)

> I'd let Xin work in all those comments and then I'll pick it up.

Thanks!

	-hpa


