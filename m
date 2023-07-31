Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4305769C05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGaQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGaQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:13:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4518197;
        Mon, 31 Jul 2023 09:13:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJk4029569;
        Mon, 31 Jul 2023 16:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=yZZt31EVjU1TjyEribw3s1baro1HCBxKlNL1G2OTKTc=;
 b=y1o7rNwR/ujBQXNsH/aZ/lwc/WB8Qx2GZZN7Apag1JN29SpJZVgdl4l6ZUh3TN5tOmG1
 3b26isxs9PBNJpTp41du5/LCtBrjmlorYZ5KC1l/vGcejXD37gCd2Gh4XXme3TEQEOBL
 OyPLg7NFpSGOOHznkO/SpHFs6zhQgeV8df5FI/qazlW/qn4dqPZOUglMe2KzfUMRtlXP
 WvEF2RWZLHLjCjINR64FrNp+CLzYiMIjSkC65Ca7+Eejtc/dqTpA5gHvGKCqTVqsLzhx
 p/fw++b8zsJzXwMVr21Rhwh53fBlkEbWv2U728xEB6s21wyJSTKLEUnyPU8bXvtVkAka UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd30ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:13:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VG5SRx000799;
        Mon, 31 Jul 2023 16:13:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74ugpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqKGyfyxOwx4BnnOHb9vzIBRD05haGxhIul+zBK8SCxzvqSXDllv9n3bnWdupSQ1WvD3i9+t9g8y60V+1c6KCo/y2HYIkHbOvJ6KDUwMwZmH03TkJUi+u2+D2FQC/mLD+XJB3iQA6IjCggudOu6r2iRoqvd6+eqr6w64u9W2aXstAuGbENNzuPoBuxuDCE6Mtm2oJb6JbfJy0hXU/gXvVA/WUU0zxWnDYn3T4uhhSDqTdx7IwbncJDFyBz41lK/HriKLE8hLWs5KMhpyldHO1rLDArJz0yzoz9YDmy8FUD3fpC4brtbwEAp+tWf7WgkAtZx0JDrH/1s3Plw7og4DUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZZt31EVjU1TjyEribw3s1baro1HCBxKlNL1G2OTKTc=;
 b=KoUtzxegFFOgypvvhp1lVswnZyNO/u5AP5gD/+bmJu1Y8bC0WiQh+Ut2+4PR2wFx8ftb8vKQACRFHznHsxAeu4V7RbWOoPGfGdQRZ11Jw95sc47mk+UnplvmQIFGqjR0rrZrS7G+R3IbgKP/4ec3dQV4tad9Z4K9l1XzJm8nixfNd9WmqzoLm9/xPsMhHsjCSB2tqu89XBDWmBeZ8K5tmTNuc9KFkLm+g4KiwFViz8d94w1MfTngbq4Nq2OWXy1w4bgD0oXCA1SWVWOJjFNihQqgvTwEJScp43ZxHUeY9e1f29sRI9c4eZ+CPT1crHY1a7Qa1GlC4bAl2dkVVPBhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZZt31EVjU1TjyEribw3s1baro1HCBxKlNL1G2OTKTc=;
 b=AN8MfDVa7xek/lFY+cL9Ca/hyAR+PBtWW0xn1pO0sUzpBKyNoCdv/Hr5IZsqhYQRPK/W54oVDuY5SFBTqnsLm1Vd1LGASeXYVuTnxRAoG/Gd2Sjb61EZk5tzmSHhbwsm5IWBvZHWH/jadF7DyK275w+nSHT76jz0zn9BVnLe1sY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7140.namprd10.prod.outlook.com (2603:10b6:610:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:13:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.041; Mon, 31 Jul 2023
 16:13:05 +0000
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stone.xulei@xfusion.com>
Subject: Re: [PATCH] scsi: aic7xxx: fix firmware build fatal error
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y60rren.fsf@ca-mkp.ca.oracle.com>
References: <ZK0XIj6XzY5MCvtd@fedora>
Date:   Mon, 31 Jul 2023 12:12:58 -0400
In-Reply-To: <ZK0XIj6XzY5MCvtd@fedora> (Wang Jinchao's message of "Tue, 11 Jul
        2023 16:47:30 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce09f89-850f-4a36-8d31-08db91e1058c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoUUNbfWO2SLusnJBXTw7gkXinJFTAJo7DARY9wNjzUVMc5uS/YBJDNsVe6lfQe6/sKeNIPdY8iVikvJ1CiYYp1d1mCmCi4l1iqBSNWM8cC2EESRTM8GciFCHxbBRx4vBQlPWmXSM/gbhbBHWCWUfY3L1pOJlxQpl+OXSa/uMiyC+5HJ8XDPctKTuzJTVc2L9E14f2hUUyBXE7cvvtsJMiE7tx9MLo9VdhR5IagqpYN15Z96evcQsNgV5L8XAL54N8PW76NfPyfPvAPnNW+4yXwgKdFszt8fyuD1Rknu/gUTz+s6FfuLMRqr0LY3k2tzplaraHTY/wHBRKeCZ3ViG7SRqEzIM+llARnreVaqgwZCYhgoNAHXb0FYEbc0snS7+1CPibh6cFsGx6YtS1bK00RRCwv2cRhXnNrMNkgvxkvh501HGUO9sc7/BtXEKVpqFmj95LWH+iIbMMuChK0L3uuaq/cQ+URGfNdOrjO3Gh216GpqSlR6VijCj0dhBetgsQnh9WeluT1Sv1teYevYNH38OZwqM3p7ydKOqQY+w+dTHKZw0KBRsRil//tswHzy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(5660300002)(8936002)(186003)(8676002)(6506007)(316002)(26005)(478600001)(4326008)(66946007)(66476007)(6916009)(54906003)(66556008)(6666004)(36916002)(6486002)(6512007)(41300700001)(86362001)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaFPYTU5spFzKh+M78PWtk0G3fIl8ttiaaTYOoSYv3XiWdOGBS13TEbs0MY9?=
 =?us-ascii?Q?uhCejNUwgkJoJevxKqVJjdU9S3tytLS6OtZF0AGctWv1ejYjLtyuHKCO671S?=
 =?us-ascii?Q?iHNX5Ng4QK+r0lbW7+dNZKZjZLrAkNcZY0lv2BvPyVtUJcCWWFom3cUT1G2K?=
 =?us-ascii?Q?zUY30FYtAGkGn+1lE2Cu/O2Fq5vG+WXSZbOH0k1zG0pxXoMUd6QheOQwAl6I?=
 =?us-ascii?Q?kYmXTdkwLFPWES26IUh1/uLEQwbq9MSqf7tbjmaL1AYvFQBHUi0LBnHLuOpJ?=
 =?us-ascii?Q?Ybzg2uWvCRId0csM5CAdY773leOvFi7RUYECGTbhceBa7NWs9X+NbjP68dD/?=
 =?us-ascii?Q?ClKzylbzT/pL38UlyODU4Ha9GWulS3Hsc3547WShjycfnbNxnXz1ZWzDTwdb?=
 =?us-ascii?Q?p/cl/zTyuKvMRYUXspL3NJf9kDwY4fjUTQJCnOVVivZGMg+3TBPJRnLKBCq5?=
 =?us-ascii?Q?0ztTpXYQMYCY16CtaT2MbpBwIMNd/VoUIb93uhlY5XcLd+LBWdbSuTDLaTcW?=
 =?us-ascii?Q?1exQ4M3P4JMchooc2M3x2OAQ0WfKyZCGCbqKlLRM4y3wBMH5l9zgIE2tDVQU?=
 =?us-ascii?Q?Y86iUdQdcMKOKS4DfQwQXDBHBYlvQr2o5QLftoB48qWLrzjLoyu3rYfiv0D2?=
 =?us-ascii?Q?tU9ucdi0fNOSCHQiCYZzJLQdleBmdyM01A8pgG3NdjFnJJjvDtd6fAir3CUU?=
 =?us-ascii?Q?YRzt7rlo/cj0DyyDTWrfOof7ALpIUCuL0SC8FnxOInZc3tYU97ZmpTTwXwEN?=
 =?us-ascii?Q?DHjR0F/q/f+VmdlwDFvjpvtSmXEXuQzUJxlUkoRgs+zZLBZ+CaEYR0J/FdVm?=
 =?us-ascii?Q?JGgEVQ1UeshzGAoRz2SMHvusyQ5b4ddWwq649B6FYWHTSoIImy4MC5XlHDPd?=
 =?us-ascii?Q?/QmFCnpklHiPsv8W28iEZgWb+wXL0ad7pqLQAYGFQXOnbxa02X/JqR5KurwD?=
 =?us-ascii?Q?jQPDjS34fRS72rxhNOWwWQLzXCAHNdNYD30qfaBfJUpugjt+izGnKIx/BdL2?=
 =?us-ascii?Q?cfJfIk1N1KCWvGFZ253k0lShi9xs17xE+PYXdpLpYsOI4P65i6Rh+yTsqYwe?=
 =?us-ascii?Q?oju21OXL3FIkZepeaTyP/QiOZyRkxbTwpufacq9C1cUSGTzpo0yvhKGi9pSU?=
 =?us-ascii?Q?JNLqiqiZY/DMTK1Ts+hfl5A5lSTer98r2FgUCxtVs/AVi9Un/97clFLjgAGT?=
 =?us-ascii?Q?U2OURyIICwiGgMpcPdS1I1RnOJKHR1/ptgN787xR4VX0sj/VMCm41mm8u8f/?=
 =?us-ascii?Q?jZHoXJZIRThSzmP0qIyQYDeIPzX0itK1LK46NA5uMKYEHnOqecxDPntj0+8c?=
 =?us-ascii?Q?kMZrgsKToEUkImbdYRjihxJHFp3gZvjZXdFfyuD99dpePk4ITuuCaQxUyu7u?=
 =?us-ascii?Q?cLZzh0NEOLOgcSLVBaRClJf7HbSnvPiJtAMEjMyRvzF1GxQc/X1LG7UnKkwS?=
 =?us-ascii?Q?4wcoma8TSi9WI8Wi4Y8RGeLafOTst6dTkW/5PbKvJvp1ti1Lvd/DDa6LcwRh?=
 =?us-ascii?Q?V9h++cjL1pQIJy3nW6yHEuFqk1IFOac7IQmO5VQGh9BLZl46F23LNgiigRrk?=
 =?us-ascii?Q?JfVsmiRTbt9TzZyHaZ5WzxI2O9jXswfOI6ZmuL9mmnHwta/BHDPa1P3OKv4t?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 71Wr8RrCqmhIkN1iJ/+Xmm2/U9jvtzR9rpmJZQIBFshA2xG0ZJQVdfz/YonzXzjQLIxagwGT9mDNkBp85wMamQBjNKx4cxNC+VePxbHFb2Bp6J8DL69aPuDkpI5UntgnRMeq6LHfYNQcIp2A94Kl9MT9ix1ao9qQbs44HHjQpURNNBY8DK3ZlunIRPt8ImZjcYoldKuGJdrWZTTgU0I0vRH0XJvFeY8Utfn9mXGPNXIhoBUMJSP++Jmf1Os5NxAUmEt5U8bsNzjmlmjTd2IX1nwdxXPEQYP9SiPBZxbgSlQRiGv65IWjC0wOfp+mtO6VbAZjZgiER+MZstlQplp2wZLeVadpoH6lplGI4629i3+C6he50W3Sj/NZwXFbvzUxGw+Vk9UXhA2O03RnMOrGryi+NYGn0v1Q20PYNMG7P4YdOezue22aLwubrD2hwp+mirCiIn1FShSUg/yuKjV8Q+y8oKLxGpZGoucETVbAIpXuxYsCrb8NK8AWRkWD1uL2wQ9RBkbRIRtP09Yam5pmLxz7NriZir9l7jVMJa4KtE17zqPu2ReCd7Fzlwk8SjDq5m32eH7QVmjJEe2pHeFDGKaPFTY0sZIkUZucGlxPwtKK95IidVptxn7mpnl9wpOGrPp/jYF8ej2umnMWhvNaRV1c4fHHTg/CRun0Fj7wRP1zVKy8ujebsfp59D5fDHkRKOEH+GObABHwm0DeguA7kdrPIsB5GQ9f44bcJF/JUhIS61FRropIUla9Ik9pzoVyFpWdr90H84VXCH/WJdDJDvZeqngFS4MnOY0Sf3zHi5sMmMCiSGU5vjeOR91Cpl1A/X93UbfPINfMuu1oHXcYfwjV2xJNvP6CYAa6mPz3SbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce09f89-850f-4a36-8d31-08db91e1058c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:13:05.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPnwkf9Pdj/kflbnstom2uIkUS4V9phEJF8/zYBHfF7+oHtZKoeoUmhy0lW/omO2gQgY7ueFdx75MANTNva2e3O7e7aeMN7KacuuxwQej9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=939 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310146
X-Proofpoint-GUID: ReZiOG41N-8PnpMiLVtxYaT16zWhWgQj
X-Proofpoint-ORIG-GUID: ReZiOG41N-8PnpMiLVtxYaT16zWhWgQj
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wang,

> When building with CONFIG_AIC7XXX_BUILD_FIRMWARE=y, two fatal errors
> are reported as shown below:
>> aicasm_gram.tab.c:203:10: fatal error: aicasm_gram.tab.h:
>> No such file or directory
>> aicasm_macro_gram.tab.c:167:10: fatal error: aicasm_macro_gram.tab.h:
>> No such file or directory
> Fix these issues to make randconfig builds more reliable.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
