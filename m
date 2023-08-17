Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA69977F342
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbjHQJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349622AbjHQJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:28:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED9271B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY5yN+ziHYi+/OeJn7ipiJ+9/WsyVytpwOqyrnbpDqhi/A3K6IZAGOgNRS4uWXFzbesgoPTtORnrL8ePuCOFWqRsC3tRCoCW3wMeCmf+LxDB2c8oo+ZrfwxD3L6LND2rRaBKH/B3E7ko0Nc0fEGsqV3ZjHGVX1f9ubCwE+8I4IesEFYluhfl1LvXJFP6GOHBVf7v7fCyAEgxz6wRgEVvRNuoZW/2huRyp1cBUTl6ylRujrdFRo8dFjq5mhY3tq0iy2hx2sMGNgsKEQ1vwRzRw1H78imF1KIgurQid3T2sBPqlDGoc60svVuCqwqui5XpjwkBeFw7c9d70DpKGqcnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6sGhoczp/hnubWp0ZP1lyZmuuVsjKRCBXxmVJgw/Es=;
 b=lJybumRLogiIImU/ch+Mj9KJKlUtdbd/YXDAndFduec/7Ox8rJDKxSoKKiQmpL2qxMz1hM2e6pTCGY54h8NAPtR6n6iMSm6H/eN+cHyo3/yvdpLnqM1rEnSBqWPZ0bI2+CsCHy2Z+7fTOthtjNq98/5THDI/LH0lbI82gd71kGmoO/v0N/z/HK/Z6B+fmm5pPc/bh28LYsUS5CaMOg6srtnXh+eWRMnT16qK2lpN+8OzROng7FVQimOS2eqhvIBKWwqqV0V2lJkKXAk9YQRneY/MRIYvoMUd21jKliLz/5ENcyyQXZfLjDGbQAg5QI/8rSlI1Ars+wc1a5nYD2Ow6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6sGhoczp/hnubWp0ZP1lyZmuuVsjKRCBXxmVJgw/Es=;
 b=IYWA/uCoJZSwP9Z+tk2vjP4OVR/svAHOCRkSdPOTW0HWIvnDM2RcuUD01oxgJPanwMLrS7JWkl8a6xJRkYtquD1qWAYLqOP+4jniuSfI/LwJJm7/spUe2Pd63NugdbJTcJh+ay8rmmruyUJjr+lfcaCGmG89+SAlddymBrvWMtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 MW6PR01MB8221.prod.exchangelabs.com (2603:10b6:303:248::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Thu, 17 Aug 2023 09:28:03 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 09:28:03 +0000
Message-ID: <0c5fb304-8c69-80c3-6f1e-487828554244@os.amperecomputing.com>
Date:   Thu, 17 Aug 2023 14:57:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] KVM: arm64: timers: Adjust CVAL of a ptimer across
 guest entry and exits
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com,
        Christoffer Dall <Christoffer.Dall@arm.com>
References: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
 <20230817060314.535987-3-gankulkarni@os.amperecomputing.com>
 <87bkf6oyyt.wl-maz@kernel.org>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <87bkf6oyyt.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:20::27) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|MW6PR01MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e1cfc7-74a0-4db8-b984-08db9f044169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QDuv9hulxHl7CrELCoAkw/IuFaJ51QUKFSxgTD0YpkPEnQf1hMsUImHloWMbEbeXnKTqBY0VpylO4ro+bB8ViULPTKn5kffTzrssefXIoHMv4EHtWIMLPxlQoKAbtPwY7PuzVz/syzuBEZHTMKPD6dXWaQ98EIFRbx7W2MKt63eOBwfyp/qTIyIgAyj2LaVaaPyOuAvtkQRlZEFWgCmRl3bPtCxQBzb2nJfTrpEuSnbR7+rNqc7H1qvrD0CYElMnIcxIiLaIhGQ+FgtdmxpmOo5mPZDF364TO1D8KMdCWfqX/DbvhMMqtqAyYlXoaiT9C/am9gDWsUZJM/vmpCQzqJnf2cF1e3oMY5TpgdSHp5E7aKHV4DCAGuuxKbH54SnXq4+f8n+rchGy5cGTMp7z/a7BgvB5qLgohn99vgoqFFhedAsIhW0Urk8IeBDSTFhLKCFY/w7/MFgjLbQqvxvkDuXQYyhbtLqxNjdvqQhC3eOfqApgm/VN7NeobNpVtylPbrbJV2KMNgnH5/TRKjQI5DV3QUqPaVYcC0hVSbXBroiY+0FIq2uUnzHg3VEAgG+zYc/BmyJGt3s+5Y2nyjju2ZL85F2AMiNEfn2PIqcm9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39850400004)(1800799009)(451199024)(186009)(31696002)(2906002)(83380400001)(66899024)(26005)(86362001)(478600001)(6506007)(2616005)(6666004)(6486002)(6512007)(53546011)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(6916009)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZoTHk4UzE1Wit0dlNSQ0NPRDdLQVVLRmNsQjl2a2FUQ2p2UHlIdUxxVjRi?=
 =?utf-8?B?OElIRzVjQXUwdFVDT1FEejgxRGVvTW92WWxSbFN5QS92VWdSZW43cEplLzNj?=
 =?utf-8?B?TU9YajFYWjRycEZ6cDNXQ1FYODFuSkhFL3RlamFZbXR1U2JMdXN2bkVhNmJq?=
 =?utf-8?B?bmNDbW01bTdrYWlxV0hEZC9FTUtqNUcrMklqaFJWbm5qdnhrNU8xcTczZWdH?=
 =?utf-8?B?UGJSaHRYR2x6R3ludE16ZE1FM3MzYzkyOWVQTkFZQWxRdlZ6T3NNQW1qYVkz?=
 =?utf-8?B?YVptUk9OSUJSaUlFeHVTaHVJdVZHQW96TXNINkhGTiswU0VKR2syN3FGU3BJ?=
 =?utf-8?B?Q2ZvOFY3SGZFTnNkeTh1NWVGeUo0SWE4VGJxKzBicnFadk1yTnVqNVN5SkJs?=
 =?utf-8?B?aU5YeHkraXFhUEhSazUrN1kvTEp2dUJVaFhmVzlFZGEwc0cxZ0FmbU5haTVy?=
 =?utf-8?B?VjVlMDk0Ynl3ODlYdlppajdlbFRvamRZbUI2Myt4RHBOYkZ6UTQ4Z2RGTW1w?=
 =?utf-8?B?RHpVZE85ZDdqcXpVS3NlYjNFang0bTkweC93S3F6VUxBUTVwQk9yenlvVThr?=
 =?utf-8?B?aERVVW9TSWhUR1BSYW4yQ1VyVVhmWnJ3b3lkMTdiVTVCcS8vUEY2NDNYOHRR?=
 =?utf-8?B?MlJveVV3d09QTlg3ZmU3bUdGY0pMNFUxKzEzZitOaXEySlpOZGNpWUFrNjdu?=
 =?utf-8?B?aVdoWEw2SkxEZFdLRis2SlJsV1pDNWZ2R3AvMEh0UjlPZmFuN2M2YUlBYVYz?=
 =?utf-8?B?UFlVeDlleThwaDNvRDkvM0RjbGNDYTdybDVEeGlteTlBTldkb1h4SFN3QmxX?=
 =?utf-8?B?bVVvVzFoMjAyTHpuTTdjOGY4d2Y3YmdFTVdVdVZUcnRxekVsK1VsenVUM2dU?=
 =?utf-8?B?dXcxUmlOcFI3NitLL09ZS1BNbWV3dndGS2ZnK01WRkRJbU5lSDRnYzcwbEZy?=
 =?utf-8?B?SjFNY1k3UUdRQldiRGlmWDZtQWQ0SHhPMFVZZmpZa01NVm5ValVzb2VYS0tL?=
 =?utf-8?B?bXQvSVZ0UnFOSnZ3VkMrNDZUMUs5T3JGcGhKQnVJNktlNlV1OEpVTkJJa05F?=
 =?utf-8?B?S05lNjB2V09yMGg3YWRCZVJLWGFmcVZ1N29WUjJCRXF6M1BGMnE1aUdaa2Jj?=
 =?utf-8?B?dUZKZ0xxMVBrQ3dURWwzeHNUTVJGWi9OTGlYeEh0amdrZnhCQnkyUDhsSHBZ?=
 =?utf-8?B?OW9Pem1ycHIzY1JnNEF4R2lUcCsvK2tzVlJzVTczWnZvMXJWMWtzTU5ueHZY?=
 =?utf-8?B?QmhOUGpoR041RStXVkRlaXdiNDRPZmZ0WFo0ZVRYMG1lOENRR2RyV2s3TTF1?=
 =?utf-8?B?Zi9yVEJnUVlzRS91akpldmtoOE9ScUtYR0Qxa2RnS3orYlB3M254K0NGby92?=
 =?utf-8?B?V0hLaGdPeVNMZW8wTmJQSWlWY1kzdE1kSnM2WHMrQmNvT2VuVkVrK0pSWFVM?=
 =?utf-8?B?OEQyb1hpS2Z1UzRid0xaVWNLWUFvMUJ4WHAvTDNMTWhIc2xMZytucDlVK3Rs?=
 =?utf-8?B?MlhvYzBRRkVmaDNhNlhVSEM4WHBvRnVPT1M2aHh1YWJwVUNpNFlyTWlHSWVi?=
 =?utf-8?B?akVPMXZwZGlJbkE5MENXaTR0bHNRUG5EWnJDdEJCYnhNaUQ2VE14THJMUkdJ?=
 =?utf-8?B?ellYTWZqQ2d5dkRIVngrSVRHd2JNYlpmOGtHSzFaWWFkOWlHeFVhWmJMTUhN?=
 =?utf-8?B?UnlGUVhzSjEycDF5Ri9Gd1BSMTJvOE1UR0IzeEZPc0FTc25yTTh2Qy9Idmxw?=
 =?utf-8?B?SE5tdUY3WjBPVE9tazNCck85K0xZVlN2NVFXN0pnTlJLQUFJRjJZeWhDSy8r?=
 =?utf-8?B?Y2VOTWNNS2VOa3Bvck1yUnJNWk1vcUloeUVCQWc2cDNlRW5mTnhSL09ISGZJ?=
 =?utf-8?B?b09lN0NMd05vZmk2ZEswUHdmUllJK3JLdlc2WVV5YjVqK1ZNU3VkTWg3Vk5K?=
 =?utf-8?B?aU9HYU5GTGFHMTczUlhqZjBBYjBhN3I3eFZDMmVzNDBMamhMZzhkM1h2TzU4?=
 =?utf-8?B?UWFUdzdzeU5INGVXc2lzTi9wSDRhMjZTUHg4WVoyUER1aUJSNnJ5Z0pIRWZZ?=
 =?utf-8?B?WWIvdFJzUzZmbDZJUHNjU1g4QTkwYkhKU1hkL0V4RjFaU29UdytYeTRDeFYw?=
 =?utf-8?B?UnQvQXVhVDRsZDJtTDhYc1d4UUIxQ08xeU0wVHptMHBodTJKTklxbFd3b3lN?=
 =?utf-8?Q?Ja24/0b8fGCg0lDJlTCX/46j817/8p06JU3K5jFsdjdz?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e1cfc7-74a0-4db8-b984-08db9f044169
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:28:03.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrnSNjfOxpN83M+9D1DPhTv/a8yzI6WYiW3KIZGIowuy8yRC62NQHtfVpafOzKj66ekD+Z/p2QTm9Z9KKrJceb46VbpxMcKWl3ud2+g8XehfH1/atLkcgNixluPEBUSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8221
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 17-08-2023 01:57 pm, Marc Zyngier wrote:
> [Fixing Christoffer's email address]

Thanks.
> 
> On Thu, 17 Aug 2023 07:03:14 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>> As per FEAT_ECV, when HCR_EL2.{E2H, TGE} == {1, 1}, Enhanced Counter
>> Virtualization functionality is disabled and CNTPOFF_EL2 value is treated
>> as zero. On VHE host, E2H and TGE are set, hence it is required
>> to adjust CVAL by incrementing it by CNTPOFF_EL2 after guest
>> exit to avoid false physical timer interrupts and also
>> decrement/restore CVAL before the guest entry.
> 
> No, this is wrong. Neither E2H nor TGE have any impact on writing to
> CNTPOFF_EL2, nor does it have an impact on CNTP_CVAL_EL0. Just read
> the pseudocode to convince yourself.
> 
> CNTPOFF_EL2 is applied at exactly two points: when SW is reading
> CNTPCT_EL0 from EL1 while {E2H,TGE}=={1, 0} and when the HW is
> comparing CNTPCT_EL0 with the CNTP_CVAL_EL0. In both cases the offset
> is subtracted from the counter. And that's the point where the running
> EL matters. Which means that CNTPOFF_EL2 behaves exactly like
> CNTVOFF_EL2. No ifs, no buts.

As per ARM ARM (ARM DDI 0487J.a page D11-5989)
"When FEAT_ECV is implemented, the CNTPOFF_EL2 register allows an offset 
to be applied to the physical counter, as viewed from EL1 and EL0, and 
to the EL1 physical timer. The functionality of this 64-bit register is 
affected by CNTHCTL_EL2.ECV."

As per ARM ARM (ARM DDI 0487J.a page D19-7857)
"When HCR_EL2.{E2H, TGE} == {1, 1} or SCR_EL3.{NS, EEL2} == {0, 0}, then
Enhanced Counter Virtualization functionality is disabled."

"The EL1 physical timer interrupt is triggered when ((PCount<63:0> -
CNTPOFF_EL2<63:0>) - PCVal<63:0>) is greater than or equal to 0."

As per ARM ARM (ARM DDI 0487J.a page D19-7938)
"When EL2 is implemented and enabled in the current Security state, the 
physical counter uses a fixed physical offset of *zero* if any of the 
following are true:
• CNTHCTL_EL2.ECV is 0.
• SCR_EL3.ECVEn is 0.
• HCR_EL2.{E2H, TGE} is {1, 1}."

In VHE host hypervisor, E2H=TGE=1 hence ECV is disabled and Ptimer 
interrupt is triggered based on PCount<63:0> - PCVal<63:0>

Since cval is set by Guest as per offsetted PCounter value and pCount is 
not subtracted by CNTPOFF when in VHE-L0, results in cval becoming much 
lesser than physical counter(bumped up since CNTPOFF is zero) and timer 
interrupt trigger condition is met falsely.

There is no issue/impact on cval due to ECV, however it can be/is 
manipulated to handle this on and off of CNTPOFF/ECV.

IIUC, CNTPOFF and CNTVOFF are not same as per specification.
> 
> The behaviour you are describing tends to indicate that your HW is
> applying CNTPOFF_EL2 to CVAL, which would be a gold plated bug.
> 
> It doesn't mean that the KVM code is correct either. I'm seeing pretty
> bad behaviours on a machine without CNTPOFF_EL2. But what you are
> suggesting is IMO a misunderstanding of the architecture.
> 
> Thanks,
> 
> 	M.
>

Thanks,
Ganapat


