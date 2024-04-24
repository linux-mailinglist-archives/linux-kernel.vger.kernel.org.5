Return-Path: <linux-kernel+bounces-157302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD58B0F83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E15D1F22D74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B616C866;
	Wed, 24 Apr 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="bsmSfAPz"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63216C850;
	Wed, 24 Apr 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975292; cv=fail; b=YKmQMm2eEXongsG7NFTTM2TN5LsN/BDGygc4afHLLPJQvaBjbDWWCbtceth17t9mT6RihLcqOOGVyH0w1Ahsju6VC1WNFklpboBrjTK24sNDwGjVcvPPloz0auF2rS8UB5Jgf90h2Et3vzw6HcmHPrV1Z6etCFBNwcau/Fj38Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975292; c=relaxed/simple;
	bh=um7X7I6R3W5e2ZvJwu7oaTwv9hYRvb6SwE06hoQoAxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g290xuqdIbFnrYJwmNknRAd3D++YKrxaofC/JJuxhue/pmZL5ju3W5tVchw6+cIjWuWGgF5IsiBSd5GC3rUqyMlis/DsBltFPDYdzqFhSwqh1yHG/1GNkb0kLTmROs2Im5Urjfz/1Ss9V3cuzmg+uV549kk0kKNd4dwUz6q9WV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=bsmSfAPz; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OGEZMH006177;
	Wed, 24 Apr 2024 17:14:35 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xnxsfrsv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:14:34 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxHXMC4VFDRFn9S4Vi22nJWd2qPwr9rf6UsukvB/2N4EKSvE9XVzyBdxJy+evis/abrhL2WVIKRT8KGWzWNLw6Fybz+GYHfRfKLjZoP815W2qHvw6k2RUy28MEqzUqwbv6HeVI8ZK+nHqZghoceHRHyIVlemiY5xyjKorHHe5wb0agjKIMpArWJ3852+Serez876TGWYgOgKDNqP7ItjJqo5dAnm1CFzz5puNPDfsEuKX0mbp85WY1tzdW74q8GE22TfbmOBYlyyaZYfleD5Zy+1gXptORzd6eCGtUlX4AtxfdkBTXVNVCi4h4Loz6i2+Iani11WEA1YEW/lcX4jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPqTofm5Vd+xibj/g8rjnY5N0e/30coOqin106+tGoQ=;
 b=ehX1dk8RWUPt9/lHfwaYtMhVcfQXhmJDOe66nLGHXSny/nOSt2wA+m4PAN41ICm20SAZrCNCMd8FC5xHmOB2Kn1Mo5LyEtzFsIRnYMoh4L/sJmNJM9wyh18lozBZ7kJun8efsgUiiZsC3Lgm7QbQMc3svflEjq27AG1p72X0CX8991Z8EQbLF+8N9P15E2StIR9cZJrUyM8nnrTo7laKMflJH62lhlDH2uaQrhMbbd8xT0ThCL+sv9S09mKtQhTUYNvdvAGtq62PUFBFFj+BUIIPdlqOO0FjE04EhgljHSGtpohft40p16z/ftwgABDLRCqhZhQY7D+SVhuFpMf0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPqTofm5Vd+xibj/g8rjnY5N0e/30coOqin106+tGoQ=;
 b=bsmSfAPzZ+IxdX2K2wcG/GvRsSYBkeuv2hCqmxn/KJwuYniEVU4XV5J35oT+jje4PZA0ZNyFhDonADRKND4S2dZ5BIuvkev9ZadgDapZtCdf3lPbWoNrCiBow94fEzi+eLK6nexGeiOhv6qgRXzKp2Ntei1V6Wq+1W+dPvsgxgY=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 16:14:29 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 16:14:28 +0000
Message-ID: <c11194fb-0449-4b36-adf1-c15d7a66344d@blaize.com>
Date: Wed, 24 Apr 2024 17:14:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for
 BLZP1600
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133241.19210-1-nikolaos.pasaloukos@blaize.com>
 <fd4072dc-7cd3-4d13-a15b-d63c675a5994@linaro.org>
Content-Language: en-GB
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <fd4072dc-7cd3-4d13-a15b-d63c675a5994@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PN0PR01MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b3cc8a-7d37-4d91-4d57-08dc64799dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjhsaVVXRmZzOFV6Q2VBbGh0K0poM2JLU21XTzVicjNEZjU2WTQraW1sNjdw?=
 =?utf-8?B?YWlWNm1aYXhqbnd2Q1NwU1RiZ1c5eTVKZFFjY0VaUEhxYzNzWU5oNEpPQUFt?=
 =?utf-8?B?T3pZaW9Ba2VCai83ZlZ3RTV6aXlBK1AwaW9OQWxCRWFYeTNvVVZsWWkvQkpX?=
 =?utf-8?B?Wk91T0hiSEk4ZkNrc0c2NFVEekd0WEpmUDRNR29iSW1UY2VVaytnTnVDSHAx?=
 =?utf-8?B?dVdkVHZ0U2lRRGtwQVRuSENINmVkdUVJNnZCajdzSG94SUlHYUhiWXJrZlVn?=
 =?utf-8?B?ZmxGNmxYL2dRbWZqN2pYaWMzT3R4ejdkZnVod3FnZHkweFBLQVZQclcvdFNQ?=
 =?utf-8?B?TTRpa2RFUGp4QzN0TnlSMU9sZkdERTVxeHlvcmFlc3pYK3VJc2kyNnNYUEJx?=
 =?utf-8?B?anUvalZqVGoxa2pVTUZVK1Y0b3Q0OEhVUThDN1RhckthNDhuaTlwc3hjWTha?=
 =?utf-8?B?eW93UGJBaTV1S2JWc1V1ZjhEbFpXUmh0Mm1tSkpYbjZWdmJoV0R4SlAvd3dZ?=
 =?utf-8?B?RjI4L253c2ZFcE00OFlHYTFOYnlNU0tWS3NxTXJEQm5OY1pqZW9NOHdCWGNJ?=
 =?utf-8?B?QUhkL0dRaGF4ZFBRM1dQZFhtRER2WjNTZXVlSUhkOFhoWUw3cUQ4NGc2Qi85?=
 =?utf-8?B?c0lGZ2ZVYTFVYkQ4L3U0YkR2RDgrRnFuS010TytDZ3E0c3l2UUVWdFNWUGU5?=
 =?utf-8?B?blpBM2xFcC91ekJWTFJiOUhZRTh0Tkh4ZUFnT1dGYlZ2RTcwODd1RDJkYmgv?=
 =?utf-8?B?dGFja1RtZ1JHcXBlRkthNG0rL2pGUDhKT2xVUm1waEkwL05va1EwZUlFa2VS?=
 =?utf-8?B?UVJncXUxTFArNlR6dGVMcDBuN0VhMUhtdTZPWnZsUTRkVFhTRUtnLzZFcHZs?=
 =?utf-8?B?eFVaL2dyWTdjV3lxNVdpMUxLM0xnaWt1anl0MnczamR2bkpVeU5jTEwySWpr?=
 =?utf-8?B?eVBRWWUxUGtUYkdTUWpTSnVXb2loTjFHNDdRMzI2eHlTZDd2aGNwdG1Iejlm?=
 =?utf-8?B?V1NMdTQrZ0NDdVdrY2RDMlB6dENLWW85Zlpyc3Z4eHVyemN3WUYwRXZDOHBm?=
 =?utf-8?B?dXFySEhYUjNtVjdvUEdBamtiNHpkaE5uWFUxT2lIWmpCd1pNNG9nSHNOcWFq?=
 =?utf-8?B?Y29DUElvSnJNcS9DSnZ5cU54VERnWFlzb3pZeHhudE91VlprNlovbU9pMHl0?=
 =?utf-8?B?T0FDR0tZZUxobkgwWkMrSHFmVFpSeXRWeFc0M280YVhxQzBKdVBETm5lYjVF?=
 =?utf-8?B?aHI3ZnRrOEcwWndVcWZNU0RqaGZTU203U1lHMjdPZjg5N1BzSDNzWTkwdXhS?=
 =?utf-8?B?QUIyRzFSbVBxODl1ZWdmY0dIOEJ4bWVBQmp1c011c2tSaStuaG9kMnlMQi9W?=
 =?utf-8?B?SGhZV0NYQWpXUGh2N3RlZW5GdlNpQVFoUUloZlRQekVSaVFYdjVVMkZDL05J?=
 =?utf-8?B?ZUJXRXJWRmlLRm0yb3Z0eFppOFZuZ3JkeFI3SEh0cGp6cUQ1SnZ3c1dnSFcx?=
 =?utf-8?B?Q09WejM5RHpFUFVwU1ZTV1hvd2ltV2lxS0RZY1JyQ3M0YmhpTTFES0JLbi9H?=
 =?utf-8?B?UTFoMXFUY1FzS2VUKzRRUEkvRnU3ejlhZFRxS3JPV0ptRko4UzBCUVE4RUZW?=
 =?utf-8?B?MEU4QmRaT3J4U0NMbjZ1eUJBUGJPVTFnNXpYekw5RzZacTZPWUlTOGFTR2Zo?=
 =?utf-8?B?Njd4dUR2MlJjdHFVVUN2T2k3SnZ5bFBWL2tieGpGelNVbzlZd09KemdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUJYM2s2UnZaNVhrMVprbzgrUWRHRHkzRW9ieEJ5ZDJzWmU2SnNjTzlucVd6?=
 =?utf-8?B?N0pzMll4cWxhSmlFenFXSW55dnluelcvVDk0WHJVQkpWRk5zbzQwRGRsS1Fk?=
 =?utf-8?B?YVd4NTBSbVpFcWFiUnBEWGY0empCZXBiZHZKcWl1aGZPQTA3Nk1UdUN0T1hO?=
 =?utf-8?B?WGNXOGN0YWR2WllVYWcrN3ZHbm9wZExYM3Y0aGwrejBMeld5bnlTNmMwUW9H?=
 =?utf-8?B?ZnhZNmVpcXFUWFVXM1pKL0swY3VFTWtrSC9mU1FGY05UWXRDajNIN240Wk5R?=
 =?utf-8?B?QW0vSk5HdHd4MmQ4NDBiZzJvWmxlK2grdkVsekIzVXBTYUoxVUZnbzgxQXlZ?=
 =?utf-8?B?ZHgwUDk0ZXdxRzRnM3JoSVVkaTVDaTZpU3ZITUU2bi8vL3RMblZxSVRBTFBM?=
 =?utf-8?B?cUNjQmU2dHlXd1puUXpqaGlQdVEzNW9ueWdqZFh4cTA4YVluK0UzUW9TenE1?=
 =?utf-8?B?enVnRDQ2QlBlbS9ITEZUUEZQQTBqbGdEODZVTHRoZER4WEx4ckVCd2ZFNjE3?=
 =?utf-8?B?eDdLenVwZlhHOFRqVTM1Z0ljVDZQSGNaeTZobm1RTGYvSjIyanZUTTlYend0?=
 =?utf-8?B?V1paVzhQTDJRZUlxTTB5aTFITmZHbEx0L2k4WW1RVHU1TkFNQ2xqaGtEOHpY?=
 =?utf-8?B?ekh5QjdUc1NxaXR5N1V5NHdjRHpLTndCbU8yWTR4Qi9NZlplY3k4Ky9Qd1cw?=
 =?utf-8?B?TjkreDJXS2Z0TlZZOTlGSW9mMzJsMzBOc2QyYkhobGRHS0FrM0pZTkpTOEFy?=
 =?utf-8?B?WmVlem42VUhYVXlJelJINTdvbDJYN1ladk1CQW9EYmNYcThLeFIwbEt1S0Fz?=
 =?utf-8?B?d3prOEVHck5mRG12WlA3TmczelZWRmE3QWNzbW5oMVdyZXRGMTdCSVlEMXRq?=
 =?utf-8?B?S1o2c0R5MnhoU3IydHk3R2dNbUZaY2tHQzg5NU1HLzA5dDFNQUR0WUN3WUNl?=
 =?utf-8?B?anVFUmk0ZWdJTi9zN1B0ZkFpUnNYSVhxTEtFWWJCeE9VMmFaRVg5cHIwSU9Z?=
 =?utf-8?B?M1V3a2tUR1hTSVoxMVdTMG5qUlo1UTlxdmZiT0M1aE1mQlRSUjg1eUo1bkdW?=
 =?utf-8?B?UHlhckFkUFVWVllGVzZERlBwM1JPQ2FoSVFLay9MTkpLV3JpbmRLN3pNa2g2?=
 =?utf-8?B?RlhOOE12bHNRRVdTSTNCTlhJRVVDWXBTOTAvL3JDYUNSTC9MV28rc3p4L2o5?=
 =?utf-8?B?ZmIyVUh5R29tb1Y3bkxBWFIxS3NKUHhrM0I3NDZ2YUgwakh1cTM3V0FYV0tV?=
 =?utf-8?B?ZStkSmt0RFlwK3JkM2I2TFNRWWYxeGZLWFVWR3ZTZEpEcTZsdnNUbytLNVI3?=
 =?utf-8?B?OFVmOHdRZ2lmMWdDaytVUWNvd0UvTXA3NTZCZC96R0RNNU03cExZYk1rVjh4?=
 =?utf-8?B?MmVWcUM1eDBNYm9uWnYrdWVjTjlBYjRWZUJwc05OWFNkQ1NHNExudE5xZ3lp?=
 =?utf-8?B?T3NwelZScUZndEtoVWJCSHVUbVRRUE8zNXJCZm5CaGtLQ0VKUytjOWV3T1hz?=
 =?utf-8?B?ODJIV2MxRllUa0VCVHJUQWp6RzYxNUtTSTFyRkhkTVR6eVMwakE4dkdXZU05?=
 =?utf-8?B?ejZ6TnhnK3JVaGdHeGJqWXVWZzhWL0lMMEtEOUR5c2xIeE1JY0hKZW9HdXhy?=
 =?utf-8?B?U1lXODVybG54YU9jVmsvY0dQam5rUm5KV3JpN2NmRFJ3dXBtNXpMRFVRa3Zj?=
 =?utf-8?B?c1RuN2VzZjFlVGNZeXN2aUViYVBHRnZvZ0poWTZIakVlSWc1S3VXdGFNc1JN?=
 =?utf-8?B?MlJ4dXM4Z3JPWlNJbGRxTk5zc1BOQ2tMdXNWQ2RiNzl6d2E3OE0zMDJWSGgx?=
 =?utf-8?B?N2JDUkRSOGsyNXhiZy8vTzFHWndER1oyOU9YTUFnaVd4RGxheDRtWTRiSytC?=
 =?utf-8?B?azRhYm5wRGREbjVxRUROTjVGakp6OG4yWERFUjBsVGd5ekFtQTMvRGlPblh2?=
 =?utf-8?B?VGZnZEtMZFZXNThCdHZIYWdmdE91QmpzNlpWTE50Q0p2RTRXMG50QWpzc1FY?=
 =?utf-8?B?TnZqSEFUdkZCV2hMSGszNllvbG1VWHVlMWc2R3dIejdIcnZpZFdMSEVqcnZr?=
 =?utf-8?B?bkFoK0dRWHpwYXJNaTNoWUhoRUJtVm82VTB4YUtYbm8yQ2JJZ0pYYW9jMGc5?=
 =?utf-8?B?bEVzT1JLZXpZandnbmN1RnNPUTh1akFIV3J6Q1pDVEZseldjYUpjWjdhUDRD?=
 =?utf-8?B?MnlIcFZFY2c1NmxvUzFSSlowdG50OCtqdmFKVW5xaVMrOWd2aFYxdEdQVmNz?=
 =?utf-8?Q?APdWyqmgEjXyaWNGspttO7fJkZSiLm2bvSVJkfpWpg=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b3cc8a-7d37-4d91-4d57-08dc64799dbc
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 16:14:28.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70EKtsorjoB73ABbQVKkOQis74K0LLRupBomM4trruYmcIRgTr3atM8yFGrH4cFN7jsy7Xsegjtnjta9vtibFQ6C3j/Po54m1JkyFnC0e3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7749
X-Proofpoint-GUID: 2dVSPvehlK-UbKppdgQv9AeWVk7oZ0Mi
X-Proofpoint-ORIG-GUID: 2dVSPvehlK-UbKppdgQv9AeWVk7oZ0Mi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxlogscore=982 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2404010002 definitions=main-2404240066

On 24/04/2024 15:13, Krzysztof Kozlowski wrote:
> On 24/04/2024 15:32, Niko Pasaloukos wrote:
>> Add SCMI clock numbers according to the Blaize BLZP1600
>> SoC hardware specifications.
>>
>> Reviewed-by: James Cowgill <james.cowgill@blaize.com>
>> Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
>> Reviewed-by: Neil Jones <neil.jones@blaize.com>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> This goes to the patch introducing binding doc.

Apologies for the broken threading.

>
>> ---
>>  .../dt-bindings/clock/blaize,blzp1600-clk.h   | 77 +++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h
>>
>> diff --git a/include/dt-bindings/clock/blaize,blzp1600-clk.h b/include/dt-bindings/clock/blaize,blzp1600-clk.h
>> new file mode 100644
>> index 000000000000..f1d59849a6e5
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/blaize,blzp1600-clk.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +/*
>> + * Copyright (C) 2023, Blaize, Inc.
>> + */
>> +
>> +#ifndef DT_BINDING_CLK_BLZP1600_H
>> +#define DT_BINDING_CLK_BLZP1600_H
>> +
>> +/* ARM SCMI clocks */
>> +
>> +/* BLZP1600 clock-gate numbers as defined in the hardware architecture */
>> +
>> +#define BLZP1600_CPU_CLK 0
>> +/* clock-gates 1-6 invalid */
> No, they cannot be invalid. IDs start from 0 and are incremented by one.
> If you have holes, it is not a binding.
>
> Drop the header or use it properly, so as virtual IDs.
>
> Best regards,
> Krzysztof
>
My intention was to avoid using magic numbers on the DeviceTree. That's why I added them here.
Also, we have some custom drivers which we plan to upload and their schemas need those files.
The alternative would be to use magic numbers for our clocks and resets.

In the commit message and on the header file I have mentioned that these are numbers matching
the hardware specification (1 to 1) of the chip not just enums.
Some IDs are invalid because of a hardware gap, some others are invalid because the SCMI
service will return an error that the number is invalid.

Is there another way to prevent the magic numbers in the schemas and device-tree.

Thank you very much for your fast and detailed review.

Best regards,
Niko


