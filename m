Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1E78C436
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjH2MZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjH2MYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:24:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E41CC2;
        Tue, 29 Aug 2023 05:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvajXL4wGal6KA06+pkCkv+v0okx+LR/dwPgcfxZ9dG1Ej+dlTQA3nszWnXHFUj4Ux7rLQgVrEBmHkO/2jst7ivO1t6C/vpb0HCCZRHVdiEp37oW7V5KQVZkwHJl+w+jHmPg48k41VcQqZICk79I38sR5tm0mKOyG2eL0LAF6W5a1jsXmQfOhhK7u7jXEqxf2R4MuOR/AEDAlmg82JkJduK9FtyslfUJpztHnZBJ+A7/Pm1GtygNUUzmOkYGxIfWp6MTIARILpQko61uhofbF1VLkJjlAhcSsA+tKgbPXFELeujRbKsabC+eo10UdAlh9tMbK18r4of5ylWs+tLIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+Na58lhSeB4dAJM0uDwOy+vtvbU+C/Of+oQlxhDMao=;
 b=bln5H7REn3j9omOF3Hkkhgah2N2WTDctVtIchXmSbfzKmMOFgBobOIK/hR8eZdARrpvkSmow/2HKtB0u0/Er7h8KwJts1jO/HAYNiINABF/H+Vz8hLzBHvDswk+ZvSBqHglJWWhWxediqITHL2DetqJpjPuZ/QAf7z2HyibmPWxIRzkyZTYggrzNnmZmChXYNQ5C80Qz4bLXYhiBiSzzSeyy5/78jmqWARxI7zCIUcxGaZ39m7CtJQuVuXNsrkvRcsYd1HmJYBzvkL68yHLPrz0HqAoMsagXgERlYKmwaWIlUUBVBsyOdorNGX/DMxzchldfhJNI0SB+ALL8UiP9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+Na58lhSeB4dAJM0uDwOy+vtvbU+C/Of+oQlxhDMao=;
 b=rN6K1ir6Ge1uo3uBXIhEKAePaTEQMt6hDbB0RhF/oaZiUazrlrTwEnVLeJoBqibWURHqR6nDc4c0TCkEaTnzp/QVt+clwL8N5xVuHJBI3ow67lMOkKHl93bv0Z2fkfIp6MQ61FM8T1Uh7Eoe9GV3fu06QxmMqeKYA+S96/eoi5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Tue, 29 Aug 2023 12:24:39 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::4b88:f989:984c:ea3b]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::4b88:f989:984c:ea3b%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 12:24:38 +0000
Message-ID: <929ddd1f-dc15-079c-331d-13cc5f25a1a2@amd.com>
Date:   Tue, 29 Aug 2023 17:54:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, acme@kernel.org,
        irogers@google.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230826032608.107261-1-yangjihong1@huawei.com>
 <bcfabb85-4dc1-e642-4a82-f3b8cc009b0b@amd.com>
 <93abb0e0-1691-a887-f7b2-7591f83a8618@huawei.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <93abb0e0-1691-a887-f7b2-7591f83a8618@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6584:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c45bdf6-0c6b-4fa2-b3ce-08dba88ae9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6X/iABZGwBDpiAeALblqzqi5FgSf82UoB6EcZgUmxohzjsk3YN4txUnwcnBBrqo1aHQABJpPCccCE82eIkldvV6VzDJseymo6xwe73ioufYCGxGPesCHIic+/wpF4r16XoRADHnFS48RZI5M5UfpDUp0NFImUnUbMRKFXLW99Qv4vtmSwka4JeBmch80EysIDXOIpO0kdfvc7cBiVaw+DWHaZ9CjP3ngeTLO/AMIFLBazacsGCjrp7hD5dpnrl4M046MQVoYN5KVg2OPOdTTW3DDotLsoCAv4BK78ahRN+dpgholZfNfa7ic0kKm5Ntzj2+AtAHk5OD7Ftf5RkDTB92QVMgmI/6BzuNccHQDSdOQDqGPmB0VarVvLZAsA1FsVhU77Vp+yfltOmCXzV69dxhu4Og6PttyL7ZI2V9tp/ToiamOu3lFDRHLuH5Kjf74L5yx3yT7XohatVa1jftuycex+u3l0/5OueNdmuwJ2wtpcbFLOhKJXxIgcGCRXPYmUBXQNZi/cry+GTrcisX+JFq0QAA/2NpXzn4p+TWt0Iqc4wXBtmTSArIbgteZDq4TEkmw2mSocREl5+E59Sguz0cpsxgR5Wn0HsCuGJ6RO0tPfaZW7//X3EdPibinwjpX6VbIzJOYO69sqiLk9XFvTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(41300700001)(4326008)(7416002)(2906002)(31696002)(4744005)(86362001)(2616005)(36756003)(26005)(5660300002)(44832011)(8676002)(8936002)(6666004)(6506007)(6486002)(66476007)(66556008)(66946007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpCNzBEajF4TnF0WWFwdTIwc1FkVHl1QnRWSlh3U0VFbzRvcFdTWk1RTVpI?=
 =?utf-8?B?bnhrakdTVlo1eWFUY3I5eUlCWW1vb0hNNWo0WW1RditwazNZSk9lWGVCYVVP?=
 =?utf-8?B?NmJ2eHpVeGdoUFlkTUdvTVdXZkRYZXBvZGRYOUhLcm9wUzc1cnV5L3pqNC8w?=
 =?utf-8?B?NUZKSkNJTzd1TGJBUXdnMGRPTnNsQ0Y3UTRpV1NINjhyVGFremV2VUdFc1lF?=
 =?utf-8?B?N3VHWCtCNEhTK29wRmQvTVE3VG9FbVRsZzhOQm9Zb0FVYlVJVDhDT1NDZHI3?=
 =?utf-8?B?SFo0OWJsSWJMYWgvZUxwNUtsYmxkbkdmTW45ZU91VmhtNVFrbHgzZVEzRnVa?=
 =?utf-8?B?a1FzdHhrcVNMV1g4T1pnckJEMEZ1T0hIa2ZFODRXUkN3c1VXNHRwQVZERnEr?=
 =?utf-8?B?YkgyT0thckMvNGR6WWpjVk1qVW9IUU1QZnNzb2tmcHV0eS9xbGhBQ0MyYktR?=
 =?utf-8?B?Wm9ucnljdldMQngrRmRBN2VGUklmR0RnNW9wSnZvaTVwb3l6bVdVL3NDcUZi?=
 =?utf-8?B?dk5sbStjR3FBOFVRcGJQWUNLUzRXbVVjQWJJZmdTUmVGVnFVNDZVc2s2OU1k?=
 =?utf-8?B?elBXc1BNQmhCazIxd3JlOGxJTTljQmZWTWdrV09iKzVCMGhuQWpZQTUyVVp6?=
 =?utf-8?B?N0ZRVHgxcGFIeHdxNHp0NFBMVWwyYkowRFBRT3plYSs0WmROcFdiTEhaallm?=
 =?utf-8?B?R0lPRzVWR1pUeGtFalBBanpMelZrQ0F4Uy9rTmoyVTVLZGZmQkJsM1ZEL0FO?=
 =?utf-8?B?d3JORSs5VUNTeDlrNGZ6Y2d1TnN4ZGJpNGxRQll1Tm5PWE9HUUVDZUVtcEVO?=
 =?utf-8?B?STJnQXdLUEpvNmMrSjVZMEVja0Y5TjFhcEhWdlVvWFZuNWJvSzRneS9uR1Jv?=
 =?utf-8?B?WmRsMXJPRE9ESUN0aWtqNU9BZmFjUlRheXV3bmEyaDNOVVh1bkYza0hJRlVs?=
 =?utf-8?B?MzVBWHFkYjdhS3NVM2NROFpqOVg2cHYwMFlTcTlNU2dzQW9GWXhqMjNyemlq?=
 =?utf-8?B?TFdGbzQ4bjIyN2Z6ODVsMDJFdTI1R0xFaTdFNGJrSGgyOS9HdkZtc3ZpY25i?=
 =?utf-8?B?S1N3eWFWN1dhdVZQTDJwdGVhVDZxRlU0bmdsQ2pidS83SGd1L1BvVE1EM2pJ?=
 =?utf-8?B?MFI2WHhNM0FlNVpqRXp1cGxXRzNncmx0c0QzMDlZOWttZVF0RzJRSmhValpL?=
 =?utf-8?B?T04xTUFrZmRWcm5oVi8wTGFiOVhYd0ZUMUp2V2VVYjREOVRkTDQwd3Fsdkgz?=
 =?utf-8?B?djZVMTRweHhFcE52S056bXlQZlJzV1ZIOVlETlkrTEVmT2hqWUh4RlFXRXU0?=
 =?utf-8?B?cHRnOEV0SGl1clA0ckJ3NzBQWENFRjhramRaN0Y4cmZRVFp2UGJreVBLSjFU?=
 =?utf-8?B?VUdiOXliYUJlZTBISkhIWEJqaStyaFZXaEYvV3hqYjF4T0p2VnJLQVZFU2VJ?=
 =?utf-8?B?ZTlic2hBNVdCellBemR6a0ZmNWthTEtlMDk4aFFUeHB6SVdLZ2xPWVhiMHRj?=
 =?utf-8?B?MFpSUmticFdOOUZsczRpMGlWNzMyWkkzN3doNzNuWEMwemJ5YjhHYlpaa2ZU?=
 =?utf-8?B?Sm9yTU1ObHZDbzNUeEFVRVM1WUNEdWdjZlBiSW1tRGNzQVFJbzBFU0ZlLzNk?=
 =?utf-8?B?SjMvSUdXOGV6ZjhWNnFMSFdMMlhVU1lCMG5GUE1ITDdnOXpDblpGR21HY05B?=
 =?utf-8?B?WFdtUTBSK0dxL25hZ2duU2Z5bDl6Y2d6OTNhMDRNYXZFclFmQkFvWHIyUlln?=
 =?utf-8?B?cCtPTHF6UlZ2b1RKajdlU1E4Z0lmZHlidzFydU9zYk1lVEpFbEpXcFdHWWgv?=
 =?utf-8?B?QnQ5SFRSVTR6aEVqTHZUZkFyMGlQcU9aZFJWU01ZUE1vaFRsNU5USEFDYTFq?=
 =?utf-8?B?V1UrQWcvWmlZeXBVMXViWTRIYVQ0S1VINVBVRlkwVnBFRDQzRGhvMkxwVWMv?=
 =?utf-8?B?amt5UVlsR0lVcFFKYVJjZWRKRjZ1V0RoekF3RVVtOTVTUlN5U1MzaHJBTDJE?=
 =?utf-8?B?OU1Ka0ZsZTQ0VUVIL0cwSHRpZ05rSjgrYkw2dGoybWRtd1B4ajNKS0RHa0s0?=
 =?utf-8?B?N0hXNEM2UlFEY3ZyZXdmODUySmNzaHYwZXpIc1VZVDZJUkY3RFNhN1FQakxG?=
 =?utf-8?Q?hcmlyZN8oKwVzqvfpt7AM3emb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45bdf6-0c6b-4fa2-b3ce-08dba88ae9a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 12:24:38.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eicrnToBXSNdxo+hMDbhIwQCZB91vFXf92XJhU/boyBpHd7Q263sXScQFEIsSgPl0ouGgICEnV6alLlxHuRftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Number of actual samples are same ~38K. However, the perf.data file is 5x
>> bigger because of additional sideband data.
> 
> Yes, if record system wide sideband data, the amount of sideband events will increase proportionally, which is expected.
> 
>>
>> I'm pretty sure we don't need most of those additional data. So, thinking
>> loud, should we post-process perf.data file and filter out unnecessary data?
>>
> 
> I wonder if we can add a new function in perf inject.

Ok. perf inject is one option. But shall we do it bydefault in perf-record?
It's needed only when profiling target is set of cpus, not for systemwide or
per-process mode.

> By reading perf.data and comparing tid of SAMPLE events and sideband events, we can filter out the sideband data of unmatched tasks.

Yup. But AFAIK, perf-record keeps writing to perf.data and never does post-
processing on it. So adding support for this will take a bit of effort. Not
sure if we should do it as part of this series.

Thanks,
Ravi
