Return-Path: <linux-kernel+bounces-74894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0C85DFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224591F234C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C369D13;
	Wed, 21 Feb 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5fHncw2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uXTThvIk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025481E4AF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525887; cv=fail; b=dudikmY6xM7ZTHpsORdzXekXx6UgVGb4469OWrv6/X3NALEQVNHGwE+uX2Q6zfSDyeb8pwdPDF6uARQ7pqZUXZd5ZBL+aNfEVDcEQn1eJDkLZEb7wg5NMdqlr+DBuLnOJqqdqrWE1LsGdGfQDCVeHTe2aKSWkO+vI8V1fs1vrmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525887; c=relaxed/simple;
	bh=XJzloGbS4wSiWBnb3nJFbubTMb9jBY6FfI7Tfzaifls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HrUJMmTfvjsyO+/ew+z12SjS8pk9D0EziYYm0DvsDo8udiQ5b488j4z2E2p6/VHMRUjEk9MRH9wzBSkF7Kn6zcO6qsz3QIgX+ImwZZqpatOTKpVYyA8iJ1e3BW+GpStiqJ/N4zMs3GRWtb0ZMUiYI/+OnAuvfp0XXnXsAFhOvIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5fHncw2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uXTThvIk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDikKA012070;
	Wed, 21 Feb 2024 14:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=FwfNvpkWzqoW7d7bWPslK7MWNzO2z9jtrK/5pEHhKzA=;
 b=D5fHncw2E8ny+3P0mVmgWgb4wVYkFVYDKeDeqPoX8pNgSS73EfdgEFKc9M/7QSV74U4L
 7aIIm90RJf6vkJYFYrFnb9ZkTCywS07fcGI+ExTW2aLA8kdQ3/F48NsmozkWcdFNMpyu
 Kj8UssRry49InrI1t6BVL6AkxyCi62rCjzVjzZmsH0k/SsqVPwU8Y5ReYLyz5rbi015j
 tVYt6ry6zyoQzDiNGhvgwQOBwVB4wGbiasGbqygsnr5lAMnMSOFcNE68SWU50sWk3MMA
 IhH1n1hJ3VXyDeygwsRJ3w0V/WlZuwPKCNca32XNXiedTsbsRbY3VjrY1t0EZAtOzqfp wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu1vja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 14:31:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LEIK5P012979;
	Wed, 21 Feb 2024 14:31:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89243r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 14:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjss10Vf2hZb+JXAb/pa1wPEk+HoLkMqB1Pp6pXuimpXdcIgw9nEtnnc5t2bWftylTw35HExohwGI1U9OwkKdWK5qB2BNOZDhkbNBzQZKMSdtOsSe7equzqH21vhb6P0gl+IIUFqKucg5JqSo/sSU827Ih4qi28Qq6s/wwjXMSqejIpypFbjui7o/2pf1vpB9Oo66oX+OeP4X+0HmGvLJGsj/LuyJJFbCy2/5ew7m2Ug01ZYQXWEH/eodoQ2Go7+VNNHVtK3YCdT0FWLXODYg/wfI3D8M9AQfbIWuQde7AbZKG6eui6s4QgXPcwPlNYIrgqgdUTNljnEJmf+GKVv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwfNvpkWzqoW7d7bWPslK7MWNzO2z9jtrK/5pEHhKzA=;
 b=OEIaodbpnAPIDEOH0JlenRRxBlGeN+F9GUB5nVIWLMUM7nkPut+PuHsaXybkH72pOOgCxlGCldU7DIEIg8vEdnCQNkzkHgNLUEcOjgS0hA/S20YP6AWHS/PHfkgDmXFVUVPe7JQTBvF38ijDdAgJGawN7WFEItAHogmKJLOWQKXaxsrk8OcDBY2tOiZZp4yy4US6YU7ijUJY27F+BeWepjTLMcH6WzmMJF1gO9LdhQhYCvZykO07+gB86WyBnX2mBpEOPPaRuoZbrjJMl5sHedtMcljj2/EOpNJypG/zGRG2FBv6jXCrGfb+BM8AZnGAiV3NAJBDXHjbPifQuBFCEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwfNvpkWzqoW7d7bWPslK7MWNzO2z9jtrK/5pEHhKzA=;
 b=uXTThvIki3ig8jKg2TEW6WpaG8m/PDeawt5LL+6qAXpBfxzksm1d+B3Vo5fzHzUDmAUlkXhjkubN0lx2ucQ/h3+wDNHVcd6e9yvv1HGSI39BJmLm6xzTM9INi1hc+GPIqE2GdMApVVURf4GzliC3m2WYjVEqVDPaS2nI5AJIYd0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB5863.namprd10.prod.outlook.com (2603:10b6:303:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 21 Feb
 2024 14:31:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 14:31:06 +0000
Date: Wed, 21 Feb 2024 09:31:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: convert all mas except mas_detach to vma
 iterator
Message-ID: <20240221143103.bkhewpq2wirsoyqw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	vbabka@suse.cz, lstoakes@gmail.com, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240218023155.2684469-1-yajun.deng@linux.dev>
 <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
 <20240220180603.dhnthx2nk5455opm@revolver>
 <0ff93990-b8b6-89ce-0174-4023599059e7@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0ff93990-b8b6-89ce-0174-4023599059e7@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: ab573bd3-adac-4bff-277a-08dc32e9bce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tF+Ypc6smhEDZ6F9zsztJV6gRe2coPAo4Gv4Cob7pCMcSP8qPkOryJLHrCrdapeDDcMnXoNyMhkfL9PeLGtq6Ve0VaSyASi9u5yPZy4/uqAoqR8XvOZ/PoN3E+wXynd98b1DziDc7x00O9+5olzTM/G9NrOb96INyIJoiCxykUzehKPtzVlBG0y99blguRLwLM6bGBsJWdOJu9t37gnHZ4ZFsGe7I72O+jb7Lhft+wD5I8j7i9/Jxw3im4aNn0sSueTAm8cOvS+u0HMVDXLHNDRuCGrnr2QhoO3IvrEwzo067br4s5k3WLsM5NjFjl6OX5dt/boTUXOrv03DJGcA6PUzZ8JlMu1JpQxxJsGMtEiZJGNOCnLYphSJlY1cElW2jsi+9j0d+uMYGkIqymZM61BG0Lo3m17mbv1wpkMHluajKWpCx6fQU1Pg9e3vtpQMPVFraXLMxQ8RpMa4gK/DLZCJtr1FB4USFZleF9Gu+MqK7Rhw55i4rwy7XDVPfQhcGx8Okg6rvRjFbiSH850TncJlUZegiLkpt8CFh7OlJQQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?5P6scnQYmqQPMNqpatHm8/M4pGCqggkgbc4zLjtpiXcAdg4/rjLrg84CR3?=
 =?iso-8859-1?Q?X65DRHfiadVlCPlpIxEyFg9cOcC/n6M3RK6uT/fZdrMALshbkJrny9jNX2?=
 =?iso-8859-1?Q?0q2lS+981EIpfSliFziHGdxcO1i0OsDNr4V2nmpu5XASB7wzHwW3+NmJ7D?=
 =?iso-8859-1?Q?4RDSRGoXPsM2rr/y/Xo6S/iWThvZV/EiJTaypPYRmnkLMx5BbThkZ8sseA?=
 =?iso-8859-1?Q?aSJNoAYYcm6rEyZuPbtvtKNTikPOUJNlVJGKdWw1lZ6KY0HbGbprMYUVW5?=
 =?iso-8859-1?Q?zYeQM/Ht/kSXpYnXny3t3i/zBLbbTaZj4XE2FHhOmMAGyEoIOE9X5oSaNX?=
 =?iso-8859-1?Q?f+KwQpMYx+FB2ub9eqVFyf9lpaRa55DiWOX3GXTdfSGnNHLMxG6xkB7Ra3?=
 =?iso-8859-1?Q?SgC9rHhqXmJ2s3sEaxfcieDWOVJjUJ+5ixDGNavf87tJpVdE4FwFy8NHeH?=
 =?iso-8859-1?Q?7JUriXJ3SyENPPfnwPTezYkE97vJuujTm7CiWGDc0HtUS7Jgqkts78damM?=
 =?iso-8859-1?Q?z/n0GIMUWNii7RebDZutPC9O7UWtAt74/YTvmdRU3J9YeJVRMUNXot+LPi?=
 =?iso-8859-1?Q?kUy33xacRYShuk8D8l6LWS/7+YoE7dkRUkUcDdWhUToFC0Fr8RVkIuW4Yx?=
 =?iso-8859-1?Q?/BIgPgiHWY7QG1kIJJLOjvoe1r5FFCuExJju7ra6y1afYN7QM4vij9amxV?=
 =?iso-8859-1?Q?VuggxiQlqfoTbQA36pQU7E0KR3UIPGXESUeAzyLLm0IC+xLphcwKvze8Sa?=
 =?iso-8859-1?Q?K52IW2czVKQAtOXmPqkk3+g5R9EocI+JholveChcAHGpwnW991QgJJ+bZp?=
 =?iso-8859-1?Q?K3Y7x//glUZZjV0Q6GFtMvYada0M+tFz7qHm8oLHIBP1HwrmU0B5Jfg5jk?=
 =?iso-8859-1?Q?HK4jY6yrAeK3wptyAuh3JYAZzCBO6Mo4VkK4FHK89s9Y4Y9hN9uyvr8Fpc?=
 =?iso-8859-1?Q?HVV5mtIY7iypw09n1/GNSbCI4mvpJL/7qbqxpf2ith7K4549+IVEzgxGPa?=
 =?iso-8859-1?Q?NGptgByc4LmB5UqzGDGPKy/ZfmhCoEoHWSE6X44f7Zr5qUMxY4KP3Kjod+?=
 =?iso-8859-1?Q?lLsn3nndD34wFLJu0GVqkasR30+DyVbrXlNSLpPAWDMcuSt8XH6oTTj2B8?=
 =?iso-8859-1?Q?I1UfNszrtISKeSuDTlB2kQq1gBvG5pwIGZAqZvoE9Lwe3LP6I4VZgZye9r?=
 =?iso-8859-1?Q?b4tMdQF0L87iZZkQ8P0HpJ36Kee3C+Ol1kG5/W/KZhLYygln4dUJlYnYE1?=
 =?iso-8859-1?Q?wr0AAyAoDgaDP1BNhekc5r07iKHQRo6GAhMd9k8iysZc78QWcGNbT8cqto?=
 =?iso-8859-1?Q?tpnhpeeLDutZe18XEQoWdedMv4EcD7MBbk9JYgE6wVg6EIwyhXm5dNoHit?=
 =?iso-8859-1?Q?XR8oakIyo0/RWMITZAevw4m66WcCYvToApcmX8Vkucved1cOzhhCUFM5e5?=
 =?iso-8859-1?Q?sFVZ1DFC1xw2A0JDAiOZ30olLPzDCpPSy5zSPZG1zz8fr/GWZ8ttT1h5QJ?=
 =?iso-8859-1?Q?9GgLRONEmfdyqVdylUoekeCf2+7Tue+lzxU1dkw6/+xs88ND5Sj5oIebqW?=
 =?iso-8859-1?Q?avN1+IizPrSFMrF+bMU/eowwFAinc0OoBpHRb3EPLtgvg9pssZ9GpS8glD?=
 =?iso-8859-1?Q?L92TTV1xdaxvQRZ3Iui17TgJdrNq/pMx3CMt67rDgGfD9aS4CHWV6P1w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ACBLYoH23xxKTNcH7ToTOxx1/Dffmj9B6Cn5pGzgFabr7A5vMygnc6oKJV5IE8Zaw0sNNIg8CrOghzsOV+3ayfAC39SHBZWWO7oKrUAD+dxMylVLKGn96UuHhr+o0UpgC5bTKEsA0B9n9EIeCJPVRITFXwrJ2XeNVeT8Sl7aBnMQsg7MOYICIKmFYGprjmK4oYCQlaEcBugXVlwK7eLsQbpPpceCEgrIaBkQU+RtISAc8cVkRd9U/ukpggCGJG/uWxedXp2qWj641VgTtBNnLI9wIzK2VV867QhU7GEc6gZThnXN9wh+MVPtC7uK2CSf+NzpMH0PP45s8eXvdG8y2UN60b7K3wRd6nFbSgnFI6g8tiiTv4yJ198YzkvxzN7nnfxrpkO+R9rKdak060SybRk4phN8xJm225772parcRcMGpcp2rIt/1zlWJM+TMoyTdxeXr3WRug8Xq5pyQd2nHLNJTAH23zCUbgv0Ly5co8o71KqHt0PU4Rx0lOXwJNUx5qfodvJon3cClW7edPcnu9Tva+9zHNu+qyllBhMyO9Ag9JNFBX6pNuFFHrw4NdhDKDC4chZ2WuvaMwdaGsjFmGnak5tCKUjwNORMiMoxmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab573bd3-adac-4bff-277a-08dc32e9bce7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 14:31:05.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDJvgIwG1ETDO+qHoExCm+AJOZG9S4ijw7tzqPxTtbMDgpBCBOHkjWsUhDenmWN9z6FzBI+3XYsys9ncqD55Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210113
X-Proofpoint-GUID: H9Tlzgn5kRacNfawBEYyXLxPYnZ9AM0p
X-Proofpoint-ORIG-GUID: H9Tlzgn5kRacNfawBEYyXLxPYnZ9AM0p

* Yajun Deng <yajun.deng@linux.dev> [240220 22:26]:
>=20
> On 2024/2/21 02:06, Liam R. Howlett wrote:
> > * Yajun Deng <yajun.deng@linux.dev> [240218 21:30]:
> > > Cc:=A0 Vlastimil, Lorenzo,Suren
> > >=20
> > > On 2024/2/18 10:31, Yajun Deng wrote:
> > > > There are two types of iterators mas and vmi in the current code. I=
f the
> > > > maple tree comes from the mm struct, we can use vma iterator. Avoid=
 using
> > > > mas directly.
> > Thanks for looking at this.
> >=20
> > I had left the maple state exposed in the mmap.c file because it does a
> > number of operations that no one else does, so the new functions will b=
e
> > called a very limited number of times (as low as once).
> >=20
> > I think this is a worth while change since this may be needed in the
> > future for dealing with more specialised uses of the tree.  It also
> > removes the 0/ULONG_MAX limits from certain calls, and the vma iterator
> > names help explain things.
> >=20
> > I don't know why you treat the low/high search differently than the
> > mas_reset() and mas_*_range(). In any case, the comment is inaccurate
> > when mas_ functions are called with &vmi.mas in places.
> >=20
> >=20
>=20
> Because the mas_reset() and mas_*_range() only covert mas to vmi. It's
> simple.
>=20
> But the low/high also covert max to max - 1. It's a little more complex.

Ah, so the code doesn't match the comment, since the code will still use
mas directly in this version.  This was, perhaps, the largest issue with
the patch.  Having a good patch log is very important as people rely on
it during reviews, but more importantly when tracking down an issue
later on.

I like the idea of removing as many mas uses as feasible, but we will
still have a few that must be passed through, so please change the
wording.

>=20
> > > > Leave the mt_detach tree keep using mas, as it doesn't come from th=
e mm
> > > > struct.
> > Well, it's still VMAs from the mm struct.  I agree that we should not
> > change this for now.
> >=20
> > > > Convert all mas except mas_detach to vma iterator. And introduce
> > > > vma_iter_area_{lowest, highest} helper functions for use vma intera=
tor.
> > Do you mean mas functions?  You do pass the maple state through to othe=
r
> > areas.  ie: free_pgtables().
>=20
>=20
> Yes.

..
> > > >    retry:
> > > > -	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
> > > > +	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
> > > >    		return -ENOMEM;
> > > > -	gap =3D mas.last + 1 - info->length;
> > > > +	gap =3D vma_iter_end(&vmi) - info->length;
> > > >    	gap -=3D (gap - info->align_offset) & info->align_mask;
> > > > -	gap_end =3D mas.last;
> > > > -	tmp =3D mas_next(&mas, ULONG_MAX);
> > > > +	gap_end =3D vma_iter_end(&vmi);
> > vma_iter_end will return vmi->mas.last + 1, is what you have here
> > correct?
> >=20
>=20
> Yes, the following changes 'if (vm_start_gap(tmp) <=3D gap_end)' to 'if
> (vm_start_gap(tmp) < gap_end)'.
>=20
> > > > +	tmp =3D vma_next(&vmi);
> > > >    	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev=
 check if possible */
> > > > -		if (vm_start_gap(tmp) <=3D gap_end) {
> > > > +		if (vm_start_gap(tmp) < gap_end) {

Thanks.  This works and the variable isn't used again.

..
> > > > @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_area_st=
ruct *vma, unsigned long address)
> > > >    	struct vm_area_struct *next;
> > > >    	unsigned long gap_addr;
> > > >    	int error =3D 0;
> > > > -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
> > > > +	VMA_ITERATOR(vmi, mm, 0);
> > > >    	if (!(vma->vm_flags & VM_GROWSUP))
> > > >    		return -EFAULT;
> > > > +	vma_iter_config(&vmi, vma->vm_start, address);
> > This is confusing.  I think you are doing this so that the vma iterator
> > is set up the same as the maple state, and not what is logically
> > necessary?
>=20
>=20
> Yes, VMA_ITERATOR can only pass one address.
>=20
> >=20
> > > >    	/* Guard against exceeding limits of the address space. */
> > > >    	address &=3D PAGE_MASK;
> > > >    	if (address >=3D (TASK_SIZE & PAGE_MASK))
> > > > @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_area_st=
ruct *vma, unsigned long address)
> > > >    	}
> > > >    	if (next)
> > > > -		mas_prev_range(&mas, address);
> > > > +		mas_prev_range(&vmi.mas, address);
> > This isn't really hiding the maple state.
>=20
>=20
> Okay,=A0 I will create a new helper function for this in the mm/internal.=
h.
>=20
> >=20
> >=20
> > > > -	__mas_set_range(&mas, vma->vm_start, address - 1);
> > > > -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > > > +	vma_iter_config(&vmi, vma->vm_start, address);
> > The above maple state changes is to get the maple state to point to the
> > correct area for the preallocation call below.  This seems unnecessary
> > to me.
> >=20
> > We really should just set it up correctly.  Unfortunately, with the VMA
> > iterator, that's not really possible on initialization.
> >=20
> > What we can do is use the vma->vm_start for the initialization, then us=
e
> > vma_iter_config() here.  That will not reset any state - but that's fin=
e
> > because the preallocation is the first call that actually uses it
> > anyways.
> >=20
> > So we can initialize with vma->vm_start, don't call vma_iter_config
> > until here, and also drop the if (next) part.
> >=20
> > This is possible here because it's not optimised like the
> > expand_upwards() case, which uses the state to check prev and avoids an
> > extra walk.
> >=20
> > Please make sure to test with the ltp tests on the stack combining, etc
> > on a platform that expands down.
>=20
>=20
> Okay, I will test it.

Testing this can be tricky.  Thanks for looking at it.

..
> > > >    	mmap_write_lock(mm);
> > > >    	mt_clear_in_rcu(&mm->mm_mt);
> > > > -	mas_set(&mas, vma->vm_end);
> > > > -	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> > > > +	vma_iter_set(&vmi, vma->vm_end);
> > > > +	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
> > > >    		      USER_PGTABLES_CEILING, true);
> > I guess the page tables still deal with the maple state directly then.
>=20
>=20
> Yes.

That's okay, we can leave that for another time.  I believe Peng
complicated the internals of free_pgtables() with his forking
optimisation so care will need to be taken and should probably be done
in another patch, another time.  In fact, hiding xa_is_zero() within the
vma iterator is going to be a really good thing to do, if performance
doesn't suffer.

Just don't state we are removing the use of maple state in the change
log - since we do pass it through sometimes.

..

Thanks again,
Liam

