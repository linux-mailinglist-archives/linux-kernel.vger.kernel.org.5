Return-Path: <linux-kernel+bounces-140284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB18A123F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772D22815A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3D145B13;
	Thu, 11 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OA40fiz9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lDqUCrJh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62062EAE5;
	Thu, 11 Apr 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832756; cv=fail; b=n5xWNhqz1CJoESv6XSVH26Jl/jLDtVRngXyei3zXTOqqFRhACjpxdNpKHpcW6yu6AK5pgP/u23FbjIsGsp42HwOfvd035W5KhsAR8CrmqudSh1pgy1/pFPzeBr2E/AFvlYvDGCVQprqpc2tcJ934ga8WnJZL4Y+bbQghFgNP07I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832756; c=relaxed/simple;
	bh=+u3ccRAeqUFVLb6dSHGRnNbEitmDV3AOzufUjKeMohU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pwoylW/5FKehov3d+5Pwygt2wkvil5w2hJaX0A8o6DNf5RSSJn9KeRowWIbld7DBc2KnW/+xrVIZOZN3ORUanzon+seyiRSyB8CR8OmmoRCYCh84R6OiP/ZoDIMg5a+UOmWXsgkR6OXV/Q9+DtD9kwj7QSdsXMgPmXi2JeM15n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OA40fiz9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lDqUCrJh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B8uMbR021645;
	Thu, 11 Apr 2024 10:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+u3ccRAeqUFVLb6dSHGRnNbEitmDV3AOzufUjKeMohU=;
 b=OA40fiz923ldxwyBgjDgfDz4H4wwxTffqQkxWmqRArB4z4Nm8UgdNVw7qegKOtHCaLmL
 sirFcXYi19rBm+M7kw05S1nrvZwaJ24dxb4sWayUxXxYmVdlPFtxF0ZcbFU+X1Apv50f
 pnZ1EcREschT5J/sOVf3CqdSBuQmyr97sLidMDqpaJ3UjJcP3zCxa19cGvm237QaZnQ6
 woCxEOM7I980KYc7RumcNnJfxqaeGgRBIVua6w/Wc9l1T49R2YDm4qwA6BC9pU0EJTxn
 lwciqzSsuomnQM0NEVuatMzPCJzK0ODWU9C2ua/id2kgeuU88ccr1suwk9zfOn94t7VF iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedsdya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 10:52:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43B8IxAc002883;
	Thu, 11 Apr 2024 10:52:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavufmp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 10:52:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlHWKXFvF6smIQ4TD6vRY3bceEh0zXcnS0Jb+545QbOXiXRnSoXcUgqde44LC/IDEFDbHOH/cehKuXQgjLz48HSavjLwf2mrJf8r9guj+/EgiJuXeGVB8/oH10y/wd93K08NV3TjPkckbpFJGay09bzB6mD5iVx1Ym7wqnDHMPIY9BCCyq6brLatPYA2NYdex+jizEV1zo1FOv1X1/NPaaqrMiaoZPVh8Q7CVmCJPM6yuwCPPByxIlTKYsYnKVoYNwKbO5AsYm9HXrTbbN3RCfJY0a5cukhqGpNe6Q/P/wocGmJmlm+DsgFanIGnPkzsajifTChhwcQpnAR2ecXnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u3ccRAeqUFVLb6dSHGRnNbEitmDV3AOzufUjKeMohU=;
 b=BTtmE8UR5uTlHbxOHatNyvIZTNBCPVASW1hFQ5Orj51z1xuRvzbzs/ruYybtwAlIwoaHNTHVDjOLGNJJzfJdC5eojLOAEGXEeOOaAW16lw5KHJkwHtTj611fU4fv+vPVjd7N+GPJpYpX7Qw19BoTxu8pRD2O6m9j/SorZIPFAQmmBvsT33JfZ7WoRUcHNRWSzpfrXI+TXRdkoUQpqd/h6oe4pIGz28W3C1mgXhDYdbzPcFfVDB1iQdsQ7dhQgBk95WIl6TDkZn4cRAGk4AgBham9xit8Xhje59Ov9qktbHiM8x4MTHxUKQBQll7xE3hKMLnDRSyTbvntMJv0mnEndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u3ccRAeqUFVLb6dSHGRnNbEitmDV3AOzufUjKeMohU=;
 b=lDqUCrJh71O8TOfHZlsy9nTh+hGUKwGlELiXzW4XfBiU50EGKPWjC/UNOAkCYKvjNcQUZxHH2Ylt9jBfoQJv62H38N1K1U0FMU0VukmT4fN2JhiwIXfCyc0U12xcDr/6VcbEA/f6Jg/Xf79Sq4ffSr53N9AEST/6PHB/t1qRPNo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 10:52:13 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 10:52:13 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Topic: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Index: AQHaio+bKzbJEucF902Gmw2yADhKgLFhf5GAgABVT4CAABTwgIAA/Z8A
Date: Thu, 11 Apr 2024 10:52:13 +0000
Message-ID: <11AF41A3-05DD-4100-B327-295EF74FE7F6@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-4-miguel.luis@oracle.com>
 <20240410142359.00003dea@Huawei.com>
 <AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
 <20240410204415.00005597@Huawei.com>
In-Reply-To: <20240410204415.00005597@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SN7PR10MB6361:EE_
x-ms-office365-filtering-correlation-id: 0eb9d277-4d64-4193-0818-08dc5a1571da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bMUPitGkg/f/ovn2RyVVhDC4tXGSPmIhhVMKFVHwB038dYp6aIvjWqBkXG3jfo9vgFk+xyQyIkwfPnc13QBApahTh2Qah1xt5M9RxXm+BCaUcfhKvXB9d5b/n7JKM4SdvWvsm8a5De3zlqO0AHoPghfZGbHuBDR0qFD3OaLdjGLCNqj3ET9WsBroblYP9YIrZ00XEEMAcXLfNzBoJFV6dED5vCQSwOKZfMMa3SCkxeXkwEo++3ftYy9TOEBVdPgp7bcok+RsNKLBDW24IDJDPJMROfbRRijR4Qi8U+DeKFIh+KDmW2TXzMbFvBmJPRMC1TH/g5XkkFYwwC7FG/ZAtqONSfk69a8AMFIbpQ8JYqH4wO2hj9ubN+sDf3yVVInX6CazsR+H5qNsYnPcOHAU/DfCKSU/NHG4DQAsLtNrozF/G/0YmNhHlk+IGPmM+/fSEumf/07l65BxioqESoj/4C48J3tEJ6cd3ttMK1/Ac+RKYfla4eTpJbKGI3+fQSwbF6rKD2trn6+Sbp7dL/vfeia4ilFzVb0x7Ui3wACYzaK2lzsA1Uryx67oAjtQrH/Y/5IiVkbT3XvOmDfirL9a1pZQGYwszaa+uLcnu3QQZtAX0Ma7qmQQ6+Hr/xt6qbHQRtwuNB8TVbhijbzpB0v4w6wY40XKSmBrHIm44I8Dep67VRld0vzdhn+3ONPiObettXpNb97dpi3KedwP//L9EA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHdOUEIraHpvZlloTUxlelllWXEzdm8xOGxCN0ZvbkwrYXVuK291Skd2SFFN?=
 =?utf-8?B?bGUwckJ1STJLSm5GTE9zMjU4cFJIbVBzVTBnQjFtVmZaTjcweDRQV0RvNnBn?=
 =?utf-8?B?d2kzR1Uyeld2TXdwSVMwN1JFSjJvalF3VFg5c1FHZi9rZ200Q0I3dlNLNVhx?=
 =?utf-8?B?TlU4SkRZRmkydWdEQ2xNWERNWi92TGJRRjRsais2cTBXQkh5Z3dnZ1BVQ2U2?=
 =?utf-8?B?L0FiSnExOVhNYnJGSjU5YlQ4c0wzNTNGc094NzMrbGdJZlJpeGYwNVR1dTBT?=
 =?utf-8?B?QkZNWURQWXdoMldSclBScWRQME11K0w0bDNBV2lXUHVTSWxQTEVVQ0xPRWpp?=
 =?utf-8?B?YXdGZVFnY05YR1dBdXF4M1dFT1RzbHEzNDFvbGZ5YWNNakkwNlNSQXozYUlL?=
 =?utf-8?B?a3pKd3VhVitoNThxeXo2YWlvWlZ0WklXeXl6Z256ZTEvZ3Y0WitiZWJUblZO?=
 =?utf-8?B?UnZ5TXEvQUdmNTdUWTNQKzRsVVBwUEtPeDI0ZGZsR2EvY0lROXJaaXJDSXBI?=
 =?utf-8?B?WjZkOE5YdEk2YU96Z2RoWEhGeDRaeVkwT0tGblR3MXhucnRad1hlcHFLeUVS?=
 =?utf-8?B?S1MzL1JEWU1HbUp3aXdVNS96VEFaa2VqeXZERkRveUZlZzd6MEtUTVN5M0Nk?=
 =?utf-8?B?WGVCRldaNVpzeWdzUzc5U0RuMXBIUnJvNVhwY2JMUVpuVTNSeFptbVZWQUNh?=
 =?utf-8?B?b2hzNXoxa09rZHZNU2FIVXdNRFp4ZU92QitkVnJHOUpOM2J3bDhhZm83YkRn?=
 =?utf-8?B?enhHUCttQmNBZHk5bjZvMUxOWUJaSnQ1NEQvV3d3QmtVT0xaN0VGQktLMUFq?=
 =?utf-8?B?aFZFWVptbys4RnRsZ0hKR2tMRGU3VUpuU1FJbElQYVFFNzNhMzZhNnY3VjlR?=
 =?utf-8?B?aHB3T09ET0o5ODliZ0JDMExHUUZUVTgvWUtLa3MrL0lHVU1ITk9VK3VyazdG?=
 =?utf-8?B?ZGZIRDQ3RkpkVG1LMG15UjhPT05ldWdCL1RjMTY2NzUzR3lKVzV6UytBZXhl?=
 =?utf-8?B?bGVFWUVONzhIakNaN2VJR0lNWm5yVlB3amE0OVlwb29xT2ZhVDkxaGtlaVE0?=
 =?utf-8?B?MEdlV1QxL25HVkdCODg3djQzU01zQlhJVmVWU2c0K0tVdFBIZVhocmlxNm9D?=
 =?utf-8?B?bVhLemR6UzFKUHdRdEg2YTdPSzVNQWtpbUxtV1NwZi9nOEZDMStyWVh3SmtL?=
 =?utf-8?B?d281ejZkdHYzVGtRdUJLaEV3Nmx2bElqaE9jMWxaMWRJUG5USHNuMkc3cEVR?=
 =?utf-8?B?QXRtVmFQdTdlMWIvM2NQV2pHWFBCKzU0ZTc2UDZnbzMwSDZWRUpWelU0YTha?=
 =?utf-8?B?ME80d1RvYW15WTZ5U1BrVzArWEFpc2MwNnJhMmpOay9VeFpKa3VHTTJjZGU2?=
 =?utf-8?B?ZkdIa3l0YzVaMGV0LzNJaGZydGo2dUtzMUYrNUdqNU8vSFlVa3hDY1pzV1lW?=
 =?utf-8?B?czl3SmFNNE5reFhnVHJzTFBiVUkzRzBZSnZkQlhzdjUvWm15U1FvT1A5OVVN?=
 =?utf-8?B?eEdaYTVLZWVYeHVUQ1N3OEg5RUFvV1prVy9lWE1ZUit6WFQ1cENmZElzN2U1?=
 =?utf-8?B?dVgvU3RXYU1lT0ZWN3VmMDJhVXRMZDlOWWtWZE9LSFBEb28wRm5adVpiTy80?=
 =?utf-8?B?S0hLb1VXZ0FuYnVBQ25MN1BIWDFsbTluL1dtTFlqUVREdkZzbFh0aE9tQWdK?=
 =?utf-8?B?OThaN0s5K3Z0M0M3eUNXTEZmcVN0R2hhclRnalB1RFRjU2FlTzkrSmxvSWRS?=
 =?utf-8?B?ZkMwVFZoM05DSlFCeE9TQlBSKy9Oa3JYYlBrcHNsWEtJbm96U0s4bHMzZmZM?=
 =?utf-8?B?SXZCQmRrQnc2Umg5cW9YR1Irb0M1T053d3hISGNBY3pibEpwQTFRcDdVNXdl?=
 =?utf-8?B?ZHU2NStqbU1Tb2hlS2ppQTFSQUlBdVpkbEpwR3lTTUZ6UTdjWkQvNHRKTGhE?=
 =?utf-8?B?YWNKRDNnYmpkcWpKeGdXMXBqZmVEWmlZSTZvQ29YUE5XV3Z3Y3VyWmVVdzJE?=
 =?utf-8?B?QzE2QmdZaVpGZGxVcU1UWFd0UW1YdHdoWU5YcVF6RTZBNEhQTG1EOWZjWHY0?=
 =?utf-8?B?YXVGTVlZR2ptdTlwd241NGM4dW4rUFV3MWxwU2lwOEtOMXAwTjNVaURnZVJz?=
 =?utf-8?B?aE1mQmplY1huZ0FxVWRyRWVSYjhhQ1N5YTBFYWkzL0VxVm56ZHVyVmtLVmZZ?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1771F62B9412D94BB091F960C63B3900@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JW884aWwQf1CKwhESISIeLznHPcoXH+TeTbUWmvWknp13nUqULPkfR6Xp714YDeYcqXddVTu55oNKjSl28fcVVIQ/BajpYOFRt2bfIa09vp/e6Qjs5cAAbKMy1KDPHZZtIu/4RTUxK315qOGaymrCwAHWb00k+ykw7+oVhDM0RSA/+9k34Z08VJ6Nl08aTOlOcfK9NK0hAksUUmyPTfczI5mcGriDgJ6i/ODgHUoR44HMBscuhQHBrSGkLBdRDoX8wzx1lVPLvoOFZtNRdsnIJR36imVQ0JwVK/Vz1k4e9q2IAD8VFyaBgZeOP0DiR3SOS5AoN4fIH5WePIYqSfMR0pDJaePFCNIRX1k7OU/TAQBKrWPOSPncCTZ2+IaKl6SncQ/XGu2K36sHHjrBacjF5O7hH8XO6aTG5uHPqDZ4YftpskrXOEGsmWYMjXihU6f5v9QFe1kJFEzH7lDXFkN/o+dSLuVOI33tyNSykEd4Z8ihe1659ebDpsmzAKMQPwbKx0bBnE1K/u8CIAqtW3kJF0gw3TBkJrH89HNCkfNXvw9do5CcpxZupNWkxp34nREr6mTj4dtKXrnUCexkMP3W84cpyULVVPlV5uf37pvRfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb9d277-4d64-4193-0818-08dc5a1571da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 10:52:13.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +i/tLPnqURuak2+UjwKBZ9IlX/Mr4+ZaHPtJftM4EO7gDI+/Db/n8wn17T2k8eZmVY2Wx1VWY65FMwNukzSN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110078
X-Proofpoint-GUID: QIDVlVy7criD9ryDvsO_DxFbOx2Dm2p1
X-Proofpoint-ORIG-GUID: QIDVlVy7criD9ryDvsO_DxFbOx2Dm2p1

DQoNCj4gT24gMTAgQXByIDIwMjQsIGF0IDE5OjQ0LCBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAxMCBBcHIgMjAyNCAx
ODoyOTozNCArMDAwMA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+IA0KPj4+IE9uIDEwIEFwciAyMDI0LCBhdCAxMzoyMywgSm9uYXRoYW4gQ2FtZXJvbiA8
Sm9uYXRoYW4uQ2FtZXJvbkBIdWF3ZWkuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsICA5
IEFwciAyMDI0IDE1OjA1OjMyICswMDAwDQo+Pj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9y
YWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+PiBtYXBwaW5nIGFuZCB1bm1hcGluZyBhIGNwdSBh
dCB0aGUgc3RhZ2Ugb2YgZXh0cmEgY3B1IGVudW1lcmF0aW9uIGlzDQo+Pj4+IGFyY2hpdGVjdHVy
ZSBzcGVjaWZpYyB3aGljaCBkZXBlbmRzIG9uIENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVIHNvIGxl
dCdzDQo+Pj4+IGlzb2xhdGUgdGhhdCBmdW5jdGlvbmFsaXR5IGZyb20gYXJjaGl0ZWN0dXJlIGlu
ZGVwZW5kZW50IG9uZS4gIA0KPj4+IA0KPj4+IFNob3VsZCB3ZSBjb25zaWRlciByZW5hbWluZyBh
Y3BpX21hcF9jcHUoKSB0byBhcmNoX2FjcGlfbWFwX2NwdSgpDQo+Pj4gdG8gbWFrZSB0aGUgYXJj
aCBzcGVjaWZpYyBuYXR1cmUgb2YgdGhhdCBjYWxsIG1vcmUgb2J2aW91cz8gIA0KPj4gDQo+PiBO
b3Qgc3VyZSBhYm91dCB0aGUgcGF0dGVybiB0byB1c2UgaGVyZSBidXQgdGhhdCBzZWVtcyBmaW5l
IHRvIG1lLiBDdXJyZW50IHVzYWdlDQo+PiBpcyBhcmNoaXRlY3R1cmVzIGV4cG9ydCBhY3BpX21h
cF9jcHUgZnJvbSB0aGUgYWNwaSBpbnRlcmZhY2UgYW5kIGRvIHRoZWlyDQo+PiB0aGluZy4NCj4+
IA0KPj4gUXVlc3Rpb24gaXMgd2hhdCB0byBkbyB3aGVuIHRoZXJl4oCZcyBhIHVzZS1jYXNlIHdo
aWNoIGRpc21pc3NlcyBhY3BpX21hcF9jcHUgYW5kDQo+PiBpdCBnZXRzIGNhbGxlZCBvbiB0aGUg
Y29kZSBwYXRoPw0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gYnkgZGlzbWlzc2Vz
Pw0KPiANCg0KSSBtZWFuIHdoZW4gYWNwaV9tYXBfY3B1IGlzIG5vdCBuZWVkZWQuDQoNCj4gSXMg
bWlzc2luZyBwZXJoYXBzPw0KDQpZZXMuDQoNCj4gIElmIHRoYXQgaXMgd2hhdCB5b3UgbWVhbiwg
SSB0aGluayBpdCdzIGEgbWlzdGFrZSB0byBhbGxvdw0KPiB0aGF0IGNvZGUgdG8gYmUgY2FsbGVk
IGZyb20gYSBwYXRoIHRoYXQgaXNuJ3QgZGVwZW5kZW50IG9uDQo+IENPTkZJR19BQ1BJX0hPVFBM
VUdfQ1BVLg0KPiBJdCBtYWtlcyBubyBzZW5zZSB0byBkbyBzbyBhbmQgc3R1YmJpbmcgaXQgb3V0
IHRvIGdpdmUNCj4gdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgY2FsbGluZyBpdCBkb2VzIG1ha2Ug
c2Vuc2UgKHdoZW4gbG9va2luZyBhdCB0aGUgY2FsbGVyKQ0KPiBpcyBtaXNsZWFkaW5nLg0KDQpP
SywgdGhhdCB3b3VsZCBiZSB3aGF0IG5vdCB0byBkby4NCg0KYWNwaV9wcm9jZXNzb3JfZW51bWVy
YXRlX2V4dHJhIGNvdWxkIGRlYWwgd2l0aCBtYWtlX3ByZXNlbnQgYW5kIG1ha2VfZW5hYmxlZCB3
aGlsZQ0KYSBzdHViIHdvdWxkIHN0aWxsIGJlIG5lZWRlZCBmb3IgbWFrZV9wcmVzZW50IHNpbmNl
IGl0IGRlcGVuZHMgb24NCkNPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVPw0KDQpNaWd1ZWwNCg0KPiAN
Cj4gSm9uYXRoYW4NCj4gDQo+IA0KPj4gDQo+PiAxKSBleHBvcnQgaXQgYW5kIGRvIG5vdGhpbmcg
LSBpdCB3b3VsZCBiZSBjcmVhdGluZyB1bm5lY2Vzc2FyeSBkZXBlbmRlbmN5Lg0KPj4gDQo+PiAy
KSBldmFsdWF0ZSB3aGV0aGVyIGNhbGxpbmcgaXQgaXMgZXhjbHVzaXZlIHRvIHRoZSBDUFUgSFAg
cGF0aCBhbmQga2VlcCBpdCB3cmFwcGVkDQo+PiBpbnRvIENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BV
Lg0KPj4gDQo+PiBPcHRpb24gKDIpIGlzIHRoZSBjdXJyZW50IGFwcHJvYWNoIG9uIHRoaXMgUkZD
LiBJSVVDIGFjcGlfbWFwX2NwdSBpcyBzb2xlbHkNCj4+IHVzZWQgZm9yIENQVSBIUCBhbmQgdGhl
IHNhbWUgYXBwbGllcyB0byBhY3BpX3VubWFwX2NwdS4NCj4+IA0KPj4+IEkgdGhpbmsgdGhhdCBo
YXMgY2F1c2VkIG1vcmUgY29uZnVzaW9uIGluIHRoZSBkaXNjdXNzaW9uIHRoYW4NCj4+PiB3aGV0
aGVyIGl0IGlzIGhvdHBsdWcgc3BlY2lmaWMgb3Igbm90LiAgDQo+PiANCj4+IEluZGVlZC4gV2l0
aGluIHRoZSBDUFUgSFAgcGF0aCB0aGVyZSBhcmUgdGhlc2UgYXJjaCBzcGVjaWZpYyBpbnRyaWNh
Y2llcy4NCj4+IA0KPj4+IA0KPj4+IEFzIG1lbnRpb25lZCBpbiBwYXRjaCAyLCBmYWlybHkgc3Vy
ZSB0aGlzIG5lZWRzIHRvIGdvIGJlZm9yZSB0aGF0DQo+Pj4gcGF0Y2guICANCj4+IA0KPj4gMiBh
bmQgMyBkZXBlbmQgb24gZWFjaCB0byBiZSBzZWxmLWNvbnRhaW5lZCBhcyBDUFUgSFAgd291bGRu
4oCZdCB3b3JrIHdpdGhvdXQgbGF0ZQ0KPj4gQ1BVIGluaXRpYWxpc2F0aW9uIEkgdGhpbmsuDQo+
PiANCj4+IE1pZ3VlbA0KPj4gDQo+Pj4gDQo+Pj4gSm9uYXRoYW4NCj4+PiANCj4+Pj4gDQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4+
PiAtLS0NCj4+Pj4gZHJpdmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMgfCAxNyArKysrKysrKysr
KysrKystLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNz
b3IuYyBiL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jDQo+Pj4+IGluZGV4IDllYTU4YjYx
ZDc0MS4uYzZlMmY2NGEwNTZiIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaV9w
cm9jZXNzb3IuYw0KPj4+PiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3IuYw0KPj4+
PiBAQCAtMTk0LDggKzE5NCwyMSBAQCBzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVn
X2RlbGF5X2luaXQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+Pj4gcHJfaW5mbygiQ1BV
JWQgaGFzIGJlZW4gaG90LWFkZGVkXG4iLCBwci0+aWQpOw0KPj4+PiBwci0+ZmxhZ3MubmVlZF9o
b3RwbHVnX2luaXQgPSAxOw0KPj4+PiB9DQo+Pj4+ICtzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29y
X2hvdHBsdWdfbWFwX2NwdShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4+PiArew0KPj4+
PiArIHJldHVybiBhY3BpX21hcF9jcHUocHItPmhhbmRsZSwgcHItPnBoeXNfaWQsIHByLT5hY3Bp
X2lkLCAmcHItPmlkKTsNCj4+Pj4gK30NCj4+Pj4gK3N0YXRpYyB2b2lkIGFjcGlfcHJvY2Vzc29y
X2hvdHBsdWdfdW5tYXBfY3B1KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpDQo+Pj4+ICt7DQo+
Pj4+ICsgYWNwaV91bm1hcF9jcHUocHItPmlkKTsNCj4+Pj4gK30NCj4+Pj4gI2Vsc2UNCj4+Pj4g
c3RhdGljIHZvaWQgYWNwaV9wcm9jZXNzb3JfaG90cGx1Z19kZWxheV9pbml0KHN0cnVjdCBhY3Bp
X3Byb2Nlc3NvciAqcHIpIHt9DQo+Pj4+ICtzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2hvdHBs
dWdfbWFwX2NwdShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4+PiArew0KPj4+PiArIHJl
dHVybiAwOw0KPj4+PiArfQ0KPj4+PiArc3RhdGljIHZvaWQgYWNwaV9wcm9jZXNzb3JfaG90cGx1
Z191bm1hcF9jcHUoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikge30NCj4+Pj4gI2VuZGlmIC8q
IENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVICovDQo+Pj4+IA0KPj4+PiAvKiBFbnVtZXJhdGUgZXh0
cmEgQ1BVcyAqLw0KPj4+PiBAQCAtMjE1LDEzICsyMjgsMTMgQEAgc3RhdGljIGludCBhY3BpX3By
b2Nlc3Nvcl9lbnVtZXJhdGVfZXh0cmEoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+Pj4g
Y3B1X21hcHNfdXBkYXRlX2JlZ2luKCk7DQo+Pj4+IGNwdXNfd3JpdGVfbG9jaygpOw0KPj4+PiAN
Cj4+Pj4gLSByZXQgPSBhY3BpX21hcF9jcHUocHItPmhhbmRsZSwgcHItPnBoeXNfaWQsIHByLT5h
Y3BpX2lkLCAmcHItPmlkKTsNCj4+Pj4gKyByZXQgPSBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX21h
cF9jcHUocHIpOw0KPj4+PiBpZiAocmV0KQ0KPj4+PiBnb3RvIG91dDsNCj4+Pj4gDQo+Pj4+IHJl
dCA9IGFyY2hfcmVnaXN0ZXJfY3B1KHByLT5pZCk7DQo+Pj4+IGlmIChyZXQpIHsNCj4+Pj4gLSBh
Y3BpX3VubWFwX2NwdShwci0+aWQpOw0KPj4+PiArIGFjcGlfcHJvY2Vzc29yX2hvdHBsdWdfdW5t
YXBfY3B1KHByKTsNCj4+Pj4gZ290byBvdXQ7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4gDQo+PiANCj4g
DQoNCg==

