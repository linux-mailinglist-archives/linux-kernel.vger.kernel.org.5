Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5957E4C78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjKGXJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjKGXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910B10D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK6Lq026463;
        Tue, 7 Nov 2023 23:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zK8SFzx6JjVEKci+tBZyL2d70uL/RG8LSxDqG81d3JA=;
 b=NKEQwCiAfgp3pJb2anY0CClEi4FMqkQ1xDK2Qyp2wUqDnTXcpfmzpY07MsQvRNmcZjPB
 1biidY3UUYH5ovl4pLYuu4ajoYonZR6z93naAV4PuD2bNeT/85i7oyBlYB6cxSdHyxHb
 5rDGmVpQ1u1+4eJg0NVKwgjM5iTbIxg5Y7GkUgm4CGIsqr8V4Y4rsXCUw3KMs6NARt99
 l3tg1gzeyuu/+osKh7GNhNuSkoMn8BenBjTPue1fhcHKgFMkvZWz9YtAEcwI94kxPhWz
 zBAfPH42SYuhAxr4/o/mQQmAqIh0PtK0IzIsv7DBXVWpGmR8bCsUkF2pImcPUxAhAZlz kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3tUW010979;
        Tue, 7 Nov 2023 23:08:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tv94e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O66h11kv6FJUxDYcbB5rlGAHepZGVteYkwskpd80All0VZ4dk6q6bkSISfi7DTbKPz1XqUtWCQXAjDt669WwusTtiqJhLVue0XQArWZ7mjXaXtima2Gc5mzKrGUcdyjaTtRlwjt1DEht+4k2EX7m+PfXvF5XHlUDUsYPrs417ZLPixPBND2+b7QHwOOxF5w5RuaW934xPR675EIR//c1PeDiXmBgaYnyKd1tZAOVTFzFzor+KKr8meuMYTfQxz19txEM9jGSkKdbfJDhW2gAsFMXor8vY2htY4CuYGjW6kk+mSyIHtCtCSveT2jRBRlSiOX81kuWJVtgyX0zOqI9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK8SFzx6JjVEKci+tBZyL2d70uL/RG8LSxDqG81d3JA=;
 b=LLpn22HrZjK0iPVvhQGdWab2KpjwxMDvDh6xF70d8LnlaArN4sqvdXy7+ZObYQ0YtipHWdnTkdnlaV/lmhuzmodwAYZbMNM38z6rfuvq7QearGS17l7/za094S4I7KzUIMroH3BY2OLErxCYnfaypoY/CHQLUn4/p/fCKXd7uuJGtqEQmTAo4xKOLgB3+N/u4PgGN5oJpI8szQCu9fVRPy+ZwWI/XJzFUF8ncqRNrj4Abnyrgfn4cBu8k28lxYAmgBKGyNjFVrxoufiDv8+KKGZ36aJRhMUiwYRHqQ9edBuN5zSOsumeIK6r6805skCdR09wYX/UuBen3kOudf7ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK8SFzx6JjVEKci+tBZyL2d70uL/RG8LSxDqG81d3JA=;
 b=x4HdgYbCpPPhDE4ZRqEdm3eyzAf7E857m2UzlXYoZ/GTLJ1MhmBorSmoILpDPb/4qx4shI4KkYajRcwSjb3GIKsy9qcKq5nJnz0HahM6kCr+7Q3SS2iV62LyZTDX5eejCkQye7VIOX+DkDg4+Hn0sC6meazvYF+S2Lv8PGX3bj4=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:25 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:25 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:53 -0800
Message-Id: <20231107230822.371443-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc9d6cb-b1ab-4b0f-996f-08dbdfe671c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5XANYS1fInMB+l7L72Xsq+KLEtLLwu6NcMM1VyhblfvZjMELnaqv7VLVvMj4OaaacN5UmSIUV4ly9wzVR5lIXCqXnEvY1ZHU38TOm2ZNwYoLRGuV/dBltjIFmlH41Ql4YUtGziVBuBBV8s3FvEtEOxjIBt+saOiWEzucDN8gEvOr5TtX54oDvkL0hBQshQcyOtqWfOVAVox3e47q8wbzGWP3nQkyVxAAaYKWO9euhCk2wwaTvhXNPugWgX68C/BPySi0jKI/hBxtZ87WRazx3BptaxBPj9uubiaKN1d3aHOWQn2KRvKroH5dAEQ06Rg5F5cCLY4GSyNwFoUCb2vXjStI6BvsnV0263pRzSvAnYA0yJIrc3vDNyN/NGEnUTgVXzP2b+18/eakHNOiFPQRHSlXJNT6G+DGmv+/eUQ3v6g9lOkcBb8HC5YInYuHZirSuhJ2vcweoagTUaIa9PpLujZTdnu2LZkpCwlCEMULos5j6wre0r+lBZc20RaigUSgrwkpYz1chNs9Gx1huiXe9ba7IB8y7C+HJzXle2Uzr20dMSjPf7Cr+UmSbKLOD4i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6rJbBB/nG5+yQw8C75xwNEb0oTLrR2vHz5hM7R0lrROez2FUOnMjx7iGIGY?=
 =?us-ascii?Q?JOJi2dZph8PMoMK6zahixJdcNkS8ug7+liGDS5DAMe0sP77o1U1a23Qi56ca?=
 =?us-ascii?Q?1nqDS2u1FAZE3hKATM4vibHaemc6MjngDczXzxqmked/XC8jK3y9MCBYni0D?=
 =?us-ascii?Q?ag/na/Gui8AhnNFQ2+6RS+oej5CzFb3g4kg1sMjg8JlONpWj2J6x45cJwAJI?=
 =?us-ascii?Q?HquozJga/pENywYikP5tdaD9tWYN4/wm7cLIbyE8Ibr8fIbO7XVcKRBOCOC3?=
 =?us-ascii?Q?BfqHkqpr3Fle/MqGKVU8Xk+RlKBP45c3aOJ9Ehb32TKi1GggSeYVdI23O2kl?=
 =?us-ascii?Q?kcq8xwgbD+xruc5mboEfH7ZDZQuyQXY4IHAfWTU8qPoNLUMAePAtqmlY5fbh?=
 =?us-ascii?Q?OUqoLwRARWokuDDht/1qBISO/EKnunuK6DfOoH8IBXB+I/DgshY5G7b2pDtc?=
 =?us-ascii?Q?98fnWn1HKmlxRZOQgGcIGj517uCoK40hJlbgDWpC9zmlj1NfBhdrUYm4qc7e?=
 =?us-ascii?Q?+ed+u4ZVaMdOooZj9G8cDy46q13v442T7KL5ZbecogfZlCcv/Ti87c/tcuEc?=
 =?us-ascii?Q?l6nWy3U4Vd3Vd//vfwuUwZ6PE69iMSFBKwy0+8KoeZZlxVStTNoKR2UbnXZy?=
 =?us-ascii?Q?Hh5VZ6Jco62d+/gjX9vXwgsJrNWZ8jkiYGQCWrHL/K4Qpc2hD65KLP+kgoDJ?=
 =?us-ascii?Q?8+CljPaTh6Mmgw9VkbypwS5/DZg/0bCWQatlmDyUkgKLWMLz/HDdTSPrOclL?=
 =?us-ascii?Q?T2tKm6Jh/e8bI2UDzMV0R3EuxJNJsDVHtxvjEzwsqfqHaxhovjnlu/WaLh9b?=
 =?us-ascii?Q?ofdQS1vU6VuLURIqQQePsx1bJ4oNqKDz+ckGop+DbjD3rpQRbncWmRtarC/A?=
 =?us-ascii?Q?/baXJC/gu3GXTkReQe32imI1Bs2mTWUM7Y7o/MJfTp4tfWkkkrKKyhCs3Qkx?=
 =?us-ascii?Q?f0QeMDqVu9bXTg4zv3r9veGiRzjFJQ8CU1lU53pdR5nuRTKvUbYBMd1zHZVo?=
 =?us-ascii?Q?I+W49fPnrd6iJq24X8TMFp/o7HLeZ4PdPDkGYedtdNifbTLUNh8QZmvxxE8k?=
 =?us-ascii?Q?7NWLW5zUk+OKBevBSo04laA1SOg7/8ZaJrkomSRZf+/jPCwONEgdl3MRKZ4m?=
 =?us-ascii?Q?1OsZREo/BEVr4FhzVuoAnXgKi+Zd3/gVVBHOC0j2O9aWSHBleiDyJQd1lBRb?=
 =?us-ascii?Q?onOMfR1sRMTLQ9pdKsnlGGZej5uMp0KStb5GDN+L1A1zReSw6jUBNPLfdBXx?=
 =?us-ascii?Q?IAU8l53ghWvn/M76VQ6Xtbx0G8jjUzaiXPAG4cumg0xyO9dMcy9+wrOCnV7B?=
 =?us-ascii?Q?90dOYeS7BSEGxXK0ERSKvnGF+/hxgX2BgYxLy1CrpkFUzjfUWHs8AZqSuoPD?=
 =?us-ascii?Q?4ZeGNihfYPBst2GXepwhOEs/jji5T8uSC9LoD9BpzeaBXBdqxC6V1g6NLcHO?=
 =?us-ascii?Q?tm1zrgSuKktcbfLhgpRYjtGXByWZ96d0gEClpU11vY0Nm84cvmKFDUq4RlnJ?=
 =?us-ascii?Q?ykRGpJvSwENDz0n8+GxOSbvrZL7RzuAxVx4mJb1Q3B3XznI6HiHjND2JFX9k?=
 =?us-ascii?Q?CSf7kJLcEf01PvQWQ2h2SQVq8sNbY4UBiMFt6drAsT4Y7Mnxyy1FN9TxyVf6?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jzEQFCzWHbdwDVZ/+PnR3WRKFhY+FW0GXIbmSWDIWvpRPEqwedqcpUkQUXGl?=
 =?us-ascii?Q?6jOQnTAaHsX2AYXtwMcf5+7qvz7dToaiWLcpYP0P5Tf8+yUMg7yIgRSLEP/c?=
 =?us-ascii?Q?CTUCJKvDrqMrX4uDNn/ngE8NI6lHzdWLAn20Lw9j1cFAHCJ/UzQikZnA/Vv4?=
 =?us-ascii?Q?6VMTzrWv8nzANVcZYbg84Z3uZ44gUC5Ecti7Lp/O+HiKBzitJXTMZE338XD+?=
 =?us-ascii?Q?QBfuK9udFdW9k+mLmwJunYlvtXZUN+y6aLpfWqR0cXPEcOTvRejWWhbc/P+L?=
 =?us-ascii?Q?bPtgaknXnv33RdLNoDpxtpm6+byn0o9oBmpQ2CIgBTUbVB/FrWYOLZvnedtM?=
 =?us-ascii?Q?5KehpUQgKBW5b8byotlQ6HLW0iF4WWiSYkpxJg6levjV20P/flnFt1MdsKle?=
 =?us-ascii?Q?SlHKNUc8JTKyTYj3006hRTaVgSE6NNF5MN5yWWX6e1g7pM+4tOZc25QV8vjA?=
 =?us-ascii?Q?I186G+M5AMvIGZob1NSmEZ1IN+xIJW934jvj/AQeIK6VKSzIHhtW4j8kZcKy?=
 =?us-ascii?Q?hVRL/N2o8emkA7LDWdKugg9WGGKZK5NsXVYg3A8yMSfJJNLaqYyZTI5ddE/L?=
 =?us-ascii?Q?+My/F24SEs25sB9LvlcWgkt/I+NWysqnoajZH9wmW42t4bA8IUd+1mfdEF2z?=
 =?us-ascii?Q?Sfi8KdTsajXtSkFyTuPEr5tiGfCeuzgUS6e4136LYWUJ3eeLz5w/nRg3jR9o?=
 =?us-ascii?Q?s73LLHymqebfugm0gYG80ZrcD7Aq4Blh+bl8LNicmVqwfXz2BKr4U1D2DpCS?=
 =?us-ascii?Q?WVfmi0pesWb7i6k+GPVfxFxz8zSw9IRFBNWg/B3w+NrwbtZEafvqHLL9HFO9?=
 =?us-ascii?Q?p7tPCsOTCeSXeibGcfdTcRU5G7fm3dmDEfxjr1S6m0FrmEFgxGEVwh58XjZf?=
 =?us-ascii?Q?Q1wYGMe//K/EZQDZZeQKw71NNrhlXVQMZHefKkURl5dU9xfdwU7mwOVC8OTQ?=
 =?us-ascii?Q?tE8vPsRnOmr5wtsQtkrxJu/UHHT0rYFE8ZyjxfdcQQYusocCGmKTJRzwJrCX?=
 =?us-ascii?Q?kW92RxpriNeAHMIo8UnUDE5ZJmPlj9R3f9GidQG4ICB5CXjJLXnuq16PVKeC?=
 =?us-ascii?Q?7ui33/QCNrKOFbeV7vZOnMlmKX+cqn1XOwZecv/YzK31yr8Xa7XDRNBW280J?=
 =?us-ascii?Q?VcOWrzX73DygrmLJ4gKDftzdWILkOQjcfFniaEqtza0CPZz73GS5vCumTmQP?=
 =?us-ascii?Q?/BxukGXvQNir2+2PiC6hbDZEAMcEH9HyWUuKrurBSO/r2FjW76WghMVUuVJh?=
 =?us-ascii?Q?nQOk68rrOs3O00d/7mL6/Ym5rTQ1fL9ibdgQ7hs/hHmy71Yz1ww1scy/3HLt?=
 =?us-ascii?Q?Z+ktuFoSCNPYBEdLE87eMGd7/R28rXB/9gdSkHJx6eKKBqICqCM/OTUqSAqH?=
 =?us-ascii?Q?C5oAGXgsFZyjcq+WyZ08CUBGkGcEnTgWg4ux8Pr5yLtFF//frhxVzd+bEFV8?=
 =?us-ascii?Q?vU5hr4/9k+h9fV8vJn7fFDWaU0jOTaxtFSeLYAiDXi6aZxlXO16kNLoqFwbh?=
 =?us-ascii?Q?HRNnaDmCe4T6qBznEl57/hlBHgxHh8pVdtY9RTbHoYBFYMMRS9v2ZOwxyvWP?=
 =?us-ascii?Q?AIGtoxms0hTdHfBiIF9DmDtl29oJmk1yP8SHoQ1J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc9d6cb-b1ab-4b0f-996f-08dbdfe671c7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:24.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8dd89tuqjYCRo/zdixBlJ5x3zaCTKKY0bW59zaMq39PL84wJTjjaG+CNryW11PjCujlld9cq8myk7PU1YAIuxGq30l+WoPKpQ+VQwIylmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: xYDt_49QsbCv8Qq5k0yBXTMpnqtVplvY
X-Proofpoint-ORIG-GUID: xYDt_49QsbCv8Qq5k0yBXTMpnqtVplvY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rudimentary script to remove the straight-forward subset of
cond_resched() and allies:

1)  if (need_resched())
	  cond_resched()

2)  expression*;
    cond_resched();  /* or in the reverse order */

3)  if (expression)
	statement
    cond_resched();  /* or in the reverse order */

The last two patterns depend on the control flow level to ensure
that the complex cond_resched() patterns (ex. conditioned ones)
are left alone and we only pick up ones which are only minimally
related the neighbouring code.

Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 scripts/coccinelle/api/cond_resched.cocci | 53 +++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/api/cond_resched.cocci

diff --git a/scripts/coccinelle/api/cond_resched.cocci b/scripts/coccinelle/api/cond_resched.cocci
new file mode 100644
index 000000000000..bf43768a8f8c
--- /dev/null
+++ b/scripts/coccinelle/api/cond_resched.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Remove naked cond_resched() statements
+///
+//# Remove cond_resched() statements when:
+//#   - executing at the same control flow level as the previous or the
+//#     next statement (this lets us avoid complicated conditionals in
+//#     the neighbourhood.)
+//#   - they are of the form "if (need_resched()) cond_resched()" which
+//#     is always safe.
+//#
+//# Coccinelle generally takes care of comments in the immediate neighbourhood
+//# but might need to handle other comments alluding to rescheduling.
+//#
+virtual patch
+virtual context
+
+@ r1 @
+identifier r;
+@@
+
+(
+ r = cond_resched();
+|
+-if (need_resched())
+-	cond_resched();
+)
+
+@ r2 @
+expression E;
+statement S,T;
+@@
+(
+ E;
+|
+ if (E) S
+|
+ if (E) S else T
+|
+)
+-cond_resched();
+
+@ r3 @
+expression E;
+statement S,T;
+@@
+-cond_resched();
+(
+ E;
+|
+ if (E) S
+|
+ if (E) S else T
+)
-- 
2.31.1

