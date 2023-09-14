Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0A7A0779
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbjINOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjINOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:38:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A11AD;
        Thu, 14 Sep 2023 07:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8JBWH8+K+JLu6WS3laQReDKP17VDEo/CiJrinLkhd5UEp3wEcH8BQMYgVqbMpU6x7Dpd7p/WIrEJL9bfU3Gak2xpT2T0ewcVl0zBp2fhu7UYSRC10n6b+upohFEz0orXOzvO8aYbp25TKdBvYOTcDsSDi8D1W0FTIa3pC9becr+n4dlPq5dGE+nLFZgIw/6l6lCW9LnHdqqled0QmBiTm3UYhewq1TwW+0jHUD4bmwfL386/VXM+z0tBotxCBCWfgcXFfazK8952Zzler0oTsdM8L94eCKNauToBaUZbcVcUxVdQC54WOpTWJVeYPMYlEDserwL5IAWPpCJNLXlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEi6d4dg1gtAcFz8tzW7yduRqzbLZ66rrWvMcCEXxog=;
 b=n+QzLZFhE8Nw5XsE8eFVWnSCh6lONBO5jCiFQMgW8qitp7C/U6YkDCfd2UfepwRj807msrXIaBigBd4gX+OZkD5qoKNYcBL59T7q+OMKcDjQvQwg96AnVVHXzAVYQmuPzbLYMqO2+F8b1JjVV9nPwBy5ziSQadGYLgloYkG9tv9ukK2xjIKctLjG8gd16RhZMklUb40qTSbHQ9cUlaYekOZBgs+4Ftvy9Eg2HzsTmrxIlISwhvR0yGegmFKPkDseaHTUgBiY+xp+ytPCz6WMc4SeNfAGdnpK8T9lAAU0/twPEHBGc97lzEKrBIre4aqp+g3zId+ONPfFMkYjCtk9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEi6d4dg1gtAcFz8tzW7yduRqzbLZ66rrWvMcCEXxog=;
 b=wnIT9Bu/Q2UPzir0UFJ2hMCAfSdGM1+9BYwdXOHwb8mi4eR390PoFksofLan0Nf+H7KYx3lvBwZAAkP5VwX3CsSKYgavxUwcqJwmNf7E2MSpeu8J+8QMtpDcvQXeLK5ap6tzAyKcaSeRCui4gd/peT3aBgHK40pHzeGz4mifR4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:38:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:38:03 +0000
Message-ID: <031c2a8c-7bc7-4ab8-a288-136eb5a78865@amd.com>
Date:   Thu, 14 Sep 2023 09:38:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Content-Language: en-US
To:     Luca Pigliacampo <lucapgl2001@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, regressions@lists.linux.dev,
        Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
 <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
 <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
 <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
 <b9f879d5-55b8-401d-b154-8066cb66d20f@amd.com>
 <0522393f-9f0c-4c59-b961-9b8d865a645d@amd.com>
 <CACRpkdamAs=c6YBW2jgQ48kUPHqUGT=b89NSXYYttf0RbnpctQ@mail.gmail.com>
 <65ec6171-b47e-4d1e-9bd7-a61f2acfb959@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <65ec6171-b47e-4d1e-9bd7-a61f2acfb959@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::29)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b624130-f24d-4272-7d62-08dbb530339c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9/UnkJn/2903g7WikthZipWeZ4iCmPrA78ka07oSz+CsE2Crk6K/WktR3NkrNRSqSHk2jKse7nZbJy++WkDLLKlhZPOT4/GdsUQkL/6YuKnJyWnelWJ4veW8upXQC57lD6VDGB322vzEbAYp16Ea2hWwCIzMzhH1d/hnr26a0aRNI02nQC5ZxDMn3EhpCAfYrru/br1bRyjmFUgSRQocZpDuHz84LiaUTisWx1IgPYQG0HGJo3Xd52tb6NA2APcXLFoAiyuj/3rsSRtXaoUPkrf+fq7myTJwRJtS8V5JY753gYutqfVc6tDP7VxPi+TS/gsOEWmPhEBDMJ+FBEByScju+9F5bYRnCPRRUQVvEcRpz9GxOS6d+ADNJZjFAI8v0dZWFmma9Rukh9li5fBMto0WbfDPgLmxhuOcAVJqpXAzVg+nu7d0px3+IUzSDW9Gvkng4WjIhyERU73m4giSPO/Tv809qf8f2WDRck191rOzbuOCmEtp49bLJrLW88NhcuhviXtzsVM11iaAOP5VcCMsH5Wzd1a4ApxPck6PsY5mAuTl9CFzuwUPliFA+khwW+fllL3fCWwNolQy7s7JqQLsNiniBN2tIY2f8t/3Jaogkef2MTl9R9cl2wWE3zb05jOUdm3YXLrMSpU44yB8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199024)(1800799009)(186009)(31686004)(2906002)(5660300002)(44832011)(8676002)(8936002)(41300700001)(4326008)(66476007)(66556008)(66946007)(26005)(110136005)(66899024)(316002)(478600001)(53546011)(6512007)(6486002)(6506007)(83380400001)(2616005)(36756003)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhLZDBDZG1xNGRKWW5kdE5tbFhZWDJobnhRYWluUnNJd25mRnVGRkQ2V3Zl?=
 =?utf-8?B?R2ZuWkM4NjRzejlCb0pxR0toVkNrMUpJMUxMT2dxUzFHTVo1NHV1bVVManlE?=
 =?utf-8?B?eWtaemNDZEh5bFA0UUNhYUh0cTdRZ1BDdGtOdjN0Y2lwUUY3VzhqY0poSUta?=
 =?utf-8?B?eC9FYXI3SDlXM05kSm52dm5SMjVtS2srSTNlYkF2dXA2a3JaS2hvQlcyTWxv?=
 =?utf-8?B?aitBWkJjVFhzRzhqM3d5RDdDYm4va3dYUnFnNnVOaW8yZXozbFhMUGNSZlVJ?=
 =?utf-8?B?TjFnSUxWdy96Q2lUR1J1WjkrNHNGY2NpVEdyempTekRHb0ErOHNUczVpZE0r?=
 =?utf-8?B?NlpYK3lKRFNPOGF3eDIyQkhxSTQ4bzVJNk5HdVhCN1M5UVFqcXViV3JIMllq?=
 =?utf-8?B?ckhUaVVyYWdCQmNNZG1rS1VmYVZoVlNBeGRKM1N4elB6OXZtbEI4ckxUR2g1?=
 =?utf-8?B?dFFveDd2VTRuUCtVN014RVJlaXMvajRvUmVEWGQ4ckJKOHRZM1BuTmdkNWdH?=
 =?utf-8?B?S2ZLUVAvb1JVWlVvMXBwekpuK0FGbGo3UjRYN0pMdDQySWYwTGZTMlpKVzFQ?=
 =?utf-8?B?aGFQWmZrOGRzdWY0QWpVNjhobVdobHRIcEoxYzVVcnl0Y2ZiOEtiU1BSWUpF?=
 =?utf-8?B?Vk5ZaXVBQ0RBbnpTRnBtUU1ubXNzV1M2SE9PaEFRdlZWakRBSmMzcFdjbVFF?=
 =?utf-8?B?b2ZFWWFBWE9pTVNtajJibWU3OHZsVHJrN0xLMUxjM0Z6djhBK2hOaStxYW02?=
 =?utf-8?B?S2YyVHZ2M1pxRWJESDIyWUE3YkN1ZmdoQTBwdTM2SGRSQXhqQ1VEQlE4SjNs?=
 =?utf-8?B?c2NDQm9vR0pwY21zWkcycmdNbFJVWGF2UmRjTFBNZGkvdVRLb0lGS0ZZYXJE?=
 =?utf-8?B?Z25WRGtDTVRlOGRCRHkvOXJpWS9VVGlVaXNDOXNSeU10VkVPMW1FWEFQV1JE?=
 =?utf-8?B?NVZ5UnV5SmxsMXg4cVovU3dvR0NIUFlUUkdXNUk5WTF3OFB1WkU4enhtcE9I?=
 =?utf-8?B?bm1tcS9RV2dVeG9FUHlCSGxadG1qaE9hT1d0d2JHVVJnQTF5QkREWVR6c0lB?=
 =?utf-8?B?eTM3ZTB4S0dNRm8wM0xyREV1RlhBNU1CYitkb2NUajhVRjRDanEvb21HWlVC?=
 =?utf-8?B?TTdhWHJIOUtIaHhBdFJtQjUzVXlXcng3USt0cE4zWFhoLzhMUUFJWElSdzRR?=
 =?utf-8?B?bm8xd0Q1a25GUDhFZ1FGY2daaHJqV0FMWUVvZ25MK3dMMDdwaTd6UWxFb0d0?=
 =?utf-8?B?RWJIYjY4MmhmK3Jyd0tzNTAvWkR4SEtNVmxuQ3pKS3BTZmZucDFLTGpTWGZw?=
 =?utf-8?B?amIzK1JyajNyeG1OZXpwSFRUenJodjR0YmdWT0ZtT3d1N0MzNmd1cm5IRE9a?=
 =?utf-8?B?cHhhaUVDR2ZrRDNLcmJTc2wycURoMEJWL0VpdFN3OE9VbG4wYWJWSFltZVNI?=
 =?utf-8?B?UW4wL0J1NjFiYnZnUjY2OUtISjhNTU1oaC9rRjlKZURlY0c0SGVLdHk5UDdH?=
 =?utf-8?B?Z1R4RnhxeUFZK3BqdVQ1TkxOaUthanZEem9DQi8ybWxNNU5aa2VXZFBYRXZC?=
 =?utf-8?B?SlIvaGZ5OENCUzNLUkVscHB5Ukp5K3o0UCtUMGpnSmxhK2U1NU0vQ1krSUxN?=
 =?utf-8?B?ZlVJNDh6Wk5LTmhkS0NNMVBDdU1JR0xDd3VWTUFBVndNdWdSS1FvU3hEUkY4?=
 =?utf-8?B?UzdZdndneS8zMHpWNDh5MmJsNzB0VVE0azg4MFhzamhqbDZpNEJuSUExK1FN?=
 =?utf-8?B?a1dCZjZla2dvK1VBYjU1ZTFSNGxlOGYrVkNhMFJncTVTRVlFd3V6Zm9RS1VI?=
 =?utf-8?B?bU45OWVWTzBSMlp3elNCaFloQVp1eG1hWHRGR3grdGgzN1BZc1I0MCtWTXVI?=
 =?utf-8?B?ei94SUNpNUU0eG84Y1pIcjVXRnk1MnJ2eUR4bjJQUGl0SXNJKzhmS3dWeHky?=
 =?utf-8?B?aDZNdG43eEh2TXQrRTM1djE0N1dON2RYUDdtbGVaOXhMS09CdEVhbnBBb0hK?=
 =?utf-8?B?L3BEZmcyZi9ESVhYWkx2dmM1UE8zYVU0VVc1QTVyME9wZ2lWZ3UwWmhsOEtv?=
 =?utf-8?B?cXVnUmdBaWJQd0FQT1cyNHk5Sm5mWkM3ZncwNkg0alc0UjdiZ0NRRTRUNWQ3?=
 =?utf-8?Q?9HJ1nF5DXDtECx75uDat4Lzvw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b624130-f24d-4272-7d62-08dbb530339c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:38:03.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5Tl69EgbT+AI4taD4hdRIPlt1InNWSkUSHIsj8qHqLDPWHG24O7kYAbhTDLP7c9pvfVj9I75Qvlz6qD0zJA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2023 04:08, Luca Pigliacampo wrote:
> On 9/14/23 10:43, Linus Walleij wrote:
> 
>> On Wed, Sep 13, 2023 at 11:21 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>
>>> 2. In better news updating the BIOS fixed the issue in both Linux and
>>> Windows, no kernel patches needed.
>>>
>>> So no further work will be done on this series.
>> Is it easy for users to update BIOS? I.e. does
>> fwupdmgr update work?
>>
>> Or does it require flashing special USB drives with FAT filesystems...?
>>
>> Because I'm not sure all users will do that. Or even be aware that
>> they should. In that case detecting the situation and emitting
>> a dev_err() telling the user to update their BIOS would be
>> desirable I think?
>>

I'm not sure how to detect it without giving false positives to users 
with no problems.

>> Yours,
>> Linus Walleij
> 
> sadly it's not convenient,
> 
> the only way lenovo offers to update the bios
> 
> is an executable to run on windows.
> 
> 
> So a user should either have a dual boot
> 
> or install windows on an external drive and boot from that,
> 
> also the update process might wipe every boot entry beside windows.
> 
> 
> I read that some bios updaters also run on freedos, but i didn't try
> 

On some systems Lenovo offers native updates for Linux, but I guess not 
this one.

