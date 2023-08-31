Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73178EF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjHaOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbjHaOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:08:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42618E8;
        Thu, 31 Aug 2023 07:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKTQ7mN7B0m1IA3+gpstpeSpKMizlK4uVV8LlwlfSDzB7OsoVFIrAwgPzO8RgV3FaSmDhE1Bf1w+DXZ7zehv3EFVqMr1lPeTfSMFvarEvE9fIWHU1sbnEAoymBQtAT8kSAZ78B6OU2/irwBJVY6oCfVikZUMBuryVXa9rbH0pHlTHl9vTUBjUquILGQEawqXp0OLld4Wf0hQiWi1gxuo7B+hkLUMNo3CEqorZliR9rh3w4k7XFvhJHqzddg72Lt+4sb7S23dDv5Td3STOaLY3Z5nzR/tI8RSQdPhPtQ0ZFO+fAe1ORqg7/HNHshwiA6aRCtJq3aSwI0m4Ijq1V+bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+6J/SBTnfomLD0rn2r+T4OZmNA457gu8XaILmAediI=;
 b=d/vpCy9f4eZfRYtydHtXP1w6AyCBsMeO2JF+SFjszjxcs/G8jJlOphJgB7NUP1zePQ4XuqV+zcCEnkWi09I9hUt3EWs6JQ+VMKYwI6fmwC1I5aC8SAZIDUDdONyBX2+DiI/cQ2Dx8mIcg4qI3LXxIi2TnR/t4IoPdAuE/b0SGHmbFbDtCAIgbkvFMpvvDhu8Emf8T3IVXBKj4Fz/kkrI68DNhifBpF3Fb7SndzWKv7UrmDKwR3P/lg5tlrCimtYXBMCspgfzcGDi8vIf6STmzB9J80hg/c1xuicvw+BnZa/7CCwEPJsCJB/+3tzzw3igXZZJ7LLczh/B7tr8WGE6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+6J/SBTnfomLD0rn2r+T4OZmNA457gu8XaILmAediI=;
 b=lIvFHe88GUT5cl14EIxxF/ybBob0m9ugYP4Vzh9u9pRx3ckM/1IeXUs7OAnxIfpwOk3ZgMiEHBK/FK/KZCZuSD/Fw3l+HDeUHpxRJ8aGUyoOn7nt2+q6HxuguWTxb00aAUopmjjqf/wLTSmQCNf227zuX58zF3hFPToeQWkqZgqlLELJrMh1pjnvLaKW4Cyr3LypmHq09+e2xe1XmV+IzwK/tJsiLUq18NUtuQhLCr3U8e70AWKB/d/wopMPlTCenu3kqr+MzEmNS27GT+2uPgGaYhaCRPzAPJ5eMvBuhEn1QvJNp80X7ChINqxHAGYQbpOXWhA26+QxcuwPg1+C9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8714.eurprd04.prod.outlook.com (2603:10a6:20b:43d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 14:08:15 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:08:15 +0000
Message-ID: <acf21174-13b2-1114-28f2-2b2f3c038aa0@suse.com>
Date:   Thu, 31 Aug 2023 17:08:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND] USB PD broken on Lenovo P15gen2
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.com>
References: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
 <04e8de7a-55e3-4d12-921d-537750fe6217@suse.com>
 <9841c4f5-614e-bfff-e725-2398fad4e927@suse.com>
 <ZPCYiMEzEUZrv2OR@kuha.fi.intel.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZPCYiMEzEUZrv2OR@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0040.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::29) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5a0ef-6453-4861-0172-08dbaa2bb7e6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyNNm7TdJnYgvsUV71XHCgWV/jTNiZdKX/CHhuxCS7Egtr4fEA8SVGPWlWDtxOXr5J5dHsasvrABA+X0t7X0mRFMwh9oGyRiOxkYL6ADLyPalTr1yKK6dJm9Jav1VbSD1+97KTG7lxmSg91leCG+1V+wTrqxUspgLlg0W13OtVxuS+vCYuPUSLadJnOPBydYmtW5brjVIDLB+GeCV7GCXJIF5TeIllnxT9e+lwbD0+2GzEWF9nOO/oxS4SzhmQ8fKKDP94Qw9J1OHvVzRvTW+IMt07tmrm+D1d+EGSsdcevM2tHam8yLN0HWUpyI0KFawY82CeP5Arli1yG3lXhjICdwIaD1Q6UFIuUbYcf4i08XxffC4bI+gOD5tX9fbrz1QrJzt8Ni1g+b0xKTrPBwbjDmGtfxBpVlsOLXKhffBQCtyDf1BVK5+aGkHqUXHuGEQF3FIiMb6Zsprm5ZdqxMZjw0/m1+xpmVp2D16Y7cy2i4yzhNk8RBWRbODbF1RWV2UMMi42mrc7NWtlWpJJTGeMG07ZMPT8Q0RBLfjXl9UVex+zCmpHysqWs5jqjMYs+4qcFgbJZquHU8bjmWphXsnTY5amEKQfzQnic0iWNg+h6gLH6RZ2zA6hXDZHLJYSRzzlWXZXrIT+0mdxgc9fZ9HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(41300700001)(38100700002)(6666004)(31696002)(86362001)(478600001)(2616005)(83380400001)(26005)(107886003)(6512007)(6486002)(6506007)(66556008)(66946007)(36756003)(54906003)(316002)(6916009)(66476007)(2906002)(4326008)(8676002)(8936002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdFc2YyMzlNVGVDam9xM0xvVzNhV29iQnhTQVFuT0FnU2ZZcTZoL2hZZEx3?=
 =?utf-8?B?a1VYMkI4bWQybm0xTTdVQ2ttM2RzL0MzQVUzZ29ETEV3QUVuRHFLeWxCSitl?=
 =?utf-8?B?dlc5YTdaMEhSUjBWZWJJNU43Wlh1bFM3M3lQMmlEWVdzOHI3cHZQRUI3T3dE?=
 =?utf-8?B?elViMWsxVGppQ3l6MXEzZTE1REw4dmFjSnZZaUt1ZVREaDVxaUswZjJvNGVr?=
 =?utf-8?B?SC9GcFkwVkF0MVpVSjkwYktiOW9ZV2NRVk50K3RVMDZrK2NIR2NxQkVPNHkv?=
 =?utf-8?B?Z2RkOUVtbjVvNGxESUhrZDVRTE9BU0VRRS9WQmRDV2c3bFV0bzBLVlhwNkRR?=
 =?utf-8?B?YmYxb0poYnAvdjV3bTdwMFBhNDA0amxrMnhIMGExZzJRUXgxT0dxeG5uVnln?=
 =?utf-8?B?TVRqTEhIUkx3aElGbFZKNXVyc09sc3BBeHdObERHdmpVcEIyb2d5eVZLUW9C?=
 =?utf-8?B?YjZEVG0xd1FJa2dPTmdBaW0weTlFYnd5OHk0dkk4WC9wcGxjdGlEM2xjOWlp?=
 =?utf-8?B?UjBIQ3AvN2hnNW5uRUpINWp5dnFQU2xyeVNkT0dwbnhNc0lHdlF4STFlY1V6?=
 =?utf-8?B?WmUxOE9WaGNVb1RVcFAwbVlWcGJiR3FMV2MvN0pqS045Y3J1eFEzejAvOVdF?=
 =?utf-8?B?OEtXaVpNb2JRN0xpempnRGFJK1hLMmxYWmdkQmlUTHk2ZkdHTkNwM2tWVWhl?=
 =?utf-8?B?Ry9yQm82bWFGUlppTFlialNpZUtMU0o3aDBoSkFtbG0wTFQzNzR2ZzBxWEc3?=
 =?utf-8?B?K0pqeHlWM0FUS25CVWgrK2lINXlaR3BZR3RuZmlNdDdoMDlnOEZzcC9JZ09n?=
 =?utf-8?B?cjl3YVVQMHBtSEdEdGdRdGdSY1FLWExHbEdwUklQN0lFL2g4YXBFMzJPVFRR?=
 =?utf-8?B?M2lKd0F4cmNpK1VKVG1RRHdSRkVMS2hNdDk5N09zUFdxWW5nUElhbWJSYmlV?=
 =?utf-8?B?ZFBsZGtra013MTRRb3VCUjRCdUVDNmg1RGduMjh6RldXUitTOUR4NkhMS0w5?=
 =?utf-8?B?azBZRHdIaWgzMFE1YWdneGUwLys4M2h5QzVDSGlLL1hwV2p5aVVYKzBmaldR?=
 =?utf-8?B?clJJU2c5YUVTOUFaZy9pd3hWQzhuVUlnaEhqeWFOT1R1L2FCcEtrTzhqMUta?=
 =?utf-8?B?cU1iT3hRekhiSnFZN3dkVlArcmVKWEpJMHY3Y2ZzTGFsV1FOTmhySkVISXoz?=
 =?utf-8?B?S29DU3JablRETGNRakRGVlI0aTJMZGQvOE9DMHdhdms3YVk4UnVBdTNNamR6?=
 =?utf-8?B?RUcyVEtaYVRReDNIYXJzaGE4SnNVeXFIbnlhaTN2VlRRQTU4WlJNT3M1Qk84?=
 =?utf-8?B?a3d4NHRSVnBSWFNmeHpwMExKNkxtaXZEZytNWWVRamMrZTNzR1JFSG5aYm1V?=
 =?utf-8?B?VytnRkpCMFFYVW1pdUx5MWppZkVwNUs5VGRPNEFkdS9iazBkS2RLbTJLUkJv?=
 =?utf-8?B?dGVmbmpnNnZSNTRLaHF6cWgvdThkRk1ZRTMwNDVNMEtWWlprTThjWU10b2xY?=
 =?utf-8?B?dHl2bUhITFNRNDZiSnh5bndHdmxuczlBRUxKcnFnd2RadElNdjE3NTF5aDFr?=
 =?utf-8?B?T3JPUzRvc1VsT04vQ0QrYm5ETUFza2V3b2Z0R0FmdFY5eGNXeTg0ckRMM0U2?=
 =?utf-8?B?U2xVWjNIek0vMmsyei9xV0w3Q09PM1NQdFBtWVpwM1ovcGtacElYQ01UUWhi?=
 =?utf-8?B?UU51MllPVGx1OEp5VG1RNTVkQndqYUYvT3dZbUJldWJJZWhXeTBBb0xHRXAz?=
 =?utf-8?B?QldIb3UyMndvMGNTTTBwWjNHdzNnclVNOFZqdjJVRmExTXZ6ajVYVW1hMkVw?=
 =?utf-8?B?bzlydjc4Y1E5SGxDMGd1cWhybWd5eEIzdWQ3S0E5S2sxTUtNcnlsMVhMTDBQ?=
 =?utf-8?B?bWVKQzl1QXgxNVVxSWtJbzcySVl2dXNqNUpjSUYyaitOdHF1ZWhEelNHRE1R?=
 =?utf-8?B?L2Q5cGVXK1l6SkRhb2l2UTgxZUdqencwNEhwU3ZTazZ4RDBQVVFyUXcrSElI?=
 =?utf-8?B?WDhIS1NqbllKTUFlbkVlTDRZeVdWV2RDN1JEVTJmZW5pVzFjM0tVNDFXSkJY?=
 =?utf-8?B?UmtuK1NxK040RUNFT3hUTmVxZWVub0o5MTFzTzJCc3ZONVNQeS9ZNE5HMmVp?=
 =?utf-8?Q?gAew96jTASLwMHRFARJE14Ucq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5a0ef-6453-4861-0172-08dbaa2bb7e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:08:15.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVPr1HfwpOSAY/Usa6aLupCKj+L3TXfrQJynQN5RqI1EzybkP41a5oro/SOLTBSIJ57kI61wMD87eWI1L/ZjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8714
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.08.23 г. 16:41 ч., Heikki Krogerus wrote:
> Hi Nikolay,
> 
> Thanks for the report.
> 
> On Wed, Aug 30, 2023 at 04:07:55PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 28.08.23 г. 17:52 ч., Nikolay Borisov wrote:
>>>
>>> [Resending as I had initially attached  a full acpi dump and it got
>>> bounced from the usb mailing list]
>>>
>>> Hello,
>>>
>>> I'm not able to use usb PD on a Lenovo Thinkpad P15gen2 laptop. It's
>>> equipped with 2 thunderbolt ports and a usb 3.2 gen2 usb port, all of
>>> which are supposed to support PD 2.0:
>>
>> <snip>
>> So I've been debugging this and what the PPM reports is the following:
>>
>> modprobe-529501  [004] ..... 33507.058332: ucsi_register: Supported UCSI spec: 100
>>       kworker/4:0-524223  [004] ..... 33507.486591: ucsi_init_work: Connectors supported: 3
>>       kworker/4:0-524223  [004] ..... 33507.486592: ucsi_init_work: GET_CAP: USB_PD: 0 TYPEC_CURRENT: 1 POWER_VBUS: 0, POWER_OTHER: 0, POWER_AC_SUPPLY: 1, BATTERY_CHARGING: 0 bcVersion: 0x102 typec_version: 0x100 pd_version: 0x200 PDO_DETAILS: 0
>>       kworker/4:0-524223  [004] ..... 33507.682726: ucsi_init_work: [Register port 1]: OPMODE: E4 flag:1
>>       kworker/4:0-524223  [004] ..... 33508.850438: ucsi_init_work: [Register port 2]: OPMODE: E4 flag:1
>>       kworker/4:0-524223  [004] ..... 33509.986672: ucsi_init_work: [Register port 3]: OPMODE: E4 flag:1
>>
>>
>> So all three ports support DRP/USB2/USB3/ALT_MODE and they can be a provider.
>>
>>
>> I find it strange that USB_PD is reported as 0 yet pd_version is reported as 2. I contacted Lenovo's support and they confirmed that this particular model indeed supports PD 3.0 on all USBC ports.
>>
>> I see a couple of problems with the current upstream code:
>>
>> 1. It assumes that USB_PD is valid because the PD version from pd_version is being propagated to several places (like in ucsi_register_port() cap->pd_revision = ucsi->cap.pd_version;)
> 
> This part should be fixed.
> 
>> 2. When typec_register_port() is called from ucsi_register_port() cap->pd is 0 hence the port->pd = cap->pd; assignment in typec_register_port is a noop. In fact I don't see where cap->pd is being initialized since we initialize con->pd when we call usb_power_delivery_register in ucsi_register_port().
> 
> That "pd" member in struct typec_capability is optional. It can be
> used if the driver has a set of USB PD capabilities meant for USB
> Type-C port ready before the port is registered, but in UCSI driver
> the PD stuff are registered after the port.
> 
> So I'm not sure there is anything wrong here.
> 
>> Is it mandatory that GET_PDOS is supported if PD is supported, the UCSI spec doesn't say anything other than GET_PDOS is optional and signaled by bit in the GET_CAP call ?
> 
> It looks like nobody ever checked is the command supported or not
> before using it. That's a bug.


If we assume support of this command is checked based on the respective 
bit in the optional capabilities member of GET_CAPS message. Is this 
command actually mandatory to properly support PD. I'm currently in 
contact with Lenovo as it seems there might be problems in their 
firmware as well i.e what they are reporting.
> 
> thanks,
> 
