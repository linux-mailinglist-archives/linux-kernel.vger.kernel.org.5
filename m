Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764607AE98F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjIZJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjIZJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:49:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2FB3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw2nSgFJN3r6drgY4HUNAIjyI40DBrY/0g8QL7lA9bJDfu/VsI1dGE6ghDUVxiEfA+R5AivOcYjhO7asmYsPcIfHtMX8CpICP/jFTNJNQowjjgGRwZSXPf+VZX5uj0pJkdH0TC0g3xx1taHCT7+GY9nyH7BT9fUTwrXLLF+gLibMjUhnX3dTnTlHOT2T+pGfwUu9FXOsGxID+oJbr2iYku4w9+8JphCIiFMfQ2WaNlhfcL6kBvbrmS1L89cUnubitmzRtHRVfhYRpK327UdAbfSitV+aAUFisDz29Vu0dqJo4ZCk7B/4s3u0CTl3KymfMy2KxFMn+O8A4tT9YL5BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYPkzyhCjQsT4JbEqQ4a0Btp6SkZNIUnc6vJf78Z6Bg=;
 b=TRFcp49fgS6bsa0Ga12pJ+8dW0eKvOkfoqm7YZUz1U4W/D2RUy/CJs3C5zYjE0Rd/d8ZwKEMzvKCGl0RKZN4folr9lmzt1g8erB7qPCHoZfN+tU5PHIf1p0dRR+ZJn6CUtQRMQPk/NbPyBGLftfWMVi3Ap21zXC3pvhLfsp20tOBu8M+Hs5A+rymQRvEWCDxz1ry3lhroJ1Dli1dguP1MIAMmlk/9MuNYJk+ZFNOc+MgTW2Rqks/LfEzRFyF2WNzNDfG8K6NBt3dbwgjxwCxy1+WZ9vOUDB0IRTBoKKTpKZPBvko1RKQbhWj+2EDGZI87vBR0PLJobdwdB/afTjKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYPkzyhCjQsT4JbEqQ4a0Btp6SkZNIUnc6vJf78Z6Bg=;
 b=eF6yHguyD7RmE/bNpCw+4sqZNvcS8JfvObq5y++8FomoQb/hmN95RkWI+jWNqUMHw6DUjMp/qVtEj3WnXTSxQqkYD6kcQvFFJNeStdt8uHAsimkfNWVdvuUXNWoy0gXdWl3/hnoYuJezI6ed0PyruXl75CuRyq7yqkRdb50CeCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 09:49:13 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 09:49:13 +0000
Message-ID: <6127727d-cb4e-7729-5216-83c93fbb22ee@amd.com>
Date:   Tue, 26 Sep 2023 15:18:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230911135259.14046-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1103902e-e281-4027-5bb4-08dbbe75d6ca
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiXDXC6pEtFdaiXMhlit9pI9LoI0FODIRZxT8PB3k3BTHsYVTYrmrNNwjIWQIEEUVKfY0N8qouKqYbJh3pyrLiiytC2wfnUy4xzcuxV73DcScQEQTA4E50C7B7JvOgTmFALrYmRxJOEYstHXQ0NiZxKaWqUJukN1oMNhBlboXCm7VqF1xEN61WSLDB7yg+IehoxHH5i4GP/vjx5JO8jni0/spRYmV0QqeKIamT1r0ISv5h0Y/vsPp6XP46C+cFx/Z0lqnJMVAghz0pg8j4bLQRL6uIcxCVgapNdQMPgyFyMNHQ2EH0yrz6Zj11MpUwSUiMrTNecQqOJGUemjoqiwe5zxWL/ZzB2iHKw/6RVQv2wwYGzURV/j30sZiRl+MUAHBaSIONfoqdgLP3qBdkQPM58hl/cEzOJPPVs4C9x3UOIjFY2BDF4+eHlKqGd2qDPJY0VqWnqX+0rKT34VTN3+q0c9cJjx5748ShzYRC59VMeE3+KGGp3k/24NK1POGDBxuQjjRwoJEy/tz5rrS8XGlnX7P4+GBpjxHJ5zOE8tG3OKGu82KF+QZ/E8PSrKApWu5Xal61Ul+nELFtJY2LCM+AXlmEqt5GDYVCzH19xIIdGspodRk6t3mgmSrkEZHgXDJUnHcH4sXv0kPQ77JRpBpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(53546011)(6506007)(26005)(6666004)(2616005)(41300700001)(36756003)(316002)(66556008)(66476007)(66946007)(2906002)(8936002)(8676002)(38100700002)(86362001)(31696002)(31686004)(4326008)(5660300002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFN4TjZjZlBLMkNaNWtRK0JFcUtJUHhZNzdPOERDYUxxMGx0bVI1K3UvQWp1?=
 =?utf-8?B?elRVSXdXTUUzMjNKWnhLZTRWcG11dWVGajRnWFFiQm5pMUdic1RkZUhjRlln?=
 =?utf-8?B?TUp4aERkZERENi9zdGFNR0piSWFFSXk4Mjd3RkhVM0h6d2lVUzlsdlhnNXI5?=
 =?utf-8?B?N3VpOHBTYjA4ZTM0aEJhQVUvQ29vNmFpV1JPMmhJeWNCaGVHV3FTa0VKVldn?=
 =?utf-8?B?bXFUb0xxMzJObVY5YkpWQmxPQkVndDUxK0JaT2F6c05ObmNlc1VBOE14QnU2?=
 =?utf-8?B?OTlwMDZBRWErdytlclVuWWJmekk4Rml3d1o4K1VHaGxkR1UrcG4zb2FmRFVU?=
 =?utf-8?B?T0lOWHQySTAwMkNvY3JmRzhJWVBET1FKekhZZ0NxdXA4S0xDMmVMRUVSM0J5?=
 =?utf-8?B?K1gzRDhwcXBlZ2Q0MjgycTVTeEl0R0g1SFpFQ0h6SktxZytha29sMTV1Um40?=
 =?utf-8?B?VW9tSnY4Rjl1M3d2VnZNcm96UWh5aktDa2tDTTJFMEMwZDFjQ0RaUDVJQi9J?=
 =?utf-8?B?d3Q2b3RsV0dGWEFqSU42cnM2Ty9iMkc0R2lOcDAyTWQ4cDY2UVhVdW9wVUUw?=
 =?utf-8?B?TlpMa2JqNE9RMGtPRU5vaVdWbkg1U0xiWmpVMUtZNlhGekxudjMyaGFTRUg5?=
 =?utf-8?B?V3pZeUY1R1NYOWtlMG45Y3lNbGRuTllseGErQWhZdU1jdnpMUHFQTk1aaUZj?=
 =?utf-8?B?V0U0empPVktzWTE1djI0aTJ6RURRWUV5elVUN0dyWkRPN3FvUjh5R2huYlJx?=
 =?utf-8?B?Y2xzY2NqKzFOQjdtMWRqcHRVWEVrNHF4SXdoeWF0NlZwY05FTHQ3ZWVVdExj?=
 =?utf-8?B?VjFJMlpJbGR4eUpFQlRuUGRnN3kyejJxNEN2a2w2OFlPWG1yNDBKNzVyVlhs?=
 =?utf-8?B?SGdMelRwVVdMRWdtMHl4SzdDbGRHVlFwODZ2THh3SmUzaUVncVhVbnFva29G?=
 =?utf-8?B?TVNpQXRZZm0wVUZUYzVzR0NubmxTclBlRnJXS01zMmRRSmlhL0JhVWJBYytp?=
 =?utf-8?B?RlhSNU5LMlVORit6YXZoaisrK2pmbjQ3aVJNZ3BmSUJwaGdTTGd3THN5YXB6?=
 =?utf-8?B?OXBZR3JuYjhlZld2ZEtybzMwd0FWeUFZdlNURHNaSTB6d2xhd2V6M29xVUhn?=
 =?utf-8?B?TEZJeEJsZFg5c3dpcmNPc2RYTkx4MTc0SXFJSlV0d0tISEg2b1NsNTdjL2cv?=
 =?utf-8?B?UkdyS0tGcXRla2RnSnhrOFQ1V0ZoQyt2bnJIYjc2Y0tkTXVVSEJzMDhhUG1w?=
 =?utf-8?B?cDZqVkFXbEZqODB4aHk5WXJ1YkFjQzJMakI0VU1xamlSd0lKdVpMZ0hiL3JF?=
 =?utf-8?B?NitjN2FGTVZUOVlKNUxZWUo4R0h1bjBncFI4N0ZaSWE5R0RLZFFrSzlCVjVX?=
 =?utf-8?B?bU1LeWJXUjRFbm1jQXNiQ096dUt2VTBwWjUvTDFPR3ZtbWxJRmdZUUJJTjRj?=
 =?utf-8?B?U3p2dlhQVWVqVDRIYnpQMkdmdWVNOFpBdnZSc2hDV1ZaRVRLWGl2WWJVb24v?=
 =?utf-8?B?UG5EeG4wVmFiL21acTNRNi9WVEwvTEttRDIvc2c2Z0xIZGE3cytXZjJqV2ZH?=
 =?utf-8?B?RWZTTk5SUTVUMHR2d29sVWR4U3FNcTZtYnZWVUhXc1dWUm4xRnhqb2JRNUZS?=
 =?utf-8?B?ckZmRVpuSlRJcXhlMXRnYXlCWmZCK3JRY0hIekJxamRGc2VKb3I0MVY0Snll?=
 =?utf-8?B?MWFMc3RaUktGSGxuWG83Z0FwY25EaHhJcWxVRDJTS1pjcHNTWmRWY2RTRWl5?=
 =?utf-8?B?aHd5WXRKTG5FVEQrZW55S09FWjJDUlJxRkJwWVpaMVZtYUJQbVU3aml2OXAy?=
 =?utf-8?B?Nng5cGJtOXRQUmROU3dPcldzNkpYbFBMeEZ4dXdpY2w3OTV0aXJRdnR4dklF?=
 =?utf-8?B?MHRFbldEUmFDNDI1cG01ZjhXdjVPaS81eGpZZFByMnR1V3ZuaVNISW40c2Zv?=
 =?utf-8?B?bXdONE1oQUJualRVTzJuZjFPTkNNSWVMbkFzbGxvdG9GQ0w3dE5oTHJ3NlVq?=
 =?utf-8?B?ZDRvbFZjMllxQ3ZicnNNd2FzWXhlczlXbFBhOGk4VzhSODEwNTJJSy9MRDl2?=
 =?utf-8?B?L2prMTYyYmIrUHRrejR4TWs2b1dkeGVxMHJiS3l3clJIWGNMV0lpOWNmRDAv?=
 =?utf-8?Q?6LfPkHDwOX7lZRcrx4NCAO7fo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1103902e-e281-4027-5bb4-08dbbe75d6ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 09:49:13.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XExrUM5E5XmNvYUVqfLYMP4ITUqALex4FVSy/PtiyAFQobnmb/tybooBs9Lr9Wdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 9/11/2023 7:22 PM, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

Please help in making progress on this patch. Is there anything that 
needs to be updated in this patch for CDX bus?

Thanks,
Nipun
