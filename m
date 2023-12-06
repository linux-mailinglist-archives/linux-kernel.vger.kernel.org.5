Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9829580659B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjLFDWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376325AbjLFDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:10:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8390A1AA;
        Tue,  5 Dec 2023 19:10:51 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61xU1r019643;
        Wed, 6 Dec 2023 03:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=zdc1MSs1H2vk/pgOQDnWNeKO0OjezS5a2nlHCM5kCLw=;
 b=KIz3oSFQG7gNFgtvs+Twkp3nh6XrYH8xQjnPjaSsaYJjy7mtU1va3O0PAd+PQpQ/CqRv
 DjxvCTTs4JdBENc1jsrSxvOqIdj7P9xTHUGEdyBFvcwkZzn2Ah+7lEWG5wvGNRXK1IeW
 6e8brNnO/cwUqSLPZyEUaSwVJmwGsCKuEN48in9m6PTpZan43YQR6yNn5Ur2hFbXSe6H
 TwwfZLC1zR7uY6XIggWDOsvkBSfpJxJvrMUZeO8nCQeoEsYMMmeC4NcVLkSE7+zcyw+R
 TjxX3v1za4gyEI2Iak/p70++rfyvR38sTz5C6jCnjIWBDdPITuQYgdxLOqGleZKvr/ES tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1g8882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 03:10:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B62K5N1039587;
        Wed, 6 Dec 2023 03:10:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan565cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 03:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf8gUicZQtPfGk1fAWYQpEql4RXIMTdW/91G1Q16OCorKCAkikKYuNlLtX5ZZBLTYCSt5wc7WoodKUlesWpFQHFrEcfGcdGV1H0LOT83ddkTshdgaPEvBJCsR9hCjmvD00+9ysTE+58Pa/GXOv0JPIamiS1TocWQa+U3N/FzE7UJmtASjKNc6VycFgolT7JD83UQ+yOHwaA9obbiCk/fiBHpNBAsNRa/7nYodmRpCsBNfiUuox000p2XT+rhev6frowIH9+af4i5ixuOFF/MoGjQlrYHDw6SfGLbuq7QVlB+Cczmvt7UB7C9RAf/ctS2guXXr9DMHa3MJnrBgkJNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdc1MSs1H2vk/pgOQDnWNeKO0OjezS5a2nlHCM5kCLw=;
 b=VjNch3MWvJtJpz7/oivCZsyBajKo8jVfTuRP1upbthNwMcdNo1y+hqNFBd+hFveWr8smiDYkTbsteLAH88LT3TQEGe/bIHhF1lJ4ZP5FVTifJ1D4kiK7NJCssnmNLknGWULbDYtQQOYa2sQNrVlV/Rnz1oqpfqLgB8knxkiKkTr/L9Ptq50DMRgMxaKEfdlGeEZCYQHfm/dLr5HlHe7iJeHX52FOzluZEVMup5gUDHG4Q6525s1mlxqTFcWePgoHllYcSdTibqjYxxyaJ65V4FmPkg4S7WEDo0dtUAF2PlCWzj5DUXpGrN9yscij1SSGpQJOMEPn96k6iPc30ADhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdc1MSs1H2vk/pgOQDnWNeKO0OjezS5a2nlHCM5kCLw=;
 b=g41sBVppzQf/UuFb+UzQsyjGbnddeZQv02iBLbttqeMwyL0DjGW4aFsDMRynyMmAEFyAiX64aCnsI52zzS14qEuojhw2/5VZp+c73vkwf9hLDYCLaDEni5RBdPgOTO47hgYqzgWrekFeV8Xq0QFcfq3tSdDtwLBrAz4+/cZWj/k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 03:10:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 03:10:44 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jgwm3gz.fsf@ca-mkp.ca.oracle.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
Date:   Tue, 05 Dec 2023 22:10:43 -0500
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Wed, 29 Nov 2023 18:33:49 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a358f9-6f14-45d4-7b0f-08dbf608efce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHHjKWJ0iBHqiYnvQthsOi30YuT6qvmtfnle7GodtHPwzBi6YRL8D2/fZStCQBbMKPDvuVPek+o9AK6Vv8Co4cUknDy4AeeyaC3OXiSHbTuEa1IkZJ03EbZqqegsSSzRjhWNFp+jGLXL5qB/odj4shzIOw1G1HM/Do8jr3hCErY+iVVAjP8lPANIL7tYWjx5mSY3RR2FqwqKFbOn+x/fVxsnDfRAWDLzmfiYscaBi0RO+bmLieAde7X1x+uZA2faFsopUJTbfI5A+KmtplvPKC7aSfIKah34LaEaDRmR5YWJo+k64AVHCyZpdn7+1Ujtq1F9VwWBqvV/UvZTFGFx1DL0mQVudMk8bjJHNRVzPifURdsA88RDoIh9YC8JWuNXx3BajunvACLCgm0NCXcs3scw4iHQwz5h8ny+BqnMOwp1++L5Au9ibfoEGPh2puuRO3AzN8AyPoSqcXKpGnHMtCC8FmsAHbjVb7grZY6GNrM6MAuzCtz5DIn/8InFFIfTS772/lSYolkgGYZQtSV39oXSBir2qke/0caSn2dBF+2AkFm5AlCzO92EbW6+o+fd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6486002)(7416002)(4744005)(6506007)(6512007)(26005)(36916002)(41300700001)(86362001)(38100700002)(2906002)(478600001)(316002)(66946007)(6916009)(66476007)(66556008)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbmZZedplRJzVoRM6jg7FmmDzUVANvmxCZxfVX9Y7qIlTmaQGwcNskztdG3J?=
 =?us-ascii?Q?as3o3Fv7xyCRuVeaKec1hqTs26W15RGH2vBTHOT+HQZWzgjmFPn+4WCQuPXN?=
 =?us-ascii?Q?tLTaw7lV20z1fBQk7+QLIOi/+4F8AsKrPLt7xt9EkY+Cd9mrKdXh5GkniQGG?=
 =?us-ascii?Q?h2u9kDULvJFGN51QwS5l1WPeIAzGJcJFvWXjYxwnRLaUzYR6t2+rNkyzqF5v?=
 =?us-ascii?Q?FNUwLgjuICopP5Th/TEMUxQL1xaBb49H3jsBTfst28N5kGKuepbXorcnJ+Bx?=
 =?us-ascii?Q?7w5heL/7FYDIuLn1Di0ccdzhnSXzw/4You2Op79xBsl8zlNl2Zy6UDjFINiW?=
 =?us-ascii?Q?mbAoo9r7ym2Rg9fetQPgwcBRQpfNF404bwwhy8ygqavStK5SeldFUYQeJR82?=
 =?us-ascii?Q?3G1WVmT0/nwZmuNYa8ksP4zVv1EV0SfOFqYHhYqF3q26WxR4AnWwiiecKTGi?=
 =?us-ascii?Q?qruf2fV26uRxiJ72YrkrUZfAAm9iUN8pnwynLWelim6C7oZmSmozOo0JHO/7?=
 =?us-ascii?Q?TIuWR7jv8oe4l+nKGKuDcEJRZ7iQkX7VyLr9a9EJyBsaoY2WPNz3Ko5E0SqK?=
 =?us-ascii?Q?56qH9IFjEgyYPyUZ4FNhZ7ww9RuXxMAtAIfHRFiBoGrma6u2QdNngIBrg0sZ?=
 =?us-ascii?Q?oaMTG8+YDbpRRzbQxXTZ7hkDyaxC1YZ6N7Hr0ov6th4PlbKmxZmlQf00CI/T?=
 =?us-ascii?Q?MkUuNj9FdQctwste3OgxuhJTwRkOLDubcg2fzEsB4RlhACujVt3pObYCHmUs?=
 =?us-ascii?Q?jovXewTHjLUXxTybAazQsqqzAIH+xP8FjnJctd6aq2kt5dXigJIdKM4FxJUt?=
 =?us-ascii?Q?kSvFtUIxATf+LWmmfTOpnrAMoc0jLToa+D1kxxn8e1gKHHA6eErrNniFqEir?=
 =?us-ascii?Q?EouFKt8ZzXLRCjdbIFLTXPG4irzH2RrATszTtgEsCb9APbZh2yUM6vC52xjl?=
 =?us-ascii?Q?kEeHzR3/uyY4Gbr/cWoXgm2hVkG5hOmriGmTIHw+JASxDFtA6LUe8bPNwoPP?=
 =?us-ascii?Q?1S/I05Y1PFgXQNJ4Hi2wcfuc7aUZbliriC4CBFybfzLuV4mHk1BCqE+pa/Ky?=
 =?us-ascii?Q?gE1BbUj71kTxkC0Yvjm7PqtABuYnXzOK0EK8rTGLWS+dhGmNo6xE2mQLW5u7?=
 =?us-ascii?Q?HwFLi71UJ1EvTDMzao2HsOyZwFhSrWm5zOdo6Okxr8QdhuNTVwJqrH92hr5Q?=
 =?us-ascii?Q?83n7Dx4AX+2W2Yd/Fs70JJAJPzYygvQWWWBG055Ikcotf0aqZ2QCUii3N3Cq?=
 =?us-ascii?Q?nc5gqanOn2dvjGUshKHHe+2xeiy9bbeqwjIa4jH5WDqwxswTLWdFeL8s2sJr?=
 =?us-ascii?Q?GHYo2sblbkV9BTomKOK371W3qXdvzCyMvUaui0GFq+VpiWtkNLS/Z5tzuCIu?=
 =?us-ascii?Q?pKkP069YN3BlYWzPRy7kfOt6lZPOtSKrTellfDQotvVsy7w/JvUujgwPc0hl?=
 =?us-ascii?Q?fxxEziyVWowiyLaiiErcKIEH9jfkitY4YFVP7QikHZs492bBcxcG4qbfWSQA?=
 =?us-ascii?Q?CBK3gKbgERr76LCzWuHQ9dZRic2zledlp/9gQMs8KFN9AzuD1psqRW6Sd/co?=
 =?us-ascii?Q?qmFz+doyCpralJv1GwE4bB8juKRGJ6iukre+DUb1CCiAgESD1rziw9UvFpZL?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ALs1OTFq90CGTrDduihDkbmHPZNrbwbQRCUEFk7ge63Ae9WZVJKVqGJ4kRmcJogYXn87Qa29AX+abK6TMKKrZENPoxPeXdCs1fLQNG7uhVuTQj3Z7GTtgAmCMC1+oJMK6liO6rFviwHJ1fpkSqFy2CVv92ZYstxkJxHy0brW8faBUaCDfV6UXcBYzIaFh7NFj1/q0emznYvuxeV3nQmg5z/NttRAbA6Y1Jrz4Gja+2T38WO48P+3eJXZw+Ix1Cz1N54pN4STbz3oJTxv/aBzpTbqirAmMRroRt1Au1/IsQMHh51fbyqoKr0+6WpHDdMAyr7Qi9Nm7Txj6DetqDL6D/2fAFy3KqtB4oPxUZ/1fkRKlkpdj+BptYbhKUZ6WhldrUZ+8KP6vXZ75nJ2Zm0k5DxyS+WruEQOtjDh7VPYkM4/JjCuo01GIA6wVZkRJgN4QhsPAr9rjQIxd5w/p6fwowLZs4ZMpf4/BnqE8WKVFng6bWPf6giP5ggJaLRsoU83WXfiY5ArtGoBqQ2zB7+p55wkoXKlvk7JyFB3FhMgsMZ1GucUgGiUg+I6QxyWhb5PwlZzSvGbWFXn2JOEPRZbJEbqs3SUmZSjjy8bj6/vkaUsc6feMgfQjGInwsHOHa/2PgDtIrs0Np8vo9lE8dI6bMmforgQp3STTQqdX+VoNSHfYgbgwhel9enADtOwmvd2vpD6jOKWj5X6uYZsAGXkrln1CSehxPI+2eKx2Wyi+ENZK13/QqDM4lidZRdAsrhIcl+L0pAvHDXMtSfcU9NtlZmQ7m8eV2LsfU4ZbwpihmAKV5dMFRvb1GgX7gXDe1lX41S7o01bGxxqjyUGGZhH1w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a358f9-6f14-45d4-7b0f-08dbf608efce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 03:10:44.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqouzR4HBShzpFLuvLu/NfkHNQadpD9sxKjhSfHG4CoxTt4cYUF8jNVaftcM9aFropJxi2QjCQHZyLg+Es4Zv3sG7dkQG8aIqzR9YMY8CDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=806
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060025
X-Proofpoint-ORIG-GUID: YwFmnurXbIeka78j7R9-F1_tVIORmUcS
X-Proofpoint-GUID: YwFmnurXbIeka78j7R9-F1_tVIORmUcS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> This cover letter describes the feature: add support for multiqueue
> (MQ) to fnic driver.

This series doesn't apply to 6.8/scsi-queue.

Also, for change entries for individual patches, please make sure you
put them after a "---" separator so they don't end up in the commit
history.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
