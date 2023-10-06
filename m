Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F527BB07C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJFDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJFDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B5ED
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962O544027984;
        Fri, 6 Oct 2023 03:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=OEk0D+/STrWX9EUMhMW2zvjYPmAQg8LOFsTTTh596Nb3LrprpEkveGX5uoIGk3ScorIc
 na+r+H19hlZUVzZx4SV7miFEZhi3S9zzkTp7QrWnk3py2Zm19Ds/ayU6enMSrcwTkFKH
 lkpySEktYiA/JST5f5v4lypSMs1cjUL8fV3dcsxshdCUYSJ+kLchk3dU98QGDhxTA74R
 Ny/dmrv2q3fjXNCNp62SNSdKLYn+7EYAKMUYBWDXArrJhGl5+P9CH52zySYw0PWLWz7m
 y9hpnQ1RTmRvJvXx14l3+TJj5qtOR9teXAJjV30XXMOk3Vb8jY8dGTWHm8gd3zmpnf/L zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ejyaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960oAAI002983;
        Fri, 6 Oct 2023 03:20:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ypvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKuQ9KTc9TZOnvgn38k7hiYiB/H7nsXpWldNju2fGtyl079qgXnCUNEk/d7nf/3jgAgZ8EzkHIj56EptInA1uEpdGF3J630WjYyNgZyts5llkzWkXHgmiiGhC9WjHOFhhJFzhPUcppmB0BPg1/JQ44vweeFvpyK8s6W5Jp7o5WNY4q7xpluZFAWOTa0gMfMb0F9XzkmebfygRXbfBoxQ9MJlTMiejs4meHsetmlWkO0Iqv/+OIhCQXwoiCPWxEzBF18q/CcixFULQXBcpQIxLre4bt0iJj4AJtE8q/Aam/yXRgNGQQk4huaRwm3C+p3uKxCIuMR98YBTfYgAAYTIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=OArL9szItFuqafH+CnCfaJgcd1zA1dmfmATuAHDyOTRlbEIAFaeMvJFlJzBc0IeqDBGKYt4cGpWsjdFpJsBbRR1nPDZiweCh5Re0z/CzeRyuZy9vz7AAM/vxpNemSozpZZWcCJGLIK1WHtNSQbJ0cbB95iMW7PdEx8cmm9nIor5ZrBDXNrjtxnIKT39K4vxnplWUnASZQk1AGDl+IluOHepcgkRX6XeWg+clRwnAyRWoBvln81CgQ8EupDO6+iwPVePeWFjDDSgxEOvrUYlAal68chRuWGEFydCJzmUQXdY4VrO+aIRwo0ZXxs/b2vOytDg1Ugt6GosaktWDTks9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=hqdXZDn62+w89Ktzhq/d/oPlNu4Cg0WOYAtVFVksm1eBEPin9KPnuY/w9xIHUL1Jd9GJbJki7BXUwgdTXvFHRRC/gi9N9KfVc4nS8NRve6x2MbLoMDznqWYIcoHkjoE4N2SvS673/l+jD9wLHxAupjCEaXBgzd6XGSmAFUDJGJA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5391.namprd10.prod.outlook.com (2603:10b6:5:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:36 +0000
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
Subject: [PATCH v7 5/8] hugetlb: batch freeing of vmemmap pages
Date:   Thu,  5 Oct 2023 20:20:07 -0700
Message-ID: <20231006032012.296473-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 44630959-3a0a-4db7-c92b-08dbc61b34fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bpA4f6UR5D9j2bqtkunDVibRvmFBe3ABM6pzFIOsahecWryycRDHoC1c3QCDerpxbZmCkor3qUJSxNQzKCaD6WuyfjXIG0CnxkAzT/MriKA5sLGxyqMuTD7om2VEFMAWEpyTw2OUq+GJlXLePPSmc+npy4qJbtMMrsIGHMAATHt0Z7iT6GVwcudOLQKSnHE5kmG2h9XamK8GIZl+jsQ/qb6jOdYdBgaYFHDuz68ut/78eqSstcgu7jhAPHZ7lZNMlc2D94jjPiIbHVOeS28ZbUwKU+ln3gSoSeC2mTg2avyMRcoG23K5O3FKKMV1+wUHhKIlCxMAFrCJPqkUrKUvnyLGkygEKjO+9NnZDMz6Qz+u+yMJmXriCmcsWS7cHAZygNrGNqF1Njm9wXB4J9vYbyF9Kf90G3akPRG0h0S/btWMOrIkanljj8aAqOYfDkZkmHk0o8ObqXm+N38dGi/FlMW7uZhME1wZ8wdSiiJ8tGeRJ09dJGzFYYFlvB9XP+n94+BcuoU//l1FjPCzdi4ZRllu1oZCnQCnMBWMp535gX5TkmmBNXMAqbr/ReNNKoF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6666004)(6512007)(6486002)(478600001)(38100700002)(86362001)(2906002)(7416002)(316002)(41300700001)(2616005)(83380400001)(1076003)(107886003)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(54906003)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiygdZgaRfsSFuT7EBEHjXhyIog5em+8pNMlh5Psfc56nmsAMTjTgKYKASXf?=
 =?us-ascii?Q?XmPlJnzlq1jquiOLCUn8XSZF0ZaoekA1nAuxAPM1+L3T4YQ6ahsI9fnplO6V?=
 =?us-ascii?Q?9CbH4mc7kK67vy1fUn/nLFQJ0UPKPbAE+xcmclLWSpj/Wv55O3jneS58EL34?=
 =?us-ascii?Q?rIDB74MvQ6gpUhRpyhwmGeCRhF+UQMTZBflQO7DfGn/GsBxjVSl0DA9PqYhw?=
 =?us-ascii?Q?VVX1o9CQR2uZ3v+cP7NOjtmpc/zduW4V3QXOfrkrQPpiT48n77gKU8f56qc4?=
 =?us-ascii?Q?jm24GYVk/lOw6Y0+i73UL+gAAzYDHq+Z1NzOyDTInYc4wqOGKzjaO1B3VmRs?=
 =?us-ascii?Q?nAiC4lt2KlnKfdp3zJ/MI0D9qVCqrxksw5ik7HJIR78ORJytnUWQZFqdYwJq?=
 =?us-ascii?Q?MOZAmbezOLv7nEbcHFSSh8f6FVSLMAUKdAm5Z0cyaelCFlo889MQsP5dpdMT?=
 =?us-ascii?Q?wzaJkXHGHpf+wY5lu+CKUJP4SZ/Umg3qWqCgRLobo1gpLI2/TD3nh5VcAspX?=
 =?us-ascii?Q?W0oQgp+wqr1xp0x0U69hqpj0AVgtSwni3vpknJZAMDPqLp3niVlpXAC0DVol?=
 =?us-ascii?Q?dw2wAdgcrKIamIEqzRvxR4OSGgukOSqt38exRt272ZW/XjUiH1zKdWmyrYKM?=
 =?us-ascii?Q?AFkMnoHGLW5R5AooBKliR4ed52Ynf420KxNk+qy0cN2UzeyAMfaj9tGsMqCJ?=
 =?us-ascii?Q?1eDk4syiqd0aKTDxMYORv9wDS/iKVnGO28h7Bq2lfANf8dqAajbW6+MIZEEk?=
 =?us-ascii?Q?lPELe1WQRRXgMANWZ8hlH2CtknTQXNl4IswaIKJd4SgBL8xv4K9a3bihs/vu?=
 =?us-ascii?Q?XEc5CNBtUx0WWiYiB2c+8sVTQNHXhCFCi5X05zJ7afvC5MCBwYWZ8RChSSoi?=
 =?us-ascii?Q?WeDJEfnlpGhz/cXh+pE/IPW9TJO8jWUCZyE9M8+Vqj/8oeLIktO7JV0DDfWM?=
 =?us-ascii?Q?aMeMSSWvWnvTW6rVPn97i9zmbpO3YhH9FEPyZlN1I6bh+cePyUZISC3G9eJm?=
 =?us-ascii?Q?bB9o9mlpX8lhEU77txAGzC0lHc+13oHQzD7BIZsgxSbRZMoHYEglLbAELg4h?=
 =?us-ascii?Q?IIAE12QyJpfXDN1lXnkw+nPr4RDCVGrVTh/6MYUl9IW5e9RLlb7/lOSvyH1X?=
 =?us-ascii?Q?F8nZuxGMeueJkELRmvkupeDifSAPkl6hCCvF9doSzGPcleELZ9UynmuiOyBx?=
 =?us-ascii?Q?+jfmBp2GQDeWuo9BnQFAjLUjd26sIfeTjbUR8yIXGVkwpQBqmVycagYHFnNV?=
 =?us-ascii?Q?6rtgKMrwfhhVcwEq7mLX/XdPJiPH+ufK6b2CxVYspAHoxDdAwkGTAJSgDnLA?=
 =?us-ascii?Q?fZaHjCjYp1o/6MQ0qDM0pCN2xFUNGbl97gIwW5PCSRAxMZCEgZhSuUNe3Njf?=
 =?us-ascii?Q?P8Y8sqAzM9i9esi05fzridf2lMwBidPBvU+MLU/0lmBpvLjYgoSEpJd5TTcB?=
 =?us-ascii?Q?5h8DRhAib09SSvdNtQ+KFgjPS+DZ2fRvze/TrFl/2OPVb7RH2uVPCCR7REcu?=
 =?us-ascii?Q?lbTJQc5tDBdqtc6qOc8EhklGi1lEA+VUVUtuABFZlO4bA8EGLcnF6TEgS7z7?=
 =?us-ascii?Q?GK07uF6D0ibtk/JquiWoBQjFaUgKTPWnIJygNHn+HnGPZlVTT8NsgInMln+m?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Mi/TM4QQOpAH61zW4tLN1/md73USVSUVh6Ds5kuEEBwKBXWbt4Hne62y7pvL?=
 =?us-ascii?Q?uT8BiHwQbAAa4RtTx0PZsv/5eh+huFoBy2iQiDhYqWiMGm3aKa5gzGgIAC92?=
 =?us-ascii?Q?bUhxADHq8uunAv0TCXAF0+kJlOvzEk65e9f5m3mttux81twj62wJ7efY/xTw?=
 =?us-ascii?Q?AFmro7Dd3+OadoTFAehl/yD+/bnub4FpxUA/H9N4V+4Cv4PwCxCN633GiueV?=
 =?us-ascii?Q?TKOMZOV/2z6xz/K7BLoYBLeDBvjdwr06EFasDoKX+Gw+0iPCWWgEHpeszYXI?=
 =?us-ascii?Q?6BKWrIWfLMHuzHxV3fOo7cjEqIePb0tgn7FHt4MrSd3Xymqsg8dOXWk08R+e?=
 =?us-ascii?Q?d84bPQdKe3Mvu2jvzG+dpPpEzfGljYvqzYRvJXnGJgBdzkYP9F4iR5dqWAKQ?=
 =?us-ascii?Q?639HGVAFMguCIcKWwldhrkTL8g1XfsEcLwMWtgHpUTF5/8x8xVExhh7/GJKE?=
 =?us-ascii?Q?C0ZQfB+XirLEeRVx+NUEaHUxko/Ahmpd5G0Kdy9l4tVtybgx1oWq0zbOYAQv?=
 =?us-ascii?Q?FRRq2HQMaIom1LT/aoJUTO8o5yuDW0i/tpfMRW3lSZsBhd1IzBfkPDNSL7BW?=
 =?us-ascii?Q?9t4RJ/B25vRpURv/DNXYLlmEGak4LFEZ7ULk08EmjViOijYdm0vygxFCpjpE?=
 =?us-ascii?Q?dfNsDnHJKDOiw17ZQZoBcOnpxxP83vvqGGXWy0IDTgKWUOo4xqyaeurMUN2u?=
 =?us-ascii?Q?UFcJzkAHnvhaC5CQNM1VkdLxaHPlevu+gnvxzi18ii8cB3qi7MAld42frafx?=
 =?us-ascii?Q?ugYNnQriETrjc1ObV94TjywRVck6wdUR6pWXd6XE71DlzB7sa4eIFiWNm6Bs?=
 =?us-ascii?Q?n7ooiUyJ18p0OoN7TIanuBHhk2cwu7HQc6YVwE/MXEpWxjuPLfFFXNuf4weA?=
 =?us-ascii?Q?Q252mHzA6HRCahyaiCH5DCPJre3iGuuQCvjjLR7qFv9fnB5LqzASyipkgPo2?=
 =?us-ascii?Q?K3SNAuLhVkW9LB4SfIaTUmLIEpwUSkocozuHahYoVNs2HkaFIzbKR54DXzB7?=
 =?us-ascii?Q?vVP0sinDe/LIF6NkXu9S/lIYIqqQxepK8ahTqhp5e66OUHJxxgHY5LcF4FpM?=
 =?us-ascii?Q?h4qjA4lHPl9ovdoSw+FrF9dF/TxnmNR4InNpG1MIEq3X0Y0bB9Ek68F7VjZr?=
 =?us-ascii?Q?qcA2EaM95pmDHWwjeCduQXaYweu75Cquyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44630959-3a0a-4db7-c92b-08dbc61b34fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:35.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl/GEpIwq/Js5ji+zrzq2fDW4R/D49PWwqBVgCwh1W821ZWc9uenMfDtIw9yCv/KWUPfjD4dsZwRH1/z76gpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-ORIG-GUID: t2hYD3M9Pk0TB8r8dPy7YM-f1gXPPTdz
X-Proofpoint-GUID: t2hYD3M9Pk0TB8r8dPy7YM-f1gXPPTdz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that batching of hugetlb vmemmap optimization processing is possible,
batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
hugetlb page, we add them to a list that is freed after the entire batch
has been processed.

This enhances the ability to return contiguous ranges of memory to the
low level allocators.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 82 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 77f44b81ff01..4ac521e596db 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -251,7 +251,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add_tail(&page->lru, walk->vmemmap_pages);
+	list_add(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
@@ -306,18 +306,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
+ *		responsibility to free pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *vmemmap_pages)
 {
 	int ret;
-	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
+		.vmemmap_pages	= vmemmap_pages,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -334,7 +336,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, vmemmap_pages);
 	}
 
 	/*
@@ -365,15 +367,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		walk = (struct vmemmap_remap_walk) {
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
+			.vmemmap_pages	= vmemmap_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
-
 	return ret;
 }
 
@@ -389,7 +389,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
 	}
 
 	return 0;
@@ -577,24 +577,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-/**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
- *
- * This function only tries to optimize @head's vmemmap pages and does not
- * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
- */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *vmemmap_pages)
 {
+	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
-		return;
+		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
@@ -604,21 +597,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
-	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
+	 * mapping the range to vmemmap_pages list so that they can be freed by
+	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
+	if (ret)
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
+
+	return ret;
+}
+
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+{
+	LIST_HEAD(vmemmap_pages);
+
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
+
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+								&vmemmap_pages);
+
+		/*
+		 * Pages to be freed may have been accumulated.  If we
+		 * encounter an ENOMEM,  free what we have and try again.
+		 */
+		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			free_vmemmap_page_list(&vmemmap_pages);
+			INIT_LIST_HEAD(&vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+		}
+	}
 
-	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

