Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3277660FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjG1BHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG1BHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:07:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6230DB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeQzXYrb2xZvzjIiSROn35kuxBGVqGroEuIKo60CICLqhQaB9RPeoS6L3IdSUrViCBc83z2QBeotmFTgpKUJ/+DyzzqfgfTniXeQIZc3DNBkskEsgyD+tD0RTHgd0Wy2d5hyh7mlTusz7IkIjzBkoCb47oPkK6r7X7xKlrIEKRxynE9xicLLNlyYQC0rf4ptOVtbb8g7WQxBkyiq1Uw9lwmnGG6d7cZ7n1idXPE00PNZ9cKgC697KLFqW74bq/Q86Y5ftBxL2tusPkqswDpzJekqnr3FzQwPr/uqPXUmZdgl6frEEHBkha6DbIrKxSKTx8xYYGzxVz+CAuLGPvLVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5axg63UXdxK/Yg2yZJ4vR+xXpyicjHnfrnkOmUADLWI=;
 b=LLSJgL7/CYxHISVvJyD0ReLYF3BsMy9Y/yeUMj6lITVQ7rTDAIaY9zx5z2xN161Q1qiHrHAy/F72pBKyxRE+DzoEs8h2OD1cVG3ipfIkvcQyFUKEn9Fa9uvog4sNT1D5ta+ICKBoRtT20x2DdRDGQ42msMNIFklZuRmQQlnWZX/AHebGZ/sKnjwpZ2UddTm5BTRG7aqjIGHZZfAxww2chUQEv3MIDJRzrY7epeBKKt1BP6YZT4EngEOYsZkUPS1Kkq22ZYoFMCLLLdhrgBRYMDlxtFtuSbAXlpVxF4HTSdiZKsl5tsFMUBA49lAL8Vmrhd1SeN5Jg08/BCAn3shTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5axg63UXdxK/Yg2yZJ4vR+xXpyicjHnfrnkOmUADLWI=;
 b=OrzhryEWlPqr9cr6z8L3unsv3rti7uMcxEpoGJptl/znKpMoV2/Sl+LKK1hru9DUPeFbNcVNC9g1LWzbxmd6mtwuPrm22d5qdv3xmrwarJ5cFrMp3wbkNLfH7R+OFQBN/l4H9OB5cDSW9myR2S+FEwqw8kvtR8Qc/dt5+wSIXrQmDTU/shi0B9aSQUVO0+yMlCgZi4kpaHV6GodqGCKKBQRP7oU+LCGYMhQ+QjDDc0o5ov4+NDAHhsHVYinCVMOizrIECBP4VMFj2+2O6m/U1zOpcJde0UnySwddTsRWNUvxTSGAurEG+fF+fJtWF6YjUuiO3Ux6NILJTzx32Cs/hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:07:46 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:07:46 +0000
References: <20220817081408.513338-1-ying.huang@intel.com>
 <20220817081408.513338-2-ying.huang@intel.com>
 <01797bb1-43c1-62a1-e483-61fa67061b9c@arm.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V3 1/8] migrate: fix syscall move_pages() return value
 for failure
Date:   Fri, 28 Jul 2023 10:57:43 +1000
In-reply-to: <01797bb1-43c1-62a1-e483-61fa67061b9c@arm.com>
Message-ID: <87pm4cx2qs.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0024.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f88c725-2573-4566-6867-08db8f070dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NscRQNFxMjuXZPzBbnIpA2f2nkG95ZxvI032EJl/kAmu4h2GiwOMzIwkJkJbAUjsjEXpx4IeDQlCgTMidr8rloWks3o6RVwtNA64qzoN815cqsbPxQzOvUixo878JtPmE6C3VVddN2Sf1aTDBh0jsMOu7i4oMAVt5/fun5iRN4Oky2GVGD/9YBnL6z4TnkMhZfP2YY2Wxl/r3UOU+og3R20aQORgf8gWFChoaEvAWqDAMCUsftBV4fttYQLOvN/39Ccdhtp7YhLOyDn4i8G0eUa2d+5eNYO5fPull2VP6bF8aytLynlu5CtJLH36hq+AVJQGTPiGbFjJo4bdkQTmC/qlBUQTzR+ZLd5HimBwSetKFeBqMlXfyjLp+0/fvzWTh+8aTUdZic9s9IaNrgbodRUKR4i3SMB4R8oWRE221+qa1+ctjpv2LSQ2anCqym2EVywdYQNR2Ty5daDDf4icnw/npPbetuPG/Se5YEUUmUa4PHYLLIkuEcjgnJdehTrWTfchf9E/O30383fr4lyoPNccU7Qw8YQ2S41zG2cu/4/Bhq/V93hRUSHtfX0Gi/lhct3snjHjO+1B358ucWoBr6cGU7yaIDvDBNbXwQrnEf9syXSCnOVvQ6dEVRV3+glN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(83380400001)(66899021)(86362001)(6506007)(54906003)(5660300002)(8936002)(53546011)(8676002)(966005)(6486002)(9686003)(6666004)(478600001)(6512007)(6916009)(4326008)(66476007)(66946007)(66556008)(316002)(186003)(2906002)(26005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fI0mInMU/OA6cmkozKA5EgT8b/hPdRMSsVXHZ9m6a2q4FSPnYhqB9VJCXlWn?=
 =?us-ascii?Q?JeWZDwlOgna4g4oDNOKZRAAipWT61fMbVqiPsdVKQFYjDdHwb4tgxFlGXclS?=
 =?us-ascii?Q?bHEbETn4Sh6idqJlwGSDOsBQSgZjoNS6inoqxVwFZ3BDxo92u2G1039RSYF1?=
 =?us-ascii?Q?OWM+87qIldk2p53QIV8PISHnBIyjZaSnx0aGzDRvDB8pEvPNYxJlW4vxZ7Ed?=
 =?us-ascii?Q?QkRM8uLyHUiKtd+fahGjdg5B0PtV0PSh42nYGjEDrNcSLjzH1GSNYEjSNvy7?=
 =?us-ascii?Q?SucrOnHi39Yt3EsYW8cshzARmChqRjbxTfjrSmv/FF7kgjdRqWZ455ziGMJc?=
 =?us-ascii?Q?A2DIkNlaB5DM627TeHbdaANo1C20k5j7FxEXhPaXt7A7XrR+ab2nPV1pAXcV?=
 =?us-ascii?Q?eXifmRqLb/9uFca0EtmjFN0Mc9C31DQ3YTVFgm6xAViuXnBRZKeSW4vNoftQ?=
 =?us-ascii?Q?FcOKbNSfLulfr16iycXRC+XiJE9ImdRJTSKXw68WBvpq2YxzEXpOkH5jf9vs?=
 =?us-ascii?Q?ekJXxu3n63vT1emL0neXLvcL/EUfg5VnV47RqSJMI80PFvCTifqEBVli4rJA?=
 =?us-ascii?Q?T97ThAS8+ZfpIP3ok93TwP9zu1BdBI2KV6h++iINXtySkM38EJ/vAga7eEjM?=
 =?us-ascii?Q?vxkgxEYp/rK636QevQAQhmfmbLTIKFEJ8JbmcFGF/p01+i9dCYLac/28nbOg?=
 =?us-ascii?Q?XtFeNmVLKC6fF08+891jcgPDAKLiB2dlOUTyZzDBYAnoQVU8jEXzNdumaKJe?=
 =?us-ascii?Q?u1bFd5SrtyY3OWLSMXae5APuLjJaoTGTIrVwZZrO7t+8As9+MkGlj9Fds99P?=
 =?us-ascii?Q?3rvnCo88UC8BnFtEhnVWzffDZ2zfeA6gMOPzudpLRI/W4LfZeK+FFfrwESS+?=
 =?us-ascii?Q?fVV6Oh2u4Y3bvaF+TYRK9qLCgxp+HYwIQ2nMMkuEjoLRKCkmDeKcHSlfaUjJ?=
 =?us-ascii?Q?wOXjnN6puzUPdrV2UQsSBWyg5KqePK4p0RUzXNUqkG5YSu6KkmxQcf02UgEZ?=
 =?us-ascii?Q?Xn0U3J5hngsZ/rM8+xUJXVHm5OFB3A3NGJF684vvSZ95RHSwusMVkvllYsEQ?=
 =?us-ascii?Q?o4FJVMvaCWEwNyKvA8PJdSRwfbE4EiMmsiJ46tp6Qu5jGiKHuSTth5b011Xc?=
 =?us-ascii?Q?qcrdof8wUkykRh/HkuL56ouTfT4yU/ioXPzpADeNRcSuH1UcLAQ1HqxMa2cz?=
 =?us-ascii?Q?pV1RaPIyIhvMXg+oZdGLDgEPPML2zG1km6oOj6s4VlQ24VBoFGCRulsFAWkh?=
 =?us-ascii?Q?CAooSTdYorY6IS0b4ap14M5fmRRU7lbhxQOkkdyRkFqJs+oGGEQzhwuiVQMU?=
 =?us-ascii?Q?19NGQvqBRtA7YHnSFJOV/VCCtIKmRZUT3HKMcNoWBDIcDW9sSD8fhGJK0P3u?=
 =?us-ascii?Q?ZL9Ewawv6NEtpdDbdGdM7rraiMUcJuYY7aJnW9keotm07TM8viXDEf6kZhfM?=
 =?us-ascii?Q?BoAys4uZ2fULIvP6mV5YYGGv+dFl+UTXxBXON2Ekr3DWjfZaxZO+aAhPvf72?=
 =?us-ascii?Q?WZZK6jlP3u06cxO4LVMO0hn2Ls+CrvTnHs+Lx+LVUQl+9lx6RfgF3pJphERY?=
 =?us-ascii?Q?UjVzaqzRelzw7DWwG9NB+yYMZBvgw5NUNDK5JJkw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f88c725-2573-4566-6867-08db8f070dbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:07:46.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0jJHsgY0MRO9TLQEgB0e3dLpZ5OAxQEoGfHrHBVNK9xg+qnnRyk4XxkRMUR29WgqRS51Z+qfLD4K7EcHRFOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Ryan.

If I'm understanding Huang's patch correctly then kernel versions
without it would have returned a return code indicating that all pages
were migrated (ie. none failed to migrate) even if they hadn't.

Given I would have wrote and tested the test against the old buggy
version it's probable that this test was always failing but the failure
was undetected.

The failure to migrate could be valid (although I'd expect at least some
success). One improvement to the test would be to check that status code
for the page as well and make sure it matches the return code. We would
likely have caught the bug Huang fixed earlier then.

Will take a look and see if I can improve the test.

 - Alistair

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 17/08/2022 09:14, Huang Ying wrote:
>> The return value of move_pages() syscall is incorrect when counting
>> the remaining pages to be migrated.
>
> Hi Huang, Alistair,
>
> I've noticed that this patch from Huang has caused the mm/migration selftest (authored by Alistair) to start failing (see bisection log below).
>
> Of the 3 tests, migration.private_anon and migration.private_anon_thp continue to pass, but migration.shared_anon fails:
>
>
>   #  RUN           migration.shared_anon ...
>   Didn't migrate 1 pages
>   # migration.c:167:shared_anon:Expected migrate(ptr, self->n1, self->n2) (-2) == 0 (0)
>   # shared_anon: Test terminated by assertion
>   #          FAIL  migration.shared_anon
>   not ok 2 migration.shared_anon
>
>
> The failure occurs due to the return code of move_pages() and this patch has changed the return code handling in the kernel, so it makes sense:
>
>
> int migrate(uint64_t *ptr, int n1, int n2)
> {
> 	int ret, tmp;
> 	int status = 0;
> 	struct timespec ts1, ts2;
>
> 	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
> 		return -1;
>
> 	while (1) {
> 		if (clock_gettime(CLOCK_MONOTONIC, &ts2))
> 			return -1;
>
> 		if (ts2.tv_sec - ts1.tv_sec >= RUNTIME)
> 			return 0;
>
> 		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
> 				MPOL_MF_MOVE_ALL);
> 		if (ret) {
> 			if (ret > 0)
> 				printf("Didn't migrate %d pages\n", ret); <<<< HERE
> 			else
> 				perror("Couldn't migrate pages");
> 			return -2;
> 		}
>
> 		tmp = n2;
> 		n2 = n1;
> 		n1 = tmp;
> 	}
>
> 	return 0;
> }
>
>
> I haven't looked any further and am not sure what the correct fix is. I wondered if either you might be able to offer a solution?
>
> Thanks,
> Ryan
>
>
> git bisect start
> # bad: [6eaae198076080886b9e7d57f4ae06fa782f90ef] Linux 6.5-rc3
> git bisect bad 6eaae198076080886b9e7d57f4ae06fa782f90ef
> # good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
> git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> # good: [d710d370c4911e83da5d2bc43d4a2c3b56bd27e7] Merge tag 's390-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect good d710d370c4911e83da5d2bc43d4a2c3b56bd27e7
> # bad: [8715c6d3100fc7c6edddf29af4a399a1c12d028c] Merge tag 'for-6.2/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
> git bisect bad 8715c6d3100fc7c6edddf29af4a399a1c12d028c
> # good: [12b68040a5e468068fd7f4af1150eab8f6e96235] Merge tag 'media/v5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect good 12b68040a5e468068fd7f4af1150eab8f6e96235
> # good: [7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf] Merge tag 'drm-next-2022-10-05' of git://anongit.freedesktop.org/drm/drm
> git bisect good 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
> # bad: [524d0c68826bc1adf9d1946e540eb4f7b16699a7] Merge tag 'ceph-for-6.1-rc1' of https://github.com/ceph/ceph-client
> git bisect bad 524d0c68826bc1adf9d1946e540eb4f7b16699a7
> # good: [29926f1cd3535f565f200430d5b6a794543fe130] fbdev: mb862xx: Fix check of return value from irq_of_parse_and_map()
> git bisect good 29926f1cd3535f565f200430d5b6a794543fe130
> # good: [d4013bc4d49f6da8178a340348369bb9920225c9] Merge tag 'bitmap-6.1-rc1' of https://github.com/norov/linux
> git bisect good d4013bc4d49f6da8178a340348369bb9920225c9
> # bad: [ac1e8c6c95bf805c699656046aef0a05205edfbd] Merge tag '6.1-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
> git bisect bad ac1e8c6c95bf805c699656046aef0a05205edfbd
> # bad: [f80be4571b19b9fd8dd1528cd2a2f123aff51f70] kmsan: add KMSAN runtime core
> git bisect bad f80be4571b19b9fd8dd1528cd2a2f123aff51f70
> # bad: [c4c84f06285e48f80e9843d0775ad92714ffc35a] fs/proc/task_mmu: stop using linked list and highest_vm_end
> git bisect bad c4c84f06285e48f80e9843d0775ad92714ffc35a
> # good: [8c004d1fc1497d9a6d92ea968bd58230af59a492] jbd2: replace ll_rw_block()
> git bisect good 8c004d1fc1497d9a6d92ea968bd58230af59a492
> # bad: [f76c83378851f8e70f032848c4e61203f39480e4] mm: multi-gen LRU: optimize multiple memcgs
> git bisect bad f76c83378851f8e70f032848c4e61203f39480e4
> # good: [36537a67d3561bfe2b3654161d6c9008fff84d43] mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in collect_procs_anon()
> git bisect good 36537a67d3561bfe2b3654161d6c9008fff84d43
> # bad: [5fc30916b5cda697a7eb8f1167c38c27100a793a] migrate_pages(): fix failure counting for THP subpages retrying
> git bisect bad 5fc30916b5cda697a7eb8f1167c38c27100a793a
> # good: [2e3468778dbe3ec389a10c21a703bb8e5be5cfbc] mm: remember young/dirty bit for page migrations
> git bisect good 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
> # good: [f347c9d2697fcbbb64e077f7113a3887a181b8c0] filemap: make the accounting of thrashing more consistent
> git bisect good f347c9d2697fcbbb64e077f7113a3887a181b8c0
> # bad: [9c62ff005fc774fb2ba14223b0d865a8aca48fb5] migrate_pages(): remove unnecessary list_safe_reset_next()
> git bisect bad 9c62ff005fc774fb2ba14223b0d865a8aca48fb5
> # bad: [a7504ed14f9b5e873599b2487eb95062dd0b65f8] migrate: fix syscall move_pages() return value for failure
> git bisect bad a7504ed14f9b5e873599b2487eb95062dd0b65f8
> # first bad commit: [a7504ed14f9b5e873599b2487eb95062dd0b65f8] migrate: fix syscall move_pages() return value for failure

