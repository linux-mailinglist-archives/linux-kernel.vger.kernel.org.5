Return-Path: <linux-kernel+bounces-44431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38F8421FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567D01F2301A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E070664BC;
	Tue, 30 Jan 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BJe/OT+D";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HC4xRLC1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC720664A4;
	Tue, 30 Jan 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612007; cv=fail; b=HVEUrg9PpBhV3oEhv8LJ9DZG7790svoNAoiSuxpr1iIcWYjTZEWo+KGRho74j2lVruJirkSiwX+uybQ1u1Xhwl+RSiyXgahvPeV4kzwUbXr2HQkHHUZvRsgKJF8N3RvkhaYaiVxqy7R1SAnKHmE3mhTM6Roe/qX99r08PB2koWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612007; c=relaxed/simple;
	bh=2BGraaliAGokZ8v2CN2zgxWjdKf0uUF9bs/2vvicEfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPvJfpmnApHNcBN4YjW83miBapxAFvsbB1fEczc5FDeLWZrTwJoBaeuPNxG8Pi9pWwuv3pSUqtFBtMX+Kchs2oW2aV7m9Xr0f5QQQqqGRsRK9R/QQQ8FmsvKHuTtkJGIjl/bZiiuymeSbXdIYTm+GqhWWg6cBEF2q85XTeHIl18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BJe/OT+D; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HC4xRLC1; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706612005; x=1738148005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2BGraaliAGokZ8v2CN2zgxWjdKf0uUF9bs/2vvicEfM=;
  b=BJe/OT+D5h8EJEkyG3tfwjTvbwkfTC5Z3Tau+WGgDvWmi0hUa2U2Enns
   4+kT6h/1VxDrp3U0Z4K+XdRVF7gYvSlULOTXvHs4AxtW+9dZYHnVYJs0f
   YSiHcL+kHbvK7z5Zpw9+i3S7UkNcncreFpUzQFzRXHkvsKi/HoIESfWx5
   AoYJrJhkm/o7PZg68c/ImskMBTlI+gzwvxYoOZp+ASStC2M3uWU688kMN
   3No+KS55XQt8GDEa/csNjwy+SEtWmFsYiKQIxwuCk/D1jvHjE7UbSw7zI
   eNMUQYndenQwpXIM7hX/ughfcV7N2BRF9eFJIjIiGwytOPEvbbkWCNn2h
   Q==;
X-CSE-ConnectionGUID: +tT1MuSyT920L7M9UbqROQ==
X-CSE-MsgGUID: bSCjFIoXSy6G9576c6vUfg==
X-IronPort-AV: E=Sophos;i="6.05,707,1701154800"; 
   d="scan'208";a="16801232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 03:53:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 03:52:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 03:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+0n/54hJ+W7GeS//LXLHL/2JgBH1NfWslZz6vSFMbOIuiLfsLCKQ35ASoK1k+hl2q1z2ttKwviEoz0Za8FQuVepbgY052aJnmLQaI4XEw4HF+dFKdLMR20mbFF9CJigUs8NAwGUTfehOKujD6mRdSDhb2neDuOsCzMmXMwFwzaiO+RRiK1hEtGl2jYkuX/wqRKR6S1W+bPuxphtXNLksvo6M/TpHE1t0nPRUcyn7OfQLANj2ft7MXQLoFfxzv9etNkV007HcyGLvNYaM63rPmvkawU/1yyqNfGqylY0mMbDJphkMX38iXSqCe/OytsurC5O4elXKB+4URmwBCQqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BGraaliAGokZ8v2CN2zgxWjdKf0uUF9bs/2vvicEfM=;
 b=SWm0UVrtc6lx7NvYKea7AjEr+xjFuAtrB08GUlVJeETdGL7HgVVX5iXrhR3sHm/XygNMm+SwmWfDfHk829xOjhb3aFB9h/ClkQ9glHPfrEKeUhdJ+v3eJg2sprGs2FglGuZNO6bnKI2NaII56A8wBRHXuY23yGQOTiAmA7YTCAiiY610dcfy0vLHhLSSDM6p3a6NbERECVzHBPpWU7hHsjURE/WiO8zzvc7Y/Lv4F8Ud5jGipwA+xBorvuDNimF/C7xux7if+9Id9N6JqfLGpAOoq0nNPYVrgyEK/lQjla6CH0c/vAmeq75L0PP4sISJ+wi7CMhX65eheH5V4UoDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BGraaliAGokZ8v2CN2zgxWjdKf0uUF9bs/2vvicEfM=;
 b=HC4xRLC1C91O3rW/B20Nu7LZk92YLSyeP5X1s0Uhr0+xT0gUliB1ATOWc4yUSpFaAfpscHRbUFnt8sWc5S4vAJoQcOanARSSu1G1v0v6yucqY2fzIBL8Umi+PZeB1NA5DkRUqwE8pzpwTRMWXThyZkXiAmaQiq3cQia43dRnauElsqM6jrz2hNdLrZsLlXVfCDp0t9lRnysYB3t+P+awI+FGcBB1slkou0NRPL5Mn0dzwOiHOrQR0REzD2yjKeoHOnhOOZ16ubjmz1rSaz9573fXPg7bXZWf7vkKJ0sdQog0Mf+aCFvWRwvax8EhaA4s8b6yR8lbFScNGs3mE5Cugw==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 10:52:41 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 10:52:41 +0000
From: <Rengarajan.S@microchip.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <Kumaravel.Thiagarajan@microchip.com>, <jiaqing.zhao@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <ilpo.jarvinen@linux.intel.com>,
	<john.ogness@linutronix.de>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <Tharunkumar.Pasumarthi@microchip.com>,
	<jirislaby@kernel.org>, <f.fainelli@gmail.com>, <tglx@linutronix.de>,
	<UNGLinuxDriver@microchip.com>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Thread-Topic: [PATCH v1 tty] 8250: microchip: Add 4 Mbps support in PCI1XXXX
 UART
Thread-Index: AQHaT3ZxJm6lVWei10mqPlqZTMvpIbDvXg6AgALYrYA=
Date: Tue, 30 Jan 2024 10:52:41 +0000
Message-ID: <8406d8866968950b9bb2f2c01aaa92e3107a7a00.camel@microchip.com>
References: <20240125100619.154873-1-rengarajan.s@microchip.com>
	 <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
In-Reply-To: <ZbZyW_g4OOkCqIxf@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|DM8PR11MB5575:EE_
x-ms-office365-filtering-correlation-id: 038b11e9-d2f0-43a8-d1f3-08dc2181951f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5h0EO4/DtYhqEEKfNyP/tmKmPI26OiKBU5cWJXkjeZOjAKrHuVza0wI2HlLE8uc4n3zhrk4WU8iz7JHl/sGctkb512+no9HpBSIfA2AR14VokINuGjs7Bd2G+f2T0EYFTVE81GQ/ufoyKiGZSLzrQiWT4DovwaP1nATMaeDSTNGsItkUs41UnFGsf8qFwyzwS65qlSLi0OOnyu2ULt9yQyNNatY6TkJyERfQxoDBTRxPtkHFvLGPyMlNsv53YMr37jn9zZa8MBN/yL4TKAibxIMkvF0UIgl1in0O0udLFvKd3ckPTnb1wuhiLe/kWimOhXObxWB4dExakYAVysijQyspUaUgl6Wu0iZpnLAxYu8sXUrRV3HVBTN8UZjiCTFaJCfDIsaXxZooSx6xdGAfXix1xHPH3XiXhAOffTr6xWQqsKfI9Qrz69RtU6qTrHvOGVt12UX41VwHyO5PFprzpUjyYC7SJzeTuyOslQtSccyUJwtFhlCWku2DFio/+WksIKzugOtlLS0NF1iXVj+tB6OwjyzkZa/ZIZVdXI0FGwPz76j0gX+335yZ5Yhd1l1cy6F5iBobP51/JRT6JX6IKxjo2oRfgzxs6u9YEn95ntRn2o0M5HO6Nip0S3W7WzaviWmYbOb8zYyTRNBPte1IJnaufUGEGK4Xen4k5tE+eBMCHxoVzs6Ugnk8zWmUidj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(6512007)(6506007)(38100700002)(122000001)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(76116006)(2616005)(66446008)(478600001)(71200400001)(7416002)(316002)(6486002)(66946007)(66556008)(54906003)(6916009)(91956017)(64756008)(66476007)(36756003)(38070700009)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Smxra3k4U1ltQzV5L1l5amNJUml1NEljUHhIc2thRXZxcTZ2L2FiLys0SHc4?=
 =?utf-8?B?dFJsTThHN01PQzRsNXBTQXVBUFdyVnBjby9kUytRTUVxRk0vV1dkRGc5eVpy?=
 =?utf-8?B?aXIvYW05eGUyT1Rubnl5NmFJcU1SWXR2RkRpSHFNcFdJa2ZtNkxkT0VSS3Iz?=
 =?utf-8?B?KzFLaDk2ZmFRUDVZMEVHWVJYcFJGSndoMEJ3TGl2OWg2VXRpOXorRGtSb3Zw?=
 =?utf-8?B?VGVTakw1TnR2VXdFTXRDR0RTMHN5NVNIL0tITG0vWnhYajg0bGJyN0ZCR0hG?=
 =?utf-8?B?K3lzbzBKY2NyQTVOY2RqcnI1TVorbTE4YmhRT2dzOVZId0R2RWMwelA0OWo2?=
 =?utf-8?B?V0VWaHJNKzNrU2VzNnJjek9tbHdnSmtFWjVnY1d1VmU4VXFEYUxWd0NBUWFL?=
 =?utf-8?B?ZlRKdUVyUmMwQmJhRGxRNnlGUk16cDZBSmN6Z0ZxbFA1UGRKc3AxM2ZKT3JF?=
 =?utf-8?B?NzdvelR0a251WmxRY2RlTFluVWM3VVRoSkVZc3NTWlBuYUZFZVhhVUJ5R1dz?=
 =?utf-8?B?eFRMNmFvOFdzcmJFWnhodW4yaFZsbFhLMG5FdHh4ZERqZDUzemlVN3Iyalli?=
 =?utf-8?B?VU5TejFqWC9KM1dlUWNLcFJnL3lpOHJnS2FmdmplRGtQc2ZPRGl0TWR6aEFj?=
 =?utf-8?B?bTAzNytVS2NRZFFJcjNQZ29KQ2s3Yks3NGNKdDljdkdrTEh5NjF1WWhJUitK?=
 =?utf-8?B?ci9SUmdPWEVpR3h5M1k1ZFhFMm4rRSt4dXd4cGNUNDJObU5vU1ZPTnQrMjFv?=
 =?utf-8?B?V3NwVTVWSmd1dTR0bXRtb0UveXBZRDg3bUk0aUVSWSt4Q3AvY3pIRTl5Nm1w?=
 =?utf-8?B?akJLWWV3czZaKzFNeEVRdEkzbnRNZG5iMGtidWt0bWYxc3JYZy8zSWN0UURv?=
 =?utf-8?B?cGRvUDdpRXB4VFk2VXNmaW8wU3FvV0NsTUE1NURuTzBYelUwa2Q3NXNRNDJH?=
 =?utf-8?B?MzZ4eDJlS0ZBcHhFYm9MS0gzeWlTNTh4ZEt3V0I4ZXFTUVlGcDM5bWNmVlZ4?=
 =?utf-8?B?bFJzd3haTVMyd0VUTTJqckdnWWdRWlVZOHRwU1Z0YWZlM2prQlRqQXRYalhO?=
 =?utf-8?B?cVlSRGdjTUlwTFRrdk1FYWtOby9nc3d1UVliazdXSUJUZVhobXRlR1U0MmN0?=
 =?utf-8?B?TXNnMHRyVG9Cd1dVWVVwc3F6VFVlUldBSDFtaEs3dEdneWJkbVRiK1IrUk5n?=
 =?utf-8?B?TFIxM013WFFqOVc4SlNpditvZkd0MmMwMytCbmZpOUJLbCt5MDQxYnZuQmRQ?=
 =?utf-8?B?MWtsM0Z3MStDUjZhZkJrdlRkWElFcW5RNHJBK2taN05TaEcyL084TjJJTUdJ?=
 =?utf-8?B?N2NDZjdTdmk2VWY4SGVxUDJ0TWlzVFNVWlV1VFcwSUcxcWhOazkyUHZ6b2pW?=
 =?utf-8?B?dHpGQ1NILzQ5WVJYVWlBNEVXdEJqRmdIT0JHT1o2eTlPZ0JGUTN3TmtoV1dN?=
 =?utf-8?B?OEdSTE9lQlZKeGlCTnR6bGJtY0NaSXVISTVHQys5RFk4SzNRMVBuakNiN1NS?=
 =?utf-8?B?dzVra2pVbHU1NForUnBLY0VaKzFTT092RHBpOU4vbHRPNndGeGV3TSticElp?=
 =?utf-8?B?WGhWenUzYkt6bnU2dDBkNTMrVGJ5dVhVTHUzQnFPMDVVMytoekE4bkttbzlD?=
 =?utf-8?B?Y2lvQnpTc1VzOW14MCt4S0M5dW5PWkNtbjYrNlVzbGVod3FpWnV5bGkyR0VX?=
 =?utf-8?B?T094cE5hUlZIY0xqWnJlcUNKOG9TQ21qUVlabFhUUXFFaDQ3bVlIK2ttcGJ5?=
 =?utf-8?B?K0hxaG1HYWFRZWo1cXUwOVQ4QUk4eVlGa0YwMjBaWWMySlU1SWNjbkNUUzdP?=
 =?utf-8?B?RlVJNFVpUGdCcEsvRzdBU1lCclpQSGlZMFhhM0EyZ2tYTzJDaTAwK1hQVmlz?=
 =?utf-8?B?SDM4aTBJMFRZa2czK0crTE1aYmovTTNaNUgvUUU1SWZoUFVFMzV1aTNVWnVu?=
 =?utf-8?B?NTA3a0ZaLy80OXZGNElqZEdLVVdGVnRvZ1lNZ2hvTHd6cnlNYkI2ZmRWUVln?=
 =?utf-8?B?NU5PSWM0YloycmJpU0xzczJzdTN4ZWdMSGNUVlUvS05ZOEpDWSt2OG1nWUZH?=
 =?utf-8?B?WVQ5MmVEM0dsRUxzaUFrTkhmZW9PRzhpSVlBcHVJNU8xYzY1SUlGeFZZblYx?=
 =?utf-8?B?VmdCYngvR2hpWHNIZk83a1REbEJVV2NEdGJ5cU1yd2l6ejdRQ1NnT0E2cUo0?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A2E94DB8F19342BA54C15B41DD2933@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038b11e9-d2f0-43a8-d1f3-08dc2181951f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 10:52:41.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlP/eB5W7EG7IXdvvWWPQig2+Px8qbjDHro/clJFy6Rut0ELjFC6coKECRv5iRfTyb2dG6UIIzsqpYL0ZIifltqWlcMPiwNGWfROJiJBPTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575

SGkgQW5keSBTaGV2Y2hlbmtvLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guIFBs
ZWFzZSBmaW5kIG15IGNvbW1lbnRzIGlubGluZS4NCg0KT24gU3VuLCAyMDI0LTAxLTI4IGF0IDE3
OjI3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMDM6MzY6MTlQ
TSArMDUzMCwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiA+IFRoZSBjdXJyZW50IGNsb2NrIGlucHV0
IGlzIHNldCB0byA2Mi41IE1IeiBmb3Igc3VwcG9ydGluZw0KPiA+IGZyYWN0aW9uYWwNCj4gPiBk
aXZpZGVyLCB3aGljaCBlbmFibGVzIGdlbmVyYXRpb24gb2YgYW4gYWNjZXB0YWJsZSBiYXVkIHJh
dGUgZnJvbQ0KPiA+IGFueQ0KPiA+IGZyZXF1ZW5jeS4gV2l0aCB0aGUgY3VycmVudCBjbG9jayBp
bnB1dCB0aGUgYmF1ZCByYXRlIHJhbmdlIGlzDQo+ID4gbGltaXRlZA0KPiA+IHRvIDMuOSBNYnBz
LiBIZW5jZSwgdGhlIGN1cnJlbnQgcmFuZ2UgaXMgZXh0ZW5kZWQgdG8gc3VwcG9ydCA0IE1icHMN
Cj4gPiB3aXRoIEJ1cnN0IG1vZGUgb3BlcmF0aW9uLiBEaXZpc29yIGNhbGN1bGF0aW9uIGZvciBh
IGdpdmVuIGJhdWQNCj4gPiByYXRlIGlzDQo+ID4gdXBkYXRlZCBhcyB0aGUgc2FtcGxpbmcgcmF0
ZSBpcyByZWR1Y2VkIGZyb20gMTYgdG8gOCBmb3IgNCBNYnBzLg0KPiANCj4gLi4uDQo+IA0KPiA+
ICsjZGVmaW5lIFVBUlRfQkFVRF80TUJQU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNDAwMDAwMA0KPiANCj4gKDQgKiBNRUdBKSA/ICh3
aWxsIG5lZWQgdG8gaW5jbHVkZSB1bml0cy5oLCBpZiBub3QgeWV0KQ0KDQpUaGFua3MuIFdpbGwg
YWRkcmVzcyB0aGUgY2hhbmdlIGluIHRoZSBuZXh0IHBhdGNoIHJldmlzaW9uLg0KDQo+IA0KPiAu
Li4NCj4gDQo+ID4gK8KgwqDCoMKgIGZyYWNfZGl2ID0gcmVhZGwocG9ydC0+bWVtYmFzZSArIEZS
QUNfRElWX0NGR19SRUcpOw0KPiANCj4gPiArDQo+IA0KPiBVbm5lZWRlZCBibGFuayBsaW5lLg0K
DQpXaWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCBwYXRjaCByZXZpc2lvbi4NCg0KPiANCj4gPiAr
wqDCoMKgwqAgaWYgKGZyYWNfZGl2ID09IFVBUlRfQklUX0RJVklTT1JfMTYpDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzYW1wbGVfY250ID0gVUFSVF9CSVRfU0FNUExFX0NOVF8xNjsN
Cj4gPiArwqDCoMKgwqAgZWxzZQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2FtcGxl
X2NudCA9IFVBUlRfQklUX1NBTVBMRV9DTlRfODsNCj4gDQo+IC4uLg0KPiANCj4gPiArwqDCoMKg
wqAgLyoNCj4gPiArwqDCoMKgwqDCoCAqIE1pY3JvY2hpcCBQQ0kxWFhYWCBVQVJUIHN1cHBvcnRz
IG1heGltdW0gYmF1ZCByYXRlIHVwIHRvIDQNCj4gPiBNYnBzDQo+ID4gK8KgwqDCoMKgwqAgKi8N
Cj4gPiArwqDCoMKgwqAgaWYgKHVwLT5wb3J0LnR5cGUgPT0gUE9SVF9NQ0hQMTY1NTBBKQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4ID0gNDAwMDAwMDsNCj4gDQo+IE5vLiBQbGVh
c2UgcmVmYWN0b3IgdGhlIHdheSB0aGUgODI1MF9wb3J0IHdvbid0IGJlIG1vZGlmaWVkLg0KPiAN
Cj4gQWxzbyB5b3UgaGF2ZSBhIGRlZmluZSBmb3IgdGhpcyBjb25zdGFudCwgdXNlIGl0Lg0KDQoN
ClRoZSBjdXJyZW50IFVBUlQgY2xrIGluIE1DSFAgUG9ydHMgaW4gcGNpMXh4eHguYyBpcyBzZXQg
dG8gNjIuNSBNSHogaW4NCm9yZGVyIHRvIHN1cHBvcnQgZnJhY3Rpb25hbCBiYXVkIHJhdGVzIHdo
aWNoIGVuYWJsZXMgZ2VuZXJhdGlvbiBvZg0KYWNjZXB0YWJsZSBiYXVkIHJhdGUgYW5kIGxvd2Vy
IGVycm9yIHBlcmNlbnRhZ2UgZnJvbSBhbnkgYXZhaWxhYmxlDQpmcmVxdWVuY3kuIFdpdGggNjIu
NSBNSHogdGhlIG1heGltdW0gc3VwcG9ydGVkIGJhdWQgcmF0ZSBzdXBwb3J0ZWQgYXMNCnBlciBz
ZXJpYWxfODI1MF9nZXRfYmF1ZF9yYXRlIGlzIDMuOSBNYnBzLiBJbiBvcmRlciB0byBleHRlbmQg
dGhlDQpzdXBwb3J0IHRvIDQgTWJwcyB3ZSBoYWQgaGFyZGNvZGVkIHRoZSBtYXggdmFsdWUgdG8g
NCBNYnBzLiBTaW5jZSwgYmF1ZA0KcmF0ZSBpcyBjYWxjdWxhdGVkIGhlcmUgd2UgbmVlZGVkIHRv
IG1ha2UgdGhlc2UgY2hhbmdlcyBpbiA4MjUwX3BvcnQNCmFuZCBjb3VsZCBub3QgZmluZCBhIHdh
eSB0byBoYW5kbGUgYXMgcGFydCA4MjUwX3BjaTF4eHh4LiBDYW4geW91IGxldA0KdXMga25vdyBh
bnkgYWx0ZXJuYXRpdmVzIHRvIGFkZHJlc3MgdGhpcyB1cHBlcihtYXgpIGxpbWl0PyANCg0KPiAN
Cj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQoN
Cg==

