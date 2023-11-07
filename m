Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7467E4B49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKGWAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjKGV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36C10EB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJWLU005429;
        Tue, 7 Nov 2023 21:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=DMUkD8VVua9HrGNysHhMP9T0hjlKGMUGQzHU+hlGhOE=;
 b=qyRZXRWHvTTLS+Fm5Nq5s7ieBWX7syqEBPj8kqoJR+uVHnxyWNncKr+w2MiUh+ohqEFH
 5hT6MAg1WZ1zUOXdbcAwzHov5M4mMTyg4V853JGRw3kyxPDih1HydZyDxbKi7/HYcxwW
 3z8jkHrcMAQp/kxHLDiM4Cg5H2h3MSwgPBZQjM4A5fD7ArGZsi6qoFvim69zjI6y3ixn
 r3bDUBisLRMTggUZ/NRaJJzOyNoCm49ZoJWv6Oe2XLWjDQpXY/3LyWxQnrCLbvYjbBxM
 GQQ0ZGBeUxetsf5i6DzwUbgFwQsCtVvR5vNkrBcnwYVTkLmsxPjUwZYiKNzcJj2q84+s 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgcT011085;
        Tue, 7 Nov 2023 21:58:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tshe4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJX8VRrcL+W6eWEGCEWtM+TJMKKDM7nDsx+ShxnJzUr04TJ9gWKFEQOE4GYU14Ay4/X6xVmsefR7vMNlRj5IKQADVOQ+SDO0GrtTDHl6xZjdYMgW27TGlkHd24GxEkDkTXuuxZKwUgtmhby30ivAg7tICEiEJfOQwV/VjSFWCu4sJqw4iv7RrpsJlAXdaIjGteQItvsUvc3mw9oBuW/o2P28cdh8ypMfx7Fkv6esKIWUMBMHzp8cXllrHc4KUyg7rNfWCgIEK68u7bEzWNXY1athDtn8z/UsCE1KXxCgR8CZk6DBA+T0gb0uSDbOj18uBNq/LFLoyRryFWOMmKfnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMUkD8VVua9HrGNysHhMP9T0hjlKGMUGQzHU+hlGhOE=;
 b=LB1eVr4KG4Sglc8GkKhUFPh1cfiPFEBEUlZ1/f0OmDDsTyWPoZXSF42MnOQw/AifwITI/AZSAdMl1eBeDylGyBLVArrTnjCVGtEj9vFU4+0Ar8hQXcvum473Stx2T+TC2+ecy8NPX63gc3+F56GaI5TPDd6+50s9yXRHAtwZ1zbhqSP9fXyOE2eRhgdN9UiJeUlBDZeBNhDeHvE5i07vvCSVlAHRwwhdqfYyd3Ah+WRP/9RV6GGr0xDxemi85Yz+wUo92VxBGn+FIZm5I0sfR5GYuF48qUT5t4rRxae12THlUIlnSnG59wwtKLaSoygt8mKmwz2M0urfK+5kRzGTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMUkD8VVua9HrGNysHhMP9T0hjlKGMUGQzHU+hlGhOE=;
 b=asTwSQygVeRTRspwYMVvWq/BYtumq+Spv+ur7q5u+Gx/+/T6DH1EPZO42xMvF07e3DCOep9fujuIaWqu0F8wMIpjQM8W5ozM9fmOpzs/Q5nDg+6r3S3TQgWEs2H5WIqOi11AHgl++40sgkfI6jQ2K9PNpcD1pNvJBqVISEzmxuE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:31 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 16/86] Revert "sched: Provide Kconfig support for default dynamic preempt mode"
Date:   Tue,  7 Nov 2023 13:57:02 -0800
Message-Id: <20231107215742.363031-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 96208147-3296-4164-6a63-08dbdfdcae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0/MRD51v/l+y5uSj8FZ2rSmnTZEiHVtLhITct+CXCKwpdH2BZ+5NCvAc2Cs09ulxx+ZZyLr7esL5ru0WQtIEgaK+yqwb536W/AjyCEA2H0pL7u2ifXa2Lfw5mkKMijfqADTZd3OCxRsxFai3qLfzixYkQ6lys2zrFEVupDC3C+8BQLqXM6F3gPRLbx9OOR5/mob59CLxfCKJgtCli0BHDFJlqQ8YlDjRb04cJX9jRw9oDH5+QSfN3u05lPup1ydFL0lbv2SYtqo1Essijp39W6AktJjQ3qhSLSeD9yhNMN8Ob1xfIJK4FsYGZ5w2nN4ZufjzbuB0xdacxWxLfm90oVKCh9OULU23BoyLAoJ6L7dd3ZlAZoVKDFLRxisbfqf+ydwI+QMbb3GXdkdRjsArSk//9s3yjtsYaCtbj9EMQZXrX9ycWqE4qwGBGwpmwXPMyY9ppNofoWabylUTpSXavflOcdfbzOfOtUlSo49fULRcVxj77NNY3PqzGUMlhIyRycmlcJNrZE844lvBDLVz0ENzjdui04FjOZLAxYuud2Q65QR+JawYnBgwYD5PVMk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQ7dIqe1oIA0gFNEebTCYB8JpT/rB/GRsrmcVLlXoBsvMWTw61gVUQp3NuHz?=
 =?us-ascii?Q?XWuN11Db65+k6dWksrZdJjGKBJTZsFjwndcFYXiodWZ9TKl2zDLwrmnxPtNz?=
 =?us-ascii?Q?W8SUhjmZAv74Rq4mXNFGnDuVz1n/NL0HJPaUgyozzXwDn354Jbf9+ADKvlMu?=
 =?us-ascii?Q?T2aN3VIuUz46R9cvLtc8mDzAeM5ITY9S9Sll3fFPuJcXMck0GMF1TRoJERAe?=
 =?us-ascii?Q?tSSotvc768GDl36g/TvnK3N1ixduy/VtzW9K1jKnRcOH3CWTEMiHj239fv/B?=
 =?us-ascii?Q?m157laOsvVgxY3RXdqb5OQ2LIoTDHGRoCkyQM8hxuoRUdNu4r4F532MxKyjY?=
 =?us-ascii?Q?85eywyc5pzhhY6/zrRs3e10az4iTZ9cKDbpy3Pott2bTnJKRN+Ig2QBLIt8A?=
 =?us-ascii?Q?fBAywgeToVepaDvOCOom0bbXA5z4wDuj/fpCE7LuEB5gWJalAS0sBzoKb+rM?=
 =?us-ascii?Q?G2kdFBiJn6CawozgbqeA7dckk8B2eGtc0u6j+IXJThj1C/jZeF/c9LnIEcs/?=
 =?us-ascii?Q?Kpjl5fCVJr5Ubit3tb2751fYhC6TkBNUL6DPzyRs5Cg7Zg6jlUH5yCaRHuYN?=
 =?us-ascii?Q?c5FIqIyveGSYxoYSGVxqOPVUrJMHe579mYUjeGWsNjFsNBrQsyav4gzysc4k?=
 =?us-ascii?Q?bCwvx0kwq4iPsvEx5PCg0SzAlo8RI4JC68yxvcM7gz7WWawgxcbGImrnAdta?=
 =?us-ascii?Q?fFunUGN/jyYWt+L1sl5V1ztXLiDjwNwXEKkRBJfHm8lTdAAw1rT7AgFOXG/C?=
 =?us-ascii?Q?lhkTfTpOcoV1gXQ+m0V5tyxPGXFHAvZy08i1FxynipW9BF5A3+6fE/qgvqkT?=
 =?us-ascii?Q?3ZCTqWEfxPhFftE2Ba+tiR2RNa+LqSYSUWnR5VW+zJ6unSt/I8C2F+HPwDbj?=
 =?us-ascii?Q?qQWwOxWqmE/LhICW0zcHb8i+Pb9JoWXtzEnuTdCPl/CbM1IsyVzdvxPaHZ+B?=
 =?us-ascii?Q?WYZZ47hOCxzJiQDSRSUdgVfOghVKm49pYDkjHDXCE+UewRxA7ZW8nfHXlSk2?=
 =?us-ascii?Q?NRR6TDawdfQs0RR2GxXITCsjtpusVXFXaiEHeSUFkSlQ48y/7n1MhPslQJ2k?=
 =?us-ascii?Q?jluZyCsf4HxZZ4jl1/HFJM8aIe+LU2cgyBOuPGNpq3FKW7FxUM+jisO7KfXO?=
 =?us-ascii?Q?DpyS5a/jjnCdNaEsZ1fO+LOYK3CAZm7sdKnt0c1gKtu1AwALMzj9sIhxYGrP?=
 =?us-ascii?Q?CRbnQH2Ma3HQ1mMvmlTQBUVyh9Q1r5kCcAzvB0A48PqHuZ30EeW0UQ5yl732?=
 =?us-ascii?Q?G4fM4xq6xjOV4QcjS8kHTdc9bgsUaPCodMpoQtuO2TDsU/X2e+7yTRL95NKW?=
 =?us-ascii?Q?VNoekpf95bLnvkdO0KFkWD20ezWOE+lziwKcoPSAiR++bXuGgQQXnWJ5gfkI?=
 =?us-ascii?Q?TkfB5mJZwu5e8BBnzEHJ8U2YCoyg2PVlwr8lH3Hrj6l+8+C7Yj21De5UZR2R?=
 =?us-ascii?Q?Wwg6Gb4M29ZaLu12nwmhBDg7hUm1guapPLAE0A8GNUZyJ9xhROZvaBfW1Yz5?=
 =?us-ascii?Q?TIcTJ6F30kF0ZEgIWsq77mRqK1+hy73S644LLjlZpTHJcF9A0KPCb5Ji4wrB?=
 =?us-ascii?Q?8pCQtO2QhxlClNnG92T0DwMV4jHh15T9KiK8uSpDkCKA6kkLb0CXrDC/F3F6?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gTUzsKs8UKVDFtA15D2+zPyyjoVYsa2cfIxicvCC5zkLmiK1VBfsyc6ttUIP?=
 =?us-ascii?Q?eXzuT0Md3uzWp6JaowS17AlHnlIV9iN4SHpfJ53lfRE3iv14OiWON0YGJKyO?=
 =?us-ascii?Q?E8iJevRxMAo3nG3wy9QC6MKb6s7oKWs31MoZox4+M8ztimUf6XfO+kG8CW/r?=
 =?us-ascii?Q?9mdCyhrZYsU+SgGc1OVM0rO6mzg9SDv9OqRX+5Lp6PIaPBKbdjg5quoq6Mno?=
 =?us-ascii?Q?+ehuw1axXTqVOEgEi16SeWzE92DbPZMuH6J8kurYCeQiuE2XmYSxHqV+6tEy?=
 =?us-ascii?Q?CkwZw3W4Fqexupj/39+GBfT7SfyYcXecvxGhp2XYmpegLOnU1WMSK13l4jb7?=
 =?us-ascii?Q?beq8SN/l1vDwD+HIoIp6iHagpQ7ebnhfqO5JggV4lIEUNI+Q0mJT4zAogg5K?=
 =?us-ascii?Q?motdh4QoBUqnZRBmpxpVuK+hvGhJSUTq+EPk76ehwM7x0Nwdt2JdVd3HFg9t?=
 =?us-ascii?Q?T0TpuPauXGj/DsNPwK/bFiAc837k17hkpqheVhlbuHsKYbtR1NnVtRrvP2UB?=
 =?us-ascii?Q?jutMOcs/8uZgP9MfPYXUcPyyuV2jHwmcNd7zSejA6Jh53/xt7UhBCjbDbiJP?=
 =?us-ascii?Q?d09yiHaFSgH7PLd1596TRRIMrSbuAqlFL1oWL0LZl+Gt38AqNPiOjAiUM+sR?=
 =?us-ascii?Q?tKP0ypkiev0HEums/3C8KU5rb89dHm3DCLhvoN5VH6Is8nGtT/yfodsygRwu?=
 =?us-ascii?Q?l5P8vW9Fy0VgwqA8xY+NcRZ5USc9DSF+T2eT3U3qlRSFE0kJ++ljQnn7zqJz?=
 =?us-ascii?Q?Sv0XryvYwjLcDtpN7F6PZb30yORXDLzP9EkOSd6dfQaU7fccu6Ni77eSyYvu?=
 =?us-ascii?Q?4vbKP92FH80rA8LkOywwoAQrKYunsM0Eq151F9MIYhlBbgIME7jv2Q1jt2DO?=
 =?us-ascii?Q?57zrf+KgMFkeBsUnlKIKuFv9rh25WZxT6DM25/MCWDPgNaifGb3Iq5x86SYM?=
 =?us-ascii?Q?PFV24MtQwYVR90W0XuMdo8oSsK/Zughusv/6+RXmnd/uSNNKcNf/GSWyw+UK?=
 =?us-ascii?Q?fA19bzANiL32yhY87t48QV/mmHR18gH4wpJW24SuHz5gKWMVPC/HLGdz0E3Y?=
 =?us-ascii?Q?JZVxLXTlyK6G6vPdGYOe+HB9T+IDWbW4ELqhcO7tbmAX9MPJfkgouIdymAa6?=
 =?us-ascii?Q?TQXFD2lN8qkuPPXKG2J+wF7TmTmoRUSrPwaIleGgYLqiIrh/9FumHhzSFcpy?=
 =?us-ascii?Q?hnEfhg9NfFjsf15/hGVA4ZiacUJ82Zn+HMbQGhGPq1FYuOETAzPdMNVj5nNn?=
 =?us-ascii?Q?q6D3ohQNuazpusI+TsPEmOz8cPG8ey97Ch2dYNaYvMHrcJBvDwsGKv6zfmeC?=
 =?us-ascii?Q?a833yTXzzD/1UaGmhpNJ659afBo0FxMcvToE2BA5om2XKBlxy1xm9JjN1lOS?=
 =?us-ascii?Q?QazTlivhQBQ1fdHYv/8P7B/LFOoeRN5zYEt2zdgVm9U6MeZURJ36ko6I2f6s?=
 =?us-ascii?Q?ZHImp0HatlhBxsK4dQWTEak/IrbECM9O5PP7p1UYw0nhJOhhnLBx5AFXa9Bx?=
 =?us-ascii?Q?BVW8w802EOZbX9C4siTcdQo0v7CClqnKJVfRzuT0NqZzbons735Fx+LxcQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96208147-3296-4164-6a63-08dbdfdcae77
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:31.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gweT+sutDhTI5suVpMtzPOIwgOxjk3vA78Y2NI71kD7jjkZm44ViDzIeFGrtvk6PGKZv0QiS6x7h30WbKIL3avoDn4cPvNgOvcpP3omdj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: E60aNi2XA_0laaOBTAOdJZY9WD7M2H7r
X-Proofpoint-ORIG-GUID: E60aNi2XA_0laaOBTAOdJZY9WD7M2H7r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c597bfddc9e9e8a63817252b67c3ca0e544ace26.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/Kconfig.preempt | 32 +++++++++-----------------------
 kernel/sched/core.c    | 29 +++--------------------------
 2 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 60f1bfc3c7b2..5876e30c5740 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,11 +2,10 @@
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE_BEHAVIOUR
+	default PREEMPT_NONE
 
-config PREEMPT_NONE_BEHAVIOUR
+config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -18,10 +17,9 @@ config PREEMPT_NONE_BEHAVIOUR
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY_BEHAVIOUR
+config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -37,10 +35,12 @@ config PREEMPT_VOLUNTARY_BEHAVIOUR
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT_BEHAVIOUR
+config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -58,7 +58,7 @@ config PREEMPT_BEHAVIOUR
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
+	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -75,17 +75,6 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_NONE
-	bool
-
-config PREEMPT_VOLUNTARY
-	bool
-
-config PREEMPT
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-
 config PREEMPT_COUNT
        bool
 
@@ -94,10 +83,7 @@ config PREEMPTION
        select PREEMPT_COUNT
 
 config PREEMPT_DYNAMIC
-	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC
-	select PREEMPT
-	default y
+	bool
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d3828d90bf84..12f255e038ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6991,13 +6991,12 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
  */
 
 enum {
-	preempt_dynamic_undefined = -1,
-	preempt_dynamic_none,
+	preempt_dynamic_none = 0,
 	preempt_dynamic_voluntary,
 	preempt_dynamic_full,
 };
 
-int preempt_dynamic_mode = preempt_dynamic_undefined;
+int preempt_dynamic_mode = preempt_dynamic_full;
 
 int sched_dynamic_mode(const char *str)
 {
@@ -7070,27 +7069,7 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=", setup_preempt_mode);
 
-static void __init preempt_dynamic_init(void)
-{
-	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
-			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
-			sched_dynamic_update(preempt_dynamic_voluntary);
-		} else {
-			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
-		}
-	}
-}
-
-#else /* !CONFIG_PREEMPT_DYNAMIC */
-
-static inline void preempt_dynamic_init(void) { }
-
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /*
  * This is the entry point to schedule() from kernel preemption
@@ -9966,8 +9945,6 @@ void __init sched_init(void)
 
 	init_uclamp();
 
-	preempt_dynamic_init();
-
 	scheduler_running = 1;
 }
 
-- 
2.31.1

