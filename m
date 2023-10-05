Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE47BA9A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjJES7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjJES7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:59:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2190;
        Thu,  5 Oct 2023 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696532341; x=1728068341;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wMWd0cwFLEo30xwau5dYIiwNMNTk97+CvSpCYirtMpI=;
  b=R5vdPECUyF4XGkxE+IqviTnrvb02Yyy+4apBRJklD1IjlstmLVNZCCrv
   2PY6tjd6yiP6dDI3ut2vmCLdzCc3IySPdSl/lmH8FRjb7DMLGp6GwhFLy
   xVW67Zm2pxaC6A5Yf0P27EESCxi+Kw0iM50Ybdx5HmjhXiEk0qoUIif4s
   kU7BtXB38jVrS1lRiurflxgx67cuNPHYabltyjhPG1OmoZpHGL7EglrBq
   z9mTr3202s3JUrAZ710ih18CCU1ooHygpGhNIHGtwiMsP3OP4uR4bCzUg
   3xsS/quw4349UbobIAyO/quOS8AloVtyuIFM8j1fu0Ugh6leqmIUY76id
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447777325"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447777325"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817722315"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817722315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:59:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:59:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:59:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6XThjcgmF1UqyJY6X5lX30x76rM9pHz5l9V1RB8Z8Rq1nZRXu2E5fybXSGF4XUtapEogsKfJONCJaF1AdqZLSJFR57aTJS49HHHNb/NsQUGdnhXRpn4WD6ZDqbFpygJqUuYhKU1F3Oh/IjA2LHTmSYHtKn4EWnmv/sultwoL8wIS23BO9AGv7AtxGpohrjnU9ze7aX54bb6OfGEHYfji7DHmPlUHc9wotEV9KRKf7YQnD8TQPIly8dwbhHxkgSM/hqPUuA6mS8IXKhyYrd5Qhosw/53RyGVszgRUGYR6bB8nEXbVBkQqh02DS9HMQ+OV754+jVwsowWf6Qqp7ekuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9mGXfEvlom+nisomcioQyRp6nnkzO4ODEfnNaRHkEY=;
 b=erpiZTVrz92x593PeZsmg08uB5Bmfek8sTvovufHuSMdNAwUqIocZNxVkI1nPGkNe0YQK8WmqbHsOMH+jqPsOVtlBLdSrToSQKDukSsKDxgTSvh9VbJlHTu5wAJj8yEZ+F0EJMx37m0f70fZizxjgj0NMQApPQxxnnINYeUpQuDby54K0wyUYReoZr45I98b/Qg84Vpm5lvTwTU8kxmTtuEeC6MgeI17wSZ4mRsBXatg0Wx2Md3O/82yk1BoWGuoZ2D3F/+IFtQneHEN9JooCrZ+XXYd/LVFtLAudzIxJacDoEP4yUhon2YBmeUj4l6oOw+PrR2SMKvgfMFPzF215w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 18:58:58 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:58:58 +0000
Message-ID: <04972447-91b5-4392-acf0-c942e02403c2@intel.com>
Date:   Thu, 5 Oct 2023 20:58:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus
 concepts
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, Elena Reshetova <elena.reshetova@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-3-michal.wilczynski@intel.com>
 <2725050.mvXUDI8C0e@kreacher>
 <edb1d4bc-a484-42ea-9a5c-4c77a860645a@intel.com>
In-Reply-To: <edb1d4bc-a484-42ea-9a5c-4c77a860645a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a056a8d-25a6-42c3-ecff-08dbc5d52116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBFL3UPClDzak+Ie4Cq6L9qXqKR20648t1NhybTqmAPdjYSWd+7yJPIubDYtI1QdWM5Z65IxERMGtsG2ISDGLMz1OFKmsvVjVvcDL7vTLAu+ZCP6Onh3zjRZYceYe/y9/m30ML+HGdoOaTlkN/eA8iZKjMqUhFNPBEnZYbpWNPjfyI9RGuaZbImOsclc+WBIRL6TwW2MPJgpIT8smYARpPH5lMZkdFGvHuTRs/XT8AxxUNs2d+/4TMO9RbM+8bU7PObQQ3EHQgxWWDWSJZNY1XZwIk+uWrT5YOc+d74Oy5EKTNDQpwE6T2bDfDa7aOTaR0VGUA5eisSWOC5j2aED0sLSXAF7bS+CPuBUg3QK9q4sYBJWGdXsIVpkU6/EzRMTwqKdFudEA71OWV2rrxr4COfxTddnMgfl6BSXLtZo5tIiVGtMfLKcl0mueelVvswnbPXmKtUw35gKFbOYfJjpHq1leX2uS2gqa3vBzW8yzP5tQxzI9FoedgYgPK1xNcOBvzXmJ2el5+c4m42cNeBchY4Kc0ADGF383x4N9C9XaJCZNMW1yCTZ74m0dR53o5F6j/zLWqlp6Hh8OBsVfZbl2R/GFpCXhU1CjUyHKegY1s1y8peSx8CpoI/Wp/jvi8sJg7oQ8uB3nDpSdxmOeYzfHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(31686004)(84970400001)(8936002)(8676002)(4326008)(5660300002)(41300700001)(66946007)(316002)(2616005)(66556008)(66476007)(26005)(36756003)(6506007)(6666004)(107886003)(53546011)(6512007)(82960400001)(83380400001)(86362001)(31696002)(6486002)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlKaEJBRlc1YVdVbEdHQjMydzJSZnJTM0lrNDU0dFlkaVlyRXkxTjNEbi9H?=
 =?utf-8?B?NjFHTFliSTJ5eHlIT2FkbkFDK3g3MTBUaHVua2hrQlY4OEppUEJBM3JUbXVY?=
 =?utf-8?B?TVNMdEN2S2JGOFRWWGt0TUM2eklybVRwSGY1OVVmOTdxTk14RjUxZGVraW84?=
 =?utf-8?B?QnJhQnY3NUQ4eTFOakhWSGxLcy84OCtYUDVPUVhycFhPcHpaOWdQY2JkL2Qv?=
 =?utf-8?B?NWhiUDJCZVkza1UzUTNzMVN4eWVBNVF4SGZEaFRONTN3NkEreFVLUFI2bTB4?=
 =?utf-8?B?OWxheWpKNlh6TzFQSUNiQ01UQmNLZ0h4enZOZCtSZjl4TWZaeTZKVWRPOVor?=
 =?utf-8?B?dG4yMXA3UHBYbWZmeW5qOGlmOTI4S3JJMkRDbVhNNHRpa1F5eDR1L0FNMEdL?=
 =?utf-8?B?SnVGdys2OUh2bktFb0NpczUrZXNtMitZU2VmS0pKNlRHc3BRbDRvL01iL1Y5?=
 =?utf-8?B?VVZPQllSU2x5L2JGRUNsK1pVRWM2RWIveTd3OFp1b0tORUxQVGJudi9ZRmhq?=
 =?utf-8?B?ZzRHYkVqb2U4TlhxQWJtTFRuczlzMmcva3JLV21vbkRVdGhzcmJBQ3hNUlY2?=
 =?utf-8?B?ZnBVNWF5ZXZhWWZ4ZDA3ZWRZTmgyL2xtRFdtaEI2SW1Rb3dUcTVvY2pCYmhX?=
 =?utf-8?B?Zmx3aElJdDlUM3JraGtSR0I1WGFJTjZackc5Z1U0Tk1yZDJRMXZUVTV6MGNC?=
 =?utf-8?B?NHRsSDA2OUhWUm5zYkx3WnQxWkRyeVI1QU85dDFYMXViZUhRWVBJWUhUTWZI?=
 =?utf-8?B?WTVRRWJocDlqdHNHYUVkRGVnenR2SlA4ZWJSMW1qY0cxZ0gyd3Z0Y05sQlFj?=
 =?utf-8?B?czZZeEhBTFFDcVJMQlBleVc3czd6MWh6ak9JQWdnRG9hVGRiQXlJTzlXTFdO?=
 =?utf-8?B?TVBHNlQxcGJsSVBmSmJkWHZ1anI5N2liVUkwUzZtU3dtTVpQMzYxYkRZRWdr?=
 =?utf-8?B?OTRTbFd6NXlmUjlJK0Z1OEEzcVlUL1FEay9lZ2JUVE5lK2l2c29jTmg2UEt3?=
 =?utf-8?B?ZnFObTQvdHYxZzZPZEdDZEttbENUaGpCVUhQUEE1RHZSN0dpeUVZeENiTW04?=
 =?utf-8?B?SHl5QUJzVnFHcW9FdFpzcXdiYzNDQ1BDWnlYc2NFR1daY2NScmRsbGlLYmFV?=
 =?utf-8?B?WWJIYWppQzdhTXBwRHUrNHJqcVJDbTB3SFBJYm1vbW0wZXZMMkQyU24yRE15?=
 =?utf-8?B?OXVGbW1JZFhCbW9JTHFwYWI2bjVRcTZFanpSbHlNNkQycDJoUmR0czVpNEtv?=
 =?utf-8?B?TjNKelFHQmxMV0E4Q1dqaDVNNFhPaUowZVBxS0FIQU9FMkZDSlFXUVJCUENU?=
 =?utf-8?B?cWhiNlJvV0ZXaGpjdEc0SWpCSkxmSmpLaGlyUUl1VGdLeGU3aDhyU2dFbjNZ?=
 =?utf-8?B?Ymlxc1BpdUZhc0c3MXFiMnRNMnUrdWd2VDlyVXRtcGtuN21FK2crdG1yTUFB?=
 =?utf-8?B?Q2tyNHRnSjVoeVBhb0JkZFlyR1F1d0R0NW00VngvNGdBbGpxdUxJR0JMZ1dX?=
 =?utf-8?B?dHZxMEhuTXRrbThrN2d0S01uY2JFK2tUNzJZaDlSNGorTFlSUDh3ZlBPQkZl?=
 =?utf-8?B?Z1BmL2tQRnFQNnhPelkyUnVJbmw3cjV6S3VBTjAyK09MdUpxWC9mcVlNdUZu?=
 =?utf-8?B?dXVQeWp0U3JhS3RUQlJYemxSdG9xbGpYSjBhdG9CVUwxazJiVWN2OVBuNVVU?=
 =?utf-8?B?eGJOMU5FZlVHU29ud0tVZk44QjNublJuR3FPUzBoTDJZMzFjNk0zNk5saWJC?=
 =?utf-8?B?TjJPS0FvbzNKQjQ5aWMrSEtXL0tpWHRqSGVuMUR1Mko2bG1xejNiNVFydW54?=
 =?utf-8?B?ZGNlWk90K1dPeG52dkQ2TStaeWVsUjhoZmJsdWJ4ODdzc1FQeG80K3dTeU4v?=
 =?utf-8?B?RlhDa0UyRG9lVCtBaW9OaTNrM0poaVEvaXhqR3RwZjBPWENWSjJVSm5RRllQ?=
 =?utf-8?B?THNTYWZZZHNLbUY3L1h0WDI4b1pQZEFkeDI5NFJ3enFUTUUxZW5zUElDNmtE?=
 =?utf-8?B?eEtKb2ZvMzk5S1dlSUFITzl6TUtXVzlGTHlUdVBHaWk1V25XUGRjV3dRNEty?=
 =?utf-8?B?ay9oeVhoK2xROHlldU0xTW52bG9FK0N2L25kbVgzQW5EZ2ZIV3dDeWxwbnZk?=
 =?utf-8?B?NW9NVHJ6OTBNMEs0NWhsM2hqYXNjVk1Yaks4VVZ4dUF3K1NBNU1NRUpyRHZ3?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a056a8d-25a6-42c3-ecff-08dbc5d52116
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:58:57.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuqdFDK3LSC3X79QgiV6PacZCsqj54PYcc/oSB45Zvw0luWzdL8+sIzY+rck5vKTnuyyvFRMkJ5kzJvqBSxlW5uB3AhS0VihtbyJt/vyJCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 8:28 PM, Wilczynski, Michal wrote:
>
> On 10/5/2023 7:57 PM, Rafael J. Wysocki wrote:
>> On Monday, September 25, 2023 4:48:35 PM CEST Michal Wilczynski wrote:
>>> Some devices implement ACPI driver as a way to manage devices
>>> enumerated by the ACPI. This might be confusing as a preferred way to
>>> implement a driver for devices not connected to any bus is a platform
>>> driver, as stated in the documentation. Clarify relationships between
>>> ACPI device, platform device and ACPI entries.
>>>
>>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>> ---
>>>  Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
>>> index 56d9913a3370..f56cc79a9e83 100644
>>> --- a/Documentation/firmware-guide/acpi/enumeration.rst
>>> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
>>> @@ -64,6 +64,19 @@ If the driver needs to perform more complex initialization like getting and
>>>  configuring GPIOs it can get its ACPI handle and extract this information
>>>  from ACPI tables.
>>>  
>>> +ACPI bus
>>> +====================
>>> +
>>> +Historically some devices not connected to any bus were represented as ACPI
>>> +devices, and had to implement ACPI driver. This is not a preferred way for new
>>> +drivers. As explained above devices not connected to any bus should implement
>>> +platform driver. ACPI device would be created during enumeration nonetheless,
>>> +and would be accessible through ACPI_COMPANION() macro, and the ACPI handle would
>>> +be accessible through ACPI_HANDLE() macro. ACPI device is meant to describe
>>> +information related to ACPI entry e.g. handle of the ACPI entry. Think -
>>> +ACPI device interfaces with the FW, and the platform device with the rest of
>>> +the system.
>>> +
>>>  DMA support
>>>  ===========
>> I rewrote the above entirely, so here's a new patch to replace this one:
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH v2 2/9] ACPI: docs: enumeration: Clarify ACPI bus concepts
>>
>> In some cases, ACPI drivers are implemented as a way to manage devices
>> enumerated with the help of the platform firmware through ACPI.
>>
>> This might be confusing, since the preferred way to implement a driver
>> for a device that cannot be enumerated natively, is a platform
>> driver, as stated in the documentation.
>>
>> Clarify relationships between ACPI device objects, platform devices and
>> ACPI Namespace entries.
>>
>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
>> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  Documentation/firmware-guide/acpi/enumeration.rst |   43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> Index: linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
>> ===================================================================
>> --- linux-pm.orig/Documentation/firmware-guide/acpi/enumeration.rst
>> +++ linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
>> @@ -64,6 +64,49 @@ If the driver needs to perform more comp
>>  configuring GPIOs it can get its ACPI handle and extract this information
>>  from ACPI tables.
>>  
>> +ACPI device objects
>> +===================
>> +
>> +Generally speaking, there are two categories of devices in a system in which
>> +ACPI is used as an interface between the platform firmware and the OS: Devices
>> +that can be discovered and enumerated natively, through a protocol defined for
>> +the specific bus that they are on (for example, configuration space in PCI),
>> +without the platform firmware assistance, and devices that need to be described
>> +by the platform firmware so that they can be discovered.  Still, for any device
>> +known to the platform firmware, regardless of which category it falls into,
>> +there can be a corresponding ACPI device object in the ACPI Namespace in which
>> +case the Linux kernel will create a struct acpi_device object based on it for
>> +that device.
>> +
>> +Those struct acpi_device objects are never used for binding drivers to natively
>> +discoverable devices, because they are represented by other types of device
>> +objects (for example, struct pci_dev for PCI devices) that are bound to by
>> +device drivers (the corresponding struct acpi_device object is then used as
>> +an additional source of information on the configuration of the given device).
>> +Moreover, the core ACPI device enumeration code creates struct platform_device
>> +objects for the majority of devices that are discovered and enumerated with the
>> +help of the platform firmware and those platform device objects can be bound to
>> +by platform drivers in direct analogy with the natively enumerable devices
>> +case.  Therefore it is logically inconsistent and so generally invalid to bind
>> +drivers to struct acpi_device objects, including drivers for devices that are
>> +discovered with the help of the platform firmware.
>> +
>> +Historically, ACPI drivers that bound directly to struct acpi_device objects
>> +were implemented for some devices enumerated with the help of the platform
>> +firmware, but this is not recommended for any new drivers.  As explained above,
>> +platform device objects are created for those devices as a rule (with a few
>> +exceptions that are not relevant here) and so platform drivers should be used
>> +for handling them, even though the corresponding ACPI device objects are the
>> +only source of device configuration information in that case.
>> +
>> +For every device having a corresponding struct acpi_device object, the pointer
>> +to it is returned by the ACPI_COMPANION() macro, so it is always possible to
>> +get to the device configuration information stored in the ACPI device object
>> +this way.  Accordingly, struct acpi_device can be regarded as a part of the
>> +interface between the kernel and the ACPI Namespace, whereas device objects of
>> +other types (for example, struct pci_dev or struct platform_device) are used
>> +for interacting with the rest of the system.
>> +
>>  DMA support
>>  ===========
> Thanks a lot !
> Looks very good, will include this in next revision.
>
> Michał

Aww, forgot that you can also just apply it yourself, so I can just fetch and
rebase. Whichever version you prefer is fine with me :-)


>
>>  
>>
>>
>>

