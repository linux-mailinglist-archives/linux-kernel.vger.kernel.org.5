Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E47A5607
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjIRXD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjIRXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4C8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK4uFN015809;
        Mon, 18 Sep 2023 23:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/kABIFJps6jWnNmoklKd/IHG2yjhKjdt00SHy+x3QPE=;
 b=CDAgZj71ErOiKLHRyFQulnHdliV+PjkNj4nygM9iCkFiTVmSGj94EV/wYwc0PFcn8b6Y
 M/X/OmXBJKInm/vy1zj2Ay4J/hpoOwmtla+L0c+uWt2D0yEmhclN5ZZqVtW6yl0NczEW
 1yMum2JWs1I4x0AK5K0rEUyBYVwf0Ua7rUj+c8/YdjL7Xd4Jsycj+gT4xbrYu+ESNSRS
 KMFHRJc46QD1zlZJPYWWB0dnpG5z8nt1UeA57dz1Xy4GXE/HSN+NflBRmNKBmFBQHihF
 8u4/MV6VXFW/sPVHEAhKgF4LuBzI6jJbk2B9b9jKUhxM8ciHYP2Ms+rLq8Lzq8rMAJmK ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wukkma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILqIbJ012157;
        Mon, 18 Sep 2023 23:02:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t559w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi5QzkES+XrJq3qT+8OuUnB3kyFoDqOF+hzEJDUbnIv3/XlVK4c2x4Vbklh0twZW8av0NTAPvv+c/lnHeBMbqdckNYOzKUENBqOsfJLzx5yoTG7P/8fO6QQsUL+sJhVimeO2e2LhXUguBn8vf/9B6i7bN5h71T7k3ethT42SRK3bvRyXtNYggJv3+cgg+GqsjB6dXGXBFyrbpBV+96jvFVJUnHCRp9X+FQYulN4Gb+zayUonicefTqyRgoBJfVoPuOgTEAQ0TlC9Po4p5XlvC2p6a4hpD/Zgym7sMcUlwxx3BwdaSoeOsHLMpF+m7sfA7KHQXOjIPDEhkGEkbutClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kABIFJps6jWnNmoklKd/IHG2yjhKjdt00SHy+x3QPE=;
 b=lLB7F+CdYYMESX4V+7je+Rcw0NMJcLjdQZrH4BLR0kfa2NrMu21RQwieKUOvzTtDMUgXiiWLMvwJi7EJNk7PnXcIdD/F0c4gTSKh5X0/zIu6axfmFNUBlOc+uk4chvP7XzjU94yLLmOTKUvmRpI3wZFJyX1eX17+cYG40dwKYM70HvzQOJG+iuFtOfUIUeGBnsEc/Und8UrAhgE2mUOb4E+fpTPuciGsX163e1YDH5qozrXuSoTmbxfrfnOvy+Oemc7jXl/+YjKYa6eRuCyi2zsJYtocbDtx+WgS6WOmqTf3p7fmLjm67C9vo3rbu5EQlsLuZ36O4r0q6yR/3qsCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kABIFJps6jWnNmoklKd/IHG2yjhKjdt00SHy+x3QPE=;
 b=YvoVIsxSjSqbaFj+ktzGHYM9TKs/5CEKqyV0x7r7I4yeyZs3KFaK+vLbjt6Np3sFs7gnVj8ND6Hq0InnbChiIH3vXkhk22TeTn1BYliDh72/Yi5zvsQaCjhaOFPTYkI/5wpLrKycDtTOXBdLCwwZSR4opycmUqQuGZzj8wVjmxk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:02:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:09 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v4 1/8] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Mon, 18 Sep 2023 16:01:53 -0700
Message-ID: <20230918230202.254631-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: ace0880d-45ab-4a19-8c80-08dbb89b494d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRMQzPpi0Iic5phrplDDjWnPBUoNuxee5doIL0gR1xS18MoXnnc+Vyvbe+bPLMDgArHLW1+FidYpDP62cDnO08S/6XTruNvX+aSHV30plrO5DOQxPY2ok4opSXQ957xlMyylV0rY30+PInRpkprotih0/2agpliPE68UIEWzLfb6/jmjJWFQQNp8WfNKD7mia22UoppF9iKvHbdy6DjZKNBeIebhF4W7djtWmv9q4h4ODhHUxXbhI7UEgSCNnEIyPeX8C1a3k41QBJBIv9koAqW3D+LrP79dE5+cWSBR29WUtbd8cPqztIML+mQbp905WEtM+8kVHT3dB7mnMEQu4r9s3APBTLBtd+San/q4HJBxVImCJMENajPom2hz3uvOX0nT6+lM9LnESXP1aUhjY3bTnGQoGpgdyuyNI2QRfO+6Ij/XWe9wOUl2zC0HBM/PNMSfZvQEQZ1e2FuabrLiXYE8NMQptL7RsG2hmEnAOD69FSsKDKcIPvdXLOGwa2URrK/x9jFovBpJpLaQRE8Ag8L1kqAJBh2EZHL8y8yQtHnasFOcwAD/yhJkeHOu2Kex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(86362001)(6512007)(54906003)(316002)(38100700002)(66946007)(66556008)(41300700001)(66476007)(6666004)(478600001)(8936002)(2616005)(26005)(2906002)(36756003)(8676002)(1076003)(4326008)(83380400001)(7416002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utPZ8mDndgzqmnKPjbFrv3zI4L6D/qKFVuvBMMWJb/5meaRK3/9H6jHC35Pl?=
 =?us-ascii?Q?5hIjTSlzX2SkpW9aH8EeQXubPqLN2dfyZswAT7pQnS9SBUtXFF+dF8esrqOL?=
 =?us-ascii?Q?nBxfIYYOUgHDKfuKp8iNHFlnzd2R9fphEbYwgNsT7tguy31yAUvm0rf5vKBe?=
 =?us-ascii?Q?aMRmLKiW/DcVbeqN/G6jkxskgZY4N3SKu69guWLbwXX2MDYO0hsp/dYkO3Un?=
 =?us-ascii?Q?yJlAiSaxt6KTCOSEaKbCVJ5bo2vZxSdtl9CO6jWjsnLM9x3D3ohESq+Jtg5n?=
 =?us-ascii?Q?vkIvUBUbY+pUgM/d53NeUGD+BT5DlhAvXLZCSBKsXEhA8QzuQm0DT59S1xRo?=
 =?us-ascii?Q?QkWhuzbgrZlfYmX/qrhEOl1IEh8oqQ4RysHPGSriV8lPqD1lTaH7+bz55ZaU?=
 =?us-ascii?Q?qPKtn14f+opsOLfa53ZkvSZV55Lw/urxosY5esl4dZZ6HznFu0TUbZ9NIZ5h?=
 =?us-ascii?Q?l74T2ImUIvjKAeN4h05vr4DJfIrBIpPf2Fx31LhbnIhoA92coeGf6Vukl0ae?=
 =?us-ascii?Q?ZdFRHnnbmH2I+klqlThEy0aE4rIhg+3ITgGNPKq0PHInrU3IWeZKy+YP0pDF?=
 =?us-ascii?Q?AljaXSmQA6yFnHOOOZSXi28TkHasF0V01a2my7Sj80w5QSh53nh+JUMYsgUf?=
 =?us-ascii?Q?9iNC6hDgeh/Vvh35GcRcvALbo4XwWSS2MUmfHKO6i3d1RpdqXEhK6ZmABm0O?=
 =?us-ascii?Q?auHl3us4Bl00sscoLW+Hl4+8JUaT7G8EiM6r7Zos+mRGCXY4BYgeWUnLrHFH?=
 =?us-ascii?Q?nK0/Y3QZsH7C7fmpRTuoVDEzDztzUtDb3djMTQbFXw9bY57E63T5dFojgh98?=
 =?us-ascii?Q?222eD+TRytu2/2RWz8Y8CMxSAS6OmcK3vITD9dIoufFnkPaiPjbxxKbA4EJ+?=
 =?us-ascii?Q?FL5ytomjZiCG1HIySLWHMYevfrAWTMcqRdYIWPmrQaHYLNMZVA5z+6yY6qwS?=
 =?us-ascii?Q?tE1LJkmJLH+f7hHxV0/4yWMV01THUtES1erNn+ywzS8hf85NyZT4td8kX6Sa?=
 =?us-ascii?Q?G2FkrLkt8aqFuSVoc8D2LP9DKz4fk25JpkGk4UQoYjSfA9E46eUZ8j1oj4Ex?=
 =?us-ascii?Q?XEzxRCvb92gDe1cWU5q0kBivcJiq51kb8XYBNw6BnhFy9xIoyoU0VQqgfUl8?=
 =?us-ascii?Q?NA2HTu1tWH96DkkkCOOMHC4SlDfluFVVdGXLZVZp69Ub6fpMAb1Sad/eaE1X?=
 =?us-ascii?Q?X9KBRlPfif0c36DfpqKVVlPigj7Re/jaTRsgha1UKeRGxpgFutyky278WwZk?=
 =?us-ascii?Q?ZO9fw8Tsp9d2HS3QLybvKkT+uiScW1X+bQt25z0Bg+u7llbPaHHtVkUfNrBc?=
 =?us-ascii?Q?sJTUO5dJET4UqsDCBoYAyPzHcdHSMCAoa18cB3mRnJHWu87N7P4pBewolWZp?=
 =?us-ascii?Q?0Xs4eIbWKo7jbVi//aiS3m9/lj621hVnSeGArZbFFGdlsqgNIyaDbjgAsjYl?=
 =?us-ascii?Q?LyJLPJdGVlKiUxP56zH3jdSHnFBvqLeu6k8gpfY06Y/JVJHGq5bb5nVUW7BO?=
 =?us-ascii?Q?M6cbFYLsLvPBSQc69AHbOQvFyts69WetIfiuVDvMsG34Mx6PqhI7GxVmMcdF?=
 =?us-ascii?Q?4Ffi1CzyLkwovIaMiguyawq9ff65aF6ghgHrdH2y5xA26FcjfAP0ahxHfJXh?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ChchMA4CjwvCFCXHn7Sd5VLl/8qin3KO0+gH6glUSKit1gUwa81Gyh3S8x2W?=
 =?us-ascii?Q?m/cBrE3v+gWeMg+OEtYUq3SBiWpBoFz5BulRD6mvBzbCsEyqdvaIgljjJnHQ?=
 =?us-ascii?Q?7T7PO/To8kZ03yO3IWQ//Aqymib8feE8AZ9KrWAeoBB94yo+JkZq94qgdJY7?=
 =?us-ascii?Q?KeN9ASBr2CaOJJs7hrexRor13gyaIynHgzOrgIBaOyELaky3ftyRsOPzvLUT?=
 =?us-ascii?Q?U3Opa57ei5/m/GH8D1a/qT83+vd/CbURt+Bzr8j9CZhM918bXB2KPNHAAQrS?=
 =?us-ascii?Q?NpDkt6Vxq4VhWh4/B2wiDE2AhciBqPp3VI7CoSnkEaRalJRCR7yVHf3FGZbc?=
 =?us-ascii?Q?fWFnwOwHNDNTNoNSXUMxRM1cC0bep9NQyl1rH/9OfHg2gkXiWOmFSbPPGF9q?=
 =?us-ascii?Q?NvP2XpfOzMw1i60kDp986r+TyfkKxA0CnIiYW42frx5LiJ7q1A8t9ppeIYV6?=
 =?us-ascii?Q?g9LBKv0lQU9g7auDv78pLXjH/nlpf6HHiAcTS5IUOaHOkZV2qMYglgOfKAzz?=
 =?us-ascii?Q?pjpG1t08AegarZiDTIMs0mWkI620i71P0Ohr2y6Wuek+3KZdvskkFzd3nJEq?=
 =?us-ascii?Q?t6PNx5cgVCxVcDMQSrMTAEzUbA+kp6ZGUqYewzHVeh+2JHLcsVNmst47A+Rn?=
 =?us-ascii?Q?2Mulmn00RLq+8Kve5K9cYCINVQeBwdfd3MJd6zcVocxslCtD79vxZFK82sZ+?=
 =?us-ascii?Q?Itka2zksxlOL/nZp54qA2aQOQjYvub9/DOP1ia9qlZaRHrQu/yAghD/O6FKn?=
 =?us-ascii?Q?EtJXal2T7EERtMEQk1DytwaYHBJM0yoyyjpB8Ro96W+4hcQMATNNekT7xJMM?=
 =?us-ascii?Q?uy/SpuBX6k6bWvk7kV7E4xJ3M0UQ7K9JACiEwmP0FPN2C6cfyCdOTmCvp3U8?=
 =?us-ascii?Q?hRrraYPBwZJOLjWP/RrzFdBFuW8ESHhfXzFV8Q+UMmOcikOsfdvpMM5kMvix?=
 =?us-ascii?Q?Ow2mP1R/JB7XWNwceO2DTJUxW5bBUFjxhBQF0UM0xra5TJK3GU1x8nkOx65k?=
 =?us-ascii?Q?EQRoCnlCdMx4HfZNEincv82EbaoX/yJTx16a9DeLDt/9UgxdGsDvY6fCj/x7?=
 =?us-ascii?Q?wUvyvUlY2k3yJRNfIE+zLaz/thTghL8KWiZ6Jrx2pDuzW0NUfb7W6U6Eon1T?=
 =?us-ascii?Q?uj16I8Sc8cHB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace0880d-45ab-4a19-8c80-08dbb89b494d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:09.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnetk6kIeZuYV7bNlfMaG/6YFxrO8oyxjHIo5rlcXzuBWGTGjlcc/w908gW+wHCcHRX1hWN7gDOJFGq2hFtM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-GUID: dzPeiEgd2R5qJePP3nKocY-jYQo986Oz
X-Proofpoint-ORIG-GUID: dzPeiEgd2R5qJePP3nKocY-jYQo986Oz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e2123d1bb4a2..1ca0377c62ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1837,7 +1837,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap (if necessary) for all folios on
+	 * list.  If vmemmap can not be allocated, we can not free folio to
+	 * lower level allocator, so add back as hugetlb surplus page.
+	 * add_hugetlb_folio() removes the page from THIS list.
+	 * Use clear_dtor to note if vmemmap was successfully allocated for
+	 * ANY page on the list.
+	 */
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on any folio above, take lock
+	 * to clear destructor of all folios on list.  This avoids the need to
+	 * lock/unlock for each individual folio.
+	 * The assumption is vmemmap allocation was performed on all or none
+	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(folio, list, lru)
+			__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free folios back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
-- 
2.41.0

