Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E187F8788
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKYB0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKYB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:26:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DD19A7;
        Fri, 24 Nov 2023 17:26:05 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP17R25025438;
        Sat, 25 Nov 2023 01:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=HrJLKqWs8Yy+MmDm3iu+pL7v+39pQ9rHI3fCj+zepEI=;
 b=I9LJNSBGmxEYm2TH4GUKjgItl6edd2nch5mJuTe29Kgu3YhG+m60sfxA46c4drb7TWDa
 u+CNJjJV9E7b5CrT4ej6DntCmsVlN8Ec0dbbDIffYUK3O9HkCBk9bhyh4A3C3ZKqU8Wd
 x0NbyhIrym67RvQzGqpOPsZ5ZtVkmIYu2r0qUEgInlObMhb595dxyPaYvK+H3bdYf13J
 dZIy0KXG5u5AC6DRcXVIl1QJlC5KTCJ4B3FKIenWnC8ecqufisQOfmaBYlNPPgM9oZ4T
 8a4QTdTOeYXJqcsoLFnuxJ2HmrgM9f/Vm4wJs0miIvzEVv1VdamRaBIf8sqSA6oi2U+D Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv33xv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 01:22:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AON2cTr011035;
        Sat, 25 Nov 2023 01:22:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqc61wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 01:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alCPS4Nl/ep77Tnlux4qiBFoBMSOF9g0d4YC8F+PDN95wGOkIAuLwnh73wNz/eC7nCr62Xaf6b6b567p5dWvfC3cIogvE0U9Y3WAw33T8FzcumKw1PmEFuFBmlooIyc+tlz+4UCTtu38ZZ2rXFL4+BWIhaFhMoiwoQs3GEGXxIGEWviloOGBIFbK+1tdbIjkohb3+VvJrB6RDPemDG+ETkZyhYIU93JVwnRNqXUSW0QxpMejK8cp9B+0eynwqtfpmSUkfjJpukfJ3VYAZwngGUKBur3a/zqIYy1Xg66JvKWpA9JgOPoNUBL8COVUgsimATi3+H3xQ5Cd0kaBeYuF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrJLKqWs8Yy+MmDm3iu+pL7v+39pQ9rHI3fCj+zepEI=;
 b=V7ovIW4DYkhJ/gKQk0vObZxxhnPe/iQI+KcL/3PIQeSHTFgOaAuMG42cofgcq6UGwXKAUiuVwYafTpz3FLH9zRpbBH1lhlJbrEOrlQ86yrFdcqD0xO86nm94v8aORVlazB+7bTYU6nAqOSzAgOXSYVkOr4mpc6H6SexqXOn/h/vqOGvkSP0pgFhGpqey2mBTF9wy93SkpmiI8xf+us0vwU9HIelsH0DZTOpdpY+0zqr9ErsDJCa0Z2JyyKUntoV2ysJ7DIsMQj51kun1tixsOcv8NKwu3za7cLmuJMcr+53hXtPWQ5unOxSxF4gMVZ5pVB9i2tNHBZo2QGJWR53ouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrJLKqWs8Yy+MmDm3iu+pL7v+39pQ9rHI3fCj+zepEI=;
 b=LKvuXIl3UedgpGwc+q3vdwI+HxxKhBHJSbR+mKXU1xb18NO8ga+evexWQyz7CTHthrXFPxauSVd5gewwJeMs0OGSoGbKmckzhEona48RPyZuqAlvSDDM6ZixdZF2Bugi+WBJ5Gjg2XYm6A0JVTREmkWTe2JeE8T14qNgQRcHurY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24; Sat, 25 Nov
 2023 01:22:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.7025.021; Sat, 25 Nov 2023
 01:22:09 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] scsi: fnic: Add and use fnic number
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1emtzok.fsf@ca-mkp.ca.oracle.com>
References: <20231114223221.633719-1-kartilak@cisco.com>
Date:   Fri, 24 Nov 2023 20:22:06 -0500
In-Reply-To: <20231114223221.633719-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Tue, 14 Nov 2023 14:32:21 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: edef3b23-d770-41ef-f127-08dbed54f17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4R2lRfg+gZA8ksPVg28g+QU+/+3JgdbPdR/Wg7wtBiNHtUBc+VID8nvC2alc4J5k7bzkRf+0ON1J16+U0mw+FFc2FnKo0DxkZanwidOkiNhnvNEAX+EF23oDOAvmOR6cUIKXl/ChoUz3erIMac/CzA+343Rvro591E/9Ow6lh9cY/1GgYe93en+Xc6sECNXQSo2vmyIeJYq9/a/4Yq8eoUuXQ/c06MasMyTHZUmVentsotc2u1k/wtXdo/025yVHZIqx23ZHEmS5QYpX7YTIT9wWYkZfdvTjL174bu832K/dkjmmC5JFLGqEQdf28l++HTMCJ3iFQqdlPvrPILQWDcN8TnVrcaM/kmIPqEJJ89BM9111yuygjWpKcrvQu8KlRbY/Obno+qZfJvJs8LueQnGhw4Ais+ZeYLg7rxppwNXXGXfDnc5V2RJ6xNauPkofPHqMTOHpmFnL7FtfLtvMXMzHczBFNVHuAVJaeSWcIwyMwmPEAZVBu5qOCfDLZMXC0nYKb1jTJ/Xfs4Atvkhj0ZxangNar+ciM4WJMdOkyAiP1PI1M/qf+Ma36+iy56Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(7416002)(5660300002)(41300700001)(2906002)(4744005)(4326008)(8676002)(8936002)(86362001)(83380400001)(26005)(38100700002)(6506007)(36916002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SChUKtG0qP/9EeWMxQ9pMEIsAJC/tFfTqDCs0GesrDad3JEZRprXfLmJy1LW?=
 =?us-ascii?Q?GErH1ocvriTXu6H7t0UAXbNT8ELDT5b2nUNxCGXutnCNDtcm0oUoQ8sxLtcE?=
 =?us-ascii?Q?mLoYLxp3MjP5Qe1M6qsYXNPz+Tx0cIWYRG2lFxULFlqvveX/TKelEWY4LnTW?=
 =?us-ascii?Q?SHrAuoxk9dYZyb0GzLhrzd15jX/+s5yxC0LtAYdI6FJrkobBe9xCbyE46oa3?=
 =?us-ascii?Q?UiXIObH/ZXud5mvFTSsG9u9N68XEUyQJNaRHmEx9xT4hYjjLTwtZWhQIHNjI?=
 =?us-ascii?Q?1fn/Pt+g+nuVufllHen5ka6RGE+3T22VgD2KK84GFFHIibhjIeGwxp9KE5Mx?=
 =?us-ascii?Q?s9UHfr1lkkb6DP45TJhyS47ge6gPaZXHzqsKOC1wbP9j2nDMiLgMCvYguaVi?=
 =?us-ascii?Q?R1O+MlLDWExofDJCCUHGskpLqhfs2dBt/EIQfh31DcXTrmVdvH3dFB6S01sT?=
 =?us-ascii?Q?8XNvLDXXb1YHVMuAnpJhIvnty1jlvYv2jxbRPPFDtQyY8BdQLkOwl2L580iD?=
 =?us-ascii?Q?OpI/RWwBbYQcvM8aKsXsYugWURKBOpJDvxk0wmf9mdCB/Swj4A6oQUf/NhSj?=
 =?us-ascii?Q?/8YcmPCuufp+5L0YoAjPkFzFa/lncU8acnNCsUzLm/+tUIjjcatYJoYY4gI4?=
 =?us-ascii?Q?e48Gsso+56R4NvW9Tv5Apj0yuENRKuhwK206EOjhDfsi9DhLElSoSnrckgW/?=
 =?us-ascii?Q?PrJ6b6a4xuBRGVI6z2F6SLBUE6N1F0pZN3+Hv6k8Vzf49XrHC8c8wtaU682o?=
 =?us-ascii?Q?aAupXhYBLc42+ZJDJX8vN3SQMEvdHaRJX6grfk2QLAPBFbr8GPryVz8THv+5?=
 =?us-ascii?Q?6auNr/NuNqb3/SGMvB4pxG6lJuZgOIxjyofXwk+Wsq8Uriere1kqrEmsb1u8?=
 =?us-ascii?Q?ONlP/aiXEh7wyWRMYDKVny5oTTJ6b/3BLvmtoKNt34jyWwCxTIlLxyEROzEx?=
 =?us-ascii?Q?JGb3NsXDnKRrbC+lQFwyDEIehb6092CHcG5SIprNlNt6cXeOKOc3pezTzSge?=
 =?us-ascii?Q?mTaahKTdEfkg+gzsrVU99L6yX6QARExwvoJJnUg8SkUTN3LMLL0yGikAbrWH?=
 =?us-ascii?Q?IJ74ZVIPgKn0ndflL3VWHtIg85MXLGRa+tIHPrt0b7ZFSyuKZk+9tBgb8TFt?=
 =?us-ascii?Q?5W+nTmRBoPDBf1fEEmeF7eNdObZeMkHfmsjRHatCHZ3i0/9y1UzwjF7RfX/g?=
 =?us-ascii?Q?mGMUIOBJ8eIN8FtSYn+h5RJQi47FPh1Lk2qYhbC02Jiv46fw3L8Mmobf12H3?=
 =?us-ascii?Q?jU1wa1po1BPjU4/ro439At2wtg0TI4x04C+IyhCxYa7htD5JYkywYjbUdSSn?=
 =?us-ascii?Q?L5pvJPtlO0krGHBCno+GTWMTK5xd7y96sTefimpe2driHK2nDu6JJ1oqiYjJ?=
 =?us-ascii?Q?y/t6acU72dlkOsFnIJ583AZqB6QclKRYyugIOwXFKLGVxSFyXJfjh19vS9Bh?=
 =?us-ascii?Q?RTOKbuLyBMxx69GB9ogUhXdJvPibrqfLadGrd/1rE9pmuvM2StGqzO1rjxwy?=
 =?us-ascii?Q?h2dkrfOA9LpWfZDWsQvzPXpGW6CY63FHXwcUdrt4qnBIGFHWgMc2I4VzNjVT?=
 =?us-ascii?Q?Ne7IxQDIKxKJ4tig4Rg5/OX2OTwwEMCE9iotGVEnIOHFOqXrxRc3SyXDsU5U?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rf1OhJWbBQIYILM+UOSQSmFWw6HQbqEW3MTmJRXym3P6OyQpD4NxDX5rXRp4qoj4l3YPMRqPb9b1F/1YJwoIEiihiIDqussYJSZooQj1Co5MfZdTo6dFLPRjsXn1nJnIR75/R5YrF1iPafD8h37oKsdRneZHW5bBFikr3VldF94EtZOpILQDj9oYmcuSzz07UIYE7abx9ok5Xz4NFVCiKXKXc1/vQ20mbb2qopZtkF5W8GBcczXRs30b5bAooa1ceZqbpAonzgp/6yPhPNwn8xiH8PDc1NqUPHqUA11uSD9hr0tH9o6qZCKEkPPuuO/o8aIvVlHJq13lr62P71oE7ea4PjsVH37Qlt5eY2iIlHkNQOhG3kLFOeXxl9iu+SKQ679RczhHdmYiHbf45abVUmr29Ex/U/XJa+YICMgyCS5lF3ZfrqvAwZ4DCy1MuKbySBaFzD4IM3WN5W9V9mlpnbPoO3bAIC+pDGzqATbgMSN9VbWq9ISYt48bnm3h7Wq+j7e8SVvhXNtFyFXqf8ZVJBeSsRuv4mxYkxJWq/JD5o7syqSJ5iez8ddVZ9VnaTEV3kl0vEEKq1nnywcCkm4N+pimH/Ak7+rRzIoYEkXG2fNqKFPFh2UfDvS9ERjvmH2fG8dSHccX8UFfCHx6C8s3+XuXUOnrb7zG3x7+w4D5m0DzlsRd3fB3Xl0hxMpIno6nC7htPoztdD/r41MgkTm8AvD18m5rMAbrQjxBQOHxPBFEoXicA2ckJk4buzAEtfjEUjQznm/H4B3pEex9niABq1zwCz9k3AuNQeEQ/WZMSgVgaFRswi/Vj5880z9jCHwP6IddvsljFx9byACZDA6wWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edef3b23-d770-41ef-f127-08dbed54f17e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 01:22:09.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwWQ9qa59rmp96b0Vl3JXZJb4hrkedDxOrAv+8nfLb7Zo8kElDfwgYKw9acQzz+xldoHdW/fxF0/UT04QK2seYJVyyu3QN7HLwd6JX7vF5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=717 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311250009
X-Proofpoint-GUID: iLCJDGbShimfjj7wYph8BIGRj-LylXSz
X-Proofpoint-ORIG-GUID: iLCJDGbShimfjj7wYph8BIGRj-LylXSz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Karan,

> Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
> Increment and set the fnic number during driver load in fnic_probe.
> Replace the host number with fnic number in debugfs.

I agree with Hannes. Everything else in the stack will be using the host
number. Your change will make it harder to correlate a SCSI error
message to an fnic driver instance.

If you absolutely need an instance number I suggest you add it as an
orthogonal value instead replacing the host. Also, we typically use an
idr for enumerating things like this.

-- 
Martin K. Petersen	Oracle Linux Engineering
