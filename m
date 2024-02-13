Return-Path: <linux-kernel+bounces-62962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD385286B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0522B25FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C641775F;
	Tue, 13 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KR2Kl+MH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XuMLjMjj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272B17558
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803821; cv=fail; b=sS4FCE/f1PF229O76ZhEor8qz21sHL0Y3JfliRD1OrQgm/Ji1joFR0qXUBT8T+XO0jyPI1bm6TUhmcvLoAB68oAbfaeikAQRYDibCIL3K/ce11AX6+ol7LTIRaos7Rw76qK2LcdnjFB2LBh2nUODC7ThTZekXuKZ/V6YZbwnJNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803821; c=relaxed/simple;
	bh=yHMRxHn+WSGnJ4XEWqVfaLwJkb/Gh+LmRbNfhdGcUB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hIQaN/wKfPIbIEd6IYQ9KhRzPi9D30AIU7LwOW1m9MpHgJAgUi1U3kl04GA8KapfEIhgWsli0NrOThLvQvw2v/ZFdub4zjUj5y8YmRWUFaBjBURiG2RoFrCNdRi2CcajV413pvliuYHLoPtRTX7tTlEmSumfb1Vx7OLlvbRX7jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KR2Kl+MH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XuMLjMjj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5n3sK013728;
	Tue, 13 Feb 2024 05:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=DvwUEy75MTO450t/awgfNqDNaLpyUzAb+VPNe3a0neQ=;
 b=KR2Kl+MHZNJLSOHkkNj2umq0HyCE0e+iItBUyqb0ck2tnIhU3OGnYukHgmrJ4MO/TzHg
 hO0zZdRWaWV4q7RvtdrC/NVjbooYP1gtq78no+HvYFTYvlZLi650XXwjHt0wXZXCabI/
 TOEHOwJ+a1FH7EfbKs4sfra2oOEOS6g2WGD3kDWJMiJzV0uLa/0ooDOs1bMMf7FrVxXD
 DRyj4DBQLWkmDNJoOUDUt7dBCPn5lQ4LSxNF/SUcgW8TsF2yevILtZ2bRQ+4GHR3j98U
 l3LJO/RZBr4XhDP4WDkCmyQg6ZFgMX2sRfU2ag3CWYsLq6RL4EtUcSwA74utpKMdMTYx Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w816tg49f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3XGS6014943;
	Tue, 13 Feb 2024 05:56:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4LSVVlaEqVWTIrPCh8UFJuQ0FocAHp0iyEWOnhL1L+C6/Rgvy9tX14aT5fDLVlRHq1wkJMCNFio7ISKUI0q6cTzJ8nWZZdk0DMfG4YYIjb3RPeAN4+McBhWqJ3dxeU1nxLBweiOrcTTTg5DvUgofG5aoJR6G9WsMH/hsusOjTA3mfvpwKMFsvXhboYRJhlNyXvpIIXhqXYxuMxxvyP1pWys+lyejdNKtx1od4Zgp0qkyHZKZTh80d6PenpX1DE7NglkuSYTykxpGQuREp3c4fRNiy4y665RI9PwCIQz6SQAhvYcJF8FI4ZKoe88+RJ+nc6SGrJKI6QwPLSFOZR6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvwUEy75MTO450t/awgfNqDNaLpyUzAb+VPNe3a0neQ=;
 b=kwglg8ZUsX2WxUzl4q7f39ztpyd1x/p4Kqwk2QfJDoMnZf8D6kSmNGO7KyTFP1IM8Fl09GuF209KMnwlN2S8ki3ObYkmrl0cQrxlc9KDaoCCn+1ThTur5s/GG500v1wYNW1OmihDE0NUl1ZYCZpQem6yo9lD36qMNq/naNvPWYFAZylkqsfl0gZkwMDI5s72TXFmgBD7KrReHG1UDkloaYZHSOCstUYhOBcyJmrQ7uuDBh4LOU9WST8Oim2sEQX8JKQK0VG/nEBDmGwmBz9UDi7A8mkmbhMVarXlpiwK/W3vUAoxuFQffwIn0/AxGq7NLfMCos6291MMK8d7XzJxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvwUEy75MTO450t/awgfNqDNaLpyUzAb+VPNe3a0neQ=;
 b=XuMLjMjjrwq9Ws30Nbzfk8Lbel2RCLbXYHq9RgpX7aX+ZvDgWoiZdk0PcqCLvuHDyNYgDAn9XW/KeFDpfRopKi5m04XXx9Yuth3EfXOx7/bsFzwn3P3sQomwQsUvi3iSGqi721103bImjeixNWPKnbpbzoBHbJm3b8F/mwopEiE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:02 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 09/30] sched: __schedule_loop() doesn't need to check for need_resched_lazy()
Date: Mon, 12 Feb 2024 21:55:33 -0800
Message-Id: <20240213055554.1802415-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: a1edaddc-6855-4a5b-e3ea-08dc2c587585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aedJBq8fOYfvwOf0jYRyQEacjym0lsCBCPhhMFeNZG0JPHxp5ru7utd/mCt7kCIFROaGVbs5dfAB1tkM+0X4LKYiqk1D4cYDzZVyj86qKrwTmA2lckUZoIIVjXJLSFILL2w/E/TlUDJ5wsob9JuH+DebxuFzghlqWnSSL9npMhkyqheNpZ8DG3mkDryW0FJ9wemeAK0UPjGcqEcNxX7Gm08S/b7k61lctH8ToZ4vYgXIeceMK6JBdcpYFlmHYmnUZ15fGw0h82jE2vYYqG7pEk7t9F4KOT0pzqp7804j5+KgudHhNz3WAnVm3AMX+9ccENgPsPsoVY6Fq2aGvhkH//mF9OEcoGgN2qnHDdaj6rhP0HUUAOqbaGLcMLUm1/a5UMu2PXYgVG/jPcP3olyEZCOq1h4sRRHIw8/hKIUcBZ0Z1q/L6zC5ZkWtlI17KWFTVeJmhVn2/rw8O2s7u1ntBnJ5SmsE4Z1Ehp3RzRQNeX5OkhnDzuovR9mzcPTXiztMUmj3Jni9ECZm+qGv62oa8e6JdUVr3XDRqaKYJ2Yexd4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DHP7XuVuCq0lBPQ4UuesfaOizcu8K2u5E1dO8HvLX2jiGC4oZxV0MjRKsWEt?=
 =?us-ascii?Q?wHinddM6DXFY5gg/ijGn60giILpBt2ABSJ/kxeDmebjs9pkKBtLa43NJ1i+n?=
 =?us-ascii?Q?4Lh21vgh56ha6eKGJkUOoXKoDsCJ0sF0Zo1YqfgHQ4T5+C5z6hQZe4TQtM09?=
 =?us-ascii?Q?Ja3lWDdYv3DYUT+nnpHAzmrMf+BiFR+WrHaDHuWLQ9xpy3OLveqEGFVl+l5V?=
 =?us-ascii?Q?7+NB0ZfXjxxJE8GGiOusT11wkz9tL3pa4GEBHIRzlUI3Z+aRztdwnc655sJl?=
 =?us-ascii?Q?YrQst+Kppb/QwONEQnSla0w/5d+IJHpcRzoQLi8XzD9MiDRyX+dWbwUqz5md?=
 =?us-ascii?Q?e+ZzGciKOCAnbctHlmEqtbVYSfWliho6zU+oUajtkw9V89vLLYnjAUzwj+oj?=
 =?us-ascii?Q?Zl07Qbwtiim/sCCANZEla4BrrGu6Bbr9YZM7GzG4pZLV/kvhP2sExixBPGRA?=
 =?us-ascii?Q?Hw8aGca4Phe55ymGXxLM+zygvY+1StoPjc03VoaJBi186Likbs4z8QPzw41d?=
 =?us-ascii?Q?Q9CSP29I7/OIuuzklLGBYkifdZJsa1XMQolxGB2VmAtUrbkEGeM81FqZvoK+?=
 =?us-ascii?Q?8JDHOz2VcLXG/+mMfCK29I92XR1Ixw5J7xBL7RtInViUsJOq3TrNL1RYwfxL?=
 =?us-ascii?Q?/K9/TAkxmlFICXiDCssCmqxpS2yOaTo+EEW1WPA+44UqrWsXtEwePlL/i2uw?=
 =?us-ascii?Q?wlE+CuJQHmNy/HM0EaU249MZKz4SPsHpq6d5HnH3Kb1Iefb/iWmkkv9SyvIA?=
 =?us-ascii?Q?802O8BYsGJ3DvS8A3YqHGrSMVGZNc36nR20ooozgOHx2GiZPgzLd+4VEveS6?=
 =?us-ascii?Q?f6JFpOQfdrifN5ZuM1P8BA8OZWPeJiBI88r7ldhT6yYgcBSlXwHxyNncS6J3?=
 =?us-ascii?Q?kUchCq/XCkn6GsMB8Str+dk/cmtPlmSJ39ERePcGN5cOuj1Ga7ZyM1Or+CGf?=
 =?us-ascii?Q?hkY18rN7OYwKHQIfb52KrIABYVsZLCXuQx+/IMcwzDdu7UMm03Rvpx+DwCeL?=
 =?us-ascii?Q?GKcndxulpfajTZnhz03nBM6kRS5bVoPG+UKBdP0TX0cwJWiuEmsQngI6CwsX?=
 =?us-ascii?Q?5AFOiuHyo2f0yrVJx+m1oR/POoPFc2ZG0wlSuaLCLIujlelBxZtOQm4+seYI?=
 =?us-ascii?Q?qx9R8TDXFzGu/H9RK9VtiCrWPm24gozRboKm2m1v1VQ2m6eZCwCSMsuPigia?=
 =?us-ascii?Q?YKh7cmVwNO1pi+hdjtHXk0MvMoAQfvtBDPyFQ1DyxZlg7XBmvI1KptouHBud?=
 =?us-ascii?Q?r9DvzUEgFjnxdTLt6CNnTpUA0zXuBMP2Z4vEvATvo9ucppT42O+WSnqkzS8S?=
 =?us-ascii?Q?3PMBBXSslFQn6xeClj/yUZCLOUs9f5YBWs3a1sXKCkgzmP9SwZhcs5qA9t5E?=
 =?us-ascii?Q?sa0kTue5wxcL8xGGUvUdJh1XqxbCwlsMzveG4t353mB4rqxlbFTMsldUORna?=
 =?us-ascii?Q?xxhkoVhDJ73UZ5BrYkVrOPUui6XBE6LBVnELElmc/b7meZfxdtdryM78BEQ4?=
 =?us-ascii?Q?0LXXoX6UQ1VQo9upDLXXU3xKKBgZrfTAfpdnY0EMDjf2WVNElZi1m5C1j2/o?=
 =?us-ascii?Q?qQA02YQF51eYlH/Zl9JSBNeb7V++2KOs0/ATWA4ZQfGY0yZVKRh/RkQsoQnW?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W9ShxVOdxY3UIQ9q0vjaNLlfrGjlqRb6FSnzOyfZDsIPNnqgeF7WAbRw71iMrbzrd8nyXQkn33oufqO+YB8FwJYLDXrSOPNiY6EuXZ+R8mO4RkM8d3VLA8hxxUnjohfHvR++e3z6DtmZHd2GZ2Dusrrlkf+ze1VIrvkVXNRVaNIxpqhJHR/RW0vAtRv1eHt/giSBppH0Ey5vKxKhAGmnfrFajq4WcsOKbZhOZAc3dPlfwjqcVbcsUVQyunvUo1dEp0MOwJuI0C8ot4fHun954zeZO9dJsTqjsWglsE5AKrKN48vZ2sfxx3iq6oR1D2LOZsEFHQ7EwmVkbB2zAzhRy3GzNDgAdTCjcwwOjroXOiQLohRwkBHVJLhsqQw7j5sXXP84NH1zQNmNxIuaqIs5QKilhvWMGDnCRqOjxGzYg5tyY0kHGg6uGSqO33lhILbBckRG3lGB7dKsseodVcogPvkPOLNmCWI+ZaCp6g8FRdMP15We8421MXqrGWzXDINSDma0kIhFqQesD/R89gqfKFKb6phhpbnZbv/+Ya6KSneHzpbEJlPba7IERgfYh38q45sGDAvixshTTim1J/r6Jl1eCgTnqudhgMCW5fQwJ1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1edaddc-6855-4a5b-e3ea-08dc2c587585
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:02.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYnHackW7j9ejiNcZVoaicbLHDvJ2owoCSj2JRePtoBNpNkMl+gAvfqgzD+RuDVl8KeEg1lLX9UGJtIrWgHZyjlFHY7xrxZGHq+sx2V/XZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=540 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: W1PZE2iODLlVkADUtjFxfwW_DvZYUoqN
X-Proofpoint-ORIG-GUID: W1PZE2iODLlVkADUtjFxfwW_DvZYUoqN

Various scheduling loops recheck need_resched() to avoid a missed
scheduling opportunity.

Explicitly note that we don't need to check for need_resched_lazy()
since that only needs to be handled at exit-to-user.

Also update the comment above __schedule() to describe
TIF_NEED_RESCHED_LAZY semantics.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41c3bd49a700..8e492d20021c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6573,18 +6573,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  *   1. Explicit blocking: mutex, semaphore, waitqueue, etc.
  *
- *   2. TIF_NEED_RESCHED flag is checked on interrupt and userspace return
- *      paths. For example, see arch/x86/entry_64.S.
+ *   2. TIF_NEED_RESCHED flag is checked on interrupt and TIF_NEED_RESCHED[_LAZY]
+ *      flags on userspace return paths. For example, see kernel/entry/common.c
  *
- *      To drive preemption between tasks, the scheduler sets the flag in timer
- *      interrupt handler scheduler_tick().
+ *      To drive preemption between tasks, the scheduler sets one of the need-
+ *      resched flags in the timer interrupt handler scheduler_tick():
+ *        - !CONFIG_PREEMPT_AUTO: TIF_NEED_RESCHED.
+ *        - CONFIG_PREEMPT_AUTO: TIF_NEED_RESCHED or TIF_NEED_RESCHED_LAZY
+ *          depending on the preemption model.
  *
  *   3. Wakeups don't really cause entry into schedule(). They add a
  *      task to the run-queue and that's it.
  *
  *      Now, if the new task added to the run-queue preempts the current
- *      task, then the wakeup sets TIF_NEED_RESCHED and schedule() gets
- *      called on the nearest possible occasion:
+ *      task, then the wakeup sets TIF_NEED_RESCHED[_LAZY] and schedule()
+ *      gets called on the nearest possible occasion:
  *
  *       - If the kernel is preemptible (CONFIG_PREEMPTION=y):
  *
@@ -6802,6 +6805,11 @@ static __always_inline void __schedule_loop(unsigned int sched_mode)
 		preempt_disable();
 		__schedule(sched_mode);
 		sched_preempt_enable_no_resched();
+
+		/*
+		 * We don't check for need_resched_lazy() here, since it is
+		 * always handled at exit-to-user.
+		 */
 	} while (need_resched());
 }
 
@@ -6907,7 +6915,7 @@ static void __sched notrace preempt_schedule_common(void)
 		preempt_enable_no_resched_notrace();
 
 		/*
-		 * Check again in case we missed a preemption opportunity
+		 * Check again in case we missed an eager preemption opportunity
 		 * between schedule and now.
 		 */
 	} while (need_resched());
-- 
2.31.1


