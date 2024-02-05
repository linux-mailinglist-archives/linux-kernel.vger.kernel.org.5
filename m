Return-Path: <linux-kernel+bounces-52144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE320849490
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB228712D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8A11198;
	Mon,  5 Feb 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BVeO2kBJ"
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940D11184
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118324; cv=fail; b=O68BcpiYWewPSreTyQmd9PCl7nuei/jGMbQa4VDk6ZY03G4TRYr+sBovShp5Qcszz1ZBfaO+r5eCnQrJspGTyTslWTcZMIiJHEeG9S3LkGQAbG9dNaTZkjOm2uCEJ0oSpNFtwlCAA5OCFn1K56rPHX96d0S0+syi/IXuVGDV2Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118324; c=relaxed/simple;
	bh=M7/lvVvyt1ps9fACU2nau+hq0NtXEtSKxm0G1f+hqrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5ceK17r8yn64Gi/NsIZQ8GmkCeh/NKNKtyGebHVRcxN/XRB6kHKX6XV3Qkve7m0wK1+khIoAFd9JS8f5nOWmW+V1+mVzgnxHXRMFAR6kvvrEnLn99u7nno9JKEd5DCgD5KMbv1LC6egQXquk/BmeZ14yIYLKUZjgV1mJxThknk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BVeO2kBJ; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1707118322; x=1738654322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M7/lvVvyt1ps9fACU2nau+hq0NtXEtSKxm0G1f+hqrk=;
  b=BVeO2kBJCMath7VxvkV91Ru2OL6hZ3PqhuJF6hURDUozauMdLtYS/dbF
   /5VLQHM9V5YzpPAleoUkyp1qo/L7nDEALzuiNzRgvl9mImD7KQcrmJbmo
   2fEGbg63o9l1FuJtAIWNs7E2+3k64j2RVJuOT3yoZkAqZNid15XthDXB1
   3pVXVMdrnAPS5VxrxDFr7li3gff3Gc4nOGaGrLr6AjkzjCn0cKzHsYg/s
   BCumEZQ/ywpiNrAvVHC+F4n/pJk2Gtl8Kt1x8pWH/nDJRhJpiohTFCaFY
   wjYRmVUMXAxp4y8m0rB4gif2usAlwfwCGjd6xxTeDZJ7qHTntkOebmE27
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="110552561"
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; 
   d="scan'208";a="110552561"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 16:31:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPZDtYgDCUST3c+bRGIqDlLGogX/BtIpBzXz6a0x/PUIk+euF6KE23YMxF5hzmi2IKh0BGJj4pwcCf55OnXwa0gEROOuDW/fhJhewIzvUh71ubuOaHgonJ1BRT97hCBnNma2/IRu5ZFRlUkznDFygSlCvPp2R0zYk8tpkg2F5nNByM8vbuy94M3wb3WC19v13pi8I5Bq15G3KPAnEzktgL+iqva/OtI7YtCOegOuUUxKArCCAFeXDOj3dVIsEZgNAPi8XZp4AzPpS6z3ziOQT4s4jOUFwtla80OkKCTFenIUh470MQGO3tqTUgv/TtRlTRzUvs+UBEYB39WaIP7+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7/lvVvyt1ps9fACU2nau+hq0NtXEtSKxm0G1f+hqrk=;
 b=nixNTxmvDorlw0uj6RsutROA5jgz7xgxS+zp0J+BvZAlbaJuqI/oN/aIJR7xU2kLpW3c3xxnEJPmBxJ/x6oIw6iUuCC4JBZVVH7ZFKHUS85nHwSuJwCqgJl53pGlu7GzsqVY/Z+NzzuoZRQBi7yIknv9D0Z+kJl3MBbMzCJb6bNcNJAOXFBwDzqmSCK2j/sleYt8KFrLi+LBYP3zz3MVA/5ZAR8RZVDDOBktaao96wbqksZb4H/DF/wi6MPZWDqh/hpMtiaiCObRXSp56cz2NkKZmNu5Bpub/wrnpGnkTERB600Pl3P0sexVOfNVo5/2sTePG50L8wL+tmR1ofgAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by TYCPR01MB10778.jpnprd01.prod.outlook.com (2603:1096:400:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Mon, 5 Feb
 2024 07:31:48 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::2336:cf8:2fb3:65f2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 07:31:48 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Topic: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Index:
 AQHaDTg+8WEYMUmyx0WBKXqinoE2/bBmXHiXgIw8lwCAARKLkoAAIh4AgANuxwCAAArqaoAEqOUA
Date: Mon, 5 Feb 2024 07:31:48 +0000
Message-ID: <a791fdb6-6c36-459b-9138-6e0dc73f2b24@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-2-lizhijian@fujitsu.com>
 <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com>
 <87fryegv9c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cc125e55-890e-4de8-876a-30d88e8438b0@fujitsu.com>
 <797f9b10-5626-4511-af6f-6b90cd5c884c@fujitsu.com>
 <87sf2bb7mb.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf2bb7mb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|TYCPR01MB10778:EE_
x-ms-office365-filtering-correlation-id: 7a1bc1cf-f30a-479f-4b48-08dc261c836c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A5k54SJK8NMtFhlqs0KbVh3ZgnFgJY3jb55seoaHIcWrW7P8sBuDVrbsCF4au8YL+3lp/FkrKnCT2CCbdfOH6KBFoNyTsO37xT1Uy5B0DJMp/RLWZPjlfmzdscpNtcoEdDCgb3cOuCjrdx92mE0DpR7kduGL/nhQxRfuf6BzOCD6Vdx2C1/LDcEtumGBSvf3brhz9n/FaHzcC9P4qSo76m/TSL58SAhb82W9m7pfdipIFH3zPdYjEffYMtg/4HT9zOBcxGln0tKmkNMZa57qHp+YyaXzP7rqPwM6oBMKeHftjzaDh1ysWe2HzFQfeQb+Lr4fRb8dPYU9L483N7zaw7t5YodtQ6E3piD4DNsZv8bdvihFp7Seba+vHQTsx/orKFtKFbAh5WPEXORd8rUkU68U1rFEeKNcfRQInFZ34VtmhBFepDxK7c1hoH2ir8gN7zr8sFLEUszoToHNjXl9Y8tJfoQukFuAiQAR17jkkfuT6eAU8VDNacBK20zt5tcT3Q5/K36F51whyBCr+m0nM/U6coRECyu2DzEZH1hAIbLiSnJXb5wg2UM/seD9Z2bhM/ieRU95ylQKmuaDKRXwXFoOF40D1h36FxbKkWFErfa+5b6TygB5UwdjE1Im8te+MNVD4H55j2zv3C2d6tthwli2YS5+JT0O7I6BWTSuA+LLFYJvHXYuDQFjCOEowT7QIfFXLPAgsAL7iG4nTeZ3EQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1905.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(1590799021)(64100799003)(186009)(1800799012)(4744005)(5660300002)(31686004)(2906002)(6512007)(1580799018)(38100700002)(8936002)(41300700001)(2616005)(31696002)(8676002)(4326008)(85182001)(6486002)(478600001)(38070700009)(66946007)(76116006)(82960400001)(66476007)(36756003)(86362001)(66556008)(66446008)(71200400001)(83380400001)(64756008)(316002)(54906003)(6916009)(53546011)(122000001)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d20xa3VCM0pSK3NZMEZMNVI2K2RIbjZpdXVGTVcwajVWUU14ekVYaEZ5VjBK?=
 =?utf-8?B?ZkVvV3gzZW9WbDQxKy9rRlhlODFPSjIzdEZUT0s4eG9xamhHT1pzNTlOa2kw?=
 =?utf-8?B?dU10NmN5ZjlOMnc1NDRXZEJ2Tjd6QnBEQnlvT3dodXpDOURLVmY4RXlpNVI5?=
 =?utf-8?B?eFNXYWMvY1NyUzlyTDFSd0RIWC8rUGdDZ2hUWkNxM29Sb3FnTTFlQmdNQmhH?=
 =?utf-8?B?djFnMS84eW83eXVYV0VRVlBwekxoWndLbUN3UkJEL01kanYxb0hldnhuVDZy?=
 =?utf-8?B?Q0N6YXJIYnI2ME1TSld2bncvaXFkL1FWWGhndFdYWEkyR0FGaUgzRTB6V25v?=
 =?utf-8?B?R3lEVkQwak04bStvUUthcmhtVFV1MEJtSE9kQktYQm9lcEtUdXVOaHlqQ1px?=
 =?utf-8?B?SHA1aFlnTnBtN2FlOHAvOUJIdGtPNzI1ZXdDcVlFNXlWOGIwaVExcUFXS2lK?=
 =?utf-8?B?Ykl3L2tueXlLMlpXcFQrTzlFajNMajY2MkhLbkZ1cnJXS0hkSy9KaWhnVVk0?=
 =?utf-8?B?UlV4cGpCR2x6NW1uSWlzSDRvbndvb3ZLRkFwckhDSXU2ZmNSUEJuOEljNkRY?=
 =?utf-8?B?RFhvaFdvdEZRWjk2Y0lsSFA2eVlZOGVCWDgwaUZXd2I2dDJkd2hpVXA3VXJ3?=
 =?utf-8?B?bXR4Z0hUSmZUR1JYQk9GZ3Z4UkcyWmVCcExVMWtnZHRubmtnWXVGckdFeG9Q?=
 =?utf-8?B?L01SaHNDOWh0UXNGZ3ZTeldWZmNrQS9qUGh6SzBwN0Jtd0tTWndjZ1kwTlAw?=
 =?utf-8?B?WG4za2daOVd5eC81cjlySHphK0ZiOElaU012OXprSm5PR2pIVFN3amxNRE5F?=
 =?utf-8?B?eTI2YjFjU3pZa3JKay91NnlhMHNFMi93WEtrb0RONWVuNHhqZ3hDYVlDdSt2?=
 =?utf-8?B?Q21YeTFOT1BxQzlqNStWb2RrWDlCbHBxK2RGcmh2YkFQbDZ1NlVTdzRDcXBO?=
 =?utf-8?B?WHdiRG9CdGt1dkd3WC9DbGhSd2xZdkNpTkpIRFZmWHZ5Yi9DS1R6ZWlBNXZi?=
 =?utf-8?B?SGQ4UWdOMFcwT1FzVlJYTVdUNFJIaEc1ei9TWHBQdFZUNW5zdThtbUJENDAy?=
 =?utf-8?B?enNXcHRmT21WdmhRTTVsekdrNjdLU3duU2RzNkxmZFFnWVg3TVhueWp1MVla?=
 =?utf-8?B?ZmhDL2lXZXR1a3JjV3VwaXlmVjloeVZpMXkzUmZueVVzZFJVT0ZlcGdjZzBZ?=
 =?utf-8?B?VXVsaG5Pd0lGVXBYeUl0N0YwY1FRa2FvSmNiME5YdTREb3NUZTU4R2ZmUkdh?=
 =?utf-8?B?SElabFM0Z1h0SDU3K20zcmdNKytqaSt3QlJ3RlYrTXBHNDI2Mkw4RVllV1I5?=
 =?utf-8?B?L3BSdU16Zk91bGJzeGttK21xQ1I4aGh5alJvWHpVNGhxL3VoK0w0djJXa24y?=
 =?utf-8?B?em1CVzZGbngzaGdjZlppRGxEQ1pCL2ptUXRLWWFFeUphSUV1TSt4OWdoZHgw?=
 =?utf-8?B?bHE3cWxmY1UyWTlCTkt4d2ZFcTUzK3gwZGlnWUtLOHZLV1Q0Y0RmcDNCT0lT?=
 =?utf-8?B?VEY2a0F6RnNBMUp0WWM3N1ZFSEs0VnhqQlE2MjE2YklxMFgzYWFoOS9CVldp?=
 =?utf-8?B?QjBBaU1OVDZ5Ymk4MlNralIvOGF4ditrWkU1UkxnemlldzJXaGZyWVVGcGlI?=
 =?utf-8?B?b2R2dldCNU1LazRsSTRWWEpxbnBKem9nSHI4ZHYzWTFxMFFJSzRsbmRrWW1B?=
 =?utf-8?B?ak95TDhISStITjhyYUxLWGRxSlJlck5VWHVvNGhBZ2l5NXkzdWd4Zi9xTlVB?=
 =?utf-8?B?czFFTG5wQTRZSlBJMDdEVkxldHhxaHJSMWFzSHQreC9lZkJWaWs3WnM1SGpP?=
 =?utf-8?B?MFV1YllXYUpnbk5sZndSK084alUwTW1lMm9Cdm53RFpLRmRmcHNLY0V5clEy?=
 =?utf-8?B?Y2tWN3FEc0ZDVnVBTkpzM3JlTFkrbWhvUlpSbkROREcvZ0NpZ3hGQ2FITVA0?=
 =?utf-8?B?bWpJLzhvWFMxc1poZ1NKUWw2QSs5WnZFT09uR1lsZ0VmbVFJdVpSd2pPUW05?=
 =?utf-8?B?bEpoSGVaaUpGd3JSOXdlVWdsemNFWGhHNTNVejdtNi80TkR3MnlFaXVSMlVF?=
 =?utf-8?B?MnhSbjFvcUVUS2ovTlRuZVBQNS9MY1VjOXZ0VU9hUUNMQXpmRk5UMnpIVUdC?=
 =?utf-8?B?ODdoVDh2WkxWanBNSGlJZmt3RW00dW1FN3pMa3I5MFlncVZyQXpSS0R3YnRW?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05307E9F07B2874EA3446CF9B5400F4E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Hx++pA9NIbqHG11sG+qzeMpNoYJEJTJEHKwH8qtAxfPoLd2dPcK4IlJMcnAotcAF3EZByCw8XFR9TAks0kayrH9Wn7wMvWqucESlr2ZYN1buyMFhqx6mOVZk+U43a10V0yravLskxDD8C/5FYKBUY2NGaSN2rPYwJ+n99Kdmw5zkeGeZ9yQlwrpzKFDlIi23hXXX6/mcTipoBJ7tp5OHDe/p3AiF/K0eesArpAGYRkmvlwBqyZ/7NFXNMVdzBJjSe49r4mDjPWFRTHU66fIiz3EspHqdaks1ih49wMKeYc12137fNUkDB4VRDtlfykYkFtq5sJKPXJjrXE4Y+N80kIY8w9Z7xf2quSNp/avMFskobs8EpzM8v/QLue+y655H6jmjdhQvOhiBz5+ffwoe1t2nu6p5GxvyxzJMJ8IzjLpQwa1wrqRLSyek09q8I5x4805ozBqIp2jt5eBkbNy6PPvuaiwtNcEB+K4dB6/Hy7cXgSez0jp1f0/E/sLYiEZSE9g4Df4N6t3C04ZWEJ2gxYpInpozwSVZNWkpNU/w2F751dhF+yZ+o0mLxz7RLXOiPtU+bke2Hl6QgM7+MaF5keGAi1eD5DfZr3atm6Z7CVyC2HuvhZThQkf6k1yxqv5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1bc1cf-f30a-479f-4b48-08dc261c836c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 07:31:48.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1im3d5FjD9FE+Zj3zgegncw2jJuEFPD8us+rWFa7RT9ZKs/o3K2cmZcBfdY8YIDFt1TERz4LrDhXI0mA8khf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10778

DQoNCk9uIDAyLzAyLzIwMjQgMTY6MTksIEh1YW5nLCBZaW5nIHdyb3RlOg0KPj4gQmFjayB0byBv
dXIgaW5pdGlhbCByZXF1aXJlbWVudDoNCj4+IFdoZW4gZGVtb3Rpb24gaXMgZW5hYmxlZCwgd2hh
dCdzIHRoZSBkZW1vdGlvbiBwYXRoLCBlc3BlY2lhbGx5IHRoZSBwcmVmZXJyZWQgbm9kZT8NCj4+
IGFyZSB0aGV5IGNvbnNpc3RlbnQgd2l0aCBhZG1pbmlzdHJhdG9yJ3MgZXhwZWN0YXRpb25zPyIN
Cj4+DQo+PiBJdCBzZWVtcyB0aGVyZSBpcyBubyBhIGRpcmVjdCBhbnN3ZXIuIEJ1dCBhY3R1YWxs
eSwga2VybmVsIGhhdmUgYWxyZWFkeSBrbm93bg0KPj4gdGhpcyBpbmZvcm1hdGlvbiwgSU1ITywg
ZXhwb3NpbmcgdGhlbSB0byB1c2VycyBpcyBub3QgYSBiYWQgY2hvaWNlLg0KPj4NCj4+IFRoaXMg
aW5mb3JtYXRpb24gaXMgYWJsZSB0byBoZWxwIHRoZW0gYWRqdXN0L3R1bmUgdGhlIG1hY2hpbmUg
YmVmb3JlIHJlYWxseQ0KPj4gZGVwbG95IHRoZWlyIHdvcmtsb2Fkcy4NCj4+DQo+PiBJZiB0aGUg
c3lzZnMgYXBwcm9hY2ggaXNuJ3QgYmV0dGVyIGVub3VnaCwgaXMgaXQgcG9zc2libGUgdG8gaGF2
ZSBhbm90aGVyIG1vcmUNCj4+IHVzZXItZnJpZW5kbHkgd2F5IHRvIGNvbnZleSB0aGlzIGluZm9y
bWF0aW9uPyBsaWtlIHRoZSBhbGxvY2F0aW9uIGZhbGxiYWNrIG9yZGVyIGRvZXMsDQo+PiBzaW1w
bHkgcHJpbnQgdGhlbSB0byBkbWVzZz8NCj4gSSBoYXZlIG5vIG9iamVjdCB0byBwcmludCBzb21l
IGRlbW90aW9uIGluZm9ybWF0aW9uIGluIGRtZXNnLg0KPiANCg0KVGhhbmsgeW91IGZvciBzaGFy
aW5nIHlvdXIgdGhvdWdodHMgYW5kIGZlZWRiYWNrIG9uIHRoaXMuDQpJIHdpbGwgYXR0ZW1wdCB0
byBkbyBzby4NCg0KDQpUaGFua3MNClpoaWppYW4=

