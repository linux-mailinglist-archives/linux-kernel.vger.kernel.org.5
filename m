Return-Path: <linux-kernel+bounces-34966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40B8389F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACC828A134
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119558114;
	Tue, 23 Jan 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o9voDCh8";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qrPA58th"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6246EEC2;
	Tue, 23 Jan 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000908; cv=fail; b=KGxFWrM7xIskMaMo87ese7xGF6Nyn+D6vAWtrwOFRNaph/JumGMPqRex8nJ2csVS1WMBYszlp1lVHgCcLWbXtKWsWBTnqjSO5bPumSwKEheXwwGLTtoY+ZOCRfSz2YpQgtt6sSo7QMmoDeefcjQmK1DyvhB3RNAAypuTS50fyHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000908; c=relaxed/simple;
	bh=bNUfj8hmWNX6f0HEKrV8E8ixQWuWDjyvImNrqGReFbc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fda9JuIJAd7+tr/o+yb92XEk1rwv/XJahTBGBWlThl5DK4t/ExbjLLiIaj1ncIy9BQHgWiB7+ksih/wVrSRAjlamfR6KN4G3XJDGmhTNx2Nn9I05vtdpO9R6gcujsWqvdrZHLcUIu/ASc4u0MaBLCZHtyutWnwx4R2dlkkW0MPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o9voDCh8; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qrPA58th; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706000906; x=1737536906;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bNUfj8hmWNX6f0HEKrV8E8ixQWuWDjyvImNrqGReFbc=;
  b=o9voDCh89hh98FqtW0cEs5IkZunmz7jjRbD8QicvcpGRM//deoQkddGX
   99wqilqyn4A+WbiKifNVTFpX+YV1Mr0JL7zKxtj2hLiWa03GMtDp0+y/h
   VhnEq6dfNMf8KHl+nT2howJFKPXK8L/9h/Vw5SwbFsNh244mscCndv+Gx
   F7/Zy2P9ODSpVdc24NVlP635ZVZzwSACoJvAzUggAHqmKEquWwwiALmH1
   5M8zPXMyChtFsJY9RWVpduVPA0BeS1DNSxqvIuQyAgeMqxlB7MgF07q2w
   44dB++iJnbG5Z7ygn+qfXGlZ4PZI0wjFkQSV28E3mH3QL/RLWsrHuSrss
   g==;
X-CSE-ConnectionGUID: cSU7oFZASp2r/LGMOCobvQ==
X-CSE-MsgGUID: grhFXikVTDqSvFk7iqqfow==
X-IronPort-AV: E=Sophos;i="6.05,214,1701154800"; 
   d="scan'208";a="182391179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 02:08:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 02:07:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 02:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ7p3d3SE9s30qPrW2Kjf/O/7lG7YTX46ALXNW4MTtSa+di4syTLP73bVSdXxwX1NDA0uk2wqjRHUITUEPrYzkYbgP43A8oaDqxo/JfeLyhGJQ4KlGZeJWnS/M+qjjm/Uo+UBR+/yJ2jVxGZARN70HvuQ4XN1+37E0u+Soj376UwQk6dNKtR/EqDhUzzcpEfHP2THWqS1xK/ICcYhtLUHmBuDSDJnOtjk2zk2KbGqp94zqiQPXpOscyARnVK9QUeCgA8sibxwBWtMKsZ2lGdg446tlacLCVyE0oGk8++TUrcw0xz+WCiKedmmowVrqpFwkdUc9Wv5Ssj2GxgB8l1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNUfj8hmWNX6f0HEKrV8E8ixQWuWDjyvImNrqGReFbc=;
 b=Tjica+flBj1OebvVyCOx6KJAr5Hl2f7+eBS1//Ld7u0OmdnugGf0z/zAOVxQ3+tOObEK2Xib9aAhqsvQ6x9nyJvMR1OujrsPdKQ8T5FzvW1Ifn5huKGf0OIIa6IJfMGoRWZ+/q49Kqa+JZUYK7yK5ucH+Qf4DSXVfewH5jz93DjVbu+EFR+qsbZkBNkjrb4SQB8CuC/67kP/b9KtlUqBFCzYZq5Cu6yq5ppoFYJ3NV6AJeWFeN8UCp40UqscbV4lq367AC/iZ1fPokLs7HkBzHmtIFrl2Yjb+zvi2eC3NbA4iAGa/3ynvxSaHbNqFOW7l6MxFKrs3SNXB/Uc2fgsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNUfj8hmWNX6f0HEKrV8E8ixQWuWDjyvImNrqGReFbc=;
 b=qrPA58thQ9aZ09jw7UK2qdBXP1jaM3A7h4+J/7qXNDh03g00sRijyO6JPgjNq6wkYfkYDdVzE5fabDs0SPx1D/cmVsj4o3wgMIswR5UGxRy/EFy6WZb16D+MUfEuy0AoOKAq0aCO/ST7OGQJlxvUbbue7LGzQKyBueE2rMOjyaoeV3brNlcfyM9JWnRkUvokJtgHi1GF/T0VT+ul/m3TrCdgmpcYmBi/dXsbMOp4fnNBg+8n5w9fH3ndO+b8TdDO31na8ncIM+3gZhsf32e5Uaa2a0Nk6x1HAIuIajOq3iS4orxaDw9vpdE2nEbmBvxyu+BSg8FtDN++Gt1vsRzURw==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:07:43 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::f267:b0f5:662:b562]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::f267:b0f5:662:b562%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:07:42 +0000
From: <Mihai.Sain@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <claudiu.beznea@tuxon.dev>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] ARM: dts: microchip: sam9x60_curiosity: Add
 power-supply properties for sdmmc nodes
Thread-Topic: [PATCH 1/8] ARM: dts: microchip: sam9x60_curiosity: Add
 power-supply properties for sdmmc nodes
Thread-Index: AQHaTda+6oADpGVfWU6R369Xoh+n/rDnFZuAgAADXtA=
Date: Tue, 23 Jan 2024 09:07:42 +0000
Message-ID: <PH8PR11MB68047F3DD9D23C6749D7F86082742@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240123083158.7339-1-mihai.sain@microchip.com>
 <20240123083158.7339-2-mihai.sain@microchip.com>
 <c289a167-031a-44cc-ab62-0fb0adcab2bb@linaro.org>
In-Reply-To: <c289a167-031a-44cc-ab62-0fb0adcab2bb@linaro.org>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 8bc48a0b-da7f-4dd8-f3aa-08dc1bf2c1de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nwv9wc2WJZYD3EO7GWUtryclUgJogh1Y+6AtS2LV1HEkZMGd4tGA59P3g+ZX5vwmsCOkFaYWU+EJ/TCaezp5wmt7JI3gpim5Iu4latfPh3sWaBJOTmnF75QTrADA0o0I93q2diB2wK8bvYG3zkrenZkSGK+sIf/n+AcLv206m1sJrEo5CPP0s9Kc7gppkmKr+7UHMLxwugFPNb9mmUh+w0I3Bg0r8XexRI7LegLIgAD5OJdXU5fjfcp8iBZk+Sp+uhn/cnv02RM+A0mkyFyAptje0fgbIZLUNmoN8k6upZKeatRLBKva9vcY2vYFPYSpMx7rUQmZnXzl6LOzGrrflSc26gqKu6eB+X1m3bh+TuicwxID4HnwsWNxy8BF7nQh6p4NiIVoNlZXDxQxfN3glSKWDiEk9uI0X0Sz7mAk+nbZRq/HOhQAkDiNS7loeKQQ5axxcUpXu1vN5nlpnriD24AfyKYi4NFrEsw4Kl8HS46G1aFR3gx+fJ84PZvvl+X9aqK4N0ZcJbPtRlStIgdYtMWfK7F2G670ilO9l5Dx7AAfWXj8NGvEArNnc+NztHEQihYMIqJNXV2PBJa5+Ac8D+KZegWIL4jxYintyJpspVAPolrZQAdwJappGWhtcNksokNTAqHD6Ta0TYdzxYydkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(38100700002)(2906002)(41300700001)(33656002)(86362001)(110136005)(316002)(71200400001)(66446008)(66946007)(76116006)(66556008)(478600001)(66476007)(64756008)(7696005)(9686003)(8676002)(5660300002)(8936002)(6506007)(83380400001)(26005)(45080400002)(52536014)(38070700009)(921011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUtzNzdwU3pxWXI1d3VIOE5Ib1lRY21YVVo3TzNhNURkZ05lcnRsQnR0NUF5?=
 =?utf-8?B?MEF5eDdvWDcwTDBkRnY1OGswaDlad0x5S1F0RXJSMDV4S1NjMzJFamlKQ1VY?=
 =?utf-8?B?MUxjVWdwZG13ekU5eTdRdzZnRjI4dS9MeTJld0xwUDBHWFBqZk1xM1JUTWo1?=
 =?utf-8?B?dUdLMElVNVgxbE5DbnV5bExabGtiVFVUTnQ5NlBvZUR2ZjByekRCNGYydXpj?=
 =?utf-8?B?ZitjSk9kY3ErRURsNHZmMzVncnNhMVJJS0xWOGNsZjFOMFlTZzhqNjVTejFR?=
 =?utf-8?B?a1ZmcTdQeWUwM1VneEZNNUpFcGpheEwrTjBMbzZMa2JPWEFaZlllZk9EZXhi?=
 =?utf-8?B?THhMQ0tONmZ5SXBHS3BmWU5ZR2J3d1dxclhwdlpnVW00ZFZzYnB0MC9ZaHln?=
 =?utf-8?B?MUljZlNPNVBDdDE0aFV5a1Iyb2tFb28vYklSV0wyMWpPSGhHUC9JSmg1VVpq?=
 =?utf-8?B?Ynk1QzNIUVBqWFFoZmFHVU9BR3FhR2NBT2tad1U0QUUzdEwxZVhCZkxUU25x?=
 =?utf-8?B?eTc4RXhmakNBSVRReE9zQ1lZYUxpTXVFQXp2VGkvWjdPclovaDZwTXlRWnBZ?=
 =?utf-8?B?VWVPMWVYYTdSayt6UzlMbWo5QWNjWUFTMkxYd1RMMnN4cWMxVVhFc2FNdEdm?=
 =?utf-8?B?US9RcG5RU1NQSnB5NHlEVVBTTzh6cGZKSENsMUt4emFuamM5QVROdk1ML3A1?=
 =?utf-8?B?SlpGdS9PT3I2ZEdLZE81VzI2ODEveDBiUlA4US85eEFKOGU2QWdQTkdlL3ZI?=
 =?utf-8?B?aEFLZmd3QW5mRUlMdHdYRGtSaGlMblNOdkpYeEdFN2RubVF0K2hNL0RJSyta?=
 =?utf-8?B?SGZaZzFBSEV1OWRQTWkvYXFHWXZTb2U2dkdrdS9FWkJLajAzMk42RDJWMWpP?=
 =?utf-8?B?R0RnSTl5VlBqeHg3b1NJN1E3eGZya0hwVU9VQmx3SjBJMU55b1BRR2Q5dHpj?=
 =?utf-8?B?dHA3WXdZcjhrcnh5OEJTc2FCeitZeGpMOVQzcUkwZ3lqVFkvQmdRQkMzdnk4?=
 =?utf-8?B?MEdpWThORXBkeFYxZEt6am1JNkQ4SThDYTZGZEN4c2R0enVISjdtUUYzOUlS?=
 =?utf-8?B?Q1oyTjZWV3NTM08raFVTenl2eVZEUVZjNG5reEtyTGE5WUhOSFlxZWplRmdp?=
 =?utf-8?B?Zk1hekcvOE12Skk2eGIvV3RuempGZzFMaWEvdmZvNHJINkRLRWx1T1BKamlM?=
 =?utf-8?B?Y2tsY0tqaXpaREZ2cjluMUNEOXpScFdaMldHWC9wYzVnUFJja3lXd21SRit1?=
 =?utf-8?B?eHlaaDhtK1NMeVc1VURHVEVhMW1iWXIvbjJlaitKeFBiYW5DTTRYRUZuRWc1?=
 =?utf-8?B?cEN4YXNaaDRsZC8zM2hpYlhRemNyaThqV3F3MFRqSVRya25tV1RwV1RtYmNl?=
 =?utf-8?B?NnJFVEhsNmNDNkFXRnNqcUY2ejFiNW5XYTJXYklCQnJyMzE4dElWMi91R0Vr?=
 =?utf-8?B?NitCTE5JUW9nQlpodGxaMXl0c20rVGlicjR0MllNRnVSdWxvdW9IRzNOZkNW?=
 =?utf-8?B?OHF2SVRzK1ZmdmQ2dVhFeXJhbzZpZU5kbDc1a1Bhd0FRUmxET2NrYUR1MjE2?=
 =?utf-8?B?RGhoWThTRVpRbjJudG1PMUkydS9YWGF0WEJGd1lxUmxQSkFvZ3RLc0IwVmx3?=
 =?utf-8?B?S0tEdVFmMDdvODUzeXFKRENzMHFFN2RYZVJLTVJ1QXRyVmFSSVlDNjNDVGNX?=
 =?utf-8?B?L2t6ZDl0eDhGdXJEUXZtY0oyVDJNMW5jaHhvWExUNlczVDhKdFRtSUw4UWl1?=
 =?utf-8?B?ZVNvcTZFVmhJaklMM1pLcjRNYVY5VXNlVW1hRjl0cEhCa1pZRzJ1OFc4N0to?=
 =?utf-8?B?QlNRbEtRNm9iWm5wZlNoQk9QZy9tT0hXWHArdHVzNFFIUXhYVlV6Nm43S3hJ?=
 =?utf-8?B?a3dZTXdzeFkxWWtyN2pCMEhjdXR1ZFNqWVYvb1QwNUhkRGlvQ21WRTVOMXpn?=
 =?utf-8?B?YjYrVlh2eForcnlPZU9EdFNhd084cjdJYTk5aG04eXIwYUtVdWZGSFdaV1JK?=
 =?utf-8?B?VFk0bFk5cnlZQWgzNVNKVkJibmRxTXNwZ2I4dTZqVko1TVJqNk9yTWVmMnU2?=
 =?utf-8?B?OUJLMHZKUWw3MGFTNERCamxveEszZkFEYTVmWGJsaFZJT3BsalBJZEgxSXFV?=
 =?utf-8?Q?xixCdRXTtAnfacmvacxkjzk5J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc48a0b-da7f-4dd8-f3aa-08dc1bf2c1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:07:42.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNw2apADM+exy7+o+Q/ZniFXuAwseclU1ZFwT6TDArYEuze1IzXqDAEOOuOdaAAq6tHwuqSoWZpuCrUHrOaUFmGRdFKOutmw4171nfwu3Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828

SGkgS3J6eXN6dG9mLA0KDQpJJ20gc29ycnkgZm9yIHF1b3RpbmcgKGVtYWlsIGlzIHNlbnQgZnJv
bSBPdXRsb29rKS4NClRoZSBzZG1tYyBjb250cm9sbGVyIGZyb20gU0FNOSBNUFVzIGRvZXNuJ3Qg
c3VwcG9ydCB0aGUgSU8gdm9sdGFnZSBzaWduYWxpbmcvc3dpdGNoaW5nIHJlcXVpcmVkIGJ5IHRo
ZSBVSFMgc2QtY2FyZC4NCk9uIHRoZSBlbGVjdHJpY2FsIHNjaGVtYXRpY3Mgb2YgdGhlIGJvYXJk
cyB0aGUgY29udHJvbGxlciBhbmQgc2QtY2FyZCBwb3dlciBwaW5zIGFyZSBjb25uZWN0ZWQgdG8g
M1YzIHJlZ3VsYXRvci4NCk9uIHRoZSBTQU1BNSBNUFVzIHRoZXJlIGlzIHN1cHBvcnQgZm9yIElP
IHZvbHRhZ2Ugc3dpdGNoaW5nIGJ1dCBzaW5jZSB3ZSBoYXZlIGlzc3VlcyB3aXRoIHRoZSB0dW5p
bmcgcHJvY2VkdXJlIHJlcXVpcmVkIGJ1dCB0aGUgVUhTIGNhcmRzLA0Kd2Ugd2FudCB0byBrZWVw
IHZxbW1jIGF0IDNWMyBpbiBvcmRlciB0byB1c2UgaGlnaC1zcGVlZCBtb2RlLg0KDQpCZXN0IHJl
Z2FyZHMsDQpNaWhhaSBTYWluDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEtc2FtOXg2MF9jdXJpb3NpdHkuZHRzIA0KPiBi
L2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLXNhbTl4NjBfY3VyaW9zaXR5LmR0cw0K
PiBpbmRleCBjNmZiZGQyOTAxOWYuLjQ1N2M1NGRkZTBiNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEtc2FtOXg2MF9jdXJpb3NpdHkuZHRzDQo+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLXNhbTl4NjBfY3VyaW9zaXR5LmR0cw0K
PiBAQCAtNDUyLDYgKzQ1Miw4IEBAICZzZG1tYzAgew0KPiAgICAgICBwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfc2RtbWMwX2RlZmF1bHQgJnBpbmN0cmxfc2RtbWMwX2NkPjsNCj4gICAgICAgY2QtZ3Bp
b3MgPSA8JnBpb0EgMjUgR1BJT19BQ1RJVkVfTE9XPjsNCj4gICAgICAgZGlzYWJsZS13cDsNCj4g
KyAgICAgdm1tYy1zdXBwbHkgPSA8JnZkZDFfM3YzPjsNCj4gKyAgICAgdnFtbWMtc3VwcGx5ID0g
PCZ2ZGQxXzN2Mz47DQoNCkZvciB0aGlzIGFuZCBhbGwgb3RoZXIgcGF0Y2hlczoNCg0KSXQgaXMg
c3VycHJpc2luZyB0aGF0IHlvdSB1c2UgdGhlIHNhbWUgc3VwcGx5IGZvciBib3RoLiBMb29rcyBs
aWtlIGluYWNjdXJhdGUgZGVzY3JpcHRpb24uIEl0IGlzIHBvc3NpYmxlLCBidXQgSSB0aGluayB1
bmxpa2VseSBiZWNhdXNlIHVzdWFsbHkgVlFNTUMgaGFzIGxvd2VyIHZvbHRhZ2UgdGhhbiAzLjNW
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg0K

