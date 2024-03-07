Return-Path: <linux-kernel+bounces-95314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CF874C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3361C2349A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30785276;
	Thu,  7 Mar 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GbcMHRDq";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pnEQuq9d"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEA62A1E;
	Thu,  7 Mar 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806597; cv=fail; b=Yyv4won75oKkrCWqQXAuNgOv4cl/Q/5QFBKFkxL/hARGVdWYWljy/6/ROwuz4/CNlElHr/k7oMPjocu4RDz7nmMMomK3rLn6/bC/kAzfLuSv6JSCP7ycRh3QBQJzJMSc5s0MP0aZweyU2HHVtjXQhbhLFxYkukeAWRE9Nupuapw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806597; c=relaxed/simple;
	bh=1Rz/bpEyWyRxJDMsEjJD4jqD0jl6ZxwK0lmg9aczFr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rPXSFvZZQ/wFrT/iEvWTWx1XdMcRsU6/uilwHAuthPTA57Bu3V8pVwUPnsQdJ1bD303NOc7zBQfEW1OCxx0K+um3SE23GLrgt1i8A3Qt00LjN1gINN6yVZesKfvNmToJBo8GLJyhC/Sfe3sLC/MQ16YupmN6TqKQFBNVrn1d/Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GbcMHRDq; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pnEQuq9d; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709806595; x=1741342595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Rz/bpEyWyRxJDMsEjJD4jqD0jl6ZxwK0lmg9aczFr4=;
  b=GbcMHRDqCAT8PqDHMCnW12ohwYAE2dGICXEzDAy1pBRLNFs/V4hLE26z
   B4bLS5QlhIoNdJDrKHO/IwI6FVq242yqiw2D/iQqMS04mnDiPm1Mjxs2/
   zWigiK0psAFsQKoe4TVm0D05E1ZjG+wHOUP1Koyez7os3SdG54XyFU3xO
   Nxt6wk4+OmEcFraOFiJJK4BTTVYHKSnVWQQy2L1O1cLcrvCbs7lGEI+Yo
   545seb/jCO8YEv4cac86VqSeU+p5jvLGJtPDnFnUcF9l8AS0bFrC6CpfC
   XUCARK1EHeqFODOqTtdSTZalmPlp1vMTnhrtta0PluZdr1xi7Fl6/6rBs
   A==;
X-CSE-ConnectionGUID: N9qkLTLYSiCM80Db5IbgRw==
X-CSE-MsgGUID: 14rf5zYWTa61eVpAl2GjLg==
X-IronPort-AV: E=Sophos;i="6.06,211,1705388400"; 
   d="scan'208";a="17875546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 03:16:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 03:16:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 03:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8UiDDSBMKA6V1Z7qtv29vI6eQO1TBnBKkVNli7iammIp3zLPEMAlDFANGmDeKFwatK60mnjWO8/2lbiihXxNkZFAYgWUVJgBdT68s6mfe4hoYqjwLC8a/nPzHjx/f7xogHSrr5g5z00RuRJqnMQOELpxQBvtUiZ2B6bFXxtZxaNgFEY49hCyzviNpTVPGchjB64AI1OC3QLHOpRpEwRxtutB5PP29SFwbdKt9BGA1++DhQQES4IXSDheTTCgNniYkGj+zVWS7yVadPLWowPdpWRYXidyakRG8ujkqJvCnajW3Ex+PEq4fCLviK8D47y8tEufNAcjeGDvv3kE3rnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rz/bpEyWyRxJDMsEjJD4jqD0jl6ZxwK0lmg9aczFr4=;
 b=KUQ5SvJAa5foS1c6Sjb8vX0CvN0kNmXYReEG7sdFhURcMKmhEv7WqUug3RrZPc7LwEIxL85iZslv2M6VxWRpB0iEwxYP1aQndVrCVC/lnIhUwtdrWqn4x2jqFjmErSNaG7XNwkwY5DaiVkhoJhtS2/9p5ATeglj1tGM9tWibNY57lAF8tslnlmenKZTBu5o/2sXPk1YACypXtYRzeJcWHD5WLVJ/rAOaVMTBSrn9ELoIcpHKUF6qY5J3B1LFqJ1jnPzU4iH2W4BM/WXZN5GAx0m1J7mF3Rktk8ENikIOF/Z4A1wGgw6WbyWuwl+oOZu80U5zNZX7y7AwQTGbZlB8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rz/bpEyWyRxJDMsEjJD4jqD0jl6ZxwK0lmg9aczFr4=;
 b=pnEQuq9dgNa0SygKZz/L2eQE6Og4qdnz8I0lNSDO2AA17sq7Cy4kJ7v5Qj+HXoHF2po9ASeLYXckyStYq+ab3REhtzaBY+lk4UACTX+qRDgnTx/KD3eOK6CWy/lnhK/Cv9FPFxCa4sWs42furU7saoAwlRu7uQq3IG0NuSw51/hWMqo6wmdIr6EAN5poXxS/+nRVq5pjPvDv1Z12UlFn2GWDzz7sT7DNwWrVWaeviUdjMINg8i2NLlIwJi/ubHnekjGaa8jBrAypa0ia0yzPuDMBwBREjcVgtNV6zpMC/UW1WE1PuTrZCF1d9A+DA6HXXfE8H8m2BLgHQ3iGFioYMA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 10:16:14 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 10:16:14 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Woojung.Huh@microchip.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v3 10/12] net: ethernet: oa_tc6: implement
 mac-phy interrupt
Thread-Topic: [PATCH net-next v3 10/12] net: ethernet: oa_tc6: implement
 mac-phy interrupt
Thread-Index: AQHab6ObNKe868Zhl0eyeM3lgSfsJbErYJAAgACxGoA=
Date: Thu, 7 Mar 2024 10:16:14 +0000
Message-ID: <9abd5656-3bfe-41ba-9f56-03f6e905a4b8@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-11-Parthiban.Veerasooran@microchip.com>
 <BL0PR11MB2913A429E53B85ABC67F9657E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB2913A429E53B85ABC67F9657E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: ded2cff0-25c6-4c6b-52f8-08dc3e8f9ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDiZesRL5qirkjoMcmFqHyORzKjn/GgdnDTeCKjam/jeLatqM9WHZs/5iWD/BVJn34ckhB00HluZaVnDhAG7bNzR3/8W4iMq7ceORCZUGBN2dMvS8aVnoUsWGoP4UwqY3cdWYaMg8NwuzYzJ8CSHSNqvas3QAzSua5ybOfWCBD6L18OtHte9hSzcy62oFd/YH6dlMkDUL94WHGVZcFU24xdtYeEpBH5CTslgcFrAdpmjHHM/TQ3ROfGW0XDY3g1SofqjvtgrDxKxyt3QrgBXvcvDJC/t7SHCR7RuartyORitA5bkMHkNYGSkbhSF3ysPFz82sMCjayyJxydg15PiV+0mbwKeOloSheOTosvbAQhAuho7SW7zKZigIdgdymQyLMA2rmn7E57ZD3gddGjZe2gdxunJMYsdIzwyUz6LQWiS00yycNEv3W5cHvca5TrQ/wxYWHFf+3BhWftx6uIcniW+dzKG8GkzjxDrYxBaci57fI6q9D/Sfg7iJ1oCgXIPCNPXPWhzpdQXv56zljoYbEgx8BgdmPlIOhT2UrWYOJz3/iMhNPiweN5Rp17/6AiRQEQx+rc8Vf5Qn/WDIXjVz6aNUrjRvDOwvcmxyl8eUCB8/cBuJJ06xqEhkqshXgT4bLnai0xVKi2Y8qfamAp6610KzJbRYRKgHO0XQe+cWkCYbxQQOnSxjkFCWHGmK6h9SrDQvC+IIDXRiCPEuCpXz+bLyzb3mTVqem/LGL+tYgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky9aZ0dHRzczMjhBZVlhbGl0TUJXUUhRTVhMK0dKRXNTRnl6dXZxMEFiSmFo?=
 =?utf-8?B?Q1hLVVk2Nnp0cmQwZG5mbHFYbjBEUGJIdnpSRHJoNCtMWjc1WVNldmx2MVlG?=
 =?utf-8?B?QXlWbXVzYVE1N0Q4Mit5cVRxYmdPbzZRTWdPcmJLM0VxVDBxYzBGaEVyYlp5?=
 =?utf-8?B?VlhRMzRUTnpaS0dOdUE0TWNqc0h2VXpNZ3V5ZCtVeW9CRjVSYlFvWmx1T0F5?=
 =?utf-8?B?Uk1QaldPckFjRFhZWFB0c0xaZTlRRnFRcGxoWGRhZXVHUW9JL0g2L1NaVys2?=
 =?utf-8?B?aTFHN090MDRMNEpZazVVYkVDM0ZLN25IajN4bG8wT3dqbGN1ZnNtdnAwSWlI?=
 =?utf-8?B?UWwvdU50QUI0cUVyN1A0cWJvdU5iL0UvMy9IZmp6dEpUdzVzWUV6TDdhYkdB?=
 =?utf-8?B?aGpRMkp6SFdwZEUvaFcrS3FNdGFtTUQwYXF1L0JDemszVzltZk0xZGNCZWxz?=
 =?utf-8?B?Q0lOZm0vdFIrRXUxenpRM24vTW10R3hhUmRQald2YjNHSnA3c2FFOFpCWFlq?=
 =?utf-8?B?SEVsL2ZnK0lKbGZ1VkdSZ0YxcnJVQXVTM2hIWDZFRzM5U3VZOTBScHFCeE8r?=
 =?utf-8?B?R01TODhBM3Fza1NGajBXdEU0QVpzMXFSWDdDc2V2ZTY1NEFnV0ZucCt0ZXB5?=
 =?utf-8?B?TGNtd3IvdUtkVGNVbENKb2hqdjJiVVFMM1M2NGx3c29PTGZ5cG1YS1dhaXVN?=
 =?utf-8?B?ZEJUOXIyaXNRU010d3BrRWNmcGZSVlFubWhpTEE3N0wrTWZDMHpzQ3lxWWsr?=
 =?utf-8?B?dzNGTFBYK08wS2FidFYzTGp0d0xyQXJnME9sekd0SFJmN3lnNUVBRkt4ZnRC?=
 =?utf-8?B?dDhXN2pTZE5BdTlLVVltWGV3Rk5tTnlmQ2poemVTOUxPYzgwUWxMVHJtdTFP?=
 =?utf-8?B?b2dENlBuNm85RW1HWmhwZWMzS21MMVdtV29iOFVlWWhzRU51TzVXUGNmbFFx?=
 =?utf-8?B?cTFwdlJINm5DNHpRNnNwZGVnUzYyaGZkSEhWYzg1Qzcrd25KbCtWZHd3T2hQ?=
 =?utf-8?B?dW0rd21PY0wvMEp4SGh2RlA0eUZrUDNsQXhXeWVsZFZUY0trT0hqWmNhZW1G?=
 =?utf-8?B?MHRKelVhYldEYUVNOGQ5RmZXdWdSYWM1N3h2VlZoMkJqNCs3U1YzMVRCSEI1?=
 =?utf-8?B?bU1FSjFvbHFpcUVSejNyQjR0RWQ3cExIU1gySkpKRExvWWJqUVlGT0ovVEhJ?=
 =?utf-8?B?Mkx2aVJ3SUEzNUFuZ3JXWTJxNGg4Vks2ZVIzZ1RIVUErR2ZxaUJ0REd3ejlo?=
 =?utf-8?B?Mm9IM3JMTFpTQjdFWVE4S3ovd2ovWXVHL3UvWWI0ZUdqUm0yaWI0eG1MVExh?=
 =?utf-8?B?U0Y2YUR4aXEyaTQyOFphYTB5M3JBcDQ4OStVcHgyTFlpQ2NrOStSRVhVRDZY?=
 =?utf-8?B?R2J4VTEvQmk2TTZidkRSQzFEZkhVdEJxTWdSSldTT0VWcGo3VDdGK3ZDSDVy?=
 =?utf-8?B?NEZvcnV0b3pqZEZOYkNHRmNLTlNNU3FPbkZ6VjdZZGc1d3lTUzFlQTFNTjZF?=
 =?utf-8?B?b0ZRVkFDLzhlYVhYVGxPem9DWEJQeW5JeEVVZ25VU3NqSVpRSUE4NnByRWVr?=
 =?utf-8?B?UlFiUkt6RGZldXBnV2Qwc3M3RytNdVFxS2tLdkhaZ2wva0lmRk9rYmVFUEx4?=
 =?utf-8?B?dVJtYmxJMzRMY05VRXh6MFUrb1dQc09wWlZZTmFaSXRoaG9kc29iaXVyMWg2?=
 =?utf-8?B?OTlQMHRTQ2wyK3hROHpKaXUzbkluTFY0dXpSU0oxSEthUmdKMmJ5UGNSdFVT?=
 =?utf-8?B?MjBFc2wxOEJtS1FBcWdQRTJxNCtqc0dEU213clhGT0taaDJCTXlRRzkxT2JU?=
 =?utf-8?B?TFdVcXFLUUVzMDluSDJSVFBjS21qN0RNT3dmVmFoVkFNeTN2UWM0WTByMnFL?=
 =?utf-8?B?cHVNcXNXVHBmMDVRYkM0bHZTcjlNSkZwK2RXOWxiN0ZEb3NTenVJVkNWaDJ4?=
 =?utf-8?B?UHJVdjBiaUJtMkRzOUkyc3AzRTQ2V2lPL3RrT21RcHVHUE5paWtXNjNKWnN2?=
 =?utf-8?B?VlFkK2hMR1dXL2psWVN2Z2hYcXFtem82WmZwNzV5UTNYRU9hMEM4L3l5UXVE?=
 =?utf-8?B?aFk5RVhMZjZON2YzOEZDcE5VZkVGNHd0WE9tcHBWRjRnMml2bHI1U1dRc3Zp?=
 =?utf-8?B?OWsxa1hzSVBQNlZEeEJrbElweDA2bFZQdUt1RTVCaUNYb2RjWjQwS1pHdTJh?=
 =?utf-8?Q?F6U0pjRot3kB3NxXPM6Qxas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C84B3FE5390F8140BC445C88786A7FEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded2cff0-25c6-4c6b-52f8-08dc3e8f9ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:16:14.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoAf2Jn5vy6Ul3Ch7SQozJI+Dk4IlCVmrlvXID0Kntv3GC26g1AffXevsQ8R0mz6cbpLc0Ox3UoRySVR+ji1y2B8r+RgdgCBqGPerGVYRbdCewqtGR9pVcYHdQ5R3K92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144

SGkgV29vanVuZywNCg0KT24gMDcvMDMvMjQgNToxMiBhbSwgV29vanVuZyBIdWggLSBDMjE2OTkg
d3JvdGU6DQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+IC4uLg0KPiANCj4+ICtzdGF0aWMgaXJxcmV0
dXJuX3Qgb2FfdGM2X21hY3BoeV9pc3IoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4+ICt7DQo+PiAr
CXN0cnVjdCBvYV90YzYgKnRjNiA9IGRhdGE7DQo+PiArDQo+PiArCS8qIE1BQy1QSFkgaW50ZXJy
dXB0IGNhbiBvY2N1ciBmb3IgdGhlIGZvbGxvd2luZyByZWFzb25zLg0KPj4gKwkgKiAtIGF2YWls
YWJpbGl0eSBvZiB0eCBjcmVkaXRzIGlmIGl0IHdhcyAwIGJlZm9yZSBhbmQgbm90IHJlcG9ydGVk
DQo+PiBpbg0KPj4gKwkgKiAgIHRoZSBwcmV2aW91cyByeCBmb290ZXIuDQo+IA0KPiBQZXIgZGVz
Y3JpcHRpb24gYWJvdmUsIGl0IG1heSBiZSB0eXBvIG9mICJ0aGUgcHJldmlvdXMgcnggZm9vdGVy
Ig0KU29ycnksIEkgZG9uJ3QgZ2V0IHlvdXIgY29tbWVudC4gQ291bGQgeW91IHBsZWFzZSBlbGFi
b3JhdGU/DQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPj4gKwkgKiAtIGF2YWls
YWJpbGl0eSBvZiByeCBjaHVua3MgaWYgaXQgd2FzIDAgYmVmb3JlIGFuZCBub3QgcmVwb3J0ZWQN
Cj4+IGluDQo+PiArCSAqICAgdGhlIHByZXZpb3VzIHJ4IGZvb3Rlci4NCj4+ICsJICogLSBleHRl
bmRlZCBzdGF0dXMgZXZlbnQgbm90IHJlcG9ydGVkIGluIHRoZSBwcmV2aW91cyByeCBmb290ZXIu
DQo+PiArCSAqLw0KPj4gKwl0YzYtPmludF9mbGFnID0gdHJ1ZTsNCj4+ICsJLyogV2FrZSBzcGkg
a3RocmVhZCB0byBwZXJmb3JtIHNwaSB0cmFuc2ZlciAqLw0KPj4gKwl3YWtlX3VwX2ludGVycnVw
dGlibGUoJnRjNi0+c3BpX3dxKTsNCj4+ICsNCj4+ICsJcmV0dXJuIElSUV9IQU5ETEVEOw0KPj4g
K30NCj4+ICsNCj4gDQoNCg==

