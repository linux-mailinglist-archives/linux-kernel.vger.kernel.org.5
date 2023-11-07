Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD797E4B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbjKGWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjKGWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57DE170B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:37 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJxhu005003;
        Tue, 7 Nov 2023 21:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BBDmbv6t4bIOhWhjzk0+j/+zRLSLKl8O3zxrtXMpl2w=;
 b=ZDOclOr4G2PrWZ6+HxqGb70r5MHoymMHcmX8wHc47Iv+SvpKiHBEfsBU861rFb0zfxDm
 Bp0F3eT3rce7qGohEpobkd0vN0zj6JVe/kjKaIZKwWGNLxGFCdNA08jBv9w0RmeLDHxU
 7buWOMYaHYjuJ49HnN1ULyqitNAw95MPsqq2dnaT1+GzRMqQQywaFjjcL12XPhIP/tn6
 +5v5rucYVDi9IgVOt/HlQ0KgNCOLOQEiB2RYdC1V8fZo+plehErRUm8TkD5XzQNbPJdo
 21XDwC+k4HWJHvmJsneisc/GMWv35oTJzNQsus2vzKPKt+FUzPTe5KYbGyGkyZaPAO5c ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g2ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgcS011085;
        Tue, 7 Nov 2023 21:58:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tshe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYTitQ4jqh/i5JJX0EPXgQ0BT6LWg9OOutFla5ja7+Vcy1m048wtu0wt6wdfUWwWrLNS3CQQg1EFACpNRi5JKi9R5TVf4Jx3YUAKJ0rX2Gd1fG8xdGfIQpiUYmDo1Idx8DRg8Ha7UpPI017N/ptHCWelPMjfVkcS4VC8srj0Dv39nYs8xpllfTSog2yGDs8mKKCSNEkZPifq1Ia5rhO9LCZedRNccfN9xOdguDykpz7iile4khqJ+TsV/Js03jxDQmfMKBsC6vkV2T2+wAE8oNLAZMahKs4k9dYj9k6WTrvr7MGqq9uz5CYD1k6R9hZm0Z3B1u4sP83GNI6k0qMYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBDmbv6t4bIOhWhjzk0+j/+zRLSLKl8O3zxrtXMpl2w=;
 b=bTLMMds55AaXrlK1fC7aeAZFWiqK2iR3rBonf3NgKQY5AlMZOnuFrKeAXNDEUqIAYApqvuO5hbYmXlxMMIkQ3WlOPofJ2KbOq1Pq+e7Gc6PhWDeyNg3KdM4yJU7mpQhlznuzDnDKCfl2NPOZpv4+z48qoHso0uIGe2S6famRYGnqOqEd5MSjYLeXf131EjKu8+i8oB4wEEy1sY/5pioO2y6wDRd9NLdN+3VtWkk4SLiKD5CWXE7scGA7hhoCWobUYxh0VvZq52dL2iQ6CaXXB/MACqCLGJSaWrkgrFM65bsh8oXmwOFDk4sCUWcOgEG/J5kzzkdiFgOKd5AGiigspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBDmbv6t4bIOhWhjzk0+j/+zRLSLKl8O3zxrtXMpl2w=;
 b=yVbV1gaOJmgux4lmQf9yMhbmLpOWWj/o5q1CVvjFjKoB1rPmt08jQpFwwibKT1Yk8VUepsNB8+TPrKOuGxE+JjCopafimCqvXO8cQyYJAx6rEANA8wBaJf1Tr+ohNKURGaBd2FvWlEAURxN8zu1YvIvH6pQr65jGFmklvqKq0pM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:29 +0000
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
Subject: [RFC PATCH 15/86] Revert "preempt: Restore preemption model selection configs"
Date:   Tue,  7 Nov 2023 13:57:01 -0800
Message-Id: <20231107215742.363031-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: f01641a2-ede1-46cb-e880-08dbdfdcad56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCgrjoYkbWxj3GPOynMkL+z5Yh/VD3qrQqGM6KzOI/1GSsUv8ywVISCHEf4Ie7ChOOkI4Fn3bOFJ/4H3B5Fy5CpfsbqGK6F93/cNYxhOJgfZCQqddhW3IC7tsntvUuy/RkxSEQM7yP9oFp2UAPqVJXer4Yq1KXE5StDrpzVZo9Uc7m/KjZZclzM97OR1l6bUH4UvGp7ktjhxlo2SPXx1IAb+3PA1VYWO3K8erHdnMIrPHCfx8Zw3UjYP6GcIuPbvr6mCTZ8fo592+NBG7lJufL4khuRYqZIk+5eKHu9dn50e/fGS43UdP2ehGKNIL/8v8SqirP2gMR3PZVM6qFO34kcw0K/ldmw3SSzMzTXsODdqcKja7c8POH3aR35HHh4fvFei40wNE8RlO21/7UrCaUYlKmApXt0UT3vImzZAIHepY6Stm8LgUgzNVZDlpMWAzuPypsjNlDAmi4d2wmLDM5h24AA9axNDJiT3j/kBbRNDh8c4wr34D/eb1ZH+6MqoUBGR8YDI9B3iMe1t2NVljilxtYnuNdKc7VA+Hn1T7qX3DK6G9WrDbdsEd3xXEMgf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psFjpO4w1m1a/bNaO2laBdNnimFtNZgoOw/MaX3BJIgM1BJ+ZRl2YFu32/M5?=
 =?us-ascii?Q?N4dJI30U53bYA2uvL6VgF/+4Jsm3FohKcSk3ns4He58KNTXlHBEhFZTXuGAl?=
 =?us-ascii?Q?crlaIhgH85fHoRoNPFyTYca9jYOb49mMP4JUGJu+0Kb4rg7w3NSMrfvwVxfK?=
 =?us-ascii?Q?QhRghVYHnhbBmUM9T45YBdjj2vXU8+0ha9h1dSJAJaCIfGJoBH/NOZailPlO?=
 =?us-ascii?Q?hJjUrhl6T/tNkEz7eFYWUpN7X/h28fXghg4OnpyYrRBtwiHoGacXtGHm2nLM?=
 =?us-ascii?Q?Dzc66miz+JAdbo334LCK6aUCp8Nq067jma2Ve6zYJAUYZRiRYthugfDA3dtB?=
 =?us-ascii?Q?eLSDQIX3i0hkTdr5PGvHHtvEivctP8nDjBVqyDN/QWm6AbAkKx6noRgNrxBo?=
 =?us-ascii?Q?ZRwGn2lziobyFLfPbqREnBuYOIuKvApPs7GHuQlGtrPB5tTRaMuqQS3M3t1Q?=
 =?us-ascii?Q?EFJOcqy4pJd0Es1CNxFDkxyM2BM87/RC/rJ1ovczdtHJZdKa8qom56nKJC+W?=
 =?us-ascii?Q?AC25Ne6Q8lAMJCp1w897lD8ivJCE1HRJ2JPa+0jclyqq1HDBgM8vKm9D0EVr?=
 =?us-ascii?Q?XLUMbdXeFr05zlglFoFtaxH72QpXVUAqFUvoMCCy1lkrDV06ycdWUh3xNtES?=
 =?us-ascii?Q?mhQbyRCI43gMs05kaQV7yJqfBewS2yc8qn6a/yGd9TPz88/SL8UwL28jhnVE?=
 =?us-ascii?Q?olgHz/mMQKbY3g10+77l95A1rMw3KUGSIja0b+xl0uuz5r5fB7QSFEZNcZ4d?=
 =?us-ascii?Q?mrdcrHqlQjpKxvxtTmo3Ekr/OKBMk9gqOdDd85wH0n8CZau4QjOwabrpFQoB?=
 =?us-ascii?Q?KcvHfeR6TieN0QJe2NhargUTJFhJMC888gJZc1WsIk5LTNeEp/FPU3NE2S8x?=
 =?us-ascii?Q?WbrQwvvGjlyEwOBjgKH8Z/OX895EIwSrhRbDuH62aWn3Xb1cMD7K7CwjuMVJ?=
 =?us-ascii?Q?tRhYYS+ecTMF6sELdc1smgkvrtTkBzMJ6cuFmnRUcoQXxBSKyUh5PkqiHiCV?=
 =?us-ascii?Q?8dx+B8NM7gxoUbASh1/QIjxw3JdWVNc76KDf8fvF7OwgU0VOrUas/A4BXHid?=
 =?us-ascii?Q?4l3WvnCWgoGovTP1zxBJZd0mQkDk4RvX2S4IBO8NoSDZHnNeD+ZksUNfh05l?=
 =?us-ascii?Q?AEKbFMwa8ohwYw/JtZ1sWi177KFiPKJyRpvnPT5H//q0V7EM2ETGWStIHV5+?=
 =?us-ascii?Q?V68GTkP79uh95mwKy9LQf6TDN/1zimTfUjhC49/ftXNxktXO9p5xYky3b/11?=
 =?us-ascii?Q?QBUBkdX8JZCjc1TQYytvOociv9fM+7/mtMT0jatXYZQx0DP7lzFzftPTdFsU?=
 =?us-ascii?Q?/+p6RMHVNvq9WCHJj9nLsSGm605+QsneHE+qxxvUZBJfU56+LanrM8BoaT6D?=
 =?us-ascii?Q?Nl+j+U9kAkVAZOOv6MHsJcWLuAujHAenCaaBy6IMhLatgs80cY1nNvII4ed8?=
 =?us-ascii?Q?rIHjOvGDUQd+kap2YAkJup9z9j9cpokFO94M6XrqbacXmwWMLrbL9AvZ8Gsk?=
 =?us-ascii?Q?T9SZMe/5Bhvyw8lq0mH651hab7cw2Bxw3PngdRHvqIEs3wY9/EjnThQhaSsP?=
 =?us-ascii?Q?dzRAx+uKy+Pzb3j441Aj2pL31TAEPI2kVj5XjAl7ROvTFOPQmkG1wRzR1NIL?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pnA2se8/0DmbGMfbXY9x9WRMsxoGBnyw50xK6NKxKQyLRa+CCsdbk14tNpin?=
 =?us-ascii?Q?LkurH7zPsxFmkZ3Tm+SUkT6ISKW7IL2VqZOKz0mg3siFowGFXIdfR+FcVLRK?=
 =?us-ascii?Q?a+amDIEgSGKq7/SFMeZVNzYfEBdWti45Frgp9JHiO59XmCY63D72beBnA+ey?=
 =?us-ascii?Q?vJcO4Mqp+gEezBijl9hT0QjMZ388VzSARyOJIfTTiqgV2JMoC4H+04RLJiJQ?=
 =?us-ascii?Q?ulesZX06UUbgOQLRx8MrWFN/L4u0bYRfE3leSiuyTClr7J6R6QO3TKqByDdv?=
 =?us-ascii?Q?X3k19Dlv5/HG0MM+R3JS2pxF1W6FbKuAs8SHbRY3WE79G6i6SnjW/khJWbPv?=
 =?us-ascii?Q?wMkupQF6T4VN1HxZfCvd2eNsrKQ3KdhuyWgckhlsJa1vAFVSLSye0mqYTbVW?=
 =?us-ascii?Q?tNhZayoHgMTEKv7STYweCbUaV2XhzNHW7vtEAKheMm9a2YaqQ4Vq5IY3mFDm?=
 =?us-ascii?Q?bCxRIRtpnO/UeH9AQ8G6wKNdmoL2hyegLE3/NBdOzfOZpTQRKZRcwT3i4qrj?=
 =?us-ascii?Q?DfiXsGt8PyQZyaYmqRmQ8XVKP3TCw4Zy6+oUQHlFuF6tSa1XTGBc5bh8JnmW?=
 =?us-ascii?Q?vy8AV1Na3MBMlun8LaTiZ1oXgWNTZyHNxi0rzBvlUB+Bw22Z1GksLXzCdhu2?=
 =?us-ascii?Q?57eE8vhmAhYmiEFIrvxTUQr40N7i2cbSbzh3+gtQhLaQkhZFPrZFgH10jwvz?=
 =?us-ascii?Q?jmxBEQVSG9DlY544BGbUQOpMT2EVmMt+/BLbLu6qiPV0YRrp3XdMomM80tIC?=
 =?us-ascii?Q?JnKQNh6Z/DtcJAAKGmkH6QWNPeoK2P8ZqV96cx1XkXfOhaiasiUQS188aIVB?=
 =?us-ascii?Q?kQmnRW/FhWxi7/IN9f7ZuTcIqkmCrC58SqnWK5dkpbtHQIjTFAq/q6lC9FoL?=
 =?us-ascii?Q?Ec9b7ddauADNe62vS3uB5vZUKOGIW5PfecJQi3+Q0czeFNWL4RJZC/OXErXr?=
 =?us-ascii?Q?ZgfAN058PkE8RpE8G3RJMI5Q4erRo+L4I62vC61JgX1Pda3S13yn4tleh7ys?=
 =?us-ascii?Q?tctP81T88FqUYgcvlpkTXahq2SA9KlatBfB3kw5UhCZTTJge8JrlJ9VuVyAQ?=
 =?us-ascii?Q?Wj5324ZaNsOOVLNXxlBusuEbw5tf5FD50skRXADVxqLXjHuT5jR2WXTVFUDG?=
 =?us-ascii?Q?wyRIjXDoqJFnbcXg2jQHLevpH/dmLQJOKvK8O7QxnZr8uuVPuxF5Xshldt5x?=
 =?us-ascii?Q?mi9uTOvheluTLr9NkqEITIrW50hsCRb7/Ci3sXZOKZno09dqk2mdr5pIL3kN?=
 =?us-ascii?Q?MDIKIEr8DnmES0RXB92e92Ck7iOLl/e9vuWFnj+nTmx+aQAhMByeea3HUMzA?=
 =?us-ascii?Q?GeUtezGcO87+QCA297uIOvAi5/7Akzzyr3EjSvWIBFm9uh6ry5XaY3U1tRGA?=
 =?us-ascii?Q?HMf4vVwi5iDm4KmEa9pRz7JqJrpgXiDqtK2lmL+C/9oyFqsZtm9HMhA98axK?=
 =?us-ascii?Q?fhknfT/vHYhC5vB6egqygjWVJ6hMJvrpxVCZrwmBKhhZcC+JAZuxooTCf3dr?=
 =?us-ascii?Q?lOfnF5ilYdFpI6ag7G013jiPm9+y+nzq9rMiOAPHsDHuHwlXqvTImBvxbQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01641a2-ede1-46cb-e880-08dbdfdcad56
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:29.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnHjJw03vGLBWIKe5HufAIncZPIGe6WiVr1HYW0OWnGNL7fCpD8EORTsnKkwed+Xw9dMM+Pb4ektAO9aZcZHHRjsNvjVjFZGkeZ0KDxqD04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: QVLbm3B3XtOlNYjRz8o8pn3FUJovaFGh
X-Proofpoint-GUID: QVLbm3B3XtOlNYjRz8o8pn3FUJovaFGh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial revert of commit a8b76910e465d718effce0cad306a21fa4f3526b.

There have been some structural changes to init/Makefile so we leave it
be.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/kernel.h   |  2 +-
 include/linux/vermagic.h |  2 +-
 kernel/Kconfig.preempt   | 42 ++++++++++++++++++++--------------------
 kernel/sched/core.c      |  6 +++---
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cdce553479b4..b9121007fd0b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -96,7 +96,7 @@
 struct completion;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
+#ifdef CONFIG_PREEMPT_VOLUNTARY
 
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index a54046bf37e5..e710e3762c52 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -15,7 +15,7 @@
 #else
 #define MODULE_VERMAGIC_SMP ""
 #endif
-#ifdef CONFIG_PREEMPT_BUILD
+#ifdef CONFIG_PREEMPT
 #define MODULE_VERMAGIC_PREEMPT "preempt "
 #elif defined(CONFIG_PREEMPT_RT)
 #define MODULE_VERMAGIC_PREEMPT "preempt_rt "
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ce77f0265660..60f1bfc3c7b2 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,23 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config PREEMPT_NONE_BUILD
-	bool
-
-config PREEMPT_VOLUNTARY_BUILD
-	bool
-
-config PREEMPT_BUILD
-	bool
-	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_NONE_BEHAVIOUR
 
-config PREEMPT_NONE
+config PREEMPT_NONE_BEHAVIOUR
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_NONE if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -29,10 +18,10 @@ config PREEMPT_NONE
 	  raw processing power of the kernel, irrespective of scheduling
 	  latencies.
 
-config PREEMPT_VOLUNTARY
+config PREEMPT_VOLUNTARY_BEHAVIOUR
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_VOLUNTARY if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -48,10 +37,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT
+config PREEMPT_BEHAVIOUR
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_BUILD
+	select PREEMPT
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -69,7 +58,7 @@ config PREEMPT
 
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
-	depends on EXPERT && ARCH_SUPPORTS_RT
+	depends on EXPERT && ARCH_SUPPORTS_RT && !PREEMPT_DYNAMIC
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -86,6 +75,17 @@ config PREEMPT_RT
 
 endchoice
 
+config PREEMPT_NONE
+	bool
+
+config PREEMPT_VOLUNTARY
+	bool
+
+config PREEMPT
+	bool
+	select PREEMPTION
+	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
+
 config PREEMPT_COUNT
        bool
 
@@ -95,8 +95,8 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
-	select PREEMPT_BUILD
+	depends on HAVE_PREEMPT_DYNAMIC
+	select PREEMPT
 	default y
 	help
 	  This option allows to define the preemption model on the kernel
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50e1133cacc9..d3828d90bf84 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7073,13 +7073,13 @@ __setup("preempt=", setup_preempt_mode);
 static void __init preempt_dynamic_init(void)
 {
 	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE_BEHAVIOUR)) {
 			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BEHAVIOUR)) {
 			sched_dynamic_update(preempt_dynamic_voluntary);
 		} else {
 			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_BEHAVIOUR));
 			preempt_dynamic_mode = preempt_dynamic_full;
 			pr_info("Dynamic Preempt: full\n");
 		}
-- 
2.31.1

