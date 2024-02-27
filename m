Return-Path: <linux-kernel+bounces-83764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E231D869E37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E51F1C232D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C34EB32;
	Tue, 27 Feb 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9zg7mgZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vGCWQ95Z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713C4EB21
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056014; cv=fail; b=GTlJYO2Q6qk9qgdVSO5zsEzP9DS0UiLsAy/htzVE6NxaQAOZcZ79G9Nzx8ao1QW9ZDBA+U33YE6cn7YuM2K8Hy7tC1H87KiLwdFAqvbXk608ZWbIjW2xJMCCXwp9b+QUsi0jtACK7NAZwY0Y4aNTsAaidIhsxLzVfAJjxj1utE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056014; c=relaxed/simple;
	bh=j+A8RcpJGdP8GkxgGwrSFrEUr7EFhqhlKnF29htF/Pk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=FYAbmwZaBfzCjhn5INTRTYxU3Ue/6Flrdr17CS2PmbarlmxjIFdP1wyuz/WCh5nsDNQIDxCI5sEk3PHKVEAxufsnkzuzqZb5/k/gxrSPm4WwktuKAvYxCTwaFWTN7WA0jHovF1BzcwsWf1biJulMjkfLJAbDYxIni8rOnNjOdtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h9zg7mgZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vGCWQ95Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RFYjMf010732;
	Tue, 27 Feb 2024 17:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=A1T4IOtUUwVoJwin7pZ6lUP2xOWeOtWdbgPOOGy11IY=;
 b=h9zg7mgZIv5V6jyX4KBguHYSq18luM47reVyIpxlSgfjtwrbIINA1EA+G7Dfqly6bL7Z
 KcHhoYTOT0suzbfUa4ruXQVfoB3xPpQAuzYPjqB4C73vhldHW7yphAb2u+TzgFqNdc+h
 1kE2gCfkFl6lUT+mhbbUBUKD/h1SvF5uUa+QRkgR7d0SsB2ebz/yHzuhIlNLWtdCecPY
 q31dsas0zNnGO6uGStejoxS1EygrjQ0hG2ZEgy1mVgs6KAE9lR2q2Pzv6/zV7T2fJ3R+
 FTIHUF9eWWL1+8YqlHRvy26HBciyp/xdaZz7gMPTOz87q3Vb3wtJUAYOVhe+5dhAkhZg Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722fyqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 17:45:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RHYgHR015291;
	Tue, 27 Feb 2024 17:45:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w7t7sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 17:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIq5GBiTCUz7XuTV3xPL2XCEQ2N8liBwEBsMfta4v9YcZ5Uwkzj1vrVO8C+CR3aQ+pvkr0Isr7XBkcZ/FsJbmdjfAtsJLm5MvfectQO860gIIpvNTlmM4C6OqaXoivA9CTDwrW3mtGivZOw8w/VvDLxAGjA1gXqCg+yuUmSiLXYODvbp8AJIcENln6Aqo+c5PpV87E00Hsb4w0CQLyKgiPxdIUMMvpsdlbiQ9bmSLv6yqaRFPFwX5xPsxWX6ItIqJTjY6/ZKaArBhdDcevj6bvEUhcTQg4YWDTVS00GoHj0H4wbmEMUZTdGxRcxVejVKnAsGtZgTJdTc8TPCLqp4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1T4IOtUUwVoJwin7pZ6lUP2xOWeOtWdbgPOOGy11IY=;
 b=bVLwgMSJ5qCBDYHhG/7Zs6ZnhCZCsbC1XJQlTYhcFlqWq6EkhtLfFfgew3mCKOHZ1JTLppK3aEFnIsY21jLUhlGupMO7Zmqvu2+8gOzYXJOSyp5e9t6Wk282fH3mLElxyCXVZ0bVD/AKTMfaTjJJ+IzinnEfdh84+ERSUtgrrhoYPcinfA4z1Q7BZ6fWKBw6aVelVAmNZfwQU9a3WN1LxZkkMwuE7iIeNWES0ppc5zU6EdLo8gnPZnCmNfoFjQ4HK2rSYjQXwmCwkGoIERtDfPikEqwjusvxrkKHE0aS6HbbYtTPzAzy6RaD+Hi/EdbvHlo1Szky6uxJYak+4GHZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1T4IOtUUwVoJwin7pZ6lUP2xOWeOtWdbgPOOGy11IY=;
 b=vGCWQ95Z6QDI8gxut4I50N3BhFVH82NN9tA0lqvJCYTJH/Kv5XO85RJB5JivbHx3D7PjCtCfMPfGC+GCHxSH8ZZqXmW2anJ8oA3i/tfWAa5Wm8VTWLqmCcytoPDVliQ7FqIA4vmoPULrdNOKhg/iHVgAc02GWK6MVmZ4kgz+pUA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 17:45:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:45:18 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com> <87ttm0dwhk.ffs@tglx>
 <87bk87c1n7.fsf@oracle.com> <f32b90fe-2d56-4e9e-8f44-c7ee662af43d@amd.com>
 <cd56eb4e-520e-4ab2-a041-0a580cb42e1e@amd.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
        jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <cd56eb4e-520e-4ab2-a041-0a580cb42e1e@amd.com>
Date: Tue, 27 Feb 2024 09:45:42 -0800
Message-ID: <87h6ht94xl.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a0ec36-10a9-4f77-cf64-08dc37bbdcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F1CNsC112Lze3ZVASJJV6jbKeOSt3CXsCKUBZSElu9ToLhxooK3vC4AJ+62qtwup0YQMrz4pOhMvr8VvNJYEuYyHvLxCxkLwdvLSxs76cv2tYvobeDOBkataP5WSjIwKxRd6FRfAejmIkCUWXtScR8WuE6dm4aPet0TvbZEJQTEJOT4InAIGBQL9LqvHib4f+RX5cZN4mbUfzrHlB5pKzTMQoAuOu9rDqO6CAg1bD6KwyKIwCx5WyXBAz/e3T5cyM3tFf1iftL6hx+qaJAUoA2ld/QO2MmA+PRhkHHgEfS9nziFeS7WpqgCDLioj7IiXbaNhyGRpW8yIHJNDB4wei3gM0zOMTFodGSZnyM4631s0O9XxaJ1oNbXwR1LHJc7nnBu7uwrTotraHsKg9Z1SjonKLkvsL/0v8PrulgDtCNiUjcE5uUkajmVT9OhYqDg5wZRoZWscf2rK/Uvoe5zDgl/16JZ+YI3E56ucEvGd+gYE6rIpTsqVbwDFEyNEMIm/aDcU/uZ8hsvelaHgPKBlbpGaf1wtCCQgjx3WwkoUMgk+qETYnsm6hNqF9CRMJ2bV2y+hgeIJCsbp+VVKy3StTYD27a3e+nASPllwlBNc1qHs5IDIoOHF3CXAikxt7QE5qLXvucphhEBjfFfSAeQEAg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kKIZWWSTRObFYdW6aZwbUI9PCez/4pkXX/rUkxPeoqXSv+I6FpuiK98J9vUn?=
 =?us-ascii?Q?c9ZJmv5Ch8zPYkvBm3+E+Eqt1w/qIL1FtUDnj6zWRFAOKM9UELw/IelHIZMz?=
 =?us-ascii?Q?kknSUDHRtsmwUfdMPPQcZpAtKmKmbTgDl5R8OQfsLc0cNdVgPfMDI3E9B/Db?=
 =?us-ascii?Q?tDmFEzj8I9514c3o6aoXKD30tmyxh9hHHFwMoo7CCCaXaQkKkHa6rB6Oiwva?=
 =?us-ascii?Q?LI2ptfSWNk9pSxjwDnALfHfbF/hMyjM25p83G9MTpqsK7Kn0msucbWne5X0P?=
 =?us-ascii?Q?C2lTqcUw9L0mKDz19gC0DTEAIubqq13b4UCd4LFjcXjxkDLSd12XLjxXfzdL?=
 =?us-ascii?Q?ngpMDGnWuXB3FBs3F9Gk9F3hmQIvicdAzPN4Ua9RDJIB/DZnGv487vPMtmbZ?=
 =?us-ascii?Q?G+sZE6q0biG4RItq+pkodJ2dH0A+768V097Rn8sTWd4A2MmVvEmjLYybpinS?=
 =?us-ascii?Q?3oAxD4xvosE/YeuXBBDMVG3qL4rkhoOg1qRTZvssReg8sTdxYRTLoNFkfE/Z?=
 =?us-ascii?Q?iRRFpfO0r3uxJKJ/E7Y4etQFHxgIRLV107SysAg2xIzGCy7/iPLtiZE7PxSy?=
 =?us-ascii?Q?gVOBKbvdaeZrLJjG7wv//Nz6nZqiiizWZf88Hy7ClYOMOQddKxB2fvWOGNlb?=
 =?us-ascii?Q?ziIqjUS50HRz7mRnl9r1leY9Ns+F6Sxlp4yBghweRM1RfqJQY76NwoWXlQzT?=
 =?us-ascii?Q?allozLRO6M2Ke5/8gNGrVSuACYLaqGbLYqCq2L3QLVrQLYzm8AXk4b6aabgB?=
 =?us-ascii?Q?ocWEaRm4EdRzZEj4nYfguucCo4+u1AL+b1gddgaDPJ456zZtWXlXXRxYBFZ9?=
 =?us-ascii?Q?xRoV9L9h3yApTPpuZooz1egwuo/eHi64IzLCQ41/LwPL1rkAOPcbbqf3uQYu?=
 =?us-ascii?Q?xrWURmNEMfgd0MwJs0Qo53Dr7OTL3KjJnWmZy5sCue90zaowrvhw007Bs/rL?=
 =?us-ascii?Q?eTKS37X3NfwY9ZCJEFiNwHuatmlxv8mYwJdcEhSGkxw5TnIyb+1TWumAeTac?=
 =?us-ascii?Q?fTwYl4Aw7iiE8XT76635JraiEY1LUXXQfzPXZt4JMElo3gfU9x9niH1K5HMu?=
 =?us-ascii?Q?XWpOBGzEIgxmwtkqVJUQtUbVRHAPq9X7j6v5GDiLwTvp/NqI2jTCrSToO3r4?=
 =?us-ascii?Q?ZvgpTHsK3ZAJ1NvUhq9XzdvtJa1b9jIG0fFBgFG2AqGme98WvpLZ+su+AwWX?=
 =?us-ascii?Q?8YI54au04P8vymJJgPXyA7jV+cSvi8WEVnhVxJTbWktlVpVMnBiS70qEAVUW?=
 =?us-ascii?Q?vuWQErS3IjCstHms0rHsHXjORC5K0Wy/QFOTNdw0/BMmpEWk4xqF9HMNRzEP?=
 =?us-ascii?Q?veou+0dUahVqMelNuOt5wes+v/M/C6UpJA8XOPFEzhpZ0Qs7vmiqbYmJiNwV?=
 =?us-ascii?Q?YnHuZDlQM67ikncSCExYyVtPGGF8XQn1fTwhDwWzNnpAnIhVhjetiJWy2Wbo?=
 =?us-ascii?Q?LQaBkyk307titLPPUkZCO4/PNJYbbdzZHS9llodf1QkWCPEeNAxdCfQ4TT/O?=
 =?us-ascii?Q?yhBeQIuoyiJMaLL34imrmUmWuKfsPUzjvdVlz0pmKPyYRVkgQ/W/WNmTsEJg?=
 =?us-ascii?Q?sx7/Kl7So4KoK3KRnBNUbRyKWqscC+JJH3JP1Vm0Mg1p8oPa4zdVbqa+UM0n?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nOE32Lv+uvGjF4/QsrGEIsKe6KzD0KBPXTmi/ydPMRNTNKgl6C7Oy8+CC9FHIJSU1/XEpY9hThrfclLtVvNjvdV4eNwYXFQSIXzQfy+zB1oHIYTDWO8atKfBwDPCrIz60G/E66BgWq86xrXfd2NG/o1FlFJO6bkf5IofWf2htp2NKhbsYYVsjhLLT9igHRmqim0asUogC2v0UFX4S0WYM+Nt/lhKFrLZsVM2f9T6MieYwLXBoQrTGOlUuI1CD3cWcDLeSqY3g5b6gSIZkCruM5yaae4CgSAIFSV2agBEgzBiXgaQCzwIg+nK3yZIvGTU8/4nOkVoBhTbv2io+3qj2nm74fqnnIPx/eYVLZ6anrb89NheFAMVWJ6W2LkDD4wbjRp7VNMvdJHohYNwStj36PTXSU3qBoGSSCHOEkeeqC6upLlzrD8K0sqLSRkokPUxOOL4QtTpYV+TxpK3omqRolClpN8QnTAJI9fdDpg6bPiviDemfdJ9uicbWSrcPa7vWXG2EmRiNgmwqiTJD5bQQh08b2FWqsUIXiSWagpXXobK6Dstm6jGCr/y+8X2anKIM5q8eqisrmMv9t6Hi++63b9p/yi24Gs+R8qQ/XXlDoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a0ec36-10a9-4f77-cf64-08dc37bbdcf8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:45:18.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VXHMBgU03M72qoI7pQPgV2QeiPe+V3CP3u3IP5sDoET7ZWCfeu74e8zjPqXWiHeljxsINbk9nhRkfExCbhwruXRFflFqy+u2D+CCYplASE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270137
X-Proofpoint-ORIG-GUID: 4cEfYNBeGj1F2CH-LpO491M5kkwAceCy
X-Proofpoint-GUID: 4cEfYNBeGj1F2CH-LpO491M5kkwAceCy


Raghavendra K T <raghavendra.kt@amd.com> writes:

> On 2/23/2024 11:58 AM, Raghavendra K T wrote:
>> On 2/23/2024 8:44 AM, Ankur Arora wrote:
>>>
>>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>
>>>> On Wed, Feb 21 2024 at 22:57, Raghavendra K T wrote:
>>>>> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>>>>>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>>>>>> Configuration tested.
>>>>>>> a) Base kernel (6.7),
>>>>>>
>>>>>> Which scheduling model is the baseline using?
>>>>>>
>>>>>
>>>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>>>>
>>>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>>>
>>>> Which RCU variant do you have enabled with a, b, c ?
>>>>
>>>> I.e. PREEMPT_RCU=?
>>>
>>> Raghu please confirm this, but if the defaults were chosen
>>> then we should have:
>>>
>>>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>> PREEMPT_RCU=y
>>>
>>>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>
>>> If this was built with PREEMPT_VOLUNTARY then, PREEMPT_RCU=n.
>>> If with CONFIG_PREEMPT, PREEMPT_RCU=y.
>>>
>>> Might be worth rerunning the tests with the other combination
>>> as well (still with voluntary preemption).
>>>
>>>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>> PREEMPT_RCU=y
>> Hello Thomas, Ankur,
>> Yes, Ankur's understanding is right, defaults were chosen all the time so
>> for
>> a) base 6.7.0+ + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y
>> b) patched + PREEMPT_AUTO voluntary preemption. PREEMPT_RCU = n
>> c) patched + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y
>
>> I will check with other combination (CONFIG_PREEMPT/PREEMPT_RCU) for (b)
>> and comeback if I see anything interesting.
>>
>
> I see that
>
> d) patched + PREEMPT_AUTO=y voluntary preemption CONFIG_PREEMPT, PREEMPT_RCU = y
>
> All the results at 80% confidence
> 		case (d)
> HashJoin         0%
> Graph500         0%
> XSBench          +1.2%
> NAS-ft           +2.1%
>
> In general averages are better for all the benchmarks but at 99%
> confidence there seem to be no difference.
>
> Overall looks on par or better for case (d)

Thanks for running all of these Raghu. The numbers look pretty good
(better than I expected honestly).

--
ankur

