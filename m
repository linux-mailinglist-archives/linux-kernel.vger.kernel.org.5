Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869ED7E5634
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjKHM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:29:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AEB19B3;
        Wed,  8 Nov 2023 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699446540; x=1730982540;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbPjrC15KoIrVygM+C69qKqJfjGe0PLwD5qi0KsO+9c=;
  b=cLz8luxjFwil5Ahns8vNUnD06o8d76xyFaLfo95/fukRd6FZq1gKFH6r
   hok4Qtkq+CvmgQ0R7bOu/VWfYSPibHY7f7/35AUzQbw6HweMk7kIiuMS7
   67meVippaEl6Q75L3041lG3koBMDVwRxNG4JMeAxGjKJdniGaHB/wNUm8
   13WoIlLGeSww0sqS4nrjb8+i+EXJn5YZq701uWAgro6kxbppKLBsrvR+D
   4iba43tyBZAQL3ThlaYXjCIb9iZA0RwE2TdgmkHcm1Im/lc/PcsSvwccO
   ioQhTCsCun0km3dhicti+Lo6Xeyghh3eEjtRYcdUoGP9F8aPmjuC8kSVw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374793911"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="374793911"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 04:29:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="880193932"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="880193932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 04:28:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 04:28:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 04:28:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 04:28:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzB/lcnrhYoOfTNTLtWK8SHR6nlDy5/kYvU2xDATxstizQA/Y3Kc0WTdXDBhFwS4VIhkhpgOLqHloHEDf9jv+GBw8e6GHwSCCOSFJx84WtDIomsg9hoBfwqy9EZKYaunZdz/Vb6pgj3psP7OtjXsxmNOyoy76ARB7QDY707FENS+S+gboDHMmk1x2gwtk4P8FeS7WzUOPhi0h5cuW9cO1mT8zOJ+VqZXBOuSagEB8sZQwP9QhTmrLmaCGHnBM+5h1uPjxXzA2AK1A6JhgzBwT5NGvM0MqXIv+W9JnTnT3PGYDybxXLK9I8AYn8V9yNC3ZjxE0zlsru0OhlqUPTFz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3L0+6R6/O2rxn8FtiDT4isVNwfJFrXVuI4c752v6UU=;
 b=XVUsbGG4uW7W0Nx3zIolXZA50p1MNEg5p8LE6hJMuyFfdlXQhdidY1ksduxDJAmvQtoZODwL9XnHukc4gqo7dmsqaEudiLoc2yW8t8Sp8mPWxuJwK9zsv/SR5syzjzQlT3JpgVBoR8n0iFNP6AU72VlXwxPeZuoPM5oyCMbQCzASUCId9r+KVgWyBHPPi0iw8mW1QLdituudyIBssJ25H+4thh1njbKkhcKXml3CiFdYm7jbReHr9QSiLl+ZLncXsTYsKeqjgqdWoPMz0ZhihYX9CIuhoD3+q8I03+MnShyZWwtBimjz+xSF1PlLNylE7XTfxgiRbv5QyiG6w43HCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB5474.namprd11.prod.outlook.com (2603:10b6:610:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 12:28:57 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 12:28:57 +0000
Message-ID: <2a1d3097-b8e7-4007-b98b-5b111c4b7702@intel.com>
Date:   Wed, 8 Nov 2023 13:28:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
CC:     Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
 <e3b4b1a6-5383-4bfb-ba83-ab27d58dae29@intel.com>
 <ZUqCpmDgKFbscRgW@yury-ThinkPad>
 <457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com>
 <ZUqPAZC4sS455xtx@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZUqPAZC4sS455xtx@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 8001767c-e112-4c55-c137-08dbe056475c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REMRo2tLkVWG/LAIM2knJ1VLv7FlF7KKJP3uyXBeOVVnimaPj87fIX+HYOBa1igziaLdN2oG5FeoSip23jmT6DEagvxSiGkM8MRamebvZY7unIF3SHMaG2KRiFsyw2XSGfHlO/LcjedfG9mx6gBJgZlfLyZJVYwoi472EppbisUPKqsPIXH8FkeaSzbhKa5EaBH2tOfKSyYfcdMaOH5VKPVw8241kJCdW8FEUYPLur7MmNBo/OWKirSPL1jMero4QVu2HUg0I3+hqNhTsSPtDddwxWsYm7zYPpgaT8ZlI0XLeGdTglnj6az05odJMZMV6dPljMModUM0nbvoau3MQTCsrMs9G+bsvYbCVCXwkIkce+rBh9bJszXhWFGH2CR2iNvsQprp3u6gSaLjK+miQScWfZIPc3BSmJbkkhy2TaoLY9a837olaohqUYOSNRf2xy1HBE47EwvfappVB/Hq2brJTFVrYEgXKObOHJib9XghnCuaqgyR7BOye1H8gL8fFCTA5GDRp5hHd0eOBM4VejAvVaKsXTo12mh+rFNDLbf6E/skppyQq1YyiixhDDgeN6Zc9Is52E/wnxHJK74941wrrzsZ6LsO+vUFX29Vsg/eVoDNzAiKcKf9XQYdke8moMSMJO2GHCfC5p1DWbKXdX8Ojp2eSRweJ7fcv7dDyHWDGdl75t4ywRMZcqEtJtFN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799009)(186009)(64100799003)(31686004)(6506007)(53546011)(478600001)(6512007)(6486002)(2616005)(66556008)(38100700002)(36756003)(6916009)(6666004)(86362001)(82960400001)(31696002)(26005)(66946007)(2906002)(41300700001)(83380400001)(5660300002)(8676002)(66476007)(316002)(54906003)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThKOGorVFVMaTBmVlBUMWVxTXVkbDdURi8rcjQ3YUtIWnU0eE0yTjcvQ25z?=
 =?utf-8?B?NTJOWm0zYVcxOXdNK01FUGZCSTRDejF2MnhOc1BBZTdNak5kaDBzNUhNWTRz?=
 =?utf-8?B?OE8ydGZObWVDTGtPUmxqN01UKzZSWHZKVW5mMDh4WjZ0ZEtSci9Jc2tGQlhC?=
 =?utf-8?B?VjVGZTA0WE5jMVk5dFpYWkNmMnlDREdVQkZnNm90SjEvUUlzNUsvZ1RlK3Vt?=
 =?utf-8?B?eXZjOEhtYnp4MGhLRk9WTlhtbzlTTnhlUnB5bGlJOFl0SFN3RXFqTUs2MVl2?=
 =?utf-8?B?TUJYRWxib2tsc245WlFnalozRDFjWk90bis1Y3JTWExxTFhIUWlVTEo2MGcr?=
 =?utf-8?B?SVpGaElCZmdJOWVQc3FLVkZJYkFpdEJtb3EreTRtRTV4d0ZVK3haZENac2ha?=
 =?utf-8?B?R1Z0bGJXZnZjckxMd0J3MDMwenNFajdqREhIcVRpa2l2ZGRObFBuQ1pCZVZo?=
 =?utf-8?B?SjhOOEdiRWRlZFVwL1l3OUo3TlY4YWRJUkVjUElLeTlTOGgxSnJhUXJLSXhX?=
 =?utf-8?B?S3J2MU5MZHFCZkxHOTJaVlRzRzVRTE1NK203Ry9xMUhSVW1yd09sUm9uWEhG?=
 =?utf-8?B?cGhXQU1sVHZERTV5TC81Y0gyTngyVWxLaG9pY3RqQVRNRWxoTHlDVXhOeGVU?=
 =?utf-8?B?T0FGWTVjSDR1QXViaFduNE5Gd0hXMUVvMXAvN2FBL2hTbzcrYXcxei8yQ1lR?=
 =?utf-8?B?cWRxTWM3cGg2cDlrbGxYNGx5cUdPaUIyVEF3V3hzdXhOeldwRWRlbHJTbWc3?=
 =?utf-8?B?TlNtRFcxU2ZLR2FlaXdIdW40YUZWSmxLRkthVllsZG5EWTFJUVJsSzFMUW53?=
 =?utf-8?B?aWhSS1k4MGF1T0NMeCtPOWt0eGxEUFdPNnpZZklZdGtTcCtTTk9aUkNueHFD?=
 =?utf-8?B?blJsN0g3bXFZci83S1B3aGhlbng1NE54WGNpeWU1MHM0Y1hHMmlvc1AwQzJS?=
 =?utf-8?B?N3lNQjZpajFiSGdlcVZCVWNrQnNVK2FQamExMmRGSDdPbjJyU0l1WVFMU09i?=
 =?utf-8?B?amsrS2FGcWwwMGptUGNPTzRUaDU4RUtyQUE1b0IrRVZ3KzNhdys3NFFYckVQ?=
 =?utf-8?B?bGh5ZUNqYUNNT2pBSTJGY0NjZDBzSUxVQjgxUXU2alJyWC9EY1NDL3dhTjNI?=
 =?utf-8?B?Uit0VTRDWU1NR3VHV2NidFVEQUM2NlpHNURpeVBieUFyeHVtU0FVQlFwWHdt?=
 =?utf-8?B?VXBjSUJjRHR2M2lLQmh4S0FyQjMyd1lkVDhEeUgxWGJVdGYrMnZlVFlHTkhk?=
 =?utf-8?B?YS95UDdoUFhxUjlQR2NTdGMzSmFCcEw3eDZ4eFhwbnROM0ZWdkVObHRyUlZE?=
 =?utf-8?B?aytKeFhTT3RXSDlieXhlbXpLbnIybXhZYVZiRG0zVHBPbVh4Y3hoSmJDYS9h?=
 =?utf-8?B?bWZ5dkhlWlV0elVwV3pvTHpUZmxnUVJraGg1RmV0aWhTSDlNdktpU0MyM1Np?=
 =?utf-8?B?dHZDZG02bFpzUkF6T21RajZ4NzJYN2UwcjZXbVFaU2xtc0JCNDB6amhxVFM1?=
 =?utf-8?B?MDRqc29XTWhPb0NUTk9UWUJBc0RtVHVvSkQ5RW1VUnpwK3BBU0hUYmhkMitL?=
 =?utf-8?B?Y0NtalhPRTMyM0g4OWlRYVhiNzVncHNnUkJ1TXIzOXBsSmVCeWFpWmpYdEVX?=
 =?utf-8?B?dXhBZlg2cjBhVUZ4c05xZDJFc00venBySzkrYnBIWTdYZldyd2hjMGQrRmpE?=
 =?utf-8?B?OGVvdnNDaFNqQjhaWmY4ak8yOTBUWGZaNUpyRmdia2pmSjdYYkZTbXdCdmVI?=
 =?utf-8?B?SVUySWkzTUpsNXdKRTFOQ0tZdmJQbTQ1Nzg0THpwS2RTRHNJK1kxUktqTmNa?=
 =?utf-8?B?UlRSUWozRXBiRGJJbVVlWXd0SlhZQW1kRTh4ZXVXekNZdWgvT01MQWVMaWll?=
 =?utf-8?B?M0NPRWR1SExzZmNlb3l0aE9PYmNKTTZ4MHQzSVFRVU5WajJVY0IyZlY5aGht?=
 =?utf-8?B?UzU4U2hlenUxRWVpVjJXTWx4M0QxTTJPVitpb2VQY2ZmQ3RiTHRYLy93VzhO?=
 =?utf-8?B?ZFJEZWdUdEdGbzR4NFlsQWIrWFhyOFBMS3ZKVldCbkRVVStGeXduT2p2N1JC?=
 =?utf-8?B?NUVtY3lpdHUzdWw5RE9QM3VIbVFoS2ZVcWN1UVlOdVNXNGY5SXZSdHN2MSs0?=
 =?utf-8?B?dDdPR3BlZ3h6YzhzanJnNWU0UUN0cmZ5R2Jtb0NBdHBsdHBjSkt0VFh3cU5Q?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8001767c-e112-4c55-c137-08dbe056475c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:28:57.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAVbzSExbU/gC3EX52OSEFtPyzOEKnE/tF1Dul0Lwv/Kp+vXGQ3euhkeCStJCYrov4Z+g0XjBGhbsJiPxrulwRC7rHJjRtO12g0b9kZ6WVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5474
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 7 Nov 2023 11:24:49 -0800

> On Tue, Nov 07, 2023 at 07:52:19PM +0100, Alexander Lobakin wrote:
>> From: Yury Norov <yury.norov@gmail.com>
>> Date: Tue, 7 Nov 2023 10:32:06 -0800
>>
>>> On Tue, Nov 07, 2023 at 06:24:04PM +0100, Alexander Lobakin wrote:
>>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> Date: Tue, 7 Nov 2023 17:44:00 +0100
>>>>
>>>>> From: Alexander Potapenko <glider@google.com>
>>>>> Date: Tue, 7 Nov 2023 17:33:56 +0100
>>>>>
>>>>>> On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
>>>>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> [...]
>>>>
>>>>> I tested it on GCC 9 using modified make.cross from lkp and it triggers
>>>>> on one more file:
>>>>>
>>>>> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
>>>>> ./include/linux/bitmap.h:601:18: error: array subscript [1,
>>>>> 288230376151711744] is outside array bounds of 'long unsigned int[1]'
>>>>> [-Werror=array-bounds]
>>>>>
>>>>>> to give the compiler some hints about the range of values passed to
>>>>>> bitmap_write() rather than suppressing the optimizations.
>>>>>
>>>>> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
>>>>> correctly, rather shuts up the compiler in cases like this one.
>>>>>
>>>>> I've been thinking of using __member_size() from fortify-string.h, we
>>>>> could probably optimize the object code even a bit more while silencing
>>>>> this warning.
>>>>> Adding Kees, maybe he'd like to participate in sorting this out as well.
>>>>
>>>> This one seems to work. At least previously mad GCC 9.3.0 now sits
>>>> quietly, as if I added OPTIMIZER_HIDE_VAR() as Yury suggested.
>>>  
>>> What's wrong with OPTIMIZER_HIDE_VAR()? The problem is clearly on GCC
>>> side, namely - it doesn't realize that the map[index+1] fetch is
>>> conditional.
>>
>> It's totally fine for me to use it, this one is just an alternative
>> (well, a bit broken as per below).
> 
> OK, guys, that's even worse. The 12 and 13 don't fire the warning
> because Warray-bounds is explicitly disabled for gcc-11+. Check
> 0da6e5fd6c372 ("gcc: disable '-Warray-bounds' for gcc-13 too"). I'll
> test how gcc-10 builds it, and if it's broken too, it's worth to shift
> the threshold in init/Kconfig.

OPTIMIZER_HIDE_VAR() silences GCC 11 on my side (`-Warray-bounds` is
enabled via KCFLAGS), but now I'm wondering if it could possibly hide
really incorrect cases like you mentioned before (reading 8 bits
starting at 60 from a 64-bit bitmap).

> 
> Let me check it later today.
> 
> [...]
> 
>> Oh you're right, I didn't think about this. Your approach seems optimal
>> unless hardening folks have anything else.
>>
>> I don't see bitmap_{read,write}() mini-series applied anywhere in your
> 
> I'll not take the code unless there are real kernel users for it. Your
> compressor is still under development AFAIK, so I'm going to pull
> bitmap_read/write with ip_tunnel series, if it comes first. 
> 
>> tree, maybe Alex could incorporate your patch into it and resubmit?
> 
> Yes, that's what I asked him to do. But let's put it on hold while I'm
> testing different compilers.

So now I feel like it's a matter of extending the Kconfig threshold like
you said. The code is clearly valid.

Alternatively, we could trigger a build bug manually when offset, width
and map size are compile-time constants and suppress it otherwise. But
sounds pretty hacky.

> 
> Thanks,
> Yury

Thanks,
Olek
