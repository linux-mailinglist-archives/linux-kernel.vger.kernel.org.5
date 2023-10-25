Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986D7D600A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjJYCoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYCoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:44:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9A129;
        Tue, 24 Oct 2023 19:44:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUthB019987;
        Wed, 25 Oct 2023 02:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=iEL8GB8Kvbqpc7OQ3dN8SIRQpRPaixSs6xSmuYDvCsU=;
 b=mSdey8YXAHIz+/i4USMrS2cEWWQoAD7pGvVsIu1z8VWNijUsPyhIjpTtYyuHPRDBsmGO
 keUbxwkCdye9t2b81DO0j6w9lT2eDTamBrw3x2l3aTiNBjp0KUcWcsxLp9EPP6DYxkZz
 6EsGCQzqGEJDPnE/7pnBiK7bmXhB6WsruU9VqjFt45fvwGZxdU3vGuXPtWhNe9HsRa7h
 9R5Bfq66oOOgYhFxQD2vDAE7dJNovAOURqmVJStJcdxK8hiwoz7fm0L7uYqbdR5SPWsV
 oqCuqk81XqNwxx04PBTr1CSsX0HWKMOCLjQloBA+AOajG+zaqbx/nRxuBj78+SBAtlVM kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68teqfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:43:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P030W8031193;
        Wed, 25 Oct 2023 02:43:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53cjnbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnnlQCvAdpRQUTjXOpoAjYow+ICwRHA6VNM11FQeFoVhzq3z8/NYovsy3bzU6OyfkY1j4OyakMsgEKHDy7CUheLJ2rxDhy4iYM+w7ry8L68QQ3t6Z69+Lw6MeICYUDev9SqjDugohgRe9DFgaiDWJORBYLCsJcJVVg6QtV+v7iz3ZXf+lPqXYQF28SabJ7Iw/q5e9Fel/s/nbFI+qqKo9QEycv3PnO0pf+HdBNUky78AqwqjFjTn3+b+p6cOGlUBZo8mGl4piOy7c0x6SqHxSuH4XFHaaaTVq/J//XBoAwMGcxcEUTAcD3psiDYos/JZzTVNqrBj8Dar607mqDEzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEL8GB8Kvbqpc7OQ3dN8SIRQpRPaixSs6xSmuYDvCsU=;
 b=flqsVCmXQiVN/EYQkB588r8GPjFCtO4TIm3EuYq3L8zXRICRTSDd6im/Ua1wzLKK9C/NHIuXKfRbqOr3KHMiXQFoSH0IKawTxcSDwRd2lZ8dgxYzTb/JkhuDXOIMcAijN9O0B4z1CGoX2JQ3s8CoJvJZ7Q5dCM+Qf3RZLlZR5LuT7ycN1ROeTtAbePF4bv+EBBr5hccNAaiR6fYwh1KdaLqp1V7GWyTgzBP9zeTc76+ZWLh9ePl1KyQcwLP/b+/guZ60+xs7pPBVVjg7awUqCho+4X53VZMLhjaCnJOuYsdkxB7SAmH/fEYobubwW3BkFwgDQgXmgxLba4dRZjZRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEL8GB8Kvbqpc7OQ3dN8SIRQpRPaixSs6xSmuYDvCsU=;
 b=BkaC7ui4dsZAN/FYcgMFAXEarlIYSsl+qKrw7lqYDCxKSLXuD87OAtCme6ra4o/ZYhn6AmHkrlNbMm5vbGuqf3MhRFa8W7v/nX+OWukgjiNJZyj/8ehAKAXvXVjR382NDtkAy/puPs3O+6zigBwmkWR9cTzeWW9HFyc1BLY6jEs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB7401.namprd10.prod.outlook.com (2603:10b6:8:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 02:43:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:43:43 +0000
To:     <alice.chao@mediatek.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <cc.chou@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <casper.li@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/1] core: ufs: fix racing issue between force complete
 and isr
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1frctgw.fsf@ca-mkp.ca.oracle.com>
References: <20231024084324.12197-1-alice.chao@mediatek.com>
Date:   Tue, 24 Oct 2023 22:43:41 -0400
In-Reply-To: <20231024084324.12197-1-alice.chao@mediatek.com> (alice chao's
        message of "Tue, 24 Oct 2023 16:43:21 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: db74223e-04ac-4cc6-6d81-08dbd5043406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvH9UMnjUCdy8rwckZ+JYEWnt5350TIGfUvNyb02ju1rpIkLRiN46n2WCPqi5CYRXCBhlR+xNv4T2hU/k9en/6IV6iLup9BEsdobly6dvicUiS3MCOSgbgXISVYUHrPX0L3041SgQm89+j+fKLVeGgdXfhtSQ5HJaiGeqghByCqRma4Mw7JVK7+a5XjI6gwU7uU94OCBZa9J/pDoNEvBfs8qXmBZxA+Jne//LUx6JPmgE5uNlJd9ghW5BW1AWH/bVJSI02RDYNW9SOobM24sWFsZfXuP+oNwQ9sg+jqd6iEUiWC4lnmRHYyiqqqB8l41jt0rDROXeIkg3eNuDxlkXJmJ5EQEEfne8lxdWykySItp9IJN7I1BRHZojKwYnuElRfX5jmYWSW5h2b6fkad3SYqmyoBb9X/SkPQJ7Pm9kA8qtb/+PBTVShbECzPKckvc9wbMyKYxKTegwfVPKDBcShTFjWHYr/HdsZ5ad2ZpCJ3oho0HguYgt6ZescQXRshpultsYpcAAOIbZneDlpgTb07RTG0kTvyVaYW1ITFFnC5fnWBVSBxPQNnwoFLuTL25
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(478600001)(6512007)(86362001)(6506007)(316002)(6916009)(54906003)(66946007)(66476007)(66556008)(38100700002)(558084003)(6486002)(2906002)(8676002)(7416002)(4326008)(8936002)(5660300002)(41300700001)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkD8aii4t0L4aKCiFud4bXrD2dL5M0muce5YpLCHIMuc24cXZaYiiAJdG13K?=
 =?us-ascii?Q?3H3Mkgazj5gcafKx1NzcZOwFd9tC42JBxYC6Ww79wCafcnAQZhogjAyWAZgO?=
 =?us-ascii?Q?N2ZpMtLhE0ff79vtao8y9qccniXJOQHNOL28jIp7ggaWbM7VDRbKyTx8+9dG?=
 =?us-ascii?Q?Tmb59zXVBfhLUGvbU3N+F6t1W/tl8LgGa9BUMzr7lTBNRK4LVbK4TTy+Fpaa?=
 =?us-ascii?Q?q0rwNR8luaJVouE5K/WGGyVAb8UMLzcnHEcOlKlv8teFgnrYiJRXlMZxuEg8?=
 =?us-ascii?Q?eoTxrpNNzSGGP1z2GEZuDisDw59tkwZwJjQvyf6kef6PRVWZZ15K+wj6FRAs?=
 =?us-ascii?Q?pTRnHXFX3FHkcFdbeBID2z4U1N7bllB/UaIhCPRfX/l5KNm8L+lTIsLqki+X?=
 =?us-ascii?Q?we/pIH68eV8Qln7LqsQfty4ZQEud6vmtgGrHPNozNzT2k3yGvlH0e6PbuDIi?=
 =?us-ascii?Q?Wetj2m8JbX+l6FRjnT5rP1gsizNdTntCYnu9ZLU1iaRG4Xi0rwzNxHC8xJwI?=
 =?us-ascii?Q?l7gx4V3/VZUZAWJCC05kgwJpg3LDOwC2/Y8O9Z+Z2hQcO6ZdJMnseGoKv2vh?=
 =?us-ascii?Q?4Flm/qWHO6xykwzR2L35V3IrH+4mMJiqYyIYaz032QlD53jQPu+Dwm3YO4Zr?=
 =?us-ascii?Q?trXVCzLQZ5u79mAWLgvhGiLsrLGgWBT6h0J5ZsZHr/6s/hE4AD6dcTWfCUgG?=
 =?us-ascii?Q?eT/1s4H8h1y6b+NAGI2fSmv3CBY1Gut5gGgOYzAQSvJ2oL66aMn4F4gr39OY?=
 =?us-ascii?Q?IbhRRAMeGlbiP4tgeSQB1TGtYCEgTdAU3K4PZVcO/ZngyAzbOG9XUFLJKn9w?=
 =?us-ascii?Q?NFSqjDFCVt+h8YSOpxWv6+VqkIj6eIFEOkk5v+lWgWmwETkYhcK4ZSxfSFiL?=
 =?us-ascii?Q?fk34N8v3e9Zm07Z2JN+30XPOToFByS12P6e1diLqqjFkKbB2J2nkHJdtnrvR?=
 =?us-ascii?Q?sNxlbGeNWJ/mdD6iZe9WelVaqEmrNYmMaHNqYH/6Ci4JlHf6q54E9JwOWQSt?=
 =?us-ascii?Q?5KPXAblv1FMsryLLwb4HJks63zSSM38fXFcxDc/GmFiw3IrhO9HTlECotdzm?=
 =?us-ascii?Q?6j78AiXx3/BfJzoGHNbLFY/lHk1STbmxWLs7PWeDIn7uklxd31b+1mLzZCQD?=
 =?us-ascii?Q?7FJLH86jz7eMVopbsSazggw+rBGjvrbHE0N+futyyjMn/qTkMs08t7gQ9j6E?=
 =?us-ascii?Q?4GBr4gOtwiUqV5Hhcj6C2vdUU1RWnBdX0/H0OmNkvzgujXug0+06Gmoooud+?=
 =?us-ascii?Q?TZJ1rPi/uyUPk34mevy+GT5IEcb+EmV5SJR2nmwEJ4MTsVmGgSPrNVqzgjN7?=
 =?us-ascii?Q?SJPmcA8etZ4nhvFpxq+ncd0ZpXxBFIaoH+Kdnfbc6yImIwJVRMgTXKhlTB9+?=
 =?us-ascii?Q?MH+V/ZRcqVzhEP7i+hn9Bp6vyU7Zjn0N6BSlgnEa4GWHwaXGhm22k6r7Z3v5?=
 =?us-ascii?Q?TnBqutOphfNBzq+iMU8y7Rn9Lf6uS33AO3uRpULXi/Lx1tEs3IJkUxlVNaRu?=
 =?us-ascii?Q?twTi2O2NkjKE+zkCVZQHILiLGGs+Ht2cVpmTocwT4M5dzWoAN7+z/GPBaUEl?=
 =?us-ascii?Q?ej4Ga4IhyT7GxYeyECpkvkIMc2G1y4urDax0iPXUgRsZutVSlmNby3fG2bKi?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/gmH9x7cMDrvWmTnEx7UdWl/plcqwnJyqe2zNXS55vI2gxBKznQRoixjzI/z?=
 =?us-ascii?Q?z1xBm4jHoAHR5eF27jZNohDMb8vzxTvL0ohHDE2bo1vYioDCgabMSoNEBtJR?=
 =?us-ascii?Q?mCzV41JMYqxSk0tT3lUeOkYOc5WMHMsOgt/np4yiWcvRm8sI8Bk0duTq12qX?=
 =?us-ascii?Q?VhcMck04sYXZPHxWnKXQeVOzM5bIL+XvfpvD/du71Y9DWQaTyIigPRuIejKP?=
 =?us-ascii?Q?FXq7nT5V6kK+D2ip4gtEMQA/8cXQij9eRy4jXziSehMPg9H9ZMJ6csANRZaz?=
 =?us-ascii?Q?oSoQo0jU2W28mcqOFJoKLRsxFSNEvGamWgXHkfyB+daRDiFuXksWIV1YCzmj?=
 =?us-ascii?Q?689F6KDV1bNouqRsxoPGO3V9afwhfcxYatvlAB+ZO7AglKywORiuYguZSuoN?=
 =?us-ascii?Q?IASdwbkZG8nGC/lIWASgOpT6BN2u5Kv594mXPxUwcy2XyHk2j+vFhTkSHKO2?=
 =?us-ascii?Q?COpM1aHAAnu2P+dVf5wvShfZzhW3I2yLMEwd+xvZWSgNLgwgV9/IqQMW6Yk3?=
 =?us-ascii?Q?qMO5GtNi6JtfBDisxSWoycvy6vPQxwR4nnMes3NGc2P1VomoqlDoF/dnaOq8?=
 =?us-ascii?Q?ZpsWeHTw5SxGcNfqtm/cdMvWD2dQKLHm9KukVcZEpWXoR76f30dKw6zZQ3JT?=
 =?us-ascii?Q?R/vFZyqUt5jv4zHrGYsIH+w26oQjbFmKjXWmQ0JyWCOw+mPxe3t5Y0G3vUYL?=
 =?us-ascii?Q?1U0XGqz6j0LSrMuBXZSkjkintTHy6jTHMR5Pb623nakEQUHbZuQ2fJJwmbLY?=
 =?us-ascii?Q?UXDGdl37y6T2EL/xsnao61NBVH05EjLQaThd2uarb+oXX1gvfiOApne2/A6h?=
 =?us-ascii?Q?Z1K0OwN4mR25yOvhmufWDj+c/lb2S2aNNIATh6unBrkh2H0UlBNNvg8J8MZK?=
 =?us-ascii?Q?clT8fRxqSQ/gVTD45c7viL4jdHD8D50OL9Vpfk+iKPz68QJUNSIj4XAwFWGw?=
 =?us-ascii?Q?6m4XXTCjZt2+NKHts3bOzGfVuwzefhrBTqgPBu7UkGLdx2u4EXGPFxMz6g8i?=
 =?us-ascii?Q?a85yzx6O5frr29G3A9qEmqlugw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db74223e-04ac-4cc6-6d81-08dbd5043406
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:43:43.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NTgxI6lEZAuzzlYAgC/adIQkjSlhl5N4A6czw70V0plKQcP7B196eBSEtAsKEQpN350/XXhfYophkbV9ue376NOu9DWmonlYq+yyPcL7aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=901 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250022
X-Proofpoint-ORIG-GUID: Gi821JCh3xuKqTqcSwMvDBCPJYciAJiN
X-Proofpoint-GUID: Gi821JCh3xuKqTqcSwMvDBCPJYciAJiN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice,

> While error handler force complete command (Thread A) and completion
> irq raising (Thread B) of the same command, it may cause race
> condition.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
