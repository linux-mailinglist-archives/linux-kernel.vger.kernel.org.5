Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00475FF24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGXSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGXSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DDD1BDF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFNp6m027010;
        Mon, 24 Jul 2023 18:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gASc2k9myOR5GwusdG5JW/5KRuhuyxQLmMm89M04DtA=;
 b=Pf3EkMHyaXhkw3q7zWZfHPVT7iMo8bubnJJ0w1gjaW33I5Mdd0V/unukQcYYnerOucQK
 f/0jLwvfGLwAUnfx88In/Ej8Eg2Ki+H+7zqbb4bRBWN7UcF/cOoNU5xIQQGS1fkH5v+U
 dE3nJ0SPkA96qJr8X/0SUCpOWnVpIcC+PSDQlp4HWFLnIyydzjW+jtTJMG+QM8huwPlf
 bN31EVN+OMsaH/LQAoXbZ7zWEdYWLm6utAqNUvTd6R1BjH9UQpoxyzZQCTTsN6NfdwCE
 DJe+bgjboLfGdeZyb8QKLc8aqPT/7SLXsmDvN4mUgsYGt3GtEQ9KIWro7G81NBSCYgYw rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d3fac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH2CpY003886;
        Mon, 24 Jul 2023 18:32:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3ssh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS40XSecKEqCu4AXjdfICBOoaKarbPqKnbpWfEjMty2160ZJsOG7N6ruWCBqRZVjeou8HX6RVpmGpaJazTKENPMBfPulhqWIZi9xZRHO5mY6XPWLpDCL3Q9OmbDx0j5BwvMUxN6QUjxPU/cUazJC0kXZBkvyFXjF4T1VOFBhburjxWHW8NRhmzq/IK9yymakXFtgUAQ8m/Qpp5ATKb0bFiTZ3yYvKKF+j6S+xScCnH73Wmzsl1mfeVKNxsOAY4O+TR973/GZuJNZjwUEBx4oOgKHoy0fIkai8fDZFwSc9Xb1ZZ2te3pU37/oWF0G3xqAEvW31n0rmuDW/2GrkAqg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gASc2k9myOR5GwusdG5JW/5KRuhuyxQLmMm89M04DtA=;
 b=mjZVz9Db3j1RU/QV+g9WI6gn6pv2i7ALC9sTbNOnDsLSViSOSZLcc97P6kn02eTvtx1rWyC4IEa9snbIHHlDVVawatwdjaWgRPeDGCdT6b96griy+k9j+swOBXWaM1ftg+UyENYXXVZLliCTOqxi0jgbd7RnjWg3B/RKm9aeYlOcGE3GiIQIzQdsQv+zDXfdzVoN8vMPeqMIwjctdN9HOGSnuOXBBOecNe6Xh3u+UqSxf16uDRIuN1Q2oSEmxldgDd3c+Rvo19CDoNeQEnYybA7bHhVMxfe+LexWQZFlOqXvn/fLXTiWCGWxVmTBCIemkJWxVsUKFmBM9WOjMOgDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gASc2k9myOR5GwusdG5JW/5KRuhuyxQLmMm89M04DtA=;
 b=t0QS1gzyHhpBbVWQwDOWM6ns9T94Svoc2hctJsjFEBCOrIxf5jAZaxhFYzWT8+pi0Okm8TM6tqwtZ2YlrfDdUskq3f3HISvPFK11K60oYnZhKy0g4FMA+BFDqLkr/YPa9tRIpmc98FbTldjpB3PUn8GmNzbtFspl/0G0II0j9CY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 12/15] maple_tree: Update mas_preallocate() testing
Date:   Mon, 24 Jul 2023 14:31:54 -0400
Message-Id: <20230724183157.3939892-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e89d217-44ce-4cc4-c0d3-08db8c746044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/wrSbkN3Id4QwPYjg+PljRHIYw2+m58qziUTIY+aJCZiz6xVDtwbgcExCP/v10qKFpkubFiEI6buL1B54/mys63WSqjlLa4LhKC4c1/gRDMdHbQrAGI+9Pya1cTRk1nSYj9haarwQIY8YRTUm5PL4zzLYZOnmrOHixGUCPeGwQYeSenCEpWJKwJNjbKN3OGKuBKabZaRVk7gs6zpwsjCP1yRybRFyNSbkE8526lDNmT6/evfF9YWwP+YY7xsUJZb+c2HSAyFGfrO+KbD3xvBtSfZXuZeuCX5ZUEmamoQOYubGU8s7S7gl5+tKs2Za+VCjx5riPzsqRAP4uEBVxTStS0pzND2y0aYEKcHPmOsCzveyHevPNSiPQ64oOna/eZ5y/U76n0k6LlTsQDu+HoIHheUukZlB1+Fuswz2w6q9rtHrg4NYjcCHrxSDIqC5V5unQe5DxOcUbH/Y/ZY6VOKMCCenWur6C7UxwFVNNBvOiz4mt+yg0UKwvi/3MTx3WFzZuDobKRWEJUj39uqiUNv5/KN4p6f3MlaX8amvIFlg06zF//gc2d5b2Wzfr1OD42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(15650500001)(6486002)(66476007)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CKbdWgHMhVjs//HgDj1qvkyhazeJ80wMnE4U8YCuZjWfMB0VnFnxWc22XQV?=
 =?us-ascii?Q?3hLKhAX3xlDSbuLyZw2hwk7zb+mSBbhp/4W/i2Z1eeC4nudLtmzZXzHPSoHn?=
 =?us-ascii?Q?9c1KSpbWb0VnT5JDpXvQFckDJWeRyi74U6tdHgArWZRftewE4qZZXCstkufS?=
 =?us-ascii?Q?j1j2y9BIwcHSg6oMoyGeGOGymj3tKpJWBP6sldg1Rs0Kr8WMB2ZNvZJ4ZLOA?=
 =?us-ascii?Q?YbdsSsHkgl4yqLNzGD3e7uIj7IkNL9o33JONOK+c20bVGoxdHnYmUjgiGfm5?=
 =?us-ascii?Q?1Vd8uay4rbQtflfkDhgCatukpJLfolKEISD8TK3iNFPOAMSk3ZZn+0oc+bvY?=
 =?us-ascii?Q?BgSIMS5ZRW2aBKABGhXAYWsdunjnJcbXKthB94ViAZRBSw925bENu5qKHWYl?=
 =?us-ascii?Q?3eKIc0a/iBEiVnVZdGKvAHQA5ng740VbwvlFMWa//FuXiU2at9/gzfxu3BAp?=
 =?us-ascii?Q?gANAEkES7wrxe2svpEKtui4RAM8Lyx7yKf0ac5TBODbAxVY0FKp8pbiyJpcY?=
 =?us-ascii?Q?iBu5Rsc9NOVamaYCcpD1MDT8MyjQSTNwTkvgBRtcfXlIJlBdGwMLElJ69Ka1?=
 =?us-ascii?Q?hNOwJwTqU9yJEE6O1d0vFKtu3XeqTQOFmkOZBznipvSK08DqvnujU+35dDYv?=
 =?us-ascii?Q?NoaqU9HEEqsfXbfa7//8Chf+pGXWZ7NKMvd4tQ8eER2d8wBayCGJJ6mTw4de?=
 =?us-ascii?Q?LDhb+yWN2ZhJkAB9ySocfH90hW137y/h+qac+aJTvp2Q7jQI6d3Da3TpBaSu?=
 =?us-ascii?Q?0X86aGCjPBUS6tNSybBXuCSkMjRVDVCWP/ytwd3ze31Lm7CRRZusGPUNHUNk?=
 =?us-ascii?Q?AOH4mClbYBuHkMyXrTkSiuc+eYP5v19h0spEZESgT00z1uPwH6/YV1MR4gfX?=
 =?us-ascii?Q?H8/1hWTWlAdmjoeodRaehn7hIST0q8sfHDHwmNL/5pjHC8NpDEQm5oHpQLYJ?=
 =?us-ascii?Q?SS4jw6Eaiq/h+X1bpZ2A/Zfm9KmRtxYYxczS4DHoM8ExJrePd6HH79UnY0J1?=
 =?us-ascii?Q?Rw1c89A/R3LddrLbs1U0AbHlLdBAu2gEajttxzfMADqrq/8SNaCcY9qff1SU?=
 =?us-ascii?Q?Ta7Fw5MlPdDQVfdRn2sw0WXSbwgeMy9tVjGUR0fxtg9q9CeqmjCACH9Qiqox?=
 =?us-ascii?Q?ZSZhCCLp+AjYGIV2OmcIeRY1b93ncNjLe00xf+XM2ay2m4gpl8P6pgEpB58W?=
 =?us-ascii?Q?Jk55CI3okxTgxRo+UWetGjZvWyymLN5UHwyosERL1SqraqG8QPclUgWDAoup?=
 =?us-ascii?Q?vLoBDrvit/g5wWEs5rHSaNYKr6Oz56pyMbUQu++N1YG6xyShs5GfDEXQ5k3x?=
 =?us-ascii?Q?syiKDo19sdbmtLdDGagUwOf4lMa90QLOLMTbH34GD4l/Zu8scY1nT+U7KB2/?=
 =?us-ascii?Q?A+Jz6QdT906XY+DVfZaMORaSyjwux3BeREnxowCKMUvcKLoVq5ub3E31XaOt?=
 =?us-ascii?Q?rhJL3jC5F89rbYxZKxbVfQE9dFNJ102QuPimGqcecf5c2dMRNTEeeDv0dKt8?=
 =?us-ascii?Q?K0y/Gq5vVqHBjEb5U74NRg3yC5AzCoZ2XSR/7VuF5rn+GschVudwWo0erUAz?=
 =?us-ascii?Q?JMmmJhi/XX/1KouigUQH/af4I6mnO6a0JP4/TJhRGKM8szTQsUwE+/1stIFB?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uk71LjPvycxlkowjeF02z0VIk24oTBfaj987FHASpT6yfYvt/eQtyRvTlBQjrs08zIWDC8LaOzHZzV8i7Do2uElz87XOlupH+gdsJGwb3uueZtaMqJrQQrdXR3q8y0uGGP7JQW79tcnZJk2T881kKOkuKoZgU2TIo7/okSNFWdVIkZ5tYcoxz0ppph9Kcnmq5tz7txGBYMi09/MJt2rPMDTELY6NeVYjMCVhTrmA1QAPSbUTJYJ05ZVQEFluBirLt4tiS8Gqv2gb6576nkZu06YHMEOgcb8/0yMsvXvkdKtWGdkfjAnUfNEWVaRvj3eO9LGTKJkri6Jw1AvoRi4sX3nC37xRMsj65bHd/zzuHMeSeuDINSG0BXRThFlYCSOLVfMXWuu1asd3es59Ed1n+HG/qyVIcdg6EqGvAaTL0sfEEgoTko4JqR21vVwosmidpMxK/ispGeY1hi02gEC4Cucj/7eCNjI9lN5Xr4BSc7H08HBKVLfQFUPZB75NKaPg/ga07Ks1BU/UchYUwVeZDngNjGvkTkKuCYs2Lpt1Ybjbo3o5osRgVUlhYApapuzgkNA2wcJ02Y+uzftsKddcPD3NwxSpn9fqFzPYCfuX6op6zSQqZ6CsnEIGX3EWEt5jAKaxZQAT7ewmU3xcpM8YIO6TSvBhBtA9v5PjX50LcyMErV285YocZtziuc8yloWCYjPs/jwdqCRASFGVEwPKPl3ebimYs6FND2d0aO3+JegeJNxokRYqDc3DyHJ+A1zxibeaFMnCuN+JZEyaV1PT74mhYGhtfGbIm9tplvG9I3ykXbt9BP+cgl1F8bE32I0kMLfoBZOlp32FGoGocCDxNaF+eig4ZBNCIHC8h44DPUh1916qNhmWEUvdgCjoKCKJn5S4EJRkdJFtZErXm59o0oXiBN9EhslJYal5oUC6t7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e89d217-44ce-4cc4-c0d3-08db8c746044
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:46.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcXMeKWhgN4NyoqQwVuN25bfmRv7rnoJZ+totijFRqC28HRN2qesysrjbk5AuZyOdvpbqXkHAxtfwqmQcODPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: uec6J5yuS6NTB_FBsKlP8pHa1b0G236h
X-Proofpoint-GUID: uec6J5yuS6NTB_FBsKlP8pHa1b0G236h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the mas_preallocate() calculation has been updated to be more
precise, the testing must also be updated to check for what is expected.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index c6c1c5109deb..e5da1cad70ba 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35458,6 +35458,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
+	/* Spanning store */
+	mas_set_range(&mas, 470, 500);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35481,7 +35483,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35495,7 +35496,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35509,7 +35509,6 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
@@ -35523,33 +35522,37 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Slot store does not need allocations */
+	mas_set_range(&mas, 6, 9);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
-	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+
+	mas_set_range(&mas, 6, 10);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1);
 	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
+	/* Split */
+	mas_set_range(&mas, 54, 54);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated == 0);
-	MT_BUG_ON(mt, allocated != 1 + height * 3);
+	MT_BUG_ON(mt, allocated != 1 + height * 2);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
+	/* Spanning store */
+	mas_set_range(&mas, 1, 100);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35557,6 +35560,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_destroy(&mas);
 
 
+	/* Spanning store */
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
@@ -35564,6 +35568,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
+	mas_set_range(&mas, 0, 200);
 	mt_set_non_kernel(1);
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
-- 
2.39.2

