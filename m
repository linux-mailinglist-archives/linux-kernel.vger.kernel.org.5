Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D27E4FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKHFBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:01:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B813A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 21:01:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJm2J000897;
        Wed, 8 Nov 2023 04:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vBoxiu66tbBBb3RQjriH+Rf46F1A9j0SyUIDTk6/WuI=;
 b=JGCLP1OCcMldHmBPsCkeCjMb6eRJjUs3Zyc6ey0VhiqglJ6W62ruN3dUlJ/bd8McoW/y
 JDmZEvw7/EHwmG/9CPu0vsm9rQYeCV97HXlEdQZjHMdCn9ShbdNaUxnfovBHCf75dsUp
 R+HXKWq9LVvTKMEF1nVQB6rZaObD94kDmjoZ9jEa1wCSg95uTMij3Ek/Jsa27b9YbvbE
 Yo1XcUK/NvoQ7UrRsRtXd8g4EOgBMiu2V77nn/c2Bw9fqXiQUPvCiuzSBn9v7zLaZm3j
 e6xSSkfAyeiiAnS68z1bNi4VohGYSiW0vAdSnv4v2QEJ0Kigus1RBekc+gwnPcMWsbmT 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23gju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 04:59:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A842We9000644;
        Wed, 8 Nov 2023 04:59:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vp1ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 04:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+X1BN3dPZhKw9zbgcaLtleS0/0OFNKdzkffVDaD4m8Qzr6eypsMROLzvfnraz1RXrcd/bw5lC9xK93Cry++rOr8NxLCBKLArKS91xKT1THjIes1ZVuwvW8spJXc4aNZWTc5UA2ut98pUsYbdxBRqLN5bSYotijHYrbTA4uQpK7BQ1NjECGEGqGp8qiVg5k1qmyLS2g9hAmdW4mM+qdv4bdjxiPG9Qbz9GwI9BxBNO4y85FYLirVyrrW6xzkd34tZBTwNbAKBmt1Cc3ypjiE9MAFAnTNUE3cI/8h5NyghNQo6twsoVjr6L6TafamO8ZBYKX3j5By6bf7gqFd9LSjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBoxiu66tbBBb3RQjriH+Rf46F1A9j0SyUIDTk6/WuI=;
 b=PVThb63XQTi9SaByaQFwG0sgU97HTQIJEq1hj54HduXKBLA+48+pXGUVxLdSvW3bho8xloRGytxlEzfeQ2LFpKdx8frJeNrE0y8nei504jkKfdv2PoOxuUviRJ3ycfbCxnLT7iI6unQtINnze7I2Dxf0h4zStDhj9+2ZuZLyf7OFqqfwe1ggFPzknYwx1zfkGBPlpLH2ze56Pg/+bk5dODGnNTwJRY6GkDNFOYLX1YWRk9nBe8PPdXnf2k75fs0BTDTdz9Wy1lwu2nEWNiEJ1tcOpBmDPHdStq4yEbBYSk44leGACNXker/Jdd90wkmSYJ/VxaIYecwRFjxYQvrFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBoxiu66tbBBb3RQjriH+Rf46F1A9j0SyUIDTk6/WuI=;
 b=vn+3wLDPZpzZcuLNunHmUQJL4afsG0ueYKuqpgwzC11n4dn2orgpZt9YdnXxwmKPQNeSPpCf3bg9oJyVq4lBNpDh3ko9sg+z403lE91dbi8ZJm5uQq5AoPzzdid/zvqt73VZyJKdTzDZ/C2k9FBOf9Hf7tSZ3p9DcSSN6ODJn5g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 04:59:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 04:59:42 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-5-ankur.a.arora@oracle.com>
 <20231107181232.26dcdf61@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 04/86] Revert "preempt/dynamic: Introduce preemption
 model accessors"
In-reply-to: <20231107181232.26dcdf61@gandalf.local.home>
Date:   Tue, 07 Nov 2023 20:59:39 -0800
Message-ID: <87ttpwu9fo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a3136c-488d-4b4b-9d4f-08dbe01784ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVzg0OX6dtPYRtMBT+fpDde5kzEl37v/vVZ8mmRTdZ1WTCE4Ap5WU2CLqDABoampPG5elxNYlUY24UnY6fpyuSY2OP9DJMHkP6rV16tZaDitx2D9aUijPJ3d52FaaYBPh64ALc1qDWkqXaPHI7X4L3QiRO/LwjA8l6LBVLR8al/UkmflFfuUqCeV3gkUZC34RHB0Ppji+iVa7FTZP2V4Lf6h5iy5rVfyLmP/LnRmYJ9is04nfAe1LBB6zHvTxt3ZqiA6VzZkWjZB00tb+2ifDPDpXU9olNvesyPyJgZW3EAofL215xIMpdyWvHdeDi/GHH4U4I5yZKWVH7qlnI2oovo/tvdaGkqu3PGMi6wexWOo0Yt9XQdOe7nW4Ey3fSB+WXHdxYp7iKlay0mpHLxdveUq4BkPcR3xQGEZuItN5v6ygiQsHAu0TIJ5fLzwL2hHFpCbDVREacGBrNZlxxelBjZfKfygpKLjs7PN6Mg0dnrVan2kTUFS1e/8uF9rvHkYc4vB4a9nAu6ZzUX0uXwoMhppEYwrqOH90+sr0OeDW2TWeOEOOIR4s2ffZldEvG/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(6916009)(316002)(38100700002)(478600001)(6506007)(6666004)(6486002)(66946007)(6512007)(66476007)(66556008)(2616005)(26005)(7416002)(7406005)(5660300002)(8676002)(4744005)(41300700001)(36756003)(86362001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjzv0K3g43XsstpH7ugy5TUxPQTsNmdwFuyl3zkTpz+iV4XhXVXgD3gFWegM?=
 =?us-ascii?Q?PsQrBtNFeoagtloesG78b1Uw19VRa67nKXX/9rbW+OvVlxXC7pI+VCIjem7a?=
 =?us-ascii?Q?/8DDspTiqWlxLnvU+bHRUzYrtCGUCv0TOfhCrxGXj1Qx1bFJCuw4zot7HgNL?=
 =?us-ascii?Q?Dv3rZMmNJgaIYq7QeAnfWfhnDYrqeTds80s/LTCW2QF34iJbjiZQOK3nspBo?=
 =?us-ascii?Q?R0hJuE3TZvuu8upIN6NlMK0oibTt5jb5MAbhG6H57NnKd2HZN6kPszcnUy8w?=
 =?us-ascii?Q?hrvk02nUcALOpSJR2u3DcaNenkSYUY9UNhGHPTYIlxAvXtvocdQhhKPQQ/gQ?=
 =?us-ascii?Q?nQSG/S8mQ5HHdZsM2KGz5fWj/JFafzHixzU1biBtAkD58R72FkGlDeAV5BSj?=
 =?us-ascii?Q?hVgy2L4klZ2U7lKLJaRbywUv0iaqsjM59D0hEgcGJ+SVQE0Krn2qZ2ZP5pOu?=
 =?us-ascii?Q?Lv93BOmN33w7uS+z851YgIlvLgYH7e8cVMx7Fywdf4AWOSECQdmG38ksaDCS?=
 =?us-ascii?Q?2GEHsFv5YhYX9Q6NG0IvhBuygfL3K1O2dXUyaNgeRA/aVeGXnTsMSEuErdHH?=
 =?us-ascii?Q?7hgSk2IX9/20mDhcQ5ZvyGm6aEND3s2HAsxNkc3zSJ7jt+y6/mgYgTEFpURu?=
 =?us-ascii?Q?9+6cDRNixDvNo1jRDoKg0pdmWcXhr/vegnu0hwN29UiNHbzxCbn8+H8vtNeR?=
 =?us-ascii?Q?2CcV76tnpMdvw6YO4YhfQJqzGotHzXPvjUu9lWn5an3o9MaVHUIGVQLpwOxF?=
 =?us-ascii?Q?VhMPkuevmjhNOvN+SjTqrSn49w9xWfB0Ubd6eG/HQQdJ/d7G44T4mZAybgdg?=
 =?us-ascii?Q?zHGLamg6EYn2JZiZ+GuX9DMYnx7sRn87bkMzsxMzd4hfNn294fSA9VqzlS3+?=
 =?us-ascii?Q?WHApept/2sXYwDhSBtDG5hUiIoUYuGFS6XTwt45/3KpMuGM+jSQsjqjUQpBC?=
 =?us-ascii?Q?ZN9AXzZvoOOjqL5M8SuCrvRZ/QLT6ywk4LdSSMle7pQzosJwbsX/CE6NJW5O?=
 =?us-ascii?Q?g+h9JCMo+Or2g4yT57+V12zt1xT9ljBp9nUzn8CHYU13BhIKvgH0bQNKrmhH?=
 =?us-ascii?Q?272QlUszN9g9FE1EP4jrRuMpe9ucrRRj1+ojEVxenVlEu7+l0WWOHqD2B9oZ?=
 =?us-ascii?Q?9i8xDjUbenM8iQr33X0aO+/7lfdqvWUsf8y9LXXeoDMo+2SrMe9ECCjqyood?=
 =?us-ascii?Q?mcev9VjPqCZT1VPlJ1iILmnuSnEaW+YiklRbk+gnnp1w0eoFpnRaVE+iA63k?=
 =?us-ascii?Q?vJAT5YLcYjCjPHDq+sRcyMRu+4gsJ0pi7eWKnOkCwEYQ+XeqoYlB88g65plQ?=
 =?us-ascii?Q?YIhp5Z6Xqe5T74lW1I+A1Y70C1c0vqQXoV2h5Y9Zj6YFlQt8YIqGvDXCs0Fu?=
 =?us-ascii?Q?lBj5URNCd6KINyGDAVHeK/WPR/WboGmJ9f2RhnO6Y5rsCR+YJt0F3QIr/w7J?=
 =?us-ascii?Q?zecnyz3TIvs+6KmRt3+VzYMHk4BI6dpR9ZSvEb2Phgm2Nkd2EkQoQhVWhJA5?=
 =?us-ascii?Q?k4ChQf1rttzxVP2IwUYvk20u3oVGgaLK7rGIpTK9FEgTEouCt/G2RMDea6jH?=
 =?us-ascii?Q?R54z3OV39Y9t2ACuPBBD3dZDlS34vXrsxHp2Bfs3V8O/NmbdEZTezLKlJU2I?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dBYWfVgfZu8yJ0k9qSbbC3UlpcIeE2CMFeGa1np1ESieZOW3V3Mi6JvlRVpe?=
 =?us-ascii?Q?+aDa989GCF5dx4EQmx1E26LpLF4uFlT7zV1S80ry1b+kXqYSKuXaaYyM6wDW?=
 =?us-ascii?Q?ySj9EGx88Y+tKJL6D+361ezaRT+eCauBjYBmB0ViebeyzQX6F/AsmSLakeUL?=
 =?us-ascii?Q?JTLx6qnv+g3HbZsigjBLepgmD2rBzbag0TciXbvRyxBgLz6A7r4ftgD1YKUS?=
 =?us-ascii?Q?/wvVYLHyltbzWhhZTfK1Yf3k9s6BUt2h1otiVBOEFQR5tHFK5srz49HvH60H?=
 =?us-ascii?Q?cRt1AhC/yg7cLG0rISyv3ZhVzsXULOqz4hduF+N3YXxocfsnIi2VVz6Pmfr5?=
 =?us-ascii?Q?4y5jwqDnU8gackQykpml2ht77VG8VmeTGJ8P6LeWwH4imQBrYbBQfAu1S5Ig?=
 =?us-ascii?Q?WUAbNVUM3hpGHMAAkwYz3jlj66xUSprVHQHgKW7780KjT1AJZhPhWBl1pQyT?=
 =?us-ascii?Q?gizziwdLfyXXjodMluESFxBDrht8rcKauEuPWrt/z1euD0a8fuHxirHxw8wI?=
 =?us-ascii?Q?GYFdlEbE7ftNeOj9OTETrcTW0nZSabgWTgziVu0ZAEb8IopJIe9bF0mkkA1V?=
 =?us-ascii?Q?oU2heQyj7mhtiC9XVEko5J9Wi8T3OiOOZXTUJRgD0k3M5mKbZJi2gS/f2elD?=
 =?us-ascii?Q?Bwy/QXpdQ/wFk3Nt2GF4uXtB0MXp1q1lMcK882MrGRut1I4vHSiDyn1uR5iP?=
 =?us-ascii?Q?Q+MYyJxxifb/Hs0D2PCz6yi2wjnB197aQHQz14wcPf6mG8nbOmjmbVTKNHkK?=
 =?us-ascii?Q?5DApNTWxJHauqyhWSdgBpFWdwo17gqTQelXz41PCDRqpTVDFaGo1OgbkANXr?=
 =?us-ascii?Q?UbBJQOqvBWpxcTSR9/qex6NFC9QEI+cVNW04tgONZMfa/yj9Ki/eLZZeAv/w?=
 =?us-ascii?Q?Sk47mKnvA3i9w2JZHJpmn1KG8gLAvSrI2Nuz+m4Ljw7ZtDgOiu65LNDLxjtP?=
 =?us-ascii?Q?GtSoihlql1PFiBlTS0ixVKGNlnsiwfxM71aIHSp4/14F9UzESytIlL2Ei5Us?=
 =?us-ascii?Q?tuUqd+/7E1ILy670N7Rj4gu2TzDeafvJjlIjYYBrtXSU0K59/0vimgqmzlkN?=
 =?us-ascii?Q?PlAi4ZBol2lalbuUoLkT52vp7l6SjRF6MZX/doEdxDYKx2TFXVLAklJCex+/?=
 =?us-ascii?Q?Q0mTJjGuPAyLr8ukMMgIeG+EtD02HvXrFKut6jKx44bgM+lzAAZaZfMJdJnl?=
 =?us-ascii?Q?hkYOfXK0lSI+smavMbyxnMcFFce20WmYsuJn1q2kGEKIWZ8CXIwhjI3SuBlQ?=
 =?us-ascii?Q?57NE/OBgZ5Myz625di3iDWz1A+ytTPKQZluVWr3U9E8xQFuYYfiqiKkQ6dgF?=
 =?us-ascii?Q?a+PiQlH63aA3cC92WZeMXnxgVdnZ+EDZUSEyliiX5gDHXeaWx9ppwpzs8Bci?=
 =?us-ascii?Q?oIPwv2lCcWbQUBWbqcGYdbDicH0SRQVH7cvS/Ma993f5ykHSamvK2Pcwn6io?=
 =?us-ascii?Q?o0AlcDquCoQQGrsITK2QNxHBIxASAE0whaul+mV0WS3ggOjUU5Y3EAD4BTEL?=
 =?us-ascii?Q?QANwU4eVNm8/wwD6wnGp7ra6tcs1GEadb1SFMroomNGuC6BcAqqzJlFmIQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a3136c-488d-4b4b-9d4f-08dbe01784ce
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:59:42.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW12bdGWtYsx5oB29ltWvS0S4C0pGbht8IxwNuNDvFH+1oVHZqZcuulM7TyExCeKag5yGk7xjzx1UFpqwybygtQTRcfzg5RgbS5+y9GCnbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080039
X-Proofpoint-ORIG-GUID: 33g7lbq0W6_oFGScoVXpgzwL9DwOjh32
X-Proofpoint-GUID: 33g7lbq0W6_oFGScoVXpgzwL9DwOjh32
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue,  7 Nov 2023 13:56:50 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> I know this is an RFC but I'll state it here just so that it is stated. All
> reverts need a change log description to why a revert happened, even if you
> are just cut and pasting the reason for every commit. That's because git
> commits need to be stand alone and not depend on information in other git
> commit change logs.

Ack. I will also take your suggestion in the other email and remove the
relevant code instead. Reverting is clearly the wrong mechanism for this.

And thanks for helping me with all of the process related issues.
Appreciate it.

--
ankur
