Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970576B2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHALQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjHALP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:15:27 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534B2128;
        Tue,  1 Aug 2023 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690888385; x=1722424385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oLR0NKnUrWggZZza0EAAXZ7Ic75fMcCQGOwHs4P4K6U=;
  b=Xh+u9xcY7IQt4z7G6oz2E+iwKOE4bNeV1s5bmWXfZxaxHdHWklCglxON
   Tb7/sROV6GsbHiOZBgvfxJW5oe0Bv3Zz3c3twmVoETREmVfNXqxxwgQu5
   sJ2Y4JHoZTL7pS773agrYBYzwIKqAqaWXRspgJnDfDzajD4d1MW8gT7f2
   DEk3jfAmEIcHC9xL/mgf5HTLsu2fdoecRK65USvnpNl9fDZeTS9wnRASu
   fpwSuze0k++Cbg6HiRmJX8IzbTMVrKqOBPilvZC6Nhlt5QwXQ4ymNuYoF
   vSXWQwV91t5m56c6/0TB569ZAacvUglDKSogVEF3PL29N5UV7LdAyVXHm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359316864"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="359316864"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="975250889"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="975250889"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.126])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:12:38 -0700
Message-ID: <3551d65c-2295-b6cd-b5b1-9264026cff61@intel.com>
Date:   Tue, 1 Aug 2023 14:12:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Add support for QEMU
Content-Language: en-US
To:     jeuk20.kim@samsung.com
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <48f05875-5255-70d2-0737-36fa95470037@intel.com>
 <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
 <CGME20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p4>
 <20230801092000epcms2p44c99d2c15bc6169e38693cb64cf946db@epcms2p4>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230801092000epcms2p44c99d2c15bc6169e38693cb64cf946db@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/08/23 12:20, Jeuk Kim wrote:
> On 1/08/23, Adrian Hunter wrote:
>> On 1/08/23 10:37, Jeuk Kim wrote:
>>> Add PCI ID to support QEMU ufs.
>>>
>>> The new qemu ufs device can be found at
>>> https://lore.kernel.org/qemu-devel/20230727155239.GA979354@fedora
>>
>> Please say something about why a UFS device is being virtualized
>> and what features it is expected to support.
> 
> Hi Adrian!
> 
> UFS device emulation feature has been newly added to QEMU recently.
> Currently, QEMU UFS supports basic io and query request features,
> and plans to add more features in the future.
> 
> With the addition of the QEMU ufs device emulation feature, 
> QEMU UFS decided to use the pci device id of 0x0013 in the REDHAT vendor id (0x1b36).
> 
> However, this information is not registered in the linux ufs driver, 
> so the current linux kernel does not recognize the QEMU UFS device. 
> Therefore, I want to register the QEMU ufs pci id through this patch.
> 
> Do I need to add the above content to the commit message?

I was really hoping for an explanation of "Why?" i.e.
why does anyone want a virtual UFS device?  Why not use
any existing virtual block device?

And yes, please add to the commit message

> 
> Thanks,
> Jeuk
> 
>>>
>>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>>> ---
>>>   drivers/ufs/host/ufshcd-pci.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
>>> index cf3987773051..29d322931427 100644
>>> --- a/drivers/ufs/host/ufshcd-pci.c
>>> +++ b/drivers/ufs/host/ufshcd-pci.c
>>> @@ -590,6 +590,7 @@ static const struct dev_pm_ops ufshcd_pci_pm_ops = {
>>>   };
>>>   
>>>   static const struct pci_device_id ufshcd_pci_tbl[] = {
>>> +        { PCI_VENDOR_ID_REDHAT, 0x0013, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>>>           { PCI_VENDOR_ID_SAMSUNG, 0xC00C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>>>           { PCI_VDEVICE(INTEL, 0x9DFA), (kernel_ulong_t)&ufs_intel_cnl_hba_vops },
>>>           { PCI_VDEVICE(INTEL, 0x4B41), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },

