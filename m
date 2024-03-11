Return-Path: <linux-kernel+bounces-98467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD57877A87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA01281C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6ACAD2D;
	Mon, 11 Mar 2024 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O3GT1LlY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4N5cnTY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE58F41;
	Mon, 11 Mar 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134389; cv=fail; b=owqLPvAJT3VsH+nZ6R7bKlSFzE9QkAiLPNckFlq8eoc9sraQsh/Rb58qLBAsbEKf8f+KbAQdCrZGTtdlDCGNyp2y5q07ZmiIHFpXiveMbWg0GUFqoSFL62sbeLx1KnFQQcABFFwGAiLkA7QkhhEiwF+9Bg78pAq4hkdziuvvzxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134389; c=relaxed/simple;
	bh=fay8IXseuK9bv4CewojIf9KbH8a8clSDNd90ZG48ieY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=lmLH5Ag2gZD/LQdwYFumd1GthCFIZ48umuQU4VZPLa2AB7xvQ7Wvw9VTKJx9EpTJpjZwzsj90LyGgi1QlRrlfgQWgmMc2sz7PqZWDMhD9oUL/pzBjeYo0ZBjKPbnx1NgGUa1YrS/G9YzyrgaPeKUMASojbDzalVhSiXdJwMvGf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O3GT1LlY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4N5cnTY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4O4F0019311;
	Mon, 11 Mar 2024 05:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=MU3Fxoufoobp9tuQNE4kmdlGb9NEPQAcSnPB4bQzkbw=;
 b=O3GT1LlYVodcoNtA7DrTmVozF5/X1gVZ+2xsT2KPZRSBKjfmCtejKTWzdWxp7H7izgnZ
 NTzguvu3wQy8k/rQBrO0h0jmrI5p9YLKLWEaRez48yqghbuuNdalrBnYLtVVcH6PZdiD
 mtfZNenlvAxMjh2LN2SjbchytJDG0e6wE+77vbX2fChBExwHNBsmFypHyOFSV61W3FzQ
 wRK65ByRXGSiBwBT+YLvVR9QNZudqkB4mopoMUXHWz2QJXwg13O/VCoxmM7wELgHciAh
 JVFBZyP3H24591KyaGk/bFhhb4J4uW5K5JP4VZRjAQ9K5HwiZtp8UGt6IUnTLE8U1oKd rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepctcd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 05:18:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B3BBVX019891;
	Mon, 11 Mar 2024 05:18:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre758jhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 05:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyPEyDr9rWtvVQQz2MBeoyO1JuD80bVj++j3aj9N3Gn8XDzHtdNSFpximtCNpidJ6FreNs0dkcV7opxPSLsyDRVvO+tsp6tPKYwgb7Lx6bue/7xhxzx3z/IepT2JQkiBFKWMCsJNgn08aByTK+5FVIcIVO9PV/sIQ206BaqL2PM1zbVs8jLhtuvd//v85Dug8VkF4TeMAb4sj+u695xBjheAj6InTlostS5IwzinDxe4fDGPnsDJmHEpKfhaXJvq0So0WprUeKFqBvoAxQSG9EaYz7nve9T1qg5JHSChYqFwGASkdrmhwbqPzXW6SOWJO9s8iBUO8G8ujKWGlSxtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU3Fxoufoobp9tuQNE4kmdlGb9NEPQAcSnPB4bQzkbw=;
 b=agG3IPW5ZBRyAUFteHP7kaVnG69e8NtEcZ1+ugfq41CsX/ZuClG+NOkGRaJUXcwrMF4ohZrYDozyZ4UeiHpClcytjCbvt1dzr7iaQfhfv1P3m1gXsugs53B7ih353o+0dDtryZkWdB9ZTuGNeHnhGT5h5VriGeocD4D4u/l+GjKu+U/jQQHpwuLmxA+nSlhUValezUxFtAjfjikdfh2iPT2rJlB6pVxMAtbWP7caBy5lYy+OHAQxnL+AWd7QJMXxY13om9KA8UO1o7m5J4jdyarvbiuvw5wiiEe1n0asK+Hn0mCLbYX3hRlAZOrvWUGIFG9lMgODGPKUm/TJ77kfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU3Fxoufoobp9tuQNE4kmdlGb9NEPQAcSnPB4bQzkbw=;
 b=X4N5cnTYoEFdMgSEZ2NEhw0lsQIM6TMbxgF3wHML9uZGc9b3RLnlCT4zEbq/8sooPhUTJuVLM9HhSpVjx8F/Px7ajVr2T+Dpw7dkG8Jv3gLjGXeMIQB52tD22dHk5/3Qkl5pV/TwA3sZglOxcmny9HTEs0+nJISmm3IvmnjxmNw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 05:18:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:18:21 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
Date: Sun, 10 Mar 2024 22:18:52 -0700
Message-ID: <87r0ghl51f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1263be-0fb1-4fa2-99ae-08dc418aab05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G59L/LIFoSR+QyENI7VKi2tJpuNrX4MH7E9y+e72JO8pmn56ngF0RwYH3E6RWzPABSUmOG1nnuKhwojFpHiLWSp77KtM8YEcgqHQQ6Vce7vDnsLE/z5jMgIHgo/8ZQTAGyiNj9fIw2nOE7HBPCr+dVj0fi0j7ZAsibyg2b6NrBkAiwW8FcqXV/EBjf/7cd8XEcvzudEXKRO84P37WhU1tK94PEWkEmmO3SuyI+edt60Pk0emv8sSvhzbU/oRwmSmEYAlp9XP61mk6AQv27sy5RFshlJfd9x2D3HdR5IFq9hSdsMKs6tA+LbXb9ah5Cka4eEPbRYhY2K2FdmuHv2+nqF4tGakDr5n5YME6TItxuXDaYcWqz6wNL21K2EOozr7d0fw3BP3A36gYRe0rnWYO1BXmig8LvZCjR2Rc4gKJx1jaD4bt2HS987KgcF8lH+B79G8t+T0kyh86RT05qmHRQThIPeCUZxrcWL3OaGfb/wVGKyYMAE0J+YUL90v7TI1E1OhuCNq2oA7KDE2Pj5dQhR70mBqQCXeZmW+YzAYUQkdUfxhai14zwSuonUNisvak2n64I3/jSKK9nQSyfRgReoPeibXqaITsa7NZ0n9jSMIujgR5DalWUYwgf9hQ4sgJkP8CrDv8UKM1Jnb/UJdc6h82pZxVrbwcEgyAIZyvck=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IYeO7gulcgknkC/Q3EBrI3xP09KjPUU/athdDcT2QefY0ePKq79rq+fBExRa?=
 =?us-ascii?Q?1vJ9VtNKYvduZXl4HPtEoZ+eWkmRa4GeuX/z/Mh9Te/0MMqNJBNUsNG/uhYa?=
 =?us-ascii?Q?mtCF/W1r2TRRQuWA7sFgGwgvk/Rb4moVRcUTZ6ygOoYiOLG8NRFSnzO6E+8D?=
 =?us-ascii?Q?dgmLQbVj8k+uh1ySrnFtA9oPuehPxobhDDPVwj9hnJ9cKGm8RS+RFrc2CqmH?=
 =?us-ascii?Q?Cyi8KKrNJ0gSJI02xHy5Czv2m0RudkOy3EUHTSrva89jA9CUNdjrI3+074wv?=
 =?us-ascii?Q?91X1NBDa9MKpZZPEpijj3zAQgbgaFJbLIucgE3kHgVwqUAv6ffHqiDVXQcrc?=
 =?us-ascii?Q?rvX53ttl55/8DYJtnAT5d0Z4KMkWhXCzDg4IUTp7VxbCdbpJGHWYY36MZJgU?=
 =?us-ascii?Q?FVXZ4T/u3mph0QiyFUlFrdiBXGFzOvcBlKQdg5lyEaen7cyELbhjzSctAbZ0?=
 =?us-ascii?Q?Xa4+wo6Gq0FcIC61MeJr+PoAwicdbwn+b8AbY/MidF8LQfvjMT9zk/yJjzxP?=
 =?us-ascii?Q?CHmKHnPh3+sb/FDKvQ3oNlEpupAyHr1cKTiXIaOfz40H7TKYczVARae5xIT7?=
 =?us-ascii?Q?tRg8B3ogngImQxIGKIiT7r9CzwQp/8qVYXRJFP7p/6kl1f8XJpNG8aQUF+t8?=
 =?us-ascii?Q?4vPVSJrORDcJBUk3GBKsNL8xC0EI6WUqqRbV9wnZNqjqqEHTRKK1hJ9m1uNP?=
 =?us-ascii?Q?ceDJmUwh9UqeQVKGjRtAaBD0Cbs0iHmNWaR9lLDiiJUmWcoB3YlOsSisyeT1?=
 =?us-ascii?Q?DPXGP8/sjBvneI8eay2Z+jSBzGaK44IAlbL96JUPUm6WSDXNdv3uKIJo5MgU?=
 =?us-ascii?Q?p4G2fDAzkCbvd1ZTl95eyJfNJ3btvONCgEEePHcPBz1zdQqVaXq2ORvEJU+y?=
 =?us-ascii?Q?oZEGAV/46euMqPbZzqHgazq0iaf4I/Ojd7Bli0Vven22FwCzD4G0o43dJ8Yc?=
 =?us-ascii?Q?Es751tLh6tpHCU2BOVbC4aIBDJZUqQmUwfP4w99GSRrZrMm6i3VZ9gI6inca?=
 =?us-ascii?Q?mmKbCd8FOXsXQPFpDInDF926C1e545m2IqpNe2/6xbZLlpMLEZglWP0LyrN6?=
 =?us-ascii?Q?uWsl/2WPoQXW+LJ5kt7uBTI3kbVDnIzO9kKDi+xL5Asb4YDorbQG1XqLtAU2?=
 =?us-ascii?Q?jNVYJg6zCn4Ue5LLuGVKmyi1Ah6ZIUDCVkp0RXwoR6XaZ2dVnE6EjpuVwbY+?=
 =?us-ascii?Q?QVa6ocRSm2icAcXU9fbbEJMBT6yEDekwDcla3S2vaVBC94fx8dAmKyjV9Vzc?=
 =?us-ascii?Q?EW8H4hmaLEielmKRHLxdthJ7NvzM13+CQyktIzgJ7BMx4R5TafYB4aHGRee5?=
 =?us-ascii?Q?wk7vhw/AkkneXE9UyO71HrtHHXjoOI1cEd0bfAntxRPpYd+nyPYzbpUNaHfc?=
 =?us-ascii?Q?Y7TA+Pd0akxI6lebmbL8G+BLb5xJkhcFoXupkoZXoGr4uVCfJtKOpg0atGc0?=
 =?us-ascii?Q?k3YY5ELGVYH9RRN5qDOmKbnhFwNrA0cPUAAJbOK7oZoWmXYEn4dyjstnY4IH?=
 =?us-ascii?Q?nvlz61BLP9dlZb6gbcKzhpBFt6L9DWjUEz+KzrN6cPDU9p3pnj1PIRGhnpkr?=
 =?us-ascii?Q?4zQm4xH+Na6ygHJkaobFQxqmQ1eWMTS9rj28aLLjASH2uhp9T7Z3+F85Bw4H?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ldDlcbvBEiyTlEtaIuGx56YDTmDSNu6/ANI9ZJDjIHSlTFqkYWpxVCWQoozeZ3kjBked03oFhcADypKADZEr2z/ZGIWidQRCMwX6rOf8gx9WfyoGMnIxQ19AzvuiYvp5FgiE8XtCvkJx+3lY6ket0Jso5wlnTLNrVVXkgtYJCZtAXhGjL08lZmG2z5AhU5pEgMzWO5Uj8MB2myhgDdQuLjZYQH94WF6t/RHRUJhffTtydUeIb6bt7UzSlH2cwFyz4c9bDqdFPObFQm0kI8NA5fu+jR8r5Hu3BJd2PQ8Yry0SQWQVV1K3r+lXdvT6Da8SE3EcOwQwfQSGZsTAjCjP/AeEMR6Czya6NvDizbMwE/b8dxsPvyyNVdulDF9R9rlCZwKTNM0HMdyqnAkr3nq/bXpSQTMQqM28XbrVN31DZvgSl8M2EjeNzw7xzfvpssoO8MChna84TxvVrqx39RRRV2gWnRsvfSWzSu76NvV7Udu2/0jXt+6KeAd7ov5q+E/dEpvR3OAz46//Qvr3j7xymwMIHnhlBwP0PAaRGAGNClkJaMdw93iYk6oh1W2AfbgpQoQoXH5fGWnpniI/QHIfxPVUsryr11d86nm9EJq77qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1263be-0fb1-4fa2-99ae-08dc418aab05
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:18:21.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpqPlw/rlSqvH1b634hQoqO999ovNtbJ7m3GFm+Xp7cfGNwY6mhbeSONr7QxIxSnpSV5I0AVBbD/N3NBObENX0SEv+HeMXPS1sGr2sMM+Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110039
X-Proofpoint-ORIG-GUID: c1Av2sTbyuGjsFqRy8kLEaT5rh9GZZ5D
X-Proofpoint-GUID: c1Av2sTbyuGjsFqRy8kLEaT5rh9GZZ5D


Joel Fernandes <joel@joelfernandes.org> writes:

> On 3/10/2024 2:56 PM, Paul E. McKenney wrote:
>> On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
>>> Hello Ankur and Paul,
>>>
>>> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
>>>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>>>> states for read-side critical sections via rcu_all_qs().
>>>> One reason why this was necessary: lacking preempt-count, the tick
>>>> handler has no way of knowing whether it is executing in a read-side
>>>> critical section or not.
>>>>
>>>> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
>>>> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
>>>> not provide for quiescent states via rcu_all_qs().
>>>>
>>>> So, use the availability of preempt_count() to report quiescent states
>>>> in rcu_flavor_sched_clock_irq().
>>>>
>>>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>  kernel/rcu/tree_plugin.h | 11 +++++++----
>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>> index 26c79246873a..9b72e9d2b6fe 100644
>>>> --- a/kernel/rcu/tree_plugin.h
>>>> +++ b/kernel/rcu/tree_plugin.h
>>>> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>>>   */
>>>>  static void rcu_flavor_sched_clock_irq(int user)
>>>>  {
>>>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>>>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>>>> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
>>>> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
>>>
>>> I was wondering if it makes sense to even support !PREEMPT_RCU under
>>> CONFIG_PREEMPT_AUTO.
>>>
>>> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
>>> the next tick boundary in the worst case, with all preempt modes including
>>> the preempt=none mode.
>>>
>>> Considering this, does it makes sense for RCU to be non-preemptible in
>>> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
>>> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
>>> from happening, because rcu_read_lock() would preempt_disable().
>>
>> Yes, it does make sense for RCU to be non-preemptible in kernels
>> built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
>> CONFIG_PREEMPT_VOLUNTARY=y.
>> As noted in earlier discussions, there are
>
> Sorry if I missed a discussion, appreciate a link.
>
>> systems that are adequately but not abundantly endowed with memory.
>> Such systems need non-preemptible RCU to avoid preempted-reader OOMs.
>
> Then why don't such systems have a problem with CONFIG_PREEMPT_DYNAMIC=y and
> preempt=none mode? CONFIG_PREEMPT_DYNAMIC forces CONFIG_PREEMPT_RCU=y. There's
> no way to set CONFIG_PREEMPT_RCU=n with CONFIG_PREEMPT_DYNAMIC=y and
> preempt=none boot parameter.  IMHO, if this feature is inconsistent with
> CONFIG_PREEMPT_DYNAMIC, that makes it super confusing.  In fact, I feel
> CONFIG_PREEMPT_AUTO should instead just be another "preempt=auto" boot parameter
> mode added to CONFIG_PREEMPT_DYNAMIC feature, otherwise the proliferation of
> CONFIG_PREEMPT config options is getting a bit insane. And likely going to be
> burden to the users configuring the PREEMPT Kconfig option IMHO.
>
>> Note well that non-preemptible RCU explicitly disables preemption across
>> all RCU readers.
>
> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on

I think that's a view from too close to the implementation. Someone
using the kernel is not necessarily concered with whether tasks are
preempted or not. They are concerned with throughput and latency.

Framed thus:

preempt=none: tasks typically run to completion, might result in high latency
preempt=full: preempt at the earliest opportunity, low latency
preempt=voluntary: somewhere between these two

In that case you could argue that CONFIG_PREEMPT_NONE,
(CONFIG_PREEMPT_DYNAMIC, preempt=none) and (CONFIG_PREEMPT_AUTO,
preempt=none) have broadly similar behaviour.

> the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
> to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
> kernel but are worried about reader preemptions.
>
> That aside, as such, I do agree your point of view, that preemptible readers
> presents a problem to folks using preempt=none in this series and we could
> decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
> just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
> consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a

PREEMPT_DYNAMIC and PREEMPT_AUTO are trying to do different tasks.

PREEMPT_DYNAMIC: allow dynamic switching between the original
PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEEMPT models.

PREEMPT_AUTO: remove the need for explicit preemption points, by
 - bringing the scheduling model under complete control of the
   scheduler
 - always having unconditional preemption (and using it to varying
   degrees of strictness based on the preemption model in effect.)

So, even though PREEMPT_AUTO does use PREEMPT_NONE, PREEMPT_VOLUNTARY,
PREEMPT options, those are just meant to loosely identify with Linux's
preemption models, and the intent is not to be identical to it -- they
can't be identical because the underlying implementation is completely
different.

The eventual hope is that we can get rid of explicit preemption points.

> week from now, no one will likely be able to tell the difference ;-). So IMHO
> either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
> optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.
>
I think that's a patch for CONFIG_PREEMPT_DYNAMIC :).

From earlier discussions on this, I'm convinced that PREEMPT_AUTO, at
least where the user has explicitly opted for throughput,
(PREEMPT_{NONE,VOLUNTARY}), should support the non-preemptible RCU variant.

Thanks

--
ankur

