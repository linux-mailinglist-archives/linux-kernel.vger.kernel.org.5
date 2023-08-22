Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95A7844A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjHVOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbjHVOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:46:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D5187;
        Tue, 22 Aug 2023 07:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Vc6XzQroJWpo3JHJMaNVz+4kcG7QbLE/KmjD4WQMJjT84BDvQIaO6SiEpMe2uP6Xp0XpWWkrJQB2tPSlD/5PL7nky0+SPyL6relGkINEPOXzG2wXrrDkr0uykNjhPhHfvAvR5hoynTePzRzd88cc/VsZH/g4qJlffVB6zj2DFO49Z5DE78DWCG4pj+SGA+5O6juiLR3PfsS8KsMyXgOxs3AQVExmJGf2H5sqNBjGZ9VXSFr5S4nd4wGxrIQgG4fUAPTyNUiNCP13usVcqXKIXI4v8t+sFoZAeHlZh7VJCkW9ewY0riqNQX5w5MYskl+HmFr0eNQ6h2eqrEQuulZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH1wQOu/NBSlQPCGjNrj/ZAMk63DXQKxstcEouvKtiM=;
 b=H8oK7PO3hM70Z+aGisfrt0j+jn1UJg+vPARLMIMJ7Z5hXqSd6H4+u17gQCvpXN5i9CBEDjnwhyw1FByZ/x6RmEejZG/wdnsqaDprphV7pWeajRMgsMHqbqrNBzXA41cZsmVoKfu75azgbqV0K4+CcYWoXjbtwUQZFcfh9ZYWVSqXDZnMO5DCYYhLI2YYbQ+PsgfdtnHGgRDWS6Go7W/1ls7o741yKkllne+DkiamZGYyaNPjMLXVz74IKXC/Puf/Ef80slH7e6uVlkjJsqQgHpua/2bUgJT5Rftqexk4PR3wTZouMuFR73D8yJZ0VQbQfXY5XNhKp13BwWbTZV3gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH1wQOu/NBSlQPCGjNrj/ZAMk63DXQKxstcEouvKtiM=;
 b=TaQSAL7yeytVymPgo0wtCOTVXJAPRc2JXan7l3Ad1PWlFgGQuUOAMStVK3fpUSHQRvtuOXw6efWx4rvefcOlL8f5/sV34Ng0PsZl6ngHc0ohaeTUppXuZBgwn2sDBZGgLngKMmsweIDcxOF5RZKoPIAbTxg/QeNWv6L7yCXJamc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.35; Tue, 22 Aug
 2023 14:46:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:46:35 +0000
Message-ID: <da0e34dd-b20e-452e-af86-af793ef9baa4@amd.com>
Date:   Tue, 22 Aug 2023 09:46:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.4 36/54] platform/x86/amd/pmf: Notify OS power
 slider update
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Patil Rajesh Reddy <Patil.Reddy@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230813154934.1067569-1-sashal@kernel.org>
 <20230813154934.1067569-36-sashal@kernel.org> <ZOSRcmbzTxI9POQR@duo.ucw.cz>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZOSRcmbzTxI9POQR@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: af06821e-1cc1-4f69-ff2b-08dba31e9587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuFnx/nTiw6XVUCKqNUFFKJHrd0GjPhFOFKlYG4LXfK7EmhGIWrlgwJFiYHFilPyPfVmH64P8NdfWDlcX4uaIcip4Uhfk1FBcVkYyQwYWYDlngQ+vUkusbJVr2X66895zm3y0pNMCpivtBJ7vdYbCxc5KL/RzfTHoH/pFwJZ89TTxzM/XICkYPQMKsUFHcjHBWXM/HK65lNgKbIo64dTn5rGCdBlllqb9HqFAhaUb9ctQEvBTD+yaOm5JX9DaZk9aMRaHxEo6VVnMkbKPt7EqLQflt1aopL0FkQebl4uzjETQzaobK/wEr+DgcICMKXONCTKHIW9ewmdDtdXYCh1TxTOsH+d6GtzrElf9XvV4D5I+AuTqfBA18iMc+sC/fnhNMDjVLU6aai115Si8GPscjCJGHHx335oWNn0DvyAFgaiQx/EdQgHszSSyqOPGG5SX3PwRK5iIo+cogY7hq1HRQwAiGw71PVhTUloLGoUoNNa2SKbLlaDJnyA+71tNOndmMdQC26bSmzrR+G+wzRwCx2keyBh/vrSX6FBeCptdQf5AZPjo1F2EKmA1L9qPYxp88kzHMOnMLBBJi+3FynunHBjQFKBI/m9kLMK3eNC9NdrU+nT8nhdgtKcmRRarDzxXNjkll6K+n4t6v2MlJg2Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(26005)(6512007)(83380400001)(53546011)(2616005)(66556008)(54906003)(66476007)(4744005)(41300700001)(316002)(8676002)(5660300002)(44832011)(8936002)(4326008)(478600001)(6506007)(110136005)(66946007)(2906002)(38100700002)(86362001)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkg3VW5sbEVzWTFiayt3M25mdGQ0RFE4RHIvZDMzNkxBS0c2SlAvN2UvaDI3?=
 =?utf-8?B?dFN6MWpzRStYbEttZWg1RndzcEhIbWd3bkV6YTRTZGhCcmVNR1ZoVXpQVk1N?=
 =?utf-8?B?eTZvNTRMUG9jVlFWdUFoWjFLbHd4T1VlMVlHa2l2T200NHBkUkFFYklrYUpB?=
 =?utf-8?B?ZC9DWEw3Q1RMTHNEdXpXbm55M2x3enBkNjI3K0RQeHo1SythSkRWdXNndHl2?=
 =?utf-8?B?N1JEMC9uR0g0bVpNcXhHOGl2TVd0cVhJZG5TTjVOazk1anVrTkFrUjVJWFMw?=
 =?utf-8?B?RGh3S1lmeE5VbTNyRjE0TUdKNlFKVjlITUkxaUJFRUNSODdmUmxRWVkzd24w?=
 =?utf-8?B?akswWm1WK3RGMDFXMi9sWDMwcXZUZEtRaVk3c2FvR0pjMUhTSlpUYTAwWHBx?=
 =?utf-8?B?My8zSlZxNzB5eXFLSlNPZ0ZleXdlN0pONGpxYjNobE95L2FZMzU0eVZ0aFRH?=
 =?utf-8?B?VCsvcGgvVUNuZ3VTMWsxTVdxcUZnclNPZUx3SWtzaWVwbjN0d1dwV3dPUWll?=
 =?utf-8?B?L0R3WlRMb09ZWVFqUUFRajJwdWszQmVOdU9EaEFSUk5nTi9UZDRERUMwSDJq?=
 =?utf-8?B?K3F3b0VMUnpUNDdQUjBPNFliSTJBYTFhWWhUTFFKL1p6N2VKQmhBWVVWa1Fr?=
 =?utf-8?B?cEtCTXd0QXcyRXAzc1ZNK2ZQMjEwQ1drbGxLcXhKTDU2OUVsdDl2czBVWjZN?=
 =?utf-8?B?cmxZNS9XWEtydFVpK0hQVFBEWkwzRGcybVlKTHIvMk5oR1RnZGkzaDd4RU05?=
 =?utf-8?B?aDgyalhyeU5wWG5oZGNzcUl1bWxaVW00dnZUTzc0dTNJSVZBQ0o5bEN2eHk4?=
 =?utf-8?B?RmlTb1M0ZEwwY3dkaDFzaG5RdDRPaTNobm1teGpMYU1vdGN3ODZjcFU3Umkx?=
 =?utf-8?B?bm94bUZwVUM4UmlheXlhWlRibnd0TEtMM3pRZE9XSzJsSlBKbE9XYTlETlFm?=
 =?utf-8?B?SHEwTXRIaFphczdhOVBxVFZDTlV2aGNheDVCYjhIVzA5L3FnZFdDMzBYY3lU?=
 =?utf-8?B?eDR4eS9iRXJqUVBobnZkL2tZcG15dXZZbFl4Tjc0VGtBY2NLaTRLTndQOWVO?=
 =?utf-8?B?cnJPczlqV1NmYmtYeGFMU0FrbHUwWnVUeWpya20rTUJrT3QzcWQ2cHNCWUov?=
 =?utf-8?B?Z2ZOYWVpSCtmZlVKeU9Ebjk3L2dxY1daY0JkZ0ZlbDhXQXNnRjVoajNCb3Rq?=
 =?utf-8?B?OFdoZERzZm1hT2xYMGlsbFlxQkphcS9ORFpOMW9vVG9LYW93MU5BTG5XOU0z?=
 =?utf-8?B?b1BHVWFreHg4QXl6V3I3Umg0aS9JOUdVRWpuOEdjSVdYVjJHeGdLUGZ1bWgv?=
 =?utf-8?B?bkJhNHdUd21QZk9kYlM5aC9DVzQyeDRldDRjT1I0RUVSdzFnaXJFSjB6S0ta?=
 =?utf-8?B?blJFejJaS1ZDak9BRG16VHFXSnI4UkFXMTVLSDVhYzVDT1M0OWZPTk40Qmcz?=
 =?utf-8?B?RXZVMmZqVyt5bnZtNWdKRGNLSkZtM0xKbm5HZHYvSnF6MUFDbW0yT0k3Tzh2?=
 =?utf-8?B?bk9qb2dEK3NCS2w1MTBKekFYd1pSYmZtTHdNL2lid1l6SXB1VFpCbFFnckhN?=
 =?utf-8?B?c3gyZnc3aWNoNkNrUkZEZjF6OWpiMHBFQWN3UjFmOEJGV0xFNE1WYUJ4QW55?=
 =?utf-8?B?MWFYdlhUMDE2TzFjM1dxV0NkbEYyalVrNGxVRDN0a0J3YUJZdU1qd2FiVnlP?=
 =?utf-8?B?ZHc4cnVsR2VwSi9LeDRqRUxRamYybmpmNTRvRm5WLzNEVDNGZkpTL0JRVGlq?=
 =?utf-8?B?SXU0eis2Uk8xNFJ6eW5ISytXYUxqUTFPS0F5ZEI5VTFGRTRIbE1VbFdtYmV5?=
 =?utf-8?B?RDRqMWFxaWlOZmhPNFJQY3FsRkVwYStNZTRKQmJzbGRkUTNieHppaXlNNzFC?=
 =?utf-8?B?RzViTklJWnZNSFRwZis2by92bnh6aTZ0ZWlBMGRuMWJBL3pLQ3Y1YUdSbmNW?=
 =?utf-8?B?ZW0xaXRiSk5XZTJCdEIxajlsWEZPa2JqelZoalFST25KcG1mWGY4dUQ3cWdJ?=
 =?utf-8?B?OU1Ud1phU3EwRW5qNXlNSHptTCtVVjdDeHVTRGpEemlFOCs4RkkvY1U1S0xN?=
 =?utf-8?B?bHJqK05wRzdOdUlrVGFYQmZ4LzF0WDBJNWdqZnR6VkorSFMwVHJlWDJSSkdM?=
 =?utf-8?Q?2X/DuyyTCDqRIgC35bhnEL5EP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af06821e-1cc1-4f69-ff2b-08dba31e9587
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:46:35.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaODTSJqOUEgJZxVemXgE1enNhDbE5FIJHKVCgSRUbFP1oxqcTc2OtLLGH0TsDbrwS0QzcFL1Hwa528QGj0uQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2023 05:44, Pavel Machek wrote:
> Hi!
> 
>> From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>>
>> [ Upstream commit 33c9ab5b493a0e922b06c12fed4fdcb862212cda ]
>>
>> APMF fn8 can notify EC about the OS slider position change. Add this
>> capability to the PMF driver so that it can call the APMF fn8 based on
>> the changes in the Platform profile events.
> 
> New feature with a new API. Why is it in AUTOSEL?

FWIW I have no opposition to it going to 6.4.y.  It fixes issues on some 
systems that the EC controls the APU power targets and that power 
profiles weren't working.

> 
> Best regards,
> 							Pavel
> 							
>>   drivers/platform/x86/amd/pmf/acpi.c | 21 ++++++++
>>   drivers/platform/x86/amd/pmf/core.c |  9 +++-
>>   drivers/platform/x86/amd/pmf/pmf.h  | 16 +++++++
>>   drivers/platform/x86/amd/pmf/sps.c  | 74 +++++++++++++++++++++++++++--
>>   4 files changed, 114 insertions(+), 6 deletions(-)
>>
> 

