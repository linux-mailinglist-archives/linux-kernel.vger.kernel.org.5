Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6177E4B75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjKGWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344212AbjKGWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:04:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF373852
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpqo020714;
        Tue, 7 Nov 2023 22:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CaXGc/Oz6KRDRsIiJc13vxsw+xsuSELjGpa2xXje9IA=;
 b=SLNLHEIetUP4ICWVrxL4sP2vkzRxHamHGR7gbgPZVFbuF3Jb+Tu0ONlnzvYKPNoChabH
 b9mqgd/7FudcN5XKdMFFDTZ7J0o82GBB5Yx0El4EEDcq4CxDWN2WPQoHWn7FHO9pWoAY
 yuKKVIleEoSfPHT89ct2+T52/1Jo2Z/puC/CTekTjvGu0ZQUOnJFa0H4RZl54XeyDImQ
 CKhZ9mcdvt8SwZMqWO1sqawXIqn+LG4uQkrvwx7hMf3CBSKZsAismXGPiuIwW7ZuDzvl
 SjPrnuXLv7mYNrBFyVntLQ+Fxz0srnZdDBp3Anf+VTCSIZqfE3/kkGqq3EAtz9jkbEc9 qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIhBG011123;
        Tue, 7 Nov 2023 22:00:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsm6c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVuub7GZxWUpE3P2czO6UHSuweXQrb02Wlz7wgeGOGaMDzxVy/1zS0UEVji+72Pc/lqH2VOniFok9rlscG/+K5mOB5PtqSXm2B542QoKOh3t5kOe/dJimxQqQi1uCk5ahv4UzkVBenEc0YbcVCegp1s2cZu2EPWl8XN3K+F/h8tjuBgGfog1EsZvidGH8yPI1oJopp5gVqh9JlgLBpterEpmLNOBLjE7zWNnrW0C3vwXlbDC5DoB/VbXyIClArlUW+GijmMgYEqKN6VX+HfWl5msjES2O0+kzvV71j5QUcG4GgxrIqdvWjScWnvunQ93Fo4Qi8DJ/tRbmCFCorY5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaXGc/Oz6KRDRsIiJc13vxsw+xsuSELjGpa2xXje9IA=;
 b=B4KjNQGETrPgNVfSNDbxJ+7mZoySCZlIm9jJuySlsK3dbnsgsSEuXXHXa4l59DjniR7n0KZYc47zT2YZVeXPu3qyiCV7JCrlK6SJgYu1/FqKYU5UiJrYiHvD8PUmiqqWdIlrSHj5+bgzzROZXbRj6YJ6UmVwizhfk0T3bxz7y8redr6c9J+PEM9ePeML6XmpS8h0cyezhPd1vPTq1g6eBpREo+ILwRSje34CBTcHMMgxfg4zSXhMzVSli2YVIY4zo0C7QAnwMnwGVsLqOaCLE5PmwfyPje0GNv0fY5zZOgBqfsh2WqxZwO/EWk8nhdKJRg70PE7n8NEkSicZfODHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaXGc/Oz6KRDRsIiJc13vxsw+xsuSELjGpa2xXje9IA=;
 b=woy7ZwAi4rjuujtCiF6ZesVi1/Kz9bWINInVDaJTR8VmdCqXnAX+tmIgkHSaOe3H8yC1jPF9CmJ9VxbCNp6AQr5bICL0VrAE7JZ6r5VoTta2mr9Y3RatthKr1sT9ht7Fylk+VkKyMcuH1GG9xRR/3cygzIpApsi033ckiZVQ9UI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 22:00:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:24 +0000
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
Subject: [RFC PATCH 53/86] sched: fixup __cond_resched_*()
Date:   Tue,  7 Nov 2023 13:57:39 -0800
Message-Id: <20231107215742.363031-54-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f17e49e-2f74-4ea2-c9e1-08dbdfdcf167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eINutye8vuGw+fverb31mbXI+MGgroNkg5XJreKba7LlfAhefhv55ZCgLIubzGp8fW8XRvkNDe8Oa3lTOUUg6gYFt1KCBTvsXXAOTru42wuy//4lHu3S7GFs8GOD/8P5PKD1zsyeCC1wDj1/fbb5RChzx2a6robp3F4Wk7anfQyGqLIJq07Hv6MFfO1O5A4vw1C4PcI9EY5+HXQivJJYvICLsrRij+Psdxc5eM6AjP66wxMb4kYn5dC7YzAEGv6d39TQz1hKb4eifyk0Uq4dxI3vc+vVe6GdYceDxJbpOEARfRdpgFJf8nJjtbjyJeZgjDlcubGwy3aMyuV/ziWKs3v3uq/s9XK0BdHJg5IFNaYMLbIcvomt5RnnHN18CK7R6qXNGTpRYO6CaZjijxFQ5tFhatKXHEW3NaHpJX91jY6jSYwrAaynK4zAlOngeAC0jyfjtr3MFCGGmnX+VnkSfGhP73ZVyQ61xj7uPolkmoy7dZ0RFNDeJTHkG+VuIe/2QNV9miUOjliXGzHjsqjTvK+oNIuNBGpxN6uDiBjo012xuiOHge+tAGP6bZXtNdt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(38100700002)(83380400001)(5660300002)(107886003)(2616005)(6486002)(6506007)(478600001)(6666004)(6512007)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(7416002)(86362001)(7406005)(2906002)(103116003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QsT1esiuXl92BhmwdkVdF0oqxQcRY8wG8FN7s4uhJcpW7pykwx2cYerIsC6E?=
 =?us-ascii?Q?IbQlVvLTeNv6mKIZ15FKuRc7GEI4oq34WkbPQBzGqWCeMdCpxWUrvxdWlLED?=
 =?us-ascii?Q?0iKbkPnK2pOYwmNYp1j0APq1H8KsqHMxVaTxGZ5VcCqsJ/QR3B4/yb+8oQpj?=
 =?us-ascii?Q?i1CpeNHH5k4hyhkzG0EGOMC4JVerHoyVBtnzf1pyNDhXQ8xIUG2TDUjss2cS?=
 =?us-ascii?Q?Gud5YWp1WmBKcLz/OKdPBzqlE8tIks5VCwpbg8jD6x61RqQykytPXkQeLYsn?=
 =?us-ascii?Q?MUkYoDPzALdh4LunaP7iuku1p7MR9OLCPmFlEl/RWCWGux2vQuPOpMjY6ARh?=
 =?us-ascii?Q?Oj4ZjwPaKMmMXk3448aLfqB3d5F6TCBOdhw2KEDwxo5oI1jMXqtESe8S0X4B?=
 =?us-ascii?Q?N5Bea9f+MVal9gAQd+l2XkM+VXiWWcEB8ljbCGLP/PXdWreyYQzDIeEPLJJs?=
 =?us-ascii?Q?cwFkN4IqKhCo3PD0/4jOKKTURbNpAKZ5zS18t/eK/lOsrgKgnn0IeQYjqzn5?=
 =?us-ascii?Q?08ljlhfaq/iQTrLXgQ+ELKTliszB8amr+xNBf/Ryi6weca2msBZ3jFdEAolQ?=
 =?us-ascii?Q?AHMBwcvNTaei3kOVe7aOsA1BL/vmmswO4ahS9/o/RbDNakIDKF8BKOCmEzce?=
 =?us-ascii?Q?NwEo7Q3VCpTbUqrHCkZLxDjDdhOZ6jMQV0RxezjXz41dm/ZUcY48326oK/5t?=
 =?us-ascii?Q?QLzBJ0vYs/wFdFugBxeDniI6KNB7ITt0ea8UUMiJHaLLZx0hj7IOcbkNqtyD?=
 =?us-ascii?Q?1InZ8twRORSGCTL4y3KA0IjbWVMUaYzSsAXJEPURIX7yxLQDXuzcK7/843bG?=
 =?us-ascii?Q?qhMkyTMsXpIXdVPprBaYeB+cO9bGAcFhrql+/GxfJo78U3e6/4S96/G9zOCQ?=
 =?us-ascii?Q?xCV5DO0vA8pwn3qUHCCKxLIK4FyCKRyU2S/44u1khAko5ikjlha97xPgrjVy?=
 =?us-ascii?Q?RFbz0pwOktHTBW0iT4fBaE2w4qV70mV7THiCRemuqSf8Oxpb8/njMp49S8Ts?=
 =?us-ascii?Q?pkS84+Q30bP24yyi8AAw4BYXP6ea/HSftlBWEF8lDsUvno72mddPMwo1FD0c?=
 =?us-ascii?Q?VS0i0HSBk69QZuTVgQ4MyLNhtQqJWirlvXyTrOe0tJpFjkn0yY6iwFSOw9WX?=
 =?us-ascii?Q?WuNniP9nlcMo7JFsJGbutXlIx+MJZLxUxKTF6yHNOILpxWN+hdJvb59LjsuC?=
 =?us-ascii?Q?MA72lQPC4FNK07Sb8vwfN/tH21PZOA8Es0id3PedPsAricoaJ7K4CcY3v86v?=
 =?us-ascii?Q?PvAsG6ihGUJSvjXR1DqOPWkLtoDnrLUfKNQ80Bw8yN5B7snOHqC4EF7/pL1i?=
 =?us-ascii?Q?ODp5kU4uXOwxn4G4BhZf81s4KKz2XSNuL2Evso4bVBjEOKe2NhaQE2xzQUta?=
 =?us-ascii?Q?TPfbo6HyZRK6yj0n712wXuq9GMBp1zjVZ3KmUPPZXA07esy4vqshfUTWmune?=
 =?us-ascii?Q?MRoE5HqeD8vwjPfJHiyvYX3PAvnyqYhU1e3mFDN6CWfGdlaBK6azHf839PtV?=
 =?us-ascii?Q?ckgdOLiCJp61YuflYqJuuOVgtMMy2AVsfp9k7GhvcowbR+cWArWxH8M/gLkA?=
 =?us-ascii?Q?ay03WMmD/dQOq9HgoA0XBeBg3G7E9cHdct8SnYXgwuzQWo5PYQnE2CIs8UR7?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jt/HMow/pqg3esG51IbCRneetotudD+hnOkOG5Hv2tshhfPh3wiquP3EdLHx?=
 =?us-ascii?Q?EN0D5SOy3PTvOXMpzf9ftYXaLZJhbdlD4+73IOaf0h/58I+K9IjGxNfreiwy?=
 =?us-ascii?Q?ry8gn37IXy/kQHgmukCIaW0hVFo5c06h0syh0VoEMgAPdvnOeBZCmLou0NUI?=
 =?us-ascii?Q?v0sqtVE/4eCPHy/T2Mx6gqxx1xiY6aSJw1jRw3J3P9guU6M4/0TjilXl9Cfg?=
 =?us-ascii?Q?QBpwYUl2sz9riRT8C1Fz2iHOi/t13mUyEDi2qK2r0vbEnw40NhWGNbG2yN6+?=
 =?us-ascii?Q?egr07sIvzO/g7AAlxj2FDqwd+ROzefwZoLIlSi5/JKNeZtwrMHOo0/3bLqc1?=
 =?us-ascii?Q?NjstxI9OwiB/29tR5PLLZi639ny5A26ioMVL6swBaMvpF9h8dRFcGJetF+2l?=
 =?us-ascii?Q?0fctCakXIfEYF3yU/WxeOV2vXXn++3SnMRLf36HnKwuQj6FonPQoKEnl55ET?=
 =?us-ascii?Q?ztW+nznKq3g0x6qQvOyDX5SB4dunFiS2CXE7tSpyFss8oYiV2k1zd21CaUzY?=
 =?us-ascii?Q?NNCFxnhbqSNV/U/TYHj76bpEd5Sn3AGRtQZood2emxLNXT7Lxn/R/tPOuiLB?=
 =?us-ascii?Q?4cwd+38uEjY/NtOKlU+ysE+zGTx3bGVrbd8/FZXentB1NuJHRpvTKOYQZPnA?=
 =?us-ascii?Q?2utmNVX4f5Hpms3ItjudoyCnx3fWPAhC9AywRrsv66RDHLtWqgZ/xLM/m6W0?=
 =?us-ascii?Q?m+FqDW4GQN/Zi71pc14FDE9ttzjh8D+ExGU4OksW1nadJGnhaSinpIZnA/Em?=
 =?us-ascii?Q?VG0UCuV69qRHB3KqMahVeL0TK2L0sVgO1KsLUiqxrgIxyl7mcZounW+2jG8a?=
 =?us-ascii?Q?frxHLHXsj41Wg3+pirnyvm487FLPtNfwhaWFFhA/+CLXoDsZZtjPe0Bq5Inc?=
 =?us-ascii?Q?NFGxSbdYCmk04uNgJnGAUua7z1jFbjz343/UM4ek1o5GS5SUifQ/oUFoaz1I?=
 =?us-ascii?Q?nhT6rzBNnqE0o3F+BiXr/GzphWuizOYsjelSkr8ATmUMQIaIedMzej4RRJz1?=
 =?us-ascii?Q?RY6J8z47wAKaj7EJKK/NCOiRedW51jD3jr3LW14cCtRmnsUSX4zG0T7j7ZqH?=
 =?us-ascii?Q?0/WsEy//Ba7fzBFws77p9j7WJvU6UnJFrvACUfv4N6eOJS4eUcwFSWvYXReh?=
 =?us-ascii?Q?p/2nZpTUlVVG0J1o1zU6Pnv13Giswqfo8FZP8Slw4XoNShfGFlm3/jqk/6XD?=
 =?us-ascii?Q?L2iS6Y9jS0x6SldC3Dz+zvkwRbgCziFV08ZpRAJIi3dVNb3krcUAbXSEVt5q?=
 =?us-ascii?Q?ydbDE7MIGqU6GZfznM38IO0i2Hv7RiBGMCQly90WPdAVeL03lBO5UlEW71AN?=
 =?us-ascii?Q?SMALQnSQ+XqaG7zowp3EUPXoXAYugdHS5kuK733tkvChY94QntOTBpWynXpT?=
 =?us-ascii?Q?y5GZi/iS2KFld4uDyUUqH64wVuiVpNrMKt+iX4BRm3Scntg0/qHMiQ0Uq6Cx?=
 =?us-ascii?Q?ISmRHOmhYIHrPz5V4jPlP/ge85OySiD3iyAebb4c6mjlxr6XyuZkJN1nGMoZ?=
 =?us-ascii?Q?PwteoaO+H1Q2lsKbxKPkXePobVqL6JFeI+U3vDD7otckgezgKMh2agJ46Q?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f17e49e-2f74-4ea2-c9e1-08dbdfdcf167
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:24.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2rLaLrl3FGZIZMN8Xs+d+E3HLKmAsHgQ+AXygwiUgjLRyN+qcqcagO2+NkcPW7TsuK4CY4QCr+CmDgNXd3kUZF3LUa3skzKu/HJLvg8EXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=816 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: mRrjxsjl77RPY7m7nPFCIu2smu0fy_gC
X-Proofpoint-ORIG-GUID: mRrjxsjl77RPY7m7nPFCIu2smu0fy_gC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the call to _cond_resched(). The rescheduling happens
implicitly when we give up the lock.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15db5fb7acc7..e1b0759ed3ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8595,12 +8595,8 @@ EXPORT_SYMBOL(_cond_resched);
 #endif
 
 /*
- * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
- * call schedule, and on return reacquire the lock.
- *
- * This works OK both with and without CONFIG_PREEMPTION. We do strange low-level
- * operations here to prevent schedule() from being called twice (once via
- * spin_unlock(), once by hand).
+ * __cond_resched_lock() - if a reschedule is pending, drop the given lock
+ * (implicitly calling schedule), and reacquire the lock.
  */
 int __cond_resched_lock(spinlock_t *lock)
 {
@@ -8611,7 +8607,7 @@ int __cond_resched_lock(spinlock_t *lock)
 
 	if (spin_needbreak(lock) || resched) {
 		spin_unlock(lock);
-		if (!_cond_resched())
+		if (!resched)
 			cpu_relax();
 		ret = 1;
 		spin_lock(lock);
@@ -8629,7 +8625,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		read_unlock(lock);
-		if (!_cond_resched())
+		if (!resched)
 			cpu_relax();
 		ret = 1;
 		read_lock(lock);
@@ -8647,7 +8643,7 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 
 	if (rwlock_needbreak(lock) || resched) {
 		write_unlock(lock);
-		if (!_cond_resched())
+		if (!resched)
 			cpu_relax();
 		ret = 1;
 		write_lock(lock);
-- 
2.31.1

