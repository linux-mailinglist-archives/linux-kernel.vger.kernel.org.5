Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1A7C660E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377624AbjJLG6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347085AbjJLG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:58:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50677BA;
        Wed, 11 Oct 2023 23:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZZu2rAcTefcGHhErmaSSxq5Y2HdSrdwPjrajJTonOl6uav+2V+Ke7Zoyj2XWJvWK5ZkBFiXrKkLxQxj9P6dy0skPUUY32Vmvyipjw+X8lcGZ7WXbbKPpt3CA+XKy2U1EwgKQLfMCzvcW4gxzr53vzUZf1QTLzhRJxrBUPeD1XnyVm76vKCRVU8l0mtGUr38yBJB+q+RLIhHmYp/dGULZ+7n33kjoCYpcDWp+NQH+EudayXEQPrfLKvhffkFP7NUZ5Dd7r1DxItAfSimNvRrhlfc+OfuSDgqSd1ka2UgaXo3VI6lb7eM7l5pMmDlmUssPYa2m6gd6O6vs6fsEqiXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3NV5BW6qTD09tIABeawA/Ym6wDcKBEj6QDJo2oCTrY=;
 b=e5xXFvF7pu8USVYStzF+ZhtuoDC+Qzo+ejI0KliTdrwbBGUu63cMuliLn4rtdVIQ7ewTuzE8UWSwqRl+8UGelbuH1gFCW+nPI2ukaqNjd+f0tgoIociU9ZdC0KHR3MdBrezvqBAgw3rsynHGMsiv/9RRghB3yCci5AlphXfX8TM4FrEYgV2VOX5SMsKrKXqCdOdoV5l73KBW5uu65fraanGIax9t5h275ydCqc8Qxi9YCJeLI+oyDa72uH/qfw+5nLE+EuQBdEkuKcP5YiL923hNJSg/99XrqKfTtwFXjY9gqEfRWRVXz6c8ZNUf5zJqmtpM/lh72/pQJiOWoHEu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3NV5BW6qTD09tIABeawA/Ym6wDcKBEj6QDJo2oCTrY=;
 b=h/lL5fhwyMUNTVIsDUulafiviP22+SSIK8cy0nlqPBPfLc91IyjeQJFq+MX3ZqxaglUL/15wBxOec6rELlZrz/dtmyvW6vPry+Ii+FGrSef8mtxW9Kj99CIJC7QXwsCoVUpU60DXHtojvZ/CuD+mbJ5HaSm+JaD6kF9yilbsaqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 06:58:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 06:58:10 +0000
Message-ID: <c90f5226-8a55-9a04-765d-104e54484d6b@amd.com>
Date:   Thu, 12 Oct 2023 12:27:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hardening: x86: drop reference to removed config
 AMD_IOMMU_V2
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, iommu@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
 <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
 <b9f08b19-80e9-4908-89f1-8712bb3b59e8@kadam.mountain>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b9f08b19-80e9-4908-89f1-8712bb3b59e8@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 904b0d19-7f55-4f50-9768-08dbcaf09829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjL+UnSrwVaWRUzkEet4SbYaYXKf4X/yiWLf4B/gLoOwdGTskgOwtB9Iaohh4mtZzL48UuN7EuWg9OKv2t3QtmUfQrXkrDM8uhuS7G1v4iy4153DDO3QUybf99wFAnwPjcBfZBFo698+C24cgAv8JuAPYgZwdFNkG+QuH8D8rouvyUMeGHwURvBF5ygjZDG7FKnaDQ7EV8tUgJAS+FEBOEQJpTgrCBZyFIkmkUcIzs4/AVJO/CiziqesBIhokLCcZNx4dBv+PrnNbCEvp0TDakiWddes1ppVP5K5q3BEvtcFbScTi6MriCVstA+nFJkyxh/zIW3pYcpxDY9qY7MJwr/qSGnxDJBne0d3g3KoDb0iH5IeQG/VHDP8tE9lSsXP8fgycTk2+cXJxNBtQ+b2UCayXRuQQJfxsmFy9bAvq+DH8/G9VyV6ELqm4UT3iBy12B2waH5af5yUnJNQG4KRxr5t3i1SMSO//T36949pOZRzuQZmUKTNNMhi/cCdpsJdaWlU+WyrDyVhTXRiR6vF3YVpPJI3/zOFW1uGYDTW7zxfC84KmYT7g59dtbZfB3QVTeT218rZr8Gj+r0pGkbFRR7Fk72Qr69oeWsHd4qTuQC3Y/XyxmY0GRW3jMUPoDEuSGA8lFXrZbftKk+9HpKpIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(44832011)(8676002)(8936002)(4326008)(41300700001)(5660300002)(2906002)(4744005)(36756003)(31696002)(86362001)(38100700002)(26005)(2616005)(6916009)(316002)(478600001)(66556008)(66476007)(66946007)(54906003)(31686004)(53546011)(6486002)(6512007)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ErTUh6YmwzZ0lPSUl6cmpvVmU2Uk9DR1NodXd1bllFaGdISStNR2Riczc3?=
 =?utf-8?B?dkt6d3k1OXlLdDF0akVaTTM3eFpZMnVieFdZUk80K0Y5ZmFrVElxMkd0M2Jo?=
 =?utf-8?B?RkQvOHd6b3UwUUJHZ0xwVzRicUllOGo2M2RGSUZVbFRtem9BQ1FmMGo1N1VR?=
 =?utf-8?B?Y0xjWWhVWThtd0lpclo3RWJmbnlnazNLejFDbGpQR2tWaVZDMjJOY0xxQ01M?=
 =?utf-8?B?dFpzbFFkSklDQlU0YS9nMFY5aUxKWk40VkJsSW9aMWtKMEp3S1prZjZGVkhF?=
 =?utf-8?B?VzhwR21PeVpVUXBZdXkvZFF6RkkyU0RwM2p6ZWJCYWNDMXZZMTJzejlRbnVK?=
 =?utf-8?B?aFNaMTRadlZoL3RmQ2F3VVdWZXJPZGY3RVZMcUk1VWlsZXU2STBpOVdDTUZT?=
 =?utf-8?B?aHVCRC95Z01lWUVrbEkxUkNtZTJqRXpqUXFaSXhjMmFjcVFQQkNpWUlWTHdJ?=
 =?utf-8?B?N0dIOW9NT01CUTk0RDdwSlVwZkZmLy9KbU9DTE1EOWxQS3lYd25UQUQ5SFh1?=
 =?utf-8?B?NmhEVXBIb1lIa1JvTGFkblNPYWhydzJqblFUeWI3QS9pcFJVYmpIMm53dnk1?=
 =?utf-8?B?RlFzbXlxM2UzTlprRlVQbkpRRVk2NG9Nay9XbG9COU5OdEEzVWJaMmk0Z3I1?=
 =?utf-8?B?TFJuOEN2RU41TTFXVmcxaG1oWm4waUtLbWRMd1J0YUU3SDBHZEkvZzc0dnor?=
 =?utf-8?B?a0tJcm9YdENWSHFRUWhXdTQ1MXFMT1k1UExpdUJrLzA4ODVBRWhmMnVvNFlW?=
 =?utf-8?B?UG5mNXpPMzM1b1lrL0hJbDZnbTJWNnJET1lxbUpwQWhlZ0pzMkpranlyTzZP?=
 =?utf-8?B?NWFIeUw3MTRCYkxubENITG8wMStKZ0VHdjJwenNFcVQ1S0cwU0xiVWNaUHA1?=
 =?utf-8?B?b01RSkxiU2t5QVpuNWhIWlEvekdZSllralRlTzdLUHY4TmxKdkZReFpuRTZC?=
 =?utf-8?B?dkJxK05yUGJFNVJEUEV1MEtHTDMyekF2YVM4Y0RqejZ1dXV0Njk3OXQ0eTlL?=
 =?utf-8?B?NUpxTFhTUjI0QmZhTmJaL2R1TUEySEhldDJUVTc0VnAzMStDajN4WHpvdC9K?=
 =?utf-8?B?d0VoMFdFRVVqQVFIZDdTM1oxZzBkNlNyTVhkYUVWWHBuRGtobnNkNDlaRjJK?=
 =?utf-8?B?eEFVbm0ySkpHSENDVTJidS9VY1pWZGlicHVGaE8rUjRtSUp6aU1YZGduam96?=
 =?utf-8?B?S2J2clN1WjA4dm81a0FvRUVueE1SbFU4YUFwL0lsR09QOVpvc0NUNUR0aVpM?=
 =?utf-8?B?Y3NrbkFKdW5CQ0xwV1RBK1Jad09sVitIR0syNVN2ZThHbTcrY3VSVWNjbVph?=
 =?utf-8?B?RmsrVUxJNndta0s4R2prS1RCRFNBdkdjZWtSRUdZT1IvUEVJNko2M2V5eFV5?=
 =?utf-8?B?NEhMWFhXYlpsTm5keDROcEw5WEl5OEJRLzJ2Nm5wbW55TkJwZyszZ2ZEblUw?=
 =?utf-8?B?OGo2bUNlcnBFTy9zMm96TmJyM21oazdyN3M2U0R6M0dpRXUzcnV2c2o5MmI4?=
 =?utf-8?B?ZnBGM2tCTGRXSEJsY0lFcEY4NW1GdWh5YlI4MHZuYUdMVUNhRERUQVlaazBa?=
 =?utf-8?B?YnNGR29wK1hKRER5QUdYOXNreE1tcWEwNWpxc2cyWGxrUURQMmYwUjVXOGF1?=
 =?utf-8?B?S2JpOXhBMGtDQnc1L05YZlQ0U2pKUjJqUjBvWjNJSVBYaW92NEFXRGlTbitk?=
 =?utf-8?B?QVdnZFdiZC8zSmt3b0hwdUxiU1JRcWx0eDVGTXY0Z0s5S3dZaG1aZkx5KzVE?=
 =?utf-8?B?ck9ZMmtaTjRoQjlSSUNCdFlOQnFyeURzUFBuemt6dVBRTm8veVozSmhjS3V4?=
 =?utf-8?B?OEdsemtBOVBWV1UvWXl1MHhSaEFGNVU0UEhld3lvdnk2cldPNnA5UE40Wllz?=
 =?utf-8?B?TkJOR2xJWU9xNkZ3THpLWnNYcGovV05QalNvYWR0SFIreGpwVDlEZ0l5N3dT?=
 =?utf-8?B?Nm9rZGUwSDFjdkJLcVRjRFZ5WlBlcUN2aDRGeG9zQ2YyaVBpLzYwRUFBZUht?=
 =?utf-8?B?UW00Z0F6U1ZJeXByZjY0RHc0U1FoQW1GU3ZUaUh3VjFHcW1HSUQxMkczVFVJ?=
 =?utf-8?B?dnk5bWZXK1FCMWRkbGVXTFllazBNRlJUMEttb0F5S05SeU1OZUViQTdRMDdZ?=
 =?utf-8?Q?+Ai9zZo1fSQ3ADrPy2o9TI7q6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904b0d19-7f55-4f50-9768-08dbcaf09829
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:58:10.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtQGjTzoNLKOR9TwWUMlyYB5CdBNRgSoN7bFiRQGk6eu17p8TDJfGYj8Oyio8ehc9wGbpbeGTEBGP+HD/KtxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 12:05 PM, Dan Carpenter wrote:
> On Thu, Oct 12, 2023 at 10:45:03AM +0530, Vasant Hegde wrote:
>>
>>
>> On 10/12/2023 10:20 AM, Lukas Bulwahn wrote:
>>> Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
>>> config AMD_IOMMU_V2.
>>>
>>> Remove the reference to this config in the x86 architecture-specific
>>> hardening config fragment as well.
>>>
>>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>> ---
>>> Joerg, please pick this patch on top of the commit above. Thanks.
>>>
>>>  arch/x86/configs/hardening.config | 1 -
>>
>> Thanks for the fix Lukas. But I don't see this file in upstream linux tree. Am I
>> missing something?
>>
> 
> It was added on Aug 24 in linux-next.

Thanks Dan. I can see the patch in linux-next.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant
