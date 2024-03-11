Return-Path: <linux-kernel+bounces-99544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352948789CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5B1C20DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2454FA1;
	Mon, 11 Mar 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KpNxQ2YI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zL6ZigrK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79356B81
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191094; cv=fail; b=qV6REtVpCEt6ZvuFJwweTqqRgQnkrcK22F0gmbRviujeP1quVK8LEtSPjW7FeO9CQTQWkROZ7NkHd0XV1vBIW2OB9DYeambDaBjvqT0jhQXLUkAzxJfO6Ct/eWSu1xC9lrWA8yyG7WrtCphqWzKTAXkMCJtRgxUfGAsQuVVRnxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191094; c=relaxed/simple;
	bh=uZiYmoz9b1I7+Qh5YTdhDOClqKzPyISlrRCvq5koNh8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=P3tm7ToVwbLZA7dGWiPB422jdlvVP27vbT4EGub8yWzUpYNka6In54nWsZ8PQTGhv7EyaxfbyemimwXpTFzJfnzpRBRQZhW8uMu+2F3amA6dAja9CssGnr/DGJX7zlEv++9H4rKLxYSK1Y4Bp7F5+BEQBDfffzkarKlBYq3h7Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KpNxQ2YI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zL6ZigrK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BIYaPc008790;
	Mon, 11 Mar 2024 21:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2m06xQ6aqiV9wgu7kt1/RBqIzQU/U1MRtreVc+iAs0g=;
 b=KpNxQ2YIj4o2HZgGf62JHysAlOzJvsCGwHH5GUZ9ks3HjNdIYgp/1eu5Ib0mS6mQGAU1
 kLLrsSsBB9gm3790Lt/qP+IhyUUky/ptWMA85FFtF0j3b+ApMIQtp875mMiI/sPPnfpg
 qBbnuBc1vp3DaDUN94EaL9kCLacxo3Pl/Y8Yx/RhQ/t/b6n1pf4JrmLTWl8FOv6zASyA
 Ha2hvkZvOBL+0hUQiHPmPAXF4uKDoKqV3qzeflQCCfwcBwsoHeKzOSjTLQpa1ojT6lcY
 j7G3tlgfeT4og8RWKvyjpzJF8I7cwwOR3e4l93adm7Wq1AtBmK2L7EzGibJrQwMqUeRL UA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbm752-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:03:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BJSKpZ028567;
	Mon, 11 Mar 2024 21:03:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre76ac62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2Y+bnyMa0m3v2XX4W/EeHn01XAPtej3BldJD7zX2Qd9oYckD/84Kez4kPocymvZrSxi3kXu4kR88RqRqPnnWgaXZ2x9Hsj2CdMUEViV/tfVVYtSx+2xUxHZWfq8N42iv8zoLFH8nWaSGMpvTC+9ifRG7Gr/npgCpYcwYncspk7dV5mqj6Q3cXExFShCBoROMG3ENM0o6K8Z++AvPsVSj72GDfLvgNl4NxDAOOcnMn0BuXK2ZVvGyBFbg3yK9XUqvEGFdTKCJ5xhNwkNmpT07VLh//RWwSsP8JsUatCTDlE1AdbrecQ5UGu8cD8ZvywEPdxCs2YUsmAAD2jCJkorWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m06xQ6aqiV9wgu7kt1/RBqIzQU/U1MRtreVc+iAs0g=;
 b=U2uYF3oITCudH6X1O61Yi/8AfOQIhfqV5Aws4u70HNG9wbVFXVgv9OyktQNKsCByo/l3R/dLY0LzPXWMl8NbHEuuXGryGLvp1DBBpfCSoU/XZN9Lo5vRLMxMZzsP4W0eVyNp609qj99BrMKBL5+m/H3YPLzR2MCSKryto4oeypWDnn3i1wxUUrGLlBOgVgBj60O7/pGvDuuGMJQSYzmfbAS8Yn5fx8bImpU8KH9bYxwhINF4yKV68ObviDhs/fKQCu4xJVBVToV4FFzdZKCtC28FD7n9z/t3lh8zW2HTlhVIofmbLF6Z+VmG/4cyhpRjKCj5/y51WqhTkc6dZhl1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m06xQ6aqiV9wgu7kt1/RBqIzQU/U1MRtreVc+iAs0g=;
 b=zL6ZigrKp76nxIFHBYfcDvP2+hWumdqM7m3WsKlv1R3eMV2OEJKh2ZrN65dr0Y+x2plmb0fC1YKcouxwie6YkkzEJPSrgZbE+/KoxzP263Ebyc5B9+y0TYqWwkXTsVE+fgu8zYy2c+IofgufaumJxK8yIOcRSWbJ9BfDqJX4rSc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:03:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:03:24 +0000
References: <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
 <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
 <87cys0il7x.fsf@oracle.com>
 <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, paulmck@kernel.org,
        Joel
 Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, akpm@linux-foundation.org,
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
Date: Mon, 11 Mar 2024 14:03:56 -0700
Message-ID: <87zfv4fpkz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e4374f-1c5e-4b36-161e-08dc420eb093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UkzpUAlnxoq1tmUkeeyHKKr8igE3Q0dpevtxL0gqvGAKE566nclWxPf2IvG/foosmZgR9owi2nSNjyLx4+EKZTnjN6lqV89MBSHN9rG3Xhtfub2VsomMLTY6fyMHAQdRwFUNXVrHyPbKIY7EQsPlj53rHeCEM/oEcbqTMjZuDrNbPZNMQqRjv3TqmoZJDu2SjG0jUIFQYI+kZdEO/LH7wifAs8FBQJ3HQPTlU626ffd3ef5tWOv2gB1f1icSEdmnTuv8bZ8KwzwaXzyaHUxtXPZ2dp5f90F+0euLnfmDuB9mZRCfGIvZPGjieieMvXNkJ+l3Cq7GXImv00RjQBi2zoemlP6z629qnQHIgUVF0pK1jB6bRy7TmSUvWqBRL9W4A9nbO8JdcjRKP6ca0wekPmnx97qlyhTQ/XAAP/Ao4qe6tiOCPCdgGQIECy/HzJbI3GLSZSbL0YhZlCEJK/cjvVimQxBd2YGHBSAFB8qRhenTEmriVFZyX5zsGawWCR5VrIA7bKLzRmETjOlje5XhK6bJxmi0RZGtRQCVQ2twTjP6QAJlgP5EeZuirqplElkbCMIbVGg7O8XhpqgAKYCUO/pOGnpyJb15tyzzPEodz5myq1xocmd5R+EYGgUCkTj8Zzqk5yOQAhWepKCBlChF+FoyJAz+ZRjnCSwRHtCGdW4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/gaxaDi/zqob+1pCbammIRkRxat0VZhgujaH4yGhRlU9TTBVMvHJrC3ugdgd?=
 =?us-ascii?Q?HFhM/gBEzAq9rhmCWC1JhgDrWiKBpkQK5/7mRPRGpVPAQbD/pFR0FW1RIUNI?=
 =?us-ascii?Q?EZwVvy+NVo6FCJ7TeRgjovQ5nL2zcLkSNy+a2fUG2S41ck6Oqx49v2n0LtVb?=
 =?us-ascii?Q?9UXhAtCFBYRCm2NaoCR14ascrt32dO2aVHtCuvbqkaLKULFytz9t6dujEiTu?=
 =?us-ascii?Q?WFJXSwhTOXZpnd8j/gQEI95nSaMi+SDVkdiSKZqNsIUPqsLU8HYozgqOdcAy?=
 =?us-ascii?Q?jATSx63mEdlxNoj/InGNKHJXe2DuVNNbpOI4zwQi1T/0KlVJJrHttR/pKhRv?=
 =?us-ascii?Q?ek4XIP0eSzduofRNgu41QNehOcMXnCEdc1KRkAm7oFbnN8r2O6Qo28Vc5h6z?=
 =?us-ascii?Q?NwLkl55hw8njFuaZM7VsstBOBWYRQ3pCNPfMVMU0tKYColUQyArMq48bQlIv?=
 =?us-ascii?Q?d8xkQpVXdHqa+tPq79SveaB9olBZumNPDYN1gSZRpBxNPa19lj3tEXP6VNbG?=
 =?us-ascii?Q?wIrewCqJaownOqmiz6z87NRFAiIi9+lkH9uQajQ2GuSmMx1KAoJPzCCc5trd?=
 =?us-ascii?Q?+zz35AJ6HCs0aveW5PGg83m72VVG3R1GACv78zhKtQMwFB+moFSKSZ2JL8U9?=
 =?us-ascii?Q?Kfp+nwgBwukRl+9QSD3qbI9i5rfftANhU83hae/pAEW0++y8BUi0Oen587lK?=
 =?us-ascii?Q?Yxcf4o8FrTSNvIf1pt3TbO6HNN170UfDmQ6wmRS8WhBNeqsc3VigNfg5zPLK?=
 =?us-ascii?Q?tlrXPqvKqHVvCmpxQzy9if+7ukuTdlMQO1DcJrxkPm4W8xs7ZzohqlMQPPNk?=
 =?us-ascii?Q?1TDk78xkgBSdMFV9B96vykXlLuYYrwIHSyNMNmtA9VBG59/09QjFd2ASH/re?=
 =?us-ascii?Q?ZEcsZQ3K/Nu0fKt5j4F8Ir+yHpl2ZjiktmgzeugyH9VQ4aVh6JAdFpWSA8cl?=
 =?us-ascii?Q?v8tolSkpMp3F/Nbq9AObYQfOY09nFj2TLF1putThDsYWuAGP1MmDy2VtMUcs?=
 =?us-ascii?Q?rFAoGLn5NXSFA2eT9no5eMQldrQawBo8UPEMvSlUmWPKGlzWCLJsWtrBuam5?=
 =?us-ascii?Q?CYoVWdoSUfrSb3wRXcrCKGVxT0DxJ8C/YevE3aWY22BeKjLvuGS2lOHi89Vh?=
 =?us-ascii?Q?lq/e0Hc5zozI0LNRNN3CryaD08jmPmcp/+qR+4Qz7rQw0k6RERrHQlIP8vpN?=
 =?us-ascii?Q?5z8Ct9STNN8yePI+8dNbl/ALlhOAjtzW2DRehGrKdYvW0nflRWfQ/obYnUgr?=
 =?us-ascii?Q?veZ87g5YtY2dZKgmqLmJgsDgzejGYkjZjWV5Ad+dB0Y7mRz/nmJXpGUsLz86?=
 =?us-ascii?Q?//D6XEcV2wGJPxOic4eiiQPh7Cp3uGnuwTjijjBLtcc2HV4q6XflaCjWvVNE?=
 =?us-ascii?Q?KTQrbD6RDXRMtxcB+gTksxotc9cKFZouRUYaVb4nVBChB0kurAvhy+C+tFak?=
 =?us-ascii?Q?a5yaHlFRPqhlgrYpSBNJKIzgCJcgdeXyq5IC9AzgLRd3yim7bQkQzBikK1XQ?=
 =?us-ascii?Q?uoO/5WpvnDBSapa8wWT2Nl6NT21Gh62aCr0jatGoEC4Yc5BZauA37c963CEP?=
 =?us-ascii?Q?+ndTz3irU1kbP/2CfQT7200BXk2WMvJnazjMf6naft7+EP5WaFalSUCIqnHC?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OLui/NpWXCggn/JHn8fG0GbbY3kor0ufsuZnx8ldVzjcPPr7P6rSjCRj/NOJ9ESJ8hZPO5ARCPndnwvfssML/rN74cOFFtdabimvZLzYDjBm89XLtt6AANmwHNwQRNsmMeYRa5up9tXr1CfgiM6LZgM3+23VgYRJJPnyhRpspUu0XfziN6v+OiimK+BnWhqAWd5fVa4bEaJUFQaNNioR+i8N5DAO36KvI86tnaNH2vsoYIb3ovJpZU2XsO/eGOQVS7b6gRbltNn3PlYXn7gzciiHV4tNErXWRjvAlw3HfJ9uGk2SNq8XoVakfoyr4Qi3UJeLKPhHWGyHabXHGFYLEUKRue2QJKPgLIcySGs2hptPQfR09/2JnikpNMVfJMpbfJQQJEW3kVECAv8c1DYXd0JbWhK7lnBcdCF+Bp/NMaHaYyewceVfcg8DpGTCkOx/Mh7fD6Fm/iLk/FRKCHflgLfBnDQS5JrriL1BRkNIKfqUuSRxEJlSa2o2dr1Rtq96bB1wuLSrBFQaJrXZH4SICAUsAHeRCEjlkMsk/lQzlcRYScoVAcN8QkrgzpsnXwdUF5YW2t1G6VrLl3Fsop3eC1NA6FP9Loymo0gUe6FJGC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e4374f-1c5e-4b36-161e-08dc420eb093
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:03:24.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hy4mGRZ0XHPjMUshJ3+yFEAeedldyaDm+8A/aHuw9/eSdWNj8M3vyTK62Kv0DrpcVPPxmLH0ycXUlFXlkUksb1J7wyo3PmXeeQxtavYMQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110162
X-Proofpoint-GUID: EuEwiT0IkhRybIRdPpBsOix85LWt4HQF
X-Proofpoint-ORIG-GUID: EuEwiT0IkhRybIRdPpBsOix85LWt4HQF


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 11 Mar 2024 at 13:10, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> Ah, I see your point. Basically, keep the lazy semantics but -- in
>> addition -- also provide the ability to dynamically toggle
>> cond_resched(), might_reshed() as a feature to help move this along
>> further.
>
> Please, let's not make up any random hypotheticals.
>
> Honestly, if we ever hit the hypothetical scenario that Paul outlined, let's
>
>  (a) deal with it THEN, when we actually know what the situation is
>
>  (b) learn and document what it is that actually causes the odd behavior
>
> IOW, instead of assuming that some "cond_resched()" case would even be
> the right thing to do, maybe there are other issues going on?  Let's
> not paper over them by keeping some hack around - and *if* some
> cond_resched() model is actually the right model in some individual
> place, let's make it the rule that *when* we hit that case, we
> document it.
>
> And we should absolutely not have some hypothetical case keep us from
> just doing the right thing and getting rid of the existing
> cond_resched().
>
> Because any potential future case is *not* going to be the same
> cond_resched() that the current case is anyway. It is going to have
> some very different cause.

Ack that. And, thanks that makes sense to me.

--
ankur

