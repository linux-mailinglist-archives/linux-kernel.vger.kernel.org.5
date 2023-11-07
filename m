Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FA7E4B71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjKGWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjKGWDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DF26BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpZ7020719;
        Tue, 7 Nov 2023 22:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WnmL+bkPmZbyvp+KJh3mqXxxiny0hkTiE1G0LVNwr/Q=;
 b=qY9JE6Nj0yvz6yhRcfrTJcSJBIy4+9riqqrwwUD1WmsEqJ9AUsXuUjBPk7+Dvkb/UyxK
 QhmGUQoX55O35qFdT7RpDY/394oNMRQrNMNwigz4f/gLvPfCemjXPNxljPNbCojb3EXo
 m1jGLlh6r/TzT0P7Q8IUERvHQy3jvnNxu8UI3ixxIQDqW7vdRy2bjj2833EQZAAFATby
 hkhbDuITMnCZMFZn5NiMP0RFWKBBydH3OHuO+IS34LuB4RfJp001BLI+W7Y7Hurxq4Vw
 hz8Jr8RW+hoiiIynjgshY4egsCfwNfmsGHjwH3poE9mop6ONnYQy/2lsubco9lfBlWKL 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPg0023842;
        Tue, 7 Nov 2023 22:00:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241h35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0weliJ7JxpsnMTQj/PqvNY9aUjvHZFpBzCNYRAhkOOnQ4fXnMsJKs5lVOj49ZSZR7w+K67tZr2tr/96rtm0Auzfoi2tQvvxoVgE1LDdW9aNLCDbveuybac27yJ4kcBzAoMuMeJXcoeiXZtgBc3IwaOa2qQaVqriJX0MLibpDJUrZDQqhFV2/xVdDM/M984WS8u+Mi5SbCc+M886VDZjZumIL5591Nt9bOK2gaHAuo6kgEZc2jBu1ySgYpMGKfDr8vCumPCzNDHvyhb1Iqkb8NQbh8USi4G3ZNmdtCeNnA5zb1PxVkAcr1XgJrpzjM0zlealoZRD8YBv9J4K/54nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnmL+bkPmZbyvp+KJh3mqXxxiny0hkTiE1G0LVNwr/Q=;
 b=jgtd3zT+N/gmFH9aWH5FU0uI1CvczLPppLPmH6t7eutUBs/3njYd79NN+Bl1Rk0XZH8/ulgdLfX2F1s4C6HlxPHIOB8X+luLJGJL7A0KqGcXAvQ0UXVgu88jLEYVKVnPNFUyrQIQAZ4Y89VtTRWgbHDUEEl9va19lX5hNtmYPRfAtqXDdVPsRV4E7UOzm5hkrgv98D7aHBDsL01VolU8A0c//10Lv22qDCAwC3MgC3PL597VXP1kMF1ZW43NtlG2tumlTsD6bjopC553lyUrE9SY6IXINdcvAfrBa7MM/tP2byc1Yz+v0kJyIdb5aqoT068Fco5hQtWIYscM4g4NyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnmL+bkPmZbyvp+KJh3mqXxxiny0hkTiE1G0LVNwr/Q=;
 b=hI0E1RhyCQl91//KCyMJnmETawH51D0XlXy8FDKEP0HvNrq0unGVwkr2Z4eW2o4UpL7DQY0eMw6mh7s8GuXRhWAvj3SANbPOiI6uUeeYDjOgtU3jadLJCPp+Dd9k0bPVY161c2utOMz/zoW89us1MNZ2rBqnq0R294b1pIltn7s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:00:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:01 +0000
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
Subject: [RFC PATCH 45/86] preempt: ARCH_NO_PREEMPT only preempts lazily
Date:   Tue,  7 Nov 2023 13:57:31 -0800
Message-Id: <20231107215742.363031-46-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: b64a4c84-2a99-4663-0218-08dbdfdce3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fio7NFuFJ3uqjdezuagLqhd26OuG8EPxBqX5iidIIG7OmFt3KvN4WGFYtcGSG5LxhzAAJMIwQv/GFgS2OrZAMKaH9A2t1G46W95DIEgWgg5KMqI68n8OwrAuqC1tcMuSCygKnje8TNWyop8ZHuRGgbgVVg6p+eLno1n16udYGwdBW7NisT6DT/xyBLJlC3F79jOeV02X7VdRSsnJFwBCEiM/QjDrU35GfhlIAT1ADKxq7KRliw2J2t2F7Nj9zsG+4nhi5dbcfN8/vCNKKytB4p9j7I/Ome3rEW1xaJZ2HoiD26TNbcB27rfDgZC3AQd3mjZNYupXGWa6N/sOJI/6HwIEavvN2WQi3zJoD3JYWqOayufgCrkBXq4hv9MJJQ8ot8CW+eSLV9iisK8h3ZWDDnBhxKiGOw/qYe4aMFIYp7EGmboL0gx/+QFXKgkqaj8a7kbq+pKq1ZVRlZRmjnuBOD8fEdHuSNCPaG5e9WuPCT3+FPzGYU0iyjEpHRbFeMjGOtyy0bVysdhXy6bHkwvgJku0Z74YHnDXTkqIyiQWaML/JbNEvvVAjBIboRRXdz7B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kC306ikyQ+jFprZ4Zl2SU1LJyIVMjr/TtfN5WwlKaru+Ohl41NVoQVEfOKly?=
 =?us-ascii?Q?kU1d9L2FqsgsioMO360RLEJKSi6BGlAP7VzM6rzJ+RJfDCvuUn8es/naug2C?=
 =?us-ascii?Q?5nGtDR6FKrAOyipgbWg1181ajUc8ND1uLPVNE15Bwefjz2+Mji+9tNRczcAx?=
 =?us-ascii?Q?TfDvvJn68JMWOoFPWAh4gui1ohHb/SBLrt9kA27tQ5/X+jNge+mxIKaAX4vV?=
 =?us-ascii?Q?3ZYydgzFj8I68YW1ZgQamOTyuzi4keIVXw6zs59c0TvpzD8lidvXaaQf+Yfo?=
 =?us-ascii?Q?Ll0yLKadzV7QgXA+aqxM8TvHh2paStSGBLiShL1SwpOuG/t+JerJZNffuKTG?=
 =?us-ascii?Q?LiHLBBFlnYISoiye4++oIXkgWAY0Bni05lf1ph9vGY9aUwgTbzqEcVdO14ce?=
 =?us-ascii?Q?+KsoWlIWZ/pM/0imBeBN/SCDnBsnOOTvlMsJokQd6khj0Ycr32whkusSe7P6?=
 =?us-ascii?Q?MrpUFgJEeYNuDOjNgtsOOBck4iGq+8c+j9sJPZ6Dd2WYCv4Lo7dlgOU0Dm+M?=
 =?us-ascii?Q?lz+lj6/DpI4Z9Pzw3GMY9KrmO0+1jg+HKVliNtmeomSYvZwkZ4EJ7gPOdceX?=
 =?us-ascii?Q?Bo4kFKRgS9EaESQ7Ib2n1NCgNDnNApc5y2B92VqIrcYTluK6l7zBnfBYLp/3?=
 =?us-ascii?Q?hqTaXjvD9FxCgRUciL54TVE59Wm91gQHBJHyb++C5PDvcrG3HF3n7WhQn9JG?=
 =?us-ascii?Q?W3yeDMxSYqeBJMOVe6TDE3LGCNEh+t881a+/+s1gfyn7yWESksAKhz5TNE2l?=
 =?us-ascii?Q?qMqkaN7zHS71MEX55zHiNQewHXE/+J6/Y9lC3/6zvgfUKxNlFadExmUyLv9Y?=
 =?us-ascii?Q?chJcrNEb+Au9ba48x35zPzc4dgecAiYoFwtXpiqiLgOrJwJGrIKby+EIsEng?=
 =?us-ascii?Q?Q9cpJdSFxi/AVn4HeMOqyGLAUZ75r1ZJSYGvzT+/jpMkCokZ322MTxFDurt+?=
 =?us-ascii?Q?4Ut+TmUppJuqEcXM4xAKSFAIyril8exoVl3SMk0dHMMVPivj0RXsF6VlVJwd?=
 =?us-ascii?Q?6cDnHwNDJTnex6O4p9x6CyEVhLY93pRhFUcMAgzZ2M7mPkCjZz3BGF6EXSJp?=
 =?us-ascii?Q?7m4CFISzGoThBMA/PHh06fvEi2o5sAZ1OyR2kVDshkMz21j2e+i9Z/XnSBLg?=
 =?us-ascii?Q?aACZV1gl5TnBBNntKTFoaMgucaClRK21lSIT6NSI0Rpp50QZemnUhIL86cV7?=
 =?us-ascii?Q?PW8jUgYTX2Q7z22bayfB7j4/9CXa9lyD7wMePdKC7x+yCbhEVtzeGYA6729N?=
 =?us-ascii?Q?Bq3Q+fV5cKI8Ki2gslxLiO12S9YLbaguTMsjdOyf+bUx9UtrTn+RpDNBy6oQ?=
 =?us-ascii?Q?fhPKLzFmLtWJ6Xhhq4jXmkGsEHq3Hc9Ego4viJPuwIAnuEpdhwKYDWCyGHcx?=
 =?us-ascii?Q?lx4fSVFLnBqIPrx2kPsoDI0WhAfB1yIRKRMemQGg+xN07Caby0rer32jHVLV?=
 =?us-ascii?Q?lOKimhYy07q1pqufKONq1wr7V932kXt7LAZ4jrrD2C2BgWGYkmawCV4vRrDq?=
 =?us-ascii?Q?+IYMmZhxgbhM95lKBGRYu30VOo676PmElEzoafcD+nK5lHHCj3OOfpmpiZpW?=
 =?us-ascii?Q?0a1TiSJ5+ebOuYo/QFMLNdBaocvUW9LlloYOI6lQT0m316yrOnJ2zkqpaDE8?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?C1ItbLP2icFLh7VZhIWV4NFyxFTcasig1X104q/ped0adaSt6GrxGGXsfaRG?=
 =?us-ascii?Q?D8bSiCI9XYgdBOyisbM626kG5UZNQmdWqlWFUAdFNYW/3WPX2T5sgVvYAwA9?=
 =?us-ascii?Q?wKIgSGEzHuM5bSpoQ0ytZKEflPLwxXjPyW35MIpMI+RQSsms/pEYRKWnolwS?=
 =?us-ascii?Q?dQwkE3pzg/xqzsOa+gnG2FbKmcmYsnfjHP1NtOLxCtIpbSm0qMMhAMvO8vjn?=
 =?us-ascii?Q?ukiR5OJFnS/X2RhOqDbrIYgQQyl8l8y2cX3boGJGZfuWJhYuCL6L8yT0tq+Y?=
 =?us-ascii?Q?ogWdO/v+gNHLjuIZzGA/r6hFiWTURI+2UKUh4QfOmg92wdftBNdRmCaVaVz4?=
 =?us-ascii?Q?SwPH5rlLMvyoX1UjlZLFmHH1dzqUitaIEJHK/TajPWhN47kWmThSPtphDdrN?=
 =?us-ascii?Q?7qwcAVgq9/S64DaI1wXrDBLznX5M59U/092kuRSAopJ43BfWHkCXtm/2Rbh3?=
 =?us-ascii?Q?VxSfPOJG3IstNfMw7D06f9tv29l7GXkvHsMl6IQTRcNbLRkMikIOVKgFYPmJ?=
 =?us-ascii?Q?adIGkv3fUYMj9JsC4LEHQ0wIBnn9XR8BUJpoiHk0f2Wi4iaMrF6pA12KXAsD?=
 =?us-ascii?Q?SrgRVE3Vuh8DD1OdGake/GcbBxAuaWzJ5KaIOCxL5YO7LP0QnA6glhK+bzw/?=
 =?us-ascii?Q?0Wr0M4G2H4AwtEGgmQUFjugt4G20rhOsUtETKg7bPhxkUuXo9aKoRaV/t3sl?=
 =?us-ascii?Q?qg7tWZVYjzL7Wf51Gr9Pqi5LMiipiptsWa5d4rutQnJgGqMezrm9+sahtRM2?=
 =?us-ascii?Q?vcOhiX6rYuG1iZlUVw5qtvVtPcC611yzelmgVXM6Cb0sPmwzBuFoxdhLcMrc?=
 =?us-ascii?Q?uo8zS/XlEp0SGyGyzHY1/eFD8B7LYhnW4Pg0ceWlu1xgCDJaoahtoLoZKa+5?=
 =?us-ascii?Q?iQI5KHkJ3lY3AcrtO/jv//XHSsOgXd8V8AZ20q0qJ9LPNDr3YlzoNvcv3Dud?=
 =?us-ascii?Q?8ziENFd6SHRY40Z0wBN3oA7haYZs5a0tTMhogwUD1mJTf93mthVS5OKaER32?=
 =?us-ascii?Q?nPujC1efnSvSERhpWmtiTkL+j8fqpKB1CZj+HC/chRb4jMgTGnMCa/njksMS?=
 =?us-ascii?Q?cCAakqm6jyhpOFDxn96NymgYmRR4uIZps/ppHjHgGPSKMdVafzgWMUTbvmkJ?=
 =?us-ascii?Q?dpjDRE3GGoBpnzsjoX0gpMU7W34UkXJbqNEVA5O9PT+iNko3B0YxK2ZH5SYB?=
 =?us-ascii?Q?WTf3SU2DX5IG3z76R/V8rjljkWua4mrxjEr4bPDqCJI5a6kX/8LI9OuCBut2?=
 =?us-ascii?Q?7npROhmlivrL96VSAxHs7efaPytvuG0E2YNCs71ANmK/tRENU1OlWjt/Zl2v?=
 =?us-ascii?Q?1GeUWvRfKB4ek+XTV5CXVoPaX8zGSIDrl19/NAL5NSaONLn7P0mL5N/pCzj5?=
 =?us-ascii?Q?kjNSB5ncPdD3foRx+FomFdzzVSqkLpBCh60TyuhN6ZP4tt1AyBGnXwfEguYr?=
 =?us-ascii?Q?wmgSlueHoWJvapKuR5b5yzFo0TovV226TlQC6ab9kPTKhwpHv267dIXsv5Jw?=
 =?us-ascii?Q?NFZN5HEO98m6W9Z9mtkXtIC0wqHdRjy73FKzRO8jZxFm8lgwVeZAyOxYTA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64a4c84-2a99-4663-0218-08dbdfdce3f0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:01.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjfXn2mpkJGCUE+jZiUIWmWDqbRJ6NDOPlNNSo4Fi6JuqdsFhIiyBqomRkrmKPMr8yGa0SavMAOIpT6AbLsKNza5a1KaAzM1OXx3Ytog02A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: J5fkcx4Vl6lfchMmOAheXQL5eqLEplXR
X-Proofpoint-ORIG-GUID: J5fkcx4Vl6lfchMmOAheXQL5eqLEplXR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this commit is badly broken. Only here for discussion.

Configurations with ARCH_NO_PREEMPT support preempt_count, but might
not be tested well enough under PREEMPTION to support it might not
be demarcating the necessary non-preemptible sections.

One way to handle this is by limiting them to PREEMPT_NONE mode, not
doing any tick enforcement and limiting preemption to happen only at
user boundary.

Unfortunately, this is only a partial solution because eager
rescheduling could still happen (say, due to RCU wanting an
expedited quiescent period.) And, because we do not trust the
preempt_count accounting, this would mean preemption inside an
unmarked critical section.

I suppose we could disable that (say by selecting PREEMPTION=n),
but then the only avenue for driving scheduling between kernel
contexts (when there is no ongoing userspace work) would be
explicit calls to schedule().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c     | 12 ++++++++++--
 kernel/sched/features.h |  7 +++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3fa78e8afb7d..bf5df2b866df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1059,6 +1059,14 @@ void __resched_curr(struct rq *rq, resched_t rs)
 		trace_sched_wake_idle_without_ipi(cpu);
 }
 
+#ifndef CONFIG_ARCH_NO_PREEMPT
+#define force_preempt() sched_feat(FORCE_PREEMPT)
+#define preempt_priority() sched_feat(PREEMPT_PRIORITY)
+#else
+#define force_preempt() false
+#define preempt_priority() false
+#endif
+
 /*
  * resched_curr - mark rq's current task 'to be rescheduled' eagerly
  * or lazily according to the current policy.
@@ -1084,7 +1092,7 @@ void resched_curr(struct rq *rq, bool above)
 	resched_t rs = RESCHED_lazy;
 	int context;
 
-	if (sched_feat(FORCE_PREEMPT) ||
+	if (force_preempt() ||
 	    (rq->curr->sched_class == &idle_sched_class)) {
 		rs = RESCHED_eager;
 		goto resched;
@@ -1115,7 +1123,7 @@ void resched_curr(struct rq *rq, bool above)
 		goto resched;
 	}
 
-	if (sched_feat(PREEMPT_PRIORITY) && above)
+	if (preempt_priority() && above)
 		rs = RESCHED_eager;
 
 resched:
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 9bf30732b03f..2575d018b181 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,6 +90,12 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
 
+#ifndef CONFIG_ARCH_NO_PREEMPT
+/*
+ * Architectures with CONFIG_ARCH_NO_PREEMPT cannot safely preempt.
+ * So even though they enable CONFIG_PREEMPTION, they never have the
+ * option to dynamically switch preemption models.
+ */
 #if defined(CONFIG_PREEMPT)
 SCHED_FEAT(FORCE_PREEMPT, true)
 SCHED_FEAT(PREEMPT_PRIORITY, true)
@@ -100,3 +106,4 @@ SCHED_FEAT(PREEMPT_PRIORITY, true)
 SCHED_FEAT(FORCE_PREEMPT, false)
 SCHED_FEAT(PREEMPT_PRIORITY, false)
 #endif
+#endif
-- 
2.31.1

