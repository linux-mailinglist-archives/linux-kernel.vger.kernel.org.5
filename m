Return-Path: <linux-kernel+bounces-62986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69627852887
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20789286593
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCDE51C21;
	Tue, 13 Feb 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lY6q1Inl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0GHqqeSx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEA50A77
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803881; cv=fail; b=nvGPME5marCEh8Bp7yuKFravG/0pBiz3kM/t0KRtCqdyYZSgFXvO+jBNm3uPviJMbMhxj5ROcYycSmr0nMonS2wvX9iAlB2xNIG8QDUrd61bH0TorDe3VU3LUDb4o0ilEGS1e1KT+Dw9kCK2IMTUHAtvnhUWe9bseGUQgDbAoD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803881; c=relaxed/simple;
	bh=HWMnr0IL3/+UnCwwU/rSW3D61iUcgJaEY3VB3Gw22UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flCRZpkgy7Gq0/0yOLfyiyT5Jme6TAs34ppxWLy3StAlhCon2ld8aG5qF8/JFDLHfvLRbJhgmTTZjyvlojcVXZEXIU4BNo2N6Ue85i0s/LFJbHfoFJs0hSQ+W73ipHXFg1AGIjcvkRLcY+8iYdOcMOaKwoK7q3gVIuREguDVnYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lY6q1Inl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0GHqqeSx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ng4d028881;
	Tue, 13 Feb 2024 05:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=2ISIDIE+DWdtLOJcbwLdBeVJe6nQP559F6WAgS9bf2A=;
 b=lY6q1Inl3m5SZnA2NrDjUiHZw9YdBlBPAKIDo1E3Op3xWlAjhK3zbp5iQtE7ghKNe7Dr
 JGzyabCKvdSD2995DcT6LZG81s8+UhxRYNGoFrtXvIdxQ52B7keeVvF0SXCKyi9Y7mCH
 WDNSFwPGsqxm2iDDIJVbSUNdqM+AfzWGWfuDnnrdaG2STibOIMJAoDMMHu4ZmsXsa01T
 rSGfcirJYkm/9fXUFfdrEmiYSVRpBeNu2SB/fbf4rFRBue+QK23htK24G6jy5ovodCxG
 WlsuLN0NKzT7BP/nUiVR252VuCsKWOcVwbhsINT6B3x+rVMUE0StjyagOntiFRNAmhhw VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82m480kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4QMOQ015080;
	Tue, 13 Feb 2024 05:57:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6uh6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYdRrHnuD4POoNXv4xnBuftpInZJqvHTotsdjI6pkPNHBUbJUgO1UUvjDsNWkH45Ij5hapX8lt1awpBwRF52lNErL0DtsBnzZq/pGTXqBWVBIYU/KbZB3KaaCKRXZbm2RBM3GszVS+qMRXmn9anJjw7U4UieMptaHySnmhLMIA7e4URSDT3npPCKjpyxlNg6CKQ6J6MQyYQQEVguE96j8gvnc/vKMtmrRQQB1oRZJvNgMwBud8+sFafZIiyVVhWnRpfmKZ21Ar1fZtFYfxfa6fvRtHt+HlYzeiiTPt+Ra94VNWSx93Eo4LJ1yaMy62JDMj3K1z3P3PLnEKw1ybtWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ISIDIE+DWdtLOJcbwLdBeVJe6nQP559F6WAgS9bf2A=;
 b=Ifr+Lr7j3BmjX/NF2m+UTa2JBOq83+2fdxAj01O8bT9cmK8tQbRGrQ0p08dC7Kw6m24Pc8oYYH0BEuSELNRv2mtp5TpMzCce0MG0KaEeMQ2yP/Rf+7qdRuL1HuTTvNHdHFDVnboAFfT2OilTs8yaKayGMygr4xpGXQe7/Z3zflfBagskYEhDPirBdF/h0DP7jM1DjA2dkBXXFCSJLu0ycbWGt1/ol0RiiKUYfQxSZEAjk0fcqATf1Po17SIYunLDWGzAH4a7z4Hlb+EkB9vtldU5oky9ow/Yb1rjxBrN5k48EZwRNU2+3+yaJlF2hm21A5ZE/cLxfiqtmVMvAuZ/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ISIDIE+DWdtLOJcbwLdBeVJe6nQP559F6WAgS9bf2A=;
 b=0GHqqeSx476Pc/dEUK41si3+GqSe+UcWRlN24VQ/BD1SAyjow+qrNKUM4Bjjexe1QUpO9P7faSkVNfZH9FQQF0pDRZbdgEJE7tyLctqn/lWJyceSFOYQNvH6JbgknCc05xmlNsc3Q2t/nYpcMUKBtzhbcixYp4ArTneJSiTf7kk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:57:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:57:01 +0000
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 28/30] tracing: support lazy resched
Date: Mon, 12 Feb 2024 21:55:52 -0800
Message-Id: <20240213055554.1802415-29-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 828b5498-a7bc-47f0-5333-08dc2c58991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	adkPco3e8A1sUf0m6vrr6QRN0g+XgKcef4qX4SacAM/Fd81Fu7MtgwYSsBUj7qdvl3uu3LunceHy6IVCOu+eCrSuMKpwCo4IemokO+xgTLLLBBL1G7/SGnmmmwxbAnH3VME7uzYsLmfn9boHh+ua+l0RdiMpBhKuJv53AsvZhn2sGFj3YGkUy1+Ph2h3gZei66pevBD3sR2P9p2dfSfWapX/Oa4rUdutTdTT6TV+c/Twbf05JSMhFGPmCvj6Cg4Vk0VXB9eomVJjQ/zhuAfVBt5Mvpji3stChQ0BMuw4Y8D8Mk+Ur4RWWGKHOZcpRdCzlzDIGW5E9UtR6DkcMvaWz3fKcq60qjB1HzN4I90rVn5GAvEm8TCeVvwwZjfN1nhuH2qUMhMQsBMCUcvrBFOPniu6g0Rrq+3xyHeumodDec+thLw63+xN0rybbpUmbZduZPVwgmmA38TQAq+RZGRXdZIWju8Ngpk0pIvioyx/cKzSyNxmFf/g29W2bNnQIHP7aY94H/0QKO0riAhCbD57u+1fOcigfqb+fL4WTwcNHTY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(2616005)(36756003)(83380400001)(54906003)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qoiYsXh639pejsSB5FoL6ve6YV6FHEVKhPm5a+LoVfgMtY7zDMGfjxmnb++X?=
 =?us-ascii?Q?twJ3WnMts4E8uOrIZgqcSqYMBmwaWkrCyfc+PYzfaBt+mOab1tLMxDAdo95F?=
 =?us-ascii?Q?8Y4dQL4G8862RtLPQ3oCgDUoe5GSbmMPCui7LPZGqhfKs0rN1AUD9TA0XSpy?=
 =?us-ascii?Q?K2KKfpiBScOA4m/jb5+H/MsNreFLMCu/u4c8OXrJOtMFiK8EcA+1REsNyHvD?=
 =?us-ascii?Q?zRg/2wr3fw0q/gYc/pKZnIvS/NY/FesHdoyRfJzZxyArKlh5mtM7frCE7eEG?=
 =?us-ascii?Q?hToHPDBl9gI9mg/DayxaEFpR1YpnR9EN5MyhGOP0iZXxSMy53wSX9CG2KsNX?=
 =?us-ascii?Q?f3BeBX+NxENIVbvVe6J6ghh1cAY0c96EuKnDrYMAHjRiA0A1LjOlWUSnq11u?=
 =?us-ascii?Q?hVbM75fg6VC3X6WsN5k2kcuigVPvsuwdn/FX32qv22nv18UdhxJJQq2YXaGQ?=
 =?us-ascii?Q?pr9+XYUjPUsPPDDVVMD5NfDFauzSg19Cm3IgszSoec3FkZVE11pR54iwqDd+?=
 =?us-ascii?Q?oqDM0DMaplslM6W+qy+hO8w5FvkAreR/Vog1iOdz8PlnLDvP/FpRN+Wk9Wrr?=
 =?us-ascii?Q?KHSVIfNQDTiomndXfkr0s/3S1LZmhTquktqowMUM52l8UvYnFOWI39y5ky1z?=
 =?us-ascii?Q?WWI4m0Cmgv8n9GrgknUytFdMjqPXD3ELfzpre0ebdrOvZRD41JjWVF6BczWH?=
 =?us-ascii?Q?9Y7SPQGxdm/4HglhnTNd+RE8/rW/q6Y26z3xW2RvPLk9slIPOkes5Qjl5xlj?=
 =?us-ascii?Q?kYbeBwegaZCaz3Mz4rP0wgzFQFhMIGkvaaWcWyX6WWWz0bzvcHZnRubVqZcl?=
 =?us-ascii?Q?+QJ3xdrRYWeGudidGmO9iTe7/Qk7Vyo8yWNg3OxcedbJcHMsyNOU8+V1KIYP?=
 =?us-ascii?Q?S4Qa/RUXTT1MBocnoDD26BpuFCbZKoRRbctwtcu2z1q12oQBlb6hJuuC8sWW?=
 =?us-ascii?Q?4Vv9i7I1a7kVkaDG7pi9byrX2h2UdV/KsAAD/kYfrjBJmlcCK3uZk/eqfSVH?=
 =?us-ascii?Q?rZtP/DoYhC70SeSbp+X5accRZ7iu4L6fz4mCC+jcpdvNRPkPZXwnE+ZmRiZK?=
 =?us-ascii?Q?O685+CWMkphSU8CSOHhQEF4zNkWwcN08KEG/uC47jGU7CyfDw/ss+WjGIdmj?=
 =?us-ascii?Q?2uTUBIHLNAucdSfYrsyIEnLv0X2B7LYYGsELsRPZfKHMbddnjzGbL0K08paT?=
 =?us-ascii?Q?c/YpDRRJ26Axc7/UL8+Kbsu04SftblAhEwqPRRULjSPwEdN8iGHawq64fq+4?=
 =?us-ascii?Q?uz5tC8R7gkXUnzeDhGitwoiGdTE3mcLe+1FkNSTRIlW03HmyQO96TebsO3C1?=
 =?us-ascii?Q?2TDrK0SBGy4pboXm2UWvMv9srNyvOSdAB6B08taCzpCnBVAlzuJH/vliqHN4?=
 =?us-ascii?Q?IQFtfP6ELL9IBaDN/deCkEMEPTImZ9/iE0dy9fYSGIgHZQsKxCeJCeCaLi4f?=
 =?us-ascii?Q?hhoalZX45TIkFcZBqrHh2AeF4mEu1565kb1YhfrqWIviItWdXDImnlYkggna?=
 =?us-ascii?Q?G8M21VAgUOwZfC58VvVDLyLGfpiBJCjYKRCdpHGtNjbVgv/WEjAJrqV4LI6N?=
 =?us-ascii?Q?xlwI+uUFW6OgOSxQNy14Z81fQ+iNIQEdd9raqUwkprl+ZgRI2Dm6bFhj+Kgt?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qJqrWrvKio2Ushb/Cid6HMKzH0wiJoF+cs2xEQhGe4ixVpcFZYVM7KrG/n2NIXChjcxjxeqgRVDxFCN/m51pmxMIcaQUMmq4VZJzQmv9HoO0DxVeXa6/VmZLw9O0vKgNiT5CmQcIXpPbNOSqliEYR5WY5ig0pYAZ1LXqJCwbOdyVJx9KhpzVqdNA+R9dV/ZXdBQGuJQAPam9AtKlHbeEmUVwjBah5fqm3iDVpUAt/1cooarJO8O6I5JAozJ/joOeG7d9T/4mAU9Q8Yv5ujOIxnQYZ+TqZNC2EI14mG2q90Hvtx+0umf8vhf/isCMwfEAXaD6LSG66Rfd3s2C/dLNYOaa5nZ/+scJ1NLFUHUYHXLjJva6wurMHJh+Ya8esPiX4ROdcNJ2uNfczhhq7fdt7hMPU0o7grGo6d2t3b0lZEcL/msJDw2NNu0+vFMG/omz/PJBmAU40w7TzoEn8jXwSD51pwjSyxr6rjtlT54NZRf6bUw0vXpAv30Pj7OjvtzR6H5hKoA75x3sVjIZ/v3YEEjETT7SzKfreRbltrZA+FLNlze+Wm8/ONWGazA7yNJ2St4o5fLHXQDm+LjnVVNUgj6QOw/gAew6Oddpz1ktdcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828b5498-a7bc-47f0-5333-08dc2c58991b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:57:01.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfkWEoOpRn+l9IyvJDd8MZvom6wQPYlSL2X1xcmZGbSBfhSbsHxa3JAzI38lR4fsa+o5/jdbj7ZbNFNHKDNIqDpho0FfmM7c/ha9t5XdPXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: yD1AjVAKFwJC5zOj-JdfyINs1mc27Kqd
X-Proofpoint-ORIG-GUID: yD1AjVAKFwJC5zOj-JdfyINs1mc27Kqd

Tracing support for TIF_NEED_RESCHED_LAZY.

trace_entry::flags is full, so reuse the TRACE_FLAG_IRQS_NOSUPPORT
bit for this. The flag is safe to reuse since it is only used in
old archs that don't support lockdep irq tracing.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/trace_events.h |  6 +++---
 kernel/trace/trace.c         |  2 ++
 kernel/trace/trace_output.c  | 16 ++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..0c17e9de1434 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -178,7 +178,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY    = 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
@@ -205,11 +205,11 @@ static inline unsigned int tracing_gen_ctx(void)
 
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 static inline unsigned int tracing_gen_ctx(void)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 #endif
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0a9642fba852..8fb3a79771df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2703,6 +2703,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 
 	if (tif_need_resched(NR_now))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
+	if (tif_need_resched(NR_lazy))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..5e120c2404cf 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
-- 
2.31.1


