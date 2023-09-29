Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC77B3668
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjI2PKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2PKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:10:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565CD6;
        Fri, 29 Sep 2023 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000219; x=1727536219;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rkTo6AiPcIDB8DOJ1mPkz97wz5dXCTcGhw15wnr9YiA=;
  b=g7ipmiBXkyub8TFnv5oVyWzSntlTUqG1xAHmWKW0DDckXTzv7tdvDhVQ
   6fVZFZ0gamjOD7Kk5BhtP+ZOnRr162VJvE29ARXdWX1RvAs9mT1Igqh1k
   GRGJt0bw5waw4jSdxhx1aC+A0vsLXDlP6Fgb+y3fH3M8fQeW7meelK8F7
   Dlzl7nbGd68slEFBYUXLmu2t1fQzWvv1uk0n5dl3Tbldh4VRt9TesCNbD
   76Vz9JG0FVf+lRuqW5QNUEeDVsjYZHfeQ4sy+iVEb+W7MxXq/nUF9PawE
   6TUKIC5vR3/6Ueto+QmQMpKrU+1D1tFPbIRZZJY8WFlVp4/JzXRY+lk8I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="382224768"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="382224768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="726624094"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="726624094"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:10:02 -0700
Date:   Fri, 29 Sep 2023 18:09:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 02/10] x86/resctrl: Simplify rftype flag
 definitions
In-Reply-To: <20230915224227.1336967-3-babu.moger@amd.com>
Message-ID: <cce19488-3c42-e782-279c-141e3912f8ce@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-3-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-191885404-1696000210=:1989"
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

--8323329-191885404-1696000210=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> The rftype flags are bitmaps used for adding files under resctrl
> filesystem. Some of these bitmaps have one extra level of indirection
> which is not necessary.
> 
> Make them all direct definition to be consistent and easier to read.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 9 +++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..62767774810d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -243,12 +243,9 @@ struct rdtgroup {
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> -#define RF_CTRLSHIFT			4
> -#define RF_MONSHIFT			5
> -#define RF_TOPSHIFT			6
> -#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
> -#define RFTYPE_MON			BIT(RF_MONSHIFT)
> -#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
> +#define RFTYPE_CTRL			BIT(4)
> +#define RFTYPE_MON			BIT(5)
> +#define RFTYPE_TOP			BIT(6)
>  #define RFTYPE_RES_CACHE		BIT(8)
>  #define RFTYPE_RES_MB			BIT(9)
>  #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f0d163950969..7ddfa4b470e6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3242,7 +3242,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
> +	if (rtype == RDTCTRL_GROUP)
> +		files = RFTYPE_BASE | RFTYPE_CTRL;
> +	else
> +		files = RFTYPE_BASE | RFTYPE_MON;
> +
>  	ret = rdtgroup_add_files(kn, files);
>  	if (ret) {
>  		rdt_last_cmd_puts("kernfs fill error\n");
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-191885404-1696000210=:1989--
