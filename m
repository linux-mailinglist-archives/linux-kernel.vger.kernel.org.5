Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC3F7F8BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKYPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:10:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D73F7;
        Sat, 25 Nov 2023 07:10:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVz7Vfqhm9zD0s/E8C3htys+ChdIgENG4qmq9JXWHdycyTFP2wJAB9M4y1HdwZ05En/ChuBXEbTYSUxizEGUfffvwecJrARsrZ1X35ZyTlX+tpOuWv35qaZmMhmS4+WHiRKpeE1g1c4aNdbnIPUCKsoy2derouIPtG/8f+K06d1fqYFuyAvgcF3eZ1WGCF+UbiFe/pbiG69hCAs7Pn1njuFyb/ZEYLe7j7N4PJBSNMJ2H9hF3uP9MhzisZ17dEoHRaqVWE6qdXSw5RfuSwB3sjtxeeSWoVLQNV9KSnbUtFZ/99XjBQiY7lqlsVawJi9a3ERBtr+CaMvlhCVrpvbqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvul4LiikNP004wiqil+r2jbimyKb+4r4TP4iu/7Fhk=;
 b=NK8mdkbmt63Tc0RGKXeHDwcnp0v7IWFEcrX7PkhUA0xfQZlbk7rA9JyUEIM+nUPnBjhcpmtmfYCDF/RpFUBjOvbzVjGG2z3G21f6AYbBPhK9fnj6pVqYD5thSOhLupRnBBP1+zCp7o+pLgPgYKeQTKqwmDYKlCWzzqFlhJBuuvXI0PrTeH8C1PPGIMyiWebuflvVgOGitllg5fkCpFEI86m3k9jERUsZxGcizjGEG2LfK002U1r2dJltbn1CFzwg9UvoUFGsUyTD+lMLK2T6INXZMcNqvHzrYDwHpg5kZELEUTTcPBNIfOVnUeW9ScBmnXh4gBJhSsM0Gy68lJGcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvul4LiikNP004wiqil+r2jbimyKb+4r4TP4iu/7Fhk=;
 b=lz7RqUO8FcS0IwIzI61rujKE40D0k+ONoGKHkcSDbWSvzsNtdpeW8C/nlpKksEJv9EC7HNbsTmaW2hfg0LFGfGaHC0t2OPuFEP6h146It8VTaHXtCHmz3uAdTI9f4N4xMI174gg/hFtyBf+8E/akLGjcoZJT+kfodGTbEFlcuvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.22; Sat, 25 Nov
 2023 15:10:12 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 15:10:12 +0000
Message-ID: <3f033585-91c6-1d70-be1e-f083fc855aed@amd.com>
Date:   Sat, 25 Nov 2023 09:10:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] crypto: ccp - fix memleak in ccp_init_dm_workarea
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123070337.11600-1-dinghao.liu@zju.edu.cn>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231123070337.11600-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:806:a7::32) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a3699a-38a3-4f23-183d-08dbedc89edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weL7pahs3Ay/2ceu30JqAvnh2uhpLdHqhyTCwje/RdbP836SwLFOuVNIlJfkpWlKKQnY1fDbAPhqHiGLVP1cDCFGlaDjr8q3eFnWCBvbENs0ieVXP5pVV31djCR9c0nD6xeoQeoxAvSjpYEOvjT3GpRUFGuTWOt9wMViQdE+VuiBKJOMLWWrxWl8bCCt0DhuALGUgMRqrzj8lfaAiFlUnKXLx3ZXZ96lghRI5gL80c8KfmBPIHKUqaWJe/rkpMP2vY29RFsFUTP9BwVMJ3CROspKK3KNJwHrI4yRlFmM9gPJs0rzo48rFlE+XoGZqgr68AIA6TpU9X2XIWTSlfZSVhErRIfdkrQCxSWlJPGTP5WNBTn/QEw0iyAY0+aS35CFY79JeiCtf7DZPlfFJqaJri5mTqxbVzy0Yamw8MBKHjmmdjBP3V2L8zYeI3A/IYc0lA2bT5WkxhKC0WisikSxjm6tXbfGCdFWBnRxor3++9gQGR6r3qXkr78JJS4wUogjERKUJ2Zs/th8AqI0xTGikLFAKQW4nD4NO+KiB5mDtgCzaOeu8yP8IQrK7pKTQ32VxAJyYM3u8ZNE5IH3vRSfYkO2B23+GHbICtCwGXBmUlSp4xA4XWRsgZiAddRzrjDWdu9ynKrXzZFd7GSg1+eBYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(36756003)(5660300002)(2906002)(31696002)(86362001)(6512007)(6666004)(53546011)(6506007)(26005)(83380400001)(478600001)(6486002)(2616005)(38100700002)(8936002)(54906003)(316002)(6916009)(66946007)(66556008)(66476007)(31686004)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVQbXNBMnVsWmloWjVYaWtTczVqNVFGTTh1eFlOcjEzQ0dTNGc1YU0rdm50?=
 =?utf-8?B?NkZqRGh2alg4TS81dzd5TmxQVXRKTTFiN2V3REN1Q3F6TWRRVmJBaWpQSHdn?=
 =?utf-8?B?Zml3c0NjSy8yWUIya2Nscnpwb3M0TzJ6d1FVNllWSVhkbEZWOTQvRVhoMVk1?=
 =?utf-8?B?a2NnSURRUEMvSFZIakV4T1RVVTBIQVRiekVTTTdmYlFXekFFQUF5WXRZT0pz?=
 =?utf-8?B?L3IvRzVPOXZpbHJGdmZaM3BlQ21ndjh3enhhTDdmTDk1ZTkvRWdrNGVmMk55?=
 =?utf-8?B?S2dvcFFNa0pFd1drYXE3UTFWd0ROMmlpem81SUcrQVJkR0h2NGg3ZUNLWHcy?=
 =?utf-8?B?elRUMkQzNTZjWHNlcmdSWlU2ZmR4d21aeDZXUDBQU1ZWSnp4Y1c1QjZEUlhY?=
 =?utf-8?B?UkdaL1JrY2ZXMW9oZ0ZNMmJzMFNCb1N6VEZTb2pDRjNaQmNoam95NzNUelJQ?=
 =?utf-8?B?MWQyWHVjYUJLTTNvd29JRXpHOGFhMEt5d2xPRUh1alZmblREbGVKUXdURDdC?=
 =?utf-8?B?Z2xCR1BhRzY1TTBlRDRoNS82Njl3NUFRVWxlZnN0YlZZY05EWTNCcFNyL0hm?=
 =?utf-8?B?SmYxb2V0RklnVTlMTUNURXk1QWxJVzV6Y0Z5Uks0YzR3TG9wMU5LejI4emx3?=
 =?utf-8?B?RDlDQ21uLzY0YytPNEl5OXIzVkJzUkFVbnBjcFkvWFRKR3VQYy9xZ0w1WG90?=
 =?utf-8?B?ZEk0OFMvYkNYNXNYWVNRajVJZ3FwQ3NrUmlaNjBUdEk3UGV4NTZtcm96NmZ4?=
 =?utf-8?B?UU9tMGhIWUpwcFFja0RDdlg3aW0zUXV0dHJERG0xYWxVYm1KMjZUUlZCa2Rv?=
 =?utf-8?B?Z3Q4U2tvRGplMFpXMlRWdWNzR2tzMUVCYnVseWR3RVMwandpMGRxSzVpTG1u?=
 =?utf-8?B?cDJFOXBCZG9qWkJPMzFZSWtKVmRjdGs0R2JpOENVVXVkaVlDUEluQlo5WlFu?=
 =?utf-8?B?ZnpXZzB1K3pDR0xIeTB5dXh5K29JaHRYSHZaWGoxWEhLUThCczlZakhGNmRq?=
 =?utf-8?B?ekFCOUJ6Sk1BVEFneXFQR0FWVCtyTWQ4Q1J3SFJ2QWxkakpINnVFMnNhNnFX?=
 =?utf-8?B?RlVQTzFNR0FHSjBDS3ZvNUxvYlpzK3J3L2hQQVhva1BOclhEaGU5WFlBbkw1?=
 =?utf-8?B?TTVkaDdFSXFReDVDV0t6Ui9Lc0NHYVFPUWtVdTB4czRVSG5KOTdjRi9DNE9y?=
 =?utf-8?B?UWsyTVA3K2tvM0EwK1UrakZSZCs1ckwvWFZJRExxY01kUDB3eVFWZzJzcVZN?=
 =?utf-8?B?YUJjUjZLUko5RndOYTBoVThxdUFVY0RRMkZPVXBucHQrZURiV1lKZTBYcmJw?=
 =?utf-8?B?a21tSExHRVFBVHVDT2E3RCtoSXZ1YUVzMGRoa2pzZXc4WXlhSjI1Y3BaNlgy?=
 =?utf-8?B?MVg3N3VFdkhweUc3NHRSSkNyeExZUisvanV1SU9ZUTZEdnJ4cWVtT2NQV1Rv?=
 =?utf-8?B?Q283VHZoa2pCNStaN0d2ek5Fd2tnMWY4RUhrTlJ5ZDR4dzl4cnNFVTh5Z2tu?=
 =?utf-8?B?WEdGc3FtM2NZMWlJVjc4dmdjUnZxV0NVQ0o3Y0JyYmNQNHdDVXpya0xaRVQ3?=
 =?utf-8?B?VEg0cGVIUHpXUnFWVVZtdHVtL2p4VndVN2dFb2lsTGJLeURVQS9scWZkS0J5?=
 =?utf-8?B?SlM1aWxFWk5pQlowVnNEbjBzdEdxYzdZVDFhbHVXTUgxcytLNjBJUEtaOEVO?=
 =?utf-8?B?dit1YzRIRGNrQUZHM1VUZWdGSDJwUWlOb3g5dTlRVjhiU05LUW9zVmlTMm1G?=
 =?utf-8?B?b1NpSjhIU1FWYzkyeUt0L1lZSFJub2VoYkY4WW5JcFNhbWIvVzJoUnB3WHFt?=
 =?utf-8?B?US9mQzdITXduRGdhZmhBeFYwNVJHUGZTOFUrcE1JTVRYQVBhOW85NWVVYVpS?=
 =?utf-8?B?a0VNTjVoUDdJdy9kbzB3NlFWSFRTYUtKMHZGQWZqenQwWDdiN20wSG4xVVlz?=
 =?utf-8?B?dXUxbVFLTnBoWDhPTmJHWUVZN28yVlorMWFYNG9yMjN2NS90aGtRdE5CMmow?=
 =?utf-8?B?TVQvc3Y4NGhRZjBYVndSVGNUNFBDVnVDV0F5L3Y5NmVOWG9ORUxZVDVaL1VF?=
 =?utf-8?B?b2tHQlRxVGsvS2w2UG43SjllSjlrRGVYRDNIM2E4U1dueVJjdGJVaUFVV096?=
 =?utf-8?Q?sm1a32f5LOrlD9BaUVAN4BOcS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a3699a-38a3-4f23-183d-08dbedc89edf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 15:10:11.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFvNNc9xuJdaws5yW/1zsisfDBnxdUqqmodSTRVQROxWSPUU+5jyjZWSX0hjiH9veGHpCd89rVXwjabH2sU1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 01:03, Dinghao Liu wrote:
> When dma_map_single() fails, we should free wa->address to
> prevent potential memleak.

You should expand on this a bit more. The ccp_dm_free() function is 
normally called to free that memory, but many of the call spots don't 
expect to have to call ccp_dm_free() on an error return from 
ccp_init_dm_workarea(). Because of that, the memory is freed in 
ccp_init_dm_workarea().

So a more detailed commit message about why this change is needed should 
be provided.

> 
> Fixes: 63b945091a07 ("crypto: ccp - CCP device driver and interface support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/crypto/ccp/ccp-ops.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
> index aa4e1a500691..45552ae6347e 100644
> --- a/drivers/crypto/ccp/ccp-ops.c
> +++ b/drivers/crypto/ccp/ccp-ops.c
> @@ -179,8 +179,10 @@ static int ccp_init_dm_workarea(struct ccp_dm_workarea *wa,
>   
>   		wa->dma.address = dma_map_single(wa->dev, wa->address, len,
>   						 dir);
> -		if (dma_mapping_error(wa->dev, wa->dma.address))
> +		if (dma_mapping_error(wa->dev, wa->dma.address)) {
> +			kfree(wa->address);

If future changes should result in ccp_dm_free() being called on an error 
returned from ccp_init_dm_workarea(), you should add:

			wa->address = NULL;

Thanks,
Tom

>   			return -ENOMEM;
> +		}
>   
>   		wa->dma.length = len;
>   	}
