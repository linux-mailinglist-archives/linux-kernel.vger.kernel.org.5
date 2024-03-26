Return-Path: <linux-kernel+bounces-119656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226188CBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B001C3A643
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E786AC0;
	Tue, 26 Mar 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FIFJSdPp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kh5WY4Xw"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9E84D0A;
	Tue, 26 Mar 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476596; cv=fail; b=M6Yykccf2EtK6Y3GSHbhz5Etvsf9J6G+VjbsWFE1jFvdHA7y6UAPtQEVg7FjwNsJdTrlL9n+1DnIXDuO31bf11M4/T9aaLV8XRZYXUdr7t8Vig0/gadp86Rqnkep/j8pDOz9kAeGq3BRZiAngAyF1AxDGeHhhI9/O7sdcH1zlh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476596; c=relaxed/simple;
	bh=XZgXAsKUNlVHX5HpGLmHJg5fOfLYvH6rjPtPPdgh6Ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=boev5/VhujD88g/1hg/LRBgyZGRnIXWIrKDMI1hmrISKAOcsARSvyIaQsfx/Uj62WyGvT/l4yCvARz0v0It/dOJ7gk1AbE/C1vxcgP0tBkni/wgGtIs1jQm4PGD3/XDbeXCbZSMcVkmcBi8pFNQMi1sV74DfG0nCBRTjj2DOirg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FIFJSdPp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Kh5WY4Xw; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711476593; x=1743012593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZgXAsKUNlVHX5HpGLmHJg5fOfLYvH6rjPtPPdgh6Ns=;
  b=FIFJSdPpy6O3xJEAi5kAXIrvz5yD6seTTcN+wQt/xg9l9Oerl+poxvHp
   kw/Sw5DpO9mVslURwXj0SVtRwUw6nw8Xx1aZZHuz3f60zvj+mO88JvPtW
   caRJsjViqpERTDVr58btCPT8jzEe3u4P6nKQHvoz4CkUiDIE7Etu4KYAs
   /dUG1YevbsRgDOEWz+7AkLYj/VCUo4WDOgMP/A792zAjsSPhH3o9ipiJy
   BvDgnVYP6/LS/G8ujf+LgtfzuMLA6rLhajKqNW9d3XM+c5L+OQ5qAORDo
   WdMi3hRyKpy6JhT9UEAw/sld1d+MW/ci1yNXPmBqrldgnpL++n3PsDcau
   Q==;
X-CSE-ConnectionGUID: YVT5+DPVSuC0+y+kNLBvoQ==
X-CSE-MsgGUID: SqrdundsSrCSCyzaJoDQ9A==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="12528316"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 02:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOAw/f1LQSFHaOy4064HBlizrk2lqTZjGqFeGshdioUhz9VrVLsfKpDk6zaXbGvEaK4iR6TO12aNRKFypahIr//1Ymnw9waWvbRjIA9MMtcEKTv+lrZtxuMUiLmMGJ/TqqaIQ4CK65VRpYlIT4DOWWVVCC1izby1rbWzi+ANiMxifwhn3Xi3oSEC4rgH+vPGnHJbngpztLQiS3LZSNo5xXk47A9lpe+vo9/zMgssmld0/qdw3QzKO+GTsJ8jPK3o1ubGYlsNQ0JUGwMmGHaImP0jBoqXIZFZ4Q/eEDbQg190j9puj3yhCDF3ibKHLFbqdNzNs4XZwXtEmtTuHWszyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZgXAsKUNlVHX5HpGLmHJg5fOfLYvH6rjPtPPdgh6Ns=;
 b=dlWXrY4A6eyCCkaDGID5OhhnYdUF36pdZfZJMBSIChJ9pEJX9+DWYns6whMbYfYZEhIqyfhA+wRCjUM4sq7bvVPhQLdAlDJj1IevEJT6WBq9CpDSbODvz5Zn5lEtpIP+Yvx8ZETbnJ9GDwYGwlZSenjB0LsDLiovg/8oFseqKRIN08LvWveFERM6so9cHWLYKwYgHQj888rN4WyApZTW7S5J4Sg2rvmuwY4hJM5gpHO7YhkXS5hJV7lISMcizJCk/q3DxqKmu97ZHqMKji7TDh37+O9teeTKAuQENOSY9iIgvveRzL1m/BwpRitZe8bBtAAEmfB37W1E1Ke9Jh0XVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZgXAsKUNlVHX5HpGLmHJg5fOfLYvH6rjPtPPdgh6Ns=;
 b=Kh5WY4XwoxmqhvUqswODrwZqkBu+yiWFCGqXQ2KWpNdFaO0u1+85vdO45RD2jY41dJMSycq8RvG5qo4oHJz45bbzymAxd99hq9W38UIRS4t3Nak7rdVtEpY6ZaEGRC04azkJ/IRYWGdl+21LbrhByxCAD2MedcsAdySQ3xWhaPE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ2PR04MB8581.namprd04.prod.outlook.com (2603:10b6:a03:4f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 18:09:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 18:09:49 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bean Huo <beanhuo@micron.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHaf1hBCRqbUYC+WEG5POc3Xd9iP7FKRQiAgAANpXA=
Date: Tue, 26 Mar 2024 18:09:49 +0000
Message-ID:
 <DM6PR04MB6575CB8F8972B09DF4870230FC352@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240326083253.1303-1-avri.altman@wdc.com>
 <20240326083253.1303-2-avri.altman@wdc.com>
 <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
In-Reply-To: <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ2PR04MB8581:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 80x0THKNyeUOus1PHzHMuANak5BvKZSJYD+sukabd/UDlRDSblOWYf53/pvqSDviVHfYYUBXtPGqibxOAAwu3CDpZpRY0LyRiJiqjnh1Ajohc2qRKEEdDwYuYwNVsikzNzlb0/R9HCUNR3j5AHGwgvOXpB8dR41OE/JkBXapkVYz55emObXgiHuUYBPOWrYviNV2w54DLAYFiUxFcpdBUl7uxBQmvE/+eHKkhIOkFb7LJr3H6RMFfmi1kfjU9Rfv9cjZ9KBEzazo5BZJvO8lT09j6dOKKFsqTbACzuqwSPUOOcdqgZEiZWoDQ0bj+Piaq1RCPcmJNs98CPMmbCUAnrEPqVgs9gUUQWDOj6Q69/nYWaFedUXqLdRiaL/HNO5+oBpfb7qgaNhJgprAfM4ApaQ/imY/LD/r7GNPGqPDfG7MK28na6eON/o8ysNwu4JDanc9HAhwf5Zt1Indm/eimMN7rZTOleJWKoPwNDNmLdRiACRBjC8UXZARTfm9Qp798utg9JUosFWBST6V0SUKKTlAVtpyJFu8cwUqnSbd+BNP5zHTuKfhO+jOVO0rBm3IXkQQAddEnfqONl8H9+fUcAiYRfQVtfPbFfBvF+ew26YC6zJ4kZLE8EgbSJkaR+yGtaD/cXkl3TFmpytmY9UvGw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2QwN3pxRXhqSElRanhuRlFxZDhUajA5QUx0L0VJYTNRb2VRbDBZQlRqNHZB?=
 =?utf-8?B?K2FFODMvME5MN1NidFJDWStoNFlkNFBJYnhJa1h0OEFGTnB3bG1JVENnaENy?=
 =?utf-8?B?V0JnTlhlandRTlpucHYrVUVybThwOWhkNGJxQlZSOG0xcDlrQnQ5RlpmZmtq?=
 =?utf-8?B?Ym9iWDZib09sS1U4Mys5U2t0c2hmUjl6YTRJbFlVM0lDcXBpZGhzM0Fkbkxp?=
 =?utf-8?B?TU1BaFU1YkxPZ1RycFlZallQbjRYY21VNkJNTDNkNXdvZmFiNGY3UEFFNjVx?=
 =?utf-8?B?bGRWemJDa2VGUVkzVmpiUTBTcXZvNEdCY3VhempNa2d3ak9PSURRVmZwVVht?=
 =?utf-8?B?RkFkZUJObk5hRkFZdHByWVZ5dWYzbS9yaXZQb2lEbVdNQUo4OWRnMXhjMmlj?=
 =?utf-8?B?YkcrSnZvYXBKSEhubDJGV2tFMmFBa2tUd2FaZk5SQkFWQnBNV3NuV1E1YkRF?=
 =?utf-8?B?S01EN1ZpSWZmeVNrQ0laWStqc2YvdzdqNGJ0dkF1RG9wY0lhb2x4UVlWMk5B?=
 =?utf-8?B?dEFBclVYa05mSnVnQmE0SjJMaG93eEx5MER3eDFWbzhQQlJ6SjYzcGNsVm44?=
 =?utf-8?B?Mmp4L1Juc1VCQlJSK21sOFIwWldpRUhvSlVGMFdhVnJMcHJLeVk1MzVhTVJv?=
 =?utf-8?B?ejJFY3VDdXNvMnFBVmFvK2NJOHlXY2NXNjVpMm9mQWVNOUprYXBHQm15b253?=
 =?utf-8?B?dVVZeXJEbWdna0poM3loRWxGeVEvYjc5WnF4akgyTlhRUm5QVlFrQzZ0bk5T?=
 =?utf-8?B?VDVvZ09DT3lua3MwUTFBdG8yRzBlVUcyU0pKczYyUk1oZkVCZGpLTmVKWGFT?=
 =?utf-8?B?azA5NDBvSW5mSmhoSEtnWEF4TXpaUXk1OTJOdXBlWEtzOXNWYXBUN1dLN1Jp?=
 =?utf-8?B?d0E0M2xhZWljR29ybUtMbXJIb0JlY0xlaWl6cmRwWWpZL2d5YXJFMnVoSnR0?=
 =?utf-8?B?ZFRmMVlURFd1Q2ZaRE50OTUvb0JwV1UzWXVWMzVQSStvbFExdlpVRkhmTkl4?=
 =?utf-8?B?WHBXSG1qSWtZUjg4bE9SekNSMmkrNE92cEN3K3ZVb3hvM1RaL3NSeFh6cW9R?=
 =?utf-8?B?dmtOVytYUnpnbjNiTWZ3T0t3S0FKbG8wa1YzRS8xQXFQRnhNeFVnZzBRYXcw?=
 =?utf-8?B?ODhHTGNBN3lxbmxuWFhaeG82eEg2K08ranNSSlluMHcxREJhMTVTbmNYbEtM?=
 =?utf-8?B?cGFhZnBCK0RXVG8xVkVMd0JNR1VsU2Y5N3V2b3dkMHJoa2tFNHdUTUxSbTly?=
 =?utf-8?B?c1VhdGtmT2RjYjcyZ2cyREplMGRqRE1oUno5ZnFnSzNibDVHaTV6THU2WUpU?=
 =?utf-8?B?ZUxHUWQrL3dOeE4xaFBVNzhDaDZnZHVhc3pFWlFCSE8vUDNPRWFzWUhZWG03?=
 =?utf-8?B?Mm9MSFd3U1A5TW9OMSsxc0NaNWg3VGFYV3FRc1NHeHpzOENhaGJ5MXVFTzYv?=
 =?utf-8?B?MUhUbG9QMVhRZmV4aGFTTmdDc2VrbFBZRDkvcGlYSjMyWVphSmNkQU1ya0lJ?=
 =?utf-8?B?ZmxYL0l3Zkt6dmVNK2V2V0MvampmbU1TMFVVekREb1NNUUttZS9keGhONndv?=
 =?utf-8?B?WDRUSnhZK0ZwQ3lldW9ySm14bUlERG5oRkJ4Wk9ZNURUTEY3WmpmbXRPa1Na?=
 =?utf-8?B?eU5VTTlGSGlJSWlwaXF3ZGpvSndsWHhOLzc5a1BGWGRveldnVURGSTJDYldU?=
 =?utf-8?B?UnlqNUowM0FjekpOYW5ZQ0ZYUlc4ZlBTeU1RWnc2eW9lYTF3RU5hOXhWVmhh?=
 =?utf-8?B?S1dvKzdPcm11Qmg2MkllSDhnd1VKQXNnMm4rOXU0TkNpQWZnalFCTVhBeDVV?=
 =?utf-8?B?SVc3a3Y5MDBaamtlVnZqYXdXakdSY1ZORDRBcTJZdm9LaDQ0bVhJRzVWM2sz?=
 =?utf-8?B?bjhOMUFsSytUUFRjSk1lTFFwazlkOVVvMEljYTF6NVBqb01tTWVpRm4xeVZ0?=
 =?utf-8?B?NzlkMC9BQlU0Z3BmQ0xJd20vTXZKZTFFUHhBaU1IdjNGRWRKbkdSWkdVN2FU?=
 =?utf-8?B?YllGQ1ZBMVkvalFZaExnaG8vbThwa3lDb0YxUmtpc1VQQWJjWVk4bzRGZkN2?=
 =?utf-8?B?TjdlRmQ1RU5qWUViSjh1RW1MUXYxckdMdWcySFYwd0JaL05PUlhtTHZGK01J?=
 =?utf-8?Q?wZjODuCvd+VSsDWAvXXXfxbs5?=
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
	x1q0KUUiuL48xiVqzkgNagFMqoeAk4tzOan6y8pzGhMCHH2Mj6mQtRh55utcQD/CPs4K4iV9OT9Y+FEmG8WhhaI+k/U4ZKjkpnpYVbv0tp+C8r8FGxeczCCreWJgHQW55Kllphqv2RYLsbNvhP7VZcVD6LvjIuLQCXzakdEbvkEBsX5x8b4GwBTer6vmhvo8dny3O7NqECmRfZVtm6envnn5gJgV1PMi+biJEWfTBLvC1NzwlYo50fy9f7W7IrGMhvvniwNZihvvNAuTKzd2DzblFnsmpi8DIAzFmmg89G1TjFNm3gXeAhi6X48lgi0k7BMM+6H3paqWPdERb0jr9/WkwJxNEX2BQ5TqsqlLubA7Y3RINibUzOb0RsYuCu8BQf0JgxMnjvvIldlmBXZBCR9whr7AJ08rXStG5T2UKG95wjM/zvEWVMF/pSGmMNjhhGkup/0OGd/ZsLpzG7mPkiSQz4z7tzR19pNSP90pTENkEOoey13MXJLbMCywxS5x8mS3bCc/GGUVASD/rJ8yRnxA9ioOqk9JrpSlams1Jb8Z7Rh2Mw6OaBiNVFlxOa16Cg6kuyuy+/ziRj3qsLb3FiiRAyQjXcaCqDl46H6wI4hRWM+rH+0guFnQzq10P0Yi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bcd474-8a4e-4686-1703-08dc4dbfed42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 18:09:49.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUJTsMp68dWVisNJnen0SAETLcr7vpc06uqRbn3qzjRBiDhLQGpZTloL0spyp7Ha0Z1Di4bj9MwV/qu9kPVK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8581

PiBPbiAzLzI2LzI0IDAxOjMyLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBAQCAtOTkyLDEwICs5
NzYsNiBAQCBFWFBPUlRfU1lNQk9MX0dQTCh1ZnNoY2RfaXNfaGJhX2FjdGl2ZSk7DQo+ID4NCj4g
PiAgIHUzMiB1ZnNoY2RfZ2V0X2xvY2FsX3VuaXByb192ZXIoc3RydWN0IHVmc19oYmEgKmhiYSkN
Cj4gPiAgIHsNCj4gPiAtICAgICAvKiBIQ0kgdmVyc2lvbiAxLjAgYW5kIDEuMSBzdXBwb3J0cyBV
bmlQcm8gMS40MSAqLw0KPiA+IC0gICAgIGlmIChoYmEtPnVmc192ZXJzaW9uIDw9IHVmc2hjaV92
ZXJzaW9uKDEsIDEpKQ0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIFVGU19VTklQUk9fVkVSXzFf
NDE7DQo+ID4gLSAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIFVGU19VTklQUk9f
VkVSXzFfNjsNCj4gPiAgIH0NCj4gDQo+IFBsZWFzZSBmaXggdGhlIGluZGVudGF0aW9uIG9mIHRo
ZSBvbmx5IHJlbWFpbmluZyByZXR1cm4gc3RhdGVtZW50IGluIHRoaXMNCj4gZnVuY3Rpb24uDQo+
IA0KPiA+IEBAIC01NTY1LDE1ICs1NTI0LDEzIEBAIHZvaWQgdWZzaGNkX2NvbXBsX29uZV9jcWUo
c3RydWN0IHVmc19oYmENCj4gKmhiYSwgaW50IHRhc2tfdGFnLA0KPiA+ICAgICAgICAgICAgICAg
dWZzaGNkX3JlbGVhc2Vfc2NzaV9jbWQoaGJhLCBscmJwKTsNCj4gPiAgICAgICAgICAgICAgIC8q
IERvIG5vdCB0b3VjaCBscmJwIGFmdGVyIHNjc2kgZG9uZSAqLw0KPiA+ICAgICAgICAgICAgICAg
c2NzaV9kb25lKGNtZCk7DQo+ID4gLSAgICAgfSBlbHNlIGlmIChscmJwLT5jb21tYW5kX3R5cGUg
PT0gVVRQX0NNRF9UWVBFX0RFVl9NQU5BR0UgfHwNCj4gPiAtICAgICAgICAgICAgICAgIGxyYnAt
PmNvbW1hbmRfdHlwZSA9PSBVVFBfQ01EX1RZUEVfVUZTX1NUT1JBR0UpIHsNCj4gPiAtICAgICAg
ICAgICAgIGlmIChoYmEtPmRldl9jbWQuY29tcGxldGUpIHsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgaWYgKGNxZSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9jcyA9
IGxlMzJfdG9fY3B1KGNxZS0+c3RhdHVzKSAmIE1BU0tfT0NTOw0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGxyYnAtPnV0cl9kZXNjcmlwdG9yX3B0ci0+aGVhZGVyLm9jcyA9IG9j
czsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICBjb21wbGV0ZShoYmEtPmRldl9jbWQuY29tcGxldGUpOw0KPiA+ICsgICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICAgICAgICBXQVJOX09OKCFoYmEtPmRldl9jbWQuY29tcGxldGUpOw0KPiA+ICsg
ICAgICAgICAgICAgaWYgKGNxZSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBvY3MgPSBs
ZTMyX3RvX2NwdShjcWUtPnN0YXR1cykgJiBNQVNLX09DUzsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgbHJicC0+dXRyX2Rlc2NyaXB0b3JfcHRyLT5oZWFkZXIub2NzID0gb2NzOw0KPiA+ICAg
ICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgY29tcGxldGUoaGJhLT5kZXZfY21kLmNv
bXBsZXRlKTsNCj4gPiAgICAgICB9DQo+ID4gICB9DQo+IA0KPiBUaGUgYWJvdmUgaXMgYSBmdW5j
dGlvbmFsIGNoYW5nZSB0aGF0IGhhcyBub3QgYmVlbiBtZW50aW9uZWQgaW4gdGhlIHBhdGNoDQo+
IGRlc2NyaXB0aW9uLiBQbGVhc2UgdW5kbyB0aGUgZnVuY3Rpb25hbCBjaGFuZ2Ugb3IgZXhwbGFp
biBpbiB0aGUgcGF0Y2gNCj4gZGVzY3JpcHRpb24gd2h5IHRoaXMgaXMgY29uc2lkZXJlZCBjb3Jy
ZWN0Lg0KV2lsbCBtYWtlIG5vdGUgb2YgdGhhdCBpbiB0aGUgY29tbWl0IGxvZy4NCg0KVGhhbmtz
LA0KQXZyaQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KDQo=

