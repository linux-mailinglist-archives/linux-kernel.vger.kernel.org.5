Return-Path: <linux-kernel+bounces-96488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB7875CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521C61F21E27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C512C6B0;
	Fri,  8 Mar 2024 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QaUtYowV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JLX10tv+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA52C68E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869845; cv=fail; b=LUSSQ68Yz7GY4i5gZsFmVh/HtRIvKKvUyZOlX0gVMRXKj5drayhpe8tuSrvndi3Jpe1q5cFtujZ4zVoEPGHdxj7k6wE55C6E7rPdiHFK78jzqTvLW9K6evfEAh8mO9NJkVH4Zr9iNRwoAkcwa1qvEXtwZhOcLlUobJUKDV4Sqs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869845; c=relaxed/simple;
	bh=SAWme+b+2KXbvo80lBN6gTE+mKKGo6Czt6kksvMdVqI=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=K2npA3EvUrbADvZYjrU4Emv/s+xKDyFZ9//+vu0kPpbDMupZQzI3zh5k7HonxRj3JYdWTZp0Q5u0s8lljQSfmFGBIZao3W317lqWXLpu0cCpqNL8nmaZB+q0kP5Y1BaB9/pEtHCbhrGCqFUIJqOhVFPMUSKTCyqQr/WKRPdU28k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QaUtYowV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JLX10tv+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281j1ZI018492;
	Fri, 8 Mar 2024 03:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=SAWme+b+2KXbvo80lBN6gTE+mKKGo6Czt6kksvMdVqI=;
 b=QaUtYowV/A0eczj+HKQZGjXZce8UhsSNKUnVjS5uQB6RkxYEMc3s1ca/mBSOr+1SsLhu
 mhX6Ru9r4EOmKNTRbB6e3wL0mmHZxwCpRjVuu0a0TIu/27O0IhNXN+WPmJEjN09YA1nV
 qIQ9O2S/BbQp7w83K4B/4PUxUlhfvvXOiOZifRfu55Iuap50Men9WK2Vi5oF++PtFLhs
 50lxPUyudn9UxUQJ7HosZcVFn6P2w7maEQJh0+vjCoirDcCohec8x/1UQPZosXhDaIwN
 ME3ACkghEwGqLfSLELB0nq+Szuajk2uC1pXQv6MEnYWAZVZJcZuQvGbATFolPkqcRaHr Aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4dt4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 03:49:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42837s0I005140;
	Fri, 8 Mar 2024 03:49:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nuqyuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 03:49:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5LAvYzvW/aZk/qHy45mOzZXyeRlCPMe/Fv6vffSCmrK+yUFgTdGs/rghjHEmnWYM8SjWxNl3pqVk8l+J4LyQMOm7uvKoq1+1IP9n7A0OtiW5RfprFw6D8TB3uQtbOT2FBchwyCn6hRWIaTfaNLMz8o4SLxhe5XAjumkKutgVdvXGgwwYN8gpdHCB5CIAXfeJ7udcOZlVEb8Bj12sMwoNmRFoHi2MwNqjTvEZFf2pOaSqptHKD/frHcdX0/hQD7v/Fb0fVLe5nM6KzSimHA+7i8oJOHuxrCsHk0D+raWzvzHmn/Q0j9b0RkxMc2cCp1P34P5WUPZPgXEt0B0ezDqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAWme+b+2KXbvo80lBN6gTE+mKKGo6Czt6kksvMdVqI=;
 b=XGGwPcFU6qaEDXwdzsXjlOpCmQ5j42YkhRvKHlBELkg84KUR5Sv7J99XKT1nLliKQKiceMFhdR+gCYePHwZFFif3hB0bbLnnXfYdOroCwP8myzSVK6cJ1yX9JZ0Km+2G2VAA23ens5EPuABI+tbikLOdV38zOk88HmDw2fFzrPHl/HlEegdqgaVS9DpCqkNH6EktDg0RFZuF+0PinQouxQMswix+ecXT6XbdNnmiOcZhdZsdW+cWqyUrVmKSf3ZzANN0sEZEf3FmmBl5gONgm8R/BTqxVPosUg0bfRm1pd7ifpWB7N41ejDit9em0SIvbIecy9XWseWxKV9srW25cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAWme+b+2KXbvo80lBN6gTE+mKKGo6Czt6kksvMdVqI=;
 b=JLX10tv++OegDM3Nevj40q4ekGmmbJ3m7OjrDTCh3rba/0MzYCS3cNkCIEKtO07halkHSCzR3fZlwTJ6xlzIpAiM9PBWWO78eRfr0MRtYrHqrM8TYmQuet8LjS2DK33QqVPERQKDNiGyeI0snRvanZqHd7E3El6vTUPnlyPPcs0=
Received: from SJ0PR10MB5421.namprd10.prod.outlook.com (2603:10b6:a03:304::10)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 03:49:03 +0000
Received: from SJ0PR10MB5421.namprd10.prod.outlook.com
 ([fe80::2c09:4a0b:dbd3:b6cf]) by SJ0PR10MB5421.namprd10.prod.outlook.com
 ([fe80::2c09:4a0b:dbd3:b6cf%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 03:49:03 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
Message-ID: <87edclqt6a.fsf@oracle.com>
Date: Thu, 07 Mar 2024 19:49:33 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To SJ0PR10MB5421.namprd10.prod.outlook.com
 (2603:10b6:a03:304::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5421:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: a933b4c3-82e5-431e-0420-08dc3f22b24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MwAZupPPAUsRCfOL7seK+ANazjOgVZ7yoinc4ZdMXrBrYA+OzGnSpN94kUtV3EQ7WKylM43mmQGd1r/zzkjjNQhU8Ds8N10GS554THq5v93EyeXP86gRuspphJ70K7qxiRTFIyPeR81p9OmS6Ra7fHK/lL4gJvo7bX2M45ORcvBuN9PrDYOOUK0hT5tJ52JD8ab6Y71XEGfGlF47+Vp+H57gZWRfm2Zyhs4989pNvOJ7zIbQpm/ofovz6TrBKzZfmDGUZOd7BwkMayQWbwGOTDuPSdxuExztY9AMWr7EUPH0UgskejW957kdTLqgf2k5Wn0TVIHTpICt1wqpdhil7UEHG75FjWjBEN2yDGju/jIOVIlxkt8s3foWMw0/l5jwOpeXYoyZISpT+qkJHLGOh3bVq8vxDKUnintISHvVooOTCr/mxmlJQ1I+nLfceI2AukCsKvtqkDt5Me1koMHEusBL1z7vthq13H+A7XCB53OBlxxlimyjUW/ElO9EFtySKH1tvICc0/fc7s72TQIpwhGInnsw+xK+we/sQN9nAzeEogbxcTr7BJqI33hs7cINFFBqzbCor6hmARggZk0sqy852jW3bQL06FfLiFogB98KEyFEKVdiJldSHWeJjMbJ5hLgwNkMgtkFpTdL9NxkRz8gYVEnMAeoEF2pUWouGso=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VdgCijvH0sbdgxcrUML2mNeTPoqYWrgobJ126p9Hyow+A+uYuDAjyMpMA51j?=
 =?us-ascii?Q?GRV8M5Igog+lhG2Wx5alWcK+u47pBZ2awYSkMPMb+OL2BCtGiBs7sR7l6P8P?=
 =?us-ascii?Q?3hPhqVmqqPjNWSfOWynGXW5/RzRC9aMR+NO+yjNLWLZSGTOZ/8OMxvkoJNkH?=
 =?us-ascii?Q?+MMQp5Yb4Pu+lXbGov19mxPjh9GkmFd4sIKeFYTLHrH1iUqhEDwEnVAM2qhi?=
 =?us-ascii?Q?MFaCwyCnqrszbMMpf4h+w3VzfK06QqBhNPzNYtIk1h/rBPOj2m8EWPj9jQXU?=
 =?us-ascii?Q?sqNndmvHqRDlKy02isYXoc2QudMAYmfbQFtQ7fAx3MqGbCozj2fkD8wmDQLH?=
 =?us-ascii?Q?9T9qacWICZM8+ROvpxzbEh8PR3P4l3J4+PD9uiG6CzYqG87IPz5GJpQUmkhg?=
 =?us-ascii?Q?zCfpEhgqynzsSJzIcHapiI34srLuhE4qKfFrzbAYkdWg8C19yDjQ3g/HDZSi?=
 =?us-ascii?Q?ZZN6CrnR6prlDfuQoLNXPl8GCJHhTZiuK/J96M2lYhQlcdcrWZMXoSz/ddto?=
 =?us-ascii?Q?cWeyOjQxKUll8MJhhn4K8IfvxBJNGcL4xutG3EN7OVI+0cWnVKfpKdzCzG5o?=
 =?us-ascii?Q?iaFNuBRbUdn4ri2jwq5giGjaYcsjsy/zExuw8EJ+s9gyIoxdY5Yi5E76ecab?=
 =?us-ascii?Q?GEs7Mk/O6wH0z0y23NcbSBzmhImoPwtnhdaNJ2EBH0E6wrH5LKriDXxsuFZ/?=
 =?us-ascii?Q?ZAcMveuCZlw4EnvA/njvmX7RL5DPhKQCA1Gm5MdOTukcHNtXBFQySHbGCWAV?=
 =?us-ascii?Q?wm+Qvc8nENGe1QDZTh72JyFVlqpx/UH9r572+r4Lrq9mOxrtvYlu5LDRx8Cm?=
 =?us-ascii?Q?SnKF1Cv2DBGPO28PKlWAhi8XrfbrFJkH4zCJki6yKB9A1uTDOwGTCy6zXdXq?=
 =?us-ascii?Q?7HG153/30RkiUMvwmtx89ltnLmeOJ7mf+Dozefy4kriWzCb9TfS4WDErqIL3?=
 =?us-ascii?Q?tKrkt0/QuBUL+HxBSsTlzvcwXz5MsJzN9ax3JWkPPp01NP0EYAHn8eSNYPkz?=
 =?us-ascii?Q?hz7/DLU9B4V2dhXG5CAuH0Ah7/rRjlC79ReWfB/Pb+R4kQpE1nTkhyjqbR+G?=
 =?us-ascii?Q?NBIXe/xbS+4LvHzxOkbOVpBFgqdyEJKdRTKfp9mpRC22RpIPvfhjYSM7Mg8c?=
 =?us-ascii?Q?0rbpbK+fMO6cMu3jOJ9CoYRg76inx1uUHGsVZSYkkz5SWQlqozCMKPW58Flo?=
 =?us-ascii?Q?U1wmVCfe/A5NRdSw4SD4kpcPRS/fp7nOGOu0hTpchJqMOJEH/3iKR83mT99U?=
 =?us-ascii?Q?5iVUurCdExAgeccjIetwDmZG6zkNsCmuGgm1olBgeMHakb2oolx3JhzZAx8u?=
 =?us-ascii?Q?3oFK2qM5tA8/3GvliSEBDH0EK9xFRWN/VgbIxCbtqGd+u+aGyxwl3DkUBWfv?=
 =?us-ascii?Q?k12m+uenWL0brJHL/QHdzRlpgCRt+5en9KWpj9GT4y3O9r5KTMO4LHfQFUh0?=
 =?us-ascii?Q?PS2mXrjLdQaSHkib5I2eSynyaB+YeQMwc7h+BVaiq+yAIdiECQDbukCeGRa3?=
 =?us-ascii?Q?+BkMxCgubRCfhZgFq+H/iOLBh6XM/DVw+XzeFpfqFoZsxZUjpXpC+Yc+QYKn?=
 =?us-ascii?Q?EqNlqrK3wC9kHyJL+HBKA4rTszJLn7IgdFfyLZ9pqItN5kjlea6NJ09DZjQG?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j817jy4b9s9LKIUeRErQwQaXNTpxhKYtk1kkU8sVEPLxwb/kLiBVzn7aS2ttsIYFtjuoC7XnVSn6XXFkq62IBIwMH+Trok0y1qCn5l2rix0x7fWLB/arxA2Ei3dDf6WWMxmK7/VpwuRZXXJqwmYYoyzrVmBGFe+GS0XnOnVHrPyYVZCcD8cY58GgxARUZEuFo103LFsxIkXT4EqLhpW7A7Ee5oErlqfi+GzRMRI3jUAjoYUMCRwsp/UCoEKP5DlSoji+hH3KVnl9u7OjSRLi+aISBB2gyzJBdtqkVnVABKsUFuFonKoOmHOhxSqH72Vv7q7JcZrNg2XKJ/0RWA9+Ik3Ocvd+nLNK/1ROhfuSmNUcpWDdZE8uwYPVGB6Bf3/YFagbnQwqAyRSbb12nIbGoihncARf1+OIvWyDA5MHJvG/e7McQYO1u6Gp1CJtYFms2Emp9tk0eZLkQjIHHBcC39qBU5CvKkZ4TnV+boAucWB+bzFTIWZJeyumWM10J78iVuV/gnzYImxGUGALcpP8W0sWXzAB2st6cUbWl1g6SVa+97ozfT2O9VxmJF6rN3kMVMRPFitm1dEYQzZ5FrotX4XQZ9k/ySeWgor2GIwhGtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a933b4c3-82e5-431e-0420-08dc3f22b24e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:49:03.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDA8oQT9sE/8vIzS9MdCOSMBPbEjRMVMFzmbonITJWXCEh+2ZCGfDh0LrT19Kgr8128LJR7Kk7x2E7WjQpdLqc09nA5vf/G6nPghKOEx8f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080028
X-Proofpoint-ORIG-GUID: nURfnqNHT8kLFd1kloRTZVzm7CuN5bqs
X-Proofpoint-GUID: nURfnqNHT8kLFd1kloRTZVzm7CuN5bqs


Joel Fernandes <joel@joelfernandes.org> writes:

> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
>> On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
>>> Hi Ankur,
>>>
>>> On 3/5/2024 3:11 AM, Ankur Arora wrote:
>>>>
>>>> Joel Fernandes <joel@joelfernandes.org> writes:
>>>>
>>> [..]
>>>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>>>>> 'voluntary' business because
>>>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>>>>> is not about the old voluntary.
>>>>
>>>> What do you think about folding the higher scheduling class preemption logic
>>>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
>>>> deadline task needs to be done for correctness.
>>>>
>>>> (That'll get rid of the current preempt=voluntary model, at least until
>>>> there's a separate use for it.)
>>>
>>> Yes I am all in support for that. Its less confusing for the user as well, and
>>> scheduling higher priority class at the next tick for preempt=none sounds good
>>> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
>>> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
>>> that is more aggressive, it could be added in the future.
>>
>> This would be something that happens only after removing cond_resched()
>> might_sleep() functionality from might_sleep(), correct?
>
> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
> he seems to be suggesting preempting instantly for higher scheduling CLASSES
> even for preempt=none mode, without having to wait till the next
> scheduling-clock interrupt.

Yes, that's what I was suggesting.

> Not sure if that makes sense to me, I was asking not
> to treat "higher class" any differently than "higher priority" for preempt=none.

Ah. Understood.

> And if SCHED_DEADLINE has a problem with that, then it already happens so with
> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
> more than the treatment given to higher priority within same class. Ankur/Juri?

No. I think that behaviour might be worse for PREEMPT_AUTO.

PREEMPT_NONE=y (or PREEMPT_VOLUNTARY=y for that matter) don't
quite have a policy around when preemption happens. Preemption
might happen quickly, might happen slowly based on when the next
preemption point is found.

The PREEMPT_AUTO, preempt=none policy in this series will always
cause preemption to be at user exit or the next tick. Seems like
it would be worse for higher scheduling classes more often.

But, I wonder what Juri thinks about this.

--
ankur

