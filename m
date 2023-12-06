Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD4807920
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442853AbjLFUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbjLFUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:06:22 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C618D;
        Wed,  6 Dec 2023 12:06:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLZ5kTM1DTda+cHhwPI2NEutHqyzkeh+cU7iPBpNDynBoQln0FNkbaq+U16v6OE89yxEImAgblA5MRssGH8D+F2bHJ0M3quNPmnUsP5RsLtlw8nkLwKCSfhWtYsxLl8yNUidv1TtXIio7T/PpCpL8aZbLYyPQ69GaL7lfgFtT/AdGxSyuvhic8Eg8mE/At717myN6F9uEmg/SPpEELrtJvzmO7/x1GHlxDuJubqEmpx3sCjhD0WbWHfB1FY9YxhLJFoarbadSbogI9kBe5V4t+tc93acv8X3YqAln/apngQC3BdkjffhI6s//EG/o6XkBkpEeQ4LqgXWsjhz/dORjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJIMNHysTXxwajYasySRxIbhTq3TPUvUzfAFeaXAW0A=;
 b=eZo/1O/n0ntImGObTJrCNw+1S8hXdvBac36X7QrEjYFiOs91K8PBmyHUEAQAD2R4cAaw8x/G87z+uUc8nlXb16TL6rGb8Sj9UP8Df5C4f7uUfJsYbaE4ch8358fJYrAhtSz5bFAkQqYsPEtN8cCfJy4LQzexJZPlk7VYamYlStJwBTLFehMXRq2NjI+MiBJiiyuDYddw5cnoHkNNHCR2DKABTw2nGadBbNl1wocrppKtY003F8TLb0CR5N/lUxT4bAq0SDTBLZ/AkkQ2rbtqY+nrqhn805IQtlRyNX1t0M8YkHmRwiauXH07u5pVZxKEPYlcwgSp/XtLctCZkDwtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJIMNHysTXxwajYasySRxIbhTq3TPUvUzfAFeaXAW0A=;
 b=4j0PQUb32/XWpzE/3AuwGiNbnR/Iwxfm2SKH1H/yW7A7X/5kW+k3KhLlO9n5DqEoIqOLZP6V5J3sFTkfH4wWfI58mD2laxYSIZPxaJ5mW77z0gf9MYdIaPm5DmSTJB8hJdddHVY4ywrV+dhcEBImE2lc0+ai8GXFKG1GGXTn9fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 20:06:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 20:06:25 +0000
Message-ID: <31feee1c-f1a2-43cd-a2cd-ee3fc30c0609@amd.com>
Date:   Wed, 6 Dec 2023 14:06:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: i8042: Quiet down probe failure messages
Content-Language: en-US
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231206175818.2568-1-mario.limonciello@amd.com>
 <87zfyngoe4.fsf@nvidia.com> <abc96443-ed27-4021-afa9-280be027e355@amd.com>
 <87v89bgl7a.fsf@nvidia.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87v89bgl7a.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f561f04-bc89-473f-6dab-08dbf696d368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0dQlXLaFqwbnpg9t0Lry2G4Big4V3B4Tq8zP6uvmE4QVo5xYNALIEROzHIpWZu0lHKgoPDX7KjhTY2z7YdFvXviSNDzlitgL7YGm3Kh8ZVhQ5Lt29ix/V1aoUpmAkfZRX4ezBcDMyX/r5frOGB/tV2MTN4hvE3WB6pA4Cfa2BoUs69yxTKeFz5Xl8sm1fL8NJ9q0YjCURKCLj+/LjmktNjFLclQ0ZjkxBzMAzjCb5/Ev3G4hE0nvhd6jJ/Vj5ODWJBsOtfDg3c6R4wLoSsiV+Gr8gYOA+DVDrSZoSyfRFgsmCI4aNALr4eu8Ys3On7DYWP1Bcykx5BaoFwli4fAS44AD7PAIaJjBWbPRNkwEy5F2rWz5zaDZpUh3fZE86YhQEximTGmjjx7a/cI+5hZ/PR5o8JB20Ql0HXKkVD+FKJAs6K5sGzsLLXgypLM3GEQzLzd7P9J0ypBU9+7FZZjTf0cc/XKBohuYcyD9lj9IqY54/p8QGWjsO7feK0isrdkimQQi1KjOgfXKMyTHlpb5PM2PSSDgSaoORtnTqXbjwJyA2enQFuZNw3xbnIdpy6vicVEkZX5VNAmoWlIteozaHlv7x+6bxw7GVNvfuydjF7RHYz189vclIGXjpAW4CjWwOw53hJo66BGu1zeNjU+AYMOw5+Djnd6/+qkxxrpR6L/W0Wd8k3Enx0XeKujA6/f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(53546011)(26005)(966005)(316002)(6916009)(66476007)(66556008)(86362001)(41300700001)(8936002)(36756003)(66946007)(8676002)(4326008)(15650500001)(31696002)(2906002)(44832011)(5660300002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpTNUs5bTJSS3FDK2hObkM5bXl0M1NmbERmWFk2QzVLSHRZYWRVVmw4Z1pZ?=
 =?utf-8?B?ZmcyNUQ5Y08vRWxrNWl0V21uUzU5OUVNWDN6Q2pFREdpWkRiVFk3Rjd2THZh?=
 =?utf-8?B?NnZUR0RpSzFERCtxZTEvWCtKbUxQODNuTTRJMGd1amVPZnFtakxxUitVSWk5?=
 =?utf-8?B?bDJNVHczS1d4ektiZ2JwSzJZL29ScU1lYlA3VXNESU1wRE5uRndXUmdVcXF5?=
 =?utf-8?B?TE1GdjJZc1IzR3EvbUdqRHgyZ3VKSXBra05KcEcweWpxaHNQMHp5UUZuN3Iz?=
 =?utf-8?B?MGllSEsrd2t0WVFDWWRqOWgrcXNRclUwVGFHa0pra2wxMHM4UlIxcHZQRlk0?=
 =?utf-8?B?V0ljdDhzc1diVjc3dVgvV1lxTGxYQ0ZBOGdPQTZVeEZnZlRyUGd2RTJGWTN3?=
 =?utf-8?B?UXhjOU1vdzl0K2hlUml6NHBBYzdwN0JFaDNmT2YwSzFKeis4RDNBb2trRC9R?=
 =?utf-8?B?M1RrOXI5RlZ0WFhXSkE1aHVoL2UrRGdpTlRMSml0WS9ReXMrUHpxV1NCZ0pw?=
 =?utf-8?B?akF0ejYxTjExak5keEVLdXl6N0R1UjEzWlpIVlJjR05rbVNzMlhEL1dtOVFJ?=
 =?utf-8?B?SlEwZ0psT1hjcGQwM0xpR3dlSjQxNWlaalJlQmdIWkFjZ3dFTU12b2tpNGxV?=
 =?utf-8?B?SXlDZzFWQytUeXlTVnZadTN4dEJreE10dHVPb1NTdzZFMDYvQUZESDRyL2tD?=
 =?utf-8?B?bXc0VUdCazhELzloWGhvaWxIMlpwUXIzYjZDS3d5TndTT2swYk1xK0h1cWkz?=
 =?utf-8?B?ZDJDYzJHMm53ODRTanZuZkhDNkhkVG5PLy9HRVVoNEM2VWZsVzhxSzYya0J6?=
 =?utf-8?B?SEFJZ1RBRVlRZ2hmUXVxenZjSkF5c0JGU1hrSlp0ZXBETFprcHF0a0VpeThj?=
 =?utf-8?B?ZVQ2Nk5JQXAwN0lSQXpTQ0ZSYlJYbjY0eUo2aHNaa2NHOXp5TXdCUmx2a01P?=
 =?utf-8?B?YkJCb3pqK01qWll6OUxTRmVLSUJaSXh2eWRiMnRCTzJjcU1vbVg0eTVnQm5u?=
 =?utf-8?B?aWQyUkJBUkx5bDFGKzZLYm4xT2cwZTBxZEtzcWFKYy90QWZBNFY4dTgyU0lP?=
 =?utf-8?B?UDJYTTluU3hsa01zVTNVbU1IaVNBNFFUUnJuU05qWldQM2JnNkVrR3BCOEZT?=
 =?utf-8?B?VnBWTVkzNHNoRDRyeFdPSkxyeE9pVVowM1Z3MUx1K29STDJDcExyUERYbDJy?=
 =?utf-8?B?SWNwTHhhQUVjdnRPOE5Gakp3SEhjVkRkRFJkcVJPSWNzMUpyR0tqOEdIN2Ru?=
 =?utf-8?B?QXFKNzlnN1NxYlRFenk1TStZU1FudEJMSFJoVWZLMi9Rd2lRNjBOZVJCWUxk?=
 =?utf-8?B?VmE5c043c2U4aFJFcHcybWhYUmlQV0FyWHRzZnJPYkxVdE5xUTZuUTh4NW1J?=
 =?utf-8?B?akJrWWV6K05GNFc2UEJQY3l0VDVxQUNUT21pYXpjVFgvZXZLL2h4OHJsMnpJ?=
 =?utf-8?B?OUhCTnRlbzVKamZkNitIT2I5ZkhINldqc2xuVEkvOVM5Q3U1ZE9IZngrZC91?=
 =?utf-8?B?MUpnYU44MnM4V0E3Uy9QYjdXSnlpNXNNd2VUcG1PUC95VUNHYnZrVWpNYlM2?=
 =?utf-8?B?bVFPeE1UUGV2Tmw5NTliY1ZQcFR6QkZFV2lrajlXSVd3R1BJNDl0eG5DVXl6?=
 =?utf-8?B?ODJ4eGhjRlpVUFF4M1M5aVFDZnFZN3dMdU1HbjJucWN5R2hpTnc4Q2JWUnJV?=
 =?utf-8?B?YVEwRitkb2Z2RmJDU2FucDJlN25idWduVWVjYlEraHErMEhDSkw1b0FFYWFG?=
 =?utf-8?B?SlB6Y05tdHhFRjF5cm1PQ3hTaWJaeTNLS2x1b1ZqVXpYTklPNkZIc2NmaHhp?=
 =?utf-8?B?OXhZRWFNa3ZKaHZSbk5PZytRbFVsdHNMOUd4UlBDTFVwZ3ZDTHM4VG1jb1RJ?=
 =?utf-8?B?cmNnWEpVcHhiRWpLU0NxUWp0Nndodm5XOUlIU2srOERDaldqS29WNkE0TFJ0?=
 =?utf-8?B?SDU5RjRaVW9QTDVlMjU1N0F0OFNlbEJxWHlOekI1ZDRwbjBHUDVIM2xrdGdi?=
 =?utf-8?B?SjNYeVlsOTRnc1ZmSFBHNGNrMjcrMlovQVpEeFJkM3VLdUdHSGNCWU9lUXI3?=
 =?utf-8?B?VE5HQkpJNGViWjlwZ25OOENlSEZUdUVndThPSmxBYnkyM2owa3UwM3dlKzdS?=
 =?utf-8?Q?5rkTVfKcpqevBoFCX8T0n0chj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f561f04-bc89-473f-6dab-08dbf696d368
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 20:06:25.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqn5QZyb/L3X9ofNLwLmFL/ZgNbC88WfKTr5Lz74ktSvZ6/aAmlaN0claJkgbTWesc78kD0k+DG1M5tEgKqDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2023 13:55, Rahul Rameshbabu wrote:
> On Wed, 06 Dec, 2023 13:22:25 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
>> On 12/6/2023 12:46, Rahul Rameshbabu wrote:
>>> On Wed, 06 Dec, 2023 11:58:18 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
>>>> following messages are emitted:
>>>>
>>>> i8042: PNP: No PS/2 controller found.
>>>> i8042: PNP: Probing ports directly.
>>>> i8042: Can't read CTR while initializing i8042
>>>> i8042: probe of i8042 failed with error -5
>>>>
>>>> The last two messages are ERR and WARN respectively.  These messages
>>>> might be useful for one boot while diagnosing a problem for someone
>>>> but as there is no PS/2 controller in PNP or on the machine they're
>>>> needlessly noisy to emit every boot.
>>>>
>>>> Downgrade the CTR message to debug and change the error code for the
>>>> failure so that the base device code doesn't emit a warning.
>>>>
>>>> If someone has problems with i8042 and they need this information,
>>>> they can turn on dynamic debugging to get these messages.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>> For the Framework 16, I think the following should be done.
>>> Use SERIO_QUIRK_NOPNP for the device to avoid the PS/2 controller
>>> probing. You can find examples in drivers/input/serio/i8042-acpipnpio.h
>>> under the i8042_dmi_quirk_table. This will prevent emitting the first
>>> two messages in the shared snippet.
>>
>> I had tried this initially, and yes those first two messages are removed.  But
>> TBH I'm not too worried about those as they're INFO. Adding a quirk just
>> switches them over to a new INFO message.
>>
> 
> Right, I can imagine someone owning this device panic-ing about the logs
> in red/yellow in journalctl or dmesg output. That said, since we know
> that the device should not bother with PNP, I think we should add the
> quirk, none the less.
> 
>> But the ERR and WARN messages still come up.  The 3 messages that show up are:
>>
>> i8042: PNP detection disabled
>> i8042: Can't read CTR while initializing i8042
>> i8042: probe of i8042 failed with error -5
>>
>> I'm more concerned that ERR and WARN messages show up making you think there is
>> a problem to look into.
>>
>>>
>>>>    drivers/input/serio/i8042.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>>>> index 9fbb8d31575a..95dd585fdc1a 100644
>>>> --- a/drivers/input/serio/i8042.c
>>>> +++ b/drivers/input/serio/i8042.c
>>>> @@ -1008,8 +1008,8 @@ static int i8042_controller_init(void)
>>>>    			udelay(50);
>>>>      		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
>>>> -			pr_err("Can't read CTR while initializing i8042\n");
>>>> -			return i8042_probe_defer ? -EPROBE_DEFER : -EIO;
>>>> +			pr_debug("Can't read CTR while initializing\n");
>>> I also think this error message should be pr_err in the situation that
>>> the SERIO_QUIRK_PROBE_DEFER quirk is not used. I think what you are
>>> likely looking for is avoiding emitting this message when the
>>> SERIO_QUIRK_PROBE_DEFER quirk is used for noise reduction purposes.
>>
>> SERIO_QUIRK_PROBE_DEFER isn't set on this machine.
>>
> 
> Yeah, I would like to add this quirk as well for the device potentially
> along with SERIO_QUIRK_NOPNP. I'll get into why I think this might be a
> good idea later in this email.

OK if we end up with a quirk for this system in the end I'll add both.

> 
>>>
>>>> +			return i8042_probe_defer ? -EPROBE_DEFER : -ENXIO;
>>> I do not think this change makes sense to me personally. It is indeed an
>>> I/O issue with the i8042 controller on the Framework motherboard, so the
>>> error should be -EIO when i8042_probe_defer is not set.
>>
>> With i8042.debug enabled I can see that the error is a wait read timeout.  So I
>> had thought -ENXIO ("No such device or address") made sense here.
> 
> Right, I think that wait read timeout you are seeing is likely a symptom
> of something very similar to the experience on laptops like the ASUS
> ZenBook UX425UA, which inspired the introduction of the probe deferring
> in the i8042 driver.
> 
>    https://lore.kernel.org/lkml/20211112180022.10850-1-tiwai@suse.de/T/
> 
> In this case though, the ASUS ZenBook device did have a PS/2 device
> attached, while in the Framework device this shouldn't be the case. Will
> delve more into this nuance in my next section.

OK let me experiment with this and get back on what happens.
> 
>>
>> If you feel strongly that the errors and warnings should stay as is I I wonder
>> if this should be looked at from i8042_pnp_init().
>>
>> In the no PNP device declared case it still probes, why isn't PNP trusted?
>>
> 
> My understanding is this is due to some PS/2 devices not supporting PNP
> so this manual probe path must still be taken even when we add the
> SERIO_QUIRK_NOPNP quirk. I think if we add the quirk for deferred
> probing for the device, we can then also have a patch that does not omit
> the error to the logs when this quirk is enabled.
> 
> My question now becomes the following. If the Framework device does not
> want to expose its Intel 8042 controller to the host since its some
> unused hardware on the mainboard, why does it bother to advertise the
> 8042 over the ACPI table? Wouldn't it be better to have some UEFI update
> that fixes the ACPI table listing to avoid advertising the 8042?
> 
>    https://wiki.osdev.org/%228042%22_PS/2_Controller

You hit on the head my confusion.  The laptop doesn't advertise any of 
the PNP IDs listed in pnp_kbd_devids.

I double checked in /sys/bus/acpi/devices.

It seems that they're ignored anyway and will probe whether they are 
there or not.

So how could the firmware actually advertise this so the kernel would 
trust it?

> 
>>>
>>>>    		}
>>>>      	} while (n < 2 || ctr[0] != ctr[1]);
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

