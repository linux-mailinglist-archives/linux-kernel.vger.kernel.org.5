Return-Path: <linux-kernel+bounces-99217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E3878506
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548011C20854
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAC5A7A3;
	Mon, 11 Mar 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwvaN78O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H6raxL7I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4053E2C;
	Mon, 11 Mar 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173905; cv=fail; b=TVntVT7qo1Q85BZeZbku3RlKHsXBd9D8Z4HA6Mou9yvjlKPuVHSZgJwqX4pFebKCRYYau4keclJH0fziJwPQ9rc80rM07VUvCXNrLVNVF01T3f07agVTf8dnMN1gGroJofR4mO+FuFIfih8SuPVGDZ4N7ratETrSRDkoXzAp2KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173905; c=relaxed/simple;
	bh=kga57KGDd3uGN1KIsPUxvwYk3AQAOFhd4PtIaHzhgaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aL/XR1qcTefvC9dDhDM+gR+bygSk4FcJPPH38/QjsyCFle+t+KnRiN5k3gUWDzv7jEuCZr8igorzh6ZinXGO9D7P2SCOrfy07hWAn49w3v6l6cj6FHYoh9JA+XFbSy525IrVoc1ffLi1r0QkvuVo96w8sZwEAh+mFHvvLy1sANk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwvaN78O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H6raxL7I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG3qGZ020986;
	Mon, 11 Mar 2024 16:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GdMx9S252HRyOhcjzYKcAQBpoXbxDQS1Ca6pWTdGfJM=;
 b=iwvaN78OUIjFNM08Or0A7hQQJOpAkoHyYX6sUFH2dDWa9zXfc8lHu9nLayuudmDrQd6V
 w8gtXoEbY1Lzsplx04q14UkqokEcjD9/8A2LVwn/HVgFIG6JXf5KsoyJLB1ozwVW/ULb
 3VsbKAfrEjNv4C8rS/kVh4EQ5DLrvbGO3B2C0T3V4w9i/VUMViHQhJGTdzsnca7h9rtq
 tgXdbrHutUwGa8pVV/7FTWT6MIjhqBgS7isljWUGNCOwjeiuizOZZirEHgIczhzqB6eN
 QRJuDX9BpAUyrlN4RScvndCF/xIa6Ct8XJliIYx8jWt//UG858C8uQtQGLsTlhfSbWvI lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcubsjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:18:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFdDPu009129;
	Mon, 11 Mar 2024 16:18:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7c6hvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrBeB9Q9yYhENNxIL73J/KRmM+0EMLSl4zYn+z4tso+BG+HbQVGG85rSKaOEBtyy0uydpaUZs6ilRuBq9DZjRo1WJ3LOmWc4/ODargPXeWEZsc+e1oF4zpSk0OF3q3wgPZMi37+9YNHe/uIO3Xt8w14lESfsDXOLSjs68vcK2CRIym9y4FHaN2LAqT54bNkY+gIPQ/m3xQm4q2KzIuOlGhKkTYEy3ILMDJ/jraq4vTVOBcWKktG482aJYbTeYRm1QYNxT8shxOIcoQ2AuTfaJFhhLG+uh9Q0pdw6EoKYg3u1hlNKIOsmU0sNQ1rmZgygN70vEnH8HOSBBh2hc+cxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdMx9S252HRyOhcjzYKcAQBpoXbxDQS1Ca6pWTdGfJM=;
 b=GnACq8AIZPL++UIs8a0PbPeMPutSzkTnkILDo6akSTyeaf1mfe7a3e3qNnK4my1O3njI6cDSiVo61YTcZW09kiKSFuJ3DTNa0vEFpZIK/NC6t5gIYWiITNE5bY7uNbiRtC7srUhcsPx1drVslwYLYOxx3sfLrTYuAhh4ePgpEe+5sLLjQVmB3UQux3p+dc3YbsP9fCENnQp80TG2jFIXr8K2vzFxoG75UKiLbXXGkkGRGbegjW6sC0WIUnQW0ioGj3/x0BQZp6/Wxf2T7QiRLO4VNlh1EOf5LvZbMsXRx4Fjvp2AEMRbwv1jiEsjdWs66m1nOO6rDgwXFS1vS7FYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdMx9S252HRyOhcjzYKcAQBpoXbxDQS1Ca6pWTdGfJM=;
 b=H6raxL7IedfCYR/RJVIlXPxtGxLquhNbojdG0wKIX0jyXUDjPjsz0c4XxcxmP2L1criaU0s1ns2yvAYOcKScibODIvwHiNfVuxsjM0ptLZMPFYO0p3qpezptKsF+pRRLpIAjD6pSvYI6KfLwcplp8mdQwdOzkzvtYkeepEujJ/U=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:18:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:18:11 +0000
Message-ID: <3e852dfa-6d21-4c68-89cc-43343d07e5e3@oracle.com>
Date: Mon, 11 Mar 2024 11:18:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
Content-Language: en-US
To: lduncan@suse.com, target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, dbond@suse.com,
        hare@suse.de, cleech@redhat.com
References: <cover.1701540918.git.lduncan@suse.com>
 <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
From: michael.christie@oracle.com
In-Reply-To: <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: ff282fd1-7fa3-44cb-a91b-08dc41e6d8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7moAPMqH7hCim492vBtVDmQIbGNuKA1zZFWhVHnuwHv0fY+37Bg6V908de8fFIGGJBYhNFNEa23XapaEcvzPn6+0jFGVmdp8ommRq7t9sZP4k/kESSsdFGxfpr8idAvnGhPmEiu50yPcjhqvzMAgvUu59nwBUE8UopbzrBfUCnDVI9p8FsiKcOe6diyqBxscfhcuS/ZAvzGe3zTpFwg1o21uyV5oHfcM85ZOkoouewO7SYSpXkfQ6cwcWvM/DS93JHBkzwzWzzMNVAUsbcl7d2JLxhrG7nSUZ4oEoWYzOfKPcx8lfusgIuBE8UvzhpKl8YPW24Hke2ZHB+qFfF80SL2X8naZRfiT3zfTEVur2X8uIhSzKB0UfaB9oIymRUymv0at5+bAeFxjT90Ap0ChB9NUrLBeevd4Tc4mcarN9SK/BDOt+074qxGojyhqnHnRzOsFMFsZmUIb3MQ9YusJg+qvJvt0mLDkHkxPkDHG7cxQK6NbFgaG1CL6guiGWjXju/aBlaQFB0v54zlcrZVp1qD0e4oHWzh+pU9nY4ST0KpT9ikF2C64xuUR9fWdZ3sJomIq4Fz2jYnDiMifJ58Q3+roNB6ok6OtlAppAOVe0vB1tQK3oUtAV4WT6FH16XA2TyYruI86gsTu6l0LHMwqUwkNx/zsxjsUbgfEHCcAGH4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlZVZE5JTXVuY21zcUh4QmRWQmR4MDFTNnF6VlRjS25ib2tnckdhOTJobWVO?=
 =?utf-8?B?bGFrbTBjYlMwczhsK0ttZkE3eGNhK3JnZUtBMjRraXYwZHdneFdqeHdxdkVa?=
 =?utf-8?B?c3lKZXJGZ1NyRDFQWlV6OWFxTjB4WUVNaGY2YW4vREErQW1zaXhoRkhoM2Vz?=
 =?utf-8?B?RThNci90Q3h5ayttb0p1TjY5clZXOXFua1BudGRCaWtPM2xNbzB6YzB3ZkhW?=
 =?utf-8?B?TklSeHZFN0RRMVZORGFpOVBITjZBVVIzWTJ4elEzUERHU1Rrb3dFaEZQNVpy?=
 =?utf-8?B?L0ZERHNpcUlKdzBGQ3BDUkJpcFM0aUZYUFZIamxSMkhKMUk5MlpsSEVOUUV3?=
 =?utf-8?B?M2sxVUhteHFCbG9CQUVWMU1NaWJQZG9wbjB2M0VWVEkrdHJhalpRSmV3bENY?=
 =?utf-8?B?UVJsQ0pNRkJpdnpGeVFGRDZ2SURkNHRKV0pHYzRlcW1WRGxPd25jdmFYd3Bn?=
 =?utf-8?B?ZFJ6d08rQ01XOEx0b1lOWTJGMFpuZmxjRGFQVFM1RGt4cWtVNWdQNkEyV3ZY?=
 =?utf-8?B?bk04UXhIUzY3MjFlK3VEaGdzak1EQjhkR0c1UnA3QjAwT3p2YmZpdGgzTzkw?=
 =?utf-8?B?TkpXMENld3BBekcwQmF4UDZISzlSYVpXWnB1V1d6QklGYXNNZXlLSVRrRVJT?=
 =?utf-8?B?bHB6aWVPMHQ0QWNpUk15bDZoRUZPeGRlWWp2a1hRbGUxOWVIeHR4VlhVNUZD?=
 =?utf-8?B?SWphbUVFL3Z5SXA4emk4bFdNaGxTSGJHZGVoS3QrYUxOZlhXOGQxcXNlcUFo?=
 =?utf-8?B?TDM0aFdvZUhuQWY1UU9Fb1VMaDJxVWNtZ0lBYmpDWFhVQUgwSGdqRHFyc1BT?=
 =?utf-8?B?OWh4YWg3L1VDS0o1R3QwOGg4V1o0cmh4MTJYamNjZi9FMUl2aFFsbzJaME1C?=
 =?utf-8?B?dUlVdFVLbDc0bUVzOVBnamkrYXhjdzEreUpxUU1zSzFzdjd4RXduODM5RjI3?=
 =?utf-8?B?dUFEeUhIclhsRE5DY1hTdGU3UXN4ODZ0ZEYvNVlmNjRYL2k0RGwvVHVHM1lw?=
 =?utf-8?B?YUtBYTAySnBPQU5NZ3J4L1Y4dEZwQy9OeGhRd0VGTWV3UmdzWVRlUndHNGNT?=
 =?utf-8?B?aXdKTjZSNlM1QUlxaXVBWFJVUzY5VVZhVVFaWm5IQUVuUVh0aS9PZ1ZlSnRr?=
 =?utf-8?B?SEhOUlVKeDlQRkplQUZyWVhNNWJLWEpYN1pwblVxa2ZlVk1xeE16aVZPaE1E?=
 =?utf-8?B?aVhyWkpPNFpVd0ZlZ3lkZzBUV09xcG9PNVVGMi92cmZwN3dTNDJpTkxqbk05?=
 =?utf-8?B?bGlyS1NXNUErUStRSzRlU1czZGFVQjBqNkhEWm1ablVIZ3hXTC9aNjFKZU83?=
 =?utf-8?B?TS81RTAyYUxvYWs0MXF1c0FBVTFOdHA0VVRiZUtGSXV6NmkzdE8rZ0JBODVM?=
 =?utf-8?B?UllFRWdoRUJxb1E3TytCc3d5ZUQxSzNCNDhMWlRkZkpsNTJORW02ZFRhbHp5?=
 =?utf-8?B?NEtvQ3l6dFNyZVh0c25VOW54ZldMZE1yNHhPS0FzVXQzR0xKZS9jVXg4QmRa?=
 =?utf-8?B?RXFKNmxqZWpxMElpNkI1TEs5eGlHamRvQ1RTNVhVa1VCeW5hMkdJVit1OGVo?=
 =?utf-8?B?V1RRL2xTOGttYktCbE9xRkUwc0NsZUtLTkx3c0NWUkpFMHdCUEdwWEtZV252?=
 =?utf-8?B?Q2tWQjNrcTlyUDd3STdpZUR0QWI5azZjVStHaEFVL1JtZDZDV09ZR01GcUM4?=
 =?utf-8?B?aEFNQktac3l5b0Z5N3d4WHNHdmxpNkRHNTUyZWIvVnIyOUU1enQ2aEI1bGtE?=
 =?utf-8?B?dTBZSlhPMW5rRG1tSHROdkhOS2hVVFFBU0FXaDUxQlBqNENOOFRhT1JrUnBq?=
 =?utf-8?B?UWZodmZwb2lkTmdpY1IxOTY3a0RBeTQ4dUNvcm1sQ2VtbUJPTWlpZjRDZGMx?=
 =?utf-8?B?WGtVaFQzcnBMT3JKRjR3RnFtL2pUWHRjdzcwazFCV0l3T1hmVTgxRDRaV3Fh?=
 =?utf-8?B?K2JobUJBZzBuYUZva1RIN29pSFpIdXVOWkx1cVcvbnRaZHVURkxtUGd0cGN2?=
 =?utf-8?B?R3N5MGRwMis4TThad0ZNakJ0SUY4OW83ek5wNDJwSEdZa0UydzY2QURvd0hW?=
 =?utf-8?B?ajNwdkZ4VW1uekhiZW5tNmhGTlBHS1ZhWmIrUm0vOWwyckt4THEwOGJDSUdy?=
 =?utf-8?B?UTVyN0c5RWtKeGI1M1BIcnQzZGNRRmgwL2hrOFBaby82b3FBdDV0QmZxZmhC?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dInuXaGtCb46D0Vns54kyYuKxvSPJUR06I8Mi/82JmwlQ/Qb5FffncvWGYX7TWe1bWquu0f9L8v1nPUUOmrJt0Xo3o2Y2UrRXz7wKdQ+fUJN5Yc0l+7c18F00jKgSymMpD2sY6q0Jdmgj9sVhrBvSC99m82VNC5FYMbtfFpNTkuLb+wkSAwk0ITXHp4qhGkmUjKIPQtjTtUvBmrefsX/iPYKJmkUU3iCQWRvBWm+rpffU7MrRE44+iz1g7b2KkUgRsoEilh5nywJL90L5bZ15JFsnBpF3FdYT3N591RWhVZoXf7gATdygT50VL7hvs8PodkIFR5b3rAi7AtJ2kso7i27q09VYJKX9wZWTZluMStjSlG46OX22J6vw3zF7pI+IylrS2XFQ3GooDw0ShPg0vFbQK4I3zik2NDHBmixMznHzp1pmRayWXbgwVOAYXT3hsvl+htw07BJsNNrHWpJv23ZKnkHgjHVftCpvzW5oDiVvAQOvr5PDFmi6i1sghg6Pr9ErtCn+IU2AGjVxx4il6geWEAGWW7Uj8pdzlyeHuMHRjsPVv4OPVFRWscU/IGK+zrzmSCSMFf6S6e6m95fRsSNQxGEKgJwGO7cHa8LBgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff282fd1-7fa3-44cb-a91b-08dc41e6d8a0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:18:11.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn5imDps8uZSE/yg+9flDBHp/xJcekPgV+QMTFTzSXNk3TNniXNrdf6qncjQwuxONAuFl0LquhENgFAYc3Xrbg5pUijk7zyMWP9Qwn3jFqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: Nj1xwh48OKdcK9_rwheWnfsxRbUKB8AG
X-Proofpoint-GUID: Nj1xwh48OKdcK9_rwheWnfsxRbUKB8AG

On 12/7/23 11:42 AM, lduncan@suse.com wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> Some iSCSI initiators send SCSI PDUs with the "immediate" bit
> set, and this is allowed according to RFC 3720. Commands with
> the "Immediate" bit set are called "immediate commands". From
> section 3.2.2.1. "Command Numbering and Acknowledging":
> 
>     The target MUST NOT transmit a MaxCmdSN that is less than
>     ExpCmdSN-1.  For non-immediate commands, the CmdSN field can take any
>     value from ExpCmdSN to MaxCmdSN inclusive.  The target MUST silently
>     ignore any non-immediate command outside of this range or non-
>     immediate duplicates within the range.  The CmdSN carried by
>     immediate commands may lie outside the ExpCmdSN to MaxCmdSN range.
>     For example, if the initiator has previously sent a non-immediate
>     command carrying the CmdSN equal to MaxCmdSN, the target window is
>     closed.  For group task management commands issued as immediate
>     commands, CmdSN indicates the scope of the group action (e.g., on
>     ABORT TASK SET indicates which commands are aborted).
> 
> This fixed an issue with fastlinq qedi Converged Network Adapter
> initiator firmware, trying to use an LIO target for booting. These
> changes made booting possible, with or without ImmediateData enabled.
> 

This is taking me a really long time to review because I've never looked 
at some of these code paths.

Have you tested the error cases?

What happens for a scsi command that's marked with the immediate bit and:
1. We get an abort and
	1.A The scsi command has completed?
	1.B The scsi command is being completed?

	For example, if the command we want to abort is not in the window, does 
iscsit_find_cmd_from_itt just not find the command and do we just return 
ISCSI_TMF_RSP_NO_TASK so the initiator will just escalate to lun reset.

2. For lun reset and abort, if the scsi command we want to abort/reset 
is not in the window (let's say it's cmdsn is higher than max_cmd_sn), 
does the iscsi layer complete the scsi command then complete the TMF or 
if the TMF has a lower cmdsn than the scsi command does the iscsi layer 
complete the scsi command then the TMF?

3. What happens for 1 and 2 and ERL 2 is used so we have 
ISCSI_TM_FUNC_TASK_REASSIGN and maybe are hitting the out of order code 
as well? Does it work ok?

