Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE3788F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHYTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHYTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F42137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIESYv031124;
        Fri, 25 Aug 2023 19:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zb6NKCA64ESqc3mqR+LOpdZU6XXh60EAfRdU796i4Ro=;
 b=2t+1O4bLN+k80Qt9bl8aoXFhuuMp9ZXlhGq2afXlv1gd9xeoJmb4MlG+dFYXOYomgqlh
 pd7rKQDWu4w9dOxZ/FZ7q27tc8uN3+WFx6gQTKk+WZYIJqtXEZQvQceCjOSwhTJqBSdR
 vEthCHAMekuHt6C65L48M7Qx/vFdBltTJdnkAHgwmoVYlviSM6H5EJXYJZrEMO93F6V/
 MwTvuSuIFOL67XvKcpUheYgqurW3AjJ29fH8INRv0KYVxyQudGJVbvVLKLESEagaLAm2
 aKkT/Atw1827JzDLQOl9FYVJ5Iriq2LnRGjLvLrzNUa6Axw6ZHPfVdvF0BsWVmRerCQG 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIjPs7035753;
        Fri, 25 Aug 2023 19:04:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yr77jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC1icQetrRL8CdwcQPbVd2yUqY7c8UF/mUdQ25eApLIfuiZ+U7QPW7uEUy+EPBxnVLIlZ67q0xlezRpjAPGNWS1+yuZ1eHgfiXBQGYlijdWbSc0HemBIVBGXEplqwq3fc6qR6brsdSeRiagUEU0yLXSf+nwOPyKPSfZ66p5DiY0LnW62pE+MQw7HHP3m4AIlNJubxR3PxqHnSVnX/2VfnrspbWpM2Krtw1oeCiU9J3wQA6Dd66n6BRnXdwWaQyeWic/RZ2lLSaEWp4cCBZOpbHFP/cP2IXbCcL8+P1qzAcmRf4OT2La+l4YSQSSv+BdIzh6xZKM63vZohtGKMCjBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb6NKCA64ESqc3mqR+LOpdZU6XXh60EAfRdU796i4Ro=;
 b=Dmb9c1nDCzFNX99cinMhXC1hhMxmciTIFfMr1U5AWErAdsbLIcY7C/GWMhMFHgAPrf+CtSyaxATo52ZP81fz6iYrp3TQCj4aTV/KEnSrUI3Y0uJ+N5UWlWt+SjkrO+TlFFgP2D5/1RMRsWviPPPhOkcly69E9Gt8hs4ki0LRuR99O+ywjqubgZy6CzYs75Mc0hZvUVph6FlemZD9xwGxxEwXUZJyPy/8LC6LuokKADNevspdtGXo/kZVR7i9xGIOpD+eiI65UIVW9uXwL2f5iM01fRQv1KIVO5gUymHEbhSiNxiq4rasXTJUtZhWXlmE2ZWeazYQ4QKDqepx706E2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb6NKCA64ESqc3mqR+LOpdZU6XXh60EAfRdU796i4Ro=;
 b=wV+6nZbBfTvov7/U74Whvg6bWvinIk/Wi8XNXGZUKPk1zZGKnM9pgoV7x7cVIXQnmkXByBllfoQO2zxH5RtOSPyrgsfphF7+97ARnRLmkZhzLlek1me1Scoe/cMP4uxyn+AUrGqEMNeJTRgvwY2wipLqgI7LH8mxSStdWrfz9Iw=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:04:54 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:04:54 +0000
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
Subject: [PATCH 03/12] hugetlb: Remove a few calls to page_folio()
Date:   Fri, 25 Aug 2023 12:04:23 -0700
Message-ID: <20230825190436.55045-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c6fe78-d656-440d-cf30-08dba59e2a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74PHp3nRoAJ6M9Fo0Pd0MN24HTz16HRlKL8Fq19+S5T8wbfui7T/x8rlt4ltVkoXMm0R5qBM9OXkIKLhHL4kRms+ltL0yg1Ds1Jm+IYFaXFBroO7dZ+AgRcaCjFWuc7va7kmcrUKi48KS6KlyrB7p5plz64QMsfdN++mIFjq7dP40Eb6Y1y4Ymx7WCJ4vNv+mYAcC3GPiAWV67la97jBaTeAreUIag6rM4hhYaqK4stz+L4SQLH+wW8TxjBY3hAIsBDYpJRjXOJjPww3U5JNcYpSBPF4eDqehcJh83FNvnb5wU7KseB9IcZWsaftf0eSlg0SPpa2TNGo6XgB5J/0bUeCHVWGrdollihAumO2iOe4IWTx+KxoddFxnpQWtJFpgRRlL2vupcDjsjyvU5A+eev6imKkwb0JVdun6yAvW7mt1O/YwKAG5iMXy8Vf4BOiKAAhS0eBZksfOlg7mwX5NU9yhNGpHly8gC/aDNHqENcJrgJuu/RkCmAvb/mSiAJIJOgTKpzanvmhNMubZbivC5KtEe8eaTw5njjGn/brCJPQTkBnP77HVoXH4bfv0yii
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5TgNuPOV2zkV4qXRtkdJvrtWhUYCJxqgmbDZDF15l0LJeOkCUU84H7uWfSU?=
 =?us-ascii?Q?iEtzqAxh+6PN1tFXeDjMeGDRJXH1yQmn61dErAzmTOgfD5PgAF+90thw4/7D?=
 =?us-ascii?Q?B39q0EUvu+nquUgMlV0E5YhFmNQ3vrnBibq0RNHnKQZfzcRn5Y3XKRtz+tZp?=
 =?us-ascii?Q?5QBqAT/vWPdWobDzVpRauIcJ5jok157r9lkxrrCNe+Ww5aoBgtSFfPsR+Z2e?=
 =?us-ascii?Q?ay80Wm81YXO2tNa7e0JFfmDI1wewaugPAYdV3Yn3uPnwwAKtUa52IxZoEJze?=
 =?us-ascii?Q?QdKzvgAMlI7uxmvdhAfwrtR4k9mTNwNx2XmzsTxSXaFOmBswLW6ePgKOq4c3?=
 =?us-ascii?Q?zZ5Mmm+ls2KU+ooPqB3GgzVGwizOHVuH7WupObXX/g1Cy8btpjph25PJm+PW?=
 =?us-ascii?Q?nSBA72rV7fMczza7VT3UCjcoJGc+3cKB/H74SW3Aa9kyma9Pmy9PyUI1Pcax?=
 =?us-ascii?Q?i4h+wviTLc8GSqCMSYVcIUxaNGaZAwc8YfZhEFoinMFZNP87x1v2y97k8TPg?=
 =?us-ascii?Q?aDoXo4NGUtbACzlfQxes93pHmnJnbLcgjOXeXMLZyhUoN3D7cyjEXbVLVUNQ?=
 =?us-ascii?Q?7HAEBE+yAaCDLk95zucl0/gzsOugqyD0jBp7VysehePNxYY50qAbnDzn/6k9?=
 =?us-ascii?Q?AVoS101gFNC+6WsO7pE/7ooGqI4FHewPyFsbyns70U9ezzPysrLfa+UkOslb?=
 =?us-ascii?Q?tvudgDzioTAh4XZUQuySu8Gt4hmFvo9BmUoReVn8FvU3c9d3hnFzaJWPhYYR?=
 =?us-ascii?Q?F4A14mqRuMhq5P2EM/MO11yRFeBuxnetZqsUQWPVtD9z/3nR+3IiHvJVBg01?=
 =?us-ascii?Q?ux1C97xmuDgggksJ9nfjjI+mFZr3e7KaJiKplZUN3j4+2CyOhsnuraoGiA0D?=
 =?us-ascii?Q?9lUWxc29oOVcevIAYH9XcLnHjkuYAJE+cCnkkEl9aB9xnJE5hIo6e8IXmmQv?=
 =?us-ascii?Q?VjU5z/xncWLeeXULz5hOdqOI9n96P3qXxEernNkbi8Pajes9bUFn57c38t5+?=
 =?us-ascii?Q?b7fdSLg9ILh31yjMvaglfNh7vjC+g6bftvivu2ISXBfvHgZxt45tLd9sng22?=
 =?us-ascii?Q?BAvCI7m5ThlR24KaZZKKJSw1/FDpPega3c38kmUgiVz9j+VccefXV/n4vp+B?=
 =?us-ascii?Q?kKS8NUoytO5ytx0HNu9df+frR9SDkQ6VFufL0Hi/Y8iQV7ZdhmlU6Qjp8i/n?=
 =?us-ascii?Q?GPKm9PGRgDbS9xvCJN7lR3uFHef0xhj+grXoBo4oFoS3trr5PY+VhiZSovGo?=
 =?us-ascii?Q?g7gVr4dFa62f/1sq/i9K7SSGQvFauUav/NLHqG8kjqW1+GyCVYHqzBF/w2l2?=
 =?us-ascii?Q?iVqK4KN83jHHkegM/MTgc3EPbK9sPtTjXzzeFRR2qhp2fEux5nQAn5U2JH5G?=
 =?us-ascii?Q?YjYQyw3fcdWj51/m4MPj/zqCTUSdrm7Yo0UCvqWNW9ZTY3rMa8RxckMuvQZs?=
 =?us-ascii?Q?8RtWMA2eHNTWq7Bq5f3gKBEnq5bMmxnBdP7IeANeGwDPaiK0uhKIZGLV9blw?=
 =?us-ascii?Q?SZoQwgx9hUqAauP8axFIgIbtWyosEc5J9Yv5v8/eiQ+E5ui5S0VFUA7xXoKA?=
 =?us-ascii?Q?mQ1Fd0HhocwC/m79rSq/lXaqOdNAU9H96mPffK9L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XYNz8A4oew/fcpsNHxzr8c46jc11uMYyjGx9dpM86agOsu5ASLmyDCTYcB/p?=
 =?us-ascii?Q?i9l+g/0XB9sXL4gTW8h/ee6P8zcPBUbMQgBK2S3olXI/s9QxKNoDUknXPSTn?=
 =?us-ascii?Q?GvuATwrGUGW9LlPtFfnPd6tpGN20GGNEaDXbBVYr+4jB9bLamqfrFUvQm/5z?=
 =?us-ascii?Q?fNqYiWxvzSbySjoR2GwtJBJoEg8Nx3H2+ezwYQMnE7Q2/fVfG/WoQ+PXcarB?=
 =?us-ascii?Q?iefDG72ieXX38PW9aVu3K9tO5Hkioz9bKQbDmYaIE3839TxVxHlrkFDPnQeR?=
 =?us-ascii?Q?Je0ZoXE13aZI0+W4Ur4VnfcAudNmBKRck2CyA3QpjugF9b1J1onGzWeM1W8t?=
 =?us-ascii?Q?SK0Td8uko7d4P1n2W8dFXpqGpqOF96X7nzJj35oRjkyS7eMkIeJpd7IPQ5Sb?=
 =?us-ascii?Q?2GBNiv27srNUZ9Y1nmet1VqadTT0Jo7APg3FNaqAATI32BQ1yg1jWEaoaB4A?=
 =?us-ascii?Q?9ouJCgVeJSLJ91z98le8SzhObtlWaW/NAQAh34WSoFMt6uY89USofQ8i7Ave?=
 =?us-ascii?Q?mKKVTh5AaXkL70/DOkHaTkjnoggmiTo0z1aQlqF7EwWpy+ENOEYOgYplNIFv?=
 =?us-ascii?Q?jomp/cG+67t4YKT1dQfRVNZ1vDbah6ufhbog79AaXnLtk72bzeQCaG1sDUa/?=
 =?us-ascii?Q?741z0VkjCQE/NP1AvGoKUhrBKPZ6vrjmJNPDoj72GhkVLCsNHF+aN4i4nwo+?=
 =?us-ascii?Q?KJSp2kS3/Mtdrsj3gcGJALuOc8VcrL/rEBuoAmX+dR7X4qD2HXWeUqAY4IyQ?=
 =?us-ascii?Q?dWWrYw5GeYRD78g+zn7T2JUZstBUgutEnVFGlx5ePEEPnpMKJaOAXW1WJsmM?=
 =?us-ascii?Q?rfm7+iCGAYbatkHfKdzor/FUZBSIiT3CuUt6KLJKzeju/wPnEnjf7JbX9eoG?=
 =?us-ascii?Q?QX60IFrBIc4JYfrf5tA0Jr7lyzXIS8jtLWCEwxi5HAm6i9nqzk7C6C85F6U9?=
 =?us-ascii?Q?yQr4JIOG/gpJKbJp7fdrfTI9TBfq5uoABCOQYFxe2jy1rv/ZqmUQlAdMin4Y?=
 =?us-ascii?Q?nAOptoi+hmnwz2wwoOfFve3l9d64QoVDFqpyiDrFUAFBLkXfgWMt4vFe56Pm?=
 =?us-ascii?Q?bvW3uVYzeGW0LM04J8AFBnRKpLxh9LULIX/oAKCcH7mzUaC8kEO7jeexHsOH?=
 =?us-ascii?Q?N1U7+nD+fVRB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c6fe78-d656-440d-cf30-08dba59e2a80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:04:54.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4viqr2pRx2yxE1H0+MrvVG6QMsocN7EvySr8SP3OO1Lme1rMR87KC5iU+uskIteL3QVmMBimJyoWeqYvQuO8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: 2OKrJiPSiCvmOy9oRGA8-kJw9qhUO_Pt
X-Proofpoint-GUID: 2OKrJiPSiCvmOy9oRGA8-kJw9qhUO_Pt
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

Anything found on a linked list threaded through ->lru is guaranteed to
be a folio as the compound_head found in a tail page overlaps the ->lru
member of struct page.  So we can pull folios directly off these lists
no matter whether pages or folios were added to the list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a48a83846cb..a5348dfada89 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1831,11 +1831,9 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
-	struct page *page, *t_page;
-	struct folio *folio;
+	struct folio *folio, *t_folio;
 
-	list_for_each_entry_safe(page, t_page, list, lru) {
-		folio = page_folio(page);
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
@@ -2224,8 +2222,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	struct page *page = NULL;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
@@ -2235,15 +2232,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			page = list_entry(h->hugepage_freelists[node].next,
-					  struct page, lru);
-			folio = page_folio(page);
+			folio = list_entry(h->hugepage_freelists[node].next,
+					  struct folio, lru);
 			remove_hugetlb_folio(h, folio, acct_surplus);
 			break;
 		}
 	}
 
-	return page;
+	return &folio->page;
 }
 
 /*
@@ -3359,15 +3355,15 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
+		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
-		list_for_each_entry_safe(page, next, freel, lru) {
+		list_for_each_entry_safe(folio, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				goto out;
-			if (PageHighMem(page))
+			if (folio_test_highmem(folio))
 				continue;
-			remove_hugetlb_folio(h, page_folio(page), false);
-			list_add(&page->lru, &page_list);
+			remove_hugetlb_folio(h, folio, false);
+			list_add(&folio->lru, &page_list);
 		}
 	}
 
-- 
2.41.0

