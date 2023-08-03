Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023CF76F1A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHCSQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHCSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:16:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B32726;
        Thu,  3 Aug 2023 11:15:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgDRV025563;
        Thu, 3 Aug 2023 18:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=13hGlwGmvawn5ZNkUDlZpgRihxASDSgFABCI3QsW+Oc=;
 b=dCdCyFRQxKOfTfJ/5qoCMcIUUuilAsoW1ti+Yli4voLx3uvz6TlSw9TD8Dp10ycsfGE8
 mC7Qvdcy6jHKrxPkWIq/iAS7rljhK3h9zSSapKNRnKA0Wdm+uKGdPKwYyofxVKyYWu9G
 WePbYg5x1f1Zgw2eMbahiYaCH4SW6bfzNRefhcPBioAZv5aJQIk1ruAPXciM2X/rMkJK
 03dGPfFsHlsfCBG5VA9fECljf9a4Eiwrn8kU33oXFWFqscgXwLuBRFj7k3tiUxJjan13
 ctz+oIYKBibZzv62vku5OYFLYqgR0Q/I7NsDZrDquzDNvVIc2new3IZQuaEXRgFR3pyX Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6ea731-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:15:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373HSC33015692;
        Thu, 3 Aug 2023 18:15:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7a1u0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Aug 2023 18:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA/Bpo1FnsdNvK8aT4mVK9HaFtBK9XAJ1D1CBZ9m5KI9WZbKKcOTobxPF60MzF4xLOjiQhDJBW3j/lf63X9V8IyQ6ZF+DOOJ/jQrR+6cBnsLeKS2C5HxQ8IWTKsfBVjrAkLmQb8gkpehe179TQUtiMcZf4xN/lRgHtWl4H1OSXIp3xc7xmOue3Zz6qE0NdNGBLLQTq6V8gi4SrxmBGxGjp5J2s6WjjxjIb2wexLmrESpkVbzB76hWCiYh2UqIobiJ/syMSMTwN0wZTF+cmr9XA6UemP10rbW+LLo1+M45qj67H+QXlG80PwF2tCfcSfypyHJdckhNMnUCICf7VnWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13hGlwGmvawn5ZNkUDlZpgRihxASDSgFABCI3QsW+Oc=;
 b=oE5kJcs5ggDDrCiz/dlZ9gLeQ7eIS4+nui7SS7jWNG+dttU5B7PJsSTOsBrRJ9Xeepw9dng8IVXKy9pmEwosgGmYFlGnHfi0gsc+z7Bg7vFApQl1Y1BwQXtTXWO4xOwK2n9FVUBzeFLedSx5Ya4Fehkfzp/uC+Q7AItY50FGDdEA+EQIxOEZshNHsDBgwy6VLfq5LjaPt3FEONxNKR6HCuVGpV3ezJKvrsEmxxHcYbL8nZR97uXxVOyrhjHu2+dFh/m+IT5hwuImzOztYF+QeIGeF+xOeWPtiJXXQdbXOc5eJxBxHWgXjdRFgAQx2yPEj1hpmNgTBhzVK998kiWg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13hGlwGmvawn5ZNkUDlZpgRihxASDSgFABCI3QsW+Oc=;
 b=NDpiV0a2Hljd8wJoW2Tmq72vxGkFRZG6Ep5nHv7McHC85M0xm4pMcYvBQCiQMJfzFmmsbjLyvXhCJATOXsvewe+CkuaunreMWi1u6Maz687SwVJVAAy+TaTfFMqhI73Ey1kiUQrPI0S60c+ekcJEc2yYc+WZTLQq4TocX2xfbSU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 3 Aug
 2023 18:15:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 18:15:23 +0000
Date:   Thu, 3 Aug 2023 14:15:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 5/6] mm: always lock new vma before inserting into vma
 tree
Message-ID: <20230803181520.yd5ao45rm3rxnsbs@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <20230803172652.2849981-1-surenb@google.com>
 <20230803172652.2849981-6-surenb@google.com>
 <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d26f93-85b8-48e6-12ed-08db944d9ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXWLFnpQhs+mjL/ZUFEkGaYmPRsI0mGUyN2hwekJLXydbP8WYEf20cWqhrGRFjpv/D5N+3owy8ABMYgDwaURGLR440Mq11yidNKy8tRZO5kxqxRkjjNycl3GX8+VXIBHp+EJWHK1pRbT28hY4MAjWcK6+47eso+3tP3G/9gG6OmFmCRgQZVWxrNVgrP8iV+eODsSXfKoz1SI2DALc5p15uLrKKC9sCyQdUmIehVU9Hl2bJmce7Av+npfm/Q+wK2ASTSjaAacVK8oaFwCh1Np9QfB10TXy4EbCoj6PVLBozKgjI3Jw3MxyPR0Bpf/WSE+qA9S5Y6Adqrh/0e/KDAtAF9PVxdA3gH7AipBfqSiq0FGCuY1hedIf5mFlxInR04D3WNclF9kKIT8+ET3crQ5MLqHEVpsCbFFkMcn0A00ZfW0tgLfu0Slk4lDCYwynmvgewRCIsWm2tpS+pmTrSGLHa1AWezoISIvr/4vh8p+BBUx2iPiVwoDnSi6Rwmz7cnJ3K6i28ZorVgcXTYcj7F1ajlnOEpIDfkKvcZGEMlrA0tU8gnygFcn9QeoXool59Q2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(33716001)(2906002)(6486002)(478600001)(6512007)(9686003)(83380400001)(86362001)(4326008)(316002)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(1076003)(7416002)(5660300002)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wo1BtVfGU/R+/SfPXsUqn5feWP7iCgKUw7yGOss9Xi3N+ldMVxh/PIkD5FOR?=
 =?us-ascii?Q?ULyyuuGxMq2OVUKEJ8VeyDRQWF+TCBg1Evg7JCSTpFkMmnwmU3u8BKiDVAv5?=
 =?us-ascii?Q?IWwbz4/JE77nse/lFPnMjU1cPWpRhoQTdIdXqU6sjWz5Jdlb1QjVzu/VHjdB?=
 =?us-ascii?Q?+5q7BHrRZQ+/CjEWBpC3obSHkgJJLs2i0T8Hg4vkF00h87rNlTcAQcE3vsL4?=
 =?us-ascii?Q?jrU2XxwecFiN1begAlHeOpt+61yFi76NIPVbIP389cdbcSJw9ITmV7j2iTZl?=
 =?us-ascii?Q?6MeC2EXHp04alKziPZF30bSIwQcH46B45d0H71shh7bZShPpCw/Vtbuem9vG?=
 =?us-ascii?Q?tUI5k5RL8uJsqxHOQhbmuBcwBlijsEmfA3qriDy7CqDhiB8yRsGAihFs3OvN?=
 =?us-ascii?Q?ODk8VWxS9z3u4RApd2UmSr1MIzpcCGl7Ez3oWLyVw7cBNN40myDYozbholIu?=
 =?us-ascii?Q?Nbk81ZduXH3yDbDMGautEztsenCXJpiRXw/t42RlG7FJZbLypmi1MWML1EPz?=
 =?us-ascii?Q?In8EN7htPqLLa+AiDAZw7U5L6Lqmjkbxa2WW2FjQ35eJvbHILB36CANeZQd8?=
 =?us-ascii?Q?mcyljTD/ThGPxZ3gWrXkHZkBJKD/P5S4e92oKoALP+M0HoYGkQSzlfYvTORb?=
 =?us-ascii?Q?GY3de4r3efSrC0RrUImEiW1rl6q4sPV/TRUEnzFf54dlx7WwIXA4dqelV4W8?=
 =?us-ascii?Q?vrXSRBI/o9vz82Ted7Fbzh4EO5OUIadIj9qQUiJmK98D0cjimmc3tv9tmWLL?=
 =?us-ascii?Q?RnBvWvhcLdtB9VVOoO9Eoxr5qyZP31o/PVps9H3eDV2A6BdPmNgAD17l6ZTA?=
 =?us-ascii?Q?3u+BvGrQ7bKQK4clTlQfEpx71RrSv3nz54wJGuvldg1qMCfmmFktxgLQtRjr?=
 =?us-ascii?Q?oUeaGC8IPBLZnYmX71/BzsVHAmti7iUdf7TxlTdpRDfMSlFT+bgAenC3vSrA?=
 =?us-ascii?Q?kr62ZK9HpVc0upFc9+sTaBniYV5kXDpFzWTLIv+P6m5jK9kYiDS4nUa3EbSp?=
 =?us-ascii?Q?EWOn3Ymq/SWdTq9YsGXb3Iu8xFIiExbwree826oBKh5goIg0XrqG0yu5LNdt?=
 =?us-ascii?Q?7Z73LJ37yWNTfkUDquhRuPEJvpIMNk5pZeGcr8BAjWXhi39QoDkNhWCMs5vM?=
 =?us-ascii?Q?urNYoTrbVUAkzpl8M6st98JUqSo8sTz9VB7lo1h4o0Y7xikdcBhtHtROhhA3?=
 =?us-ascii?Q?SSDb8f1Cbwhppfy5A64K1bYtjKKu7sj3c0WrD76xYAwJyrefNVuZ4tufDMsO?=
 =?us-ascii?Q?hE1foJ809/76ISV1RpsGOXyVai3Ada9IxXAyLOlTmNcZu//YffkHpfPolnBR?=
 =?us-ascii?Q?4L7f/eF8LMcnCivXnNmLEFBX/jjz8cANXX/ZBik7RBBV+EZAkA83ZIF/Jwfh?=
 =?us-ascii?Q?JVD1NoAXiJ5rCQKILxmOtjZ4rY+R+MWSYlGJm/92JDA8qpqDS8nuzw4K3LdZ?=
 =?us-ascii?Q?Jvfic4OKX9bmkI9H+EOD8n+2MdvdOv5eYg1ruqAdiFusAZ6fp4cgY8uvZtbc?=
 =?us-ascii?Q?3EQ+HkKgK3d5LW+6foZucvNffyGs0xpxd6z6jk1rsFIt2f4A5fK2GdjzFohH?=
 =?us-ascii?Q?mZ4kGAVdBX9MGaxoPyW5Nv+XgQJNCIBG6ZPZQiUJII461Rn85aTYdEPTGSNq?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WGkrh17cZCAmeZUCvgir6ZrQ8kAphabxei7cESEqJZCFoN7QVSvWFmNEmLPF?=
 =?us-ascii?Q?PYviaXG54v0o2MQWxQfwizFD0v+kQLi8yR+oqIKq3CE+gGlfBsE675xHPUwy?=
 =?us-ascii?Q?sbw8L8lIKLHB6ytW6hvl9hY3hpG6AvFKczQttu/0DusoB6Sb6uUcyAxKbQ53?=
 =?us-ascii?Q?wgqS3QfM4mDHrWb0HoitwI4TPr3nUS6CmMMADjvTkjtIpy0yR8oDPAe4IW9g?=
 =?us-ascii?Q?u2QiqgZfEV4m5rjKr7II2ceQAFur7zHqz1VqhCVCoY7MGxcdf2JkyaFBqcHF?=
 =?us-ascii?Q?XJ+Bz29QrTczAUEg3lnDmzLjM/k299j4j2URV7c+yXKK95WEIe2sv2h3cxFz?=
 =?us-ascii?Q?oKJb3pSwG6Vgn2MfjKgBxt00F10KodoSYVo8RgJZnMsk+clZfAjpfjedBqP7?=
 =?us-ascii?Q?VV4llhwU0JsFXfpH8TtGIbayE9eLexLN6xMDwtgLW5ba3V1QkGubW/dzGLhO?=
 =?us-ascii?Q?dn8CifvSJErAHC3PWUnWoG5XH9xEo4U1xUzwNyO/p+8weMyzcoV6M5aBcdbS?=
 =?us-ascii?Q?BNgLNFdDoD8N7RNxcMd0Ib7RSy7pGYMqKRqk3LSZ3ApLKRp/DFY0O9oHLval?=
 =?us-ascii?Q?Gvi2CCJSOb9i+Ei9pH58/jnFbq0/rCtAIukKwiA7QMoMwbRK0Rbk3Dh9MpAu?=
 =?us-ascii?Q?6j9VHz01oOuZ3cttL+EfD+UhDWi8yTu5uv5G9Qp7HHWAfcuE6afIP0fBEVnL?=
 =?us-ascii?Q?wMcpQwzZ0qkBosyPTH5wnSuibObVzJtmgZiNvdvekvb/Qyba/t17e8suHUyH?=
 =?us-ascii?Q?05rnD4Hh1ba3wmz+O/o6D65BSdcSqEaV4xCYKjgn02hTReSrkr4S4BwzBMSJ?=
 =?us-ascii?Q?SqospSxXgVxO2kT7HkDb+WY+F2T+Ymt9hjh1d4EkodQunqbzu1rKId46bRff?=
 =?us-ascii?Q?6W+9fKQ+7GBOC8wRcptfJN+CjZ6y0BSiOURXmyGRNgY/m9c8ddUIPh+I3rCa?=
 =?us-ascii?Q?lGj0hEHg0+GvlXzTZ1G7SmEarRkSAV2xR/2PSwgkSTkYTvC88ZtGdA4Dugxk?=
 =?us-ascii?Q?oMm/RSfwILx+V+wvAN5et8ZwXhd7mwvGn9fFccLOT3fLBS0KvI/8l42JAgfx?=
 =?us-ascii?Q?Hb4EnD4E+9F78Riv+DQWgmeWnvOX0t0fIbDDGwHJchhcMmnbEFTclRbwUHkc?=
 =?us-ascii?Q?3MWio3FhkxmV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d26f93-85b8-48e6-12ed-08db944d9ae6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:15:23.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJnATPOCV3Ai0X+HniXu9EALSZkawDPNAHC8SyWGKdDoVIrj/LexBQa4sce5dmfFkY7y8v7xI6HVeAxeXYICoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=720 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030164
X-Proofpoint-GUID: 9OnzFbU6EgbRGS8wilm8BI0XSGImZ6q3
X-Proofpoint-ORIG-GUID: 9OnzFbU6EgbRGS8wilm8BI0XSGImZ6q3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [230803 14:02]:
> On Thu, 3 Aug 2023 at 10:27, Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > While it's not strictly necessary to lock a newly created vma before
> > adding it into the vma tree (as long as no further changes are performed
> > to it), it seems like a good policy to lock it and prevent accidental
> > changes after it becomes visible to the page faults. Lock the vma before
> > adding it into the vma tree.
> 
> So my main reaction here is that I started to wonder about the vma allocation.
> 
> Why doesn't vma_init() do something like
> 
>         mmap_assert_write_locked(mm);
>         vma->vm_lock_seq = mm->mm_lock_seq;
> 
> and instead we seem to expect vma_lock_alloc() to do this (and do it
> very badly indeed).
> 
> Strange.
> 
> Anyway, this observation was just a reaction to that "not strictly
> necessary to lock a newly created vma" part of the commentary. I feel
> like we could/should just make sure that all newly created vma's are
> always simply created write-locked.
> 

I thought the same thing initially, but Suren pointed out that it's not
necessary to hold the vma lock to allocate a vma object.  And it seems
there is at least one user (arch/ia64/mm/init.c) which does allocate
outside the lock during ia64_init_addr_space(), which is fine but I'm
not sure it gains much to do it this way - the insert needs to take the
lock anyways and it is hardly going to be contended.

Anywhere else besides an address space setup would probably introduce a
race.

Thanks,
Liam

