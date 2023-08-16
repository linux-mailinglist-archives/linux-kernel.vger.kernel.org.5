Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12EA77DB49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbjHPHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbjHPHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:40:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24219A7;
        Wed, 16 Aug 2023 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692171612; x=1723707612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zkD8GEaOkZ8+9zvX3nbQCJwPb7xHrPG3SCaPvxJzOF8=;
  b=RjHEp0Zl5vG77tBTkR0ELbakSkqlxGc6Q4pZKoSRWL5A1E3j/yj9h0uC
   jj+bZp4jU4gw9BW+2CeIiHdPns7eE0GI0lnidJDT9HnrgPDb5kHPHVjus
   XHBWVsH1Sp5uUpXrh7K0Vn+0282rbFOXNYGFHCIFcyZth/eevOwOrsSis
   RW6TzPeg4a7OC14R9DLmuGtBc5x0Z9R3iSFdO5UsrB4UYo38qDsTtma9Z
   b2f+ZB/jkEUSP+jOsHTHTzpvt4Sn8Si7ulbjOHFtuBLmtgaH4lUcgdGwB
   x+Chewr0l5ulhqRZ9GcK6jr9j00/sp3gTx6hHflq7wYVe+wCggOuOUVdS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375237888"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="375237888"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980642522"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="980642522"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.102.225]) ([10.102.102.225])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 00:40:09 -0700
Message-ID: <45089a6f-0173-d33f-425f-48cbf83051ed@intel.com>
Date:   Wed, 16 Aug 2023 09:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: isci: init Return result of sas_register_ha()
Content-Language: en-US
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
In-Reply-To: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2023 22:23, Artem Chernyshev wrote:
> To properly manage possible failure of sas_register_ha() in
> isci_register_sas_ha() return it's result instead of zero
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Reviewed-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

