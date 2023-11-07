Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A37E4B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjKGV7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjKGV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6E10E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjVx014999;
        Tue, 7 Nov 2023 21:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=L0Mjat5vRnelUd0kb9wZr4KmZFbXuFTujcTfmbGjq5A=;
 b=AqYwNjapBnx+iwsCNfMlqy+8tLtmkIe8tS+77Ng+HvzbGy3IjJj0fu5ba9t65ikGzRi1
 ExunaT9wnMk6OQc+jlWkSuo/dRUofV4RqlO9IfZuygZh+LducbhMGrx79CmFCs2xyIU1
 VnFYS5k5BS2mqmRD0zYL5ZE9JaXuN09XBR6W3ePm3W3pedr/ah4fCUndg7fmFr3dcr3i
 7D4ahCxauMQ3Hygsg+nsicpdF4TD8hoawgBSHurOZzkA1GnIxMbRls2VD7kChQxRQBRv
 qkL2guMhpb6DiBbxYt6q9/xy7DctmKPO5RAhCt3zr1UsMcHewAABnz1Ztl+jLN4hahAJ mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LItT6000430;
        Tue, 7 Nov 2023 21:58:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsjve-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+ktIALRarGJbg0YLRLH/OGMNfTd5yCM/q+bkUGKKdpz3jF7qoSLUqsGVhXXijdRHv42WHA/f8wWL2vh/VhKyNttF+Kg5FnFDK0xO90jVoXVEX0Qv5is6GOYa82wxuHzSEHp0AWDlQAc47h8nJPHJeWPwPD7PxuPgW3fHUMzlzlK2AJBt5K+6JPNj/GXl7ZB6UH4H8Y/2Z9JLg8zmo/gnPIriyjWmkSP0ddWDZarQTXL98ygqdT+6dOtmNduG9GdLKOYVjKfDJSlnAgPbX4D/VnVj1KRjBMyOE8zntWh3Mk7tRpu9/y5yKXi7WTHB0Sc7M9M9jywulS4Ec/lfQ390Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Mjat5vRnelUd0kb9wZr4KmZFbXuFTujcTfmbGjq5A=;
 b=iB2/B4lKEhjoRC6srivv/zpkpWieuUp1nslRNkJNXk5qT5bvADqVNe3j9I3zeuCcHlTWRhAvAmRQHfg7WSk7B8MS4C4wYrzQ4rd8+5Tmp5BRmvL6RKGcG7B+Jvm/+djMMndjP85CCn170U4tCHHsJEIuCO/wH0Twu4Lv/Vt56/N71AD0KpTjUfYTbFYO9KqrwtBWMa2YsflhOJTgMRDUHMSh0VCUHBrk75zwKzQwAc4cuwM864gb9bstEzbMKkmSydVNFwLrxWcIMTkx1EaoDNgn11SUgk7e6wUT2fAtX8GBEe5SZVi1Xw+l/UKdPhwXw6gSi/aV0DIU1I/pkkMh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Mjat5vRnelUd0kb9wZr4KmZFbXuFTujcTfmbGjq5A=;
 b=tXkXiv4+ZyENhZZrnQOW3lHbc0NBvpN/popHzU53RSagr3jCvL/0ikCE8kZv+LrQn1Uy5l+FHgD9gNa9F+t83bS9b6xRG03ob8TsrGckByC9AiKelfaQadfi9mzl2bdHj8lXvGfFg1mDrWjKPn7LBpxK82ZAkbdwoj1LJtbaKhw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:22 +0000
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
Subject: [RFC PATCH 13/86] Revert "sched/preempt: Move PREEMPT_DYNAMIC logic later"
Date:   Tue,  7 Nov 2023 13:56:59 -0800
Message-Id: <20231107215742.363031-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b21837-f81e-4f11-9114-08dbdfdca904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIcg6s7UwAU0ygsMBEvM/wkZwydQpU3On/0LlaJh548RaHXo5kq/wCoJcFZxS1jmci4KLvGNLFz5cBBeCRHe6/3VnCwzJT0j+izVg6Og9HZ2+1JiFfrNsnGnBJc5r5SiPTPbjdnriWxgMdY8AOS5QlbeaSLGDSRD68cdY0ukzPqYrsnREIdp8lXQ9OMJZVD9/MoiKVbET6zybn4GArrWdyvRHIC95oe0hJh7fO3wEDlAKzk1Yw330IxWdrW4hCyltMpjIgFSqmsexLoEPkdY06vFK5ilSCzRhWaAtTBvpT2HWgCGjiEJfdZgdC28AbaxwLBCJP5Ul3EreYQKInxqHJ1Ur/4QE8/xS8+BGhkF1SNNTP5D5niZyQzYQkBNnseD9c6sTrK/McD87QVxpIfG5sPxmbRnay1ETSowf1KV2FsYoZuiyVUpfzTJ23KOrr5XviFSnzsglMJKxDA0zY1wZ0A588vKJLMlOupGWHjJZMMrPzlmPSxxeGMnB2cWfu+g5cOsx5es2/X5e7P+Uz5ETkRjT3bszuxtGj4hf9s3+npIBDEP25nUf39RdlRYeIcy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6eZQPH0rEo0uYgzsUWFTSZqRiehH839v9osJE8fzD6AaB2WSC/4o2/Wt+NsV?=
 =?us-ascii?Q?vRUb/OiwecdPCiyfVpZifkOjPO5U0m6RvUexOszZoW4K0MHWqW5sTJLA7kCo?=
 =?us-ascii?Q?hZLwgn3ZNnzDK9b8Xs6HBztt0wpjK5Jwt3AsH8zXComZx3mbLpWawSKtLSxO?=
 =?us-ascii?Q?9jzpAPwwfJOgm7hahg5N1NIFf18ReJ7i/T2En4QTwrIBXlB9T4AjfGwdoh5H?=
 =?us-ascii?Q?semJQR4Qic3Ox98wEbqXBxPNcvXJAedamjXb7TjSXbEOxtMD+/C6sMrbXj7D?=
 =?us-ascii?Q?GC/0c8e6SK2em9JLnqLiUrcC5DJWcYy/l9mBF6g6HCSQ3Vnt3zN3BUKftjaF?=
 =?us-ascii?Q?9il6tF8k5XJMruGXq9pdnP8I8YVG3RLqVu/1BqMKG2xSX9XFoLVgynVK69u3?=
 =?us-ascii?Q?RaAVF/3LL3VjgUtVdItfuNdo448MnXXCQHunkP6l5NORP5E3zp/qaFy9UGMj?=
 =?us-ascii?Q?wywuKwb3DtkXSRf8jcOW6D8k3XsyTu7ewo1rMBgLXDkWZl5HMHxE4YU1Yp7o?=
 =?us-ascii?Q?JBsj2HRPG30/CiCwDPCqzBxFOkMvTEozbytaNKYvW9qwrZDfufPBa8PeOFbt?=
 =?us-ascii?Q?OnP6vqsl9y+FgcEA+UdQUKGmfmmcqnWfuLhNt+lOhT7bbPh9K1JIikfylv4+?=
 =?us-ascii?Q?lNgaubx1IzlH+Vyr12h03xCbXpU2FBdwisWrvVPqN9TfbYFm58yoLLWos3Ug?=
 =?us-ascii?Q?TdxQuwGF5XikB06ZznvGXPvh5wGPTDke/z4Tvy+R+lAkiKt6haKLCm1HaLhp?=
 =?us-ascii?Q?WBwiDifVNwwJ5KV0GLwOhGV0z4OBzkkjG79TNShQNazvRyRMQnskLNzrDMWF?=
 =?us-ascii?Q?jupjbU4oeoZatApowVwQV7o1KSzo4zO+95ItXOaYfH1dnTlNTuvbHl18fkzA?=
 =?us-ascii?Q?DVzwO1KdFq4QrjaZ2tZszXHNnTHBENz6Il/OyJwHY5NUTufcpMiU2JRNaz4/?=
 =?us-ascii?Q?BQKDJFwiDGNa2T7gD8kNvRI/JRG7mWcO/bmWKnm5VanvyoazH7QGZ+kKqmNY?=
 =?us-ascii?Q?8n0zCjYdY9R3tpVBC7FDyT06jWTJJjZ0pA6sp1HBA/cK/XhRSIhL3CE5VRFJ?=
 =?us-ascii?Q?6VZnlgSroJJMHHG45bfBRbJVYtnnhaznQxadbpRXZUQZKKb281T3eNpy+r0i?=
 =?us-ascii?Q?xBEe13ErQa72+tV8TQi0sFDeZutv9Qohuy7zL4Iba+KMAcEvF7CpszS92SeH?=
 =?us-ascii?Q?Vga2rejguMQ4tYJLYnICX9sFSWORgocmY63hbk+TGt/Ij3l+v9K2F62gFuMH?=
 =?us-ascii?Q?OXshmEBQoykg1OYEE6ezm8dTSi2MV6OFypYSWM/o8j5dF6bm8yTYwxN9i7v4?=
 =?us-ascii?Q?g24sPz7LI2rfoyaHvghyeWLewhdSNJiwFyi68vrw2COjzPO5iH8QWWq8XTOb?=
 =?us-ascii?Q?n1a++8sT5MXTtVwwj+Say0wFvjLO5+dS40G7DxAEIrGn769x6dJt9KBeATbv?=
 =?us-ascii?Q?a05/lIbZmV/7L6jwUcI6pC2OrF/TjlYLvPKcAp0+qoftnSS+m5f6c6u0HoXL?=
 =?us-ascii?Q?RseK5LXE/+FoN1gMRvOfALwZeH2VIE6XzTu6I1oMH48NiO4IfK9z7QtwfyGr?=
 =?us-ascii?Q?BEJaB/VJ/7N/0FCEdWh+QK2O6HbXuTqMavgwwQ2DmpKqumjvzdEcE+B7rhUb?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?l2ti+VTkaP4Tkp9jIw7NCru10AdgaiGmtK4KfAGs1wjbFbSlL/0BNq3+Rbl9?=
 =?us-ascii?Q?6TA+0HJsyjY579Eylx7CokokgEoqamOHmU45KEn7ODS1/aagIDYt9kUxMi0L?=
 =?us-ascii?Q?PlmmxmEIkZCyow5lvmwIrFvgD9w9anvdzKkUiTJK2Ha6EjAt5W6GWK89ZbG1?=
 =?us-ascii?Q?wJ+EfEXOSiKSzqZ78YiaE1dPGMK8auVkiDKKSeQ5EL8OwvDYTSBEUCsSf84G?=
 =?us-ascii?Q?FwihNfAcXNiSotve+cp9kFE9W/8YMdPArgIKAJi3dskxELFxJXfAOHChB4+4?=
 =?us-ascii?Q?fzdi4CBRJ1HsHnXaXfZz8eDQiRMsSQsoxGH7Il0+vbGGFIldhnQ0pgk94j5F?=
 =?us-ascii?Q?UnFYBGv2+ENnX226LYtgTFbPjjZY87UGAJNqeU9Tu78Y8Co1QQJ0S2QMxg6J?=
 =?us-ascii?Q?U9VGUplkja8VrCFZ9/gl7ug0O7dSWJzXWx2lT2lPg9elndkWPeVA1J8xrqsZ?=
 =?us-ascii?Q?RvTfTCFBJ2x9EUVU0zLEJdINjjY4854APdtAV40ZWcw13lOFiDIwLkRvaRG9?=
 =?us-ascii?Q?wQXGIkRJ1+2zYi6pTi43F2XWGQbLGySloXQBVkKeC0aQGqw9GXIz0uDvg9j9?=
 =?us-ascii?Q?uUJBJHSTfJrDO5vUOEFLytrrZK2PQKQTXgTBbVKxB8KQJzqwrCDxzxMJ9Wcu?=
 =?us-ascii?Q?xclyoHiS/DRF2tnT2miT9zZ9ZMrez368B+/5j+o2ybqHvOhThA3v2gSMZLfn?=
 =?us-ascii?Q?r7A8gvcmZitqoFFZuRP3cH3EI/HI8UgV8K7li/JwxYqYMU2EYBav1s/Ru5mZ?=
 =?us-ascii?Q?5K3UQ0qZSoXAog5yt1NMJ6CnRJhReG31Gz4l+L9DFj/RSWR1v+wfnzuod0uU?=
 =?us-ascii?Q?avlqIpqInasqQrYAzm1aALPMsfd23lPRwCMLOObvc5F+e2ace53bnhA1w5zH?=
 =?us-ascii?Q?+6cyrQzUwq3aYrJ4oxBw9a982IZtmZ8ng9WlB6e55QsQQJu4fI5w7mqrZhVu?=
 =?us-ascii?Q?FDC43XxGPDQRVYerlkakCGnqIk9fj3Tosx3lgkeALvIYhTjy53ML10+VNglO?=
 =?us-ascii?Q?bWWSjwbWexQq0GQLEZLYwdU5k3FvpvT7SZ8emGBbYbC8RB6VZE0R6Mytzg59?=
 =?us-ascii?Q?T2qNUz7ipXuxfU4J8Oug8i/Mzob+KyJCkBbuxGlNaUeVbOnt7BKOuDQnZS0M?=
 =?us-ascii?Q?zSaD9waT+LOMY4YUsh84DC/17xGyc1jl0DW+mDcOTQNFyerBkgoymCKPJzj+?=
 =?us-ascii?Q?+QyCtVbPyWx4yoxkXLnmZRpcektVq0q/lExgUD855Tq9dn/W7JVIeafMnleH?=
 =?us-ascii?Q?yy3ks9kC0o9lEHhginESxCG+/U/Wi47TRjq7eZw1Un3BPc+WiPYbyU2P0Sni?=
 =?us-ascii?Q?nJcqyRF7iJbq0xmhDfuu+EorMJmkb0jP4Q6IV5xPYJUD+YDu8y8Bg6CwaecW?=
 =?us-ascii?Q?2bwIqN4Cn++5t7m13aEB3h/O+57J8wFqTojlvnnWIRPFG3hgLXHusVu4I1c5?=
 =?us-ascii?Q?5ZpErcjtAqo/ccfr97j7/z+Kvv8MOfIL9zjFDhWWvS8tgluVjP7baICbK7OW?=
 =?us-ascii?Q?cg9Hx0ldvJxmhwzDROQWOBPygGWqV6p5Y8rUaJFfIqJaPWaOhpkk8PnBFA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b21837-f81e-4f11-9114-08dbdfdca904
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:22.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYdqJLWXDXSRgBAzeqKHTsSYdy+39NMqkm7BY7u4PmFlBlKeOlR5/mWMgGyiZVQkYgDi6k1TTY+ep5UqYLXPVBexKDuaosHVhbdNgLgbA5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: q9W8fxkBWK4Q7nBCVHIzibgcUBRSfdnu
X-Proofpoint-ORIG-GUID: q9W8fxkBWK4Q7nBCVHIzibgcUBRSfdnu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4c7485584d48f60b1e742c7c6a3a1fa503d48d97.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 272 ++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2268d9e23635..f8bbddd729db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6956,6 +6956,142 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+#include <linux/entry-common.h>
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+
+enum {
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+int preempt_dynamic_mode = preempt_dynamic_undefined;
+
+int sched_dynamic_mode(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return preempt_dynamic_none;
+
+	if (!strcmp(str, "voluntary"))
+		return preempt_dynamic_voluntary;
+
+	if (!strcmp(str, "full"))
+		return preempt_dynamic_full;
+
+	return -EINVAL;
+}
+
+void sched_dynamic_update(int mode)
+{
+	/*
+	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
+	 * the ZERO state, which is invalid.
+	 */
+	static_call_update(cond_resched, __cond_resched);
+	static_call_update(might_resched, __cond_resched);
+	static_call_update(preempt_schedule, __preempt_schedule_func);
+	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+
+	switch (mode) {
+	case preempt_dynamic_none:
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
+		pr_info("Dynamic Preempt: none\n");
+		break;
+
+	case preempt_dynamic_voluntary:
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
+		pr_info("Dynamic Preempt: voluntary\n");
+		break;
+
+	case preempt_dynamic_full:
+		static_call_update(cond_resched, (void *)&__static_call_return0);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func);
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: full\n");
+		break;
+	}
+
+	preempt_dynamic_mode = mode;
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
+		return 0;
+	}
+
+	sched_dynamic_update(mode);
+	return 1;
+}
+__setup("preempt=", setup_preempt_mode);
+
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("Dynamic Preempt: full\n");
+		}
+	}
+}
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
@@ -8622,142 +8758,6 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-#include <linux/entry-common.h>
-
-/*
- * SC:cond_resched
- * SC:might_resched
- * SC:preempt_schedule
- * SC:preempt_schedule_notrace
- * SC:irqentry_exit_cond_resched
- *
- *
- * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
- */
-
-enum {
-	preempt_dynamic_undefined = -1,
-	preempt_dynamic_none,
-	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
-};
-
-int preempt_dynamic_mode = preempt_dynamic_undefined;
-
-int sched_dynamic_mode(const char *str)
-{
-	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
-
-	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
-
-	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
-
-	return -EINVAL;
-}
-
-void sched_dynamic_update(int mode)
-{
-	/*
-	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
-	 * the ZERO state, which is invalid.
-	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-
-	switch (mode) {
-	case preempt_dynamic_none:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: none\n");
-		break;
-
-	case preempt_dynamic_voluntary:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: voluntary\n");
-		break;
-
-	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: full\n");
-		break;
-	}
-
-	preempt_dynamic_mode = mode;
-}
-
-static int __init setup_preempt_mode(char *str)
-{
-	int mode = sched_dynamic_mode(str);
-	if (mode < 0) {
-		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 0;
-	}
-
-	sched_dynamic_update(mode);
-	return 1;
-}
-__setup("preempt=", setup_preempt_mode);
-
-static void __init preempt_dynamic_init(void)
-{
-	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
-			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
-			sched_dynamic_update(preempt_dynamic_voluntary);
-		} else {
-			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
-		}
-	}
-}
-
-#else /* !CONFIG_PREEMPT_DYNAMIC */
-
-static inline void preempt_dynamic_init(void) { }
-
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
-
 /**
  * yield - yield the current processor to other threads.
  *
-- 
2.31.1

