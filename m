Return-Path: <linux-kernel+bounces-67968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9C8573B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF521C22555
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C570FC12;
	Fri, 16 Feb 2024 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eOei/M2E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S0NvzB5O"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8AFBE9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049760; cv=fail; b=JSIKkdXNh7WYmpXmJ2+aoouHl8czf6L2/A5i/2s7ZmaQabIBuTNA3Tl7j0epJtRVWkWNS33PilKnN5f6qOvt4LEvk0VtwMf3ChYw72DLrT1gSPbownKJ8UI1WoD56N/hKyxP9q4fKEQErhTCXILHjJpCVY2PMmYdkc9VwjlObm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049760; c=relaxed/simple;
	bh=mvZ141N+URpRl5KzZKumhnql9g5lXBr7L7SckQrL/7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8N82NHIv09x71eFnm344rjM9FMXHjlEKLX5yMCRKvTkCN1XXdLTKiWM0Ri6TFa3q2AOUZrWvzgbDBQXAj/PbwipoPqJ2tPYDZgzW7lF1kxNi9LepMQyNStEs6UEk/zt09POO7cao1LygPQsQIPr+UJpQJyEH2ZE2Geg1bAdIiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eOei/M2E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S0NvzB5O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSMAM001616;
	Fri, 16 Feb 2024 02:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pgBFvWwz5K2u/sLI9rxiV0o5yVFxFHz1Okkw69iX4tg=;
 b=eOei/M2EilKMtx1C7i/u1xyjB2aUhx8P5hOmH5bTGuHhm4Rg9OjZSiH15CIOUxfAeCsR
 V6ejcuvmk0kOqnICmUzF+aqhy+Fb+FE0WlUwxxfQ9aDKYqOVU4WaOgByfr5+1FDpMkc6
 mNJEdRUu0A4Ox1TzBsMFWsdK+V4BRdvpO/ip68pVoMYQ/3Fl4UnILqBLhtgHNRpalV9I
 3etZFXMFsJ5z4Uy/UjlXT7DlBFoU2/DBhPy8+b5vc7qMXF2JWnJy38sRUeAdAMn/oPKe
 TV8HV5ngKCUxeplXBSksBsdTkJOG02AMpjRp5RV8UZclKNOCyrHK6gas73HaltpI12Qh 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f04441-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 02:15:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G1AAqS031501;
	Fri, 16 Feb 2024 02:15:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykbep93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 02:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEqMZJSx5AoTj8inDDsdxzIg10vNecYEm+a+BUO2C4LDarQdWBc+CSKvzzysu+szPPTklHcoVrzXGfjyyp2s5bY+WQNJcLyHQ/SsvKfhqKSbJQ6X6vyfPXNa0D0D+m7pXe3EaOY/FHlYUqv1vh0L+Rwt+xZ+V7dFbfgymgj2KvTj8tSt7uvJ00Lc4Rgb/KOAlwfOpuBWd/oH9/80diX5xjT7Bd4nGSTbQQs8LMO5nkgfgyc7rebrCoqckPerrMZiJibWGA2EL2YJqCIaY79ys2S8OHXKoIuDzHzoxr0gKi8gfh/rvnuW073bsOFL6+84FCKwZk0K13ndW1VygOhajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgBFvWwz5K2u/sLI9rxiV0o5yVFxFHz1Okkw69iX4tg=;
 b=TQWe7bIK474By01ibtquM0G+5MaJaqeR01ggfyFE1UGZ4V2cNQCA38bWeF+9XTcC1sxuvQ8Wc7KFcANE6q+xVoOAmNU6fz2QMdsHZwUl8BNHIPyKW4OcjzM6A+3yMDRajVO5mTvxLi+LgxWuH5YGOhMdqm831j//ICntrt2Rkmg94f5diAyoYQWfbOHxLlyVECTS3R2C8sD+cZAwTnWy//kY4iaWIeXFLZV9SeTCjOFvRLnmZvWvXBMUqzgC13696VwQz4p5c9OA62HYqzypikkAJqm2efrOhtt9RvtCFH/UUl3Hl5Z3iISXn6HYlY4z5/X4YAevzt17YPl6KIcBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgBFvWwz5K2u/sLI9rxiV0o5yVFxFHz1Okkw69iX4tg=;
 b=S0NvzB5OVVtuSuJ2LI8WrgROs0c1XWIIniqSZlq+igu5p3g3wyQcLdNs4Q45OnwyyHmfU5WUb+bkLyKPKkIGuZwCD7qnZ/ZeBNktCbBsjEa9U2Ul/nw9oriZGfbtXnJCDEAudE1sW4qoDYw5DPnTnrCTUDos6PrXvElEAo21gMY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 02:15:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 02:15:25 +0000
Date: Thu, 15 Feb 2024 21:15:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, akpm@linux-foundation.org,
        debug@rivosinc.com, broonie@kernel.org,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Message-ID: <20240216021523.xb2q35kdchwdk4vh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	akpm@linux-foundation.org, debug@rivosinc.com, broonie@kernel.org,
	kirill.shutemov@linux.intel.com, keescook@chromium.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-2-rick.p.edgecombe@intel.com>
 <acac6cc8-fd83-4541-8310-63f37cd41fa6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acac6cc8-fd83-4541-8310-63f37cd41fa6@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 13496501-0eb7-4db5-5eaf-08dc2e9522ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+vCQuU2gs4rJCj3/zEu5B7XPggdiFpqzRkUDBCIH7x6WYLko1veboUk+/krfj+0Z5SHEOrWHvcoEgsUEMtB7u99jMfc4Zh5I/sn47DdiVGwG+kxfD1vpJiJl3/u7qNRNTUQGmKDwR1t2W5IMu139Vncq2jQKWMm/A7m4bO5zmJ0QDk8NUtCGSdWBUHOyXPA8S+a6uA7z5k1sJHwOgYoiPYqtcQOxdjfO7/BU/ocvllCVIok2QsWqk8iQ0cVWwK9cmX7GkPnxZ/8tPUbu14omHpEj7HD9YA3z3VkooAzs96Ioe0PCA1aBJWQWVCumUE/gtaWjRJnTxfjZeoeFUeSbrUjfAxUBcFttzDYrA/Kd/zF2Di+gpyHHgYZ714phmc3WYkeWmq2XtE3MjfSzEnky+qGIrlzJdmAGSUWBwJPYOSbXwqDz9K4hepvWRACGO8Y4/RbREOupN9M3PIDaIpOEM+6NcUUiRb4c8dPPDoURv/lY59+f8WlBEkmCkeoM23TViknJrZ+9krnedPvCiLMEmP4LiWYcCI4EMlV5D4mAXGnS5LCFeqzeMO2zW7df2fQb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8936002)(8676002)(4326008)(1076003)(26005)(6916009)(478600001)(66946007)(41300700001)(316002)(66476007)(66556008)(6512007)(9686003)(6506007)(53546011)(6486002)(38100700002)(86362001)(5660300002)(2906002)(7416002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vGmHczr6WdGcYO3j3mHK03rrzfjt2OAvkvV5rpMMfx9SiVyZIvg+Lur2Jo1R?=
 =?us-ascii?Q?qnMv30MGVmf3mlxrQKeFTsylbGyoSFXfZZfZ2397UDGjVycLQfPyuA2kskwP?=
 =?us-ascii?Q?s1rRoQrVuyjKo6VkgbhlSOAmsYbQ2NwTiYkqNINWLjdEpEHxCDr2igPEsuf6?=
 =?us-ascii?Q?lcJ2RT5EQQTe2fxTENAnXNiDNMaC1g0uQn0haW7NMo4sBfrPsPMVPDho7TTV?=
 =?us-ascii?Q?xoEMOTHBk0/eTkWfs+ULUdiJ2TXjYOhZLpNs/vWszZK6lTmqGaOZfOy1u75Q?=
 =?us-ascii?Q?ZgRi7P0EvIcPn46Ao2nckVsrdec/ebNW7qjDAxVkZ7muyhE68haDVp8oBOYb?=
 =?us-ascii?Q?ipek1keMIQ6cDiHAEiNkJtm9jOXJqz7OwArYIqdp7Q0lzaH6q9TVwWwsL7Ec?=
 =?us-ascii?Q?MQEJUkloLp7uwoy5VP9E26s77EsksBGBrDFhBYDq6KveZKLifG8fIhv7T6Pb?=
 =?us-ascii?Q?ctnGpAZPPzgwablROi6OrzsVwBa0GDL39jSXhJagYLyj128czoBlaBbrC7gF?=
 =?us-ascii?Q?zZAvL46g5M68zml20nQezFCQ9n97Ca0arg/HoLweUwK6PcmRGnwT7wqf88AP?=
 =?us-ascii?Q?3yKNA2/bwtHQsvRoZIwRdrg7kTD2w9ViU+jSeUP2CyZKQYRY5u2IANS1QM9A?=
 =?us-ascii?Q?5fhy8rHEH9xnYL0ZKXefAeRg8SqhMYZjMuyueqIFdBL05iF6ZCYoprZRNf8u?=
 =?us-ascii?Q?i2twehqbLmPlXfT/ZDR2PDy2lKQMADSJkbtwMPVfV9cy346Kb9KnH/n7zobW?=
 =?us-ascii?Q?xEOl4eANJA6lyM6f/4ePNRAgWQmEeRIU98lXJJU6FgYfzHVvgFv4Y3vaAeLP?=
 =?us-ascii?Q?mSgXXhoCF6coDVhTumx1/8FfFKSzxSMiBB4jTwDtrr1eKPo0350BWkwVTQ4+?=
 =?us-ascii?Q?27XjXn9kgJlo9fHuirNylIhxtXWVg1vRJYgdTuGZ+xpfhG6cKLSz6L3HlEy0?=
 =?us-ascii?Q?jpCwM7kop8PTCt/bahyYi0UtOPVIIIpgCtkpUZwH4hX6mIofG4zBmb0gsyr4?=
 =?us-ascii?Q?qtI0k1pkzEoOrstRS3Soq8zzWbvYBp9qkD7eaqEgim3BDe2uEJww27d0PavV?=
 =?us-ascii?Q?w1AFhrJIty0TL3tEMONX8jBrRiAS6Au54CuEVBX1pTQQFCNdul7FB89RpCtI?=
 =?us-ascii?Q?LF3eLQP3wASMSasP5Wto9Rv6cFocvOruhC0jEl/zmC8t8DcUNu/MQ5oV7P3j?=
 =?us-ascii?Q?6clMap15gE0sNxPACd2O62An9ZYub85HJ5u2M0k+5ol+N1qvtMJRRbaGNEUp?=
 =?us-ascii?Q?XS/zh1Fuv6okOAyJLrcmjODNpZKs6r/P9ItfOY206mn7JlYQBWlc7Oa6VEZA?=
 =?us-ascii?Q?7c/ccZsQH8k/51XIO4/w6tH0ohQ6cdhITVOVZotUr3Jmin+MLJUCnIRyvxqI?=
 =?us-ascii?Q?ZuRZiWWgykwpq9ycKWKtj9MrpavKR5trzBZKF/DAYlR/64nRNORlZkVBCqMQ?=
 =?us-ascii?Q?r9/xQ/wKggR4WF6uLKGKUZ/cQgL0tYTniMF/MdsIFJg735VNId1SYm+oFdEa?=
 =?us-ascii?Q?zHppxFxgTMauEEzEC7izQ0FFq8JXKdP4i7dOhwYttGeYhAcsJzOJkwO07xGC?=
 =?us-ascii?Q?U9YISaBOcLCofpOwrrbn3CAo01ELlsjIskuM0AJR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uKQm5MDfaW7e2TmifYgWJO8XJEm1fxOY4790Io3tFFPNZsFnGii2Kdl9BY87JQOfMMJNlJnrLHOvQzZa1NjSABgIEr91ThpVZQbaKtlCBpc2zIqgwpRwFxLwTemADyGb39VdIO8Xi9+eXNqJQ9ylYvzonz98R3kOjnTz7tJzWonVimfBndcremCHruCOAfRp4fx5sF08kL703gVj1R2tFgABuHbvCQSWVWiAfZB0VNMPcgTe17BUXlqVIUF2/2VOXNfFDSoQgO27RFuWG6G5cH5WRof0bbcDL44W1P0+KGC7ppQJmRbxa0K2CNQmQZzmINdO4XBQHrOhmIz1AI9erHfgRF2MYBlXrY2XfJGY+iTlEEibbKIGu3zd1I2svsNz8Txa6wptKDjagvvcgfGSuJvCp4hZK53gOnKU56ALK4q++a9r2SjTHaygTBHObv7EkKcwn+RDQ+POc+AbNKhzYCnHxcULvLPXSjpSS/COaow9DBC5HVTcp/m/kQa/rbSfMK789AqyspdwyTK2DDYC68S151WwbxwmgUJd2nw4ViOQKuSrMmEiCIzXWpyiZZb1rFBTKNbiWQsPnSVwNQV9GcFW+HNOGCkzjDeNwWooCT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13496501-0eb7-4db5-5eaf-08dc2e9522ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 02:15:25.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUQlu7GHIR0KftShwRKjozRAa4ke0LWljYWjEJT5oU7pdCkXET40Mw5wvVvN0GF5Bq4Zvh24X80ugbidCsWJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_01,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=619 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160015
X-Proofpoint-ORIG-GUID: PnHu0ljv_RQAoqEm0j-PNGUKR1ehIywC
X-Proofpoint-GUID: PnHu0ljv_RQAoqEm0j-PNGUKR1ehIywC

* Dave Hansen <dave.hansen@intel.com> [240215 19:30]:
> On 2/15/24 15:13, Rick Edgecombe wrote:
> > The mm_struct contains a function pointer *get_unmapped_area(), which
> > is set to either arch_get_unmapped_area() or
> > arch_get_unmapped_area_topdown() during the initialization of the mm.
> > 
> > Since the function pointer only ever points to two functions that are named
> > the same across all arch's, a function pointer is not really required. In
> > addition future changes will want to add versions of the functions that
> > take additional arguments. So to save a pointers worth of bytes in
> > mm_struct, and prevent adding additional function pointers to mm_struct in
> > future changes, remove it and keep the information about which
> > get_unmapped_area() to use in a flag.
> 
> Indirect calls are just all kinds of evil, especially when Spectre-v2 is
> in play.  This is a really good idea.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Yes, this change can stand on its own I believe.

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

