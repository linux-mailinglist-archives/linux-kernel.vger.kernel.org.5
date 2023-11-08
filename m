Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE367E5F91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjKHVBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjKHVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:00:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A372113
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:00:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8JiRM5013723;
        Wed, 8 Nov 2023 20:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=62SMZm3MgnQcEFW9NukrvFRBVd3Huln5lBVr8hFheEs=;
 b=Clq7wXiLK67Jvh5t/I9e8dB7xvyk1U36gDLeNYMKRu9sW9NtYlA/b0zGASJ1fy8KzWfw
 PkBlO1CRxdf8YVO0aV3G+wbjJKUfVhHlNGs0Vxxg1aU6ua2/LT5VxixL4YWmHVobV3Rr
 b1Jm9L4/qYRL4bv3R2pXz+oyhqzjC7AIGrTMHySbKgcqbZIzNepXkWhF+/v2l6Gici1Y
 9LSKrTTjLgGzaZ8glZK5yFC65rRlHkku14O7mvHzaQMXE427mbTXjYMhmni/qUf4A3iP
 PDsPduF1Ph0n3Wug+FnM51W1kSu+msoxq+4TKUTXfGWR74u3I4o1bfTiJodkaNrj4/gM Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26tgy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:59:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8KItAi011047;
        Wed, 8 Nov 2023 20:59:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcjpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 20:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfy7cglH6qcGcAsWY2XicSXaGI7X4eE3L94GsaW9xFIlZGm6u5ZpASC9PMyISN/aKyEO7ow9cQcE9Uz8Lpoclu4C0euij1V8X/WRd9T5AEWG32OjDPPJHyIVBaRe5nH1fxwDtAZ+OI9Jxfgd/hbFGCiiVAw7jqjJoQBOxtknWlxH+PpqKlZSxdpCBnd+5zsf/PoZMMCRqiOcMX8xqO1uuxOAQQglaZmbGK3fUYLN6qovjC6rhH51Ny7po/G1TvQoZvPboqIKFq2Zt0IcDdo4lWX2O+IwLd085xAMAqAHZ4g7fhve7tWnxsXClMr5wNL+r8mWNcvhzvdP91tXQLfmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62SMZm3MgnQcEFW9NukrvFRBVd3Huln5lBVr8hFheEs=;
 b=ZQeLzqrNPFlFRHHlft+Ie6II9Z3Pc1aKm9qB2B+bZyPAvUc0N2KBwTjphbq03dxxhB/6Va4jBt4nCGO+/1jPSKEyXjNtOq2GlsaCs3o8BreU8fSF0IXehCspXDAVJh5iFIMiNWqpoU2pUZB+ELh6+H+qhmolhYvhVvYRLGE5mUT4ESokaVaH5UnpPdVJhi0NhNz2h6ib5lU4/6vNAU1qw0TgcgLnfw0xMgmfS/vD6mUxun4l0topSClHqd+FzQ4lDUqSTMf3P20kkvWH2yXMyt3FAtLeimJQg1Bbq/kiVdttycbqQfkOAH9fqbimR2Qirtxwa30qf40RMRbcmPBAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62SMZm3MgnQcEFW9NukrvFRBVd3Huln5lBVr8hFheEs=;
 b=oC0xrYv/Wlk9K/dW4sU9sl8fui12m7kq+HICRhWgoBlPQLyHUSyquvPvhJ386GTUS8cCSIj5xFU8d1MsvGVuN9qKR8W5/NxWUYXg7AbyzfvZNOP4y60D4uqyinpO4eyjwlwK/YUZVp7xaNI716PAYN62b8dBr5Be5m4CvDx+ZLM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 20:59:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 20:59:12 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-23-ankur.a.arora@oracle.com>
 <CANn89i+b3=N1gT7rrrxU+zOMN_VzzHjyYW=TeE5AMSoKcdLvyg@mail.gmail.com>
 <20231108121138.114f0f15@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        "Nikolay Aleksandrov" <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFC PATCH 79/86] treewide: net: remove cond_resched()
In-reply-to: <20231108121138.114f0f15@gandalf.local.home>
Date:   Wed, 08 Nov 2023 12:59:10 -0800
Message-ID: <87il6cezc1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bba4a54-0435-4d0f-d060-08dbe09d8f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E40mGNrSZc7jeXhDeA3Tr8ZF9f04ACPPYN4isSqaoftHWXbJAaqT5T3wW+MbOdIT5elzcXrxZnfWohxBUSFEh85gDBOG8E4k9//U5q7sHH90gT5aYkBhVjFOHPOa0g9WdUFzKzT5jAzTy9qQVygrfK3/jC8Me4BORB9wHX35GQJw2MdVgCYZEnb3HRgYsZZpQDauoQi8NP91hC8axQ3zuEf3TY9Uuu94vYtry8uLBWtcEC7xDRmgxLKRDQYz8GwivUwSDOQCSqfnxjbALrJU0MygmHN7ro8Dkm9Y+NPqPU9EV+AcHdcG3p0xmuViyLNByC+2a/ISMsUlyuHH8qVyuGYohvKkphv7R2YzfXTE3cod5Av0xqkIPQtctqXtw+4HeLNo5UoBSaR77XgQuG5MkEmrqEnVoxTmJt/LgCWo9maXpa8VnKVc6HFAJN8W11/hFs7grY8ShA6JsDSqRf7IkaiTGy+1oixzwYywBLv4RIJ4i8z2JzXqfG1cV/UV11SnKScrWYIsK7FNOW/PJJjT1OGKwmcN1iYpa8XcdchDreCTD9M5Mr0tD6XchclK52F9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6486002)(41300700001)(6512007)(26005)(6506007)(2616005)(36756003)(86362001)(38100700002)(5660300002)(7366002)(7406005)(2906002)(8676002)(7416002)(4326008)(8936002)(316002)(83380400001)(478600001)(54906003)(66946007)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXk3NCXhbCg7ABPcR1uKnh+bO+ygPpvzaGi639Dr/ezwTHlTMHvT262IXksj?=
 =?us-ascii?Q?93LfNx7a1euesAHI18GPe2IKogl6ixzOER52xFIJGk/jowDcGpW1R0wrTGRy?=
 =?us-ascii?Q?85H6sctbP8PEMCaEzk/Vc3ekfFN7qOWJmwo/O4qTKnLDd2ihhQshXzfOMyzR?=
 =?us-ascii?Q?j+S0T/87I6jVkQ85QLvIYyZ9ME6Q1dKR4ONRI1s4h7S3Hog0OhnC/1KmdZxm?=
 =?us-ascii?Q?vgXKXXw1ASUeD4JPmEdmGTlIbkWmopdHAUzezDoW6p0ARdG/KkvntOtVmITE?=
 =?us-ascii?Q?XXOhegP98uYiepC4zXjL+UOclawbri2PdoXmX9Cj+tcYGMguKZsjZTZ3SlmO?=
 =?us-ascii?Q?gLCnWj68clDBCYdpPZUxq/VuCNxwD6X3iRX7r9u4S9rup8GALuJb+aLYEDmN?=
 =?us-ascii?Q?ByF+07ZBdraMW4bSt/4vBI82ySaizzzAGPdhL1lqOf0x1JjooaG7KhLMLrSW?=
 =?us-ascii?Q?uxzIGTP2ZeU4Ew+9aZmG1Yj2Nqj/qdQlhW5HVbdOHoXshlji9oj1r7/srvD0?=
 =?us-ascii?Q?6ZWw4DA7ih6GHiInp0FfjayBx/rKEZJuLTvSTqcQ6+vHUmY0x4tJojovpV/r?=
 =?us-ascii?Q?/uaqGzPn/ivSWmkrfS0T/tXB2z173ZymXepUeWeG/nIbDRwx0YYLvrNoFaDr?=
 =?us-ascii?Q?DMpVTnGiOaNV3TB3hmhox9hWHhRiT1fyyk9DTyHsfvKzCWcGig8GaV3FixBD?=
 =?us-ascii?Q?k43jFMnAgEx40AwrC6r4JKka7Mt3oSI0g49yDcAlfNFNE3EYg5JYdwbscRNv?=
 =?us-ascii?Q?a5aW/Og69cP22Mtp3KSJOa/ljfctrNOhNw/gBgg2s6p3hnTELAi3IPekgKp4?=
 =?us-ascii?Q?lI/9m1fZSUliUgqTXjwcVyPu0WeHDz8YKVQo7mRbKP8sDC6NX7rIt1vbrMam?=
 =?us-ascii?Q?5n16V+UFKVqEraXvd2AvJOS4qmnVEpXd1MbAhrFQvp7Dz3RNd6a/e9R/CEGp?=
 =?us-ascii?Q?umNpWGSaXt9LynYUUCJA3ceeAeOr4ZfZpsMFlSNkoWH0jGySGcZld2ZLVV50?=
 =?us-ascii?Q?2MTXGwj97DfFKOu/HqjgeaC/na5RkKEn5H04F7YSO0yIOgI4H24oo8D2ZlEl?=
 =?us-ascii?Q?KbLoWuHyUGVJaj6miMJ6q9CnNrGTrOQrXEMa4BvSOfgo2uK2mJ8n1wqEKKQC?=
 =?us-ascii?Q?5OAYHOCZccF1fsyb4LFBPG5HZv5rsVN91Wnff52JN6gEHPE+Xx5kMbxKZJC+?=
 =?us-ascii?Q?aSRWVf+qPcsaJmAAdEdTBLP6AkxtP5Ds3ikk4us0jAPTacxVPHHRKvlCsHdP?=
 =?us-ascii?Q?6Mqp2GfXiqHjsKvRpysAsm7+le2XfI2+hblBkI14iQtoccwsHPgfCByq9Zb3?=
 =?us-ascii?Q?E5tRW9P9GnjcpKcr/Df8EprafYrmPCswYczhvZmF7GWLZYmragIPZ+lcRKkb?=
 =?us-ascii?Q?2IgfZTn9xtXClmJTqt8EljkTaCWE3DiHdWpfA2dvFsSeWW4cPN7Lf8BNF8WT?=
 =?us-ascii?Q?M/0pGsgxkM1oDsu4GtfR6xPuoUf8H4iXVHLinfvR0wDGM0uGHBjChMVrIouW?=
 =?us-ascii?Q?OcZgSZyiJEdY/Cj+9tii+MvgjZzeAwEFGazqk993SkLNmT1KDVVOJb+7IpBp?=
 =?us-ascii?Q?Fpd5sy5+Co9NMDRGrCkLhbT8TWH3VrJBSKiFCJX1qeiSsEYbCi9L5ihkQ4tv?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kXJkcKlN+y/PLkCQtmHLi4qI7ST4B71+ehP2zwuQpuL8ffr1jZoKa2TxJ56C?=
 =?us-ascii?Q?UZMn6utWEg1CQq8Qs0lg4c6coWGLljJnhycO79+8JAzNQClMA+03LvrAdHLm?=
 =?us-ascii?Q?YAmb/1On+sHfI6uE4MAq3aspAQchq9NLYBz5kdAuF3mXE1aSCV+0/SZslQSz?=
 =?us-ascii?Q?S8XooMOXwcNdPBKi8WqA9Dhs9wSSWPSgoRhQTGYR1K7APxOPrLfxCfD2nP8O?=
 =?us-ascii?Q?oBCUhR7nBy25p1v7U7am7udDwcyBBsOGP4gA4Kum/2ZLQbjPyeEEEAy9t8qs?=
 =?us-ascii?Q?eWIlWiKmbIcOEVCOp90f81DFiGr8ctP/xQy3MI4W9HYo0VTp731NImF8573u?=
 =?us-ascii?Q?HpzHDVniCcZlzOL4/6bYC0OSjMYu25fX3SKYok44A2PYbKVBhst+wtUk6QfS?=
 =?us-ascii?Q?OWCL+KFJLHiLK68wiyPDpLTq/cjSJy6k5KaD3e5C6uecjFppaNAB8L/6KMmq?=
 =?us-ascii?Q?7bSQk2XlB5y2jyvQBi2UV4oq+wem6jeukibSMIO7cKkcSF6HZeA2jG/D3B8E?=
 =?us-ascii?Q?wOAFmZ/bG579mgcFeELDeBkVHSsxP3P2bcXcqFTyL4ovGkJUrPani3MXfD27?=
 =?us-ascii?Q?B0dsGX1Nur4N/auL2WhLjtuDcOqwd50KlREd7Xp6JdS+ftGJl2CNKEGVA1zm?=
 =?us-ascii?Q?cRIjy2onFHkSi+L9cC3YH/6njm+m1iqS1npjITtN2T4+sdN9KfoVoy8WrZKH?=
 =?us-ascii?Q?my2aacX1OyGcTFTXyJdF/f5GjNpUjUNdLbmwAr5nKWvD7TsubXhp/cFQ4mDR?=
 =?us-ascii?Q?3a3ixMlJL3D4ls34WSDfgxonDktpa1yc5vlSLdMfZlQZXcqCosp9sRYOtc2o?=
 =?us-ascii?Q?3EpQIIFfAJ/cliwx3Vrgd2yk5jmId0bPgyYcoF6hXcuE/MDcbELKdc3SJw/W?=
 =?us-ascii?Q?gIpI7ua5SEOaaDFeC8//f7N1nfDzO8qWQUJZ6Y0BVeTsMBKQFHcA2qYw6y0w?=
 =?us-ascii?Q?V4x0HL/09AGTagptB3U8g/KAAZBvNRnzHUSjhwIH2FIwAZIZilIWN7hPjoVm?=
 =?us-ascii?Q?9coXuQCYlPYxClPJMSj1YNt+MWuZKRuLVLIAwaaYFVtOsCCNlS3oYcHJwREc?=
 =?us-ascii?Q?iCBnSkyTkr3KpuYE5Y4fkIQWWXt6PhxhTN9IqEyrjf9ZSaiTL4Y4UDKXniG4?=
 =?us-ascii?Q?5JVI03kcMcVu3DgUzMxpcTcWDhEblBqVCXw+kZXxz5iHck7y8eb7szfF2E0f?=
 =?us-ascii?Q?ilp872NKv7oOQLTcnUmv5J6o/7bp8Oza8CNse1Dt/c4BdJNWExebbb4vV8EC?=
 =?us-ascii?Q?JZ46tK7V8v3SIEYS9WDV4ZW6gQB03I2Pay3THQMUu/Zp7Pqv4kmGGJPcVY4z?=
 =?us-ascii?Q?myUQV5T/P1MtlHIRfNHjpVCSmTaKU322ANX1Q/qRKWrEnM1l+g4QjKVcUZWd?=
 =?us-ascii?Q?NBSqLmzaC54h7N640cgt9sidQmV8IlE0Yj/BSlqOW/JluKngGyh8AqMqCbUX?=
 =?us-ascii?Q?7S/JuINePKzN8RxLWOBFgMHIq9uhMWfgZSOy/Fe7ntyiTFnYoMm2s8LGXbXz?=
 =?us-ascii?Q?NqYcdDOciXjpTlI2v+lJ03l1qX6f4jMkoyWBT1KhKGKaYkwhv+SYtUKKLIcA?=
 =?us-ascii?Q?0xsg1mAoWslALIodjjH8ADAwSvL8rURGpoPi7pjAXwVr71ReoFeRL/11i1bR?=
 =?us-ascii?Q?7dWfND/c28ueCV6pTlDYIluyxJmfWOH9O/ZDO3pim3e+VQ8n1wcttmB+YcCo?=
 =?us-ascii?Q?aGmKezPUKxZ6MueRh30OC+pGewZ21bkgni3ZtjOHf53pDIjx6u/QeFdMbcJx?=
 =?us-ascii?Q?yVD+uCmreRdgyaS9wbfIbnCB2avmrXn0mQn97ICw8p/nuHg4VGSQmV8Xxrvk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: YVy2h9XVxarJDV/AbZNnuKgrO5SXgLy/UukZTkPlMeJlaygLtYbAia66vhHImRgwPeUWAZ0nUxB3K9cP12IBn8VdIKD1uMa+z8jeze7Fv65iCo16dq7EDLDRieAQmZYKLI+K6kgCUosBAybCjrz8x2XcETfxFFBlbc4F1fHaQ6RofS90K1lF5fCiIbAOW4sU20KPfoljEkxPCmjPYTZjcFjSnLqwA5iXNqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bba4a54-0435-4d0f-d060-08dbe09d8f33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:59:12.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45TE5KFoVxO1qvX1hrljD8HI5dGhHfe8GBUVNXmuX1BSPumkiS9PL6CWpcaJlbFzZfmya9WFuy1/a8loo7WH4aaDHJa1+q7iDLsMAhHoLZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=774 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080173
X-Proofpoint-GUID: PMrS4iruGvQeJIk0F_nWB4EAdhmcID9b
X-Proofpoint-ORIG-GUID: PMrS4iruGvQeJIk0F_nWB4EAdhmcID9b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 8 Nov 2023 13:16:17 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>
>> > Most of the uses here are in set-1 (some right after we give up a
>> > lock or enable bottom-halves, causing an explicit preemption check.)
>> >
>> > We can remove all of them.
>>
>> A patch series of 86 is not reasonable.

/me nods.

> Agreed. The removal of cond_resched() wasn't needed for the RFC, as there's
> really no comments needed once we make cond_resched obsolete.
>
> I think Ankur just wanted to send all the work for the RFC to let people
> know what he has done. I chalk that up as a Noobie mistake.
>
> Ankur, next time you may want to break things up to get RFCs for each step
> before going to the next one.

Yeah agreed. It would have made sense to break this up into changes
touching the scheduler code first, get agreement. Rinse. Repeat.

> Currently, it looks like the first thing to do is to start with Thomas's
> patch, and get the kinks out of NEED_RESCHED_LAZY, as Thomas suggested.
>
> Perhaps work on separating PREEMPT_RCU from PREEMPT.

Agree to both of those.

> Then you may need to work on handling the #ifndef PREEMPTION parts of the
> kernel.

In other words express !PREEMPTION scheduler models/things that depend
on cond_resched() etc, into Thomas' model?

> And so on. Each being a separate patch series that will affect the way the
> rest of the changes will be done.

Ack that.

> I want this change too, so I'm willing to help you out on this. If you
> didn't start it, I would have ;-)

Thanks and I really appreciate that.

--
ankur
