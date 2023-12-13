Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF406811EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442192AbjLMT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjLMT1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:27:40 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170439C;
        Wed, 13 Dec 2023 11:27:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBTK3Ti1OY2+RyIwUUd22OZPBra6WwVhIWK7mi7jgnDuZXfrvVKOOPCZ+hN2b05P3JRYkKXdD2A3bkR5T1pa7sLtZDeQ7jiPSe9m3mKeFozhUr9jfWqYEP8+u8QnCv9jgmYjw2lyHtmAfu/wxEjV0h302LONrEtC8uvVZXbwT6T4J2yMAC88O3r+y1jGdC6rajvHQcHzdfsBDdxDEq1OnrrXe/pLnjTh2f81HhY492IDppjwnys6/BmLP7pw6yojxYam3XWRAUAjN7J5iZ65q0LBOWbOPupkONJp1rOiWRwTzWy9c9QxD5rGAS9EytrlSvuBiaf4MT4sSKWV1Va5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0J9WuRfmk98KWhuC4pV+d+VOO658C5hxxybsqPJjQc=;
 b=PXp0brU8pp6id6GIKjEaXG7x8JLRwKtADe8HiYVEoMq2JqxoKwgE8DNxyB3Bd88pOKd3Kn86ZT1kQrNWBypTM9vnwTcSUZVGiy590VTnJ1HvAwiFJ7hyCVdjBZwECbS+he+mWsYvDha+hGnyNUerBb5qMBPlhNIzI6rtGCXn494eHhS1pwthuuwBaN8Sd5uLaroCOp28ONsIwW6/I59BX+lMCK5wmZMiKP2mnbl41MX8nsMUXnfOpP6oI88RoqikORwKnpgRjECiWVFi7kljxx/pUoj2cSC9eSBXy+YfyYHtbMU2zt4ORbr4W60i4Qcap/hPNJShykKBAGEJ3i2i6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0J9WuRfmk98KWhuC4pV+d+VOO658C5hxxybsqPJjQc=;
 b=Xyw2YbnjVU71zUICzwUflQqUjs/JTRUa4Exxqk4p/pU6nnK4ak0YFk/4QEaI8ef84SS69yhUtkFueR23vnzGR7cqd8bKXXEiJSjTtOWUX/IuH1Bi5Z8F7qLb7w5ITWsSOmjLpkE6WhHONZadqTeVL6vaf9SeAYOcWsM5NkxVvmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:27:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:27:39 +0000
Message-ID: <1ef12773-74ca-489c-b36b-d3cf7da22c43@amd.com>
Date:   Wed, 13 Dec 2023 13:27:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Content-Language: en-US
To:     Ben Greear <greearb@candelatech.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <874jgmnud8.fsf@kernel.org> <ZXmxD1foASMaCDIe@lore-desk>
 <d92c081e-47dd-5c57-a6f1-bd72b2748141@candelatech.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d92c081e-47dd-5c57-a6f1-bd72b2748141@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:8:55::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 28196a1b-379f-4892-f3e2-08dbfc1191d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYHAonz3MdTn8B8S/W0sIRUgWZinO3mx7Q5zRfRKBzWQrxAm5pneQXOarEXnSOWcsno123xOBPJ+sr2xAZLmCGHf/TYrB46XbjiV3c5JzWxhyaM5EuOYOMkRlis1GLXiOR5IQt3+RXBaC+fzFMoGtPJONhK00nJqucUs8aZIXYrHb9O/4A0vwk1UoStNawDNyLv98fHPK2HxGcNh7rh65n7tQQF3b3hB1OTz1i7TL40rt0FmK9h9w1jUogMzc1/z8QS7CtAu12/WNPHqbtBz75+m859wn1i1UWdNcOnSJ5Ew5JfmbsqzZAclr8B4TcWICnPZK9z7LXMP4vGKvVLOrAyrbNp6TmcFGBmWfIK8DohpV6o8iGLykZ9rv9BkZYgLOCUkLxWpfNb/yCVQ9aAyZBVYKHg7kA49Qp42rZqPH+OWck5S8XfvBKxo+TmqIpWucCpJAkGzmskqCM5eBmAXxx/ARypygLCiBcJ6VUNAA+/2BE4BxcZ6AP7Zl3MwalUxdix6kI2z3PDm4x2ER4LvU8+It8D4gdax5hSGdMLfxEaAFd1khvmV4iu5/fCWiqvfpCPfUi6S682/Pc20Ebk92GXigY55zcmqVd4Pe2T2NGK+yozbRKb8NMCyi6dfqqtUFn27vF+owJZ4YkK3uBEa7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(66946007)(66476007)(54906003)(66556008)(86362001)(31696002)(36756003)(966005)(83380400001)(6506007)(2616005)(6512007)(53546011)(316002)(2906002)(110136005)(478600001)(6486002)(7416002)(5660300002)(4326008)(8676002)(44832011)(38100700002)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1YyZXRkOGJBMGc2WHFGb2k1eW1xU0VaQVpPZDQ1WkFjd00xVHgvbHdKVUM3?=
 =?utf-8?B?UG9xMUxBWGVzTXFheHllV1BIYzFCNGxPSk9sa0RsRHFrajYzNkZla0FMRkNK?=
 =?utf-8?B?NXRINlU2enFObXBIZ0hZaFNEdGhtN25BQmRMS0wxeVI2eWticFpEK2RuQ3dH?=
 =?utf-8?B?bFBZTjV5Y0t5OTNPWkRsZm9qSFlrbXBHdzNPcTJrVWJBbVZ2WGdTcGx5U0VD?=
 =?utf-8?B?anBCamRNODYyU25EcXJZUkNjV1NPTE1ZVTNSWWVaYXIwSVhLNUk2endIZmF4?=
 =?utf-8?B?bFBOL3c5U3JuWlR0S2NPRFh1SFRtampxUUVlVVNtK1YxcDNvSU9na2dDZ0lX?=
 =?utf-8?B?NmFoVnpJeU9aUWZ1QlVXSWZOT0dET3NZSUQ2NXRsSE5EYzdCNE1GZWN6SVRj?=
 =?utf-8?B?RXdFMHVuMUdUSlZmNnBwWmh3RGcvTWdmRHYrdmdUdzVCSTh0S0hXKzFTekNs?=
 =?utf-8?B?MHZ1M1hCTTlZVEtsdzVxbE9ja1R0NkJORUhRenptNExYMnBwQldQdkhMSGI0?=
 =?utf-8?B?T0FLME5Ea3YrdWtLT1gwcndpeW9sdjlFTldhZ1g1a00zRWFxNzltQzdrdkxG?=
 =?utf-8?B?SkhUR1p4dnQ2UGVnMGdjb2JaRTYyQU5HT2pyWlhxZG1NZC9jdzVQaTJlYm9u?=
 =?utf-8?B?YVFqdkx2V1pGSTZGNjRMTHlMdFVoU2lLeWpPSmJJN3RFRG5laU5Fcm54bEZZ?=
 =?utf-8?B?R2MwOTYvZjMzQmR3aXM4OHZJdnFUR0UzVVl3d0JtYStxSXJhdk5uTFd2WVpn?=
 =?utf-8?B?c2g0eStsdVljUWdtT0xZbWhhc215aGQ1a0YzOG5IcTcvSHNHL2hYRW9MdE5E?=
 =?utf-8?B?VHNOcGZGbTRKNWNUKytrZWsySG0yZXZzZSsyU0IyaEhqT1dMUlFxamR6RHIr?=
 =?utf-8?B?U3JUdjcvQzFtUE91S2haMS9zckxCQXBMSVpucHJJUE53YmZsenNhUVU4SWdO?=
 =?utf-8?B?TGQ3cFhrZ1k3WXhEd2N1SmhkK3RSTnAzQVJnZm8yQUZDTi9FbDM3MEZpWE56?=
 =?utf-8?B?SVM5L3pNK0EyU1NPaUNlQ2wvNlU3K3Viby80a2I0M1VRL1pPUml0VURkV2JW?=
 =?utf-8?B?dmJQaDRrTVZMMjI4L1V1Z1M5M2xkV0gyVTBISFNxNVpPWlc5TjNRTzdWTURC?=
 =?utf-8?B?M0FMc3NaeTgwb2VaVDVpa0t5SnJKVXJqbDE1WXhSYTJUOGFBYjBkSDdOTDRC?=
 =?utf-8?B?enBtY1A2RVdXU2lDb09VOXFPaHNOMm5tNHJteExUbHdRSjRZdnJxVldPQzNi?=
 =?utf-8?B?UFh0OWlSQkJHN3ZOdFFwbkUyQXIyVjNYWWdJYVBFZWJlWjdxYWpSSHhwNjFC?=
 =?utf-8?B?WitINVFzT3VSbW1zNS9ZN1g3cFNXbE9zSWZKTmJFS3FmbktEWmtzRTdqWXZu?=
 =?utf-8?B?Q0ExbGlLaHJ5TjdQSHJ5bU90YWh4UWhwaU9FZVZrRHBkdE1Oc1BpOTlpTHVh?=
 =?utf-8?B?b0F3emx1Zzg3YjUyaXozYll2VnFGbno2NDBzblhXc2dIdUVNbUU2bkk5SmhT?=
 =?utf-8?B?U0NNQldKREFzanBWeDBRaFBBcXBIa0tUcExsV2NvVnhDRTdrbjd1SkRleFpD?=
 =?utf-8?B?OVJ1dy9jdGpBbHRvT2ViRUE2ZEhIcTRtNWIveXhhNlUxVEhpZzZTUkNEOGFv?=
 =?utf-8?B?V1JrVmdLWmJIaVUxMmRZUXQ1L0xaZ0sreGJGVEFLcEtaNEZIR1IzMExpWGw3?=
 =?utf-8?B?QlkvS1BGM2NzU3h0aFpEV2sxeHBZc1M5My9FWDFwY3NSWTFyWG5MSDFUSjhB?=
 =?utf-8?B?by9EMEN0Ui95R3labHVCTTFXY0YrZTZWVkUzSmdEYk1zSFV1cHQ2dDFURlRC?=
 =?utf-8?B?MGIvNTBvQTlGZ3BqUGN3aUZTQ1FlNlA0TUxQVmJzeXJ6bW1xT1hjaWFrUGVL?=
 =?utf-8?B?Y2JsVk53YlFld25mZHJSWUx6MDJTMXNkM3BvT2NCWWVEWmg0Y01VYi9ITVlq?=
 =?utf-8?B?ak9nOTVjcGN2WEZ5ZVNUcHdMUVlLQlh6QVVhQW1JNU5QdE14amdSKzdibld0?=
 =?utf-8?B?aFBsdDFWMldXWmh4UTB4aTZ5WnYyQ0h6akZsV2dNYUJHYTN2WjFEVjVUTS9o?=
 =?utf-8?B?WTFvV3o1Y2E2MVZwOS9YZkx3VXlGMWRFL09GQ281WnZQdTVyL3R4TGJ5WVV4?=
 =?utf-8?Q?YC6HX2fM4c+7xGmPNy8FCHcfU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28196a1b-379f-4892-f3e2-08dbfc1191d9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:27:39.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FmA9nJyj/w4XvS61PNZ9ydv8yrBqc+Pbv4K7yJarKw4kXk6VjImHCkrXU4+2ZqjDrJ7vp9WkTU7GvLsb3XAwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2023 08:45, Ben Greear wrote:
> On 12/13/23 5:26 AM, Lorenzo Bianconi wrote:
>>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>>
>>>> Several users have reported awful latency when powersaving is enabled
>>>> with certain access point combinations.
>>>
>>> What APs are these exactly? In the past 802.11 Power Save Mode was
>>> challenging due to badly behaving APs. But nowadays with so many mobile
>>> devices in the market I would assume that APs work a lot better. It
>>> would be best to investigate the issues in detail and try to fix them in
>>> mt76, assuming the bugs are in mt76 driver or firmware.
>>>
>>>> It's also reported that the powersaving feature doesn't provide an
>>>> ample enough savings to justify being enabled by default with these
>>>> issues.
>>>
>>> Any numbers or how was this concluded?
>>>
>>>> Introduce a module parameter that would control the power saving
>>>> behavior.  Set it to default as disabled. This mirrors what some other
>>>> WLAN drivers like iwlwifi do.
>>>
>>> We have already several ways to control 802.11 power save mode:
>>>
>>> * NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')
>>>
>>> * CONFIG_CFG80211_DEFAULT_PS (for kernel level default)
>>>
>>> * WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default 
>>> setting)
>>>
>>> Adding module parameters as a fourth method sounds confusing so not
>>> really a fan of this. And the bar is quite high for adding new module
>>> parameters anyway.
>>
>> agree, I think we do not need a new parameter for this, just use the 
>> current
>> APIs.
> 
> Is there a convenient way for a user to make any of those options above 
> stick through
> reboots?
> 
> To me, the ability to set system defaults through reboots is a nice 
> feature of
> module options.
> 
> Thanks,
> Ben
> 

Some userspace has the ability to do this.  For example in Network Manager:

https://unix.stackexchange.com/questions/595116/wi-fi-powersaving-in-networkmanager

