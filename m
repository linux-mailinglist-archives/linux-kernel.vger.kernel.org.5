Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121A7F871B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKYAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKYAL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:11:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF021702;
        Fri, 24 Nov 2023 16:12:03 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AONsiXl001077;
        Sat, 25 Nov 2023 00:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Ko4gcxI68PRmCy/yOJMJYt07fyQvrtuU/HRjbh/W9r0=;
 b=CK9pbxUysSJFGQkE93LxOv5SKpXZ2x6DLJTpRuKsl+FDLfEJqAn2STSBQMh/TC1bdU/Z
 qKzyB4e2jZwyBGs2bX+3M/r2Pz9Q8Ukyjibk84YzVSwZLCBGpEdVg9Od+wYZZwddnMd1
 yAbow8nv+Fonhx2mTbC1Yjbkxo1CAm/Ji/H82XOzzKhGDmM7i8Cnvr1bRW1LIi4w5ddk
 miXyoGE6Zprxd2JxMc+oYoXrTOdyiQ1mMpB89RqNb3Vyi1Z7SK66JNqdF4nM5vK4ckzF
 Z9YHbwGPRbo6VsSjD0fZxRgLi6b20RBJ8Bvb25B8+w/u0+oNeRTlMlQuRTBNNPU7Qbqy 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6ckyxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 00:11:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AONrMu0023964;
        Sat, 25 Nov 2023 00:11:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqcfk73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 00:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDj7G02Y/769I6OtoPir7D+y0SKEgVxOdyRy/+a70YwUslX1RIl9AVQU8C9FTNTWYD3tAnBs5dUhYH1ZEEYB7iAe0n1GcLURZgs3F0r0WAdl3/vfnmhf9O95RutrwofZE7qn1csIKZBMuDAsHzAaBm+yV9Q04JmMC0OG1LWLb78CxeIeDpqxVoYtTSXfYGwOEdBAw+6VCVeVVJrnDSbsaLAaKScJHZtXiJHSb2uubDPSF0YMjIIi9piKIAzUqOig8c8JlYfWivxT3r3hekgIf65Q8Xj4KiBIlUExHVnEgOKdbs2pSORElzpABPwfoj3w59ikxOwVuOU84pnWQyDMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko4gcxI68PRmCy/yOJMJYt07fyQvrtuU/HRjbh/W9r0=;
 b=Pwd2Zsn1jM8pBOFG09OJHsDby6J3hcPD+uGQavJEdu3QCq0OgbV/gnIpFH5K5oH4wxur7bPymUhEQDeX8NSsr7jVBzc049ftFmI797ruBHEslIv0a99D2SHP2IApGKU/0ehlmsAsw1SdlBFgdPEVZTCvU3lyhVmQo7GmciHj6QkU8QgABj6zDZYticG964d1uRJnOgNPQF3SCSc6MN7CPSF7ZMKqLqbiDVbzROwbdMNnn1pTc7V0FtH9OLwKTvtz7+s5QCZ4XV3uNlTTl37Rlp3LBaNSqK+VfA0IBUNoAENwRUwgaupnmKb2e98kzTJvbk8C/D3iH7TD0tnohwI64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko4gcxI68PRmCy/yOJMJYt07fyQvrtuU/HRjbh/W9r0=;
 b=F3u4oX7YC8ONKe3umLWReTHlyX7pLtt+3l0tM8Hd87lywjlq6YWAPZxy2gTCdMODLU5qi9p3yMNfPUFgwQloA0SobDizM36Y9lulCmefUVfQb/Y14mhksKE/GlmdeZIOfrV4890kBtWcHrcicdIpIomkcjq1PK++7CyruyVfBUM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Sat, 25 Nov
 2023 00:11:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.7025.021; Sat, 25 Nov 2023
 00:11:37 +0000
To:     Stanley Jhu <chu.stanley@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        peter.wang@mediatek.com, stanley.chu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v3] scsi: ufs: mediatek: Change the maintainer for
 MediaTek UFS hooks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmu6vgi6.fsf@ca-mkp.ca.oracle.com>
References: <20231117103810.527-1-chu.stanley@gmail.com>
Date:   Fri, 24 Nov 2023 19:11:35 -0500
In-Reply-To: <20231117103810.527-1-chu.stanley@gmail.com> (Stanley Jhu's
        message of "Fri, 17 Nov 2023 18:38:10 +0800")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:510:23c::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: a82f4d7b-0e4b-4d51-3bc9-08dbed4b172b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+FqPr4JAxzXKUnvuSj0VG2lKAz3+NlOloO5MAkMHfAU/Sxq8ys0cO5zVzDUDP/gQ0QjQkNONkjU3t1aGNGtcfHSr/YFqB4ZUWUOvpWE+ZsWvFDvqUkClpUirXLS+x/JzEuKsV3BYqheW5Genpva4rIglSEA6jEBnSy+aej79xW4d5M4vBAJN3IyAAqiiJEic7PPzZI+g9kRZbHtCPjnK5MEyiEpxWKUzocl4jfyZ1WYTq2lY559IK56pnOznliPupzj/hBssUsyrw/fpsplkBtIk72BiBmEaKgN9609e2X8ZD0D4AGvL2rNFDxfpIo7SpBqxID/HmJXYtNMbDh6TzBPjqwy3S4PtuU2Jxx9uxkyxGBXFbBO+TvVABe6x6mklMNW9RUp+GhEBILTc1qESxcCbt8sWugmEVgBAABn6qM/Y3HmL8fOBOCgyprQCrD+654ff8T1KB25UYIm1CfWLSFZD0CdpfU6O916ebrkOaboFRx+oBqi6q06N85p88zN9P4wZPL94KdVM9IMJ3luSVbLahysJ3IX9sSNQxVQgJVfQklkOQb7CPztV0YnuLrE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(7416002)(41300700001)(8936002)(8676002)(4326008)(66556008)(316002)(6916009)(86362001)(66476007)(26005)(6486002)(6512007)(66946007)(478600001)(36916002)(38100700002)(6506007)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mIzLBMqTl+mYnpkNhdYDmU7RZSsGiug0y8aMYh7HGEClajDJyead/JXQduE?=
 =?us-ascii?Q?qIGxaMcGGDeda3YCKLPIHgJUfyXZIQeSMzckySQc+maLyPP8lDsUV2/d+4hP?=
 =?us-ascii?Q?LeK688tqGwx6OCdmkuRHKYWpd9jqV+zUy6e+O4AyQYJF1LS7ykXZFBwO2k9r?=
 =?us-ascii?Q?nm6tr9etznPdvU1tHhUyBRMdeiIghGPQilt6OlBIgBamwQeI4J7QmNB9p71s?=
 =?us-ascii?Q?tqLw9Fmm/JMKXpbItPjJn0sJ8oqTDZ/1Hgfse/pWJy1HrXIvosz+hlvRiUBf?=
 =?us-ascii?Q?p+uhhcKrKjTcekpFKJC4/130cC2a5eX3uONglUqNtDtKAQfc2n/rHvFcwhH7?=
 =?us-ascii?Q?2/nlAusOy4ZdYXdttA0kdSVvp79QYyOSS6DCLmdpO7QE39J6gffDCqeRF8sX?=
 =?us-ascii?Q?KxSFZ9i+8dTNVhbhRnvWam3fPb/1l6QjvcMtAC8GFvKpr4TH4UzFxNiyg52l?=
 =?us-ascii?Q?mAKjDO47jYmTDrfZ3KTroWRONRvqYPiNYeyFR3n5AdbkSLvDXUJL0Q9Bccu3?=
 =?us-ascii?Q?Lkw/FrecgDdJbn4b73zNsfgXKBTu3MzbD2kmDZpl6YJI6A2PxyY/Aj/0/pB8?=
 =?us-ascii?Q?eO+a/bPLoJ7V0zxcANNC9HpcSi6BfDNa81h4Jf/pjJvf63OhEczq0N3YOFMC?=
 =?us-ascii?Q?dIY9mMuNkSMkvIz3lxi7VDmFZ/9X8qC6OthNCF8aQq37Ni+ajoQ0iwMEnm5c?=
 =?us-ascii?Q?mcTKgaYBm/gDvLCBConY6c+BHdZJMc2TUOlP52DoYIvkEYrNtcUQpxxtPbyK?=
 =?us-ascii?Q?Hilf460t8kuQRtwkj2UsQd1wZHypi3vvEaTRXOcB1W2Df7Dmb/Ptv+mJdeom?=
 =?us-ascii?Q?YTPqZtS3a6LYq/sQB5cOBSjkyoLg6wibWo9IQtYqyUe507o+hCBlYQ5mcDhS?=
 =?us-ascii?Q?tHxdHfMGo13MGC6968ZYbIWhpMySsec49sIuylXj+G0no0SUd3/t/2ZzZ9T+?=
 =?us-ascii?Q?PzZYFsNEPAeoFKBpP3L6P8G4NEeh1XwIBAbswWhg4v1PH80uZMBn6AF6ABPX?=
 =?us-ascii?Q?NgUXKQ+XcTpWTrHJX3e3GUJoAyEI3M0YGwCrXQsfiZyCDEr9Otv19ojjnfEH?=
 =?us-ascii?Q?9+YscFRqT0HNSqbbkfnRgx0jT0lVR7KKc1voKG2Sr6Q6MO+hRXpjzyJ6voHh?=
 =?us-ascii?Q?Ss3SGOns+uVVQQOVFNboIwkUSUMcGh95SGLEYPfxPs+V5EUwvdufgqpQYmkG?=
 =?us-ascii?Q?2sSgutnXww+xKEIOG5dYZvGJuj7JMWoJXTmwIfgF1O9QS0PBdBhl3dtCjVnB?=
 =?us-ascii?Q?ES103AqWwHNVH4pE/yZBUykQZdt/Xf61oWlMP3Sb4/oOYqDpYF55Hzc6S/+M?=
 =?us-ascii?Q?tj+KYW05VDvbYCY+A1gt846rBj4oQheYO5q2cf9XYiPv5jpTyQBsmbPGvgMD?=
 =?us-ascii?Q?4aRJa0EGzMR/Ve8cMAJ0T8jCHMh3l91begO2kF9Z3gf+pEUKztuIgp+ltJnw?=
 =?us-ascii?Q?G1ELsgFjjXzbvE1R1wEa2wEBqGKZFh7B58dnsyK2E7fz6qTt0IOAhSdai7Ro?=
 =?us-ascii?Q?JGsbicHcLIDM4j7v4SWzKBQqajqeLv9p/2nR0rwS2laA8RMQIqthBwuajLnT?=
 =?us-ascii?Q?WX+Sf9oVQ0CW8TvyECxaf/1qD6inzPq+3nOYC5yivMmZGNBF1oS66osTRtDg?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?l3d0OcntrxI/gj4NyoUSkxBcDKO9NqVAP835VRLYXZrHijIyyyH1194FMgbv?=
 =?us-ascii?Q?HLaKjXaUIIJ7LOndK26R709K16bXC4NedS4cHDsXOHu/FPDyvQVX4k8s52H4?=
 =?us-ascii?Q?rmk/CnjyezwIz1ECZfUKQVSc6iKZ3myVPUOMe9Jj6ATObHOoqLvUviNrZnnu?=
 =?us-ascii?Q?Km/j3aAKoPJXDHODYZi3nzWSVs3LdTww5lf8beJ3nGXn7au02tH2UIEFI6ww?=
 =?us-ascii?Q?ujtF7pr8eNV0BPBMJEttLVqehFCryysgjHrseajaD3vDSpBHrMfpndQLqELX?=
 =?us-ascii?Q?1yeG6X5bal/sP7iBNvGY2yvlOJvbtAMyygDhxU0SkGi7JCEB582EJitU8H3B?=
 =?us-ascii?Q?jHi+C7w5NyWVmTI2tvC1GlYUUy/SRjv9SCZ5kDzjMqCvy+9X+G5oEIWOqWCL?=
 =?us-ascii?Q?se/amrdhpWJcOtZ2wINa+o0yhHi6Snl9BqXLP/llK3ywonWGseOInIVLil74?=
 =?us-ascii?Q?PxkWCvra1Jgrk8+XCdnjtdegM0z8bayMb5gX0AUeP0qP6TwKSYZoPkduBlt2?=
 =?us-ascii?Q?KjnGIVAfT0B/ftxCxDIYdY2Z5GmAtRZa83oqmQLsOuFLzTM1DQmvJJupHcZv?=
 =?us-ascii?Q?Fvc8UcR2r4Stx6g0LX35TccUThZj6agd4o5lUT2wda3trWTypWAkUzmY7Hkz?=
 =?us-ascii?Q?sbPu5HyI6AQ/TTZvjkn3sSxh90KqraB5vXp90LIxU9Tbk3pHwmUZmOE1c/7F?=
 =?us-ascii?Q?JWfEKzFe7V4dKyo0gnIPH0wn9NU4wu16tgflNmcMHxKp2jkxtHDSNdl1OuxV?=
 =?us-ascii?Q?j0iXOu3ebfi31COYmYVN00SzMWGjdLNOHeJbd2EQQUrKAV92c1JavB5o+MO0?=
 =?us-ascii?Q?nZDpFCneehmezXmA4o7dxQDJeBGBexo17r1S289M6Xe/CaSyqjIGp4MCAREl?=
 =?us-ascii?Q?YQmd652QoJINSUns+sTgJEUM+qjoXwXjcwwRji1sAh2msMguIV7vmI61hdiR?=
 =?us-ascii?Q?zRU7ip+mhrXENHxgEbNhX+vT9QAGUrpjsFGNDVwjDlsmH42ff6f7elSK4Aej?=
 =?us-ascii?Q?fbTRsExOF0rWuAZHCIPjpdsmtw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82f4d7b-0e4b-4d51-3bc9-08dbed4b172b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 00:11:37.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/6S2om0E2GQ2x+Ez4A5n+VeGeAZ1QsQwh0Ogn+lsYrLoJrcmiwDNByaC5Ak3+BDMzNocIxPRXlkNxDxQofNxpAHle6VTUdRq6HzluJr6ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_10,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=858 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240188
X-Proofpoint-ORIG-GUID: -sINHhcUsSz7UpuZgybojNJE1aWBuly5
X-Proofpoint-GUID: -sINHhcUsSz7UpuZgybojNJE1aWBuly5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> Change the maintainer of MediaTek UFS hooks to Peter Wang.
> In the meantime, Stanley has been assigned as the reviewer.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
