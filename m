Return-Path: <linux-kernel+bounces-140616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0C8A16EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FB5B292A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69F14EC68;
	Thu, 11 Apr 2024 14:15:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0C14E2E0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844901; cv=none; b=ZT3Q6IzC6i/G8AIjv9X3iXEzT0C0kk8uF09cT+Qtiz0wAzZoNUtaju3lyrdndysjXEeGBBeevknPEJHk1p3/YsicHuYrI7B/LF2uALZ/FLevkiibsKCYdHDieSw+mTR96W+sBICTWgLly/yoJbbuYY/r5ae8MEKcZECSD0jdkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844901; c=relaxed/simple;
	bh=OVGVgg31oGcwJxk31stKFgjkFjJ1hAfVWM0EN+hA52g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1Qj/spVdbVipo0gZiRM2WLPmXk+y+zzUNbIxxeFORruC8NaPXPknr/3Ki/iiVMyqOsh+yB5j8JP11QEg2BkAju6nDJlt6KiPIPvC4Cq7ZrWZUcTsUDIP7NiWl5WdtyqpewCa10j3C9QT4QIjMPn9oiEj6mrDDKh6DZaU40wBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2F23339;
	Thu, 11 Apr 2024 07:15:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FC4B3F64C;
	Thu, 11 Apr 2024 07:14:56 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:14:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
Message-ID: <ZhfwXXoe4k+JusWo@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-7-james.morse@arm.com>
 <e74077e1-3c5b-4126-a567-4b4b04f5367d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74077e1-3c5b-4126-a567-4b4b04f5367d@intel.com>

On Mon, Apr 08, 2024 at 08:16:32PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > rdtgroup_init() needs exporting so that arch code can call it once
> > it lives in core code. As this is one of the few functions we export,
> 
> Please do not impersonate code.

Noted.  Any objection to rewording this as follows?

"As this is one of the few functions exported from the resctrl common code, [...]"


> > rename it to have the resctrl in the name. The same goes for the exit
> 
> "to have the resctrl" -> "to have resctrl"

Noted for James' attention.

[...]

Cheers
---Dave

