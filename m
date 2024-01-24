Return-Path: <linux-kernel+bounces-37699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8691C83B40D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEF7287B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B95D135A56;
	Wed, 24 Jan 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJJytbfp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC055135A4B;
	Wed, 24 Jan 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132130; cv=none; b=D9nZSE2rYUICQl1abzrMkhLRFjM/sTqsfwm4OXQ8YUniKFhEY+lS8p3XVueRkpnu+kpRSqG5xyhrbwoLUXX2Jgpx6NgDfpXXhCTSUTxUsKxI/GYTzYtuf1o+U5uNX01QypwzT71XQoL06BdXaM60LwmDg6yM48TO4rsHTud7mR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132130; c=relaxed/simple;
	bh=X3kuJFi54cfvxDK9NJRtjVC1uZ+1P7SotaVQzpYWUIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m695BmQo7R0ZDNDZsA2Bqvrl0PfnHuVOhfawpfEGH/p5xixoA7feb0SQMpDzPY8hUXqzw60mL6fx9aXNCKEtKMyt6cH4EWqYJJfaaJbXDyxvPAw7CASzB+jDmkeQgxv6vgjRYHOUo587YYsMGAZn3g3nm1QIz/EnFCOxduCcnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iJJytbfp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AX08+RLbDchsJTFyY1lnz5dLrmtS/OEhzEMoWtz6kyg=; b=iJJytbfpjgwsfOP6lKgV0cHI66
	BGr6bA9cPVV5+u0+oRGd/xH57eMjl/B6M3khMQAL6yvfrlUUJJ7pWJ9ulNl+9NBbLhtwTgASfht2h
	q6l+DLKMx4Ks8QxOcRQ6ObF/grcj0Lmdyy95Av1kIWgoLeDsFDFIEcUfuE8yd2oLb2P6uT0A1BoMt
	Clgs/69OQNzvyLhSzDoXxrglpqa8tbFrHvhHYj3MC0+f9JTCP8Bp5dyZbCeQYqmBh5jMHyCqZjOIC
	UTClGiWfoc9iSrDNmKjdIyNa1fqQDgxj1YdrelkthMkvksqNaald2yKe5gU/MVBlX6g2F7hWwHc0t
	cSn+M5qg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSku7-005ALU-0r;
	Wed, 24 Jan 2024 21:35:27 +0000
Message-ID: <f16366bb-664e-4794-ad41-2c4c669190bd@infradead.org>
Date: Wed, 24 Jan 2024 13:35:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 23 (drm/xe/)
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: intel-gfx@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 intel-xe@lists.freedesktop.org
References: <20240123132929.7cb6ea4c@canb.auug.org.au>
 <152521f9-119f-4c61-b467-3e91f4aecb1a@infradead.org>
 <87le8fks3r.fsf@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87le8fks3r.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/24 01:17, Jani Nikula wrote:
> On Tue, 23 Jan 2024, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 1/22/24 18:29, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> News: there will be no linux-next release on Friday
>>>
>>> Changes since 20240122:
>>>
>>
>> on ARM64, when
>> DRM_I915 is not set
>> DRM_XE=m
>> DEBUG_FS is not set
>>
>> ../drivers/gpu/drm/i915/display/intel_display_debugfs.c:1091:6: error: redefinition of 'intel_display_debugfs_register'
>>  1091 | void intel_display_debugfs_register(struct drm_i915_private *i915)
>>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from ../drivers/gpu/drm/i915/display/intel_display_debugfs.c:19:
> 
> Does [1] fix the issue?

Yes, thanks.

> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/r/20240124090515.3363901-1-jani.nikula@intel.com
> 
> 

-- 
#Randy

