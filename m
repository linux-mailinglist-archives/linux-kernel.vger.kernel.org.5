Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D07AB4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjIVPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjIVPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:39:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B941102;
        Fri, 22 Sep 2023 08:39:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEEMHO002835;
        Fri, 22 Sep 2023 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=n7HMNGW0DLdIWS1oDQuLBkxVS97BEvA55qvFbneqnOA=;
 b=w74ObqzMZk+4H+tHQ+1QSzPHwTxZQoqdS39tGL//ByqJWo1GaB1/xdmJ+kkEpyl0CTpF
 PW0A8fywhKhSPGWWNc8w54RRuMQFOPZMK0SOd3eEgGqJRk3nPKY4pUJCtQQylf+eWUkQ
 ACC1vTEdTJqNHNr18FR+ofEiSigBaSUqjrl5bRg7ZSf4PaXqRJUZ877gDkctSZ0GsrXZ
 7PNpHQvqB1XhfNZmYLsJ+bs/3RdRXZ72vHwVQ+xfZax3e4BBBnAqASTkdr6YmmkNy8Zw
 ceQIvoICfSlk5sr4N8NhgCwlSXivzVuqTovLoywrAMKdDFu0r5t3PhPGagG3AeSHFe1B rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tswj4nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:39:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFPexR007691;
        Fri, 22 Sep 2023 15:39:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhcwva9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=calJjOURpO+v1juT2fFrTAD+ZytoNCd6aQowGVTORiARNAxnCf1LctaDd8u3iW9K1pvygzt2Nk7InID6tcoIbkjDr1lNd7OFTiWREqbHBZfUKsF3mYVaO3H0rzbHSvTnXHTbHgrS7atLiUOwNwYxFIKU5/aL+wMHiPdY+/yp9rOb2Qecy5emRIcvXlM4aT5F/+hB7JdYm4uZEnOCiYSA4G+R8oVMP/HnVAkDLhFOxAW5UPLQ7AdPnwKcSpbvQYTKRHeC15kcwEn/3ETnnFvDcLvoqekO4PJSxpC+e2E5PBCq+pmJY3MHsXiukRxmXYXZlgjSe6JSo77HYnzOanNnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7HMNGW0DLdIWS1oDQuLBkxVS97BEvA55qvFbneqnOA=;
 b=E54p9PEwABlk9VaGDh/LPmBELoFaC3A0qOK9LPIgZRU4JNLe1iDGbherjD3Cqf/HYZgz7gw+bTYbd6mrCNuYtgSz/qpYRN4lnW+O/XSA0qJH85k0OcAESwtxOaPgI2YA+mBi6rTgc0NLZ+UDSxEyqKYLKtvwh7ByulPdQLebON2KLvukdVTZpXgcRkNUX6R4VTGMzJHjaesSBfiO9FcsSx5qd3a2RoU2Ujpa2Ks+zStIKSyS1rdxEmzHLChRmIxwLsC7Lf1uAoYSrNUroIl1sCdtJKLs7fNyHBw+o7+y2TMShoNVu5ft8IGBEXeUjg8XJSlS7H/zN5Ztfk83p7ps0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7HMNGW0DLdIWS1oDQuLBkxVS97BEvA55qvFbneqnOA=;
 b=JW2rMDYI9S5RefHSG3wbBLjdXgEjzms700rPfgzKR8uyT++fCVmlhaskXsZ/yIgqCZDlJ8ZTmW6wc7fEv1IYie9A5d11HM4qD1BU6t5gcMEwEw3dSMBC/eRZqcYXbziv+TJfoH6i+t8iPD3AqUJARnQK+J6uwXE85tAzscOXzwc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:39:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:39:01 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable@kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states
Date:   Fri, 22 Sep 2023 11:38:53 -0400
Message-Id: <20230922153853.767603-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922153853.767603-1-Liam.Howlett@oracle.com>
References: <20230922153853.767603-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed64d54-5a4a-4bc1-4dfd-08dbbb820b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XU8HqeQhGKuiMnRgjA4njKO5P284kc2D61pQ098TEXN6zm9gyRqPK7KwAfudlai3WZWVF/y4Z0TfuL1htZVHnxvzwkVzwFyFYLazNlEuYbFJl8wDAgTiJ9nlph9TvbhhVOn1IBG3Z8AkAepJNqvAv98M0wUTNnZROs1bBvvz5rKuKz6xkZ0T9sBnrwx0CO21fABJNo6TjQDGbBib+oB4Y8xjdvF8PusFCL53n6qmvwBi7Sa4e62CwSrNxNctjptCoTFcD9KwClOeBgyK4burRSrpPyY62TPtyD0LP00VGSVy8RtpVSWYLg30fCLiM3thtIWKwwTXvYzFQyHHdVExe8Y28jUyOG8czw/RToyLH470dQLZOr9rnMuEad7VgsLSbHznxvDerc1eMhOiaiyWeEMROfLevPlOTgAnkExodgr1SzDpWbXy/mRsA5BPxApmFP5gAkdljuJ+jK/IXeO9LuCx0RnROsuB/FCJzdxBFgHEbS7WlpYzsNPhDl/n3Z4Cymhy5PTaF+UhU+zV1asGDkNrSVTmoDq9apa1wGOzztw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(316002)(66556008)(66476007)(6916009)(66946007)(83380400001)(6512007)(6666004)(6486002)(6506007)(1076003)(2616005)(26005)(36756003)(478600001)(966005)(5660300002)(2906002)(38100700002)(8676002)(8936002)(4326008)(86362001)(41300700001)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/l/d7+6LQjHxC9iCUHr3hsbKyItqY98pMSDKMLQmqnWyy5/VOoUf5w2K4jG?=
 =?us-ascii?Q?EaTGGzgXST5damX1LhnvpC9+CsfauWov6yvYEDcg8+/NPGCcOCdxO3ODopMh?=
 =?us-ascii?Q?Dq2PhlZggjnBgnrqDH6SrjdMufILwbna5UJiIyB413JTpsVqbP83D3MPLHeZ?=
 =?us-ascii?Q?Ns3NsMogfYTFoy+B29q2vKA6AjvnVf73rmykwBHSWbYjjNiQafkKjUpdqmyO?=
 =?us-ascii?Q?waQi3P00NU9q10545hCvdSAMWwIxaWcJZK+4pQT0P+Dq/aYUmplTQIj/Ccaw?=
 =?us-ascii?Q?cQfItO33N9dHkGV8S+seDOF4Y0RQNHBUAbdtIx1inkCE51MMD5zV1bxm3N7O?=
 =?us-ascii?Q?9jColiS7pe2i/2t/5CAoXEE0w8YQbZ++h9EDYJu1jjBYXufSiUkatcZvJVjf?=
 =?us-ascii?Q?5mRPcCq7yoTKaiO3OWwvn5XtAgdnGDsLfO6ksvMZR70inWm5oVjxWwkgjvIh?=
 =?us-ascii?Q?RB5FAtnGw4dbVlIQfUTtrRGb8QiVnOSGJb3TXgGO7L0bymTtcgH1JJEcAOe7?=
 =?us-ascii?Q?TJSxLlGcAPoRn6KC8dpULq7d4jsqNOI0ejDS0Y1PGxjazcg4QzyvRMgVOjsq?=
 =?us-ascii?Q?r/pis9qt36DOF7NG+7+EbXyXXDr7mJSeSm5/10ZqKlZUIV6l5D7BZ2MNM0br?=
 =?us-ascii?Q?wXY574NdZtTFUxH2hCeLqYi0PNnGEPflFnLpxOXsFYeQRjPZP8KNrJoefmvO?=
 =?us-ascii?Q?uwGSpEDxjUQUfgHnNXMqylZyPvpLcXMPqFDF5hfOtkkNMdv6fX5RqtCEHDg5?=
 =?us-ascii?Q?xvlWRlIAvsIBjWnGbQJVC2KLn2bs4hvrl5qRpjJGYbfwMITZ0Zc0ou3p1QdE?=
 =?us-ascii?Q?D0dU4PArHmWTYWwaiIIyAdOI3fBZ2GKKVkH0xKYzBiqCNC2v5LWD0c5gvCB1?=
 =?us-ascii?Q?b7/yzL8UcZIesW9Gz27VgpFfVhzp3CbUcdfgOLKWIGZf8stESKqx9CmxIy+c?=
 =?us-ascii?Q?pC44mwIohn1zVUA8/QwJv+JxpMIhHtTtdt9Dt8g0i2ljzwNTgKcRogwaXo16?=
 =?us-ascii?Q?yOQL5RVSY08GBH2CdHYyZG8Cg79X9CZayEilz8liAfTi0sloRmw0el/O4s2O?=
 =?us-ascii?Q?1BfFlNNMbkXsxEuEQPFo6CxBHcyYiLu4VgugmpGk4JWxp+qQTQ9ZJ6pbJTLu?=
 =?us-ascii?Q?RRSb/zsb0gUtL6qGtSpIvW3+n8tSuWGVWwKu87ghZwtsg2m5/Ygjl2paERjL?=
 =?us-ascii?Q?Vdg/W+sJMnf/qx87CV28PQrnzLOuxQO/Uxvw69CalMgsRQbxLioZ/SpSSOAt?=
 =?us-ascii?Q?wZTlDEddh9WkOIiEuHVE0tf/JoFjOalA86zaH9HPqaEMj2RYeUKbOmeo3Plm?=
 =?us-ascii?Q?UWinOG5Abppv6woPrdSwvpDSBC2xBPI1e11QrOqWo+0hk7rL+mjG8NMjJqRE?=
 =?us-ascii?Q?FGhqvfu1AyMNikWNBgKCB2kU9f3LzGXMmYeGCRRBvtzCBWVNjW0QQRbq57Vw?=
 =?us-ascii?Q?jwEibdjziSam4xqlC+LbLFsf6E21yUM7pXzKJsrH2gI0CgHlA0z5/2YgFqcm?=
 =?us-ascii?Q?sL7V0xxASDb7tMJpeQADuJhVUnA18rIPm8qutd0Zyoq9jZWc2YubtBCzs1l3?=
 =?us-ascii?Q?TGUN5YalS3+2pbEk+15BFAHo5gUNeq07YorIzYjyWsI8u7I2Q7NkExuhzGwL?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NSWQd0VTlOPnpNZ+gDqDvUvzSuq5OnxpFSm1aj6ALuyL46pnaG+YOVymwp9d?=
 =?us-ascii?Q?DMI2BBYcLbCIlNVX6dnVl942zA0LU6EX0odmajExHqjhjvx2X1ZUEvIlHgH3?=
 =?us-ascii?Q?IFzqTsgWdu4dCZctdJAqCQ9AGBCp9lu/4aHi2xstbYIfVSCQ8vtRd+3NB1mJ?=
 =?us-ascii?Q?p8VZGpKkP48jEYq6Rda3/4JTVurpp1OVwkFxzqc3FtetR9lMwmw4HwzJgEub?=
 =?us-ascii?Q?N2QKs8SIFWCD44L7fMO0wOw5kWmTrVHifX6uguDPJVH5fyki2B6jsX7j1f+g?=
 =?us-ascii?Q?ikTeOIYYrRO71BacodtfLjVQuOSzlIPxqDd5soKJpV11mbiHEAGPIn1FxPm0?=
 =?us-ascii?Q?Rr5DWNTTy0iKU1TMc9fT9iXemmUV5grurbSlsVd+wxDCNvG+UYFvCtJ5iHbs?=
 =?us-ascii?Q?g7x+xxX0/P/DfocW0i3LqWpS0E+HpvOEHPDqqVz9aFd6o207ODcJF4RerWF9?=
 =?us-ascii?Q?hIBkNskYIEWe23n8FGwzfe7ZRUGw55q60K0Oa9CjZm+aFBrrnpZHtxKrNH4a?=
 =?us-ascii?Q?Kk0bH2kdrRf6bgSkLwlq7KroFQkKCt2ZKtB58X6f1rx4n9xYSlGmu6C5/wbZ?=
 =?us-ascii?Q?qRQQeNG3C+2nPuuoI4EKfdxxc/rBdsT49LCzeOleAjahOZNuOwLwfMFu+5UK?=
 =?us-ascii?Q?jS58wrpoVhO1RQB8PB0ruK+A9BYlDzfwJu0EbIK9isfzfFAz3YwzgO3IPDyS?=
 =?us-ascii?Q?iu4rGxucd++KETRa0LIs7Y6aBPkK8tgsCY8NJeqLZ5QUqqp9Aru38CB+CICi?=
 =?us-ascii?Q?SW1lSSP06TIf8HEarA/J13dWJ4yJmk/7LduRVSypb96odOecyciE7NS2U0yL?=
 =?us-ascii?Q?I26VHLwqcxBLM0Lvp0Xc2N78On+8z8Xpw/nGx/F/pZYU/BKXUFh243V0uW+U?=
 =?us-ascii?Q?GGOBN8GyrPCsYK03Q4LVSYrGGVsHTmXokLzD0KU35oZ+h57kLqUsfNH1adrH?=
 =?us-ascii?Q?9N4XosZKcBq8b3SXGZB82Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed64d54-5a4a-4bc1-4dfd-08dbbb820b94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:39:01.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSXREedlhZuTMFA0brJHbOQleQsPqW5c/I/IAnW5TMFFxG6Aluikr+DfLLEMV8Af/dxvhzR0/amDart6FXkUxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220135
X-Proofpoint-GUID: YGmkw7Yn5t9erdlXM3NquedQIBTB1X46
X-Proofpoint-ORIG-GUID: YGmkw7Yn5t9erdlXM3NquedQIBTB1X46
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When updating the maple tree iterator to avoid rewalks, an issue was
introduced when shifting beyond the limits.  This can be seen by trying
to go to the previous address of 0, which would set the maple node to
MAS_NONE and keep the range as the last entry.

Subsequent calls to mas_find() would then search upwards from mas->last
and skip the value at mas->index/mas->last.  This showed up as a bug in
mprotect which skips the actual VMA at the current range after
attempting to go to the previous VMA from 0.

Since MAS_NONE may already be set when searching for a value that isn't
contained within a node, changing the handling of MAS_NONE in mas_find()
would make the code more complicated and error prone.  Furthermore,
there was no way to tell which limit was hit, and thus which action to
take (next or the entry at the current range).

This solution is to add two states to track what happened with the
previous iterator action.  This allows for the expected behaviour of the
next command to return the correct item (either the item at the range
requested, or the next/previous).

Tests are also added and updated accordingly.

Reported-by: pedro.falcato@gmail.com
Closes: https://bugs.archlinux.org/task/79656
Link: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Link: https://lore.kernel.org/linux-mm/20230921181236.509072-1-Liam.Howlett@oracle.com/
Fixes: 39193685d585 ("maple_tree: try harder to keep active node with mas_prev()")
Cc: stable@vger.kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   2 +
 lib/maple_tree.c           | 221 +++++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |  87 ++++++++++++---
 3 files changed, 237 insertions(+), 73 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index f66f5f78f8cf..d01e850b570f 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -428,6 +428,8 @@ struct ma_wr_state {
 #define MAS_ROOT	((struct maple_enode *)5UL)
 #define MAS_NONE	((struct maple_enode *)9UL)
 #define MAS_PAUSE	((struct maple_enode *)17UL)
+#define MAS_OVERFLOW	((struct maple_enode *)33UL)
+#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..0e00a84e8e8f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -256,6 +256,22 @@ bool mas_is_err(struct ma_state *mas)
 	return xa_is_err(mas->node);
 }
 
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_OVERFLOW))
+		return true;
+
+	return false;
+}
+
+static __always_inline bool mas_is_underflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_UNDERFLOW))
+		return true;
+
+	return false;
+}
+
 static inline bool mas_searchable(struct ma_state *mas)
 {
 	if (mas_is_none(mas))
@@ -4415,10 +4431,13 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * @mas: The maple state
  * @max: The minimum starting range
+ * @empty: Can be empty
+ * @set_underflow: Set the @mas->node to underflow state on limit.
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
+			   bool set_underflow)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4435,7 +4454,6 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->min <= min) {
 		pivot = mas_safe_min(mas, pivots, mas->offset);
 
@@ -4443,9 +4461,10 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 			goto retry;
 
 		if (pivot <= min)
-			return NULL;
+			goto underflow;
 	}
 
+again:
 	if (likely(mas->offset)) {
 		mas->offset--;
 		mas->last = mas->index - 1;
@@ -4457,7 +4476,7 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 		}
 
 		if (mas_is_none(mas))
-			return NULL;
+			goto underflow;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4474,10 +4493,19 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (likely(entry))
 		return entry;
 
-	if (!empty)
+	if (!empty) {
+		if (mas->index <= min)
+			goto underflow;
+
 		goto again;
+	}
 
 	return entry;
+
+underflow:
+	if (set_underflow)
+		mas->node = MAS_UNDERFLOW;
+	return NULL;
 }
 
 /*
@@ -4567,10 +4595,13 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
  * @mas: The maple state
  * @max: The maximum starting range
  * @empty: Can be empty
+ * @set_overflow: Should @mas->node be set to overflow when the limit is
+ * reached.
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
+			   bool set_overflow)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4589,22 +4620,22 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->max >= max) {
 		if (likely(mas->offset < data_end))
 			pivot = pivots[mas->offset];
 		else
-			return NULL; /* must be mas->max */
+			goto overflow;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
 		if (pivot >= max)
-			return NULL;
+			goto overflow;
 	}
 
 	if (likely(mas->offset < data_end)) {
 		mas->index = pivots[mas->offset] + 1;
+again:
 		mas->offset++;
 		if (likely(mas->offset < data_end))
 			mas->last = pivots[mas->offset];
@@ -4616,8 +4647,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
+		if (WARN_ON_ONCE(mas_is_none(mas))) {
+			mas->node = MAS_OVERFLOW;
 			return NULL;
+			goto overflow;
+		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4636,12 +4670,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 		return entry;
 
 	if (!empty) {
-		if (!mas->offset)
-			data_end = 2;
+		if (mas->last >= max)
+			goto overflow;
+
+		mas->index = mas->last + 1;
+		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
 	return entry;
+
+overflow:
+	if (set_overflow)
+		mas->node = MAS_OVERFLOW;
+	return NULL;
 }
 
 /*
@@ -4651,17 +4693,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
  *
  * Set the @mas->node to the next entry and the range_start to
  * the beginning value for the entry.  Does not check beyond @limit.
- * Sets @mas->index and @mas->last to the limit if it is hit.
+ * Sets @mas->index and @mas->last to the range, Does not update @mas->index and
+ * @mas->last on overflow.
  * Restarts on dead nodes.
  *
  * Return: the next entry or %NULL.
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	if (mas->last >= limit)
+	if (mas->last >= limit) {
+		mas->node = MAS_OVERFLOW;
 		return NULL;
+	}
 
-	return mas_next_slot(mas, limit, false);
+	return mas_next_slot(mas, limit, false, true);
 }
 
 /*
@@ -4837,7 +4882,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
@@ -5294,14 +5339,22 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
-	if (mas_is_start(wr_mas->mas))
-		return;
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
 
-	if (unlikely(mas_is_paused(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
 
-	if (unlikely(mas_is_none(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
 
 	/*
 	 * A less strict version of mas_is_span_wr() where we allow spanning
@@ -5595,8 +5648,25 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 {
 	bool was_none = mas_is_none(mas);
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (unlikely(mas->last >= max)) {
+		mas->node = MAS_OVERFLOW;
+		return true;
+	}
+
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_overflow(mas)) {
+		/* Overflowed before, but the max changed */
 		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
 	if (mas_is_start(mas))
 		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
@@ -5615,6 +5685,7 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 
 	if (mas_is_none(mas))
 		return true;
+
 	return false;
 }
 
@@ -5637,7 +5708,7 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5660,7 +5731,7 @@ void *mas_next_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5691,18 +5762,31 @@ EXPORT_SYMBOL_GPL(mt_next);
 static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas->index <= min)
-		goto none;
+	if (unlikely(mas->index <= min)) {
+		mas->node = MAS_UNDERFLOW;
+		return true;
+	}
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_overflow(mas)) {
 		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
-	if (mas_is_start(mas)) {
-		mas_walk(mas);
-		if (!mas->index)
-			goto none;
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		/* underflowed before but the min changed */
+		mas->node = MAS_START;
 	}
 
+	if (mas_is_start(mas))
+		mas_walk(mas);
+
 	if (unlikely(mas_is_ptr(mas))) {
 		if (!mas->index)
 			goto none;
@@ -5747,7 +5831,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5770,7 +5854,7 @@ void *mas_prev_range(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5828,24 +5912,35 @@ EXPORT_SYMBOL_GPL(mas_pause);
 static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
-	*entry = NULL;
+	if (mas_is_active(mas)) {
+		if (mas->last < max)
+			return false;
 
-	if (unlikely(mas_is_none(mas))) {
+		return true;
+	}
+
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
-		mas->index = mas->last;
+		mas->index = ++mas->last;
 		mas->node = MAS_START;
-	} else if (unlikely(mas_is_paused(mas))) {
+	} else if (mas_is_none(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
+		mas->index = mas->last;
 		mas->node = MAS_START;
-		mas->index = ++mas->last;
-	} else if (unlikely(mas_is_ptr(mas)))
-		goto ptr_out_of_range;
+	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
+		if (mas->index > max) {
+			mas->node = MAS_OVERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
+	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index > max)
 			return true;
@@ -5895,7 +5990,7 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -5913,13 +6008,13 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_range(struct ma_state *mas, unsigned long max)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_setup(mas, max, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -5934,26 +6029,36 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	*entry = NULL;
-
-	if (unlikely(mas_is_none(mas))) {
-		if (mas->index <= min)
-			goto none;
+	if (mas_is_active(mas)) {
+		if (mas->index > min)
+			return false;
 
-		mas->last = mas->index;
-		mas->node = MAS_START;
+		return true;
 	}
 
-	if (unlikely(mas_is_paused(mas))) {
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
+	} else if (mas_is_none(mas)) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
+		if (mas->last <= min) {
+			mas->node = MAS_UNDERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
 	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index < min)
 			return true;
@@ -6004,13 +6109,13 @@ static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6030,13 +6135,13 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  */
 void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0674aebd4423..06959165e2f9 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2166,7 +2166,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2917,6 +2917,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		exists	MAS_NONE	active		range
  *		exists	active		active		range
  *		DNE	active		active		set to last range
+ *		ERANGE	active		MAS_OVERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_prev()
@@ -2945,6 +2946,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		any	MAS_ROOT	MAS_NONE	0
  *		exists	active		active		range
  *		DNE	active		active		last range
+ *		ERANGE	active		MAS_UNDERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_find()
@@ -2955,7 +2957,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	MAS_NONE	0
  *		DNE	MAS_PAUSE	MAS_NONE	0
  *		DNE	MAS_ROOT	MAS_NONE	0
- *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	1
  *				if index ==  0
  *		exists	MAS_START	MAS_ROOT	0
  *		exists	MAS_PAUSE	MAS_ROOT	0
@@ -2967,7 +2969,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to max
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to max
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at last)
  *		exists	active		active		range
  *		DNE	active		active		last range (max < last)
  *
@@ -2992,7 +2994,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to min
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to min
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at index)
  *		exists	active		active		range
  *		DNE	active		active		last range (min > index)
  *
@@ -3039,10 +3041,10 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
 
 	mas_lock(&mas);
-	/* prev: Start -> none */
+	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -3069,7 +3071,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
-	/* next: start -> none */
+	/* next: start -> none*/
 	mas_set(&mas, 10);
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, mas.index != 1);
@@ -3268,25 +3270,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* Continue after out of range*/
+	/* Continue after last range ends after max */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active continued */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* next:overflow -> overflow  */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* prev:overflow -> active  */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* next: none -> active, skip value at location */
@@ -3307,11 +3330,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning end range */
+	entry = mas_prev(&mas, 0x0100);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> underflow */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* next:underflow -> active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:first value -> underflow */
+	entry = mas_prev(&mas, 0x1000);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* find:underflow -> first value */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* prev: pause ->active */
@@ -3325,14 +3383,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev: active ->active, continue*/
+	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
@@ -3379,7 +3437,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* find: none ->active */
+	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
@@ -3778,7 +3836,6 @@ static int __init maple_tree_seed(void)
 	check_empty_area_fill(&tree);
 	mtree_destroy(&tree);
 
-
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
-- 
2.40.1

