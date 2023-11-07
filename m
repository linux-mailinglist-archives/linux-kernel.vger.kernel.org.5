Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC777E4B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjKGV73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573610D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmSp000897;
        Tue, 7 Nov 2023 21:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ud7w6SeHvr0bpgjfPeosv9sSObd40JxWsANklMjVl8k=;
 b=u0vnlN3Rk1TQk92O92Xd1LCuKQsAn/DVUHfFcHQsQAEUHetnIBuTQs82RgVP9ULxgjFF
 IVXtDh/wOrxCfPDX2FPkeWART4o7RKhJQ/wp6H3Zkt5sNI/cgx5eqZWV8ecG3F5FqS4g
 Ey3xq/EECmoTJgdDhTnmeIFY/xTNyD99OxrMPW666jdDen6uDRCg7Xr0t0fDVs8uFcIN
 gR3P9GFbJZM94Uo/fTMvuVmsWQkAhxFZTMOBVlOaJORRVP2GvJOGkcNPUomWTqDgjt2u
 6Hyizlfjw6wQraRpXq9aAHn8HuBXtF52nOwspCEpt14BbgSVPneQvSTvC7IJXWlOgNkv wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g29u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrHb003903;
        Tue, 7 Nov 2023 21:58:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDYqQMQzKPnQu+sKrFI/8D+EPVqdoNCVmLEGIV2+D3S6keK+QQOtyNTUi+bbW8M0Uvx346alAPaLERmFMOgFZrrQzBMank68pBy/sJqV4RdcVxOiTECUXjrUnPnTUmhElemm4ov7bfgFWBVktNtKqpNkdLQn25vvnyE+dVtGXHOunaBTtmkWR22Lc7dZEGRl0cPI+52bVlGhcl0XyLAXzwlKrZOTAWENjxxNM1kAVphAyztkJqpfTiX4/yWHR4gIgCctMHvzCAHlgdJ52Aqcj2nAfyuzp/YNGu7ijr874U+4XUoJMC+JkGG25ADaqj/ufk/cp9dEo0P5C2a99mZfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud7w6SeHvr0bpgjfPeosv9sSObd40JxWsANklMjVl8k=;
 b=arQihQWLgu7V8nQZCGGVIzSsxx0OrdDzy8uDsCGHQZan0pB1h2SSf8P9QfG9MlI+N2C+sQmpuXVXraqvnbLdU5hYRYi+H2FMg9DtHeJC5UT+tdalXeU9jBLbTgsMa+Z019OvRJRqDvoKkg1nfT29Wb5esq7ImNwnQCBvtUeIco4VG9Gj46+sOB9KUqwwawFfl11rml36jXjsEpJtyhcEbel98G6cbXh5Ighqi2O7ETEt5RgShQeAeNVDqhVXQRfIc6f8+OcNmOy1bQVp+SyjtoASeb0XJwd+G2GVIUidtFGzeSDDbe4k2fYJ/0gX39ItkwcW5WnzzwmOoUdsE+6l+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud7w6SeHvr0bpgjfPeosv9sSObd40JxWsANklMjVl8k=;
 b=dnKi6ixrHOIQ3OU7KP4dwZSz7hzobrNPg3umkbHK4q5ZNTNONbux1CkYA1AC2Ury8qaTHhJtNqLiUUrMRTudsncwdwZLAKAV9TrgRmpm218ZcZ7payufD39B75nTrQRdvCBlYCDTSX98UCyriklx9JJsawq3hBlUTWet13kX3uc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:55 +0000
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
Subject: [RFC PATCH 04/86] Revert "preempt/dynamic: Introduce preemption model accessors"
Date:   Tue,  7 Nov 2023 13:56:50 -0800
Message-Id: <20231107215742.363031-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7160a6d8-4d16-4af4-b47e-08dbdfdc98fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTATtLLnp8mDZpD0H8Jy3jOgDiXnggOBDsuuP2Yh8PP3zTLkDkUbyXomd7/4u77EPPs+o0rCq8GNVa2HazVr1pcZlRtM3ZPunm0Bew+q/gWkPQYmGTMVNu7/X+OJxfp4BE7zATxCvbJKzRza1UnGfqANStTfvO3EVAXweCSo6NQ0rQUBSSxApkssnTaMizbZSXoYo/xe8sdq72FsmtyEHEhn663Hvk2mxnXeH0ZhC64PBlZahmzh+Jk0A8rekQ5miKxfPBAw/bxjBL9XohMRcLWlzmyy17B6fKhJIQszCykhwh6CL28rLARd09eFwNTLZmBe34QcCm4khrA7tHWdROwozzUPHxdrdaO4ik1SatE3H0Tc6TNHshM0jVmk1dwYkBb3yi+8ujZY7GhPKJKqX6NCDeqkx+kcos+gms9pZpy6LjyzbN74JAhHm7BvqdIE4DFwjFijfgdTcnEaNIrSamFU24XsO7woqqN560tt2WDsp/1s3h8Zc5afJbE+dMBafCDEsBxSRw0sdpXlTF9wh2h6MxPgDWA6lQcByXiWNPNjsDxuL4lXPfeDK13v26Oe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+8b93rE1MOmmptATOpLuCrv+nXgp5ja1k4tPjEwpPs+gswX1vPoAHjYLcdc?=
 =?us-ascii?Q?ZAAVg3XGjv4RumQ9rBOSIDE4I/oXqtE6+ny8YOwKHbyp3KDtYl0S4vycwzLm?=
 =?us-ascii?Q?K+GG43AWruulJl5MRCw7AlFbjoh8QDzny2gtPsyK5YT2y8C1O2IeozzVOZcS?=
 =?us-ascii?Q?Zds6do73LZO6imsDmqzaNlkFC6dWMaA5LD80KqIa2OwZRAQiadf/AqFqMEco?=
 =?us-ascii?Q?hBA7vXothlafETr601bsNXJeFkN89CfJHVRP5WDzrL2FUIHV2tUnY1JRKvBZ?=
 =?us-ascii?Q?QKkRr0loBWbDQY5U9kbf+XQTyG5UaIBTOAP6sixKoMmc9Qtu0jpGN1CllJeg?=
 =?us-ascii?Q?0XqPSDKY06zHvKiCazOKIYwsn3IhDAmLj/TzhFGUHQRa5CCM8ovni8D+z7Lv?=
 =?us-ascii?Q?ATeMVeKROKHsq5CI/qOMhAEgXt0zEYboKIZFf3D8okR/TKiZMm9Z6MfkuWGX?=
 =?us-ascii?Q?hMCl821m9TrR1AUAPwmM8wsk4MVyg6v6kY6bJXWrynhSVmTAzF4a93GP0V2O?=
 =?us-ascii?Q?6RyZmirj0v1qo1pzuxroWcmoUgEh/ORg+lz1K24/nN+Cfo/Hex+3Nw87p/dC?=
 =?us-ascii?Q?qKedncg259PONRUUuFmDjuwAR/wVJf+5tSTzNHFY0X2T156Nim/6JQxcjFJZ?=
 =?us-ascii?Q?/6WfGSqX3TXPRiy3CpWK4im3xazjnhEo1KAseDahsIyF2U68I1EX8LzN1O4F?=
 =?us-ascii?Q?aIe3ly9QX8h+OYIp89ytU0GIDwVZ83vADAviqAOviPbIA92LLh6VzipKlQy2?=
 =?us-ascii?Q?++25cygrBxHD5AyIb09AyGReArOxAFfHVSznH7x+LsJt16IzcNW26asdWo1I?=
 =?us-ascii?Q?GsYx7SMEbhQbdNqedMdrd4MyeKCpFY9DFoCeQqL2vqk505i9MJtmeUvx97ay?=
 =?us-ascii?Q?4ATmsYT7Mgm4pQZfbn0QERRMiRPCRGI52/0C9xNeilSRKbBXvEI8dOW4jWPM?=
 =?us-ascii?Q?T5099THXrpqID66Kk9/5JlWW/ofT921CYKWYG5uafpIFEVYqhuAbuK36iJhY?=
 =?us-ascii?Q?hTgowocEoSjWEBGtF0f18eabk0Vr/7EVgGZyDK0iagfS3CjkMcYlcSBA5Jgn?=
 =?us-ascii?Q?vR0HPnjuMMYF0rX2jR1UcnqAroiLOO387Ysp1ulkIlQpNwUXc0AzET+6mufl?=
 =?us-ascii?Q?3Vs2rqQuOHXDIX/pQtYk3jrGjImP1GFIK/r4IHkXkpDVR9Dj1nf6TWBKfeai?=
 =?us-ascii?Q?lE7uuDFyOk1g4huA4DW2YP6WqNcSG5Msmfh056qY4bzeLhFtoLrXohPDc8GG?=
 =?us-ascii?Q?iPj7NKxVwNJ3VUBOUYyA1M2SjGHK6K3IfArI4gR13LjtFCUlJX/2OLSesH2Z?=
 =?us-ascii?Q?/MuIW0/szgFMQxvSF+lMm275L9/58FwgJ4JRCqEU1DRI+9iReahGIAcccECD?=
 =?us-ascii?Q?Dvvv+wdeBQRsPxnhmE32xJ28G9pJfd1Cdjfz8ys1qdN40EdoW/w3NuGuXUaq?=
 =?us-ascii?Q?HY7fsiIsla9JnXEE9jPsSAlvD7frkT9XHAdTDzRQhQIRX2sYGp8o6Ng5a2+4?=
 =?us-ascii?Q?3sKrCrYwAurva8k7xXmfUSno0OYKcXLpsplfVisRT27HcPYjw1sn+7wtPL2/?=
 =?us-ascii?Q?zcE1Jlc1QtoyntV9gYSQJiWlcMc0MC+b01TsIvpluMTS8Or7kd0Rolor70Wj?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?x7fNS6KN560B8ftquUbVxUST9D1tqkt3+XWHm3glO4jDB1AjeRp6AwLuvD6+?=
 =?us-ascii?Q?lN/+TwveSLWk4TQ6o5nYGP2bX54rvTKNhMMsYO3+4omIZ3hGvwbLxDoU2qbR?=
 =?us-ascii?Q?CSc1YRULfb8eo3GxDwtEhSyQu7sOcGv9jcoEuFzcMHXoQZmmj5HPBcabqw60?=
 =?us-ascii?Q?oqcQoBt2p8QqNNnB4f4HKh6kqr1+RDqptuyuVRAMiEaL1f4X6h2eibOqXwaQ?=
 =?us-ascii?Q?88o5eh1FD4xCNITZ6D7NZjQEQDUljhALEVPSh1Iv9ZDA27JmVbtv7VDi1ZOm?=
 =?us-ascii?Q?tf83++kPCCTZTxkbugu4DWViD4CVhWfrwq7yrf09RAzkBcDxGcXSw7cWkN+L?=
 =?us-ascii?Q?j0w3fd1EAOGaG48Yx1q4Kad1mt+iBB8w2hv4Osf0fdxO6qCLVQTDwsJqbGgq?=
 =?us-ascii?Q?VQAKTZZyGXoCbdCTzqXzz2Zuju+Aylz82dvB5MqBq5T0PCp2CGa6vaERs5qT?=
 =?us-ascii?Q?hKYiyCGDcgcHQ7etwYhBT1KlXKJdPQyzQ6TWO31Ry1GrSDNKoY5/8X9dyXc/?=
 =?us-ascii?Q?NkqFA/J+7b062MuJLvN5yOvVALCRyY+go3DO6r2s8oZ7snX7fVL0Qal/vNEP?=
 =?us-ascii?Q?4MUyzZNDyahcK6iumTuuVRRKgS4jePCbbiTgzhnbQ5WR/2zhlZbHc6l7N2aP?=
 =?us-ascii?Q?NLaUHqWmJQ2I/H8mhzye1NGwTD51uaS7i5QFft6ElbkKEw8mde1MMLCC0fPh?=
 =?us-ascii?Q?d5tFUJ8xz9pJTpkE+PJLUsP/kJ9zwRxqTZaKLXHFgkNmzWbBnFyYxtOwu8zo?=
 =?us-ascii?Q?UKHbOV6pvt7V2DSzVNARA0eOmbxhIqkOB042QJ2PfQL+b9Y3fALn1ckx2RqG?=
 =?us-ascii?Q?E0Riu3ZFkMsySBbyBP+ePNANFmDZcTqJvR8E8D6BqZaHN3QtPmPUrUbn5xec?=
 =?us-ascii?Q?06Yvjgu4fyBAHDUT0nk/1PhOy3klEiney+p2M9iKc+wsNN4VO6ERy51j58Q5?=
 =?us-ascii?Q?TqRpLxJkYEWHnYYHmrrxjEifaXfdOo7TTjuPXxQdtY7a456iVBNUUkvuF41H?=
 =?us-ascii?Q?Ag3dR3/w/jnE3lcA18EEdRa0jJZahpSDjtcculsCU07QfuNZijUQ9NU0Lohz?=
 =?us-ascii?Q?J/KXsbNB5mGruLDTxhHcmKBuemJfp3hM+kc4GfZ5xF7TTnETWZ7/gcjrkVw7?=
 =?us-ascii?Q?dbHU0D7OBZAi6BeiMq4jlG4pzfVSZBppENuT+vNJjPaB3GG8PVsdLdbDBU5e?=
 =?us-ascii?Q?jFLyLhMduZwlpr//Zld3Jllr09waP9d0EuUUMkOYBr6PZ5tCY5N0HD5exn9N?=
 =?us-ascii?Q?nikbjTi0ofMXdGDhWiYxQPcNZidabrHNbKLPTI2fB64cO/vM+MiRsipldUAQ?=
 =?us-ascii?Q?/0FrtbJr3tzS+UzKJWQcB3tyxs3DwXv2rgzP19iN61ZLHml2QDS3CLjtuqxY?=
 =?us-ascii?Q?pxn6IcUHuYJUoaXXN551Jr8kEgTwQP5fdLttoC3H5p66woc9MZ6jn3OFDsdh?=
 =?us-ascii?Q?svJtRstPh2SMuFnlLi7xLpdharAXCAie/gaiLm4Bwrdve32ekjb72+fmUzg6?=
 =?us-ascii?Q?MnLetjJFtxX2BSq7HsksYG+GtvYi5dLcoRSJVwEZIQMeZfuieq1yck9YiQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7160a6d8-4d16-4af4-b47e-08dbdfdc98fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:55.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYpmHa4/ZHkSpOfflB01pRrl/czL0LXZWyiroHwYBDPRox94HGDmFb9QnXVtbpND86sp6RJcLSzSZ2f0EkVw3Q3oEbDuNMYIOFuRotjo98I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: BnWGopJu-uoOnz9gHo-V5J0OaZV7QutW
X-Proofpoint-GUID: BnWGopJu-uoOnz9gHo-V5J0OaZV7QutW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cfe43f478b79ba45573ca22d52d0d8823be068fa.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h | 41 -----------------------------------------
 kernel/sched/core.c   | 12 ------------
 2 files changed, 53 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..5bdf80136e42 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2178,47 +2178,6 @@ static inline void cond_resched_rcu(void)
 #endif
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
-static inline bool preempt_model_none(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_NONE);
-}
-static inline bool preempt_model_voluntary(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
-}
-static inline bool preempt_model_full(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT);
-}
-
-#endif
-
-static inline bool preempt_model_rt(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
-/*
- * Does the preemption model allow non-cooperative preemption?
- *
- * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
- * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
- * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
- * PREEMPT_NONE model.
- */
-static inline bool preempt_model_preemptible(void)
-{
-	return preempt_model_full() || preempt_model_rt();
-}
-
 /*
  * Does a critical section need to be broken due to another
  * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab773ea2cb34..0e8764d63041 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8866,18 +8866,6 @@ static void __init preempt_dynamic_init(void)
 	}
 }
 
-#define PREEMPT_MODEL_ACCESSOR(mode) \
-	bool preempt_model_##mode(void)						 \
-	{									 \
-		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
-		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
-	}									 \
-	EXPORT_SYMBOL_GPL(preempt_model_##mode)
-
-PREEMPT_MODEL_ACCESSOR(none);
-PREEMPT_MODEL_ACCESSOR(voluntary);
-PREEMPT_MODEL_ACCESSOR(full);
-
 #else /* !CONFIG_PREEMPT_DYNAMIC */
 
 static inline void preempt_dynamic_init(void) { }
-- 
2.31.1

