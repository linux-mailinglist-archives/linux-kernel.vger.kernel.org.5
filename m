Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632BE77D961
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbjHPELu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjHPELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:11:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA61FC6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692159080; x=1723695080;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4+AGSqBUOkC77nRQkn+4Zy4NeYFwDDx95fpuE62seCM=;
  b=MPxZjQ457IB1nI3xp8yzCk+JoKQfgL/hUFhjzz0KJu4LArmTy7Vr57Gj
   KcEthQYGMsHwTiieoiXGh9L3bc1wcUb45MLL6Y5lv+cMOEcCpLXm1S3YG
   1K+OA3N9xxTxY0h3NFE4PTnzxlS7aMCpp0FtfBFB4PztfcKS9jvnPzDG3
   FNnbx/T8geydGAHMAHYr38b9IChldVNGd9hdnJOogDKbL+ZGJe3Mf6Jvl
   ZwTN4gy6Cztw46rv44FZjYFOiylewx0AFeottQIcMRYcFtvHoRQOM26wT
   dPy2FCOS+uyxvbYdoGQS1x9F8g2/TA8uMRgIC7AG8RNMQ8ptgRPox4q/E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352023642"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352023642"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 21:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737140064"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="737140064"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.88]) ([10.254.209.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 21:10:28 -0700
Message-ID: <e9d339f0-89c6-10b4-3171-9c5b1725b76c@linux.intel.com>
Date:   Wed, 16 Aug 2023 12:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, Anup Patel <apatel@ventanamicro.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Content-Language: en-US
To:     Zong Li <zong.li@sifive.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
 <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca>
 <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
 <ZNvGH91EmlOAaxBK@ziepe.ca>
 <CANXhq0pQ5wisNtbVjm031btUiO=y_MmA9rfbWwnMFo_1y2d50w@mail.gmail.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CANXhq0pQ5wisNtbVjm031btUiO=y_MmA9rfbWwnMFo_1y2d50w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/16 10:16, Zong Li wrote:
> On Wed, Aug 16, 2023 at 2:38 AM Jason Gunthorpe<jgg@ziepe.ca>  wrote:
>> On Tue, Aug 15, 2023 at 09:28:54AM +0800, Zong Li wrote:
>>> On Wed, Aug 9, 2023 at 10:57 PM Jason Gunthorpe<jgg@ziepe.ca>  wrote:
>>>> On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
>>>>
>>>>> Perhaps this question could be related to the scenarios in which
>>>>> devices wish to be in bypass mode when the IOMMU is in translation
>>>>> mode, and why IOMMU defines/supports this case. Currently, I could
>>>>> envision a scenario where a device is already connected to the IOMMU
>>>>> in hardware, but it is not functioning correctly, or there are
>>>>> performance impacts. If modifying the hardware is not feasible, a
>>>>> default configuration that allows bypass mode could be provided as a
>>>>> solution. There might be other scenarios that I might have overlooked.
>>>>> It seems to me since IOMMU supports this configuration, it would be
>>>>> advantageous to have an approach to achieve it, and DT might be a
>>>>> flexible way.
>>>> So far we've taken the approach that broken hardware is quirked in the
>>>> kernel by matching OF compatible string pattners. This is HW that is
>>>> completely broken and the IOMMU doesn't work at all for it.
>>>>
>>>> HW that is slow or whatever is not quirked and this is an admin policy
>>>> choice where the system should land on the security/performance
>>>> spectrum.
>>>>
>>>> So I'm not sure adding DT makes sense here.
>>>>
>>> Hi Jason,
>>> Sorry for being late here, I hadn't noticed this reply earlier. The
>>> approach seems to address the situation. Could you kindly provide
>>> information about the location of the patches? I was wondering about
>>> further details regarding this particular implementation. Thanks
>> There are a couple versions, eg
>>   arm_smmu_def_domain_type()
>>   qcom_smmu_def_domain_type()
>>
> I thought what you mentioned earlier is that there is a new approach
> being considered for this. I think what you point out is the same as
> Anup mentioned. However, as I mentioned earlier, I am exploring a more
> flexible approach to achieve this objective. This way, we can avoid
> hard coding anything (i.e.list compatible string) in the driver or
> requiring a kernel rebuild every time we need to change the mode for
> specific devices. For example, the driver could parse the device node
> to determine and record if a device will be set to bypass, and then
> the .def_domain_type could be used to set to IOMMU_DOMAIN_IDENTITY by
> the record. I'm not sure if it makes sense for everyone, it seems to
> me that it would be great if there is a way to do this. 😄

What you described applies to the case where the device is *quirky*, it
"is not functioning correctly" when the IOMMU is configured in DMA
translation mode.

But it could not be used in another case, as described above, where
IOMMU translation has performance impacts on the device's DMA
efficiency. This is a kind of a user policy and should not be achieved
through the "DT/APCI + def_domain_type" mechanism.

The iommu subsystem has provided a sysfs interface that users can use to
change the domain type for devices. This means that users can change the
domain type at their wishes, without having to modify the kernel
configuration.

Best regards,
baolu

