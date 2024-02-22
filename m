Return-Path: <linux-kernel+bounces-75763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FF85EE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D1D1F229D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C8F4E7;
	Thu, 22 Feb 2024 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qhab6FgM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YcIKaXW8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cqhRHgm8"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA818AE8;
	Thu, 22 Feb 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564852; cv=fail; b=b4vAQ5Z1wy+OUJGdiWY1jV1vtUGX5xCAw0jAwH2zjWR1+2uTZ5Thj3lNYkbfWh1EYBeaNF0L/DrXZGghNsKVTH7QdSoVX9Fyt6UIEGyVzM6FiZUSyEHMCkyTg5yaEw/bCF+w/8gTvCX65rCKoSQubnJtizE0/Myu1kwiFD72Xf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564852; c=relaxed/simple;
	bh=Y/SexfnQ2tD/QNypTH/UXjX8PQzMLsEQfOjff/eVbnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBF0YFhUSvTWv0E4rZx1QlvZ9keLGCXZGdDgV7dF+cHOjlFqRFrpI59ommRS2S+Q308+knPbV1i8++yJEjgoQ2/TG7akeDptilazS627tJXqqQoah0N4fBANdVxiZWO+JPE/i3BWatOdrL+pXqlR1R+hqrHzfHjxtkV3gpp+WSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qhab6FgM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YcIKaXW8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cqhRHgm8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LK2Dwg001336;
	Wed, 21 Feb 2024 17:20:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Y/SexfnQ2tD/QNypTH/UXjX8PQzMLsEQfOjff/eVbnU=; b=
	qhab6FgMrUfQCNAwXemN1te5toKpnQx6JfKPduLbNDuX7UL3SkBc5iAJJTxhSPdS
	BX2fqNFo4uDT2QYm8w9r+uRwlMcDCBRCA2zXL1kzB4QOS0ee3Y5FJy3SFBz+o3Q9
	2JfYVESCLfmdk6LHJ9wztHENIP/dInAr7Att0rfIyH5BPpqzUpeSxyR7/sIr5DeQ
	5ndJFkfdwS61YZorpgIyPj6gphD012nnZO0daqOPyU6AZTzJxSXcrndMmKG8YiEx
	SPOZ3rup2xEYLPBX+42bX8MPCblXgpe/ZnuYppnDQnBmaKcZtO/uXLWz23fA3QlO
	NcdfY4btDOrE3xX+9GwHHw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wd227xqxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708564813; bh=Y/SexfnQ2tD/QNypTH/UXjX8PQzMLsEQfOjff/eVbnU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YcIKaXW8o3z8X3G+DYABEVsvrds7R4XgzXyfJ/cXV6pDtnlvk7TqjD7+QQ33KFIh7
	 Atv0xxrWe8FIOCitxW+2DMaEENbheudSy2X64cZQfx3et3mLaHKndVrMaWRdnk7q42
	 1bLK92QL9IIQ1kk29AG8y08UcSJElewZ0U+j61vdh/MsXVePBuaOsWDTgg0Ebq988w
	 O6s2ENbk5IT1bTtvnPf8XRgfhSLc4S5PVijoMnDGCI/emL6pVufF/gtZS3/y2ZGq1/
	 h73IFtfO++Kt1mruXslJGmZtnIGfhDMdIXSc0K/44bhO1MAMj3JeV2MhcqSJS+cI8r
	 2fSGjJCQapvsg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7ADEB4035C;
	Thu, 22 Feb 2024 01:20:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2A7C7A007B;
	Thu, 22 Feb 2024 01:20:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cqhRHgm8;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9A998401C4;
	Thu, 22 Feb 2024 01:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx2mPtp3PSZJZd6Ub9Jy87u+QZi9wxickSFRxajN6UmZKt5jy7pHthP6MVxyKM9wNIvKHIPRH6cB183DhACnaCVprF3x33+9/AVHV0FxNVT/mh2n45PJSB1tpvQ+FifqydGVfwcCYK3o35KEZZYT679vOEsw7hEG0UvV7EGDF3lgXDrnP2Tti7LJQ/S39VpfL1zsYUtbvXvwsgQAY5h35V0KG/i69jWiww7wK/oIQop9q/JLE64C9ALXOjKdcAxGsPXJn5CJLwaPk436LvNOU5le09DsI8I6ZVVN6OooLCpMYJ6IwdKjjOkCmfSzmnIi9uwxn5QX4zH7BSYd8UllSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/SexfnQ2tD/QNypTH/UXjX8PQzMLsEQfOjff/eVbnU=;
 b=nVTqW7sojxrDx470e7aP8hSH5CLfeVubswGYkITjFt+E4GHdWh90eHQWHuFkZqsjtHJkU0i6GoSx3KngrRnHvfKgwajO+s9c7LdnK2EZC2ksqARrSQCvfZWcvF9VujTp7q/Pw5HL0RjuN0NAwNhqsLjlclKxa9CtIA6UnIL6o2vXmZ9hP0YdjjsS1e0vkTLH5JHTc0TGSz+DmUgTISwUzSRZpTZ/eR6CLKieQzIYTN5QgH3CeY+Y2uproqKaxnFe/3GN+7ftUJSJkTRlMWcB2PMKetKmL/5yDXuBJEFM16YzeG35ZWlCEiHDJ+x4zFS1etB+/j3Ft7lYeo3K4QDDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/SexfnQ2tD/QNypTH/UXjX8PQzMLsEQfOjff/eVbnU=;
 b=cqhRHgm8udk/6k5YEdLsCwffHOxo5MILXeh21oYt/AoHbRX/cePUbIFvPcuqkOThcYEKvLTlFWbhDSDOHolytvdtwXk79PdszdxR7p+LkLLViVMSF3UqhxZLg9GZTRAqQb7zgXL2Q13b0XF469EYubIM36G7YlLK3yHbjB7VE4c=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Thu, 22 Feb
 2024 01:20:05 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 01:20:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Dan Vacura <w36195@motorola.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Thread-Topic: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Thread-Index: AQHaZSKBngnJI2fmsEG+RpJSSObqsbEVkDeA
Date: Thu, 22 Feb 2024 01:20:04 +0000
Message-ID: <20240222011955.7sida4udjlvrlue7@synopsys.com>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-3-w36195@motorola.com>
 <ZdaPLGTbsBo4F4pK@pengutronix.de>
In-Reply-To: <ZdaPLGTbsBo4F4pK@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB7990:EE_
x-ms-office365-filtering-correlation-id: b1c6f816-d3a7-40f8-2a3a-08dc33446658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 quOJO89Mzv58ofhkOifNb7SXubLI0P/VSoo91uhaLqwlJ9ZvQrJbDfOidiG2vnp8rrWUfX02g/Owg7YctGXELCQMFJ1STXazdJ6/y16egh735RYZiRZeZligS/I0f5Il/IK1+ym5D7Gs8/E80Y/m9VluY31vdyKv0VUzse2NyhoHFLXEQPMrgJdeNrPbdf1IFVWpxC6HIvEfp0qpLRU9cw3VnjCiAa7MS9MwjEjcdmemdaHJ0pmj7fgAtLdIpOvrJnvVNIHl9PLENRwYnWauqpVOmOPl3jIcWvkRUb2ZnZyzIojOEjWme0WYDba0QVRlX5sXN2tS0hpPXDIByzCUYJKdqo0+ZcoaD3OjudTUxAHJUt5ZkWNopoFjrsF2ObfuGSIr+NJAeX5zZcZN1oxzOx5/3tsQhcjGcEfrFnjnnZquzaIFdXj36UbGasv2ZRi1Gx71VWI/KDYS0fPmkjPIMlPVfqCEq867tCahUwqsgumOZqwtdxqPbFEmIE2i0NOdilp8pYmorFUhP7AIDIAYmdjAk9rQb676mc9eeUtpOcANY8AnPbDNLgcTAMiPxvI4Hh1+IH8UNqRqGFRzHTPF/Xql/qQPYGIMX5Ly5lXVbohJE87tQ8NU1sds1dxEAlZ2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVpEbTVSaVlmaHZGYmJpQmtrWWdoVmJ3dTUyOEthdXhzVkp6YlhyL3VVVXlp?=
 =?utf-8?B?UVZLK0hQL054L3U5Z1B0dkdVM0xTS2l6anI5SU40QW0zMHFEaVB4N0ZMeEUv?=
 =?utf-8?B?Nm1XRnhOM043cnErOE1LaXZsWjRxSll4RmdMb1ZzMzZhOVZBQnpkdStYVW9V?=
 =?utf-8?B?azdhYUloNjZEWDVGMEhpcFFZa1dvMGcxK2JHMjgvc0NzRnd6NEY4MEdLZmk0?=
 =?utf-8?B?VmszcXhKc3ZocGgwa09IbWJzYlI2TjZoYWQ4aUpmTHoyai85M09lbW9sZTRU?=
 =?utf-8?B?WnB0ZEFMVDdrVExNZ09La1Q1MW03NHNOekwvVkRwMGxRRDlxemY3d1FYb2RW?=
 =?utf-8?B?a0JmZm1wTkcyODZVanBEUEFrZVRjRlAwMWl6Q3pvNXFUWXRkcEM3TTk2TGdE?=
 =?utf-8?B?dHBBTFhMN0xGZzRnYUgwN0d3Y3pwejlUSUVVMGJoVjNYN3lsQm4vdFZOSXdT?=
 =?utf-8?B?c1BNTEdZek1EZ1dTamlVTUZPZzlSVmFMUkhEOHhQWEdVNEdUN2plRHlMaStL?=
 =?utf-8?B?ZGJaREtnM1VHN1ExRjlFWXRBZzJrSllzT0lPalRkRGZQSGd2WlNtd21jVm13?=
 =?utf-8?B?SVFIVndsYXJZeE53aFZJaFJqbUE0dmttWExPeFZpVGRWRE9ZRzlTNnZ6UFNj?=
 =?utf-8?B?amRENVo4NXp5aGJ1SlBKWUVzQlZtUjJDUndoSGlNdFNpL0FiV1lYeGIvVFMv?=
 =?utf-8?B?cDNHTElLTW0zN1RhaThhSW1sUytjcUM2QWZqbkZINTh5c1lSek02VXJCd1Jq?=
 =?utf-8?B?bURtcnNzM3g5TTdjR0VVVFl0Uk41UmluWnZWYUNualV4akxJMnI0aXFWbEhK?=
 =?utf-8?B?RGZZNXZsMUo2bW54RUFXU0JKaCtmdDJnTmJJRk1PRGlWa1NXYk12NUd2NHhG?=
 =?utf-8?B?ZGlFZzdTRS95SzE4bWF5dW1BMy9DUVVrVTFLQ1l4ckErN0xlZFZERW5QZExK?=
 =?utf-8?B?MDgwdmpGYmg5aCtoR00xTUo0UzBiZHJiQnRXcjdDcW4yQ1VNa3FGV3RwdVdo?=
 =?utf-8?B?RGdTOGZod2FxaWVCd3ZVQnh0L1dvbFliZzRHVlJxRWFXaUR3dlloaTdWaEN0?=
 =?utf-8?B?UWVrMUMyQWFRSThlc0hlOTNnclN4NDNJN0ZFbHlHMERtcmMrcUcxdFM4L0pI?=
 =?utf-8?B?L0tGQ0dQbitXc1g5M0hSYlZhRUJvTnpQL0ltY04rcnZiaVQ5bnYwRFpnTFdz?=
 =?utf-8?B?K3U1TitKUEYrOE9wRXNwQU8yWEZZSW1MeUdJYXgrQTVyK2dsWXhIT0NZMC9z?=
 =?utf-8?B?SmNKZ0UySEZWbCs2WHUvKy9CWmwxM0ZHejR2QTFmTXhvYW02eURSUkpENjVF?=
 =?utf-8?B?N0UvY0VTamhqdldQSVN4aEFTNmI3ZXJyNW94RWxzaW9wanF2RkM1VFpHKzJ4?=
 =?utf-8?B?MG9TbkU3NVhkRVh5K250S2tzS0RJcW44TEMrSlZvNGlvU0lEc0xDRVZyVlQx?=
 =?utf-8?B?Nmk4Q3pqeHcxaG9CcUR1REdJVzByTFpCRjM1MFBueTR5dWRBV1g2NHg0aDVT?=
 =?utf-8?B?ZGJnOGdNdDZBNlU1NHhiR3Rqd3o4UW5rN3lVOVRiS05sK0RGd0x1UUVhdXVE?=
 =?utf-8?B?cTJadzRGZzkraCtJWEp2czR4aVhuSFpzZUtQaVEyeGsxT2dkL2IxOEZJRS9h?=
 =?utf-8?B?MFduUEtRZk1QeFlycFk0U2JGalpTMUNOaUh3QUlOZVNZaVRkRFBGajRkZENM?=
 =?utf-8?B?UzJLSW9YWWpJMXdoeUdBcGhybS9OYlRmTjY3YTlBeVBDbTBKR0R0aVlJS3Fo?=
 =?utf-8?B?U0RWVTFaekd1eTVWL1JNZlBhYThOM3o1SE1VaWZWaklsVkxLdjlUMUlHZm5j?=
 =?utf-8?B?Znp2ZWI0dzVXbTdQYm9Gc2RFblpKSVRCVnBydWlJbW1pKzhhaVJSSzVScWdX?=
 =?utf-8?B?b0lxZE5UZHlCeG9uaUVoNlF6dUVXeWZOakJBRFNCMWpGa1ZJYzNEaXpQcWxw?=
 =?utf-8?B?bUpwOEZnUmdnRWVjM0UzOWV4KzdaOWc5dHNIYjB1VUR4QmFDZi9jaFJYbmFU?=
 =?utf-8?B?L045d0wvVnBwbHNTM0pwZUdKMG04dlloKzFCelVDcDdiV0IxcVdmbi9SRVI3?=
 =?utf-8?B?NHVlMXJjaTZNdVZqMHRMZDBnZ3JaOW5VcDU0aE80ejgrMDVweXJPeldnckZP?=
 =?utf-8?Q?wnT3YeGJp3POTWY/qdFk+8ljX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A242CC58A0F64F93131AD79804DC79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IbkdHFs8xEEMhWBf1/uM+0fwSErbpoBawKPTYwI47SQ0fFHN+WSldYEVht/rgvaBmffVAYUoFXsUxeJTV/Hbgm9zCC88slaLmwPNoPxBLasVCPX9LeME91ImzutgMhbs6lpM0kQLlz8azP1oCIyqvZQ8Vz2q8fZxQxBBpPKA3IInK2QPCeRMqDvh8kDKDhpDp7FmwV8RHnPISxLa5E4EcZGSCoVLAcgMW76jlvXBVfRrO1V6Vvsrztul9AuIRMtGrYI3iDuBjPPvDKOPTpW+S6pzrljug1UPHQcIAPyl9I7gt/SjNcEBNUi45OdrpUFgxFqunIyGDz5Z4eWVNsuMc64PbxJpAeA4hxbEwfOO9wvEi5f0BfH4FJGLEQAehePf7FJtmAvoNVz3CyHg/zVbhQHq2s+MJu5hPL5GucoiGrZBLKEyqHX7i0u8Sigl8zqxkQrtTWRUrl6lDhnDC4ga0ueDYyhBjeNtDog+ONsbky2/WlH25BuIr1P4Pil5/VVPmWNAh28aUN+M/HM5mn5r5xpJj0gBISVZXFbAmuC/UwHlz4QJEQkoRzXyiZDTmzLfeHLUh6fqkG7rnz/K0NOkKIetMJhj/Cx/Q4LcTvVKj4QAR0Wrfcc/SwBOwqG6OREvB1i3BrnEDq6wAcIJrdtN/g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6f816-d3a7-40f8-2a3a-08dc33446658
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 01:20:04.7195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx3dIA/i0GoEhmiHcLQ1JQ7VM/4Gs7alDIg2hLUR2rGQ272uLsxpbHStzpPZmwqi/+kGL4WWrLNq2XLLV1vS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-Proofpoint-GUID: eJYqebaL5-_tN-5bihzZmZRtDkcIK688
X-Proofpoint-ORIG-GUID: eJYqebaL5-_tN-5bihzZmZRtDkcIK688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=879 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220008

T24gVGh1LCBGZWIgMjIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBTb3JyeSBm
b3IgZGlnZ2luZyB1cCB0aGlzIGdyYXZlISA6KQ0KPiANCj4gSSBvbmNlIG1vcmUgY2FtZSBhY2Ny
b3NzIHRoZSB3aG9sZSBzaXR1YXRpb24gd2UgYXJlIHN0aWxsIGVuY291bnRlcmluZw0KPiBzaW5j
ZSBvbmUgeWVhciBvciBzbyBhZ2FpbiBhbmQgZm91bmQgdGhlIHNvbWUgcmVhc29ucyB3aHk6DQo+
IA0KPiAjMSB0aGVyZSBhcmUgc28gbWFueSBsYXRlbmNpZXMsIHNvIHRoYXQgdGhlIHN5c3RlbSBp
cyBub3QgZmFzdCBlbm91Z2ggdG8NCj4gZW5xdWV1ZSByZXF1ZXN0cyBiYWNrIGludG8gYW4gcnVu
bmluZyBIVy1UcmFuc2Zlci4gQXQgbGVhc3Qgb24gb3VyDQo+IHN5c3RlbSBzZXR1cC4NCj4gDQo+
IGFuZA0KPiANCj4gIzIgdGhlcmUgYXJlIHNvIG1hbnkgbWlzc2VkIHRyYW5zZmVycyBsZWFkaW5n
IHRvIGJyb2tlbiBmcmFtZXMNCj4gd2hlbiBhZGRpbmcgcmVxdWVzdCB3aXRoIG5vX2ludGVycnVw
dCBzZXQuDQo+IA0KPiBGb3IgIzE6IFRoZXJlIHNvbWV0aW1lcyBhcmUgc2l0dWF0aW9ucyBpbiB0
aGUgc3lzdGVtIHdoZXJlIHRoZSB0aHJlYWRlZA0KPiBpbnRlcnJ1cHQgaGFuZGxlciBmb3IgdGhl
IGR3YzMgaXMgbm90IGNhbGxlZCBmYXN0IGVub3VnaCwgYWx0aG91Z2ggdGhlDQo+IEhXLWlycSB3
YXMgY2FsbGVkIGVhcmx5IGFuZCBlbnF1ZXVlZCB0aGUgaXJxIGV2ZW50IGFuZCB3b2tlIHRoZSBp
cnENCj4gdGhyZWFkIGVhcmx5LiBJbiBvdXIgY2FzZSB0aGlzIG9mdGVuIGhhcHBlbnMsIHdoZW4g
dGhlcmUgYXJlIG90aGVyIHRhc2tzDQo+IGludm9sdmVkIG9uIHRoZSBzYW1lIENQVSBhbmQgdGhl
IHNjaGVkdWxlciBpcyBub3QgYWJsZSB0byBwaXBlbGluZSB0aGUNCj4gaXJxIHRocmVhZCBpbiB0
aGUgbmVjZXNzYXJ5IHRpbWUuIEluIG91ciBjYXNlIHRoZSBtYWluIGlzc3VlIGlzIGFuDQo+IEhX
LWlycSBoYW5kbGVyIG9mIHRoZSBldGhlcm5ldCBjb250cm9sbGVyIChjYWRlbmNlIG1hY2IpIHRo
YXQgcnVucw0KPiBiZXJzZXJrIG9uIENQVTAgYW5kIHRoZXJlZm9yIGlzIHRha2luZyBhIGxvdCBv
ZiBDUFUgdGltZS4gUGVyIGRlZmF1bHQgb24NCj4gb3VyIHN5c3RlbSBhbGwgaXJxIGhhbmRsZXJz
IGFyZSBydW5uaW5nIG9uIHRoZSBzYW1lIENQVS4gQXMgcGVyDQo+IGRlZmluaXRpb24gYWxsIGlu
dGVycnVwdCB0aHJlYWRzIHdpbGwgYmUgc3RhcnRlZCBvbiB0aGUgc2FtZSBDUFUgYXMgdGhlDQo+
IGlycSB3YXMgY2FsbGVkLCB0aGlzIGZvcmNlcyBhIGxvdCBvZiBwcmVzc3VyZSBvbiBvbmUgQ29y
ZS4gU28gY2hhbmdpbmcNCj4gdGhlIHNtcF9hZmZpbml0eSBvZiB0aGUgZHdjMyBpcnEgdG8gdGhl
IHNlY29uZCBDUFUgb25seSwgYWxyZWFkeSBzb2x2ZXMNCj4gYSBsb3Qgb2YgdGhlIHVuZGVycnVu
cy4NCg0KVGhhdCdzIGdyZWF0IQ0KDQo+IA0KPiBGb3IgIzI6IEkgZm91bmQgYW4gaXNzdWUgaW4g
dGhlIGhhbmRsaW5nIG9mIHRoZSBjb21wbGV0aW9uIG9mIHJlcXVlc3RzIGluDQo+IHRoZSBzdGFy
dGVkIGxpc3QuIFdoZW4gdGhlIGludGVycnVwdCBoYW5kbGVyIGlzICpleHBsaWNpdGx5KiBjYWxs
aW5nDQo+IHN0b3BfYWN0aXZlX3RyYW5zZmVyIGlmIHRoZSBvdmVyYWxsIGV2ZW50IG9mIHRoZSBy
ZXF1ZXN0IHdhcyBhbiBtaXNzZWQNCj4gZXZlbnQuIFRoaXMgZXZlbnQgdmFsdWUgb25seSByZXBy
ZXNlbnRzIHRoZSB2YWx1ZSBvZiB0aGUgcmVxdWVzdCB0aGF0DQo+IHdhcyBhY3R1YWxseSB0cmln
Z2VyaW5nIHRoZSBpbnRlcnJ1cHQuDQo+IA0KPiBJdCBhbHNvIGNhbGxzIGVwX2NsZWFudXBfY29t
cGxldGVkX3JlcXVlc3RzIGFuZCBpcyBpdGVyYXRpbmcgb3ZlciB0aGUNCj4gc3RhcnRlZCByZXF1
ZXN0cyBhbmQgd2lsbCBjYWxsIGdpdmViYWNrL2NvbXBsZXRlIGZ1bmN0aW9ucyBvZiB0aGUNCj4g
cmVxdWVzdHMgd2l0aCB0aGUgcHJvcGVyIHJlcXVlc3Qgc3RhdHVzLg0KPiANCj4gU28gdGhpcyB3
aWxsIGFsc28gY2F0Y2ggbWlzc2VkIHJlcXVlc3RzIGluIHRoZSBxdWV1ZS4gSG93ZXZlciwgc2lu
Y2UNCj4gdGhlcmUgbWlnaHQgYmUsIGxldHMgc2F5IDUgZ29vZCByZXF1ZXN0cyBhbmQgb25lIG1p
c3NlZCByZXF1ZXN0LCB3aGF0DQo+IHdpbGwgaGFwcGVuIGlzLCB0aGF0IGVhY2ggY29tcGxldGUg
Y2FsbCBmb3IgdGhlIGZpcnN0IGdvb2QgcmVxdWVzdHMgd2lsbA0KPiBlbnF1ZXVlIG5ldyByZXF1
ZXN0cyBpbnRvIHRoZSBzdGFydGVkIGxpc3QgYW5kIHdpbGwgYWxzbyBjYWxsIHRoZQ0KPiB1cGRh
dGVjbWQgb24gdGhhdCB0cmFuc2ZlciB0aGF0IHdhcyBhbHJlYWR5IG1pc3NlZCB1bnRpbCB0aGUg
bG9vcCB3aWxsDQo+IHJlYWNoIHRoZSBvbmUgcmVxdWVzdCB3aXRoIHRoZSBNSVNTRUQgc3RhdHVz
IGJpdCBzZXQuDQo+IA0KPiBTbyBpbiBteSBvcGluaW9uIHRoZSBwYXRjaCBmcm9tIEplZmYgbWFr
ZXMgc2Vuc2Ugd2hlbiBhZGRpbmcgdGhlDQo+IGZvbGxvd2luZyBjaGFuZ2UgYXN3ZWxsLiBXaXRo
IHRob3NlIGJvdGggY2hhbmdlcyB0aGUgdW5kZXJydW5zIGFuZA0KPiBicm9rZW4gZnJhbWVzIGZp
bmFsbHkgZGlzYXBwZWFyLiBJIGFtIHN0aWxsIHVuc3VyZSBhYm91dCB0aGUgY29tcGxldGUNCj4g
c29sdXRpb24gYWJvdXQgdGhhdCwgc2luY2Ugd2l0aCB0aGlzIHRoZSBtZW50aW9uZWQgNSBnb29k
IHJlcXVlc3RzDQo+IHdpbGwgYmUgY2FuY2VsbGVkIGFzd2VsbC4gU28gdGhpcyBpcyBzdGlsbCBh
IFdJUCBzdGF0dXMgaGVyZS4NCj4gDQoNCldoZW4gdGhlIGR3YzMgZHJpdmVyIGlzc3VlcyBzdG9w
X2FjdGl2ZV90cmFuc2ZlcigpLCB0aGF0IG1lYW5zIHRoYXQgdGhlDQpzdGFydGVkX2xpc3QgaXMg
ZW1wdHkgYW5kIHRoZXJlIGlzIGFuIHVuZGVycnVuLiBJdCB0cmVhdHMgdGhlIGluY29taW5nDQpy
ZXF1ZXN0cyBhcyBzdGFsZWQuIEhvd2V2ZXIsIGZvciBVVkMsIHRoZXkgYXJlIHN0aWxsICJnb29k
Ii4NCg0KSSB0aGluayB5b3UgY2FuIGp1c3QgY2hlY2sgaWYgdGhlIHN0YXJ0ZWRfbGlzdCBpcyBl
bXB0eSBiZWZvcmUgcXVldWluZw0KbmV3IHJlcXVlc3RzLiBJZiBpdCBpcywgcGVyZm9ybSBzdG9w
X2FjdGl2ZV90cmFuc2ZlcigpIHRvIHJlc2NoZWR1bGUgdGhlDQppbmNvbWluZyByZXF1ZXN0cy4g
Tm9uZSBvZiB0aGUgbmV3bHkgcXVldWUgcmVxdWVzdHMgd2lsbCBiZSByZWxlYXNlZA0KeWV0IHNp
bmNlIHRoZXkgYXJlIGluIHRoZSBwZW5kaW5nX2xpc3QuDQoNCkZvciBVVkMsIHBlcmhhcHMgeW91
IGNhbiBpbnRyb2R1Y2UgYSBuZXcgZmxhZyB0byB1c2JfcmVxdWVzdCBjYWxsZWQNCiJpZ25vcmVf
cXVldWVfbGF0ZW5jeSIgb3Igc29tZXRoaW5nIGVxdWl2YWxlbnQuIFRoZSBkd2MzIGlzIGFscmVh
ZHkNCnBhcnRpYWxseSBkb2luZyB0aGlzIGZvciBVVkMuIFdpdGggdGhpcyBuZXcgZmxhZywgd2Ug
Y2FuIHJld29yayBkd2MzIHRvDQpjbGVhcmx5IHNlcGFyYXRlIHRoZSBleHBlY3RlZCBiZWhhdmlv
ciBmcm9tIHRoZSBmdW5jdGlvbiBkcml2ZXIuDQoNCkJSLA0KVGhpbmg=

