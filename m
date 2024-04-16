Return-Path: <linux-kernel+bounces-146666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5018A68F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C431C20E97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE310128385;
	Tue, 16 Apr 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TfWdOIyb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vYt+Djtr"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658F128376;
	Tue, 16 Apr 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264406; cv=fail; b=q4Q2VCMn+iJqXx+0bUU4X89RFHEm6BQt5EhqxQLCNpwXw0C6cVSo4VF8JeZfSar/Hp/SsVkAY8cZXEOQVGf66m/4BdJLR0c1QpFQzmTfBmkIN2Jfi2zo3UH7KM4SzV4y4nbx7mpPXnQL6wuzSwZUvzE+SycLA1CR89TU1wWeaao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264406; c=relaxed/simple;
	bh=NePuvX4OH3vXaAuxHoT5YSxBVlxsni9QbZlHAPS/77M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AbMfFrsFEY8ngiNOXqZzKex9vWTDQAWtF8WrO1CxqKooTO7OLfL5qOl7elLtneHtf5zKMbcYVePYXMR+LVgePlXBaYhtdyhjg0x+9ZkIDa40B0F1xprbikcn3vtV6uXmnEPyjEtV/HTkIukdqX7bK1E9/j14nszf3DJASzaJ4q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TfWdOIyb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vYt+Djtr; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713264404; x=1744800404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NePuvX4OH3vXaAuxHoT5YSxBVlxsni9QbZlHAPS/77M=;
  b=TfWdOIybdfifXkYV8FWPIiFvJzgz1q7Ez7Mgp3M7HdY/o0K+5H7EfoXl
   ZLwpi8HDOsUxlf/EkZHtYmhpblhK4ZR56RUo1ER6c+mnRmldi7k26Osmu
   5bLnGFYeWPfCwLRPClXAlyALTdJguoWKaEjQeMuSYDZ5slBYNREVTpyQD
   QRywpAcxOHm9cenD4w3D2UGrIb6PIwZ5xUQPMd80LiPKTryXEcPhAEKNz
   KamTAAmQgqLj17NtPMBgny81VJqf60wlX0hAXCxzqYvZ0aMW+k9IHbolT
   BWN0FufcmOowCRakfmaXZFnjiMsmcdHJq2b6UD9+AhtgQdfDv20GfM8cZ
   Q==;
X-CSE-ConnectionGUID: RI2LnEA6TeCPPchdVTZnsA==
X-CSE-MsgGUID: rqKiV968RH6aFC0tW6G/bA==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14323638"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:46:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBl1AqymBI3LlH8+uW3+G0USV22wHR/SL77bcQiunaE/YhZlHUBR0FfPlyJtXAXrkIfApoPg1v4GVfqkBoP6m1mFGjDocUXpOVu0ceavMdoxzwU42ic/u8xzIJ62EXe0bu9R4njHdqUFOMD9sdrSE7vD0UWyaw6McQIjslsnHtnXKBR2hGBy4s0hXYB8487kZHfxsDNX/PPw7ek0DNX9mB56EU40k+Dwz3xGOmHmxVIURIV/R6FlISs+NAVi3uv8G+icA1L5jV7E6eDQ7GnKRJZbYAgA3jeg8WLtD7OVBw2W8vHYf1MVBI/uL4ROJVwPhgklUvvHQiMXVMWYvE4YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NePuvX4OH3vXaAuxHoT5YSxBVlxsni9QbZlHAPS/77M=;
 b=UbAuULx6z9xiBqrx8l5//aCehaay16keXt6WD61tPfNZ0o6WTQGXSoi1oo8pUVuZI+vynW7wzlkvZiFsTovwuIT2KLTFT9BBmHmEIRaGeb3w5SGiX9rH7TL6dGji/iSlp/X4V/lBqRaESgWAveMLE/exuuXWHzrvzSVrDPVsZNn1wDHS0GWlbJld60IhprwjZxOAW9VOjolE22UqyrdYNLEult+D67sfyzTNMOPpraWfClb1Y2thaiWnNgeaSJMKYtkn91LvOJCdT3CKu6KyB4NrmzVK24L5+vVz1+SRwIJYIzYjwLb1rTPxTunkuDxGx9skbrbCRmyGBu7YKu25Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NePuvX4OH3vXaAuxHoT5YSxBVlxsni9QbZlHAPS/77M=;
 b=vYt+DjtrsVbB898qfifDWdko8jaMexJJy1L1wY0YP8nDKUcPocyo5CNVdQ/nhNznbwN4gbJeqrCzZtXMwAcxJvUJVz4etkm5rjBlpHLEs3snTHNTOOqtL+igrFViXcuIjf/pR1pX38jzjDgP8NgZb3nKaHnj3yRzAo7Jq8kjiKI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7465.namprd04.prod.outlook.com (2603:10b6:806:da::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 10:46:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:46:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, Saranya Muruganandam <saranyamohan@google.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Thread-Topic: [PATCH] block: Fix BLKRRPART regression
Thread-Index: AQHaiwSINB8WBnJl30qPCQCcaD9o87FiKqMAgAIQ7ICABmorAIAAGvYA
Date: Tue, 16 Apr 2024 10:46:41 +0000
Message-ID: <f6n67pnc6xfqo6onmmimeebmr5vqez6s3vff7siugifr4xyrh7@jc5nalawfpxw>
References: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
 <20240410233932.256871-1-saranyamohan@google.com>
 <zvmwp3n3yx55ogzb5gtfe2xdmsg53y3umgnezcwd4weq5vloru@w6qi7lfvezls>
 <cbcf7378-e889-489a-92d2-1feb112cff58@nvidia.com>
In-Reply-To: <cbcf7378-e889-489a-92d2-1feb112cff58@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7465:EE_
x-ms-office365-filtering-correlation-id: 68cb4ee6-93a9-4001-854e-08dc5e02801e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9nm7rg06osYJW8H0wFm953bHwh7GHYhlhOszwNFTsw5PURHdmA1jPuJI569RZEpfjiiUJVeL3kXLYZbsg5yHcUibsuOuQDJE8NCMgxPHKX5n5IORDlln/MK5EX/GPBUqKY22e8yjc6pc1r5JaEOUyj2eoR+uO7qs2NCkSVgiEGfkrMLIT2L87Mb7Aa10VT2zJYnwJYTxzGuLwyPbD3j3tsvmnRVq4hZIE4QFpkQHvOiKqZ0RLPO45lzojEBiYTKA0INLSY5elJ4y5+xSHQZNMR5gW9QZ4QkEHWz4n3CK+jj9DM1KO6OLAI/cOluauH8KK4fQ8u80vREf+WKCkSxdCiWzCfB7dVOzBHzKiOE+KAqJB4UtMWczV1DkExd+bm0FBq3y+0NQvTzt3vLZZcFt3V7iK8nKMD+ZCpiLnzm+Q4RnpU0nr6c9GoWe+IhqqQB8smBdEwnAthEbR8XmcI4sTFJBcOaRjmweeYOlXHgw7k0iyjsFdzmAP9ZepBLrNCF8eghqUcFf5Bynw2LaeblIknqkD9WFMk1+T9slrCI5okGUx8uga7SZHtryJ6L7y0wQ7o7c3bWuaygPgmaUWsgDaql60jX6QBJilHZAVwkrlq6XHA0BqJvqueWBiVciLjrmKYzX9RpRHYetW9G6I7tnuNDvN/WVl+KgIg2mjg3pGXTw3TTzNuOwZw0sdfoEV7EAkuGQp/vuzoZfOk6RSz0P44GXF3mQatUJyZ32xwzW+0s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckhSQVlCOWRqbW93TmpUWWZ6dTlnVkhGeFprMXJ0TVFNc2VtdFZoQ2ZDUlNC?=
 =?utf-8?B?a3p5ZWYrdGNNT0FjUE1ITURCRng5d2x3WDBJQW5BSHozQ29DYXZ2NmROL3k1?=
 =?utf-8?B?Wm5Hb3JQdEwxZlRnekJCTGZFeitoamNBRHVaaldiSlZzZXNQeURKSStleU43?=
 =?utf-8?B?TTFPVHZyN1NFMWNxc0JoY1VYSzZmYnNkbWMzT2pVQm9BOENmaVJmWkVRTFVa?=
 =?utf-8?B?UEhSVkZVc0psc2cySVU5bUtoNFFiL1kyN2xqOXVISkdlUjZHRHBFTDB5NUpv?=
 =?utf-8?B?cmszcE4vcEswTUhQYzE0MGZVRnU4T0pGcUpoSmdxc0RTNjhYT3V4RnByWVEz?=
 =?utf-8?B?VGl1WmpGaGgyQnpHUjZBTGdjak5yMTArN09MaWxndHZWZWFUaFV3WHBzQXdS?=
 =?utf-8?B?WkJhcHN2cGxjUW5DdG9DRmdmaXYxUlZDMnFwNk5yeVRadFd3d0p3RXMxTHRB?=
 =?utf-8?B?N1lFMU1BYzhnMG9wU29VS3kwV0szcVVWcEk1YWZQdGRtTTFxMmFrUnJTK2hM?=
 =?utf-8?B?c2FENlZUNE5XWUh4ZlBHV2ZiN3hvbEh6a3dPZXF6cFoweDVQcVF3K0ROdzZC?=
 =?utf-8?B?T29RclkraE1Ob0pLbWZCZFR6eGZCcjJpUEVyRjBJZ1JiM09qbWtrUTNjRzVJ?=
 =?utf-8?B?WlQvV2VQOUlueVZKUXlSRC9QVTVON3JIVGFQMGI0Snl2eVRHUHRuWkVFOE0v?=
 =?utf-8?B?VTRxRDIvNzMzZmNHSS9Jbk9zdVdLQU5QN0Z6ZFZRNjV6dXMyR2dKNmo1azVO?=
 =?utf-8?B?U3VUcUdKcDZRd21PanpDSTBaWHZTZGQ4ckkzTHpsdWpKTWxpNWhsREkzcGJr?=
 =?utf-8?B?ZHFybjg3QWk4S3NBaHViSkdMZ1pPU3k3aDVtWlluR0ZscUExQ2ZBY1U0ZzFN?=
 =?utf-8?B?UVg2Nmhia0h5S2lIWTcvQlE5ZlpzT2hFTEtKUmsrOVF5cVRFa0tORVNWeXQ4?=
 =?utf-8?B?VGJsUU9ibDZGWGZ4MjRGYmVPMHFKUUhUZkh6bTRHQ1VqLzNrV0RFaGg5NGw0?=
 =?utf-8?B?L0N3N21XNGZTQlMybXhxU0IzYlIzOXI5amVuR3g4T1VOcWlvV090OW9kSTlD?=
 =?utf-8?B?SGZRYnBJclZ4WXhWd1VUUW9qMG8vM1dKazJwMDhTOVNjUkxla3ZZSHhBUE0w?=
 =?utf-8?B?eUJVSW5jMlNhV0dlTG5oWnlYVVBoV3JvTmp4SzF4UUVDR0ZUbmdkYTJLZk5i?=
 =?utf-8?B?T0FDVm9mbnR0dkFJdnU2WUJteEpFV0R1Y2VSWmxxUGFoTHlFK0dvVFF3eGpS?=
 =?utf-8?B?SEdleGdlcis0Ujk1elgvbkh4dTNBRktyYlV6eUVtUjNrRDBxQ0pkWk8zVnNo?=
 =?utf-8?B?NUxkK28xWXlNeENvclVuUDg4ZEpUVHlvcUJmNUJIZlJpTXdJWkFCMlo3ejhz?=
 =?utf-8?B?aWlKOTNHczZYWk5lWjZYN0k2ZGlZYk55azVYMUpqR2drZXgzdzhnOWw0cmFI?=
 =?utf-8?B?RWpUeldqT2c3M2Y0czdiUnVrSFNXR01VbnorSUw4bmxhVERSTlMwQUhSeE1H?=
 =?utf-8?B?L01EZDUyNitmazRkd1ZWbzdTRWtlYkV4WWVxa3lGQkFKN2RhNXBXZ2xUZGFx?=
 =?utf-8?B?UWJjSGQ4MHVwbzhnQ1pXWDVPNlFESE52cEVIbEdXRlpQUE1wTTFya1FGbjl6?=
 =?utf-8?B?Tlg2TEg2N0czMzRQRTY4REQ1OFpvYklCSjBoZS9MWmVhakc0SjJkNmlrZVBW?=
 =?utf-8?B?dzVOdHcxQkVJVjU2bVlEaDFRQUkvcUN4bkxiRDgzcm5yTEVaU0tFWVBJaTEy?=
 =?utf-8?B?Yjc4cFhDV3BaaWJ3QUxqZmpubU1CSzlWY2QxejZodGxqUTQ2dGdtdGJSMzBq?=
 =?utf-8?B?ZzFhUGFEZktqS3JaR2VjbjM1cEZEM3diM2ZxMDQyTmtjUDVSL3JQbmFrb01E?=
 =?utf-8?B?MVlPbUxJbGo5RkVURER4djl6UklWYmR3ODlVdWRneDFJZWlnQVd4RFhlSFV6?=
 =?utf-8?B?M1gzOVNkaWttMjA5cjN3VGpWT1d2N1dDK2RUTGw3cUdyYTdsWVV0Wm9qQWk3?=
 =?utf-8?B?NzVMRWoycFlQcWtuZXQwWFBOQVk2UnBUemZsRXduWEZIVG5VY09UclJ4Smgz?=
 =?utf-8?B?a1FwOWtqMy9EQVlYRDNJM2VPYmZZbmZ2VThhV2JtZmhpdnlPcWtQWFlUZHRn?=
 =?utf-8?B?cVV2TDBQaC9YVkxnOW0rVHlpazh2N3hxM29ONFpQSlNQdnZ4V0tkTUdUOVpT?=
 =?utf-8?Q?iNnUUrm02b/X/ju9AgQKRVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00362F44DF43014E9EA672B6FBDA5C5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	glWa5kTNCU+vMYwJkyc6gV1eXxrALxqeTslm1ND3ci5TYzKmAWikaE9JSqqfoZvk4057IkqB6t/0WQIpjRVxS1pqxxUpxuIJxZ+GnF/7Ik1+CS09yV9wAm1PlByJ5fN3hTHdanrycpcffLGviuFo6l/17NV+hip7ppeVF2brdDARzD3N7nIU0y/KMbMB4reaQmeT08fYnLd0Dm0UJtPwSAYbd0/jnspPW+YVAbwsvK/wnlrdg/uoX7z5BwsTL3KtngrXO4THJPmkT9q553NMDFSorF6AFLy2d0vBagAfSEFG+tjG8Zc3sEyArKJAg/1Phzbht8PY6VDRba4qQi1VAqVLlztAG+jU3b8I/0svGvkkX/FoFB7iRIC6H3bIZkT/cgWyMkZMjGyN0Sg/69pHSTQhcWGawzi/VmRHLARNjcd9uPgVG0Azaq3fvDEnvGvmdKKPsF96Cy9JS82wdG7+j6rjqspGtftsARWt+Co98cG5/W4hfwJfmN8vXHFU6gSGTpvtlOQvD1pnvBr2KIZfNHJ6tqDU5BjeEBhaIPN2OzeLEERLXUr+scX2sutIcT9PozIE9LHxI3g95oBJgYa3CSa5HLzfJAbF6GxBiJieTXqNcBf4RsPIzW20DwPS8Kr2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cb4ee6-93a9-4001-854e-08dc5e02801e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:46:41.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QdxVL7dl+ZpLC5aVw8jyKG90psOCTVLRR/gG38aLpMOh2J+wrJ0WMBG037nNY9si8ZMSzWRg5f1MfvTtQLtjIwPOnxBmCrfJCT5kLHMy40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7465

T24gQXByIDE2LCAyMDI0IC8gMDk6MTAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24g
NC8xMi8yMDI0IDEyOjEyIEFNLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiA+IE9uIEFw
ciAxMCwgMjAyNCAvIDIzOjM5LCBTYXJhbnlhIE11cnVnYW5hbmRhbSB3cm90ZToNCj4gPj4gVGhl
IEJMS1JSUEFSVCBpb2N0bCB1c2VkIHRvIHJlcG9ydCBlcnJvcnMgc3VjaCBhcyBFSU8gYmVmb3Jl
IHdlIGNoYW5nZWQNCj4gPj4gdGhlIGJsa2Rldl9yZXJlYWRfcGFydCgpIGxvZ2ljLg0KPiA+Pg0K
PiA+PiBBZGQgYSBmbGFnIGFuZCBjYXB0dXJlIHRoZSBlcnJvcnMgcmV0dXJuZWQgYnkgYmRldl9k
aXNrX2NoYW5nZWQoKQ0KPiA+PiB3aGVuIHRoZSBmbGFnIGlzIHNldC4gU2V0IHRoaXMgZmxhZyBm
b3IgdGhlIEJMS1JSUEFSVCBwYXRoIHdoZW4gd2UNCj4gPj4gd2FudCB0aGUgZXJyb3JzIHRvIGJl
IHJlcG9ydGVkIHdoZW4gcmVyZWFkaW5nIHBhcnRpdGlvbnMgb24gdGhlIGRpc2suDQo+ID4+DQo+
ID4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMyMDAxNTEzNC5HQTE0
MjY3QGxzdC5kZS8NCj4gPj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gPj4gVGVzdGVkOiBUZXN0ZWQgYnkgc2ltdWxhdGluZyBmYWlsdXJlIHRvIHRoZSBi
bG9jayBkZXZpY2UgYW5kIHdpbGwNCj4gPj4gcHJvcG9zZSBhIG5ldyB0ZXN0IHRvIGJsa3Rlc3Rz
Lg0KPiA+PiBGaXhlczogNDYwMWI0YjEzMGRlICgiYmxvY2s6IHJlb3BlbiB0aGUgZGV2aWNlIGlu
IGJsa2Rldl9yZXJlYWRfcGFydCIpDQo+ID4+IFJlcG9ydGVkLWJ5OiBTYXJhbnlhIE11cnVnYW5h
bmRhbSA8c2FyYW55YW1vaGFuQGdvb2dsZS5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNhcmFu
eWEgTXVydWdhbmFuZGFtIDxzYXJhbnlhbW9oYW5AZ29vZ2xlLmNvbT4NCj4gPiANCj4gPiBUaGUg
Y2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUuIEkgYWxzbyBjb25maXJtZWQgdGhlIGZpeCB3aXRoIHRo
ZSBuZXcsDQo+ID4gY29ycmVzcG9uZGluZyBibGt0ZXN0cyB0ZXN0IGNhc2UuDQo+ID4gDQo+ID4g
UmV2aWV3ZWQtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdk
Yy5jb20+DQo+ID4gVGVzdGVkLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPg0KPiANCj4gd2hpY2ggcGF0Y2ggaXMgdGhlIGZpbmFsIG9uZSA/IElz
IGl0IHRoaXMgb25lIG9yIHRoZSBvbmUgcG9zdGVkIHdpdGgNCj4gdGl0bGUgOi0NCj4gDQo+ICJi
bG9jazogcHJvcGFnYXRlIHBhcnRpdGlvbiBzY2FubmluZyBlcnJvcnMgdG8gdGhlIEJMS1JSUEFS
VCBpb2N0bOKAiyIgPw0KPiANCj4gUGxlYXNlIGNsYXJpZnkgc28gSSBjYW4gbWFrZSBzdXJlIHRv
IHJ1biBzb21lIHRlc3RzIGF0IG15IGVuZC4NCg0KVGhlIHBhdGNoIEkgcmV2aWV3ZWQgYW5kIHRl
c3RlZCBpcyB0aGUgb25lIHRoYXQgU2FyYW55YSByZWZsZWN0ZWQgbXkgY29tbWVudC4NCkl0IGlz
IGZvdW5kIGhlcmU6DQoNCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8y
MDI0MDQxMDIzMzkzMi4yNTY4NzEtMS1zYXJhbnlhbW9oYW5AZ29vZ2xlLmNvbS8NCg0K

