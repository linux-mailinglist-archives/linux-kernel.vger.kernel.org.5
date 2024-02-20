Return-Path: <linux-kernel+bounces-73749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0085CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833EA1C2151A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3519152DF9;
	Tue, 20 Feb 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ypk+YcTB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H7u/Wk1i"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A941AAC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467084; cv=fail; b=QHqNVChLEOVu0BkdxfFM56yZdn8Gu+e5XdSWcV2DdsY8DVr6H0gWNe/S68Sc/JtiDW/ZWzuKNLeJtxiHIeqXolGsEf5GXL7VyBqHkYW0FRqSJQP1Syt7xPm3OpNeIKHDtm9DEA5DFAkZSe3/QOI4Jsn7LQTo0rF4iMYBh0IbHd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467084; c=relaxed/simple;
	bh=NUqx/uPS5GJ86nGeGX0yYXYWbzpXxPxl+LKdE9r7wqk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ir1z9QR/nW2F2wms+V18X2C8S5BF3w3mQ6am7wGnnwNT3bvKP+IbRGQLgKlnNcPvPN8kFvAEwp/jFnvD/kJgjLHT1m6QETHHVSeroNnbWWImsdKuayhF/waqTsGOmbDvbo+n2DvI0YXzdP4YGT3cePjIFHdwio5Chu5UfRiWL18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ypk+YcTB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H7u/Wk1i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KM7h9r012464;
	Tue, 20 Feb 2024 22:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=OYygl8Y8WbHZeJEElqeQMImH4PUkxpVu/hO/mvS6Bl8=;
 b=Ypk+YcTBxuvFUBHyi4mn+N1CfvbLQ3XTWDWQ/YeYphlX7YOH3qSKoVRa3ZnCPY3Sgqj5
 UXjXv9Z9AEhMawa5j/UFNnm8XGgE2CM3fZ3EXhowfBR33oYJ88tqVrh7uCvGNkTR6lH6
 tlP7t/YY6AeEUtmITla8D+iJjLXL2nEL+VoBenEAxT0DG5A36V+uyA80Z2RF5uZk/G/u
 VHsYGWWSTHCp/AFhJYziqmPuFf2D9IjxfFivdh8HT5lYH08MYdcH8LnJNITbOCXu+E4E
 RE/N/KEY517KtuLj28Mmuk/gnmzDeRVGWp4RYh5osBha2WrKBJUv3LwZesXlNhbQAWs0 iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knr04j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:09:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLHmeE013034;
	Tue, 20 Feb 2024 22:09:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8807t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/px1LODroVxmaEEOuAC6qmXMDJBNhuhzrww3AONwgSTDGJ0HzeKetS3XvzWyx/W6G1TTp3csQxZ86AGQ5ItW2rQ7Tb9o4qVDBCZEFRKsV5xuAlqNc8e99ZJoOieu10BVwIKAfsqcxr7/nPcIv+C097ZDi/iBBoiChYdLo58SnaWHuet22oTUd/y05Gm0pQLgwCj6WEg5OC/pFHoT31WRBD2XvBmFdiIYpOskOw2xhhx/cvvMi8uIq/dBntZdxd02+3emWakALOg7NLcF+C++b6DRfI+ZLwpZbURzNSXEtluxQR3E9jatF5cF/CSFM6fCrFBDB6vcYlCEkwBenNk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYygl8Y8WbHZeJEElqeQMImH4PUkxpVu/hO/mvS6Bl8=;
 b=ITDYAThpmZv5EGJ3ysv8TYXsZPQw/yKwej5/I6zHdIolpDol2SRJFypcXyKbPKYL/t3UE1CcAXssVFmO2K6oRs7E3De4GBD3ZcP5cdfuQ3ipsZLXapdtOSgcJH1iJ2NTiiYcYdRd2eJPjS5owh0jb3Ic8Tstpeq4LadtU38XwyLB/iKKCN7B0TPYwhWVDEx4+BsWUXqz8/cFOaUQ0GTg3hghnvK6N7LyNiBrOYRN7dBBMrugsO4/1nvnSexhsPxGaXIRVj72xtCntPueW17nY4PuGr1wfrtqA8Mh8ceQtin3wktXSvkJIMD7wq6kVLazKxCf/WBF+fSoA9fDjX1wSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYygl8Y8WbHZeJEElqeQMImH4PUkxpVu/hO/mvS6Bl8=;
 b=H7u/Wk1iKCdQHsuVhdlw0sm8BWpPXHN34P3HvEr5XjcwhccjQRepJhySQ/riBSctog1JGet7LBUhHbEIOGjSax26HqRu7P9oTpl4OUcwmmJdogmewAvlcUPvTxXS07v5iuX2zbvEKwPcvPHeNXTow2hGC2ZRNjjdhN0aC+iM6xo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7496.namprd10.prod.outlook.com (2603:10b6:610:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Tue, 20 Feb
 2024 22:09:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:09:16 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N> <87il2qmksh.fsf@oracle.com>
 <ZdNJ5x1XmRZwa0Zp@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Arnd Bergmann
 <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
In-reply-to: <ZdNJ5x1XmRZwa0Zp@FVFF77S0Q05N>
Date: Tue, 20 Feb 2024 14:09:38 -0800
Message-ID: <87le7ekct9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 43273527-9df3-42ff-d0cc-08dc32609443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	huusQBzp3l2bMDDtmMpJeYv1ZejcgLoFKaKTEww08GeORKVB3kdTO0SKqlKskeOm2rYVRDJCt9jvMj9x4YR+iFa8s9TVTkW1nqcuLpK7a5dW8BwfUUNmnFL4YhhSDiX6iGp0dgzTHB212QdUHJLxtS6V9NZsaCYu4GqR345fCYdZYPKI/7wRpAOLJfstpx84rLx6n+fkCpDNItV1IbKfd4Xc4gDs2FACRj7Bv25P0fCAqd4YpDcrO80HxEPANFwElLtcGVmt8izBT+RkWPmBdU8CrHU1Z9mi8Lm4T+F4aBEPFfa2bUlV7SxXCwAA3i34TerYnUWF+X0sJSFXA61bG62NAtKr3sAV7TIhQLmxcL1yGS3i3VZ0HbK1pF64IK62TKENxdDT3s9olC5hF62Kf9UYRO34lQ/UPe1j8Y+upFfZ4Pa95WT2FZa/fxrXuJcwZW3eO4RwXrgfEmm756Aknlr896GOCilA1QHv/LJuZyB2G6agw3I3f7SfAA8qYs9xjA4GGGSNL1zYkwGEREMwKy8DbNf7dmegnhfmj/NODjo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gCsEry4mwOlSl6945GqaaAE7hB/axJ4zylWRUo4TxpUm6iMdSLD9kN5UNsAe?=
 =?us-ascii?Q?L7vkU7ibaiVBbpCrRLaN34qF2AM2yJRtO5xm48pkltYea8cJakrk27sKFzrI?=
 =?us-ascii?Q?WeDTtp5dvngVqiSh07aQ0RQpB8Rus0AZN9bQ7bA1Av12YH9YHYsmvSSZxAIX?=
 =?us-ascii?Q?piXVt1j78/+mjmqnACC3LYzxzWMx+nAUoFb9Ii98C4t3j9BovT8uBMx4TFns?=
 =?us-ascii?Q?XqQgBcpgUe+ItHoPVDBJLeosdTqMBZMMozqPRlA4wjwGcWqLoJGrsk3PNMz9?=
 =?us-ascii?Q?ZpuNuUiKITc2vZhRos1SJCp1O9gVQCFKuJhoxg33Q11iOol2+dG2RgMDNeBV?=
 =?us-ascii?Q?QuA7ZTW5i3rxu+snWyOGDw01RKhSwCukR1fV2Ld/z65q3beg5cHrBqwdULo+?=
 =?us-ascii?Q?JeNsSqKx3+SepCvKrT1EKX6cupbWaZ4Bmq13/W0Qdo3lVtTIqeQz2c4RTlOF?=
 =?us-ascii?Q?pGowC6ih6deeCxW6UzMWvgWqgDP1UZ+JcLi83zXx5O1Z3JEWA8rY1DhNQNe+?=
 =?us-ascii?Q?Cd664F5gb5ieiKC1GBjauhxT96je4wC/lNIWSCKueg0nsMqtgrXdVpax8oM0?=
 =?us-ascii?Q?97xNJ4/g1b0LNdFUJOPkc/5VIOgpN569suYN4bnLrrvFwXrfEP0de+cD/PQv?=
 =?us-ascii?Q?kN6dU08vupfCVd8sudnaI3xuZiNH6a+Xj4JfBRdqrp6MjVeKihiwy0EoG1J9?=
 =?us-ascii?Q?/7sLRK6+eEK4M0cp+DLf1c25o+zKW2vTaMBK7lVLkV4S75tk4qw3RBiyTZCs?=
 =?us-ascii?Q?cEVR/u2xFKuDw7BhcRYWO6zmW36/AOPurKemIYp1basxaVOd7YaQsWw8mOKj?=
 =?us-ascii?Q?veuJDm9J5BjHcAMK5giHbEj2QveL1dVSj6xNJ2Ab6jLAYIEw/KdpKJ7nvRJg?=
 =?us-ascii?Q?rPnW4yzOJpDviw1lTaCtms3XeyLOzCIpuBaMum0k3vc12vYzOlmCYxQmrGEG?=
 =?us-ascii?Q?WxK8HNyNgLLz9VSiSJ23IcOvTv8exYQ/gDBYSEuTWbdFKo94TjcQcGc9HLoT?=
 =?us-ascii?Q?22Kr75LOrSMRBH1tx6WmTYjXi+hjsjO/h0oYfxIzc6K7Oqj1oBxj1z9mo+LD?=
 =?us-ascii?Q?MFRhzAOYgR5lfteDcYDFIWKntdHemv7/bB7cPZeYqPeo5YBv3+6x4OOfQwDk?=
 =?us-ascii?Q?gLtkP5bOLQsAxXrqK1LX123pH7islIxFQLN1IDREMmCbH4YPNpL9OMtBN08c?=
 =?us-ascii?Q?XhOVI9BAZAu2Z55zOZHAHRc7rZBv1tNxPSqQKXnrH6rsVlJpRBHDYpz4KDnS?=
 =?us-ascii?Q?I2rR0wtv7T8lenxziFWERVCz58mIpZ9BdsRlPPEplSj5IYzRs5CFEc9qS3OL?=
 =?us-ascii?Q?lTYYReqoxAb7eXhqNj21qDDAv7x0p/0ETJSEAJAgg8/GyoinkVyIfxfG90ni?=
 =?us-ascii?Q?ztyuQ8MfW2lvsjuEKSx8UNmT1oRIX40QrT3hYMnUaFyANp60O63xmDRmZHmg?=
 =?us-ascii?Q?4Ehi/VXuOe+gb7qvCJbI0AxjQarIwDaVE4X5OHL3vNqEnSjAALIjKfjs24wF?=
 =?us-ascii?Q?L8NwTI5GVqr93OGlGaK/B3V7SpFF0GXL3/XHhFls8nF9P9Kz3D60+obCiCip?=
 =?us-ascii?Q?07X6gkijQHxy8ABdWYvHuuvujc4KYB2I4Wo7hpZDJaSIHryqM///P/+yoBDm?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lM5c3CCfIoDydYiIt18kj6p+cnVbafkPDmWOg+nssl1/DxRPOiYFbDSBOQlzy/Te2nVioyJVNTN75eEooRi7Y5j2cqvf6zWC9q2r4okamlSxm9NO/QeQk8Onl0mo1ODKvR9p8tN3/Gvujntrn2ivHyeHHWM7KbFkzzICX8I2cSKgXwwgeGMm9u98xRw7z1ZvwXCp7hQMKxm0BjdiZFs9VYqg+lswUzBgxA8VjT+MoxPuIqkE7PqSXXA1mJBJ8UpY9PS1os2ar3pNO9WFd0QcJUYEYgS6vlIDTVt0w2L2WuHULR+H3lWt7xJ0Z4j3/x2e9rfLRVdOzHw1kSTzHOKAedue3SE7jTWwai6046n2knnWLCnS9XdarLz8CWqtVvOEepXhxxnrMVaSkKTGW7zGWug6C2DdsLO0nXsOfTvOqPdM++kNMIpYHtX2ltMd3M4yeYITxXhzfnIYMMbnuafqQLC+wkVfXwqQYEqIjcbOEpj/u1ExckBcTuA8nQhdMmIxvJY3euuNyvbSa/Fvy4ja9NUfMZN+Z1Y5dJ3msuX+wbW4BLk8ONF+Q9eCYuDICQsvXKmFuw/FpiNAHs1REPW4hyKyVfcLT8fSib32KefkY4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43273527-9df3-42ff-d0cc-08dc32609443
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:09:16.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21UgBDINuoG1+EUDxbsEknJr7zAliAnt45CD0LtGR8apEpgkNzotRX1bPqWv7zEvWelcViG522oRUFqio7DwrO91yXCtje8GqnRiwqxwTjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200159
X-Proofpoint-ORIG-GUID: a2zOBGkiGKCnMIRO3PDa0O22GQr78vKu
X-Proofpoint-GUID: a2zOBGkiGKCnMIRO3PDa0O22GQr78vKu


Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Feb 14, 2024 at 08:08:30PM -0800, Ankur Arora wrote:
>>
>> Mark Rutland <mark.rutland@arm.com> writes:
>>
>> > On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
>> >> tif_need_resched() now takes a resched_t parameter to decide the
>> >> immediacy of the need-resched.
>> >
>> > I see at the end of the series, most callers pass a constant:
>> >
>> > [mark@lakrids:~/src/linux]% git grep -w tif_need_resched
>> > arch/s390/include/asm/preempt.h:        return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
>> > arch/s390/include/asm/preempt.h:                        tif_need_resched(NR_now));
>> > include/asm-generic/preempt.h:  return !--*preempt_count_ptr() && tif_need_resched(NR_now);
>> > include/asm-generic/preempt.h:                  tif_need_resched(NR_now));
>> > include/linux/preempt.h:        if (tif_need_resched(NR_now)) \
>> > include/linux/sched.h:  return unlikely(tif_need_resched(NR_now));
>> > include/linux/sched.h:          unlikely(tif_need_resched(NR_lazy));
>> > include/linux/thread_info.h:static __always_inline bool tif_need_resched(resched_t rs)
>> > include/linux/thread_info.h:     * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
>> > kernel/entry/common.c:          if (tif_need_resched(NR_now))
>> > kernel/sched/debug.c:   nr = tif_need_resched(NR_now) ? "need_resched" : "need_resched_lazy";
>> > kernel/trace/trace.c:   if (tif_need_resched(NR_now))
>> > kernel/trace/trace.c:   if (tif_need_resched(NR_lazy))
>> >
>> > I think it'd be clearer if we had tif_need_resched_now() and
>> > tif_need_resched_lazy() wrappers rather than taking a parameter. I think that
>> > if we did similar elsewhere (e.g. {set,test}_tsk_need_resched_{now,lazy}()),
>> > it'd be a bit cleaner overall, since we can special-case the lazy behaviour
>> > more easily/clearly.
>>
>> So, we have three need-resched interfaces:
>>
>> 1. need_resched(), need_resched_lazy()
>>  These are used all over non-core (and idle) code, and I don't
>>  see a case where the user would find it useful to dynamically
>>  choose one or the other.
>>  So, here two separate interfaces, need_resched()/need_resched_lazy()
>>  make sense.
>>
>> 2. tif_need_resched()
>>  This is mostly used from preempt.h or scheduler adjacent code to drive
>>  preemption and at least in current uses, the resched_t param is a
>>  compile time constant.
>>
>>  I think the scheduler might find it useful in some cases to parametrize
>>  it (ex. maybe the scheduler knows how long which bit has been set for
>>  over long and wants to pass that on to resched_latency_warn().)
>>
>>  But that's a contrived example. I think this one would be fine
>>  either way. Will try it out and see which (tif_need_resched(rs),
>>  or tif_need_resched_now()/tif_need_resched_lazy()) seems cleaner.
>>
>> 3. *_tsk_need_resched()
>>  This is is used almost entirely from the scheduler and RCU.
>>
>>  One place where I found the ability to parametrize quite useful
>>  was __resched_curr(). So this I would like to keep.
>>
>> All of that said, and I wonder if we need these new interfaces at all.
>> Most of the code only uses the NR_now interface. Only the scheduler and
>> the entry code need to distinguish between lazy and eager.
>> (Plus, this way lazy and eager becomes an implementation detail which
>> doesn't need to be known outside the scheduler. Which is also kind of
>> the point of PREEMPT_AUTO.)
>>
>> Say something like the patch below (and similar for tif_need_resched(),
>> need_resched() etc.)
>>
>> What do you think?
>>
>> Ankur
>>
>> ---------
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 58e6ea7572a0..b836b238b117 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1953,7 +1953,7 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>>   * tif_resched(NR_now). Add a check in the helpers below to ensure
>>   * we don't touch the tif_reshed(NR_now) bit unnecessarily.
>>   */
>> -static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>> +static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>>  {
>>  	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>>  		set_tsk_thread_flag(tsk, tif_resched(rs));
>> @@ -1964,6 +1964,11 @@ static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>>  		BUG();
>>  }
>>
>> +static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>> +{
>> +	__set_tsk_need_resched(tsk, NR_now);
>> +}
>
> I assume for this (and test_tsk_need_resched() below), you mean to drop the
> resched_t argument, i.e. this should be:
>
> 	static inline void set_tsk_need_resched(struct task_struct *tsk)
> 	{
> 		__set_tsk_need_resched(tsk, NR_now);
> 	}
>
> Assuming so, this looks good to me!

Yup. Great.

--
ankur

