Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42EE7EC425
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344015AbjKONyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKONyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:54:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C0AC;
        Wed, 15 Nov 2023 05:54:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDlTT1013001;
        Wed, 15 Nov 2023 13:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6k1tQ/bvf0ow7Db/rQvw1SGSKK3H02M3rtPex+43VPQ=;
 b=Eh1uXwszE+sur1lD/7Evce1wIJ5bVzAHAHfb2esMrl/zV+5YHVUoynyBI7qrVT1h4PbX
 nqY1gp9VztrOFpXlaP5cRA02eoHrvszKVb0qLF8UUI2upgvlITdpQRh/3C8GRZpMwhHN
 c5eDXkM8Rmwir9R1fqEMuvzJvAA74l9bQgBzO/K2HPQs+SOY9yurUbWe8KZ1Ta2ZSyVg
 eNlhkK0PUrCHdj/GooQPm0ZBMXzX5pjbdHsFz/yoEHT1DhTnbJcrn6hgxiUXaJCPAeIi
 0DBnY3alFonMS4Aoe8I/aULK6k3e1Hxo5Yx0qHl6PMIpFLeJcCZuPWGZoH4ywcPW4Raz jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd8g49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:54:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDFPnS013049;
        Wed, 15 Nov 2023 13:54:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq1368v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyHFtQAunuiJxh5oBa5dVXmBKuOQDZABGh0CFHYuRHPOaC/9A+x8pKFm07pUgQx59pHnbxRAOX6Uyk3jzZ4cDOpGYgi9JCJU+S1RAy+jYcouKzDKVEoo7wQytrmWlWOTh6YygKG7xDCwRKr0CCwsDr+6s25oRg/HfoZgc2WFavvf9chT3QRhZWd+LUBE5jazINv1+7C73BPhEcXpDINUFmrN9TljeU3eyQOSU95XDV7kN5z+km4nG/Z6+rtA36HCJf44trK6QgnLcO1hoEU0eqKYjJVZ3lyfF2bhJTMEW5W21Q3e2eAdYCGDRwWs1yk8xzbIHehkzdc0uH4rKXnrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k1tQ/bvf0ow7Db/rQvw1SGSKK3H02M3rtPex+43VPQ=;
 b=PnouUnK9mafDb1xxz7fYVnYrk97uAUZ12p5NH3tSbsh/2NjaAjhMYzF0zAXIqvQoFtClCsS1/zivUoGScMVu+2147bTZEmeTn9ry6mGFomkfc8weHfvzDLj2WoD0I8soND0UhmN+Riw8vlCXI0xFHE2tKN40xviTuGWLDgU3THiS0JV8ke/W4/HMER6r4hIhaSVSocu6Pde/ALxlfwlik93SuVUEqp3HADkPgoTTapFZYJ8oo03PjpSA9q4DpccV8WO/tzOUyqjCKmj4+P/hTWli/nBEWv0hLyXKIWXIBNdIDZ7TMz+KqFjTMd6JM7JuawvSMta+eOaU7iRS8Kj+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k1tQ/bvf0ow7Db/rQvw1SGSKK3H02M3rtPex+43VPQ=;
 b=i2uyZ5nrvp+e8M22RlUMoe5dGq97vGA1Lw4oC6+aCmM+3UP/VIVjI3LIBt8LVNbhOfUw57Mwvji5KlJVnHfn/lN9h/RqXHX5paP3v5csVZAE39MZqvPb+m+bIdM8yvU7omwzeCMwdGb77u5gk6hzr7+H4CTz9qbMYn439OaY+2I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5372.namprd10.prod.outlook.com (2603:10b6:610:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 13:54:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 13:54:23 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        James Seo <james@equiv.tech>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a
 few cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7fv2kcx.fsf@ca-mkp.ca.oracle.com>
References: <20230806170604.16143-1-james@equiv.tech>
        <202310230929.494FD6E14E@keescook>
        <yq1il6vfoiu.fsf@ca-mkp.ca.oracle.com>
        <202310251533.1A27F79450@keescook>
Date:   Wed, 15 Nov 2023 08:54:22 -0500
In-Reply-To: <202310251533.1A27F79450@keescook> (Kees Cook's message of "Wed,
        25 Oct 2023 15:33:43 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0313.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4a0c0c-174f-4e3e-4b91-08dbe5e25fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVr2rqPF5/0TLHI+vfzI7CbmVN53NPCNhl/0HgB9/b3Txiu1aApTdyfu9XevgnnL5GZrFNcdF7JBVqP2p7F3hlBwWQQq9T99T+jwfaa0LaAmGI63913+yOWHZPTY5qRIRTxeSv60FO2MqqUZNGzBBz1PzcCfC57xKOlEaj5Zipqhqe03wMwobUYJuHUAI2YxHxGAGiF4x4eEXrcT4U7ubuODit6YAFe8c4OPpeVW7qJzsK4Z4mkvDuoEoYpoA9Aw9mk9aGvH608P59g7eg2vkqrzPJl3UZeV1hMdeMXgvN272JbRtkZQ3wptQ7I4QVoLBDIBKTjFynSWt4Milqg5sxRg1t1u9vOPGFULWWbAEXRlgr4iXvTi6rH3ctMJPX+qKQ0NXOslCaWA054xiqGp8g3J58v6+1Y/TCmMGMLay0XlqJYmPPjAa3g8ctQ9XsGoEnI8JlHGHFrrgRY5HbsPikcg7xYFUViuS0HDwybrlqmDaLlXcq/3D5Q6gtKFML1uOx4Be2GBm7YDYppuQa0Bu95b6tqZCQs4p4Pdpj8odEtHmj1aL/Ggez4410QXesA97M0ZvPvEMTdj1seOwkk6gFVMOLWQJg3VFhlKovZG6Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4326008)(2906002)(7416002)(8676002)(8936002)(26005)(478600001)(6916009)(6486002)(558084003)(86362001)(66946007)(5660300002)(316002)(54906003)(66556008)(66476007)(38100700002)(36916002)(41300700001)(6512007)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/MKgVVsrtnynpVazH8ob6eH5NkGSp7TuGaJKAGlLKDpYXpYsHHiwXjWbFBTv?=
 =?us-ascii?Q?gq1a4uHLdzZSj9/gIzfZq1uKheAwc3vWrNaoojrHyZhv+M7wuKjVvejHFLjG?=
 =?us-ascii?Q?WMqDWlPIvv7gsJB8XnEjGxeIspn/sUIvvicCqtQlgVCi1Qft4bQOI/b2kK3J?=
 =?us-ascii?Q?sdGFg4wDvLYd/W2KtbSwzN7KTzhmG4FfZKGBXgcvrejcG6oVO7muLwkNXgmQ?=
 =?us-ascii?Q?cR76mz/Trc1H2LvthOD6Qy6Hap/bZTAJBQVnzojG2djNOCeQZFzgcOxQZDis?=
 =?us-ascii?Q?C9kncHOkjWn+U8NHZLBDVayVFlXTpYotnTf1dX3OAygu50oLIsTQT2xgi+Se?=
 =?us-ascii?Q?SnpuOtaqSaIZYM1oiRA7mQHmxakV0EDJqJFEKMT6xnhqzDoskyoCpd6xbG4Y?=
 =?us-ascii?Q?7LSb34ymSJyUYU+I+rQv/mFqUvY/bW6TcG7wQIyKXHyUBybhz2j7WlxghaBJ?=
 =?us-ascii?Q?mHeWCQakeOmg4Uth7/EoUqlI2dEMbPeMoN2PBNRVV5iGKY3CEltQN4upzHP3?=
 =?us-ascii?Q?S5gWXauQGez5DulKNZ7mBbFTFVHK33IaKG07koPwSsIIBDaUl48Fe9D0F3/3?=
 =?us-ascii?Q?4sIzofa8jA6vWiODnyMjx4Mtzw9BdUJmVO2W7gZQCMCSFFIdGIEaS9g4bTeu?=
 =?us-ascii?Q?wzJKDsBTE0ia7ZDs6rKcqIzI4jFBLjM7MT1/x+VZvPmH4mqMIEab9Egeb39K?=
 =?us-ascii?Q?T1bX6BTdpb11UqFyGILQdrTGlMYHHV7sZo1d89CbVfjPYjXDD8NzZItCoVs+?=
 =?us-ascii?Q?r7+lhI3l0yTh4ftYrmCStoSWqSIdNJi8F2FyUTqWgCAR1JGYRGBVGMAhL9Qi?=
 =?us-ascii?Q?iM/6TXFlxInK/U7/fkgz8f3pAwnTaBPUg7K1xo8FoUjniBM8syp/Z81kvYia?=
 =?us-ascii?Q?OslGBYcAJQih9BxvF3k+1+1t+tndKSHcx2oQ/Pnz4tpWlZhW+ZPQaFZ7KuoZ?=
 =?us-ascii?Q?2oFdxXk78rpu3rFIeJggTTGTfMO0NbrNBdXlwe7lXSY+8PO8tcKrM0b+YZ79?=
 =?us-ascii?Q?dQnNqgApZS6n4pZe07jaH6naWOlktGT27OHtYSUjoWimY8efoyeyD6Kzfzyx?=
 =?us-ascii?Q?K/TfhzcdcqFCDgBka8asjhlMYjsno1mp2rK+9gVRbz7lIp3gesUNXLFgizR3?=
 =?us-ascii?Q?rWy5G1cknUfHkzOrZnii1p1iufQifrxPy0MHRziXdGZtazeT/Ru8ILWgR+zN?=
 =?us-ascii?Q?E7ibtdfld2cmUJrivUP6vVaTYHlOIywN7MNECjLRXlj7gqPqiBLP3HqfFM2M?=
 =?us-ascii?Q?+WS76p4MZGzItVju1iwVt6BfYitBhxuNSHbIpWcNci2WvEoGAvzaBvJi1wZN?=
 =?us-ascii?Q?XfqEajPSB5Yb4VngWyMqSdfgco3/5pgfnSPjX+EIwasz0ZINMo1DWBYHlP5c?=
 =?us-ascii?Q?zZ2sao0A/B/sOQSxEzSR8vtTqveEMZ2H0i6m2ERx0Nq0M3hruXLIZ+aYkJYB?=
 =?us-ascii?Q?qX4xJtFlWNhH2HrATF0C9pOHeHuid6bIxfHlA4iwj1A4+BUCZs5b4+PjLIzK?=
 =?us-ascii?Q?N0QmH50qXsDOcx7EULXDqjojGsK7BSQc3vaASvReSyNInVtVwGUXv1mM8rg8?=
 =?us-ascii?Q?E9sK97l1siNbRUN0xKdWTWITC/GBccQYzJPKZetFsBrMI/vDShH27bKiHLDH?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vBx9sMzn9+WIe4vkOOv87AD/cGXg4q/gDERywqvMbgQU6RWy8ExrCkmq8LzK?=
 =?us-ascii?Q?cnoFDAZrI02aqnEcXqdaN9gQbjSdCuX0ysNo5iijTsinPTy4fTwKJ3aEZZBS?=
 =?us-ascii?Q?p06uHUbUxVyDGt4jcOgvAMs1YzESMvge5hMFWdlqkpOym6AJSHxg07piW/z7?=
 =?us-ascii?Q?PGGTRh1SDytp3ZaniOjnW/xr76Cur4gfz6WEnHpwwae2vKMCJPf9my4fPL/L?=
 =?us-ascii?Q?lQp0/9ozbfvwzPmSx/Kco1Oj7sWlRSORbkiodXxDpjKRpjOmqjNBAo9XZGoC?=
 =?us-ascii?Q?NETdKSMXWliqHwCA6bHW8UluT9utU0/59FJl14kdbuX5KuHL1k9LQnhnLi4V?=
 =?us-ascii?Q?IYb/XmfYgk9nCVDx5FEyGRA6GC1asY027ERRHB+eaJffMg3UAXG02oa36PBm?=
 =?us-ascii?Q?emXP5e4D3OZeSKWce4UOaereWUW0edHQuAjeMGjB/RkIQKHU4+PMP610gBlt?=
 =?us-ascii?Q?ZtSIuB3XppGUBbHvNl0Glrjb6B4ry7yic+60afhXYWsNoJdCSHIUfJX+uleU?=
 =?us-ascii?Q?EV58c/HVBI65qR1Exf+gOX7hO6wttP3ui47pa5Wd1v+/VOekxXEHv4EliLAy?=
 =?us-ascii?Q?iYV72ivKIGUqtge8MrONfDjr7THaEueuVwJ0yRxlezl5Ilv4gJjqwo2lWwlD?=
 =?us-ascii?Q?H4Tm8pr0VXwfpRALv7zJMgKIXQp8PPuyjl3f+d6Cy9fPURDPQW2EStGDR1kT?=
 =?us-ascii?Q?lZxOtDEG0XoIIsLsKbhgGPLhtOsljd+xMz8+8TiqRsEoTVYeejxLzbzmuDTB?=
 =?us-ascii?Q?slZGcDa7YCd4OVu/3mpE9s9rwV6MzoEQbfP1by2vZt5IAMJjkV8bAhKyog5B?=
 =?us-ascii?Q?YyK2Osi84kZOmqI7+VngnOTbAB/CS8fejGu3SvyBMVywaut6i7VZjjOqQW33?=
 =?us-ascii?Q?1o2guEvwl6RVJaKq3Z/hZe5Pqruen87Pi+K4If3xtUF21X69+h1UEX+iDPIv?=
 =?us-ascii?Q?Ou/PH6XgmlCVkBoklGFGNzjghSfohy+kkZrlYRaGjcg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4a0c0c-174f-4e3e-4b91-08dbe5e25fbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:54:23.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2GO8HQNO112N9Sz30IUMWrIoHw3/MV3VEw3WA8IHtU3PwdJ6I0sD75Uo/Nzn2b4LR5nl7R9MZl6bTVhsfjs7PaZxK6IwBkhMRnHK96adNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=936 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150108
X-Proofpoint-ORIG-GUID: Kejr-HfJy-4JLPb6ZwMdGmE7f7JQB_9g
X-Proofpoint-GUID: Kejr-HfJy-4JLPb6ZwMdGmE7f7JQB_9g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

>> I'm a bit concerned bringing this in just before the merge window.
>> Please ping me if I forget to merge once -rc1 is out.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
