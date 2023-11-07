Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9777E4B78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbjKGWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjKGWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:05:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D33A9D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpwN026315;
        Tue, 7 Nov 2023 22:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Fh2jfFMWi/Wx6T4nUc+e9YCPx7n8xiF5wQKPn3yuv+o=;
 b=yqIc8staFCyKtM9TCU6GFSk/XyEYQHDQPGERku4U5eWDVEPgNXIE/y9uiiKIkk+nFNK0
 7haQYkKLXfNM+vDAgiU/nWtJ3hrD963/mcCszMQtPiLwfduRjpaApi/687KbPerBl5zz
 cZmKwopAaWH9fPW5BzsU/xZ6cdLsUM6nr6B0bC2eg8uxrYD4G0HYM7DvThmRXGlVMCp6
 mGTgvibLY0vyBr6bIxvvY6gj479p64OTA3BewIQDZDJX9dZ8MJtpYLXat2qNltK1EQLC
 fCWARl9622z42Y8kFIgnzSbZTnK8a5T0fTnhgUeRDi3Wkvt3Z3SAOXp0FDLyuE48pnVH cA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2102s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgSn011082;
        Tue, 7 Nov 2023 22:00:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsmhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQEtGTqYsZ2v0uORArpLZA0Giiy9SZPOIecS8JIYHA4cqF04RdmIKAq5M54H4jOf9T0vIbBzn6kwyWbaLW3TYbH3LzI0Pv0uz9xxEBdJePANRlYDvWRBp0U1n2cgTgq2xPi6Kwb9UVJRXzSStuIYA7yET8U2FT2dyGZhe/4rAaZPA94N3TqhoQhtEi1cj58YYt8a8GI6ZWY6vADOqQmAIlQjumXx0agZ5k6oiYuAWSkLxsURsZ2nkLTXntK+qnTgXbUYxDOVpLnFcKZZCYxVUwpL1iRbIfrdQge23J4dQZhP+8U+LskZLTS3jNbTJTyNmMX+YBQETiCuVnLJzgPc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh2jfFMWi/Wx6T4nUc+e9YCPx7n8xiF5wQKPn3yuv+o=;
 b=KRs6s66jD7OEccyL2OlLhFNyPkdHkHOnRlnUZREO60uMYH6EDYLgS7ill3//W4QkCG+/8Mn8dsEX0qjcKhNII+2uoXU4N5cI/kRmVbim8RtJPqhpJJk/wu4o/KqtE/xCPZ0UHvKTFcv1bF5RzbWAtNvoppSoKu3ns1D1xqN5v924JFlEgR3RufougL0ObNeqYqSuylrVm1RF38rk72a1jWBPTjilEGQpDbUI7T2eiYHcn9EP0Sq+9FH1aGhQOYqyi8a0+z/8+Ij0nw7uQ6OdKDb0md2wz1JkQv/KcHhBF8LzDTnkbLIk9P5yqDkQ5ch44S6lmd2HdzFj1286najADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh2jfFMWi/Wx6T4nUc+e9YCPx7n8xiF5wQKPn3yuv+o=;
 b=lr7II9E17eTjnYxaQTRgFplTkHs8Iz/XASzRsBW9EjgAugpAlyvnGFkXk6o08VjHvtR3kJukpeK6bzDUsr/4EavSHWEotbu61dTo5cMhfQFTbuRc1lVe7ZB7jOxBcNTjHQCeYP7xlg1JjpUDQeBB4aH8gVQ2LbvhVhPg/mwS4NY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 22:00:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:29 +0000
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
Subject: [RFC PATCH 54/86] sched: add cond_resched_stall()
Date:   Tue,  7 Nov 2023 13:57:40 -0800
Message-Id: <20231107215742.363031-55-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 57445321-6835-46a5-6834-08dbdfdcf460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/h1Z5xkCX6+hOYGEmNasiVqhRCqzjMlr3wkxRj5Db5HP9Pnyf92lK/vaCpQK3+r/NXagTM9w9Pkl4CcDu/hQr5AQeVkxLGa0Wah/Zcg8BF6tyAlhmjJ7vLdV8NbaA42gnZqsTQdbor5nCZiw7HFnhPD2tp4p1QaAm/2ViokimM7SwF+yGVBrFZylWTSEO/gNKWpEpU2DzE082vRuhZqvCcgxtDdasxJMreSGSaY6ms2f33fTUDnytHFDHScRG16wphCaXEqtP17n4WJT5Bq72c0gdogBQ3XhjHGNNEEz3C+koXXmxg0niL+DYnnazJXSj/BbbrzkEyF9RzIu+wwKDLZDHlqbDG0K+880InAhe7Fqx/oogmvWz7HrjrzTVBgca/ZRaP9LpNKrMk8W1dsbGT/2V6xp23b1Go0w4A3eMna0OTgCSZTs3B5Ke0RnXV9IU603wJqrVZkYPkEOULwg4SHTr3Pc9Yp/rQtXumPq0kcRs+jy+ewPH/ob8rZAGms8QWYtX6hyYqWZIJp8jXCath0MekuwOMb1woG1RPmYWsTfFzJj0vIL/+WmV6MJE24
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(38100700002)(83380400001)(5660300002)(107886003)(2616005)(6486002)(6506007)(478600001)(6666004)(6512007)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(7416002)(86362001)(7406005)(2906002)(103116003)(66899024)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yagmEpr65ITCT32mGr5Sy/xxdHr0z7gKNJn/uIfUla2c3PAxWia/wd9StnO?=
 =?us-ascii?Q?03JfuLjsiDlsJ+CVXqo+P5ULiXJ251KVqGRM7rKsbquZ2pHl8KS5tmBj9HFR?=
 =?us-ascii?Q?TUm8sfmrsEEI5rABGKUN6zg+kJ2kh4vRmLO/ZqSMK2aaY7OS3CJby8MPfegZ?=
 =?us-ascii?Q?87gkYaFKt4Sb4AWDQ/T3PMzItmp1/hpLmL7zQSU377KH8+IKGnMYawHiFi5k?=
 =?us-ascii?Q?1Ksqz5X/Xq63yUPQUmE1sJG8cVWLzHhfd5SgVBdVZI1rYJPk8JTuhrDeDE+R?=
 =?us-ascii?Q?MGtAUxaXctNa22MV7iFFTW40pghlVfpNYqwqjXVJ73ZPMhFlgm929aisvq7s?=
 =?us-ascii?Q?xyxDjMxg0NILTNh7oGPwbNLDPFS4wjMAxhALOsfPzJfFCv1svqPcWfi1mPVH?=
 =?us-ascii?Q?B+UQJq9hOpSxuiA+o+JMwPqDwjx7liQFptaQoOG716bPiftaBOSVbb74tl1G?=
 =?us-ascii?Q?pWsgXG6pxDp6vz7TVUK+sNqd2srUkfuBrlhC+DUaXl5w3pa0ppmc4LP+12mQ?=
 =?us-ascii?Q?xRZ5FC7WO0ADvHHp0qpemgyY/vcqk9xGechy0ZxGJJ0H4Z3b0NV1haGjzSxT?=
 =?us-ascii?Q?ah95DiFuV6pZhsDH2TROagoDmNXaWQOVAB57qTbkiwEfeNIjSdE7ijyW83NJ?=
 =?us-ascii?Q?rRNxj37+JvSEL61VPQiowsuKvfVeUsMBmV/ujhzyw5AY9UoioGuR6IrIjakq?=
 =?us-ascii?Q?St0mS7BDzLAWXVMpZyAc+vWR3h+QG0O0OBYdzxYZ6LuFsMlw4Q4vvUSVXkkx?=
 =?us-ascii?Q?64DSXaTapq8wF5AVNQdr9Y1I1se6WdkhGhvM+5Pr/lBOnM9RG0KAx7FgDSoV?=
 =?us-ascii?Q?wtIXDIRBDZEmJVFrH1sI9A8Dx6NOb/YS0ineLfkAlSIOxCF3Tq+r39tpdZhp?=
 =?us-ascii?Q?CcwJvAZdqmgHSTLLci4fhxzPqKnOVjDD6tiJKd/EKvtuAv9YE1bFs1cQb9/O?=
 =?us-ascii?Q?fxag+yoyohhjPi+sNl8ZNm08mNiTmyrtwMzrUY9brZLqB7IydePy1zneABFe?=
 =?us-ascii?Q?YWyHQf4iKZXJ918li/T+CUKN3O+7O49xLL9J+vtb2px6HpQuKOis+WDTK2nq?=
 =?us-ascii?Q?pupQodw9FUGZyTqKoVOzkK5EGaKpHWbWegiEDbD4GZACtuZewQvB2SoAhn7q?=
 =?us-ascii?Q?xsJzHvoTasnJgTXwPms6dLrIg0O0CTJ1GVyUPxLM+cf9/f5pRhp/6nPkTGdL?=
 =?us-ascii?Q?PMVe8KzG9uoml4H8ky1LU01hDxQzgCIkJ078mHs+82W5W5kMyYZSMVJZzIyN?=
 =?us-ascii?Q?cX2HmfZno0kIZmJRIDkMxkjiUXZB2QBuVBta3Ycp6dpw+AwOZsXmfx/8NAFf?=
 =?us-ascii?Q?gzynSSLJJKhIrbqmmi1/P5/87CiwM5MlEYgKzo+S8AzbAIIONwkr1RULd8T7?=
 =?us-ascii?Q?Cgkw41LYuRnFfGDsB354OaxhyN6NFFiF9JZ9cxtnLuPSOwzZguXygoN5uk4w?=
 =?us-ascii?Q?4XlwJl09D9CJIEZqlgnid34LyYcIAYZCzdwYdS5NoasHQpk+gsQ81LYCYv/D?=
 =?us-ascii?Q?z8BmwyrAc6xUVCcUy0gFJJF+KzdHTvJGqjSHmuUIeOk7X/NzoEOqoirSFV5+?=
 =?us-ascii?Q?YQ5MRoeZSnqgez1kSZS+TqvwdjCJT/CJ/B2GdoCLh69U5BZ30hq4q5ElBLwf?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?svbZTb6ojRgp8AuqwmrnDpzhH2UlwIcLR3ZD7pNmhEBQP/7CWkdYPqUtn1gB?=
 =?us-ascii?Q?ew0e2W93LzQUS31m0xeuEuoPJi+bHdy2AsIoGatP+zrreWyP/6ApFhg+xAWH?=
 =?us-ascii?Q?P8poZ619dFobAzOq483gXKNVfEQpvp0x/WQMh1tnACAi2X2dbtY1z6yiwl55?=
 =?us-ascii?Q?soaNNg9DA0nJpFyzI8Gilq2XSVYEU3lImTFeiXGB3/tUK45qVZUbl+6zRW30?=
 =?us-ascii?Q?zSf7vegnzfCdCOzP7fnVpU1wauMcim9aurP1tbbtzyCh1Yf7xiY7b8pZeg5/?=
 =?us-ascii?Q?fHM2GAElPSm5RLhUWGddwlwjr+UXWS7Zxd6uCIvJ9izTWQDR7nweWj4XocPg?=
 =?us-ascii?Q?3HK7zyo1jq0cCtid63TmKpcOEg0phpHoY9YFPCmsBIxb1LZQ1eUxBX2OrRE6?=
 =?us-ascii?Q?fWZK2+jE8CwWG+C4Eis1D0f8XMcWUN+946Ye2/HNhzxDg/tJWZrEWGENK/By?=
 =?us-ascii?Q?hN8Q2tsLh93z7nP65QVJ/x6K06+oFNcG5apkMtL4nNQC9oW53vO0bdHvHqxj?=
 =?us-ascii?Q?Jc7qbuckomYPNcRHoKLgOdxyobqz+ZrRlmzLg6KhgcM/9eB7Jxrdo4GN9Cby?=
 =?us-ascii?Q?y7n4IlW7d6Ba4O2NRFDkzYEnnjRKuj57gIbUUhTVkiVJBdOJsM+xmUsZIeNG?=
 =?us-ascii?Q?0pYBNP305WLRTqb4cKZfCzAQ0PJPaymNsoxxG3GYnkK7r3ImW7br4KXyXcUA?=
 =?us-ascii?Q?Mo8mX89/VlgAvqZ8MmcDGQq6qtMRlrWVXbMR/jX1fFz8EAa+DxPEQKK40WgB?=
 =?us-ascii?Q?7ucQO7Rq8YY7+WbvKGQ04hpve5dXuSiEhY2PKMgpfarwjUZRNGhEv2GCpqZG?=
 =?us-ascii?Q?DCT7G2UIPNDv5yNzYTl9U8TUJX5mF6Q9K0SNBtX6CImRtD4w94FXRN8+KUOo?=
 =?us-ascii?Q?+r0Vz2Z7lDIr3LFt0+m44RIZ0tRc9JXUwFZyHaOGv79OGyf/QuAF6ZdNLztS?=
 =?us-ascii?Q?xFelnXKf4tGxXZKCkJ8gISTjHoFdNlpY7MFAPk+JUW+LQKFGC6tuR5HzNQKd?=
 =?us-ascii?Q?4ai4CsASgBCx4uOJTQR+uzjsHA0Qbwcgpbt0Qfb5lwgxKWDJDEnAkVcUrawg?=
 =?us-ascii?Q?5ZKB75ibQrkqnRjOZy50wrFhABkL1zpjc3AdQbFVkHl2YM8grgYyfnM36DUe?=
 =?us-ascii?Q?I38Kc/S/2nXrfEBtNnzAusXbbkMcf+q/qVv87aZ3wskkYL/iojI6sq05edtb?=
 =?us-ascii?Q?0s7c+cp5GA19GV+2HVaJIxfRmf8KcIylbIFVu4Al6Bm/3xXPJJvuvwNIPdSK?=
 =?us-ascii?Q?rKSl94jI3wOFQYJ0eqmRqjB1TEdBIo4FLqapLvV6JytKPUNgEfGo7TtB6F5t?=
 =?us-ascii?Q?jalJnbtNQJNTnce8sE3tq9Ffh2FWeR14EQyuQnB7PnH06T55ZArGlO46T41o?=
 =?us-ascii?Q?ogt1jDiwma4/tfElGaZgWGsK9BlVYuCNwTbG3AVORUGK63YqFfN2HXzkSggk?=
 =?us-ascii?Q?n6RLfbmFVzp3uzrdyOxDZi5GOtsVEo/bzp98vmySs0/L18RAg3DoO7wDaFJP?=
 =?us-ascii?Q?xMpx7epfg7REUfbR3YSqvzL0kmZzzQc5zF/ElIkFaR9WnSwCxT341obBTg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57445321-6835-46a5-6834-08dbdfdcf460
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:29.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYEpH6o2/o/Lyzpbojw6LUxGrV0MuTapbCgyuq5pmFcrw+O/z4MOI2OLolnFI6ZRM0r40VKBwS7IX/1+/Jy63GcnlHZRCXP+j9WkkX5gKzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: 8YFjFnmcZbV_ncv7lKz74gkw1th9o_UZ
X-Proofpoint-ORIG-GUID: 8YFjFnmcZbV_ncv7lKz74gkw1th9o_UZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has a lot of intances of cond_resched() where it is used
as an alternative to spinning in a tight-loop while waiting to
retry an operation, or while waiting for a device state to change.

Unfortunately, because the scheduler is unlikely to have an
interminable supply of runnable tasks on the runqueue, this just
amounts to spinning in a tight-loop with a cond_resched().
(When running in a fully preemptible kernel, cond_resched()
calls are stubbed out so it amounts to even less.)

In sum, cond_resched() in error handling/retry contexts might
be useful in avoiding softlockup splats, but not very good at
error handling. Ideally, these should be replaced with some kind
of timed or event wait.

For now add cond_resched_stall(), which tries to schedule if
possible, and failing that executes a cpu_relax().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h |  6 ++++++
 kernel/sched/core.c   | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6ba4371761c4..199f8f7211f2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2100,6 +2100,7 @@ static inline int _cond_resched(void) { return 0; }
 extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
+extern int __cond_resched_stall(void);
 
 #define MIGHT_RESCHED_RCU_SHIFT		8
 #define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
@@ -2135,6 +2136,11 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+#define cond_resched_stall() ({					\
+	__might_resched(__FILE__, __LINE__, 0);			\
+	__cond_resched_stall();					\
+})
+
 static inline void cond_resched_rcu(void)
 {
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1b0759ed3ab..ea00e8489ebb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8652,6 +8652,18 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
+int __cond_resched_stall(void)
+{
+	if (tif_need_resched(RESCHED_eager)) {
+		__preempt_schedule();
+		return 1;
+	} else {
+		cpu_relax();
+		return 0;
+	}
+}
+EXPORT_SYMBOL(__cond_resched_stall);
+
 /**
  * yield - yield the current processor to other threads.
  *
-- 
2.31.1

