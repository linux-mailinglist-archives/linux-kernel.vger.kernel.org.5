Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69A7B367A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjI2PSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjI2PSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:18:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B1D6;
        Fri, 29 Sep 2023 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000681; x=1727536681;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VZ3WShJyCrZYn0NzPBevyJXuJ6fQOlnkaBO79lTV9aE=;
  b=i22AcR43u919svQeetZ/SlfYKAzcVj/ZTYjZD2sm6PlAQ3CY0gymrmlg
   Yt4OA6D4MieRJtAvaMCcPuwNnXZcHkTEfAnyQwrj0ihCaXTkyVXUWhSWs
   Riv1E7YDL2xGCdD0/K+90LwlRpJRmLTYOrK2RNbDYXq8tDHKaU7mhx0xp
   0B8lFfLSLF0RzVx+LZrs48An9ThGPxo9Bq44huT9XeKEKFmZD9alhUk5b
   H1btaDIgIz0SLpRktog2NLBGQWDKu6Nwwue/BT3wCNI+SPfJ5ci2Vyszq
   ClSCWBpV24oDicq5wpfW8038ObDivGbwZ6xUPOhFH+NzrH0cGhUQ9Bd2w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362567583"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="362567583"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820239422"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820239422"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:17:53 -0700
Date:   Fri, 29 Sep 2023 18:17:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
In-Reply-To: <20230915224227.1336967-5-babu.moger@amd.com>
Message-ID: <7b5f86e-e6d4-2aa9-652e-ee1ccd48f2a6@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-5-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1352571749-1696000680=:1989"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1352571749-1696000680=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f71bc82c882f..14988c9f402c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,64 @@ struct rdtgroup {
>  
>  /*
>   * Define the file type flags for base and info directories.
> + *
> + * RESCTRL filesystem has two main components
> + *	a. info
> + *	b. base
> + *
> + * /sys/fs/resctrl/
> + *	|
> + *	--> info (Top level directory named "info". Contains files that
> + *	|	  provide details on control and monitoring resources.)
> + *	|
> + *	--> base (Root directory associated with default resource group
> + *		  as well as directories created by user for MON and CTRL
> + *		  groups. Contains files to interact with MON and CTRL
> + *		  groups.)
> + *
> + *	Note: resctrl uses flags for files, not for directories.
> + *	      Directories are created based on the resource type. Added
> + *	      directories below for better understanding.
> + *
> + *	info directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_INFO
> + *	    Directory: info
> + *		--> RFTYPE_TOP (Files in top level of info directory)
> + *		    File: last_cmd_status
> + *
> + *		--> RFTYPE_MON (Files for all monitoring resources)
> + *		    Directory: L3_MON
> + *		        Files: mon_features, num_rmids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> + *			    Directory: L3_MON
> + *			        Files: max_threshold_occupancy,
> + *			               mbm_total_bytes_config,
> + *			               mbm_local_bytes_config
> + *
> + *		--> RFTYPE_CTRL (Files for all control resources)
> + *		    Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
> + *		           File: num_closids
> + *
> + *			--> RFTYPE_RES_CACHE (Files for cache control resources)
> + *			    Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
> + *			          Files: bit_usage, cbm_mask, min_cbm_bits,
> + *			                 shareable_bits
> + *
> + *			--> RFTYPE_RES_MB (Files for memory control resources)
> + *			    Directories: MB, SMBA
> + *			          Files: bandwidth_gran, delay_linear,
> + *			                 min_bandwidth, thread_throttle_mode
> + *
> + *	base directory structure
> + *	------------------------------------------------------------------
> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *	    Files: cpus, cpus_list, tasks
> + *
> + *		--> RFTYPE_CTRL (Files only for CTRL group)
> + *		    Files: mode, schemata, size
> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1352571749-1696000680=:1989--
