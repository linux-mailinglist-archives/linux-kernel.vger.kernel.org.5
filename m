Return-Path: <linux-kernel+bounces-46179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A962A843BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600021F21CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602169978;
	Wed, 31 Jan 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QYtfDNFa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V+X9UJUU"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5A69965;
	Wed, 31 Jan 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695702; cv=fail; b=gPU/IMk7fl9DEuKN6uoKEmX6R9QbNH5H9l5f7c9KpXIbhtBUaOQAMPDa3pciiIBzWru9km8AiZOm4hi6GLRF2bhklzSCxKT40wUWdKw9EdYX+kdjOz+9eFEuYdvN8JnVAM6ZGw5DyBJKvO4UMaTpagxFX24lVeAz7OdXxju158g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695702; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7E2hra0W/SYYkQTgjD5nJW6tzipKeOA6YHMjLNjKSz/DYU9sEacRL36mU5Um8/lvJQrbn3KcHn9g176sozzxVXf498eb1SxcTNrnjDkz/tXs1bn/c/+3azm9VvsH2o1/ftShSrDLpmYSSeQfY+JD/lOd6KCA7HGdjeiZgUgDfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QYtfDNFa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V+X9UJUU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706695700; x=1738231700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=QYtfDNFac6aCMmmeym0SyS/dsyFCOA5PNBlQVkVaUw0/A36X3PPYX63L
   GCxJembX0v9FNAREfqiT5uuxYt9QNgylxw6xuJXp2W+Yx3ml1M0L6zbf/
   IknLyg7SMSb2ekTAgcgPmeDy94xR40EJfRMpNYUkR8iSg4hp0TJd9wqHD
   up9B+h29Ynzxqs4lVrO/nqriHa6MC35/SMzLUX+X0S1ORRFIaOJL4x4+c
   WVsqtt/9xMFsS6fdmRgzdLk2SNxvcgnPMrnkfX2xaGrdIDLjtqkEaZ9cr
   dYAKYlvKSyZiavB8/FEbjKCqKsNjEE85rX7fc/GqOyQ80ywpRJ6bUwb8V
   w==;
X-CSE-ConnectionGUID: vogWZ1F/QtaJ5M+v+yuIbQ==
X-CSE-MsgGUID: 4M4RBT45RzivlE0xZSdVwQ==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8158593"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 18:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGsEUqb7hy5r9/Rn6ocFTT0QSNffDAWF8eQEGaRV0tkRneBc1g0lPY7CYf/PnleHjyDUOTJ5qMoofv9uE511Z6SjocINWUQq7ajC+svurYEuGWXh0EMu+IomKVO+NuhrdfNtEmZnBdHYZK+It20P5rsGxzKQ+Cvqi3w7/8rru1vZyTVnqpFjOosdUfJPbYLakI4oEqSlR6PL7dXVJaxH6fnON6kYttoh6K9PC4COB+cUS2ADNbIj+Qa8d1yu3DLLKyK7jvsOIk9kqFL+xmkVpFOE0CPLnjpflyu+LBafUwz7RIGpEfYIMPqaWQbldeLsjBSt/ADqhFpyzcxP9sX59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=HqSrKTeqbq3OoWK6qH98UEIEHgMsDfoYySTrsS69ciNwhU+XaaVbMRoVGPC6mclB4Puki4/665eID32WXDHoYFk1GB2oCDNPHSTNhSmNFv0+rbJ7+sknwhqdnphybfzXpthQK3GeUDKaUMLqskdGilgo7pI8DezaHGJUlAkqOPqNmag4R89X/dduMIiJ1H/Rvt637i44Lko8WCxArPIxV528VS+EcFgd4rwgm8kG8Vs3hQaM5PwLTrnYB+oXpX3y4CQ+I0tyrhlNsfLEwHMtewr5wja9HJebJ0xqLIRPYfPcwfh7fDmNsKp39lnJV+hUrmLX27ap+DfOOVXXnM1yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=V+X9UJUUrLvg60CF8R0lNiTkvuL0YlOWpniTEYQsnrk5Ot1+Kk/1ARapw1hiLQyVYP4NrP5fIgwv/A6sAHvytd6wdSm6KYCb/P52XXu+NXzq1PGEt41QeQkGdPeKW+47treanAP+Q5enxZY5TrmxQPK0+7X5iJ+lip5WUiK2R68=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6334.namprd04.prod.outlook.com (2603:10b6:208:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 10:08:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 10:08:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kunwu Chan <chentao@kylinos.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Simplify the allocation of slab caches
Thread-Topic: [PATCH] block: Simplify the allocation of slab caches
Thread-Index: AQHaVCoT3/hpdFxmxUyi4QmHH5/0gLDzsnUA
Date: Wed, 31 Jan 2024 10:08:11 +0000
Message-ID: <375ed714-147b-4a81-b9eb-7b7819d20024@wdc.com>
References: <20240131094323.146659-1-chentao@kylinos.cn>
In-Reply-To: <20240131094323.146659-1-chentao@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6334:EE_
x-ms-office365-filtering-correlation-id: eb064e8a-0d18-42cb-2941-08dc224487f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6xLlG+3UvLn9rPNdVkN2kCeOtxL/gqy1KYN7+ok/btfzXISrUI9dPxp5smoQd3JjLPE15xzNbGBHkR1vMApQs3s8FP9RZLX89wXuh2x/WdZed2yLJ+fcDa1u85C+ORQPvTHfwmrTMeeSIK71OXW7LmfwD885JdENoN7zmcFF/sy+xGYBxqSiY0OzFI+xGuuDdR/KlHtLaVCTqicmr8SfgB5EBMLhAKhJXcmhhAXterT7B/0nIla1G7aIXShZ9724hj9ANIoSJ16ZW+KUt+f3CrKc897LmyL5mb/uxvXSgbNYfntgtXYLl5wHG1ZoSyX5PpRI8tYsxjbsNwn/SgvJF0+Dvup1O03kkrnChwPiA7NL/I0Zwr5u2Dj8r3jf8GgkDCuRmu05n0nhRKACZweNwX51LY07jwaL2oQkNFOiv0qpNwuUJDix4s6h1X/5/5MlTxk8JpqbTxQuRhbqofkEW4Kl/NA0UXf0nlsfoIerWeBlzGfiTpWX0OSZWNgG+VG5aErKuYwAm4sTN4gIy3f3HH2AEutKqKat/jEtrW4ClR1qy5B6qhKToOSD5tsO45KMLv+TW/4wn5yxpigte8Y1+T7x6rS03WfGY3KbVLlPdGT+d6Td/J0GrU3YQdm3vHQnbkVyGLSlP257RABwPgV7jej5wPGgC0f1XUD2sZVsAEZln0jER2XFEY0U2MyhyKiR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(82960400001)(66446008)(66476007)(66556008)(66946007)(64756008)(558084003)(122000001)(2906002)(54906003)(8936002)(8676002)(36756003)(4326008)(6512007)(38070700009)(86362001)(31696002)(76116006)(110136005)(91956017)(5660300002)(38100700002)(31686004)(19618925003)(26005)(2616005)(71200400001)(4270600006)(6486002)(6506007)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlF3ZW4rcSt6dUlwakIzNnJrMG45V0wwUUFldjhNWFhzdWhCYWlIdUptU1lr?=
 =?utf-8?B?cG5ONUY4VXFLcUhMUzhydmIveVZmS1JaMU1iTTluaVltekJsMkd4S1BwNzNU?=
 =?utf-8?B?bVlLTnRCU29RZXNTb1E1bkRUQzZWWk5lblM1L3dYN0hqVmlwVDFPRzZjcHlT?=
 =?utf-8?B?eHFaSmpXNDVCdHBpUnVXSXZzKzhnYVlxemRZcUR6eDVMQkRwR2RPa25mTW5y?=
 =?utf-8?B?SmRvdlhPNkpjNmVSNVRWRWdlWnZqQkpEUWtsa1hSYmRlN0liTVc1cnVLL3kz?=
 =?utf-8?B?OTYxcjgvUTdEVzQ1MTNZa1d0RzFLU1ZSL3lLcTVHMWFvRnVJVnpkK3dPYnUy?=
 =?utf-8?B?ZzNBV2I2ank1RHJRSlZEcThEK2Z5Z0I1SU1zSlA4T1JjQ2ZFVEsyUnZDVE9x?=
 =?utf-8?B?OG5uRE8yTGcwWlRnelBFakRIZkdZYkVnclU4QW4rUDdGOUxIeFFwUTJ3NU5q?=
 =?utf-8?B?QTlKYnU4SG1Odi9qSjNxY1hSbHpyT1lyL3d2eEtGbEdaUjJSUnFBSTZFTzN5?=
 =?utf-8?B?OGFJTU80VWdhamxDSkNybXBqeVpjQTBjREUrckE0aXByenJVNkVaOHFxVW5t?=
 =?utf-8?B?c3BtQXJXVU9keTR1SEp2OWpiYWJDSERpM2ptOVdYZmtJcDJieGdGUlNvdTRM?=
 =?utf-8?B?YXZrQ2RGMkFneldEZVVMc2pjOHpFRHlGTndQQjV1NTZHK1JQQ0Jna2hlUThn?=
 =?utf-8?B?ajFzZkdodkI1bDBMaFk5YVZqS014bm1uUFdkSXJlSEthdHZGNllzbmxOTkI2?=
 =?utf-8?B?YmFqVHl3bW5yUDB0a0U5RzkzN2Q1WHlUNWdmY0lOMmI4U2pzZGc5RDN6WDZk?=
 =?utf-8?B?WmlwblkyN2JYSVpRYk9OdHFzdmJyYWJab1RYNCtpQ3JMWmFnbjJEQVdOd1F4?=
 =?utf-8?B?WFgwcnprUTk1ZlJPb2cxeERJY0U1MzA4bGxUSkw5ODJSVnJPaHNHUmpXTWRo?=
 =?utf-8?B?d2xFaVlyenRRV041V05NU1hWR0laZ2N5UGIxeVBpV2p1STNxWCs3VTdsTW9I?=
 =?utf-8?B?K0o2Nk4ydm9OYUtLYTF2d3BudnNKRjVZMlc2eExXVWhBNlZBdFVDdGlWdFVQ?=
 =?utf-8?B?bjBoVHFyczQrNFIzQ0oyZVlkZTZ3U2JEMUhuUmR1RUtscjZZVnBHL0JUU0xq?=
 =?utf-8?B?SWk3QW5qYTRpaUhGakF2by8wdW5lWDBDMzBJVTRLWVBxcDlhM0xOY2VVQlRl?=
 =?utf-8?B?Rk16NmdiRjIwVjdHMzJUa2pUR2UybFV1ME5mNXpwaTF2TWdUa01RUFNlZk0y?=
 =?utf-8?B?TFpyd3FacGRHQ2p5Zy9mK3E4TDZubXR2Ykp1bzBHWEJGOFVyQmYvaW1DU1Fw?=
 =?utf-8?B?cUEydFZmYXN2L1RKM3Fkam5FYjk1MUtHNDFUbEZaNk15M0JmcGFSbkpITmVE?=
 =?utf-8?B?Z2o1b1YxNzFETGdrMUxZcUJoTDJFTVhYL2JFN3dCb3ljZjJqZm9hdnhOS2Z3?=
 =?utf-8?B?dEdHTDllelgyT1Z2eXEzZ045NjBNaHB6YlcvWERzSlBaQ3ljQlVpemRtbytU?=
 =?utf-8?B?SzRwWVl3bTUvRFZTN01TY2EwWjFsUElFSnVHRE8yeXNYVlRBalFEMGVvRGVp?=
 =?utf-8?B?K29qOEpBenB3WTdoVk5Fd2t6cDd2RGgwN1g2WFZQZzlnc0ZURWFrRDhvTmRv?=
 =?utf-8?B?STlSSkpvVW1TRTBwYTdoZzlzM1VqN0ExVlczQjhoQjgrQ0REYjNyemxBNE5Q?=
 =?utf-8?B?Q09VdHhpRGNzTDZ4aXhpSmpjZXR3elR1eUdTZkdvUVlxMmR3YXpmMkpKRGpC?=
 =?utf-8?B?ZWlFb2xFRENyVHR1SmxHRlBXa20xOCt2eXhQL2kvMnBObFc0UXlmak1MV1Zy?=
 =?utf-8?B?VFVGL3FYd3BmYXlkbms1UjZwMnd1NHB6Y2NmY1RSc3ZRTks4MzhCbllaU3R2?=
 =?utf-8?B?dERmd1dsbHpJcnlIQjJLaVlZUkU0N0RtK1BkSm9LMmRtd2wzVUNjblU3QWhq?=
 =?utf-8?B?K3NwVVpYanFESWpaazJQMGZldDYxN2xGbnE0NExMV1A1L0E2eC9CVkord24r?=
 =?utf-8?B?ajJWd0YvRitDNFE2Z0UrcmJnMEpEc2gwSkRqRk5hYk9CNUdTbUtTTkdqbUVk?=
 =?utf-8?B?YTFpc3NyTkdXOGtIZGV6MEFCOThWYnJ6TDZwR2RzUmFnZ3ZKaGlZSHhCU3VC?=
 =?utf-8?B?M2NmWWhqTkhzTjZGVzQ3YWFzWndSSkk2THlaSCtDVmEySDlOU2hmNFVWaHov?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2CDAF7A4B056844B9D5C0E9A9B0F4F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FfpGSnSxTvLdW3UKg+uWIL+JyWZzcG9kGD0WMVkqqDgXG2/B66E1fqbpTC7UC1LZTGvM9RhKjzea/9NtxJK+mEa9aCz3zC0HaBFg6IJSIpP9JPpgsBBZxvbzO5ewb404dVllGHLMymlXsswDEpxP6O8neaPBzdaZc+TUnpMywOZBO8S/QJZNR8e1VTZ1cig5QlzuTtW8U7d+A7edf4o/0SLhK5HeJMmli5kPBrBSpkAjMTOL3oGv6Wn3Wei1uOyMQAxVLouEZLEQ3HwDMxihej3dwt7UUv0AuJXrwnpGbWNxd8CxRy8neVlQNRaFTEuhzLQUGU+NxNgno1BPlYRppUa7jIsdeVlCEKPj541Sk1ra9AbfmfTPrlwda6r/v/4m7BcJGa8zG+PBo/RT67tOE3/727XDL5/OZ+9We6g7q7Wy7KRPnoUlOhtgyP2drPB09P7ogGuvLoO9EaY+Eu7hge2k2X0LHFigxTqGl99THq/PUXxhoj2SlLuCd3f0YQG5TYQViCxie+tWpU0XBmCM40M7umSXGHq/ygHKInWsC+DmX1oydvKzDlrZfKzO7L1446fY9jWEHMeiWyYhwJXVnkruSPFCNqAGf8R/HqcAVnrt+kjX6NZvtqy7TaSIRs3V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb064e8a-0d18-42cb-2941-08dc224487f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:08:11.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8HPaZZan9vcPWUU0nTYcWeiCIYKZlKfUlSkvFqBgKXThSygZVrz+sLmIuU8VBQLLUzkzLpBfrUXbx2sJIJa2OCh5lxFvzKfgBqHqgnoOvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6334

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

