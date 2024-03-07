Return-Path: <linux-kernel+bounces-95191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A0874A78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4761F23857
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029F83CCA;
	Thu,  7 Mar 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e6FlLVUh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QXa73a+n"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751783CA9;
	Thu,  7 Mar 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802806; cv=fail; b=j0LaFtLucAIg8omfT+Dlowg1E839Ekk4bKMHqDIXJcQ2IHVwCNAUrhQvg2NQF2kZ9VXkVST4k07MZL3UwAYhfGJukIYKgewt4agLihA1TcwlZiDLl1/Tep0oydlFt+jDnyTgaAYA67aaRpneI6fjbBPSViIBI94aJpk+7ZkQ+vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802806; c=relaxed/simple;
	bh=VgUWx2dxf9ozTWA1L/eH+hCOnrdFhnz03mfu8oxvVKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J7idr1MUuWeiJHLeAvJUuvrAUqj02mAStckGhtxs30I60/nedxzTywMXoHhFnzLKJg6ZBFcATscASsbUoZRFaT+ifVBnYeRrWRVsSelVd6eQg/z28qEJyJYooEfTZu/b/n2leL4BazRCs7zo2yeOql+HqWNwQF9EJ9QeV8KA0jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e6FlLVUh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QXa73a+n; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709802805; x=1741338805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VgUWx2dxf9ozTWA1L/eH+hCOnrdFhnz03mfu8oxvVKw=;
  b=e6FlLVUh0IlY97WIMoaCy5Vjd1slLL1lplum98Ib7zKsu41IBoBB0CRr
   /VJeDNOu9bsP61pCKCeuyPk5Q2iXwjiGe4rcBoBN3G8d0Cs7Rc3milDvW
   4hGfGQFoBQKmYC5B8aZWKKHZGBHlW/w/IY00dGhs6xbOzIvIC6MtLagyr
   gIexqaQaLiO4Omj2z71fEDwT8PBa8DyLr7qlVm8vkP4EgJbKk30KVvC82
   wUDctTC/1BRiTFrOp02cdoMhO9isWKPP+UxXPFPOygX+rT/dwTOL+gCVm
   nw1+c0zZzEyC+ZvuTxkAsphw29dlCrAk3LV7lgned/2kWGRVzXdd+hHP4
   g==;
X-CSE-ConnectionGUID: aQElAjZ0QEu3SMVswA+yBQ==
X-CSE-MsgGUID: mvR1IR2HTB+g5GQ764pvtA==
X-IronPort-AV: E=Sophos;i="6.06,211,1705388400"; 
   d="scan'208";a="17339556"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 02:13:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 02:13:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 02:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJmIJE+/SbBp85459QqkNjt/7qFKoINFj7kWlk6rtgiS2uTrZn2kE7wNvjxO/WC8bKPAoX4Fsu0BYN7GgstAavuqN4ad+YMutiqHZ4gt9EEUGT7mXPiDVY8e1cF9JRyA4t79fv2clwc+ASotRAaQSg3sXRIkFk4udwF22VieiphamqoMop+ftet8aZiA+ihcqoWgFbVYV3+I8yoHEDYuTG0R6MQ7uYv+0FX+DQMgg9AArGFLfbHe6zTiF21u9oFe+4oxyrUMkU51lkRvans1/pfLN24FYZAttTTbF12JZcnFwlhqlvxrr60Wsg3PzMAK/aC0FvpiDZ9swATW70Xmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgUWx2dxf9ozTWA1L/eH+hCOnrdFhnz03mfu8oxvVKw=;
 b=XLy89P8T0UAqLFrWGp91qx4B1GsPolZuGbls+Hm30SycxAeDdqgU9lEzoGEvSsKhWm2a/WURwpr7cgAvUouUtMr0CaqQ4nIW1ulMQFhpBIZkddxbQMiYSK0Lptf1g6pLMqOcFc7VeNsY5I4edzc+gJMfvpSWXfRFGuMZd2DFsSdH7CFYtkLzaKnDY19AYWrrbZkNc9EuZiLTsMrOp+xGCke9dWag9RyowRI6RuMnEuCfd57b9VSfZiW8N0BbiCQN5+TO8Ijb3WcUceREbeYPfYRtCnlTSZ38qPes7cvPdQbuiZeaymrGnCYGFBedp+ZHaSDqztXWTlHAqIiilTXGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgUWx2dxf9ozTWA1L/eH+hCOnrdFhnz03mfu8oxvVKw=;
 b=QXa73a+nFO77jXld0rXPaJWqUkXsg/pcnoC3ZgGH0QGQdhRHBqfFQC4j1KJAkA0rvhUiFu7GLP/md1PhxUBc9YmrlQZpXIR9CvLcZz/YXaPR1P1aVFHx6njdMLCvIus3WZKuCRjc1PEd5/hsrApJopAqurSVhpxMmruQQ4wNdnvSZ6G4RqSXwU2bnM5dBcUnU/cmt1nF7oK68OqUUZ/WpPiC1O5zJh3Vq4qm8eu7CRkiX8W9Sd3eoxkjEPaNFiEEi1wjrQTe4PuvYWcbR3wUcKvmglhZL9nsv7N9R4pZNuA9W+Qo7+Y39/vlDVtMhpq2VQ2EaPwAsAbogQI/+pJOBQ==
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 7 Mar
 2024 09:13:06 +0000
Received: from SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27]) by SJ0PR11MB8294.namprd11.prod.outlook.com
 ([fe80::f85b:116f:aab1:9b27%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 09:13:06 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Woojung.Huh@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Topic: [PATCH net-next v3 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Thread-Index: AQHab6OpnVrpCHzm0kqlC3TKN4hYaLErYVEAgACetoA=
Date: Thu, 7 Mar 2024 09:13:06 +0000
Message-ID: <b20caac3-3fc0-461b-8ed5-4cc825323b0c@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-12-Parthiban.Veerasooran@microchip.com>
 <BL0PR11MB29133BBDC826A8B79F59FEB1E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB29133BBDC826A8B79F59FEB1E7212@BL0PR11MB2913.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB8294:EE_|IA1PR11MB7942:EE_
x-ms-office365-filtering-correlation-id: aa5a96f7-facd-428e-d6d0-08dc3e86ccd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k29k3c8v7GZhvarMY6L/TgFi/I+fdlapnuHYYzsVOgudxnxg9ttz0ArDHzDVV3NEWO3IRGIHNfaA+X11Z6xvKS/YJHOGqeR4y/Unk3WcyQhFEp+qQ+SzqnXePHHV+upbSxUvCLmYSYC4tRoviUGiCsHlr49Z74z+jZetGTpg58BUFhhtH0B1MR+0GWcGFeXrBNfdBEU+QtdmLvIw5wzHjmbgHfDFWUk4IushCeXbI45xMY/GudECBb4d/stl7WQzxZmBsV1OKNO6NCuKYBYdwCFNkrXOVgYOewhNF0OKRbI/1OkN/pvvddcDPq83xnzZBINNz2LLlILaUkkpkxG0MVNXJOGzjskVBeAkVfL2eUrSZ6WeJSNbWVdF2a3TY5ACXi0CYNgUUAbHxxIUFGP+UPGP9aMuirE9x5nFbGLaKEx9juT/zGaRM9hU12UQAfOuS6W2hFAMSZ8o2EElZm2OcMHkxBCdlnVLHF5MZIDLMIJjvjyhdUm9B1O/FcNsHXJR2m/EekA8uuz5UqYlme8x6rkxpEvk32e4gJYnGvfatpZhqSPVeJHILySp7Seldecn8/ez2mhqox6GWTam3mjNDhRQvuTwHCRkUfnMFdnMCkKI/qcad/9ZRnczl/qEfX/7KZPgj84mh8Ittsnl+WsQwuQSnTvrGHYC3gd+ZCO9guk64QEwr1EVaPHmkdkSqdGxkguQffTUSiH8EoxrEWpK3tslFBrs0/t8KkzhhxCamGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB8294.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0paMVEyeHdrQVQ3eTI1ZFBTYVJ1OVpjY1o4V24yYXVBTHpjVldkelJNNjZy?=
 =?utf-8?B?eENIKyt4TXlDKzJ0Vy9aalRPSVE1eFZieG1RUVRJMS9PRkppVTdERU1lRXJl?=
 =?utf-8?B?WU9UamtJa2I1Q2NVZjh4ZzVTdGJQMXBiTW5LYUdzK3hzcXFmekhVdWdHdUx3?=
 =?utf-8?B?YmZ5cHY3QjJUcVFsbWNndFRzU3JZZUszYUVvVVM0Y3NvTmhHeWV3ZTFLWm5G?=
 =?utf-8?B?TG9rdUIxMG5acld2Vmt3QUYyQSs4RnBlWDd3U0hVVm1lcnNCUnUrcWd5aFcv?=
 =?utf-8?B?d3JrUEtEeE9PNGxHVVFRL3BkRldzTjE1anhUOHNjVE5iS3Uvd1ZhUnhuczFP?=
 =?utf-8?B?SzkrVU4xUnZIaEt2TDhTdEdmQ1hTaldNWUxCb2VKMFUzQVdyTHlEWjA5NWd6?=
 =?utf-8?B?Y05uRzJBTzRKbVM4WC9kUmlIUEtQZnJqNFA1TWJDbmtnNWtJZDBjSGxiWEdT?=
 =?utf-8?B?WDdZQWhlalFGVFBrRk94ZHU3RGZHbTA0YmFSRWRiVjR3aXhGNmxZK2NYbTdi?=
 =?utf-8?B?ZXA5ODFyUWFzeE5pblJHRzJQWFJScDkzTGsvNENsRDVTNEZTejNXd05qL05z?=
 =?utf-8?B?WVgyTEFIUDhOdk53eURSbFhVTk9sOHlHb0ZyK3Z1OVZZTmcxcmtUUUpnTlhO?=
 =?utf-8?B?Y3YySmRFNEt0ZWIxNFJxVTQ2eVBjeThPM0JYTE9BbnFTKzUzb3Axb2RSN05z?=
 =?utf-8?B?b3gveEMvQkpWTFNUN1NpYmtzaU1TYnJpN0tPTnV5alFhOTVHZEp5UFhnWFpr?=
 =?utf-8?B?Wjd0cE1TSkxxSXJtd1RsRlYxTm54NHVRSzlKVjhNSi9vRk4wRWJtRnZscFdl?=
 =?utf-8?B?Qm1Xc2RMY0FvK1E1MEQzdkFlWllmcHNYdFJKeFVadzBxSEh4bm1CUkphZWc3?=
 =?utf-8?B?Ky9GNk8raExxN2hkUlRpSnNlL3J5bUFWSGt2R09TK2FsaVlETWhqMFBTbUJE?=
 =?utf-8?B?RGVySmdrZjczNE5zc1J6czlPQjJpcEdMT3RwaTFZOURiY1kzTG4xTmtUOGNr?=
 =?utf-8?B?UVZJVUZCRjlhdFI4eTJqRGlKeGVVN2xWOHdYOVkrMHdyaDRNeDZhZUUwN0FS?=
 =?utf-8?B?c3NIWEJoeThqQ0RjcFAxK1BqaFBpTU9LMG5PVm1NTWl5eStBd2E4bVR4NnFv?=
 =?utf-8?B?VElleklmZE9HaUN0OXJXOEFPd3lYVDlWRUdLVnA5SDllZUN5a3J3bmFsNlBT?=
 =?utf-8?B?RFJhK0VzSFp3ekVSWDBGQVVPbHJ1aWtvZjJLaEtDeG5JcnhHZ1JsMEQ5bEpZ?=
 =?utf-8?B?clVYSnVENFVoUWtDR01iY0NWSElFNTVBRUt2Vm4zZ1JrdVJ4TDN2ZTNCSWU1?=
 =?utf-8?B?cnllZmMwcmttY0QxYmVMMHFvblVYb08zam8yNGFrR05FbGp6czdlbGJTbWRV?=
 =?utf-8?B?SC9sV016UHVMdEVSMU8xRVl0QWdEb0w1Z3B4eFREdmtVZjJBZVgzSVByQVln?=
 =?utf-8?B?V0h0RGt3dnp5R1VVYUQ0ZE5jbkxobE84cDBtbXlxTlJMZDQwa1BjWlBKQlor?=
 =?utf-8?B?Zlk1WlFzZW1xSzc1MTJLWlMvTzV0K1k3dld4U1dNS1VBTVNSZ2tUbEM1d1FH?=
 =?utf-8?B?K01jQ2d6ZUNBQXYrU29IV0RDdlAwMUVGbnFwbk9EM2xYQTRxaDloRmhVUGR2?=
 =?utf-8?B?aERBaUpNVXFISDZIdkFtdGtwZEREQ0VEcUlhNTZ3M1NGSXhHNndtWUJuZkk4?=
 =?utf-8?B?YVhrVWtYMWhQVkkzN1M1THpMd3hKS3VBaHZVZitnRHpDMlI4eUxwV054K3BW?=
 =?utf-8?B?cW9CYm1VUlg0eHFQK0h0NmpGMnhEUW9NTXpsbW9ZbUYvS3M4c05yRlZURjA1?=
 =?utf-8?B?RThGc3o5RTkrTnNhZ2FLcmdBM1dIV3dTZGk1OW1UenR2TzRraFI3WG1vdFp6?=
 =?utf-8?B?Qk9xOTBTSzh2ZE5aMkw4eFRXaXpYUnhsRGwxL3V1b29ObWZMeDZDZzBJSnZP?=
 =?utf-8?B?bUJCQVEzSXdBUkdQck9Qb3pOekJFcnlsVTE4OUszUDIvZE50cENkMEsvR3Ni?=
 =?utf-8?B?bDVpN2lWMEoxcXd4d2ZCTjJTblF1VUNlWkZnOGE3b20zN2EvNUl3dGtmOXpQ?=
 =?utf-8?B?cjdSRXlhKzduNXAvWnlzYis5cUY5TkpBU3VKN2VnRnVWNHJMR3U0Y04ya05j?=
 =?utf-8?B?dlR3bTAwSndBcWN2NG56NU1SRmZhTVpyVGZFcmxmNjBEdFA1d0lmaDZSUytS?=
 =?utf-8?Q?f6JpwHOzLL6wN4xDYi+QgHw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C867D957F1084F9231D7627E6ABA77@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB8294.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a96f7-facd-428e-d6d0-08dc3e86ccd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:13:06.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptb7/XmygZskLbCJrbd/HpW4oYrmzD3Xncq80l2X73LcsB0+GFtmBOj22n1Ib3uXG2odPUC1rjMf4yce2mW02n1X4tjOz5tqBPU3+slhs3383vEn54fA6JuBSHQO8zl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942

SGkgV29vanVuZywNCg0KT24gMDcvMDMvMjQgNToxNCBhbSwgV29vanVuZyBIdWggLSBDMjE2OTkg
d3JvdGU6DQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXgvbGFuODY1eC5jDQo+PiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L21pY3JvY2hpcC9sYW44NjV4L2xhbjg2NXguYw0KPiAuLi4NCj4+ICtzdGF0aWMgdm9p
ZCBsYW44NjV4X211bHRpY2FzdF93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQ0KPj4gK3sNCj4+ICsJc3RydWN0IGxhbjg2NXhfcHJpdiAqcHJpdiA9IGNvbnRhaW5lcl9vZih3
b3JrLCBzdHJ1Y3QgbGFuODY1eF9wcml2LA0KPj4gKwkJCQkJCSBtdWx0aWNhc3Rfd29yayk7DQo+
PiArCXUzMiByZWd2YWwgPSAwOw0KPj4gKw0KPj4gKwlpZiAocHJpdi0+bmV0ZGV2LT5mbGFncyAm
IElGRl9QUk9NSVNDKSB7DQo+PiArCQkvKiBFbmFibGluZyBwcm9taXNjdW91cyBtb2RlICovDQo+
PiArCQlyZWd2YWwgfD0gTUFDX05FVF9DRkdfUFJPTUlTQ1VPVVNfTU9ERTsNCj4+ICsJCXJlZ3Zh
bCAmPSAofk1BQ19ORVRfQ0ZHX01VTFRJQ0FTVF9NT0RFKTsNCj4+ICsJCXJlZ3ZhbCAmPSAofk1B
Q19ORVRfQ0ZHX1VOSUNBU1RfTU9ERSk7DQo+PiArCX0gZWxzZSBpZiAocHJpdi0+bmV0ZGV2LT5m
bGFncyAmIElGRl9BTExNVUxUSSkgew0KPj4gKwkJLyogRW5hYmxpbmcgYWxsIG11bHRpY2FzdCBt
b2RlICovDQo+PiArCQlyZWd2YWwgJj0gKH5NQUNfTkVUX0NGR19QUk9NSVNDVU9VU19NT0RFKTsN
Cj4+ICsJCXJlZ3ZhbCB8PSBNQUNfTkVUX0NGR19NVUxUSUNBU1RfTU9ERTsNCj4+ICsJCXJlZ3Zh
bCAmPSAofk1BQ19ORVRfQ0ZHX1VOSUNBU1RfTU9ERSk7DQo+PiArCX0gZWxzZSBpZiAoIW5ldGRl
dl9tY19lbXB0eShwcml2LT5uZXRkZXYpKSB7DQo+PiArCQlsYW44NjV4X3NldF9zcGVjaWZpY19t
dWx0aWNhc3RfYWRkcihwcml2LT5uZXRkZXYpOw0KPj4gKwkJcmVndmFsICY9ICh+TUFDX05FVF9D
RkdfUFJPTUlTQ1VPVVNfTU9ERSk7DQo+PiArCQlyZWd2YWwgJj0gKH5NQUNfTkVUX0NGR19NVUxU
SUNBU1RfTU9ERSk7DQo+PiArCQlyZWd2YWwgfD0gTUFDX05FVF9DRkdfVU5JQ0FTVF9NT0RFOw0K
Pj4gKwl9IGVsc2Ugew0KPj4gKwkJLyogZW5hYmxpbmcgbG9jYWwgbWFjIGFkZHJlc3Mgb25seSAq
Lw0KPj4gKwkJaWYgKG9hX3RjNl93cml0ZV9yZWdpc3Rlcihwcml2LT50YzYsIExBTjg2NVhfUkVH
X01BQ19IX0hBU0gsDQo+PiArCQkJCQkgIHJlZ3ZhbCkpIHsNCj4gDQo+IFlvdXIgaW50ZW50aW9u
IHRvIHdyaXRlIDAgaW50byBMQU44NjVYX1JFR19NQUNfSF9IQVNIPw0KPiBJZiB0aGVuLCB1c2lu
ZyAwIHRoYW4gcmVndmFsIG1ha2VzIG1vcmUgY2xlYXIuDQpZZXMgc3VyZSwgd2lsbCBjb3JyZWN0
IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPj4gKwkJCW5ldGRldl9lcnIocHJpdi0+bmV0
ZGV2LCAiRmFpbGVkIHRvIHdyaXRlIHJlZ19oYXNoaCIpOw0KPj4gKwkJCXJldHVybjsNCj4+ICsJ
CX0NCj4+ICsJCWlmIChvYV90YzZfd3JpdGVfcmVnaXN0ZXIocHJpdi0+dGM2LCBMQU44NjVYX1JF
R19NQUNfTF9IQVNILA0KPj4gKwkJCQkJICByZWd2YWwpKSB7DQo+IA0KPiBTYW1lIGhlcmUuDQpZ
ZXMgc3VyZSwgd2lsbCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPj4gKwkJCW5ldGRldl9lcnIocHJpdi0+bmV0ZGV2LCAi
RmFpbGVkIHRvIHdyaXRlIHJlZ19oYXNobCIpOw0KPj4gKwkJCXJldHVybjsNCj4+ICsJCX0NCj4+
ICsJfQ0KPj4gKwlpZiAob2FfdGM2X3dyaXRlX3JlZ2lzdGVyKHByaXYtPnRjNiwgTEFOODY1WF9S
RUdfTUFDX05FVF9DRkcsDQo+PiByZWd2YWwpKQ0KPj4gKwkJbmV0ZGV2X2Vycihwcml2LT5uZXRk
ZXYsDQo+PiArCQkJICAgIkZhaWxlZCB0byBlbmFibGUgcHJvbWlzY3VvdXMvbXVsdGljYXN0L25v
cm1hbCBtb2RlIik7DQo+PiArfQ0KPj4gKw0KPiANCg0K

