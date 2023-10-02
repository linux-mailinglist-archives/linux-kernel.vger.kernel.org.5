Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41BD7B5D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjJBW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJBW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:57:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B4AD;
        Mon,  2 Oct 2023 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287427; x=1727823427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0RIKQuF7zLm/AOZlkjtaA5vzcF6jcyyV2q248S/XCwQ=;
  b=jqdxY3J9OYd9dHzpU1JwBHj1vyELcnW82tKBvi00y1wiL66aycAaBBj0
   5V6qXfrsDHbq2Bnlb3159VHS72cJfUOGFyAA94gggAAeUdSnwje71yuVb
   sGDCjQfid11ZcI5x1vOi+GKVJwlyVe0Wdtr8ImSPScDyWjz2i9X8oPs3Q
   yojPq7UNdcKZg41dlfRCXg7bWCHZI4ixriUT4wlbOr+YX2qQ36OG2FbDh
   /Aik8FB2YnaP8umLmayc4H51kpNfaZjKyaLcmxZFdl95hHmkPIrkGgZHr
   bfyshJy4jwLsVKHzpWVyje75YXul/mXptayXhTLmEFe5W2IGARjxBuRYR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362125147"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362125147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744288095"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744288095"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 15:57:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 15:57:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 15:57:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 15:57:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 15:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDew9dw0ZqwzhmQf+Pmp5T27UDUMAnywmPY0Rns1dTsEIWZX+eKXaDfVxykNHAb6hXBMBgYspKZr9U+vOefyoowIKajAKeeY4OKkFheDYAyV7StcqOWqprDAjwdwK3Y0aKiibZnFlKtOs4IuQKPAlsObeOOoXwGxMwOJiT5eO2Y5INZLCuVw77mvsFA/CjS0yhYY+g7gA8GaBqRoTwscnY3S7S/aeQR1CjtIUm4a6H3B0EzFw/VC1YVpM2JcbgcTUxEXJyAVq/F4zQSDXXNia39oP/Fmi+MjNT7r2+oERCpt+4YY12DZ8t3upJVq1jRPSTbUL0IracgoCXzO2CL3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwxY/Lpgi/qEbLQ1+/lc1L3WmmHc7DyHU7qmA9ebbWg=;
 b=kGUcltSDomgF6G3JyIS4AgGIVM/FVWDI9HtM9QnwXtpCVXf/nC8MBnPpIiz4+zFJ5pyyomImOnDO8/A0wOhpVYMAGZrT221ujgELLvYhJ2tDdylqLmeMSI20zMto+SBu9RfN2HENTLImPfdX1QdUDKGdlwNsfPdWwROZChQOl1qtdChUuDTR66DcqCS3VqYpV1f8/bbXqmMe0MfED1niVpOm3BleLgL+WVbw2GYTyxgDNd9ysLuAjXl1tJjJrxoGGrnc8NPB2BC7JZjXeKA+CfCI3jcsXqZy3/4MDDSAxT5AyATWRnWGOhFiK6ZF7LgCYBgdUwD4xAxct7P0YznWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Mon, 2 Oct 2023 22:57:04 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 22:57:03 +0000
Message-ID: <62fc008d-ac84-8df8-e379-a6fc9b992d2e@intel.com>
Date:   Mon, 2 Oct 2023 15:56:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/9] platform/x86/intel/ifs: Validate image size
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
 <20230929202436.2850388-6-jithu.joseph@intel.com>
 <f5a560b6-3410-f4bd-479c-c9ebec7fdc63@linux.intel.com>
 <b3ae7831-9634-ee63-c0a9-baad59b6fabf@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <b3ae7831-9634-ee63-c0a9-baad59b6fabf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM8PR11MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b370cf7-4487-4677-7493-08dbc39ae4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0KEvqTZJHJDAL+ZSESdZKWvDa6zePTzDgMzd9/pI1oYBsgSR2y/W6Rmpf7r+c1clNwkQJ59BfjltWufAIp1y+i+V3YafZ3t9d2MdRIU2JWPyy/sgSNnZbKNraEL+ShateLEradg8sBOJhIn5QKxrsDhqz1RsoCi+Y9BKz1EjX6zEGiOsY76LPQds9MM21MdWDCY974YH99K3y+9OW9srT+rXc6MLH3kM85XBQ+zQHjy71UNN+y2ov/E7uModNmvspxg2ERNMriO1B58SKyO4CfLc5/sUUmbmZ+gnOZB+XdJycYDCbl26j4SEa+b4dxxYKTzCbMwDG85AbDWpVx3rYngVWnpKhrexdOsv9stAnNcepXYRUDfPZvBGdTa5Pihd2QE48xgO85uDGbL9xyMtQSQF9hUlDbnW3swx0dNn7drb2qDojkobrpU+CYgCDF8oOSsKfLLc/ya6o0NaAZFaYf+Mkhg9IxquOVMY064kNWilEt88fHRR8pJjeAHK/BCefTz3SRdVVUhm+px8vbx2ZfKz+GLtRPtoUUWJUA7SQpBj8uDf8x517CIjMEEhlj5wMCO7RgqPQbC/a6cPk7bJ+APZwQH/oFhuD8kxxnoBQuaLCqZuRAkTRrzFUotjzrp0bFqTW6coDt3IFDZRUwVEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2906002)(4744005)(7416002)(82960400001)(6512007)(53546011)(6486002)(66556008)(66476007)(478600001)(66946007)(54906003)(6666004)(66574015)(6506007)(4326008)(5660300002)(8936002)(41300700001)(8676002)(2616005)(316002)(6916009)(26005)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGYvcW9QUmNldHB2TjFVWUFuVUZsTFMwQi9QN1o2dXUxMzY3OTZyQ2lXMzBk?=
 =?utf-8?B?VFI2SW5Vbms5YXdlaHhqWmZpUWZCZ1JqOWEzdUVkMjhhQjlqNlZsTEVRcHE1?=
 =?utf-8?B?b2lnNkxwTnNwalBBQW1mYnRBZXFTaDUvZHVRL2VSQ0lrdC9xL09kaVRPMlZm?=
 =?utf-8?B?cGs0ZHpKbENmalovT3Z5RDhWbDJOd3BTV2xBNHl6ZG1ONHJNVXRIcEVXVkxR?=
 =?utf-8?B?NEtYbnhuMVgzODRKYU5BaEZrWE9ad3U4QnBhYXdaOWtBZHBZR0pIbXJJS2FS?=
 =?utf-8?B?cTFFUm9IWG93STJpSUVxRzZTVDhtR25VR1NKSy8rSDZ4ZjVqcStFWW80UUtw?=
 =?utf-8?B?NllDVm5WcVMxUkt1YVU1Y0NodHZBQXhqSW9SZ0txTCt1dGt3LzA3bndrQmxK?=
 =?utf-8?B?NkxQSzg3WTRkU0FrS3ZRVUl3U3h0b09ocG5NOVJZeThVL0pySnRqZzNqLy9E?=
 =?utf-8?B?a0NrbXpQOFVkcWNEbTBqZzdXL1JPdnd2UVJUVm9IQnFFRWtzMlJONXREeTdt?=
 =?utf-8?B?THRVUlVZaENRSlh2U0M5QS9BNGxkdFJPb1dPUGE3bFVZZ3JWUEExR0hFQ3lT?=
 =?utf-8?B?eGcrbzhPZ045NEd0NGE0S2hDc0VkQ2piY0FvMHpMMkw5aDdjUThQREFTb0ox?=
 =?utf-8?B?M3Bwb21GNFdKLy81UVVNaWV2RjBpYmtRWVo0KzdEZ2FyRGVrdkZZVDd5NDVu?=
 =?utf-8?B?V0N3T1BhK05iZ1VqSHRwUXl4MWk0WTdrb2thRWxTaW1NRS9sNUhKK0Y5L1pu?=
 =?utf-8?B?NERKU3VTVXhJeWw2RWM0TmJEaHlWNnJmcEZ6WUVuOGFIbmpYSUg2dTBmbVFT?=
 =?utf-8?B?UE1ZOWt1Ulgwby94SVBaaWo3K0VFN2J6RTFHK1VRT05QWmNKQnBMZFFYTjFF?=
 =?utf-8?B?UnlnSnNpZmgyT2cxMEUybC84Q25ETEFXU09RZDdUc3ZLdEZvelBRbHY4Q3px?=
 =?utf-8?B?SGZGK2l5VUJrTzdBZnY0L3JhbHlBN0YyOWdjMjFicUNzTUdkWVNUYmdEc3Fw?=
 =?utf-8?B?Rk02ckVWWHREV3dyaDUxQXVPYXc2YVJpT3owVW1pUU9uTldLYjZ1VXFrQ3Ax?=
 =?utf-8?B?ckoybFNRT0dmNmpsOWw0eFlRT1M5eU02dkNtVUVwVWJxT1N2bVBmT3FmQWts?=
 =?utf-8?B?Um5Fd0laaURWYVRBMDNSY1dsMVF2c2NtNzJicGRiYWRzOUhEakhQWlV2OXFV?=
 =?utf-8?B?bVpFN251MzFabWw2OThCUE55bEhUYUp6NmtnZlEySTNQaDR4anVlYzc5ZE93?=
 =?utf-8?B?UmZyTWRhODlnSDg0K2ZyTGdrWVZrRmNtWVZJWmlwSUZweTduOXhsdm5uVEF0?=
 =?utf-8?B?YVhxV0NLUDdOczVHWERjQVBBS09IM0NYdVVvbHMxcitkKzVHMmV3Y2RneDR6?=
 =?utf-8?B?RnlXWU4wN1ZBRGZ5ZXd3cWx6cGtEYnhjTXh0Q0RnZjhHT2ZldmNRNDMvOWVs?=
 =?utf-8?B?eHJiR2VrL1VONTFsL1llZWUrLzNiOThVQWNNWlpPRW5mWHJSWm5OQWRuT0or?=
 =?utf-8?B?N0R6YUFITjg1eFFTOFpYSE1nQjZBVXpWaHlsaXMweEk1Qmk5M3hZSW1UME9o?=
 =?utf-8?B?SXVrYm1DMmxlTCtlRWVjUlpwd25QUENMWWZiUkJZRGI3OW9VN2ErZVNQdWU4?=
 =?utf-8?B?VkZneDlDaWxEMnVIbHFDN2orRVhrREtwUnZEUU00UzRVZm54UmhHVktscnVO?=
 =?utf-8?B?N29EK0s4UGxPbkxGd3ZHK2N6YTFVWnc4ekl2MzJ6Uit6K0hZWW0rcXFZdERo?=
 =?utf-8?B?L3Q0M25GUndjeEE5WFBFZ2VXaXdGdDZwR3Y0dFc5d3Y2WkxTbUpZYWpSeTk4?=
 =?utf-8?B?V1FrKzY2SXRnNmFxckx3dGdSMEZ3TFo0MXhYRFhTR09yazZRWkdWMGkwRFA1?=
 =?utf-8?B?OFp0WHp5OVJkUkRzUTZDU1FGeGFacU42UmNocFVHQ1RMNmJiM1p2N21KTGhS?=
 =?utf-8?B?MXYrcExRSUNxbUNQd2xnWkI1bXRRZkdoQWkxVUJBSEljQ2s4Q1RvcjkzY1Rj?=
 =?utf-8?B?QmZBRHdhWm5GRVEwekFlcnhrRFQ5c0hOc1NzSWdLa3JhWkROMlhnUHhLN08v?=
 =?utf-8?B?SCtnbGk4R2VFU3BJcmxBOVdwQVROSHBOVVVNYlJWMVdib0swSnM2VzZ4V2U3?=
 =?utf-8?B?VVpMc1lUdmpOOE5KMWoxemJNNGo3YWZQNWp0T0xwNFJvQXhzUmhqRDhRck1W?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b370cf7-4487-4677-7493-08dbc39ae4ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 22:57:03.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVcE+S1uaXsj+5jskt90wjoWmIrPRNSrs/KKxA3U7RsxF22zTrCk+MmKGgnn2TS6/mvEuzsLKgGbGsAji/rlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5592
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2023 4:50 AM, Ilpo Järvinen wrote:
> On Mon, 2 Oct 2023, Ilpo Järvinen wrote:

>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Just after sending the rev-by, I realized this also has %d vs unsigned int
> problem, and %ld should be using %zu as fw->size of size_t.
> 
> Feel free to add my rev-by after those two problems have been fixed.
> 

Thanks for the review. I will make this change

Jithu
