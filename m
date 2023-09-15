Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79A47A2A57
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbjIOWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjIOWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A031291
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLwluU027810;
        Fri, 15 Sep 2023 22:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Z0pbkesaKqvYJeLsJht1bKFE7pKSDUHfig44BRUqGi8=;
 b=FWQpehyUwthwsc5kxVZDdu8WUc702caUPjl2rJHESCbDlSWfXujXqEgTm9S6E9kGalqv
 bBM3qUvyJU01jb2O8UzL/eISJqOtG582f1aismjC+RdusIFpgkdjC4S8BWO5eqy47X3L
 4eirCjE1Iqo/Do1pX6mADoEi1TvQGNGp/czK5sQLakPjwvwuTb/EwlFOeIi4V5axN6FS
 asNqNOwxt5LwBj4FKw+1S2Oi1J6XUVpBqMrar6NyoWLGc0A9vN+rFnWbViSZGCh9sU6t
 O5tv1C5Iwcd6lYiEWDmkoECR37JZPPwFA3zXnPb9AJ/xRyhz5Ld4CBXz5GepwY6BgaTV Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kgsrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FL2HxB003116;
        Fri, 15 Sep 2023 22:16:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5anfkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYrwTpIytPZK7iR9/l42nR0ceMsb5fiAJ8rjwvCEdWYP/dj0RgZnbNs0FS5HOKXzhY4cTZyo+KrFFjfQh8rNx+BAraO03zfx4u+ld/o9zN8wJmL7aYerB7UqUzmrdGFsmb0LuVffV471Io7OVQziPxFS4sZWWJy7pJeUTmcVFsTJQ12LTEQu462tvwss5UJOAWgzT7f/wFPoQie6y6gcFK0yjlZdUBzfRuJHeKfZQ4iowGNuNBAtAkDifK4dmmJHplLM0Al/A//qtCvfLvfeBlAFNxfn0/5A9bMV5Tvlmf19k+tBi9yLxEkGGYVEbIMJBoJvHrRftCOKO96V4FjSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0pbkesaKqvYJeLsJht1bKFE7pKSDUHfig44BRUqGi8=;
 b=ofsCfJGDoXPt3etQFhlenECJjwrwkWC5gwVvDZ7vOQsqFG1ihmGVPTQQwOV1zsrQ5O+cpcd5Qoek/jnBse1es6/wpRI1f7Shi/O3ukgcCeI8aPx78XKDiO5BmTJlNbXOv3/9SdhGJWh3iVQUledgW3akslWPUD8caJ/sqpsIrcloJXXkZ6gdeZBHkqQeFRhIEt8QXSI+euta/yD6NOXFL2loAScTm9foY+NkU+UCTtn/KeK5X3vUNa//6ZjASAChMeMPIgub5CTDQ+FIzjsHPZDpYMC4rXA/RnwS1kIn/FsHFJsQxEPQfB8QISHBYXwPdbXAgonbDYp8WcESzbRdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0pbkesaKqvYJeLsJht1bKFE7pKSDUHfig44BRUqGi8=;
 b=NGVJn2IDT4zc1hPa98+kVgBndMIbmhGPDxL0SsekkGC/4ITE9Fkm4ymnyx63cbmHRAJYih7HpcEscjKabr3z8hzsKr8CNPV6xn7zsTYJGNp1b3xnL8eBnlgznNcDsZWH3BSkld7gDBRTuMiBpYlJ9KaoPCf+pXbT2HSjPH5000c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:15:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:15:58 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 02/12] hugetlb: Use a folio in free_hpage_workfn()
Date:   Fri, 15 Sep 2023 15:15:35 -0700
Message-ID: <20230915221548.552084-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: ae097464-1a2d-4a22-db14-08dbb639565c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTSdzMljbPRDqINwlsRZmDdjF2FeTHyVCcokk23ZKa6vvZJj052eY+eQfeYYFqjp3OHhB73tVjjcik2cE5lo2fRWIh5V9MftidxX+8/KCp4kZ2qY0GmhiBKj6rpGNgOM4Cx4M8vJFVphIY4sDyZ0vCfnKDMLfmq/IUzLua1SbBTLMatDzzPPfzfIU2TWa9Aew1ihZv9ioJLPMf/dyGhy9vUnXelvJVNakvGJAM091QpEj46V9KQFPsEMi48UiHqHngX3cZWh5simqcp2XlkVpgUBGfHwBf2ks286X4rfrRjtEKqZ/VqEG9ekzX5wm1/oHvc99fM9zCZNlaQenpPMsmYGn3Hiplcp4O7FRbfRcuyjQ/mAqm5od60DG/nPbKrYRO5P8WeQd/RjEyGCQpLTZU+OMyVU2a4rapjWydyvXp/MmlFc/IbdsqT3BkRZ9bt1A5XUCYh/QdCV1lNWKZkV/HzzzBpUePCyihX8RguR5m9VRuHhEbLXu0M55YYzuE2VuPCamjo5+W7INIL4ndaVg1CBqHlLW4A/C03MqNDh/Lj5fd/4g/veeScM/BUYqlLS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNphD1lWJG9deYnTq4QDT27cUjkEgBRolEgjy8OYmNH/+Xch6i7oROZwJDs2?=
 =?us-ascii?Q?n9Txggqu8UuCw0BQ+pBqditJIXPkcZao8nf30Get9iOmit2MSp2bAx5BAg9Y?=
 =?us-ascii?Q?pI8jY5Yw9nLxQBJYxCC+7UaTwgEjbHC0vEBbQxhzHMByXCtT/ewUsKr1dTPK?=
 =?us-ascii?Q?8J3jeKkis8b0NxT3FXFqV3qkXlLyirTRzG2u7GEsH/35C8K4xXnOdi71sak1?=
 =?us-ascii?Q?erN+QeT2h1czeh2wI4Vb16Rx2Grfl76Cqz7GWrxLJUjbECVX1PrtD6ObDrQE?=
 =?us-ascii?Q?dn7VbL0xT3xzV8CuHfSs6OiSsTPhCIELA+8TeJzpJcizFmXi0zr4gQn9Haoy?=
 =?us-ascii?Q?ZwbaF+l29WwJ9BWZ3Z+CtcGbqB9gDgVSFUilPe8LGmIJX7wMdS0w8K2+Kscc?=
 =?us-ascii?Q?Z5X/sAQ15yvBAL5h3lhvIFsf8OB6u6G7ZED4wpz0xmQhX3Oc6iKJUI3jP1UL?=
 =?us-ascii?Q?A2vODkPRBY9hymmehoNwYKowtJk+VFtlNH0r2T6fyGBdpn9Laft9DYKnJnC0?=
 =?us-ascii?Q?6pg7G2Hg8g7/DZMMnhxBB3EdrsHqq4d0M8hkntkKgJuQxC/2wcMw0T6tJdlC?=
 =?us-ascii?Q?zubXvNkWM1OAlDbQ7Ceqo1u2+bYddMXW9KBcuOiC2M6na8UiQMkbz4QeOhmn?=
 =?us-ascii?Q?uVKo4JNltFxqr+nDv7uuQnGo8puqyL65iCRYTZJoGuxvMafNT4equCXFP1PX?=
 =?us-ascii?Q?9rqSBJf/Col9k0K+QB0mtWdKJF2V9jn1m3Efe7HxbR1Gi5EphLacvITln6Bt?=
 =?us-ascii?Q?iEVjvjRvEH8lGcfTAxaAlZIK0xQLqTi4njlik+iY8l8T3rKTNoysgCl9Y2Xy?=
 =?us-ascii?Q?2zlPE4KdPZULIQZPA5fzUUtR1mEp443HCuRbCdvkk3y7ti97TsT1+3mVplLB?=
 =?us-ascii?Q?HSr7rfGuzvMhYSDWfIYTLt+Az0q2OfcLjuhFwn9Adk6+vE6xzLKgjOjf8oI7?=
 =?us-ascii?Q?TAkHTdu+q1NBkDzfzbTlu8Ku3eGd5dkxVpLCtmnkM1m5dRUkWVljAmGiBUo1?=
 =?us-ascii?Q?D332lQc3b+etAgFulVID1uY8PmqtpgY+cMkwcmhFPEumLWOJBpYIofOOWWEX?=
 =?us-ascii?Q?YJKsqcbAZQ/bsLLt+W+apab3IS6P7CMzdAOaIx8nxgYofhQLsHDOjuVGCROF?=
 =?us-ascii?Q?cD2UCxZd9iIKtgzf6jHkZar42IM4J/SSHQkA2vL8cmhg7TtRFfl4/dqYoN8j?=
 =?us-ascii?Q?ozmM0LC1LPWF6wf/asRXST9Zl6puiSHz3PaPpL0eVZBQ1shFOxrIBWzMx8w2?=
 =?us-ascii?Q?MWJTC985hHoxlODOTKE5wAgX5BMO7ky6duR5/RTzutFdhafSmxXQuRcOC0iz?=
 =?us-ascii?Q?F7xgYu3Ee97EYby5lTkbM0qBER8rfuah7BOXLrNURo9mhc5nwCcA2Ujy+px3?=
 =?us-ascii?Q?MrWOmMNtXpF7ybtfp6NEegQM9G1RzL0y2MxvB/nPYki+Zl41pGG22rL5skKS?=
 =?us-ascii?Q?I1GxPIqpuEGgcexVvHuqLrO+MrtRKd014N23MPZLeVAkcVdhAK+4rEuTs5L8?=
 =?us-ascii?Q?vSu1R/dOvMLt+Nms1dOfrmeOtGFYuOR9Yfpd5lWw8lUROazz8ULTxFLaB6/g?=
 =?us-ascii?Q?b8FTkZJTECIkOwnH0fg/Qu1atNuIxK2xJNOxBlfn0X88m+4FhEJZiLMCYSYl?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?z/IVJvVLVFN17xcfbIAzkB1617YCkhPMMRu93FJDaz4Sbdr9JRdrt0a+/pvT?=
 =?us-ascii?Q?KGtnqw5kvQIocBH/qxFN58SJgTa2Ot3C6ry8x/uaFCkuTZ/P1ZMAD7NxRAms?=
 =?us-ascii?Q?xoB+3uY2KzuUFa7sFoYr04rMmGC1HhFnf0i7NhjjbTJBejo/4I73IvTkXMe8?=
 =?us-ascii?Q?WZz+UMgE+JjyRSgLty1uxBQ0/wmz95+NFBP9JTyxWEBgGTkxhgdqFTfq1gqN?=
 =?us-ascii?Q?yHSUvsSnslUI3qBxkA/LTZ7mXqpHMHBeHDL1tm34HCX5Lr7wgifH2GX83r5U?=
 =?us-ascii?Q?vizqV2cu8Tmohrs3TA3WuP5jJyqL/pzZzsayyTpYKd+kP0Ygl3d0/kwjjGHv?=
 =?us-ascii?Q?HR4MEpUGYjpy93RjrSF8WbHM7/JNjeZuO9+YDBJfULWXz50mWv++ee+XCZ7c?=
 =?us-ascii?Q?CEoGoNvLHNDOm63niF845QZ/rL2q1Da2qV/zxYvnGZR9UCA75kdBJjL8VvAm?=
 =?us-ascii?Q?FnY/FklUI6jctzJNu2nbQEkPyAxpQmDfHMDDlpEH2lE8GRj2p+KAWYB+6zQV?=
 =?us-ascii?Q?RJn5Qu06t0VOUEhD2ZdzXDzGa+t+RiJvcDhc+G6D6Cgli3CiJi7GEUxhcjLV?=
 =?us-ascii?Q?bFL9CmjPivYWfQm9W7IsSppKxlyuNszmx3xppnIOSJfOTfIqa/la7yzg3ADz?=
 =?us-ascii?Q?fsVaVyAdxP4i8H1Exl2KgAyB/0XgXM4M2UvJq9SZXrDsjaJ3T3L8SusfuT0a?=
 =?us-ascii?Q?tC+wk5j47xuoXRGJYgHZa3mGF3nosEvYLmdPoJWpWPoOECcZi4lucFKWkDeo?=
 =?us-ascii?Q?PGHWRla/xObVkAKxFGeQRIZCKqRRhhqhky/edwLfk4BlYL/cNsuwlh3pZbmt?=
 =?us-ascii?Q?0EV8yX/tWUdrMi5VP5aJuyzUQSXtBDlSenD337MS1uoJMSJ+hVItqs1xyaiO?=
 =?us-ascii?Q?cDfnIXI01ZmeU8dzn+N3fMJIKvGLL1MRsQlftRuTdwmYufyX+013c/jE4ggq?=
 =?us-ascii?Q?eCqJf4TqAM2TOTOZ3k9nq+KnEc3xqTYbtNR9E8wipXsOAqNgKTtx37hYWM/R?=
 =?us-ascii?Q?hIrfnCwrMgTCN9ELs4SOHlyy5L3UYjsIQ9F0vY0+UOK/+qmCUnGXeyj9l6TL?=
 =?us-ascii?Q?sY6NCNMnYE9I/L/sovm6ceK5uYiEyHOvkdJ8rKuqmP9GuW8nNNHUVKy2wUgZ?=
 =?us-ascii?Q?ohYzMokCbEJA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae097464-1a2d-4a22-db14-08dbb639565c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:15:58.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PISC3D/BETXJx215CPZKZ6fipM5XzhFx27p3AOkyw5pNJjcVbv/IqAjOBy2TIGq0trOxcjELuR/6PkrDjZ/4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150200
X-Proofpoint-GUID: hzSeL9k9eZgHxR8RKFNmecbR62ozPBZz
X-Proofpoint-ORIG-GUID: hzSeL9k9eZgHxR8RKFNmecbR62ozPBZz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

update_and_free_hugetlb_folio puts the memory on hpage_freelist as a folio
so we can take it off the list as a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index af74e83d92aa..6c6f19cc6046 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1780,22 +1780,22 @@ static void free_hpage_workfn(struct work_struct *work)
 	node = llist_del_all(&hpage_freelist);
 
 	while (node) {
-		struct page *page;
+		struct folio *folio;
 		struct hstate *h;
 
-		page = container_of((struct address_space **)node,
-				     struct page, mapping);
+		folio = container_of((struct address_space **)node,
+				     struct folio, mapping);
 		node = node->next;
-		page->mapping = NULL;
+		folio->mapping = NULL;
 		/*
 		 * The VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio) in
 		 * folio_hstate() is going to trigger because a previous call to
 		 * remove_hugetlb_folio() will clear the hugetlb bit, so do
 		 * not use folio_hstate() directly.
 		 */
-		h = size_to_hstate(page_size(page));
+		h = size_to_hstate(folio_size(folio));
 
-		__update_and_free_hugetlb_folio(h, page_folio(page));
+		__update_and_free_hugetlb_folio(h, folio);
 
 		cond_resched();
 	}
-- 
2.41.0

