Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823B76B34C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjHALbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjHALbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:31:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03783EC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXkfevRRpgEbgKZIYAqEQTwhZ9+TGR1FXU7gb8CVCpElu/YhCcQb0uv8hDrVWRfp/oGhdQUCOM1ArsxGrqFKWg7V2f5838eueJbe+Xnb7y4usuTBQbF4FFDOi/o0Ul3MzSyn+WdYruyIRWhD36WOE587KRF04ZDagq3nfBsjIng6GeZU8362RU/ur5IJ+PmcBza3I3LvEPL1CMpP5jN7bCuoWqtEXjVga8euhWa99aGIW+gRKEG4YBQSqPiEAcy1BQLl4NYSo0NCGnkFPEbyrg6hxRQ/UrCYg8SYGnHAbEQ43Wwnga9xtluaaonsycXaFCqUGnfVtuepdi9QgG04VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWaOEJO55wYXkhqiefdV3UEZ3VmYBh+ongOLlD3mhAw=;
 b=nuos7kjDJEQv3bspMLt7Ax8QetXVgOfc2Ve06OvpyvH9msvlJpKmEN473AtQCmu7xACxHt4Oc7ugzF+kT0nxDPi66ChC8D8hahQgo4jjRQq0slIFNfkttV46jCNp7QejtUlVWOXOp79eolKzygQyAXAtlmLoSqaa9TQa46wAl25w3E4ztWZeS67QTEbnYOWsJ+pAPJFkdY5sB891ybryJGu5hxtwfiMqJeGSdy8azCGntBsy8aP3+y7EOpFdjZ63JM5YQKSyTlDDBZNcpKUAFdD8PNMux+bxphUgHKvS5aShK54ipXZaxQkQ2xBX/zEyVHzdLGsUaEGD7Ku0E2zYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWaOEJO55wYXkhqiefdV3UEZ3VmYBh+ongOLlD3mhAw=;
 b=w4uorFtNlGYykqWhn0te47WxtvsusU57DIMCH4i/a8kWI3E2vhywmqUwTcz4ASbA2h0oQ66OTScUp45ucK3IzQo6A1B6hRmU9wg71YH4iDtNdY6gp8aho3pt382jm1Sd/BzApMIz1OVcDi3UKPyKWcSz2eeDAbuJ8kh2m2ZYqCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 11:30:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 11:30:55 +0000
Message-ID: <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
Date:   Tue, 1 Aug 2023 06:30:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com> <20230801112403.GA3972@lst.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230801112403.GA3972@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 3575524f-cc01-407d-6d1b-08db9282c4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HjdzFu5yl1EpzuZ5i76L9VeLuMNLR5C2DDAM8dhEoAjlTh0258w0vUgSyodBVxdWW8qDyTtmn6guIrtHozy1274xMlJ2bi+vUe7eolNV7KeoEkKDkmIIS0hI8ecGZSvi8r5dxWQRtcJmZPRAZQdPVhbuVAt3IaeEuvEsNXzQ8dJSJ2m1yOAAlUKXX8Kqx7N2Rb5B6CiuOn0NxK2pxICXDtkxTHliE93w5hIb2R96vBoAB8Ph/uHc+3YqZ5dsD8er4MvN/qbyG2N8dtdzR7vD0ccwvpVSzuq9ObWc1W4wf5OPLGUTDyuWiC35y4zQ/DysGt6HgfWRH4C/8QcVL0hWsq0LVRgrtbMF2FA0DwBcmRGUY9FGxIZQOaReC0KwYqky5zsLHYr3sasQH/4CcDtuS7iht/j8/hSdLdWLB0WMtuh5lhDmYimZjdMxfNDxJ71YIRBAwzHysfLRTSi0d74a6SmLv6h7umlnCwVUys1X6x1ybF/iYJmR/XnoVt0X7N36wjbLIECL9ToJKlUVtjf9bBhYk8+YhuJ0LrWCAgG13vXcl2GDYAH8qTScbrfh5rcZWUhTlGVyIzcnnT2RvrT5FgWE4Q1J84XUF/UtjpHJfI5C8bPGBazRDWynf3bm0KtICnIlL5E/rtVntn3oZ4G5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(54906003)(6512007)(966005)(6506007)(36756003)(6486002)(8676002)(6666004)(8936002)(5660300002)(66946007)(66556008)(66476007)(53546011)(4326008)(6916009)(2906002)(2616005)(83380400001)(478600001)(41300700001)(31686004)(38100700002)(186003)(86362001)(316002)(44832011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpIb3JMNFV0L0pBZlZwSjF5dnRXcVQxQTdnZzZpQ3dyY0w5ZnZYRk5MSytB?=
 =?utf-8?B?M21IVE9vT1lWUWhQMzFSeDc4bE5GU3JQRUcweTdRWlY1OFpsK05xcWdaREd1?=
 =?utf-8?B?MUVxblVvT1J0dGl1Q0haYTJOQ0M2dDZhdU1lSWszNExhRjRxWC8wSTVqKyt1?=
 =?utf-8?B?NDNPZ2owZlRXOFd0OFRKMUdLQ2xxVXcvZmpXRWVGSWFtYmU4YTlRNEV4dkVj?=
 =?utf-8?B?bCs1a0h4enNpTXZIazRBNk9JQ21RVDJyQ2o5eGV5RTV5bDNPbUdxK3dRS3FV?=
 =?utf-8?B?SXNIb2s2TTBBRTE1QkVvaUh4c1BYYThYTGNEaWRLbG8xRjdSWkRMWW81QXEv?=
 =?utf-8?B?RHk4S3JIYkNHS3FzNWQ2dEpCZ2trSGltYVhsNFRwMVkweTZ5NitUTDNLTWZr?=
 =?utf-8?B?cjQvYnVQb1ZwdGh5UG1sS1o4RFQraHVSenVhd0p2Ynpxc3dBa3RKUlZEVzFr?=
 =?utf-8?B?V0tjbXR3bys2dVh5Ung5Y0NTb2UyOVRJU0VJclZFbGRlYTZTRWVlcUtuTTJU?=
 =?utf-8?B?MUw0dTRSaGlJSm50SEFDQzhnc3E3Tzk0RmZKOStkT3M0dldoS2EvNTBkODZU?=
 =?utf-8?B?bzl4NVNkdm1aU3oyYytJbDF5T2FuVEFWd3JwRTZNRGEreEx0dWl1WFpTMmtx?=
 =?utf-8?B?bzYvNFFzeWhJaVM4ZVd5UzlVVk1EN0FKN25NN3ZNNjNBMHlNVFdxZ3dWQlFN?=
 =?utf-8?B?M2gvTDU2VzBVaDdiclRrb09LajFNcGpseWdyWldQZURxK0pPblVxUU94U3hW?=
 =?utf-8?B?ZDVrMnhxMXliM0V2bHhvNlFaMWRhZ0VHNmFpQm0wMVFBMG14U2RQa0JYVm1j?=
 =?utf-8?B?QXB1NWZIQ3hmWWNTLy9ZQzljT0t2R2hYNFJpd1pxN1czMHBQd09qOXJZTlVL?=
 =?utf-8?B?a2E0dU05cjFaMXQydVoyZlZyZ2REaEZSVmtybzhDVGg1QWVCdStVRk1URDR0?=
 =?utf-8?B?Rk1mVExsc01UeTVLSVVIbDdMbGZMOHZqNmwyb3NWY28zdmpvR0lCQnRnTFU2?=
 =?utf-8?B?RlA3NmlHbkRwU1ZwaWdINWxubWc3NWdoOFVuUEhudVk5SytpM0drekJQUzJv?=
 =?utf-8?B?QXdYZjBvOWVZSkxrWWdJK0NxM0ZVTC9TeFNRMU8xMmU4YjBVOUFVVEVTSnVh?=
 =?utf-8?B?WGxJZVpsWGlmekpFMUdpY0dIellCV01oT1kxWU8yY21oSWdiNU4yeEo2RDQ0?=
 =?utf-8?B?NU1tbldobmNHMjlnTWhUSGlRTWhhUDVUOXM4RU9JeGw3UEJZcFJ4TElzSCs4?=
 =?utf-8?B?a3FFTGZWOWdVRUh6aDM0ZjRwLzlRU3FEWTdSMUhNZnhQTnh3Q1orMDR2VXFJ?=
 =?utf-8?B?cTVhYTNWY1l0NnVWZDBVNXBINVNDSXRKc3g0WkJoVXdyQXlaNFhBZE1ER2Ja?=
 =?utf-8?B?cG1aeTVVS1ZRNkZ1Q1JNN1R5ZzhXVCt2dnQ1TkI5YkhZMGVhek0wOGtzUGJW?=
 =?utf-8?B?dTdxZWhKb1F6TFVhT29mSDdQNHB0R2taMjY1SWVXbjZ5NzlzdDJ6YWFWMSsr?=
 =?utf-8?B?UGJ1eGZjSkVLUjArWXVQNC9YL3h3c2QwaDh0aTlvU2N4MmlIeHJ3ajNncm5W?=
 =?utf-8?B?Vm5keGdXYjgrY2Y2dnlXVVFXOU14S0ovR1hkMGhJMzhvdGVMK0E2WXpYempC?=
 =?utf-8?B?NGc0WTk0Wi8zV2E5T1NUTngxNzVsU1ozcW1YWFlOclNmR09tZVc2YzA5ZVRF?=
 =?utf-8?B?a0VWdWE4RDFCOUdQWHkwVnVaS1Z5NjBSbHJKdmoxOTdScDN6NWN1K2ZQZFFU?=
 =?utf-8?B?WmNUcTh3bC9qNnhGN1ZRZUxHdDgzcUVoWk5MSjNNRi9yNVNscWhnY1h0WWps?=
 =?utf-8?B?czMzbGE4RktHN0E4bm9LajVaRjJYcEFuUXpCcldLNGp2Y3h4VUphZ0RxUUJh?=
 =?utf-8?B?ZGhuVUVWNVlMbm1hM09ybStpcVdxQ3lrb2FYREljSjdiNEVzM1RDbC9XNFNh?=
 =?utf-8?B?VUw0REEzcnRnZ3BTbnNGNHJxME9leTRHbEV4bXl3aVZVMGdqNDA1SExGVjd6?=
 =?utf-8?B?YkV3TDVpb3hsTENqVUN5NmhkZDU1WWNhbU5sY1V6TWhFbGpYTUtXQjlHRGhr?=
 =?utf-8?B?TEtlTEV1eDQ0VHErbXAwd3hPT1YrcFowRDBPVHJQS256VEQ3amR6b2VocThh?=
 =?utf-8?B?RlVheGp1Z24vellPRnVWelN0MkwxYk5xZ05VcnhSUkFabzV1YjNPMUtoQ1lu?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3575524f-cc01-407d-6d1b-08db9282c4ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 11:30:54.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IpSItpXQI4C2SKh3fWh+hvY6bY1Y//KhrqSNUD9XFZI6Bk20R9N7KmkE/3qbJxW+8L4HVOOcYrXSXdjnAPlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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

On 8/1/23 06:24, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 03:14:54PM -0500, Limonciello, Mario wrote:
>>> No.  There are tons of NVMe devices that only support creating and
>>> deleting namespace out of band, especially in virtualized and cloud
>>> setups.
>>
>> Even if it's only the error handling path only that it's checked?
> 
> Do you mean nvme_validate_ns with the error code?  I wouldn't really call
> that an error case, that's the function called to check namespaces are
> still the same after we did a rescan (either manually or triggered by the
> AEN).
> 
>> If you don't want more changes or heuristics on the error handling path for
>> this case, I think the best solution is probably to pick up
>>
>> https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
>>
>> instead then and hopefully we don't end up with more disks like this.
> 
> That's probably the better idea.  I know at least one of the early
> quirked devices also IDs that changed for subsequent identify calls.

Do you want that re-sent?  Or can you just pick up from that lore link?
