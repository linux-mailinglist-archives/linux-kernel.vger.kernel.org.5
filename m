Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DBE788F25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjHYTGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHYTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4C212D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEIrP010977;
        Fri, 25 Aug 2023 19:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3yqqBf3/EUJhnisgK8UhLekUfEAaatv4D5tHikWfcW4=;
 b=LCV6H6GrK2qc8JPE7ZlMcsbBOPJrAw86cJ/5kRz2NgMYJ4wqofJhFm3JgM+zqxkBUD95
 mThA4kFvetNXiUU3Am4VI21L4HsyyHNDcJJaNzCHE9789qiJ/1NsjYq4kWFENyRz+03W
 F8nhvEZbzPiSyk6XV9uMirZR9ITMHo6LLmNGFUmIODC1SijZGyX4jIiNA/YqxDfHj155
 0sfGKJTJw7JV/yBzxE9D7Qa97852G3FFF2TUJi6MhOXUsyBpbwMMEWCZ/LgpPzE8zB15
 FnRTXSDgbxoJ2BwRgiG40iJw7cjUzeV6+V/AWT5uhDuE5wHNxZJMt8ibs4i5WyQn1d0d VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv74ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIhRpw035774;
        Fri, 25 Aug 2023 19:05:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yr77vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaMBVRSljPbIc0qe77chXvcGvfvJ0PYtMqt/JLEph5RfXd13Ue7f7WZq/ScN8NtIM9hRu0ifD/j8YUj8fte9Dsv0nt0hjISNhX8kNs0wS0tA415lwEpOw5NBlMRd/PRxM1ACRqwcR4EW8RvA02a7XpGoiwsHYwIVCiMasJgWBmDlLOwTYlQrr7uQM+ZN4nBShtAOuTjviVhqJF55lG45GJ3DsmudoL4/DtmqTiie8/9vMnZOZLTu3LkgExtT3FEGVaHsnknb9ytvl0s36jrADqznz2ziQxlZGXRNoNbfkO6PkKFcux966qCXgpzVmfDlmhKkB4vWBxlgSBmMGnD2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yqqBf3/EUJhnisgK8UhLekUfEAaatv4D5tHikWfcW4=;
 b=fxCkksHL0lvJwPGyBk3+6WT3mcB8zB3OXQHqPVLo3i2dG8b7ZJGEIQ8KZrDzZ4G9e86TIXeY2DOrOlnXfn4Pgk+cmG+6BtnhRxOXmjduQ5bp/0ybnGawAuL3AG2q5YA5+8TWSFXcEgOz2/8+HdG//aBZEG9Ue210WSDC0oDYFSt8XPuNzE5RdZ6Kl251nQC8U7RvnNiu5L7LJm9lW2EZpvS6bF/vdSEK92R/OFE3i5j5VDxoOarHC54tRq3Z8Xow1mPnqw95oYYr539TFZLWLB2Bea8hpKoPVEH/n+ZHdeTcbaiRiWw9kZXN024uENNbwcYE0H+Lj2W7PQSqEKs4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yqqBf3/EUJhnisgK8UhLekUfEAaatv4D5tHikWfcW4=;
 b=OAmZc/4ORS3/ItrMeAzf5qWLA2nzpPHtj7R/GXXIf8LoO9VvP3b/0hAA7MBwwg16bBBQkJCJRczUQIfD4uiZ2YfLaTR6ATG0d5EBrkhno/iy33b8UR2yCjOipmOjJm07zOjnNSBg1ZxHGR5Wdq5hP6vNWp8SmmthCxE0hPhVjtI=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:09 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:09 +0000
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
Subject: [PATCH 07/12] hugetlb: perform vmemmap restoration on a list of pages
Date:   Fri, 25 Aug 2023 12:04:27 -0700
Message-ID: <20230825190436.55045-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8336fd-8c41-481d-5fbf-08dba59e3378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWBpvmOUKAZohKU7SVHXIsS6RXZ7jKx3FM9PbvhIn1rtfZEmLlhqKogWoDYG+tXqYki57aQpJa/ffxF0lig8Xb8zsk7EzRjqFEhiVg7wq6eq1Zrzn9qiAedNq89U9vUQYzJ1KCWk3Smn2pafZv/sXNakSs0Xp/L9Uy5pgf1Z0zDJoMI3YRvjhMO08hddkgyp2/5VJd4aaDNquAiMO4dsOYdKCf+cc5oNa2h7bi/pTPBRvxHTRZRy9RZTdCDVka6Xhwp0QgAcvGpd98wrOGQYUgsT04nb8DkKoY9yi5B7B+XwkBRUSNdHNyG00g1PRLQapyCWJCuigykNqs28l3QAhZKIjrUkT5FvXcMTJhB7daZt0zN4MNyU0xazVx2KiesPIH5IABnp/rDET9szruFhoAkMxgRkcAsKeEgsC10DpEInD3sA9+0jCf+TQgBukpHTyA1sSrMOOPKWZ//qdYovj+eqSu+x6JBRXRUrKsmIwHqzsjn86i48rF/lxHr8znEoAFtAS+cTnIJMWEEH/5U40SVOkTPK/JEEOhaoCTGxgHKXNxZP7eTObPvwcgxjtj0B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Guh3FDSOHYCmwWMJCnG0kxAbT7HhTPqf+R5FXkuhb0UULlrui9ro4MYLF5ss?=
 =?us-ascii?Q?npx+FKEH+Hqv4+/7b188P3yxY3kkFJ+RenF+PqSQRZxafL/AbvbWXgqp26BY?=
 =?us-ascii?Q?jvxO26soLFmtX2VxICHEQJCDr54h/jlrvAHvlbNqVMhUoE+FaXK0TMvjdt/m?=
 =?us-ascii?Q?2brGcdmHn0+3p6MLf2NQcmvDTe35206L1jcTNw09/FS1BmoiropyJORluh6C?=
 =?us-ascii?Q?xlc+trZXHncknypW6meGIXgI7tUhgL9vRwUU3fopFhAoKMYEL6nUfMPokqVW?=
 =?us-ascii?Q?tZLfRwh8mZKXM3CBBU1SWNOIkJiwiz+QS7BY9AOPJJgSOdxtf99jnbswPDGM?=
 =?us-ascii?Q?m7h1/oW384UmFvRSSbSNAk35cCgQ6n5VlFWd5QnRxlw+m0P7ySu9WJb74911?=
 =?us-ascii?Q?6QovDDh8IsQ0QBi9yz8f1+YG5xv/9Ru527+ZMUGXqAZgMtIwNgXBQXB0EOSd?=
 =?us-ascii?Q?nxrlkTwp6+uSvpnkhKMdar9kEZJcNgLBFdh2TiNu3xzyFLMfGU8VI4i6LCzi?=
 =?us-ascii?Q?dDLKqMeiO3WR43DFp3QSjihOGo4GU69F8g7M1wnClAeZh7nQbOtpVQhc/r5z?=
 =?us-ascii?Q?9NbedPz6XgZl035ih2tHmHt7cA16baM98dUGniB61T/kC6tuauveyESuqgle?=
 =?us-ascii?Q?VpTKpQCTbIkYPKmrtnqJ6ecUXM41hOvVFEnep2GEZNep4X7r/QZ/mIYPC1KV?=
 =?us-ascii?Q?H2EODr83B/bSk3M+GgHSKHL6Hjwo3RUVEcWTOAdObFk04q3cwggw/lV/ZiU8?=
 =?us-ascii?Q?X8OIYLZeALlJ2u6Qsf3YXRNaPYh86sR+t6/FmYhlortrcQzzAakwCUZplm4Z?=
 =?us-ascii?Q?pxH9snnQ2Y/ze7KNra+l6av5FbaibqeJ5c4k8LbISEi941NqvvsMote8Q+hG?=
 =?us-ascii?Q?2q6FFs7Yyd/6xXzwGFhiTrr4oUy52ZmLvQYb109/THbLqyoci8ytif7jYStn?=
 =?us-ascii?Q?RbMDFkHS7S8FLRd7C04lsbF6asMR3v/AbWPIKvEcgOzYT3Sq7d7Y2L8jVzjo?=
 =?us-ascii?Q?7VVfXPwvtMqXzw47fHLT5pdfkFNXooSTIP8UEPDKH5SiaQnmvShnIPf8L+bY?=
 =?us-ascii?Q?qr0zWPo/8m+VByAwDlNpAUKhCsuqYTKW9VYEpfSP/9Kigf6NlXvaut92n6sF?=
 =?us-ascii?Q?MoUyvm9I8TBkcTKI/t6WaJPn9GWm7kaPadJ8Z0nV6itKT0Bp05HgbtEVSeoQ?=
 =?us-ascii?Q?ofymR4mT/zAnDAX5CqbemGS1EMzAdmXfHaDooh129E75++r8Iz3vrgq9PiO7?=
 =?us-ascii?Q?cMd9Q717RNT+TH/sdDzqop9Z/ut8+PBbqYpAg5c1di3x5B+gqvTUXf55brLK?=
 =?us-ascii?Q?DRtfLB7S/8WDGvLXrWsH2r2az6YzH6N7qsJUEKyrTpPIEyTtAJ88RfMxjnn6?=
 =?us-ascii?Q?XsuxOXib9td1i1oIUD73/Nqs8yx1gl+ROlOGrvHD0rVPajFxE8q9Q8BQX5A1?=
 =?us-ascii?Q?kUdhmljcpW/ZhRCb5AvoLvUPQnZRqEaIK+4EYSzPexqep54NuG0DnXSGd+QG?=
 =?us-ascii?Q?Rhsdi2FLoKi/mERJlGm64EuPMLZDszdaJuJ2QBJKlCzVX/sDxw1m95pUYGzw?=
 =?us-ascii?Q?8tygFZbNXuswqVdcJr+DxW+YCI+EETWrqyVcqLy960JVbLewAzWjtcDc3uG8?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DUXQQzwraCkXPAGLcbEU47Jvz7FPADnT6AKCtWvOgL8KBVKzlb+cLNA3E4qy?=
 =?us-ascii?Q?KakqfCNRqnk30S46M+iAwjQxs4Lkx/SuKczsVpsOq9RBuxfQ2vhu7BRMMYiC?=
 =?us-ascii?Q?3itjI3z7AuseH1QIabA+dznq6hz0QEh7c3YSNSyOQcI5mN8lw0NUjLLSKFF+?=
 =?us-ascii?Q?MqXruYoqBji2xI9WRB8MdBBXAuPJRMcTEJO6UYsqTjT/5JHRP4Y11HLhgUBS?=
 =?us-ascii?Q?Zm6cOHyx+psl5qYa+Dh8sjkzr58x2iRXV5FUcrmmszSRvhZ9rfomC2XuYHul?=
 =?us-ascii?Q?f+smiwxgQozGjJytA5awnumNoSPDPNtkSFZ+QOO4FvbZsop6+gsT0UKMeDlX?=
 =?us-ascii?Q?nYE5/IvikS+BoVnaWbPdE+DpuwAhLNyhcRqBWo/vMhKezLlywH0q8FQfRWg0?=
 =?us-ascii?Q?6WnqI/1+pw0h9JCyxxOVajOmQbGc8VDwJ619RNNtBHzIydPx/5fRMyIsHbje?=
 =?us-ascii?Q?yecC6tHX6oRGEC18HPMcW5/J7m/nVGtZ7aO0xZWyK95CaPPubjIIQxjrVMYk?=
 =?us-ascii?Q?4Q3lURg5ymGGHnqSh7AFppJ41kTOF5B42YO3I7Xmc+7c+YM1CQKWi5vEvsx0?=
 =?us-ascii?Q?7RMXIhMQszBBdc94KeBhsRv+NE2nVvXlsLjE9tKXsM5bnnx9BQwbK1Sswz+G?=
 =?us-ascii?Q?TgpOPQMfBqxU3u8YJPxjFlOS4OGK0ekBYYq5mFCy1edvOovsknGrz17i8NEb?=
 =?us-ascii?Q?AOif+oapbrAn7QRu6HvesDdehHQKFiPJBRWquD4XiF/uwJ9mYZTZ2t2jdu4z?=
 =?us-ascii?Q?XiyvDAlCwbr5QVWlAFVepjHEuSRioGtwCnrDWvllLvjX7NRp3lzrxL+x60Qg?=
 =?us-ascii?Q?KDWvK8/sWrWKhrCwhBcT3bEnmkIrtcH/CZjWllIOtKyQrSA9Gxx4FQYNLkTI?=
 =?us-ascii?Q?p47imrYzv/rV5rDTU4mjvaRi0FH30/Lpap91ijkzQPqFHxiNwDekXGER3zvW?=
 =?us-ascii?Q?4oqriH4u8XeKJAd31EWe9WUf980ZyScRNa7FD9PDaCC+K53KeycvI3LUooMg?=
 =?us-ascii?Q?mvdaNbkSFMs8/9u9nwbyCYp17CZnLXszQKgttRUNoHJ118i+lXL/xX2c4qHj?=
 =?us-ascii?Q?q3u/VbQYcvcV47YWOww1ODsSwhvhYlikzcgCsZ4NixHBdbmY1rMIqhYCTsMM?=
 =?us-ascii?Q?qnrZW2rIdtIg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8336fd-8c41-481d-5fbf-08dba59e3378
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:09.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1VXRNSRdiJYI2eVKdL8GpoYyZ2GyfvXKMfWooyCQRAkeKdmZdD7gJb/3pMYFP/9uPxXHri+Q/HKH0bmgmchVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-GUID: r70cOVOm7hPTyVVRs7esswLDi7Jym02f
X-Proofpoint-ORIG-GUID: r70cOVOm7hPTyVVRs7esswLDi7Jym02f
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing hugetlb pages from the pool, we first create a list
of removed pages and then free those pages back to low level allocators.
Part of the 'freeing process' is to restore vmemmap for all base pages
if necessary.  Pass this list of pages to a new routine
hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
performed in bulk.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 3 +++
 mm/hugetlb_vmemmap.c | 8 ++++++++
 mm/hugetlb_vmemmap.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3133dbd89696..1bde5e234d5c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1833,6 +1833,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
 
+	/* First restore vmemmap for all pages on list. */
+	hugetlb_vmemmap_restore_folios(h, list);
+
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 147018a504a6..d5e6b6c76dce 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -479,6 +479,14 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_restore(h, &folio->page);
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 036494e040ca..b7074672ceb2 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -44,6 +45,11 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static inline void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
+{
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

