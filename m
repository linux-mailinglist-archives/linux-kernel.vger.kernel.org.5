Return-Path: <linux-kernel+bounces-96105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DE875722
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F59C1C211A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB0136673;
	Thu,  7 Mar 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M0kjTEX4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TX+Pj+xv"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFD1BDDB;
	Thu,  7 Mar 2024 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839742; cv=fail; b=P9Nt2iB/02AhImjxqnFJahbDoie3z1eM61Heka62pcVkj7gxDqX9y4r+fPcR5rkLk3ysA76SjQ5bSkFFq+qDGfulFYPt9yc1gNECymrePHEy8B5iTzcO21+8UftJU0AdgzCvXdPrL8Qx8W9dni/KaRSV6aL4FDw6gb2g0ckDYaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839742; c=relaxed/simple;
	bh=8V3X4E6LHdFb1p8z9A+wgnZ2YCnxtmIDFFuzwb+fP0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joq28qi+lrRu3pT68q9w51Od85oa/JPmX2WlgGMIei2hOkHtGJlEdiHKd2QlfboJ+k8BWN8qkom8D/S8suJPdnTXvv+8Uc0KmibhssP42s5puvuRMHTeljmLZPqfq8CqCspMVGUqNO7W/YweW4h4S1nCHT8+tD11H3qCoFlu0QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M0kjTEX4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TX+Pj+xv; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709839740; x=1741375740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8V3X4E6LHdFb1p8z9A+wgnZ2YCnxtmIDFFuzwb+fP0w=;
  b=M0kjTEX4qpCMWreWNybNWPqqcTovENhQ/MIX9bs18ljj7YN647bnLB2B
   bSZeY755Cw3BtehiQwpfSK+8JMkhVZ1mBoJVrcW0wiBWYmMpj1USydF7s
   saovJfwMjHqjJIUXf07KZy0N6Mk/NoadE6CF/h3IRgjQz9dVuOWVMWV2/
   faye3DKbzs7c+13XUTQCmeTXz0axE702QR5bB8z7LC8/Q67AmpePAxdnv
   aMtmJpvBhO0TohkI7IllnufLlHycCQ7fq3Z7vkxO1M2oNiL3gsDHtVVEI
   nnwu2r/VaF1TndLRyrh8g3qXx7tnWuw9hB+YynIDAjJVuph5Rr/hwVwyu
   A==;
X-CSE-ConnectionGUID: sikvBcc6RhiMw90+DsWBaQ==
X-CSE-MsgGUID: +03fO9HcSjeVBnrHNZi1iA==
X-IronPort-AV: E=Sophos;i="6.07,107,1708358400"; 
   d="scan'208";a="11665020"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2024 03:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUDksSRXgtiwLMBXtS7eeNZty8/qt1khIl5NTeJCYfer0HKSjjWbPrHRtKMKKhMFDAKQhJeK5GsJP81HFpASucx1+g60mZuBT9SRuhlrQhaus/QYJ+DRmatWybNS4ttYlOmJrZRbeOhhPoB4hJ9Ur83OkIQna16ex3wqP33QaBOM8sbx5NLe1gG68qob88SQm36xDADR8tVycMOukXWwZysxEoi/v9jWQB3Bia2M/qzHxhvFM1T8zgiebUDBcGTuIHKEouf/T75CKjFK3eHrQIRRG7Y94MHO2DXK2RuGR6e52JPsaLbVfCal3DNa+DJHAvxw/6Qr1Zf3gRaqjq2TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3X4E6LHdFb1p8z9A+wgnZ2YCnxtmIDFFuzwb+fP0w=;
 b=oZsQwjtKFfPGEYNj67+aaNwbTLgd4uJerckpJFXadiXUuYeEasgsIII+4jG1LyxvLhKE8YnwbkriCpuARSDloy9l2zsm49PZhposbA9BytK8bLygbUsDw1Eb0gbwO3tyCauucoPlZgdQhdkmwEKOJKV9q7FnLgp7+HpDCRCBoTOXaWjJEXACmuD4D0ZMxJY5n/B+8KU8yCLqEY184mXQwdxOKucyMvA918Zg/6sduTvHNynO4NfsdRwpR1whe9LxWhLwLEmwNVFDVTsPDyO2QiJ14K0txmKQbT5r8QQDTiC9CNBy5Rpjky8LLZeNl5EnIyoOSnjxe/To96XtvX/qUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3X4E6LHdFb1p8z9A+wgnZ2YCnxtmIDFFuzwb+fP0w=;
 b=TX+Pj+xvjoYxWjfsSDi5S7WhUWRgZjyv4tARimFjcM7wMANQEt457HYb93rcdcHeY94QNkcg1Fq5Lu+tUqe9l5gcdkmwtz5qpir4mEd6hCdtU3r/nb8dW0foOQ6pBXWM2kAhx9nM78g6PDnbUzh3jse6CEtQYae3en9kTFG+mEQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7683.namprd04.prod.outlook.com (2603:10b6:303:a6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Thu, 7 Mar 2024 19:28:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:28:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <huobean@gmail.com>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Topic: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Index: AQHab0BKI7cW0RmwrUWKY2Jh4C2U8bErRjmAgAFmNnA=
Date: Thu, 7 Mar 2024 19:28:58 +0000
Message-ID:
 <DM6PR04MB6575A5D43DF0589B480A4EA9FC202@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-3-avri.altman@wdc.com>
 <6c75ce4cc05c6983137e954043d5ae7323a96172.camel@gmail.com>
In-Reply-To: <6c75ce4cc05c6983137e954043d5ae7323a96172.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: 8668a1e4-2778-4d22-b717-08dc3edcd5fb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +dG1FW4bXBEnYf+FEG7l5Zsq4TTh9TStoi01fHDHwuWBfuQxXDw8sGgvGW7Em6wyA4NfwZnx18XGVCi+yAz+czfVbiga/87F9xlnOI69W0adOTzU/w6aeZG23qzSX6XkwAzDnEg+4YX4qFH53vSsrVXFTXCclTJNZ3Q8DxnR/vCs+0CdARDZ7eb+ENqe62O0RzkAQnemdjwviczIC1oQ3XtGifa12P6B+yZ1+1s2C+aiGA5mGjebXaWSfQoC56lOXdGK1Q975YszAM7reJNubKcHEONigLISc4dS1ZhSJYRqDXQ8BnHdfvcQQq66HWc2rr8V+wZXK3/xcfKJwBqAPsBngRu3dLj73Lvce2tR/C2biVHZojdE3WFMkupIYnsD5WMeBAfjcrzxQlX6SZXcS6Q8MsWRMn8MuURhhG/I4vjt/b0Tiv28Ngk6/22VpStY2TNuWNdSloZzk3Cs2Fxr3JfLxbjwj8DnSiHqbmbfsUBcYA9qcKCMOhO6eBTB2mZa1rWYGUGH294m4T8TJVuInQxHpJqMJbtCCPEjlpPPFZiavrrTR2jGYVGlRMalcnVulj0PYpdn28+tnvHSqyEVdJLZ9L6gEdayUuU7LIGHob61T1ivDUhLcSCL2bDLlsj9EN6EnZYqfY0ENcs7IkOMmTJX/VkPyNm5wCvBeBFuqFEujkKXALBCHGiUTNwTilq9Z/dkfIUImZ7fR0XhBPF85w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T09weFB5OXN2T2k4ZGZjZWZJMGJ3cTFZNm1GMnpEUnE0Z2dwcEpMekRyUXJn?=
 =?utf-8?B?OG01OHFsVEMxc3hQbHI4OUI5NU93RkpoQ3BHeUxvODNuL2N0MFlsRFBuSkwz?=
 =?utf-8?B?TGxoNmNoVVkxTUp5eW1hdDhKNmdGVXZpTS9HWE9Xd3A4UE00SDJ1Zm12T1dw?=
 =?utf-8?B?c3VvckVWbS90S2xub2V3eDJnbkJkQ2xyai9LZ0ZJazA4eGNGQW9PenZxZlIy?=
 =?utf-8?B?L2VQNWNUQlJsbGpLMzZTNzB0Z04vL0FmdG53Z1hiQlloY3ppVlNmeG5yMEEv?=
 =?utf-8?B?a2hPcUNBOWtpcU1uMWR6NkduTko4a1ZlbmpteWZhWUpWcGlFYlRFTzR3VDZy?=
 =?utf-8?B?M21IRG1GeFYyTnVGWmlrdmdaWkV2RnlDTzJtUzlLb2JLL1BCeWlyai9ITCtK?=
 =?utf-8?B?NXkwN3lyUzM2bDBsNXhHT0FMZ0w2ZG96SkNCelpEb3h3eGxYTHphWk1wRHhN?=
 =?utf-8?B?NWJEYlduRWxWdzF0OWVIRGpnUFdyMGdqcmlvS3VRUk1JVWxxZ0owLzdmY0Ri?=
 =?utf-8?B?dDNjNnBKQzlPZzdIdXI3TEl2cUI1RlFwVDdaS2htb0x1S0JETStBNER4b2VN?=
 =?utf-8?B?SzVsSG1pR1dhUDhaYVFVSG5haThhTWUvRFpTL3JKdERPS3NzaFJGNERyWEIr?=
 =?utf-8?B?L3JYemt1ZXJlM2s2c0JCK2VndWlwWndhZ2VTRnUxRE9pMGdWa3ZBdmtRSlkr?=
 =?utf-8?B?elpSUzNQVDAvNTVFN0VnUWU1TWZOdXQ0RHl5Qm9zZGJMQWl1Qk9mSGFYZHY5?=
 =?utf-8?B?YjdnZTY0ZGlha01BdHF1T0xxbGF4d3lKbWRrVEl1L3d2QWxUbzBNamVYc2Yr?=
 =?utf-8?B?SXNBRE5Db1UyVGlRak5wb0daY254RG5Tbk9WcjNoUDc1UTlkbGVuUFZ6UDNR?=
 =?utf-8?B?cWZvWHBjSjhjRU5EaXJVUWdNRkd6VVhiUCtSTElQRWMrdENlNGhBM3hoNlRU?=
 =?utf-8?B?ZlFqT2tHUkJ1cWFYWUZ6UjFNWm1aZGYwbUIxbXJ2QXJSMzJKd1Z2WjVraTFn?=
 =?utf-8?B?SGNoN3l3dzk3SXAxbHhYNnFrTFlkb0xOUDd4RWVUSVZzVWJIRzFBam5ZWEF2?=
 =?utf-8?B?V3FNMGtiVFMyZFBQZXl1aDZKN1hhc2pxQWJOc1lzTTJWdi92d01zTm9waG40?=
 =?utf-8?B?a25SY0xEaysrYXlYaGtpZUVlb2lkZHVjWUlCQ2RnQmpvSW5oVDZkaS9CL1da?=
 =?utf-8?B?cU9xMTNkVm43aHdsUk43ZGRmVEpRS1U2WDIycTYyaFp1MlhTbHNaZHFOV1U1?=
 =?utf-8?B?MVdGZUhGRFFpY1dWdGZSdDJIUGdKdXRTZXVkRUQ2KzZ4aDVGL1FXVTlTMzA3?=
 =?utf-8?B?Q3NldTFoZUtHbnVCNUZhSUlHNGxVbTBYSlFQZlZzZjZrR1IrZzM5VWVhTUxV?=
 =?utf-8?B?QjJvcVBRTXpHRDVuRVdpTGprdEpzTXd0M0UyVm16YTJuR0xPMGFJOFk2NHVP?=
 =?utf-8?B?R1lUVEgrcUlFNnlCL1pEU1Q4K3MrOFRIQjIrY25YOW9sbVFGbVR3NXJyWkwy?=
 =?utf-8?B?dEFISEt4dW04SzFwaXhjWWtkYy9zTVdRVXYyNVdzMkg0VjRTSHFvTFVFZ2tE?=
 =?utf-8?B?OGhWOHJGa01nekloRDlHVW1yZUhSVnJuaVBJa2FWMFlTMWovOUFLUnNnYnJy?=
 =?utf-8?B?a1MrNDlyTTBaTDB3NmNOTG5XS3A4eWhoWjNMSFBPelBPRDdHejNZbHlsV3cz?=
 =?utf-8?B?QTJSRVZCbGlPakhDWFNKZ1NRdUtNYytTVWhMbTVQTGJrMjRCQ1BWaTRLOFF4?=
 =?utf-8?B?M252VVNPZlpzZ1Rhb2xtRHN3ck0rNGlIUzN0UmZlZytpbDRISDNrTDNXdU5Y?=
 =?utf-8?B?Y3lXZFdoWUFRaHVmUkRhbXRwWkhMb3hGVmVzczEvZTduZXZUODNpZ1VSanoy?=
 =?utf-8?B?MlFlVXBtRlJtZXFnZ2JKYTlnOXdhTzdnVDczY1FoQVhJcll4Q3VZOWdKYmJY?=
 =?utf-8?B?MjZLQ0txRnd0c1VMc2VKWk1DNWF5ZVRoejI5VENHQTVnUnozNENaU1BmYkQw?=
 =?utf-8?B?KzMwZHpvWEZsTXp0WVRIbzJLcVU3NzNSUExqSXh1NG9laG5rWDV3QkpEd2tH?=
 =?utf-8?B?VzAzNWpVN0s2cE9KdE5lcExpTEZ3QjBCMFkvRVVwUDBVVjM3dzcwV0dPd1gz?=
 =?utf-8?Q?+cZfF0JPBDuAbFgoQgXutKU2K?=
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
	2ybsEYq6iqWYouMa46cObwiG84AXlQnTMydiRR3Uek3btyf3AuHAdOmCA71x5DFELPRaQhq+tvcpwHmGjCjrrIUzmrN5qfAfe5HeMZT8dAuZuIS/LOZR9fjbGy1nhvPl9SsdnIkEVtekY3k1zlnWBh07vKzIV317XaOI9SBEfPOKHyqYHbiUwC3YXWLM9toptO4PPxnXf2wWkg2FK/tcz0I7kFPZsVj6k5DKMnsXoWtGOK5i9hoVi16cqUZF6p3+HV9x4bvKEHzQd0Gu9qv3rTluZk0uM28f8vSDsS4+gHmP1VNNym9EAitM7oq3WrfF1QNF8Vq8fOzKG7IMdd7RPryNNxycezRAzRXP1Sp7LX2mWkI1PR7zEHYV6ESwqaE9XbklcYKYv5dAsBkHdgpzcKn7aZdqmvL+iQupxyPt3gesiTfUBP6gA+R38COmi0Nlv7/hQdNPFors3kLYOx1nSS86NdPeZwKDQxw2bJHPHebM1xu6y9l2BCMBxFzM+jY59pWQCp/g/tHkkyaYyv0ik78u8vh5aGlVSuMvmgwq4j9Yy2JFRHPhs7oluYz5jTmoGqhyaQtVM7orAUaQwbn8Fxy3EQpWlar1IkMt6FAeKd54jFvzPmKPxG0DUv5/4tNt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8668a1e4-2778-4d22-b717-08dc3edcd5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 19:28:58.3337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrSbFL+lhkMuSbof4Sh36M/mVxukYKVmy0dmAtp5qRrjgllP/mKtvz6LzIAzkL8iRmgREkaVgW4pP53FUrL0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7683

PiANCj4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDIzOjAwICswMjAwLCBBdnJpIEFsdG1hbiB3cm90
ZToNCj4gPiBNb3ZlIG91dCB0aGUgYWN0dWFsIGNvbW1hbmQgaXNzdWUgZnJvbSBleGVjX2Rldl9j
bWQgc28gaXQgY2FuIGJlIHVzZWQNCj4gPiBlbHNld2hlcmUuICBXaGlsZSBhdCBpdCwgcmVtb3Zl
IGEgcmVkdW5kYW50ICJscmJwLT5jbWQgPSBOVUxMIg0KPiA+IGFzc2lnbm1lbnQuICBBbHNvLCBh
cyBhIGZyZWUgYm9udXMsIGNhbGwgdGhlIHVwaXUgdHJhY2UgaWYgaXQgZG9lc24ndC4NCj4gDQo+
IA0KPiBUaGlzIHN0YXRlbWVudCBpcyBhIGJpdCBzdHJhbmdlLCB3aGF0IGl0IGlzICJpZiBpdCBk
b2Vzbid0Ij8NCj4gDQo+IGZyb20gdGhlIGNoYW5nZSwgdGhlIHBhdGNoIHJlZmFjdG9ycyBjb21t
YW5kIGlzc3VlIGZvciBicm9hZGVyIHVzYWdlDQo+IGFuZCBlbmhhbmNlIFVQSVUgdHJhY2luZywg
aXNvbGF0ZSB0aGUgY29tbWFuZCBpc3N1YW5jZSBsb2dpYyBmcm9tDQo+IGB1ZnNoY2RfZXhlY19k
ZXZfY21kYCB0byBhbGxvdyByZXVzZSBhY3Jvc3MgZGlmZmVyZW50IGNvbnRleHRzLg0KV2hhdCBJ
IG1lYW50IGlzLCB0aGF0IEkgc2VlIG5vIGRvd25zaWRlIGZvciBpbmNsdWRpbmcgdGhlIGJzZyBw
YXRoIGluIHRoZSB1cGl1IHRyYWNlIGV2ZW50Lg0KRG8geW91IG9iamVjdCB0byB0aGF0Pw0KDQpU
aGFua3MsDQpBdnJpDQo=

