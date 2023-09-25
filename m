Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F28B7ADCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjIYQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjIYQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:12:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA50C0;
        Mon, 25 Sep 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695658338; x=1727194338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hNcMTkZbalvmyhlxzaoAOJMGTLrrhtTxDpDmXiSeMgg=;
  b=DDu6BZAf5xM9CEw9Zk5TMBNIfuoglaat4LI9tpL7dkQiwE4k33qavVqa
   meyu41IT25oqNTka0IamiYEKHcFqJ/5vcmlFd04/x56j8gycBJipmr4T0
   58/Rxkx0+Vz0eN1SxV9E4MWgB5OHtPNNZwpYHxM6jEEpK2q86Ay//cnYi
   eNaEfHA1QCLvXZWFgrWtNGXU7JU4oivaGkMmAMp8ZQVvseF4AqSyGBCUW
   O4CkN9vmuF1rNVVixJMadgTJuE+eE3glZ3POaICAFIUhgvJN0h2lnN9Lz
   aNqFWv2rOTHbw8rkEOlytSRhL84Sr64L7YaG8VZ6Cs8BI4pK1dcFZ7/JJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467577908"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="467577908"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838605487"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="838605487"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 09:08:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:08:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:08:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 09:08:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 09:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFqOhSCZXRmYY3/B06IIUHaaQIFB3twemRBHbC3/VcrT5smbnZpGs5258ezDFRJb8+a30lTUxVADJhIDqu9M4oYsV7FJEuMkH9wbXinvII+2XU9rySrQNyL2hZ+IaZHyRBozGjn3zFVQ3+rIwMv2UrxOvUDyy1k3uC7XjnfKQE4Y9mYCjv21tez3X1oEc0xnkpldpxkP6D9n6ansXEVmVTAmMReJm89QKBTkR92QISYUAQGiOnqrLKK7DMBEmGhiWHlKYtjlfSLNta+tvHnN3CeJtb3DaY8cEUGsx9Xz8L1An1L3VyDt5klOk7RwWg4x6UDmmfs6zak3tYZkOPutVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHJzIb8nWUq36eR3bGuMJb6PSvk3pylx/9p02hDKsXM=;
 b=YwWkbwKbQDpQzNJKophacH76fSqPX2mMNIIDzv5nxqzOLu1AH25yPMMeK2eTV4qBY/Bem0OdyE9pjibPSNvmK7FuDsQZp8U/aW3SG5lBWislFQjqpzS6NtvZcTteOBPv/VygmubC7bV4tT4U86tlzR6wJbNtJlp2pDmMiz1nOx54S+hYWmM6zWaib9mm/TmNh6SDR9Z0v0nFb892BNu4CiPguXF0fPJtN4p8RmN13L/mq+AIup7u9t/sYkLnSUu+CfZit6Lzt41nkzu0vlk6ebeFh9Z7eqkQCGEnGaEwqeaXZh3TwAL4pEmmlgIhuFy/TMGtgD+dkxoDLnmYQJMvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 16:08:36 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 16:08:35 +0000
Message-ID: <89f48b0a-a6b6-2204-7d96-28ebbe96b18a@intel.com>
Date:   Mon, 25 Sep 2023 09:08:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/9] platform/x86/intel/ifs: Gen2 Scan test support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230922232606.1928026-5-jithu.joseph@intel.com>
 <c390bdaf-ab5c-bf1f-bd64-29e2827d01f@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <c390bdaf-ab5c-bf1f-bd64-29e2827d01f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|IA0PR11MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: f76bd38c-8c14-4f3d-f9bf-08dbbde1ac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOKEFatmM5VuVZlEtUCon00XlyvYPXzOiQ6alieuiZtw9HUN5WQHff0MyPw9MUCpqUzuZk9bjNLrolYUfDNYdRWHICUOTGDVVsb8j5KwiBCpkowbV2Jgp/prpaw+M+t1Qtleb51uOznDijZr4Eu/4B1O55lfl4gp5ALQjgORp/nIih3qPJik46m7TM8/rorLPFiLzAr26FJ//T7ZaeJaleTlwfpIwoCe0ErrijoB+7o1NFQHbhzw5p98ZTMb2d65VSGwXP4m8ROPfv36kYpSpac3B3OUb8yK+GpxOvEDXEFmzJvMmUy+r57JuuONSJ1+//FMSA7txjrbImZTCbJkS/6GsdmC+N7FXLvYpgHoyzKGX/7E6GaAhr74+dLN7JYolWoEgAo7x2jJ+0DtMXrzieNo4xzlmLkRAoqDf0AFRB5uMLaXb55xiQkCGNlPMKL22H1UhI7UGtN90vu2gb1esmluMXuf2E19lt8W1v5pmCVCM8PO2FquAgVTSr9AL2+sPR9+20RYG6Ym4R6jp26iP7Uq9G/Yvd+ThYZvPHLoIVOf1ke5drEU6GzUnXnO1upvH1v0pwS6cCzK0p14MAqLWxXKhA8PsW5vBD4vLlvttCHlfWVX4Uro8iNfO5hz7fFGmEwopX381RFUR9oKPKMEHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(6486002)(2906002)(83380400001)(7416002)(82960400001)(38100700002)(6512007)(66946007)(66556008)(66476007)(54906003)(6666004)(26005)(5660300002)(53546011)(66574015)(316002)(41300700001)(6916009)(4326008)(478600001)(8676002)(8936002)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZiN1ZWQlI3WlRSVE1nbE5DN24vTHZreFRuM2ptUnFkRjBybFppcGZ1V25C?=
 =?utf-8?B?TXdMTzl6b2JRL0p5RnhmMXJ2Q0o5RkVsRE5wRTlrMDBtZm5ReUhaVUdqQWhU?=
 =?utf-8?B?S0N3am1ONGx2L2hZNUFYaEZUVndadTAxQzdpQlVOSGZpNHlJaXA1VWxCS1RY?=
 =?utf-8?B?WDFUZTJXUEtoOE1mbjU5TkkxOWJtMkpHR0pqbXVycjdXdzVVSHdOcHlnVzlB?=
 =?utf-8?B?NEtiNzVkV05GU0RrMysraFRTUExidTlNL2hkVFE0UU9TcmJCNTQ3Vk9EMm1V?=
 =?utf-8?B?NnAwVFR3cHNYdnQ5Vmx4bWhXOEtkSTNoQUFXUmxySWxXT0tLZWpwSzBVU0to?=
 =?utf-8?B?VXRIT3dWK2FhcHVFb01meVlyZ3RUOVQ2N2tUNm50bXFUQWx5a01Vc1ZZWUcr?=
 =?utf-8?B?RzlJcU8wT1ovVXVQN3NKRTRjbWhjVXVadlRJVFYxblRUWE1IMCtOcldiYnl1?=
 =?utf-8?B?UXZxWmVZcUt4WHVyT2k0UWtsZ1BBSENkUTY2TXI1OTlOWVlCamtiZ1lQLzNk?=
 =?utf-8?B?QUhPb2NQTlBDMnBOYnY3Tk95SGtKTHB3Zkg4TC95bTBlbUY2WlNzdUhuZytT?=
 =?utf-8?B?T0tIREZDOFhNRVV3aU8yRW1RamdJTG0rR1pQYVZLektlYStFL0NueWI4b3lW?=
 =?utf-8?B?bXRaTWExaVU0UHY3NGErV3dEMzhycllra0NORkR0MDJQR1VJb1A0cHRtTzNC?=
 =?utf-8?B?bGQ5K3B1N2pVTmdkaUlZM0lZZERhcWp6Rmh5Vitic1lkN1pRZWg3Ym5xbXJ0?=
 =?utf-8?B?aitDZHEzWlhGZUFYNjZyUS9QOUlHb2l6ZkZEYXVZK05IczFXRFJWbXcrTzlh?=
 =?utf-8?B?S1Y1M2ZmY1BqaFZHcklMcVNURGk0K01KR3pwNWxJbzdTZ2xnc0R5YnFCcE92?=
 =?utf-8?B?Zmt0MjdZV1RPd1oxR1E2Y0dHMXFKd3RvWEg2RDlWeFdDWHl3bE5wbjM2a1N0?=
 =?utf-8?B?cVAvOFBHOGlMWi9FWmk3VUpzV0FvRStGS3oxL3B6b3UvellPbmRQdmFzWGx5?=
 =?utf-8?B?MXdyS2Nud0ZhVjJOdkJ4V3oyMERzUkprelV3bG8rK0lLOTdBKzV1ajNIOE1H?=
 =?utf-8?B?UXNXZ3B1Y0JiUXZpeVNLb3hkaEVPbHJMeEozQ2VIS3NxeitSQ1JwQzlSdmYz?=
 =?utf-8?B?cU1MeENaQjZUcGpybUtFMWZpQXp1S1RodVFrWHRsaC9rUUFXL1NUbWNNbXRQ?=
 =?utf-8?B?dVBGM2lSMHc5ZXIvbUZqMzJvQnI3WDk5RGErbEhZUkdDRFh3Q0NKVWdZa1BE?=
 =?utf-8?B?RUo2Z0YwQ3BwV1BITVhCd1VKR0ttTlBSRmNaMGV6U2F0K2FjdzdydHA1NHhh?=
 =?utf-8?B?THNkQ2NYQnEvejZ5TXZaQkhLWGVFMTA0ZkFQdjhlR0NoYlRWWTA1VDg3OTZJ?=
 =?utf-8?B?c2dET1J2cjdqTkJDWDZpT3dWbkJES0JBaGplSEkzdXdISmJxL0Fkb2MxOFEv?=
 =?utf-8?B?dU5CREZkMWxWd1loWUtucXBMNmo4dTV5aGJTUUZmWnhMQmQrVTI5UG9GRUl3?=
 =?utf-8?B?ZzBJL1VLS1BzaURMUGJ3MklMK2F6Wnc2amsyMXV4OWJZZ0dZZkcyRlNjOWxI?=
 =?utf-8?B?eE5SdGJZbG5nM0dReXREd2NsTU9zOUh0SC80aU5ycWJXTnZ2QmE3cm5JaVl1?=
 =?utf-8?B?ZUVLUUxaNS9sSTErb0lxYW1saFBwQlNvMCtvUVFlZDVOVjZPMUk1V1djYTdS?=
 =?utf-8?B?ejZTUWdCSDF4YS9JWXVRMmFxbmhhMFc0U1NoUTZod0c4QUhSS1ZHNmhld3lV?=
 =?utf-8?B?cFVpTWxGSFlMbFM5blFjbG1lWk4xOGlMQnlNRVhkaFR4eGtGaHB5SkY5dzB1?=
 =?utf-8?B?eEFvWExPRVRKWEc1SDJ2ZlRFVzRHNTRTVnlFbWl6R2pQaUt2Qm5NRCtZZlU0?=
 =?utf-8?B?ek1iWTA0YXBnZnh2am9lMlplaVZmZ3RFVHVmTk1hZy9tN2V1d2JFZ2cyQlh0?=
 =?utf-8?B?WVkwQ3JGdkh2ck52MnBMU1FSZ0tXYkRJVnN4aTd4WTVNTC9YSUU5WU1vcW9u?=
 =?utf-8?B?S0xBRE1vTzhXLzdjUW85SnR1SjBHbjFyMUE4SktoUzRXUWRJRS90MWRQYm52?=
 =?utf-8?B?MytRWmMvbXBlMGl3WTA0a0ROTWk4L1pZMjh0djM3cDgvMFRwQlNCbDZZdmMr?=
 =?utf-8?B?dzRqRkJjOEVGNmliOWIzbkdrSzZFYlZqMGhnaUduOGVKQ2Mrai9WR2d2YzVR?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f76bd38c-8c14-4f3d-f9bf-08dbbde1ac27
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:08:35.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPHrcXdfVnKrf0+1xMS6AepKqZo9SkmHyOZfjR3kQYVFc1w7KxWasgVu0IE3BTtEWyI3R1CvZVwAp/TZ18BtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 8:39 AM, Ilpo Järvinen wrote:
> On Fri, 22 Sep 2023, Jithu Joseph wrote:
> 

...

>>  
>> -	activate.rsvd = 0;
>>  	activate.delay = IFS_THREAD_WAIT;
>>  	activate.sigmce = 0;
>> -	activate.start = 0;
>> -	activate.stop = ifsd->valid_chunks - 1;
>> +	to_start = 0;
>> +	to_stop = ifsd->valid_chunks - 1;
>> +
>> +	if (ifsd->generation) {
>> +		activate.gen2.start = to_start;
>> +		activate.gen2.stop = to_stop;
>> +	} else {
>> +		activate.gen0.start = to_start;
>> +		activate.gen0.stop = to_stop;
>> +	}
> 
> Is it okay to not do activate.gen0.rsvd = 0 anymore? If you know it is, it 
> would be nice to record that fact into the changelog so that it can be 
> found in the history.

I did test on a gen0 to check if there is a problem due to this (and it seemed fine).
I will make a note in changelog as you suggest

> 
>>  
>>  	timeout = jiffies + HZ / 2;
>>  	retries = MAX_IFS_RETRIES;
>>  
>> -	while (activate.start <= activate.stop) {
>> +	while (to_start <= to_stop) {
>>  		if (time_after(jiffies, timeout)) {
>>  			status.error_code = IFS_SW_TIMEOUT;
>>  			break;
>> @@ -196,13 +205,14 @@ static void ifs_test_core(int cpu, struct device *dev)
>>  
>>  		status.data = msrvals[1];
>>  
>> -		trace_ifs_status(cpu, activate, status);
>> +		trace_ifs_status(cpu, to_start, to_stop, status.data);
>>  
>>  		/* Some cases can be retried, give up for others */
>>  		if (!can_restart(status))
>>  			break;
>>  
>> -		if (status.chunk_num == activate.start) {
>> +		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.gen0.chunk_num;
>> +		if (status_chunk == to_start) {
>>  			/* Check for forward progress */
>>  			if (--retries == 0) {
>>  				if (status.error_code == IFS_NO_ERROR)
>> @@ -211,7 +221,9 @@ static void ifs_test_core(int cpu, struct device *dev)
>>  			}
>>  		} else {
>>  			retries = MAX_IFS_RETRIES;
>> -			activate.start = status.chunk_num;
>> +			ifsd->generation ? (activate.gen2.start = status_chunk) :
>> +			(activate.gen0.start = status_chunk);
> 
> The alignment of the second line is still not correct but now I notice how 
> the left-hand side is hidden within those expressions. Just do a normal if 
> instead so that it is simpler to understand, please.

In v1 the second line was kept 1 space to the right of previous line.  In v2  I kept
them at the same indent, since your original comment was Misaliged.

I will change these two lines to
if (ifsd->generation)
	activate.gen2.start = status_chunk;
else
	activate.gen0.start = status_chunk


Jithu
