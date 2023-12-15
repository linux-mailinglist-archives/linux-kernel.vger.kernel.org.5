Return-Path: <linux-kernel+bounces-566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEC814301
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CCA2823FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6E10A0E;
	Fri, 15 Dec 2023 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcBFqIVP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A2107A8;
	Fri, 15 Dec 2023 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSGjM65Bcn0mDsEQ7n5OSK0CFLQymtCX5ZNx4Wyokwnnv632V/o9sNfZRbNpR3ByzYJsuJqKjN2HLLUCaByv48ghYl+IGNOv3T4WRoWIE0ozsWXHGH9BqjnLzDofMK79nWBU92UAier4XylP2Yccjp9BTa/YzT7m8nlvLb/iSt36b1BPVexPoriPfOqJZWtgIbGGqhcQcA5l5+EVpHn+YbOssun5g1UzWldc/0QZhgaY7MKqEHsUk6M/DjNw1HTAzDddDxyKGkc/HaTxa8fsaipciRAri9b4er/A5mihIHnHx9o5i5Skyc5VjzzV+Jy4fSeoOIwdWtGdAjW85Goanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt1Nfjq7n6uySiDJvizoYG0pNt8789q1BI7reMdqufs=;
 b=W2p3IpWbLUrJWSREEhm+BMol5bh2yTqvjfs7cAddzIf9KU/Yw40pgf2lrfAUSFh4OV3NB78pL8rNlDomamqGb6H70CjwRmQjqZwvwAZ86w9rsSI1yllkFmCZtO5drILyRFGjF0wrrAdzb+aruHifVXr9F8+kKF8p9FiX3a7kuo/cd9z/V+6FH96yWrzfJKFf72SWHxplsIkDcPsZLVwXyM800FTuKufB296bANFhff20AFie/A2+zGPyANLhGovkMQOrJ8fOySaRCASATPGkRGOCvBDPaNeOLMcXEqF4790cYESaSpQ+zXVSbmbbq2Czlync8eOJYMqCQug2w6A6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt1Nfjq7n6uySiDJvizoYG0pNt8789q1BI7reMdqufs=;
 b=gcBFqIVPhCTqPLRZIVOUqSID1D21TIkGRBtIoNU0klPOybkwVVuICzxvsd+IIDMuvzNErf8XVG+fy5h9J3Znw8B54vsDtBtWlgh7/S8kNBkGua8ret+SwdO7zc5fyjiWlCvEN2ac+/HzD6SOFbG9y5ZjF+pqKJ+bRYRDa6C1oaE=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:55:26 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:55:26 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECA=
Date: Fri, 15 Dec 2023 07:55:25 +0000
Message-ID:
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
In-Reply-To: <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DS7PR12MB8249:EE_
x-ms-office365-filtering-correlation-id: 654fc680-83e9-4bec-9e28-08dbfd43324a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S0Ccb5XwnK9GmiwrOj7vdNr3wU+k79g+dSYP/bmyYU8T7Gu2Vt+QwLG/9sFITqZ0twRZgt5KYnwpxLctPtW2ufR2FE2JrsFvLKyYxDuAQdUYuBK0M8eOSYsssnaU0aQeqHbTaK5yq6EpET4vaKdqJtYWFCYlaF8hEBX/sqz4ybaZCbb4rdvhZ4oBIKJKS3o6frcFOVnoxV2SiYP0y3ZpL0LEBTXPmNIdHGyUcXwum877cNlMcp4N7QBKjmiDFCVjQc41WNW/DskLC3BrgTCiiKWxXxO8jnOmimsqh0IekzKjcl533rIntxyWJ731ATYkFSDqqDAn2TIsrs+cfEB5Cs3j7Hm106HMF963AnPzOzrYgKR3Y63ZPEMTDl+EgiobulBio05eQtYzNZX9taVJJihL73QKMCinYQwJhIIG0WVFEiI1p1MbHIww8xoaDT7I6vVZy1UnmeXeHAouw5cH3V4E+1j0Z0cvlNv2qPLaQ9lj/U5d3j1AMBPgvwC1mW6pRFPTBEbBX7G6wO8F9pNkExioeHVTxh2E8M5gdOOHWNzA8/Nrrj7OUdLEC9SSbgJTcrC42A0nHETZig5uQDECi7sNs9nZZisAbr/XLXkGQRZQHtOL+YZtYalGpRAT3eWRof3UbB27i19EyrRCF//z3QTxC09ZQmLHvnhB2POJZ4Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(966005)(478600001)(9686003)(7696005)(6506007)(66476007)(66556008)(66446008)(64756008)(54906003)(316002)(7416002)(53546011)(2906002)(122000001)(26005)(921008)(71200400001)(86362001)(38070700009)(55016003)(52536014)(76116006)(66946007)(110136005)(4326008)(8676002)(8936002)(41300700001)(83380400001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUNja2RQUldVUGNHNVpaU3ByWk13a2RPalZiMEJ3dXVlNkptbzNCMGNPMzNn?=
 =?utf-8?B?RHU0dUt6UFZWSHhGVFJXQjlWeEMvSUxjdnVBUDRhelU3b2NWcUVnMFlZYTg1?=
 =?utf-8?B?YW5Qa3A0UFlyNS9JaEoybEpBZXhtdlVEWWVaNlFycGNpcTd6bmMyTCtlcEhX?=
 =?utf-8?B?aHp0WmoyZDlyN0NVNWU3dnQwL3d2Syswb0pJbjdIYlN2WnNkeHc4enYzRTVk?=
 =?utf-8?B?dkpwNmdTemw1YWFVbEgvUFQyNmJoZVdlZHA3MjVpMVRXK09CckNjS3VjZWJm?=
 =?utf-8?B?WnlYcE96M3BISXd4WjhSTVBja1BqR05JNGlicTgrVWtNNVZ0d0Z0czI1R3lZ?=
 =?utf-8?B?QnZ2eUlZdVA3dnhXOXA2ZWlNakVTbUd3cUdtMlJ6VURWMXNsQnFENzJJRElq?=
 =?utf-8?B?cGtYUHRuMGRkRzdtTHZZMmVnQVpJQmNsRFRnS0NXWWw3c2pSUDlOempBOXZt?=
 =?utf-8?B?eU5TTVdMTHRuN2xzNlc5QW56UDRuT0w0TUdzV0sycmNqa1FoVG9TVkdNaVZa?=
 =?utf-8?B?Nm9XajlENm54MGZGQkpKM1NkdkwrZ3l4dXJvQ2VXS205T1M0eGNlRFZjWWdN?=
 =?utf-8?B?SmVWY2ZiMDgyc05oMFIzbGlWRU9STTVpKzFDSVBML2NPZGJLVGt1Ym5ROXM4?=
 =?utf-8?B?RWwxTndkZVBwdXdXdGl4ckpUT1VJYVZPK0YwNXJXY2ZmWDU5U2NucWt4SnVO?=
 =?utf-8?B?MUlSUzN2QVJYS1hBV1djMjJDMTVpY1VXUkV6Rk5YTVRNWnpIWGlkWmhBamhS?=
 =?utf-8?B?ZllqUVJoZ2d4Ti9TNmltS2RnZ0hvVjhRUVY3dEpOdkNVQUVJVnBQMEZFQUxS?=
 =?utf-8?B?TGFMQ0lGQlV3S1ZhbGUrVW03OFFhczN3TlIwNmY3eGNHNE51djA5TzRVUFh6?=
 =?utf-8?B?SnUxZVN5L3BoQ3ozWEpPejl5Tkg4R3pFMnRSMnFKN1hNcmI3VEg5T0cvS2pk?=
 =?utf-8?B?amVsMC9pZklhdGUzQS8xRWc0OUl2N1p0dlRFeU85VDJSS3l2NCtBci9taWN6?=
 =?utf-8?B?ZFdUZkFUcENiMHBBZnIwc2piUEJML0pQYUdteTE2OUw3WlZFdFRWcW1scUZS?=
 =?utf-8?B?a0xHcXhqV3J0K29DV2NWMXI2UWFwb01FeklCUDF0NklPek9zejBlZ2NaQUlm?=
 =?utf-8?B?eDZNTmpRY0V4ZmFVRFFxaHRjdlBYTFhSRHFDUTROUWpKaExrQ29KMWJwYlg4?=
 =?utf-8?B?V2NUTG1lYkc1eHFVcHJlTWRQNDNpc2haaWVneGI4RDRWTjB1YzFhVmF2cFZq?=
 =?utf-8?B?cGJ1TTVQRVhpbndqbnpqNEJDR1cyM0tlclVaa21PMlR5SGR5RllRTEJPWkU1?=
 =?utf-8?B?Z05PTm5BS3o4UDZMUEtMS0w1UEIzcVkycTVPem82Q25lVlFlVXl3dU1jK09R?=
 =?utf-8?B?Nmt3aWJBWCtXSlpSL1FqUnVqeGtvanZqa2F1WDVRRVNxayt3K3pjck1YTWd2?=
 =?utf-8?B?Z09jTmhpS1pabjI1bTVmdjB5Z21EakoxV3pHcmZyaFdFRnc1Lys2YkVqYk11?=
 =?utf-8?B?UkhHMlE0dFFERWNiWDQ3U2Q1Y3R5VDA0R0R0ZmRKSzIrUTRXL2JXajd4bnNy?=
 =?utf-8?B?MlEvUmxEMkpTaThPV0h1NnB4RHp5RnY3b3RsclFNZTlUNTFwbTFYbTlUMlUw?=
 =?utf-8?B?aE16SnBLRElYdUFqcTBrRkRaT3llWXNkTURlUENQSVVDR05CdEtkRktKWlZo?=
 =?utf-8?B?bGN4SytPbHExM29BKzliS2pSTHQvcDF5YTNyU0h2amkyNWJlV1Qxbld2M252?=
 =?utf-8?B?Q3RZcnE4UG1oY0YxcnBzU2hZa0M3NFRRclI4a2YwQU03VE1WcDZ1aXVRbXJH?=
 =?utf-8?B?c3E1TGxzSS8xeXN3RWtMeXZJZ01FOThIZmVWUnRyZExmT29YdXhzMHNaanFY?=
 =?utf-8?B?K1NoR3JOWVFwMC9SUmJUdTZuRGVaR2VzL1N6bDNJRWJiWGo3TjR6T1VHdnhM?=
 =?utf-8?B?VWk0VmlReFJWWS9LSnViK2lWWmZUZW9IWVVpeTBTdGNoKzJ4WTdBQ3NmS2Jm?=
 =?utf-8?B?WDJvTi9PQVZSREdrNHFZV0E2K29jNldGQTlGUzdPM0VWdm9YZmxuZ1VkWWxF?=
 =?utf-8?B?RHBZRy9vOTBKK3B4VkNDcE95WGJ2Wjc1dGY4RjhKNnRIcnZQQWJCcS80TjNy?=
 =?utf-8?Q?brCA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654fc680-83e9-4bec-9e28-08dbfd43324a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:55:25.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgEPsE+V/MTL0Oqmk8YExnxqHEW4bnsLfQSylYG18OtR0uRCWJm/1QjUvawGQOfQPdFnInUr4wR0K8NwUKsVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAxMiwgMjAyMyA4OjMzIFBNDQo+IFRvOiBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgPGFt
aXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+Ow0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHByYXR5
dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207DQo+IHJpY2hhcmRAbm9k
LmF0OyB2aWduZXNockB0aS5jb207IHNiaW5kaW5nQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsNCj4g
bGVlQGtlcm5lbC5vcmc7IGphbWVzLnNjaHVsbWFuQGNpcnJ1cy5jb207IGRhdmlkLnJob2Rlc0Bj
aXJydXMuY29tOw0KPiByZkBvcGVuc291cmNlLmNpcnJ1cy5jb207IHBlcmV4QHBlcmV4LmN6OyB0
aXdhaUBzdXNlLmNvbQ0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWljaGFlbEB3YWxsZS5jYzsgbGludXgtbXRkQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsgYWxleGFuZHJl
LmJlbGxvbmlAYm9vdGxpbi5jb207DQo+IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7DQo+IHBhdGNoZXNA
b3BlbnNvdXJjZS5jaXJydXMuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAo
QU1ELQ0KPiBYaWxpbngpIDxnaXRAYW1kLmNvbT47IGFtaXRya2NpYW4yMDAyQGdtYWlsLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAwNy8xMF0gbXRkOiBzcGktbm9yOiBBZGQgc3RhY2tl
ZCBtZW1vcmllcyBzdXBwb3J0DQo+IGluIHNwaS1ub3INCj4gDQo+IA0KPiANCj4gT24gMTIvMTEv
MjMgMTM6MzcsIE1haGFwYXRyYSwgQW1pdCBLdW1hciB3cm90ZToNCj4gDQo+IEhpIQ0KPiANCj4g
Y3V0DQo+IA0KPiA+Pj4+Pj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgfCAyNzINCj4g
Pj4+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4+Pj4gLS0NCj4g
Pj4+Pj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggIHwgICA0ICsNCj4gPj4+Pj4+PiAg
aW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIHwgIDE1ICstDQo+ID4+Pj4+Pj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjQwIGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pj4+DQo+
ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+Pj4+
Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBpbmRleCA5M2FlNjliN2ZmODMuLmU5OTBi
ZTdjN2ViNg0KPiA+Pj4+Pj4+IDEwMDY0NA0KPiA+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBjdXQNCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4gQEAgLTI5MDUsNyAr
MzAwNywxMCBAQCBzdGF0aWMgdm9pZA0KPiA+Pj4+Pj4+IHNwaV9ub3JfaW5pdF9maXh1cF9mbGFn
cyhzdHJ1Y3Qgc3BpX25vciAqbm9yKSAgc3RhdGljIGludA0KPiA+Pj4+Pj4+IHNwaV9ub3JfbGF0
ZV9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vcg0KPiA+Pj4+Pj4+ICpub3IpICB7DQo+ID4+Pj4+
Pj4gIAlzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9DQo+ID4+Pj4+Pj4g
c3BpX25vcl9nZXRfcGFyYW1zKG5vciwNCj4gPj4+Pj4+IDApOw0KPiA+Pj4+Pj4+IC0JaW50IHJl
dDsNCj4gPj4+Pj4+PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBzcGlfbm9yX2dldF9mbGFz
aF9ub2RlKG5vcik7DQo+ID4+Pj4+Pj4gKwl1NjQgZmxhc2hfc2l6ZVtTTk9SX0ZMQVNIX0NOVF9N
QVhdOw0KPiA+Pj4+Pj4+ICsJdTMyIGlkeCA9IDA7DQo+ID4+Pj4+Pj4gKwlpbnQgcmMsIHJldDsN
Cj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+ICAJaWYgKG5vci0+bWFudWZhY3R1cmVyICYmIG5vci0+bWFu
dWZhY3R1cmVyLT5maXh1cHMgJiYNCj4gPj4+Pj4+PiAgCSAgICBub3ItPm1hbnVmYWN0dXJlci0+
Zml4dXBzLT5sYXRlX2luaXQpIHsgQEAgLTI5MzcsNg0KPiA+Pj4+Pj4+ICszMDQyLDQ0IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yDQo+ICpub3Ip
DQo+ID4+Pj4+Pj4gIAlpZiAocGFyYW1zLT5uX2JhbmtzID4gMSkNCj4gPj4+Pj4+PiAgCQlwYXJh
bXMtPmJhbmtfc2l6ZSA9IGRpdjY0X3U2NChwYXJhbXMtPnNpemUsDQo+IHBhcmFtcy0NCj4gPj4+
PiBuX2JhbmtzKTsNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+ICsJbm9yLT5udW1fZmxhc2ggPSAwOw0K
PiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+PiArCS8qDQo+ID4+Pj4+Pj4gKwkgKiBUaGUgZmxhc2hlcyB0
aGF0IGFyZSBjb25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlIHNob3VsZCBiZQ0KPiA+PiBvZg0KPiA+
Pj4+Pj4+ICtzYW1lDQo+ID4+Pj4+PiBtYWtlLg0KPiA+Pj4+Pj4+ICsJICogRXhjZXB0IHRoZSBm
bGFzaCBzaXplIGFsbCBvdGhlciBwcm9wZXJ0aWVzIGFyZSBpZGVudGljYWwNCj4gPj4+Pj4+PiAr
Zm9yIGFsbA0KPiA+PiB0aGUNCj4gPj4+Pj4+PiArCSAqIGZsYXNoZXMgY29ubmVjdGVkIGluIHN0
YWNrZWQgbW9kZS4NCj4gPj4+Pj4+PiArCSAqIFRoZSBmbGFzaGVzIHRoYXQgYXJlIGNvbm5lY3Rl
ZCBpbiBwYXJhbGxlbCBtb2RlIHNob3VsZCBiZQ0KPiA+PiBpZGVudGljYWwuDQo+ID4+Pj4+Pj4g
KwkgKi8NCj4gPj4+Pj4+PiArCXdoaWxlIChpZHggPCBTTk9SX0ZMQVNIX0NOVF9NQVgpIHsNCj4g
Pj4+Pj4+PiArCQlyYyA9IG9mX3Byb3BlcnR5X3JlYWRfdTY0X2luZGV4KG5wLCAic3RhY2tlZC0N
Cj4gPj4gbWVtb3JpZXMiLA0KPiA+Pj4+Pj4gaWR4LA0KPiA+Pj4+Pj4+ICsmZmxhc2hfc2l6ZVtp
ZHhdKTsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBUaGlzIGlzIGEgbGl0dGxlIGxhdGUgaW4gbXkgb3Bp
bmlvbiwgYXMgd2UgZG9uJ3QgaGF2ZSBhbnkgc2FuaXR5DQo+ID4+Pj4+PiBjaGVjayBvbiB0aGUg
Zmxhc2hlcyB0aGF0IGFyZSBzdGFja2VkIG9uIHRvcCBvZiB0aGUgZmlyc3QuIFdlDQo+ID4+Pj4+
PiBzaGFsbCBhdCBsZWFzdCByZWFkIGFuZCBjb21wYXJlIHRoZSBJRCBmb3IgYWxsLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBBbHJpZ2h0LCBJIHdpbGwgaW5jb3Jwb3JhdGUgYSBzYW5pdHkgY2hlY2sgZm9y
IHJlYWRpbmcgYW5kDQo+ID4+Pj4+IGNvbXBhcmluZyB0aGUgSUQgb2YgdGhlIHN0YWNrZWQgZmxh
c2guIFN1YnNlcXVlbnRseSwgSSBiZWxpZXZlDQo+ID4+Pj4+IHRoaXMgc3RhY2tlZCBsb2dpYyBz
aG91bGQgYmUgcmVsb2NhdGVkIHRvIHNwaV9ub3JfZ2V0X2ZsYXNoX2luZm8oKQ0KPiA+Pj4+PiB3
aGVyZSB3ZSBpZGVudGlmeSB0aGUgZmlyc3QgZmxhc2guIFBsZWFzZSBzaGFyZSB5b3VyIHRob3Vn
aHRzIG9uIHRoaXMuDQo+ID4+Pj4+IEFkZGl0aW9uYWxseSwgZG8geW91DQo+ID4+Pj4NCj4gPj4+
PiBJJ20gd29uZGVyaW5nIHdoZXRoZXIgd2UgY2FuIGFkZCBhIGxheWVyIG9uIHRvcCBvZiB0aGUg
Zmxhc2ggdHlwZQ0KPiA+Pj4+IHRvIGhhbmRsZQ0KPiA+Pj4NCj4gPj4+IFdoZW4geW91IG1lbnRp
b24gIm9uIHRvcCwiIGFyZSB5b3UgcmVmZXJyaW5nIHRvIGluY29ycG9yYXRpbmcgaXQNCj4gPj4+
IGludG8gdGhlIE1URCBsYXllcj8gSW5pdGlhbGx5LCBNaXF1ZWwgaGFkIHN1Ym1pdHRlZCB0aGlz
IHBhdGNoIHRvDQo+ID4+PiBhZGRyZXNzDQo+ID4+DQo+ID4+IEkgbWVhbiBzb21ldGhpbmcgYWJv
dmUgU1BJIE1FTSBmbGFzaGVzLCBiZSBpdCBOT1IsIE5BTkRzIG9yIHdoYXRldmVyLg0KPiA+PiBJ
bnN0ZWFkIG9mIHRyZWF0aW5nIHRoZSBzdGFja2VkIGZsYXNoZXMgYXMgYSBtb25vbGl0aGljIGRl
dmljZSBhbmQNCj4gPj4gdHJlYXQgaW4gU1BJIE5PUiBzb21lIGFycmF5IG9mIGZsYXNoZXMsIHRv
IGhhdmUgYSBsYXllciBhYm92ZSB3aGljaA0KPiA+PiBwcm9iZXMgdGhlIFNQSSBNRU0gZmxhc2gg
ZHJpdmVyIGZvciBlYWNoIHN0YWNrZWQgZmxhc2guIEluIHlvdXIgY2FzZQ0KPiA+PiBTUEkgTk9S
IHdvdWxkIGJlIHByb2JlZCB0d2ljZSwgYXMgeW91IHVzZSAyIFNQSSBOT1IgZmxhc2hlcy4NCj4g
Pj4NCj4gPj4+IHN0YWNrZWQvcGFyYWxsZWwgaGFuZGxpbmcgaW4gdGhlIE1URCBsYXllci4NCj4g
Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIwMDExNDE5MTA1Mi4wYTE2
ZDExNkB4cHMxMy90Lw0KPiA+Pj4gSG93ZXZlciwgdGhlIERldmljZSBUcmVlIGJpbmRpbmdzIHdl
cmUgaW5pdGlhbGx5IG5vdCBhY2NlcHRlZC4NCj4gPj4NCj4gPj4gT2theSwgdGhhbmtzIGZvciB0
aGUgcG9pbnRlci4gSSdsbCB0YWtlIGEgbG9vay4NCj4gDQo+IGhhdmVuJ3QgeWV0IHJlYWQgdGhl
IHRocmVhZCBmcm9tIGFib3ZlLCBidXQgSSBza2ltbWVkIG92ZXIgdGhlIEFNRA0KPiBjb250cm9s
bGVyIGRhdGFzaGVldC4NCj4gDQo+ID4+DQo+ID4+PiBGb2xsb3dpbmcgYSBzZXJpZXMgb2YgZGlz
Y3Vzc2lvbnMsIHRoZSBiZWxvdyBiaW5kaW5ncyB3ZXJlDQo+ID4+PiBldmVudHVhbGx5IG1lcmdl
ZC4NCj4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDEyNjExMjYwOC45NTU3
MjgtNC1taXF1ZWwucmF5bmFsQGJvDQo+ID4+PiBvdA0KPiA+Pj4gbGluLmNvbS8NCj4gPj4NCj4g
Pj4gSSBzYXcsIHRoYW5rcy4NCj4gPj4NCj4gPj4+DQo+ID4+Pj4gdGhlIHN0YWNrZWQvcGFyYWxs
ZWwgbW9kZXMuIFRoaXMgd2F5IGV2ZXJ5dGhpbmcgd2lsbCBiZWNvbWUgZmxhc2gNCj4gPj4+PiB0
eXBlIGluZGVwZW5kZW50LiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBzdGFjayAyIFNQSSBOQU5E
cz8gSG93DQo+ID4+Pj4gYWJvdXQgYSBTUEkgTk9SIGFuZCBhIFNQSSBOQU5EPw0KPiA+Pj4+DQo+
ID4+Pj4gSXMgdGhlIGRhdGFzaGVldCBvZiB0aGUgY29udHJvbGxlciBwdWJsaWM/DQo+ID4+Pg0K
PiA+Pj4gWWVzLA0KPiA+Pj4gaHR0cHM6Ly9kb2NzLnhpbGlueC5jb20vci9lbi1VUy9hbTAxMS12
ZXJzYWwtYWNhcC10cm0vUXVhZC1TUEktQ29udHINCj4gPj4+IG9sDQo+ID4+PiBsZXINCj4gPj4+
DQo+ID4+DQo+ID4+IFdvbmRlcmZ1bCwgSSdsbCB0YWtlIGEgbG9vay4gSSBzZWUgdHdvIGNsb2Nr
cyB0aGVyZS4gRG9lcyB0aGlzIG1lYW4NCj4gPj4gdGhhdCB0aGUgc3RhY2tlZCBmbGFzaGVzIGNh
biBiZSBvcGVyYXRlZCBhdCBkaWZmZXJlbnQgZnJlcXVlbmNpZXM/IERvDQo+ID4+IHlvdSBrbm93
IGlmIHdlDQo+ID4NCj4gPiBJbiBzdGFja2VkIGNvbmZpZ3VyYXRpb24sIGJvdGggZmxhc2hlcyB1
dGlsaXplIGEgY29tbW9uIGNsb2NrIChzaW5nbGUNCj4gPiBjbG9jayBsaW5lKS4gSW4gYSBwYXJh
bGxlbCBzZXR1cCwgdGhlIGZsYXNoZXMgc2hhcmUgdGhlIHNhbWUgY2xvY2sgYnV0DQo+ID4gaGF2
ZSBkaXN0aW5jdCBjbG9jayBsaW5lcy4gUGxlYXNlIHJlZmVyIHRoZSBkaWFncmFtcyBpbiB0aGUg
c2VjdGlvbnMNCj4gPiBiZWxvdyBmb3IgcmVmZXJlbmNlLg0KPiA+IGh0dHBzOi8vZG9jcy54aWxp
bnguY29tL3IvZW4tVVMvYW0wMTEtdmVyc2FsLWFjYXAtdHJtL1FTUEktRmxhc2gtSW50ZXINCj4g
PiBmYWNlLURpYWdyYW1zDQo+IA0KPiBUaGFua3MhIENhbiB5b3Ugc2hhcmUgd2l0aCB1cyB3aGF0
IGZsYXNoZXMgeW91IHVzZWQgZm9yIHRlc3RpbmcgaW4gdGhlDQo+IHN0YWNrZWQgYW5kIHBhcmFs
bGVsIGNvbmZpZ3VyYXRpb25zPw0KDQpJIHVzZWQgU1BJLU5PUiBRU1BJIGZsYXNoZXMgZm9yIHRl
c3Rpbmcgc3RhY2tlZCBhbmQgcGFyYWxsZWwuDQoNCj4gDQo+ID4+IGNhbiBjb21iaW5lIGEgU1BJ
IE5PUiB3aXRoIGEgU1BJIE5BTkQgaW4gc3RhY2tlZCBjb25maWd1cmF0aW9uPw0KPiA+DQo+ID4g
Tm8sIFhpbGlueC9BTUQgUVNQSSBjb250cm9sbGVycyBkb2Vzbid0IHN1cHBvcnQgdGhpcyBjb25m
aWd1cmF0aW9uLg0KPiA+DQo+IA0KPiAyIFNQSSBOQU5EcyBzaGFsbCB3b3JrIHdpdGggdGhlIEFN
RCBjb250cm9sbGVyLCByaWdodD8NCg0KV2UgbmV2ZXIgdGVzdGVkIDIgU1BJLU5BTkQgd2l0aCBB
TUQgY29udHJvbGxlci4NCj4gDQo+IEkgc2tpbW1lZCBvdmVyIHRoZSBRU1BJIGNvbnRyb2xsZXIg
ZGF0YXNoZWV0IGFuZCB3b25kZXJlZCB3aHkgb25lIHdvdWxkDQo+IGdldCBjb21wbGljYXRlZCB3
aXRoIDIgUXVhZCBGbGFzaGVzIHdoZW4gd2UgaGF2ZSBPY3RhbC4gQnV0IHRoZW4gSSBzYXcgdGhh
dA0KPiB0aGUgc2FtZSBTb0MgY2FuIGNvbmZpZ3VyZSBhbiBPY3RhbCBjb250cm9sbGVyICh0aGUg
T2N0YWwgYW5kIFF1YWQNCj4gY29udHJvbGxlcnMgc2VlbXMgbXV0dWFsIGV4Y2x1c2l2ZSkgYW5k
IHRoYXQgdGhlIE9jdGFsIG9uZSBjYW4gb3BlcmF0ZSAyDQo+IG9jdGFsIGZsYXNoZXMgaW4gc3Rh
Y2tlZCBtb2RlIDopLg0KDQpUaGF0cyBjb3JyZWN0IC4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGhv
dyB5b3Ugd2FudCBtZSB0byBwcm9jZWVkIG9uIHRoaXMuDQoNClJlZ2FyZHMsDQpBbWl0DQo+IA0K
PiBDaGVlcnMsDQo+IHRhDQo=

