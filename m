Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97896788F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHYTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHYTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294326A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEWaI031486;
        Fri, 25 Aug 2023 19:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hgjjLKzxatL2kLeVbyvUq9gKeYfImLdjnfaoRhKBwD0=;
 b=z/xyJX30XZCI2BsNidlskUASj7IscFRb1fZd8bEPimLqCabKlc9o+Z+JooI5a5wclB+n
 ksqugs727M3bGNT3/SfFBaKJvvC9Ne3n6IurVD+hDZjT1zpiPdssKLWX93RFuaMEcTk+
 3gIgxqngdlIPApKKck0b72HKcSK3EEwLGdtjA+Sxnrx8YQnySl55z4Jn6IZOsaH49p1u
 MhZlOzXbLvGnTr/aPTE2I0GQ2Qlm6Ne/X5MxSrNDWSI/LjiTEFuA9cyFaEixPifWuwJY
 RtAxEzeNiPPGu7SqLvmqIrnvduPDbDHOM7qj74m/KImZWaJz2l2JI//nAwM8ondUTljO Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIUF51002259;
        Fri, 25 Aug 2023 19:05:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yyg8k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWrP9Qjf7um6WvLwmSCGrDhukrrmpgI1AcZTV5KSNEaeCiVIBXbzJLNzDqKyrB5ObIzKG0ij3ekKsiUqFwxg+awarjuunvAqOOB+yUBmUwRIWQikz2T3X/OdlkemQ3XVZATgOYoPPMchuxsITL12FangHZqIEtypOrh8wAMmCeZkpwDKj+5gdG9CKtyZ/sGvlwpZCaQ/YsY2ynYxPLhu9VbJAyOErVxfcZx0lBEOuCsx4VoslrVkXSKVktXRGz4juJ5zZAS7QhrwfcBjJlYtUvmwce4PIX45AnS1+uR+a5LyTCEXjnN75WwXJOMFCAgt1t/Hq3cGc9kUUTkGaBWCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjjLKzxatL2kLeVbyvUq9gKeYfImLdjnfaoRhKBwD0=;
 b=THr6BKYBNTfAKpinJl98k1axbv0NvwhzQq9C05NTwdWkLUrlGFRgKwp0ITJmTGYh6ZLQZmKBM8Vlz7KCWi0hsQ7sNImQGqONnl0WiWX8OqxGnMzlvuPUTfdAB1r+Ntsvm+5kJCj9MPYxo7krlJAAoWPlO1R5AkW3VWnHclz41BWRHKOqwxlqmeMwcJNgcinDslSRhJJ7I44auv+ILaKPHOpjs7rj0B/o/YzSDXJ7HNx2KgWVDLUAprIu7F2hybSUwFP24pR0oHjxo+pn1JsybFXm2ADaFlOq1xHmMXoXQLstTosm5FEqgkbc7F76p+ME64JleiNbr+7ClK5fAeqYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjjLKzxatL2kLeVbyvUq9gKeYfImLdjnfaoRhKBwD0=;
 b=mbIFw+4FC5egAb6bkI13P7RO7pWnN315794cOe9Rp0cW06Ts7e9Vg2ukzD3OYJhVv6P6QWhPaFlFVc1Q3ULqbwqgmO0jjsXmYhT7xNPAJQrgqy9MenLTYgwlFa0w3xQgyeNDXTKy2Tmu1UVUYvQrnivZCm7hu6yNGNMomvURBao=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:06 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:06 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 06/12] hugetlb: perform vmemmap optimization on a list of pages
Date:   Fri, 25 Aug 2023 12:04:26 -0700
Message-ID: <20230825190436.55045-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 483753e0-17ac-4bfb-518d-08dba59e318d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnxJSfTikXoHKsRYQD9iT+K3jM6MTMtZxAy/XGK46jZ7HEIpBoWISR8uDWPFn8++wAZ8LYxx1KqAUwuCO4M23mY3qPJyLfc7Oi3/sHTjeHqVM6le0uk157eFpQ846/lBQ265kBLXJQ4Rr1qoxUJ0829D1zq8cDeDoceWXKEf0hd2DGXoVb7pHMI/UVusiF5oqsanZw1DDC6EZiNVkthRH+Yhr7L6hDf8oqPkKrgOtaXdsrGkyV9UjgLiptoVARfZqC4/4luEPBoAy4UVUrqwD32bVV95LQLCmthoq+k9MM3iJTQUkKbzaFUMR/ycdjDB1hX+oBnsMgJiY6r+syOmHquyysvm40VQkiR8aVV17QG6niCc5PQ+0nTtC1k+ujXc9HiBKf5bip+GKVGrbW7Njt4VrXEdqWezAqfGD/gXfBMukZU4MH2zpbiEGN148iE8xEBPIAqiJvmeDvAysspYSvptZ8WeEcLVTxhW9arqqPV+e6bnaTHsHhBTIv1yZBS4eksQPzoN3IKsPAp+iNnDl0IRUnvMlZsmRU61oVryVR4Kbxvll27+FcTruszQFnoj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rB4xzcCPyDfCyc5Hc3/aQ6oM98DT7rh2cRVOm85p7CdUdnjDz+cfVDhft0w?=
 =?us-ascii?Q?93PBR9ANwIf6U1rK8D279FsQBRfgcPktOYnnY+1GcfXGNXBSk+27LRfc9MG/?=
 =?us-ascii?Q?wCyskxJM4CDLcEN7OYNPlUQP6vOkPp3mpnOxRsvppWIrQvkdwFAhT7+TBo36?=
 =?us-ascii?Q?5HbOlEi3v3fh+piTzyR42VfuF0Pt4W3wWJC1HzvqgiVfkrNmzkUPF0jnb3EX?=
 =?us-ascii?Q?O21nta2qItfQVCTrL+7WLnj9NuTsF3p6HNjMFu6vPz3yY4DyU2k0Cv8724Xr?=
 =?us-ascii?Q?1iqs1572ItAygEOOGSeGAgmdWTwIWtD+KZrJsdw7uqG1Y8iFPrldBd1UZvKN?=
 =?us-ascii?Q?kRdrcuYHzOhOmKlaA9RFqjPRI1PbjWCh7vpbfpAMYFxKHIwDd3X5QhMJR8xd?=
 =?us-ascii?Q?XY7Fza0s1PGMrn7aF1YDntUmbEpFOEy7SBFo8I0fuyqG/BHV8fS34mQ41oCD?=
 =?us-ascii?Q?xK1278cTXJkMBThIpK3to1IY7CaxNvOfkEB+CA0lYHudcyH2T4Duwq9DQJei?=
 =?us-ascii?Q?9gS42KQrK/K3AwtwsS2fLHd8rxXcYzIanZ9ox2IaYhHj2mcHDgmaP8eAlm+V?=
 =?us-ascii?Q?d9525N5WTESOn9t0B3i9KaGopioDym1yidAuB38lIcijOIRKG3U85xH5gAId?=
 =?us-ascii?Q?QAtcrVHhJvEGngPN8SL0DJNNFbE0jiG6sUhqph6QsBi47twaxJOn2cPD0xEJ?=
 =?us-ascii?Q?AnSqtFIqHA0Yl0W/Jp4edzzYsYyHEKPbXy4o1YVdtaZfH2RsQ0eUHgrLsHuJ?=
 =?us-ascii?Q?oce2sj+IgVbXCHiQJdhOIlCm9cnkjOfFaOkigKxv4glwDInvMQyX3xqmg3Ut?=
 =?us-ascii?Q?BXpth+vXoub759RsC129ZwxKsEiLm/SWBfZqQxYMQXCqYitrH96XO8Tlp/hl?=
 =?us-ascii?Q?XjfQAOnoFaaenHCIxQP5xRtSjoNt2okG/EUHIGaUo00At50r+aKhz2IZrVEE?=
 =?us-ascii?Q?IfPXvEiE/6PQWAmtLAps2ynfcPgpMUMjbWom5EnEe7AO2xXzgJOTiZiQnp4Q?=
 =?us-ascii?Q?eCtCtbtUb98k+cmvdgVBzSsi6i1Eo1txescs+o3CGw6vJhgCXEzKZc5k8RDZ?=
 =?us-ascii?Q?fcf5Hzll5Cn3jh5qEqxQO9c/ki35QYxpKlzriVbvfySk9oI5rqrLQWLdZEg6?=
 =?us-ascii?Q?gql3Cw8K1PRXIDQOUlNCCtR5EngpRsrWk/6NpNegLFCDCp5cDskXsTNTfgTJ?=
 =?us-ascii?Q?e+dEx552XulxmSZXpSaNWUcbVRIFr7Wh9fQGjdOhw9RWdB33WjgxssFERqtv?=
 =?us-ascii?Q?ai8iOwIKCy1pkhQaozTPsPoaVg8hXPoukDfK4YEGJD6va6dNqguQ+yeCNR2p?=
 =?us-ascii?Q?DKexJ4Pvdv2USJwCdnxQ1j5Z5WHlvQtaHY2EVeJ1SF9UTRNYxhqsN4RjpPLR?=
 =?us-ascii?Q?XQUFHslkNw2m3C2eDCBS9r1hGyaedAAv4DzeapPqrD5dUauSAzVo4O30Yq0D?=
 =?us-ascii?Q?caOmwrhMD9cUZKpQf2jMzPEn+x7UNHgSNNujXIWdwXLiVwURNLgaepwuluyM?=
 =?us-ascii?Q?ULG+N1vfdBiTxc/xfodwmpHAbXqDAXEy/sPFc8cbG2tDEl6N+KJselax2lK9?=
 =?us-ascii?Q?bcf0+Jewv0rSvW9Zs7wOiBlb8YRGVMPDEdwGd4HWWrjj/Uh6TsedaJkB3RGR?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wspp+Rq31laP+o+2y8YLGL0kHUIVl3+YPry7w5JVbxpZN+C4QHqWuvYAHYBw?=
 =?us-ascii?Q?xlaqWbMULS8XxOTX/PTsu3rR4+KPRiCE/Mw8ZZdCdFqoXPdvLz9lnBqXT6Us?=
 =?us-ascii?Q?1W11VBdkABKQ9wTfJRJnfUuIUtmiQ6hFj6MaycrBhg7s5c8uuwD39eO2pDgB?=
 =?us-ascii?Q?drioz/u2YKBkntQBsz+6DlUGSCigvxL8ZwfLKNGKxdQdbZs/npko62ns8Xps?=
 =?us-ascii?Q?zzr+7twyPHHbho3PaUY0UAwiPHrTLne+Vkjpwe40wtBTNyRa6qt8tYdFzh4J?=
 =?us-ascii?Q?5/6XJDGwe8GyoDBuo91YMvr7QO90Wxuw39JsoAD4PO47Ptp4yeIKlKiCM4bG?=
 =?us-ascii?Q?U55l+U1QAFBjOibmsqaYlE6O5qiXovxEjNWj0hKA7cYKMYYxCCB+oJ3FJhk5?=
 =?us-ascii?Q?128GI95mewG5mynlgR7sOl9PzWFiquA4UWUt3qZIB4C8TXqY8ojOiUWkmSJf?=
 =?us-ascii?Q?0IC2wYuSRBIt+PEhpTFEIYehXsyk7CdRz4vnj0Z9mMpbrtI+xvrasYPzk8JN?=
 =?us-ascii?Q?5D2QWGtDyFqpLc89EQOf2Ogf6aSKZUHreCkLJH7HH5pKq2izIGCfQGDj0gQr?=
 =?us-ascii?Q?hrrt8e6QCTp1UDixYd/6LHkgfbQZXPLHeeruAsuGdN7plhfFwZCKUUtzLF6o?=
 =?us-ascii?Q?OdXhWsy94fD5uWcRxxX77fNwX/ptIgylzdZ74K5oVElI/wIfWPd7oYwV0Rng?=
 =?us-ascii?Q?DfYQqHOaD4gOipnV7ILCGL2n5ZKYtm96aFjK/3ZInw7boeLaf3U2224uu3Ov?=
 =?us-ascii?Q?e6/TLxiacrU80NSpcuKTAm8TDYb4n10BwNjSVJr22PuIivRY4jWp/GJt1JZ5?=
 =?us-ascii?Q?fLe2PWVkATOtjiZkrTREv6dsFn2saRHyXc9ea0lOivoxHThl4kXUafhBbTBc?=
 =?us-ascii?Q?AxibRCuRYb/I4s/KWOUXo0oz5+Eoor3Luow+ecUFXpH0LdSZ6RGfi5mqkLGa?=
 =?us-ascii?Q?CKQ1HroxFUr6EjFgxME/7hJ2FYlAOntvAKOoPCOG5n5TbvZEoXIB2mybVpbH?=
 =?us-ascii?Q?GyOCk78At6aZb8FPjRaLuoNFps+gwCLVIXVclMNyB0WPmdHZLqqUY5ZUuf/l?=
 =?us-ascii?Q?Z6OMe++KzIRgMsSF07fFKrPE0QRCrh3MBGmcPlgr3MRDUyADdkXV37XOuXqq?=
 =?us-ascii?Q?GOtYiotx6LPQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483753e0-17ac-4bfb-518d-08dba59e318d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:05.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX+NjcmF7KoWhK8wcA4xqAm5kCIA1KOFBpz4srQmQ5MoLXa43OPjiibUGHBzumcX5NvziaD4/g+aYTJPpR3Ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: f6SQZLyQGTPDeSD3UkeDiDl_BnIG-U0o
X-Proofpoint-GUID: f6SQZLyQGTPDeSD3UkeDiDl_BnIG-U0o
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding hugetlb pages to the pool, we first create a list of the
allocated pages before adding to the pool.  Pass this list of pages to a
new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         |  8 ++++++++
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 452e7ed6dc36..3133dbd89696 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2223,6 +2223,14 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/*
+	 * Send list for bulk vmemmap optimization processing.
+	 * prep_new_hugetlb_folio (called from prep_and_add_pool_folio)
+	 * will also attempt to perform vmemmap optimization, but this
+	 * is a NOOP if already done.
+	 */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru)
 		prep_and_add_pool_folio(h, folio);
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..147018a504a6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -482,6 +482,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
+	if (HPageVmemmapOptimized((struct page *)head))
+		return false;
+
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -570,6 +573,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..036494e040ca 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -47,6 +48,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.41.0

