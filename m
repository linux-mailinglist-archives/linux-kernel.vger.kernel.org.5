Return-Path: <linux-kernel+bounces-105464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9397C87DE3E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB67B213A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAA1CAB9;
	Sun, 17 Mar 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="NBJ0w3Fe"
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3D1CAA7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710691435; cv=fail; b=SueL0kly1ZyDZEkEcnlzTcqp1Oz47xm78QkDUf4zbooODMFRYSGp2pbkS2lUn7OUQjzfIoNV/Ww8eDMWpFPPzwLJEGC9oxgdDpkWpirrI+SrfvoUEv+QC7bfQUzasc4zVTZB01u3TBKgkqSyPDZmFMi+jAHEGJUVUnD+SlN7JH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710691435; c=relaxed/simple;
	bh=smMv8DutK5AvTFrpMG2RuL8Lil3iKk+bApA6CRuQv20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVf7UfRt6f4UlfY4z056lnH3tibtgvxcNoj24OMtK2Duble8P8YxsveC0R1MuUI9nCE8r+DI/Etc7y2mVzpm+Fh/M/UxJTfFPQma8ecj8sn+X9Q5McwFp+dHl9515el2mHu3ucO17KhFBeUG7PhfAmDE3eItxa9ywj1rWs++ZEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=NBJ0w3Fe; arc=fail smtp.client-ip=148.163.133.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
	by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42H3sfal022515;
	Sun, 17 Mar 2024 16:03:47 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
	by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ww4t2subd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 16:03:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8dwVar/nWMLx7IhvEbFjCFDxokiSdxNoJF8aSKfVNRQlHPQgIfnQEnyFfD/f+xr01PfX3vUjxTnC3aPHvaJyZ+ayk791MM3z76KRlSiHH1VBXe3TWdMIekz2mTdmCBUsldPGdTfbQ82ZW+ahWjowoVp1yrZweuIlJ6iDy47bl1sVKdsYqnCtcvfq62J29/Iqhbj/RCuB0qev4eogkRLi0rVhWmmZrmbcsgJUQ0/OByAgZWTG7Xly1Xwn8+CFVKy4pNdBDx/TprJsxy0XuAB5B0E4Of8TE6PhzmFt6DEkJP1KBGFERaCWUXGJ0i7yQE2eCScd/ZYjD1rlqCklDORsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smMv8DutK5AvTFrpMG2RuL8Lil3iKk+bApA6CRuQv20=;
 b=kv+ZXmreuMg0JeyDu7u5Rj9+vmMzh/I8EsSywDAlr1/W/s6nwNkLSgDUCVPYgEhg2g/ljbrAIozHqMh7KiOS47lLypvooLdDW1d2aTAtp2w/KOVwvoydnellt3IiLsNCaRn88um61gjgrjdsR4ds00nPQcEiL96PRWes+/5NXfuGhD2tK6Z8a43oyXFskEFriaTYRN8AqyBGH/jY7kolziWoUqSsMGV0q/Mfj9aGmt4McaBdVtqF/JJBtI1broMj4Z0X++/BPgObvRJXCLVnjkskf4uOSrcxbX5FoBmg+sJNet8aK/BoFJrNyGqIZljdl/6PEJpRfT+KVXsPutKkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smMv8DutK5AvTFrpMG2RuL8Lil3iKk+bApA6CRuQv20=;
 b=NBJ0w3FeZxpQIKUIUqCShER8rAqdGtkO3C8mGALTTBLxjkMNjVPM1vJHY6ERMhyF8WtQRhaCJ3OBJIvxrIFaw/PLM6X4LBCodZVNez9cB18A2vNuWf5fcq2gn/ESEHhNbbPwXN4ajR/tvAFx5i9C6qn2sgzis83X2wMIBwb7OJ1ExiwWhWX6RRVXU76d88j28aA0t2FhA9C6eF5F9pTHPktZSkXB6HtlQUO6KMJXIoXiPgEFwb/IUWxhGU/ZnCewCAG5P8so2akzR7iXvWO49361YHDwBpoHpuXg4Bv4Rf6nuHHJzQE9D30FVkc5cf9bBYnJzpBlC2GAOmRwyk864Q==
Received: from VE1PR03MB6109.eurprd03.prod.outlook.com (2603:10a6:803:10c::19)
 by AS8PR03MB8102.eurprd03.prod.outlook.com (2603:10a6:20b:445::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Sun, 17 Mar
 2024 16:03:43 +0000
Received: from VE1PR03MB6109.eurprd03.prod.outlook.com
 ([fe80::69af:b5f1:b3b0:4061]) by VE1PR03MB6109.eurprd03.prod.outlook.com
 ([fe80::69af:b5f1:b3b0:4061%7]) with mapi id 15.20.7386.023; Sun, 17 Mar 2024
 16:03:42 +0000
From: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To: Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen/events: increment refcnt only if event channel is
 refcounted
Thread-Topic: [PATCH 2/2] xen/events: increment refcnt only if event channel
 is refcounted
Thread-Index: AQHadRYYap97PRUEWUyJa/zlA+m6fbE8Hy2A
Date: Sun, 17 Mar 2024 16:03:41 +0000
Message-ID: <3dc20f60-9811-45c0-a6bf-773db35db78a@epam.com>
References: <20240313071409.25913-1-jgross@suse.com>
 <20240313071409.25913-3-jgross@suse.com>
In-Reply-To: <20240313071409.25913-3-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR03MB6109:EE_|AS8PR03MB8102:EE_
x-ms-office365-filtering-correlation-id: fb571332-8c90-4569-4314-08dc469bd109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +TeNImJmWkBgSq0nGdvdkKgT/pk7s07bokTi91SxSsfQc6rn4hPXL8vIzvb/WJtpoJUtoK5/8vgd/mwuwyMbDdrZGx7egSRiQQmM/p+DJIUFWSerF89AMgKaDxPEHs/E2kSaJE+9zjyTq5Jp8Ngr9pKeKfgkbxMs0pwvwgvEw7LLfQJW1QxOWP75fLp++FHpmqDVWJzbMY9hy4wxGBKZfZhT+aKuLUmZ7CxhQVYOSZDyb38AUqJnDD0pPZEAbmJF7M7oG3dMPNd72mh1WY2JO9d8Jd5GWHOVU3GHRRh3hD3rtq5D5ujjv4pUnDGZCAY8wn8sK/dcKYYVaB+CG7Q4OayyJY3D71g6S7oB09IHFz1VUThBzsyC4X9q73GqmqZHlrRdO7dXyNqO3OGpmFotIXnjgqj3WoGl6sVBkMQpe3v9Er+i7uowKSeCcsUKUVBw9rl+wCRr+rghGDovERegucXd3VFBacyEFLFCZ1wCayamI/rJDpfyWKfDaAqjMMlIAWwpp+YsJSEYjN1RW4gTiGg1hZduzUMiXFU30cwfp6jE37+TB+KDL52iES2wQqB/L33vOSn7xXct48C3WWV3NQcl2zgMpq+knD3eQ0AzOJuf/JyhHDvjakOjk6PyR9fC18+D1TqgH9duBmH7jtfHUcIycPP5jv2fAgIg46nuQrKa8UWqcpJJ8ng1GTRhRy9LJEuABwlHaWf/DLzHMxxPzg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR03MB6109.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aUFYUUwrdEZLR3NjbXdicmdYSElILzUzU1pFS2hacDdOTWQvVlRpRlk5OGJk?=
 =?utf-8?B?T1pqTWhKd2JRcnlCbmlBemdvNjNKVFZWd2pSTjhnSENrQ21HNGtEdTBKNzQw?=
 =?utf-8?B?ZnZsYkZxWmQ2RW9rSmthK3Y0R3dWeWpFU0lmMElFUnhQYzVKN3B4TEZvU1lm?=
 =?utf-8?B?TXpIT043VlZ1T2tzeG9rR1BvNTdMZndIWG1RZTYwa2Y2UHVwUURNYlp4bkdC?=
 =?utf-8?B?cjVkdlJEQUZ4eGZjeTdnNVpCengzNmFkVWpTK0tOQm9LUGxkL0d2a3ZmR1FU?=
 =?utf-8?B?SG1PVkpHVkFvemZQYkljeDBkNmFNaXNIbDVySkN6VTJ4aFRlNjZXcXJpUTZP?=
 =?utf-8?B?T1pERnpUWHZUSytNUEpaSFV5RG1SQUZIWGhpV014bUg5dnRVR01LU2NkZndn?=
 =?utf-8?B?MGlOc2oxZ1NlWVdtOFIrWjRBczhHSnl2U0dQNnNqaG5BaWpnMWhJaXFWTVdV?=
 =?utf-8?B?TXdodVQvaGsrOWNTK0pCb2VFOG1FUHRkTXlvS3ZKUy92aFNyR2NZYmhmWFBn?=
 =?utf-8?B?UUlMZ29HWmZsN2d3SWk3L0UyYmJuamZyNG84WUR6QzJlSkRLb3hDUFhZSTUx?=
 =?utf-8?B?UTdTOERKSzBMd2l0MDJXUWF5Y3I2U0pmL0lkaVRjd0dYVVBhRVJLdDY5Y3ZH?=
 =?utf-8?B?akIyalFzRE9hVGRuSExDVGVxaTN4Mkt0UVhCZ0R4TjVFd1VoLzA4OUt0anBs?=
 =?utf-8?B?WXpvYWc1dThFcHZ5RXJ1dlo2UjBLdnFacnBWNVdtS2RMYmNvYW5haXJ0RVZG?=
 =?utf-8?B?U0t0YU1CYjhxcFJQa3FQTE95ZjdmZDA3SFQ3OGFjVG5IclFJNmlEalJIem03?=
 =?utf-8?B?MlpyL3pScDBZMDQ4ZXlhUUQwQkU5VlhsVmZVTHozZllqdEJGUDJWeHpTZDNQ?=
 =?utf-8?B?VFVpSkVHQmpCNmtodk0zVWRJcEkzT3UrSkUySFBkNkM3TjVqcTlhZTVkT21P?=
 =?utf-8?B?MHZQQXNaa1dtOGQ4L1ByZ2tpMGY3VEVrTitVT2s1cjAwbEtVbUF6VE5zRFRr?=
 =?utf-8?B?OThJVWUxY3BsSDYvMmFEUVZBS1IvR2NmTi9VdUVicjN2SityTGNGYjhGaUUy?=
 =?utf-8?B?b1ZBQkZwN1ByQ3lndVN4REZjcHpHeXdXd3E2d0RuOWN6RGE1cmpmVzgxamdt?=
 =?utf-8?B?RnBUQUhwb3JpQW81R1VhTGd6Yzh0dWt5NmhuSTFuQytEdTdsN1Y5dDhhZ2x4?=
 =?utf-8?B?SHZlckJmeEdjdWI1Q2IybHVkTGx4TmFYK1c0RjZVTWltZHZVUUNxMXM5MFlS?=
 =?utf-8?B?U1JFK3U3dm5jcUxMVC9jelc5TlB4bStZamltVzk1N04xb05PeU9YSGNxV3Q5?=
 =?utf-8?B?WEpTTCtMVTA1SG0yc1JCSXVXZnVlU1g0ZjlyWW1iTnIyVFdQNWdUTlhiWkgw?=
 =?utf-8?B?TWdMOGI1a29wc0VKUW1GdlJsbjgreEFvbFc4VitVeWVBdVhqakcwczRNV3RV?=
 =?utf-8?B?QzBZb3ZjUzVHalRlQ1RGWHBuM3RCcWhLWmcwb2JZUDdtcUk3YUs5TG9QRFk4?=
 =?utf-8?B?T0M0QW9qZlk1NFBBTkw0a1lDd2JGWHkxdCtYalVkN0xRRlNrMVQ0Ni9xdEl4?=
 =?utf-8?B?TzQ4MDlDdmNwU3dodEhmME9zQ1RjeXZLZ21aREt2RkQ3QzFKUkU3cElXenZC?=
 =?utf-8?B?VmJMK0dpWDdtV3F3VXhQQVFZR09vc09EZmRiRjJzZ29TYjkzNmVSZENFd2pP?=
 =?utf-8?B?bjJoR1FuSnJpa1NkUllBdVIwcTFSL2c3OXVMSkhIbzJNZlE2bGxhWklXK2hq?=
 =?utf-8?B?b3ZiTUgzanZnSHVTbWhDVCtIbTJvbE1lRUdUTy8xQ0krVmZUVWk0QVp4Zjhk?=
 =?utf-8?B?TGNYZUVQeFg3U09KQ2hyTjdmQVpMTVIrcG91RFgzWXJ5T1d2N1pXcGFGTm4w?=
 =?utf-8?B?clFmWUtpM3NRdTlsR1dCRmErTmxjeXYyY3VxaFNZTnVUQ2dTQVVNR3U2UlQ3?=
 =?utf-8?B?T3BXek5uemlqL0F3Q0I4eVlmVHpyV3hZVjhhL0FiT1lKNnBLdFZaK2VDWHda?=
 =?utf-8?B?UzZ5OUw4cDltY3lyQStDTlhhUWlIYmo5cnFOSWJjejMvbDA0MVJFcUIyaWRJ?=
 =?utf-8?B?VGl6WkNZQ0NkMVFjWDZ6Ynp1NFlYSy9vZ1k1M3ZaN0syZ0NhdEt1dnVoQXJt?=
 =?utf-8?B?ZnJrMVFId202b2Zmc2lGYU5ucHJTYjNyWWhJVVZKUk41T3Nrd3ZjWTdUYzJY?=
 =?utf-8?Q?Ro4ceJmSewZJbd8INHJScH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AFDFDE8DCEB4748B771174C9B3EA771@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB6109.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb571332-8c90-4569-4314-08dc469bd109
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2024 16:03:42.0155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgrSXjPkd0ArlgQ1W3rrKOtwy5mCYd8FJfyfkBsqJ9BJf00peoGviPMUQyVQTFlJk42EByP3wYepAdnmoxEF8LyyQPzX7XTpaf+yZI1zG6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8102
X-Proofpoint-GUID: f7v-kkxU4dZ2RO4GzrCRz7-twCksFguS
X-Proofpoint-ORIG-GUID: f7v-kkxU4dZ2RO4GzrCRz7-twCksFguS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_11,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403170125

DQoNCk9uIDEzLjAzLjI0IDA5OjE0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBJbiBiaW5kX2V2dGNobl90b19pcnFfY2hpcCgpIGRvbid0IGluY3JlbWVudCB0
aGUgcmVmY250IG9mIHRoZSBldmVudA0KPiBjaGFubmVsIGJsaW5kbHkuIEluIGNhc2UgdGhlIGV2
ZW50IGNoYW5uZWwgaXMgTk9UIHJlZmNvdW50ZWQsIGlzc3VlIGENCj4gd2FybmluZyBpbnN0ZWFk
Lg0KPiANCj4gQWRkIGFuIGFkZGl0aW9uYWwgc2FmZXR5IG5ldCBieSBkb2luZyB0aGUgcmVmY250
IGluY3JlbWVudCBvbmx5IGlmIHRoZQ0KPiBjYWxsZXIgaGFzIHNwZWNpZmllZCBJUlFGX1NIQVJF
RCBpbiB0aGUgaXJxZmxhZ3MgcGFyYW1ldGVyLg0KPiANCj4gRml4ZXM6IDllOTBlNThjMTFiNyAo
InhlbjogZXZ0Y2huOiBBbGxvdyBzaGFyZWQgcmVnaXN0cmF0aW9uIG9mIElSUSBoYW5kZXJzIikN
Cj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNClJl
dmlld2VkLWJ5OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBh
bS5jb20+DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyB8
IDIyICsrKysrKysrKysrKystLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+
IGluZGV4IDJmYWE0YmY3OGM3YS4uODFlZmZiZDUzZGM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZl
bnRzX2Jhc2UuYw0KPiBAQCAtMTE5MCw3ICsxMTkwLDcgQEAgaW50IHhlbl9waXJxX2Zyb21faXJx
KHVuc2lnbmVkIGlycSkNCj4gICBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5fcGlycV9mcm9tX2lycSk7
DQo+ICAgDQo+ICAgc3RhdGljIGludCBiaW5kX2V2dGNobl90b19pcnFfY2hpcChldnRjaG5fcG9y
dF90IGV2dGNobiwgc3RydWN0IGlycV9jaGlwICpjaGlwLA0KPiAtCQkJCSAgIHN0cnVjdCB4ZW5i
dXNfZGV2aWNlICpkZXYpDQo+ICsJCQkJICAgc3RydWN0IHhlbmJ1c19kZXZpY2UgKmRldiwgYm9v
bCBzaGFyZWQpDQo+ICAgew0KPiAgIAlpbnQgcmV0ID0gLUVOT01FTTsNCj4gICAJc3RydWN0IGly
cV9pbmZvICppbmZvOw0KPiBAQCAtMTIyNCw3ICsxMjI0LDggQEAgc3RhdGljIGludCBiaW5kX2V2
dGNobl90b19pcnFfY2hpcChldnRjaG5fcG9ydF90IGV2dGNobiwgc3RydWN0IGlycV9jaGlwICpj
aGlwLA0KPiAgIAkJICovDQo+ICAgCQliaW5kX2V2dGNobl90b19jcHUoaW5mbywgMCwgZmFsc2Up
Ow0KPiAgIAl9IGVsc2UgaWYgKCFXQVJOX09OKGluZm8tPnR5cGUgIT0gSVJRVF9FVlRDSE4pKSB7
DQo+IC0JCWluZm8tPnJlZmNudCsrOw0KPiArCQlpZiAoc2hhcmVkICYmICFXQVJOX09OKGluZm8t
PnJlZmNudCA8IDApKQ0KPiArCQkJaW5mby0+cmVmY250Kys7DQo+ICAgCX0NCj4gICANCj4gICAJ
cmV0ID0gaW5mby0+aXJxOw0KPiBAQCAtMTIzNywxMyArMTIzOCwxMyBAQCBzdGF0aWMgaW50IGJp
bmRfZXZ0Y2huX3RvX2lycV9jaGlwKGV2dGNobl9wb3J0X3QgZXZ0Y2huLCBzdHJ1Y3QgaXJxX2No
aXAgKmNoaXAsDQo+ICAgDQo+ICAgaW50IGJpbmRfZXZ0Y2huX3RvX2lycShldnRjaG5fcG9ydF90
IGV2dGNobikNCj4gICB7DQo+IC0JcmV0dXJuIGJpbmRfZXZ0Y2huX3RvX2lycV9jaGlwKGV2dGNo
biwgJnhlbl9keW5hbWljX2NoaXAsIE5VTEwpOw0KPiArCXJldHVybiBiaW5kX2V2dGNobl90b19p
cnFfY2hpcChldnRjaG4sICZ4ZW5fZHluYW1pY19jaGlwLCBOVUxMLCBmYWxzZSk7DQo+ICAgfQ0K
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKGJpbmRfZXZ0Y2huX3RvX2lycSk7DQo+ICAgDQo+ICAgaW50
IGJpbmRfZXZ0Y2huX3RvX2lycV9sYXRlZW9pKGV2dGNobl9wb3J0X3QgZXZ0Y2huKQ0KPiAgIHsN
Cj4gLQlyZXR1cm4gYmluZF9ldnRjaG5fdG9faXJxX2NoaXAoZXZ0Y2huLCAmeGVuX2xhdGVlb2lf
Y2hpcCwgTlVMTCk7DQo+ICsJcmV0dXJuIGJpbmRfZXZ0Y2huX3RvX2lycV9jaGlwKGV2dGNobiwg
Jnhlbl9sYXRlZW9pX2NoaXAsIE5VTEwsIGZhbHNlKTsNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJP
TF9HUEwoYmluZF9ldnRjaG5fdG9faXJxX2xhdGVlb2kpOw0KPiAgIA0KPiBAQCAtMTI5NSw3ICsx
Mjk2LDggQEAgc3RhdGljIGludCBiaW5kX2lwaV90b19pcnEodW5zaWduZWQgaW50IGlwaSwgdW5z
aWduZWQgaW50IGNwdSkNCj4gICANCj4gICBzdGF0aWMgaW50IGJpbmRfaW50ZXJkb21haW5fZXZ0
Y2huX3RvX2lycV9jaGlwKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsDQo+ICAgCQkJCQkgICAg
ICAgZXZ0Y2huX3BvcnRfdCByZW1vdGVfcG9ydCwNCj4gLQkJCQkJICAgICAgIHN0cnVjdCBpcnFf
Y2hpcCAqY2hpcCkNCj4gKwkJCQkJICAgICAgIHN0cnVjdCBpcnFfY2hpcCAqY2hpcCwNCj4gKwkJ
CQkJICAgICAgIGJvb2wgc2hhcmVkKQ0KPiAgIHsNCj4gICAJc3RydWN0IGV2dGNobl9iaW5kX2lu
dGVyZG9tYWluIGJpbmRfaW50ZXJkb21haW47DQo+ICAgCWludCBlcnI7DQo+IEBAIC0xMzA3LDE0
ICsxMzA5LDE0IEBAIHN0YXRpYyBpbnQgYmluZF9pbnRlcmRvbWFpbl9ldnRjaG5fdG9faXJxX2No
aXAoc3RydWN0IHhlbmJ1c19kZXZpY2UgKmRldiwNCj4gICAJCQkJCSAgJmJpbmRfaW50ZXJkb21h
aW4pOw0KPiAgIA0KPiAgIAlyZXR1cm4gZXJyID8gOiBiaW5kX2V2dGNobl90b19pcnFfY2hpcChi
aW5kX2ludGVyZG9tYWluLmxvY2FsX3BvcnQsDQo+IC0JCQkJCSAgICAgICBjaGlwLCBkZXYpOw0K
PiArCQkJCQkgICAgICAgY2hpcCwgZGV2LCBzaGFyZWQpOw0KPiAgIH0NCj4gICANCj4gICBpbnQg
YmluZF9pbnRlcmRvbWFpbl9ldnRjaG5fdG9faXJxX2xhdGVlb2koc3RydWN0IHhlbmJ1c19kZXZp
Y2UgKmRldiwNCj4gICAJCQkJCSAgIGV2dGNobl9wb3J0X3QgcmVtb3RlX3BvcnQpDQo+ICAgew0K
PiAgIAlyZXR1cm4gYmluZF9pbnRlcmRvbWFpbl9ldnRjaG5fdG9faXJxX2NoaXAoZGV2LCByZW1v
dGVfcG9ydCwNCj4gLQkJCQkJCSAgICZ4ZW5fbGF0ZWVvaV9jaGlwKTsNCj4gKwkJCQkJCSAgICZ4
ZW5fbGF0ZWVvaV9jaGlwLCBmYWxzZSk7DQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKGJp
bmRfaW50ZXJkb21haW5fZXZ0Y2huX3RvX2lycV9sYXRlZW9pKTsNCj4gICANCj4gQEAgLTE0MzAs
NyArMTQzMiw4IEBAIHN0YXRpYyBpbnQgYmluZF9ldnRjaG5fdG9faXJxaGFuZGxlcl9jaGlwKGV2
dGNobl9wb3J0X3QgZXZ0Y2huLA0KPiAgIHsNCj4gICAJaW50IGlycSwgcmV0dmFsOw0KPiAgIA0K
PiAtCWlycSA9IGJpbmRfZXZ0Y2huX3RvX2lycV9jaGlwKGV2dGNobiwgY2hpcCwgTlVMTCk7DQo+
ICsJaXJxID0gYmluZF9ldnRjaG5fdG9faXJxX2NoaXAoZXZ0Y2huLCBjaGlwLCBOVUxMLA0KPiAr
CQkJCSAgICAgIGlycWZsYWdzICYgSVJRRl9TSEFSRUQpOw0KPiAgIAlpZiAoaXJxIDwgMCkNCj4g
ICAJCXJldHVybiBpcnE7DQo+ICAgCXJldHZhbCA9IHJlcXVlc3RfaXJxKGlycSwgaGFuZGxlciwg
aXJxZmxhZ3MsIGRldm5hbWUsIGRldl9pZCk7DQo+IEBAIC0xNDcxLDcgKzE0NzQsOCBAQCBzdGF0
aWMgaW50IGJpbmRfaW50ZXJkb21haW5fZXZ0Y2huX3RvX2lycWhhbmRsZXJfY2hpcCgNCj4gICB7
DQo+ICAgCWludCBpcnEsIHJldHZhbDsNCj4gICANCj4gLQlpcnEgPSBiaW5kX2ludGVyZG9tYWlu
X2V2dGNobl90b19pcnFfY2hpcChkZXYsIHJlbW90ZV9wb3J0LCBjaGlwKTsNCj4gKwlpcnEgPSBi
aW5kX2ludGVyZG9tYWluX2V2dGNobl90b19pcnFfY2hpcChkZXYsIHJlbW90ZV9wb3J0LCBjaGlw
LA0KPiArCQkJCQkJICBpcnFmbGFncyAmIElSUUZfU0hBUkVEKTsNCj4gICAJaWYgKGlycSA8IDAp
DQo+ICAgCQlyZXR1cm4gaXJxOw0KPiAgIA==

