Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B778303F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjHUS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHUS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:28:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC47D4231;
        Mon, 21 Aug 2023 11:28:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxYBt028078;
        Mon, 21 Aug 2023 18:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=CJw8s1kwk0+EKAsRn/QJoK6VcYd24kSCf+sHlszNzLs=;
 b=B1QxRT67OzQm2Y4oG3Av60e2lYXVj+7dsBhcOYtsHHtsh4lSnFAuvX9LbOhQiNmJ98Rl
 vhAVQWwJQ17b2ZLxaEcURQ8lRtbX+ejCLlrgJVw6MYplpZDF9PeXOENsqu+7zdh2Ayo3
 3y+97dRRx6HTNSQoBk8XgfYwhOuREgVFrmulC6DvVEQHAP+muF2ySP0RIVnD7T8iZLiz
 bytwA0icw0e5ZNZ1MO/WG4LR8yUTQszK6zSMFU2wDpqkKnkUdQaqCaO/AY0E+z36icNr
 Aidcn3wVij7LvZ6Ibol9WHECJqOui8If/sQs+pqb4fF6WcaGQEaEquv8e9n5Eq/xrBJd /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9ubfqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 18:26:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LH29Bp030373;
        Mon, 21 Aug 2023 18:26:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63tnyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 18:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx9ARZ61SzHmAhIgu/O5pgzyC+94KDe+4J5NI/FACcwlUffAAQJtIDaamGixVH/FN2JJQ4lhmnnQphcDYHwPtFuAK4t9iR82fLPDPBe5Xa+KKxk7N/hCs/uiYFiwkkLzXk3bWddp6VGwYZqpijb7n69KwogvwpCggnJteSsPkU3MZLnTEXn5u3eUtA6OykCilltGvg6WY+xrg9z8XmiD/nozXeO8QJTHEfDcah2NhSJdz+p7HiV7BZVpJGWN7+kq7v3eG8Ub7+TfoL9Zo3o2AGoZjJ25aOYLegbSZ0Ag7Gxn4sxyAMrwFzI5Y5Bo0lAWp6ClBN2Lo/L5TBYtFibgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJw8s1kwk0+EKAsRn/QJoK6VcYd24kSCf+sHlszNzLs=;
 b=bxDSn/6b4yC4qiBDIrK9oe2z85ir+d1JhGTgFsjSQk/0PW2o6fjOUCazu7D5oYTOKFxcc7L3JONzhx1WV/BsLzeU8TkL7YwT9Zdntz8Hcnjxrh9AcBYlv4YT3BBF3xK0p7DdCbYlePingYCYihHc2ra9NMESK8B+0xo+XI+Jtg8ziylG/zWRncAiOK8PgZ9YO5yRx/YY6EtnCUEmLGWe3rFsQ7bDBwTxkxsR5BZgM+2MrjtcOKjWSdH7u293OWReNLiVEHq3M6Dwx0rU/pODk8sEcw1Q0gAzXRTUPxKHfcijRosvTX8Y6Lh8uaXQYSXGU00+3z47QE/qek7WOk3JyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJw8s1kwk0+EKAsRn/QJoK6VcYd24kSCf+sHlszNzLs=;
 b=e18tEn1kJLOJiUSRFEVRYTe2WGuPVGBWdu61AxR/aU9IJFiTk4Sy2a+5WXveMzkk6HQUgVsq5cBAOsyUf90/eoN5Oi4a+gXgUIOj9gGCoUN+Wz660H5ePSKw7AOFBzKf/f8Ca9j6WGzzsZ98bLTOrmusbND40C71EZTfMXi4Img=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB5355.namprd10.prod.outlook.com (2603:10b6:610:c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:26:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:26:53 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        ziy@nvidia.com, ysato@users.sourceforge.jp, xin3.li@intel.com,
        will@kernel.org, tsi@tuyoix.net, tsbogend@alpha.franken.de,
        tj@kernel.org, thunder.leizhen@huawei.com, tglx@linutronix.de,
        svens@linux.ibm.com, sourabhjain@linux.ibm.com,
        sebastian.reichel@collabora.com, samitolvanen@google.com,
        rppt@kernel.org, rmk+kernel@armlinux.org.uk, peterz@infradead.org,
        paul.walmsley@sifive.com, paulmck@kernel.org, palmer@dabbelt.com,
        ojeda@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        mpe@ellerman.id.au, mingo@redhat.com, mhiramat@kernel.org,
        masahiroy@kernel.org, linux@armlinux.org.uk,
        linus.walleij@linaro.org, konrad.wilk@oracle.com,
        kirill.shutemov@linux.intel.com, kernel@xen0n.name,
        keescook@chromium.org, juerg.haefliger@canonical.com,
        James.Bottomley@HansenPartnership.com, hpa@zytor.com,
        hca@linux.ibm.com, hbathini@linux.ibm.com,
        gregkh@linuxfoundation.org, gor@linux.ibm.com,
        glaubitz@physik.fu-berlin.de, geert@linux-m68k.org,
        frederic@kernel.org, deller@gmx.de, dave.hansen@linux.intel.com,
        christophe.leroy@csgroup.eu, chenhuacai@kernel.org,
        catalin.marinas@arm.com, bp@alien8.de, borntraeger@linux.ibm.com,
        boris.ostrovsky@oracle.com, bhe@redhat.com, arnd@arndb.de,
        ardb@kernel.org, aou@eecs.berkeley.edu, anshuman.khandual@arm.com,
        agordeev@linux.ibm.com
Subject: [PATCH v28] x86/crash: correct unused function build error
Date:   Mon, 21 Aug 2023 14:26:44 -0400
Message-Id: <20230821182644.2143-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: ff94d49e-6cdd-473a-58fc-08dba2743170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELc1hVFap7iQVSXLe5ePdvJJ/jWOIGnUGH59bfRUUvI+qNjzbIM9WtAxjE4KrIwmokCWcMLo1bps6jj11SIfirGt6JO/wJ+VYemBoUUwx3i7g0+T0h+ePrANzMvHXq0vS0yt8XNewglwYm5h2Ihe7A+uEzNGOJ08ezBjiMmGoMpeAYheT5GxwM02BOE+QZ32v1YvHfgVho91CHa7KWIAS3OfRCSIJ/FhrWUkMkvx5TkqzY8bUVOSQCHX9Ku6meooQQ77+feWdoBQuC4iyvprf1uCQlvtGwuh5jHmhOMToDA63/kgSwzHWDXMU/gsRC3gnOiGV9DRNhCTE9PVJxc9JORWO3uBBoRiuNjf4OOxtMJ9F9OWEHYQOb9bMnTzioGpnH1208xpp/8mFOXR0IhbrrtwpAFCp4aR/zdxwiGO1W0sewjfSyrWNiD7WvgWzeNzX+4Aw8ExZE9Lp2jj508xxGHQl5mgqqAGkBV1PVLv6aPgI/9NyYWFdVvuR2IOO4Zl9xq3DC18SxJF0LzMSayfidBGqoSZLhMTCviARGoQNqXz9MThRb4T7ZdhXqysz62k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(4744005)(2906002)(7406005)(7366002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9anh+xx1E+R+pcMxVzpYXATb5gEh7c/6qx8Xi8IMvRTiOCr36ugDQvBXC3r?=
 =?us-ascii?Q?MoLZ8Ka+pVIHMSae+B6Cn/lZ4kihrSHzPU45o2pU8Lwcc/TeUco+0gPVu03c?=
 =?us-ascii?Q?zGx3g+luCSYJJ3GCeetqilg6nWW4Q2P8O1u0MfiUyxqvldJWsRflXbKR+cm8?=
 =?us-ascii?Q?00UOKUXGi60gYyytW6HzTDvHIYgHNMELw9o25E4O70MmmNSMI9OI7W1BgiUk?=
 =?us-ascii?Q?grj/Wc55gDykOyw/xDK/CW5bGeXwqAvs9RLBnDxy/X+sx1p8eeb70AealVmC?=
 =?us-ascii?Q?eA8unUqIqCfa2dfZ5weGkmlmT9mcKpiMDTJw7Zu0SwlwiJCCm35osYKWsDEu?=
 =?us-ascii?Q?6MVXSkMtQwDK1xh2m79YlUhcNbmz0nP0CEW3QXM9yGdE0ln6PRkiQsGvLrvY?=
 =?us-ascii?Q?/EWPYm2ajq1qsfe7am83EbspNIfuJDUniBXP+jUG50qZVFtZhWzLvVjqMxwb?=
 =?us-ascii?Q?Hkfoqjw5Wchz/XUm9fm1G8RQXeAII6HwoClpGZklofOlyfxhwq4enzIyis7R?=
 =?us-ascii?Q?7zoGuVz3xHjiemMHtwaB7rcQfhwfEV746BPr4VwFEGT0mm1xRMiBf6gsyFaJ?=
 =?us-ascii?Q?3Doy5kZ5uZ0Xj88BPyZhL6C01w4tI2+TKvyg5J01d2cN3tvAnmgsnDvjyuP6?=
 =?us-ascii?Q?YvAcnl4V9fCo7dCGjQC6bZfpeX4FQKOcJAs8ymVzMuKHoVLGtOCDNPmSEC99?=
 =?us-ascii?Q?Lef3mVyvrDrKkq5yT2P3/p8hJWgva+RfVfeVn+q8/NLALupnJrNu7Oq0yDuD?=
 =?us-ascii?Q?L3hxCrb1BLk7D0Pp0eGGsvO7niHO9CZ1vzJbMEAY4FqDOBiCfM52o5t28dN7?=
 =?us-ascii?Q?+gIS+ocVxJv6ta8dZFOC96CyfNuTflbl9gEKeB/9Iy4PGD01dVLp6xmVkqSD?=
 =?us-ascii?Q?erbJ17i66m1O/qyXfzb8TSiBeNljYdMWH+6MWL02wRLCdUq3yJkNwgrZZG6f?=
 =?us-ascii?Q?LzA7P27esKhg/W4C6IEuCP4thvAGfvStyJhloZzxWolQUKiQqHTiPMnGXywF?=
 =?us-ascii?Q?u7bkvtgCXYIWCCjZaPk92ff1dMP5Oku6MPqD8teG8Z+Exa/bbKAVJ6hoZY8i?=
 =?us-ascii?Q?UCsgw9f9rg+T6iUs1YeinhroXIQ7ZoWAxMR6U0f627LcpvFe4588NAb3VqdD?=
 =?us-ascii?Q?7pacjnzvGvDOLy3AQG1KfhLQexRf5H9ra+1ZeXxaI/L/PE5Rgtbx0ToZSqlR?=
 =?us-ascii?Q?7KqnUgMuo1Qp/ljl3hj6nv3RwBMzd6zdE2MdcjzC7GxdkrMUkrG8vGMR7yLM?=
 =?us-ascii?Q?xJ0SE4QLDKbB3p4e4k+ZkTObHcA+mfQbC3wxoXUEtpl9c+P5uQ0SL1aHs2j4?=
 =?us-ascii?Q?gKumngAbcnTouGwHUctdRkXtOPKN2awrokJTIO8/T5ebBbfEg30BWTHW4eMJ?=
 =?us-ascii?Q?r8j5wTmqNX0DrAia+TGSl4LG5/DCD+HncFlUJejsKeSFhMJ83kSFPWAayJ1b?=
 =?us-ascii?Q?srnoaMlM5G1QNtnsAhLfsENpNbOD6l7J/Z5VCbDBJreX6+FhLUcmN5nZugaV?=
 =?us-ascii?Q?80x/ot76bs9FzumhcMj2wqxQ20rIr79dRKv5SshvnGwdV1YwLL2ZDV59eqRD?=
 =?us-ascii?Q?l/92Fl9N83nzF+Nbkw7lE/1RoEBAxNT4lizkXLBoMBLcombPeFJ6d5AxIMw/?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vMG0/bZJZcYuL6s91Aob3yebzi7SGKNpheUSzmqR4M7X3A2TUxbs+B8NGblm?=
 =?us-ascii?Q?5kuRpgWFTFh/YEHLOS5P9CAC2u6QpXNwUBovAW+VmQ4v2rtdcOUZUW3Bo8jh?=
 =?us-ascii?Q?wQeaLQs+LfpBBHJnrI7ZNti6xxIKCfY4vWOAT+A5p4HxtKSW2dyP0ToYtOWb?=
 =?us-ascii?Q?GI02xxq9SPnoZTidnTDh31qd7FUXzjS/j0+A0KEU98ZwVhDwG4Tsp5or3Vyt?=
 =?us-ascii?Q?X+2Yt90ilz6G0HF43fGaRPpMw1BcU92AkTO+p+Pq17zfKdlO9YSOgXhF8LHZ?=
 =?us-ascii?Q?YI4pwC7MhuF8G9p8Rk2J4SKKTqDWjXYMrAcRVbIQPohePfO9ekBL+6AvlDg+?=
 =?us-ascii?Q?gXGQRe/URue7lE38kWTz9WnxRBbsrqpb5lJLqYlNPKdFv79Mz/lH9fIMRtln?=
 =?us-ascii?Q?DbIkQr+0jnpwzHYQ3zeB/DmFHxGt8g0FKH6OaUt2cFTT+Bat2S0cBA+XLS5L?=
 =?us-ascii?Q?2vdloYXe88KvSIh1IFe927O9lIHOaIh0OHOJe9WSMpSvjtwMc1JtRkzhH5TR?=
 =?us-ascii?Q?6Cid71Q8Y0RkbmHgztvz2pnocOhiTyQuE9H4Gj1TkjRvEaJkXtdaLUr/HHKF?=
 =?us-ascii?Q?pDyUOMmgEIB2FHgFlGvvPUOeV8Dj3RrwqdfrzcRgyAIof9InjCd8dW6H9FcG?=
 =?us-ascii?Q?ESCzzmSPIzuwqvCgKIjNNHfKMsMOdkATbEtyvMK/piZDe1nimdPRJzAmtHEz?=
 =?us-ascii?Q?m1rdf0p+rRKFJxkWHNSqgXOeETTYkJbSF5md9+5K/spcNyhxyssurT/unvof?=
 =?us-ascii?Q?cuj7md/RPPWxKmLZ9g6a32//npaqgxP+vc33bHfPPMwFMQk7OMLgg5BrF8Ln?=
 =?us-ascii?Q?GGgHluBl+lwFRAHDSv8dudxLb3x4HBXbAff6tdZsC0qEVHnhHECpPUdqzWtS?=
 =?us-ascii?Q?O7X2XOzCgmmQrTjTWHvzLnnwXESp6m3q+bKFnKP0VmgfWQnnIJVQz8mcYThb?=
 =?us-ascii?Q?gXcPS6WBs0sU9fDLuGfloFrYf6QcV5f8AXmCvssGNkxvR7nitne4oyflgFBp?=
 =?us-ascii?Q?4lAoXLFfSiMlv5XlFb4Uv1qUGd/G3FTFdaPG6IRUiBF4L7lfVQiB+o7iHJVo?=
 =?us-ascii?Q?lFWSr+jXEDzZryV80eAJm0cL42y4WUqTLLDZ+EDjA8SSwX/kEBPW2SoCEcfn?=
 =?us-ascii?Q?n/fPChDNnz3YBT7rMmEPVsjh9+8MNHv3QbdRYG36dG36xBNhj53OVtpb2Flx?=
 =?us-ascii?Q?QfbVlGS1cMgpnXZ7uBSjxNiiN/XFlc3tQbBkAZkQCrQF4P3ibrj3WZpKcyZs?=
 =?us-ascii?Q?AdWj2wopUZtFHrzoRw9ccuQ4Sz6WAU/+w9emZEfZs6jGd3IWNeCs/HghZmMP?=
 =?us-ascii?Q?zWxCPj6LNX0XpoR9+5z1emU8qwZqWqUMqURTop/aRGrFFkgbVDP0db5zDbWb?=
 =?us-ascii?Q?HNs+cUJr3x6nfMvfECZOiuVDZYO3moaVESYKOppCExRyu3vL010IyXDYwosN?=
 =?us-ascii?Q?UEbAtzQXH3XpN9piRZ95O08iYs+fjSYwryWEOIz5ENHVig3havF9zzJjzQBO?=
 =?us-ascii?Q?+D/YgtW7THYBiiEuWi66uE8HMlgSyqm+7wdfrD/HsRBKbm+erx/fHQ0mXvES?=
 =?us-ascii?Q?zhWhi6zB++MUComwMH7O+ITISE9mJ4SY6ttlkRuP7kaUiycAeYdNHuEdqhQB?=
 =?us-ascii?Q?aCQtyzvpsszonILhZtn+QyhOZL/i1oXQ/eUWAHCz1E3k2QgaTImtEwCdKBAI?=
 =?us-ascii?Q?593mZ3hlxaWxMArLuCaWcUogB/UJf7FiC3w3c7XFuQduPlMcmU0ZY3jMAbun?=
 =?us-ascii?Q?54m6OgQ/UXmtfvlUkwTLcq5q/x73k0k2M8U8mCa8leMF1nO92XuwIeUZuuKJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: RSs2OqcC3KGMbULTazDuK1EQY0hIw8KDtyqGRPnl8NHQYxrJvFY0Fd6B17wE33hJ9ZMsy1ETICXeFPMkglwu/cUEtSriOGiFIZXovi7InZqt5HpQ8kQHH52jL7y92aGiqgOLVuZCOIOvDjCU36wqYFIFjJ4C7VCgIEWiSJJoCYHbEJTnxfV63ZUKs2VDiXuzzzdiE5L2n7BarTB2y0DP04E4kWYE6GVdsC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff94d49e-6cdd-473a-58fc-08dba2743170
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:26:53.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fml5qagwojsDYEm85HQ+1EC2P0DxwlqWwwBc5Jm0H9RznAIRgg0ozNGjN1amXOvxpeRTqjH+4PNfIKk2HLiOn9iWYME0dCtcXF5+bxHkJq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_07,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210172
X-Proofpoint-ORIG-GUID: B2fZGG3Trb_tcXvM3xlVTQP3Ffh2cyYA
X-Proofpoint-GUID: B2fZGG3Trb_tcXvM3xlVTQP3Ffh2cyYA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain config scenarios, an unused-function build error occurs
relating to prepare_elf_headers(). Correct the ifdef guarding these
functions to eliminate the build error.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 86d2ca80b9b2..587c7743fd21 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,7 +158,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
-- 
2.31.1

