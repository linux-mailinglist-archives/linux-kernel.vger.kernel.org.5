Return-Path: <linux-kernel+bounces-138899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001789FBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC2A1F20F29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09557178CD5;
	Wed, 10 Apr 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlFNo+8V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uq1NTX8f"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A16F0CC;
	Wed, 10 Apr 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763355; cv=fail; b=Tn5WeKc5VwnWw+q/u7YbDIlQFGy1Xdemf1fOtqDteB4tAROf/rYBJGsBG5bHXGLxn2pyi+KauhFCzhqlrPUU88VH0aGYjfZaOIjwTum1s/Az79/kb6gcHCDtJvVXi7MhMaBYcqnUJs6Mi9GzeQv/rS1YLiv1S14VopTz9nd4WLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763355; c=relaxed/simple;
	bh=6rGagDlgVZuwt3BgGhJQzd5/2Pps8D+TWnJFV86MtuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pm7zhbw8icDJ6uE945mIPvOPCIqLBUTl8+02TEQzHXIAxIlGRmWYXyTZlLPT5KZP7WF2zb65zEMgfpidhVgh+smT07dAsNcRirwUaA9BMUFZPr1KW03G2PY2vcCPsr7Cc9Lyq/j1xBcjsiKcQ+5N5yHXCvpLHXbchlVjLCeM5v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlFNo+8V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uq1NTX8f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ADwphc017669;
	Wed, 10 Apr 2024 15:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6rGagDlgVZuwt3BgGhJQzd5/2Pps8D+TWnJFV86MtuU=;
 b=VlFNo+8Vj31qkBAk6aIaFViOEOOcUTj9Cgnl24h0aB/jXSZ57XdnR1NeB2WpwP1tEhRg
 zEQtGFyaygZc34taSA/uJWZ0S60vjbi6mNJSxNS1EtE6CIpc14G48Tzfuf8uPG8XRPHj
 b11/mwWYfdX9Xsi/MohHHr6UrOctjuXu6wwk06VDp1heYn7eMgw5xxgu894F0XvxchBN
 1M5e8sZeb7Dpg0/oFrbYB7UBqaEq0nesX1hNlqkdUkQYeMXW/OY7x0L7oQbmoJMhaO8Q
 /RigREgqm/ya8s0SSeUGI3fnib4ky36Pic/uFdxslw/DS8gsSUj0E0U0IondESm8riHH OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw027rvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:35:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AFNc6q002742;
	Wed, 10 Apr 2024 15:35:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuek1r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1MVdt+Hgq8pqFPzXsZfvSuUBCtn4Md/8RALIr/QM9NOmkJaYdvrcullqNUvszO9wI518XBIonY1hpcnQuSSzdQqfE/H7AZ31LR5DUlqTOPptNbD7DMRMZZ11xSW8ERttEekclqRFbEKgpVJ0SwIQ/VwCxliEG9xA0SM8OPXQQxJHHDVJD9t8vwl6GIe4EUazlvmBesalTaSJqpQ20xcK23nZNB163X4RLnO0IZPNqRV+OKNvPnwSiuVV3GRcm3ZTOgBy/Wrm4iW2Yhn0xlrwJMsjAlVqhpaCm26Gc2lZyTUmmUc7Ggdvkiba3FfrdLS3xZFz0qL+/KNIQ17PfVS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rGagDlgVZuwt3BgGhJQzd5/2Pps8D+TWnJFV86MtuU=;
 b=OdGtT2UVqu+38tPYjro6ssZt9HpPpSSO41ELO6ejoKpuT33W5LVtxj8t9NKo9VHlMpuz5IFX1KHk8jxAbIEv16sKATJm/c8YIkaUJvJ6mfsdL1gC7uY+4jsAr5nAho5mncmWMs9ymf9MQ4gRF/qsF1A7Xswqws7bqsbOtqBboTHRp3cBBKn7ju1C0Xj9fVwW70NMZL5xsBAJ2beTs9TUsGcKXB4mRnNJLCHDgsrXYbUZBbvaf083ML/r4SWAG+5uG4BW8FaDC9CwRmM4TpvRjjx37kEIoCMmhYjRrDRH+VsjSFxsbkfWBLT7SsNTg66Tg0Rf1c6gIbMy3JX4fA8HGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rGagDlgVZuwt3BgGhJQzd5/2Pps8D+TWnJFV86MtuU=;
 b=uq1NTX8f1U5gkiLg75EleFifwXdO1Y0jv3aYjnzmPpOnRA8Hk664jq58FjfNqauwki/UDL7NeThnIl0TWhC8//un9mfwNtf7NDrNi33EFQKS+KbUTaM6RL2pOvmeAXi3Pe5UlDNLPTNsuJ7t/rF/kU0TMAgOP4lhArK1KNuEWbM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7066.namprd10.prod.outlook.com (2603:10b6:8:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 15:35:31 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 15:35:31 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/4] ACPI: processor: refactor
 acpi_processor_get_info: evaluation of processor declaration
Thread-Topic: [RFC PATCH 1/4] ACPI: processor: refactor
 acpi_processor_get_info: evaluation of processor declaration
Thread-Index: AQHaio+Uzk4PLy1kSE+/uInjneOa/rFhfJgAgAAnq4A=
Date: Wed, 10 Apr 2024 15:35:31 +0000
Message-ID: <543F5357-2C4A-41B8-88E0-8730D3A04523@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-2-miguel.luis@oracle.com>
 <20240410141320.00004199@Huawei.com>
In-Reply-To: <20240410141320.00004199@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS0PR10MB7066:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fd4AuoR0Eox7s3YwynQl93SHpqAZko2dezc+XURg8ftD8QXS+W4u4Hc40y2BPzSLvgLw7bvTxasbd3v/Ul8L173bMtXNrdYvhGzGXTMEpzLSIvHoAGpwsroYpi/mVJkTqVwZ3tLBvgRN3mLEf11ro/Tzn75paVVXIZAlRu/cBMgtdJsun1jgHCJwRowsge2a1Bjz2zsEaS+HxKhIGedaGqnKT7KvB1Hc/uWtF2USKjS5yzi0xBlWC5i9SLjlmgYOo8hL8BGx4+oTJQ9rNCWXzmWsJj8jfQXxI9GD4290tbxV6O4AKrPqMQFU169BLw0n3wNh7V6FDevRFzL5Z57AdRlhrfcjwre/T7la3U06Ps2FrFIbKfxXei4+QLtbp6TkiNbNNLJdRicHBU8bKqm4O2t1JFTfktzAhuGcrBRxdvfiu5PG3mDqO8kDa5rnLL/UXuoj+1G8tMys0PNjhkffsJwt0wICm9hKPQCbz2JGqhsna+ez8og5iPrObzqNvQDdrln4versGUTr/S13piObVBw9m4WUkbp/p6tT/pO9KrESG2w71+7wR1QoXRsVHuBF3BoszLo/3k3euulZ4Q9DQqX1f47zBPXW5nUHu5zd9FiifMvDcrcQWf8eN3gpNpFptw9DxIEALDnyIAUP291Qe39teNPJ57Ca4J/ckgZ6sqE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VDJrdmNSRkNkcGltUlFhSVN0d3Myczg0Q3BqZEJBVjVWWDZiL0R6OFhkY2gr?=
 =?utf-8?B?cWdEK05rUTdSVXhXNTVsZUtqcTNzdDVtd1hWaW9MVlJJODZhSFcyS0xVOWpG?=
 =?utf-8?B?SkZGQ1ZoSjc0RVBBSDFnWU1aVG91ZkdUaDZVbDNWU3FnaUNIaWQyekFCaG1S?=
 =?utf-8?B?NVVrMXE3MVlaQ2V4T2VuVHUyOXJuN2Z2U3RxV3A4K1gzVGxhd3E0Tmoya2NQ?=
 =?utf-8?B?TU1nbzlFd2RDMVVOZ29QMXFUVFJlc0MxRnhCQS8xUU9Hcy9jcy9XR1BFaHpU?=
 =?utf-8?B?ZDRsNGZKVzVxRVJYZzhKaHNRY2xMNk9FUFdmUU5sVWpINWtUU0doODhZdzNX?=
 =?utf-8?B?aHhvS0lDcmROZ3dRUWFtT1ZXaGY3R1QzTTBIUkRORnJuVkROc1JjdUQyS3Rz?=
 =?utf-8?B?Ti8wTXFiTUhHKzhtU25LNFFTZSt2U3VTeUx4ZGFpQUUyNTdEb1UvNVF3TUFk?=
 =?utf-8?B?TmhTR1c3MDhXVHFTTE5FbkQ5anFPWHIrbzdQTGZXS0haMDJhL3RzelFCaGR3?=
 =?utf-8?B?TXVaRktCM256c255RWthNFBDa0k3Z2dXd3FqVnh6QzQvSVo1RVA1Rm82cFU5?=
 =?utf-8?B?ejdadHNMOTB5SGZ6RGpnTXNxRys2Q0FJUkhqSzBvSjNndWk2UkVEbXpNemxh?=
 =?utf-8?B?aGU4RW1XZzdYNE9jQXZkNzIvbW9zRGwzM3RJWEZUZ2t0bkdhb1NlSE5LNmU3?=
 =?utf-8?B?YVlZREQ2Z1hwUnFjVGp2TzV3cDBWVkwxcmVpN0dRU1k4NXMrZmwyd1FjWThG?=
 =?utf-8?B?MFZZakdSTytSVXdwVGJ3OGhXOTF6eDFPRENSMlhhMU0wekM0eU4zdGlHaC9U?=
 =?utf-8?B?TVc4bGk5MFBtNG1SeExQSXE2ZWtsZGFOaDhpdlpWUE1ra0pBV0UrNlhET2dr?=
 =?utf-8?B?YVYxYzZKYzdjUDU2TXNla1Ywck9JYVZ3M3IyRWhzZTYvMWhUSjB6Q201dmto?=
 =?utf-8?B?TjcyZkpNZ3UxMWc3S2NHZUxnckdFc0FiNTAvTk8zd0xHaUN5V1E0VUdjaHBJ?=
 =?utf-8?B?T3VnbHErOE5XbFpaWll0bGJITUdSaWh0OExGT2RsSVpiL1BQbHdSZ3FjaHhw?=
 =?utf-8?B?Qkh4QVMwWnBTN051ZUFVanJUQXJ6TkNYZ0ZiWGtnV1lCUFNuV3l2OHBvaTVQ?=
 =?utf-8?B?cERKZ3Z3aEhvWVkwdmo5NGY1MEp3WTlKVGZQYUZDM3E0Nkc0cjJFbnlleXJt?=
 =?utf-8?B?ZG14T3V2Z1RZWXg2ZFdWZmt5aHFGS0M2TWl4SGtOTEVsaDl2RWo3YUx3aVhx?=
 =?utf-8?B?Vkw3eTlZL09WWEk2YzBEeVJYMUF6RENJV1A0czhSOEc1bVh0cTBRRC8rTkxz?=
 =?utf-8?B?NWhwMXhYV1Z0VTg4eTMwV3lNdjR4bk5XanVhZFIwbS9xYWR3Z3Y0bmgzVnNU?=
 =?utf-8?B?YnNvaGRSMnhkRjFRUC94UE9MWXpKYnFBUFh3RzdQTlFzTEVwYWJWMFhKbVBz?=
 =?utf-8?B?V1VzelJpbzI2OGNTaGQ5ZXBScWNJVHBHT2wrNTQrS2RtZXhEQVF1MWp3WGpt?=
 =?utf-8?B?VWR2WEpNSnB1NHF4K3Jib1k1Z1RpNjdUVWZ0bldYUVp2dXBUTWQ1L0xJU2dy?=
 =?utf-8?B?VjZZR1cvd3oyOVZ4YncrMWN4T3prQ3VtR3pXV1dWVlZSZ1lIWlVMd0p4K04z?=
 =?utf-8?B?Y0xEZklKNUppQlFIWTRibDQ2aVZqQldsNitKMmo4Z1pMNUUvV3d0anBVdUxS?=
 =?utf-8?B?aWwvMU1mUUFmZDlnS1dlYS8rZXJRWlpDMmUvSDBwZDQweHpGaWZqeHZ0WW1K?=
 =?utf-8?B?Z09VcDFIWVliOFhTaTg0MmovZmE4VCs1WWgycXF1ZFlEeUVqR2VxTGxlNnU1?=
 =?utf-8?B?Qkl2ZWFWQVRTaWtYR1FaUzFycjI5RzBIUytnbFdDbHFVNDk2a2twUGVDOHo5?=
 =?utf-8?B?cnZDdW9mM2x3LzIvUDRpVHplV1E1WXRsMUZEOUJmdzRPbGJvb0Jtb0NCd1V3?=
 =?utf-8?B?VlI5V0VrWi8vVWZ3bzFuSUF5amQzQ2dzeFhXcTlKRUZZUFRMd1dleHVoNDdP?=
 =?utf-8?B?Slg3azlzNzZ3Q3ZUdUdGMWZEek5ocG4zdURQWERqdkhGUUVibGppd1doRHQ3?=
 =?utf-8?B?VlRlVGVML3l1RSsyWWhIU21DVkVmcHN2QklaWXFjK210ejkyVVh3NzBEaVBS?=
 =?utf-8?B?cjJmZit4SnhpdTRGakZjeVB4SDhNZkpHTHVwZEJNaWZ4U2VnUTNhelh4K2pm?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <244352431A83004AABF6D7572DFB1DAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HhAYftGnQgJKHBOqM12Ri8c+vZjo/4BwrwDlqpQeDtcW2ZxH0/CsEbnoF4HCaPRhnldwvHjguoXtc9DJE/FZRdOHOaAvbgJbaA1TU8mCgy4pCg/I3aqymgtACLTqzz4H19QDIQ3yqnfmaFEs2R3ilpYc6rrcChvMHKU+y4pSd5ZrGCSWDm15ydoUl65AXd7JFTaeYPPIG90mLyqEm88+DOq4Z8D/sLBXojB5IQ5kjfgieVe2db5SJefgyGSyeIS/T40/LHzr6fzzcJ6j5FqlpOZYSa3lTFU07BvjCdLe+Cuxve/tGOma+Gg3zQHHrUF4m9gCWlBGrb2hxbFm4m28CAYRoJZO6uitsmHZrTH9NzpgE2HBQbk4u/PmPe8DzqZJqKTw00QKzIRJf8rMCiqaQBZywIlRZpGYflRDdmdNemjTeU5PkseUkp0yolH+e4HCq0fAoqGqtPY4iY3QdJ9ENAVlIkuWoaD9YRxej+ZORYQjLvvUXDlaVjm7AhNUPvB4Tyq1phQU1DrtCU9KbTX+miu4UQ1gEykdupo0qSw9+AZxOcV0dwJSA5XHS6Yf4YfEMgjnkBhe5lkIYYag6iqZc8umWsbNrb6Eon1L7xXM/TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e567772-1950-47cb-5665-08dc5973db13
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 15:35:31.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pyh/brXKgZQzAj3O13O0uQvEl4Aq0KZY1SUwwIp+aLKP9mshgqYkmVU9CbiCjh6mNgLnJmIapGOoJ2qZrl/7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100113
X-Proofpoint-ORIG-GUID: KaVteNMBpE7v0Ao7-LafYhvEy3WWdPp8
X-Proofpoint-GUID: KaVteNMBpE7v0Ao7-LafYhvEy3WWdPp8

SGkgSm9uYXRoYW4sDQoNCj4gT24gMTAgQXByIDIwMjQsIGF0IDEzOjEzLCBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQEh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAg
OSBBcHIgMjAyNCAxNTowNTozMCArMDAwMA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3Jh
Y2xlLmNvbT4gd3JvdGU6DQo+IA0KPj4gSXNvbGF0ZSB0aGUgZXZhbHVhdGlvbiBvZiBwcm9jZXNz
b3IgZGVjbGFyYXRpb24gaW50byBpdHMgb3duIGZ1bmN0aW9uLg0KPj4gDQo+PiBObyBmdW5jdGlv
bmFsIGNoYW5nZXMuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwu
bHVpc0BvcmFjbGUuY29tPg0KPiANCj4gSGkgTWlndWVsLA0KPiANCj4gSSdkIGxpa2UgbW9yZSBk
ZXNjcmlwdGlvbiBpbiBlYWNoIHBhdGNoIG9mICd3aHknIHRoZSBjaGFuZ2UgaXMgdXNlZnVsLiAN
Cg0KQWNrISBDb21wbGV0ZWx5IGFncmVlLiBUaGlzIHNob3VsZCBiZSB0aHJvdWdob3V0IHRoZSBz
ZXJpZXMgd2hpbGUgcmVseWluZyBsZXNzDQpvbiB0aGUgY292ZXItbGV0dGVyIHRoZW4uDQoNCj4g
DQo+IEEgZmV3IGNvbW1lbnRzIGlubGluZS4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4gLS0tDQo+
PiBkcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYyB8IDc4ICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMjcg
ZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV9wcm9j
ZXNzb3IuYyBiL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jDQo+PiBpbmRleCA3YTBkZDM1
ZDYyYzkuLjM3ZThiNjkxMTNkZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX3By
b2Nlc3Nvci5jDQo+PiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPj4gQEAg
LTIzMCwxNSArMjMwLDU5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGFjcGlfcHJvY2Vzc29yX2hvdGFk
ZF9pbml0KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpDQo+PiB9DQo+PiAjZW5kaWYgLyogQ09O
RklHX0FDUElfSE9UUExVR19DUFUgKi8NCj4+IA0KPj4gK3N0YXRpYyBpbnQgYWNwaV9ldmFsdWF0
ZV9wcm9jZXNzb3Ioc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UsDQo+PiArICAgIHN0cnVjdCBh
Y3BpX3Byb2Nlc3NvciAqcHIsDQo+PiArICAgIHVuaW9uIGFjcGlfb2JqZWN0ICpvYmplY3QsDQo+
PiArICAgIGludCAqZGV2aWNlX2RlY2xhcmF0aW9uKQ0KPiANCj4gSSdkIHVzZSBhIGJvb2wgKiBm
b3IgZGV2aWNlX2RlY2xhcmF0aW9uLg0KDQpBZ3JlZS4NCg0KPiANCj4+ICt7DQo+PiArIHN0cnVj
dCBhY3BpX2J1ZmZlciBidWZmZXIgPSB7IHNpemVvZih1bmlvbiBhY3BpX29iamVjdCksIG9iamVj
dCB9Ow0KPj4gKyBhY3BpX3N0YXR1cyBzdGF0dXMgPSBBRV9PSzsNCj4gDQo+IFN0YXR1cyBhbHdh
eXMgd3JpdHRlbiBzbyBkb24ndCBpbml0aWFsaXplIGl0Lg0KDQpBZ3JlZS4gDQoNCj4gDQo+PiAr
IHVuc2lnbmVkIGxvbmcgbG9uZyB2YWx1ZTsNCj4+ICsNCj4+ICsgLyoNCj4+ICsgICogRGVjbGFy
YXRpb25zIHZpYSB0aGUgQVNMICJQcm9jZXNzb3IiIHN0YXRlbWVudCBhcmUgZGVwcmVjYXRlZC4N
Cj4gDQo+IEJlIGNsZWFyIHdoZXJlIHRoZXkgYXJlIGRlcHJlY2F0ZWQuIGkuZS4gdGhlIEFDUEkg
c3BlYyBhbmQgd2hpY2ggdmVyc2lvbiBhbmQNCj4gdW5kZXIgd2hhdCBjaXJjdW1zdGFuY2VzLiAN
Cg0KQWNrLg0KDQo+IA0KPiBPciBkb24ndCBzYXkgaXQuIEZyb20gTGludXgga2VybmVsIHBvaW50
IG9mIHZpZXcgd2UgbmVlZCB0byBzdXBwb3J0IHRoaXMgYW55d2F5DQo+IGZvciBhIGxvbmcgbG9u
ZyB0aW1lLCBzbyBrbm93aW5nIHRoZXkgYXJlIGRlcHJlY2F0ZWQgaW4gdGhlIEFDUEkgc3BlYw0K
PiBpc24ndCByZWFsbHkgb2YgaW50ZXJlc3QuDQoNCkFzIHRoZSBpbml0aWFsIGVmZm9ydCBpcyB0
byB1bmRlcnN0YW5kIGl0IGJldHRlciBpdCBtaWdodCBiZSB3b3J0aCBnaXZpbmcgaXQgYSB0cnku
DQoNCj4gDQo+PiArICAqLw0KPj4gKyBpZiAoIXN0cmNtcChhY3BpX2RldmljZV9oaWQoZGV2aWNl
KSwgQUNQSV9QUk9DRVNTT1JfT0JKRUNUX0hJRCkpIHsNCj4+ICsgLyogRGVjbGFyZWQgd2l0aCAi
UHJvY2Vzc29yIiBzdGF0ZW1lbnQ7IG1hdGNoIFByb2Nlc3NvcklEICovDQo+PiArIHN0YXR1cyA9
IGFjcGlfZXZhbHVhdGVfb2JqZWN0KHByLT5oYW5kbGUsIE5VTEwsIE5VTEwsICZidWZmZXIpOw0K
Pj4gKyBpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsNCj4+ICsgZGV2X2VycigmZGV2aWNlLT5k
ZXYsDQo+PiArICJGYWlsZWQgdG8gZXZhbHVhdGUgcHJvY2Vzc29yIG9iamVjdCAoMHgleClcbiIs
DQo+PiArIHN0YXR1cyk7DQo+PiArIHJldHVybiAtRU5PREVWOw0KPj4gKyB9DQo+PiArDQo+PiAr
IHZhbHVlID0gb2JqZWN0LT5wcm9jZXNzb3IucHJvY19pZDsNCj4+ICsgZ290byBvdXQ7DQo+IA0K
PiBJJ2Qga2VlcCB0aGUgaWYgLyBlbHNlIGZvcm0gb2YgdGhlIG9yaWdpbmFsIGNvZGUuIEkgdGhp
bmsgaXQncyBlYXNpZXIgdG8gZm9sbG93IGdpdmVuDQo+IHRoaXMgcmVhbGx5IGlzIGNob29zaW5n
IGJldHdlZW4gMiBvcHRpb25zLg0KDQpOb3cgdGhlcmXigJlzIG9ubHkgb25lIEFTTCBkZWNsYXJh
dGlvbiBpbiB0aGUgZGVwcmVjYXRpb24gbGlzdCBzbyBmYXIgc28gdGhlIGlmIC8NCmVsc2UgaW5p
dGlhbCBmb3JtIHN1aXRzIHRvbyBmb3IgcmVhZGFiaWxpdHksIGFsYmVpdCB0aGlua2luZyB0aGUg
c3VnZ2VzdGVkDQpwYXR0ZXJuIHdvdWxkIGhlbHAgaW4gdGhlIGZ1dHVyZSB3aGVuIHRoZXJl4oCZ
cyBhIG5ldyBzdGF0ZW1lbnQgdG8gYWRkIG9uIHRoZQ0KZGVwcmVjYXRpb24gc2NvcGUuDQoNCkni
gJlsbCBrZWVwIHRoZSBvcmlnaW5hbCBpZiAvIGVsc2UgZm9ybS4NCg0KPiANCj4+ICsgfQ0KPj4g
Kw0KPj4gKyAvKg0KPj4gKyAgKiBEZWNsYXJlZCB3aXRoICJEZXZpY2UiIHN0YXRlbWVudDsgbWF0
Y2ggX1VJRC4NCj4+ICsgICovDQo+PiArIHN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihw
ci0+aGFuZGxlLCBNRVRIT0RfTkFNRV9fVUlELA0KPj4gKyBOVUxMLCAmdmFsdWUpOw0KPj4gKyBp
ZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsNCj4+ICsgZGV2X2VycigmZGV2aWNlLT5kZXYsDQo+
PiArICJGYWlsZWQgdG8gZXZhbHVhdGUgcHJvY2Vzc29yIF9VSUQgKDB4JXgpXG4iLA0KPj4gKyBz
dGF0dXMpOw0KPj4gKyByZXR1cm4gLUVOT0RFVjsNCj4+ICsgfQ0KPj4gKw0KPj4gKyAqZGV2aWNl
X2RlY2xhcmF0aW9uID0gMTsNCj4+ICtvdXQ6DQo+PiArIHByLT5hY3BpX2lkID0gdmFsdWU7DQo+
IA0KPiBNYXliZSBiZXR0ZXIgdG8gcGFzcyBpbiB0aGUgcHItPmhhbmRsZSwgYW5kIHJldHVybiB2
YWx1ZSBzbw0KPiBwci0+YWNwaV9pZCBpcyBzZXQgYXQgdGhlIGNhbGxlciByYXRoZXIgdGhhbiBz
ZXR0aW5nIGl0IGluDQo+IHRoaXMgaGVscGVyIGZ1bmN0aW9uPyAgVGhhdCB3aWxsIGtlZXAgdGhl
IHByLT54IHNldHRpbmcNCj4gYWxsIGluIG9uZSBwbGFjZS4NCg0KR290IGl0ISBMZXTigJlzIGxl
YXZlIGl0IHRvIHRoZSBjYWxsZXIuDQoNCj4gDQo+PiArIHJldHVybiAwOw0KPj4gK30NCj4+ICsN
Cj4+IHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfZ2V0X2luZm8oc3RydWN0IGFjcGlfZGV2aWNl
ICpkZXZpY2UpDQo+PiB7DQo+PiB1bmlvbiBhY3BpX29iamVjdCBvYmplY3QgPSB7IDAgfTsNCj4+
IC0gc3RydWN0IGFjcGlfYnVmZmVyIGJ1ZmZlciA9IHsgc2l6ZW9mKHVuaW9uIGFjcGlfb2JqZWN0
KSwgJm9iamVjdCB9Ow0KPj4gc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciA9IGFjcGlfZHJpdmVy
X2RhdGEoZGV2aWNlKTsNCj4+IGludCBkZXZpY2VfZGVjbGFyYXRpb24gPSAwOw0KPj4gYWNwaV9z
dGF0dXMgc3RhdHVzID0gQUVfT0s7DQo+PiBzdGF0aWMgaW50IGNwdTBfaW5pdGlhbGl6ZWQ7DQo+
PiB1bnNpZ25lZCBsb25nIGxvbmcgdmFsdWU7DQo+PiArIGludCByZXQ7DQo+PiANCj4+IGFjcGlf
cHJvY2Vzc29yX2VycmF0YSgpOw0KPj4gDQo+PiBAQCAtMjUyLDMyICsyOTYsMTIgQEAgc3RhdGlj
IGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfaW5mbyhzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkN
Cj4+IH0gZWxzZQ0KPj4gZGV2X2RiZygmZGV2aWNlLT5kZXYsICJObyBidXMgbWFzdGVyaW5nIGFy
Yml0cmF0aW9uIGNvbnRyb2xcbiIpOw0KPj4gDQo+PiAtIGlmICghc3RyY21wKGFjcGlfZGV2aWNl
X2hpZChkZXZpY2UpLCBBQ1BJX1BST0NFU1NPUl9PQkpFQ1RfSElEKSkgew0KPj4gLSAvKiBEZWNs
YXJlZCB3aXRoICJQcm9jZXNzb3IiIHN0YXRlbWVudDsgbWF0Y2ggUHJvY2Vzc29ySUQgKi8NCj4+
IC0gc3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9vYmplY3QocHItPmhhbmRsZSwgTlVMTCwgTlVMTCwg
JmJ1ZmZlcik7DQo+PiAtIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgew0KPj4gLSBkZXZfZXJy
KCZkZXZpY2UtPmRldiwNCj4+IC0gIkZhaWxlZCB0byBldmFsdWF0ZSBwcm9jZXNzb3Igb2JqZWN0
ICgweCV4KVxuIiwNCj4+IC0gc3RhdHVzKTsNCj4+IC0gcmV0dXJuIC1FTk9ERVY7DQo+PiAtIH0N
Cj4+IC0NCj4+IC0gcHItPmFjcGlfaWQgPSBvYmplY3QucHJvY2Vzc29yLnByb2NfaWQ7DQo+PiAt
IH0gZWxzZSB7DQo+PiAtIC8qDQo+PiAtICAqIERlY2xhcmVkIHdpdGggIkRldmljZSIgc3RhdGVt
ZW50OyBtYXRjaCBfVUlELg0KPj4gLSAgKi8NCj4+IC0gc3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9p
bnRlZ2VyKHByLT5oYW5kbGUsIE1FVEhPRF9OQU1FX19VSUQsDQo+PiAtIE5VTEwsICZ2YWx1ZSk7
DQo+PiAtIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgew0KPj4gLSBkZXZfZXJyKCZkZXZpY2Ut
PmRldiwNCj4+IC0gIkZhaWxlZCB0byBldmFsdWF0ZSBwcm9jZXNzb3IgX1VJRCAoMHgleClcbiIs
DQo+PiAtIHN0YXR1cyk7DQo+PiAtIHJldHVybiAtRU5PREVWOw0KPj4gLSB9DQo+PiAtIGRldmlj
ZV9kZWNsYXJhdGlvbiA9IDE7DQo+PiAtIHByLT5hY3BpX2lkID0gdmFsdWU7DQo+PiAtIH0NCj4+
ICsgLyoNCj4+ICsgICogRXZhbHVhdGUgcHJvY2Vzc29yIGRlY2xhcmF0aW9uLg0KPiBHaXZlbiBm
dW5jdGlvbiBuYW1lICh3aGljaCBpcyB3ZWxsIG5hbWVkISkgSSBkb24ndCBzZWUgdGhlIGNvbW1l
bnQgYWRkaW5nIGFueXRoaW5nLg0KPiBTbyBJJ2QgZHJvcCB0aGUgY29tbWVudC4NCg0KSeKAmW0g
Z2xhZCBpdCBwYXNzZWQgdGhlIG5hbWluZyB0ZXN0IDopDQpJ4oCZbGwgcmVtb3ZlIHRoZSBjb21t
ZW50Lg0KDQpUaGFua3MhDQoNCk1pZ3VlbA0KDQo+PiArICAqLw0KPj4gKyByZXQgPSBhY3BpX2V2
YWx1YXRlX3Byb2Nlc3NvcihkZXZpY2UsIHByLCAmb2JqZWN0LCAmZGV2aWNlX2RlY2xhcmF0aW9u
KTsNCj4+ICsgaWYgKHJldCkNCj4+ICsgcmV0dXJuIHJldDsNCj4+IA0KPj4gaWYgKGFjcGlfZHVw
bGljYXRlX3Byb2Nlc3Nvcl9pZChwci0+YWNwaV9pZCkpIHsNCj4+IGlmIChwci0+YWNwaV9pZCA9
PSAweGZmKQ0KDQoNCg==

