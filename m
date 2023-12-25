Return-Path: <linux-kernel+bounces-11019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15881E022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354A0282133
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5E52F9A;
	Mon, 25 Dec 2023 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="k4bJpEMs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740E524BD;
	Mon, 25 Dec 2023 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYx4NuAc7XhQ97gBxeJHkX471JybGGJfV9KCCux9Psqql6FXxXdnTQmP61v0MhsVLoFx2QjqUDOijHrTQeF621s1uXGFfczCwNlrU5JRKChOK7TWxoY/o0KrEEqNmn1oAGTTeiyRVj5JrawryUviUPl2ugpRd5jrBVhmIxTjy8gOFdL5OkmLzlILpnW3be18Ji/DIP1VNE/6Y9deHNxfHnPX21fBFeWeWpXwzheuWJwz0bkiFr5rWViRKWGo/wDaV84FZ74iBgLssgKj9DLK4WvISrUk3UHdYcQimVxrnnj8N6BDJvCd0keu13qijj0biP+j/mTd3RyUvQcBwnpTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPnBAB65jmBQDLunpS8k5O/cIgfIkQi5kIiRI2Szkg4=;
 b=C38aQgxrguska+PIS31RCMq8xo/e6B4gcD7K2L61VXDreLMpI7oq7t/woB9m0Y6PKY0zhL7c1Y8W8GQwdA/YhU4AeBFNIBGh/gt2fvLX8RKNsRvQ1voh/XT13qzfQFe8+27aIQn82rU7tONfy9WCP3HLTJn6SWxzu2lZDMyD+XACvAoDyJS6gaCu2hl4vRBj7HZzjVS3gWeIUwq+MVlpKqA0uEfCsMqw122Z0moUvx6Kr+FDMPKogHvKEPaB46kufcWxHHNnDrnilfWBuFcjdPsz5xumPRxt8Bcdui7Mi46Jz8P6XNqMAyQSEuf5xKm3AtmkFunwRC9XHiwxmHWXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPnBAB65jmBQDLunpS8k5O/cIgfIkQi5kIiRI2Szkg4=;
 b=k4bJpEMsad4dfxfCn2W6zYW1XUkw39AWvj2SzUvgJe4U5cyRbXaC6er9EuMsg2FmuJ072bqF1/1SAE6KM3ljI5ZAtffuESWe6Ibh4F9Xzl1+4vktxkTgbzg9/mVlEk5+KNSUZ521bQmg4AmUvCL4tEBFnItdy00h2mAyxtpqMKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2061.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:55 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:55 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	cniedermaier@dh-electronics.com,
	hugo@hugovil.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date: Mon, 25 Dec 2023 12:35:21 +0100
Message-ID: <20231225113524.8800-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2061:EE_
X-MS-Office365-Filtering-Correlation-Id: 365e86ba-c222-4353-5610-08dc053da7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PlB/dzJlVsp6kOYONNs5G8rQy3E0bfSyqbZZ/KLqsUHyxFFufMIf2ge/bOVIp6BjLChBPnWI6E/0ipd9eGbvimehEi8a25QbhV75UcA9URQL0JjS+MplZcNkaAVlFiStyArm8n0ZulPL4z/dBvl4VWikTAVKFoIVMbp4libo/c3QOhqZAM8RqO+cnyBjeqZUdAM0jcpSR+UrB8C3TjH/tvvzyfvgONTekMitEx+iOIW/UuHfE1NGIu5kGrFkfvudeNtfU09Reii5G0sXfW70FkXqpLrja9XIOI0qVSevT+FZjJndw1u8UMph7TLweysN0cAm/CKZwom3246U4TQp2NEkNA+p/hZNu9kqzJIT0gaOE8ulzK8nZCxdizE1hy0cjLMf3dEKtsIlbUO2RVXLSlvLHPDBRCOxU2ZxXcmYm7XusOlAZBVS+fYDHYY7XPupadB2DA6HWx2plTjnBcbsofRGBGduIsbedJgY/O632lGHAXHl7o+ERCGw6HYwdok/ZqwR7zBlB/LBydj5BTpF7ANj0IIQ+unxi/UBaTdDA1VFpoNP+n0oaEkCqOi6k5fz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6666004)(6486002)(478600001)(2906002)(8676002)(8936002)(5660300002)(36756003)(7416002)(52116002)(6512007)(6506007)(66556008)(66476007)(4326008)(66946007)(316002)(83380400001)(86362001)(1076003)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXk3US9mVkFQbGlUOCtSY1dROWZzbkNsTktBZitGNm9QOURPMWozd2dvdEpV?=
 =?utf-8?B?cEVKNjBlbElCclhqK24wU2ZEZk5EbE1TNzhlajhpU0o0bUdDM0hTekR3bElS?=
 =?utf-8?B?VXJidlVHQjQva1gwdGhHZkNaNUV1VHVHUGtzN0dWbkJwTU9CSjljQUhydnk5?=
 =?utf-8?B?MTk5WllDU2hIeFAybnVRTXlHYWRmQllrSzdvank5Q3phZFMvM1Y0d2JrTDhT?=
 =?utf-8?B?WXdIcTA5K2cyY0FyUHlTR21PUGJrS0g5aDJ5MlI5eXYxSWRUTmQrWTZ6Z2Rt?=
 =?utf-8?B?S3lBZ1NOUk9CZFB5OUlnSm1sRk43Q2s1em4xbDJzRTE0TzZRRGRCSmRBbUpP?=
 =?utf-8?B?a2pYZ1dYMUZEcFpKK2pRM0huNDhrZGNIbnFFc2tQYVZmMjMzai9rV0E5ZzUy?=
 =?utf-8?B?WWg4bjhqb2hqVmxONWhhK0Z0WXZ4TVRnRCtiemRsSG5pS2NycG9uVStDZ3JH?=
 =?utf-8?B?dWRmT0Vkanl3eWJpQktwVVM4eU5PU3dzZWhMNFJJd1Vpa0JjdVBEcUVrbzJ2?=
 =?utf-8?B?OUtsSnM1SVkrZTdmQWQ2Sk1zMG5kV2xGellUS1NSVWFUTjRSeFVSMWJhL2VR?=
 =?utf-8?B?NERpREdvQjViQVJqNFVDcjg4amRhQUVIL3lPR0JsVGVTaG12R0h1K0hWRVVZ?=
 =?utf-8?B?TzgwclhvTXNWaFRmZGEvcHZRR2lkbGhoTEFmendnVGxGYkdyTHUrNWs3OTZZ?=
 =?utf-8?B?SzBSSzA4OTdFc0w2MkJ0YXlSeU96ZUh3cjh2YWJWRW9uWmhnMkhicDNXYjJL?=
 =?utf-8?B?elo4emUxYnBOa21Gb0o5OVh1bXFDWU9zVEp4dURCVzN3QnBBVUtKam0yN25x?=
 =?utf-8?B?VFkrUFpwWVZXM1dSYkV2WklCTUFLWmxSdE0xS1dRWW5hTmM3bEJJNWFycWgx?=
 =?utf-8?B?Nmw2OFE5Y0l0VDAyeE82NkQzbWFVUzZMQUdacTkvcWFuczZJaDhjQXlEekVh?=
 =?utf-8?B?NGpHV2gva3lHbG1PUEI3NFkwaS9sMjl5Rm5WdVRVQjVNMG50TjMydTlwMTQ4?=
 =?utf-8?B?UWxISG9JbDB3T1c5UjJVOU9oTGFKcjVseXZwRWlmM1MybGRyWnVtaFRDZndQ?=
 =?utf-8?B?Ni8wTjBONVQ4c2g1dFd2UmRBR21PYU4yc1Y4UGJMeE9xbFpWOVZqRVptdEVE?=
 =?utf-8?B?RnpXdzFwWWhJUjZVUzVlQ1R0SjZsMmExZDVpL2xUeFZUSGZnNFpsSVZhd2s3?=
 =?utf-8?B?OGgyMWR1TEhEOWhqOU9ldDBWTm5QbjIxSUdZVndMcjN0amdLais3Yk5OV1N2?=
 =?utf-8?B?VC9rSnhRZ2diWWpJL3J2bGExN3VxaEFuaXYyNXRIem45d3JCNXJaVVBvNkxk?=
 =?utf-8?B?Qi85Q3RJSUZBbGFsc1Zkc3NOMmNGelZXN2RDNU9oSmxwajFKWHJxMHhld3Nz?=
 =?utf-8?B?dkJ4KzJ0Y0VwKzVHalFpTmJ6VzFUSWdIR25wd3ZudFE5L3ZxcldEZUhlOXRV?=
 =?utf-8?B?UDNqK0k1d21wOFZGNGhtODZ3TzkvRHZWcEw5UEZZUEdPTlFCTnF0MVphbWxL?=
 =?utf-8?B?MHZrRHIxejlKZmMrQ05weHhPVVhDckxyTjBoODRpUVU3WmNmdk8zV0RXVjJS?=
 =?utf-8?B?T0RZYllibHN3N2VlY1htaWs2VndYOUQ1cW1wWGYzVzlvQWJNSVZZUDBPcFE2?=
 =?utf-8?B?N24vUXJiRGh1bWgydzNySW0wOFRyNkFqNUR1eHRKOFAwRThvSE9EdWF4TllW?=
 =?utf-8?B?VllPWGFPU0JobXFrZ2xESDFkZm9qL2o2SmdnbG82cFRCQnFvV1lNcEpmbzJx?=
 =?utf-8?B?Wmg4ZTNWeThvUGJNeVRHNnpGYVc3TENsWkROT3U5RXpPSUU1YndsWlE3MXR2?=
 =?utf-8?B?WWRQRHlHa3NNNkRWSjdLMlpEN3lZN2JIcHI4Y0VibDI1bDFWb3RtTnh4WTZt?=
 =?utf-8?B?dFRxUkI2dGs0VDZ1VnZGUkk0bXZiZ2JYckJaRVhOK2UxbTYxMXNwNi9NckNQ?=
 =?utf-8?B?TWRjUi94Z2tLcVdGaXhJOWtkSlRiVWRVaHFmZ0E3TUJyT1VuQ1NGK0U5MUJR?=
 =?utf-8?B?OWVsSG55L2xBdjIycnMxVm9ocExaVnZSWTg3ZTRNMi9vYlRod2JXRGRmbFU0?=
 =?utf-8?B?UG9LZkRzQTN4L0sxcFE3bUMxdkhMK0VFc08rcmtWd3pKYkh0UzRKdFVtRHZq?=
 =?utf-8?B?S3RGM3lad2M3bmNmMFZlQngwWmVBOEYreU9IaXJobDgyYTJHQkh0OXRpb2pL?=
 =?utf-8?Q?/96GvFTppJQ0qABUwN8AC75RZfNaaOfejgOh28yRZcvZ?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365e86ba-c222-4353-5610-08dc053da7b2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:54.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhmUu6DHwmQHVNngcV4n3xhznAqp1Q5Bk9kRjuwGv5btj9ceEsJJW/mOvbKp1PFuFDHAMEXzcWum694+s627Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgbnVsbGlmaWVzIHRoZSBw
b3J0cwpyczQ4NV9zdXBwb3J0ZWQgc3RydWN0dXJlLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFydF9n
ZXRfcnM0ODVfbW9kZSgpIHdoaWNoCm1heSBzZXQgdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBuZXZl
cnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJTNDg1
IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRlZCBp
biB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBieSBi
YWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJMRUQK
ZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEgY2hl
Y2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJpdmVy
LCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFNvIHJlbW92ZSB0
aGlzIGNoZWNrLgoKRnVydGhlcm1vcmUgdGhlIGV4cGxpY2l0IG51bGxpZmNhdGlvbiBvZiByczQ4
NV9zdXBwb3J0ZWQgaXMgbm90IG5lZWRlZCwKc2luY2UgdGhlIG1lbW9yeSBoYXMgYWxyZWFkeSBi
ZWVuIHNldCB0byB6ZXJvcyBhdCBhbGxvY2F0aW9uLiBTbyByZW1vdmUKdGhpcywgdG9vLgoKRml4
ZXM6IDAwZDdhMDBlMmE2ZiAoInNlcmlhbDogaW14OiBGaWxsIGluIHJzNDg1X3N1cHBvcnRlZCIp
CkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEgSGF1ZXIgPHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClN1Z2dlc3Rl
ZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8IDcgLS0tLS0tLQogZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDljZmZlYjIzMTEyYi4u
MTk4Y2U3ZTdiYzhiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0yMjA2LDcgKzIyMDYsNiBAQCBzdGF0aWMgZW51
bSBocnRpbWVyX3Jlc3RhcnQgaW14X3RyaWdnZXJfc3RvcF90eChzdHJ1Y3QgaHJ0aW1lciAqdCkK
IAlyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7CiB9CiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Vy
aWFsX3JzNDg1IGlteF9ub19yczQ4NSA9IHt9OwkvKiBObyBSUzQ4NSBpZiBubyBSVFMgKi8KIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlteF9yczQ4NV9zdXBwb3J0ZWQgPSB7CiAJ
LmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUQgfCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgfCBTRVJf
UlM0ODVfUlRTX0FGVEVSX1NFTkQgfAogCQkgU0VSX1JTNDg1X1JYX0RVUklOR19UWCwKQEAgLTIy
OTAsOCArMjI4OSw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKIAkvKiBSVFMgaXMgcmVxdWlyZWQgdG8gY29udHJvbCB0aGUgUlM0ODUg
dHJhbnNtaXR0ZXIgKi8KIAlpZiAoc3BvcnQtPmhhdmVfcnRzY3RzIHx8IHNwb3J0LT5oYXZlX3J0
c2dwaW8pCiAJCXNwb3J0LT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IGlteF9yczQ4NV9zdXBwb3J0
ZWQ7Ci0JZWxzZQotCQlzcG9ydC0+cG9ydC5yczQ4NV9zdXBwb3J0ZWQgPSBpbXhfbm9fcnM0ODU7
CiAJc3BvcnQtPnBvcnQuZmxhZ3MgPSBVUEZfQk9PVF9BVVRPQ09ORjsKIAl0aW1lcl9zZXR1cCgm
c3BvcnQtPnRpbWVyLCBpbXhfdWFydF90aW1lb3V0LCAwKTsKIApAQCAtMjMyOCwxMCArMjMyNSw2
IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlpZiAoc3BvcnQtPnBvcnQucnM0ODUuZmxhZ3MgJiBT
RVJfUlM0ODVfRU5BQkxFRCAmJgotCSAgICAoIXNwb3J0LT5oYXZlX3J0c2N0cyAmJiAhc3BvcnQt
PmhhdmVfcnRzZ3BpbykpCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIFJUUyBjb250cm9sLCBk
aXNhYmxpbmcgcnM0ODVcbiIpOwotCiAJLyoKIAkgKiBJZiB1c2luZyB0aGUgaS5NWCBVQVJUIFJU
Uy9DVFMgY29udHJvbCB0aGVuIHRoZSBSVFMgKENUU19CKQogCSAqIHNpZ25hbCBjYW5ub3QgYmUg
c2V0IGxvdyBkdXJpbmcgdHJhbnNtaXNzaW9uIGluIGNhc2UgdGhlCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jCmluZGV4IDI4YmNiYzY4NmM2Ny4uOTNlNGUxNjkzNjAxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwpAQCAtMzYwMCw2ICszNjAwLDkgQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21vZGUo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAl1MzIgcnM0ODVfZGVsYXlbMl07CiAJaW50IHJldDsK
IAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVE
KSkKKwkJcmV0dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXko
ZGV2LCAicnM0ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxheSwgMik7CiAJaWYg
KCFyZXQpIHsKLS0gCjIuNDMuMAoK

