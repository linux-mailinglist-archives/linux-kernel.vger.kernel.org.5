Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB17D4BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjJXJQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:16:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D18DF9;
        Tue, 24 Oct 2023 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698138961; x=1729674961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u+Geab/uurTWEVJm1HJQIRNIM0EAwaSJoRpgjoxe2U4=;
  b=B0SX5Ph0YIt/FV/1SXytENOtJPn0LCDlVgH3mVncKcAEkOhaHkjg73QQ
   T/2AnXVE9sYU9ItyyMsmw+v5Kag5pCtkZPL3wfjHmsSfuzEoVPpHGoRRi
   82G++FLaaoiOwdG+CFlOeDsqHZhSQjmW1hiigSH84oyMs8I6N81J+9IbG
   BuUrPL1I2VL1izGeuUTdKSUNw5bTN45szQPWdZqHjX3RZv8Yujjyw5iTD
   50Xwmx39dBZ5ggh+O7qVHSj367eiKjLzN90rB8C7dvbU2L4LwsTj7MKlt
   bqy+3LbCS4EWNN3PqvHnEyxEnkDGNQHhWAm0aYJfR8KIHuYPDcsTZmark
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366362277"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366362277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="762042557"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="762042557"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 02:16:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 02:15:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 02:15:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 02:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKcwDXquInsK9cd3vojnqTUUPS2wIdgmg8VSWpO/JPIqB553cBFKkfwvqlriv/6PvswyyL2+meVnlvamZX5lnzaD29pVCFQnb/l6zCtuDca/qtySq2vL4ZjuIhMRtyH+oe0LJn5+bjq3lr/7DOwpk8YKTzCTUKhTcV4CDqEjszC4JyGpHKJiZb9+qvlGFdKzxfSlc6z//LsPtiisrAOP9lSt05rQe5XuRkZKBvvlHuJ6ndUQmYfTgjnLLX/nxeJi94N2fcJpdYvx36eXHfQu4MXnPS3ntv3cPyYWCVGadp//sTXc5Xor0gVkA3bmERPlKBm+4CsomJVGpuuWFOjA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4EcV5iFFP7FOPl/gGTJGNJp9bB9sBlSZZVSxAyExLM=;
 b=HQ1IVcx/Xy3KrI2SerBV964MWabQ1gMa7Y5BKwfNRxZtHv9tSQVhLthdPCw3NQ8DSA6SV1Ae629PJd1vP3ZXy/gQtlZM9oGG3K1B6nP3x4xd063ew++o4rU6s0KYbFJJmqnREa60zAojMAc6TJym+scwCVIzxYhlvdVXIw4GMq76xkqUfec7FuK6wTrEhJ9xCVihEZELYEiyNPnuqCdkGK1P0tVSqQufLoVf6ih5pJqctGQEoyJApzsxJv1YGKGUxHq4NX9uuxdVvsksQKXnJ73RzkP4rSrydqMzpoIQSEadE4EzhKYjIp/DmjSsd5QXPTL1oSIv7UmsH4viXWGRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 09:15:56 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Tue, 24 Oct 2023
 09:15:56 +0000
Message-ID: <887636af-6be7-f418-bfa4-d85501f2f40c@intel.com>
Date:   Tue, 24 Oct 2023 11:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and their
 sign-off
To:     Sean Christopherson <seanjc@google.com>
CC:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <workflows@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Mateusz Polchlopek" <mateusz.polchlopek@intel.com>
References: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
 <ZTZ9Bk3-NrK_cVDu@google.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZTZ9Bk3-NrK_cVDu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: b0049868-4e6e-42f7-c629-08dbd471d41a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMbgU2H3uRItVMfnIpebagogVdhaOzgFH0gEq/9PPIWJLcyzWbup95Qrp7ZZbCJchcOnxstHmIAsZo+HfvcY415CL0aLu1HONFrQlHGK5Hu1u5H7l3fccLvIWm+mpmA4kSko34/GeQQ6sKP9rY1atoqeD+qvj7h540zkpIlX1tBb5y7HXi9VhA/PqSf/OPVgK2RzTPGV/aCIp6miO1OpO868ATiGavCCHlyNfstBWcR/x6atwVLBxMjIHM4t2+cIU0LnF7oDQcoBNgbQqW7okBgQru3fyesKNDkm0H1Euj5LGng6jpWa9EBl8gn08nrXOprVRb19duEUtyarE2eA+QHAmq4jzrbVEnR4aqurRPcG4waAqm2MKUUX2tyLZ1zG58+1/L+eEWw1cgVMvJjZfb5zx4JJ0pI+Ub6nNKby9kIgkvq1rH6ucf7SZ7LdJvEyWQS7TRl18YLuTG9JpfCTX40JkJiVPgwaZv8/zSExFjTxRibTVZ35r49RC/u1SRe5OnZBSGPW3EXWcFuNk146+/dn05uXSn609FzfpxqsWPUc1xh4cK8T3NIyQRoVVvU+xOhDrrPWx59JfYmrxBA6ghS5WIbPzVeq8v1NRM43HbbcnBGZfVGTsAg8lZRQbr7aMTlEMyExCK9aEwHtlZuLRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(107886003)(6666004)(6506007)(54906003)(6512007)(53546011)(83380400001)(2616005)(2906002)(6486002)(5660300002)(4326008)(8676002)(8936002)(478600001)(41300700001)(316002)(66556008)(6916009)(66476007)(66946007)(82960400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJiUC9Ra0ZieDBOWDY1dzVrZmhQc2pNaTZPWUdUOEVoWDZrMktXODZpaWhy?=
 =?utf-8?B?cmliR0hBVVVrNURUUTFQeGFSUklTbDVVb3MwZHhvdG91OGhvczFtWUZ1ZFdh?=
 =?utf-8?B?aGhXeklISHVXWEV4MGxSMDNVNmQ0UXNpaUlRU2ZZUVp2MkdTcUVucE40c2Nz?=
 =?utf-8?B?VnFnYnNTeWo2MEo0WDFPVWpzcyt1RFliYzU5NUVJY05RSUUxQXNSbzVpeTU2?=
 =?utf-8?B?UlhPRWkvWDBDL3ZxSWZTQi8waExzVDR6SDRHMEh6eUF3aWczb0M0aHMrVnRz?=
 =?utf-8?B?WXpPVG13a0xWVllHckNwSWNGUUNhSHlYc0RWNWRPZHpkTUFIUmVKcCs0Qmdq?=
 =?utf-8?B?M2hkakRpKzhqV2d0dGFSbkRZN0VCTXpyYnNPWTNlQ1lReGNkQTc0RmI3OTlN?=
 =?utf-8?B?cjM3RW5wN3VGK3JnbjhDTEhuU2FnaCs1ZS8veFdKZWRBeW4wR2VXZysyQnNt?=
 =?utf-8?B?VzRqNFE2RERVODhKODl1NzFkM2NJTEY2Z1JheXFqTWR5T1VtK053QVBzM3hO?=
 =?utf-8?B?VEptNUdsSldJOXhJbHpES1JOWnZUTjdiQ0RZY0dDV0daWkNHc05CTDJsNTho?=
 =?utf-8?B?SW5iVlZzeFVDTXQ5TXo5RzY4RytHOTk5MUd5UmtZL2pOUHVweE1VU3Ywa1VF?=
 =?utf-8?B?b3lxNlVtTmlSRW0vS3FrSWxMVE42U0JheGJyYk5LbkNLZ2pQL0o2NmRETkE4?=
 =?utf-8?B?aFl3UjNoZGNKT21ZbTlTZ05HUUk5WDErOFJ0dlBucTY3S2ZZSS9NUHRtWXVx?=
 =?utf-8?B?OUQraDl4UzFRYUVEd0taSGhZQ3lxTXhuN0ovWG1kUkFHa2R5dE9KNzFtOU1q?=
 =?utf-8?B?aUxlVWI5aG15NERqS3dTbnYrNHRsYUNqYkJGSUY0bEF3RjhaZUtFV2tHWFZs?=
 =?utf-8?B?ZzZXbE1GZjZ0RmNLQ05qQkdSb1lreVlzVS95cTlLVVBhalZJRDh0YjFRWUxm?=
 =?utf-8?B?bXZlZmR6TlQvR3psVkV4amo1blRCU3JHOGlyZEJ2NHpvREtvVkJOYW5EK3cr?=
 =?utf-8?B?NklaUXNHWmRTT1drOHNjU1QrNmpJMzNGczBDMytjT3V2ZzJMTjJDV1ZnNml4?=
 =?utf-8?B?eFl6T1NTaWQyTDNRUlNpTnhTM1EyVnF2K3Z1RnNrQ2Q4Z3dpYVkwTlBVRGRy?=
 =?utf-8?B?SzlOUTBkQldRS05DMlNVb1hBMzhtRW9DYVZ2czVYRGM2RzFQazEzMDBNQ0Nk?=
 =?utf-8?B?a1FjL2dhMW95U3YwQkdkdmo0NUhCd1NMUE1EY1lTM002MS85cTR4MFVFUXF5?=
 =?utf-8?B?Zms3RnhOMUtCUWN2UnZVVkRRWVMweHk3VFcrOTR4TXBqYmlBQVFlZEtCZXpB?=
 =?utf-8?B?SnNaSlVHTDFQdytKNW9GVzJGYXlmanlveEMwYlYyK1lkNzRwSTlrRXc2UVZS?=
 =?utf-8?B?bEVjNHhCRjlaWWhIN2R2L0JIQ2MxTDk3SFFKSGpMazkzalF0ejJuN2xCVExv?=
 =?utf-8?B?QnFxeDIyeEJNQU1IWkhqd2JJUU1aQ081R2xjU3Y4Q1ZPTGtVbkQvNG54b1N1?=
 =?utf-8?B?R0pNdGRNVXlhV1NHM3RWdU15emFaby9yL21SdkcwZmtIU2YraVFzSFdTZlFE?=
 =?utf-8?B?eHVWSDd6cHdvWHNNOHBXTlJOTTJNVktQRGFrRU1pLzhmYk5XNVc1UE5GMlZa?=
 =?utf-8?B?NlV2dXpBOE9BRVRDcXpMN3Y3dWs4aVIrUllPb1pxL0dZZVZVdUsvOFlJUEFC?=
 =?utf-8?B?NnljajhOc0lkT1VtckM4d3dVb1pxZjVmcTVoK2NkTlBwdlRNeXBRT3VLNzFx?=
 =?utf-8?B?R1Q3WXVSaE15RXMwam1OUE5zR3g2UHV4c2RMcG8zOHI4Q3ZRYnhpbDQ5NWdE?=
 =?utf-8?B?QWp0OWpRUGVRUHpuTlQ3dEZmWXRqaS83WDMvZkVUci9rRHBIOW1mN014ZnZE?=
 =?utf-8?B?dExPcVpBSGErTld5eWg0SzlJZXNJVGMvMFc0eTJOQ1hsWUFZaTU2eUUwb3Nh?=
 =?utf-8?B?UGkxVExSbmV4aHd0QW1Kekk1VE1ZZGhRdk01M3QxMnVvN1BIaEFnRkV0cnA1?=
 =?utf-8?B?N0pMZmcvK3luMWtKYk51ZnJVNDUxeFhqSCsrVGV2ajJXd1ZyRm1ML3lhbDdu?=
 =?utf-8?B?MlFDRXdUb2JLZytMaXRqeEFHOFhueTVNYXIwSVU4V2UyNkFhRUFXcGNEQUdN?=
 =?utf-8?B?cTVhZWNmMjBaWlBFdGU0VUlpaFhpVXF2Ujd6Q1hYeE1xUUlVeWFTa0NwOUpi?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0049868-4e6e-42f7-c629-08dbd471d41a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 09:15:55.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gOB15IH9HL7faxfmgdg9w1GuUO1LfpOyG4fcWqWHpOUoKD7GeiiUWWdTKAGYo9Q0lyO9PR2jFq01yDjS1jrmZK3xVXgNtOIPm+CUZaU+3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 16:02, Sean Christopherson wrote:
> +Mateusz
> 
> On Mon, Oct 23, 2023, Przemek Kitszel wrote:
>> Additional tags between Co-developed-by and corresponding Signed-off-by
>> could include Reviewed-by tags collected by Submitter, which is also
>> a Co-developer, but should sign-off at the very end of tags provided by
>> the Submitter.
> 
> ...
> 
>> Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.
> 
> Heh, there's a tag for that...
> 
>    Reported-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> And it's usually a good idea to Cc the reporter in case there are questions they
> can help answer.

Heh ;) then I would get a checkpatch warning for not providing Link: to
the report, somehow I wanted to avoid those for checkpatch contrib :)

> 
>> @@ -509,16 +509,18 @@ Example of a patch submitted by the From: author::
>>   	Signed-off-by: Second Co-Author <second@coauthor.example.org>
>>   	Signed-off-by: From Author <from@author.example.org>
>>   
>> -Example of a patch submitted by a Co-developed-by: author::
>> +Example of a patch submitted by a Co-developed-by: author, who also collected
>> +a Reviewed-by: tag posted for earlier version::
>>   
>>   	From: From Author <from@author.example.org>
>>   
>>   	<changelog>
>>   
>>   	Co-developed-by: Random Co-Author <random@coauthor.example.org>
>>   	Signed-off-by: Random Co-Author <random@coauthor.example.org>
>>   	Signed-off-by: From Author <from@author.example.org>
>>   	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
>> +	Reviewed-by: Some Reviewer <srev@another.example.org>
>>   	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
> 
> This is silly.  Allowing tags in-between Co-developed-by with Signed-off-by
> unnecessarily complicates things, e.g. people already miss/forget the rule about
> tightly coupling Co-developed-by with Signed-off-by.

Meh, I see that as a pure process simplification with proposed rule
being almost the same as the current one, thus as easy to remember or
forget.

> 
> And if we're being super pedantic about chronological history, arguably the
> Reviewed-by should come before the Co-developed-by as adding the Reviewed-by is
> a (trivial) modification to the patch that was done by the submitter.

Tagging patches is not considered co-development by most people.
