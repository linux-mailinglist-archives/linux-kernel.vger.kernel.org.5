Return-Path: <linux-kernel+bounces-158059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074778B1ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8731C20EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA83DBBF;
	Thu, 25 Apr 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdOVBGX8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KnX+VFwy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61927473;
	Thu, 25 Apr 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025930; cv=fail; b=tyjS3PN/tSQjmrm8rYiUWeNTeH5cFJ8BSrXmxBNZNSdfNAlq/98bArdaO4+oaxNtzoG9JJqDF4G4kPEUJ6LmAod6yf1DUOw5i1t+kS3T9MniPUWV03a55l7kX4lHCOa8rdsC1d0JQGuzZYFNf7BRKFjUr/y4ap0sby98V6Tz/DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025930; c=relaxed/simple;
	bh=BwWTspRjJiwqsGHKbzpGYElHOi6aZUgra9pUvGjdhmo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=OAsjmf/Y/YiozYDxTWTjIllfK+LVm+qNbZ/+gnjKGTsX8F/hcwlj3hC0PkLBNnxohiedHoy+L/FEAMSomuIQ7AZZ8Jsz2a0WkCdaVdC2eKrtF9taQVNAYiKDonBbnCskMHiCqnt90oU4EwhygUhAU7ocyDt58CrlK6tEdJ3AVFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KdOVBGX8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KnX+VFwy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0ilKv015826;
	Thu, 25 Apr 2024 06:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Kw/2lqUZ9LMyGDdE3IukIMaGlMyFXnI8xufzDIG8Obg=;
 b=KdOVBGX8rX8I62+pz6/eSHdV5utfNOcwZSbxz1XSp8yFgRXhob46xOvmVvDYmpfOuAx4
 kEExyQKVI6vzRJ5IskwuBsYIZIPDmXRC/GHEyZcFNlfn2U54vwPC2O2JpcXTgc3qyhYU
 l3oxdYKXd0TeTUme1LXxMr9emM159TkcBTCIaCta6x+uiu04/lPIDj1yYChumE4b3kKk
 vPBKKPAm1JBNCozdkQMn6SXipXMpfAU7zPsOR0H8wfJdqD1pArbnyiDJjpX0QzzXY74H
 9XogjOoD5ajk0gnauw9yA+xVIckvhWF31JMT3Pm4fhqEztQKKnwWvSp3ImREjWFrshCK /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f1n5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 06:18:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P6E4QQ019811;
	Thu, 25 Apr 2024 06:18:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5wgw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 06:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXSvgPshbyBmjHqve92cHIghrK6nxOu08dqJh9SiUlq5WL5ds7trjPZhvl+vAtqZ/Y0iX7elsh2Zu75WhTSmLubVa0v91kdw1F0n+D6nWzFf7wSwIQ2ER2Ot7B547Z3sPZxHHLL3CYr5aWg4H1nQmq76YU/hG2vixc/f+s4cPcHr5nyAO1XqOXCQGuvkT2kbbOskFRajUUdTY27mdPoxLQ1vSPxtb5tjdQeTlvEwKgF9vJsTDhWrNrEpEv+6M5n+NCabjQwe+62VtNeu/GuihIaufEcgdgdbueL6Kax/yoREvHliItpuvaf7cQUI8ciMf4F+Ia8ecW9wGklr9yHCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw/2lqUZ9LMyGDdE3IukIMaGlMyFXnI8xufzDIG8Obg=;
 b=bxtQKl7RD/12vIq7TN3hbzm+n+lr2PkurNZUSrXWIm+Ml0wi9MqelI9Ky9H9TMtQpOSz8ungKzufR/P0ANd4XxVUfKGXbGIP3Fd6mWcyjEiNbTNvcroWwdN+f6Ch4d15h3B+vHms/fKEY3OZKsEwcJj3WBSzL05GaBZ/EWReYw8CsNaSwz92XwirwuWJwTqUkPehzH83d/oH+Hfm1AdGAuWrs7bFxl9ZtUmJLkeHXdfZLIVkbyPWNVYYaeiwjiHFSMeTZRyx1x96+iU6SrVUqbCKmV2A/YVRhPiLNvM7jjzU+SVF3K8ptbjHSkH6ieTRBym8l6Rc7LT2pBIbcO9AWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw/2lqUZ9LMyGDdE3IukIMaGlMyFXnI8xufzDIG8Obg=;
 b=KnX+VFwyGAX8HChMfMB9vKv0cmYw9pXbENaXDuhe0LHkXpgK77vD/UJCjEyuKSqS+UWDWEUhEUAqp0LYbhaXF0eBAqwcAxdUhGJ8fS24uNKCOVfXVsyd+VrvDT3hlzPtB5hfQmJsKWc7z+Hr+cwQzhfH4ATYysjHo7TouNvDRAE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:18:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 06:18:04 +0000
References: <20240312193911.1796717-1-seanjc@google.com>
 <20240312193911.1796717-3-seanjc@google.com>
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
Subject: Re: [PATCH v2 2/2] sched/core: Drop spinlocks on contention iff
 kernel is preemptible
In-reply-to: <20240312193911.1796717-3-seanjc@google.com>
Date: Wed, 24 Apr 2024 23:18:02 -0700
Message-ID: <87cyqedkyt.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd5b295-8086-45a3-597f-08dc64ef7765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AtQ9GT/1sBttw0XvYAICvkabKdrcqjaz9tFDM+HB75oZG7dyM8xDPZ6OMN7b?=
 =?us-ascii?Q?y7OUQkctHXvOIKEUkfRshO1oPrYY+2Hd9kZ7xWpTQiME7rW9jKlqpZJV4URH?=
 =?us-ascii?Q?lxtB3NiE94S+TNU+X+VCgH3Pw/IfG/28k8R97H8BshKCEhekTtq4GawT5H3r?=
 =?us-ascii?Q?BHVSH2HJeSOh0YAkrVEjfWWEJ5rG2DHCixCNXISG6xAPJrDw2y+PA1q5IhCz?=
 =?us-ascii?Q?uzRKgn1NihLs8CuhFWstDj/yWnKgKrL1mi6Bb2wC/TMczMjRyyxIEmt8l6Qq?=
 =?us-ascii?Q?KQiEnII4a0nwoajSS794QMfOpR2aQ46KpFAYDLRD433A5qPjYeHuAntQ8W2R?=
 =?us-ascii?Q?LXqz3KZdAOYjhCZi7yTUaebti9H10LgYeODLSQYLWbpaRkZrVla3+mO85jfx?=
 =?us-ascii?Q?diwYEpLPirSiFXqxUA8ZOQhiNm1LqDEowvZYyKw1KOzBOlND58uq5yHO7Zw1?=
 =?us-ascii?Q?nH9yn5TGdrgX3W4eZx8kUlj+yKU1zVBlPFL2SsKW/Dru1cXNHr4daJAfw+oM?=
 =?us-ascii?Q?WEg5Sy+o0q+j7QocvjvhFiO+lTq6iI09LUNte4pkkFalhy69QFgSdIIwvMc5?=
 =?us-ascii?Q?CT63J4mPzOnUOgMB2LuP4Nvxu5rQlEg1JwtMluZK7Gg3QeovG7JJA1CW2dKy?=
 =?us-ascii?Q?XrubwhtKd4+3V0lx70y+rDUm95lONgcYFtoKw7mzq44QcZudOd7lgcvdZXG/?=
 =?us-ascii?Q?wXAxDlTWPKo+D2CchpRjSAtE+bFIVRMGQMjq1M+mrunNiI/QFbjh8MV00CTY?=
 =?us-ascii?Q?QWq3fxhUU83OzN0JdRrO9myOXzcRrQjH4zkPPKo4VkwkYqvXkqgI3oF3e2uH?=
 =?us-ascii?Q?OU6o7VsIwgNYcl5zk5OK/q7k2APEdHIkjmA7nlWxrqvjvrV1hUsfnY0b8WR5?=
 =?us-ascii?Q?zqI+YsdSz5HqEH+5+01X709WkeZwc7MC/ooaga6bSgsJkeotESbRCt/m9OkH?=
 =?us-ascii?Q?mMunQyNJ0F1hK5EhkVcd+TAIVgiwLKW5G7CqiUq3F5qSIKJJPLMGavuf4rVD?=
 =?us-ascii?Q?JYLsybpZuG7FvGCw6KLZa58HFAzn0v3qZDpkHCuolKTwxC1Rdbq3kzu0cWym?=
 =?us-ascii?Q?HMSmbgDfFNJfCgqK+0Ab9qZposZsoerGb4Rn5Gwuw9sEhvcAB0enJjzOFgZw?=
 =?us-ascii?Q?rmYVjE1hZl/ScZeHKjULXHuqsCS8d4yQbtUnpkVMknXCkiRk+i1Ez2K6lXZ1?=
 =?us-ascii?Q?Ji/BBl+y3o1hSh5ySNNjJvB7mKMQxVciayUZEpgxcHTxxHCS2XbvhykPyQJV?=
 =?us-ascii?Q?DfVRiV2WVcCkloar+ysKfJmbUYCqsVfofP1ymlp8vg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2EW5ll2Wtbc22IJd8jw5o+IeM1U5RLhTtZbelxMyf8M/ouB3yk9vRqfA4Nj0?=
 =?us-ascii?Q?zZZg5msJXJrUmR1JeStlneiv5iFomgjK/zW0HB7UkS8Mw8DBi53Swmf2k2jO?=
 =?us-ascii?Q?eZpOFPA1di5XVBi6ucCDIE3y+PgV7HeIm2KLxxvubsUiKgcehtSIWGZ3hDwl?=
 =?us-ascii?Q?OidPkVE05DQnuevIQfnAVsQrxcojgEp9zXV2sdvwnupfhuzUXHHijGkHdqNr?=
 =?us-ascii?Q?Hwl86JX76pW59ST6ZaIcX4MNlOjtQGsrOnkuxS6eLjAWOmtr4JLm6R4BOHWG?=
 =?us-ascii?Q?syPdoMXeo01+VMhyxlYujhmp0JT3yT2ELLa3g25buZPMghhYeH2zZHuE53Wa?=
 =?us-ascii?Q?0hgLA2UVdGmoop0oV/D+rzMqY9gippZJ5yEpmPDhu2myKXYaxSIWaiM4/R4z?=
 =?us-ascii?Q?dot6Wpm3+X31ZCxKzZ8qSYQm4GGWjgFN/Cr61n55s7QQmfqkpjcKOJw+KB88?=
 =?us-ascii?Q?iWmu/93uGQZOj9sObxYevx6zhNiO/tFn3vaFF5+19hMwD6/1I8SHmCNYYnxF?=
 =?us-ascii?Q?6G8tBKVW1gZxjFccopAbYVx2O5rQIx2hFIVPhwfYtjn7dk6mZuilehEkBYF0?=
 =?us-ascii?Q?35dG6ju8GmCT535CIDpau6lmI5XTY3siU8u+S7K79/LJCa574lsyimvGIKAu?=
 =?us-ascii?Q?PQ14iHG8DoBzoBqcS9KV23fb8xPBSkqYyYllcxbONmWPXkzesPXLiWEhl8wF?=
 =?us-ascii?Q?ZjWFRX7hf+N3y+XfefgEWd5XojiSCBxnKqODu1LQViLGvODx2u/PWN0NFbpL?=
 =?us-ascii?Q?sz9xqD6GqIFYsX3kVzhNfekPjpnX0GRzeJQtAwU+0R5Bd+caEOc0vC7xReY+?=
 =?us-ascii?Q?WNImmO/JP0Ft3Cn6UqAW9d0CIbbbGZYNe8Gh/LxXCoDGxsvXlJFDxe7QAQVp?=
 =?us-ascii?Q?aNMYpU66yXXMD1eQJz8rRriSg/Q7QgOA4YtQhiZFlpp9W3pCch94EA6CipAX?=
 =?us-ascii?Q?jbN7iV7y9J4Vh2m7lTj+vc6DCSaGhZmbbgKFMEkbr2FMVIE9hVBQSi8Bog07?=
 =?us-ascii?Q?mMpGtabYW/THXRYJtb8WfnmkiMFHN/+4+gez3k2aoo++0s5t5y9k0pU7F22W?=
 =?us-ascii?Q?+zSUSgoIcj25pJ97ocBTwhIHtwGaLP/VpYt+nIeOtWxh/9n5U0HOv3b7D3KR?=
 =?us-ascii?Q?xwb1KNyJ4JxbYtHcqLjM0n5rUFLq9RnToVfXfAkG//ryBTTieSQMCxazzuUa?=
 =?us-ascii?Q?JKUUw+5JSjyzwOtYXaWs29/iMfdeInhiVvys2aJlH72N57zgeJHKoCSHj5nH?=
 =?us-ascii?Q?T+812GCrrZrN94Kfd+W0A1/yfG4gkIoSFlc+wM5DkihIZVkO2OeFPOw4ORYW?=
 =?us-ascii?Q?1sX5OQ/qklnpfh8/G7IhLPwhM6m/8J2Va+rFRduKLaKajiG1X01hQACZP0gI?=
 =?us-ascii?Q?8f3fCJ3IZ3M78ELph0A84Kl/y8D5wQhGlJ+YoqB/a3R5Z2bFbkbwX8pEJ4iH?=
 =?us-ascii?Q?/kUA+5JObzO676rS/4uRML2Qi9GrQV1etXK9yfH5vPPQ/Sp0lc6jFe41OF/K?=
 =?us-ascii?Q?PGAZny6YfJIPyaYVRFMrfiAZzHo62iEtBUwBFuKLnIwjVHbw/RW9dMJHLCXM?=
 =?us-ascii?Q?JuohJS7dkQV5aP+S5fLMB0xjjLrTsH7zCCTwQ9VDhTBIhe5FrzjKokgMQiu8?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1RDGrtSvduh0W7FoPcXM68uKKXK+rVBgTJl6YNHFV+EJG8QwMcoh5Fvye92HjMkiVZz27C8yyfzuPVcqKcT31shA8L3hrm9LIjj5mQujmwq976g5AmHRuuZJ3CpS+t4Tai8CcY7W4ngOyyxNS2WC9F0iUnOPat3ImWb+rzX1g/pvgUJF6QbcBgeSkrmfYnDU4xF7v7mrBO5fC6Qk40Qoi4gZ4g+T+dERP+DLqBo89hzdMgzTyuW/B44Vo9a//4EdEm5FwgvVK+VPwqn7dMfS9qzPhF/ZHoCCm8MaEhtTZR6Wfxh5mg0T12qbYodEmscNzA4Nl+Gw9DwqYA3XjfHphlXEFjIxPL1j7sMdksOiUYJuiFGE1/A7aFnFTftwbK31aUyQOLN1KMtlAiHzzuu01az5HebMDcpZfMODYfX5vyLK1cNSkKATTYVmejMRt91AVH/6I/LbX5SA9TeIyCh16a2hYr7JyaAY6DA19CPzxa1CUs/D6Py2dJ3fgT0y9iV8sbz1sT1uI6R7kH5XfT9WxBAoQZmYzGPLmJw0Ks5G8LqKlKMLGCsvzQN2XnyKxAJy1T/+TmJQBmpAcdNyeyFF7Z2nICFVhIxG2ny/ukceVCI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd5b295-8086-45a3-597f-08dc64ef7765
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:18:04.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdOSUvNP5OFssj19zcOcdeGOVwg8SbemUjc+7caGE5SlqbyibL5yoyVS5CfcZcY/dOEN0l7FsttCRaL9wj1Gd4swuzSr8uR+TStzd1OInjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250043
X-Proofpoint-ORIG-GUID: FuHvl78EzC42BP8KN8PsSShBAN5E6pmV
X-Proofpoint-GUID: FuHvl78EzC42BP8KN8PsSShBAN5E6pmV


Sean Christopherson <seanjc@google.com> writes:

> Use preempt_model_preemptible() to detect a preemptible kernel when
> deciding whether or not to reschedule in order to drop a contended
> spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
> built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
> preemption model is "none" or "voluntary".  In short, make kernels with
> dynamically selected models behave the same as kernels with statically
> selected models.

Agreed. This behaviour makes sense. Should also be useful for PREEMPT_AUTO.

The only thing that gives me pause is that now there is an extra
call+ret even when we don't yield the lock.

But maybe that could be addressed separately by converting
preempt_model_* to use a static key or similar.

> Somewhat counter-intuitively, NOT yielding a lock can provide better
> latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
> rwlock, is often contended between an invalidation event (takes mmu_lock
> for write) and a vCPU servicing a guest page fault (takes mmu_lock for
> read).  For _some_ setups, letting the invalidation task complete even
> if there is mmu_lock contention provides lower latency for *all* tasks,
> i.e. the invalidation completes sooner *and* the vCPU services the guest
> page fault sooner.
>
> But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
> can vary depending on the host VMM, the guest workload, the number of
> vCPUs, the number of pCPUs in the host, why there is lock contention, etc.
>
> In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
> opposite and removing contention yielding entirely) needs to come with a
> big pile of data proving that changing the status quo is a net positive.
>
> Opportunistically document this side effect of preempt=full, as yielding
> contended spinlocks can have significant, user-visible impact.
>
> Fixes: c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic preempt mode")
> Link: https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Friedrich Weber <f.weber@proxmox.com>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 +++-
>  include/linux/spinlock.h                        | 14 ++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 825398d66c69..fdeddb066439 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4689,7 +4689,9 @@
>  			none - Limited to cond_resched() calls
>  			voluntary - Limited to cond_resched() and might_sleep() calls
>  			full - Any section that isn't explicitly preempt disabled
> -			       can be preempted anytime.
> +			       can be preempted anytime.  Tasks will also yield
> +			       contended spinlocks (if the critical section isn't
> +			       explicitly preempt disabled beyond the lock itself).

This seems to read a bit better:

+			       can be preempted anytime.  Tasks will also yield
+			       contended spinlocks (unless the critical section is
+			       explicitly preempt disabled beyond the lock itself).


Ankur

>  	print-fatal-signals=
>  			[KNL] debug: print fatal signals
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 3fcd20de6ca8..63dd8cf3c3c2 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
>   */
>  static inline int spin_needbreak(spinlock_t *lock)
>  {
> -#ifdef CONFIG_PREEMPTION
> +	if (!preempt_model_preemptible())
> +		return 0;
> +
>  	return spin_is_contended(lock);
> -#else
> -	return 0;
> -#endif
>  }
>
>  /*
> @@ -479,11 +478,10 @@ static inline int spin_needbreak(spinlock_t *lock)
>   */
>  static inline int rwlock_needbreak(rwlock_t *lock)
>  {
> -#ifdef CONFIG_PREEMPTION
> +	if (!preempt_model_preemptible())
> +		return 0;
> +
>  	return rwlock_is_contended(lock);
> -#else
> -	return 0;
> -#endif
>  }
>
>  /*

