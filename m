Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF12578E47F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbjHaBng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243236AbjHaBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:43:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F80CDD;
        Wed, 30 Aug 2023 18:43:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0ELBT011966;
        Thu, 31 Aug 2023 01:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=oSyCuz2nJ30bYJSVBlBikMHoOpNTj1x1SKyTR9DHKLw=;
 b=zQQintSx0votFovz5NVDVHnuQTVkjrKq4oZBGBTS3xPlb71CU+782kaiDE7dNsdSiuIt
 iJZ1ekbUMuK3YWasgUv1Te863b2kmj2AGpYAkP/bTamuvHXUBEfxzyUuSaLe1wCC8QE9
 vgS4/63sEut6AgGOPn5ggnyQQAXnZR4mLayARfWd4DaT+U1Otiu+FXlxFnMj8mO3GGzu
 zzw0RFXhIJipVqII0yKWSjaY0X9tlUHHucW+PXZ3uJmW650x+jh32KWmm23LDhWRaOFv
 XDoAB+SLKYqsCLznQu4e2QP5oy0hHyUdspGQ3tOTWqaTFGdTlB+xXcjvGPj94ElFmWxS Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt8sf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:42:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0SVel024500;
        Thu, 31 Aug 2023 01:42:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqap6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGhcZ1M3tdoJ9/e4wbcVCWyRNcOxVyRz+D0lcUmDWBWhumMTLgqKWXLT/TJz/9fMdhKJ3Mmjb9O0BGUN+zynmKqQIJDOQaXky+hovtTD+4UsDsSFs4u3yLjasOhuddcPxZ2c1nDGvFKXq99YHN86vyv+5+gDJqzA7Ve1FaZ28S1XCjMfEBoTL+aM5t3S1X8qvbeG6pw69XS0b2RS1eYDjTyISbvbzI6nLmpH+mEa1RsjkEEHFBjOUIHzxsLnR0vM0MaINDhI2yRfnDYKHkp8DJOljS1UUsrWMLjKldxwUHKtcf1ckqzz1c3S+b0gjAOeT5eLOhXm3tVK+lHXr1ErBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSyCuz2nJ30bYJSVBlBikMHoOpNTj1x1SKyTR9DHKLw=;
 b=SgPJMPyQheOES9H/bNVf6SOzJUNlyL487R2E7u7S2aqNQHBieDG4z9+a4p7XBhqbxaaswXGBQRY8PCuc6llHUMjvg3qYpJnY/t7slhtjK3w6PQiJFPV2qFHZLNfKQ13JxS51G6rm587eE9wCvLmnSVfG7WkOUEDEfi3JOME3iMDoUN8nxwCWHkFVEVF2g2bJNp7JZDsFU25DsP5j7BoUNZIa8VZSQQ0URX95iQPgwAYLYmmTPxyrTv+jFBhgigUnNkDbGAP6cNcSV08QJEhvPb6dBVGanTAWkvZseOdP6vEMwsjYObI7ujGU97fgptUIlB5n8Q2/bS14CrI8iDRqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSyCuz2nJ30bYJSVBlBikMHoOpNTj1x1SKyTR9DHKLw=;
 b=zn7BuZKgtLqX31WXHh6mlbzkFAx/ez1NUiYormJvukXAO8NuhnDg8/5bSm3laUnSpo0OGgytnIqTGjWNFKLDpYoUL49iQrrrpSnjp1NXMiBqkrGjWb07ew6EAkzFCTx/5k6LoI7nE7eKZ9O7nQ2yrcJ5jc/u8p4nBDoSZpjq4ik=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 01:42:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:42:47 +0000
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, jonghwi.rha@samsung.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Changes for UFS advanced RPMB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1il8wt2b7.fsf@ca-mkp.ca.oracle.com>
References: <20230809181847.102123-1-beanhuo@iokpp.de>
Date:   Wed, 30 Aug 2023 21:42:41 -0400
In-Reply-To: <20230809181847.102123-1-beanhuo@iokpp.de> (Bean Huo's message of
        "Wed, 9 Aug 2023 20:18:45 +0200")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: dd148308-5cfb-43e4-df77-08dba9c3941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tl+aGlfM3jQ3W74mfBeE1+hku8q4cFAipZlqIBhQXz2yz6LFYT3/9/gWNjPO9HJ+VJWwd4dzo4yZqPZvci5jELNftFqTRU0xWlXn4+lidoSSoTkyU+O9KcI/Y6p0ALmo9P2Nm/sbbkFHdxDgVRkpreOM1skjzmtIO4zTFryZhlCU4RbUIahapy3taQljMPL0rZlOQeMM8ilNUMJ8WedeVt6NVSzEc3TBFoWYfT6N/D/xp++Fa6zzybuuWNJljQEIoM/EaxbQ2/THrOYnrv3P07aYAKBp5MImkDdRT4O/yN7+JVP7pTapgLF4v/6+soUmbe2Qn08QZKeUi6Rp9WfRIgJcOG8ldnKBD6PGuPI14ZfekWKIAz9oWeXcXpZBdTw5QNuNqQKvloCG9hj1gW+Yw0AMXg7Hupx68gFJJDnI7zildxLhf66+jn9dWjgyYqqEjhTsa78deZuF0xidXQHf635Ifm8JN8bZnfofjBZoykovH/PhDPpN/Pwi2/l2zhBwZ25hx3bgt1M+pidMH7GpWc0pMd0Iu7XubZHuy7f56DR5kUe/DIvnf8FSmNMqyaGf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(478600001)(66556008)(66946007)(6506007)(6486002)(66476007)(36916002)(316002)(38100700002)(41300700001)(6512007)(8676002)(26005)(83380400001)(5660300002)(558084003)(2906002)(86362001)(6916009)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqgE2i8ucKLfz/NPsPfQk/QCb23UTnXzcx509XMpE/PKwPAo1fdoKqhHfu3k?=
 =?us-ascii?Q?0Wl5a5l6CP0RFqjz5PqaQ9EV5i4LGV3bYavdqakRiXIdPKQE11sZVuyD8JZP?=
 =?us-ascii?Q?cy8tlYLREcryPtepTEAoWZ2AXc5KdHJi20V8+lNRskldEPr/HCfPavWwE9hB?=
 =?us-ascii?Q?qE3PE64886RstePluICju5eVu+oRcBp5EnucxwovuuKFqaXi1LYTGmFpxibL?=
 =?us-ascii?Q?Nh3PKXSqaAbV6ev0z1gba/4e8z0vOkK0umSElVBWZN9aYfU9iirsbA/FH29X?=
 =?us-ascii?Q?oDhEk1EXrwoTAmb5pb7ASCMR1J1R9NEvSfK6aYuLl7QqYQiA68kG7G3ntssr?=
 =?us-ascii?Q?NmusjIT8rYjQOKfENLW3THGjb4bo5VePgq5N5+zWvnxLRcXOxLZSBkbFw7ev?=
 =?us-ascii?Q?HWyQrf1XK2gayAkgL8LXOLKqc+WzSDEwOI1J5yyut3VYe7B+HDkoU1FSEU8T?=
 =?us-ascii?Q?1ywsrSiHY3upB3OaRvLXORuQkzrLb243Hkqu7DtCsebLxnawJ7YPelXKyL2a?=
 =?us-ascii?Q?N8ZPznKHq3GdWsm+wXjQHxW4De1X3F43hTtRMxvF0WW7GHaGDI7gQNtyavdr?=
 =?us-ascii?Q?uy53fe6/NlregYVjAgxmtb+RX1xlg11jcpznETu9U9CypmMq4Ke+bO4TVAgD?=
 =?us-ascii?Q?aqXl/bKYLDI0aeigrCGdvMCagKCDGahvrntfmK6mbnlqQ63Y5CMJEwizqbc7?=
 =?us-ascii?Q?bxqpJeRNG2AH1AccSg/bZJW/EW/yf+JUNuyP9Jj/uJH6wvNjYZ4DMCZs+/vu?=
 =?us-ascii?Q?mbx35f4nO3QjumnRZAJ7mqtKDtnMn3lcAyN1rBXxtiGshOpD1U8KhSi3HhPT?=
 =?us-ascii?Q?eyEcMuPRvnB1+7jN0c1T51++j3aQMgzOMjcAMD529jSjCYlqERLnVCC6Xjqe?=
 =?us-ascii?Q?i2RnZQRub0RJBNbAOSIVOccJTL/1fLI5l16Tov/S09S5OKPIfD+3oA+nm1v3?=
 =?us-ascii?Q?6L/v4Byfj3eirPMe7CdmpMDTKgw6f2R4vjnjaHQOelzxKP1HseI+eyIayiEt?=
 =?us-ascii?Q?pCSI4bHW0WJ1cU7ED3mX9VaDCqbnAhTBRYouDm5M8U55QSuAXqpzklocH7ui?=
 =?us-ascii?Q?LqCVS2IDHMtpq4ns8M9cAlEH61VjJj6vpkNo2B8BQhteXrff5/WGby+oZI8f?=
 =?us-ascii?Q?Z7vfhGFhrKSbP1JcBrvwNrMj1SsKb23Ydu+5Qw868fXtjxsA6Y/xQdqvHAPW?=
 =?us-ascii?Q?WN3KPnqmEJnPP6qL5KLe5A0jwsUKegpffm42qDhz0ZAppYkpCNZk16JTmn+S?=
 =?us-ascii?Q?SwCToA5S0ASfE47sQMvyTVvGvGGzKZW7M/UaSm0OkLPOGLOSmVOoyEi+swT/?=
 =?us-ascii?Q?CiXEOq8YloO2LRHideQX5bmlANzhcQ8jAoo59Fd5CCFT7qutqzYTjEL1Zy46?=
 =?us-ascii?Q?0GjB9xUtBzj5rx5/9PTWlojZLNpvg39PUPpqTagRucKxeTLkLD+k2P1mH08G?=
 =?us-ascii?Q?ySySit/zkf2X3anYRhMuSxdJrUSD/Y2GBW3vlfOZL6PIOGmZT826jodJHF4B?=
 =?us-ascii?Q?KOp11S/AykqisbbCVuk3RTGD0jR8/jH06rnZZ2B1C+q77Rkc3HKKhV0yfdXZ?=
 =?us-ascii?Q?OmBbSLg46U3KkgyfW0rYhVAbcZmjLwL73heBv6Bvid92ejg8Xrva3K7GXCvE?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?02QsiMBK1Jl8PCqV+q8J2//z1uhKmu2l4a+lTOS7EyZyKNWv1SFOhPEHe2Vu?=
 =?us-ascii?Q?LJuc4sH6kxiFIoliQfxC+iHuFu4KLcL8oup5j4NgfLfe++byennkDz0V+ZcU?=
 =?us-ascii?Q?ekIJjN6U8GcPjWzr8UD96JyvprWvRxzs+aHZggR0VkYBDyNXqOlUypoU5Pr8?=
 =?us-ascii?Q?Rz/FdtAgSzbD/R54hl/MFrGotZvgfKl2RBI6aHUfIX/bOESaTrf6ntlp/zpu?=
 =?us-ascii?Q?zLYIeB7j3oleDv8i1sKXj0PbcZfZa07SXZarpH/8ELdPAo818yT2/BzQK53l?=
 =?us-ascii?Q?Jq6tOTOu3LpNqQwEfeoXZ2Gx2pPNG43dlvPs7kdhXe2f5at4bVrSWSUSb0JB?=
 =?us-ascii?Q?JeHSbLcxwmmf7siqiWbHYSkwa1CRAUboTWrlXsOyGQelkp63iHkkR0xBw40M?=
 =?us-ascii?Q?KF6ZcrwO+jpGZBhbiTrcanltNC6pXlUQ6raZYw9ExuWypgDgjXUgVPBKV3zt?=
 =?us-ascii?Q?/P1upu/4VyRAG9l3fLc0d2LT9TGnCkF3d9WaJv0eBQZZ0NXi63ciJmoikeS2?=
 =?us-ascii?Q?zwUH95C6u7gClAICvaNJqW+3VrsIqc+i3fcBWCEmpkWXieJs63+ljibCvZAv?=
 =?us-ascii?Q?23jrKMYwGEA8EoBPxu3RE1JsD/HWtQqkbSmJCb1u5RT/cIKTe2/bmY2QYlZC?=
 =?us-ascii?Q?WCWQJ0HNlFIklzKJTyeyrGLJspX8eWAsE5JTE1tiB8f5XEFqacmVPuPvuD/F?=
 =?us-ascii?Q?rZ/zNttnWhK8WEW91OYrxddSQNplYg6OSWcil/VKMNXT5EDn1mzIFpiH8INl?=
 =?us-ascii?Q?cOEoMTfxKD97NTLJhDCASEwyNpFK1nHhOw3glO8RJOkXH72LkG2apELR2GuW?=
 =?us-ascii?Q?ODAZHyLV4DApyoWFMjlSTUj290V1H+MOrvg4zTIDP0V8kAJxJ2VmNw2nI437?=
 =?us-ascii?Q?rnHcY37ogAt/V9Ee3/YLzVy4sR0RUGTjmqYtyP4Mc5mT44NE93QiNhEdxXl8?=
 =?us-ascii?Q?4+aCpuhtyr5EUvr/6OoLPdKKsJLfijOEAQztQpWIw5DA5plHuPvDMo3Q0Q5K?=
 =?us-ascii?Q?LZyV4Cg6wp8ORynulw+it0Q/hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd148308-5cfb-43e4-df77-08dba9c3941d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:42:47.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PNQkhe+HPtCMgOURtiUWnpZWYN9XQOXW6qhyf2uhIYkOeoO6xEc87zTE5RIMpNRdjOIne5nnrVP5M3jBo0hnuXZ4qNi+vP04yR2tMpc5AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=577 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310013
X-Proofpoint-ORIG-GUID: lIqC3D9BYspCRYzrAa0WGjLysGrUwSsf
X-Proofpoint-GUID: lIqC3D9BYspCRYzrAa0WGjLysGrUwSsf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Bean Huo (2):
>   scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not
>     support EHS length in UTRD
>   scsi: ufs: core: No need to update UPIU.header.flags and lun in
>     advanced RPMB handler

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
