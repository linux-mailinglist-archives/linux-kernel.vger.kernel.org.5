Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30E787FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbjHYGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjHYGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:25:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687C1BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944731; x=1724480731;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sZrPxJbdhXGilADkAelJ1myrqGQtvXIg1bV4g6vdelg=;
  b=GkTNrbPWuMd9hqIDfp6i88oCjm3mBOuaFKuAKo7OTR1KhTcoHwpM/pAx
   TbBc3IytWo/BDl8cPQyMawbMiZnGO3rFf2X+FmdAJzwqPar8Q+DiGsgD3
   Z9+Fb3ncwOYGNPubqrr5MlL4pVkcf/1Q6Cp3JkTG3Orf02uIkHjGrgOpb
   kMeZ0/NyNUnGTj010M786dxgl43/I93piLtSJgNRDqmflvdNo0dMgH7qZ
   hl8bR0Ta6MbraKhheoyAYLzsl/tKlG4PoT11HKNcvK8TtFyRwLfrWVAmZ
   LQwmjopRFGCpQe6O0BNd9V7gDOF7gmh9rSJtAEqwseQUfr/xcBnjO0qNp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="438583169"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="438583169"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714255006"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="714255006"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 23:25:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:25:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:25:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCojv0VCF1a94aiRC6cEARDJlYtZkyLVWv4wq18NDGWQ3MWAnHmY/2S0pOa87RH/ouMKzeCK7olCXra+yt4gHm8KIIWPLwtbU/48G1iHlzrWeLlLJaHxoOSjBi98c+eSDwFdigvqb8ZQxqushpWnVAz4ay9j2Dk+txquKsLdeDobiKUUhn1WO/3uajHExOyPBJgVUEc0qqkNzxm212+8RZKaPHwR85uKNkeD6E1lj6l0qGyDEauOU6jNZHSe+Kf4R/Sj7+34S5KXGpJoICN+fOqzveG+0x1WS+QyXtYRMNEVkAmZaH2WnRe0Imw5mtKvVLCh/xs/m5d7aBlzm3L2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+qvJqqaajejGH2HwEf9RWbP3pj8cljFsSBsJ4lJR1c=;
 b=fgLI00czZs7lYbbAcvEJjN/lS4M/Oehjpo1xjgIQ5YzpJjBr1lqd0i/F1XpMUyj1rYrLIjfSGSp8hRp89FP4VgSuXMMN+mOdBa4AnOyJA9+sA8fl9nZDRt95NOVuQBkv4aW9dDoSBgkZCrQrD5Zf7faYmLXvwUu2yPc0x1c9fhqJiBmy2loKA5LtFLYzG9lXe5I62SHOM3bBWHacyCk7OtxDq3FPkk5cO4LUwCcl2hQO2Lf/36KWznT88C9EMd/E36XpPHbCdj2F+xgOvOHvpcy/OwOOxhy1OtRSJ3RYul01jisEbPQLMeyOmV+wwhCVPgFpwRXQTi16fPd3ilqjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 06:25:24 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:25:24 +0000
Date:   Fri, 25 Aug 2023 08:25:08 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 1/3] selftests/resctrl: Fix schemata write error check
Message-ID: <c3yp5kkhrc75tvytkbmep7xknqgomyn52xpogqzsy3sp7kwefm@ikzmp6rgzisr>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <e7ea177261ded70f0c781841b0fb67fb1eb8909d.1692880423.git.maciej.wieczor-retman@intel.com>
 <5c6a2065-6771-ed87-c5ed-843f4e184ff8@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c6a2065-6771-ed87-c5ed-843f4e184ff8@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0453.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::26) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4e572b-3e1b-481b-000a-08dba534106d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uwygDD3a38bvuaBr/XqUbWF0yFK2yXhEpYKrfy6oLdu8C4Xcvx8wZg3B8Os+V3QvbL0u8wtLb2j5o/RtvLb+vTXr87VDzpQTbs4FG/37BImLDKSmEI4AvfjMezGcrn4ahCzauT/hZv57qYEfiBU9id1gMzb8uEkR0BEi+f3w1lPS+KGB4g3RIiu3IfSVxYo9jlPiOpGwe68jm7OVzP6XItnGq+ScmAa4BhhGh9kjh+hSvmYeODCanuwAfd4cAkpMW4ZBBylnQx1P5o6O4GjWSQ6EGyLmYpp3iJQDtSFEeC8Cy6XwzvQx+Su3NwtOkfKNWUfmzp9/zah5MRzSqLDtwt+H9iC2zyFDftAfvD9gjHs57JMZrImYBxsShtK/7EzYzp/Ge8Ii7nJUzTSbK6JUyfw/hxsW1LNu4Wp21oJHEb6A/9Xr1YK5zg5w523hsJHW0aX1xD1EadgkXQGMmTZxsMJ3JabJYNwkbikgCwd36LpU0XsA+r8Xtl5j1hVcMU+GXjxYWOKJpiZ/wnG+/Jhb8LPFbccW1JOvCZdjHAy/cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(6506007)(6486002)(6666004)(53546011)(6512007)(83380400001)(2906002)(26005)(966005)(41300700001)(33716001)(54906003)(6916009)(316002)(478600001)(66476007)(4326008)(5660300002)(66946007)(66556008)(8676002)(8936002)(9686003)(66574015)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3peyKhpgt25W3uIdp8HEXP5sHKNib5R9B7h1zexX53Dtxm3Pf2uuGARda+?=
 =?iso-8859-1?Q?yKIsOb3YQ3zoJmvoN+J68PAMUp75+u01bq/VSSRx4ykF0ey5CYsjP7eswo?=
 =?iso-8859-1?Q?t6NLC8eLhHW3tPjhTwG6eC/PSjidXd3QVgZaOlRKQYOBFZJ5CTrtwX9VYR?=
 =?iso-8859-1?Q?VOH4ViETxY9gxGV05c8Tbg7uIOJcjj78yK6Vk5pSKlv8M7zbQubFtjOP+6?=
 =?iso-8859-1?Q?sgNPY9ANP1x6Pa6/maF/rzHnLaW1FB5AIa6kyrzoF/WV/t4xiefrve3vsa?=
 =?iso-8859-1?Q?yR1C3xuVuZtM/sLP+hPRnb1lJX6i9EejjkHgvAet1T7adTedNCYxnshDmB?=
 =?iso-8859-1?Q?2dqAplAqA7zqJX9wiRtYnPgmzWvs4kSIUci3OvQ+XQteEatX4KW9F+1Ft9?=
 =?iso-8859-1?Q?s7Z884YN0hktIpkrY50pCDhsoGzSP0ulrRZz92FMn2wEgw/pOa7Qs+Zj5x?=
 =?iso-8859-1?Q?UsRg+GYv/MpiNkhjIojTZKWBB0RhmP8or/enu+IPn+D9zu5NcAplNvHAWA?=
 =?iso-8859-1?Q?hPTv2jQ6zWKHgAHJHV3NohPf02io5vrqx7oSC8EPONN4XT9Uh4SCiDwgES?=
 =?iso-8859-1?Q?tE/eYWyaf68pnV666rAOKSmO4IT6gYHI4hZiD8Th1tP7rZfzzmDguSh5c7?=
 =?iso-8859-1?Q?t43E97g1fZMtexh78kMDHA6v4lHUfmxoQDN2mVhKuo0I/9gTldNjB+FXKw?=
 =?iso-8859-1?Q?DYzm+TwtFAk4whfDcVW6iiNLQK2xB5s7tNhW7z8IkFA0M3EZ4nZLcm8rH7?=
 =?iso-8859-1?Q?0ILcJRDqyWMIqzBikpGi4q35jGy3tAhiNJznWQANM2djRkudyLEC9HlwuW?=
 =?iso-8859-1?Q?T6J2uDgBPBy5jmBNGxAvCQ5f7og4ehgrzepFs2TkpnC6NoPS4SKqARTW2T?=
 =?iso-8859-1?Q?AIvs0op2LwsRrrB6moOZNqigi3eeiDzH8kgaDzldA0XFgJpnV/ANlaMYb+?=
 =?iso-8859-1?Q?+69MWmKmd+fEpm5RFWxLLi3NWk/egPlIUo+XrZ/s3SWVitS39Ktug+i5SM?=
 =?iso-8859-1?Q?d+pifieSx0H2JaRKLdDNGeNipHMz59lQflmmNSi+sth7PvYPcLn2PV1Srv?=
 =?iso-8859-1?Q?s0qnLt3RGFUNdD6YdtTvvOve0Mn5BR5SnrBAPxfwpF9bnFPCl7XSni08HP?=
 =?iso-8859-1?Q?cakYi8yoAffIpHAWgTBL0I3mmAddlfDBsh8x2sdhPwZlKG3oR9nERs4Smr?=
 =?iso-8859-1?Q?apkifuiH2yQzlH/mRFuin1fAnqDSaXctOP7pBakmJWIvACKtcVHxKNsL0o?=
 =?iso-8859-1?Q?nqbK/QaKuoKnpECj7GsxeZKB/QCMHnt/jeifeDPORJM+wqRGr5VHYeWVMk?=
 =?iso-8859-1?Q?hFBi0ByqEWtDhVtNvsSm8R4+bevW81W3dwQc9Rn/Yn4uje7fHdHw2cD+P3?=
 =?iso-8859-1?Q?g3nEhAd/aFCSCvnBbBU/taA2GW2DbR0EhxBpw73H7hGielqaS4W9db7GO0?=
 =?iso-8859-1?Q?grW33SyTaew7krJ/eJx9pM7qn5fE750SqGyHA/3zOOmkQO7IvF9QX54QmL?=
 =?iso-8859-1?Q?//k2zyrOp7FcC3xnt+PYkdSNGlhkUBNIhU/zvJ2no2Tb5+dEJ7JG/mMKLp?=
 =?iso-8859-1?Q?BL6fJXybfBknifBzK+QCvpHsMaVM4vnflJAScsnmhhHDG/cX3Kxij0eCl0?=
 =?iso-8859-1?Q?7zsA8al6EUEY+5Bp3k++NhA/uip+aYxCUplm/l0lkTwIiV781ot5UFkAOd?=
 =?iso-8859-1?Q?sLgjdjpMichUB1YoG6c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e572b-3e1b-481b-000a-08dba534106d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:25:23.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5/On9e++MeoXtIoKhLeAoC3L0fWhcuTFzcf/iscK+DhQjn9exKwIF908uTll9JShC5IXl8//6w5ukqw7A0PSjxaAf1tIYWalQ2RymzlS9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-08-24 at 15:52:05 +0300, Ilpo Järvinen wrote:
>Ki,
>
>You're lacking a few people from the To/Cc list. Please see KERNEL 
>SELFTEST FRAMEWORK entry in MAINTAINERS.

Thank you, I thought I checked the MAINTAINERS file well enough. I'll
add them in the next version

>On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>
>> Writing bitmasks to the schemata can fail when the bitmask doesn't
>> adhere to some constraints defined by what a particular CPU supports.
>> Some example of constraints are max length or being having contiguous
>
>"being having" is not good English.

Thanks, I'll change it

>> bits. The driver should properly return errors when any rule concerning
>> bitmask format is broken.
>> 
>> Resctrl FS returns error codes from fprintf() only when fclose() is
>> called.
>
>I wonder if this is actually related to libc doing buffering between 
>fprintf() and the actual write() syscall.

I started looking and apparently in the manpages for fclose [1] it says
it uses fflush() to flush any buffered data in the stream. So that would
probably confirm that it does buffering there.

In this case is there a situation when the fprintf() before fclose()
would report an error? I'm thinking if there is a point to keep error
checking after both function calls or just fclose(). 

Or would putting additional fflush() after fprintf() make some sense?
To have separate error checks for both function calls.

>> Current error checking scheme allows invalid bitmasks to be
>> written into schemata file and the selftest doesn't notice because the
>> fclose() error code isn't checked.
>> 
>> Add error check to the fclose() call.
>> 
>> Add perror() just after fprintf so a proper error message can be seen.
>> 
>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index bd36ee206602..a6d0b632cbc6 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -532,13 +532,17 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  	}
>>  
>>  	if (fprintf(fp, "%s\n", schema) < 0) {
>> -		sprintf(reason, "Failed to write schemata in control group");
>> +		sprintf(reason, "fprintf() failed with error : %s",
>> +			strerror(errno));
>
>These should use snprintf() to make sure the buffer does not overflow. 

Sure, I'll change it.

>>  		fclose(fp);
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -	fclose(fp);
>> +	ret = fclose(fp);
>> +	if (ret)
>> +		sprintf(reason, "Failed to write schemata in control group : %s",
>> +			strerror(errno));
>>  
>>  out:
>>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
>> 
>
>-- 
> i.
>

[1] https://man7.org/linux/man-pages/man3/fclose.3.html

-- 
Kind regards
Maciej Wieczór-Retman
