Return-Path: <linux-kernel+bounces-62978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D171785287E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E101F2163A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27098376E6;
	Tue, 13 Feb 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfGumtUg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G82c0uqf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F313717C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803850; cv=fail; b=IwEGvCIsE9oXPyWG9uFHljjzfmwdqxLEOE74Cz+bPBc+Empbc7hxLFUygO8C+Mlg+Jxd3Q2DAwSfTcOTX4S2O762epWzoWOq8zHIvCRWNeo/0ira6DRsQIVWqfokp/SGpsyNErs9jF4+bEI9WxEPqMkv5KcHiLUpSSYcRvVGAi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803850; c=relaxed/simple;
	bh=Ft8y8OngKbzwDsZ+tglqAARM/IdDnwoeRLwfRMUNrxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON9vp5vjQ8TKq/v9WhYjX4T5+scwSddM0/LE6Z8s1edjEvEc+gv4oRY/D5BwoDFOTg0xoy5Y3QB6wN5oVkpDlrI5f6xGYp+VYp+iY+MxouuMPhvb57DpVWohJuKv347ilhhcQgJJe06jtv2aa/BhUeG1Hss6t7R7fyiQWbz1wFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfGumtUg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G82c0uqf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5UMxs005162;
	Tue, 13 Feb 2024 05:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=tCiSuEUWQWMydIOayxrE3q9Dd2AiL5VU7dfnq3OK/JQ=;
 b=KfGumtUgsXEtXjM7v0gQnCsvzDuOptWAUUAGUE0C3eDPc9NXxEmByRGsDob+kK3blXdh
 003VEzF6pnGhjc4NUrETa+fbGp/qkxHHmsKFTvxmdfaIM0QbuEUZVlMNPexdZPOh2e8Q
 fJ0viA+jipSXXy+c1Qg5KZjbdpxhAWit6LHI/hJlBwyGfBDwWtnIWuOn72+y6/ZwJwRC
 agRF6EW89n1auocDgpuq16t6RI2cudTKF8cGo6m3r1YGM31jL+1vJkmiiWlv09M4P1zT
 xzS/c7EvSO2Eag8q+61Sj/P0TvHPR6RMHg/3nZ42rZEba77mvXmRbY4O7K8vaA0yPn4V kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82atr1ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3XGSJ014943;
	Tue, 13 Feb 2024 05:56:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8JZ3eNVjl1qS4Y3FGhQN3c/hPwv3j34Td+3fM6XeeC95QXfGtDUUSEnYprGEkiCkIoA/wEaveJp45LkwZ7KhApholBlWKgXdCidFQZ0QMPVF3evpZDkp7sH4UJQSDB8DO5wxIajW/iZxZRpLNEHboQmkX3BtgTr5blBb6WOa6yQlXtxcEODZ18LY0q9g50FVwZqldVAhCBpfC/+VotbC6YC2TVaYl9FBr07ln1ruCuXSNInTNtOphOcMkhtZ3EZbOyid5fGJ5OoG6sZckr6oD7WtOM9ee3Ts0Yp4Zcmc5BXEOzqS+x4+FD+BFL7BzFGo33XFtMD3gT1b4JiQLazFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCiSuEUWQWMydIOayxrE3q9Dd2AiL5VU7dfnq3OK/JQ=;
 b=b73R07z1rNUyWLxCmW1GeyPZyDbiY+tKDxbA5+KMBp597/RUquMc07S2GwHvXiy3lJGUxhdNBof0vf8uZknen4ZRkFwhB5cLDIv6Hp0dfnkaA/WVSwoGeS0UQvOagPxN5gSBo1RGzDQrIeSjQB9XbF4Ezd7iDf31TzBN2FaGnJjXAIQzSFeEy+0+QgxUKLH6d3lm+SPaPWMXKcD9f60Y6tD7GLdDvJjDjg6ImJ+LUFH5BJAj1LfCqc1VQRPLUMMZT+2IPwbPE4r6I/u9XYb8Wo4vTvw34w8RUjBT4oxcbNWdaiGNadStmU/roQUlL7kMIcRY1XgGWGItDIVbKlOq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCiSuEUWQWMydIOayxrE3q9Dd2AiL5VU7dfnq3OK/JQ=;
 b=G82c0uqfc+uqjyumw8EE9WWfFzI5hicbZKnGB5civqtE2O+LHdWo2oPFbx266CcCeCTdGusZO51/Y+2lO5HFQZCqaPSDbe1YLiPMi/lhi696+IYaETaoaB5QHAsxT3ybS7ANgLPyY8pugE67Thh36qq9NRYQYacZvT/JWQTDzeg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:32 +0000
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
Subject: [PATCH 20/30] sched: handle idle preemption for PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:44 -0800
Message-Id: <20240213055554.1802415-21-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ef8248-25fe-47ab-bec8-08dc2c588754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ybne6AR9CBy73Q8qm1BnnuYoXspEX8rxYLNe7W66wv5Hiuqo83z6VCyWr7dSVLeiBdqSveP0nvzdBRwKPNRRvUH3U9mR2zRYnXpuj0tn1Opisn2fPw1T2ndd7D1bpTcLutI1D3l7kh4GIv4RteJz7JFPQt1nqitC2Fj7XxOY0brQ8n4e+y1yeonmRO0NxMfzCDkBDsnN36uV7RyUMZURRl/Az44sxW8W98j7D7/NYYVGJBf8ghzGB5lKIYtdfKMionSNHuKwN8AZ+DoaFkPD0H6iaYjt3dhZ8+7jXGMA29BqKPI0UQII381S/gfIZ3okqhkyEMteJXsqQviyKtq1O6O88jKZeKa6VMJi+gVV3vZWNdzxjPLL5iYLUzPy6X2uC0QYZTQbZOEZI5mgSXtvEQmFh90zElgbHc2gB+j6JAPccPW3H6eRve87q5ISozqu7xpNZYPLccsYA75ZWBOYAKJ4Lr76qommJYAe8z/8ikVZ/Zan53+JnLEC1lqNzSHINil8FmzEQ3YgODpEyh/SYkVqoY2c/0BsGa1rp5hgUw4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T7Za8WfefmA+6MzSSIJAnhLsROl8Ikb+5lNNN05lNjo75gTZsgcFP4L4csbJ?=
 =?us-ascii?Q?40Gd6XzwApAU+O9IvUk48etYwRqLONSKaz9SIjPCVSOtPVnIqTZcR6b9FCKt?=
 =?us-ascii?Q?KI4ZMWruoYIrD8B5y9paIZajpDdZ9Em8N4+xNoAv/EbORa6+YvRCjNlXeAIP?=
 =?us-ascii?Q?pbDuMM5TqJCJZFGyelz6p4U7Yq2wLn8rn9L4qBer8x1Wv9TNbNPYhxl1EWVc?=
 =?us-ascii?Q?e7nIbqMF6lY9s4lK9XCpW5BEIn823BxGaKyDd4vbi3pgwP1kyDEjM8AG+NUE?=
 =?us-ascii?Q?iVYc6PD6JbLJ0Hz0KP8OiZhfwG85wWeMz8jMsXBiU3BhEYS4OfxT/mvFT6Fu?=
 =?us-ascii?Q?jMQEykOjy048DmvPlg79Ej8Q3okNbW6Ny0F77AvvGQdPh4OEh2JtlYEHUujo?=
 =?us-ascii?Q?JKS0H99TGo9sBewEqVruzXdHajxUlYG5rdOygC+VORyTvaZCaTFeohyVjvDd?=
 =?us-ascii?Q?p9Z85ES/X/WPDIxCuM0DnigsUDdJiM1FsxlFF4UNDdxryfFDCUQ7ifgPRE8X?=
 =?us-ascii?Q?gj9GN/twEoT0vq+vROpf9zRXq3OlzrNkeD93SufLDKJxggHkLNwhMR+Inuha?=
 =?us-ascii?Q?zivHV168tyDX0VHHB/yGMwd8zjtCl44hJ99kqd4xooyjH8Z2JnyRbfjnbRin?=
 =?us-ascii?Q?yLGPqax8AkN1cpwC5Bt3aLJIhJBRx50irbEG/IElUu34Z96h6JrRoA3RpbD8?=
 =?us-ascii?Q?9hQ8PU6QjL1crUcyfjwNO5udeCCbH9ikOQm23zJSD27kmii3tXM5M+Ucc5pa?=
 =?us-ascii?Q?xxv0ySV/R6tGiaVZMRcqOwLIwniVEuaXPPWveH1Ihv6CLql+7i8VIUqF6KkC?=
 =?us-ascii?Q?7lOcW17N6q0KMra61GzW/Odjmv0bi/4cxbGH5cSxU9wvA8Myn8wc5skMgoST?=
 =?us-ascii?Q?YOXP+cK27F3zNL/x0xosynERUub++XjzIla9G8R8JKBi80lRESFcgq4+j4xf?=
 =?us-ascii?Q?Wu4xm9fT+pidviBQHDaL6NgcY8MaSvQxFhjMTV5QK07erU2jEXovEMbqwSmk?=
 =?us-ascii?Q?Z6Q/5fz8ALL7oG5YUli+cyKB0fk5Dj80bCD7jKkK8frjv4uvNbmSISxhDLeE?=
 =?us-ascii?Q?Htcw54TZJTmuUgWCyx2a32HLtFj0CjiTW6VJdCfGWpfMUEODDSWdWAgSD4v5?=
 =?us-ascii?Q?IWbJPoeXM3LZMSuTZbbiN03uobD24IqoVd3HFnzoJDVyU8igVEuL3cIPm1c2?=
 =?us-ascii?Q?tU29gb3Vd4/MDu8LWYtoat7OTOZ1XqtEOu0652A8ALeIUH3rH9gKAWUWG40h?=
 =?us-ascii?Q?JIwGc8B12+ziub1Rv6hNGOWQpGCQ5CoFjiKvhrkHdQeaqWGoPS3Ep4EUIhuL?=
 =?us-ascii?Q?8Fa3a949b5LeJCMq7j/D9hSDvavZATb3ZSMJemPIv++Dlw6jtx0xk8u5xvsD?=
 =?us-ascii?Q?fsqse6hp84Hp+Q0d66s/WeWvFlO7JS1U5PpCMYQUHgY+w2cP01kuOxpYL2LR?=
 =?us-ascii?Q?53Hgvaq4jE0bglJ0ApW0oeyGrHKYcNMGkt1VoEPflG/WeULNMZtYZsTFvywV?=
 =?us-ascii?Q?M9GLd+34qSKAb2Q1QKeOUlMi1rYV5SJauOJeIKARmDw7BwS3Q7AXTmV/hnbU?=
 =?us-ascii?Q?RFs/4vstR8PegcF8HGM4QgbTFOzQkzKkwLjn97W1MRy2p/gL3BGP+9VSyk9M?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XBXYo81hww6PCJCGn+O/lL5W0k+P9JVV1evr66s8N5Z3vk4ux8SfpJxNNASf1xQQYoOfKHzMu9axMIGYHL8a75j3kuBJE4dyu3VYaLSfr+VFGc463T4Sa3hhmNbx31OII5HiDgeZ7lmY+6ZhTz23c/Q27fDuMIVDA8mOFB1pqXbXO/ZKmWuB9EfbeVcRHFfOqipdgcu09LmrtVbWoZBpD7TKmBPUgZbcJS9KBSMGZy9TOLXCKQ9DIDV1APQzS52lVrUs5Jbc4kvzdWKVgbOF7JwoAAlhv05ycREeNG5K/rz70iVG/M5AfrU2RU90+qzozEoK0SLsAOCOaV0Gq6kcVctu2ul9Es7NhwdQGYkwNUDReVaEe5x1jpDz1jzUwm8P96dDtqXJrpAx6AZ/DypryZcMX08gRMHsby+1BHf/MQ1B0E886oQoso+ON2L2PKJcHqZvwTjo8vHKDge41ELPX2sns8+Wn88FPnQOLeJlsQg41bnon0MYgCjy8+dEXhwWYuYOI+S7oaBgExU0so2qRVppAArD0DiFkOp03JkmZ1l5TO9lwYVIBJfJGWOb979JF87DX+cJfAXUooWCtxAepGhgZl1xb8VjyiB0zt87TRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef8248-25fe-47ab-bec8-08dc2c588754
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:32.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6gJdwz4w1k+fV7RTgAchFtWEOCPdkExNbyRp+fW1xUsYQexi8gCxUZ0y/dd79FnypNLV6KMEVeS6IcTB5pqlJdpLAU7eOnmym4X0Ur99zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=984 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: z7dvOnMISgqXLOoahKatk7ADvv36kQdz
X-Proofpoint-ORIG-GUID: z7dvOnMISgqXLOoahKatk7ADvv36kQdz

When running the idle task, we always want to schedule out immediately.
Use tif_resched(NR_now) to do that.

This path should be identical across preemption models which is borne
out by comparing latency via perf bench sched pipe (5 runs):

PREEMPT_AUTO:	  4.430 usecs/op +-    0.080  ( +- 1.800% )
PREEMPT_DYNAMIC:  4.400 usecs/op +-    0.100  ( +- 2.270% )

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6596b5e0b6c8..5e3dd95efb73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1045,6 +1045,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
 		return NR_now;
 
+	if (is_idle_task(curr))
+		return NR_now;
+
 	return NR_lazy;
 }
 
-- 
2.31.1


