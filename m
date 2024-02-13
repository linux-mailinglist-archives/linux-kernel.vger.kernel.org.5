Return-Path: <linux-kernel+bounces-62981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A3852881
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867D9B270F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E03FB06;
	Tue, 13 Feb 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pqe+mfvq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jlQHVaky"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B913A1AE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803861; cv=fail; b=qEdGuschzYH92W8DYkkOtQad8XvfGEfZh86XwUsseKuOy7w2dkyhCHgYPjrhNC9lrNaI8fpGKCHtSlLOgLcDeEC4xE56QJ8me9ViGeY2ZFDD2HNnyIZMg22s6EN+X6wOLFOkrtAZJgt1LmXaFvjaYChvlqzykS5JDgFXEwc2GLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803861; c=relaxed/simple;
	bh=nBKwVvQJxQh1s9wUNZRJwrqUQwS4G2njDeHrQGd1xqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/BpK9DHrVEY3RBWhoaoTtt+AakRQFEn+VhFhAHs3Co3YhPikIka9fKHBwlQIve6+NQjJ9wQoHtBbBqUyQq4HH6oIIK4674DUSggnraDcjKI/4vilMqNq1LrIhI5nKylzjcHIDywfyNxaBp8p6H2qwwTcm58fC7tGK0vTzHjQjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pqe+mfvq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jlQHVaky; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5UAgf005097;
	Tue, 13 Feb 2024 05:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=I6D2XlQiBTqdezvAHzpaUa9Foics35VeMmOvva/QEmU=;
 b=Pqe+mfvq8ptPBJxK0yeZK6R12G/udsmExzIbF2gDFPrm0Vn+aSF6mGAf3bXternconXX
 6TLeaMnKsEvfdXn8b1N4oUnrkfDycgW9ccNMiDm4hh6rfVTVrF/KPq9LFmFPylBzDN4c
 vsjuE09NnZKed/o2J1RL2xhe9F5gAcQBBclvA5qk76QivJ8aGj1OztoKPJbQc2dGb6Wc
 CUS0RaWwr0Oo9jzZUykYfdXrlfUK+pDd/dfmMwK3njUH00c53HTi6pO4r9ZDMb3haSg0
 rOd8TkwXwwFT8JYEC50WaA5/jjTrM2ebLxhdJA8flw2/Fx+siX4AVvJ9EUQOzsf207Q0 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5uZxs014991;
	Tue, 13 Feb 2024 05:56:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxkzY0aUq0MM6Ow9Ww6VHGjJsfzVYm/nYoDtZ6Dsl5LEZizMAhdEGC8YNANX7UvvPjFB9FNFE+qVOX9wtFHfIDDBMmdy65/oRnEBCEB58/FvJXW18LGRV5l8GzCQjxoLVjLVyOqHmiHGbw2SxYYE985Vh00sYaX8Ft6NR1tySC5EDYeGHQf3AngLw59TjLb839g8Qr1EuPROixyEJKjNslhW1nq+NAW1dGzfplvuqTSBjOARnrxYU6hZUXJW8Iw7aF4BUuvbEctYRo7mnEd+X4QQL5M7yz3BAxXG4jRIcF5JR1TO8df9DZ1tIk8WvlLDE8CuOIjshSsmOTgjgPdCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6D2XlQiBTqdezvAHzpaUa9Foics35VeMmOvva/QEmU=;
 b=GXdv9AY4L2cZS0xOy3M4M63MjtAhQUg4h57F0XtlagUHTAqpq9mI2VR/Yw451u8vhZ7kKO2MXoP9zJS6KQ2oFPcVzHh52dwm0yxrJ+MbnzFxldC4yVemTNUHOPMMTFUqyVXkWSRbiDpNp2iskXLw62lQCnagLmmCP3oIMiK1y+QIHC/N1wxY1Hu/RISV70sKRFKOtTPQWvfsjlv7nqPFREGh79Ol9WTczWNE/irueU6PqRF3wMok8hkECIEiy8tmUg6ACqp6EW1Osuoy4MInkMSE3ijDZHrr5XObwZ0s4mkHy3SzoFTUMQGIkOU9exN1Fk32t1nY0zzbP1Yisnbl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6D2XlQiBTqdezvAHzpaUa9Foics35VeMmOvva/QEmU=;
 b=jlQHVakyLC8vuGfnR52C9VaN8DjwwS5PLaBEZdOoaytum2+d7Ox1ud1psU58CHcCIXZT3Manb9CgCyj2GecPi4GNz++uj3N4SJfbcrDFENN08DRonWScA0tYq/orqA4GOPqKe9fjClwMgxzUL/igVZwGH4RnWk+oSpn+KSNe0As=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:37 +0000
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
Subject: [PATCH 21/30] sched: schedule eagerly in resched_cpu()
Date: Mon, 12 Feb 2024 21:55:45 -0800
Message-Id: <20240213055554.1802415-22-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d67274-e41b-43dd-4fc0-08dc2c588a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ojfQ7FooKbd1gFw9GhN5OBBuUrXJC27rA5z7iBXk5h47K6dCniRIy44AWaakodwuhqejsrg3/78u4xAlPOyUdfpam1ANdpKcWg08Dajw5AAIVukwAlkREZmbzcIUfxbZTYb0BPk5iIa1UBPz0D6wgiqKNdCFgzLZ4aT9ak0IgDBiu1uZBzrgMp5xLzQne/2CePNaZ3JnDi/+LH5hx+bzRHscYkM3qWCVPfgLM9kqkoJvBtWTGoFh3hPKmPkJJe7IdA9l4vdxDNTR1B7wCWmDEr9M64v3DhYMwI7ioTWGemWf3esgQXx5dpe+ZYLBZdmXzXOg2jNDLe9YHRIKlNsk6F7epJuPeYO1pQv8sTwu9bONFPE4PsLyp1H45ryOVQBJnvcLiRgd260KGYO4SIpw+449CHUTl4I/t0fkGDvb7f5ybd0X0dlKAWX/euUZCzuyCU9XPRH/wStOWPhlgqmse5m9u8Ic57QRPv6WVmv2skHAQtC6KQ3hDiutkt7elsm6epkZTaI0TAQUy2zktVYdXj/xSiN6JdWVguzFcM3WVziZmMuzOQBZ8EhXufbVgJiR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EMosoI7PFq1cO8twuAmOxV2baxrtE1XLQqUgH+ECIcZXjNr76OBzOtoEg/Pv?=
 =?us-ascii?Q?1qYi9BnS9m5tVgHY9motCpfQYsFWE4kuzu+mp6rx9k0tt0ORjpRjFrMarmLw?=
 =?us-ascii?Q?bJIWn7XwwNBYbCT12kLkYPRYPF86yva/7S8IRzOKYfI+KKlDJuRVwzOR3L8Y?=
 =?us-ascii?Q?dFLavr/yv7ujX62Ekuv8mTKoa0Xdk6vij9TQqOUIIYKJ0JmyFjsod1LTTmvM?=
 =?us-ascii?Q?A95KyJ72BGb5fKEAIH25BEEhkJQYV9TXJ18zucUL75E0KlS5qri1WTupGpdc?=
 =?us-ascii?Q?EZrJt/sUSmkozR+PEn06Id5ZD2740V9ikt1XIToR3YRpf59K0j4QN+3ITeuQ?=
 =?us-ascii?Q?TtLf8/iZo5KTY3FFTU6mP4QWzIORN6ZhR0ZG5dMNVpVtch+SKzGzg1bH5YVc?=
 =?us-ascii?Q?V18FS615iIEwJWHOAoK+Vm3krVmse+Fc04XihHO9zbdRitWMtsDrIRHym5mu?=
 =?us-ascii?Q?bvsL17wsq2ro6qZFQCwh5vKCgZe5i92sO7nRAu23iAgIstRmpsCVhgR8gT0G?=
 =?us-ascii?Q?oukWt90J7zDJyQrTYjL8biJd79FVBh4Y0wx5X3KlBJClSTrvlyW9uScbVpau?=
 =?us-ascii?Q?2AscS4EhyGmkyKbE3p6cSr/ONa5lNDGyNZuMBKWUaeer7RAzhdssWgb4WQ1Y?=
 =?us-ascii?Q?Kom6gm93zuhHVwt/+cfumrDJHo7/yNj3nn2dr9zcH/HbMkmNmcATMYKf+3aH?=
 =?us-ascii?Q?HlLZSc0Ps/WCCE1MUy/W+uIKHiUVeLS9xDn37rEODUG+FfO+/dt8IPJmJ7mg?=
 =?us-ascii?Q?kDX5v5W3OwjgIVQeQcpWblZXuoV2aN/6iPHT40W/WCC9cMwwGuG2OkaQpiED?=
 =?us-ascii?Q?N960mrqR08scAcWTy3/zsawy0wQHWv71tbIgikPwm8P8Q55X9i7r8DtNgwMZ?=
 =?us-ascii?Q?AZFZ2cxm6HsgH/N0SODTyk999DCIuU2jSI0h6muqMdyF/xwJ+cePWrQcb6Y5?=
 =?us-ascii?Q?XxCDTMGd59LzMX1ZmDbSCuQoPeEEzW0hnRlsImrrui7GjHT6+IF6N/UDC7ce?=
 =?us-ascii?Q?EdjfbhfnksxRprF6j8dZth/BAd6ZRt3N13MN+M2UVhV4ORxfcjnbqzZtiobC?=
 =?us-ascii?Q?j2OWJBxD2kryAQH75DnY7JGyLBOqAx+eWOga4CpPCcr2YnOv/VSm5nTggLaD?=
 =?us-ascii?Q?AB7hTrNmD4foxlqytVBXKlzGQ7cXv7W+tho+qdE3Y9dMi8KKvkZWJUDsJ9WB?=
 =?us-ascii?Q?wEeKJtMFpX/rtzL1KsOquNSbXRE1+lzT8AkYkV7Cl9kKsJaMxUVM6+dfmhkU?=
 =?us-ascii?Q?7vi7bfiooQo+yywGSZxON8wyvQGoLdIQ0R1NiTL/ymwMTNFnZ8FqyGo7TTgw?=
 =?us-ascii?Q?XJIkd3C6JnhYGnpteKjB8eu4EsmyW8c9jeA/kXH4HBgY6W99ikU1l26Jie8Z?=
 =?us-ascii?Q?LwLQH0as+1sbRcm+TXfkMpDypZn/1Jq8QFSf3iyG1/J7Znm82LKMfcf2tPrJ?=
 =?us-ascii?Q?fwpuX8hsOPhEdEBoORsIVA/Ocu5VsokqmP3a8vQXn5NHZdV2eqAFuHZR04Sg?=
 =?us-ascii?Q?St6uxfwtumofz8SzvinsKkpgh1aK9YFowY3Vo1XZWrXRQgjefMIpFxCHWLkV?=
 =?us-ascii?Q?b7TkmlpnpsWWo59cbvltLidlAPkHWAIBnpU2eR0/s+TD2V2ejxaI7IU9rkzI?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uvgLDQwRrp78BvzFju4XRaGBeqzrLTP32DnZ0LratToHAnaCEn03s5q8284gz/bd973bwhZZOx5YHlZXuc89uyYB2eO07jrHEl8CrZAEDgPmT5kfD66qGYQ7BY8pHgGKuID8TRaxlBhH1RMDNK7UbisgyAnoU6ts8ct94fWOlLw2z3wCfeQavdkKM/kpjSlV30tg0NvqTLH/TcV7TuaJZxHMf52MDXOs4X1n3aVE1f4/9ImoU/0ePUO5aREt9Z5IIHJUaYMqugvrwn1jtos7IwR8eCzG69WmZXVVQUTnTkjH0dTYPBkguYDm+fWSPtcdBgfU30JmysiXGcZ9nRWnpp4zeZxQ3P+kxXgPbedj8aa9Xm7ra7LTMT7no/37P+2qM8/H81rOBZbMvdgokhKfq4M8e9cHX7Q6ZxY5QT0ghcykpeIpdt3yXdZuaHXKmBOyLYlGLrStAnfvLJtmM42wyPk8ES/XmLQTBEy7LJYbyN8vdRG60BYnBNLsAeSH/8NskGEhbBoHXt4wXzQ+AynrSkUuJG19QW/pwzNEG6jMld2B+FhUbl+p1y8J1I9IjRRxir9GDOnYRjYWU9MEWSwufKW0k9dedsKYAZDDNhdMGTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d67274-e41b-43dd-4fc0-08dc2c588a4b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:37.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bhp3U08bZ40yMG+a3h4JGY0c2Fi1201NmTUD5zQYcql83HejxX1WA42fxFVWtWL8gPz1OaFoQ5a0jtI7RZujYFqIJungYJRM1TFRVSo950=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: utIk-zCDd7SrAha4fZjevqfXPB6NuRcy
X-Proofpoint-ORIG-GUID: utIk-zCDd7SrAha4fZjevqfXPB6NuRcy

resched_cpu() is used as an RCU hammer of last resort. Force
rescheduling eagerly with tif_resched(NR_now).

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 15 +++++++++++----
 kernel/sched/sched.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e3dd95efb73..de963e8e2bee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1035,9 +1035,9 @@ void wake_up_q(struct wake_q_head *head)
  * For preemption models other than PREEMPT_AUTO: always schedule
  * eagerly.
  *
- * For PREEMPT_AUTO: allow everything, whether running in user or
- * kernel context, to finish its time quanta, and mark for
- * rescheduling at the next exit to user.
+ * For PREEMPT_AUTO: schedule idle threads eagerly, allow everything
+ * else, whether running in user or kernel context, to finish its time
+ * quanta, and mark for rescheduling at the next exit to user.
  */
 static resched_t resched_opt_translate(struct task_struct *curr,
 				       enum resched_opt opt)
@@ -1045,6 +1045,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
 		return NR_now;
 
+	if (opt == RESCHED_FORCE)
+		return NR_now;
+
 	if (is_idle_task(curr))
 		return NR_now;
 
@@ -1106,7 +1109,11 @@ void resched_cpu(int cpu)
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
-		resched_curr(rq);
+		/*
+		 * resched_cpu() is typically used as an RCU hammer.
+		 * Mark for imminent resched.
+		 */
+		__resched_curr(rq, RESCHED_FORCE);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3ae70ad23ec..3600a8673d08 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2464,6 +2464,7 @@ extern void reweight_task(struct task_struct *p, int prio);
 
 enum resched_opt {
 	RESCHED_DEFAULT,
+	RESCHED_FORCE,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
-- 
2.31.1


