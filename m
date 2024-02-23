Return-Path: <linux-kernel+bounces-78076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD0860EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2E0B2816E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0925EE63;
	Fri, 23 Feb 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bEkIjBGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EEFkQQxp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED25D75B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681742; cv=fail; b=urBxT7p1C8HoLyEqnjaMlmUlcGa9oSMJPgtO/HIEWPUEzaumIHNiiroTK0HIp6kKFiSR9zADjOYfoTNWdH1yleuHc3Kk+wFeqVoX9CCmzcY0H9XUrz3YefYN3m1Dw5Kp6gBmU4I1H4zmZRS3XkYWMqh37Ho4CbAMix0gxV72fKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681742; c=relaxed/simple;
	bh=/UjDpaU3zLo6+dFUYRpjSxVTtrOI7IFpOi90Ql64VAY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ntukr33hUuUSsUeEGIXp0X8i7yD06NkrsioppPw69oJsyCKwn05zzO+iaZnHmPr3ADf5w7CUluxJK1CoCXWplVYpLlrld3zOk7todsja85H7dWYQjLooNCavwOD163opy/c8lOSAT7IFNi2TVG/6WcAJPMFBxgMky22yK6woJIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bEkIjBGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EEFkQQxp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41N4x32b004423;
	Fri, 23 Feb 2024 09:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=+locVhMx1tvl7sBK8DLghl1X06k+czxvvBW5EmELboQ=;
 b=bEkIjBGQEbvEIJm2hEkKkvdWB+p61Oz03RhEAdk0Xtjr57o/PSu50Td1lvF6kWYJ9pUg
 clzMYNAGGSzPWUdcrMlMTIaMipfc73EOO76TpIsGKhN5TfCXBNL90u/PT40od0dckSiy
 RXYkiavRofHXMk9gN+3rG7bf5r3XBCIb8omFSWqn0EEO3srbd/KfD5aY2+kLjX+A5Rhf
 U5wMw8W5KeII4G7swJjxy7dgj/llJDCgjAsBD2w2hj495uWQyVR7Qe6fuC5E9Is16RQJ
 VNXGe4rPppdXz7NNNHuFDVOPe07L4AWtBlMJ7bAjsGTHdw0tqSAUWLQPkGZycxfaRk4N pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knxqhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 09:48:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41N9QQwZ035746;
	Fri, 23 Feb 2024 09:48:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bus9b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 09:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjTAZ9k3ELUVATL50I2mrUoDgn8lBHUnFrdLH1CMLUp+N/Ath+ny3nKYtDTcf1o4IpPqeYBX8+XDQ0NsUFflJo7VduK/23L+OlST73G8sl+RHfv2V5G+fKexVZE+ivedS5FI5l9cdCz/NlyoSMC9R7cVXR8BegAAl4m8UKrhHk47nPQzyDsO6y7R8ImzTZjDanh8RKytOi3uzo2F2+QNSdWaJchcxEl6BfHy8JrUri7J8aBLH/sI6vCqD/teRd/eP9qiJCpnYIDSMdT/vKA58VbrmhPFXtQzmw5ypPgRK3BMtkpMtLYRRxRsLidrnnHOI2FHtIS0R3aFNs2f9r/tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+locVhMx1tvl7sBK8DLghl1X06k+czxvvBW5EmELboQ=;
 b=OBFHX7dPmdbHuHAembgNgmwYiBx8HTuq5P9ZDlSDS4CMXRfdpDxU8OU3qN8vnADUtoVdgen4sAiukUSJSIuNtxAyTQEqTpVKUyZDd8EJ53Ny1KZ5WZ8qlBgi0oNn69q++ztCFDToJnKXEYjgbJAa2aonpZETOSmF9EVMYA7LrHPh3IRDZcjShQF2RVyQ3ixJCF64q/Op3wFySNYfs7nnMlyawQamV+Oslfjn5IB14tpn168kdeKWcU5QG6X0hMd9u10ohjO5bbOLS8BIwpoiwbfDa3Y3sQs0T9Uf7dCAnhsYlgJhfTWbivLZIu9dkIVb5iNxyrTDu29NEyLasresjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+locVhMx1tvl7sBK8DLghl1X06k+czxvvBW5EmELboQ=;
 b=EEFkQQxpY8G5EN55S+CH0VPuR1f3+iZkkX5DpHOHRKuDWnu8gWdfsrcz/cCYtPdmKS1P0gc/jqSSANOuGTLQFBmBBbjDO3MoSTns+8y14O9N6jYAIEBDW67HnBuxXKpWq03ge53XX2KO+t5uSVNud51NDaB75+dCt0MhbQGU9o4=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 09:48:25 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 09:48:23 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH 1/1] x86/split_lock: add the source of exception to warning logs
Date: Fri, 23 Feb 2024 01:47:46 -0800
Message-Id: <20240223094746.11305-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::15) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BLAPR10MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: e6517ce9-410f-4671-5c7f-08dc34549372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sHrijGPC7pU+IdaIfyezvnB9iHhGxoVDcGbQ/lWLaWBt5469ecBoDFn/IiA5r7weRJptsmGpytFNF65LHxGkXjvcEAsU4tUpD8sHU/IYEMvekBuCf8d0+uQLePaHuMuktvumOuKlooKUBWVMTQZyo6WpFEwHAGgBbQHUxaTBZ+5VsF2960dmUa19uTFN7Fycs2OBfANwzBUg0DcPcWiRCNQksnZImPN5iYMJDkL32CfQw5FBLrSSjvbFFbJ9Fuo9iDTP0LCr6fYiUOuOqd+DYYGcwD1fUg00+Dkf+M8SWBc/LfnUEbcNNh5cg2dxz3zv2jooQS10RytXYc47b5Y/KE938a/Dkjel+ddV1C2ed4yl4Aeujtm5eWwYpbRms2XChbjDPIIzxwzzss8e2iFOx7VX3rwYrnZluPHRFqGJRrpOZOrOxRseUW/8BJ1VXtcYfjx6DkxAAFeG4mlRZZNOJvQwhxpKxyh0kF3Ri2drdUbg910ecaTjRbspJl4Pq/bBdKvOS23u1w9MHb4AeFHBcLXrb49BCBZTJx828Bwxts8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1VGKK0hM/N0BMmsm3bG+a/L/YGuEDMzxUqoCS/e+2BMEBYOrh3kCEzV1eCLo?=
 =?us-ascii?Q?BPlcHcSBGWx/hFMBvkEqfjXuU5+zfxIPvaxKk5YNJXVOZhuH1A5DtTjaJScy?=
 =?us-ascii?Q?TgknxVn9cC+8cXTSy6YhZXcehIlDtWW3jhJVwKKABS6eYH0uFyujmEmEiGgQ?=
 =?us-ascii?Q?BYQDuxnUgC1184GbqGg0U1jH4sgsaxlyQWxp52IJIR/agd/KxQOtcHoLhWp9?=
 =?us-ascii?Q?r/u9UPIzL9Hiv2CJ17akdoYMNW8a175Du+H8fKStwdyLNQhm/anAl6ewW5CB?=
 =?us-ascii?Q?h7yAr7US3dDF93Akv6ne7OqoHZKmyB/ssJQWNlV1xhAXLxUjaYMGZ5cmFwnx?=
 =?us-ascii?Q?Yag/Bg1kxvFOnquLeNyrEMzpqjvgQoxPR3EUDMxUrcciCkty44HcUsiPVvm1?=
 =?us-ascii?Q?Bxkpd1+6LKcar9KUueLBQ786LsJpqyQS+L7xxgDIVn70YAveCCRXXW143nlE?=
 =?us-ascii?Q?wshZs5RbeJuC8YnspNNT8wrvt5pPbBhhliC4nf9xcmCTqMPc+wj6SMaiyFSg?=
 =?us-ascii?Q?tCuCdxnoS6ySqYfdNcj6r5Pm0S2CDe718SyatIN2Kl0I9EcWLBKjDDxYOl/R?=
 =?us-ascii?Q?+rn4OPTmXdMlX1LAlpZofFWeGKn1FvD/3jfyWdpalfVbfPhiblbcI8kbAF25?=
 =?us-ascii?Q?nZXSBjDiUMQ+dfmhZze2JKSBPtrtR4mpzUbCmjVU6uVvWxP9ILf/qPihEqfv?=
 =?us-ascii?Q?mIHVJGe6ZTSEK3k9AdhtW/9j/bOjANzydnUb1IVGqYWviWldK7bUu9II9SI0?=
 =?us-ascii?Q?RWrhKLrt4KuH+gzNwKppaUoB1Kkra5KYEDZ8g+Hrp8NCudd0jtEskzIx3wQy?=
 =?us-ascii?Q?jMEmqbfoe1DvjHx9P1mGRVT/i1WBfepOEFQfgyXx+Iw+uGEoHrqDXS0hDj4A?=
 =?us-ascii?Q?VDaXfsK5LYfw6S/B/waT1CfYQtVOyQxwsLt7KS38J0XwKezylj9cN66312hE?=
 =?us-ascii?Q?Ncqhxm3ImVBim5Ej5VWVeveYwhCsY5QD5Qe64EPxdwUrMloKVDuIUHnA9aPD?=
 =?us-ascii?Q?9O32XTWN99GTvJXjUrmEZpClCBTIEBNxs2Me+MLvgBCwaiwzWed9LddhpWSp?=
 =?us-ascii?Q?4AoUpLgcowGBNpqYa1oqjNK0lU+0Hj6Zss4bx1hSSmhSikfJh/TNQAF5fEaM?=
 =?us-ascii?Q?cUR0R9mfavKHwK8hwwtBpoToiYBy1qDzkqmNe/Y7NTV++LAdszuyxlDEsL/f?=
 =?us-ascii?Q?tH6An6Q+4WDiBb5qfPCWNXfdpHMGHBJQnOTAlA4Vqz8zA2Su/VquWBTpKeIJ?=
 =?us-ascii?Q?kB9/Ss9yT73xBvze+EM4oJANpPpGCCoLz05kDVi9tZsDgAP60IckeB+zQeXN?=
 =?us-ascii?Q?0bBfskX54Ody7KieiGUarcSw8evbfRwCWGe0iEo4xNmVoPqcXslTZd2VB9QB?=
 =?us-ascii?Q?BQzT1No1qQB2nQkLwJNbM01LYaYoUTNOgj2MHcHXQGH8AMHqKZQ++uy1oFzk?=
 =?us-ascii?Q?wIy6M5UHCL6PaWCpFvNagya+wrEVsC3R6uh97N52U9JYkE4giAzPAwiuE7ep?=
 =?us-ascii?Q?SubqwNgl8nUQLYEWrPGUH69S6p7qG0znptsioMmV8BLykIfIkS9tGOXztE08?=
 =?us-ascii?Q?IiGLqOWhebT8KVAeeuh1hmxhYi2NPOoBLTfV0wBK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BjMQFCjoeLxj3WLy1gYQWELz1Qo6hCSNUrUKCZxm37X6zMHxN7Dt9t5YXdBySc6gsQrMsFiJwhX9P42hzYJNiMa361WtJj8lDdMtV5Y9rQHU8pSIaksrijQSXK+nOS+82bkU8r/DJZIDnkK28y8pRe5ja9BUbXYCAWTukvDpz8ToY0/G2TiMeuyGvUwBs0jZtD3XNfRmidBL+RBBwmHUDUnlQvsAYcpHWdNXuKxc7CJ8NY5ZMz3vZlS9IeC0TJNu1TT0wtfq7MujtAI1Uaatc22mXiGEv5Xxn+9Zyte3gnENb/Ng7FdUvjHR5f0lBEqtqQcYCgC5U1f0h30zRlRIXjgWsdq5NPPgnzsKiQ42YQPHyz2pN0njQqgxTMuzlYTYFfpRQGqanNanOuo5iy4UZi1gpGF2VvE6A6scLOrZspF76qt2h2ZZxixhMHPGgP0r3SS3lOu/NJvu7u2qK6xXonVoayj71Xp/B80nAAn/urjg86GGkBatMfYO0MuzJLbUVfxyT2ejqWGVpHZe+YpMUkomjiAIbrTrSZltVYa1o6t42Lup68ZKCTlOE5it5iBO5heuG0vfAwDLGVOdVvvCCO4+z/d6RdkJX0Itgk4ucvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6517ce9-410f-4671-5c7f-08dc34549372
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:48:23.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPGUDxsflTlqwKTUZk+JQTCzV34pb4CgUOS8TkSIDSxGPvD9NdcN0B4YRqsId37KY1MS84heWK5VvXVkcZiiOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230069
X-Proofpoint-ORIG-GUID: mSUZRtkx1f-hLSfZplTwSWomq0WIA040
X-Proofpoint-GUID: mSUZRtkx1f-hLSfZplTwSWomq0WIA040

Currently to trigger split lock exception at the guest side will print the
below to host logs.

"x86/split lock detection: #AC: CPU 1/KVM/65886 took a split_lock trap at
address: 0x401173"

Although it is more likely the split lock exception is from the guest side,
differentiate if it is from the guest side, or the host userspace
VMM (e.g., QEMU).

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kernel/cpu/intel.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..22285e7cc138 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1155,14 +1155,15 @@ static int splitlock_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static void split_lock_warn(unsigned long ip)
+static void split_lock_warn(unsigned long ip, bool is_guest)
 {
 	struct delayed_work *work;
 	int cpu;
 
 	if (!current->reported_split_lock)
-		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-				    current->comm, current->pid, ip);
+		pr_warn_ratelimited("#AC: %s/%d (%s) took a split_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid,
+				    is_guest ? "guest" : "user", ip);
 	current->reported_split_lock = 1;
 
 	if (sysctl_sld_mitigate) {
@@ -1194,11 +1195,11 @@ static void split_lock_warn(unsigned long ip)
 bool handle_guest_split_lock(unsigned long ip)
 {
 	if (sld_state == sld_warn) {
-		split_lock_warn(ip);
+		split_lock_warn(ip, true);
 		return true;
 	}
 
-	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
+	pr_warn_once("#AC: %s/%d %s (guest) split_lock trap at address: 0x%lx\n",
 		     current->comm, current->pid,
 		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
 
@@ -1237,7 +1238,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
 		return false;
-	split_lock_warn(regs->ip);
+	split_lock_warn(regs->ip, false);
 	return true;
 }
 
-- 
2.34.1


