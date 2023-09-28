Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318257B2344
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjI1RHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjI1RHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:07:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DDBCD3;
        Thu, 28 Sep 2023 10:06:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGisJ2013300;
        Thu, 28 Sep 2023 17:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=A8U9h3PY+tx5AOqRpvlvOgpysjfcISXc4uGsedyga6I=;
 b=SRYzGN+8Mphf002KYFIsNLG6oJFLD73PPPtOP0lpu7PD06bBseXutouQY8ik1u7tJNau
 ZerUSaoqp2tSb54Vs/4Y9GmPiCsFMK4/CkhUk9OJbs0geFBHqp3nEHyNrDj3pVNP7+tz
 v68L63lT8MsUstm/IEclnZ9jbrVtVbjCZKlLkcdWJhA3OjVyNMhxT44fh2Nq3Wtp3Yjo
 IikWayP2ChnZcWj10FvHJyTlhqvvOdd6tdKAb9GJvkUlStgSjzjLXRr9erZvfxfl6VVJ
 xmhyOvp5dR2MTTZ8x5UJgqj+mSi0IVEg/usXf0kQ2K5DLVRH+wXGt+585C3v2HVOYJd6 Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbmxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:06:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH1HTx025358;
        Thu, 28 Sep 2023 17:06:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pffyqdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZYTllztIOhsWbhxXBzgp7zrB+9VCYYv61TgGIEMzuXwnfs1aMwjNbwyCY/jbe90AxnNUn3dGwsriWjRB7kN5Cxf1a+nI92u2haJkL08NfRFAMthee7u2ue82SRq+oVX85UTcZNhwSvT+Ke8Z9Li5rU5HU3Xcl3puYy7tgWO/t8cEv0TpqYQxNQTzvjArH0de8HibRosxKsEZhl3+kP+y0byvuBdY8aWCp7gN06QaqLBjZDaX3fYU/bMpkOgz3VaaFUedW38LtK2b2QeolOtN6O205AmVuwSTviRFOCJ216fZL6+sIvCKfIdhk3rNjqH6rdoouymNWMbiGdIappigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8U9h3PY+tx5AOqRpvlvOgpysjfcISXc4uGsedyga6I=;
 b=CgOu1hoD7MUEDR7L2Fpol2ZIgVb76OsM0dNXPK4CdiKe6ebQqVJIZEZGMdaU1OOnnhY9LtihV3HyrCpTM162Mv5zmngigBJDDWguzXGQREfjTS9UbNk4oe5ic/V945Pk/8lh+UNntOLXF7NDmJalG2SJAkQJKluxAZw+o115pEkZFr0/L45wjgYCL5WsAYdT5RojZuFg3/MJdUZ9sIjliOI4Gc5IGCfuGj+ZF3MiIhdtHuTa2IeMDX+mzkjP0/pg0reXIPR086Qx2kmZcuK4TqnlD7gkLayw44//+L6zq8MLuRO2DkESx65EPdf7p6wsnIxxJjtWx6LyB7G6RFAu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8U9h3PY+tx5AOqRpvlvOgpysjfcISXc4uGsedyga6I=;
 b=q6MgBv5gkcaASQzWm3nqawEIClqt/iV7W7efPDGq5Lt9la0L07BoRcrJmZm3Z7Uar/CK0jWY7V+dP5DJgweJ6f/QG6dWdtLNaGm0GUeflGBy93k66li4YmoNZZQTZfj7lxbDagB7jForb/xaAEUdepY0bUkGZk2LBGkkgzh8yi0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6031.namprd10.prod.outlook.com (2603:10b6:8:cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 17:06:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:06:13 +0000
Date:   Thu, 28 Sep 2023 13:06:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-ID: <20230928170609.uyugdslacbvaw5kc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
 <20230927101410.920fd8a88d2453f5c530aff3@linux-foundation.org>
 <20230927172649.tivg3yxtmzo3fzjb@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927172649.tivg3yxtmzo3fzjb@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0036.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6ab623-8d9e-47fd-ed9e-08dbc04537fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79QlRnTZlHjDaD+GpKrJ3SOQSS4SA1mXIWncFWiPBKVmVn4HrsnzTn58JaYXdwPyGM5uJDigh+GuX1QoAck7mb9F7+YugO7eMKxDpouqCKlBuvKeKgZgFi77NN3JWsacjqAcDMnkG+56Bxlw8vnbWPJeyJm73rfiGn0N8YJoZuCNoYyXz1mATJxTfl9IEyxK6lhj/Nxnc2TryEQbB0iHtS8tsKcVpQ8lZ50i/F9FFGHIFeGPtZXlD+THPgmpy1e/yEl83gYQuiiKZa98Ih8YW+jbiemNJ2UNUDaWZUnD874Nut9BKFLuzVAw9G9lt2bNkxcYUuxi25rEVXn/04uy+9A7VGcVcFiBp84SqTryPsy5WHV6ItVOyd6KM+vtYX3w3juvH7dHE0o6MEf2nhsUNeHm9vKtlT0yDfHSy/xzAfDtIIIkZ2e3ziDK1/HRX/73xNsWPFEWunv9xPq/1okDMj2FVximmURnnR5dOet1oqPveG5xsGUkHz/DQVZaz8DI+FuXPPfLTJfoHkMCsA4McE673mAbLwSTBycqQIJGbOVNoKEaBz4+7xNk1xZ1sjeZc5k+JsxhM/t5hVKrq/WJ9VsQTkAKqKE6roE3Kgil28w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(5660300002)(26005)(41300700001)(66556008)(110136005)(316002)(7416002)(66476007)(66946007)(966005)(8676002)(8936002)(478600001)(6486002)(6506007)(6666004)(9686003)(1076003)(6512007)(38100700002)(921005)(83380400001)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GB5AesVVTNwzNr+E0CbyCiH5tHIwi9BW/THeIjy15/VRROHrmwwZG/KNk6Kl?=
 =?us-ascii?Q?0cfEAOdcyU8X80NfH3wZBm3dFHhrsNJPKvTNv+xN1uyUNlYhZ1yTIJoHy2gU?=
 =?us-ascii?Q?xIIOUa6msbfkVHe8LPaD+thQv16g2TzvhTBoRDr1zEGZ8f6kuXANGBDFrp+c?=
 =?us-ascii?Q?TXpWhcMNgZc9N5Tmtypc+DFBDJG+lmkrVf1OuCzxpmJO/47zgoj34+EinLWb?=
 =?us-ascii?Q?HNrQF7JeBPPaufP20eSEakIzubueEKzo/Tljk6rYsAvWmvcB9wmDhmFgSmYh?=
 =?us-ascii?Q?FmDVSv9Ku5WhnDw/fm5pgVqYpTARVexLjY5asHVHNSdNpqfOsTLI74kWx9lu?=
 =?us-ascii?Q?Bai78PuPKa4wkO6abtdcsMKJ7MTHqbT980cFCS0G3esqo5xx4WevOMy8rJ3d?=
 =?us-ascii?Q?nrxnpbM55kGk+G01YJn2q8LKVaK4lldLxk08j5EexRf4d8MPWF2WerbvVx3J?=
 =?us-ascii?Q?Ie0ME5HNVqCTov+LeDAXUXtHFCqVk3qlGEcRCF6i6d0XY9xqEOknK/rEePTD?=
 =?us-ascii?Q?UMum7v3y4e3bP0hBl6dPImOcEZ941HdP9e2W5lgODRziR9ZOxH+IAFYf+MOp?=
 =?us-ascii?Q?hnrTOtEqUNzb0KEsxKbj9/AeB3Ge+pqIWORMOT+484RpggGNGMDctYQUjnSw?=
 =?us-ascii?Q?1yZSrmKWsXU4AIZDg1iGLxkZQkjcEzOMQl471m/2PGqFHWKetJdqISqsrhmN?=
 =?us-ascii?Q?i93k1PbUYMyQ/8iWuR16b31IeUekxgh1W218dfggR/4DqU0WYUINqbthT+rc?=
 =?us-ascii?Q?3wjvUmzNX5e+IMZxhign/PglT/WewQKYjKlPSSwK/hOS6nGrwxsjyZZHNx98?=
 =?us-ascii?Q?Gh1h5PBSumuWERvBuqeYFnwMDpNzhMa1/N/9XLv8GtmI8+wEY7D0m4cINV6/?=
 =?us-ascii?Q?Nlz90EElE/i8saZH6MCOJc3ZhZ8rdvfwq4Bw6kTtPskE8QppVsIznwg0sTYl?=
 =?us-ascii?Q?QC1w6ahSnhiYNMuNho/xG/EYL3LeVnIZziIMi+i9NnxpkRIj0AI4++r+vxFR?=
 =?us-ascii?Q?sNqwu/gds84Lup7BE9QmNRy1pv0qfczoK9ednMbc9e2JLunkIc1P8O7C9mQM?=
 =?us-ascii?Q?vAVEWPcu3OoVDZIWB/fa1L7dLF93B0xee1mydetRRtmixhlIPFb6qGWPcISR?=
 =?us-ascii?Q?YLz/tMqgtsQD6DiBcffiB97iPD25h1QHZCHA/GsqHS0qX60phYXbLLi0sPBU?=
 =?us-ascii?Q?SvdPzubDRwM8FZ5Ykdj6NCWwj9/kpjJzeUX8GjGi7GT1EbrK8G73fIBmjgjF?=
 =?us-ascii?Q?6RC8NWH337eczLmN44J+Og7dQ7Yv9npUkecYXK5wpkbsqGBqXLVvHHkrvABp?=
 =?us-ascii?Q?0flNer5Ezd96ZdXCBWGcHljyqZb44x5/BCPTRSQb9GLBRGr1gLFB/M/ofusz?=
 =?us-ascii?Q?589cyCtwK+5oZJe1ETclCKfEDMAolX6hro7VXvwZslT4bWbPDlSsqAl4BaZG?=
 =?us-ascii?Q?i8locmg8N6ArzgF19Ldj23kuEW3U8dEGDHRc7MRvWd/AnA28fDFkUTw67Y33?=
 =?us-ascii?Q?IxtFLvhkzrBu+Toh5TLpZTbGGHxplGC3wxpw8edzIuSDyL0c67CtOdVjqPCd?=
 =?us-ascii?Q?uAtF9f/hEvaMxxzAAWMt8ub9a3IMVm4H5R/4muif?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?H7DRsQeMF1i05raoba4AwIMTC5/gYj+o+hFB7w+5Pr++9BbX77ftC9sXVzsX?=
 =?us-ascii?Q?Kk5BCGC9exKKRIjLZ3N/nBvMDC1x7RAkjOfwDWbqIVSjzFniwNiW5uy1a9uH?=
 =?us-ascii?Q?6k7EnAP9HrDl3PTlwj6y2nTHB1UG2MccWb+UUmeuDLGyNv9Zb2uWNLmIaO1h?=
 =?us-ascii?Q?vylabxxLYquF9F4ET9zYtiPLV5XpswfnUzHeigOWhRKzbxQgKR/pctzO7fdZ?=
 =?us-ascii?Q?kjNberMK3LE4dd7/De9dLvQ3ldktYrL3B6NkpLPIGTpjBGDuFHSMP6PEhzr+?=
 =?us-ascii?Q?yCpCwyYBplITKN8FjAaRsqFA5Ot6YO9GIUJISa7sbwkngeUGaJbQWe4y+LNi?=
 =?us-ascii?Q?H0HOoX3eqZmBhWdfYeek96ZwuNKnrZ04WOE8ksrn3n+kIYR30wxxgv7OHsLZ?=
 =?us-ascii?Q?Xs5S5r/x7GJaCeYpctG/vbBFRzrbPA70DJfYnHwHVCZfBLzh/wMIW0C/nIUN?=
 =?us-ascii?Q?v7hEZC9QkKwBBvhRBjGyJXLDy9My4fZtW3385sGGg7Byyd7yobjIfMQoCwjF?=
 =?us-ascii?Q?kHOEcBd0Y2pPpnv2yLFYtjRLj96P9IadI++5vjsPHGwmEBxvUH4hgkzTKo00?=
 =?us-ascii?Q?K5VKZUtGNIjj8g55vMXfRDpSZ8LjreRS1MugDMsN8/bOJVxkfIlo3Uh2lFcn?=
 =?us-ascii?Q?vAvDLvguDVJrWHWnzd8Quzqf3R48F/rz2d5PSMb2Bp1aPZp/bKLTE8/qPXWJ?=
 =?us-ascii?Q?QOXpoUmPn6kxE7KXDEp9QIJ+1/TfYnl6wbGwC1B+gvLFVkgygq6UD6ame1KB?=
 =?us-ascii?Q?iDyclHnbzV13QZU6wtKV68rnOjrp3FTfYl+6rm+OlGuBUwU1SAWG8DfM3cEu?=
 =?us-ascii?Q?XQxvzVjTxTaAf/YGGbhLDbHVMdUI+oPNESYdLTeCLtR76IGW2aL/prDPhnvU?=
 =?us-ascii?Q?w+m9rTiD7DfUckAuQtEQfL4YF+CEO64Hcx9ISEtfrVJOkrSiQJYGVX9iFLhI?=
 =?us-ascii?Q?jqdMficYk8kALrM09FiXXOfqyZdQSgap7KSOYB4SgZhZMYdVJMIIehVlgb5i?=
 =?us-ascii?Q?v3FE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6ab623-8d9e-47fd-ed9e-08dbc04537fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:06:12.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iiNmJxzHVV3DO9z/7jD8rY5nXhikKPx5dv8KJtOajiuxz5UgJLhRpMmrOjRqKJzkya/pBFDP5lt4UZed7aMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280149
X-Proofpoint-GUID: Fqslbb28uQK5G8NL5IXMyJ0aiDRXMuab
X-Proofpoint-ORIG-GUID: Fqslbb28uQK5G8NL5IXMyJ0aiDRXMuab
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230927 13:26]:
> * Andrew Morton <akpm@linux-foundation.org> [230927 13:14]:
> > On Wed, 27 Sep 2023 12:07:44 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > 
> > > When merging of the previous VMA fails after the vma iterator has been
> > > moved to the previous entry, the vma iterator must be advanced to ensure
> > > the caller takes the correct action on the next vma iterator event.  Fix
> > > this by adding a vma_next() call to the error path.
> > > 
> > > Users may experience higher CPU usage, most likely in very low memory
> > > situations.
> > 
> > Looking through this thread:
> > 
> > > Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> > 
> > I'm seeing no indication that the effect is CPU consumption?  Jann is
> > excpecting bogus oom-killing?
> 
> His testing injected a bogus oom, but since the vma iterator may get
> stuck in a "I can merge! oh, I'm out of memory" loop due to the
> vma_merge() called with the same VMA in this loop, I would expect it to
> be increased CPU usage when almost out of memory until a task is killed.
> I don't think he expected a bogus OOM since we are using GFP_KERNEL
> during mm/internal.h:vma_iter_prealloc() calls.

The initial call to vma_merge() is correct, but on the second call vma
is the same as prev so it won't attempt to merge prev again.  I think it
would only cause one extra call to vma_merge().

So I think you are correct, CPU usage will not increase very much.
But, there also will not be a bogus OOM.  There will just be two calls to
vma_merge() for the same VMA when there is an OOM even and we could have
merged prev.

I doubt the user would notice anything and they have bigger memory
issues at that time.
