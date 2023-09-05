Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BB7929CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353100AbjIEQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354141AbjIEJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:56:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C818C;
        Tue,  5 Sep 2023 02:56:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853PH8h011372;
        Tue, 5 Sep 2023 09:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=CcpKXCF/W24kZ5Q5YNF9BjHIS1entmkgFlvl6Dl5lIU=;
 b=ZhHRlZuAyYzGz4Yz7ekGsd4DBOiw74gPaM0jJwKP2lJZj7dSBVenVqjdZT7iaAcoE5vH
 GA8dr664UVCzLyuwkKLMy5vHA6T4m3mIMt8dAQmersCieR+ujbUjQWk48v7VeTydrWMF
 F5gDEdA4u4yvze/iX/F7HLujVbWOC7eOB3K7Myw4zV/Tuw6Rmcd0LrqDetxEtuCL7zls
 6843gwIhwCqSRmiO98y+3Dqd0GW6i+tB06mP3BGSb9V/xjb/TdkYIKkkzIPlxSyx7F48
 n7QBf59C37eSJeUYcwwujB1ZawffPffUrYAPA2hoPmxn//18G7XIB/QIZ66OLcFu83qs 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuu3mwv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 09:56:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3859K4QX010457;
        Tue, 5 Sep 2023 09:56:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugasgtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 09:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaMEWkZGgt2bsYb/Pdf4dCwZEbnUcE4iyulFs6fA4fa2aSG1spcoWaVhpl0yCR+dkZPlFY5UASb6tdzWUupT7RCbcPZtFRy/xowNOMG8A81S8EAsXjsVrED2scPfndUCq6O7Jq/OigCr9QF3IfRJS91y+SZSlxoKLrQA2rWrSL9z4HfPXpCePnNBGHrhFyX80d3VgSORG44wrYe6xm3p9tgMo82nNXcWK5twgsVQnJgim9dtz3MO3EEyvdLkoQIec55Sbb2z0i24c4m8qzM40lkbYGRy6JXzJZ0sZjDzi+HYiGxWIk6T1+faQcEH98/4JB8hD/eq+E/XHrHZvk3dAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcpKXCF/W24kZ5Q5YNF9BjHIS1entmkgFlvl6Dl5lIU=;
 b=lalA/o9zk9VNe8150pa+LbzashtyHHIe4J2PWvioKHnLzn8A2JMFrhGSc3TtW1GgqotsLkfMHs5sz2LuLKobv7VN/vgPv54GwkzHDylAN9QZdfsHeOu4T2njTB5Z8Orh7RpgkGp+7/4r4HxgRSzxkyqnFtfIMTqKEi2WUTPU+ePJbl30rKe4xm0wYxd5KYuXauKYpwgqLy7bft3i8RsWhQqiL5ml5U4jaosgRUM5YE0/5jV6w2IRWs4m4VtIm3MHE+PtvLc2It0NxzWsn8q9pPxjRNhkPghQxL9h1R978BpEjmd9294o/ycnWaGDGJzj9LIJPlJsst0TSANjVIlAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcpKXCF/W24kZ5Q5YNF9BjHIS1entmkgFlvl6Dl5lIU=;
 b=VNxnncaDdO/YifyW6ftpu8j9F9NJUSgiMmE4guvhcFTWytVCxrs3FLa+pvP3ktyV3pj8AtKFWPrNf42ZIjzefx/LfCOamXhVYflVrBHcn09f+RhpYCH4NFbCdteES0916RMb1ekV6mxn33MMsGOXSg+nJrP0Baguvj982eRjpeQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 09:56:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 09:56:09 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: Replace strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cp5kkpj.fsf@ca-mkp.ca.oracle.com>
References: <20230831143638.232596-1-azeemshaikh38@gmail.com>
Date:   Tue, 05 Sep 2023 05:56:03 -0400
In-Reply-To: <20230831143638.232596-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Thu, 31 Aug 2023 14:36:38 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0487.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: c124897f-e7af-4bdb-07e4-08dbadf65483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsqhijG6erbrAwJ+dzbr01qXu3B/0p5EDiiCRm2zm3fFqibE8OQDh3T51eaLdH6i7+lnBKPBm91cCVRpYXYa/7A3n6hsUaHa9LHNX/VlFj9MMc6tqEA8ccavJdsAwFts3UC6TAFgB+1zZ3+NHgQq8uXq6dohMR1PGpAX46YZuTTCnAGyG5o5/be8KAYzybbU4VL5MU++enPlFvEIhWCc8BiK5DhhanJQOCC9y45vZj4gfUQJ1CECVQxERO3RHQpx4YSVMwpe3x9wBJCLqRUv+/A4wAi4Ipg6VxP3BgALBYBL+/mbcrG3d37fx3yYalO5DDjXMr9YLmnoHn1CSeq4noiKluzt6FAQKsAaHmJWbl7o027zg5SkvjFAdxwsPLah1Ntbj3oXs5WR7oDJ6Yarw8E9GjDjf/F1ebexm+QI/jrO1MFOIcBKeCmpVGvIl5sb1JsN1R8/2CYqNG1BnusiLTf3w5mdA3Bctf7Zamu5J+pjS8Knm49bleM2brkc02njt7nZOaYnUjM9kZ2zYiYagX6iRnyrtzt1ROXuZSqIOrlD5Ix97yzqFXewMbOlV5njOcfKxZoczd23bFSFVWxGGom224tziX3Mstn9F92MOJJqdF6SE+nwJMbLM8nKbsTL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(4744005)(26005)(2906002)(83380400001)(8676002)(8936002)(6512007)(6486002)(6506007)(36916002)(86362001)(478600001)(5660300002)(38100700002)(6666004)(4326008)(6916009)(316002)(66556008)(66476007)(66946007)(54906003)(41300700001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdpSXGIChevSJDcJk+2qzLHdTL7aLG8mVe1GwMXIRAedRUKp9cyn1ZB/N59K?=
 =?us-ascii?Q?4pdsra7Fhgl0lf/MLWJXmooRCwSiQGU9SUG1mlEo9YW0QrbWERohgL8ReGr0?=
 =?us-ascii?Q?m+bmDzJKTPz2j7xfbM43Sdm69WtRb2gis6KroLeNemGasOdNV28kfsPVFP3o?=
 =?us-ascii?Q?4cRKxWvHplPBAVx8ONTf5OrZT41O1EVwQI8clyh61owyaDfsOBx/y8TTpyPQ?=
 =?us-ascii?Q?MVHIU+3PgF4NkShiVqJWqICkosvMXUzWW/RNZjmFd7e0IF1qNgZuiBjGPNV4?=
 =?us-ascii?Q?v9PHuEwGgTisaPYbWGkN1vDOXcFjYfbwfiJC55OJ5BZiq/jTxfx8QjwMRGkf?=
 =?us-ascii?Q?/zQAGbVex95ExEq2tmoLQaWu/jKyrQxD+AkJcy0YeBN4/i4dEM9PALNKIgKX?=
 =?us-ascii?Q?hZUeZE9E9gHeoWXyf4W55OkOgNeASRqvHyC71WikUCRB+f2Yjoz8MgxWcG6A?=
 =?us-ascii?Q?zCqEypqbKcA5A6Gs59E28pL/c2lneE58LwRGrI+cx1itNom9z9jrDGJE2MFd?=
 =?us-ascii?Q?XEZ1M3wFQKtgiYDWo226xrlWzvboCjB+fHd/UyTB7xQHs0RajH5pMetDQj5j?=
 =?us-ascii?Q?T9SG2Z5j7XaV4y0CoDhFB4+bJEwGAG7U64D5RRrPVKQ4rqc/0jZDdgcUzX5m?=
 =?us-ascii?Q?IJOXZ6DtS0hQ85/rYS/yD33iUbRF1LWZofX2mQBwbs6Tu5ZdXvr411H9k1QK?=
 =?us-ascii?Q?ZucBbEAIHbybDikQmlSbR3JluWZ7AnJnNMEWcU6zflTlBPfG+/vj0/H6m7eu?=
 =?us-ascii?Q?zHXpVVNZLDy/OCgCWmIj1ORD31hr6CnvU0c3IT9vtzoZftaO7U5SKcU/UrBj?=
 =?us-ascii?Q?H1U0buHz5j9+l/6wrItR5SAMeLWQGebtwoHriIwz99Xn5jdmSzpgf4cXI8Nd?=
 =?us-ascii?Q?YKIN1d2YbcnQCbfUjO3HhfU7V7a5C0C/ohFvv+k5xVRh8vBa5iQEBlD+7y+R?=
 =?us-ascii?Q?9PY85yG82qNbV2bbtwSMeV3PjcWqoVGyaYSxTfEidKEPiulvj6E9VK3rz1e9?=
 =?us-ascii?Q?1QQ6/DMoH2q0GOc2DrYJyRhX17+x1+3L307mVxEB5Wu8TCD7cbAMLLJV8r52?=
 =?us-ascii?Q?uL6AxWmRJW26LlK6JX6fUiDiEX9q3XxLomn7OiTOtrgFq2+3FEP9yf5rBrHn?=
 =?us-ascii?Q?dYeTsR3XyB2BAIhnsXttc+9zfneBKU4gapNCHmK/IvSDo75HFp8e6pigm3my?=
 =?us-ascii?Q?WJeykr9FinoZR6KEbuZcLm8SPJQYdH+rVORKG7uNPNnFUM1rtRz+ejqa2NjP?=
 =?us-ascii?Q?v1/LOvhw1BDekR/Lfn4jlrWieGxsA2eUYh0lNxzg21rIYM5unYuyq8d9Dya+?=
 =?us-ascii?Q?kQK4zYF+buaOLMEcEpcAyfcCAINE0RjvGFtVXWA8u6iOLUxouAYIAGGHlAx1?=
 =?us-ascii?Q?XvbMseIooJ2Di7bPjqxgn4ubBZmA4JO9pxLgKzI6TWigPgtFqHeMgsfmrCKU?=
 =?us-ascii?Q?QkkUxYkpxgwViFUqne7ntkh38SGq8laAY84BnjHvUu3uwdIHtr8OhumaSMdf?=
 =?us-ascii?Q?Z2co/GwvgGVZQTC9Q7PKOpohRhUOzDIHhXvrfq/odYLKq+p5w9tvNJxT+Oh8?=
 =?us-ascii?Q?JmMS5qAnhdnmMAn2HXpkyAr24+0+v6rgmhNYhtxFmiiC2ZXDX5FAsB3VB+zg?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vyrf37f6r+RnlpQeNJpfS630AVlmzOb/qSS2V/ynoHyNTpqm55uMUj4WAItQ/3U81bDAf54yvnBIivKnlsNnZhATmvMe1+S9sC3ih+Rm09TaJzH2ESJV6JRBUUmTE2jUfuVHvPBdfnzWeCnJSYc9C1eoSgplvYE8h6FeLsKf2FKpqZF7Z/b0+yA0gP+bXcVRWT3a3Mln5Pdn5eNWrvA4j3fCCvizKFaYFMtCvh5LU65jato4e/nRAg0ZMhYoX+tLfAgzJhNFeIlCxPi4BM+jzzABjMPWBrB/vL2zxcp0UD3CeMJcJ++3nCh18nV6QILnKek2J5Ly+QY4HpuSQR1oj2M5dyp0DdfOihBSTWa8dx/pRJpZvcJ4ncJO58ZcktUwMVcE4jBwHZ7+zDElbb73/OTMAIoWjvG5o4XdjSwoJ2O3RsDSNS6RplSyCacG5b820by36iwtN2KAqCr+TnaIEB2IEc4QmP1T9sg2BIehiGMOJUVCmXqw2fF93EtAy30wIZJssZFz18dWSTfC4AMrU6Uxrzmj4k2Zm3oiU9Qyiwcukb5V3kjiWMsX2cGPVbMxFPr5mMqQmFcFmTxy4NU3wxenvYy1sf5jpaAqm5H8/6K0JRJYaYEfD+QCYe/y2Q8gLFc3lWKr0zrgfFz9chU4/xZ/vh0+q83Wcgpof/OtUkX7aezk3SYzzskkT0xEChNfMHKGvVISzN31Pc7ojUjw3SMmkqQUcrLRubh0cPi9lglECe/n/uKoWgGYjf9IM6LujVTVh3GdDWPqh2VNhbw2guPM/e89U0FpujKJnEirmyXjoTAXt2WnhLJGSNDL5QeT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c124897f-e7af-4bdb-07e4-08dbadf65483
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 09:56:09.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y+7MS5hiiNgy+RSlq9hTR9jxnC+OVvKyWKoW/7oOBIUPsw75JWVWngQoVYJQAnUxd+ysrkxKKvGOmKABBISVAlRpAaii9dZ6URxZKJwM24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=833 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050088
X-Proofpoint-ORIG-GUID: 9uJz3VNJBCs3Ks0r6ck4Sol-dq-GXh_j
X-Proofpoint-GUID: 9uJz3VNJBCs3Ks0r6ck4Sol-dq-GXh_j
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy().

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
