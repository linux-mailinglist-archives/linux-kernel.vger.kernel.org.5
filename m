Return-Path: <linux-kernel+bounces-158062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C097C8B1AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F226283A11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8F44C6E;
	Thu, 25 Apr 2024 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HwUnayk2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gdPQSolI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26D249F9;
	Thu, 25 Apr 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026031; cv=fail; b=UowpAcMS8rQVfOgp9p/fkBOrWPL5iQYx2NtUHRnNwGQOhR73k1tFz2Wl/ucaoxXxA916z757NdIe06f9+UfjfW/7SxAl9vFJkaMombMyVnU2VsMrHWwire74O5qGKo1GmrWQgBqTSG/nwjcvVJTSYJFPd8Fs/RkKZRxQbZRqEZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026031; c=relaxed/simple;
	bh=o1RQnsDrYkUJNRcoHeDK2QhPCVLIYvmsskjD7A6lQ9I=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eiYz77sNzAph/tNVZylJ726C6Pxg1ErIfNYn/PjKRwzprJZBavLEkisiUTZq63NeD7XyyuZJQDE2bpQQ47vSxCB917N7qPsLzGQ6Fw6IGz92qVLLrAe+nl1TwID5ImNx0lGblKo8i5SvdQhdTALxqFIJgVpZhtCo8g8nh8zUJeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HwUnayk2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gdPQSolI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0jU7K032458;
	Thu, 25 Apr 2024 06:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GJFudWC33OcmI54kH8YRbisVwqwdklTHlCliYLX8tjQ=;
 b=HwUnayk2JUHoax+FoQeX8wlEpEHcP26HKF3uU7ZtEZTZ5ytPFjN18q4ivvSh+WLajqYe
 sdFOznavmnJOtka9DZUvmQfEKFnsDk49XT3sLZQjARHtDDQYpEaLjF3Ux3O3+doMjoHz
 0KlMLjGwCBiQ0+th37Hepp7JbI7aBPrWhLgpoJbOfwsyjvFqyA4wahiYeTK5mY9Rdf81
 ZkGHzzLl2f4Dttkc3D0yunMk4Ad3gvBnQWM6EvPJKRo4wuVgz918o3RZiDHGBWNliKor
 2PM6WhmYUqlMMJpbN0dQAIriFTcEOvsyWI9NOqSSB1VqCA2srXOf7ot7swGdmS6jqWqf iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbtb8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 06:19:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P51A1f025274;
	Thu, 25 Apr 2024 06:19:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45g730d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 06:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0a/0OisjzUkfhYNSBmVcZY/CsVXEdTYu0lJMi3+vDjK0Ytm5qG2w0wEBK1EzM5HYXCk8oHvH/aTdonaf7ig1Y2HFlpxZ2yVcmDMayZ3qH3ZKND9MsQPhTGwqkbaA6ZlD62t/2X/iGnExEIHplwFjsa4L2Ep1U9MNC/qfGwe9LGx5bxlvcCqfqzQQUnZK3r9DLsbObfUoKSxPI2juvtZskvs4tO8oddvfszFnczezTqQW78zwp97o1ZUp5ef2Ku6NNihXlpMK02HotFt/24h+oj7AVvyH/JXYqC+3m+O9aNVclhQJ1UyB+Z0PW7aixjnGaCpCZdODIHf3FMPwDY2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJFudWC33OcmI54kH8YRbisVwqwdklTHlCliYLX8tjQ=;
 b=IE47nA4RyOsBXNU9nfcqD4VwrH/9C7oGNbcqgLW2AkbtbO5C5oRN6KlbNGsThAJxyyn/GZULQafjp9+12uamLBsRMD9zMUTbQ1FEe4+Deg3Fuonflo7sVkx0BTi9/0GrHx66UGOGluhfy1J4PBYPXumeBAduY5nGnLj+oRL+2yN9pxvFMiICNpVRSbOntoZ23MzCOyzWkYO+emIxnwlp/UImjmZEyYYPhBxjkd59OCIxeFlKUmPRfgADD4VaMAahsT9uky2jJ5ZG0fe3L2tZZ+L/vJJqjNM/fL+EEOmI5kuEF93MYYxKL8XVDZjy36wZ8S10rIRKiMPo9R5w+qnN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJFudWC33OcmI54kH8YRbisVwqwdklTHlCliYLX8tjQ=;
 b=gdPQSolIPX2WkQuAepSRx0jJ6V7JrNo4PjVGqcjRaSxxmUkhN6FuNGWsc3FfAineiQd64k9DjaYOnNYzvhVb7/XIgItkbwWUg+XoRGcA4y9W5ZpWKqrZAmfhlsyEGOp+UV2OsY2/K75SlpMYgNyKaQ095xeKhBe0laFKEwDn83M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:19:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 06:19:37 +0000
References: <20240312193911.1796717-1-seanjc@google.com>
 <20240312193911.1796717-2-seanjc@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon
 <will@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentin Schneider
 <valentin.schneider@arm.com>,
        Marco Elver <elver@google.com>,
        Frederic
 Weisbecker <frederic@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Friedrich Weber <f.weber@proxmox.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] sched/core: Move preempt_model_*() helpers from
 sched.h to preempt.h
In-reply-to: <20240312193911.1796717-2-seanjc@google.com>
Date: Wed, 24 Apr 2024 23:19:35 -0700
Message-ID: <878r12dkw8.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d4501f-ae70-41bd-92e4-08dc64efaea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c96YP6MzGuOq3sixrfSWVzIuGt4/zS5XeooCTRatC3nwXqT4tjJej2/kp7kP?=
 =?us-ascii?Q?KCOZSy8ZiDQdzsAL/bsem7/45UZPVjddGYpUE2FA8y8o4hAluPXRWa9ugHcb?=
 =?us-ascii?Q?C3qRFp9bqaYbYMuSr2BYN3bURqVrUOqlYSg0OloFZ87uckY6KBSrz1Ba05KI?=
 =?us-ascii?Q?7vBq2k8qfUpO0BwUdd9jVCE06qJ1psdJf38+dzFsW005XWGg89X/a0P3kelU?=
 =?us-ascii?Q?RTPEdXJ2DX7EWEGKK97rq0XRLQ7opGeIhHmSUYsxAKhJGhxLqzQyiU36hR/D?=
 =?us-ascii?Q?bE0jIiQFZHKiWqQ7OdyPnPzDtxHKrSMl10dmjDcUtl9mliTzC8XFXejmpsLg?=
 =?us-ascii?Q?CAPXI6T8Fr5u9a8QGrKTcnDHWSCoOycdV3VwFD4CK3P7n5S7WxFOEnDjPZbj?=
 =?us-ascii?Q?UWRSTNFLRRPMiVEws5Q0C+xWR5b7/jH5S91GXx/eNCEKUPPNOkj0oKL0sy8w?=
 =?us-ascii?Q?LKYapCAstVsouzwY1hN5UjLI5g0MczoabMJ/InmAcPmjz0ujWwSb+lgebdfy?=
 =?us-ascii?Q?HSo53nd/2YJx6PUNOLk4/I/qkr2tRQTVHXU70fhUTytNWW+RjK3MQFZYilAe?=
 =?us-ascii?Q?wjF0Vd8r6F3y9FJUW+TiV6VRVi3ZntaK9EI4YugxyziBvdor0aKLYczTftOB?=
 =?us-ascii?Q?B0+qeUIfL/hjzJPUcFsHBGCzBjbOpRCQTC6Ujlnd8HCHB7Enadmmv/N2v+K5?=
 =?us-ascii?Q?eIeSfWvqd226EEVwerfsbnNfCo+bOfLL+LE6m9Iy5m5O45tzII0ies60PqhB?=
 =?us-ascii?Q?qNJ66F8VTAxsm1DvabiAwojU0oaMaaWX4zQUtFZSlioaHE1yWM+NbFDsg+Ff?=
 =?us-ascii?Q?+MRkQet0OynPHtGJm+zsKXgDWLJ4QGHhR/wkmj8x58+wH0ftzx4V74c39r3y?=
 =?us-ascii?Q?dmCIf2nijYezKvUhVLN9mXfzOw5qNafD0L5a5mCHtP/MQmvV61CQcmASIuRB?=
 =?us-ascii?Q?uFwh/Mnj4Fwe/EAABSq7Q3w8OB9TEd26P1UmomGUh9pTN+hD1dDp0ZT4ywZk?=
 =?us-ascii?Q?TZ9aG76uv/l/iLki1ihg4rb4eP48OXT4UaHnI+Q4M/JMFVxW4tCxNTbgdaFQ?=
 =?us-ascii?Q?WYI/Df4pAtnbf4Bg5rpTxgo215J0NZPpG1xMeBGlLfc3HXOIH18ogiZhGzxE?=
 =?us-ascii?Q?KvJU/Qxpy3NvfZ9/LO/WTPA51HbtMHfYSTeJfK2q2pTAu0DxIqnzvzI7c1fm?=
 =?us-ascii?Q?W2sn/7D5FAxyTRizeJoHOAPbv2FmP/MWhZICqwGz9YzxrOiyMtPxJNsy56EU?=
 =?us-ascii?Q?s93eSBPxQOoRX1v9CGbk/V3+crPKXi8dE81nWG8xkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gxWxQqkqj/bUQ6A6iCoWHIiYrerx/G1AoM8sZF7iPWcFsbHSQRRSVAnqAHTv?=
 =?us-ascii?Q?F8MW6cG9qRCfw0y5jspRTpWWg1N5+RhRG1+VHp97398MIi3UaW3bWGt47xpi?=
 =?us-ascii?Q?GQA9IYhLmnSAWJpgMSuA5lKWjNH+fXKHpvN5Bd8Xe4xYMB5A/ZBfeCGh7IHc?=
 =?us-ascii?Q?16dB9W30qv78nh5KbtFGr+pg5B+kdbXVZVl8HAiaSJ3et0vJcx6IkDSw3+us?=
 =?us-ascii?Q?VMl4EJUnolmRNSIty0bNjtX0BQavu5dn3HuZgtdXalGZVAA1PGA3ds8LLLKa?=
 =?us-ascii?Q?3DGS+yZWcvfNZAlQIsDKgXUtDVE+vCqcf9u9OvyqQwateaUonBZ9USOzZv3J?=
 =?us-ascii?Q?xJZxNFeeeBDxbFoDCtJn1QaajbWp8vBYKmVhYjocJp8kFaXFNxHRrGprScUb?=
 =?us-ascii?Q?bm26dsd0qPt7Q0yxfJNHnrbzlatlk4vaXjiplvmP67n5Pl7Y30C4iYLpJXug?=
 =?us-ascii?Q?dDi94dSmPq86SLjIfRzlQTJbkjyIe03ifxTN8nIguGYUB9/cl5mKwt0iZPip?=
 =?us-ascii?Q?PFeqmq6of+ap6DecHcD1qqABSCvMmESIXmyh5b7kdZly8KvXKFkpqed56w5E?=
 =?us-ascii?Q?UqWVOuP5bRb47pXYEOc9dzPc/fbl0hJsSRiPvmyPyzIMcguixMDDIGrGaGt6?=
 =?us-ascii?Q?pf9p/KcYQ1sXpVSU6oXJp6yDMYXnB4Tzx/3U+SyjIQEuR/KNSU8fRa71QDJB?=
 =?us-ascii?Q?ZpL7z0I69hXYVLgdG7D+eklp8Lq5gemVLPFSNlqvt6UpwRH3QeDmKS/KtJ8O?=
 =?us-ascii?Q?hKqinE7X0Npn8KRAQ/pK10MnIrqlCGEFJwkQRPVnyX3fu5pvj6mpKAPMYsPD?=
 =?us-ascii?Q?eB3Pb7EoZi8etzJ8PFDaEC2lAo7/acqJOIlr7zmU3Do0wth1ENJcmZAxApJl?=
 =?us-ascii?Q?ifpUsrVKssbgBQxQ5FRB8SQHEHVVy7Cp3u51zTn0Qdk9tI3ogwOuryvXA6WN?=
 =?us-ascii?Q?hbkVR3qDRIw0A/t8K/jYAJeJvv0Hi3IeWwkpdkWpJH9wS2DSsbSrqD31gisA?=
 =?us-ascii?Q?tEtEGRa+E2KOLFKaQ3KDuy5HLVirNyRFKnw7enOusuv6u17DVBe2TVRKggQW?=
 =?us-ascii?Q?k0wnWLPHSKe/XG728Qw0uXyqPKOnA0DwSPHxlVIGVng4xtFpGHdW/iJs+TWQ?=
 =?us-ascii?Q?wwGL7qstNy/7kVZO/ezCII4ZCF3kY0p/EvDwujocj2YqKP1FU+1QNpvqT+nV?=
 =?us-ascii?Q?k49IkUHAvrIgyt2A6MbUN2aLIeRXBWBzIeyhNmeLnPdRG4HxmDQgjPWBkDH0?=
 =?us-ascii?Q?Q/sPWc9iDwkbh32X+O/ub1MltJNHy1YfdmJYjD1kaeUPVgRsQZw17v4SS0g1?=
 =?us-ascii?Q?BZ91lpSac9Z/BnA/ADetHcLF9faKk1wJZKwYze/UK2gJDCTV3TZDvM5NXZal?=
 =?us-ascii?Q?O3HOl95Ojd4RE2pBQnvXMJ+xzHsN878l/Vn77+LowQt3tTOb973DNm09YWAj?=
 =?us-ascii?Q?ktEzSQhrz4JgtVhHwrdabgS8uDmHihVRGICouZkWrflYvX3gNYAz5qM8c8bF?=
 =?us-ascii?Q?2G8ZLtumUCoTGzwswzljuTsGx+b4bmRQ7+dLhcCykcWZOIiG8ysMs87Dv0yJ?=
 =?us-ascii?Q?IgFN2XZMvjXkj31lm38tNUeGYsJUFG6DWih3kMxRc2HnW892C5lZMH4pPy2p?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RvLTTYenvj7JiHekaMJ52SISfT1Woy9SLunpTOhNK7rS5j7qFhmhkqvHx20iuzHF2fhAPX680K7Qxjp1OPFlZzoAqM5z+l3u+WDjMsGSgF1ltwutLMtUuJ84//HdOfp0yqShv2hcev71+pPY0SaGHnUND2XurZ6VlTF/w9LJ+f4WvM/zCU8Xpsb4jyGsF/5VwOQomWUJnkIb3144AMEBMN+ONn2tAyhQQZ56ErWhcmUQx+qiWe36yoRf5HJubOMIO9Pajc/JP0DL5fmhZovx3H5zyR5jL5OMH9i+bfHAADFvjwtMeUYsnejeJF/zfTiKQ/LCTiZdSMBYHsO8I5GYUWV5Z9pV3Z3gYppKXBnrd6sj91QmzLMS0+Gm9iSgYKXogGENoNX8w2SLRQKQjXLoTYW9jJHBDPVIK22jg8tS5eM/9aRhqgLSfQT506rIgJCmzNRbQbwPI32N8xtVeBFQMR7DIwSSOSVc75jMDSnJgKEumpipQrJl7nhAeMU0vo8Zz6SigGnGmMnyGzHaO8V+SCJOExBICUxYJ5T6C0lhL3VsgI+/Tgy1SakVNn+tXOA6/8Rk7j94sCHAjIFFrdj+fyInLRPkRgmxkKw1ddaS1Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d4501f-ae70-41bd-92e4-08dc64efaea2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:19:37.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzOTlBcYbJOTP3P+z0YX/UODuQZOfkz6kNU93hyTJAsYOAebHmLSMty6dFLH6vcrzA01K6VlMvqTqODZ8U/xZ2nHL2kEz3LER4XhctEpDQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250043
X-Proofpoint-GUID: R_Qk99QU7LlycdN8KcwZEyAhKgzG0d1s
X-Proofpoint-ORIG-GUID: R_Qk99QU7LlycdN8KcwZEyAhKgzG0d1s


Sean Christopherson <seanjc@google.com> writes:

> Move the declarations and inlined implementations of the preempt_model_*()
> helpers to preempt.h so that they can be referenced in spinlock.h without
> creating a potential circular dependency between spinlock.h and sched.h.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>

Ankur

> ---
>  include/linux/preempt.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/sched.h   | 41 -----------------------------------------
>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 7233e9cf1bab..ce76f1a45722 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -481,4 +481,45 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
>  DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +
> +extern bool preempt_model_none(void);
> +extern bool preempt_model_voluntary(void);
> +extern bool preempt_model_full(void);
> +
> +#else
> +
> +static inline bool preempt_model_none(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_NONE);
> +}
> +static inline bool preempt_model_voluntary(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
> +}
> +static inline bool preempt_model_full(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT);
> +}
> +
> +#endif
> +
> +static inline bool preempt_model_rt(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +
> +/*
> + * Does the preemption model allow non-cooperative preemption?
> + *
> + * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
> + * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
> + * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
> + * PREEMPT_NONE model.
> + */
> +static inline bool preempt_model_preemptible(void)
> +{
> +	return preempt_model_full() || preempt_model_rt();
> +}
> +
>  #endif /* __LINUX_PREEMPT_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 17cb0761ff65..e9dc10f7a463 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2058,47 +2058,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
>  	__cond_resched_rwlock_write(lock);					\
>  })
>
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -
> -extern bool preempt_model_none(void);
> -extern bool preempt_model_voluntary(void);
> -extern bool preempt_model_full(void);
> -
> -#else
> -
> -static inline bool preempt_model_none(void)
> -{
> -	return IS_ENABLED(CONFIG_PREEMPT_NONE);
> -}
> -static inline bool preempt_model_voluntary(void)
> -{
> -	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
> -}
> -static inline bool preempt_model_full(void)
> -{
> -	return IS_ENABLED(CONFIG_PREEMPT);
> -}
> -
> -#endif
> -
> -static inline bool preempt_model_rt(void)
> -{
> -	return IS_ENABLED(CONFIG_PREEMPT_RT);
> -}
> -
> -/*
> - * Does the preemption model allow non-cooperative preemption?
> - *
> - * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
> - * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
> - * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
> - * PREEMPT_NONE model.
> - */
> -static inline bool preempt_model_preemptible(void)
> -{
> -	return preempt_model_full() || preempt_model_rt();
> -}
> -
>  static __always_inline bool need_resched(void)
>  {
>  	return unlikely(tif_need_resched());

