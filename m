Return-Path: <linux-kernel+bounces-30718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7C83237F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CBC1C22480
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238417C8;
	Fri, 19 Jan 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Uqpm9ONZ"
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6E1367
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632837; cv=fail; b=GOnwZisFAbbc4kN+UjVUdIJrcBlEkaDQRMC7IF2ZcWvy8/JkCRO8QDbJpx0w8y/xqs2N+mo8bNU6ZmkTnxnufc4kVC6DIYm5JnGR5Ow/gmqcMdQUkMVsTr92zrt4QwvXVjZ65Pd3t6ymHi/AHwv0V1uPjlJTWoUcXzoYK69kEW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632837; c=relaxed/simple;
	bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eihHRaRpaixAKqVAuljh0TzQ5oF68KPCANcZbi60o25MCE9HIqxBvR4x620Zlk/jD/0bZY9fOKmQl+7YLKLhpOPxdgM9rM+1WOVPsEfbVFUKW6pM7ygSlRR5Y+pFTk8mNxlCLUJY0idQw2Z753ClEpLSZj8yXXLQahM8EQaQbCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Uqpm9ONZ; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705632835; x=1737168835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
  b=Uqpm9ONZZ20iIIgJHFiHEiQXiGD2btqWVxwfC932cQXOfV/WYLWYSM5R
   AqIimQsnqqOM4pY/hlNtm9Qg8mt5C8M0ctbVsV1OUiS5KU8W+y/zC5BEM
   PNHzCAYLk+J28OjYO+2jIhZd4K6YHdRoQqh3HmKZFzT6h8QGKs6jrg5nu
   nsLu453t9yEez83cdJq6GkMBK+jJrlyLepQ7eDrd40s+jk2Iw/qxoJl8R
   KYkY9qaT4Mqj4adX1m+9Mx3jZTRQqsI04NEu9j6GG65kN2TTMK+e58CPh
   mt/8xPAXpflqmdHnq//7E6Sefl/SkXE9vByzDFxgFfeCSkN1LE4CU62Qz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108831552"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="108831552"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 11:53:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9dioT2c3+35ccFua2CsOgJlEw/+N2hjFMMAzUnuBGp6jS3Y6xGi6aWiQSrfTnSeV6IaNvpW73y7PjgBFmBLF61dy5phkUHfOdIC2Q+7CnzZwPhDnyLNF66tZvQfi9nNRkJ07T8rO2UOo9iNNyeDEq3Co6qYGx4MIobezh9j6OXoUwj5/BiqtlvW0acExZ6kui5TaoIFXXYKcBKYhCwATod5bihW6s1VQlqKigSfYIfLGLAy+keoKjF78DlvgHiFI2OLYBYNhc56qPt+PEi81BjKghz0m6yJd/bJ6gdI9yPU5zI0oI+wxazbhLc36DB/cChvGd4uLTh6acAozVMATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aTK8Fz2WhK6qh8d+yIpcYSyrgRrI24cyuPCNWKIGCs=;
 b=Cbxh4HvurKiyJbSNjkz4O/jvigIEYVI+NbtmO7GxiT0DBD5RIogE/pJngCgFAAkI25E3BhZf8ipaSkryF1xSUbCbCsmiviMSMZ+zA+4E1nNsY1h+jtMuV4mSa17K1vCZ2V1lDhBGnfNPQkcnK3QrPGEjkBEpwzuHB6EJ5wB83xjga5qExBI0yWb+x8PUY1XKbbAJZtZM1dX73qIsGEEzR0QJpfWiZDNbxUWx+iimWgpA9NxVN+UqGdsF+h9PfjTeXuRmdQdh1HeegHlflsqHeIQxnaqFBiz/3xqz0Q+7WlEyn82gFV/IKEDa2iU2U9DiAOwhId/TzWQ7gOeGoQFN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY1PR01MB10865.jpnprd01.prod.outlook.com (2603:1096:400:323::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Fri, 19 Jan
 2024 02:53:41 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7228.009; Fri, 19 Jan 2024
 02:53:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Topic: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Index: AQHaSDIil6iSQfVKJk6069otilFPcrDgCPuAgABsBwA=
Date: Fri, 19 Jan 2024 02:53:41 +0000
Message-ID: <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116041129.3937800-2-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY1PR01MB10865:EE_
x-ms-office365-filtering-correlation-id: af37808d-9934-4f27-9613-08dc1899d7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3AQfudXDe+QRrwToZBHkQD7EgDd0X8TlI+cetLlxYxAQsqNnZ/n4HMsha3mgqrmWwp01QPym1RY8AretD8STD9mbHRows/2BXGSBDDHIxl/gksY15XShZH6Ypdjn/7+89xSxbeHlPErumeleev0t1Rwc7WQJ57ekvmvREwn7gFSfDPLnogkhomZqKcAcSYqD8YruU2S7Auhx543VjDrLx9XSjtT1KBmK0b7OzdLsgshOKeuEnIm4mpo2r1NKFnz6MWRbiRw0E75UsL0tf653exf9FsitDVKMx3WmoFSuuzSFVViquHGZKp8TBKmf1Pq1+gUt+lWfvQNAPCtVefRXSLkD9AD2fVIyGuwD4jHF/cJH/vslvtsRUmp2JeMdjLHGd4KiTwI6/RtIWRHjO+efA7mlaUPezFa9hvDBusdvc1OVIo9i6EYq1CqT6gfsrX66JpQGf2UnJtXGB78z4iVQc1ljDaLl4APD4cbcZ2mSy27EXfh92sIt/+DItp+oV4h9kMIXALFoaCbzk8CJ1gn4KP1RUps2GlEB/Az4YoIb3K9p12wgT6mi15b6bbT5CW8KUIUZbrgTuMwgtbxnfgraLsiE7C6ez52MFdDck610OltYwXQsnF1gblHrthF7hi3MMPvILPLe/BL/tlQyFJKFkBpwj/8Gb1217fUOOt88s4wBPAtP+4Sj7d/ixpQGbGu6NDLU/l07dK9/xkTPfeJLWf8PznalJeeaN3z7SQkSPeRfJXnE1jxA/B2YL6t72dQd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1590799021)(64100799003)(1800799012)(451199024)(38100700002)(66446008)(53546011)(26005)(478600001)(6512007)(66556008)(2616005)(83380400001)(6506007)(64756008)(5660300002)(54906003)(6916009)(8936002)(6486002)(66476007)(66946007)(316002)(91956017)(8676002)(2906002)(38070700009)(41300700001)(4326008)(76116006)(82960400001)(86362001)(122000001)(15650500001)(36756003)(85182001)(31696002)(71200400001)(1580799018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVpYemtTdzRqRmpUcmNPTnJmYUNab0F6aW5yUDYyNE04cC9abDl4U2VLMTFy?=
 =?utf-8?B?SXB6YmNkdG1Icm9oYlQwQ3hFLzZBS0N4MHNwZnNhMnMwK01DcVZzZ01Wcy9V?=
 =?utf-8?B?Ykd0emt4dEJ2aDBuZ3Q4RDZ1cDZIY1BOM3FraDVRQ3ZjcWJ3M1NlVlA3RVNS?=
 =?utf-8?B?ek1uNFRWNkxaY3pWWmhTRnBMVVZ4MEZPSTlSbkEzRi9vL3B1V1poMm1xK09s?=
 =?utf-8?B?Yld4Z3JaeHh3anZMVkQvODVIVkxvR1YzZW40K3BmM2syMFJtZ3UvZkd0QVV0?=
 =?utf-8?B?NTZiNkx4em83N2RxZVB2OENUQ1N4b0tmampEckhDaTV4WkExYm5yYzVNdUJl?=
 =?utf-8?B?aXhMRXVTY0tJQ2pKcG5QZXBjZUwwU0J6VkNPWU1yWVVvemxjRVA3TE0vTGtF?=
 =?utf-8?B?Q0ljdU9PaGpmRXlWR3NMUHd3dzd1dTdtOWJneXJZUjVKdC9UcTRRdkFzR3F6?=
 =?utf-8?B?enZBSHhqT1pMUEtLTUk3L3JwZ3MxZU9UYXp2ZGhiZlJRMkdsY21xbmhXcnhZ?=
 =?utf-8?B?eGdPRThadVFiZmRtODI4a3JLdGJCaURZb3ppYjZJNmR1THdxYlRzVGxhU1Yr?=
 =?utf-8?B?WmtJZjJZdU1Ld1Zpb2F2YkF0cTJXcmk4bHN0Vk83VGFkRVVEc1NvMW85aXcv?=
 =?utf-8?B?aHU2cEFIaXdFa1QyejB4ZGVVbUxCYTZENUsvV1RqcGJsNjJaYlBOTTZ4YjVv?=
 =?utf-8?B?K0g5NmRsTzNTd1lwRjdvT0hGdUlDM1hyVEZsVytWSnQxdEZ1OVdqamFaVGVH?=
 =?utf-8?B?b2NzY0N2c3dub09nRktkMDF2WFY3b1A5V1l4YXpYWU96dDFXdUMvRkszOUw0?=
 =?utf-8?B?K2NObTNUTHRrZHNjaWhrdEJFbHRZcDFxUjBCQ0RQT2J3WVN3bnVKN0N4NmZj?=
 =?utf-8?B?dGU2VXVwVXB0Z0lFbldQdWlHWHYwU1BTNHpqZjlXU2dxVjZyczRhVUlxeStv?=
 =?utf-8?B?ZHZndytieU9OTFg5NDFVek8rQjRUSnlNWmg4bjlWLzJNLzB5YlVBWEZ1M3ZD?=
 =?utf-8?B?cUhLdVVKWk5sekNRa09naFpLcy9lNnhhaFZONWlSTXpVQnJTUXpMcVpKSTZZ?=
 =?utf-8?B?ZGwrV2l4WHRzRmhKWW96czdNTXdUZ2p0dDRTRERrMjRmek12bE83NXFyK2gw?=
 =?utf-8?B?RGp5dW5TVm1oeDBGcndCNFF4ZE1FbG9zSUNVS2tiSTd2TTJ2d3k2ZFYzTnc5?=
 =?utf-8?B?cU1DN3dRcGhXYWwzcW9BamxrMllNaGw1bHFtdU9pRFEzT2lIV2dMazVZSDEv?=
 =?utf-8?B?YjJoQ2JvQVRiZlRaUUJ2SmNqZjUvcmtyZ2cyS2pmN3NhdHU2SnFiWjZFdnZN?=
 =?utf-8?B?NzhRK1czb2psWlNjT3M5TzRTbDY3b3hxUlI0WTZnZWttbUorOG5hRktvN2lk?=
 =?utf-8?B?YVgvVktWenRuSVlYa21VOWN3YkZ4cjFUSVp1TzkxZkRGVHJBYWx1SE5QNnNB?=
 =?utf-8?B?V0JvK2h3RExtRGhYZTc1NG1VQWFtTDd1d2ZoTFRiZ0ZEd1BuT2JCRE4zdHBp?=
 =?utf-8?B?Y3dyRURTbkl4Yjl2SUUrcU8wQUFTY3hVL1FYSkR6THdPejhzaXlUc2ZJTE5E?=
 =?utf-8?B?TWl4RVlZQ0gvOUYrcGNXZWpvN1BuK2xEVG94MEFnRXdPTFRWT3JNVWJ3Yi81?=
 =?utf-8?B?bHlUQ3d0Um44bE9LUHp2R0ZUb28xOGovbEpRWlBqNHBZSHdLT256VllQZUtr?=
 =?utf-8?B?M1lhdXhoSUhYUk52OU5mbEZ5SUZxZVNWa2NpS1p6MzB3S0ZWSlZTRGN6L1Uz?=
 =?utf-8?B?dkRKOTdXQnA2U0ZHblJNZmJkVGRQUVlKYVhzSmJadUVlajE0UkRwWmwzT0ZY?=
 =?utf-8?B?T2RaR1R3YjIrczBCUzYvSjFnclBBeXBBMktYN3dpS2xIc2w1OC9oUGxaMXFt?=
 =?utf-8?B?M0ZNMmhKRk8wS01TVFNueU02UUl5NGlLaFJCWEkxMUVmV0M1bzRNamVqNGZp?=
 =?utf-8?B?VDBVY2FidGV6MjRsTS93OHFyeVMxMXIxMDF6OVN6Q1QwallweTZTdEIyRmV5?=
 =?utf-8?B?TkY2ck5XU1NkTGozZnVkbGRJQ3N0MTRKQnJkM2w3aUlMRGQvekhON0YrMkoy?=
 =?utf-8?B?cjkwc0xLdnZkMXdhV3NjS20weTlnaDRsaWx0bEJ2QWZCWHNraE4rTmxEWUF4?=
 =?utf-8?B?N0R1cHpIcXJBb0RxYnplR3BIUVF4anB5S0lESU5ITlJCNWFuYVF1UzF3SHJh?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5CF91744917D84582125CAE872687FF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9mIAxnpdNGcjrSdF84TFCW7vhmFTrCQfQw61qKknS55zodew29ijK8fV7XQNAT6RWA+908vtcd9oNXYOBZ/o9oP4WxzuJXQRsuZIbfhenfgS/9H5n3ZiOxpUB+lQ0uFj2ArgpMMG1IlE2OOhpkZbkNDxkuTTa+dsNFcCq5XJxhyQQtyZJxhY+SlaJ/+qCQ8e+uscr3ZcEJ7fZSUGPRPZj78q4Ida7ucv0tjm2HHP0q7X1NJ613l4SoNw2J8r6Y3B80qFUfC1JbEjfO+bYNpWDAnTd5jDA5uVlTrsyQfbSaeDrusaOEIKjJKA3/XpZ1p4A7cgYI0R568LaGAqcd46c3JBpuhhzDfviB+OsoSnCh/SLmQgCg4TF4RstA9hhmrIr58HvMbRt1kUKaU1c4KcL0EOBo4yM49SGmoistXAbGQdLyoSmwAS3Ets8+GUI2GKylvZahmoRNW4GFC8PaPsNWi4Y6ythrKnscC1cS3cAm1ELX6FO+3SWqE2No/v7zfCp7NjbHHi9PZiEqAFCfkW2E3M4+d3iSGYoL6FLxlpb2JHFTL1w0Z/xWTSast0EAQgKjchZWYFnb2T6U5NIQtJbp95UyMJcqJrUxQ4w3t7LWtEm+ogGxS05i1cfrfND8Qa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af37808d-9934-4f27-9613-08dc1899d7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 02:53:41.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sn/6B8AhthAX13AAhTdr5/SYJPkGfZ7My8BL1Zc820OJjoQMLnFc4E60HcXQbX499lJCM7xRmO2EEvsIK54dew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10865

DQoNCk9uIDE5LzAxLzIwMjQgMDQ6MjYsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4gDQo+IA0KPiBP
biBUdWUsIDE2IEphbiAyMDI0LCBMaSBaaGlqaWFuIHdyb3RlOg0KPiANCj4+IFVwZGF0ZSB0aGVt
IGFjY29yZGluZyB0byBsYXRlc3QgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNmcy5yc3Qu
DQo+Pg0KPj4gQ0M6IEp1bGlhIExhd2FsbCA8SnVsaWEuTGF3YWxsQGlucmlhLmZyPg0KPj4gQ0M6
IE5pY29sYXMgUGFsaXggPG5pY29sYXMucGFsaXhAaW1hZy5mcj4NCj4+IENDOiBjb2NjaUBpbnJp
YS5mcg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPj4gLS0tDQo+PiAgIHNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5j
b2NjaSB8IDEwICsrKystLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jb2NjaW5lbGxl
L2FwaS9kZXZpY2VfYXR0cl9zaG93LmNvY2NpIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZp
Y2VfYXR0cl9zaG93LmNvY2NpDQo+PiBpbmRleCBhMjhkYzA2MTY1M2EuLmE2MjFlOTYxMDQ3OSAx
MDA2NDQNCj4+IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5j
b2NjaQ0KPj4gKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZpY2VfYXR0cl9zaG93LmNv
Y2NpDQo+PiBAQCAtMSwxMCArMSw4IEBADQo+PiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkNCj4+ICAgLy8vDQo+PiAgIC8vLyBGcm9tIERvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvc3lzZnMucnN0Og0KPj4gLS8vLyAgc2hvdygpIG11c3Qgbm90IHVzZSBzbnByaW50
ZigpIHdoZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUNCj4+IC0vLy8gIHJldHVybmVkIHRv
IHVzZXIgc3BhY2UuIElmIHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgYW4gb3ZlcmZsb3cNCj4+IC0v
Ly8gIHdpbGwgbmV2ZXIgaGFwcGVuIHlvdSBjYW4gdXNlIHNwcmludGYoKSBvdGhlcndpc2UgeW91
IG11c3QgdXNlDQo+PiAtLy8vICBzY25wcmludGYoKS4NCj4+ICsvLy8gc2hvdygpIHNob3VsZCBv
bmx5IHVzZSBzeXNmc19lbWl0KCkgb3Igc3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9ybWF0dGluZw0K
Pj4gKy8vLyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCj4+ICAgLy8v
DQo+PiAgIC8vIENvbmZpZGVuY2U6IEhpZ2gNCj4+ICAgLy8gQ29weXJpZ2h0OiAoQykgMjAyMCBE
ZW5pcyBFZnJlbW92IElTUFJBUw0KPj4gQEAgLTQ2LDEwICs0NCwxMCBAQCBzc2l6ZV90IHNob3co
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAq
YnVmKQ0KPj4gICBwIDw8IHIucDsNCj4+ICAgQEANCj4+DQo+PiAtY29jY2lsaWIucmVwb3J0LnBy
aW50X3JlcG9ydChwWzBdLCAiV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmIikNCj4+
ICtjb2NjaWxpYi5yZXBvcnQucHJpbnRfcmVwb3J0KHBbMF0sICJXQVJOSU5HOiBwbGVhc2UgdXNl
IHN5c2ZzX2VtaXQiKQ0KPj4NCj4+ICAgQHNjcmlwdDogcHl0aG9uIGRlcGVuZHMgb24gb3JnQA0K
Pj4gICBwIDw8IHIucDsNCj4+ICAgQEANCj4+DQo+PiAtY29jY2lsaWIub3JnLnByaW50X3RvZG8o
cFswXSwgIldBUk5JTkc6IHVzZSBzY25wcmludGYgb3Igc3ByaW50ZiIpDQo+PiArY29jY2lsaWIu
b3JnLnByaW50X3RvZG8ocFswXSwgIldBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBidXQgaXQncyBub3QgcmVhbGx5IGNvbnNp
c3RlbnQsIGJlY2F1c2UgdGhlDQo+IHBhdGNoIHJ1bGUgc3RpbGwgZ2VuZXJhdGVzIGEgY2FsbCB0
byBzY25wcmludGYuICBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0bw0KPiBmaXggdGhhdCB1cD8gIE9y
IHNob3VsZCBpdCBiZSByZW1vdmVkPw0KDQpHb29kIGNhdGNoLCBpIG1pc3NlZCBpdCBiZWZvcmUu
DQoNCkxldCdzIHJlbW92ZSBpdD8gIEp1c3Qgc2ltcGx5IHJlcGxhY2luZyBzY25wcmludGYgdG8g
c3lzZnNfZW1pdCBpcw0Kbm90IGVub3VnaCBmb3IgdGhlIHBhdGNoIG1ldGhvZC4gQmVjYXVzZSBz
bnByaW50ZigpIHZzIHN5c2ZzX2VtaXQoKQ0KdGFrZSBkaWZmZXJlbnQgYXJndW1lbnRzLg0KDQpJ
J20gbm90IGZhbWlsaWFyIHdpdGggLmNvY2NpLCBpZiB5b3Uga25vdyBob3cgdG8gd3JpdGUgdGhl
IHBhdGNoIG1ldGhvZCwNCnBsZWFzZSBsZXQgbWUga25vdy4NCg0KDQpUaGFua3MNClpoaWppYW4N
Cg0KDQoNCj4gDQo+IHRoYW5rcywNCj4ganVsaWE=

