Return-Path: <linux-kernel+bounces-161913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A738A8B5337
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA63B1C21606
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DC17BCC;
	Mon, 29 Apr 2024 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jgPrOEOr";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xtRH+N34"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241EEAC2;
	Mon, 29 Apr 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379563; cv=fail; b=Qb5LkAGVDpS/DZVcCUu4HRUV7JMwt/D5zU4DDXpl3uU1pjq8UdTOEaBzyU0cXuVMGIVdE7x9mWHY8cLSf3KH26ziRM1+zHuXtt/e2mhJjUdKGqIzD+oRHIYyXzMXoEx9MXvTuN4O/9JbslWJzWh3DUH2KzwpfeRvOjVut46k0g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379563; c=relaxed/simple;
	bh=oGj6LNWgaesgHR3nc7+k/6gQceP1Yx7/D13VSwu6S7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRvgvTO7xyZMHhxy+SXl/fTAixP5z0bG/2GS47Z/WCkdJ3oWCNufVCIhVLjs9ZBJoRb7Tky6CZEfyWLnaOLNXGSbiYJxVLdC5B04WPRXtoH4llTWgj2ztONN9Ma0AbE1V+2wiKGWB0EmFA2TZVoA2wQWNqW/xrzTlK08QrMP97c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jgPrOEOr; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xtRH+N34; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714379561; x=1745915561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oGj6LNWgaesgHR3nc7+k/6gQceP1Yx7/D13VSwu6S7E=;
  b=jgPrOEOrRlVYDhjoNLgk5YW/xh81SJELZkCLqzSbtILIineW04ioTofY
   9dI2ySYTYfRiA9rJdbXa5kkN85PI8/gcISBmhwAZsE8iOY4vqysYrlyKk
   dS77iMwq2wzd37MVLeImOiqMDq644sko1zYjQXXbEFvPZL4SJDHVGuhIm
   DvlSgi1n65m/wzj8GA3/rSiD10pjrPJwowDOHrKSw+wxQm5GXNZLudr2d
   uu9ePSaId8kLpPQZgA/FI/HQehbwNvx0Lc5OyjtWS4igyiukuw58WYjkz
   I+ADXTmsReo9FZJb3hsBHCk4BU4foWzk3raI8TDrAXVLjW/cPMBJwD9Md
   Q==;
X-CSE-ConnectionGUID: FL4BCKnKSgmTOXZkb7zAfw==
X-CSE-MsgGUID: 82I4/74USCCINXc4D+LWHw==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="23151177"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 01:32:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:32:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 01:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSd/gwXRSBMpm8V1zUpcSdZTeZjZ8ZUR4vpJnxUZKc53XzY59t8DjfVIZqeXGZR0OguVuzyJ4B0vbBFLDUDqB0n9rGOkxax0qjfP0tgQ6d3c6qfF/qbLhcrmzAZ/lKqZFjCk2ZpIo0W6W/o2KZgXWpT8qNFSfszPo6rVII4ZVlxADjcOzkm9XjFPZYjpyJoyuUX2NCACmTTe4HaHxUlfqjsU5vvYQU6WsyXnBPiavEk5CtpjNn1rP4swl+gig4UOuH3ccUoe/WAgAUHuVL9Rh67fp45mYFlUzcsNt0cos01zeGAjK1r79sVmIFQH/ID3I/8NjtpG9eBZMttH9elaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGj6LNWgaesgHR3nc7+k/6gQceP1Yx7/D13VSwu6S7E=;
 b=msp4FROzmVJjLEK21ofbzngnkWiON7Eeog3lA2oXaTbOymm9JjVJEcvA/y+DMsyg63htYrACymSipChGqB+TwV990CdHp8mTlgHPUx83fRBbp6KamaCJf0H/Fde2dCXb01ZTANXufFzBbIsz+wsc/YuDflLPTmb1ZYAWvxIv7jbidj9iaMgHAQXUEFY9I5gwYKPDMylR+B1Y0ohTdmnvl/nN1NejogEhaC9q+rHind4oqZbBHhOx0KD0acv6Rv2sowxe/7YHw0LZrDT/gJ6hfhV5TkDRWJ9GIViDRiaXHBf1qJxvw1VZCTkkPnXrChGbIUUZ1mRt6iCAfyAgc+CxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGj6LNWgaesgHR3nc7+k/6gQceP1Yx7/D13VSwu6S7E=;
 b=xtRH+N34opH4gBCf5qPX5dbdvj+rD2Hw31cUn5lZxFCQSvCydH+pY+KQfO+76nCph6WxqMFhTXxX6ySEdqp0hBf/OHTrxd9QXhjKDS2i0AKka5lkVztgAeU4sxqoUbkqYZLXvO8G2qma2a6PGz+cZHj2BWb+P8ZVFE0JFXM3Yp9DaFkeboKu4Ma9oq/iuXrQXeG2zV8zKBkm4SSjqhX/8FMauBctQl0u1vo5NX8YA+7fFS9zOxc5wumUtvl6hc/6wleou9O9u9d66NQwFFJVgkrL0s5TmVBExpGVAJ3NSu1qUzlb4Ux9lqPZbJCr6rE2DmvkyR+iRH/J/HygEq+Izg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:32:31 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:32:31 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <ramon.nordin.rodriguez@ferroamp.se>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHakZAeMmJyUl87WkuqM6F297dNprF8mJ4AgAJjugA=
Date: Mon, 29 Apr 2024 08:32:31 +0000
Message-ID: <b82a3006-05cb-43a3-bbe1-4f2f81113bab@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <Zi1Z5ggCqEArWNoh@builder>
In-Reply-To: <Zi1Z5ggCqEArWNoh@builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA1PR11MB6443:EE_
x-ms-office365-filtering-correlation-id: ea6b327c-0d5b-4836-0483-08dc6826e989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VWdHeUNsQmRJcXZBbzZZejA2SlQ5RmJXdnpUOWMxYkZucE0rcjBDdXVpWTBz?=
 =?utf-8?B?Wkt3cDAvMGpGQkcxeWtLdkF2S3FSM21obWh1UFJUTUdLSWxJNzNnUWZQcXM0?=
 =?utf-8?B?MkFGRTFVYm5yalJ3ajZ5QUQwSW5URE9HU25NdC9lN2FFWGRJUm4rOUZiOWZP?=
 =?utf-8?B?NXZ0ZGt4Tm9UUWRxZzZ4RVVLcUVueUJhZUU3MXpPRUdXdk1FUURiZ3QzcFYv?=
 =?utf-8?B?Z3BOeXgyWGhIa2RaTWFvYTZ3U2VKT213UFgzOVhZYlRNaytVQkpmenFUNjQ1?=
 =?utf-8?B?T1RzUUhFV3ZLaSt5VVZ3K2hwRXd3SStEY2hqWXlJNGRiQzZOSjVBekxWdytU?=
 =?utf-8?B?MlE2bWo5bGxtWEQ5SHF4NjVRaHA4Vys4bVhxY3cvNTRNcTlJS1RjM0JwS091?=
 =?utf-8?B?SCt2cFRnc0gzQ3lnYlo3U3QwSTVJcmsxbFc5ejRHMnBEbEx5M2V6MTE5WFRK?=
 =?utf-8?B?R0ljQ2huWGVCYllOTmpWWVFFQjhkTzRmMmlxSjVtMjhaY2lOdmpnaHJGbVRP?=
 =?utf-8?B?a3ZRZVRSbEJBdXF6d2Q0c0t5cnhIVThXTkZMM2RsYjg0UVJnUWtla3Z6WGJK?=
 =?utf-8?B?dmFtZWdob3FJVWJJdlVPMHI2UVcvSmVXdlAyYy9OeVZuY2ZEbjZVUEFtTHNJ?=
 =?utf-8?B?WHNsZEJGL2N5c09zYTN1NGIwZ21mOGc0Q1NWcDM3aURyRWxNcnpYUnRBZ2pS?=
 =?utf-8?B?YnA1blJXV0JWRnUrNldTSWxuUVBQRkdMdkJPUktKR0RKamFhYklTd3JQVmY4?=
 =?utf-8?B?ME05d3hOcDhjVmRrdnhCbyswN1c2dllaY3JlTzQ1dnZqN0cxVVhSZkV6bEdX?=
 =?utf-8?B?UVFseGF4YThidGVMdTNkdFp5b0tRRUxOd1c1UWxBSTc1NUVDT3p1dlJ6dWhC?=
 =?utf-8?B?SzZnWlRNZWZ6ODkxU2lSOWVJQTBxYWozd1dxSitxUkFTSTJJTXR0dmRnUnAw?=
 =?utf-8?B?cmdwN2xRVkhEWm8vL01oYlBqNUp1aDFSS3BUbWFDZUdDS3ZhRjB6ck90K0tG?=
 =?utf-8?B?bHA5cFJpR21zMHpuWS9qcDU0SnhxRmgxSGxuZUVwWlVlY0FEM3ZJWjhIVXNt?=
 =?utf-8?B?WEJWYkQzc2ZsNERPSHFyRWFpNGJ4dlQ4bDdvb1ViWm9aVmphWE0wR1FnWWNj?=
 =?utf-8?B?OURrcjJmVHFZT1o2eGt3T1BJZVBtZFBLalpzaUhvZXB3WGkxVzVRT1VHQUd5?=
 =?utf-8?B?ZVgyaEgzLzd1d0pTTldXS0QyOElSNkJ1czJoYXdTMUs3N3NrWjA2cHBFZFFt?=
 =?utf-8?B?cTB3YkZOcWxnelR3WmJ6ZWM0VllETmlTU2lOTUJsTVB6NkRPb00vM21pZzFP?=
 =?utf-8?B?a2gzRFAvaVlJam05Mm9HU3BOcnQ0TU8xd0krd2dQTmVJemhPMHcyc1FXUHNG?=
 =?utf-8?B?S2JQVjJZNmlBS3g0aHc0R1ZCTDRsOGpSQmUrUkhiNW1uMDZyUzloM2tYVEhU?=
 =?utf-8?B?d2c1WWJ3bVE2YlFTYzNxc2loQUVTbXJ4K3M2U1p4NGhoU2R3ZGlHMGhqUDVD?=
 =?utf-8?B?TXZ5T1VBa3dtUTJsb3NiMnBDUEdPcUxSbFNta2RCbkVkc2FsUldxTWk1QXhI?=
 =?utf-8?B?Qm5NYmxPMWNkUXJHRERzZHc2V0t2OG1LVzI3UklaeEtJcFpxRzdlSFFoWFoz?=
 =?utf-8?B?cXp4UEIxVVJnQUZHUXFnTkllYVc0R2tFUXZjQWdIZm9uYllXQ0IyN0U4Nkxi?=
 =?utf-8?B?UVpNMkkrUWtMWnBqV2JjVUdVbU9MaGpDNVRZNDBSVkpBdUl0SlBFcW4rdWdl?=
 =?utf-8?B?alUyWExrb3FkM3RrcWtGd3VNSkthTlFMM0RhVnljM1dmZnorSmowclcrTDhI?=
 =?utf-8?B?eFF5bWpDMEZyUityT0xMUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzNBRC84bTIxTVVJOU9Ia0w4WjJUSkJyRXVTSmFybVJoWUdXZllBQ3dLMTFu?=
 =?utf-8?B?QWtORUZiU0FyeWJDekxIMzBMdnNJd21PSTc5RG9LZXpxTlF1U1pmcFhsdWhQ?=
 =?utf-8?B?MjhDSXN2Vjk1RXVaRDBTbWZBSE82NGNYSnlMOHlRUkRmRVhENkpXQjc4Vlpw?=
 =?utf-8?B?MXdWRCtNWEFiZ3l4MndYZ3NzMlZNK1gyd0xnMU91S3FDVkd5YjIyTmxDSkll?=
 =?utf-8?B?d0JoVnl3OU5IQ2JUc3ZCNkIwMmVqMUg0bHJJRjd4aVg3YWtJZjRjWlNEeUFF?=
 =?utf-8?B?SFJDQWxEWENNMFM2cGNxMS9oU2VTQnFJQmhQcFNsdklTTHk5Q2FRREo3Ny82?=
 =?utf-8?B?SlNQL0ZEZThNVHNKMENiYzk5allFK2l4aVZ3QTBBOTV3QldsNE9NT0ptYlBm?=
 =?utf-8?B?UUk4MkhnYzFsbHJoOG1Ea0tRZDlSS3RKUzdadGl4cy9sVW5SMkZWWGdNNDNm?=
 =?utf-8?B?dFpPVkxxbm1yQ3BkeGdIZ3VNQ0N1WmZ4R1dyOG1WK1hjaTZYaE9VSDQ2ZTFV?=
 =?utf-8?B?T2YzWXhYREE2d0luMmw0aU1Jd0dJVHZZSkFvcFdoTG41RWpaTjVCRHB6WWRP?=
 =?utf-8?B?SFl6bmQ3c005QmJZNkdpL1VWU1VMR3FsRVYzMGFZWDNGNExORmhmdDh2M0Iy?=
 =?utf-8?B?SmRpSFhWWFlpMGxvY2Z1Vm9aT1o2aDY2c1p5c1NpTjg2MkR0Y2M3WElvZFpQ?=
 =?utf-8?B?VDhzWGM0ZS85eTlIRFBDK211N2ZtUU1qZHhqalVJM09DRnI0YWhDLzFxazFs?=
 =?utf-8?B?WTdjNmtNT0wvK3pNSG9lR2FhZjh5OFNCZEdheElndUNuYlo2Tm9UcVV1MWpa?=
 =?utf-8?B?UXNGNHRnZFFwT0pxVmE2RC9BN1Q0YllJdGxzb2owWm8zOUowNFE3RTFSeFU2?=
 =?utf-8?B?SlVFNFBSRXpaWER4dnU3K25nZFNlZE16TnNjRVk2UFZQc3hnQWxXUmRtK0lr?=
 =?utf-8?B?OEd6cW0zbWVrM1BlU3RlOEJGWUl2bitXRU5rNFU1S1I5TjZocGVyb3JHSkFM?=
 =?utf-8?B?cTZiYVZmVXBaWXEreEZ6cXVSM1c4RUp1MkNCUmhmV1JoNEhZVmFRU1FnS0Nq?=
 =?utf-8?B?TFNSZ3ZrdnlEOFVSc3dJeUxmRTA3VHVqbjNBT2RRV2Z6Ryt6S05JOEdqMnhi?=
 =?utf-8?B?ZXRmcUdMLzRWdWJ3VlBGYTRBNDdJWW1ydWV5bnJHc0xQTUtMYk0yek5pdk5N?=
 =?utf-8?B?NjFFaGp5VWFxVG82Qis4KzlCWjZFNHlBMU5pUTZjZWo1N2swUHlFUWRGRGY4?=
 =?utf-8?B?ZERBZEZQWmp3aVEvdEZKVmFqRzgrdzJGTC94R3dpRDBXcjJwdG9mVmpjR0I0?=
 =?utf-8?B?QUFkajM5NDBuOFhGeXg5K1paeEtyc1Q0SWNKUmpNd2FybThtbEtiQUhNelZK?=
 =?utf-8?B?N2ZMRC8wNG1nNTE1b282UWNqMi9PQ0FINExrUTJuM3Q2UE1nWkVvaWZYTjkz?=
 =?utf-8?B?Qm5qSlZkajZoZWR6S1R4eHV5cFdmYkg0OWJ1RUpVNGpiV0JicVZGbGcvVkNF?=
 =?utf-8?B?aVFKOEpqN1JFTUZUdTFyMmJJb2ViSkdUcXJuYU5EN3RFdkh4dmh4UlB5K0sy?=
 =?utf-8?B?QWpUMzlpQndRNHorOGZOd2VzSEt0RERUL0M4Rm9WSWlVQ0E3cTF4T1d0OE4y?=
 =?utf-8?B?bEpjU1p3cXZNNTdaWmVEd3dGcjRkaUFad0tjR0pqMFRKSkh0cnFpR0RNc3c4?=
 =?utf-8?B?cWhlNEtHMXVTdC9XeWRIUnY5MmxtMFRmSGZpc0FmYXZTaDRNcmN3VXZHV2Rk?=
 =?utf-8?B?UjhGTU5DR3cwQm1BaklZZU9zdnd0Z0I4bkRFRWhYTG9rTGRMUWJyR0NRSVJp?=
 =?utf-8?B?T2RMMkw3MytBYS9BdmhBejZyWmdjYWhLVnJhZzNRZ3FoTitGNXFHZzRlVEpx?=
 =?utf-8?B?b2tJaWxYcEJMSzVBRFlCTFh6YXZzZmQwQTRUL3Q0MGZPRUE0cVk5ZTVSWXdu?=
 =?utf-8?B?dWkxRjMzbUkrQTVqUkQ4TWc5TG40TXk1SDZBMUFsNkFFWjVjeUtCNjEwc1JV?=
 =?utf-8?B?QmZUazI0U3R2dE5SU2hKT0k1NEx4NmVFQUNJSVVBZ3lqcjNwLytiSkNya2Q2?=
 =?utf-8?B?THo1bDJzVE1oQURPVDJVVGswQmI0dkhkWkJTb0FGVUlnZlJjSUIzZWxjQU94?=
 =?utf-8?B?R1Y5cTRxNytnS0ozSGhMMmFhTmZXV0tsR1FmNEp6QUVKWkhQRFpMaW8yMmpY?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F6F871F4209DB4D8F0F2FD0FC5E91FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6b327c-0d5b-4836-0483-08dc6826e989
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:32:31.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNuxs5vxq2hyh1P3An3025ppeZunmbI98nvkHjBe8dX7lqVigHfpSxQOV1XCgj+x7zGKzwxxMFihkjEX3P1M7TZ/DeFFjffXlpw6b6TkMpnZQPpk63IRBhhAELIev7Ji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443

SGkgUmFtb24sDQoNCk9uIDI4LzA0LzI0IDE6MzIgYW0sIFJhbcOzbiBOb3JkaW4gUm9kcmlndWV6
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IENvdWxk
IHhmZXIucnhfYnVmIGZvciB0aGUgZGF0YSBwYXRoIHBvaW50IHRvIHRoZSBjdXJyZW50bHkgYWxs
b2NhY3RlZCBzb2NrZXQgYnVmZg0KPiAgICAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHhmZXIg
PSB7IDAgfTsNCj4gICAgICAgICAgc3RydWN0IHNwaV9tZXNzYWdlIG1zZzsNCj4gDQo+ICAgICAg
ICAgIGlmIChoZWFkZXJfdHlwZSA9PSBPQV9UQzZfREFUQV9IRUFERVIpIHsNCj4gICAgICAgICAg
ICAgICAgICB4ZmVyLnR4X2J1ZiA9IHRjNi0+c3BpX2RhdGFfdHhfYnVmOw0KPiAgICAgICAgICAg
ICAgICAgIHhmZXIucnhfYnVmID0gdGM2LT5zcGlfZGF0YV9yeF9idWY7DQo+ICAgICAgICAgIH0g
ZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgeGZlci50eF9idWYgPSB0YzYtPnNwaV9jdHJsX3R4
X2J1ZjsNCj4gICAgICAgICAgICAgICAgICB4ZmVyLnJ4X2J1ZiA9IHRjNi0+c3BpX2N0cmxfcnhf
YnVmOw0KPiAgICAgICAgICB9DQo+ICAgICAgICAgIHhmZXIubGVuID0gbGVuZ3RoOw0KPiANCj4g
VG8gYXZvaWQgYW4gYWRkaXRpb25hbCBjb3B5IGhlcmU/DQpJIHRoaW5rLCB0aGlzIGNhbiBiZSBk
b25lIGxhdGVyIGFzIHBhcnQgb2Ygb3B0aW1pemF0aW9uL2ltcHJvdmVtZW50cy4gDQpMZXQncyBr
ZWVwIGl0IHNpbXBsZSBhbmQgb3B0aW1pemUgaXQgbGF0ZXIuDQoNCkJlc3QgcmVnYXJkcywNClBh
cnRoaWJhbiBWDQo+IA0KPj4gK3N0YXRpYyB2b2lkIG9hX3RjNl91cGRhdGVfcnhfc2tiKHN0cnVj
dCBvYV90YzYgKnRjNiwgdTggKnBheWxvYWQsIHU4IGxlbmd0aCkNCj4+ICt7DQo+PiArICAgICBt
ZW1jcHkoc2tiX3B1dCh0YzYtPnJ4X3NrYiwgbGVuZ3RoKSwgcGF5bG9hZCwgbGVuZ3RoKTsNCj4+
ICt9DQo+Pg0KPiANCj4gUg0KPiANCg0K

