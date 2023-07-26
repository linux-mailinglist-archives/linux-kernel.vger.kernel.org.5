Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B46762932
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGZDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGZDVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:21:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60825121
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690341709; x=1721877709;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=41wbTtODPkpjnhNbDqWe3jLLGDqh9EzgVAF8fhApyhM=;
  b=XuYN+rHsrFlgbLdUGzv0/+TELCtFFa8Ss6Ap/FqDmbP03LxtsRd3OKa2
   9EdsaOMWKmusUtfOgoSIBs8/Z4Q6kOQ+bV4Yb0u0zrXWgXSL2bYwAkrAC
   ky7q+7r4kJWyN7lHFPE6CLa9UMQ7GtSjBL/0NFQUNatLYF9arCB9j3pxp
   79MyIa0Q9d8L5Gaw43SPsnWDhuJtK0lCsohAq9MJApXO0PNdjur3tRvKm
   PetzourLtORVpaLfBkdw3qdF/rI7DInRMmPjcOKQYRtFyiwqwmAwi5viM
   FVAM5QF6yG92FBCx6nex3pZOOtxft8vqttXyquIAj1alGPhJQkwyv3Go8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="371513237"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="371513237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726345744"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726345744"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.129]) ([10.254.208.129])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:21:36 -0700
Message-ID: <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
Date:   Wed, 26 Jul 2023 11:21:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Zong Li <zong.li@sifive.com>, Anup Patel <apatel@ventanamicro.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/24 21:23, Zong Li wrote:
>>>>> In RISC-V IOMMU, certain devices can be set to bypass mode when the
>>>>> IOMMU is in translation mode. To identify the devices that require
>>>>> bypass mode by default, does it be sensible to add a property to
>>>>> indicate this behavior?
>>>> Bypass mode for a device is a property of that device (similar to dma-coherent)
>>>> and not of the IOMMU. Other architectures (ARM and x86) never added such
>>>> a device property for bypass mode so I guess it is NOT ADVISABLE to do it.
>>>>
>>>> If this is REALLY required then we can do something similar to the QCOM
>>>> SMMU driver where they have a whitelist of devices which are allowed to
>>>> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
>>>> compatible string and any device outside this whitelist is blocked by default.
>>>>
>>> I have considered that adding the property of bypass mode to that
>>> device would be more appropriate. However, if we want to define this
>>> property for the device, it might need to go through the generic IOMMU
>>> dt-bindings, but I'm not sure if other IOMMU devices need this. I am
>>> bringing up this topic here because I would like to explore if there
>>> are any solutions on the IOMMU side, such as a property that indicates
>>> the phandle of devices wishing to set bypass mode, somewhat similar to
>>> the whitelist you mentioned earlier. Do you think we should address
>>> this? After all, this is a case of RISC-V IOMMU supported.
>> Bypass mode is a common feature across IOMMUs. Other IOMMUs don't
>> have a special property for bypass mode at device-level or at IOMMU level,
>> which clearly indicates that defining a RISC-V specific property is not the
>> right way to go.
>>
>> The real question is how do we set IOMMU_DOMAIN_IDENTITY (i.e.
>> bypass/identity domain) as the default domain for certain devices ?
>>
>> One possible option is to implement def_domain_type() IOMMU operation
>> for RISC-V IOMMU which will return IOMMU_DOMAIN_IDENTITY for
>> certain devices based on compatible string matching (i.e. whitelist of
>> devices). As an example, refer qcom_smmu_def_domain_type()
>> of drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>
> That is indeed one way to approach it, and we can modify the
> compatible string when we want to change the mode. However, it would
> be preferable to explore a more flexible approach to achieve this
> goal. By doing so, we can avoid hard coding anything in the driver or
> having to rebuild the kernel  whenever we want to change the mode for
> certain devices. While I have considered extending a cell in the
> 'iommus' property to indicate a device's desire to set bypass mode, it
> doesn't comply with the iommu documentation and could lead to
> ambiguous definitions.

Hard coding the matching strings in the iommu driver is definitely not a
preferable way. A feasible solution from current code's point of view is
that platform opt-in the device's special requirements through DT or
ACPI. And in the def_domain_type callback, let the iommu core know that,
hence it can allocate a right type of domain for the device.

Thoughts?

Best regards,
baolu
