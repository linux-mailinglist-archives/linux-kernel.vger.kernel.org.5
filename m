Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C059788F23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHYTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjHYTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA22690
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEo4x009220;
        Fri, 25 Aug 2023 19:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OlqrnYCf/SWJqiFiZ0S7D0zk7AgEaG4b4hT8Gbzo+AY=;
 b=ei0QlP/+liCl+Im+OJXOaqmMYdMvDMx5nDqljH96E061eLMvfbYZ/PxX+5QzzsjOgAAh
 JEEo+g/nFYdHKCRv+Z22gdLLEN+/CuNaLmdrvCumKWlTmBZHCl/9r/YXtNeq6LDQkShv
 fRoKJaWc48RsojFD1ktAWqKdr7oPkMYRjXbpdlZHLDO0k4MrY9Lgt4Wf/Uzut45LqmRs
 HqzaWMY5gqbVrec/PBgZ6tIhA+rBdDcl9XrfjxNS87kJuhJWYkEY8RSrdA9aGQHn0ezj
 evEZlbzEGTPY4KrPfZlHcIDzrpJ4kOp9QgnGImLSW/f/JdEVI27cppH2FUyV+Tojt6fF DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20df0sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHGikX035838;
        Fri, 25 Aug 2023 19:04:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yr77hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJte0QNpO8C7kl4nhXIJxycgoNmMOs5bFcppURIfA1qq3ml2kW600BkPUL0NxquaeXoEoy0VoB3ETUT91+rvScI0R+dwvaUWrDp3YD3qLqUGhyzQcEWWvyPx9MSJg2C5eq8JZ5ApGvJSpPYy8dNYGCJgHbuJlQgnPGuIjWdW2nsIMZcvt+So/Ej8SYg6M43ELZgRev//98BK+OMuaSXFD46tEIvjxiXY1i+aFMIf8YYmO7e/fUvMzLndV+u/LbX5J2cEyURGUOyRnV47uTZ/aINPMkUtdH2vV2pTVBpDoQtVKXxG367mnMzABVne6n/hwYn4fchUDa85BNXrMJ/SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlqrnYCf/SWJqiFiZ0S7D0zk7AgEaG4b4hT8Gbzo+AY=;
 b=WO7uGu57sbCaKFXiUPYaF8rlHDkepte9SQHP+61H7kNq8E/WrSA1S384Zrc2E6nRt34jHSEblIkmtIjIVC9Y4GANvxi28QtXJoD2rJchDrQZkoo+EmZJjyzI5imFsB0Gk/Z4cFb30mifFRjgfONmPAlL4GGelD7CBV+pOjEXYcBDbG+aQdn5zfQfvshlpdHBB/tesgWiSefFMKwyLIqHUaurUt8rER94BvP2Q6X0MdfjGgr2lVTXgIQX+X4Pjv7y/7zeeQ9UJRT8Kdj1BBxCwnn5qagmNKc8x99UesmLCqtXT42JUxuLfMAQGbwnTxSjBpDVBcm+dX6ORHG822O5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlqrnYCf/SWJqiFiZ0S7D0zk7AgEaG4b4hT8Gbzo+AY=;
 b=So5lE5/0YT4nQSyNfRykSNZfpIQqGHvkWD3KrdDYJ58r7cThwwmwY8Lz2hudWbZoKs6OMaNov3L6D3cgvKLT5+URnMv6GESizIA2osXpCsnnZSrsx+yl6YwBlKwtcSSY+LoeGqghopUYV+3MfGy4clwaXTl3858FWXARQRJLrJ8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:04:52 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:04:50 +0000
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
Subject: [PATCH 02/12] hugetlb: Use a folio in free_hpage_workfn()
Date:   Fri, 25 Aug 2023 12:04:22 -0700
Message-ID: <20230825190436.55045-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: c2eb6754-8598-4f6f-141e-08dba59e2866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFQROwA07L7FLFzZPKiExSpb8Yimk+ggo9TaCdjXGdCMBTV6yRktwGkVDOp9p6SV7QF1yc7VmAyfrYFDmXAgNyNqtZaS/Qz03ABJvxzd1puw8B9Y0hE+z4EOUWBcL9NvzMq1LtGA5SZknjUC4YfEy2eNTZQTIv6P8G4XgLJFJ9O10/x17kZdlBtjKO/KTe69ssRPebbJ5gfcOwCexcf+asUwoF/zCz9T+5g6DgoBFqOAWeueDdPK5I+SqMWqNUqv1DTwrhhlbvv5ft5pi52yfRUyOSI/afuitf2m3AR4bY3AOYvxqtuxuyhYKROYcU5jvgWJdpSmXmN1jvYm2ywU85M9P7uWyjMhaCFvIm2XPMhRDp9pbZSRB+UCmWdJ2HYMHrni/yC4S0xJ0L4eQqvtuAX/sNkiXstQp0mUi5Lato5zhpxEwPzXpmtRQftCh8v2GswbtHBgRunoYnHqxbwgOudOugJWgwhwxqODe5eMlJxo2+YESFCbIaL+547jh/i0UdCR8ChutF0zLGLTSi48sxfoz6/vmptiVDCUw0gmp79HhcJ2s3OvSEDdDd8kTPde
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxeMLk9UYBeWy0q4+wFMYdUexxnmDfa9GZaIKj2Qx1EJ61G6G6pMIKkDiyI4?=
 =?us-ascii?Q?vaTjGjAztj7EqgLQu6HnqDik7nmOH96ohcG0WTO2AZ9S/OS9L137Es4TW40/?=
 =?us-ascii?Q?wYc4r21pCHX2uYNqWstK5FyT/1V06eMYMFSVfoH+3/+ebpeZHpkntYRTn2CW?=
 =?us-ascii?Q?LhuKJVkHgTXtqKwDuIQtacaPYu9e/mynh1B142QKBBt1pdptd31UoRu906Wh?=
 =?us-ascii?Q?lkKqKT/BOeTbe/gjqZYup6R350SZgzNf6xYDgwcNLze89TbXoSZYo6DEunLg?=
 =?us-ascii?Q?Bl5vkLMRazqqrkIaElqWItKgl5QNlhAci6V7TMfa6/tjdnjBIb0J518flN0B?=
 =?us-ascii?Q?ev5wbGf18fAos+Lv22geWIN5KKc9/H8+fEsvL3HQU7bAuzgQ2GjTeR+/FAXn?=
 =?us-ascii?Q?Cix8QvvGFxlCNICmuXGrhuPGSzq9Q83ldfIvj4zp0RhPQjI2kQb2XIvKL/z3?=
 =?us-ascii?Q?ubTSwDAolX/VgT8WzNW95m9NUO/MvLjItliTr95FD4odvcZSWP/HnRffx3oU?=
 =?us-ascii?Q?OqthoAkTUB6c+7RDusVKYIP+x54FJFjzvPY5r36Qd0MnvZmSyo3bkQR9vuvM?=
 =?us-ascii?Q?xssAisngPn0uavhSMXTx4/yU70v4AnwFBGvpfHxpmfGh2GzZZDNJ+bzg8dEX?=
 =?us-ascii?Q?+9gZuv/vogdSDwXRrtqejP9y0ILUggthfIns4jGp4pV5ExFh/4uJLAjv1M70?=
 =?us-ascii?Q?PDs0l/8PpjmHXFbHpVxnnuOiFrCcvPN708lOcEmPR0KmuiHrrhuusnc1GDCZ?=
 =?us-ascii?Q?3D+RwGpdnxlAF0/orhJnWhhsfPtEvm0txP1zSs3ix1MrvJ1vBqJ8RziVxuBf?=
 =?us-ascii?Q?hpEbC++Je0zIzk92/17wG7FEOgMD9Qe48V/Y/+NP6Mu6Kpa3gWlItITjykmm?=
 =?us-ascii?Q?8I4h3uaml6u1kYTSJBvRr/iZHsfvSulP1FSdKIILZC4jwvk/I89gS2cgYDr3?=
 =?us-ascii?Q?SGc4chH3cCgQl6v89s0dU3X0xa782+DkRWcK89iIz5BbiCELtNRXlwzwak5Y?=
 =?us-ascii?Q?nWmzVFmTcP1xULD6Ni5ETOQrl4Ky8H7eQ1z+7Ru27bLxp8Q01fPXPHGVYhFa?=
 =?us-ascii?Q?CV/kQhdd1Dx1SUCOGGgQLYQ+MFZodkSbs6ZCity6H5eI3Et4wrDCMd5qf6m1?=
 =?us-ascii?Q?SYxmwOaIeQoYnh4aOaRlCLlR4ErCFGqfolGaTXbAFoM0hLpUlsH0LRGX+70x?=
 =?us-ascii?Q?hlJCVca60nUlzldGIBWqhQ2xFj5KFApnB6KGwuhUQdI3Yix5EkaJOp0Oxilq?=
 =?us-ascii?Q?8SXxcvyrXMHy/ehH350UnvSrGAGhD0MJRLFondI5RBYSpXPkSwcmx62VFz7I?=
 =?us-ascii?Q?L2BaQtxSrDFJKx2DMABCphB19B51kItFSK+AaOrHyTzv1cbxVY7GVIzgsPh4?=
 =?us-ascii?Q?/QicvifFL2O6pnlrVIW/f6k666h/IkIpl9PZsKvIvQf0cqmlO2fIc0+ClAr3?=
 =?us-ascii?Q?VRPXSydntt7sJlHiKif+ehlGKQ53kwgTZuSvC+5Fe5Ok7xL50X7FnFCMtq1J?=
 =?us-ascii?Q?47+fBGmnJdnbltjkRtDkOaoPiKp/LuqxqOgty5dOaSRVq/yQWx5fD+YjJ96c?=
 =?us-ascii?Q?qZH88VSOm+BE7KMLPHRm933Qhb2PABPNtnWO9ajx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ccOTViSzUa9HtmR/xNh4+bgnKGrvIrBz9idEXsdlqDDDxGIBzTAgFMBuS6Sq?=
 =?us-ascii?Q?gPPsDPUTA3M1OJZE2RTNp/SJNePEDnFAZFTFZ5xjW7EDOsyB9xCRgr7/ghYH?=
 =?us-ascii?Q?2DKVoJM+5hzU+tz0AxH6bTuz3wOb6qy9/A0uhGQefez7wGzWdMl40xIm7Wmy?=
 =?us-ascii?Q?srRgEIM1ZpvehAYSVsQxRRKkdkiLE0NdYEX6TSNF7z1PRsoRmftg+6Kj7Yuh?=
 =?us-ascii?Q?IA7iBmg3WCU13h7NSEKQkdz68V8nRgIW/aWwmy21lHjLzZhUemLaUQbiK4XV?=
 =?us-ascii?Q?SwQCHrGRCurRctI3mC0omXiv3ELoPDNMqHMHPepB4Gm0ZsCgLbXl4b5mMmHN?=
 =?us-ascii?Q?reFT6wKSAGyVNX7s/GyEkqZVy+pVQTsz99bq1eEzQbABPnSrxlfQou92FZnS?=
 =?us-ascii?Q?MrAv57a/N9sWJjgjD+UtemGs+pYNMxNZfoXzdKz9PHHPxS31uAAiMwxV8Jyc?=
 =?us-ascii?Q?4r75fWDajcDSMANPcusySccIu+hKTNNRlKbkL4AXcpKgRVdEsV00D1pMqMn4?=
 =?us-ascii?Q?+fRlLugWjRgpRSePZYltUEFy3ANMB/N0ReQzxPIttXygZefLMf7qS9a3tTJZ?=
 =?us-ascii?Q?+/kTsWoqKDzOAdABmLYVJMWccbLcUm1k0B2ksTKF6qxP34CNibINF1OQfJcQ?=
 =?us-ascii?Q?5BJHNlOvKKAaDvv57Tc8hXbJhdNaRhyewuGRzhRdVUhG7NWihOe+pp5/Y6Bn?=
 =?us-ascii?Q?tUpwmTOlmmq5sipcvTWcY46zQTK+Y8Z/zbdSiheLYI9PJtsd4P33aeUMh78b?=
 =?us-ascii?Q?hnuX4KonpJb0EpSdLlfFg7fckw6KsDxRz6w8gDD2EfyaUeJJZLiW1m89x6O5?=
 =?us-ascii?Q?IyOqnScoyvvY2dOrR3rnIQ2zvofhnOA65Y/BPWU9RpsV44zQMPIJt/A6/MGK?=
 =?us-ascii?Q?G6bFVrHoNvGh9G83p/RCOpZS6t0JJJg26EGeEr0UPkmzvGnRrU8LaEH8kxbw?=
 =?us-ascii?Q?NBCr+EsYjscOHip8dPjia/TuyQ4iTkzlSWY3IYAcgq+ji06Ss/IBnIPd2wEG?=
 =?us-ascii?Q?UjnVQuQ8qn2KqERE9HgQ9PzZTGO2IEDCAaN5QGsdSJlYtJbZm/r+FRgdQ/ue?=
 =?us-ascii?Q?BKK91T82BelwsspUavlcXBln/U3xWnDVzYx5SY2VW/kJTBZNjMEPFwNdfzKS?=
 =?us-ascii?Q?8XQsQDGTl8Zh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2eb6754-8598-4f6f-141e-08dba59e2866
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:04:50.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11krfbWWK/fRLYx4h8qG5XbsdxH8bVKXh/0SrgMH7+r5wvpd3KV2bb/vR0HEkLJxb+7rk+NMUsuNnBikrqP0Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-GUID: RjUyhRaDvbDSPDQPjxjvqQ7jGG8PRuKV
X-Proofpoint-ORIG-GUID: RjUyhRaDvbDSPDQPjxjvqQ7jGG8PRuKV
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
index ba6d39b71cb1..1a48a83846cb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1782,22 +1782,22 @@ static void free_hpage_workfn(struct work_struct *work)
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

