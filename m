Return-Path: <linux-kernel+bounces-62959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F3852868
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8078B25AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF55168CC;
	Tue, 13 Feb 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLJHjPlE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zqSIhpcz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0B13AC0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803817; cv=fail; b=TMi2zkymnZ97bw3qltEFZeY5NGTVZ9CenzIDEem+Qkrt5xhQI95li1n/kouhPOJNhBkDp+M1bbBTBb+ULPQg5n5N0adHZd5CRiloHdLRyFzYXv89GjUzVkk57T17BaDZZztjBIwKZX/AOPmx78/b/Mylpno1uHPn4RR9M8mMkX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803817; c=relaxed/simple;
	bh=nr0QPCu+GnZE5/UOpk39fhN9n2hnLDQiL8bisVcyU58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGbPmfr044XLWB9Hh9MaKNwuRt7A+s64bMk5zqtQc39l9Mv9HpavofA4Xds68kLCtRRwgAcj6jZ9ciMRvaxk73CeuW4MQMh++4bVs00KFdETAQe6Ds/BZ7aCsFJ4bAgDgxHlKrrWeH6MHNVZDhlUpjhcTNkI+2LR5i7RrVAeMKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DLJHjPlE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zqSIhpcz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ZIOu006358;
	Tue, 13 Feb 2024 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xiTU2FNLYRY8SsmUttTPdEuTbpCyPg7TgvckCcFoWU0=;
 b=DLJHjPlECxOzILKjnBrMmu5WJ/RWbphE3NmWOu5riNTfhxg9qy7IGmKjxxotJ/OKdHjX
 Ivw9qb6uXoICrvgTntuJ8pPVv4en4/UuRCwsJT7FAXM5XZssTYy/2RX9KYgQ8UrOJHTc
 JAWJEqovPlH7nZxD7Uo/0QR4JzYldBWLJZ6X5PYR7CjoDWllhQ/uSTEawi2/XJO7+f9o
 lWyp1vgLFrW1ELw7LpVTFT8cUvXNjcI8omSPHFxEnbZikBdEMClNJxCtuyC8SXO1YXtK
 pNsGhxJYkczfSmDzygfXaWPcjjgftIaVzhw7N2H2wBC2ZCk9W72aQIVMhC4s9o2uYJCF Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3TKii014951;
	Tue, 13 Feb 2024 05:55:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k842-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jII9NDdr4Pbzs+R3dAt/b1R9d1zoAjEWG7NyqNFIZVXjSqdljd1zXVJ1Yq8Oy08uDA4LRJJLqJ2L6YRAzmCioPj4/y3pgjicYnQEqg7fhmEl3+kmkVaVvVvQjFljGkcOUINZz3ITJ22my1nhBNRVoJ7rveH54cRnWYhsLAe+Gr5qQmTn7l+HOgqLOiBZ+mU+PbfS7ZHfU9TfSB3gZbg9lagoPFAE1VTGzDd90Kq3nqdLpHfFYUfJiWKWI7rWpwH3lBZ0vS5FPvue5pS4Bn+p5fUEowqL3Cy8pBHrii9WplIKTAFU7M+xy/9zw9jgybQVegQfr1+0W6qe+y2hyrIQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiTU2FNLYRY8SsmUttTPdEuTbpCyPg7TgvckCcFoWU0=;
 b=YdNWB0C4+AcsTtEpo2MRJCzDucWkPnxfB8mVdnF5nXia/UcpDnSFMvj+5fApXfZpNwDlxb4h8kwh8W7Tr/O/JC1B0/Iv6a4ynHdUwdWDMNfrlYdBKs6uGoVvzPqHYtY6Xs/CQ/l7ArPDn+R+mcbRjHLNfQ66jdbEEwjjNx3NYp8VTP60GwoTCxUf0s/RCeoPWgvkjw3mx3+ZecvuflFEz6VJJ7DKajMR7o+cvALBj2K3/HMiyxejc8s0MIroD0zENDLraPYgfUo65oSprFvfA8xgl+W33wR6r2zmu5EWwDLwi6ned9USHTj/saFVsAD5JsqQQgZu+E0uzv23Rtz77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiTU2FNLYRY8SsmUttTPdEuTbpCyPg7TgvckCcFoWU0=;
 b=zqSIhpczPuJ0jt4KtdTe7gvQ2xrMgDJaiYotNVVgtbxrvYivEHZrSvurAhMhrC3fIIyju7ysC2pro9zjqBdJR10heQSjUgkj7iASmmsLxDCnELfYXQ9WLwwaJjvilJd+cAm1cePD2Ipu1tPnyu7myZUb/PXeExbI6WVvNc+niZ0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:46 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 04/30] sched: make test_*_tsk_thread_flag() return bool
Date: Mon, 12 Feb 2024 21:55:28 -0800
Message-Id: <20240213055554.1802415-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1557ed33-39d1-4fe0-20d3-08dc2c586c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w1ixs6QKQARmPzJdKLNBw7ua1+7+dFmLHxx1eifFvkq96a9nUulkokxc49foUZIn0M/gBsGzSxhagpDe0kvVywwiupsypXVcdwxxwp7O0QEBjAhyuppE0I9H1+vOUX4ZnEZqdCjVOrJjCZ4sv/RT983b7IUZrjPTGyzMxi/YnzqdNCLCcyWmz8cA5gpYSn6Yh+UYi2idvQksRcF3PpZCgLl2DoZ2aOZDNKOm9JL2EfQGYDXKSK2GvavHIVjKuKaSRD4BxSsNioqEfh3TDkwrw8DLQujqepSpQT9dL4JjI/CBsYDE3koc/+kIpNtRE1nCy5htTQtUzYXZjjTTxej0B5qNtMRzgrY5PgOfzLE63KVn5lo1SItFjNHKNBiRMpOvX9MFYvIJd3GVKbsGkolmpBRZJK8YHsf6UgcNd0AFz2zRQcZd4oRTs6tJf8+I+mRlLQ2Jh6pVzJycvx/SLVtbnda9dBYvdb8yb5dZsJaijzCz0Goa3xzYCWSf8iZLUjyNKDduIb9zfRiXzm+Sa9/mm8pJ9AQTFpt0iCXcHB/k2l0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2qDNptoTrbYsTHUotw+EcNcH9Id7OVQF+6+/g4sQb6a5t8yMAJQrfpwPA9pl?=
 =?us-ascii?Q?GJs90KsDBBEvtJhgGy2SOh2DBUjJINeuSgtX8COaA3/lG+szWJGvUC1whTLs?=
 =?us-ascii?Q?RtwsQrWM6ARnrGdax/Ks1BZj94efh7vSH8t6GS54UYDl9X3PPioDAt7Cmkuk?=
 =?us-ascii?Q?4+Bdh8e1xsbfrleLTW0QRdbSPlGyOihB5xy1jnnxEOuTTHHEkN2mxOGWME3n?=
 =?us-ascii?Q?N/VCkRdS88Cc47UyvB2CyijAw6+gRNC/qhk2OEpUEEyn0ZKNy2ZKsa6lym5i?=
 =?us-ascii?Q?B1BvaORzuV8frx9sWFsYVASW/HSHzwWFqY2v8dlbfUqLGWsxzs2c5XzjN4x+?=
 =?us-ascii?Q?NhzMyjHq/bBLqbql4e+cBdlr9GMeC6xyj7nZ1fyIWhm38obvsbu3A8hTCey7?=
 =?us-ascii?Q?0mW61dsgpqVLSIsBjRPCw9eBnQ0ZwRVGtRX0euiHBb/VXAfiggne0ealk4VZ?=
 =?us-ascii?Q?ys2N73RYCVygAzP5s0F/8kLWr/UNSagA/JUgTimqs+D1Lqn7eF3wu8gDhIfI?=
 =?us-ascii?Q?2Lo1SvwYyejpLYNHYkDpkTHBC/W0lFt0GEyC9XEQHRW5Jdqnl1SASO+SKdje?=
 =?us-ascii?Q?GUffvq1D5BBApp0rG0ibkkRt7ejSEscHfpyw7dkDdRZO7/OXbIUoAmQTqcV1?=
 =?us-ascii?Q?PHfGuE63prVs80JO1TKzqdej51Xhl6s57joM9rUcAiiM48x4JH2aLzBTvw0P?=
 =?us-ascii?Q?thmtjIKTVu7NuQyHRqcImEaAPH5PXmICP0kto2VcFRYrHXXPOv7bO2NBi9xW?=
 =?us-ascii?Q?1U4goxeb2L1EztZ+kWVvcMgvrKdiyU7zEntKmsbXdunZlrx+WeLdbV1OoBwI?=
 =?us-ascii?Q?3rwRrmrG3P24+nAYGEo3VIAqCeb2tfJULw7CxxWyfsX8YaiOtE0txdNWSVfb?=
 =?us-ascii?Q?HfAyRVTOeoC07SRlQTRXf48LBDmQrX8CJR5sdjEA53qcu+jr3Rvxvw4NEUkL?=
 =?us-ascii?Q?C0LIMSnUV50ZI8qiRa/c/BhIxpreaIiTdE49XeMcLDD8KM45aN2oiyD+VHb6?=
 =?us-ascii?Q?5wHEkDsuRwerDNoXSeRyb4kYfVicoDSy9jCOzp4gR2ERJZROj/sJ0QIsiI8W?=
 =?us-ascii?Q?EfGqWLuhIhpOVWfchxtFyfiLgi76kFdWWCuOCGugzGh4u0+ZIKvC3tCQC5Xg?=
 =?us-ascii?Q?26eeagQzqi0l3Gb1Akc7DYLkTssxsDdtT4vhNdLqXLTxHkgqvO3gn2Se/8Kx?=
 =?us-ascii?Q?48TP+D4+ZyWAmccYQINPHlvWW733SlmZWMvKCFs/xdRKKFcEWMVtlWF/Uo+i?=
 =?us-ascii?Q?rnjuZswxJ67GApXN31rYv+WDIQCFRvphFPaybHF8CGa5k4PzVMTnU35S9mC2?=
 =?us-ascii?Q?4gcSwJY76j2TMJAv5B1ERLtxovf2s/cqDAkQMJtiyRNXheQpDD0D0E1VPqfe?=
 =?us-ascii?Q?DLcC1hQgr13beOU7UBzqqGb5oPnpd5qt1rVEEfili+RyG+9Hsd6pADlDeGJT?=
 =?us-ascii?Q?pQd2COfqreI/F9Pja2dcrbe1aXzgm+yYZlsdk4lUJcLk7FkOOWv76ydi8Duf?=
 =?us-ascii?Q?EfYJgmGOXujrZ0LUYTN0i5RVaSU2+cS4c9LnVgT1YZXHRs9mb7cOEAbvF8q6?=
 =?us-ascii?Q?ExWMRF3HUIXExYxGn2qA9ZvpDTleH6wRYnOJDuhKUDZDk/cqwod3UBf0NDxP?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1LxcDQci518h8kDIfKu8uTewckRw5KhRBxoaLbDZtTuewfHr+M+0PmMVQPSKkSPC/MK7S9SRFeBn8u5DYTDAfm+Uny3zda7x/9/mpkfRMUCTr5vB/fBfT8A7ROevKVzrLbxfp74ErCY961GgZDUek3XunIYGrDXeZ/sKh0PAXeEwb4zE2/3p6SuSpCll84ZCpz0z5bBSeG79oQUk9sDFgUeP7MG2kiZiBKCE6Ar+u8BH2wT02nOns+Wkr2ALTQY3BQMYidBUUt7sZ3Wtr8oESibYga+t0WoaMnJ4C0KXfqm8JyCqM3glIDbNIPLlUwE007JQfpE4HkHlq8ELxASv3IJg25a+RNZmJjxox3MA2e3zUqswWPaiO2fsHuBmAzDAs3sRQ12Sstk/hVHRYZwvzWs8+nxPNdVrinQy1rTjto7NN37mjC3grV39udOydgBVcC9+yonlXZtm0+RlW06BLU7540RN0cuv0PrOaJ7AfmG3XbIRHlCtn3tlFgzLn0bBcm6YOpA/VnlIy/OnEhGdSpTdCiERMPyIWq7XB3V9rKMyN84JkRsTh8fM31Sn05+Kqf/H7MJinpwA0v/j1IB6KgYdIDnp756/Z48Zq0RFr9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1557ed33-39d1-4fe0-20d3-08dc2c586c2f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:46.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kQ0a1tAUSBgQjv3bWMaOC+WmjyuupLi+OBudjzbTdMdXAGtJa1Z9ClXmIvbLaXj+7vFkUzwQcpGIV5Rartnyu78ppztWlMD30lOY7++dxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: FIi_gl6ubWUvy52-6ZdaPSlvRcs3nQEh
X-Proofpoint-GUID: FIi_gl6ubWUvy52-6ZdaPSlvRcs3nQEh

All users of test_*_tsk_thread_flag() treat the result as boolean.
This is also true for the underlying test_and_*_bit() operations.

Change the return type to bool.

Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7a22a56350bb..e790860d89c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1933,17 +1933,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -1958,7 +1958,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
-static inline int test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
-- 
2.31.1


