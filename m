Return-Path: <linux-kernel+bounces-66235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600308558E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877191C22F43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EEB1C06;
	Thu, 15 Feb 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8J3ToNJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VRhb2pWW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227017C8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962680; cv=fail; b=Yg2FmEqNhAqjAY/yr9ShUgtVSuzZvX1B1iCRO1IP/pB9lZ4SEDRtv1EOZ/NYG3gej+YvCxD27ieiOdu+Pl/BhWe2WzD6COROw/2nH5WtSNed58rneeLMHs/nGuEdxRWdxZ6n7ersysJz84O330F6ZltSBeZe4LWPD2ozq+/WFas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962680; c=relaxed/simple;
	bh=spv71h2pkjvYBZzkZuVCunxF4HHxiqwNmf4mp1eruqc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=mDmrYK36KAW6rWPv2OO1cE+X5URCNs9nEAEmVmzD6wYqhO9D/DVWMAx2wWn/s6I7S55nZTHGo9uEX4HQOw7MAV9WSUZRi8vb4hiyWWjzTqIyE7Kxvk7fhFhD+WEEORM8PvjGfVFqyvi8MjhqBMQzMwAKGpQhaknQ+wYSdtx6XjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8J3ToNJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VRhb2pWW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiDVe005270;
	Thu, 15 Feb 2024 02:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qTOocIp9E4A2T4OI4I7vY0jCrZcYyhORgPuAlOhwH2Y=;
 b=m8J3ToNJG3f1HWnHRmcbGE2giAQ+lU+40eBFoNmdRyrMIgbW0gvC3EnsmXat2GTEu+GO
 XwN3NkHHmFOBbnJQACUXmN8rRiYp52yQ6Nsvkve4MjvdYkMMojWYk74v7FAIjOJqlOA+
 qIaBvLQWQMX/U2GxD3hKjZS1P6TMqex5bSmpDKEgrMbYTBK+KXMdwHri1Aeie2kMrKHO
 D69Tt1vx310If0TSHJcQJQeH9u7zNLAjf1VnWDBrZuYGXMcS0iyccuvgGjaETivpWUUB
 BdpbotNumkPxkmI9I62KFh2VfOZbOWP5KCZjY2AUABJvQK0Fsi3gB/XXrWbmO+pX6DyX Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppgsww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 02:03:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F1nsBx015173;
	Thu, 15 Feb 2024 02:03:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9hhxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 02:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz8oC6FQtwoVDu6lvD9hPbC9M6ZJZGUwhAS/Ld2e1TUaSoBg0lI8Vsvm2KKYLY5ALZxzGKftFebyG/gEaxFzxfhkM4AIu7dVJlcIpOWC0wzrD85o08F5cHEJ4dnkpuO4R78Zidko0EV6m8Im8Rp/oZRLJIRIYj9uCZtmqcEUIAbHeYnpHZS4YlFPLU37xvlduyb53CcEXAtyj6ioTWI9DVcBJnelj+KMzdEPFIT+mdCI33fQAHlDyp2db0Pmuxfrx5gu991iPQFt4BkPjEfN7Hgjj9V4AghHE2vmfUq3VEMOmhadL58HeK7CP0/beEYJaJoLvucNCLgqbMcDwJW9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTOocIp9E4A2T4OI4I7vY0jCrZcYyhORgPuAlOhwH2Y=;
 b=cf8A6MBLQeaoGzqpEtmEKaOnZt8BC/90xjHszaSS4FvdNHNZR7oCgeJfEVBsh31VrfGvhq3u/NoQCPtq86POx8xyIX1Q1e4AXvVGUZdbSlQWUcfdd0UaPulBaZb6GQWnTOhvTueYyLqPpIzc5IoUoEj+G9xy7MwaxqdWUhdwt11YKEFJ+wXXBSQny7UxjFPdUJJeHKUESNru/Bn8CyYKSJmp/SeS5439cAzlls9sBd9rvUHaScw8BUtzyJfw6DYHFCJ4PBYqKv/bv81pP+UNK9/dLyMKFAQFHGuf/n5omR0qO2q/1qNAwyQAujugrSFWmFBIaxKUMNVSBQMwDJRnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTOocIp9E4A2T4OI4I7vY0jCrZcYyhORgPuAlOhwH2Y=;
 b=VRhb2pWWjgJgNOs3reA3wGojl4Up3eZxplsSmaTFtLbBQ4w4MnFd+r6DVabVNmZWGF0gjaHs7DcpNp3jQnxdbUmgPrHbY4scFNFCcmM+3oLnG3+yqhb1NmD+chkjh49iIs678qku92dncs5VeCkbiStNEihT1Ovm/GC+tt3Hg+U=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.40; Thu, 15 Feb
 2024 02:03:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 02:03:08 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
Date: Wed, 14 Feb 2024 18:03:28 -0800
Message-ID: <87le7mpjpr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4916b1-0cf1-4710-7ddd-08dc2dca418b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gIFYwZA0KjkOzPL7cbb4QB72cZRATdC+cyPKrFmFJYCnfzguVpuld65qe5NWHvEjdcEJGJELhqlM5oceroSJU70BO/82V5I3TXM6gHqcnCx8UqqTRY6fXCUaFXc0unQYBH9ybQC1khqdkanUYdVXyqpFVNtXyR58OSUUGxlCms6EVLhHWcmF2/OoI+hQNnr5iddAPd0nWSPyYCdd/uNNZ+BZKLAcWfF0TCQBX2HdjXh3SyyMpPxIF1w4rYgGOFxgZIaqA3kzlHNVIzCnh/Xq1bfW48cISpJpT49QR+xdjyuoaez1RY5JR5lCutkF4yenkYcxk346MR4dYCvanx2gW+8V9byyzMyHgZGRvBld1s0rG2pmhN3lkZploCdlJElp8ZKC/vKyZ/uWXYgWMpIZzxEtWG7/EbwrFr6aPlsuGLCdJjs+CNDOWVil5SpCRYoL8VzUWr1FIqbQZpQc/EFjzWumyirN9wZfcU6teShLv19gfkUuL8DFMpn0dvBR/MaxFwsU8ZO00hb6ZIq2K23HBwOMxbA7++LP0y6ZC6hk9Jkxqo3qkl3SQLyySFkVhRNj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66476007)(316002)(66946007)(6916009)(6666004)(6512007)(2906002)(7406005)(7416002)(5660300002)(8676002)(4326008)(8936002)(41300700001)(38100700002)(6486002)(6506007)(36756003)(2616005)(86362001)(26005)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oKPJoUF8cvEOsaYj9O9WHDKtMXSUlNjxxcTbUU2oCYSHJwaNCHaiW+gyGPKK?=
 =?us-ascii?Q?+sIZcKgwhiR68HEwQwzavdKys/mm5igwmbEGtpcJAArz4anVZ7/M83pLMB9K?=
 =?us-ascii?Q?TQJZH9EjJRn3S9iUsAl+p8OiVBvF3Awxszgzud7/XkNfKVI5s7tBxfY5GIT3?=
 =?us-ascii?Q?21tRak8B1/RSoEQ5Ta70qFMLDZ0AjKpg4he4WHQbSAZte1S/VdRebRNwZV+d?=
 =?us-ascii?Q?zQqjZlQVCk1blWhsfjyFUAjfE08kWA7DGKStSQW8coSrWXUFlGM9V+vXyOzR?=
 =?us-ascii?Q?YM0HmyDXzfskmslpUJ9WMoxgKbBUCGXxR8N2JlhTpLl1mjXYDNjFjKW8iSNP?=
 =?us-ascii?Q?TJ6salNyrOqY1J60xNgnstBwbHcoNi4RPPhbl1RuGs4XhpR85gWjwXE9aoJa?=
 =?us-ascii?Q?ccwspau6wAb/4T3ZiaRPIRFV2imNRLKhYfQNtTsOzO02DMX6x59hI9quq//4?=
 =?us-ascii?Q?dkEHzaVwgX364ohQn+al89OO+H8dwCk8KxDpch/FdvPRNXkTAGbyQ+Bneq/J?=
 =?us-ascii?Q?Wkp9FHFAI51O56WWCu8jbCRaF8EblMjxmPvy0YRB/YqJyEeLw1+wcJqyeCGF?=
 =?us-ascii?Q?sWq1GQmLgZoJmcO4kNhDTbcKkyjvKUNjC9fHX1NxdIVDEspKUqZ/M0Ua8Hos?=
 =?us-ascii?Q?EldCIS1oC6inkaVDJSq5HoI676eo61FEYny+lfSd3tGIggwo509c3u9l5CM3?=
 =?us-ascii?Q?cIZwR7ouIo/8m9DaKjjJUMZidH+RHmn+xqq62U/QMbj67StpETO4oBZTAmf6?=
 =?us-ascii?Q?4oIv811XUfJR3cIhEVU10xGMro/ChO40owKrxRbQI40BP7fhdUaP3HTo1oZ9?=
 =?us-ascii?Q?dM9LC3iWCtPD/gUqIupBM6eAhxOoM6KPodOUqopJo+a83jheGK8qHHYH+MzG?=
 =?us-ascii?Q?UvZodX0t0fGwlOK4z21oxcg2QEOgfTOXDR6h1jDOoEF0tK75Ub8EFAJO79Ai?=
 =?us-ascii?Q?xESzSrfiycJS/wdoBAUmSShxTptaZ4MUnvqnlJh32J3ifecthIv8nbef4Yvq?=
 =?us-ascii?Q?Cx0Xk+Ofvo1JHQAjw+UPYDvLHfFzzo4hvY3YMWfDy8Bd6oxQuOgvYfrCM3Gj?=
 =?us-ascii?Q?aQ8i3sfy85EHR5IVQCdFYWpXGlxysg34pPaZ0svjAFIEq8EF+2TjpDW60h3a?=
 =?us-ascii?Q?w7sCunLWmdxE3ZieM4JxLTjDAlUwsdqiMS/fEYgIL5WGJLDINMLAb+Cx4X5c?=
 =?us-ascii?Q?S+BfbQNIt0B1ddYwIO1zFr5hfHwu/G9qq8JuiQ00BRiH6+qCE4bt903HU4W/?=
 =?us-ascii?Q?vPtZyTU+8Ghz43YNJrsgz9rYMNT2z+jwHpdg5zz9j5d797pOiKjFJ/HBVmR6?=
 =?us-ascii?Q?eiIa8OiMrOGKaVkcjs1vN/uEdgcTgSFTdf+uON4gMfnRE2VCmp0Qek7YXOaN?=
 =?us-ascii?Q?9CUDzgnxyVMDqc9B9YYIE1xk4rOgvdkAe6/BJH/B0Yf/Fp0KAbJMiG/VVdBH?=
 =?us-ascii?Q?PzXW9u7k3jhJfwL1HoPhEsi3uutblAEg/tZYEKAUoK7lvi7x9qlfVR57TbHL?=
 =?us-ascii?Q?QORCw2cdavK8UDVJet5/EVK7q72vnqY+OyRIxmDQdSV+/mDTHOIHw8ldHP0T?=
 =?us-ascii?Q?Mcr6VMKOcC3Iru5YekvOuEsE8hZP5Srf0NFkGABklOfahCsgQRWAVtAeRyV7?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2TIppHqmq1+S5uNMagLz18p0iHRVvXZy4SoxNlvVHXoSQAvIi8Rz30nPJCcOKAdMbioL6NS97umTBih4+RU2ID9ENIICISQrQjItNUysJ04D9ydSrtT9QozelDXlInTz0Sf5pqzwrwRxoDnQGUHaTEAULwklHkdHz7KjI5F0cW+egG2rQfR3DxrndmAlUZ8E4OAq+t3FOy8egDbbiDxF6L9KSUDfzPgIIhngaIzhToLE04BT63edQbR3zd3BEZzx8HPYMK2zddM9BmH0c9DinLPH3IC+rYKsoj/oZPqw9VD/uiG08bia1vSxsWjOdpbApcGIV0pA3JUwSH9y8K0ZMfl5+bbmgS9MLOPY7GQqoIc2YKMl3vmWx3cHiQjFcRkDfPC3LBNEq+719EsJDdTiysZ4n8lgoFoKw7e3hOwnfRqDMDjps+7DaYwFYQxnHa3+qOI+grbOGeNVC6MTKG2+ilAUZElXT19fCMCo6+d2i7npSe/ZDJTJaj94ZvPxRSercDgWBeusCmJCzTr1ZZc6NGl+u5DdbkPNwLE6tsSoruLway0gQ4y2Q0qS2do/YB8lcYC4fYhQcslV57Nw+BLNR6+rARrUojgopWF46YFqFzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4916b1-0cf1-4710-7ddd-08dc2dca418b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 02:03:08.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBBztsaXyDXpEsTpOfg03VHoEzW7iQPhI3jd4H6B8KBv9z0a6EOXbtqXtxd6oPdIBC208Hz57RusOeZqdHjJXxLrNArkRGaHUUio7RK+EQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=563 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150015
X-Proofpoint-ORIG-GUID: xGmNanpoHWT6wEILztKOzZe_yWIbKkXE
X-Proofpoint-GUID: xGmNanpoHWT6wEILztKOzZe_yWIbKkXE


Paul E. McKenney <paulmck@kernel.org> writes:

> On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> Hi,
>>
>> This series adds a new scheduling model PREEMPT_AUTO, which like
>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> on explicit preemption points for the voluntary models.
>>
>> The series is based on Thomas' original proposal which he outlined
>> in [1], [2] and in his PoC [3].
>>
>> An earlier RFC version is at [4].
>
> This uncovered a couple of latent bugs in RCU due to its having been
> a good long time since anyone built a !SMP preemptible kernel with
> non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
> likely for the merge window after next, but let me know if you need
> them sooner.

Thanks. As you can probably tell, I skipped out on !SMP in my testing.
But, the attached diff should tide me over until the fixes are in.

> I am also seeing OOM conditions during rcutorture testing of callback
> flooding, but I am still looking into this.

That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?

Thanks

--
ankur

