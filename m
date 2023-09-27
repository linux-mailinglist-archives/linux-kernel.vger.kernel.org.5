Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC07B09A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjI0QJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjI0QJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:09:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E4DE;
        Wed, 27 Sep 2023 09:09:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFsmvw006126;
        Wed, 27 Sep 2023 16:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wKLO5aowMtFkN1v6flI3U2j8ilZzZwu3h9RuAvaF98Q=;
 b=BuOaCPE5a0NvoY16Bo3RcThian0yWndqUHHRIjjmzZbZ0mABEi1aQeG82RSXYyxKbBVf
 pFlISRxFXwKEbmxrhyDzWjg13kft7OcOww4wPuNf0RDdw63sHYkZn/Vy/ECJxpy+l1NI
 HRpoA0nIaVysbz1HDgNeox60woiIA26bO4VBZavx7FEtJSN7ugR2lGRLyCYzkP+U34Fl
 wa++FRUXikWobqdK5xirFmHGMDXjCHIN5c3w98uxLk68y2opiUosFS0IgfCKoFaQ2asX
 uE5d2LUL972zJWLPXVtEFL+W2ZR0vbR/TTbzv+j2LsloxxJ56ncU6jDFu9C9NKWUpAEK 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3t017-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFQw3t021222;
        Wed, 27 Sep 2023 16:09:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8fdpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jna6sIBtWOHJlew6LrZorg+N7mxEdRLIGCbab/rwDrTGMIz67FVkR9EoYRJvR4ehGUzyJrMEo1pqQPWvdaobgxcsgm282ZCpKxfFFxgRooMsT/eR7SOpFxhfUNl1XR4gLW6BvQ8Vi7EoSK6OM2P4ybdtHooWw1zziv76dP+87IWLtwfYjIX2yAigz0tlkuTSCtremGNMygewDN42k5289Zd2vyGkpVAUJIEm/nytR4ouz+y+LC/lwwc2jkG0VrokbRo3e7EKj3U/XsRwDCxJZxpv3M9+3oza/JeAsKjyXzx+XnRNKNa68lbFMVtWtwHy+vfcIEhT4bP9X69LYo3Lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKLO5aowMtFkN1v6flI3U2j8ilZzZwu3h9RuAvaF98Q=;
 b=eadwhyJ058Ct8Sgphu9Odr36RILfnadmEBf6fWajnTmObEzjB5icNnMhKqwcpJzxpB5z718+8pZ9Dha+Y+ZbcTBw/zSJlBIa4sLgDCNNZVbFw3zW3xcZf9ZfhfqvOffJg8p9QWq5h/p1tQjAal2AKz3ybNrKjoLFnyeUPGgvLeaj3ZXJpRQ2yZxi/NvfMiCTqKk1gbqgboZiITsUZ8rkhBHOUc4xF3YlsirNSnE/nTamqkpzejIRiPF5Ur4uzbpmoLgSHLko4phICwigteOwJoKOXFZegXHSRgZ3+VDJS1aVMlFlAj437krDiVPkzxCNHSEt6xS1jfSN/57NY5ZryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKLO5aowMtFkN1v6flI3U2j8ilZzZwu3h9RuAvaF98Q=;
 b=m0hheYBujpxtq566mTbKEuyk6CjFbDHweCj6+nYfodXfJnFTlRskaxXo5xG9xjEAgDWxeGLVrjanfXAI99zRpTDFFUQBhUCrhMnAFU+Y+YdUwujW9wXZKgeblE1oUgsiOx4A1WzQRC5MTUdeCsgJ52vVwMl63ixeR6BG42NRBfs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 16:09:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:09:08 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] mmap: Fix error paths with dup_anon_vma()
Date:   Wed, 27 Sep 2023 12:07:45 -0400
Message-Id: <20230927160746.1928098-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0467.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2084138d-d534-42f6-a89c-08dbbf74148e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOgQSX7y6QWs/fnHOiPh43XePlQW2PyBACrt3D/D8H2WeDGGoutXoO11cNz3ONpQ7Ro020dyOLp6jYQ5o4GlDWQsBRb1wJsEpj2p+3iLXS9vjET5MPnZm7o/1Dj7Z2n7mDpXUPXQUZ3MXG/ho4Xk5JE+gyGehk8ILvQjfm0RaQSs0EXBwvXaCscWEJPuJ1QEIIMAbhK913RVfPRG54CIDT8AfDNusEfPJOGR5DFEn8Yrr0xgadcnqyXg3nq7IrjLVh9SKFD03n6pHohHfAxxnghgZWmOVqWgpOTw/0z1wFvgnz8RlgBEW7RHm2iuKXlfzEhSwOaQy5VBRKLNWD7TMaXPcDThjl0NsSTjHli0O+0c9dckqu/ppDzu6AdwWrDZYmoyXh9q6AofRG0xfeath5vxgkuhM8YPjj4kTBFyYwTCCgjlelmfa0w9lWEGhpT9+TIIg7Sbo/OXsyjrKAWcen3/YZ78c+Ro2MXA1/fEzV3hT4MEgpjdrtlthCMLFQWwrxH9X9rNLgituQaw4frUsEx8hRFPrD/BLEBPOtiqOMKqhFDJZ8FyoO/g1Bm8P1xj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(66946007)(66556008)(66476007)(38100700002)(6916009)(54906003)(478600001)(86362001)(2906002)(7416002)(316002)(6666004)(36756003)(5660300002)(8936002)(4326008)(26005)(83380400001)(2616005)(8676002)(1076003)(41300700001)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BV7LC1OIEumSi1hKnRkz1PhRAibE4SIaUftLhlk0lHmWDEHzHEJct5ki/Yfl?=
 =?us-ascii?Q?GbM4o1R8FnrZ4Wt04DUzh6axla0MvRwrNeyxT9S4HvYiVBiSXWM7Fom9HTOn?=
 =?us-ascii?Q?av8Hl1EaF7dwLO1iBVbqL3uC2Jz5NYd87/lE8dgKjEY8M3iOVT2nlerDQsy2?=
 =?us-ascii?Q?UTP57rSqRUHz+4ua6+VEdInTUZvJNqkFtWcpMcnAGHLodOhankHnpAxfYx0M?=
 =?us-ascii?Q?+e0bFbNzIsVnSCzyOkLysPxMPgJpRa3+ohaC7q2bbc1nOGvLhJSKGStBg9we?=
 =?us-ascii?Q?A1QIir7UmbaN6GIXH3vWMXbozIj4fQt+hJuIt5EDk78QFRG4OtjRMkW5X8xe?=
 =?us-ascii?Q?zyk8035wYAcHNagyOLnB/6LOrEgU2kQ7qUtxB3WCIS6Id88Bbqg9G0aAQprL?=
 =?us-ascii?Q?Bt49aze2yGSSk0xZNx8EC4halohwBmp51widG/xcqIH3y1tJ4s3cP0c3SE11?=
 =?us-ascii?Q?phrKoreOrtZEsvOEiDaIlaY38AFOkcFJmQS83q2Vig5QuuUdwQoI0+EEryoo?=
 =?us-ascii?Q?GSEnRjLiJqxO94o3vnrYInEyEoLgVlDHGw5/4CrSHF1uZOZWOtzYuq+aoWHU?=
 =?us-ascii?Q?gewTtBeHzl8iSXOBzr0koS0tANWV63gwa3wmtoZvYgnicqFCKCg2+poen41Q?=
 =?us-ascii?Q?ixiZEBfRYzUQwkoOHGPJohhwcN6A3hPGOOZCc9nWaLA4HNDBYoWIjeCc6pom?=
 =?us-ascii?Q?BlNoZwWVd290XMhYjvCeECQ7VO9/TJ3lyM5/GqGuXbxSjns/Cz2tTml29Zp+?=
 =?us-ascii?Q?V5njqwlTxo9+dZB+5g/faBkSUgCBAgG/MMiJMXKwKM30PPTd4pmFanhuYi67?=
 =?us-ascii?Q?A2yRM7LDhQvdGPRXY7/LWup+hCm4/XHC7z23VcBFsqP7aru6PURPYjVSFYse?=
 =?us-ascii?Q?dF+e3ndAI9te8ad3U7eH3hXwKyi7cQ1ThFTLy0IxkcKxjdPC+fXrq9pdv5DQ?=
 =?us-ascii?Q?45mGRab4fAamMhMlSpp2UH6ct4XEjfz20hlzL5p6UuWO67TzYx1HDfVj6ZFP?=
 =?us-ascii?Q?OV9iCvHYdWSA+vLKrHCuhSgIV+xz5if8S6kXCEBti0v2VcGCsvGajrrWAJIs?=
 =?us-ascii?Q?zvyFWDIZ3OK3SMh5bM3Gx3nlwouTDhnxR0YpaG7Jy2T4y99Y4oc+tp8jWK6u?=
 =?us-ascii?Q?ISJtVUKhY8MjGx0GEWzJlxhT3WFQc+niIE1kww8Yla7LIMKew69PkNmJJyk0?=
 =?us-ascii?Q?ZBRTkQI6Y9xllEysD5cdu6hHlNvVgDzhjuer26rVHaGwJPgCaoUUxGsVmdWs?=
 =?us-ascii?Q?Oo9XrgMHPC/KDbtD+mgG/s6Ecp7/kBkDLvS//JGBlULhUXuWEbla3tmW7V3g?=
 =?us-ascii?Q?YKFQN8JjGIUAy0ONLmXVa8voDugTOrzhAHjbcUCsaDN3pSpDrKBZD4vfuW09?=
 =?us-ascii?Q?kLkP6FCznDVGV0dDB4+eQuO8j/aRQwdVIJgW3VqqtfwDv88CtdF2QQiSd0QZ?=
 =?us-ascii?Q?w9GiL12PX83sY+MlfXJaHKoZKZKWl8ohD5ifN1k+eM/VqKhlniLnT426rjPt?=
 =?us-ascii?Q?udhPuCUxL115i8g/IFz6WXoyDmpQb/kUjHs1W2m0GTxDQLEDZSZ5LbuytuU1?=
 =?us-ascii?Q?xQbritabVmpLXqmgFsVOpD88ZX1fpq/bOdzz+/hw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/493/iW/yaL+h4zHq5RIUoYfGmGS6JOVUEUlTupYb/uwsRDXe4Oir0gy/maJ?=
 =?us-ascii?Q?TC3XjOvAz7eOM8q93Z/BuTF0SaGy2wn+DhaijyFZ4MCEVhhjPCG8ftdvHIW9?=
 =?us-ascii?Q?ruaGv3IEfx8/G3ImiJHEvKpbxn+tVX98whJDGjfzBy2eIKlyljgeeroDLA1i?=
 =?us-ascii?Q?3Rn0gx5opyYJCMVSCKuI6Mb4KxjJwJarHGOCaFP1yhhgJJ5w7hX7BlJUDmX0?=
 =?us-ascii?Q?sbbyNxoKw+WmxH+G99QLzutI5GDy4y1Od0FDF/u/E0TFMcl++uY+6iJvHcIC?=
 =?us-ascii?Q?EqslfRbOwAIMYq5NAUydyuFNTJdgOKnMQ2cuAMMmZo7qyvuDHPO0shsIn3mO?=
 =?us-ascii?Q?PccLALYCCUjOHh87+13xWJiQLGgk+4qJuROQ2rjVMugrPKrNcqV+6EohxRX3?=
 =?us-ascii?Q?zTJSRYJV4ndHOSeEEbn+QPoiVvzzfRz6G1RpaVOeWdLriQAqArgPLHtx2/Jv?=
 =?us-ascii?Q?3UZBF1YQpNJ9hoKmlmoRBbToDTkrwm/QQQJrD2AMXeFdx9Sprca5WyFnQVLC?=
 =?us-ascii?Q?9biE5XWBt1f6052NWQkZcONscmDL8JGYTCHGBxeHJUNUPOmyrBDURKN8E1T/?=
 =?us-ascii?Q?2eL7+f9eX2sp00ZcVkjxev/TCaU7ojqUMyT1sqEtqTz+4yyOGJxXXteedcsE?=
 =?us-ascii?Q?F9XcuPLPqrb79XHkXRWmPJ6ujP76XHLStWJ4l57YcTWB+0jnE0cAhGcp9FxD?=
 =?us-ascii?Q?ffcDar1huswyfha+6mnDTh/x62s+THGCefBG66FMK65Z/5lK4XUdTb15jEoO?=
 =?us-ascii?Q?HS8MQT4cB1RbaTvoSBt+Xb34wtFsPdL0bBAdohB6Ym4pSghES89OnPKAeAIg?=
 =?us-ascii?Q?K2v1tvnMYkNgWulo/UbbnaGOP1YFo27bI8PCq70fv3oE7abaiiVlVQdCdJYL?=
 =?us-ascii?Q?P9+m4tzWphzil4RI/i/+1oLkrs5tkw5eWu8vtLPxlYDMcuz7clP3LTWMXXa3?=
 =?us-ascii?Q?BsmHbdqFXQc658c74JjDQoILCwT9ZJGUrXaXdqfszd90bxHvDS6oO0fPqmkl?=
 =?us-ascii?Q?7hiI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2084138d-d534-42f6-a89c-08dbbf74148e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:09:08.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSK65zzy6aX0ZDPHhnGeXodhWjVC5Q1YVolwB4RN11uSzDXeQwyMY9d4jGlIsBn7C3JY9xnRHfVnYJYHHbWUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270137
X-Proofpoint-ORIG-GUID: StTGcNikf1_B-Srv0yNwqwz89SOIiU6d
X-Proofpoint-GUID: StTGcNikf1_B-Srv0yNwqwz89SOIiU6d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the calling function fails after the dup_anon_vma(), the
duplication of the anon_vma is not being undone.  Add the necessary
unlink_anon_vma() call to the error paths that are missing them.

This issue showed up during inspection of the error path in vma_merge()
for an unrelated vma iterator issue.

Users may experience increased memory usage, which may be problematic as
the failure would likely be caused by a low memory situation.

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b5bc4ca9bdc4..2f0ee489db8a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -587,7 +587,7 @@ static inline void vma_complete(struct vma_prepare *vp,
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -597,6 +597,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	if (src->anon_vma && !dst->anon_vma) {
 		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
+		*dup = dst;
 		return anon_vma_clone(dst, src);
 	}
 
@@ -624,6 +625,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -633,7 +635,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		remove_next = true;
 		vma_start_write(next);
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -661,6 +663,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -860,6 +864,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -927,18 +932,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		vma_start_write(next);
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -954,7 +959,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -1018,6 +1023,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	if (merge_prev)
 		vma_next(vmi);
-- 
2.40.1

