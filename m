Return-Path: <linux-kernel+bounces-161921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2C8B535B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA011F215E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6E17BCA;
	Mon, 29 Apr 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fDW1FRYD"
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81551175AD;
	Mon, 29 Apr 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380207; cv=fail; b=Mt5cv5v+xC/iSNxHV37RDyLbTnsuFHQR+YowY9ZWHYB4BYaszypN2dCO+XTN0alIqLiELd/Qcf6xqU4ueyca7JR90Oi8oqwpx0nFrwcdKuRweYz4xirjrwvk+OAAi3GNejt5pnDxJH60HIFPVSgquzgVJT32DlIIPAOfC9c68cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380207; c=relaxed/simple;
	bh=8l8f2o+OzHuLXnFDrckb/Ygxv4FhPF7kQ2Hqwcp12PU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcNX8rBIBrkTUWU3CrcY+nVtsDLGDjq/zi2ghqFnq4yWYu7fRJqKEOAzX7Df+90REPweFi6vW8p71OhiHML4wE3hJdMZoiNgGRVAP7Ym7oCWfuqNChqAgs+9pNwvUFikQ0XpXo1tPwykvr0w0a5DPljYDgm+qoqZ2nlkPDR9sho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fDW1FRYD; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1714380205; x=1745916205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8l8f2o+OzHuLXnFDrckb/Ygxv4FhPF7kQ2Hqwcp12PU=;
  b=fDW1FRYDo7NrJw9XoiBOuppBnfrHwDrrnZxSiSfPvMBFAX+apJ2TKeoA
   tt8J4oo3A6WngoXdxWwM+M8jx4Har4bWv81ZGRt1d1Oyy5wYBN+uYmGUI
   7Vq9uzvoOIm1w8Clgyvft5g8SynE7Fk0nGsdkX0HMb1mgVQgyDMngeIk1
   DHpGaJLeTApbp+1GdlDu/DcDK0n52RJu8ddpzAnyfKUIlXMEZOYj0/Qq0
   p9aBqzJGNZQU98gwUJbqDY+6OlTHHBhxXn+iNTvvOi6PAP9QpC9R1+pHS
   uOVa9vmj/dT0JwAhgUqRquv0C7xBcH2cCuOn2sj5R1gxjLs3ZteofLvyY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="118105598"
X-IronPort-AV: E=Sophos;i="6.07,239,1708354800"; 
   d="scan'208";a="118105598"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:43:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX9JCRzdBAo3suzyY/b9PRY4fjsCwDN3oYTssJ67spIC+I9H0b/78KFt1KiIo5qv3v6NoeMb/1+e6yZpdP7B7UQkkOckwnq9raKoZZhMaaAsRuX+GaDY/iRFOTOtuQupvk/gpFHdLo6HNPWIAWFAuqhPsXWhHlxPJHPT0/6fNNSXc68GBKSO+j5uR9Mh+i1263sgUEBMxdzwY+EI7k8sy4dDa20M5OOCpWsYdoNGA1c0sj9VWNH+/a50oFGGolkwWKRv9Bv+HC+XYE1YkgPPrmoGGTAbrJafXCyT4dkcjEIYQ4lHvGG8tI5/Pzz5F5UxKEgVQJ4YPsP2zYyjZTZaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l8f2o+OzHuLXnFDrckb/Ygxv4FhPF7kQ2Hqwcp12PU=;
 b=mJ3Si4aAJkbBc9N9gA46yMSuqnDufppyFQjT61o4GdKh2tfX6Q0VC5/TlAv2aGupQu7gsBQ8sReGF/H+1/tXu6N/r4oWOPLamNNeoZQBc8edwxvuzoXJRGIRZCUCjimAG0EejneQQD4e5G35VvsMcm5/g/UQ2HTXM/xTDsaaoL6dStZBY9yKdAPIAvXtbrADhWaJehoVxh60kQNYh5uhobtWg/35xM4zox++kk5CR6rHTkzkbZPpiSoqTUMu+o25bvQUY16qETmRGGBnszNfJ54BGCOX1qz5REev/FdRw5ZtVfpEM4ZIsCLSF3nxE7joibHfGYR7LPaqp1x/QIp56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB11609.jpnprd01.prod.outlook.com (2603:1096:400:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:43:15 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:43:14 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Vishal
 Verma <vishal.l.verma@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Thread-Topic: [PATCH 1/2] cxl/region: Fix potential invalid pointer
 dereference
Thread-Index: AQHamdUJpJYyJtkDbUeNFeBCzHKRtLF+4C0AgAAOs4A=
Date: Mon, 29 Apr 2024 08:43:14 +0000
Message-ID: <bbcab973-46b5-4d91-b8b3-c91d43c0f58b@fujitsu.com>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <1df4e8d4-733f-43d9-a9d7-3764b6df7ed7@web.de>
In-Reply-To: <1df4e8d4-733f-43d9-a9d7-3764b6df7ed7@web.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB11609:EE_
x-ms-office365-filtering-correlation-id: cd724aed-6cf6-4d47-8c14-08dc682868ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|1580799018|921011|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ak0vRjdRWmlsWEpwM1djSnZrVjQ4WHVXT2MyVlBMeGNtTS9RekVBSEtUYmh2?=
 =?utf-8?B?ZXZWeWNTaW80azRtN0lMNFNLTzBvVmFlNHorUmlFcnhwSlNYUGFOU0k5Sm4z?=
 =?utf-8?B?dDVMN3FCT0l4TVFYZncrb2VsQ0V1dXBFVHMrQlhTNDhnaFNqUG1wYVlnWHZE?=
 =?utf-8?B?NG1LaExIWmpXWFA5NTZLYU1CbDdzWkJLS2lLd1NKNnJ0TVJMVkRZVDRTdjdV?=
 =?utf-8?B?b0U1WmpuNVM1UUVYRzhjd1FURjZiTmloMk5XYzVpNlQ2SjJ2RUxFYXJGdUJJ?=
 =?utf-8?B?VjA1QkxWekN2Y3FQTzkrbmc2KzMzMjdaazNEMW8rb3lGN3JyR01QZnZMNE01?=
 =?utf-8?B?RkJmUUNXQlRhWmpsVndhZCszMERKb0QzU1E2Y1l1TjVkUGwzNXBlUjVobFZR?=
 =?utf-8?B?d253NElKa0EreHlyNkwwRWdHZ3NiYWxwTU0yZXVjUUt2eW1IVjZVRktqcC9H?=
 =?utf-8?B?SndQOEZNdDJHdzByVmpMUUZCU0QxL0JDalVBaFo1MW92eU44NU04R0FVd1dI?=
 =?utf-8?B?TGFIVGZwc2R2RVRBQmEyeFN3cFRIcE9YR2t4dGUrOXBDaTFzandYbENqWHcz?=
 =?utf-8?B?cGlpTWJjZUxIZDVPQlJnSElOSktYcFRCWUpXWGNuQncwMjVIcllWTEl5NlFa?=
 =?utf-8?B?NStZMjBIZ1BjZVNTOVRIM1BINzhUOU16NFZYYW95UnMwZmRpUjFOOG1GbTFn?=
 =?utf-8?B?TW54YWNLRkUzRWxvZzg1N1RCVDYzb3RIL1NSV3BxaTg0M0JZWjI2VXo4UDRa?=
 =?utf-8?B?WFk5Z2NJWXlkVWZZdHZTbDJ1RjNQTUovSURmaGYyVTJuTUUzR2RoRU5NRllK?=
 =?utf-8?B?bFF4Ulc0SjljeVpzQlRBaHB1dFdvZ1dqbjJrN1JmY3RtNEpZYk5hejFIc1FH?=
 =?utf-8?B?K3E3MEJWUjZtQ283YkU0M0dxRVhNNitEQVRjKzNRT2U1VGx6RzhCZHg3U1Ni?=
 =?utf-8?B?RFIxTVlROHliM3BsbGJvcUpBd1NzVXV4bUNxZWdKcVZlcGlxdWF0U1RzN1Fv?=
 =?utf-8?B?a29NK1NEWlVkeTh6eFQ5MTg4TVY3SHBHbEQvQ1BYMkQzRjNkWmROWVdEd0tu?=
 =?utf-8?B?NlBRYTlZakpWN2Zic1lQdCt4YllEdlpBeU9xMnYvUTZ1dFh1bklTRlpnSW1S?=
 =?utf-8?B?cUVWeCtidCtHTnFwVFB5RXBYYkwrbXVCWE5UUzB5MkZaNEFhYlVKb2VRaWpo?=
 =?utf-8?B?cTM2cnJRZmFGMWp1K2QxeGo1WVRnVGdCUi8zNUlObzZCMTRUWmRLb1NMTWxY?=
 =?utf-8?B?STZsNHV6Tk1vVUpUVjFUbVZXZmF5Wi9DWWduZVZPbVMyQXhvUDZXdVg0eFIy?=
 =?utf-8?B?L0Z2YWpNVjR2RHVQN2NYbndMN0tidFNmNWIwZ29URXRDUkdoZmxFZk5OaDRE?=
 =?utf-8?B?NGs3SVc1cDl2TjZzYkFQTUsxSm5Kai9IaWd0WlBTTnZKVVl5dTNyTE5pZWw1?=
 =?utf-8?B?eVNMb0VvblZRZDBabVg5NGo1eE1hZFRQTlJ6OHR1Y3JUakhBTGZHeVRmOEs3?=
 =?utf-8?B?aUFXK05TR3g3dnlzOXFPdGUrNityNFV0Q2pmd3AzTlVyZkpMc0NwYjROVExU?=
 =?utf-8?B?a3UvU09SMlBEcFdDK3Jta0hTY2RXQjJFbm4yNVE5Q2pTcnBwQUpiS1Zjd3h1?=
 =?utf-8?B?STNZTFhDNVJRVE1RNDhpSjFGWVNWWk01S2ZudFIxUS9TYWNNM0QxWHM1dEJB?=
 =?utf-8?B?K3JqRGNQcXI3amwvRmV6U0RVY2E0MlNNOGhKKzBHSUNlZkVFcndSYy9ZYlNK?=
 =?utf-8?Q?BUlwkPb6ELbsKouxLVenXoFUlp2seHUCJ03ghCE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(1580799018)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1JicnVyeVdCclNyRHN2blZielBNQ3RNWEg3U2NBSStObjlQd1Q4S09TRExI?=
 =?utf-8?B?TUpiUXo0cFdSaEk3QU1MUEFSN3dkRTZ1c0VncDdETndiNWxnMGZzdHBXbGZO?=
 =?utf-8?B?ZkxZWGUzYU0rdUx4OWwzZjNtOVRybS9YY2ppTTRjdkh5dkVzMmxQb1IyaXRh?=
 =?utf-8?B?Y2UzOWtEclYyaG9nZVJXNm9QamZmdWZ0VFRFSTliVUdRa0NQbWdGTEptbGIy?=
 =?utf-8?B?TkZWaUYvRXdyYktLTGNNZlRrMHd6a0s1Z2pxSzNMRTY5VVlnRFRXbk5sY2ZX?=
 =?utf-8?B?MDEzR0E3dlZONHgvNVFiQjZKTW9WTUd4aGNEdGV3NUlGeUFzY2NZQnJ4ZmFy?=
 =?utf-8?B?MnJ6TU9SVlhXQXVyaklobG9tYm1HaUdiMm4wLys2NE9RREJSQzY3L2g3VlBs?=
 =?utf-8?B?Ly9wN1M5djUwQTZpVlhtQVAwN0ZiS1RMVFd2YjRrTEh6cVRrSm9uY2hlcjZ6?=
 =?utf-8?B?WFhvbW95QTNKZDh5anhYWExGdUtnQm11STVLOGE5bHJNY09VamlKVDBlNGZy?=
 =?utf-8?B?QitkK3pEdHVzUTM3dUs1ZStHSlhoY1Y4ejVtdlI2WU1PZnBkS1BYbHZBWkl2?=
 =?utf-8?B?T3EvblhDQzcwd2JFZkFqeE1uL0NuenNIM2oyRFhoekYvenl0ZjhONzQ2dS9G?=
 =?utf-8?B?cUl6dUlKRDFXZm1wZmdkUlpOb0NZVnFQNFVwckR1L3FQSDZXMTJOekc5NUVH?=
 =?utf-8?B?RU9QRk03QXpXejh0TW53d3FGcWVVY0doSllUQXVnQVU1dFd1ZDJ6c3hLYmRx?=
 =?utf-8?B?bS9QR1lBRWZpYU1OT3YyS3YxWDNmaGNzSGU1WFJMNHpJVUkrU0VFTm4vWElt?=
 =?utf-8?B?NlJ4b0g4RU5ybnhhTDI3UTVhcWJrVXd1bFRqT2VxK2tNMkRidVRrb2xYS1g5?=
 =?utf-8?B?UEwrN09Dd0twLzVocmQ0RHp0ck5hYUJVWkI1aE5TeHNtVDJaV2Jta1NWNUxO?=
 =?utf-8?B?S0N4WDVGNWtnYVNUYmYzemtBZnFsN1M3RnJEWmRVQXNzbnZIV3N6dnc4eG9P?=
 =?utf-8?B?Zy90MEtoUkREd1ByenZHRzEwTFpPZFJDVld0UmFmcUZEb3B4YlZHTUJlR2or?=
 =?utf-8?B?MmQ1TGp2b2tQQWZFcExhdjk0b0JZU0wxZkVPeU1MSVdtdE9NZXVuRzV0OWht?=
 =?utf-8?B?TFI4ZmJtWmhFTmNFbGVHaklkdFNjc1lFM3pEOEJPYTA2MWxRQllMczJUK0Zl?=
 =?utf-8?B?cFEwWFc0OXVHR2tFblR1Q3U2d1F6TWpRMWNXQTBnRUZKbmRUdEttRW93QWRD?=
 =?utf-8?B?aitxTi9hejhySDVBWVBKbWdmbVVTdmw3TTd3WG8zZ0ZhMnd6MFhheWV2SDVy?=
 =?utf-8?B?WGFpN3N3MGovbXNTMmVQUDVNYXlabThFYk5ZTG5ZU0VsVWk5SnhOMlkyRWhy?=
 =?utf-8?B?VnJ6NlBKMFhJTU5ZM01pelFubjhtZjhSUHJ6cTJoakVQTDZKTitZTXdqS1kx?=
 =?utf-8?B?OUc1cHN5VGpzWUFSWWdVWW83Uk05VnEyNDJkS0kyMGJ3Qyt2c2tTZ016NERR?=
 =?utf-8?B?S1cyWlJLelVRQTNuQ2pCamRydHcxUk1BN3ZBMnBLNTNWVU5ZdWhLSGJ3SWwr?=
 =?utf-8?B?RUVZUnYySERkWktDaHdHc1d6dHkvOVByMHBIMVJPSmJwWEZIbnY3Zy9kV1pt?=
 =?utf-8?B?V2dqVlRlU3ZWMlRSdHYyUTdlczBkWWJzNk4wZ2o4SVIvaEFHQWZGNktiQnRE?=
 =?utf-8?B?b2d0ZWxVRzdLeTBrcGRvdFhGdEhFaVl6blUxaG81K3hIVXNKbGZzdUU4T0o4?=
 =?utf-8?B?WnVFbVNhbFUyUjRYb1o5cU1sS1NXSnIxL0EwS29KbzE4V3o0REx0dWdtZnJz?=
 =?utf-8?B?djFhUmYyTnFmT0FIbjJHSlRYVlNGK2ZQTG1aWHgveGplejV5MXdDNkFmSG9l?=
 =?utf-8?B?Q0cvV2ZTUEt6MEFLK3c2dlBlNU5sbEVLTS81QTIwR3cvRm1VaTNyNWVpSzMr?=
 =?utf-8?B?NDZLaDZDeWJuRlpTZ2txV3NlQjdUa0MzaFVvZGQ0WTNsemxkN0tJckdBR3ox?=
 =?utf-8?B?eE9XNkUvUVA3ZTM3bW5JUjRwckhzb1VQTWg4cksrOUJEbGdmYTJ2WDJod1lo?=
 =?utf-8?B?L3N1US82bUVWNFJwU1dkb0Q2UWZOSzVUbDlLVlo3QjI2OXovaVVyT2FpZWx5?=
 =?utf-8?B?M0c3WUJGWGxKcnNFc3h1Nm1HSHYvWVZ6T2ZCMjJlZ0xGQVNKNU81TmVEQ28y?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61069E61B7F92C48A0C5FB11BB90C93A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FMIRbBHnFP9SxI3ksNGck9RaDOHqtTL9Xmf4wcNFCFBh4hiVBHNSqUD4O6V1FWRg9iEbBM0fEPEIwpdlNBPeiDLdMLQfvMLoO7Csx06PPCJuSG9NSF0ynshIAAdLa8CyCthgT6iT0mCD32gNrtTjerWAMkitbMm5S3Ooq+Mz5JcCrCaeR6mozyu7AQmLx8Yxm61osuAkn1DlI0/+K5/e1A3z3oD0/Mz003bSLnaFbu+84BdPmMwhKYGiW3rv8gQykvX2eK94y3REbhTwC+9g1oKGah+PMQeXI8g0N0F8CVqvWem2V2GYXmIxtxV+tNDd1SSVfkMu1XaOE04qaHOdNbF4KhziqFngO3uRJLB6W24WnyRhKEvqIiUy0tSKAutgZvXNrPzZ/Iv/bwtfXM8EGVjNlhID2GXKGqDprlTFeFh/KRm+f84WxXNSLJ+SPJ43/dE/nb3OAuauAiWD39ME+Zw0w9N7+DIpC6atIx6yTc1I2fptRfUIjJtn+TsaPvqP6/puiYyu0wAx1ALrZMsoeYr1SYR6nwptqiKnKfhIuJ+VpjekhqPhe0hub6xNehgCdLRu2URvayg+8dUGKfV2nPVokCQj7Tkv8QSnR9nCCK3fYr75GwfN3zyFo+Vrf89I
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd724aed-6cf6-4d47-8c14-08dc682868ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:43:14.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w782KARBEqbR5ji/AXGQEOqBoRumtQjYQ5CWChPdb+wY89QmU2tc0J/6z0PLC2J5sH6o+eatqk0lknBKdefBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11609

DQoNCk9uIDI5LzA0LzIwMjQgMTU6NTAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiBJIHdvdWxk
IHVzdWFsbHkgZXhwZWN0IGEgY29ycmVzcG9uZGluZyBjb3ZlciBsZXR0ZXIgZm9yIHBhdGNoIHNl
cmllcy4NCg0KDQoNCj4gDQo+IA0KPj4gY29uc3RydWN0X3JlZ2lvbigpIGNvdWxkIHJldHVybiBh
IFBUUl9FUlIoKSB3aGljaCBjYW5ub3QgYmUgZGVyZWZlcm5jZWQuDQo+IA0KPiBJIGhvcGUgdGhh
dCBhIHR5cG8gd2lsbCBiZSBhdm9pZGVkIGluIHRoZSBsYXN0IHdvcmQgb2YgdGhpcyBzZW50ZW5j
ZS4NCg0KVGhhbmtzLCBoYXRlIG15IGZhdCBmaW5nZXJzLCBJIHdpbGwgZml4IGl0IGxhdGVyLg0K
DQoNCg0KDQo+IA0KPiANCj4+IE1vdmluZyB0aGUgZGVyZWZlcmVuY2UgYmVoaW5kIHRoZSBlcnJv
ciBjaGVja2luZyB0byBtYWtlIHN1cmUgdGhlDQo+PiBwb2ludGVyIGlzIHZhbGlkLg0KPiANCj4g
UGxlYXNlIGNob29zZSBhbiBpbXBlcmF0aXZlIHdvcmRpbmcgZm9yIGFuIGltcHJvdmVkIGNoYW5n
ZSBkZXNjcmlwdGlvbi4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1
Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni45LXJjNSNuOTQNCj4gDQo+IA0KPiDigKYNCj4+ICsr
KyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4+IEBAIC0zMDg2LDEwICszMDg2LDkgQEAg
aW50IGN4bF9hZGRfdG9fcmVnaW9uKHN0cnVjdCBjeGxfcG9ydCAqcm9vdCwgc3RydWN0IGN4bF9l
bmRwb2ludF9kZWNvZGVyICpjeGxlZCkNCj4+ICAgCW11dGV4X2xvY2soJmN4bHJkLT5yYW5nZV9s
b2NrKTsNCj4+ICAgCXJlZ2lvbl9kZXYgPSBkZXZpY2VfZmluZF9jaGlsZCgmY3hscmQtPmN4bHNk
LmN4bGQuZGV2LCBocGEsDQo+PiAgIAkJCQkgICAgICAgbWF0Y2hfcmVnaW9uX2J5X3JhbmdlKTsN
Cj4+IC0JaWYgKCFyZWdpb25fZGV2KSB7DQo+PiArCWlmICghcmVnaW9uX2RldikNCj4+ICAgCQlj
eGxyID0gY29uc3RydWN0X3JlZ2lvbihjeGxyZCwgY3hsZWQpOw0KPj4gLQkJcmVnaW9uX2RldiA9
ICZjeGxyLT5kZXY7DQo+PiAtCX0gZWxzZQ0KPj4gKwllbHNlDQo+PiAgIAkJY3hsciA9IHRvX2N4
bF9yZWdpb24ocmVnaW9uX2Rldik7DQo+PiAgIAltdXRleF91bmxvY2soJmN4bHJkLT5yYW5nZV9s
b2NrKTsNCj4gDQo+IEkgc3VnZ2VzdCB0byBzaW1wbGlmeSBzdWNoIHNvdXJjZSBjb2RlIGJ5IHVz
aW5nIGEgY29uZGl0aW9uYWwgb3BlcmF0b3IgZXhwcmVzc2lvbi4NCg0KVGhhbmtzIGZvciB5b3Vy
IHN1Z2dlc3Rpb24uIERvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlOg0KY3hsciA9IHJlZ2lvbl9k
ZXYgPyB0b19jeGxfcmVnaW9uKHJlZ2lvbl9kZXYpIDogY29uc3RydWN0X3JlZ2lvbihjeGxyZCwg
Y3hsZWQpOw0KDQpJZiBzbywgSSdtIG9wZW4gdG8gdGhpcyBvcHRpb24sIGJ1dCB0aGUga2VybmVs
IGRvZXMgbm90IGFsd2F5cyBvYmV5IHRoaXMgY29udmVudGlvbi4NCkZvciBleGFtcGxlLA0Kc3Rh
dGljIGlubGluZSBpbnQgX19tdXN0X2NoZWNrIFBUUl9FUlJfT1JfWkVSTyhfX2ZvcmNlIGNvbnN0
IHZvaWQgKnB0cikNCnsNCiAgICAgICAgIGlmIChJU19FUlIocHRyKSkNCiAgICAgICAgICAgICAg
ICAgcmV0dXJuIFBUUl9FUlIocHRyKTsNCiAgICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQp9DQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJr
dXM=

