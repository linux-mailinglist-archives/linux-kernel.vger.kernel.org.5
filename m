Return-Path: <linux-kernel+bounces-42956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AF840941
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364C3B23C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB91534E6;
	Mon, 29 Jan 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYMuWl5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ys4l7xWl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5351534EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540687; cv=fail; b=AA1ABXbfaEyRnD8J/3VZzc9aoYqhjx8aCAff0LFgIO1pAqocP0mmKbYBHPfifQEBHrNIjRbF3u0Wks/U14gKKCbw5vQ/u9k1hkZpzqhIjGBKLcalPzoJGGX+bC8maxooZjB0co6Hx/Fze5qIRzmbJumlGaSb06ZcOZX+qSjg/S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540687; c=relaxed/simple;
	bh=6Ixlz67VdeaGEKuCASMs3BEiIxKlmcsUzPTCZNTDwhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ls0+0c7ax2C+h16teDbIfmMS4jhPOe9Nprbp6cP9463jn0xgS0Uf+nwpk/jEnZdMNmQCfHagCAOkH55ma9l3htFsIIvlS+PMotDlsFppUaQWFMvgyoALukKGjksfuASZB5P0i58M8obqsbq9I2jpXTWn1u3fkO333fEb/pVvNqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYMuWl5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ys4l7xWl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9i1oo010671;
	Mon, 29 Jan 2024 15:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=/eGk2yo7ThL/+TK9iKuQ3BxCoRbkRTva8vHg2uWHYpg=;
 b=fYMuWl5JFsVeQBAkz4mB1AWbgpOy5+G7tazrzykgMsP8C1UeWFE85NuXeysvaPIcrHpf
 +Dszflx0rIvQWvUwu/maJ4kxDqeAdi39IgNtClzflurCjQk7k7k4nDGRjxxeWLWcupzA
 emzasbGwqcz8/2dXxtcWaLcY/h3Kb5zbh4waTe6nqhgIH2PmTKJMU8ATM8a2EnxyZVGB
 CIyoh9Eswe/k/gUUhREx+3sAe9keczE22qBS9hqYowWEXL6CJaJJ1iPgux0SjIb2GoeA
 euwPruAN9ExfnDPzZ3mlyq6gG+S+Td6D08MHjbCJJP7kaCQiciGySaZKyZ4fEBKIXdCi 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3v4w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:04:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TEhg8x014626;
	Mon, 29 Jan 2024 15:04:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95r6vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFKQK7lz5XzKur/LeFqPx0G5qpSezxQ5FJixRdfFFZPW+CzIfyMlzwgffsaYRDDzEh53gd3usBXJ6qxxdo+6mf7y4XGZy/Haz3AOo5zXZNy9IQQXIDWv4vAWZmHFeLLYc4bq8DGTCPFBhBdytNUfSa6TQKmdo5HfGdfM6i93eAxIRVYmBQkFTFL8BlGufpJhk2AmT15mVN09YH8LCM2uU0pEZ3mhIQA/xXeaEOSDGOZzDTZLUwc7OHlzw3rIqZRbVfx9Q9Ra9wWbrmBO1gpkgIWK8ZTAfEh26B3L29/50vF/51GVGtLQ35wckTN7NL5ZUNgsoV4i1NxEniUr4GTG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eGk2yo7ThL/+TK9iKuQ3BxCoRbkRTva8vHg2uWHYpg=;
 b=WEpGRLR9AuA9jSAitd4FYInUWmWGuqwT2tj/9u3uBIII0WLL3e6+qWfwNvDfsohoI273MbVeTUq++DrreEApbx5WxbkY316/nn8PXbJ47wgKqLwyt7TcwCAKv2fot4S+XA9bMMReYRLqdpP9i75kLoHhsj3eEb6y4ZQKCFC9oF3Xl3k+znGRWVKnWM+XWYGCGeVQLlo7q6NeJsAg2E7AoDAMbcrsgFVRPugfl/CVEJpxk1KhlX9tAkh1hvtQa7xYCRCxGlWpBv7LIDrg7wAEYWl8V+GbG6DWZ/jaLAP6y8Njo7SRVrFFsWZmV46Rjl8vCeTTYDh8K/8aKKCrpHj3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eGk2yo7ThL/+TK9iKuQ3BxCoRbkRTva8vHg2uWHYpg=;
 b=ys4l7xWlJ5aa2E4oumMI/FJRhsusiSkm8ZmzY1xXKS3uW4a+RQcUDMbADM39eQwp1ZFD4RGa5NiCSJ+VtCXKUh+SXafjhMVF0YIRYe19I1rw36iqpWrWgpcWd/XENY+PQzezvCq8AMVsm9O0PJyzATTPULmlRB/w/IyDnLNnFEc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 15:04:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:04:19 +0000
Date: Mon, 29 Jan 2024 10:04:17 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: remove the mm parameter in vma_complete()
Message-ID: <20240129150417.3m6jyj3ftdh6ka7x@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240129075305.3512138-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129075305.3512138-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d77d96-b29f-4dfa-e056-08dc20db9176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g7Pts17/2unDmNJeVGRJx+QtSUgq/eRmQm0IewNrnYS5cmgxc1elE65dTRe/v3akM1HXanw7UgSuahmxSSpfn3Igwiu+ePm3jZxQOwjgOVPCuN5GscgD4DcLd9/MMCW3rvXXbV3Lc1kShZuPErO2w7KbUQ+X78EHO8L5iG+16dukEFAUU82p0kysOTn9Zv3fv9PPj3JczIzzMqAR/h7moqT5nY79mgXXeAKjGMbvFeJdOpnUhdJDVpirb2cxGCntlU6x3Qko/JcN/+yHizWbI3Yc+yNGPgDOzoRRHsx5mjQY6IbozD6qUmRbtmA7fBuPmEQr+4jArmylzLjohAPQwTzwP5XMWssYNQ3mg7/hwkDhrsAS4BRUQ2gDibOqfcLqeujH4/bCpWPKpOYikly678kblLzljpymP30BYqCgjuKyMN3HLYCj5JuE6aeIztrbmoEJjWWBeq6ALqF7/uXMBABFf7omEslCuy8HDzF69T8OwMtXeT+Opxv8kqbKQ1L8s70/u/qN9udHg0G7FAG5tYAXtd0JjdrOMNWq1um/XUgu9qt7u+24lDjSPNuq8Rtb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(86362001)(83380400001)(26005)(1076003)(9686003)(6506007)(478600001)(6486002)(316002)(66476007)(66556008)(66946007)(6916009)(5660300002)(8936002)(8676002)(4326008)(2906002)(33716001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BUg4RfSl9PlgeHihlCE8pXedqBAXb5Ic6f7TuH18oNqlyrOagQcLxaPUSPxu?=
 =?us-ascii?Q?LrIrn82DUmlV9AVtKsMb86OzvD/UZFjTqTcJJB77ohkmCJkKYzup8nK0p9tc?=
 =?us-ascii?Q?RVpjjWZXQwkzxiJbhqWp0+U6t11Juvh+s1xhpj9aPmDaBwPLQ+fUcAq4TlN6?=
 =?us-ascii?Q?jgn5SJS2VrNpAYpZ3EK3t0F5vLcu075fTquiDVjVU412HMqp9nNIFu8LI3HO?=
 =?us-ascii?Q?h/M18flSbhlMMtdqr/4BuNQ+5doUzzqSrVoaYpUw1BaxrdHZUnoog01bN6f4?=
 =?us-ascii?Q?nXZFQYVpATOWUSLU++jU+OGEveIlkAKHS0jD63L/p+DTIzdEzkzn1AQeULnA?=
 =?us-ascii?Q?Mkq1/L/H7wYhFmb3uoO3qMblbTJFR0MuXYSVEEMwK5JDH1jteF0ebEvHTOXg?=
 =?us-ascii?Q?ngUgmwrc5up5hUbevY2b5KZzPmWfz0I/rh2H0MfvtCSMZeUnCGOA8FxKKG1k?=
 =?us-ascii?Q?6jl9ZwzioeM4PuG3TkaivAQyD9ShIGGLC/9Ez5BEBpXMann7uhTHxy3JjANF?=
 =?us-ascii?Q?FFbvpZEHXUkveTY+FqRZW4Tfvcz4sZV5kS/cCa8oWgQiFP9AZarmmGKizOF7?=
 =?us-ascii?Q?ChK8FWtBF2Il+JT4dqUZmvUzo6cX00F7IneP2r0irg8t+JvhHZ1reuI77YQ3?=
 =?us-ascii?Q?ZYrK6lWd2h0RqrkwP4ZxLA2UGMJUtgwJi+pTsSM8O9PaRrV27HGCcKAQVgjd?=
 =?us-ascii?Q?rUupNNC5qtUXHanGLey/475c/ePUyeHZfEEpNN1SlXt7ft6ccZtgFrT4Iqvu?=
 =?us-ascii?Q?oBT3umy3IqSJe9c9EFDBjqKubThFpwJ1EZ24BGnb+xGFThcQz4WD7bH5OCAL?=
 =?us-ascii?Q?4FzF2dGbRNEbUweaTzYCtygukV1SpEC+leCEugK/CQYlVKfJBMgvLfZAf6ua?=
 =?us-ascii?Q?zHtscfM+IWiTCAYShMO/D6xTTG2vzojDu0O+b3MsW4DNLEeS5lPH5cobwxSr?=
 =?us-ascii?Q?W6UN7g2z7Tcf90yNM904Piai15OgM7RoV6/k1fYNPmKidZuXdHh52EB4BJt/?=
 =?us-ascii?Q?hDWupez3LQHayLRX6qcGB3Dqyi8mZMfdlwZ8v2LqHECOf8pKr/DEVCMMLGQM?=
 =?us-ascii?Q?oHF0Mki+aIZQkCvAEao1ItRU4UHFTfG1gt0MsK7HhyaFfGEJsU9ZVznk0CFG?=
 =?us-ascii?Q?vjkzwQNUuNArDtFBvS96e7eCnJosF9vu1TAhbDEgyiOJ93/0XLK6Xe5EI65e?=
 =?us-ascii?Q?PfpsHmWybyTcc/Orp1YT7KFaLp8xiZxvLq4+C2ptQ64mv8KLLU9raIWIpcem?=
 =?us-ascii?Q?XPS9DNbbxkEirw+qbyl5ksMxO3I0zcghQoJYYromIw/OqfaD1yGryQW2STC/?=
 =?us-ascii?Q?JrvHbOCUkoOaS75LpmHCREXx3HlVqnvw9O9gyn++ec7sLktJyVVk3/Qdskb6?=
 =?us-ascii?Q?uiABbxk5PQqIiQeyBlb+o/mZC0+TAeKA8kG5OJge8RP5ryXV2+wDc5tFt3wm?=
 =?us-ascii?Q?sCIHrMeaeB1BeldQ153dBSSqwlcUQCPrfaSB+A06C9DuCvrqoUcfyfkuQySB?=
 =?us-ascii?Q?FtfbICo3L7XM3X6eKyepsAnuihQnmgDnJMw0jv8efArpa95YvYqqBkAWa1n/?=
 =?us-ascii?Q?qwK9YaEZy0lmP/8in/2dc+ZuoOXwG8gXlYz9pF/t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hac1Z0TDOSBgqJ1onH54LCPVINT+B0BgGj9nqncG1/cW+x12H71Lk1hGb4xRcJ78OzlG01eOePqXF0zfIDoZLOR08PlCC3L6Uukd7zGB2mWy8WoLatSY66yUh1Nzelvf/fMKEFZD1Y/GnUximf69E0uRD1VP8wI7kMyC4QuP7xIjVUiu+QaeeNftl/xQhWzMtcCaeVH2585id15e/vtHe4vGfsMyu3GTG3Y5tmjdlf4hPhkboJjjNr5rLrHPshBociZT/E4YpRb3Sxcbchl+cm1rQq+4b3yzbmKNilDX1mjBJH4yH5C/9zv0vW6YFAzZkECXMUlW9+sMXnUM21qys2z9Jt0y3DVkHcetgdM0S2+/27fxs/c4mvkyp9XEp9S9BilMu08hmuRXpU4LGPCgG8Lba5LGMUoyVDb8/fXhRrxU6a9t8Fq9peUubStnbFlRThy1w2JE1W0f3vkPfAGlyMWZcid5/wdD1y2l7PULMLkTbcWpZe41+a/Z9cZ+8CT49FqiSvD9H/LsLHGa3yl99nl0z6T3aH7TICkQXAsMBsu/eJtS+8Gejfp4LUf+xj8AQmCHOjinxXRbvIGta3PkZ04zXZ1mo97suKWrYXLf0EM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d77d96-b29f-4dfa-e056-08dc20db9176
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:04:19.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt3oetM/aMwiVqRL9U/w5XIz0W9I42JzAV/TFCpEwwRsuOLKbDTjfz6Wt7Es1teyy5esMcFZIwdHWxGyHSGfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_09,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=732 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290111
X-Proofpoint-GUID: kzWntR_a6owViJECwzDzJngZJp2RlIAJ
X-Proofpoint-ORIG-GUID: kzWntR_a6owViJECwzDzJngZJp2RlIAJ

* Yajun Deng <yajun.deng@linux.dev> [240129 02:53]:
> There are vma_merge() and do_brk_flags() pass mm to vma_complete(), others
> would pass the vma->vm_mm. The following explains that the mm is the
> vma->vm_mm in vma_merge() and do_brk_flags().
> 
> All vma will point to the same mm struct if the vma_merge() is successful.
> So the mm and the vma->mm are the same.

Absolutely, they must be the same.  I don't think vma_merge() checks
this, but it is true.

> 
> vm_brk_flags() and brk syscall will initialize vmi with current->mm,
> so the vma->vm_mm and the current->mm are the same if vma exists in
> do_brk_flags().
> 
> Remove the mm parameter in vma_complete() and get mm from the vma in vp.

You have added a dereference to the two paths that don't need it to
reduce the argument list from 3 to 2.  It's the same number of lines as
well.  vma_shrink() is only used on process creation, but brk is more
common.  Note that this function is marked as inline.

I'm not sure this change is worth making.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/mmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e97b9144c61a..9b968d1edf55 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -509,11 +509,11 @@ static inline void vma_prepare(struct vma_prepare *vp)
>   *
>   * @vp: The vma_prepare struct
>   * @vmi: The vma iterator
> - * @mm: The mm_struct
>   */
> -static inline void vma_complete(struct vma_prepare *vp,
> -				struct vma_iterator *vmi, struct mm_struct *mm)
> +static inline void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi)
>  {
> +	struct mm_struct *mm = vp->vma->vm_mm;
> +
>  	if (vp->file) {
>  		if (vp->adj_next)
>  			vma_interval_tree_insert(vp->adj_next,
> @@ -666,7 +666,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_set_range(vma, start, end, pgoff);
>  	vma_iter_store(vmi, vma);
>  
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_complete(&vp, vmi);
>  	return 0;
>  
>  nomem:
> @@ -707,7 +707,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  	vma_iter_clear(vmi);
>  	vma_set_range(vma, start, end, pgoff);
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_complete(&vp, vmi);
>  	return 0;
>  }
>  
> @@ -1030,7 +1030,7 @@ static struct vm_area_struct
>  		}
>  	}
>  
> -	vma_complete(&vp, vmi, mm);
> +	vma_complete(&vp, vmi);
>  	khugepaged_enter_vma(res, vm_flags);
>  	return res;
>  
> @@ -2377,7 +2377,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	}
>  
>  	/* vma_complete stores the new vma */
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_complete(&vp, vmi);
>  
>  	/* Success. */
>  	if (new_below)
> @@ -3145,7 +3145,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		vm_flags_set(vma, VM_SOFTDIRTY);
>  		vma_iter_store(vmi, vma);
>  
> -		vma_complete(&vp, vmi, mm);
> +		vma_complete(&vp, vmi);
>  		khugepaged_enter_vma(vma, flags);
>  		goto out;
>  	}
> -- 
> 2.25.1
> 
> 

