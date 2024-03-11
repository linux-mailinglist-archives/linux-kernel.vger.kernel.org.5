Return-Path: <linux-kernel+bounces-98480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF02877AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9451C212C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B972AD2D;
	Mon, 11 Mar 2024 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRwS9xbi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lzckOw6r"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB76AB9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135337; cv=fail; b=J4pDzoOlai29F/bvf66cXBF1E+4YmBN+EeujS8gd5cZ17/F32kK0hocJSnzzr1Zv4TA7nqtR/vDNgyhDpr5RzGd9195m4Ny2ONoqdXEssI+rIGlmRBJB4RzQw0hIRajANRvIDiYIvN5Pa2aLHw2t94TeWIwNhNPc6jwdjilP/d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135337; c=relaxed/simple;
	bh=vNXMs87mebsFNbMnuShrP7MjymdSr1apSvpZkGFnJTg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=r3bkyP+jqchMD7LKIsHv3n0wmHXqphvLJVelFfL738+ye7yqTqqAcAGqTgwo+NWnrw64VKFa+5XHM71L9b5A8fpqVhDCMM0AM2eedZaMM2MqK9b3Cn1/TtywMVvKyP76H/zacmnJg8Vs9LlTO0/VhYaKn8EFcUK+wordcReCTo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRwS9xbi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lzckOw6r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4O98X021920;
	Mon, 11 Mar 2024 05:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=vNXMs87mebsFNbMnuShrP7MjymdSr1apSvpZkGFnJTg=;
 b=eRwS9xbiGWOtzpEZqdF6jKK0/L6EedrhfqXSHsnhiso/9nSdR8oQnI/xXuXEP1aa7WVl
 VrnkiSq3ivTlMhXVwWneDsQtX7tNPP53ryJ2HE6fR8bisadqgmrxYrhXqw0q5iOvaw/p
 0Zj+6VEEngwZwmWhxRdNtBkT548jXAf2JwmF5/IW8MlvLobzQbSzPOAU/7cUMx2Djn54
 O2QdXHY+/G078phlVBNWzw4dAnLGDk83P53lOcT1uguiCRBLO9uinX+7weln/JJ6+Zlh
 j3En/G4efZ0z32i9Edl2U0bZbFn/9LHufUpi1W8wvjRrYl3xXwnDVbZzbc1qJ2VNR5YB Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6eacnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 05:34:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B4tQQD037374;
	Mon, 11 Mar 2024 05:34:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7bgdf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 05:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2uZuuNN7Ppnqot82dtoL8sReBAp8iX/Iyl1YAShnLGxdWnUiOyERr3NYoPiivCCvC3gaEUTPO5NS6/rAezJrawJ2mzoyblKLKUQEXxDvskddKs9Jl+5D5oo2AT8UynxK3Zxrseqv8mJMOKUNwLN9KPM3oxBx4ianJd4oEvJOvj8rnv2FDKJ8Zy2DwpoF4FZQm9GgtvIzDFhaOgB0BkLjihDOQ2/FUDWP3v76Lzl1gsXYA0PtsI0oeEQWe6LOzY0486OVCjHNjXuo7gi+VOceIFttIcPD1EDcaAEjtxp4+O7g5OUUOYtqPMIi7W7O4sH9BmB/tgTXFDPit4tjfaSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNXMs87mebsFNbMnuShrP7MjymdSr1apSvpZkGFnJTg=;
 b=Fa2LYmqVyC0c05Ekthn9hCJRSBX+pndTxSBfwRf6A7bANqww9lCZ65GMkKMy75VlzMBoAOF/Qyfbc4xdNhACiWE5QYL3SuTjnyyYS18IKYB3etaLGPFuXKsj0mfJqfccyZsEang8PAXj7InO1zHRyEF1QDF2uxuSh3tNAZ/MGOEBtyhqWLx8DolNebj+QwyuJVbCll1xKClolFSD0mBu8UHD7Dyv5ULq8Pds/F9B6ZA+8kcngO10sHx0GvVwKNbVdownZZ+QSJ4qs0P8Ltap1RphUfkUBepa1x5S0BjGUE06QXVMr15Omkspj9J6RcOQ9ZwK6ndiehh8rQeFA2782Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNXMs87mebsFNbMnuShrP7MjymdSr1apSvpZkGFnJTg=;
 b=lzckOw6r74b7dirxv88jPv0dliID8qz836s3ebvMZeoEY93BY2NRYyvfWaJAK1uLZXp6PyLG5cu87AbxUJAtN6SypM4l8TFtCJf9sGIM4l1WknttDP0aYL+MZSa9aXptnsaC8Jir4tUfoh9buy4Bqn4j3pBdKLwUqVnQu6tciYs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6053.namprd10.prod.outlook.com (2603:10b6:8:ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 05:34:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:34:25 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <87edclqt6a.fsf@oracle.com> <Zeq2FUkU4nVSjY7I@localhost.localdomain>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Joel Fernandes
 <joel@joelfernandes.org>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <Zeq2FUkU4nVSjY7I@localhost.localdomain>
Date: Sun, 10 Mar 2024 22:34:55 -0700
Message-ID: <87h6hdl4ao.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:303:86::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: d3333da1-8a76-4f69-a386-08dc418ce9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JQVWKDvJjVzS2iGNC8SHgCRhsz2QN/tIeWU0l8LLpaaqzWPB8i35jJ/fPidQ70fw4DcLd1SaZ7HuRrbrG1dq5y78yMkwpLlBIfSGIKxk3mjzoUNnv8bbvn+LmZBRqEwQMFIivQ8hLTodycam431E2hqHbG9rRrvHCcXWWt4CdlWQeVGdnRC04OeNpolKDyNpU14zU+PMt28sS6jgoHfFUZ4cRyvhElr8o9j5gAzwHonw0wR5qwnbvDIcdTkr2eoK7enk6fQ5YLhSt2JLNw0uJaMzu8AB/YIOd4L5HFZc6p5t010hDYUP53DQPVogFl60bqGexPbSDMH9zzhv7uiQa2vsdo8yOo88fz7ZHEbS90lpzlzBa/Vl43/kOxucjkKPAYbNZaff+uz5kMQQamwpNs9qwzJEqLBtU6TZ3Z5JgbOYP6v7VV4mmD+7dwJKblXdt/HkNGnUFZrjtj2ylsvavjAKloamEzRBVKM2lRDMdwFhdJfJsXnaszOtJAmvcchtjw82fIWuZiEEG/8u9JnZrDoyWElwxda2MweDam/XVxoFl1sqvhi2VhxG97eDvfrijXmdWdWwX6WFA9Px7R14Chkme5eQcg5ZVhy9DD//01+SOYqOyyi2hfztZfkramMY5q0Mv7nYhpbS3XLj9NfMoTBJ746rtEJ/UMawjKfaL1Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vFBBKVgt/w9JFTDuGr7mM8f3TfVhzutejpBnujXT4Rf14aRV+oicLW5uWdXq?=
 =?us-ascii?Q?MKY8DXZAq1qi4RDZQ1wxRNQAQ/6Bdf4Pxnapx/RhRYfv2kagwb/Z8u+7Y7Td?=
 =?us-ascii?Q?c5h/nQERZ1nS/Z3ytJjdw/EQIt9pLrVqD65haldyJntTa9S3pVgBxTNkJxzI?=
 =?us-ascii?Q?Ph9KI/Q6f9ZZxrcZ3d0/MBhqZmB3CanYHm5X7CtNJ2LauQdueBgFWkrp5xO4?=
 =?us-ascii?Q?07Qq6Wi41V9Nocy/ysyX/fBSEtzGy8BZp5wKsJqKpxLu+pIZ072t8oGjw7bG?=
 =?us-ascii?Q?WKOXK54J9gYtHTns5RypQiGVYnPAkZgwbT27VYsKNMUL1/eardkJlY8zLhNc?=
 =?us-ascii?Q?sxVchDeDptSmAVDLWyJ9GidI1dDOuhs2sRiwRQO79V4A+7XrzHz8/EYiJYtb?=
 =?us-ascii?Q?k7G/W1bYkRPhWxjXX+lCg2Pf0Hh3kz89stXNMbgMxcEyxVn6jfvlMh8yvByg?=
 =?us-ascii?Q?RLHFqSs1s3GVED/iUGJpCBVgXzEqDLzQIpnJZRjgnWS0grjrtYuiBaCfJohM?=
 =?us-ascii?Q?gjXgK0BvQGybq7GEnBklzZmAthpgqPnjZhR0kpEo1QSAKUaLS/YKbPCOwiEO?=
 =?us-ascii?Q?2IhRhnf3cpinpZiw9WA11u1+5w4+VXG/ZwEo7IO/kHBXZ2q9lJxmxTtSImxo?=
 =?us-ascii?Q?4ibUehVmkwFc7d7tdvj9SOBKwEV4FKvoVzWtVBTc8XMX5RwsTyE2SUPCfjpS?=
 =?us-ascii?Q?S8mfgjlTddl2BDJuKiaCG0ewIB5BAcZcs4+O4nsxhvD0n0N2nImxkdBk5v1I?=
 =?us-ascii?Q?pHfFSMGovGABD3ZbVZquK22kbXts+eDVZl4JzA+QuzwNVS+fL4vob7ojtnWy?=
 =?us-ascii?Q?Bh46UL5LR9olHFoKg+q27hEHeUz5WtR7UBuXNMMIu0GGIy4xE7hKrDkvUiWg?=
 =?us-ascii?Q?8+dFi2JC0t2RR+UwvpFB6QIA7SEQnZcjQrC4wQnepPbtAfVlF2yhVHI9dIsq?=
 =?us-ascii?Q?Gr5IU2DhhL94+qEKjCAWqHI5Ws0cZ3kQQqtxq9s9m3p3I5MbsihF+8QHV2FE?=
 =?us-ascii?Q?5Hk3VrgBVEhhnODviTBGZy+6f2q02exOufNxeMszYbbyyo4Oj19QmzbBJ/lk?=
 =?us-ascii?Q?cd79Fz5qIupbmDf4RXiWCdhpPmGLC3JGFaf9Y7/MdfqEUwvSp9OZjNVHoXKv?=
 =?us-ascii?Q?nokYfgyk333M8itrWZtKC669LJRRzEAR97n4dVgzHAt94fV+x0e1CDfUj5rm?=
 =?us-ascii?Q?81v6t0Q0KBohKUTB+anXYg8b41Q6tcC97XiTOb5FniXfGcR0IC7+e+SRk1aI?=
 =?us-ascii?Q?yvG7rbm/C5KKeUeIt0/TKMFvte2g/kJZRwCNQi1H7D63XyxWxu6rf6cReLok?=
 =?us-ascii?Q?ux/D11D79851PKUD/wizo0adCI117mcoKeRdNp793vz6fKpEFUV9IHr4R5Fa?=
 =?us-ascii?Q?mJ8zWlzWzp6MpbSBL+VDJE+GzEoZW0SMDpPN2i1GcrwSJ2CurKIXrvnzyg/G?=
 =?us-ascii?Q?CgPLFF7ZiEpi+8ITPyxS0gpsn39IXNdjDEbUNKGhCYs9N/asO+aRWA3evJ5O?=
 =?us-ascii?Q?vN/wH4EazTdXd86dnH4aDLm0ZtaafzYHezURNntfs+cRQnpT1Kqsluo4eDmf?=
 =?us-ascii?Q?idxGMi1PgPmO1csfb79Uv3cvtR7EwueM5a6KBnaUFPkpefycG/m6Mk6K1CcU?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/WBXcblADdvSqu4g5GX7ZZBxjPlxoil32wVe7m4RGM5pEVpJdkaQOO1YIVqvr3GzI9+mgocB7HYbVP+rt1Za1h7b8os/do+LFbAmRLCivRZpi1ScCjt/ftAUVp62A1mlu9++9CUmYNioTfH0s4At+RLqNViiv27Y1rHTSqFx7s/dO1n3Ihn8XJSB97+dgt/4+XodjU51UfxQGSMmjoz+XBrOgqIUyPZduG55opA0bLZ8ycmbA0n6OIX2EVPi/Ub66WlG7JiaC2kjhmhJ006dryf+nAQO+sqF0AYioh93WRLo5LUuJg6cdPQmnZ3vX2yFhogAHz5TcO8mOJ8eZVUNczI8h7+35r6zMn/x0wy50WFZdNXilgIsaV4h3n1V9pU+t1nfQNYC+64KCYgv6t/BiH4kf+HtZD5mG3T6lSBCRbU+L23M5VyKogSctSIgkl/PkDrTDA55pZ2foeZELAn1AGuhQLG/LqvFq0Z+vUe6p6iQZdZTltVatMcQLYJttIFj3V22MxFzh9fbWwsRMJ8XqOSihJdbyI7K6mXJQrF3oApzUq9+/rTmZXPLXBWrU16uFCdSI39zIyjgk3oGshKOnvL1J27wR185I+GlqII7lvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3333da1-8a76-4f69-a386-08dc418ce9f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:34:25.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK04QNxCHX+lqGbVB15nc7EN6i2T+ipKwgGXEUrVRCdQPQe9hDbcfjyG2PL6t/oUHqqQzfhahc2TlSanqo7qxAb7vtGU6LuUSppcmGtlJC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110041
X-Proofpoint-GUID: sEl3VxF8Gdu7zwG9NlHEGmITg_VdfSi1
X-Proofpoint-ORIG-GUID: sEl3VxF8Gdu7zwG9NlHEGmITg_VdfSi1


Juri Lelli <juri.lelli@redhat.com> writes:

> On 07/03/24 19:49, Ankur Arora wrote:
>> Joel Fernandes <joel@joelfernandes.org> writes:
>
> ...
>
>> > Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
>> > he seems to be suggesting preempting instantly for higher scheduling CLASSES
>> > even for preempt=none mode, without having to wait till the next
>> > scheduling-clock interrupt.
>>
>> Yes, that's what I was suggesting.
>>
>> > Not sure if that makes sense to me, I was asking not
>> > to treat "higher class" any differently than "higher priority" for preempt=none.
>>
>> Ah. Understood.
>>
>> > And if SCHED_DEADLINE has a problem with that, then it already happens so with
>> > CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
>> > more than the treatment given to higher priority within same class. Ankur/Juri?
>>
>> No. I think that behaviour might be worse for PREEMPT_AUTO.
>>
>> PREEMPT_NONE=y (or PREEMPT_VOLUNTARY=y for that matter) don't
>> quite have a policy around when preemption happens. Preemption
>> might happen quickly, might happen slowly based on when the next
>> preemption point is found.
>>
>> The PREEMPT_AUTO, preempt=none policy in this series will always
>> cause preemption to be at user exit or the next tick. Seems like
>> it would be worse for higher scheduling classes more often.
>>
>> But, I wonder what Juri thinks about this.
>
> As I was saying in my last comment in the other discussion, I'm honestly
> not sure, mostly because I'm currently fail to see what type of users
> would choose preempt=none and have tasks scheduled with SCHED_DEADLINE
> (please suggest example usecases, as I'm pretty sure I'm missing
> something :). With that said, if the purpose of preempt=none is to have
> a model which is super conservative wrt preemptions, having to wait one
> tick to possibly schedule a DEADLINE task still seems kind of broken for
> DEADLINE, but at least is predictably broken (guess one needs to account
> for that somehow when coming up with parameters :).

True :). Let me do some performance comparisons between (preempt=none +
the leftmost logic) and whatever is left off in the preempt=voluntary
patch.

Thanks

--
ankur

