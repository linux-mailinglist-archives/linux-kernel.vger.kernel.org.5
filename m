Return-Path: <linux-kernel+bounces-51014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCCC848510
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211031F28789
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21DA5D49F;
	Sat,  3 Feb 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lOP1NNvF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A984E1DE;
	Sat,  3 Feb 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706953233; cv=none; b=ron3pYBoag4TPL6JtdEQnFx90SXHI0X9uCRVKPJSYpWUSjxPjD0p7BAULqA0WMqtc58jTmRwo/znfoOUKAUxH8tRHxv3M59fr9O1x+eSaWBPcWeaOObZDT3hcoHz5otLkmuQneIhcqpYH0OTD5AK3N/06z2aBki0FtiaA3R2e6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706953233; c=relaxed/simple;
	bh=Mf+FC70bEz34Ne9LI0bFgbzLhu9lure4rqnmn2jabz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUHfarFhWghaD6gSMZl5zq/gfR1G7g6fjW12Za1HXxWilsx1lVimg8I37MzJ5XzK78T5NQG7MQTgAkDwe/sz0DmusTapKg97qrGAVYcAGVJTs+/Fk5zV26D/TmsOMeltH+/o3fS3e06cCMLGgtaxFdUSxliakK6gLuB9lDN0YIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lOP1NNvF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2961F40E00C5;
	Sat,  3 Feb 2024 09:40:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dpn5HsdvUWlF; Sat,  3 Feb 2024 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706953227; bh=o2/kkEvYopAiZxbDPfxFVKmvW7UOi+5Dlc6xEV9gu2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOP1NNvFmwMg3iqSzqQ3CnXdWJdIBoSRnGsqZFpkjTXl+qr14LAx1akeaOv7uVkiw
	 udo8H0oi+0dpAy7zSkh4J1LKrmD/Qj5DqA0bha7tY9MZvJQN5l3pjvFWrVXOnKj5UN
	 Fmk6rIDGycuztEh3UuFpdA86nxYsOtX657k2wbSkvCMI/h3GIO+YEbtbHK0Ug4RwKL
	 IO5mQ+KGq+ny10QxjF9vvwfwUck2driT8+RSoRvC8QYH6SK9TmUOcmcCaqZLLMNUFo
	 hCFQy8oQn+BFDyIfLFpO0igoyyVcEQ3r/pscZ2alRQ4ztRXN4qrKqXPT2G6L75hsW5
	 ddUk+vs7gUlimwo/vh1JniGyTF3Tp5Mhoig7/wPBO6+lTdZRYJUsBPPJqHkDvOBu9f
	 V8+7KtgqWDQe8eeqVVyQ8qZMpLrESB5L9umxwIWFxgQdWW3V9sszs0QM/FZZakmdmA
	 xHHZRkSFrS8uk4BXvl1nrFxYZMhug+i6WWXodJJYjPTQwWzIK3b/Z4z/oH7bjkm2ag
	 PKBcS+KaHY4U9daYBKq8tmHv2zoNLZ/0Vp8hSvri0xOexWA8jln+Bf1v0TFom9jZje
	 EB/6vLDgFR4Iqcm4c0/atnC3Kxzs2mMfK8cva6eW9LWfF89XnVxgQ78QoxPwov3B0G
	 NVmj9loqF9PUTizNwo+pNi0k=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C7CF40E0081;
	Sat,  3 Feb 2024 09:40:15 +0000 (UTC)
Date: Sat, 3 Feb 2024 10:40:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 9/9] x86/cpu: Introduce interface to reset hardware
 history
Message-ID: <20240203094014.GCZb4J_loB5DEohHxT@fat_crate.local>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-10-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203040515.23947-10-ricardo.neri-calderon@linux.intel.com>

On Fri, Feb 02, 2024 at 08:05:15PM -0800, Ricardo Neri wrote:
> +void reset_hardware_history(void)
> +{
> +	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
> +			     : : "a" (hardware_history_features) : "memory");
> +}

This thing belongs in the header too, and it should be __always_inline.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

