Return-Path: <linux-kernel+bounces-140148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA878A0C08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C562866D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506C144303;
	Thu, 11 Apr 2024 09:14:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7661442F7;
	Thu, 11 Apr 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826879; cv=none; b=PrwR8jnSbSclnlU1ogaoafFQTJhzrup7G/BvgEHlDvqtwiJUT0Xxwln1GhOZGUE8CWY10imBYFpkE0AU+Cf4A+qVC2qV6UrA3z5PoEr5sT7n+AFk3aE2uPkEFykW28ROk8iV9+y6imhJd1L48DsTb6GA3OfyOwKg3qjN5oZ2vDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826879; c=relaxed/simple;
	bh=kyhu++ullHOjPqygTG6oKCJuKamhP3KbmBBunl+M5ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv4q3+UGgku4w9vRRhqgrZqlEC+JoSjM9u4XDfrUbw+ytyxEJ3U8aiQIGYdlprB8DFK6I+h1olvHPQffq9Pfp8qKSRK6DGhKGOfkzncY+Ta2UV36w63uwlxV1DdpP9EBKTgxVyx3CMRU9cym3EIbFLu3bk0MzfeXre8k5IKlID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC13113E;
	Thu, 11 Apr 2024 02:15:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911583F6C4;
	Thu, 11 Apr 2024 02:14:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:14:33 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
Message-ID: <Zhep-UCqqPlg9BIh@bogus>
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
 <ZhZacAOVpAXK8lDE@bogus>
 <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>

On Thu, Apr 11, 2024 at 03:54:48PM +0800, Ruidong Tian wrote:
> 
> 
> 在 2024/4/10 17:22, Sudeep Holla 写道:
> > On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
> > > AEST V2 was published[1], add V2 support based on AEST V1.
> > > 
> > 
> > Any changes to ACPICA has to get merged in the external ACPICA project.
> > Refer [1] for details from Rafael. You can also refer [2] in the kernel
> > docs.
> > 
> 
> Patch1 is just a fix to follow kernel code style.

IIUC such changes are not allowed as ACPICA changes are always imported
from the external project. So you have to take same route as patch2

> Patch2 had merged to
> acpica project, PR link can be see in patch2 comment:
> 
>   Link: https://github.com/acpica/acpica/commit/ebb4979

Thanks, this will then get imported into kernel next time ACPICA changes
get merged which usually happens regularly.

-- 
Regards,
Sudeep

