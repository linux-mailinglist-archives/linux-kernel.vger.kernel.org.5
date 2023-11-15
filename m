Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA37EC439
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbjKON67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjKON64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:58:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D54125;
        Wed, 15 Nov 2023 05:58:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDsvet014816;
        Wed, 15 Nov 2023 13:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=b1gX6KKLQrdNp/bQxUtnNp/jNLdGAHUtvT0y4WFNWkb9Pq5Xe+V3WYKEsGYrn0c0ANRR
 qtvrrnq9/4jul539xsG0syf84fqrF+ogllIv9n2ypi4Nuc8hiVXQPI3yYlJpN/vdBxYN
 63KBR7rB11pEiO9zfFlQwPU5/oe3xtw31cxa8RCTRqf6ulN+m9wwTsv3oR+GbK5tNzCc
 Jhp82Tbuv/WPsmQYPDjtQQO9iAk0ee+7QZG+dqrO11ppr0rAnNvp+JXVhcO3mgyo7+de
 bPQieQBKQPkEYXpSboLgpFycSHDF94IWvZQipAxT//Qm+gw8I10CxdZPIlcsE/b68LxN fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na0khq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:58:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDiEDT003911;
        Wed, 15 Nov 2023 13:58:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj3v72m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5LyqfbyIqZ6hsylCYDKzYL80FmDp+ikaOwDwNDgPW5yQnyIGDZie9Y54L8Jd1WFck7nq9KXnKQrw5M1wDuccf5BptJ6NZGASz/M3CRoZ9BU2z74cRhxNSOetTU+fJTzqm2XI+igJBPVCfkRPuJPDCTsUyJ28EB5HPzZbGjqLZDZKWkF5Em0cn9NzLHWPDLGlbKoGoTbigRSjnw+VwTmq2dFOpV7z7IgOZtDZ0lRYrwCu0CF+BqKwJ9YS+1kGgAb9qfulEP/jeq+IONgzoEzcZ976exVR5imb3WZ4jOADiK3yIWftFoRnW19hSZHjHvO90SU4ncf8GSMh/WYhSg+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=QndTy3DtxRXZWlVUXqziVV7lg5QXIYetFGgW9aan4t0NwOAj/O4r8b0RiCKqB2+n5cmkaJy5376+BRZYcj4U7hI9kqy3KONGhKikQij4FTz9gJYjkaWC8owW7bzK1Y8jn7puQvLkW+tavmMEMardiSsuAyGvC9sZKAzvh44+yZ5oHGigh3WK9nf5jjmTr0P8ETjUex03kCzuBENHj4k6zj014+GbnPhJs4JxwzSWNBkK4SoK3EVfqUQEod2FYSshv2UeGRY+rUgfHx6xpyDw657oVLxHaDz4tpaN0SToqHHOEWxQmXWA40n3rGDGRmytXVCN7uep5Inu1NNetQ4YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=vy7XYSv7o67nG1baIIBGbo47u6PKLZY52lgnZvLUK8mob/dxAvivviUgNluKseJE6SO9UWLoAfk0b6Ypn6SIP04cInDCmZ8Chn3KfggE6mSvtw3JjI8QFDoF7Ta2wHG7NB09G0528fkmzJ2zJP/buf+cqJ6CsCHvJeCp5U0iXnU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 15 Nov
 2023 13:58:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 13:58:45 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: replace deprecated strncpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1il632k51.fsf@ca-mkp.ca.oracle.com>
References: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
Date:   Wed, 15 Nov 2023 08:58:43 -0500
In-Reply-To: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
        (Justin Stitt's message of "Mon, 23 Oct 2023 19:50:57 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd2b2b0-110d-40db-c8d1-08dbe5e2fba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R13r5lXx7aEgNblRFFDVAPlX6kDRWjpzXFNiNR1w+5eUjtsQJdu2fyG5PfjHyx4RljdUMb70zmqBRtjX0ms0ZSQ8Hj8STh4f47SXeAVVc6xaqm4owJwXTNPp1tCsr/oz+JC0/SfQKK6z05A1irN0Z3hUUkXHGXJvWRzq1BgvzZgOjZnGXi0V/ubSKfzBiOXibHb9ze+sZDRTSmWVupkAtJAfDIlkSQongkx/vV5oZfZWw2fe4MmMsIkv1JQfdov0Vu1XRVLdwiluQGJgwLBFySXB+Ark6EpQYrU/XK6GVtuWWVb4L8F/MB5S8bYCqOZqsY//9jI+x9345P9qiOpv+dvYhGF26SCEvkpb5tH6wQ21C7VR35JK0gmLhv8FnDAriidAYa7Efv/PF0+kg89XVKEPiPPQ6Q/iS40N+iCV56/hNM+R4QumgqpsB/Qr94pIuEjIJfXVlBHpVt/bOEqbXrDanO6qCYVpdB/iHDe56O/TIlcu02ZJj4bA3eN2df0+icmACpFJGXvQSiE5APWwrPf6zSJeLhsHIuKUCX3udeaI9POk+pdc1tMulyxpeis/V+D2w7MssY2y5ptXXb82UZA2/9iLf9c4FPG3cDmRcUXWMK+HBiM73RFu3hbUGGM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(41300700001)(38100700002)(8936002)(478600001)(558084003)(8676002)(4326008)(6486002)(86362001)(2906002)(36916002)(6506007)(66946007)(54906003)(66556008)(6916009)(66476007)(5660300002)(316002)(6512007)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aM6fSGXdhiNCw2+Tv65QpV7LHjA7+/s2zlGETyl01NHSfgncPDnpD7eQb0Pn?=
 =?us-ascii?Q?ji63REg+3JD5Lir3Ph34AGIG9sjkly4gJIeY3udoN3eccUHbmVHRjm13kLEX?=
 =?us-ascii?Q?A3G8f6SvHz9alGwfCYM8xw4C5pQwjt8ympP51hydw0tEwyPce8nsCidQwdVs?=
 =?us-ascii?Q?g6OTvK20cHpBz6CQ7eEj2aLICF8rirLtp66OtB2k+CLesLYDsYHMcfbfp23r?=
 =?us-ascii?Q?ApKHHN5brVE+TALL2zrgDWnKd3GitASlY/aTYEKN8Z2JyuG1eqx70CDpuPt3?=
 =?us-ascii?Q?EoQA+LfMMRvwqTL0B9W2yIdmkUnwaCjfg7q2BtRudGjyHTAL2bdGimdL7XJC?=
 =?us-ascii?Q?1VQeUowxo04BUzjhtLx+bHiX/SSIJSVKK2NuzxEymA41zUUpMM5gKRcTjvER?=
 =?us-ascii?Q?T0ncNzog+uJDEHs5LAs6iLIXZ6LG7D7jPNpYYkQu4JZF2X6mLz5C+HwNNBtE?=
 =?us-ascii?Q?EufVkL4YlbXrMOA/vz4Sav3CjBmcrWIKd6eKRkcbCBgtzjacb1edvVMWnOHH?=
 =?us-ascii?Q?JJXCpBkMc2rJ6F6gzZK+d25xCzkbwT0mzdMeOEYKWCic6J/Hv0Jzb10kjmUW?=
 =?us-ascii?Q?NOdTL5BRkB3NRejJl6h/LC8kpOf1Nw+C9vSzt8ROPmDN+gGpLM+ldFkd3Ym8?=
 =?us-ascii?Q?LTPUSjENoNWnY71LdHHbW6yOlpwXVeG+VB5quYJHj6eq+OOrKHtNGHBwMhmR?=
 =?us-ascii?Q?rRQFV2Sg+hVQnmYcm7CZHKXQA8SfJAgO9WmlG3N5py6y5TRrUKFlTtGHtmNZ?=
 =?us-ascii?Q?GTEdgDXp3LargS8xlXTIagHTqgeWktt+6ulaNWwmHVsqFmmfMuCO8DLWMjXm?=
 =?us-ascii?Q?cjsK0Ny+urPQyVHsRzP8FSJ1wRUodUG70wALtjG8fgBpx3n619QJRJuJ9LzJ?=
 =?us-ascii?Q?viBFmvo3Ug7sjDo2wBTaXca0sMsgPB26ml8L/O/vmgmLImB2d+jH3Fn7NlnI?=
 =?us-ascii?Q?R2OrdTrO70/5zF6mm8oRz3H3fM4lNEGtgr3I6xVZYPah6XqAPuUSjg2xIK61?=
 =?us-ascii?Q?IsDMyxeWyTVR5rheAe9wZ/LSeq5Mg4+BngSWN0IWn0QEEPn0w6PI29iGO8/v?=
 =?us-ascii?Q?T/ZHexXFKnodzepaDhw4PnOSi4+SWUpW33jt8mO+uL25e20PI7Wd0pSpxUZ/?=
 =?us-ascii?Q?6oxHeeKoVUU3tBU6f/mbQm8Y8fyySaDDoF8EgxVtapJKjEwtll09rEp/A2xg?=
 =?us-ascii?Q?2sZ9L2it2LwuTkDhykR/uqMKokd86lFyvFRFUhq0fkA1L8mqSwUqiv7oklKf?=
 =?us-ascii?Q?nE8qXxK9PAJ37ldRq1/0J3P4viNmC/8xuMd5PdJOqgX0ar4tx36OduImptHF?=
 =?us-ascii?Q?LaP5sYm4DjAvW4y7ARhiKuRy5t9T3jf+IK1rHH7CPZahJAe3sk3biL7kLbaB?=
 =?us-ascii?Q?ejI0br9cmvbae5IcwZqnSRNYblqRvdMcysQmyw2pqs4pkrZ0iMOJoLzaG8HD?=
 =?us-ascii?Q?W8teD6o+DT3e+rcDrkI3CxVtuki6TvYryYdka2B+2fpiutjw5o+Tx0eYVOqc?=
 =?us-ascii?Q?wcpBMg7KFbYUGpugiLOocQVFlFSPJ0gdShqYIFIku6fCWGjgkS38noKvJksV?=
 =?us-ascii?Q?VGm4sfLaHUsNDYs1HIn+jdcM1K4UUHvtXjLDC/+RToBYlr81TXOijMVGjV1q?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ie9Cni/xLbtDHl1BstFp1ylIIIwILscJoYeY1HDRaUjE4SOVUgYLjWIG4iHNPmWrcIoYGf1EOuwKAmWdxVUCZm85wEpkSDuamNyK9Dz/dW62jqELLj4JjKbvrxmv9AyyhujZwmpRjHxLiP+k/zd8uKIkGkWAOY8PJXgNv9zELh7pcNCiLnnvAJv4i5BOVtH0yuKfZSy7+61oHF1ERgSeX+IzSpLn4b2/+iRCK8ZFTHbc9bcYIf1Eov8pUdDNpfdappCsiccyIagIApHNdQKCdRvAurLfjW3/P6Ia6C9FyHtJPyWUOrZdxcbmmGu7+f3CQjfDc/JfdQ95x/1L7hnS2+C8MICwKF2cA/s23plyl14y/HRubv2CIlur2ISA2xj5+uFp2ylP0DQoXUT/vtB6GhczM8M03kQGvzHwRKP2Odr08jmA2F3GH9eTQXHBLNNGqeijHjYjRAkI6lzIUR9erZzezn1KIXNOmtNWAkYM/UJzXkiFtUKJ6KUuy27t2amIRetELi28NHs/bb3NGxS6tXlqfXOam6PNyoZ/Dvnskenb9LKTGSm2PML/mMdotryB8T+jf2bvsX6U3Q+gVh/aZCUuktzZyVcvP1hTr6YiRBr6Wqdv0o+NF8n8wzMTr5vfMU+LUE/ovQkVERZgYbC2KHN2FRWlLXr3scuVbZrRvoH9YE4FIQyRNXggNYU1QcjMQev6/hJ/DDO64X3SNWBrdwLbCcGgdNIreVDszy7jb3WLDN5ZOHVMGARBE0xV3Je7/g1n3pQ+iCZo4+obPZYqh2k1sNQBTqQbRp7BAquk1N18NhxM6Al+QFzmsa2HS91AKvn4ZUtWIf9tD9cZfeeiuqR4VZIgntpM61RlFm6xP7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd2b2b0-110d-40db-c8d1-08dbe5e2fba4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:58:45.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zkf24Bj4FdXFV95pzlZfbVVvmprJRsVEYwn8jTzqs1u0pqp1Hz8PGjlniU7GzLXBi/OmAjOzbrgPd3grfxN+vd12bYG2OXnl29v7GQJbjtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=773 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150108
X-Proofpoint-GUID: SXV5KO12XEmP90VKCxyY1EM8LOse5Wa8
X-Proofpoint-ORIG-GUID: SXV5KO12XEmP90VKCxyY1EM8LOse5Wa8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
