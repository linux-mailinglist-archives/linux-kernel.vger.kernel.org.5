Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448F376BE7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjHAUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHAUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:35:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE91FFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZHbKtBXTpP7mbX5AheNMrR73dTjBcw8CliOXyLzplDE4I5S2lnWR9A0abW/3wZLCa7IXZHwbyCYHk/TQa/f68vXAG49xzJaGEHsvckrH1Yy026ednPnuc9W8+gdrDeWrkB5zqx5gu1Zez8zEtfWI5x2vlbP+s/2L1c1sbTieFocekPZrIVc8KuF1yHghVfLjjqQAtl3V1wIGtnBwNYO3KCcIgVZgzNA6ssupAm0dw71zidEs1IK3EsYwSgHv4l4/uAYIqv3Vn8jDdMrB8uC6YT/vxiUe+fqeqIkaVejic2KCbCzuIH/iqRetR7xMvPPbnnBZi801A6VXuRxjjt6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jFBCOEsKpICic9MF7qLKiIis3/uSOaKepBH9wY4K44=;
 b=WzgK2ZSh0OUPYqO7l5Q1s2JrANebb8oBFO/uJ810cZWPSVyt7EIME+kB4Nt9uk0GyHVYB6NojrGfsWkrPdhQrXh0FQqiHcAM+p6kROZiZ5THCZ3RoI3fk27lW8e2gkdALhx+GPV3ELL6Qs2D3C21xRLEjUKsmF9V80Y/wJkt71E7RO17OvdMvpM1AJr45c4ErkwtM7iSPxijR22P+we5Jxw4qlMgyc83f+9YwJeF8hEDrch7Qnxr/Jwq+ndAVx9WwhG8pvAdXFia6zPf5j6ZRbO2O9QXgdyIBEV8ByI6imLkwidjSUFSptW2LADsK3qerNRiQoOL/J6gP2LIkGlqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jFBCOEsKpICic9MF7qLKiIis3/uSOaKepBH9wY4K44=;
 b=yZ3O7rHFNzEOt7vELXyXCFnnjBPF1GRs/y+/Y+EpAXkkCQ/fY08LuVZCZq8feB2aXALosjnEV6mV8vrJoH+tDH30X6pyJCvaWvNKOYZsDbRrD8n515rh0bNJA0zAwRY0mW8DGDG5BZpII3YNIVOl+Gs9yMrnl7q06PypguDbBoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 20:35:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 20:35:00 +0000
Message-ID: <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Date:   Tue, 1 Aug 2023 15:34:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        August Wikerfors <git@augustwikerfors.se>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com> <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 213b3e7d-42f3-4226-2962-08db92cec6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa1WHvVjWYhjaxceIdIITTHoNtIc2mxxrAPAv06AxHt+ZeBBSqWnbYRQj/tXiAk7igyV22cDtOdu/dfTcsqdsk+JTXGMv6MzcS6894K7M74LFWoVnDUNuS1dACGeXYrobHDifvpuBR65zRR/XvuxH+SK4OBB27vWEvdaPyD9RTYHL+6l2CZLBgLNugYLJQE3N0jbGZHk8vtp8s2XcEC/VvTOKr/KMystbeyw2Aoz1WPiW2leQQf/IRD99wKNXeO9PYMv4l6mO5+zfP3oVRqWv+be4KbihMkW0np24fOhcmqooVEm8kisXlsAL7bOCdJ14TlVAtovvS6CvwKVTDmSUK3Bvkp4qzBRFOy6WS0G52ItbpmCL9N27RMCf329GR35KfBKQjIDpLro51Lpo9H4dNVdiggOqlSJbQ72UMsM5nFpXNRlTd8E+fBo9xrXphJHUr4kpGjjKX8HqPWqODtrw2FJZYiYvmGWQPSVyhZMMS9i3ZgEjhbVjW5NXLtpDLuN9xdRBu9JNLqgZCjiM4Q9c0OHcaK0JA4bH6eZ0LXXepVJg11PSxURE/4TIu9CkE4xXjCaJDbC9h414V05Te+pGRCKruZJN4XXKIIuslIv4HU9qp5fBfbJbvKPWwj3xMvl0s2Wbm3urOKROf2+zsnoWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(2616005)(186003)(36756003)(6512007)(316002)(86362001)(478600001)(54906003)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(6916009)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(5660300002)(8936002)(4744005)(2906002)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWtaTXVzcU9oNXRldmpmcVBsZHk1QTRTWEQweWk3UmhKUkhzQ2xSTVdtdk9Z?=
 =?utf-8?B?K2pkTkJiNHJGb2FDUmc4cU16RjVManhOZnpaejFMSjlWNTNobDJTcWhySitF?=
 =?utf-8?B?UzE0Y0IzMTRVSyszbUZURXRTMEpZVnBGNE9rRnFwekVrRzFhcWtVT0ZVT1Aw?=
 =?utf-8?B?NlJOWTNac1UzNGlVbkROV1kyV2Z1b2ZNaEhIemdDV2gxc0Vrd0t4bnJ1RGE4?=
 =?utf-8?B?bjlvVjZmUjlRczF0MkFhVXZDd2FER1Y3RDN1dStUSmd5WkcrSG1CQ0tCUGRU?=
 =?utf-8?B?R2YxOUFWN2ZNNmhFeS9qcGFPNXMrT2UrK00xRmxvc3NXZ0NvbjJLUFQreEI0?=
 =?utf-8?B?c3RPa3B3ZU96ZzZaWjAxaDdBMnBLQWRxUllOWUtKV3RPc0puN0xyZ0UzOFNJ?=
 =?utf-8?B?MVk1Sjg2SE04RTFhNWlXdzJmUmwyOTBSU2FRMDhTUTZUTlNmMlVIRjE1dVZi?=
 =?utf-8?B?eEVOakhUTW9KZklsQURqY3JlSTZJNUZKZFBOc2tqQXNVdXhJbnM1aDgxVGFm?=
 =?utf-8?B?U05QU2tIc3pVUVRYbWozY3pCZnpHUVNIZkxzZENqZ1NnWUIyQUt3OUI2a25m?=
 =?utf-8?B?WmUzcWt5Q1BkRjNPeXByTi9aeUYvTmg1SlFBaW1VRXhNS283MjlscGw0dXpz?=
 =?utf-8?B?blFCblFDL3J2dWo0a2w1T0ZmSStpNFJuRDJ2bFBRMGg4UHhYelFra0xqOG1N?=
 =?utf-8?B?MWRvM25xRXBpZjRCRHJiNWUvVE9rODhXSVZVd2ZscjRRa2xta3pnVnNjTHl1?=
 =?utf-8?B?bWRPbjBFM1pWQjRFazZucHA2b2xLZHRzUWNZYncwemVRT0kzcUEyTlZFVkFX?=
 =?utf-8?B?a3B4U3BaNlVSOUZlaFlPYzY2VlJGVDJxaEx2N0liMitxNDhKeTlyUkpscTFF?=
 =?utf-8?B?eFpGKzliM3hvVVliV2hscUdsc2svb3ZVQmxtbGFVQ3FGUkZvTWEyWFgyQWFq?=
 =?utf-8?B?OFI5dE1tTEJBR01ydU9DYVdTSnNkRHpWZmk3eXl1TXRUZ2JiamZIRzJZSFp6?=
 =?utf-8?B?RVdmcG1PakdUUjRIZU92cElTblFLZUMxc3pERXI5VXViQ1lsVFk2K3FvZEtE?=
 =?utf-8?B?cWU4SW1VSTBTeVZmQ1VTSkdFOHZXdnFoRXc1QWN0WjJtQWw1OGJmQ0VpVjNU?=
 =?utf-8?B?djA3UjE3TUcrRVdzRzl5c1FZWi9RbHozMTAyMGpMM0c4b0xqYnBYaEVMalhq?=
 =?utf-8?B?YUZBdEhBQm8xUmJLOW1PMHJ0bnoxNmE1UGFtdzFHU0lGczlxcGRIamR3RHAw?=
 =?utf-8?B?RWRWY2tXTnc0VE1QK0M0SzFxc3NBUEs1SnplWHZKSUphS3phR1liQi95bTMx?=
 =?utf-8?B?eG0ycmFNSmdrRHRiK3Y1bTFlUkJhbUhWN0w1Rm8rMXNFWWdoaWV3d1RNaWJ1?=
 =?utf-8?B?Y2pWSXlrS0p1TXVZcW05dU5qZVFKZnRhQjdOMVRhdlJqNUZwM3d0citCdTRG?=
 =?utf-8?B?bmp3cWV1MzFKL1lJZTY2REhSeFRYaVpzN3U4Unl6WFRUR1dwdjQwbEFWT29h?=
 =?utf-8?B?T1UraVd5K0hWM1hrUURWcUFSR2pQZ0lwa2tXcmxvZHhjaWF2V045THB2UnJD?=
 =?utf-8?B?OUc5VXljMzdXZHl1SytqZHl1UGMvRWdrbUZ2M1RDSmJ0dlNKTlNXY1M4S25v?=
 =?utf-8?B?aEJ4V1JNeHlwR25IdndmUUttOU9Yd094eUtVSkpleG5ETVhnbE1TZlFlQ3ln?=
 =?utf-8?B?SkJneVRTRjdPUXNGR1k4T0ltTVVhdFF0QW9JeEFXZVhQSXR1bk5HUTh6WHZx?=
 =?utf-8?B?eDM3YXZ3V2k0ekY0dzFPTjNDNFhuT3d4WDUzb1d3ZlRLR3duQ2FTVmFMckQy?=
 =?utf-8?B?ZFR6c2hwaDRjN1BuVkswRW1OQ1I4TmVCZk41UXZFSmZ1d2FaOXJoRXVuQVhK?=
 =?utf-8?B?bXVTSlV5QUwzL1pGbS80THZUOEdRTkNkVTBwVDhMOForU2Y4UGxoMWJqb01s?=
 =?utf-8?B?Um93NGJNZXBRbC9IRUpCbEM2M3B2OWp6L0c3NGJKVUFrc3dwNlBtZnZZdmxs?=
 =?utf-8?B?blZ3cWVhWmR1bTc0cUhoSTUvSjJ0anR5VnhKd3hCN2hzUVR2YkgwenBMM3lV?=
 =?utf-8?B?VGhGaklhc2tpL3NDLytXQ1BsdCtUdXAraWVHWjhBdWczcklUY1hiWG5zeGg1?=
 =?utf-8?Q?O5Maq5E6YipkOZbv0aXnKltk0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213b3e7d-42f3-4226-2962-08db92cec6f8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 20:35:00.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeQoksKG4qddqUGEYXoARFteZti3jEJDsEJz7K42ET0eYB8a3WO8Wi4q2l1jrTfjAtoZcKdnaCcQfolKYecbqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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

On 8/1/2023 15:29, Keith Busch wrote:
> On Tue, Aug 01, 2023 at 06:30:52AM -0500, Mario Limonciello wrote:
>>
>> Do you want that re-sent?  Or can you just pick up from that lore link?
> 
> I got it, and applied to nvme-6.5 now.

Thanks!

If you can still change it before sending out can you add a stable tag 
as well?
