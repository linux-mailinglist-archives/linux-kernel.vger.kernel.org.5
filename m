Return-Path: <linux-kernel+bounces-96949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB523876380
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B1A1F24C51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBF5674F;
	Fri,  8 Mar 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TctdH88h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BGV5ilLv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185356442;
	Fri,  8 Mar 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898264; cv=fail; b=sJIEsIcxp4zgvYnIvbOmM5qz+UJPDFOhkvnxnawDslPRuKv65aW5PKlYRHaUy7UUMfVp3x07pV6BqyIfNV1BS0RPTF+oAAYx3BR5YhLJv6J266JXzc4IkBGl2uYv/ljhsqhVNc8T6dM1NXWnlhV+c2C8qYW6pHhA8ZxZbV2J5fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898264; c=relaxed/simple;
	bh=WEuX3G6Q7SZ0wTZ/H1aIEtoTOkypLrcVpQSPC5KGi4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JO3HtdV39WORy3NtCkw2AISJxkqENUli2pmLBfet13ZNXfa51kyHHbNt4B9H2M0nfNi5WMOAr5qlmgnQ6j+cVJdXwPAIOL/bLyo1i7wdDzYmeLS5h1KUB5EpdusNSrNHC7bNlQmFoLHO1CdJP9RmKjcYv6IzuMG52r8SF5Zy8YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TctdH88h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BGV5ilLv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Ahwlw024721;
	Fri, 8 Mar 2024 11:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=nalAt+iOZg8YqD/EUsSHMvarV6FbLHNdn+AsfYlLl+E=;
 b=TctdH88h3lYhNJFgCRv1QH9zE/J5x84UtHJFv9V6BuBuWCvfhxQr5Qc+5Tsqdal6sBVe
 vE1lN13XaiIWN1mTR6b+Qpo5OaAZ/+hCR1Otg+u7zJto1Ea4vJzAskaE1SR7VS5qVn+G
 86r7PnK1FBT5R+0YajGONBWGBLoiOkXyOnkhg9XAR4hGaVsPELoakY24VZz5qwMOCSr6
 KSzr3Bki1vUG/4NUIBXh+87E6zKdpJfJsUv5xbeXJ5yECCrjBT5mzoUGZV8TcuD0E9Mg
 dP9aJ4F4W+dHF2jj8Wn/1ai8xu92tiz4Lsh20OiVmk6BXoPZzPYzg3fadZTFfhlaHwfl 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dpvus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:44:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428BQQou032047;
	Fri, 8 Mar 2024 11:43:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcn4ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZMJXRvuj3LqtuAi1CGvqilQcw9E2JepzLhd+XT9GhAlYBOft9ZNGQIXrIlyckDHC+msjOu9wJG6my7BTnfcG+tOwUQt2gvbC901L6k3tBfz7dKuoUMQJ3ixHHW1H9V2dilaFN+QLP4C5vPgRcpZSjUuIj6tLSmZTfTku0KAYR39loIqttEwuI5w/wX6lVyaxAOP3W72l1TUcQjHSsi3kqD5MZmfKVE4omjqmpYOKc1V/cmg1+ZBeoer1hEJwFKJ3vpMv9O0+lGKhNzPVog3h/LDnH819HX+Sh+JDgbopa9GCEs7rsCY99lspo3j26V6p47D0S81IBgFDWNJfwEpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nalAt+iOZg8YqD/EUsSHMvarV6FbLHNdn+AsfYlLl+E=;
 b=nvOiJK6Elo7ivvLTCfp1WuM+y3TxFs8jbFXw4+vL7z6f9L5SEycLgGuJ08YlELwWBG0wBf+HRiUea0mlHNLBIiT+9qoCIwe8p3worf89G+HEzTlmk4l84bxadrcvJWVm0cMiMoz77JQbYSyW4rh1X8dx8LnhfnPQiz8zuKlO5lhqpjoUVajZpViWA3PtdAIgR3LL5ggF/pJnlRFaKoS2W3+sn9CSFnqphIo8PB6+gTjczY1c9lFkPzgAY25SEnQCb4zBp25CN6kju2K0Bmn3DUjYBy/BzGCKXW+VTC9xXIPAtul0AQVE81BM1iFkZvfzV5m+bP+dIVs/Hrw8q5TIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nalAt+iOZg8YqD/EUsSHMvarV6FbLHNdn+AsfYlLl+E=;
 b=BGV5ilLvgCsYMvkplxTifFWcRLXZu6FPPCg/EnVEMuc2+KWE2JKLbjP9DKIC+pF85BsGG561OdWRA99xqyP6gXQ3qknX1e184UfGQbB9Rswtn+GP600KavgMCyxOSo1zuUHAxLKgMyII9/zAuukWCJYIA4+kvdY6G0/x5911naI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 6/6] scsi: isci: Use LIBSAS_SHT_BASE
Date: Fri,  8 Mar 2024 11:43:39 +0000
Message-Id: <20240308114339.1340549-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: d3202a63-7079-45d1-03bd-08dc3f6508cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2PPLyAhkjEzb43MGhprYWz+L3XLmNS2Pi6RaiX/x72GL5+uC3TPssriTqAsOeyuGpHola+SeVhWA/XK3jId8BWDsLjsnuee/C7tL00w4yTIc94eHQ84jb/TasJK2kYC4iwNh0geaPxmKUpnC7yKxTDtpcXIYr78qoQS8XGaxMorBS25Vln4eQkbevPFZZ7ugj76BsrvSB85NbHsFF5DBPtjlmNLZje2GgKGN47M9kg87YnJzXiuAzLi5fXx0ebZx7fHbdajTHLkezyXLECFpODKYhNeBx2Fp+OBe5zMgub4joWE2DZ84uH/jZwys+0peDmgoUZSDniCzcWx8IXLC6/oA/AtHAZ9vvXzwPXT57QZbY0e24C2F448Qow4XmK4dwKFI8Se61dAOCizbNxmNCNzwIdu5WfLK42DTyYQz6NeA4XOraPeNp0FB3HAiWfjBWOgR9KXWhmYk87HideFeyEmo080QPCBy0b3etZ0zrjHBWEFiI89ENFkLpWXJloRhk75Cq2s3XWTAxIHQ5kbiroIkFsMoBCYOGFtuJWiMdX5hc+pJSBqZIfNXQ0TapIOL0weGW1nbQAPh9/xJLiDDqclHFGXPWy4LoEvJCPhezTarz+8kApPHPkGvd0aBLVxGnCBXDXB4ySrAYyJSUk4nrlJe7KBQXsWp0V8rXvM7WY0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xlpFVeaKd+RdVMn0cmeVFakO1byN6yyqoxdPQeyLv6HsCIRqLreIzWstyeke?=
 =?us-ascii?Q?tgqOqxwv238LrRJ9uY+Fu3IDHmorptv46Rt+4lhffaVbuyko43s/DRXqpCN0?=
 =?us-ascii?Q?IHSTui+eK3OAt5CEq0rYbDF/noCLHuvvCAebfUZq0pmcCe4Gr1uVdXYO2ngM?=
 =?us-ascii?Q?nuyP+FARCwG0xzqjKcPIAha0sUP2pD+CQ6b3hkdE/gYuZmasjywQt6ERX7M6?=
 =?us-ascii?Q?sGfvTeRZJsNxZzkXPAnRUPGpnPFbqutSXZEgPBHtWWr5RWw7FMcjnIx/wybM?=
 =?us-ascii?Q?y6vXw768MvcRz23Zcwrg4b/SuPuann9h9xGv+UhfWtYzP/KWN2gV2/bp1eTq?=
 =?us-ascii?Q?jKRXGVITGL8ydj5NZNSy8dhfX6gEfMHnw6QBxZlducQ+OpMaIkoKo/1w71qX?=
 =?us-ascii?Q?Cr1gGbSa/qttiJgE3Dv1r+s6FF8UYvJX0VEtT94pWOZeDhUIO6CKLlPa3jkR?=
 =?us-ascii?Q?Cy5C5MyRsOLaGupfhGP6RvyjFf1lBIrNb/HvtSzaFnzdLy+PEq2Zn2BRjRY3?=
 =?us-ascii?Q?4jy4EjHv+cLhR67RKJPGj0bn1mWXJXzpEQI0ipO4VIMRU//RPe//fshEv9ud?=
 =?us-ascii?Q?HGuZXCBxRpN+xx7ej/oRhjaqpC4vR1cheQY+zGfSahexQ0tr0PQBtpLvSjRX?=
 =?us-ascii?Q?5H2lKV88xTpTlUoVZ0VfydyhtDjs/dUFcLfeiVCo+pls/wz/gK2DLmJy85a2?=
 =?us-ascii?Q?l1o2h6WcI/2mUIc3X60LitqBLSVdzo7WudxcQDBFCvO/+TWcLF5oYIDIWKfN?=
 =?us-ascii?Q?q3ExOt6HOOVLr8sAArMX01XGUQzp0/MnYG0oteitpKcFYWbV3tUGxckq3PO1?=
 =?us-ascii?Q?tOEZTx+JIbqE6xmslUJ5awrJunIIUujoDhsJATL5RRz1r02S+OlzvizLaVYX?=
 =?us-ascii?Q?PPKt2BW5Z6V1fW+8zVlVQEoad7CGltkBn5cYK8IEONpd82FtxDSLYXOTfmuJ?=
 =?us-ascii?Q?3auufYlLaaTtyyr776/RFZv7tLYLNAWejIidYeJmdZ5V+7tcmwuE4UbSX4Wf?=
 =?us-ascii?Q?z95aAvdO2XBDh8eOYYjdys/v5a6VJxZwSaUWWBlltdp3oPtwvCusIs72MI1n?=
 =?us-ascii?Q?b0jVywto/c+JAQ7GDRX61TBtPWaq2kBldfZKS/Mba3k5he62wrbwPUtVkCVW?=
 =?us-ascii?Q?3Si4u+MjHKXAf4IizsveaRXABcjhaCjln50QG2VGJSUpO3Lx1Y/1MDIXDhY8?=
 =?us-ascii?Q?/bDXVL2usYmpTo0ikNMbGikBpVdyuT+V7uDl6/+EHQuJ9/V0qUhLHtBx6BRM?=
 =?us-ascii?Q?HJCYhriW/usWYbNArADGP9VL2+RiA+UUl39p+lE8i2BZk6LYtY8+HAOPW2aM?=
 =?us-ascii?Q?Ym3oCaI1+MMbEoO7Naqbm2tN/4vn69COOsmM98OXJLf6S9rv1g19FrJnYywR?=
 =?us-ascii?Q?DFvOTegi8/2+jHlN14AzE1wg5IFCYNdi//JQLY5XSRQD5nKm7xLQRTE7tgxR?=
 =?us-ascii?Q?k5yRfJOBoPKilTgS2wubYmlsQamPdgAARNFTDEhcQTk3Dse3BueiMRtxFpnv?=
 =?us-ascii?Q?us1uTB287HCZJOn0cjmG3uMD/Tf4gHH/cA9gWX7lGkbF2Ff1imICMmqCj5Fu?=
 =?us-ascii?Q?nTyK6D3OWG4UkpvZtID4+mFTUC0N1s0J7ilKEtO0cBN2r9Ldl0/acg9A/NRk?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	47tvLAyCSUZKBztSvtmYx7r53iEES19soztMcDkJAP7KJyTWknjYoXQTkNu+Q/1LnQa6aFoZO/q9ZAuOGB6uINOKViLuaAbsGUnxh9Z6E2d2Drs8SkvZn0zpP552IbIeDgLJt4mecv2e8auoOtuX/ZP2xP4gjddoqwf90fmivHJq82a0Wx795bUENmrIqrIVLYNl24R5henkbWKqrJF2vgZ0FzwcsVsXglIDin8dRV4GnRMRlnBledxpMi/oqIPt3zoK2YjbTKX3Ew5RKDWL5aO01UL1uG7M8622fIQ2ByMdcJNamp+v4xVktiRDxl6Cs0J056w1q1+4PtR8dEy7zMv7yJ1bW6g0jTSCnkaLRyZDA6renrBlJ1RMJ40ZYs6+2iIOTJ4ODisH8qVUyYuAxoZkPBIw1BLg2utFvdg1HRjWIompWG0oOvStRyI0D7vvZ3IhsVdtJxgmSg4pOvrEaDuRkAWacjVJ8lXpt7wOK5+1nx1h2YkOZGC/nXr/noAB8oL3QjKL52zgd0odNmaVZ83WLaXp5LSrqj7HyI1EO5FuveBFYo1OlSuENYts+LCgGM9m0cLd6U/8Kq1mLk9Jh1at9Czt+5kWmW6NkeRANpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3202a63-7079-45d1-03bd-08dc3f6508cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:55.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATRE7VpzRe3YkzLyIvzr+kTNivCAQ/Z0B4z+98nBa2vUNfLHwj/57vqtEclwX07RYMglLm8hlGUtj8LpW0DzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-GUID: KffMArZCtfR59nnBusG7-myQm3HRctmC
X-Proofpoint-ORIG-GUID: KffMArZCtfR59nnBusG7-myQm3HRctmC

Use standard template for scsi_host_template structure to reduce
duplication.

Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/isci/init.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index c582a3932cea..2b29e8505987 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -150,31 +150,12 @@ static struct attribute *isci_host_attrs[] = {
 ATTRIBUTE_GROUPS(isci_host);
 
 static const struct scsi_host_template isci_sht = {
-
-	.module				= THIS_MODULE,
-	.name				= DRV_NAME,
-	.proc_name			= DRV_NAME,
-	.queuecommand			= sas_queuecommand,
-	.dma_need_drain			= ata_scsi_dma_need_drain,
-	.target_alloc			= sas_target_alloc,
-	.slave_configure		= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished			= isci_host_scan_finished,
 	.scan_start			= isci_host_start,
-	.change_queue_depth		= sas_change_queue_depth,
-	.bios_param			= sas_bios_param,
 	.can_queue			= ISCI_CAN_QUEUE_VAL,
-	.this_id			= -1,
 	.sg_tablesize			= SG_ALL,
-	.max_sectors			= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_abort_handler		= sas_eh_abort_handler,
-	.eh_device_reset_handler        = sas_eh_device_reset_handler,
-	.eh_target_reset_handler        = sas_eh_target_reset_handler,
-	.slave_alloc			= sas_slave_alloc,
-	.target_destroy			= sas_target_destroy,
-	.ioctl				= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl			= sas_ioctl,
-#endif
+	.eh_abort_handler               = sas_eh_abort_handler,
 	.shost_groups			= isci_host_groups,
 	.track_queue_depth		= 1,
 };
-- 
2.31.1


