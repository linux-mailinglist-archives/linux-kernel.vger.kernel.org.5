Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4238064B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376467AbjLFBlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjLFBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:41:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7DE1B2;
        Tue,  5 Dec 2023 17:41:20 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61a7Qs025549;
        Wed, 6 Dec 2023 01:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=sBovhTRMqKv4PHDHynhTdzKUPKNWohZ2SWFrmHiItbw=;
 b=Lz0LmZM+fetIZQpGCnc6kRIqVXgPLiLHqV/GCqvaSGlulZnhXhwPMJMWy20KiuCNP+/+
 oRPukTyDN3QnCNvuZV+2QAOcS0a4h5/3FTqLp5nsvSwVFDcxg41cC42skBIVjEOZFNdP
 yZbO3ksE8wnASIAu1SXYoug05ryUdqQiEZDY5PzBv4I7F1o5ejRpdYh4lWF29Iqm0DOu
 T5DpgyAwwYlQtTrrH11L2Wxi9euxpDnrF0jMtJ2o8s62VAR5vRvpowq+1UBGadrebfA5
 THHAs9oDeCE1BHPrIBJlyct7ysyIU9Ly8ACrmM3i3m/EjbwY//TBK3hdqzqLx2Uwwz9T gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1g85ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:41:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B601hwv039498;
        Wed, 6 Dec 2023 01:41:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan53mmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+NGWYeOukJg9AXUAD5yBSnlcjHnbi/ZHvV21zcuApwHMXaBF0KAIz/1LpFuWfo6yDdtF/LHiau4JN1sKfAiY9TInzeii8J39VgRa4tbBkxZAH8echYuZXw41eI4xH+JjtVwd3q5rRNZbzCXb9G9Zz/ZbAa43dpRB8l8h7Hlk2P5MYmLHddga/a8X3XphVhB45/QS3JWemgXFZHJEys+nApYQ6c5BVl2Va5kQ8x15NdAnCqHUGX+d20msiJ/nuhskQlGInjUQyekCtjFbQfz1Qcn4xAGGZ5V3okMsUvnfTvr04eQPLelHKDynnHXM5co3jwWhGffw5p/rSIl+XhZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBovhTRMqKv4PHDHynhTdzKUPKNWohZ2SWFrmHiItbw=;
 b=IRWP2p7OpmFEBOR1PnFc+1/8IEE2cTgJvK2G3Pp0EoX/OkscK1ocC2RBOKGfbS0/6uVZX5nDVlPr7LUjWDMm22fdqk1dwaUoF5Ui3hAjPJ+Y681rB8V7XAnbiIJ71pYYvJMYgrDTZhUG5oJRe/YC+sOmxUqmhAKrLk1M1n3oW4mslE3GNQg8AryWk06cXpDOAcwUoDb3IXYjFvazS79lizpmCTEYTfYTBF0pWfSug1n7rI8eo8T/5ldUYDL2FkTNlY+JbefElXqgQNMMhA5ddE/v9j05SJ3dST/j6J83VHqidE4dIBab3fZoNx57bPVlDOUkNVt4oBpXpIlodHQXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBovhTRMqKv4PHDHynhTdzKUPKNWohZ2SWFrmHiItbw=;
 b=E47Qzod57ssF/gV+MtKZSUR23NnVLKZYjKz/tvFK9a460KKmdxMCg19gs/x0gMwaPG7yWk/3k5CRzuKd+OJWCISh5x20Nycs7/9tZFXuyn5FmKoCCz1qN1uW+Suhdwv+LfTrcgm67baWz9BA6LCjZXEnQt+hMP2TpGFlEMMkTj0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 01:41:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:41:12 +0000
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7f4p0pb.fsf@ca-mkp.ca.oracle.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
        <20231124090919.23687-4-ilpo.jarvinen@linux.intel.com>
Date:   Tue, 05 Dec 2023 20:41:10 -0500
In-Reply-To: <20231124090919.23687-4-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Fri, 24 Nov 2023 11:09:16
 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: c2af9335-e6d3-40db-db66-08dbf5fc6db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfpxXIBQPnbkf9QWfn8jo2l71jXrEPf2Iims+ekTVoz1zq6RAo679uuwUPGwkQPhrEliXwd5K+2z04l0ccbpR80KCRH9GEbveL7m9ics77llKc/YlwPnt+aTQkjJvjDliCzLc9vajOanw8veuJ8Zyzisi57KxlwtFPyi9tsRDku2UxCiIIthzozRbC2ULWI5mLmlh3lLA2dhMil5bGK8me6ywruqZrZW48zMtGLN8Ursp0lF2sn+vH+8OPF5JbJLZfPi3pPZS7W8s5qDzIQEz1ZjRML8BlWRqkwkrlxse+nstw0lU+b+NNA5eK7FgNuVUoFJ7Hdr2+vPxeT9fX+iq4QERejy9y9Z8rNx2/7RZ6Q92UJmvi6gyhObGTTXI1X9D1z9Smi8pJUNbI4Qecbfyd0o57AdKfyNBAM1kMWXM8Z4MLywV2gjEwJbFbSGII+fpp+ahlywlNYIj0Iua4Gn79dhuo/SWp6KURvfTikeJdLQg+UfMEWrkHb0nZ5eKDp1aPdippv7MAqa35OYGEgPX9mzlwtWqX77AI5J30l4+5hfXjm/CxUV5O2ns+tAdXex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(4326008)(8676002)(5660300002)(6506007)(36916002)(6512007)(316002)(54906003)(6916009)(66476007)(66556008)(66946007)(6486002)(478600001)(41300700001)(2906002)(38100700002)(86362001)(26005)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdwbeOaATmyZdrK92VgSwH3JPx5qxO8VvI1otaNekhD50l9z8qj/73JxG/g4?=
 =?us-ascii?Q?sAkUPChxmlZXOU95SLK1b+SuzhGcjcQ0nml6humROgEGXddELHWrRcH++o2e?=
 =?us-ascii?Q?EAU2imQT+yi0DdnOgWmbFRHQDpkyN5p5K1ZVlK/K9rjoz2IsWPCW5Pb6Moe3?=
 =?us-ascii?Q?iDO/rQ/PEHzjxnRU0Ax+au78YiieFwi8gMuAtDpKvPyEFUSbLzt3mtpVte/E?=
 =?us-ascii?Q?YTEHO1JW9OotC6YvZG1agL55IlFO/CU14qPRFhfk4tNtKm/Lt2Mkg1AjpVrJ?=
 =?us-ascii?Q?u8olz7sdLCGyRiXmTKnPfwm7P68TM0YOv6u9sJQgAfSkbPNZXsYvyclR95nq?=
 =?us-ascii?Q?CM5Aeex0ZhhWG9uzJHWTdc26OnpevvvF4a/LiQuZrtVFwnOdSaJuXZdcFBfC?=
 =?us-ascii?Q?tEudrePZZCLLzRpqy4u4g/pa6+ZgbowJYm7EYuy4cb5OD03ooTCVR1TkloHX?=
 =?us-ascii?Q?XfgjVrv2hbU0DJAcYk7Cb1ZrPFQ6kjX9LS81A2Ot1akRseJzajgSipjlck1W?=
 =?us-ascii?Q?wGtRQdux7kT29Dmi2tcBMulTgxoVyIXywW/KW2oD640wc3sb6cYsDRAIdRnb?=
 =?us-ascii?Q?+wvs2qIwl9UyWWBfyisQiHGvX6KMlh0l9T4MqTFuUd3ZU6mR+50mX1j8sTGk?=
 =?us-ascii?Q?+FB3PuM8whaXsNde+luWDp+uf9Yy3OlYj9+wb7QokrDRrWSYoFoSS6cCwm0G?=
 =?us-ascii?Q?/2SalWlukyT5tHBAD5UGq6cZAAsHPuZ+QwZUiKIJLYQ7n+JWX25B+9CvSybh?=
 =?us-ascii?Q?b8NE17IUb/CbyToSFfkPSCNpMM0up5pFkiZfmxdnrlnbRRqWMXvtE8hkzB1l?=
 =?us-ascii?Q?zXi70279rnGH9Pv/lTNvX1ungXhI75a/mvD/SRLoXvWDLWfzUWjqkSUtYYJE?=
 =?us-ascii?Q?q+cUfO70Xa58n+TfbSf3mDA8y1DX6ruWKP9AimwhMTL0iGMFkl9X+0uTCAid?=
 =?us-ascii?Q?WJ+dgO0jqE93+PMAiUfLpjGRCeP67UxMroI+UE5QEN3x74dS1L0q6aEMP7Rq?=
 =?us-ascii?Q?UOYOJZsLgQgR7TKFB6nd/60nBXFp9JhCwqPsXtLEJ8aC1BzkG+6awX+ih7Dt?=
 =?us-ascii?Q?5bstMMXQTwthYkQQOpIm335R77PrDE4MzgUbRgWzmosp/9en8zRYh0s5iPKl?=
 =?us-ascii?Q?I6hhcqMarhn5GJ8k3UvsOypDvSGFMT0EV5nwhu632LG2fbkqeRYyGsGksPlH?=
 =?us-ascii?Q?txVXvmfeuio9H5SukPKXOAIlp7VBEZ5ZjPBmIVee1GnJkrRF1T13Dtnlo+tR?=
 =?us-ascii?Q?tba+spCUsTnWv3vpufPVQOeIcHTKkalBAQV5oNE6TtdJYNiVbregU5eazid8?=
 =?us-ascii?Q?EQwlXy9um9kCw+71M9wtL76vuH2q/H2Yx90ul/NBmKSKbsBEEWubMk9y/R2T?=
 =?us-ascii?Q?wUFe8yNPmY+3XZg3hGZ1QQTGgGTJ1VFawLQym/jstEoTWbQxb4Y4TJNp6BMa?=
 =?us-ascii?Q?Fb6/z8R7sY4TqqkQCs5sVzhnsn7Tq5vtIZTZ21XGhivfKR3vSVkasniD07RE?=
 =?us-ascii?Q?QldkQ58d/EUnCL0V9iGkQF0TGLDumFTHs0w83biJnW03WRe+IDh36k78xDOU?=
 =?us-ascii?Q?8MPI/YlMXbbVJ9TblRJ0uph6XwLINiuxoxdz+/OuyTMZ/KuJttNspPNqLYLz?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pGlaki+zoDpXNM98TyO1wXVv1qwjdHZP10JL47B4exyWnJk2GiXN/IdqdS6xO0rRJjSNe/F4o2VOQSdLPF2FvncIXUP83KE/r0/ElLWuuaTeY+7VB76E8uiWemT28BQKTtjtv0zYR85ZtERo5Tp3Qu6LSKRbWGPnF5u5DL3LDWxaGdCdNAO7+yGRvFYRaYWVVOOSd6dFoJNswhzfbCaFvhB/j6Z0qTT3WY3b2i1l/5PbK4cJW7Z6eAoQ0nRbxKZse+0EzAe+N2dm+rA84cenjc8a7cPydru486egZFh0Nmm5ov6nE0NBCOD36dppTHpdwLwl0ilHsKau/2/cmosW64iY6dp858UlA20Jlu72kLU3IHQZ+4ALO0cOti3I0kMdnBzI384xzDjx5YoVn8PmXscg/2S4c7tmL2aeLsT6Ow3bowRIHnnPDgJMakA3u5bXDMsDEv7YW1O3ElqgNAwqpu/0znaXFywmkvVR3SKRoVb/irws1SMSEHaiUXL/JWtMidH9+kcnwMXzj9BMckDHu8USTU6iTqsMI+fG9bOq0Q4FyMEZqzqCS94P7bpydzisxSQ5nBZEm57NQ1DRcAkkx5VYCUrZefIrIDO8fw+FCTVjEmcSHYuSJboG0mm9Jy6T4SUNJrsj7TzxcvnXdBWiUEwvP7jHA/3zt9esjP+Tu7JetkE+4BHUOXYtALtaJsOFg/NDK0SbAWqFbIeH4ZYSgEA/tZ6MfuFHEDPv0DBXS9ONKRyZN5vG47Geue3tPyQjQ5sMrOvFzTyLBGEQAW6zXXtHwU9OyiF+NMCxzY+d7cIhRLvDDr8NNxQeepFTgi6/4A3vH6SUhuGYNTRmELZotcUBxTmlP7yaY9GX1z2kjzu6LCa47HY+zDMDi5NUcYWV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af9335-e6d3-40db-db66-08dbf5fc6db5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:41:12.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba1FXL9fJMN2d+/aRF3xABWqu0OFt1sRCfAL4qwxL5+u8/XUbmbXEfzRUGKOvcZgfO0T8zWCccKUi83VTjKjgO23JT0dE61S3Mo8FW+fO4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=756
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060012
X-Proofpoint-ORIG-GUID: ksIm-1vkh9l_TAhqv51tGfjmB2OO_7Nh
X-Proofpoint-GUID: ksIm-1vkh9l_TAhqv51tGfjmB2OO_7Nh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ilpo,

> Replace literal 0x80 with PCI_HEADER_TYPE_MFD.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
