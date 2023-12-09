Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6B80B338
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjLIIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:04:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D35F4;
        Sat,  9 Dec 2023 00:04:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B97bq0D006599;
        Sat, 9 Dec 2023 08:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=LmVtp9+kB7Llao0Zvgd/zbuHZ84fXkc3Wr4FhFVymbE=;
 b=krOnIuOm9ierTIfCWtSnGN0vOtC5yfoOc03D0X79gMefi5C+czg+LqQ4TyioPFey8GtQ
 /lvS1z855Cc54p6mCNV/nOMU4hqh0TpDPQsz5IiMGnrCS1MBGoHG+yCCEC6SYycZNTPS
 m5fWIwT0SPIr7UjgY2Zh7yyTbZAbt7REuV4XjU4G26e5f0kCeMemyfJ6mtu5zm3p8rVH
 rG5sIy7ET8o4I1L7LhbD8kWOkuxKB3VaKPz1gHNHO6Or/2pKsrBh6BdO0zs1P3z8xCv2
 S5gSJ/r0wGtuXsOLok6xVvBcb6zhczGInV3vqbYVb7y1cg1VQ9NFryhmUXTBpTIxaUSn bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf1406dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Dec 2023 08:04:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B95T6IY004375;
        Sat, 9 Dec 2023 08:03:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep2ygbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Dec 2023 08:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGEpf/+8UFrlPTKCe0tBmlP+4Yf2mbVjxcYtLoS017QpOwKNb/FOPCC1L/K/pIBBP+vIq4ZkO15IcilqhlPtlu+AhM+jwIGqD8+HRdsQ4MlUg7zEHM2/pJTMdnUOkhQcLBfUQVKzCjQ0xpGe3YMZbctvTfRTRGYETuvbcpsD8nHzySPhMhzHUcPJ6/SEjn5+tuSgcviEJbrJm7EU6BAaSh1iXjjNR+rhqaE3C5zuHbn/ufrm47ZgVnD+OJ2oI2bqhfNALR8lJi4oaR1/QAwnd6xYBVomJVkZUPv0bnTqJ404mrsHoR37s8qH+HlhnRXul2EcnL67+w6fTzLftXuwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmVtp9+kB7Llao0Zvgd/zbuHZ84fXkc3Wr4FhFVymbE=;
 b=H3wsG5B1Kl9HL87YeE1ogHBSPl+61yEZsMRNm8bwWkQQtjVOhZd9OLHzC2gR573KLkvfnUobuN5WpwW/rdRAy2vlcwoALsfOTERs7QjMJvFuhJ5YP2E4vM2nXPoaQ5+4WF8yCisGhj13VV3F7yN4riOFsAzg3nQYJSncrD2nMINnDoYIQND9rjrvDZxd1mseGDKujQjfzVCSVVJ+ZvU2jJbp9k93y62cNwrJjBYnThEmgXfrom2a57s6uo3fEavm6/3a0FHgPunyKMxCxDvH47sTylyRBrlsn++QmpAiaFPPfpi54OAuk+CfHo5lu85voEePwg5itZtuqaYOB3i82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmVtp9+kB7Llao0Zvgd/zbuHZ84fXkc3Wr4FhFVymbE=;
 b=XNLhux91xNroqX4LeQWS6rFOtXVNmCG4RU9Rvcoqwge3NnTtxkQs98muJQJaS1PqyrJt9CZ6nI9ds8q5zostiGtY2GIYWgC7p3NCTWXQhsGk8aUHBAwueDwW9VoQ2Fh+unaCkvBQ7L41C31cW6IwrBzSt4+i8aQYMnRIfN583YU=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by CH0PR10MB4889.namprd10.prod.outlook.com (2603:10b6:610:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Sat, 9 Dec
 2023 08:03:52 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::9bf4:a5ad:d9cd:f62d]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::9bf4:a5ad:d9cd:f62d%3]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 08:03:52 +0000
References: <20231129123947.4706-1-bagasdotme@gmail.com>
 <ZXP6kzbfUcLbBtCi@archie.me>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH v3] Documentation: xfs: consolidate XFS docs into its
 own subdirectory
Date:   Sat, 09 Dec 2023 13:30:29 +0530
In-reply-to: <ZXP6kzbfUcLbBtCi@archie.me>
Message-ID: <874jgryf8d.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::6) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:233::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|CH0PR10MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 462d87dd-d334-49f0-accd-08dbf88d61cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39Zo8WlErx2+JbmP1S4vVV3Z+n4xmc61u1sxpU+YeNGW/UttuSj05+wgDgqcHcw5EWHP+uByoMh3edINFsQMrA1wuZyYPLR+LJbCwjCfxeSrC7HsNL+N1Vw9YuxnE4TafidmUyuz0mHH+OEHIlo11NSkI0d8uKy9WmRyE5P5Ytr/RtI5x2ynw4nX8KNxrgdy0UK/y52SDgbvO6zA8etOWScekWc/sV92H3fWW7mWK/8jV+ExomSlZtY/EgorMV/qjICdPFZ5iQyMmGO7Idc7S9IVbqy9PqUzJhIbpIqzLnZlVwyUSD5VuF647v8ZUV1M0qt4Sd0iQ1IcZ3ld9IOrvznMI+sfYWpzzLgFWg4L7b9mZMQRNeoyWnPuYB7+Rc63W73yhdZAo3jFc3Mg17lZhpqyzMhtvXKQE+UoGgBLcvXpbz/auchYpsrhlxFRLZwPUB+TOOjYWYSY39iUaBEXMVwk9EJ8G3SQ3kF9XTFmZA0aSbS050ObKbGhYjRZxqVDTs0iLl7BhCRzujuXBzBw982JgFFc1GW/Py9trrqKVHCvEbWmPhal0IqOBChdrycB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66476007)(6916009)(38100700002)(33716001)(54906003)(66946007)(478600001)(316002)(4326008)(53546011)(8676002)(6666004)(8936002)(6486002)(86362001)(6506007)(4744005)(26005)(7416002)(107886003)(2906002)(83380400001)(41300700001)(5660300002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HbdjGqhqt1ord6yzuUNP0Y69AUKyf+wmruzDcR+DTdk0O0YuvllG04zlJDoF?=
 =?us-ascii?Q?YiuEHCwPcE1xXCLFCCrF9WYZBsWPhHBKJ8N/bHCsfymKpzkWcm1S+JBHSQ1E?=
 =?us-ascii?Q?6eP9NHTvTSsNzs4y+etON2BqKWGLXOcL/O93aKnVfhotPzEqZSLr1XtE+Nd0?=
 =?us-ascii?Q?7Q74Lf95qqGrfMgiYzbuQo3Ekt7TGI+lyRC6pmhBdANkf5clYd0szxt7Cnen?=
 =?us-ascii?Q?TDDWrBfCeEZ9MPRFOuIh2V+waW2EZWePwNuvBbDdj9HVnK1dcoNKh2tQqLxe?=
 =?us-ascii?Q?PTq2RGfRqoa1nXWYDlR4I5DIufXTdefgbPL4VWNZUBt7qKjW5h2xL5SHoBf9?=
 =?us-ascii?Q?kzW4Yj4oEazM3Yoy+SbxfbVC5XyoPVcyNhycdfos69PR+QuBjLdDz7oH4S2n?=
 =?us-ascii?Q?ae2Sts5faDnRDIsG1MPwSgmkX+oSQ5fhcH2G6xaIAFdKS/EtLWVyBkPg146E?=
 =?us-ascii?Q?jTEKN5lAUU/7PqWzxa6yetcbARJT16o4o/0Pqb8JmbSMX1PQeTHTLj6WOWb4?=
 =?us-ascii?Q?yt3dQqKQL6EpRE47Ctq7hWJlIfnrc0HmYXPU+kdNtCW7pAj3QaWx+okcT+pJ?=
 =?us-ascii?Q?yJJZd/xN+AJVoRnex1vD9Krq0fNZFiivHWSa1hwIZaV7egpru+BSpxlfTr4B?=
 =?us-ascii?Q?4O+PC1tIQKrAk7l1B18oXhuOm4u5I3Jz7SxKbC5qAlL09yKBM941DbBxjeH0?=
 =?us-ascii?Q?/NX60Fvw5UT+A62o5xopEDZ9PFHrxpTh+EVno37pTrhZTZEE0Qjj9JAT0zab?=
 =?us-ascii?Q?Zlhs6Ys6JYwi2XlZFewbzPaHGf3GjRaUthkD3zhEFU6d5Ir1VnPZE7XSHAhU?=
 =?us-ascii?Q?mFKzQzXRbKTbXCaC9EuDjFW2cwbf4v9xG62K5Mof7w+b+Lw9bUt+S5aHGziR?=
 =?us-ascii?Q?VqSIxqA/IMHWu+VofopDEBt95jEVlj9F2bjkZKJbS/0S6sMqLWxp2TSSnzbD?=
 =?us-ascii?Q?AqMyqJMTnCO/3O5gzgGR4TGm0lceQpb40kGbaJH2E6bfI0Zd3dJwmAKWxD0S?=
 =?us-ascii?Q?OMh7cHAalcqfAX45tqWEdovgds/P7rP7OBdiMJ1gUc9xT2qWCLQfn1ytYnKP?=
 =?us-ascii?Q?BkMZWE2v3dWe86tvf1hKbGGOJmG6ieN+qHmcDeBUx/MpzjdrweBDdbQxQMKI?=
 =?us-ascii?Q?LKv5UX071ydNyxrIN1kDGKuBElIUaRvV2QufaC6FE/IRPd2eZaDu6gGmA6s0?=
 =?us-ascii?Q?KF6a5mt4ndr/9ICgCHwvRHmNlQiMmUKANF1Jyy7zMrx2VufqV7NMfK1Dc0y/?=
 =?us-ascii?Q?WpILEb8e/Z0c5vMnJVc7Ocbbdvb1JkmAeurrb2c0IVTkm2RH63q9h+j+PTGa?=
 =?us-ascii?Q?dsn+nYk3nw7zpTFZgMpYKD0RPdyiAZVgD29hcrgwv0JDQzMDTQxcv9LuQTpJ?=
 =?us-ascii?Q?MjJd27GXAbryQdD3aeiHalGtb+Y8nfcpjoqT+oR2FQrOtdavRmuOp5TfsRpX?=
 =?us-ascii?Q?9OMZ5MXhVS4mpONvPzrIMCtARy7X/J2/iXGF0ChjXGaAAeme3geGPue1yc41?=
 =?us-ascii?Q?IuYSp/tcSbagBhDHoBjexF2AESe/SDls7o/WkSTgprWjDxFMdBaW31bEW7Gx?=
 =?us-ascii?Q?0uBKvw1Whm/ygys5/bMW8a5ea1HP7fiqXUlTOfCw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8Uv8xbiqhx9NPHic3cW6VAmJzr6BGhYrP0fkQlWiwifA75Whhz7vDISw68rJ?=
 =?us-ascii?Q?qThSDclvoKRYOl8+dOfq8nlIKAG/iv0QogYPSVGZYk+vzOeJyr/Ua13W9HrV?=
 =?us-ascii?Q?lZt23qvGTvrLbVQtWPzGFJ3kfxQoA/XyV8vzLevcsaMfscIwqzpO5qOnqiCC?=
 =?us-ascii?Q?c1EKwrqxSNKJ3sQviPrVfsFetLWym2yi8UpYGYAD0lr70oWApezlOXIVU4cV?=
 =?us-ascii?Q?FGj+/2+nJ2cj1b/0h+nc2dVMxRBZgkJbwhgtSkbpc5S7Y2YftAAnQvhRJqt6?=
 =?us-ascii?Q?EhKGkxlXxBrj3Of4vXZaizyQZ6/RBCfWGWgjaQakxIWH8KVUxGGkIH1fJLM0?=
 =?us-ascii?Q?5B+ioRQj2PhX9AzehwmoJMmn2AA9vdLB8PYclj3ur26jX4FV3z8Bb2CYyfcd?=
 =?us-ascii?Q?hfMVuqk7DWzNNzOHX/5B+DlD4WWM6xZBUIX35H4g0SHdAuna7LmxKpozofY/?=
 =?us-ascii?Q?r3ojWkCi4m4cfQBFar4C3QjbIwhTdsoeDppgNo+L3Ban/lX2seJNYL43IURZ?=
 =?us-ascii?Q?gi9M3E5iVO7QzEgBKpH0r/mtm2WeLzIdga+DPXj14LymIxhrrZ5QMDB0dTLu?=
 =?us-ascii?Q?/KJOBrbBcA1dB23ZFDhIOlckSrLTwoqWdjs+/nmiiW5vFKxRhL0J5RPmUcWV?=
 =?us-ascii?Q?VQ0WsUgbPyjcWC/0fRKzBa0hWPOTbGvz9avZvYqI8SupXzKHAXNUqD+3IXQu?=
 =?us-ascii?Q?RfUvSBakJDghVnl85PwW6BOix+1uGF4BTNKqUR2lFpzBJTma7oMhPSn65CGi?=
 =?us-ascii?Q?gBBDYwpQksJw6GPLPNL2W0uEVZgDcdzc5vW0+51NxfNbWq4fH7k4SZHpmFtZ?=
 =?us-ascii?Q?qhihGldPUJM3viwCu0T7fxq5wt5U7/v91YcWsYAjCUntNEX+duFGvGx788m7?=
 =?us-ascii?Q?8RlkWZ4Q7rzNy7BWKVbLmibWe0CZ9QY4GtUMmeeL7M/6nwqjGM+Y8iHErE5m?=
 =?us-ascii?Q?Q4X6RfrEHQ4NO3VQB2an06L/HoysWhgMaTTB22GCP9rpVPaIPX+s1IBdOoBg?=
 =?us-ascii?Q?Q4M1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462d87dd-d334-49f0-accd-08dbf88d61cc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 08:03:52.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2y+DsFaPlu+DUXruaglT3PiwOXQWVoI1BsgAg5CPVhycRqLENwa5b3h3vwFhVumsyIiHbr/A76Gj/LPBjb0mRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312090066
X-Proofpoint-ORIG-GUID: sNorzRcRHcrNF15ZRn4BkuJFxwWJq8e9
X-Proofpoint-GUID: sNorzRcRHcrNF15ZRn4BkuJFxwWJq8e9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 12:26:43 PM +0700, Bagas Sanjaya wrote:
> [[PGP Signed Part:No public key for F6B9894955514EA3 created at 2023-12-09T10:56:39+0530 using EDDSA]]
> On Wed, Nov 29, 2023 at 07:39:47PM +0700, Bagas Sanjaya wrote:
>> XFS docs are currently in upper-level Documentation/filesystems.
>> Although these are currently 4 docs, they are already outstanding as
>> a group and can be moved to its own subdirectory.
>> 
>> Consolidate them into Documentation/filesystems/xfs/.
>> 
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Hi Jon, Chandan, and Darrick,
>
> FYI, XFS tree [1] is not updated since 2 weeks ago (and this patch doesn't get
> picked up). Would you like to route this patch through docs-next tree or
> xfs/for-next?
>

This patch is part of a collection of patches that I am planning to include in
the pull request for v6.8-rc1. I am currently running fstests to make sure
that there are no regressions.

-- 
Chandan
