Return-Path: <linux-kernel+bounces-62969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E78852872
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63E91C2352C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C692134F;
	Tue, 13 Feb 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h80prFgH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IsDCwxRY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D417999
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803826; cv=fail; b=rR1ioOfffXA+4GJL/41tkI6daIq1eHIFJJC4frbPIAhgGNbmRfygfRG+10KQrerFzBo10omLMx1GHPsgE5HD/9qOUL3F2GtZwKvhGGZw6nafpjFeU1w9bZ+TIsO+hrtWUlEOV5VliINs2FQ0KBnnNFRHo1dA/43sTXaMEeRcROg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803826; c=relaxed/simple;
	bh=cZ254lLjxAdLrH8n5/CjJEIsc916JEPISVxZvXwcxZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBnsVTVMomB1+0kTKS3peQmvsodpIzJFb0Z1PCNmtKU3X9rldB3lmRCN0DHe1QmIFeBN77GZuUzgkXNtGP36+L2BDVondn6aQ4E9IkNL2L7IAWl9PBqrZjRVaIzPLapj0N4rxb2WenTWj4m/7DX+NvMLt12vOlxGtp69GFZWgQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h80prFgH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IsDCwxRY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5neCO028863;
	Tue, 13 Feb 2024 05:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=HzqwUvkK8xB7rMUcd8xTT1/p/prwRC3nLM1EuhPBUtk=;
 b=h80prFgHjqy6bSWjwi3PqOZ6ti8lC1LMoOsm8mDYfZf7zPLiIApr4Jq91hZX6xpNhUj4
 KymzF36hGneaeOV+TeEFgdt6TnPuA+BEuM3DHxFBHuFfJsllc3V6LE0s45zA6ofNcJ4U
 dlkwHFtzeRm7rLgtPasvSl/p3SOBlfRhsZaHBkwQVi7ZBGbui2+t0jkGisqA3w4eEGSF
 6UM0P1fcU7IGp26TZSrmkOcsU1L/1ub+g3vck6u5sq0eU3mtwJDRacdTDC7jqjMVhPiq
 td0W+osIyE5ABNbd5ZRFKwQX0raIL31BASQlR1lxMov4WVD7bQKEj+eWN0fNatR3Cub4 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82m480ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4kTMT024017;
	Tue, 13 Feb 2024 05:55:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3sq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Uivd1y/XdBlW3zImbLhfEVK+QjtwvRxmPjJ1NSdbCm2CMjM3ruz0F8CgB48TwOnmIeaRDn14d/T+OpjwBhvTa9jRoYKx4eyL1QI4PjTJI/CHQBy5ZRNzVQWmJwQfHAZ3JDJezKC74AcCwMk9ETMvJhz67LiMZbUsw1I6yhPTf5tx2QOz9H3NYgJL/D1ycFVx7dSnrVYmMDt3Xe17vejerKvSpxIXdk607lQ8b8RWIpKD85NjM4ia1KlnFpIe0vr0o+vBcvYO+Cf9TvEhgtjti/uogfi0k7o695NATblFXNgvfwh0ANchfeegb9FgAXmbfOjAQrK2wOr6RWRrLIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzqwUvkK8xB7rMUcd8xTT1/p/prwRC3nLM1EuhPBUtk=;
 b=c/nZ6QXcl4BUP5vvjKpk0AsD0wWlgEYKytq45FlOuQTf/16Th1PmCpU8RV1Z62doFRd4Z1kYgOiSJNQSf87QvRTZP1SPhMHqwe8+97TKnG3NvpFRWIImsbX4DXi389uxL4x73tCnr72K3UL4W6as6XYNV50bRfFKfCdiSjMTRowObWJWKQtnw5IO3fKiGM361uWlGn7p8U9eG0QsmuH1U95sfx5Z7K+qQVMn4mUbzVSg20TyJBUCb9qvzin04wwPUzVs/fyMoLSKOGMVjFU9scUjfSVrxyEb6mGLN1mW5561hQnf4ahH+BxX8Hfvy4wvCGSqEJJN2C+XFWZJxKEKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzqwUvkK8xB7rMUcd8xTT1/p/prwRC3nLM1EuhPBUtk=;
 b=IsDCwxRYHttrUZ0BcU/7zCPcArzdSj3lPh0f3X9wlELod2CsMrw9Nv4ymKJG70JfKO2Je4ST2rYEhIPzQlQfe7fpz9zxGoZgXEbPdhErIRDF0PRBkFhLNBrJ1VT/P5gE8TYUd6gq3dj2k8kEDRVKFupAJQamTSe7k7oa6fKO+3g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:44 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 03/30] thread_info: tif_need_resched() now takes resched_t as param
Date: Mon, 12 Feb 2024 21:55:27 -0800
Message-Id: <20240213055554.1802415-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eed021-4c68-423d-6b18-08dc2c586b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OS1otCMje2i9YJIAGA+hcwp8fIWFbYz4ZJ4fh7DMp3noWfqndPfrdzYEqp8h3VZyNbTHD6exkkZ+6l9ZT+IY6g2Kgaf4gnbCZi5t/VQiqCprvQ6kQBtVxoHIp+2uUGzFg87waa8PCV39vIGUO/6L8S/a1NGp4D/iV+DnfpNSbnn9T3zexHPNurunCOFT1Oe666xjscJ6o/9ZrsxEagMO8CobA4G7nKfwxkmg8vpYc517OyJ/ZBG0le4I5NgBhvvambVVeT46NlfjG9Mn1ieXNIOqk99/iZ1rqAuPXTncRnyStcIPyK4N96Xbz1aDC74i0phPnAO4I3mgjahJt13k+ygYifp0nitQFdEIMAGP5Mksd3VEIr20ue49aeH+FFqqrZ5oyfjs1la+ERnDrozxAXWhB3FSZyXCuUB55Filrul/0/vM1Pv6gFusW28Mk6Il188Ayom0GM2SgJJ4zNvN0kvCdMMy+SpqedHHhHdVcgUhxMVUBs6gJPbKUrUdw4R0xM6YeCGQ2hyeUpAK9kThpwkMEXG5cBCy7e4ArFmbHhc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(54906003)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Oy1SKhBOpzUBEwbs5uPgDXM+VrHg6GnBVBg19fV+rJ0nmVbvA6IHBcd209Im?=
 =?us-ascii?Q?rvzxLN2Wr50u+6kxoE1HmlWMmz2Fxg6GD2aNkCa1Kjj9gfF8x9fjVVtEuztn?=
 =?us-ascii?Q?jHs2GmHq7vs0RYHsr4mGtTTkcFE5tRH59yYPW4R4MgPl932PzZlsHQYWQozZ?=
 =?us-ascii?Q?ReTQciaZZgzE50rtu1l9dnt6XJKdFfpWJsuTW5I7MR1i91G6h7QMLklExSMg?=
 =?us-ascii?Q?dd2Y1XND1xgR7RQUN1+Ynjm4m5Q8bmqGUX6/xGZ+T+Ti06H5hbGfmc82HDti?=
 =?us-ascii?Q?IPQlDYHGnIk55aKbDwDREYqnfUeQM+A8qqDVOKiK3kfFEMWkoWxjphcn2HjZ?=
 =?us-ascii?Q?GEd2F2Ge2mvlFwMF3TjJLx7m/LdyEZ/E8UKyEfYmtAabbpgSGdortQwUqRwD?=
 =?us-ascii?Q?MqeqcKb81PlxTgiwl474Rh2+7+tiVWgcQrUCE+Hdodf05LLHJIaBpb+b51Yu?=
 =?us-ascii?Q?BF/jRyzIKIMLkbB+u+Zlls1jJ0aeHXoH9hM9l70aKWn+n9sE72m+2lKdSbZX?=
 =?us-ascii?Q?XkUPvLgTLQ+auLYGLzyGsZ5JDaAJh13hcjzI88N8TeLhqGjI3vx8pCgB6NTz?=
 =?us-ascii?Q?XpCbClw7gxYzihr33PCHFO6MPE3zeoCqsAL5NdDap18RN/DjtElODeXQhi3m?=
 =?us-ascii?Q?cpimSu8mRlfBOEDEH4BoAuwK59zTeMV4eHNgGlFmOB1J+oB5cS3bS6zXyF8X?=
 =?us-ascii?Q?fv1kZVnIHtNFM0hlTykf90JfUArHBBEhnYu6NdkE5WI1EOR/ia/CbqD49iqt?=
 =?us-ascii?Q?QLcI1m5VUHMzBc7Phl96bgicAhRY12/TdJwqQEcddl31dbICdVT1IsbyIjOX?=
 =?us-ascii?Q?7tE7CdqotrAHAi+VmVpp6wUazCxzsj8dVGIP45zLOtWWF5+vFo93jqGSrsV+?=
 =?us-ascii?Q?FMsSA659H+p8DvjJAE1tnSgc8zie71d2KMP7JOi1y2xAjhQ5LNTJNCjTP/HP?=
 =?us-ascii?Q?b79z+H++EGb23+d9jnXJtmlEX2+Kvp57n4U91OSvVs9Rh0Dilv2C++gbj9Tv?=
 =?us-ascii?Q?qUmT51m3Kt9WfUBPH/j6QzfkpKwhLdrnrhV2KjaFyrnqbpmdE2bN+s6mb8Z/?=
 =?us-ascii?Q?gLzOoESYf3Cusje2kHlB4P315FEJ2IVk4PsXT6ol8H2qjycWl84stFTL7qvD?=
 =?us-ascii?Q?/D7zguBSVYhX0N44037B0qBB+XgBKId8yMktr31mQIEWz6fWDXHoFUm9EhKt?=
 =?us-ascii?Q?KToD1x9DbcnbHPx5s2EDWAYNAcUctRh8tRRM7Pg1HW0a2D84f5an+OYIw7VF?=
 =?us-ascii?Q?IdJ1qocGY+wVwsitx/6M0BCh9w+Eu27xCkA9Ojbw34Ihz0iWVzHqI+5UgYE5?=
 =?us-ascii?Q?IbkD5igE1TrAd9/5RbARQB8MH9ABLAN3f+pxK+rU6+MRGIt7eE3Gs0d9p9FP?=
 =?us-ascii?Q?pX1n39l/kcJlp2T8eEXrlCFVS1PbteJLq/1VlrH+ILzig9doYuwkEW1kIF+k?=
 =?us-ascii?Q?XxoZVWO77fEgifPxZQr3dOuqIafAM99ot007Mwy/prXhHEqYBQ5vzxbKGZBa?=
 =?us-ascii?Q?OSXm6s71SxUf/j6i9ABAaCR4klgvpQhr40OJr/tTH5Q4zE+1nDAvIA+P1TAR?=
 =?us-ascii?Q?y2eqyNOZcApVhTPiZXg9fWMMiXJ/Pfbe4gQ1/aUiLQLK8bZfytK6jwlfnc9+?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ofZUWZUjXWRuoTM9XbTQZaiaQ5EZHpdYbCMPy4/tsuLKVVXDCg8k7XZh5x5nq12Kru+zyVTEcbYlOw2vyVFtUXJrP/zIWM5Kq+KyY4z9cZx3LUtCMczLSEI2+vqx4Wc4eCdjvSWfoqY9N7DyWYRKtL3fEVj/4rl32gDS57XRItyM/JcdV8Z56YASVlomPxKYeiA96ZORcmmzCWi6inqoZgIVS9QDtxBwmXacYNxSrHu4wl3ST+RKfZd340mfo++ygVEWdtGtApxsLDkoFrRWHeZ3ZbNZq+rd9h14oRRLqQVwG8kvBB7TrPyiFSYKVOOTmepBnGz7gcoOXY74D76yMbLNXUE+knJ733y1HE/TxcWHLfK2e4JXm7pe3gCO+oZrbtcwJ2Ks7QI2wngXd46NVQKEChIGbziH3Y2No4vIe9WEs/+ui52U7eGCRSdFqoTNp7pkPZZTu6Qh/E4xrXDcHYk8keNJeCE/2VakylRuZLGbiuECqGKvFQBp0MfZk3W8FOuMVVVHbR6DWg45Fc4iHEJCudaLVsLS341l9TjieF+zHkWH72eWCWX3jX1I6Iflyxq81rD4LgjtxZYW9zgxQiHZhkP24S90AzKH76QC0V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eed021-4c68-423d-6b18-08dc2c586b25
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:44.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVuR4RS4xwfA4fUqHDi8Pc8kP25bPfPw1ggYVY5k6oCf8MllktotT8I0TFCvF14vz2LTZh8QQbsin80xPkOUhL3KsNZbo8cJNAHY1+IlaBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: 47l9FIMoFeS6V7NQ2dqIWuSZ-F52eYTr
X-Proofpoint-ORIG-GUID: 47l9FIMoFeS6V7NQ2dqIWuSZ-F52eYTr

tif_need_resched() now takes a resched_t parameter to decide the
immediacy of the need-resched.
Update need_resched() and should_resched() so they both check for
tif_need_resched(NR_now), which keeps the current semantics. Also
define need_resched_lazy(), which as the name suggests, checks for
tif_need_resched(NR_lazy).

Given that need_resched() (and should_resched() to a lesser extent)
are used extensively in the kernel, it is worth noting their common
uses and any changes to them:

 - preempt_count(): we only ever want to fold or make preemption
   decisions based on TIF_NEED_RESCHED, not TIF_NEED_RESCHED_LAZY.
   So, related logic now uses tif_need_resched(NR_now).

 - cond_resched_*(): checks for should_resched() and preempts if
   TIF_NEED_RESCHED were set (and if (preempt_count() == offset).

   Hand-rolled versions typically first check for need_resched()
   which would also continue to check for the same thing.

   So, in either case relinquish resources only if immediate
   rescheduling was needed, not for lazy-rescheduling.

 - idle: run to completion is not meaningful for the idle task and
   so we always schedule out of idle whenever there is any work.

   Most idle code uses a mixture of tif_need_resched() and
   need_resched() (the first one especially in the interfaces defined
   in sched/idle.h.)

   This change moves all the idle code to need_resched().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Note that the need_resched() semantics here are narrower than
earlier versions of this code.

  In previous versions, need_resched() checked for
  (tif_need_resched(NR_now) || tif_need_resched(NR_lazy)).

  However, there's a fair bit of code which relinquishes resources
  temporarily based on need_resched()/should_resched() checks. Or,
  in the case of mutex_can_spin_on_owner() decides to optimistically
  spin or not based on need_resched().

  So, this version limits need_resched() to only checking
  TIF_NEED_RESCHED.

 arch/s390/include/asm/preempt.h |  4 ++--
 drivers/acpi/processor_idle.c   |  2 +-
 include/asm-generic/preempt.h   |  4 ++--
 include/linux/preempt.h         |  2 +-
 include/linux/sched.h           |  7 ++++++-
 include/linux/sched/idle.h      |  8 ++++----
 include/linux/thread_info.h     | 25 +++++++++++++++++++------
 kernel/sched/idle.c             |  2 +-
 kernel/trace/trace.c            |  2 +-
 9 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index bf15da0fedbc..97fda8e06b6c 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -114,13 +114,13 @@ static inline void __preempt_count_sub(int val)
 
 static inline bool __preempt_count_dec_and_test(void)
 {
-	return !--S390_lowcore.preempt_count && tif_need_resched();
+	return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
 }
 
 static inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
-			tif_need_resched());
+			tif_need_resched(NR_now));
 }
 
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 55437f5e0c3a..7fc47007b926 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,7 +108,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
  */
 static void __cpuidle acpi_safe_halt(void)
 {
-	if (!tif_need_resched()) {
+	if (!need_resched()) {
 		raw_safe_halt();
 		raw_local_irq_disable();
 	}
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523..ed98e6168b99 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -66,7 +66,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
 	 * lost.
 	 */
-	return !--*preempt_count_ptr() && tif_need_resched();
+	return !--*preempt_count_ptr() && tif_need_resched(NR_now);
 }
 
 /*
@@ -75,7 +75,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
-			tif_need_resched());
+			tif_need_resched(NR_now));
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9cf1bab..336cb76f0830 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -312,7 +312,7 @@ do { \
 } while (0)
 #define preempt_fold_need_resched() \
 do { \
-	if (tif_need_resched()) \
+	if (tif_need_resched(NR_now)) \
 		set_preempt_need_resched(); \
 } while (0)
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cdb8ea53c365..7a22a56350bb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2099,7 +2099,12 @@ static inline bool preempt_model_preemptible(void)
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(tif_need_resched(NR_now));
+}
+
+static __always_inline bool need_resched_lazy(void)
+{
+	return unlikely(tif_need_resched(NR_lazy));
 }
 
 /*
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..d8ce85dff47a 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return need_resched();
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 #else
@@ -85,11 +85,11 @@ static inline void __current_clr_polling(void) { }
 
 static inline bool __must_check current_set_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 static inline bool __must_check current_clr_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 #endif
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 99043cbbb6b0..8752dbc2dac7 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -211,22 +211,35 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool __tif_need_resched(int nr_flag)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
-			     (unsigned long *)(&current_thread_info()->flags));
+	return arch_test_bit(nr_flag,
+		     (unsigned long *)(&current_thread_info()->flags));
 }
 
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool __tif_need_resched(int nr_flag)
 {
-	return test_bit(TIF_NEED_RESCHED,
-			(unsigned long *)(&current_thread_info()->flags));
+	return test_bit(nr_flag,
+		(unsigned long *)(&current_thread_info()->flags));
 }
 
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
+static __always_inline bool tif_need_resched(resched_t rs)
+{
+	/*
+	 * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
+	 * as TIF_NEED_RESCHED (the TIF_NEED_RESCHED_LAZY flag is not
+	 * defined). Return false in that case.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
+		return __tif_need_resched(tif_resched(rs));
+	else
+		return false;
+}
+
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 31231925f1ec..be53d164e267 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,7 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
+	while (!need_resched() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..0a9642fba852 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2701,7 +2701,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
 		trace_flags |= TRACE_FLAG_BH_OFF;
 
-	if (tif_need_resched())
+	if (tif_need_resched(NR_now))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
-- 
2.31.1


