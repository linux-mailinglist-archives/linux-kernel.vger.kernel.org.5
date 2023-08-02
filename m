Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F176D554
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHBRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjHBR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:29:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545D2D69
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq50duIz+YBpg8garxRU5FRyDqSYOwxZe7NGLTC77dE1j1cY00hXq4TAdR0nHGzVE1D74TZsIkBgRza6hdVYnvwPa5yVGEPEbr8jynICVr4g6Igs6jI4gwMIibZuPmvxB1TD+rbgK9S+giGtnNdpwRlZM3yLnNyKPF12YmiVAjQS/7R9f0rqEaQCxQpX2yXK2Slo67BCuhe8xio/GBFWU6HzpXs2B0505vUBAkZSgEZ4yuvZXP9kVwQWdJQ6ZChLLbCAFCvOx6eAVTJ0wnxLnMMx7G5sBx88tc4RLfDokFcV8f6s6oSTNKeWTLuDDr3julEWz8/F9MtKcQissc2U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0Zu0LV9Kf+x40iaTfu4K8ne0qBJw0PIq2DUXOSQ6EQ=;
 b=cTPq/UHHvaRMQa5YoT0V6HQZ+ZnhuSaS93vVO7fF5mAhAfRumUMFUQOckBMYkqdrLTBrTW1hK3iviv+6GU+8o+ZDRm+CXCEntXPGkA2d4qe7rFfFubAxNRBfKoXAI0wpC84a6AGZGIAnjGfyvvcrWAw6qlij4U2mypEtQvVvxALrfrnTIltf4nfl6tV9tFXLMOA6z+RiAhBnIUBwxXsRzmCvTptdvzQcH7u71Qq17QTJUnCwpHi+4yR8cMkWndADJ9ufz7yylEeoAuj7V5wWBg020SAtaSBn/oOakRq6A/wyoToocx8H6e5/6vmDvDOO++NhpOx4nrBw0CvUOPzeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Zu0LV9Kf+x40iaTfu4K8ne0qBJw0PIq2DUXOSQ6EQ=;
 b=0VjFZYbk0p245K2N8guMIBYKriVU17Eut5bqYRLaWXs42BmbnKRIkpzMdeCOrJjTvAl7G4+HTJVL/+XYStL5ifr/Mob1OztN5lrtOm8bI2GlpkagvoJ3AOcs7d0TVUMU8nsJXXFTUIWSt3slz1B6moPeKxd6DsTycvhKEsjwPLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:28:04 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:28:04 +0000
Message-ID: <ca7bc694-b7dd-6699-2fc4-aca046377194@amd.com>
Date:   Wed, 2 Aug 2023 10:28:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next] iommu/amd: Remove unsued extern declaration
 amd_iommu_init_hardware()
Content-Language: en-US
To:     Yue Haibing <yuehaibing@huawei.com>, joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230802133201.17512-1-yuehaibing@huawei.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230802133201.17512-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::35) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: d262f06e-642a-47f6-aa4d-08db937dd43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcKayLVcHEqm+laCZYOacD1urs6bSwwU3/yupfgGwAuZNJnPhhzHCJHMOQA5nU6OK/izZl8QTKPsdY9oeNmLnTcsbxGQ9RRvbtSa/UhB4Xg2FrBFXWvKEOCtoe0rjnJZPrfOgJrH9j3/NL8HecxOxg2dPVkSUN+imEWJikXGRzROPm4aJ0FG8vlT0ASCxeC7I0CBjD2Q45osffeGEmNflxNR2PFgbAwCkBXeMf9tYCO7OPGHRpUkpBcw5Z8AZfqcf3ILoDlnzSKZFl5lKfz95l2393Gc73kLsdT7eOtZigU1JxJBRM8G8QBX7aMaHplHmckimGuQqddm6qLsE6zHUcM/VCFxQ9imrQMbIGXvQpkBlFq8NMfiOfN6gAPbEJXReO4aKiMDO4B5GEoBWsZgmKCvU9b+K1vGdUChVoniQTSeLNP+UeysjGHVqjGWdcNZWi+HEbTGCBHub31J1qZGB+S3ziKDvtUouaRiIR3U5bOlQ07zcvRn5CrE6ukM/CPNOKh734vr2Z1yM9cgEzDIpp7O5j55/f3C9EyVbyP2ssdUj1rP3WsASp+YMtECIL0xHIzuQeeZHHTlvKxwI7+V2B06Aju8nXfYIEgQbuYOhv022yhFgxvuQ83OOzSuhwqONXO01sV0C5UtqU6RfATTvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(66946007)(31696002)(66476007)(66556008)(6486002)(6666004)(6512007)(2906002)(31686004)(4326008)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(2616005)(5660300002)(8676002)(8936002)(26005)(53546011)(6506007)(186003)(316002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09USDRhQ2hoR3dVc09MN01haFBmZXlIcUFQVmEwY0JNbjd4V1lNRy84N1Rl?=
 =?utf-8?B?eXkwbEV1NEVycVcxTnRsNGVuSm9Sa1dvVmdOa0FwZmRNYVpIZFJGUUJlQjJR?=
 =?utf-8?B?emRpOWQ3MkFNWnJ0VytrUjU3blRiRnRiY2c2U2ZsVzRoMklCZS9JTWdLdmRW?=
 =?utf-8?B?Q0NzSXpxRjNvczRUam5KUW12RjQ0eWs2WTBMcTJTd1JCeXg1Q0ZWOCsrUkpN?=
 =?utf-8?B?L1pjbTVTUjdtbUIxanpNcjdIak5vbVlxcFRwT3hzenNtaGxjMHRKZWduYWg4?=
 =?utf-8?B?RXI3blNONnh0WC9TcEUrZnZLY1k0SUsrWnZRY1BaREk0UkltdVFKQzR1d0hD?=
 =?utf-8?B?M1RCWVhVbEtUaXh5amp5M2I1RExDWGZ3OFp4dzBFMUN0TmJQNmw4dGF3VUpv?=
 =?utf-8?B?Rm5nTjhQM1dvRm5wb1B6cjZNQ0VhSGdabjROektYaVE5NTUwQnNiZHRxaFNm?=
 =?utf-8?B?dUFGWDBkWC9kcFZZVUsrL2J1dzg1RVQ3Q2tkSUJWSWx1Um5ReGFtSUx5V3BC?=
 =?utf-8?B?eDlwQTFaSEc3UHJGTFZGOGhFdHlNWTcvZWx0eDRwdkF1SGw3T2Q2SXpEbmpp?=
 =?utf-8?B?ZE8xSWJTMmlyTmZXV3dDeTNwcGZnSnhxTHAvUlg0d1VRRkR0YkF5NzBvdW9C?=
 =?utf-8?B?aTRKdVpyakEwK1RWTUNzQlV0d3VLZDdUb01jbmlzMXh6SG9uT1BUcnpQdkxz?=
 =?utf-8?B?elRNeWlpaWNXUGlXRWdkU2ZCRndvNXpvMHNjc0ZCa09OZjNBN1ZCS0lrdUVU?=
 =?utf-8?B?VXRsM0Y2OVVWaFp1b1Ixc2FpeDhLY1k2aHIrVGNIYWpmNUhsVnh2VU9oLy9B?=
 =?utf-8?B?SThrSDA3REZRa1dVQU9RNWNvOExOKzFGNGdKZlFka0tSbml0M1FxQjFrVHJn?=
 =?utf-8?B?cDlQaWl0YmREOFhqL2xxWmhDVWw3ak1HUWdoSG8weUlxTDViSnQ1cFN2aFBw?=
 =?utf-8?B?Sm9sRGtEekUxWFFMRzNINlIvbk5LcmtST1A0dGY4UTY3SVhxcUY5MXBKdnVi?=
 =?utf-8?B?ZWtHeDA2aHhOQzVkaXBXTFErSjJSQW1qWVRpSDFKMmpyYkRJaFYySkNzaUph?=
 =?utf-8?B?Z1FlSHBzQVlzSFRvd0k1THlnU0NLQ0dTNUtFaXd5dk1Sak1wc2EzMUVKTnlr?=
 =?utf-8?B?Mm1qMTJTNFBSZFhPb09VaWxxWDZFR2d3bjYyOC8vQ2FwZjkxZ3ZyWEF2a3Zl?=
 =?utf-8?B?c2ZRRk9OT1N5ZS94VmZJS2JxbG9oNzlpeEp4bmVQRzdtdkQvKzRSTHJJUjk0?=
 =?utf-8?B?UUtRdDhmOElGdStNWUNkNjV0TXJFYzRMWXBOOEppN3RrakJpNkRnRjQvMjFr?=
 =?utf-8?B?cHdROVR5dGtUb0lFZWZwRnFMMkdPUEgzR1B0bDBhckNLdTdFcnRvVWtwclNi?=
 =?utf-8?B?aHRTa2l5V1M4Y3ZRazNGSE9yZ0N6clQxcko1b0ZMWG1oUytYc0J1OVR3QXlt?=
 =?utf-8?B?RCtaUk02cE5rNDZhUGh2TVRORXdmTjNpbDROenFDQzNYbTZxblRFWmo2MHVC?=
 =?utf-8?B?bW1Gbkc2Uk5xQjMyUElya3FHMHJ0M3NiNHcxaG90MXRHVDJSSEQ5RGFkL1c5?=
 =?utf-8?B?cTB4djA2aEJTc2VTK3R4di8vZkNrTnhWOGFzbE5zSldFcTV3all4c3dVSk1y?=
 =?utf-8?B?R3o0WEFDYUh0eVZCVjQvR3FuU3ovUVd2Q3ZKcDh6UEZ2ZjY5RXRpOWVQSlJX?=
 =?utf-8?B?M2Q0dkx1MGl5MmZXV1g5Zm5xeXBKZDh3dTVSQ2NVOEY2L1VNc0xsd1daSTBE?=
 =?utf-8?B?R1k0RWd1OTh4VCsvakh4NGRQSkdiaEFvM2lRQUl1SEVabUExQlM1NkU4UHJx?=
 =?utf-8?B?N2hZNjJPcFFmd3E1QjU3NUVJdVg5dzlLNFpzeWlvWStvMGxNUGViQlp1amxO?=
 =?utf-8?B?WmUyY1cxRlQrNFB2MXJnWGpvcU54UlVOTlAxYjBJS0xRUHl3Z3h2ang0VTht?=
 =?utf-8?B?TWU3NGJOcGZLRlkrTDNHRURiYSsvRmg1c254c2FNR3I0TjlBK3BmUnFnRUQ0?=
 =?utf-8?B?RGFJQStFS3NFdDhCVlVDVDVVSGo4bWxNbFg3L3QzZTVac3FmZHRQWG1oekl1?=
 =?utf-8?B?aVVmRGl0UUtVUmFOcHpiZzZQNnVEMmFGK0JMTC9oaThiWFJ3eXFYMnkzbkJt?=
 =?utf-8?Q?dr2QQCIeDga+aPX/IKSjFcaOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d262f06e-642a-47f6-aa4d-08db937dd43e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:28:04.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0CNkL08W/bdo2Ne6auA5E3/Qno7De9q9QUnuEtlPAdwA5J2GfSTW+5X1FEosx5G2tb9txXWOQUae8Zbket5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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



On 8/2/2023 6:32 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Commit 2c0ae1720c09 ("iommu/amd: Convert iommu initialization to state machine")
> left behind this.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   include/linux/amd-iommu.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 953e6f12fa1c..99a5201d9e62 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -32,7 +32,6 @@ struct task_struct;
>   struct pci_dev;
>   
>   extern int amd_iommu_detect(void);
> -extern int amd_iommu_init_hardware(void);
>   
>   /**
>    * amd_iommu_init_device() - Init device for use with IOMMUv2 driver

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
