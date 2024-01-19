Return-Path: <linux-kernel+bounces-30717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52D83237B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518861C232CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E704A05;
	Fri, 19 Jan 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U40I0fCa";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KEVGYWjs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD03D9E;
	Fri, 19 Jan 2024 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632753; cv=fail; b=a3Wg805MESUoQzSVo3+irqh3C/C7e8EBidoINsTqpQpUKLwn7+o5LnKp5V6ZpwTwFcwHlyoflZhIqGHKF6ImnH4Azfg25VgoepA4ScMunDVE+Cs0W7x/WJ1xDkJJ6Aehw3az6Nt/F3NowVeTWJzAZumgL84repvkkxVdTJ+ZGX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632753; c=relaxed/simple;
	bh=oHg1O+N7oheZkSp65AdQylObSWHULzm4+Qfxl5Tnz0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHdk6mTHYZSqolhBoWmER1DKr0FSncPJqdJllmysa0tsYAdVUPHgKFA+vxqMfnKghR+r11Ia8MLG9YVnM5GaNxyHW9/P/lPQavSWJXFT3IUhn+cBu7rAyrRVE1mnrTjvKOL5p+r93TAuuFnlxTfh45QHjsJvybq7kvw8wC/sGK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U40I0fCa; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KEVGYWjs; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705632751; x=1737168751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oHg1O+N7oheZkSp65AdQylObSWHULzm4+Qfxl5Tnz0c=;
  b=U40I0fCa56c37vZ2sBrLq5bR/52u3+BzWktluo/O15E8ympgCWctSv0l
   q0cZPOw0PlYF2N+l4Rrgn9PdVHomzg+oIJDXNK6rgQijKI3WPvxShhwul
   TbK5lLtYbO5Xetqj9+P5vepS3tFZpp+gFVz7NgxCRt566BFKUE3jUzMga
   Zzzc8uw5HEyrQn0g7TR+ywaP/veQdxnmYs6AH6F9NhHJbrMEa1toItMmC
   TU9brUQiaxTozlg4o94D0EktifNIzUJ08B67l9YuwNmQVfRV8Pvv5uZB7
   uN9h8SUDkK4SqVoVhk65hC/+jeOQTbmOhZ0Iz+XrjU7/ypLFsqKi/ngMy
   Q==;
X-CSE-ConnectionGUID: jroz23nJQ5medtwO3IGrmg==
X-CSE-MsgGUID: GAbdGrutQIiyNN5xhijIFw==
X-IronPort-AV: E=Sophos;i="6.05,203,1701154800"; 
   d="scan'208";a="16198958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 19:52:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 19:51:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 19:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoaoaHReDubJtyFxO1nBB9QSaVuN7J/KKfDiC1GkJbunPHoc+pZMU3BM5W6EmmzaJwbs4ederBtfMP6negCBKJaHgaTwwlRrILJTjSHUP3dM173+kZEN8U/hapINOF7JuaXnxBLjTJ0qDU/9a8YGDjks53QUPQnvPANtLonXFwch4SNGYFpMkJP6mQkxT/nuoxhLSs+z1Vk7VzX3t/wXgKpHOawQDfx8ihhnUPNByN2qMLbDxP5OLKenQBMuYWjJlmHTxn4n1dNEg0CUbfKM4wy1CAd1yH5wL/3XXSLkRzJH1wOgqV9OauKZn+YitThhJIPZLJrPmDrO/v1md4Ih4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHg1O+N7oheZkSp65AdQylObSWHULzm4+Qfxl5Tnz0c=;
 b=IpUQImzQUyM4GgWivAjPKTt0geUoJdK1YMKEnH4tQ8is7Nn3y54TlwIVjfGFyu5Wh9OkczmuKsRfbqhPswrxcDjcVGFajPBAnwTbvAi+jxR+rpnJ/r2FMHlUv++S+A/htrUeQPNph896OV6v57lVfVdQ07LVCFoYZeVyqRIYQLEZBWLiHQezOi0SFD5hja02HbktSnRqgvyeDkInIDdcNjyVqvUCBk/FwKRVTNPAfrLDHK0DKmS8ZpXYTdqo/KsnpnLUsXgM8bUfG01sANMaF56rzip/09BVTH7ta0av1L5liRzb4f397KhrUZxJAyyZIzx4L1xSWpN3osqDYrWxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHg1O+N7oheZkSp65AdQylObSWHULzm4+Qfxl5Tnz0c=;
 b=KEVGYWjspUfsjjwDNEY11wTnm4Fm/5hmdYV/s1GTPtJR6dOoJYVqO3IHAqI0/56y1hbIbgiQX02MX2KwtGWKOiVguQKVfiJHtoJlvNRW+dplnEo5Y3atX2DCU3IaKVdFZ9VWPJQ/eBcYj+us5koy6AfgqhZ3Q+mQpZWTg1ibN3YnWoIZ6gmwiZK/RLTPxXBWOVJHsjG6KCUtHOgyHmka9R48NNN5M9DHCmvPhlSg+9iNACwjfpHLDkGZ8LN4IsWL5mG6J/yb7+QMsYYmgHKCgM6PofE+AmPE950hQKd4rWtjKfe4ZloMCfJSLah0faROjXnfUxxxrzuAI7lLVPrmPA==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 02:51:48 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 02:51:48 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <Conor.Dooley@microchip.com>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
	<Linux4Microchip@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Thread-Topic: [PATCH v3 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Thread-Index: AQHaSfBxBE7vYyXbakeOwmoCIPKx1bDfsusAgAC+FoA=
Date: Fri, 19 Jan 2024 02:51:48 +0000
Message-ID: <6630655f-282a-4a1e-99fe-46679fcf1e56@microchip.com>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-2-dharma.b@microchip.com>
 <20240118-unscathed-flail-be2e49abc56d@spud>
In-Reply-To: <20240118-unscathed-flail-be2e49abc56d@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: ed2d1d07-85c3-49eb-c7e7-08dc189994bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aX+ib5r05JgICkxfixgEjXq156xGTf+NhyXliU1v4Kog26dPvKWbz0CBnCSGElURAT2cEXltiTeJWVtjrV/WhqWluq+AEqgxjHMxR/0EW8CcUVz5vtvD2z3ZhuQAX+RTB7E++q9B9RGix1Maik7ozsrTB9c0gQDPi+Wzcmx/QlJIBmxUni5KDbJjpgcGvS4A8zTWvU4ZBsZ3/fMv8o5oYbPCDRpV0YSbNaA9zc1DHCMsDhR1EJb34kIhOZXLGccBUclyjSif3QWW7MKFS97AjloP/BYj6LX2c+fQuPJG9O7tJk0aliZCcoDhMiJYCc+3XRV+C+dpV/QjhogUywmj2zPAt4ZXCRNpgvQh3lK3mSkpgXMANtE9jbB/feQo/etT0LnYf/6RmDNPF3VZAQDVby2Cac1OLM5ftGnM1vq3k2CzXoAFbVNvka4xiq8qUNqIFXV7TtxAkHNIzOJ0hRYtFlDVASoa56R2F/9GcsMOUbRpWe/HIwNPG4WzL9SEyp+UTQIpIx3fgItXqxn9fUuEiyq2x1YXY0+pwKcwaxINMCe5dtcaUZK15oR8ty+gxUHcvGcUf6pEzyen1Q1ynfoKbtx3wgXrCjFb5jB+Ezn7E+AUHBcz7jGXxcE2o6CpZFHBOTgfZMAdhUoZJIWD4CvxcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66446008)(478600001)(8676002)(66946007)(122000001)(91956017)(66476007)(31696002)(76116006)(6486002)(54906003)(66556008)(38100700002)(64756008)(2616005)(71200400001)(6506007)(107886003)(86362001)(8936002)(316002)(4326008)(26005)(6916009)(53546011)(6512007)(2906002)(7416002)(38070700009)(5660300002)(4744005)(36756003)(31686004)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1pZS2F4YUZaMERuZjk1aXdNS3VqMDY3WXJmZ3orWXJ3ajFwanhMUm0rUkFL?=
 =?utf-8?B?YXNXTWhTSnVibVJRZW01VjlGZWZCNGp0eEdyUTBmSjIxNU9ySmJDRXZibllX?=
 =?utf-8?B?QW9reE1OSGk0bUxKZUxmS1cxS2s1aEdYbVlkam8yeHhWWk5zRHRWSTFZZVVZ?=
 =?utf-8?B?UVltcUI1VHAvWjJTVHpoVURudXlTZmVMbzdaR3N5VFJhZ2I1TENoS2I1dE9D?=
 =?utf-8?B?ZmhJRW9Rd2ZSOHlqU0V4SzJzTzRkZjJ5cUIyekN5WTVOcUlCMjluZlQwMlY0?=
 =?utf-8?B?dVFCSmdtenNJVmlOb2tibTFndkR3cVBtL2RRSmQzd3JFaE85bXVacUxTdGQr?=
 =?utf-8?B?NzhzVzhtNmR6MGJWMzFleVZBeXNDU2JsbStzYmZJT0pLV0loTCt1dmtScmd3?=
 =?utf-8?B?T25CSFN2eTgzWFF2Z0cybU15ZWNMLy8yNDNHcTduamN5N2kyRjE4TkE3UUNt?=
 =?utf-8?B?d2tta3dyNWhNSkhOR2dKZ3c1N253MTEvUkh5TmZIU0VDKzgzYjUrVlBOT2hO?=
 =?utf-8?B?aTJGbG9wRlV6bFRuTTg1WkZqajd2OXRzQTc4RWRaMGR6VGNYbit2WTAvZXF6?=
 =?utf-8?B?d3VyWUFHVit5ZkNyVEhQa2dhcDVEcGxLSGR6RmVzbmROV1U1dFB1a1ViZEVm?=
 =?utf-8?B?VFk0VHQrU3ZTL3htakdzT0VEajBQYytMU3p1YkNqZnEzYmFRYWczdnNCOFJj?=
 =?utf-8?B?bVVVdnl0bEYxUVRaSGFhR3A5b1dMZmFYRkpHUS9rbTlyTlJsbTdPc21Kb2tS?=
 =?utf-8?B?QktnQUNpVy9sQXdSQXk0dmlDMVVqN1RpT0RLSGpDWnFFVmJkdlZ2Q0Nqamc0?=
 =?utf-8?B?VlBlL0hFOVI1NFMwenJkaVYrc1lSMys3S3B1NVlUTXdEcmZTbktZKytJZFhW?=
 =?utf-8?B?WTE1bkRZSzlJNjFpTWY4S0lpeUViVXg4TmQvRnpVOGNSRy9mbGloRlNpdXNP?=
 =?utf-8?B?a1owU1BvSUFsOE1rZzRDS0h4R3ZaMzZ6eEhsenN5MS95WmJxWFJWMmtNSmc5?=
 =?utf-8?B?VWY2YW9KTUhZSEVRb2FETkxZMkRnekNnL3hLNm02djYrK0NGRXVUSHZ3SXJl?=
 =?utf-8?B?dHl0WG5DM0I5aGxxeXJkQjJ0N2phY2h6bU5iQUZZYk1rNUowSEl6aXA3WHRi?=
 =?utf-8?B?dnphYnR1MC9yalpOL2h4cmFKeGRWUmtoUUYwbTF1U2pVU0c1NUcyL1QwM1RI?=
 =?utf-8?B?SWJaUER2NXVjTElVdVJYSWpCTnFreXMxcHZLT29LR0pERzhZRmg4YTQvV0kx?=
 =?utf-8?B?QXBDMXo0UGhXbUxPa3FPNnVib1NVM2tYbkFkTDFsa2ZCM0tpMVhFTGFhV1kr?=
 =?utf-8?B?RjJZc2p5U2RGSmxWNC9YWVpGVTdHcEVtcE5ReGZ2MHE4QTF1cXJIbFNMc1pU?=
 =?utf-8?B?R2N5Y21zRFZuM0licm15ZjRvWDg0Skw0QjFDK0ptQU4yQnVaMXNNcmxsQWFU?=
 =?utf-8?B?Q2R1TTFTaGIxYzNwNDZlZHlxS3p0L2JwRVdYcEpWOWFiNUZqOW5QVk1ZdEtK?=
 =?utf-8?B?YlpmSXFocWIwZmVxM0ZTMXB6ekZsM2wvL1hIVDdxOFJNZ1lUVjRnSUMvV1Fw?=
 =?utf-8?B?bitvS1k3Z2hhWkpza3BZcnhadHdTcEg2aUlaZWxYdXBVcEVlSldvTEpFdEVN?=
 =?utf-8?B?K1RKRCtjbHNOTmsxTXVQcjdoU3p5UVBuMk1OcVJNTHh3ZzgzSVBsOURvQ0px?=
 =?utf-8?B?R0R0YWxSVXNERTY3M25DZnV4RlNKZVc3cVgzaHFOcVIza2krRTBFRXNVSnhu?=
 =?utf-8?B?S1lxVGNXRkFnUVQvcW1SRS85RHVZbnRIUG55THdEUisrZEpya1dBTFpPNEpq?=
 =?utf-8?B?RDF6WURoMENmQUo2K05OWEViV3gvRmgraDh1dHNPbU0rSnlnanduSHpMMmMv?=
 =?utf-8?B?aHNoY0R2emdGcTVRZ09IWU9KQ3dHa3NtQTFpV0wzc1V6dElieGtTYmhrZ1VU?=
 =?utf-8?B?bjNmMWw0ZDJwRkRReGt3cXZMSVNLWGRWN05WNEltcSsrOHVPRTVsRS93R2FD?=
 =?utf-8?B?dGJzYmlreWlwS1JDblY2ZWtRUngyTGRDaXpRblVRMlpWT0w3ajU5YzNQTGh1?=
 =?utf-8?B?OGh5TnBHb1ZMNzJmOEdYRnZNNmdFS2krN2pVN05KeGIwU1ZSSVNWVjJYbU11?=
 =?utf-8?Q?iP1lfWyHbwrfd4zOzZUX8i3Zi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3D120DBAAE6646B30D419AA53F859D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d1d07-85c3-49eb-c7e7-08dc189994bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 02:51:48.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FpfvB20SYdCHn5c8iLvmj5UBZpKECsK/WGRO3JneyCMvcbdPK2RQC7Wrv3M1XGonMkSWQFtjKjL9X3byqbLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324

T24gMTgvMDEvMjQgOTowMSBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUaHUsIEphbiAx
OCwgMjAyNCBhdCAwMjo1NjoxMFBNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6
DQo+PiBDb252ZXJ0IHRoZSBleGlzdGluZyBEVCBiaW5kaW5nIHRvIERUIHNjaGVtYSBvZiB0aGUg
QXRtZWwncyBITENEQyBkaXNwbGF5DQo+PiBjb250cm9sbGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IERoYXJtYSBCYWxhc3ViaXJhbWFuaTxkaGFybWEuYkBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiBjaGFuZ2Vsb2cNCj4+IHYyIC0+IHYzDQo+PiAtIFJlbW92ZSAnfCcgaW4gZGVzY3JpcHRp
b24sIGFzIHRoZXJlIGlzIG5vIGZvcm1hdHRpbmcgdG8gcHJlc2VydmUuDQo+PiAtIFJlZiB2aWRl
by1pbnRlcmZhY2VzIGFzIGVuZHBvaW50Lg0KPj4gLSBSZW1vdmUgcmVmIGFuZCBkZXNjcmlwdGlv
biBmb3IgYnVzLXdpZHRoLg0KPj4gLSBBZGQgbmV3IGxpbmUgYmVmb3JlIHRoZSBjaGlsZCBub2Rl
IGluIGV4YW1wbGUuDQo+PiAtIFJlbW92ZSAnZXhhbXBsZSAyJywgYXMgaXQgaXMgbm90IHJlcXVp
cmVkIGZvciBqdXN0IG9uZSBhZGRpdGlvbmFsIHByb3BlcnR5Lg0KPiBSb2IncyBjb21tZW50IG9u
IHRoZSBwcmV2aW91cyB2ZXJzaW9uIHdhczoNCj4gfCBKdXN0IDEgZXh0cmEgcHJvcGVydHkgZG9l
c24ndCBqdXN0aWZ5IDIgZXhhbXBsZXMuDQo+IHwNCj4gfCBJbiBhbnkgY2FzZSwgZHJvcCB0aGUg
cGFydGlhbCBleGFtcGxlcyBhbmQganVzdCBoYXZlIDEgY29tcGxldGUgZXhhbXBsZQ0KPiB8IGlu
IHRoZSBNRkQgYmluZGluZyBzY2hlbWEuDQo+IA0KT2theSB1bmRlcnN0b29kLCBJIHdpbGwgaW5j
bHVkZSB0aGUgJ2J1cy13aWR0aCcgaW4gdGhlIGV4YW1wbGUuDQotLSANCldpdGggQmVzdCBSZWdh
cmRzLA0KRGhhcm1hIEIuDQoNCg==

