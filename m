Return-Path: <linux-kernel+bounces-152668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F8AC284
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8509B1F21004
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F29442C;
	Mon, 22 Apr 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="CVZ9vQtS"
Received: from outbound.mail.protection.outlook.com (mail-koreasouthazon11020002.outbound.protection.outlook.com [52.101.156.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832221109;
	Mon, 22 Apr 2024 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749063; cv=fail; b=iFlii0nEnlyowpgVVMDNEmalwT6qYRv6ceriMZsRfkEiRIcvNrYjHFZxhRLNTxMpR75SEuwJgKw7HY9rk/kNdfEiWlDA1lXwbsU2tEG0/TzcxXcfY+CLJlR6Kirmb2zmXQzYGo+wIiaFCQE2eIHTGrHq2hrpBp6z+Vno3wS8Yrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749063; c=relaxed/simple;
	bh=tz60iXJgqCsDq3mQYJNobQaO5xl8y/+7UXR7rU2JWEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZ3Aqq3luAIxBAaPbiF1TslQlRRpg9n1hp0Qjhbdoyfq33WSsoseSBRe0iCTOifcaRzOcT3m1UvKtnigKDesQrBbHxHpXUcmlMv+S5YBZw+dSuWa8zf7YybTbfQ2bM3XY0rMHleIogZJNtbZLn0axbz4To6HHuTDnP1jDVNnXJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=CVZ9vQtS; arc=fail smtp.client-ip=52.101.156.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6mUSOm+xGG3GrhwtKkVlFbX8h3CPzwQtpBMYWcQ1m+ZjndsaZzph2RinzyU87fRqH4I+er5JwmCL3uX7n380uAAFbAmdXjTn9PjZOBdWmAW3O5mLeuik59v+lPJsu8jEL7RCgjWcQSddVGJN49dagqzgHWQ+MSD4zUwdNvjjxZBE7TxZcS75NvLgNoDYS9cW4yyzB4BAKmx4tYU8/bBaNSwyKVzoOTwH0goNI8ocnO/EaYTEfxmgSRGDy11QMx9aocpHcG4iq/S49y2LBs7EEOTp7WPs/tPcAT67LezEhLB7gLPi5AE0MIxteFNtWd90zGISgqAlal5O9mN1VDwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz60iXJgqCsDq3mQYJNobQaO5xl8y/+7UXR7rU2JWEw=;
 b=bCiwuTpK9jQndqnz82L78+1KfpbdyakYNhm66shvSk6LAA4fLabBb8cabjTVUDsWxdVDkJk2tsPKULdqjPJb99YbjNznSJH/iT7Dgqxm+4Zp4j8qoJaMiV4c5NAdMBYMXiLTUHmEovSC2iPsOUz8uVZsmydJ2M26844xC4dA5Zfd7p2PcArjQYbmKh4QoZxz+BEvJUX0BGE0spIusEF6Och+aZquxXFLRHIGZIFuAqqh9eQVyIbejz5OZ/R6RwtLd+5/yrBymWMka3BE5ngw5e7PrB7Hwr+r85aCgy8tGRCpB35t99RcMUNxHMtf3H+l2dmeXpQlp9kJoOPymkbf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz60iXJgqCsDq3mQYJNobQaO5xl8y/+7UXR7rU2JWEw=;
 b=CVZ9vQtSzbzSkCGym6BJUCUeTqZAW3imSeI9YkW+XjVL2UkJz0WgQTFDjdF/qxtlu3gnSmd83B8ow2Hb6ASGVaX4yy15X88oWg/4KiWFee5w3uOE/W8JLYfizjLNPGgWRx5wFbUfN8Slp6Bmj1wWDL1NIV22tLQWaqx6S0FbDug=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SEWP216MB2764.KORP216.PROD.OUTLOOK.COM (2603:1096:101:298::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 01:24:17 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 01:24:17 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 1/4] media: chips-media: wave5: Support SPS/PPS
 generation for each IDR
Thread-Topic: [RESEND PATCH v2 1/4] media: chips-media: wave5: Support SPS/PPS
 generation for each IDR
Thread-Index: AQHac6LGNxwcLv0qDEyuzxryc8+Au7Fuup2AgAUFXFA=
Date: Mon, 22 Apr 2024 01:24:16 +0000
Message-ID:
 <SE1P216MB1303E78AA4E73F752C0511DDED122@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-2-jackson.lee@chipsnmedia.com>
 <b2bd37736630d339091ff829a8437b1a34eff292.camel@ndufresne.ca>
In-Reply-To: <b2bd37736630d339091ff829a8437b1a34eff292.camel@ndufresne.ca>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SEWP216MB2764:EE_
x-ms-office365-filtering-correlation-id: 5e3735cc-7ec4-4f29-eeab-08dc626aed6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2FuU1VKWWc5YUhhNjNmQTdQL041YUpPd0xDZlJyblhuTHp6V2lDYnIzTjZo?=
 =?utf-8?B?QzFtM3JWc0xtMEpOR1pXRGJ3VWtwajRDVlhDQ0IvOVptTkE5Z3hZdXJWS3Yz?=
 =?utf-8?B?bHp3SEJjNXBFaW5IRjlmd1RmUHZwS2NneFpYbXZjREdxVmNnc0pxUkI2QXVk?=
 =?utf-8?B?NjFuNWVzcC8rMzBnWEx4Y3piSHNrZTA2dXBTcUl2ejVrRXErajAzWnVkTGNV?=
 =?utf-8?B?RmgzWUJBY2NTd1dkc3l3R05YT3BzN3cyTUwxUjNFb0JCSlNOaWE4MExqbW1T?=
 =?utf-8?B?U2dBT0VoQlpTN3owRkV3ZGN0MUhnWGdxR203RzV6WVh2eWNpVEJNQkhQNWN1?=
 =?utf-8?B?RW04SDErTlFnUU5HSGgwK2VVSk5MaGhxdkYrOTdzZVU3VEhlSlhWUXE2dDJ6?=
 =?utf-8?B?U2lDM0lMSjVaN0EybGk2RzJCcnVIUGcrVitmZTdRL1JpNG43Um55Y283WXVv?=
 =?utf-8?B?dFpxZi9aQmJlVjdqQk56Y002YkhYdUYyRGh6VlQ1Nlo5Y3E4Mk9zN2d5YjFJ?=
 =?utf-8?B?MHo5SC96S3pCOUdCQzI5aUwrMnJxcGd0eFNOT0Jsb2dpNjl0U3ovTXF1MDYy?=
 =?utf-8?B?WmplY1FSUTZnazdIVmZscjQ5TCsxK25DWU0vS2lxWlNqRFpURGFscnlBamNL?=
 =?utf-8?B?RUR2c0dCRU1vbWhWUWZYVXZHSDQ5Q1lLSzZ1eFltUnhmbFNRd2hNeW15dzdQ?=
 =?utf-8?B?enNkYmMrWXBVc3haZ01RQm82Z0IxaUo1cDYwYlpUdnNES2xNdlMrVUtpVnZm?=
 =?utf-8?B?UHFEZWlYTXZvRURBdVNxUWNSNk53amZXMUpQTWY3YWVRYk5TWXZRYVppQVk2?=
 =?utf-8?B?WlpxeWdqbkFoaE1uWnFZNFFWUnJCRXdRcEJIdkVTUTk3TjFtNU9FMlF6eVVU?=
 =?utf-8?B?SC9YYlhFbVNwSW5YOUJ0OHpEaE02aVk2dVllc0Y1NlVTZFpFejNJQ0ExVEp6?=
 =?utf-8?B?MDg2SUhsUC82dHNsUVNKaUdzeW5VbUVxbjhiTVpJOFlYV0RVcHlTTWhMUzhr?=
 =?utf-8?B?K1JIWjJrSWV5M0N5WmNvWTVqbXB1aXRHZEk2dFVhUlhyelNjd1NESFlGQm95?=
 =?utf-8?B?SjJtQVJKQm8rdWZ5WEQ4aHI0b2V4Y01vcHZaSi95dDNjZGJ0Z2VrY0doQWlN?=
 =?utf-8?B?ZDA1TUVWWkUvblY2Y3U4ckFhQ0dHK2ZHNDgzbjYzcWFYRzN0blI0bytWVFlp?=
 =?utf-8?B?RmE4K2xzY2ZTMFNZRkwwZVBXZ2V0bEhQSTZqblBKSEg2dlQ4K0d1a09BRStM?=
 =?utf-8?B?TDhDV2FVZjhXNEh1UW9oWms2OWFISFpwMmVQeUdEVzVyRTB3VmZFakt2OUtN?=
 =?utf-8?B?aXgzeEFpVDdkWnpqV0NJd3FSUStKdzk1VSt5VkpKMXZLaWZUaVIwNFVsOStN?=
 =?utf-8?B?Z2hNMUU0TkhlQ3hyZktMc1duRGxOc0ZuL0QySUZBYVdqREtRb3kvNkliWW03?=
 =?utf-8?B?UWV2S013RGFlRURXVW90ZkpaWDlaeGxDTnc1L080TDhMTGpmMDBHM1dzdWJm?=
 =?utf-8?B?UXpBYUZNcytrR3NONFFZZzUybDBaTUdHUDROalFVK2Z0N2xXb0g1WDlXYStH?=
 =?utf-8?B?Q2U5WnhzMEZYbVZPOWtSOGsvazVCMjZsZU1SSytNSU85bWZpR29BenZUcDZJ?=
 =?utf-8?B?UHJ5azhnMlR4MVBXVk9ITE1tR0FqVUVxOXJycStFTGRZRWUwOWtJSlBydW4x?=
 =?utf-8?B?VEhIbDk2NmxlVCt6bzBVT1krRmtrMGpFMjlLeTUvb0VBeERmMGJwRjI3NEFs?=
 =?utf-8?B?YXNzV1d5bnMwTmlYK295SFlXcWd0ZEd3MUg3YXJ0bTI1L29YSVY4YnFYdWls?=
 =?utf-8?B?Sm82VXNySUdkWkNPUWZtQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUpLNVlDRDlPTndMeUtQam4zc3RUcnBGOFFZc3RNa3lUZ1drYXRxNy92eGh3?=
 =?utf-8?B?cTV0SGR2dk1LTG5XMXR4TzJ1SENDZ2Q0S0tpaUNiM0ZucXQ1a3IwZmI0ZktO?=
 =?utf-8?B?YVZ2Z3plN2dsanZpTVBOc3VESDRnMDh2c05iZDUvdWhiMTJWRFpFY2ZlNG03?=
 =?utf-8?B?d3JjM1NPTHcyNXVUcHJjWmVMajdVc0VjSEpRYjJVdTlTS1JlNmY2aTZWMUNk?=
 =?utf-8?B?L3puc1BHclhNVHBCQklWd3ZuRGY0MlBnQmFmZTM3WkZFMjlXTHgwc3FDcm5W?=
 =?utf-8?B?MFR0Sm9EWnYvMklNWG56OS9JbHN1eGs2TmJHZDRYamNkR1ZhdkpieVhobERK?=
 =?utf-8?B?WVlEQU1XejdLMTJIZ3ZhcWxNUEFvMVJsTlpWQ2JXem9TQXJqNW9EVCtpQzlZ?=
 =?utf-8?B?TG15S1dhYUEvNnVpd2tFcmJXbWhUd2ZBSHhCTlg4R3JuV3RaeS9hTDkrSTMz?=
 =?utf-8?B?eFVXb0d1dGFWeG1tZmdPSEYyQ2ttNVFUbzZWaW53dmUyeVgxMEU5T2Y5Slh5?=
 =?utf-8?B?VWlCOXlYU1p3VXdYMHA5aDN1dDFLbzB1K3NTWFBhWFp5cEZRQlVIZTF4ZWhY?=
 =?utf-8?B?MmFnSlNaWUZwd2VYOUJDd3YyWk0vYkNkb2NIcnBYdXhnQTZqUE1LN3R0QldY?=
 =?utf-8?B?dytWbnVkZTV1WVRDa25LWmVsTGg2a3UwUUFGWGJ0ZjFEY0ZQcFNoVTZMd3R1?=
 =?utf-8?B?d1BrZitDMkQrQ2NqOVBtMi95MmRMakFBTzZRNWZtQXRpNFNIcW1ScWxDanQz?=
 =?utf-8?B?UlFMamhPYnFhTUlzRHRhRE5tSzRwbm1nSzJHc2hsN05EYXBRdEphR2xwUG9u?=
 =?utf-8?B?bEVEdVVZaG1jMk1iRUlCSWZ4aEphb2FRRW96ZEpwT2VtdndyVTZLbjRNbU9j?=
 =?utf-8?B?bUE5RkRPNFM1WnM4UEs2WlpYY2o3Q2VrWFpPR21rRStBbVNuSFcvb2dFdkZM?=
 =?utf-8?B?R0ZnSDBWMDdrdkV4UVE3R1dXZWlicFMybGk4T1RKR1lDVGNka24rR3BrMDIx?=
 =?utf-8?B?WVNZWHI2eENFQWcrZnQ4dmVCdmJNL1MvL1FPSnhjRjdPajIwME9pYkhpV0U4?=
 =?utf-8?B?R1VyR0I0eFNzbENRNTNEMFlqeXN0bGZaTzVKcS9yaDJIOGdmeDhHWCt2cWpp?=
 =?utf-8?B?SGh1dUd2K1E1dWNyTVQ4dXFrakt1Q0N0dzlWU1BRWjRFR2FtcVMxSG5zbVp3?=
 =?utf-8?B?bGRlQnh3L0p6NUVVbFZiTUlEMC9Cdk1BTFFKL1JMOXFrMnZDdzl3Vnc0VVpx?=
 =?utf-8?B?djE0SEhxTmIwSEc5aDNVVmx0dmlXc3RWYkJFdGhOdGRLQjJoRGtvWGl5RWVV?=
 =?utf-8?B?S2RhYUhIRU1tK0pkWkptWmZYM0RWb3NORVpqSFR6RkN4UlRyS01QMFl6V3da?=
 =?utf-8?B?V1l0MnBEbkxOZnlLNEhNazdnVEJEWXc0RmxkOXBwVGdiekNra1pYZVlQbVZu?=
 =?utf-8?B?S05Ca2xMYlBCSk9ZaDA4a3l2cEJVcUhJNUIzSE9iVVNCRVRubkQ2dTdYU2Jj?=
 =?utf-8?B?YjI2VUM5cU1WdmI5YUZyZXhxM005REVXT2h5aUV0Y21qMXl2Zy9CbmNHZFZR?=
 =?utf-8?B?RXVicjhBN3V3dnJCT0ZsVFdmenZVdCtJN3VRT2xvRUx0RDB5UGZlUWFoclBO?=
 =?utf-8?B?ZjRXU2J0OUIzaXZvdXRRdTY0YUxlVUNiMFNpTC9MRCtUMDRHL1p0Y0RsTkVO?=
 =?utf-8?B?SUQ0NVhrK2ZySzBaZTQ2TXMzOFlLRS9wK3NweENWZWU2aGlhdzlBV0ZRMVBT?=
 =?utf-8?B?WXJacVZFZVlyZzBERUlqaHlCTlNxOUErOW1CSVEvcWV4czFES2QyM09hMWtr?=
 =?utf-8?B?emFIU3ljdldza0R0bG1yQ3NnclFHdHN3Y29uQ01CbGI5Wk1iN3pUWWgvT1BR?=
 =?utf-8?B?UGxzUzJVVlFNMDlzL0IzcHdIWCtCMkI3NlhoSVVPcnN3TlV4ZDR2RExUYnlB?=
 =?utf-8?B?K2lSSEpxRlYxdUZ3bHloL01IWE1uMEpQOHRtRkd2OGZpMzVlU3oyT2lnd0ho?=
 =?utf-8?B?NVdqdjIzRUE4cmJaeEFFN0puZFFDNmZFZWI1NjU5OEF1QkN6aDEzTHgyYm00?=
 =?utf-8?B?Tnp3WWRGNVFNMVcvL1hFLzhpTHdVVXd1eTdRL3huVk1yaFJRb1FTUXMzamY4?=
 =?utf-8?B?NnN5b3lBcGEvc3NiRzhJNmFpLzlWcmNuaGJ1V2Q1ZlE0UUZwc01KV1N5VWtQ?=
 =?utf-8?B?clE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3735cc-7ec4-4f29-eeab-08dc626aed6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 01:24:16.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6XtO1wShBpV/VTLOoKlLGukzvYUOOdA9zHR02MJXPYgmDdkwyqhQUsNHtU+t5N/YtKvjedjVlA47yi1dZ0tEZxlhZcnx2Ye7jD3xNbvETY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEWP216MB2764

SGkgTmljb2xhcw0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpJIHdpbGwgYWRkIHRoZSBz
dWZmaXggaW50byBuZXh0IHBhdGNoLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPiBTZW50OiBG
cmlkYXksIEFwcmlsIDE5LCAyMDI0IDU6NDMgQU0NCj4gVG86IGphY2tzb24ubGVlIDxqYWNrc29u
LmxlZUBjaGlwc25tZWRpYS5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+IHNlYmFzdGlhbi5m
cmlja2VAY29sbGFib3JhLmNvbQ0KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBodmVya3VpbEB4czRhbGwubmw7IE5hcyBD
aHVuZyA8bmFzLmNodW5nQGNoaXBzbm1lZGlhLmNvbT47IGxhZmxleS5raW0NCj4gPGxhZmxleS5r
aW1AY2hpcHNubWVkaWEuY29tPjsgYi1icm5pY2hAdGkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkVT
RU5EIFBBVENIIHYyIDEvNF0gbWVkaWE6IGNoaXBzLW1lZGlhOiB3YXZlNTogU3VwcG9ydCBTUFMv
UFBTDQo+IGdlbmVyYXRpb24gZm9yIGVhY2ggSURSDQo+IA0KPiBMZSBsdW5kaSAxMSBtYXJzIDIw
MjQgw6AgMTk6NTYgKzA5MDAsIGphY2tzb24ubGVlIGEgw6ljcml0wqA6DQo+ID4gRnJvbTogIkph
Y2tzb24ubGVlIiA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPg0KPiA+DQo+ID4gUHJvdmlk
ZSBhIGNvbnRyb2wgdG8gdG9nZ2xlICgwID0gb2ZmIC8gMSA9IG9uKSwgd2hldGhlciB0aGUgU1BT
IGFuZA0KPiA+IFBQUyBhcmUgZ2VuZXJhdGVkIGZvciBldmVyeSBJRFIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYWNrc29uLmxlZSA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE5hcyBDaHVuZyA8bmFzLmNodW5nQGNoaXBzbm1lZGlhLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LWh3LmMgICAg
IHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAuLi4vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1LWVuYy5jICAgICAgICAgfCAgNyArKysrKysrDQo+ID4gIC4uLi9wbGF0Zm9ybS9jaGlw
cy1tZWRpYS93YXZlNS93YXZlNS12cHVhcGkuaCB8ICAxICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtaHcuYw0KPiA+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS1ody5jDQo+
ID4gaW5kZXggZjFlMDIyZmIxNDhlLi40YTI2MjgyMmJmMTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS1ody5jDQo+ID4gKysr
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS1ody5jDQo+
ID4gQEAgLTIzLDYgKzIzLDE1IEBADQo+ID4gICNkZWZpbmUgRkVBVFVSRV9BVkNfRU5DT0RFUgkJ
QklUKDEpDQo+ID4gICNkZWZpbmUgRkVBVFVSRV9IRVZDX0VOQ09ERVIJCUJJVCgwKQ0KPiA+DQo+
ID4gKyNkZWZpbmUgRU5DX0FWQ19JTlRSQV9JRFJfUEFSQU1fTUFTSwkweDdmZg0KPiA+ICsjZGVm
aW5lIEVOQ19BVkNfSU5UUkFfUEVSSU9ECQk2DQo+ID4gKyNkZWZpbmUgRU5DX0FWQ19JRFJfUEVS
SU9ECQkxNw0KPiA+ICsjZGVmaW5lIEVOQ19BVkNfRk9SQ0VEX0lEUl9IRUFERVIJMjgNCj4gPiAr
DQo+ID4gKyNkZWZpbmUgRU5DX0hFVkNfSU5UUkFfUVAJCTMNCj4gPiArI2RlZmluZSBFTkNfSEVW
Q19GT1JDRURfSURSX0hFQURFUgk5DQo+ID4gKyNkZWZpbmUgRU5DX0hFVkNfSU5UUkFfUEVSSU9E
CQkxNg0KPiA+ICsNCj4gDQo+IFBlcmhhcHMgYWRkIHRoZSBzdWZmaXggX1NISUZUIHRvIHRoZXNl
IG1hY3JvID8gSSB0aGluayBpdCBjYW4gZWFzaWx5IGJlDQo+IGNvbmZ1c2VkIHdpdGggYSBkZWZh
dWx0IHZhbHVlIG90aGVyd2lzZS4NCj4gDQo+IG5pdDogY2FuIGhhcHBlbiBsYXRlciwgc2luY2Ug
dGhpcyBpcyBob3cgdGhpbmdzIGdvdCBtZXJnZWQgaW4gdGhpcyBkcml2ZXIsDQo+IGJ1dCB0eXBp
Y2FsbHksIHJlZ2lzdGVycyBvZmZzZXRzLCBzaGlmdCBhbmQgbWFza3MgYXJlIHVzdWFsbHkgY29u
c29saWRhdGVkIGluDQo+IGEgc2luZ2xlIHJlZyBoZWFkZXIuIEl0IHdvdWxkIGJlIG5pY2UgdG8g
Y29uc2lkZXIgY2xlYW5pbmcgdGhpcyB1cCBpbiBmdXR1cmUNCj4gcGF0Y2hlcy4NCj4gDQo+ID4g
IC8qIERlY29kZXIgc3VwcG9ydCBmaWVsZHMgKi8NCj4gPiAgI2RlZmluZSBGRUFUVVJFX0FWQ19E
RUNPREVSCQlCSVQoMykNCj4gPiAgI2RlZmluZSBGRUFUVVJFX0hFVkNfREVDT0RFUgkJQklUKDIp
DQo+ID4gQEAgLTE2MDEsMTIgKzE2MTAsMTQgQEAgaW50IHdhdmU1X3ZwdV9lbmNfaW5pdF9zZXEo
c3RydWN0IHZwdV9pbnN0YW5jZQ0KPiA+ICppbnN0KQ0KPiA+DQo+ID4gIAlpZiAoaW5zdC0+c3Rk
ID09IFdfQVZDX0VOQykNCj4gPiAgCQl2cHVfd3JpdGVfcmVnKGluc3QtPmRldiwgVzVfQ01EX0VO
Q19TRVFfSU5UUkFfUEFSQU0sIHBfcGFyYW0tDQo+ID5pbnRyYV9xcCB8DQo+ID4gLQkJCQkoKHBf
cGFyYW0tPmludHJhX3BlcmlvZCAmIDB4N2ZmKSA8PCA2KSB8DQo+ID4gLQkJCQkoKHBfcGFyYW0t
PmF2Y19pZHJfcGVyaW9kICYgMHg3ZmYpIDw8IDE3KSk7DQo+ID4gKwkJCQkoKHBfcGFyYW0tPmlu
dHJhX3BlcmlvZCAmDQo+IEVOQ19BVkNfSU5UUkFfSURSX1BBUkFNX01BU0spIDw8IEVOQ19BVkNf
SU5UUkFfUEVSSU9EKSB8DQo+ID4gKwkJCQkoKHBfcGFyYW0tPmF2Y19pZHJfcGVyaW9kICYNCj4g
RU5DX0FWQ19JTlRSQV9JRFJfUEFSQU1fTUFTSykgPDwgRU5DX0FWQ19JRFJfUEVSSU9EKSB8DQo+
ID4gKwkJCQkocF9wYXJhbS0+Zm9yY2VkX2lkcl9oZWFkZXJfZW5hYmxlIDw8DQo+ID4gK0VOQ19B
VkNfRk9SQ0VEX0lEUl9IRUFERVIpKTsNCj4gPiAgCWVsc2UgaWYgKGluc3QtPnN0ZCA9PSBXX0hF
VkNfRU5DKQ0KPiA+ICAJCXZwdV93cml0ZV9yZWcoaW5zdC0+ZGV2LCBXNV9DTURfRU5DX1NFUV9J
TlRSQV9QQVJBTSwNCj4gPiAtCQkJICAgICAgcF9wYXJhbS0+ZGVjb2RpbmdfcmVmcmVzaF90eXBl
IHwgKHBfcGFyYW0tPmludHJhX3FwDQo+IDw8IDMpIHwNCj4gPiAtCQkJCShwX3BhcmFtLT5pbnRy
YV9wZXJpb2QgPDwgMTYpKTsNCj4gPiArCQkJICAgICAgcF9wYXJhbS0+ZGVjb2RpbmdfcmVmcmVz
aF90eXBlIHwgKHBfcGFyYW0tPmludHJhX3FwDQo+IDw8IEVOQ19IRVZDX0lOVFJBX1FQKSB8DQo+
ID4gKwkJCSAgICAgIChwX3BhcmFtLT5mb3JjZWRfaWRyX2hlYWRlcl9lbmFibGUgPDwNCj4gRU5D
X0hFVkNfRk9SQ0VEX0lEUl9IRUFERVIpIHwNCj4gPiArCQkJICAgICAgKHBfcGFyYW0tPmludHJh
X3BlcmlvZCA8PCBFTkNfSEVWQ19JTlRSQV9QRVJJT0QpKTsNCj4gPg0KPiA+ICAJcmVnX3ZhbCA9
IChwX3BhcmFtLT5yZG9fc2tpcCA8PCAyKSB8DQo+ID4gIAkJKHBfcGFyYW0tPmxhbWJkYV9zY2Fs
aW5nX2VuYWJsZSA8PCAzKSB8IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LWVuYy5jDQo+ID4gYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiA+IGluZGV4IGYy
OWNmYTNhZjk0YS4uZjA0YmFhOTNhOWI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2ZTUtdnB1LWVuYy5jDQo+ID4gKysrIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUtZW5jLmMNCj4g
PiBAQCAtMTA2MSw2ICsxMDYxLDkgQEAgc3RhdGljIGludCB3YXZlNV92cHVfZW5jX3NfY3RybChz
dHJ1Y3QgdjRsMl9jdHJsDQo+ICpjdHJsKQ0KPiA+ICAJY2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVP
X0gyNjRfRU5UUk9QWV9NT0RFOg0KPiA+ICAJCWluc3QtPmVuY19wYXJhbS5lbnRyb3B5X2NvZGlu
Z19tb2RlID0gY3RybC0+dmFsOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICsJY2FzZSBWNEwyX0NJRF9N
UEVHX1ZJREVPX1BSRVBFTkRfU1BTUFBTX1RPX0lEUjoNCj4gPiArCQlpbnN0LT5lbmNfcGFyYW0u
Zm9yY2VkX2lkcl9oZWFkZXJfZW5hYmxlID0gY3RybC0+dmFsOw0KPiA+ICsJCWJyZWFrOw0KPiA+
ICAJY2FzZSBWNEwyX0NJRF9NSU5fQlVGRkVSU19GT1JfT1VUUFVUOg0KPiA+ICAJCWJyZWFrOw0K
PiA+ICAJZGVmYXVsdDoNCj4gPiBAQCAtMTIxOSw2ICsxMjIyLDcgQEAgc3RhdGljIHZvaWQgd2F2
ZTVfc2V0X2VuY19vcGVucGFyYW0oc3RydWN0DQo+IGVuY19vcGVuX3BhcmFtICpvcGVuX3BhcmFt
LA0KPiA+ICAJCWVsc2UNCj4gPiAgCQkJb3Blbl9wYXJhbS0+d2F2ZV9wYXJhbS5pbnRyYV9yZWZy
ZXNoX2FyZyA9IG51bV9jdHVfcm93Ow0KPiA+ICAJfQ0KPiA+ICsJb3Blbl9wYXJhbS0+d2F2ZV9w
YXJhbS5mb3JjZWRfaWRyX2hlYWRlcl9lbmFibGUgPQ0KPiA+ICtpbnB1dC5mb3JjZWRfaWRyX2hl
YWRlcl9lbmFibGU7DQo+IA0KPiBpbiB0aGUgbG9uZyB0ZXJtLCB0aGVyZSBpcyBvbmUgdG9vIG1h
bnkgYWJzdHJhY3Rpb24gaW4gdGhpcyBkcml2ZXIsIHdlIHNob3VsZA0KPiByZW1vdmUgdGhhdC4N
Cj4gDQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IGluaXRpYWxpemVfc2VxdWVuY2Uoc3Ry
dWN0IHZwdV9pbnN0YW5jZSAqaW5zdCkgQEAgLTE3MDIsNg0KPiA+ICsxNzA2LDkgQEAgc3RhdGlj
IGludCB3YXZlNV92cHVfb3Blbl9lbmMoc3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIAkJCSAgMCwg
MSwgMSwgMCk7DQo+ID4gIAl2NGwyX2N0cmxfbmV3X3N0ZCh2NGwyX2N0cmxfaGRsLCAmd2F2ZTVf
dnB1X2VuY19jdHJsX29wcywNCj4gPiAgCQkJICBWNEwyX0NJRF9NSU5fQlVGRkVSU19GT1JfT1VU
UFVULCAxLCAzMiwgMSwgMSk7DQo+ID4gKwl2NGwyX2N0cmxfbmV3X3N0ZCh2NGwyX2N0cmxfaGRs
LCAmd2F2ZTVfdnB1X2VuY19jdHJsX29wcywNCj4gPiArCQkJICBWNEwyX0NJRF9NUEVHX1ZJREVP
X1BSRVBFTkRfU1BTUFBTX1RPX0lEUiwNCj4gPiArCQkJICAwLCAxLCAxLCAwKTsNCj4gPg0KPiA+
ICAJaWYgKHY0bDJfY3RybF9oZGwtPmVycm9yKSB7DQo+ID4gIAkJcmV0ID0gLUVOT0RFVjsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93
YXZlNS12cHVhcGkuaA0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93
YXZlNS93YXZlNS12cHVhcGkuaA0KPiA+IGluZGV4IDM1MmY2ZTkwNGU1MC4uM2FkNjExODU1MGFj
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2
ZTUvd2F2ZTUtdnB1YXBpLmgNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBz
LW1lZGlhL3dhdmU1L3dhdmU1LXZwdWFwaS5oDQo+ID4gQEAgLTU2Niw2ICs1NjYsNyBAQCBzdHJ1
Y3QgZW5jX3dhdmVfcGFyYW0gew0KPiA+ICAJdTMyIGxhbWJkYV9zY2FsaW5nX2VuYWJsZTogMTsg
LyogZW5hYmxlIGxhbWJkYSBzY2FsaW5nIHVzaW5nIGN1c3RvbQ0KPiBHT1AgKi8NCj4gPiAgCXUz
MiB0cmFuc2Zvcm04eDhfZW5hYmxlOiAxOyAvKiBlbmFibGUgOHg4IGludHJhIHByZWRpY3Rpb24g
YW5kIDh4OA0KPiB0cmFuc2Zvcm0gKi8NCj4gPiAgCXUzMiBtYl9sZXZlbF9yY19lbmFibGU6IDE7
IC8qIGVuYWJsZSBNQi1sZXZlbCByYXRlIGNvbnRyb2wgKi8NCj4gPiArCXUzMiBmb3JjZWRfaWRy
X2hlYWRlcl9lbmFibGU6IDE7IC8qIGVuYWJsZSBoZWFkZXIgZW5jb2RpbmcgYmVmb3JlDQo+ID4g
K0lEUiBmcmFtZSAqLw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBlbmNfb3Blbl9wYXJhbSB7
DQo+IA0KPiBXaXRoIHRoZSBzdWdnZXN0ZWQgX1NISUZUIHN1ZmZpeCAob3IgZXF1aXZhbGVudCkg
YWRkZWQuDQo+IA0KPiBSZXZpZXdlZC1ieTogTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZy
ZXNuZUBjb2xsYWJvcmEuY29tPg0KDQo=

