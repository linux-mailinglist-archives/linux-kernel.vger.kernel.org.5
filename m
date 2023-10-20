Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA327D1968
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJTW5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJTW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:57:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354FD69
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:57:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KMFIZv026908;
        Fri, 20 Oct 2023 22:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MuecVQKaEy9jbatUXiXH49tEDItl1ByY7CxGwltZ8Dk=;
 b=pXnO8to5MUOqV3KGJnGY4AkjA7RMBb4+/OcqMnzvZmRCjqSRgDZW7I5XNcNoOR+HXV0f
 OO6xWlB4PWt3cZeQFiX6zQ9rdkz2/l/wseN9sQlTaRhrFcEpWOApRRz8WQjHeKidR5Tx
 hdN+5zh36s0eLpP6Qbaxf1mSNbiv8w7hmpgohK7cHeborp/xnJ0hTBHb7UpAjPKztdPf
 fdcevEF571OIcyn3/1QTCabYCeZDDYO41KK3mDBM5Xqre+lazA9mcJ04pjg0phU8FLqV
 3R34xoAj2+hoSy97qC2s2qvg3FdfaqQ5Q6rydwn0aP0oQGIOM3A64WA3virtBUdyzrCH Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwats5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 22:56:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLYHtw025705;
        Fri, 20 Oct 2023 22:56:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwduya4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 22:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqtR8juv5UWTWpKg8d+aXw3eK5ra7Mcr+I4kvnjBz4UrruGRZtIhkRz7QFsJO7fnZ9o+1gYbgct468eYmwGpGxC6uSnQr0ksMjkU2sLMML5lUfXCBBBlWvc2oHO7lAJ/9y0F1BrZy6L2bR7/U/XBAXdWbcAC9Gj0XKoYW0FTAnHFPpuVcb13N5O47Vt6FS+wh3SeXbUNZg7TWHNsz5/RX/a5SzX1UFMmPcK+3d4xVt5deO/IQVbFQvlrWw8E7ElKiJQPDrJt7j5KtqMxuw97v4/gcNx7psz98W9RL2kvUqc/qP3WuLGPy7pgsajzovj+/zOaQaK7rRH0MTllOsTDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuecVQKaEy9jbatUXiXH49tEDItl1ByY7CxGwltZ8Dk=;
 b=ZCNJzgEf3z0MSFdRocvCTxZCJNLch/EILO9OBWyZYpRG8lD4Dr0utmTXi3K8svZ6uUc6X7rY5Z8u4HbtRQO6g0a7efhOEy+bQsu+bP4AUHUo+FOP3ZfOE8Rr/03vTVSLEh/48HelH0t4lQkwNiOgT1MtjcB6dg9F+FjuQWXk8HaNQnKw5SG2+nDPS/+RufjjBozIIXC/M8vKt18wlvebB6tZ/yTwgzF/zckZ1pvZ9y3qIqSIFVrR0j0mqSDFQzBJUapuDePVDnApnKuPcSdlimqJJHTqV2Fw8ZoXMiXHeZ0x3dqhdl1uWOUT5AAeYQLa4ZGrnG3F+NZboXOsgzVdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuecVQKaEy9jbatUXiXH49tEDItl1ByY7CxGwltZ8Dk=;
 b=e2jJJtxWbZ94Ht4s5X/ra5PWCzEk1N5h7w2ip4VbL6QBcMo3f/V/iQg2y1/0jg6tjG748I9Yq6wlFxL/PtYcsBvNvlD5B5M7OZRdDl49xlRVHZHB8q14kE7zE3q9+z48PJC6NgVoJ9W5MDTHsLoJ+6b9VCXPKKgrga+/aKwCEFA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:56:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4f38:c0c1:ac6d:f024]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4f38:c0c1:ac6d:f024%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 22:56:40 +0000
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <8734y74g34.ffs@tglx>
 <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
Date:   Fri, 20 Oct 2023 15:56:38 -0700
Message-ID: <878r7wlx7d.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff7eb84-9046-4da0-b3c8-08dbd1bfd232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkTsfQOp1DXqEm/k55epC3e0/vBvKIrP7tUwSY594iqB7JhjlCv7pJhTv6I2nrE7m8XtrrI8P5aZCQ9KE4QLmD3Z0dxiVSenU6WbjjwUiyqmI48MyRqDscaNJY8QdtMGt0odg3MIh7vXhWWUb//zijRj4Ogch8kAeuIMTItAyui5eSSadfYsGK7gOhFCr/BrBcGRPa8zPfrLD6uLYu3VsQOXJRgJiexcdWSwmp5eY2LhH2DPJukV54Ix8Qp9YpaVk/JvWjDbMKYxj1XQPHhWABHhnbdXviostC/ca1r5F6VEWGnrS+fA/gr4hMT28xlnHnQbzrwpzgomqxRZb2izNWvuBTRdIgtubaE1UjpWGtRKiMRbZetzJyfl5i2jGjDMxxcgO+kktwPwDcp3Do/3HjzUIQEefJVTMW9I/J3vX6NLgZY7mbh8iRYVjICDOITBmojZ9hsF3ahTK3TIO47dTMBi5sE2bBjl/bKDhAXsQlwkvR7KZQ5+Kn1SpYEd2NfO6Mvxdl3K5GH5c8uspsJuRO6y9PbDj+1MVtRaGlGDWF6JeoFwjmj9F6tRX7sq0Z7Rvx2MsGXzR9E8h3lu0b/cvqYZxF/xDXOSyVqCWu7R5Vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(6512007)(2616005)(478600001)(6486002)(83380400001)(26005)(2906002)(41300700001)(7416002)(66476007)(316002)(6916009)(54906003)(66946007)(66556008)(4326008)(5660300002)(8676002)(8936002)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlHBuh5qcaWvfa16dkJfWngzR893qvqRD8Sm3km3A+2tEDjrRCsviKNoyE4l?=
 =?us-ascii?Q?MHfESwYdtv7uvtKILQLXd4f2qri+M3xzkHTde00I23XnxO1xTe7ApR0TP8B5?=
 =?us-ascii?Q?BGUiKWZ/SOZi4qje2ygBWcWU23uxwFofPAbSHQjmTP2Too4xksXk2GedWCrE?=
 =?us-ascii?Q?OcqVgIAq4qKfs0mnN2SSl2DRioR0AdApXakb9oc0oBW+7m5bYBP9+bDYTUSM?=
 =?us-ascii?Q?YEi49xxjUiYDu4D8a+vi4Ff0dz1lJ89IuoamyuRxECCgd2e1JLk3j9Xf3odk?=
 =?us-ascii?Q?s0CznDcXRbGX0eQ6tvX+g6e439fm/Y6cYuKUf4aLrls/G2R8ixuWZNat9vwZ?=
 =?us-ascii?Q?rj4eTpajd5yvuFetNgzfRnsisbRUNADw3vYf0KulG1/++hHxHyTKEF8D3akT?=
 =?us-ascii?Q?tY8NlCemaG8A77gLO8EVxd5C2Vnf1oer7OCwzgY7n/DRhUIasmDQHIaif+bF?=
 =?us-ascii?Q?PZKoaoOu+MjyYqybU+/m7U8OBAYm9lkV2RZQYGGztICHb0SFLWNQctEZMT7n?=
 =?us-ascii?Q?rczjZ2yXqieIPXEVc44/jYJeo803uchO7yqLlWQ7tZdj0giGi8g3Le2TNIUn?=
 =?us-ascii?Q?ppi1x27jDB4otPdDUDsmWzMej94M73xYRiGcHZ/9+LtlIYvRaH+JQXMeEMSS?=
 =?us-ascii?Q?horCgF7eCcKqMvCCW2Sm2SBRUPVC4fDrs7pm+/s0mU7uRzjhlJ2nqXusAnUM?=
 =?us-ascii?Q?JNQ/aipdkgB87VxH4lJ+6QspDZgXpU490VbyiPBSLjQrtJKk5BeZydFADk6F?=
 =?us-ascii?Q?ZzDeMECAsrmT9GzctFE2r3X2wPlPsJzYje9rGueP5wR8iYHDQXFDFL5PwZlR?=
 =?us-ascii?Q?bfyNPWVpIEkVoeAxkNdo/xABw2oig2mHmYtZG9nR26lnQuQ5WS0yqK36aUTb?=
 =?us-ascii?Q?IWL5ovx9RUg1UlIHyXMX9XWFNNXKknNqMb88nZKcL3aimDYucOEgmKBpouMl?=
 =?us-ascii?Q?+TYsE/eZw9mo9U7WS/Cpv9aBTeAKEfcAq0BS4jRFiELSznhYdM7I4rqcq+ia?=
 =?us-ascii?Q?A5Oicp9ClJXojtRiCMSZjJR+fGRfN854/kWCl82xgXhDk2O1w5NG3AKHqDC6?=
 =?us-ascii?Q?MkoDxLuyub+VpMtZStE69Yqaro1SzwU/kbDONu72Rej3aLJCgDrd2KTQRpPc?=
 =?us-ascii?Q?cH2taHslwaWaC5eH5sByOtI6EgvIkf5Dfn49tS+ZHLNNb7y8zCUpzF6A/0mz?=
 =?us-ascii?Q?Rp+gMDtU7W2bULFyLOS3H3qnYkVZPoR3DuhRnEdaTPgpQhNL7H0q1WvBtcGW?=
 =?us-ascii?Q?CPz+vrTkesZUafC8wm8o5+ISmyZFHTjRzbCZ0nSoTQVMKOSVIYUyiC0+nQef?=
 =?us-ascii?Q?hE05ZXjpesV1BovWeBfYwMHAd6vRsW4pjybvpnyjyYEF0MkmUMESPDT4KDOK?=
 =?us-ascii?Q?NFY9AQxoEfAw8IwbIkWEnDaepr2RK48BrPG0Qe464Y5fmIPekiarBblO9GvR?=
 =?us-ascii?Q?ar3YmEDdKe2zV+6/cnzpYbuik2gtQ6GyOU/4EFnuB/HNkR6lvH11ntpZ2yGj?=
 =?us-ascii?Q?HqyjBBq9V9hfnkhVUdN56Xa+c9G4GM4L+Sbx8sAYGtElb/ApCUE1Isu//W15?=
 =?us-ascii?Q?mYQxYEA2MoxKu4VrGoSs3ixRGrb9qMHlDPSK42Gw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9xgWELatBlRDzgSnvgzY847pJS2vGCQC/t1v5fSWF0MxsBQuge/IH9mdzHmo?=
 =?us-ascii?Q?OVVh9tutfZNWC+pfXw98ebtlQE+NZr6gyIUMXcT38DvEVXq92hq6S3jSpjru?=
 =?us-ascii?Q?IOfks672GLZD9VD0uPZ81llKqsMYuB80WSL8EnoK/iNsa0z7XlboiIozhg+d?=
 =?us-ascii?Q?jKXe18NQGWDjWJihhGxp/MKnhsVT7ox28HLD70F2/eBYS5dh7EUWVV9anTzz?=
 =?us-ascii?Q?KGZnt7w+G+c4FuB0iZSelrcJrtOcJpCwfkcXWaRVDzRNGPQby8RmWTyfK2W8?=
 =?us-ascii?Q?xNVtvI0olFqdCwIfYZZJ0eIhbXzzpiL+n8R7uhnrRec/uo2D9fFltqAi6w19?=
 =?us-ascii?Q?3AAvD3e2jweoms4PKWMloPf5rxsT8rxw4YqrgvvHQOeOI7k6NiWhQl9YbKFp?=
 =?us-ascii?Q?7kKGbkzyH/a0bntoZdqkh3NVmSGr/BImDx1uztZ7wbsYkCtBR/m1z8NjVYNs?=
 =?us-ascii?Q?75xQNkNtv3GiMB4e71lWpUpUEgBH+MqrjSLeCzJFrQl7Werw20+T4dmiqG5m?=
 =?us-ascii?Q?tvLgpY4mR7tStz+ocfgzzIsPxJeEodsoFFC8MmXdHJPTkcqxU8dJyrw4HPRU?=
 =?us-ascii?Q?83a90cOpFe1mE+9ptroZmSe90fgvdoqYSeX3DuH9nU9eMa3Ey4YP0Jc1YY8G?=
 =?us-ascii?Q?XUDsfs3UNO7RKbQH5Z88nGtnfZZRMnr3878hcVxTP5n0+2rb374StPomTgW+?=
 =?us-ascii?Q?MGjuIip87ZPta5ZRz9jDZqAbGOU6xDmNJaU8qihKI8SA0xaCm0Kl8zREq1aC?=
 =?us-ascii?Q?FDTf73j9dHUeOwV0XvsVGPfn4SLvc5U5aycFSIHfjdmb74t8Ep1Aw6B9cjRU?=
 =?us-ascii?Q?Wrh4QlnIsCOAqC+XgchNF98bGoJg/TZ7ocSpKPlbM4YCcsAGFdpLr+xKsl6H?=
 =?us-ascii?Q?uqBDBB2p2OW5QRWmXjVXUqFHYibV0jWd+HCXNKaT+D07qBSpK0ekfyocn4ph?=
 =?us-ascii?Q?SJLknPeVqTzOzPLNUa4EpIb/Bx5WVQYBuC7FdhugOQer2vc/QOAGVsNY1I/Z?=
 =?us-ascii?Q?50B28toZMo9GUWbCZje6jK+G3tRoP9QSPwZKOAhBUHvZeVtsSTEoDcT26ggY?=
 =?us-ascii?Q?xo4nB5ov/q2ffYoANA2mQnqowa47hLmRmKNmworoKTnSw0PdNzikUx4xzPNe?=
 =?us-ascii?Q?muzS3vhwILr9occTrAWq/gYF7w/nEvBzUnC93MF+dutZqWatXNeEgfGx/Rjw?=
 =?us-ascii?Q?Z/+DADCbq/VRI6yTuIYup2PTfG/ltRx4NzkA3NElxgtcRQIEfoC2gqYlq3i6?=
 =?us-ascii?Q?OsOxakyFqOzS2NcM2lJW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff7eb84-9046-4da0-b3c8-08dbd1bfd232
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:56:40.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zp5hvz8XbefMux5ZuTcMLEnhgsaHkZAYDeU41I6FBhLF8sRUwbXlzdSfdh794wrijohW9aWRIpY/75sibV0oDe0c47WELS05EwaWlpptmcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200195
X-Proofpoint-ORIG-GUID: Sj4lIQWKEBjMiL0gs3cYKo_-7PTKFRHa
X-Proofpoint-GUID: Sj4lIQWKEBjMiL0gs3cYKo_-7PTKFRHa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> Thomas!
>
> On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
>> Paul!
>>
>> On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
>> > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
>> >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
>> >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
>> >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
>> >> CONFIG_RT or such as it does not really change the preemption
>> >> model itself. RT just reduces the preemption disabled sections with the
>> >> lock conversions, forced interrupt threading and some more.
>> >
>> > Again, please, no.
>> >
>> > There are situations where we still need rcu_read_lock() and
>> > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
>> > repectively.  Those can be cases selected only by Kconfig option, not
>> > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
>>
>> Why are you so fixated on making everything hardcoded instead of making
>> it a proper policy decision problem. See above.
>
> Because I am one of the people who will bear the consequences.
>
> In that same vein, why are you so opposed to continuing to provide
> the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
> is already in place, is extremely well tested, and you need to handle
> preempt_disable()/preeempt_enable() regions of code in any case.  What is
> the real problem here?

I have a somewhat related question. What ties PREEMPTION=y to PREEMPT_RCU=y?

I see e72aeafc66 ("rcu: Remove prompt for RCU implementation") from
2015, stating that the only possible choice for PREEMPTION=y kernels
is PREEMPT_RCU=y:

    The RCU implementation is chosen based on PREEMPT and SMP config options
    and is not really a user-selectable choice.  This commit removes the
    menu entry, given that there is not much point in calling something a
    choice when there is in fact no choice..  The TINY_RCU, TREE_RCU, and
    PREEMPT_RCU Kconfig options continue to be selected based solely on the
    values of the PREEMPT and SMP options.

As far as I can tell (which isn't all that far), TREE_RCU=y makes strictly
stronger forward progress guarantees with respect to rcu readers (in
that they can't be preempted.)

So, can PREEMPTION=y run with, say TREE_RCU=y? Or maybe I'm missing something
obvious there.


Thanks

--
ankur
