Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044BD766BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjG1Lcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjG1Lcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:32:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560430F5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESyCcLgzD58Jc3eBXeLiO2ISMOnk2y2higR6me8WIdRdh9nkRBx2GMeI3P9IIU5UmD3k8UAs3+tKAjOB5kLIG8P4sFOtSJM1wHtxLVhKGwn/HHou7jIf5+hLwcXAK9oBOUoL6CpjJy7qfyRj3JQxtBJR3gQ/9QE34E4muYtSRmd40rNrwypPF7uoKy0f+Yq6qOM7h2S9hFulCKte+ec/jbHLArEfKF2508iZiNuoHd2ErfZwdazuECoFrZLw4sqLBqoqlnCp3oPnmHK+vi/ptGi6zhqrPDgR1OUOKiwCu1wrtEWDHmtY7YIs9RWD1PisflakWYibPn6uQHv96jTEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ1PckZ4/VrntHDfF++SA+C7NxUykydRfj3kE87D19s=;
 b=mNPVqjnQcZbB+EbTmdrSS+VhukZrzNrh2rNHQSHzrjaQO+Y2ma2LVpf0UOr5S6Ia+lBVyJp7d0fgx+PHfGD9x1dJLPyr83aevfbHuIOZiqn6KiUT48AtcufufJserdCq+GKkZW+L/v7+smMMUEI/nlZ5AFc77i+6HV/tMc5IqUzZYS/OA8y9oQ+eFHb5AGE6rU1q/4JFCSD0nWJONQ/Qu2F0yPRoMw8bBkycpbdRtyVK7ZsOj0xGR2eJo35b1b16YhKG67qipWOuN1WwjCby/e0H9U0NoMhG2SxcMQ9hpVdFvxHXM3exVmuDHQ3qPwWnPl41afeUKNBbiYcQjdRFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ1PckZ4/VrntHDfF++SA+C7NxUykydRfj3kE87D19s=;
 b=hQ+aRbSB2NbAYsysY6Sd3a5VHwKvRbU0sZS5p34tZzmIZwc10Fs//XDSmNTAQvnlYmNO2F+F1tjxvVb/FjXot8YgrF4stJTG2HFrQP+P9BCyzcIZn1RYbdGLgrPIaxGCODa2x9vp1wpo1luPH6QW1xf0Wf/yibPo9eXP4DrskRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 11:32:40 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 11:32:40 +0000
Message-ID: <394f79a7-e0da-a72c-2a09-c68c3cde5f1f@amd.com>
Date:   Fri, 28 Jul 2023 17:02:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230710112844.27309-1-nipun.gupta@amd.com>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230710112844.27309-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::23) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: bae97e7c-c9ce-424e-7af4-08db8f5e599c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6Dh85wgdqoJ2NBwrQ7tPUjy4anSmcmCeQWAf7EeFndDWVdpy76hVZHJOfpunBqOA4f4qNQE3/OIxviU+GuobDUAVGDWNyz9CMt1cMHgRnJX5+3H8xn/c07t/vHHzUtO2qBS/+TvYZHPIPIuxssibkYnK38nDyuNPDoKGcy9ZiTtdoziEdgH46NkQFRtpfFqguaBNbNJ0MiLDsFIt4QdPyGauv269NC/iJKFzXhWeznkUDGa0gWWGop6lqiFOBqomPGOM9fq5GjMvbFTUU4HwJ8XSon20fQBC0CSW1LR9DINRxdvy+4nT01qkTo14mypGINEzLrThic5vjfL7LgRYYyDtZG5W9j8zEhL10KUo19NMlaJ5cOR+lIHVB5natb/caK2TX9pkFGS4PkS4kE6R8xfNC1bsvPKPTRsaPuRZglHnJnFY306a0wzIz/pB7PoreD/cKaISQKImMtZdRiFd+p1q+qcRegi8OMQlse7fUZMrbiGlLFdhK/du1o7aUwHiMwGH4P/f1EYzlu1HoLdfGhdFlLh4Q453yFm718CE3BYLiy+6eDKNMBkzicE5/upcHLKx3SvyQZ3onOmj6nF9v1fpd10r6sK3Vr45uHhXoEHCr7YAMLkkk+EyuZ9Gr6EOEWguPV6/FJ2jPNZNNyOHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6506007)(41300700001)(186003)(2616005)(83380400001)(478600001)(26005)(6666004)(6512007)(36756003)(6486002)(31696002)(86362001)(2906002)(66556008)(66476007)(4326008)(66946007)(5660300002)(8676002)(8936002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0h6SFJJRi90N2xnMnp1TnR4MmxDWnNCVmlWRTRPaTNoM1NvQ2ZXSTR1WUZM?=
 =?utf-8?B?eHBNU3RIeFkzT2RucVJEbTBVOEVrV1FaNzBJUUVycWVuWVVQSWRSK1dVaERv?=
 =?utf-8?B?WVNTbURpcUVlY3lJdTVnK1lJVFpwOVVSSzk4RVBnN2Z4Q3U5YW0xRnlPUW1M?=
 =?utf-8?B?Tks0QXpMRXpick9PZlBlQW1HcTRYZTZYQllmNnVPMUZoc3FsdzlXcm42SlpK?=
 =?utf-8?B?MVBhbkRFeS9rMG1kcUZSOUpja245YS9sVVdpSFdyOTIrSS8yU1V1eUk2ZFZO?=
 =?utf-8?B?UGM5MFgwSXpQYWpJdk9yRzFVaXQ5bGxoWlg3dUdBeDBFMmVKL25VM2RzYzY0?=
 =?utf-8?B?a1ZUaFRkWmJhb2NwNS9vajBKVWRsM05jOE1FTUV4ekM5TXNUUncwbDhVNThQ?=
 =?utf-8?B?a2VaeDN4YjNDVnpTV0xFYmpMamdsczUyaGlhcG1DdzZnZTFHOFlRVTh6Znc2?=
 =?utf-8?B?S2EvK0RUQ1JLUmtCMGs5a0NpUFowd0F0MXBWTUdFVEFTR1c0QlpQMEZuR1RL?=
 =?utf-8?B?d0tscjdUbHF0aWJzdi9mN010T1lnT21HQWVCRXY3Z1ZJc29lNDF5a2RBQmto?=
 =?utf-8?B?QlNkdUVSN2VqTDJiMmZIUXlOZEFHTE02RHEzOHJqdUFVbGdCVWJWdGNMUlV4?=
 =?utf-8?B?YnhscTFUeUU0ZFRyblVDcjl2Q0kyc3IxS1cxSStNNzA2Q3hXdjF0akFONVVG?=
 =?utf-8?B?R1p6eFpDNHluR3JWd0tRVE5JUlZMNGp6dTlxOGZxMkpvcW84YU5wR3BQZHJU?=
 =?utf-8?B?eThjMjhLejhNOWlhTjU1S2JIbVRyZE5EVThHcEgrZ3JUYjVQTU9DZDhHbG5O?=
 =?utf-8?B?L2RzZWxRSldtVzNXWjBJeER0NUdNZ1N6ZXo5a2xKRTZ0cGhHaVEwSEZlUUdy?=
 =?utf-8?B?dGdQQmEya1pYcEExS21Ea3pEK2VTOTFPeVB2RWtKUVMrTDkyVnJsNmNObHVG?=
 =?utf-8?B?TW1ERVZVbWd5RkREVHFubk1hMm8wWnpGWWp0cElMNVNDYUtWYXlTLzBNcFNn?=
 =?utf-8?B?MlUyRFFVQlNYcml1bEhOLzFXNm1RL0N0ZXVvcERJd25lSjVpbzdzVGxndWRs?=
 =?utf-8?B?YS92bnhadXNleEJPUDZPelV4RVRJb2tLK3hKTGFqdzJqbkRhM0c5SVRxblpK?=
 =?utf-8?B?TXlyM25kMnRtb2JOVmpJWURJdFJCbU5UUGQwdzY5RUpSRnpqNGNWU2N0QWxi?=
 =?utf-8?B?SXd0eStBMG0wTmdiazZGWEpGWDgrQTBhMlR0dGtxUW1oSnkvZEZvVk0zV1pT?=
 =?utf-8?B?RVZ2SlRzRGxOQk5YVFg2NC9rVVNKaU9TRW5PbHhUbTFjckkrZXM5b1NVWlMw?=
 =?utf-8?B?UE9hVy9TUGpEdmM4S3BaNzQvWVVNOEp3OHdHMWhxOUtxT001eThvbDdvS1h2?=
 =?utf-8?B?bzg2cUNFUXhXYU1VVDJpNHh0ME9KYlBNZjVxRmNJT3ViNWg1RC9QNmhBbks5?=
 =?utf-8?B?aHc5L1FnYUY3azkxOC9MNkJpMFZJZFNpMFlURllxUVh6dlpneGNIUmFKQ2tJ?=
 =?utf-8?B?V1RhNWNxUmNHS2dQRlhyZVBwN2dROU55eHd4b1luRmVpL0FPQU9lZ05PV3d5?=
 =?utf-8?B?ZENKZFFwOHNIckxPeFFXUkZDYjBaUE1odE84QzJxLzJJUS9wZ0RZTFNrRzk0?=
 =?utf-8?B?bFVQcitMenVxSWg1YUF5dVEzTUJjT05XVVd3Z1N0UHVXL0dpSG9QdG5Zc1Mz?=
 =?utf-8?B?aHJUWmhpTUxrRnRKa2ExYSsyQXptWjdGWFhMMFZBdkZ1QlJWMG1aL0F2bkRS?=
 =?utf-8?B?ZkI2UVRNOVFYL2FLWEgrd1ZFa1hkYjNuenBFZHZ0L3hSYWR4a2VrZXZmZmRY?=
 =?utf-8?B?MWp1cjBPYXJCUTVYbHJieCtXZ2dIbUdNQ25pVCtKM1BSNUNXV3lqWmVxZWov?=
 =?utf-8?B?Z05KbUkzK2kzMFlaNitDSHlUOUJKay9aRUZXaERqV1lWSlpPYy8wSFhFS3NN?=
 =?utf-8?B?aitzVC9xMit6em51UHlXcHo3cUlWOWVVMjVSc2o3aHQ4TmMvU3V0SHJJcUxG?=
 =?utf-8?B?RThueUszTGFKb0VuZnE2enJzUm9xbXpyWCt3WnNFeEs4NkdnbndtZ212Q05j?=
 =?utf-8?B?ZTVyM3RETGNHelZOMm54YWd0S1lnSGdUUHJ1NmdwQnU1am5Lbks2VmhmZWpG?=
 =?utf-8?Q?w3FwYw6C3gnu2qG6tIJGK2XXI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae97e7c-c9ce-424e-7af4-08db8f5e599c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 11:32:40.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv4TxzqmzvBN1OlS0E0dwfQEmUgxlelYKwqvDx9K5DbkdFatGpOUKEv6LvZBsaCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Do you have any further comments on this patch. Can you please help in 
review of this version of the patch?

Thanks,
Nipun

On 7/10/2023 4:58 PM, Nipun Gupta wrote:
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
> ---
> 
> Changes v2->v3:
> - Rebased on Linux 6.5rc1
> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.

