Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AE7F25C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjKUGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:32:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0ACB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:32:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43go7015015;
        Tue, 21 Nov 2023 06:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MPn6gjGfv+yMotBd5DRHP1oTJsLH0WLsdby8RrS9Mq0=;
 b=3rT2NFd3dqKPRyP1sWh7EeSVI22/tvOJhAydOKWQoCbi15MAb8q39bzOsTBCHtMBgNuZ
 pNJDOfzxkWNHOqYyeNRmiTgLc1j0ebTcftJehvz9lSqIPiDUMzh5qwq/JMBa2WnIX5hL
 q6m4KuzrQgLdU1fsvMX/rRRGe6sWQ3O7NHrVb8M1QWz5L0BA56OnzkreGuUrMIBRbsZ+
 ZsNTmpvuqxi1Go1vu2DIsvoeN/z6CmnY5RZ2ECCrYylz7Ya+l+3USML3UIIs2aE4fLUc
 Kbqjs39O5AWGwsD1WthVATQJNApDIlub0fl3IeFAr/8DX0L7G77p/V3ixOm9fnXT5jjo tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24vb4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:31:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL58C01002366;
        Tue, 21 Nov 2023 06:31:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6fjux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZzu0ayJitiIbC1P4mbZoSpM7SvsByP+b/jIWhJzzjBKhHU2qniXAv5dw2L0utZ1sg8RRiH1O9yhVLSo7EP4qf1zP+y7tNqrRfMlxcJL9BS+m429V7JqIl3QHRB/ZuHWz5A04NVYtwK8d/fPHwl3iwDctZtHWOYQa+xX36tpMIpVHfyFIcMP7PkFZfIf0i2jr404hAjyoSRSfOP7jdo5hDixmWv0a02AYVZx+38R9ufj/hjVMYSzrTLbvJGjq1w0zn4NaFiXXRSrqpeZ71+KefQ2/uF+toHg2Dvr21MK/hU+9YOYK+akzYQtbr3APp1mOWRKIjfMagzvk30beSNozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPn6gjGfv+yMotBd5DRHP1oTJsLH0WLsdby8RrS9Mq0=;
 b=NjwsW0xelCPnSmql7sO28pEVokDyqxGZTKl3P9w2b+SJAaegEeZ76ENeiZ8xNdiRUzXcS7iPhRFUx8U1F5h1OeGINLU5ZbDz5J27E+VlZGym1/0hkwWvFwPfCit0fBuG3WRrVF+QlHU4/5X7F2CFYwXoGFHQQs4/9954WljdJa68rd0LWRqo4LAiE0wiHkXIBUEZjoWTLJMB571eA0FMxXiNMU3dsZcBtBXqZIlNaAbAgFZ9dWxjhngvObzTAj7/s1dOX+akHhwqQGObttv6gyeFl86mT/rz7v2amHXerhCvruC41X1lDftzJHMj4cE+5D67df1yM8k2F216wyEQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPn6gjGfv+yMotBd5DRHP1oTJsLH0WLsdby8RrS9Mq0=;
 b=ZE1QqlSt3erNXkOgbQ/Xj4jIbSW5FBdRAsebWWBotoLBnQlYKCW8JQMlXeN567+4zpG3r5VtBd2QliPge93RzGEoMYgAiiYTcSrMFXK97kVxVjtMhjWbSt5+CXqm91ZJVwO+IcKHYfz+3SGIhYw8xDlQ4OXDeiyuuLzKXRuxtUQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 06:31:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:31:30 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-42-ankur.a.arora@oracle.com>
 <20231108093645.GL8262@noisy.programming.kicks-ass.net>
 <87fs1gk0bm.fsf@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
In-reply-to: <87fs1gk0bm.fsf@oracle.com>
Date:   Mon, 20 Nov 2023 22:31:27 -0800
Message-ID: <87wmuby5vk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: d09d981b-74c8-4491-c26b-08dbea5b7f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HO6TBduAKHc6HoNG2m9bLgb78wl08mFGbfb1xJblQsCVC/fCd463NOeE9mlA6vzz789uNhliMDh+2LT4Psym32B/ES9ejtFWj8h0VSvSD0oaMxtrNVdD8Yy8CSTUeEeC+3HBzwIBkbz1L2nvBs1vP4RJDbjaKsFy7rTHR1jNBAJtNCMnzbfD0HX1EUbdJaSKYYNps9eAMelMqjGJs+xhQQpprd3S8LGVdihRwCOE+irvZ1iKQazlDntn8jO6XLqkS0XU3A68NfMWKPdt2wviapTlGXoX3SaPTqWI8jWtagvavL9CjvaKOZ4afz0AV7Oa/sMvZax2oX9e/5sz/xte+75hESxqV6x3yBNJkO/45SLfutEdujpyCjM1uR3ha9sFBSWE4Vst5jXF2AKF3WOQawWXmiZwcrRXvQ52lZ8yJgnKl+tabxGInu5SD+3U1lpxy/Zh+y02n1IeK/z/+SVY1TwmZPavtjnhjVrFd2xizsrqbJ9zvkQyoCw128n8rKLFE2b3n6Zn+TDxs9I3Zlx6sEWV9BSoAh7vLS+xNWK0BTKEFSYVqskCylYJxj0hXsve
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(6200100001)(7416002)(7406005)(4326008)(6862004)(8676002)(41300700001)(8936002)(2906002)(316002)(37006003)(66946007)(66556008)(66476007)(86362001)(26005)(6486002)(478600001)(36756003)(6512007)(6666004)(2616005)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptfskRLv1WBRDprd56L5YXzRtlxceFNB7HpgySpL0NoTsGtVvyVRTbkUg9hu?=
 =?us-ascii?Q?ojcK/Y5UIToAQLOmFp9iZslSkRxwwMZ7A+y6aKTJfCmz+kPadSV3JK/zHYZu?=
 =?us-ascii?Q?Vr5mpcoiw93d3kUZFMXY/i72FS68TVoIH1nvg7HczmsXctjDYfxmtcJI6481?=
 =?us-ascii?Q?NZl+CsuAF2G+ygUkWTy5Aykxh57yIlieD7khguYG5EM1o9d9qSqwJtwzwH8k?=
 =?us-ascii?Q?yBPono7NrNfuCiWRJ724LvsXrdr0oNRctr+RV2e3xN5bcPGm0XU4K9LzpOvL?=
 =?us-ascii?Q?PCkCFYG2/D8FuUnW8Hh9E4ZxDkKnlgfx0sx8KLL8AgPfH0EF/g5ltQoDhAV+?=
 =?us-ascii?Q?w3zS7xwmwNa+I+Jnbr8nH+5/3RfddYmaE9gXFhwPbdCgyikbejfS3Ygn6gTL?=
 =?us-ascii?Q?db8hbe855f9//k4HGlwlXZVwprwhJkY1XdNrFTPrm3vNhfWEcRdQu+Bh7i4N?=
 =?us-ascii?Q?zz8CHQ/CPiJA8bImfVUUX6f6ZTPrSbIFAtitn1WRTPoJ0cxr5bL89NLWxLR4?=
 =?us-ascii?Q?9XMw/ca6e3Foq9Uc+3vpTrWhNCHUrFhqWmVByLknPBdlscRdBdVWHshZm8et?=
 =?us-ascii?Q?+jd9Tmj76K2CeYLZGA6muIqjkQ3OaOn4LQ1lKFliRRgBUoINMJ6LsAJeBZyT?=
 =?us-ascii?Q?t4X934xMcDTxapd7RxK53q40gkuccQZcrc8X62sSNPCRNfnfgVACpCKwq5R0?=
 =?us-ascii?Q?qMwc3x493TAiIkKCrXovUBfkUTHZiqErzpSiQsVIOw0cUwmPP4PV3JKmW8uA?=
 =?us-ascii?Q?X/+FIf9LXgCg0Kle7Ppn/3e+0SaQOmuYiqW+MBS0T1cbNBYs3DVdYsWtKWYN?=
 =?us-ascii?Q?eWAhOcc+C5I2MnnqW5B7iNL6HE9NQhPnetlgiDc5UQaXRo3LKsa7sa1lqOqK?=
 =?us-ascii?Q?wCijcns3iUnYYeEYTlrmtWYgaRBSpDIinBnYb3CVLcvBECh7wV0CrOo6GFqk?=
 =?us-ascii?Q?t0JYvaprpzknq0HHdYOjZZ54JyMp8hqYVyvdgKCUVByCYHZGzMEjeYc9fHpJ?=
 =?us-ascii?Q?drJjTgWcrRR2ysHMlnQrtNVazPEXl4DRSSqECSt9fWp98sfw2DLgKcZPek7+?=
 =?us-ascii?Q?gkNnDlZIpYUzP3K/Cya38kVBK8oIqFImE5epp3sqdvJblNOaJAK/vOayYrIs?=
 =?us-ascii?Q?9K20pFG5AisNPNSB/PDq4/mcASvlxiJoIOx+zx6KVdlBh2vsurRhhM3Vd8kB?=
 =?us-ascii?Q?0o3d+xKQdksMBJAcaxZ8Y6cKrD2hkH5HvunsNC4EFZKyzf0tZr3Paiaz/hZ4?=
 =?us-ascii?Q?ORm4cwFe234unrJYLPNBn2Bdta/PySYV7jPUsv6Eyu9zCMkV99Cc9g6TvEEP?=
 =?us-ascii?Q?cBb1m/otPgoXINnLTawFQgNUj6RfIBpQPP34kUyeoshgm1B20ARl0PftCOBt?=
 =?us-ascii?Q?er3TrjEu2fJPZCNpHGYBRTHokA+zrj0ZCr5SkY0+Lavfrzj/rySUS2wwWa6z?=
 =?us-ascii?Q?IVNm1W6I5y84atHX+Q38+6t/NRXBSy2CvSccn+DAub+MyoyCpu66dB7XovJU?=
 =?us-ascii?Q?Yp7ct7WKqBJW3RUAafWNuk6pyCfYlfmWeiqvonWEjk2JnLVf/OVjs5bASxHm?=
 =?us-ascii?Q?hlEEkhVfW0zthQIlVorQ+NTyjNGVfp8bGPwfAAGJRJZ1RS/CVd0phSJ4RNl1?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?unZPiBf3b5p4+srdW2YqXMTSvufgJKoVN3oimT66Ghg3Tl6MPm8zSC1RwL5Y?=
 =?us-ascii?Q?fIDmFwfd5fnGvqT1O5u0/4qShmSvhTRTzjV8KZNVZXbvqAM+I6X2UNCEp7ZE?=
 =?us-ascii?Q?YRlUjFK7RqrrsA6XMrxTcCEYGVoj7TjreHmlBdok0Jz+zN8owlSVbcpYj6wp?=
 =?us-ascii?Q?qTOudA2Dgo32H7jVeI9YFXZ04on+vQS5txhKbxg8lOrQ7I+dhtejWGmbz42A?=
 =?us-ascii?Q?fqeRNAkrstvsMqSCkBFlJRY87aYgMlJp8wft8hAo7Z37D0P6afSdNQ/u+kUR?=
 =?us-ascii?Q?DMnp+BCFEj4T0DZqAl0TWQZv2ymoiYpUKHt4qVte6j71g+hdLf/UB29Vi9L8?=
 =?us-ascii?Q?w+TXIyD+qtNQncywBU7YzJMYOgADdTb7l+yPQvxRa37q6aqvUfV0FvwNrA6I?=
 =?us-ascii?Q?2KFR946FQ9n/4ya+T9K4iPU4wRRqOTrRxT6drFJlqyoI5aMYkD7V2wczmIfe?=
 =?us-ascii?Q?UMKpJg8B8ie/eU8ZKjun4wWS7uDBg3B0jsAcNR34PtIUSF7SBAwL6H6GfZcS?=
 =?us-ascii?Q?jHmU/25JpRGVyU3kred550X8ffBpZmzl2zlZ0ePZXVU/6PcYobeMbs5nYuYv?=
 =?us-ascii?Q?cJyc1oXFyFFPhuJ4gFbYMnt9DKRqOasRukVqDJbE7uKhdY6S9zjqHSv2sHvV?=
 =?us-ascii?Q?xmY5DnToiYmJQXqwlNeMHmBd0uF12Ln4sl0t2UN/67+uy4q/UrGwPP9t75cj?=
 =?us-ascii?Q?LiRFQRxbKdinB6Vfvy2c/z72S1hSjTE/zKLjXxkuXTmXNCj6lu84CxVG7aPA?=
 =?us-ascii?Q?EyT7x+UhkpQifK2LjHpuU5M8eiLieTgZx2NsYcb6G2KlrML5ZxCa7zgRK185?=
 =?us-ascii?Q?IuGKJQH8yzImyCQw5ajBukQUHa8kyTIRnMkxcO98VchYzpLWyhPmjvtI38Pz?=
 =?us-ascii?Q?e5vJGbFNheFH3UQbtowdyQdUN/tf4YzpIaZA0h7ZpKQSCBCOcVz5lNojqLV2?=
 =?us-ascii?Q?zgCbrswJjGxbykmtTe8P1Bfzj+OG7jQReY5TB+roU01CGz+T0sPLoP37Eau1?=
 =?us-ascii?Q?pE+EyHzRBNJRwPgr921LgepZAYjHurKiQrm2y7R7iHApf18uof+R/3BWp99V?=
 =?us-ascii?Q?LD3msSqR5oi6hbva64fWsY3+BZeURGS75d9ZJs3xzjmUybJhotPeERDvc+Yk?=
 =?us-ascii?Q?ilGI4qsXoCnyzH3IhNTf9OvZ5lMKk8q+9sS5LjONXXelXs9EytNKfgtLRmq3?=
 =?us-ascii?Q?jeOdWz5oG7RQSIfYhSHHfItcMiV5X58gSkLbAyVVA++fqmK4igTfg/IMKI0O?=
 =?us-ascii?Q?lL3YbZcEBiXwM7a6o53cJv+Ez59Mk/DpLM17UgFCNe59K61O26e7etzuJ8K7?=
 =?us-ascii?Q?lo//s1DeREJbeYYIT8mXmGAWOv4fPY+k+aWfNJ8ArmR+9tHe448/3rVW12+g?=
 =?us-ascii?Q?SdWUOMADL5f3CQAR047v6wF+9ebbrURa0RaPskEPDwKi3loogXy38PDg04BB?=
 =?us-ascii?Q?rIbBLg70uUxGDVHUyQs+2YryiTBSS7Tvf3Pkl2kIH/nUswf4IyR+RhNJSoeB?=
 =?us-ascii?Q?KjX+Ent4LK5KbM3NjrnDmzhCgKm13o/PhKyvA0TDBAOlcJAeavFEhdC3gQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d981b-74c8-4491-c26b-08dbea5b7f34
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:31:30.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEErQQObK6ogDONA9rgH1dX8591aZYVWoSbdoTyBkbS6g0NWj3EiDOc6q/rwnVoqn8utg5xpaYh/aVFrSdn5zUirWRaWWJlw6yNgl7XvaIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210049
X-Proofpoint-GUID: -peT4AevBI0UX2xUPi-VduhMyyHHELeN
X-Proofpoint-ORIG-GUID: -peT4AevBI0UX2xUPi-VduhMyyHHELeN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Tue, Nov 07, 2023 at 01:57:27PM -0800, Ankur Arora wrote:
>>
>>> +	 * We might race with the target CPU while checking its ct_state:
>>> +	 *
>>> +	 * 1. The task might have just entered the kernel, but has not yet
>>> +	 * called user_exit(). We will see stale state (CONTEXT_USER) and
>>> +	 * send an unnecessary resched-IPI.
>>> +	 *
>>> +	 * 2. The user task is through with exit_to_user_mode_loop() but has
>>> +	 * not yet called user_enter().
>>> +	 *
>>> +	 * We'll see the thread's state as CONTEXT_KERNEL and will try to
>>> +	 * schedule it lazily. There's obviously nothing that will handle
>>> +	 * this need-resched bit until the thread enters the kernel next.
>>> +	 *
>>> +	 * The scheduler will still do tick accounting, but a potentially
>>> +	 * higher priority task waited to be scheduled for a user tick,
>>> +	 * instead of execution time in the kernel.
>>> +	 */
>>> +	context = ct_state_cpu(cpu_of(rq));
>>> +	if ((context == CONTEXT_USER) ||
>>> +	    (context == CONTEXT_GUEST)) {
>>> +
>>> +		rs = RESCHED_eager;
>>> +		goto resched;
>>> +	}
>>
>> Like said, this simply cannot be. You must not rely on the remote CPU
>> being in some state or not. Also, it's racy, you could observe USER and
>> then it enters KERNEL.
>
> Or worse. We might observe KERNEL and it enters USER.
>
> I think we would be fine if we observe USER: it would be upgrade
> to RESCHED_eager and send an unnecessary IPI.
>
> But if we observe KERNEL and it enters USER, then we will have
> set the need-resched-lazy bit which the thread might not see
> (it might have left exit_to_user_mode_loop()) until the next
> entry to the kernel.
>
> But, yes I would like to avoid the ct_state as well. But
> need-resched-lazy only makes sense when the task on the runqueue
> is executing in the kernel...

So, I discussed this with Thomas offlist, and he pointed out that I'm
overengineering this.

If we decide to wake up a remote rq lazily with (!sched_feat(TTWU_QUEUE)),
and if the target is running in user space, then the resched would
happen when the process enters kernel mode.

That's somewhat similar to how in this preemption model we let a task
run for upto one extra tick while in kernel mode. So I'll drop this and
allow the same behaviour in userspace instead of solving it in
unnecessarily complicated ways.

--
ankur
