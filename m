Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557D7DEDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjKBH6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:58:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66F102
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L763/PLl737h0SnunV5mZmQy+h/f3oDDVQUk54Tm9qaUJRKm7cPI99BRBYftYgU8ruqoJTlPB2NS8z72giI8u/5K3aJKpxfWTgYjNwL35adBlQTb/U9mYKJjj5btn4iI3pl9gbVApMhCU9/K08uH8bG9pQjrRCKybuPDPbWYwTr7XSimuL+X/0J9iXDdXdHxURDUvzNJK2IMiRzps5nYZNv+8vkR+9ELybPBacx7kDlK3M4VPtnFaZ4B3FB60b3oixKPbvOzjUIMw2QxkbdQocFP8Lt5daVSI0aymYnv8hj1c4zAclECDqg6cGq0tKsWib7D99WFfkJrCzyisyMA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N30oZ4WzFuwCu3lYNV0JgiZx+layo9T1Brkirr0ZUAM=;
 b=guNvQtoMYC9ZmmXOigsOY94p+l6xBRlXFKwuovn9lZ3e3PlaCO3vwGjFRq2wEC0w7DyoyGk/f8dHOcsRZf7ur/Ovy0T+9+BGCXFdG3G/vkqS3D26nwqiXaa66sKg880UG0fH0edTgR5l+YFg+CyrsHI3wXMRMan6CMc9jHY1w+N8fp5Ajw/kPZQhn6dImNyRYp6OsGixuI+efZqSw2uSYT+emA+6SAo4uSzMxcprXk6sP3QnGW/pbtyeovxnAQWUimWfgFZbNd0hA6Jd7uWf+7Nd+PyK8w2nwm/YJIizWGwOqiQsRdndu4OOFHhFHmmkXNSL9LOvT/re97t02nbuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N30oZ4WzFuwCu3lYNV0JgiZx+layo9T1Brkirr0ZUAM=;
 b=ORFYC8Dw4X4bu3+NZK2ece8JQSVlV7zQnc1SsCecpBx3tpPYuOUwlKi72kAL9Et3DvFyC1sKv/JUCssSMNIBDxuucqQ/WjN+YMsfMCcjJkeHBFBatr4y58lR82utoIM8uq19WMHH9KabiMwgYRm5IFD/mCXHlYOZWeUUmQuddFXoHynioaOV2Y+8i8O7zIutcW+e9rIEC8SwKmf6bs7Y57eeN6y6hIfaxVqq3B0G9oxRrtiJ2djnEawNLP5CX9WTNFLk7m4cuwzpl/ASmnLYHGtFgGOXQ4WkANfTITpYJwiMuo3nI89Yq/iwGefHRRgWz3E4oH4ffRQBGRS4scEgSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:505::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 07:58:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 07:58:10 +0000
Message-ID: <cb729887-13ba-4fe4-8824-3062aeb1ef8e@siemens.com>
Date:   Thu, 2 Nov 2023 08:58:07 +0100
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
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 819fa0d3-d712-4875-e750-08dbdb7974d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzuMCveNBnX8YbKx7otKKAGPedjiDN831izxOTvzunAZ8s1eFeUgQP7T9SGy/8JMiyUh/8m+GAksJIEYILfRYSqADkZBbebviiyjin+gH0rvl3AvQBm+TPOBV+UAphyB51BqFv3iy7UoRvUQ8DxA+hQRhMMkdyUd++kpnSETrupAu542AkD9dqCkC3IP3BPZnCjieRWFzKoIFDUplebwErbtxJ0E31qKhiGthULNW+JZerifFP1/4EEH7A9yM3XMNIJWCQ6+OY6xSjhSyFx5LwI7TqvACsxXMk66lWk4FzYyF8Ktl0jKocy3DQb/32byzBKeWsC4Fi0r/lOuwdrb0zmTAYrNoPzQrZ/+64TyXZeU3dGQxpjlYCUYmlQ7rmi9d1pu6428lEkKbyauxr3CDXc8fErP9EAQ67rqHrEV8omVB2+OwYGhPWoQ6/aMrYi3LLr/NT0IJmliXhM7HP44GwAZAb/sSaf79tkomBkcIK6VYqjayXT2P66KrnHlXjmvriMU8X7MoXq76e3QNTfxWYvq4SFtdtZ+utni+yRiTfWLTQmb+VWt5JiNHSPUDEYYReIN07c3iN21AJZi9x4kRIgnOgEV8RDtSOiAdvpEKU4dRAJBQKGRmFLgsRmJrMq/YHkczmKVWtmS1UEWvWMtIPsLy+RpVQq5po0Nr59JxOJiVQC8d8/wDa4jpkeMuEWi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6512007)(26005)(478600001)(6666004)(6506007)(53546011)(2906002)(83380400001)(7416002)(41300700001)(44832011)(66946007)(8936002)(966005)(6486002)(66556008)(66476007)(8676002)(5660300002)(316002)(107886003)(6916009)(4326008)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0YvVWtzYTY1ZWpLWkk0S0FQdVdEdk9SSkV6QXhkYmxuVFRUbmtWZXVsSHY3?=
 =?utf-8?B?VFEwQXc5TENLblpNcmR6V2E3KzlXSGIwaDQ0RkkzMk5ocDNtQUtwTXhvU2hx?=
 =?utf-8?B?QTJEM3IvLy8rZ21kSGJ2amNkUThseXRyQ2VieWtFOU1lUFRiTWhZU3NpYkFY?=
 =?utf-8?B?KzdsUjJuVjhCR1VlWXRxZE5IRCs4czhCOE04RWhyQlFmOEhEdWkwaWJlbGJz?=
 =?utf-8?B?bWoxRzRLZkU1djJjc3E3UDArWEt1Ui9VblUyRXZkNmFBVlZobDFQdDBYYmtW?=
 =?utf-8?B?cGdRZktaWGZVWUMxd0VrSFhvUmpIVXd3U3lOSjNwOVAzRTVNSzYwdzlkRnRJ?=
 =?utf-8?B?Slc3ek5JUUF4RWExQm5HbzRFd0VaSVE0cUlJYm5uQnFyaHNaV1dOSi84RUd4?=
 =?utf-8?B?clJoYk1kT3NET29JMzVUUk03WUkrazhTL2RqTDU1d05nWHlyaUQvTnFlVW5D?=
 =?utf-8?B?REIzc1pzOXJERHFKbFoxVm0yd3dlQUdBNkN1TnhoOXI2dXRnd1VpTFFBME91?=
 =?utf-8?B?Z0VrUmxZSUJnN3diOGgzdGpRbk1CV3hwcWJPSGFrUHNtYjdoWDR1c3krM09L?=
 =?utf-8?B?S1hyU2VoY0w5MjIwRjFPd2ZlTEhTQlE2ZWJQN1JBZnN3MzNvSi9tL2trbi9k?=
 =?utf-8?B?Rjc4TnBKS1lCaGJYaU9DeHM3WlZSL0RBblBuOEtTbk5XWlhWNTRrVlNMR05Z?=
 =?utf-8?B?dXpQU21PUGFHZ2UrUkNvMGxKY01RZmxlODhUMVNsT3VhVnBSQ2ZCSGgyTVBL?=
 =?utf-8?B?TmVaaHJCVnQ0UWhRUmdGZkoxd0MzMldraDNlRGZzR2dKNlNBd2F3YmFWWExI?=
 =?utf-8?B?Z0h0d3R5d2MvYVlKMTR4NXErZGtsSzl5TElnNkVYSi82KzU0QnZ5K05UYkRw?=
 =?utf-8?B?RG9GRlFpcFBncC9SMnNocVhtUVdncjdxb1FtNmw4TVJEWEl2L2pBNTR0WGVl?=
 =?utf-8?B?UmZRVHJaVXFjb3lDVU8zTGlkczZ2MnhpUXUzUFJYQzlNbnFvV2pXZDlNVHNZ?=
 =?utf-8?B?QjhuOUVnRW1yVDhrQm1tcnlZSU54ak1ldlBneG5nemlFRVlQM2gxUzhLbnNu?=
 =?utf-8?B?V1N0aFdENzhyazNQU3FWYzNLeVVSdzBvZ21XcFRtd2p1TlB6WXlBQno2TlpB?=
 =?utf-8?B?alFmcDR3QmNtY0tZVW1JVnJGY2FKdVU5eC9kNVVXYldyenkvaHkwL1JVK05T?=
 =?utf-8?B?SDlmdkFpZVU2Z016Qk84dTB4L3c5TXhOWGFjU3JvNTJUcjlsTkMxRERmZzhI?=
 =?utf-8?B?Z0t2MzNFWFc0RG9ycS9wb0t5M1NrZjhHVFBkRitRSG5nNmNKQm94dGx1TEZ4?=
 =?utf-8?B?blRHeVFyQWFzeFJMaWJzY1BHTndEclVObUE0ZE5lTHdaYW5CcjFIVFZoQU1O?=
 =?utf-8?B?V3BPRmxMNSs0emd1ZGJVOElxOUg5TU40bkxPOVFLL1p2MnVsZGx5UUVFYUdV?=
 =?utf-8?B?NVNlRGhERnNTQ2drQ1duUmszbHVMdXd1ZkhjT0pWUWVZMWgyRzl1ZW5XbmlF?=
 =?utf-8?B?dDA5MENjSit4TC9zNEczSGppU2JkMTFwY2EvLzVXOFZGcm9GaGpWRWdyc213?=
 =?utf-8?B?alYwS2tEakphbnFPZ3hENjRSbWRpNEh2Sys5dkRZOTdYajd3SnR3QW96U0Nl?=
 =?utf-8?B?eGppQVFvdTJRZ3BZaEVqRHZOdVpGbU85K0VYTE11d2xFRlFNaGVKb0RZTTlB?=
 =?utf-8?B?R1daT3ZnNWhsdUFVS3hMQTlqdFhJKzZXYlZJcURTaFYrUXVVNVRZTHJyb21n?=
 =?utf-8?B?T0U4SEgwaDBwTHA2QWowWUdybUFkWStNVHpydXp3U21HWkhub1NCUzVTL3NZ?=
 =?utf-8?B?Y29WTkZaL2RRRkFOTVMxdTZ6ZVlJNDU5U3QrRWFGN3pneEdRNWsya1dyU0Vp?=
 =?utf-8?B?T3R0b1VXWVhES2RWVUFZcmNQR1MvcWdEL05nWVU5RjU1ZXdjSitrajk5eGpR?=
 =?utf-8?B?M1RqOVpibnkycHN5Vlh6L294cVQrS0dHYkNUbDcvb1lTc3dBQm9ydWVkRXRG?=
 =?utf-8?B?VFY0c29CYlNlMWlXNkNUenRBM1BDNytscEZLYVZkejBEdE1xZU8vRm8wdEpB?=
 =?utf-8?B?UnZxazRIWmM0V1c1WkdiaXR1QUF0OHZ3dGxCR2xGZWZjMkV5RXhBSDVDT244?=
 =?utf-8?B?UFArcjl6dHZGOFRxam45Z0xCcm9ndHVIUU55dTlERGNIK2VQcE4yamxyZ1pJ?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819fa0d3-d712-4875-e750-08dbdb7974d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 07:58:10.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJHVA+bEvByMShXYWG7jvIFm8GMpxI7Cbx8V6OmDfbQ3A7nXX8G97wfgZRgLT9nC2JBG/yPNhCTzPn2Z4UCR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 08:37, Sumit Garg wrote:
> On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 31.10.23 12:04, Jerome Forissier wrote:
>>>
>>>
>>> On 10/30/23 16:59, Sumit Garg wrote:
>>>> Currently supplicant dependent optee device enumeration only registers
>>>> devices whenever tee-supplicant is invoked for the first time. But it
>>>> forgets to remove devices when tee-supplicant daemon stops running and
>>>> closes its context gracefully. This leads to following error for fTPM
>>>> driver during reboot/shutdown:
>>>>
>>>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>>>>
>>>> Fix this by separating supplicant dependent devices so that the
>>>> user-space service can detach supplicant devices before closing the
>>>> supplicant.
>>>>
>>>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Link: https://github.com/OP-TEE/optee_os/issues/6094
>>>> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
>>>> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>> ---
>>>>  drivers/tee/optee/device.c | 13 ++++++++++---
>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>>>> index 64f0e047c23d..78fc0a15c463 100644
>>>> --- a/drivers/tee/optee/device.c
>>>> +++ b/drivers/tee/optee/device.c
>>>> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>>>>      kfree(optee_device);
>>>>  }
>>>>
>>>> -static int optee_register_device(const uuid_t *device_uuid)
>>>> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>>>>  {
>>>>      struct tee_client_device *optee_device = NULL;
>>>> +    const char *dev_name_fmt = NULL;
>>>>      int rc;
>>>>
>>>>      optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
>>>> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>>>>
>>>>      optee_device->dev.bus = &tee_bus_type;
>>>>      optee_device->dev.release = optee_release_device;
>>>> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
>>>> +
>>>> +    if (func == PTA_CMD_GET_DEVICES_SUPP)
>>>> +            dev_name_fmt = "optee-ta-supp-%pUb";
>>>> +    else
>>>> +            dev_name_fmt = "optee-ta-%pUb";
>>>
>>> That's an ABI change, isn't it?
>>
> 
> Indeed it is an ABI break although we would like this to be backported
> but don't want to break existing users. So I brainstormed on it and
> came up with an alternative fix via device attribute in v4. Please
> have a look.
> 
>> Oh, here did this come from! Yes, I recently had to adjust some systemd
>> service due to carrying this patch but looking for the change only in
>> upstream:
>>
>> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5
>>
> 
> You don't need to unbind all of the optee devices. v4 would help you
> to maintain backwards compatibility, can you retest it?

How do I know from tee-supplicant perspective which devices I need to
unbind? There could be one in the future that will also use storage and
will therefore also fail once the supplicant is gone.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

