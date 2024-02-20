Return-Path: <linux-kernel+bounces-73757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92085CA97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8DF1C21869
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904515351C;
	Tue, 20 Feb 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eT3i8FGn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RjP4Kb1B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E21534F1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467726; cv=fail; b=u/nlIDPlFE9UYgKhaRXbSTcb0iRf7UHf1e7eVtFjAJBpZpYxh1O1++hLSqNGmIX/Izm73rh0vn8A2QdHxJN2ucH9xekHyLd+RFZ3GuY4unNDM0tRucrlaN6wcsxv0g3MLNmKKoEly7E8SDmk9Y9H+xx58vjwBYv4SyiKeMRWs58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467726; c=relaxed/simple;
	bh=0obA/3gLRcOZxnWa5rdu2ko35LMs2Ub56zzzhY9Vjnw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=S17af0CSNBmjSUO6iZ33g0FMitq2YqbtQI3dmGuuEePAuPWVZZPGEwuRZPWkWatMoQlxow9D7wNlKVAaZbMu9yN7N1eOc+6C2nlGY/cJIRsEF6DchrBIE9pnp1QZVNGGXFFYy0yc2YfYNb4ehVhZHQy3b4KOIdu4rNqAaBJ/hQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eT3i8FGn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RjP4Kb1B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KM7hBK012464;
	Tue, 20 Feb 2024 22:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=I66ZTTpkmGgt2PKKDJnqtcVYKZOb1TewrW/u3TJ0whQ=;
 b=eT3i8FGne+Rn6CMGTT1VNdIG7lZm069xDXK5wcfYNxp2LbP9JxRHS5SE1v30lUBXDTlP
 qewlXhFpTzx7EaPu/GMkdN2g2loj/bCLuIDe9L0NY+28vVo9v0FFX+dDh64Mzs1WkQ21
 Z2EWDd6XDkBmKEcSUKSz1ICUFlFN19uc3HFCjcdeWzS6SLRPcg4bVZSaTA/ncr7AmYiY
 HfBvMZTVpe7uZhA763XR0iOo/Gn8tv4CymsBzeqLdU2RUJJ49amFBgUnK2W/U0xxW219
 0i7MJRWzKnWfhQLjSutlwMvfoFvf0LDD6BLQs/h1FfWkP2ykCqgqtFAQ0uOW6Bd9UbQX 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knr0v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:20:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KM0BDB013069;
	Tue, 20 Feb 2024 22:20:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak880pda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkTQXuOCtj4FuWPR9A25QXlFH7jAUxaWukcRDiqTW5IzI6bxJyYqLpVvLwzz4nlvGcMHQbZDegUp8XyGno4X7z1VDiUYdKcN9+9Du3bcu26AZ8b9DNXqMCjI5bNSbLWvu83ReqR7XidpxuoWcXBdS7bbhndi/rdKW4tjW4NwF3yvZnsg8JFfPzqo6l+gciJ55hfbFiiIE4jCCs0awqK1GkmT08302cem7z5lnvk/jRgH2n9w58qBQoXC7jyWhLEcAl38Nymgr0zXntrZHJHlDe9dTGvr7jEG9SXv5fKafe80Dy0z0M85fTYMLlYK4ZQoM8Gdm2yq+a1U/d55n4Umlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I66ZTTpkmGgt2PKKDJnqtcVYKZOb1TewrW/u3TJ0whQ=;
 b=VMBRpjdqpqQ6Y+BIDG7coOJIQy6rr7qTAowTXdKLmGnZVpriEaX/wlyMIEgGJuJLmwaA4tYAEwQVT1wzcHdZXlJIbezGTp1r/gCuChehcFUy0p+BFuWCL2szXBBJeK8ekAYlQTOrGcFBqTSJ8y5oTjxb0FE0Y4o39r/2tirb0OcIqKtrd/3ZrlcQsio6ks7bKd2ejKrHTYnWQ4Ks3AvWQs/j7zhrgUL8uNfDRZBbJymaasTk3s1qbD5CoHCMloB+E2nGmTLX242BMAsqELlFlyEvnPrimLpjCZR8D9cAY1QQAb/+PKIOxlrlfgJQEhyktZIfMdawk2B4WjTwnnkgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I66ZTTpkmGgt2PKKDJnqtcVYKZOb1TewrW/u3TJ0whQ=;
 b=RjP4Kb1B9dD0NO9xdjkGYqauoz0fqmLwUpoOek1sQzer53FGqlxpN3SnW58O8ET7RCcel/Grt1rnoIBiIYuF8VwYbbAFsbaeRKVD7lk85E+3PLeZGfn0NA2eBcS+olOU0Cn1y8guRvpIrbvjmkXnOynVW1Xn0oJYIqygxA6J47Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 22:20:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:20:53 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N> <87v86k8opr.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
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
In-reply-to: <87v86k8opr.ffs@tglx>
Date: Tue, 20 Feb 2024 14:21:16 -0800
Message-ID: <877ciykc9v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f930e9-974a-4a65-92d7-08dc326233bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q4ZeD1Y0MtPPCBii1SpMZG1CHKd5iGsZWulDqq3Jk8/5eBG9MPhHqKv9/aOc7tdfgwW0UWP1guMg6diggUivss4CQx2akJcNzXmnee1E4GjxOd3DtHolU+jxDM/nrJZlya0tuWPtif01lTmyP/C4WR5StyH+Zvly3oBu+Jz6ND+gXl37jTJRQo5rtaLzRBOKHtC+nu3drO+4FWRXii+KlXvo3062SOS2XSro9okhtv6jd1+Pt9HTiGpoprNbsA8Fj7mxnhUrZ/chcWbC3m+2end+K6xuYO6mgXX9WuWmrbsly0peUQHbUBsZz81PgICQggeWoVUAig0A3hevruqSeNiw49CrXYfV0I0uGfRM3+yDzxKyJXuMO9lFOx3AIhbHFvtARkX5kty8Ylf8kwmH/l0Ut00nDHhre2lrVfr4MON8u8j0iSF/MN2rLNEKxWz8URd0/GPWL6kxJmI7DEk4uv7aBOxaWsAV0PIP/AgjFpwPWHL4Cb3Mc6ieaVCcZjCNaiOYpa1mncWLoIBMNPEt+a4/3cLnkLmTQ54kPh7e6sA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kCYeTnhsJIx3CNALPYJV7HVDcjFXTx09pKaJ/zOjqI9d2Fo5gw34nR8KPHqR?=
 =?us-ascii?Q?1kxZ3mYuyxUfiPUoG7M7Js5Vn27IFU788XfNJnYb2fsGcDNfp9Ou4O5ZVkRo?=
 =?us-ascii?Q?Pdp/TPWejd2zb18cSLoedP5tfOZdVbgaIwC/xBKkWdeb/DvLapPEJo2SoEnZ?=
 =?us-ascii?Q?WWEurqSqqNFOkKS3GhCRSHQRecRIZl2zrnMbJii2diIpq1nrtC/DGj8XRqd7?=
 =?us-ascii?Q?L4psLCAVOIc3GEc0OTaetnrd2WWrhWT7aeVUc5lZ1kL8V9ONKtFOaJVyYURm?=
 =?us-ascii?Q?KMVKvK9JwQWpMWSEARPSZNV01RJ+kBX7dR4iOki+UoaZcbZJoffoSQ/esUFQ?=
 =?us-ascii?Q?wv6jVY524roApwBN4nFEGbaM2GvID5PqVcgSDvTDNQXC0PGK+/viVl3XEQYW?=
 =?us-ascii?Q?7+wwQgZu6mXX/OOLhuR0gmvT1r3/9QJmzp2SzsmrbDVSgth8HU64KIuZKPb9?=
 =?us-ascii?Q?KNQ2ciJHj+rhfXCsOrdY84vY/pBqVXkUsVHkd8N6cQeqCRpgwY9byLPVDQ5+?=
 =?us-ascii?Q?81JRaopsV+3bTf2B7p479rxP6PUZi1fGVCg6JhVuRFV8xhN3pzt6jJQwdIHg?=
 =?us-ascii?Q?GsA9lJjA4lH7ku4kjItYHq5Mh07HAYFKsNCN98f1Oh8/yRzeEUTJXLjdVRTV?=
 =?us-ascii?Q?hSmXzuGo9FbEq4iKEMBqZpknFjVmIQh54OoVyX9JsGg34a/24/682K88vdu2?=
 =?us-ascii?Q?QXuAeKu3mZ/72iYR2Ac+5WbajMhDIOENwM/sxS8e/Wju0sVlOWxbI6gdJIv5?=
 =?us-ascii?Q?ZzWdmi8FxWJWWMKR4uMI0VJ+carw/nJL+6n0N4IuE2mLcFhEXW+6gnpCRsfq?=
 =?us-ascii?Q?7gKkl2AMKVBiFeHmdkAIzRigwP4Zu4iWxzl6S1gwKDZjU3YwfTjek4c4aDFk?=
 =?us-ascii?Q?7v6+YIu95n4ZowRRwPuXHTwmD5+2QPfA/GW6XAV9QvYiFl4nUDu3x8kb/48x?=
 =?us-ascii?Q?3p7Kbw4p2RLh+exjLI2oDnJrEeopAlp/FsdrIX7y8hjos9o1yriGC7fH+Efj?=
 =?us-ascii?Q?eT/xDWigC94516aQYyRnPfq18ctq/LQ/FwambKV3+N/vEXQO7JTaXlFxiIwN?=
 =?us-ascii?Q?YAsxrEUQ8bUShVWZXyqBvdmVO54/MKYIgEZpED3F3zDYDdY9A2clLkugIBCH?=
 =?us-ascii?Q?gfriH+4gDDGit+PAy5Lmo8VF1Gy6VMwFlISVI+3rx0EaVCCIOH9titk5gMyK?=
 =?us-ascii?Q?fwIIdU0vW68uqZXCUWb0rF7kmb1Ikcytv4pxQmQhOzIz7AvIMDh/hxDUjsB2?=
 =?us-ascii?Q?ozVcpptZUotO3DeMtXRMk2kXMkGYpWWxSyRNqttUFyIPBYWpBT7o0un2unOT?=
 =?us-ascii?Q?/+7zWPVhPAuAadSDEWliYDABv5FPKdO3wbl/VSQLNv38M+LeZqKN1sWrw2h3?=
 =?us-ascii?Q?TZwbZoTKysZw7z28mOOX7ipF4QpLTnx7UvUlE1IMXNG1ACNA/DCYIu26+QvD?=
 =?us-ascii?Q?V17JWKbYiIxCRdhubG8N3P42CcNebOwwvTS2Z1A+QHK/z+EJIRyB+Oe5Qexw?=
 =?us-ascii?Q?dMcFgd8u1FIm9JbraJWMfw1xtL4YAer0S/IVGc8BlHnL87ENX45fhVbygV9l?=
 =?us-ascii?Q?lXyO8Rm2XoXlbIK5rhre96Z97wQ1xwncCyI4E9OgjtOKKyV9VXyQYUyyjbw5?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5JiUz2gGu9C7rvh6wgU5ZQD4ndA1NVVN79ufBIOTz27J1qN8NwUZQQAXkxFFmix+68d2SPdCVAmY8SvJdbqF6iwk3mcl/vmBk1eYBiBTtYj5e6BzXIcMQKxFJX3Xi31JbxNUo8uDwROGSm/v/Z9k1t2G8tNMf5twvEeMU8FoEuH0v2x7ienBPEeXF7wcRPSl0h/OkOR01P5GphqWffN9+V09YDKuNelRi3bsx+AP0vsKpOe5wpQGXicimp3/DbQpMmMFe0HpROO3xry1xYDgG7vSRAmjEE4cYsiWYsEG0pMW80JwgP16g/j+sU5JFWjJcFu83fPSNbHnOL5A8v99q9pWh6tftmBIOS+Usg3l3vB6TXAsvnUNa9o9JWL2sBTqsBXCyAOzARxwxsxXURkhOC0T2SwZBQJYZIOP7YRgKF0q8LfpPvAyaznJF1bl2L3seYfi/LKQ84cTluvM6nPELHSBfD6d9hnqizxmaT98yFfFA0OKxbX16gtrmS/v/8OLBIDXO6d9KoCEHvW6q80rosoGl9MxhnWaBHNH+1Gkq29u+Cmzj4M2GrbSt0WIAmSGhJhxWdXONovLBfgFB2fD3S5HZjKSGeN4sS8r73MlmHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f930e9-974a-4a65-92d7-08dc326233bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:20:53.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+c6yFl5cG2mO8R64YxqyfDsH+nihQKBELC7rk5bKiYbdTjXF7G3YDTj6GG8TopMWGZikbFlIjxBWsTQlCsZ04z6XuNia16xOyrnX3r46EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=915 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200161
X-Proofpoint-ORIG-GUID: ngQfYKIMa52U5CFFUT_s_YETUvIExUFi
X-Proofpoint-GUID: ngQfYKIMa52U5CFFUT_s_YETUvIExUFi


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Feb 14 2024 at 14:08, Mark Rutland wrote:
>> On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
>>>
>>> -static __always_inline bool tif_need_resched(void)
>>> +static __always_inline bool __tif_need_resched(int nr_flag)
>>>  {
>>> -	return test_bit(TIF_NEED_RESCHED,
>>> -			(unsigned long *)(&current_thread_info()->flags));
>>> +	return test_bit(nr_flag,
>>> +		(unsigned long *)(&current_thread_info()->flags));
>>>  }
>>>
>>>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>>>
>>> +static __always_inline bool tif_need_resched(resched_t rs)
>>> +{
>>> +	/*
>>> +	 * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
>>> +	 * as TIF_NEED_RESCHED (the TIF_NEED_RESCHED_LAZY flag is not
>>> +	 * defined). Return false in that case.
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>>> +		return __tif_need_resched(tif_resched(rs));
>>> +	else
>>> +		return false;
>>> +}
>>
>> As above, I think this would be a bit simpler/clearer if we did:
>>
>> static __always_inline bool tif_need_resched_now(void)
>> {
>> 	return __tif_need_resched(TIF_NEED_RESCHED);
>> }
>>
>> static __always_inline bool tif_need_resched_lazy(void)
>> {
>> 	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>> 	        __tif_need_resched(TIF_NEED_RESCHED_LAZY);
>> }
>
> Yes please.

As I wrote to Mark in the sibling subthread, I think exposing
the lazy variants outside of the scheduler isn't really needed.

Non-scheduler/non-entry code only cares about checking if it needs
to do reschedule now. So, I think we can get away with just having:

    static __always_inline bool __tif_need_resched(resched_t rs)
    {
            /*
            * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
            * as TIF_NEED_RESCHED (the TIF_NEED_RESCHED_LAZY flag is not
            * defined). Return false in that case.
            */
            if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
                    return tif_need_resched_bitop(tif_resched(rs));
            else
                    return false;
    }

    static __always_inline bool tif_need_resched(void)
    {
            return __tif_need_resched(NR_now);
    }

(and similar for all the other interfaces.)

This way lazy and eager just becomes an implementation detail which
which seems to also match nicely to the point of PREEMPT_AUTO.

--
ankur

