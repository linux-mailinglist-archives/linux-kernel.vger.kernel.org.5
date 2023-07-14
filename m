Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8175437B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjGNT4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGNT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:56:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8087430C4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQfMh019442;
        Fri, 14 Jul 2023 19:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZosrZNMjYCZKN62ARwFyZydisxecyc8Jvja+c5d13h4=;
 b=3DXvotmJoEanAz2f6FmNZryUb5XV+h5wZx4t1lMeEf+QDN3NWjr5BeeuHIkqRJK+0L4w
 dpDFGE9eAVFnPaqqjrGkAcflemIsANMi7k+/KIQf2T7BAkuUO/RH2vUniQwTXxHnPDgP
 VLvWqHU5VZqI10d55J7SwwUGhuxNDyngbrL+1Dt//lnGBQGsL7jWT6T29TSUehfOk4Ef
 ImYVmPm+ozt6ZAEUtLCKIP9YUZzqjqYsMxcq6qygwxwOHNAA2B8gP5y+f2JFge9vZdWb
 Gjl/3r8rG18y0r2HDlcm+a6X5vecCC4KTDurSjsIt3sTXbYfcTAl0tOaGB9LZncNVcH7 Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq8at7qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EHx2xi007529;
        Fri, 14 Jul 2023 19:56:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvsn80p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC7359wWgMNEgljDZo9MuxzPR/87XNcFGSLTxGmWJWSvXtltcuxf2uMkZ8Iyr1uVuXMeUl7zwDY3oFzvSSrxyknW9Khju4iYH6KwCSHznpm4dS2fe5z5QVh6cy5+gXAsSkgGAcFwWBY0G3tjhUZrzfrXpLM08XhEEGNR5+3ucY+OoL+6vS/Fr2hnY0cSrTQN+fDmGVEoczNonbXJNGFgq0OsfeGbZh1AZAV4ZXwkLLuGJKkHsL//pvKaTHL2jjiO/y0BHd5NtK7pj+5I5mXHiLi5DjOz8owtDAZ7RocrzXtkCotqdZy62ruerosQkfKXduX4f/mb6yDUddWcFtCkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZosrZNMjYCZKN62ARwFyZydisxecyc8Jvja+c5d13h4=;
 b=FoIegbIr0ViOCS8fAfbXTVS/hpwl/Se/3vnivy2ykN8+y/3ZZ4etWfe7MsrgKTUU2MAttPbYV4+iJ++fFS0+7u9b7h3nYUoVlqsJii1cGfOUKxdn6mivDRMPrQrBpBfo0JseH/11KZqp0jFKcwC/O67HzTrOTwX/H9hLsaUIMsGrzAJPoiGQimWXinGPPASWX4XsbCqtSmPMjd+3xdOS14ws79n0/iSderWOh10D+CadXX+o33EpMWeJUrLnRsHJLrEUjcJ+5A6Z6U7WexoTpGP7n100mOJaH5Ri+w54z5LAlzewCD1MDnHJikMFLvM7fT4JtdY/zUAfuCXCIKcmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZosrZNMjYCZKN62ARwFyZydisxecyc8Jvja+c5d13h4=;
 b=SKSvIeaIgSWhKK/VIJCCOH5kdPD9oKLbboKYNZ5pA5gCB7CDvOs+m6ejkO2rRb0T/2lbeqIrOg9qK6QY/9dTcWBn9YvYBkZGKt4yiNmhR0YT6kCrtK+S8MAUyl/MVXk7XQo9q5sxv/u9BkTnHldgciaHjWYC3CUqdIDm7OUlzBI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 19:55:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 19:55:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 0/4] More strict maple tree lockdep
Date:   Fri, 14 Jul 2023 15:55:47 -0400
Message-Id: <20230714195551.894800-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 708a8e80-73c8-440d-534b-08db84a4573a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNkXzvhGUXZgsoL3ntrbi85cdiOKd22V8w0gEFHQsWHzw2GgP6dTbgwQiJ5fSJp4444xkFHq6wxrXBonIx4juPGYe0MdavFb8IKsUbsKFYZwYoE35dIMRu+VM3N6QKgAKT10CLeRrKUdYm+hitY1bYT7Gd6W71kRdXnHNHNTXrQD9JjN+AV9+/cJ9VYrSIW67bh7S4t8AmbudOEM3jY6k64xn6YeWIwEnOgF2aMC7zsuf+0Z55JFe/r3z6V0mpMaUl9Xc5mzFhdLpPgp9CKoWerp1MUH3vNXZ7TJGsJ0yGKfiotLU4CvdaWr10YIGP8l+epqIj9T1dOO0mFrV+XzZFsXMSbjitFwRRMqQYj3cvHD0F6Z/5dTnPRXfMLtk4guUAxPQjDL2Iqyf53BQCzsJKKTiikRBUCQA3nrx++67TT2+QYILcEHt7FZms4i5o5jSm1T/B6WidXITUj/FpzI3Jv2rCFRZ8BT2olBrK9gK/fjbFnS0PXjwUOZ0AxOxZGyva8jRsBUiPMNiTT7zJIxhUNCb5iBOlVhj2a8mUQKHHHum/8RfEuJtRcXdXzX0Z8TZhaH4blruQY2d/y5fJetFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(2906002)(2616005)(6486002)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(966005)(6512007)(478600001)(1076003)(5660300002)(6666004)(54906003)(186003)(6506007)(41300700001)(26005)(107886003)(8676002)(8936002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?doXObWqjyfObnHVJx+2OpUBYOsytRbGHt+q3fK+Pd57ebNYVyYyx8g/uBw4H?=
 =?us-ascii?Q?OGkXltJX2+XXuGD3DvhhDiC7+2j1eYARBX7mnG+IAFyZOEFjdgIr/x7P3Bge?=
 =?us-ascii?Q?V4fQjZ4vCpUf3PCygozBkE5QBQoVC2AIcfAEmTKFmT0MyMuJDhs/8QWgh/1o?=
 =?us-ascii?Q?l4wkLJ7HhDSynbJiHHwABO3oi/m+3+vxQMA/WQiWaLLbqyfeStcmxYws3wph?=
 =?us-ascii?Q?ZCH6NHI7jf+qSGCIHSw510oJB9cZBixnbMFCWoT8G4//Ynnu2D9/e87JDmg5?=
 =?us-ascii?Q?A8blc+e62oRcWwc/uJPV2ew3W8u+qRHZreyRhPj+FIRHPqkkQaoDv7D0lCsd?=
 =?us-ascii?Q?QnXt1qctpQJSfq2ffOXFApWR/A7oZ/PJb87gYWgwr4484NrCe5DAh7q7Jf6J?=
 =?us-ascii?Q?czC+gWmFcwf7/aamjzvxJhA8cTtysifigKJwI/ylJ/6C8D8HI6JK1G4sOxvD?=
 =?us-ascii?Q?jezkt/fLzh9DohqjRKXk8xJA/D0hhCsbyzeBNLX/UIOIcRCoKqr/8sACRUEs?=
 =?us-ascii?Q?0bAkOSlBwR++dlDJfamhWKshShR1NfJGueyRlkY2FActLNItrwe08zvRD5uX?=
 =?us-ascii?Q?hL6X2CUWRkAPN/+CP7I3sxUcX5s3PotTx8QL0IJcELLvlROj8DbvIYG3T4mg?=
 =?us-ascii?Q?iZM49+u2uI3kGwYCDOGe/HSY5GZoWOzzI+aAlfpycyxoyx1HgxE7O+tYM9mX?=
 =?us-ascii?Q?IwvVeXPK7M387fwolLy3xYVUt+vK0lpUPgH0iFkpm66dTssQXHISjc6gpZHs?=
 =?us-ascii?Q?01UDd6Dh4jyQp7MX1H0KVHg/HR9rUo5NEWMuPe3DXPC3CQ/tsvbmMwYrgFo4?=
 =?us-ascii?Q?sqIeG6cDu7KuMAIqcES9XO2nlqMLCRpMwKRwAfL58f4nQncbRYLpnpZqxs4R?=
 =?us-ascii?Q?JX/bQ54OMpw31O+dpYSxyVdXpnkIi7ceoNxyrXNus6tGcOQ22Edzg245l7X9?=
 =?us-ascii?Q?3G2devN1JIks2n/EZuuk3ZKIBvA+LSgplzd791NmX3RqAvBYWUdRSX0rt9sf?=
 =?us-ascii?Q?pOEfzGAbXqJ3ISM+hWqc00jn35KrAyi6wR/y6w40sghLXploAUqMAQsDOr97?=
 =?us-ascii?Q?cOPM5Ucs2aOS6WW5vpkySDQGHY+XmEckv9ziEiqLYIQxyEywQgqynugrPiVU?=
 =?us-ascii?Q?T1ys0ydSn9W7dtQeWulnspq/NFr8CHUmVVNMIMGKU8NwB+QBfmnd6P2wtJ45?=
 =?us-ascii?Q?vFUfpBbyYK2lbJQPRB0z2i//e9QJOWrw5Bcbfd12H2ftZ6m5D6qeK3IRdtzR?=
 =?us-ascii?Q?t6qVXQ8SqOCB5yBUPln65A/egEpulKnHXY7pzfVP8uCpmubuXBl/ENgvvvKZ?=
 =?us-ascii?Q?DXLtqPXcuDelb0zAJECR/o2f2l+aygVQ6HfICcAXnHjmMNUjiM5Mr3NXHaWM?=
 =?us-ascii?Q?yCAaVJDPthYfggnhFf4lKG+dG4fa1ET3LKn8n/6nEJFpB+p450x27dvL0IK8?=
 =?us-ascii?Q?RP2vubx9K1a3SqKwA4Z/QVS4+DJaYHwnHrLKiHJ817yr0XxhFfnsG5W1hME0?=
 =?us-ascii?Q?h1ZB31yqTPW/ancX8hFflb5jP8pt/FDPnty3mVVauEN4DIx2nCrORDf1zwcv?=
 =?us-ascii?Q?/lvylOyztj+Dic2AV/wHGtTXP+rnBki7CGMrI7yKBE1JEX1fZulraqXcGyQE?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d3aX18dPIhNsuhnFRUYt2HxhUuy4OwljT6P+1t5xjUglqB5FK2MfrNPGksut1BFZvf0Mjwpb+jg1nkztQ5xJM88JnrLKY7TENBdfrPRO9DUnGV4l+PvOZJS84GhBn4LZJJY9WMXQksNjRl94jZHov7qx7deTH7T9e+O32bp6cPia4JwaOCvVoQA+HnZGtQyz9Nij3X89NEtvpP5I5RFwVRNLGA8Zdn4A5y9yvGgioumGaVo4vI+6GeDngBlI37RM8fHrRam9Wu3cf/sUW9eGnhLrfw3U8OIyildwePXN6PmEa4AD6HqASXFbC5sk0ABM/xDZEQGC68UmyPLn9jvTG4/4GknDpSdNcXl/SOVQKiAM5voCz5sFgM9st0Mj1ocvpWE+LFAls6Kw/xuCN2kdqsBC/vthu7aDL1QT21qWoo+kqgVm5VMhBaNzRHji/Um8qDzxwD7xuuUcVlPXrcyn10lfk8v3JXgtcxiZvsQup5+chaWkaKcSo2ZfemtUM2+d9tzuJEVmN5gKa7MqqkiBGyXdKXOU2tR1thWpf4sjRYXhvs4uovG8KUFC5+righTXqP3feGFQey56obQGT1eOo937zQPU5EwoDP2WvjNBDfjdrJC3ngHZ3a0huTMCc2IkGk4LI78AL1IKmvMT32C8lO4i7OauSN+Y3JobHdK5/aoFzznLJfTsMHH4amuhuccWyWyiaMeGQfp9/OzPB4+1LJZQJFZ0/mPUxNbk0qDVaE4XnrQs2Gd6FWmb7O2Q9ZaHoYCvu+LCb4a/ZKRsRjB7fn13baZ+ghi4yB7Lsyw64479wtNj2srNRQkSoFtU7XTFtBPpIBp6JxelYRLlZHhXf1iNBPE2WfdXiOiIlLsd0yvR916msOjWKiUnCFEU3EaEq7oIAbd/OMWtILG6zJdC/A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708a8e80-73c8-440d-534b-08db84a4573a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:55:57.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O88MVvP0uZHZ0fjBS612z6mFquYC+xj8j+1UXPCYupZnOe0t1e2TQYdK2FCVUMJ9UlvNlZu7bVCpqpKNJn277Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=622 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140182
X-Proofpoint-GUID: Z3LskvP4y8TAIdqtYaipK4fi9fr6RRIA
X-Proofpoint-ORIG-GUID: Z3LskvP4y8TAIdqtYaipK4fi9fr6RRIA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus asked for more strict maple tree lockdep checking [1] and for them
to resume the normal path through Andrews tree.

This series of patches adds checks to ensure the lock is held in write
mode during the write path of the maple tree instead of checking if it's
held at all.

It also reduces the validate_mm() calls by consolidating into commonly
used functions (patch 0001), and removes the necessity of holding the
lock on the detached tree during munmap() operations.

Changes since v1:
 - Moved the relaxing of the lockdep check for on-stack trees to its own
   patch.
 - Moved the on-stack tree destruction to after the lock is dropped in
   patch 0003.

[1] https://lore.kernel.org/linux-mm/CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com/
v1: https://lore.kernel.org/linux-mm/CAHk-=wjUp5+tcsHG89ieuwa0wUtSWWBWRt8xOsoZ1nskZbbk-g@mail.gmail.com/
v1 part 2: https://lore.kernel.org/linux-mm/20230705204629.clctvnx4qdqoexyp@revolver/

Liam R. Howlett (4):
  mm/mmap: Clean up validate_mm() calls
  maple_tree: Relax lockdep checks for on-stack trees
  mm/mmap: Change detached vma locking scheme
  maple_tree: Be more strict about locking

 include/linux/maple_tree.h | 11 +++++++++--
 lib/maple_tree.c           | 10 ++++++++--
 mm/mmap.c                  | 28 ++++++----------------------
 3 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.39.2

