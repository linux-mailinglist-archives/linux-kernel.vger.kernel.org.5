Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E087E4B42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKGV7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjKGV7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59710DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPwM028640;
        Tue, 7 Nov 2023 21:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=A5FpMHsAQP8YoR48V58OEHzKSjNZ0+wz+DG4FqeREDI=;
 b=qMT1v/hnr4rYALACbPMidvOZDUF0CzfEDv0WukZ2ZkYCIaAAP6m0V7Dbjwt8IDGbsgEy
 Gmlxn7ccnKTHNns+6XNRzAZE9oFZYv+TWttRncLIvgggB1T8E2tDh6zcohSluY6UJ943
 C8DlEwOPFy4vBsxkQNUKM5iEG0o3aMD65Ru3xeeYW6wjer5Kf2x0VtFMzzeYJo728Isn
 UICldqaqmpQPGOA3PBLlUmq5ylR6+uf0dg0K6WJOSkM0Q6Cd6sqhuKtszKxaDAOuHRJX
 Aup9jUmhC69+DJCaOGq3w+6iO9h7m/pQqY3/UDodDpfMhfAH6NUM1dniovnQNSJ/kCcS kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2302ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIx3v000599;
        Tue, 7 Nov 2023 21:58:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsk7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvkd06S3nzc4qGk4t5EIwQnUgLk4fmK4X/oLO6bYmdM0uwMxSAdHqjf0AnjvD3BdObrJV6zuVsPFuExJfHeoO4Jo+s6scdNvAVEsEXnG5Tn7GO2HUR7W+dTTRkC64kqCevYaWXAzsfHt2OYtR3qBTbkakJVwN7GHamzGQ3JbZRXvCRgxo863W7R/f5kQQHHRDCXrGFDsdRIyNlk2s/iEyXPQ8bk+VXDSwTGe76NxahECz7MQ7flU4PWnWNIr7jd60fbQKgNfyGoW75HuVY9D7PdDOUxeQddlpAUezNkSvz0SCiZqGB0og/EAN2lfcNExo4tY/vrA6/chvQt52GB4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5FpMHsAQP8YoR48V58OEHzKSjNZ0+wz+DG4FqeREDI=;
 b=gHAl6tHgD4WVweB8Nc+FopNzpIRx2odwg3FO1o5gwsja6yeRjGCS/fqICm3jLd0Vq8whfOTS52ztbrbHuTkRS9ObH4z5mJalh1ln4QrRExkqEJuRE0+2E+YOT9C5rsLzb8gVVs45ddh0Q00VRxp7WTfOh/RDyMmgydUfxgfIzK0QWJhgz9Vp7LRnjYw1ZMfV94WB28Tfa6QD6u85by3V0YiOFlAGlT68wOEe2vCG6BgDzlCscyBrGvI3Ske6OLjKpbdsM4XAH43JJJ4c9qS1eL43sAuE5hEXDthkAjH6MfPQJD07cVJnYRRSI5h1g8ZBKcuLcSgKgOHOYNaffO3YmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5FpMHsAQP8YoR48V58OEHzKSjNZ0+wz+DG4FqeREDI=;
 b=JQN4d8PPOgJdKJOcIg0FGcqDwRgR+5yhBZSY9wJ71jz7cvVOsXtQt41NmveUZUeVA/OzdihIjhum2dGPcIHreik5205SZmJ2qD6dG0ms1ZOLI0VlOcn9DmcnJ+1N+EThXeY66r0iRuy4mXT0OK1G21lcPP5yZPYn6I4c7h3DBEA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:40 +0000
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
Subject: [RFC PATCH 19/86] Revert "sched,preempt: Move preempt_dynamic to debug.c"
Date:   Tue,  7 Nov 2023 13:57:05 -0800
Message-Id: <20231107215742.363031-20-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: e06f2d25-b826-45bf-597b-08dbdfdcb3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6EjMv+lkegtoDUtL98K9cHt9QVt+z2y8x0F+jfrfeqidwQ+gdYeyFxv01980SKmM3VYnczuMLLZ5DYfdBr3RCjtnJl9GIsROdBm2e2Vo4YZi+/DB6mmMJ50EpLZWXv4iLyraxEnrz7B5zfqgehjUAYhuOhsrnCnu2oI83mMAQDcg2pBjFcVlSy3oImzCejjZ3JmaNp7N6X6OcawRta9zenExKgfn7F7zPgb8lgXW8LqmRj7nB06N9+hxVlQuXZM533BENezDJnNkpYt13L1ow32VyqFOsf5VLO3vgqkL56XZoeV562Z/LxbKtukhaecrhc0ltpqliOYvKquE8TeTGCeTfU/gEJxnbwsbpXjeUUqkGvCD/bdUTdESEYcxTBl1gVfX9kPqTn3ANOHUERrtuXXATGWhiIYAHu20cB6b2ZZDkJ+iIk80RQbgaxDUjZERfSxVT72YpaJMl7LSSJScRTFNw0EhG7EvxcMX2QSItP5LMwrb836aF2CQ0RXVxX0ePszme/VN1R7gznMYyWwcbLoQ/gWrO1mtVz2fOBuK9PEOLNXtk6iMwc1z/Djriut
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?REtLxb/Pc5vgwUccI5+XAP9DLxQRx98qPQa8pH1OZQtDeYGbasT9RZcqRv0P?=
 =?us-ascii?Q?d1pSzzv3R0RGsKP3il3eeMwvI1iltaCUkad804+yUFV8h5KqA2UQ9F6QLhCY?=
 =?us-ascii?Q?k6kWw2szPS9s79cVZ8zGJqAd+2jKVxCaF6fKXpbmHfE75OYbfdMW1TWYh4l4?=
 =?us-ascii?Q?jqHKmX+VqDNc0VE3Apob7o8gWj9bmzmridDKMQNsyqphSHR+IFwGK06BgWbu?=
 =?us-ascii?Q?MfOnuZgBYCqaVs/OUmPchpinNHW3g1yYXqp7IWPflUnIdmxsYV2BjhZrIzuC?=
 =?us-ascii?Q?JRr+NPp2IMMZJQwMxhXYSuHh2PRq09OHDe7TuV95JlnprLwWlaDG2abzvUFs?=
 =?us-ascii?Q?LpIQdXpzU2ZSpW8OuU6PzHNDX9nbnz3wkXLO5VtXh4eWcYRcjn2QeXqcZ1x7?=
 =?us-ascii?Q?i9avVFT2dOmT+R5G5dGhWTYuzd2kgKxTcsbquLL/KkzoMeVRbnRMZ8kWjXK8?=
 =?us-ascii?Q?etyMm7UyDqhWpc4p9fEbYMho8ECzpJmyd7YoNx3U2qFlwIH+A6wU9McX3mnX?=
 =?us-ascii?Q?Bxwm7es771nTKmN6cJnPDhrWbb7wI1kWKKNvTaOQBxE4lyjGScHkvMYu2AqF?=
 =?us-ascii?Q?V9vYPub8mHcNacA4Z/qOEFGkCruY75IDAiu2zPF1aWkOurR+vEkssqovDGLr?=
 =?us-ascii?Q?VzAPFqeBr5yHZ+emg8f50gQfsaQw9KpXULaZsZj5EjAWhKct1lPrFV8JnqSm?=
 =?us-ascii?Q?IIOQYFW5aXhPBsVJjluPEdQuLKpaEJhAgKgtiqo3NwdaIou6lncbJMve4Lnk?=
 =?us-ascii?Q?8ADX5HfOwViJCt2tINrKlURT7WsbGTWlBzXtq7BpaoUa+h6JIfNG3XtpaKTb?=
 =?us-ascii?Q?UtTRfFkGhjb2QMDQM2MV9QSKZ0IrRBxZ85pSiLiH8b+rHMOEAeUgAnf1EGME?=
 =?us-ascii?Q?QKHzkUYJluUAR+4zydCb8eYPsJCoS/RKMxXKWv2NsgL8U7B8vrrCP1TdxO/Z?=
 =?us-ascii?Q?cBhbTsVz9b7JeoXYZC2owCKtbkIf0+gSYNo7umRyhwZ3EzlxudSorhMRux4Q?=
 =?us-ascii?Q?4bFNLc7R4dkxmvvHcm1OLuK/1Z08+w5QGIRKiNwU9g+u/Ty/XvXyrbFDwTdP?=
 =?us-ascii?Q?Yn2XXyw9HkJ5fUpIxWUR91aEljEv9VJ9N7yluuhUtYAJ7EW7GszMIPyXhDUD?=
 =?us-ascii?Q?EgndULoytuF6SZD8hVKwpA2Ar2pTboInly3/t9cBKkLbvG2WyrJC8WUX990a?=
 =?us-ascii?Q?3eym6Brs7/2PYOOebdhztFGnhu2V4kVeZqFgOhj1mLLrTiW72Sr13TyF3ic0?=
 =?us-ascii?Q?TWpw/P3uINU8I7K+VqjEf+0/z7hz1AF+TNVto6qTb4ucEsho3/NaXgzmWAAv?=
 =?us-ascii?Q?fDNDIo8z0H1thAKPCFcAhe68gMQF6N5RdezQBxSZCZCXDYur6raK2S3NVIQu?=
 =?us-ascii?Q?SSwj19PQH+x9LvVSY6Pp25PxJiS+01iqZ1gRIXyRcc/NSwkJXIWNw94790CI?=
 =?us-ascii?Q?PNs+jn1X8H9yXrFQGcQlBfE3yFM8TpJiiKhkGye11l94d1iCQ7Pxv+jUWOeo?=
 =?us-ascii?Q?N2DSpyZK/cS/1au2yE8E0i7NdILJ5SavZaC6/9Ck8gzULaHS6oCPU17wC9Ji?=
 =?us-ascii?Q?gRWWJcpxT7jeoYEx8tei9wp/dAHg7+v3uNPS5hbiPXbE2qobFQFYXP9I0An4?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DvsHpuYb/eJuUrQIEQ1VO4cOJKNpkX33mbhcyWr8bnR9fREYA65VOb6hJgbH?=
 =?us-ascii?Q?1TrOpNOSfC5PTUjdepauI2pjSJkY/5gWpxYgfJxBlMC45n3Jru3PdLWc8a5O?=
 =?us-ascii?Q?UW9O0K7ITG47V+LN3gHdVWen25RA1DQ/8YSWJe1Glu0kmF+547qgvLO9VETU?=
 =?us-ascii?Q?oEZlyJcEyejYKnbwnD5CdNNMwV+5QxDozyDq9LdFhMQQKBkz19Xo75xlBXRp?=
 =?us-ascii?Q?i4dYi8bDSW8mk/jfL/MttEaKFvzY2AH9w1SyyGGWDOPuDTEcbXuOd5iceXPO?=
 =?us-ascii?Q?EMp49uJ3y4HprhyrCY8Uy8rEunMhKx7zfoE8YjGhj88PFml3h+EGk7Kun8DJ?=
 =?us-ascii?Q?xypC8tPfVd2Lxv+O9aLcXzefMJSxmtS1PQvyKLp7gjqZOiVxqaaZsMnkv8iu?=
 =?us-ascii?Q?MQvjZoBHvakDFZSYI6iD0O1W5NiUdHxLnDb7zMp3bcEBNOmnuiWpk6Tl9id8?=
 =?us-ascii?Q?gSto7o4CO5kooBF9Wp0ZzC5V+nyLtPF+NxtrXLU9E8iANrfYXMEJUftAX6K8?=
 =?us-ascii?Q?MkdeQyJYg5xfjXBlVluFvHWXgrxLU4B9Gk5UIgelRBsrBcWOFfw5EQCoNATo?=
 =?us-ascii?Q?qJKqVZnIQDnIPG25p3m+PEsue4XWImwMi3yZwgh2EnxhOJQfK08vPd7UNDGF?=
 =?us-ascii?Q?4hgluZkfAZ4SLEkmJWmEHjgk4/TpU8KwqULNo4s4wJL1bUVyaY2aPhun+2D1?=
 =?us-ascii?Q?HWHLHskyWWmvuYvVwZiH32rO7w/QjfrsPsNMtObblhuNeHYsrmVcoCCzhWqk?=
 =?us-ascii?Q?aaxFJkopBnbtAb8+Dg8PMkbncCSfSvXLlOVxEMC/wrR3OCmZFMGHyzp36/AO?=
 =?us-ascii?Q?LH7TPt9Whty2Lv0pKl8T1LxNpWp5owJaV4exEqRWJzrta3nl4SH4UZI3vHtQ?=
 =?us-ascii?Q?oE09vg5z8aem0jAAzIwX3Jjd3rg7qpS5El1r7jmKdy3d3jyAwMq2jNsk+opd?=
 =?us-ascii?Q?TvzuF0HJfOUTptZOlYsWuwL5UvCo8tQq2uLBxPeaaMdgWA0RlVd7ZIZ1j3kn?=
 =?us-ascii?Q?fCte9D7V35hIUSQdcjokiI2G8x15WrNveBO4v0PsCSy7gCp+boDl1PSalu06?=
 =?us-ascii?Q?FfeSuTwuYdXcw1zJlkPgSRrnzGd+FbWS2vA/Zw9X0ez1YRQq6VrZBMl3bMJN?=
 =?us-ascii?Q?kFVx4HqR8NS6/UhekZwoRhY1lYNpzLbR8NKjBB08H9WlmtYDAivjYhlmglo7?=
 =?us-ascii?Q?USi6BiM7ILRwd+fRBr187c4tPQ6HEZDML7Zfft91wz+Uz50SM/DwJWZrhdMs?=
 =?us-ascii?Q?yEWZ4VOg7e1DO5Ju2wTDYytyMyWCFmdKM1+QHQ/osvK4s1O0EjL/w8ubFIuP?=
 =?us-ascii?Q?HlGF0qQE1iC5hO1rYtQN76QjVMqvrIjeBo1pwYF8RJj22wNFuIefgIYL4RcF?=
 =?us-ascii?Q?YioUxzSdptHyPq6qak00vjn5mptaUAIL/eXM2/nOCZ0Qmppo5qgFqMjqLxxV?=
 =?us-ascii?Q?+OAy3k+Xvqzw3/2p6IwqLvCbF6QruxGvF7a/GCmKadTryRSjn8ZSBEwGBKOf?=
 =?us-ascii?Q?VFd7nZ79U1fqZo6C4sdripOhA5WchnAI8KnZA8drBE2hcAo5fHhI/IvhBg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06f2d25-b826-45bf-597b-08dbdfdcb3a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:40.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA8w1RJUaUqFpl3aym0TlVzhT40ytjQk0ezcl2rx+ouj+/LnOysxFe7KvfEpavqDQTitQvC+Rs3ERrsYchFDjaZyjp9P+jHIALn54jJpb70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: C3nnT7L_-Q7eN--ZZLrsCERwiQP8VqST
X-Proofpoint-ORIG-GUID: C3nnT7L_-Q7eN--ZZLrsCERwiQP8VqST
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1011dcce99f8026d48fdd7b9cc259e32a8b472be.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 77 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/debug.c | 67 +-------------------------------------
 kernel/sched/sched.h |  6 ----
 3 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12f255e038ed..abc95dfe0ab4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6996,9 +6996,9 @@ enum {
 	preempt_dynamic_full,
 };
 
-int preempt_dynamic_mode = preempt_dynamic_full;
+static int preempt_dynamic_mode = preempt_dynamic_full;
 
-int sched_dynamic_mode(const char *str)
+static int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
@@ -7012,7 +7012,7 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
-void sched_dynamic_update(int mode)
+static void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
@@ -7069,8 +7069,79 @@ static int __init setup_preempt_mode(char *str)
 }
 __setup("preempt=", setup_preempt_mode);
 
+#ifdef CONFIG_SCHED_DEBUG
+
+static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	int mode;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_dynamic_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	sched_dynamic_update(mode);
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+static int sched_dynamic_show(struct seq_file *m, void *v)
+{
+	static const char * preempt_modes[] = {
+		"none", "voluntary", "full"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, preempt_modes[i]);
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, ")");
+
+		seq_puts(m, " ");
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int sched_dynamic_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_dynamic_show, NULL);
+}
+
+static const struct file_operations sched_dynamic_fops = {
+	.open		= sched_dynamic_open,
+	.write		= sched_dynamic_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+extern struct dentry *debugfs_sched;
+
+static __init int sched_init_debug_dynamic(void)
+{
+	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
+	return 0;
+}
+late_initcall(sched_init_debug_dynamic);
+
+#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db6..67d6c35fc5a4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -216,68 +216,6 @@ static const struct file_operations sched_scaling_fops = {
 
 #endif /* SMP */
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
-{
-	char buf[16];
-	int mode;
-
-	if (cnt > 15)
-		cnt = 15;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-	mode = sched_dynamic_mode(strstrip(buf));
-	if (mode < 0)
-		return mode;
-
-	sched_dynamic_update(mode);
-
-	*ppos += cnt;
-
-	return cnt;
-}
-
-static int sched_dynamic_show(struct seq_file *m, void *v)
-{
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
-		seq_puts(m, preempt_modes[i]);
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
-
-		seq_puts(m, " ");
-	}
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int sched_dynamic_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, sched_dynamic_show, NULL);
-}
-
-static const struct file_operations sched_dynamic_fops = {
-	.open		= sched_dynamic_open,
-	.write		= sched_dynamic_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-#endif /* CONFIG_PREEMPT_DYNAMIC */
-
 __read_mostly bool sched_debug_verbose;
 
 #ifdef CONFIG_SMP
@@ -333,7 +271,7 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
-static struct dentry *debugfs_sched;
+struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
 {
@@ -343,9 +281,6 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
 	debugfs_create_file_unsafe("verbose", 0644, debugfs_sched, &sched_debug_verbose, &sched_verbose_fops);
-#ifdef CONFIG_PREEMPT_DYNAMIC
-	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
-#endif
 
 	debugfs_create_u32("base_slice_ns", 0644, debugfs_sched, &sysctl_sched_base_slice);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..9e1329a4e890 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3274,12 +3274,6 @@ extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *w
 
 extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-extern int preempt_dynamic_mode;
-extern int sched_dynamic_mode(const char *str);
-extern void sched_dynamic_update(int mode);
-#endif
-
 static inline void update_current_exec_runtime(struct task_struct *curr,
 						u64 now, u64 delta_exec)
 {
-- 
2.31.1

