Return-Path: <linux-kernel+bounces-44032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3DC841C76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E77CB24435
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13953E07;
	Tue, 30 Jan 2024 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MI2d5WUa"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F323C689;
	Tue, 30 Jan 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599186; cv=fail; b=JDJ3fpeANR8nxu3MH5bF40M4ryKrHrv3PM9gIK5FJVDXxOBjHIYNkixeT4yCiRM03saUr12tlrFmQVSF+tkrP/LlalpOnSiOQnr/2DO8XVDog//lYHN0Uj5yhBr9JjVYNwXt3CYRu2CYeR3s1NQpthg3z2xbqMDxPRoR7iPUuIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599186; c=relaxed/simple;
	bh=qxj7iil4Acl+2JrEEe7eJUS7Lr2pZM+tA4lA3buwfVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWUA6Qd/2QWR7+QU5ymAoPpGPsv6qeoYYd/ntekJUJxb6PL2vkNKWtcU9lCYg/CEj10CRxfFsrXo365JdXJeJcdmB6YALo5HQ38f7IEmYeLGnozRK2EQmpD3vlPYC/8KT8Ig1PCI2xQn53B2DwuzVEnJWJ+LqRcy8etzFpwRAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MI2d5WUa; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eL9SxHBMa6P9e+1pNuYXv3MeTYQ1jdkfl3IrW0Czla4pdwzzQhDqFAxHa3Vluml3mzbLkG2aZlQH0YSIeiPIXRuKmw+P5asHCY5t+KklSJW+8TbvkLYN7MRYuGES0FyUZLfVi5g/vQWN/ehbDGpNgWajcdGysv9vsJtiHk19h/u7TyeeDsqIJ4t5dOXKf1Nv1+bwirU6TjSEl+KOysLe4aPmvDdka+rbXdeOwwiJdvfUXI15wP09xL6mL+53PFui/C0+9yYOF/K34LVNkuiwDfKVzFX9/LlkhD8rX6DveJazK34GOo0i0KpWp3B1MpPN9pS1EnAjxkacI+M9GxNuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxj7iil4Acl+2JrEEe7eJUS7Lr2pZM+tA4lA3buwfVg=;
 b=iXzYSDGnI3x/1ety4h3cQ2ZOKnd/s5FuDz5+XtXTUbpEcxj9+xJTqzqq8N0OoUde+TDy530SGTm0VJ4KBAFOGaHCjnrpL2YanyLw99PiV2BoYXHF5KO68AwoltFtGcWIxTdmpjnayuD7MMCZx7XXT4OcvLqJChk2P6bpGpvqK7dYhMC2rXxzcSztXSNXL0m4bOJEDNd0YHLxI0FrhM0Ob/gA811M5gATKit+jepJSrfd8GBP6LGxu/+Gb7ASF9NJJAaLmXbd/fF8eqayoI/dlklzfBa+0O9NZ2gesMTzNuAFRzlpzDwDrw+Bo7Kps1t1cJOD3lG/nWFoIyFeh/v1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxj7iil4Acl+2JrEEe7eJUS7Lr2pZM+tA4lA3buwfVg=;
 b=MI2d5WUata18FlRVwT8knIPT8H+5lK1laBZtu0v6ZGykKd/dx3NqdUAHQYDo7zT/iYQ4fiCp62UGuoBUPiYkye7Wcs/qgf0YMcmS3OkFreUKj9evHQbptey+hyN1GcG6rO/8Pf/aV3uigXSfg3Js/F/rNLyvUPfRxDqxTg5KE5Q=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 07:19:40 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::b0b2:5cbb:3f6a:6630%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:19:40 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Rafael Beims <rafael@beims.me>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDyBCEw
Date: Tue, 30 Jan 2024 07:19:40 +0000
Message-ID:
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
In-Reply-To: <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB9413:EE_
x-ms-office365-filtering-correlation-id: 5f5a2379-d24d-42cd-3447-08dc2163d2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E81nFvusLbN6tXxWu/YPsEwB6pQRA8ijBJifYGWViht59pr14N7k4bWREKiBofW/X4IPIxSElJc/GX28XPv7HD23Y3ggHb919P6ernuvsQPCp4XzfDTGtYvhiknpctlUaNOyAFCiMBoyxXFXjQGIz5MUN0v4L7z8gIJf8+HBzrYjeaEXiun0moeQK4bKgUYk3DGF/wjrN7T9SLItawYhu356cMd+UHySdND5k2PZ4e74SQvONhkjCUwnPRw3iglcUH9hHNhNHZmhzeSJ22Y/BOAES7XyKYTJSRLdRk0LGX2MSA1EfK1ut9FNKi4gZItjLAEjWgbyUXpiqpplskPUrlFm2kFlb7Hm9RLJ5qDLhzQKJ9WwEYzTMumy36+WMats0SGGaKbGiHtRr2Z7dr6fdhrnOwZh+R2HiQcq1zkzOMKUFTcypEuWoBIEOxIghd0uQ0Fp3+mfO0++/FLuVMbxi1T34dVvuogB6JOOx5GMpV+h/lC2gqy55GzmS97yME+bsN/bSV3qYvj6rfrByIjVCd6T4L7gaTf5SMD0wx0/CwJEoohZ5JVdvafLtC/zqyVh0GHaW/wMAwvQ6q6WHiobAiBPTrm+EiEcV+WIcbtRoAQH3Gam5Vss+prCMpHIEBw/DaPwvVJE/ALcZLikcVoV/2clwEl8LXmAU1iSCIcF54Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(7696005)(53546011)(6506007)(26005)(66556008)(38100700002)(9686003)(4326008)(52536014)(5660300002)(8676002)(8936002)(41300700001)(478600001)(2906002)(66476007)(316002)(54906003)(71200400001)(66446008)(76116006)(66946007)(64756008)(110136005)(122000001)(86362001)(33656002)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG9ObnIzazVUS2Z6aWFDOWxxU1puaVBYNWZTNHZwd0phUzY3UFF4ZHIydytj?=
 =?utf-8?B?ZXlBZHU0WGU2bjV2OEJxVkNnMTgwNTduNWVKRGhBT3RvZkg2eG9NemJka3gy?=
 =?utf-8?B?Umgwc1pDWXo0Tk8rTVNNdU5Ub2NST084NzV2aldoL3dTeWw3Qzh4aGxHRHhO?=
 =?utf-8?B?YWJpcVY5eGREZUVEZ3MzK1AzWUFUeXFWZ285T0lMNXFKVFNqZGJKNzlMbFov?=
 =?utf-8?B?ZjlVcVlBc0tZckNXcVNJVXZBQlFBTi9PWU1vYk9vUGREeE9OWFppMmpNdW5u?=
 =?utf-8?B?SG9DNkJNMG5Dbm9KblEyM29HcE9HeklKMDJ1TmJYR0wxTklNaGkxVDhJaDFh?=
 =?utf-8?B?LzhjRHl0Rmt0R05scHA1VWhVM2RTY3Y3cWJrVFdDKzN0ZC94dy9KYXJvTDZ6?=
 =?utf-8?B?eG5VKzliOHRzUVNDSzZMQXBJZzVGdTlhMisxUjZCNWdjekIwcXdheE5mTGxi?=
 =?utf-8?B?aUU1eEs3VVBMQ25vRXVZWURmd1lWVTdYemY5VGJzSXBwWmJNS2RTRDBFcy9U?=
 =?utf-8?B?QUUxallGNktQRHZOU045aEkxL3lZbnRxQzloUWlkMEdWdmUrRFU1S20xeTBF?=
 =?utf-8?B?ZStmSmpPSjU2UmtOZmdNMHlESFYzQThxUFlXamd6dEVzcStSS3JISE15aFFa?=
 =?utf-8?B?aTlTYVdKL3dWb3FKdkVVQXJpZXVhRkx3TUJnZVNkV2J5ODZ2bTF1TnY5WE5V?=
 =?utf-8?B?c1RMQkhicG5NNmFzZHROTXpNclhwOUZtd1liM0ZnZlhUUEMxV2NEeDJTem1h?=
 =?utf-8?B?Z0FMUSsvR245ZVcvam5HZGlaTGhkRU9TTUw3QUdCaWpudm52ODhFOWpBSCtS?=
 =?utf-8?B?d0ozd2k3ZjJ4eUFmM2QrVFVpc0l3K2l4cEpwRENIVmZJWE5JTitrK2I3aEZD?=
 =?utf-8?B?T28vWFptTTlwMUNOTXB1NTB4Qk4yQVpJb1BmNEdwdlhiSi9LNTk1WDlxcUIw?=
 =?utf-8?B?VHFlK2pkRnVpSXhZcHh1ZFgxTXFHRzVYQzVoN0lhTjZ6OHpPaTMzSURNV3Z3?=
 =?utf-8?B?KzFhdkxxTXE1akpkS2VIRG5rOUZJOWIrVjMxNEFIVG9KSDV3cE9HdnpkUkZt?=
 =?utf-8?B?T0Q3OHZXU2tsL01GZVVvK0FRWHMrQ3YwZEllMmEyMjFYOWIxS0V0TitBNy9R?=
 =?utf-8?B?bTg3aU44TDdkQ09rZmNvVC91NjVYd0F2OTBDdlh4bkpCVXVFNjZqWjIyY2FY?=
 =?utf-8?B?WDBLb29XemdIU29WSTI0bDhhcWpBbk5CcVZTeGNCamtMTzJrUUYxeHBoY0Jl?=
 =?utf-8?B?Y1dhdHg3WUhSMFhsbnlsdHpSSzQ2NW8yL1VmUjlRbGlHRFpJektIbUFkd3g3?=
 =?utf-8?B?ei9sbEdubDRmUXZPSVYrL2FJVGNWVHRzUkxXbWg5VXhaWGRLWW42WkdTZ2ZC?=
 =?utf-8?B?T25ua1NkeEdLOGkxWEtQcE9ydFdlby9GUVBKaHQxQXFXcDUvaE9NOUIvU29G?=
 =?utf-8?B?TlpRNWRuaTlvWFFEU0FPSExoRTBsd3BvZmJFV0xvSEk2UTVITU0reUVzcXlC?=
 =?utf-8?B?TmFaS3QraEF3RHhpazVSejY3aFUzT1dOQ3d4NU4rRnpmcWFoVEFQSk0wQmc2?=
 =?utf-8?B?Tlh4cS91RTgvWDd3SDZwU1ZWeGdZTm1BV2t0MTdsTlorcGgwSFdGOFc1S0Nm?=
 =?utf-8?B?alU3RUsxMU92RkNPN3VlWW9janpQVTBLR3VJTWg3d1RUa2E5UGJhOWpLcUVw?=
 =?utf-8?B?NUZHZWQ1NGlZaGFGZmIrZjJUSFI4cjUxdzFtck5pYjdsVkZ0RHVwYkZ6dk9m?=
 =?utf-8?B?ZnVKRW1YWVNVZ3BFMjd2RDR6cFpkU1JqUEJxeElJcWRBK3Q4dGlQTDF0K1JF?=
 =?utf-8?B?RWRveHJ6eTlFNFNoU3IyYTlyYnMyT3ZVT1RkZHBseTRIL21QaHZ4eHhUbFlp?=
 =?utf-8?B?M3AxV29ucUpCNUhmMVBrYSszM2tIaU1PcHN0Ym1xKzRjWkROcUtHbmxJWHRy?=
 =?utf-8?B?Y1F1YXhCQnBCZHdyMW4xQ0pYMVlFeU5lQ3BNblZVbG1mbkRpSkczSlZRUmFO?=
 =?utf-8?B?OUV3ZmJMcUUvWUhqZzdrTi9wSHM5MlI0ZGFlWDBjTy83anJwYmRLZHppKzRE?=
 =?utf-8?B?WUx3dmlCK0t2bVFQTVN2RmhnaGhYbkpFcyttNENFZDhwYjd4Z3AzOVJ4dG93?=
 =?utf-8?Q?iwlczPhXVzVzT6afXikoqpUf6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5a2379-d24d-42cd-3447-08dc2163d2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 07:19:40.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cgqt/t942vNYpCsZYRJtwcezs08bQoV7xqv0jKffckZVLPmnEOItirabUH01S4uMKajiREvLSaShx/Ac4ofTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

PiBGcm9tOiBSYWZhZWwgQmVpbXMgPHJhZmFlbEBiZWltcy5tZT4NCj4gU2VudDogRnJpZGF5LCBK
YW51YXJ5IDE5LCAyMDI0IDE6MDkgQU0NCj4gVG86IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAu
Y29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7DQo+IGt2YWxvQGtlcm5l
bC5vcmc7IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5o
c2llaEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY4IDAvMl0gd2lmaTog
bXdpZmlleDogYWRkIGNvZGUgdG8gc3VwcG9ydCBob3N0IG1sbWUNCj4gDQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiAN
Cj4gT24gMjIvMTIvMjAyMyAwMDoyMSwgRGF2aWQgTGluIHdyb3RlOg0KPiANCj4gPiBUaGlzIHNl
cmllcyBhZGQgaG9zdCBiYXNlZCBNTE1FIHN1cHBvcnQgdG8gdGhlIG13aWZpZXggZHJpdmVyLCB0
aGlzDQo+ID4gZW5hYmxlcyBXUEEzIHN1cHBvcnQgaW4gYm90aCBjbGllbnQgYW5kIEFQIG1vZGUu
DQo+ID4gVG8gZW5hYmxlIFdQQTMsIGEgZmlybXdhcmUgd2l0aCBjb3JyZXNwb25kaW5nIFYyIEtl
eSBBUEkgc3VwcG9ydCBpcw0KPiA+IHJlcXVpcmVkLg0KPiA+IFRoZSBmZWF0dXJlIGlzIGN1cnJl
bnRseSBvbmx5IGVuYWJsZWQgb24gTlhQIElXNDE2IChTRDg5NzgpLCBhbmQgaXQNCj4gPiB3YXMg
aW50ZXJuYWxseSB2YWxpZGF0ZWQgYnkgdGhlIE5YUCBRQSB0ZWFtLiBPdGhlciBOWFAgV2ktRmkg
Y2hpcHMNCj4gPiBzdXBwb3J0ZWQgaW4gY3VycmVudCBtd2lmaWV4IGFyZSBub3QgYWZmZWN0ZWQg
YnkgdGhpcyBjaGFuZ2UuDQo+ID4NCj4gPiB2ODoNCj4gPiAgICAgLSBTZXBhcmF0ZSA2LzEyIGZy
b20gcGF0Y2ggdjcuDQo+ID4gICAgICAgQXMgaXQncyBhIGJ1ZyBmaXggbm90IHBhcnQgb2YgaG9z
dCBNTE1FIGZlYXR1cmUuDQo+ID4gICAgIC0gUmVhcnJuYWdlIE1MTUUgZmVhdHVyZSBpbnRvIDIg
cGF0Y2hlczoNCj4gPiAgICAgICBhLiBBZGQgaG9zdCBiYXNlZCBNTE1FIHN1cHBvcnQgZm9yIFNU
QSBtb2RlLg0KPiA+ICAgICAgIGIuIEFkZCBob3N0IGJhc2VkIE1MTUUgc3VwcG9ydCBmb3IgQVAg
bW9kZS4NCj4gPg0KPiA+IHY3Og0KPiA+ICAgICAtIEZpeCByZWdyZXNzaW9uOiBEb3dubGluayB0
aHJvdWdocHV0IGRlZ3JhZGVkIGJ5IDcwJSBpbiBBUCBtb2RlLg0KPiA+ICAgICAtIEZpeCBpc3N1
ZTogT24gU1RBVVQsIGtlcm5lbCBPb3BzIG9jY3VycyB3aGVuIHRoZXJlIGlzIG5vIGFzc29jaWF0
aW9uDQo+ID4gICAgICAgcmVzcG9uc2UgZnJvbSBBUC4NCj4gPiAgICAgLSBGaXggaXNzdWU6IE9u
IFNUQVVULCBpZiBBUCBsZWF2ZXMgYWJydXB0bHkgYW5kIGRlYXV0aCBpcyBtaXNzaW5nLA0KPiA+
ICAgICAgIFNUQSBjYW4ndCBjb25uZWN0IHRvIEFQIGFueW1vcmUuDQo+ID4gICAgIC0gRml4IHJl
Z3Jlc3Npb246IFNUQSBjYW4ndCBjb25uZWN0IHRvIEFQIHdoZW4gaG9zdF9tbG1lIGlzIGRpc2Fi
bGVkDQo+ID4gICAgICAgKGltcGFjdCBhbGwgY2hpcHMpLg0KPiA+ICAgICAtIEFkZHJlc3MgcmV2
aWV3ZXIgY29tbWVudHMuDQo+ID4NCj4gPiB2NjoNCj4gPiAgICAgLSBDb3JyZWN0IG1haWxpbmcg
c2VxdWVuY2UuDQo+ID4NCj4gPiB2NToNCj4gPiAgICAgLSBBZGQgaG9zdCBiYXNlIE1MTUUgc3Vw
cG9ydCB0byBlbmFibGUgV1BBMyBmdW5jdGlvbmFsaXRpZXMgZm9yIGJvdGgNCj4gPiAgICAgICBT
VEEgYW5kIEFQIG1vZGUuDQo+ID4gICAgIC0gVGhpcyBmZWF0dXJlIChXUEEzKSByZXF1aXJlZCBh
IGZpcm13YXJlIHdpdGggY29ycmVzcG9uZGluZyBLZXkgQVBJDQo+IFYyDQo+ID4gICAgICAgc3Vw
cG9ydC4NCj4gPiAgICAgLSBRQSB2YWxpZGF0aW9uIGFuZCByZWdyZXNzaW9uIGhhdmUgYmVlbiBj
b3ZlcmVkIGZvciBJVzQxNi4NCj4gPiAgICAgLSBUaGlzIGZlYXR1cmUgKFdQQTMpIGlzIGN1cnJl
bnRseSBlbmFibGVkIGFuZCB2ZXJpZmllZCBvbmx5IGZvciBJVzQxNi4NCj4gPiAgICAgLSBDaGFu
Z2Vsb2dzIHNpbmNlIHBhdGNoIFY0Og0KPiA+ICAgICAgIGEuIEFkZCBXUEEzIHN1cHBvcnQgZm9y
IEFQIG1vZGUuDQo+ID4gICAgICAgYi4gQnVnIGZpeDogSW4gV1BBMyBTVEEgbW9kZSwgZGVpY2Ug
Z2V0cyBkaXNjb25uZWN0ZWQgZnJvbSBBUA0KPiA+ICAgICAgICAgIHdoZW4gZ3JvdXAgcmVrZXkg
b2NjdXJzLg0KPiA+ICAgICAgIGMuIEJ1ZyBmaXg6IFNUQVVUIGRvZXNuJ3Qgc2VuZCBXTU0gSUUg
aW4gYXNzb2NpYXRpb24gcmVxdWVzdCB3aGVuDQo+ID4gICAgICAgICAgYXNzb2NpYXRlIHRvIGEg
V01NLUFQLg0KPiA+DQo+ID4gdjQ6DQo+ID4gICAgIC0gUmVmaW5lIGNvZGUgc2VnbWVudCBwZXIg
cmV2aWV3IGNvbW1lbnQuDQo+ID4gICAgIC0gQWRkIEFQSSB0byBjaGVjayBmaXJtd2FyZSBlbmNy
eXB0aW9uIGtleSBjb21tYW5kIHZlcnNpb24gd2hlbg0KPiA+ICAgICAgIGhvc3RfbWxtZSBpcyBl
bmFibGVkLg0KPiA+DQo+ID4gdjM6DQo+ID4gICAgIC0gQ2xlYW51cCBjb21taXQgbWVzc2FnZS4N
Cj4gPg0KPiA+IHYyOg0KPiA+ICAgICAtIEZpeCBjaGVja3BhdGNoIGVycm9yIChwd2VbMV0gLT4g
cHdlWzBdKS4NCj4gPiAgICAgLSBNb3ZlIG1vZHVsZSBwYXJhbWV0ZXIgJ2hvc3RfbWxtZScgdG8g
bXdpZmlleF9zZGlvX2RldmljZQ0KPiBzdHJ1Y3R1cmUuDQo+ID4gICAgICAgRGVmYXVsdCBvbmx5
IGVuYWJsZSBmb3IgSVc0MTYuDQo+ID4gICAgIC0gRGlzYWJsZSBhZHZlcnRpc2luZyBOTDgwMjEx
X0ZFQVRVUkVfU0FFIGlmIGhvc3RfbWxtZSBpcyBub3QNCj4gZW5hYmxlZC4NCj4gPg0KPiA+IERh
dmlkIExpbiAoMik6DQo+ID4gICAgd2lmaTogbXdpZmlleDogYWRkIGhvc3QgbWxtZSBmb3IgY2xp
ZW50IG1vZGUNCj4gPiAgICB3aWZpOiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1lIGZvciBBUCBtb2Rl
DQo+ID4NCj4gPiAgIC4uLi9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2NmZzgwMjExLmMg
ICB8IDM5NA0KPiArKysrKysrKysrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L21hcnZlbGwvbXdpZmlleC9jbWRldnQuYyB8ICAyNyArKw0KPiA+ICAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWFydmVsbC9td2lmaWV4L2RlY2wuaCAgIHwgIDIyICsNCj4gPiAgIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9mdy5oICAgICB8ICA1NCArKysNCj4gPiAgIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9pbml0LmMgICB8ICAgNiArDQo+ID4gICBk
cml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvaW9jdGwuaCAgfCAgIDUgKw0KPiA+
ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L2pvaW4uYyAgIHwgIDY2ICsr
LQ0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYyAgIHwg
IDU0ICsrKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4u
aCAgIHwgIDE3ICsNCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9z
Y2FuLmMgICB8ICAgNiArDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZp
ZXgvc2Rpby5jICAgfCAgMTMgKw0KPiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9t
d2lmaWV4L3NkaW8uaCAgIHwgICAyICsNCj4gPiAgIC4uLi93aXJlbGVzcy9tYXJ2ZWxsL213aWZp
ZXgvc3RhX2NtZHJlc3AuYyAgICB8ICAgMiArDQo+ID4gICAuLi4vbmV0L3dpcmVsZXNzL21hcnZl
bGwvbXdpZmlleC9zdGFfZXZlbnQuYyAgfCAgMzYgKy0NCj4gPiAgIC4uLi9uZXQvd2lyZWxlc3Mv
bWFydmVsbC9td2lmaWV4L3N0YV9pb2N0bC5jICB8ICAgMyArLQ0KPiA+ICAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L3N0YV90eC5jIHwgICA5ICstDQo+ID4gICAuLi4vbmV0
L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC91YXBfY21kLmMgICAgfCAxNzEgKysrKysrKysNCj4g
PiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC91dGlsLmMgICB8IDEwNCAr
KysrKw0KPiA+ICAgMTggZmlsZXMgY2hhbmdlZCwgOTc0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogNzgzMDA0YjZkYmRhMmNmZTlhNTUy
YTRjYzljMWQxNjhhMjA2OGY2Yw0KPiANCj4gSSBhcHBsaWVkIHRoZSB0d28gY29tbWl0cyBvZiB0
aGlzIHNlcmllcyBvbiB0b3Agb2YgdjYuNyBidXQgdW5mb3J0dW5hdGVseSB0aGUgQVANCj4gaXMg
ZmFpbGluZyB0byBzdGFydCB3aXRoIHRoZSBwYXRjaGVzLiBJIGdldCB0aGlzIG91dHB1dCBmcm9t
ICJob3N0YXBkIC1kIiAocnVubmluZw0KPiBvbiBhIFZlcmRpbiBBTTYyIHdpdGggSVc0MTYpOg0K
PiANCj4gbmw4MDIxMToga2VybmVsIHJlcG9ydHM6IE1hdGNoIGFscmVhZHkgY29uZmlndXJlZA0K
PiBubDgwMjExOiBSZWdpc3RlciBmcmFtZSBjb21tYW5kIGZhaWxlZCAodHlwZT0xNzYpOiByZXQ9
LTExNCAoT3BlcmF0aW9uDQo+IGFscmVhZHkgaW4gcHJvZ3Jlc3MpDQo+IG5sODAyMTE6IFJlZ2lz
dGVyIGZyYW1lIG1hdGNoIC0gaGV4ZHVtcChsZW49MCk6IFtOVUxMXQ0KPiANCj4gSWYgSSBydW4g
dGhlIHNhbWUgaG9zdGFwZCBvbiB2Ni43IHdpdGhvdXQgdGhlIHBhdGNoZXMsIHRoZSBBUCBpcyBz
dGFydGVkIHdpdGggbm8NCj4gaXNzdWVzLg0KPiANCj4gDQo+IElzIHRoZXJlIGFueXRoaW5nIGVs
c2UgdGhhdCBzaG91bGQgYmUgZG9uZSBpbiBvcmRlciB0byB0ZXN0IHRoaXM/DQo+IA0KPiANCj4g
UmFmYWVsDQoNCkkgYXBwbGllZCBwYXRjaCB2OCAobWJveCBmcm9tIHBhdGNoIHdvcmspIHRvIExp
bnV4IHN0YWJsZSByZXBvc2l0b3J5ICh0YWcgdjYuNy4yKS4NCg0KQm90aCBjbGllbnQgYW5kIEFQ
IG1vZGUgY2FuIHdvcmsgd2l0aCBhbmQgd2l0aG91dCBXUEEzLg0KDQpEYXZpZA0KDQo=

