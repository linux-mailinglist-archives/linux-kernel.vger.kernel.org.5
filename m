Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759B87FB7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjK1K3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjK1K2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:28:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3219A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701167156; x=1732703156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LGPeg9O57OfCTPqJhUi8UTBafgJzPM0BNyHdnV6/HDw=;
  b=H8fspH6BFl1nyjyamoXT0IKz6i7+Hh4o9c5fOro1jM2GftOVfxITSuJ0
   bJp5o++HRuqwNVsKToSXfgKak17PK/JlBUkSz4gsQoQNRcf9PBOlDGGg9
   QsufER7GLFYlqx07FYvvZbN6ltyDUL+TESQyICngr9wTho5GlJ1y7hhVz
   MlpoJR+fMTc2459yxqgVaKTSNQu8dsrvUJL2SVOgGA0CJnlOJqaL6f3X3
   T9cJ8FEMnzPZU5vbQ2vLSnN+lVMvsfgNgWbXZxqJEv3s3m5jzrZ9MQ0gJ
   XgFT9C25tLfjMwmJnfdqQEfzOT/4Dvk3We0uXYu2H6kAtMra7Fp5wyZrL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395712391"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="395712391"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="16580595"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 02:25:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 02:25:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 02:25:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 02:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nluUYdVyP0c11q/JtKcTRBU3QBjwfNW0yk49LmBE+0P6TCRCAx++0S3WC+AJdCgbUImO82PICmESU9R9ylWr5mJvs8wh0Ej2IRYC3Vd3/TTNhOjKNpLRGpnGp2whaZOf/ePwr0u3qVa4WiHDwAJlzn5J7zeIjgkTICSzk8uwODL0NiNN8H5vH3OTpS/ZRzhEZ5ZdPXWDjxfi8ZTBnaoHJDEh+yKFEsSvyofcku4nnGEueciuLDRaMQkz0kOMoy00L9Jarfh3s1YOMaLhS6I4ueG/XYdCRZ4h32n0piFp56H/30gQs9dEjv14S9B9NV2wqLeO+HDOb2E0Q0bpqcIy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6hfa1awme9FXdynSUyi0iLe38R5WLl3DnvJDrZt+Y0=;
 b=fTgCAchi3OKFmSRdhgEa+9DMgdtQOdGGrDGrbUlZBO1cuusM0TyXckZHyzRWEC85PQbQ4hnymKQaGUcSl51q7K0d/aIWpPce29my2SJWYX2uMQX5aNDwdqw5UYzX2OOf+PqIOM8r6e8BYdT5REq6pQ3EH5nqaT51oj/Fpb1aL6oIK86hRhhSjULheZ12z2jt83We+Bi7daPdN/U40XsglXwMXdlVo7zb1TrYFKRjy3cP6yszDSEPxE5b2QvQCLDnf1gmtqdEBZUI+++En+5qKTVOImI/FC3hg6CtcS2tBEDaMZjW7rKGjW898K3IkwgCxn7GBXL9Wd96ZKnXaNj0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 10:25:19 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 10:25:19 +0000
Message-ID: <812f7729-1e48-bdcf-18be-c94c57f5e5f2@intel.com>
Date:   Tue, 28 Nov 2023 11:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] checkpatch: don't complain on _Static_assert and _Generic
 use
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20231127151847.52945-1-przemyslaw.kitszel@intel.com>
 <bfe9cc37ea78bd7833d22e5859495929cc896fa3.camel@perches.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <bfe9cc37ea78bd7833d22e5859495929cc896fa3.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA3PR11MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: eaabe343-990f-4bb2-507d-08dbeffc51c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FBZO09ZQKvqkKNrHzkZDwBXwTuAXnX8VrWPGT7gymCxm6lnofmaN7RAQs2GXkdULQZH1gIKMvOkfaSpn+vANdURdBhzQ+Oi+FScjNq9eIIcw9cFgQpw5/BziBeIUUrLyzDM0t6VOIGKG4S76BnNvQCmT3qqe+6alAIIagTRfYvpaK/5Hb40V8vxg4TS7fe+s2DicXg1hsKbTNr6OceqAEkmje635yWqXauJyTrW7klWcYIDzw9YrwcEi/ClcJNOT7V4dcZv68+/rKxgUElgQbignZaR6WHMCSF7PLXkDA1IqycoQi+9GTniA/goeP0DRGAw0Lf1K/QO1fzE72JxHsxxpC3wfcMxRa5IxdO1ih6K/C1oo5n2q4uPNV9990lDT0DveqK825v4mqgwK/UFbCd9/NRy/TUvFrfdY6w2CJBnl/FBsVvrFvad/5+Dmzv7gtQk0jjOATgdNWXrwMCidXf/Psh/4gKKY7DnjcigsGbw8jirwFARmowLx2tSwCEWjiKOJfptybeXznyZD9tpe5B+Jt7Azn1oJAic1mdC3auksyMy0rjXVhb3b9uvAUWhWvKzWZw0HutHJ8/1oO1cM80/0aZimRCOAwIdOZ3V0oLcJkjI2e+m2I5XiYeJqei6kxG98tHVFACwO8TKCH2hxAWYNxpgXoIbQiU/eIkOR4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(36756003)(4001150100001)(31686004)(4744005)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(66476007)(6512007)(53546011)(6506007)(8936002)(31696002)(6666004)(8676002)(4326008)(6486002)(478600001)(66556008)(110136005)(54906003)(66946007)(316002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnQ2SWwxVTkxdmFkNVBSTmFsdWNRWTVhczh5cERtcENVdThxUDF3TmVvYmNj?=
 =?utf-8?B?NlJJcGtDRFVaOVE1RU0ydDdQT052dytNQVJoWmhEVjU0VHFJYVRzZFRTNm5O?=
 =?utf-8?B?SmdjRkFWRU5xakk1OEQ3ZEdZejNCSklYcUpRWGV4OHdMalk3ZHpIVTVVMi8r?=
 =?utf-8?B?MTBBbnR5TFRLQmRNR3ZFK2VOUUNUVW9RYzY5dVFwR1FsOFdrbUVvQmZDWmw1?=
 =?utf-8?B?bVBhU0R3MzR0ZHhYT0hIY3RUYU44Yld1VkJ4UTZkM1BGSCtjenE1ZUtkTHVz?=
 =?utf-8?B?STl4c1NROXBtMHRNbUdqZ0RoRVVjMjllcmwxM2ZBemx1ckpBM3d1Y0NHR09a?=
 =?utf-8?B?RmNyREN3V0I4dDcxU3NkTjg4QU9hbFZrU1BGODlybFdPVllQdWpROFFpWUIx?=
 =?utf-8?B?blpTUlJScnpjeEFkejhMSnVtWHlua3hIWmQ4a2N0RUlvMEpFU1I4WDUvMllh?=
 =?utf-8?B?WVYwdkM5NFo4NTQ4ZnJUd1g5SC9DZUt3anRUdThHL2w2bnBhZjZEallMWkYr?=
 =?utf-8?B?N0VTaWFHdVJ1U1NkMkE1a3RKSGdaMmJBdG5sNXJTQkRyS1RiZXpBN0pGQ0N4?=
 =?utf-8?B?WWswR2dNUjFMQkh2UDlhbXhjUklpVGVnQXkwL1B1VndrWFQ3b0lhV01xdTdj?=
 =?utf-8?B?TlJPNW13b3JiZlV1NlhtL0FzaElvRGtYZXhyK3RKbkl2MHdPNHA5R011RUEw?=
 =?utf-8?B?Mm9GWEZnSnMycEI1Um03a3l4dzk2RWN6MjdvQjdBMUN1VUV5WHQ5K3V4bEVB?=
 =?utf-8?B?NzdKc2Q1UFZ2VkFwUEY5VGpoZjNLdnlKTmcxNy9TUmQxYkpycXBOT0N0YVZQ?=
 =?utf-8?B?VGFndnEzbFZaeDhpREpkU1lDckZBb2lpZk52VTErWEZHSFR3TWwraXRsR2JK?=
 =?utf-8?B?Ump4Yng0WWV6UE43aWpCYUVjYUd4S3FLakxBcEFPSVNXRS80TXNIWW1wTmZ5?=
 =?utf-8?B?WEd3RXROVDZCbDNHY1BNdGdmTXBxdnN3MlovWVhKaFhraUJoSjRvbHNnbHYv?=
 =?utf-8?B?WGE4Z3NrY09SK1hKYkdXSzlHSGJJdGJVeU5hRlRwMlExWWdYYTZEVm92WWJP?=
 =?utf-8?B?U1l2dlFkVmkwNkt3MzlIOGcyNytOMXYxeEFYcWgzeHVTUTNSRTdtS2d1K3FV?=
 =?utf-8?B?NmZ6aUpPb1ZZMzNxcTF4TjRTTEJES0Z2cHpsTU5qK1lyV1AvT3Y5eGdoT0Vw?=
 =?utf-8?B?R09uVFZub2RkZm9nRC9oUjRudGFpVDJ3MXhtN1NaVyt3WWEycHZmM0Yyazl5?=
 =?utf-8?B?cDMwUXdCb3NNTElWYlo3MmNab1d2Z1ViS2hBMTZBa25uMUhQQ0FzM2FScVcz?=
 =?utf-8?B?TFZXRUM2akRKNExHVkVEc3E3MVErUk83UFdYSTZlOElKdTU3QWRxc0V0ODlZ?=
 =?utf-8?B?Y0E5aWozWEJqcEw5d2ZZclM0cGIzTndUMGQweFEyeWdTd0p1ZTY3T2FDYWMw?=
 =?utf-8?B?WWtLbk1KVzZqNUVzK3FtUFQyQXd0TW5DQ3pMNVE1c2hXVE9zdWI1L2RCU3RL?=
 =?utf-8?B?VHZyQ25VWHJDb01yamFVQ3pqVVNHbGl2Z2V4ZEVaM3Y5cnNvZ2ZQbDZaYjZG?=
 =?utf-8?B?T05aZmpCUjNuU2lidnVuQ0JlMHV6RGxNNDY4NXkzbTE0QmdtZ1FYT2QyVTg3?=
 =?utf-8?B?YWdFdmgvVmZhWEI5WFJ2bGhUMmpJb3RYcWJta3FoOHBvM21SNEwxZzBSL05V?=
 =?utf-8?B?MVF4c0FVTC9IR1p4ZStxZlp2VFo0dUdnMnRud1V2M0JiaG5aK2IrUHc1aVpX?=
 =?utf-8?B?NEVOc214c3J0NVA4ZjcyZnEvS2xNNTNsZHk0azVxUXBEVmRxcVU2VkJWeVQv?=
 =?utf-8?B?bHBrQzgvVVlrOXZ1dWV5d1d1dTZnemRFazFFSnVkblJma2ZoMkp0VU4rSktY?=
 =?utf-8?B?enBHaTQ4VHo4RGViSHR2ZVZ6UVFzeEJQMEkzWGVoRFRoZzBURkVabEhxR29r?=
 =?utf-8?B?R1BBZ0VnMlhGMmlHM1lucWdlTVZXS0JkMit4cDZJV0d1SXZKdVZwV25YNndD?=
 =?utf-8?B?VStGdTBnelpnUWJyNUIzUUk2SUpDRmJTc0ZWYkoxclZQb0wzc3BZSG9zUUho?=
 =?utf-8?B?cnJrbmNjVkp2VTVVZDVXZzFacXhXUVV2RVAvR3BsNEE0SjR5dndxZVZZMnhX?=
 =?utf-8?B?VmJrN0NNajFaNFprc3JzVFVJVTcrQjVqTUhmb0tQVmNYMWltcmNwZzg3ZjIv?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaabe343-990f-4bb2-507d-08dbeffc51c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 10:25:18.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc3NKazacvQUGjnZSRXwwNJl/Jv8kCIPhbFP589LmGSvQf5U19TJObShsftYwzNv1KBMtDeZF517kUUzBoz3fAWcvxCvSM2xJOZp53Jjn3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 01:46, Joe Perches wrote:
> On Mon, 2023-11-27 at 16:18 +0100, Przemek Kitszel wrote:
>> Improve CamelCase recognition logic to avoid reporting on _Static_assert()
>> and _Generic() use.
>>
>> Other C keywords, such as _Bool, are intentionally omitted, as those
>> should be rather avoided in new source code.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -5839,6 +5839,8 @@ sub process {
>>   #CamelCase
>>   			if ($var !~ /^$Constant$/ &&
>>   			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
>> +#Ignore C keywords
>> +			    $var !~ /_Static_assert|_Generic/ &&
> 
> You'll need
> 
> 			    $var != /^(?:_Static_assert|_Generic)$/ &&
> 
> to avoid words that contain either

you are correct, thanks

also good to use non-capturing group :)

I will resend after usual 24h

> 
> 
>>   #Ignore some autogenerated defines and enum values
>>   			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
>>   #Ignore Page<foo> variants
> 

