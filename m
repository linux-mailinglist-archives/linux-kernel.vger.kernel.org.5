Return-Path: <linux-kernel+bounces-70142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4D8593E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179041C20C38
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6E184D;
	Sun, 18 Feb 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oa+Rhu8o"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CF17F0
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708221264; cv=fail; b=CXghlQZExIbYJ8Bc6ltpw+0/1fNFp14NwNgnthkwU3fT9HuouqKlhLpVzDfrGMmwTxH3KAhzoGoCBQkF75PC0JhNE4QjRME7kCbMWZpYM4uAxtD5mPCzGf/c6xqHjPHKiyrcKY8kWqOcw/m1+ze6nxXTVa8kLp6gvLgHI78Jke0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708221264; c=relaxed/simple;
	bh=fc6zqC/rPip0xDZb2MSkTVZUPhCe5ckC24z8r6TLEyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JG5TnLFK4Y3N2VG+2FdlmYK6lLWWV+hDPNQVErseTC275Sn62afelrE3YCE91BiKPSIy3pb60wLjhRL01Hwvh55hxf5ysWRaGYWEYBYHZxCAd4LvRkEiuOfBRYzyRzTWnxRV7nuXJmb+2/+EFvy0gM1nq/WDr0ZHRoDTqD+1zqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oa+Rhu8o; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1708221261; x=1739757261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fc6zqC/rPip0xDZb2MSkTVZUPhCe5ckC24z8r6TLEyc=;
  b=oa+Rhu8o4+RWp2bfyDpNZloJd8Z2RhRoz7L5ClNLHuaHpf6+GHI3xQ3H
   /G4STawhTAp5qnrZOpY9rLjX01Clg1bjvkPHkv5yH/s1M8PqcJFcOojlS
   bpyi+mTOqFnRC25j1asPZQy+qrGbPLj5WDBnE6cwyDLc0HW6t7zi4/gEr
   p+QPHMzZvATJ3QUE6ph29uMqd9V1BBuVYapCCkklbavH3FIOf93gB9r7A
   ub4SZN03Aw2Zo6UfzV54nwNjpeR38kZVTbObichGthmrF2kNHPCd1GNzK
   KVtnU+L3dctjSqDvmDGJmZnNfqgjPAR1ihPdf9ha/tReF6BjH9uhFHato
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="111037885"
X-IronPort-AV: E=Sophos;i="6.06,167,1705330800"; 
   d="scan'208";a="111037885"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 10:53:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7Rvyec2S1iQKh+bMc52KHjuCS0zGi4JnBTCqN48pjzyAZpANjak8JOElN9Rnlu6niEsBU/zaFKxvJK+dauaU+SoR9Hm9tOMhX8GRdskTm1+4xbhPQkJb3gBLTFMRuxmoYFPNiESgoQr4g+lQEU/GY+q6Spa93m+0bYJ3Uv5IsVN+sseVmF2RUbCQiSLKa8PhimEFP7CaTj4NBr8/v4DjkVDs8IjrRac9PwTtcIRf3z2lM6M4FbFIkaZRDQ4j66BooBU2SwS83/7mckjObi+a6cRoGpArU0e6JV+7a005kHcKddnp2sZ4IBiMaArAvgq4e5TOGmsRl45MkJ17gXxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc6zqC/rPip0xDZb2MSkTVZUPhCe5ckC24z8r6TLEyc=;
 b=LzUiOWgWQ+xHzu7TPBsYsrdG0GtWZ9PonXLB4QoirY4/oS2XWgFuFtvYtmcPy1hSjgy3keLzdPlbfwYIlrVrPciVIoBNbToVrCSaPwKdeDSOlTtJ0yRhkqXHXQX3NfRUll+48+1Dawaq4ly1zq36pAc3+2TR56OC5Qc1HIsNg7Ab/C8FoXvTLrI+u4ep1fxvbMjtSlb4Xfx5hyYEcRzL6qcfEHy/P2B66jEMFdmOaCctgJBSPkFj3EHNaxS4O1Sxpr1HBhrjrh7Jz/6PIBFCGjTQ9drtZ7/uOUn4abPgkaEDs7wfpf4vIQQS3ApNLSVvVlPg1OsCnEYdb4se7n1XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by TYWPR01MB12073.jpnprd01.prod.outlook.com (2603:1096:400:447::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 01:53:05 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2%5]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 01:53:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [PATCH] coccinelle: device_attr_show: Remove useless expression
 STR
Thread-Topic: [PATCH] coccinelle: device_attr_show: Remove useless expression
 STR
Thread-Index: AQHaTOMDSY8x5dmVmkqPf8bcr5UoI7DlYBcAgCogVoA=
Date: Sun, 18 Feb 2024 01:53:05 +0000
Message-ID: <c09f0536-5489-4ee6-8ba9-eea82376d234@fujitsu.com>
References: <20240122032800.33026-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401220729490.3204@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401220729490.3204@hadrien>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|TYWPR01MB12073:EE_
x-ms-office365-filtering-correlation-id: 55d82cfc-8d10-4553-80ab-08dc30245942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y3XKtrcTn8mrIizrqeNx3Aaf93GAIbla8caCrNsqe0vWNAg/K9FnNLZwVp5fKXd9t4Sk76g5daXkAv4rIpjT4+ZIJ2GBS5qEx/OWg+JKmswtQWkqDiHIPfZ0LTuA4NGapIlbMGSaJoRUgelHbfHGMfYD/g4N7wDw2XMN6kttn0nh2yuFRWzH/tX7MMEQVo1MpYEDQoKmiYQxL2qAi460dLyTRbr84UqNsuIfQmN84M8tcpUFGQ7vcCPWiZhU3n7FGu6nw/SO4QIUbcx9BuvHrq96gXdX17oM4uQZktewQ1ggF+KOzDtCfVaAdUzEXimpAhINAaeAkHid59UNDyg4K7xxIPgDH9Q0JPN3Bu5onvAPeXngLWqz7ScvhfHZOkyVa/5fTVrn0jo8ebTeFpg7k4nX5fDt0psTQU6t7VTXFgbVZuQBwuh/8BbDea5wAZs0H5g6+8yTGPuCkq/rZXxa9XY88wGpH7zXE0Qwir3qf+I2ylBwnC4vrntjWJGGmTo9I3r5+Qe6yxBN1My+MiR1ADKUOdWFx/BvEuo7UPPAs54BF73yIRxD724mGiERNgLLfDzuQhemp6f8gc12TfRZ7ffhH8o0OSfBdxqvkszCL7FoOvld9L5I6tvrnbmHxAm3PUH52jK/Rk96yXeXLLZWKA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1905.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(230273577357003)(1800799012)(64100799003)(1590799021)(186009)(451199024)(31686004)(54906003)(6916009)(316002)(41300700001)(1580799018)(2906002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(5660300002)(4326008)(8676002)(8936002)(83380400001)(86362001)(31696002)(71200400001)(6486002)(478600001)(6512007)(26005)(38070700009)(85182001)(53546011)(6506007)(36756003)(38100700002)(2616005)(82960400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnMvbUFwVDMrak9QSUJ1TjZkUkJqclpEN0phMmhySlNoMFgrRVdQbWdoSUMy?=
 =?utf-8?B?K1VJNXZIOFZ5OWNJY0cwK1FTQU90T1NGNDZVd1hCNk5GUW1ZSlBxWEJ0c3hu?=
 =?utf-8?B?SmVDdzBEUGppdm1jWnhqcTJwZDFQMWVjYUsyYjNjbk5ZRUIwSGxaY0VwZEpW?=
 =?utf-8?B?TmhCaHZVdm9sTlNldVk2aHJtNldmL1VacDFrdkZOMjlMaEltbldueEY4K0Ja?=
 =?utf-8?B?RC9sWlZxTmhmdFloS2lTcTN3OVVhQnVEbTRZZGJ5UCt1RkoxcXR4M0l6d1U1?=
 =?utf-8?B?cExJeGN4TDVpc3pBaDVtZzRHTUJUb2RzTWtlZzdTNi8wdkNYTXZ3U2l2b0tM?=
 =?utf-8?B?RGZCR0tVQThpdnFQQ09waTFocXlZakFWSUY3NHVkMUdvOEUzUno1VTQ4dFBx?=
 =?utf-8?B?SlZMYnFCa2FMZ0FhdWNMcG11OXN2UFNTSU9lN2todk00NzVhWFdyazhqVUFY?=
 =?utf-8?B?S3BpMGlCUXVlNXVkMDVwUXJjTlVhYVEyNHIvL0twVWU4UStZeTdLd3NtK2o4?=
 =?utf-8?B?cTJKa1V0TWppSEs2eEZBeDZzbWwwRHNlYWxPelZ0OWRrdzNBeFpoNVp4VDBj?=
 =?utf-8?B?bVBpMEwycnNESzJPSnV3aThRRzEzbW5qMWZhNmZLcnNUcFBKWGxWSkF1WHBU?=
 =?utf-8?B?RmYxazRManR1cnRnTXhmTnQ2S2UrUXRuMmVGNnM1RTN6QzBUbFM4NGs1S0Fp?=
 =?utf-8?B?bG05ckRsVVN1T1h2dVhVRGZBNjNlN2w3QnlQcGE4T3JvL2s0VHg5UDdhZ3Bo?=
 =?utf-8?B?b1dvb3orak51ZDZNWkZUS0lWNWxmaGlScXp4UVFObWZOMmpiY2k5S1B1QXRD?=
 =?utf-8?B?cWNDNGhDbkRZZ01mUWJ5dlJ0bkx1RVFmc2Npa0J3aU50WS8vWnQ4cHAzWU9J?=
 =?utf-8?B?dDU0RFR3czFxTHNnTFhGeVhCVSttNmMxSW51VUlpN1QwSkVpNWlVMi9ROFFD?=
 =?utf-8?B?c09sSnF2WWU3blFENTQwZUhRaC9KejVLQytRVm1vaVJUMXhhWFZkYkloaFJt?=
 =?utf-8?B?MnMyaFprV1hmSFJWdC90WDFrSm5SRmpkNHdhdENndWRPS3JoN0kyNUF3VzF0?=
 =?utf-8?B?ejQ5UnlzQ2x3TU5QSEprR255MWFJamtaeVV0VjM4Mnl0dVNDSnBjSHlOd0RB?=
 =?utf-8?B?Qnhaa0NRa281cjhLdk9Qd01xL0xIMTlVLyt3UU12YnYvS21yTitwWE9zeitJ?=
 =?utf-8?B?VHZ2aTVCVGtiYTdndENEbEdEV3ZVSW13dWEvNGg4cTFDNk1GWkN4a1hpUE8v?=
 =?utf-8?B?OXBxQnFxVUFFVEpiR0tqOXdWMyswRWtXaDMxYTIyenZFdHRMV0ZRdHlSbUtE?=
 =?utf-8?B?aUNYNElkRnBKMFl1VCtiaWlGQjcvZTRZQVZiUWxKRFVKL3JGZUhKZ3Z6bGQv?=
 =?utf-8?B?M1VmUFNnSzkrYWp0MnpkQWxlc2VoM3MrY3ZJVDFYaFh4QllPM0owZ091dDFu?=
 =?utf-8?B?WC9HanMyQVRyR3g5a3B1cDNPbFJORkpnVTNwRW56eExRRnNodXo2V2hjVEll?=
 =?utf-8?B?RUg0Q1g1N2c3NlZEMWgyZUpDb0lCb21yN1ZFRWxsWktySzZMd3EzanpUR2Vy?=
 =?utf-8?B?Z0ZOdnlYWkUrQm9hSG5vS3oyK0lENHJiSEU5ZDZrbXY4ekExWUZ1dkNvdytY?=
 =?utf-8?B?bHZYa2xZem95dkNhemhwbXB1WjNsemgwSVlSN2RwaHNrajNCc2x3NlJBVXFT?=
 =?utf-8?B?WVdCOE9Uc1VRYmNER3hBNUh1Y3BwK2NjVkpEMHFJNm50c3hOV3VJZ09HaWdQ?=
 =?utf-8?B?SlFlMnBtemVlb2NmbGc5eHgxNHhGZWg3TDZZb09NOUVFZGhsdFRTaWRGQ09w?=
 =?utf-8?B?Z0tJTEdLV293VWF3dTliVm1rRzF4cGJSaEp4RExSS0IrL2EyME9NN29KNHVU?=
 =?utf-8?B?MFl3bjRXc3JxK0NqUmtBVTZaRDZtU2h5R204SzR5bDQ3TlA4dEQrNXhNOEQr?=
 =?utf-8?B?aldFVTZaN2xXa08zUmJDVTE3eWI2K0tXU2NnNFJ5akxMdWNkKzF2U1RTMEls?=
 =?utf-8?B?OVdFQkxWekJJdHNFQzBUNVhGa21vNTk5cUhFNzkxa2J4MjdSait4MEUxZy9R?=
 =?utf-8?B?NHJ0VzNxREc3YVAvVDg1YitzTVZFOWcwV25wTHFyQThnRHhCazAzL0d5eGZy?=
 =?utf-8?B?b3J0NUJRMHY5bG00YU5aS2tJcHlvM0dQVGFYcmtZZllSeTdTWGhZSzVwZGNx?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E3D44C739B63F479B180E29B22E75C6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nFvxPO/C/SF3+TS37Ut2OVTAjmZ2tMVWbW9KNeNHWYwr3p0IqDLNjgma9vxLhfGC8uIy7CjPQ9fGVDPfnACbOQ/OdkcK8R9Xg1P6VpV8og0AotCWAgWX58z8aNJF4K9Lzq0MdwGO1yInR3vxy8LT6I/2vX87ySF16jR7XjuG4CubB/CnAGtwrX4oEARwuWWpjxO/qAxD89mj3qPAE5HPpgwV1FbVkTcrmBga+UG2SW1poJpO2jO/8OAPPlHmqWQGPZ30WPUBKv2xoe8soaP+6JNPcFUlS5r2zUAYjrF/+ebPGx5BMm4GLTKusiimrK9IxYo6jiuBW0uiMt+XHbWjZ7wcXnBM1xTfShcVBGATCTNoBNlXTmPZARutbCbiqGaxJ0wTPodh90LAbuM/Mi7Dq37DSO41aQ+NXI2byiGk38QiPS79wsbmwpSIYXviD6/WDUiZrm+8ZAa0qYyUVM5tkE/hsGPWLYbCt3d8unc5DSaB5AuCSuCRJ1ZshBVjWEgo4pUTwoEkhrEwc8sWQ2OCLOjUJjDgL+HYa9xsw9/JL6aTYIH8+HOU7a8qiXWYxToV6eJIhXejyY8MxR/3pFwiuYjsV7Ap4eoennmrRxRpPVab9aTTiVjJEdV0Zm5XZPOA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d82cfc-8d10-4553-80ab-08dc30245942
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 01:53:05.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4EnkhSvVRPey2ozSn2Js+btJpUanu0OVkynA4wV4Jfy9ZWvu8J1rFv93VVivhRNicJY91nH+NBfga3k/PjTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12073

SnVsaWEsDQoNCkkgd291bGQgbGlrZSB0byBnZW50bHkgcmVtaW5kIHRoYXQgd2Ugc2hvdWxkIGNv
bnNpZGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggdG8gdjYuOA0KYmVjYXVzZSBpdCBhbHNvIGhlbHBz
IHRvIGZpeCB0aGUgbmV3bHkgaW50cm9kdWNlZCBjb2NjaWNoZWNrIHdhcm5pbmcgaW4gdjYuOC1y
YzENCg0KPiAvdXNyL2Jpbi9zcGF0Y2ggLUQgcGF0Y2ggLS12ZXJ5LXF1aWV0IC0tY29jY2ktZmls
ZSBzY3JpcHRzL2NvY2NpbmVsbGUvYXBpL2RldmljZV9hdHRyX3Nob3cuY29jY2kgLS1uby1pbmNs
dWRlcyAtLWluY2x1ZGUtaGVhZGVycyAtLXBhdGNoIC4gLS1kaXIgYXJjaC94ODYvZXZlbnRzL2lu
dGVsIC1JIC4vYXJjaC94ODYvaW5jbHVkZSAtSSAuL2FyY2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVk
IC1JIC4vaW5jbHUNCmRlIC1JIC4vYXJjaC94ODYvaW5jbHVkZS91YXBpIC1JIC4vYXJjaC94ODYv
aW5jbHVkZS9nZW5lcmF0ZWQvdWFwaSAtSSAuL2luY2x1ZGUvdWFwaSAtSSAuL2luY2x1ZGUvZ2Vu
ZXJhdGVkL3VhcGkgLS1pbmNsdWRlIC4vaW5jbHVkZS9saW51eC9jb21waWxlci12ZXJzaW9uLmgg
LS1pbmNsdWRlIC4vaW5jbHVkZS9saW51eC9rY29uZmlnLmggLS1qb2JzIDQgLS1jaHVua3NpemUg
MQ0Kd2FybmluZzogcnA6IG1ldGF2YXJpYWJsZSBTVFIgbm90IHVzZWQgaW4gdGhlIC0gb3IgY29u
dGV4dCBjb2RlICA8PDwgbmV3IHdhcm5pbmcNCjYgZmlsZXMgbWF0Y2gNCg0KVGhhbmtzDQpaaGlq
aWFuDQoNCg0KT24gMjIvMDEvMjAyNCAxNDozMywgSnVsaWEgTGF3YWxsIHdyb3RlOg0KPiANCj4g
DQo+IE9uIE1vbiwgMjIgSmFuIDIwMjQsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPj4gQ29tbWl0
IGZmODJlODRlODBmYyAoImNvY2NpbmVsbGU6IGRldmljZV9hdHRyX3Nob3c6IHNpbXBsaWZ5IHBh
dGNoIGNhc2UiKQ0KPj4gc2ltcGxpZmllcyB0aGUgcGF0Y2ggY2FzZSwgYXMgYSByZXN1bHQsIFNU
UiBpcyBubyBsb25nZXIgbmVlZGVkLg0KPiANCj4gT29wcywgeWVhaC4uLg0KPiANCj4gdGhhbmtz
LA0KPiBqdWxpYQ0KPiANCj4+DQo+PiBDQzogSnVsaWEgTGF3YWxsIDxKdWxpYS5MYXdhbGxAaW5y
aWEuZnI+DQo+PiBDQzogTmljb2xhcyBQYWxpeCA8bmljb2xhcy5wYWxpeEBpbWFnLmZyPg0KPj4g
Q0M6IGNvY2NpQGlucmlhLmZyDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZp
Y2VfYXR0cl9zaG93LmNvY2NpIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jb2NjaW5l
bGxlL2FwaS9kZXZpY2VfYXR0cl9zaG93LmNvY2NpIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9k
ZXZpY2VfYXR0cl9zaG93LmNvY2NpDQo+PiBpbmRleCA1NTBkMWQyZmMwMmEuLmRmY2Y5MzA0MTk1
ZiAxMDA2NDQNCj4+IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hv
dy5jb2NjaQ0KPj4gKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZpY2VfYXR0cl9zaG93
LmNvY2NpDQo+PiBAQCAtMjgsNyArMjgsNyBAQCBzc2l6ZV90IHNob3coc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPj4NCj4+ICAg
QHJwIGRlcGVuZHMgb24gcGF0Y2hADQo+PiAgIGlkZW50aWZpZXIgc2hvdywgZGV2LCBhdHRyLCBi
dWY7DQo+PiAtZXhwcmVzc2lvbiBCVUYsIFNaLCBGT1JNQVQsIFNUUjsNCj4+ICtleHByZXNzaW9u
IEJVRiwgU1osIEZPUk1BVDsNCj4+ICAgQEANCj4+DQo+PiAgIHNzaXplX3Qgc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+
PiAtLQ0KPj4gMi4yOS4yDQo+Pg0KPj4=

