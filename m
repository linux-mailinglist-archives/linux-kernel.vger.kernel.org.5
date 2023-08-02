Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4676D4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjHBRON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHBROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:14:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA41AA;
        Wed,  2 Aug 2023 10:14:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HARhA004941;
        Wed, 2 Aug 2023 17:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FVAPj+Wis4CrtdWWfGGTH5mKvc78Ds416CZLRjOSiCs=;
 b=XMLc81llcSXLkbX2kB+h16qVj/mHiY47iQdXddvG94Il5YELukC/Fpx66ZJNqcIjt3g2
 9vMBW0ZVdd/nd0Ce15QVg+w2YonsxYWVq+h0mVfNaBHN7cw1LYv6C/yGZick4/GxV3Jn
 QGgi8IhWNEEKF+ucx9tbP2Us22tPIlDVMKvH1WF5Xerom5a0oaiIiVylROvBH0x7ngo7
 f1girw4OWTAlTCgv+j/SB2HNoDCEGg1nGJi/fegMtDCJT5bN4QSfP9w8CvNlHXMRCAa0
 TvuXFMQk0njGEwyHNKvYGlSoqKmcRhsqYEL1nuE0/TxfGX/+jrDYAQe8mtz25PmWhHJI rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e7sjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:13:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372GYhQM015773;
        Wed, 2 Aug 2023 17:13:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78f3rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvx9qseX63GOFldkCtiLjNuhhBV+BahWH7wRIzLKoFuQ1pzFlaUDv+OTq+IkOKSJPsAT3gUjIWa8Vp+z27mndUVyMXbFUTh6gPclqUuaK2I2BS4jxF8BYgJaP6G4EiKk8BY/MxOu3z8N5+oOCYk3YNTbNKr0BaTUBqWWlp2EbEa2K5OxAl6u3OccWz5zyWezaFDrPXn9Z8bKQ9hRnADwysFn4YJHnm9fMfUkzVp5HcSTBzhDuaP1T/cv0O/TNdniDpkWfqk6HeSDR1oIwk+UZjubdxwZ5rmvHI7Q1ZoFfAe8UQMGi71/ohW3jiUmj5HNLlSaQxLRGwzPV6q5HP8Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVAPj+Wis4CrtdWWfGGTH5mKvc78Ds416CZLRjOSiCs=;
 b=LhHqlrwigR3M98CZHF5aYk6a627u1ZURyqbYuEw9RKO1ImTnVIYP2puGUxZ0bi/rxIn86YFOFppCI3UTX/rhKSguyA+rUVYX3m4KTId+SvVg1GudTgXRlEtLwkT0tiPyRF7YW9iKGntWPECHBaYleUR9KYuxf7xpJNOi4F3hTAQAVz2I94Vs9VOEXVU3VXOB5PxEGkMcmTgJr1PwUxcpRncyxm5q9lqzFa6OGJC+rs4MrkQ2BLummoTpD2+hczRnq91Z56bLtwj0BCzZwRYJGuZ1ZKkkcPZ3wAiCjJBwVmhWFn4kyE4UbNJJbttiSSaUBOlDCYFXZJADhfdk/oPDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVAPj+Wis4CrtdWWfGGTH5mKvc78Ds416CZLRjOSiCs=;
 b=aDIfTOKNOicQE6RkGjsaH3125/Vom9aXwyUla08BOMbZ35Fn6xIBYLRXYVGVNRdgNYP/6PqmoY8J3+81e2qZpQJ7VeUSbh8FdWFIPaAcw1yP4z5NJ52WEItrhQV1VrAFlRrZOioqDbF+ysqDELoOKX6oEn8SjawSFWFjibDXyYQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 17:13:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:13:46 +0000
Date:   Wed, 2 Aug 2023 13:13:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm: replace mmap with vma write lock assertions
 when operating on a vma
Message-ID: <20230802171342.gq6bbybrqianxali@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20230801220733.1987762-1-surenb@google.com>
 <20230801220733.1987762-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-4-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: 560d9e17-3fd2-4fe1-7b6a-08db937bd4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ma66XewYsjiCqlXIajcDH7oOURpOT841SorwPoGEoAEmtWeDiKiKkUi7lqJd2Tq2IC/GQMlrt9stb7ZFtwKYW4nznzOQrgEQYo6QQMedza2EXbc5kly8nCxESBKaTzrORmTu0ExYGPx+qwkX1TMF9difF7BDjuDyj0uHt+Ud4y1tRDc6i38Hry81VCYJ5c5wulT5qvQQb7Htht2ABykpIW81vhJ/W8X6HyfF3n1qwqADxprBhVV+/OTYUYulS7CAierb77B0Qs+8ohrs3X1WR96oU9wBf3fdI5zHwRv7W3f62Ck4GvM0fTcj3gas3LPaEGQxtTMDihoaNHrctOBnEbTEetxnR7szN9x4FkIGtwieVuXeHWxAE23F+3r5IeSs3Zvkj0Sck49UpGRyDr4jBiSnTf4BduLz11vqWaQnrDs0puuu6XKlRJ+saE9fWI8U3WdtPWgWAA1yma/nOM180S1GkcvZmjwhxlksw9iJX89fNDOSQ8jmmq7P6VVsr9UJ/MbuNfzHiiVashH5ucJVzaXmccN97kYUjYJtRqJt7LXfQn2XHtSx8VFR+CZah4OA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(478600001)(86362001)(9686003)(6512007)(6666004)(6486002)(8676002)(8936002)(41300700001)(316002)(5660300002)(66556008)(4326008)(6916009)(66476007)(83380400001)(33716001)(7416002)(38100700002)(66946007)(26005)(1076003)(6506007)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ha9vJxQGGwvzx+i/MnATj1fMBAwJPZboQz4bl80Cu6fjS4c3aApkHPvlM+6e?=
 =?us-ascii?Q?mEvfPJ6B0/SlCPuEah4hLMp7U0n/5eqw7zwwRcQC8p9a/PwUEsH8um3DSm/B?=
 =?us-ascii?Q?mFFCadG+C+iVDN6WfzOU1fsHJHqNNL0tbGOA1Q+dHu7EuvnYW8Fv3NdKZkCl?=
 =?us-ascii?Q?I1lPorlfHFVzpw3O0tJtWIs36LcW/qhAbLhtRkt5DP4b9c2IdHs1HpteZ4ml?=
 =?us-ascii?Q?BhJhf4HdNebtaBHXqeUbiYCaSzLeYRGa8tJNoEYa+c7Pg0bsGrTkXWOApKdq?=
 =?us-ascii?Q?XXWXS1ndaAB9C8Pk7UmY10+DO5CG7yFVDlMTF1vqBclWjNNBq9tCYs3PQllZ?=
 =?us-ascii?Q?Pdla1lPhLvby0E4/AscNkqrqlLBjf2nN697vvCorlSIkSRsLo/jj45gPiAQg?=
 =?us-ascii?Q?jp33vb2rZtBqXaUkFqtSQlYPiYPDHPHagpaIrqB+vvn9uMlfrr9ScBWjTWwD?=
 =?us-ascii?Q?zGOzO9INzEvjgCtnQ+fMCEPoC9X4p4W7JTaS5JMPGkBcaQRxy/X3ZgEw04KN?=
 =?us-ascii?Q?yCmixsn86W6dI7rK3it8rmpjrhzUhQzjecttHRmxapubmSo/UDQY2Nxz3eFl?=
 =?us-ascii?Q?JPa9eT23yTt4qHBFVaB4bDKiHtn+1nJUpbsvCx7ZXq7vMw9SHA90RYjoLseH?=
 =?us-ascii?Q?W/Mt1fzda1FfjuoRB8FQZUBazgaB9HwM8Smjllo6XnbsNw9xLtRhRC71sJpB?=
 =?us-ascii?Q?QmLGo1T1lFap0CXONUnSdS8vrm73CtMdX7ca6c/m0WLDN0fTwfKSObWGFUiB?=
 =?us-ascii?Q?oBi9th4AE6Ld98tp1CRzvga+LHqi68bmICIfR4aIantJ9my6yJJ4HBhjp7N+?=
 =?us-ascii?Q?etkjBPCxGQryWei/tHTuKQ76HlVYhYNJkB1VGLe4qu5zOlkbQkMDx2y8TqJ0?=
 =?us-ascii?Q?oyH0oliu8zszaCqLki0tzqyjN3JQxb+IOh0w+HFGjEhmZDYW5murUYGyVFiM?=
 =?us-ascii?Q?7jNtDj/IOi+OejP9G4b2iojID7BvsEjsS+hfoEj2Ug35TiXPyPnqBjzqkJHF?=
 =?us-ascii?Q?mPdeNfQGlzFTSoG05Ni+ngTvnJSUmE20t7JeQOCD9zkYUK/WPDHwVK2j0ayM?=
 =?us-ascii?Q?GgVbXR+oiDLHaSkoZTKczZ5FtevqcxEViJMAXwypqTa2FCmeThh7eWg511Yw?=
 =?us-ascii?Q?pVUm9PE7vrrsR06NhHsCI5jfIt5ljKJyRpBVLA5GQKBKipjsslKx1YaMdvk5?=
 =?us-ascii?Q?AvyWNn7yI6ejJZnUEXoO8dWORswEi4NiylqJaO27oYDHzO+fy0BT11EyDcqU?=
 =?us-ascii?Q?ewMrOUZ0gOohJo+94tMevq8+G4XjOFxuQg0yZ7J/crRTz/OvcwYRdVf67Ev/?=
 =?us-ascii?Q?OnhiqSwqvUncCIabql7Fn9KiP8Wsu9EyPCOfEadYdAdaHrbH6SL2u5lGc9Kf?=
 =?us-ascii?Q?+5bBG8hFwFs83o5RYe0Pl2nkdgtjA8JJB3Idvcci4GjlEhURHgpvxFXdK7lC?=
 =?us-ascii?Q?jC78CV8ptQZoK+7vXjWWOcOG2o/yvTJvrpRWrKNnzui/JX8AekrzVtXljUQh?=
 =?us-ascii?Q?QGeAzPnN+6FAfsFeDGE9hfTxfQrbmoGBxiquP8vtwsE6sR04tjUhlNTbAH1D?=
 =?us-ascii?Q?bBq6QKE3ofJ3Sso9MzqaVpRSeCcCv6ujbp9Hvt4Zoc7avGkRzbXaEqDp+zJo?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tbVC9+UxAPSJg/LouRlNgICY9VTMJLpNGRzZJa8k/KGi90bFDjOZhR7utehr?=
 =?us-ascii?Q?hSTe2S728xvF7c9TaMpgbZ3fYIHPbMN0w+IBnFVfNUcTgCdlM4rfNztusBsR?=
 =?us-ascii?Q?MUYn3NqvGxjI4/w1+b4Jyl6PX/iKkhfaqYtqW8I140pN+BDeBNyTonCLrcIQ?=
 =?us-ascii?Q?ruFAGFOdD2vHW2Rz1atRl/ovtVva2+QNmqHtjLYXhL/179v/4ezzxxC0eZvP?=
 =?us-ascii?Q?s9qivGDFeF5Lg/FRGuY9euuQ6tswX4x8IN9OZEPoOIp8QKjEhzmWSKH4z/0F?=
 =?us-ascii?Q?FBqVZ6eCKKYtI5kPhZjezoGqEpzvons5Le8OnRgZJ1OoeeIXnBz2DYvXGBt+?=
 =?us-ascii?Q?Hdk1Cl3gzv1Fl02B45zRMnrUsoRVP4esqmr6ZlDyfstb7C/UqpF6cFBtZ+s9?=
 =?us-ascii?Q?AF/wJ0xV8BAiHdFE8k7gVkwYPQvKYDWmqnDow4L5V3RvG/8L+Bqq8YDK2Auy?=
 =?us-ascii?Q?sIaJbHwwY3UevYyCiPik1u5/6hnfrbB8qM3UU/0ZpBjD1FvbkmYfmG5UzQrx?=
 =?us-ascii?Q?QrFFubOcxRJBoLon47kXyMw1IZy5sZ8b6Ywg+QWgz8qO3cbfuKynfWmYMCrg?=
 =?us-ascii?Q?wjEbX3ENZLNFcXzEVWUSRvcNndVpQiEScjyXO/uJCR9Hj2WtuUBFF98JHO6g?=
 =?us-ascii?Q?FkWyt2vkjI52daR1pxf4dfkjS2l61DIhGYi+wVmbu9cxjz2Up7Cs1Yi2Oem9?=
 =?us-ascii?Q?4VlO6mZdPEDQCSrsGKeIbKa8Kpxm9rvU2+gKCuw1H7V0DMpChoB/ZY1dGIkM?=
 =?us-ascii?Q?BejvMO0HMktkPCM+2SkuRHwGPQIs5kGZlyXb238vx3De6gz9PpIwubD85ew2?=
 =?us-ascii?Q?XCMH0/Rk8mWmKJGnMcxeLam9bTr6UWkVl80Uz2jbG8TZYlM7qmhFWoYfSxyB?=
 =?us-ascii?Q?HRASkKqfQtTMXgmRUVRazk9mcxRvegwHVoGlLHJ0FFfaJSNz9M8kq4njK3k7?=
 =?us-ascii?Q?ni2N2kpHJuM246c5gMHKIrt179mbrh7YpJ7JVMEN4E010qWjCngmUuQ1xTKS?=
 =?us-ascii?Q?FWhVDi+Qa1KpaBmHQVybVEtJlSJek3QTmqeGYKM0TTvDTtaVPJnqDh/racqn?=
 =?us-ascii?Q?YbxgTqVR5GBtqa3kJ6kmjm+Ck7wcEfMJl+MGVU4rCALkFjH6k6fgFefKoBXr?=
 =?us-ascii?Q?VWUUB1EgtIMn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560d9e17-3fd2-4fe1-7b6a-08db937bd4c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:46.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7s88UfeTS5rPaaqUJ4kcyS5T3VqIwkO08RID7sR+mby0ecSv0ue44l0+4eCOE+tiK3uKY7hDdijmQzW/MGpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=634 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020153
X-Proofpoint-GUID: _yqQIeaCKQOnEPxiErrntGk34_2LIR2Z
X-Proofpoint-ORIG-GUID: _yqQIeaCKQOnEPxiErrntGk34_2LIR2Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230801 18:07]:
> Vma write lock assertion always includes mmap write lock assertion and
> additional vma lock checks when per-VMA locks are enabled. Replace
> weaker mmap_assert_write_locked() assertions with stronger
> vma_assert_write_locked() ones when we are operating on a vma which
> is expected to be locked.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/hugetlb.c    | 2 +-
>  mm/khugepaged.c | 5 +++--
>  mm/memory.c     | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..1d871a1167d8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5028,7 +5028,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  					src_vma->vm_start,
>  					src_vma->vm_end);
>  		mmu_notifier_invalidate_range_start(&range);
> -		mmap_assert_write_locked(src);
> +		vma_assert_write_locked(src_vma);
>  		raw_write_seqcount_begin(&src->write_protect_seq);
>  	} else {
>  		/*
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 78c8d5d8b628..1e43a56fba31 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1495,7 +1495,7 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	};
>  
>  	VM_BUG_ON(!PageTransHuge(hpage));
> -	mmap_assert_write_locked(vma->vm_mm);
> +	vma_assert_write_locked(vma);
>  
>  	if (do_set_pmd(&vmf, hpage))
>  		return SCAN_FAIL;
> @@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>  	pmd_t pmd;
>  	struct mmu_notifier_range range;
>  
> -	mmap_assert_write_locked(mm);
> +	vma_assert_write_locked(vma);
>  	if (vma->vm_file)
>  		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
>  	/*
> @@ -1570,6 +1570,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	int count = 0, result = SCAN_FAIL;
>  	int i;
>  
> +	/* Ensure vma can't change, it will be locked below after checks */
>  	mmap_assert_write_locked(mm);
>  
>  	/* Fast check before locking page if already PMD-mapped */
> diff --git a/mm/memory.c b/mm/memory.c
> index 603b2f419948..652d99b9858a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1312,7 +1312,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  		 * Use the raw variant of the seqcount_t write API to avoid
>  		 * lockdep complaining about preemptibility.
>  		 */
> -		mmap_assert_write_locked(src_mm);
> +		vma_assert_write_locked(src_vma);
>  		raw_write_seqcount_begin(&src_mm->write_protect_seq);
>  	}
>  
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
