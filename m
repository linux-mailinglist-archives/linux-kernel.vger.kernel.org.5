Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3778E434
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjHaBNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbjHaBND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:13:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738001A2;
        Wed, 30 Aug 2023 18:13:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0Dvsa010993;
        Thu, 31 Aug 2023 01:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=VUlHiOajLHYkMh8vHFQ2jhIqYZQdzBnB+vxWN1kwGAk=;
 b=qz07UkIvm+Hw6UV/8gTCL7ZPkN7i98h+h+oA4HITNidfpxwXTXTVVIoDRcgUqsvNfuWf
 c+wqcUMsH4AjYfZmgBb9j18mJp23ZW453EWKwgj3hhKUW3E3ok65k7k5n/+h/3Ivs39f
 4plnx24YwRECb+qTuHxDOYmH4drkvEp56YZEgvQ+s/5dYDMoj+ahTykGh0lDHfDpqUGH
 dzRCNFDIOl8bOIMonjMzTwoxdANFMfyGelv1yFugUlZKng/eooGrTgtvszI+LjVqZHb0
 DhWf+8AKAFfimqqIeBxBQEBL3VBIYv5digMX9TCIFR7UGCdJfjhve00s6/pq9wnvzm2/ Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9p00hss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:12:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UNLHv4000581;
        Thu, 31 Aug 2023 01:12:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gdbprh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKwEMIVavt4WqOBU3D1yjMTgEQ32M4GbPoVM02LxSBl7H+OLoPzIEvVjkkk35w0Otuo5KkRbliR5YwxUiI4ukh89SwN8P9j/Wk+2TX6wVy9+aObo3QZmcObwCOXMdMigRfkoXbTAcyNQct6XbLHxkMi6UqBTnH/1EbHpj8sKdWfLZQGmDWUZKfM01OLYXYX/wfO2Of0h9ERZr8TJkrZIriVpTx6iUcJPTuJfHclpm61AVSbYtXTx59O+CRXjTJL1SuoL1E2kBLaRZdvNs5ay0RMXqsf4AiBfiM4wPjzx0b7Nq6nsdSrLw7dDYu9rTZsgP6KnJqS4nj/SFG+rA7lr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUlHiOajLHYkMh8vHFQ2jhIqYZQdzBnB+vxWN1kwGAk=;
 b=HG1RVAOWVi1tlwVIIvNjBfpWuQ8dPd/rihlMjh0cJzzXbmacn62PjkPoKBxaS1l+GSpNbbmgGsQPiFynDBB6e98GUtU364hwQl81+GjQyRJXDzH4jJbO1RFPLFvuu6pRpQ4sp1Mdx47qbnWpfO5XUSUD5oMZCgUPOS4q1Am/HLtefvJWu/Tpg50tv4AlfwCUO4lbbaXYWI/xY+qyTJ+Znj3b11M1uxciXDsvZC39ZfkhH0TxJqFLZwijsxxqGFfkgTN04yNJ9eXPCTvrLNFc9qHmn+20Fnr6UwujUbMVTLUzROfXPfWL7dxA+9PvSPR+71wORByUwdOEzlGihBh1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUlHiOajLHYkMh8vHFQ2jhIqYZQdzBnB+vxWN1kwGAk=;
 b=taUgj0fPv3BxZM8LL6sSonlvW3cEI2XRUS8pLJeigbGCuUbaatMQ29N3PHtN4uH19KS9s9qGAP64oqn4aUSHSzX0Swa5mLAC12XOlrJkF/w0cnf8RzNo2LqWoSFe3kiGrilCHjWmDIKQfRo3ESAez+Lc5y4DlcLkpRLtV7ixJ4A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Thu, 31 Aug
 2023 01:12:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:12:55 +0000
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6oguia0.fsf@ca-mkp.ca.oracle.com>
References: <20230817182146.229059-1-kartilak@cisco.com>
        <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
        <SJ0PR11MB589673606EA6527A478990B8C3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
Date:   Wed, 30 Aug 2023 21:12:52 -0400
In-Reply-To: <SJ0PR11MB589673606EA6527A478990B8C3E7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
        (Karan Tilak Kumar's message of "Tue, 29 Aug 2023 02:44:13 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 65afb529-ea4f-41b8-c7e8-08dba9bf6813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb5Q+6mTx71gtkyxj/jsmOSqAF8MVMJD1b5zpQT4sTzhl9u8zWtj5mxAHyYrH6cbMNEPL/bbRL08WIku6LaDTSFYR+1pVvVtND5y24raADbaTvsRaxXO9rWSuCo1lNpKm1Qj+WNebPeVKGlDEp2vVT5yGOkYeHG3S5JkpOyzX1+sQJmDt0WxKqseHHdmv1UN/vSXL83Ga8A/nQlonQAwB/rU+/mJCatsWwG9Tgs9yBxy8Wj5Gc7e2TN5EtLC97nKnvbEbXQpYNeQD+o1PogpLF5GRReWygniseZB59T+HOatXRk4agjeX/j8njaH7cX3NieQgvNXmz+3ETRnN30yj5Ay8dL88mHkIP3uXptVoWOT9td/8iWxOwHr8xzYmDDDc9xbQW3aw1zMk2dPao0tWyYwQ2QQhT1uBOaXD9/4oh9xlmFKwkNzriYVl0CQJuiD9Rqlvwg93vlzrHBCqY8zNc77n6xPVQv83RCCIzKHlRMMHd6h+hrldePcTr1maclWYDVRzTVh9pZacYJqbN9X6K0CEUM9KbAFE40dGf+uKOXYXsWKVH1B4H6kCWgqQb8g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(38100700002)(41300700001)(316002)(4326008)(7416002)(2906002)(86362001)(8676002)(558084003)(5660300002)(83380400001)(26005)(6916009)(8936002)(6666004)(66476007)(6486002)(6506007)(66946007)(66556008)(36916002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GDhhc8LCC61Q0hisZ2HzGt94SfntvzUcQvRNnEY6Uc+l1/vBGeP5RpC53tZ?=
 =?us-ascii?Q?+nmrWSUuvy0AreJUVlEWJk0YX1CuEUq5k3xmGvM83hLzM/yp1SDP/pOo5dFX?=
 =?us-ascii?Q?LvH1SJPG7gmmtHz9Ip4DdwQR2A/M5jUVD+XuGpbU/7/4SAPPodkBXLbhHuHt?=
 =?us-ascii?Q?1C/NOdkGuVkrh6TL5IAictItrS9Iy/zO4HJQgakuYYQ2UeVmBIPTTBqUQ/ja?=
 =?us-ascii?Q?dIx7J280zHzjHRPN2WOGrDB3DDcFfdVW1I/PAiCqISVOQlC/76sIa2iPeLUk?=
 =?us-ascii?Q?BPm973XaBEzvhXgn4oXTI5V3o0J0NmwelSoZeNAVd0R1frtwyBzj5A/CX3c0?=
 =?us-ascii?Q?y+H0Ae9S2yaNA/EzfAWMv7zRLb75IVReWfLiI4mZLJtJMp1V6e/81sI3yd85?=
 =?us-ascii?Q?qve5KzAapdNV0x8xKdaJRlTaLhCFa05tyCAGUCYRaxyx9SiTEE/2d6D/BgMm?=
 =?us-ascii?Q?JEjA4qNBjbxaaHN9w2sJEVe6kRnhDQBr7fa8H1rv01l3cNQOWVItCqXS0O8y?=
 =?us-ascii?Q?MlGipWzhuKs7mYMs5aRe8oSJMBpwrv9k1Cf+C+PZSIlT+lgEwdgAu4Tlbj0m?=
 =?us-ascii?Q?AGFmRoY0RNIHcEkv7/8qlS+cFTz5omOC8x1h6lJAvtZYNUHJVhX5FRu/BRmm?=
 =?us-ascii?Q?+6lLp6DUjTxwCeQa9+3Ow/ACJgofosyVynZNpo+e3vFSEBvjfUv+IpEA/7FZ?=
 =?us-ascii?Q?jo6Bj23JsVJ2Wzf8+lyVOegLig1z38ycggxhyHtLg9jcRaUobQhCOiupaLPz?=
 =?us-ascii?Q?dQpBNk3cCIYs69L6+eY9mgMuQm5518c+PkE4LqhdMXMIxjeSyXd5imLJ9AsV?=
 =?us-ascii?Q?3vJwOPLgSqeDCl6uY7XcWwX05Mw6ySZ0KZfA7k63NtqYth9jzEsf+8/QIyOf?=
 =?us-ascii?Q?v4dOsRQ/uWou5IZ6n3R1SB72FHWUAgh/Ggy111CK2GRQee4QQ+48Hz3mE5rN?=
 =?us-ascii?Q?jFyZiDWfkR9swQPko6bdX4Oq4sUwuNf1CT3M+6rKd74BEOkqFw0lIgDU3/9X?=
 =?us-ascii?Q?nq+Y8s4bhTOJUUxgDyLPmXH4qUHKJMMiROAGTYEZZMvi4F3GOA6JaflE3F8Y?=
 =?us-ascii?Q?zaHznmWMIEmhpO/iAS6ZmxFeYqTuMrRYurSUGbeqf71ovd2TbtmUkbdsT3yy?=
 =?us-ascii?Q?BK/pXyUbgqK7a1eYYDqdmdV1tH4Ll6pVtnfVp8sG8f8ikg1XttPE5px5rk1e?=
 =?us-ascii?Q?ChVufKnm/O5XBZPSUJQ8CY1858yC7YWzR57fqIbmxznp8qw3AJ9fedCQRoT/?=
 =?us-ascii?Q?wOL2y32VnRHfiThXKPHFsDKjevplP20R0VCuikKZ9VzV3d0L2epJlFmFDScq?=
 =?us-ascii?Q?HZKA+N5km24zakYLv4+Mv5IR5jkX07/6D8OEiD918B3YEHJP4BmwVIlvRvf7?=
 =?us-ascii?Q?60qOTsH7iqF+4zQWYfGb5ECKyOP4FyOjPO2oDUkdHALG1kotGFmIYb7qeSGF?=
 =?us-ascii?Q?K/D7b5mm8EMN1ezS7Wawp2TH71e6NDPmFU5mkps3lqRGlA41+KZs89IhoqPv?=
 =?us-ascii?Q?TC7vR6P7TrUI6hQyoxJgULgQLaSNDbkj5CE+jLPno/HiEsPZTkFZ5hJgo7/T?=
 =?us-ascii?Q?XDca4Ca23UgdcPG5TUN7jZrDfBwMzzBrOOStY9rYxBCMRk0vST58McP4BE+/?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mr6K2tZO+WkoegYjoDaMPyEbMbwTTkGtmJN0kuaVjh8QvgyCekOJnQvfACH1TqsgGP0l4R20b19DKadfuBAOZG0Diubgj2/EDCB6aIIvHvB3kvHq/p175tW0MRpJGB4icBYWiPW0GPpYcULbkIuBu3QcPcJEpt01p0fifzN8iHGI00vmI1bzDv2c+Wm06bsCilKXFjYR4o63l8guqG8c8cniIwo8st5BSMGOtg05oQn1EIGMSoctGckTrEasg/8zHNVu4Wj1aVVE8ys2hTX9avyE2whqAeUcmd29zdjS4VXvoz9ljuJAyteIE8xCy1NSd+2mRUL8OrE0++rS3OZVBYEcXaSP4L2ULGKvhYGwQefoHbKulxefEt0I7UsgeLwcJ0UmDUrKyGzmZri5ukiHhgYjPQJH/KhmM91DWtpRZV4YBBoUl3dey5bkQf6onxFTugKjGegopPts5RbsvrAfGiXde9aITczPsxse/TJzLW+x5XXoOGk+cLKAfPvEjH424GychYIGlAfEmOcl457szi3iYGpIbT5QkpJUFyNKonRzU8q2iRvYhSoafjs67xT5YS3AoU08LGMsHP+3hnNQlh7kaSjNzLIa4eIoM/r5/6up5PbB0Yid/9q75uyAERmmEuTqqtkV5unnvbSBUTggqk8OyA3KPnvW0ElHAdeBgz45crR0GY8XW7ybP608DN0gQ1Rctj3sItg/l/VKCP32Ej+3/3RVYLHmnUAnqgdMV3VrSFQYfycSkDZKnH3XCsfG+5w8lnlScT+SiCMmB0EevJ4/A4TXMIgTPYYwP1/qBQCe2nwnNmfjqtPqsY5OIgs+rAYtINSaj+fq9DtY7lywwg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65afb529-ea4f-41b8-c7e8-08dba9bf6813
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:12:55.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymofmv4vAXuBRqvqho2brgq0+mufsi66nyPiYReBrSpe34HHz/G3kdPNFrxetgi6LvXnDrlcwOcD6iclFz3cEDvC1DBh65PfLsw5oOgPaDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_20,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=571
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310008
X-Proofpoint-ORIG-GUID: IBpzasm-VNX5dGWiEgXW508R8yJD3_M8
X-Proofpoint-GUID: IBpzasm-VNX5dGWiEgXW508R8yJD3_M8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> Do I need to send out a patch request to apply this patch to
> 6.5/scsi-fixes?

You can request a stable backport once the commit is in Linus' tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
