Return-Path: <linux-kernel+bounces-62967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150A852870
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C07E1F24C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA11CABF;
	Tue, 13 Feb 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gfdY5ZVB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ji9zGoEg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9D17C71
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803825; cv=fail; b=kIxiYt0EGYlBRAm5RTdw39J4016o8poQvKh0qaHteSM5YF8zPbUzdkOE6uIyimnB1nYGpGkV3TJXkTic+Wn3ldmfj3VQCWhUxgGHiEwi2L2wAAYIunNrHe9VGQlRmpPPua8fT5525c6wPc/8fZ78SPnFUz46WElRiSf3GBxgU4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803825; c=relaxed/simple;
	bh=nyw0dQ/ITJXQwzcEChSoBKjNXJVRNp1RpUeC5ycZArU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBsRkY4sbfN+e05yu3NpMAndHtV0VcnhGAvG4yVkjF8iv7jjpPdj8rC1+Gc8tcOg+4EpvtU7MeqKbZ6uWJOEb5Gdz9TPDvKTDoj49WbE0D3+/1xsJhlywtks8tPyrQduI6GmnC1pc1QEQ3ufrCPhxQc08MaUMd0hpVWxGR6e1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gfdY5ZVB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ji9zGoEg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4xLVU031838;
	Tue, 13 Feb 2024 05:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=E5vV9XE+n5/oDbOcyagGXUgyXsm/0ns+qpyDQ3ZtavY=;
 b=gfdY5ZVBVzDC4v1oG3rvP4a16majEVVKtSoIIWQ/Q8f+EUcqDfTlt/7D+o4Gg9r0Y/1P
 u/wpjKTPb5MRoLyLpsdN9kQRSiHxS9xE3nCAGNXlygU6rZTRVfsljctOGDuChhrGBnin
 VCk5Jw5Lug1iF/IjrwCgJtsscKapZjDg7DSyBVyp+4kZtJYBhgfzKBLuzeJS/GbJkqYf
 B55U57Tp3TCOIWqwgAnOb+XVVzrWGceGwr9qw5Al91s73b4QXplZjxjOZ5IJWDbcXNuq
 YlQay4nJc4xuuJA4A7FPBzf3Y5pWklFKo0Knwh9cH6gv5xMYBfY33Pqmb033FhmLpPTA ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm8351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D40f8h031501;
	Tue, 13 Feb 2024 05:55:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6tvnj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EibWRUmxWJBNC9xx6FSnp5yWUWkkqQwVSM1a17R9Y0tsPM/ADzqTIJwX8jBhtYpdhMdIt31bw1v770ZI2N26ClJ4uf7MnUNORbTkZLMdJ50Pi3Y9oHa3xVgSrQFzcNdNfqVDj7/HutnQk+q0wcKT4V+RuJuNRuq1dT/uRBvE1Shrcw7iOSx0Vxw6EOufpR4CwrOlNsXVn6Qy7XXjlH/Tt//9jYJYXxxxZ83iG/43I9a4+N99JVfwU277bJsoK04CUNLqxlyhyPjZR/+MxiuzurjW72dfIaVke0P9DdWbKV4cB1mK0MLYg8eGHwYNpCQ6nFMZGs7wNmgAIN5Wrf8wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5vV9XE+n5/oDbOcyagGXUgyXsm/0ns+qpyDQ3ZtavY=;
 b=doLzOyNjp6F/+aoVbXHPTLLUF4dnxaWSCWftS0mAwK+6du740fUE8+u7fMWoHGX4Ded5TN2EvI/SQKRLQMhQz4AsM7sif4fxcRQEHN3m/NTNTeaCcJ/gcI0txBwL/wN0NaPLPdbA7WIjQ09bq8VBnnM3533LNhB82rBL6QbmN0NLLZofeBZwiUZN/fhbtsqk1fCAIjoPPCEQFWuI6sw7Oby6DgTD093sC7Qip3V4yrDawy5M5ACW7RJWKOABSUKm7+31l7amh8b6G4kGsQ8OCW4fA/97G5JQjXmp0quC1qLXeW2hMkwn74kjlMaZQ7qIvFfSL3c/R/dGDGutsmebrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5vV9XE+n5/oDbOcyagGXUgyXsm/0ns+qpyDQ3ZtavY=;
 b=Ji9zGoEgZKF6NL6suUdkQj7HsFFriJNPEG/J9EdJwJ4H+YGSikMGY1i0dgvvZHqCOqN3EAx+CMMx58X5mxIkQTtPScwSlnHZ7ftDGGLEnetCDvCMxBcTy3yYbtj+VTkObUfabHYxq0Q+pNPYHGW4V1gZWk9mXRZZm/7jsMHOBRE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:38 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/30] preempt: introduce CONFIG_PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:25 -0800
Message-Id: <20240213055554.1802415-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf215c1-cbf5-43bd-ea5d-08dc2c58673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WAwMQBJbZGrCVr21B+6LDMLVcI5/C1G0ZXOf86faWdSjuW8pJENmqPSPQ/oS6ElV6EHCx+qPGuJKGnFThVq+GForpUeg0OBNNMKtqpegA0TxDe1BRsGuFEVI+e248e5azCdQ+72xwLaevc3Qyh0dRDeaSsnrCUTNeS7QYgIK9bgeopQ0povPXyyujS2QuBXRXtXDNGWD0gNJaoW4Vec9qftKGw3qTMJ68S8UWz4tVWq5GRYqzcp7bIE3k8DiFECT4oZNS/S2TqYXH9XZbBHMt34eZaIwhlvJ+rRWvBhal5UAlK2+0KQu4QtA08Hqxqz1/jpA9Li3Jm9dGMODxQ93i4NUr55oLrcT7/TYaj8c96Oa1eqBMhWGX3PEKoXYcga/ZclS6hyyTG2c9mQG2XTH1ZKfpMpdBqSLj1rCjmG/SxIkICieEUHSBsSqN1zUI2p1Yd6xuKjlH8nBbsbx/I+npWkd0euuRIXn8AN+Pat2EFkXfPzQiExT14S04cn1T9wnmSYqUBZDH/ojop0s0FS2dUZArwpR7QlLt+hNVodOSPc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(54906003)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hZiI1xt/HTD+JjwqKZBTUgAlbezX9t7+P3v6ilpYOYcU6HV7XaHFvG51zbXj?=
 =?us-ascii?Q?LbO1ykpdZR0EZ3ZPi+4YFMpy2S1M/YA8Ph24JBprFaIMIeI/nW+T8lyj56eU?=
 =?us-ascii?Q?d5TWlw82zfAK0v6EWZ0/z0rBMxySQUOfif6BUqEswyvkUVRitS3bjZcAif27?=
 =?us-ascii?Q?WtXvSwO6W1CtGjfLU24I4RedYiv8tc4wzFnHzTq4eZqOm91Vh3f7soEPKhV4?=
 =?us-ascii?Q?pdB1V3TKHlBM7KhLVSgXsLubR7ImAHAKdX0Aqzx+zKNqTiqHCHG0irFsIU0t?=
 =?us-ascii?Q?ocsmU3wIQhHmngOIiBpcfQazvyOU4aBaabC97Gc+9O187M2N3HlmnDQ1hOl+?=
 =?us-ascii?Q?byKMhootmblXha6qeWfD9vpgNgGLisHU1IQ/fL1y2NDn9X0YcumK8FHmlrFV?=
 =?us-ascii?Q?NcL51OAbLVMTKNuGjkcZmwKBc0gSKK5LwC0BtzfZjomGdUArjzmvc4lRgwkh?=
 =?us-ascii?Q?CU4dKLyxA4YLdPq29byXkvKQItd/xwLVTYVMRbtVBfgB4RPqO1a117MzN8ga?=
 =?us-ascii?Q?JGH76HeW2S8vuHyTz92pKNvqnW4ywZjjk/mqr/khvQHCC2TKfeTIpq2mX7w5?=
 =?us-ascii?Q?2H6tafbBVU0zaOf6RsEzctpds8b1t+KF2yTOKCc2IXvR7lEgOn5YXV2c/1kb?=
 =?us-ascii?Q?DFr7egHuXi8oUB32wIzcoP6d+yiM1XRCdYegr73BuFCJmwzg+KWGaSAGzfGH?=
 =?us-ascii?Q?VtAq8f9WWM8iRMBPLGjOm7o+JScD/Vx6m2jwF+dfd0D4TQxTvV0iMDWXljNG?=
 =?us-ascii?Q?OjHwEVnAs5YDrj599qf/Dix7/1Fpr2kkIWD5zCcT1yo3uWoeGVPqvizlCALp?=
 =?us-ascii?Q?2N3l74/bhE/F0Qkk3+K+eGJO1K+KRzLnQNgZG7Pim4+ztwEvHFYZ/iuqtetz?=
 =?us-ascii?Q?e3atUnz8Z44dsyrch9kaJiPMhI2OKm0C7uHeSR+lhQkhrSSPLCypQ8TdglnP?=
 =?us-ascii?Q?juBgXzZa0Rn1q3ipWHvcJKP0WIwl74LL8tYuO+TQ6z5Ig4lyuJ681DD3Cuxt?=
 =?us-ascii?Q?Mqou0NPuI7n7YTZcmt2bB657NDK1/g0WXmrp34uZBMFsQx4VwcuMwuEWOxn2?=
 =?us-ascii?Q?Oy43bKfLntotN55sgQnY5D+TV6/sGDxvU1zhm4jpimZPpFjgsSN0yyLwRnoP?=
 =?us-ascii?Q?9Fijx43hTME9qruAIgocc9E/mkNt9zeZO1SlqhkDFU1YjUzDd2qEk/Wa9f6B?=
 =?us-ascii?Q?0TSt9hp4AokYoSUcUUmndaJ6LWOmnM8mB3G87O84tsBaVXdw1JgoTX2Lp9Bi?=
 =?us-ascii?Q?RDCXCfhd3AJDk71zBXISqcoTGblXidc9X14WZvxAVPQ+zuBcXbiaxiT6NolY?=
 =?us-ascii?Q?WRUiVk19Sj6Cl05qTo75CqFU4jgwczIExp4feR18cusgrE7gY9C6a6NILgpk?=
 =?us-ascii?Q?zb+5Z9wlNwOedE33W6mqnhT8gq3zY4FybUsHKJOw3wLBWbEPGXi64U1l/Lg4?=
 =?us-ascii?Q?p5rNYX2eFX/RGt4SzQTxVyr0UB5l0fJw7hUKAffuVo9DCTEy6/0a9cvG9Mq8?=
 =?us-ascii?Q?xY9jsIMxZtjH+336ZBiIIcCYSeKoLM3z6sZ0uXsj0xmrwk3Skp/4TFY1naeV?=
 =?us-ascii?Q?G8b+IGbChHPqR4vBFEl/hkCVJJluGcsfLa7yPOtx4wK56aSlbSS7OFXrustS?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KQQ8HBlWNiHhHI1iCH7pPNvgaSfikLhXoCkLWicwsqlvqiWt3oyuyeYoodr5yylA1CLVBH9SzxxHz1S1XTB7LX6yuPZMKI9tEy0Kesgb8h4ZZ7SPwNfQOHXyhNjxj6qmRy5hKTss9mD1P2DJV4zzEtxnkXOllzQ+DxlkewRj1PSjScvb8UqQ4vI8ei6uhzsHUnLmOOl0p5bm2QAqY2WI2zDqQ/xijWSFMgmeJ/Z0dICRVPoeCgqNvgmAmJkQh0eQQ1MEr3+68qUPSi/EVkrSTCnVlgV9WBO87dCewLHKbOM2mwdiznva2gS0tIdw3cdY0Hiun2bWfndWndCZpSQnccPsvc1PkJ3MHT/nxvzaIFsV6Tp0HaKnJnrDwR8MHMRezm6BFmuq5Hriw76bsmkML3HRLLowcVNXNyPv8Sj7urBfJZ8bVGOkGJZ+28Fwz/zkZuWjWZSSRTlL5C47TqNeK7/oSG4vmUVGcnMArwscIxLQHGss5LkDoTMhLhCzsG+ffD4DEDEiKYqcjp1/NbBgfE9KJuyFnb4CxM5hs7o1rcabyBGGn13aEMM24YUTOcilNtOFzs3fSHEU5ykMm7Jf/djLUm9jAp3CE+PcJ24/aXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf215c1-cbf5-43bd-ea5d-08dc2c58673f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:38.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZdxymuRNiWIzFTO/EakXI7rtQERB0CT5ik1T0OmYgVgO886RLYrX0ZW5eV6pexU4pziT9Oj07hKx9TqrfaqHVTCNKHHBS3iRwdcC02NK4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: PyWqVxLXTWfTmZsnaNMid_Oir7Ac7tcE
X-Proofpoint-ORIG-GUID: PyWqVxLXTWfTmZsnaNMid_Oir7Ac7tcE

PREEMPT_AUTO adds a new scheduling model which, like PREEMPT_DYNAMIC,
allows dynamic switching between a none/voluntary/full preemption
model. However, unlike PREEMPT_DYNAMIC, it doesn't use explicit
preemption points for the voluntary models.

It works by depending on CONFIG_PREEMPTION (and thus PREEMPT_COUNT),
allowing the scheduler to always know when it is safe to preempt
for all three preemption models.

In addition, it uses an additional need-resched bit
(TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED allows the
scheduler to express two kinds of rescheduling intent: schedule at
the earliest opportunity (the usual TIF_NEED_RESCHED semantics), or
express a need for rescheduling while allowing the task on the
runqueue to run to timeslice completion (TIF_NEED_RESCHED_LAZY).

Based on the preemption model in use, the scheduler chooses
need-resched in the following manner:

		TIF_NEED_RESCHED 	TIF_NEED_RESCHED_LAZY

none		never   		always [*]
voluntary       higher sched class	other tasks [*]
full 		always                  never

[*] when preempting idle, or for kernel tasks that are 'urgent' in
some way (ex. resched_cpu() used as an RCU hammer), we use
TIF_NEED_RESCHED.

As mentioned above, the other part is when preemption happens -- when
are the need-resched flags checked:

                 exit-to-user    ret-to-kernel    preempt_count()
NEED_RESCHED_LAZY     Y               N                N
NEED_RESCHED          Y               Y                Y

Exposed under CONFIG_EXPERT for now.

Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 include/linux/thread_info.h                   |  8 ++++
 init/Makefile                                 |  1 +
 kernel/Kconfig.preempt                        | 37 +++++++++++++++++--
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..5d2bd21f98e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4662,6 +4662,7 @@
 
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
+			or CONFIG_PREEMPT_AUTO.
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..7b1d9185aac6 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,14 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+/*
+ * Fall back to the default behaviour if we don't have CONFIG_PREEMPT_AUTO.
+ */
+#ifndef CONFIG_PREEMPT_AUTO
+#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
diff --git a/init/Makefile b/init/Makefile
index cbac576c57d6..da1dba3116dc 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -27,6 +27,7 @@ smp-flag-$(CONFIG_SMP)			:= SMP
 preempt-flag-$(CONFIG_PREEMPT_BUILD)	:= PREEMPT
 preempt-flag-$(CONFIG_PREEMPT_DYNAMIC)	:= PREEMPT_DYNAMIC
 preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
+preempt-flag-$(CONFIG_PREEMPT_AUTO)	:= PREEMPT_AUTO
 
 build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
 build-timestamp = $(or $(KBUILD_BUILD_TIMESTAMP), $(build-timestamp-auto))
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..fe83040ad755 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,13 +11,17 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config HAVE_PREEMPT_AUTO
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_NONE_BUILD if (!PREEMPT_DYNAMIC && !PREEMPT_AUTO)
+
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -32,7 +36,7 @@ config PREEMPT_NONE
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_VOLUNTARY_BUILD if (!PREEMPT_DYNAMIC && !PREEMPT_AUTO)
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -95,7 +99,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
@@ -115,6 +119,33 @@ config PREEMPT_DYNAMIC
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
 
+config PREEMPT_AUTO
+	bool "Scheduler controlled preemption model"
+	depends on EXPERT && HAVE_PREEMPT_AUTO && !ARCH_NO_PREEMPT
+	select PREEMPT_BUILD
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model selected during compile time.
+
+	  However, note that the compile time choice of preemption model
+	  might impact other kernel options like the specific RCU model.
+
+	  This feature makes the latency of the kernel configurable by
+	  allowing the scheduler to choose when to preempt based on
+	  the preemption policy in effect. It does this without needing
+	  voluntary preemption points.
+
+	  With PREEMPT_NONE: the scheduler allows a task (executing in
+	  user or kernel context) to run to completion, at least until
+	  its current tick expires.
+
+	  With PREEMPT_VOLUNTARY: similar to PREEMPT_NONE, but the scheduler
+	  will also preempt for higher priority class of processes but not
+	  lower.
+
+	  With PREEMPT: the scheduler preempts at the earliest opportunity.
+
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT
-- 
2.31.1


