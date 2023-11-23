Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B107F5806
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjKWGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWGJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:09:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13E191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:09:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5pa58/RyycvNsZVc3d7Dj556XCwo771Yz4CAQeegTKcMR1ebsuff5rI7ycZr0n9PRajFqqR/NvPumkaREf2FCnBt18F9bfgDnallDK2gq6Qo4X7FFzTAXo2wXiY5rnYRB3+PIMssqPAD1F0yZnjBMTH+g8ub7kz6Wdgy+OgVlLWbew0apx5Ub5TfQl4/K/XffXO2fBzLiRcIg0Qenn2pVSv+uFib3yUZJuI9/FyKidxt2N8Vdrbvln09q82OfUHAMMLHpeuh74sJyYLwLfmQBDCpCK1fp8Si5n3bqHE/F4feJzWZdrYmYOLqnPF6hFPndK9VKDovru6SSN3A3sWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Rz8zORGEh1EhF4bduNNw/uet/f5EbIlLydzdHGy9uo=;
 b=n271tSW6vlwCegG3nQjkxBS299DDRVSxPPRvmTwweM0ZuSiLYD5j3S0WWeF3PsEobpxpwYGnWCijQRV5RcH1n0flSgZGrwBrK3G1klGzetu+E29rEmuyk+VP4pA7Fowa3J0TXXOPh5ggQlBsTt1SfIIKBN+1WlW3+wk0lrA+9LuuKwEq+xjvFzTSegHtaTj+7PCRCbsER58cDtClxguKhSgw/3UR0GTozaYK3Cxj+AqmpEZcqgITXJdcNckD2uxYuxFdNdB3L/gTztn1t3zVFeBhK73PLn3IVrkGj2UM38tyu6y6JQZeMC+ZsOthB8JG63xRcMMqNX8F/UgzGLNjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rz8zORGEh1EhF4bduNNw/uet/f5EbIlLydzdHGy9uo=;
 b=HY+zm92uznUQguSqbx2gjGP2VTfMaVIcq2iz1+DT+xv7rw7ZIAJvosBhT0NQ2tazP3NEHJ4CNlfRuX3J8clc6d6qMbpzwC7xsiL0bKKYTYk47A5crxiZdCY6ry9hZ8GQChfWsjeUfQ0SYQReVx7I8lfR6LSdouxWaDp/15Ze9hpSqanjmnjNBCZXaEDVJxx7nv6ZWwO98Znzj0m9Gnc8ALEymBrV5jaHuMy4+i3YlWfH2FYvPC6JjDurVOaGV1QBz6XxTnz6qZgvOMIvW+07t725sFPiLGhTU/pnXzIUgQe5fpEIceu14EMoCCZejaQiupgM9tEo9TvrPEPy9AhGPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 06:09:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 06:09:37 +0000
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-7-ryan.roberts@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 06/10] selftests/mm: Factor out thp settings
 management
Date:   Thu, 23 Nov 2023 17:07:28 +1100
In-reply-to: <20231122162950.3854897-7-ryan.roberts@arm.com>
Message-ID: <877cm9xap1.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0198.ausprd01.prod.outlook.com
 (2603:10c6:10:16::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c20874-183e-499c-3c24-08dbebeac521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBVAuualUC8aOkpg6fV5TKWUpc5MnvgBocV5k8U/spU1RvqxLVbFPEKRSp/o06Ojly01CBJMcQnE88PvW70GfP2K57cAdv4Xbqz2aFP7H3SDELutVI1Ed8wvHURt57/XXs86uo3Q88Zf1vmLh3YMUO1+UktbuE6jZ+cglCk0+dZRABx7e0hPTo/Z17a5uXcAiKTuB560YAFbWCIMl8/9uEgoFHfX1cPbH0O8NpdQM+0KS/JSei/uJAAQZ69y5bMSKwAzxQEZSrJ5yJK4V2DRfrHoW7iVZzOIK3D2MKjL7WYgC0HWmgTAMSKFFoAXExlX6XvmOPnF9A3SZKtMqkRelikn5FVAgtQII6odl1Jld4/wthYd9z/67fFukByWaVsHdZi3qz7HuK+w46jDz0E5tsFF79ZLnnd5grwAMracaCSAlmKdr3JHriHm/N1VQfL8Yrqs5e5dTztfYuNoRlmU2W70pOLZjoiikQS0UvgAsUTOg3PrtZPVeeiJsqFuDLKirLShkcW8x6qyfiPoigKFM+KF1NaDyneLtQZGADy9gtm63d93TRAaj8FlVQ7M3pg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(54906003)(66476007)(66556008)(66946007)(38100700002)(86362001)(9686003)(6512007)(83380400001)(2906002)(6666004)(6506007)(30864003)(7416002)(26005)(316002)(6916009)(478600001)(5660300002)(8936002)(8676002)(41300700001)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvHz5Fr9zdP96BpruezJyZ8PwkAbd5qDiskWmuFZrj/WtVtm/RPIhaMWdZy6?=
 =?us-ascii?Q?O+hOL78qnXlWklUpxgN/FVsWcWMqrWWcSda8gZt5cOP23CwLbuohiQrKO9I5?=
 =?us-ascii?Q?X8xCoPrKYULv9YQXmwpRjC7qfTZ5V+NTh7us4V0Di6JVVWN3ltnZ0LEL4fMM?=
 =?us-ascii?Q?RUObMxJRcbGSjrpcuUYHhXZjW0oyJNPI1gw7cvbzFOo1ZviK+PCsjtk1wom1?=
 =?us-ascii?Q?m04cxz8sGhO96YG6LPc40ursypcrIO4gQZI+z/MpWbq/oqpZV7J9ieOEgSAC?=
 =?us-ascii?Q?8a/6Bvvo7PToZpCGSBtcZkvJvgwDITJQ1OqCob6HZPNhsegbqso9Z6JXpMGT?=
 =?us-ascii?Q?ut5s7nJWBpG9cT6aa4LE8QeIRPFO2HHpoXdKWYRe7EtZCcCTwrcgDkojkUju?=
 =?us-ascii?Q?9n8QA1CAHjpazNKuWla0e8JfRPNZcQBEf7zEVhSkK3q+kcSqd7Uyr0aAFz3v?=
 =?us-ascii?Q?KoCGbz38747MdE8lTYjFtaEfJWnd/41nrVHgx9rUctnA4uTL2InSZ0EDX/ms?=
 =?us-ascii?Q?LqYVP52W/cdXNpCHcr+RiuT2LQvvmHTyr4zWU/YgNOX39z9exc1WvEtE09TZ?=
 =?us-ascii?Q?d52ilmWhhqYHvR0Xdiia6hvojkbTXsKZPJBdPQXk+n4Ainh7ieszlM0L1f9t?=
 =?us-ascii?Q?QDMmuimqUF6XdmaHTjcJrYYryuvO5YY9n84Msoa5ctdbQaqoyO817/BTlall?=
 =?us-ascii?Q?FY0a9wEO3nsZisH/NqOKlwroDtI/Ouw1aptAM2or+kmaDqy4UNC8RrVZFtkZ?=
 =?us-ascii?Q?j8JXwalHqoQgw2ZZnJ5kmeRF4Z91IDpLzElGyDThMR/ezoK9ckPV7zNbwTAw?=
 =?us-ascii?Q?PRX9ScH3M8DVJsmLmdJTveLnKhRAMM6DzADdOnQEMMiaBw86oJ++xucrlgJr?=
 =?us-ascii?Q?RY5ZUcolVwcE5YYRPltnZAwVZxUjehHEUUYNgISzktxyxzQXauJEe4MGjog4?=
 =?us-ascii?Q?gY3HmLuuph19dVdm2SgM6bIbQBoRn3at01UCiQ1sYdmm+Eg09eNds4TtdB/h?=
 =?us-ascii?Q?kAG5h+B7cEIjah7U9GLPJ73FnpAN6frdWIsnjDDcfcaAaR9PwzX1TKNoEBLe?=
 =?us-ascii?Q?Gs98664HuUtzpI7ioqcdpJedt6n8H+aL3SXlR6xwPVtDDmtsXpisHd8VxbuH?=
 =?us-ascii?Q?X5yb9fXX2Za/XiG3cpCp00gVDkCLRYPbn9kpENZh5hcXy7dgY7Du7IY1VZhW?=
 =?us-ascii?Q?A2UTjmtIcdpi4fBnymvvKIvzHkBP7Nqvim9Dy9Poor3KzVtNU7ewb9Amuliy?=
 =?us-ascii?Q?t+sYlfWH5YcLl0Gj/bmzz1hZFz2hD8g+Y0ZGjQO9p+cxXR6qjcyQbesb3pYs?=
 =?us-ascii?Q?V2YArl2HyJhjahV+fW8jp7m76VZLLhpT2Xl4cTFCoTyiDPxlssbKLxIdYFLu?=
 =?us-ascii?Q?VuXzzgFSdmK/PW3ojq1ZaJ4tZ33VLTSe/YTHKB01whW3YnqhSFp/y8dRN5Ik?=
 =?us-ascii?Q?4RtzQXwJSHrgSDFqyt2ecpG6wwocOHLgWw026nxXy71pmogLEYENcAVDInl+?=
 =?us-ascii?Q?E97+G+uHmdRc023drSlzN9QR258fJM6gAw0r3xKSa4QKJFSI6Aa5E3WoWxyZ?=
 =?us-ascii?Q?6jzHip1/D9KDJhQfyRPAnq7peZrWuG0vd4AsjIyK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c20874-183e-499c-3c24-08dbebeac521
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:09:36.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM/xSI3ejYkbzD7QTjibW65SzWyiLYX9GcldpDjv7T73/bBIiphBryaxbLSuE95ooo+Z9ou9kh80RdAuqnfKSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> The khugepaged test has a useful framework for save/restore/pop/push of
> all thp settings via the sysfs interface. This will be useful to
> explicitly control small-sized THP settings in other tests, so let's
> move it out of khugepaged and into its own thp_settings.[c|h] utility.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I've only glanced at the code as I assume it is a straight forward
cut-and-paste with no behavioural change. At least I didn't observe any
change running the khugepage test on my x86_64 development machine so
feel free to add:

Tested-by: Alistair Popple <apopple@nvidia.com>

> ---
>  tools/testing/selftests/mm/Makefile       |   4 +-
>  tools/testing/selftests/mm/khugepaged.c   | 346 ++--------------------
>  tools/testing/selftests/mm/thp_settings.c | 296 ++++++++++++++++++
>  tools/testing/selftests/mm/thp_settings.h |  71 +++++
>  4 files changed, 391 insertions(+), 326 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/thp_settings.c
>  create mode 100644 tools/testing/selftests/mm/thp_settings.h
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 78dfec8bc676..a3eb20c186e7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -117,8 +117,8 @@ TEST_FILES += va_high_addr_switch.sh
>
>  include ../lib.mk
>
> -$(TEST_GEN_PROGS): vm_util.c
> -$(TEST_GEN_FILES): vm_util.c
> +$(TEST_GEN_PROGS): vm_util.c thp_settings.c
> +$(TEST_GEN_FILES): vm_util.c thp_settings.c
>
>  $(OUTPUT)/uffd-stress: uffd-common.c
>  $(OUTPUT)/uffd-unit-tests: uffd-common.c
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index fc47a1c4944c..b15e7fd70176 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -22,13 +22,13 @@
>  #include "linux/magic.h"
>
>  #include "vm_util.h"
> +#include "thp_settings.h"
>
>  #define BASE_ADDR ((void *)(1UL << 30))
>  static unsigned long hpage_pmd_size;
>  static unsigned long page_size;
>  static int hpage_pmd_nr;
>
> -#define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
>  #define PID_SMAPS "/proc/self/smaps"
>  #define TEST_FILE "collapse_test_file"
>
> @@ -71,78 +71,7 @@ struct file_info {
>  };
>
>  static struct file_info finfo;
> -
> -enum thp_enabled {
> -	THP_ALWAYS,
> -	THP_MADVISE,
> -	THP_NEVER,
> -};
> -
> -static const char *thp_enabled_strings[] = {
> -	"always",
> -	"madvise",
> -	"never",
> -	NULL
> -};
> -
> -enum thp_defrag {
> -	THP_DEFRAG_ALWAYS,
> -	THP_DEFRAG_DEFER,
> -	THP_DEFRAG_DEFER_MADVISE,
> -	THP_DEFRAG_MADVISE,
> -	THP_DEFRAG_NEVER,
> -};
> -
> -static const char *thp_defrag_strings[] = {
> -	"always",
> -	"defer",
> -	"defer+madvise",
> -	"madvise",
> -	"never",
> -	NULL
> -};
> -
> -enum shmem_enabled {
> -	SHMEM_ALWAYS,
> -	SHMEM_WITHIN_SIZE,
> -	SHMEM_ADVISE,
> -	SHMEM_NEVER,
> -	SHMEM_DENY,
> -	SHMEM_FORCE,
> -};
> -
> -static const char *shmem_enabled_strings[] = {
> -	"always",
> -	"within_size",
> -	"advise",
> -	"never",
> -	"deny",
> -	"force",
> -	NULL
> -};
> -
> -struct khugepaged_settings {
> -	bool defrag;
> -	unsigned int alloc_sleep_millisecs;
> -	unsigned int scan_sleep_millisecs;
> -	unsigned int max_ptes_none;
> -	unsigned int max_ptes_swap;
> -	unsigned int max_ptes_shared;
> -	unsigned long pages_to_scan;
> -};
> -
> -struct settings {
> -	enum thp_enabled thp_enabled;
> -	enum thp_defrag thp_defrag;
> -	enum shmem_enabled shmem_enabled;
> -	bool use_zero_page;
> -	struct khugepaged_settings khugepaged;
> -	unsigned long read_ahead_kb;
> -};
> -
> -static struct settings saved_settings;
>  static bool skip_settings_restore;
> -
>  static int exit_status;
>
>  static void success(const char *msg)
> @@ -161,226 +90,13 @@ static void skip(const char *msg)
>  	printf(" \e[33m%s\e[0m\n", msg);
>  }
>
> -static int read_file(const char *path, char *buf, size_t buflen)
> -{
> -	int fd;
> -	ssize_t numread;
> -
> -	fd = open(path, O_RDONLY);
> -	if (fd == -1)
> -		return 0;
> -
> -	numread = read(fd, buf, buflen - 1);
> -	if (numread < 1) {
> -		close(fd);
> -		return 0;
> -	}
> -
> -	buf[numread] = '\0';
> -	close(fd);
> -
> -	return (unsigned int) numread;
> -}
> -
> -static int write_file(const char *path, const char *buf, size_t buflen)
> -{
> -	int fd;
> -	ssize_t numwritten;
> -
> -	fd = open(path, O_WRONLY);
> -	if (fd == -1) {
> -		printf("open(%s)\n", path);
> -		exit(EXIT_FAILURE);
> -		return 0;
> -	}
> -
> -	numwritten = write(fd, buf, buflen - 1);
> -	close(fd);
> -	if (numwritten < 1) {
> -		printf("write(%s)\n", buf);
> -		exit(EXIT_FAILURE);
> -		return 0;
> -	}
> -
> -	return (unsigned int) numwritten;
> -}
> -
> -static int read_string(const char *name, const char *strings[])
> -{
> -	char path[PATH_MAX];
> -	char buf[256];
> -	char *c;
> -	int ret;
> -
> -	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (!read_file(path, buf, sizeof(buf))) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	c = strchr(buf, '[');
> -	if (!c) {
> -		printf("%s: Parse failure\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	c++;
> -	memmove(buf, c, sizeof(buf) - (c - buf));
> -
> -	c = strchr(buf, ']');
> -	if (!c) {
> -		printf("%s: Parse failure\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -	*c = '\0';
> -
> -	ret = 0;
> -	while (strings[ret]) {
> -		if (!strcmp(strings[ret], buf))
> -			return ret;
> -		ret++;
> -	}
> -
> -	printf("Failed to parse %s\n", name);
> -	exit(EXIT_FAILURE);
> -}
> -
> -static void write_string(const char *name, const char *val)
> -{
> -	char path[PATH_MAX];
> -	int ret;
> -
> -	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (!write_file(path, val, strlen(val) + 1)) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> -}
> -
> -static const unsigned long _read_num(const char *path)
> -{
> -	char buf[21];
> -
> -	if (read_file(path, buf, sizeof(buf)) < 0) {
> -		perror("read_file(read_num)");
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	return strtoul(buf, NULL, 10);
> -}
> -
> -static const unsigned long read_num(const char *name)
> -{
> -	char path[PATH_MAX];
> -	int ret;
> -
> -	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -	return _read_num(path);
> -}
> -
> -static void _write_num(const char *path, unsigned long num)
> -{
> -	char buf[21];
> -
> -	sprintf(buf, "%ld", num);
> -	if (!write_file(path, buf, strlen(buf) + 1)) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> -}
> -
> -static void write_num(const char *name, unsigned long num)
> -{
> -	char path[PATH_MAX];
> -	int ret;
> -
> -	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> -	_write_num(path, num);
> -}
> -
> -static void write_settings(struct settings *settings)
> -{
> -	struct khugepaged_settings *khugepaged = &settings->khugepaged;
> -
> -	write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
> -	write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
> -	write_string("shmem_enabled",
> -			shmem_enabled_strings[settings->shmem_enabled]);
> -	write_num("use_zero_page", settings->use_zero_page);
> -
> -	write_num("khugepaged/defrag", khugepaged->defrag);
> -	write_num("khugepaged/alloc_sleep_millisecs",
> -			khugepaged->alloc_sleep_millisecs);
> -	write_num("khugepaged/scan_sleep_millisecs",
> -			khugepaged->scan_sleep_millisecs);
> -	write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
> -	write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
> -	write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
> -	write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
> -
> -	if (file_ops && finfo.type == VMA_FILE)
> -		_write_num(finfo.dev_queue_read_ahead_path,
> -			   settings->read_ahead_kb);
> -}
> -
> -#define MAX_SETTINGS_DEPTH 4
> -static struct settings settings_stack[MAX_SETTINGS_DEPTH];
> -static int settings_index;
> -
> -static struct settings *current_settings(void)
> -{
> -	if (!settings_index) {
> -		printf("Fail: No settings set");
> -		exit(EXIT_FAILURE);
> -	}
> -	return settings_stack + settings_index - 1;
> -}
> -
> -static void push_settings(struct settings *settings)
> -{
> -	if (settings_index >= MAX_SETTINGS_DEPTH) {
> -		printf("Fail: Settings stack exceeded");
> -		exit(EXIT_FAILURE);
> -	}
> -	settings_stack[settings_index++] = *settings;
> -	write_settings(current_settings());
> -}
> -
> -static void pop_settings(void)
> -{
> -	if (settings_index <= 0) {
> -		printf("Fail: Settings stack empty");
> -		exit(EXIT_FAILURE);
> -	}
> -	--settings_index;
> -	write_settings(current_settings());
> -}
> -
>  static void restore_settings_atexit(void)
>  {
>  	if (skip_settings_restore)
>  		return;
>
>  	printf("Restore THP and khugepaged settings...");
> -	write_settings(&saved_settings);
> +	thp_restore_settings();
>  	success("OK");
>
>  	skip_settings_restore = true;
> @@ -395,27 +111,9 @@ static void restore_settings(int sig)
>  static void save_settings(void)
>  {
>  	printf("Save THP and khugepaged settings...");
> -	saved_settings = (struct settings) {
> -		.thp_enabled = read_string("enabled", thp_enabled_strings),
> -		.thp_defrag = read_string("defrag", thp_defrag_strings),
> -		.shmem_enabled =
> -			read_string("shmem_enabled", shmem_enabled_strings),
> -		.use_zero_page = read_num("use_zero_page"),
> -	};
> -	saved_settings.khugepaged = (struct khugepaged_settings) {
> -		.defrag = read_num("khugepaged/defrag"),
> -		.alloc_sleep_millisecs =
> -			read_num("khugepaged/alloc_sleep_millisecs"),
> -		.scan_sleep_millisecs =
> -			read_num("khugepaged/scan_sleep_millisecs"),
> -		.max_ptes_none = read_num("khugepaged/max_ptes_none"),
> -		.max_ptes_swap = read_num("khugepaged/max_ptes_swap"),
> -		.max_ptes_shared = read_num("khugepaged/max_ptes_shared"),
> -		.pages_to_scan = read_num("khugepaged/pages_to_scan"),
> -	};
>  	if (file_ops && finfo.type == VMA_FILE)
> -		saved_settings.read_ahead_kb =
> -				_read_num(finfo.dev_queue_read_ahead_path);
> +		thp_set_read_ahead_path(finfo.dev_queue_read_ahead_path);
> +	thp_save_settings();
>
>  	success("OK");
>
> @@ -798,7 +496,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
>  			       struct mem_ops *ops, bool expect)
>  {
>  	int ret;
> -	struct settings settings = *current_settings();
> +	struct thp_settings settings = *thp_current_settings();
>
>  	printf("%s...", msg);
>
> @@ -808,7 +506,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
>  	 */
>  	settings.thp_enabled = THP_NEVER;
>  	settings.shmem_enabled = SHMEM_NEVER;
> -	push_settings(&settings);
> +	thp_push_settings(&settings);
>
>  	/* Clear VM_NOHUGEPAGE */
>  	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
> @@ -820,7 +518,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
>  	else
>  		success("OK");
>
> -	pop_settings();
> +	thp_pop_settings();
>  }
>
>  static void madvise_collapse(const char *msg, char *p, int nr_hpages,
> @@ -850,13 +548,13 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
>  	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
>
>  	/* Wait until the second full_scan completed */
> -	full_scans = read_num("khugepaged/full_scans") + 2;
> +	full_scans = thp_read_num("khugepaged/full_scans") + 2;
>
>  	printf("%s...", msg);
>  	while (timeout--) {
>  		if (ops->check_huge(p, nr_hpages))
>  			break;
> -		if (read_num("khugepaged/full_scans") >= full_scans)
> +		if (thp_read_num("khugepaged/full_scans") >= full_scans)
>  			break;
>  		printf(".");
>  		usleep(TICK);
> @@ -911,11 +609,11 @@ static bool is_tmpfs(struct mem_ops *ops)
>
>  static void alloc_at_fault(void)
>  {
> -	struct settings settings = *current_settings();
> +	struct thp_settings settings = *thp_current_settings();
>  	char *p;
>
>  	settings.thp_enabled = THP_ALWAYS;
> -	push_settings(&settings);
> +	thp_push_settings(&settings);
>
>  	p = alloc_mapping(1);
>  	*p = 1;
> @@ -925,7 +623,7 @@ static void alloc_at_fault(void)
>  	else
>  		fail("Fail");
>
> -	pop_settings();
> +	thp_pop_settings();
>
>  	madvise(p, page_size, MADV_DONTNEED);
>  	printf("Split huge PMD on MADV_DONTNEED...");
> @@ -973,11 +671,11 @@ static void collapse_single_pte_entry(struct collapse_context *c, struct mem_ops
>  static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *ops)
>  {
>  	int max_ptes_none = hpage_pmd_nr / 2;
> -	struct settings settings = *current_settings();
> +	struct thp_settings settings = *thp_current_settings();
>  	void *p;
>
>  	settings.khugepaged.max_ptes_none = max_ptes_none;
> -	push_settings(&settings);
> +	thp_push_settings(&settings);
>
>  	p = ops->setup_area(1);
>
> @@ -1002,7 +700,7 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
>  	}
>  skip:
>  	ops->cleanup_area(p, hpage_pmd_size);
> -	pop_settings();
> +	thp_pop_settings();
>  }
>
>  static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_ops *ops)
> @@ -1033,7 +731,7 @@ static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_op
>
>  static void collapse_max_ptes_swap(struct collapse_context *c, struct mem_ops *ops)
>  {
> -	int max_ptes_swap = read_num("khugepaged/max_ptes_swap");
> +	int max_ptes_swap = thp_read_num("khugepaged/max_ptes_swap");
>  	void *p;
>
>  	p = ops->setup_area(1);
> @@ -1250,11 +948,11 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
>  			fail("Fail");
>  		ops->fault(p, 0, page_size);
>
> -		write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
> +		thp_write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
>  		c->collapse("Collapse PTE table full of compound pages in child",
>  			    p, 1, ops, true);
> -		write_num("khugepaged/max_ptes_shared",
> -			  current_settings()->khugepaged.max_ptes_shared);
> +		thp_write_num("khugepaged/max_ptes_shared",
> +			  thp_current_settings()->khugepaged.max_ptes_shared);
>
>  		validate_memory(p, 0, hpage_pmd_size);
>  		ops->cleanup_area(p, hpage_pmd_size);
> @@ -1275,7 +973,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
>
>  static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops *ops)
>  {
> -	int max_ptes_shared = read_num("khugepaged/max_ptes_shared");
> +	int max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared");
>  	int wstatus;
>  	void *p;
>
> @@ -1443,7 +1141,7 @@ static void parse_test_type(int argc, const char **argv)
>
>  int main(int argc, const char **argv)
>  {
> -	struct settings default_settings = {
> +	struct thp_settings default_settings = {
>  		.thp_enabled = THP_MADVISE,
>  		.thp_defrag = THP_DEFRAG_ALWAYS,
>  		.shmem_enabled = SHMEM_ADVISE,
> @@ -1484,7 +1182,7 @@ int main(int argc, const char **argv)
>  	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
>
>  	save_settings();
> -	push_settings(&default_settings);
> +	thp_push_settings(&default_settings);
>
>  	alloc_at_fault();
>
> diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
> new file mode 100644
> index 000000000000..5e8ec792cac7
> --- /dev/null
> +++ b/tools/testing/selftests/mm/thp_settings.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include "thp_settings.h"
> +
> +#define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
> +#define MAX_SETTINGS_DEPTH 4
> +static struct thp_settings settings_stack[MAX_SETTINGS_DEPTH];
> +static int settings_index;
> +static struct thp_settings saved_settings;
> +static char dev_queue_read_ahead_path[PATH_MAX];
> +
> +static const char * const thp_enabled_strings[] = {
> +	"always",
> +	"madvise",
> +	"never",
> +	NULL
> +};
> +
> +static const char * const thp_defrag_strings[] = {
> +	"always",
> +	"defer",
> +	"defer+madvise",
> +	"madvise",
> +	"never",
> +	NULL
> +};
> +
> +static const char * const shmem_enabled_strings[] = {
> +	"always",
> +	"within_size",
> +	"advise",
> +	"never",
> +	"deny",
> +	"force",
> +	NULL
> +};
> +
> +int read_file(const char *path, char *buf, size_t buflen)
> +{
> +	int fd;
> +	ssize_t numread;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd == -1)
> +		return 0;
> +
> +	numread = read(fd, buf, buflen - 1);
> +	if (numread < 1) {
> +		close(fd);
> +		return 0;
> +	}
> +
> +	buf[numread] = '\0';
> +	close(fd);
> +
> +	return (unsigned int) numread;
> +}
> +
> +int write_file(const char *path, const char *buf, size_t buflen)
> +{
> +	int fd;
> +	ssize_t numwritten;
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd == -1) {
> +		printf("open(%s)\n", path);
> +		exit(EXIT_FAILURE);
> +		return 0;
> +	}
> +
> +	numwritten = write(fd, buf, buflen - 1);
> +	close(fd);
> +	if (numwritten < 1) {
> +		printf("write(%s)\n", buf);
> +		exit(EXIT_FAILURE);
> +		return 0;
> +	}
> +
> +	return (unsigned int) numwritten;
> +}
> +
> +const unsigned long read_num(const char *path)
> +{
> +	char buf[21];
> +
> +	if (read_file(path, buf, sizeof(buf)) < 0) {
> +		perror("read_file()");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return strtoul(buf, NULL, 10);
> +}
> +
> +void write_num(const char *path, unsigned long num)
> +{
> +	char buf[21];
> +
> +	sprintf(buf, "%ld", num);
> +	if (!write_file(path, buf, strlen(buf) + 1)) {
> +		perror(path);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +int thp_read_string(const char *name, const char * const strings[])
> +{
> +	char path[PATH_MAX];
> +	char buf[256];
> +	char *c;
> +	int ret;
> +
> +	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> +	if (ret >= PATH_MAX) {
> +		printf("%s: Pathname is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (!read_file(path, buf, sizeof(buf))) {
> +		perror(path);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	c = strchr(buf, '[');
> +	if (!c) {
> +		printf("%s: Parse failure\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	c++;
> +	memmove(buf, c, sizeof(buf) - (c - buf));
> +
> +	c = strchr(buf, ']');
> +	if (!c) {
> +		printf("%s: Parse failure\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +	*c = '\0';
> +
> +	ret = 0;
> +	while (strings[ret]) {
> +		if (!strcmp(strings[ret], buf))
> +			return ret;
> +		ret++;
> +	}
> +
> +	printf("Failed to parse %s\n", name);
> +	exit(EXIT_FAILURE);
> +}
> +
> +void thp_write_string(const char *name, const char *val)
> +{
> +	char path[PATH_MAX];
> +	int ret;
> +
> +	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> +	if (ret >= PATH_MAX) {
> +		printf("%s: Pathname is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (!write_file(path, val, strlen(val) + 1)) {
> +		perror(path);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +const unsigned long thp_read_num(const char *name)
> +{
> +	char path[PATH_MAX];
> +	int ret;
> +
> +	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> +	if (ret >= PATH_MAX) {
> +		printf("%s: Pathname is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +	return read_num(path);
> +}
> +
> +void thp_write_num(const char *name, unsigned long num)
> +{
> +	char path[PATH_MAX];
> +	int ret;
> +
> +	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> +	if (ret >= PATH_MAX) {
> +		printf("%s: Pathname is too long\n", __func__);
> +		exit(EXIT_FAILURE);
> +	}
> +	write_num(path, num);
> +}
> +
> +void thp_read_settings(struct thp_settings *settings)
> +{
> +	*settings = (struct thp_settings) {
> +		.thp_enabled = thp_read_string("enabled", thp_enabled_strings),
> +		.thp_defrag = thp_read_string("defrag", thp_defrag_strings),
> +		.shmem_enabled =
> +			thp_read_string("shmem_enabled", shmem_enabled_strings),
> +		.use_zero_page = thp_read_num("use_zero_page"),
> +	};
> +	settings->khugepaged = (struct khugepaged_settings) {
> +		.defrag = thp_read_num("khugepaged/defrag"),
> +		.alloc_sleep_millisecs =
> +			thp_read_num("khugepaged/alloc_sleep_millisecs"),
> +		.scan_sleep_millisecs =
> +			thp_read_num("khugepaged/scan_sleep_millisecs"),
> +		.max_ptes_none = thp_read_num("khugepaged/max_ptes_none"),
> +		.max_ptes_swap = thp_read_num("khugepaged/max_ptes_swap"),
> +		.max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared"),
> +		.pages_to_scan = thp_read_num("khugepaged/pages_to_scan"),
> +	};
> +	if (dev_queue_read_ahead_path[0])
> +		settings->read_ahead_kb = read_num(dev_queue_read_ahead_path);
> +}
> +
> +void thp_write_settings(struct thp_settings *settings)
> +{
> +	struct khugepaged_settings *khugepaged = &settings->khugepaged;
> +
> +	thp_write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
> +	thp_write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
> +	thp_write_string("shmem_enabled",
> +			shmem_enabled_strings[settings->shmem_enabled]);
> +	thp_write_num("use_zero_page", settings->use_zero_page);
> +
> +	thp_write_num("khugepaged/defrag", khugepaged->defrag);
> +	thp_write_num("khugepaged/alloc_sleep_millisecs",
> +			khugepaged->alloc_sleep_millisecs);
> +	thp_write_num("khugepaged/scan_sleep_millisecs",
> +			khugepaged->scan_sleep_millisecs);
> +	thp_write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
> +	thp_write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
> +	thp_write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
> +	thp_write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
> +
> +	if (dev_queue_read_ahead_path[0])
> +		write_num(dev_queue_read_ahead_path, settings->read_ahead_kb);
> +}
> +
> +struct thp_settings *thp_current_settings(void)
> +{
> +	if (!settings_index) {
> +		printf("Fail: No settings set");
> +		exit(EXIT_FAILURE);
> +	}
> +	return settings_stack + settings_index - 1;
> +}
> +
> +void thp_push_settings(struct thp_settings *settings)
> +{
> +	if (settings_index >= MAX_SETTINGS_DEPTH) {
> +		printf("Fail: Settings stack exceeded");
> +		exit(EXIT_FAILURE);
> +	}
> +	settings_stack[settings_index++] = *settings;
> +	thp_write_settings(thp_current_settings());
> +}
> +
> +void thp_pop_settings(void)
> +{
> +	if (settings_index <= 0) {
> +		printf("Fail: Settings stack empty");
> +		exit(EXIT_FAILURE);
> +	}
> +	--settings_index;
> +	thp_write_settings(thp_current_settings());
> +}
> +
> +void thp_restore_settings(void)
> +{
> +	thp_write_settings(&saved_settings);
> +}
> +
> +void thp_save_settings(void)
> +{
> +	thp_read_settings(&saved_settings);
> +}
> +
> +void thp_set_read_ahead_path(char *path)
> +{
> +	if (!path) {
> +		dev_queue_read_ahead_path[0] = '\0';
> +		return;
> +	}
> +
> +	strncpy(dev_queue_read_ahead_path, path,
> +		sizeof(dev_queue_read_ahead_path));
> +	dev_queue_read_ahead_path[sizeof(dev_queue_read_ahead_path) - 1] = '\0';
> +}
> diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
> new file mode 100644
> index 000000000000..ff3d98c30617
> --- /dev/null
> +++ b/tools/testing/selftests/mm/thp_settings.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __THP_SETTINGS_H__
> +#define __THP_SETTINGS_H__
> +
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +
> +enum thp_enabled {
> +	THP_ALWAYS,
> +	THP_MADVISE,
> +	THP_NEVER,
> +};
> +
> +enum thp_defrag {
> +	THP_DEFRAG_ALWAYS,
> +	THP_DEFRAG_DEFER,
> +	THP_DEFRAG_DEFER_MADVISE,
> +	THP_DEFRAG_MADVISE,
> +	THP_DEFRAG_NEVER,
> +};
> +
> +enum shmem_enabled {
> +	SHMEM_ALWAYS,
> +	SHMEM_WITHIN_SIZE,
> +	SHMEM_ADVISE,
> +	SHMEM_NEVER,
> +	SHMEM_DENY,
> +	SHMEM_FORCE,
> +};
> +
> +struct khugepaged_settings {
> +	bool defrag;
> +	unsigned int alloc_sleep_millisecs;
> +	unsigned int scan_sleep_millisecs;
> +	unsigned int max_ptes_none;
> +	unsigned int max_ptes_swap;
> +	unsigned int max_ptes_shared;
> +	unsigned long pages_to_scan;
> +};
> +
> +struct thp_settings {
> +	enum thp_enabled thp_enabled;
> +	enum thp_defrag thp_defrag;
> +	enum shmem_enabled shmem_enabled;
> +	bool use_zero_page;
> +	struct khugepaged_settings khugepaged;
> +	unsigned long read_ahead_kb;
> +};
> +
> +int read_file(const char *path, char *buf, size_t buflen);
> +int write_file(const char *path, const char *buf, size_t buflen);
> +const unsigned long read_num(const char *path);
> +void write_num(const char *path, unsigned long num);
> +
> +int thp_read_string(const char *name, const char * const strings[]);
> +void thp_write_string(const char *name, const char *val);
> +const unsigned long thp_read_num(const char *name);
> +void thp_write_num(const char *name, unsigned long num);
> +
> +void thp_write_settings(struct thp_settings *settings);
> +void thp_read_settings(struct thp_settings *settings);
> +struct thp_settings *thp_current_settings(void);
> +void thp_push_settings(struct thp_settings *settings);
> +void thp_pop_settings(void);
> +void thp_restore_settings(void);
> +void thp_save_settings(void);
> +
> +void thp_set_read_ahead_path(char *path);
> +
> +#endif /* __THP_SETTINGS_H__ */

