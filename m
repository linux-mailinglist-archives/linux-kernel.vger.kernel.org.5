Return-Path: <linux-kernel+bounces-62977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13EE85287D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E581DB25D17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037062BB10;
	Tue, 13 Feb 2024 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIdPjjH+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HiN2KVxx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200A286BF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803841; cv=fail; b=cuU05bPH6SnHZBLi81ugH7N1Z+5+EbI+DOBn5GZquzt9dwudP1i+nf0zBsElAIQ3Wq/zr7M6tFNXgaYJwdJEqKVXwCKzs3l5RoH76TZBAd3JCnQdu/1nG7gW/Cu89vE+rlkFm4voAi5mVix81XU52bYdN8k9mMxpRmpVI1aAE0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803841; c=relaxed/simple;
	bh=e7K4s8NV1Z3WsjSixol3ct7UiyOrjWtYHg5qnvnaGdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl+33tTVnXp1V2Zh4WMrJWps79AG38xCeiS+8OFUwZOkFe9ZyW9kz+xHy8D1LDuuLWzAAGZvNFEn+seBGQfK5W1t87U/K26l8oRWYRXwxc0t1inlPHVEbKRA521GDBp9u03re5xjfA0WJL8rArdLu92MDgzvtzE8m9GensUkWT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BIdPjjH+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HiN2KVxx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5TnRS003524;
	Tue, 13 Feb 2024 05:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gMxzyHoRAAFPam1OfV6WHYNcwGnxqQvmOgjxa1LeBwI=;
 b=BIdPjjH+7RpPj/h0OJXhpg+FxRkskdnrOqBy2UBuXH0d/Lf+VToFdpBbT8Z3HpkY1GKJ
 015EZxUtDNUT11CD92G0opNql9rl5v3CU2zq9KJqxjynAo1SIMyKyApbbigGG3CZklhh
 EmzihM7bKxKC9ckiC2/UdnNN53A619FbY/9Cr6cnF2eeParThSBil0SFEXZvHKmOnqfc
 Xq+j845elcyaBRTsa4jGvTpFcoSRWOu2IdCzn8qM/4r6ul1irB940sxwEIMKOhHfCBol
 V0jPmOcIrrLYYxKquKMb7djl40iBIDJK1gtVXXjiaVQkyXlgPFP0cQI+DKG3kh/WwcfO dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3VCaG024670;
	Tue, 13 Feb 2024 05:56:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3ta7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Oxl/dULl99a80+zDn54rpb42tEE9ESpiwBW5S+t5EIjRI4EHHvYngLjDZcW0zkJ/3PY9hPFJy4R3+mGWe5JlzvdODWTrWtet84Ydhuto1uEmN/CMQYZiSGrvyyAGRbuM9WSDq3oVAHBn2+VuDoRy261NbmS0B9Uqp6BYBY2TCavSL6XwjEiOODUVwZ5CXCsbozwq9d2wu8YNr8iAu+9fDkpYLK3noUEcVHcyfUMKaqHh3WkBwqXeNm4sfq7tnc9DUbVxaYXTLyslZ3Qs8a0YdifSQ8hB1ihm0qeGScs3ZzQXorUaAA8hnOcyL/MApHzte/2PI55mMiSurBE+s4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMxzyHoRAAFPam1OfV6WHYNcwGnxqQvmOgjxa1LeBwI=;
 b=SK5F44kvV7bVsY0f/udTuxDzes6c6lHCQgY+s/Z7gk9Op+S/MsdUEVxGvPakpdvU2aqu3rakyLanYc7cz9e9nmB6taB/I/BV5Hb0QAkKBT4Wn8nRYXVowhh/DbtC6IO1CE5r1gO+TyDR6fLT4RqS4uQqYIQ/Izf+LcRsrYNWgRlE90DdGdSCfruY25jGmOZu33n9GgRjEUue3FjnDgyShSNqxHl29eq3WhncJx9YKb7963MKEcOT6zse/VBUBdbL3Yy2boM/5IcaxSzjwWDU82WMGGMEQYDth54jWpJ98pfzNXEJk8Okks97ENxXcDDaIp4nFGLIBp+ZOPPULfxvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMxzyHoRAAFPam1OfV6WHYNcwGnxqQvmOgjxa1LeBwI=;
 b=HiN2KVxx+A8Se+1l1+pdq65LxZFMtLUyuq2c6UaZ+g4W2z7biNsq/bCgYtkDV5PQco6YwVAuiHHUm874hQYxxEh8lGDoaDkUTVdtYPL+5cR/maMEKbPumjkXEZiJOp+HIy3s77yLmSuTBENCfofH9+zyq/NYclVFpzNDaVzYh1I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:28 +0000
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
Subject: [PATCH 18/30] sched: prepare for lazy rescheduling in resched_curr()
Date: Mon, 12 Feb 2024 21:55:42 -0800
Message-Id: <20240213055554.1802415-19-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d28e10f-5a89-40f4-3e55-08dc2c588545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wL0dyXkrCY0mnw3Ap1ZdwN8ygtBYarv5SdVAHvYTT4eqQLAPJW4dZmEJxGDJfsZogcC1TDdyNLd1YveUagGBBAkqvqi1H9tf+PY6cj9qKwsl1eo+MB0QHKMmUZxf3noWtYquuG6MtO+zx9/5zpEuy9YtmZXaRFQurb6rkR/vJHOPNzLGGOWmyhERCFHmYq9VrBN4Z81xFgOyfsu4yaeuGiaLs0cmxflc4bXQhwWl5NB6T2B8A1oy4ljYZRMGI6tnWNf/2pYT08vCwkfJp1H67riNe4bjdj6AOcOoFPk9iAOTJAOo4HZTSOAG/T6DiKknfDooubqV+ux/y2M8MU4tvliXenDBxIzugEIyUuq46VR4o7WB1Rv3U9oBU+hA9Uk8wkPdpNddMYg+9nM0AuRCevV4NJ6JMOSNs9AlSfI7s7oH46Nwq5zZRutNXwxhZ0425IkrFIMpZrqLNONPzf+8HpH4m3vwl1v7vcBToXs7TQ1KSDovohuuj4O5cVwf5Kiwa/NVE7yd+LvXrDQbefHbNneXrgfY9ymhhCM6ox34oHU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FE+mOfg0I2EiujKadPkY6tXFf/j+qpNm1JREOYyly30G0Ijq4GEGCBHUvh47?=
 =?us-ascii?Q?BHKZus6oTI3c/MDeTcgXXztSLYWbs+7okXyyjIz77a2U23IzrRQ7Xvi7wJnU?=
 =?us-ascii?Q?c0WrrLHI49Shu1GSGzeyhqdQTRztBTacAOuAJOQgieiJz6pL7fQj1HaZMBms?=
 =?us-ascii?Q?xc6gVD0VYDJq0UEWkoNRCn2Waetg0iVsghsaKawfw5YaRemwtECa9p2ysl6X?=
 =?us-ascii?Q?IoW2P35e4sz/EWE3Cwr4oPk8Hgs6S/nD62kw9E82F6AcHSftbbBVS/qAJg10?=
 =?us-ascii?Q?ireEzGUyH880rlRYroGICx1WARTgBLgtZHgJD6TthTk5jeMKOZQKpzmuMDhC?=
 =?us-ascii?Q?XeuYZpfLz4ls5veE+eTYtRnKhR1yCSQZU4c5pf2tN4qaSj3BMbgZ4vAo3hpt?=
 =?us-ascii?Q?8En4caNYRQlQujK665uQYTNdI7mL6KFah3rDIVK1gCni0FKjrVMEVgnUDdsl?=
 =?us-ascii?Q?WaSHUY/e9LRtFHF3k3H2IHGpG5ZX1W/3kCD90qB8Cle9sCpj09brkp7c1Rdn?=
 =?us-ascii?Q?y/xb/9tuQNLowkZ+pjS3i3WfKVidebYWK+VDGXHWfiOYsChTQCC5ehb4GwEI?=
 =?us-ascii?Q?AcdMQVsEKqLoPgO6wxD8HbBHc1B1Ya+zDvi397q4F31WOZvgU9t+e1kEhhBj?=
 =?us-ascii?Q?1pszZ5J9h5qocv56WwOSgY75zoTgY3NHw/A8K8N+WMO+e7s4EH2XUMZ/vf7l?=
 =?us-ascii?Q?NpH14Li2xLjx0prlQD8d6cWKnQYrA/+jEUFkJHjnS+ly0W+NiMTXUI/g6Sex?=
 =?us-ascii?Q?4PDx1iUvCE3qS3a9R1LzdrJzkQHiknP52jmyHEmACXlsbuGr7sKDVf+xmR6n?=
 =?us-ascii?Q?pHd7Orge/ZhkhC91KLjhQQYTAycmJVSNTI74O69hSw88e9czzdKfYZvmMHmX?=
 =?us-ascii?Q?3uVysxSd8du1u/wbXAyAjFe/1L+tHnQ3EOO857iSHlEhxUKSCEGyOVTNsZVz?=
 =?us-ascii?Q?V+C8khxlTdZuWBcFcvboTWBQnH2x/mMX2edYWPzqJ3HvgR59i3mDttHPjYYO?=
 =?us-ascii?Q?uykbn1DqBoNSSdWx4r7mN8y2FdC9r6CVA52o8v3KT8xI64fMQYJIp7FpLuIk?=
 =?us-ascii?Q?oYjWSsZPYB2T/wzXHVD/dEYj8ZIR5R8zQiZONQY0JK5+Waj53pGtxfdu03mH?=
 =?us-ascii?Q?1N64NO2cTDJH2FGkxIrubktaTjMLyGN8xwszrkdpZh0zkqzsJGIgkmsCVqqV?=
 =?us-ascii?Q?qckpgvhA7U3UuFUFKtbH0l3GQad1VMwfISjQnp1Kz58wZeiladZ94tQeObfR?=
 =?us-ascii?Q?f468u/0Cv0k1kvSxOKZ4c3dw8CB7EOMRZ9o0hPHvedgFLTUwcqj1VqrQwZBn?=
 =?us-ascii?Q?fX2hfrCucZ33NmfJ2Q4igXLaJUgMdALZy3t/7s0Hf7Sy5lRfDPNncHhOh1B5?=
 =?us-ascii?Q?Zo2IfA1A/fgZYuVGWdoEOIyIgtsuWdvMnAOTHwb1ebb8+TEgMIRShflzgSO/?=
 =?us-ascii?Q?AnMu/vQ5JGxmG2nXjF5R8FrP+hs14oV3aY67k7Z7ODMtCMNhSP+RdDp1rHGW?=
 =?us-ascii?Q?ADInsD7u1hpxKLA0p9yQYlY4UKexzrbeNTKtR6A1DmV4t5atd8xQmEa0Zivq?=
 =?us-ascii?Q?S164bwF3SOhegYVj6JnbywvLUJASRaxgNBQYU1Y2Q9gITrYCkzdK9FnWAK25?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yTc1hO7N6cX5CxhAJ9054Oy83zDqEWVuPk9DllPp8P7dzEg/gld8KwOJAVR8n9s06L6cvOYTTXQPs2IP3KjLkjbCEknho3366dbiYaiXpQnIvhJ3MWY6RkD2IAZEFZ3my+gUuJRJDiSV7xvP0c6ajn+e3qgcid8W7wCHVAsM30xNmgHTz80BsrhWwikdz3YVhtjxv/qkc+D/k0NHF50dexoZnHiNKzwaXMXDroNmTIV+Qwte+/AJBCwUBdhwjWusCwsY+Omv22RHRodnPgONmvICyx2TiVagzYcAphLZ7wVMSwVnVsTrqvB75RkSkQt9NNez0xAVBBIjywizCdV7X1H2+YHG/WdAXB8+0zca91OEA16gCUBoLM0Te+COLCJ6CW9f8TE/SUzFfyHmMhJxgYvCAp/NPqgYEj/g7t4dTmKltY5iKqIiTUjgYmVGgEUnjuT5O1YR7rnLh/+2DF50mdNj99iTmgtjsuwXQMNMCm9zir0sZNYT7zU57iVoUazk9azVqNhYFt5Olf6BR43IiRaZ9FMmZcAj50e/86imspw1CNF8gE7nfH4+k/WzX29dh4DffUpnPEHdi6WH+R7dMXcivjysJUrGXEI4l8drkCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d28e10f-5a89-40f4-3e55-08dc2c588545
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:28.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qy/k51NDLiOm54X5u8gXajwqxZ788YX/rHCrZZXjdyDvop+EuyYQz4M+Bich3P93sGuhI5JySwmVpIB1VINJyOMreI9QJKeUNTX1mBb84I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=837 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: jueS3Y7whRVoqIPPCuyzEXrYZkYfmTaJ
X-Proofpoint-ORIG-GUID: jueS3Y7whRVoqIPPCuyzEXrYZkYfmTaJ

Handle NR_lazy in resched_curr(), by registering an intent to
reschedule at exit-to-user.
Given that the rescheduling is not imminent, skip the preempt folding
and the resched IPI.

Also, update set_nr_and_not_polling() to handle NR_lazy. Note that
there are no changes to set_nr_if_polling(), since lazy rescheduling
is not meaningful for idle.

And finally, now that there are two need-resched bits, enforce a
priority order while setting them.


Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 425e4f03e0af..7248d1dbdc14 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -899,14 +899,14 @@ static inline void hrtick_rq_init(struct rq *rq)
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
 	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, _tif_resched(rs)) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -931,9 +931,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
-	set_tsk_need_resched(p, NR_now);
+	set_tsk_need_resched(p, rs);
 	return true;
 }
 
@@ -1041,25 +1041,40 @@ void wake_up_q(struct wake_q_head *head)
 void resched_curr(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
+	resched_t rs = NR_now;
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr, NR_now))
+	/*
+	 * TIF_NEED_RESCHED is the higher priority bit, so if it is already
+	 * set, nothing more to be done. So, the only combinations we want to
+	 * let in are:
+	 *
+	 *  -  .       + (NR_now | NR_lazy)
+	 *  -  NR_lazy + NR_now
+	 *
+	 * In the second case both flags would be set simultaneously.
+	 */
+	if (test_tsk_need_resched(curr, NR_now) ||
+	    (rs == NR_lazy && test_tsk_need_resched(curr, NR_lazy)))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr, NR_now);
-		set_preempt_need_resched();
+		set_tsk_need_resched(curr, rs);
+		if (rs == NR_now)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(curr, rs)) {
+		if (rs == NR_now)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
 }
 
 void resched_cpu(int cpu)
@@ -1154,7 +1169,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(rq->idle, NR_now))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -6693,6 +6708,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+
+	/* Clear both TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY */
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.31.1


