Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059787E4B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjKGWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjKGWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CE1999
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJlGq004887;
        Tue, 7 Nov 2023 22:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CdxkzwCkAACo9KhjEACiAY9GZyZVnoZczDrZBjKY/sY=;
 b=2XhRGuye2hzF0IcFdzUOMoqDe5QWyN3wJQpM9ymZ0L2eRDHhsFqcCf5SSBbNDLSRs1vm
 /AE80sJVdHtOltwxS+GkFfFVbIRgfLtuQoRfR1BOHxk/zYaf+TBSRMVGUtLRe2d/u0j1
 QvH7X7JnzNGWr94/ynvlJEXtuT9oGl+UXzgGLOUMocF6pKTosN9rohDXRr9cnOpSGIk6
 BV73Uhht6Lh46qFLA+zNWnZ6I5shSU559AWdqeQ3UHVwOkVR5PM9STi1ECGMWgniG5Nx
 J8TRHPR/3KSH4iqaj50/9hZ5Enraxfefu7QGm+JmLamWmcFhuF/BTjG5yk2p4l3QY5nA 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g2pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIqeI003884;
        Tue, 7 Nov 2023 22:00:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsk8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djpXAETJgBzFHOapNMQ0YIfZDpOaVHpbXzB+bfUAeJ27KpuBjQr8J08/Pw/MU89yJHl4hqV+rX7v4nZ/PljxHDraJdCa3fBwaOl1BX6x/YhQl1WJn2Jmst0VUir6GDQgTf6M8l1N/8ir95fxvCJlGXPvXYiU6odVJsBVnFvC8pbaMRKOmVjeiHXC+kWPeDuYT1aBDCbT35vjYkumzVpuuXLtm6Bs2cMthT4PrRvNNPUzhVG0zw0+/ixhCM85FzBreGAWoi5xk085Wd69ovx2AduO3DJuhULqyGKvYa6KCoJ2M6lUsL/Rng4YB0Eu3b+XPjI1qORbvxlZb3+VZhDuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdxkzwCkAACo9KhjEACiAY9GZyZVnoZczDrZBjKY/sY=;
 b=awc9wqxnz18IHuneUt40zdduwMA8RO/vkaNA2PzA2sdX2F6rRhAG0sDFT7ba6pgyZ5Js6IC4oPYcYN/VBKBBGN5xWnFHI9EcFwVRcW3qzuxilRACkS0kmx+98LLGax90uJnkD8oFnk3uw5njOyVfhksGOKGTse22sFV9PmwJKm/zFloVE/Y28ptE+htgLSzro9N++I4FnqBOglkTTgryTGtQqP641zHOQc2davk6TUMvJBvKBWzRU2cCptu8/w7frlnWgKMotlaWfJ6sesPrEpoE1XOfap8djS8gWjTmMSkyfHbX6nqXKWEvSOCLrXz5Xb/fdhL04L0QBAgbqP3KYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdxkzwCkAACo9KhjEACiAY9GZyZVnoZczDrZBjKY/sY=;
 b=G5uiIqT5Lrgxl7UeXAXXwTP4abnuAZ26aqrM1xmjZsM5isrYpLwjoT5CNYvoUsjbEfYSbXc6qo6scvupQFQA7enoL4Kin6ONPVOci+AhZWAr1iDb1g1lS0P3C1WxW9q0Rt/u41kKnrc2FjsEf+IGnfluS+dTfNa9yiko6GdUNIk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:56 +0000
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
Subject: [RFC PATCH 44/86] sched: voluntary preemption
Date:   Tue,  7 Nov 2023 13:57:30 -0800
Message-Id: <20231107215742.363031-45-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: fae18619-eb89-4604-2b3f-08dbdfdce0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcrHNF16HEXWKX6YVL9Qjs+62GmEz96u1A253vttgdAAtQIS/HRKC7Mejq8UOJnung8dGaVHE6C91jgHOx3iCMVpuHYfH0/Z5kvoGGwDUqMybbZeTT3iXm6VrlLBvC1HwMDq+6clo9Stzd1Qj5G7Yw1+3A/3X3mc59UW9ZcD4Q9YsI2nJPn4+mLPP1Sc3+Ihhm+nxPgVevylYUrd4jlLFmwMSnIoteARAOFoHd0irwD3ieoOVE4NIxFqtgDdb3OoXwQhJFhiaGfbf5PeJpqHkbBet/JeXooTx2iHGs200jOQW+AtequWVtJK+WDoccnLHjCZKtUzxxzOjgEtRMfPoxLzuuPJghVlRdWzzB+A03BuPHltsEiZQSpx7d8xBepwVDPlJDrnRXe9C0Aw+iss4N2blSvSVR5w65IgbPHb0SWKh4iZjRth+Y2wdF8KFBoJLsnX/qp04Vvb9gub2hb6PN2jaNqkUmq4LdSfAbLkshPPbBNlbXI0o+7BD1bXuFwFpnGVy1lFmbkV/66oT9O+b4iXeJWDWeqFq9uMViC3J5g9y0i3WJA7X94Xy9eDTDJS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(30864003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3lHyT/l9tb7jyKRnD+wMaBDy2dt5fzGtoTROACr2ZIJHS0FGu0eW611HGae?=
 =?us-ascii?Q?cVN+rYd/Y6Ljw0UYgTL3ri19mexM71COqPPZLxRo8xGhmsaXCHeQHk6trv71?=
 =?us-ascii?Q?4xmJPFtAJtL8VwmfDABjFk3KKTHp2cxCnB8hkAsWFKIlWYo42xJorAPQyoS7?=
 =?us-ascii?Q?n0UgszbdVbvXmjF8VSwVvAs7vWaQvZHcrcJoPGgNaJJP4nhmNQmpTeYREqfu?=
 =?us-ascii?Q?IX3f6AIMDKp0X3OuScy8LVBBL6A3uV1pKql8H5e19QbrgTJhuvNvwnwpZYMn?=
 =?us-ascii?Q?6+eZ1qsrCwQ7e5pkgEBKhiINOE7XkmL5B8q8MbRm84iNkHDcgjg/TpEkr5EE?=
 =?us-ascii?Q?1TzdT85oi9G17LpAR8/5RxKt6MmWYqz1JTpG2Ph7QexaglISCIf35VGlc8Jj?=
 =?us-ascii?Q?RSC2eEXOf7wL4ksYmGMl7+kVyic6W2zSoLsPrUG0EE2anpgUpV7gN5hUbqwK?=
 =?us-ascii?Q?RLfuX21hG3497YQzW13Ixh2FVU17QOClMm6XPCnZih+Xl+oaJjhYLJ9ALVyH?=
 =?us-ascii?Q?0l4haTOGs3Ux3OX5jP8julJIZz5ViboaMaMD2Wdc7tBPQzQ2LD7+04mwy58R?=
 =?us-ascii?Q?fOngSYG9hKyVOZ/B/bVGcFsNAcNzb2vvlr/DAvgAgxTXN1n2HDotYOfbLgql?=
 =?us-ascii?Q?hu0tCvRNNM/afnWJiY/xyOiLAT3wf3070KJtk6bwx18UFkX1L7hlM9kw6Kqj?=
 =?us-ascii?Q?krvcRkL3YGdUihcv9rxAdvf9rduE+372dzXSIYeFaamr7HOBb0jzGsBscDVR?=
 =?us-ascii?Q?hpQWzqN6UCjPlo6lkFC8kD/ftbxw/Ug3LYB6aPKa5QJ0HX/9RtboPN1Rlt+N?=
 =?us-ascii?Q?nP6Oc3pn4mmqOb+xBayN0owMTZdpN5gtUkMUtAR9G6TC4XHRVvFS2UN4cxCN?=
 =?us-ascii?Q?iZXC24yEGDZC9aKq7qVvGSSMOtAYIiRkfycXewKI/8n2TUTrzj8RrungE8/j?=
 =?us-ascii?Q?O8uTqbC6zjAxEoH99LVehcVvwjTotMLjFLixuiXPSYo6iPL4cr+Ir2fkPVDP?=
 =?us-ascii?Q?+cqRivDPwU1tR7+WexVhhLe99L6YofvrxiLBEkn7pvJoEKw2RDNutwb8V+Hb?=
 =?us-ascii?Q?HZzWGG8me929I6SpD9RxiQN5MZxXyFsKF/upBD/7TstDk5TXDCBjzXYQg8HZ?=
 =?us-ascii?Q?uzD7SuQdzBJ6FKMJ0qsQbdkdw7by8Uh95B4CQrLM5KLzYgLzGwS/X0EV7zVC?=
 =?us-ascii?Q?mkuUiapGmY4CZAjiOgO1hQTKiO9ygT3YdLT05QeShaWTJMktEJTVSTRP92QA?=
 =?us-ascii?Q?1Rp6zHIGYvp6snuUTE2X7j277ZalCUvFsBlF54TiAKVYAu8V5xS3CpVuEQoE?=
 =?us-ascii?Q?s+t3tOKu7ICKjR8TJggC1sGajrXuG1kVZOCgze31IffS5PBmpuc1DhgEi1N/?=
 =?us-ascii?Q?cnpTqwsRnkmg5F3dIeiQbrzKTVgzibCY0fBZNVURu7s8cUWn4SjDt8YjZGuj?=
 =?us-ascii?Q?SwApFox821ev30U53oQELPz/m/6xqd+5n6QB+zO4k339C4xV8Uy0IKLXA31f?=
 =?us-ascii?Q?DYLhtUGOg6U7NPWFHGx4720iWNs3i5zyO/OAJo0kXDJcgwbcS6q0Yy3TIG4H?=
 =?us-ascii?Q?Hwgy9omk8VlXUz5eboSA5qBUKuoBe4l6SG1XMv8D4IzGZuZAPEb/ZE1jVZYP?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MjJ64ByBNDc46wczT0TW+PAYnw1m+ObRE1W6CAVZINNBk19j+3jV6rVs6Qzg?=
 =?us-ascii?Q?OwKVujNAOJ9sQ0lDve0lnnWaeeOi7OH92pA5371Vut+oZNqleGAbHpnZqqN5?=
 =?us-ascii?Q?JDpqn7rk1A9NlkdMbudOlHOzkfZNyDscNEQXx+l2ATWCtanF4nfHFpYdyIDD?=
 =?us-ascii?Q?UA2sAoKUT8gv5UViZAGXNEURCWffJpakeBEZjziUQm4T69FlLib6BitIbLho?=
 =?us-ascii?Q?AWDrAaPZGnwU733phc3Zk2dXR2VvGBPLVPCcKUnMpz0qPZQCsbB7VfnGa/9g?=
 =?us-ascii?Q?OgLJkA+va4s6eHEs/Frhp/+n45B7EwWGa2cX61slY2RqLqZ7boe7U0aiWUyt?=
 =?us-ascii?Q?O5I0tth+quyEQ3WKH4ezouzsfhWGDG2vGBAfG2PMEvAaOu6qa7XFpE5xeK4+?=
 =?us-ascii?Q?S5kT/MeUm7TEq3e6mQiR+2Scl/sp+uTbri4VlIHovUhZo+m66qAmVNxq6uZb?=
 =?us-ascii?Q?JdSUDPIm65XglkI7yi/ZyAN9I6m/JX9Ks9+KM8+W1D9FPWSELhm179dSEdRR?=
 =?us-ascii?Q?ha+8ocNaa8QX0O6fnUTjO0hPci0ajObFcUJt7IEQdqAmv1/lG1zs5jtEBXkY?=
 =?us-ascii?Q?NnadTLULxMED0Hy2OXmztu/GU3hxsEBK/6vXuG9Bed9KUu0s8+tmBydDq1s+?=
 =?us-ascii?Q?xLF3hXbLVEouNIeldftjN+O+RMs96FsVABws7wcWi5ououmd5dCzvt8NXWl4?=
 =?us-ascii?Q?4Mc8EiTGQZn5OW+LFUuLoq374jsbArGGnAgK7yg3CRAg61mC7KdaVh4Q/UeZ?=
 =?us-ascii?Q?CR58+CyyAxaL5O1gd5mHdCp5RsikfRCbWaGQo0AgWQnkMA9VnPxBSnCp2BTb?=
 =?us-ascii?Q?sTixrM/RForO5f3N7T4LgZ8N0+hQz3TK0DYQ0IDnXNiw/zrTyCjWfxjvEKSS?=
 =?us-ascii?Q?MgYoArXXvGzsklYTK3d2RQflMUla5aj8Rmcxv1wO+2IDByDiV8C/I7/u7ac3?=
 =?us-ascii?Q?tJXVRbCNpHYbuDDADtCE+kI3BJXJVs51byBZNCPzFacTGTs2bxnqGQ/w+yQm?=
 =?us-ascii?Q?WsoX1RkfC4mBIhb97NV/H0dpJXSI2yNWlyTcGRXwc1Uy3OD+b0mjQcM84MS6?=
 =?us-ascii?Q?S3coKB+Mt2wsqVAF/JttV9QL5ljj1y+h08J0X1iXolJiJ9udHudGKv1+bAUE?=
 =?us-ascii?Q?Ir561F7H8rF7KerDfCNcJyHU83yj0NQwYqFgK/I48CBi46rCdY05ngA4ia77?=
 =?us-ascii?Q?Vt9TQ8gs9SB3F7QsPWEt0Jjg7nkSRIguoMm7CvO7laXii7+iwQEJgfjWwfBx?=
 =?us-ascii?Q?klDY0YbGMahzMpA2qJhvLuGw9DeuDfkZICeV54dw5/oHs+PyBZVH0dsQFuP3?=
 =?us-ascii?Q?wvwFz/u0i9XdxfsmeTs3LbIaE0XhODAyC1Lsae6UvGR9o7dRrLCMocQ6zPnz?=
 =?us-ascii?Q?y0I2iPNYTTYqi6tSmHeAg/T5+ePTRTgoGUTaIG8Gvvry26qg1h5JQ60K0kjp?=
 =?us-ascii?Q?tPw8bhOywq+zZ/aVbpKQUufHLuMbcFnvgMWnm2hLywj74nEboDL7t4YG4KbL?=
 =?us-ascii?Q?l+NW544COHKGxCjChjCiOJt2XS+uOSP4pBTjbFB6WVKy578Ml/V7GiruFA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae18619-eb89-4604-2b3f-08dbdfdce0fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:56.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdPLdqeBIBX7N4Zn3RGRhPYNDrh2StKMpLniMPQN8J/os3hO7+Am5orAn5qQbqAcX9hyT0CZdb1lBXhRBem4yVdLgd00ddOcVXG3fRbak/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: jzM4HBniecIoK4u9dcdfa1gInCBXSEV-
X-Proofpoint-GUID: jzM4HBniecIoK4u9dcdfa1gInCBXSEV-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The no preemption model allows running to completion in kernel context.
For voluntary preemption, allow preemption by higher scheduling
classes.

To do this resched_curr() now takes a parameter that specifies if the
resched is for a scheduler class above the runqueue's current task.
And reschedules eagerly, if so.

Also define scheduler feature PREEMPT_PRIORITY which can be used to
toggle voluntary preemption model at runtime.

TODO: Both RT, deadline work but I'm almost certainly not doing all the
right things for both.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/Kconfig.preempt    | 19 ++++++-------------
 kernel/sched/core.c       | 28 +++++++++++++++++-----------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   | 22 +++++++++++-----------
 kernel/sched/fair.c       | 18 +++++++++---------
 kernel/sched/features.h   |  5 +++++
 kernel/sched/idle.c       |  2 +-
 kernel/sched/rt.c         | 26 +++++++++++++-------------
 kernel/sched/sched.h      |  2 +-
 9 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 074fe5e253b5..e16114b679e3 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -20,23 +20,16 @@ config PREEMPT_NONE
 	  at runtime.
 
 config PREEMPT_VOLUNTARY
-	bool "Voluntary Kernel Preemption (Desktop)"
+	bool "Voluntary Kernel Preemption"
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	help
-	  This option reduces the latency of the kernel by adding more
-	  "explicit preemption points" to the kernel code. These new
-	  preemption points have been selected to reduce the maximum
-	  latency of rescheduling, providing faster application reactions,
-	  at the cost of slightly lower throughput.
+	  This option reduces the latency of the kernel by allowing
+	  processes in higher scheduling policy classes preempt ones
+	  lower down.
 
-	  This allows reaction to interactive events by allowing a
-	  low priority process to voluntarily preempt itself even if it
-	  is in kernel mode executing a system call. This allows
-	  applications to run more 'smoothly' even when the system is
-	  under load.
-
-	  Select this if you are building a kernel for a desktop system.
+	  Higher priority processes in the same scheduling policy class
+	  do not preempt others in the same class.
 
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a50a64255c6..3fa78e8afb7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -256,7 +256,7 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (!(flags & DEQUEUE_SAVE) && rq->nr_running == 1 &&
 	    rq->core->core_forceidle_count && rq->curr == rq->idle)
-		resched_curr(rq);
+		resched_curr(rq, false);
 }
 
 static int sched_task_is_throttled(struct task_struct *p, int cpu)
@@ -1074,9 +1074,12 @@ void __resched_curr(struct rq *rq, resched_t rs)
  *
  *  - in userspace: run to completion semantics are only for kernel tasks
  *
- * Otherwise (regardless of priority), run to completion.
+ *  - running under voluntary preemption (sched_feat(PREEMPT_PRIORITY))
+ *    and a task from a sched_class above wants the CPU
+ *
+ * Otherwise, run to completion.
  */
-void resched_curr(struct rq *rq)
+void resched_curr(struct rq *rq, bool above)
 {
 	resched_t rs = RESCHED_lazy;
 	int context;
@@ -1112,6 +1115,9 @@ void resched_curr(struct rq *rq)
 		goto resched;
 	}
 
+	if (sched_feat(PREEMPT_PRIORITY) && above)
+		rs = RESCHED_eager;
+
 resched:
 	__resched_curr(rq, rs);
 }
@@ -1123,7 +1129,7 @@ void resched_cpu(int cpu)
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
-		resched_curr(rq);
+		resched_curr(rq, true);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
@@ -2277,7 +2283,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
 	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
-		resched_curr(rq);
+		resched_curr(rq, true);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -2764,7 +2770,7 @@ int push_cpu_stop(void *arg)
 		deactivate_task(rq, p, 0);
 		set_task_cpu(p, lowest_rq->cpu);
 		activate_task(lowest_rq, p, 0);
-		resched_curr(lowest_rq);
+		resched_curr(lowest_rq, true);
 	}
 
 	double_unlock_balance(rq, lowest_rq);
@@ -3999,7 +4005,7 @@ void wake_up_if_idle(int cpu)
 	if (is_idle_task(rcu_dereference(rq->curr))) {
 		guard(rq_lock_irqsave)(rq);
 		if (is_idle_task(rq->curr))
-			resched_curr(rq);
+			resched_curr(rq, true);
 	}
 }
 
@@ -6333,7 +6339,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			continue;
 		}
 
-		resched_curr(rq_i);
+		resched_curr(rq_i, false);
 	}
 
 out_set_next:
@@ -6388,7 +6394,7 @@ static bool try_steal_cookie(int this, int that)
 		set_task_cpu(p, this);
 		activate_task(dst, p, 0);
 
-		resched_curr(dst);
+		resched_curr(dst, false);
 
 		success = true;
 		break;
@@ -8743,7 +8749,7 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 		 * fairness.
 		 */
 		if (preempt && rq != p_rq)
-			resched_curr(p_rq);
+			resched_curr(p_rq, true);
 	}
 
 out_unlock:
@@ -10300,7 +10306,7 @@ void sched_move_task(struct task_struct *tsk)
 		 * throttled one but it's still the running task. Trigger a
 		 * resched to make sure that task can still run.
 		 */
-		resched_curr(rq);
+		resched_curr(rq, true);
 	}
 
 unlock:
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..32f234f2a210 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -89,7 +89,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 * next scheduling edge, rather than always forcing a reschedule here.
 	 */
 	if (task_on_cpu(rq, p))
-		resched_curr(rq);
+		resched_curr(rq, false);
 
 	task_rq_unlock(rq, p, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e6815c3bd2f0..ecb47b5e9588 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1177,7 +1177,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	if (dl_task(rq->curr))
 		check_preempt_curr_dl(rq, p, 0);
 	else
-		resched_curr(rq);
+		resched_curr(rq, false);
 
 #ifdef CONFIG_SMP
 	/*
@@ -1367,7 +1367,7 @@ static void update_curr_dl(struct rq *rq)
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
 
 		if (!is_leftmost(curr, &rq->dl))
-			resched_curr(rq);
+			resched_curr(rq, false);
 	}
 
 	/*
@@ -1914,7 +1914,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	    cpudl_find(&rq->rd->cpudl, p, NULL))
 		return;
 
-	resched_curr(rq);
+	resched_curr(rq, false);
 }
 
 static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
@@ -1943,7 +1943,7 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
 	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
-		resched_curr(rq);
+		resched_curr(rq, false);
 		return;
 	}
 
@@ -2307,7 +2307,7 @@ static int push_dl_task(struct rq *rq)
 	if (dl_task(rq->curr) &&
 	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
-		resched_curr(rq);
+		resched_curr(rq, false);
 		return 0;
 	}
 
@@ -2353,7 +2353,7 @@ static int push_dl_task(struct rq *rq)
 	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
-	resched_curr(later_rq);
+	resched_curr(later_rq, false);
 
 	double_unlock_balance(rq, later_rq);
 
@@ -2457,7 +2457,7 @@ static void pull_dl_task(struct rq *this_rq)
 	}
 
 	if (resched)
-		resched_curr(this_rq);
+		resched_curr(this_rq, false);
 }
 
 /*
@@ -2654,7 +2654,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		if (dl_task(rq->curr))
 			check_preempt_curr_dl(rq, p, 0);
 		else
-			resched_curr(rq);
+			resched_curr(rq, false);
 	} else {
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 	}
@@ -2687,7 +2687,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 * runqueue.
 		 */
 		if (dl_time_before(rq->dl.earliest_dl.curr, p->dl.deadline))
-			resched_curr(rq);
+			resched_curr(rq, false);
 	} else {
 		/*
 		 * Current may not be deadline in case p was throttled but we
@@ -2697,14 +2697,14 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 */
 		if (!dl_task(rq->curr) ||
 		    dl_time_before(p->dl.deadline, rq->curr->dl.deadline))
-			resched_curr(rq);
+			resched_curr(rq, false);
 	}
 #else
 	/*
 	 * We don't know if p has a earlier or later deadline, so let's blindly
 	 * set a (maybe not needed) rescheduling point.
 	 */
-	resched_curr(rq);
+	resched_curr(rq, false);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe7e5e9b2207..448fe36e7bbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1046,7 +1046,7 @@ static void update_deadline(struct cfs_rq *cfs_rq,
 	if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
 		__resched_curr(rq, RESCHED_eager);
 	else
-		resched_curr(rq);
+		resched_curr(rq, false);
 
 	clear_buddies(cfs_rq, se);
 }
@@ -5337,7 +5337,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(rq_of(cfs_rq), false);
 		return;
 	}
 	/*
@@ -5483,7 +5483,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	 * hierarchy can be throttled
 	 */
 	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
-		resched_curr(rq_of(cfs_rq));
+		resched_curr(rq_of(cfs_rq), false);
 }
 
 static __always_inline
@@ -5743,7 +5743,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
-		resched_curr(rq);
+		resched_curr(rq, false);
 }
 
 #ifdef CONFIG_SMP
@@ -6448,7 +6448,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 		if (delta < 0) {
 			if (task_current(rq, p))
-				resched_curr(rq);
+				resched_curr(rq, false);
 			return;
 		}
 		hrtick_start(rq, delta);
@@ -8143,7 +8143,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	return;
 
 preempt:
-	resched_curr(rq);
+	resched_curr(rq, false);
 }
 
 #ifdef CONFIG_SMP
@@ -12294,7 +12294,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
-		resched_curr(rq);
+		resched_curr(rq, false);
 }
 
 /*
@@ -12459,7 +12459,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 */
 	if (task_current(rq, p)) {
 		if (p->prio > oldprio)
-			resched_curr(rq);
+			resched_curr(rq, false);
 	} else
 		check_preempt_curr(rq, p, 0);
 }
@@ -12561,7 +12561,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * if we can still preempt the current task.
 		 */
 		if (task_current(rq, p))
-			resched_curr(rq);
+			resched_curr(rq, false);
 		else
 			check_preempt_curr(rq, p, 0);
 	}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 9b4c2967b2b7..9bf30732b03f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -92,6 +92,11 @@ SCHED_FEAT(HZ_BW, true)
 
 #if defined(CONFIG_PREEMPT)
 SCHED_FEAT(FORCE_PREEMPT, true)
+SCHED_FEAT(PREEMPT_PRIORITY, true)
+#elif defined(CONFIG_PREEMPT_VOLUNTARY)
+SCHED_FEAT(FORCE_PREEMPT, false)
+SCHED_FEAT(PREEMPT_PRIORITY, true)
 #else
 SCHED_FEAT(FORCE_PREEMPT, false)
+SCHED_FEAT(PREEMPT_PRIORITY, false)
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index eacd204e2879..3ef039869be9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -403,7 +403,7 @@ balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  */
 static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int flags)
 {
-	resched_curr(rq);
+	resched_curr(rq, true);
 }
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5fdb93f1b87e..8d87e42d30d8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -589,7 +589,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 			enqueue_rt_entity(rt_se, 0);
 
 		if (rt_rq->highest_prio.curr < curr->prio)
-			resched_curr(rq);
+			resched_curr(rq, false);
 	}
 }
 
@@ -682,7 +682,7 @@ static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		return;
 
 	enqueue_top_rt_rq(rt_rq);
-	resched_curr(rq);
+	resched_curr(rq, false);
 }
 
 static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
@@ -1076,7 +1076,7 @@ static void update_curr_rt(struct rq *rq)
 			rt_rq->rt_time += delta_exec;
 			exceeded = sched_rt_runtime_exceeded(rt_rq);
 			if (exceeded)
-				resched_curr(rq);
+				resched_curr(rq, false);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 			if (exceeded)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
@@ -1691,7 +1691,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * to try and push the current task away:
 	 */
 	requeue_task_rt(rq, p, 1);
-	resched_curr(rq);
+	resched_curr(rq, false);
 }
 
 static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
@@ -1718,7 +1718,7 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (p->prio < rq->curr->prio) {
-		resched_curr(rq);
+		resched_curr(rq, false);
 		return;
 	}
 
@@ -2074,7 +2074,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * just reschedule current.
 	 */
 	if (unlikely(next_task->prio < rq->curr->prio)) {
-		resched_curr(rq);
+		resched_curr(rq, false);
 		return 0;
 	}
 
@@ -2162,7 +2162,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-	resched_curr(lowest_rq);
+	resched_curr(lowest_rq, false);
 	ret = 1;
 
 	double_unlock_balance(rq, lowest_rq);
@@ -2456,7 +2456,7 @@ static void pull_rt_task(struct rq *this_rq)
 	}
 
 	if (resched)
-		resched_curr(this_rq);
+		resched_curr(this_rq, false);
 }
 
 /*
@@ -2555,7 +2555,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
-			resched_curr(rq);
+			resched_curr(rq, false);
 	}
 }
 
@@ -2583,11 +2583,11 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * then reschedule.
 		 */
 		if (p->prio > rq->rt.highest_prio.curr)
-			resched_curr(rq);
+			resched_curr(rq, false);
 #else
 		/* For UP simply resched on drop of prio */
 		if (oldprio < p->prio)
-			resched_curr(rq);
+			resched_curr(rq, false);
 #endif /* CONFIG_SMP */
 	} else {
 		/*
@@ -2596,7 +2596,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * then reschedule.
 		 */
 		if (p->prio < rq->curr->prio)
-			resched_curr(rq);
+			resched_curr(rq, false);
 	}
 }
 
@@ -2668,7 +2668,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 			if (test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
 				__resched_curr(rq, RESCHED_eager);
 			else
-				resched_curr(rq);
+				resched_curr(rq, false);
 
 			return;
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e29a8897f573..9a745dd7482f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2435,7 +2435,7 @@ extern void init_sched_fair_class(void);
 extern void reweight_task(struct task_struct *p, int prio);
 
 extern void __resched_curr(struct rq *rq, resched_t rs);
-extern void resched_curr(struct rq *rq);
+extern void resched_curr(struct rq *rq, bool above);
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1

