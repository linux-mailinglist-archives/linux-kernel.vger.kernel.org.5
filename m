Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DFA765925
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjG0QtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjG0QtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:49:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D935AB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:48:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFOfFI014656;
        Thu, 27 Jul 2023 16:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=O53n55QQxxK2XnTkc0F/CA2nVcH8xfu8atmWej21Fsc=;
 b=ggyM36+6H5olf0L6bnmyTRnkw5xgC8IUnXMkqulSKAcrD64sUIMV6Bvkl2Z+NmJSfk+8
 nLhWtZCHGFAj+eYBsQ4MxVsEHeNlBl75l9zASuCEGZw/aTUpr0EXa87P0TtnqNitzfQ/
 DLYoHhNd1LLH1k1Sqde1vH/bVcsNNBK2Xg/LysQ50GOS9k1zOae9FUq2xU5JPsy26rnU
 KVcSks7l96mkgAJGPcymkq/6WshnFnd7P4WV3D8e5N6jL0rGIsDL7s7q/j9dqwgL+JuQ
 BFQeODHLHXWjRDsMKyQKTN/0GmMJXgZYtUqrNyzBqXd7xzpfTtwn2Eu9z0MPOcI1h9bw 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b25nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 16:48:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFU0FO025341;
        Thu, 27 Jul 2023 16:48:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8cmyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 16:48:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip4tY+rIetSO2a/5sWOb2Twprocb90hI/JK4WOTqVLRJT8adV2O0q5vW9LtQm5P4l9QexIIGqhaLMwXDO2w7E66GjIX4BalqzDkYI5ERm4Kn9drXsLE9xd8BJ3Ty3oCn9Bdt9Sz5vSHyyf7wXCjIBKECFC6zMAKTjuLgR5qGJ4d+jmmHemdCF49jUIg2OxWTI6f+vW3rjAi6f6wm9OGUvanxH1Qrj4nb4PjJJ1WR/X384g0LcVMTTPyUqnczLPOinbahdu8w8c87y1z494x/LuBnAJg1oxsLVzjhItriOXkK8CKbNDRV88jqGeqD8cOKQDZLqckUda68ZYOkdzw9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O53n55QQxxK2XnTkc0F/CA2nVcH8xfu8atmWej21Fsc=;
 b=JxUQsb/URokJiqn4wT3+Gl3wvKzvjhSfhYiGDMWmJirSwL0g3W80yiGamXA8juhHrtVsIU4gXcCFrTG0B4Pu2d9MNWtdKRmYFKQpvYnJKH70AHc59jxQ7qK0OxZ3QwQ2WTLxm3vYShXFtRwncG1igIpZVZZGjTsYOFTfsGrIHHSRoJbh5UYz64BLd/XMxvxcJdhqBqXu9Zx57d3Xn7zHrEFFXKnd/K1uTPA7PmfgK/9iqihfgbclq53IRxfMsOyKTqBAVYMhZ6YEESOJGbY5x4UhFGkpYIWjVIzXT22eeXg5A6Rq/L2oO8ruP3vwnhW+XvlIdW/BORpiIfZhZ/udBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O53n55QQxxK2XnTkc0F/CA2nVcH8xfu8atmWej21Fsc=;
 b=c4JdqcfpiLOnmbxp8wQykHmybBdsEJxCPLbqMyssWRc0tgdCJnUbKt7TKcbB3WTTVOwM+feUyMNnk6shyk0rYZzR+ZM5IttQZhoT86srOoZ1fphFTotkKUW46vvTk9fR9gI3OB95R+JuzTuOyOMQGTp7L2np90nIWZ2ggS8e2TA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:48:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 16:48:00 +0000
Date:   Thu, 27 Jul 2023 12:47:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <20230727164757.e2di75xjybxncohn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000aeb7f06015e5cbd@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4ec2f6-e191-497c-4e92-08db8ec13c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGim0OtTqhQGRxdehSt1wd+lcLc/OhdQnPU76Lp1MrYciui2mGYWDGGNQ6/vzm/Xa51ohZh8+LN6Kmuwp9Ug5wVEyz6EofTqE7Zn43pzpAsiv2XBZtnEbn/z/nqWwkS2NoJISDHvKnqUG8kyLmwqX8YxCLsvD9oL1dOhjM/bggxmKdl9S2B+vZyP5F2YjzPTL1Gfex8mP+32xTa9VhDtS2NIWToBV/rwFVfVLFLUxV2PoyhizF5SXsbNvPCu9QGlCGGZeEB9RhpMrmU+NEF+9Hf3Rzv2Zqh/AyIKwTeyMxpJQ0n5RJKA7RnjW1nSt6WsPgBjxigid+2q2YBBYMKnfKyeKr6MK0GACYuGgYDsS15LDjw3EZp0UpdOairTszU+J/mUnDyYwJUn0hr+rfHfCc3UhEJXReDWD2Zkp3iShaXZSfAlypuuO1uMUp3gGPtAoNtiAp5KI0uvUhggdorvOJphbT7zaYZQVmI+CCIfoF9fpAhUCfU3JXNWdQ/NaiBrhEWNKnghDyJP0RMobK/Wuaz1fXkY0xD7BfYxjszAQQfbqt7/wh5W5IqtQRSLg1wMpcSkbIj/8dMyMLOBE2/x2zYBVhEPT9V5HIUo94uzyJZ51C8hyj8+yG+BswvCpSAhKUTRKjAqupcVvmCSbrvVvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(478600001)(9686003)(6512007)(6666004)(6486002)(966005)(66476007)(186003)(26005)(6506007)(1076003)(2906002)(66556008)(33716001)(4326008)(6916009)(316002)(8936002)(8676002)(5660300002)(41300700001)(66946007)(38100700002)(86362001)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cREp2gLTC4fYo70I3Zy4rcg6Qo+e28K/3qPJtoy+d4ocnMwioARcFT3IbBKj?=
 =?us-ascii?Q?oOPoWyHiOyXxKvhfUd2FTupqd7vwVGpO7rixTN/1pXOx7WzL+96hMZ8QLVSF?=
 =?us-ascii?Q?5623xWX0iHyS7+4UC8Md/eBK+hQnRBvC0EXDtMUaz3V2sb0Tq6CAgTmECc4/?=
 =?us-ascii?Q?zs6+d2PNg0jj0wPgQY4z/646wu+3gGAnpIKWSBn+y24vFCCLOYR5kONXa8V2?=
 =?us-ascii?Q?4XvawpkHpB9yZYKfWviM9SBOuS+3cYYZnjodzw12ZBcwfNzRp56wz4Xk0leF?=
 =?us-ascii?Q?+XwuVSJ6En+uwg7FfJTIHysO7vJWVc9cIekdCWlYi8U4Zp9ngh6YoeC8vm67?=
 =?us-ascii?Q?vvrBgizSrE63A3WXn+ou9KBJ9slxAddiPftzP3o+4ylfq2NVXr8xWxCqx2or?=
 =?us-ascii?Q?6ydv5oMyNaUwAteUBmpNXCx8S9VXTKGNb5z3jSMzqUjNpMjc8O87zNynFPlC?=
 =?us-ascii?Q?b9ca+DFRVcUdwEpIKhupRP146AFaIOvnPpqM3bxuN1MG/5rdtv1LLU6Svvyv?=
 =?us-ascii?Q?zYGMYvX05XRXwwz9OlrXNbXrIJXrEVYP9nmUaAOTMrQZVNY2iH/RKzjYhW57?=
 =?us-ascii?Q?GPG1Lxlplht4+8iXBZE+k9anYHvhHb1UNdQ5VIOH1v29ezTfxw5yMQWN8jnN?=
 =?us-ascii?Q?zW5R0vL8IrEu/1039I0GluuTJxf5eQwzaXzHVP/qJydgvtDawcNrQZfxaM6w?=
 =?us-ascii?Q?yiloPcv5/Pg0GkoK9TP5PXVrNcFQvcariMOjXcczJm+bjBZzGcAWrMorvdOx?=
 =?us-ascii?Q?U5lzlApQPcty/2eiKSxpCuxsPEfn+6mmWOr+o+aoWWUFoR8qk1KOXkA04mly?=
 =?us-ascii?Q?/4tGFKgnAj86Bsv6Ujdemm2DIvpSsLNr0BFJO8Wp4IeuebzusH8dGQFtpBqF?=
 =?us-ascii?Q?Ruyr81Liwk4F1KCJHwktvUSed6KBh4BOC+6mml3xQDfRQCKiszIUsuyrymQT?=
 =?us-ascii?Q?HP0olUJxIv7hRqpo7JASEFP7R5851yBBTBI+6nsVC15uA8hDlMG8GF6YV+6S?=
 =?us-ascii?Q?VYyvsV10BrFoTv15jRADFNqpHCegS7aMaKVIT5xhF9xc4K5YN6w082rsnK1a?=
 =?us-ascii?Q?uXF6DzgsXxstLS4kk2iBZEr2kou/iu559Ow8MQGFCSBWtqmrYImm2wb6CcAt?=
 =?us-ascii?Q?OrGLc0U8aX98SQXMM73E1Er4zx5wVY6unrOvhhgsXaAM26Uh31OUaS9gchld?=
 =?us-ascii?Q?Zop1fkIrcKKzpkl+D4E+nFL5gYwoUUho4J/lGnW98nPKJQ3ZYIrBXqC/+Fbc?=
 =?us-ascii?Q?mr0Xz8D2p0S8bHEIeMWm2Hj7KJNSwNAFM/Puvjc3zUJwgeohg3QNQmdEbmwY?=
 =?us-ascii?Q?qh/MKbI79WqyA9fB0lDG3+IAOERorgOlBxt6NKJx8BC/thytwYPCftEmch1d?=
 =?us-ascii?Q?O0WqEaoBKzvhXfsSQ+qPc9lwcrWwQ/STEPcDvihFQbdMHjtMd0wMyqz7q6JY?=
 =?us-ascii?Q?5jOQTwugE7KjUCm1VLKx2QEkWNLYFOjG/n3/Qcr9/tDFBPY/UnC3aHztuXVt?=
 =?us-ascii?Q?x9XDYxKeAjXJXC8O3syLEo/iehQIgP7tJcNxDczXnUHPWbNmmKYRgEzGFbQh?=
 =?us-ascii?Q?/0LTv5PsTMd33hA6Psj8a8Bo5vHs1fOFm43UxgWEiC8l1vhDcTWqMr4VOwWr?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3KUw6WGY5oqtnjq3pVVENn5Ct4B5PQguaiDYgYbwqvyxpteLf8Z0uPk/A6O+?=
 =?us-ascii?Q?R+BiEstuggG2iaRTLLHegigflOx6EBGM6vij5G2xZyYDYtn6bc/5EzxZYmwn?=
 =?us-ascii?Q?el5tPaD9RDtsbMMkftJ8uh0dsuMl4ihR9aePfNzG8fbCpY/wDgPTdWSdmYp1?=
 =?us-ascii?Q?75LDxfifV0FEjBnnhW7gfjQ6I3nSCsHSRe0Lz1SsNx50/lP+36QAvDf68tzr?=
 =?us-ascii?Q?VzFkaUZfQyYW/Y6ZSaNXsHa91bQ6hRPNw3QEnxMGx8WDfEzH61OLWGwFgX7M?=
 =?us-ascii?Q?rQff6t3vd2XbEUFURoObscZEbIErr+OQcISRVROeizshsswDsdh0I/pt2wtk?=
 =?us-ascii?Q?Qwo3MWEQ74YgMiLdt+9WHlBgZXkgVLjY1zk4TKkDnAz1GCSiCtdKfgRj2ZsU?=
 =?us-ascii?Q?Qji/cjL/KyPuOoI4js/UzCV7xZ8Ct2qI23MZLWoj6Gelo12E76v7R23ZIkPp?=
 =?us-ascii?Q?lloMG0fUkM5RUUzUlTFERAK4ZJJ+oCHud3ImheDjDYw4oA368s0X4JnglX6o?=
 =?us-ascii?Q?MmQ3cQvJXnIXvahlJ0pB1rVdnvuKI1zetfayPTIF/KV4a7ja2bLaDTn5Y3xA?=
 =?us-ascii?Q?ckUuue+MFFiHt5xiN3YCyJkiFZyruRKFgp3WzXeF/XvFk7HfTfxJh2erYWKY?=
 =?us-ascii?Q?JKrCSuUgrUKGst76M/PRya/YRR9mjFYNhvPuaRu5Uu8PvllGMRaE25pcDHCw?=
 =?us-ascii?Q?n5PzQkAqzTtSsESPzf39hCUSI6AKfla7l5ss9TVxcg3hQBEXU47bv5xlNzps?=
 =?us-ascii?Q?SXat7ziarAb5ZXMoSmqV/BuRBo+PVuFOArpYIpJTg28SUzsDUnnlFhbdTRs2?=
 =?us-ascii?Q?hrTHAw6EEXwZVv0YiXixemY5yOSoRSbUw0OoXTZw+zGj7yKRFlqBxdrJq0l7?=
 =?us-ascii?Q?f1KPu/HSonEgdH49PVmsd+a2DV9CKsqY+zj8eNQl1HSn5A3N5/fGT1Y3m8ye?=
 =?us-ascii?Q?kkwu5xwsYT1NG+6kVhldEq3YGeELXx/EMX0GiZ8ZKodCPBScsYXSNnDxtP4i?=
 =?us-ascii?Q?zFRnarXij4wyuY18ICKCexkUyg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ec2f6-e191-497c-4e92-08db8ec13c7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:47:59.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+KzemCR5oB9WLB/3bNpn4zBAvH635KcxATrHkvYkaEZLlEgxsOBqZKyI7lRV836JkfQd9LIUU+TDGA8OvZDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=654
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270152
X-Proofpoint-GUID: ESVPmMGIlFjmSHOS3i592f_C1IH1-T4R
X-Proofpoint-ORIG-GUID: ESVPmMGIlFjmSHOS3i592f_C1IH1-T4R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com> [230726 02:57]:
> syzbot has bisected this issue to:
> 
> commit a52f58b34afe095ebc5823684eb264404dad6f7b
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Jul 24 18:54:10 2023 +0000
> 
>     mm: handle faults that merely update the accessed bit under the VMA lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
> start commit:   [unknown] 
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1443585ea80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1043585ea80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f481ab36ce878b84
> dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1697cec9a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1566986ea80000
> 
> Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
> Fixes: a52f58b34afe ("mm: handle faults that merely update the accessed bit under the VMA lock")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

This is caused by walking the maple tree without holding the mmap or rcu
read lock when per-vma locking is used for the page fault.

We could wrap the find_mergeable_anon_vma() walk with an rcu read lock,
but I am unsure if that's the correct way to handle this as the anon_vma
lock is taken later in __anon_vma_prepare().  Note that the anon_vma
lock is per-anon_vma, so we cannot just relocate that lock.

I'm wondering if we need find_mergeable_anon_vma() to take a read lock
on the VMA which contains the anon_vma to ensure it doesn't go away?
Maybe a find_and_lock_mergeable_anon_vma() and return a locked anon_vma?
Basically lock_vma_under_rcu(), anon_vma_lock_write(), vma_end_read().

Thoughts?

Thanks,
Liam

