Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5D7E4B51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjKGWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjKGWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988E1997
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJaYK014901;
        Tue, 7 Nov 2023 21:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kIqs5GaTUnYsYWtEFgh6wQaJ/Uli7RMd0ESfN8XJJMw=;
 b=YASX9zbCAZg+a+s/S4jQBiqkcLPnTyW/VVFAEP8/jq0lx3tcWLmf3ahViK4r8tt/LW7N
 1XBB6V2F20nF4MuWEYJ8p1zU+tvP/XwxN36CFcMZ8cZaoBm2dOkqa6v3Uk/pZSfEuWQk
 +eg5KDq+G4pzDPYdHxdXJ1DSc9yiwJvXBVd4eYSk70o5KUbgjYIvsXWd1v06PjSOrngw
 VMz23U9T45QVhV3gctofYNMCWSXTPFkh1gVrYl5nXjX2ApfobcueBLWvxpPuHyGgCia1
 CqfATyj0ZeNQue2HIn6buLHmljZhFCgJJcr2c3smmIVOqSgn/BfMyBIouDBD1rBXrLeu RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrHd003903;
        Tue, 7 Nov 2023 21:58:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshdn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj5jGp2lRiK42xk6vwnwx+Kw1PcXvMX+fMbT/cHoLFUDQdUBceuc/L8LHSVsQD8EhTIscXoPlVvTpKRV+VwDmOFlt8uRaYRMNDzwInXCnO84c6dK3ty4cSD3l2esjfnoJQdaySfdFIylQOd+ng2RfEe10n5uRqqlSuj6RKKxrgmIDTb+KsCLtmn6i6YTUD6i9EJqoZmlEKnac0qsMCNYLXKXjywko/E/T4+YZsFwL/N+yZClmoz5CYiMOIpiam1gsEwMG5BC1jBXiykFK+dikYDl8Mqcn+lYR5BK51W2+ShJSfmNGmFdCT7G6BukA5nTLau6OmA3skDpQgiTDQ23gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIqs5GaTUnYsYWtEFgh6wQaJ/Uli7RMd0ESfN8XJJMw=;
 b=bsHXU5UKSHU+gf1XLBrsb7nSHhuvPOTOkGmxx2C5svLmAjIfdAIwB5Q+ZntZKZ/tpIAY/csOURiX2dTf5sdcID/dSStkZmHlaWojz3DO8FDNPtuMok2DJ5Miok8t72OPSixKdnQZAxnFXT/GffXeZoelWCjaI8bHOQ0pjve37Rare3cogHT6SMSyNEwknfZxJILALf6mGM79luTO25Giao49s6jHmsSTYyH2yLo414qz9coX7shmwA90rI7GS/nFkTQyFcxxNGb5s84BITPpePfplzM2BMgcVfcIegZAVZO5DGAbO+lwK9UEQkAbZAJYiGBmnnWSVeqReZvd1qzhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIqs5GaTUnYsYWtEFgh6wQaJ/Uli7RMd0ESfN8XJJMw=;
 b=YtAvOn8Ph/kxLo/VkO+heDFR9yeHgiEi0f79yaiMhuWBx7+P2kW3Yi/PUqURKBAceIs6U1Ul8yOu4PtAZ4EHnOqQixcFO0UUJEUF7+B/Y+8XFbPgPX2YbMsbHFzorLKhFkauvwsa4HITMM8bwCAbFnpfRbWrRcnLBHmOxXQkB04=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:02 +0000
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
Subject: [RFC PATCH 06/86] Revert "entry: Fix compile error in dynamic_irqentry_exit_cond_resched()"
Date:   Tue,  7 Nov 2023 13:56:52 -0800
Message-Id: <20231107215742.363031-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: e018e3a8-87bb-4fcc-abca-08dbdfdc9ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6jESFn4PV0nwmO/lnbiMeC6KXD7ElwN2RCbEGrhgoee5j04RqhlDPcL8aRu1JgfRQnS+9jtUWHGt8C+HRPvKK3rNJy4HucaesVSq9OVl9YR0Z9JIF2HVIG7AOWy+ia8HDBmOIGR+fhsZVLOeeicq1S7DBX8ChraKrG5H4XxBprak5+6QNqON6UohFlkQSbK4kJ9E9PfQvIBZ/cv99JttehoqdpJwXnYrXTMfDG4e2GfDHn4Ds2IDfaJuabgGx94LkrhKVzWvVy7Z6Nf1JKzunKFtU32fCE9s7MsgJ9Qnhrxs3HJC+tJKs+lPmj7OOPz7QAY6zrJQAq2Qc8y2bNknrwDMRGTS15qFWvZC2nP7pKoCyC3NcDrvR9rYvrtt8CQeI5i6JTqnDe/tqiMbN4+onYjIEjO8yfiIKd9z/vcj0n/oLY2zv2/zZeZNm/4VrJ/IuXG1GWSBkqsvhqhgN9HmcxSaXQ19Pnn9lfbrA4cMTOJ58nwu0z2D29N8xSXcYsRnuMI9EJVkGCCH5ETR0fJ15uXjNQvOg279di3MiN0MZohXbqKz4oYXa62Tui5QDGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(4744005)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xM8ckh5A7eL9uHx+nwgQhHdFlepu6JUM7YQPMS7O4bIGes1jBNJ5rXvjcHpK?=
 =?us-ascii?Q?PO4iyzlRuqjc5xuQ3e4fAQkEHN29SAcVhfGCM+N9h2UzJ7ZDG7EW21soIrJv?=
 =?us-ascii?Q?2YsxULJC5l88y0zk8V4w2wh0/55ue7GDVPvhvnADqg1bm220uXWOT3ayvK+W?=
 =?us-ascii?Q?sm9YVLRwV6Uc4xh5l8C5yiHakhEpuWL42AvGe/1nmJvJYKEhvM3IPp+8r7mb?=
 =?us-ascii?Q?l9Z95frDLF/eIpGr0JohCgzSDe4NeBipiFX2BJEqX70rkv6YcgaLeFNnXWlm?=
 =?us-ascii?Q?SapnPR/pehxn8KjbVh/Z5Ha9Cm+PUSkVFC7+HykxZE4xWQ0bo//hWLdEGWi9?=
 =?us-ascii?Q?CGiOpz+4iMJr4Cht3FTCBLH+7F1+9k8mtNRvYTLeH7dZNgKznDSYUvZKI99+?=
 =?us-ascii?Q?Zp99eXoe7O8DP18NgoeoMJ134al3SnILPGrYGx6VKpudRFP4xEtypIRC/VRG?=
 =?us-ascii?Q?/7c54KB2vrx4DF4/YLb3ngVdlQYVftbh2rDxKUGSC4JLjc7kuJt+PwzxKA7M?=
 =?us-ascii?Q?NFn52cZj+VxI4D3jFwBIb1HYMgNVbXsfoePVUwAlXTqyeDuHYBJgZQTGo6r4?=
 =?us-ascii?Q?VZSjAoPYEmWtcJdfOC4WcZXrwR+dJeihTps6efnKPT7vuU4X+UhK5RrmepPP?=
 =?us-ascii?Q?L9BNpwBm/mEWoVbORNivVsFYhr9G7UA6Tbo0J8+IE6n717Tf8r5oKI2Ok+z5?=
 =?us-ascii?Q?V3W4P0HjeXzyhokTgoHh9SYqjVeVObfGfMXm0IvW9MRA+DYRrGckjPN0NK1T?=
 =?us-ascii?Q?j7s499eVtGEX/qkC9zJtIwXBdXzD20Nr83Hlaf/o0U6HpO3fXTXLgqB3ScC3?=
 =?us-ascii?Q?WtC+7aPoEYATB4BlOi43RdAIqpFd2uT144P9DYjVKC2VVR90wQW+Z8co/t9K?=
 =?us-ascii?Q?xuopRug/DJP2/H1Qj0mhQrx+jX5S/zBtKnG3b06cgOMCDPQeKmzoKzLDF0W9?=
 =?us-ascii?Q?zWmsDubN0FEu8uT3PFBCZtolH65CfA7ne9ERnyKq9KRP/wrW0r7G3wvFkXQv?=
 =?us-ascii?Q?itrxPUJNxK741iGxAii7yKMSEaZq/KFKjFHs0lDZHZTs59w5XtTS/6PB8HJ+?=
 =?us-ascii?Q?xYdCGASGMxXly5vDCunlD7vEciO3p5iezUotmJartafnR/pDxo355rTbG535?=
 =?us-ascii?Q?FRzQqpsexCEz9wed0S5rrLSjh9Efp78XG/Io2lBnkr5hf8do0eLg1t/iYVvr?=
 =?us-ascii?Q?3xa31D6W6zBTJ9A6IYbGRHsolein35B8rNwNyGoPsHDHNUeR6Yq/agOWPpFd?=
 =?us-ascii?Q?2VD+EjQKdW4iKUQ4U9hrefMWnM60AQe3SKqSr8dCzQICMIHIPMfaqToB9Vsw?=
 =?us-ascii?Q?+/ytn+sBjfy3Yppm66QJLmgrrIgVXs5uZkhV3Wbea5yJWgyT7DWf9pWWSiyJ?=
 =?us-ascii?Q?vWw++vJZDZJ7mbd5NPFwmBWAOXZS0XJ2bID3t1AS6rFJTsemit+WRFvfoIlo?=
 =?us-ascii?Q?xRNRpVlVyWZJtciypyadFnCOGhri+tkWYbdWYqFx/AZreiZMdlsjDkzwdawK?=
 =?us-ascii?Q?YlEHpSf1d58pVjOAlWxrS868W0JvuaF+owM62/xs/dlvgvjJsl1aKlqAwpKk?=
 =?us-ascii?Q?xANgBACyNCXl30ortfSk3LLYKCSCuFrnFtfU4Y/5iakmLFgaG259RHtam8qg?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8JQ9LgoI8uQwX2ftOLdrDbIwFPqMgyCTeNBK0XKo0nvA6AQAn5bAJofAUf3l?=
 =?us-ascii?Q?OJkANSYjTg+l/rpPF5vQ5Mro9UWTJlqYuQEPigCKdkibJIyK0Uk2/2HVoytz?=
 =?us-ascii?Q?OgUIWV5essdVNZMQ9nOigyThgG+4W0Imiz3hMKbB9GeSkNVnhrI4xmuZ5Gmv?=
 =?us-ascii?Q?BhVKJj2HbPgcDY7iJorFTd+xw0EiUV8ayFhS1R04mswQ4GuKJOibX3mGSMfi?=
 =?us-ascii?Q?Ivp0JXpeGmai0IYtmX3921AuCYZ/1VbrWrb++pND09anRoqjzOyoJYABNW8r?=
 =?us-ascii?Q?enIkbG2lf4T4EI0tTqs6RE2NJ8K2xJD9HfBAuZu3emSvidFQIezvbQdNagnx?=
 =?us-ascii?Q?w9cGWkcemvj1hXUm+dKZKzkkmkXwPpJepe+QWiINaxzGhWUrRRlzYgKFJngX?=
 =?us-ascii?Q?KWkHE+TyZy7vLiHOzeQ44Fj3M5kR5E8SpxN9HYl8iI/I6YwxI/y7qXN8qLG7?=
 =?us-ascii?Q?BuP+rxJoc81TZ1YI1IEAm5wdu4dWy1l+YZpBjTxowkOcmN3izw8B+MqAJwUZ?=
 =?us-ascii?Q?IhMUqYPQpUF6FPVtQPXFUMVeilIqq0jBCRrYfVwgkDnEQMlxbnWVoG471jCt?=
 =?us-ascii?Q?u/pgL6u10M/D1G9jWLsgpX2ObrCVzf0L9WiKPf/sgV10U1KTzgGIRajbonAP?=
 =?us-ascii?Q?O7PHk3IgXwk2Te1RBDH+Tfd4GsQIwo5WYxLCwDwaFu+Z/XlXVNaKmNLAFHHa?=
 =?us-ascii?Q?WXoAbobENoKCB+NRlAE/hui3BrbItU3ftFmQRvOhFQWqL+XYj0n+jYmOcuK+?=
 =?us-ascii?Q?bHKPUfRoKOjZnwvn2ytsx02bZ7PLjn3dgBBE1Bsz+ITW2E6L0IjRinfOFZux?=
 =?us-ascii?Q?Dh7P9jAvE7oWNnCGLTN/V+aN4Xl249Hb4RKE+pa8bGOB7upp7xV4zgqa9039?=
 =?us-ascii?Q?3thjgkBDQD/2PCMi42lFo1eOZn+IRMP9K6b+FQ/Pr4z1VBo5MkF4j+8YCxEL?=
 =?us-ascii?Q?cgVhCIAAlFlSPwFOTVm+nW/YvUVR4dQR9YV2JS+uB/cXXOh3ZOn8dGoPsYPN?=
 =?us-ascii?Q?zD2OLXoJQ0HsnERllY4mX+btbiDXGa59xJhWEiKU2I1FCj2B/zpOPw7+PyCP?=
 =?us-ascii?Q?mi/a+SQGPftTAE+TvozeRW3Z2MNwAZG5KmsWq9bzpk5NosofiM8J9LofI+nF?=
 =?us-ascii?Q?oDd+DLuv220LOame1T9HCGPjVZHdOsp9AH4nzt68V0tjHFjpg7VKZlD2VglF?=
 =?us-ascii?Q?Te5YV5IdwgSi0EB3KcVu9CO2jmWN5GgUnCD4pkoP27TN6xKU6oony2T1KV5c?=
 =?us-ascii?Q?UT4F05m7TuXV+Y4EmNQNM2fWoAvmMG1NK6uL9l7Cxh1eDRw8CGsZfSLx25UH?=
 =?us-ascii?Q?gtjHPTv73R9fYEJDj8j4Y/XiIayeQC8VN+u5PHfBQVBOoO0yjJBUiwOm7zWX?=
 =?us-ascii?Q?RT2q8f9GAuff+PFpB4JyIHKwAizUj7HOHpY4MJconkcD7SQr9ziiqowmiHzH?=
 =?us-ascii?Q?Zc3j0GvC64Fdd8j2sFgYrls0zYBNF7sCioXeUVLRgmKqPuDr6z2iWcnsj1jb?=
 =?us-ascii?Q?bijDLbguSYqMfsJjNuc11KlvDaUu4ALYKZ0QIL4uyhdu0FePVEbVBYKUXw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e018e3a8-87bb-4fcc-abca-08dbdfdc9ced
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:02.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An5XWQbZpAobiTKHEUJJQknla28jXwsFcAIT4IkUIsmlKzjfrAHiFi8I1WXyTw9gLGumQgC0wgFuubq+E9e8jltcnl16CC54wVDGNcgExGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: dplFozPxw9dZZdWZ3y2QPZOas4k-fD7Q
X-Proofpoint-ORIG-GUID: dplFozPxw9dZZdWZ3y2QPZOas4k-fD7Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0a70045ed8516dfcff4b5728557e1ef3fd017c53.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..ba684e9853c1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -396,7 +396,7 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void)
 {
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
 		return;
 	raw_irqentry_exit_cond_resched();
 }
-- 
2.31.1

