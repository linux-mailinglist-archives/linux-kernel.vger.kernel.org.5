Return-Path: <linux-kernel+bounces-156976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277208B0B11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916B31F22FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A815EFA2;
	Wed, 24 Apr 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mc7MDNr7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22715ECF9;
	Wed, 24 Apr 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965595; cv=fail; b=kz+p1dCOjixJvy0KsUUXqsUOjbti7dNPzWCI7XbO55OjmYCFzo59EiJjYAZft2u6G3IDder+qhf3Wqhu/0/zt2tgNud5pAakvJPemM0OVwB5qkUcYYqcEcQrHm6nRYFPgG4fIf20+ozuWl3QKLwW9Cg03GfeOM+eqYLpIYIgiW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965595; c=relaxed/simple;
	bh=/0J27VjdVJYgZMN70wQnEk1L9ld4YWa+Tls/6FkpmTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktFsgZnCjoSNm6iDBsV2rK+lpyu17OkV0yVqh6iZ07eM9kzNS9oXooWSKiRb4VM2k1S3DCBHGmx08qyjViYAeZgslAUPJUC8MsCSB0YvTFGa0T9i3MOQemUzFGGTl5t4WI+gKw+pWQHNK5whG8Ou7YptMgdMLK+BU6/st+SE6R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mc7MDNr7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713965594; x=1745501594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/0J27VjdVJYgZMN70wQnEk1L9ld4YWa+Tls/6FkpmTM=;
  b=mc7MDNr7CW1yKBZoynjQiiB2n7HloaNO51ZhCleL6lHBnVAd3WfYq3lg
   shu2zScUmKabtFTHKqYp7XYiSXUS74bS0cK6fxkerXsvCTSg35Ug2JMlq
   /LAhUoV2r2ZWDv5jWPRSdB9vAUiVdxTJDKq2yAZAMFL+6ild98p9OD7hJ
   aoWd36C1qWrIZG15Khw5YIH5t8+sJg3VHwjFYTvPQE6bheUslFLIZap/K
   AUFUG3LYofO44m5WOB6FMAWVSS3CwI8ctUnc9Wxlw1F61TA7JKObgPjtB
   CtEhWSmpcX1KsyIeLyhZNfL1nzLjoC4N+hS4oWOUiF4XWytz5Qr79HLbz
   w==;
X-CSE-ConnectionGUID: K1jGps6PSd+Xt9RF8epvnw==
X-CSE-MsgGUID: ipPOHpEvTyyE6tmj2TsZNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13385310"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13385310"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:32:47 -0700
X-CSE-ConnectionGUID: AbRzqCtjTe2L/oJDZN7YsA==
X-CSE-MsgGUID: iHivPHyCT9W6fZyie4MnYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="25327886"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 06:32:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 06:32:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 06:32:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 06:32:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 06:32:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSDX9YpLGXxxbkNgJ3cQ+L8vlVB4+LKs3Hizr0CfGeYCVDnu0DTpbe0FlekeNK2oUhwqtr8FfT8bVmzbPfHaF96eOowe0hSmBQUanqWPRH6IQuu/gvFKCJMVnVLC0gHowqrXhE4s/EsoTvrsi6Qg6HXfgW2SI8hBYrG8BV543t7aeBCZf5K7W3nISuHYj8QqQTgfrtOi8MYotOzA2rrKRlCcLDa4zLT0DIX/nK+qlCsp3VyF17ig2NmAiabBMIr92OZL8lrY57xeKtFnfzvQ31QLzmU60u8Vf2PfiCE5IC5kYelb/fjXu/f5Nccz6HBuv/HCWLaca9t3jeiB8Ydwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0J27VjdVJYgZMN70wQnEk1L9ld4YWa+Tls/6FkpmTM=;
 b=ZZXDl51SlpHRNab99F+tupMVVcLgmgoJYdsZPdQJ98evWy8Nqhykl7Kngp3DFaRUxdddjdknmhMuSqa5tkTfShtssKZ/6ylkWTS74U8JaOlHbjY1jF7egqR3Z3pak/LrcfkRAlc+fmWVUTBbWgvGNzynoDHaJJDjCYAivMHLfOFHmfMsktM4kznlVTalKAdFmJ6PzG1l9BHCle2ypi6rZrnZeK+NE/zXh+0jzP818Srr5nRDbAjzOeu/raJmK1pg92BuuPcdrsX+qaR/o9/ZdU8V32km3kTqmpNZ9bAY4ozBBDkVVpkZ/MnjA/dWu3kbvrawcMrZfRbWw2kW6FmZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 13:32:41 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::5627:e6de:5e36:aacf%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 13:32:40 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwGnZ4qOKG40CUyk3on+cyGbFrfA0AgAAIgICAAAjkgIAABZ0AgAJ2DoCAAAXGgIAAEDYAgAZmfACAAGBHAIACkV2A
Date: Wed, 24 Apr 2024 13:32:40 +0000
Message-ID: <c0c4d40546e77f6c4428ed3df1530e74e38ed5ab.camel@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
	 <20240416212216.9605-1-tony.luck@intel.com>
	 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
	 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
	 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
	 <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
	 <f0b67e10b79e7e57846f792a0671434ce20c878a.camel@intel.com>
	 <SJ1PR11MB60834BB7EF162E36DE58D29BFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
	 <SJ1PR11MB60832358E2E243784A57DDFDFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60832358E2E243784A57DDFDFC122@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|IA0PR11MB7307:EE_
x-ms-office365-filtering-correlation-id: 1fe36582-552e-4bf1-62cc-08dc646303db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QTlZM2ltaWYzOStuNC9RdUhaL1ZqV1Z0VUZDdGpyaHZxa2QremtSb0g4WWl5?=
 =?utf-8?B?Z1lScmhMQ3NQSWF0MGN5VmZXK3RNb3RZVFI1UnAwbWhpU0dtdkFLL0JYRWtl?=
 =?utf-8?B?UGVuYmdjdGZ3RjRzVmN0Z0tvK25rRmphWkNJRDNZak51cVBOcExiN1crdTRQ?=
 =?utf-8?B?T3I2Zlgra2xPNFV6d1hDV3VrU0dqV0FWd1RJSGtvbGQ1OWx0OUNpMitFVEIw?=
 =?utf-8?B?UjRadHdWcWg3d0t1aysrVCtVK2R6UnVCMVJkTHVmekdsMmdEcmtYdGVsaWlh?=
 =?utf-8?B?bktCTU80c3BvN3FoSGs4TU9HU1RxUXVLVjg1aUN1Zno3TDF1R3RJMjRoT1VN?=
 =?utf-8?B?bklOM0RzRnRuSWdKQ3IrWXJ3WU16eVg4cC9XWlVyRHJRR2x4ek51OWN3TUxa?=
 =?utf-8?B?WjdYSTlBbUNlclVBTmpEUUFXYUV0MzlVTkpyMzJBNUpFVENqVzdLMlJOR2Fu?=
 =?utf-8?B?dEtRS2VkV3VlQ3B5dFhwS3VmdmczeGlHQVU1QUFXb3ZQek5LQ2N6ZkZMZGpT?=
 =?utf-8?B?ZnNQWFJ3NWxsRDd4Y2NQSDBwckF3SkxUazJJVW1FUnh3a2l6RFFzM0szQ1R5?=
 =?utf-8?B?dTJKVG8vR1RDeUVUREJuQll6Ujh3SS9GVlBoV2JIMVNjemthcTFHcCs4TDJE?=
 =?utf-8?B?ZWs3MDNrN3VKTWpXY25wMk5wRTF0SXFiSTdnWis0eVRPZjRLY2tXZ0MydHlu?=
 =?utf-8?B?ek1xdnhpcnVDaXFlSThMcVY2RUxGYzI4clFtd3BFZGRidzIyQm82UUdydFBP?=
 =?utf-8?B?S1ZtMm50VndoMzRsaThrUWliQnJrVVlrZTFBQzY3em5OR25ZeDE2a2ZSM2hp?=
 =?utf-8?B?THRzSEExZzJpSldDZGxIekllb1hYQ2V1UXJjeWNKUGVQQzhxZytiN1diUlVh?=
 =?utf-8?B?TGlwakZYTFd6WmJEVHpCM0NMVWVjT3FMa3dUa0FkdTFiNmdCVlJVZ2RjQ2sr?=
 =?utf-8?B?S1c0Q0p5dndlYmNCandoMGF2TDVFMFdaR0ZWclR5UTRPRjRmNnpWUi9wTWo4?=
 =?utf-8?B?ZG5EQ3NCRklkenIyRU9lQ2ZBUUMyRzEveXJ1RWtKcno1SGlOSTl3a3A5dVha?=
 =?utf-8?B?SkkveHo2NlB5cm9HSk1RUVdBRlVSc1J6VjlHMFEwY0VJYzFJVW0rTDFLRzJr?=
 =?utf-8?B?R2xLWmhWYnk3SGFHREhsc1QzNURqZTlIaWljVG9jbGxEZ2FQZE5GSTFVVHNS?=
 =?utf-8?B?V2xIUDlzR1dtWGdLSnd4SW03Ui8xRnMyWWkwQUY2UUZoVXhudVhycjUzK0RK?=
 =?utf-8?B?dkdvSjZRWHRlMm1jbVgyKy9GNHh6VXhCdXBRcmZ5WkJSZkFOUUxKaENnKzFV?=
 =?utf-8?B?aEZ0UVdVeCtGRjVnN2xkSWFKci9uTTJUNGlBSVpQMHREZ0x6b3o0Qi9USUxz?=
 =?utf-8?B?ZzVuYzE0djI0enNoN0IyNHVTcDAzcXhGdTRCWFVFZlFvZ0ltR3pId3JFVGFF?=
 =?utf-8?B?aEtrUjJId2NxaUVCNXduZkN4RVUwK28yd2k2UmdZSkh2VDJXTTY4OFlKeHR0?=
 =?utf-8?B?TU1zQUt6dXpvSHdsVXZnckRlNGFpcHZETDUxYTltSXp2MWdLSTJZSVBIeVla?=
 =?utf-8?B?dDRqNzdHMjBnbXhJcFRoSkJWT1d5WkQ1Ri9LdmRVeCtvR2ZKb2ZyQWZ2d1k4?=
 =?utf-8?B?amZoMXVuR1RHNXpyRElwN2Fmckk1bElDSnhBV28wTDNHVmREbitrdW5tbFNk?=
 =?utf-8?B?bXJUWEdzRE5xQmtIZENadHg2V1JsZU1nbVVkM3oweW01Uy9Kd0JxdHlPOEhD?=
 =?utf-8?B?eGNMdkZNR2t6MGNCZVJSS0xkb0dyY2tobGs5OTdIRmlVTGJxallHcTEzWlZQ?=
 =?utf-8?B?d2dkaW5hMWRpSmVyMlI3UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2RUVmRZbDFDeG15ZktQMWY5dHM3aUdpanpLWmdBZXNOckpNTS9uMWYvcEVh?=
 =?utf-8?B?dkowRE1mNGVEVU5taHhLbkVLT1FsY2RtckVCajNoTFBnaHFiYmt1bWo0MFo3?=
 =?utf-8?B?bGk4amNMNGluWG5FTGk3bTFzQmoyNFI4dkpUWk95enY5VWo0a1Qya3VIOFg4?=
 =?utf-8?B?VkdIeXlraUMvN3l3REl2djJGczdtcWtmR1ZwM2dteUJWQlc5S1gvc2doNlZE?=
 =?utf-8?B?TlVKYXJzNXhCcklnMktPbDhoL2NJQTRPelZGVGlsWEhuQyt5aHNBVjV6dGVK?=
 =?utf-8?B?OXRiTEEwVnEzaFFaL0Y3T1p3SG9YNHhqTG45R2pnNGVxWk5kbVJpbHlqckVi?=
 =?utf-8?B?MUJVaGFVS0J6azdXUkkzR1FwQUIzZkNuWGVhZEFnVTNnRHhMOFUybldpSEsy?=
 =?utf-8?B?aDJ4eFlwV0tIbmhobWdCMFRWbGF0cWNJY3h3cGpaOWlpNlF5dlhaQU1ickR5?=
 =?utf-8?B?SnVidXhrQ09oYWlQWjVMMEhybXM1SEtiRWY4dW9OQTJRT0VxSEt4YmVJc3F5?=
 =?utf-8?B?QXRNaHdXS1M0ejc4LzNpaXhiQ3Bpa0pjM1p0T1hmUllId0ZMSENpMVVhYWo4?=
 =?utf-8?B?OWswZWxqMHlLSHZ6UmpEc1psMkIwRXR2d0RKaHlwRHgrUlo4VXBISzJaRVpW?=
 =?utf-8?B?QTlyeFVDNmYwWGlFelhTVmQrWUJKb1pSbGE5R2FPV2VPbXYrQ0EwL1pGTXdF?=
 =?utf-8?B?WnU5M2ZzN2czeXhMY1hja2tSYlNtTjR2dWkzWkJ5YldyWkljTXFKYkwwUW0z?=
 =?utf-8?B?c0tQSjhOK3d1SXQ3TVJNOHl6REtHN3VRV2VuUU9PVFl2Qjh3YXdVeE45dC94?=
 =?utf-8?B?MFJUdk9qM3pVdHBKNUxLakI0NnNidS83dzl0bnBIVmtPZi94dDl1QWR3K25H?=
 =?utf-8?B?ek53eFd0Ylh1Mzd3WXYyVEw2all1cDdoNmpPNU5KRjY0OGpQSDdjZ0hwRFYr?=
 =?utf-8?B?NHFYYmhWUWpYTm1FM3lvYmNZUXAycXNwKzZQTXd0UTl6dUYrNmdBT0F1YldP?=
 =?utf-8?B?R0hrVDE3MGNKOUVuaWx6QnF0bTJ4SUxCS3FkNVRka0NWVkZzS2FNcVV1eGlk?=
 =?utf-8?B?MU9IMk9kaVoySXo4eDFibHFYZGFrKzZ2M3l6dGhtaFBsTXRwZlhHT241aWkz?=
 =?utf-8?B?d09RL0FnY3BxU1BMZU5JNkwyV0I3alVNL2tWM0tFZkpva3Zwc3hsSFJJc1lG?=
 =?utf-8?B?RjY5QTFiMTE2KzdsMXlsSEZNWGJ0UnlQNnZ5b0xoZm9zZXZMWE9XQjA4Zk5R?=
 =?utf-8?B?NEQvOU9mVXVtMThna3I0cHpLdm9WZTFjKzVIcCt5T1orTEJjS2FSZWlFWVBU?=
 =?utf-8?B?MGtwZUZNSUhlWmdqbGRKbEN4ODh5UGxBWVJZN0RVUndQNy9nY0dRSGZJN3pP?=
 =?utf-8?B?MGlvQlVTcTNxNVpWZ3JuRVlmUUFPdXN3Z2RWS3Q4eVpZQWhzNE44YlFrZkZR?=
 =?utf-8?B?dnhpYWQ1N29PZENabi81U3MvYjBTcW9iWXdTcjRjeUxJbjN5c3c0Y05Rb3Nh?=
 =?utf-8?B?cWhrV3NXVW4zWkhXSzZOZmQ5VWJxT055RmF4VGVHMG1YeEppNmpTQVJFNm5D?=
 =?utf-8?B?ZmlkcTVQSkd6ZEwwTWJlYTRIQ0grT282eFI2d0RpeGI4SkxNbm9jOHJtaGhs?=
 =?utf-8?B?MS9CZ0F1SEtQajc2SWJRSEtYZ2JhRWg3VTV4a2NFbFZiWGhXWTBHWlI4cmhX?=
 =?utf-8?B?eWFTRVRuL0ppVzlOK0RNV0podU1FNVU2dFphNjFVelFHbTJRNXhoNDB5ZXZo?=
 =?utf-8?B?YUxONitGQ3BoZmpZODBtanB2WCs5em9sdEJJQ1JsSnNxUDUrdFFQSzA5Mkd6?=
 =?utf-8?B?SEF6V1J4L3RmbUVjclRaMHVlb3hhVlFrR3NYNmxPNmowakxhVk5nWm9VemVM?=
 =?utf-8?B?UnVSTldiY2EvcU85YnNTeitNL1VuTFE3M29mTzJGYWo4dDdmRndIUVkzaFQv?=
 =?utf-8?B?YXVHVkxRSDg5MVhtWDZhcWhqa204M0NTdGVITTVsd1lnWTlPVUorbytUNmU5?=
 =?utf-8?B?NUxaakFnWU1nZzRsK2FDZTBZVGs4eitoRUZWUU0wWVlvMTFvTUdKVjJjcDhE?=
 =?utf-8?B?Y3U3c1pZbFNob0o3Q2hFMHJhRGN1aVdIQTVoWkxTUzBkMDJyVU5rK3pUbXVl?=
 =?utf-8?B?VXpaaWQ5NFdkaHhibjV2SmVLNUJxUkg2eVlPbDVYWVJ2NExYYzFFM2tyQ3Nq?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12DD9E49B5BD1045B943B38336D0436E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe36582-552e-4bf1-62cc-08dc646303db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:32:40.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCO4OCC4VhD7Ugno/zY/tCOejocTYQJGcEtRJ5hX0WTA0OjUSw+UrcfuRuVFZaP68qE9GFNrPKm0giTgVXezZTdK4caifWkrc5IM8GS8YkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDIyOjE5ICswMDAwLCBMdWNrLCBUb255IHdyb3RlOg0KPiA+
ID4gVW5mb3J0dW5hdGVseSwgaXQgZW5kZWQgdXAgYmVpbmcgc2ltcGxpZmllZCB0byBqdXN0IGlu
Y2x1ZGUgYXJjaC94ODYNCj4gPiA+IGRpcmVjdGx5Lg0KPiA+IA0KPiA+IFJlYWRpbmcgdGhyb3Vn
aCB0aGF0IG90aGVyIHRocmVhZCAoSXdvbmE6IHRoYW5rcyBmb3IgdGhlIGxpbmspIGl0IHNlZW1z
IHRoYXQNCj4gPiBtb3ZpbmcNCj4gPiB0aGUgeDg2IGluY2x1ZGUgZmlsZXMgb3V0IG9mIGFyY2gv
eDg2L2luY2x1ZGUvYXNtIGhhcyBiZWVuIHNvdW5kbHkgcmVqZWN0ZWQuDQo+ID4gDQo+ID4gSSdt
IGdvaW5nIHRvIHRha2UgSXdvbmEncyBhZHZpY2UgYWJvdmUgYW5kIGNvcHkgdGhlIFZGTV8qIG1h
Y3Jvcy4NCj4gDQo+IEl3b25hLA0KPiANCj4gSSBqdXN0IHB1c2hlZCB3aGF0IG1pZ2h0IGJlY29t
ZSB2NCBvZiB0aGlzIHNlcmllcyB0bzoNCj4gDQo+IAlnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvYWVnbC9saW51eC5naXQNCj4gbmV3X2ZhbWlsaWVzX3Y0DQo+
IA0KPiBJZiB5b3UgaGF2ZSBhIG1vbWVudCwgY291bGQgeW91IHBsZWFzZSBjaGVjayB3aGV0aGVy
IHRoZSBwZWNpIGJpdHMgYnVpbGQgb24NCj4gYSBub24teDg2IHN5c3RlbS4NCg0KSXQgc3RpbGwg
ZG9lc24ndCBjb21waWxlIGJlY2F1c2UgWDg2X1ZFTkRPUl9JTlRFTCBpcyBtaXNzaW5nIGluDQpp
bmNsdWRlL2xpbnV4L3BlY2ktY3B1Lmg6DQoNCldlIG5lZWQgc29tZXRoaW5nIGxpa2U6DQoNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BlY2ktY3B1LmggYi9pbmNsdWRlL2xpbnV4L3BlY2kt
Y3B1LmgNCmluZGV4IDIxOGZjOTM3Mi4uMzhjYjYxMjAzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9s
aW51eC9wZWNpLWNwdS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BlY2ktY3B1LmgNCkBAIC02LDYg
KzYsOSBAQA0KIA0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KIA0KKy8qIENvcGllZCBmcm9t
IHg4NiA8YXNtL3Byb2Nlc3Nvci5oPiAqLw0KKyNkZWZpbmUgWDg2X1ZFTkRPUl9JTlRFTCAgICAg
ICAwDQorDQogLyogQ29waWVkIGZyb20geDg2IDxhc20vY3B1X2RldmljZV9pZC5oPiAqLw0KICNk
ZWZpbmUgVkZNX01PREVMX0JJVCAgMA0KICNkZWZpbmUgVkZNX0ZBTUlMWV9CSVQgOA0KDQpUaGFu
a3MNCi1Jd29uYQ0KDQo+IA0KPiBUaGFua3MNCj4gDQo+IC1Ub255DQoNCg==

