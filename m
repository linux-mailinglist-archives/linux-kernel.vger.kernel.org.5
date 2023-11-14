Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476417EA82B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjKNBVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKNBVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:21:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A9D5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:21:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADNsdXu016950;
        Tue, 14 Nov 2023 01:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=R4eSCppAuuZtKFLIW6OmmpRDutCvliapm1Q0waF9sDQ=;
 b=MNHUoQQ1dWsEqUznH3kzAgMsDWGlgU9XhclEsqsfohOzPeU3Heku4Wrmi72212I+Yvfb
 wHul2ieX0gx0KYApPgOC1Rt1RUmQuNHV1XUtp/W8cyG+TS1kXGEK8CsL6Mp55ScHNSZE
 2M6bDMDSNVNAiQc4RD8OGXp61DivswwQvYwOBvY0anWzJ6Mlg5c7Kvf0JbDAA0ZunMYu
 OGms7RRpJ2llLNdfAD4uJ/UjWnwrWQJzJA0kgltKwg4161jqJ85MHzrBtbRo17mP8fJS
 Vw85R0T1ykzIzzBU9SMabeOdxnkyBi+Lu5xcM2IHyS0H4xS50GMGGySqUphcCTV10bh6 Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2c41d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 01:20:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE0mIKC029673;
        Tue, 14 Nov 2023 01:20:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqqrwdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 01:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIAbuteWhJLtxePSkYiItNx8YYXY7O2ZiQT4owGMBG5OAUShW2i6nn7wWhq8vJqLu1sAlNVAE8xDgzGfWaaDm88rUk1NBiXJ3a9StWa2TEGKIjQgJ8BbGK/3ScXYA/DKK0LlDDmRUS1umf44lMTk8TIBsX+vTy2xPxIfmeP1HMfxdZIz4M3klPFgPjvmPdaWpGt2DxqiJRPfgExcf01LUU7kgHSM6+zpfPZDPEJp0fo8ci7HNqXy5KFtveZBRzcFYm5fANHIkyX7IaU+BdbSnS31OG492MBU/dOpGuuOEgxK4AzJ9qqGOMAmZ2F299TnwFFHKGC9j/EVTabWbVKTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4eSCppAuuZtKFLIW6OmmpRDutCvliapm1Q0waF9sDQ=;
 b=NsSyECR84a2uF1gTl6UUnv6CwPTf3TJsdW4Q75DucaF5qIlpE6VrlfV7soPO/WzAasVm2NXpsPMWQJ57ngCk4lCDsbN/fXRXjKOGFr+dtT9P9iwyM/ABOJLv4vdEyszjeUe40q4l4VxBPo9c+zjC22h8ZxUGc7Xvbqxn+WlNVJSlYH16N8J2JBicpG2B3Qb0TExsVXKlyv0AJ5NUJoKxRSQ20+cA2/HlQCxHVKurHkw+HIIu9HjIwnBB4oPShfYXaucQ7DthDcFC1dYa0La7xcyZEN5Arj7cCALj1nrsjhbWzaA2D3XSBf0jejtk9SzfWCz71vGNzehIIS7SM/7bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4eSCppAuuZtKFLIW6OmmpRDutCvliapm1Q0waF9sDQ=;
 b=oVvyNB22iZuW8VplOyRuEhO0Xd5F11K2F8WdkqO1RyOFd/sjGz10nV//wpNS7D7D51oPqDURZJog0hxOtkKjN6WtsqLvcVP31G+flRXh764s3mFmivIj0EKYjJvzLNMFZacy1JKDVEaN1f7nysCHEktGJ1mAP5dfcMzmMDOMIi8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4776.namprd10.prod.outlook.com (2603:10b6:510:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 01:20:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 01:20:42 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     riel@surriel.com, eadavis@qq.com, nh26223@qq.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write
Date:   Mon, 13 Nov 2023 17:20:33 -0800
Message-ID: <20231114012033.259600-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: d03e6802-03b9-4a59-662d-08dbe4afeb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Q1u8luZilIu53aE5E1xzTo6Ch8w6nXBzyNvo5aJ/u4gIwXhq9hgyu6xbyY95EObedM71/AoKP/H/CSsn9W3wjJkqHuhcIP2jvYZPfe0Y3nJdlcZJTHvKSgbmiTQoqcAmhAUw6HLTO/4gS38ORrm40fhKgQ2vmPznerPwoIep4zQB23FUnvVT3WH0F3aLlkbWQVhbSPiZdaoE3jPKHlZ6sSIHIyW6VMVeR4+gZHwxD+JEecVS9ruHVYJJPSOfNYN7LRZtjedmATvy32zLmW2QSUcZOu7bHTAAdl4QhpifDI6YAvVtJLffIQwCvNCUUbOQ5lr4FaMwTNg3ceGq3/p1bNbkoD10J3FeGVMwkODIubdR7uV1tV4byHXs/87yMRbhPrV+utBVQQwCngWhgYTToqvuPbb5Io+hFBKF8DRtDItsubn1C2dUmmBij1rQOOChhTfYkz+91hlaPZjQXwfizBw5KnE9t4k0Owwh78eev3u3WXBptVhXgpZg7xKJ5SaaO5CTA054JpW3K5sbMCVeuvareBBHX7O4QReBaRPHJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(66476007)(66946007)(66556008)(38100700002)(26005)(86362001)(36756003)(6512007)(83380400001)(107886003)(1076003)(6666004)(2616005)(6506007)(2906002)(478600001)(6486002)(966005)(5660300002)(44832011)(4326008)(41300700001)(8936002)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSAWuz4eigvkkJpM2Sz0jiWOLXjVxmCbW8AZvVsBiZ9oWlb+X7dkFRFwsmfk?=
 =?us-ascii?Q?L6DqGBj8bbVM2yy61rWxQ/S8KI9NVNSX3LnKCMTGANYjydz04YJnBNnK42FA?=
 =?us-ascii?Q?3d9h8b5A7TyVfpzUI+NZouirW7Su95w4LQerIhy+A2OlY4kBkRZx83WUEl3l?=
 =?us-ascii?Q?if88X9/mBrYmdsTAs8dDOkVnvBbN1+AQCsRXi/hDseDB8uJdy71tiVKfkghj?=
 =?us-ascii?Q?neMaLIX8eaXxIgSA0YiApH2z/vxru0dNkn7c+9DPIA+yyCxG5pU1jUXKMVPM?=
 =?us-ascii?Q?TDZOBzGojjr8Ro5GCdiIEGMGeqPR+uWbENRAVATwT+uu5kPbmv2wRIzHfeRt?=
 =?us-ascii?Q?d2o7z+rxzIvWBwQsWwXf6o1Xv1x4i6J+H53BmTlvZdm9+GPcu5P9JElm7TJt?=
 =?us-ascii?Q?sADnjY7pkjfeu/2wRE7MInTXj6p9bemURb+i5LlSrcqNrTvkCXdzK3FWy10N?=
 =?us-ascii?Q?O8SxAOZiz0mpbSl1DcD3JfrdfVWFrraKy9rg+incK3FIMqMrSPtPjLdtx045?=
 =?us-ascii?Q?jnZixu3b07mP7+1haAGofEwx16Bn7SlAP7iggMLyj62bUzZu2uINE0nrBlRz?=
 =?us-ascii?Q?3bFMQrGjyvxKB2OzsQMZe/cp+VbshgdSfGG2XvvrG7BOqOtPxlhg91dRXA42?=
 =?us-ascii?Q?gNq70+505IliYE+AxQ06rt8Eco5bCys1pKrUD0Y6V153yc0AOEunVqCvWCof?=
 =?us-ascii?Q?MnJykYuz554PLWd02piEiGYTOjniTE+JLnNJkc3gPNe6E/iMQDcza3HfCI0o?=
 =?us-ascii?Q?uNDEstf5IJILKpJBJK9defN1xI8+NYykiCsmEwEQtPTq5ggC7WiyHMHXa8mA?=
 =?us-ascii?Q?S+eXVfpJOtaNKDBgEocAkhf49+tt+FZOQg7WmIS8NDAvmErCaQ73OMtGTu+x?=
 =?us-ascii?Q?BaO+Tpbo1zpWpwnt8Jujrg4zsUiMQvS6QYfNlYJfUDZoKQJ+0S5jwg4p6n9X?=
 =?us-ascii?Q?p6lYvSUw2DPV3i+6GGiKOFQggJTvM0v2qMDr++DaydnUuANN7k/QDapzrDyP?=
 =?us-ascii?Q?AiQZA1dON0cNOTYyMoZMOqHbdYswRsyynv5IfllJs7dmIGQnaXs6wz/rP4Ys?=
 =?us-ascii?Q?CsUSqPte2C1TDqIHMPXJ8ta5DgBeCYeqGhhxqSo7QuI4fNhttKOBKZYHeyLM?=
 =?us-ascii?Q?nyVBmGpUV0H8mgIwbf54uebh0eE0XoHoPzzU1u3xvZcJFa7uYYh1881UYdtj?=
 =?us-ascii?Q?GO3FbQJYLG4HlKEcWML4VQFe7iEATQxAaXG0uCN5G5gJtu+/I+LiO8m/b9uL?=
 =?us-ascii?Q?D/o5g0exz/rRmnnuYq89nn1mTFeFqiDeVgWObj2Vy8E7QaH+uOQfqD7+iDCj?=
 =?us-ascii?Q?7S9RTQfJY1OjTxYg8GyIkoVhAetbsNnS22SmqzKGdkcmNIvhModOLC5dXuGN?=
 =?us-ascii?Q?MRhCq1ncJj72/QgLKtiHCcMMx4rTrtZWQZIMbknQ52GpD+3aF5PNnaf9PUEM?=
 =?us-ascii?Q?YZnhaP+6YO9OvEBb5jRk1jb5bWWCDfD+tbaRscjKy027nZHVeDi9O32hiWg6?=
 =?us-ascii?Q?oK3moxLKi+GYA0KSQgIM+mffpPvDsNeQXLmZHMDDLxuhPaYLDIElLH8XmaKx?=
 =?us-ascii?Q?L0bRcvmhYosC1Aa6Q242LdTFF2eeU14LYqu17j0p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6WJS68feW9v0qQuMMK9c20HGELXDXPHvRRkttcBnp9Y2jVZXDLJ6BEVdKcS+?=
 =?us-ascii?Q?/PsdzluoEgP/46UUTZyyxUrqPGljW0tERdXl5O8QhejDYMvvkhNoAVCr+mrE?=
 =?us-ascii?Q?K9fA0Rz/PyIIzUD9bi4xIQk0plVTDfw9UaRE884P1f9z8/YRA6VvDVNBldCF?=
 =?us-ascii?Q?v/sYU3aMsSlUJOgAmAelzh4scuP4fqsULPSNz7E4lxocB4kEi3tM15xgAV/E?=
 =?us-ascii?Q?xWXEFCnUnqgshXj4s31cls4ZAzIyY4jackX3NdOTjbp1qwyND0seaBof7nO1?=
 =?us-ascii?Q?sYFLghnruOHiEs4Qk+pca3eDYnoOJrpGnX86678Rhj0jtswzxJKofIsM0Aof?=
 =?us-ascii?Q?AlviD3CwLs3jphMdjT00JgESLK9Dk7dVHcszK4HwTDl7yLl7RIp6X0pDHxgX?=
 =?us-ascii?Q?e5ey9e+nfNI5otLu7IETQnZud4OeT6D1Syi77sA7/pD6uoGqAS1iZFJZgdX6?=
 =?us-ascii?Q?PAEoHD62lO7Io6KofJbpOGgGIM9uqYLkb/kDan+eSfE0K4N4GOwYnOj1AUOY?=
 =?us-ascii?Q?FQtI9OXT1Nn6wuoed0ipNsDYhOgIon58RoYabHbU7t7p2GPZiWtQSoEUtgLD?=
 =?us-ascii?Q?aJjBy4xiKchvFNntJUg1mQ+osX5Hh5r2uxQka0UXsecPiQZjAU61kEY7v9wq?=
 =?us-ascii?Q?RKLBbtkzzdPi6A5eLJrkGDT6Hi6fqLfJTDx4ZIEbfFFKdBwgV2sVdSwmAkAW?=
 =?us-ascii?Q?qwyTXrDpjr9rO+i4VFes71Uf7ifhyWm66Dw5I8ijJlCjrDs6LAdUL1cLWg5r?=
 =?us-ascii?Q?yXttpprzSjbH3gP8cvQGDFVKEN8m0FnCxrqO+Sfyr8P8HtkySzJZuBGvpEDq?=
 =?us-ascii?Q?Cq72f5gv1JaOMt1ZLOik5VXTpoSzlIYVR1ERvRVYfQ2iXskdvk2lxmRTfiCm?=
 =?us-ascii?Q?EZizFdKMf6R0IwXtalkyJvKjRxP5MrwUAfI925xyDU07LaelwuErLjRDsXGh?=
 =?us-ascii?Q?V+EgOr3MH0lwJ39GbIFDJoS/ZunEk6/n9nQi9S5ZpuL65gCKh0e4Ftf8i+ZJ?=
 =?us-ascii?Q?CwgO/dZ/C/KCylWrKvLCNGBiW+x4GlcpGuqYwYWVr51nAAH1rX02iz78WFR9?=
 =?us-ascii?Q?QPN9rriANdrLC+z9MLBJaa86PFWBRFsjM62OAZPdVddK0AeKCarjVyXEGEoo?=
 =?us-ascii?Q?EqJTVC5HXNiWeGvAcgw3Gq5DF/s1JCmWgqtUEFIvRXHESg6gPSBsi3w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03e6802-03b9-4a59-662d-08dbe4afeb6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 01:20:42.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vKiyFxqB/XqeMthakkEgtYK3jeRkOD94TQj6wsxjCieFl+h34p2UTYc06sHkoGTXX08wX0ktnNJqQDdV1/Mhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=735 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140008
X-Proofpoint-GUID: y0vEA14fx3HAuBRtSoph0pgsLMK3ys5D
X-Proofpoint-ORIG-GUID: y0vEA14fx3HAuBRtSoph0pgsLMK3ys5D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine __vma_private_lock tests for the existence of a reserve map
associated with a private hugetlb mapping.  A pointer to the reserve map
is in vma->vm_private_data.  __vma_private_lock was checking the pointer
for NULL.  However, it is possible that the low bits of the pointer
could be used as flags.  In such instances, vm_private_data is not NULL
and not a valid pointer.  This results in the null-ptr-deref
reported by syzbot:

general protection fault, probably for non-canonical address 0xdffffc000000001d:
 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 0 PID: 5048 Comm: syz-executor139 Not tainted 6.6.0-rc7-syzkaller-00142-g88
8cf78c29e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 1
0/09/2023
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
...
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_write+0x93/0x200 kernel/locking/rwsem.c:1573
 hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
 hugetlb_vma_lock_write+0xae/0x100 mm/hugetlb.c:291
 __hugetlb_zap_begin+0x1e9/0x2b0 mm/hugetlb.c:5447
 hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
 unmap_vmas+0x2f4/0x470 mm/memory.c:1733
 exit_mmap+0x1ad/0xa60 mm/mmap.c:3230
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2a20 kernel/exit.c:861
 __do_sys_exit kernel/exit.c:991 [inline]
 __se_sys_exit kernel/exit.c:989 [inline]
 __x64_sys_exit+0x42/0x50 kernel/exit.c:989
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Mask off low bit flags before checking for NULL pointer.  In addition,
the reserve map only 'belongs' to the OWNER (parent in parent/child
relationships) so also check for the OWNER flag.

Reported-by: syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/00000000000078d1e00608d7878b@google.com/
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 5 +----
 mm/hugetlb.c            | 7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d3acecc5db4b..236ec7b63c54 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1268,10 +1268,7 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
 
-static inline bool __vma_private_lock(struct vm_area_struct *vma)
-{
-	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
-}
+bool __vma_private_lock(struct vm_area_struct *vma);
 
 /*
  * Safe version of huge_pte_offset() to check the locks.  See comments
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..6feb3e0630d1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1182,6 +1182,13 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
+bool __vma_private_lock(struct vm_area_struct *vma)
+{
+	return !(vma->vm_flags & VM_MAYSHARE) &&
+		get_vma_private_data(vma) & ~HPAGE_RESV_MASK &&
+		is_vma_resv_set(vma, HPAGE_RESV_OWNER);
+}
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-- 
2.41.0

