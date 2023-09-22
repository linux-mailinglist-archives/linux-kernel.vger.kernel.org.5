Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C067AA8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIVGC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIVGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:02:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D8102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZiQGt621dkSbTnXheAJVPgkhHfuexLB7Gi4orxwv/79c3p3sOBMqHGhl8wrVfDqWOUcdC2mnPqkVr2SKMLQLdPtvVq1FWbgjIpjsUh56fim6S7xG1EsqiRjHEQ2HxIYxUzDN+ljUTqOJ95Dy3AOktJXUgApMY/8BTgMS0QPoLNK/Dj4Lh846hkPP8Ykm7CjlQcXUvaSoknHZxKJ4FXumQXuL054YlYAEGh2yrlo7fVLQ4aI0eMsro6WOeR2sqs3n8WqoAVbTJzDnihRBULEA47MoaALbMQVhCT6ymlzNI7ic7XM3DChhkmb0Dk1kWXQUN42YIl+Dz8yXSVCLQ5dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEoPtZXfp1t3oQB7OcsG1yI6Z1V3PXDyNQ/z377MfRs=;
 b=Ni/MLhnvt+iNcFSMwg4MNeosCyAZ4ZHmsDaPATnXJGdAIZaGPZ8jVB/I93qV+cha+1eFMjs1d1pGoVMaVctMUTrHKB4JO7wkq1F3/cb9diCQtJAs2R0IcSoQ1awBHNL1fRb2vToIYCsfhwjzqT20QxvNuvzbebcnAzOWp5eg3ub5DDl0s2hMHK6zoXlObVSAw+ApmhL6Q2ANs2JXgPHCRDuYi75h1Jry8sUtT+oAB3JqoZudXDwa3yrIa2O7mstbI98eoQ4GMzJXo5lrxYr6XuTVhMifmDy9AOPI3oh2j3BfXZA3xBFyzuEZu+ya3SyrD8MD0x/aef5AOL3lut40Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEoPtZXfp1t3oQB7OcsG1yI6Z1V3PXDyNQ/z377MfRs=;
 b=jDwFOtwzP/S5pt0OHUTMFQRdo1nwVMdMfXJw1CZKa/fFnP9tNdI2QqdFeqmXhubIz+Il0cuPZqbD4hGk6ZuLvMwe/SFm+jaL3ma9hizISCBXxkN7tatbIdnRxGqwtGtoZQmW3tbUDmG3ZSQTOtk4F6BNWDeNxIUUTon8npknKUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Fri, 22 Sep
 2023 06:02:13 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:02:13 +0000
Message-ID: <a5121152-aeb0-42c5-8ebf-c4ede1e2a884@amd.com>
Date:   Fri, 22 Sep 2023 16:01:44 +1000
User-Agent: Mozilla Thunderbird
Subject: ignore: Re: efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@amd.com>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <5a3f1772-15a8-4525-a323-801458247416@amd.com>
In-Reply-To: <5a3f1772-15a8-4525-a323-801458247416@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 162af672-8cf3-41d6-3764-08dbbb316a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mHnygV8mFvtZoAah5ttSrfuwF/zTxY8K9b6kJfGUN8CtJWwPcZwI/PaqoPQxxYs406FwpD0hdoZZesHcgxK3r/Wh9Z9F3GKKrESPY2Fb1V9K4N6jiTyUtLEuIakP/UbL6bZLYON2xvk+Tr8vNohABW15g6O60dMzD5oE/fdEBX6gOTGiEjoJoASXc2k/QFn+kkLJApPTgPMD33BG1MJTkugdpAIAo+cQo0fu4oiETZMrcKrClKeo+fMHeUQ9vDQNQqFJByfkf7BqzaJWRPh1JGLVASpe1QKX8t/JPTs5atpkVOxRlJEF70aqNUj7PH6FU17E5sg0OsHdJYDGJp6T7mzcK4VPSXGrybt1WuFZFnNI3sA5tb0XR1PELck2u9Iqa5sIzrE+HOcpnM+1TnfyeKoIed9B7p93cAmrMPBLaLN/SOjtIQLHYNzJUIblcT2ZcSxIf1eWfBJXsPh3VryFBMAHxvv9V4paHkOPNEFsVNmlJmxd5S4F4T4gMXarswf9SQE5groEhrzDhzKUJv0N/MKcG4bRvq5aLj2qIeJbTO+SdgIq2eORmDaZqtBdJuenWhBZzPyGkQAsKlXIGn1iRC07Gzg+9yFve/ug589Iyr/jiS9zEZozgZb336ZD/kaqW5di9jTyvjR9egOgdUO1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(1800799009)(451199024)(186009)(2906002)(8676002)(5660300002)(8936002)(4326008)(41300700001)(66556008)(316002)(6916009)(66476007)(66946007)(36756003)(38100700002)(26005)(478600001)(4744005)(6666004)(6506007)(2616005)(6512007)(53546011)(6486002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJDVFhJSGI2WUdLZ3NnQzYrUjNtenVacGFCMGhQYVpFTjZoR0paOEFJZ1ZR?=
 =?utf-8?B?KzZnazl1SWlZUFJVMUMzenc4MVpsempDb2p0Mjk1VmpEY3hJVitKSG1YK2Ir?=
 =?utf-8?B?b2MxUFU2ZkdPQ3NRSldTOHlrT2cwOTZCbVZKc3RicUdsS0E1Um9wSlcwUkRu?=
 =?utf-8?B?bDRHTXFXWm5laDllazRaTnRublV2aVBiQXVKNWlSNDhEL1Q0THRWUlltS1cw?=
 =?utf-8?B?T2RiUFNKSEJTNUcrOW91RG9pZGZGSUlKK3h1ZFpWV1VyY2lya3BzUmI3ZFZj?=
 =?utf-8?B?UHkydHY4MFZvclN0cndJbDduSVJoS2JOWFdCSmRHaCtYNExHckRObWNBTXl5?=
 =?utf-8?B?ZThCNVloNlBHZ0pnczh2NS9rdksycW5ubVROSmIyazVzR2toTHdzeE1rOXZk?=
 =?utf-8?B?MWV2dzJ5RDJsa0dmVmRuMk9FMU40R3NJaFk5RjZQVk5EMFJaYWZCQ3h4c0tm?=
 =?utf-8?B?d0wyYWp4Ukpmd200VTBIRG5IcFl5WlA3cW5EYlVJUlZOZEN0MW02Vmcram4x?=
 =?utf-8?B?ZGdWQm85MXY5MWU2dEFjeU5hR1RFalVlVlI0ZjE4WG5GUzRFWTBSMVBxaHQ3?=
 =?utf-8?B?c3ovdUV1ZVY1ckhIUFE4bk5kY1dRV1NkaFFPeEpkV0J5dDZjZElTb3VvRXZy?=
 =?utf-8?B?THlLdVduSGlTWDJXUGVDNi9KdGRhQjd2TzFzSDVJeDgyVXhDVlhOZWlUL2lL?=
 =?utf-8?B?Zlh5VlhYZUtwa3dwQm9zWE1rdTFYQ0F0UlA0VFQrZjZJUWwzLzljc2JVcUpk?=
 =?utf-8?B?ZSt0dC82L1Y4ck95REtHY1VRMWVxSkp6aDA0TDlVTFFwQytsZ1JIL2w1WGI3?=
 =?utf-8?B?L1l5YUx5NDVmK0swM1ZDK2J0MFRaRTR2czNXUk1QMWthRU16SFU4MWpWNXN4?=
 =?utf-8?B?WVpJSVMyUWQ3S056RmdnQS9mVHBrWmQ2OWsrUHlxQk15ZjJld1QzZmk3SHRs?=
 =?utf-8?B?M1BjR0xaZ3JwRFkrMFQvaU1lQ3IraVVZZnQ2R1RrSjRJdjhwMVdLWURGeS94?=
 =?utf-8?B?UkhEQ2t2L202TmRCVmJWT2JGZTdvRElsRDBxVkJjVGtPdFUxSFUvTjA4dnpT?=
 =?utf-8?B?VytKSy8vWHNHMjU5S2RhbDA3d1ZPaGhnang5NE5kcDFrbXo2M0I2dVJUNWVa?=
 =?utf-8?B?bHRvQUlyZkN3clJ6bFZjU2dEWC9EOTdweWMxWjBRR3Jwa0ZlMU9NY3VPTjlp?=
 =?utf-8?B?T0xsVndIcEdsbXJSNlFNejFWM2lSRkREZWZzTzVOSjFJV0lLRnkrRGwwbTE3?=
 =?utf-8?B?RzkwN2p6cWgvNTN5MjRnMHZqMjRGWng5dy9DcTVLU0hpSUYzR3dpdExoeUk5?=
 =?utf-8?B?RVlFYjFyblZpV0tlUDBnaEt3cTB5U1gyNm1RcUlmZXZZeTNaTUEzUEVrcjFX?=
 =?utf-8?B?V3hDNlh1R01qcHR5a0NSUUVQWnY5bUtDdkh1Q1N1UE9YdGduWFRNNUk5YmQw?=
 =?utf-8?B?S0FzZm9uL29LSzhPT09YUFNYaG1PNGhUOGl5a0REd1ZlWmpiYlhkYWZJSWxP?=
 =?utf-8?B?aG5hZlFURllpMWlJV3lVWTFNcS9JbUU2bEhTM3JXdkxxNFh3aGZOYk5td2FB?=
 =?utf-8?B?aTFodkxJT09Jem4wUm5DaW5RNE1BZlBIMmlQRGZub21hakJ6cWlxRjE2RFZ6?=
 =?utf-8?B?WHZnRVFldStDMjM5RVZxbmZUdjZwaWw1S1hUUVFubyt0V3pXbmtraXZNV0g4?=
 =?utf-8?B?dS9oNXJQV0JZdUpPdDlManNNZDVOZVJYM2V5QUNQU2dKK2sySS9BTkRmTEVt?=
 =?utf-8?B?RjllRWYvWHFScitVUk5DeFVXNVMwZk55UkxOZjRTUFJwL2xPZXRySkFNQnFD?=
 =?utf-8?B?Yk9Qc2xHcmRNbkFQdU1RbFZ6QWdMRHdCaG9NK1cxZmtEWUdyQjBDbUZCeVlt?=
 =?utf-8?B?OUR6RWdZdy9tK2wyZ054Z3V6OTVlLzNsS0ZENTg3ZE9NUmh2aUs3VnJsYU1O?=
 =?utf-8?B?N1hYTTBjekNBRXY4U0hhdTJDM0JCVUFoSFB0MGdqVjN5Y01rd2JOcitKdGls?=
 =?utf-8?B?TkM4VkdxeENZNDVEWGprR3ZHUFBhMjZPb0txRVhnd0hKZkV0cG82NXJzVDVo?=
 =?utf-8?B?VE5RazFIb3MzYWRUQml6UFMrNkJHR2ttV25lWTlxaUJwdEtOQktpVXk2NXI3?=
 =?utf-8?Q?fx9xa8VNDHt9QnbH5Xz+bOgma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162af672-8cf3-41d6-3764-08dbbb316a56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:02:12.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdLxw+lviL0w5gHqApuf93AkmKeE3f1OgsRqW2Cor9Du31HrsdsAC7xM4CopJa0reHnU9rSQHUZFJTHkBTvWnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops already reported, never mind. Sorry for the noise.


On 22/9/23 14:21, Alexey Kardashevskiy wrote:
> Hi,
> 
> e7761d827e99919c3 broke SNP guests on AMD systems, does not boot and 
> QEMU exits.
> 
> ===
> commit e7761d827e99919c32400056a884e481ef008ec4 (refs/bisect/bad)
> Author:     Ard Biesheuvel <ardb@kernel.org>
> AuthorDate: Wed Aug 16 21:05:57 2023 +0200
> 
>      efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table
> ===
> 
> Is there a fix for that?
> 
> Also, out of curiosity - where was the patch originally posted? I could 
> not find it anywhere on nntp.lore.kernel.org to reply to it. Thanks,
> 


-- 
Alexey

