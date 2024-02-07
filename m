Return-Path: <linux-kernel+bounces-55973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B855684C460
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0801D1F229B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC14A85;
	Wed,  7 Feb 2024 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jriH6JXz";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NgVq3FW1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BB1CD13;
	Wed,  7 Feb 2024 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707283566; cv=fail; b=Uh2mGb0QKAAdod7kLK2Q7d34kjBPNx0wlh+XQuzIjPOJfN1Phk6dp9EwwGkFhEJLz2wwWr+fAQ78HH7HupyE6F/g/F6s5ncfnXg/hg/TwHnkS1vJV3mDP+V30xGJFujX++qvdh+w4q7W+85xfwxunmZDP09KVg/RSYsTLtiMUUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707283566; c=relaxed/simple;
	bh=2HsTGL1/b5mqMhBLdkQt/L1zyFj2rMDdTutS3QI9SZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0HZTpxaDzVgfolK3zzLwBYMZFwbhUN12VDOT7RQ1bWgMjHL3IdHI3pzLfXxQog7yB6qfuzWTNlxx6AlYig+EqzN5Pv2gopaMCgalHjmlDFghhXkvUQu9b02/LNpXlEzqobdPHz+MYq2PEBonH+beLFuctW0O6ook28yHskihOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jriH6JXz; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NgVq3FW1; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707283564; x=1738819564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2HsTGL1/b5mqMhBLdkQt/L1zyFj2rMDdTutS3QI9SZo=;
  b=jriH6JXz2QmGNfvayngDnEvmyXVFgwVpwwA3+gIr0LfOrA+HP6xHgPjK
   V7prSfD+BL2LzA650iFpPNYuluJ6yVddFFcFE7HlPrQXR0I6qedJWqUwq
   RlY1hLMr0tDmAJEGgRZ5L7hFdKz86A/s3wcWcW3wdHI0ESwQoNA3S41z+
   4UNZx0l7DdF4ntSeGUN0S/ynPl+8Xf8NoZ327sNiE7F2ohSXUoMAD29Oi
   rv9DdlCtjsA4vfmTSRiu29NYEUO13lBkrCyEfOxo0Xx1u19dFf1HkkslU
   8eB4MK7ER5OvOlN/Inful5eWZkcgSQjUIK/mwbb8/es4mQNisTTPEbAIE
   A==;
X-CSE-ConnectionGUID: qVmRIH3SRIOs8ln40ULF4g==
X-CSE-MsgGUID: obkVdE3oS7eLt6pGzgbt1A==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="17261063"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 22:26:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 22:25:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 22:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxbgbZvwJzF/tjZpXTjfbBl/HBCZ+tr01fsTZgke5GNP7Hq+rXQwcrywHXdyndRXLqQUU8421/EgHDXjOp74nopFFb0prZ/Ux+PxXdz1oMPWlwVEBGrEbZi5/N7HYlxpNDHNxT5r5pQI8C3zEWpPzragGCp26kR7TWmSLNDBieoDdGlwZGqoF+UEvG0ocqFFjtnngwChOCSvLG9Y66qRAaKxZIAjYuj6LI1Zt8/AqBdhQ7aBPiRgBy0XXzqgSSAfrVvKRkjj4wUPZhscCAt0VdQ07Nj0oJSRCihpf8snGna6KPdLaOeAPzswk2FeeMsKKMw5lhRF11Va+HZdA5ro6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HsTGL1/b5mqMhBLdkQt/L1zyFj2rMDdTutS3QI9SZo=;
 b=ZlJ6Ui1gvJAPpOYA3zjGcBAiRrCiWyd1k1Su+Yh+rjD0aEUq3zOo4ohNfoiCli/5m1uaccwIOEYmlfGzV1x6T7XkLL2v8v8zjPZPp/2buzCuthVnYY3aWzUkHMGBKCOGRBCS/x5YgRe1sED9FEp4SycSPP4uXZDtn1LeG8KSP5jq0SB8/bmlZwfUviUBEBJWmtpRZWM4RGba59sC9Q/+VwbLOCm9pOI+dSGHX4lOJ1NFp/Bu9yeZvAnVn8XUCiJzvnN1xXu8BDuuiJ2NR4hgZSJiFY6ZH5Yyp/vLupod3e5QoHNVfLNym9y5tsYtj9nWcob3onzoh53VBXmR706XYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HsTGL1/b5mqMhBLdkQt/L1zyFj2rMDdTutS3QI9SZo=;
 b=NgVq3FW1Jk8SutZZ378Vy1ix8EzS3ZK3L1jl3rYV+BF4sE3GZNWSNIs2BlJYMKnm3z+GEuzLu652mcsvPkGjfZcsMJpm5A5wrp3Zq/X6QDS3KPrztvt5lA10FbIXpxADi4mbSo6SV3yQXpiHAW/bQxIlj5LTvFgOfYZ89Ybrt2NbFv4f7Sk+dkIsqAA0vD0NXHTpHZpHWGQPLa5hYIUxo7l8nS6YqtGOc8sStxD5WGGh2knJvAogf8Ruyn0fcJcq/MO/J8tNTMlTnj+WUjQqmWhX3kHbHDmLYYGTCHvPFwAR7ncQzYgFaRboDGgjLfmwKP1Ue7e1UMcSU4ljAthnfA==
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by CH3PR11MB7721.namprd11.prod.outlook.com (2603:10b6:610:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 05:25:43 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::53f3:c782:79a5:cbd4]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::53f3:c782:79a5:cbd4%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 05:25:43 +0000
From: <Thangaraj.S@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>
Subject: Re: [PATCH v2 SPI for-next 3/3] spi: mchp-pci1xxxx: DMA Write Support
 for copying data from SPI Buf
Thread-Topic: [PATCH v2 SPI for-next 3/3] spi: mchp-pci1xxxx: DMA Write
 Support for copying data from SPI Buf
Thread-Index: AQHaWK6sMkf0FyjepkqA4A5u7MVb/rD9Q6gAgAEWqIA=
Date: Wed, 7 Feb 2024 05:25:43 +0000
Message-ID: <1f83f8317bbb47417ae6e13a7a85a56c99169bc4.camel@microchip.com>
References: <20240206034118.748801-1-thangaraj.s@microchip.com>
	 <20240206034118.748801-4-thangaraj.s@microchip.com>
	 <ZcIqKP6cu+KThPBg@finisterre.sirena.org.uk>
In-Reply-To: <ZcIqKP6cu+KThPBg@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|CH3PR11MB7721:EE_
x-ms-office365-filtering-correlation-id: 2803fddd-1dca-4c40-b790-08dc279d3b0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+HA811qSCweAwaPlxZUZRT3eHxbOYVGW8tRoLYqvOOS5yKz1k3ekV000gqZ+VTftTeRaHK8BwICgtA98Mw7OZnQNRxPxK0biaij/IaVP++WdSgXeOddVNdTGXfwEY612dWDFPBWwJ6IE50IWrmLBi7a08gpTlPvESH0yWspWGoAKaZuokTFq4UNBf2uTGRjpaxsq209KdvV8dv3hlu9ihkpOlBWv8ZO8NNhb3SvKAA0iDyQ3UJZ11niL2ZZoDBJOo+/pYCUlHsJlT0at91rRa8zYAhel4ImpSHMb75ZE9RNWe4CjrIRenF/3jqVT9Ya7KO62esNxja/37xkSjTcrJwuveYJ8D0SgHNNZb5MPZZTCE97HfEOhWsREk7SGV+iu2d8C7PXHKuZtPNpZVtgsN0jNdEDzZqslR6yDSylowi8qeD7myVfEznDiZEglMuPpv2/fYaCuxdzQpKGtcLc2ePQNtpnIs5Yhf+TUzbGZrjQ07YhrTQahWbV4IeHW1RlSFjbHFq5QZ+nNN8hkJfJ5Hpbjuwy99DuYDhElqwTMhmZBk8MjROTGYeipOben1xg/RkMf0fxmNbYffhMODrFhZrj60texXENIOOQtFmGt7s4RaABxs86WGfgcXSgk6zv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(41300700001)(6512007)(5660300002)(6506007)(6486002)(107886003)(2616005)(26005)(2906002)(66446008)(54906003)(66946007)(66476007)(64756008)(316002)(66556008)(6916009)(76116006)(71200400001)(8936002)(8676002)(478600001)(38100700002)(122000001)(4326008)(83380400001)(38070700009)(36756003)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjliSTdKUUZBRGpNR3FrOWwyb2ZwcHJoSStPQWxCODJRQ1l4NXl6MTdLVDRj?=
 =?utf-8?B?QWM5MllXZDYzak1teWtlKzltMHVhTFk1UmdDU1NnbzFzUitUTy9jajNCSzl4?=
 =?utf-8?B?bGNYVm9sUllSUmhHZktTaG0wdVc1R2Ewc3cwZGRaN0lQb1Zvb1FCbUF0OXVO?=
 =?utf-8?B?KzZyeXBXMUpET0NrN2liSGtkZlhNdVFzY2c2OEFVYVlZVTBTSFN2SVpEbDcr?=
 =?utf-8?B?VzZqTjFtVEZWYnJOb1VqdmlYa1U5aEp5YlBZYUI1Y0JNZFBuT2dSaThuZUpl?=
 =?utf-8?B?VTZwQ2p3bW1HWDRrNjk5Ym9LUStDK29zY1ZFUmIwd1RxL0NGbXZsdmdpNXVP?=
 =?utf-8?B?SUM2TVJqczNRa1loY2R4NHhQTjV4UFRTL1hiT1ErK2s2UExMUXo5MzdLN3Ro?=
 =?utf-8?B?SmErWWNUbkNLd05LS0VGRzhXckMvc1RRSFBmYmtrOWxPTzdQY2RIQTdSaEdB?=
 =?utf-8?B?QkxBdUp0WFpJQ0NtaHVPMjlVMDlaVXRscWZoYUpTQTRjelR0UWtvY0FvUjRx?=
 =?utf-8?B?dk9YanhXV3NKa0RneURWZ1ZteGFQWTBMR3N0cTRESDY5UVA3RHhncXhISC9m?=
 =?utf-8?B?blo3c3ZiQ1l2a09iU0FIV2s4cVBtZzlhQzJTUWhuK29qZ2ZNOHcvTVJVVWpS?=
 =?utf-8?B?NkpnbE5ZOUJ1cFY5Mml0Zm9uK2pkS2tyVVJSakxCRXRKUXBZd1FnNnpDcEZM?=
 =?utf-8?B?ZXJ4N0pMdGNSYjh2UmFrUkl4YXdnZFYzWC9CdUNXeXhvTURnLzN5QlpNSGEx?=
 =?utf-8?B?WkcwbGc1eENoZ2p1L1p4eGlhTlpLK1AvZEdKd29hMjVVVFFwa3ZVTG9lS2l2?=
 =?utf-8?B?ZzhvQkVyTnlOZVZRNnkwUlp3ZGsxOU9GbDl3aFU3V3hmUVBndGlZdG5FdFEx?=
 =?utf-8?B?M3NvcEM2aS9mWVgrVTNzZWRFTlFwZmNBSFFERjZmRzg5V0w4YVVpYWptd0ZT?=
 =?utf-8?B?cy9ma1M2cXNOTWdraVpBLytCV0dIb3FTNiswR092czdKSnJwL3JKRUZVRWZW?=
 =?utf-8?B?VFV0QTIxOW1lcHBjaFppYnFITW9aNGprQnlEaERCYnpxdG16RCsyT0FJVzg4?=
 =?utf-8?B?T2ora1Eyd0JPbzRYWlFnazZJV2lsN3RJRTZycUhuVEFPZnRqS2NJR0lNWHB3?=
 =?utf-8?B?REVOUWhoaGxWM2V6dWZVNDNPUlJuRWpORXZBalNoTG05Rk1YQktJM3VJYXo4?=
 =?utf-8?B?NThhTUJ0Q2pxMythemNJVHFNZ0h3QlJoelo1azgyYTVBci85Z2s3Vmp3MktW?=
 =?utf-8?B?bFFweUtoOVZtMU1JS24zWmlkSnpPZVhXQUhSMnFNWkg3a3dJOVBsbFVOaGNI?=
 =?utf-8?B?ZFJpNUhGTWFxbXRjOVBRRzJDN3Q0eXUzQVVCQ2tBYVJZWHhvakhRUDlSdURP?=
 =?utf-8?B?ZW5VNFlzbHA4K09lMUFsbC94ZlVTQndBbUZvWXpVNFBxR0lRUlFGMXY2cFZP?=
 =?utf-8?B?cGxIczdVUGZFKzlyL1JZOGtyWk5pbkZCSzF0M1F5S0VaemZoRlA5N0JUdVhK?=
 =?utf-8?B?dUttdGVHd0NqM25jcHE5K3B5UlN3ZEh4ZGRudGI4bXJtM3AwQ2tiZnd3aGcx?=
 =?utf-8?B?SEJSbFNYSUpSSXJDK2pYSnpFQURTUTcyOS82Y0lHVjBMZE4rZ0dvdndGSmNF?=
 =?utf-8?B?NHNPNnBub3NNVndrVkU0N2lHb1JZOCtLU3FUc1dtUEtETDNoN1c3QWNMZVNU?=
 =?utf-8?B?VWMvdnhvNVZ4R1FkV2xKK3JUTzEyaEVOek9JUTRMOSs5Zzg2SFAzWmdHV0dQ?=
 =?utf-8?B?MzVZa0UyK2EwYTJDNlZpSXZtUXlzbE5vdkVIMGFGWnRpYWNvNmFtdzc4dGJP?=
 =?utf-8?B?SDVvWTVLSHMzYTR1N05yZ3dIT0RoZmh5eUxwWGNOYUJoekNucmRyUTl2d0dV?=
 =?utf-8?B?cnptZUp2ZHQveFBlTW5UOTJYaUJqdHNURXFkMjdodktNRzhEaEpETjVQUGhw?=
 =?utf-8?B?YkRyZk84enNpRkU0SWE2dXNYZ0NXamI1eGpRdXZQbHVGZDNPVlhXWWJiNG92?=
 =?utf-8?B?OTVwc0NQcDEvYjBMM2dnWDEvQnhMSGptSmR3aTYrcGVyczBPY3VtNU9wS0Jn?=
 =?utf-8?B?WHpmaGVIRWVvdnlxbTZVTnVPdjMrSU5yVW8rZ2k4ZzBEczEzdzNvcjFBc1Fo?=
 =?utf-8?B?MXpLL0Yvd2pibGE1YURaN0NLUXF6ZG9QcGdXVlo5WCtEOWFwM1IyeXRocGo5?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <385288DA554F134CA46CD59421B9CCB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2803fddd-1dca-4c40-b790-08dc279d3b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 05:25:43.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH196IlvOLf9fTmHRIcdnwM+QAxDMm+6mVcGu4CZoCjD1iaXFav7RdE6lBdqWScQOYBdogxU8LgW/OD0EHyyJL9vLa+tl5h1vkW286Q2gY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7721

SGkgTWFyaywNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLiBXaWxsIHNlbmQgdGhlIHVwZGF0ZWQg
cGF0Y2ggc2hvcnRseS4gDQoNCk9uIFR1ZSwgMjAyNC0wMi0wNiBhdCAxMjo0NiArMDAwMCwgTWFy
ayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo=

