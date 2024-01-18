Return-Path: <linux-kernel+bounces-30082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908598318ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487012891AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D24249E2;
	Thu, 18 Jan 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WgV8DJR7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u33EaeAw"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8D24208;
	Thu, 18 Jan 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579804; cv=fail; b=H0cz38CYVQRwR3w15JK9WD9RinRzLyC/ENUbsULU6eE2MKz9iLCnh6rwioA0miKlZJIm7QBmujQ/nIpC+YvVn4RCGZgsE4Nb7zIYLci5uv7ZBa5iRel+JGSgUrOz2VGvpAqFUCSureCeEbQd3c2SK0xcCBNo0mDmDPTpvZSNPTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579804; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=utd4ZvDfeTUjH/+IPsUTlt7biQSS5El+PpVVQXvJhLeUgttMKXYiiV3UtaFY6bbre+Otv+p/Zf5kwvvLaHB/KENDWNC01PxKP1kzNEnOMVQE2AXFP6iftcn4XKjjT8pYu1ZG999oO8ytNJ2xky8patWOzntE5X7jKyJEovtZv3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WgV8DJR7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u33EaeAw; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705579802; x=1737115802;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=WgV8DJR76Jq1Q5kS6+u5KbfnfFLGlZkMWXzClhaHLRcYPcO/8cDVo4jQ
   uNDn06GUlWkq/rwV7gSD6evNJP/JLdwaEAipfqDYto7MWZxz2+T1f7Eoj
   5AB5MBKNVa7X4TfSzFQmU03hwp2Ye2Q+lZgki62tpPPFjgbCZF2FzkzLD
   lIujcQAOXk9vjmp8NZzdWGgUggkjro/IjEjrBLAfguB/AmEGkSU906G0N
   GUBrd3ckAzuO9rioE4qNZf1Dr4OM7PEt5OUx8gXc3m9EtwDUwKn1enxmu
   1t2RL4MwJ/XYHUBpEnqSbakHRDZhpT1PiWlMXtPUNhqXm6qxNGOObaAQG
   g==;
X-CSE-ConnectionGUID: f1Fsl78qR2eRMSnAjVNC2g==
X-CSE-MsgGUID: SwSW4UJUSIeKZQM3wJrqQQ==
X-IronPort-AV: E=Sophos;i="6.05,201,1701100800"; 
   d="scan'208";a="7181836"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2024 20:09:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHqOU08lvlWgHL2pGW/yOKN4hgO1sfup6MWaaskVD6jGAV2vFOIxlNMzoATvrNeynvC4s9J6z0ApraNkJuGvwbwSi1mvcO4ih1R927w10g0Bzlub56MBhIOotBZyUw4VLgg2dfLFmw/Rf+WgXZzljJ1wVKDzKvnC4z1o+83mg1KIoqcxP43fWjHTC5x4eSnve5nv5NLzpf0loB1fQNABnQSdbwilMh6Te2uWBSo6f8C2e0Dev15459enfd7a7Di/luQYCr+oLRtIAs/ug2TT7e9mETXoVw1ZHUUCVCJt2DhDgQVcIwOcE7OFNwOY/pJ16HAFFxyQWsRmg+PgIYXiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=TWk5HXsiKa5I8NMDHx/waxbFa5418N+wQZw3jKD1e4TT6nHUoKjGigCiDa4DOlpceJaap/7CTGbUrLStMn1gtjGYEhQxXlydjxc1uAfR798DYTXeFkeI+MV6DTlDJtcSgV/5mcaC2FPa/NqRDma1YfxJKRWHS0pORMJ/nuW06jY3Tw0wdvvpoLwYlS4Xw+XZlO8GEvZOz/6a8NzwL294Sjsbjmur6Lef6ypsN79BGR2JrTCHnJfJTBksorcQoER99lPfIDT4lefMbcYo6u4s5Yfn+vU4ynBtZasy4BQPpOtDWbRxFNFE/IO5JZnixfW1wieNudFSBN37Lnr8B6wfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=u33EaeAw+zxHegIWGvMnU+a6nWt50J0l2+DcrIUHNUR+2ebswkC3E6RSj4vZWSMqhlOK98Nb8TKwwOHOWqjtBbRkUXCL5BDj0ipBO3xnsSfX34VLrZvGkiujntMvdZvGHcNIqB6Q4Eruwux0CsvaNexfjmisCP2MW3Xzwnx3KZY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7159.namprd04.prod.outlook.com (2603:10b6:510:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 12:09:53 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7181.027; Thu, 18 Jan 2024
 12:09:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCHv2] Documentation: block: ioprio: Update schedulers
Thread-Topic: [PATCHv2] Documentation: block: ioprio: Update schedulers
Thread-Index: AQHaSfDqSGkO5F4QdESi0NtmxobcGLDfepkA
Date: Thu, 18 Jan 2024 12:09:53 +0000
Message-ID: <a0a1339e-ee53-4c10-a7c5-44b3f65845e0@wdc.com>
References: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
In-Reply-To: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7159:EE_
x-ms-office365-filtering-correlation-id: eb605326-87aa-4ddc-dfa0-08dc181e610b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Sy6NCbBfKTPe/HEhaE2uPFskbpJMciGofpN5mqdM557tselF0UoM7K4upx06bwu6jbc01Xt/zBIFTL0YcSGTTlkJTZ6uedOwhBZ40sLGTOHoEIU0pJzSS3CRth0xhaqDSVOowRM7dhUNPHCYL3G/h4KTep5m4ggwqmYgcCYYyEJpi/ad2M3FAUmFqd4QUXZHhICGwBcR6Tsh+1hJFp75qHRxMjEBqo5UVysRReCr5w9fl2v19EnEId/ZVeCib3qbTXwPw1Y/7nKaVE7d3Eo8IPgJyxSAXlX9o/HaCCBw8Ut5nfhS6ujk71eUbGSGobhaIwFV+Qf8g6m+MQg0AfFb2rCEEQmUjIN0WpEag7E4W07xyvUazbTmKMNqqputY0bdiICu+3hqh0phodJ0ufYzS+cxNilwG7uNejPtxUl6/+f5jaskjsPUcmORUiN0rh9sCmNtcpUd/eIFosXoZfhoCnAJNRsP1OO8olusyjWnQfQLwtmtl0C/G+cen175ZpIfONGoaRPtHgyTES/7R3p2xVnyfd9n9rTbPIPebubkzl2mpMaLItgvcWVp1vQPCQ2F2JmndXyI58c4oNMKxEEsCp+W85VqzzWf11xUoVSCMpS5hydZRwMrp/x6qXieRIfT2WUfZh0EqKKcDiCCowxdAqgOIdBvZyPKFlt+Ys0IJ+06bAZvr8ws5CvcZtaFZDoQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(558084003)(5660300002)(36756003)(26005)(31686004)(91956017)(31696002)(110136005)(66476007)(66556008)(66946007)(66446008)(76116006)(71200400001)(6506007)(2906002)(6486002)(316002)(478600001)(64756008)(86362001)(38070700009)(82960400001)(2616005)(4270600006)(6512007)(41300700001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0UrM1BEMGxRZmtRMHJyYWp2U09wMU5TaldJVThXblp2cnROZVVhckcyN2ZD?=
 =?utf-8?B?cU5lYjQzOFJHYUVOWFRVUG40ZXdHaEdsaFhvd0lwLzBQT1JPOEZuZXhYZVEv?=
 =?utf-8?B?N3JhVkNWOGl6azdXVFM4K1dFOHBvN045ZzVPaHZiWURnRXRoM1ZmVmppWlJt?=
 =?utf-8?B?U21jUVMyUjNvcWw1Wlk1ckZmTlhNeGFqaS9ZUWU3d3drWTB0K1QzTVM1YWNt?=
 =?utf-8?B?K1ZYeUJFRWpJZi9aZnI0VGZmOGs5TE9Ec0FHZzV1eXY0aWljaXJ4Um0wMW15?=
 =?utf-8?B?MDkwZUJncmxMSDZ2Vm9mRHJ4TldxZzErU2dKVTA5WTBOYnpsSjZSQWcrL0cv?=
 =?utf-8?B?aGNqM3MrVHlqaklYRlFiQ1FZbEJnNTBoK1pQZlhmTjhCTWpxV0pmdHRxTXA3?=
 =?utf-8?B?enBKajN1cHc5dlNncW9mbFdlYXQxZjZ4ZXpyWGVQd0V0Y0NqRjdqZDhVM25z?=
 =?utf-8?B?cDVscUJQUC9RSGNRM3NQUWF3amk1RWhCUElBOXZNYnZ1NDhWRlZvME05RU52?=
 =?utf-8?B?T1dkclF4bEpiQk5Nb1dOUmJEeEtHazhUbklZVlI1cjEvbjJVVnFHeXZuZzB1?=
 =?utf-8?B?TDkwWG1sWVFDbUt0MUwwdmNUajFLNzNudWUxTFUraE92SnVtOTlad0w3R0Rk?=
 =?utf-8?B?OUh5M2tNZkhGMXoxd2FDeTIxaFRGamV5Um02V0pseXdPZHdLTEVUYTcxVitG?=
 =?utf-8?B?MnJ2YW93UmFQcmpWQWR2T1NBSWxMQ1BmL1ZialdhZlJra3A5ZTlOR3Z6RXc4?=
 =?utf-8?B?VnZHTWFxYS9TaWphQ2Evci8vc1QrMTFGQ1FVMVY2SXRvWlJ1ZkZQY0Q3Z3Vm?=
 =?utf-8?B?UjhRVGlMaS9MMFVIQm5uczdpL1R2VHFGeTBWMEpoMWNjaWlFaWRhS2lKWGI2?=
 =?utf-8?B?QnhxdlhPTkw3THU4WnNnZm54UUZaQk1WRDZDd2VqcWdYYTZhbzRIenhhK2hG?=
 =?utf-8?B?Q0xVR2lveGhBcUtGY25mSVVidDl0NEM3VVZOQ1Z0K2JCQ05BdUtqam5LSG9k?=
 =?utf-8?B?VGlvNVo2U0FvQStiM3BXUEZLOGR0VHZEdG1ybFR4VzE5L1ppZUhGQTJrR0NJ?=
 =?utf-8?B?d3k3UlNaVjFzclhwRjA3SndrS083R2QyMWtPN2FDMzJ1THlzMjVPSCtWZWd4?=
 =?utf-8?B?Z3BSdUVCS243RVA1cC84ZUY4WVdxUDA3STFUNUNHUm1VRTF4d01ZcVRtdjNM?=
 =?utf-8?B?T3QrRGxpZXEwSGwxNjhIb2JLenVMOFY1dnBXZ0hIRXA3bWliY09vSTFoNDF5?=
 =?utf-8?B?eUVreFFlYUdESU1ENmg1OUNTWm1FdjZKcVAwYkhoSWlLYW9FMmVIOFBaSkNq?=
 =?utf-8?B?eUdGTDhrRExPTFhGZXFMRm5OMGJxUmxxbWJjRktUNlpmZWpQTG0wK0UwVmRU?=
 =?utf-8?B?d00ySTBlczMzdEpHbDliUjVwZ0NIWXNyakY1RUdzQVd2eGlkSjQxMVZJR3Ns?=
 =?utf-8?B?Qmd0V0t6VWhSMkhqT3VqVEFwdmd4b292dWZ2ZzJSTjFyYW5SU3F3bnJ6dWdG?=
 =?utf-8?B?VzBoclcrTHlWOUEyZnkxb3FndGZyY0ZIUk1ZM2YremROck1vT2Z1ZDQvR0o5?=
 =?utf-8?B?eG80cktlL1JaaUtzai85dFZlSWZzRUFhSmwzZjM4UFBpZDVJVU5BZlNCRnFs?=
 =?utf-8?B?bUU5a3ptdXA5d0ZySU1zazc4U2pOc1d6N1dmdWZqVWxQUlNVSHBwdWRmaWRz?=
 =?utf-8?B?SjBUeUM4d3VaenNLKytscEtaQjFSZm5JZWdYdnRhWkdBR3R4NnJnYWcvejc3?=
 =?utf-8?B?U0xmRXdmU2ZDQ2c0a1llUy85RGgxakhxbTNGRGhoN2U0d1BMTEp5SzJYeDQ3?=
 =?utf-8?B?ODJQYktEVk1xWjJQd2V6eDIxVUdSSHVKcktQMVluY2loTmU2S3VDcWpXOGNv?=
 =?utf-8?B?YTROVTR1Z3BQUFAxVHBWTXNIRXdKZ2F5VWFsaXRVUEhwbVF5WkNNbVMrdkw4?=
 =?utf-8?B?d0V3d1lZcjA0aWtmTzFrRG9IOHBxc2EzNDBWNG9LOXJKYklGRkpDeDhrQi9z?=
 =?utf-8?B?Tjd4d2FMOExnMmN2eEdxU3AzVjhtQkF1K2ExVnAvazNhbWRYcG5JVm9IV0dP?=
 =?utf-8?B?R1FGT1JPeHQrUWpreXVzbXMyUzlPbUp6Zmd0cDRBOWJweS9jekh3ZzFFRWxQ?=
 =?utf-8?B?SVpISnZGbk04SXdTYnBRdHRyTnNNbTRyMlpOMmJuelJiWnVvVE9KaDdnVUZo?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD2F2FF7EC75324DA7472971758ADF4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m/rwWXhMPBrNA62hwDt4cMB37ewiiveakwf0aFs4QJgxhBmZFLAnOaLSI8Q/ShVl0kbim/0SAt8Dp6HB2O/1SRXQeG5e7x4EePFP1GxmJBKVKbEcTZBEVcvBBYsr2jTNkuGvIXx12Te+abvx30A3QqbItStepOqu43BZeaujbML2RB85frlKa6MP3ZX1el/8eC6GJNCg/G+Jr9X6QMM1w+Wa0PhlLBx9N3Bgkh4M/cNjyY7pDc/8YggVaiXrby4UbxXgsYTEdHJ4zuW0roD1IsQ55C1KYZV1HWp3J0QLuhDXG4whQunKwsmC83ryCdcVPRPR0kiSoE7MIx6lXUQSlwyikSmNhW4OsuJqumjBLRuupPHYbJKZnFChNvMqWw9NuSsQLl6/vCrsKy/+jcHW5TaKdTTjXVsHo1FZMOZyg/RcufmEXqN3LtcwG/rWHhQ1EEqs1BVOikVPN4wV8rnzwY3h62C0Y8cfkN2WrHItpW/QRJxTqYLBArL2YeGBVZqLQwhNAIUDXXvw9gEr/ultKmHL9jWXL7re+TvMB/4yYth0LPk6grqte347Kg0DGznksq6fb4NwhbheXDMTwef/8qozpz9hoi8zIDVp4cs2gZzOTIFJLKnB9F5K4b8pRM+D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb605326-87aa-4ddc-dfa0-08dc181e610b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 12:09:53.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3n0T0vs22R5mvMVWk6YN8JtFW7GZg9qi1OGQTv9r5QfNUuN0/ANC1aVnVI9Qcdxs6EqdUA67kcf+Ts95aHOZyNywk0Sy4RsZ/zUsSTIhiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7159

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

