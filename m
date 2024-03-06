Return-Path: <linux-kernel+bounces-93287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B9872D86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD30DB2298C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAFE14A8B;
	Wed,  6 Mar 2024 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gTBIffop";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vxXERetH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9B14263;
	Wed,  6 Mar 2024 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695786; cv=fail; b=gUy/n4zfDzclt8x4zlWRowfVOyPlwhu2P2ckddwy786IX49kJvE6/nOGT68IouQkiQ43TsIFLCP4rhibz/nd7dkFsar0cJvgh/CaNh2ftWYRfr/YXdFss3SPRkU4onDcBTiMfxmlCudc/gJo10UvjA9yEBK8n0uzK9Ys/ysfjdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695786; c=relaxed/simple;
	bh=cCtyBKWyyvU6aOMLUwJ6PiqQWA6r0DWl/OLXst3/ews=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ffgj6TyyV2y21dAHC/ZDUIxUSxcTTU0tLQJFeLIWPU66MnkN1gi5Y7pk8rJKxw914HdqjkGtQ+TisP6BpJhgjbpseKJIP8gdEaEFKhMW0b81Vv+TLpFewBWHdom3/O1xHK/JAdBZcwcBdCB6zjnQzZqNGpPqriE8hRt9HZ6t4oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gTBIffop; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vxXERetH; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709695780; x=1741231780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cCtyBKWyyvU6aOMLUwJ6PiqQWA6r0DWl/OLXst3/ews=;
  b=gTBIffopKN+BHiaNYhT5GLoF3hye6K7JeoWwYI0q4zCycCg1Y9U20rdz
   /Sj3Ti3ElvaMlAdh76DP79ocf4UiVAlbGIb9Ogjypsa/9sWyTY4vNENqM
   hxbsvJ25N8iTMm5NcuHGuUrvefBkG7JorNX2h1vh38wl1OKdIk8cE2rp/
   +viZ6FpPDxOl+hwRUYRDhMDIwVdUWI9KcpuzMKKFpghsiWpD8BLy5aSha
   zWX2OCf/qjhyUbEQEE9kiQ7mAkBhSGLjOpxNrTp7G6MWCjQ31KAX0VL1h
   jOdLGMa081Z+oBHe7lR8fxN1RDWvJ4sGBfFbypMmt/MlptH7oW7MBsQx3
   g==;
X-CSE-ConnectionGUID: 72aG6ZR8SF2usJ9v+jCVsA==
X-CSE-MsgGUID: pmDX1VG5TcWpr6QU0cSArw==
X-IronPort-AV: E=Sophos;i="6.06,207,1705388400"; 
   d="scan'208";a="17803756"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 20:29:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 20:29:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 20:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCp0Bow5i/c8G2nvy1l8qUdON4lmTro3EGjiUbNvaXRCBx+0aCQVUqYOeb9m4k6IWk45S3uYgLmtz0f6LYwEdYJ1hgf5lb3NUVPijrIR2Wl3g4dQQP8GOU7KLPdZq+MIreUpGaFxRIdndIDhLsXc5RPnAG/up3HMwe+0jW57wJaxi43m6qQbiPRjF5hZFg+UK7Ui8z6eeUtD1WckI9jJBABgJyOFUK/rnjrPC+XHZk/qPFgdbctXVUKYm45SYvydUSiIzYck6sftJQnIdytIn02L+yfusc3Xn5EwVJR1QALjdPl6uvjX0ItbLI1cQ2LXnSlOvuepqeuOkZ9uiEPKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCtyBKWyyvU6aOMLUwJ6PiqQWA6r0DWl/OLXst3/ews=;
 b=jKAX0TQQG3xyQ77H6Il+SuMOGzKXtAXiGMRuq0nyBpgbQD8AaQWiE3L+mqnxOALtmzjqD060pLYpO/PzALArMkemHEYCTM7MM5NrDNnoWi37CANQr/cAwzrtDQyq3JIBtIafODby6F60SGLdGtzjY/NCfQwS5qrVxQQIqZcGt69nZHWrSmh0yLEyXaeysCA9vjIb7O7Ro9f3YDvKurEpEIZghtRXlyEvsK4U3acPWvCuCSUj/6QuQsQOAivTWpfFW90pvCyW8h0CxpaWRScn7CZhGpvJPKW2V8sVWcYYZGoWHCHMxmTV7PGJaKN5zxnrQXARYZnOsCcLNlxtmQA/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCtyBKWyyvU6aOMLUwJ6PiqQWA6r0DWl/OLXst3/ews=;
 b=vxXERetHqY+kWMF9a4TVkMzdei2teuwJvytZ8WTSnWwgkp3y9DmHgmk9tuz5tgJ/GjbYItUAT2PVhVApU96wcIPXa3DxzwWBSCWfg1eFwNMTKH7CLjP3w+r+QFdi9aAr8khsXNzNX3TMC2kID+ZHQrmtaeJIWZDPRmOig3J3piXL0tgyVsOvqQc3Ic3RGhKzuIBfg5mK560BT8Vg3rH0idJ+U5tA7D9gMOpDGPY2iY/q2sD0vJgqyNa+bJBMn3I9+ssB4HPggS8iT7p+Qq5ciTl9U0wuLHTak+iXPC8wcE5GfeiAbI6aXykwcnlE0mGvKPKGgdab1va2w7lbbLTiZQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Wed, 6 Mar
 2024 03:29:33 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 03:29:32 +0000
From: <Arun.Ramadoss@microchip.com>
To: <o.rempel@pengutronix.de>, <kuba@kernel.org>, <andrew@lunn.ch>
CC: <kernel@pengutronix.de>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <f.fainelli@gmail.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Topic: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Index: AQHabskmJdw9ZE4JnUWWiAJ3CfXms7EqC1yAgAAEXoA=
Date: Wed, 6 Mar 2024 03:29:32 +0000
Message-ID: <935b7bd6fe116291ff5f1f5a7a52cdad89e4607a.camel@microchip.com>
References: <20240305064802.2478971-1-o.rempel@pengutronix.de>
	 <20240305191457.37419bd4@kernel.org>
In-Reply-To: <20240305191457.37419bd4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH3PR11MB8591:EE_
x-ms-office365-filtering-correlation-id: 6001a1ab-573b-44db-f8b4-08dc3d8da3e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjl+q09Bqe99fFR5TvCmtK7hrVdJYdJkdB28C5nbaOGSEFIRLdQyEBk1vSI0G8w5OQi1VQoOSbk26g3XMG/nSZRHXf+WMYn7TAS1zw9so4dbvVQzvM/A9SZeskBtHfLXEVcnAhLjjuYt7Xurxrq/f8QGWMxKGJ/NRyBu2eMHcFci/Fou2fTI/rw0FPihKB2q3x3HsUn7YUkxN+/VnDuSScpPiCNyRbItBdAq3WnnjaU93uD4vImj6WEsRFj+wTfFeFt3VmJHCP+tJooGxD1PJw6ZMazG/ZDYKvYW0Ql3MNucOHgyAbzG4bUiLVAHj04Q14D7JaZcv6P08ZpO9GggZsWuAuMvd1Wm4A0RRbB5Tuae8C9q08MzrM7BTJ0aIvI0XrqNQ11KQhIRnzx7sacsqHS7OQh7s4jN33FzJhUtSVj92N+vT3onr3H6iKGQE0svInq1a6DwaQ0xvfQYSOhyEm0/9bsXZLVC8Lc9EdsD+cv40FX3YRjUxs/SMQ5SlqiHLOZAvD3RvEEC/H0jsGs3cgmaXWiQ9RZa+SLvqxeLeka/hfXmrbJ2VXERrn+YNtXcbLgprNgvsdm76tZWtjChDHNjSQQjJrxDbwBF+nNkb7U5CIgJcAw4+b1pE5iKvExJCmRgtYb6sOv9x5TKCOPtHIFsbf5MqbJLMYwObIxbWp3Mr6ZumzCj90bQnTczKRIpua/PF+mmX8OtOBwuvmCcAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emd0cTdoYlhWOHBEMjU3K2lMNWZFNGNVSVdENUhKdTRHWlloMUNpK2phWEZH?=
 =?utf-8?B?RjJjL0sreHZlQ3FuUGhsTmZqVzhOSVlCdk9RUHNUY0NjQ2tmR1krTVAzcmZH?=
 =?utf-8?B?TjdSR2YzMzBvZlFIZGxlQzEwSThJQ1duWFNKckNYdEtPTGpPVUNvMnZGQkVr?=
 =?utf-8?B?SFlKaHJIQXRxVEJ2a3MzOTJPdmJaeWFYTjJqMkFZRHRPcjJ5QzFPQVY4WXNP?=
 =?utf-8?B?TGNld1dKQVBuRi90RVhRM3FkMXVOc1JHM1lWUWc2TkthWVhLaHBsTDVFMEtW?=
 =?utf-8?B?M1prV1BpUVVZMm8wMnM2Skd1S3BXdmNOKzRBbEJkVzdoV1BWMFNhMkh6VHpn?=
 =?utf-8?B?d1JvK2N5L2tVV0lWT0h1ZWxQUnBPanQ4OHlIMjN5QjBJRE9lRHoyNnR5TTkw?=
 =?utf-8?B?c3RmaG9WOGU3bHVURE04VUc2bHpid0YzcGJSbnh0ZzRPZ0lEUUwwM3M0UDlS?=
 =?utf-8?B?VDlCZjRnSVVScXZNbEFEZGViMExvWkRsa21jTkhUYXFKYlplUzByMm80WVBG?=
 =?utf-8?B?MHpUREJTKysxdUNHM3gvWlhlZmJ1Z2pHTFg3MFFNR3hyZllZWUtQaDdsNmFi?=
 =?utf-8?B?YlFxVnhNRXcxRXpuWVVvOEdwMGdhTWdIWU8zVzV5eFh1U0hQVWhoTXpIZjRD?=
 =?utf-8?B?R1hKbnVkRGNqZWVjZ2ovbi9waklWT2taU1JwL0VuMklUZm5ydnpkeUFCcjNL?=
 =?utf-8?B?RThCUG9uNnVLSGNXZFJXQXhDcDFEenJXOHlCUmViT0tFSEJrVFJEeW4vbGgy?=
 =?utf-8?B?ampZNjJ1SVpkdCtSMm1UKzRwaVpwTDZDc1dMd1U1RWg5Q0ZCMmJWY1c3VUJZ?=
 =?utf-8?B?ajdkZWNXV2JRSnpEbWhkZGV3VTBCbllwS1kvbHFoc0NMOHg5RGNXaXZEOEln?=
 =?utf-8?B?UG9Zdzc0VCtORlREdjhtT0VqRDR4MFprT3pYb2hNQmNhaXp0R040RU1sWDVM?=
 =?utf-8?B?ME1LT1IweisrdjVkRWFzWk9qSTQ5ZlluNFBlQ2ZheExqNXRsT2F1SmJaWklv?=
 =?utf-8?B?b3ZKRVp3NDJIbVAyZzRDSm9LRGIyNXpZU2dUSnUzOFVwYmlqYTFYSW4xdW1Z?=
 =?utf-8?B?M2hpR1NxZng4Qm5nb2cvSElWOTNpTVc4N1pmN1lCTmZIa05OUVNMenhmMklt?=
 =?utf-8?B?Ukh5dUh1T0VjK2lOV3pRMS9GUmFvV3VubjdFNG92dDRrZTJUcXBtL3BzUktF?=
 =?utf-8?B?LzdreGFmbkVVSVAvSVVXcEtMNStLTTkwclFiZ2pXSjRxMVQ1dVJ5SEY2VDVy?=
 =?utf-8?B?QkdJbGV4bWFTYkFWUDB4V0RRa0xNU2dxYnJmeUdQUzI0UjJZQjJTeU5KWSsx?=
 =?utf-8?B?NHhGT3dnZXpoeUtMZmF5VEdKT1c5V1V1YTRBSGN1VDJNNXNXY2tYY3h6MUw2?=
 =?utf-8?B?TVREVGxtUG9UbldqSmM0bTg3bXByWmMyUUtQTnhxOUZWZ1lPQ01sVmViU2c2?=
 =?utf-8?B?VS9XY1YxTk5iS05ubUk1Y2NCcnZNaHZGM2d1NWlxemdSVUFZWnN4dDA1eGN3?=
 =?utf-8?B?aTFnWTJJWGg0ekNHcmo5QXFzY292R2tBNnlxSXdvOUwweGkvY0tBcG5vUElh?=
 =?utf-8?B?NjZkOWFVYjZWdmtYMFVybkdwdkMxVUZnajNCdEtuS25IdUlEamw5YVVQRDRE?=
 =?utf-8?B?SW5Tczd6bGIyYm5FSXpEaTlZL24yakdYVjJWb0FUV2Jlb1hmSUIzSmhJMUtL?=
 =?utf-8?B?Z0lQVzk2aE5FME5NWmttNEUrS3htNG92cnFiT29tcXIrUHV1NWZhQXhwcU1I?=
 =?utf-8?B?Nyt3dDV5b0tuQmIvbWd1SEx0bTR0cG55aWlUMTIyc2RERDBaek1BV1dkUzZC?=
 =?utf-8?B?cTZzQlhkVk1hWVA5eU5LbUY1TzN3OHVFY2tPY0dyb0lDM2VMbUJwUHczeDZS?=
 =?utf-8?B?VHg4dWxaSm1JZ1V2K0RvR0ZpQm9IUzVsVnZ1RXJqQXNrc05tR1NoaGN0aUNG?=
 =?utf-8?B?SHluZ3U4R0MrNnZ1UXZGem1jZmV1Zi94ZTJ1WmdMZ2JNR2dkcm51VSs5Tkdi?=
 =?utf-8?B?cldZWGpRUkJjbWtlQk8wMGdyeUQzbTRuUVZabUFMUkdtSUxkYjBzYTBZOHAy?=
 =?utf-8?B?b1plZWJMUUdoOFFTV0xlT2FiYTAxMTdQVW9xTWk4cGJJSVVKdnhJNk1IcVls?=
 =?utf-8?B?RTNsYzF0QlV2ek9NditmT1pkWW52OHhRajZCNTRpZnFCRVdZbU15cEtYdndY?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C29AC4477E59640BFBE1DA3D47A04F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6001a1ab-573b-44db-f8b4-08dc3d8da3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:29:32.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1PC3M1L71JoqLuf2vFvImuW0YZGwxzM8jGlNm7apfnWcePBzOJyPkh5fHr2KHBJgX+7NEQC2zy+R21CdY68eJ+R+lH9T3FW5dJxrp+Zc74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591

SGkgSmFrdWIsDQoNCk9uIFR1ZSwgMjAyNC0wMy0wNSBhdCAxOToxNCAtMDgwMCwgSmFrdWIgS2lj
aW5za2kgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gT24gVHVlLCAgNSBNYXIgMjAyNCAwNzo0ODowMiArMDEwMCBPbGVrc2lqIFJlbXBlbCB3cm90
ZToNCj4gPiBUaGlzIGRyaXZlciBoYXMgdHdvIHNlcGFyYXRlIHJlc2V0IHNlcXVlbmNlIGluIGRp
ZmZlcmVudCBwbGFjZXM6DQo+ID4gLSBncGlvL0hXIHJlc2V0IG9uIHN0YXJ0IG9mIGtzel9zd2l0
Y2hfcmVnaXN0ZXIoKQ0KPiA+IC0gU1cgcmVzZXQgb24gc3RhcnQgb2Yga3N6X3NldHVwKCkNCj4g
PiANCj4gPiBUaGUgc2Vjb25kIG9uZSB3aWxsIG92ZXJ3cml0ZSBkcml2ZSBzdHJlbmd0aCBjb25m
aWd1cmF0aW9uIG1hZGUgaW4NCj4gPiB0aGUNCj4gPiBrc3pfc3dpdGNoX3JlZ2lzdGVyKCkuDQo+
ID4gDQo+ID4gVG8gZml4IGl0LCBtb3ZlIGtzel9wYXJzZV9kcml2ZV9zdHJlbmd0aCgpIGZyb20N
Cj4gPiBrc3pfc3dpdGNoX3JlZ2lzdGVyKCkgdG8NCj4gPiBrc3pfc2V0dXAoKS4NCj4gPiANCj4g
PiBGaXhlczogZDY3ZDcyNDdmNjQxICgibmV0OiBkc2E6IG1pY3JvY2hpcDogQWRkIGRyaXZlIHN0
cmVuZ3RoDQo+ID4gY29uZmlndXJhdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBS
ZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiANCj4gSG0sIHRoaXMgaXMgbXVjaCBs
YXJnZXIgdGhhbiBJIGFudGljaXBhdGVkLCBhbmQgYWxzbyBkb2Vzbid0IGFwcGx5LA0KPiBzbyB0
aGVyZSB3aWxsIGJlIGNvbmZsaWN0IHdpdGggLW5leHQuIEFuZHJldywgc2hvdWxkIHdlIGdvIGJh
Y2sgdG8NCj4gdGhlIHYxPw0KDQpTdWdnZXN0aW9uOiBJbnN0ZWFkIG9mIG1vdmluZyBrc3pfcGFy
c2VfZHJpdmVfc3RyZW5ndGgoKSBmcm9tIGVuZCBvZg0KZmlsZSB0byBhYm92ZSwgY2FuIHdlIG1v
dmUga3N6X3NldHVwKCkgJiBrc3pfdGVhcmRvd24oKSBkb3duLiBTbyB0aGF0DQp0aGUgY2hhbmdl
cyB3aWxsIGJlIG1pbmltYWwuIFdpbGwgdGhhdCB3b3JrPw0KDQoNCg==

