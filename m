Return-Path: <linux-kernel+bounces-62975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2B85287B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F02A1C2353A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E92BB08;
	Tue, 13 Feb 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LKEs+w7S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PuyMM9V2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6647286A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803841; cv=fail; b=owUB05VJerq2JSJfiFC2/S0+HwaJopEtn1ZZKoXiwmAORyJsReB+GHqkjNZ/Ahj4IyfP4EPFSkRiZWHjzMng2mSoO8+l+8BxghIY+z4AXV7yiV+JXWE4W+X7Wmg65vcDJgi+v4EDfGhD+LtQghNoTwNfrVLGt3Rk5Bi9qQaUExg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803841; c=relaxed/simple;
	bh=6TlW/dK4PJiKA1H+OKwfpAOdooAvrFke8sAXfycZwxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mdh8hiB6DNnRCyQCRugEmN6ZuDsur33VrMshueHDoIZnoQs6AWMsBrvpOUfqAfywSs4e6flLfQP1ud+SKCfxBFyYQeK3jXf8OagEiA/9AaM/sQFg6/sc4rljcAimT/I/bUb1HvlLkk54HdE7bd4CEzr8k6bBafQpUqXI3x5Xif8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LKEs+w7S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PuyMM9V2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5U8md004768;
	Tue, 13 Feb 2024 05:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ghLuSp8KTJpodZ6jrwIUcvXLLNeYMHBmB+G7KWE+Mng=;
 b=LKEs+w7S3Un8LpIDv+XF5d+0/cKBUfODoD5Rm1VBmFV9cVVZhtPb531O9I0X1iqXvpWd
 WzjJf7Q93JIMQ7/ryO7OsuioBw2s+uIStfMHOaD6GFXOkDSSx3d99xnRCYf4JKKQcMCG
 kZIxhxQrsPIj3XFNr6qc5d/9+jUqPjaQGRX3A11b0C97D3rNTlt43US0sHCLl7Hq036Y
 e0hXcrhs4BF0lX9+FMUfLeIzSDKCYMHmxxMtZ3paUsLpLINYEoBXTNAvdxyODlzIFgsL
 /XZgMXiq0SA/vsPdbdmvPHWYnw4jxKSgXxme1NW0F8rIIwPVO5qyMuHl18TUVKX4CaOu pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3TU9l015098;
	Tue, 13 Feb 2024 05:56:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6ugpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK9z6yzm0cgBECRMalG1PXFegC8ZaUu2aLMwAtYKoPQ4ewJBlTpKITbN8CGdkMPRhFPMYCnJABdWG7yYvf0BR+FmLLvOHJzef30I6spEPOXab5VqiTYvbYYcyA1lXAhcTpLqSGor6weTyRvk2WwLJtLFrh5PZgZQhT137st9u7qlnwnhDlg9K4z6uYsFX0EfVbY9zZIicXoU2GEcYHl+uSrjuwZSIRwtzVAoJ95mEpEvxFha/FOCOUOCK5rE+x5wLwQZ3sncBdUll4Lv7lQ9nS43N6BZTkAoBpDObKT9CQ7MKuBmJxBx5hGVrpqoAep1P4Lhm4LmbF3niKz7k7dUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghLuSp8KTJpodZ6jrwIUcvXLLNeYMHBmB+G7KWE+Mng=;
 b=h9pO3C94RKxWMVTRcYnhwgtNnyJ+N/A4O88Aydyb9gkTdtb07kTF4Qibk870FxR6lSu/Ugfcza4HbNkjKHHT5cLUC1I1tkTFWjJ78BRVrPNNcj7MGFoFXD5V5HHDgHRfVbym+dELWe6QJwLmN/eTWGulFsrUK3inP+J5L9NK4YTGMZSo+5ucvU3+AS7UrU1PAUj9T/4mxekgNqWHCxeUQW61up37wYPwdnysmq2/d0ciCENcHNExZjqN7sjllmua3kM+A4/BsS+PH9MBmAUHqa7tHZ0YHcZ5M+Xf2oLiZaxuH5VPRR2ghQkkhcW3SNox7i5HZFgigV1o9Zb6RpCJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghLuSp8KTJpodZ6jrwIUcvXLLNeYMHBmB+G7KWE+Mng=;
 b=PuyMM9V2H1Oe5QugFc6hbxKcn6U2JVPsoB6agMgrHyOtL1CCMs+F+gmx7/DYDDWxOyRy9uCVjbFY1HxXnafBFOS3PcG5MkTM7ty3u0yBuHFXM525z1oqw4J3G6ab8W6NuUGIbb0wyEV1gYYyeTsgmf2Ss97UtWY5XV5yDS3fz6Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:23 +0000
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
Subject: [PATCH 17/30] x86/thread_info: define TIF_NEED_RESCHED_LAZY
Date: Mon, 12 Feb 2024 21:55:41 -0800
Message-Id: <20240213055554.1802415-18-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ca4265-a3ba-4535-934e-08dc2c588276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1jXoN8w+7Q+282Y7dJZ8DhYJnQea6stuM6zxHvc5+PQUkhxw90pZMW5hCpGrf6m3XDRAOuEe64nMJiUdecJ579+fA37yHlTpZki1R/gyiEr0xyn63sFxyh6KjZKfeX0yGtUbBw8l2SCqDBvi4CEPzqV2S0aQjVrp+vJrpduPO9K2Y8TNgNzFEDvPg8FRNBnq90fFxNe4R9nQCwEMyvVDZvMWw1mioQ+CUUkPFslQQoaFOy+csORe/e3O8xM5p3bKg8dow6eRo5qych2UbEOf4hYu2s2uZKp9gURPVjnZQPGMFJa/+Y6pdNgagkStbavpWH25zFOfJTXD7d9Mv0C8uwSVDlhjIRjYDwAjeCjuj/FdEXdIRgOv4qlUrObecgO2UpPEFFLyfblcofHreGbg3TybuK1KiV6T9Oz2ePmrrxsNnXXV+IHbDZkUuchag8oHcQriZO7zI9isAFv4wm2ifLMdUPtjZedjaY1bWy+276DX9Hd+juQC8Sy9u2P9fZTtMFQ/5jV7F5nISxuzi8Ge6rhK3Uj9Y5TLMarWnLg1k3c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ypxaAEKBu4xNkE/aQkIRMZK7hvuQUJpwU1ASZyO8y9dSjyCQUWTLpxm3EPaG?=
 =?us-ascii?Q?JvoVORsC7u4Dq6t9KhZKCft2C0w56BRO0qCKmQrHtOF/l5fbIhHvvqYA7NkZ?=
 =?us-ascii?Q?kJUffzuhVCJ3kuHi0Fsjj9hSEBI8E3ac/l8XXWeb33d3lgSagb1b+yR6597U?=
 =?us-ascii?Q?HgGTS+baBPVWP3z6zcAiEPNuQgDZSKwyqLAPMmkA2RcX58XZV6SIMjq7B8gu?=
 =?us-ascii?Q?Ow0bdyH+XUaNyyzIQ2LEYZ9e2fAD82Da7ShlvqFVDboEYcL230tAWTAlj6D5?=
 =?us-ascii?Q?4McblT0BXU8vJKPY+hiy6lqgwsqUT2xggjoy83WxLthc3QfRim8wIf8QN+3d?=
 =?us-ascii?Q?I4paYyxrby7O4GMaPGnORyhegSRVU7ys/6vm0cl1fKU+tMImoUBci8lEdmiq?=
 =?us-ascii?Q?v7UL8ifvaZQMFidWKInfqRn+MYaVI94jS5zFmSJ49jsZtEZNlJCPgAworWhq?=
 =?us-ascii?Q?HSsGLYrj4CXhEu1JiuoYgGE5v/C4/pds8KZ0WCmiQIWiQ8dPGOGYgC2Ml+DK?=
 =?us-ascii?Q?4fkPY2/xfR3dfsJcCQPVh6x0oq2G1kEFUkfc1OdsLp7UCGGIx2ujsnsZuFEb?=
 =?us-ascii?Q?/1SJFQaQbwAK6fMQSsHwWD2mwHkbK4xmAO0bpwoPau5jc72/0yYOQDFuJ7K4?=
 =?us-ascii?Q?ZjD65ywwXjTDNLPOTKeLqgdSUciPLOp0MliJIL/DkNp6CFg3QNlJ89vRa/52?=
 =?us-ascii?Q?cJi+EdkjDHV8yJ9MHZn8uD3Uk4/hQ9jE0c9U7yMtIOni5UwmvD39d0u7hgem?=
 =?us-ascii?Q?Ou2cH01VEN+K5UTUAcaBdUIBQiMFWiecr54NmDWfbFfgB8Fo4slW7zOka0dA?=
 =?us-ascii?Q?4CoMCuMQWqjq2y4po8nuAI2fg6HNLyIbxZgVl0noY4LJ4NDGB40OYPO/Kp1u?=
 =?us-ascii?Q?kJ5HYGWbmUjMFlyorazW7WI4OWoEBAKsC4ykJmOSdGwe452iBWx0tJNjyx8d?=
 =?us-ascii?Q?lQ28nAtt6qIsZ8fC9HOB4g4qj1LvmhBrUYyURNPM1XiE6QS45fdep9rGQ/L3?=
 =?us-ascii?Q?lw6IuQ4hbrELyyJXUQC9wc6SXC+hokrFUwc/sqyjECZW0vkSOTBrH75K7Xxk?=
 =?us-ascii?Q?dHkGWI70yCsSYTnwqIfcIXxvcK9+hFKLsxyJDx8euVEVwiRL2WWKg85pyf6Y?=
 =?us-ascii?Q?fCGeBa9KKMIwicElNN3a0bfTGJd4zG+ncfwiMArUlFj36X1GvzJ+ZV5Og9Cx?=
 =?us-ascii?Q?BKj1sVpFQv09EW0gvqk2M3teN11s3dIk78Pprh1FwylIJxZDMOdDsErAB3oC?=
 =?us-ascii?Q?f7shjAXuN53Ol3Y0bA2UEuVAsTifR2/alENQMzV8iZr3kPJs6AGM9sSgg6Wb?=
 =?us-ascii?Q?7NOKQtOaN5h/P79zG7Q+S3vhSM0hCyc88ZEAM0JrwRoNbOz7e2MCU0H0FYuo?=
 =?us-ascii?Q?1fnraSdBZ4vAVn7SbTscfFofYP+g+BdnVWUwK2u6FXyFaDne8F/9XjTf9mBh?=
 =?us-ascii?Q?+yBUBSSINa6JBL3B3qWYInSsTNmG/Enw7lcl+LJ9YHN4tRIOkouxdwP/wLh0?=
 =?us-ascii?Q?RQWHztiYzYt4Zue/1oAC9G+r9CIuRvZV1QJQ+IpntIy3qRqGPUEGmyG0ViSC?=
 =?us-ascii?Q?bvHACwaarAdvvFEF5ZGlj4yPSmBUPnIMJYoJjkx2pRAhtLtA6AvDUEGNVNhv?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CtjKQKJTsInfw3AsMvSfCPj7NsdHqxQoSfrlwEAlv+BHiLlkEzRo39sriomM44SGL/qfYMhz5Mxdl3QjjK+x1i86R0Tzd6dodDwrGqwuSV59zCbKfy1q4N4NUOpvRuMGywysOuJX/2jL01p0PWoqCjty1LCyh08ntaZaFLNv+3ZY9g0F5U8kt3rv3k9VLVb3/rBrm7Exahg+gamzheTEKxZHMoMF2BieNBfQ2KB92l6L3fhmUKuxvaXlMqN6SH/7rEt+R4BsPUg3lOsslwrwKf4EQdfvzbY+97BnjiYePKm2eLEyXAotylJfmVQ8y8lvq49R5tp7pw9BL5DbSVvLUYyh0ZJaxH5I1x1e1uzxJIYQLOSEmslRdTUZvF0N+KOm8qv0gY3qoiByYQeim45TkYFRX63DO1a5LoUhVmO3jYyCmrTaj7PV7fhV77lI9ug6zJWKk3/8uxxyHNN0sWeCbxJKze+k5Zsea4eabuzvjpArysfXBiB6xVYWUT7oAMyXH6TetB5nhz6x44VYg3tlh4BMxv1VlMN5/k6SlWk5PkplNR08eBcN2V7jCH++prmTwnjhQv23nQ0qbAkNhaKB2+FW4cDJmdayJ4ixRHOKre4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ca4265-a3ba-4535-934e-08dc2c588276
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:23.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvuYWSOliyLjRxN19mxmEPnZxSS83Xawkx80trG1dtaWCnjC4GC0+eHWum8gWu5+OnYX5lj5olPbuE+Q3oGqZzJJEUn5K+azzdGsD9M27Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=740 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: rHbhPWj06GGaTjDbAaENr7AO63uuHNow
X-Proofpoint-ORIG-GUID: rHbhPWj06GGaTjDbAaENr7AO63uuHNow

Define TIF_NEED_RESCHED_LAZY which, with TIF_NEED_RESCHED provides the
scheduler with two kinds of rescheduling intent: TIF_NEED_RESCHED,
for the usual rescheduling at the next safe preemption point;
TIF_NEED_RESCHED_LAZY expressing an intent to reschedule at some
time in the future while allowing the current task to run to
completion.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/thread_info.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..ab58558068a4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -275,6 +275,7 @@ config X86
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
+	select HAVE_PREEMPT_AUTO
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..88c1802185fc 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,8 +81,11 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#ifdef CONFIG_PREEMPT_AUTO
+#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
+#endif
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -104,6 +107,9 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#ifdef CONFIG_PREEMPT_AUTO
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
+#endif
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-- 
2.31.1


