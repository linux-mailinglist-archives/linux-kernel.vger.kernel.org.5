Return-Path: <linux-kernel+bounces-28983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C518305F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56ADB24777
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C051EA8A;
	Wed, 17 Jan 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aU3oVagI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PMUNNMry"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0A1EA6E;
	Wed, 17 Jan 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495799; cv=fail; b=BIVXQSWEXm4zIJisFLgcMxH2zsdww2Ys48h45Pj/BUKUysQfSF+dwJMgNqmlSmOEfL6XrSL6qVmqSrWqVH7xxkKmVHMuZujdu54Wg6RtD6zGuQWJLPGnNoOfdZjYCSNUd0QUnowoDpFXQ/Q8SSRSfs0OmeCPALitDSp4i/QP41c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495799; c=relaxed/simple;
	bh=jq2G0F463qvOe9i7lXwy8UJPiHpJ7pqyDIcA7NZt0V8=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=hTSYAVo769WfzXkdv6csocZneLj5EswTaSRODh2PP0hWZkbRwbF1gZ3b0UMfv/YsuAIl5355wGpzYcfY3G764Bg7VHWYoJr6xiH/s3m3SKsG8lkdTSSGqBVm+5IlgxBfXyKHzt0XpNrwlG8hREUXVfN+UQlT7qrf0BBE2MYV7KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aU3oVagI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PMUNNMry; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705495797; x=1737031797;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jq2G0F463qvOe9i7lXwy8UJPiHpJ7pqyDIcA7NZt0V8=;
  b=aU3oVagIciqaBu6aEIDmv7ETr4xbGEOAnCtf1vq7dNpE8W5BYCeLyqLl
   D+lRV1JZOYIHw/3lQZyHNbA3yb/FrbPycpwk6/z2eNZZu8v1P6jC+xOMM
   hbxEZG1GsBGbKYjc9LhCnPdCaTV0XVDM6yOMTAwTRBbdrLAmhxKJ2m+K6
   MFumoFXB/LINIILi/oCsd1dx4IMFWPCzwEJGXgQaWmPrlc6iRudm7q0Ad
   xvH5sqgIg1JHFA8eFsqL8lKzcoKkMeDhrRKcdrCjcgOsXFrl/+3ZCosXW
   Sr9tGWUwozEfKPAW+Vxt/Dl/ewzEkQToxEOr1q+e4C3k20yq3Zt9m2d+A
   Q==;
X-CSE-ConnectionGUID: KRYr+YveRq6YQ1XuPg3wTg==
X-CSE-MsgGUID: cBj3Dv0xRtSSvingL6MScA==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7161173"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 20:49:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOvkFEZMLxAukoHVvaZBh0nfoqRjGXGr4AzoWlvSnDiay1DLRjvqqzm3yrSR04XPnYy1WmyYwl/fHn4+i5BZYuIHTK/1G5MUT1LTOf+IaeeOwDkq4eNRnsld4KXmGflrzlruy7GdjZs/u9RdLDKI/Svvh9JcFCrLmr0maY3KXrfeyQ/dbooL+IWcYcjBXXRVbHBnC44z8cJZlUcuin8JqodGxeJ1gWoXQgW4kjapIT2K9uYEL5s62z6iVnlINvFBY4wS+m7KkWszzgY3ZlVx+O3pA7F4XlWNOOiMCIWWFPLXg05u6+5Ne7CkeylelcqEhnwrVXF7WVCAEYUGOJ1OZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq2G0F463qvOe9i7lXwy8UJPiHpJ7pqyDIcA7NZt0V8=;
 b=hFIdWZjtPrkoa2bhGYUwfMSa4xWbZLzlnO6z8dOe3ytajft/16ZLZ4+kgEtDLy0h0xRnAZfzulSRiS1CIbvf2QIwHka4Tc3z7E8Qty6ZRTu+FPv7vOcuHN5YLBHWoJqNMTTf3O+niYlUWSU581bj1mUI9kSsVuNhtX2M/t5n/eka6NPJU1rA2p/9qOcvpXCzpk6nMR9U6Y9CpIHXRq6beWTeHlMxH0AVN6IS8u6ojnJmRZ/Va5/WawbVHU1IEesoHNfduMi8VMDn+bBXldBK3Mjval9e/lFdVku2SA+dhAeynNDAJ0a6iGeJbRlnNoSCAvs5i4Dn15+/V3GYAuCn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq2G0F463qvOe9i7lXwy8UJPiHpJ7pqyDIcA7NZt0V8=;
 b=PMUNNMry+BBP/jN3Q5faFxHd2nWBi+bDB7DOXCfJK1Yv/9jErV768eN8w4bjXctGYnbuoKuQk7E8Qi946TjEYsZhjN7VSNj6t+fTrYVwVYQFiSk5lfKTYwqs0rd887SA+y8IkM/ijdK0nGYlhck4mjed+E/Zfi3jvQBiz5zgxPE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 12:49:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:49:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: block: ioprio: Update schedulers
Thread-Topic: [PATCH] Documentation: block: ioprio: Update schedulers
Thread-Index: AQHaST+NKrhpqBBDp0GmOHhbUucHV7Dd9NQA
Date: Wed, 17 Jan 2024 12:49:53 +0000
Message-ID: <8085ea13-29d2-46bd-8ca9-407d22266d0c@wdc.com>
References: <cde50a18-7c09-4d00-b3b8-32da2992c952@arm.com>
In-Reply-To: <cde50a18-7c09-4d00-b3b8-32da2992c952@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7302:EE_
x-ms-office365-filtering-correlation-id: 0d8018a2-92df-4382-1ddc-08dc175acd04
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VuYGPnmv6eMf1p4a7RviFyJ19TnwGwAWXy5KZarLvPAgqLIP9B8LYQq9pn6jJCEs4y8veA39D0NR2oYWchCZhZ5JYsnElRDxMza/oFC5wGqk6HXqm8Nc5sjse1tpaL3d7R8raXPCBBfscjs+Hlq1Xrx+7I5wmtuAMF1FTClwi9pGqYpdcWkFkRsXMqsc0u2BobGVTKTda5uCiGqbzfPbeoNht3knaTam/fa94bbcOoYTYlTR4WMUPCVIz4TmhpBBxn/bBKCZJnd8tRjcIpaniS8vB/dCtZ9QLxF6x7ta8PBfTcr4uUsge7UMp/Sq2Zz9nln4tYOJOpSfjt4xKxKxRFX70VhJrO2460f6eYwprFi+2oHcmiaAcDNQkrK0CSoQ0++RJaBpxiE9RzwF1Z+kahZN7p1vP9+eDNzlypkcgcO4X+sRFF9Zjws8i6Y9ThGlvAxgt1oL1JgB7nDjP/LjkhVrGh+el3a/UIpR6d75aBfqsT1t2RGuBxluuxkY2EOw8Btk4KuZgxOJfbYzQOYkRvCyUFrVCnOUvpQSJfIa8Q/gm+CaFiMEJjIWAjX2MT1FEb9S6LYTF8GO9vQN6NDrPDwv6R/cqJkiRm6m81/0lwZK6HkS0Oz3NUeoOihO9Qoy4A+2Xy+kSlSvpxk3s/xu2xE6nMCKC1JjDezX3RtqDoTUVoqlOf/Al6ltZgXChQ+L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(6512007)(2616005)(38100700002)(122000001)(5660300002)(71200400001)(8676002)(66446008)(41300700001)(2906002)(8936002)(478600001)(6486002)(316002)(110136005)(91956017)(66556008)(64756008)(66476007)(66946007)(76116006)(36756003)(31696002)(86362001)(6506007)(82960400001)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RW0xTUhpVGJrcHF0UUtFb0hTM1ZxUW9oRTBnek9DT3F1Tm9pOVNaS2ZhRTJW?=
 =?utf-8?B?WHV1MVMyci9VK3RVcHdkWXp5alVJTGRCYWhrRWxlcnBqeWovblFJVWJKRkxr?=
 =?utf-8?B?TDRoTnlKWS95L0dLSGVBRDRxa1N5aEhFVTQxemNzRFhYVFpiUmhVVE42MThV?=
 =?utf-8?B?bFl1c1ZOcTBjQUZBZjViUVEwdXV0VThYdDhLMytlS3lhUGJWcDMvL2ZobG5O?=
 =?utf-8?B?YWlkb1FRL1QvdTRkNVg2UWFmbmlXNVdrdTJDQThyZ2RJMzFCOC9XTEtKTTlX?=
 =?utf-8?B?OUZJQW1CY2MrOGFoTmREYWIyMVB6cDZ5clA0Q1pjMjVsNVlkOVdyOTYzaERU?=
 =?utf-8?B?eld0U3FsN3haOE14VE84ZmdJWHlkTkwrblExQjFldjUvR1Q0TVIwSldQNDVN?=
 =?utf-8?B?dmVIQzBCdXM3UEQ4U0hFYzFiSnFGWStJWFQzSk51NzRkM04vTk1qRG82QlB0?=
 =?utf-8?B?OFI1dmNYQXRTYUxpc1prM0FxdnU2U0E1eHp6VXljMFlyR05uaTIxSGVkWjBz?=
 =?utf-8?B?V1cvZkRVdEh2bkhpZkw0Qy9SaG54UHFVSjJJQmVjRGRkM2xZLzZ1OWY1aGhP?=
 =?utf-8?B?ajJoaHIvSU9GZWEvckxkcUJWK2JqeE4vWWV1UXZ2bmhaMzArd3BPK2h1Rlhz?=
 =?utf-8?B?c3NPZnhkUUN6Vis4dVBLcUx2Y3o4T3BtY3NCMS96UHVJbmFqYXF4elJIeEtI?=
 =?utf-8?B?ZllOUEJvN3FIdVRSaDcrOXQzZy9JNUpZRGpMd3ZJZ3pBQjNNdFZWcmFwbWdh?=
 =?utf-8?B?QTZqczVrdFUxWHY5VHZHREw2QzZRVEhucWwwanNEeVFDWWlySGlqNHhZOTht?=
 =?utf-8?B?T3Y2WFNZNG5kREwzVk5rWUxMOUFKVW1MckQ5Tm9CeEdtUlA2OXpTRWN0R1Rs?=
 =?utf-8?B?eXhuQkNMSCs1NXkrWWxmcUtCUXpEV0l5V3c0Uk5PcHU1SXBGQ0d2c1A3WExY?=
 =?utf-8?B?M3VkRFY3RW9TWWdRL3loUCtGSG12a25ybTFPRzQvMGdtSFYvdVh4YnFiOVM1?=
 =?utf-8?B?K0tDVFFWaDhYeUYvOHFzelJQZFZlS1ZYd0xrUUlqcDBEUWJ4M1Zzb01YYXpY?=
 =?utf-8?B?cDhCa2FXUmxIUmw5dkY1UU11SlVVL3E1ZWpHOWFNWUpPMFJLZHpKZnM3MkRB?=
 =?utf-8?B?M0tXNzQ4OFB4RUtULytRNThhSThNSERQUUYxRUFIZVpEanRVTkQ4MVZ6MjBZ?=
 =?utf-8?B?TWZac0lwRUdEZERMOWx2bmNCK3k3eGgwUVdOeksrSGpUOVVJZlFwWURsU2hW?=
 =?utf-8?B?SC9vZEgraHhoelM5em9Nb1ROYkEydy90Q1l3YmFtSTdEekpxZzNaemFqVjMv?=
 =?utf-8?B?dGJiNmt4L3RKMVZKRmdKNzh6VjBNT0V6cHl0U0FLT3hFUlZxa3dvQW16SWlF?=
 =?utf-8?B?S0NOdjRhWFRCU0pUM1ZqMWVzS1FtVW0wSGRSZ2FMckpMcXZ3ZG1Ib2lFcnV3?=
 =?utf-8?B?MzJ3SzluY2ZWbE8vT2Z0am5FckFuOWthS2JIdUVySEpvbWJOV1ZUVVpyM2lT?=
 =?utf-8?B?VXdMd3FVd2JVdTNNaHpkYjd5QWxtTGlublRINU1wY1VUTWVpTjVYQ3FjL2o3?=
 =?utf-8?B?Z2s2Y28wWkw2a05HQUszUkh1VXhLR3l4L1R2U0Mzc1kxNUpUTW1samFJUHFr?=
 =?utf-8?B?cUhrdUgyaUVsSnJqT3JwOXM2MjR0VnRiN1IzVkhpMXVZa1hTZjVhNWJ2VjVR?=
 =?utf-8?B?aG9lM1kyUDhnQTQ5YVNrMmlFQnhMWkRlSndmeFl0TUswT0pnMFBtamhaejRm?=
 =?utf-8?B?M3JFaW44T2NnbSt0RWE1YVRkSmtEN1N3WGdCeEV0amN6Rm5vVjMxT3BoNWpl?=
 =?utf-8?B?NEc5UTVkWWUwaytTYktaRXlONloxVzJtMXpiRjFsWHhJdWZGY01sMmhlTEdL?=
 =?utf-8?B?OXJUcHY2NjcrZEdrTWtZdXNaU3MrWG1VZVMzSEZLQk5UOTdpQUYzTFpBVWZk?=
 =?utf-8?B?L3hoZlFUSjdXd2R3L05LQkVXSWFYYzVZcTFJd2VDY1FqcDRjbHVJcGFrTk9K?=
 =?utf-8?B?Nk5VdXBRMHhpcm1yOFVxbEhyek9ndUFtOWw3NXJIMDkxOFhzV2huZFZtbW5t?=
 =?utf-8?B?MVkwS2ZrNkY5SlpTUVllM0Z3eUw3c0FHMmUxVnpGMlI4VXBmL1B6SFMwYXNI?=
 =?utf-8?B?dzZ0TWx2K2IyaWc2Szc0eC9mWHlpbFpYc2FBV0x0RzVXWXVLOEF0aFRUSXZY?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B20255363C7FA4691E77B0E54F3BBBC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IgiJCn1/x0i6wms72p4AqraDVfXzAVki/Q+3UTCMaae5bsEIMYHMNoD/Ft63kjvH5hOS3lSdxS7qy6gBUTwpIPvzFNI9uHHNaUWaO8hbgOA+IG3czS2DFA1Y7yfyJCEQHsJNfaIxuvTvdwyK8uD0H/mYMP/IAOvVH2w0QgGgfOcw/txl5aVtFD1t/dV/KiW1rvi/eiwOgr4KT3lNLFKBKqkajwIsUfyWMwv5cRcuahrzUNC5YTPmG4x4yKEDZR4D/V1DNRlr9NoAlPserPav1Rgj83W4mL+qzAntxHODh6RhSqw9czSxWFt0CMWceOqEVJP2xpGvlj8eFdEMdB1apkfNp+JgARRTFhhqEHcbiix5NUACbmJVehBP/DYXDxFAw7ndcSYfY9uykeEK9bTZkHErjSffcTxfbb3qnbcSCIZKWmrpZsQOmtm71v2L9+rZEzta8GZBucjrqkJWtrbdZQ516bnRXgXH7yUZ6YNGAVqrANu6DS1t4veAYkxwppqzsbBtOmTzATF8k+/9HNxGK/f2y86pEvONvBZW/I8KPQwP5sme2R1CConfegz/LA8Dpb/1r/BOlNDUCRRqR4hv878F6Fv314toahLfFAvcDFej0TiOWOMXF7K5ibrr4xNI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8018a2-92df-4382-1ddc-08dc175acd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 12:49:53.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kawvvS+UMzsovsd1b7ixA9m9LOFHYuXUTqeHweTYgZDVMGy9anqUkE149j82w+u7i6pxj5i3U+er6SfsVNlX5O4S1IdAwuZg4sMbyTJgZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302

T24gMTcuMDEuMjQgMTM6MjAsIENocmlzdGlhbiBMb2VobGUgd3JvdGU6DQo+IFRoaXMgZG9jIGhh
c24ndCBiZWVuIHRvdWNoZWQgaW4gYSB3aGlsZSwgaW4gdGhlIG1lYW50aW1lIHNvbWUNCj4gbmV3
IGlvIHNjaGVkdWxlcnMgd2VyZSBhZGRlZCAoZS5nLiBhbGwgb2YgbXEpLCBzb21lIHdpdGggaW9w
cmlvDQo+IHN1cHBvcnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxj
aHJpc3RpYW4ubG9laGxlQGFybS5jb20+DQo+IC0tLQ0KPiAgIERvY3VtZW50YXRpb24vYmxvY2sv
aW9wcmlvLnJzdCB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYmxv
Y2svaW9wcmlvLnJzdCBiL0RvY3VtZW50YXRpb24vYmxvY2svaW9wcmlvLnJzdA0KPiBpbmRleCBh
MjVjNmQ1ZGY4N2IuLjU0MTAzMDg4ODhkMiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9i
bG9jay9pb3ByaW8ucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vYmxvY2svaW9wcmlvLnJzdA0K
PiBAQCAtOSwxNCArOSwxNCBAQCBJbnRybw0KPiAgIFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBj
ZnEgdjMgKGFrYSBjZnEtdHMgb3IgdGltZSBzbGljZWQgY2ZxKSwgYmFzaWMgaW8NCj4gICBwcmlv
cml0aWVzIGFyZSBzdXBwb3J0ZWQgZm9yIHJlYWRzIG9uIGZpbGVzLiAgVGhpcyBlbmFibGVzIHVz
ZXJzIHRvIGlvIG5pY2UNCj4gICBwcm9jZXNzZXMgb3IgcHJvY2VzcyBncm91cHMsIHNpbWlsYXIg
dG8gd2hhdCBoYXMgYmVlbiBwb3NzaWJsZSB3aXRoIGNwdQ0KPiAtc2NoZWR1bGluZyBmb3IgYWdl
cy4gIFRoaXMgZG9jdW1lbnQgbWFpbmx5IGRldGFpbHMgdGhlIGN1cnJlbnQgcG9zc2liaWxpdGll
cw0KPiAtd2l0aCBjZnE7IG90aGVyIGlvIHNjaGVkdWxlcnMgZG8gbm90IHN1cHBvcnQgaW8gcHJp
b3JpdGllcyB0aHVzIGZhci4NCj4gK3NjaGVkdWxpbmcgZm9yIGFnZXMuIFN1cHBvcnQgZm9yIGlv
IHByaW9yaXRpZXMgaXMgaW8gc2NoZWR1bGVyIGRlcGVuZGVudCBhbmQNCj4gK2N1cnJlbnRseSBz
dXBwb3J0ZWQgYnkgYmZxLCBtcS1kZWFkbGluZSBhbmQgY2ZxLg0KDQpDRlEgd2VudCBhd2F5IHdp
dGggYmxrLW1xIGFuZCBnb3QgcmVwbGFjZWQgYnkgQkZRIElJUkMuDQoNCg0KPiAgIA0KPiAgIFNj
aGVkdWxpbmcgY2xhc3Nlcw0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIA0KPiAtQ0ZRIGlt
cGxlbWVudHMgdGhyZWUgZ2VuZXJpYyBzY2hlZHVsaW5nIGNsYXNzZXMgdGhhdCBkZXRlcm1pbmUg
aG93IGlvIGlzDQo+IC1zZXJ2ZWQgZm9yIGEgcHJvY2Vzcy4NCj4gK1RocmVlIGdlbmVyaWMgc2No
ZWR1bGluZyBjbGFzc2VzIGFyZSBpbXBsZW1lbnRlZCBmb3IgaW8gcHJpb3JpdGllcyB0aGF0DQo+
ICtkZXRlcm1pbmUgaG93IGlvIGlzIHNlcnZlZCBmb3IgYSBwcm9jZXNzLg0KPiAgIA0KPiAgIElP
UFJJT19DTEFTU19SVDogVGhpcyBpcyB0aGUgcmVhbHRpbWUgaW8gY2xhc3MuIFRoaXMgc2NoZWR1
bGluZyBjbGFzcyBpcyBnaXZlbg0KPiAgIGhpZ2hlciBwcmlvcml0eSB0aGFuIGFueSBvdGhlciBp
biB0aGUgc3lzdGVtLCBwcm9jZXNzZXMgZnJvbSB0aGlzIGNsYXNzIGFyZQ0KDQo=

