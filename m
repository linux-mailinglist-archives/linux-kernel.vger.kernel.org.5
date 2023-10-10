Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F597BF045
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379331AbjJJB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbjJJB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:29:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19749D;
        Mon,  9 Oct 2023 18:29:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NxX4I012702;
        Tue, 10 Oct 2023 01:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=sNDl7ZVNwBUdxaIe/7o1HH1BBWFNwBSmPx1ktzXIr3T5Xa6HfgZXi1ndOlyVXHvz+rZx
 ZHMeOA1wP1/j8PmVxloIE/BrGXT1e+QQklD7+/Vt7jThj60W4lZcfxuwRFvaWqC47C0x
 IaqfBpTUJ6zKTK5nOUCz7pKPd7HOiiaf3Ycyj7FAOPyxuntcPrEs0Y78MHY6YPIXTIIL
 L+Uv4IQiIUpSqFr75HtKvDD7Ybo2Meyke/pYgvXc1QJ9lZwjHZJ/q2mTwSBGJ2x9pier
 fxu9dFeODnN936pWJf1rqrw0iA2xnn07F9UFNdJfLQAiDZqt9PeCiCYOvt3+bdMAtU9Q Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvukwtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:29:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A19eUB015079;
        Tue, 10 Oct 2023 01:29:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws62e9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBgMCPfPtqsHUI8SKBJ1yki2zPC7oBpsq5kZpBxgyIRu5T1yvGAltPdPUYDO1tOjTM3Pol/+mbHBxa2sU8xSSwv+lHiMlynuXHATFu3vbzcLMdVrX6LdcLATCBg64i/GG62tr14mHLzbrKxTmLcsr03tLaUHQr1t5NJ+ETWmcO8hXt74P1miZ4nJuDP5e1MpUWQw9YigMmGSjF/7kYGLgUORLRhNwF1+B4VhiyTNG2hc8npES8AF0MHZ2gwVXRVoE3pknobTwLPanSQCPEcRwA0+XhEVdHS+DSZvIX83/JKGrXoKMj45C5d+TcAqMZiFxbitgA4kntuvxpvi3bF/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=EIZXKMQYvvKXfla2sOEbwFEUhsLYOZCVii54nvcJwqRQwKCvNePLaMGd6IDQthLG7viJ/j+bqQeD3ev4RtpY4ipCtj96Rhc1pupbvI9mBIwb+zN/yhPkowO+Sle5vAARpr9O8VU7Ziz05cInajY+y8ncusD2yfI3T/GCjw/b3i7I72MaBCY3Lnfrdugjb5cUrCQS+Rkas4f/YyxXkTgwcgokrd5Bbtizq/VwC25xH+KC8eFQdSXAhW6UnhpbMaAa/hVEgWotQt/x1w+gdtyvATEfxdJtNI63vMyZ8oTLP9UlNuVptAi8iN0/AS3UUeYfndI82O3/pDtNGL9KbRdxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uErNPlCttzdTbQKjixbwlncWSOrvVGllj37yo0rxM/0=;
 b=gsnHdty6bXJmdgrtgnd8VfPE0WCdttsJfGm7PcJkVWHjjOvuj7IaL5BBYrT/RxdFJ205rrhUUy4s/IvhGNgzmHZgkYv3hh2gE/vXRFmqs+O42x6eBKlWPrZBxrE/nM28sPCi6Rbg3qV/wsp2S8sFJ3Yk7EjA2JEh1joG5WF51CE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6205.namprd10.prod.outlook.com (2603:10b6:8:88::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 01:29:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 01:29:34 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: message: fusion: replace deprecated strncpy with
 strscpy_pad
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18r8bp8nf.fsf@ca-mkp.ca.oracle.com>
References: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
Date:   Mon, 09 Oct 2023 21:29:32 -0400
In-Reply-To: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
        (Justin Stitt's message of "Wed, 27 Sep 2023 04:06:09 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b9b32f-5586-423b-61a7-08dbc9305c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVRt1yviYDwPINtaZAsGyTmafDEhW+AKfB+2gYJgCx8hRrtz+2Oy9K+X7j0uee9+ANJr6J0/yHykijmYZR1wqBLDtwSkd8CnOLmAudenuXfn7/y3VhADBTvND5NQJh5EQ5FPcf02EonGhQcwfVXsL5CYcWX3RYRRlm5aogUaZQsi9q93I6c0hMw4fX7Z+cF9RiZ4+2haH4siWQt7EvndqKnXizt6GJAjc6QClgEls/vHHejluH+n/Rps+Dyxgc4+crX4C9V7gz4XlLMexsOJNdgQvhNAGs5ZcZaLPkHufOHXv3nIHb7605dOjzcucgZEsUyoCO4IYjxfEqcbwpJT44rmj8G1PJ0AgjZ0Au8MqtgZz/lXMN2OchTRYPfqK5zgnvuv9CNE789Ck94AwjoFJ5qnLT0cq4x7tUoPvcxCvYO6NcPZ2bAtLyNZQSCFCi2qdFAJfIZLGqXjM2mp12nib6+kbGYaGZCdZzr+1iIyKL4r9y3WLf8FuRw3V9HKmqB8EOU1FGi6eUxuUWAOvFEPQKY/PoHSyfi+JXTxdz/YSi6f/pGIMergI0Obu6aDb3Hs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(66476007)(66556008)(66946007)(54906003)(6916009)(38100700002)(6486002)(41300700001)(5660300002)(8936002)(4326008)(8676002)(558084003)(36916002)(6506007)(86362001)(6512007)(2906002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BT28aWWC06NIgnrLdEYjNfaY83ObkmPUMVZchy9vOewcihp6NLmtKBGuA293?=
 =?us-ascii?Q?l4YThfnIq0OTITrmt7piv+EEkF4E7PW2jb8OVesedXBU8kYeeZ/a6j7/90wY?=
 =?us-ascii?Q?XthGqMEClQt5131WRXmVOPpWD3+ujQxQF8tT3eXbz97TuTFROndNuOl4pq84?=
 =?us-ascii?Q?w96qooekSt3alEoAyMFO+LAV9IY/EV1kxXDwwBCsPoxvCrrLZmrU5Kxh8rMn?=
 =?us-ascii?Q?qdwSIskvFEkKd0Blod2beRkLRTyh99P1X88gOqgtWpG9HQeWMtgw9+3hj/JZ?=
 =?us-ascii?Q?486R9kHkIHGeHLAMh4k2FHJrZOlIMar16RZMUih8GNVrudylCxIgpSsXlPX4?=
 =?us-ascii?Q?s6RybyinFxa6aHN8QSuRn2jKVT/MeRf9sZAuva+PAlrdhOdhd4McxTN+HlTx?=
 =?us-ascii?Q?mZWO6A8wMRUjvfV9DOAZH46O2HtamCLD2hEt/LAqq7JjCCqILyqMmLtC56tZ?=
 =?us-ascii?Q?R3P3PXDcrHdBQDH64AnF95Mh6KIIBvSTeW0RR3bVQJOqan+0rAktuWnimFM2?=
 =?us-ascii?Q?jxDGLKO0K/2HIzHgZ5IB2LCAp6N79R5oquE8OnWaOF45eSLVhHXHEQJydS1w?=
 =?us-ascii?Q?EnWko1tzYVEqhHojaMHDN3ZQtZX8JkSBWZlI9mzFiFPLUBDi8PzrBIsZp1gL?=
 =?us-ascii?Q?ZL0P/lo6yaPFtQwL5sUTexn+Iv/s6bEZrUaPbXyuhDa0C6QMvcQdJwzTxD4b?=
 =?us-ascii?Q?4Wv3z6ERIcNgl0hFyNkJxOZ6DD6hhsZuoYl3qrO/DARJvAHtqFE1V7+PNYeI?=
 =?us-ascii?Q?TRUGL2qHnbm6s4qoRiUt88IcC4ryFx5OzZ9M1IykH5ksaNyu7XH7HLdmoN5R?=
 =?us-ascii?Q?Fnj7QpxfA+Vd2Cez3/KzOgQ8Hniqwa6Zca9Wbsra1gLKJOnAnzvOGFngMIry?=
 =?us-ascii?Q?63cEkBp+VwxGFLymY9hAszSFvaaHWrmRg8JkR17RdxnqrsXnByfJAEvy2QrV?=
 =?us-ascii?Q?O2tsWdNTcyHyPeY8ROGR0eHqJVo2rdkQIZRi1pYpSwsIqMwoO0IEoUB674wn?=
 =?us-ascii?Q?sxEJcBlKYo0ITdHtonl+Sb9x4GnbV6KufRilcsOs76qcnzwH8qOCYjaLclyB?=
 =?us-ascii?Q?vvAT2adwII4by50LLFMw70YsjENyszTOkLEB0Llbqx7ScaTc2P3Q4y3jgrey?=
 =?us-ascii?Q?SN0xFQWNadIR5n28VtzNeB2QWXyRrSogxekfBYF8s6SKUKDnqNBYlEhJ+tCE?=
 =?us-ascii?Q?D7SMfzURFbJP4aMd8pZciOTlhwf85tULgWhjWSY8fp9up5sAI2TjkwFXJhbZ?=
 =?us-ascii?Q?TEtMoFtqZNW9nxjYAArZSl4Lv4EWugBqadDSyf5ZrgYFMCeulf09QMBsGjcF?=
 =?us-ascii?Q?Mjzj6gwfSp+Huzi4d8lCPnWXblNkpOCFL05HKDoNa2J4dS4lyU1O2C1iJKlU?=
 =?us-ascii?Q?5e0VNIvbGCELBm4Y3tVmq4TBO5YwVKFyRroVh6fRLkaKYFHwvPcOM4/oJXUD?=
 =?us-ascii?Q?hyyUytseGzeTsslWKB+YGFmXpLhZpArYLB6iFFUjrkiBFCaayGqRjqzp7wSd?=
 =?us-ascii?Q?H3o6y/SWTabnBSMee4NcZN9ia1d5pQXGk7snpDY9LpKafWDJXikemlSuojn5?=
 =?us-ascii?Q?4//Eicy/Gr39HFd6QluajQ9CNnK+Ko01Q5fgNRqaV/4HGFzLNhpahcqm0G+j?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LnlLL9bobTKTWLBXeKkkQfxgGcLbYRNdLX4Y8V/yR/puizRtMhn2K5+ve5fcmDodQ+1pDYGHjDkK4jnmioc1t0wIzNBp+XWhXiZUVeVFjWIn0PYPxn0Fbe4NaOYoGf0yKdVI9OvPA29xQ7cch2UlXaX133y1eukkTRQQ7BvG4agbgevsww+Hp6iOveAJFuUg7YZzrCNnWp7OPbNSzxwikxceGrqwV4d/2QdvuGEXuH09pxOzn4QqYBj5fVkHqyeGUxCESMwAAqps4JBuyQbrA9AtjuwVbNHHIrIPO87t0zraTNiSLpvl4EJuF+GQsZHOSEKcaV+wR3VNNux5Eu6bP9RxYuDrcVj5NHHLRyMMl6yiBSoS47gVkZZXng8C8AuVartjErRj/PY6wcRFW9wk0c3F82GVKao5DWBFQ5YHt7fOkCcPACdwqUdOl3O9+c9hgRe1eKAs2tImEG2NtN+L2OOK28kBBJSGx7Nw6a09AaJ7o12dTVl4BTD25Q3YBBGGOoxN8kW3TNP97LKrQHqIIG6qpUrTv7gpPFoATQb6zGwsF8PPqelnP+fahJUbryJqpdBlC1AZWFRYLVgqpt7TgiYNznQM9e+kgmynn3BZDDmM4Qb41NxvQwWfnT53nA30FuxRif/Wq9tK48disHk5fdVQOU+MeszeAbMGBqC6QNwGOuMHKZZ2QZujSwPiacpwFrIwKSon6JBqHAwQCT8aYMsLDxI45GCBjN0ADwqL2I1ZdEAr5xfnZCBRMLjMeJzVOLcKsY5W49kwWsWRhdeCc7BhyMjYMog9Ztil42nuyI0czQpwOSx1dB0a/UNkImsfBkG1tEkivy/n72AmZIFhISOy5V4VvS+VUFNdxyb85Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b9b32f-5586-423b-61a7-08dbc9305c16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:29:34.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNpg/Xtbt651UvPv1ypFidRbcRXLcxRiy7WUob53k7N+KcJxAH0lNPu0CjTRjNLYtL6D2uK7lXgsplBKNulWOEulg8G7ZmVbqNCwmHrE6s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=787 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100009
X-Proofpoint-ORIG-GUID: t0snkqFKrQ7ociiW0RDX9jQYfb5m-AgM
X-Proofpoint-GUID: t0snkqFKrQ7ociiW0RDX9jQYfb5m-AgM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
