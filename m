Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721B7CB793
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJQAqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjJQAqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:46:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453199B;
        Mon, 16 Oct 2023 17:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697503606; x=1729039606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U1bzVqrASa0n4ZsnAbzcw0+bRSpMXl2QiUT6PSZuyLw=;
  b=ZqxTwus08Cjrwp3jvd4NfQzpRDgFAkjLwkkX2nhawUs6agVjOIa6YnLL
   hJ+kied6awqe4HaG+lIZFvJ+mKpSohkX8VAtV3qW3QgsoXi19sRJ8aavv
   6w9vgoOV+Rwdp/WlxWH/3zxpN0Z7ayS4hpyYm9+wWjpbPVRUSvh8P/xZE
   A/s2NIZCwtVfuGTdgz+8H3Iu+OfbQNbrE9vf9wP99lC0rDOmtT7oiN7b0
   RY/KJu319l9Qr9UNnXNOX5IKozFFNw4GAfjAusMpL7OULPFs1rozlsaCf
   FFsiGWI6OD/VeoMBpiiJ7YpIalWvwxGPPdDKTl1l+GHTcc2Q0pjRsjAuL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376040648"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="376040648"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="929558402"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="929558402"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 17:46:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 17:46:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 17:46:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 17:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4f9v+Ub9r6SAJIuooDoBR2opWjbgYNySZsTTMUjospU69kLhi632/hGB0pcQuWkL2XebJ4d3DkXtDBxYYf/9pqdqry3pkN0A0VV+cKqG91zSJBcoxTQjANHhaC9J2LrrGFbG1YYp9m4SnXXbx4QMqHQBI6D1yp9SYCUbwjfu0UtP8Qx8ZNvSmRviB4eXJBG6fNFR10cY861aCBJpnfe08+0N5NxyCbBWvRCo+a3E5fOYLCPYT9exYkESzi8FI8ykBN7+DeVq9DwY5Vz8rzOft2CmoTMkvqVldTCxr1uj5zL3i5zGJenejraPvztSQk6xEUnJfTVIpsg0DYo1rm2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiPzBrWlVURtoNZJU+1cHg7cHf4hkGBJX6WOO1mCIYA=;
 b=h/6oABEqiMMkqntYJFOpzHHG+n39Ig1xIhu45pzy7NScBc2VewmK4K3qc2R1YlrwWsuQ8/qGNBpww5ITt6bjSIqErnBHu8h7Gu4Z45k/mZKHRlong7gQtKKUi0blhKDKOgCcf0dxbf6yo/M6fsi1jvkQuIbJf8Ck6hts2oVifFS1fnOKhIsXQADsup79fy3B+3CyjYdE7pAPmxliRxq5p6c9atq5D778vIMWoZLKC8Eer78DztFdFgrLXlrinx1V1iKSSBzOMYNrvGAS/Jhfq6gg/0deewqtAO3MM0UXiZpmPLAEj2fewnRylRanVdV541UioE4CewwXz8xjF0oMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:46:41 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::4286:c28:4465:752%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 00:46:41 +0000
Message-ID: <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
Date:   Tue, 17 Oct 2023 09:05:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
Content-Language: en-US
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|CO1PR11MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f433d0a-a45a-4a1f-5527-08dbceaa86c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADSIm7o2Q5uUybMKyfBgJct0LUZ1/tLPj10TQIUMHemi/5Ij0sSGCAFG2JSlu68aSOpkYpw6Jr0cdIxfmL81mzcB7kEA9xznjTOG85aD8n/pjR7Z0pMsYmA/NZf65q6/Ipjql4CzouQ+dX418UET20HWB766l8Pht/DzLTv0P87yf+/7K2o6va1YC7l0b+GOUTlYy0soM+aZXtFEfRhbt0+9X7GQMJOiIhbDFcBiTHs4aq+y7ZPu3fkf9p0ajaBvuy0iXSAA2UqbW/3mmWQgGnlqq9qzpkW/YFp3xLNnFczguDhm+vrO3H2eBIDp5AwQlpan8q9tG25sbMzmFVZ4EAB5rW/roWjZiERGneZ0LhJyJP7cwk/qbr4SDcoHLUsaBFCWk+HjNiX3auz2Bbe43rKEhA+HnvlAtdNhtBaAdyz+TFsnmf7dBf+MLMEbnIjM39/TEq2p0Qevfs+0n/If5VJf9HRVzMlYCTrlZYdNrw3mok+vOMIaGrpdeHlWxlgc5l8yBPX0+5CfVCdqQHLeMH2gVt+SFLLRu1WNEjWbYpXs40ZtYT4xk0QZYeCqaCNvxLTvbFLG7aiRawMHtAN3fig6iHpbYhO2N4zRI/TfX2SPrkMmkoFgdgwrNcMwPGoGYJwYXoSwCFurC0D0gT5kxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(478600001)(66476007)(6486002)(66556008)(6916009)(66946007)(54906003)(6666004)(26005)(53546011)(6512007)(316002)(6506007)(2616005)(8676002)(8936002)(4326008)(2906002)(5660300002)(36756003)(31696002)(86362001)(83380400001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hHS0pSYXFsRGx6TDBza296Z1BZTU1RTUZ0ZldjaDJ6QVltenQ4M1NMdmhk?=
 =?utf-8?B?dURwdzV6TTFSMXk1UDVnaWZHUGdZZUJwWHVkMDVHUnZTeUgyV3JIVm5jSTRi?=
 =?utf-8?B?ZGdwRjZIM21tam4zaUNNUEpHWVkwQzhMVnR4YXFHZk1YQVdZR3BhK0JsQ0RE?=
 =?utf-8?B?RkdNeDI5dEVqdUV4WnhacG14aE5XRy9MQjNyYVk0R3B1YWdFcjdneGlZMFQ3?=
 =?utf-8?B?NGVsZk55RVBsTjJHVGJKUEg2aTFRRkx1V2dCVGdHbEQ5TU1uamJuVk5CKzcz?=
 =?utf-8?B?blFGRjRhS0VpYU9YWm4zczNYb1hCalVtNVRkaUV4MjZhRXVwS1ZiWkpOdHMv?=
 =?utf-8?B?L2p1MzdndWZtQkNHeXNRTzcyRlBCUVp0NkJ4VGdSajBsOEY2b3kvQ2p0Z2hy?=
 =?utf-8?B?d0lnK1BOekZERDl4amJ4S2R0azZqdXJCbGFvQVpUR3NmVFhQTEYxdy9pc2sy?=
 =?utf-8?B?Q2IyY1RoTmNaUzIwbjd1OEVadWZBQUNhVnduK1ZPWFFlWmpTVEs1QnBrb21i?=
 =?utf-8?B?d0RkQ3QzaUEzZmtEQ0FuRklzYkxEaUtmekx1NXQ2NnAzK0t0M1p4b0tmZWN1?=
 =?utf-8?B?azc4aW9MMUQrb0d6eTZsK0UzU01yS1dSaVJCa3ZZS2taK1VvSEZzNC9nK1FQ?=
 =?utf-8?B?MEhqQVoxOUF1ZUM3NGtQSE5GMFYwYWZUWFFsaGt5blhwQnpJUWxIUThmRFMx?=
 =?utf-8?B?UnEvSVpDRWMzTVJmOGc5NWdGZmJyNHQ2bkIzaERJOStvOWJoeHR5SHhEZTFi?=
 =?utf-8?B?WmhFbFd4R1ZzY2ZhYWZlNEtJcTUyQmwveHN0ajJvSHBXaFB3M3c4MlB4UVVW?=
 =?utf-8?B?T0RNV0ppQU9oWmtFREN4VlZJWmVMRU5YVFVVM2pUOGFualE0eElmWUJESjlI?=
 =?utf-8?B?bCsyR2ZDaHpPeVNQU0tld3J2TGNTWTdCWnF1V3N3UnpxalBkdUFteW9xaTF5?=
 =?utf-8?B?OW1PVXFtOVUvUDdDeFFJaWFZMEZBZ0pZWHYwVDFTWFMxSlpNM1oxREF1cGpm?=
 =?utf-8?B?K3RlWGRGd1VUTVd1L1RnVG1FdHM4UXYxVHM2bVNmM0NDdFRHM3NlcG5sV1U3?=
 =?utf-8?B?Z0lKMTB5WDR5Skl1SEVIUEhvNGVCVno3RXcraG5pZ0lzNFdwWXZad3pXSjM5?=
 =?utf-8?B?RGRaMS9vNnROcHNFN1hrK01VbUJzSGFlSytVZ0ZPQXlLZ01rVnJWazZkOUt2?=
 =?utf-8?B?ZXpkWXVaNk5Ieitkck5POGhxNHVjTXhvNGZDbFNWVkZMekVSNDE0UjJ2VTE5?=
 =?utf-8?B?bk9tdkc4WUoxWXlVcGMxQUxCRVFvU0QxenFkK1J3RFhIS2NGVzVqVzVxT2xq?=
 =?utf-8?B?VUkzelVVNkw1WEowbFlTN2pjeXZNMnQ3WVQxYWY2OThBRkVxTmdVeGllbmhQ?=
 =?utf-8?B?c3ZUTlFOTDRWME4vbWQvaS8yVmRzYUFaY3VCV1JKSWJXWkNvMmZuK2xYMHkx?=
 =?utf-8?B?aEhIdlZNUU02RWZ4dFcrU1VzejNyNVdZY09oS2hiOGtqb1A1VUlUSkRxTDE3?=
 =?utf-8?B?cWlBcXdUaFNzU1hZYkJVVFZNK3AzY2pMWEtQbjNXQVVoT1JxVUJtaGJyemlz?=
 =?utf-8?B?ZHdkbnZnd2s1VlcxRXVXcWtGV0ZKUHVsbUVNRGVnRmJiYjdONXJJMURlNUdj?=
 =?utf-8?B?dTNOSHI1bTVQcll2QWFqdzVZNzBUMFdWVzhSdE55QmwyMFhpUC9Bc21xZUM5?=
 =?utf-8?B?clAreW9HYW1mRzhEclF6UEZwd04yZGxVeXlhOFhjYnZTMjAxcUVJSkhmaE5q?=
 =?utf-8?B?dndCajJZVm10MENiKzJzNlowS2pFOWJ0aHdjMGpWUHhYWVNSMjd1QWhZS0Fq?=
 =?utf-8?B?SStvOWw5M0kyU2Q4ekI4RmlneTkvN2swdUpSTWtYQk9sQ0xjSGRiNEVkOUdr?=
 =?utf-8?B?czI0dGRxd2REamM2NnNJVGhHVmFUZzhjNVF5RkdxM3NlRzlPZ2V6RHJscVM4?=
 =?utf-8?B?bDhkMlVER2tTMmFmNWtmcEQxK0tHenRtWEFrME9GWGpNQ2U3UWpkUTM4ZWs1?=
 =?utf-8?B?ajJncnZyQWxJT0V5a1A4R21qMnJrdlJ1OWE5Z21GSzZtd1VkdEpLSlAxc1Z6?=
 =?utf-8?B?RXE5QjRWOUIvcFlmUkhRZTEwQlpHVTgvM3gwUEJRRjNqbU9MSHFmc0IyY1lF?=
 =?utf-8?Q?zXzGpzy2HFupBe8PeAmh/JZ9/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f433d0a-a45a-4a1f-5527-08dbceaa86c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:46:40.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4wAdX7QDv9S9+6bfDlshEShV82GzVzY0IaiD6iOcLa7B2FYlCfk/ufJHa9tLPRGclUgWnG7RXuziFps052pUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 17:11, Borislav Petkov wrote:
>> For some MCE fatal error cases, the kernel might call
>> mce_panic() to terminate the production kernel directly, thus there is
>> no opportunity to queue a task for calling memory_failure() which will
>> try to make the kernel survive via memory failure handling.
> You can't "make the kernel survive" if the error has been deemed
> critical. That's mce_severity()'s job. If it grades the error's severity
> wrongly and memory_failure() should run after all, then this is
> a different story.
> 

I understand what you mean.  Looks I didn't express myself well on this
point and caused ambiguity.  Maybe removing the attributive clause would
make it brief and clear? Such as,

	For some MCE fatal error cases, the kernel might call
	mce_panic() to terminate the production kernel directly, there
	is no opportunity to queue a task for calling memory_failure().

Or do you have other better suggestions? Thanks.


>> @@ -286,6 +287,17 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>>  	if (!fake_panic) {
>>  		if (panic_timeout == 0)
>>  			panic_timeout = mca_cfg.panic_timeout;
> This whole thing...
> 
>> +		/*
>> +		 * Kdump can exclude the HWPoison page to avoid touching the error
>> +		 * page again, the prerequisite is that the PG_hwpoison page flag is
>> +		 * set.  However, for some MCE fatal error cases, there is no
>> +		 * opportunity to queue a task for calling memory_failure(), and as a
>> +		 * result, the capture kernel panics.  So mark the page as HWPoison
>> +		 * before kernel panic() for MCE.
>> +		 */
>> +		p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
>> +		if (final && (final->status & MCI_STATUS_ADDRV) && p)
>> +			SetPageHWPoison(p);
> ... needs to be inside:
> 
> 	if (kexec_crash_loaded() {
> 		...
> 	}
> 
> otherwise it'll be useless work on the panic path.

Good idea! The condition makes it more robust.  I'll validate it and
send V4.

Best Regards,
Zhiquan
