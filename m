Return-Path: <linux-kernel+bounces-142406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42518A2B29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1511F230C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE31502BB;
	Fri, 12 Apr 2024 09:26:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955A4E1D5;
	Fri, 12 Apr 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914011; cv=none; b=io1wOudpuOvxIFhJIdqtjnD9Eda6x1Se7FjcBzTjBV4GiDAy0/p1xwoQWCV+JMrjF0aXIBsswutPNSqe5HFf5QQ5HEZxEjIvaskBxtBnigqJM9XMQbDEZvUT0mknlzdErQcDzmlRtikR5MylsWIyemxemPFZKXyTGZ4OQmPWJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914011; c=relaxed/simple;
	bh=TL6K3GRlyYxQ3w5DXaBs4yM3sBZ4TGsWc9twC55D0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VndL74lQSD+/XogXhVPOI4hnf+cCise6n5JbF5xEItniQWFdBiB6EBXDWtpI6p0cmReiMq2NL54jlnXHUNb5bdkFixFE3lNtN0K8SiTRg9T1hxj2bPuKonP8AQrNAqgSOtYz9rRDuy21PbBgQgVViJocVhCNOITZV2T5VmFJp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C98339;
	Fri, 12 Apr 2024 02:27:18 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B95C3F64C;
	Fri, 12 Apr 2024 02:26:48 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:26:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ACPICA: AEST: Support AEST V2
Message-ID: <Zhj-VtiWyTd-zq5w@bogus>
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com>
 <ZhZacAOVpAXK8lDE@bogus>
 <e3c91a7b-4bcc-45ce-92e6-c6a50ad80479@linux.alibaba.com>
 <Zhep-UCqqPlg9BIh@bogus>
 <8ff4deab-13ab-4fdf-b418-fbfefe46c087@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff4deab-13ab-4fdf-b418-fbfefe46c087@linux.alibaba.com>

On Fri, Apr 12, 2024 at 10:41:31AM +0800, Ruidong Tian wrote:
>
>
> 在 2024/4/11 17:14, Sudeep Holla 写道:
> > On Thu, Apr 11, 2024 at 03:54:48PM +0800, Ruidong Tian wrote:
> > >
> > >
> > > 在 2024/4/10 17:22, Sudeep Holla 写道:
> > > > On Wed, Apr 10, 2024 at 02:36:00PM +0800, Ruidong Tian wrote:
> > > > > AEST V2 was published[1], add V2 support based on AEST V1.
> > > > >
> > > >
> > > > Any changes to ACPICA has to get merged in the external ACPICA project.
> > > > Refer [1] for details from Rafael. You can also refer [2] in the kernel
> > > > docs.
> > > >
> > >
> > > Patch1 is just a fix to follow kernel code style.
> >
> > IIUC such changes are not allowed as ACPICA changes are always imported
> > from the external project. So you have to take same route as patch2
>
> In ACPICA, all struct use typedef which is not allowed in kernel:
>
>     It's a **mistake** to use typedef for structures and pointers[1].
>

Fair enough.

> I see all other structs in actbl2.h follow this rule, so I fix all typedef
> in AEST struct to follow kernel code style. But i can not apple this fix in
> ACPICA. Patch1 is just a kernel patch.
>

No patches from the kernel tree applies to APCICA because of some variations
in the coding style that the import script modifies when applying to the
kernel. So make similar changes in APCICA project and send it there. It will
get imported if it gets merged there.

--
Regards,
Sudeep

