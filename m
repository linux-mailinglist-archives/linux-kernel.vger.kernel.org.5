Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203D805F56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjLEUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjLEUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:20:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0A1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:20:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5K9MhO016221;
        Tue, 5 Dec 2023 20:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=o3YjZ3sRcd2LjShLvwl44UhfEJYV49wz/mSFGoQQgvU=;
 b=VFokdfhl0fXhnlOal69aLpYGm0iGkW2gwCaFVKtbW8JJqjtiF4AcAUy1cRI2JY8FK7KB
 as0g4F+hKuzWR2j5rKnLXdwgVaoPh4Qpbkq3wU/AEo/KgiPdu+zVevhTHFIVhi5msFAP
 0t2RfulGU0wi6uSNY0lHu7xcO2DrnSPr7g0h3IppqMW0jt/bOr5FQNkca6lDQKWUnkKw
 e2YX+CLhwci+1cysXEA8+BeICJntiN4m6bRLdh2gsH5lHkPHEFspXcKtb3BFoSz6vKIM
 xiMgCN/jgXiyVdLAL+4IBhfAsAdh76YSkt0c+r1WM6OdZ6zgeDJZ8EVpGMHuVVQQRTQN PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utan9g0j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 20:18:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5K9VOA038489;
        Tue, 5 Dec 2023 20:18:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanarbax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 20:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWEVdaYIwLdET2oDHro2Obv3pSSlOiJ/RXuQQd+C6OHUzpfKKGCx5S2caXuswi6gWZ2FUyMPxZqXXnLKUWdvmooxFKEoJ8fb1bNphsLoy0f5B9AIfkg13EFBAAuyy4Gjjn5JlLF+hfyNUmUB/hMcLbd9cYo61FLeNb9+Xr5aOOAoYyCtUGyTbwS5d8Gz1lU655hWSK3WHECkzSyVGTs4XuFIIodtfA6gNcztVWOygjjc3lXxR77PqSMvwNp6jOBMBpnPA4GUS5ymYE/PsJUhBcpjkhFHizpvcIdlLyKv/B8cFQ93uhh02HJhpgs6Yf4QyofZnhAT6XGInY/hJS+KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3YjZ3sRcd2LjShLvwl44UhfEJYV49wz/mSFGoQQgvU=;
 b=i32tmK8ITNE1TGSMw/4jro1irThn5JZtYieyDujZzM34dujsjafc3B9E431k0z3cDzN+sqneevdNwrfdjzsZZUOo6tbhEDi1iXz5ki+unQk1W7dO8UQxXwAPqOwNmGr3WTpAl8RAocHa6LubdvvfKWN1pzQutMf39lpuucEjiADH75LSY0cwcWv1wdHk3795HrjW9Seu3waANm0KXhfvNOTfteklPLWw4dk/soXkrDr1bZZxQIMi13ajPvxuBw/prilIgNUD1oKLZPQ8i+7DcvLmwkmstxFYW38+JFYpIoosxG08OWWFvPTpQO0lRLlC4KUJcp11Z2xMhN3FDMaixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3YjZ3sRcd2LjShLvwl44UhfEJYV49wz/mSFGoQQgvU=;
 b=YfJCk0Jeoa2Ow0KtOwQaUBWjbT3OizswBay2VNPELws4UI/YzpP+FB7Cl+o9+ZAYsay3u+kxFbLGkfRuX7yAYxaRACK0mYRqxRFq4Pgi6c3GS0aJ+B7DA7z5VAlZatKQ740MPj6h0zrP+bMv7XMnVBT6x4095YCUWGhdAoX3H7o=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5350.namprd10.prod.outlook.com (2603:10b6:408:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:18:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 20:18:28 +0000
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
 <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
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
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-reply-to: <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
Date:   Tue, 05 Dec 2023 12:18:26 -0800
Message-ID: <87il5cpfn1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: e70e1664-058d-45fc-e3d2-08dbf5cf57e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNMX7367QyVgwvL59lUGZAYGDP308xPvTZdFRxQKfnDyCZ9IxUPCA6hhRA7KPH7Gbz8+1PpbxJGvP3VTs2ONUvYBu7i04O9wtNYnHOrtvLaPbacFI15LYdV5+cgf1v6CRYmErbdgshsR0GpfL1vufPQjyGi3WSEL1ANL/CD0KG+zTNc8pCunq2lSd2Bgm0Hzcx99GGdvJRU/XTDKrZo1//7E1Y/IIIG3MdiWIRFEqzS0gTtCu8WCw67h0JIgy6hdqxIZDnWlW5Svh92OpBwQp8dbe2w7pw5e1MlN/qm4xAGja09dGFyqM60DWVWarMpTZQ8/d7QrXM024cFksFnYQ3h1Jg0PUCH4rYN3mYrlE4UOmkRzysToEtasSEOsCaC7/0ptlk7P3Bi6917o9HRdNo8Xi6kapRw5TyB4G+LcADmsXZwxnX2TA2/amU89BzDYrBp+rfg7T34KfAZAPJOapFU3BZLCVigCNFp4sK1FL9W5xTqGh6SLExxUd4wuTCpg7kJNCzWqfT0sD1iNPg9xWw6PxN/YVa7PGI2xa0/DhjK6XnkNnm/sAOM5tVcmGglT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(54906003)(66556008)(66476007)(66946007)(8676002)(4326008)(8936002)(316002)(478600001)(6486002)(7416002)(7406005)(41300700001)(2906002)(36756003)(86362001)(5660300002)(2616005)(26005)(38100700002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1UFSjQRvc6dIAca9PiJkEyOFb+qQ1oMryNYiktuNFDqJK0qP4Y5ArZqt98xd?=
 =?us-ascii?Q?T8Q1iAKkOCwxAnp3oyTBCvRl9qY8vaBNr2Uh7YfKy6gxa9ApgBUZ6ecldM2C?=
 =?us-ascii?Q?0c753HvQvJ7WwEpa2m8yLhKfIRIj9O49m0XiFus+IlpTjwq1E36Oyza3KIXG?=
 =?us-ascii?Q?eTABf0S+IKHe8QfXeFeCJXHFQA1iBLTCc/3oYkx4/axoFJtDhyqHzDSlnWkY?=
 =?us-ascii?Q?OzoPmsVwO/YtirZJAzA1xpx+rViwW+ej2Uk2omIKvXO62PE49dnfKT0kud8M?=
 =?us-ascii?Q?HMDPmzpP0H5ViPFV2iNeNoxt6vBcV+jdRdIZZ9GCONtUbrtix29U36nfsFyl?=
 =?us-ascii?Q?gZPGc7lVkPalVzsWUzgGsL8i4XcsR+ee5wc2pz+Q0BiyF1XhHTIHYWHiBItG?=
 =?us-ascii?Q?pBb50ho10tDtZ/Ha0/Qz2JTb2LD7PqWumInG/j0s23zmaPPyidZWXoaEzthH?=
 =?us-ascii?Q?OfpMt8X0zmMcLbhobTnx0kB1VpCvzeM4KBD/Fc/PutQ1/mffdts1JWFLjGqx?=
 =?us-ascii?Q?T2GKqpwfnaSDqt0CsSzlcMHuvd4+OawRgpsQTR377HJw9/xv716ipkQmc4SC?=
 =?us-ascii?Q?om4zEPbxRZ0zhEv/MIthdbOlVOiMbdOu4SgdGfR39B7s88mY1X332H3fN2vz?=
 =?us-ascii?Q?n42xcvnW0Lo4ezt4pwzaI5rBF2n7E1xWUOfODJpx5qdqhVDhfCA587OEytol?=
 =?us-ascii?Q?kE2UZJeBBtw/iybhqMQ5JpFtxzmb7lg/70YBc/1CVJSsA6kBCfvaH/fVi1qa?=
 =?us-ascii?Q?pZtZKQlhvGaomEW8y1k4H0Reii9BrW3w6jkaTvupKXoAsLOSg1TExAf2GCTq?=
 =?us-ascii?Q?SQpH0GVpFscGbtvpg/5sAPxiXhz1sAZ1U7vrxo8le/Q4GRHlvxv7lBOR5wXZ?=
 =?us-ascii?Q?Br6gI7f8fl8SdM/SpEJHCwGh8pFIjljqlW80tSKcrQFkNpzTjKCl+1n2cLGa?=
 =?us-ascii?Q?qH3BZwCXYFS+3UwFmLTOLiB+PRZ1rk/QzsZ+/SvaOdH15YfH+pZS+srASD9R?=
 =?us-ascii?Q?tDtwvwHTX8vxuncmdKlozXrYi3NlQiKYjEO1n9T8B1UQiWXIMSnloS2P9Qhb?=
 =?us-ascii?Q?DReunWxpq64RiKFRWrzzIlEPh/ufT1Kwou/VmU0e1kjXULHSxVAQvx8Ox1gQ?=
 =?us-ascii?Q?78QU5rJHiTVKgpmrqxVqjMBy2l1B8IThni/6S1erABClkn1lSC/oVSiuiqpG?=
 =?us-ascii?Q?SbmBNZ3X69U/TsOy/Arvj49JlQgJikzT1erYN+R7YYkwxZD/uVIwyKAsoaxS?=
 =?us-ascii?Q?wwNvety7CO2PLQt0sv4BbbpaJZrL8z6JdQS6hWBOSjnHWpHBdkkNlBiF3z7d?=
 =?us-ascii?Q?xPqz6L+0K80o5Mw+741FwlS8V9sKL3tXiIKh2zY/z1zB9/iLPHrBAoW+iJnE?=
 =?us-ascii?Q?LlJp6sSk5PuzvM5GKySA/7HNYVAIU8Pnrtczt9O0IFFzTHcB/IPaHr6dXVVX?=
 =?us-ascii?Q?yHQkTSGlDvrIpc20zrPrNZjbAXPdnreh3meaeHH2SApwjGtR/+YDyErKQ31H?=
 =?us-ascii?Q?X7S4OexfP7HzYZzkkgutI2NWcwjks6FlqAnzQjFeorTf9EH9/TqoCXpss9UC?=
 =?us-ascii?Q?lrtlAk84wU8i+MM2oTnbp9zkzy6j6Z8olMDgMKuX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JgziLLqp7+rY518d25oI7L8IZGbIms9rX7CAUw4FMTMB2FwBBgtFqL1N9rRw?=
 =?us-ascii?Q?hkECMslmcyp7pCnvpBs2sxlxNI0voyg/fpAJFfZeRQIuh2ePWC3hj8nONBBk?=
 =?us-ascii?Q?l0Ej6DdGFmRaLgSJxhrhXkm5QMrPaM9BlKugNEbKslcvxYHgwPlvBSqvZqRt?=
 =?us-ascii?Q?ZiAXraJQ/DwE1jiSMnz9hNb6ZDlQiQ5yQrjg06+DVCz5J2IEwzpzRqZJ3H31?=
 =?us-ascii?Q?zZ4NYhnoWGJ6h50Q8eEGBnD9K1IW+w62oHdWUxQDxyu/bzH/jHAtq4iO4ZPX?=
 =?us-ascii?Q?OAWzG6eWzp3pKytAjnXn2i0xc0ZB1BvZumyseQqEeYgtbJ0QChbexCjHA9BZ?=
 =?us-ascii?Q?TYWn99cH2NCMo4UK6kwcS4FpyXKzn7eKJByfA96gDAmamGc0gZCque3W1/XE?=
 =?us-ascii?Q?M50Zc3aDTo2UvME/df0ZUq7Ape+SBOBorlRfP+4z4RRdTWd/V3Lduzl40uCi?=
 =?us-ascii?Q?slIZZlzQJg2wcY6bEQd3LLCsQElynD/bWrRuoeq27XroOBh598Ja9PqjS5JJ?=
 =?us-ascii?Q?KK6JXcvzi6ePum3uJzMM93ziHVHtjubIK5Fr6Yzr0YjMSkzPXmAA9+Jxqwm9?=
 =?us-ascii?Q?IyJuGWM2nfS6iUMv0+RykEkIDjjIVzlr8rve1QALqbBxWcTCge7vZqfAS3LT?=
 =?us-ascii?Q?RjqZaSHtMVfAkaEusGASSVWQULZWhL4PPHyP7SDmkjqMloQqF2sKNnl+bbCW?=
 =?us-ascii?Q?8QV9BVbMOs/rAgz67yKz/0tFt6xQWBTQ1r1E+aVCnnms78JyZH8etP+BehzJ?=
 =?us-ascii?Q?YdlWLtnPJJSVg2FE72jzBk6ySWddaFjzhuis9sRZiTOA5mjx0UlTuNGvNrEo?=
 =?us-ascii?Q?KPln83SHvNY4todkBkxka3AluIDXHa48f5IGO3X1zgeDS/ENQ17Tlwz29lNv?=
 =?us-ascii?Q?tmwGM9HvZ37TlMWZtDzLUybOhvPP4BD50w3MwU++MIhp5TZCYu5lzpoNx4M+?=
 =?us-ascii?Q?SYBQYkP5a/mjE3gJeOFbht+Rfj2coEJpaZptFxifH43M3pi/+yPibd69oNP+?=
 =?us-ascii?Q?Dum0Qh4DyjBEFi3U+JEzFJtjMgofMOuZAcP0qJWm8xWjkjupll4MDSGgo7Np?=
 =?us-ascii?Q?Ylyc89qsW5LFXBXubJ5l6ELNsj+ofXyVAWHrzlDJCsaQNxLPosIJdOTVOBm7?=
 =?us-ascii?Q?uNIagwNualYlFialYN2YetXkQDSUSG4KJm7gqqai/ioyq2W4OVdZeseinm9i?=
 =?us-ascii?Q?D5OZrbOlcEY0lOBD5JWU/icfssn/LIQOIeuWvACHW1XU3tGE948MQwrRc2Mo?=
 =?us-ascii?Q?2n0KNDK7Q4MT2eppQx2w0np6GECMPe4Z2SqQtltI7raLBc4TsjgtbOGn7q8F?=
 =?us-ascii?Q?CekppL+6emjh7BH117XN3c4g/aOv9PE5Tr8p/m5E8zrCMVSVHk1xhjjEoSXu?=
 =?us-ascii?Q?W1jCZBbNWIl9mKwgSRQMEVjdriRirA9eFmcrKct0e8mzeAWRI1UxZaZc96GO?=
 =?us-ascii?Q?T5odgyhU+g2IPyZkgQ5Fefv+D6vksWbVqGrknRhaZ/BQSaT0kWuvgvlr/JOT?=
 =?us-ascii?Q?BUPbShMFzG+ATp/aR0XKPtajPLRSLx5zMizX0Yg7ru3wIb1uxVoDHp2SC5OM?=
 =?us-ascii?Q?Xip5tq+VBf6Xflo/LKrnlyAWVmDOICzz0Elx2zDey2hu9+pTC14IJcXp8w8o?=
 =?us-ascii?Q?x6aVHbnKHK0az+4df+dyJWk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70e1664-058d-45fc-e3d2-08dbf5cf57e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:18:28.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti2ewL1RrM3NHIHwpg+x/XG4M6aKUH/djSZPPww9ueph3shFyQlLDZVP40/+cBYqOPBS4sgojtP0DPJ6N2Z0YgCsMx9g4k+6BvswecraaOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_15,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=705 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312050161
X-Proofpoint-ORIG-GUID: WcVFVNnn3mljgDBOniekBcUbkSrR7JGX
X-Proofpoint-GUID: WcVFVNnn3mljgDBOniekBcUbkSrR7JGX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Tue, Dec 05, 2023 at 10:01:14AM -0500, Steven Rostedt wrote:
>> On Mon, 4 Dec 2023 17:01:21 -0800
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>
>> > On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
>> > > Paul!
>> > >
>> > > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
>> > > > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
...
>> > >   3) Looking at the initial problem Ankur was trying to solve there is
>> > >      absolutely no acceptable solution to solve that unless you think
>> > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
>> > >      is anywhere near acceptable.
>> >
>> > I am not arguing for allow_preempt()/disallow_preempt(), so for that
>> > argument, you need to find someone else to argue with.  ;-)
>>
>> Anyway, there's still a long path before cond_resched() can be removed. It
>> was a mistake by Ankur to add those removals this early (and he has
>> acknowledged that mistake).
>
> OK, that I can live with.  But that seems to be a bit different of a
> take than that of some earlier emails in this thread.  ;-)

Heh I think it's just that this thread goes to (far) too many places :).

As Steven says, the initial series touching everything all together
was a mistake. V1 adds the new preemption model alongside the existing
ones locally defines cond_resched() as nop.

That'll allow us to experiment and figure out where there are latency
gaps.

Ankur
