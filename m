Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C1807DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442129AbjLGBdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjLGBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:33:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EAC10D4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:33:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6MgJgF023016;
        Thu, 7 Dec 2023 01:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YmjbfD/YhYJK/NcBWzrOQz7cenxzTzhDK44IprKp5ms=;
 b=i0Ok+jHe+aOg3Q9CciNof2ipbFkU3D0fqHjWBlb9ID4iXZaBkMgvOMQ0//rVimClhFEA
 CJLo5B2ETlSYGW9aZz50HcHGfzPTh0cncPMGOs3bFCvv7KGSuxIiXqD8Gn/zK5swxMrJ
 VO7rVFMq372d2yhBel081uU2NCfz7GpEq0Ql1TaICQdONew+KP38nFYrIwSpi94T0u1y
 UWo/Wm2UUAG+cO5RtFjQTCvHaangx4ufCrZbNgAd9uPIv/VVxmKbfWK0IdsPKGh+1kcU
 BYOgfaSxqlEvT6Kv/ZluU2M/erd0/QaphdRRUtl5nfdZEPQaOKuYq0av41clZF3dw5QA yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda2rky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 01:31:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6N23wC019557;
        Thu, 7 Dec 2023 01:31:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan5g6t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 01:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I//2ql4AtAEtvi1vZSaXG0XzBx41So9TM0T352HQCLyKQffZcWyjQG5e02uhjtPSggmZsgYo6DDrNVxRQYfhy8gxYNxIrzZNtx4lL5xGAHS+zikgGs6DK/faxE33jLMeLOT8LFepdag1uZ9N4MxqWLLW+QmE3bt1KzirUnmhCNbv9dibtVUmwhGNnNFlrwLxWDFYk3rQASGWhaVrr59/Ukh1Nmgxmu3gCB38n3gzAiobOInEkQFiHVno3B6y/0JZomihZQMzWg5g10XlFoM6d5fq+TxlilHIHtu38KF6E0SPkNHhdIa+Zq6qcj/vTK7Lthpvw/+sRhmvIAcn6gEFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmjbfD/YhYJK/NcBWzrOQz7cenxzTzhDK44IprKp5ms=;
 b=Q/f+wxiDkTFBBPnHq6rtk+q6dn4qQ25oOYFjaDl/fFutT/Mbzu6cg9Z6QzO2lO7EpiHPEo4hZZGmJPWh+439D99PRQlQdTr7XNMJQJgXHK3AsBz1BMSklSSooK3jCpQ7hQXqFufLAA06XyLzCvTEkra/I8bA5HTvgL2d70UD+fHPzaGTQv7IK8m5MjEM5doE5kVfMVf8BRlvm1aUjwFQrX0nVhy931WvxpJJG+Uu0Cy+eRchOnj2ermIuaF2lnzN24yhRD6U2AzyylVcPNjGxAlUnY8vgM2NAn+Shcqj7oAzmsTDgYApRNPsEjt0UjO15y1KKErGT/DWunkb1D8ACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmjbfD/YhYJK/NcBWzrOQz7cenxzTzhDK44IprKp5ms=;
 b=N4sHBQnL9AXF3BFfNecOXkqW1GujL0kkpnTAu0WV/8HikoDgDSvW1kyl7501+gryAHl6CUy11tzJZqwN9/cWAVN6vq6Tw+wVOJK7l5SEhvpvBYPTE4N3xRzDpw0zsMMpH/aqBeBplnHPFy9QqW99jR/M9Qzp3Y9AyU6YnyZ+JAg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB5916.namprd10.prod.outlook.com (2603:10b6:930:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 01:31:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 01:31:32 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
 <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
In-reply-to: <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
Date:   Wed, 06 Dec 2023 17:31:30 -0800
Message-ID: <87zfymn6h9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: a1385476-88d2-4202-2b45-08dbf6c43e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2eGj7z06pKScPJgoZUq5+I8d6czkjkLPHCs/+FpX3zFDV7hX8RV5KbSCeT2yYnDJp36/WV4KeF8iHIqnCRCKd/E/txzjS/l5cvq0/1S8sPmJ7wjZxvO+xlTK2EpqZElNjun6ujnb7TYrAhOp+9xwDA/cGfE8ONDieuv+z2FOyc8eVFjG4pBdsTMvWfwhtBlq1Mzw73zA+IFCju7XU5an5/eK/HCzzGINbyUJ9DJbTvXSvsOD1VO4tluCRjN1sIPd2tSARzLBUHvBwzTp4041R6OwJbZg/8ba2W97tzVTIp87Up9gPfz2HC6gHg1Sp3ki7h1iFEhOjxMdnO9lgSVGfOr/8tDhYNaxM6Jkb3vJ4d4oRgUTvZBvdBjuatWhsMK0ToJGrQ3OmsicOCba37/CoLB4qYJh45GNKaRHRjDWMfxNB21XFZ7kY3Y01Z+mMuvD7inW6/hHYXWTUw7BXslpBqwCH2aYxw8DUj4riyiWyP+LV0JKxTWRQDenVyexIQTLDU10J+K4SMOTxVC80m7TgWPgj+n0bvwBKB4Iybmf6OvmP8v5uOejL0J5k3jCXfnrzpQYYx3ONU9WKJIaGNgdD9dauEF8zLMTlxdRJn7ecylzWktWDtMwvJ7734Wa2l3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(2906002)(86362001)(26005)(83380400001)(38100700002)(5660300002)(66899024)(6512007)(6486002)(478600001)(6506007)(36756003)(966005)(2616005)(8936002)(8676002)(4326008)(7416002)(7406005)(41300700001)(54906003)(6916009)(66476007)(66946007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQWBsLULSpsG6TXhvwTKEpuNchbs8ubiaX1ArMexay51ZvhXqNem1SDGZPVZ?=
 =?us-ascii?Q?NlTqSK2rdGD7xCYlcUcJ8suEa/QzU/i5x6HhaoyLM/hrsK1WehUOB8fzCaM+?=
 =?us-ascii?Q?Jq8vJ+l0A0rBAc7WTYwXJ3H6V8xHpb3TCkUXhvpZqENGNx3T9e71xnVWKLdS?=
 =?us-ascii?Q?uq6NyLc/JU2l50mW0+X5TknrtoSM8fsgpRRzxpD6etVc8TB07eDeuPpGFrAe?=
 =?us-ascii?Q?E/Rl+CSka8PSGNZrgjG/wRTed1NFVPwWkvQhJTpRzZsA7JmbhmxisAfsijDB?=
 =?us-ascii?Q?Qj34bV8N3HmKgz9RPSUDb9kldjq37vOmEtW0K/wRF4RSGhC2gyzrxJW40rJY?=
 =?us-ascii?Q?rjznHjE5WcKZqayH6W7Cyk2x1a4LuWPpCPRKVEoR/HlWiXeU1u3PSqZGhc1n?=
 =?us-ascii?Q?2YjrIMkL4pdRnEbgHKipSspBDoMSYQM86gN6/u+gO9w+EFm2zgC7mZ1X2vxP?=
 =?us-ascii?Q?I3Fq7XxpWdxpU1ya6jkdCfQZw/irXZWRNXc5xs5s86OiKbHT26S3MtVwOK7F?=
 =?us-ascii?Q?mVuomTnslnviRLZ0vrMYA91SBi5DkRbaKZN61CAphi7NRg2KdFOnOdATdACi?=
 =?us-ascii?Q?JBZEg8tcaQBaRQrD24ZaS/CLZola8f+3Z9iCsOAfqUM1p9TZOLytRhZf9f8+?=
 =?us-ascii?Q?0+/oq6mRtLrjY/LFWWAS4KXw55hoWnB3+dIqZ24a7qEILKJXHUV8BQpCAI7R?=
 =?us-ascii?Q?hZdGdReiMB9MQJEofc7vKFq8/7YVMJ8rKfUDgbPJxWDu/0oIAh0xTtY0y4JF?=
 =?us-ascii?Q?DJ/nf/Jzcvj3e5NW7gB7xZaLsww4xPnfrUl7ixJZhPaDtOisUHpZC9V5p+dS?=
 =?us-ascii?Q?5NOWS6sJ+tlAryJxRy5nxegKViEeZyrcCaaElDPY2Tw79ntH12tfkkHCSuln?=
 =?us-ascii?Q?EFxm5YVccJCxC3RkvICxdY3IT8vmgXtiqan4TcFkut4NRSKjW8KPyaRab83V?=
 =?us-ascii?Q?Yq097tFgD3ToOn7Bc2GV5SymwSrD7LUuQInPkIgpA7NHcrcAOQheCoONdRiG?=
 =?us-ascii?Q?/aLD+zZ77n9dQXSRteCai4kw5mJYn2OPQ/vqCBm/XzQ5zjgoARoVOg5SKDjy?=
 =?us-ascii?Q?S1d1N7cGOaXTtuvxVp4ECQ3ZMw4CKKm1mPv+qHZPwa9tzcLZ6JBCgBdBNRtC?=
 =?us-ascii?Q?lCg5fgmMHfZBl/dRWl2A79hHlK7vPQLfaCFEcKAkojQ7Vj4wPTcBWD5cDX4N?=
 =?us-ascii?Q?cG/m89vFF9AnImW8p41aK7O/1gxMfCjOvaNh1il+xtyV8L+Doj6cUCWWcZLB?=
 =?us-ascii?Q?Mx9e4Nr04xHxW5enyXSMW3nylcrRURH3y0sOGbqHhvJZLNQtxn+U/KvDj4WM?=
 =?us-ascii?Q?kqjhKEBmv12EHimax9N7k87LXNDoyZAA2RYqJ/NmwbIBpmETfG1pAJgVQP4d?=
 =?us-ascii?Q?PG5JANBSnSUCCNqGb0zXw/mrd6W/jAaiQXgsB8gNW5XwOcoTY/saTtBkWKiI?=
 =?us-ascii?Q?hgmgHQ2N7tDx26wIzJdgh+fr0rpEj6HUq/iwKo4DDkX/dnC9LexC//Kz3dS6?=
 =?us-ascii?Q?dVJE10o04Tgja2uVHDmiaAnQJysESM+nyokHT7jP87ELRqpQKZGGnxaAeiCL?=
 =?us-ascii?Q?Xv8YOuuDqaczpE1ljJEB7gIoKYrc+rQ8EueCH/2jrjnL+T3IvBUWZErzQVWs?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Xf7LmLRT0woxQ4lF2MVzHJxVLwcAnctWc866c71BI0771TjAMlIyo2OG5B1B?=
 =?us-ascii?Q?Dm6euKOOMkfAJovnxj/e3WjewcKudPk6S73LbyxtXFQ6aHxIaC6v80+ESy1L?=
 =?us-ascii?Q?QqrJEBAZ3IMpMxYUlLqD9Zbq6w9kJgPpaz6upZYT0Rg0ReD7xVhP2KGLpQ+f?=
 =?us-ascii?Q?hyudMI83ohU0xLBVCY8CoHp0EIa3VP0+dUeTAKGEemCmwUeudWNfPWoboed3?=
 =?us-ascii?Q?aH12wB8mhSPtmLgaVtubbCS2Sz9S2Do9v/Pt2yzcUZtB5ZJY72NPMfRt6ERa?=
 =?us-ascii?Q?g105L1cGerT60AwhzFQjo1u9rTZR68CY1TmpO78ZekVpAXB3BwjhSKX4WfqF?=
 =?us-ascii?Q?bAOwLHZTQbHpvWHrkNppwBfNKc0s27tTrnSVa6JGpv8y2Hd9m+Zij6mjQbVP?=
 =?us-ascii?Q?W7LDBwZRb0OipInML4I2KBcJ6MB7alc/WZeCzhg4y/SVrRdMZYJQblq1p7Iq?=
 =?us-ascii?Q?1OfQX2HzhsDWca6NhYyGLzsD3wAQ6L6k9lX6d0/bHKgfaWeIziwA2n7PpYPM?=
 =?us-ascii?Q?PjhjjTzpRKMxKZow12yDZTgKk/mkORrKpjmvobQ9t3UZSsUDLQupY6NI5THD?=
 =?us-ascii?Q?BMsbqVo32rqFFPotRFlvQV9TsJiQ3mAbUzDLdbO1dO4NuJAxqgGWVl3FkYN0?=
 =?us-ascii?Q?q6u+Q+8js0CsDeKDv0Y7BQBz02RJYG2+5Jc7xepYihuWFtUV6Kbj1H/6CQhN?=
 =?us-ascii?Q?oAw7m+YWxKm3ESAOY7xnSW+B6h6k1zMg5mSdGvrNXPIJi7KESXkZRnqF0wzQ?=
 =?us-ascii?Q?8i46ZlRP8kLyb7exTSpaxRIy5J+YZiTd1jHun0lPsiPrS1+aIUkzFE6UkgAK?=
 =?us-ascii?Q?wGduPNrUKnjQvRNmz6ara7fVIBg2/zC9B+P26XsKBcdkVvT1z/vH3S/wczEM?=
 =?us-ascii?Q?Rqc0INZX78nv0/pLEKDE6h54JPrrTt6A2z6N6eyvCg4+GuqX0OYW3e1CWnx8?=
 =?us-ascii?Q?QQrgDddm5Bm1GwYOL5skWD1OCg8cVC5sm8gtHg8YfJnFRwiwclLCtJHZH9e6?=
 =?us-ascii?Q?3YvcrR7qcqY42RhvadHhu64dxjONIPfhbin7gemGmslKVUx0bGq+DUf0XBrn?=
 =?us-ascii?Q?AkGIDwVuBOcjydQn1sw56M/p2hVQbG8xe9++3A7sHWsHbq4nitBzF04JeR5v?=
 =?us-ascii?Q?T2OKt9AiezvzUhlHsTHgZqtfx71Vd2MMIfaRdW+oKqLMM+/abKV5rDhBSjCU?=
 =?us-ascii?Q?8Q0I2FfTiABnURur/FqAyCrqFX8TQ8IHkueP6auy6IMknyAZknqffQBo6lMm?=
 =?us-ascii?Q?m7o+KDDlbWIQpkOH776E+b7zvrpE+SRM+t6RUEq7IsHBiclzWFymVI/Bt5FC?=
 =?us-ascii?Q?bKJ1EF55ZtjuMlW18ERZuM/oy2LJ9d1KBxOUm9JuljA/dWgG947cBoGjrEJH?=
 =?us-ascii?Q?h0YVNZSmvhUG73pLTL4vihDKy1s0PiazVxCyutwDHf0UTGPkTu0K5d+LHsvm?=
 =?us-ascii?Q?15aizF0bjewwte0bU+D1s/GaJC2+LU5QtdFTSQ+7Z32JatUpo/a0LaUMlMBj?=
 =?us-ascii?Q?DqZ724aiSU6aJACj9DFO0CTXzl+BEgLmqEIzQUj3g5aRVNseg2LkSiZu8A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1385476-88d2-4202-2b45-08dbf6c43e59
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 01:31:32.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFSY+sU7c+HkwpJbrzCZLHXvIYup22IJHSLiKe6PX9kmSLe1sjrlkXBTucN5e4K/NH3xs3soWXAidTRfsWISI9/C1U+OmXnDjWHuF2tO4IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_22,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070011
X-Proofpoint-GUID: Z6aMkmvdI7RUv8FifeERjNejsByxfGuU
X-Proofpoint-ORIG-GUID: Z6aMkmvdI7RUv8FifeERjNejsByxfGuU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Tue, Nov 28, 2023 at 06:04:33PM +0100, Thomas Gleixner wrote:
>> Paul!
>>
>> On Mon, Nov 20 2023 at 16:38, Paul E. McKenney wrote:
>> > But...
>> >
>> > Suppose we have a long-running loop in the kernel that regularly
>> > enables preemption, but only momentarily.  Then the added
>> > rcu_flavor_sched_clock_irq() check would almost always fail, making
>> > for extremely long grace periods.  Or did I miss a change that causes
>> > preempt_enable() to help RCU out?
>>
>> So first of all this is not any different from today and even with
>> RCU_PREEMPT=y a tight loop:
>>
>>     do {
>>     	preempt_disable();
>>         do_stuff();
>>         preempt_enable();
>>     }
>>
>> will not allow rcu_flavor_sched_clock_irq() to detect QS reliably. All
>> it can do is to force reschedule/preemption after some time, which in
>> turn ends up in a QS.
>
> True, but we don't run RCU_PREEMPT=y on the fleet.  So although this
> argument should offer comfort to those who would like to switch from
> forced preemption to lazy preemption, it doesn't help for those of us
> running NONE/VOLUNTARY.
>
> I can of course compensate if need be by making RCU more aggressive with
> the resched_cpu() hammer, which includes an IPI.  For non-nohz_full CPUs,
> it currently waits halfway to the stall-warning timeout.
>
>> The current NONE/VOLUNTARY models, which imply RCU_PRREMPT=n cannot do
>> that at all because the preempt_enable() is a NOOP and there is no
>> preemption point at return from interrupt to kernel.
>>
>>     do {
>>         do_stuff();
>>     }
>>
>> So the only thing which makes that "work" is slapping a cond_resched()
>> into the loop:
>>
>>     do {
>>         do_stuff();
>>         cond_resched();
>>     }
>
> Yes, exactly.
>
>> But the whole concept behind LAZY is that the loop will always be:
>>
>>     do {
>>     	preempt_disable();
>>         do_stuff();
>>         preempt_enable();
>>     }
>>
>> and the preempt_enable() will always be a functional preemption point.
>
> Understood.  And if preempt_enable() can interact with RCU when requested,
> I would expect that this could make quite a few calls to cond_resched()
> provably unnecessary.  There was some discussion of this:
>
> https://lore.kernel.org/all/0d6a8e80-c89b-4ded-8de1-8c946874f787@paulmck-laptop/
>
> There were objections to an earlier version.  Is this version OK?

Copying that version here for discussion purposes:

        #define preempt_enable() \
        do { \
                barrier(); \
                if (unlikely(preempt_count_dec_and_test())) \
                        __preempt_schedule(); \
                else if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && \
                        (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) && \
                        !irqs_disabled()) \
        ) \
                                rcu_all_qs(); \
        } while (0)

(sched_feat is not exposed outside the scheduler so I'm using the
!CONFIG_PREEMPT_RCU version here.)


I have two-fold objections to this: as PeterZ pointed out, this is
quite a bit heavier than the fairly minimal preempt_enable() -- both
conceptually where the preemption logic now needs to know about when
to check for a specific RCU quiescience state, and in terms of code
size (seems to add about a cacheline worth) to every preempt_enable()
site.

If we end up needing this, is it valid to just optimistically check if
a quiescent state needs to be registered (see below)?
Though this version exposes rcu_data.rcu_urgent_qs outside RCU but maybe
we can encapsulate that in linux/rcupdate.h.

For V1 will go with this simple check in rcu_flavor_sched_clock_irq()
and see where that gets us:

>         if (this_cpu_read(rcu_data.rcu_urgent_qs))
>         	set_need_resched();

---
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9aa6358a1a16..d8139cda8814 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -226,9 +226,11 @@ do { \
 #ifdef CONFIG_PREEMPTION
 #define preempt_enable() \
 do { \
 	barrier(); \
 	if (unlikely(preempt_count_dec_and_test())) \
 		__preempt_schedule(); \
+	else if (unlikely(raw_cpu_read(rcu_data.rcu_urgent_qs))) \
+		rcu_all_qs_check();
 } while (0)

 #define preempt_enable_notrace() \
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..2ba2743d7ba3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -887,6 +887,17 @@ void rcu_all_qs(void)
 }
 EXPORT_SYMBOL_GPL(rcu_all_qs);

+void rcu_all_qs_check(void)
+{
+	if (((preempt_count() &
+	      (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK)) == PREEMPT_OFFSET) && \
+	      !irqs_disabled())
+
+		  rcu_all_qs();
+}
+EXPORT_SYMBOL_GP(rcu_all_qs);
+
+
 /*
  * Note a PREEMPTION=n context switch. The caller must have disabled interrupts.
  */


--
ankur
