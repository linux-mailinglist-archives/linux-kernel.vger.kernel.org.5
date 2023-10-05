Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD937BA6DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjJEQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjJEQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D4A559E;
        Thu,  5 Oct 2023 09:25:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395Bvi2p021334;
        Thu, 5 Oct 2023 16:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xvLmE91Cq91aWOwHUWGfhMKbokxiUFtc4zkpmIENyDU=;
 b=Cr+4sY7SAt154JosgPcFMBhdR4rbP739HvqZ93iookoUnJvuC2qYDudq6GFEIg6zy4FV
 Jy4Ovg+AzLatcWB3s1aZiKFJWEQ7rdZqJJtEGzVUWZzWsL9BnMivs95Htzzx5VLRtpEJ
 CmEclIZSL5wSd+OIpmhG32Nk53x5xiyACEQr3OmzE54xiXNwOQSwec3LLn7mMnZmg9BL
 8FdAoUJS//Op6/1hurymjphxVfw1KucuRJLTIre3WzfCNn7BQc2M6vqz7bY9fSNKor/s
 L4LKnCPTztQx84RLidvDIrGmpa9W+NxvMPyeFV9Ic9pknr60B8hgeoDe9tHT7DVdb78p Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe21cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 16:25:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395GBA8k005828;
        Thu, 5 Oct 2023 16:25:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ccka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 16:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPTOf8HP9VrG0aRI2X8+IRFQHhKmsy+UbZAXay/YFKlDP6OnXOiO/uejKArMSCCiy7HqUwUKwXrOECUw0BUSMlqofjswsM9nyminqHOHKJ88V78N2HnfqC5D13mhZr6O0vbmThb8g0NLLu2gjeMFX7dDdft98LXNL4ZYFmqJT8pHOzkcATlcc/ED4KAULMdNpbsQvzIbQPrzHfsjsGVUG6aVZ/jeApPUKTHAdKNuUS1l2yJ2J9boGUWMLvUNnpJkH8XrIgw8IwU9sPcTZGE2huqvSwQE2Ca1Z40sA6K6ewdCzJlkFwdF4PUO3z+FUjmxoHNryABx6XPmPyY8mPoD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvLmE91Cq91aWOwHUWGfhMKbokxiUFtc4zkpmIENyDU=;
 b=N1Cp8chwyOpuXrv4duqwpEQYJXA5MgxYFIwqtXfmUq63g4EY1IEIUHqeSAKcR2txoRKB8QVcqvbdI81Cgb+jp3GNQnbEzo9X4OQYefEULhEmA6wGIrFVLzCexBjQJTQLRKo3O5RO8Idxu+YaRQFo53033ngzZCBHMSzWfzCSzwD1HApxIEr8oK1HhbZFbBQmiI9yyrS5zb5xTTJ/vSohURTiw7glT68Bsf0mgCE9YliMLJJDeT+0GDxoG8nd9mRQBqr+5ypQYEpoc68rY+gaSIlYLQtoNW4ODitxxLzy+zwZFFPxEhj3qsLOUJmOdFqk3SAjHS+2MQavt96+sq1EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvLmE91Cq91aWOwHUWGfhMKbokxiUFtc4zkpmIENyDU=;
 b=V4erJlDsGUG2Vqd+yepP3q+EVonK+KoylkDFNDI1Q+VaRbOcCnwum8s3TJckpOmHmklITcKQabwzW6j/siY02GhSUN43yPzx8ZI3Pp+4paFV/yq1zvkHxIhKSQeW2BpUIL8/JcM+KC6n67rxC6xJPu8q7hpA3Q2QFVlTmcOeXaw=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by SA2PR10MB4409.namprd10.prod.outlook.com (2603:10b6:806:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 5 Oct
 2023 16:24:57 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::983a:62f5:8590:73ce]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::983a:62f5:8590:73ce%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 16:24:57 +0000
Date:   Thu, 5 Oct 2023 12:24:03 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
Message-ID: <ZR7jIxh/VNT6tMVr@oracle.com>
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|SA2PR10MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f44d25b-ba67-4a7e-085b-08dbc5bf9d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzItY88bxVT3w8Qtb5X4F9JL7qVBcwSjq6IOzy4zS+yjiTrQyr104hjgd+q9Oypt7mZ4wdwa+xJEPEopqSOcSyTFIvn1U/qrLFXpOn7mEtp1N9YLeotLYLqDnNFrsGR09zxFqywhWtVndeaPitzOatORlu8YPUF75Mb6XqifT0tlQPVUqXg4hmNGB6c9GhlwjZ+ZwNf36WbJRxP8kOW+S6Ok/29pSQ7ea3wfJ5T2RZne6E/NO0fKZslDrqj+S8jpwMQP+HwOx45ZT788vVYH5Tk2ffpssinkW+bUaWbuRrahYdG7/nyxaZ8qiivKtXaQJWKiXzXRku2wlfcjvVEGW84BoQnr948lmsuE9AbxCgZERlxZWE22k2FUdigO3NI4ZSpxk3G+RjmJNkoG9ai2GcLwZjW6BHrSeOkV3RZTmKD1aaHWo/VntnS6A/BLFMezqxBAxksvy9aqVZptCvUPlGSoL20Ap1OCTkkpl3IiScmqms2ypWFWoHiZBeSJY9++FPH4ZOhWImNlyzLTuHNJ1DFvepyPkbUPe5+hPt9yCQi/5ShMtD6Hu3i2nAp6qqtX/yhPfj2ZkuclW3QjzHSP5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66899024)(83380400001)(8676002)(4326008)(86362001)(7416002)(30864003)(5660300002)(2616005)(26005)(36756003)(6666004)(6486002)(6506007)(6512007)(8936002)(66556008)(38100700002)(478600001)(966005)(2906002)(316002)(41300700001)(66946007)(66476007)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a3AEkl0sv+R6sOlefCPEjNwfYxFtPIjQBQaATlylEXRMyf1oFcVNdftu2kx3?=
 =?us-ascii?Q?85qWJxYp+ikrzKxs4uYDSUdrATRcASPBi/a8q5vl5SgnbfVx5HGATKiIyBHa?=
 =?us-ascii?Q?BghUUPp5s65IAt3I/fy920Ip2uuTVN6aSV+G+mRzUKtprX8twqLs1lwu7gUw?=
 =?us-ascii?Q?BNTh3lp3lpNi1c6y0h2VDgHCzRiI0MCCYVCsQcZuq83HAVmXdn7rEDLqmTG4?=
 =?us-ascii?Q?yNBI84iXIC18AZwQ2sCMzH1KjvAxAy2PT+usjIcZT7O3K155uulotJNtVOzX?=
 =?us-ascii?Q?hjorndEr8doI20XxqgtcL4Cw33IQewg0k/S9tCPefYo0hGBv1cpvJdg8XOyP?=
 =?us-ascii?Q?ns8kV2NJOAtwGO+ghy3Ycf0SMGTVsnym1tsO+xPWjNfNwdpxSEjhZHCZ/Oao?=
 =?us-ascii?Q?EUPLAUIVBo2J3CLc4j8HDARIJB6gXxmx3CoHwmiHGs2H2Su4EfkunxVqFIZg?=
 =?us-ascii?Q?de8Yg47mosPA9vsrTJt9VdWrpROQEmooXW84qDDQyS2ng6pgt/5qh0gB9ntU?=
 =?us-ascii?Q?y/UzaSdolYFy4B/Y0XtHLpMjrF9jv2lZ2ZJiJy915u93NPXdzf/yxy/FDZ0W?=
 =?us-ascii?Q?ySY1UQTEl38v3bA5UF/HM3bhl/s8rSfk5sLa27CEDE8BUfeHx2EYoB0JO2jR?=
 =?us-ascii?Q?WXJVzd1fUKeAYaJBrMS2DkHtk8/dcDqi/S3ReJVX2vaPGPpIcrE2aKOkOjqY?=
 =?us-ascii?Q?uajL31Ak/SknPinAT0EO4Aej3uct44wYOQ+K4qqnz3htdgBNy1sIc9L2Cfuu?=
 =?us-ascii?Q?wA/44fsAOg+kBG7svCW/QDgr5sPFA6DmzUu+E8S/UUI3/RbHiIc+HLt+Avqy?=
 =?us-ascii?Q?6WkNPT4nrV4HMSptJEYtst5nkQV1E4ijQY5pOhJMoGjAzFlJkkCXSF6bksmz?=
 =?us-ascii?Q?sCvrr5WVj27SvCINLAmcPYuA4RcypjDxot7pcIFNRUNAgXIBh5GhTfYvPotl?=
 =?us-ascii?Q?+PXj2o2sIy5ymPYFVfxohS9qN8oEHlDMM7kTQtEWsT02CjAiHzo06rnXaK1m?=
 =?us-ascii?Q?T95O6/TpjxhWNW5bC2HxoKZQXPne/GXhyVXKJdrd6sEaP7RRxKnnzxqmx0L1?=
 =?us-ascii?Q?UQ7VfrSiMmPHMCHyCTdMoTKfQFWA8AwnHBbRxPIr4EDvdNA+BYf98HLCiYTZ?=
 =?us-ascii?Q?69+NQIMbJWI58/39hhS6nva/REzJlFoX2p2VL1GCKRbci8nJQCLScxwzgqn/?=
 =?us-ascii?Q?wgYtTae8gwjpc02F+kU4cOzKynEWTP+NFF3n3hl3rx0Zwyq2Ff61fc7TsQDh?=
 =?us-ascii?Q?FMEamMdsPdf8g0/ZRXxpl+ByDsE9ipyX0TeK/vfV7an4H8fwWPmqnWThn20z?=
 =?us-ascii?Q?DR1IuWVDAh9sRdsdsANJlhvoJAZfdkv2Hpu5xVMY0crbtlooZpqHJjB+78rc?=
 =?us-ascii?Q?w5KpRM07xYfszT3mgf9sxNqTpzeFmbxhCenspZ9RsayL/ZdV7jYW5tAU8C1G?=
 =?us-ascii?Q?MgHl0FDMQZ+9mTDhsBgy17f3pXFU2bampF72vcPZCJaG/SY7Xjd7TPmhjmYF?=
 =?us-ascii?Q?rh4tyrSPcsCMQMpsw5eHw6pP1AVGk5PCf4+NJzk5UV2IAuZp+3L1TwShOl5s?=
 =?us-ascii?Q?xQSOMeSKz8CIDFyng2wmJmX/8jBhYNVJjCeU42P/+0LziFFrTLtr9jpdc4rw?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HJjHKTxXUkMTMBNu0rP9u20sMCwjxLpnTZ1V0fYDj5VspHB+bFr+Uk/JIody?=
 =?us-ascii?Q?+JpDVLtH3unLmdVeG/98mHL9SGjKcMdJbSuPy/xPiecEyRBkghBdbn4OlANh?=
 =?us-ascii?Q?KJcS322fi5hH8c3gKFVFj7e720W/BFLI4FF29CTikgzxLGhDYQlhFFkN1iE+?=
 =?us-ascii?Q?/TjZb4G64u7R4xbi9GjiG+WvmyO+m6vPhTZvnUlzt1pY9lzhPhPn7R4I0f8I?=
 =?us-ascii?Q?k6he2HzpruPNOmRnUWdRsXETsm0X7CiqeNn4G6s3yvbfMzK4OhPGvNVHRy0+?=
 =?us-ascii?Q?yobki2CXjQKoQToJF/2JDToUDPO/P98VBVONSUmNRTB7FTCHaL7dK0N94oA2?=
 =?us-ascii?Q?nkaH5PIcr6maubQnfPjPhOeknjJr7YajehPOsJoq8bU0XdpxtlqkXmoFE0Z1?=
 =?us-ascii?Q?Da4GUThdtHPVKAgIJiyed6qICJXcl0PezzFnAuEYQ7MWG+k6W0WvD/O2FE/P?=
 =?us-ascii?Q?JYeOCma5EetXA6K5gRycQiF2gS7dMQHg88gA+lqhCOMdrXT4svht1JsFZ0Qp?=
 =?us-ascii?Q?zXYA3+/Dku81Ne03EwFn3aditaU2ArhDlBIWTOwfFzIIxARiKAtJTxQ04PdT?=
 =?us-ascii?Q?3tIQZCiMvdH5719DCj/xxHPbZt0XjmiCxKLSV55Vzw0KRieFvnGQtiJb/YP4?=
 =?us-ascii?Q?5x1Rm8aJJi7SAz1vf51usyp/1vXD6dkv8j43/M80+xP4e8slUfbeJsxl2/KO?=
 =?us-ascii?Q?uV7Dn3sf+1WHfxvkED9f/OSWaBluAHbFZoeIHyi/oErOom2w3mDOBSA2XQY1?=
 =?us-ascii?Q?rLgmM1RElOuPc+g8KnAQ75cfTF182BqB+zz3fq3KEexXXYSIiLYwj879l+UY?=
 =?us-ascii?Q?6qRXK9Ndf6loE4CYV0KkNwikmBdQUtCZv/a5xyGpkZbd/mTgacPpFcuvWYoO?=
 =?us-ascii?Q?sl+NeHW2w0nis1xAvH51Yoi8O1W9tgKwsuSvAnqow2fw/uZOowieErSNxjEM?=
 =?us-ascii?Q?ML+GQ76vHeArN/nejLmuLtenJE0dkGBBK247J8LHvC6PL1V57N+ww+ZVOvaL?=
 =?us-ascii?Q?r5zYYYahCvljqSnQM6PGHVjCDALZNNfPWH0iaqwLvLuWKHg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f44d25b-ba67-4a7e-085b-08dbc5bf9d6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:24:57.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I36yNO5/NMtoOgAyiCPQ7FcLvoUtU6vmLqULKaD2w0ugJg/9q11Mg0x8zQKkRVUM1X0DF6ktO3969mWZujcsYX6BC/ogxEascw2VqaicQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050128
X-Proofpoint-GUID: 8viHXxd4uIS5yC0Q5EvXp6NhI1eBpbnZ
X-Proofpoint-ORIG-GUID: 8viHXxd4uIS5yC0Q5EvXp6NhI1eBpbnZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:35:16PM +0000, Alessandro Carminati (Red Hat) wrote:
> It is not uncommon for drivers or modules related to similar peripherals
> to have symbols with the exact same name.
> While this is not a problem for the kernel's binary itself, it becomes an
> issue when attempting to trace or probe specific functions using
> infrastructure like ftrace or kprobe.
> 
> The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> symbol information from the kernel's ELF binary. However, when multiple
> symbols share the same name, the standard nm output does not differentiate
> between them. This can lead to confusion and difficulty when trying to
> probe the intended symbol.
> 
>  ~ # cat /proc/kallsyms | grep " name_show"
>  ffffffff8c4f76d0 t name_show
>  ffffffff8c9cccb0 t name_show
>  ffffffff8cb0ac20 t name_show
>  ffffffff8cc728c0 t name_show
>  ffffffff8ce0efd0 t name_show
>  ffffffff8ce126c0 t name_show
>  ffffffff8ce1dd20 t name_show
>  ffffffff8ce24e70 t name_show
>  ffffffff8d1104c0 t name_show
>  ffffffff8d1fe480 t name_show

One problem that remains as far as I can see is that this approach does not
take into consideration that there can be duplicate symbols in the core
kernel, but also between core kernel and loadable modules, and even between
loadable modules.  So, I think more is needed to also ensure that this
approach of adding alias symbols is also done for loadable modules.

Earlier work that cover all symbols (core kernel and loadable modules) was
posted quite a while ago by Nick Alcock:

https://lore.kernel.org/all/20221205163157.269335-1-nick.alcock@oracle.com/

It takes a different approach and adds in other info that is very useful for
tracing, but unfortunately it has been dormant for a long time now.

While module symbols are handled quite differently (for kallsyms) from the
core kernel symbols, I think that a similar approach tied in with modpost
ought to be quite possible.  It will add to the size of modules because the
data needs to be stored in the .ko but that is unavoidable.  But not doing it
unfortunately would mean that the duplicate symbol issue remains unresolved
in the presence of loadable modules.

> kas_alias addresses this challenge by enhancing symbol names with
> meaningful suffixes generated from the source file and line number
> during the kernel build process.
> These newly generated aliases provide tracers with the ability to
> comprehend the symbols they are interacting with when utilizing the
> ftracefs interface.
> This approach may also allow for the probing by name of previously
> inaccessible symbols.
> 
>  ~ # cat /proc/kallsyms | grep gic_mask_irq
>  ffffd15671e505ac t gic_mask_irq
>  ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
>  ffffd15671e532a4 t gic_mask_irq
>  ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
>  ~ #

In the same context as mentioned above (module symbols), I am hoping that the
alias you generate might also be able to contain a module identifier name,
much like the aforementioned patch series by Nick Alcock added.  We have it
for loadable modules already of course, but as has been discussed in relation
to the earlier work, being able to associate a module name with a symbol
regardless of whether that module is configured to be built into the kernel
or whether it is configured to be a loadable module is helpful for tracing
purposes.  Especially for tracers that use tracing scripts that might get
deployed on diverse systems where it cannot always be known at the time of
developing the tracer scripts whether a kernel module is configured to be
loadable or built-in.

I'd be happy to work on something like this as a contribution to your work.
I would envision the alias entry not needing to have the typical [module] added
to it because that will already be annotated on the actual symbol entry.  So,
the alias could be extended to be something like:

ffffffffc0533720 t floppy_open  [floppy]
ffffffffc0533720 t floppy_open@floppy:drivers_block_floppy_c_3988

(absence of a name: prefix to the path would indicate the symbol is not
 associated with any module)

Doing this is more realistic now as a result of the clean-up patches that
Nick introduced, e.g.

https://lore.kernel.org/lkml/20230302211759.30135-1-nick.alcock@oracle.com/

> Changes from v1:
> - Integrated changes requested by Masami to exclude symbols with prefixes
>   "_cfi" and "_pfx".
> - Introduced a small framework to handle patterns that need to be excluded
>   from the alias production.
> - Excluded other symbols using the framework.
> - Introduced the ability to discriminate between text and data symbols.
> - Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_DATA,
>   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
>   excludes all filters and provides an alias for each duplicated symbol.
> 
> https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati@gmail.com/
> 
> Changes from v2:
> - Alias tags are created by querying DWARF information from the vmlinux.
> - The filename + line number is normalized and appended to the original
>   name.
> - The tag begins with '@' to indicate the symbol source.
> - Not a change, but worth mentioning, since the alias is added to the
>   existing list, the old duplicated name is preserved, and the livepatch
>   way of dealing with duplicates is maintained.
> - Acknowledging the existence of scenarios where inlined functions
>   declared in header files may result in multiple copies due to compiler
>   behavior, though it is not actionable as it does not pose an operational
>   issue.
> - Highlighting a single exception where the same name refers to different
>   functions: the case of "compat_binfmt_elf.c," which directly includes
>   "binfmt_elf.c" producing identical function copies in two separate
>   modules.
> 
> https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> 
> Changes from v3:
> - kas_alias was rewritten in Python to create a more concise and
>   maintainable codebase.
> - The previous automation process used by kas_alias to locate the vmlinux
>   and the addr2line has been replaced with an explicit command-line switch
>   for specifying these requirements.
> - addr2line has been added into the main Makefile.
> - A new command-line switch has been introduced, enabling users to extend
>   the alias to global data names.
> 
> https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati@gmail.com/
> 
> Changes from v4:
> - Fixed the O=<build dir> build issue
> - The tool halts execution upon encountering major issues, thereby ensuring
>   the pipeline is interrupted.
> - A cmdline option to specify the source directory added.
> - Minor code adjusments.
> - Tested on mips32 and i386
> 
> https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminati@gmail.com/
> 
> NOTE:
> About the symbols name duplication that happens as consequence of the
> inclusion compat_binfmt_elf.c does, it is evident that this corner is
> inherently challenging the addr2line approach.
> Attempting to conceal this limitation would be counterproductive.
> 
> compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
> but report all functions and data declared by that file, coming from
> binfmt_elf.c.
> 
> My position is that, rather than producing a more complicated pipeline
> to handle this corner case, it is better to fix the compat_binfmt_elf.c
> anomaly.
> 
> This patch does not deal with the two potentially problematic symbols
> defined by compat_binfmt_elf.c
> 
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  Makefile                |   4 +-
>  init/Kconfig            |  22 +++++++
>  scripts/kas_alias.py    | 136 ++++++++++++++++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh |  21 ++++++-
>  4 files changed, 180 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/kas_alias.py
> 
> diff --git a/Makefile b/Makefile
> index 4f283d915e54..f33c179f4cc3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -488,6 +488,7 @@ OBJCOPY		= $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
>  OBJDUMP		= $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>  READELF		= $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>  STRIP		= $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> +ADDR2LINE	= $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
>  else
>  CC		= $(CROSS_COMPILE)gcc
>  LD		= $(CROSS_COMPILE)ld
> @@ -497,6 +498,7 @@ OBJCOPY		= $(CROSS_COMPILE)objcopy
>  OBJDUMP		= $(CROSS_COMPILE)objdump
>  READELF		= $(CROSS_COMPILE)readelf
>  STRIP		= $(CROSS_COMPILE)strip
> +ADDR2LINE	= $(CROSS_COMPILE)addr2line
>  endif
>  RUSTC		= rustc
>  RUSTDOC		= rustdoc
> @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP := 1
>  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
>  export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
>  export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
> -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..d45dd423e1ec 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
>  	  time constants, and no relocation pass is required at runtime to fix
>  	  up the entries based on the runtime load address of the kernel.
>  
> +config KALLSYMS_ALIAS_SRCLINE
> +	bool "Produces alias for duplicated text symbols" if EXPERT
> +	depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> +	help
> +	  It is not uncommon for drivers or modules related to similar
> +	  peripherals to have symbols with the exact same name.
> +	  While this is not a problem for the kernel's binary itself, it
> +	  becomes an issue when attempting to trace or probe specific
> +	  functions using infrastructure like ftrace or kprobe.
> +
> +	  This option addresses this challenge, producing alias for text
> +	  symbol names that include the file name and line where the symbols
> +	  are defined in the source code.
> +
> +config KALLSYMS_ALIAS_SRCLINE_DATA
> +	bool "Produces alias also for global variables names"
> +	depends on KALLSYMS_ALIAS_SRCLINE
> +	help
> +	  Sometimes it can be useful to refer to global vars by name. Since
> +	  they suffer the same issue as text symbols, this config option
> +	  allows having aliases for global variables names too.
> +
>  # end of the "standard kernel features (expert users)" menu
>  
>  # syscall, maps, verifier
> diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> new file mode 100755
> index 000000000000..7c6b7045081c
> --- /dev/null
> +++ b/scripts/kas_alias.py
> @@ -0,0 +1,136 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati <alessandro.carminati@gmail.com>
> +#
> +# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
> +
> +import subprocess
> +import sys
> +import os
> +import argparse
> +import re
> +from collections import namedtuple
> +
> +regex_filter = [
> +        "^__compound_literal\\.[0-9]+$",
> +        "^__[wm]*key\\.[0-9]+$",
> +        "^_*TRACE_SYSTEM.*$",
> +        "^__already_done\\.[0-9]+$",
> +        "^__msg\\.[0-9]+$",
> +        "^__func__\\.[0-9]+$",
> +        "^CSWTCH\\.[0-9]+$",
> +        "^_rs\\.[0-9]+$",
> +        "^___tp_str\\.[0-9]+$",
> +        "^__flags\\.[0-9]+$",
> +        "^___done\\.[0-9]+$",
> +        "^__print_once\\.[0-9]+$",
> +        "^___once_key\\.[0-9]+$",
> +        "^__pfx_.*$",
> +        "^__cfi_.*$"
> +        ]
> +
> +class SeparatorType:
> +    def __call__(self, separator):
> +        if len(separator) != 1:
> +            raise argparse.ArgumentTypeError("Separator must be a single character")
> +        return separator
> +
> +Line = namedtuple('Line', ['address', 'type', 'name'])
> +
> +def parse_file(filename):
> +    symbol_list = []
> +    name_occurrences = {}
> +
> +    with open(filename, 'r') as file:
> +        for line in file:
> +            fields = line.strip().split()
> +
> +            if len(fields) >= 3:
> +                address, type, name = fields[0], fields[1], ' '.join(fields[2:])
> +                symbol_list.append(Line(address, type, name))
> +                name_occurrences[name] = name_occurrences.get(name, 0) + 1
> +
> +    return symbol_list, name_occurrences
> +
> +def find_duplicate(symbol_list, name_occurrences):
> +    name_to_lines = {}
> +    duplicate_lines = []
> +
> +    for line in symbol_list:
> +        if line.name in name_to_lines:
> +            first_occurrence = name_to_lines[line.name]
> +            duplicate_lines.extend([first_occurrence, line])
> +        else:
> +            name_to_lines[line.name] = line
> +
> +    return duplicate_lines
> +
> +def start_addr2line_process(binary_file, addr2line_file):
> +    try:
> +        addr2line_process = subprocess.Popen([addr2line_file, '-fe', binary_file],
> +                                             stdin=subprocess.PIPE,
> +                                             stdout=subprocess.PIPE,
> +                                             stderr=subprocess.PIPE,
> +                                             text=True)
> +        return addr2line_process
> +    except Exception as e:
> +        print(f"Error starting addr2line process: {str(e)}")
> +        sys.exit(1)
> +
> +def addr2line_fetch_address(addr2line_process, address):
> +    try:
> +        addr2line_process.stdin.write(address + '\n')
> +        addr2line_process.stdin.flush()
> +        addr2line_process.stdout.readline().strip()
> +        output = addr2line_process.stdout.readline().strip()
> +
> +        return os.path.normpath(output)
> +    except Exception as e:
> +        print(f"Error communicating with addr2line: {str(e)}")
> +        sys.exit(1)
> +
> +def process_line(obj, config):
> +    if config:
> +        return not (any(re.match(regex, obj.name) for regex in regex_filter))
> +    else:
> +        return obj.type in {"T", "t"}
> +
> +if __name__ == "__main__":
> +    parser = argparse.ArgumentParser(description='Add alias to multiple occurring symbols name in kallsyms')
> +    parser.add_argument('-a', "--addr2line", dest="addr2line_file", required=True)
> +    parser.add_argument('-v', "--vmlinux", dest="vmlinux_file", required=True)
> +    parser.add_argument('-o', "--outfile", dest="output_file", required=True)
> +    parser.add_argument('-n', "--nmdata", dest="nm_data_file", required=True)
> +    parser.add_argument('-b', "--basedir", dest="linux_base_dir", required=True)
> +    parser.add_argument('-s', "--separator", dest="separator", required=False, default="@", type=SeparatorType())
> +    parser.add_argument('-d', "--data", dest="include_data", required=False, action='store_true')
> +    config = parser.parse_args()
> +
> +    try:
> +        config.linux_base_dir = os.path.normpath(os.getcwd() + "/" + config.linux_base_dir) + "/"

This logic normalization fails when you are building the kernel in a directory
that is symbolically linked to another fs.  E.g. I have:

	/home/kvanhees/linux-stable

which is a symbolic link to

	/local/linux-stable	

Since /local is its own fs, the above normalization expression renders the
passed-in basedir "." to be /local/linux-stable, but addr2line is reporting
filenames under /home/kvanhees/linux-stable

> +        symbol_list, name_occurrences = parse_file(config.nm_data_file)
> +        addr2line_process = start_addr2line_process(config.vmlinux_file, config.addr2line_file)
> +
> +        with open(config.output_file, 'w') as file:
> +            for obj in symbol_list:
> +                file.write(f"{obj.address} {obj.type} {obj.name}\n")
> +                if (name_occurrences[obj.name] > 1) and process_line(obj, config.include_data) :
> +                    output = addr2line_fetch_address(addr2line_process, obj.address)
> +                    decoration = config.separator + "".join(
> +                        "_" if not c.isalnum() else c for c in output.replace(config.linux_base_dir, "")
> +                    )
> +                    # The addr2line can emit the special string "?:??" when addr2line can not find the
> +                    # specified address in the DWARF section that after normalization it becomes "____".
> +                    # In such cases, emitting an alias wouldn't make sense, so it is skipped.
> +                    if decoration != config.separator + "____":
> +                        file.write(f"{obj.address} {obj.type} {obj.name + decoration}\n")
> +
> +        addr2line_process.stdin.close()
> +        addr2line_process.stdout.close()
> +        addr2line_process.stderr.close()
> +        addr2line_process.wait()
> +
> +    except Exception as e:
> +        print(f"An error occurred: {str(e)}")
> +        raise SystemExit("Script terminated due to an error")
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..c110b0f58a19 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -91,7 +91,12 @@ vmlinux_link()
>  
>  	# The kallsyms linking does not need debug symbols included.
>  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> -		ldflags="${ldflags} ${wl}--strip-debug"
> +		# The kallsyms linking does not need debug symbols included,
> +		# unless the KALLSYMS_ALIAS_SRCLINE.
> +		if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> +		   [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> +			ldflags="${ldflags} ${wl}--strip-debug"
> +		fi
>  	fi
>  
>  	if is_enabled CONFIG_VMLINUX_MAP; then
> @@ -161,7 +166,19 @@ kallsyms()
>  	fi
>  
>  	info KSYMS ${2}
> -	scripts/kallsyms ${kallsymopt} ${1} > ${2}
> +	ALIAS=""
> +	KAS_DATA=""
> +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> +		KAS_DATA="--data"
> +	fi
> +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> +		ALIAS=".alias"
> +		${srctree}/scripts/kas_alias.py \
> +			--addr2line ${ADDR2LINE} --vmlinux ${kallsyms_vmlinux} \
> +			--nmdata ${1} --outfile ${1}${ALIAS} \
> +			--basedir ${srctree} --separator @ ${KAS_DATA}
> +	fi
> +	scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
>  }
>  
>  # Perform one step in kallsyms generation, including temporary linking of
> -- 
> 2.34.1
