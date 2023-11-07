Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0A7E4C92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjKGXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjKGXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FEC25A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmiE026251;
        Tue, 7 Nov 2023 23:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iI2Z3QGnF44r/VGe5kI4eNp8TGYVc1L19RakcS48BlU=;
 b=pYadvMyqtrF0Ncsp1kbsZpldOPd3BhzqhQkwf3QGCWYhKHemV3kK338tweFb7QJQODYf
 pEhxHkz7nosUupobERyiNVki8REVg8UtMh/42rSdGOX7Jejon4m9jd3yYjnWaRP88xDd
 C0ka5I5eKCnPKvh9B46ZGpZjPuVS1VXPijLWN1RbjmaX0yhIsajij7HK7jlM1rEXRa9N
 WF4VRLXYUAu6t7iPxjsV3c6SGeZiiAOxAfhucArgxHGRYBZzw8nGfjdewrrOvR2MRv9d
 OuclhXR7sXfw8Zy4LsDsyp1G5nU+nwUWqWQmPqFYY/atacLijtr9fv4xlwSiCbfPtvdq 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2B2A000412;
        Tue, 7 Nov 2023 23:09:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ5sUelAiCyFi5dQGV9cXxGARepXF9+g5/5ouGl6fmVg7bA/FXQoZrYhT8QmeuobToXgFdcu7x/nGBgUdBzL2VJN7Dk1pSHus9fGRfKWYc1B/J3nrD4fnL4gwtHHk0GfBo8V51BGHkeA/iOc0jpP55/WL/h/klex4uxuV3ancPvvujgltTODf9/iEuMn9zoc/SNhP/jGC6ofhhO78pLBdRkpue2/pXu0wdCUvlM7jLoEGevp8VqdJi/vgTAxOv1tg1DkBFZdgD3BS+gBc4I+n4+9mz3p+8xM9yvHsvTEAI1JocxcpHAc4MuMhgGSePIS1+zDD3nMyVvo2OKF+vzsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI2Z3QGnF44r/VGe5kI4eNp8TGYVc1L19RakcS48BlU=;
 b=lg77OHjNczXROHfih1bKEsri5+u/OCVCxUgBW5/08AebtA5DvnRGQvmp90ayBTU/mMPJpZR9q6XfM06U4dkq48x4JSSKZW92QYsDCjQ1QQWa5zJu6DAYqDys914or/R9TLrwr0fmNBaqYVMgW+VA4urg/rJLT0DimCbvLhGRGBftKB0q9xJ/Z6aI9lOq9CO8jp0o7nTPsSUQuQpr5AUDeW0xPc342upaFlF49/gKaE3eKOFqYNHWngTu15/FiBZ+cQ6vUTaXeD3LnG+cp3Frr7zRoCNkEiJzEHyIm+w0obHfIqGP3MmPslrXhurFRO5LLxPllDhTMWyNPT3KoUnmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI2Z3QGnF44r/VGe5kI4eNp8TGYVc1L19RakcS48BlU=;
 b=f0exSD+toRJOGBMGO7t1lXxrXgQ67aTwLzP0Lo4Q3deIOt3GhDJZ3SdSLYn9hnaq/UuxJ9QkZrTKqgmXpM6rZI9Q1WxQmE/OQCzb547UPndIeVhXf3n7rUAee+TNZgDpS4U5vXfaDTxPLEUhJXRrZxz2KPtf3aK6fBMHxWS+s3A=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:20 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:20 +0000
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
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [RFC PATCH 74/86] treewide: fs: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:10 -0800
Message-Id: <20231107230822.371443-18-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1643603b-781b-4402-3c84-08dbdfe692d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxkTOJJlyJLRBuU5Eeka5Fy8aebfmn7GodFPYqWIFwdUEwjGdNTwOqMuLelKM33md61AOJsxGnI1nLodd41mQT1VYyuVwzYco5M5oqth4KDpd8tt2N5uOIAPxvRRsAjV4xvWYsjo4OQ7OAGkt2Kuw3nWiIIP/Poo/6Z0QYqUXgtQZOQ+IJ5/7eiu0qGQ/1OobvrWNNa0cEyE5W4m7kVlxZvu9GJeJiQOsPp8H1eYhET93jWXY7B6Zko3cow6xVpPnf7knl/8bSlOK1cE++dLi+7DikA+LU5M3jtRpGRYTlvmxQMvKe72QF8cmb1MQep5oySJexsMVSSu6xpe2s5Vb4Q1eWuiSJugX5sxgM6SbQm7rOxfQKmou7UqfWV0aoYi76Fg+TNJuWZ1Vp4Pj8gEt//wZHhA7WusPM9o8RWL+ZRZRWM8PBRvca1NKrhUO4cacpA6mjABUP50Ngujz1Zllq5G/MV8xgi0XxfYN92HyWlTjCmMz6dk8p4FdyottCAGIzMCXvn7MpThcbFfhkjQfX8PgPTJ+M0OlljR3O+qsr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1bSfBJbmM5PtiyoafXDZoLMfUQm6ANQyCaJ+s7OR8nhtXDn7xkFKJNL9Ybwh?=
 =?us-ascii?Q?CoO4aUnDxgXTSZRsfrmRytXaZJJfRaw+KGDvm1rf8OW9kH4i4rSr/WNFvLga?=
 =?us-ascii?Q?ej7E0Zd7Ld00kpuOoXk5TM8Q2zDBZHWeFBhGG+r5c7BoL22oqEZjkNT0z8kJ?=
 =?us-ascii?Q?VpN6jHKAbYhuhhjwegaycZhxIVr+qiy1mG3c9fd+hoaKV3QXdk4xRnr/o/fz?=
 =?us-ascii?Q?pO2oDIrPsxQknXQasqh0kehwsMxzJAEoIRTnmi085T2P0vvLyEbu6721KDGl?=
 =?us-ascii?Q?3V+8vN9MIHf0KDw3fEC6NPPfOpg6nB9nuRTEBmg6WVho+Wxgq9G2jjNa+YOy?=
 =?us-ascii?Q?xm3rs7Sz9YGHMESHBHbT0xudErlmUuUI+SWvMLQXVOWKELwDldcz0mNqkKNa?=
 =?us-ascii?Q?GVdIYooAXsd3PU70Vfga9HqdFZJZoRnVuvpTzkW8Mfg5kRDC2zRxRWkQJ547?=
 =?us-ascii?Q?gm/1HrHJihIAhEqGZOD4lHA3AQaN0Wyx8CT7nIrq+NuPTyHVnmdWcnaqp2Ky?=
 =?us-ascii?Q?iSzowMEBu4c4ZzLGT9dOyHikzdoPLuyN6o/32M0qHVWuXagY/JUhmkFRnVHQ?=
 =?us-ascii?Q?EAmICZRGiXHUTe1QHPiPqwGANz3UIyExm6U9KnbdrBFllrkks5mrqaz285zp?=
 =?us-ascii?Q?GYFhBoxMLfQmrjvSW/7zv+V8nhsmr6LDkXaggIpAr6xjIf5AXRvGzjEOSjcI?=
 =?us-ascii?Q?ukd75ot+LKM1n1mo+k6CG3raPMKMHSZN6fnHAZlrZMeOkuYRg7Aakg1wsx2e?=
 =?us-ascii?Q?Hc/EJKbHnhluFXdy0ed424AFcgjifYIHx2+UhNPyiRYVC34Sq88gJG0n+A3b?=
 =?us-ascii?Q?5RjnHs2/VASg1ezLLJUp3CYMFSslDpVRQm7wW/mwq3G7PpIqQDOmqmRltTH+?=
 =?us-ascii?Q?3qCqCAvtlKPVe4g/j4hrxPuMmDEfMYzqBcQx0z0RZriiQvpXMJ36P2lG4zKz?=
 =?us-ascii?Q?cpAvXDpRPzcOYeM50kK0g0JOM8BoNrfO+qmxOlfd+wU5cIeKayBcCByjQVKS?=
 =?us-ascii?Q?QsmMDvM1Ll5CUo5aQIyMepUi7SxGC+496ajkmhiLhFNyi+L5yIkPTuu0tAlj?=
 =?us-ascii?Q?2o8rn2t/4M4i03Ckb2Mm10Q4fjBtaMpUaYDxpr2/hxZf98nD+k6uOqL2SPQw?=
 =?us-ascii?Q?UMPzKgHK4mavq9AdYwbtjBi/b9YbNCJjOfq6qHmo+80QrplJWtqdJubglvH3?=
 =?us-ascii?Q?NiVSv0wqLm1Yo46p1SnzUsHKfuOC3x7NcuUCFbk6VMYS3CalscHh6Fum01VF?=
 =?us-ascii?Q?D9FFVhe3A/PGqfxidsuv1GLsulT0swJzKOLrQYBRQrukdkOywhuXCKF3BtFw?=
 =?us-ascii?Q?EXD/gz5q5j3yJBHHNO4YS8H5iMJzN+kVeG+KhWUS+h7aJIux6xFQhC2D3Pj8?=
 =?us-ascii?Q?8oFmKj3xYtjpFMOhrI/3lRwhhJC+r0RELTV9EFI0ZQlwjxPi2K+2wkFgHNU+?=
 =?us-ascii?Q?GHFDmx1stxqVk2Rye6XhBCclxhe+JIykWbaF4bECbibL1svs+D279VbBWO0C?=
 =?us-ascii?Q?wsXBhWL094iCfgde2+RP7Mf1mFbXjb5uGImcTt+4d/2y24v+/uc5oWna5F0p?=
 =?us-ascii?Q?Ylo98oBKFDBxGlDnbIMrs2GtTesvlLMAFRwXAfSRhz7ssZIhtRp0oaLLQblR?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pX42GqENjayJ/J9nCl9yvMPNQ5UlOvyPpOoA6Wz/b77QWYu6L/HSCYmOKQTF?=
 =?us-ascii?Q?kIOi9+YMroxcMu8ndJ7pJSSjRwYyYGm8dp2VXoxLDUhUt/YYo6dNbAlNjGbp?=
 =?us-ascii?Q?ueQzVtKWQgg8/3u1no8xDr3CtZWatYN2gGGiV9lkJUEUFrRXBUCW4jzzxVXx?=
 =?us-ascii?Q?f3btwhCmYA+RVAzHVJu64OleEzYeUQ2FnjF4fUv/9TPF3pnlXeOMacZbnYDx?=
 =?us-ascii?Q?c1j168STqxAVpJrSWP1PjbooLXHJ/hejqp1HLzRzx4YQaXyUvE+dUI0pqQDs?=
 =?us-ascii?Q?1S9NTNRDmnf5UqSQUDaFgud2ZJSiBAUFLibx4ZiYXThtj/ic+Y0p0AEVi+T9?=
 =?us-ascii?Q?RmkKRtbK5GvI5QGU2spUXYR0XJiQCFdUGxXsZdL+wugbWjcMD0vbYFFGE8BH?=
 =?us-ascii?Q?5nK9/CaqXqS2N/XU0Ys/5qn6BA9D3v8LHIF1+XfjjhhQ0djgROkw7CaGS5oO?=
 =?us-ascii?Q?eUB7J+u2nBCICathLTwup+fByzfIexj4cq231T91OyLFJW0OhaPkrsn73Hm9?=
 =?us-ascii?Q?uA/XI/vfEgAmFFLXjMcxl51/l6D94jSScaIPTowgM9wH5e96SYuA5Ydt41Ee?=
 =?us-ascii?Q?P6mLHjocVsuA/fo9es4xXZUrnN1PWevJvixEi6Ty+h6ZssH6uaJUYTCeREkW?=
 =?us-ascii?Q?lwwqR65cLxZS89H3Go8epJ5rR8Ho/pZjJLYu/r0uTJOVtTtMIrUTGkQ14N0h?=
 =?us-ascii?Q?7q6GgeVqJHC5yYXc11A9aeYmGmnOkB/Nxe4PT117wrpgPSJq+PIPfcjjPXaL?=
 =?us-ascii?Q?HwspR2/Llsf7bqHWApJn8MRE9hZgzz4gsNjkwCnqC4pCtu3+zNA7Fr/Xc2kC?=
 =?us-ascii?Q?4X75JGDTQyBBLNikEIkY1I8uqg09hQ4JeM4RN6BdXvG1a4QW6Mq6Bvldn9Jd?=
 =?us-ascii?Q?QiiQ+7GZLZMjIb+c1jOPp4gW7RLlU1eOj+JCn9eWGVkRgnZecFP3yLDLrSJR?=
 =?us-ascii?Q?/vf8mULaz/0CaCiXwS2hdSEFGfi3V+AMcI9LEOa5HP7rGvBKBuAZOERuQpWK?=
 =?us-ascii?Q?Tk3XdYL0rCzJuUCECykZcCRgbz3zKIQG9Mex+H80ZNH2YIX6ZzCDt1FxppOi?=
 =?us-ascii?Q?gvu+xOj4UL/hDMrVX1KNwblpfqgki7EDJ/4Jd8Cr1Tq9qDt2WxO5TH8WfoTm?=
 =?us-ascii?Q?NwVmoPmb298aPyURWkYzob9Fnk5M5j9zOrs8vAuQQGHoIc7jGdDcXE+N9bv7?=
 =?us-ascii?Q?nyLWzoPsE+UQwxefZ/QbJKKuMFwwMwVCGmhbspzoaw/7VpFgyUDkvwk1GHGS?=
 =?us-ascii?Q?F0TrBoaaNKBPDf5HYizP/tc8cF2GvSt/BALidO9PKspFvCGjYsGzLQWl9T25?=
 =?us-ascii?Q?PCHre6xqPoF2EEe3ArZsKI9G/eBLN4TuXfX3MsdaM3D8WUFH5jA9ibSmQrRg?=
 =?us-ascii?Q?GFkt9YHVomHWqerxhvhQ2bHKCXZ63pscnjezH2gLzUxKu1Mn9ge29Gb8WS6G?=
 =?us-ascii?Q?BHos5N4HPpOFSacvA/c5dGcyJI+xodhc9DZtP5ozbq/I8I4D3MR39GspU406?=
 =?us-ascii?Q?OSMBTrm6jxK6NLA3N2AYZH0X8wF+JWZq/LewsVYEMMNRsv8Er1eoaCQluEJM?=
 =?us-ascii?Q?8chWCcjfhJQ8JDnBcZ/1364darJledJW447J6kNTHVJvkm+WQyAzbjwjzn9H?=
 =?us-ascii?Q?ZP+SgEEj8NniT75sQeNSbEllOMQpvayKUzpyhngLDKHAn8lRmESxP63s1QI3?=
 =?us-ascii?Q?rLc0S6IcywkcamuyzBzmJoaDFAtMfwvcR+pYT6V6DAxWTFTbo0ZAdJ1/1ijU?=
 =?us-ascii?Q?TADOGb7Oy3AFPW6BXjILm1xYPAKTm22CV5n/yFCebn2vcEYMwLIZyBqMx/sT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: BQauRdTe0rPrMMi+k6NO4sO4JLlu7hnvX54ozkjAUk87QQgC2kg1fkhWxf4L721V1pOIunIFPxh/Mvf87xN50Cg0cAa1fBy3rm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1643603b-781b-4402-3c84-08dbdfe692d5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:20.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDGPCrVMOul0NDzE4gvATljGrg5qtYs2b80VluvkX2bTD5011jTIg6QgktmuHjAvS5D1uswhBWtA8u72wkx3MNBQjl9CBK26lmyNRkx3+Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: 3PFe85h7iLGwOPvpeoKH_wqGTfBhnMmn
X-Proofpoint-ORIG-GUID: 3PFe85h7iLGwOPvpeoKH_wqGTfBhnMmn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most uses here are from set-1 or ones that can be converted to set-2.
And a few cases in retry loops where we replace cond_resched() with
cpu_relax() or cond_resched_stall().

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: Alexander Viro <viro@zeniv.linux.org.uk> 
Cc: Christian Brauner <brauner@kernel.org> 
Cc: Gao Xiang <xiang@kernel.org> 
Cc: Chao Yu <chao@kernel.org> 
Cc: "Theodore Ts'o" <tytso@mit.edu> 
Cc: Andreas Dilger <adilger.kernel@dilger.ca> 
Cc: Jaegeuk Kim <jaegeuk@kernel.org> 
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> 
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> 
Cc: Mike Kravetz <mike.kravetz@oracle.com> 
Cc: Muchun Song <muchun.song@linux.dev> 
Cc: Trond Myklebust <trond.myklebust@hammerspace.com> 
Cc: Anna Schumaker <anna@kernel.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 fs/afs/write.c                     |  2 --
 fs/btrfs/backref.c                 |  6 ------
 fs/btrfs/block-group.c             |  3 ---
 fs/btrfs/ctree.c                   |  1 -
 fs/btrfs/defrag.c                  |  1 -
 fs/btrfs/disk-io.c                 |  3 ---
 fs/btrfs/extent-io-tree.c          |  5 -----
 fs/btrfs/extent-tree.c             |  8 --------
 fs/btrfs/extent_io.c               |  9 ---------
 fs/btrfs/file-item.c               |  1 -
 fs/btrfs/file.c                    |  4 ----
 fs/btrfs/free-space-cache.c        |  4 ----
 fs/btrfs/inode.c                   |  9 ---------
 fs/btrfs/ordered-data.c            |  2 --
 fs/btrfs/qgroup.c                  |  1 -
 fs/btrfs/reflink.c                 |  2 --
 fs/btrfs/relocation.c              |  9 ---------
 fs/btrfs/scrub.c                   |  3 ---
 fs/btrfs/send.c                    |  1 -
 fs/btrfs/space-info.c              |  1 -
 fs/btrfs/tests/extent-io-tests.c   |  1 -
 fs/btrfs/transaction.c             |  3 ---
 fs/btrfs/tree-log.c                | 12 ------------
 fs/btrfs/uuid-tree.c               |  1 -
 fs/btrfs/volumes.c                 |  2 --
 fs/buffer.c                        |  1 -
 fs/cachefiles/cache.c              |  4 +---
 fs/cachefiles/namei.c              |  1 -
 fs/cachefiles/volume.c             |  1 -
 fs/ceph/addr.c                     |  1 -
 fs/dax.c                           |  1 -
 fs/dcache.c                        |  2 --
 fs/dlm/ast.c                       |  1 -
 fs/dlm/dir.c                       |  2 --
 fs/dlm/lock.c                      |  3 ---
 fs/dlm/lowcomms.c                  |  3 ---
 fs/dlm/recover.c                   |  1 -
 fs/drop_caches.c                   |  1 -
 fs/erofs/utils.c                   |  1 -
 fs/erofs/zdata.c                   |  8 ++++++--
 fs/eventpoll.c                     |  3 ---
 fs/exec.c                          |  4 ----
 fs/ext4/block_validity.c           |  2 --
 fs/ext4/dir.c                      |  1 -
 fs/ext4/extents.c                  |  1 -
 fs/ext4/ialloc.c                   |  1 -
 fs/ext4/inode.c                    |  1 -
 fs/ext4/mballoc.c                  | 12 ++++--------
 fs/ext4/namei.c                    |  3 ---
 fs/ext4/orphan.c                   |  1 -
 fs/ext4/super.c                    |  2 --
 fs/f2fs/checkpoint.c               | 16 ++++++----------
 fs/f2fs/compress.c                 |  1 -
 fs/f2fs/data.c                     |  3 ---
 fs/f2fs/dir.c                      |  1 -
 fs/f2fs/extent_cache.c             |  1 -
 fs/f2fs/f2fs.h                     |  6 +++++-
 fs/f2fs/file.c                     |  3 ---
 fs/f2fs/node.c                     |  4 ----
 fs/f2fs/super.c                    |  1 -
 fs/fat/fatent.c                    |  2 --
 fs/file.c                          |  7 +------
 fs/fs-writeback.c                  |  3 ---
 fs/gfs2/aops.c                     |  1 -
 fs/gfs2/bmap.c                     |  2 --
 fs/gfs2/glock.c                    |  2 +-
 fs/gfs2/log.c                      |  1 -
 fs/gfs2/ops_fstype.c               |  1 -
 fs/hpfs/buffer.c                   |  8 --------
 fs/hugetlbfs/inode.c               |  3 ---
 fs/inode.c                         |  3 ---
 fs/iomap/buffered-io.c             |  7 +------
 fs/jbd2/checkpoint.c               |  2 --
 fs/jbd2/commit.c                   |  3 ---
 fs/jbd2/recovery.c                 |  2 --
 fs/jffs2/build.c                   |  6 +-----
 fs/jffs2/erase.c                   |  3 ---
 fs/jffs2/gc.c                      |  2 --
 fs/jffs2/nodelist.c                |  1 -
 fs/jffs2/nodemgmt.c                | 11 ++++++++---
 fs/jffs2/readinode.c               |  2 --
 fs/jffs2/scan.c                    |  4 ----
 fs/jffs2/summary.c                 |  2 --
 fs/jfs/jfs_txnmgr.c                | 14 ++++----------
 fs/libfs.c                         |  5 ++---
 fs/mbcache.c                       |  1 -
 fs/namei.c                         |  1 -
 fs/netfs/io.c                      |  1 -
 fs/nfs/delegation.c                |  3 ---
 fs/nfs/pnfs.c                      |  2 --
 fs/nfs/write.c                     |  4 ----
 fs/nilfs2/btree.c                  |  1 -
 fs/nilfs2/inode.c                  |  1 -
 fs/nilfs2/page.c                   |  4 ----
 fs/nilfs2/segment.c                |  4 ----
 fs/notify/fanotify/fanotify_user.c |  1 -
 fs/notify/fsnotify.c               |  1 -
 fs/ntfs/attrib.c                   |  3 ---
 fs/ntfs/file.c                     |  2 --
 fs/ntfs3/file.c                    |  9 ---------
 fs/ntfs3/frecord.c                 |  2 --
 fs/ocfs2/alloc.c                   |  4 +---
 fs/ocfs2/cluster/tcp.c             |  8 ++++++--
 fs/ocfs2/dlm/dlmthread.c           |  7 +++----
 fs/ocfs2/file.c                    | 10 ++++------
 fs/proc/base.c                     |  1 -
 fs/proc/fd.c                       |  1 -
 fs/proc/kcore.c                    |  1 -
 fs/proc/page.c                     |  6 ------
 fs/proc/task_mmu.c                 |  7 -------
 fs/quota/dquot.c                   |  1 -
 fs/reiserfs/journal.c              |  2 --
 fs/select.c                        |  1 -
 fs/smb/client/file.c               |  2 --
 fs/splice.c                        |  1 -
 fs/ubifs/budget.c                  |  1 -
 fs/ubifs/commit.c                  |  1 -
 fs/ubifs/debug.c                   |  5 -----
 fs/ubifs/dir.c                     |  1 -
 fs/ubifs/gc.c                      |  5 -----
 fs/ubifs/io.c                      |  2 --
 fs/ubifs/lprops.c                  |  2 --
 fs/ubifs/lpt_commit.c              |  3 ---
 fs/ubifs/orphan.c                  |  1 -
 fs/ubifs/recovery.c                |  4 ----
 fs/ubifs/replay.c                  |  7 -------
 fs/ubifs/scan.c                    |  2 --
 fs/ubifs/shrinker.c                |  1 -
 fs/ubifs/super.c                   |  2 --
 fs/ubifs/tnc_commit.c              |  2 --
 fs/ubifs/tnc_misc.c                |  1 -
 fs/userfaultfd.c                   |  9 ---------
 fs/verity/enable.c                 |  1 -
 fs/verity/read_metadata.c          |  1 -
 fs/xfs/scrub/common.h              |  7 -------
 fs/xfs/scrub/xfarray.c             |  7 -------
 fs/xfs/xfs_aops.c                  |  1 -
 fs/xfs/xfs_icache.c                |  2 --
 fs/xfs/xfs_iwalk.c                 |  1 -
 139 files changed, 54 insertions(+), 396 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1c45341719b..6b2bc1dad8e0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -568,7 +568,6 @@ static void afs_extend_writeback(struct address_space *mapping,
 		}
 
 		folio_batch_release(&fbatch);
-		cond_resched();
 	} while (!stop);
 
 	*_len = len;
@@ -790,7 +789,6 @@ static int afs_writepages_region(struct address_space *mapping,
 		}
 
 		folio_batch_release(&fbatch);
-		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
 	*_next = start;
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a4a809efc92f..2adaabd18b6e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -823,7 +823,6 @@ static int resolve_indirect_refs(struct btrfs_backref_walk_ctx *ctx,
 		prelim_ref_insert(ctx->fs_info, &preftrees->direct, ref, NULL);
 
 		ulist_reinit(parents);
-		cond_resched();
 	}
 out:
 	/*
@@ -879,7 +878,6 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
 			btrfs_tree_read_unlock(eb);
 		free_extent_buffer(eb);
 		prelim_ref_insert(fs_info, &preftrees->indirect, ref, NULL);
-		cond_resched();
 	}
 	return 0;
 }
@@ -1676,7 +1674,6 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 			 */
 			ref->inode_list = NULL;
 		}
-		cond_resched();
 	}
 
 out:
@@ -1784,7 +1781,6 @@ static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 		if (!node)
 			break;
 		ctx->bytenr = node->val;
-		cond_resched();
 	}
 
 	ulist_free(ctx->refs);
@@ -1993,7 +1989,6 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		}
 		shared.share_count = 0;
 		shared.have_delayed_delete_refs = false;
-		cond_resched();
 	}
 
 	/*
@@ -3424,7 +3419,6 @@ int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
 		struct btrfs_key key;
 		int type;
 
-		cond_resched();
 		eb = btrfs_backref_get_eb(iter);
 
 		key.objectid = iter->bytenr;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b2e5107b7cec..fe9f0a23dbb2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -769,7 +769,6 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 				btrfs_release_path(path);
 				up_read(&fs_info->commit_root_sem);
 				mutex_unlock(&caching_ctl->mutex);
-				cond_resched();
 				mutex_lock(&caching_ctl->mutex);
 				down_read(&fs_info->commit_root_sem);
 				goto next;
@@ -4066,8 +4065,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			wait_for_alloc = false;
 			spin_unlock(&space_info->lock);
 		}
-
-		cond_resched();
 	} while (wait_for_alloc);
 
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 617d4827eec2..09b70b271cd2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5052,7 +5052,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 				 */
 				free_extent_buffer(next);
 				btrfs_release_path(path);
-				cond_resched();
 				goto again;
 			}
 			if (!ret)
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f2ff4cbe8656..2219c3ccb863 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1326,7 +1326,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			ret = 0;
 			break;
 		}
-		cond_resched();
 	}
 
 	if (ra_allocated)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 68f60d50e1fd..e9d1cef7d030 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4561,7 +4561,6 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 		spin_unlock(&fs_info->ordered_root_lock);
 		btrfs_destroy_ordered_extents(root);
 
-		cond_resched();
 		spin_lock(&fs_info->ordered_root_lock);
 	}
 	spin_unlock(&fs_info->ordered_root_lock);
@@ -4643,7 +4642,6 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 		}
 		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
 		btrfs_put_delayed_ref_head(head);
-		cond_resched();
 		spin_lock(&delayed_refs->lock);
 	}
 	btrfs_qgroup_destroy_extent_records(trans);
@@ -4759,7 +4757,6 @@ static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		free_extent_state(cached_state);
 		btrfs_error_unpin_extent_range(fs_info, start, end);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-		cond_resched();
 	}
 }
 
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ff8e117a1ace..39aa803cbb13 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -695,8 +695,6 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (start > end)
 		goto out;
 	spin_unlock(&tree->lock);
-	if (gfpflags_allow_blocking(mask))
-		cond_resched();
 	goto again;
 
 out:
@@ -1189,8 +1187,6 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (start > end)
 		goto out;
 	spin_unlock(&tree->lock);
-	if (gfpflags_allow_blocking(mask))
-		cond_resched();
 	goto again;
 
 out:
@@ -1409,7 +1405,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (start > end)
 		goto out;
 	spin_unlock(&tree->lock);
-	cond_resched();
 	first_iteration = false;
 	goto again;
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc313fce5bbd..33be7bb96872 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1996,7 +1996,6 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_put_delayed_ref(ref);
-		cond_resched();
 
 		spin_lock(&locked_ref->lock);
 		btrfs_merge_delayed_refs(fs_info, delayed_refs, locked_ref);
@@ -2074,7 +2073,6 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		 */
 
 		locked_ref = NULL;
-		cond_resched();
 	} while ((nr != -1 && count < nr) || locked_ref);
 
 	return 0;
@@ -2183,7 +2181,6 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		mutex_unlock(&head->mutex);
 
 		btrfs_put_delayed_ref_head(head);
-		cond_resched();
 		goto again;
 	}
 out:
@@ -2805,7 +2802,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		unpin_extent_range(fs_info, start, end, true);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		free_extent_state(cached_state);
-		cond_resched();
 	}
 
 	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
@@ -4416,7 +4412,6 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			goto have_block_group;
 		}
 		release_block_group(block_group, ffe_ctl, ffe_ctl->delalloc);
-		cond_resched();
 	}
 	up_read(&space_info->groups_sem);
 
@@ -5037,7 +5032,6 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		if (nread >= wc->reada_count)
 			break;
 
-		cond_resched();
 		bytenr = btrfs_node_blockptr(eb, slot);
 		generation = btrfs_node_ptr_generation(eb, slot);
 
@@ -6039,8 +6033,6 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 			ret = -ERESTARTSYS;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	return ret;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index caccd0376342..209911d0e873 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
 					 page_ops, start, end);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
@@ -291,7 +290,6 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 			processed_end = page_offset(page) + PAGE_SIZE - 1;
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	return 0;
@@ -401,7 +399,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 			      &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
-		cond_resched();
 		goto again;
 	}
 	free_extent_state(cached_state);
@@ -1924,7 +1921,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	if (!scanned && !done) {
 		/*
@@ -2116,7 +2112,6 @@ static int extent_write_cache_pages(struct address_space *mapping,
 					    wbc->nr_to_write <= 0);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	if (!scanned && !done) {
 		/*
@@ -2397,8 +2392,6 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 
 			/* once for us */
 			free_extent_map(em);
-
-			cond_resched(); /* Allow large-extent preemption. */
 		}
 	}
 	return try_release_extent_state(tree, page, mask);
@@ -2698,7 +2691,6 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		last_delalloc_end = delalloc_end;
 		cur_offset = delalloc_end + 1;
 		extent_offset += cur_offset - delalloc_start;
-		cond_resched();
 	}
 
 	/*
@@ -2986,7 +2978,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			/* No more file extent items for this inode. */
 			break;
 		}
-		cond_resched();
 	}
 
 check_eof_delalloc:
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1ce5dd154499..12cc0cfde0ff 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1252,7 +1252,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	if (total_bytes < sums->len) {
 		btrfs_release_path(path);
-		cond_resched();
 		goto again;
 	}
 out:
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 361535c71c0f..541b6c87ddf3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1405,8 +1405,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
 
-		cond_resched();
-
 		pos += copied;
 		num_written += copied;
 	}
@@ -3376,7 +3374,6 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 		prev_delalloc_end = delalloc_end;
 		cur_offset = delalloc_end + 1;
-		cond_resched();
 	}
 
 	return ret;
@@ -3654,7 +3651,6 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 			ret = -EINTR;
 			goto out;
 		}
-		cond_resched();
 	}
 
 	/* We have an implicit hole from the last extent found up to i_size. */
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 27fad70451aa..c9606fcdc310 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3807,8 +3807,6 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 			ret = -ERESTARTSYS;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	return ret;
@@ -4000,8 +3998,6 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			ret = -ERESTARTSYS;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	if (offset >= end)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7814b9d654ce..789569e135cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1021,7 +1021,6 @@ static void compress_file_range(struct btrfs_work *work)
 			 nr_pages, compress_type);
 	if (start + total_in < end) {
 		start += total_in;
-		cond_resched();
 		goto again;
 	}
 	return;
@@ -3376,7 +3375,6 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 		run_delayed_iput_locked(fs_info, inode);
 		if (need_resched()) {
 			spin_unlock_irq(&fs_info->delayed_iput_lock);
-			cond_resched();
 			spin_lock_irq(&fs_info->delayed_iput_lock);
 		}
 	}
@@ -4423,7 +4421,6 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 			 * cache when its usage count hits zero.
 			 */
 			iput(inode);
-			cond_resched();
 			spin_lock(&root->inode_lock);
 			goto again;
 		}
@@ -5135,7 +5132,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
 				 &cached_state);
 
-		cond_resched();
 		spin_lock(&io_tree->lock);
 	}
 	spin_unlock(&io_tree->lock);
@@ -7209,8 +7205,6 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 		if (ret)
 			break;
-
-		cond_resched();
 	}
 
 	return ret;
@@ -9269,7 +9263,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
 		}
-		cond_resched();
 		spin_lock(&root->delalloc_lock);
 	}
 	spin_unlock(&root->delalloc_lock);
@@ -10065,7 +10058,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		btrfs_put_ordered_extent(ordered);
 		unlock_extent(io_tree, start, lockend, &cached_state);
-		cond_resched();
 	}
 
 	em = btrfs_get_extent(inode, NULL, 0, start, lockend - start + 1);
@@ -10306,7 +10298,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
 		unlock_extent(io_tree, start, end, &cached_state);
-		cond_resched();
 	}
 
 	/*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 345c449d588c..58463c479c91 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -715,7 +715,6 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		list_add_tail(&ordered->work_list, &works);
 		btrfs_queue_work(fs_info->flush_workers, &ordered->flush_work);
 
-		cond_resched();
 		spin_lock(&root->ordered_extent_lock);
 		if (nr != U64_MAX)
 			nr--;
@@ -729,7 +728,6 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		list_del_init(&ordered->work_list);
 		wait_for_completion(&ordered->completion);
 		btrfs_put_ordered_extent(ordered);
-		cond_resched();
 	}
 	mutex_unlock(&root->ordered_extent_mutex);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b99230db3c82..c483648be366 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1926,7 +1926,6 @@ int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
 	}
-	cond_resched();
 	return 0;
 }
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 65d2bd6910f2..6f599c275dc7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -569,8 +569,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			ret = -EINTR;
 			goto out;
 		}
-
-		cond_resched();
 	}
 	ret = 0;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c6d4bb8cbe29..7e16a6d953d9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1094,7 +1094,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	for (i = 0; i < nritems; i++) {
 		struct btrfs_ref ref = { 0 };
 
-		cond_resched();
 		btrfs_item_key_to_cpu(leaf, &key, i);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
@@ -1531,7 +1530,6 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 	while (1) {
 		struct extent_state *cached_state = NULL;
 
-		cond_resched();
 		iput(inode);
 
 		if (objectid > max_key->objectid)
@@ -2163,7 +2161,6 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 
 	next = node;
 	while (1) {
-		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
 
@@ -2286,7 +2283,6 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 
 	next = node;
 	while (1) {
-		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
 
@@ -2331,7 +2327,6 @@ u64 calcu_metadata_size(struct reloc_control *rc,
 	BUG_ON(reserve && node->processed);
 
 	while (next) {
-		cond_resched();
 		while (1) {
 			if (next->processed && (reserve || next != node))
 				break;
@@ -2426,8 +2421,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	list_for_each_entry(edge, &node->upper, list[LOWER]) {
 		struct btrfs_ref ref = { 0 };
 
-		cond_resched();
-
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
 		if (IS_ERR(root)) {
@@ -2609,7 +2602,6 @@ static void update_processed_blocks(struct reloc_control *rc,
 	int index = 0;
 
 	while (next) {
-		cond_resched();
 		while (1) {
 			if (next->processed)
 				break;
@@ -3508,7 +3500,6 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 	while (1) {
 		bool block_found;
 
-		cond_resched();
 		if (rc->search_start >= last) {
 			ret = 1;
 			break;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b877203f1dc5..4dba0e3b6887 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2046,9 +2046,6 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			break;
 
 		cur_logical = found_logical + BTRFS_STRIPE_LEN;
-
-		/* Don't hold CPU for too long time */
-		cond_resched();
 	}
 	return ret;
 }
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3a566150c531..503782af0b35 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7778,7 +7778,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		if (need_resched() ||
 		    rwsem_is_contended(&fs_info->commit_root_sem)) {
 			up_read(&fs_info->commit_root_sem);
-			cond_resched();
 			down_read(&fs_info->commit_root_sem);
 		}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..e597c5365c71 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1211,7 +1211,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
 		flush_space(fs_info, space_info, to_reclaim, flush, true);
-		cond_resched();
 		spin_lock(&space_info->lock);
 	}
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 1cc86af97dc6..7021025d8535 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -45,7 +45,6 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 				folio_put(folio);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 		loops++;
 		if (loops > 100000) {
 			printk(KERN_ERR
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c780d3729463..ce5cbc12e041 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1115,7 +1115,6 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 			werr = filemap_fdatawait_range(mapping, start, end);
 		free_extent_state(cached_state);
 		cached_state = NULL;
-		cond_resched();
 		start = end + 1;
 	}
 	return werr;
@@ -1157,7 +1156,6 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 			werr = err;
 		free_extent_state(cached_state);
 		cached_state = NULL;
-		cond_resched();
 		start = end + 1;
 	}
 	if (err)
@@ -1507,7 +1505,6 @@ int btrfs_defrag_root(struct btrfs_root *root)
 
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(info);
-		cond_resched();
 
 		if (btrfs_fs_closing(info) || ret != -EAGAIN)
 			break;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cbb17b542131..3c215762a07f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2657,11 +2657,9 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		path->nodes[*level-1] = next;
 		*level = btrfs_header_level(next);
 		path->slots[*level] = 0;
-		cond_resched();
 	}
 	path->slots[*level] = btrfs_header_nritems(path->nodes[*level]);
 
-	cond_resched();
 	return 0;
 }
 
@@ -3898,7 +3896,6 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		}
 		if (need_resched()) {
 			btrfs_release_path(path);
-			cond_resched();
 			goto search;
 		}
 	}
@@ -5037,7 +5034,6 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 		ins_nr++;
 		path->slots[0]++;
 		found_xattrs = true;
-		cond_resched();
 	}
 	if (ins_nr > 0) {
 		ret = copy_items(trans, inode, dst_path, path,
@@ -5135,7 +5131,6 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 
 		prev_extent_end = btrfs_file_extent_end(path);
 		path->slots[0]++;
-		cond_resched();
 	}
 
 	if (prev_extent_end < i_size) {
@@ -5919,13 +5914,6 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		} else {
 			break;
 		}
-
-		/*
-		 * We may process many leaves full of items for our inode, so
-		 * avoid monopolizing a cpu for too long by rescheduling while
-		 * not holding locks on any tree.
-		 */
-		cond_resched();
 	}
 	if (ins_nr) {
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 7c7001f42b14..98890e0d7b24 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -324,7 +324,6 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 			ret = -EINTR;
 			goto out;
 		}
-		cond_resched();
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b9ef6f54635c..ceda63fcc721 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1689,7 +1689,6 @@ static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 			search_start = extent_end;
 next:
 		path->slots[0]++;
-		cond_resched();
 	}
 
 	/*
@@ -4756,7 +4755,6 @@ int btrfs_uuid_scan_kthread(void *data)
 		} else {
 			break;
 		}
-		cond_resched();
 	}
 
 out:
diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71c693d..a362b42bc63d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1743,7 +1743,6 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 		/* End of range already reached? */
 		if (index > end || !index)
 			break;
diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 7077f72e6f47..7f078244cc0a 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -299,9 +299,7 @@ static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
 		fscache_withdraw_cookie(object->cookie);
 		count++;
 		if ((count & 63) == 0) {
-			spin_unlock(&cache->object_list_lock);
-			cond_resched();
-			spin_lock(&cache->object_list_lock);
+			cond_resched_lock(&cache->object_list_lock);
 		}
 	}
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7bf7a5fcc045..3fa8a2ecb299 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -353,7 +353,6 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		unlock_rename(cache->graveyard, dir);
 		dput(grave);
 		grave = NULL;
-		cond_resched();
 		goto try_again;
 	}
 
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 89df0ba8ba5e..6a4d9d87c68c 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -62,7 +62,6 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 			cachefiles_bury_object(cache, NULL, cache->store, vdentry,
 					       FSCACHE_VOLUME_IS_WEIRD);
 			cachefiles_put_directory(volume->dentry);
-			cond_resched();
 			goto retry;
 		}
 	}
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f4863078f7fe..f2be2adf5d41 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1375,7 +1375,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 					wait_on_page_writeback(page);
 				}
 				folio_batch_release(&fbatch);
-				cond_resched();
 			}
 		}
 
diff --git a/fs/dax.c b/fs/dax.c
index 93cf6e8d8990..f68e026e6ec4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -986,7 +986,6 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
 		pfn_mkclean_range(pfn, count, index, vma);
-		cond_resched();
 	}
 	i_mmap_unlock_read(mapping);
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 25ac74d30bff..3f5b4adba111 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -619,7 +619,6 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
@@ -1629,7 +1628,6 @@ void shrink_dcache_parent(struct dentry *parent)
 			continue;
 		}
 
-		cond_resched();
 		if (!data.found)
 			break;
 		data.victim = NULL;
diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 1f2f70a1b824..d6f36527814f 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -261,7 +261,6 @@ void dlm_callback_resume(struct dlm_ls *ls)
 	sum += count;
 	if (!empty) {
 		count = 0;
-		cond_resched();
 		goto more;
 	}
 
diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index f6acba4310a7..d8b24f9bb744 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -94,8 +94,6 @@ int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
 			if (error)
 				goto out_free;
 
-			cond_resched();
-
 			/*
 			 * pick namelen/name pairs out of received buffer
 			 */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 652c51fbbf76..6bf02cbc5550 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1713,7 +1713,6 @@ void dlm_scan_rsbs(struct dlm_ls *ls)
 		shrink_bucket(ls, i);
 		if (dlm_locking_stopped(ls))
 			break;
-		cond_resched();
 	}
 }
 
@@ -5227,7 +5226,6 @@ void dlm_recover_purge(struct dlm_ls *ls)
 		}
 		unlock_rsb(r);
 		unhold_rsb(r);
-		cond_resched();
 	}
 	up_write(&ls->ls_root_sem);
 
@@ -5302,7 +5300,6 @@ void dlm_recover_grant(struct dlm_ls *ls)
 		confirm_master(r, 0);
 		unlock_rsb(r);
 		put_rsb(r);
-		cond_resched();
 	}
 
 	if (lkb_count)
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index f7bc22e74db2..494ede3678d6 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -562,7 +562,6 @@ int dlm_lowcomms_connect_node(int nodeid)
 	up_read(&con->sock_lock);
 	srcu_read_unlock(&connections_srcu, idx);
 
-	cond_resched();
 	return 0;
 }
 
@@ -1504,7 +1503,6 @@ static void process_recv_sockets(struct work_struct *work)
 		/* CF_RECV_PENDING cleared */
 		break;
 	case DLM_IO_RESCHED:
-		cond_resched();
 		queue_work(io_workqueue, &con->rwork);
 		/* CF_RECV_PENDING not cleared */
 		break;
@@ -1650,7 +1648,6 @@ static void process_send_sockets(struct work_struct *work)
 		break;
 	case DLM_IO_RESCHED:
 		/* CF_SEND_PENDING not cleared */
-		cond_resched();
 		queue_work(io_workqueue, &con->swork);
 		break;
 	default:
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 53917c0aa3c0..6d9b074631ff 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -545,7 +545,6 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 		else
 			error = recover_master(r, &count, seq);
 		unlock_rsb(r);
-		cond_resched();
 		total++;
 
 		if (error) {
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index b9575957a7c2..3409677acfae 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -41,7 +41,6 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		iput(toput_inode);
 		toput_inode = inode;
 
-		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..f32ff29392d1 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -93,7 +93,6 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 		} else if (!erofs_workgroup_get(pre)) {
 			/* try to legitimize the current in-tree one */
 			xa_unlock(&sbi->managed_pslots);
-			cond_resched();
 			goto repeat;
 		}
 		lockref_put_return(&grp->lockref);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 036f610e044b..20ae6af8a9d6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -697,8 +697,13 @@ static void z_erofs_cache_invalidate_folio(struct folio *folio,
 	DBG_BUGON(stop > folio_size(folio) || stop < length);
 
 	if (offset == 0 && stop == folio_size(folio))
+		/*
+		 * We are in a seemingly tight loop here. Though, if needed,
+		 * preemption can happen in z_erofs_cache_release_folio()
+		 * via the spin_unlock() call.
+		 */
 		while (!z_erofs_cache_release_folio(folio, GFP_NOFS))
-			cond_resched();
+			;
 }
 
 static const struct address_space_operations z_erofs_cache_aops = {
@@ -1527,7 +1532,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (oldpage != cmpxchg(&pcl->compressed_bvecs[nr].page,
 			       oldpage, page)) {
 		erofs_pagepool_add(pagepool, page);
-		cond_resched();
 		goto repeat;
 	}
 out_tocache:
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1d9a71a0c4c1..45794a9da768 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -801,7 +801,6 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		epi = rb_entry(rbp, struct epitem, rbn);
 
 		ep_unregister_pollwait(ep, epi);
-		cond_resched();
 	}
 
 	/*
@@ -816,7 +815,6 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);
 		ep_remove_safe(ep, epi);
-		cond_resched();
 	}
 
 	dispose = ep_refcount_dec_and_test(ep);
@@ -1039,7 +1037,6 @@ static struct epitem *ep_find_tfd(struct eventpoll *ep, int tfd, unsigned long t
 			else
 				toff--;
 		}
-		cond_resched();
 	}
 
 	return NULL;
diff --git a/fs/exec.c b/fs/exec.c
index 6518e33ea813..ca3b25054e3f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -451,7 +451,6 @@ static int count(struct user_arg_ptr argv, int max)
 
 			if (fatal_signal_pending(current))
 				return -ERESTARTNOHAND;
-			cond_resched();
 		}
 	}
 	return i;
@@ -469,7 +468,6 @@ static int count_strings_kernel(const char *const *argv)
 			return -E2BIG;
 		if (fatal_signal_pending(current))
 			return -ERESTARTNOHAND;
-		cond_resched();
 	}
 	return i;
 }
@@ -562,7 +560,6 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 				ret = -ERESTARTNOHAND;
 				goto out;
 			}
-			cond_resched();
 
 			offset = pos % PAGE_SIZE;
 			if (offset == 0)
@@ -661,7 +658,6 @@ static int copy_strings_kernel(int argc, const char *const *argv,
 			return ret;
 		if (fatal_signal_pending(current))
 			return -ERESTARTNOHAND;
-		cond_resched();
 	}
 	return 0;
 }
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b565..1a7baca041cf 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -162,7 +162,6 @@ static int ext4_protect_reserved_inode(struct super_block *sb,
 		return PTR_ERR(inode);
 	num = (inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
 	while (i < num) {
-		cond_resched();
 		map.m_lblk = i;
 		map.m_len = num - i;
 		n = ext4_map_blocks(NULL, inode, &map, 0);
@@ -224,7 +223,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	for (i=0; i < ngroups; i++) {
 		unsigned int meta_blks = ext4_num_base_meta_blocks(sb, i);
 
-		cond_resched();
 		if (meta_blks != 0) {
 			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..cb7d2427be8b 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -174,7 +174,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			err = -ERESTARTSYS;
 			goto errout;
 		}
-		cond_resched();
 		offset = ctx->pos & (sb->s_blocksize - 1);
 		map.m_lblk = ctx->pos >> EXT4_BLOCK_SIZE_BITS(sb);
 		map.m_len = 1;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..79851e582c7d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3001,7 +3001,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			}
 			/* Yield here to deal with large extent trees.
 			 * Should be a no-op if we did IO above. */
-			cond_resched();
 			if (WARN_ON(i + 1 > depth)) {
 				err = -EFSCORRUPTED;
 				break;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b65058d972f9..25d78953eec9 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1482,7 +1482,6 @@ unsigned long ext4_count_free_inodes(struct super_block *sb)
 		if (!gdp)
 			continue;
 		desc_count += ext4_free_inodes_count(sb, gdp);
-		cond_resched();
 	}
 	return desc_count;
 #endif
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1c8b0a..1c3af3a8fe2e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2491,7 +2491,6 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			}
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	mpd->scanned_until_end = 1;
 	if (handle)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e599305d85f..074b5cdea363 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2843,7 +2843,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
 			int ret = 0;
 
-			cond_resched();
 			if (new_cr != cr) {
 				cr = new_cr;
 				goto repeat;
@@ -3387,7 +3386,6 @@ static int ext4_mb_init_backend(struct super_block *sb)
 	sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
 	EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
 	for (i = 0; i < ngroups; i++) {
-		cond_resched();
 		desc = ext4_get_group_desc(sb, i, NULL);
 		if (desc == NULL) {
 			ext4_msg(sb, KERN_ERR, "can't read descriptor %u", i);
@@ -3746,7 +3744,6 @@ int ext4_mb_release(struct super_block *sb)
 
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
-			cond_resched();
 			grinfo = ext4_get_group_info(sb, i);
 			if (!grinfo)
 				continue;
@@ -6034,7 +6031,6 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 		ret = ext4_mb_discard_group_preallocations(sb, i, &busy);
 		freed += ret;
 		needed -= ret;
-		cond_resched();
 	}
 
 	if (needed > 0 && busy && ++retry < 3) {
@@ -6173,8 +6169,6 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		while (ar->len &&
 			ext4_claim_free_clusters(sbi, ar->len, ar->flags)) {
 
-			/* let others to free the space */
-			cond_resched();
 			ar->len = ar->len >> 1;
 		}
 		if (!ar->len) {
@@ -6720,7 +6714,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		int is_metadata = flags & EXT4_FREE_BLOCKS_METADATA;
 
 		for (i = 0; i < count; i++) {
-			cond_resched();
 			if (is_metadata)
 				bh = sb_find_get_block(inode->i_sb, block + i);
 			ext4_forget(handle, is_metadata, inode, bh, block + i);
@@ -6959,8 +6952,11 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			return count;
 
 		if (need_resched()) {
+			/*
+			 * Rescheduling can implicitly happen after the
+			 * unlock.
+			 */
 			ext4_unlock_group(sb, e4b->bd_group);
-			cond_resched();
 			ext4_lock_group(sb, e4b->bd_group);
 		}
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bbda587f76b8..2ab27008c4dd 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1255,7 +1255,6 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 			err = -ERESTARTSYS;
 			goto errout;
 		}
-		cond_resched();
 		block = dx_get_block(frame->at);
 		ret = htree_dirblock_to_tree(dir_file, dir, block, &hinfo,
 					     start_hash, start_minor_hash);
@@ -1341,7 +1340,6 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
 								blocksize);
 			count++;
-			cond_resched();
 		}
 		de = ext4_next_entry(de, blocksize);
 	}
@@ -1658,7 +1656,6 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		/*
 		 * We deal with the read-ahead logic here.
 		 */
-		cond_resched();
 		if (ra_ptr >= ra_max) {
 			/* Refill the readahead buffer */
 			ra_ptr = 0;
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..fb04e8bccd3c 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -67,7 +67,6 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
 				atomic_inc(&oi->of_binfo[i].ob_free_entries);
 				return -ENOSPC;
 			}
-			cond_resched();
 		}
 		while (bdata[j]) {
 			if (++j >= inodes_per_ob) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dbebd8b3127e..170c75323300 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3861,7 +3861,6 @@ static int ext4_lazyinit_thread(void *arg)
 		cur = jiffies;
 		if ((time_after_eq(cur, next_wakeup)) ||
 		    (MAX_JIFFY_OFFSET == next_wakeup)) {
-			cond_resched();
 			continue;
 		}
 
@@ -4226,7 +4225,6 @@ int ext4_calculate_overhead(struct super_block *sb)
 		overhead += blks;
 		if (blks)
 			memset(buf, 0, PAGE_SIZE);
-		cond_resched();
 	}
 
 	/*
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b0597a539fc5..20ea41b5814c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -45,7 +45,6 @@ struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 repeat:
 	page = f2fs_grab_cache_page(mapping, index, false);
 	if (!page) {
-		cond_resched();
 		goto repeat;
 	}
 	f2fs_wait_on_page_writeback(page, META, true, true);
@@ -76,7 +75,6 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 repeat:
 	page = f2fs_grab_cache_page(mapping, index, false);
 	if (!page) {
-		cond_resched();
 		goto repeat;
 	}
 	if (PageUptodate(page))
@@ -463,7 +461,6 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				break;
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 stop:
 	if (nwritten)
@@ -1111,9 +1108,13 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 			F2FS_I(inode)->cp_task = NULL;
 
 		iput(inode);
-		/* We need to give cpu to another writers. */
+		/*
+		 * We need to give cpu to other writers but cond_resched_stall()
+		 * does not guarantee that. Perhaps we should explicitly wait on
+		 * an event or a timeout?
+		 */
 		if (ino == cur_ino)
-			cond_resched();
+			cond_resched_stall();
 		else
 			ino = cur_ino;
 	} else {
@@ -1122,7 +1123,6 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 		 * writebacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_merged_write(sbi, DATA);
-		cond_resched();
 	}
 	goto retry;
 }
@@ -1229,7 +1229,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		f2fs_quota_sync(sbi->sb, -1);
 		if (locked)
 			up_read(&sbi->sb->s_umount);
-		cond_resched();
 		goto retry_flush_quotas;
 	}
 
@@ -1240,7 +1239,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE, true);
 		if (err)
 			return err;
-		cond_resched();
 		goto retry_flush_quotas;
 	}
 
@@ -1256,7 +1254,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		err = f2fs_sync_inode_meta(sbi);
 		if (err)
 			return err;
-		cond_resched();
 		goto retry_flush_quotas;
 	}
 
@@ -1273,7 +1270,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 			f2fs_unlock_all(sbi);
 			return err;
 		}
-		cond_resched();
 		goto retry_flush_nodes;
 	}
 
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d820801f473e..39a2a974e087 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1941,7 +1941,6 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	} while (index < end);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 916e317ac925..dfde82cab326 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2105,7 +2105,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 prep_next:
-	cond_resched();
 	if (fatal_signal_pending(current))
 		ret = -EINTR;
 	else
@@ -3250,7 +3249,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				goto readd;
 		}
 		release_pages(pages, nr_pages);
-		cond_resched();
 	}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* flush remained pages in compress cluster */
@@ -3981,7 +3979,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
 retry:
-		cond_resched();
 
 		memset(&map, 0, sizeof(map));
 		map.m_lblk = cur_lblock;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8aa29fe2e87b..fc15a05fa807 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1090,7 +1090,6 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			err = -ERESTARTSYS;
 			goto out_free;
 		}
-		cond_resched();
 
 		/* readahead for multi pages of dir */
 		if (npages - n > 1 && !ra_has_index(ra, n))
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0e2d49140c07..b87946f33a5f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -936,7 +936,6 @@ static unsigned int __shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
 
 		if (node_cnt + tree_cnt >= nr_shrink)
 			goto unlock_out;
-		cond_resched();
 	}
 	mutex_unlock(&eti->extent_tree_lock);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c..073e6fd1986d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2849,8 +2849,12 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 				unsigned long index, void *item)
 {
+	/*
+	 * Insert in a tight loop. The scheduler will
+	 * preempt when necessary.
+	 */
 	while (radix_tree_insert(root, index, item))
-		cond_resched();
+		;
 }
 
 #define RAW_IS_INODE(p)	((p)->footer.nid == (p)->footer.ino)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..0ac3dc5dafee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3922,7 +3922,6 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 			ret = -EINTR;
 			goto out;
 		}
-		cond_resched();
 	}
 
 	if (len)
@@ -4110,7 +4109,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		count -= cluster_size;
 		page_idx += cluster_size;
 
-		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
@@ -4188,7 +4186,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		count -= cluster_size;
 		page_idx += cluster_size;
 
-		cond_resched();
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ee2e1dd64f25..8187b6ad119a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1579,7 +1579,6 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			unlock_page(page);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	return last_page;
 }
@@ -1841,7 +1840,6 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			}
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 
 		if (ret || marked)
 			break;
@@ -1944,7 +1942,6 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			unlock_page(page);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
@@ -2046,7 +2043,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				break;
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
 			step = 2;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..09667bd8ecf7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2705,7 +2705,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		towrite -= tocopy;
 		off += tocopy;
 		data += tocopy;
-		cond_resched();
 	}
 
 	if (len == towrite)
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 1db348f8f887..96d9f1632f2a 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -741,7 +741,6 @@ int fat_count_free_clusters(struct super_block *sb)
 			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
 				free++;
 		} while (fat_ent_next(sbi, &fatent));
-		cond_resched();
 	}
 	sbi->free_clusters = free;
 	sbi->free_clus_valid = 1;
@@ -822,7 +821,6 @@ int fat_trim_fs(struct inode *inode, struct fstrim_range *range)
 		if (need_resched()) {
 			fatent_brelse(&fatent);
 			unlock_fat(sbi);
-			cond_resched();
 			lock_fat(sbi);
 		}
 	}
diff --git a/fs/file.c b/fs/file.c
index 3e4a4dfa38fc..8ae2cec580a9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -428,10 +428,8 @@ static struct fdtable *close_files(struct files_struct * files)
 		while (set) {
 			if (set & 1) {
 				struct file * file = xchg(&fdt->fd[i], NULL);
-				if (file) {
+				if (file)
 					filp_close(file, files);
-					cond_resched();
-				}
 			}
 			i++;
 			set >>= 1;
@@ -708,11 +706,9 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 		if (file) {
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
-			cond_resched();
 			spin_lock(&files->file_lock);
 		} else if (need_resched()) {
 			spin_unlock(&files->file_lock);
-			cond_resched();
 			spin_lock(&files->file_lock);
 		}
 	}
@@ -845,7 +841,6 @@ void do_close_on_exec(struct files_struct *files)
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
-			cond_resched();
 			spin_lock(&files->file_lock);
 		}
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c1af01b2c42d..bf311aeb058b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1914,7 +1914,6 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * give up the CPU.
 			 */
 			blk_flush_plug(current->plug, false);
-			cond_resched();
 		}
 
 		/*
@@ -2621,8 +2620,6 @@ static void wait_sb_inodes(struct super_block *sb)
 		 */
 		filemap_fdatawait_keep_errors(mapping);
 
-		cond_resched();
-
 		iput(inode);
 
 		rcu_read_lock();
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index c26d48355cc2..4d5bc99b6301 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -357,7 +357,6 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 		if (ret > 0)
 			ret = 0;
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	if (!cycled && !done) {
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..2eb057461023 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1592,7 +1592,6 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			buf_in_tr = false;
 		}
 		gfs2_glock_dq_uninit(rd_gh);
-		cond_resched();
 		goto more_rgrps;
 	}
 out:
@@ -1962,7 +1961,6 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	if (current->journal_info) {
 		up_write(&ip->i_rw_mutex);
 		gfs2_trans_end(sdp);
-		cond_resched();
 	}
 	gfs2_quota_unhold(ip);
 out_metapath:
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a6..a1eca3d9857c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2073,7 +2073,7 @@ static void glock_hash_walk(glock_examiner examiner, const struct gfs2_sbd *sdp)
 		}
 
 		rhashtable_walk_stop(&iter);
-	} while (cond_resched(), gl == ERR_PTR(-EAGAIN));
+	} while (gl == ERR_PTR(-EAGAIN));
 
 	rhashtable_walk_exit(&iter);
 }
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e5271ae87d1c..7567a29eeb21 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -143,7 +143,6 @@ __acquires(&sdp->sd_ail_lock)
 		ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
 		if (need_resched()) {
 			blk_finish_plug(plug);
-			cond_resched();
 			blk_start_plug(plug);
 		}
 		spin_lock(&sdp->sd_ail_lock);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e93..8ae07f0871b1 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1774,7 +1774,6 @@ static void gfs2_evict_inodes(struct super_block *sb)
 		iput(toput_inode);
 		toput_inode = inode;
 
-		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/hpfs/buffer.c b/fs/hpfs/buffer.c
index d39246865c51..88459fea4548 100644
--- a/fs/hpfs/buffer.c
+++ b/fs/hpfs/buffer.c
@@ -77,8 +77,6 @@ void *hpfs_map_sector(struct super_block *s, unsigned secno, struct buffer_head
 
 	hpfs_prefetch_sectors(s, secno, ahead);
 
-	cond_resched();
-
 	*bhp = bh = sb_bread(s, hpfs_search_hotfix_map(s, secno));
 	if (bh != NULL)
 		return bh->b_data;
@@ -97,8 +95,6 @@ void *hpfs_get_sector(struct super_block *s, unsigned secno, struct buffer_head
 
 	hpfs_lock_assert(s);
 
-	cond_resched();
-
 	if ((*bhp = bh = sb_getblk(s, hpfs_search_hotfix_map(s, secno))) != NULL) {
 		if (!buffer_uptodate(bh)) wait_on_buffer(bh);
 		set_buffer_uptodate(bh);
@@ -118,8 +114,6 @@ void *hpfs_map_4sectors(struct super_block *s, unsigned secno, struct quad_buffe
 
 	hpfs_lock_assert(s);
 
-	cond_resched();
-
 	if (secno & 3) {
 		pr_err("%s(): unaligned read\n", __func__);
 		return NULL;
@@ -168,8 +162,6 @@ void *hpfs_map_4sectors(struct super_block *s, unsigned secno, struct quad_buffe
 void *hpfs_get_4sectors(struct super_block *s, unsigned secno,
                           struct quad_buffer_head *qbh)
 {
-	cond_resched();
-
 	hpfs_lock_assert(s);
 
 	if (secno & 3) {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..21da053bdaaa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -689,7 +689,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	if (truncate_op)
@@ -867,8 +866,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		struct folio *folio;
 		unsigned long addr;
 
-		cond_resched();
-
 		/*
 		 * fallocate(2) manpage permits EINTR; we may have been
 		 * interrupted because we are using up too much memory.
diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..f2898988bf40 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -695,7 +695,6 @@ static void dispose_list(struct list_head *head)
 		list_del_init(&inode->i_lru);
 
 		evict(inode);
-		cond_resched();
 	}
 }
 
@@ -737,7 +736,6 @@ void evict_inodes(struct super_block *sb)
 		 */
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
@@ -778,7 +776,6 @@ void invalidate_inodes(struct super_block *sb)
 		list_add(&inode->i_lru, &dispose);
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2bc0aa23fde3..a76faf26b06e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -927,7 +927,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (unlikely(copied != status))
 			iov_iter_revert(i, copied - status);
 
-		cond_resched();
 		if (unlikely(status == 0)) {
 			/*
 			 * A short copy made iomap_write_end() reject the
@@ -1296,8 +1295,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
-		cond_resched();
-
 		pos += bytes;
 		written += bytes;
 		length -= bytes;
@@ -1533,10 +1530,8 @@ iomap_finish_ioends(struct iomap_ioend *ioend, int error)
 	completions = iomap_finish_ioend(ioend, error);
 
 	while (!list_empty(&tmp)) {
-		if (completions > IOEND_BATCH_SIZE * 8) {
-			cond_resched();
+		if (completions > IOEND_BATCH_SIZE * 8)
 			completions = 0;
-		}
 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
 		list_del_init(&ioend->io_list);
 		completions += iomap_finish_ioend(ioend, error);
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 118699fff2f9..1f3c0813d0be 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -457,7 +457,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	}
 
 	spin_unlock(&journal->j_list_lock);
-	cond_resched();
 
 	if (*nr_to_scan && next_tid)
 		goto again;
@@ -529,7 +528,6 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 		}
 		__jbd2_journal_clean_checkpoint_list(journal, true);
 		spin_unlock(&journal->j_list_lock);
-		cond_resched();
 	}
 }
 
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8d6f934c3d95..db7052ee0c62 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -729,7 +729,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				bh->b_end_io = journal_end_buffer_io_sync;
 				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
 			}
-			cond_resched();
 
 			/* Force a new descriptor to be generated next
                            time round the loop. */
@@ -811,7 +810,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 						    b_assoc_buffers);
 
 		wait_on_buffer(bh);
-		cond_resched();
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;
@@ -854,7 +852,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 		bh = list_entry(log_bufs.prev, struct buffer_head, b_assoc_buffers);
 		wait_on_buffer(bh);
-		cond_resched();
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index c269a7d29a46..fbc419d36cd0 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -509,8 +509,6 @@ static int do_one_pass(journal_t *journal,
 		struct buffer_head *	obh;
 		struct buffer_head *	nbh;
 
-		cond_resched();
-
 		/* If we already know where to stop the log traversal,
 		 * check right now that we haven't gone past the end of
 		 * the log. */
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index 6ae9d6fefb86..4f9539211306 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -121,10 +121,8 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 	c->flags |= JFFS2_SB_FLAG_BUILDING;
 	/* Now scan the directory tree, increasing nlink according to every dirent found. */
 	for_each_inode(i, c, ic) {
-		if (ic->scan_dents) {
+		if (ic->scan_dents)
 			jffs2_build_inode_pass1(c, ic, &dir_hardlinks);
-			cond_resched();
-		}
 	}
 
 	dbg_fsbuild("pass 1 complete\n");
@@ -141,7 +139,6 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 			continue;
 
 		jffs2_build_remove_unlinked_inode(c, ic, &dead_fds);
-		cond_resched();
 	}
 
 	dbg_fsbuild("pass 2a starting\n");
@@ -209,7 +206,6 @@ static int jffs2_build_filesystem(struct jffs2_sb_info *c)
 			jffs2_free_full_dirent(fd);
 		}
 		ic->scan_dents = NULL;
-		cond_resched();
 	}
 	ret = jffs2_build_xattr_subsystem(c);
 	if (ret)
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index acd32f05b519..a2706246a68e 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -143,8 +143,6 @@ int jffs2_erase_pending_blocks(struct jffs2_sb_info *c, int count)
 			BUG();
 		}
 
-		/* Be nice */
-		cond_resched();
 		mutex_lock(&c->erase_free_sem);
 		spin_lock(&c->erase_completion_lock);
 	}
@@ -387,7 +385,6 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
 			}
 		}
 		ofs += readlen;
-		cond_resched();
 	}
 	ret = 0;
 fail:
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 5c6602f3c189..3ba9054ac63c 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -923,8 +923,6 @@ static int jffs2_garbage_collect_deletion_dirent(struct jffs2_sb_info *c, struct
 
 		for (raw = f->inocache->nodes; raw != (void *)f->inocache; raw = raw->next_in_ino) {
 
-			cond_resched();
-
 			/* We only care about obsolete ones */
 			if (!(ref_obsolete(raw)))
 				continue;
diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c6..7a56a5fb1637 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -578,7 +578,6 @@ void jffs2_kill_fragtree(struct rb_root *root, struct jffs2_sb_info *c)
 		}
 
 		jffs2_free_node_frag(frag);
-		cond_resched();
 	}
 }
 
diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index a7bbe879cfc3..5f9ab75540f4 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -185,8 +185,6 @@ int jffs2_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
 			} else if (ret)
 				return ret;
 
-			cond_resched();
-
 			if (signal_pending(current))
 				return -EINTR;
 
@@ -227,7 +225,14 @@ int jffs2_reserve_space_gc(struct jffs2_sb_info *c, uint32_t minsize,
 		spin_unlock(&c->erase_completion_lock);
 
 		if (ret == -EAGAIN)
-			cond_resched();
+			/*
+			 * The spin_unlock() above will implicitly reschedule
+			 * if one is needed.
+			 *
+			 * In case we did not reschedule, take a breather here
+			 * before retrying.
+			 */
+			cpu_relax();
 		else
 			break;
 	}
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 03b4f99614be..f9fc1f6451f8 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -1013,8 +1013,6 @@ static int jffs2_get_inode_nodes(struct jffs2_sb_info *c, struct jffs2_inode_inf
 		valid_ref = jffs2_first_valid_node(ref->next_in_ino);
 		spin_unlock(&c->erase_completion_lock);
 
-		cond_resched();
-
 		/*
 		 * At this point we don't know the type of the node we're going
 		 * to read, so we do not know the size of its header. In order
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 29671e33a171..aaf6b33ba200 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -143,8 +143,6 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	for (i=0; i<c->nr_blocks; i++) {
 		struct jffs2_eraseblock *jeb = &c->blocks[i];
 
-		cond_resched();
-
 		/* reset summary info for next eraseblock scan */
 		jffs2_sum_reset_collected(s);
 
@@ -621,8 +619,6 @@ static int jffs2_scan_eraseblock (struct jffs2_sb_info *c, struct jffs2_eraseblo
 		if (err)
 			return err;
 
-		cond_resched();
-
 		if (ofs & 3) {
 			pr_warn("Eep. ofs 0x%08x not word-aligned!\n", ofs);
 			ofs = PAD(ofs);
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 4fe64519870f..5a4a6438a966 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -397,8 +397,6 @@ static int jffs2_sum_process_sum_data(struct jffs2_sb_info *c, struct jffs2_eras
 	for (i=0; i<je32_to_cpu(summary->sum_num); i++) {
 		dbg_summary("processing summary index %d\n", i);
 
-		cond_resched();
-
 		/* Make sure there's a spare ref for dirty space */
 		err = jffs2_prealloc_raw_node_refs(c, jeb, 2);
 		if (err)
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index ce4b4760fcb1..d30011f3e935 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2833,12 +2833,11 @@ void txQuiesce(struct super_block *sb)
 		mutex_lock(&jfs_ip->commit_mutex);
 		txCommit(tid, 1, &ip, 0);
 		txEnd(tid);
+		/*
+		 * The mutex_unlock() reschedules if needed.
+		 */
 		mutex_unlock(&jfs_ip->commit_mutex);
-		/*
-		 * Just to be safe.  I don't know how
-		 * long we can run without blocking
-		 */
-		cond_resched();
+
 		TXN_LOCK();
 	}
 
@@ -2912,11 +2911,6 @@ int jfs_sync(void *arg)
 				mutex_unlock(&jfs_ip->commit_mutex);
 
 				iput(ip);
-				/*
-				 * Just to be safe.  I don't know how
-				 * long we can run without blocking
-				 */
-				cond_resched();
 				TXN_LOCK();
 			} else {
 				/* We can't get the commit mutex.  It may
diff --git a/fs/libfs.c b/fs/libfs.c
index 37f2d34ee090..c74cecca8557 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -125,9 +125,8 @@ static struct dentry *scan_positives(struct dentry *cursor,
 		if (need_resched()) {
 			list_move(&cursor->d_child, p);
 			p = &cursor->d_child;
-			spin_unlock(&dentry->d_lock);
-			cond_resched();
-			spin_lock(&dentry->d_lock);
+
+			cond_resched_lock(&dentry->d_lock);
 		}
 	}
 	spin_unlock(&dentry->d_lock);
diff --git a/fs/mbcache.c b/fs/mbcache.c
index 2a4b8b549e93..451d554d3f55 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -322,7 +322,6 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 		spin_unlock(&cache->c_list_lock);
 		__mb_cache_entry_free(cache, entry);
 		shrunk++;
-		cond_resched();
 		spin_lock(&cache->c_list_lock);
 	}
 	spin_unlock(&cache->c_list_lock);
diff --git a/fs/namei.c b/fs/namei.c
index 94565bd7e73f..e911d7f15dad 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1781,7 +1781,6 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 
 	if (!(nd->flags & LOOKUP_RCU)) {
 		touch_atime(&last->link);
-		cond_resched();
 	} else if (atime_needs_update(&last->link, inode)) {
 		if (!try_to_unlazy(nd))
 			return ERR_PTR(-ECHILD);
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 7f753380e047..fe9487237b5d 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -641,7 +641,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 			netfs_rreq_assess(rreq, false);
 			if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 				break;
-			cond_resched();
 		}
 
 		ret = rreq->error;
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index cf7365581031..6b5b060b3658 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -650,7 +650,6 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 
 		err = nfs_end_delegation_return(inode, delegation, 0);
 		iput(inode);
-		cond_resched();
 		if (!err)
 			goto restart;
 		set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
@@ -1186,7 +1185,6 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 			nfs_put_delegation(delegation);
 		}
 		iput(inode);
-		cond_resched();
 		goto restart;
 	}
 	rcu_read_unlock();
@@ -1318,7 +1316,6 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 		put_cred(cred);
 		if (!nfs4_server_rebooted(server->nfs_client)) {
 			iput(inode);
-			cond_resched();
 			goto restart;
 		}
 		nfs_inode_mark_test_expired_delegation(server,inode);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 84343aefbbd6..10db43e1833a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2665,14 +2665,12 @@ static int pnfs_layout_return_unused_byserver(struct nfs_server *server,
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			pnfs_put_layout_hdr(lo);
-			cond_resched();
 			goto restart;
 		}
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 		pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
 		pnfs_put_layout_hdr(lo);
-		cond_resched();
 		goto restart;
 	}
 	rcu_read_unlock();
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 9d82d50ce0b1..eec3d641998b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1053,7 +1053,6 @@ nfs_scan_commit_list(struct list_head *src, struct list_head *dst,
 		ret++;
 		if ((ret == max) && !cinfo->dreq)
 			break;
-		cond_resched();
 	}
 	return ret;
 }
@@ -1890,8 +1889,6 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
 		nfs_unlock_and_release_request(req);
-		/* Latency breaker */
-		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
@@ -1958,7 +1955,6 @@ static int __nfs_commit_inode(struct inode *inode, int how,
 		}
 		if (nscan < INT_MAX)
 			break;
-		cond_resched();
 	}
 	nfs_commit_end(cinfo.mds);
 	if (ret || !may_wait)
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 13592e82eaf6..4ed6d5d23ade 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2173,7 +2173,6 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 			} while ((bh = bh->b_this_page) != head);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	for (level = NILFS_BTREE_LEVEL_NODE_MIN;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 1a8bd5993476..a5780f54ac6d 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1280,7 +1280,6 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			}
 			blkoff += n;
 		}
-		cond_resched();
 	} while (true);
 
 	/* If ret is 1 then we just hit the end of the extent array */
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index b4e54d079b7d..71c5b6792e5f 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -277,7 +277,6 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 		folio_unlock(folio);
 	}
 	folio_batch_release(&fbatch);
-	cond_resched();
 
 	if (likely(!err))
 		goto repeat;
@@ -346,7 +345,6 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 		folio_unlock(folio);
 	}
 	folio_batch_release(&fbatch);
-	cond_resched();
 
 	goto repeat;
 }
@@ -382,7 +380,6 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
@@ -539,7 +536,6 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 	} while (++i < nr_folios);
 
 	folio_batch_release(&fbatch);
-	cond_resched();
 	goto repeat;
 
 out_locked:
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7ec16879756e..45c65b450119 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -361,7 +361,6 @@ static void nilfs_transaction_lock(struct super_block *sb,
 		nilfs_segctor_do_immediate_flush(sci);
 
 		up_write(&nilfs->ns_segctor_sem);
-		cond_resched();
 	}
 	if (gcflag)
 		ti->ti_flags |= NILFS_TI_GC;
@@ -746,13 +745,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
 				folio_batch_release(&fbatch);
-				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
 	}
 	folio_batch_release(&fbatch);
-	cond_resched();
 	goto repeat;
 }
 
@@ -785,7 +782,6 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 			} while (bh != head);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 62fe0b679e58..64a66e1aeac4 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -805,7 +805,6 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * User can supply arbitrarily large buffer. Avoid softlockups
 		 * in case there are lots of available events.
 		 */
-		cond_resched();
 		event = get_one_event(group, count);
 		if (IS_ERR(event)) {
 			ret = PTR_ERR(event);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..a6aff29204f6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -79,7 +79,6 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 		iput_inode = inode;
 
-		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index f79408f9127a..173f6fcfef54 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2556,7 +2556,6 @@ int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt, const u8 val)
 		set_page_dirty(page);
 		put_page(page);
 		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
 		if (idx == end)
 			goto done;
 		idx++;
@@ -2597,7 +2596,6 @@ int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt, const u8 val)
 		unlock_page(page);
 		put_page(page);
 		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
 	}
 	/* If there is a last partial page, need to do it the slow way. */
 	if (end_ofs) {
@@ -2614,7 +2612,6 @@ int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt, const u8 val)
 		set_page_dirty(page);
 		put_page(page);
 		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
 	}
 done:
 	ntfs_debug("Done.");
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cbc545999cfe..a03ad2d7faf7 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -259,7 +259,6 @@ static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size)
 		 * files.
 		 */
 		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
 	} while (++index < end_index);
 	read_lock_irqsave(&ni->size_lock, flags);
 	BUG_ON(ni->initialized_size != new_init_size);
@@ -1868,7 +1867,6 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 			iov_iter_revert(i, copied);
 			break;
 		}
-		cond_resched();
 		if (unlikely(copied < bytes)) {
 			iov_iter_revert(i, copied);
 			if (copied)
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1f7a194983c5..cfb09f47a588 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -158,7 +158,6 @@ static int ntfs_extend_initialized_size(struct file *file,
 			break;
 
 		balance_dirty_pages_ratelimited(mapping);
-		cond_resched();
 	}
 
 	return 0;
@@ -241,7 +240,6 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 
 		unlock_page(page);
 		put_page(page);
-		cond_resched();
 	}
 out:
 	mark_inode_dirty(inode);
@@ -1005,13 +1003,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		if (err)
 			goto out;
 
-		/*
-		 * We can loop for a long time in here. Be nice and allow
-		 * us to schedule out to avoid softlocking if preempt
-		 * is disabled.
-		 */
-		cond_resched();
-
 		pos += copied;
 		written += copied;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index dad976a68985..8fa4bb50b0b1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2265,8 +2265,6 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 		if (err)
 			goto out;
-
-		cond_resched();
 	}
 
 remove_wof:
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index aef58f1395c8..2fccabc7aa51 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7637,10 +7637,8 @@ int ocfs2_trim_mainbm(struct super_block *sb, struct fstrim_range *range)
 	 * main_bm related locks for avoiding the current IO starve, then go to
 	 * trim the next group
 	 */
-	if (ret >= 0 && group <= last_group) {
-		cond_resched();
+	if (ret >= 0 && group <= last_group)
 		goto next_group;
-	}
 out:
 	range->len = trimmed * sb->s_blocksize;
 	return ret;
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 960080753d3b..7bf6f46bd429 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -951,7 +951,12 @@ static void o2net_sendpage(struct o2net_sock_container *sc,
 		if (ret == (ssize_t)-EAGAIN) {
 			mlog(0, "sendpage of size %zu to " SC_NODEF_FMT
 			     " returned EAGAIN\n", size, SC_NODEF_ARGS(sc));
-			cond_resched();
+
+			/*
+			 * Take a breather before retrying. Though maybe this
+			 * should be a wait on an event or a timeout?
+			 */
+			cpu_relax();
 			continue;
 		}
 		mlog(ML_ERROR, "sendpage of size %zu to " SC_NODEF_FMT
@@ -1929,7 +1934,6 @@ static void o2net_accept_many(struct work_struct *work)
 		o2net_accept_one(sock, &more);
 		if (!more)
 			break;
-		cond_resched();
 	}
 }
 
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index eedf07ca23ca..271e0f7405e5 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -792,11 +792,10 @@ static int dlm_thread(void *data)
 		spin_unlock(&dlm->spinlock);
 		dlm_flush_asts(dlm);
 
-		/* yield and continue right away if there is more work to do */
-		if (!n) {
-			cond_resched();
+		/* An unlock above would have led to a yield if one was
+		 * needed. Continue right away if there is more to do */
+		if (!n)
 			continue;
-		}
 
 		wait_event_interruptible_timeout(dlm->dlm_thread_wq,
 						 !dlm_dirty_list_empty(dlm) ||
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index c45596c25c66..f977337a33db 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -940,6 +940,10 @@ static int ocfs2_zero_extend_range(struct inode *inode, u64 range_start,
 	BUG_ON(range_start >= range_end);
 
 	while (zero_pos < range_end) {
+		/*
+		 * If this is a very long extent, then we might be here
+		 * awhile. We should expect the scheduler to preempt us.
+		 */
 		next_pos = (zero_pos & PAGE_MASK) + PAGE_SIZE;
 		if (next_pos > range_end)
 			next_pos = range_end;
@@ -949,12 +953,6 @@ static int ocfs2_zero_extend_range(struct inode *inode, u64 range_start,
 			break;
 		}
 		zero_pos = next_pos;
-
-		/*
-		 * Very large extends have the potential to lock up
-		 * the cpu for extended periods of time.
-		 */
-		cond_resched();
 	}
 
 	return rc;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..fec3dc6a887d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3532,7 +3532,6 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		char name[10 + 1];
 		unsigned int len;
 
-		cond_resched();
 		if (!has_pid_permissions(fs_info, iter.task, HIDEPID_INVISIBLE))
 			continue;
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6276b3938842..b014c44b96e9 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -272,7 +272,6 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 				     name, len, instantiate, p,
 				     &data))
 			goto out;
-		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 23fc24d16b31..4625dea20bc6 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -491,7 +491,6 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
 			page_offline_thaw();
-			cond_resched();
 			page_offline_freeze();
 		}
 
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..14fd181baf57 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -80,8 +80,6 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		pfn++;
 		out++;
 		count -= KPMSIZE;
-
-		cond_resched();
 	}
 
 	*ppos += (char __user *)out - buf;
@@ -258,8 +256,6 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 		pfn++;
 		out++;
 		count -= KPMSIZE;
-
-		cond_resched();
 	}
 
 	*ppos += (char __user *)out - buf;
@@ -313,8 +309,6 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 		pfn++;
 		out++;
 		count -= KPMSIZE;
-
-		cond_resched();
 	}
 
 	*ppos += (char __user *)out - buf;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..49c2ebcb5fd9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -629,7 +629,6 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		smaps_pte_entry(pte, addr, walk);
 	pte_unmap_unlock(pte - 1, ptl);
 out:
-	cond_resched();
 	return 0;
 }
 
@@ -1210,7 +1209,6 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		ClearPageReferenced(page);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
 	return 0;
 }
 
@@ -1554,8 +1552,6 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	}
 	pte_unmap_unlock(orig_pte, ptl);
 
-	cond_resched();
-
 	return err;
 }
 
@@ -1605,8 +1601,6 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			frame++;
 	}
 
-	cond_resched();
-
 	return err;
 }
 #else
@@ -1899,7 +1893,6 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
-	cond_resched();
 	return 0;
 }
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 31e897ad5e6a..994d69edf349 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1068,7 +1068,6 @@ static int add_dquot_ref(struct super_block *sb, int type)
 		 * later.
 		 */
 		old_inode = inode;
-		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 015bfe4e4524..74b503a46884 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -814,7 +814,6 @@ static int write_ordered_buffers(spinlock_t * lock,
 			if (chunk.nr)
 				write_ordered_chunk(&chunk);
 			wait_on_buffer(bh);
-			cond_resched();
 			spin_lock(lock);
 			goto loop_next;
 		}
@@ -1671,7 +1670,6 @@ static int write_one_transaction(struct super_block *s,
 		}
 next:
 		cn = cn->next;
-		cond_resched();
 	}
 	return ret;
 }
diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..1d05de51c543 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -573,7 +573,6 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 				*routp = res_out;
 			if (res_ex)
 				*rexp = res_ex;
-			cond_resched();
 		}
 		wait->_qproc = NULL;
 		if (retval || timed_out || signal_pending(current))
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2108b3b40ce9..da3b31b02b45 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2713,7 +2713,6 @@ static void cifs_extend_writeback(struct address_space *mapping,
 		}
 
 		folio_batch_release(&batch);
-		cond_resched();
 	} while (!stop);
 
 	*_len = len;
@@ -2951,7 +2950,6 @@ static int cifs_writepages_region(struct address_space *mapping,
 		}
 
 		folio_batch_release(&fbatch);		
-		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
 	*_next = start;
diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..0b43bedbf36f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -604,7 +604,6 @@ ssize_t __splice_from_pipe(struct pipe_inode_info *pipe, struct splice_desc *sd,
 
 	splice_from_pipe_begin(sd);
 	do {
-		cond_resched();
 		ret = splice_from_pipe_next(pipe, sd);
 		if (ret > 0)
 			ret = splice_from_pipe_feed(pipe, sd, actor);
diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index d76eb7b39f56..b9100c713964 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -477,7 +477,6 @@ int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req)
 	}
 
 	err = make_free_space(c);
-	cond_resched();
 	if (err == -EAGAIN) {
 		dbg_budg("try again");
 		goto again;
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index c4fc1047fc07..2fd6aef59b7d 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -309,7 +309,6 @@ int ubifs_bg_thread(void *info)
 			ubifs_ro_mode(c, err);
 
 		run_bg_commit(c);
-		cond_resched();
 	}
 
 	ubifs_msg(c, "background thread \"%s\" stops", c->bgt_name);
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index eef9e527d9ff..add4b72fd52f 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -852,7 +852,6 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 	       sleb->nodes_cnt, sleb->endpt);
 
 	list_for_each_entry(snod, &sleb->nodes, list) {
-		cond_resched();
 		pr_err("Dumping node at LEB %d:%d len %d\n", lnum,
 		       snod->offs, snod->len);
 		ubifs_dump_node(c, snod->node, c->leb_size - snod->offs);
@@ -1622,8 +1621,6 @@ int dbg_walk_index(struct ubifs_info *c, dbg_leaf_callback leaf_cb,
 	while (1) {
 		int idx;
 
-		cond_resched();
-
 		if (znode_cb) {
 			err = znode_cb(c, znode, priv);
 			if (err) {
@@ -2329,7 +2326,6 @@ int dbg_check_data_nodes_order(struct ubifs_info *c, struct list_head *head)
 		ino_t inuma, inumb;
 		uint32_t blka, blkb;
 
-		cond_resched();
 		sa = container_of(cur, struct ubifs_scan_node, list);
 		sb = container_of(cur->next, struct ubifs_scan_node, list);
 
@@ -2396,7 +2392,6 @@ int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
 		ino_t inuma, inumb;
 		uint32_t hasha, hashb;
 
-		cond_resched();
 		sa = container_of(cur, struct ubifs_scan_node, list);
 		sb = container_of(cur->next, struct ubifs_scan_node, list);
 
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2f48c58d47cd..7baa86efa471 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -683,7 +683,6 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		kfree(file->private_data);
 		ctx->pos = key_hash_flash(c, &dent->key);
 		file->private_data = dent;
-		cond_resched();
 	}
 
 out:
diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 3134d070fcc0..d85bcb64e9a8 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -109,7 +109,6 @@ static int data_nodes_cmp(void *priv, const struct list_head *a,
 	struct ubifs_info *c = priv;
 	struct ubifs_scan_node *sa, *sb;
 
-	cond_resched();
 	if (a == b)
 		return 0;
 
@@ -153,7 +152,6 @@ static int nondata_nodes_cmp(void *priv, const struct list_head *a,
 	struct ubifs_info *c = priv;
 	struct ubifs_scan_node *sa, *sb;
 
-	cond_resched();
 	if (a == b)
 		return 0;
 
@@ -305,7 +303,6 @@ static int move_node(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 {
 	int err, new_lnum = wbuf->lnum, new_offs = wbuf->offs + wbuf->used;
 
-	cond_resched();
 	err = ubifs_wbuf_write_nolock(wbuf, snod->node, snod->len);
 	if (err)
 		return err;
@@ -695,8 +692,6 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 		/* Maybe continue after find and break before find */
 		lp.lnum = -1;
 
-		cond_resched();
-
 		/* Give the commit an opportunity to run */
 		if (ubifs_gc_should_commit(c)) {
 			ret = -EAGAIN;
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb170382..4915ab97f7ce 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -683,8 +683,6 @@ int ubifs_bg_wbufs_sync(struct ubifs_info *c)
 	for (i = 0; i < c->jhead_cnt; i++) {
 		struct ubifs_wbuf *wbuf = &c->jheads[i].wbuf;
 
-		cond_resched();
-
 		/*
 		 * If the mutex is locked then wbuf is being changed, so
 		 * synchronization is not necessary.
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index 6d6cd85c2b4c..57e4d001125a 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1113,8 +1113,6 @@ static int scan_check_cb(struct ubifs_info *c,
 	list_for_each_entry(snod, &sleb->nodes, list) {
 		int found, level = 0;
 
-		cond_resched();
-
 		if (is_idx == -1)
 			is_idx = (snod->type == UBIFS_IDX_NODE) ? 1 : 0;
 
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index c4d079328b92..0cadd08f6304 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1483,7 +1483,6 @@ static int dbg_is_nnode_dirty(struct ubifs_info *c, int lnum, int offs)
 	for (; nnode; nnode = next_nnode(c, nnode, &hght)) {
 		struct ubifs_nbranch *branch;
 
-		cond_resched();
 		if (nnode->parent) {
 			branch = &nnode->parent->nbranch[nnode->iip];
 			if (branch->lnum != lnum || branch->offs != offs)
@@ -1517,7 +1516,6 @@ static int dbg_is_pnode_dirty(struct ubifs_info *c, int lnum, int offs)
 		struct ubifs_pnode *pnode;
 		struct ubifs_nbranch *branch;
 
-		cond_resched();
 		pnode = ubifs_pnode_lookup(c, i);
 		if (IS_ERR(pnode))
 			return PTR_ERR(pnode);
@@ -1673,7 +1671,6 @@ int dbg_check_ltab(struct ubifs_info *c)
 		pnode = ubifs_pnode_lookup(c, i);
 		if (IS_ERR(pnode))
 			return PTR_ERR(pnode);
-		cond_resched();
 	}
 
 	/* Check nodes */
diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 4909321d84cf..23572f418a8b 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -957,7 +957,6 @@ static int dbg_read_orphans(struct check_info *ci, struct ubifs_scan_leb *sleb)
 	int i, n, err;
 
 	list_for_each_entry(snod, &sleb->nodes, list) {
-		cond_resched();
 		if (snod->type != UBIFS_ORPH_NODE)
 			continue;
 		orph = snod->node;
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index f0d51dd21c9e..6b1bf684ec14 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -638,8 +638,6 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 		dbg_scan("look at LEB %d:%d (%d bytes left)",
 			 lnum, offs, len);
 
-		cond_resched();
-
 		/*
 		 * Scan quietly until there is an error from which we cannot
 		 * recover
@@ -999,8 +997,6 @@ static int clean_an_unclean_leb(struct ubifs_info *c,
 	while (len >= 8) {
 		int ret;
 
-		cond_resched();
-
 		/* Scan quietly until there is an error */
 		ret = ubifs_scan_a_node(c, buf, len, lnum, offs, quiet);
 
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 4211e4456b1e..9a361d8f998e 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -305,7 +305,6 @@ static int replay_entries_cmp(void *priv, const struct list_head *a,
 	struct ubifs_info *c = priv;
 	struct replay_entry *ra, *rb;
 
-	cond_resched();
 	if (a == b)
 		return 0;
 
@@ -332,8 +331,6 @@ static int apply_replay_list(struct ubifs_info *c)
 	list_sort(c, &c->replay_list, &replay_entries_cmp);
 
 	list_for_each_entry(r, &c->replay_list, list) {
-		cond_resched();
-
 		err = apply_replay_entry(c, r);
 		if (err)
 			return err;
@@ -722,8 +719,6 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 		u8 hash[UBIFS_HASH_ARR_SZ];
 		int deletion = 0;
 
-		cond_resched();
-
 		if (snod->sqnum >= SQNUM_WATERMARK) {
 			ubifs_err(c, "file system's life ended");
 			goto out_dump;
@@ -1060,8 +1055,6 @@ static int replay_log_leb(struct ubifs_info *c, int lnum, int offs, void *sbuf)
 	}
 
 	list_for_each_entry(snod, &sleb->nodes, list) {
-		cond_resched();
-
 		if (snod->sqnum >= SQNUM_WATERMARK) {
 			ubifs_err(c, "file system's life ended");
 			goto out_dump;
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index 84a9157dcc32..db3fc3297d1a 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -269,8 +269,6 @@ struct ubifs_scan_leb *ubifs_scan(const struct ubifs_info *c, int lnum,
 		dbg_scan("look at LEB %d:%d (%d bytes left)",
 			 lnum, offs, len);
 
-		cond_resched();
-
 		ret = ubifs_scan_a_node(c, buf, len, lnum, offs, quiet);
 		if (ret > 0) {
 			/* Padding bytes or a valid padding node */
diff --git a/fs/ubifs/shrinker.c b/fs/ubifs/shrinker.c
index d00a6f20ac7b..f381f844c321 100644
--- a/fs/ubifs/shrinker.c
+++ b/fs/ubifs/shrinker.c
@@ -125,7 +125,6 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 
 		zprev = znode;
 		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
-		cond_resched();
 	}
 
 	return total_freed;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..0307d12d29d2 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -949,8 +949,6 @@ static int check_volume_empty(struct ubifs_info *c)
 			c->empty = 0;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	return 0;
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..97218e7d380d 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -857,8 +857,6 @@ static int write_index(struct ubifs_info *c)
 	while (1) {
 		u8 hash[UBIFS_HASH_ARR_SZ];
 
-		cond_resched();
-
 		znode = cnext;
 		idx = c->cbuf + used;
 
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 4d686e34e64d..b92d2ca00a0b 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -235,7 +235,6 @@ long ubifs_destroy_tnc_subtree(const struct ubifs_info *c,
 			    !ubifs_zn_dirty(zn->zbranch[n].znode))
 				clean_freed += 1;
 
-			cond_resched();
 			kfree(zn->zbranch[n].znode);
 		}
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56eaae9dac1a..ad8500e831ba 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -914,7 +914,6 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	mmap_write_lock(mm);
 	prev = NULL;
 	for_each_vma(vmi, vma) {
-		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
 		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
@@ -1277,7 +1276,6 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 		seq = read_seqcount_begin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
-		cond_resched();
 	} while (read_seqcount_retry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
@@ -1392,8 +1390,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	basic_ioctls = false;
 	cur = vma;
 	do {
-		cond_resched();
-
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
 		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
@@ -1458,7 +1454,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
@@ -1603,8 +1598,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	found = false;
 	cur = vma;
 	do {
-		cond_resched();
-
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
 		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
@@ -1629,8 +1622,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
-
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
 
 		/*
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..a13623717dd6 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -152,7 +152,6 @@ static int build_merkle_tree(struct file *filp,
 			err = -EINTR;
 			goto out;
 		}
-		cond_resched();
 	}
 	/* Finish all nonempty pending tree blocks. */
 	for (level = 0; level < num_levels; level++) {
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index f58432772d9e..1b0102faae6c 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -71,7 +71,6 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 			err = -EINTR;
 			break;
 		}
-		cond_resched();
 		offs_in_page = 0;
 	}
 	return retval ? retval : err;
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index cabdc0e16838..97022145e888 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -16,13 +16,6 @@ xchk_should_terminate(
 	struct xfs_scrub	*sc,
 	int			*error)
 {
-	/*
-	 * If preemption is disabled, we need to yield to the scheduler every
-	 * few seconds so that we don't run afoul of the soft lockup watchdog
-	 * or RCU stall detector.
-	 */
-	cond_resched();
-
 	if (fatal_signal_pending(current)) {
 		if (*error == 0)
 			*error = -EINTR;
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index f0f532c10a5a..59deed2fae80 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -498,13 +498,6 @@ xfarray_sort_terminated(
 	struct xfarray_sortinfo	*si,
 	int			*error)
 {
-	/*
-	 * If preemption is disabled, we need to yield to the scheduler every
-	 * few seconds so that we don't run afoul of the soft lockup watchdog
-	 * or RCU stall detector.
-	 */
-	cond_resched();
-
 	if ((si->flags & XFARRAY_SORT_KILLABLE) &&
 	    fatal_signal_pending(current)) {
 		if (*error == 0)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 465d7630bb21..cba03bff03ab 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -171,7 +171,6 @@ xfs_end_io(
 		list_del_init(&ioend->io_list);
 		iomap_ioend_try_merge(ioend, &tmp);
 		xfs_end_ioend(ioend);
-		cond_resched();
 	}
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 3c210ac83713..d0ffbf581355 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1716,8 +1716,6 @@ xfs_icwalk_ag(
 		if (error == -EFSCORRUPTED)
 			break;
 
-		cond_resched();
-
 		if (icw && (icw->icw_flags & XFS_ICWALK_FLAG_SCAN_LIMIT)) {
 			icw->icw_scan_limit -= XFS_LOOKUP_BATCH;
 			if (icw->icw_scan_limit <= 0)
diff --git a/fs/xfs/xfs_iwalk.c b/fs/xfs/xfs_iwalk.c
index b3275e8d47b6..908881df15ed 100644
--- a/fs/xfs/xfs_iwalk.c
+++ b/fs/xfs/xfs_iwalk.c
@@ -420,7 +420,6 @@ xfs_iwalk_ag(
 		struct xfs_inobt_rec_incore	*irec;
 		xfs_ino_t			rec_fsino;
 
-		cond_resched();
 		if (xfs_pwork_want_abort(&iwag->pwork))
 			goto out;
 
-- 
2.31.1

