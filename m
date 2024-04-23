Return-Path: <linux-kernel+bounces-154610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1958ADE57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395012816C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DAB47A48;
	Tue, 23 Apr 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jc3W2q5e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JzHUVGhX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079C1CAA2;
	Tue, 23 Apr 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857834; cv=fail; b=f5hUwoUC6yAA94qsoyHd0lgk9NCCAazrLL1tJkrum5JG2k2Kd8b0iZw4/O44WKeoBr/0wkcJ3rHx30Kiz3Fi2Jnva6wl43pNe5QI7t0vM06crzusVvMnKmIxYb3mSVLabV9V/3QWSn79rlZxhVjk8VJUjmSE3W4S0kOO5Nsgq1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857834; c=relaxed/simple;
	bh=ZUGwO5b2E35AmWm/FW9sd+Vj2etEgX+s7zrG9UKBPec=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NAzraXaxfIfaUso39S8A98NGkcZOMvzz/w/NSyjEqBdl8BjqqoZgUpfcdFBAe+3PinZIvqAh91onNhy8mEMHP+bOKz22Hhmcx23rNNj3zkMAl1Mre+XgvMiEZeElXYUH8tNL+nyHolBCcOoIo3ol32Yf66jOC0g8+K2S0G+SlFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jc3W2q5e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JzHUVGhX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7Y4RF031878;
	Tue, 23 Apr 2024 07:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=kgRiGMvrFMq587P25flP711KNbI4dAVkM0T00rOvcWQ=;
 b=Jc3W2q5eeoyyV+lKFS1urBOTeSds7YJJjLrnmfF/kXRcLWU8FhD5ZRN+FOVzaoCRBxxr
 7IqnlH9eW3GztHhdlGHVpUzQFGxEFkTd21Xm89WdoVZZkPB46DdmNE7lV94KBDA3waGz
 S70j9vmyXtnkEuCaQcnicRUM2b3IHRgPxh9tpRAFvPxVchpasvy43wWphVyxUs2GqBOV
 NGktMT/NkLfeA7c3d1ECW5ZllQI8FBJOztndXdZT3u0fCnzSWbz1FFnB4NkyC4l6+qtZ
 u0fVMA4vj1N1DrwQMAcqvi2tFASUztCOIq7lE6roNTpsBrSHgTAJ/qhvX+JPtrOOS8DD iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5rdvh7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 07:37:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43N6nVYK007752;
	Tue, 23 Apr 2024 07:37:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456ta0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 07:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHr+7el0rC/5S/fcMdwX8hcsR69Kiq0c4arw+zxX1orMq7+F7Rbr5TY10x56OizQPdQkL1Z17lZvx7UdzxW2dn4lQZOkenhdfkLsMAMKc0j/9yBwHZU32WM48Fxjlu42w4tI1Z45b03WibSlMPzuLCQGb6nbj04//xOf18qSVad8mY9JSp1j4D2XLxEwzafwS97f7/AysgdLllnd54zA2kfy1DYMDnmkITywno5dHEbUI/4EjDWYoBHrHRz3/YWe+2gzk9uy3Vud7jSV9k0nxHg6iLF17PZCYSkYCIGFkpPQjKhgHPzjRBfK1fXH21tevguc4bQai/X9kX+eWQmpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgRiGMvrFMq587P25flP711KNbI4dAVkM0T00rOvcWQ=;
 b=IlgqPhw4AchJ/yAjuHoYSAjc9j6jM/9RTYkD8EGRohzpdG36g79OpNBOOgMtpFiOf8jP03GC7TP9AIh4ahyHxhc6IIz4ldU1tINyahBZIg3qeqfiUXAc5hyt+dAHcTBbwn2uyj3+4zZsQRTtEN9zT8SllYwcBceQLRLN5Rog2ZicqrMWH29uYQ8hCTIVMitjGv+KciqLbhrpNAhtho53ikO9vTs4gtd82vwap3OKlfLRwt/oinCXQUt5ZQ/5lGUNVFwFKxdHryFr52CQs8nEAO5FP7Vnk4bzN68PYW44Lpq2SD3m/sbATPsniI0OCcVM1ZV3/VPJ7cNJP5+Jk5AJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgRiGMvrFMq587P25flP711KNbI4dAVkM0T00rOvcWQ=;
 b=JzHUVGhXeIbTOw+pPRieg1ldF4IBSviGj5t9vUU6MzTxVJzDv7ZRpdrGVWwbOOA/JKSwmTcwW+LtLxzViEPXW8WAjy239pyMDMt0oGtvsJxr+btrCAa1R3MV3ffGFS/U3g0VS5pX94Iycd1ucrF0O/PNlaOzbh5eGyxFpb8+SiU=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by SN4PR10MB5798.namprd10.prod.outlook.com (2603:10b6:806:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:36:58 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:36:58 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev, tglx@linutronix.de, joe.jin@oracle.com
Subject: [PATCH v2 1/1] genirq/cpuhotplug: retry with cpu_online_mask when irq_do_set_affinity return -ENOSPC
Date: Tue, 23 Apr 2024 00:34:13 -0700
Message-Id: <20240423073413.79625-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|SN4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: e062ca41-9148-4f50-5fa4-08dc6368287d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?adCPCgX/mNn5PvQ7f6ouAinqD003i/q5AeG0Pg3UU6SQ2BWQyVwx1h9RwboV?=
 =?us-ascii?Q?1DAHLApwcjEX0Y8xY+jmOKmNW1aMXLE1sXeje1FP7c1uP8ei9P8B5iL/YkgF?=
 =?us-ascii?Q?aoGtz0Yg+aiml7B9qsMqe/mbhFYFEmuoovnZODMOKbX665E6HzLqW+0bBCxw?=
 =?us-ascii?Q?hAciCrxxa9/CfzWMuERNzTIlcQ6YwCREDfmpEMlm/Njny6/GZjsq6UVNzR3O?=
 =?us-ascii?Q?50XVcvrvWL5RSl+EBpU28moqfOuVh9b9Vvxi3MmnPsOM3iziJAZ6BcFmALOP?=
 =?us-ascii?Q?87PNPuAAk7Z+X5VwlPlgdfYTu43wYF41YcEQaqQAmgfAIYlmJ5Hg74Wg5ecb?=
 =?us-ascii?Q?FnOAU1bqOVJtv1SJfnJQheYROquihf//4YCcdgPl/zhcbLS5lAgyLdyxT0Zl?=
 =?us-ascii?Q?wYuVmTAoTK09d30zoZyL0MdQDKab5NWNg0PkCZviXPNakE4+mS2OPkwREndh?=
 =?us-ascii?Q?+MZXSCTQkeDLtamwb/luKHEHvPBnT7zhZwZFcXDCrJrht6bitS9Wc8+wLx4p?=
 =?us-ascii?Q?jMkKgdgZuc7IqZwehfGy1+/fKrhF4H6ohCl7m2JKehYxkcS99X06yhLea79e?=
 =?us-ascii?Q?HsZJr55wYernhHBjIka9GaOIzW1zn9Xs6aCfcPX0cgKw7JLyvuu43/Lj9lAT?=
 =?us-ascii?Q?PpSSarCEDvTHMW6dDtSb7jrOXf/xbpBsnGaCQXSa+8lYISerYfSx7pR+pKRy?=
 =?us-ascii?Q?i4XrqI0ZMFC5IugZaxrngJLoc6bTVSKR/iw7JB4ctitJcoZPew7V/AVwyLuz?=
 =?us-ascii?Q?6fdpNvdKsE/rBvuhLi3msmSejNaSmtMcniQsBXHO6aEn0wvDNtdSNTAPvt3v?=
 =?us-ascii?Q?C6jFcOO6giYW0Y6BScAm294lAVP7JhJEB+XktDXw5+7ma97BvT8qFbn0yUXA?=
 =?us-ascii?Q?fc7syQWIYBbGN6jmEP/59y5Xaw2FqByRyEIKqUWtVCaR4kG70twFCRwNid+h?=
 =?us-ascii?Q?H4ATvO0e1llXCrIeyXrCEzsL7eIReS9RaHGKnTYMt7g79OOjTr6P7/4WMJR2?=
 =?us-ascii?Q?OvoxPtN6bRDqS9sUWUZkgiaA1Up3xrO9jmynIzd3NSdbM5lQgB5A+2diPhKg?=
 =?us-ascii?Q?u+q5V+IT3gOnG8cH38JtDEM4Jht6BlvT8STKaAoACJY7kZyqzt3eYZSP4VsP?=
 =?us-ascii?Q?jlqOt2UB4cMPd5/oNRSMLMCDybN6bJj2yLnbLrGp2FIkjMjpekdgPfnVPpkA?=
 =?us-ascii?Q?3RHSEIM/66P3MNJ9In3mBhr+mKE6L1I3Zq0IOy8BIykIwX316iUqVg+UAKFz?=
 =?us-ascii?Q?Jau5H3cnG3nq8sdCNwVFotZOapYyu0lWRuFcQ9Cj9Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OO5CWzPqn3YPhL+eRpraWd6LbMBfOYtKaLrWDO3KHAXXIrBYej07X3mlACyV?=
 =?us-ascii?Q?0ZDFkMgudcI1myC2cWkBpt+kMQ/wNSlHWLyrc2RSvBARsqlqbkjS6KwAV61x?=
 =?us-ascii?Q?kJvJNF8/u9dKrkTKqlwm5Hcit9GXnIn3ePEPAZivz2z9PbyQ3bYeV2k8E562?=
 =?us-ascii?Q?8njd9mqVgfITgPxUi4eYhHKi1bF3R9e+DCFTL/M8tv44+MuJSkEFWAS099TB?=
 =?us-ascii?Q?qSdfvdW5Enka1n/933J/mzWaDD9S/rr26hnUnlfiTI5gWF05DROWoqX951V+?=
 =?us-ascii?Q?jthgTe6jH8yGpRj8P2SDOtAEl9tpVBQMrZbxu30SOngOpfL2SQqCg8R6mhjX?=
 =?us-ascii?Q?3uSy2EaEbA/tIPlSrkgzdyXnYlVvzW7vL7JBjmALR1CcbEX0N1hqArNDrzXb?=
 =?us-ascii?Q?CagX/9B17CY8hgmXHSg7SCiTFJBLmV+ZeFM8w4NC15dPeLmxghcyYFsNDTJU?=
 =?us-ascii?Q?pNJPppMNUyFuD9X5w99yLm279UULiZcKBBuxhjq/sZYfKQBwIkJRQ12NRCkQ?=
 =?us-ascii?Q?RC4EdJgczEO5Z9CB3gqnLTYamie7NAJ6Di5qxkWbro47kul7p7RcNTCfC3Sa?=
 =?us-ascii?Q?8k1fAUo4pA6PLlkh68BnGnCOwn8aeJns3oCQjCpFz45atE0l2npR3gyxAtqF?=
 =?us-ascii?Q?MFUJuW4N9xxC4adDvZ5LhaTy0wMVrHSLQ3rFaPV/mKgUOz9q6Icm0amgh2ee?=
 =?us-ascii?Q?vB38l5yurhlemmglTWRt6clGYy8KYiEkjCrMYt/WDkZca+RyinQkti3MQ0DI?=
 =?us-ascii?Q?IPzx6Djac32aqj6UV/dL0CRqA2kLGFCv0NGHzq21re9jYEJGJaGKD4N0yEdT?=
 =?us-ascii?Q?L8HYNyX7eiNb7mOb82gUB6iuhtAb06bYY9L+bPS/7/WZAhrPN7XlYfiXH6MQ?=
 =?us-ascii?Q?f7NDyYKLXW8EymkJ2RaCyWxhYrep6hI+zi0iv6fwWQIHHO+5sJMQckxSkTOW?=
 =?us-ascii?Q?frCxdXL7j0fZSawe8ykCuv7/sMdvxkPzVBFBW4aQBX4+Le77GA0Lx5yThApL?=
 =?us-ascii?Q?QDcpuMugoRkzYJzezQBbN19efL8IC26W3rIZxM8IuhYBQbn3y8bOWQuFtldn?=
 =?us-ascii?Q?dPVuiUiVxQc+wOFYOdQZsv726qquBQa3NsVbNFrBmlHWLtI+LxUOWnJJ2Od1?=
 =?us-ascii?Q?8bjvlcg9crxGB4igOoKmH+/Dh0PES4lRkCOmpYteb3aiE/GPtLJAl28b8jcj?=
 =?us-ascii?Q?iRPrN4t7+fXIFyFRWRnKB10zVwev7imS2/ubF+aYIVH86yydwH0q+N8QF35H?=
 =?us-ascii?Q?VXEWMSkzNZ+N4Oz8SHIUmew9OAcqcUiGC8zVgeNiOxUEtGr1aFBySn4wS9Ly?=
 =?us-ascii?Q?fbdxrKJUP0/5NmVevKsLnlxtXKlw5Y2DpooEj8iAPssH3AKhcsWFHTDswrMq?=
 =?us-ascii?Q?LBjX4wKcdVSY2vRjukiQfusUu147kxx378x4KWydH6qkIlt5lIVVjSBuVXGh?=
 =?us-ascii?Q?sSJUhi+8fXSsrss3vLUmL38gwiyzvsls6TC/oVqV/MpuGZpW4RMqgxSGmMDe?=
 =?us-ascii?Q?3xW5JeA/DKKxnzyWMkt3r9cnx8YFOujXjZQCjgEDLOMqPeTcfgePLA2Rj8vO?=
 =?us-ascii?Q?i+MHNc0MD/juKO7iuy5SDqLO3BR31jtl4ume7+Uk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j6bm/aurQSfal1zDMu5iBReDQlJtrGBmU8SHRdCV9Z9rfuZtCihBrw9rFx/hLXYQvd8hQC2xfQcgm7D6ErHDihZbyC9A9hTnvdOqGcKql1IySpelfWIgVbQLG6+hVkIDCgyHh/1qHu4qlMgkOMFS9Xuj3oKq9IITQzCkQvJ5HkSP8fg0Lln2TJAByqZu4PDkVovGjzRfnpKotJlndntGK72uYD+NwKo1sR0c5ZVbTv2mqYbHtsI29i0+457Xi9yt/2DpcHZ4q8QvE+QlzW47y+/UZpYk+tJRHqahqYqmfPxCU5F432dcEeno0nBnFwG/Tw0GNsZ5Mlv/FgTRO0nH5XSztPkvEuRLCvm585IrI2HZC+CZ6CMMPDCu89QuRZ1qfDitEkK3poFnVTf0T9VGATN9BgNoBDtEmQHsbIAijiN2FfLuPwuHV5qkZx0pmO4c/TTxYtgHI5OOt0o6LugplahdY/Wg5YWkQmEepuNEW6Ncd8iv7GCYM+01oEGWcrs+y00prn25L50rtHuZ8BeZ4RG1l8mVofsK40ztZCwavXsHmnHh5DhO6zYaFjSc+AhWfuOjU3TC5dD1oPVsficBEPRXV/Jotgfw405YvUNhb/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e062ca41-9148-4f50-5fa4-08dc6368287d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:36:58.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKgj8fWxskbgUwZ4F0mwYJkjbT90ufm3jBDPI3Yf6ffhObkd0oYX7qOb24R3QnPKfQnw411Gy3dihvCC0h8Oyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230021
X-Proofpoint-ORIG-GUID: mNZaVbk5gsvYW9pX0NW6ypriaSXny78Y
X-Proofpoint-GUID: mNZaVbk5gsvYW9pX0NW6ypriaSXny78Y

When a CPU goes offline, the interrupts pinned to that CPU are
re-configured.

Its managed interrupts undergo either migration to other CPUs or shutdown
if all CPUs listed in the affinity are offline. This patch doesn't affect
managed interrupts.

For regular interrupts, they are migrated to other selected online CPUs.
The target CPUs are chosen from either desc->pending_mask (suppose
CONFIG_GENERIC_PENDING_IRQ) or d->common->affinity (suppose CONFIG_SMP).
The cpu_online_mask is used as target CPUs only when CPUs in both
desc->pending_mask and d->common->affinity are offline.

However, there is a bad corner case, when desc->pending_mask or
d->common->affinity is selected as the target cpumask, but none of their
CPUs has any available vectors.

In this case the migration fails and the device interrupt becomes
stale. This is not any different from the case where the affinity
mask does not contain any online CPU, but there is no fallback
operation for this.

Instead of giving up, retry the migration attempt with the online CPU
mask if the interrupt is not managed, as managed interrupts cannot be
affected by this problem.

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
[tglx: massage some changelog]
---
Changed since v1:
  - Re-work the commit message
  - Move pr_debug before setting affinity
  - Remove 'all' from pr_debug message

 kernel/irq/cpuhotplug.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..19babb914949 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -130,6 +130,17 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * CPU.
 	 */
 	err = irq_do_set_affinity(d, affinity, false);
+
+	if (err == -ENOSPC && !irqd_affinity_is_managed(d) && affinity != cpu_online_mask) {
+		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with online CPUs\n",
+			 d->irq, cpumask_pr_args(affinity));
+
+		affinity = cpu_online_mask;
+		brokeaff = true;
+
+		err = irq_do_set_affinity(d, affinity, false);
+	}
+
 	if (err) {
 		pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 				    d->irq, err);
-- 
2.34.1


