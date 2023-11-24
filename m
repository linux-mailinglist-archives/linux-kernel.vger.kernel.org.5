Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB327F8644
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKXWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:44:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750310F4;
        Fri, 24 Nov 2023 14:45:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGIddP029848;
        Fri, 24 Nov 2023 22:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=UWa6WwjcDyWMDJ62vuCUDKf+F05qoHDYoMSJMP49gq8=;
 b=KKSNOBfCA3QHi0ICC9J5LdTpj/hXICx+ZeWMTqam0B06RgNb8tmlvqKVEZdikMyXW4Vx
 ubZcHlsgRiBSQg6WTK9TyaZR8vfDVg77/LCAVAwKKDv/zoKLXpuLTnR1p0xBRcnFbW4a
 IbwWiz255lRiEHEsrKOh9jnCzYNQ8FQQOG51jHb6KCIo2gX51KWlAoNZ215AsLa7AQHp
 YS4XPbiRDg/eqDaI7RQT94V/EWwZrfQViTrVpGB+l8ScBIIlWkg/l+a+kxonerBvlYtq
 pnvrgrgndi/sF/x8MeXaJXoy0Fsn2c9GyJxMTqb5FevR5pONurqnPJcquPXF5oXp4CB+ Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvukvma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 22:44:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOJdJpR022595;
        Fri, 24 Nov 2023 22:44:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqby2vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 22:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE1K8pBNq8u9QvtbGtdvNNeX6QNuHGgtc1jGjNLgBk89SR1GRFtCcNzgX52QGXbBzWNoh0pofoffSUlnjXMJoRYUzJOv0RuamHdjPzunCreKUlLnBr88WExdMyAdgRApDDn5lXo8/1XTdY7A1W0AcKofDsvidGIJputEt2NWqJju9rN/MACQonJLS3b/QXO+f7kbWmApNS2lfuaFFfhtwtZiOihrfoMr4LZ57HbiLEPLXNdXbz+5BFEg+ba3Z1/OUq1fshVJDLQii6g39g5J3tjtsGNLkPYsWhUB5BFFlR1KIXYnOO0kfReniT+68aWILm4oLQp0siE8afzNPn60Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWa6WwjcDyWMDJ62vuCUDKf+F05qoHDYoMSJMP49gq8=;
 b=M6SxwW7v0RIE1w6j1jk2dRfxYeyYr6hPoi9VV37vpvppdLFKMkyvgW65uWi2lRFLTA2ucv5+u3E7xnfDMZlhJdQh3xxGw3WoAHfQoWslRGaz9wM2ifnlH8m900O6znAH1BTv35qbzNd9a7rCnWMqzKl4wVjkImPhII30zcjl0ogS43p/e0XAbuoFnx4/DTlUFugeAwogL+CrZqFOy0QO6wDO2zvwGuZcjEU7hVAlyl0JhIGiBM6cDeRsvtLjjcCnTkr3DSKtOO9tV66cNWYD4Ma73ezNbcETO3NIhhuIF6S3AXkz5MQwLrUp2TuM66Ys0OC42LDMUa/AS1mfvj3cMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWa6WwjcDyWMDJ62vuCUDKf+F05qoHDYoMSJMP49gq8=;
 b=dKDAActsBxIrPX/QqX3UHFP7NqFXZ2DVIyr1TuNxPfQMALuN6ZIbSvGvDFE9/9N0L5hQCzYQ4btWWk9zBnVk80NJF1jpGcB58q4X8zKxKJC9AkMYSSbfN7PRpA1nwlAnL0K6ZlT1mDkCsMP1JOxFNeqRW4JBP4/iUZzbL/DDAQo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 22:44:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 22:44:25 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: scsi regression that after months is still not addressed and
 now bothering 6.1.y users, too
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cyvywzk5.fsf@ca-mkp.ca.oracle.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
        <2023112456-disinfect-undoing-b5ef@gregkh>
Date:   Fri, 24 Nov 2023 17:44:24 -0500
In-Reply-To: <2023112456-disinfect-undoing-b5ef@gregkh> (Greg KH's message of
        "Fri, 24 Nov 2023 16:25:07 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d173eb7-e8e3-4bab-2853-08dbed3ee8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISLprnedDjWECKJKdUdpnr9+tdZWa1CC3KzBBV5RiXXc8sYbSHSNIQB/tdc28Q+Fm8cfyZqh8xr8xNUrk1BhjdWdqxefZUkHFM6MPkMx2D8EZm7huza1Ji8Mig1TU1kqHDKS0dh1c+I2tpoSR5fPV19kOW9aTXkEqX0wkoRlQxKs3vZT0PqJP0kRQm/CGWQlCNx0B5XStxWLoWo7nDcua2VAy3xnSfjIyd8EZASi9yzUDpIIGCckR5aZTD7uMFTxQEYA/77rI3N9EQLcG1QsM31VLdUuuaVWQM6jjJgcYu/wWadrEx4sCpqVizoy1xUOazPr9xXgUinSivzQoPYypAFf8JzT5/CnxydtM6ax/lJ49T3mJ1NrDNdTvK32hL3nk+ipivH12VChim410bMnNCrx7GJa7qnZ/KxnHg2V9SZPJKk8rnSWOT/fWMvi4f3qjfQn3j4egjX5ayNloS+OsKzitdu9vJo/hkL33acTWuutN/2lEBJnUpELNl4QKkKCmC3NCKIMt8LVLLP9EMIMATfVU0smybZCOig7nWZebvUhbUGEM8MWZ5445zCjkzUO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(36916002)(6512007)(6506007)(316002)(6916009)(66556008)(66476007)(66946007)(54906003)(4326008)(8676002)(8936002)(2906002)(4744005)(41300700001)(38100700002)(107886003)(86362001)(83380400001)(26005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KWD18FB8xkU1l6xpj3F59mgEtWYFwVsoBUFs1htSOs8VpU56hNixmT6Y62OR?=
 =?us-ascii?Q?znGRYt6WiHSY8+ck2e+xyN5bJQzGlkMXLt5wyu+e7n0a70Wjkox6E7MQ1mEz?=
 =?us-ascii?Q?opW7r55GA7M5g23Q6oo9D5R7PGOQsWsoeADRKIskxo5/Z7r6HIQdHauamQvV?=
 =?us-ascii?Q?Y5eBE1lxjfEdKsc626IvQEkVPSW4it3YH9nkQp91/pI+Io+kKKg2YsdrVWRy?=
 =?us-ascii?Q?jacfkPyXDRzWLTtO9IPB9cL3oi2cLkvvnfKAm9I95vQvKopIRD/4sFnBIKoI?=
 =?us-ascii?Q?5pK7A88LKCMJeUxDf/lLjUwcmeOLpwNzDAPaVbcVaQGLXrsq6VGvsTRycvyF?=
 =?us-ascii?Q?B72IRY9Kv+d1tx1FEv+O1Bpc8kg+UMxrNR24sqpi+ij7XTGfIbf75elq98Pq?=
 =?us-ascii?Q?frSB6CsslVq1dEybwhnTE4o5uinYd2QcUdXNfQifYnkfd6UKHc2XyR2yFB7/?=
 =?us-ascii?Q?EffgmxAhLfpVQXcfrRa/3CWHCEja3y/kHUQrJs9uepmFrziB813scPD9OzZc?=
 =?us-ascii?Q?BaAKQx3H2ELLpTtQw2JATPQx26/8xcT9QQUpBvelrtDFm7WiQ/djjC65bVk4?=
 =?us-ascii?Q?pvxVRTIvQ0c9q3es0TZaa2PzkEpXCQRPu1rUZ2+H9lq3eyfFXc8ZwazvAWr0?=
 =?us-ascii?Q?3rrY7CWRcNPN9M/OMuOQBZZhVL50vPPnX8HapZLFk96sxNN8ds0Us2GozjTB?=
 =?us-ascii?Q?zc1kBK8nyV2UDIwO/MFmrBZ0RJw+UDl6Z9Nh39i74/67F+GLtR0W0QeS+Dd9?=
 =?us-ascii?Q?hQVNYWYv91HLdniZspM0f6qp3myPSU4vzVjExeWQS5VLUpeV1rszweQo1+M+?=
 =?us-ascii?Q?GxT0ryXN5POHv3g5CJB1o/w4v43pXgRsO2Hvo5jBIAHbAa41ZbGZcxGU+jws?=
 =?us-ascii?Q?FTcH3877/eGPEcieWJ6T5jJpyJ5MMDBf8ulkj64H4UehKsr08qMjmsJxM589?=
 =?us-ascii?Q?h8uIn2/JAEPLHN4yBBg3KrtI6MXWQn1B1xdiJ9d5MGJnyE3eGzi/96f8RvQF?=
 =?us-ascii?Q?hYX/pE5dkRuyRzbtrHwRXxNhjXuKIw3D4FCd/pajWmfalRXNNMjiQRStHZSf?=
 =?us-ascii?Q?xXsu4ydUTBtXtNf9KAFZTFLJQhdDQ4IBVWEXNBpDjgfm3vU54mhZbDK+v35/?=
 =?us-ascii?Q?KHMUCbjwBwFmjAvTS1ipn27UOkBF3JYlQZEF0EOhUKPgJo5w1i37jC54M/Vy?=
 =?us-ascii?Q?G3AL2zs0QFAyzxNpSzh7gPXL2PC1RL4Qf4gA0AzoSEy1BYZX+l+owyxINuIu?=
 =?us-ascii?Q?jn63WpzauEGKTQZ3y33R+ONUaD6r5c0wF5/ItArBUTklxVphF/3WZ3Y8bX1o?=
 =?us-ascii?Q?qK7ZiL5nsz0IrDZwz9ovYvQ5edObSxX+TBQFcL06Nk4mfMZAuxYjxsZcoRe5?=
 =?us-ascii?Q?tktnbVQ8P6m4QswA2iG1+EECYb2N2p+/Ujl+WohoZKb4XYALPXSWTkk8zuDq?=
 =?us-ascii?Q?CElAlIwHVyoZvRnCi2elHqhZOuO4a53/pq2S2P6A6H8cDYJCEM9KsUYrefvW?=
 =?us-ascii?Q?TAic2lHkVQGb0w24URzuRI5KJZgx24Uf7OAsd/MyRVBtXD/WvFacpsMHDJHl?=
 =?us-ascii?Q?00UmrTPOv7BN8PYiHHJ9CfXgO23tns1LdH824CTo1HgaWYFKb3cM1DqPcArG?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IAldXJaCFKmfzRd8aYqrixhZFc7ShdpngBMqRw17lto8pwrqC7tTlstbaj7H?=
 =?us-ascii?Q?SrUt5LcVZFYGDXn03ynRpJ2ljyhC0eWPkU7HC4dV4cI9RjTBxkGhlN+sp3LY?=
 =?us-ascii?Q?9jMxrg5W5PgvCCwOTYHO8Zv9Dt+e1by8h9oMVVn9MBNNZzHfEzPVOHbXwWvK?=
 =?us-ascii?Q?7IGNTWAZrmot09JUvndavwO/tnZviW1kk4U9RZeQ2LsdhpG6hZwLxhUMjLXB?=
 =?us-ascii?Q?LoFgJgcqGCz2NDgfi1C/zvAZ2XMIcJw2zdfEev+rIjlvUfJE58CO4mev4S/e?=
 =?us-ascii?Q?boOWNSHVBn7gFcApFYtSjumsciRMqj60Bd5pB5bKYS0J07sE5XWPF+uGVsvX?=
 =?us-ascii?Q?v+B6YMJMzqty292OwnK0HLrCMcKODcQcxWAaDkUO58DRqPd4WrQQtQgqs4J/?=
 =?us-ascii?Q?v6cMqrcQjm+sA9b93BAm9bjPK62pkyzbXSOvb+jGHC7EgRR9zkFluQUZCdM0?=
 =?us-ascii?Q?eyFpHMiCrnlU3Pu4V+dYHE9ngGHjkoBdkRibBo8y14N+2Sd7EZgVD0fkkwmV?=
 =?us-ascii?Q?UROU4wigUDaZ6BaexsAVkNKpE1d50SlF3MAn9cXZFIOuxf9BXx6kF78L/mFP?=
 =?us-ascii?Q?APD4Sjz5/cKGiSyaT0siyTPwcBS7DTJPgIuN1u8deRyrrMbwQWa0Pism1S8z?=
 =?us-ascii?Q?RFls++SMknDBSD+OLXi6mxyH1r+kAoMI++5ROc7b55WA49IUfU6H+03A6XQ6?=
 =?us-ascii?Q?S4RxNalA4fCKfCnQxkrths9XH7iXPWvhFKi1glhyjVMljQuIDrSLrihfoCYD?=
 =?us-ascii?Q?Ii6k/UuDiW2FCvSjtiiNmDkC0jMy9JS2fQkWFMTIhkLAomC5wTowWU1nVGDC?=
 =?us-ascii?Q?/PTcE7AiXdAlRCYyiIKBlEJdZYrMbb2oLSnXJk/KVObWtArFJW2CzfHfnsVj?=
 =?us-ascii?Q?CHe+t1jeihQfY690IoWZkM5c7f3x3i34hNYiPUNv7XMGzDVKbZyG+qnR3fti?=
 =?us-ascii?Q?jVcY96CHrUGSXE4N0PsFopPcwDfHQc/QCp8MxEw2Qaz96sM3ViPO/aEstWqe?=
 =?us-ascii?Q?EthBTmyMlowDzN+qo/ri4X2ggqDq5Qb0FgR4pMNP6oMB5HpskAUsX7n+820/?=
 =?us-ascii?Q?XTr5XVlz5IXcckJOtV3ktNAlMuw0jQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d173eb7-e8e3-4bab-2853-08dbed3ee8c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 22:44:25.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8cI+mQAopJa5YO2odlaE4fVJ0rc+ASHFGixDucybEW9Sa/VfVDYNK7ZJnLh6c49qlT3F702aZDWsJL6UYnXG2XMbtxTJWZXlJDDx8guOsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=799 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240177
X-Proofpoint-GUID: kHEzZ2Fvtc-4D6YO4cJHGsULOn7qAtPb
X-Proofpoint-ORIG-GUID: kHEzZ2Fvtc-4D6YO4cJHGsULOn7qAtPb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> I am loath to revert a stable patch that has been there for so long as
> any upgrade will just cause the same bug to show back up. Why can't we
> just revert it in Linus's tree now and I'll take that revert in the
> stable trees as well?

Hannes just posted another tentative patch. I'd prefer an incremental
fix if possible.

-- 
Martin K. Petersen	Oracle Linux Engineering
