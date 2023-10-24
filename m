Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6C7D502F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjJXMqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjJXMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:46:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6DA9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151602; x=1729687602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wgfr8w1cbLPQHYG5iVU1irgIBoi2fm60vn3H7o4w7c8=;
  b=LZZVwIIRKmJyS9IGA8DfDvDNosNmrKNLsQVeOczZKFCxnjn8qisn+9Dg
   84mGlBORBSFHqM74DE09dIrIXHhMxu7vc0uAs8EP3Q2wDCsDrB7mQORMk
   CCDnO5s7y7Oh8o0qQyHbPTm1uvEf0+dtk4M7j+YRMuK2/Frm1UQy90roF
   sE/74OS5PA+h8D6QJlprRZE9iBlE2eQCcnZ6tY8EaeDUOXorkKEyNYOfF
   oiYRgWCbFQcsFapCFgSGoOV9Cx6lY5ELeySiZNRisawLjD85GtixWnmyk
   qNOjraaS8NhlhmsGZWLYGFt2V+qkxPiCfO2NoUdpQlnUqxnm7w+Yz3g26
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453506411"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453506411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6438628"
Received: from marynguy-mobl1.amr.corp.intel.com (HELO [10.209.14.133]) ([10.209.14.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:46:34 -0700
Message-ID: <af33711f-9240-429f-92ba-b0e67c572839@linux.intel.com>
Date:   Tue, 24 Oct 2023 05:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/13] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231020151242.1814-13-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 8:12 AM, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version
> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
> 
> The field 'mailbox_version' renamed as 'version'. This field signifies
> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
> 
> The field 'base_address' renamed as 'mailbox_address' to clarify the
> kind of address it represents. In version 1, the structure includes the
> reset vector address. Clear and distinct naming helps to prevent any
> confusion.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  include/acpi/actbl2.h              | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 9bbe829737e7..ad170def2367 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -79,7 +79,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  
>  	acpi_table_print_madt_entry(&header->common);
>  
> -	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
>  
>  	cpu_hotplug_disable_offlining();
>  
> @@ -98,7 +98,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	 *
>  	 * This is Linux-specific protocol and not reflected in ACPI spec.
>  	 */
> -	mp_wake->base_address = 0;
> +	mp_wake->mailbox_address = 0;
>  
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 3751ae69432f..23b4cfb640fc 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1109,9 +1109,9 @@ struct acpi_madt_generic_translator {
>  
>  struct acpi_madt_multiproc_wakeup {
>  	struct acpi_subtable_header header;
> -	u16 mailbox_version;
> +	u16 version;
>  	u32 reserved;		/* reserved - must be zero */
> -	u64 base_address;
> +	u64 mailbox_address;
>  };
>  
>  #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
