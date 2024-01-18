Return-Path: <linux-kernel+bounces-30373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE7831DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B9B1C25319
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C72D045;
	Thu, 18 Jan 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ifUJ7YaR";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mmVaHb8V"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61382D021;
	Thu, 18 Jan 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596766; cv=fail; b=rc3a9vZxS8/aGFNbWSlXYUwR2nqFVmHyAm9PvQkUVOxCmQp9v0X1rSOPGMlN/3nVtcIPH0hvLV+/YOmCVkdeXzodQSuccLtkb68+TilplchwyvYv3M7/BS/nxaKk9KaFXhNoncwNl4bI41Z8I9PEZaXvyfzg9kYg5T72xJfVLoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596766; c=relaxed/simple;
	bh=v0v8b6pfmLu/wSWQ94+qbWtvcv7IDkkiUEkm4KIcdvE=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=lWKlrM2Kx0exBoJz9+wcmMfvF/qTNVbPi36ICOmXoalyoh7ONKIHOJO5wrB1lYssAU5q7vr5UhcisGTscZ29NTi4dXCVU+N7DJEcY88ip2TaijeHwRBuQngPVwZ3gX5A2uauwFW2x2kh8MGNzxjjdl9yXbYAVq6lhRKuRRQbjlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ifUJ7YaR; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mmVaHb8V; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705596764; x=1737132764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v0v8b6pfmLu/wSWQ94+qbWtvcv7IDkkiUEkm4KIcdvE=;
  b=ifUJ7YaRxmEyM4+YP6eoq7XFoyex+buuBzQmCOgkV2zM9TmU2FZimW8h
   xrzWjbGRg/8SqbuD0/4arilB8N79tLEV+lg0bnrLU2dh27P+ihvjQ/YIW
   KzbU0fbh9O4rSn9JdYuRA9Rf/LhmHoWDi/5A5GoCZNYW9QC1DDIAJEsHm
   Kh3POYyFVqk1VGwqJ+K/B/C9qhq880THVIgC001huALmUrLlKKF67C45v
   t32JV6lew9zvmj4Teu3UahioScdvuPKIP8uMJjM3HQILefxRVqAFf96di
   ITm6KqR+YyurO25jocc8JVqla3ZW2y9vs6kwYNNECm5G5gpkSedOigfl7
   A==;
X-CSE-ConnectionGUID: W/je30oIQ1K7uUjGsJxhoQ==
X-CSE-MsgGUID: CIOR7edVTjuc56Jy0jFq7A==
X-IronPort-AV: E=Sophos;i="6.05,203,1701154800"; 
   d="scan'208";a="16157512"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 09:52:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 09:52:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 09:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSD0fQGDW4BF+uwDc4BUYN3jwLadEchmGK0fm8SdvzQb06ejCPGSCn3QC+NU6PmxUF4wKEYtwHCZMzmxccHXwtnVD+af9GN4yX66BPkRyLcZvJRVANTQySYi4MvWrWoTEBb6MOfewLWoObrSd775Kq5J4+htetrDPB0nQpbfQwRr9QMG8xDn4Bo7u8a6wZYKFqyhGoqjBpzsR/GyWTmAFg6dmId+h0CH03nUsNtmK3864Ryfa+AhnMZnuX5GXmIhaSi9Gcs8iz+U78NKWs/dcEyNdPr9nO3TIVH8F6nWaN1gX7t14l3XUTpac/W0XqFeCJxANbMHFuR403oE4imMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0v8b6pfmLu/wSWQ94+qbWtvcv7IDkkiUEkm4KIcdvE=;
 b=jlAbbPT1OmSJwFFW6bF4/wMWS/Y3Ylo54jtO+4Yj6B7RaA6NgwxgUlntolbHXhAzNsiIDyNZOfuxglVErWIcQBwYdxI2deoJepXetRWfNdWVIISdHHCEqd3eIJoRw/0GqJ27OnZQmx7C9d/wI/xT0ayFxrngH6rEI04FiXXNZtpolw0DI9oOkBffbhjSw7j5H+AgYUIjzkRJ9l4V9wPu3U8YTL+LOm+Wie0i7je4latayMfi+p4R2Go2fnsyL3WYs26xCPkWdLN3syjnSoTWOFoh/lsMO6bb0H07NDcJuxpRj0+O7eg44SGLRjAmH16olOo/RcmY/bCrPqm5gndb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0v8b6pfmLu/wSWQ94+qbWtvcv7IDkkiUEkm4KIcdvE=;
 b=mmVaHb8V6GPu5bbQtUBJZEIkc0hE/Alul5PIrlw2CvppSDMmOuhUfGTb28W/qNqPTuRSYO6IUonAxUTrvabKGb10hUtvOSYaWZH57rVxCk22sO8xI7gj0wLaHhNb1DujepQjkSJdSJh0KlBCToZ2y9xDC6d7pO4s3AHRVo3PsE3iYhZ/QYohPmlCnyVV+YFeCtbLaXA+1p8Nvs0wTH1u6jUAsA2LUtRXWe+4o7lzfXtZhixorNE8E/mn3Ieoiy7SJh5/Uoj85bTxly809d+U/Jk9TGx/rw4CETMkHTsYeiLOUXfm2RHf0XaFO2JXDl7otXl1k7ToLYsnSMgq0HSbeA==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 18 Jan
 2024 16:52:05 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 16:52:05 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <claudiu.beznea@tuxon.dev>,
	<davidm@egauge.net>, <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
Thread-Topic: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
Thread-Index: AQHaR8N1F/E9+Yo0nE2y0lDjNrL3d7DfUqEAgABeLICAABz/AA==
Date: Thu, 18 Jan 2024 16:52:05 +0000
Message-ID: <5c5e1332-39de-4d6b-9646-661c78cee900@microchip.com>
References: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
 <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
 <000e823e-ede1-408b-b8e1-fd9c1c73fd6e@bootlin.com>
In-Reply-To: <000e823e-ede1-408b-b8e1-fd9c1c73fd6e@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DS0PR11MB7925:EE_
x-ms-office365-filtering-correlation-id: 569cdac9-7c4c-4e53-1b6c-08dc1845cd69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /h+hGxCVgBHFPUIz6Ny5LmoAbsLRGV00bHc8FZknQOS2yHyO7Hu8Qwcc7+4Pab+dS8oQ1w5RmbmUSUEwq73ALmHGelcKJrEF/U8PPfuZP7Ykbf0dxX7D32IoQ1B9JT7pFL9dg80vdUt32UKA3JK6RKaC2UPnzOq60g+YIeYRjV1ddPBuUHHQ5Rp6h4/2Pzu6GS+3jjYDd34mLq2Z0gUiHkq+UEwYHX6OwU3g5S4R+FQakTwQCm5/+xz0ZalqNPkF1m3AtrRdOlFvUgspXUu99IXW2u+jI1ip7vN7+bF2v1JJ7vBhT0RacpZM1z9bOeO1KFu4g3gL/1eA3bm6aQmV5hbxt4AaLLIWAYGwrtoG46cWe4OsdbrfH2OlYx7quhqSTARrc8S0cEPQxXJOlorCUZW3Qfv7847RAJkJpQuj13VC+Ea5WDhbcYGHEbwW9RzcDBOPbfn1fnfen/VhPDU+mUaSQy5O1Wyge+cBNU1DZl0s8vevBfVMfDPu4IWTGCB9vIyD9IZze+cVhAkUT0v0B5IsGmW9EM6X0MFhXAaukhs2ZkHzW4ivKyvYM/oaMSZuJN+C5aOXI/gpmpcQg6lQsemhrrX8IxUy81iDF+zMqRvRLu0NsjIz4/l7mVL1GZ52j18Nua1LIeh1KdLYFUtpCQuGNkRPD7B+Fj+3lVp/dZdt8RIozG7Hsno5Sx8EUWYOIFho9RXJsddZ6br0LxHEKfClZbfvwYVJiUH9b12bQiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(86362001)(31696002)(83380400001)(38100700002)(54906003)(26005)(66946007)(41300700001)(122000001)(76116006)(8936002)(5660300002)(71200400001)(53546011)(8676002)(4326008)(6506007)(6486002)(2906002)(478600001)(66476007)(6512007)(66446008)(316002)(64756008)(66556008)(110136005)(91956017)(36756003)(38070700009)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXZiSzJlMmFRR2tyeEJrQWdOaGJubXlWOTZUMFRPTmtTV2p1aVRMMU1tcDQr?=
 =?utf-8?B?YlhIb01lMmNqNXM5aGFVSjNiTGFQZlF0ekpTSlFxTlYxY0JkNzFqdGtUUHF0?=
 =?utf-8?B?WFZHWVBnd1E3SytaNE1GWnp3ejNCc1Y5VFdBdFk5MW5rNldjYTZYcThMT1pp?=
 =?utf-8?B?ZlhsWGwybU1tWWh0THZEUHAyQzd1Wm9wTklnTzlCN3IwclQrQmlkcHczNU9C?=
 =?utf-8?B?U3FoWk91c0JOWmEwVEtRUThLdEhaSXFva2ZEamd1a2xmbUFJSnRFT1JNSFBx?=
 =?utf-8?B?R0thWm1zK0VUNVIwMTdyVjcydmdIcG52MjJtMTAyQmVlMVhuTVhUU0N4b1py?=
 =?utf-8?B?VXhMQ0prTE1UaStvSHFCVE9VWUx1UkRTSDV1SGhSREZVOGZ2V0xHWU13L0Ns?=
 =?utf-8?B?Vjg5OGhWb20wQThyVGNDbDVxR1dTUUF0amYwNkJrc3ZLb3dNbEFkejVyVGZy?=
 =?utf-8?B?SHRwbXdTQWRMeFJuMEVyWHdDcTczV2JEZ1ZQQ3ppdVVqTk9TQTB2VyswSy9Z?=
 =?utf-8?B?Rkd6QWNUaERCVzQvRlFTSlJYLzFJN0dWUHk2MUgyRjFzNE94RjNjTTBlWTQv?=
 =?utf-8?B?Z3hRc0l4QnF2azhKcm9GYklwM3dmTkE1VDV0ZmZhSXhxUk50L3Z0NFF2NkJT?=
 =?utf-8?B?QU51bFhiUWNjNEozQjdJUXVFWHhtWEhmYTEyNTNCeG5QTjI5S0NLazQ2blM2?=
 =?utf-8?B?b3Y0cjZNUXRtRkVFWFVmQmVVbFQwKzdGTDZkWnRZMXVBL2MvSERWZm1LellB?=
 =?utf-8?B?alczTy9yTGlUQnRYajJwRXBhVnR5a0pYbVhsWm5SUGhacC9sM1ZYV00yUFEy?=
 =?utf-8?B?ZmpaYXgzOHBZdUlsUEM2a21WZ2svellRQ213RjdROHdRUjVRcVlaSkRCNmJN?=
 =?utf-8?B?N0F2dWZzdFFtTG9WaGo2c041a2pZMlRqbDQvNTk2WitMend4dVkzMFFkSEVF?=
 =?utf-8?B?K0pIK3docVpjbEwzZitqVXBBaGpaV0tqNWJURkJjN2xES2pHb3RvSmg3T0w3?=
 =?utf-8?B?RzlYSEJXVlhmaVFaem9DRWV2L3d0dGVHR2JRWE9YbDFtSnN2b3BuVmFwZU5Q?=
 =?utf-8?B?RUtMeWVTSVBGQms5UXFkUm0wZXVHMytDM1NBVHc1eEt4ZVcxY1lXc0s1MDlR?=
 =?utf-8?B?VmdqR1RYcjJBYmxCeDBkalo1aUdWNmw0TlB6WStqSnV3RWNlRVZWeHRKQnVh?=
 =?utf-8?B?QnF4MXYrcGhmWUxiNTZyTkh3bGk2ci85V3VhOTZialdMeENad1ZlQ3g4N2VM?=
 =?utf-8?B?YXlaWmRFa3E0NEtONW5vNXgzRk94OHdsSWR1YlE2dEFiMi9TR044emgvNWdS?=
 =?utf-8?B?K0RTbUNiRTUvK1B3Q09mNnBtekNtZ3RscjQ5MTUxcDE2WU9uNWc0eCtrQlI1?=
 =?utf-8?B?RXhxN2pRRTNxc2lBbGpGQStmcXBGU3VZTFFta0ZpOTFsMkQ5c2J6U2sydzBo?=
 =?utf-8?B?V1hkSkordGFMODd0ZjllUXN3aFBGRENlcFZicE9EbDNncWwzNnVWQlNxQXY2?=
 =?utf-8?B?dnhFcmZqQmFQS1V5ZFJSdmNhTEloT0pNYzdLU3B6T3FiNzNKYVRZd1h5WVVs?=
 =?utf-8?B?SzdhdjJWNy9GZUpLM0g4TEdDRHVCOUNJalh5aXcvUjh3SzhsVFB3QWo5bzV4?=
 =?utf-8?B?UEllNXdZY0cvQW5MUll6ZDNJaS9zaUNFWjBpTU5rMENRNmllSXlRQVpmR3Nm?=
 =?utf-8?B?em90OGxUYnlQcjdXRnlLaFlNQ1JNM3dxV29KcVk2YmhGSU94WG1JVHQvNGJ6?=
 =?utf-8?B?V200MWx0SWM1ejFJWjZ2YXpxYnFRTGFTMGs3a3ExaUlVZDBhUy9HWmV4Mll4?=
 =?utf-8?B?U3JnYWJQbVNjY0g2bk9hdnpEdVR5TnNBdWVUa3gwRytWbkFZNCtDQTFES3V5?=
 =?utf-8?B?d2NoeE1WMmEzTnI1YVFmSDB3cTM3UEk1TmpYUHA2bnJRa21XM3lWRW5OWTlE?=
 =?utf-8?B?RmIvTFQ2SHdKQmVPZ1NRdHV3elBneDVYc2RLUkNqL1ZZOG01L2tzTGdBKzlv?=
 =?utf-8?B?L1hReXFWc0drdkNXUStxQXJtcDIvck5PVC9Ca1BTMDNZWThHSHczZ1p3ekVO?=
 =?utf-8?B?a1hTK3BNQVU1cS80WjlyM24wYkI2bnpaMzc5SURvaTZlUmVxV1ZwRXZIZmhh?=
 =?utf-8?Q?WhGfTsp7Qj35YNOOraa+IY8xf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89A66133807E2A409C8B0D286DBB7D05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569cdac9-7c4c-4e53-1b6c-08dc1845cd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 16:52:05.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Om0rF72jPezIjGABCjMSpXUIxCPEVztUTSIslznbMrc0wQQRZwQnCjHa/lE4XhMFRa0mL2iINTDOrbefMhrJmE1UFXtIjE05l5cUCLThCu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925

T24gMS8xOC8yNCAwODowOCwgQWxleGlzIExvdGhvcsOpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIEthbGxlLA0KPiANCj4gT24gMS8xOC8yNCAx
MDozMSwgS2FsbGUgVmFsbyB3cm90ZToNCj4+IEFsZXhpcyBMb3Rob3LDqSA8YWxleGlzLmxvdGhv
cmVAYm9vdGxpbi5jb20+IHdyb3RlOg0KPj4NCj4+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5Lmth
dGhhdEBtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gQ2hhbmdlZCB0aGUgZGVmYXVsdCB2YWx1ZSBw
cmVhbWJsZSB0byBXSUxDX0ZXX1BSRUFNQkxFX0FVVE8gaW4NCj4+PiB3aWxjX2luaXRfZndfY29u
ZmlnKCkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBt
aWNyb2NoaXAuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhpcyBMb3Rob3LDqSA8YWxleGlz
LmxvdGhvcmVAYm9vdGxpbi5jb20+DQo+Pg0KPj4gVGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBh
bHdheXMgYW5zd2VyIHRvIHRoZSBxdWVzdGlvbiAiV2h5PyIuIEkgY2FuIGFkZCB0aGF0DQo+PiBp
ZiB5b3UgdGVsbCBtZSB3aGF0IHRvIGFkZC4NCj4gDQo+IFllYWgsIHNvcnJ5IGZvciB0aGUgbGFj
ayBvZiBkZXNjcmlwdGlvbiwgSSBtYXkgaGF2ZSBmb3Jnb3R0ZW4gdG8gdXBkYXRlIHRoaXMNCj4g
b25lLiBJIHN1Z2dlc3QgdG8gdXBkYXRlIGl0IHdpdGggdGhlIGZvbGxvd2luZyBtZXNzYWdlOg0K
PiANCj4gIldJTEMgZHJpdmVyIGN1cnJlbnRseSBhcHBsaWVzIHNvbWUgZGVmYXVsdCBjb25maWd1
cmF0aW9uIHdoZW5ldmVyIHRoZSBmaXJtd2FyZQ0KPiBpcyBpbml0aWFsaXplZCwgYW5kIHNldHMg
dGhlIGRlZmF1bHQgcHJlYW1ibGUgc2l6ZSB0byBzaG9ydC4gSG93ZXZlciwgZGVzcGl0ZQ0KPiB0
aGlzIHBhc3NlZCBvcHRpb24sIGZpcm13YXJlIGlzIGFsc28gYWJsZSB0byBzdWNjZXNzZnVsbHkg
Y29ubmVjdCB0byBhY2Nlc3MNCj4gcG9pbnRzIG9ubHkgdXNpbmcgbG9uZyBwcmVhbWJsZSwgc28g
dGhpcyBzZXR0aW5nIGRvZXMgbm90IHJlYWxseSBlbmZvcmNlIHNob3J0DQo+IHByZWFtYmxlcyBh
bmQgaXMgbWlzbGVhZGluZyByZWdhcmRpbmcgYXBwbGllZCBjb25maWd1cmF0aW9uLg0KPiANCj4g
VXBkYXRlIGRlZmF1bHQgY29uZmlndXJhdGlvbiBhbmQgbWFrZSBpdCBtYXRjaCB0aGUgZmlybXdh
cmUgYmVoYXZpb3IgYnkgcGFzc2luZw0KPiB0aGUgZXhpc3RpbmcgV0lMQ19GV19QUkVBTUJMRV9B
VVRPIHZhbHVlICgyIGluc3RlYWQgb2YgMCkuIFRoZSB1cGRhdGVkIHNldHRpbmcNCj4gZG9lcyBu
b3QgcmVhbGx5IGFsdGVyIGZpcm13YXJlIGJlaGF2aW9yIHNpbmNlIGl0IGlzIHN0aWxsIGNhcGFi
bGUgdG8gY29ubmVjdCB0bw0KPiBib3RoIHNob3J0IHByZWFtYmxlIGFuZCBsb25nIHByZWFtYmxl
IGFjY2VzcyBwb2ludHMsIGJ1dCBhdCBsaXN0IHRoZSBzZXR0aW5nIG5vdw0KPiBleHByZXNzZXMg
Zm9yIHJlYWwgdGhlIGNvcnJlc3BvbmRpbmcgZmlybXdhcmUgYmVoYXZpb3IiDQo+IA0KPiBUbyBn
aXZlIGEgYml0IG9mIGNvbnRleHQgYXJvdW5kIHRoaXMgb25lOiBJIGRvIG5vdCBoYXZlIGFjY2Vz
cyB0byB0aGUgZmlybXdhcmUNCj4gaW50ZXJuYWxzLCBJIGp1c3QgdG9vayB0aGUgcGF0Y2ggZnJv
bSBBamF5IGFuZCBJIG1lcmVseSBkaWQgc29tZSB0ZXN0cyBhcm91bmQgaXQNCj4gd2l0aCBtdWx0
aXBsZSBBUHMgKGJhc2ljYWxseSwgbWFraW5nIGEgV0lMQyBTVEEgY29ubmVjdCBhbmQgcGluZyB0
aGUgQVApLCBhbmQNCj4gZW5zdXJlZCB3aXRoIHdpcmVzaGFyayB0byBnZXQgYXQgbGVhc3Qgb25l
IEFQIGJlIHJlYWxseSAibG9ja2VkIiB3aXRoIGxvbmcNCj4gcHJlYW1ibGUsIHdpdGggV0lMQyBt
YW5hZ2luZyB0byBjb25uZWN0IHRvIGl0Lg0KPiANCg0KSGVyZSBhcmUgc29tZSBtb3JlIGRldGFp
bHMgYWJvdXQgdGhpcyBjaGFuZ2UuIEl0IGhhdmUgYmVlbiBpbXBsZW1lbnRlZA0KdG8gYWRkcmVz
cyB0aGUgdHJhbnNtaXNzaW9uKFR4KSBibGFja291dCBpc3N1ZSBvYnNlcnZlZCBpbiB0aGUgODAy
LjExYg0KbW9kZS4gVGhlIG1vZGlmaWNhdGlvbiBoYXMgbm8gaW1wYWN0IG9uIHRoZSBvdGhlciBt
b2Rlcywgd2hpY2ggd2lsbA0KY29udGludWUgdG8gd29yayBhcyB0aGV5IGRpZCBpbiB0aGUgcHJl
dmlvdXMgaW1wbGVtZW50YXRpb24uIFRoaXMgY2hhbmdlDQp3aWxsIGFsbG93IHRoZSA4MDIuMTFi
IHRyYW5zbWlzc2lvbigyLCA1LjUsIDExTWJwcykgdG8gdXNlIGxvbmcgcHJlYW1ibGUuDQoNCg0K
UmVnYXJkcywNCkFqYXkNCg0K

