Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C38113E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjLMN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379222AbjLMN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:26:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23A91;
        Wed, 13 Dec 2023 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702473977; x=1734009977;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+kY9QgK8FMlrrYySDrLuoBvhnlDhlG8yb7Ov4BOpYak=;
  b=VSyAHxf/26Hqkn6itmmPpCqxKT/qSI05IMChQYkrM30byIJOIA1hvXeQ
   JdDj6/JYCfsuULKi97M1IkjpW5rXFd0X0vcEyYRYbUgpifNfSZ7nhsK//
   uXRqtcr/AYs19eyabYADXxxTpl18K3A6D+W/JS2IyrUhgD6l4/Vll1S1q
   xjiOIX05GPa0GdhDtzf6JgPmFyuiFVoQIrPrftQh9FY79ZalticR/PYPm
   iu5Ob/M5zx9F9Oe1SnbnWD9aIlxeCUhffv9P3eDykV56HkhuKPhKxu5Xf
   iv0ZisMojr8+4GzAq7tQkg9VdubpNKftLjMPsFj0GSx4Z6oLi/AayJ/JK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1818080"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1818080"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="773949973"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="773949973"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.246]) ([10.254.212.246])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:26:12 -0800
Message-ID: <9d30d670-d4ac-4af1-9177-88fde952ed3e@linux.intel.com>
Date:   Wed, 13 Dec 2023 21:26:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/13 19:14, Harshit Mogalapalli wrote:
> Free the handle when the domain allocation fails before unlocking and
> returning.
> 
> Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
> Signed-off-by: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
