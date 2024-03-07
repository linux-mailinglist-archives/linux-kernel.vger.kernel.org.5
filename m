Return-Path: <linux-kernel+bounces-95134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760587499E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEBC1C21FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97854634E1;
	Thu,  7 Mar 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UwVWBTzW";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5Borwc36"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48C63108;
	Thu,  7 Mar 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800146; cv=fail; b=Tnim2mK4YfArx2QDionYiPoFxqSJbITTyTkfMSreAfLknba34VcQsXdns1MCP9bvjysX7AsozXksDyo9Vm7SExyPmMptV9Tw6PBXo2+n4SyV7kYjt5ThOi7Dflc4/PFRZGXYomNokKdKN3duA4gXjB8z2aKz2aTLYfGpl5XSQSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800146; c=relaxed/simple;
	bh=ymGNNRh4+hiUopVFxrwoAqG3s/ROdSR4jenadDLs8Iw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=izNttQwwZ+IS45v56Yt+jL6TDsTJlB4lIvDbG2AU7jtZISvyQGsOCc7if7pZhUh6VOCcZo0ZZD+DQlCir/Q2AoC2nBoFx2eMQVph1vzK/Rmq08g4RbbWiy7SE1fxR+Nnyq5MWiFhG2IwOLFQ4Y0/0gVLBsL1ttsRD3ba3u4ZnTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UwVWBTzW; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5Borwc36; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709800144; x=1741336144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ymGNNRh4+hiUopVFxrwoAqG3s/ROdSR4jenadDLs8Iw=;
  b=UwVWBTzWsmQiAt3H4gP0ebqoGWZsLZBe4ua2BWv0ZEMN2YqdOL8ez3Zy
   c/ndB1uj7wd/DSntdxNpUt6xEP+VizopyF1P8MsYcgvS87tAB5CHlZEv8
   v+FcPFm/pExUWUiEaM+EuMZwSgm4VQUfsqmtj2vGhR0rwO8g7bgoQdJnj
   SQ2n42xLnC72mouzCREAKcrPvsgE/8lbUoAwu4K3PJDItSrf1WI1q4YZY
   UdwoMhlgwr06MZziYE/Jmh/BbY56abBWD88rJd2UIsESf8thfCNSWLV01
   Ei681mOFMJtoCveywARsyu5ocymYeaYa4q+LsOOLzANF7uwn07T46HxPz
   A==;
X-CSE-ConnectionGUID: 5y1B8dpnQ8ScNkybsBUmtw==
X-CSE-MsgGUID: UHgM8fAxRbSTGcVS12dW1w==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="scan'208";a="17337761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 01:29:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 01:29:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 01:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVm0pnqOgSgZ4ymWjBCcfjI9Sbr82ZXjaZrKYL0oOK7yUIbMdM1vUVKPasQIqxD9dZhq6EuWAiftNPpXZrtTPkHoRa8577w6az536yZr20UqziOhAKs7kWqBz94EiXGoHQmrCXYdwTxJbOkHYGcX0wawMLwNXOeo8tvBXvIOdkser+nUVXOTcr/tq/dZPsHbWj7ryhbZKGRMawp+I3CMxAGlN+iJu7/Ot9vCSmjfni7FjjFxsdzM0a1VmzKf7l4aJss8rTkSx2ORS1IesBnFwfQAG4XEhvOXyxkU7haM7VQRWQY4oqdGMEmC36trRPaMfmeSrQk8+ecoyHsWY4ZUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymGNNRh4+hiUopVFxrwoAqG3s/ROdSR4jenadDLs8Iw=;
 b=ZnJ9IjHGupZssl5j0SvKAB/AVs9/xk54TBRN9mfzMoR385Q6QpQVgs6opeLlhBc7nGn0LDXqS8and0ke+xIPHuH9MQ5WjPDcY2VKRv6lqHYg/wS0d1NNyC1O0y9Dbzfe02hgoSIgimnBt07U5ly56NUsDmdChCzJmOfw3yZsraO2xwfu9LWRjKVEhM6Y4Al0MxCMUrqNgfsP0cv2NWxgffaGVOz2isS9ZG+aO3WFy/QVyhAp8LO7WvSO1wpFf9FmjNP/mz8YpfN/tYDbxbK+RE5HZQMvaN7BtBZq68M9p/5jsnMjho2Z9EwHuzQuAUMe69vpxzcaHZg5jYTMrCrMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymGNNRh4+hiUopVFxrwoAqG3s/ROdSR4jenadDLs8Iw=;
 b=5Borwc36ZgwinmSe4YWuNmmo0fuF3UGFSvqY45uitHpah/CHqXmL4a+vF2FM0g/OLSTvg5PNa5WyPxDK01IjUVqTc+BpWoW8eqFQzqjQL7Sx4Oh/pcJ0ExFENPDesoz3TvwD6/PY5OcodUEs8Xj2R9UshTq1ZXNIlx9EKVT9C0gdXCX6AzZOKudVIalVtb0L+fRYp6GioPXSixUvqn1f3WU6XKG2gartvchZ0AkITOx2BSc5DILCEGxGKXn8mK0qT6/OXV0sGD5K5hvAdlsQSjkevHlEJU3Zi5/sa0ja9v/zqI5WTZpI4+p/v+F1jDLBD9D5euUs45QkxvMz+EoZLg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 08:28:59 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:28:59 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v3 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: AQHab6ODhegyEXGdXEqW27P6zJjh0LErccmAgACB7IA=
Date: Thu, 7 Mar 2024 08:28:59 +0000
Message-ID: <9f824a6f-a075-405f-b615-75076061a284@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-6-Parthiban.Veerasooran@microchip.com>
 <ea217697-fdb8-4112-ae84-62f566cdc375@lunn.ch>
In-Reply-To: <ea217697-fdb8-4112-ae84-62f566cdc375@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_
x-ms-office365-filtering-correlation-id: f193b1de-45e2-4a05-1ed5-08dc3e80a348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJADpp+Qcap+PajKLbiCGAWg1Atm7hux815P/x6e5pCeY9OYawo/x7yIXBJ/e663oPsfA0UPcwANX8SLUVobQT62vZy2LtDI7XAKSzF5Xxw2zrwuJkx9xQ0FPGLMUdVW1o9cuRdt7bwImNZ/JatPaxZnpoYDer7RpBlb2oP15I2RjiQVDk5WWZWcTN5dmrJjYvWX8HEC7uOP2rBB23KDZOKxAgcd2ZE+n3y7z7AVkXxkJCYoEa0ZmvhGlsIewKewUGUe0kn2GWBh0FKiGo/rP3bcqLn1IQygw1Nrf0vpBOgUbj9yIWn3duoG+b8w6DU+Tr/BqQqSas/MUtAuM5zHVssliGOnFp9AFY0vyiIlE7DJcAGdW20R4WNvivi6WhWpan1lP34QNTeAs5WEeqIi67dlpP1I2TrSvitA+h9DhvOti6cELzNQIlX/LGkliarr5OC708wHlMYYtbQRGtQAXALeL5dTUtVe+dFDFSokx6MQWpvkeCNVVMsLnMgzq55zep5USg4Wb0wZN5LbMUs/CG2V8kYMcqar3adt6UauajjlNZdRtPpZp1zHHRnyGkDOxiYuuUx84KSzoHn+ykLj7cffzE1OQbGPgLYUxhGGAgmNefIrw8GpXmn4Dkj6pzjGn+FH6NPf4iRKO9CYKRHTwWsq6VN6vNAu6C+00rbdJS0cVaBs1h5KOuW224RZZyrxhE0XwS87PVoP4ZyyCk+UQSTcLPhycDcF7c9vyHnLW2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmRHSHF0OWVYTDd6aUpMaUgvejFEVEU2bTZjWHcxcWRoL1pRdUpsSTdUU2xZ?=
 =?utf-8?B?SGV0amVTRERuNDhzZmlVQTdJU3E3ejBiNnl2RXVXNDhTdEFMbTdqUHNlcHBk?=
 =?utf-8?B?azVKOTFOaEZQcVU3TTFONWpQK1lvVHZiR3JWNCtTVEI4S2M2cmg5NjBVb05z?=
 =?utf-8?B?Q1JqRHExSWVid3BlQStlcUFvZlhUK0NIb0FwSWdsQUNCczlRdTQ3dDd5aDJG?=
 =?utf-8?B?TXZrR3JNRFQrT3pEaWdiUXd4VE15U3BRYmtOSnhPVGNSWEd1RG5vUWJiSllz?=
 =?utf-8?B?bXVoWGRmMmx1T0FRY01qcms5RHYrczA0ZlJrazRTa1V0UDN6SUp1cXEySGcy?=
 =?utf-8?B?ZTl1c0dlQUFZVURLYkd5WE15Q05zaEZYTGFWVjdwRTZ3QnBMTCtEUW9LNTkz?=
 =?utf-8?B?aE1mR05mS1RSNCtMbHhRNmZuckVLVlJHZEVIQTVITXdIdkVYdU52SjN4TFdi?=
 =?utf-8?B?NDJXTHFyTm5wK2Era2gzUk96akhWZFh5MVRUZjdIMEFmQk9kZGpFc3lqYjg0?=
 =?utf-8?B?OFdWYmI4R1NtREp6UnhOSml0OHZxSHJZaGduZ0dEN3M5cEZ1SFlNQTVOeHh2?=
 =?utf-8?B?ZWptTXpvQUZNK0t1M2p5ZDFmRThpNDZTYi95QmIrKzRJUlZNYXFqbGNIZnN2?=
 =?utf-8?B?eE5uYy9HVmNFc0ZxamMvWUlsc2tzNHI4dWd1R0MxSk1FZUgvbWUzQWxmWUJQ?=
 =?utf-8?B?bmtXY0oyK1NNZERrSUN2SEJsc3ovcitwUmxod2c4MnIyV2h2UEV6aiswNDRw?=
 =?utf-8?B?NnM4WFZJbXpyelQxNUtxeDBmZDU4ck45YnR0UXI4M0JrWkw5SFBSV2FzN2Yw?=
 =?utf-8?B?VE4yNmtnZzdDb2lYNkZPYUJMekhnNG5hYW1YZjdFMm9qWEkvdm8zSkpXV2sx?=
 =?utf-8?B?bXpCN1dZWWlnU1JVZVZySnJBZ2VlelZKRXY0bmxmbU1rclRQRjc2YW9MSGJk?=
 =?utf-8?B?aGJnWWNMbk9lencxNlI4YmxxQU01cFBDUGkzUFdYdnh1NVFNMTNBVnBMK3dY?=
 =?utf-8?B?YTN1TlhYc1M1SS9BakNaRHliK2FhWW12ZHR5YWpNSkIwQWZiVy9Qa3NVQ0hx?=
 =?utf-8?B?Y3hjTkJKdSt2VVRodU42SVoxVVA2bnB4MjBkdlFITWV3czYyTmhieDBzKzJI?=
 =?utf-8?B?a3ZtK1hKSTdIZ015WmYzU0xHanJRVExKOWtSRytDQU1EdytIQlQ5eGswZVhL?=
 =?utf-8?B?L0pYMmlxN0tFV3hzd253ZUlKMldnbjVrM05ydlM2V3dlUHAzdURGZVdJYzB3?=
 =?utf-8?B?Vml0d3FpS0Y0WFFYT2ZYTTVkb2c1MzVBVzIvVWMxVjFiWkRoM1NhOUt3UU1i?=
 =?utf-8?B?RWxQRGhPK1ZVQk45Y2gvZlU2VUlJN25DdXpqTEpFV3RiQzQ2VVp5Q1phQXI0?=
 =?utf-8?B?ZFNQV1JYSTJ3cFVCa0JrV1dQMk03eUdBcDBhUGhhdklMTUlpMWVsaTE3UjZS?=
 =?utf-8?B?MmxuRjhmRWNsYUIzcWhVSUlXdzJvczBGTjIyc095TWc5cXZFbTI3Ny9qVEhO?=
 =?utf-8?B?VVRRek5nOXJoRkdhZy9FZ3JFV1NmMzVXd3N6VXlaQTBIWTluZldvN0lNRE13?=
 =?utf-8?B?VnlNOEMwaUJGeENSYXV6QkQ0YlkyamtLZlYvL2lJQ1IvV3prcFVPeDFjcW9N?=
 =?utf-8?B?WUdGaDRscXI3ZWxRUTlkeUFGYkljNGkvcUFuSkhtbFk4a1BLeWdTRTFMc0JD?=
 =?utf-8?B?dFRoMmo3bjZUekNEeWE5VlNxNmJDT21wS3lCTUIyakVVOTNvN1dvc2xMQmR2?=
 =?utf-8?B?VkprTGZNOExJTm5BS2kxTk9mZi85czErc3VBdHBscEFubEpFdUtYbm1haVZw?=
 =?utf-8?B?RjFxWlg3aHhEYkVjSW5hODZvbDlieFJ4Z3pzOGI0VFNCbWdXVjRZdUZuK3RN?=
 =?utf-8?B?WXBoSGRQTC9hVkJPbnE1bDl1R2FmcitxUVdZdlFjWE5yVFZCU1JLQXFRSkps?=
 =?utf-8?B?Nk9PNlh2OW43cjJNN0l1b2wxUHhzYWFsVlZoL25aczFFNUhUODVwM3FwRE9R?=
 =?utf-8?B?eVYrK2JBYlhlRytVUU11R3RrajVZNGdIWXMzVkNnRTNKMmd1a0ZySjVjWTho?=
 =?utf-8?B?d1lPSTY0OTROc0M4NTlhMVVZcDZQd0hCWXpjeVVrK0JGaDJXNGtwQVcybnk0?=
 =?utf-8?B?L3pnTSs2aE9nQTRKbklQZDZzNlUzRTlkQ3huOHp6QlQ2cDA4Y0d2QXlvMGgr?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C2A34C7776FD541A6FDB4E1B0EF704B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f193b1de-45e2-4a05-1ed5-08dc3e80a348
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 08:28:59.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fo3nAH812hwvPetNzXqNhr1efMmDZ4zXArxlGjKpCIOQq0rJhRmcedlX4t+zhIRp/Y8uMxqA5oGBBpyjpxnDPc/rc8MRbk+8KkgI4YEssk6LB9OoOwpGQROWXq7QWO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA2OjEzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIE1hciAwNiwg
MjAyNCBhdCAwMjoyMDoxMFBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
PiBUaGlzIHdpbGwgdW5tYXNrIHRoZSBmb2xsb3dpbmcgZXJyb3IgaW50ZXJydXB0cyBmcm9tIHRo
ZSBNQUMtUEhZLg0KPj4gICAgdHggcHJvdG9jb2wgZXJyb3INCj4+ICAgIHJ4IGJ1ZmZlciBvdmVy
ZmxvdyBlcnJvcg0KPj4gICAgbG9zcyBvZiBmcmFtZSBlcnJvcg0KPiANCj4gVGhlIHN0YW5kYXJk
IHNlZW1zIHRvIGNhbGwgaXQgIkxvc3Mgb2YgZnJhbWluZyIuIFRvIG1lIGFzIGEgbmV0d29yaw0K
PiBwZXJzb24sIGEgZnJhbWUgaXMgYW4gTDIgRXRoZXJuZXQgcGFja2V0LiBIb3dldmVyLCBmcmFt
aW5nIGlzDQo+IHNvbWV0aGluZyBjb21wbGV0ZWx5IGRpZmZlcmVudCwgYmVpbmcgYWJsZSB0byBz
eW5jaHJvbmlzZSBhIGJpdHN0cmVhbQ0KPiB3aXRoIHNvbWUgc29ydCBvZiBtYXJrZXJzLCBlLmcu
IEUxIHRvIGtub3cgd2hlcmUgdGhlIDMyIHNsb3RzIGFyZS4NCj4gDQo+IEluIHRoaXMgY29udGV4
dCwgd2UgYXJlIG5vdCB0YWxraW5nIGFib3V0IHBhY2tldHMsIGJ1dCB0aGUgU1BJIGJpdA0KPiBz
dHJlYW0uIFNvIGl0IHdvdWxkIGJlIGdvb2QgdG8gdXNlIGZyYW1pbmcsIG5vdCBmcmFtZS4NClll
cyB5b3UgYXJlIHJpZ2h0LiBUaGUgc3BlY2lmaWNhdGlvbiBhbHNvIHNheXMgdGhlIHNhbWUgdGhp
bmcgYXMgeW91IA0Kc2FpZCAiTG9zcyBvZiBGcmFtaW5nIEVycm9yIi4gSSB3aWxsIGNvcnJlY3Qg
aXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4g
DQo+ICAgICAgICAgIEFuZHJldw0KPiANCg0K

