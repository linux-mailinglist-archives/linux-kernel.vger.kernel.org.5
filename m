Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F87CF3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJSJMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJSJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:11:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00212A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqOMVuVj6a91/jKmfOV+vjE8bXrUdTahQgK+X4x5ODq6EawJXqtjh+yBCRAgMu7NNrJbbrVRirA5vW07M1T35S/NxjRwgtlKrAIqDDUPYzI/kC0I2pi+tJLZYmlD7IAAkDjbq2Ss8YjG951yDMZXTGhJ5QdX50C9lQ6h8ZaJxiFRJdmJ8h/nfOIr11pjezCs6qDRlOnOOQ9qNCsrjLHlADBJ1yDY6rUsVg5H8x/q5uzRnrzc6wE9O2p7X9E34gDPBXwPU5KFJAgWCHcqn0+ueuQbRDw60TQ+bZH50iO4/W1z1dv/uam0hlWc+Tu49yMXgNYY0eDv6YdwpCfLaD+5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOJh4YibGmSL/H8bTWRQufhvwt3viQ+lU1mOtQDEgJI=;
 b=BSOqvYVnJUHvUIVcDhfaRaKckNPOwWI1CCjqIlmPhj4Q+NGl8U5XNGkO442AyYF2O/uXHdBnI6oiFiXXw2qcUDueBxi26XEXZS2W6Fwo3RsmppW2LdmVrYCQ8XZBcroL7Ms/BBpJOasMZsCTV9grfjFzo1jBO2a47OToj79iQXsqh4trtKdwrmiawfYWL6Yrrz5M9LlO742kJdMNimH2ylzCx8qYWhdrie0zsqLhke90LTabEz7bbsY6Ko5pvd2ttQdTq/HKVJ6UxCmZt1Q2hOgtEljX64CuUTZp14IozgMufUsbHf5UcX5tnUtSZ0GNDQdtILD8lcIQMfb2KStOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOJh4YibGmSL/H8bTWRQufhvwt3viQ+lU1mOtQDEgJI=;
 b=MsGJkm/aIf2dOGzLP7iirFGP3YiR3E6v/a3HkDIZkox0AZh9Qm6QLSgM55LvTBfNe8uDMFXXefRCHEgcoQrQcc9e1htAcRNwUUCfyzdMsxj6BVB6tI1rEzxmx1Rx6FKyG5qbHoNL/Q4nUop7Wa9PA5L5S5MN/nGHB8XX7WdJZxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23; Thu, 19 Oct 2023 09:11:53 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::90d5:d841:f95d:d414%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 09:11:52 +0000
Message-ID: <d0731c73-b2bb-972f-a728-f63273c4d5ab@amd.com>
Date:   Thu, 19 Oct 2023 16:11:43 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun and
 destination fields
Content-Language: en-US
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
 <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
 <44477b0b-af38-569e-95d9-e78c118c9d18@amd.com>
In-Reply-To: <44477b0b-af38-569e-95d9-e78c118c9d18@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d719167-1485-4c57-4b51-08dbd0836ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXjU42oo9UVevz+0Iaju9pcDM/eS3/gSrbDGyHzp91RXpwdhq1RMea9V5e5whv4QD964oYMj7RrKP+scTYPp4Z+Bq9hPDi1f8CRwMS1jWoKUlgOePusRNPteHyHtjxIKA+tsexVvDPGrNvrFKKB6gOgF7V/WCty7sgJ0D4lRkD0oG5+gtp9f4AIYQHFeHvNCtu4aQwfVWG2FmdZMcQK6r/9bHeJZVgHYd+oi0fIRUDQhsssSgkEO7RLhlmA2nYm4SvTB/UwXEXZsJqUkToViOXtlfIL/zrWaruI2Zc8FrD0BxSHqHksgwhuE9B0iSR2F9GgvnCpMkGPCItgmXhlphEweEnkPpuE9xcCcc1JvvEmLVbU1CYDjC2ftdxELYuUGmDkNPzmjR9913fRt/6QkqkXADnl7cZPPDNtssHZ84f9faKeNyhmoBlHjI2jSkVutSFakD+8Z4s+mu7FMDtHPJInUJ9h4/LUZB76s0NjaIPVTru9+idtk8+yatYng4yB6cfWBElIVXNaLLv9QGpjq9PYXcaNhd2g2+9X8+Qad7spOYVsGUmF/B17r6h5oCqY0eR16pwajQ25g666xeEWV1aAldb9CymteQyLGPzDX8BlVs1HxGRWkxgoITMww20xoUZd1PXD0k7d91l+qiVe2EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4326008)(83380400001)(478600001)(8936002)(6486002)(8676002)(2616005)(31696002)(86362001)(4744005)(4001150100001)(2906002)(6666004)(41300700001)(36756003)(26005)(6512007)(6506007)(53546011)(38100700002)(5660300002)(66946007)(66556008)(66476007)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2w4Q2pmWEpkaXJ2SWFPNjhKaHcrbWhFb1VVdkRlYjA2VHdGQnhmSnBsTGNw?=
 =?utf-8?B?elJEZksyM1N1c3p5STBtS2RMazE4MEgzQzFYZGVuODZqWW9xKzhBR01iNmRz?=
 =?utf-8?B?OGFKM000b0pCc1AycGJiQzM5cWRDbXRXNnFHZEtGNzlTR092VTJkbC85R0NQ?=
 =?utf-8?B?eG04WWg3YVBORXhNMmxobGx6QmpkM1RnZHFvTWJ5SFFUOWFzZksxY2FqeFBp?=
 =?utf-8?B?WlcrNHRlNjU3elFJZDY1K3JGQ1hMVU5IQXB4dTRkSm9sRko3Q2Q0RlVkL1k5?=
 =?utf-8?B?a2FCTW5wNVVJakNyS2NYdHNiaTBlb2tSQ3hwa09uOU0wakRMUnREQS9UTUs4?=
 =?utf-8?B?OHh3UlV0OTdLTXdCMUhuK1Y3ZTNtYmp3N2ZzSDJXR3ljUzI1MTJuZkF4NHVB?=
 =?utf-8?B?bFBBbFFVUk82NFFlMlIrZk1UcUtCbXBZZWwrM3hKd2tHSmhUU0VzbnJnNGtZ?=
 =?utf-8?B?MEsxSm04cEdscFVUYWNRYlFPMEZKZ1BzYnY3Z2JVZWp0QTVUNkw5Y3AvWXFR?=
 =?utf-8?B?aHk5bmY1WFd5WDJrZmJLbVpJQ2ZzUlozZzFxRmhzWmtCWHAzbi9wQnpJZEcz?=
 =?utf-8?B?cFExbXNCNE9WV3hPRU9LZTFyNE41ZXdBVktHM05RYnZEVEZobm81aTVOWE9G?=
 =?utf-8?B?M1lNTGRvMEZuNFVYNnZ2b2JpZDMzdXZXL1NhS01ZYVdVZWowQTFBbVpBd2hY?=
 =?utf-8?B?dnhmeFhQRzdZZTVCdndzcENBTW0vcWdjZ2k0WTdlWTZlNXFxV0lwUUduOXd4?=
 =?utf-8?B?V2Z3MEZoVTkxQ3VPMjdXSERHVFVSNkJYVTZKSi8rTDdtaDRJUlVGK2k4MUV1?=
 =?utf-8?B?angzcFRudGVVTndrSlNyRnRLeDJRdmpjclVMakkzOSszbWkxTmRZS1ZNQmh5?=
 =?utf-8?B?OEpXcXhsWGFqWjEybHdiMkVORlhvVVIzMU1ib3pscGlPRDhaN3lMZStWZlMv?=
 =?utf-8?B?bERLdm0zb1ArV1IrdTl0bHdScXVCbHRrb0s3bzloSi95L2ZJQU80aHFtdG90?=
 =?utf-8?B?NjlDQUxEUi9YL2lwVk1FL1RRc3RuRzgrYVpKeUtYOWM2L2kvRENHb1lSU1Y2?=
 =?utf-8?B?Nk1Ra1FUd3pyYkhQVi9lWjB4SzVsc0pKRW1OK01QM3pDd0dveFRnazNENEhM?=
 =?utf-8?B?eFgzQXU3dlU0SUYwVXNFck5ad25oY21SbnN0Q3VCYVZTU09Kayt1Y0ljbGd3?=
 =?utf-8?B?NDFDT1cwQ3hSaTU0cWtpYWkwVmh5a0VlUHhFdkNvV21RQUpiS2czRjRWL1pm?=
 =?utf-8?B?QXJaOVhTaEJsMW9ncjA2d2I0YVNHcS8zdk9oSUlZRFo1SmUvWWdxbjNXWm1a?=
 =?utf-8?B?ektWQnE2bGtjM2hha2Y3eWpjdk81eWtKaGxDNWFHV2V6Sm10L1oxWlFtZXo3?=
 =?utf-8?B?SklnQjBEKzY0aTZVUlRjL1BzWGFYaWtDNGhWOEVoV2UybjFDMm00T2dqbTk4?=
 =?utf-8?B?OTdvcjVCNUh4TG1scllIcUlJZ1lMV1pYZHR5MEowMEFhSm1INm8rd0IwOUFB?=
 =?utf-8?B?QzRpNXUxcUQ1OVBYYUpkaG9neWRuR3R0MFluQU1rZFF0OFhMZENJbEwraGJk?=
 =?utf-8?B?WlQ0akdDUWZVTmpqUTVZRk1qMXFNUkNzM1pRanZxWGtLMnFKS1lPM0c0bisx?=
 =?utf-8?B?NHV5azRleDFzckhTWm9ONFpOZ2MwNk5aTEVjekVIUldBNFhhaDFpSFlwbmFz?=
 =?utf-8?B?SWxHWEZaV2ViVklpSWVoMnp3RWRNYjFWdmlwNjV0REVid29tMGJiaXpqL3BN?=
 =?utf-8?B?dDZmY2pIOHNqZ3lSV1JmWjZOQWxqbHJYamMvY0x6MlR1S1hTVnZZMUxoNElG?=
 =?utf-8?B?K01EYyt1QVIrUCtyd2trZXZreU5wMXhsV3hFc2R0UmpRL1ZScVNYamdDUjVD?=
 =?utf-8?B?M0p2OHZ3SDRQeUhrdzlwYy9VN1h1eDNmcjF1MUxDQjhKTDdnWHBGZFd6dGFt?=
 =?utf-8?B?RHpZUDRpa3gwWG5tMkM5bnE1dzR6SHJCWHkvNjAzUGNMQ1p2cURIakhrS2E5?=
 =?utf-8?B?OExXMkExSVB5S2dwWGxha2dreGVIWkpXd0lkT2FQaDM1S2VEL0U1aXcxbjZB?=
 =?utf-8?B?OVYzZ2N3VDhxNGg2dXg3RUV3ZTBoV0dEZXljZGZKcDNhL0NjeUpPakpWOCtO?=
 =?utf-8?Q?HUThhPFd5Q4efRK6VhyQTj7ou?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d719167-1485-4c57-4b51-08dbd0836ef1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:11:52.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eXDH7MpDCAsjecQJpOiWJ1Cq+iw/ei085VZTF43CRC9EtEL4Is5G0eRy6ayuSDlvt2UcjNiE5UxBgnkErgLRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim,

On 10/17/2023 10:36 PM, Suthikulpanit, Suravee wrote:
> 
> On 10/17/2023 9:51 PM, Maxim Levitsky wrote:
>> У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
>>> According to the recent update in the AMD IOMMU spec [1], the IsRun and
>>> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
>>> cached by the IOMMU hardware.
>> Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 
>> hardware?
> 
> This is true for all AVIC/x2AVIC-capable IOMMU hardware in the past.
> 
>> Is there a chance that this will cause a similar errata to the is_running
>> errata that Zen2 cpus have?
> 
> Please let me check on this and get back.

Just to be sure, could you please tell me which errata number are you 
referring to here?

Thanks,
Suravee
