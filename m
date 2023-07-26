Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583697628A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGZCOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:14:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5912E;
        Tue, 25 Jul 2023 19:13:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIXXU020077;
        Wed, 26 Jul 2023 02:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=EBRGOUiVAVAMfYbG0jXDZFECVVJqqII476paP4DXAow=;
 b=K1+1Y1/AcZggcIwJ5I9vGuBuyFW6GSCi6o5RcZ0sCSI160yg7cikR67iMouP+E2tjq9B
 A+7kaT1bJ4gcVol6HbpNOWN9rpb6Jtv921qwhZrJvEoalKHqn4RS6oPt8/hyRYs4V+Gl
 D2JqDvJamy+hHFFLvm51Ass8/UJIP2mlgva/O7oOyHM18CcteDqeaTZA9Rshcz5Io0X0
 h/j+4inufGU/nLv3/gJDR0w/f4HgchFs/3MMSWoV4UXmeyAlEmAhjyzSXcvbgd2Tt4o6
 hhKL/cMRL8919AfBu9Iar+P8CRbSEItt5hg8miXWTmMUOMX9U4YxpA7Ru699mosFYAVs sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdxdxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 02:13:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0FLYe033436;
        Wed, 26 Jul 2023 02:13:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbum2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 02:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfOi9EqNGxTUuQkGcxkN8wQ8BkHheYvc1ekPmHEIAzZvn3YvAffSL6y4hKlZbSWjb12FkElOmcvQPtH51CaMSS2dKYH3nExTGqPLVP5bcvl3VRMXcKDaRTxjzBB/Tjw4bQNpr1nKR5JTqE+nfP1AlTwubtLtayu+un4z/QvTQEDA7rA+bk2ZIfgKl+j4/26oZWG7B94MUbl7+8eY2bx+I449Qq9XzghUAhysGx4GKbi36qsDdnP/xXQ+0V4rUL81qLKFXgKVChVutA6H/Yq9eOIbJV6HS+7x6Omk/V/81eei5LsCDddDCrc2LN2AsxGI6KVs99l9XsKDq5836pN35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBRGOUiVAVAMfYbG0jXDZFECVVJqqII476paP4DXAow=;
 b=AJrSxaG+ccy4GlkNWnIkFIUEaRVxKE9I7qJLHnJCnJA9asjoUlhTjRgIRsiYMcQfiByejuGb1ZWRRaczICrA5uij4qoo+2Dkk9c+gFPNCTAWhVUmE3jiSQQzI4Pp6F8lUaot1JTZVTXJd05eo8WKmeWXfV4pMJaLlxTNw+/sPZ30VdD+rLvY2dN8pm2V1BC51VrY2hSLdxuB6a0Y4r+zsOBx4YDvjQMf9fY3VzgzOV80KtBdkaha0E0nqzR1a6wEEQZD+BIjsNf0Y2c5kmJpVp+5FdOADWJLjHiFlpO/LkmmDtAYtLp9Q9BT26lIT61dXZNxuLACMywSN9QZnzUaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBRGOUiVAVAMfYbG0jXDZFECVVJqqII476paP4DXAow=;
 b=JIlsoh65r4MZkDeMgJbV6ETxawwzfTONmWYEhDf3VK8zOuX3ooIfCXkeMrDBYrT2+53kNDOtwlqTAXyJC/Ks21LU0+KrVeemc4CZLGWIocWIxFRRC+GzBNXb4KmwK2mneNX40w4QjJW0pq/2C8ilbJ/7PQQmPMj82K13x5ch6ZY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:13:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 02:13:42 +0000
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs5bxvwt.fsf@ca-mkp.ca.oracle.com>
References: <20230724140454.71047ed4@canb.auug.org.au>
Date:   Tue, 25 Jul 2023 22:13:40 -0400
In-Reply-To: <20230724140454.71047ed4@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 24 Jul 2023 14:04:54 +1000")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 67643db8-bfca-4809-b42b-08db8d7def19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY+lQE1PXLJM22kcJBdvESmn+b3R13BrPbTIWSVdNUf71MsSys27YlLRY5WjILTlunks+Ak2UawDDZXX05thvVup/DcmLqU64yfONEdsGB/sku+9ZwJwY1jjE0qRvoxyC/YXF+ZdwrwWt0RTGo96YhneRZGG5Qhv8c9/Kb2sdEaS4Rb9vJUO8gbqtNerOybO2jN/u5pdU4HjdOvMvI4dTYUG6PubczugdWCPk/AkF28/tSR7GX43Pk3cWarfz2GWkKEHVi2CL3JUa7v3k+hGZgJxo4f/XqA5oCrK4OGkwqnphpVkJJzC/PTzNdPD0ZNsWy9kwqG42aP8GHSLCQmZllkmu2naolCy8j4RqRCkpYM/9CkmCfoU6gDd0LOOESQOg978UrxPnh5JSF6utJQOsL0GXSwlus/0t+ta5h3NO2BG89YENyyZ/AtoAry16bj0ttXgAFsq0//4YOUZj2Yvq7lWckgT4v+6KNjDlTqUGmEdUacsMYqSbLUeHVksWziGfX/l0XHzw5NcXQ0wRvsOpw2B6xFayNF4maz7Pz2XyZ8Bl/2pPSiWH4Rv/ZfByC9m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(41300700001)(4744005)(2906002)(316002)(8676002)(5660300002)(8936002)(86362001)(54906003)(478600001)(26005)(6506007)(186003)(6512007)(36916002)(6486002)(38100700002)(66476007)(66946007)(66556008)(6916009)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOjJtoSRNhQGVmKetc169RCqn4HPwyZRTB/c540z2uuVt0E8MkXtsnvXDhdt?=
 =?us-ascii?Q?wDX9XQyPS9YewXuWDqx52LkoQMeYDNFJfJkwo1pxtIsGeZIo0yW8E27vLvQm?=
 =?us-ascii?Q?67UuWH5EV09kzikjodCkKURmvONxaI7Vo7m7lhrrkVFevf9G3b6n28b1lqpq?=
 =?us-ascii?Q?JLmbTB00ilFCYSha1VRfUjCrhWRmVBtGciod1t9ZiphATqLoY3pmxpWhF3O9?=
 =?us-ascii?Q?TARaYed7vEQg8JApuB1WxjqckuF75PxShV5JVxUkL9k2YZf5+GdJulRfptjh?=
 =?us-ascii?Q?9+tsHSuXiATjo5RkHGAbPIR1z2NCyInEL6gkwi3WsOvhOO5PwtX4OjD1VCmp?=
 =?us-ascii?Q?H58dFbO1ZsRYWePyxKijLUca+CL3JEJTXncehpQf9XyZ+xmB5GHBUBpMnVvS?=
 =?us-ascii?Q?od+9csyQ8HGH5KkuRmjilW6FTp/7AjcJVQCyS7tgECMkKAm0JFg2T9CPUXe3?=
 =?us-ascii?Q?Pzi/ad3L0ig2o11ZAeQR46Dnbdqy3NGU+HF9waLdFc2vQm/VviO46uT2idje?=
 =?us-ascii?Q?IGeUzQuovoux0KCGbomR+91isNJuVft1rxMb9FDcez2CnKoML+SGrycyIs+o?=
 =?us-ascii?Q?hLT2Yu9u/o39nNpJpmB6P+PrqwyoP6upNuhgopPy90ejPgMnPtMd/rzY9F6e?=
 =?us-ascii?Q?5xDGb5hqt0J7wFSK9mSd81fipVuTH42wlB/F7dcMjBJa7Yn6bWluABWkiikr?=
 =?us-ascii?Q?R3sRMbIqB23yf3EFW4Mpk00iaXitC8pkq9EDPJXvnU3kvN465i16NGKKl2jF?=
 =?us-ascii?Q?293eg+GLE+fFybepxTXhZIcRrR8FOdCLsHruIUAjMKtfUOaDv7mc1SvAIR5U?=
 =?us-ascii?Q?SQIIdlZeYDOiaDKucjmuScYRE/BVH2pvkpuYbani/hp7gTMW78tOBNyuaBZW?=
 =?us-ascii?Q?k82gTAFV1p6opNuvpNMaNLMWahmDjIjjdMZpNOzl03m3FEvXzmldfDfe2IWe?=
 =?us-ascii?Q?la3amaPIZT8rVRMAn6wFq9fRcmcaYZbD8KY57gwFalYUW5M7CPhn0A20HMJU?=
 =?us-ascii?Q?KjjDMktmRjuqKpqEeN2KcRlJQayYfTf8EErFhcX5+PXO361mqLwSOaz9sl2E?=
 =?us-ascii?Q?0E3jk3CPbCIx9N/9/skYnm6gTtR4wInsdg6arjldTSgNJbHRt1UuMYEnVAD0?=
 =?us-ascii?Q?5r7bKuLYh0/HXsnYHcu+r0rrDSUtZRkqIMNnNA8qsVIwi0Fvglqry+B6SSFQ?=
 =?us-ascii?Q?8t3vbNIqzziDnnut4lJvuwvnVtChxEUkV/7yhxF9Eog7Q077KKwdpUPY2/PI?=
 =?us-ascii?Q?tSV2SzpsWkt3YXKovfXPZw+1LZARV5bFuoNm9sRBBAA01fVcVTPDc4aamWlP?=
 =?us-ascii?Q?pM8etUeNgGJZkL9Dr0++cW/IGPjubckhg3IehULWbhED4tKgZ3AYELFqRAtq?=
 =?us-ascii?Q?6WlTy9mM+EPmmwghTtaHAPBl/I0Le3zTIuhOw7XrMZ8tA1fp8Mo9+rwn1p+D?=
 =?us-ascii?Q?z5SfVYsdKwmFnBE6jXV6oZzPDHHfL2XfUgfWhmxGq0W/hAlCr2TbXGtQCNtR?=
 =?us-ascii?Q?bDBOWPxRxhZpaXd4HD6mRQL7sNcCfLxcHncSbeJFbN5DC0nS9rqJyTt0Nuw4?=
 =?us-ascii?Q?puuF5ov2BUF5qw4nkkq9zHMLnVIGQOZec8FbmIalg5SQ0cN3LsrPlGBZkBUW?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JLPPJWi8GgU1byXwhVSuiFRv+bGuvYhTErL6/7WeVLUYa+fKWER9EfECNx6d69iVw3+S6z/t5fNXQsX7gTpB3T3e4Lhmt534akqSCUn5wv8RmRj7kdTjxSIalgN4PE4s67KwfYfdm5o12p3KtiVjBL8jutke55zozb1EoOoousIB9YO9FhBVphycKEghqiEizwkwFYrZaR7gtHmWVqSPZXx04fZCH6aJxBpSA+n6lMHisVad8Ekc/viFqJb79IRJKiiYhAstrjDC3OGRIIm2h05Yq9yyfu35HVg8jBXqV03GRFSdFElZ+6y4XmWxRtsCCL9MC8aFScAe20vt6KZkbKOsPc1ekOei5XCE7KOy8YK+ruSxfjXELV4Grm3uijcyS7P8vG2UvRApCkS1SoMpCLWc8VxfZHIwJR/YLrwX0bux2VlLUB7BuHLpowMMV476Hj1giegbTfjvh+w0+DQVMdoaYt2D8Bn9quLrzhhBdSg8xBOpI/b0ABxVoynM0/z4sXh5pYmd8FnxPMUkeoenD+MYVQzp5NienbjbG396ZqbZI0N/BcGl7GTe7CpvZyYJuo1XWnhHxn96mIWARNfEMy+ZdgM6doU+EzNku5klyFlacIzlSn/C5OR3XZH3i6iUNcqr4AodGTYbwdjx9dQ7DpL8RP8dNrwwKdwjlkpMjogFapr2d3DdRWcQxEiN8hKIsqX/C/GtdD4tkgJawnPi98iYa8CP1U7fqotMGarOLdG9kzA8hSUehN9ptmmTa5nmq6QeiImxQS2ihFFOcAyxt/pIEfz+FR2xgSFAENE3jCSci+Etxvlq8Barh1OHX1q8xFE/nuHaIBBJa5A0w/DsSQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67643db8-bfca-4809-b42b-08db8d7def19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:13:42.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUgpBHt0hW51YWnQRnkGS0k5vsa7BHQeHu5MHoOQ3hxRV8XfGsaTqPOdEVIsddrvJakd8epGVeH/2LKeSc4127q2OQ+QR+KX7YZpEnPZquw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260017
X-Proofpoint-ORIG-GUID: CO-NUDwVQ1dmHkQ9bR3tiw5mIC6Vcz9W
X-Proofpoint-GUID: CO-NUDwVQ1dmHkQ9bR3tiw5mIC6Vcz9W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

> After merging the scsi-mkp tree, today's linux-next build (arm64
> defconfig) produced this warning:
>
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
> drivers/ufs/host/ufs-qcom.c:1652:31: warning: unused variable 'host' [-Wunused-variable]
>  1652 |         struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>       |                               ^~~~
>
> Introduced by commit
>
>   8f2b78652d05 ("scsi: ufs: qcom: Get queue ID from MSI index in ESI handler")

Now fixed up, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
