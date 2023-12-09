Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F280B351
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjLIIs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLIIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:48:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92710D0;
        Sat,  9 Dec 2023 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702111711; x=1733647711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BArBMRz+Uu5UuNs6uA3RiQFC97rd4SqkRdb+dYG43vQ=;
  b=OYjoR3u02cYbODohI4k+TGOe/sCWI3aRHtq+hYYuZPhEqLIGanrsTZ5k
   FKsUkTnuC+Kf90bfnwUmvncpMmrurznmAp7iKzKkhxrUQcBemZELuRbTv
   QxpFNyYs5d3fGnSFQisn1EAru9Mr1FYCLN7p1znDOZrHikI0QMjPoJVEU
   b02DaZQQN8G675x5UG52gU94PhvagqK+5AoYjDmcfQg9ltDIpLL0g/ef7
   3GXUfMuMh7IhPC3/2DeaDym1ymFd1niaJrnpGgvOo6hfEhhJ1Bp/cVb1H
   faUK701spzedOc1rNgefU8yunHrnfLgGuNbXpp8skO3oC5T7idm1Rpxh7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1573878"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1573878"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 00:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="863150723"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="863150723"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 00:48:26 -0800
Date:   Sat, 9 Dec 2023 10:48:23 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 5/5] perf: arm_cspmu: drop redundant
 acpi_dev_uid_to_integer()
Message-ID: <ZXQp18e9IR5w41wW@black.fi.intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
 <20231123100617.28020-6-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100617.28020-6-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 03:36:17PM +0530, Raag Jadav wrote:
> Now that we have _UID matching support for integer types, we can use
> acpi_dev_hid_uid_match() for it.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 2cc35dded007..50b89b989ce7 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1108,7 +1108,6 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
>  
>  static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>  {
> -	u64 acpi_uid;
>  	struct device *cpu_dev;
>  	struct acpi_device *acpi_dev;
>  
> @@ -1118,8 +1117,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>  
>  	acpi_dev = ACPI_COMPANION(cpu_dev);
>  	while (acpi_dev) {
> -		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
> -		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
> +		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, container_uid))
>  			return 0;

On second thought, I just realized that this can cause false positive
in case container_uid is integer 0.

I'm not aware if that's a valid value to match against in APMT.
If it is, it's better to drop patches 2 and 5 for now.

Raag
