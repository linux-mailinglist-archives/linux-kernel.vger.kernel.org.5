Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513987DD94A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346949AbjJaXgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjJaXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:36:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEEDB9;
        Tue, 31 Oct 2023 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rmDBg442GPXbpmQYDhM9m5rfvjZvnyUa7KdVKTxDqDI=; b=bkMl9bXQltns243D5IbE6Ep0QH
        nv13VO6dxyB/cnpIxswcNSfpZq9wVh/vlEHHxO91Qkgmev9TFvUrW0S8801hVtfOdnjvnhW4lcQQ9
        4XdAOJ+GBrSxwz147v/D4/0248m6t/SdSwkalUhUxriy4giennW0pfj16uN3Xal4LskOJB0yUexob
        mlwfOgU86zJxGhwCQP9Lt14c5MOOS+Tqk1EybEw8NuK0+UgBs6SDvr1d73Iv8EslRHxffWZip7yxJ
        A7eiFXkb7gOIEJSmbWDcOEuI8mTcwVmrZmpt+9OjZ++d/1UaHfH+5qLSejNH/h81cTTmPwX0ZWbWx
        BbtmyaPg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxyHc-006KX6-1M;
        Tue, 31 Oct 2023 23:36:28 +0000
Message-ID: <cd18356e-51dc-4054-afbb-7f92a45833a7@infradead.org>
Date:   Tue, 31 Oct 2023 16:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 30 [drivers/cxl/core/cxl_core.ko]
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20231030163344.5a39a625@canb.auug.org.au>
 <dc312544-6070-4299-b9ee-903b34d7cf21@infradead.org>
 <e3e9bcc3-e026-43d3-964c-5f5b51916782@leemhuis.info>
 <65413d5ae720c_244c782942a@dwillia2-xfh.jf.intel.com.notmuch>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <65413d5ae720c_244c782942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan.

On 10/31/23 10:46, Dan Williams wrote:
> Thorsten Leemhuis wrote:
>> [CCing the CXL maintainers]
>>
>> On 31.10.23 06:04, Randy Dunlap wrote:
>>> On 10/29/23 22:33, Stephen Rothwell wrote:
>>>>
>>>> Please do not add any material not destined to be merged before v6.7-rc1
>>>> into your linux-next included branches until after v6.7-rc1 has been
>>>> released.
>>>>
>>>> Changes since 20231027:
>>>
>>> when CONFIG_ACPI is not set (on various ARCH):
>>>
>>> ERROR: modpost: "pci_print_aer" [drivers/cxl/core/cxl_core.ko] undefined!
>>>
>>> Already fixed?
>>
>> Doesn't seem so, I saw that yesterday and today in my ppc64le builds for
>> Fedora (based on the Fedora rawhide config). Build log, in case anyone
>> cares:
>> https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/next/fedora-38-ppc64le/06583955-next-next-all/builder-live.log.gz
>>
>> Seems 0day ran into this, too:
>>
>> https://lore.kernel.org/all/202310281921.W9lzomPk-lkp@intel.com/
>> https://lore.kernel.org/all/202310290131.Z10R00pk-lkp@intel.com/
>> https://lore.kernel.org/all/202310302206.Pkr5eBDi-lkp@intel.com/
>> https://lore.kernel.org/all/202310310457.5LusQqF6-lkp@intel.com/
> 
> Yes, apologies for the thrash. This fixes it for me. I will append this
> to the cxl/next branch:
> 

Works for me. Thanks.

> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index f6ea2f57d808..3db310c19ab7 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -43,16 +43,20 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +                   struct aer_capability_regs *aer);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +                                struct aer_capability_regs *aer)
> +{
> +}
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -                   struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>                        int severity, struct aer_capability_regs *aer_regs);

-- 
~Randy
