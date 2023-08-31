Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B078E41F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbjHaBIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHaBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:08:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF821A2;
        Wed, 30 Aug 2023 18:08:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0Dg8S014658;
        Thu, 31 Aug 2023 01:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Ad9c3JlkOL6L2bIgIBl+iyZKMgqiQJqACFRsUIPpw2c=;
 b=zHeYYVyZbp6DrxWWsn+f+ziOSbb0x0veFrVpGUzuC/5LteWi8nu6c6cvwC7nwppInC17
 RfmA3F5zzBzw0gpQkRKM3LKZCHqBpfnopXCm/R/nxpkViWiU4vkgc92MoCsxaR7R7H+R
 59nuIolzP2mhNdDTErzX2qgB2Wy4PrmziYU4faT7LXfpS7aRRhPpAUm8hkJtmqsf7Cce
 5nMykT47x0W/UX8C4+T4MkewCQjxC+G+hlsXa4+yCqiDh2pbtLWIZxKzQejPMPHcLLT9
 sZpzpcfwiVFV+YLPThxxIqeOu4HuyqTgIvhfI2pGwxArGRM9jehlI9pXJnDgOEBFJIqN /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9ge0mm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:08:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0PhXh009286;
        Thu, 31 Aug 2023 01:08:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepypcd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiDKpJq/w6Akz9028mXFO8vcaN3Cfgm3j94NJVEWYDUKC9fjjPUkcUmtaU9QloQ0CwSaTkGzHOitJX/iDklN8szPsgI6vvenzYfccFMlJR4QIiopR9a9ZlQP/hAfcstrKp87R9D+zLTu9ZJSy0D946BR4XJr6mNmcz0OVXDgWfuwSXfTGkfcgFRDyWFblV/CZQlWZNDr2+MpvFypTqWt4gC8XJSyXi5RZRYWoMScJxMS4ahZGkTZk+MEbVbixHcNFTAay2ZoxbWRflQPL2Mv4RGL4Im2QhR8RMVe0qW9AYo0nGV22MnJhy3KB4h40SSnI/TiBE74ab/HNKg0qxnaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad9c3JlkOL6L2bIgIBl+iyZKMgqiQJqACFRsUIPpw2c=;
 b=QmHjyyuSXJJVdp5/HE3zvmzXutYXEbtOU2U3SuDOMQaZ7maCEeC2RqE+pH2depOTjLLVI8DOVR0VCAzyj8D3Yy7xCgywmB54P6vlIaZ2BJI4D+zTGCEthUibz7RY4/Wm5b5lM0BAy78ny2EsjRyd7klFFvIGWgO/whRH0//NYIZDwoYEXGP4zMPhjtAWqN+SXSRbPb0ylL6HMOPbJqQf0TPkm1irKklu9YaXHE4JeW0yuvzNauWoISmATUE7ciCAOsb3jLLm6becsFaJKVHhdoUjcan16u/6f34ISJgZD8H8BBQzAhl8ODh7YfBWohKgtpVg2RgpQzrwI3Mve2KVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad9c3JlkOL6L2bIgIBl+iyZKMgqiQJqACFRsUIPpw2c=;
 b=gZHB8IQH7xLYwNKKW8uBrSAQkQNedeqZtu8+sBoVSjtwXTHtNT+7rnL36OA16SndQLjsdEGK1EC36sUaeQl4rKWZqBzypCCyYDuVyldxKDIdsJnWvedBq8aAVC1VYvj7wMDjSqG5uoePHhADInW2jXtYTXpop+cJ0SXLGnseWxk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Thu, 31 Aug
 2023 01:08:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:08:27 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: qla2xxx: Fix spelling mistake "tranport" ->
 "transport"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf80uigr.fsf@ca-mkp.ca.oracle.com>
References: <20230828213101.758609-1-colin.i.king@gmail.com>
Date:   Wed, 30 Aug 2023 21:08:25 -0400
In-Reply-To: <20230828213101.758609-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Mon, 28 Aug 2023 22:31:01 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7c3b3c-bde6-4517-a6c7-08dba9bec84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcmAfuGE+PAc1ENcIXfNK7iH8bnLMjo6y835WURBRHUEepIoWY+KiqdzBHlESmG1ecJjqTlzVBMHYJfqiIMwUd80xZU99aLt5lfXxXprMq7/Eo+G/Tm0d6oNAcOHvHI/CuR1RsrYP2zNVRpNZ13W93nuzLKG71YZ8exW0n/LvD7DKddERs0mFnYA8FOcnGKdGVRMAICOcI85n2+JEBlJ8/Vwi8/O7xRBOIPXTWg0WxwSX9pvG90P98aD1EM2MrO+xSAvff7qPcMTn3bDkpfVGF9BiuWabd/9CuouGIbs+phyBrkG51U3RLShLKeGpF+ZXBK/EYCd1zssxrNdcYy0C4UdoFBZAadyawYP70dBFwq+lc5bDqRLpHas12kSLu2R3OSShqSUw8+A4hh8p1/Vi0udSICWiHNkfTo6k8dq40qoGVZsQmSslzNw0XeZTTPEs5Z4/0OpVpwt00rFrWLIev/J3kOqYZLtxp4FemaVHOkaP9ZhtMjuIdsiESIhprdrWwkOJspkLL0KtqDtrZXdNDKXQPfkL2SGWZgeHA3sRqv+yTh62wQvVVY4jMFxwhko
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(38100700002)(41300700001)(316002)(4326008)(2906002)(86362001)(8676002)(558084003)(5660300002)(83380400001)(26005)(6916009)(8936002)(66476007)(6486002)(6506007)(66946007)(66556008)(36916002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCWprtw/7nJDf9ExYPTBH4fXmOCb0W33dKH7Lj3cwEoEYaqs8ZNDWeLCCp5w?=
 =?us-ascii?Q?5Yw0y9EWbicJGaEPrA6uJ+jUQY1mdWEdZNNycUuvHsMGTgeO8JJqGDxqOonI?=
 =?us-ascii?Q?PJwl5SOWS36rvGDB/O+qMkL1aLHEqpkmgXVksSAKdHLnMLuaNO5qpgQzW847?=
 =?us-ascii?Q?9T726TT0m7878hSFrH5WPT1qnL3BoaFMrCUsy83waxZ7WySJyPz4VmcxgpiL?=
 =?us-ascii?Q?lq8VhR1w8fo0nNyJN7jG1LHMETpKFHFC026NSU62RGYdGw+yrrCtSXwNYI1q?=
 =?us-ascii?Q?Z/3rjbc5NgfUvq+yb9VyD0zsfEgOiogP2PuLOlobBIfvfP/Hxvt/A7WqntNx?=
 =?us-ascii?Q?TH2Seo2NgwrAAXSLankOZhn//SAGQgBXhU1LIMSEEtCl1v1F71cIw+kp1KID?=
 =?us-ascii?Q?uTj3HsvgKXVdqzr1ZzMAjiWMOonu/cH7R2Hjar3jwn71VqotgILJ+tDz4EE2?=
 =?us-ascii?Q?R5T3R29Eqnf7O/UTjsJte9HbkYCbdlLzxo2ekkYZFPsBC84XVjs908h9xPCl?=
 =?us-ascii?Q?nf5Odecp4voPA7jFG7O+6KvO5fdHo1At0v+VYzGoC4KYQv9DEBTLnf2Uuffu?=
 =?us-ascii?Q?hBg+6SUNcRMS81FFapqp7mynQwJC0u3LKY1W3OSwBf8FOtbiyo4QSG1yucMX?=
 =?us-ascii?Q?3QlV9h565Oes5K3cEQWZEv/AT6N2k9FIu7I0UiyYjPv9/V6cQHFEN+OpGetS?=
 =?us-ascii?Q?WasK+KFc/0VQELy3Sunm3c0hAKTHvQewka372wumGTXOOirxx7iGCy+CWibz?=
 =?us-ascii?Q?4P4VOmwCx2VtJVvNldNWhVJQpEtE32w0BqFxEGkp5b7p5MRhvYb/nBsR8rLf?=
 =?us-ascii?Q?e7G+7QkU8DyKHlMmLt83xEe9QFUrvrV9siZNpaTaMFxwXMfiXj04sSZ1g+rG?=
 =?us-ascii?Q?6apAFVCej4CdRu+ZYmGlSzbfCZA2hWS41dpQYT2L+eTC7+p3jrWaFyRJgWPj?=
 =?us-ascii?Q?4WPULKn66YrQeFaYze0yTxk9YfVr5XZPyUXpHvaRJLiObg1TGsOLhCrzw5ew?=
 =?us-ascii?Q?CYKPHW2oTFoR4ZBG9s5Vyp5jj38BzmE9YqAUi5soWdozhEhM9JxkOte1qiIw?=
 =?us-ascii?Q?zYjfOW5ZmXszOi/UcRxISq0Ryoxx6BL/z/db+K6Un8Qdmft0K1UNy9NkULWY?=
 =?us-ascii?Q?hLV2eZby2qdyMaN4KHQ118iQNvC8K9uWLWhRrVA7kensoYofPEukQ6xfZ5wX?=
 =?us-ascii?Q?Tz3ArbJRmgg9KgDfeXBBCgWmcjK4fD+TUMpu9bNQB70DEFtimEG/BjF+HE/9?=
 =?us-ascii?Q?SK/7qVVi1YkQBVSbfRn5POgN1A6/rWBfi+q1KbJ1D2AZBw75SsSOMtn/R3Yj?=
 =?us-ascii?Q?5sETHwmwUhU/YmmCRvVWkISrBHjzQYfNCFBymL8p6R/66QQ9+vsCffVIL854?=
 =?us-ascii?Q?rTFZqfWD3TfyNIHfpLac3GWru4QYuX0PR2thoVB99bipgKg78HvVgQu1D32X?=
 =?us-ascii?Q?kC2voFBcCCg+v+rxH8mJKrFurogt3GbXFMU4tfHLRaxMI65wSzT5Th7cX0yI?=
 =?us-ascii?Q?ja3nlBIqlfN1OW0QY97Oqe3n+0C9F0YuaR6UjeklYlHDLKQ+ZW3rO2EltVkw?=
 =?us-ascii?Q?5r1LBDF8GmmnaKswSsxvFU3KJDVrstGmpajU1lj52PNavV4Jq++2Ho//ca41?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XARoGVWNjRNgveHQynVBNia4RBjv3eHofKjgQpOpQgbi3EO6l1BcvAX1uaBX+bEMRFgAab5ChhL/tAV+7WXt3KfKEI92BHILcsTdb6WHsONHLpUBmlxsQHbLpZGMVb7SNEeb1X6Dr0t2EmgFVYzKflQ7L3xRa1td3lepuLYfXgynLhsvd5EKVYIm1RMUzJRbgljudORZs4Xn0m7QbsOQOaubU3roJS2HcuJko8v2f+f/YoAcTlaez0/0DlS4+EH5iz57qnOBi+OmoJ5AY6uSqzSK+KYtl/9jp+axOeXNpgwOgXuW/x2qRqZcInhmcoE2MTJKJGkHWYXEJuA2dPdFaqPLD2bWXyPdza5CGG3XBcgjfpx0qbx8PK6Y50QHDyNFk3PF6hVLKjf2BEw7sWgwSf0sOsjAdKHROFIxlLZjLvttjnlH6okauiRZEVavGNEFxLs+J+dZXPEjNZvi32RAXtYL/SRwGwEGo8FT/E94eNTYisv9s6VVoLjHvp94W7sHm5c3VjhGwc8xk14qM4GQxtZ4YVkIt9c9MLiYWSKp4MkGmmcKXOkihJNOiKoDA9lMzcBLZN2yktprXW9Aow0GMEsnfK5Ks+nMTDWkgY9WPFLXbmQYwKVbThbSXlLufKlZikWD6Xkb3GD3Ptf2Jj6zb+P/A3hVt6VKgOTK4WZJcfcNzihv4XLZoy2RJyEa8Aj4hvlsGqFMEXswW10iHCh0MGgVCsnOnzn1YLowomjciwxCCi7bK8MnKU7e47a+StjQaSv+UOY2LDcyVPU+tM/4+TgJ08Q39QGW+v21f+gvRqZjzufwZ3F8Gq7IGKrHszbyxlhiQOacGXuyMbW1TyqBgSoUpt2FzHUh4lIkKF/C0DI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7c3b3c-bde6-4517-a6c7-08dba9bec84f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:08:27.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKkjYFNkpmCRa9sYzgiRt1IaJUFJ9jt2okA9dxP/I1TfO78CLpsh68Cv5H+ywtOuKDVRdu3ZJpg1Pdewc6z5zO2OEr1DfhTDc2uhz2Iowz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_20,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310008
X-Proofpoint-ORIG-GUID: oTgAf5jJT6Q-IqH--yyWyXZtFOO6PzbE
X-Proofpoint-GUID: oTgAf5jJT6Q-IqH--yyWyXZtFOO6PzbE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a spelling mistake in a ql_dbg message. Fix it.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
