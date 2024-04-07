Return-Path: <linux-kernel+bounces-134158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5C89AE59
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759D9282BAF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA61876;
	Sun,  7 Apr 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="R5BGUFQ+"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8681C10;
	Sun,  7 Apr 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712461984; cv=fail; b=JxwIpefAGwolrsBw86mj59q41HOADhTJcvoc5VGp4YE3OZ5SbHmg9pVdfwGex7qo/JUn8Tf6EZpgN4WmNggz7bpiQTZ5l8AhjCXLKy1kNzV/iu9ExsX+2uyn6AxIoCJNnUJw57BMhYvMvdWWQB96r5dTxvPWG+AinvCUlVDt960=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712461984; c=relaxed/simple;
	bh=+/rZef1YH7Pu3i3L341Y+3Mo1A+ec2pNzrAwdIvxMbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erb6iKSCbxfi/6sC5Tiddv0vaxBD47119H6YDQyeVC72zPjYVX2GYDE+h0dnM0tDxBXj9Oty90B+zMvADupJkFiik77MVcVtGden/iwsFIgpRhezmHuogn4vgx5DQkUyEPqcf/bD4PDPdOsVIP9kUARYKBnXN/g0xdOPZ+/Linw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=R5BGUFQ+; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712461981; x=1743997981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+/rZef1YH7Pu3i3L341Y+3Mo1A+ec2pNzrAwdIvxMbE=;
  b=R5BGUFQ+zXSHM2vNwho/5A+fj2Nb4543/SZQSo486YEBAbfdafpqEwlM
   oftpJjaophfhVBOxuUDZ4LQsNpkUGLp9C7vdRcOt6MKs81fLwmwQHkwcI
   NqK8DLcRwp3ZrigCcy9V12r1XIII1T4Ge18/s+5So46QoA5mrfWpQQ4Rq
   L9H17rqX5AACqrLvW61mda+Ist73dYMfqHT9yS8IbbP0J0k5RiAhyXrIZ
   rM3mkNrs73JKhwaJmYi5SLSKfqiRVyly2gItb2fZZoDPsGnmQnYlgA/fa
   6bTr8S75RMU7aJrISGuggeVM4KwVpHLDG4u+W2RpvcO9nzPfMwPC+jYUx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="115737716"
X-IronPort-AV: E=Sophos;i="6.07,184,1708354800"; 
   d="scan'208";a="115737716"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:51:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8MyNj3T2aVsxE4eLId/ckCl2fS+Z9JKeHhc23BLqXontIRcfnHBQUdgidNagZuuIeVZCSnMloisCauUJ1xu3aiwygB1oTSLn1Qs/1+LQ8/UDsBBiFH4rLd9dDDfjCyzQ5NmkseHRxFdLOZZthAZI/KdkMYc639JpUUjuqzhipJRAM4zEQkLnFVHoezoc1u2emfZd5x/nQPeVRZ6MTwxRMsyzI2R/1rFS1Ki7VGFItXWcrJcwwfVKHXRUtA+er2Y7fQoKa16D/yBom2h2OQLg5N6ACDxt8M8mIgrOisXPCE4lol79Wkjrwanx+uP+BJ147DTaMuosn4hjqxh6tUjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/rZef1YH7Pu3i3L341Y+3Mo1A+ec2pNzrAwdIvxMbE=;
 b=JRlnOwdbMYSGtAIyH7mQApEiP4vlWWbQxrvlSz0GaJoS71gGolxxad9xQlm6BALZME4Ue3TQWtA8z1AL+Z2ZRvpYdnzF8HML6h0otHeABFtdWd32BMBQivVGLJo19XXZrx0fR1ic7J+PHPo/gtQxDDYY8P9cNwQ4km7US3PYnGacEvUwgm4MDbrgZS6jNTtSbl65RxiTu9jcNb0B0OM6GeDVJ3JPEVbGZwLzTIB+8HefYrIFhimXLL4s196wt9u5+yuCNNLkrDc3C2M69TbymUkaj4u5xg+rjp3C+XTi9h+E52j803XyUJxysq5fc4pfzI/sd9Mj5Wk9Lmiz1vREbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS7PR01MB11964.jpnprd01.prod.outlook.com
 (2603:1096:604:23e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 03:51:42 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 03:51:42 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Subject: Re: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Topic: [Problem ?] cxl list show nothing after reboot Re: [PATCH v2]
 cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS
 window
Thread-Index: AQHaYPF+guY7ES5MRk+p0kfVt2bmsbFDTJAAgAagGoCAEEYNgIACSTEA
Date: Sun, 7 Apr 2024 03:51:42 +0000
Message-ID: <df850be7-a9d1-4737-bc64-3fb682cd5691@fujitsu.com>
References: <20240216160113.407141-1-rrichter@amd.com>
 <b0f5e2ce-d39e-4a8e-8f2f-ffa67b604e02@fujitsu.com>
 <24b8b11d-a7ec-42ce-9fa6-8a24701cfe46@fujitsu.com>
 <20240405175711.000032c4@Huawei.com>
In-Reply-To: <20240405175711.000032c4@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS7PR01MB11964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Prg2CJ8MEaFRsbKMkrMcDs1b3OoSlrRbfcGc3pm9VDuJk2r+64Rbyyedd0emyn81eXbTSXNNNXVQ62SNvTcA3Dic/UGn6HyOeM8zUkj2o3g7rL+EpgAT2IG2jFOI4f+DBqMD3kezN0tdl4lk5IY91f5jXDEEs52XiBMX27WHHrccf/fY+9TtufT2xVKLRtcTRXJMp+y8pIr+tLchpCmKnrTH/QIJeq9PY06pxzFs0INAE++GiDAAxYds2IPvLekEh617Wzy5Oqou6IXHde/XGl9JmZ07ZeY8jvi5KAtKFSE7lr27hJY9vFbfI+rOqWJGoCl0hnzD/fUjFHPLK2INczcC8dUl619NCqfkeD67tbEyB1cSwQ+jEgs15ST2W+53mXk7dqBRB4X65doQDSG2BbhLIgBaSH3LeGN38knYE1vB+T+VWT6zCD1v59VEvUzPZH0KHVt9AuS6s0uAfpvuK80SZgm+42BEDR3DKJk4jZXni68FKc6PQVI6z81JVqxjYIUf1wW4FB+M0b51vSzWaH+EMagKlxi/NmS/t9isBUk2w8AxnDe8tYvGrieYQZdJ1wt0+WrSZThfPRRJwPmA2T/JdeYJBP2XgmR4vkpICLkKHGUex/rGiNB6ybfy0sJ6DCy7bjdIDckFozB2KLmmMFkPHHDFUpNF+jMRnZF+/EGpvU121cRkvK5d6bWqb2PhvUIFVg8Lz71P4yylu+n/ng==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnpMbWRmKzlDTGhad3Y3NHp3dEpEMU5USnlHdDVMQVRjcmV5Vys2Q0JjMkd5?=
 =?utf-8?B?YXMzRzhpSXM4NnRRUGtPelRIYWEyOU9ROVFxSnpWMzZIUU4zek1TUFZUTHVG?=
 =?utf-8?B?WkRtL3hSeXFTejFteVREankrQ0ZURllxRjM2RW0yOG5xZkJVaGs4VXFMNnAw?=
 =?utf-8?B?SDk5bW92dmhMdVpEZ09SL2lhWmRmMEhrbHlITDdmMlE2WWRhbEFtUjR3L3Jh?=
 =?utf-8?B?K0Y4Z3pVWmoxdXQ0K3NTS1RiQ3pmaVh0UjNnSlVuV01lcEhYekZ0czVDUS9n?=
 =?utf-8?B?aE1FTG5ma1hkZ2hCN3Zab01oTzluRVFnQ1J0cUFIOUV3UTkvNlV2aU1LVXhx?=
 =?utf-8?B?SW5YT1hqTi9KbUVDTkdpTGJLQWlZZ0NvOWZYbitjVDhZSmNmNWo5Mzd1Qlpp?=
 =?utf-8?B?TUVPUkxFMzhhNTNVcDFwQzhtUGlPM2xvYURleXQ5NWVSbGpZeDJzNmhPY1Jl?=
 =?utf-8?B?L21MMjVPdHo5NlZpUWxvK3NsMVk0bFNSZHRQMFZBR2JVT2VNQkJnOWRiK2kw?=
 =?utf-8?B?cjh5ci94eVNnMnZ6RXhNUllyaDgwZ0I3VGhSVFJZczF6UmNxWlJwWVRwSk1F?=
 =?utf-8?B?YVltLzRTdDRzdnpqcG9OU25QcU11U3VWamNZMG1RYmJWTGxScU9CNHJaS0F5?=
 =?utf-8?B?N0dDWk9MYVQ1Y1A2L1p0Y0lyeklXZEc3dGtnRnJ1bXBwdXlPOStGTkJLUW84?=
 =?utf-8?B?bVpBR0x3dDJjWTFJRHBzcitCdzUrSmhTd3A1bk85ZmQrWkNZYTdMSTAzK0tq?=
 =?utf-8?B?V1ExWC9MSllESktybnhneWRMZWdNdHkvT2Y0SUx1K2QzaXFrdjNFTm03NkV4?=
 =?utf-8?B?bEttRGxmU3VyTWNLcWRMbkZhK3pMMFptbWFOQWFNN1g1YzJOWVgySlBRVWda?=
 =?utf-8?B?dDRYdGg2WWFYeVMvaHVHQ21LMkxKN3AyMDVRcTdFcXluMVRrMjg4TWFkRXlj?=
 =?utf-8?B?VHg2UUVxTUNDYlR3U1h0bTFkQ1FMcmM5UjE3VVh5UjlPdk5xZW5xYTdFT0U0?=
 =?utf-8?B?TWVqMWtCZ09hclltVzdNaXN3eWZOdXc1N1lRbXVjTytaR2wyTFQ4bmtTSzRi?=
 =?utf-8?B?SWRkUnJXbzZyUEFZUE1DYkI2OEpHSGQrcUFyTFF6NVkxbVc2MmdKeWN3Slgx?=
 =?utf-8?B?V1NQa1dBUDJTK005MUMxbmVzSm4waUlHWVZuTnZTV1VvRW1yaXVFV1Fibkc1?=
 =?utf-8?B?YjVDQlZMWDB3L3NZMXdSVzVkaDFScytjNzRQVjcwamx0TDFiNUpvM3BlNDZG?=
 =?utf-8?B?R3Y2azVNRWZoVGRMNERrN1N4Y0Y3dGZJdHRCSHdVYjJMK2k1NDFzdmJicitS?=
 =?utf-8?B?c004Yk83QVAwaldZVU5DdGM0VUNsSE9SRjhQdTY4dDc0YXVENGZxcmhaODR4?=
 =?utf-8?B?a0pNRTlOelYya1ROcWdSUU8xcVdFcGdxcmxCd2gweEFEeUlLbFBUVUdBL3JD?=
 =?utf-8?B?cllIWEVYRHN0MmpFQnovQ3R1Q0ljK1J6Z3lzWGdvd0kvdTNwTlhWMDlvWUI4?=
 =?utf-8?B?dmY2TmlLNm5iUnNraGlkNDlGU1pSbEphUGt3ek9WanF4TmVsZGR3QlphU3hl?=
 =?utf-8?B?SXlvdjZPRVRKS2FtSWIvVGc1V0E3bjRvY3Q0T2c5T2VIaU10cnltOUdYVmh3?=
 =?utf-8?B?Sk1Fa3ZqaFpsWXpaM1JqWnJFcEZzU05xWEUwSVZHK25zTGFwdWYwZFpWRDY4?=
 =?utf-8?B?RWVLOHlkRFAzQ0IwYnc3aWlLbTlCVXlXQW1IcC9PWTJCRTJ0QUtrZ1A5am5v?=
 =?utf-8?B?RmJaaEdIOWlEakN6RHNDa1dYRVlNbjFMZHZPOTQvSVI1VVU2SzM0ak82cnN1?=
 =?utf-8?B?SDNLTW9QZFRCdmdEd2lsaHQzek5FWUVXcW0zbEhSQUg2NEpwWlF4ZDdMemFp?=
 =?utf-8?B?UzhncEhEQVlnb3lZUDRXbWNPa1N3TEpvRU10eFdrYTBMdkZUc095WFlKZS9J?=
 =?utf-8?B?K0ZtN0ZER3RsaTI4dTIxMXQxVHRwK3YwVUxVclVDQkZlcnROWGpDazAwTFdK?=
 =?utf-8?B?dDVTTi85OWFXRmd6SURlYjUxUWlQc1VRK2J4VmtwTzVsN3ZKeWwxZWc5N0FG?=
 =?utf-8?B?QWYxMHYxYUM3Yk5TL0hkUDNGTUIxTW5ZMysyb2FEUE91blFNQVl2cFFjZ2U1?=
 =?utf-8?B?TGE4NGUwcTc4TE9EMVhHNFB1MGMyVllrYXlsaG10aTI5QXhEbXFoQW5ZVWxn?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0532DB171D5E2479D918F00C068D245@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HpDjQkr3BWB1Znyv7tazTUbQQvBeFgsLVg0ixlAm6APv7LwtSHA3gxusVJGU5b8p82EuErcJSJoDFux9dlKz5N9L7Bt5vgS7QjgM57yQqPb+5NV1x3+VotsqBHIppFceE8bQRMtC0IBNOlaGPmimaq83sDDSpe4AwK1Hb2uJOouO0JqEz0V2oBuLs6JdAGwp4Ewffl9OwuLuyk+t4YDJb16UZ99w1Zpv06Y7M2pLQ1ulwVgXGAmsGC27278/jeXl/EOSnBd/6rK43iKhywS0WiwRh1OBclnSD3O19XkR1wBTrql6X/PbD+mDzJfTsVA9SstFBinc+0Dofxyhb3INDM0rKQ1XDI45cPlNPpzYNtHjZ5ev9+OIqah1bAi7PaFAfaLie13DRrBQLYW6gjvszQkWVBs+Oi43XIykoa5ZnTwDeC0KoBEZSLjanQ8EsItxBlCMQx2vkGpJB9ypOPqSHtKbB5xo38SRF9s2ySAafja/v0iG5nj2R8mxRA1sxxrZdsBV+k200TL0TroCv5RVHCCv4QPgrofIRpXUyBaI2+YdezADh3EW0ZIQuayM+nKcoJRX7YK9UjRoWIPSBmvUuQ/hOCC+KZeR+HipotXWT4eFQB8RrMTs3JEfM5azgfBT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ca6c5-edff-48a2-4978-08dc56b6097a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 03:51:42.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eATEclj69lwKJVmVf/EWUnaKmJRcxeEc2sdLDgUAjziBFbUfDrzdxK2xkXt+LMLynHd1l+7RW3OAPGMHdgOhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11964

DQoNCk9uIDA2LzA0LzIwMjQgMDA6NTcsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFR1
ZSwgMjYgTWFyIDIwMjQgMDg6MjY6MjEgKzAwMDANCj4gIlpoaWppYW4gTGkgKEZ1aml0c3UpIiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBBbGwgZ3V5cywNCj4+DQo+PiBJ
biBvcmRlciB0byBtYWtlIHRoZSBDWEwgbWVtZGV2IHdvcmsgYWdhaW4sIGkgaGF2ZSB0byBtb2Rp
ZnkgdGhlIFFFTVUgc2lkZQ0KPj4gd2hlcmUgaXQgcmVzZXRzIHRoZSAiRFZTRUMgQ1hMIENvbnRy
b2wiIGR1cmluZyByZWJvb3QuIEEgZHJhZnQgY2hhbmdlcyBpcyBhcyBiZWxvdzoNCj4+DQo+PiBQ
ZXIgOC4xLjMuMiBEVlNFQyBDWEwgQ29udHJvbCAoT2Zmc2V0IDBDaCksIERlZmF1bHQgdmFsdWUg
b2YgQklUKDIpIGlzIDAuIFNvIGlzIGl0IHJlYXNvbmFibGUNCj4+IHRvIGhhdmUgYSByZXNldCBk
dnNlY3MgaW4gUUVNVSBkdXJpbmcgcmVib290Pw0KPj4NCj4+IEFueSBjb21tZW50cyBASmFuYXRo
YW4NCj4gDQo+IEhpLA0KPiANCj4gU29ycnkgaXQgdG9vayBtZSBzbyBsb25nIHRvIGdldCB0byB0
aGlzLg0KPiANCj4gV2hhdCBhcmUgeW91IGF0dGVtcHRpbmcgdG8gZG8/IFVzZSBhbiBPUyByZWJv
b3Qgb24gUUVNVSB0byBjaGVjayB0aGF0IHRoZSBmbG93cw0KPiBtZWFudCBmb3IgQklPUyBjb25m
aWd1cmF0aW9uIHdvcmsgLSANCg0KDQpUaGVyZSBpcyBubyBkb3VidCB0aGF0ICp0aGUgT1MgcmVi
dWlsZHMgdGhlIHN0YXRlIGNvcnJlY3RseSogaXMgdGhlIE9TJ3MgcmVzcG9uc2liaWxpdHkuDQpQ
cm92aWRpbmcgdGhlIGNvbnNpc3RlbnQgZGV2aWNlIHN0YXRlIGlzIHRoZSAqRGV2aWNlKidzIHJl
c3BvbnNpYmlsaXR5Lg0KDQpTbyBvbiByZWJvb3QsIHRoZSBkZXZpY2Ugc2hvdWxkIGhhdmUgYSBj
b25zaXN0ZW50IGRldmljZSBzdGF0ZSB3aXRoIGEgZnJlc2ggYm9vdC4NCk15IGNoYW5nZXMgaW50
ZW5kZWQgdG8gbGV0ICpEZXZpY2UqIGVtdWxhdGVkIGJ5IFFFTVUgcHJvdmlkZSBhIGNvbnNpc3Rl
bnQNCmRldmljZSBzdGF0ZS4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiBpLmUuIHRoZSBPUyBy
ZWJ1aWxkcyB0aGUgc3RhdGUNCj4gY29ycmVjdGx5IGJ5IHJlYWRpbmcgdGhlIGN1cnJlbnQgc3Rh
dGUgb2YgdGhlIGRldmljZXM/Pg0KPiANCj4gV291bGQgYmUgZ29vZCB0byBmaXggdGhhdCBjYXNl
IGJ1dCBJIHdhbnQgdG8gY2hlY2sgdGhhdCdzIHRoZSBhaW0gYmVmb3JlIGxvb2tpbmcNCj4gdG9v
IGNsb3NlbHkgYXQgdGhpcy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4N
Cj4+DQo+PiBbcm9vdEBpYWFzLXJwbWEgcWVtdV0jIGdpdCBkaWZmDQo+PiBkaWZmIC0tZ2l0IGEv
aHcvbWVtL2N4bF90eXBlMy5jIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+PiBpbmRleCBiMGE3ZTlm
MTFiNjQuLjMxNzU1YTlmOWFhYiAxMDA2NDQNCj4+IC0tLSBhL2h3L21lbS9jeGxfdHlwZTMuYw0K
Pj4gKysrIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+PiBAQCAtODk5LDYgKzg5OSwyNiBAQCBNZW1U
eFJlc3VsdCBjeGxfdHlwZTNfd3JpdGUoUENJRGV2aWNlICpkLCBod2FkZHIgaG9zdF9hZGRyLCB1
aW50NjRfdCBkYXRhLA0KPj4gICAgICAgIHJldHVybiBhZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBk
cGFfb2Zmc2V0LCBhdHRycywgJmRhdGEsIHNpemUpOw0KPj4gICAgfQ0KPj4gICAgDQo+PiArc3Rh
dGljIHZvaWQgZHZzZWNzX2N0cmxfcmVzZXQoQ1hMVHlwZTNEZXYgKmN0M2QpDQo+PiArew0KPj4g
Kw0KPj4gKyAgICAgaWYgKGN0M2QtPnNuICE9IFVJNjRfTlVMTCkgew0KPj4gKyAgICAgICAgcGNp
ZV9kZXZfc2VyX251bV9pbml0KGN0M2QtPmN4bF9jc3RhdGUucGRldiwgMHgxMDAsIGN0M2QtPnNu
KTsNCj4+ICsgICAgICAgIGN0M2QtPmN4bF9jc3RhdGUuZHZzZWNfb2Zmc2V0ID0gMHgxMDAgKyAw
eDBjOw0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgY3QzZC0+Y3hsX2NzdGF0ZS5kdnNl
Y19vZmZzZXQgPSAweDEwMDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvLyBGSVhNRT86IG9u
bHkgcmVzZXQgY3RybCBpbnN0ZWFkIG9mIHJlYnVpbGRpbmcgdGhlIHdob2xlIGR2c2Vjcw0KPj4g
KyNpZiAwDQo+PiArICAgIG1lbWNweShwZGV2LT5jb25maWcgKyBvZmZzZXQgKyBzaXplb2YoRFZT
RUNIZWFkZXIpLA0KPj4gKyAgICAgICAgICAgYm9keSArIHNpemVvZihEVlNFQ0hlYWRlciksDQo+
PiArICAgICAgICAgICBsZW5ndGggLSBzaXplb2YoRFZTRUNIZWFkZXIpKTsNCj4+ICsjZWxzZQ0K
Pj4gKyAgICBidWlsZF9kdnNlY3MoY3QzZCk7DQo+PiArI2VuZGlmDQo+PiArfQ0KPj4gKw0KPj4g
ICAgc3RhdGljIHZvaWQgY3QzZF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KPj4gICAgew0KPj4g
ICAgICAgIENYTFR5cGUzRGV2ICpjdDNkID0gQ1hMX1RZUEUzKGRldik7DQo+PiBAQCAtOTA3LDYg
KzkyNyw3IEBAIHN0YXRpYyB2b2lkIGN0M2RfcmVzZXQoRGV2aWNlU3RhdGUgKmRldikNCj4+ICAg
IA0KPj4gICAgICAgIGN4bF9jb21wb25lbnRfcmVnaXN0ZXJfaW5pdF9jb21tb24ocmVnX3N0YXRl
LCB3cml0ZV9tc2ssIENYTDJfVFlQRTNfREVWSUNFKTsNCj4+ICAgICAgICBjeGxfZGV2aWNlX3Jl
Z2lzdGVyX2luaXRfdDMoY3QzZCk7DQo+PiArICAgIGR2c2Vjc19jdHJsX3Jlc2V0KGN0M2QpOw0K
Pj4gICAgDQo+PiAgICAgICAgLyoNCj4+ICAgICAgICAgKiBCcmluZyB1cCBhbiBlbmRwb2ludCB0
byB0YXJnZXQgd2l0aCBNQ1RQIG92ZXIgVkRNLg0KPj4NCj4+DQo+Pg0KPj4NCj4+DQo+PiBPbiAy
Mi8wMy8yMDI0IDExOjE1LCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+PiBSb2JlcnQs
IERhbg0KPj4+DQo+Pj4gSXQncyBub3RpY2VkIHRoYXQgJ2N4bCBsaXN0JyBzaG93IG5vdGhpbmcg
YWZ0ZXIgYSByZWJvb3QgaW4gdjYuOC4oQSBmcmVzaCBib290IHdvcmtzKQ0KPj4+IFRoZSBnaXQg
YmlzZWN0aW9uIHBvaW50ZWQgdG8gdGhpcyBjb21taXQuDQo+Pj4NCj4+PiBIYXZlbid0IGludmVz
dGlnYXRlZCBpdCBkZWVwbHksIEknbSB3b25kZXJpbmcgaWYgaXQncyBhIFFFTVUgcHJvYmxlbSBv
cg0KPj4+IHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoaXMgcGF0Y2guDQo+Pj4NCj4+Pg0KPj4+IFJl
cHJvZHVjZSBzdGVwOg0KPj4+DQo+Pj4gMS4gU3RhcnQgYSBjeGwgUUVNVSBWTQ0KPj4+IDIuIGN4
bCBsaXN0IHdvcmtzDQo+Pj4gY3hsIGxpc3QNCj4+PiBbDQo+Pj4gICAgICB7DQo+Pj4gICAgICAg
ICJtZW1kZXYiOiJtZW0wIiwNCj4+PiAgICAgICAgInJhbV9zaXplIjoyMTQ3NDgzNjQ4LA0KPj4+
ICAgICAgICAic2VyaWFsIjowLA0KPj4+ICAgICAgICAiaG9zdCI6IjAwMDA6NTQ6MDAuMCINCj4+
PiAgICAgIH0sDQo+Pj4gICAgICB7DQo+Pj4gICAgICAgICJtZW1kZXYiOiJtZW0xIiwNCj4+PiAg
ICAgICAgInBtZW1fc2l6ZSI6MjE0NzQ4MzY0OCwNCj4+PiAgICAgICAgInNlcmlhbCI6MCwNCj4+
PiAgICAgICAgImhvc3QiOiIwMDAwOjM2OjAwLjAiDQo+Pj4gICAgICB9DQo+Pj4gXQ0KPj4+DQo+
Pj4gMy4gcmVib290IFZNDQo+Pj4gNC4gY3hsIGxpc3Qgc2hvdyBub3RoaW5nIGFuZCBoYXMgZm9s
bG93aW5nIGRtZXNnDQo+Pj4NCj4+PiBjeGwgbGlzdA0KPj4+IFsNCj4+PiBdDQo+Pj4gICAgICBX
YXJuaW5nOiBubyBtYXRjaGluZyBkZXZpY2VzIGZvdW5kDQo+Pj4NCj4+PiAuLi4NCj4+Pg0KPj4+
IFsgICAgNi4yNDkxODhdICBwY2kwMDAwOjUzOiBob3N0IHN1cHBvcnRzIENYTA0KPj4+IFsgICAg
Ni4yNTgxNjhdICBwY2kwMDAwOjM1OiBob3N0IHN1cHBvcnRzIENYTA0KPj4+IFsgICAgNi40OTA1
NjhdIGN4bF9wY2kgMDAwMDo1NDowMC4wOiBSYW5nZSByZWdpc3RlciBkZWNvZGVzIG91dHNpZGUg
cGxhdGZvcm0gZGVmaW5lZCBDWEwgcmFuZ2VzLg0KPj4+IFsgICAgNi40OTQyOThdIGN4bF9tZW0g
bWVtMDogZW5kcG9pbnQzIGZhaWxlZCBwcm9iZQ0KPj4+IFsgICAgNi41MDYwNzJdIGN4bF9wY2kg
MDAwMDozNjowMC4wOiBSYW5nZSByZWdpc3RlciBkZWNvZGVzIG91dHNpZGUgcGxhdGZvcm0gZGVm
aW5lZCBDWEwgcmFuZ2VzLg0KPj4+IFsgICAgNi41MTUwOTJdIGN4bF9tZW0gbWVtMTogZW5kcG9p
bnQzIGZhaWxlZCBwcm9iZQ0KPj4+IFsgICAxMi4xODExODhdIGthdWRpdGRfcHJpbnRrX3NrYjog
MTggY2FsbGJhY2tzIHN1cHByZXNzZWQNCj4+Pg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4gWmhpamlh
bg0KPj4+DQo+Pj4NCj4+PiBPbiAxNy8wMi8yMDI0IDAwOjAxLCBSb2JlcnQgUmljaHRlciB3cm90
ZToNCj4+Pj4gVGhlIExpbnV4IENYTCBzdWJzeXN0ZW0gaXMgYnVpbHQgb24gdGhlIGFzc3VtcHRp
b24gdGhhdCBIUEEgPT0gU1BBLg0KPj4+PiBUaGF0IGlzLCB0aGUgaG9zdCBwaHlzaWNhbCBhZGRy
ZXNzIChIUEEpIHRoZSBIRE0gZGVjb2RlciByZWdpc3RlcnMgYXJlDQo+Pj4+IHByb2dyYW1tZWQg
d2l0aCBhcmUgc3lzdGVtIHBoeXNpY2FsIGFkZHJlc3NlcyAoU1BBKS4NCj4+Pj4NCj4+Pj4gRHVy
aW5nIEhETSBkZWNvZGVyIHNldHVwLCB0aGUgRFZTRUMgQ1hMIHJhbmdlIHJlZ2lzdGVycyAoY3hs
LTMuMSwNCj4+Pj4gOC4xLjMuOCkgYXJlIGNoZWNrZWQgaWYgdGhlIG1lbW9yeSBpcyBlbmFibGVk
IGFuZCB0aGUgQ1hMIHJhbmdlIGlzIGluDQo+Pj4+IGEgSFBBIHdpbmRvdyB0aGF0IGlzIGRlc2Ny
aWJlZCBpbiBhIENGTVdTIHN0cnVjdHVyZSBvZiB0aGUgQ1hMIGhvc3QNCj4+Pj4gYnJpZGdlIChj
eGwtMy4xLCA5LjE4LjEuMykuDQo+Pj4+DQo+Pj4+IE5vdywgaWYgdGhlIEhQQSBpcyBub3QgYW4g
U1BBLCB0aGUgQ1hMIHJhbmdlIGRvZXMgbm90IG1hdGNoIGEgQ0ZNV1MNCj4+Pj4gd2luZG93IGFu
ZCB0aGUgQ1hMIG1lbW9yeSByYW5nZSB3aWxsIGJlIGRpc2FibGVkIHRoZW4uIFRoZSBIRE0gZGVj
b2Rlcg0KPj4+PiBzdG9wcyB3b3JraW5nIHdoaWNoIGNhdXNlcyBzeXN0ZW0gbWVtb3J5IGJlaW5n
IGRpc2FibGVkIGFuZCBmdXJ0aGVyIGENCj4+Pj4gc3lzdGVtIGhhbmcgZHVyaW5nIEhETSBkZWNv
ZGVyIGluaXRpYWxpemF0aW9uLCB0eXBpY2FsbHkgd2hlbiBhIENYTA0KPj4+PiBlbmFibGVkIGtl
cm5lbCBib290cy4NCj4+Pj4NCj4+Pj4gUHJldmVudCBhIHN5c3RlbSBoYW5nIGFuZCBkbyBub3Qg
ZGlzYWJsZSB0aGUgSERNIGRlY29kZXIgaWYgdGhlDQo+Pj4+IGRlY29kZXIncyBDWEwgcmFuZ2Ug
aXMgbm90IGZvdW5kIGluIGEgQ0ZNV1Mgd2luZG93Lg0KPj4+Pg0KPj4+PiBOb3RlIHRoZSBjaGFu
Z2Ugb25seSBmaXhlcyBhIGhhcmR3YXJlIGhhbmcsIGJ1dCBkb2VzIG5vdCBpbXBsZW1lbnQNCj4+
Pj4gSFBBL1NQQSB0cmFuc2xhdGlvbi4gU3VwcG9ydCBmb3IgdGhpcyBjYW4gYmUgYWRkZWQgaW4g
YSBmb2xsb3cgb24NCj4+Pj4gcGF0Y2ggc2VyaWVzLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAYW1kLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgICBk
cml2ZXJzL2N4bC9jb3JlL3BjaS5jIHwgNCArKy0tDQo+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jeGwvY29yZS9wY2kuYyBiL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4+Pj4gaW5k
ZXggYTBlN2VkNWFlMjVmLi4xODYxNmNhODczZTUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMv
Y3hsL2NvcmUvcGNpLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9wY2kuYw0KPj4+PiBA
QCAtNDc4LDggKzQ3OCw4IEBAIGludCBjeGxfaGRtX2RlY29kZV9pbml0KHN0cnVjdCBjeGxfZGV2
X3N0YXRlICpjeGxkcywgc3RydWN0IGN4bF9oZG0gKmN4bGhkbSwNCj4+Pj4gICAgIAl9DQo+Pj4+
ICAgICANCj4+Pj4gICAgIAlpZiAoIWFsbG93ZWQpIHsNCj4+Pj4gLQkJY3hsX3NldF9tZW1fZW5h
YmxlKGN4bGRzLCAwKTsNCj4+Pj4gLQkJaW5mby0+bWVtX2VuYWJsZWQgPSAwOw0KPj4+PiArCQlk
ZXZfZXJyKGRldiwgIlJhbmdlIHJlZ2lzdGVyIGRlY29kZXMgb3V0c2lkZSBwbGF0Zm9ybSBkZWZp
bmVkIENYTCByYW5nZXMuXG4iKTsNCj4+Pj4gKwkJcmV0dXJuIC1FTlhJTzsNCj4+Pj4gICAgIAl9
DQo+Pj4+ICAgICANCj4+Pj4gICAgIAkvDQo+IA==

