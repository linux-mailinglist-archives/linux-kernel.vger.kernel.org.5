Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1477AF26
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 03:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjHNBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHNBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:20:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FF1B5;
        Sun, 13 Aug 2023 18:20:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DMl1JX000880;
        Mon, 14 Aug 2023 01:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3yeFxQIq4zE1Mf2S5O9kqsyOwqOIHBjrA7ZaiFE3Dm4=;
 b=sHNyxv0oP7fCi7Sr8NtiKuGh97TioCrimh8/bczE0gcUAh4rhlNy+/kA/Lt65QHJGJov
 r7HCqyIEPJUt67N/WD10nEyrzr057UHHOIADk8W+QcF8X/pSeBWSXtzj92MWrVlj8x5W
 4QPdVttvU6yr5i10X8HL8ypmZBDCAXeB5dTsz8B8Thyr47A5704ZQLXEiswSsyseb+5y
 4h6K13HF3uwKnoNtoVi+U21HinEGN5F5GW/ZxO6hhO2NtOtnpX3ma7sWlS9YK26YiPAn
 QX8oZmRgitVrEBa28rZ3NsLAztyqbDg/kW+acebzdefv0ODP0vZRpVQcwKoLiF3bYbbC xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3499kb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 01:20:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37DMoVU6040074;
        Mon, 14 Aug 2023 01:20:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0p30sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 01:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edzjiXJpOBRNZ/+u096n9zhLHFRgsHBf8ulIkCNl790qe6s3uhaqwpjGXFQG3XtjqRlnaPE+CBE84QQfXlv07CTICcl3eUZdw2Iubfzzm1R/LRl8tsMtSx8GQq3HeSSibAAkw4Bb8QBtbWnssUiudIeksoraLLwTx4rwmHvYwrT+0vEBjPmLwMyvzSZtQAwbXcJYO3wtfcl4K2f5OLe7Snh4j3QQflQRxxqenqWV8UvMl6fVAgpi3jQd/e/cZ1teFKWBQaygu9O3Rt9P8o5CrwnnGA6FFAclsZK7bjaGfjpa9pWswGcHbH/pRWwQbyCNY5/29CjyyqnBYj+wr3JEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yeFxQIq4zE1Mf2S5O9kqsyOwqOIHBjrA7ZaiFE3Dm4=;
 b=BajAc4wNZlDp86e366MLR0qQQccKgYt8lEqQsbgb2FPBkgNEYHQ2w2eTa3xqImGM2amyb/NM7TsnKe0+4P76VctfZNcoD1V/SvTeh7nw0s8tJm6ZSHtOxQJsaO8yABSqVMIKQBxp+Cvel0ynB5cjdQQ2xOUwbra2yKCieH3RIRWzPKd6KJwtUztpsSKLKZaU5qNUnVS9KZTpfExFjgZH3JeW1Xpj0cNpfvUwlfkVPFXV7VhCI27LDQLMfVI+uwtXkOxp/cFU+7tqXdqb+f9okhaJPPJ32/fLGBNet2K3sZU+jFLEM+i358OnVDBk83i+575/kq9QkXb2dWSf5s75UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yeFxQIq4zE1Mf2S5O9kqsyOwqOIHBjrA7ZaiFE3Dm4=;
 b=LqkUVgFtb6Q5c4vBeb1bMhq9llJNtdNNW8CL+fXDPeIOz4qI4tU4G4RR2h9ucm9jEld2B08Z1x9VnS/pSDToyekZOx8QDQ03fdojn5U9+4rAg9lQuLhuALrA+HSXRGDQR2rss9EHWTzlr5vPPD14S13plmcqZKQkjqe4MkdTiow=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 01:19:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 01:19:59 +0000
To:     Ankit Kumar <ankit.kumar@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block:t10-pi: remove duplicate module license
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1350mfmj8.fsf@ca-mkp.ca.oracle.com>
References: <20230811153313.93786-1-ankit.kumar@samsung.com>
        <CGME20230811101913epcas5p3a007d4594f5313a04ed5b6414aeb5b61@epcas5p3.samsung.com>
        <20230811153313.93786-3-ankit.kumar@samsung.com>
Date:   Sun, 13 Aug 2023 21:19:57 -0400
In-Reply-To: <20230811153313.93786-3-ankit.kumar@samsung.com> (Ankit Kumar's
        message of "Fri, 11 Aug 2023 21:03:13 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:6e::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: ace8af1d-8669-47c3-7de0-08db9c64936d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTRK0lrayIezIWppLx2BefuX5g2zGDVqmEFC49C4M3NI4XK2ekJERVcKWAf8V12kSPIkggfDLUHZeYGWqJskQXf3aa2ke8+g4Y6Mb36xbmUUA33H6KFkNwStr+ybbl2QSb/NSPDkxZhqF7Dzg+MPjcK6CoDWponvug8LLBVQBxrl7FFaDITFWCrxLsHXrIc0oZqcZCBusBmJXvaGaGa0d73WDohOibyqsv4F2ftUG0eoMw8FDowwuNYLyfJrj+Akb5ZIiKtHdS1IIZ/KDre8ZmrZXmle334ShlU+PmQmT6/WrRwnCM1HWeA4539qZmh6iNGYmS0XpnXdw13AzauEheRicXwGybJGVuzwJuOmNKM5tC5dbfX6f9dXCZ7tmW3zhaGCwJ3mbknPgj6uHLPIx5HYPFgvSiOgvXsGBndSK8LB/i5XX5iH56lgEScmvZczuBZE5sEgsyezG1WStUcvPWT81TRALmpiJaD5pDp7HD256osgbPMDErVEF3MPluHZgiWKIWFqK9kQV2pChSP5v+bF3UM0rl5oiMCDEn3jJ8B3KlVl+wgTX+90rrIw0T4v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(186006)(1800799006)(6512007)(36916002)(6486002)(478600001)(54906003)(83380400001)(5660300002)(66476007)(66556008)(2906002)(66946007)(8936002)(26005)(6916009)(6506007)(4326008)(41300700001)(86362001)(558084003)(38100700002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGgQgkwKRvGufn6qG5NpvL3fEDNyNEkC9328ESM29NHuU0KwGchYMsHUcJI8?=
 =?us-ascii?Q?PgaWZaRiHbAypDBoUG0kxrkTalzPtFt/FOz8a0ylX5hofhKY4Ibpa+CrA5dT?=
 =?us-ascii?Q?ro3FVxW9JNqZxd/Nhj/0K/pv97rxNqN8FCPsoyBqGXygPSJU0qW2c/5E/wxG?=
 =?us-ascii?Q?AMOdyxlL4AkfdekzSJI3V30+2iBMfRB889niWeCWHl8EbH0T0Ot4I8Hz57ov?=
 =?us-ascii?Q?OaWB/qsW+puFpNBV+embBunXHUGmU+w8wrK2+kBvoIVE4SFRpTCMMWFiDNcL?=
 =?us-ascii?Q?ipmL3LAcVdCoX4mMDJCTcZNR6uVEriPgYxlBSReekuPRjp/zzpjol1tRV1wr?=
 =?us-ascii?Q?KTqTcvMmtM21sLUYsthRPpavIK/NwThtAppjHo+FRfdewzX4RcTJGDZYQFZO?=
 =?us-ascii?Q?/6R9LH5iLOwk8/sXPdPl8JhmCD+Uu7AQtj5qxsVLX6/szK6XCv5L06rKV0o/?=
 =?us-ascii?Q?W2pNik/VfdVR2htE9juk98Jv15AwGNp8Re8j3F2+V07hgOjYwynLsFyy/gkk?=
 =?us-ascii?Q?YkKtmOLtOj4/VeU+3By6/gP0m2cECNXN6FJKy9lI5C4a2wVCnWrRI7CoK1NK?=
 =?us-ascii?Q?54VgtaA062t8VkMDkIT8HVcb1CWKAZwZJKNWMf4MnkJMT8W1XFN0CxUjvyDQ?=
 =?us-ascii?Q?K8NY6QmSv+vIn7Oo00mj4uenrs8ZohVJscE7UG1MrplUORGs1/likyuhVsKs?=
 =?us-ascii?Q?bmp14MEBHALUX4Jsv+QVmrpHeBiJD6hJu0cI9g4aDg+QVm/yzZO+e82KKL0x?=
 =?us-ascii?Q?xFb5GjIIR+n6XDBAwHmXGdN+Rvw7dTsLN9anhjgaR1+FXJmf5VHdT1KRjaKE?=
 =?us-ascii?Q?byIzaJAQ6s6LhnS6r2EATUH2LNu7HnlWBXCtpkdkJ7qKBUTazstPB4cPs3s6?=
 =?us-ascii?Q?yzKMusLgbj147EFThhpL7z2iSuAiXaZq7KTgxAtHo6G8VGXSER3s7mnY/dch?=
 =?us-ascii?Q?k3u7pBxES4oKRH9kAjmSDkrjwcj1JsqQ/YKbfomSnM2mqcke0/ct1wT/Zi/i?=
 =?us-ascii?Q?hiq4S7ZxLBT8uoJdo2GaFlFsCZF6Jq4XlThtuSC9gh+OhvYmArcoGcfexPbx?=
 =?us-ascii?Q?UTU/XuFDI1zUDSwdvRvJam+T6YgxrTumJ/59ndGiIDeJ1TIgtExyhIVPbErZ?=
 =?us-ascii?Q?VuQzvvPMaH9EeKKGeLpGlN+a3OctlqxbXt1H4mVJW4VbqhcUry/PeNqlksDH?=
 =?us-ascii?Q?54s9Qdk5Em5/TrxO/N7oZHprl6p2yIc4qovm+Qk4jkRUkiMXzBEqaTcA5dTx?=
 =?us-ascii?Q?7W5r9n0/TWPEUsv80cJ6kZ9UwVtSniDYqGbYCm7hwYgMDJATRgp9gtilkpbm?=
 =?us-ascii?Q?22b24Mw4qHSS9GyX+Cw4EOieQpICuZdYJMtOLpFmXkxWnSUsKtxcRdfk5PjB?=
 =?us-ascii?Q?/TUfKTnExX4gjltgnIFdn6RQM5DILxGUevhvjKAvOlwpE3q33x7lhKiIfWrj?=
 =?us-ascii?Q?1nRG6wzRCd8xkr6i7oYTRPCfwHKuGAuFwr9JyR00W5t5UzHL4mpoGSPk4AOh?=
 =?us-ascii?Q?0Dute3awNYvUCD2R/8rkL7Sd6aRvIffjKLPKxOZ91YUk18F7NDjM+vaPgM0D?=
 =?us-ascii?Q?ooJksLNEFT9oG7zrZtnUuz5FuaChDoxW4MGsvnj31pIImX06TWZDg3JfFt29?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KFNDoIOzyXxjQJm2xFvzeMlESFn6l6GUL766aSoOaBDj0ZQTL41QSShQ8FFPEnx/0sOYxhjREm+o5ZcYr8/vsAahj1DR0AXpbsA3HYOPVqcrFB8BXwzET8fNOjarL965XTzHS1pCUiUUKNTtkdaRu4F5YpKgmAcK9wN046G/nJlzDdo1JeGODL36Af5pkrk1UHqb0RM6aTCWsySYt3SUlcepRmNv/9UxKxXJh5bODQQK8vkm71FeczIzl7I7zq7UclGRazn6xChC3J8GdIZHY6YjDh6O5nHkNhhv2+nstPk7YwF4A3yfZnZdPOztox0zMPQ79jAPhzbqOWLyurbZEYiOXvVyzaDA3RjBLcWujxIAxLjtzcYgnXvMXuOE95CvP1eoVG1YmVZyQhHZqqOZxX/YbTbi1gvoE6K7/eVt0Hcf3NUkecPG3+61w6yY4ya0eb7afK/7DgMtH4olmRBTFk7F0iyxlRETVb9I97RKVBxEQFOujjRxgu0judoRhzRMKLOX89Cmui/64qmsyGNRbobxaOri/KWXskryV6Sj6ltBNRkt+M+EHGxRSNx4qTuTaCjvohrhgbsjoVxcWcrecHAHCnwMWYPbBeLX4foLrhX3KF5hCFKdQiLPfozngci+OeEtIOXuPaBMRc7D+5hSYWJmTnx8u67rezZNeNYIdeSOK5AogtgwCdMTu1pM4RkNY2vCnHwscxpvLBvxh3CXAq65uIi2A8Qm0J8RIzEKC/WHiV1lar4wqCRvM1JGabUDuIaj+YUg7pju8I6g8riPihT3p0ntrkFDHvWuNM++Sp4MYmrP65Swno9lNppMGVR/iIvvK7ca29G2sgVXM+JmyGQ6gm6Tkb44S7htXYQasbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace8af1d-8669-47c3-7de0-08db9c64936d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 01:19:58.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDgUovTSIE04n3b/Fl6AeMuOVbprHQgD+ZFQjubsCYlKb5B1gwr5uHEsbSV4XRA5n9imHlBqSfCOXB0iU4JmEmBdWeThvjTZ37TAdxK4fCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140011
X-Proofpoint-GUID: wiIDPR0MTBxcYRtwFKRxG3EZH_XdfxRR
X-Proofpoint-ORIG-GUID: wiIDPR0MTBxcYRtwFKRxG3EZH_XdfxRR
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ankit,

> Remove duplicate MODULE_LICENSE("GPL") from t10-pi.c
> Fixes: a7d4383f17e1 ("block: add pi for extended integrity")

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
