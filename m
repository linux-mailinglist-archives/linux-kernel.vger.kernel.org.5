Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD87E4B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbjKGWCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjKGWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1F26BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:07 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJXQi014855;
        Tue, 7 Nov 2023 21:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mDFI4sydB9kqHwvHTqRVvUvHxDNxIMSqpSdqtgAYJHo=;
 b=g7ZDoTfF621NW4V+Kc0eQ552achLZLjHrdd99Q3WypcvSqm6uhFXcD4TYQI5/HLT04+S
 vZac8tHKmdi7DEJoZtWFyAHFN8cJqhGVKUMruT6XMMwraxiNjNqZN2Vof+/CRfMFG6J5
 M8trAQ/x8h5P7+F+OEUBEYeWwgdf4r9vlv1Kr68nolE8c22jPDL0vjK14aNb7MWFTok2
 ViVwQnEhlmI0UOMc90FdLwmBJV0k/Eb1BVOLuy6N30N7e9wyuuAErKusW8IUVMgJuVTw
 cEkD/yIsElGwK9yNHix6dr7DgtmM6ZoCtZ66pXiyg0I8H5NIJeHPo0F14hUlGIywUCc2 AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LItwP003953;
        Tue, 7 Nov 2023 21:59:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsj9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpW+ypHMkuYr5f78Est0tHhqCSAF3UzkaDhqORXreFxp0M2QAVhWpV6q5qN36hETRLXRso/Vi2NPrLqUSKThwnYtKTQrEUTqYW8kMt9bPClshAIMwh/nbWM7Za00M4ch8SiV8yzd9O7/IJX4UpB0r9peVsYQdkC0J0WdxxcNAxgij1IL512MxNpWveICHfylkMgjef6/4Kfe44ynjohIUKI/qN7kFrSqQLr2lqGOTDIvx+1qVe0PZYnP93FANPBwHUVDOlWlJK4bOD3gZ37BcCLTeD4gvqeBcoQBpXAp7GAWCaULbqnaqOJ+A43JSJnGThJrXKaXqraCxnSvqGC4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDFI4sydB9kqHwvHTqRVvUvHxDNxIMSqpSdqtgAYJHo=;
 b=P/cOv9UiFahoubRZPaGhgiZm7MoA5A4Hfo/y1TC0SyKxaDkhtfBFz9e8d9xvA2e6wGlRKKwKkihHm7wftgD/PI8Yuu26RaKZzXkPPRb9b8fqbBuBd1GQvFToa4XNQEga5EoXkK6N8mCVct5frMNZVthakc20Tkn64ZqXlT1lO/tnDq1MVEAWH/2NGGVxnBVeXfYN7X88QvyIreVFQ859lDvhrCrM3hICMk++7EgU0eWvmL/rAWFBFQVoRjyPC2c26jQ5H+/1wcDcwwv1xhW0VjcrTRgRsjYPgbXddGnq5esVgDwv/hCw9BYM/leNZPd7+eCADKhjXTJbJpGlQvI7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDFI4sydB9kqHwvHTqRVvUvHxDNxIMSqpSdqtgAYJHo=;
 b=JY7UFxdUzgzhq//kpK4mrqtAcmOHC+TrjufuHH3YyfjmPVRIVEpB1LlnPnneMAk3hsC8Tj8DI7SuFCvk4t3OLkSGEE8Rxxc4catyUCA7h6vSwWBLuxe6+geE0Y0CINZRA4hwCy8fx48iYI96ir68qwip1wBK18Xu9FdwCpDJ0iA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:59:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:01 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 26/86] Revert "preempt/dynamic: Support dynamic preempt with preempt= boot option"
Date:   Tue,  7 Nov 2023 13:57:12 -0800
Message-Id: <20231107215742.363031-27-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7832c970-7854-4c91-c763-08dbdfdcbfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUz9OrqudECre6ia5v0iFNVnIa09KgoQy9iP95OTQjeLp9iUNf02v6SVdnRAVnQrnmH7Tp2uwXYqyRa+dQci3ku6lRizhHP6SCgEge/DJvFHrateajcoapw37puPn+PpzDlDtcVzJ+yh68eTsKsWz/LV0DHqWirxmWDhvvzkzyGhZvyjBEqOf2/Bhje4nDmTlodM5IBWId30lJE3qt/hpwlJYowFeonBzQBwMp8hY29AB5QMxKgjSw5be/P2n3EJwD6rDyezh6sGnhav0qXuXU6BWi8XjPe6x2izD7AVT5Rd690wB3CaHGZ8sN2FGDmzelwh0GA49aLYza9pmTtosjIw8z4DOLMysrP06QoohqErS2OmltlSLS4eTFUs/GmGHoPS52UOT1HPT3Tmd5ZbI4MdCp59vY8tctm6d6sPe5kbz4kmXIG5g1OGZUFl9pCypCYhZZ39+hqZYW6iyju9AlZJH8xD4DX2NhD80WKPeRPB+lEO/XWmfPoqQDmHysBCH/TtXvOjDTbLbmBweH9PpZFN89wFzo3cJeoEjerc+D2C5R1CGcPvEhNxIR8Q4H35
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3vOWF5D6UizTOJASn9kbFkjYIkBu86aBVvIdJaA3Ti2Kg8RHFIgxXRYkWw3?=
 =?us-ascii?Q?L1MvrvnHu1wANmCGPFfYryy2vJ8GYmCccouuYRXCXaMLtCG82B/dNZlleJxI?=
 =?us-ascii?Q?wPhYRjVc6aOAiku68YZDF02wd07910kDlORf/Fg14PDqRBaGZBnXhVs9/tQ1?=
 =?us-ascii?Q?FzoJS2I9eblwwmXan8B2+il3v/h40BHHAXMMbULvL5lx4GhRQhKUPsuY9XCG?=
 =?us-ascii?Q?OFyUL8f56GHKZqdyOAAtKKCbn+VPO0JIrLDG0Ws5tzArpP8Pz12Gj0/lkFp/?=
 =?us-ascii?Q?0MjLr/7tnKrg2h+jO4QfFS0Y9UIzxNnv37X/OPmFW5zF8i4G3fx/kkPvzxE7?=
 =?us-ascii?Q?XvU+4Vwfvk16EUg3kK5B80vNBycbLbCb3vXZ1w6M/StdhMfvzzUjGbry6sOk?=
 =?us-ascii?Q?/JYavcrB/qieGnC/ZNgcgEKazCKuklzMoReMvK75enoy4oM4k2zbd7oqk2mS?=
 =?us-ascii?Q?SOZQcQGojU/2aOZhZos1NvjbUKFpLf/sWzqQqXoW7Zn6Rx8N41v7JBM1/qjx?=
 =?us-ascii?Q?RhQkL4sU9WuUlL2L+Ft70o2Yrcq4betyJEQ+KTBCnlRLxHsBWEbTDFl08VU8?=
 =?us-ascii?Q?YD57cwGybuJwJiZSRz0NW4o8cODt6T4E1Fx1mM7D2Q8vIywHe8yI4Wqgg5DI?=
 =?us-ascii?Q?V/Qd1b/Z5lDhaQRFLaGXwslx5zBe1Idw9plkI+4dgTAkExTD+kvF8gbI6aCu?=
 =?us-ascii?Q?yLhnx+KAiBz1G5+C/Iqji9MGMU9U7eyrX6/nyEqzXh0ZZnQLGMc7AvoQsbaC?=
 =?us-ascii?Q?t8qfo+3ZCmzOpE2zS6ygAi29j6bT++iOEvtYPzVdVrARTYZigdl8HZ1yapcX?=
 =?us-ascii?Q?FDGIcjf+p+XL96m2veeqpZbnns9xTZX7GhOGm45964KwOARKCJ57L0mTbOpA?=
 =?us-ascii?Q?rDrFZ0VUaAu4rI4LZozrSfrXCM5C1fXNmCCgxKMm2o5EFz6glW+/QOVoJ+Lo?=
 =?us-ascii?Q?UHlkhqZOWI6qyh1aB5OwM3lMMR2WkD+idXHHjC7i6nDTvEsVvbdry/74Xtpq?=
 =?us-ascii?Q?iAnHNDQHQZkWJXS0FjxSVtdxfrFuo6TcKMmYta/ZgrY+FlPX7tm+5Jtox5Wt?=
 =?us-ascii?Q?SzJNY2RUjXmCDE+s/Fkil39SzlVwwJup92GN3T7OltKj5Q1ONsdTpsZvZCzm?=
 =?us-ascii?Q?sacXU05lgRkTCyoAEKSZJbqXAJMGlo4uTlDYZbH6MMeeXaEuVnm7Q+sSho4g?=
 =?us-ascii?Q?Cp03YT2nCqhQZm0sW6WtCwhVI0Yxkm6pcYXMx0MS9NK5fljzOl7PeIsi9Hla?=
 =?us-ascii?Q?AB0UTv8SSvRpdV8KibNC1VE9l+w50byL3j0196KMXzKmSh9Dqou4Kde9KWA+?=
 =?us-ascii?Q?y0Knp3/OLUdWRYbwl+F6EWtRwnDq5O1Ze4FkJHUYrGcF0FE1nZJJ4hJci4dC?=
 =?us-ascii?Q?Jka42ZF7aMWj5zk0yR0d+FiiwEN1tzlkLrNJNGEnsMGS4lqjhSxLpljsBlJR?=
 =?us-ascii?Q?HJIBogNt5b8aPPiMzHz5zM+EC1vnMeXwAGgWnjEufzyuIn9R6NzybkZ+x48a?=
 =?us-ascii?Q?hXZ12lMPCCZd0gOojJ4xEqmZ0WuDYhRPharwgm0LBiVAHCMg0jXH+UdMbeRw?=
 =?us-ascii?Q?t0gijgrWZ374kmgiS8TdBXOADZ7NSLDSHCY/Hrc0CGVA2XfSXfi43DCfBFbE?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PDPUM84Cc1VWiPk/UTRnFzhaJjznOtkIV0Zh08dnrTg4Jhqmujw1CwCtjaRq?=
 =?us-ascii?Q?IDFILCB1QTewnVuB/p2WCTynbC8q8bDJqsz7nggmT0pfeGYyW/L4O1ULcqwk?=
 =?us-ascii?Q?dnGt71uuXwD4AQB5EnTWxUTbyfvgeZzeP62EL8Du3nwc3AnI0cqZuoM9A7OU?=
 =?us-ascii?Q?uRT4bushVwCefE3oI38gS3FObC3k4pZMzClAbolxVJexKAu7c3gbkhCHIcdU?=
 =?us-ascii?Q?/CdBrKKln94iwbqSZugcv3heYiM7DdQnM5HaRsVLXVTUI34asj9bL6dBpd6D?=
 =?us-ascii?Q?Y/qBFd9aWKnw1pYbzGPgONo+6C5RQ0DWSWfRPIUwtIaX3QfPrfrEpD4KKn7p?=
 =?us-ascii?Q?23sPepkZdCo2Tt18CqDh6aZ2iuNbi8qAYfxmxKOlY5oXsbiyUndVweB77gR9?=
 =?us-ascii?Q?KCJmEVMKA5FU5AYqV2kVvwgAV1ctESkAiOixqdA4sPlOXiVszWdo0nZ2FVcB?=
 =?us-ascii?Q?eKy3cojrYVBX1Cu3zazydTvFWxRakvhOAmC0KGRzM/rXYQmrwVWUIiT/8cI7?=
 =?us-ascii?Q?uDdfLWROsqol77PXrmdyzawRHxXtlGKHbtpT6cKd4wuZp5k7UDyy1WKCN/h+?=
 =?us-ascii?Q?u56eaP5sJRRDEcA4MVWVPQNoMLhc3aGlgiXwk4tXROgTADrXo06q/wKTiqoe?=
 =?us-ascii?Q?dDUgAAYPS4KiVzs1HO606kL/lutGII0GBw3Dmw4AC1eicaWo2ojfv5reYjn8?=
 =?us-ascii?Q?SAgOqPUuOYtWO0Lp6KSUMGp7z0ZB8vUyxBb2os1TPYel4t+7+sxW6sSnRA+m?=
 =?us-ascii?Q?W4hajZDPi+A6H+8yimjuZVQBzmklI6HUL5s0/87jeNepu685ohtpy2Bs16Mx?=
 =?us-ascii?Q?dVM7Jdyx7qYkRTLhVlbClGlvJTkCuAupGCffno6KVUFE3qfRZJ/iArQ0nQDu?=
 =?us-ascii?Q?do7c71XRY9+CNR7yGL6Q1/5ceSojhMm/cx95ydb6ozCBrwO6d2haTYAp/rNX?=
 =?us-ascii?Q?5Y4b/SXZb8WDFh8Llp5lilTIgeZ8PIVlSH/+lDuQZ2ZdmJftIYeVr6GK1LJC?=
 =?us-ascii?Q?ZQMCqteWfvrR/+vlIEqwxbZXmhldQVZ34K9f39F+IeinVqQmGHpCCIvLNT1q?=
 =?us-ascii?Q?28XhrzLDgeAsMmbjCPzGPPy1H8fo0T9qoL1ypD2bchahG7oINta+gVP6sa+B?=
 =?us-ascii?Q?dANaTzbGBxorrLUsxv8HzrjoVqy4EUq+I3Ds37rizKwdYqLXehjKD8QT+slg?=
 =?us-ascii?Q?SGzIw1PC+xSwky4d0NNT30KglPrA2gq8mdFmGCtnhNf7gjf79VIJ23hJvRVJ?=
 =?us-ascii?Q?sdS21c7Wjke99rKjCyS9Yw5yfBnw87FyBwLbMx7O75B5IKK84lpRMCdXGvS9?=
 =?us-ascii?Q?AeYmV3YpkwIxjLvGMWn9JGzjeeVLiA/da/t7Fm941qh2H9H0+SGnV0DWM2SY?=
 =?us-ascii?Q?oNM6bRNeXx42k6Na36YIlI8e8W2UmlXz4+tnn7lrZNPpgVEcyBqrqI8RG/ih?=
 =?us-ascii?Q?3sWQx2Jb+VjVdEZIXcIVtS/n8qpSrJ+lZy0RmG2kt9eX/kvm9GvCDv+iQDQf?=
 =?us-ascii?Q?55aBa+1on2kea+AUJecnsPGfXafrZnLUAczsV43MLs7DgtzOl5qaiIKWEw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7832c970-7854-4c91-c763-08dbdfdcbfdf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:00.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY9VKCZQN1LFF3m7eQXlDQpHrB13aFQZKXa/5w2f6CWUW21JL4lvgvuWmlCw7TNGu9x1JNR6fHnGDMNDnQS5wArkszzTHiw7ispTtkO2nBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: 3ExKpHnPgf2O8lEVz1Y4o_ZkjpOTxYww
X-Proofpoint-ORIG-GUID: 3ExKpHnPgf2O8lEVz1Y4o_ZkjpOTxYww
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 826bfeb37bb4302ee6042f330c4c0c757152bdb8.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 68 +--------------------------------------------
 1 file changed, 1 insertion(+), 67 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8dacc7feb47..51df0b62f519 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6954,75 +6954,9 @@ DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
+
 #endif /* CONFIG_PREEMPTION */
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-#include <linux/entry-common.h>
-
-/*
- * SC:cond_resched
- * SC:might_resched
- * SC:preempt_schedule
- * SC:preempt_schedule_notrace
- * SC:irqentry_exit_cond_resched
- *
- *
- * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
- */
-static int __init setup_preempt_mode(char *str)
-{
-	if (!strcmp(str, "none")) {
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "voluntary")) {
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "full")) {
-		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else {
-		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
-		return 1;
-	}
-	return 0;
-}
-__setup("preempt=", setup_preempt_mode);
-
-#endif /* CONFIG_PREEMPT_DYNAMIC */
-
-
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
-- 
2.31.1

