Return-Path: <linux-kernel+bounces-30083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C629E8318EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F29B249EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B924B46;
	Thu, 18 Jan 2024 12:10:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468C24B32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579820; cv=none; b=TuFk78hGF/bqg0Id4jxO2wi6i9/Oe63xPshISnywvm9BgkuqyKnd8qD3Cn3ZOTsUfKQYZW9k0FqzQFICfUsGufpLRShmLCHZqHweUSk1QhUt46BJjv6HfL2qCuYnnH57dGaZROvBodOoc+sRSLDITIVeVCZ8aaqBtLcZrrPdYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579820; c=relaxed/simple;
	bh=6psjQ1uD9PMdcSnhUZ2DvHkE/3zowXNYTyjhRH/uRjo=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=R5fejShQ8VQQhSAVeAQ1hikNuZYpbly4AliFUV3BnYtvrnErpJy05y3rveFTcGu4EJ+rcZOwcxKBlSahK0BdYarYB+PH4+RZxL+LWduBpRcGVpa2rG6V9Ol0EUttdoyJSWNGLWPZuuth9n+LhETenBhpLN3Tm39zyueGizsXEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E38D1042;
	Thu, 18 Jan 2024 04:11:03 -0800 (PST)
Received: from [192.168.2.88] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20CFE3F5A1;
	Thu, 18 Jan 2024 04:10:14 -0800 (PST)
Message-ID: <c7b1f17a-5c08-4e65-b4ff-7d82d7fbc161@arm.com>
Date: Thu, 18 Jan 2024 13:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com, ionela.voinescu@arm.com
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 20:05, Vincent Guittot wrote:
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.
> 
> Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

(on h960 w/ and w/o capacity-dmips-mhz in dts file)

[...]

