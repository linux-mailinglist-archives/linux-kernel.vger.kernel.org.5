Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD07E529F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjKHJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjKHJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:25:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68992;
        Wed,  8 Nov 2023 01:25:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88tiO9017958;
        Wed, 8 Nov 2023 09:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3W/FdNqU4IjS50pGARnGXxX1xMwrS4F8QJKbg/jPrmA=;
 b=VRaNLic8f8M3K1IZit02fQZ2Wmb+Mm29qWL+7CckbTLBW6nP3h/hhsWH4+Dw+rVa8PPo
 TV4UrlpcL13sqs7xWeubdPXsN79RQ4TcGjtf0yd0cN0eR6Hq7/ExpaniI6Wlc34FDKGv
 r1HKONEeTMHryBEINDF9RR401TfPHvg6AQtR4kawAW2T942yJujkxKMpPkXsZHPeCWDA
 QTDcsiXyKPN8TW+3e1I3VgNv6ojdgaQTiDnTbtGUP4NCripRC7qT88GDUKp58zrkj2F+
 MoGq2LWpWU6EsAvLndW4mKgLMAecNaFjtqcg0AyZdtzjVkh/IB5Dz2l8RDrAkUji3h3z Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w231198-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 09:24:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88BjQj003959;
        Wed, 8 Nov 2023 09:24:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wex24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 09:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoNJZ6EFvXEm6bUCpBWMV5+jXjnN6NFioZWfuO3aY29pVDCmwrjdk7OhJBOrcY9sLP5PvVMNAAURNVQmj5cY1LH4Z76G6xUzYlhqwfF3k8C8k1loceAIRaI/PU4cXj/v2atfX2MnBKDOKbTJCK3AaQg5sWYQGqHL68dtnCtEl1a5ND5le1dEPfINK89mBQ8IO547bYMjiirZA81RjcZZZ//jxX7jUKqIWDY6e8yVKsk9BOA5B7cBs2dGtKfEqfDDP0ObqSOnravQPy1qDIKf/Tgjl3Ow0yYsASov0wckT/hOZhLCTeOEe0O5hAel5u8p3q/AkzM6rbKyxsObtNy+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W/FdNqU4IjS50pGARnGXxX1xMwrS4F8QJKbg/jPrmA=;
 b=Z7+cGovNyO6PuYnSCOAzg/x/8dQIT3Q/0zMJLYbREKRkPg55ro54tnpkEsaXJG/rJpnSCgZC+b2Ttw95EjxpoI5lkJr2jIX5CnYK+phR/tu9jPAgd9fL0PGgHmLi7lVdWr7qxiQGqYO0YfMyrOsK27Rt/If5TmIQak0qS6ngImtxLTT5eh1xKlQ00l5svY9H+mZDbVOgVkpW4VGWQEKfopnC0U3T7rf0OXLZE/tBydkU0biaF6q4jVVTEmIECea/Jnl7jklRt4O5pHZhWeDKEXQqy5XgK6UBSdEA+v9+EP5ckq+awp9daohHZ8j7JlibL8zuJ5IfVDqzdMKkIgw2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W/FdNqU4IjS50pGARnGXxX1xMwrS4F8QJKbg/jPrmA=;
 b=EMRM4vLHsN35Ue0gNWKF1snzwUBRzV3TgBUJsz9MvZ1gsH0g9rW2Do4Rp1/JNq0b5d28DZnbN3UiknygWM54NK1Z6XIUIR0re1UVa83oZF7pI/gwDcjNCyGlc4N4n3xMk/5UezYTs5B3a+92TFxClAGW/lJr9v+XchstGA5gD1Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4402.namprd10.prod.outlook.com (2603:10b6:303:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 09:24:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 09:24:12 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-47-ankur.a.arora@oracle.com>
 <20231107191953.6b44790b@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [RFC PATCH 46/86] tracing: handle lazy resched
In-reply-to: <20231107191953.6b44790b@gandalf.local.home>
Date:   Wed, 08 Nov 2023 01:24:10 -0800
Message-ID: <87msvomwcl.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ee8ea8-905f-4719-fd4e-08dbe03c7815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8KisfBux2y1JYgfP+0B5CRBuXs8S9cYqaeyF3ONJfSjItdu14jNepdJx8J0UIRqv7ca6ev2LAzbBhG7SmuKnJHOoZF74FOH8exbqbLgDtlRZkmHrKGZOq7kv5/QIq5RE1wdJU1xQGRjVtSo+eX/k9yJNTMjOS6vZgcEwqM/SPXraBQIGUv2DzHy/N8c1X1stZAX24sb2OsTpPtloJGPkWBERiibxBjQmZNM/CJrUc9aOAw6Cjjvn3YDib8d/ki1+ErNOAGsB1+SzHqPgcnKDw06tHczLHrjPKJjDcK+liDjhF3Cxlo3BMqVNRCU90wAEOL9Tzd3Q192dvURK8vWKX/MK9unqyQR4NUyBlINYpiBpSxfZmf3R+R3feBoCbgtPI8wj32bq2anF8r1TS1IMD3S+TNtE3iGWKXSZszgOV5m/nb1a9Al9GXvAOvI6rJKWwsFIU1cU+T2NRt/4+T4NzeSkUqDGn+gbr1LrRTgIlE/2wxb0e03dTPqVRbAXvg2NtC2tnHbZ/mUJUht2p11zTvf5Xgax/8FAMJBa/FmOs9meJREH0yGK6FOzkXMdqgm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(6916009)(66556008)(66476007)(66946007)(54906003)(36756003)(6512007)(6506007)(2616005)(26005)(478600001)(6486002)(38100700002)(83380400001)(86362001)(41300700001)(2906002)(7406005)(7416002)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDdQAJgNL41sMttVwf5VeKlMPOm1Jq+jcYMej4HSGt2LWWgjkfELadfhVjxK?=
 =?us-ascii?Q?C24xhp9AcfdxkkFMi02vNvTf4v4Aefw3z9632MO/DVEOyD29N+gsEbF75nmt?=
 =?us-ascii?Q?46faVb0Me1N7yXnxJZs43fxMDLqoJaP1vwhEo1x66sSFcnhKytdBL1q26ZQW?=
 =?us-ascii?Q?GMQRud4TednRHK8IDv+Xp2A7yXhhrRpRr+I/tDfXQsAvYZVM6qnE/9nfUnGz?=
 =?us-ascii?Q?UPbuZrlAb2Dfm1hmbS49zsXdx+V7qSNCktmadsJi6a/pGLW/SXXu5DfC1cx7?=
 =?us-ascii?Q?bkKjBhfd/ak+GTr1lti1ZNHltvk/Hv7FI1LadmEK7q7j9I5iV+JtSGQpjVbh?=
 =?us-ascii?Q?W+1Ln1oMuhoRE1ihiqWxq1f+DlQx8c5OxokUr5UgsVhDnNtA/mPMCX6+jqZK?=
 =?us-ascii?Q?W7QrjAMpLXtYXqXMwgzTPhKxrJYzaZsFATGm2XHk/0qB4aVGbhLcZckHdnTe?=
 =?us-ascii?Q?7fC7jie03wLDPlmUyPhInjgVLxCZb/6kZ1KKGtfAwR/P8fRx8his4u5w6V7e?=
 =?us-ascii?Q?kXx68Tgj01MvWwcFDhN0a9wGKKAqMEPbTZ8lri+2DqW/1jXc1ggJJ3VjoDuA?=
 =?us-ascii?Q?vV9fOtS/7UzmToEhoJLI8yJJ9n8RdcE++eEEKsrG1WfYrZdYEtQoVI8N6+oa?=
 =?us-ascii?Q?n5Adsq80h2pVK36rb5NB5AY4GN2RtMH4c4Y6F1yBv0n+2YCtXzmfGS69t+6U?=
 =?us-ascii?Q?7nMTZFqxJZcEwF3UO1ryqVxvTAm6O1iKbAHu2w3lEhdrqySNDKfGkYuUwF94?=
 =?us-ascii?Q?yJ0z6I5V1k2W6eKnul8MP9BgXWfqE2IAdP9fgfq2Ifbe2bFm9ISdTRZsdc+Q?=
 =?us-ascii?Q?SqVS+1SpK7s1bV1uvrzt16impzFyfkNQRlPke/uv+qsaVab8iKIKKHJpE9Pj?=
 =?us-ascii?Q?sxfb+bcRusiX3Vd7UybIJg5RK838Alb+cuqDidY55LIlQ3oVIdQDsPY69dt9?=
 =?us-ascii?Q?Z1SAt3fy1J458ejG1uth3/cyBKOvp5MyT3dIY4uqj4MUXjg1bGMSCFnx2dJw?=
 =?us-ascii?Q?QmRpsHRN7UW38D9p9LNFtqDF+dIUdlUf61+E5RFbwTNEsoUz91SL58YAIk5J?=
 =?us-ascii?Q?1iDQZElIPZ7X57iPF6oj+KMBJESX7NWVmlGAKvhf5hmFtrQdSL7mUf8c7fGm?=
 =?us-ascii?Q?4b6e6LxcD2t7IJJrZ8Jwhg8aTqMf05rTUNh2ppmuv+zc7jZ14Tmoe08X+k61?=
 =?us-ascii?Q?waZV5txcWLk1kp6F/dy4GQNWbFhFP4ltp19LhdknIk8rWRfDUF8MvYFODu1V?=
 =?us-ascii?Q?a7utXuP5cnh9SkJsR1vjBkKRi3F+SWIqqlfJBVwFgnYzMqDglriy0LBtqox5?=
 =?us-ascii?Q?Yt2Qdf4Pt/0SG5bpaWn17I+L5h9hR7vCJCbUoFvfj/QwRQYvvn88p6HA7koA?=
 =?us-ascii?Q?SOQAIFeOSBTK5mCwVTPY/RVmeys1VUrj1+L2Zu0kcNO5NHjJYwXNPOPUlm/W?=
 =?us-ascii?Q?jU1RfpMCb+bmLT9F21Bsg8V7KD09JsXlLlOSs26V7VcnuIAoana2qwLeRJBx?=
 =?us-ascii?Q?jaCf3VZdzp8W9V89V7tpigCTcIZR8KFNx/vmJv/s6MJFH7Z44l/naTHITqzl?=
 =?us-ascii?Q?UJDMct8pVOcrCQMCA5MPAOBAcHCF04yOLyJcWl94/FkJHf6eqc0zZ+lxpazq?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?k2IxfPqdHjpYMVZMl658CF7qCmvDmOr4/gggLQhUIjDMhDMY8xLd5Tt0lldT?=
 =?us-ascii?Q?LuHRsQSh4cII4PMogIQW0hdppBAKh/NCUnLoF/uliUes4yxIMuNrJeRTCcRl?=
 =?us-ascii?Q?T+sQYekPjYdj5zDnaL/paIPZRWNFXiOjR01gN0hBfAeP4ZjT1k+SaLVv+k77?=
 =?us-ascii?Q?CnWy1eJI4z4gU7nUvUj3ZazlvoavjaG2Mqg22QtL5FTGxUgA8Wm7dZmodzhA?=
 =?us-ascii?Q?91faiPQShAn8D2axn4+15w3DgyXDcpuRsc5yeiS0rlnljVd4wZxamDd9MyWD?=
 =?us-ascii?Q?xDevIysa0Vh6AEM+n4e0qakG5NHwqmK1fFLZnXEktzmfFF7GkwnNhDLh9o9i?=
 =?us-ascii?Q?VonbIc+pU5eQ5HPNOkosUSMd4KWQHYggTGg/2gwgC1A2oTLW0xfLXz1LQ+gy?=
 =?us-ascii?Q?v864ViPFbUn5+t8Zs9t//KdWGzHt+4AZ2q7lSQf8ITL+sKYPjAMkRlCJoV7c?=
 =?us-ascii?Q?rI3AuIvlZe0X/PS+sHd2uSnke4JQ6u7UJHaB3Tc7ISyAiP+v19izBCR67Jp7?=
 =?us-ascii?Q?2zp/kKVgTwBoQYuIUsJQ06bm6xRXDDTNefk7u4qBfJtugN7LXGfXfdtRPjuU?=
 =?us-ascii?Q?jqBJuPNJIzzWdCc2UZXY0qNc7dM1KY78zJibOcLrIhAiHEZLlUwlKvfElcFw?=
 =?us-ascii?Q?tvnNHhFRexM+Nho+ntPSwCF4eVIFHsVf8wkFOtyMCnXdC5WmqJ5i/NhDXvqp?=
 =?us-ascii?Q?mN/Wr+oWrFRnEoc7lFnB6PbPV6yvSNqh33RCo1M/zf640H5iQ/2o0rNk3Sm/?=
 =?us-ascii?Q?0yuGjhZ+pmi0YgUDKXCU6qYflvR20g7U/3STCvnH6k+pTpLLD3hYC5/2hp9d?=
 =?us-ascii?Q?mPhuCNXuJjqaBKRZAGLlPuO/NYuvDSrVrlTpvD+tuBbgcLoPYYB3K7+Mei2Z?=
 =?us-ascii?Q?yb1AjjZYQTHIH8LO0Cl6gsc+2oYgwk70r9vU0xvBhLLy0UHsLnl6KoFMR9WU?=
 =?us-ascii?Q?d8tDbTVDaLL0Gboz7JFiew3Vrd1gQVfl+TgtjvlX0Nz0fmdkdeKeY2oPugD/?=
 =?us-ascii?Q?iHtW/wfEC3QGrByRy68FnOq8T3RsssFe1E+xceHb3hS6aFeJ4oAxal0BbcMH?=
 =?us-ascii?Q?7t8FJUtj5spMWywJG5yIENG758JA4Dxc9BNN0XwPse3aveWmvHejPow6IbN3?=
 =?us-ascii?Q?EBxu95cXwqrvVPBDJzOfCI1k2thEJZjElY66W9MxH1kyWRFeaZDU4jWqVVsF?=
 =?us-ascii?Q?zKi3R8j7uXlVZmwfA7ptRuOGwzw/6vnjnMAFBEhXS+DZQnklizTFCIissHAH?=
 =?us-ascii?Q?0LTKxspW7KWQDjhpxxQeKPc6LJ8ExFx9OftGNiTjjU6ktrlBM0CaWDeuFJtR?=
 =?us-ascii?Q?SQrDnStdO4m2rnyJxg9YDwl5mZGMxv7oiS4Z60wg5ThRdMFxG0md0rL4Re3q?=
 =?us-ascii?Q?KcOVbrC7qxzKinFKTm4MR9nrI0FKOVmYENs94hVD5vP9sNozSsrxxsdMgJ5k?=
 =?us-ascii?Q?iUlnL4ZX6z9gu4XspkbcVgumRSG5R9zqOwae2VjsRmivtCVGh0UsftWbRhLL?=
 =?us-ascii?Q?55yv1leeXTfT4eP3heieY+IUbuucaJ0fbH9pE5ZtLHUXL9oErhL3yR3QyXnO?=
 =?us-ascii?Q?HJdJE79sl862agaGf8t0hxhgDox37lTsbK4qJZWU2vZbBcRImau1lUaRHKZJ?=
 =?us-ascii?Q?kI/7JsNPz8hhKRf1hWvolnBMmfcX+YG7mhlccI8mbO8o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ee8ea8-905f-4719-fd4e-08dbe03c7815
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:24:12.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8es8AXRNgHeeY0oYfafVYho/LYHvwJzbbReHTVB+oqum6+4TiRQps54QpWrMvs6LbgrpMhMLjvpQCCj1TG//CA5v1Ns8ftLzndVJdjMqgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080078
X-Proofpoint-GUID: F1defN30c6kP1zk9vkv-Y9m8nopBk9ae
X-Proofpoint-ORIG-GUID: F1defN30c6kP1zk9vkv-Y9m8nopBk9ae
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue,  7 Nov 2023 13:57:32 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Tracing support.
>>
>> Note: this is quite incomplete.
>
> What's not complete? The removal of the IRQS_NOSUPPORT?
>
> Really, that's only for alpha, m68k and nios2. I think setting 'X' is not
> needed anymore, and we can use that bit for this, and for those archs, have
> 0 for interrupts disabled.

Right, that makes sense. I wasn't worried about the IRQS_NOSUPPORT.
I think I just misread the code and thought that some other tracers might
need separate support as well.

Will fix the commit message.

Thanks
Ankur

>>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/linux/trace_events.h |  6 +++---
>>  kernel/trace/trace.c         |  2 ++
>>  kernel/trace/trace_output.c  | 16 ++++++++++++++--
>>  3 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>> index 21ae37e49319..355d25d5e398 100644
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -178,7 +178,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
>>
>>  enum trace_flag_type {
>>  	TRACE_FLAG_IRQS_OFF		= 0x01,
>> -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
>> +	TRACE_FLAG_NEED_RESCHED_LAZY    = 0x02,
>>  	TRACE_FLAG_NEED_RESCHED		= 0x04,
>>  	TRACE_FLAG_HARDIRQ		= 0x08,
>>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>> @@ -205,11 +205,11 @@ static inline unsigned int tracing_gen_ctx(void)
>>
>>  static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
>>  {
>> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
>> +	return tracing_gen_ctx_irq_test(0);
>>  }
>>  static inline unsigned int tracing_gen_ctx(void)
>>  {
>> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
>> +	return tracing_gen_ctx_irq_test(0);
>>  }
>>  #endif
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 7f067ad9cf50..0776dba32c2d 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2722,6 +2722,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>>
>>  	if (tif_need_resched(RESCHED_eager))
>>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>> +	if (tif_need_resched(RESCHED_lazy))
>> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>>  	if (test_preempt_need_resched())
>>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
>>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index db575094c498..c251a44ad8ac 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
>>  		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
>>  		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
>>  		bh_off ? 'b' :
>> -		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
>> +		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
>>  		'.';
>>
>> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
>> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
>>  				TRACE_FLAG_PREEMPT_RESCHED)) {
>> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
>> +		need_resched = 'B';
>> +		break;
>>  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>>  		need_resched = 'N';
>>  		break;
>> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
>> +		need_resched = 'L';
>> +		break;
>> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
>> +		need_resched = 'b';
>> +		break;
>>  	case TRACE_FLAG_NEED_RESCHED:
>>  		need_resched = 'n';
>>  		break;
>> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
>> +		need_resched = 'l';
>> +		break;
>>  	case TRACE_FLAG_PREEMPT_RESCHED:
>>  		need_resched = 'p';
>>  		break;


--
ankur
