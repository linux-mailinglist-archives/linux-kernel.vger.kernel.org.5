Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E77E0792
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjKCRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjKCRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:38:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17FD55;
        Fri,  3 Nov 2023 10:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/hr8nFKI1IP0KuMWLk7bB/85uf76nzhGBRkjj4lxToa6aIRl2Lc+00lux1C9HYjZnTBX2a7yvhffBEOjkk5x/gzHyVjF72rMtg3BXtHWELAl1QcX8+/1wtWaD/GIiGRetuVpEeMTz8f3cajDhwUcVX7DrPa7VQGiHkiRF0A2FUDc6bIxLQtXOQ/AFc0gutVy3zABDvWp7Odbqgr9EK1ecBF5cHyr3ySFisuw59bVv4pu7Csl133w561qKzoGl1y2mdNVeRsr0zF1Cn+xPyIUGxNTrsGq4A+xBtIWUQ1arJFdM8WO507Apw8+ujVpwDhyB4rLR9BtZvrDUpc64MCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0ozF1gjgUDAL1RLCi1BDaXJ0vlcO/jq7+OdECVHnZM=;
 b=PNemjdiXjbQMadYePTMvaIeTP1BavmBijW0uenjMwnokUIPz4PUnrjJnyby0ZWdtZQIL1xwJ6vLcNwvbKGYPXsgkuhiU2I2YQngOOmXakd8lAn9oK+pWL+OKDuGOVj6p9YdQD6TSEn/skHR8g8jyKS4S9azwJHOa0m+CDp7BWCB1pMO0IaJlW1IQqRBcEGLVBK6aOfiljR39giJrgz3tYjFBWu0jQ89bFIhsNSUFo/6bqW7dQsm3lVEg3Nyi/zrUtlegKUz+c0jO2zr6Bp7UEXxtG/6b0sAtRm9N+Apg8WlBVtQzJFwNOM5bp3dUf4qaebGMXbXeCgT2QR6AnHt2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0ozF1gjgUDAL1RLCi1BDaXJ0vlcO/jq7+OdECVHnZM=;
 b=Ommqu/+H9feDdphHxygruSoa/ALEzkrw3ZLoT6chRFZjIvO4+dYcFIqC6X9YAD2cnswUIgnKjBS+1QSNUhLd90glkycmMlQm5JsF2YrEF3JIRJ3rnVDZPYhnZps5SpwAHfZaH8PzSabu1sT0c6yPaFLHocc6UA20RNRdQPfziHkPx2GT3ujWjP1TaRTb+NWkT2nxCMVENWxx3PQJ9i0tIkaq9LpRs9QTs37aTGFJKbUJlFAdUHEB0XTa6HJGBQMiKp/8abCshlZ+w5BHuqhEXm2KbkUMKAUFv4cXYWnt00WzMbk1nkgGZvVIr1WWYrJHw6gwdy6/wWaQorA2weTFWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 17:37:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 17:37:51 +0000
Date:   Fri, 3 Nov 2023 14:37:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 8/8] iommu: expose the function
 iommu_device_use_default_domain
Message-ID: <20231103173750.GC4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-9-lulu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103171641.1703146-9-lulu@redhat.com>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: f5375515-4675-41da-6ae6-08dbdc939aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgigNFdrDZ8+dR8zW9kZPVmic74pQ8CJObFNky3JWpiarqUMu6DzSfDy/+9/8y8W5+DMI4dFQ70zznx2UEJCmP0HAw49oOXk3oOe2R03zRKTgCeTwa5NRPuDs43r4QSH1bZhNPPBa4wh7/36AzRfVSzSedmDfBBYZL5Qaekev5Dudfei8154ZGA2IInuIQPWojHnVLewctCKbSTljgQMSgG5FpVBPtMsna3NrI0lfyZlcqr+kVtewF0F4RScxFtmgYSYyyi5OEWP+ajN2R0HnbKB7ad4+LGxRYn3rcgqSdmFNjVhRBVRDS+1+nM9+so/bKm4PtIUCLZvcz+YHQbCbMyJ/8hbwQxjWCuNkZgBLvqqfVsXaEO5YXGV58Y4LoUUSVxJM/bCD+zdEa9p104CwYQnLig/EqbX2HG1EHevsfzZC6A0l+HGB0GVGMJtDQfkhRNNNQI+aUurGdKbrYpd6QKz2+iBq+N0UYKJQZMBVeuwpRjwIJ0p3UQVt6dcyfgrpZBRKDR+/MPFxOUbrHI/T+pDs9BexCeoDGJhnc/LhvPpRnzodTpKMPyrANwTlZ/V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(86362001)(6512007)(6916009)(66476007)(66946007)(33656002)(66556008)(36756003)(478600001)(316002)(8676002)(6486002)(6506007)(4326008)(8936002)(2616005)(41300700001)(1076003)(26005)(5660300002)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2YvSElqVmFlZDljYnpSOUg0RHNsaklrdEN6N1ZLUDNGRVV2dlpocGhvMEV1?=
 =?utf-8?B?RGhHb3VBdjF5dHRYR0lMdFo4RDUzMmpnZmJsc3NwbW5tSEFnRDZQc0QxWW9l?=
 =?utf-8?B?Si9TeUx3ZTM5VDhpdENza3dRanhNMnhPSFNORjM4Mkl3TkVQeCtXTXdwTmhV?=
 =?utf-8?B?OGlLWXFWUmFXVkZNMDZQVnpWRGlEVlNCVEZEbGtTVytFNE9PVU9sQUdpZE4r?=
 =?utf-8?B?S08vMUh2Q2JHZnJ3MXRxTDdTeU9xdi9zTWxESFVKeUZCbG0wZ1R6SG1ROGxw?=
 =?utf-8?B?dkl3ejBOZjJHcXRXRzlhTU5SWlU5VUlKN09iMkd4RjVScGl1MlF5dzlzOWpu?=
 =?utf-8?B?WGdoN3ZURVJOakdqZm8wVHBrVkZ0UDFKV2NGcGNsY2NxMlpvTjBSUCt4cVc0?=
 =?utf-8?B?cDQ3dGVNNU0vVmRYeE1wQlNvS3RjR2szMmQ5a0VnSDN1Wkt4TGxWTFE0dWo3?=
 =?utf-8?B?ZGpXNXQweW5PSlF2cEhac3A5Y0V1WWxtc1BxOVY5Y2lqeVNTWW5FOWM5akM4?=
 =?utf-8?B?d3BBWDBBYmJlUkFNVXlCZ0RvUllHMUZrVWFTUCt4ajA0cEdwTFVFbzZrcFNY?=
 =?utf-8?B?aGp1UEZhT1R1SU5QWm0vQk51TVdySDN5WTNoTkxMVTduUCs2UnhNTjRWdU9L?=
 =?utf-8?B?TkpucnRpOUpUNUhCSzFOenFhQkFtWUhzdmFQb3QyNmFhYzhMM2xpajVSdkw4?=
 =?utf-8?B?WGs2RHgvVTdnYkV6MEhwZ1RqcjBkWlFiNTRTa3NtWS9wT2ROR2cyNUErakpI?=
 =?utf-8?B?RWw3TlV0TzR1aW5XdllybW0wYWR2SHBMRG5RS1QyMW1lWWNsc0RKYkVqTWJi?=
 =?utf-8?B?SFhtd3oweHNwMEtoRTJxczRBSDcvcWhrM2ZXUUl6OThYaG5YVEJoaGhxbTZY?=
 =?utf-8?B?SUtYUGhOZmZXbEtLNHRJaWRHUDFaSmJ3dGc0Yi9ENGRiaXo4YmxPZDUvaGhG?=
 =?utf-8?B?N05CQnRxU095S05oMGM5aVV4bkxwTVI2RUxXaWZ1YUJsM01pTHMzWGV6QjVh?=
 =?utf-8?B?SkwwdWhRQTRwTDQ5b3NWRUNyZmlrUm1RMjd3aUl6aENLKzRpOVRiK2pGcUZa?=
 =?utf-8?B?WFU3VFJHMFZaL0xzYlkyanZCODZlcFMrRUJYMlM5R3pPU2ZMMnNtQUpvbjN1?=
 =?utf-8?B?dTBPb3VoUklyY3JGM3ZHZUF4NjRQSVNydWRkeUdMVGd5K3BoSjdYdWhGMjl2?=
 =?utf-8?B?V3F0ODM0V3RXYU9vQ1doUzBTcGprOEJIc2FkMkFBZ0FaR0RjbWhoZUxTTXlL?=
 =?utf-8?B?RC92YU56ZnZyako0ZVVRZ0xFYU4rRHgycVhNaWUzOCtUSVhTbDF0MHJxbk1r?=
 =?utf-8?B?am53RWRhd2NiVW14OEhJV1JIdi9qUVNsbWF1L2h2cE9lenpFWkwzQ0VmTWlI?=
 =?utf-8?B?a2Irb3gxMjZxSTlISUNKSXp1VWdSZW00UG1SeTJPdGhza0tUc0pZMmtnNzR4?=
 =?utf-8?B?N1o3R2dJakFBQ1hzdVpqNTlMeTJsQXdlRU03cThQSThUM2dPQm9OVE9YcDJo?=
 =?utf-8?B?VE1YVUhuamFRSnNBMCs4aE5SQi9PVG45dnE4em1SbjllR1l6MlNoMEVKajJN?=
 =?utf-8?B?ZzNNbjg3TXdYcVVsdmFIcXluUExrMzlWTmtkMUNOWEF4WmltYXEvUDZOTlBF?=
 =?utf-8?B?a3VnSm0xZDdOUmt5eVo1Uk4yUW5rbWVxRjFOL2R1NHF1b1Y1ay9iNG9MSHB4?=
 =?utf-8?B?L0dFcE9XZXJZdnRzY3BCQ1RFNnEwUGZ4MGtoZm1OSmIxMkM2VmdPZTh0R1Bp?=
 =?utf-8?B?cjEzMWxNdTM3aXBQdDRjTy83Ni8yVXdhQWkzMzQ3RCs1VFl2RXl1VmpYTjly?=
 =?utf-8?B?OXBoN1V1ZjJocktVY3JvTzZocU9WSm1UMmtXZWFONXBFWUJQcTZFYkJwemVv?=
 =?utf-8?B?d0Fjb3Z4cDl3NnJEZnA5S3V2WHdOOHlJZGs0dDBFUnFhRzV3Q3FCbjhreXh6?=
 =?utf-8?B?L0Jia0NFMGtuUEZqbHhlYnZGb0lLNmw3VE9Rek8zeGxIK01XdVptUVYxTFFj?=
 =?utf-8?B?YldXVG95UXI2VlNCWmNEVTNRTUJDdWliN3ZQbjVFeVdkMnVMdm1SZzRWMzN5?=
 =?utf-8?B?RlRBQWtxN2c4eS9ZdGE5bVNmeWdqNERRZzgzcVRVbVNEY1BZUXdZbEhNcWNF?=
 =?utf-8?Q?I86NhT4YhmcdxgrZ5OY35yRub?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5375515-4675-41da-6ae6-08dbdc939aa7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 17:37:51.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+fOJLfbyybLgqAXkNsBmI4G7cAWFfuHbQ8ZpyGo98gYMrgpIisgqDeQMehWfe8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:16:41AM +0800, Cindy Lu wrote:
> Expose the function iommu_device_use_default_domain() and
> iommu_device_unuse_default_domain()，
> While vdpa bind the iommufd device and detach the iommu device,
> vdpa need to call the function
> iommu_device_unuse_default_domain() to release the owner

Definately not. You need to set the driver_managed_dma flag.

Jason
