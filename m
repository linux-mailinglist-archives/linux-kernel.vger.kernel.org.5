Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E778C7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbjH2OlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjH2OlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:41:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F37E1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320075; x=1724856075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZFb5DtXQLnUngS/ViAlwZaiRhxG9pMVKO12OoPdGRBs=;
  b=ERJ98/doOoZ5JZ85gmQENUCfde365l8ba9M0BUWr9kAiG51hkRCBTRvB
   ad2ifQyG5RR6dGUfsxPt/TFnwCREn7VYZKDIQf58KgFIa42yI0TgYbJd4
   scChFxJ6ShpbxtPjafTPm+zKb79SCwNtwtPIBoFQSmjn/808VW2exWbVF
   8xWTcXjhJMs1zmNnrWxbpCFsxA3vDYI+QhXM6Dl698hZdnWQg10csHhEB
   wSY12QRDhxw37FL2FDmIYAxU/FVR4xc33kn4bJRp2a3La66JXQzChnFba
   9Or1wLgRs0SFMy8fviLhraXrkIizVq0GESxPWPkI7hYtUPlcQarpRZ7rf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355708117"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355708117"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="912445951"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="912445951"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2023 07:38:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 07:38:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 07:38:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 07:38:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 07:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR0/njyOeG82gI8nbW75sI/0aPzUZmv1nfajzY2Ofy3cEq/vCzAc6fLQWnq11iTL+mSK3mIcrtshgaY0244ObDiITYuHd4jv1qevVZLuBN5iYe2r09VsUmHXSSswPQuPiC72Ary4jR22+ezBJF6g+FRmDWWSjeIqi2w+vrgflQ8KbRi6NVXj732Dfmhr7nTxFkoTiiegBBWNUB4pnuTWZArgbSruED8IWQQ1DbyjaHX+EwdSNm2wcW+Joiae6H/Fc95cTOusZFzrCjBZJMuIpgdbN6yiMHvsm/jQBArdqCwhUg1xCF8Ro1oU9Rj5SUID2t4ZGRV8M8N52skx46QBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGu03Uw3Rre5ukdnwkTVjyEtz/n42BFElvbnen7RvMU=;
 b=gI5t6gBu/w9ln7z4i9MRSiRv1IVvZWd2R1m4GnvBCSuCtksVJEJrW7SRkq90puu44L4CZSpWaAYgJMmywu13feXLtccEkaLQm5IaoOq97wcM3nwuYYIhlPqp9+qUM0Xpcd7L7lQ+QkSur8khMaAukWbj37IGlHeWR/5qCOyeaO9ofzB2A7UQwe26A3Krks1pAqcR4mAuzNSm04JGXxM7dVfmgC8luPzuBx5Q9MZoROUUPG9BmDIxqbodbdyQ/Qzn1He8okuwm1+e67aNxFc5yR+UfHRdduE0uIbxasG+2vQR92QpJhmnp7rz81cIeY+kFW97uwKx1AsDEttoMf4J2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 14:38:41 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 14:38:41 +0000
Message-ID: <6a50e2c7-a73b-ff02-3e36-e7477ea7dc4d@intel.com>
Date:   Tue, 29 Aug 2023 16:38:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
 <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
 <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
 <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a1d6cb-02d7-4dfe-8d52-08dba89da3a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKCiN7LW+6gXOCrEp7WEbC9eqNlSu02a4Yy5miJHIoLY3tbfwoh3fuLd4r09U/QnHM0YY7Pofp46YHeMn1PXeTawlIpb8S0DH+uHbQmZfJiMIpe1SYqmghByHEMLKsnaNkKPxnD7J7VSs8b0O5dCTKjbCCMdtSakj5dX1glBbeMX4zX7+FXkFRZMkoAg1gUPOzOxUJHiie+pv7IsWuPV2ALOE4Q51MlJz5zzQ+q50F6yOsq+uWLIsIYRRpy5M197UfUJwUBGceHuEwtxbmrbpTnIN3bu4/cxSzmVwRD/KSK4tq4TmnjGioYrzPXNJ0wGks5bJpuJE3SVVhw7TXKHEjjht/vzJq517Z5CremTVCJoCuix41XZVgHtQtqBVZ8IGe2dMYGRs7siBB5vq3d/yy9aMr2bvEsEfVWBsmR/A1q9flaMZkhnyaJXg/XBkqyXxwJmAwDH1afR5Pq74xTLqB0mx3ZqI5LkL+SPyLm0sHqrpSELKoMlnhS/03tO793pfe59wyAPaNXoyYxPJ1edFqd2jXy4Ia/Slf9Au3lH8Gib98Pe+VaqCUZifDNJAp52rSAQs4/KFOLtKN4Jty+9gZeNKt78mCJ1jz8bjSwPo6SCu6ixyNRDMuvr1BWz9fzS0TP7kfgrIVisAgfIFKuClw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(6512007)(53546011)(6486002)(6506007)(38100700002)(2616005)(82960400001)(6666004)(31696002)(86362001)(478600001)(83380400001)(26005)(36756003)(4326008)(8936002)(8676002)(5660300002)(6916009)(316002)(54906003)(66946007)(66556008)(66476007)(41300700001)(7416002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkxoa1I4L1ZHUFNxSk41TEoxVklXWVEzWEhwc0tDMXU4ZHh0T0xCempoR0V5?=
 =?utf-8?B?Mk9oU3BXaDZEQXJqUGU5Tk1udHhFOFNJaGoxUjdRUFMxMDFpbnZZeVF3NzhQ?=
 =?utf-8?B?ZitZYjEvS1B2NGlxM3BncnVJVDdOaEpkeWtxMnVlRUw2c2ZnUUlTSHZMNllX?=
 =?utf-8?B?MjFJRC9CcHg3U3VwT1RsSUdRbzdNWHpUcFlwSWJGd0toU2I5WmtmNTNnNUhD?=
 =?utf-8?B?QjFtOXh4djVISHA5UzVZampBaUI3TXVtV2FsaHFCcm10a1FnM21MSjFHL2p1?=
 =?utf-8?B?MzI0K3BYSURqVWJFR3hmZUhBWS8zb2JwbG1vMWZtalQyNnhCSEd3VmJobWQ2?=
 =?utf-8?B?amEyMk81RVZvUjVRM2o4R01NL0pIRG9yTUc3b1RmNzNRYWJ2OHE5K2dwQnRO?=
 =?utf-8?B?WmFJMXFLZHdhSHlzVHBZS2J3ZkFnTXN5N1RUS1pKb3B4Q0RYVGlGTFhqTDMv?=
 =?utf-8?B?dTAvVGJXZkdPQjlaUEZRT01nZXJYbWRjQUFIQnlJNkhTRlU1K3pJTzZmVDhS?=
 =?utf-8?B?aEh6S1FFYWdNTjREbGp3VkFUdEluN1gwK2VVektvZ3M3Szd5NlRITmRPUGg0?=
 =?utf-8?B?bkhEM3BhK3dqcys4YkxGbTNjaG01S0xEbzVzZUN3TXVZbDdzNDU3Y3h0ZFdq?=
 =?utf-8?B?bTM4ZitCdEMzbHBwWWdJOGlxUU5Rci8zampyRTA2WkxSVVhFME9HcHJmN01v?=
 =?utf-8?B?VmtPTDJFTVFNMU96UFZrWDhwZXMrM0szODRVWEV0cnRSc2YwdnMwY1dDTWEv?=
 =?utf-8?B?cnFiRUV0TitwMDNiUEprcE9TQ0s0czdsRCtBYkJ5VG5LcTRnUTJYZTMxQ29Z?=
 =?utf-8?B?RC9VVk8vM3V4cVlBK3AvOWVHTDZsQnphZklxRk5Xamw0TFBaWHVDTlpRRTFY?=
 =?utf-8?B?cnpQY0p0SG02bEZCWUJON0FZOGxCc1dIQmJFditLREt1N28xWU9TUWQzOFpi?=
 =?utf-8?B?TE9sVEY5RGJVWVBWZjRHWDJrRlBKdjNEZXpjY3gwejNCYXZWTFV4RVkwaVRN?=
 =?utf-8?B?alp5elhJYjEyaHZVUkNSK0hPUlkrYkF0NE50bHVXOGxFVVhDL21JNFFNN1BD?=
 =?utf-8?B?dU40UDVpWDhodTNZOGI1SmhUSnVHRWF4WEE3ZlZzNE14dHcvQUpsZzMzaXc0?=
 =?utf-8?B?L0htdFdqWmJsV2RlS0NDaHk0TVE2L2d1Ym1Xb0NERHBYNzF5Ly9lUVZVUkpB?=
 =?utf-8?B?aDFOSG5VN3dHMVVnc0g4YW5xYWlLdldWNGNGajd2VTRkOW5iSkRjTGtQUGIv?=
 =?utf-8?B?QWtFZVh1VXU2clovQktwNStONVBuRDRQd20wazRLcFJpY3RqQXA4Mlh2MHpp?=
 =?utf-8?B?RVFkSHl6eU9JQVRtZHVuMjFXSjhtcjBZbGxISmtQY1BkRmszQ1VnWS9WM0gv?=
 =?utf-8?B?aXdaYUpIN2JpT3V6dlA1aFY3UDBCVTJNSGhNYzBnMW8yZy9XSUZ6OW90TUNm?=
 =?utf-8?B?SXAvS2VWci94ejJwdWt1TVptT2lmcXBpazJxcktMZC9FUm5CdGF0WkNrRVV4?=
 =?utf-8?B?US9LU0FBUU5GQnpybmpLZ281UFgwUEUvbHhscE0xNmV2dWYrcHVRUEwrN2JY?=
 =?utf-8?B?Rm9xUW1SVml5SVdmNlFjQTJUTXBhVThhVG5Pa1NlN29qUGRZbDdZSWtCTDh1?=
 =?utf-8?B?ZTNkMTBSNzJOVVhwVmtyVkh0NG5Ea0NsRmJBYVQ0ZGt5c2VidEFZS1VUMm1L?=
 =?utf-8?B?d3h0YUZydkFiZzIrMmZEY2VGbUpJbnhrWE5ndWdKVHhZbDRGcFlBTmI5eVBT?=
 =?utf-8?B?dmRBV3hSV3JiTnZwWC9rSWphVlVLZm1MS0w1Y2c2RTJ2OExKamlwM3czSWRh?=
 =?utf-8?B?Si9YbGJFY2xqR3I1QjdlL0NxOVRJWWwvNGNLKzZDdDF6c214QVZaNkxJdnEz?=
 =?utf-8?B?WHdKOXpKVU9LcnZBb2pkUExZRUp4S3JvOUVZTjBLelZWdTBHVUpFTDNIcEts?=
 =?utf-8?B?YzVrU2R1L1NyM295RmZJL3ZFdDhXWFp2ajkzUHVBWWIrUWtzQmtJOHVWUEds?=
 =?utf-8?B?V0Fjalk1VnJ6d0o1T1BEK2ZGNVVXRU5tQVR3M1ZHUWtCODF6K0JFYVhtOHN2?=
 =?utf-8?B?SUVsV0c5Mlc1ZmdneUc2eHg0T2k1Y0JUanllZmppVTVIYlpRQThBOWM2MU9K?=
 =?utf-8?B?ZkM1dThkNXBPVVZtVzNJclZpeHJ3OTEvQXpQelRoOFRXQlVEMWEvVmM4RWRM?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a1d6cb-02d7-4dfe-8d52-08dba89da3a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:38:41.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNTjFygRpWVveWX2Vqlc0UHEYeYqjj+vggKOBTgLGHBQqa0hzl1qrzEvxX01N4v2PquvtxIziCoRBWIN+nKwGSwqsllTsHdHw6O+30a6Poo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 4:25 PM, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 4:21 PM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>>
>> On 8/29/2023 4:03 PM, Rafael J. Wysocki wrote:
>>> On Tue, Aug 29, 2023 at 3:58 PM Wilczynski, Michal
>>> <michal.wilczynski@intel.com> wrote:
>>>>
>>>> On 8/29/2023 3:54 PM, Rafael J. Wysocki wrote:
>>>>> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
>>>>>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
>>>>>>> introduced a workaround for MWAIT for a specific x86 system.
>>>>>>>
>>>>>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
>>>>>>> consistency and rename the functions associated with it, so their names
>>>>>>> start with "acpi_proc_quirk_" to make the goal obvious.
>>>>>>>
>>>>>>> No intentional functional impact.
>>>>>>>
>>>>>> Except for:
>>>>>>
>>>>>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>>>>>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
>>>>>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
>>>>>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>>>>>>
>>>>>> which breaks all ia64 builds.
>>>>>>
>>>>>> Time to retire that architecture yet ? No one but me seems to even
>>>>>> build test it.
>>>>> Including 0-day it seems.  This had been in linux-next for several weeks.
>>>>>
>>>>> Michal, can you have a look at this please?
>>>> Hi,
>>>> I'll take a look and get back to you with a fix,
>>> Actually, if I'm not mistaken, the attached patch should be sufficient.
>> Exactly, adding this empty stub will make sure there is no linker error, this function
>> is relevant only for x86 anyway.
>>
>> If ia64 support for 0-day was turned off then I think it was rather recently, cause I've
>> seen it working I think back in May.
>>
>> To be honest I'm not sure what is being done in such cases ? Will you send a fix to Linus
>> directly, or should I prepare a patch and sent in on the list ??
> I'll add a changelog to the fix, post it and merge it directly, so you
> don't need to do anything (other than ACKing the fix if you will).

OK, thanks !

For the fix:
Acked-by: Michal Wilczynski <michal.wilczynski@intel.com>


