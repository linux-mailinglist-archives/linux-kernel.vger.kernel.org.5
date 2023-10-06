Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208297BB079
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjJFDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjJFDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D74D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962NikZ027817;
        Fri, 6 Oct 2023 03:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=x+PUOq+oletQu3/ZNtEomgJpvs6MncZM8flj0pLsxs4=;
 b=z+LNyortT5Vsjyqti+Sqbvo/8AnfV4e/iGi7vqyfTX7XN/C+YXSnk//de282gkYKj0Dx
 FH6vB9cBuOFHgPZaClLnKB/gu7UkM+h9oWvDLp23l+QsucNymu2jdMJDscCZFMWA9CoZ
 RREJnsSRjVMDmIRk/sP6QkRYl38k/8rCDYDG8u0fgm9O+LCXtjQW2TA0W8vmORMrK177
 srVMmTtNyEaVVcylSsO/0KyOjdDq35hrpIucWXfInd1bEK5ENq+abPpaIzzepXp8LtgD
 iqF20Zw9R8cVTHBf6k/37XV4aW8sesfXc+OriY8U+/gveiQ9Q3jarcvNJHogXTQBGlsQ 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ejyav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960oAAH002983;
        Fri, 6 Oct 2023 03:20:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ypv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq+li12vyGovG5vuLGaf+Y05pldHB29LMR9RVYLvn7dfeNeCn9ZERPdpbK53mbUeYiHgtL4UlWEQoVZkzYjyzwRfAighkHK3QTr1DAf4Yw1fMU3c+oy3qeXmV3NboeoOmhLeYvcCiW65NhFUs2d+iQftWD15uo91K1CD3CCFsZUjea9HMddo7O5G22VufKvCEpfizocgscMpEh8ymmr0Plx6pvEHLV5dMYMRgR4Jl3BlDdJTF0ArZkawA7znwcfRHka6peeWIm0kJAkB5E35UP2MvHntH1JVVITtx4ddfEnpymHmUqIYZwUDsq817fvlq1oAmxdT8y+Ec/AQ6DvSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+PUOq+oletQu3/ZNtEomgJpvs6MncZM8flj0pLsxs4=;
 b=Ooh2EAVkJqDjUlD8WWOUmKsdjF0Bq59BDGWide4Jb4Ac9oJxdU1P4zQIPkGSPKby0SkIMO8c03Xj9K8h+WW7ua1VJQxqzd5osaZgMusoNqOwT2zwdKIBeR04eI1MQRB8cNLRH7z8Mi5+P/XcZlNCv7lOBzvFEusSaexfFkcKyOtakRizDUI7HkfXMcE8uJy0fSTKNI0C7aPP7iVGVS+/1iw3mTLCTunelNQ+RB4AAcBD6JT6rdPSCoPF+xsI9QUXL7CJlULGVR5oiuwUy+K7ZdPJZMcKpyF6wktYGPmvmW6E4dlSRsH4DZNASyoPt9wylZlff8hXGEor3jvBQlukqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+PUOq+oletQu3/ZNtEomgJpvs6MncZM8flj0pLsxs4=;
 b=KV2cBI43WNNBVcO7PYngeH4b2RP/7AGsYz17LMeF46JmgyJTs6IQLz5qUleez0rEJwe+hNq8Nc+GIA/nhbLGWTwKehHrTtgkFvG8Q+S754pdx6RPvq+v7CdzRo6EQRol2JBQz7BqZB/eEu83AnSjtEd/j/musNct6nwlnyublmg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:32 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v7 4/8] hugetlb: perform vmemmap restoration on a list of pages
Date:   Thu,  5 Oct 2023 20:20:06 -0700
Message-ID: <20231006032012.296473-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 7572bb18-5e93-46e8-c077-08dbc61b32d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceRUW4T+bwz0tbI7XfIqZ+LrFjpUovO1slddtjc11+TaTNqoadqhZR+ljegEFX5CkCVovA5ybp5lItZmpf1tFH94sv2zgl2op4JvazroVQSeOY/ykz4Bil8EfNiuT8nFcmlfWXqBRwpMuY31mdtu3P0AcLrSVNf12eCfdXO2MUUcQRtCENwF35NBnJqic9iPz/Ynz4otXbj1K3mSx5xhFWrXbblDxttGuuzWzbg8kiGC9tjBonk09Y0FJUKODYUtwHiuS+59WcyjUMGRSuolOsYka2yBgpTcaFz+vyTCTuNZlRUJFimjE+exI2sXZSB92lW10vfJFmBRpSFgh6HPejOWCxfn1fV8sFdwlpYmDFtNy174Qm9FW8ERfR7lRvI7GrRypPP4jK/Rhhgilsy83Cj7A6/iYBQRcx/Z9YDtGQRf8ye+J1ayZhkbBlQPg2UmokkKWS4vd9A4iq7ksXdOOIa8rzHA9lyRhIo+dG/SUeQzUszXg27pkyrE+Hkc5fC8c3y4BeVXls1wdL+i6qYxwNafLNKIWHc3S66nJu/EI/SWZYTt5SiUQQGrh301/hiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(1076003)(2616005)(86362001)(6512007)(107886003)(6506007)(26005)(6666004)(36756003)(6486002)(478600001)(38100700002)(83380400001)(44832011)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?giXkcGpXxL6oo5pUcwaoyCHKuB2qJxh3yo9T9fUgWkyREb3xRJ41arJzYp/I?=
 =?us-ascii?Q?ApWhc2I/g+gDEdsbODlvdwpICVZllWeFpZaBpNwxLpMR+DKpyvMiILtHb0Zd?=
 =?us-ascii?Q?nl+G1p2bgRNjQr5WfcC6ObvBHadXjP0U16SjorbTvr1E0/8tIP0Nvm0rM+Zk?=
 =?us-ascii?Q?DvN7nLoQ+XCHd3Rs1vvTUns16NAppYcoKBuT6nfvWvvKEGzKahxNb+b8Wgo5?=
 =?us-ascii?Q?C0vjlKvNNs/CFimCHxtsaMZiOM45fc70MtYMLMzzNiP8hfoJXsOUdFoE9IpQ?=
 =?us-ascii?Q?3qUVI2KG3HEBe0k4BN4JLaLyZwfS3OmHH791wVPJ6OLn5YHu+UztDmsbjD12?=
 =?us-ascii?Q?Qk6E5ZBiTdYHpvio0+pxX1F3WWhEpwUCOJBI3k0VQW2BZOFu8FMWHKxqpvc0?=
 =?us-ascii?Q?rwZnwenGQXCQipNXnUJvfZs9tvYAItTEGFqdhfwBe184duC83YYD5bXqqMbv?=
 =?us-ascii?Q?bbY40WjXllaZli/PtPhkchnA8GdGORoFAMpRg+9nKpSaBofp4S26KER75NVc?=
 =?us-ascii?Q?ip8yBl6N2zZVesxf9NEgdFcgmtwfA4KiknEwKlliLy94qVivOZG/kmv1bewo?=
 =?us-ascii?Q?HMEJhPCjJRFvAXLTtYtT1ZiyseIEgFZwCoO7ebOw7ksR2TS+X0lD7V1t7qg9?=
 =?us-ascii?Q?XCP77XMmAGCJT1mgrfSnvqGWv8jAz3F9euSu9CNWt/ZBuv5HXJ2C+MtXjm3c?=
 =?us-ascii?Q?NU3tx8n3BxxQh3/tMYok8pdr8H/806cfh0wiFtUl0gcDJNILj9LKNYF+MMiL?=
 =?us-ascii?Q?lmTI9CpkoBhTFKfBO3Q+FV4iOKvldBJo7sdaaHqWelYA0+nkyG4VQj95oVVK?=
 =?us-ascii?Q?wCm5xOGtqxqOMlE+EMyzNc4gk4cJkOPmu1KqPKcpvuUjZGk+2MVYWqcbzeyI?=
 =?us-ascii?Q?wnaB4nVLvGeuARnjD4dUg2hwloVaLiSvWlTHvdfEPxftE03iQJL5KjF2GXwe?=
 =?us-ascii?Q?nZLStorWfZv/XrCtIJUy349PMYP2is3r26qbJf2j/2Q6cms5ENa+zwQiGOU/?=
 =?us-ascii?Q?rF31q7btp6UePbtS22z+IFFHHGtDZTJ+pofuRkBQdHlR+0VuCFK4CI/OqK/5?=
 =?us-ascii?Q?T0QKSNNdb1EfJNmDOD/o9sDJg9P1+VOooKTgZ4kbMQLUugMix79B3g4A74h1?=
 =?us-ascii?Q?bbAeTRzWegd6+j5HgBfG1GiO8kPE9BVxlxCV7V5DffB3zG9HzzLDZpoVt55K?=
 =?us-ascii?Q?dtIqNDubdS0HUfDg22afT5qNfg7egUBaJa1UYs7a4o65LsFt4+Opy0FtVGzC?=
 =?us-ascii?Q?iPAFNGAO05gCD9cXGQG+vYlWa8IOjIOGBIcgQvSFQQHFoxAtFKHCX4O7CeUJ?=
 =?us-ascii?Q?YCCvnrYxrED0q4bsKpMBGD3EZF8+Pje4MpB/ETq2siZnYaXXqJVhpDIbYpGz?=
 =?us-ascii?Q?ss1G9P+FM5ueKzr0ZqxQgSfWP8x8z2u65cKrya2Vr5eRumie4RUwB9wWb7Sg?=
 =?us-ascii?Q?ETdhyccPAnoxuWlFHWcvlqcCJe0WC9EfGPOriovOaVts4kpbDlm9nbZBrRU0?=
 =?us-ascii?Q?pg29grlXFaz+i/NTWI0DpLwbooHPu6qliFiDbmd+TDH2w715VtnGV+7gqUCd?=
 =?us-ascii?Q?e/hcEDSdvzxgiVdjkdCOykcqDmFHsQemN4m/Gm0b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d+n2S5K5Xu5DsI1jzCMLFG8ZAliW0bEiQLOQuzTJhPQLRgo5wlPGeZ41CO0z?=
 =?us-ascii?Q?ctFYofkb1AtdJ2nsfs+29Ua5Dob/J9/qBFK1qs/d3E+/OYw3MMr2M/v6sBoN?=
 =?us-ascii?Q?ZY1WWgJ/Ke57W8os376o3m1NdRNA11SmJWDpQDx03f1vxIt1+D9CO4yTx/ub?=
 =?us-ascii?Q?LwcTAuDDq8sIEXhPiAb6G/RW1f/TMyphGQi40Iqm3QAZiXnNP6B/k5qYgRsX?=
 =?us-ascii?Q?P4Ti8gVXXjRiNuaaMVIFO+HDAH1Zin6Ztd0+1KpdGAhPMKMzsIrccoojD/Da?=
 =?us-ascii?Q?1scS020NmMY/3F1MQqI1IVOyGNEmaUGgyx7i2fXYUQpOMqdJegsh2L5NDGhw?=
 =?us-ascii?Q?ISH9kPV8vdsZP/ec/gPJ6Fa7F79R0JxLpGJvR6/tS3FCA+RhF83YULwIFI2n?=
 =?us-ascii?Q?36dGrjmIG0jDV9wdM7znGt6l1ZUmGrDMl0pB/1SqBGPtAjbf8kVZWgsB0lwc?=
 =?us-ascii?Q?AUaRUHzpIE9r3To5NuvOOdoYbuae3Ghr2vL0rUYoUb8DlAB3PU/0gCZaFLQd?=
 =?us-ascii?Q?042+vasNue0eg/W902nIxgzXdL/TUx7gw4Z1rUnvcozgVcI7HmuwU61fIr0+?=
 =?us-ascii?Q?MXXRtE2UnBj3OmvVz0K6b+OmGS3cTaObEYopmDMYLC1LNUbGTl80NFDk+Ddi?=
 =?us-ascii?Q?H8K6viTRmUZmaJ1UBP5VMTPwgyoNSMuZIdCqcMjT8XzdXwfPtAUWuYm8WLrO?=
 =?us-ascii?Q?O1jeo4OcuLPFeuyTAa4xEFK23sRo1tfxFHmm0l5BLIx2o25Brzbm5/QowQNK?=
 =?us-ascii?Q?kMyYTcTdINVDeAdtd9UrFttGNmBSPUta54ayCKAzKYdrjW9vszaJatUHnCna?=
 =?us-ascii?Q?G6HwcsiLXpV5a/nFzbnuKnsqenSTt99+NhQZHW6wMk7j9YiDXggIZYJ7gi+O?=
 =?us-ascii?Q?Q5BscBY2ii5TUgvN2JKN+aJku2v9FujWdI+lHOHCdg/sZs5O+KCg7y5GCmay?=
 =?us-ascii?Q?1QLn2u/cFQgfgh2lX8/S/hnvnHY7u0PvX8Q57XebMs60ObV4nypunxXHtaYn?=
 =?us-ascii?Q?sTtCKq/IfUCcwmnUrPEqTPNe5yZSHdz5ff4c0awRxtetHVWH2SQDlm8HCV7G?=
 =?us-ascii?Q?Mqn/F1DHk+i0QE5Rjfef8Ph5PUkRahtJESN6+HwX5QwXQRgjyS1IPIl/7j+S?=
 =?us-ascii?Q?iZ0rYII+yRPmbMHGjXPmWPhjkRb5D7VmIw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572bb18-5e93-46e8-c077-08dbc61b32d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:32.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYfzFeJB0FlB0j2sC7qjreOfy7RF7hlwlUgasZOYLryp/DaBFV7xEqFUQkuBs9ucwkDh+X+IvFXqh1EF8e53Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-ORIG-GUID: VwFMwQSqVAyeeRen7QJyrmNdGfttsAxt
X-Proofpoint-GUID: VwFMwQSqVAyeeRen7QJyrmNdGfttsAxt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering an error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_error
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 99 +++++++++++++++++++++++++++++++-------------
 mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 +++++
 3 files changed, 120 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2df9435afa48..2c491effba39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1827,50 +1827,93 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_error(struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (!list_empty(non_hvo_folios)) {
+		/*
+		 * Free any restored hugetlb pages so that restore of the
+		 * entire list can be retried.
+		 * The idea is that in the common case of ENOMEM errors freeing
+		 * hugetlb pages with vmemmap we will free up memory so that we
+		 * can allocate vmemmap for more hugetlb pages.
+		 */
+		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
+			list_del(&folio->lru);
+			spin_lock_irq(&hugetlb_lock);
+			__clear_hugetlb_destructor(h, folio);
+			spin_unlock_irq(&hugetlb_lock);
+			update_and_free_hugetlb_folio(h, folio, false);
+			cond_resched();
+		}
+	} else {
+		/*
+		 * In the case where there are no folios which can be
+		 * immediately freed, we loop through the list trying to restore
+		 * vmemmap individually in the hope that someone elsewhere may
+		 * have done something to cause success (such as freeing some
+		 * memory).  If unable to restore a hugetlb page, the hugetlb
+		 * page is made a surplus page and removed from the list.
+		 * If are able to restore vmemmap and free one hugetlb page, we
+		 * quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h,
+						struct list_head *folio_list)
+{
+	long ret;
+	struct folio *folio, *t_folio;
+	LIST_HEAD(non_hvo_folios);
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
-	 * lock/unlock for each individual folio.
-	 * The assumption is vmemmap allocation was performed on all or none
-	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle errors and free up any available hugetlb pages
+	 * in an effort to make forward progress.
 	 */
-	if (clear_dtor) {
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
+	if (ret < 0) {
+		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
+		goto retry;
+	}
+
+	/*
+	 * At this point, list should be empty, ret should be >= 0 and there
+	 * should only be pages on the non_hvo_folios list.
+	 * Do note that the non_hvo_folios list could be empty.
+	 * Without HVO enabled, ret will be 0 and there is no need to call
+	 * __clear_hugetlb_destructor as this was done previously.
+	 */
+	VM_WARN_ON(!list_empty(folio_list));
+	VM_WARN_ON(ret < 0);
+	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
-		list_for_each_entry(folio, list, lru)
+		list_for_each_entry(folio, &non_hvo_folios, lru)
 			__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Free folios back to low level allocators.  vmemmap and destructors
-	 * were taken care of above, so update_and_free_hugetlb_folio will
-	 * not need to take hugetlb lock.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
+	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..77f44b81ff01 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,44 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:			hstate.
+ * @folio_list:		list of folios.
+ * @non_hvo_folios:	Output list of folios for which vmemmap exists.
+ *
+ * Return: number of folios for which vmemmap was restored, or an error code
+ *		if an error was encountered restoring vmemmap for a folio.
+ *		Folios that have vmemmap are moved to the non_hvo_folios
+ *		list.  Processing of entries stops when the first error is
+ *		encountered. The folio that experienced the error and all
+ *		non-processed folios will remain on folio_list.
+ */
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	struct folio *folio, *t_folio;
+	long restored = 0;
+	long ret = 0;
+
+	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				break;
+			restored++;
+		}
+
+		/* Add non-optimized folios to output list */
+		list_move(&folio->lru, non_hvo_folios);
+	}
+
+	if (!ret)
+		ret = restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..a0dcf49f46ba 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,9 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +48,14 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	list_splice_init(folio_list, non_hvo_folios);
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

