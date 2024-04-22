Return-Path: <linux-kernel+bounces-154026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863888AD641
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136071F21EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F11C69A;
	Mon, 22 Apr 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Idekn3ei"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67191CD2E;
	Mon, 22 Apr 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819607; cv=fail; b=iASjA8AvsGw6O5dFTFcj6wvjbQTiu4dyPvIG9jQ3oW5b3GDijFTfe7MQbZ8/dkJZjPPqkCFhIHtglylEXPdhdYUJjxzOxzS8n73PNEvPHAyedZeALMCodY3fb89Qzuc+HGfRLKLgtqlWfMx6CFWf/R+bkrcBW/j28MyT3fIQIQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819607; c=relaxed/simple;
	bh=jgZHlvoa2jg4sfFg6rGqyjeGxYybKjEpg7G5/EvbCxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZycm01sDK081Rwau0FhVWY+tAr6Ac20j4LTy5jRxyR7Vz0z9pqIX9ArJ+p8HlgKUTCnC/gt346NRpBP6CRj/D7nKhhMfWw+SEG5JbaOlpWrJD7dMatS0nipp43vbVSrSiWYZNeQnN+IrZWsLZl60qs52g0G6qayOBwfEM7tJWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Idekn3ei; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MJCEt0018414;
	Mon, 22 Apr 2024 20:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=jgZHlvoa2jg4sfFg6rGqyjeGxYybKjEpg7G5/EvbCxs=;
 b=Idekn3eischMqsN0Fi6X+DJDO8hw8xwoAUh1QX0X83hdKkIsBKry5DayDyKiBP42pI6G
 2MpCF/Ow9CZcMkQrnFr3I18iu8DP3JO2sdE+Z4y5VTkM7d1alYlpUOBKWXFdaIr3VWwc
 KVnnUtz1PkrD9WkBgiuDfa0XRz7GVRL37w1jrUIZOx8rJUmj8+lGIdIWbVhWisU080Wy
 B3Zv5nZMuPvKPrOZHeTUD0cdnmPdrEVmreVAH+cYUjedH3HrrHjdvJwAAJ7m89FQ2+Y8
 OJI6+A8Bj0rQTj2sE0zc7wooh5xw7AClv8LNBgeABDSBbpOEWUEwCv2HR0IHf8lvNoiR wQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3xnqk4cjxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 20:59:40 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id D4825805EAD;
	Mon, 22 Apr 2024 20:59:38 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 Apr 2024 08:59:31 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 22 Apr 2024 08:59:31 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 22 Apr 2024 08:59:31 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFUN1WFcFdMr6rgh4jPS90wd/t2VCccpDy/uQwXiaGrhQ3z2XnqLoQeWChcta8aSi9tHMmXPwgjbs/SCpARTdIl1yzE68rirx3gAd5CZBXa41iLl0krzqDkE+N4qu+/i7kSRDPnyGX7a+wZkLZPvB/s9EbU3hDhXqI5QUWN3Tt/e9fLVfpno5tSfEKX9JHMwfjpatO7GJGO0bn3JJfOARQOttuzQCO45FZXy6GbMhTbIrk6Xgs4XwgePIGw4BolK/QyxsFgBJlz/bK358E74zRjSyNgXZZvx+67VYqsMMGLGwQSEGbr/YT3++ra5NLgP2eqona6EtXB1KWkPUKQF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgZHlvoa2jg4sfFg6rGqyjeGxYybKjEpg7G5/EvbCxs=;
 b=K6ZtZHNzlaNyv+6UHUdKnlDy4ja3jhVyN5gTi17vulTtwiI+ihuToL0A5TTBPUhy0KEHbgZ6C7DLOhI0YRQRMGu7Yq0cxKJO9NYm5LE+0nCvJIfWB/mk8jYvyZlH9IJVAvz7WRhD6UVv3pxlDRdQZO9Osg/9emj+/jec4Y2oXr9b2OY4lRSXy1k2CSZC7I3AYmA342QXws1MQkvuh0sZPZIah/iPSrmLfOVph3fXIRZ3PoFmqar9CWd3CqNX4SdpdflXnsnR1xrznSxoA/qFWdwYbkkwhJE8BTYchQwt8seDfjwkRWujmmkjxV7Z3NHDuSxqJJGkdbWJiwUNahOH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1883.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 20:59:30 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4da6:9972:feeb:2ad7]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4da6:9972:feeb:2ad7%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 20:59:30 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Thread-Topic: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Thread-Index: AQHakjC6i7OisBxFg0KE35p6PF3J07FwAqnggAAjaQCABKMYkA==
Date: Mon, 22 Apr 2024 20:59:29 +0000
Message-ID: <MW5PR84MB1842886B2B54C00E80BD5A37AB122@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
 <MW5PR84MB1842F4C102CBFA73E861F420AB0D2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vd_zfuRc5nV42MHUjyOPQgf0+=A5Yyj8kaO7vYcmQsOzw@mail.gmail.com>
In-Reply-To: <CAHp75Vd_zfuRc5nV42MHUjyOPQgf0+=A5Yyj8kaO7vYcmQsOzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1883:EE_
x-ms-office365-filtering-correlation-id: b3b0d16b-6d52-4371-f070-08dc630f1a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZlNGQ0tPUjRadldTektva29mMk4reTlsNWFaTUdmeTJ3VkgyMmUzZlVHRzVL?=
 =?utf-8?B?dmdoaE5BWUMxb0JrQnpIeDZIV2V1VWl5TmV6c1NPVTZ0MWVOdWp0bHJtSVpK?=
 =?utf-8?B?aTdXSmQ2NENQbmpmQ2x3RVdtSm5aTWFqZUVlSVhjRlVCRSthZktBN0FDMU1t?=
 =?utf-8?B?TlFrN2tKQVJMblRVa2Y3U01USFdrNkdtSXQ1SGhhNUluN2x5SE9qNktod2Zs?=
 =?utf-8?B?OGZTV0xCdWZQS2FMVjhlZ2VqWjlVQ1ZEWTgwYWNxVDF0Vi9uQklGYXJvbjBz?=
 =?utf-8?B?TU9tVzF2Q0dhWlg4bXo3Qnd3cW9BZnZIdjhmT3Urc2RSTmtsRWxDTUdoYVl3?=
 =?utf-8?B?aUtPeWVyOWhraHF1NDA5c2dyTE9nQ3dFYlZkZjRQeFNnb3ZMbmdrRGxtZzda?=
 =?utf-8?B?SUs5YllIL1pFa1BIbTYwSjVEaDdmQTFLU0k0UlNDTmJ4SE5XZXhmdDlDNGkv?=
 =?utf-8?B?YzZ2eHZpUitxRTdjc3czODZXQUJCaDZ4Z1lSYmk3a0lTV1pQSU16M0JOMmpa?=
 =?utf-8?B?em1McDR1dkxnbUQyS01JM0dJQ05rZ21BOUg5VGZ3VlNWdy9kb2MzUFpZSStH?=
 =?utf-8?B?U29NS1pvQWRqaTFERWxHSGNtTGZaWkpLdldsTm01V1NSNjFZNmxxY2NzZE44?=
 =?utf-8?B?L2dhZ0gxbi9KZVlqbGJocDM3RE9iS1NLTTFFcjlJNU9LS2l6SFBoU0lwK2Uw?=
 =?utf-8?B?TVRwRnIxZ0J4SEFVd09pQXkycGQwZ3lKVS9NOGpOeGFYbnZOeklvMDFNdFl5?=
 =?utf-8?B?K2pWUXB6MVBqdDhxWENuQ2dBK0grVWI2aERMM28xRGoxYkM0eldVYStVRFB4?=
 =?utf-8?B?TTVKVGk0ZDRCU2RocHorRFBBWjMwaVBkbFpxOHc1Z05FV1JsVWJOWUFBRWlt?=
 =?utf-8?B?bFhmVkR0N3I1OXZxVSsvUnR6dzRDRU56Ni9UWUZ3OFBXQTV5YkRLSUpFMjV5?=
 =?utf-8?B?ZFVXdnpLc1p3eXdrTi9wSU1CVS9IdFZHelNadStsVUtMTTI2aTFUY25BYWNE?=
 =?utf-8?B?cjM2SHdpNmc5MC9lYnNob0xWNHpnUll0Z0VwMndPU2NwZlo5T0hBTDFGL2M2?=
 =?utf-8?B?cEpmT0lLTCtzaG0rTVNQbzAzb2Y3cHR4N2EzZ0xvZ1ZpZk1OS0x1SUxTMHdm?=
 =?utf-8?B?SUZwZFlBVkM4VStUQ0ZndDg1YVlJTWk2cVFhNlhPTlNkWlhWM1BGTWhaM3py?=
 =?utf-8?B?b3Y0MTFIQ1NUbXlISXd2Rk5sS0tTcUhMLzFSbm14NXNPd3FOdUFjQys4NC9Z?=
 =?utf-8?B?Vkhsa2V1eVpTZFZ4R1VraDFiS2pHclRpTVczeW5xL1NpRUpONDJ1YTliT3FS?=
 =?utf-8?B?RjJSUlpYNzd2RnNyUzBvZlpVRzQ4cU9JZGNZS2EwWS9rTWhFVi8yR0krQ0Y0?=
 =?utf-8?B?eWYwWkZZNmRPaE5iQ1JJQjFVeloycm1xOFRzRmp1cElJMHVMcE1ZNUlteDFU?=
 =?utf-8?B?VllTY2dnVldzQVVpMnhvMHdQUStlenhMY3c2UFNNdEVKVDdyT1B2S3RiT1Ny?=
 =?utf-8?B?RkJxalF5WTZHSnFHd0Rkc0MzdUxSRXhlSjJZcDNvbVBOWXk4bDVodDdZcGJ0?=
 =?utf-8?B?REdZRUNYR2VXWkI5MEdqNnlVc2lmdjk0cVFvVGlncUM5RURrN25VUTVTM3Vl?=
 =?utf-8?B?amdDZGJpWEV2aGYwM2xPaXFJQVorUWtsc2tNRGk0NFVuYTVkRS9oc1ArVWpW?=
 =?utf-8?B?dEhmZk05OHI5N3NJcExLY2RNcFRxR2xvb2R0SVlIQjhpRkppNFNCTWpmZnow?=
 =?utf-8?B?alBVbW1pbUU0cXJURFlLclRkOVEzenNNcXNmUTVidk9oaXdDUkhqeDFyeVln?=
 =?utf-8?B?RXRKUm90Y0o3N3V3NXZNdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JpRmR5NHM2YmtHMUltYVpEVDZMNlkvSjBQYldheHUvUmZnak42cnlMUTJT?=
 =?utf-8?B?TGhkVitxRUV0eWVrMk1WRWxabDFHb3V2d2tMT0p2czFhbVh4eElGS0hDTHc3?=
 =?utf-8?B?dlB5Q1dwMXZZTmljSmd6ZWxFNENOZWhoeUFnMHl1VlhXU1VZdU1yck1PQ0Nr?=
 =?utf-8?B?aDRNN1hRWHZwQ0d1UE5tLyt2RHVod1h3a28xQXpORXIyTEhLWG1BT2k3TWFa?=
 =?utf-8?B?bTZ1ZE5xZkEvZWJaNktLL0hESGZncmNOODVOVm5DWlkyMm9VT0dEOGxmKzZT?=
 =?utf-8?B?dU9yNUVUcXRtWklNeWUwLzNjTVF4NHZTNlRsMDJabEgwZjFyYXg3aGE1WEI5?=
 =?utf-8?B?bkI5ZG9pN3RLanVib1BzMkFOamtsa2F1TUVUZDJERWJqOEgzQTZOdGxLRS8v?=
 =?utf-8?B?VGFhOFJscWJBMHhIZTJMc3ZXR0ozOUxTSFlYYmxxL25RWEw2V3hEeE04UzV3?=
 =?utf-8?B?NHJSM2FjU2l0UnFkRWgrNEljRVh5Qmw5WG93V0lDenluUlZoanc2OUgvUHYw?=
 =?utf-8?B?N1lMbGF3MHEyQWtNS1BnSHo1bElCZWxqajB1blRmTGxHN2RaQXFOY0lXYThq?=
 =?utf-8?B?KzY0Wks3YU1kUVNkbDhrSFIrU3F3RHYzenNqaUpLMjZnVTN6UUJnKzNkSjNZ?=
 =?utf-8?B?ano4b3poUC9RMnBhMWlDc0RldDNzOCtDUVpxTk5ta2RxZmdBNUxKUkZZb0dL?=
 =?utf-8?B?RXQ3bzRTSU1WZ1Q4cU9UQnh4NER1UXhJbDBZR3JhelBLVEZ1eTUxdzcxbWlj?=
 =?utf-8?B?SXRQUlJKQysyNUNuWjdmcnk5QnZ1RGNMQ3pQWGMrMGlGVGRwYkVJRTEramM5?=
 =?utf-8?B?SXhLeE0veHRabVNRYytSSUpLMzJnL1QySFZDL0lXdzZqeE5aZi9aTHVUaG96?=
 =?utf-8?B?QmNZV3JEZW4yRHJSb0NuTzlCTEJidU1WREhFSGRvRlh6dlEwUVRtN2VXSnFi?=
 =?utf-8?B?QkZBRit5K3o3Vm84c1IvcXdhL3oyQzdod29pSks1WVV5ejUwYVJnTVZQMEJP?=
 =?utf-8?B?ek5aai9IOHlqcUNCL0NBT3J3R01IMEtXOHp1d1NsWm5peElYblFkMGVpZTZu?=
 =?utf-8?B?M2REYTRlVU9Yai81bUlZU1kzcGhMYk9Wc3FqR2JSRjFHem84M1FMUXpSbCtm?=
 =?utf-8?B?eHdsTFVNak55UG9SaXpmSGttMGgwY2lLR2Y3Um9aU2Z1d1p3a1FLV1VEWVVZ?=
 =?utf-8?B?R0NXUEF3MXJyL2tKckxrdjdKTS9CVHM4UjRZTGQzM2s2dEMxZEw4UHExZ0hq?=
 =?utf-8?B?ZzBQekViYlRtZkJuYnFrYkYvWGN4cm9xZW5aKzFRbjJQY0FDWFd2LytBdEVO?=
 =?utf-8?B?NW9RZlhTem5FRmNSNEEyMEg1ekZNUmJxc09IcysrSFRuaVJjS0tGaDI4OGlY?=
 =?utf-8?B?ay9kR2QwTml6QWJjOE9iVks3UmhTeTBpNmJKOXJ0Wk9NbkhPNEpCdEkva2Ri?=
 =?utf-8?B?enhCbnhKTDhsSWpkZnVaaFZreTlQNDJhUFJhbTFFV0xQdGpCa2MzVUJqYmFs?=
 =?utf-8?B?cVNlbzlKWXJ5S2tFdmNHTllld1RsbkYrZkhrdWRZN0k0MjdpeTVsYnMvQnB5?=
 =?utf-8?B?bnNjWEhxQ3B6c2x2MGJlaE5HN01tWk1VN3pXRDBvYXRDaUZYRmh5cDBKc3FY?=
 =?utf-8?B?T3o1Q0Q5aFNabk0ySDdYazZsSE5oVHhHbUpoUUsvWWJ5eWdlRzZLZlFrNDlQ?=
 =?utf-8?B?cUdJWkcxajU3VXFyVWNzVmpOMTMxamRrZ3dwYkhzWFBqUWVIaElPQ0trc2RD?=
 =?utf-8?B?SXJrTTcrb2p3TDAzOS9WRUM0RlZIMDBJcllqZnlnVStES1lLUlRsaGluNVoy?=
 =?utf-8?B?YUNUalZCamYrM2lZMTMxZE54d1ppb3IyT1RxdnZUWTJnYm9xUU1sSi9BaE1I?=
 =?utf-8?B?dnVnZ1JSNW5yVE5xSXcxYk9UUytIWFFSQ2ROMm5zY21GTDh5bDZGRTVMaWkr?=
 =?utf-8?B?eVdCTDFvZXZaN0tscHZTVnl4eEx3VzBvdDJvek1MMW95T2U0emErcEw4VExm?=
 =?utf-8?B?TXo5eDArMklPS3hzSzBTaUlLOXZteWFabmlSa0VOMGRvbGNEYUoySFlURGdl?=
 =?utf-8?B?RE9jTnBoQVBPbzg2VkRFQ2F6MUpTRWRMc1AzeFNwb3IvZ3ZOTEJNenh3ZzMz?=
 =?utf-8?Q?2HiU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b0d16b-6d52-4371-f070-08dc630f1a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 20:59:30.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHVF04pCKH0JJY53nR61Q5Fon+usVFg3/Vp7iSzrNdYTFj9oLhm2Dq4IF5NFxNeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1883
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: wDLuEXJ0I4BJcF2UR-apUcNIcTLu2OFF
X-Proofpoint-ORIG-GUID: wDLuEXJ0I4BJcF2UR-apUcNIcTLu2OFF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_14,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220088

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDE5LCAy
MDI0IDU6MDIgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZ3BpbzogQWRkIEludGVsIEdyYW5p
dGUgUmFwaWRzLUQgdkdQSU8gZHJpdmVyDQo+IA0KPiBPbiBGcmksIEFwciAxOSwgMjAyNCBhdCAx
MTowMOKAr1BNIEVsbGlvdHQsIFJvYmVydCAoU2VydmVycykNCj4gPGVsbGlvdHRAaHBlLmNvbT4g
d3JvdGU6DQouLi4NCg0KPiA+ID4gKyAgICAgcHJpdiA9IGRldm1fa3phbGxvYyhkZXYsIHN0cnVj
dF9zaXplKHByaXYsIHBhZF9iYWNrdXAsDQo+ID4gPiBudW1fYmFja3VwX3BpbnMpLCBHRlBfS0VS
TkVMKTsNCj4gPiA+ICsgICAgIGlmICghcHJpdikNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQo+ID4gPiArDQo+ID4gPiArICAgICByZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ID4gKyAgICAgaWYgKElTX0VSUihyZWdzKSkNCj4g
PiA+ICsgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIocmVncyk7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ID4gKyAgICAgaWYgKGly
cSA8IDApDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBpcnE7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCBnbnJfZ3Bpb19pcnEsIElSUUZf
U0hBUkVEIHwNCj4gPiA+IElSUUZfTk9fVEhSRUFELA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfbmFtZShkZXYpLCBwcml2KTsNCj4gPiA+ICsgICAgIGlmIChyZXQpDQo+
ID4gPiArICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVk
IHRvIHJlcXVlc3QNCj4gaW50ZXJydXB0XG4iKTsNCj4gPg0KPiA+IEFsbCBvZiB0aGVzZSBlYXJs
eSByZXR1cm5zIHdpbGwgbGVhdmUgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgdG8gcHJpdg0KPiA+IGZv
cmV2ZXIsIHNpbmNlIHByaXYgaXNuJ3Qgc2F2ZWQgYW55d2hlcmUgdW50aWw6DQo+IA0KPiA+ID4g
KyAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+IA0KPiBJJ20gbm90IHN1
cmUgSSBnb3QgeW91ciBjb21tZW50IHJpZ2h0LiBEbyB5b3UgdGhpbmsgdGhlcmUgaXMgYSBtZW1v
cnkNCj4gbGVhayBvbiB0aGUgZXJyb3IgcGF0aHMgYWJvdmU/IElmIHNvLCBjYW4geW91IGVsYWJv
cmF0ZSwgYmVjYXVzZSBJDQo+IGRvbid0IHNlZSBpdD8NCg0KSSBkaWRuJ3QgcmVjYWxsIHRoYXQg
ZGV2bV9remFsbG9jIHNhdmVzIHRoZSBwb2ludGVyIG9uIGl0cyBvd24gKGludG8gZGV2KSwNCnNv
IGl0IGxvb2tzIHNhZmUuDQoNCg==

