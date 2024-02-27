Return-Path: <linux-kernel+bounces-82726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A661C8688BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF331F21F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4252F92;
	Tue, 27 Feb 2024 05:42:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218052F90
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012524; cv=none; b=rbbwtu2mkIs9DiDlc/xGYkn23qu7Sal3UX7oMRgCmmdi18Rqv24TD04OcF9x+msBK+8gyaHIlx6KAWGDHQQEXYN9P2MusVT0E1q7GG5DtVxsWfMObtRv9dQFbiKG1n2nx3i0uqyn9+GEXQDB5hl191lUJh0MGYptGeCYWw2ieUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012524; c=relaxed/simple;
	bh=5hqUo0V7+j3KA4GJvgt4VKwHM+sYAtB5uV6UyueiwRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdpgWPPoeEU7+LQ/Mrh5GeogaKg4YCs6yDHRzfyESeNYgiEiF3ttWK8Jd+VBws+AMYJQT9QckiSWkxZyHVD/kZqVMLPRf+l9rWvllHDSvWGMEjpm48Cg6gjl3xjSAMM1+jl2z+wEJtGd9kTepk2HNfCQA4gvXpe5KzHRSzEP5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1B7DA7;
	Mon, 26 Feb 2024 21:42:39 -0800 (PST)
Received: from [10.163.48.107] (unknown [10.163.48.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905953F6C4;
	Mon, 26 Feb 2024 21:41:58 -0800 (PST)
Message-ID: <5bf821e9-3774-4b5f-b2e6-06010e42403b@arm.com>
Date: Tue, 27 Feb 2024 11:11:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Correcting the spelling mistake in Coresight subsystem
Content-Language: en-US
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>, suzuki.poulose@arm.com
Cc: mike.leach@linaro.org, james.clark@arm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240226190245.789200-1-pvkumar5749404@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240226190245.789200-1-pvkumar5749404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Although a trivial typo fix in documentation, the subject line still
might need "doc: ABI: coresight: <typo fix in tmc>" format etc but I
guess it's upto the maintainers.

On 2/27/24 00:32, Prabhav Kumar Vaish wrote:
> Changes :
> 	- "avaialble" corrected to "available" in "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
> 
> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 96aafa66b4a5..339cec3b2f1a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -97,7 +97,7 @@ Date:		August 2023
>  KernelVersion:	6.7
>  Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
>  Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
> -		for the users to configure explicitly. This file is avaialble only
> +		for the users to configure explicitly. This file is available only
LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  		for TMC ETR devices.
>  
>  What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred

