Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE927DEDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjKBIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjKBIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:05:40 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72404128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjTV+v1lbfI0RQ2L2cP0ne3A8ZUc6Adb/pALQt+g0e6w3zHvwgGhH4bsYYY/kgHybeX9ZDcHqaRcKZhSGz2jiKrFvhehRUlMZ1mfUcmKdlJ6uJk2j4/fVhwIB/tnB7sJgm8rk+lb6z+rk3IE86qMPzub2I+KE1gKhWKUksHF7v3Wq3MJUOUx75S4jDLiG/Ru6S+vtTXl6BECVnii+dAnDTmMHEw7zAptKbmlvfukqxQ+awI2CiKsxUB2VzuZ6d9JqXXv5Jg3kHNkhvq1rEWw/QnskCjefJkqyKhHrhiE9m+uW7mZT3qDbeQAvteb8AAA/cMmuPQqL+mtBo4H//UJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvNRLol+t0jsHXGQEcVBOtkamx7Q38mRpVHs4Jcc07g=;
 b=MT+uqyetWgdBqP9TjlmlPTf+9iQrBFbtSTAo09Iw4nUjqMnJ0yUrtuBiRDc3DsejO81aH3t5XKMmb8Jkl/g/9sqw2I7mGbXrFVe3V/K0aX2iwD4xoNHsIo1zjjaIH9vRME/fnM0ddzddQgAj0m3LbfpJZJTqcbEktdLEN7KmcHUMQU5wmfhzomze5+D0RIKcqilyMkqHlZMIa5Jf3qs3byMgNfCF3+bwbTYqAIMRep1LZDTCF68MtIzfsYoDsDTUKYiq7OFheKs88lia8CN17MWj7MT4bp5c/RTvDqXPKfT78M/CGFrehMoOj1cinB2OnJbn1/kuJo0DIQgEOeoTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvNRLol+t0jsHXGQEcVBOtkamx7Q38mRpVHs4Jcc07g=;
 b=LEl9ZpEHI9FMxI+r/00ctddUy9QMrQNDyKBKhKR8iV/rD+G7ylZK24yVMXceOyqWRqQv1rbM8MjMms/4dBelisjsoiH1XsyhV4X0j0oeXIe8+Tt+ihx24bxQgf54YuYyWFFAqAH3he6mww/hqJC4ISkVgYPU0+xIVAsZxTc6tRli+9tJOA6Yoa3V2WlsaLalYnIhhRQ2YRfPMiEfqcx3qBnJokt3T5MUt6NRBcBqJ6jwVWAMK6CsjFXyBZ0Y+rJCG5sC5KXbqekuoWO356mX+GUuyK6iSjF0Z0Or/4TTuaADwNLbLtuNwZz8lURA1xh2N0FBdbyl71ZFIj4E7AZ0cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 08:05:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 08:05:30 +0000
Message-ID: <61eb38c9-e40d-456a-86c8-e2d851b947f8@siemens.com>
Date:   Thu, 2 Nov 2023 09:05:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tee: optee: Fix supplicant based device
 enumeration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome.forissier@linaro.org>,
        jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        arnd@linaro.org, ardb@kernel.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com
References: <20231030155901.80673-1-sumit.garg@linaro.org>
 <20231030155901.80673-2-sumit.garg@linaro.org>
 <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org>
 <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
 <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com>
 <cb729887-13ba-4fe4-8824-3062aeb1ef8e@siemens.com>
 <CAFA6WYN-9dYRbBNM8q=H1DE7YMH4_z2fJpyvSG+W=Hy=Vo8NrQ@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFA6WYN-9dYRbBNM8q=H1DE7YMH4_z2fJpyvSG+W=Hy=Vo8NrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 17742225-ae78-4b13-0589-08dbdb7a7b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLaKZNpwMkPauci0q5mY5GeCEXz74WRYnHcdlSIu2TdhHm3xdCCNjiA+HO3USbgVEXuhXuOW1/7/hRB0KKbWiR+wxbGXCave+VqGKsSa1al46vjjtW9HaZ6LjITQcXLxVok7jyxclJsZ0zP7yf4eCxRMnTcAIZqZmfLBLHGOHXLIcevxg937N4mdkcq59ICeRBdBCLkUfwB7a6BhAhbTyvOgLnqeqnoheyb6WzUv8G8ypsIpCILuKxEU4H47ikARKYOWSBnqnptf0lgMq0uQJllGNdA55lVGeF5Bws0mgoIpTa9I7QrGq7JcnjcOiNyqhqPlv2hq5WI7m253yEsY4V5vlUaTz10LLicl7FojFuyU7l21uJQsFLRcjCVWltUoCIv73KDgCCaECcKfZV59sb6ozyfFe5QQIQLSS1kRc5u760Yrxwdr25PhEoJC5swDkk6IM10nuKk3lAKYO+wZFSKXtiFfiT7GvNc6GUG/tiL68oaVGlFmUpTzJDquhJ8XBzQLyDHDRm4wMXewceISkF+W7kkFOPS8TUrNANJZTRoE2LyBdllS4sTO82B9LI8a/kZvLcJCMxPb8bh47FiBGYZ692uusDNp8tEZCEUFQ1EB+bbDAlwVLz0rNRTpJS7kMVl9gclRbdxzQdFdH1P20aW6wrMn07PmsMWONud3IkTFJsNRRsDsWrbCErMw5jmh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(26005)(107886003)(82960400001)(2616005)(44832011)(6512007)(6506007)(53546011)(31686004)(38100700002)(6486002)(6666004)(478600001)(316002)(66476007)(66556008)(6916009)(66946007)(966005)(41300700001)(2906002)(36756003)(8936002)(8676002)(4326008)(5660300002)(7416002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHR2V21zcW1qRTBRaW9jL2NIeGRMdWx3MDdvWjNXeTF1TzNoaWJ2UHpST2Za?=
 =?utf-8?B?RmVCT0g2aDB0WWhhd005TDFUZnQ3OFdJWUxlbVVJQkptVGROY1ZOWmdBTTFy?=
 =?utf-8?B?eS80NHhiSVJPdWkwc2Q0SHhMMWdxNnlpUS9MckVzbjRVVGpuaWZXeEhlNTdH?=
 =?utf-8?B?OXJoT0hJZ2hWNThiaEtrUFJDU2RLNUZ0ZTB6UUUyV3cvL3M5MDVFWXEyU0Vo?=
 =?utf-8?B?RlpaR29DT1Y0bVhpTmo4a01aaFBjS1dkMXo3OHJvaFh3RlV2bWhEMDgrRUZi?=
 =?utf-8?B?R1BPa3UrcUhhbWZYSG1vdklleVFYeHZGZklnNXYrSnNLcHVPbnZwM0J1QmNE?=
 =?utf-8?B?aitSd2tSNEQzbldBVGVrZ3UycngvaWhLVEQySzZkM3VRSHo0WGw2Uy84OGZW?=
 =?utf-8?B?MUs0OTcydFZSNi91b3Z6M1E3VkRuN1VHakMzaWdvRHhPU05TQjYvOGJwYTBO?=
 =?utf-8?B?NWZKUVFwVnVZcE11NGR6Qjd5ekk2WDAzVUhLNzh3WjFlZlMrMXpWV3k1OUNh?=
 =?utf-8?B?R3Ntc1h2OGZGOU5XVHlCWSt5OEZjVW9vejFwTHZ3eU5aL3gzK3A4UTZLUlV3?=
 =?utf-8?B?eXVodWdPdHhqZlZjcEdNWWJQamZ1cnBJaFNqTDVwbUZ2QjJkL1QveXdWRnFh?=
 =?utf-8?B?dlBkTFJZSGdtWTJxcG9keHNOTXlMWEtUd3F4RUlVM05teG1GVUtaS2xiWFBM?=
 =?utf-8?B?bGVwaVBxTS9VMXRvMG9FY2g5Qm42ZWZ0L09KOFlVZ0FueGNyOTlwZW5sb3ox?=
 =?utf-8?B?ZjZBTFFVblZmOEJoamZBRytWS3RaOVM2YU43akp5ZnR0eW1jQi9FTUpQMXN5?=
 =?utf-8?B?c3hhNGwrdVd1Z0Zpd1gvbGorVit1VjZ1ekJsY0psMlU2UkVaUUlpeDVsemlV?=
 =?utf-8?B?dHUwVEFlcThZaUlzaXZKb3U1bW90YUVDMFVYZGUxaTNvUXpwQWJGNXU1MGZ2?=
 =?utf-8?B?OGI5QU9iWWYrNS9KS1I0SUlxQmVYWWxaUzZnSE9XRGlOVFVYTXZXTU1vUFl5?=
 =?utf-8?B?WlpTaWMrT0doc2ROMkhLUGxKci9pQlM2cXVtd0FVM3pYb3NSazkrMHphb1NJ?=
 =?utf-8?B?Qi9QYWhoWVRSc1Qrc1M1MjlBT013Y0NKMDlJZTBuWmNYQVdQNDJPSmRXbzRj?=
 =?utf-8?B?d2Nna3N1d3RJRnNMNE5NYjAraHN2Vld0bzBOQkgzK2NobEZxOC95eGFscFNK?=
 =?utf-8?B?aExuVTdhZWpVR01DZlhPVm5CSHQ1Mkd2OG1uTnk3WDVoWFFXOGRTNkZSWVhj?=
 =?utf-8?B?Vm1mT3FDL2hmU05qTTA2UVAxQ01LNS9mSlhLQjJsc2QyUVVWcE1YTnFDdElX?=
 =?utf-8?B?WDhtdlkrK3hOTjBPOEoxeDZqNFRmS213UzhwcUV5L1EwOUhyRGRZUXFTQktE?=
 =?utf-8?B?U25WakRoaHQ0RG5Yd2xNcE04Z2NCNlVqZDAzeXdsam1MNS9oR0M1UDRta050?=
 =?utf-8?B?V0VBaTV5bmxsbmROanA2N1czSnNQaWhSK2pEcXIyMlhYaGdXS0RTVjREZW9W?=
 =?utf-8?B?amwyYy9DTytwekxFQWErYXZIU21ER3FWN3M2d0FxYjNlK0pRVUcrM3VYRk5F?=
 =?utf-8?B?UkUxMHFGbGdRVldqdmV0bGlRSVNjb3F2bXpOaG90anBOWFlzbVRjRlhCYWxj?=
 =?utf-8?B?K2E1VVphS2tCSEFJem1PVlhjVDFpYUlEcFM3bXU1OWZrb2p0cTkzTmZvK2ox?=
 =?utf-8?B?c2dFbDlYVERJU3h5ZnlRRXR5SVlhZVN0STV4TDVaUWswMVVJMitRNmIxWXdF?=
 =?utf-8?B?TnRieXVBSXIyVzNaUkFWOVJwL1YzYUY5QitMeXlIUXdSVUw2cmwydFpLTEUr?=
 =?utf-8?B?VzJTMm5KMkRXakJxOXRXd1ZHYi85YjR4VmxnbmlWZWltMVVZcS9vT2d6QzZ5?=
 =?utf-8?B?dUlkanlwRE9KMytqRkVLM2piZnJhS0o2VHBUOC9od1BNU2wzdWQ2MHpVYkJ4?=
 =?utf-8?B?OVEzc1JiMzlhcnBMUDJaYklWcGhMOE5FWm92QkVDSVZSSlVvbVR5VmVhNS9J?=
 =?utf-8?B?cGVwbVJRTUFSMkFpWTRUSTdiTmZyOGVTb1RvZ0hZRVkvclZ5N0wrektockdR?=
 =?utf-8?B?d1RSWmlqRWlVMnRpcSsrQkpzRmRLdFR2V3ppN1ppMjdvdFloZ2Q5ZHFJako0?=
 =?utf-8?B?MC9ucG1SM0srN01oVjNiaVMxKzFmM3JsL3VTSkxJdWVZSUp6b2E0M2RWREtn?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17742225-ae78-4b13-0589-08dbdb7a7b17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:05:30.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBqkIQwpFwqbI+LIGr2loLQ87KbalLWgA8YfDZqOzOEqxMxwmLMlTdFsuAvhtmFmPTdjHrhpmzg39CCF+n1BxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 09:02, Sumit Garg wrote:
> On Thu, 2 Nov 2023 at 13:28, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 02.11.23 08:37, Sumit Garg wrote:
>>> On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 31.10.23 12:04, Jerome Forissier wrote:
>>>>>
>>>>>
>>>>> On 10/30/23 16:59, Sumit Garg wrote:
>>>>>> Currently supplicant dependent optee device enumeration only registers
>>>>>> devices whenever tee-supplicant is invoked for the first time. But it
>>>>>> forgets to remove devices when tee-supplicant daemon stops running and
>>>>>> closes its context gracefully. This leads to following error for fTPM
>>>>>> driver during reboot/shutdown:
>>>>>>
>>>>>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>>>>>>
>>>>>> Fix this by separating supplicant dependent devices so that the
>>>>>> user-space service can detach supplicant devices before closing the
>>>>>> supplicant.
>>>>>>
>>>>>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Link: https://github.com/OP-TEE/optee_os/issues/6094
>>>>>> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
>>>>>> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>>> ---
>>>>>>  drivers/tee/optee/device.c | 13 ++++++++++---
>>>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>>>>>> index 64f0e047c23d..78fc0a15c463 100644
>>>>>> --- a/drivers/tee/optee/device.c
>>>>>> +++ b/drivers/tee/optee/device.c
>>>>>> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>>>>>>      kfree(optee_device);
>>>>>>  }
>>>>>>
>>>>>> -static int optee_register_device(const uuid_t *device_uuid)
>>>>>> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>>>>>>  {
>>>>>>      struct tee_client_device *optee_device = NULL;
>>>>>> +    const char *dev_name_fmt = NULL;
>>>>>>      int rc;
>>>>>>
>>>>>>      optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
>>>>>> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>>>>>>
>>>>>>      optee_device->dev.bus = &tee_bus_type;
>>>>>>      optee_device->dev.release = optee_release_device;
>>>>>> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
>>>>>> +
>>>>>> +    if (func == PTA_CMD_GET_DEVICES_SUPP)
>>>>>> +            dev_name_fmt = "optee-ta-supp-%pUb";
>>>>>> +    else
>>>>>> +            dev_name_fmt = "optee-ta-%pUb";
>>>>>
>>>>> That's an ABI change, isn't it?
>>>>
>>>
>>> Indeed it is an ABI break although we would like this to be backported
>>> but don't want to break existing users. So I brainstormed on it and
>>> came up with an alternative fix via device attribute in v4. Please
>>> have a look.
>>>
>>>> Oh, here did this come from! Yes, I recently had to adjust some systemd
>>>> service due to carrying this patch but looking for the change only in
>>>> upstream:
>>>>
>>>> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5
>>>>
>>>
>>> You don't need to unbind all of the optee devices. v4 would help you
>>> to maintain backwards compatibility, can you retest it?
>>
>> How do I know from tee-supplicant perspective which devices I need to
>> unbind? There could be one in the future that will also use storage and
>> will therefore also fail once the supplicant is gone.
>>
> 
> With v4, the devices where the below attribute is present need to
> unbind before closing tee-supplicant.
> 
> /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant

OK - but that will only help in future kernels, nothing we have today.
Thus, the shutdown script cannot assume to alone kill those devices
unless it find a certain upcoming kernel release.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

