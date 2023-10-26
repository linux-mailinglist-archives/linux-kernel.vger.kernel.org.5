Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1A7D80C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjJZKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:30:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4CC1;
        Thu, 26 Oct 2023 03:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbKnHKl/ttGRLnsmKqFRvJXmBWU8hfMORFlyE1x+d2TS+AOZlaz4gb1vzXjFziUxtS4u8jIZgrsLr/WpQAEIxIAkmW+InRZmq+RreoneGZzzKRxglvGIvHtJEnkDDjzxmCgQxVF8PbKNYE5y55dV6Z1V4QEyNKaLOEc4KFbvN6CC4jqldMUonCvns4T9M4IiUTDwwgUEevGT0Yp4PuktGeEaXY+7xX03pc1tGMHfPnC40L6GBIN4t3wv35ahXlJ3LLEvp1fgNDu1wWUOxTXMWFXDDCymjgDNiM1GBKWWE1q/uxXfiVSyJ7h4Y/JtRkiJqWD28yuossbWane0FkfXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKol9GiSsBhZk1fPWVBsEM4LYi5vN/TiGdUqHSpmw5k=;
 b=cUcpK01Qh7hnzTj7GeJF3WFG9kcF/34f2/cLw7nZo6K3gNly2DDgZ0MDwY1lIdaYInPFG/+/HulEMYc5Gf9GhzlRyA81FrT6yZHtyDyy5xPTfF1yueOwWWvs5SgC4MWvs8hDT0rmFYTjiVI4WJ1Q6o9xaZRiAoFsYegV0xlvtMeyWj8UD6kbFKIXwDnGPv1FOxnYxpjZIJGAev5xxlJjzUsfjILbgrSIJs/H8j+n82i2hTA79QX60Tx9bXK14SV98Plp/UwmQLEOEQ8+ZTXEdM/eJmu8g9JKdr1vZqUlJvmhdRn8PKF5xUb79uqgl6PlP9YMaypaRN//brhxFGHo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKol9GiSsBhZk1fPWVBsEM4LYi5vN/TiGdUqHSpmw5k=;
 b=fkZFSgoQNdgnohTUQLrL5DTZwn4V2SH3+KHg/jDLZPMfkNGb5ITF2uVucLwykHjq+oRZZzL2SIJhDnEzt+HefnqoZ8qxp4pprLSyCLMINbu9Cr/EWEnonDSETsrICR9zxRwl4v+sMklhgJi6wLLIvvhPtrjpX5eKThjACrIoDdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 10:30:19 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::e7cf:9e58:4ad4:e755]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::e7cf:9e58:4ad4:e755%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 10:30:19 +0000
Message-ID: <4a261870-03e0-49f8-b968-4cbcf646d9eb@amd.com>
Date:   Thu, 26 Oct 2023 16:00:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared
 memory
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jens.wiklander@linaro.org, jarkko.nikula@linux.intel.com,
        mario.limonciello@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
From:   "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: a891a667-8b4d-4cbe-03f3-08dbd60e8d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Y3LIwKGUvpadDlxlVXkzzEj7ktTcuP5CPTgmK07E02SC0BOYp4SuBh6Cg0TVhk6lxBUl/DQtyk5FY9NZ3bTKowK9tU+dL7nqMftJ2QvWf417XWv1Nr8T+MnQY160AIS4PSegaYbSOfN+/AEhk0ARIWv9oW4Ug1FfeuhZ73WDeJhvQiKmhdW40SeqH31UN4SiAHNxcEpKw8sW8CJxCZ5ibtv9B1m1Wd2giWTgYNseOax8/vHgPBXvwcVQqICyPcPSXTDHSnAJs1d9sZymv/+RJTLtYHvcAX4BiK1eLz1xEjrpMGBDYYGGWz+CoD6GiXpQlPsCF0aoRXhWBLBnQ6aU4drhZDdrEtLceN/ak0S0TRGP0DyPT1HCqm9cEHl1Ug/rnmzlljgVxuFcm1vVMvxyhi4d4b7FF55bv6qN6RgAsy++GRgcIrlpXuuIegl+/vbqs7tynh0rKPSNx/gWsfiNoLlZCBObcKaT2zl76Eua1HidAq4sGQxJmHUmf5RKrzINrsgDbO7O9fXi51PXthHZm1vFE6rbf5hLQhsh42p8LMY36nLEtPQT5rOQKJ+cr8yzOsfWmClQWo6+eTRaH3mliVjj0IRf9TNcOmar6kHUSEFYGpIl0occJxToUptrkt00SDAsBvlAVz9+tV+qsuXCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(38100700002)(36756003)(26005)(6512007)(53546011)(6506007)(83380400001)(31686004)(31696002)(8936002)(6486002)(8676002)(4326008)(478600001)(41300700001)(86362001)(2906002)(316002)(5660300002)(6916009)(6666004)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1ON21BYlEzbThwaE5kdDRSZ3pKVUNZV0RpSEhtZkJIT0szekN0Sjcxc1Iz?=
 =?utf-8?B?MVM2REszaDZpcjROV1BwemxPKzFxblZwdFJERlVxcGxIRjJEbFNBelNBVjl6?=
 =?utf-8?B?eVVod0pzSFZkWEJzRzFnQzVuZVgvVEN3YXV5WWR3UXBSVU5ZNG9SRXBZTEsz?=
 =?utf-8?B?YlZ4dXRjM0JGRlFzUHNjNHpSUGhPcDcxNHdjSFQrZEFaZkM2V0toekVEKzJ2?=
 =?utf-8?B?NEJXKzJwTHBxNUNwektiNXZWWXhWZVAvOWpKVzkwNXUzUndvbVJyZG5zNlBV?=
 =?utf-8?B?ZXJIb0NMMTQ3Z2krd1lKTEc3Zmwza1E1UnVjRHcrNi9zREN3M1BnOWVOeWxt?=
 =?utf-8?B?YTdFd1VRcG9hbWpFYXdxTy9KMWdiL0JVRmpYRTQzVmEyN2R5VGZrS0UyTnJC?=
 =?utf-8?B?V1N3enR4MnFMN0lFZUV2MVpEM0ZLaDFrMGhMRGNGMkUzY0Z4Nm05NmFhVTBz?=
 =?utf-8?B?a3Brek1uTVphV2NaMi9NblZZcXJ2MEcvU1dIOEhId1ZCM1pYT05lSXNCT1oy?=
 =?utf-8?B?N2Q4R0R6eC9zU2o1eEZRTUkzZFcyVGhPUGs1Y2tscGRyMXUxRWpIVHQzTldy?=
 =?utf-8?B?UzJhUVRRVDRLYkpNb2F0aEFxZGhBY1MrNDNPYzgxMzJ6dGtycjBKdVJUSTY5?=
 =?utf-8?B?UzFHbVJQbkhMYi9rVmdXaWN4SS8vK1ByR3Rhais2ZkRadTdvdWpoYjl2MHBN?=
 =?utf-8?B?dncwNFNXbXFQNTVZQW14OHJNVnFEaWRSNVYxcGpDT3NDZ0JIODJuYk5uZ3Vz?=
 =?utf-8?B?OE83akFxaCtEVkIzYVV3RVA5YitIRGxxU3E1T2VQUXYxa1U1ZFpwcEhFVGhv?=
 =?utf-8?B?SVdDN0xMK2UyTEhHdGhvckY0T09yYmx1WnRHSWY0U2o0MVJlc0ZrbFkyOWN4?=
 =?utf-8?B?TVRrcStJWE1jVGdEZ2J1TjZoMXlIVS95VjlWL0VUdEFyUHo2Mk11ejFiUGQz?=
 =?utf-8?B?WHZQc1hDZmp1ZnA0RWlLQVVZUTVWU1doUGpQRERETVBBdkdqTkhTTitpdFRM?=
 =?utf-8?B?bjM2bmhzN1dRTXNZSnh3UG5xeVozNHhZekNWTUtTWjYvc295NFpUNVdTT0xq?=
 =?utf-8?B?b1NOYldscGdOWHBYMkwrYTYrUU1yQ2g2a0E5ZWQrcVhxRndIdkJVSE9IdWRz?=
 =?utf-8?B?R0Y4czZDR1k4aVpWRzh1NFViRDVPU01lQllENzZUbE1JcUR6b2RZalZMZ3Vp?=
 =?utf-8?B?WEFVYytsZHJOUkIvSCtaUTNzWDFsdkE0QmxGeDFIYkVYVDlvUnpkNFpmQi84?=
 =?utf-8?B?U1UxT000Z3M1ZEVpcS9zZXlGQTUvMEswcDY4YXMwTnRCTnkyMW9FRXZBUU9J?=
 =?utf-8?B?YVRnSHVoYWs3QmsrTlN5SmRMVUNhaEczRW5yVmJ5eEJsNmwwVkVPUVVBMmdq?=
 =?utf-8?B?UThEK1BpTlh1VktUK0VJOW04Y1JaamQrUTlUc0NtdDI2UWd3TXJWMWgvOW9h?=
 =?utf-8?B?elVGNk1NQmxwUEV6MFZwRnJkNENucGxUT1ZjMEg2Mmx0TEpxY3RVSzNFbk5B?=
 =?utf-8?B?ZFEzMGE4Qld6Q1JDcTVkK2dUR2N3SHJjRlRuc01qWmRaekQyMk13eDBDaW1m?=
 =?utf-8?B?YStvRlZzbU9yanhOTVl3RFJqOHhsckNmaGtFR3VCZTAvbjA3Z2lZU1JFK25L?=
 =?utf-8?B?V1F0VnNOMHFXTDJmb3dFak5OUm95QjgrYXNUZU5EUEtQR1hyZkRHRm9KTllS?=
 =?utf-8?B?VUNKMmtvdEw4TGUyWHRMNnRQenpZamZONVUvN2xhMUd5R1RkK1k2UVdaMDJM?=
 =?utf-8?B?WFNoMWR2RHNFdDgrVUhjTENKZXJUbmFjMUtDUWFqbnBxc0R2Z2RDVHlHQ0xI?=
 =?utf-8?B?dzJDelVTenlDU3hLRVM4T0xOZjdUOU1aSGhVR210dU9UV1NBSitJZTlJdWQ3?=
 =?utf-8?B?UTdkM0Z3cDY5bjFyQ0J5N3RPVXF3ZWV4YUp0SnEvQVVCcHBLZHV0Rzg0S0hx?=
 =?utf-8?B?U1E0c1VUYXAzeG14OVd3dE1BUUZvbW1sY2FTcldFZHF3N1lBKytYekd1c2x3?=
 =?utf-8?B?YkxubVl1M3VUVGg4WWdFMkN6eE5FTi9VVkVuQTJQTnZMOThJRjBkNDFwT2Np?=
 =?utf-8?B?RE1zTDlLOVI1Lzk1MGxTVEIxbTJZSUw1UEtxQ0F0bm5wV3JKSTYrV2orTXF6?=
 =?utf-8?Q?q/dUtfpZ4NGJ8t2BwyjoLFH8I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a891a667-8b4d-4cbe-03f3-08dbd60e8d05
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:30:19.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DtgrDsaJlpOtuFBPRkBEa+do6N5JqE48qaN330x9jdgaBwXbQHRp+4TM1uTExnG+ua4GYYVyT9UyZB+dZvsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Oct-23 7:01 PM, Sumit Garg wrote:
> Hi Jeshwank,
>
> On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> wrote:
>> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>>
>> At present, the shared memory for TEE ring buffer, command buffer and
>> data buffer is allocated using get_free_pages(). The driver shares the
>> physical address of these buffers with PSP so that it can be mapped by
>> the Trusted OS.
>>
>> In this patch series we have replaced get_free_pages() with
>> dma_alloc_coherent() to allocate shared memory to cleanup the existing
>> allocation method.
> Thanks for putting this together but I can't find the reasoning behind
> this change neither in this commit message and nor in the patch
> descriptions. Care to explain why?
>
> -Sumit
Hi Sumit,

We see that there is an advantage in using dma_alloc_coherent() over 
get_free_pages(). The dma-ops associated with PSP PCIe device can be 
overridden. This capability will be helpful when we enable 
virtualization support. We plan to post a virtualization related patch 
in future.

Regards,

Jeshwanth

>
>> Rijo Thomas (3):
>>    crypto: ccp - Add function to allocate and free memory using DMA APIs
>>    crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>    tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>
>>   drivers/crypto/ccp/psp-dev.c        |   3 +
>>   drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
>>   drivers/crypto/ccp/tee-dev.h        |  11 +--
>>   drivers/tee/amdtee/amdtee_private.h |  18 ++---
>>   drivers/tee/amdtee/call.c           |  74 ++++++++---------
>>   drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>>   drivers/tee/amdtee/shm_pool.c       |  21 ++---
>>   include/linux/psp-tee.h             |  47 +++++++++++
>>   8 files changed, 221 insertions(+), 144 deletions(-)
>>
>> --
>> 2.25.1
>>
