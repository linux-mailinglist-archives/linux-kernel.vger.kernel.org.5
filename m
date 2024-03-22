Return-Path: <linux-kernel+bounces-111123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6416886832
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C521F2457A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037E17C62;
	Fri, 22 Mar 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZH8OK+LF";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sEu5V4On"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125181B277;
	Fri, 22 Mar 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096133; cv=fail; b=oe6iX5S8goMwfw28OOAfTXFsKimo6Mbc3T1RJamcI9IG+ytuE+W36IMeNEsHXudXbQWIS8Fna6G+Tg51Q+pJ7GtZd9K7kvXdHk6e6HZvGc/eTIVSOmcSTR7mOhR4ikJMVjO9+e2fx+IHb8Qmj7rj4P3doQdc+Ei1cOrSY3uFvcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096133; c=relaxed/simple;
	bh=OBo/tb/70y3jzTrcTRpoXXt60WrtS8NDErCwu4VTplY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AIZxLwT9O2OonEfBpvrys5cXh8E9ot+5N6zWchuqAY0Cdb9nLPcGcveVuj+jkc8sB8jv/KBYcOxNNhERIv6NhMTS6WWxYFgtHOsPMUE+DNmj51RK6Y/fC3ys6UlXOSEqqrE52qGOWzoo3bTgXNSbC9AEqBJgj/DpiqRT0kvhaF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZH8OK+LF; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sEu5V4On; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711096131; x=1742632131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OBo/tb/70y3jzTrcTRpoXXt60WrtS8NDErCwu4VTplY=;
  b=ZH8OK+LFwMcLWuNOlzA9tdaiTzymQOvQxDw8Z/EXWzPafnAxxgDUel7y
   ZB+H3UCHSUwcQul1oXkdRFecSwlrki5pub0ZEXE/Sbod/wFxzhqIt7gKY
   ALRU16hO8ZJGKZoEAKxRADrRrGHKvdJv4oHpaeeDtaIyCGsT2q0HHxH+Z
   SStLjIpMnMX2R3Ld9MOO/P4ek4aV9NJejgWlkvA6ScYT8KQCa/b06uX9H
   GBaU2ywp6v5UO01VibtNAvlHohe8dxTSuGxgWOZTxJO0US/e45fjFkna8
   Q1OPS9GY6ncnvQoOlZI9rTorJAVqf6BekvAA3SBhx250TIZDj+JCVFzwv
   g==;
X-CSE-ConnectionGUID: 7cRZVOA6TQyD8KbnDeMT3g==
X-CSE-MsgGUID: CsqBXNV7TOan2cVL55Jyfg==
X-IronPort-AV: E=Sophos;i="6.07,145,1708412400"; 
   d="scan'208";a="18547480"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2024 01:28:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 01:28:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 01:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRHUZ2sq0RrkmDatZ9+soRvDDbaOFookD9CxTsvx9uuXowV9xlwAtHPCpwUmTYwGv0w31gnC28MacGwv0C9iewLt1lIFb5ivRmCwEKIzPCj+QmTUBM0atRo6xMhWtb3TGOZKWrLDrHlJnTUzx/gpOl6owaSnUis1vhb4Zxuulxoe/2O+Hp6vbGj5qMyEYOzvkNHQUwc1h/KdF/cQTmKYdJoOaqJ8yWmpS47m9AEXLyLLNkA6WInsa1P56TKnTiAWDDL5pIEPjzRnwdchBZOBzqBcCQYcPNosKaBptsFeB8rVzwigjSHcVIzgU0Gddt+5a5VCX0/za65AYHwpQSbqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBo/tb/70y3jzTrcTRpoXXt60WrtS8NDErCwu4VTplY=;
 b=S+2d4W6+gYNt19p5JFt0MHLAbXuVmFHQgp1vaI7heO5n4lme47Vt/QYBg6CDq+Amf6dDI2NvKCfxxN5XGuI8FiXtNzcggHBqv9kKaEj+cToyjOMbe2y1eiKT+WJUgM2/7TEqPSl1rRV5SxTIYJgTFfTXDvCyDNyW14mbS95taSfPl1Y3OIo7d9GBi55bZe6gGzRHeaOkGWBIaufDB/svsKSao9ZIA3TjGg+bovwAaytX98+wMALiqcuDcDdW2D4F+XK+MJmBh2kpQp/LQzxBCMi1ice3oytSJ0dr4isbn9ug/IlxC79N6/wnHEvXkAVDkjYgdIGqG1dnQT8s0KGVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBo/tb/70y3jzTrcTRpoXXt60WrtS8NDErCwu4VTplY=;
 b=sEu5V4OncHZtmFVtHng/jL+3dCuNe4h+tdxKmeFl/VtNVCMlgPVQM+7d8HTMlfWdpVTa1mAML23gds38JtaWWAExY61eFiagpwy0p12qHTwr4GZ3tXUfbFiXMd11OJze0LRoVF0OFK/Cj7dJqAFlfeZ0qlOofe7D75ZFv1VhqhO5w13Pz8pbeLlQZCDJRxoK5JinU/84FC+0I3RjhCxxa+nLpYrHq3x94H0B6T1B0R9CuM4Ek58VZY75G+jZDwh/ADSOT82yBsNrTrusvNcg4gwliVhWqOW1QTmPIKXT4l1VCHrykREiQoKu5Azha2Ss/BksL7/AM5iifMEeg8MDUw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB7708.namprd11.prod.outlook.com (2603:10b6:806:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 08:28:38 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Fri, 22 Mar 2024
 08:28:38 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <conor@kernel.org>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHab6Ox6ghenOTJpkWNbGLTwd03cbErBYYAgAAJFoCAAANkgIAVU1wAgAAUTICAAX1RAIAAAHgAgAA4LwCAADuQgIAA+O2AgAAKtoCAABfTgA==
Date: Fri, 22 Mar 2024 08:28:38 +0000
Message-ID: <b3c5d217-a5e3-4957-884c-02e8c10aba9d@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
 <20240321-upcountry-finless-b0e9b1ab4deb@spud>
 <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>
 <d41a53bd-ea1e-476a-a18c-ed51dbac0a98@linaro.org>
In-Reply-To: <d41a53bd-ea1e-476a-a18c-ed51dbac0a98@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB7708:EE_
x-ms-office365-filtering-correlation-id: f8912ae0-8ce9-48a0-b475-08dc4a4a12e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1VtQR8r2KNe3N3tsjaabzJstZj/S/+AL0HR9MxzSAUQmBEx4yLYs2jnWb4X2hLFEjoTVnxtZDTBhKASNzy0HGFZheZ1rA6/zGAS7HY37GhZyBxpYOsJCH3JI7dol0khgO3tlhNEPa9TiFoyvr/3TJw/SS0z8Yi4hupfqdras1+ePzPEMfNQjkk8N0GAAmzS6dFKEcsdu+nJDFi48Gcm/x0KV7Q0biuPFjyAhRKARVtDDDaJp7TGJJ+O1pnAB8JPnrvnzn29kFQKRdUK63HQopXa23Ig4ETJ3TmAPnFoMEtO7vBw6ndKdbac+AqdAIYfkZnnb4JMGxc7oYo8Buk2trjAPggwRWfgNERbxHun/oiIpDkpHIDKar5FVU8stu4xsnelpTu+cP1zC98b5zTPXVxj7nDopyGUCl0m/CJBpDPwjaDsbw3OdxkFJ9zQFGoIpJnIBrwTItE/iuAgzn+QxDC6DBKuyxPQQf1OOPrENGkh2mCYfSok17uIvG12nDPl8SMEXz/V7mo0fzmJUp1CfF30ZUa3zqxND1gACy/rGkKbDkECq+sZjGE/grCs9CG3jfG89/U2W9r44B7AxbdCrg6mwDI4maanAuYQRtIL5P8q/1G10yZEEujLFag7MV2XXouQAyfsITv/JsftrHOToXkqBvB5oLDxPmxU2UEkIMvXfKsLn7dZc03FAjtUts0Rwdzf4Do6TReDNa0X00WNPbqXeP6yGzUeAWg940VHJ8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9qMnlPaGQvUVFKQ3djMUIycmhkeDFiTkNYdkp5WUlpOEY5OHl2aFRCWDl6?=
 =?utf-8?B?cTAzcnpvaHZBdzJrMksyM3lKMC9nSkp2NklPdVVpNXJkM3FUZ1BYVlFJWTJB?=
 =?utf-8?B?bVFUd2ZEVEE3OUpTb0lsODFnaEJnNExOcjgyeFpoa1c5NVNXNi9pdWxCVEJW?=
 =?utf-8?B?YjlPSXFGWjY2dzdYWVlhcUVOY1pUT1FiUEJSN1F2SDdTUVp1SFY5enFiMklv?=
 =?utf-8?B?ZjIxVUF5K3U4MGxhU0c4WUVlNytwTlhtSlZ5b2lVbFlXT0JqMisrWGZCblQ3?=
 =?utf-8?B?SktjMUdXY2lrbUllMGhjK2tHZkNCam9RWFlCRmdiQWZqdDBvYjVXVXFqR1lX?=
 =?utf-8?B?Z29KNDZISlNGTi9GTldDeHgzQm9VclBvRmZyRTNjaS8vcVY4UFVxNFF0NFRO?=
 =?utf-8?B?TzVnV3FWL2pucXA5MzI5SkRsbFVGUTl5SkxOZk1hWndmam5jdkh6Tk9JQzhq?=
 =?utf-8?B?R0MydW5hR3V0azVzaUhFcU1zMGYyazdwMmJ1TTUrYkFTUHg0UjhVUzlvY3l6?=
 =?utf-8?B?S3hMR1N5UlkwSEkyTVozZU1QL01OcW9FMVQyNG9jeVAzMEZSbjVIYndwU2gx?=
 =?utf-8?B?cmFReHFaSnNTWHluSjVlUUR0YXhHaVNmb2JVcW5XY3kwbWd5N3h0RG5oeWNS?=
 =?utf-8?B?M0lLWlpqdWxGU1B1VU5kNE1MVExCODdqZ1FXTWUxZ0J3cktrNnhkTjhoOWxK?=
 =?utf-8?B?M25ISVk2cUZrbkIxYzYxMWp5d1VSTllWV0VMQXM2MC9jQTIzTkhRc2ZMZHFv?=
 =?utf-8?B?VFlUVjExSlVnN040TVpXOEpRM0tTVkhuZ05hUFB3NUNhN1ZxOXIwWWxJTjdl?=
 =?utf-8?B?SnhpMXlZbXpxbjhGWnF4VTBwUnpQYldyUEFmZzk1cEhKUWxJS2FyUTdWbVg1?=
 =?utf-8?B?YWEzazFBVUR2QlNTenRoT2VFY1BOWjQyQ0cxYTZNWmVWUkRma3BZSmRHU09o?=
 =?utf-8?B?dVd5NDFCRVhUb3htOTUrWUQvRy9Qc2NqeG1uWVRIc0k1V25DRml1U1d1VkNt?=
 =?utf-8?B?L05TN0dsYmE3ZnF2MHU3V1ZmS0hFYjY2b0VOakF0aUZxSERRV1ltZEJEUUlC?=
 =?utf-8?B?VWFpRTA4WXgrZUV5L0c5UXB2YkRCTmxiS1hjUWx1d3lZMU5NWDNDZUNIYUFN?=
 =?utf-8?B?YnUvV1VsUTg3a2doWFg5Zy94bUdJcllkUjZNOFJBQ3ZFaWpqSFFnbTJMcnpN?=
 =?utf-8?B?UkFsNWttUUp1VHdHYnJ1MlUxZ0xnblZRcWpza1hvZXdJZWY2OVJaeHllejY5?=
 =?utf-8?B?VHJOZ1g2bzVtWDFOaVVhVlhuZm1YTmxRYzFmZUh5ejMzMW1ESXFpMlQ4M09F?=
 =?utf-8?B?OWpVQUJDeXo2ckFMV2dqOGFmM3NOelMzYlAzQmY4c0M5NVZyZEZmZHNpTzVq?=
 =?utf-8?B?Y2xDNFRlc2FtcHpIZSttdWRLYjFSN0hOblVXMGpPdVo3enEzM1YvY0Jaa0pk?=
 =?utf-8?B?Z3lHdGdiaHl6Wkd1M29MQmo1RVFVc1JKc2Y0VVlyRFFlTHB4SE5mKzlaWmF1?=
 =?utf-8?B?VFRubjUzTTBhSmlLNmwxcTZ1VCtnQWQzVkpNS0tkV0YxV1ZmQTY4OFZiV0cz?=
 =?utf-8?B?SHFRc3JHM0QxSmNKWXBoS01HUmcvb25rOU9TYXBKSzNJSTM5K3kySkVESWRB?=
 =?utf-8?B?b2xodEkxS1UwSkpoWStrQ2FYclJITmVvenk2eHBwanFTcFRrZ0ltT1hqSElI?=
 =?utf-8?B?OE94TVV0V2hQdndQRisrd3VsMEtWNWlhaTl1UCtoNzAxNnBOaGtjR0tRSTJh?=
 =?utf-8?B?WXlBQkxyc0NjL2ZpVmNVR0luY3NOSUJWZnl6UytDSWRNeTNJdWE5Lzc4allj?=
 =?utf-8?B?TU5VK3NXcUMwZi9LRTliQVJiMFVMQUJ1OHZsaG9aUHZnSm1PS1lxV3d4NW56?=
 =?utf-8?B?UkRzMlp1UDVTVldDRWxBOU5EenIzZzE5STZsTUVhNDNrWk1CdGdBSlUweXdQ?=
 =?utf-8?B?RDRrV2p4WnE1ekN0OURzNEc2RHZzKzJ3dmdmLzBIb25ST0EyMk4vKy90d09H?=
 =?utf-8?B?TCtUd1dsQUxDUEFPOGNtWi9tdDVFMmlnWWpIVG5zdzBkWVg0bVJyZit3eCtw?=
 =?utf-8?B?ZXN4RWlmMHRBV0Zjem40L1hTeUJ2Mzk4azIrK1dhQ3phWDhPSjZ5cjNDNmdr?=
 =?utf-8?B?VWtLclhwbXBiYmR0RmpQclcwOEJpL0F5a1M5VUFGbUpPN29TVmNzNmZ0WWVv?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B494678BC6CCB540B3A52D483E71D1DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8912ae0-8ce9-48a0-b475-08dc4a4a12e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 08:28:38.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDQCniAYbBDqgzdfHLTZI5x7FomeJVYOXT1uoZ0R0ZRcR9CF2Rq4zkYf/9tzieOyWd5oY15UgW9gTr7en4HDSTIXD9Rheb3BHMMgi6Bf91VUDg5GZAzLhfLBNwo5GiPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7708

SGkgS3J6eXN6dG9mLA0KDQpPbiAyMi8wMy8yNCAxMjozMyBwbSwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAy
Mi8wMy8yMDI0IDA3OjI1LCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4+Pj4gcHJvcGVydGllczoNCj4+Pj4gICAgICBjb21wYXRpYmxlOg0KPj4+PiAgICAgICAg
b25lT2Y6DQo+Pj4+ICAgICAgICAgIC0gaXRlbXM6DQo+Pj4+ICAgICAgICAgICAgICAtIGNvbnN0
OiBtaWNyb2NoaXAsbGFuODY1MQ0KPj4+PiAgICAgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlw
LGxhbjg2NTANCj4+PiBObywgdGhpcyBpcyBub3QgcmlnaHQgZWl0aGVyLiBZb3UgbmVlZCB0byBh
bHNvIGFsbG93IHRoZSBsYW44NjUwIG9uIGl0cw0KPj4+IG93bi4gQWxsIHlvdSBoYWQgdG8gZG8g
d2l0aCB0aGUgb3JpZ2luYWwgaXRlbXMgbGlzdCB3YXMgZmxpcCB0aGUgb3JkZXINCj4+PiBvZiB0
aGUgbGFuODY1MCBhbmQgbGFuODY1MS4NCj4+IEFoIG9rLCBub3cgSSB1bmRlcnN0YW5kIHRoaXMu
IFRoZW4gaXQgaXMgc3VwcG9zZWQgdG8gYmUgbGlrZSBiZWxvdywNCj4+DQo+PiBwcm9wZXJ0aWVz
Og0KPj4NCj4+ICAgICBjb21wYXRpYmxlOg0KPj4NCj4+ICAgICAgIG9uZU9mOg0KPj4NCj4+ICAg
ICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTANCj4+DQo+PiAgICAgICAgIC0gaXRlbXM6
DQo+Pg0KPj4gICAgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTENCj4+DQo+PiAg
ICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbGFuODY1MA0KPj4NCj4+IEV4ZWN1dGVkIGR0
X2JpbmRpbmdfY2hlY2sgd2l0aCB0aGUgYWJvdmUgdXBkYXRlIGFuZCBpdCB3YXMgc3VjY2Vzc2Z1
bC4NCj4+IEhvcGUgdGhpcyBpcyBPSz8NCj4gDQo+IFRoaXMgaXMgdGhlIHRoaXJkIHRpbWUgeW91
IGFzayB1cy4gTm9uZSBvZiB0aGUgcHJldmlvdXMgY2FzZXMgd2VyZQ0KPiBhY3R1YWxseSB0ZXN0
ZWQuIE1heWJlIHRoaXMgb25lIHdhcywgbWF5YmUgbm90LiBJIGFzc3VtZSB0aGUgbGF0dGVyLg0K
PiANCj4gRmlyc3QsIHRlc3QgeW91ciBjb2RlLg0KQXMgSSBtZW50aW9uZWQgaW4gdGhlIHByZXZp
b3VzIGVtYWlsIGl0c2VsZiwgSSB0ZXN0ZWQgdGhpcyBjYXNlIGFuZCB0aGUgDQpwcmV2aW91cyBj
YXNlIGJvdGggaW4gbXkgUlBJIDQgc2V0dXAgYmVmb3JlIHJlcGx5aW5nIHRvIHRoZSBjb21tZW50
LiBUaGUgDQpxdWVzdGlvbiBJIGFzayBpcyB0byBjaGVjayB3aGV0aGVyIHRoZSBwZXJzb24gd2hv
IGNvbW1lbnRzIGlzIE9LIHdpdGggDQp0aGUgY2hhbmdlcyBvciBub3QuIERpZG4ndCB5b3Ugc2Vl
IHRoZSBhdHRhY2htZW50cyBpbiBteSBwcmV2aW91cyBlbWFpbCANCndoaWNoIEkgdXNlZCBpbiBt
eSBSUEkgNCBkdHMgc2V0dXAgZm9yIG15IHRlc3Rpbmc/IGlmIG5vdCBJIGNhbiBmb3J3YXJkIA0K
aXQgYWdhaW4uDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KPiANCg0K

