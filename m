Return-Path: <linux-kernel+bounces-16243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE46823B79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C191C24B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3521C6A4;
	Thu,  4 Jan 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoCRMCoQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1621A70F;
	Thu,  4 Jan 2024 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6O3TDIiEG2+9oJfv5sT9JlFgKie/TpHx/A5vRrRaATvyoOtPknoVHrlseY2oqizfI2rpx7DT/gcn3e9CKAnNq80UXZivCJ87NDMl1Dnb9nuaA98yNGABBQpW6Ohd1q4nYVW1vEjvun2ChufBU8/L918ZmElxeGcme3rLtYkVMIm0nq3A7YVoYN2jho3+m3dG1YRWY4jpGDm4e9RLPF5NB8H+fyUilxyOCp6ZtTury0dKhZ/BCOmhIxv2vlHv+6+S2s+2DJ3jZ6dWwp5VReO2IehtiG14Ymz4lhtzartjcHu2bEzLkjFxzEf447+9lyX16y1Ut2vWPXBFh4oxeShWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQQ0BEMyfWR8uwCEVKVUo0y2rjaQ303/rbAw5AiYa9k=;
 b=jELp41Lq7t/nUZkkF4dcqc1nCn650tmBWHfojLs6idSWsE0LRX4Y2aNRYMJTAaKMeOxItxeu3hEyXuJqXfkPuOpwpByRHVjr0fSvc1V5BENdMgD9/fHe3FZ5DOirHOd+awu/DE3WMyfv+byam1EU6OU1BGGKkg4NXIlsplGqeBF7FX9/1kxcpHL+AFeyR8PhoRdRImHbI5QoS+b42pEnUBo41CHqmLThkT6ik1N/4liyCoVf2oU1kVgb1qkpHc0gjzDuBE4IFb9+NMVR8h4HtqvXXDk0XyfkIze6C+EZe2JpqBwE4IYu29eQk06F3zQYaF2oc/B8h3fiix98OtBhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQQ0BEMyfWR8uwCEVKVUo0y2rjaQ303/rbAw5AiYa9k=;
 b=OoCRMCoQKj3YhBPQsUH+TcLG5eedeAgpJb2W0uJ/EgrKRFDgZbsvhrXwb2tD/Dwvmu/TL4ZWhvMk0iUvnWEx1O5wyVzZIfvoUzPldmPFIz7cHRv9GQ/ibNi8t8MOptpO/+LhrDm/feYx0GPAzzInZDz8QjE8Ut9G0qh6uhnBS9liSPE6yNx3iyWfjNYqVyd/VRFwNf4rpehZ43U1fTUjf/Y8irhMhnrPlK74O482W0G9CXhlTcEGdFFVqihOW4Fi3EKOJi69d+mMCyDk9PR5dy+V5iEBCAPCdxUxc/YfYYT+HFl+R+TrIjzQSCL9Rvmmn/olM5AokM0PAq5yCXOutw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 04:35:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 04:35:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, Gautam Menghani <gautam@linux.ibm.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "damien.lemoal@opensource.wdc.com"
	<damien.lemoal@opensource.wdc.com>, "zhouchengming@bytedance.com"
	<zhouchengming@bytedance.com>, "nj.shetty@samsung.com"
	<nj.shetty@samsung.com>, "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"riteshh@linux.ibm.com" <riteshh@linux.ibm.com>
Subject: Re: [PATCH] drivers/block/null_blk: Switch from radix tree api to
 xarrays
Thread-Topic: [PATCH] drivers/block/null_blk: Switch from radix tree api to
 xarrays
Thread-Index: AQHaOnX9UZmrpI+/OE6MN0I+LyD7TbDAefqAgAigEQA=
Date: Thu, 4 Jan 2024 04:35:46 +0000
Message-ID: <05b18725-dbf4-42eb-a233-d65611eb76bf@nvidia.com>
References: <20231229164155.73541-1-gautam@linux.ibm.com>
 <f1f002e9-8010-4b74-9da8-2551be97fa6f@kernel.dk>
In-Reply-To: <f1f002e9-8010-4b74-9da8-2551be97fa6f@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6644:EE_
x-ms-office365-filtering-correlation-id: 100a811e-3e53-4b9c-4b46-08dc0cde9f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bs+HQcxid/neG9K7LSBz8Hfa1ssruUOrrL+bl4VCAHXXf83FeOfsbDxPZfYIjSA4rNJxdHFVn5rCjGZRHX7GkjuHReEdNINPRUUMQ57y+2LWLn0G5WQ+1DK9/I0Gx7kXHKhCV7PTnCTtRXdNoC0cUmL3nxiX/HM+zNd9cj23Aq9pCc6doUJSoXjivMWEnghDMwduGxPUQxMNc2BgX5X9MZ25N1//PuQ+vlG/X+mdRBWm2gmGtm77YJKdXd6ef9DnF2ReJto/U7yJUFc9MjIJRt5KMoFRtluSVUZrW94cvAYEeD0HZo6tLjdxZyyhA7L5tG4bnIo6ap0b8JVZrjCRYU4pxHTn/Lx943UaKiMyvSoCRDCOQW/rxR+ToF6rNQOxSxXR8/G2RepT2IcR5qzyEWyCTmeCK5S6Q4rNXLbbip3ivpqsrIuGMIr496HGwBybaRKzuSDwrPKj/Jg/PdsiqqXGTmBJ80DxlhdEhFck3vDgy91dRTYJDdMXWIYlsajSS+PMm7aTKMIWTLNP3XGSDgtug5Bl9tja71Dez6apsFzygnAtMW9felSdSEVFQUBBTuc0Ww6DufZrrNqSTo9jfMGnrmkrizwnPPq/OLGIM3xznzQCtpPwIyEMmWULK7EFh2tIIAicPn/YbYB5P3j7NzXOj7YN+Smj0tS3hMmySTsBHP6cs8wGBRRH+naxYfVH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(7416002)(41300700001)(2906002)(2616005)(38100700002)(122000001)(8676002)(54906003)(110136005)(8936002)(316002)(71200400001)(5660300002)(4326008)(478600001)(64756008)(76116006)(66446008)(91956017)(6512007)(66556008)(66476007)(6486002)(66946007)(6506007)(53546011)(86362001)(38070700009)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WldRRkRsNTNzcXVvLzA2aitTNWRRdndmM3FDeFlYN3pRRmtOVGdZMldrN3Iy?=
 =?utf-8?B?blI4VVQ0QVdCWGhiUThIZ1BDWFdzZVFNTyszZHUzL3pJS01EVlQ5Vy95Qmx6?=
 =?utf-8?B?bGtpN1BsN0YvdEJWRWViM1k5Y090bDJMVThSZ2VReExvSmtVK1NLMzkwR1RV?=
 =?utf-8?B?cUdvNGl0b3F1TW0rVVRDV1hDSVJhbERvcXZCbG9RS2J6WThKQVc2YTQ3UDlN?=
 =?utf-8?B?cW4wRkdjZjNqRWRuL2NvVnZRNXp4bTNXMDNOWExoaWVtWmVTV1B3NkZrc3F1?=
 =?utf-8?B?eGc1OVpNY1pmWUlBb1NRT25QeGtQY2x3L3NuUlY2alB5ZzJhSk1TZVN1UnJD?=
 =?utf-8?B?czB2RzBkWHpmOXVsa29nZUpCdW5PZ3U2TVdmU1dFTklvLytBWmZWejgxcUNW?=
 =?utf-8?B?NDhGQWdsVTRQUjZzTS91UG10Nzh2RVpxdGtuQ1Y2WFN2bHU1U1FuQlMyaDBv?=
 =?utf-8?B?VWhUdFBnOU14SmUrVzRUR2k2bURkOTkwOWU4SmlaZHljWk9nbGowQzBtVElH?=
 =?utf-8?B?NG1JWXlsKy85Y293TXVSSEd0akFTOHBvdGpkdERPNWhaTWVOTjVDY1Z1TlBR?=
 =?utf-8?B?VjI2d0M5RW5hNFMzN3p6QWc4b2dJREFDcnRXSjBUWnlxYUt0TXVTbmhuMGM5?=
 =?utf-8?B?Sno2WjV3MlBVMHVONWJkbmpKcGphS3kwMnJoWTd2NkwveDdZb0VYMGszZEhI?=
 =?utf-8?B?OTVIYnl1dEg1TzVhZEQ5WDU4VEZ2QUJmekdrdE9ZdzdSNG0rWEtYNUVIRHZ0?=
 =?utf-8?B?VmkwYnlQSGdRSWt5Y2tyVzNUcVNuMnFFR0o0NUUyVktsTU9jd2p3emxYZnhS?=
 =?utf-8?B?SFk2R05iUmV2bTRGWGdSOFd1RENIdmRnQXhWbHFTaVdQU1p0c3VPa0FaOEE4?=
 =?utf-8?B?Q0RvdnNJYzM4dXh1QXhqb251RVVBMWFaRDVMNHRrWXJITnRkWDJtYUNpbGFP?=
 =?utf-8?B?dFFHREpEbVRnRE1Bb25vR2orRkVEMXZMczFPbkVwcWF6Z21qT1AxbCtnZTFG?=
 =?utf-8?B?YW9aejRwSG5GUU11Z1Rva1hXbHNpV3cxRG9scGJna0ZxNTUxQXcxdDVvSWJF?=
 =?utf-8?B?eExUZ3B3TFdFR3plcmlMZWtMamVsdWFzQkdJMjZBM3FkbWVkMlZPVHg2cUVT?=
 =?utf-8?B?K0oyNlNqUTkrSXRXOHMxaFd6VE1mMmhaQzh2MkVJejlxME1PUWRLOXBBKytv?=
 =?utf-8?B?MXgzUnVFZkQvRGQ0YW81T0lZMDViWE5rQzlTcjNTeDlrdlFYVUQ2SHVrZS9i?=
 =?utf-8?B?RWtienVIZ3VaK2tSSVBVL2ExS3o5VGV5dGVINmg5S1JCUHM1UWRkbkhOck1J?=
 =?utf-8?B?UlNRSTFXYTRzNVNuWDg3MlI0MFM5bnJUK3B2c3dweHg2V0twRWxpZENycFR5?=
 =?utf-8?B?UUNXaEFySnM1amRDaGROMGRXV0hJK243amphSkdpaEIwOEk3dVZOdS8xam9h?=
 =?utf-8?B?Q281N1RvU3FXR1JZSjFFenc4T2QxZkdqUXVHUnhWRFkwb0lBMnFOM251bHJG?=
 =?utf-8?B?andFbE0xRHlJbFg0cHpQR1RRTXJqOXRRdXROZkw5UVpQZ3cwVVhEVFk0R1Fi?=
 =?utf-8?B?RmNUWXZOSENoVnFpU0FPSkRUZlJPRnEvcjlZRk03SFB1cHoyUlFnV2ZHeHNL?=
 =?utf-8?B?TXRQYWR3VDB4RHhhYXdETUxXU1JodW9XU1U5UjFFN2h4ME5mdnZpays4S0JW?=
 =?utf-8?B?Mm5xck1OQUxuMXcrdzJwWFJuZDNBQXduL29NUlJ3MTBLUzJpbktpVTU4ZlFU?=
 =?utf-8?B?dHJtcC9hOFdpdUdJTXFkb0J3N0luMVBLWXdpMXlVamthcStaeU1jRTdRcjNo?=
 =?utf-8?B?ZmZmRUl6KzkrNTcrOHRtL1BhNUswcE5QYXdVMWY5QzhFTU9Lcmw5YWxSMFBC?=
 =?utf-8?B?S0x4U0xZRngwUEkzTzhHbGd1RUpudDVqRmtocGZyOFhuODdKMFhvS2x1RkJZ?=
 =?utf-8?B?dlU4SDRCMWMrdVp0SEJTTVEwRmtUSkNCQ1ltR003NE53Tk1XbkVkWVhCdkll?=
 =?utf-8?B?RXEzZzZGOUtHZUU3OW45N1FxTWxrZnZYcElsRGFpM2Y1M1hsYW5kUXZwc1Fw?=
 =?utf-8?B?bVZKYmJseDBPZ3IvekZSOVUxTmZQSHExRTIzam9DMno0bDQvSDN5QXpBdkVy?=
 =?utf-8?B?Y1dUOTJvZklVNFlsTDJwTFBoSVcvNGJlOE9Jd2RCMFFXSnFWSE9GUy80ZU05?=
 =?utf-8?Q?+Km/VthWTYZ/APvjOY52X6jTMEn1s2VcDw+XrGKllzhY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37A1C7EB2F2FD94EAEA6BAB33ACA9BB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100a811e-3e53-4b9c-4b46-08dc0cde9f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 04:35:46.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osaxDa4f68Tmjed5WWhvwvgeNyVl6R+0sXo8OdX721DWVWsVkFHtPUM+H9BUxdFQ3ft92O/DeuFKksty5gR0Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

T24gMTIvMjkvMjMgMDg6NTIsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDEyLzI5LzIzIDk6NDEg
QU0sIEdhdXRhbSBNZW5naGFuaSB3cm90ZToNCj4+IENvbnZlcnQgdGhlIG51bGxfYmxrIGRyaXZl
ciB0byB1c2UgdGhlIHhhcnJheSBBUEkgaW5zdGVhZCBvZiByYWRpeCB0cmVlDQo+PiBBUEkuDQo+
Pg0KPj4gVGVzdGluZzoNCj4+IFVzZWQgYmxrdGVzdHMgdGVzdCBzdWl0ZSAoYmxvY2sgYW5kIHpi
ZCBzdWl0ZXMpIHRvIHRlc3QgdGhlIGN1cnJlbnQNCj4+IG51bGxfYmxrIGRyaXZlciBhbmQgbnVs
bF9ibGsgZHJpdmVyIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLiBUaGUgdGVzdHMNCj4+IHJlc3Vs
dHMgaW4gYm90aCB0aGUgaW5zdGFuY2VzIHdlcmUgdGhlIHNhbWUuDQo+IFdoYXQncyB0aGUgcHVy
cG9zZSBvZiB0aGUgY2hhbmdlPw0KPg0KPiBPbmUgdGhpbmcgdGhhdCBhbHdheXMgYW5ub3lzIG1l
IHNsaWdodGx5IHdpdGggeGFycmF5IGlzIHRoZSBpbXBsaWVkDQo+IGxvY2tpbmcuIFNvIG5vdyB5
b3UncmUgZ3JhYmJpbmcgdHdvIGxvY2tzIHJhdGhlciB0aGFuIGp1c3QgdXRpbGl6aW5nIHRoZQ0K
PiBsb2NrIHRoYXQgd2FzIGFscmVhZHkgaGVsZC4gSSB0aGluayBhIGJldHRlciB0cmFuc2Zvcm1h
dGlvbiB3b3VsZCBiZSB0bw0KPiBmaXJzdCBjaGFuZ2UgdGhlIGxvY2tpbmcgdG8gYmUgY2xvc2Vy
IHRvIHRoZSBsb29rdXAgYW5kIGRlbGV0aW9uLCBhbmQNCj4gdGhlbiBjb252ZXJ0IHRvIHhhcnJh
eSBhbmQgbm93IGJlaW5nIGFibGUgdG8gZHJvcCB0aGF0IG90aGVyIGxvY2suIEp1c3QNCj4gZG9p
bmcgYSBibGluZCBjb252ZXJzaW9uIGxpa2UgdGhpcyB3aXRob3V0IHBvdGVudGlhbGx5IHVuZGVy
c3RhbmRpbmcgdGhlDQo+IGRldGFpbHMgb2YgaXQgaXMgbm90IGEgZ29vZCBpZGVhLCBpbWhvLg0K
Pg0KDQpJIGFncmVlIHhhcnJheSBpcyBhIGJldHRlciBkYXRhIHN0cnVjdHVyZSB0aGFuIHJhZGl4
IHRyZWUgdy5yLnQuIHdoYXQgd2UgZGlkDQpmb3IgYnJkLCBidXQgSSdtIHJlYWxseSBub3Qgc3Vy
ZSB3aGF0IGl0IHdpbGwgYnV5IGZvciBhIHRlc3RpbmcgZHJpdmVyIGxpa2UNCm51bGxfYmxrIHVu
bGVzcyBpdCBpcyB1c2VkIGluIHByb2R1Y3Rpb24gc29tZXdoZXJlIHdoZXJlIHJhZGl4IHRyZWVz
IGFyZSBub3QNCnN1ZmZpY2llbnQsIGJ1dCBJJ3ZlIG5vdCBzZWVuIHRoYXQgY2FzZSAuLi4NCg0K
LWNrDQoNCg0K

