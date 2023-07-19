Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A8758D64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGSGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGSGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:03:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7151BFC;
        Tue, 18 Jul 2023 23:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMq9O0GHSaH5lZsWqaaM/PwulPiCsY13JKMkp/yBpO+aHBbyo82XcV0xQQN2eSe58C2uEYmo0sU71GAnttObPTQsluRScwQ6oMgoZV0zDQb28xm4uZOFLeWhBwXh4iljV+rySTM8gkd0WvWXqn1yrT3whjf+mTE/T8j0fiI2PiZUnxkaBhrORDwH98I2molJKrm8TtPrOJ3sseDREJmmHsi2rgybGlkHyfD2KYoNympYfu3bzlmRKemvLDhc58oZisz3zx3gkuEDI1zjCKrhp1SlBsD8AoTirEcKv3lzDogvHUKzfWGQdFoPELrsZU+WTasux/HD9+cfy9hhI8BhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36SX7ZkVs2hb1dN7o0vtIp1Ce0Rd5cj7OfLWWrMVF+s=;
 b=Zpg6ceNnhbcYmIZ4OVP9Uxc04ruuz3HT6HGHCN7KSgrHBIEB+h+N5XSHsaz4RJPp/fxNo5DOvSD2BEU8pYUQNTiU73mJbLGB2GjKIhMu+XYxtquUtwfq7VLELCEuYoeGIJ7a0uKhHWrw+B2sRiMEvz/YY42WULrzXp5HrWVF0sDY+tYriTZcBH86ksmp8Qc/3aCluGDYufxydybPEpeAzUTZj+8YjbYuFw3p0QyYzUNcyhmkLtMhq1j5i0Zynkjnmdv5HmSdIdrbAN5Dw8Uem48K/sULSnL/tENNGFyXMBzSY8ige0dD2ij6OyWGSa5R4djZ5EcNCCcLa2poYKucRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36SX7ZkVs2hb1dN7o0vtIp1Ce0Rd5cj7OfLWWrMVF+s=;
 b=B9J/X9vaceaoLSCkh2/HSjk6bXz0+wuE7upgDIiFB9Se44cvjhaBZjOkhlQ24QFe73zP+QRMLx6nNBXk6A4CRc56tjxIr4BAfLAH2T5RdmkbXt192QTCfzVMdp0SO9QYbMAUIxHDe7nVKEvuV2ZcLxOMzG4Z63+aqP5PQqHe988=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 06:03:08 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:03:08 +0000
Message-ID: <6393279a-60a7-2e96-338f-22db9b9489fc@amd.com>
Date:   Wed, 19 Jul 2023 01:02:15 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/1] docs/sp_SP: Add translation of
 process/researcher-guidelines
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Avadhut Naik <avadhut.naik@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230621171457.443362-1-avadhut.naik@amd.com>
 <20230621171457.443362-2-avadhut.naik@amd.com> <87v8emxosw.fsf@meer.lwn.net>
 <820345f4-a8d1-ed16-fd40-d38a98033621@amd.com>
Content-Language: en-US
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <820345f4-a8d1-ed16-fd40-d38a98033621@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0094.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::14) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bddabe0-b0b6-4e20-d4a2-08db881dd2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBMP7XmJowD+J3+nTJpMxv/DB7oGpM4Psl+MjwQs2P98vsacxGA68IF4D51nH8PPWgi7+UhK87tXLAGmbvN1MWMWlfc74BoI0Uuolfz1oTBztGiZ0tIJylVmaNtW/0dk87LLaE0yIjoQtcSxBDtQGqkQzfOAU7ixUWXvBSKAREgM5+wEwKP3ixPuuhhkV4ZCm4EbxMJrshY6bnApvQ4aN6EkYjYxRSqt+VSz9jILaxUDVomUOjZAZQgo0mSeJtc/mufZH2g5sMlbD6jf/I1kHZbeVU1fMIenbF7glAkpcHPiOTZJkUYoS0O1T44qoCHsoDtarOAztvMdUvceG7Aqd9lmF8JPPCownsNwnhU4I7yTH9LsnSwAgTstogWP21e5iyCO6IdwVwsIBDGlsler5Y4mxF7EuPNMKs1qlO5ZLLfFMW6kEqv1TS2oBgzZKMBgeh86c8QBYPc3ISS0u/F1daZIO/sstkXDUDtbPnEfewDGcjBI4mdT2iFOYxkIveI1NhignWEksfSAKHPdWmvKamT76Th8UZJzn0NDmwiPxdLx1+ZpGdiJWcG2qMILfpyxtUUV5luCn20jWmRnrA3hNfTf/zWMQ+1tIVep9PJh76O+rOMuqInOvKbFtlytzcrlaMyW9JkIRue2dLLuf+aQLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(53546011)(6506007)(26005)(6512007)(110136005)(31696002)(36756003)(38100700002)(5660300002)(4326008)(2906002)(316002)(41300700001)(66476007)(66556008)(66946007)(8936002)(8676002)(6636002)(6486002)(6666004)(478600001)(2616005)(31686004)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjB3TFd6RDBzUHRzQmg4SWkwVkZzd1lUcVhzcFlIOW1NK00zd0pzUnZyQ0JR?=
 =?utf-8?B?cVJqSkF3aGxua0JyUGZuTFVEeXltRnFMRGYwandnUUcyUklaRlE1V2MyV2l0?=
 =?utf-8?B?aFBTL0NhT2dRa3hueFB2THFpVytFZ2ZMeE4yOFVVemtUNlBxWWNuOW5tRmZn?=
 =?utf-8?B?cVl4Ti9yeWpxazdjNWRKbDAzbFRZeUNNYW8xMWdHa1pDMlgzbnM4aDlpVkpG?=
 =?utf-8?B?cHgrQ1RKK1JWdGFTeURCV3orMjF4Q1JvblM5S0xDZFp2ckcvUTNDS1FIaDZF?=
 =?utf-8?B?U3JGMFdTeUowV1BnWk96aUdLOG15ajdkdFFWK1lLdWtFOUh6Ty9nSk00andM?=
 =?utf-8?B?L1NjSW42NzRibzZsRVVpN3NpTjU2bHgySzdWeVFlMTdMTWQrTmRzc2M5NHFm?=
 =?utf-8?B?S0pNb05LajIrZTBSNThUeFlRaUkvYU1ybVJBVjltWUtYNlRtclo2VlJVWVhy?=
 =?utf-8?B?TG1ma3lVTVB2YWYrYm9DdFVscFNIblZyODNvVGdYSnJxY0dhQ0lwbmt0OGg1?=
 =?utf-8?B?U1RvT2phWm1PMEhGSmRwU21QNmlsbXZ1WjlxbnZLcUE5UC9IYmV3b0ZzaFZC?=
 =?utf-8?B?aE5KQnhvM28zaXVYejlIOXZzVnFIVTJTcFB4WjlFMld0TmFCVHRha3ZOOHg5?=
 =?utf-8?B?VktqeS9MbFIyMGR3d3RERXlkT2tVOXhMYldyVFRkT3V5S1FPeXAxK2NlSFJt?=
 =?utf-8?B?UjdVMGk5dGZLUWRnL2hlTzJFcTZxaGdjRUM2QTd5VVE0MExYVldoMHBxSWxQ?=
 =?utf-8?B?QWQwYldSRE5RZmpYYWZTT0VHU3lJYnluMzRPdG9SM2didU5rbkt0dnA1VldE?=
 =?utf-8?B?QUhiNzNaS1VaeFpxdmY3ZExReW5QczRLR2xyZERNQXQ0d0tPK1B3Y00xditC?=
 =?utf-8?B?U1dhMjFObDEvakl6dERPanNIekxSSFMwNXN6SzROSjlnU0QwZGF1OTBBajQz?=
 =?utf-8?B?NWducjZWWWF5Z0NRMFJYaUxqU2RrMUh1a01sSFZGNER1Qkwyd2dqR1Z2TEw1?=
 =?utf-8?B?RHVhNnZudmdlSmc1MkZqUTBCUnVXZ1Q1QitRTEdzeDQ2ZGp4YzczRnJYdjVx?=
 =?utf-8?B?Vk1kWm4xSnBpVGlCTGd4RGlPUjIrTE1nekR0ZUMvT0VrTXA4KzhyZ0lYUXkv?=
 =?utf-8?B?anR5R2FOOXJEZlY5cVJ6aTV5QStvd3ZmVTVjYS9JQ2ZmUHIvdkJ6VSs2OTlU?=
 =?utf-8?B?R0xuaTdXY0o5anVueWNxUi9qaEg5cG9jYzhqSElRcGF3cHgzbVZnYzJzc25t?=
 =?utf-8?B?Um54RDFUV0ZmZHZ1MFc0UHZrWEZEQUpPdEZreXBHSHFzNHV0dlJSUHA4VmRX?=
 =?utf-8?B?MC9ibDYyREhvVEZHTW0zeVdrd3dEeWo5UDJJZUI0aE5pdnJCQ3Z3Z1QvVXhy?=
 =?utf-8?B?UmZhMXl1dGN6Z1BNRWdzV0ZXTkVnd3d0NUhsWjhEV3NYU2FEVzJmdkN0d2gr?=
 =?utf-8?B?RVY3aUpsaVc0N20waWwxdGQ3U205S3BLVk51Qlh6S2lyblVMR2o3WVJsVDdI?=
 =?utf-8?B?bk1DQXpTc0NmV25xb2ZMck0rMTZydnJHOE9LT1VLNWJGaEFFeWtpM2FwcUZT?=
 =?utf-8?B?QXRnODNzUkhhczJqbmwyeXltT3FuMVRXdEtZWkxMV2N5a3lUNTdVbUhqeGwr?=
 =?utf-8?B?ZjM5WGcwUmRjckpMc3o3WUFldTErd3pvV3Zld3BaSXVEeVhzd2UvbEhjeUtD?=
 =?utf-8?B?d05yWFc4VDltaWx2SzdoZnI5R3dpWFU1eVMzeGVUbXQ1a1d1VForVGhWYWFx?=
 =?utf-8?B?TUpldmFQaWR3U1dZU25QT2h4bmRvMHpyTWR6VnloU1dURmhuSUg5ZFd2UmVU?=
 =?utf-8?B?QWsvWmZMekxDQi8wSDNlUlZRUURnUzdhTXlsVTRWeEJGT3R4WHd5Z2VaM01N?=
 =?utf-8?B?UlcxTzFCUndIeTFtOFVMRXNwUlVScWFBOUJXaitDNWVWUnFadnFCSlZWVmdI?=
 =?utf-8?B?Zk1oN3BGZU5PU1IxSUxOMTNqbm5Wamd1RFRFSm94ZDVOLy9SY1F3VjhqT21D?=
 =?utf-8?B?VHRtWVZjR0l3NHp6RVFoelE1NGgzU01kcWVtdHVMZXZZT2JOS1pWUGVML3h2?=
 =?utf-8?B?MHhJQU1DYTlEU3NBd1hqeFdWR3JhMU82UVJwM1d6N29OQ3hSOWxteWhhVTlT?=
 =?utf-8?Q?80QIZMXKb6li0JIkampaR3nqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bddabe0-b0b6-4e20-d4a2-08db881dd2ee
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:03:07.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efo5Uhcn4qzpostTfLDPdIK5xDBqQkaoFC5aCRQLLyfG3Mp1BZvsoeNh1/GaNxrewP4Lzm443evY92oGsXLYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2023 08:40, Carlos Bilbao wrote:
> On 7/14/23 14:42, Jonathan Corbet wrote:
>> Avadhut Naik <avadhut.naik@amd.com> writes:
>>
>>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>>
>>> Translate Documentation/process/researcher-guidelines.rst into Spanish
>>>
>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>>> ---
>>>   .../translations/sp_SP/process/index.rst      |   1 +
>>>   .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
>>>   2 files changed, 153 insertions(+)
>>>   create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst
>>
>> I've  applied this, with one tweak:
>>
>>> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
>>> index 0bdeb1eb4403..ed6851892661 100644
>>> --- a/Documentation/translations/sp_SP/process/index.rst
>>> +++ b/Documentation/translations/sp_SP/process/index.rst
>>> @@ -20,3 +20,4 @@
>>>      programming-language
>>>      deprecated
>>>      adding-syscalls
>>> +   researcher-guidelines
>>> diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>>> new file mode 100644
>>> index 000000000000..9d374c70348c
>>> --- /dev/null
>>> +++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>>> @@ -0,0 +1,152 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +:Original: :ref:`Documentation/process/researcher-guidelines.rst`
>>> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
>>> +
>>> +.. _sp_researcher_guidelines:
>>
>> I really don't know how this business of adding useless labels at the
>> top of documents got started, but I'd like it to stop...this label isn't
>> used anywhere and won't be, so I took it out.
>>
>> (Yes, the original has such a label, it shouldn't be there either).
> 
> That's interesting, I always assumed the labels had a use I was not aware
> of. Ack on dropping them.
> 
	I too was under the impression that the labels might have some or the
other application. Thanks for the information. Will keep that in mind for future
translations.

> Congrats Avadhut on your first translation of the Spanish documentation!
>
	Thank you, Carlos!
>>
>> Thanks,
>>
>> jon
> 
> 
> Thanks,
> Carlos

-- 
Thanks,
Avadhut Naik
