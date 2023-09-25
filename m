Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF307AE29C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjIYXuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjIYXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:50:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65F116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNECG6011832;
        Mon, 25 Sep 2023 23:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=tTkyREEus1vZ0vrDzN8bPKtzQKfpAiGC1GOGPaIkTQapP39ASs7lLyOyDeufLNRhS0Bq
 mLyLV30tsnRIKhGGCcZ9F9+OnCGxyIjWYIhvoj7jeR7bQ2G/21PoLxrzx3PxR7dkt68u
 zJAkC9rPtaWVEqSAaaQ5DTvxU0CVJmK5RdfNL9Qr2eS57H0CqH6NDqqcpCJu/cpYcAp+
 HmwocPBprZp4f1QkA9sEaUOaeWJi+MogV6ekyWxuy1flr6PuTmPdpU2d9HWiSpiIp3uS
 0jtEngGWVq5iwYwk5sm6OEVdA7zRy0RSTHMOPNe0qOOI9ay1Do6UMjQpPqonX0L/f2W2 DQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjud6cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMKL8A034986;
        Mon, 25 Sep 2023 23:49:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf5ghug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZwOQSCPCLhjP2+ylha47wYrCIv9Z3199JZ0XiV9pWPR+/tYvLBBNsp+8GRXLg1ZgVLiMCExsHoAqv78pAOMu5SqNYO6zl+DywoTncYllbdyKsf7iMyDY8X/BllCK4PojzqnNmvpJJ3O13/oTvqSfhOk3GPUYeVXhp0/J4ANfljq/shKLPhG+dCkscyaXY2Hj0ZOTwvT1QJtqwEWvLqIK4VquQpRwGFb+aM8QdbTj4/QlSJmZ5VYewJ6ntraA+0V+GashGWk9N0d/cHKH8x7KPxx6f9hA2h3A+XmVIEFA+dXgwE6Hw4lXQaYeVWGuRzNq15zNZaMBdo+OOT65B6F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=Ni5vbv/L8c7keanSmSajLhytGwjKnN07Ff40hUksPz/wRiI+RkTahQVOzot+aPDW/SF5f00H9BvFrT8D/JunecGfKmdBi+9t9x1MM1Gg7cnpLJsuhE3mtC4ba7JrTzFHtxdmkszbOSD0s75zG+69B+18LVB7LQty/Wup0KtR3+lQMLk0yslAFGCAdrnYI8msQglcYDo6uRcRVW48SPURYCPNakONNZ5xNRr0Lbk4nZcrHJnP8aPayRtzK/xlBJ1ucAOOHRETfNgstjY8HRMBMtEDOYbYyg2Eu5rANdzS/gnDT9KfyTTVCbPFu4/Dij63sy0qmb16XuJqBg7yEdJ4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wop91Vn2thHKTczlqkauN3ZgszKMNCLF+DVzOTx6zso=;
 b=xHO55F1Y7vpmQliU/v5oVMTf8eqhsgbGIc6t4ZsffPIPDe9aR9elk9G/RuncmknNnmYNzp7vjORz4DkavSaBXFvR9spKy0VDqINCiL0u7NOIcNNyJN9B84slBy+tWdyNr6WZlp5XG/s+tApQlGXHYGYvY0Jw0hFzuRdVMhl5zdk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:49:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:49:08 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Mon, 25 Sep 2023 16:48:36 -0700
Message-ID: <20230925234837.86786-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 33069808-d3ed-45da-3aa2-08dbbe2202b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzC9s3jxM8bMObKUzSWGxl8NtcI/OTOVbEuxSL5Svf86thYIXYr2PAKjD5Msdj50wCCFI37gwqJpCPfmJOI5aYKBqjlC01sULB+ty6VGrkLgGalomTuKYgubXtSKIvEzuP3mhh2flklVdlPUU4fThjI61FKhDSlkgnWWSnL8nQ6hKMxf42VD7GBKAqa5KdSej2IkQddEoiP1wingXCgMEwjnc2rxCY5DNbLiiolti7L0DzXZ3MFQgIr+1hz0GsXf8kBF3WIrN5vSFfs8w88HiNsvmaAZHvAa8uwWVD3AWteAfeom12DhnMwG07DoyyXch0kjDewxqzH8CAkr0fh/fH03RoS1Krx+TESER11rttTrh1Sq78FIzsC4xvZhEqre3XjD2R+0d5KVxro3hSE+RW0Ogj0zkDc8Ne7t2rKBGWxKWMuI7+FRmcCQ+spRRnInr8H1typsVhRwbY+10OZSUds0Z5CaP3yPZlqxVEzu3pWdcn7ztfoLVP9Jn15oF9z8lCxdu6u92yZhaCvpZSneuflWttURHfkivolMItf8F66X5RKz7aiXrXga8SnoqGgf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRkVZXgshpr0ZwNWrmijfqP32KUN83tktdmkDcQkR33ChILvoMzafRauz7t4?=
 =?us-ascii?Q?S9g58+TK0xU4ygKKYloBhh6yv5K/tbjs/v8F7xXOP+46LENYi81JF3mx3b2k?=
 =?us-ascii?Q?nGApkvQpOT6I/gdC9N1PVQY0xRPihh7a9RH+z6hstJIUPLQNdG3e0xADcxYg?=
 =?us-ascii?Q?X9MuNp164tKS15Zusu9j3Nks5B/0OOGt/yJn0p4mHMBhhNtSdhETFLJFIPW9?=
 =?us-ascii?Q?ghxeqaK0cGAzJu91P+41BoRygzvCWQ7ZA+4J9xchemn49B2U48LuhgeJhLUI?=
 =?us-ascii?Q?oCaMI6yCDGkmY3k9o/nnqcqrDMiXPVFtbAPKp+Bc94Z/7YYDigQSqfawtbL8?=
 =?us-ascii?Q?TFJhYjDtjmfxB7U+Wakh2YYzELIilBBEjkyy34gXsIZRgSuxkj1K28zHBH/X?=
 =?us-ascii?Q?bDMXAbjsn0ZqC5v6DFhvYvvI8Q4catZDLayW6uzKO3XijQGQmkZZG4rumaSz?=
 =?us-ascii?Q?gcraKKujLiC/fN8QnarZKL5TP/pSnbhlmxLuJlxyyVPQNPKqU/m7buViyt2W?=
 =?us-ascii?Q?OWK+HD1k5848bjBQFvl4OF3BVmFCMmU9HZvWL+m+Rn2fves/KyMuBrtmClsY?=
 =?us-ascii?Q?nBDMuonetf8ZlplkxmiBEehOnSVvUD7inrp/B5rkVqNKosL2IHXZuK57W8eG?=
 =?us-ascii?Q?aLww3bKmjAZGfnfw+IeMjZLHU1WIgfSoV99Egfev/akJ0kvOJJ3bAu7criGW?=
 =?us-ascii?Q?u3nZFt8zl7aAsFwnF5R8XcsxPo21vcm1HjPQ8K+u0S6j4dD+0p8TbxeNNt9c?=
 =?us-ascii?Q?xp+3leIXnf6qseL9ccQc/bu+lJgRk7Ulrf8M+IqEnATLK0p4bBVcPUBhi3uN?=
 =?us-ascii?Q?Prn3PqX1PLc8aBDExi+ddmrhSG+ENt1qoYI3tZ+YfYkthgZ22X8VDQAJDC+0?=
 =?us-ascii?Q?lnIXrrNS8rR8nw/taPhZWpckJxerwglwyZUvFfmtML5ko06LhHdQQlbiUG53?=
 =?us-ascii?Q?DztZYo3WyRKlhsYwWyeHffbZ4fY/qmar8LVefl5um8MFVE8tMW2DVKSGRNxR?=
 =?us-ascii?Q?EkwILTsdWjKHb2/QaFPUtLC/bX7aOzcoFFzsgH3bN3BvctiuRCV9ODWJJ+iX?=
 =?us-ascii?Q?JuYBmtY/tVSXoCJVsQat726COoKS0J3fXy4neZczeHLZJS2SlWOIeRE6cx0X?=
 =?us-ascii?Q?ZDs4EGaYzeCFnQy6X10x1vltZZ8HV4vNwqm4YkG+hOQeLlbgMd9R4xCZSNsb?=
 =?us-ascii?Q?b5ORh5q58uQ0U4Y86OmQsssNqH7cuRYMbJONEkMdUzZcjJGKjr8hlAuTCIbI?=
 =?us-ascii?Q?j0+16l8Vksx7utfRMrP/a7XNAs3c4KqeLufMdM8fKQNhINMbylh+11BtA1K2?=
 =?us-ascii?Q?WsCZdb593NcAW/ehT0eVEPGpHZj0I82cYmhewJZ02fsUaj94eSBchi4rId/W?=
 =?us-ascii?Q?Co2l4g/5UXD5gmU3vOLxCCa7OIVClIuv6kYha5m6d1qcFhNs26WaicaFwTAL?=
 =?us-ascii?Q?Wt03mfpaTrtCHIBZPtjPEmMT02kHd7s4tGkZcTh6BRU7/CP5u7kwnIvoUktT?=
 =?us-ascii?Q?TX6T5glQ88+TGzmjBuH/68fxGM5qXIxMppefPhexvzoEqm96/4K2eSaMJzSP?=
 =?us-ascii?Q?8OvVhTDBzfTjZ4BJdEt9fTE23hCxOKsSKfnW5OEaizuD0U5QlU0ODewnb28b?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qzbJk0zHL3K4reegkmZaWVWTpGKn5JHySJvVXe787q+2sB/zMvXJUWshizXz?=
 =?us-ascii?Q?68fvlgUdmaobfWWwcRF6d8A/c1WrB0bC/HpTwc9edUgUmNAFHLD/MUS9+jCj?=
 =?us-ascii?Q?aZxHy8GRMOkS4jaMnoyAWNdoGr+FjcJh4ol0a5YTrKoNW67DRuOH+PmWJAqr?=
 =?us-ascii?Q?9e1nQzgA/ABw4RwByt8XPNEOWaHynF91zuNgFCG8qeADUiIMEKfKSYley5Vc?=
 =?us-ascii?Q?6Let3m/kTQyTdQXS97kzLMd49uzfVErerW5V0GYfniPIXpFFqC6Y1j8ky6SG?=
 =?us-ascii?Q?oRqWiWF58u7u3gkAgIvPu4935wJXu1Jm0cGwAVQCblaYypXKvOZ+a/fjwOGp?=
 =?us-ascii?Q?aQ6H89A30F2ejKOmcdEx5g9LoPl/JsEA10G4jxtc7orI7fZOYl9dsfa0ct7I?=
 =?us-ascii?Q?caXIwdOkPlEanAWd7CReBhcyZqeEFqD286R5kfaQnW1JTFgl5rDiLjehlqtf?=
 =?us-ascii?Q?DsQzqjbo1Hs5IkoMDAsP6xkJfI3CspfrasS4pz4nmVpuw4jQ2qjso0jaly2V?=
 =?us-ascii?Q?0D3NLysuPf7GybrcV4XAIIMqnOvdzJfo/OZUavLBpdeXA4aqFak7PS6FIp0Q?=
 =?us-ascii?Q?hBWLHNckTIz89IQ217zgX1c/7FhLH7AYBCr2DazeITtGrO0eC85D+UW4kJF7?=
 =?us-ascii?Q?0PtA1iRKdcgi+AloECWfAVsLb6fDRpbIUKgKNPJa/MF+mUq1AUZouqwkH30r?=
 =?us-ascii?Q?BUPPx92cpFOmEwDza7JQgmRIN1LgF+1cLcUJUQMk/QxkCuBU1yCRSDtfFinJ?=
 =?us-ascii?Q?qm4VAMcMiMOCvvWuQ4H9xtnQtBLkSkO8haIfUkhzY6iJ2i+I1SZQ/DptKCbq?=
 =?us-ascii?Q?B6H4LSBJKl9RyRLrUgkU5lmhJFqprEF1+c2LxO5/ajFL0AfH7md8CwF3aoVO?=
 =?us-ascii?Q?cfB6tVAsmD8md0s2RSS6HkbPGrgOnO88CA+Dg1SKLFcNJSg7Hm2Vu7rYAyBz?=
 =?us-ascii?Q?VoT/lvCL0B0eBkcNsV4AlXdTr5duJiy1B3MP0xG8gbUAGPY/PfIhBUlczlMC?=
 =?us-ascii?Q?st7JQDmAWxPfbvv9yektpKt1rSv31NckRzJJEzwnSqCxzj/KzFuifD/+BfIJ?=
 =?us-ascii?Q?5GMwlOfqIYgGaAIQ3fv+fsuip/zonu9ZJegi2FHiix2mic7mKZeLMzfuc8Ia?=
 =?us-ascii?Q?Q4EIB8i3ZsZg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33069808-d3ed-45da-3aa2-08dbbe2202b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:49:08.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqkSeEHVZC/+w1DIELPieGGrlz5rzL5ah83wPksISv1qVOkMvCB8QXxEhDiKBQOv1Bl8HE/71RddTeCOr1o+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-ORIG-GUID: 6RnVGTnEGP7DRF1qI71bwVf5vsu-1iSt
X-Proofpoint-GUID: 6RnVGTnEGP7DRF1qI71bwVf5vsu-1iSt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9df350372046..d2999c303031 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -461,18 +461,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -494,17 +495,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -525,7 +516,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -534,6 +525,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:			hstate.
@@ -557,7 +563,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
 			restored++;
@@ -567,6 +574,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		list_move(&folio->lru, non_hvo_folios);
 	}
 
+	if (restored)
+		flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
-- 
2.41.0

