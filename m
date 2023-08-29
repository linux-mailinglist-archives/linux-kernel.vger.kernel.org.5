Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3089D78C879
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjH2PU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjH2PTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:19:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131A1AA;
        Tue, 29 Aug 2023 08:19:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZrb70mcpz67n0t;
        Tue, 29 Aug 2023 23:15:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 16:19:49 +0100
Date:   Tue, 29 Aug 2023 16:19:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 08/18] cxl/region: Add Dynamic Capacity CXL
 region support
Message-ID: <20230829161948.0000556c@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:20:59 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL devices optionally support dynamic capacity.  CXL Regions must be
> configured correctly to access this capacity.  Similar to ram and pmem
> partitions, DC Regions represent different partitions of the DPA space.
> 
> Interleaving is deferred due to the complexity of managing extents on
> multiple devices at the same time.  However, there is nothing which
> directly prevents interleave support at this time.  The check allows
> for early rejection.
> 
> To maintain backwards compatibility with older software, CXL regions
> need a default DAX device to hold the reference for the region until it
> is deleted.
> 
> Add create_dc_region sysfs entry to create DC regions.  Share the logic
> of devm_cxl_add_dax_region() and region_is_system_ram().  Special case
> DC capable CXL regions to create a 0 sized seed DAX device until others
> can be created on dynamic space later.
> 
> Flag dax_regions to indicate 0 capacity available until dax_region
> extents are supported by the region.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>


