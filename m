Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4A793131
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjIEVqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIEVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA8E1711
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385L9vmM006948;
        Tue, 5 Sep 2023 21:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gKX0pbp9UVdp+b8TX61xER/LCQJjhtFXCYpv7vNcYao=;
 b=cFY7l7fEsDT25/hf2RlJEedMQxryvtG7mlWKb8vbShKzQsmnbseCfaBnBWMjpX91u5Md
 o64fH7jEceifndY4e7eBgIx60kYWUnfRdfXbcp0vB5Az88KHnvSzCttGZfauvmMUc/WA
 hkO1D5x6l9mrQyVIcCFm5st1pvOjnV6ihn5EUxG6e40l+GnfJocCF8PTpVelV5i3RzG/
 alAqjRFpRt1aYEIaMLmK7mqtf356D4/cCEvi5UhnfJIyafLj/MgCpQCnybkMKBOCfk5O
 ZWSzp2sZ9VRE/D/kMlx+WKlJ69C0531xhOm/XLzV6meaE4gtM/4MsMH9aMbi6DRmVHPs ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0g82sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KKIJt007701;
        Tue, 5 Sep 2023 21:44:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5c6ur-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyzPzQwFKvwwOxOAtchRNKUxLwg0Io/aMFvGl1dX9iMo+MzbXv6OYPTVBaD9vy2QrtzhcYWQvuUHfN8o+2PvTQJqykRJw292RllUSuC/LeVObQClH/BNHK63IYrQcLPnpnWIp0IVDTFy35wwO3sTx0jCc0aRMAo9lVw8499501seKx3yZiI7YyatUtHbUhsGIw8jhJ/vDYkvg4P7FNo+wSdry4C6zKeUBU/tzMWnCw/UMITto+iqhMz2unxfaxotYS9+ivw3aqSU+fIMGeXzRimFb9fbFZxDn5+hGfZx6aBbxNRWq5rh57410Zp+ZR0XkQLDgxbAFhf/eYJ+nc1NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKX0pbp9UVdp+b8TX61xER/LCQJjhtFXCYpv7vNcYao=;
 b=EJmpU9s5jTuMxXgY4W3i1eU5WIEM3ZsHC+1wOapAT9DDgWkqa31JZ3f3oNrroydNRjYEbCVcs5Ajlzg6fNvw2d6mTUz7Od8SkrnPmLxTj1CU7oDf0rkhzS01nUWDJV3Y21YyCSPUXzV77g3iXyPGcG7JO9rUfCDRvgeCVw9p7zdPj0HkzCy5RKLWP3MacZxYZkWj9mrzOQUq19caMGGu7ubb8qUhclvt1Ozqn4XeZwOZXG1pB6qCHAFP10QSPNTD9oILF7GJq990o2TLj0Ii9OzdBqRrVFKtAJbQELKVcNDdXbmkudcdirgQ/Cb5UAWJ1wAqKHCaL8/E1jP/M4kQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKX0pbp9UVdp+b8TX61xER/LCQJjhtFXCYpv7vNcYao=;
 b=m3Ln3ldSaIIQxgpFE2A9XY2slT/9fTVm/clQjYFGvEgodQQNim6CBHgISD6XFZ4halNzJld1D0bKFSe76ei9VZG0FXuryQtzY9/IQRnGcYFUjKRG/Ls97pWTFpW95fKuMNfpJQ6ZKK/QMyfEmJIDee2+GZptUEn2ASUVaReg1bk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:31 +0000
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
Subject: [PATCH v2 04/11] hugetlb: Convert remove_pool_huge_page() to remove_pool_hugetlb_folio()
Date:   Tue,  5 Sep 2023 14:44:03 -0700
Message-ID: <20230905214412.89152-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b6f6a6-ccde-4187-f198-08dbae5949aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okeHPF5f0Q4R3EcjnnfN1lSFKANkgzNLYzotHFl2Y52kW/c7kaSPNHiWLw8sUSRzMMzxxPyy4n220mZbocMXf6Z9syWg0pMEBV/f1QOkzrVPvXYRgvFmzxKq4gueB0o4NUicC8xJSVHbf19JDey5HoK6i8q6Lue0rd6vnPrLSvkasnjzgrX4cvOdUjI2fcrVzfIlweTRU2b8gymY5YoZIMOm3QyzevVniqBmV+OWAqvSV0F6HJuEiZuL31x9lZaZK0uIZAld0riO/mFpJHVOc814I0RxxGzS1LvKzsJGFCSvEfrfQGmvbwHRPpBgsP2HJZbiE7mUSnUaCV8bFqnUAVh91HDzhk7XLlcxS252btNd/VMc2jC3hydaNXZmJBxDHaYsbt4hi8ZzeuznB0bJa0V1610nY86Ujvv96lFUTWwJf4T6twFk+PqJjP/665RL0aP67Gd56N6rZ9TbBdYDnDQG9tQHkfmIH2Y5NIwg/j5fxBd/aGHHmBtsILDpSEyoBw4UgGNPuiBSHnVr32is9H4FxEMyowF//9HgXJlG2DHJ6W6/oKcT57u0Ly+N2M0RlCpzgwglH6tiNiNUYz+amw6K28arJKaqZtQNFgz4NXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pNEeRyMeKB9fEWkGuac5EgImumrkkjzDmfOufTNDESAvWGDV/U4Av46kedm8?=
 =?us-ascii?Q?B3b3P3kVIhMjwj4s+gskHoomvC4hBtVm4Ka7TxT/AZbBduOqCgGwf6cS282f?=
 =?us-ascii?Q?Lc+EJ8PVl1gA7XykFKCD1nTjsgDSf+dl4sowJXbOwE60L5oZt8WPAloGfVWK?=
 =?us-ascii?Q?6hCVkpJFHzM9ovqyel9KSUiyeyBY6CDRwfcKThSMWwM7L+bbnJ3ZTW1eP7gw?=
 =?us-ascii?Q?Oee5nnW3x2BEC/GYrah75kS9ZscNb9KgcDLq9j5wDFWFWAPgWy6JeYVfzEaa?=
 =?us-ascii?Q?bH1zx9sP+1WMHRLQv0ySVmwc4wc/3wDtLXSuQq/PAkvabGjmUDBGaEYMMh6U?=
 =?us-ascii?Q?6bNZT6+VRZKkvMypRh83K/bZEKcBCSWhs5JdcjqVQlU6zsGMr6VOPo/sKjPu?=
 =?us-ascii?Q?kIRYJqqkaU6+hnkMkkR7bbSsOe1ahAoNnDyTNrEliwtkVn8/HC7aLMyH+4Rq?=
 =?us-ascii?Q?yQxNsIh6UkESMCwq4u8qaKGiQdYh/B4SDUCDOfx/eNLXL4UC31a8MTesM8+e?=
 =?us-ascii?Q?FbHzXKNuUY5wCFgqLBtcK0BXFtMBBPX0Wa+nXSylbSvrnM7gajG5uNA3tuMX?=
 =?us-ascii?Q?/OVAtH0ERLecYjLLW0g+2lWSwNDgj3tqm2ydVAA2hnP/QIUcaIhSA5CGOnyt?=
 =?us-ascii?Q?9n2vYnHXBf8jazP/+1RRmlHGWYTP5k4AfDkJAXJFz7uQXdUG7v6ohReZhK68?=
 =?us-ascii?Q?u5gofjq65WPSHEfZK4r5HN4RTUteFoTpwNmAmSVFEYl/iZ7MTfvUeG9hrmkg?=
 =?us-ascii?Q?94JMwkMf+D919MiWxsHZuNzPL6KPgexMw9p8A7O2xVpaVanH+Dvs6+FvEZ9H?=
 =?us-ascii?Q?HC37Q6sZNaMAkESdA4YvCLgrm/3C7Mzo1xaLY3IwYMkYEcugEWMHUK3QA420?=
 =?us-ascii?Q?vbXuEPIVveCov4B35VIBMEh0/0M+2qvQtbAL34mqve8f54SiN4AJxUfMg5dL?=
 =?us-ascii?Q?HgdBpbVqh68dFzfv0SQfTL2xUKRQIqzd/P2odOt47hrVmZ1u3aCPki7ONdmm?=
 =?us-ascii?Q?FZurvs/qaG4mrolddFAj5pn+7hdLUqXOi1TW8oZoHBH+YS09jszpBcZHuo+v?=
 =?us-ascii?Q?DoOD7N7Rti9s6RVvKibtnsYiOhoGgpioodvFFkrcqqyTIDepdcsmjCAfjDmt?=
 =?us-ascii?Q?1zJDL/YxQ+HukmbQbuVAJCOWmvUJtIaewFtInl6enewIXFynTQUUXJ20wMTt?=
 =?us-ascii?Q?YPCmY0B0CNcNDPmQXbEokLcFydv6NlmixE3J4ZoUUc716jb1eeWZCewXydUj?=
 =?us-ascii?Q?ne8eWjk79ng7ONbqqqEJKcGkntyNXfXBGxYeQQ91O19Dcvx9bK8RgDt2GZFF?=
 =?us-ascii?Q?H/X/MN3KumXoPTbaRfUHlyxug45Cl3+UmTlTvUVfpBYNkBlNd+sxjQ9EKc0W?=
 =?us-ascii?Q?XVZ461knFxCajMioppqBQTSSzGSiQAfpifTYJzU1/No/vYF2KyOof5xjJQmR?=
 =?us-ascii?Q?FtUd6Hjc4o/lcyrUZp6l3VehMVeZVQ7BvFdzJ4ynKeJrBg+936ffZED836Nb?=
 =?us-ascii?Q?caIw/qYl3SzYXKAgA5Zp5z6raPd1jAoyNPrwQytsWO/yTt4jvSHUZEDRqdm8?=
 =?us-ascii?Q?P/rKG3cTzznMYaQ43pmUjnA3pVRMs7mfQVT9m8w80isFMtJh3/1WovxJP3U8?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c+VYZ97XMCwwXHn4uhMiXfi5W0JrM7sKJ+cMJwoJRSq1u9V34AkHNbUSSoLs?=
 =?us-ascii?Q?gHGcQffPzKb/Ts7am5/HTRacZc6+K4gd4Ys6WptcUpKKwrpWC9urb+WolxkN?=
 =?us-ascii?Q?t0pG/UpiKOxLwos/inCCYu7x1WRD68g8RiYoJ1Nn2idVm/aApCrVrc9tjq26?=
 =?us-ascii?Q?w24ibJDU1K5QyRhNhlqtX1mQ+SmdWxDqaP0HM+UR6SfzL2jiTfnlnSqxlx5/?=
 =?us-ascii?Q?WJ2+/NPX97unwD9DDlDteHN7/59u8aogEL2a78gnBmOXLWHl4O6X0Q1zZHkG?=
 =?us-ascii?Q?rU/QELeHM3sHIq5DvBs5LhBaoYa034E2Hig7fSqSUo7lqgIDjxNu5d1ahrwn?=
 =?us-ascii?Q?oHrXeMWhVDd10wF2dUxjbSznbCBFU676FCAqo8bcloCw9UCpmjsTF5XozTAf?=
 =?us-ascii?Q?MeNH5L2NtRdzcMMTiXRWA7T3Ny1QPfj3YizjZh4UgUMpq9ReNaN8KLywK7Av?=
 =?us-ascii?Q?2imj3C3/i7XeFSQib8blTd5yPXZVWWPcMNRsozYtIDMF6WkGeoNG2N1PsrBE?=
 =?us-ascii?Q?RL/PrOlnfCbW8ikiglkpHf+P1ZyT0F+M5xCl6/KLkmidHgndizTyzamoLzOF?=
 =?us-ascii?Q?qGnzcMRBQVQJKQJ88G6cfa2zmutrKIBNY6zJraak5WrTe1D/2xW7r2N/35SF?=
 =?us-ascii?Q?PS1a0TnVHg6o2MI5ZE+luItwNwg1Zk0Pu9fBb0Iso8P5GBZerinfrBdju+Ro?=
 =?us-ascii?Q?dPKWnX8ahwfS9SR+anRmXk1JUJaqbMiIjK8iPAQ36+SJQB4S3qILnQiH5qwQ?=
 =?us-ascii?Q?ft2Sa4Ybr/FNMtq/1K0HApaNhL5l5EaguBvJgyAARAAnXNEdS/lDinwFtUUI?=
 =?us-ascii?Q?625IM5SZObUNp2lSKva8kw5r+fXbXSOpIZiiPQepyebVBYpSrNPIUY8tqDVS?=
 =?us-ascii?Q?nZe+s3kJgLFBEPdkPEJvuQ7CMJyFZtZMT2MQxdh8vlREg45v5yRMWzZBhemq?=
 =?us-ascii?Q?eeN7ptQAv8H2fwmqNyTDzIoVHp0NlLBOxpHr/52sDmg4c91UxJfS3WzKIkx0?=
 =?us-ascii?Q?L+1FsNBgfml9fUIpCHYD0zMSm23WnYOJi/1Cs1XmcK/7Q9GU1JlOT3ywHZwG?=
 =?us-ascii?Q?pPsyRzGV1DuOG3etz49MjquNAao7CARjJHu0cS7Op/w5A6HXVIM4+RyzhdqU?=
 =?us-ascii?Q?IF0zghJQQ9vo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b6f6a6-ccde-4187-f198-08dbae5949aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:31.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9949QE835byPnJxK1yG4R/5u3UYPgLAau/A8/bQv3jBcc1ssEav1GLe+4c+jCwv/SYMGJ0/q7E4jEd8Ag6rmig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: jtRikbc30i9TJT3PyEOSCf6ns33xuH-0
X-Proofpoint-ORIG-GUID: jtRikbc30i9TJT3PyEOSCf6ns33xuH-0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Convert the callers to expect a folio and remove the unnecesary conversion
back to a struct page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f768fe9aebad..278c8ae6a36c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1446,7 +1446,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for remove_pool_huge_page() - return the previously saved
+ * helper for remove_pool_hugetlb_folio() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -2222,9 +2222,8 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static struct page *remove_pool_huge_page(struct hstate *h,
-						nodemask_t *nodes_allowed,
-						 bool acct_surplus)
+static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
+		nodemask_t *nodes_allowed, bool acct_surplus)
 {
 	int nr_nodes, node;
 	struct folio *folio = NULL;
@@ -2244,7 +2243,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		}
 	}
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2598,7 +2597,6 @@ static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
-	struct page *page;
 	LIST_HEAD(page_list);
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -2619,15 +2617,17 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * remove_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_hugetlb_folio() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
 	 */
 	while (nr_pages--) {
-		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, &node_states[N_MEMORY], 1);
+		if (!folio)
 			goto out;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 
 out:
@@ -3422,7 +3422,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
-	struct page *page;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3542,11 +3541,13 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		page = remove_pool_huge_page(h, nodes_allowed, 0);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
+		if (!folio)
 			break;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.41.0

