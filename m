Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A547D3846
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJWNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:41:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E60C5;
        Mon, 23 Oct 2023 06:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNZdD+ow2pj6yKpzZ/RsrkIAB3UJM3ckWj5D/3C/fmoOJKPgpX1Ri5feToTsMUX9VcOlqrt3zWvX/x4APU+39hVzCRTd/wc61cTGM/8eX24tbj5urN7tApDV3qkJ9uYROFwarHG4gF0l9+KR+VznrOJ8d2/E08PUMiyexlNOvS2mJveF3KGUsn79S2iky0Mq/hLnlJajnZo/Ac1Ywfr6kIasDw/2GOZxC7TZLI7qxFJTF45nIEh8jpB/bgnkEWUP+xFj5rY/V0CMnRy14NwYo+y7KcFYgFCKDFgN0f0jji6LJuuQD7t7iwzIDD2VlWDtgzvpXiFb7/fISaMxEmnwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOLetiRZQbi/02o3DDapqYzkqoKr9iXfDuTz9qKZ7lk=;
 b=b9+cqmJYDbIKomCzjNJl6RUWRgw7Gl6UHWFhbDXUH63090XbClZCsYpdfzON1zMTZ5uB0M8QJh1r6ewQ6kkzimfMkCfUQMeWR6klmwVPwz3EyhVCcJCoGCinlOEJQXeC4XAyhujeDSq8XIyJxO3E0K1HG5MKhEuaNahY728nBmpUDQCRGBB1NNuugy3s0nvwAI1+teK6bmUQljPN8dlmOHOTcGM3+0XD1wye7Nkkp2TY0YGC78Cn7h8tIwZOjN24EoG+AihguJOU/7pOhBTTP17UafQWzKhcEg7KrUVizTZbeaqnRGjzSEL+1pCVcM7O+P9omGdCi9o24c9Sl2a4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOLetiRZQbi/02o3DDapqYzkqoKr9iXfDuTz9qKZ7lk=;
 b=XfoRKHikhIGKrYDbLMnmEEflJoXkBbwL31cm9F6x4tKpN8xKAk1TXTDh20YnCQqXP4m/sMqUPZv3eBQ37oxQQOiLaEiiHXszU+UGjM15QfFP6D1uvkHsqPoYCCy/P7BXTZQDfalLCp8hnyBU/EG1yHCKkAt1sIbgQi3XgmFwxso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) by
 CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Mon, 23 Oct 2023 13:41:14 +0000
Received: from DM4PR12MB5747.namprd12.prod.outlook.com
 ([fe80::3174:8c54:46f0:acb6]) by DM4PR12MB5747.namprd12.prod.outlook.com
 ([fe80::3174:8c54:46f0:acb6%5]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 13:41:14 +0000
Message-ID: <b41e2840-7e75-ea1b-6942-d0701262aca5@amd.com>
Date:   Mon, 23 Oct 2023 08:41:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: update AMD CRYPTOGRAPHIC COPROCESSOR (CCP)
 DRIVER - SEV SUPPORT
Content-Language: en-US
To:     Ashish Kalra <Ashish.Kalra@amd.com>, linux-kernel@vger.kernel.org
Cc:     michael.roth@amd.com, dhaval.giani@amd.com,
        linux-crypto@vger.kernel.org
References: <20231020212234.458371-1-Ashish.Kalra@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231020212234.458371-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::7) To DM4PR12MB5747.namprd12.prod.outlook.com
 (2603:10b6:8:5e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5747:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: bd40e295-3902-4b06-d7b6-08dbd3cdb9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xYVMlgiOAYrNSW15zlUlhLlJNHXPxFg2E+QwnkXzp36RaQ5oSld2UzJJ4tgUUOwJgar81kykLO/FefKg98sD5BzOlRBVfk8q0zgUQN6Gbk9ewsVNgC97+mGTItonAvKiKXcatmCYm9xP2pxg+RKH5x2aRVl3wdJxe7qLoV6B7GTMwk4cVoFIiYMRTCyHiRtG0LxNCe/mjJ/jrc+zURiMNACMOz2e47WmQJX2YAYYTaZMIKtmjLhBKU21e7+bX74zL6a92I9V3TydO6AmuoxOGw26IE+qpbZjTv1srGTwbcnAvD1uZ43vvgl7p9g4R1FJUcDm8cjvYhCWMy3TkChakbGyhUcIcv3rskd1/AUYft8GvcXiUkXwAOm/khBBfNkhbp6euafIU1TplLcv2UGf5FtNqhwnDoAyEegK0qYYmR7LKdam098QkQknwD3avDUXuAUR0xpSuW5em4gXdi9NjmpKuLNd08eq8SV6N+VXMivkLtClVsB5A+PG0dQVP7vt++Fm/yN29kJs46wtXLUKF/eNUn1hByt5Regk3OoM0YTvZAUJg6oTkHI3C7EYbGtiYyvnyFdXkEu1S3lddw4pJP3e42aK8khz+8bx5oEYRx3WZbeK37TJDfJsTbtmkF+BHTW7Z5jw/vVV12022PjGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5747.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(36756003)(316002)(66946007)(66556008)(450100002)(66476007)(86362001)(31696002)(38100700002)(53546011)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(6486002)(2906002)(4744005)(8936002)(478600001)(5660300002)(8676002)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGRpZGgySS8vOFNNWTNHQkliNW1DS0ovaGhiOXJ0Yk9hUTJmYnJhU1V2Nmc1?=
 =?utf-8?B?YVRIVUs3b2hqZG00ZWc2THF1YngvQ21KSm5VZDR3bENPWXByNEdTL3VsUjRv?=
 =?utf-8?B?ZElsUTJzMVM0Q2N2UHFTeFhCWTBDMUNoU28xTk9qZmFsZFhET1k5ZjZtM3pi?=
 =?utf-8?B?WVdaZTJtNU9kNWRSVlNNeFdpdW14T25CK2ZLOTJ2M1JkNmRIbFIzbHFvSlJ2?=
 =?utf-8?B?b2t3eFNONjdRbC80cnZIa1FEVGI2SDZPdnoyY2lBZ1dJbDRtTkNYNjlVUHpq?=
 =?utf-8?B?U0htbWJ5bCthbWhTWUptQ1Y0YzZRSlBpSGp0cmxBNWN4YjlxVDZzRVRTVlBY?=
 =?utf-8?B?N3dSZ3lVNUdWaFh1ZXg3dUg4MXNGOXNBTU5ldUMyOHU2Z2NOek04cWZocFVF?=
 =?utf-8?B?RGx4MlhLYnlad1YrL2o3S3hmQlFxWG00TFNReDFSaVArQVBON1dRWlBYSVpx?=
 =?utf-8?B?YzZ3RUVKOFdDNTFNcTF2NUhzRzYvRW9iVjhlMzdTVTdRYWNZRnVDek5yWHBt?=
 =?utf-8?B?TWxrT2VmLzQyTGF4Ync5eVk1VXRxclhuOGZRcDFxNzQvVnFJK2J0QklCd2Jy?=
 =?utf-8?B?ZEIvYmk0aDhPZ0NVMlY0bGdCNGJxL0R3RXBZNFgrWGtJVzR6My9EVEJGbEJq?=
 =?utf-8?B?QXlKSzVjRHppTHZuTkUvK0dCRnhxd0JWSkpFK0NTZ1FHelFwQk56TDUvSk0w?=
 =?utf-8?B?M0RYVWR5ckdMdW9IdFBUMWdlK1hBVkdWbCtKR3k3Z0VMQnhOaEY5c09UZ0dt?=
 =?utf-8?B?cm13T3NROUJsejZDNUpxaldleWJFQ0UrT3FDTUoyNUUzS0huVTRPVjhoUXNY?=
 =?utf-8?B?MHdIZEJJb21nTGRObXFjQzNuRFNGMlN5MlV0S0tudVN1RUx0MjB5M3dpbFFh?=
 =?utf-8?B?UW1uZVFOc0J0aXVrd3J6TFhUQ2RLTkE3TDRkYWZtcGpKM3hOUUZINkhneEM2?=
 =?utf-8?B?ckRDbWtnR2w0Nks2S2lNQnhFb2FNSEV3U1VBS2RmZGtWUzdrVlI0L2cvL0pU?=
 =?utf-8?B?L3p5dmVHQ0VzWis4cFhsM09iazY5K1pRVkZwOUpvcTRSSmJNMG9YbDFxbVpi?=
 =?utf-8?B?K0VFcS9nOTdWL2tRWnF5S0JPdVFiL1lqL3YwbzVsSkVrdWdPb3ppcVVVMUhr?=
 =?utf-8?B?NUtkanNvQ21JaStVdURSSTFobFFML0ppSUZGbGpaZTdTMjF0RS9WRzZUU040?=
 =?utf-8?B?bThSMlMwOFAzT2xyVUVzWGN2QzlnV0Y5YlZYZlBZZW5UcXkrNGlYbHRiOWFS?=
 =?utf-8?B?bGh1Vnc4SytzY2lacGJSVDJHVDlNeTFUaHZoWVpaTDUrWFBTL3JsL2xZZklx?=
 =?utf-8?B?b2FSejdXSXhSK2RaTzJzT1FuejhNMmdzR1J5NFBSaUtna0YvbXRRVWxxaitr?=
 =?utf-8?B?TzdUdjByeFcyRm5QUXZLVGJEWlhyblFSRFlhbG4xa2dFS0xvaFFBbTdSYWhn?=
 =?utf-8?B?c3phY1ZrbzdqWDV0dHYzeXVSaGFxbUxHVlpiWm9QYjFxODNEcGpEcEhOU1NL?=
 =?utf-8?B?VDhGZE9yZ2E4WFp2WE1zZzl5YWJvZXFyMVl4bUt0UHF6TlRYOXJYbXB3M1Nm?=
 =?utf-8?B?Z2hvNXFLRnRuUW8vMFAvQkYzZVJ5M2ptRTluYWdCQVRmQ0FaTmhxZWNFM2FU?=
 =?utf-8?B?a0d3MGl4eEJtMkZCT2RaWDJRamxwRWdobHE2dW5zL3NnSE1ML1gxTXY3MzZ6?=
 =?utf-8?B?eGpIcnlXWC9UcXhEbFNybURkMjQ0eGMvWUJEdUFVZDJoMlFBbm1TZ09JSXA3?=
 =?utf-8?B?VkY3eFYwd1VLOGFxZWZaVTZ1WFdaS3IwKzJNRExCcU94WlNBYzQyT1ZWazkz?=
 =?utf-8?B?TjFjbHBSZHVoS1RMQndkRkdRaFFXblFhSGZ6eXVkY0NSOE5NKy91U0U3WCt3?=
 =?utf-8?B?cUtQdCsyKzhHVGRONkJQdXFpV0Q4OW5GNDZHb3JJaG1ydzg2bHRtTG83VDhL?=
 =?utf-8?B?d05LQVU5UWk5YjhPZHBDa3B2NDcrRmh2bXAxZjJMcG9QMVhqWGNvM2N2eUxP?=
 =?utf-8?B?aTNsOVhlMzViT3RIekxwTjhSUG00Ull3Z2Z2bTZJdFZEWnlPMUZkZnFqOWN2?=
 =?utf-8?B?MitmY3VwQWtVM1hKNFJ6WnZaeUhlaDMxWXh3RUg4WUtqVW5PZVdBbG1TbnJE?=
 =?utf-8?Q?j3UVGSD9e/K1NE5KS4AgIma6W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd40e295-3902-4b06-d7b6-08dbd3cdb9f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:41:14.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnWSTZRFIaepdqcyiJyPYlfK5B77f/tP1jF7VDXAtDJtLsyNXLOqxqdRTaS4PJpwbU9tziMGJmC4h2qz1B3ejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 16:22, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Brijesh is no longer with AMD.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a7bd8bd80e9..a7c64d36911e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -907,7 +907,7 @@ F:	drivers/crypto/ccp/
>   F:	include/linux/ccp.h
>   
>   AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT
> -M:	Brijesh Singh <brijesh.singh@amd.com>
> +M:	Ashish Kalra <ashish.kalra@amd.com>
>   M:	Tom Lendacky <thomas.lendacky@amd.com>
>   L:	linux-crypto@vger.kernel.org
>   S:	Supported
