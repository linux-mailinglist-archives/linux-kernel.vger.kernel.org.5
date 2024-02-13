Return-Path: <linux-kernel+bounces-62973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A331852878
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C901F21717
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB528387;
	Tue, 13 Feb 2024 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NBVXKK75";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhqLIKIB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BF2511E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803837; cv=fail; b=jBWfmIr0YUyh35UWUIn2Or9PFTB7U5y1pycoD9eLFn2rCsk+zQCF7JEvkJkg+85+aAjHiPmklzOEx/L+3gALiWVdTNuX3GpljH/aAJp/jR1jrSWbbxfZia0zzGjK+k3g/z50Pa1zXsBR/MwfjatIBrh5Sz0syn11LJB7IqkJi4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803837; c=relaxed/simple;
	bh=/90XYadXFTygsq5FGeOpqbO2rUJpNQfPfSSpfzZRxIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQDnJ2DK8H6ZSL104nmr4UbfryqHAbk1stQgQ580h3X89ivjZ64c7H0m6tuE0j4Z1TPigKQacQTp2psxLn/LX785vQ4sySnmm4FfVjtXp9KwRcyA/wYsxS++ZRxpzgZdTg/GCq8VrNKl4suobMdU5W5xFwXfuOs/Vh76bfiyb8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NBVXKK75; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhqLIKIB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ZIP2006358;
	Tue, 13 Feb 2024 05:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=tX53l1bK2rnTg3wwG1qVz+NSwR/puAnNCzHLHDiJUvQ=;
 b=NBVXKK75MemBbKZSf17WMA7TF78fMY+fGRn2F2+GkuaWHhK1G/TSIhpHI0ZXCQKUO0ey
 bpzLeHfHWzCWoolIQVIxCDENHl8lg1o8BR/n/AvYv9EHyA0ypZVZMl7luqQI9qNDRiiI
 PtZiSFESGtl6Sp91XbtVdaaE6UEtTj+D275QDxx9QoH3/OW9m0WhxssdKFWKiYQ/BQEr
 EtRIP/uPhvBN80KSstTnVlHrh44OUxjRLw/8xPqZ50t2v5+n5MLxwVaVmH7+UEufbIM/
 h7t+hZQEYIfJdk00IGXej0gMmUdVscjqyAZ5ZAY9E+/2ti9Qx0TFSh8PphXr8jpXTPRT VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3VCaH024670;
	Tue, 13 Feb 2024 05:56:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3ta7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgbr7cbNsRU9E8FF75eXiLFrOXhxbKcCz10sJ/yCZHD2skV5Jll54sRM7Dwgs+0V3Aw11bM0kQ9dSLZfuHG0mWHnyvhVlvBpk/9xVUlDmC8Vm7Z7QSJXN5ZFGZSSRTrKJQ6aRXEKGkYpsyo4Da3KA6NMLkiZb/6fIGedmTNqJJ0nSXdU/KuOH3PqqtU8hkOz3XY2tb4vhvaDg4RJSf/bmFb7JixGNw/tuO/1v72E2aZaoB9Z0ts/5mIIq8A+iMVVPGJPfOZP76dgqAGSbUWbZ0i00qB/Bxq5cCw6KasBxNejoLIDm3LgZ5I49GKd3lBJ5LI0ZjqYpeQuS92WJpz2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX53l1bK2rnTg3wwG1qVz+NSwR/puAnNCzHLHDiJUvQ=;
 b=K/CyvT/aXCAIXFAHSOfMu5ENeFdND1uUgECLWDOFu8fC29w+F0WEbQBI38P2qvSJR4vpwwG9gRXs0RGdOSaK5DeTl5WplyR82QpaJ/z0VCuZ60a7O3aaBCdZ516/bJzyOWnOhbEzpHceFaGYPdVNft3Zu568QxD9kaL7qllHinYIY983M3L02+X8oaySLGm0BM8Gf+SH8F7mvP0MOWOGIi+3uusBUfHlbNOrJTizjxheYTHxIISytVZXK3N0V+NWam9x0VAt0Oy65x/KGX0p1E+63yYKSv41yOmYRmE+bbOyWal1bXKoKp6EEiWV74Nym3ZeTU25ZQbbzX0ISVrSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX53l1bK2rnTg3wwG1qVz+NSwR/puAnNCzHLHDiJUvQ=;
 b=UhqLIKIBp2H7mSgADOXYJqwICV+tNcVh/krO6rmqqYhPQCMonLO2zlmdRm9fWF/bte7IHvBGCLOdcnm3y+O8hl7ItjR2Q9PmGkOJP9MT4r2rCdgYubFDRJHxNnHCGKq6Q10uEhrHDX0JZyJq6eMGmVD77F6SQE4OEhWB10JyhUA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:30 +0000
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
Subject: [PATCH 19/30] sched: default preemption policy for PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:43 -0800
Message-Id: <20240213055554.1802415-20-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 8444f64a-3861-4f97-659e-08dc2c588640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xCMRmwIdmSKAv/MS8NRRKEZ6Aj0+5qVDYrNuSyqgO43dGuB/RwKxUdi10q26AuTzetlEJQd+SzWMGMSzJxMEhUcq5lFsNqwkIqyBcfEX9LsNaxhOnBYW8gWs0vMgZa8iTMHB4DluKoecndyptGinY828qtSdlr0eeWiYjEQYtAO+JUHxe19WC3HENWW32tBsoZYPkd8LrjxgROQlyPue/W41buedBQnjfOkRxCmndD20O7BP3ta66bSkH8gNbGm+or7GyURrcoVH3/KIFUSrxSmQl7dWksj9WLOd8qGMTcdLeE9qftrElOVD3WJnkRaH0xHBJTyYuqDIi6Ol7+/MNZ9qwkPJ5oRC2j/GgVIhoAkWG+InMASq3++52Yv6HJ3w5FVW3X1wL+tSdoJlgZphuMaJub/G8a4ogonVNLGJx8xDjXE2qPaBG854ZRwRO4Pz3/fempoyk6P9k3flTux40Yn/4+aohrLle9ssEqPDtEQaXC2eAjNNWtbjkIrARqMcfapucb/ggUI5LgjTCElGFj19dPO695ilOVqojcU9hCs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L9eTBW6uGl4TzERnqcviUqv6YJEqR8Io86uyaNN1mFCP8tD9ojvj74QwPwWW?=
 =?us-ascii?Q?EshVqvDrtgtgy717sRdNxDSc6+/kj4EnFziIPYMlN7mcbtTfPmDgITNsh+mc?=
 =?us-ascii?Q?IJSIiSh5MruC/vuJ52zoPticgRiw/zkl2lPlhkI5mdZctvuIMnDP7WI5o/+i?=
 =?us-ascii?Q?HMrThg2WzTXvMuk55bz8flSLcBMPHX5q8343QSn6UAATMG5Vqmr/CotTGwYs?=
 =?us-ascii?Q?/I8OAhyv36l8SKcaYrUw/oOTwyG5qzecfs7vVDs15jSc1VnOaoH4YfaRRNvN?=
 =?us-ascii?Q?MRdSNP6F1ZGqpSKnd17ebVv/7aRe8JFcztyNHoJWmRCz2Rs6la9aqLluSXxm?=
 =?us-ascii?Q?d+qUpgfN28u5+21QwZqckDs8Mxv+yMxoJ9ZWky/K597NzblkyUDfX2Bq4gDr?=
 =?us-ascii?Q?OxwUoRHcD0iQgS+pnkItL9Z5F3Be5fs+U/ZIuB6M2vRbBnF7wHbNHYQH86LI?=
 =?us-ascii?Q?JzU3x/lw+NX+fn+0fnp0Pg0PYYoDZA/uDVgwZ9HIW++0SKmcfFhCgOa4MWQV?=
 =?us-ascii?Q?AmfdtntB6k2nBBshHs+bSb14oR93j2oGQ4Wfhw4mXixOxJDs6/TPmh/SpPya?=
 =?us-ascii?Q?bMNAOy45hPB3uVlIe1era4mPOvdClNRIpV6Sqrp0f91IBFCBLSnDIsQLlA2m?=
 =?us-ascii?Q?AluU2lnz2HmS3t94llBYu42IYtsndjyQjhhb93p4AQP0kuVQ0jNhOn9yr0Ij?=
 =?us-ascii?Q?QOh8qBIt3ArtB//tV4wvOaOF0TVthl+E8UFkGMh86ZkCf2N0hK+nrIhJI2y4?=
 =?us-ascii?Q?D4Kd53gzAtin23LQipYDSP+AOvQQHuyOKLCdacy73kXTu0kA2BgZffiiZm2Z?=
 =?us-ascii?Q?WNHst7uRDdf5TviH8NBm6/ZEGseNBkObi97+y9PkiaLnt/EfNB19p1XryaAN?=
 =?us-ascii?Q?3TknF1vj5/R2BVvKrjeAD50rF567mg/40sC/qjj9iBwbnzKaeF/txLnzUVRS?=
 =?us-ascii?Q?snpDuPeeb+Fy3HrphbUpNRmVT6uZmpxwjPQuhTL/nc1+XUOuM1bZi1Kghq+d?=
 =?us-ascii?Q?9xQ2k3fmnHnlRXyBrEA9Bmw7B3OKu8IlSItJRhHX02WabrUKLQypSX0Z1v7P?=
 =?us-ascii?Q?7bhrefWcyP+/EEjZZUtJF3JtcKCK/mPCiYW39gMqOFkxI0IcRhnGN5FJOPJN?=
 =?us-ascii?Q?DjpdEfYWHNVr7evXsO1RzEwNZpNj5k1SkMpCtLwIWyKeONeBArXwSJFdDCgZ?=
 =?us-ascii?Q?wTYRP3OuKTO+h2qV39Zk/CfdeVPo8dx0ez7+nATBd2ylnQdA3qf62c4ebCnp?=
 =?us-ascii?Q?MMymJT2AtRYVcDu4ia/A4Flcbhvkj7UY0D+h5B+wjWjHSSVkzJfg0Rgqv/cJ?=
 =?us-ascii?Q?H0Ne9sEL4oevsPayBwp5ig1GwrOFxTOa8rbrUvPrJqbTI8W8UbwMbs+aOyxk?=
 =?us-ascii?Q?uDbOgLpFgbc6wXJtMMbk0hhKRMYgaISqnD+T4zrKnIdNl0jZh+Jz2aj3SrLG?=
 =?us-ascii?Q?W1e3R19s+0HhncQoziuVgtI71agS6wvgdkv5dE2Y22Kixdozaf3gDC1xBkRl?=
 =?us-ascii?Q?rrBG3fwNnl+uvybfvs1RP7Sd3qmxKnLMsfpnzCPyO5OI6aL1bBeg28X/Fyb/?=
 =?us-ascii?Q?UQhcGChZgQm4xTJK1qMdwsJj9hcRDMjW1aVAPBy7REj0jJYcuBLRRP8Vg55V?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7/9WKKaKC5t/FUUCnvuIGXJpn92j+6rh3c3NglyJQ0a89XjAEOliHZQGswRFWeTFOiqVGVOOlUVYXNTdLlHH+RaniKYUHK986Oio/GWVW+3g9Gp9H1nh0PoT3ON5TcqrMpBr2rw1ZjNFmp9xUfl8X3jEKdnizmsheWeLIA/d27XezXe2pmK7A47XkqjXXJbrjMz7/ltORGqI4MMJ85qO1HVaA/qscPiDaxaURVYDwIlasq6vuZt6ShTlRYTxQNzp19CkXD8TCBCblv0kFhJy2L06Ibh3DnA1/KuakZTLdHxMOxaTof2XsH1B9a9wlnX/islu0bBl8i/5vzxCkJMO1uv5hXBLyyYM3UrSKQz9ibylsUOVJQJjeYmaIy6UQHALOCI1G/OSf97vV6MzwJAD0Ix9ZdPEdw4+bQ8rkvhcMANKbg1AbYwXcCGpvXpdKFgGsYTry9b5UIMuX1YrWb3PLXf0oSh8jM/vEN+PIGpuWGlo3mAAU8DZsv3YbRae/MaZDSAFn+RQ5EskECxYI8mBbP3XZsKkfWsVJ4zt2ecs6FUV0xnTYs9kqQMsCUqQmwANrz5el9kTq9s5qdapzVa4QRCZAqoOsooKUuHL23mMCg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8444f64a-3861-4f97-659e-08dc2c588640
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:30.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv5ztFBTOIFEiG7FMm+iJ+hjYmSI13jHwz1ph5MRQg2J5aola0uwSftOkTSEc7Cl+1aLe/8V9MCMl+kFnqJSt2Ly9BRAUdELZsS/ERH1ld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: 3SKrLiFqn9WTmiQ75gJCVKIRdXPRzCQ_
X-Proofpoint-GUID: 3SKrLiFqn9WTmiQ75gJCVKIRdXPRzCQ_

Add resched_opt_translate() which determines the particular
need-resched flag based on scheduling policy.

Preemption models other than PREEMPT_AUTO: continue to use
tif_resched(NR_now).

PREEMPT_AUTO:  use tif_resched(NR_lazy) to mark for exit-to-user
by default.

Note that the target task might be running in userspace or in the
kernel. Allow both to run to timeslice completion.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 31 +++++++++++++++++++++++++------
 kernel/sched/sched.h | 12 +++++++++++-
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7248d1dbdc14..6596b5e0b6c8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1032,20 +1032,39 @@ void wake_up_q(struct wake_q_head *head)
 }
 
 /*
- * resched_curr - mark rq's current task 'to be rescheduled now'.
+ * For preemption models other than PREEMPT_AUTO: always schedule
+ * eagerly.
  *
- * On UP this means the setting of the need_resched flag, on SMP it
- * might also involve a cross-CPU call to trigger the scheduler on
- * the target CPU.
+ * For PREEMPT_AUTO: allow everything, whether running in user or
+ * kernel context, to finish its time quanta, and mark for
+ * rescheduling at the next exit to user.
  */
-void resched_curr(struct rq *rq)
+static resched_t resched_opt_translate(struct task_struct *curr,
+				       enum resched_opt opt)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		return NR_now;
+
+	return NR_lazy;
+}
+
+/*
+ * __resched_curr - mark rq's current task 'to be rescheduled now'.
+ *
+ * On UP this means the setting of the appropriate need_resched flag.
+ * On SMP, in addition it might also involve a cross-CPU call to
+ * trigger the scheduler on the target CPU.
+ */
+void __resched_curr(struct rq *rq, enum resched_opt opt)
 {
 	struct task_struct *curr = rq->curr;
-	resched_t rs = NR_now;
+	resched_t rs;
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
+	rs = resched_opt_translate(curr, opt);
+
 	/*
 	 * TIF_NEED_RESCHED is the higher priority bit, so if it is already
 	 * set, nothing more to be done. So, the only combinations we want to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 34899d17553e..c3ae70ad23ec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2462,7 +2462,17 @@ extern void init_sched_fair_class(void);
 
 extern void reweight_task(struct task_struct *p, int prio);
 
-extern void resched_curr(struct rq *rq);
+enum resched_opt {
+	RESCHED_DEFAULT,
+};
+
+extern void __resched_curr(struct rq *rq, enum resched_opt opt);
+
+static inline void resched_curr(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_DEFAULT);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1


