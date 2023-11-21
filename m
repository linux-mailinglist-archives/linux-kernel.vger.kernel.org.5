Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3D7F28FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjKUJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjKUJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:31:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6346BFA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700559072; x=1732095072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzOd0cd2+5cL6VwtiHKsX8WwvIE2qYTC6osgFynenks=;
  b=B+9DNo5FDG7g4h6J7URhM3jO6PpSfe0CgRiDRTHWdfMzu1EZtzVC0FJl
   57KEQnlG2NXvXVE2S/12ABB06Z3TT6ZCInoSjygS00jX6Jzz4G5+2CgZd
   vlwX/LkwlsQeZp7tOC9zvgLsRd6eVVL1PxIsYte7b8UabrnuY08KAS7as
   OXaaCvyzS0Zg5H8RFg4nBv8HmHOjo6kaQowjU+4QvFsnE5cEmH0h+EwxF
   h9L9tBqmlmljrEaiRg4V70UhSYnMGgzVfNeMZAJqtiWwRDq0RrdnxOw7E
   jxW8l8IpJURAzx3MrMjP+1O7/0p6JD91Nf6yJVDlS9tFgRl9Zb8lCAIoG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4930133"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4930133"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8023791"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:31:08 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 14A2410A36E; Tue, 21 Nov 2023 12:31:05 +0300 (+03)
Date:   Tue, 21 Nov 2023 12:31:05 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Message-ID: <20231121093105.ev77pgbssq6scugm@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
 <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:15:59AM +0000, Huang, Kai wrote:
> On Wed, 2023-11-15 at 15:00 +0300, Kirill A. Shutemov wrote:
> > The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
> > it got woke up.
> > 
> > Currently offlining hotplug is prevented based on the confidential
> > computing attribute which is set for Intel TDX. But TDX is not
> > the only possible user of the wake up method. The MADT wakeup can be
> > implemented outside of a confidential computing environment. Offline
> > support is a property of the wakeup method, not the CoCo implementation.
> > 
> > Introduce cpu_hotplug_not_supported() that can be called to indicate
> > that CPU offlining should be disabled.
> 
> cpu_hotplug_not_supported() -> cpu_hotplug_disable_offlining().

Right.

> > 
> > This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
> > MADT.
> 
> Is MADT too generic? MADT wakeup?

I'll replace it with "ACPI MADT wakeup method".

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
