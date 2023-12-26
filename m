Return-Path: <linux-kernel+bounces-11659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD71B81E980
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7689B2825FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98782103;
	Tue, 26 Dec 2023 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6LlcVTW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A701847
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ltxuMlZ+kzMrrPIVGOVBbv3q97GGQmn2uNwiw82Dnkw=; b=V6LlcVTWVAYjZSAsOOdj6x+I+1
	mGidUToj2wg3ebKpsXdNW34qYqNIxH77CgoRKyeo2kAo5ihhWE3Kg0Iu5tFQYG99bkraAHcXKxxvD
	885NWv/GWxjRbcBtwvJ+nBAMSN6bbFuR27xFg1jRj/jRL6SeEv/0vVLdgi3GwsCWR6pPq0lMly58T
	rOUp7Dk2+LH8tv5lR04UKuKKnTRru+7Ga9Dvpqb/iiD2lqpzzcHG3xEH2DkNVzAwIjBR+7LKpWU3g
	ciX4Bfu4QgLbBjbDBHWBHxUgnDh5UbS1nSqbcy6maMPN8ctiKf4JGDesxVLI7D3G09YcjJh/o6mPz
	I2AGz7Wg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIDQx-00DSmS-1T;
	Tue, 26 Dec 2023 19:49:47 +0000
Message-ID: <0579ecd5-1335-4010-a32c-77dd4caf3411@infradead.org>
Date: Tue, 26 Dec 2023 11:49:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/i915/perf: reconcile Excess struct member
 kernel-doc warnings
Content-Language: en-US
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20231221032029.30942-1-rdunlap@infradead.org>
 <20231221032029.30942-4-rdunlap@infradead.org> <ZYsH757tT6sdSjDI@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZYsH757tT6sdSjDI@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/26/23 09:05, Rodrigo Vivi wrote:
> On Wed, Dec 20, 2023 at 07:20:29PM -0800, Randy Dunlap wrote:
>> Document nested struct members with full names as described in
>> Documentation/doc-guide/kernel-doc.rst.
>>
>> i915_perf_types.h:341: warning: Excess struct member 'ptr_lock' description in 'i915_perf_stream'
>> i915_perf_types.h:341: warning: Excess struct member 'head' description in 'i915_perf_stream'
>> i915_perf_types.h:341: warning: Excess struct member 'tail' description in 'i915_perf_stream'
>> 3 warnings as Errors
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: dri-devel@lists.freedesktop.org
> 
> 
> for the series:
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> I'm afraid patchwork was down when you sent this out.
> Could you please rebase and resend? Just to ensure
> our CI doesn't complain and then we push it.
> 

Will do. Thanks.

-- 
#Randy

