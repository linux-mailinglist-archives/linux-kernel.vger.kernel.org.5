Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989A7BE2B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377007AbjJIO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376783AbjJIO1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:27:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB7C5;
        Mon,  9 Oct 2023 07:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0dQfuP97LW1DkYPhVugPP4lDc2/mbNu1tCjso9dEhZyzcSBEuYj1G9+6351hZ/3ZZ+WKZFguNZI6t+kYqZoXc2eqwNs5Jhnn4h5c7ybzg6QhaeGHAGPSgOpzh0iaWjpboN67iYKRhnCTSrr3/JZQqqW8XIrX9CDNPMYsDcs3igyCaEMlmRtzhKo0t3jFXPbKHohtvXuOYtLbLzGMvYRxAC63q03UZIeezDP7C39OSqip7eJar69suNp6AKURZFpuzbnCGHivDX/uxOyyYxFdhlMPWi9Bq+RRHI9jmZoOCLajWon4qLsUPSWkgfuuvzx9Gx7bIIVWNIUSw/9pbefqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5diiM82jbHUYkOJ48eJks7jgS7GmoFUorUGIGBIyQWk=;
 b=ZBIw1jL0rKhRv2FMcx/kxqvlLBZOrVPBoimgt/efV1mJEvT0DFsTJ2r6QoB8eYfDTOjJ82KYiABnGeRcrhQ6uEBDog1wKEmV3sAqNAx05AgDokSDtXFcgr6ncT4qWpom2LVsMPbPGkQskQn436EDK4SQygOKIxbwZHCCAohio+iHRHCVAhzkpCHF0cltYHpEhanm889f8ylMeTBiMtG1ATtid8jym7NVoSa1mxokhK+QY805TJ+auloV2dVLh9syELAKch9qzS+2J/sfsvG0uhQs3gZwNfCkoy3YunmqxRKkz9DRV6SnuyiHpAg6XlQCrPAc8lWsrBcFnrAXPozdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5diiM82jbHUYkOJ48eJks7jgS7GmoFUorUGIGBIyQWk=;
 b=1unzTRlLM+lnKJg/l58RzuptE3q0o5a2e+l06s+0gvfCkdS4ucXAGqUXJCjbOEtkJ4VWImzxDFBEHgtxnwLukcgQ4U0wa/o5iegvH7FeCPqnnYBnYkXOOcXuV8fw1MEQGw+I4KInARAyBMCY7EufYvbasqssAflYzWOtaAQRCu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:27:13 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::bc87:8b0e:246d:5d85%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:27:12 +0000
Message-ID: <64379000-de39-40c5-90a6-da932c7da602@amd.com>
Date:   Mon, 9 Oct 2023 09:27:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/20] cxl/port: Rename @comp_map to @reg_map in
 struct cxl_register_map
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
 <20230927154339.1600738-5-rrichter@amd.com>
 <20231002153434.000073b9@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20231002153434.000073b9@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:5:174::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c5a314-f107-4ff3-58fa-08dbc8d3d43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjpJl6WrKm/2NaAf6LPTgprP9gQItUKsW8i9yAeJfHWN10cdLevzBtdoszcmGmVoF/s+XcDyQQj0KfTHdVb1IzaLq42rgPcOdhYVgUUqw/LU4ANsIZew1ez+chpJ5P2FNjaulJyOEV1aY8rHSFszwnuPzD649jg0HanhShxaJ30+6L0tVWtbjC1/w2L3mOi0YCqDWkMWTv3jqJjyhV1RlGr50rKbj0X8T4KNdqB9ZkLS+EhmZaPgTC18vvbQRnTHG6MdmuV9US06+ZQkdJ4GP2Zu30i2B8t990I3lijgZt3EaQqlSOI7n/NQ095kxrXdNTqbFj0kTbcdK7BtMuIOWW1F/p9hES53rDzje2MTqilBWN7b/FNFnLOjuOj47a7ZXrJwE4xntPhDeOIuViquvrazoOh9K5AlP8kycKG10Y9ILU9kA8ednArnFlFcYHE1JZS3H/zlHcqT0ReIGvl6BAveLROIxKPwIbBqX5y9vL6ucZInsZLRKOJ1xFwq6xO3pjJMOOFA0EGIGeYqr3amxSFIXSa1S3MPl8aTDlLrZUyIQsmhoLTd/1od/dqwxaH6Os/6AdobpSYjLNOSd8P200PedPJ93kcEq8xusCeIxiveQnzipmn4AecQ09MphXL4PPMZG5fEPPeT5739t4r9hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(53546011)(6506007)(2616005)(6512007)(31696002)(36756003)(86362001)(38100700002)(26005)(83380400001)(7416002)(2906002)(6486002)(41300700001)(478600001)(316002)(8676002)(4326008)(8936002)(5660300002)(110136005)(66476007)(66556008)(6636002)(54906003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1o4eE1FY2Z3eGZIKzYyRHkyK3lqeXBNVU9HdkpWVGt6WGtobVZsY3VCSEEx?=
 =?utf-8?B?SDB1OHg2TWsyRVJJM2hJT0RwL005ZjFGOTVzOFlsN0hjMHZJSjdTaUQ0QUlw?=
 =?utf-8?B?QlRsd25lQlRoaVlOVjFweWZUQ3dKR0s1THJmamI2c3IzUE1ZN2RtY2hXR1dJ?=
 =?utf-8?B?alJLVlU3Z0IrZm1aZ0Jtc1dhM0VvMWRaV2VVRVNvQjFrS3pXSU9YR3FQMzE4?=
 =?utf-8?B?Q1BEaFd0czRkU1hzWHBsTlJ6ZFR2eUM1OFBoM2FjS3JMZExJakl4WXhCQkl6?=
 =?utf-8?B?L213N0hxcitXRkQ5SmZsQi9KZC9mamlHSFJiVGhFSmViUU5aMFJLd0tleWIx?=
 =?utf-8?B?dTc0bFZnTno5V0tpU0F4bHY4dzYxOVViN3hiR1Z0MVY2Y2xSMVFsZlNnZ1Uy?=
 =?utf-8?B?eUY4eUxlZHhaeGNVTnRzSWdCaDI3aERwdmNObCtWL09pQkVYK3JDV2hPTDQy?=
 =?utf-8?B?cng5WmI3ZXZib0EzbG45ajhjYlUwU01yUUFFMTk5WXpqVkwxYldsK3prRCtt?=
 =?utf-8?B?enI5UmF6WUtuQWV0UGIwSStSL2RDdTdlNUlRWkMyaWxPVXd2WHlabHBsRldr?=
 =?utf-8?B?TTEwRW96RGJrUUxNYjJmQnRBcE9RQUhpZGlyK3pvOXh1TCtrNkY0MWhLNzRo?=
 =?utf-8?B?aVhUYVMrMUJCejI0UG9uN0ZKdFFSaEFYV2hWRWdqWnBqY2IyNjYyOVdKUEJp?=
 =?utf-8?B?M0dGdnFLeWtPcEw3b3FSSWlTN3YvUC9Xc1dEenFtOHU1Z3ZoeFlmNlJuL0hq?=
 =?utf-8?B?dDh4dVhZVW40TTZpZ3VCNHVwYzJUdTJYTjFlbDBZaU1mb2RGMnJIVEJuVndM?=
 =?utf-8?B?Q3pCUXJ2SXdxb1l4b1pVdzRNc1Q5UWNmd3FKaG01czhWVFpZc2tseWdDMmFN?=
 =?utf-8?B?emt3OXc2d2ZCNzVkZ2cwZG5RTCsycXFxYzNJb1lsV21BSzdXelFIeTlxNUt6?=
 =?utf-8?B?MUFJc29VK01JRUtlQm92aUdBaHhxZjZkMVJ0YTBHMjZrTDk0akYwRnFFcnht?=
 =?utf-8?B?K3c0ZHY1K0UrK3M5SnYwTVlXTnlad1RxY3ExQkRzNGcvcmVPN055VzlzK0Zr?=
 =?utf-8?B?N1crbGplemZZb1U2MXVzbXRYQ3EyWGp3Nk1wdzB3cmhTYmRrcjRpVC9zcUo5?=
 =?utf-8?B?ZDFWSEwvQVRzbUVTNEZpdnFMUmQvN2hvRkhtd2hmd0hKVU9Eb1hPL2lRTkVn?=
 =?utf-8?B?a1NKVVl3Zkx6N3ZFbW4zNks5RDl4ZVIxM3hhM3drZUdqd3dVWk9RT3BhR0N1?=
 =?utf-8?B?aGJkZ1FDMHllVGNKMnNlSC8yQkpWcjhBV0o0cWJPZFM4alVnU3N1OHlScDZ4?=
 =?utf-8?B?N3NWcmpkZDUrNUxxdnh3S2VPL0ZmaXNiZml4c3ZuUkUwVzlNYk12c0s2MFZq?=
 =?utf-8?B?dnlGOWZxWGFhYitHMXFlY2xnalFxWG00RXovbGwwelBhV2ZJdmJjTENMMFFr?=
 =?utf-8?B?VVlvYXFudENwODlqS3pNeTRKblU4d2o1SHJyL1pVWXhOUk1ReDhjQmhhMXcz?=
 =?utf-8?B?ZjBIS1J1SWJ3UEQ1dENRcElaWnpmUTdMMXd5bjJ5K2FWdXhaMitQamVzRENK?=
 =?utf-8?B?eUNJM3FTTTQrS3ZEbnZCY0tGcXdVanA0Zm9jUGRhR05xaEJCTzg0ZStiV1lu?=
 =?utf-8?B?Z29DUWZZLzloWitweFpxOFgraERQRHZKVXJWTWhoVkZSY1hDL2Z4K0VEelhO?=
 =?utf-8?B?RWJvWFZIcytlaGFSN0FZQ2xUQU5aQi9tZDdWbE9qMlFCKzhDUEc5YktMNnJ2?=
 =?utf-8?B?cHBDZW9vcTM1dEY3ZlpTSEgvMHJ2aDU2U0hkRzFiVk9xcXYxNjdRTElXbnZ0?=
 =?utf-8?B?cEp4SUxrZXcySGZtbTZNei9BTGtkZll2bEp2ZlZZRzFKcVI3WkQ4VHJ4UUxh?=
 =?utf-8?B?RHUrRzNZWGIrb1IzaWFBZDRnbzdvUjZYMEYweGpEZFNnZkhLam5BVElvV01X?=
 =?utf-8?B?YlhOWCt6ZWlJWTF0SFpGWkg4WmNySFJvZ1g3cXg2WGl0STg1aG56b2s1a2V4?=
 =?utf-8?B?WXZ2ZjZFRU1jRTFhdG5rWlRTYWxKZWpPZitzaGhFQ2pweDlGOURaM2RZalpU?=
 =?utf-8?B?cEtvVFIvNUJJNHpmOVk1SkNtRGxsTUt2SkpGY2tRZDF2bk1Dc2MwS0V2a3FS?=
 =?utf-8?Q?BAHtypvOLyc5yHBQjFcMwavN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c5a314-f107-4ff3-58fa-08dbc8d3d43d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:27:12.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvGP20rFGeSoc3ICnua2U2GdIZDjQwC3sb74p0V4CL4G/16ddd/i+foECw7ByBDZvrbtq0ACP6F6O/0rnUiu5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johnathan,

Thanks for the review comments.

On 10/2/23 09:34, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 17:43:23 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> Name the field @reg_map, because @reg_map->host will be used for
>> mapping operations beyond component registers (i.e. AER registers).
>> This is valid for all occurrences of @comp_map. Change them all.
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> Makes sense.  Can we pull the one I moaned about in the previous
> patch into this one?
> 
> That way the renames are all together.
> 

Yes, we will move the previous patch's variable rename into this patch

Regards,
Terry

> If not, I'm fine with just moaning :)  Whichever patch split
> you go with across this and previous...
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.co>
>> ---
>>  drivers/cxl/core/port.c | 2 +-
>>  drivers/cxl/cxl.h       | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 99df86d72dbc..b993dea61436 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -712,7 +712,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>  {
>>  	if (dev_is_platform(port->uport_dev))
>>  		return 0;
>> -	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
>> +	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>>  				   component_reg_phys);
>>  }
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 68abf9944383..3a51b58a66d0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -572,7 +572,7 @@ struct cxl_dax_region {
>>   * @regions: cxl_region_ref instances, regions mapped by this port
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>> - * @comp_map: component register capability mappings
>> + * @reg_map: component and ras register mapping parameters
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -592,7 +592,7 @@ struct cxl_port {
>>  	struct xarray regions;
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>> -	struct cxl_register_map comp_map;
>> +	struct cxl_register_map reg_map;
>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
> 
