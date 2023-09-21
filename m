Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538C7AA498
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjIUWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjIUWME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:12:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A833E2485D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:59:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIstNm013416;
        Thu, 21 Sep 2023 21:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=g9XGdPs1g0eRQlJ2ANEPX5CpnsvfPS5JqNhZpcMhtWY=;
 b=auw7IncEqlxrqHdl/+/VxlBI0gInUWfa1wJL/VjX0NwKPEWAJUeE9R1iMhdboQAHknA6
 eiCwOu0PazzY5/dl5fA4AtcmqH2kvINs4Dqdr2DOg64Z+lvakZNf9PyiEXuy+zgStzRi
 XVxdiLrjp7ebF6H/9rQhs3CkDLTBKYZzIlQ/kFt/qJI211OXnwKZhzXlSsMwuQAqhy27
 HX7KoeIrpw7vAWl5v7LmxOL9vk74N3/HR8yijGQIz8qbuUZqxyqcWuTN+xUWXWRNKZHU
 jMmqCYuv+b/jjIwbD3P6RqQAd48a2XxuZlUTqlhh9yTtsqwoz4HzsIRgpHirY69cAs0f bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt1gd5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 21:58:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LJw8Ig033845;
        Thu, 21 Sep 2023 21:58:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt77sbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 21:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESluB/fp4kelU4biH6d5YGGj0Hr0peVr6T9GoCEBLl5oKRsaD4VLEumgIUSMqhOPEetdNWmJlRph6jafGx8U7OfyUWNDFehPD5GgP+ZccJx12c9F7cK8qXLzs6fKAXlk6Fz5c0vDSkvKuf00Gth0r8Ax7vvBNbAD6KlxblY25H/S2CVvA3AvjvXsytFw8QC4WdhAk5rzRouUP3Rj0YpEnPL8QFAH9/5xEEZ7lqwKXo72zR9A31XBMdA0S3YaI1EU/bjMxw32qfbWBu+8G7gwLMpgfTYnYNzSNqeOYGxQB51Ltrtv8Y8ZQPpVjNQa/yaw3qfPg+TE9IO8Dlz5XBQj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9XGdPs1g0eRQlJ2ANEPX5CpnsvfPS5JqNhZpcMhtWY=;
 b=bK/fejpSlsG1wNLez1eh6dN8C9K6NMCerjwzwCGDXVatFTbn1dwyGa6589unSolvO3ySjQKA2A9/e6HIBJRvWhhUQZ/N8Nh5PF9QlAwXCZSkFFGzZ/CUz4Zht1LrkLc6XR4UmqXd8ZBhwhEo76XiMeljJcVGXhrvG1G5jcJA+8xctZa0MlFSgfcAyzUjwjqU1fgwNjBiJtVy6EgcU4iitKsnS90/bqslu/yLdMIKlzRIQb2pn87txbfcD5DXsQb+h5Fsx1lKYhh9LotFO3uGNapb2OVMjjCWAIflzAB3vb2UGa4qDnqZ+WLaPrrxP1s3KNYIaMAcV+Y+AZydwHJ9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9XGdPs1g0eRQlJ2ANEPX5CpnsvfPS5JqNhZpcMhtWY=;
 b=veaKtEz5r7GQjRIQ0VXsqN8jIcPdAM0icCIkUqHRxbb+XCk9UtHmJ2imxPwM9dZ6g9XbFBdtv1U9hK588mbUojnItWouJBMe40xBpRxbPobLOP+qqxRQwphMjNLx6mzRWfYRd7gLXBR+/ezULd6Z+Nqd+YH07Ezh9G6zHpcU2o0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4540.namprd10.prod.outlook.com (2603:10b6:806:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 21:58:13 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:58:13 +0000
Date:   Thu, 21 Sep 2023 14:58:10 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230921215810.GA21193@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-5-mike.kravetz@oracle.com>
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
 <20230919205756.GB425719@monkey>
 <CED64A95-00E8-4B52-A77A-8B13D2795507@linux.dev>
 <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
 <20230921011223.GC4065@monkey>
 <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b002f2-6ee5-48ec-0e67-08dbbaedda09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HghYeYduASy/f7YkWBaatzpBx9JShfgNay+gufeV2oQot18pDNWXLTuViY/w/C200w3TfK1o+1RJNqiNPssy4r6bPm8FEqJHKUrsPiok9Li2ijlsCDPCIgp2u3EU4iIFRk4N2uDkGpSyTSvPMxkGLmWvxGTEJCs8+lK2ePwbzrZEVtFhbTXfAcGqlai/OZaqFnZymDkMevz0R7Y1IGg4aloqU1AsQM4BrK72sEgSnpQ65Df2RBo6XPCQloE+Fyxo+aR0e14OJ+mF19NETZuHqtf8833765LlG478gUBO72l4OeStKhXVZUL8hgFpCWbgDSz0yWvSbd0vY2E3oy0IyrpefPeY/Rr3fauVcQiz92psmr0/7tEf3l28//n52+ZrFiDDMQbnjO2b/gj6QHXQGvmRN48ADJT6B5lIyR4p8o1RDLEgHvhmlH8UUTFHNhXhUn9bjMCwctFQn0l1dlknVQzUSUTBxkI2axRxo63l7SksyO4za5mQ4EHxS6iJPLZVsvyEZjMUUxw4CpjKUXvwukY0NB3sBWW6mmUBzuHdM1FwVhmjQa+VMAfEWoUOFBU1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(33716001)(86362001)(33656002)(38100700002)(44832011)(30864003)(4326008)(2906002)(6512007)(478600001)(41300700001)(8936002)(5660300002)(53546011)(8676002)(6506007)(83380400001)(26005)(9686003)(6486002)(66946007)(54906003)(66476007)(6916009)(66556008)(7416002)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5S8t3Kl8rnMU1CRIREif5bpeKcC4iZXMrstSjdTkswzuwyadMDlFAt1dDIR?=
 =?us-ascii?Q?AR/T0BCforoeSW9hhB52IR0Vu3mgO/vkhZohpqkKtrweaXnJWj3UokeGlUZj?=
 =?us-ascii?Q?urURUiZeHfUmaZuOC4AZ4edMZ5egHOAa2ohDZxJ3jDQgeINi9kaFyTOt6BTd?=
 =?us-ascii?Q?OhrR4jX+EkwgNKZ/DBErcHVRS4/pxCOl88NJEwlMxIdABvtZorXEC2wxeY3C?=
 =?us-ascii?Q?RJG5K3c6kiZRy2beHQfvFnEDhw1sgGJjHHHycTuYEVjQHxXaEsXG2crI81TZ?=
 =?us-ascii?Q?GwQ/oCUZlAT4oKXfAKR685vY1bAWWO1FMvAMmZCgaKhlYPWQHm5CXVHqbYrB?=
 =?us-ascii?Q?3G+J0C6mF4sLwGDGhSLpVAb7wqyo77hEIgHrw8EX1NoLFO7YP//p/82ItdJ2?=
 =?us-ascii?Q?kfuk72d6WxYOE+XjD/GNuSFXCVo1Eu8IhflO2EeCS0AMyjlLAAO5gmwfQaxA?=
 =?us-ascii?Q?XpoJZvFT+SOVXAQGU8i1uexhuNCG6hiP/2Y+ZYip66iifVfSrcDa5fCxsTFo?=
 =?us-ascii?Q?WjRVFtST1UjA8ulubE8HZHmppst+w2cJ0gAOZH+tlv9iFfFpBNuNsy7YsqV+?=
 =?us-ascii?Q?iQwrG2RXetNZkOrmXWYbRA90aBXl/5aufN4jm4DRFFEm1p5vWLL43wE6LU9q?=
 =?us-ascii?Q?q9lrqKwL1j19yAo8yTwNcsR5gw5Hsgh80HaT6PgMfvP41HPlFTK0unmvpS3q?=
 =?us-ascii?Q?Aj+Ckeic4KkLI67n2OIkm6X3+KLpdtMxK0zsJG9H0ZWR3dG35zRWwf+TvbCI?=
 =?us-ascii?Q?jfJSD028pEwQnnfBsNZtJOfNEAMIuYeQcY6WT5WDr2ucn+5EQsxi3xSlZgcm?=
 =?us-ascii?Q?sKEwBj7WCsFi7UrWBJRNr6fhVnr4YAEOGqHnkFZ71wiJdDWXwnWJLc/FgV7Z?=
 =?us-ascii?Q?1wOVBc6HSpWYAIWpz1jrJ5p4w6IoJmWCpxpzH6Hx1JPAHSiBA7cIcc2uItfR?=
 =?us-ascii?Q?r2PQqV3YMj0QIJeg+ODJtuHT01TZMja/tx4Az1D8fgXAljJFtTrTsS6p7FpV?=
 =?us-ascii?Q?RScRwLA5r+5Go9iZXz368sttQUAOtz87fDiAT4P6u//PtTOo5jDOF3uIwS8t?=
 =?us-ascii?Q?eX9PtFi0CD110f+RKtVWwt6JivPcrUOkQIYyiP0cUC7N6dEabDa0Rx+uocXd?=
 =?us-ascii?Q?LIsv1OoLk9/l2wApkWGhdQX4ajrRzdhTc8M9/7Bqhme0hyDfqOoN8Ph2sryf?=
 =?us-ascii?Q?euWxZExBrM9cJEitJEOKE3OpfConJcfiOVj5A5XTKulJZ+Ht3ZXBe7aMUISb?=
 =?us-ascii?Q?N7ky/IquvOT68ANHlfQ2i5Nxb6U4o5lcKQy4QSyr/V+IVYzJ+0DYqiugZtbJ?=
 =?us-ascii?Q?NpVPTR4yCzXe3S7It7o3o85eMERnWZccDmu7urN2iORAM+Kl1NooR0bGVRm8?=
 =?us-ascii?Q?0nJxlAOEigeLzgw1mthJT5sl3JZfvkFh6QNyQ7vzRhylv2mtQhKwdQ6ojjS5?=
 =?us-ascii?Q?Blqh9QQ26gRG4sqUTEHxa/gd9wK55GsEUVor0OAATkFpHbDHCi+jpmylrlkA?=
 =?us-ascii?Q?gfTDBfxN4drkj/HO1rI5Z+3EPYsIUDy98ClIX+ZcDUa4ZPBY87AtV5DZxNUD?=
 =?us-ascii?Q?+wLqQxjYO2nkG5VuWpd2nKDlkDCkAK4Z/ieE12Um?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?O5aDevejdTnGLI0wpenG3N7OgoQlzZMNobDRhDtWNCKWs9qG302KeZ34BAzi?=
 =?us-ascii?Q?rOZAsSsmn37sW6RZXFzmNhk/3v6LFoyL8fr5zvXa3KAMkp+wFfpIRBPyzhwW?=
 =?us-ascii?Q?vC+4FAxJq5Ym5MmvHGBOkmI+cLuen2MEsNvRk6Nk53JulveWWaSMufuNQjjN?=
 =?us-ascii?Q?4Cme6yYMr3pu72J88Y2aO2zpFzBODYIn+lU2SyqyEqmlv3zylNo9cwGjnSFj?=
 =?us-ascii?Q?iqA6ySdFcWMQCGFhEpaW3jQyrFbuPv1DK8MjUQQwCXkw9hJKncelLRSPTwja?=
 =?us-ascii?Q?LaSSd4VfqXcrLySgkuh5p17equosHgwySLPedCWtod0XeosbM2q5YIgU8gVw?=
 =?us-ascii?Q?hDipflhbdiomgwZNaKMFYsC2n7wNDVxqQ1mtngVKulqeh/u50NZW4Ax5H+qH?=
 =?us-ascii?Q?0g+kpBetIX75RJobhxcmHNt+g4FfvyP25D2XEu9psrnsHieVnt/0bDMXuP4J?=
 =?us-ascii?Q?9CdLolm5jDiU6iMooSkNa1AGK1skOPTjYbZ7NZg+BPSqY/7pZ34PwdHjSWOO?=
 =?us-ascii?Q?UakEgZO8RucskD5tOwnGrAReAEGBZ4ZSSG0l4C4QbSMqM94zGHsdnxcNxvDF?=
 =?us-ascii?Q?sJStJ5xHU2j12zr/kXj7X3waXS2tvDkZx7fyU62WEjdZjQgaVPMXOwfHcgb3?=
 =?us-ascii?Q?Pcyelk3TLBmT4k6UEb6/WsNBYsMfGkigQe/yszxH1hGHouHv+MwtIKxZE0lV?=
 =?us-ascii?Q?YpgqlDnPBpcdLyzlIPhmskjR5lVJ06MdhYK8RxvSLTuBln0UNNpV94KLf091?=
 =?us-ascii?Q?4BpnhuD2rY76FqOZnbl3UXHGrXxKZA2Pzs3t+vEAWXL4fIDXUqn9jaybXZUr?=
 =?us-ascii?Q?n3wxTMvwXGY0bBTA7Qxy517yScoV4oKCH68TXfKDl0u9Aiw9lKNvRJw2L2Ue?=
 =?us-ascii?Q?8gvNoErBiNfx0cyE8ocoktE/tCV/1eZDdqEpN31kHbjrp3o1sku95JQMSoiJ?=
 =?us-ascii?Q?urZW6r8iIZIDVWyUL76se42gKYafVJ0cPwvushT9AchBTWmBFoZF834aWmQ2?=
 =?us-ascii?Q?8mT8s+WNVy68cfNWExIlsMUPL0YIqaK8XVY5IDLXqBfmanawFG/HK2Js82rH?=
 =?us-ascii?Q?mbdiBqh1TAMN+9T+tSobzOcm58QMcyiZoxGawdE4Lkp1sIIrbfnhW78W+tpo?=
 =?us-ascii?Q?/kY9TWxzLR9s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b002f2-6ee5-48ec-0e67-08dbbaedda09
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:58:13.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou3FbJD6wHOhsp/6vxnxTSZwrrtUBTMETJ0ZGjx2m26P9gY1fkoCcIzYd7AA3YaMJADNd96h1jWHY5PSXLPK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210190
X-Proofpoint-GUID: tw_pm8tdepjoddRywgtFcGaMcV6UtS9g
X-Proofpoint-ORIG-GUID: tw_pm8tdepjoddRywgtFcGaMcV6UtS9g
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/23 17:31, Muchun Song wrote:
> 
> 
> On 2023/9/21 09:12, Mike Kravetz wrote:
> > On 09/20/23 11:03, Muchun Song wrote:
> > > > On Sep 20, 2023, at 10:56, Muchun Song <muchun.song@linux.dev> wrote:
> > > > > On Sep 20, 2023, at 04:57, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > > On 09/19/23 17:52, Muchun Song wrote:
> > > > > > On 2023/9/19 07:01, Mike Kravetz wrote:
> > +/**
> > + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> > + * @h:		struct hstate.
> > + * @folio_list:	list of folios.
> > + * @restored:	Set to number of folios for which vmemmap was restored
> > + *		successfully if caller passes a non-NULL pointer.
> > + *
> > + * Return: %0 if vmemmap exists for all folios on the list.  If an error is
> > + *		encountered restoring vmemmap for ANY folio, an error code
> > + *		will be returned to the caller.  It is then the responsibility
> > + *		of the caller to check the hugetlb vmemmap optimized flag of
> > + *		each folio to determine if vmemmap was actually restored.
> > + *		Note that processing is stopped when first error is encountered.
> > + */
> > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > +					struct list_head *folio_list,
> > +					unsigned long *restored)
> 
> How about changing parameter of @restored to a list_head type which
> returns the non-optimized (previously) or vmemmap-restored-sucessful huge
> pages?
> In which case, the caller could traverse this returned list to free
> them first like you have implemented in bulk_vmemmap_restore_enomem(),
> it will be more efficient. The meaning of returned value should also
> be changed accordingly since update_and_free_pages_bulk() wants to
> whether there is a vmemmap-optimized huge page being restored sucessfully
> to determine if it should clear hugetlb flag. So
> hugetlb_vmemmap_restore_folios()
> could return how many huge pages being restored successful, if a negative
> number is returned meaning there is some error in the process of restoring
> of vmemmap.
> 

I had similar thoughts.  An updated patch based on this approach is below.
When creating the patch, I discovered that using the function return code
for both number of vmemmap restored pages as well as error code was
unnecessary.  Just checking !list_empty() of non-optimized pages tells us
if any were restored or could be freed.

From b79f6eeb7a11644830bddfc43d2219c149d26405 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Sun, 10 Sep 2023 16:14:50 -0700
Subject: [PATCH] hugetlb: perform vmemmap restoration on a list of pages

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering an error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_error
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 94 +++++++++++++++++++++++++++++++-------------
 mm/hugetlb_vmemmap.c | 36 +++++++++++++++++
 mm/hugetlb_vmemmap.h | 10 +++++
 3 files changed, 112 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70fedf8682c4..11de3f885065 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1834,50 +1834,88 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_error(struct hstate *h,
+					struct list_head *list,
+					struct list_head *non_op_folios)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (!list_empty(non_op_folios)) {
+		/*
+		 * Free any restored hugetlb pages so that restore of the
+		 * entire list can be retried.
+		 * The idea is that in the common case of ENOMEM errors freeing
+		 * hugetlb pages with vmemmap we will free up memory so that we
+		 * can allocate vmemmap for more hugetlb pages.
+		 */
+		list_for_each_entry_safe(folio, t_folio, non_op_folios, lru) {
+			list_del(&folio->lru);
+			spin_lock_irq(&hugetlb_lock);
+			__clear_hugetlb_destructor(h, folio);
+			spin_unlock_irq(&hugetlb_lock);
+			update_and_free_hugetlb_folio(h, folio, false);
+			cond_resched();
+		}
+	} else {
+		/*
+		 * In the case where vmemmap was not restored for ANY folios,
+		 * we loop through them trying to restore individually in the
+		 * hope that someone elsewhere may have done something to cause
+		 * success (such as freeing some memory).
+		 * If unable to restore a hugetlb page, the hugetlb page is
+		 * made a surplus page and removed from the list.
+		 * If are able to restore vmemmap for one hugetlb page, we free
+		 * it and quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+{
+	int ret;
+	LIST_HEAD(non_op_folio);
+	struct folio *folio, *t_folio;
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
-	 * lock/unlock for each individual folio.
-	 * The assumption is vmemmap allocation was performed on all or none
-	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle errors and free up any available hugetlb pages
+	 * in an effort to make forward progress.
 	 */
-	if (clear_dtor) {
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, list, &non_op_folio);
+	if (ret < 0) {
+		bulk_vmemmap_restore_error(h, list, &non_op_folio);
+		goto retry;
+	}
+
+	/*
+	 * At this point, list should be empty, and there should only be
+	 * pages on the non_op_folio list.  free those entries.  Do note
+	 * that the non_op_folio list could be empty.
+	 */
+	VM_WARN_ON(!list_empty(list));
+	if (!list_empty(&non_op_folio)) {
 		spin_lock_irq(&hugetlb_lock);
-		list_for_each_entry(folio, list, lru)
+		list_for_each_entry(folio, &non_op_folio, lru)
 			__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Free folios back to low level allocators.  vmemmap and destructors
-	 * were taken care of above, so update_and_free_hugetlb_folio will
-	 * not need to take hugetlb lock.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
+	list_for_each_entry_safe(folio, t_folio, &non_op_folio, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..f827d4efcf8e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,42 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:			hstate.
+ * @folio_list:		list of folios.
+ * @non_op_list:	Output list of folio for which vmemmap exists.
+ *
+ * Return: %0 if vmemmap exists for all folios on the list and all entries have
+ *		been moved to non_op_list.  If an error is encountered restoring
+ *		vmemmap for ANY folio, an error code will be returned to the
+ *		caller.  Processing en entries stops when the first error is
+ *		encountered.  folios processed before the error with vmemmap
+ *		will reside on the non_op_list.  The folio that experienced the
+ *		error and all non-processed folios will remain on folio_list.
+ */
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_op_list)
+{
+	struct folio *folio, *t_folio;
+	int ret = 0;
+
+	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				goto out;
+		}
+
+		/* Add non-optimized folios to output list */
+		list_move(&folio->lru, non_op_list);
+	}
+
+out:
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..e6378ae5c5b6 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,9 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_op_folios);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_op_folios)
+{
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

