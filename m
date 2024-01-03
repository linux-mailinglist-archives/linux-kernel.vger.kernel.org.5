Return-Path: <linux-kernel+bounces-15252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9A822925
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4740B219CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349818050;
	Wed,  3 Jan 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="PZv2jw4m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A201803B;
	Wed,  3 Jan 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYLrqqMKrFpewOIom5mD0C1FtMnTxFNn4h1qgA3BenRecI5/8u/yw0aS7QWkUdgjmYQFP9/RwIDb8+p/MsC1NqFNjDdQYObLLnIRnu/2o1L3YKchp4o0K9i5osCDsSMfo5jico0Ec8OMZadAxw6oBmzxUEJCTuhF3zXY2vBbAeMhopu2Dlj1yXrAcELI7OQZQO1NOuGOBry0ZPb1Zr1bXQYwJIku5XTxhwu6VWceiLHQ+5GTADXWAS3LJWCJKv9dYuF2f3t0y9aza4+RoQBVDkhsZ1IF+Iq141n/1vCUOtxjD14CMCLV73VdU8RacR/QTgAdAE1flSa0cjUZrUArLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHQ3eSUTIlrT/G6KA++VN+jeSQc0CVWXibdnxUPdOhk=;
 b=Np+/oFgt491l2hkRXoNtpYtnKpg003UOVcn7xLRAC9WGkIyyPYHi2K9kxegwiQAI3gpqipsoq1ZgaO0Z6IjVQ9bxhXF7mQb8ezdS/m8kqjg+rtoKRAhRpncxcWijcPm7sVwARtWwPywNzPvB6RdC/o+xECGtqeLxPHl3F0h3ZIFA3DLLBGtuWHsa2ChudDepI5Pgkps2SksM+jCSg3va7E3hmt/ktTyWTVZFXjZLALVnzzTiph2RHlyK5cBV6+Vp1z1ClPKA0ot7T40onWE37QOY/56qWbKTI0ARSX27B2f9BdO+p4s4EpC1eFh6biLDfA5gDXfE/ojzCLGyzEmJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHQ3eSUTIlrT/G6KA++VN+jeSQc0CVWXibdnxUPdOhk=;
 b=PZv2jw4mQ4z3MTYUJUvWgMgrZO/Ic+NFEX61CpIrf69ZDEcdjn3NnmeCe82ZF8QVPmeqc6e3DUGKEaINszmteMQtQrWdsrNCZF7I0a5xT6QC8sCfL+tQocWpKBQb2Q8MYOknoThKQHh3G1z+RQ3kfE9td2oQnQHAWtOFKBB+U5dsY3K2h4UVefn8BVTqMh42uAFhs/Lyn4UwhQtFOjy+Ffelq3uw+si58Qcdp0/8yb6prZ6NbyHLv7BjDd55G6GddZ+Xfy8DRlWWJIsaqCVsojclbfXLBImCs/wGHbCpT9UMirhUmvzkrq41WDyC2cfb7JF2dd8OaoyWA5on6dBTgg==
Received: from PH0PR08MB7955.namprd08.prod.outlook.com (2603:10b6:510:11a::17)
 by DM4PR08MB8247.namprd08.prod.outlook.com (2603:10b6:8:46::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11; Wed, 3 Jan
 2024 07:56:43 +0000
Received: from PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974]) by PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 07:56:42 +0000
From: Srinivasulu Thanneeru <sthanneeru@micron.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: gregory.price <gregory.price@memverge.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com"
	<john@jagalactic.com>, Eishan Mirakhur <emirakhur@micron.com>, Vinicius
 Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Wei Xu
	<weixugc@google.com>
Subject: RE: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Topic: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Index:
 AQHaLe1WCWEmLbBSRk2O5Sdey42WeLCpzLPHgADTuACAA/H6xIAZGhOAgAAO84SAABl24A==
Date: Wed, 3 Jan 2024 07:56:42 +0000
Message-ID:
 <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=1f688faa-4c3f-40e2-b45d-409ec7bacdb0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-01-03T07:42:13Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB7955:EE_|DM4PR08MB8247:EE_
x-ms-office365-filtering-correlation-id: 2536b92d-bd78-40de-297c-08dc0c318682
x-ld-processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2BEQRxT0+7w7pTj/QhDKwowt76Ov9KEIdzWZcPQgucEzhN4p5NWLarr+J1fD6+xCXshq440GvCFJ9Q5gXfDF+l/l5/1EwzpxXZvESI0USHhJ19lK1D8HFFCEPEugenAOqpfnptVtZYJyX1FpeuQD7Qr0eE7ySjgpU6H1t6g/0BibpUwEVkRl8E7fggW6nilpV51NJgXwUaE2EO0CgnTUw4DUEKlVF/fX6Fpk75jJ9jRs9aTbMoNKrCozd7JoBf/k20bsuClZuONbCPWH66OfLP1lvXQDZ7xdFMC9QBoEEkZSdpW/JvBHIUZu85sj4aD6+7DrePKie9aGpmaX2XvXdC0xi0qIr4PsaPGeje2qsqUbEoiyqmBlja6p/puzKbo3df6QcrvDNWuKd4awouk4NRxrN/G8lFQQVX0+oEAzSj2CUxEBPczTqcd0TXzgmmX5BWX6wKCje66CjhUDUyb79pX8ZBPQm2EkJ21oGu2W+pOUtIDLUye2FLzIPM8Yax8fuxwNu5UXIP/I+QX/KPNacL5EzwA6MeGplqrt5bvcOkCkiaHckC3b7Gjp+svftOigz0uvAy/dEwUSW+6caEiKvq5y/TbAdjD2Xrz25tPX3Zi3xYDelUjFVeEvtdCku+AuSf7K+cBiPpRqtgoB8lF1yA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7955.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(26005)(6506007)(76116006)(5660300002)(54906003)(53546011)(7416002)(4326008)(52536014)(45080400002)(2906002)(7696005)(6916009)(122000001)(316002)(478600001)(8676002)(8936002)(66446008)(66476007)(66556008)(41300700001)(64756008)(66946007)(966005)(86362001)(33656002)(9686003)(38100700002)(71200400001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?YjM3MDFrbExYd2ZIejdYb0loZnBuejNnalNTS3ZFd0R3ZlZPQnJoeGZ1ejdQ?=
 =?utf-7?B?RDZhb2hnSTlOU0xTd1BmV0wzOEVDMTBZUCsta0s5MDJ3a1V4eTQrLUZSZzNo?=
 =?utf-7?B?cjdIQ1pFaWJiZlROblpTS1QyMTd4Rkt1akY1RGdKZ1cwVlJuRXM1YUxCa1FC?=
 =?utf-7?B?M3MzQ05MWWU2SElUYnhoTk9NVnNadUpuME8zQ2R0MzAyNVYrLXB3REF2Z2Q4?=
 =?utf-7?B?UFBYc1JaWnpiMFhoVmp4SUpsM2VHekFkQUtiS2VuTlBXTDF4WXNUdUxrUUta?=
 =?utf-7?B?WVdvMFdJT0x1dHlsMWcyUFp5dm00Vm5RUUR4bDRwOEZoTHdwSVRzLzE1V3pB?=
 =?utf-7?B?NnhnaVVSN2hEckFjSXoyZUhibkUySjVwRlp3RVFXQWJLL1BwZlNGNmxsbGQy?=
 =?utf-7?B?NXJUczh2a2tlT3p5Mjh4QW8xRkVPak5tM0s3RXIrLWk0Z1pBSXM0elE3bXRQ?=
 =?utf-7?B?SWF2a09KNHF3VVYvdEE3WW1GRnYxRlNOaVFjZHJaVkttWFhsbXB4TjgzNWRh?=
 =?utf-7?B?azBrMXJwZlZnRDVYRkNPUk9JR1p2b0t3WUxvRGdOLzVzLzlGOVdiS21UOEox?=
 =?utf-7?B?eVRET1hQZXY3aUp6VTlXZlpQendSemJwZjNhMmVjQ3h3UDVHcGxpYy96NVZz?=
 =?utf-7?B?ZE5BTjBxUG41Wk1OZ05KekQxRk5uRVpFUUtzWWxybFBRSDB5T3RCaWRGdVl6?=
 =?utf-7?B?WUtRZk9HeS9jaUZWOUZ2TVI3cEtRNFBUTXlTQmtYZGlLMlVEaGtzQ05FckNJ?=
 =?utf-7?B?WWJ1aHdJSUMzSVRrVldoL3YvQURZMUtXUXdWT0lvRjFvWG55L0x3VjNHbldV?=
 =?utf-7?B?OFRxdER3MDl3NG5HN0VqS3dsaW1rNmpYcmtzc0NOdXQ2M1JiVUZBbzdBVUZp?=
 =?utf-7?B?OTNqd3RTaHEyVDA5SXhSUE9KY3JRKy16NkY2cmpXcld3ZzV6TFZKcHJaSVZL?=
 =?utf-7?B?Q1UwVlk3Rmllbk5Kb2xWd2pIeHZpZzFoRUtucHZZRHFFS3VyUXp6bjRSTXdV?=
 =?utf-7?B?YnBLTG9zM25DRlpjNnBuTGxZMWhyREFpeEs5bkRrdzFZU3NrU3BTNFFKODlp?=
 =?utf-7?B?ckNiQmwrLVBCR3FrU2xVL0dKRW9xeVFJOU1KTTliTkpHdkc4VTE0VHN6Z3pR?=
 =?utf-7?B?eVhuNjhram5vSFd6UXdQRUgzV0xxc1I3S2xib0szalZTY3JmVnZ4RzZGbWk2?=
 =?utf-7?B?L2tPbjhvZVY0V2hZUUN6WklQQVR2V0FDZWtYTHQvOFB5ajhtYU5hSHhTcHZq?=
 =?utf-7?B?WE1OckYxZCstWjg2VnZ0SjM3R2pOKy14Qk9wQWdhUXhkTFdRbUY4U1pqS0Rs?=
 =?utf-7?B?Z05UbG8rLW41WDRrZ1I0bFg5VzdPc0dqZ0ZpWWl4ckg4WFZNUHRITXNGTTlm?=
 =?utf-7?B?Nmw3bkR6UVY1NkJwaWU3NGxYU29GZGcxZmxBWlZYelFkb2dJcnNyMmVvenhY?=
 =?utf-7?B?Qnpka3hQTVNiTTV5TWRYNWVuVmJGb2I2d2o1eHRHRmpjYWdUTWJxNzY4VmRL?=
 =?utf-7?B?aHljQmVtWmVscEo1ZnpzUHN1eTNBTURJdk5aanZaVVNJS24rLXU1MUlsMnc0?=
 =?utf-7?B?RG1Ibjk4SjdQbDVGbm9mcjUrLU5NN1ZobjJ5SzJJckt6azQ4Z05PY0VTd2t1?=
 =?utf-7?B?UW1TRUptTkExYUFTbEZRbjE2aTA0bnFDQWxZMkpnSi9QcnhMWXRtdU5kN2Fx?=
 =?utf-7?B?b1pSeEl2MDc0c2ZOd3RVeFBISGVodEZ0d2tib2ttRFlVYXlLVUVhcUxKcXNm?=
 =?utf-7?B?cnF1bU45ZmREKy13bm1qQ3UzN0MwRVY0WFpCSzBtVFJjU0tiRy9IUE5TR2FU?=
 =?utf-7?B?d2lDa2RKcjh5bDBwVGREWVNkMUJxUGJNd0NFMUs2Q2F5T2F0dkwxNmhNcW1E?=
 =?utf-7?B?QXV1UHZORFA1S1hEVk9NQ1UycnpwQzJSRDNVMWJWSVJIOW9LRk1xOGNxT1RD?=
 =?utf-7?B?eEd4TUd6UjR3MThuaGE1WXM3eG16RkpLQXF5b0xBakMwNE1EYnJKTzJEOFZ1?=
 =?utf-7?B?Nll2QVNiSGs1dHE4RkhvbnpiVEpLZDdSQU51UTFnZzgvR2Z0QVFmOUZxOGJw?=
 =?utf-7?B?Q25nMGIzdzJMN0J5ZWU5TGN1OU9sanBQTDRuS25jNjRzZVdqSDBnZTVMUmJO?=
 =?utf-7?B?dFpzOTY0eTU3Tk8rLUk1SHlORjd3ZkpDWEJuMWovU1U4S3hVYjE=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7955.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2536b92d-bd78-40de-297c-08dc0c318682
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 07:56:42.9273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wXj1hCEWf9kQR+InAa1+FXzkuhPVAxgdMqOkoxZsxY8gRHmA1kF0NL3maOT1nQ1PmnUFf1A4JKb07lgx/48Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR08MB8247


Micron Confidential



Micron Confidential
+AD4- -----Original Message-----
+AD4- From: Huang, Ying +ADw-ying.huang+AEA-intel.com+AD4-
+AD4- Sent: Wednesday, January 3, 2024 11:38 AM
+AD4- To: Srinivasulu Thanneeru +ADw-sthanneeru+AEA-micron.com+AD4-
+AD4- Cc: gregory.price +ADw-gregory.price+AEA-memverge.com+AD4AOw- Sriniva=
sulu Opensrc
+AD4- +ADw-sthanneeru.opensrc+AEA-micron.com+AD4AOw- linux-cxl+AEA-vger.ker=
nel.org+ADs- linux-
+AD4- mm+AEA-kvack.org+ADs- aneesh.kumar+AEA-linux.ibm.com+ADs- dan.j.willi=
ams+AEA-intel.com+ADs-
+AD4- mhocko+AEA-suse.com+ADs- tj+AEA-kernel.org+ADs- john+AEA-jagalactic.c=
om+ADs- Eishan Mirakhur
+AD4- +ADw-emirakhur+AEA-micron.com+AD4AOw- Vinicius Tavares Petrucci
+AD4- +ADw-vtavarespetr+AEA-micron.com+AD4AOw- Ravis OpenSrc +ADw-Ravis.Ope=
nSrc+AEA-micron.com+AD4AOw-
+AD4- Jonathan.Cameron+AEA-huawei.com+ADs- linux-kernel+AEA-vger.kernel.org=
+ADs- Johannes
+AD4- Weiner +ADw-hannes+AEA-cmpxchg.org+AD4AOw- Wei Xu +ADw-weixugc+AEA-go=
ogle.com+AD4-
+AD4- Subject: Re: +AFs-EXT+AF0- Re: +AFs-RFC PATCH v2 0/2+AF0- Node migrat=
ion between memory
+AD4- tiers
+AD4-
+AD4- CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unles=
s
+AD4- you recognize the sender and were expecting this message.
+AD4-
+AD4-
+AD4- Srinivasulu Thanneeru +ADw-sthanneeru+AEA-micron.com+AD4- writes:
+AD4-
+AD4- +AD4- Micron Confidential
+AD4- +AD4-
+AD4- +AD4- Hi Huang, Ying,
+AD4- +AD4-
+AD4- +AD4- My apologies for wrong mail reply format, my mail client settin=
gs got
+AD4- changed on my PC.
+AD4- +AD4- Please find comments bellow inline.
+AD4- +AD4-
+AD4- +AD4- Regards,
+AD4- +AD4- Srini
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Micron Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: Huang, Ying +ADw-ying.huang+AEA-intel.com+AD4-
+AD4- +AD4APg- Sent: Monday, December 18, 2023 11:26 AM
+AD4- +AD4APg- To: gregory.price +ADw-gregory.price+AEA-memverge.com+AD4-
+AD4- +AD4APg- Cc: Srinivasulu Opensrc +ADw-sthanneeru.opensrc+AEA-micron.c=
om+AD4AOw- linux-
+AD4- +AD4APg- cxl+AEA-vger.kernel.org+ADs- linux-mm+AEA-kvack.org+ADs- Sri=
nivasulu Thanneeru
+AD4- +AD4APg- +ADw-sthanneeru+AEA-micron.com+AD4AOw- aneesh.kumar+AEA-linu=
x.ibm.com+ADs-
+AD4- +AD4APg- dan.j.williams+AEA-intel.com+ADs- mhocko+AEA-suse.com+ADs- t=
j+AEA-kernel.org+ADs-
+AD4- +AD4APg- john+AEA-jagalactic.com+ADs- Eishan Mirakhur +ADw-emirakhur+=
AEA-micron.com+AD4AOw- Vinicius
+AD4- +AD4APg- Tavares Petrucci +ADw-vtavarespetr+AEA-micron.com+AD4AOw- Ra=
vis OpenSrc
+AD4- +AD4APg- +ADw-Ravis.OpenSrc+AEA-micron.com+AD4AOw- Jonathan.Cameron+A=
EA-huawei.com+ADs- linux-
+AD4- +AD4APg- kernel+AEA-vger.kernel.org+ADs- Johannes Weiner +ADw-hannes+=
AEA-cmpxchg.org+AD4AOw- Wei Xu
+AD4- +AD4APg- +ADw-weixugc+AEA-google.com+AD4-
+AD4- +AD4APg- Subject: +AFs-EXT+AF0- Re: +AFs-RFC PATCH v2 0/2+AF0- Node m=
igration between memory
+AD4- tiers
+AD4- +AD4APg-
+AD4- +AD4APg- CAUTION: EXTERNAL EMAIL. Do not click links or open attachme=
nts unless
+AD4- +AD4APg- you recognize the sender and were expecting this message.
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- Gregory Price +ADw-gregory.price+AEA-memverge.com+AD4- write=
s:
+AD4- +AD4APg-
+AD4- +AD4APg- +AD4- On Fri, Dec 15, 2023 at 01:02:59PM +-0800, Huang, Ying=
 wrote:
+AD4- +AD4APg- +AD4APg- +ADw-sthanneeru.opensrc+AEA-micron.com+AD4- writes:
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg- +AD4- +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0-
+AD4- +AD4APg- +AD4APg- +AD4- Version Notes:
+AD4- +AD4APg- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4APg- +AD4- V2 : Changed interface to memtier+AF8-overrid=
e from adistance+AF8-offset.
+AD4- +AD4APg- +AD4APg- +AD4- memtier+AF8-override was recommended by
+AD4- +AD4APg- +AD4APg- +AD4- 1. John Groves +ADw-john+AEA-jagalactic.com+A=
D4-
+AD4- +AD4APg- +AD4APg- +AD4- 2. Ravi Shankar +ADw-ravis.opensrc+AEA-micron=
.com+AD4-
+AD4- +AD4APg- +AD4APg- +AD4- 3. Brice Goglin +ADw-Brice.Goglin+AEA-inria.f=
r+AD4-
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg- It appears that you ignored my comments for V1 as f=
ollows ...
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg-
+AD4- https://lore.k/
+AD4- +ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthanneeru+ACU-40micron.com+AC=
U-7C3e5d38eb47be463c2
+AD4- 95c08dc0c229d22+ACU-7Cf38a5ecd28134862b11bac1d563c806f+ACU-7C0+ACU-7C=
0+ACU-7C63
+AD4- 8398590664228240+ACU-7CUnknown+ACU-7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
+AD4- AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-3D+ACU-7C3000+ACU-7=
C+ACU-7C+ACU-7C
+AD4- +ACY-sdata+AD0-7fPxb1YYR2tZ0v2FB1vlXnMJFcI+ACU-2Fr9HT2+ACU-2BUD1MNUd+=
ACU-2FI+ACU-3D+ACY-re
+AD4- served+AD0-0
+AD4- +AD4APg- ernel.org+ACU-2Flkml+ACU-2F87o7f62vur.fsf+ACU-40yhuang6-
+AD4- +AD4APg-
+AD4- desk2.ccr.corp.intel.com+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthann=
eeru+ACU-40micron.com
+AD4- +AD4APg-
+AD4- +ACU-7C5e614e5f028342b6b59c08dbff8e3e37+ACU-7Cf38a5ecd28134862b11bac1=
d56
+AD4- +AD4APg-
+AD4- 3c806f+ACU-7C0+ACU-7C0+ACU-7C638384758666895965+ACU-7CUnknown+ACU-7CT=
WFpbGZsb3d
+AD4- +AD4APg-
+AD4- 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-=
3
+AD4- +AD4APg-
+AD4- D+ACU-7C3000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-OpMkYCar+ACU-2Fv8uHb7=
AvXbmaNltnXeTvcNUTi
+AD4- +AD4APg- bLhwV12Fg+ACU-3D+ACY-reserved+AD0-0
+AD4- +AD4-
+AD4- +AD4- Thank you, Huang, Ying for pointing to this.
+AD4- +AD4-
+AD4- https://lpc.ev/
+AD4- ents+ACU-2Fevent+ACU-2F16+ACU-2Fcontributions+ACU-2F1209+ACU-2Fattach=
ments+ACU-2F1042+ACU-2F1
+AD4- 995+ACU-2FLive+ACU-2520In+ACU-2520a+ACU-2520World+ACU-2520With+ACU-25=
20Multiple+ACU-2520Me
+AD4- mory+ACU-2520Types.pdf+ACY-data+AD0-05+ACU-7C02+ACU-7Csthanneeru+ACU-=
40micron.com+ACU-7C3e
+AD4- 5d38eb47be463c295c08dc0c229d22+ACU-7Cf38a5ecd28134862b11bac1d563c806
+AD4- f+ACU-7C0+ACU-7C0+ACU-7C638398590664228240+ACU-7CUnknown+ACU-7CTWFpbG=
Zsb3d8eyJW
+AD4- IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-3D+AC=
U-7C3
+AD4- 000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-1fGraxff7+ACU-2F1hNaE0an0xEudS=
KSUvaF3HgClMkmdC7
+AD4- n8+ACU-3D+ACY-reserved+AD0-0
+AD4- +AD4-
+AD4- +AD4- In the presentation above, the adistance+AF8-offsets are per me=
mtype.
+AD4- +AD4- We believe that adistance+AF8-offset per node is more suitable =
and flexible.
+AD4- +AD4- since we can change it per node. If we keep adistance+AF8-offse=
t per memtype,
+AD4- +AD4- then we cannot change it for a specific node of a given memtype=
.
+AD4- +AD4-
+AD4- +AD4APg- +AD4APg-
+AD4- +AD4APg-
+AD4- https://lore.k/
+AD4- +ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthanneeru+ACU-40micron.com+AC=
U-7C3e5d38eb47be463c2
+AD4- 95c08dc0c229d22+ACU-7Cf38a5ecd28134862b11bac1d563c806f+ACU-7C0+ACU-7C=
0+ACU-7C63
+AD4- 8398590664228240+ACU-7CUnknown+ACU-7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
+AD4- AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-3D+ACU-7C3000+ACU-7=
C+ACU-7C+ACU-7C
+AD4- +ACY-sdata+AD0-7fPxb1YYR2tZ0v2FB1vlXnMJFcI+ACU-2Fr9HT2+ACU-2BUD1MNUd+=
ACU-2FI+ACU-3D+ACY-re
+AD4- served+AD0-0
+AD4- +AD4APg- ernel.org+ACU-2Flkml+ACU-2F87jzpt2ft5.fsf+ACU-40yhuang6-
+AD4- +AD4APg-
+AD4- desk2.ccr.corp.intel.com+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthann=
eeru+ACU-40micron.com
+AD4- +AD4APg-
+AD4- +ACU-7C5e614e5f028342b6b59c08dbff8e3e37+ACU-7Cf38a5ecd28134862b11bac1=
d56
+AD4- +AD4APg-
+AD4- 3c806f+ACU-7C0+ACU-7C0+ACU-7C638384758666895965+ACU-7CUnknown+ACU-7CT=
WFpbGZsb3d
+AD4- +AD4APg-
+AD4- 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-=
3
+AD4- +AD4APg-
+AD4- D+ACU-7C3000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-O0+ACU-2B6T+ACU-2FgU0=
TicCEYBac+ACU-2FAyjOLwAeouh
+AD4- +AD4APg- D+ACU-2BcMI+ACU-2BflOsI1M+ACU-3D+ACY-reserved+AD0-0
+AD4- +AD4-
+AD4- +AD4- Yes, memory+AF8-type would be grouping the related memories tog=
ether as
+AD4- single tier.
+AD4- +AD4- We should also have a flexibility to move nodes between tiers, =
to address
+AD4- the issues.
+AD4- +AD4- described in use cases above.
+AD4-
+AD4- We don't pursue absolute flexibility.  We add necessary flexibility
+AD4- only.  Why do you need this kind of flexibility?  Can you provide som=
e
+AD4- use cases where memory+AF8-type based +ACI-adistance+AF8-offset+ACI- =
doesn't work?

- /sys/devices/virtual/memory+AF8-type/memory+AF8-type/ adistance+AF8-offse=
t
memory+AF8-type based +ACI-adistance+AF8-offset will provide a way to move =
all nodes of same memory+AF8-type (e.g. all cxl nodes)
to different tier.

Whereas /sys/devices/system/node/node2/memtier+AF8-override provide a way m=
igrate a node from one tier to another.
Considering a case where we would like to move two cxl nodes into two diffe=
rent tiers in future.
So, I thought it would be good to have flexibility at node level instead of=
 at memory+AF8-type.

+AD4-
+AD4- --
+AD4- Best Regards,
+AD4- Huang, Ying

