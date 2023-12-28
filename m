Return-Path: <linux-kernel+bounces-12878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8B81FC00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB05BB238F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950210A0A;
	Thu, 28 Dec 2023 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CaN1ztGH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DC10A00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NiIPkFQqmlg8hHDXK0BoSCEzG13ttdB9oJvpLZV4XXY=; b=CaN1ztGHFmMWAdI2GUCOEzjnqd
	zJ2bpWsSL7n+0TG2J5WB0N3+Pwru274Kz+GFN4us0JC6R17IRIr3QkhS+8dwbTJVAIRRwTFo5WKY0
	y0LdLJm9QnlAaNeg97IQlajFXcPlKV+o6LxfV317aMsnaEUc7fESfVRJnrxPdXqSZjcsj9ieWtPIL
	hjhkYWua53xF/emoEinS/LQ/AL7G7Ksi+S38m8Kiz7xjPODXAfYT8PiWAJO+LwFIvv49QpFfmoeyt
	eviwSeAyQsetdQHGJguegsDNI6EwANdGPoFbKkuFCk2GvEsHnCA2pvIJdS10I4uyWzcVqb1IOf2z9
	etvPUYCQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIzw1-00HXc3-1h;
	Thu, 28 Dec 2023 23:37:05 +0000
Message-ID: <799b2484-9103-466b-ab86-483beadaad87@infradead.org>
Date: Thu, 28 Dec 2023 15:37:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/i915/guc: reconcile Excess struct member
 kernel-doc warnings
Content-Language: en-US
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20231226195432.10891-1-rdunlap@infradead.org>
 <20231226195432.10891-3-rdunlap@infradead.org>
 <ZY2lDJ4BkwO1AZGj@ashyti-mobl2.lan>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZY2lDJ4BkwO1AZGj@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andi,


On 12/28/23 08:40, Andi Shyti wrote:
> Hi Randy,
> 
> [...]
> 
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
>> @@ -105,61 +105,67 @@ struct intel_guc {
>>  	 */
> 
> 
> struct { } interrupts is missing here.
> 
>>  	struct {
>>  		/**
>> -		 * @lock: protects everything in submission_state,
>> -		 * ce->guc_id.id, and ce->guc_id.ref when transitioning in and
> 
> [...]
> 
>> +		 * we start bypassing the schedule disable delay
>>  		 */
>>  		unsigned int sched_disable_gucid_threshold;
>>  	} submission_state;
> 
> Here struct { } send_regs is missing

scripts/kernel-doc didn't report any problems with those, but it does
appear (to me) to be a kernel-doc bug.  :(

Thanks.

> But as for this patch:
> 
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Thanks,
> Andi
> 
>>  	struct {
>>  		/**
>> -		 * @lock: Lock protecting the below fields and the engine stats.
>> +		 * @timestamp.lock: Lock protecting the below fields and
> 
> [...]

-- 
#Randy

