Return-Path: <linux-kernel+bounces-121567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED2F88E9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738CC1F35B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77877131193;
	Wed, 27 Mar 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aSYnsKqT"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8C12DDAF;
	Wed, 27 Mar 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554500; cv=none; b=dFji8geqZ7tJLIU0Qnk9TyK/J2/jL9GvFgUJ05NIGbI1ncaYopOy+lo3Lz9cG0Cu/g+4pWDFfPNTs77nescRZlhAf+MksP/VrQGJzDY5J2s+JYwVY+ziS5z0UE+2gWyu02rhpbbgE/8HMmGnwVOIxZy/LQ45znfRwt2pjiI1Qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554500; c=relaxed/simple;
	bh=76OeUfIHMBxJhe8IVfeoWgftOWgpYR+KcvuA/0YJZ20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqTv7/ooJgxXT5RnFbdb7CARfYFWZdgV8EK0SeVc0jm7bhpYBAE7PfjbZ+/Tj+FmC1IvPSSgIjhd7xkfsgkzamUsl8u0G2ORZvs1lorbP/8XW3Hdb6wwaReK5L9BH9/E9Km6gWZm69MuwxSGpPgTxiqfj5PW7mv6e7e6yxIa2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aSYnsKqT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.128.218] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8344F2098E07;
	Wed, 27 Mar 2024 08:48:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8344F2098E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711554498;
	bh=y+2+9j6sWbPoLeSeuAktrd2FKSwR04iT4UsblobGcEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aSYnsKqTNvT3v1QSZJomn1eKSsYHIkcl42F7FToV2X9hSN1YPhzZMnutZN+JOtLZ4
	 BHI1WG/HkmTgSbC05nsvNYmSzXJ6ozZyJEF84DOzH82F09+B9SzfnFx/lD9z2ZL6pn
	 cd1rjP0mCGRYzc7ljxNor7ODIW35T/dLnrPOV/uI=
Message-ID: <b34308af-ebc9-4a0e-a27b-90d6e176c526@linux.microsoft.com>
Date: Wed, 27 Mar 2024 08:48:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "ACPI: CPPC: Use access_width over bit_width for
 system memory accesses" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 jarredwhite@linux.microsoft.com
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327121738.2833692-1-sashal@kernel.org>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240327121738.2833692-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 3/27/2024 5:17 AM, Sasha Levin wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
>>From 2f4a4d63a193be6fd530d180bb13c3592052904c Mon Sep 17 00:00:00 2001
> From: Jarred White <jarredwhite@linux.microsoft.com>
> Date: Fri, 1 Mar 2024 11:25:59 -0800
> Subject: [PATCH] ACPI: CPPC: Use access_width over bit_width for system memory
>  accesses
> 
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, it
> cannot be depended on to be always on a clean 8b boundary. This was
> uncovered on the Cobalt 100 platform.
> 

Please see the backport for this patch I sent earlier: https://lore.kernel.org/stable/6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com/T/#u

Thanks,
Easwar


