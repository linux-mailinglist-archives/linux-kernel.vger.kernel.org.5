Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6D7759D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHILDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjHILDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:03:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF73AB6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691578447; x=1723114447;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zrizEA1ZrvJpZWfXi3wLOYH6emAnI6kPIryklf3OJaY=;
  b=iobczcTSv4yHeU90mkGJqGlHaYQ5B/b981GhuitpzEvq4bIHN2UU6sVf
   PFX+dXBQ+K5uQVZ4+DjrPga4pdGhmYGO5lUhtUBZR3WVIl0ovTYSZ+1vJ
   T2z3/jOqcdKroux8R7mQgB5YYGxBP5MVNkzcHAJLO2dV7gfA4RayGsjQF
   d+SGCY0G++HWAXtCIm5M6NIuM+QID3P0aI1Txp4YNapeiWQZ2+vfzj10x
   /HEw8OUnaPRukiBVw4+makUC59z3ZsQGQ/orBaRZ3sOjdK9QCTiLX0YCO
   fRzNP5120ZHqICBh6P/ks05ryxniREn3UGOHZXPeJ0c95E10YNb5j3OBH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437456671"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="437456671"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062418007"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="1062418007"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.171]) ([10.254.210.171])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:51:43 -0700
Message-ID: <86ecc67a-8567-f3b3-02c9-572474af8e72@linux.intel.com>
Date:   Wed, 9 Aug 2023 18:51:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Shavit <mshavit@google.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
 <BN9PR11MB52766D5CF4F959D58E60C9238C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766D5CF4F959D58E60C9238C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 17:44, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, August 9, 2023 8:18 AM
>>
>> On 2023/8/8 15:49, Tina Zhang wrote:
>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>> by releasing all the bound devices from that sva domain. Technically,
>>> there could be more than one sva domain identified by the mm PASID for
>>> the use of bound devices issuing DMA transactions.
>>>
>>> To support mm PASID 1:n with sva domains, each mm needs to keep both
>> a
>>> reference list of allocated sva domains and the corresponding PASID.
>>> However, currently, mm struct only has one pasid field for sva usage,
>>> which is used to keep the info of an assigned PASID. That pasid field
>>> cannot provide sufficient info to build up the 1:n mapping between PASID
>>> and sva domains.
>> Is it more appropriate to have the same life cycle for sva domain and mm
>> pasid? I feel that they represent the same thing, that is, the address
>> space shared by mm to a device.
>>
> iirc it's a simplification to free mm pasid at __mmdrop() otherwise the
> implementation is tricky, but I don't remember all the detail...

Yeah, probably we could also free the sva domains in __mmdrop()? Remove
the refcount for sva domain just like what we did for pasid (at the
beginning we had refcount for each pasid...).

Best regards,
baolu
