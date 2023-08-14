Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210A77C2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjHNVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHNVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A47110;
        Mon, 14 Aug 2023 14:46:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOpsp015286;
        Mon, 14 Aug 2023 21:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=DqiHyEw27N+KxLuOxQdVG2zWadIgCXF+JCO98siCu58=;
 b=h4Tky5nndLj1+yNNE8m0q7qJzk+S7V/LTgGZpbKP8wzGhop9hqgrgHuJioGIJxOX5bUA
 3qL6sGLL5j88uA+v28VQAzvsso50QQW84r5tLDhmDGlkJOt+bbafmyxcp80LgKSjSnL6
 5LoKvxeLQtviBBsv6gJdPLS6Tnkkmg4CzFGXgZ9T5LO7Nk2MvvuX2Em7A7oh34CH7J6U
 /5ZePOWfGp8EkSTsteCu7U/n5wah37LUqZhBL2k5n/B+zmV1z+fNtgffjsGE6BpPiQbY
 MX9HJTycruxjtbuxc+MMnKQ7mxrTa9xOHavIU8jF++YBDsFNzrbk89caX5rItQg43jNQ OA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwknua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EL4KPv027399;
        Mon, 14 Aug 2023 21:45:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rdx7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV6Yho+Lh6qooxlQsW8av0tlejWgwqo3PwQ94aMv/8EVEkqj8SWpC2VKL4OlevogNNElqCwT0aM2PytEWD+D6NSKQ49veVl50MBhJrwVC4q9ipc2bYMT6vIrI+QDrgqrD14aCdbdFVc87zKI8zR81Ogl8ZHb0BhX9CJyqNqtR5tgKPU72YQ6f0NOhaPHzs+SzNGY5TGMqCfXTygpPQRMcKv9Y5uOA1FHDavUXc5F0cDTAHPMAovuA3WwuLC69CKJfMb+iTGX1/Ad17HS0GE7bHEwD3J8eEsAyBsZ+POoBesYqJ5T2QLkBkwmGaiBTx6KGvrLoUd3g4XGEizgIDTkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqiHyEw27N+KxLuOxQdVG2zWadIgCXF+JCO98siCu58=;
 b=kPS1m2arxhplkiHgDUJXMCvWiOwTCse3bFUjD+/b5SEiDsBo7vasOz/UfOKK/N+pyxS7Iy1tyNtuhTb/W42AY5XHLHzbBiypS4O/s4RFeRwQ66JCPbgXS3HavQsXJjFcMbFV2aODXwg99yRv+tC8/rk2Ot9AhGlILDWprwVLmlho/kliJZAfk8FI0x2hyrbHobqE7y8HFQUH8W/p/lMRm4ufuFWqLFHUX4aaW467B5LEA4AcRP8CJTJ7pb6bPXD+zcCi38jq5L0+i2CCkWOR+CQQUX7MJJiBpPQkHbvIZYx8vm2beDsllAe+K2OWjmOjtfXGaf6VKAi867ASKSJrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqiHyEw27N+KxLuOxQdVG2zWadIgCXF+JCO98siCu58=;
 b=KM8tsB21cxOzG65A6Np1FIdk2h1BXfGn/4S2l8hFEYquYSFhOL6v0oIFqajqeLEG2KIinNzQiqw2uVzrcYUJb+LRdzqd0+FKcBK31ESLKXZ4MsptDa7AoVLv66xyHqe/cZh0XCBYRGoUGxfjsbWD8UjCQD6Ep+hbwu0A3DYe7cw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:09 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:08 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v28 6/8] crash: hotplug support for kexec_load()
Date:   Mon, 14 Aug 2023 17:44:44 -0400
Message-Id: <20230814214446.6659-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:805:66::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: eede8638-0839-41a3-a027-08db9d0fbac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7CpYa87Hb6U6B8FILqvBeBm2ktvKGvKS5xR3XUcKHlXcKUdtQ455zdIbGpdmvTOk65avag5oHs9qzban4wPNVloKlWNNuHfuaAVuYcd2efiF72MvLyL6j0/I0euE3YUsC+vJXF8dht8/Dk7/fdrekByUkHCglgUYKqY2mV+8+XlHh0AnmQ//lYxJPaDUeomehcu5zqIxpMjzE6qc2oHDCtZjUVxIzdGVpKhyTfrzT6d/yHgrKIGbW0KbtqKT1ebvZBil7AMqdmimj6GzjbRjnvIoqVityyGyAW0hxyIQvreR4FRxOe0cb+79cpGbHbHTjTXySY1JftSjsE7pwzKqRunbc3bi/ko4lS2eeSMGA+rM6fg3UbcCzo9Bd4jAzS8vskSPscvHQ+3P958qC2FN4/prwE3KHcbcOudrpG66kFAplYLPbvit4P6A4UaF57Ip7cJ1NvlyZQ6mGl35rWHNuDne8XBzJiyQQSsilHiRS3Nsla3qdgFy0kzetkQuIfr1wuh4LiLwjAt0ryr30Vpk9YtqBOzb9Sy6NfAkhO0g3NPB9AJGuqmI42doI3r2s8TttX3C0RDiLSM/d0PqOfbbhjWMwJ+BQ/OCBTuVRo0gCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(1800799006)(186006)(451199021)(6486002)(6666004)(6512007)(6506007)(478600001)(107886003)(2616005)(1076003)(2906002)(26005)(83380400001)(30864003)(7416002)(7406005)(66556008)(41300700001)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(4326008)(86362001)(921005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fba8A+QFMcxlmG4P5ifZlVahnDltLEDtJXkMwAqaETatZidZ8aC2hNeBjqGp?=
 =?us-ascii?Q?Gescq3ptkD4fzTIZZogaBFBBBOgp1ydzizS2A+LOavCC36odP6F+qhnoKVkY?=
 =?us-ascii?Q?sNofrwyr54sHKd0j4gdYo8SlDA7zdvMh1JErkyeVKBa5RN/9PaGBjDvEwXcn?=
 =?us-ascii?Q?k2IvYrXPIEx15O/6Z5eSnCU0XGcBfrghWM+Yg7zHMT1Ngd4xBVMxzstH7/VQ?=
 =?us-ascii?Q?Be3MXIrz7lLpZIentdC8g4fTTuDmzKVxIzJ+hR+1oqE8Rb9bWDokoHne00Ll?=
 =?us-ascii?Q?8JkUuE4uMl2xrrLjQ/KWtAzpRj+Bjwrf0MdbgapJYwEE3NYQZGhPI2kdLkfZ?=
 =?us-ascii?Q?5mFwLS9ZQxA+LG7KdOel6nce8qMfQYKFC5WJ9y0lSm+kYwp0GHttyzlYAjOQ?=
 =?us-ascii?Q?Oj70AFbtoeXR5/aXwBPPeN3YC1vxZG9aM/3kT8VUvltcX/GHgsK6m9BI7aNR?=
 =?us-ascii?Q?4MVRfq3rNPCNugJyau8W/Au7+8u5Xu10DGK1MfwGUzizCZIGg5SseciTNeY1?=
 =?us-ascii?Q?n11HYVH/BbFJWGl0IQe+qjHApiVNFCbG8AYzNvV9KW8EJRleK4FtC0zMWlrl?=
 =?us-ascii?Q?QXTgoRNDd4Xz3zGrDOzwZJEmFP+i5DrKOBmuch+H1UbTPNHpuJvLGoUYQ5Pd?=
 =?us-ascii?Q?uNE36IITrvq2rp9zGnTzPMqvCZ6j0BrKrZDgrb5k5SqIKM/I/Wy+6Z0EYLMY?=
 =?us-ascii?Q?s3fLIKuEXilZBHygvRiXw5E0EwX2W/4cpHj1F4Xz+UV2Ox+wW+CzJ21iX2yX?=
 =?us-ascii?Q?JJBdR8eFzztPt+JsD3QM7z9g7AoDh4e1YClXbKmOdEkwpZp8fogrxsN4rcYJ?=
 =?us-ascii?Q?eN6WPYR0w89fG+U5Q7FnsrmyjuPxwJsOeFJIuQmRRScWAle9cKJymOzDPqwT?=
 =?us-ascii?Q?SZksJCCU72MDdB0StLvivlYFCVw6cPHX/trWf4XiVj7+biQJ1MqNBJPDWo68?=
 =?us-ascii?Q?VSX8jIlamwmAGOYL1xBmosh81uqK4ApmOz9HcIa8bmSXwJl0EUyRJy2p6Aup?=
 =?us-ascii?Q?QBThx4wwX6oG2oFysALYG7dr7vta/HEP1r5DUefsCOrdBF7W+Jn/hc5z2qap?=
 =?us-ascii?Q?XKDE42E1EUT7CZUmWrRGAxGrF6EHr14GvwCHO771oZ5gZblSZtfy6dodWAsd?=
 =?us-ascii?Q?ycv/R5CoNXugFLlbv2yUzUeHNkJKb4cqDTRb5pGrRhA+OuNpizn9JoPuJq24?=
 =?us-ascii?Q?EYYsT4AdPQQ/yl9Ss7gGaVyQUSGdE0k1alcmNPIDk4o96D1+Le4Z2+VUH6i+?=
 =?us-ascii?Q?n6UUTxWChxgcp6V6UJglcnbL+C+/52Pr4qibh1hvqSCiGMMz+d4RT0OO+rP6?=
 =?us-ascii?Q?UDBXbi1jflDmXi/yaBLWhctnzKXFBhyAPsGi0DfRoVV9fB2lzEuKhaZFIKZD?=
 =?us-ascii?Q?9V6MWNIZ1xNikPaZJ9dYvGiO4C6Q/yiUN/+SL09ezUveSIYJ6IDhNmvH8e2J?=
 =?us-ascii?Q?g8+lWCHPWtv7cJFZtRlCX+ftuXnAbLXsG8iswOTFlHx3P7jDIFGU5QBj7wjG?=
 =?us-ascii?Q?7+gcpmf+DLkJxLCPS03jq2mPHizRJHJ87nJek8U5anJ4BgX/hmVxYlUA8UYm?=
 =?us-ascii?Q?LGjxVkSl7wAfkSI5dhedx8Tc8HTmXTHQDrrf3cjPl8T8BP805JGJnF5BT53M?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+n/7L4baL6zp1P9/IghId8j3mCCwhOoLeF0PaM2T1vZI3RYO6Evo65rPoiiK?=
 =?us-ascii?Q?V/tk5LjWVpYSNYgTCz3OsyTnhkTOcs5VwpIsT7qvEWdc9OZVLSk7dSWOGHWU?=
 =?us-ascii?Q?qiTWolb9ojFlbDGigKNHWVo8HuvjiJrD/7RaGwXFjxT1hyqCfaVzBXExVtlq?=
 =?us-ascii?Q?LZPcOmwVN+DJnzdV6/mfzHZB3ZWYcqjwZsIEjOGZZLG+Cgm2h/joRx/RP1/a?=
 =?us-ascii?Q?z3PB8qfxmojcEutqMjLI6CYTgkmYeEVYpmKlOyl5PD667RxkpbkjokUCKb+d?=
 =?us-ascii?Q?ZrtppN9R6phqzc8fDZky6kt6dhrsf/23hC/a2c1y5lYwtHkyo/FvJjfHelfG?=
 =?us-ascii?Q?P3AZGtQi4W7BUxWeg72jVsKZdPvNhIsVDexY8f3tnZZ4HT/Fnhwh1Bfubug4?=
 =?us-ascii?Q?869JqlVkLvqJIOsmXCMEYw5vmhdeX0mOwUXXKiSlLBLblKbDauu/h/9oCmrw?=
 =?us-ascii?Q?3Vj1kPNtvAWjwZQxP+ac50S1OcefweIobqXzpiWZZS3PkFh7+J/qqMT1LeKT?=
 =?us-ascii?Q?K9qiA6WKk2tt9jjtqFLUKUh2uNeyku3KJFgj3gmDVt4aiCUaRmnqUbkRqrtC?=
 =?us-ascii?Q?7ylHn/MndovXZqkwjiVMqp4lzK7Zfcd2FFLZw/HxjpteUnwSOG9hg4LArkm6?=
 =?us-ascii?Q?iSDQ5QdfD2DSysKM4Mg/H/y1Hy8jZJgsrrVqysTlpv5BEVnwO+gvZUF7y2GL?=
 =?us-ascii?Q?P3kdTQXsqSSbI4BS3P333DiCRGxDUQr0MOihYUXeabkq5Fj6Iw5NgEmsJj8Q?=
 =?us-ascii?Q?EBteSgkcZ0hYFgrQAjKTBqhNuirdPaCUEOpIwDKXTVLqQbD+RzmatRSIFfz4?=
 =?us-ascii?Q?boebLLsb/RTf/kMGFn+pLltmLybN1J5+cZjiz597gTVjLg/wLqGwBOY8imRD?=
 =?us-ascii?Q?6ud/zX0at5O8Zno/VZx4u7lQNNEYOLJvGX1r1uMYhCKqRDcqSVOYZQUik0JV?=
 =?us-ascii?Q?Ydne+TqZTI7kixQZtrvmysnwAj6OKqciuJFhzux22MWckLW+lS6XtqhP+oei?=
 =?us-ascii?Q?a5W0OXQN4Dh88bCtlDaD5odWSDA4MJ2OOX8/6NFHvVhOsioxfXVZQCo8KNjl?=
 =?us-ascii?Q?RG/xDRvlUZtvPJ1pIudpqtFLeylQy2Ovp8V5QDikbOgp6Km74G45C6TWX9PS?=
 =?us-ascii?Q?+fjKoi5uh2hEmvuinYw7PhOTXyBS5HuwSiCwVERbm6LzvLy5bJZg9QjL3YB2?=
 =?us-ascii?Q?hGlvn/+qwtpkGCWPHGCAdjRPY4jf9ODTEktJ73rCizqYM/Miw7K18rlPfpHX?=
 =?us-ascii?Q?fQw+/DJ5mr7FetHzfgWm7GlZfEHsJkye8qGE9IaX1jN+HZzgHGW0QZE/DZfq?=
 =?us-ascii?Q?OzWG769innWAHD5clfgNUqavMe0te0teX6Jf4wgypVMWgpGWtaVSMsScC1FZ?=
 =?us-ascii?Q?0yomdN2KHss5/tk5us2crOiaG07Ik3Zf+bXy079wTe9AjVkc/mqEdK8VJbAF?=
 =?us-ascii?Q?id/CWvlGKTo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eede8638-0839-41a3-a027-08db9d0fbac3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:08.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xprWEzYkiiseBd55aUuyVaXidf6WBkh5+bS3SmN6UDGNOsxXTtlGUi2qn0uhUdCqSPIx8mt3BB6r8yFdrwHnfphAI651E+agpA1pxW4dIlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-ORIG-GUID: ItOliSMS40rV9tpnB56fvK_BBcmcE1Ku
X-Proofpoint-GUID: ItOliSMS40rV9tpnB56fvK_BBcmcE1Ku
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires changes to the
userspace kexec-tools and a little extra help from the kernel.

Given a kdump capture kernel loaded via kexec_load(), and a
subsequent hotplug event, the crash hotplug handler finds the
elfcorehdr and rewrites it to reflect the hotplug change.
That is the desired outcome, however, at kernel panic time,
the purgatory integrity check fails (because the elfcorehdr
changed), and the capture kernel does not boot and no vmcore
is generated.

Therefore, the userspace kexec-tools/kexec must indicate to the
kernel that the elfcorehdr can be modified (because the kexec
excluded the elfcorehdr from the digest, and sized the elfcorehdr
memory buffer appropriately).

To facilitate hotplug support with kexec_load():
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR indicates that it is
   safe for the kernel to modify the kexec_load()'d elfcorehdr
 - the /sys/kernel/crash_elfcorehdr_size node communicates the
   preferred size of the elfcorehdr memory buffer
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) dynamically
   take into account kexec_file_load() vs kexec_load() and
   KEXEC_UPDATE_ELFCOREHDR.
   This is critical so that the udev rule processing of crash_hotplug
   is all that is needed to determine if the userspace unload-then-load
   of the kdump image is to be skipped, or not. The proposed udev
   rule change looks like:
   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The table below indicates the behavior of kexec_load()'d kdump image
updates (with the new udev crash_hotplug rule in place):

 Kernel |Kexec
 -------+-----+----
 Old    |Old  |New
        |  a  | a
 -------+-----+----
 New    |  a  | b
 -------+-----+----

where kexec 'old' and 'new' delineate kexec-tools has the needed
modifications for the crash hotplug feature, and kernel 'old' and
'new' delineate the kernel supports this crash hotplug feature.

Behavior 'a' indicates the unload-then-reload of the entire kdump
image. For the kexec 'old' column, the unload-then-reload occurs
due to the missing flag KEXEC_UPDATE_ELFCOREHDR. An 'old' kernel
(with 'new' kexec) does not present the crash_hotplug sysfs node,
which leads to the unload-then-reload of the kdump image.

Behavior 'b' indicates the desired optimized behavior of the kernel
directly modifying the elfcorehdr and avoiding the unload-then-reload
of the kdump image.

If the udev rule is not updated with crash_hotplug node check, then
no matter any combination of kernel or kexec is new or old, the
kdump image continues to be unload-then-reload on hotplug changes.

To fully support crash hotplug feature, there needs to be a rollout
of kernel, kexec-tools and udev rule changes. However, the order of
the rollout of these pieces does not matter; kexec_load()'d kdump
images still function for hotplug as-is.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/Kconfig.kexec         |  4 ++++
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  5 +++++
 kernel/ksysfs.c              | 15 +++++++++++++++
 8 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 4b6cebceec68..1900efcdf1bc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -429,6 +429,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	/* kernel_map, VMCOREINFO and maximum CPUs */
+	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 172e9a544928..32c78078552c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -320,6 +320,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -396,9 +400,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -486,6 +490,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -494,6 +500,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index d0a9a5392035..6e5350d2d7a6 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -144,4 +144,8 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory buffer/segment size under 1MiB. This represents a sane choice
 	  to accommodate both baremetal and virtual machine configurations.
 
+	  For the kexec_load() syscall path, CRASH_MAX_MEMORY_RANGES is part of
+	  the computation behind the value provided through the
+	  /sys/kernel/crash_elfcorehdr_size attribute.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 40388ad51034..34dc7bddfd77 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -740,6 +740,33 @@ subsys_initcall(crash_notes_memory_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -770,6 +797,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..107f355eac10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

