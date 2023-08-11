Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2857795D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjHKRIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbjHKRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC791FDD;
        Fri, 11 Aug 2023 10:08:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDuo7i003538;
        Fri, 11 Aug 2023 17:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=4ESQ0fuVQ1wBn6eGJfxU2LaSH6oVjbQOptiEhCAM5gt67UOIi/V4YIfj3iC/CDbIYPiM
 kkhCBZNiM/kIToldeaNXhwoSJIj06dGmkyYnnRg/5fubbr3LelxpJEWs4rhtrsmyAwHs
 FblZ60grlgW2u9ydSkXENmby5QrDFNKBm2nhK0loTLFXiMnP6pVni/83iEmZLri1ygpf
 KfWdmwSz+4fddtnjUE73owiSFctNNIpVmACVSz+bbtdq10dE2UbQPK+nEjdqlxhqvwZh
 NURw9Am2kfKcQvHH+RDMNd8N/RRL0NiJ3AeZVRfRpDCck239IROwwtZhSt2N6pKMnOTA MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y6hf9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGNsqb012089;
        Fri, 11 Aug 2023 17:07:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva2gg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzB1Nre+X8/MGdGZtyX3xRJ0oOetH6NwqJmL15FqC6UQkeUCuYhEnsg/YNIEmT7kzieORcOW1jvxf6P0Rcn0pUKlfaWMZtqwt6+pJWWGFMDtR2Nl8i6bWt5zxrZKUI5ZekH5voDxei2aEjVJOrZFGrhI1dPKJhmpyWERKihu6csk/gavA/ktsYFLkxlXVUMjWVeD6mxWshSP5/GZnLN5iyZN2yrSVqAmjoKJ7OWDPg60xtCbGaB3U6wUi8BG0p1IlNoNdM5nXSOeBGnczWHgXmltfFDC1/TbIf1TwVANmmw7iKY60JMh50dkEK7tw5kKJBmqC1kC12xdmGG1s//1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=ZSjFoYylWQJJaTaUiTTbKXFOkHhT16GCgAc7hAFh9hRg4HayI45E/HX6atYwac+u3InI9kTKtqmdTQ6rBMofhNQtNV7zHUvkLq5mIgVzAZjSsZ7eTWoEtWl0mbhA6KqTZgDPQWOYMGCTp0s9FD91C4v0IuTtMkzlEJ1AoSNJInp3QyaoI6JWA0VhFIDWRJ5EMGHdfpl1Wgj1pjDyw7IxKrbu3Lvfo8hwwoPgP7jRfi3gd0hEW+y/dkS1d1Cm9/3i5Wx1pCOrzfIC7YsvmVE/D6gdaiQs87dKqkabCHuv1Mc2HYdm7KPoU9FAImkxFkJvIEBLA6FA31ZZ9jARKNBxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSKEXyVIenyIhnny+0ljW8sRLv+oqrr3PdZEtUnoGB4=;
 b=WFtIhmRcMNPaBtO7iM8rl/jptNiXsdpof8fCvGgVFGdXlXrHDHVMTjh8M9LoQ0qX7lb+E30CSmyTUo1d1upmWNGAOlLd/k+Wbujw2cPdQCN2lHN5upmrXRGx8HyQh5L8AbHAfmCNgO62WIi5brWqzlAGRjy1fbMExMXFb1Bkuco=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:10 +0000
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
Subject: [PATCH v27 6/8] crash: hotplug support for kexec_load()
Date:   Fri, 11 Aug 2023 13:06:40 -0400
Message-Id: <20230811170642.6696-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: b34e8b2b-b64a-444d-703a-08db9a8d666d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hnZjtInIfPC9Z2U+e10gW5b/dOx0jL7HvZY9fu+UFF9RbFLtJQrJ+VIBnj95uIdu0gjm9NCAVaZeSBeQYyAkzDmw3UPZYPv6ZEq/azxnoMUWdV4y2QxoOiNHBZyI/SVaELFMHZ6mo4zMtlc5PgG3eA190y4A9BVtNnrwVjolwAkGPF/lcoiwaT5OrSc7Eg/SuVqLYxLcTDbrKLsQW/7scZS6mz3enkMv98a4dfzppmICCyppW6p8VctElL7IbLOeR58SSpg+wLz1eO3GaZWF/ZO5B63I2y2shsKyT+N1qV4ljQIgEHsWj40zX+YC2OeTS/RxN1gcj7WIbr6D83TZlaeaoaQUdYF/1FtmfVv80MFWtETdo4+LyXZbqup20zY+PtQUKrPfxaodXC3afa9LRf/dZGm5rIxyYijCldVztPKBB80dn0C1STlEV/vxhmg4IxHgfEVMkGMElbX20ssZ3qGz6Mz/FMMX6JwZlwpz0RzcQJGpdjgO4OzOURnru+HaH/QiwpIwY+4YesBOueDG9CF9oQRItCjPLcYuIUs2SPTr8wp701fU3JHbb4iNsEv9aNuKbegougUrkiS4IRGR1zCn2fUF09DABsc4P53dks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(30864003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ea2y0lPx8YLphVkw0bGSxX1kvSUC3TXwrdxPClFShaS7T2JMyOutLBzx1WP?=
 =?us-ascii?Q?zeJcob4drM5FBueec88ZFkJPXdFYxWvlcFY5pO2DH7O/BY7ecTf/UcjTzTAw?=
 =?us-ascii?Q?1x0WkxPB6BugBKhdu9sE1gu3mBGyZPegAHZFuyzshFgytGtxxgHiFRQv73/s?=
 =?us-ascii?Q?u3KE+aYpJqGXZpzrLK33HeKOSp4rc9N6YNaj2UySrNBGB9jxtZpPPywGJBWW?=
 =?us-ascii?Q?XMQFf5bJ6oCVil8hONPo83UyofvPvMfQEaD0dCKERwH92MC4I4Cx4RXaBKMe?=
 =?us-ascii?Q?daErRiJAGBoXNdRwGgYcBIUUKlvpY5LrAzySRCC11PdFjLq1RYsjj0vXU+jz?=
 =?us-ascii?Q?vmHanXvgXp8Vw9KP1tDV1/nkPx9Jf8S6rsCCW/N0lIKI5UeshwN2HIiw40E7?=
 =?us-ascii?Q?OfzfAcJTfXpinLAivhlHFAk82o6wF40pnTgLDcZ1bitHVREqJVVHnp9DYF4a?=
 =?us-ascii?Q?/lGViO6vkzNbJZgdsSd9vHk3xn2+OC42AKAFym/IyXijWLW7HAUjBSRpPq9o?=
 =?us-ascii?Q?zSbz59v0USbkiStgZbz+0Nohy1YQVVScya8FIJrSHEN8Q+yQOPKr/sXKPqc3?=
 =?us-ascii?Q?oqPnv9M5o7wfLz/rN8/65FoFXjsIt8pdDWWKI4Qiq6YGxeBdbuIxmU3KgKU2?=
 =?us-ascii?Q?ZJoBBjx7IPdpixR55BlIlZz7a8Ba/+BsyKV80Y53Ys18ecDISQar/jUYG26x?=
 =?us-ascii?Q?COn9K1pPTflQBuWEYAnuXdKuzIiyqdB9Ju3q1Puexac8uQngtVVqRTuLfRA4?=
 =?us-ascii?Q?tblYYT5cO11RCOdMTrq8aIJ3jtzztxRb4/Wb6KHtHNK9FqujduS5K+QGuuy2?=
 =?us-ascii?Q?fxa2NC0izWuBJLEpUgiQFXMYoRnZsCEwPE+tONlpPDAHP8IrlmHKv3JQe1Sk?=
 =?us-ascii?Q?mLlPlu4HMQydD/mRJV9SGnyNSKhJHxOHu1i/oxFZ+3guTdxJhENxyt5m47Qd?=
 =?us-ascii?Q?Y9qK8uZgGcjVdlKyq4IGRNseGcxtGhltUpi021xx5oaoeuB8H3a5eVeYhaig?=
 =?us-ascii?Q?VBRJkwLWWbDmz9Q5A46fHwzH+mJ7mQg098czGDsPvsJYXWgzf9w/a99/SSiq?=
 =?us-ascii?Q?BOwPQXctgb1nh+LfdNgLCXQ3sqZevNgBfiEVAqhfuzqLSXKEMuVFfKVVgY/+?=
 =?us-ascii?Q?i7lSwVNvzn6oBABBdqmWGu/tT+VBwnfN6IZMkh5F87OPG5dUspHow72Fb4Ed?=
 =?us-ascii?Q?YpXMvn0x5soDG+P+nu0TBy1NFRqyfuR5LLx7oKYYHRMnTvH9fD0cQVRV9hOV?=
 =?us-ascii?Q?B8KWm9Pgl1cloPDmi5t0Y6pL/K9OkPT1gSj2WdI/GI34yXxBfszCmL0GgtoK?=
 =?us-ascii?Q?XqBdwjJE0MQ8GGHSWr8xBBKKQnlxDSDRkdMh3WC50cxVc5b7yh4znFR6qtaa?=
 =?us-ascii?Q?BHj8EJoh1+JFnRXlTG4y8NJJnXwGDlf5g2XsvPvZneCnbKmnesUTu/1z5/Do?=
 =?us-ascii?Q?KgtJquAg+pAq4NaP/5+hJBlXgaRyjxiS7Mgi1li/wK8IGjp3bR/jL8EPR8GJ?=
 =?us-ascii?Q?p+ZsOvmAEajylvRyUElad0/8t9XApVPpsn1ZV7jzmLYgLg8kybI8TkC7n+Zt?=
 =?us-ascii?Q?B0uAF2o0NKzTcY2CgoxPR7iRYVjnNVogMgzq/YGQL+oHYuUSHEwjHgot83Cg?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Xtw9aym9kVrwq6ig0hW+LWaEOL/zgHHQ+8zYqJZfjzSG6Q46ZAPzNMBXCI+r?=
 =?us-ascii?Q?67tt3mH4nnD9A3Aptra3hEwiMdZt179wS1KePdtV72hNSjqWWqMopXYPbasj?=
 =?us-ascii?Q?xmkrGVA+DTRLqczDJS1UnjzEsTY5SA8X3dhyMM5J5lczt2mmbUdnTkAx6PV+?=
 =?us-ascii?Q?o4iKrpSeyGb2OBp23VisI9IqfZMODgxya2UCOKLvC3UEFLgCRs/ca6Dh/+XT?=
 =?us-ascii?Q?DqgAaqdAWN6Be50DLCyMfOiw/c2K62sJnOIrUZDOFLIakjKCwAXNWyMs4be5?=
 =?us-ascii?Q?HDNsXfVqo4JHtpgzWsSzK/b9aTD0B0XOn/7lnXClJ1kSln+6ifqvN6QeFKjN?=
 =?us-ascii?Q?9X07vENRGtjD6nDh3iO2V2ILbUoEC8uMfa0efOuOnBPhzt3BxltUnagf1gUI?=
 =?us-ascii?Q?Jt5SBGCSxbLfQR0mkPscruLVpnBy5sHdF52aVDdkl7DALDbVezVwAMP1iPnT?=
 =?us-ascii?Q?4khIKF/Bwgx8/2gaVAMaY/+N3Znb0KPd/bafI+gRwDUD2zHZM9IFSK5WDSKt?=
 =?us-ascii?Q?vVnoJovoOEJwf45CjMKJ7qXTXIYxokVNOsz2zSipoSoZVbCmXb6WsdsMLF5T?=
 =?us-ascii?Q?PhNVCXqD1LFO6pyePhQAZfyvjT1hWWmG4wqbJduNhsBQhb/oqBmAdS3Fbm6g?=
 =?us-ascii?Q?aQqiWDI9ZXe6rz6I8WJs+rf75da0KGCWeTkfol1m2K+qgpqe5KeHlmSazjjZ?=
 =?us-ascii?Q?Tj92ZAdxGuo1NfTU9uJhQVjdLM4dkE790ETEvFf3FEUDv9Y000rVO8y4IOxw?=
 =?us-ascii?Q?XKySlvVilo09+XsdLfcT7DvujhYYuBctSSh9C2gv6DVhhfEN8XwC7bPWZxuV?=
 =?us-ascii?Q?44kWOHCAmfGy172RTwe+UXbz0PIdhvqH3mxCGyRG4/BinXsI0srFFB4gg9pG?=
 =?us-ascii?Q?MgXTk2iae5anlHa45L4SN2yUH3xoURNlQKnsC0Om9o/fXXyMZB8VaIiFZVe3?=
 =?us-ascii?Q?KmiYqkf+Ee4PMSM5vaYB1XYkZYBKbV+5eIEl9qA6fJxjzKr/5JyQipJ6rblb?=
 =?us-ascii?Q?xfdKRr9i0fqPPA7e/lhP/AjtajQEPlhL9lhJgjOnBrEcDQWTVNFrVQoKJcox?=
 =?us-ascii?Q?pHw4jc6HYl4lu0ePvRhB8b0T/niOoARS2sz0wgl6I5GaAUbxicHXn1RrhbMi?=
 =?us-ascii?Q?gpRzf5v2310AoTPQticUz57XiBiQJQU/RL4fFE1cplqusuadEDnPJ/c6z4Y9?=
 =?us-ascii?Q?P9xXkv/kUftSkbBy+lVhwBu2yR+xeNGMaZIFF0sDayC71jkMzWVJiAxou4Pt?=
 =?us-ascii?Q?SrC98hCJkhK/2R/Q3N/Nw8iqaBGQbU5n8MX7m3fryv1c059l6XUmU40QtRaN?=
 =?us-ascii?Q?WbvFyUbz/oqt07QVhDFC7Dgbkr1/d3FDDThaMgjzwyXREjpSDZnn2joZjiwy?=
 =?us-ascii?Q?SyIMXeY4lkUXAWgHzRvEw3YY/ce9Gh5sGi8PzuoVH3VxTdcvQJKHP40wVuDy?=
 =?us-ascii?Q?k2KRB3v2hfM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34e8b2b-b64a-444d-703a-08db9a8d666d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:10.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJiks1QUxAJ4x/KksM6jN3aQPb1IFC7BkPLf/6Zm6a5Jl9JEJ9c8AnzGfacGsHqJ0iH9fkfivuz2BS4qUw3EvCb4/axVAJruRPTQlZpdGl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-ORIG-GUID: 7AikSRarhnyBDRmsWvxd7m9C-WrMrous
X-Proofpoint-GUID: 7AikSRarhnyBDRmsWvxd7m9C-WrMrous
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
index c70a111c44fa..caf22bcb61af 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -427,6 +427,33 @@ int crash_load_segments(struct kimage *image)
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
index 6a8a724ac638..bb0e614f2a05 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
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
index 53d211c690a1..fa918176d46d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
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
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
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

