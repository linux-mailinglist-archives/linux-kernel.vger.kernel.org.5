Return-Path: <linux-kernel+bounces-156130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6978AFE47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5347F1C21FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C214A84;
	Wed, 24 Apr 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="B64Kzayn"
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020003.outbound.protection.outlook.com [52.101.156.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D9613D;
	Wed, 24 Apr 2024 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925161; cv=fail; b=cuBAoU3sWxzGacmSrzkrf7yxZWso+PMYOfOocvbGCkMQGD4V5ZCGjHGCY16/Jvz5Es3LXvUl/UwhbC+DrNxOScDHRsqQ7dwB8jBW383zO98PLtnLHzS4vIdspxsWLEJoi4MvlGc0Pyh3JYijb1lW9h3eMJJKT/DFlEQ4U4QDb2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925161; c=relaxed/simple;
	bh=jzsDffP29rXU4/63YBr3i9f9AB6LDpRom5wtO75qf3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/K7eOpCsnxhRoYKGtr/np0cP2jXaDrvP0c7OaIUO5xRqrvIfx5/53R+/E/REsGYK7tfS69LTJXc5XTsOO+H4/8TNEMasWFdKBSZRFc/J9UTXhTvoBKNPoI7q2/lBf6Lz7N9RlVfH1RWBd8moqtdISYIzrPph0K8RQC1i5l0oc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=B64Kzayn; arc=fail smtp.client-ip=52.101.156.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKGfrBLwe7BPG4tjyT0+OImOvkp5qX21iU9z/6NLsE1NO+/zeUlYTXhJ1hdlj+UmHS5OImkmZqQvvF4vkNFdygLi2cyegw3GmI9FSEeta2FVAmAz5R8TQzRWFzf8UyGBI1Jtrk3iA7aoK29i1+VpmpckPAwA1V2lcraRZfC1sqBFUf2JH4TlnOTRDJO+ptbGd74yZx+G1dQm/IKQlkZu3QjbzU2cklYyWHZXb4UgIoKRTPb/fNpE14nDlcpx2aOOZzOM30MChivqYND9n/eRwadRRLLfM1Byg2eeIFITwEUDPAXugmTRv+FhyMuuFh62Unhcuh0pvh9sSnbSUsj1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzsDffP29rXU4/63YBr3i9f9AB6LDpRom5wtO75qf3E=;
 b=Kb52xzkqH7meL1PuHNbyM54TPIEmWNyz0lZTxEJEl4R066k+szyd6A9SAEOR50S2UYnXn0wVg+UH8DHCA1dB6ebvkQVXG8HlSF0KLKutsbbJtz+k3AmGgN7bGsr3c7OPpV1LLNmuw1x/TvoagC/M/DaoH21CCFUrJbTDnb0OBVejovu6rMNZQOXjEdg2xSz4ggeH92Ms6Z43BA44v0gEyJ434UeZm3NJkduIU+AFyluL1Rm/izeursk22A3uOZLH541ZbrPJbV5sZtkOm9q1jpWZ1ebefiewSUPFX1UzGRtcpB3dIIGyQxuALmgVJ3gR1tjDkOAA84eh3JW3gqrs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzsDffP29rXU4/63YBr3i9f9AB6LDpRom5wtO75qf3E=;
 b=B64Kzaynvy+bwaId2JzokM/qHch/YaaBwDJWop60e6hcXKTUsRPWZNRikMs/eIl71w0kNzSStD6QL/MurBvLM4In5NnQ9FUbkTVdkHgv8vfOfmY9l4lFBJqTVlbWiQd7/kp/d33lDHzJFL39+nQtWeaXCuckrJ3raajQ6Rtgc+s=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SL2P216MB1839.KORP216.PROD.OUTLOOK.COM (2603:1096:101:100::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Wed, 24 Apr 2024 02:19:15 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 02:19:15 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422
 raw pixel-formats on the encoder.
Thread-Topic: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422
 raw pixel-formats on the encoder.
Thread-Index: AQHac6LGh5SBSdVHAEC+vu7H2SqqlLFuwRcAgAUx54CAAL72gIACP+tw
Date: Wed, 24 Apr 2024 02:19:15 +0000
Message-ID:
 <SE1P216MB1303CCB7277554E24FB378D2ED102@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-5-jackson.lee@chipsnmedia.com>
	 <3ba3445e820e14730794e85fb4322e5aa57e1119.camel@ndufresne.ca>
	 <SE1P216MB1303F475980132394E5E79DAED122@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
 <3cc5a7dbd5c0f03d6137e0795fae69f5533a8f9f.camel@ndufresne.ca>
In-Reply-To: <3cc5a7dbd5c0f03d6137e0795fae69f5533a8f9f.camel@ndufresne.ca>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SL2P216MB1839:EE_
x-ms-office365-filtering-correlation-id: 10a76cd6-6c50-48e4-5388-08dc6404f086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3g1cWhRU0w0aHorbjA0ejNFcTVLaWV3VmdGUXFJNzBKR0pyQ2wvdDZDTUI0?=
 =?utf-8?B?b0RUZldjYWlLZzhNcE9YM0hpcnpscnd4YWFOVjBmT1lKdnpya21LMXBvdG1u?=
 =?utf-8?B?V2JWTUZzNzNoZ0NTY2NwbkJ5THVkTHlBR0hWRHkrNlh0OURJQXdTbHlIRml1?=
 =?utf-8?B?RjhZSXJVQUIza21LVEk4N0c0alEzeUJJbW13di9EdnFUWHArMTE3WDVjSGdi?=
 =?utf-8?B?Y2ZtQmM5QnZRYmU1blZjeEtYTjJWVjlYWDVDQVd2UW9JemdrMnlzMDdqcExJ?=
 =?utf-8?B?blpSYS95NGNWMnV6eTZFbjNnRis3MjUvckY2b3FwY2RuZ2Y2bDN4ZDRlRVpk?=
 =?utf-8?B?MHZvSWw2TmwydU42bVA0Vi8yWUVDNWFVcjBVZG4ya3NyYWpKVy9tb1d5UUUx?=
 =?utf-8?B?elNxUVhtMGdzUWJrWlo4RTBBL3BaN1VIa0dzckoydEdUSDNnZzJGa2NLUFVm?=
 =?utf-8?B?bmU2bUhwQThIZ3RabXFONkNucElmVjd6cEl4bFZEZzhWaHBmTzNiNlNOK2tT?=
 =?utf-8?B?YjBENGN3V2pvd0hWVnA2TVQxWlg5aHBrWnkyOW9pSHBhZlBjQ01jWHFKLzlO?=
 =?utf-8?B?VHJNL2M4UGNPbnFKbWdEZ0E3c3N6ZStxR00zKzI1VldNK010MEQ5dUU5WDRI?=
 =?utf-8?B?ajMwcGNEd1E2Y2dUYWlGUDVubGVyaisrMnMzbGJneHRpK2JSRFFYRGVKR25C?=
 =?utf-8?B?WGJ3cit1djIwbE1jTmEyYjdnZU92T3RZa214MHZia21hdnFRTlpzZHV1UjJy?=
 =?utf-8?B?WVZJbjAycDh3TjcxNm5DY2JYSm4rT3I5YitFM3B3V1krMEZTMGsvOEdhbTJK?=
 =?utf-8?B?d2MvOENRb3F5WVpma1ozTDgzcURMNXhxUThhT3hOWFFDdUplR1p2d0JMdEY0?=
 =?utf-8?B?YUw4QzBVNlEvN0lJZDBOMDJ2SUo1c0RLYzJqWUFseFJaZ0ljd2pkU1JrN1Fz?=
 =?utf-8?B?R1lRRkNCU1ZYY0x2Y3AzbUs5MiszK1dEMFFZK2pDMU1XV0xQSTVGK3Q0Q2Nk?=
 =?utf-8?B?YVhENmtuUWtCRStkQUdoZCttNnA5UFQ3UGhvay9MWURyZDl0Z2xIWlV3akt2?=
 =?utf-8?B?NFQ2encxV0VkZ3NOYnRRWWhmNHhqT3IyNUFQUG1CSXFMUU5wOEpqZmdpN3Fk?=
 =?utf-8?B?VU9jSHRhS0wrSVVOT3p3Rm00dE5oOXg1V1dhSFljTUNvL3E0a1lVWUtoNVpK?=
 =?utf-8?B?WWlhTGVOWFovNDc4enl4cXRoQWZYZW1sRGxGbnlRd29hL29iU1JrYkxuNlk1?=
 =?utf-8?B?NkFhdmVMN0QxUHBhbTdOZkdpbjdIYndYeEw2TjFlNG4wcjNrdnZ2WWFESnNX?=
 =?utf-8?B?dzJMdmt1OU9OYnB0eTA3NzJUZFNxWllKRythNkpsMGlVNnROWnJ3bXFUWEdF?=
 =?utf-8?B?U1FqV3ZSeE8ra3ppOFlnNXFlNGVTdkVaMklXYTJBem5BNGErR3pjMDJmeEVn?=
 =?utf-8?B?Z0NHQ0ZVeUplemFVeVJvRGUrZ3FHYTh5TlVzeFBQbkllK1NyZktrQVFvYnNZ?=
 =?utf-8?B?V1FSUUppOUNtK2lTU2pIdEV4dEpya2UvU0ZkZnczNmtJaEd6eVlmOTFBa2po?=
 =?utf-8?B?ekFqOEdDWCtUL2hBSHNmcmNVUXdINjc5RVFQVkgzMEZOSWNFVm9vajBGd1Ry?=
 =?utf-8?B?NmZaQWZTWUNuU0p3RkpwZFk3Sm5McW9xcVZUMndFVG1wblh1UU1xNEhrcWkv?=
 =?utf-8?B?QXhtZlp6ak54UzkwZlpOOVVkZld0YnpuMExwdkkzek9aRE1ENDBIZkdCdy9m?=
 =?utf-8?B?aEV3YVAzbzFyS1dpTEQ4NlV5MTFkZUh0M0s3dmRxUzVkL1dmYWtKMTltWlFz?=
 =?utf-8?B?T3dMTDBCdG1zZjZYT05kQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVlHOHAvZ1RVWmwwRysxSGcyUVhDc0FwelR2S0NuSTBNVjBVSkcvYjNVd0k4?=
 =?utf-8?B?STYydjJUY1RwMXA3MExFZzhJWHFSOFJGT2ZnaDB3ZzF2aDcvR3lPbytNaUJU?=
 =?utf-8?B?aEVHUGN5KzhZUzFVVGlPU0c1OVhOa0FMT2lsUkhXZWFIelEwSURHc3lzQ0VO?=
 =?utf-8?B?TG40UUtBa2ZSbjJBVjhKeWRoWHU1MUpldHQ4RXpOY0V1NDZ4ZGE4bFRzWEVK?=
 =?utf-8?B?bTRQSGYvVzN5RU1VbTRzYWplWDIvZ2VSWmZuOWRjVzhuK3FoVWVYMCsxdHdT?=
 =?utf-8?B?K1VleFpOYzVPUFZrNGd5b3p6VWt6a1JGMUpLUFgyazF0b3NpVnhOTWhmUWVj?=
 =?utf-8?B?RDBJM1FwM0N6UVphdVhsaDN5ditKUzIrMTdrcmIxbmlZWGh2SUJ2aHJ2Vlg5?=
 =?utf-8?B?NmtjT2FxZ0lFa01wbEdUaENBS0lWT0FuL3RlVHpnZk1UdExQcnJNVURpU1BT?=
 =?utf-8?B?K01keGYydXViVGlVYlFVYjR0cm1mYzhOd0k2ajNLQXhDM1oxejVFQldGSmF0?=
 =?utf-8?B?RnlWemtCditUVy96R2pNWDNpb1k3RHc3M1g3OENDRW1IV3hsRWNIRjRYbW83?=
 =?utf-8?B?ek5rK1FEZ1FJUzNtblUwd29jazdsNVZNQVhkQnd6VDFTc0NLWXR0TFNTNURQ?=
 =?utf-8?B?R3VLVldYaHQ1dGVnd25hZkRNbGZtYXlDdHBWV3hPOWZBcGhPQm5nOVlFL3Rv?=
 =?utf-8?B?SEYxS3I2cUxpT1ZFbmF6VFJwT3p3blV0NVY1NlZ2OTFMQXVmQUw3Wjk3bG9Z?=
 =?utf-8?B?bkhWWWNlMnVFdmd1L1E3bDJkdzkyMi9wNHR4MCtiNTBqSFpBbHk4VkJWOWNF?=
 =?utf-8?B?N3hPM0t0MlhNMkV3WUNMSXkvZE5YVFVRQmNYMWhKaXNiRUFZTXcvRy9iMWRw?=
 =?utf-8?B?WWsrZkVPdlRLVVczaHJZVEYzdDB1NlQvaFFrcXY4V3RwZGlKeENzeE4wMmVW?=
 =?utf-8?B?Yjl4U1g2T1FUU3lIOGwyd2FTZ3RlYjA3SUxZZHBBZXZ0ZGFPUzNpNDVXR0Qw?=
 =?utf-8?B?WmxBUUFDQTdXNWE4clhvS3Mza3lWbHhmMFZiZ1V6MnJpUDVRc3plbG00eFRI?=
 =?utf-8?B?dXN3OUJnRGloNzV6c1Bid1hBNW1wdjJhWlhEODg1OGRlR2tBaHZxMDdWZkZ1?=
 =?utf-8?B?U0VxajlScGNGVlh6SnF5a3pOQ3dzdHdMZEo2bytBbGVYaGFMZDB5R2N5emVT?=
 =?utf-8?B?eCtTaWhIR0Q5VmJpY0JjU0pacHN2TWVNTGNBMW9xbmtaRGFuNWw2WVVWU3hh?=
 =?utf-8?B?SXNrMS9nWDNLK01RTVpZVmxGMnFuM0J6SFlPN01jSUdJbGFLVTVlQ0kwUXBx?=
 =?utf-8?B?cjc4dndxc0VOcDJUVGV3NGx1RHlaaG13TlRPelN2Qk9uaUhhYklZb1VRUWtM?=
 =?utf-8?B?WlNxWnFyamF6akFONkNkaFV5eTBJb283YlkzK0tkY2RuaThmSk5RemZPcFFj?=
 =?utf-8?B?dUh1RFlqSU5pOWZVMHBBUmtOdmxlRVlDb2FLNktRV0hmMGZKK2hmejhpUFpD?=
 =?utf-8?B?UGc1MHlJbGdxSDlCQ3RJQmFLb0h5S0Z3QnQ1SnRXbHpUNXFWWXpacjNOYVds?=
 =?utf-8?B?azdNM1ZqL3BJKzhmOE53a2hRWVlrMGF4Nnh4aWJZTm1Bc2toNGJ4aEFZU1po?=
 =?utf-8?B?eWZWZ1VyN0dRdWorazcyWFFHeXFoWkk4M2pUUitRaldUNmZJdVhReXZlNjE5?=
 =?utf-8?B?VS9LUkRhREhabC9xRWMrclBzZDcwOXNFUXdsTG9WdWlReHNnRHQ2V1ZJbyti?=
 =?utf-8?B?OUpPcko4aTc2TnV2YzdpampYVTAxNWgrMkVQbnhMZGVsUWV5Ynhrd3dHWTNI?=
 =?utf-8?B?WVZlUE5rbGhId2N3dGtwRFU0YlpVeWZ4WmlOZnVMUXhZVlR6bWRMd3gzdnAw?=
 =?utf-8?B?R01QYlhRQ0dKV3B2MTcvNTlDV1ZOdzRrSGN3NW9va2FlVGVxQm4rbTZlYzND?=
 =?utf-8?B?Z05mMm8zYnNzallCSkxZKzhtT2VJcGdQd2VJR3dXWFl4ci84RThWRTFHSE1P?=
 =?utf-8?B?OTYxMUpQRmZIZHFjKzJPbnQvdjVvTmNDYnBvUjN2NldiLzVYSHVxeFcvNjhK?=
 =?utf-8?B?ZW12dEtqZ3JkV3VneVlHOWNzZlUzR2k1aXc5REdDYVNFWDc0dmJTVFpiM2Yx?=
 =?utf-8?B?aFZ1Q0U5K28vSzBSUUxyZnBuSHNJb3A2ODBYM1FBMjZ2czRCZVYzMGVscFk5?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a76cd6-6c50-48e4-5388-08dc6404f086
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 02:19:15.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88KrqwlY5348e4IOqzIePxYkGrx2uXv7y+L0El9QwXOl1mlGvOpcAYcPzrRr5CxaUMDOe/DQ1cpc9rhajTMhLrufk9SxHczvg+HKvNIMN5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1839

SGkgTmljb2xhcw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pY29s
YXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJp
bCAyMywgMjAyNCAxMjo0OSBBTQ0KPiBUbzogamFja3Nvbi5sZWUgPGphY2tzb24ubGVlQGNoaXBz
bm1lZGlhLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gc2ViYXN0aWFuLmZyaWNrZUBjb2xs
YWJvcmEuY29tDQo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGh2ZXJrdWlsQHhzNGFsbC5ubDsgTmFzIENodW5nIDxuYXMu
Y2h1bmdAY2hpcHNubWVkaWEuY29tPjsgbGFmbGV5LmtpbQ0KPiA8bGFmbGV5LmtpbUBjaGlwc25t
ZWRpYS5jb20+OyBiLWJybmljaEB0aS5jb20NCj4gU3ViamVjdDogUmU6IFtSRVNFTkQgUEFUQ0gg
djIgNC80XSBtZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBTdXBwb3J0IFlVVjQyMg0KPiByYXcg
cGl4ZWwtZm9ybWF0cyBvbiB0aGUgZW5jb2Rlci4NCj4gDQo+IEhpIEphY2tzb24sDQo+IA0KPiBM
ZSBsdW5kaSAyMiBhdnJpbCAyMDI0IMOgIDA0OjMwICswMDAwLCBqYWNrc29uLmxlZSBhIMOpY3Jp
dMKgOg0KPiA+IEhpIE5pY29sYXMNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVzbmUu
Y2E+DQo+ID4gPiBTZW50OiBGcmlkYXksIEFwcmlsIDE5LCAyMDI0IDY6MDYgQU0NCj4gPiA+IFRv
OiBqYWNrc29uLmxlZSA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPjsgbWNoZWhhYkBrZXJu
ZWwub3JnOw0KPiA+ID4gc2ViYXN0aWFuLmZyaWNrZUBjb2xsYWJvcmEuY29tDQo+ID4gPiBDYzog
bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+ID4gaHZlcmt1aWxAeHM0YWxsLm5sOyBOYXMgQ2h1bmcgPG5hcy5jaHVuZ0BjaGlwc25t
ZWRpYS5jb20+Ow0KPiA+ID4gbGFmbGV5LmtpbSA8bGFmbGV5LmtpbUBjaGlwc25tZWRpYS5jb20+
OyBiLWJybmljaEB0aS5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIFBBVENIIHYyIDQv
NF0gbWVkaWE6IGNoaXBzLW1lZGlhOiB3YXZlNToNCj4gPiA+IFN1cHBvcnQgWVVWNDIyIHJhdyBw
aXhlbC1mb3JtYXRzIG9uIHRoZSBlbmNvZGVyLg0KPiA+ID4NCj4gPiA+IExlIGx1bmRpIDExIG1h
cnMgMjAyNCDDoCAxOTo1NiArMDkwMCwgamFja3Nvbi5sZWUgYSDDqWNyaXTCoDoNCj4gPiA+ID4g
RnJvbTogIkphY2tzb24ubGVlIiA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPg0KPiA+ID4g
Pg0KPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIFlVVjQyMlAsIE5WMTYsIE5WNjEsIFlVVjQy
Mk0sIE5WMTZNLCBOVjYxTSByYXcNCj4gPiA+ID4gcGl4ZWwtDQo+ID4gPiBmb3JtYXRzIHRvIHRo
ZSBXYXZlNSBlbmNvZGVyLg0KPiA+ID4gPiBBbGwgdGhlc2UgZm9ybWF0cyBoYXZlIGEgY2hyb21h
IHN1YnNhbXBsaW5nIHJhdGlvIG9mIDQ6MjoyIGFuZA0KPiA+ID4gPiB0aGVyZWZvcmUNCj4gPiA+
IHJlcXVpcmUgYSBuZXcgaW1hZ2Ugc2l6ZSBjYWxjdWxhdGlvbiBhcyB0aGUgZHJpdmVyIHByZXZp
b3VzbHkgb25seQ0KPiA+ID4gaGFuZGxlZCBhIHJhdGlvIG9mIDQ6MjowLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYWNrc29uLmxlZSA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEu
Y29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOYXMgQ2h1bmcgPG5hcy5jaHVuZ0BjaGlwc25t
ZWRpYS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2NoaXBzLW1lZGlhL3dhdmU1L3dh
dmU1LXZwdS1lbmMuYyAgICAgICAgIHwgNTkgKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPiA+
DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2No
aXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LWVuYy5jDQo+ID4gPiA+IGluZGV4
IDVhMzJiYjEzODE1OC4uNzc2NTdmNjNhMTY5IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiA+ID4g
PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZw
dS1lbmMuYw0KPiA+ID4gPiBAQCAtMzksNiArMzksMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2
cHVfZm9ybWF0DQo+ID4gPiBlbmNfZm10X2xpc3RbRk1UX1RZUEVTXVtNQVhfRk1UU10gPSB7DQo+
ID4gPiA+ICAJCXsNCj4gPiA+ID4gIAkJCS52NGwyX3BpeF9mbXQgPSBWNEwyX1BJWF9GTVRfTlYy
MU0sDQo+ID4gPiA+ICAJCX0sDQo+ID4gPiA+ICsJCXsNCj4gPiA+ID4gKwkJCS52NGwyX3BpeF9m
bXQgPSBWNEwyX1BJWF9GTVRfWVVWNDIyUCwNCj4gPiA+ID4gKwkJfSwNCj4gPiA+ID4gKwkJew0K
PiA+ID4gPiArCQkJLnY0bDJfcGl4X2ZtdCA9IFY0TDJfUElYX0ZNVF9OVjE2LA0KPiA+ID4gPiAr
CQl9LA0KPiA+ID4gPiArCQl7DQo+ID4gPiA+ICsJCQkudjRsMl9waXhfZm10ID0gVjRMMl9QSVhf
Rk1UX05WNjEsDQo+ID4gPiA+ICsJCX0sDQo+ID4gPiA+ICsJCXsNCj4gPiA+ID4gKwkJCS52NGwy
X3BpeF9mbXQgPSBWNEwyX1BJWF9GTVRfWVVWNDIyTSwNCj4gPiA+ID4gKwkJfSwNCj4gPiA+ID4g
KwkJew0KPiA+ID4gPiArCQkJLnY0bDJfcGl4X2ZtdCA9IFY0TDJfUElYX0ZNVF9OVjE2TSwNCj4g
PiA+ID4gKwkJfSwNCj4gPiA+ID4gKwkJew0KPiA+ID4gPiArCQkJLnY0bDJfcGl4X2ZtdCA9IFY0
TDJfUElYX0ZNVF9OVjYxTSwNCj4gPiA+ID4gKwkJfSwNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICB9
Ow0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtMTAxLDEzICsxMTksMzAgQEAgc3RhdGljIGludCBzdGFy
dF9lbmNvZGUoc3RydWN0IHZwdV9pbnN0YW5jZQ0KPiA+ID4gPiAqaW5zdCwNCj4gPiA+IHUzMiAq
ZmFpbF9yZXMpDQo+ID4gPiA+ICAJc3RydWN0IHZiMl92NGwyX2J1ZmZlciAqZHN0X2J1ZjsNCj4g
PiA+ID4gIAlzdHJ1Y3QgZnJhbWVfYnVmZmVyIGZyYW1lX2J1ZjsNCj4gPiA+ID4gIAlzdHJ1Y3Qg
ZW5jX3BhcmFtIHBpY19wYXJhbTsNCj4gPiA+ID4gLQl1MzIgc3RyaWRlID0gQUxJR04oaW5zdC0+
ZHN0X2ZtdC53aWR0aCwgMzIpOw0KPiA+ID4gPiAtCXUzMiBsdW1hX3NpemUgPSAoc3RyaWRlICog
aW5zdC0+ZHN0X2ZtdC5oZWlnaHQpOw0KPiA+ID4gPiAtCXUzMiBjaHJvbWFfc2l6ZSA9ICgoc3Ry
aWRlIC8gMikgKiAoaW5zdC0+ZHN0X2ZtdC5oZWlnaHQgLyAyKSk7DQo+ID4gPiA+ICsJdTMyIHN0
cmlkZSA9IGluc3QtPnNyY19mbXQucGxhbmVfZm10WzBdLmJ5dGVzcGVybGluZTsNCj4gPiA+ID4g
Kwl1MzIgbHVtYV9zaXplID0gKHN0cmlkZSAqIGluc3QtPnNyY19mbXQuaGVpZ2h0KTsNCg0KSSBy
ZXZpZXdlZCB0aGUgYWJvdmUgY29kZSwgYWdhaW4uIFRoZSBjb2RlIHdvdWxkIGJlIHByb3Blci4N
CkJlY2F1c2UgaW4gY2FzZSBvZiBOVjEyIGNvbG9yIHNwYWNlLCBpdCBoYXMgb25lIHBsYW5hciwg
dGhlcmVmb3IgdGhlIFlVViB2YWx1ZSBpcyBpbiB0aGUgc2FtZSBsaW5lYXIgbWVtb3J5Lg0KVG8g
Y2FsY3VsYXRlIGx1bWFfc2l6ZSwgd2UgbmVlZCB0aGUgYWJvdmUgY29kZS4NCg0KDQo+ID4gPiA+
ICsJdTMyIGNocm9tYV9zaXplID0gMDsNCj4gPiA+DQo+ID4gPiBUaGUgaGVscGVyIGludHJvZHVj
ZWQgaW4gcHJldmlvdXMgcGF0Y2ggYWxzbyBjYWxjdWxhdGUgc2l6ZWltYWdlIGZvcg0KPiA+ID4g
ZWFjaCBwbGFuZXMsIHNvIG5vIG5lZWQgZm9yIHRoaXMgY29kZSBhbnltb3JlLg0KPiA+DQo+ID4g
WW91ciBjb21tZW50IG1lYW5zIHRoZSBiZWxvdyBjb2RlPw0KPiA+DQo+ID4gCXUzMiBsdW1hX3Np
emUgPSBpbnN0LT5zcmNfZm10LnBsYW5lX2ZtdFswXS5zaXplaW1hZ2UNCj4gPiAJdTMyIGNocm9t
YV9zaXplID0gaW5zdC0+c3JjX2ZtdC5wbGFuZV9mbXRbMV0uc2l6ZWltYWdlDQo+ID4NCj4gPg0K
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gIAltZW1zZXQoJnBpY19wYXJhbSwgMCwgc2l6ZW9mKHN0
cnVjdCBlbmNfcGFyYW0pKTsNCj4gPiA+ID4gIAltZW1zZXQoJmZyYW1lX2J1ZiwgMCwgc2l6ZW9m
KHN0cnVjdCBmcmFtZV9idWZmZXIpKTsNCj4gPiA+ID4NCj4gPg0KPiA+IFRoZSBiZWxvdyBjb2Rl
IGNvdWxkIGJlIHJlbW92ZWQuDQo+ID4NCj4gPiA+ID4gKwlpZiAoaW5zdC0+c3JjX2ZtdC5waXhl
bGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIwIHx8DQo+ID4gPiA+ICsJICAgIGluc3QtPnNy
Y19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX1lVVjQyME0pDQo+ID4gPiA+ICsJCWNo
cm9tYV9zaXplID0gbHVtYV9zaXplIC8gNDsNCj4gPiA+ID4gKwllbHNlIGlmIChpbnN0LT5zcmNf
Zm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjEyIHx8DQo+ID4gPiA+ICsJCSBpbnN0
LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjIxIHx8DQo+ID4gPiA+ICsJ
CSBpbnN0LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjEyTSB8fA0KPiA+
ID4gPiArCQkgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYyMU0p
DQo+ID4gPiA+ICsJCWNocm9tYV9zaXplID0gbHVtYV9zaXplIC8gMjsNCj4gPiA+ID4gKwllbHNl
IGlmIChpbnN0LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9ZVVY0MjJQIHx8
DQo+ID4gPiA+ICsJCSBpbnN0LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9Z
VVY0MjJNKQ0KPiA+ID4gPiArCQljaHJvbWFfc2l6ZSA9IGx1bWFfc2l6ZSAvIDI7DQo+ID4gPiA+
ICsJZWxzZSBpZiAoaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYx
NiB8fA0KPiA+ID4gPiArCQkgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9G
TVRfTlY2MSB8fA0KPiA+ID4gPiArCQkgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwy
X1BJWF9GTVRfTlYxNk0gfHwNCj4gPiA+ID4gKwkJIGluc3QtPnNyY19mbXQucGl4ZWxmb3JtYXQg
PT0gVjRMMl9QSVhfRk1UX05WNjFNKQ0KPiA+ID4gPiArCQljaHJvbWFfc2l6ZSA9IGx1bWFfc2l6
ZTsNCj4gPiA+ID4gKw0KPiA+DQo+ID4gSXMgVGhhdCByaWdodD8NCj4gDQo+IFllcywgdXNpbmcg
dGhlIHNyY19mbXQgc2VlbXMgYWNjdXJhdGUgZm9yIHRoZSBlbmNvZGVyLg0KPiANCj4gY2hlZXJz
LA0KPiBOaWNvbGFzDQo=

