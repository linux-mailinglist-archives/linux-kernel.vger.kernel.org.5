Return-Path: <linux-kernel+bounces-64176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16C853B36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD031C22C63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17B60884;
	Tue, 13 Feb 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="jVu0v+Wp"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8660873
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852968; cv=fail; b=bfjMrtq3QIKFKzLXM72bmnyiJfDhBda3ElRVZ59+fbNnxEbAZ8CAnr2uBgP3XHxaclvuRC+YXjmRkOj+Amdc+VLiAkpb8i4knJEUxUBJlD+lJEzu6zT5o8IlDrQRzMJ0xkunE/pNQN2H+vG3LXGtSdhIMVaegUa0D8fw5LKTB2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852968; c=relaxed/simple;
	bh=N6XoT7YkReUAmB8+8ytZRqTkxb3jIjTL8EhRCypXVws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGFFUa9doFSavGM7CiA4RgYEgYFQvHu//s9tXBZDRm+1CaNx8naE8iZELTEv1A0hh2Q++T9k9UI83LEasjjG8Ah861Gvl+JEv6kWNyizkWqFSvDGtW4/JFUa8WaaHCr1leYCaruLNGVm0HBsfaWL4mnRn6Q89pH47ziReigsB4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=jVu0v+Wp; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DDdsWQ016758;
	Tue, 13 Feb 2024 19:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=N6XoT7YkReUAmB8+8ytZRqTkxb3jIjTL8EhRCypXVws=; b=j
	Vu0v+WpP2YtnVhqpSATkOMpc8VVW0yJnCsSr5MkrXF09Gdt6h1x3l6SWavYKrEP1
	c7+HA1y9zLg8bsw4iVGXtSvKFS3UajBAjxaSL+r9MYZadzLH37AoChU9c2t+k4ct
	8sqd1ioFHWtxf1gT/h4BFH0AN0MoDW4n0mviPqE4bGY5E3HF5G9OyU+l9/gk47Lg
	+/1vI8MVwEzsxQJZUELTNSpxI0TtNTD9GNuIRhfRfA05JzNwa6a74Goo/9iPTQiq
	SFUK5BQiK3Mj11InVKn70XVBXha16aWr9O01F6E69KOucUnjjOfzFMNM5S+OeCQ6
	7BrninifTzC9cTfrVnnVQ==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3w7xe59g43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 19:35:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkojfkyUfVidOiIuqXL0j1Awt9HsXEf5WX7uuK0qS4qgCDb+iNv1hZKOOvMDOVe2KDas2cwrm783G1iPYcb0h63sOHVAtqJ2KnkngjRhfKQXeAso4W3+OVi/ztxwY4IeYfc8WlGWJU+5C+tv6C8UcihL1wqTzTmv6qklK76IVtuDtc8M7bv+7m679dpu1FKJBBvqowH63P4b+TuR97s10cU+OODO2x/K8eF0kN/zXSvCjBP66l8qZUk1X1xEVrvIb9Y7cKNOo1YoSd1vp6eaSnww6DP8O2lKHKx5+iWjDmHAqkHMCCyAhRPZdKu1gx2knFohfKQg9AeJldkvgjJ7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6XoT7YkReUAmB8+8ytZRqTkxb3jIjTL8EhRCypXVws=;
 b=fMUmdFnOeReEPD7iVOY4lQ//qzwB4C9EYxcXNKc3JewU/F0lkSYvf018+jNa2RvRVPRVVWaZSw9hmZh9ihzcwoe7Y6PAZkgw7aRN+abRldFw3v2/IptErqFSwVq5MbCrW0ypn/lXqWvbmlRZZk1LrLFm+R/OjBtWfNuefKBlRbJkGBtgy+NnCaojzZqc4AbaQrTBL91dx6BBCDeqpeUgYUWKtRePvoK0/ymCn3CgClkff2cX46qgl19qs9sdXzFpGcGhLt8UpMLZ3VgoGx0bhYNOOIyRhnp4qD+VTuQnahw3uQV+5fMa4egFPTajLpOkpoZSNn2qzAWnpMdighAnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by SEZPR03MB8013.apcprd03.prod.outlook.com (2603:1096:101:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 19:35:27 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 19:35:27 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org"
	<will@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org"
	<tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shikemeng@huaweicloud.com"
	<shikemeng@huaweicloud.com>,
        "david@redhat.com" <david@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "anshuman.khandual@arm.com"
	<anshuman.khandual@arm.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gshan@redhat.com"
	<gshan@redhat.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Andrew Wheeler <awheeler@motorola.com>
Subject: RE: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Topic: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Index: AQHaXrD0JRNfqROm3Uev/Znaoa6ke7EIqNyA
Date: Tue, 13 Feb 2024 19:35:27 +0000
Message-ID: 
 <SEZPR03MB67864221134F49E9BE3B1FB9B44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
 <ZcurbvkUR-BoGTxu@FVFF77S0Q05N.cambridge.arm.com>
 <SEZPR03MB67865557061A2494B1A1243CB44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: 
 <SEZPR03MB67865557061A2494B1A1243CB44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|SEZPR03MB8013:EE_
x-ms-office365-filtering-correlation-id: 2509c787-2db6-4a03-5d5b-08dc2ccaee73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Key8mOwzm0+qCo/Zq53pYR93c07H5wzTlylWCnpfml3W6LSfJns3JqF2umxlELAMh/a4fjzg+I+qePovO9kChBidxTVb3ICAWoIbCFQZj4S3sXJAniYWDx9eJFD6OXE5UwiuvWB3vQzwZieh7Zbll5ZG664RkWJz17bdSjMhtynugbXj6fsc5b7z6xIez7X+U8uDVszLgt337SXIvKIFuOyF+dtKZIhyPSQpFdvlZqSAu/10GZ9WwQkTAHOC70xHpT6NfXrI2iG3FowFBr5bsi416bz4r9XT6/MYwE0S9snsD15+XOBxFWH4AymAHixJZ/nuH2t3PTD4cIIzhE24O4874OHdfhhudUHJaSTaCworNMv56bn6RKJfICSWzGOaLyswrBWhOGArrXFiFotqT3xXacpZLeaCnzOH1VsMYEy+VVqdShzu+/6hbhW5sWpsFxBuDYDpWCQAUtHKyGsA8iJaJV/FYlWerObSkgpRaBeHBFnuquLO7Rwi9AaVcGpBmhz7MRu4SAsV7pom/wCAiXFut8gxTUCJGbCIu8dosqSOOl96yGO9PnT58bxbJMvSaL5uPwzwVRCErtgUX/LOjGa8kGENFjhi6isWGx4w2mPMC1ArikYj4uaJz5Qd9bkm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33656002)(82960400001)(86362001)(122000001)(38100700002)(478600001)(9686003)(6506007)(7696005)(54906003)(41300700001)(71200400001)(26005)(38070700009)(83380400001)(2940100002)(316002)(107886003)(66446008)(6916009)(52536014)(5660300002)(55016003)(64756008)(4744005)(7416002)(4326008)(2906002)(8676002)(66476007)(66556008)(8936002)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RjA0MlQ3Z3BFOEdjc1loOVhwak1YOUNxbG1oM2UxRWRwVlFDb2l0ZWRCZjlR?=
 =?utf-8?B?bEgvYk51SUZXRHJ4UUNkN3hXYVRMQ0IwaStuY281K1Z2aUcvdzB3dkUvQlhu?=
 =?utf-8?B?MVNOZncvdmhvL21ZOURNY1lTYjh6Yk52RjF3UmRrQlBuYkhBQ2JaSkJhTlpr?=
 =?utf-8?B?R0lhdUozSnA5M2RUMVJuTHNSUGtLczlpaVF2RDNKSUV3LzA2dHN2NzhNTHlq?=
 =?utf-8?B?TWxKT1VmbjlPdnFyN3NuT0ZCbFBwZ2NPT0FkbTlrTm80UERkRkFJV2VCMk0y?=
 =?utf-8?B?TFk3TDNwT1RzaFE0S1lDSU1Hd1VWOWpkN1FvVEN6c0Y3L1RsSy9FaCs3Sklt?=
 =?utf-8?B?NUpQTlJrR0FGeHB2TWNmd1lQN2IwcHZSUUJlY0ZtVUlkL01zS3dFLzVxN01D?=
 =?utf-8?B?NURYeEFEb2R6Z091WmFCY0RBTjVZdWYzbVV4WkFocDcyZnQraHRPKzRzUFZY?=
 =?utf-8?B?clFhalN6OStRdEYvK1h3Ymp0aXFmTnN1N003SVZYL0xSWWNGUXM0ZTkxbjZS?=
 =?utf-8?B?ZmNzTWw2SFJqaVc1R2Z0cHg5Kys5Yys4VzNTN0tvVGphelVlMTlKNms0Zkxh?=
 =?utf-8?B?b255SWZ1TE0weEpnOS9CaTVlWk9tVjF4YTJaZnRDTSsyYlZ3dGx2c25JbnhS?=
 =?utf-8?B?cm5rbVZWOUFLenNoRVhFandBZEM3bTExbG5MQmtCc2pONDQyaUZsMVBxNERm?=
 =?utf-8?B?eGdrME83R2o5Rm5FMXZYMVRSdlEzbmdsdUNESC9ldzYwRTlTUWtIY1A0V2x5?=
 =?utf-8?B?SGo3QjZBcFJPQ0FKQUc2M0E0VFJvWWVyRC9lVkx6MWtlY04zUUNKL1VyZTZM?=
 =?utf-8?B?enVxdDF4bzErSWdQQTZrRXB3NXQ4R2l0TnEyTFF2RkNDc2V6cnd3M1k2ekZN?=
 =?utf-8?B?ZkFaMkk2M004c2hQWWFGd21Wa1prL3UzZGl2RUZlcG5EOEl6Qmh0ZW9jSU9D?=
 =?utf-8?B?SHpoOTA0dUFUVVIrY2JCVnBmeXNWY3ZDalFiNnRCTVFCY1o5aXJQZ2lyRHhi?=
 =?utf-8?B?OEdianRVTFVSVDd1bE52NFVOWlpoa29PaCs4YUU5YXRqWkkzcFZrYmdYZ3oy?=
 =?utf-8?B?eTJyUngwck9vWU96clkvZEl6cDY0bU5WTjUwLzlaaGdkMHNneTRQUkxMNWhv?=
 =?utf-8?B?d0h1enZLOWVCSlZQbWUvanE0VzN2T1B3ZnpXTk5XR0ZRV2lVQ1RSeGVxT3Az?=
 =?utf-8?B?cXU3QmhMbk1PTHVKaTdwK1NyZFlONVlBNHpDblF6bUVtempzT0doNW5aRDFV?=
 =?utf-8?B?UHdSQXhZK1MzUnJnRFo5dUtTRHRlVlFFT1hBNktzQlNTMW9JU0pQOFBqMXdl?=
 =?utf-8?B?ZkREU1RSdjZKTitiY2lDQStaRnVQb3FRNzExWUVIN2ZHMS9paDNIWUhtNExz?=
 =?utf-8?B?WTByanhMTlZaNWJhTnZOamhwWDZJNWFYZ1pJK3ByTGpnejJlVEZwQjlBQXBY?=
 =?utf-8?B?REJIMVJ0RjMzN0YrM2lGYzkremZDR0kzS2tsb2ZHSXhtbUFSSnRCOW9KMWpn?=
 =?utf-8?B?NE9JQUozRnV6a2ZiTmIvTWR5VjhRamY0NmtpWTFZN3dVZnR0QkFxbHJpTEk3?=
 =?utf-8?B?Y0puMVdobXJ3bmRpSlhONjRlUFBWTzcwS2N2blgraU1xYWxTYUhpd29qdEk2?=
 =?utf-8?B?VDkweUs1cVFQZVp3aTJXY2JYemo1cFpmMjBuZFdzM1dHdXIyb1FqM2RnN1FW?=
 =?utf-8?B?MXZESE9nNjZXazFxNGpGeE52elJtYnJhb3Ftei93MlJiTlFTMnBuTExsb1Jm?=
 =?utf-8?B?VDE4eHhOOXg4WnU3elZWdmx3UDMxdzdFV01yZXhKYVBXKzVBSkJYUzNCTUpK?=
 =?utf-8?B?T2NpbUZteWo5cERjL2tWSnBkdmFSS1Fna1Zab1FzemxUQWlCaXMwYURiWmZ0?=
 =?utf-8?B?WnY4MitZYmlWcU5ZWURha3hvQktLNmxXTEhSN05qYVJrWnkzUkIzazFab0Ur?=
 =?utf-8?B?MWd2aUpGRUpXUHJjSFd6eTY4NDJHTnV3ZC84WlhYYlprZDlLWC9ScEhJeURI?=
 =?utf-8?B?UFBZbGNLZXM4RmtPT2E5SzlXQXo1N0lSSk1CZk9UTkswRmdNd1FYby9uemVz?=
 =?utf-8?B?cVFMRnRSWTdST1FSdlBMNGJMMkNqNkhWaVZjckJaMWJpSkRidzczNWlOcERF?=
 =?utf-8?Q?cwGE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2509c787-2db6-4a03-5d5b-08dc2ccaee73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 19:35:27.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdOesOfsQIga65bKJL7IPoabF4V81rx3RlRUIWHyryB6q0w6OPVF3kT9bViQS4ZVqW9RLYhx2H9L0rY7VX9LUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8013
X-Proofpoint-ORIG-GUID: yV85aHNaHteC0TYFTiMOV8lwHaJXtHjD
X-Proofpoint-GUID: yV85aHNaHteC0TYFTiMOV8lwHaJXtHjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=537 bulkscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130155

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXh3ZWxsIEJsYW5kIE9uIFR1
ZXNkYXksIEZlYnJ1YXJ5IDEzLCAyMDI0IDE6MTUgUE0NCj4gPiBGcm9tOiBNYXJrIFJ1dGxhbmQg
PG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiA+IEhvdyBkb2VzIHRoaXMgd29yayB3aXRoIG90aGVy
IGFsbG9jYXRpb25zIG9mIGV4ZWN1dGFibGUgbWVtb3J5PyBlLmcuICBtb2R1bGVzLA0KPiA+IEJQ
Rj8NCj4gDQo+IEl0IHNob3VsZCB3b3JrLg0KPiAtIGtlcm5lbC9icGYvY29yZS5jIHVzZXMgYnBm
X2ppdF9hbGxvY19leGVjIHRvIGNyZWF0ZSBleGVjdXRhYmxlIGNvZGUgcmVnaW9ucywNCj4gICB3
aGljaCBpcyBhIHdyYXBwZXIgZm9yIG1vZHVsZV9hbGxvYy4gSW4gdGhlIGludGVycHJldGVkIEJQ
RiBjYXNlLCB3ZSBkbyBub3QNCj4gICBuZWVkIHRvIHdvcnJ5IHNpbmNlIHRoZSBwYWdlcyBzdG9y
aW5nIGludGVycHJldGVkIGNvZGUgYXJlIE5YIGFuZCBjYW4gYmUNCj4gICBtYXJrZWQgUFhOVGFi
bGUgcmVnYXJkbGVzcy4NCg0KQ29ycmVjdGlvbjogSSB3YXMgd3JvbmcgaGVyZS4gVGhlIF93ZWFr
IHJlZmVyZW5jZSB0byBicGZfaml0X2FsbG9jX2V4ZWMgaXMgb3ZlcndyaXR0ZW4gaW4NCmFyY2gv
YXJtNjQvbmV0L2JwZl9qaXRfY29tcC5jICB0byB1c2UgYSB2bWFsbG9jIGNhbGwuIFRoaXMgd291
bGQgbmVlZCB0byBiZSBzZXQgYmFjayB0bw0KdGhlIGdlbmVyaWMgQlBGJ3MgdXNlIG9mICJtb2R1
bGVfYWxsb2MiLiBJIHdpbGwgbG9vayBpbnRvIGFuZCBjb3JyZWN0IHRoaXMuDQoNCg==

