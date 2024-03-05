Return-Path: <linux-kernel+bounces-92911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76763872809
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E030A1F23385
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643512839C;
	Tue,  5 Mar 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WrvfrtCO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bapA7lZK"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439B5C608;
	Tue,  5 Mar 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668451; cv=fail; b=frwTKkpZNUo3eobCwCP9tRXWsTK9+CenFRJD+s6OhJLDxskRMjpZt8bkPrPaZWwRdFiJ6cE8/A1OzzZD3rFUz3pcfJxwUwdDADY7xhq22n04KFcuwjE/LZSCrG9DY3z2c+raa9pzi0tRUR9Gg+lnSf0RVVI4Nyw4us5xdO8A9K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668451; c=relaxed/simple;
	bh=jPC4HJg/aRQseqVNTQHztB1qPgpM0fsQLomTFlZEZmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2M+2P5//tfPKEQJNostA3bAD1wNwmTQAlS/LEK5G6tAdYyIlWOdr6A8ZHbDtQ3si96KvgoEGMCOITUec59gclny2tMRWS/Ui83Z1AE0/gdB6p22ab6xTGsHywu480v60+URy5tkH9VCq/GVTpPL2Tfi5I2o+9Xa16V08ubr3fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WrvfrtCO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bapA7lZK; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709668449; x=1741204449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jPC4HJg/aRQseqVNTQHztB1qPgpM0fsQLomTFlZEZmk=;
  b=WrvfrtCOphQKoX3tEJVCAHgq33bM816XL5dD1SrEoZqyjfnvk0P6MWRo
   1iD998R9PjFSWWvk4HjVyWKQZXcRkWT8N4J30oJ/B35kkD7KdmiqhFvUu
   C7cKB3W1IE/5XPbXWgwlV4kaDpIDip9C8RUl8KJCwI+9KM3MlOHVCuZh1
   okVOe9Xm0GA0dCGNlZhAcoYgjZYnmTB1OaUMbWXCxjXK0BeMMOhRssBxm
   PAU3iUKru6ZQ0WLMMGovEusZlRxXXIDd8znLIu1fOEhPt0DsLg1FPGORG
   4GY21KHuWSyG0HHVbx749TkK+mpfD3fSQmwvns+Dql0zn7B37O6qPZ/Bt
   g==;
X-CSE-ConnectionGUID: gzs+WsJXTzOVBm+S2qfmDQ==
X-CSE-MsgGUID: 6kQDIj10R2GREAvyiOc+EQ==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10852319"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 03:54:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li0bVvFqOkHv+ivSjtr0ObOkrfOxg13p5CmMkbJVqAHKY6c72bfGmg8OwBkofh3AU+h4GDiUSLMjHcg/EIL2A6j4NCvD+N6IE6frnkNI5x/bnuid3JmCcfnOI6XFqpMQSBkTFEh77saefUPTNHaY/vYToT7iiDx/ioO8xumkD/V2+emNZ9JQ/VcQrgquGkaTw4mgumToGB1CF9tGDl2zH5xkQYebr14bV5CYaj50pVwPcDP4U5LOh5TJXy9eS0AWyh3Avy3xWOe5lt7Btc2YjYBAjDvXn4oP1K+m30Vk95QcOKGWhEMRInV1Hk5PAw0r9aCmv8Qu5CexgMZe1c3Cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPC4HJg/aRQseqVNTQHztB1qPgpM0fsQLomTFlZEZmk=;
 b=kMciqOG2hR50aX983kUG8WJcNwqIW9BNm5AGVi7FbfwIE5El/1wulKr5ab3lrBBuV6Xo4QNyDv6EkBFVy/RzRxU6BUKqoA4Jm9uk6lxYjwG1U9aGUGvjdg+9oUQbMmSm6/puwwW9Bwe0aI3YSMcTS2O4afVCl01K28oeR/DDoMOgshqWUG3j8rwDb8dhSINW1CftkijPCdtWJg/w0k/No+nRuTOUZ7FKS1Urgkh4eVBDY2HTIsTKwY/1GV20T/7KKqhX0ezmLFRzRSZ9I7/3WMGTDKM5C8lUKfw/NbNms/9SL6DbYAnJ2+WUYrmQI6bIMHlgsTSTL74X/EXpSp0ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPC4HJg/aRQseqVNTQHztB1qPgpM0fsQLomTFlZEZmk=;
 b=bapA7lZKEJFyaCbLhUxJRy6hmrBbbesqFAal5PlJhw8qMpUPyQOHOcyKkYDa93S+jkqgWOS6TiJjsCGtniB3ZbcEf5IBh2jQ7zXtFbaW35Mpgh5soevlB+VA7Dx5yKTE9ZZwuNlQctm8uvyM93iPnKFoAb6yN8Ry2NgtTOOmVCg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6718.namprd04.prod.outlook.com (2603:10b6:208:1e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 19:54:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 19:54:06 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bean Huo <beanhuo@micron.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Topic: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Index: AQHabhW5jyV//9miXkC5d2tkHZoCC7EphUIAgAALvJA=
Date: Tue, 5 Mar 2024 19:54:06 +0000
Message-ID:
 <DM6PR04MB65756C6716317F7E1E47FF50FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-3-avri.altman@wdc.com>
 <4f766df0-b1df-4e5f-8acd-31710ed4399b@acm.org>
In-Reply-To: <4f766df0-b1df-4e5f-8acd-31710ed4399b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6718:EE_
x-ms-office365-filtering-correlation-id: 71651a9f-b2a9-45b3-929f-08dc3d4e03fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EM7ooMUlDsQjuVM8sA7832+r6GWShmtv5dekNVxTrg3ic87m+6fdfWCrZ4OwYlsnvpMuZRbn+P+v42e6uABqKbSONQSY+4zY6NPpwIYuPBzlm+1af7HPysYvZ7Lm/2Y4uN1S7VZVZIe03RTsGELhqEJOEgl3bRGRPqKhMiIAy5W1dGNhPhTUWTbqem9wmRyQPe9UI/p6TB5Vuwe7+rxZMPS5EkOkeKL1+Azdq9G80BpTGPh7N8dHqqOPCXYXSMI7T3Cjiex6yLbVyjclSxoqbpwBZlf33Tnf45DG7yuvGkp+VmTVRnCN0A7LiWic/MVHRvzQRAoFfulKddId4F/SWKytoyiagz9GOotCf8U5RL28kMNlZxy658Tlaq/rY0+zeuEd+lJE7C6B4Ye4Tk3tW0rujLNUsxkT+omvyNWd5/r7+3R5if9xjYj+xbJVlpyDpBc5Ntk0hF6EftnfuPRfTaToWpO7waU+20p1wODhA2wwnu0N24Tjz0vuvA2F/bDcbCD6vvAobQZpJ1/j0u2HMvry1vdX6Q7P8+QesJGXc6W/aQsE1t34Gv67AhUM2SnTvvyrLEqsXumX+uFvHkWqZ0jnADUCtUhlbXEoqoIeGrfexnTP8W9MRg46hTYa2QHX5K2f0BydgsCt9zpwxoNNMovZUqQKybeVPesHCifXJVu1Ibl086DR6PFLsk2nq0KtCJC4b00cNBBSh4ATTJVXqg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2ZoWXFKVm5nMzNsU3BIajBHSjJtbkt3SWYrQS9xVzBDQUZINFBxcGJxV2dF?=
 =?utf-8?B?QWowdDBIN0dKK1lhVitiTEZ2NXVBaW0xN1M1VjhqVWY4SlBUS1VUb2tvYjdy?=
 =?utf-8?B?R2owV0FuRkFvc3pXSnNkQTdtTGtEamd2azFPSVAzVkNUOGU5bGRneEljUE9W?=
 =?utf-8?B?cS9lMmZQdzkzcm84a09BNTB1am1qbDh3dzhqcUljRjVvMm9ORUpwR3RmUTRw?=
 =?utf-8?B?czIvT2IvTklmTUQwNDBBcEIxaU9NRVorbVRrRHRqbU13bHQ5TkRKRElkeHJK?=
 =?utf-8?B?VmFSdFQ1QzVuTFQwKzkwd05xaWtYdDh1UHNVd2xMMzNLMFBvaC9Qalc5bm9Q?=
 =?utf-8?B?Q1NtbUtYUCs2MlIzQ2FQUmRHNnFSc2IwSWQrZ2k2cWZ6cmltaW10Z0ZBQmto?=
 =?utf-8?B?eVJybkZIclNMSStBT1JFTzZ2ZjhjSVFUVWg0dFZJNE5lbUkycU1HOG9TTDZi?=
 =?utf-8?B?QzFSTkdjbGI2K3BSRmlLaW8zbjk5QzNDc2c2RFczWHRCZ2l4bEVUd1VPZkI4?=
 =?utf-8?B?SnFGanNDcEpqSUtncEF1a2lDRGR6dFNhc1BVcnRzVHNXek5XRHZTQUsyZjVz?=
 =?utf-8?B?cVIxQlhtcUtQZjF5eThQYWk0M3dUWStteUM0LzErWGdWOFhXM3JLc0pINDBs?=
 =?utf-8?B?c0V1ZGlIdTN3a0ZxOHIvZWJRY2paTkFRd0dJbDJ5RXFWRHR4aUFENXpNUmdL?=
 =?utf-8?B?Z20wUGlMMXRhSWNtWFMrOU9neTd6VFhMNXJEVmprS1ZyWnBndXltWjFZelVk?=
 =?utf-8?B?QWdXaTdBQzdWZXdGZWVOT2lweUIvMlgvdW9FY0ZyTmRQbVU0MnFyanE3Vk1O?=
 =?utf-8?B?NHI1QWxBaHhGOTJvR0l5NHlHZmRrVnJwZlFZY1Z0eEVEdEN4R010ai9xajlK?=
 =?utf-8?B?ang5ZUhXSDdsOEdyWlB5TW95cGdHSW5Uak0yVE9zTUgvRlJSRWpKVHRNeU1r?=
 =?utf-8?B?eVpxQ2hFVnQwUVhqY3c2Yy84cWJKZDJ1dkMrTU1XSFVGM3FYallWNklVNjdw?=
 =?utf-8?B?Z3ZIM2oxb3pTTEZVUE5jWVNORk9XSG5nYklmZTFDNi9lK0pOSzA1d2k0dHlY?=
 =?utf-8?B?Y1d5MGI4ZlVFSU54NnhpYitGWjE3enlrNlFWWUVPc0ovanYvejF2L3FzWjZ1?=
 =?utf-8?B?T09jY1FSazM3Qk5yTkpOWXA5Q1ZGNkNRWEhJZlpTcWhvTGs5L2E4OXdWeEg4?=
 =?utf-8?B?NEJGQ2FpVjFCUFYxbU5SNFZicENlSWhsYzFTUjh2REpHZzduWkg2R2hRbHdz?=
 =?utf-8?B?R0w1RW5ib0tnMVdzUGF0WFJodVppK0pPNTViN3B1ZWJwTlU1K3lTRFhOVXVT?=
 =?utf-8?B?czI0VlR0eERBdGt0UTkrVXhyUzIxTzltR0U0bTEyMjJUNURhZ2l6RW11WWE2?=
 =?utf-8?B?UEFSb0FXakkxeFZJSWVwU3M2Nzk0UHhGMFM3eGJiTTZ4TTFrYS9ld1kwRUVl?=
 =?utf-8?B?YWNSTS8vUHZXelVsUFhsWGNnNG9jWlZCYlFXY3Q2d05GVDdVeWV4cUZYbERi?=
 =?utf-8?B?YkNITTFkWXpMMHBPSDNpR3VCRDhQOUpLQzE1U1VvSWJYTFlLWndSc0lnT3NB?=
 =?utf-8?B?L3lEYTZnd21WL3BYMU9wcjUrZDFtNThxVDJTSFQyVkVuYW56ZDdpUUVEeU10?=
 =?utf-8?B?Szh6YkpDL1JoamRTUkk5UlIwMElJOGF2S1oxU1BHQTI1ZGs1ZDdONDBWbUNl?=
 =?utf-8?B?Mkl3YzYvdU9tc3dVOUpva0QwR0o3TThPQ3lNYU5pSU1QUHBzcjdnaE1CK00z?=
 =?utf-8?B?MFl0c3VJRnNOV2hIdGNEbHNHTzArT3pwOXEyWGxsTkRWeldnUGk1TGFaQWht?=
 =?utf-8?B?SjJpMmNBbno4NmxRdkp4bjVaeHdFTDBlRjdKNUd6dnE5OHFqc2RmMjMrVkYz?=
 =?utf-8?B?SjVxY0pEcHBaaDhqUlM4enFBV1ZiVUdxVHpGbmxKblRYdkhpZXBrR2wyaG50?=
 =?utf-8?B?SURFYTZkNTh0V01xQzAweDA4enJDTnFpd1M4WjNzN25PSVhGRGhOb01zNXdE?=
 =?utf-8?B?R2hQekN4TEh6eTgrQlE0Yyt2OEx4NmsvZmdpMU1IcTlZV0tPYWMzdm1NWjNG?=
 =?utf-8?B?NTdpc0FHME9lZmZEVms0czZTVGhUTDJYc2U5bnJXRjFPTDNYb0h2eWd3NDhj?=
 =?utf-8?Q?caoHacpcRu/BD3kTyh4i2G9bK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OmoBBd45KuRycsC/iZgGRhgM/X/NQg2psK41aLyqj8OItnWVxnDiRMDkUmp8VQfeVFHE+9C4U5RT5fSUMUUADzDlRL4ASsgx9p8jC2SMchy/InQ+TXsOnYjoKWq8Q+4tso4kCOkFUGxZ6PEtkPFe62HOXkdiAazWVF6SxMoQffVnPTztJNcwXKUwPtwN/jU7c75MD5lR06bYZbyz+3PGF1XtVHqmtg6B5Ra9oedNUeZXSp9FLmhGUkGsYnQPVjrBJsRZMrYUsxFkV9j+333TdpI9FX8648ZY2tT2GkCm9b7JS+11wEMv1NWpwxBrEAm/MXYRHKwdYqqALlaBDzjz1VWxRnWOBQJkR0oieG6bnXCIJ8GfLBKzSG9wX9QTKlxzAX/BPO/ccQheMWh56FYl+H/GRfkLV5p1rWQSarTUlVq/IGzcUwWPcfz0Hj7pfFqcI5YdUgq/jQHo2WzwmtegPYiar88ztM+hfOVDbunV4URzbJaRQwMqIu1T/Hqv385lvANxfPSz9VZ9T+R4fphhHD40ZdAi539iSdYjHngLC4atie8C6qcbs5w9tjUwN33NRzOCLmOJc3aTGFxt7S5CsQB2j5SPRjZjr39inKJ/i6ft17tv8sfNQCz+gIWCXGcR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71651a9f-b2a9-45b3-929f-08dc3d4e03fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 19:54:06.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXh7u/EYPJxYvLakAfWmcYQX3P40xAO3LzBJo9HDRAh/Dkt5xWjpusiwavRJlHkVyyv9Ls6nvJFikVNNME+7Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6718

PiBPbiAzLzQvMjQgMDE6MjMsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IF9f
ZXhlY19kZXZfY21kKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHN0cnVjdCB1ZnNoY2RfbHJiICpscmJw
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHUzMiB0YWcsIGludCB0aW1lb3V0
KQ0KPiANCj4gUGxlYXNlIGNob29zZSBhIGJldHRlciBuYW1lIHRoYW4gX19leGVjX2Rldl9jbWQu
IEZ1bmN0aW9uIG5hbWVzIGluIHRoaXMgZmlsZQ0KPiBzaG91bGQgc3RhcnQgd2l0aCB0aGUgdWZz
aGNkXyBwcmVmaXguDQpEb25lLg0KDQo+IA0KPiA+IEBAIC0zMzAwLDI4ICszMzE4LDE1IEBAIHN0
YXRpYyB2b2lkIHVmc2hjZF9kZXZfbWFuX3VubG9jayhzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhKQ0K
PiA+ICAgc3RhdGljIGludCB1ZnNoY2RfZXhlY19kZXZfY21kKHN0cnVjdCB1ZnNfaGJhICpoYmEs
DQo+ID4gICAgICAgICAgICAgICBlbnVtIGRldl9jbWRfdHlwZSBjbWRfdHlwZSwgaW50IHRpbWVv
dXQpDQo+ID4gICB7DQo+ID4gLSAgICAgREVDTEFSRV9DT01QTEVUSU9OX09OU1RBQ0sod2FpdCk7
DQo+ID4gICAgICAgY29uc3QgdTMyIHRhZyA9IGhiYS0+cmVzZXJ2ZWRfc2xvdDsNCj4gPiAtICAg
ICBzdHJ1Y3QgdWZzaGNkX2xyYiAqbHJicDsNCj4gPiArICAgICBzdHJ1Y3QgdWZzaGNkX2xyYiAq
bHJicCA9ICZoYmEtPmxyYlt0YWddOw0KPiA+ICAgICAgIGludCBlcnI7DQo+ID4NCj4gPiAtICAg
ICBscmJwID0gJmhiYS0+bHJiW3RhZ107DQo+ID4gLSAgICAgbHJicC0+Y21kID0gTlVMTDsNCj4g
PiAgICAgICBlcnIgPSB1ZnNoY2RfY29tcG9zZV9kZXZfY21kKGhiYSwgbHJicCwgY21kX3R5cGUs
IHRhZyk7DQo+IA0KPiBQbGVhc2UgcmVzdG9yZSB0aGUgImxyYnAtPmNtZCA9IE5VTEwiIGFzc2ln
bm1lbnQuIEkgZG9uJ3QgdGhpbmsgdGhhdCBpdCBpcyBzYWZlIHRvDQo+IHJlbW92ZSB0aGF0IGFz
c2lnbm1lbnQuDQpUaGlzIGlzIGEgcmVkdW5kYW50IGFzc2lnbm1lbnQgLSBiZWluZyBzZXQgdG8g
bnVsbCBpbiB1ZnNoY2RfY29tcG9zZV9kZXZfY21kLg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBCYXJ0Lg0K

