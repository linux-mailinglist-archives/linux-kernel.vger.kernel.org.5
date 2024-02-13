Return-Path: <linux-kernel+bounces-62971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06559852874
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A50B26BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6624203;
	Tue, 13 Feb 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dIIatEMg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pm82z+2Y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6707225CB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803831; cv=fail; b=MuSbiob5H5eqBqQFXrjTHyBrMIYR8EcTvRS6TraS3XPFVRAKkA28j3Y124ZVui1lEps4h16QWSzfMc+JpSA7St/Adu2VVfz2+4glJhvBzTfUsmOqmIKuw0sgiJY40C20DVdDwN6eCRKFMKv2anU5MvIcImcZ3u/eP5lKUEPkjwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803831; c=relaxed/simple;
	bh=k40h/VbNGJWXmNNYS7xe7vLbqntRE9hDXq8zzQkVs+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihN4bQ69T1+ixjOAWXDRHcdOMTuV5mxM0Nhq/tqHFLfj8I9WO8EoU6b87IlaCoueVMV2hE4qxvWfSfO35/qFGwdUJ5qfdKTu7ran+Rm82hea+GQ17BzJXPyt3z00Wj737d5SjpK2iqpvu9TByng9qwMATqWeXlmSv9pz1VBn2uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dIIatEMg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pm82z+2Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5Gh5K010530;
	Tue, 13 Feb 2024 05:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=VhKFn9KscEGMvCXQCivvG9esouJ9r7Y9KzLpBubsktQ=;
 b=dIIatEMgE6PqeYkNlMjYBgItgxRy8GEx1J51OAu+hlyt5Vn4BrRFYkmd71Qhajoxz0VL
 +prc79jvUnwkf+RsVKO9Mzhn3tI+yjIK3TjhDY+LTLnWyphAabvQwv4HjBvsOX7HK67t
 ml8vCnivPnh+aOAooiPhtmI/ry3iOidvFdqdzro8DTaKA5W2guTuWygvolTV5foI+qJ9
 n3npHURqZ5u71dW/yi4s3Urz2kNHh/Scn/oNgtPq+Ntt/IkOOGDY+T9WciDPODDIR6Qp
 c3bQZDTTDe0kYiqyOV6kfZ6WG75HimDMsK+etoEFmj+tgdry/3fRZEB997MAKFyz/G8p LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w824v02n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D42gFX013836;
	Tue, 13 Feb 2024 05:56:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9gnrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S74oHCcnndEw7mHFtmqbFm7zsPncPahCJVbgJF1T9J1w9REB+p1mukVewXFuvyYviwdoyFIU4b/nne/YvBE7+BcIju8KGhdBem/3J6dkcvRk1rIqwgCrhnOZ+vR9KDuqXTOjXBLMk5YpzqbBUz+zWbtkv5xBBWJUCkGiJ6T5yP9aUsmzOZlXGECIvSQXCaUHQjqlFiocpV1FB5LUhAqyGNpusJ0GsvUmMG9d6a9DcpSAKGgAWHNPAYQVXvwtAJPLHCOe62XmD9+m3E1hzaX0rTR17i4cPOlxicmjWmbn8P/PyqM8IrA8gYRLXPcTA+b36EOUxuVTGppAutzmQy6L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhKFn9KscEGMvCXQCivvG9esouJ9r7Y9KzLpBubsktQ=;
 b=Ype8FQdgd3XU7m1T0YdvRq+aLPYHn1G3K0LhZn37H7C3S1W2FxI4M3Wr4dPkW2+r5hVGlUr1hy6tCpR+OIRk4mwHI+lbQ20k4wjMFUQ5S18jOVx93UW6H0/Y/ERQ7e92/QeWZ/LDs8sOvB86gLPZ9oH+1B7gXPOAC3pAvj7HlGYlC8xeZIXVX6kweKQIM6wvGDQ5hoBDkhPCkde0q14F7+VqITd1k9JfU3U77Mck58rRQ7gUdHbBadrnPKpxRul+odvUEm5pyETAResti6jBRESV//vMu2wNsxWs7j1jzb+oN8QIC1shn1v31hB667CAoJSVX16O+2SvlfTUl+U0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhKFn9KscEGMvCXQCivvG9esouJ9r7Y9KzLpBubsktQ=;
 b=pm82z+2YtOBkrfsDwPEyLEV9XVU0pBXML6StYMbB9Q4LU+SKEqT/alj5CdIZWCnEFNE3IVil2eswgf3G4OVNv44zlRORj70f/lB58k62JmRBsyPbcuESr8CqWJ9jL7rWxIAS2j9DI/a+T/md5BJNMdsT8CUoNdKEWx912rsZ5po=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:11 +0000
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
Subject: [PATCH 12/30] rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:36 -0800
Message-Id: <20240213055554.1802415-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f6811a-4a49-4a32-f4c1-08dc2c587ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b3ifi4FSh0pCe7+W1CWtFp8EtTcTfQEgKIhFUB3omeQR+jSYpAKweiXDUCR8HSjU34QJsCeG90sDGCYjViklnjRkjVPHKUj4cbQeds9sYYjALAjRk1n4BFYOdlX93b1G5rugHxSprvBCHdo4Fzjw6vdjJaZQ2popZ3jj5BdiLuN64Oyx9JjPv6cYUO2xdVZdMY21HKpL2MWMxDIt/oCdm6CISn/xaGFcZii6HZr8wIyg67sNjLLK6vXZYum1FW2HKaeB2ponGwb6fBHFYekUQMGzQWnIFsE5p6eZaMmmXVBycJRvr2t3qxGqjCZeq9DrQNDQ5Uu6rx+QO7nBF+J7liM/3mdqcjt4h6DGwLropGSL1T3gy+sK73jElxIorMlck/19p41GKoAMqV6AZaIrZ+b8Mamg6N9CdQY1HKDA1cMPF7L2MKhpFIkFLJgpUS/++b0w17ZxQvmCCRtRgFUJffz4OGK9P4UMz2JEyFIYayw2WZ3PeKBsIhz9GNCw1GaDr/zhltSxGyRn7IUaOXWRgkvXu6ihOUXgUUWcYObXpUdbQTHy6tRXMKXSLMTtOye8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KoHyIqeNRwkYHy6EV4olV+lqg5RqmXsVqCIyQMxgSWKFWz3HPCk21YoNGWtC?=
 =?us-ascii?Q?UUwidoszzZ9rYoct6EjiJjmvMpR3F0nDEXccVQJPi2dYc1n+AuXhG62byKFT?=
 =?us-ascii?Q?JImLDvX4c7n79wbTWTTlm4Lep4yrtK92J7yTZ9QA79DtETFN1O5hdWTicxsS?=
 =?us-ascii?Q?uIlvJZ6IbtpDZSChcISngRoCLt0S/VWh3ht07Xf9V77oKgjWS+xMI2yOJtxx?=
 =?us-ascii?Q?LySnR+Ni3UGBJ78hg5PsyLhU8pdMOl6HVG5Tawbr/w3zWYX+FjEmhQ2ETpx1?=
 =?us-ascii?Q?S1AH58vsBrf0lA5oVIb2pqT3e3Ljy4tj4vXe01WlveRfAA9IZfnfK8djE+cR?=
 =?us-ascii?Q?8F1ytmzzkpe5nu5OtZG+KQKNm+RS15CY57D4zk8vAXbAOMEaP7zvGxj5JDqP?=
 =?us-ascii?Q?HB/MizuWzAgFFRTNcpWBpzHMCZCeq6EwUu5P5hqiceo6hH2X4CRYNxCzu/zF?=
 =?us-ascii?Q?A9Sj0ujdmj6lYjB8jbqXENyJ9P+JbBSF3qfHfGtDMteXZV91FqcVWFhOggPJ?=
 =?us-ascii?Q?9dZ6j/BLFpEVWmR8iRj0c4Y/xgenniUS/0cLsLZ1V5Nldf6JhQYE7M4roAAr?=
 =?us-ascii?Q?gEkAHxP70XlZbdSJxHdhzqSqHWNhtImRM0QjPsEyLVe0QUOt9pW8ZCN02a2x?=
 =?us-ascii?Q?e/PSrFMi/NuKDFxbp8OKZcZJfe9UMLRW4zd3g1VV95N+wX01UUPIpqt8i2B8?=
 =?us-ascii?Q?1YQsxdkg4CEj97dISFyBGy3yd/dHzOgz+aNewBoeO14o2yfzgS2r2BaX44Uc?=
 =?us-ascii?Q?oQuz8U6i+w8uKYKfwXFiW7SPqYjHswUNgAUqw0e17MDRhwDIAOcgy/lE2dDS?=
 =?us-ascii?Q?lIpYNZoGLH4kWAdjyUAUhxuNVWiJFhi20ThzVXUtZqSegVXXRiIkoiq190O4?=
 =?us-ascii?Q?9IgjAUKXpQr6TWhyel44GxkkLAfA/d2nZWgax0JCiw8Y87vykfUPGRpMTHtu?=
 =?us-ascii?Q?42PXiO3tCQLOindTDqj6ucV4hT+2RL+cRam+v8x8E2jc2CE+FHp1G1/MVDD+?=
 =?us-ascii?Q?59E7JSvkkPjAlfhI0OXnm50h4izF1Wzrt3nsewLeT7saRdiToE0/bmVmDQHw?=
 =?us-ascii?Q?rjPUY2Qx7nLcv8SDQ0JK0TL/pPSQ0Y8WHbissmgzVwNa1pfvp2G9fxJIGDId?=
 =?us-ascii?Q?oqQAKumLnbJCoIefZ0zv+FKteDJRkOUiDjG03N7mh2TpUCbFODAC8bnpwSNf?=
 =?us-ascii?Q?CQhnMDHIf9tOofcSzQNzgeTkII+85bKNL6vG7gGnUnSPsTEk5id8dQQ6dYuD?=
 =?us-ascii?Q?BreEanrsYrLmCNDU05H52G9zjxbHIk8rsTrKbe6db+Y41A+jtpnQjqbLu3Ak?=
 =?us-ascii?Q?eOnASGFYNTij3jIf/3K33YYTQmNuU1KzLNk+oDFPqZyPSl8/TQ4rRzmIqlvj?=
 =?us-ascii?Q?Gxab+4MdDFRbpuc7sYDvdgoGqjRuXI83f6alSWTMRVushBHpWfYzd74cYvuX?=
 =?us-ascii?Q?Gn/HGWeBsx38JbF6yweYNB7Uj2kCxZmVxsVGl6NarfyuF3ToD/B2nwcdDCf7?=
 =?us-ascii?Q?YfA41C2EipEhfkuiOKwO+tRE8warsu6wim5ogBDs/0VEA+0fIOaJ1DMa0p4g?=
 =?us-ascii?Q?p7nhSgDlZeDjkDzk3Pf+MyF7oB5/Em1/6VY6OTaoK9eFNxBx63jIAUeBBfZg?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1lP+DIq/f8qFCdr54UFgbB1syscx3z+VW02IjS3x5k94gRB+0oRy0gDmdnSnrJgLtJHnZWV4Fu5xrAD8StKdWGTTkJPSRUwHMfZ2jds40x7lZx41B3toiSWwlQ5LX3qlL1ouZOWmoLXEg5QsD/BukvhmNZlamGCbcH41iZ5cl9QP6vEZjLAVLGLjWsttne20lXiPcMIbCaCzNtveg5+udFV4Ch7Cj6drUOpoLQX2rkNSNR/tRqEsF0I95CXNrL478A/w7yFHLwHK7hku4LpBygtBFDV0s0B3hdPt7Z9VSw9ZGMv4QQnu26JEvFbHKxRoil+tLUd6koAt9Vu/XCT6Ka3BvL+hVJbOPyaGtgQ4qy0Wk2sCGl4z7H4UBt6Rfo28HsFRPcaQVGSQsEEMb3jVSiFAHzlmPOahRBmwLq4Vi2jfIE78c5D6fUM6/4Kcqd/WYiWD9H76bD46/GdlAR5SE4fkR75VyubK+rtcEnmktxupUASs31PPJEsvm46Vw4EU/4MDb+kVNHLZk+hg6CCyI9eVYJCgdFLiZKSIysL9wramCH+jS0VMtlzmjNlPNu/XR9JWLbCiq9e3Vx5nwEjQUdZ2Q/nVww2eAJRFjU1ozfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6811a-4a49-4a32-f4c1-08dc2c587ad5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:11.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UX8CIX4mU5hC8HlkGgvsuafXtCDbML+lrMO7ZbJpDUZat2gq1oe3ntcZ3ltMsWGYMQJzyWrZ3OfV2BUHnDWZPXKsiSGjdgpr7RT3/1hnmNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: WhdQ0jabJ7kk1VqGXCI2FSXlFvXEltro
X-Proofpoint-GUID: WhdQ0jabJ7kk1VqGXCI2FSXlFvXEltro

Under PREEMPT_AUTO, CONFIG_PREEMPTION is enabled, and much like
PREEMPT_DYNAMIC, PREEMPT_AUTO also allows for dynamic switching
of preemption models.

The RCU model, however, is fixed at compile time.

Now, RCU typically selects PREEMPT_RCU if CONFIG_PREEMPTION is enabled.
Given the trade-offs between PREEMPT_RCU=y and PREEMPT_RCU=n, some
configurations might prefer the stronger forward-progress guarantees
of PREEMPT_RCU=n.

Accordingly, select PREEMPT_RCU=y only if the user selects
CONFIG_PREEMPT at compile time.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8..d0ecc8ef17a7 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_DYNAMIC || PREEMPT_RT)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.31.1


