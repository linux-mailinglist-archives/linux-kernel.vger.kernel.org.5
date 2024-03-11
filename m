Return-Path: <linux-kernel+bounces-99538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DB8789BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F421F21F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFF4D5AB;
	Mon, 11 Mar 2024 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hb/guSPN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p5EClyCc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D750260;
	Mon, 11 Mar 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190363; cv=fail; b=TZKDvka434imtUOyHtfZ18gAw6hutgsTAdUdgMBqHQSVEX19ebTMCSZL8y4tJSU3C5WeUVAgS/np802fS84Ff5n32FD84WZwRszfc06UztOvZU+eodFOFibQUnPx5syXkOaHoPnlVVvtqWpN5zKCZZSi8NYCAn4LQrKtDMqJahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190363; c=relaxed/simple;
	bh=GYZP3Em1lHgJN6OO5ach9h3Vli0NzbbHNVnoFzJ+/ew=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UQ9AY56rXbyR5enfhlJT8xikE9OX4zXcqOJvOB3cieDbLnydvGY2R/e1zgRyW8oEDgU7kBBGeZtEC5T0lyfXlIjFmwD5nw0cHPThSEednugPYQMVkMKkVgNgKzHG32if2zRdaE6NDS+Qry5Fc8pG0dKw1gm9Cuj5ZxtOkxWhtPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hb/guSPN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p5EClyCc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG3q18021021;
	Mon, 11 Mar 2024 20:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=OX4Zlij0gBEskkpAkOSJODEzK8AjT1nln2yA8qB10nc=;
 b=hb/guSPNiX2cczY+aYuR0lwEMUb05wvj49f65C0PJP100snj1yIsPjKz0OTuJSG7tS/1
 9gusZ5kXoSJWAdyfPk7Dz2BAf1/HtacMeVZRmbSHrJXTihR/ptp2aoNJ0b4AbItBC1X/
 Fhqr9KdZUtbKs3k/sEpXbwsvMPJO8mYky31vupaGJ88flYX+AN3b3WYX+UEXiFYxR5Bg
 HCoUBFrAhTM971M9JnFVZla/oSw4qLF7UJ4ncYlUovqMt7OJpsMadflBQ0Flr6a+Cqm3
 Ku1E7rng57ZAv6vdml70dm90wN6/efCLYS80FkIJYCDSH8dqOI5t1W0rtXp80drYf0mJ FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcucded-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 20:51:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BKpUjM037331;
	Mon, 11 Mar 2024 20:51:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre769my4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 20:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejiySU92UC1VNE0DSu6FxwC7mrJ7kOOXf2w5w0l99F0WitbFlzxcEGyEQD8rRy1Def1TGJ+wFMET604hGx2ZfvtX69X32qpa6kZdlZwWaiDQCESCGTYmoIxaetVTt5R3wNEi3ESlFUjptArabSBaYCz3GlN0mRF/49jFGyKg6kI62a/23iWvF2ExAksLy0k0D+aQodYsM9YrfvGD3i4kCaDS779dMChHP8JeMfOs8YZkPkwL6kUHDWZZH8qhh+PyX46n56vNMs1aj2adlYBAje2nbfZ7SA74RNQHRHkw4XT+zVpTCr9voZ57pdwioj9QlOSFZo8+eMKq3RMWSb04EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX4Zlij0gBEskkpAkOSJODEzK8AjT1nln2yA8qB10nc=;
 b=CDvJN9O/6dja/hwNIAoZFxXfjyTF9Xa2dOqDuCn9H9o1M0iH4r4uCpa+gUWKQzNOF1D+h3tasIW2zYcYna8lXpsSa4NDZo9/pk4VkF73xYfC5uLxEvwQKtwymUR58X24CzYfH1rLqiXkYyLcRfCDyf3gDXNZ2NR+xHVBwfVUXE4dl3+Fuig9GGw7tev+DUKhBDw0ki4xe2ekboEeUE5ooR2bo/SUnv4S/8KMdRs4wfDfvui+m5+7XJ2z0MSmSqt3NrEzfGpxVXEwcbP+XYlIvKiM7OUSBC1yaSy9dMEu6RPZ0wBugQTg5Niir7WgHLbHwdsHKLz4i9pODzmlvNVpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX4Zlij0gBEskkpAkOSJODEzK8AjT1nln2yA8qB10nc=;
 b=p5EClyCcKUnZuCfxD4awCx+AHxGiy0/pTD155/T6AzvttGeuS7nBFDlcM/N1AobGrpfbtKhJkFxa/IIKRbwBOtot6OGjsCD0Yldp9L8C6SVm+sxbdYwnSCUia8Sa3/Gfxw+90dBryahN/yK4o5ZAPUH2yCkKtl2g7zcT49pMfgo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7564.namprd10.prod.outlook.com (2603:10b6:610:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 20:51:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:51:27 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <0965542e-80a7-4837-b14e-903c635aa828@paulmck-laptop>
 <ffc5019a-b593-4dd9-b4e1-4f7755040f23@joelfernandes.org>
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
In-reply-to: <ffc5019a-b593-4dd9-b4e1-4f7755040f23@joelfernandes.org>
Date: Mon, 11 Mar 2024 13:51:59 -0700
Message-ID: <877ci8h4pc.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:303:86::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ede29f-b67c-4925-8463-08dc420d0554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lWD5UaJQHke8/ZHGhpK5Z7pQb6N2MZxU9p6gqJOvfSEHCn7DpK5TADnPIPP33HOl4h5cVy1IvqorwoFSRyrABTmAusNIUNrlXkDKcsFGvBVXnrBmFbWDcfH/pKXsIIIDr8ZO4e/sZ7p5w6sHhXKpn6aJnYYCpwl3P9ltYr2WMfLV7/tEDUrCsbaW2D7UFQTtrkS0iRxq0NdxE0z0nW1XL/4Met0YBmWhK/oYaMC/44HQ4+P3je2Yt7iBz/QpqqhklUw9dDT8B2SBDrfkg/N+wbsZARACgz6kTJZP7Yv80W6EGm0EqoEb4zxLEJX1VAB6phvNwbr7pRI16yWsSaz3uvdNnPW7sWrgfX0AXRzJ7UnZqUtsukK9/Z8gjtLjFWzgOFhCQCz5jlwyuWqQgkZbPm928qIToyEOreIs0uqugL8XtHXLNK3MkW5CUjw54KN0CZTclQtoqLqNcBhbCEIxW6YCdNfZRikBmbB+3yTxsnhbaI4QzuJlTRylMXTwu2sMJZDL0RA+rkDzchTnMMdoegUBqTCYY421qVSYBnxKv2fdboBYTd/MHkol8g4a30UguzuDitRax33eWSspRjmH+em0s7kZCMF2wlLO4m2+jn5ZSKVhS9IPooW0jgaOw5ChpbRmF37oTERhBBZqs7vl0U8+j9AYBUC9qJEj9eqZn0g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7vCCcYMhNHFy7DV4oxZbWMff/K5VeUdGVXtgEmXqEA+nEun17z41yCH/EuDa?=
 =?us-ascii?Q?5zzi7TSr970dTtXYzbnzQBFNeiIwqoLqD0Iz6XA0+1UiW/E5vjgEVXqA24/a?=
 =?us-ascii?Q?3GZJgWmDER1JX/adfymwv18iYOfo/2UedZR1WqAGnhhJdxLwmac8ftGyv+P8?=
 =?us-ascii?Q?h+4HOyO/8f8Zd1vgZ3zuJDWufzgbtC6zNXSZF2bZimxUwDVFDWtLPshL1DyX?=
 =?us-ascii?Q?q75Ebug0NgxahYCON4a+6l7ielPyNfurzQtA8+Zt1E4mme0K/ZisFUnrxpRc?=
 =?us-ascii?Q?98tPIl+lNbZLVcoyBPM35kf6JVaT8P7iAuAD/NJ5ObWL8rF714NzbN3Q2+cH?=
 =?us-ascii?Q?25nlFZYY7Kt/WpjJb03a4sgXTUEcksHh7mqIP57ND0qSpB4/vjFt+D/w4Hkf?=
 =?us-ascii?Q?y1VNTOCYikEsZyrSVL/SLwhel7tqZ+3S9V5mrieabYVLGBxjXoXrZhFa+adI?=
 =?us-ascii?Q?enlVco1gab4xNFWDoTNXhHCf+ajm9edRn8HbMwM+eiT689KOIJOszk67gxl8?=
 =?us-ascii?Q?wMT7kTI01K/9zrhxNTFXzh4oIa4YKBNfkqz05ZduUSU/dtgG5ZNBdSvU7BaI?=
 =?us-ascii?Q?oeyU7BBaSRPIslXi/pXd51FzqnIczYzpuvHXnP9DPgl06cRVvP4C89ZUc22K?=
 =?us-ascii?Q?2h6TMhJUNHiKzEErBxCLJzPbugswqSdJld7kzuoUwbyTeafiwpe+0bguycdB?=
 =?us-ascii?Q?yP96O/mtbTEWKpV6LB+xOkPme7PW9SbUocHBCJYwP60LH0v2Gjw91+PUNEsW?=
 =?us-ascii?Q?PwtVkXWrEKEsUZLCjxmx48MotvRQkKTvIZzihsDoRcjAEzoRRcOSUSYIYFs9?=
 =?us-ascii?Q?LYXLjffqEE3HjEICgkdcqAKFOuzCKLmx6e7hAylEqUNlY48wbHUqEdqsWQJ5?=
 =?us-ascii?Q?qYeWWQ6xWjVqAkN3gTJdX7FAKhSa6HGAcZWrMsLUp1Hs5Azd39IvJciuaPpL?=
 =?us-ascii?Q?MxXzGGA+Oao/lmAgiEzhhXmkqtNOscg6/LMiIUJ5s0FRnGh0so7KafRJjXHu?=
 =?us-ascii?Q?S9J17BBu72NbwIWrmFAlX4F/wwggFMEDUVCZKJgCC2M3azzhWpazc9mWzll3?=
 =?us-ascii?Q?olmWYy/aFOVrKS0yiiULhPtg6h0bThV6PksSejo2oia2+T++pRT4slj8HAVi?=
 =?us-ascii?Q?XXZ5WhjluIh8F0suQplhgum0rEdykSzqhV7GxeCz/IsvWl2PNv4uL5EK4QRb?=
 =?us-ascii?Q?/wCN+LBSHpRB9TcJHjP9nWomvqAmIKY4R4RsRbm/qzeAqVd8IAbj79r+iNb9?=
 =?us-ascii?Q?o1Mi6lq5q3VJGzT7ByQjtdneaFK9xa9ukSMG1D9U+S0S9+7vaN8B4igwcfYh?=
 =?us-ascii?Q?OAYNLtcp9tbQFrAQy6fBIKPw9guJv1MzmhocwQsDcGS0wgLZHawO1zF1NtE3?=
 =?us-ascii?Q?tR7w9R/vH42ZOE34dpYcCsPBwM54UsHQbM6vweFezazSAKR8hwtxzLSxHzVp?=
 =?us-ascii?Q?rkCBwn6RCq007hfI2lWtd2y/mGdUo1liTpO87gJwIM0QhWJHtZOFnHzudr9Q?=
 =?us-ascii?Q?d+AcLLXdJ/OcIBS67C3ZRyac79xPTV/92tsyk1GieoYUY6KXzWak0dheez4b?=
 =?us-ascii?Q?BlUnMR3E4CZD3fZW9vuXJS2yEMDcTgwe1xHSYn3FQh9JUoIySPzMytNtEMFR?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SDsIfQq1M20e6JRnnBbuclKonsj58+laY/QIWDS6ILL3tx3AHvPMxaRc4HKEc3vzy7Daq300mE5s95e/vL9yztFoew1OndygbVHKBR0am5XzQi9qkLFEDw7bkFr/CgouuQxmTcBv3f6XrKRyYj1L++7idFGXQbxfRLfVaG8MPodMnN5zFjEodj8VE1OKX0VaNB5mPtJKA8tsvtJYdXiFO+wPUVQ+Jd8aAj3RB7psDBR9W+S8Q28pmPz+bPmMm2lVKEwm52RYYVhdaorzUTtOld5xcyORfDvDMsmO5fvkASUPHbX4WeUZwKHvQ0MBmGDlIDY+GIQl3f7tx4pg5UIMhs5hf9LeSGSVkoKkIqJOaCb75YqHEZva1Sk5tPNyGjFPVVU22/ZRVT5bb7sGL2bcC+GtiA6FZChVa9XhTZfXu+bbnTIvf0xTYkdnJbu3MLebrARMz5R+repO5i3ArFycyLMz4YYm98EXtS+qb0fcQZZ1gj7NatiB6Lhc0dMzknd426pbffBL35AtXMHmF67mWVun2iPJSl8E9xhz0qQvTUbKaYa8o1er8rdUvEbQeG5KkkkkAnSAo8tQL/I6uW8s5cD5GbIX/PBoZYAnxrT9I4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ede29f-b67c-4925-8463-08dc420d0554
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:51:27.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SexW2nE/RHjatcmaCsQqVSYmwqTOMHBtk+4mcUvhK1kp/CQ5TLqVuq4tGavv9fxgcLP5BZ3n/b9UuVJ6AQPB2CLDO5B7/V4+9Op+sM2AaN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110160
X-Proofpoint-ORIG-GUID: Kasb-uxeZvhRCJZyY9aBbDKDAZBsl9UJ
X-Proofpoint-GUID: Kasb-uxeZvhRCJZyY9aBbDKDAZBsl9UJ


Joel Fernandes <joel@joelfernandes.org> writes:

> On 3/10/2024 11:56 PM, Paul E. McKenney wrote:
>> On Sun, Mar 10, 2024 at 08:48:28PM -0400, Joel Fernandes wrote:
>>> On 3/10/2024 2:56 PM, Paul E. McKenney wrote:
>>>> On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
>>>>> Hello Ankur and Paul,
>>>>>
>>>>> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
>>>>>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>>>>>> states for read-side critical sections via rcu_all_qs().
>>>>>> One reason why this was necessary: lacking preempt-count, the tick
>>>>>> handler has no way of knowing whether it is executing in a read-side
>>>>>> critical section or not.
>>>>>>
>>>>>> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
>>>>>> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
>>>>>> not provide for quiescent states via rcu_all_qs().
>>>>>>
>>>>>> So, use the availability of preempt_count() to report quiescent states
>>>>>> in rcu_flavor_sched_clock_irq().
>>>>>>
>>>>>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>>> ---
>>>>>>  kernel/rcu/tree_plugin.h | 11 +++++++----
>>>>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>>>>> index 26c79246873a..9b72e9d2b6fe 100644
>>>>>> --- a/kernel/rcu/tree_plugin.h
>>>>>> +++ b/kernel/rcu/tree_plugin.h
>>>>>> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>>>>>   */
>>>>>>  static void rcu_flavor_sched_clock_irq(int user)
>>>>>>  {
>>>>>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>>>>>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>>>>>> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
>>>>>> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
>>>>>
>>>>> I was wondering if it makes sense to even support !PREEMPT_RCU under
>>>>> CONFIG_PREEMPT_AUTO.
>>>>>
>>>>> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
>>>>> the next tick boundary in the worst case, with all preempt modes including
>>>>> the preempt=none mode.
>>>>>
>>>>> Considering this, does it makes sense for RCU to be non-preemptible in
>>>>> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
>>>>> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
>>>>> from happening, because rcu_read_lock() would preempt_disable().
>>>>
>>>> Yes, it does make sense for RCU to be non-preemptible in kernels
>>>> built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
>>>> CONFIG_PREEMPT_VOLUNTARY=y.
>>>> As noted in earlier discussions, there are
>>>
>>> Sorry if I missed a discussion, appreciate a link.
>>
>> It is part of the discussion of the first version of this patch series,
>> if I recall correctly.
>>
>>>> systems that are adequately but not abundantly endowed with memory.
>>>> Such systems need non-preemptible RCU to avoid preempted-reader OOMs.
>>>
>>> Then why don't such systems have a problem with CONFIG_PREEMPT_DYNAMIC=y and
>>> preempt=none mode? CONFIG_PREEMPT_DYNAMIC forces CONFIG_PREEMPT_RCU=y. There's
>>> no way to set CONFIG_PREEMPT_RCU=n with CONFIG_PREEMPT_DYNAMIC=y and
>>> preempt=none boot parameter.  IMHO, if this feature is inconsistent with
>>> CONFIG_PREEMPT_DYNAMIC, that makes it super confusing.  In fact, I feel
>>> CONFIG_PREEMPT_AUTO should instead just be another "preempt=auto" boot parameter
>>> mode added to CONFIG_PREEMPT_DYNAMIC feature, otherwise the proliferation of
>>> CONFIG_PREEMPT config options is getting a bit insane. And likely going to be
>>> burden to the users configuring the PREEMPT Kconfig option IMHO.
>>
>> Because such systems are built with CONFIG_PREEMPT_DYNAMIC=n.
>>
>> You could argue that we should just build with CONFIG_PREEMPT_AUTO=n,
>> but the long-term goal of eliminating cond_resched() will make that
>> ineffective.
>
> I see what you mean. We/I could also highlight some of the differences in RCU
> between DYNAMIC vs AUTO.
>
>>
>>>> Note well that non-preemptible RCU explicitly disables preemption across
>>>> all RCU readers.
>>>
>>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
>>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
>>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
>>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
>>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
>>> the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
>>> to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
>>> kernel but are worried about reader preemptions.
>>
>> Such users can simply avoid building with either CONFIG_PREEMPT_NONE=y
>> or with CONFIG_PREEMPT_VOLUNTARY=y.  They might also experiment with
>> CONFIG_RCU_BOOST=y, and also with short timeouts until boosting.
>> If that doesn't do what they need, we talk with them and either help
>> them configure their kernels, make RCU do what they need, or help work
>> out some other way for them to get their jobs done.
>
> Makes sense.
>
>>> That aside, as such, I do agree your point of view, that preemptible readers
>>> presents a problem to folks using preempt=none in this series and we could
>>> decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
>>> just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
>>> consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a
>>> week from now, no one will likely be able to tell the difference ;-). So IMHO
>>> either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
>>> optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.
>>>
>>> Let me know if I missed something.
>>
>> Why not key off of the value of CONFIG_PREEMPT_DYNAMIC?  That way,
>> if both CONFIG_PREEMPT_AUTO=y and CONFIG_PREEMPT_DYNAMIC=y, RCU is
>> always preemptible.  Then CONFIG_PREEMPT_DYNAMIC=y enables boot-time
>> (and maybe even run-time) switching between preemption flavors, while
>> CONFIG_PREEMPT_AUTO instead enables unconditional preemption of any
>> region of code that has not explicitly disabled preemption (or irq or
>> bh or whatever).

Currently CONFIG_PREEMPT_DYNAMIC does a few things:

1. dynamic selection of preemption model
2. dynamically toggling explicit preemption points
3. PREEMPT_RCU=y (though maybe this should be fixed to also
   also allow PREEMPT_RCU=n)

Of these 3, PREEMPT_AUTO only really needs (1).

Maybe combining gives us the option of switching between the old and the
new models:
  preempt=none | voluntary | full | auto-none | auto-voluntary

Where the last two provide the new auto semantics. But, the mixture
seems too rich.
This just complicates all the CONFIG_PREEMPT_* configurations more than
they were before when the end goal is to actually reduce and simplify
the number of options.

> That could be done. But currently, these patches disable DYNAMIC if AUTO is
> enabled in the config. I think the reason is the 2 features are incompatible.
> i.e. DYNAMIC wants to override the preemption mode at boot time, where as AUTO
> wants the scheduler to have a say in it using the need-resched LAZY bit.

Yeah exactly. That's why I originally made PREEMPT_AUTO and
PREEMPT_DYNAMIC exclusive of each other.

Thanks

--
ankur

