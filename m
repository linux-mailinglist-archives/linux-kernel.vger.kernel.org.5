Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4537E4B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKGWCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjKGWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05A2716
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:09 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLxi004012;
        Tue, 7 Nov 2023 21:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Bp892IXAzjBLR0DQyAUn8HlW3wzNjHwX15Uo1+fXI/I=;
 b=Z9k+9GKztTxdms7lILm0Xab+vSoo0ZT0XxQX4lUFbyNj49Eu+9tfvXqG503MjvRLitfn
 btESfsxF4ox2f3L7Hf596k0ix89tp1zr9GnMjgptXo41FwBLHBDSQTyZYqeFjAEyV+jt
 cE+P1RUKtZcq5gLynarzQZFoxNNwn8QWy2BdBfYkjzA/nRSjcq/NbPnbhURsGu6A5YTl
 Ru7T3GjyYmmR+Cg6aFRQpNzFvJKhcUlYRlIqzUjUYDatyJLlDZNFXOtv4okwsYPpqOsQ
 LPrmoE0HjY7ckpzpHdDRU7tMg6XvjaGL0XJhkl9VoFvQbd8UZoPYENtR+1Y4IGpmJkIq bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIigG011238;
        Tue, 7 Nov 2023 21:59:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsj3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd7tE8WqtNsFKY4zYiIQg2sH2GTc4L5S4aFTfjT+T36RM1Z2F6MhxYFnJ16WOTOW7BOTOHgudD8OBADty722b/MyfrGka/folfgbTzuMk+4DtJg9wb6odojwXGeHZRl5bz6eBh+2KDM3Rw6y1b/ltm9fSkDYG4uZh0S5F6s/zHN6pTc48yoI6TVrX3ryn06PXlX6mQPoRduQfPPSJYLyrLapIoKHx565DHfNlytxHFPBMk3covnnq6yMo24WaGIAh3J2PKumkyvl4J4xNSw9veGvd9hdOwigmT1gcUOnWiiqj9XvKxzMIKYyMxXHGJsKih1s+4qm1ydKQhDtTIg3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp892IXAzjBLR0DQyAUn8HlW3wzNjHwX15Uo1+fXI/I=;
 b=mdp+0V1Elr1h2xzKaq4T3McgRjCrCE4NC0tzdV21Oc21jMXXWwuyScUlm5TGY7fQh/ck18I4c6Oihk4PB1hQJGQrtokMOj7SvgLLF3J22L1W5yGMMJvBf0VmrDqS+ztd/uI9V9OkYUVz3iQnfwEiOH1IYj2TU8z8Xq1UD7RVa5i/auxfs8GezwaeqYRdr10tG+JXeyi2vpnafj4GQHduLGMGAijN4DRqZGnuZ34p941TnWCaaR+rvJiyRyUBc34L9iqxLsZO/62//MGjviz6GwFzFpnFvn2eo771QOeVJReLSgSyTJpfCyrdsOWJaKeYnSqUAfq82OAOMskWNxJh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp892IXAzjBLR0DQyAUn8HlW3wzNjHwX15Uo1+fXI/I=;
 b=N6AE6kKbk1j1XbsnxGy0TqSh23/Hy917dT/JeMOqxCRHkIMih14Ar26xs8Vz4La5K//2pT/mb9cgH8oopADHxMk8f0Ewwovb8QwyOgT711HbwVbZkHkn94XpY1Xo7x1Reuf8a6AcdAYI//2fu4FQAG7SXXZD/Co1TCEePgaXW2w=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:07 +0000
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
Subject: [RFC PATCH 28/86] Revert "preempt/dynamic: Provide preempt_schedule[_notrace]() static calls"
Date:   Tue,  7 Nov 2023 13:57:14 -0800
Message-Id: <20231107215742.363031-29-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:303:8e::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 1490ac5a-95b9-40e9-962f-08dbdfdcc409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hxn2yiOmt/hPu6r3P/um9j8+GVr+qin6/dOCs8uYxiMcPul4ig6i9Gk9Y76is2z1bDfXgU6aVqWuLDCdSXM8CeDA7luFd5fTnV5RW/XZ5e62m5fivTR6u8WfxDQhLB0ZLUa4Qb4749JNoSWKyjramCARBS58gUsSpSUVPA8v1cZu95i59lrCCZqjVLDb3itY72/3Ck5yWsztGICP3Ofgozyju/LwxH59rV689JvdG0/gdRUKQ7IVK8yzmJZ1J3jBu60MElnr5B3JP0Th+rNKaETc3EU0+FOrh8MZJYeinm1mOOvxM48lx6dNyzkwOfE5IXDItEoTr+y2sLlOBR4eZKFwTizNhOIuiipJvyQx5OjSS6HTivjc5fwzANDr/BSJxe2iGvckhwf9pLIGXoY+rhNjv1AczmLvewdaXATu64JuWSb2NCh2MWXgUGw9eOute7nMLz9YErf3zwYDLtCvPfG7YLZ8hbZp5Xp2CJbndqKNtjKguMnzDHDGdqEWBNDCCJcQ+kuetdWCVi78abrt0l8F1+AzYs4poZgA6DQzyJvdfJBFTgYLMjNM6i41MkVZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFCXfyORtFA7XB1Za8lqLdKHZSoa3IKgQoYWwn095hVgDAm4DdGM5aPTWbrx?=
 =?us-ascii?Q?xgOz0WqPkWOBPjMspz31MZFD65tEdg0khPIpV8ei62jLPyzBJK+Df2IKcdWd?=
 =?us-ascii?Q?WJ+Wym3H+/ewfiJYjjahTf+EU147UKMmI/Vi40pvsrXNlJRafsiJajUBZjHk?=
 =?us-ascii?Q?S63ejRlNypd2ch2b4gQXUhaxdPxqgpu+vjROsI6KWqaMrksj3XXuIrrTHF2F?=
 =?us-ascii?Q?jB0J8zmB1FkLb3//0Wjy2Jq+0tOXxfFwnMmtFl9fBGDMBxXpVgzFt5NV14gk?=
 =?us-ascii?Q?Nts45vG8IES26wYmC6R7aeO0F0tYFt4WaWq9srjmTgicFnU7F0NmrOs0zldf?=
 =?us-ascii?Q?fQCkLMEkkzJKBITOZ3KN8fhBFj1IS2ZsmTyPRJLtGbzvbm8RopiFykBTXRCq?=
 =?us-ascii?Q?SVMyJHqrXQ/8LSQ1cNnwfRLqGh34Zy0vffRGOteBmGzrDleC54CQQoEJZslD?=
 =?us-ascii?Q?D439p4eFTLkaOovbkzgavCJrCUnAqNmo0Rb91Dg4OJ3X50e/5oopSROFJ4kq?=
 =?us-ascii?Q?xe5KxWHlRehtC2Hcq7eeo1NacA30n7BIsCw/tBjZAzBX0YYKlmo5XQm4MXDM?=
 =?us-ascii?Q?I9sTmbWCfjK77kFtOHyAKb3BaHQgKbZgWMXxM86eOimGpAK3yuweyob3JQ86?=
 =?us-ascii?Q?lmixttOKFnIK9+BD/zs5jkxWEv1h9L+zPc5Lbr11jCN8+JYpkEdft3qRPq8Q?=
 =?us-ascii?Q?KnZgNFlwyRO7FftzAm8MkYL74ZQzxGRk28Q6PD9e9Pfek5c88yYUyBxEokAJ?=
 =?us-ascii?Q?snJ424YJ5CtsI30FhcurxMnJxa4b+P5jgzelVgC7iPpTEhvGcF9MdkH/6NQ6?=
 =?us-ascii?Q?eE0WIVoCO1/H8DY4gV71U1oPbMQQmLZFDVbjwPPHA3P6o820Je3sRnCwGWlb?=
 =?us-ascii?Q?z2fF7WEfF+DEE0bX6GhWZsMm7ayf2HTcDKbGwwh+0Dpg9uyC0ISLn/YCRZFj?=
 =?us-ascii?Q?659bOPIUfokZypMdakmCh2LAKWsONJYVMcbvlAxtRX5ryLu0B78AAYdjD73V?=
 =?us-ascii?Q?+fCcE56xlgrMUm3Wis9Gupmz5qQoph24hE3HOhuUW36QsF2zGIoCdI1VnYIK?=
 =?us-ascii?Q?VbFqgmeSIQpv1eWXF3oMnMEclylwq6k41SPwE5CsY5JCmO2c8UI/o/FQpAVo?=
 =?us-ascii?Q?BGEGEYPguHprbiEN8de3ELG8TGkfNGUNlWjSQdgoJarzeb0o+gBjaBbR6t76?=
 =?us-ascii?Q?rsNbokwyGgVmNdqkAzCcHuI5una4KFAR/L9sgnPl8s3ubC3GznPz3dDLCoph?=
 =?us-ascii?Q?+eENsF+RJV0vklT9dT8PkzkboACJNUVrEm6gP6CoMux+2Z8zjNc/UUV5aIK9?=
 =?us-ascii?Q?hKKrgKvJ9lRj7hjCXRWvf9FS9ZJ4YS71XA66tjnPpziSIzJUgW7sea4OXYbO?=
 =?us-ascii?Q?ws77DFeieZh4SWUF+p4gCyoYsazROH9SckuNhoLN63PYS1viQFS2BxU6+vZt?=
 =?us-ascii?Q?8/6jQ+D7nX0KYMI8v6KRuUo8+HZlpibPYpgVZ54yo8Iy31cCTLW2uYc6gJxy?=
 =?us-ascii?Q?Yn26w/6LBpmPle39F2f50ygZ/CqE3+ft0m9fgh42DZX0816zBrinwok1M0LE?=
 =?us-ascii?Q?q2UrlefD2WMLPvU2Owi6wG8J/+qTLVnM4YY5O9SZ3KbmjEnu3eMoPQ8p5eY0?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eUJU01nQv9gtoW15o2vVOLWO7xOzWYiT43o6fAmLJVY0ZMcUq2LCQ8+6W7O+?=
 =?us-ascii?Q?v12m+3BJ1/TW0JxteQwbdIp4dezYbAvLhshvNGvk5X27bfnCbEX4iEPwYzWt?=
 =?us-ascii?Q?y/gxAUAQgZCDYKYQFxjrRD+CWJxSpby71bfivBjCBvuiVKNfHWhYQZ9jVdXA?=
 =?us-ascii?Q?U/U0070hVQamvo63ktumK5eX4E1p+Fu3RRkEAAJW5CYncuZr6v7wmWosUrZZ?=
 =?us-ascii?Q?43KVPQ6CNzXqK+F9e04+Ma0OlP2MS5ufa/N7rnWj8e498vaJBf4GEv/WxeXv?=
 =?us-ascii?Q?hWV2kebO1QevJDu3Djj2LGkiFiD57mWF5wSdmjrCAMdqIxOIjGUXQCnMHU+d?=
 =?us-ascii?Q?ODQ67HoWmIvw/YIa6DZ8aopIWdFLvdulwwKhvwR8LZsCxbQ95rqoFXn9LDFf?=
 =?us-ascii?Q?Rzxf09PaTfY4vKV7DRpV+0sMyRAiq8yTqBpXx6xRiEFb/sCaiM2dLgsiTdkI?=
 =?us-ascii?Q?3ftrRyk9GadVHibE9ImJxcRP+SBWAJxXn6kZA3vkuMbHBAOaePLWujX+xaMa?=
 =?us-ascii?Q?yr5uQfXsEpJvGZ4Rs0ORMTI4uLYslAu1G9XvwGKzgwZYWlLaW1krQIUp/0sm?=
 =?us-ascii?Q?Hhcbncno3NevctRFK/H0SyW0IOFNTj+S5g9A2UpNO2SFpyPa4C0xToHVtGuY?=
 =?us-ascii?Q?irwWm2YwXNH1F+jfoyiq69KhKszIrnhu4Q/NTxbQJPLAnKI6xZyy07Xeq0lV?=
 =?us-ascii?Q?PVOkCKk4rHIXknqiBx0OH6cqXM4bdRWovUSfO217LOmVqiAo3MvJcU2tkHqW?=
 =?us-ascii?Q?3oEP+NjynAaBOPbMFzQBhvAmwAALvftnWOKD9j6GTlaLGF/+oqEaqCMlG6Ec?=
 =?us-ascii?Q?AF3nMBH55etnDz0SLteN/Y7FX3HXCYIp/SAZFBwhfAT5VYAINcJqm2SbffUT?=
 =?us-ascii?Q?Mf/nzI1QBJbUSNewg+Ff26K2qn6nEoxhfmYFKSuIFbVavDA5H70T6gPFyU2Q?=
 =?us-ascii?Q?XWpCLYE7cIyh/mawQv0o4XTVBehtiZxUm96hwfzWkZx54qvnYYY9XtFMQQ7z?=
 =?us-ascii?Q?bgSu1kGtGFO309YN8kTTDzkovQK46Zby+SjhV7mHfuRLNkTAeaVf5AapSVjC?=
 =?us-ascii?Q?zJQYk+Bp+H3bwUQTvyrEn3phDx4o0nU9BztT1ouFTrf8qpIx4Cg2Um4ApCNl?=
 =?us-ascii?Q?C1yI+7sTlSj//4MhJcN3SRoa52ikFbqhd2oyEgE4/4vOwEFEc4LdBYUVI3yp?=
 =?us-ascii?Q?sunlco18Lp2h15mLrACE8gELJFwIFrFp9Zph5fzSxz79Mj39479/1NQ7JDL6?=
 =?us-ascii?Q?s+PhmY46U4R7Nfc3nn7NDS5yO2Ocxeok+2ZK6fPzKSgq0wIrLiUr/OrlBnvF?=
 =?us-ascii?Q?A0ARXEXN9FmJCRJNDTdMfbR7CvmsPpJotfVf6Ek4F7XLnZz1tLfUljEkdK/N?=
 =?us-ascii?Q?n3KHShyuSFppOVnJfUgEV9bjxHMB8zWYl3Yv9aUqRFXIqhT7b+zp5BpFvv1C?=
 =?us-ascii?Q?sK9cABwqpUuB5KZn8SHZ6ecpB77Y3hfkFxNJJcBxaT0JFZli9QrTKeyD6X63?=
 =?us-ascii?Q?B9nWNNeFE0x4mNNc4jet8VW1MuNAgcBsjwjqbP7YIAvhe5YAA6qciDhxRw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1490ac5a-95b9-40e9-962f-08dbdfdcc409
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:07.9306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqlSgZUmtdtwxWaNIbSQB8Y3VJgxQbryh6tYiU3VtCDL7xIvHBEWqSLI//8CiAru+IyKhZDfsxjcyTOO3Eo9/j58W7oAAPzch8Jmq/cO4cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: WjmE0m0sxKLONv5w4u4IRmAWICWqNPf7
X-Proofpoint-ORIG-GUID: WjmE0m0sxKLONv5w4u4IRmAWICWqNPf7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2c9a98d3bc808717ab63ad928a2b568967775388.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/preempt.h | 34 ++++++++--------------------------
 kernel/sched/core.c            | 12 ------------
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 967879366d27..a7bbe15145a5 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -7,7 +7,6 @@
 #include <asm/current.h>
 
 #include <linux/thread_info.h>
-#include <linux/static_call_types.h>
 
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
@@ -105,33 +104,16 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+  extern asmlinkage void preempt_schedule_thunk(void);
+# define __preempt_schedule() \
+	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
 
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_thunk(void);
-
-#define __preempt_schedule_func preempt_schedule_thunk
-
-DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-
-#define __preempt_schedule() \
-do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
-} while (0)
-
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
-
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
-
-DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-
-#define __preempt_schedule_notrace() \
-do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
-} while (0)
+  extern asmlinkage void preempt_schedule(void);
+  extern asmlinkage void preempt_schedule_notrace_thunk(void);
+# define __preempt_schedule_notrace() \
+	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
 
+  extern asmlinkage void preempt_schedule_notrace(void);
 #endif
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51df0b62f519..2e191992109b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6891,12 +6891,6 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL(preempt_schedule);
-#endif
-
-
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -6949,12 +6943,6 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
-#endif
-
-
 #endif /* CONFIG_PREEMPTION */
 
 /*
-- 
2.31.1

