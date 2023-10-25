Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42D7D7312
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjJYSRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjJYSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:17:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040129D;
        Wed, 25 Oct 2023 11:17:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwHQF026199;
        Wed, 25 Oct 2023 18:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Y+w2UGZtu8Z9yZg1EwPbDt/5/oOVNmyTTID3/2SDos8=;
 b=Y5YGzhqOTQHGbyAhX0BJEr5hkI5aaLJlfwF6ta6zh11NeZFLYSlauDCmAwXg/xQk9UJo
 6DOtn43tSnI8Guu723+J7eXb3f3U3zf6ngRAUNowpa8ToVXyzKjaYryuLyTfZwbNrZga
 8MhtN4ypccG4pnuCHimw1Zxx5IU6gABsJBQmsEac36HmVnVgBejoIYitqXe82t/IY6ck
 k9gQvLqZQYH88Ip0qZ2hcXS6XeAk68dywVZybMGAUQyJHisQOSAWzHgVKQFcdde0LsWe
 K6jpGW5FRO0kZKPKHE3iz/cF7kkvbuy8jnEUZE7UUIOQqx0IBBunIxMK93eEXmaRQ7xT MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52e0ga6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:17:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHomPC019015;
        Wed, 25 Oct 2023 18:17:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5379hja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snlqi2lwwU+Cch7P1OuP8vcf3sLrHWi8JpAJIvYZFIsyu5inCXsHh07pRjqGPl/0lc1xLXN4Ic+IJo6vAhKmksGZLYGOrRTuvhkWlHFW7galerbbggKaZF+mpWuBTX3GpbncI0Pc7ihrQLWCm1/CD3FxoJGagnN5/PYpxc4sFDsmdKdNr33rS9SBvpJz7o2zihoOebbWECAS2d2vvBLRdZrSEbhb+Rt5GvSayZaHUoZ+tq/KI3JCGo3QE6RsUQcaeYkzwecgO1iRljgFuTnWJTc4WRDZLIKJ72ncgucVMLFTZ7Nr0wSVvXAD0ciPs7kutpWJFCVeJSW5VWUVCyGfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+w2UGZtu8Z9yZg1EwPbDt/5/oOVNmyTTID3/2SDos8=;
 b=nt+0TpS2InUcSxuN6K3u+KvAchEOLzxgHGKRBAqVQtYm8fFazX1QAZh5lsYAfNqVbk5kOlCdIYSHvaafDgcGJdc4Ngis4QDUFVInMpMHhGYJXSGXTGiUv8sAarjMYOZqPQrTaA+CSYahw1ZWPNJM2DmlsNjbKbRfK9Fe9mBJ2F9hiz5kthkoE2Fy+y0CWLbROx0jReRYdskxTPkI9Ux3WgzbbyY9jkHkbgpGad5NnRW752sve3tcMjhbEv/vJ4eO1L9kXW/GbdQD1TnKqiW2kUK7+R9h9AdBKiAAyVnwEHYlUBx2XXLCxkBI26ROu02AKR1o5lKYcKPfMqGlXqU6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+w2UGZtu8Z9yZg1EwPbDt/5/oOVNmyTTID3/2SDos8=;
 b=vs9hBMJ2Ki0k0WKcoBSoGd8BMSQIIsnjdnNcq1HlPGwGMni8gL3iZOhF9+uYWbxvtD7QRpY91hL49N1sSdWIIG/Kod+dYFLED8Mhh0UTPvP6JoQ+RstQfUZtRX9jSeyXkcyLdkOFuw1CCYrWg3pomWqutO+8p9LojxmKXnCzmpw=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 18:17:36 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:17:35 +0000
Date:   Wed, 25 Oct 2023 14:17:32 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [RFC v2] padata: Simplify sysfs cpumask and sequencing logic
Message-ID: <mtuckinkekec6b5jolatrshnaodj7q2572itq6glfmvdf4yy2v@q2xmkhwegbnn>
References: <202310121006-wangjinchao@xfusion.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310121006-wangjinchao@xfusion.com>
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c7f476-2351-46a3-ce8d-08dbd586a9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw/vM16PkKrcuBSdb2FleiLYs1nXW6jDTGyqFTZXbPoPoDNlWrLiV4p1wXPdTuWeIibxXgZc8JgEoZ4fC246S1ytLz2QN9czY5GCofXSsTg6KT89sO4+j7nAHc3CJ+nQ2Q2dKFnf6YCGpGeBraKcvDBtDp8IBA/OgUS4+HC0iqsv20iL99Y6aUjFi1JiaFh9PvGPb4xTIt5URFuM0mFwyoiobQQKWHHttoKRv1ZvlijS0ih47NpN7n1cZzcFgXA5mLNTqWW7PQJ2lfVmXpSOgYR73gwKNhEuEDdMluP8OiLHQft08+enQNxyXCEqcIqtaHA2osRXlxNpDcLWbBrLcBNZYC5q17UTTkDUd2HOWjiYFqw3LyuTJU0yp3fi20SoSnTgxZsPJIS1HRlDm2gOmD5H2xeHbK+/lPriM9J13vwIp2CYCNVruZGS6o8bClRBpb9qq7HkbqV8HRRqzvpm8wKWPS8ouUMVH6jfYXkbpYeJ1eSlu2dnuaie4SbV8A4ZrHHOJat9OlFWEg0lGY1qW6Ur7grZAWf22HTPBnO1/eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(33716001)(4744005)(2906002)(8676002)(8936002)(38100700002)(26005)(4326008)(6486002)(6666004)(86362001)(5660300002)(6506007)(6916009)(9686003)(66946007)(966005)(316002)(66556008)(6512007)(41300700001)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bwerB21E7mSsuAl29hD3AzLwKJcbN8RZq4y5vw9pVclNQyMFi3W3Fjva+O5?=
 =?us-ascii?Q?RJcunsDfr5lmwevS51dXkNd872acqlVxdFsPlFH5X4yBQMgtipdVswHpxR34?=
 =?us-ascii?Q?3zB/MA3fQ6w6fUWrwTmEK7tCM13s1qEhS+OS44P8aQlb61PKLFIpz/O4Ogx1?=
 =?us-ascii?Q?Vj/10AvlnAsqjUQYp4+uAcdBQU8oEUVHERB+w2wwfVf2b3vRtElLHqVf4Olx?=
 =?us-ascii?Q?8LYojMw3yNVnIGF9ICjnG6kMNeCCBw4aEg+U0CVyltOaaQjlKy3DJpAOVA7G?=
 =?us-ascii?Q?WC3OcSzrOo7nujIbcfa1Jovmu9gLE0UClYznPUNaf+JSQyO7xF6zzRu5hVpW?=
 =?us-ascii?Q?vzVasAg99HFd95seUXr3Z3NXG1NmBFNLXrYDuNrwlY4Sd9ewJJbyJi0zinv/?=
 =?us-ascii?Q?SxhRAqiNLA8MesfFew0dV0z6EsH/u87CrUGiThDJSAmL+F8fHBtpdKDRL/bJ?=
 =?us-ascii?Q?qLhWojWAsbc3+m8b/0Q086lIffEuonTyqZDceLB9t6G0vUNl+54+DfHptrYG?=
 =?us-ascii?Q?swcTMaplSR/gjj0S3HuJ9f1K5HGUFNQcxFjZFaJkR5DBb541lj6fP3+nHGYf?=
 =?us-ascii?Q?b8lT/8eyRM1T1mgBHP9nvYtGZLYSrjwH4oXiYSS2owUyR2jV+cDme1rfzqJE?=
 =?us-ascii?Q?SZtY9mCbUVg8c38EqnEafOeuiX91bb7axxcvqguJyagI71JU/MxwFbuegPCD?=
 =?us-ascii?Q?GgjX74qPHoTOXnh813ZHrYgtdTLfNOu6g9zO6vo3k8upIMtfE47nq07JwMDB?=
 =?us-ascii?Q?zsf3QE7aYtROjRaEnOQxo5JISlI+rPOKUKTqHpAdCvne772ccF/q3HY1/gQA?=
 =?us-ascii?Q?k8Zvadojvg/eKlLKDlk/Jh8S8S7fY+LE9KfUp/riKbxrRpu77u858VzI1fK9?=
 =?us-ascii?Q?uqylMT//EaytH9QETkUWiP0cv1f7IfuK1S+zQ7V+5i+joOhdCt3HBVgBZlUy?=
 =?us-ascii?Q?w5v0Pe54YzsWDq/FL85tk/KDp7/0IFMRkTkLk5eVBe1DPkULcSB0CP5Figui?=
 =?us-ascii?Q?Rcfg8wW6R4XXuiiAOqwtknWKs95b0q/jZO27PQ5b3XQN+avM0ljb44qfIw/Z?=
 =?us-ascii?Q?ckEbzAoYjZTzct/sljbajiEF3CBHzcofWJ2MbqV73dLiNI83tBAQJYDoY1GR?=
 =?us-ascii?Q?W39j7lfwuXSNqYnql+PUWxx7Z4p6xauQ6ly7zHAnoLcLFYjhGCxGEcPqH9hP?=
 =?us-ascii?Q?4vt9YZP4dJstYXDZ+gRHgZ2MgLCg9a9fGXbsgU6w03jN6OqIS02vhRWeUoZ4?=
 =?us-ascii?Q?JpUybrfpYItrpPZM89+RdREuDVMnlfYIrf564g3Fu7VBN9uBwWOPBcuqe8GB?=
 =?us-ascii?Q?+/B86xB9kX5DZGEcYD2/ZX0fz6lR91iX3xjBOvbI96DnKfwyefgBJWX8dUGi?=
 =?us-ascii?Q?fiYYP8fQLiPjy5JsNVvhTON2RrzFR5tASeIm8pEWZ1RJ3OR78DHe/lZouRr8?=
 =?us-ascii?Q?/h/lUC+hTqZBfKh57UHAy1RmVOwwBFdCyftZ2MowisvQQzI66NDv6wIZkl25?=
 =?us-ascii?Q?CpW72FreuYU2YhoQp37+qH3KGCqp1DeLalH6k+ysmi2nvqszg4FDXeLtskoq?=
 =?us-ascii?Q?o6ItHRar/bXhQjY9lBW+H2Ls1rIhVdOSfblxFvIztqV6n3gjJa6BvEiU6gxz?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Jxeh+BvuUUhJklk+zbvM2cFbkn0pVxjxGEdycTAdnBpN9C8QimXDW5BSC2a/q4XRn3RKVbOw2rGIyOwGhjMoySVvhGmLj6o4/7kPTUihkVho3VnHiygXhiUN4jV9Rr5hqPovMbBDwI1NPU5swq197Q5YlNjy4C1Nc9/XcGJfFpJCju/4dLZApQbCENiqickjtL6XNGkTv0cAR/OyP1TsbGIma+jbBzqEO6ISIUb+oZH/tRJ6nyZ8DKkUPmVTxwQ++VhjINW7qjisi9YAvEs9bj5jKMZL6uDd+qjH0AiOwUx5S1PhfH/rxMGxFZPKWVKPxLnMWlp+WxpnnQ0wrzgaJxAfQVev6gKtJ5gcwmYtf2EzI+S0B/C0cjQJcPbueUuIQh/Vrbn2+jiaNt+33HQ01Vb3h3U/U0yeHK7Oj7pnCqL/C4DlbAmRQAKAUHo74nexKHeRmAH1yJSfW8fv+BF/+mCE7hxDfJaRotKQApaxtmlFTPcyQy+Ch1GyUFy2P5CvQPsrb12Mvq2uzW6SwofnJFf8zm8PAjQcWvMGB8LSnceXR1NSQLh7yQ51xFSEDssAhf0pu/Yiw4LiVNMpTuxyEPVFBKnoD+ehlgx/wxUUhh85cQgWMC8/E6UM190gtFX/75soSY8Uel4GJUFUA78vKvgnpcnAYgOpCuzsDoc8WZ3sm4uwxR/sg3YN4SLvA9cTiahoDA/u1L0zwwKDpRKjazq2Kyfpr8DQ00ANr7jRD5xfKqQtqUH8g7AK6NsLGwkRfj1xo7ckVGs67B+VGB4vrDKKWfAfZKDrPqLaOOwoZpr6MCOyh6Xf1NQ1XzgjpVW95A1PyDY0xFWhPqzW1WJVA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7f476-2351-46a3-ce8d-08dbd586a9ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:17:35.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5dWk0rc9sAP8mkQ2yfxisWDPXx+w+nnqIT3Sl9P7G2FYzISXpB17FRwLWzI8GVXgeGMOjMda3NvuLz7V0PEHCxp8TR4UxDT9QlshFbojq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=973
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250158
X-Proofpoint-ORIG-GUID: KThDy1p1CUdsjG4iNRbJT-Iv6ECJYZZn
X-Proofpoint-GUID: KThDy1p1CUdsjG4iNRbJT-Iv6ECJYZZn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 12, 2023 at 10:06:40AM +0800, Wang Jinchao wrote:
> Utilizing the WQ_SYSFS from workqueue to support sysfs
> ======================================================
>
> Padata relies on workqueue, and since workqueue has already implemented
> support for cpumask through WQ_SYSFS, we can reuse this functionality
> and avoid redundant implementation.
> Link: https://docs.kernel.org/core-api/workqueue.html#affinity-scopes

Keeping the existing padata sysfs paths seems best, as mentioned in the
other thread.  

> Using completion to ensure the sequencing of the 'serial()'
> ===========================================================

I responded in the other RFC thread.


Thanks.
