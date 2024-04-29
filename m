Return-Path: <linux-kernel+bounces-162242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED678B586C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFF287920
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1871749;
	Mon, 29 Apr 2024 12:21:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880954BCC;
	Mon, 29 Apr 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393302; cv=none; b=Wp9VCdv6F2fVKJT+DS7D0Q74FtTi9rgWcaKWKUJETMFxfjWPnQQGcCxOByNhNUMJc0QyxIpLrV7MufxZq5zI19RR3ibhgVFtJ7BuTxIPy9T04/i1svJJL0Y7cl532RUutsGJuj4vMeSzdBjkzwNXFeSmc8fax0Ve8he57qCjqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393302; c=relaxed/simple;
	bh=u9i7GEaEPB0efe/XuAZN0XrJRMGHZ1l3GMvjslIx3gs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFdyO36yl5z8ZJhNUtloK/bqwEYna5dc6tViXvRccMmROK+hNEa5lOzHkLkpQ0ejzM0z6DAo9JrqhQzx0Y3M86Ek3rmAHvTqrOhB4oeA7q1IL5/X5bUISvjRs4lBQ4DYmWGquJaA6Ha/2nrafTfySWAceDJl32yN6bLVAbK6TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSj6s3BKzz6GD6F;
	Mon, 29 Apr 2024 20:19:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 989301400DB;
	Mon, 29 Apr 2024 20:21:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 13:21:34 +0100
Date: Mon, 29 Apr 2024 13:21:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: fan <nifan.cxl@gmail.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 05/10] cxl/memscrub: Add CXL device patrol scrub
 control feature
Message-ID: <20240429132133.0000606c@Huawei.com>
In-Reply-To: <31df9f7d63e34e4bb1504dcc13a70604@huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
	<20240419164720.1765-6-shiju.jose@huawei.com>
	<Ziw_Ll3vMBK1zNw4@debian>
	<31df9f7d63e34e4bb1504dcc13a70604@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c index
> >> 0c79d9ce877c..399e43463626 100644
> >> --- a/drivers/cxl/mem.c
> >> +++ b/drivers/cxl/mem.c
> >> @@ -117,6 +117,12 @@ static int cxl_mem_probe(struct device *dev)
> >>  	if (!cxlds->media_ready)
> >>  		return -EBUSY;
> >>
> >> +	rc = cxl_mem_patrol_scrub_init(cxlmd);
> >> +	if (rc) {
> >> +		dev_dbg(&cxlmd->dev, "CXL patrol scrub init failed\n");
> >> +		return rc;
> >> +	}  
> >
> >If the device does not support memory patrol scrub feature, the above function
> >will return -EOPNOTSUPP. Since the feature is optional, should we just warn it
> >and let it go through?  
> Feedback from Jonathan was that, if this feature is built in, then should not proceed
> if the patrol scrub init failed, though it is an optional feature.

Oops. That wasn't my intent.  If the feature is implemented by the hardware and
init fails, then I think we should fail probe.  Or maybe just print a very shouty
message about it being broken.  If the feature is simply not implemented we
should definitely not fail.

Jonathan

>  
> >
> >Fan  
> >> +
> >>  	/*
> >>  	 * Someone is trying to reattach this device after it lost its port
> >>  	 * connection (an endpoint port previously registered by this memdev
> >> was
> >> --
> >> 2.34.1
> >>  
> Thanks,
> Shiju


