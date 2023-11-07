Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00A07E4B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjKGWEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjKGWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A31717
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJODE032058;
        Tue, 7 Nov 2023 21:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=c9v4Khm6/vMY8YkJAQXtVZyyMtxVvUYHI0R7VpMBhRw=;
 b=GG1ZUl9WmvTFzxqBAxf9RFy3DEEf9yR+toG+tls+zh9K9o7SUyMX8ATSmGzaoVl3iYEN
 hSS6Gvn6a/ZikJq8fUsEhbfUBjaU6eJzsfjDcP1y16fv4K+BXfHUvMNa8cVknXVfm17C
 TxeyBaFhckHaNiYxwERcSv2EActb9QAS7W23+edDlEp4RWQJ4sAPEffuwm8SwMmWocP2
 iPIoBL8obccv3fZ7DCYt5kuv1UWmU1e6wh+mzU1nQvt+qE0nhIEIj8WxmbfYPVwc7ZB4
 h6QElQtXowbI/RO8IOrMKvNvIw5E5UHN+tJxKo3VxuAy+2+a8SaHsH0nNn9i989fQdDP wA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIpY4000579;
        Tue, 7 Nov 2023 21:59:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1v9k32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eac8JORGCDLxorCQsFx2KQ1CEGrJrgDvZftjpOjH+MEENDYihaZQ9Hd7ZeTlPYDwgKc8GFmnVaHHfyU6EkJy+CyhzDPn5Azem8Sn9J4DjMbgWb3DXhCg1fAbJpS3c4LNZqWgy8hmSgZOWsJA6U+inhPnBVGhFmTeS7Hd1LdPDlB0dNv08SKeBuGz2U86ZBdqfWBlsMbzyDbIiVQBLBPQ/8tnVipdW8exdKF0AYxxBxcF0kCCaAl/eVzmODNOgIIPsvLWk1rQc1MLdRSPdF1kCGrT8KEs7yQTbZ/OcqlFSgGem8H3KTZCqjV2XrchTKXOkL78duaa6V2iL9/jYpeYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9v4Khm6/vMY8YkJAQXtVZyyMtxVvUYHI0R7VpMBhRw=;
 b=dm7Sgjw61fUG64lyX7CVZgiWvqU4+yIN0TdoxASJMrWNT4HwKrIh3zovnmaMVTq7wJuw7mRRqGGepSg/W5gP6ZlMVgkGZFw5K85cBWVfbpGpv7s5SjSKP54vRuY0/fGcYUvyMkStdRwI/ieAxsm5wVEwJu1zeWLJ0+MyeapESJ9OZBXsIMdAZYDq38EyrNKLO8tRgM+CGOOfPELOjsihlJxJgzWB2CFoCbOpndmqn3EGmV64+e+WKaJFQkWWg56BvrbapQ2bAX7ZaWUv+yKSE+0KhmXsbPGcijO1fCJ84w+cSnujgDW8yFWyJya/9x+pKHt0x+gMNDVOhTqk0tlXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9v4Khm6/vMY8YkJAQXtVZyyMtxVvUYHI0R7VpMBhRw=;
 b=WpHpoALRXWLqgpxuO4oCtXSbBFtSpjPzRQYFJ2FWSjmwM1wiRoCXhVxcRcPuQ3z9NZExtQlPKLCZ61if2j42i3QlB6BIz022XbpkbdVD1u4K74xJeH1daJxPDKwNjqn0tvGsnGdy3+hE+BM3EwcwDe+AtWcP8Eed5etN4e0J8Fw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:38 +0000
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
Subject: [RFC PATCH 38/86] sched: *_tsk_need_resched() now takes resched_t
Date:   Tue,  7 Nov 2023 13:57:24 -0800
Message-Id: <20231107215742.363031-39-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 042e553c-fb11-442c-532b-08dbdfdcd62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRminZ3HBxYzD0JU8jz5RqsB7R/Scj7ztsiyyfG+eNDzT2/iUOIZXiAFHsM3VMaw9qH3NgWTT4FUHDRcjFeajIQnZUw8Ql4sEhTLgPlrXrfFIpKHx0o/0pVJwo6GRLaayNLB0F+3acFfQuQwVFnFJDCfRtdP+upjqTTfFLXSSKl3xzPAKTzW49xwjHt3i2nq5Nrddl2AvV8J9uHWKW/SgJJVKjZhIfTiy8CbGplxKT9bFdnedbX0vkMSqOjNKYEPH+qUwA12HIi/Nkzr7MnFQYygVXIlGFe804ewPz46UQ8HW0j4EQ138GJSp5GKdAn7OgaHB/Sw55kJqdYJxSmDqZZ+Oyu7TVENO+BKGBSC7RVBcmpYaJHbxnV4BobLhADnA+UOLVRzDSqLmrtfb9rsbBZKxFOp3rvjspehgd79WZzB6xIpeIDYv3P2IgjasgCcy/eBcmiRLykXzOzdLQ2VVwrn3q6h2vXHN0e6DUtJ7i2CFlrEEI5I0WiQZCmKe167Gf8UlD+LBIOOP1p+iuRH6kNHLo25qolu7FlA9LOPUtLi3PhXj2zl+AFgf1UAWV6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(66574015)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vScT9MqfmS46K0ucVBqUPRaY7aPm4X1HuuM/BWeRQE/2EqdOu0OlZIv+X4kO?=
 =?us-ascii?Q?mLiVlRjXpiTnaUyKuQyA7mK77RkZ5zLSf6Qk3WeBIW3AmZZA1A99H1luRHEG?=
 =?us-ascii?Q?fHfGbhcnAnDqBYL7ZW6wIncv1MbIYdcJSDVW4x/YTaoJtZYzgS653xEFLi9Q?=
 =?us-ascii?Q?j768G+NNg9msSE+tlXXUafKIuy+bPxCihvPGBQ0agY45+MgtHcS8IuLhkgzl?=
 =?us-ascii?Q?HGWLuJAfWiRIZkHwqot5861MFIigQFhV788440K+VB6KXASdANwbYi5eDmsd?=
 =?us-ascii?Q?3eEnrJxZ0LA27R/mR9/UO9vZOw0Yv4ZzS8a03QqwocAKDdMyru+iv+jJpvub?=
 =?us-ascii?Q?g/6/9x21RLMzeWL0D3QcpPiJyTnJwOz8lcUyD/MzK7H22ls0unZzuaPK0poQ?=
 =?us-ascii?Q?GEimJ/Q39nQj80yJjHh5ToEvubv0K8hVIrdne0aJ42VbZounFOniMokgG0nb?=
 =?us-ascii?Q?DBh0XCUZSOhKhCno5AsM+HVR65MX9yo3iXGNODdO/cniG7jrI7QHZPURkvvz?=
 =?us-ascii?Q?pNRmm3450p9M75n88/vKP8xf1q/f5+lXgpN5zABuDuVrq6xKIHsVpMbTuPQm?=
 =?us-ascii?Q?G2CiuuIMP+B0DCv0uPMw1kRB+22TvxWPM2wO5Y1fxq/zHhzPFSnepdfYr1mw?=
 =?us-ascii?Q?5ZDS2tG02NhF4jBoOS/0EQTzsWs3bD2rG3By3DPmO2DzeMTw5pwUbIMsxGty?=
 =?us-ascii?Q?XZMGthMUEr6313Isc8f6Zvj5l2ZVQCW8t0InYearu4Kwj47wMCCjpnZDheI/?=
 =?us-ascii?Q?LtXEiWN6+Fytyz1T9XYYw3NtgjCyyr6ao9wACMqeaBOQ7J1kLclH1qd1fdlr?=
 =?us-ascii?Q?hNXm1cuqk/4PzVOcdI4hZs/mzmrTQZ+Gm26+SJ7Piq5kXfiAzirAfVAjU/RU?=
 =?us-ascii?Q?EExNah6YIEXk4NphMJTER8zrE57vsyodHQh1fq91tvO6wnwgoOYGO2V0Vf5W?=
 =?us-ascii?Q?D206Jcl7uAOtA683cjkwx9FMBbQCaAIynQDvEkEwTLyugq6wAVmschHuFEHk?=
 =?us-ascii?Q?yul92cNhXfCwM5attRSecUITdkGykejNk8SjymCsEh+4Q8T/hf3rmPkj5BVj?=
 =?us-ascii?Q?q16TtSQYhqODPZFu2TcNdHLTv6b/kyiUVkumQYLZt2ntIV+NfgkhUzR96VnA?=
 =?us-ascii?Q?CCGeQnOS0y3bIbLAMbblYvb5AGTltq77AizpJhf0T4zv5rf/gnlHVII6+Aak?=
 =?us-ascii?Q?i2Nms2dqvc0h/tJ4QqY62aJvrGgC3Yoo3HG6oiUCWYXsrXtJqjC6+SXLQvv2?=
 =?us-ascii?Q?xQ/fBzlWyUqsgUt9nyrPHvVOtSEHZeSCQVCfcNOI8Q00AcAfKjkP2kZPUtdY?=
 =?us-ascii?Q?BkpD2AjKc4H4MvtnsmB2Z7xEki9KDh+c8EHd0O+5X4tyaKj3rnMc0VJ8SBmP?=
 =?us-ascii?Q?3tzX8Cp4yjV3wQ61uqflFepvFK+jKhymdo1YUNaR+BVqcTFwuRkYBqlATJ/M?=
 =?us-ascii?Q?IO4tOVMdsukbIt9jpsiz/3V1RTPuIEacDhLMbrMhvgOOac0wvgFU/THCKcMf?=
 =?us-ascii?Q?uctYNS/pzZDK1QjWmNbxIzdtdYOVpOf7sFP0ZbG2a7FMoyVqxMjES16Z2SaA?=
 =?us-ascii?Q?5bFyBtkL6PJX594ogKTRTqGqu9c5/bF5WuGSi0nsWq5vCNLBlL5eWfGV8Lwk?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JdIZeCPEqn1ozn0uQ62f/aA+InOE6F8VJ89eLah5pOexwcn8DHZL7mQqc1Cz?=
 =?us-ascii?Q?9B4APyj+d3p2z1SaTMGIJos9C00tyTAMEQnIsKLqESldq9dYD6znYvV06uYe?=
 =?us-ascii?Q?0H8Ph1lHxHd7/bAdzEECfEnvK/6AxpArTnE69nMZtcC8QqC69zHyHlkA8feG?=
 =?us-ascii?Q?D1VR+Y3ZcFFKkZ1UcGkuAknLizp2LH3rB+OrZQJqAG7+gJUN7VN7uLgVqNtm?=
 =?us-ascii?Q?v68JMxiOjp+wgO3xJkeeNSYdizyUnj6JIC7+5om8q5bIwH3PuD1BVHdL2f+t?=
 =?us-ascii?Q?3lD5gVAGlqNUqvt6Un4VAtvFVF4SNRJ1a3IvarAnRP2XJGrApXQsGgGP1aYq?=
 =?us-ascii?Q?fE2m71QxwAjhyo19Ai+IltJl2nfR5hM1lZ5eB7+x3qEIS451j2u2kYAoLncX?=
 =?us-ascii?Q?LlMJYl0ajGj3l6fWnQPrh3SN35SJtk+fWvqieBPOjDAZl3JZ0+LsRE65RFOX?=
 =?us-ascii?Q?9srd1NrghxAqdg0GxccXP6tRUNgYeVO+3FQmONhQWtnQaKDb5LxLZlEmB/xW?=
 =?us-ascii?Q?NjmyCvx5VMYna9R2KS4fxoBOCFg9c10WOwNZiHJztUJVOUR0kaMyGsNBsIan?=
 =?us-ascii?Q?zrNnBeluG+ZRp+uaRviRshVV6RpHnDts+GKdgU0v5UXz0/oIz6C7cqGz1xJN?=
 =?us-ascii?Q?CXIKNBs3rpPsFx+eOVwGATRMXlJn6M0TsgTla5kD8l9XRsTl8SkVJq4vwlcX?=
 =?us-ascii?Q?/H/UoSf/ElHHJZp9CNyOZZ6hhaE4YiNXsXAd3Y2AQvlPtE3I/ZD0A8UdO4aI?=
 =?us-ascii?Q?YgDhaIePtmtJw1FI2zTaDEA8blf5VpB671tnL+L7ObUvbDq4fONtNsg+hgW4?=
 =?us-ascii?Q?D9PveGCGEaC4FQSUFmkog3vHAzRebtUSf3F7rBPuzNhXL+oGvqi/aaacaKFn?=
 =?us-ascii?Q?DS16rh79tcOTFwuqXsJMrFSJ2I9OCfV6gF+V4RQs1p8n0k4juY+ekijjMfXC?=
 =?us-ascii?Q?UAZE28Iqr4necksrTiw/bZ+BRPLmoc+nhXNHisZM6J6c8jGTkNjgdhgOPYKZ?=
 =?us-ascii?Q?kyOjk0CnI3sgTXgRWviP4Re1AO7Cn7qRdXhh9bgGeIyykTPGtsRWrI0bDI5u?=
 =?us-ascii?Q?PfytHsati1g06K3kS3gsv1B2jPZbmQf67wunkNXO+QvByMwDQvjTkFwJOiBa?=
 =?us-ascii?Q?mMbYa7+QBl+rKJeORbZNnxrP179vt1WF0yXvvwmafYWZ3KPPnOPzGvKc1EV0?=
 =?us-ascii?Q?3WtTJ2nVjoncVZl5JsM3/ah8FRBNaUg/hUoi4tP0EgbOUiJ8xWDpqQgvc1rB?=
 =?us-ascii?Q?RtFaDHs49JIWh0zjy/yL+oHW/vx+ycLt2NUOn3rV7EeGgzUR0498Ib0RQUNx?=
 =?us-ascii?Q?kdpWEzyPZ8nsBUMy1SeIsUOrLMEzK4fDRU0Ns7c42EF7/k6tBBhsREytxyX0?=
 =?us-ascii?Q?2N3l7PYVTdxcbtPzkPLyv1GD3QcJFMmoURAoiUv3DovKbxTd01rN1C/M2NMt?=
 =?us-ascii?Q?kaPcJitP7wafFb/qf8CLjp89HmnJZ7nZe0x9+azOHPooDPY19E9egMn1rOgE?=
 =?us-ascii?Q?mjf2I2Iw58JiRjxXkhXACVvA729CBxqQy7X3ggn0uIzXZ/1JOJWWz4WZYw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042e553c-fb11-442c-532b-08dbdfdcd62e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:38.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q81M4D34lOWmuPYcmKzDCrfjdsTZHr8n9kMxPqi7KrOA610vUpHq/n0M8Ej2LEri8sNL9n/l1NyhYlU4C8JBLPKmiW2Mfm8GwMVgHP39QKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=816 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: xsfmtYUmhCHZi5xj4pnaAmavxja50UjX
X-Proofpoint-GUID: xsfmtYUmhCHZi5xj4pnaAmavxja50UjX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*_tsk_need_resched() need to test for the specific need-resched
flag.

The only users are RCU and the scheduler. For RCU we always want
to schedule at the earliest opportunity and that is always
RESCHED_eager.

For the scheduler, keep everything as RESCHED_eager for now.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h    | 17 ++++++++++++-----
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree_exp.h    |  4 ++--
 kernel/rcu/tree_plugin.h |  4 ++--
 kernel/rcu/tree_stall.h  |  2 +-
 kernel/sched/core.c      |  9 +++++----
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      |  2 +-
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 ++--
 10 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 12d0626601a0..6dd206b2ef50 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2060,19 +2060,26 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline void set_tsk_need_resched(struct task_struct *tsk)
+static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t lazy)
 {
-	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	set_tsk_thread_flag(tsk, tif_resched(lazy));
 }
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_eager));
+	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_lazy));
 }
 
-static inline bool test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t lazy)
 {
-	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
+	return unlikely(test_tsk_thread_flag(tsk, tif_resched(lazy)));
+}
+
+static inline bool test_tsk_need_resched_any(struct task_struct *tsk)
+{
+	return test_tsk_need_resched(tsk, RESCHED_eager) ||
+			test_tsk_need_resched(tsk, RESCHED_lazy);
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..a7776ae78900 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2231,7 +2231,7 @@ void rcu_sched_clock_irq(int user)
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
 		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
-			set_tsk_need_resched(current);
+			set_tsk_need_resched(current, RESCHED_eager);
 			set_preempt_need_resched();
 		}
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
@@ -2379,7 +2379,7 @@ static __latent_entropy void rcu_core(void)
 	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
-		set_tsk_need_resched(current);
+		set_tsk_need_resched(current, RESCHED_eager);
 		set_preempt_need_resched();
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8239b39d945b..a4a23ac1115b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -755,7 +755,7 @@ static void rcu_exp_handler(void *unused)
 			rcu_report_exp_rdp(rdp);
 		} else {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-			set_tsk_need_resched(t);
+			set_tsk_need_resched(t, RESCHED_eager);
 			set_preempt_need_resched();
 		}
 		return;
@@ -856,7 +856,7 @@ static void rcu_exp_need_qs(void)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, RESCHED_eager);
 	set_preempt_need_resched();
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..f87191e008ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -658,7 +658,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting and no possible deboosting,
 			// slow is OK.  Plus nohz_full CPUs eventually get
 			// tick enabled.
-			set_tsk_need_resched(current);
+			set_tsk_need_resched(current, RESCHED_eager);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
@@ -725,7 +725,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
-			set_tsk_need_resched(t);
+			set_tsk_need_resched(t, RESCHED_eager);
 			set_preempt_need_resched();
 		}
 	} else if (rcu_preempt_need_deferred_qs(t)) {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6f06dc12904a..b74b7b04cf35 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -705,7 +705,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, RESCHED_eager);
 	set_preempt_need_resched();
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e30007c11722..e2215c417323 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -927,7 +927,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 #else
 static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
-	set_tsk_need_resched(p);
+	set_tsk_need_resched(p, RESCHED_eager);
 	return true;
 }
 
@@ -1039,13 +1039,13 @@ void resched_curr(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(curr, RESCHED_eager))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
+		set_tsk_need_resched(curr, RESCHED_eager);
 		set_preempt_need_resched();
 		return;
 	}
@@ -2223,7 +2223,8 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(rq->curr) &&
+	    test_tsk_need_resched(rq->curr, RESCHED_eager))
 		rq_clock_skip_update(rq);
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 58b542bf2893..e6815c3bd2f0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1953,7 +1953,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 	 * let us try to decide what's the best thing to do...
 	 */
 	if ((p->dl.deadline == rq->curr->dl.deadline) &&
-	    !test_tsk_need_resched(rq->curr))
+	    !test_tsk_need_resched(rq->curr, RESCHED_eager))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
 }
@@ -2467,7 +2467,7 @@ static void pull_dl_task(struct rq *this_rq)
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
 	if (!task_on_cpu(rq, p) &&
-	    !test_tsk_need_resched(rq->curr) &&
+	    !test_tsk_need_resched(rq->curr, RESCHED_eager) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df348aa55d3c..4d86c618ffa2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8087,7 +8087,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(curr, RESCHED_eager))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d4a55448e459..eacd204e2879 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -329,7 +329,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	struct idle_timer *it = container_of(timer, struct idle_timer, timer);
 
 	WRITE_ONCE(it->done, 1);
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, RESCHED_eager);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0597ba0f85ff..a79ce6746dd0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1735,7 +1735,7 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr, RESCHED_eager))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -2466,7 +2466,7 @@ static void pull_rt_task(struct rq *this_rq)
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
 	bool need_to_push = !task_on_cpu(rq, p) &&
-			    !test_tsk_need_resched(rq->curr) &&
+			    !test_tsk_need_resched(rq->curr, RESCHED_eager) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-- 
2.31.1

