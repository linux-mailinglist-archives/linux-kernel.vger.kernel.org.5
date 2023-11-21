Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4246C7F2596
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjKUGBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:01:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83FA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:01:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43gl8015009;
        Tue, 21 Nov 2023 06:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=R2/x54eO39WCfYffYdQzW1rAAsATSayjhjm02VVZaJA=;
 b=OneQv1m+l25Nt7svPo7iobEGXYrTmes3l+hgZvkfBMvTEpmEUSc1/QNE+YQxPR8bDaiR
 zu6o1jquwO1yneo8LQsDSS321hpf3snMzj7aV54d0XgsEOgxAqyRhkUu8/8XtKBBABpI
 NHP93JLJENm550MGofJe8aDd4stfsxxSppFKFYUDSg8vYTg6nM3FlY0FD8UX5lT8tRca
 Wet3lYbDRR4buxdkVCdFJdwrQRLkBmJwhdF5wt/MkYAsFjmvKVQUPCP8xbedkQrvpiLR
 3cLj6qw6/kQXxF74ZBTSL8pj9nsyAXPP7AJ6xdsyvvI44HKGLntY3X3aFLnhcSBgXuVU yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24v995-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:00:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL5hqq0037453;
        Tue, 21 Nov 2023 06:00:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6e6ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdWh0gMGcT7LXt+sbk64pyUcJ2JkMDITJu+jD7DaWHZGWlaNaIxd+OvxRRImP5DBHhPVpgvWfFmWjPYSvqSKrVf9K43IcGjx335Ck6R2o2N1g+HMUexcPFhG02y2IwTVsPIF8ylwzDvvg+n0qGGl0ERvQkr6iZFyT7vbXpcDyCZ+sMBx9XjeTqugYowclDePEawwcmMk6Qsp1YZBOY+FHIB0DVwPAFPkv/mrDpNaLNyx8jcYYCkuIgL45xSBxkCZO6OLDrD/c+n/j2G7mI051c+xOxuKmQfFSPVSqGSCE/KE5olMPV5u8MyTOtQeR9/KkWmlwnGCAym7xfUDnFvt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2/x54eO39WCfYffYdQzW1rAAsATSayjhjm02VVZaJA=;
 b=HDQh6wVaiT0os0YuVTCYD0vDTV4v4jnz+5mhtF0Xc0RayTv8Wlxok9DCrHiM73pgCUQP3qQQc4+/dnugMFF9jG75AVQqfiF+rs1vHxINqyloSTGj7df39O5AoU4CSMoE1MlknGZZXPXeO86Ch/Lm7hde41pi41S3sLmt160Dsq3uZ7Od9fPHlMIeQdTcc/1egbuPBkfF1j+bRmYnRErC/IhR3HUclnLBwQCFB5wG6yLPziINozaVkG0Ih6IneCwsuYoXqy57NJwi+ErV8qgn4yCK4Lkew5IRh4+m/kiwxYeVnULdPUyyP1x6fuZPw0/W86SjfnfStVyj1av+T4cG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2/x54eO39WCfYffYdQzW1rAAsATSayjhjm02VVZaJA=;
 b=OCCDdq44iQRDgn0kYmAc+osNskVidMQkBOjdaqJZiDCOgwMCbiAxLgX11RBIkQ5YGLV3uciu9DU3hpIwym5AR7LxdCwPhhuWQ09qTFd9SrmPloieRAcX9KUBnDKopsU5Lm4Cgl3x/nTZYnYwW/Jf/rVzShuU/Ohymfilw86MxGs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 06:00:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:00:19 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-37-ankur.a.arora@oracle.com>
 <20231108090103.GG8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 36/86] entry: irqentry_exit only preempts
 TIF_NEED_RESCHED
In-reply-to: <20231108090103.GG8262@noisy.programming.kicks-ass.net>
Message-ID: <87h6lfzlvz.fsf@oracle.com>
Date:   Mon, 20 Nov 2023 22:00:16 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0359.namprd04.prod.outlook.com
 (2603:10b6:303:8a::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 228eaf60-e705-4429-2c28-08dbea57244f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Fa6XdwunyUGYtiTtc0fbCd3YjJ0HrPlBAvXQwqBubwkWXUFQFwnSQg8pQBBPz26MXGmKbFCzXDamtw3JuPe+smbXKKWZazG+cAeoW+LW9Q4bco3lmzlagHWc+yBNg9cDFl7OuJzdwkFDbXIM2xddzim47rjKV1dcpY9fTa1A3GcUfjBRripr57THIY+aQL+kyZ96r7uKxZiJ3S33tKLgCSd2IBaDVekKYI44TY0JcTPZMDIFq+DZmSlAA5ny5ANl8TV3vsd89OjkJ4mcKDRcbU9qDPuYusEBP+m46JP1CI4GtvmyvWIq9+oD7Xp3NRXuEoZPweY3ty9QgQRGhN8/OPk6pTDueWGJ1c1usvxakugZpLBQFAuool8CHzlXPoh7OtnG0SkMe3IJIgbYfuiZZflW+vfC1Mb8XnGNnd/vSSiWpIoVLcl44nF1UOcUGs7UtGfb6LZIAFLcMGnW3aDj4ptLENM01upbdSxB8WfBOnUbV8ngLchgeAWlIaK0K2CnGCLwxgtAMLWZtNaV8dIc1zt1TRAouKkZkeYUf8POyi+yq+5XANl0ECJEyB5yU4n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(26005)(2616005)(83380400001)(6512007)(36756003)(6506007)(6666004)(38100700002)(86362001)(2906002)(7416002)(7406005)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/g/yzkzOSHYfVBPa8Hk53BEfoddHjiWzgsy+FZc94z5TC3D/maZmeklG/icb?=
 =?us-ascii?Q?LR2vbW11vdC3oQ0tjeVVKFUk1rfvBwgFEm2HSkW1P+pYYVAfdBNrAge3bIjF?=
 =?us-ascii?Q?sO3DeA0tytAF6rRVeG/Peu3yNPA28Ouo1414r3Vwd4RDu4zCnfuJyBeMTX+t?=
 =?us-ascii?Q?bbLheBambEdC1iKey87UCO1eWpfs2r9fy30AUTZjWp8AzE8VjmKAGzaP7HQK?=
 =?us-ascii?Q?e2AQRcfG8EsAW6xpj4kaFYhPUGpiW8kK7jJISxSGk1AE04IcPiS2kXzpqvM9?=
 =?us-ascii?Q?WbwwOMa/nABIHlbCKTrifNRysRlu9b2Sq2L3flnFe8tEhvq7cAIbVn2FmpMY?=
 =?us-ascii?Q?Z+HcWpn2Q0VPCXhY7uo0RHpTIsxLLRHrHG1JY7XjR9m9LCs8W0uxkNj4SJyE?=
 =?us-ascii?Q?FaH7W5rxPctcQX35ZDtMnOzx/DzrUZLhyGYlrLOyTSE7QDTtdBitz+0zbMBe?=
 =?us-ascii?Q?N6wIWvrpdYdVjaOLBBW+GAlgN2S9DIZ0xErzM20W0hZLNE/BiP3nzErcw7sD?=
 =?us-ascii?Q?lDrpVihbAKr+dFbxgfynm0n9MSM6WW939+mDIyxCQI5KRpUuJOiucAegHWlk?=
 =?us-ascii?Q?OTmKrK9D4raUmUJkFh1h+lZwWq0Tf37C/lajzEg5MFn9dLhL6lKg/aCBoYUn?=
 =?us-ascii?Q?40eGmHhj2AEaI1Z+wPAPB/SxDKhQ8RAwQR7uKOLP6M58YBXYRWeQQGf3lMZq?=
 =?us-ascii?Q?HM8hXjl+4Ch2miDP6GrT9JVDFzxSrFHiLQFQAz3G9h57WOGVdYeG5X2PBFBD?=
 =?us-ascii?Q?1hcQdkeqrsheAAic4jTZo7m6MeG61CUwtkCaR2G0DyMZS1KfTkxK8Ze0C3Cl?=
 =?us-ascii?Q?TNK1CFKhDVu1bL2B7hvavDhLMJf8VSjcoJrvnqQAEXPOuIaX3+tNDzs1CKLr?=
 =?us-ascii?Q?EZgcb/a54RokOQzFsBXrOq2NSIXbngtBumGqVLpV0pLux5LM6/kuY3y6oCbY?=
 =?us-ascii?Q?edLrGVIcD6ewNOidFtxyBGlHkl2uRRmRiO2SlWO4kTQXqNDeM+SgAz25cVuK?=
 =?us-ascii?Q?TSXzjBIQreCpGRhfTM93kqhPkf92SKZoE5X5cqFME0bZGscWhvzBcgMnKIvF?=
 =?us-ascii?Q?wzM7/URDSiV2S8wADJYH6D7NjQgWCftTmxbFEZUzgVY1lx0oKq2cqmq9qGsu?=
 =?us-ascii?Q?QLabguDxYHks8TsqOYsxsjA7qfl/pqpPnBjiUxHUgW1cPn6LtMNacIpt7gne?=
 =?us-ascii?Q?N7wejURJL9jtXXhflN9xuzWIF+4NCaLR17uOpSxmheJMqOiZDRg2NwzkTm/6?=
 =?us-ascii?Q?rPE0lmAsUiJhnEzQVNRgkRnV03YHBe2TlJRzxdhc9weQRuUgZBm1/0XiNjKZ?=
 =?us-ascii?Q?ipJiPvyuoSNsSIfZn/rv2YKQUgT16YPVlT2+qnP13HLgp4FbpNGwzYybF4kF?=
 =?us-ascii?Q?Xftl7icAOmToACkrGaPGE9e504iYhr2MmmU2M3jcrvs3wqkUo+yAJ0MgLHvG?=
 =?us-ascii?Q?/NBnmMG1hFJgW7REqyL5ssjc0GQy11Q1niLTaQaQfycSoiWkMOUlNvv+q+eu?=
 =?us-ascii?Q?WYAUZ+jeTPD1opgY2d6GCsisYNN9YAmb4jUp4dtWSszLt3Ts5g37k+FUVLua?=
 =?us-ascii?Q?ES6iEwwT812cVGkk4J/Zm6NmSozZR09TRXC9UMxSQQK6vRGDGR2bL4G3ZqgV?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DrwtS347RTfQnDojfq8Yl0YNHUSjyA87ZgMC02d0iPU28JUG4dpe0VUqHE56?=
 =?us-ascii?Q?wteK1ND/XB70I3Oei2L1vPvZ5+5HTeXvCRAG179lAueApZBZr33qSt7udE3d?=
 =?us-ascii?Q?l+qaYZFWZySVslKHUiIXVGE10EwbPEhu6VwPkqil0Y/TEu13VW3KnGXqKIAd?=
 =?us-ascii?Q?kJaDKcE+ucWKz8/1qpVd7tvOiumXuyC4npF8v+RIkMnhesPfp/3DLPQ/xM5n?=
 =?us-ascii?Q?UYmVVjQqti3+e4PxNekYN6KnlCGghJqRJGUq1FAVjoLNG9B5oKZLyOCasXGV?=
 =?us-ascii?Q?/RWRMmeBqqcdq/5QUxCLJ6xfOQSiKsLhArFIO8eBCFQuL4GjmuIGU2rxJZBe?=
 =?us-ascii?Q?G4oPHOBDT+3EUy9OTWyCrJCyRBdY2wF58sW4dLAQqamZetf8NX2wYenkDZKD?=
 =?us-ascii?Q?z88QWqrUDk2B2SZea6Lyh2Vp4mv36LmXFfzeKtyDnr6rUegvGTTQWaZ7TYMs?=
 =?us-ascii?Q?e2PkuRUkmQOMhHF/NfbkEm2qRpn0xHdY8wFjqLO/0Ac5jixPGXS5Qef45fpv?=
 =?us-ascii?Q?m2K5trtARmpHwNTxzJlx6dx0iysS25YM/Q8qn2hOkFzPFeiq4Q23qpQmc/6U?=
 =?us-ascii?Q?c2CdQlqRxjcLlSxaVU3c8+v+XtGHQRaI6kpwdfG6Ue/4hKSz0dqFpporpK+t?=
 =?us-ascii?Q?Q5liPpFN8AESdosunbwp+/RJ7xzelpQ7KOYJYNac1t0lSRBaOdw7u2+UbBxh?=
 =?us-ascii?Q?0/Cx/PvDiq9HyG2L03/dHJnStqgc4vW8q0jaCbSaw6xNh8nEm3geJPYjWITo?=
 =?us-ascii?Q?CbGZ8RZg8vQV0m+CBvEINDMHStEjnFN0BhGBH+oOwsfysjZ7fJY31AahGhGn?=
 =?us-ascii?Q?NsyidUT/Gr9g1vhXtPQFYiVqWnOZq1arEyAzfmJBXJcovFJFvte7jE8PwnYz?=
 =?us-ascii?Q?gOAWotfH/z7csBU3tFEOUjWca9iwP7P+XLlzYG7oeGFWgRheH9tElaUtqNGO?=
 =?us-ascii?Q?QgsUQPj7JXFfe2yhMpGmBMCUxiu/frXlhIj60iEPoa2/7ZOYfR6u1LJDqo3b?=
 =?us-ascii?Q?FJ1CwHt/ieeTViRAY/SjfUmfLG1Rm09V5KCUNDnfyuGVX41T6kDI/X5Wtyrj?=
 =?us-ascii?Q?jNIv/fp0oRzjHjRxkDsZCyiOg9x9j1WfPV6mTWP26iDyA3qS11dBghzdp7pU?=
 =?us-ascii?Q?8/qp3+8UGGdpAAsmVuN3j3ftIIDGEQgV6ZKQfl5E2eOkbFo/yRObTSAcPkAJ?=
 =?us-ascii?Q?r0K/EJZgwRrzboShBRLk0djY45ryj5XyxElov09IC/PSJdMgRA+voZHO5Mdk?=
 =?us-ascii?Q?teAglBMgw3mCicevtOb5JIhjzg4MRIeDFD4t68oQLYK1Z06y7ktaQqSMfYx+?=
 =?us-ascii?Q?mgLd+ig2tkJGN6aUZaD55FWsbjn04I0bdIvKKkqDKUZezeOWS/Gp5EelVPaP?=
 =?us-ascii?Q?+E/2ESrm4EqdWZLhWW+EUzz4hMU9xI6muNFu4PCSERyOtUigi+YAM70FrHeI?=
 =?us-ascii?Q?z8q61hTRrxQ+2j0OohxE9+9K/CiGdtNDqcuGnEDnpTJTE2W0bW+u309fst1i?=
 =?us-ascii?Q?f1R9bZuoq6jqSD7YYpVMGJVFrVXfE9lgZFut0RVbKeMrxrmIgiKqX0rwzw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228eaf60-e705-4429-2c28-08dbea57244f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:00:19.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGUxuUJ8S9OnTYnBcjUlyVxR5cixLvv9cU/dhiPB0dsfmi1BGNNJ+NKcdIPd6vJ0OhU27j73E6ZZSfQPH8PQzc3JZ9MFcToBBSel9AsSgOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210045
X-Proofpoint-GUID: 5gR-GcYCIOtBY-JdsTdhoI6hVLmrNVuy
X-Proofpoint-ORIG-GUID: 5gR-GcYCIOtBY-JdsTdhoI6hVLmrNVuy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Nov 07, 2023 at 01:57:22PM -0800, Ankur Arora wrote:
>> The scheduling policy for RESCHED_lazy (TIF_NEED_RESCHED_LAZY) is
>> to let anything running in the kernel run to completion.
>> Accordingly, while deciding whether to call preempt_schedule_irq()
>> narrow the check to tif_need_resched(RESCHED_eager).
>>
>> Also add a comment about why we need to check at all, given that we
>> have aleady checked the preempt_count().
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/entry/common.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index 0d055c39690b..6433e6c77185 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -384,7 +384,15 @@ void irqentry_exit_cond_resched(void)
>>  		rcu_irq_exit_check_preempt();
>>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>>  			WARN_ON_ONCE(!on_thread_stack());
>> -		if (need_resched())
>> +
>> +		/*
>> +		 * If the scheduler really wants us to preempt while returning
>> +		 * to kernel, it would set TIF_NEED_RESCHED.
>> +		 * On some archs the flag gets folded in preempt_count, and
>> +		 * thus would be covered in the conditional above, but not all
>> +		 * archs do that, so check explicitly.
>> +		 */
>> +		if (tif_need_resched(RESCHED_eager))
>>  			preempt_schedule_irq();
>
> See, I'm reading this like if we're eager to preempt, but then it's not
> actually eager at all and only wants to preempt when forced.
>
> This naming sucks...

Yeah, it reads like it's trying to say something when it is just trying to
check a bit.

Does the new one read better?

--
ankur
