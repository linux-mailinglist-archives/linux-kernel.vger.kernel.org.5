Return-Path: <linux-kernel+bounces-162498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B918B5C09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970D1281087
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63680BE3;
	Mon, 29 Apr 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RXyzudFn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BB7FBC8;
	Mon, 29 Apr 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402513; cv=fail; b=OdweTIVoo3LRjto/xVbnMDZBzuLDASj2WfIdHWb5Oxk9xYOLUmXqAi2rQOHz1vUKTzo8aU9GvjRuVnc5F6V2W26Dqd5kAeuTCf31n39vSnqeLmbrZG6a61WTrI2DBAUyytF9ZioOdUOfBhyLE+oRzC4wKBAIn6ODOJxThoo5l1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402513; c=relaxed/simple;
	bh=DbfxUvk0VRkc83S62SCMuZ8Q0wy98lGQDACgEZbxTck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7gXt6/IvZlJ0mvqG4NGon4WEBNmya2lyruYFtctOCSHIfSCHEZwmPQtA5Xr4PUsK7r9rd2Rge/+1GyuNBXrQRHEOb6WWAmR4lf2xcBQdEGGeWLbSgBVcxffUqkZtgQkk4B7XH3b61cPEi4B846xZZyWg62hWU4yRJWPwjdJTx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RXyzudFn; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3vuSe005525;
	Mon, 29 Apr 2024 07:55:07 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43au968-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcnFeEsWNL+0SyeIxTtIvv4W1tIHr1P42xs8o9RpJmFE4gjNCuHRmn2nYNNduovIu+bM3PymcoF46C5jOKMhUj7/Olp7lcTpYSZtqMXwQKPgCP84PMd7W8dBa2Ftgd8Hj6+O7hoBnV/+PxEufhsmt9ogaNrAHzpPiNdMhjOm8uASJI3BYyzAHuMOGSrUyu52gOaN3QYsWyERPAusCReCJpyGIO070o4ulDnMtvY8+PjU042pLMei6qxiPPLAIeHBQ4yIrBoy7dkPf1Ukg2KJ2XNXmmiJJwmwRM/V7zIyuLU6Ji6GqeN6gxcYpHcKuHIMW7j+/s2kXEZodZVqOXg/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbfxUvk0VRkc83S62SCMuZ8Q0wy98lGQDACgEZbxTck=;
 b=NyioJEXwtpTH1ZodTY7PD0rJgCah9nNSasmSkvJVR17IpXCYmP4hUZs7gry5HNcD9asDcaiwRf6fPfVbmdkXnMIZCljjmICPY+hbbto6964Q8o1JavtAQ3zAfrvStr3FieCETfy8A63KUnET+sYPPB7L3nGtSC+zslgrDq52mxWTy45vLdg28O/2DBOcCbuGzhqDLIEeXiyctke3a+CrIDEDPVzIN7f626Zgl0v9e0ADuxCzG/hEG/rIzh59ha7Oe5qZE5tQlpdvuUyXFe2vMzzU5M97dkoYQLhmUQOnXVaVpGfzsYhncB5vkHibZSiehTqnPHoiO7l2331Y9AgTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbfxUvk0VRkc83S62SCMuZ8Q0wy98lGQDACgEZbxTck=;
 b=RXyzudFnHzyvz9KzNQQTCGtGOJJEG23GMF/8nKow7HAEj247YhteqaiNldkf0VvsRWKNttQRVsvFlsac/OWH1tLDIt4+oy3fVjRSRgvikQokQcWHPdZanbKp2463JdxF1LFQL9M/2Z6ab7ZRQ4Mso9dkn4thUUUz9kc7xSD+iIo=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 PH7PR18MB5666.namprd18.prod.outlook.com (2603:10b6:510:2e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:55:02 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:55:01 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/5] spi: cadence: Add Marvell IP
 modification changes
Thread-Topic: [EXTERNAL] Re: [PATCH 2/5] spi: cadence: Add Marvell IP
 modification changes
Thread-Index: AQHaghIqN9nr1ATyc0SducD2uOBBqbFQKCSAgC9cWeA=
Date: Mon, 29 Apr 2024 14:55:01 +0000
Message-ID: 
 <CO6PR18MB40984F6DAC8B8B2FA9C68477B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-3-wsadowski@marvell.com>
 <7bd584b0-46e1-4dcb-a402-80784f7d11b7@linaro.org>
In-Reply-To: <7bd584b0-46e1-4dcb-a402-80784f7d11b7@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|PH7PR18MB5666:EE_
x-ms-office365-filtering-correlation-id: 56beab92-9c68-44f0-a606-08dc685c5903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dDMrVFpUNVQ3cllYOHUwc1p2dGdUOWZTSkhCNVBkcmx5OHV4NkhkMEJxNGM2?=
 =?utf-8?B?cVE5bDB4alhuYy9NbDJ4NzN1azZjbzljRm0rNElZRlBHdnB4U2w1T2lzd0kw?=
 =?utf-8?B?UEpvNjRYNGVNSEtYQkdYR0UwTG40QS81TW92ZzE2ZTBueVQ1TUFPdUlKTW9J?=
 =?utf-8?B?RVc5UzNSNUpEemxnMnlvbkNJcGFWcGN4dm9yNU1KTXFnVG4wbWw0S1l1MVVJ?=
 =?utf-8?B?M3VNMDdLazk2NEY2MTlOVkFkUjYvcnV6WmZVVUF4ZkpIalZkNWVYdHozTWx3?=
 =?utf-8?B?dW9vNTFHbEs0UXV6NmdJTVJnNzcyd0lEcU52dVZhMVpTL0tRUm4vMm8rVW5N?=
 =?utf-8?B?NTUrT3prVUxUd1cyVkUxN2lHcldGQUdKRi9sUzNWeGl1ZXVPemZsOU9WMFFI?=
 =?utf-8?B?Ty8zMjAzWm5uWTB1S0Q4emRLVFA4bWN6QlhZd2IvVnBiZHRGV1hnSWxiSUxk?=
 =?utf-8?B?TkI0MU1XME1GNUhIczR4cVRaZVUzUkkrZ3pkcDc5RldEZndHdzJXdUJaZDhv?=
 =?utf-8?B?STFRYm8vYjI5YjFCVmhOanlDNWoyUkxsZnhTVDNKMUVJOFNORHBic0FVY2FI?=
 =?utf-8?B?UUo1clJkS3QyK212Njlnc1Z2bzgvdVpXRFBGaXJwVElYdU9Qc0ExcE9QZmpY?=
 =?utf-8?B?ZTBzbEd0V0RRQkNuNzhDZExvSjR5Q0lkSTVxbUs0K0pZaFRKVEcxWHh0cjNj?=
 =?utf-8?B?SXUyNzFtMDZLR1NJK1dWZDRqTHRSOVM0M1orWS9tcGpCOWYvUG1xbmtNOW1G?=
 =?utf-8?B?K1dyMzRCdzdMcUtVV25lOWd2dHZKV3ZXTktpM0lqeTlQai9JenpWK1BzM3JM?=
 =?utf-8?B?Vm1rUm9MMDRUNjB1UzdCSUpvYUYzdndJc1Iyald1dFgzaHlSY3BUNUtWMGxT?=
 =?utf-8?B?Z0hackVZSVo2QTBQRUJUdURzUWpmR3dUaTNGMDFpRjIxSXFIaDlWeWl5VmE0?=
 =?utf-8?B?RERKTjVzWGFvbWFJS2pUTEdSRGV4ZnJSZ1poaHA2WFZlWE5pbG9UMVNIcTdi?=
 =?utf-8?B?Nk9halA3d1RUcFdCc2k1bTJWWEdsalFLVnY1SHR1elhNc0pGcVNSOUUzeFFu?=
 =?utf-8?B?OVN6QTBOSWhoZkQyRFZNL1RNN3B5OWx6eDJKQlc1VEk5R3hRc2dwVEh5QmFk?=
 =?utf-8?B?dFllalZ1QkhXcWFWeGkyMTJHSGF6SFlBenZzc3NZa2hJcUt5R3RHRm9Jbjht?=
 =?utf-8?B?VU4za29VSTFVTDFlRVBzbU5tRFVyNTRKcFovU0NOWXlDWjhWd3BkRzZ5bGJ2?=
 =?utf-8?B?cEhVMVZBWjFZVlRKZTN0OXZ4N0w4cGVadXNKZGFEeGtjK3dMdVk2S3AydXZE?=
 =?utf-8?B?S3JZMUZBN0pPc3Yxa0oxQUp5cUxoMG1iOWVITkJ6TC9RMlUwZzYxb3FHK1F2?=
 =?utf-8?B?VnJHNzFSNm1mUHJORkQ0cUtmaHY3NG1iSWRUd2FPMGs2cEZDWDZjSFRIck5T?=
 =?utf-8?B?NUtVNmhlUG45SUNPM1UzVWhPUWpCSjJJU3ZTU1RzamRoUlpXNEo2KzZmK1U2?=
 =?utf-8?B?TlU0dkMyb3FMcWtkNFdqeFVjQmxSMEdsWW1kcnliTWVDdVlYVXdPdSt3TFpa?=
 =?utf-8?B?bWgyYkxobHo1cnNKcGZXWHl0NEMyeitWa1QzaFEwbDlTWTRKcHdoSVA1RWdD?=
 =?utf-8?B?RVh3TkNlMUc1Wjc5KzNNZGZseUlLM3lRN3h6WDVKM1p5Rlp1eHZtOFpCSXVL?=
 =?utf-8?B?dEtsSVlsTnpXUHhxcm80QjI0Y0RNOU5UWlJqR2ppallOc1B5SzRweGp3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bTNTbVNXUE92WW00WDVwby9hRDM3MUh6WEJ5K0g4NFJPRXYzSGh1bTBVMDEy?=
 =?utf-8?B?QU5tQ3VHYUo5K25HeDY1dDErUjg0ZEVtN0RoQWh4T1BSY29wU2xRWHVJcFVi?=
 =?utf-8?B?a0dmSmwwNHBUK1RVbkFaLzFKNWZJeWVEeUhVU3l3aDh0Yk5KbkR2UlFMcjEy?=
 =?utf-8?B?cXBRbnYrVFI3RW1VN0JqNGhUcUtFR1hmaEJlSkJuaHd0RjBuZHBvdDFwMEt4?=
 =?utf-8?B?LzhENWdUSU9KY3lBbjBtb21McDYxUUxUeUhqOElua20wcy9WMVczWjRsZHc2?=
 =?utf-8?B?a2sxeC9uVGJBQVZrakVWWUN3aE15MWd5UUMxQWFQVXc5TG9oV25oUmtJWFJC?=
 =?utf-8?B?V3N4c3gxUnZ4dFR4cVdxd3MyR3NFRERMT1BGckQ3MmVUTlpNanVNUFhmSmlE?=
 =?utf-8?B?MitRdms1anB6TC9XTC9SUlNqTmZtbklFM2lhcTZGWVNlR1RjRkdHb0hSVmdR?=
 =?utf-8?B?Y2VpV3RWSDVJVER3N3JReFY1RThUTEdyMHZTSVhLMnlYd1lDWmhRbHIxVFNN?=
 =?utf-8?B?NXhLNHhVbFNnajFDOEZzbUNqcExhSURCKzh5YlNpUTdJSjZFcmZvVHRpeW5l?=
 =?utf-8?B?Mm1rY2pTdWc3ZW5MUkt0a2xRYTQrRlNFVU5yQ0NVd2MyTG5rUDhhOElOeFNr?=
 =?utf-8?B?N29LZFZRTDNtRXRmNi9wSW5UenFxUFVOcUU1YVpaZzg4TzJSOGQ0Z1Rodzdt?=
 =?utf-8?B?aGV6ZUlya1hLNlFPS003YS9BTkJiVXJGVlhyeEM3UFFKR0RwZmdaaWFacjhy?=
 =?utf-8?B?bDBybTkxNEFNVHNWODVYdzRsT0pqeCsrTUxBVXdFSVE0ck16WDFEV0QvdzNB?=
 =?utf-8?B?dzlqQzRsTlBMMzR4dTdMVW9OanlBRitVc0RUSmRPNFphZlFJZ0dkQ2JNdXhT?=
 =?utf-8?B?blhmNWVDRW5FS29JeVVZVWJvaFNkcjExZExkVXBaZjJEdDdqL091bzJ0RkNt?=
 =?utf-8?B?dFNKQzNyTXpZbEl6NHh1M1JjaEpxYm5CYnVGQ3kzL1ZWSjNZQWdxM0dLOHZW?=
 =?utf-8?B?OHZLVFJFdDFDVnUzempUeDRudzJNdC9yTFUyWGhWSXhQdVJkQUxSNXBxTVpL?=
 =?utf-8?B?MmlFcXlUZWhwamhBbDlVR0UwQk8xVi81cVgzMUMzQmFmckxwalN2cFU0OXFG?=
 =?utf-8?B?NjFVd3BFUXpTR2QwL1VLK1NXdVFKdnp0eml4VTFPb3dLamZuVHZUUzZxY3N3?=
 =?utf-8?B?SmhQYTZHRkRNOVpaMittUGpORi9qcndJZmt4ZDRzZFZkK0E5U2FjalVvRDBZ?=
 =?utf-8?B?VEgzcDhUYXRpUWVuTzV5TkpmbHdhazdSendZeStubVBIM2YwdWd0Z2M2Ynls?=
 =?utf-8?B?VllKQ0p1MkkvZWZmMlZhTjJBUkNiNGV0RlBjS0JMekdQQWFSRkNONGswWG5z?=
 =?utf-8?B?Y2E2YzZoeTRxTFhhU2ZyL0ZMaFFZMU5kcDgrUWNPYzZWejNMa2VDYTV2S3l6?=
 =?utf-8?B?UEozTlFqNUlsNUdLN21kYXRPUmo1R2NXZkMzYVFKVzhWbVBXUTg0eW9qT015?=
 =?utf-8?B?Um5DdTB0ZGJRQmoyem9mVlNGTWhmaDJkTWRXMFR0ZnBkZ3hBY0xDa1JpaDU2?=
 =?utf-8?B?NXZJRXdydVJhaE93b2lickpJZmlRNGx3K3FoaTZFNHdnUmVrb2NRM0hjN0xj?=
 =?utf-8?B?Sm9ZejdtRXpIVUU1SVNMbWIzQUxxMDEyY2h2ZmE0SEtOWmx3bCtYOG5GQjAv?=
 =?utf-8?B?MzhZMHRCOS82RTZZNUVhRkhqV3VhMzFITzlMbFZWUi8yT3FQMzNpdkR6MDls?=
 =?utf-8?B?ZGdncTVVb3BpWnE4bXRrSUIzNEJqczFjdHZTR3VGUGZad3JnRjc5RktQOVRn?=
 =?utf-8?B?MXpuS1d1a2xiMzRwYTRXNmdPaGVRVUR0RDMxWC9pYm14NitYMG5PUEl2YVRO?=
 =?utf-8?B?TFRDTU9RdjVEOUpvUDlFaFZSVDVPYkc3OGZlUndOOWlDcmFIL1BWMDBHWWhn?=
 =?utf-8?B?MStNOHVhMEJyNExwaUErblJ2eVdoOUVuZC9CQ3JmOVVJVEIwdGZqZmIxT1VO?=
 =?utf-8?B?S0NqOEYyMFMwc0pmMWRwVWRUNDBUbWRhV2ltMENncVFsQ1JzZ3pQdFFscXg4?=
 =?utf-8?B?RjRZRVVNZEVVbHpQT0pTbExlcU9LVUdFTUMxQ2VtTy8xSDA2L2srNVYxSjBS?=
 =?utf-8?Q?LUFml1zkCP6/kgb6Pu44nnWlW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56beab92-9c68-44f0-a606-08dc685c5903
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:55:01.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3WnJq4o/2BqWHKihDfrT5T/xKaNxXJ2ZcW6V8uZiQtva4JXPKal3Y1z03lrw6I2hBY0egrcenijjFhPO39HFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5666
X-Proofpoint-ORIG-GUID: MQkDqDYlsmalvMGZw_vY496gkGzY3pe7
X-Proofpoint-GUID: MQkDqDYlsmalvMGZw_vY496gkGzY3pe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IE9uIDI5LzAzLzIwMjQgMjA6NDgsIFdpdG9sZCBTYWRvd3NraSB3
cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgTWFydmVsbCBJUCBtb2RpZmljYXRpb24gLSBjbG9j
ayBkaXZpZGVyLCBhbmQgUEhZDQo+ID4gY29uZmlnLCBhbmQgSVJRIGNsZWFyaW5nLg0KPiA+IENs
b2NrIGRpdmlkZXIgYmxvY2sgaXMgYnVpbGQgaW50byBDYWRlbmNlIFhTUEkgY29udHJvbGxlciBh
bmQgaXMNCj4gPiBjb25uZWN0ZWQgZGlyZWN0bHkgdG8gODAwTUh6IGNsb2NrLg0KPiA+IEFzIFBI
WSBjb25maWcgaXMgbm90IHNldCBkaXJlY3RseSBpbiBJUCBibG9jaywgZHJpdmVyIGNhbiBsb2Fk
IGN1c3RvbQ0KPiA+IFBIWSBjb25maWd1cmF0aW9uIHZhbHVlcy4NCj4gPiBUbyBjb3JyZWN0bHkg
Y2xlYXIgaW50ZXJydXB0IGluIE1hcnZlbGwgaW1wbGVtZW50YXRpb24gTVNJLVggbXVzdCBiZQ0K
PiA+IGNsZWFyZWQgdG9vLg0KPiANCj4gUGxlYXNlIHdyYXAgY29tbWl0IG1lc3NhZ2UgYWNjb3Jk
aW5nIHRvIExpbnV4IGNvZGluZyBzdHlsZSAvIHN1Ym1pc3Npb24NCj4gcHJvY2VzcyAobmVpdGhl
ciB0b28gZWFybHkgbm9yIG92ZXIgdGhlIGxpbWl0KToNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnBy
b29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xp
bnV4X3Y2LjQtDQo+IDJEcmMxX3NvdXJjZV9Eb2N1bWVudGF0aW9uX3Byb2Nlc3Nfc3VibWl0dGlu
Zy0yRHBhdGNoZXMucnN0LQ0KPiAyM0w1OTcmZD1Ed0lDYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4
dGZRJnI9R0tnY24tZzZaWC0NCj4gSm1DTDNTMnFLZ1ZRaHZodjdodTJuOEVuLQ0KPiBkWmJMVGE4
Jm09ak5mNU1ZRWNleEhNTDZpbzJrb2lxbjE4UG1raDJxcWMwRkw0OHpkQ29vamJGWDA2b216bDJf
WjBDcEJlSG43OQ0KPiAmcz1CMDM4ZGdCVUIwR3ZsNjNFeE1ERm9YdW9tWkJTWlBITHBTY0hPdFRh
eDBRJmU9DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2l0b2xkIFNhZG93c2tpIDx3c2Fk
b3dza2lAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+IA0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBi
b29sIGNkbnNfeHNwaV9nZXRfaHdfb3ZlcmxheShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSB7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9IGRldmljZV9wcm9wZXJ0eV9t
YXRjaF9zdHJpbmcoJnBkZXYtPmRldiwNCj4gPiArCQkJCQkgICAiY29tcGF0aWJsZSIsICJtcnZs
LHhzcGktbm9yIik7DQo+IA0KPiBObywgZG8gbm90IGFkZCBtYXRjaGluZyBpbiBzb21lIHJhbmRv
bSBwYXJ0cyBvZiB0aGUgY29kZSwgYnV0IHVzZSBkcml2ZXINCj4gbWF0Y2gvZGF0YSBmcm9tIElE
IHRhYmxlLg0KDQpPay4gQXMgSSBoYXZlIHdyaXR0ZW4gaW4gZGlmZmVyZW50IG1haWwsIGEgbGl0
dGxlIGJpdCBvZiBtYW51YWwgbWF0Y2hpbmcNCldpbGwgYmUgbmVjZXNzYXJ5IHRvIGhhbmRsZSBi
b3RoIEFDUEkgYW5kIGRldmljZS10cmVlIGNhc2UuDQoNCj4gDQo+IC4uLi4NCj4gDQo+ID4NCj4g
PiArCWNkbnNfeHNwaV9wcmludF9waHlfY29uZmlnKGNkbnNfeHNwaSk7DQo+ID4gIAlyZXQgPSBj
ZG5zX3hzcGlfY29udHJvbGxlcl9pbml0KGNkbnNfeHNwaSk7DQo+ID4gIAlpZiAocmV0KSB7DQo+
ID4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBjb250cm9sbGVyXG4iKTsg
QEAgLTYxMyw2DQo+ICs5MTEsOQ0KPiA+IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGNkbnNfeHNwaV9vZl9tYXRjaFtdID0gew0KPiA+ICAJew0KPiA+ICAJCS5jb21wYXRpYmxl
ID0gImNkbnMseHNwaS1ub3IiLA0KPiA+ICAJfSwNCj4gPiArCXsNCj4gPiArCQkuY29tcGF0aWJs
ZSA9ICJtcnZsLHhzcGktbm9yIiwNCj4gDQo+IFRoaXMgZmFsc2VseSBzdWdnZXN0IHRoZXkgYXJl
IGNvbXBhdGlibGUgOi8NCg0KSSdtIG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB3aGF0IGRvIHlv
dSBtZWFuLg0KY2RucywgeHNwaSB3aWxsIGJlIGNvbXBhdGlibGUgd2l0aCBvdmVybGF5LCBhcyBp
dCB3b24ndCB0b3VjaCBhbnkNCmFkZGl0aW9uYWwgSFcuIEl0IHBvc3NpYmx5IGZhaWwgaW4gc2Vj
b25kIGRpcmVjdGlvbiwgYXMgb3ZlcmxheQ0KaGFuZGxpbmcgY29kZSB3aWxsIG5vdCBzZWUgZXhw
ZWN0ZWQgdmFsdWVzLg0KDQo+IA0KPiA+ICsJfSwNCj4gPiAgCXsgLyogZW5kIG9mIHRhYmxlICov
fQ0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBjZG5zX3hzcGlfb2ZfbWF0
Y2gpOw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KUmVnYXJkcw0KV2l0ZWsN
Cg0K

