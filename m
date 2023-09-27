Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF47B09A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjI0QJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjI0QJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:09:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C2DE4;
        Wed, 27 Sep 2023 09:09:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFsmvx006126;
        Wed, 27 Sep 2023 16:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KtDGpCO23d7lFr+HvsCNeiHEhbnZIYWxCsEz55HGVpk=;
 b=yKldy1uZWF8RIyH3DtlG298o/UfCCCYrsKA9h6wogUGTYbmtDJUEzT7F1noT9V7O4/de
 wGBzsnTpY+U7/O7AVX6J3Wbh/xtUDTM7PcVTHpf0EV0hEKS+krTwsRoprJD+yjQ9s74i
 /2MGXzT6Z3tJpLaX9GAMX7f80+q3soOhK8csw/H79K+ywc6gcf+jO19wy66c+i3JW5Sy
 rFiuEHZaLHFxzkL1t441bhwNTq4gDLoxvXhWLp4sqimv1D6UOAEBppgHTRNATnb8Yn17
 499d5Q6o4oU40+SaKHhHkZ6MnXmQG2F7gILRhXDf74AgEoU8zFgDka+gUuoVLu+v8E1k Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3t014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38REvtav034938;
        Wed, 27 Sep 2023 16:09:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8egah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 16:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c11ENeWKMNgiXlwSnOFnSfpMnHFd7IcWo8DMi+QzYL/gHN5V2JsWOvKDFPo1vXx7BazqzIuOIToR67H6KS46oGJ0kcelBs3ziLXq9CH5R9cRkjuk0jQ3uWCaj2I/JozQd/n9742IcNo2nJ6n47SBLnSUTU+6ZIWUVXSlVRRbX4XufUrasdRANYNHKAYatXlOptFL2oum4LAkdG9vuKqrkswPdPZG9Xc+X861ZCZ5riG4Jx6BDrr+4b62Vrb7tTvY+HgoUo/u3tARbSiSekz29o3QkDblBJskJB7g0ddxoGOGTW9IZa+4qB3IGNsymVFqABUVLwlMvrJLza528JV5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtDGpCO23d7lFr+HvsCNeiHEhbnZIYWxCsEz55HGVpk=;
 b=JLVYC66YNMPWxZ2NsZQY+EoA63PHZRsFdbnwprtESckWbVJ9sqtMya4myfHRsC+iacXoctrR2BG7NmaX0gLqR+tS0LxvcKE2fAYBXA9BeMcGaDTYz5OR5JsiJoMp5uS/6rLQU1xpsUOVIz+fkAuCXfxkzYHENliOp2YflwUQUaRzYa3N9gT0DDLLRK7RVrjfPBoPjsPMrtVLAZ8BGNzcGGUsqx1t9+rBQlPwl6BfzSf8QGlDT2TvgYzHo81M2ygXPjQt7McNo2w7kTdfuxQP0wkQagLEHMENAURWo7Z4pasMUCR53yhn6XTt5N9TGa08eSWWtO84xmQEyboZQENpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtDGpCO23d7lFr+HvsCNeiHEhbnZIYWxCsEz55HGVpk=;
 b=gYm3V6Vsw8YY2zX+UdwCZwBQSmQCCEEowkrgaO7XfSkRREVtjCCsYN+wqjzzL91obKq0/1VY6jlV1ztvoW7G8wR0UZH1BxsvoFX6cN/6pJuDqXb8CWnsB3g4H+gcWWmRVPLRQ45ffqR2neEcAMWNdE9XtBoGaZlqDoXR+VXOhEs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6732.namprd10.prod.outlook.com (2603:10b6:930:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 16:09:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:09:06 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Date:   Wed, 27 Sep 2023 12:07:44 -0400
Message-Id: <20230927160746.1928098-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9cd043-41e3-46b4-59f6-08dbbf741356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCaZOQtRrody5Ui+mw+F8dC6UQuYpu3KSz/SmY5Jknl7zXvoI+gi0L9VCi4n01EeAZwnxfnTS28FXLe+LMoSERjSGlikaPo+5nou24mMuJGwJbyK2ih33ddd38mAlHb5eOU4AtuRwPqOWOAMZHddDCATDDuf1qaIDSbztcQaMQeSuqV7IdrVqQahmff5NS3Ew7zajnF9F6yEdQqZkYbpc3yOhmU4HAHcQB7b9aBW/GtyiAExONMTmdEHO4xeqYzFBwtx+xNA+I8Wu16K2WlyVx1SKlarKOoc0toWRE1+OlMXfs6E82BkmplQ1Ia+PWha78QjSLtzNGad9I+DfkJfFlti+gr8mVTPa+A1/bjTLWes1fZ7p4txLQhyFZpftwHzf1syycPg1fxl/e1JM6TYdZlaO+7C/f4wUE9DSyd1B8pH3s+OWNPX1+rZGT8FSUImpMqBNnDRXA7Zsu5bg75mz14IMoFEYCLWouaRVDlGqxO6HuS7LMB/g+kJYs2c5+DFEMWmBTGI5ODmunhJDS4+REluJwsvCagzlyUh5J2RDhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(6666004)(8676002)(478600001)(26005)(8936002)(54906003)(66946007)(7416002)(2906002)(316002)(66476007)(966005)(5660300002)(38100700002)(4326008)(66556008)(41300700001)(36756003)(6512007)(1076003)(6916009)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3cOntXIRE90qXqwLYEi069EThQ83mRIaOS5t6x1VYdTvDlGiMHOh8LLY95x?=
 =?us-ascii?Q?Y1e3X6AcxvEjm83IR3D1kml711Dc27FwZ+rITLWWVKVSfUA12lNq8eRtEbrt?=
 =?us-ascii?Q?c7xeOEwG5fuLyvjTrEF5ms+ZTphje9SDVVswjoJXcZkjP//Rfgzr+bFn59tO?=
 =?us-ascii?Q?M52vqA5PF3Qpxd5MnuD0Vop8jP3QvKjtzMme+d1mJgz1A29odXSbE1gc/h0a?=
 =?us-ascii?Q?QYLDUsBJbyf4Vqak6z/omFxotGVuXPIBqqOPWqOTgnJTC+ejnRL7a6207Nrb?=
 =?us-ascii?Q?UlRSKwMJP2M4FbWalMJEGUdCJEDFRnGSoyv+ysa+SV/VdRwyumCgJ3/oOXVl?=
 =?us-ascii?Q?RBFtyGeSBVhzfR/MvqI7rdoi+NrmZoZLdfepoGIQNFVoej/gXFaY/S1BTvcx?=
 =?us-ascii?Q?0im5CBvsn1OXmTdi9UuVA0o9a4P0bEokZNB8X1M8FRnwWiVycSNpxxYZ/R1k?=
 =?us-ascii?Q?cOR6Y6LqJsOkiYI243yPbx0ZltaJzNeWM1VlXHO/o7SQD3y/7qfe9jncKXaE?=
 =?us-ascii?Q?qL6MShRbsmr+oCfRikk+Iy02w4fimD+5+HP5MvVuYfIBCXpI6p45UPp48RVz?=
 =?us-ascii?Q?id/Ucq1O/UFnI3xTy4aIAN25uOtuMhWe/WHleUnrTaJoC6mOFcAWgDTicc7U?=
 =?us-ascii?Q?75+ok0dTIjJPkKeIX+heeV/0qN5eFlObbuxApZ9BbPXupp0MSl4UQTCG0mTi?=
 =?us-ascii?Q?XMMRtZy9XitDBmlu8iMt94IrRj90F0PDzLLkX+lkq7nt9BrHglnctFzEjDoS?=
 =?us-ascii?Q?APu/qnf1uLctWX2N98L3Waws2yQiL9J/Qk4bxXBkVXe4Guu8pmpB1nVsiRWK?=
 =?us-ascii?Q?oanKo0gJgfJv/oDftJYqslUyATmeGs2WSZ9wJUg1gD/GHk5s0eBtxVA9GSQ6?=
 =?us-ascii?Q?DNt3inrL13iukHNAncVsEE/dYIftSN6sDrQG16GTnP7KkAsI2tn3ySgazOVa?=
 =?us-ascii?Q?iw+rSRZTHI2Ov4h2OhsrmLvtiyv3aJ/B9EDButLQLxFCAVkJGQUit4XJIpF6?=
 =?us-ascii?Q?lYH2vx3gUuymW8v2fWAlFtsvUQtBWDmFoYI9YR5UW2HIZ05NCI1qnO/29Lrn?=
 =?us-ascii?Q?9DPHewkzvmoyQjMOJiVQZ6zxIoCcx63DKw6KWBAHcphmDCUS4cv/Lt2KUJ8l?=
 =?us-ascii?Q?zdJL2Gy04/U6pyV4oH6S4BYVXVwX5whokVqRZVkWMoYX/+U1Wimeh6KoO2yh?=
 =?us-ascii?Q?RM9yU2wcYWxghIkvJBLKa1Yn8FbLSJURf335CTJR9C9C6M5yVK7jzk6Aqwaj?=
 =?us-ascii?Q?Djb3bYKHnK77+arN0PerMdwtRwk061Ssim4cpLvHR8tSuzjOQBsg6mnX76o6?=
 =?us-ascii?Q?PQXuUKWAc0SmeOOe45xgM7//qBsqsbcFiC48vqF/LObr3MZ0uqgJrAl5EJcT?=
 =?us-ascii?Q?AM11Raebss+eHYRv4DF3DPY+rjdRawIjVSF0zkWZtTHgA9OVeQqrVTDFZHNB?=
 =?us-ascii?Q?Icr2uYh43iw/PdDRSoiDQ7BZBdAIxBFNDem8c8xEW9I6phaH2VcTAJsebQJm?=
 =?us-ascii?Q?IGhHoOioSnwKMhwlJAsYeSR6/Kb15vO/93tYpGzk5qpQrXQEiiHpa7GIBtd7?=
 =?us-ascii?Q?pAgBmDjd5kkLu/fwGx2JN0p4N9nEI2zlEXocLY7h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+5lQ9/C3kHw+/+larSMaWyvs1mTwJ8sgj9ZSoz81twPC6PjdgK7mLr/Pyao/?=
 =?us-ascii?Q?GkzvsxfG3lxRsq2sxxykGzM6F/zoKNE4ilHdFiTAf3Gp7IZhaDFJiLiQ3gId?=
 =?us-ascii?Q?iZ/aDwUGYZ+FtAaie7/8nLunYZHMLc6lMcYp1kdJtwMYLiwtu2Y2oJOgIAbP?=
 =?us-ascii?Q?QPLTjhmkKEG9YnxryMNXASyUVa688BP/MtLNb8gLvO51faqYM6TkmRpNFTHk?=
 =?us-ascii?Q?s6fRD/ER3YtaagbL4GO6o/SyLjtu80mS16wjgS5g/37nj+mBBQHi0Ty9CFea?=
 =?us-ascii?Q?i4oe4uw0SWgQJrE0taoTAvsgG9Sd2M6J1kHoOvLjofcywa5ZjBIpIhtud8C3?=
 =?us-ascii?Q?t2Xvu7m4qNVAIYb2VSxNDBuOcmj/veCosEFDcnGcIwnYlrWqP9ngiEFlyV+t?=
 =?us-ascii?Q?XHwMeaaHGsEUyuux9mADa+Zt7o+RopcsKAcPb12SnxlqMEAW+scDh9ECriyo?=
 =?us-ascii?Q?ABYVKDyZSwUqezwbevm8fhGVV56B0ZDrZAWvQrgkqxPXetzK/NmP8FVGyKCm?=
 =?us-ascii?Q?m8mlnBb76MnlVixlSVvjcupD88JxWK0KGbcCKjx+0uOEtv2Yo+AB+Rnw2nsO?=
 =?us-ascii?Q?DL8Z1DKS2n9iOpJsfkBnElV/EtymvPNJwc83Rkb6neTgRFp29E7FBgrdqzFL?=
 =?us-ascii?Q?7sRe66lfjreONw28/x+hFUZDTLriq5b5w1JlBujS2aVPp7N3q2Byv8AjvGWD?=
 =?us-ascii?Q?3rPZeiQBeE7pi98UWvgIPC1lGiwT91K+jFXQr+9y3SJCbaGGJIBbq09YWAV2?=
 =?us-ascii?Q?bj/uYMkcyzJDd693WUn2A8qGZ6ehYW3+LHbX2K60lHA5D/LOD39qtUaniK/B?=
 =?us-ascii?Q?jTG87rPvosShlwW6p42BtDpnO12xB6mw3SSLUBuG1Oxnf9FCSUyimvmmbFGU?=
 =?us-ascii?Q?9i1SlzF4WsW0JGck+qEDc+2AovxQKxBr1XZnzhQ8DdZhMQHOtpc2FoGlcEdg?=
 =?us-ascii?Q?tm15lEsPWpv5+nh9CWx2D0pP4r/KOFgHgQ28orFAiMkN67VbPllTG/F26cRz?=
 =?us-ascii?Q?PcKs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9cd043-41e3-46b4-59f6-08dbbf741356
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:09:06.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPL8glYBtrnKXB4dAS+4yYrwoTrvjFX7hjXCw0P5hzfsnx2Pxn2NIV2uQI5dU2Wg/VMnvH0pPco8bG3+dzTQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=963 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270137
X-Proofpoint-ORIG-GUID: zHjT5izFqsTTEteOhQv2a817RUo0Trcg
X-Proofpoint-GUID: zHjT5izFqsTTEteOhQv2a817RUo0Trcg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When merging of the previous VMA fails after the vma iterator has been
moved to the previous entry, the vma iterator must be advanced to ensure
the caller takes the correct action on the next vma iterator event.  Fix
this by adding a vma_next() call to the error path.

Users may experience higher CPU usage, most likely in very low memory
situations.

Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..b5bc4ca9bdc4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -968,14 +968,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				vma_pgoff = curr->vm_pgoff;
 				vma_start_write(curr);
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
 		vma_expanded = true;
@@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	if (vma_iter_prealloc(vmi, vma))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	vma_complete(&vp, vmi, mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
+
+prealloc_fail:
+anon_vma_fail:
+	if (merge_prev)
+		vma_next(vmi);
+	return NULL;
 }
 
 /*
-- 
2.40.1

