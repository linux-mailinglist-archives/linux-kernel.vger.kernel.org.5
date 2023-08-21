Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC337834A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHUVIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHUVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:08:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87C132;
        Mon, 21 Aug 2023 14:08:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxTUF003604;
        Mon, 21 Aug 2023 21:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=g+nqzV4CUeNoa703Srd0/+pc/7igX7NFOhTmcxeCoFc=;
 b=NGZk+SnEDjT+scEMQqc+3PPkn70lDEeGWa2w/Liupy0ATZkpB7q2Frx7lFBCp7bHYY3M
 E4QNiYf91SK7/h6AhT5hpP1oRUkHNfV9kPmNmCJ43T7pUDXnr09d0SZWpg+8O+xmkyNP
 Ut/RtDwjBdM34Uc5phJd/D9O1r3i1neMRdlfkRJ36fAzUHZvq2FleWV/2f80QerXF4qQ
 4KDmOSj57GLPqFpbVqV3sg962/ucziMqHJYs6XhEGwHs4KzEa6I4mUiLld/1W2m4weEO
 vtM0eWjahrY84iaYQkOLsYxzAah0PSLIF67r0JYiG5ZVIpYRAdsePx+tFflAUENgMgZu 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmnc3w17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:08:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJKLEt026752;
        Mon, 21 Aug 2023 21:08:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm647t8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK8FmCRRztxye1FNWMaJxccQd+2CwyCj9W8EAEJg0n3LSSl6FtoGRfXAa1tRkQYZ6g2LJbMn8u4zkzvbWqu0mgVjgkYNug2n4dIxGVP0U3QPeT/fml8Eqx6MT1WilNEAkwE6NApbg2BUcvfOro2B+InK78m+ou8jeFYZ0uFVTNvz55pntQ6gHidu9RZvAEu5ny1tG2M11pRr/WRJ2Nd7qod4JE0mwFdZ81xXzcjhCZHx0wwqgKi8hkjDknW1XTXmNcosu6LYrY/CM/zyLIQ9x8ZMLD6MxgAgsfBOCcKiQPgKhMF+Lu+TQp9oW3maqfdX9kdI0YIB65W9hPIuH+kDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+nqzV4CUeNoa703Srd0/+pc/7igX7NFOhTmcxeCoFc=;
 b=jp2e7Jc8NdcZLFi3onOY78I/KQt/by3eLJTV0udbFiVa9ZyCUHDC0W6aVKARXoX+47B5z02Vp6KSpErN8nR1LBTRVWNVSAaD3SuVPkJkWUzYZZHpqX36F8vsL3DrHgnSYjb0RoXojY/WAt+cTppXCu+nMhGobsINOGnm+hQVTSnmG4NimhpSBUSjEdzqltl66dMhxu49XAgFdHerGeWbeQcOPJzD+hEOC6XMRr3bHGPQHBwZSbNTvh+b9C29eUTCW0rdZyFPOc0vF4viVt/jTJ+FCe38cjYKsIYNyP89hvdvD0AISfEZfYRkFcpJ1iZAmGqn0BdMGHPdPXNUywVvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+nqzV4CUeNoa703Srd0/+pc/7igX7NFOhTmcxeCoFc=;
 b=i05NgucwOWoihEavpMYqljnaIcv3QrUixuBwrtOiv+IDB08bMzkyCI4FqaLPJwhfAgzuapXc5Q/blyhkWUGRGeiO77PRuiz0mIcM1F+NX7Y398aI1AUXbkwfGhwzkwuKVbhs6astmZSRpd+dgCBM+FArcs8FQ9vPahi39xYmzQs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 21:08:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 21:08:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] scsi: lpfc: Do not abuse UUID APIs and
 LPFC_COMPRESS_VMID_SIZE
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y586r4u.fsf@ca-mkp.ca.oracle.com>
References: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 21 Aug 2023 17:08:15 -0400
In-Reply-To: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Fri, 18 Aug 2023 18:54:52 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e2b7ec-b931-4536-829a-08dba28abd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llUGdI4qLehg6obSFs3o5i+23BtYbhWD6Jvx5D/1uhr0K68FsxlwZoAxlSTDsJuYxfAZr/aOYKO8jpP0380Sm18FlwTreU6gCHtC0Bju0PQpSaB15rnTM/ck7HgGZNlLoSijm4ZpJpeNdsZYYkTLgPsB6qBsWKzeXvfanI9I2pil3q1dC94juh6xOquIe8CR0H5DRzz4/UlGyIA74TaxDpu7DH37FCkjhtrv1eCaMabqlpVS2IaxD6vwOFAjL6CquYA5LVzkHP3Hk2wvnUFMAlHOfrZqRbhs3Z7kokaH8UJ8mm5hB6Xd6GR7kz+x9bDnaAW9O9phrAULGqf31J85zQswa/jYWR8hKwtXLM6cjc8Q+a/jT9JvqeNlUdAP2ITT0pMrcx37MRIK1u70uYkh5Uc5MCrTDpxhtjVZAj8A3lHb485oXqc7Qg5yOyTrYnqpCNtgg61Cdwt4ueMUX/ZIExzuUhikNKHJv/9sQz5/3y0p1uZ5fE4nPDq5cWw9EYONlI+7QVF+lUjOWaxp3PnbefUjmt4YYs63HE4q2bjC/7Pafwv2kcnG9rmwoQlHRXmA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(6916009)(66476007)(54906003)(66946007)(6512007)(66556008)(316002)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6486002)(6506007)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/sCj3c79850MHREuXm3SxRpCj1sbLQwgJQGuQrW0X7qMrU5nZsO4MGAjdVz?=
 =?us-ascii?Q?bPFlyiwlSNbsiWaAM5jL8CapENpW1tq2/SFDntfdZLVDRO5O+AbhPhXS9knd?=
 =?us-ascii?Q?CRtLjX6hUZ3kxYA7J+KB1MSgF4+sUSIn//n5xG1yruWDHRxMpEPDRKYGYcXh?=
 =?us-ascii?Q?FAd6M2uAYdcM7fCMWiPIC4nQeepD6em8V6o9L292KoAQEHjjit+B/SuKC7oJ?=
 =?us-ascii?Q?Pieq2vyqK6Zpa5vrBjkVznO7JG2CJxlBYMkHBKHIWp8RjiQCBLWdC26Yw39C?=
 =?us-ascii?Q?Lji1SVPFtm4tADWb+5hcY3QUKtVQJAWFb9MyOMeshLj4H3G/qNTzOaJ2Hujb?=
 =?us-ascii?Q?6sCMGw4RYgITcTb0jYJm89hVWuRByUPITtIVqxHVm5k5VHUNeMvF8GH06CJR?=
 =?us-ascii?Q?kENwoB26ENfPW/B2hvMazu0iOqVmu6E6GqAyna1i5Bxv67MP88vbPe7M0Eoe?=
 =?us-ascii?Q?JCK96MUoZgtPzDa2irmTacrx/U8PdwHdYiD0ucaOmGxg7hQkzvp7hV8aH4LG?=
 =?us-ascii?Q?EZb3FipjrGTV0077J/DSB0mDnS3EVIMAIVbz72PPpG9mL3BFrTIdM7HKdIqR?=
 =?us-ascii?Q?sxbwNSl4EYqsQySOYvzzzL2OzB03Eg8p4GMpM+4I7geB5cH/AwX1uPaEe2k5?=
 =?us-ascii?Q?JjOEDbhWwWT7bRKLtQ18Ba8c3s7dXRNQ3ba2olSaCO/7uJYOLB6zzs+PpmOA?=
 =?us-ascii?Q?QNEwRvuGtqdRILrdM4SesP/eCC+AkmXraDcxIq5y0H7ireRt2FGkbvtqJQU2?=
 =?us-ascii?Q?T1K0y9SSVkiuOIaEFs0hACz5MuX/T0LY5FVi9oH23PiEdKTwv8Xec7e2SH75?=
 =?us-ascii?Q?d6muvmdAbuA6ewM4GQ7NcmAwkueYfS4KIPe+ql6ur8pdzHk2aCP17iEOur2+?=
 =?us-ascii?Q?lnGfnqp/mevlDEoCFtu8s8h+II4pxIsCVxDwEwQ1lyTCeSv7twoUkguGYclW?=
 =?us-ascii?Q?Fi6lCGfENdL2nZdt6PZC8LrZ6efR2vyyS4+FSmwNVp7jJi2fOJ1o5i4hcjJm?=
 =?us-ascii?Q?J5X13bk+yf6OujmE0AeRokZv31iEPvLDiC3hFH4LzyPBiv8yAbQwtKhpndat?=
 =?us-ascii?Q?enWYcpWUglCZJV2WAWO2rfcpMyeJwFbTukA8X2vdjH/5utM5jX3dNIrXQeLF?=
 =?us-ascii?Q?eohVZk91tO89VzgBxRNWu+fStQ77XkaeSw9kbGGpXdFgY4gpZJ0GGUV5iZD+?=
 =?us-ascii?Q?PLxbA7KWFItiJpvoFs9LAOlwzfJ9efLQePCu7RwwLEMX7boP5CfORoyqjFqg?=
 =?us-ascii?Q?ZP5kO1pK0+Rgwyv19wCdYu7F8xWqtfdrrxcddTWpNI/NvpmVLsqTp4aLc0b3?=
 =?us-ascii?Q?kymTbaJI2ExZpUdIWZuf6LfS0xYbNSixgRwyynqTeKirrfhS1ncg8rxL+tu6?=
 =?us-ascii?Q?UqVlxEmnnGB1z+Y2BUGsj4AqqSb/YNK3eXWr/2R/DI/4cth520bYGhj61SuK?=
 =?us-ascii?Q?9i+hsZMjaESzEGj1WylzQmM7cQmbqQRvxGX9KqsTEqARFeWP4EQn5KwXOt7K?=
 =?us-ascii?Q?Cmfjc48nZyHSuPnxuqiKuhe82JYyDiD7Ksh/JDighoVvCsGfjOUPtnQZCC7H?=
 =?us-ascii?Q?oa20vXT9/IUDpufwSBKKUDsjHE5YJAfmB4Anbzm8/4pfofFjVJoiTG08utjH?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hzWDS6O0SFvy89zadAwLFFJOMNETiP0JJmUHMC5AjSEUA+WwK/N/UoiwYkhlD0AZk9Wd5891/ew93XYFjtNCV004K0Oju97mhk/wco6TmPwygpfr+o8hWbVMWEhLp4ZAK1Bmc78fXLbo6vQA23zSlo1CXoL0+LWgesbxmv/zMqqvdOMgXbpH2m0rJeoBIVIeeEvRqI2sOAm7DFpM82A7nSKYssI8taoGJQZlMRKKldsVUJt+7MzCeLC61ZHvhS0MoeTh08D3VpQTd2KhHil9tNX6pAJca2OgBENMBpSn6Z9olVJxQbv4SjmIQEhL9MEyImwnqWwHOlgXu2DBTJM6f/rCco5NXYxkKsZL3tx0VBlzi1c3n7JY8A3kT5a6Q/FMzK5Trzhw+0OldtqbBAAb5lSTvht4VgSY48hcUCFaKXcik/Thy0U42FETr7cfCyvq8KhcRyxWlx+r+H+t94Nj3gSWPeWC4IZ4DSJG4tbn8Nl6jeKtjg9tM8a3qCpLey6qTb01dETWBtcE0W2H9ru+5loFGKunWT3qOokCTJkVqUKy9eeyTSQDqkSxnnZecek5JWnCU4VSU9WsMPlCxUCsIBUH1sI1o/naB3k7XUs8zi9MvzPuIJqGUnyVz2/XxXiXyyQPobBMYQu2OIl3ztXTdM74vRCGqvypc8VNLeRHsUL7rIXCqXIkgxfv7E7J50H92PBj2ELfAJH4pUdemXzfc5Y8TMPk1BOda2lI83MjWJ+J0ChrLc8WZLjgRupfDfLPNkRzbygE5e4COPKRh/kipuhWjxILb9hl8lwedQMJggyHcKthMy3R5lXLGrNhw7WjnXfV+tjgmcoKOnYiq/kPM8SSJZmIZ5jYNYJr0YWJMKbsPnAENmpYkyfxJs9k9cr7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e2b7ec-b931-4536-829a-08dba28abd58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 21:08:17.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAXXwTG6CQ9BT5tQviwelFZg+2lMnUq797x/bHmatj0e6yLUUvnBV1GBJKru/at40kRbyenMZwV1BfZNIWI2RRAMJXpuczTaY9ht8lT06Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=607 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210196
X-Proofpoint-GUID: Yswf8RqpjV1r-j1XuBvG5-w75v9u0hGm
X-Proofpoint-ORIG-GUID: Yswf8RqpjV1r-j1XuBvG5-w75v9u0hGm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy,

> The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
> the same as for uuid_t operations (like exporting or importing). Hence
> replace call to uuid_is_null() by respective memchr_inv() without
> abusing casting.
>
> With that, replace LPFC_COMPRESS_VMID_SIZE with plain number and
> respective sizeof() to make code robust to changes in the future, if
> any.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
