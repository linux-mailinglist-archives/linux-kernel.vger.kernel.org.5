Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD917E4C83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjKGXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjKGXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A4173D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:02 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK0GE022798;
        Tue, 7 Nov 2023 23:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lIOadZtTWRLNr2aNmC4m8NpdsjcflN9hHPdlsn5woq4=;
 b=UgXWHP0y0kZM/7NQwTPK+YrW9Owr8tnZPTLvm0y7R3/RN6UZVUCOpVZrsEtKTXzeDKtK
 EXCepl04MYwjl3Gpn7oTvhD4Qs8w+L6JUZyQYWKGpijyLaH9O+VaKFNIXhqbqFuvWoDE
 uIUHwj7FfCXOUPTNtg5o5n0H5kNFdOj2GqA4rXMsveiatw8F90HeBJulKx/d/ISkXZzh
 x1Y8pZlrdi7HaTbIPQv196JwkvDGN6BQBgospe1aZEIFCaQnbLDK7kkZl5lwIYtrqt+w
 5uBVnkH1y0Uyv8bMkiJzJpuF8U+eaPjc3WE9gfSVJDm4U/q/xkULbmmOnaEz6b9fADhN Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2CNk000410;
        Tue, 7 Nov 2023 23:08:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvd3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYuNM/pWdvh12JCBhLjXgpYhNV7qO0vZ/c1awW0l6WEtWMgQ9JqswI1NIA1Aiy4QlZkOq+CQIw91sh/q6wRVPpekJ8fsdeA9i1c6nN886S4RoKHME8swPYMHRcwbA7i7A3WWbYlOXpqL8VlwI6dkWKREErBbFFqjcUk+wQKzolH1a80HOFSBkxvYeBaKsuPVsxke9+WDM3bknCWUhKjyTGaQ6NZvYFDwOZR8LlYl9hqI+fd5wUGUAkclctaqZajldeJAs1dqw27Cg8YJFsp77WEX2iuGELcVcevhL4Nh7U/gkcS18hR9kLIE/nlMTMTQ5cXK0zLZwSGilr+EO3EC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIOadZtTWRLNr2aNmC4m8NpdsjcflN9hHPdlsn5woq4=;
 b=mLTqBH9oQ0/O8rqJOJB9onSrscXeKoeNpqnFJs4pfKHNyqk0DixmW70m4mrbrJNdDj4QwhlAaFDB+8sT0z9TALHR3tlVkD6gKeUZMOVXIvC0OfiuPAiYa75oyw7OOr3USKBqheoFwL7pCPtXFd5UewXiG0zGsrTvMnxStyDoRfCjoL90UZbwRW2PUwHFpdmbcLJrYK9B2AVd4TOqcAQ5hG+S8H9U5Zaeafr5+QqiGNcxL/xBe1SwHX5qu/MLcYBMfEw+NNvDWVEYs2YBcJhMK38alsILJYyY6hqT9yJUYY7dcE+luVy5rb9mG5zrtEQSwFd5OdiFRGukGQi0S8voqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIOadZtTWRLNr2aNmC4m8NpdsjcflN9hHPdlsn5woq4=;
 b=puqIH41NBNOxKhVwKzINAqeusfd5ls+8Y4fovNjEY8XGbOXsognridAVhX6wM9SkTtyrJ8Z54c9lQLKHpqD+hAN1aiamtNHJ2PLhFcRwGbc5o21I7rLIVXTO0rp2VcMagnLi7aazsu+Ci+xOKiFB+vYd/eUjfPAacQkKMGNPFro=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 23:08:45 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:45 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 63/86] treewide: futex: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:59 -0800
Message-Id: <20231107230822.371443-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b33aafc-5aeb-416d-c392-08dbdfe67e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5Q0RifJMw1D/et2XhuKBMDSCy0iu3enlJqfq7GTFoy8vrQVsb3wgEtc9RUokGd5m+nWpg46wFLRV7H1jkTP50WM+1uCdxccRZCPUAxRlNcGEexvXu0PloV9B1AZ5McJHQ/7Fg3q9NqadX0M/wc7y+hyAbyENabTbRULjXmFNfD/y/+NGI1kZQ73ZjioJZqD9y6MLEg7ssK6cQhirqm56GiF24jqoY5CxV+fuE1YPVzrdx0okPQfiy5pTMrw6TQ67XDTteXJaodo08+c4Kqt4nTCvB3siObFfT9X5G5efHaMJyq2RsIl57DqVO4WimUJ/ftNV2K7D1nVLZVk35o7QvlpMdGFcSyq9LT9Eok2mgWUnULmjZfTglV7vPSurIOKnQdFsGq9rgNpdve84MEWRuAhcxGXp11LR38y7hK2lKRZXiUWpxLol72o1ZlihATPGamQdy5Eg7APR3UvHLiypimrWGNIA+EQu7K4d/S1q+orX8lAL0H+98VUtaJh3JnKjdCBa+ttVS39WE/e99zT/1kFLkeHZiW1oT1Xh+/8EK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(6506007)(2616005)(966005)(6486002)(6512007)(7416002)(6666004)(7406005)(8676002)(316002)(4326008)(8936002)(5660300002)(83380400001)(1076003)(26005)(66476007)(54906003)(66946007)(66556008)(6916009)(38100700002)(2906002)(86362001)(103116003)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtsRjgxdzZFb29oWFlmV0xKVXpCRUhOa2xrZHNZeW84RnBqTWpZZS9tY0J1?=
 =?utf-8?B?ZmlRazJBZGh3b0ZsUGdQcUprcXB1TTVrblNmdkl2amFvcHN3ZzJNbWVhTmZt?=
 =?utf-8?B?VUNITFRabU1HY25EQ3FYUm9SNWRKOVBaQmRqMXVOUVQ3ZG1PT0J0RzllcmVH?=
 =?utf-8?B?akJ5b1JFQmRjWXEyWUNRR0JCT2pjYlpZYWtVWFNzRmF2MmRjM05MS3dQQjB1?=
 =?utf-8?B?UnhTalVuRytGd2JFTXhlMkVxbHV0dFYwNkJJSFExRkxiT3BtR2JmM0xpdXhy?=
 =?utf-8?B?a3hmZXRGdWd4ZGwxWC9BUGdHUEdjRHFhaE41QjNYbVp6b0k5Ym5UZEp6WFAx?=
 =?utf-8?B?bDQ5MkFRcUZOTXZKMTFVREJMWk00WjF0cU9BdXNOUFdIMjRmYUs1cEgrNndY?=
 =?utf-8?B?TnVkNmNBZFJURk5wN0NMVm0zMmJaMnduSmxqSXpobGxXSlhzbFA3R2NValZX?=
 =?utf-8?B?R25oRkcvWWZ3NG5UVGs5cy8rYjNNS0FmeEhKeU5ReHIwcGIyZmVaR2lWMFhx?=
 =?utf-8?B?UDZyWTJQZ3BqOW1EYXNoWHA0QjNoR3FSa0hRemMweXNrdkdRWkd0U3FCSm5T?=
 =?utf-8?B?MG5jOGIvSHpmcWdYbk1lS2luV3NoM211bXpRZWZ1aDdWalpNaWZPeTA5V2kr?=
 =?utf-8?B?MkQ4RGx4eWVRVER0ZVl4OXpZNUdjUCtGbjBNajlRbEkvK3ZvS3lIU0JDU1Bt?=
 =?utf-8?B?K0c2cDVKTXM5eEZCK0tlbjE1OExZZWo0WjkxV2w0RmFycUpKZlkxTXdVTmdU?=
 =?utf-8?B?TGRtSytoajhvUmpud3lUTjE2YVJtRVBibUhrSkR4R081SUxWNGdRajRXZzB1?=
 =?utf-8?B?Wk9NYVpkWWhpM21jTXBKZDVFUFA1dGFadkgzVXRZR0Z2ZUx6cjMvbFhvM2wz?=
 =?utf-8?B?ZWkvdmR4WHNYclc0TWRWZ1M0OFFBbzZpcG9tbUplbExOWUpKMkxaaVJHZ1lT?=
 =?utf-8?B?alIvS0lKZU9PTGEyRjhOZXNidnNid3paNVZiSjh5blpBeG9rZW9vK3hhZkQv?=
 =?utf-8?B?bVltbHNpY1pPczhVSEwxYUVmRU9lRDNCdlRudmpZcUhhdzJmbGNLSUdsOWs3?=
 =?utf-8?B?OCtYalNvNWlCalV3UkFJVTRHOVRZNWZwQnRFSThkSklScnhOVTc0eTh3SHhu?=
 =?utf-8?B?U3lhWDVHak9yS08xY0hBc28vQW84S05PeWZGdnQ5TlZ0ak8wY1ppZHlFeVIx?=
 =?utf-8?B?dzZBbzJJSlRRakhsdHNUdkNBaWVYS0ZMeVFUVlRZYk9Da0VYY1RZZVVYK2ZJ?=
 =?utf-8?B?czJOblVkN1F2UDBtOGxJSTFYQ1RXQngxZld6QjA5S3JFYTBUVDRSZlYxNGVl?=
 =?utf-8?B?VDlzd2hKQ3Fiby9MQkZGYlVOWjdhOTlKZHpwU085a1VXRG5rRHdoRWpHRmIx?=
 =?utf-8?B?aVZtUU50Zllwb05TR2h4cVptdHRzNTBWejNISnIwaGVyK2pjZE43SlZDeDdT?=
 =?utf-8?B?eC95YlVpTkFQTGcyU2VQVUZYb3J4SG1aTWVTUWFqeUxXSjJFYkp6NndNT3Ro?=
 =?utf-8?B?NHArTVp3YTIwNFp5eUZKdGF1OWY3b3BLdXJhZ3hxNXlmaWdaZjFDRlBzQUlV?=
 =?utf-8?B?eVFWcW1jZnVtNWpWSFhsK3J6ZFpwRG5IL1FHSTB6eTRLMnp4bHZvM3hSZjRK?=
 =?utf-8?B?WDFmWlpnZk8yQkgrZ2xTMDBlS3hxZWFrNmhEaDhQMmx2SFdPV3RUdU9sU2hz?=
 =?utf-8?B?RklHMG9zbUtOU3ZSR1BsUlUvSG8vanovNCtUTnVSMmRmekdrb1Y4L2hRa0Fo?=
 =?utf-8?B?OG9tQnJEMkh5MzFERGxxYmF0dFpuOWZUUFdVYUNzQTB3YUV4VzJFOUx6UTJX?=
 =?utf-8?B?QlpKdE1oVlpsdjlBcHFSa1ZuSXNGUzNUTzJwMHNlQml5R2JCV3R5c1VtUnlI?=
 =?utf-8?B?ZkVrSm4xY0VXQkpzY0t3cEtFcVc3ZzFrMnZKOC9MMW4rSFNoM3BocWVkeGlK?=
 =?utf-8?B?ZkRZcFF5VXc0cEg3eHdTcTg3bU9xYS9VRXlDZFRDeUh1N3cvZXNMaXRrUjBL?=
 =?utf-8?B?VUNab0VLOWh3N0lFSG1iRUNSS1ZHS1Q3NmNqTEZSU3k0K3lydVp2b1hLejVt?=
 =?utf-8?B?cnplU1JuWWJOZG1JUXFmVzMyS3RTOU42bGUzNE1CK21zdCtqa3FsQnFYeGR1?=
 =?utf-8?B?Q2dhWlNONmdjcExBQ2phSm1uQXhNQkJaUktNdFRtazFKL2JHSXAwVGxCSllI?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bEpNeHpNbzZ6RklGNXJ6SzhvczUrZ2I5SnBVTEpvR0ZDa3NtbWV2UGpRUGtm?=
 =?utf-8?B?MHRmTVdpNlBzbDFic2JYQjhNV25FYzdhWVl1SDlzczc2U3NLT2hXM3I2eklM?=
 =?utf-8?B?bTZxTWxnbHRhbk5lK2tsYStOK1FMTVEvRUIvNUV6dEV3bWk5MVpGeDlrMHUx?=
 =?utf-8?B?RkpGZ0h4RmV0YjQ4clZKOUw2N0lDT3hndkxhRFc0WG5PU04zdmkweXlhQW8y?=
 =?utf-8?B?TGxnck54cWZ6R0ZNdzNzamNRcXc1MmU1UEdsTlRaRS8za0xlbFpXNmh6VTAy?=
 =?utf-8?B?U0VHb2d0SDR1cHorOXpuQ1hWNC85aHFKN3lRaUUyd3JTUnErOE40aTd3TGxi?=
 =?utf-8?B?RHFSTXI1VjFqUEVnQ1lYWURKWFcydklvdEovaWkyM3pUbnVjZkNoZjA4akpT?=
 =?utf-8?B?M2tVRDhJdmtFeDZ6UFBnYjRaQmlkMGNNVTZqOXQvbEhlZXB1VDJGeHExeVhu?=
 =?utf-8?B?ZWVTT2NyQ2toSXdBOTFna3pOL3VITXdaQ2IwRkJEU0NMcGF6RFl0ZmltVkQv?=
 =?utf-8?B?eFdTQ2VuS0FMOE5yY3V1WExOTHFEVWdhbEJiR1ZhZUxkd1BvaTBHOXN3VUky?=
 =?utf-8?B?d0tjcS9KZmd2TStIVE95djN6dFhQdU96RDRiaWs2bW1LVVpTUkpGTmxISzNq?=
 =?utf-8?B?YnFXTGhERFNkam9pNkQ0V0tLVytEaHMvVlB6elpEbXlyM3l4eS9QdEpzRnVZ?=
 =?utf-8?B?TWxMNUN3b29VQlpCSlJycWx4djA5VTRpVHVWVXhuT05pcmltZm1rdjNhZjhh?=
 =?utf-8?B?N2J5VGJXWkdmOWFDSUdFMTNORmdJRUdVOGFwWGJKMGpyUkV4S043R3c2bXU0?=
 =?utf-8?B?aUsreEYrZGx4ZWUrYWF2YVlWTUVkelNSendXTzVZdXZ5SWd0YjRaVllFUEIx?=
 =?utf-8?B?Tm5NbVdtcGpsVlRONW01bmswVmNvbldyOWpnc21QYXJpbFF0ZXJvOVl4Qmsr?=
 =?utf-8?B?TVJ1TjRTNEkxa0N6c1N5S0lkd2FmY1hGbGxBS2NLeXp6QWtoM2pOLy85UUNP?=
 =?utf-8?B?RTZEZ0tkVmc1TWE2eHJMdmxtVjNRYU42eFdGRXBPa0hvdGdRQzJLbFNuQjdk?=
 =?utf-8?B?aERaR0tWUU02ZFU2aTM0UU9rbGVibnNIeXlOSmRsQXpmVkx3ekZibTNEQy9M?=
 =?utf-8?B?ZnovaElTcDhlckI5enprVWxuUjFZZjBybXFSUkovWnpxYm9mSmhqQnVmdzZ5?=
 =?utf-8?B?U0MzUmFjYnpwQWJwbktCNUdSNGNXa0FPc0I5NTJrNW5jU3J5dm13UXJseUwr?=
 =?utf-8?B?ZHJUTW5qRWR5Vjh1U09RVllIMk5YbG9LUDR2RmZJUnd5T3AraXdGeXlBS3lM?=
 =?utf-8?B?Z2xrZ01iUWpIbGNvSXpHL3c3dTdhcDV5VHRKelRIOGplRys2VlYySW1EdmJa?=
 =?utf-8?B?MlkrUnJOZFVrN0dNOFJibkt5TFczaHZCeGplVDhDSThOZ0gzS1Fyb0JxNDZE?=
 =?utf-8?B?WVYzTGkwQjEvTGRXaXJrVmdzdGQyL0FoVzRZQ28vajNjRHBjUGdjSXBIWTRG?=
 =?utf-8?B?NlVzeDB6ZGJHY2x1V0hkUkZrczMvU3BsMG8va3Jsc2xRNHNuTDQ1ZzNwejZm?=
 =?utf-8?B?MjEvYm9LWEl2NTdZSUcrc2Y3Y1RodXkrc0xROWRHeHF2ZjdQdlVSN0xpKytL?=
 =?utf-8?B?eXAveHR3amxYQ1I1R2pTUk1ESGNCSzh0aHdPK1ZEQlZVN1ZwMDkyWENOcDds?=
 =?utf-8?B?T1dFZ3JsYlo2ZDlERzdtZUoyRzRPQkIwdXJObmhFTW9YZlVoRGI4eVlKTmJW?=
 =?utf-8?B?NnJhS3c0TER5V2ZsbFh1U0JBSUk4eUloOEJyekQxaytxOUdCKzc3bGx1Z05i?=
 =?utf-8?B?MjRNQmlsa2hkTUkwZTVIWlFMSVJWMFFMUVZpckNSdCtZVGVNN0ZaWi8wTTBJ?=
 =?utf-8?B?RUw3R2srSnVQWndSY3lMQi9TVngyWHdCV0ZYaVJERlpyS2xmelZHc0hPM0x6?=
 =?utf-8?B?YURGcUJLMFNaVExVZEM3S0JRemJIQkpya0dwRXZWdjlieGtwNFo5RmZIUkl3?=
 =?utf-8?B?WElaazAyeUpBWFBNLzlTbGgweHVTcldvTUVtT0cvTG9mUW1udXZtUHAzdVlq?=
 =?utf-8?B?K1FZMXpQcytxci92Y3RrZjFGNExpOVhwZW96YU5uYUJnYlZBS1ZMYUZ4dm92?=
 =?utf-8?B?UXdwcGp1YlVIWHdDZWQwNFBDMEV4ODFYMzlIQUlVR1JxNU5tSzFtSmMvRW5E?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b33aafc-5aeb-416d-c392-08dbdfe67e31
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:45.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: monkbzwXD2gNPdbJF92yyDG6RjY4SRYNv0cnshy4YT86nh6J1yHN6+vAEHZ5bqRx4luPJ6yXvHaIwp9XKNPM15CG66Wh7EHlaxb2tJbPt9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: 8Ak1VclO6a76SH60slzBE_htoxKTnSkp
X-Proofpoint-GUID: 8Ak1VclO6a76SH60slzBE_htoxKTnSkp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most cases here are from set-3. Replace with cond_resched_stall().
There were a few cases (__fixup_pi_state_owner() and futex_requeue())
where we had given up a spinlock or mutex and so, a resched, if any
was needed, would have happened already.

Replace with cpu_relax() in one case, with nothing in the other.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Darren Hart <dvhart@infradead.org> 
Cc: Davidlohr Bueso <dave@stgolabs.net> 
Cc: "André Almeida" <andrealmeid@igalia.com> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/futex/core.c     | 6 +-----
 kernel/futex/pi.c       | 6 +++---
 kernel/futex/requeue.c  | 1 -
 kernel/futex/waitwake.c | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index f10587d1d481..4821931fb19d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -724,7 +724,7 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			goto retry;
 
 		case -EAGAIN:
-			cond_resched();
+			cond_resched_stall();
 			goto retry;
 
 		default:
@@ -822,8 +822,6 @@ static void exit_robust_list(struct task_struct *curr)
 		 */
 		if (!--limit)
 			break;
-
-		cond_resched();
 	}
 
 	if (pending) {
@@ -922,8 +920,6 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		 */
 		if (!--limit)
 			break;
-
-		cond_resched();
 	}
 	if (pending) {
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ce2889f12375..e3f6ca4cd875 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -809,7 +809,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		break;
 
 	case -EAGAIN:
-		cond_resched();
+		cpu_relax();
 		err = 0;
 		break;
 
@@ -981,7 +981,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 			 * this task might loop forever, aka. live lock.
 			 */
 			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
+			cond_resched_stall();
 			goto retry;
 		default:
 			goto out_unlock_put_key;
@@ -1219,7 +1219,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	return ret;
 
 pi_retry:
-	cond_resched();
+	cond_resched_stall();
 	goto retry;
 
 pi_faulted:
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc..9f916162ef6e 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -560,7 +560,6 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			 * this task might loop forever, aka. live lock.
 			 */
 			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
 			goto retry;
 		default:
 			goto out_unlock;
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ba01b9408203..801b1ec3625a 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -277,7 +277,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 				return ret;
 		}
 
-		cond_resched();
+		cond_resched_stall();
 		if (!(flags & FLAGS_SHARED))
 			goto retry_private;
 		goto retry;
-- 
2.31.1

