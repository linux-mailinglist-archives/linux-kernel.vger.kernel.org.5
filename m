Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140DC811A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjLMQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:50:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43252AC;
        Wed, 13 Dec 2023 08:50:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sr1g64b1Pz67pnj;
        Thu, 14 Dec 2023 00:49:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id AE4A1140595;
        Thu, 14 Dec 2023 00:50:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 16:50:54 +0000
Date:   Wed, 13 Dec 2023 16:50:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 1/3] Documentatiion/ABI: Add ABI documentation for
 sys-bus-dax
Message-ID: <20231213165052.00007d74@Huawei.com>
In-Reply-To: <20231212-vv-dax_abi-v4-1-1351758f0c92@intel.com>
References: <20231212-vv-dax_abi-v4-0-1351758f0c92@intel.com>
        <20231212-vv-dax_abi-v4-1-1351758f0c92@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 12:08:30 -0700
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Add the missing sysfs ABI documentation for the device DAX subsystem.
> Various ABI attributes under this have been present since v5.1, and more
> have been added over time. In preparation for adding a new attribute,
> add this file with the historical details.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Hi Vishal,  One editorial suggestions.

I don't know the interface well enough to do a good review of the content
so leaving that for Dan or others.

> +What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
> +Date:		October, 2020
> +KernelVersion:	v5.10
> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RO) A dax device may have multiple constituent discontiguous
> +		address ranges. These are represented by the different
> +		'mappingX' subdirectories. The 'start' attribute indicates the
> +		start physical address for the given range.

A common option for these files is to have a single entry with two What:
lines.  Here that would avoid duplication of majority of this text across
the start, end  and page_offset entries.  Alternatively you could do an
entry for the mapping[0..N] directory with the shared text then separate
entries for the 3 files under there.


> +
> +What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end
> +Date:		October, 2020
> +KernelVersion:	v5.10
> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RO) A dax device may have multiple constituent discontiguous
> +		address ranges. These are represented by the different
> +		'mappingX' subdirectories. The 'end' attribute indicates the
> +		end physical address for the given range.
> +
> +What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/page_offset
> +Date:		October, 2020
> +KernelVersion:	v5.10
> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RO) A dax device may have multiple constituent discontiguous
> +		address ranges. These are represented by the different
> +		'mappingX' subdirectories. The 'page_offset' attribute indicates the
> +		offset of the current range in the dax device.

