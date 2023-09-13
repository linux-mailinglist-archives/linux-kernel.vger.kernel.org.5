Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710EA79EB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjIMOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjIMOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:37:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585798;
        Wed, 13 Sep 2023 07:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUNQ10EhbuDA8TPz6UTYxxdItFd9EvVpbt9+x1bKFuYrxguy9Z0Bb5vJ2i/tm5J3G/IDy6Raee4DUOZKb/CanCRKjx5oa7zxCaKsFg8mXQ/2RJuMmt3cRxB5oqLZuSTmq5n9ZKHNqeMVRslzzw0WPUiKMbU4TyPflYoha0y1Bnk9mtzUNKcf665PLsl/eKeJ4aG2G+R3tNhlqip53XSAIveLfh/cKO2EkAkNR4jO8h/nDR3dkqUpVtdFFLPztgZfq8VPJdFuPcOyceeZXJMc3Ar3TBEKFiMaj4E4XT/KN0preSx28ToUahgsSiCOzDvIZuRk+iO+OLMtJhestXiRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahnKZmxJT8dusQtBeSkWr2k8rK751AY00jAIFynw+14=;
 b=ctReq4SL0yyXQYXcoE79uIEVlehvamEeiZt2Aa83B5ok2aQVMJveLbxC1DDBXjdgajBua+gOs1TIvCHUx3C7nR0ywVdEeZuyg/Vbxi61rKRZpZaVtaM3RiuKy6jeaUOS8dE2CoW/mtxLcozTqiVtRvcrWOqI0UDcdGcrVPY4GGvPSZrTZEBK4XuRzbzCtcvQNrqIQ03GMzoyYpl8y7kndPPugF6Bgq4u49nqrb3kMnifeHpSQuvj3Ax4X0umNPjMkzgPOAtr5Iw6FpM8Swcv+yXSjq2IlU4HLcOzY8c0dI6rM/01Owo3/Bt1Ba3oNJpWRaKig0sFpWW8ZQfdTYYkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahnKZmxJT8dusQtBeSkWr2k8rK751AY00jAIFynw+14=;
 b=jLLvd9VwpjuyR867JHxfLR1Yc0qip5pvotsIzBm2E3LI+rh3saJRFJhIAvUiEmqoGUrJvIaKgzrit9iYiHogDFyipt9CGhjOrczeZuQ/suS5P8/28bXIPuJ20rcrYOS4GGZuinkrFuCxYzYFPgvZ9z83WAXHIp/zUJUOl06ScR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 14:36:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:36:55 +0000
Message-ID: <40d3399a-b260-4ffa-a503-40c61468a189@amd.com>
Date:   Wed, 13 Sep 2023 10:36:50 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, smita.koralahallichannabasappa@amd.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com
Subject: Re: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Elliott Mitchell <ehem+xen@m5p.com>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
 <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a30150-ada6-47e3-20ee-08dbb466e068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMEp8RLbYtVa8hXEDxhq3loSPv79Wd6FoZTTAyoznocgRXyJRoBX5PAKuPmNw2LKCIjhj16y4yA+lYWn0yaZxdwngq+QVBwQnTgQBUFEfOamHEMoMiLDGtw8QzsWwh9s52TSrvhjyz97nUKWGeKDT4V569chhrF1gBuE1sQeg2W981TOa3rLqp/0J7wa2vhf65aJavTgJpa/LCEXinuS6GG+6JAMS4EhjfTTrwvwrEfkVz7wZI4aEv3rq7xHYWa6f7zIee3f+kag1oBj0QGsxvwezQSZrKmqbtipMn4AM5wA1rW+RpLtL7B6CRZ3knE5Crkn3SAEcrAorQWGt99Wobp81jlOulwbHbCANTW7+CznaUeTq0UfTl+zAEJJhpeKZdFmbDBoWyRMnTmyh0Hn3k7MMVBHS2FGXczHYnt83v8GHSDnwduGvlqtktFXMIGgVSh8Snq46OH5udj8S3V2DTOdTyBxYAUxOgp/7FLHRlbryAPSMFPE459jAt1S426E6gDLOfoOJIdJEWzAfeLltyLB6IkuochPEG/69Kx/Kis6Z/+i2NY8YNYAR2PAAwFTA/E2hnmrocp7qVGa1WeB2vj4qf6GHxSD1+j9ZBzTujG98HNyXy+ku6zCRHKLRPjCpv8jXoJuttpQGswcJbu6hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199024)(1800799009)(186009)(31686004)(6666004)(53546011)(6486002)(110136005)(478600001)(66946007)(6506007)(31696002)(36756003)(6512007)(86362001)(38100700002)(4744005)(26005)(2616005)(316002)(8936002)(41300700001)(4326008)(8676002)(5660300002)(2906002)(66476007)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHM2MzhFMkswRHJwL2U5czgyRUhGbURINGJ5RTlHU3RTeDZwck9ZOXB0TDB2?=
 =?utf-8?B?N0FXdkd1Y3Z6ZWQvOXBFL1pWdjRpUDdzMnJTSGErU3hkK2dtbmMrOGpvQ0ho?=
 =?utf-8?B?dTJFNWhCSGxtTU1KbTdBcDZGMHpFNWU5YWt5aENSS2VkTlBoYWdjNWVqY255?=
 =?utf-8?B?TncwWG53OTFQVE9jRWxIN2QrbmFzSFM4STBrVnNzeHFHNW9SQ0dlWUpUNXNv?=
 =?utf-8?B?TFZNeDhybWcxT2RZcytReEtYT1NTR3JaNm1hdXlDK21BQ2Y2WkFVTFVVRUhE?=
 =?utf-8?B?Y3Z1b1ZjeW5wdnoySWhtNFF1c2JsZlVrR0NHd3dXQ25ZZWp2cjZaOEJYKzlZ?=
 =?utf-8?B?QnlJaVRZUjR6UDB3OHdvSFlNVnhEWVppZUIvWU9oS1EvOW4xSkxIRTlpNmJy?=
 =?utf-8?B?YzRIekMwei9tSW8zdXhMRzV3VkRZNkg1WDZvUm0wS0RsOGFmbVZ4dDBKQitn?=
 =?utf-8?B?MlBaeVlsYlpHV0NGODVHVXAwUHl1azl3V2wvRXczSkJNMGFtWlh3NGFYd1dD?=
 =?utf-8?B?QmdvU3RkUjY1TFFpWkNQMTdsaEwzd09uRGFCTnFldDVBdUxnOXpvUFQxTmpM?=
 =?utf-8?B?QmNPeElXRlF1cisrOUtMTnRFajlmRDFZek1SbkpjQWNaTndEczZkT3EvUlNY?=
 =?utf-8?B?ZnJ0MUVjK3VLUm54YnJXNloyU0FqNkRYOTJ0d2V4TWs3a201TXJ1bVpNN1du?=
 =?utf-8?B?TElDTUp2SktYZUk3ZkFZaHYwKzIvQm1EQkF3RTRvLzZwd3UxMGI3ajJwNWdp?=
 =?utf-8?B?bTlXNW1vRkw1QkpQRGRnN0FSVXVBWE5nenFVWmtTNi9NMTQrZWk0WEs2aXRY?=
 =?utf-8?B?aytwNnA3cXVteEttekVaVG1BNFpwZ1FsTEc2a201RldmVDZqeUZ2d2Via1J6?=
 =?utf-8?B?dnpROFRFUTVNazhMc0VkaE4rcW1sZldvZ1JFdEJIcEdFb1Z4SDE3alFmZ3JY?=
 =?utf-8?B?ZlNZdCt3OGtPeENaZUZjK3NzUndqL2cwSVRQSXZkQTFQdHhoMFh2SFVRdzN5?=
 =?utf-8?B?V2JuNlVFL0I2a1JtZzNnUytlbkg0NS9uSU5VdzI2QVgwYzA2TkJGcjZWM3JP?=
 =?utf-8?B?RzJOYUZMMUpkV3hWT3NVTlpXemhCbzFmczIvN0x2dUJGZEtrRXZZb1M5ZWJu?=
 =?utf-8?B?QzVnbFFOOUZYKzR3WVFCdzM5NnQwUWhqM1NacllxWkRvdmN2dU95UG45Uk1P?=
 =?utf-8?B?enpYRmplKzBpUzhHTnJnNEFqdTNGSFQ5Z2Vzci9semtvTzhHckdlbEVCYUZa?=
 =?utf-8?B?KzB5Wng4ZVZLZ0VoVDE1amxpMStxRXN1WjMzakNrdFNyV1MxNGdDTW1qOWxY?=
 =?utf-8?B?L0ZpSkV5Y2RDNTlmVVBLdEJ2WmIreC9saE1YMXVtRWsvUWhCb09LRlVWS3BW?=
 =?utf-8?B?L1p5K0d1NG9xVnRoRUZoYXlMS0RqR2wwSDVQMElXSHdqVXRkSVBlVTlWRXpM?=
 =?utf-8?B?S3R0UEt4Tmp6aUp6Ly92eER5VUxtdE14aUowdEZXL1lHWUlzMXZFSDJxdlZk?=
 =?utf-8?B?Zm9yWEJjSTZlNXNNNnVZdDhjdGxCZk5jYmpKR25IMUs2RXpFenpmMGFSTExU?=
 =?utf-8?B?clVLTHMyaWNzL1BxbEtzdkZnaC92NUNrVi93V0E3UnUybE1TR0VVRDR3RGRL?=
 =?utf-8?B?YnZaZlREdjJtZnRadXN6QTEyZFlWU3g5QVRQNXRhcmt5cWwwWUZSNFpmOUpo?=
 =?utf-8?B?MWhxU1ZTaDlCQmxqL0V6L1p6TVV4NXlQY1g2WFphOURPWkNZN1ZzcjdYbStk?=
 =?utf-8?B?am95WmN4WUZoTEtXdy9va1B0N3lCV0hJU2p1a2dxbVh5M3d5VURuZzRySWxG?=
 =?utf-8?B?MXRDWjZPMXN5NUVudkJ2YVF1SDZHV3l6SnJWaTM5Q25tNlNJVDNyY1pNMlpL?=
 =?utf-8?B?YVhvOG1KYW01eERqeHlKZGkzWUpiNklrbWJ4cWhTZ2ZiY2FTWmVUMGYvWVVs?=
 =?utf-8?B?dEd4bDV2UCtIbURWclV5eE8wYlZOVmwvODFQaG9Tbm1sdWQzejJGQlhyc0xn?=
 =?utf-8?B?cEtUU2VnZVMrZkZ0ODVDQy9peWwwMGpxNWMzSDhNL3V1MkdiWmFWcE1WM2Ey?=
 =?utf-8?B?MGVrSDlIcXp6VStodEhjTGhPSHZ5amdHOFJmTDZvWWNzdTZ1b3dKWnp3OTV4?=
 =?utf-8?Q?yWJZK5wkFBDVuAYnhz0v8xIZg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a30150-ada6-47e3-20ee-08dbb466e068
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:36:54.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mheaqWTEv+3Kyq0krkw4EqeNQhiyuR5tL7jFHywgDzQVUDr1b9Jsu9J4EsVPUQb7i0nEQOVCj4wwa494L1qVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 11:59 PM, Borislav Petkov wrote:
> On Thu, Sep 07, 2023 at 08:08:00PM -0700, Elliott Mitchell wrote:
>> This reverts commit 767f4b620edadac579c9b8b6660761d4285fa6f9.
>>
>> There are at least 3 valid reasons why a VM may see MCE events/registers.
> 
> Hmm, so they all read like a bunch of handwaving to me, with those
> probable hypothetical "may" formulations.
> 
> How about we cut to the chase and you explain what exactly is the
> concrete issue you're encountering and trying to solve?

Also, please note that the EDAC modules don't handle MCE events
directly. They act on information passed from the MCE subsystem.

Furthermore, there are other EDAC modules that have the same !hypervisor
check, so why change only this one?

Thanks,
Yazen
