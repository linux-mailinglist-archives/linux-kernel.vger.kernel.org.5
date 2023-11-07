Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26D97E4B60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjKGWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjKGWCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B72D50
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:13 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjiM005490;
        Tue, 7 Nov 2023 21:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=abad33qGN+uklk+IGGebiQpetbLRlFgeX9ut1oMLtiw=;
 b=wT9Iga964K+b3GdLrV7suhQ7EiLsrO2kzCSQOLlqHeH4UBGOmGIwo2EPs3eISN9We+yu
 4y3bEi+nnHwJXfITjV2UPPQ9dbH4sONjM88osUWrcqlUnTaWMl01qQrRYjBdGU45k0+l
 0DWIrZl2pZMSSuH0FZhK6Rsr5cWLn80iHhsnPTn+awAYGmOOqRwfZF+ddKs8+PtxNvPI
 I3EZn22pUrl/2LC70OZeqvw0SRtNp5KI4srIzZnVgu/CylZFGsWA2+cMPPlKyQP/zQzW
 8+6wcWJOqsl6HjmS2e944hWtL3OyrM1/koemPuuF0FuXSJljNllw9sIeG7WuFNFlYykd Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIoFo000377;
        Tue, 7 Nov 2023 21:59:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsksb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT3P6mT0ncRX1slcUtorTexisdq9agbSU74y8R19YJCgupfz6XvYYNFlCpT+m7B+Uj7Myp4vYapV18H3PxMAyKVwMzF3+T+H9r8Bv2f8TqqUUeWZrvXcDAI5WCCEorjws33s9qXZV108rPp/grJyjM3eB9lCEht48N6fyd2guP2sQLkJgNvQByo+cv/w3GfsodtVYydFHjzq/kdD7S+p26UcBOk22cwZTJB+Obst7e4eSupKZIkgCdc+CnUZ9os+2mGjDDl7aiSA8MyLWDmIlRMPG53WWuUf0JyXNvlpnWRo+sEmaXNdJlV0zjED85JoHYqg9yNEsbnVMIwlR/FZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abad33qGN+uklk+IGGebiQpetbLRlFgeX9ut1oMLtiw=;
 b=bPhVOs5WBekagtWPuQIlr1z5tWDUBazETWR8E0hrGiMt5njBLMaMeY15f4PPUdY7TMKZxRjuPqT7lN17Ywrr/EN3X05BLopMVjT5085JVbzffAikBTCn/AaEa+jDraCN7xi9EsmBs5e+3N/CD/+sNvpIbaj+48yB7r441yKBXQgBYqBmlQgnFwWbJvTgc7MwexbuU/VcQ8GXGxvE8OdxYvdYfcSwFFp6qgNbaaN3jKBlsM9IuXiNPaCCJLRTHIlJ7oNa6IYM6Wjd4STod9MfyNWipB2e6m6dz2S6vqVJzQAxuF057qiO574hL5TTW2lgTT62W1XrKy/brC0cI0mt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abad33qGN+uklk+IGGebiQpetbLRlFgeX9ut1oMLtiw=;
 b=e95fSTruHtL/5uZixN8p9k/IpUJBkzD19fWgkJj9sqKIda+kdBgwo9QwqOwsCe1tQWo5I4RUvm9BGn7CF6nPiO2Y910exBfe6nHAQ9gpAE+tZQdulx+5A827IUQk8P0n7k+Ku6EcuCsuC4TAApA4ZbbxvJ6Md3psfVzyYqHtEn4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:09 +0000
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
Subject: [RFC PATCH 29/86] Revert "preempt/dynamic: Provide cond_resched() and might_resched() static calls"
Date:   Tue,  7 Nov 2023 13:57:15 -0800
Message-Id: <20231107215742.363031-30-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 70876bdf-73a5-4e0a-0425-08dbdfdcc536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ran8/8mUBUuRMHICaN/U1DqYdb0ruGUg+LJ2l1tGRD6KnYkAYjz2IMZGv/tFwBJ8q2xFwoUJCkjG9aOSRypzjUiFAFxvyNq62mQY9wD7XploGPsMntw1Ghn4ASQYWRqxts3WMS82NBNhZIgKfITT9YXc5nfTObEkey1fGN9fUvbqifYhnFkFYrmwEMncPbMDGc030/1pMGxZSLCljxqkm/kOsK9TZM0aPGClgB+ptJpYNotWN1Erta76TwCMrldbKTBEEUrO6MaKjZmRGBYQAX6Yh4r/vfuyl8HPuEmIOsc99nBg/sqVSEa0P4opw9IALFVOcLzkGoX5slyUABWcGwOmlHJj06Ueym6b+1Skmi6NTCNFVAU3yyezllGcsjCfJBZyvZ7krnB+uHgiGkc0Xil0heHv7r2s/YavrssZvmhElxkDfNB+KEHNLplAemIwjjH3P+K1RbexVS1DsPnzxymI8+PSCA6eL2BjQCHsWHR3l6SGKSzqte7VEnEtMKfQ5RQTGUMRK8fbqvxHtWhdVwMdiunkZi0AFxrqEdTzklviTBZQjWdPryQmXVX1O3V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/myVqYh3rUrZ5mQLkTCHc8jsfhE5kHzrEMpmT5cjM45msEk/fE0PPl5+br7?=
 =?us-ascii?Q?+Qxt3XEzWEQspCMfO9sVwKVpTyMJqLRz7llugIbQzCYa2P5wR6ZzulCss/xq?=
 =?us-ascii?Q?EPRjVsuod7kgGCxvf4HXtJikRMh8zG3ARAp+N9Of5/2z0YDDIS8vXk6OLYhr?=
 =?us-ascii?Q?Uku/Z0T6RPYmU9PNv4j5JCkXKjWsteOz5XSESR2TefSh/BMY1qy9kV8T3UNb?=
 =?us-ascii?Q?0H03lxxROPvsTBlmYzPGiktYzWztkX5SPm7RO9nDgkgABwpHnoHzGN3Vc9em?=
 =?us-ascii?Q?jiOdj8cWy72nkUk2B864S7k4kjoSIISWrYHSdTBO0JkP07Y7MGyboZbUtUXh?=
 =?us-ascii?Q?+Nv8TLrQzkgewLkKqDV6OOM3tlfqbFA/AO2pYUeD8+EczvAhi0O2wTNV23JH?=
 =?us-ascii?Q?2k6VNqiyz5yVlE+XuabaYrgYPslxx3Ta/9DpjE9v5uadLRgO8yJwh607ILNO?=
 =?us-ascii?Q?K3qb8XFzcUm8mecljjUN9aapzTvhf0mn9RELybDIkwXh0ySHBtqCnLvYDx5s?=
 =?us-ascii?Q?tMi5KZvW/Vj98gsHUCtJc3gyWrJxo3tFP5arMgjgwW5o3LuZei8fKRDKx/RU?=
 =?us-ascii?Q?nPq7kx0cFQHGHhqXVsu5e1SBssg9eia0s4kr1ru9hrooWTZvmHbxW+O2muB2?=
 =?us-ascii?Q?Z0PLxYUSEFPfXOEq2+2BugqtpLIGeJ9VpwSncQnNdwhdFV+KaDYrpsI1tlHV?=
 =?us-ascii?Q?QHEy2QD3Nl9ITN6PoufZqdgIVS9z7+6SHdxa5nUo0Y3mGikX/2EnENFLFgA4?=
 =?us-ascii?Q?MiOkyHnBLPRRcEwMghivKyGU0LUXUppKmYDGQXKPGtADqyi01YaOdSJLXh7L?=
 =?us-ascii?Q?UIGqK0JE5K/7RKZ4D6hLr5SYfsJXHVuVxiwTBBWzGr5jKfUj1UbTJ/gy4Ap6?=
 =?us-ascii?Q?/7zBmhl90jDUOTpEk1zsdmxtZbd8aqZZQFasiakREpcTSEqcVB0pu/czE8/j?=
 =?us-ascii?Q?fbVgU8Lv8O3WtjrUzEFaPe6Pva8u5kIVWIW81eXwvRi7y1kkA2XbOmURU7b0?=
 =?us-ascii?Q?Krtosx5reP9sPqm5/ng/eAyOM+lnP/G4ZcOMUTj3gfYKgJw2bRP3myc8d5BB?=
 =?us-ascii?Q?/k9oYEbOCPqZm98PKXqZb570nj/4D4TmzXhgaObbCOdmF/TkmkZNK6nRR9yv?=
 =?us-ascii?Q?E/kCgByApolRe9oQ8wHIAnM3i8WFASmnl630yw6LwHumJ1u3Ah3VLBE6BDeG?=
 =?us-ascii?Q?/jzN7I/JmVc5eX5wVWU/wsa0fpoMBfnrZtPBKDvdw8Mm35Hb2q+O34KcFAvF?=
 =?us-ascii?Q?m7zVjpGeu+U0jtSe/TkBXStV5KM5rmV9G4x06XasjP7WkXFu1ryPPC7Vggvh?=
 =?us-ascii?Q?nwZU7ya0HgXWSRk6mb4jKqbJwwb0GLHIjDwz5oQoBRbHIK3HapTOl0zLKhdf?=
 =?us-ascii?Q?CICFNx7kaZlQFOX+8Qp3UyZOX3BPy4fdUojoKL8yErMp/ajxAkrDuyAWw+jr?=
 =?us-ascii?Q?c4fyzpYkIdsfpW/NgmeM0JsFlVgbB57H9PBRAKOmSTVa0dVVomMeZDajDUyh?=
 =?us-ascii?Q?TDhnPMaMs0Wr/vr/MWhfUIOycT5lxo0hYt4Xz5LzGjeAI+l2Jwi8T4oUQbgu?=
 =?us-ascii?Q?HcO/Bik5JAOavXuRz/U1G9cP44yPRPNJvGxaugOYvu0gaHm+Y4YcBY/S7ESV?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GWVIUSDuDtgXFQTmq+OsJSw49e77m8Jj2Ran6eYjn/8VlR6fhW8zrQ70ix/z?=
 =?us-ascii?Q?0xU8PYCBukBU7nQjOTrES+T8SABSP0gkbsT7xSmhdgJAe9YoafM4KXWLfNKj?=
 =?us-ascii?Q?56YMqopIq1l5Q/v6A2vSr+/aeNTQwXIjF+Mux0Xys5VfRSccvpWu9cMf2DWz?=
 =?us-ascii?Q?NYQWsIz4gBLf0rjWha9E5N3jjwTc+lXiquWlCm/sIhvhnM1+M68mXHuihJAZ?=
 =?us-ascii?Q?P9rwLidX28fIxQGCZxaDsUzXywrKtvXPDLl9KTSLqBlMc4t/ojlzaNY7uL6/?=
 =?us-ascii?Q?2Yv1ayz6UYktZpjAbdlpTV56lz6bVIP8GQTDiv38T0MDjPUiCZxrx0twSo52?=
 =?us-ascii?Q?R87bwErbuqrOasH80W2XCnuH/dq9KSqfcUBGkgbsRbRFY/+ayHQbhvwCVN3m?=
 =?us-ascii?Q?7QDJL9fFMZAafSwIaNlJw1mv5DGotGE8WP4D3vRWibdGboaN4MjS9CvDygD/?=
 =?us-ascii?Q?l4MP1O109oi97CaF5uQbYoRPcmkcjHzSHp9J6ho275ZgPDsc/GYtr7pweIJR?=
 =?us-ascii?Q?mT2tfIXgmtrhjcCQhz9S2e4t7WzuBzW0ITpiSDVzdi8ZfNsAwOpruGnCQY+0?=
 =?us-ascii?Q?+pf0UHl+hiOx0szxWNxkE6XhpEJjJV5/HthnO+09hYzN3di/q9yUMhSSUsj3?=
 =?us-ascii?Q?oVbQWkd79f/1iAecBiaNDDH4I/KeyaHuFqkcV0vKpkMaSPY6ucrgywRHV05x?=
 =?us-ascii?Q?P72z1K2AQA/N+eoRV+hn5LY3e1rz8nVPcs5UZ8YtwsqR7U4LGw4HAXOaItv1?=
 =?us-ascii?Q?17Fj2BUj6SF/CJGawPGyz/GbFxXTB8QXv3VRXvoE91vOdJH/9L1R4sontH1C?=
 =?us-ascii?Q?CX/gShXfKZXSMtSI+m5utn1iL4d5ExRjyytJKmBhbS4KC6lz4jqFdKU05LBW?=
 =?us-ascii?Q?Iz8wykg9xePN7qEWbdK7oQHOEQ692d2XB3kw99T0La06wTMDtrpN4kkUhpEE?=
 =?us-ascii?Q?UYj/kI+8r1NApDUaUoqwSg5Zlm530YmU73pwBSctWZhnDeMvJ93fASfzfuSd?=
 =?us-ascii?Q?QL2Qjqs5hDwYN4rar4wERYZaSeSfAGwSv5y0uEGtpRuapTq6LrDxk0c6dEar?=
 =?us-ascii?Q?9Z2PfajPacL/s/pmsFdrA7n01RWMb6hu0IDJ1oCJPw/9lLJfBYRn2Nphkroz?=
 =?us-ascii?Q?G78r6Jo+ASJAeBjPHSTWUbS71O9skeDDCSBgde6OyWdHTr30Wuv7jJTONpgP?=
 =?us-ascii?Q?s7I0VZBpjgStEStnSHITEsa1LlyKg4luxOy982ldoTXMZmCWwrLGQjyKeWIa?=
 =?us-ascii?Q?RlAU2t3Qu3SwFpbzIA2auqn8SPiDy0I0Anj1xkw3z10ilnIEGO40KmWKfDXA?=
 =?us-ascii?Q?RsJfAk54iD97yvAN/c9L3AC41O6Ei2ksDqmu4fzlcm/H6pk+9ar+2hd5/pIq?=
 =?us-ascii?Q?GdxidejGmk21F4m0XmuR3lHj+anxvyXEuCGuOiPXFXhT+wbZCEze8FcSol2a?=
 =?us-ascii?Q?cEDyqan2GcYXAlyoSgUFAjgDA77y0OpGNSpNPHKWjmYPYU9eSI4gqSNkV8Ow?=
 =?us-ascii?Q?SHH2MQvRAAdlK2ofWt+zuCMOck2HmdP3FRAgZd2Ye3gsE+5iYd2DX1GEag?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70876bdf-73a5-4e0a-0425-08dbdfdcc536
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:09.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ja57lp4PQXBN/w8yidKjvavsD2HDtXBLZszDkgjMSNytBIHbi6MMZd/MNT0qgcTo6UJ8JwavQk1PLH9olLqkL5OY33oC7ByTuRMkYSj/hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: IJXO7Fd25FaxiNLHM3P5iaGMtBRPlFCT
X-Proofpoint-ORIG-GUID: IJXO7Fd25FaxiNLHM3P5iaGMtBRPlFCT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b965f1ddb47daa5b8b2e2bc9c921431236830367.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/kernel.h | 22 +++-------------------
 include/linux/sched.h  | 27 +++------------------------
 kernel/sched/core.c    | 14 +++-----------
 3 files changed, 9 insertions(+), 54 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5f99720d0cca..cf077cd69643 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -30,7 +30,6 @@
 #include <linux/printk.h>
 #include <linux/build_bug.h>
 #include <linux/sprintf.h>
-#include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
 #include <asm/byteorder.h>
 
@@ -97,26 +96,11 @@ struct completion;
 struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
-
-extern int __cond_resched(void);
-# define might_resched() __cond_resched()
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC)
-
-extern int __cond_resched(void);
-
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
-
-static __always_inline void might_resched(void)
-{
-	static_call(might_resched)();
-}
-
+extern int _cond_resched(void);
+# define might_resched() _cond_resched()
 #else
-
 # define might_resched() do { } while (0)
-
-#endif /* CONFIG_PREEMPT_* */
+#endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b1f3008c90e..95d47783ff6e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2081,32 +2081,11 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-extern int __cond_resched(void);
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-DECLARE_STATIC_CALL(cond_resched, __cond_resched);
-
-static __always_inline int _cond_resched(void)
-{
-	return static_call(cond_resched)();
-}
-
+#ifndef CONFIG_PREEMPTION
+extern int _cond_resched(void);
 #else
-
-static inline int _cond_resched(void)
-{
-	return __cond_resched();
-}
-
-#endif /* CONFIG_PREEMPT_DYNAMIC */
-
-#else
-
 static inline int _cond_resched(void) { return 0; }
-
-#endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
+#endif
 
 #define cond_resched() ({			\
 	__might_resched(__FILE__, __LINE__, 0);	\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e191992109b..5a0bf43975d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8515,8 +8515,8 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-int __sched __cond_resched(void)
+#ifndef CONFIG_PREEMPTION
+int __sched _cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
@@ -8538,15 +8538,7 @@ int __sched __cond_resched(void)
 #endif
 	return 0;
 }
-EXPORT_SYMBOL(__cond_resched);
-#endif
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
-
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_SYMBOL(_cond_resched);
 #endif
 
 /*
-- 
2.31.1

