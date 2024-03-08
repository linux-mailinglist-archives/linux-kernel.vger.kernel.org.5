Return-Path: <linux-kernel+bounces-96462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F3875C80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E033D1F21F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E12C19F;
	Fri,  8 Mar 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vrO3r9m1";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gtonr+gz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FhivUULQ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40428DCA;
	Fri,  8 Mar 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866057; cv=fail; b=Ph6ByoIG2Q6e7g0xLfl6D90Cej3cy0yn8syQkhPrHEpVxHiOw70xB73J/ESEmu6MbqUF7ZaQvhfAAA8gEiXS+kuIoOk/OF5aMEG2SEAxx9BuylEEw8wOJhzNVAR/5fmLVxwOGQc6xlaIeVd8wz0d0VRVYf8acWjj3foWyDS4Ic4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866057; c=relaxed/simple;
	bh=XVNeb998X5RAamSbjFhzAB3VbCaW8iK1tPHQdGQSvBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNESeagekT962h7IlHr5W3gu3tYVDz56WDsQisLJtAYPhPSX4YLbqjhBlAoVwWEAiCEhpc5bNOpXxfJzabPZtITo+0eBJ0+BBcZDfs1/NOOfbl1yZrSldZW8xjono1V1Lkj5wo/zilVRHLwXUDAqaJh4cOv772iKKgeW9hW2gDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vrO3r9m1; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Gtonr+gz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FhivUULQ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427KpxpA004401;
	Thu, 7 Mar 2024 18:47:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=XVNeb998X5RAamSbjFhzAB3VbCaW8iK1tPHQdGQSvBM=; b=
	vrO3r9m17k+aKEsnHDtZum1UsFK/Ioswv9G0Zfg6Qtsr2cT8afz4PL/kq4mO0ngO
	A+k2BIpD6aNFtWTYCkF8C4jr7fl/WnaO6x2cb4jqb2DIb7G0yFpIRx8fXwxfAtfu
	DaFZ203z7Oa4r8IBp9GEzxAG8LlVjbCzhqPuQ5p1Ht2KeaMKNcN5Idy9b2xxeR9O
	jZLfzXV7dEY351oVc/mzwnnqaPgg3NZyLk0rUSniGBhQgpZIVJQsO7a9sm4PcNNe
	s/Tx6Do0OZvjRLOw/2LqEw6Y+u8dnomgjl9hE/JRdyeLogPMAJesvqRc9bCx4d4N
	xeV/FgrTC7H+SuUYlJaBJg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wm40qge7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 18:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709866028; bh=XVNeb998X5RAamSbjFhzAB3VbCaW8iK1tPHQdGQSvBM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Gtonr+gzeXMk+ivlcwg3UHzhLnodpxsb+zdZrrt/h+WY3cx7NjTnPs1eKhxTBz5xF
	 5yMm8w5llvUJUfxYRVC35fp+OmePSzIg9zVR5g0Xh9OAGck65ajjUguMKzw/YQVvjX
	 lHrv23Drhd/O+JPZ4eOnYObJbHgnSsFpcGMnKsrhysb/UcQky+vI6YEFmfUGizzl92
	 kPqA+v15fbqt2aNSSVM7fSE8ptz02P7h3TxKBcuChB2bUD1Yk4r6kVi9IORuwAiXGr
	 3TozZw4oQhzJnyfbc7Zq3BNPpDkU7rczNW4fD7bZTQv639qGUor3Rt32GOE6cu3h8j
	 Y+kwMJOF8lrVw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D4E440346;
	Fri,  8 Mar 2024 02:47:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 92C0CA00A7;
	Fri,  8 Mar 2024 02:47:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FhivUULQ;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D8054401C4;
	Fri,  8 Mar 2024 02:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAHLOX/B+xwUpoE+YPkhul1jzOKTVhEsXe/GoTSDKPvloz12wkecbgdy9P+hz1K8mUaa1e+8fMkL+HZvY/bnm6Ttg19eO8yAP12JUiS4t0QiKnXJNy+mfP+Z3o5itfzfk3FOmGlQHv+kVDTZYnR6KrSlDlFn75HiVbKEbUyCjqirsZ+u9t2PAIEF7vN16WXhwo9c6n1B0UYH5rrqel0rsqtYq5vG0ke3nbjgbojOXti++Z/nayu1yhEsEfA8et7vPYIXgiBSBBK1fAZCNz1Q+t7bbu9P9rIzQ1U1cF1ycJLdxWre07Ej/siA6L7Hb9BZrUdrHjhCp3JIv64CRIOceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVNeb998X5RAamSbjFhzAB3VbCaW8iK1tPHQdGQSvBM=;
 b=B7ASg2i8raa6LsUjRlHA3N7SrUxDk3B9W/5yLaICDu21TnwCYlwRRrBl2qQD0w0ElzCIGf74sw+vaGSUDYZptOH94t8MTW5Xs6p0eIhXUrXNyDag2iu36yPsMlH4ZEzjzCf/sC9znFZ8xfeqN/YKV3svKI9TWEe7ZeptktkHrTjiIxoVazlT5F5sqr3jITd8z4htfjTn4axrxJF/7XEba0tO0gnoovg7gZJKjLq41owtpQGNBNXQzwx7wf/8Rr/dXKmG+U3lUazcy0uQgZgxWLlntcSQg39dPkKe3UCjXUxWXUvA49JZaseptXk1dgLprJBMPex+9qoIQ75XUbCszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVNeb998X5RAamSbjFhzAB3VbCaW8iK1tPHQdGQSvBM=;
 b=FhivUULQuv6jxw1UX+eLp556nPaC918ItBdPSZL7ux4Di/zl4GeNUaIlcjlN18DtzbE5h9ADiKsFk2eOlQJMLVUOjHcihQ4mlMeye32K1Vp8c3ceV8Y1QwhKs6ZLcHqhLmmdcd24a9BUMHhu0InyC5t6PjeudQ/hB0HlvGBE4IY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 02:47:02 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 02:47:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Dan Vacura <w36195@motorola.com>,
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
Thread-Index: AQHaZSKBngnJI2fmsEG+RpJSSObqsbEVkDeAgAkluwCADOVwAIAA75wAgACwfYA=
Date: Fri, 8 Mar 2024 02:47:02 +0000
Message-ID: <20240308024653.dp76mzoom4fuoib3@synopsys.com>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-3-w36195@motorola.com>
 <ZdaPLGTbsBo4F4pK@pengutronix.de>
 <20240222011955.7sida4udjlvrlue7@synopsys.com>
 <Zd5Nns91uXvTOAwd@pengutronix.de>
 <20240307015736.4dhcrzsli4dihym5@synopsys.com>
 <ZenoEJmne73BlCFI@pengutronix.de>
In-Reply-To: <ZenoEJmne73BlCFI@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB9047:EE_
x-ms-office365-filtering-correlation-id: 2eeb4f67-459e-410d-7f1c-08dc3f1a0866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zlGILMAiinvVw7bfwRqZCK3JE+XZoL8NfL9ZEhHuq8qGuwS1XlwsfGYHujMp6bXfr4AxIpSd26SXt607LG4g666Um89YCaGJfToMR/4JiE0x7uV06TPugNwIXPD8SO+TVYcSbmLa00KrMZY+iVSYoBr/yQ2qVLFd2Z0s0y3uubtbI5TjXkyaoEFZyljB8XfVbNVvt05xkvcpc2S89ciqzbE/GqK+DKbjBdzuImChFj7WS3JRkLm3zQDcyPlSiS2Cgk/ulGqkioufkOCY7BmNWnvvahFn2ghJwAMEvViUH0q8nfx2fFw9f7wREaVCV6yUrV57Tz5aBYSia/54TDUAPumQJmfqL0On87mjV3nsS+PvRXuTXpB9J7A+i44vMCmlFrcnSxQfZsRJSbejkmDQPGPaKwEDX9uW55q/JUxFw2xOpdH8EBBr/ixiNt58Q0U7H0CVMrdoacvGRTJ9Hjj1ROnrqrLSN+5CmWapYniZN805vkBZps25j80/EB2A+3LglBTiQpT26bKMPbjOxKCJBlGBYvzmBZAWerLCU761cCB0zSvY+BbZc26AST6eUHYJPjKwd1Kg8dXT+tE8XYooezfWVbCaK5ZNWJvRJY8dH7dgHcSPaLDOFyD7uAJzjeApdkjMzgSOcX8aL5LHP67B7gr0sLO8Vddo8sAdz975ggo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eERDYnZZT2J6MkpkaVJTd2pYRkZ2Tm8zbXFtWFBtaExKdDJ1TStOd0RXcXZZ?=
 =?utf-8?B?WnZvWWFxZ3J4dEtZRlFtQjBaeFFxL25peVdZbm9Od09yZWNOQURxVERVaVkv?=
 =?utf-8?B?Sys2aEY5L0ZHSFZ5QXlRRzNtTHlkWXl1VTBhSWQ1bEtGbTcyR01KY2ZxOFFp?=
 =?utf-8?B?YmQvVk9ZZ0pnMzA0MWJzVGlocm9RdTk3RUxLNWZUdXFld1N3MDdlUWFMNmx2?=
 =?utf-8?B?YytuTWhyV0ZlWThnME1sRHRZcVdZNk5DQldPVTBJd0ZFUWVPQ2FWUGo0ZVl6?=
 =?utf-8?B?bzY1ejZ0TVVSYXJOSlI5S3BCMjlQSkRDNk1WanNQS1lKWFhCZzg0a201QzBX?=
 =?utf-8?B?bHErSURacmNCTTBpVXU2Ylg3WERqaE56UisvMlc1MzZNQzVkU0NsN2dXbDJ0?=
 =?utf-8?B?WEpyNW5iWG1sa3doaEdNU2pscVg3TG0yQjRUWHJJUk5Ib282cUhvcTJVUnl3?=
 =?utf-8?B?VGdxQVZ3dTVQVTdObDE4TmUraSsrNUhDMUNwVVlKdWx0TkVUSDdqYWYyaTY2?=
 =?utf-8?B?c245MmJ1c0VNREZNVE04c09CbWY1MzJTTFp6SUdRSHdGVEZEY0NOdERZL0NN?=
 =?utf-8?B?QXU3TDVHU2V3NjM5WXJUTzFRTkJ0N0hpM3FaZ21kVHgxbWFMeGJXYlA4UHps?=
 =?utf-8?B?TmJLbVlMRDB4Q2daUUxMSHJEWElUZHFMdU91VHlFYkRXT2lyb0JuRXppc0Zx?=
 =?utf-8?B?YW9mQlNXdzl2Um1pSkU0dTNDY2Y2aG5zQVY3SU5aRER0Ykk1WUg5cUZ0N0hL?=
 =?utf-8?B?Zit6K01qendHdjZxNEZLWTJ2b2tGTUpEak5QaDFCU3RmZ2RIWXFxWm1UZHVL?=
 =?utf-8?B?ZGVWS2x5VmdDTlh5N1puVkNVdmdST1NwOTdFVlNIUzZnd2RyYUtUdjAxWFdP?=
 =?utf-8?B?RXBkM0JySUxsMzZldTFrL1FaNDh0MWdCcFZxc1NHTUNPMURpL3NJMHhZZzk5?=
 =?utf-8?B?NnNTc2hKeUYreFg4Tlhya3pwU0JaeHlkSmJUb3NEa3ZwV256WUhKQXRtcTZy?=
 =?utf-8?B?dzhKai9NTUUrMXI5Qml5WGpGaGMzMHZZVnpPcDNESEt1TzgxaUd1dnpmWlhK?=
 =?utf-8?B?aWxTNEY4NFF5Z0NUSGVycHNENWI3bXVjMHZkN2ZsUUZ3RkYxUEJsbDdQS083?=
 =?utf-8?B?emxKM2ZTZkJmM1REUFFyZUVkM0NLUnNoWHE4ODI0Y2NaY2ZpL1A0ckZPVzRF?=
 =?utf-8?B?a3A2aGZlUnNFVDBBOEw3L3lGeHJhSUNGczhmK3VINWF2U05RZzcwY29CYnV1?=
 =?utf-8?B?NzVwQ2ZyeFF6NjByb0Rydnc0cmVMNEhmNVRpd3lhUUo3NGR0dUlnSk95cUdB?=
 =?utf-8?B?MzQ0SzByeEx2R3ZCOFFFUm9WQno3djhLV01xSVZPTHdnaSsvUW5xOXo1NG5D?=
 =?utf-8?B?RlpRSDF1N2tweWpKTEIrL2x3cy9xUXYvczVQTDZ4aFQ5dC8veWxuUnc3Sk1k?=
 =?utf-8?B?R0FUYk9wWXdXNFllSTVmd0V2bGFzZ0VLZkZqVUxnbWp6VUlEdDVzWVo3aFp2?=
 =?utf-8?B?RE5XRHE3NjU1Unkva2RUSURwN3A0MEp4aytMbEpqSnFyU2VVaEI5TURrNkhX?=
 =?utf-8?B?cmpmOGRrRDJjdUpmVUxha1RBYnpKSzFSOGhpSyszREZ6WXBmdFNEb0ZJdFhD?=
 =?utf-8?B?NUY0bmFaWlpOMmZ6MzllVU5NNlRxV080OFpYeVVlOHhVeS9VMVVwdHdxNklq?=
 =?utf-8?B?S3RrS3BQQU9mMnE5YmxwOVJhb09ZSzJCL2U1Q2FDamV2S0lyWUpFRldsN0xh?=
 =?utf-8?B?bHlHUlQ5VmFlNVMvQmtHT3NuTGRXd3pGd29DZmF3WGxVaVpDUldhdXY5a3o5?=
 =?utf-8?B?QlIyQkhzcXMrdU9meWxvd2tuMGdUUkk3Nmc3alF0cG4vOWExL3lyQ1FoQVNj?=
 =?utf-8?B?VENmbFBYMVRVcWwwM3JMd3JMWWJXZWMrSVI4Q2kwWlFobDkyTGlBOXd5Q2hK?=
 =?utf-8?B?VjRzWVBobjdaOFBiQXpJekZzU1FXcWE3eWE4L1MwWGpqY2NJZ0N6QjE5blFN?=
 =?utf-8?B?WWxvTm5HUjdHaHFoK2pWT3IyaTYxalVkN0ZSb3NyRDlCeEhpUnN5ekRqR0lk?=
 =?utf-8?B?NkJ4R1hmNE9XeG9KTU9iUWN4RDZKQnY4ZU9QUDFZSmNDZWUveVVPSTY5c3ll?=
 =?utf-8?B?TTR4UmZ2MGhqTlIxMEI2NHA1OHFmKzgvaVJPcTUrTWJFcUZwcG5SeU5DV2Ix?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A9F57DE580214478EC2648206E7E909@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1bKv+2yDXnurQUIuI58WUyNO0DrUy1GRa/8CoL4mN4ZMYbVSpEkwBWMPCE1Nxfqjf8p4UYSheSSD+B8H1VtEfPToiSNadNHp2bL15U5c/joXlcnH6XkKpBFDHEhrWu9Wcc5FokhvBYNAyX8F1m+UIfTgbP0XZKk3RgOjS8q7ZWZOFl6a/1bwfoOGx/w0O6BAKGCHJbADGVrXVqVwB/Z1UHt+6fM87EsI9mKZMg1HbYvMwITkU8MsgIO034zEJPuU08SJ7v/lYdXGc1xqzhq70YVgtR1uwBgV1hpCMuqxGd3zLPTqqu2Ya/VKzwK8Clk9BN9yGqpPwb/L4ZDgipV5mzYONyl1erknNvPdDVmwS2UguTJmzpPT0cfuhzhJ+UNBh0uGrmlHzWDgBnbBdUol3DxPy027XNRa8jwplMW7C9tSvaP4wq2p0HeqCAYOHPEAmXaRfvtuNM48i9DWRPM3+hCBssfK7z3qnJQ/O7NRcTIpxNneOmVYXpZOhYFp6ZoLeWkeeYl0/QWspvb4YpR5zPXI3LbfZ4KM7cFuVllD3yRqdM8azfDCAydVne/05Hdh6WbJSgvPyAVr8pBbSyW9EWF/qVPHzHtKb+d1OFJAHFwKMyZS4GRkd9iCTfqegD5W9l1cXwMzllIM8snTVq42Zg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeb4f67-459e-410d-7f1c-08dc3f1a0866
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 02:47:02.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6DY4V3RqHUKJxgcbc2nZcjOZGybeh3aq8oJByaMjIq4WIRICjgsDtQj3yuHNyXBnX7Oh5UQajTyK10KQCEtcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
X-Proofpoint-ORIG-GUID: P5uKsgWApJnSy74LEagaWGsrQIggwh4t
X-Proofpoint-GUID: P5uKsgWApJnSy74LEagaWGsrQIggwh4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080022

T24gVGh1LCBNYXIgMDcsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBUaHUs
IE1hciAwNywgMjAyNCBhdCAwMTo1Nzo0NEFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gVHVlLCBGZWIgMjcsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
T24gVGh1LCBGZWIgMjIsIDIwMjQgYXQgMDE6MjA6MDRBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiBPbiBUaHUsIEZlYiAyMiwgMjAyNCwgTWljaGFlbCBHcnplc2NoaWsgd3Jv
dGU6DQo+ID4gPiA+ID4gRm9yICMyOiBJIGZvdW5kIGFuIGlzc3VlIGluIHRoZSBoYW5kbGluZyBv
ZiB0aGUgY29tcGxldGlvbiBvZiByZXF1ZXN0cyBpbg0KPiA+ID4gPiA+IHRoZSBzdGFydGVkIGxp
c3QuIFdoZW4gdGhlIGludGVycnVwdCBoYW5kbGVyIGlzICpleHBsaWNpdGx5KiBjYWxsaW5nDQo+
ID4gPiA+ID4gc3RvcF9hY3RpdmVfdHJhbnNmZXIgaWYgdGhlIG92ZXJhbGwgZXZlbnQgb2YgdGhl
IHJlcXVlc3Qgd2FzIGFuIG1pc3NlZA0KPiA+ID4gPiA+IGV2ZW50LiBUaGlzIGV2ZW50IHZhbHVl
IG9ubHkgcmVwcmVzZW50cyB0aGUgdmFsdWUgb2YgdGhlIHJlcXVlc3QgdGhhdA0KPiA+ID4gPiA+
IHdhcyBhY3R1YWxseSB0cmlnZ2VyaW5nIHRoZSBpbnRlcnJ1cHQuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJdCBhbHNvIGNhbGxzIGVwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzIGFuZCBpcyBp
dGVyYXRpbmcgb3ZlciB0aGUNCj4gPiA+ID4gPiBzdGFydGVkIHJlcXVlc3RzIGFuZCB3aWxsIGNh
bGwgZ2l2ZWJhY2svY29tcGxldGUgZnVuY3Rpb25zIG9mIHRoZQ0KPiA+ID4gPiA+IHJlcXVlc3Rz
IHdpdGggdGhlIHByb3BlciByZXF1ZXN0IHN0YXR1cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNv
IHRoaXMgd2lsbCBhbHNvIGNhdGNoIG1pc3NlZCByZXF1ZXN0cyBpbiB0aGUgcXVldWUuIEhvd2V2
ZXIsIHNpbmNlDQo+ID4gPiA+ID4gdGhlcmUgbWlnaHQgYmUsIGxldHMgc2F5IDUgZ29vZCByZXF1
ZXN0cyBhbmQgb25lIG1pc3NlZCByZXF1ZXN0LCB3aGF0DQo+ID4gPiA+ID4gd2lsbCBoYXBwZW4g
aXMsIHRoYXQgZWFjaCBjb21wbGV0ZSBjYWxsIGZvciB0aGUgZmlyc3QgZ29vZCByZXF1ZXN0cyB3
aWxsDQo+ID4gPiA+ID4gZW5xdWV1ZSBuZXcgcmVxdWVzdHMgaW50byB0aGUgc3RhcnRlZCBsaXN0
IGFuZCB3aWxsIGFsc28gY2FsbCB0aGUNCj4gPiA+ID4gPiB1cGRhdGVjbWQgb24gdGhhdCB0cmFu
c2ZlciB0aGF0IHdhcyBhbHJlYWR5IG1pc3NlZCB1bnRpbCB0aGUgbG9vcCB3aWxsDQo+ID4gPiA+
ID4gcmVhY2ggdGhlIG9uZSByZXF1ZXN0IHdpdGggdGhlIE1JU1NFRCBzdGF0dXMgYml0IHNldC4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIGluIG15IG9waW5pb24gdGhlIHBhdGNoIGZyb20gSmVm
ZiBtYWtlcyBzZW5zZSB3aGVuIGFkZGluZyB0aGUNCj4gPiA+ID4gPiBmb2xsb3dpbmcgY2hhbmdl
IGFzd2VsbC4gV2l0aCB0aG9zZSBib3RoIGNoYW5nZXMgdGhlIHVuZGVycnVucyBhbmQNCj4gPiA+
ID4gPiBicm9rZW4gZnJhbWVzIGZpbmFsbHkgZGlzYXBwZWFyLiBJIGFtIHN0aWxsIHVuc3VyZSBh
Ym91dCB0aGUgY29tcGxldGUNCj4gPiA+ID4gPiBzb2x1dGlvbiBhYm91dCB0aGF0LCBzaW5jZSB3
aXRoIHRoaXMgdGhlIG1lbnRpb25lZCA1IGdvb2QgcmVxdWVzdHMNCj4gPiA+ID4gPiB3aWxsIGJl
IGNhbmNlbGxlZCBhc3dlbGwuIFNvIHRoaXMgaXMgc3RpbGwgYSBXSVAgc3RhdHVzIGhlcmUuDQo+
ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gV2hlbiB0aGUgZHdjMyBkcml2ZXIgaXNzdWVzIHN0
b3BfYWN0aXZlX3RyYW5zZmVyKCksIHRoYXQgbWVhbnMgdGhhdCB0aGUNCj4gPiA+ID4gc3RhcnRl
ZF9saXN0IGlzIGVtcHR5IGFuZCB0aGVyZSBpcyBhbiB1bmRlcnJ1bi4NCj4gPiA+IA0KPiA+ID4g
QXQgdGhpcyBtb21lbnQgdGhpcyBpcyBvbmx5IHRoZSBjYXNlIHdoZW4gYm90aCwgcGVuZGluZyBh
bmQgc3RhcnRlZCBsaXN0DQo+ID4gPiBhcmUgZW1wdHkuIE9yIHRoZSBpbnRlcnJ1cHQgZXZlbnQg
d2FzIEVYREVWLg0KPiA+ID4gDQo+ID4gPiBUaGUgbWFpbiBwcm9ibGVtIGlzIHRoYXQgdGhlIGZ1
bmN0aW9uDQo+ID4gPiBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0cyhk
ZXAsIGV2ZW50LCBzdGF0dXMpOyB3aWxsDQo+ID4gPiBpc3N1ZSBhbiBjb21wbGV0ZSBmb3IgZWFj
aCBzdGFydGVkIHJlcXVlc3QsIHdoaWNoIG9uIHRoZSBvdGhlciBoYW5kIHdpbGwNCj4gPiA+IHJl
ZmlsbCB0aGUgcGVuZGluZyBsaXN0LCBhbmQgdGhlcmVmb3IgYWZ0ZXIgdGhhdCByZWZpbGwgdGhl
DQo+ID4gPiBzdG9wX2FjdGl2ZV90cmFuc2ZlciBpcyBjdXJyZW50bHkgbmV2ZXIgaGl0Lg0KPiA+
ID4gDQo+ID4gPiA+IEl0IHRyZWF0cyB0aGUgaW5jb21pbmcgcmVxdWVzdHMgYXMgc3RhbGVkLiBI
b3dldmVyLCBmb3IgVVZDLCB0aGV5IGFyZQ0KPiA+ID4gPiBzdGlsbCAiZ29vZCIuDQo+ID4gPiAN
Cj4gPiA+IFJpZ2h0LCBzbyBpbiB0aGF0IGNhc2Ugd2UgY2FuIHJlcXVldWUgdGhlbSBhbnl3YXku
IEJ1dCB0aGlzIHdpbGwgaGF2ZSB0bw0KPiA+ID4gYmUgZG9uZSBhZnRlciB0aGUgc3RvcCB0cmFu
c2ZlciBjbWQgaGFzIGZpbmlzaGVkLg0KPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgeW91IGNhbiBq
dXN0IGNoZWNrIGlmIHRoZSBzdGFydGVkX2xpc3QgaXMgZW1wdHkgYmVmb3JlIHF1ZXVpbmcNCj4g
PiA+ID4gbmV3IHJlcXVlc3RzLiBJZiBpdCBpcywgcGVyZm9ybSBzdG9wX2FjdGl2ZV90cmFuc2Zl
cigpIHRvIHJlc2NoZWR1bGUgdGhlDQo+ID4gPiA+IGluY29taW5nIHJlcXVlc3RzLiBOb25lIG9m
IHRoZSBuZXdseSBxdWV1ZSByZXF1ZXN0cyB3aWxsIGJlIHJlbGVhc2VkDQo+ID4gPiA+IHlldCBz
aW5jZSB0aGV5IGFyZSBpbiB0aGUgcGVuZGluZ19saXN0Lg0KPiA+ID4gDQo+ID4gPiBTbyB0aGF0
IGlzIGJhc2ljYWxseSBleGFjdGx5IHdoYXQgbXkgcGF0Y2ggaXMgZG9pbmcuIEhvd2V2ZXIgaW4g
dGhlIGNhc2UNCj4gPiA+IG9mIGFuIHVuZGVycnVuIGl0IGlzIG5vdCBzYWZlIHRvIGNhbGwgZHdj
M19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMNCj4gPiA+IGFzIGplZmYgc3Rh
dGVkLiBTbyBoaXMgdW5kZXJseWluZyBwYXRjaCBpcyByZWFsbHkgZml4aW5nIGFuIGlzc3VlIGhl
cmUuDQo+ID4gDQo+ID4gV2hhdCBJIG1lYW4gaXMgdG8gYWN0aXZlbHkgY2hlY2sgZm9yIHN0YXJ0
ZWQgbGlzdCBvbiBldmVyeQ0KPiA+IHVzYl9lcF9xdWV1ZSgpIGNhbGwuIENoZWNraW5nIGR1cmlu
Zw0KPiA+IGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzKCkgaXMgYWxy
ZWFkeSB0b28gbGF0ZS4NCj4gDQo+IEkgc2VlLg0KPiANCj4gPiA+IA0KPiA+ID4gPiBGb3IgVVZD
LCBwZXJoYXBzIHlvdSBjYW4gaW50cm9kdWNlIGEgbmV3IGZsYWcgdG8gdXNiX3JlcXVlc3QgY2Fs
bGVkDQo+ID4gPiA+ICJpZ25vcmVfcXVldWVfbGF0ZW5jeSIgb3Igc29tZXRoaW5nIGVxdWl2YWxl
bnQuIFRoZSBkd2MzIGlzIGFscmVhZHkNCj4gPiA+ID4gcGFydGlhbGx5IGRvaW5nIHRoaXMgZm9y
IFVWQy4gV2l0aCB0aGlzIG5ldyBmbGFnLCB3ZSBjYW4gcmV3b3JrIGR3YzMgdG8NCj4gPiA+ID4g
Y2xlYXJseSBzZXBhcmF0ZSB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IgZnJvbSB0aGUgZnVuY3Rpb24g
ZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IGtub3cgd2h5IHRoaXMgImV4dHJhIiBmbGFn
IGlzIGV2ZW4gbmVjZXNzYXJ5LiBUaGUgY29kZSBleGFtcGxlDQo+ID4gPiBpcyBhbHJlYWR5IHdv
cmtpbmcgd2l0aG91dCB0aGF0IGV4dHJhIGZsYWcuDQo+ID4gDQo+ID4gVGhlIGZsYWcgaXMgZm9y
IGNvbnRyb2xsZXIgdG8gZGV0ZXJtaW5lIHdoYXQga2luZHMgb2YgYmVoYXZpb3IgdGhlDQo+ID4g
ZnVuY3Rpb24gZHJpdmVyIGV4cGVjdHMuIE15IGludGVudGlvbiBpcyBpZiB0aGlzIGV4dHJhIGZs
YWcgaXMgbm90IHNldCwNCj4gPiB0aGUgZHdjMyBkcml2ZXIgd2lsbCBub3QgYXR0ZW1wdCB0byBy
ZXNoY2VkdWxlIGlzb2MgcmVxdWVzdCBhdCBhbGwgKGllLg0KPiA+IG5vIHN0b3BfYWN0aXZlX3Ry
YW5zZmVyKCkpLg0KPiANCj4gT2suDQo+IA0KPiA+ID4gDQo+ID4gPiBBY3R1YWxseSBJIGV2ZW4g
Y2FtZSB1cCB3aXRoIGFuIGJldHRlciBzb2x1dGlvbi4gQWRkaXRpb25hbGx5IG9mIGNoZWNraW5n
IGlmDQo+ID4gPiBvbmUgb2YgdGhlIHJlcXVlc3RzIGluIHRoZSBzdGFydGVkIGxpc3Qgd2FzIG1p
c3NlZCwgd2UgY2FuIGFjdGl2bHkgY2hlY2sgaWYNCj4gPiA+IHRoZSB0cmIgcmluZyBkaWQgcnVu
IGRyeSBhbmQgaWYgZHdjM19nYWRnZXRfZW5kcG9pbnRfdHJic19jb21wbGV0ZSBpcw0KPiA+ID4g
Z29pbmcgdG8gZW5xdWV1ZSBpbiB0byB0aGUgZW1wdHkgdHJiIHJpbmcuDQo+ID4gPiANCj4gPiA+
IFNvIG15IHdob2xlIGNoYW5nZSBsb29rcyBsaWtlIHRoYXQ6DQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+ID4gPiBpbmRleCBlZmU2Y2FmNGQwZTg3Li4yYzgwNDdkY2QxNjEyIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+ID4gPiBAQCAtOTUyLDYgKzk1Miw3IEBAIHN0cnVjdCBkd2MzX3JlcXVlc3Qg
ew0KPiA+ID4gICNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRAkJMw0KPiA+ID4g
ICNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19TVEFMTEVECQk0DQo+ID4gPiAgI2RlZmluZSBE
V0MzX1JFUVVFU1RfU1RBVFVTX0NPTVBMRVRFRAkJNQ0KPiA+ID4gKyNkZWZpbmUgRFdDM19SRVFV
RVNUX1NUQVRVU19NSVNTRURfSVNPQwkJNg0KPiA+ID4gICNkZWZpbmUgRFdDM19SRVFVRVNUX1NU
QVRVU19VTktOT1dOCQktMQ0KPiA+ID4gIAl1OAkJCWVwbnVtOw0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
ID4gPiBpbmRleCA4NThmZTRjMjk5YjdhLi5hMzFmNGQzNTAyYmQzIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+ID4gQEAgLTIwNTcsNiArMjA1Nyw5IEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXAp
DQo+ID4gPiAgCQlyZXEgPSBuZXh0X3JlcXVlc3QoJmRlcC0+Y2FuY2VsbGVkX2xpc3QpOw0KPiA+
ID4gIAkJZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKGRlcCwgcmVxKTsNCj4gPiA+ICAJCXN3aXRj
aCAocmVxLT5zdGF0dXMpIHsNCj4gPiA+ICsJCWNhc2UgMDoNCj4gPiA+ICsJCQlkd2MzX2dhZGdl
dF9naXZlYmFjayhkZXAsIHJlcSwgMCk7DQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiAgCQljYXNl
IERXQzNfUkVRVUVTVF9TVEFUVVNfRElTQ09OTkVDVEVEOg0KPiA+ID4gIAkJCWR3YzNfZ2FkZ2V0
X2dpdmViYWNrKGRlcCwgcmVxLCAtRVNIVVRET1dOKTsNCj4gPiA+ICAJCQlicmVhazsNCj4gPiA+
IEBAIC0yMDY2LDYgKzIwNjksOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVw
X2NhbmNlbGxlZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiA+ID4gIAkJY2FzZSBE
V0MzX1JFUVVFU1RfU1RBVFVTX1NUQUxMRUQ6DQo+ID4gPiAgCQkJZHdjM19nYWRnZXRfZ2l2ZWJh
Y2soZGVwLCByZXEsIC1FUElQRSk7DQo+ID4gPiAgCQkJYnJlYWs7DQo+ID4gPiArCQljYXNlIERX
QzNfUkVRVUVTVF9TVEFUVVNfTUlTU0VEX0lTT0M6DQo+ID4gPiArCQkJZHdjM19nYWRnZXRfZ2l2
ZWJhY2soZGVwLCByZXEsIC1FWERFVik7DQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiAgCQlkZWZh
dWx0Og0KPiA+ID4gIAkJCWRldl9lcnIoZHdjLT5kZXYsICJyZXF1ZXN0IGNhbmNlbGxlZCB3aXRo
IHdyb25nIHJlYXNvbjolZFxuIiwgcmVxLT5zdGF0dXMpOw0KPiA+ID4gIAkJCWR3YzNfZ2FkZ2V0
X2dpdmViYWNrKGRlcCwgcmVxLCAtRUNPTk5SRVNFVCk7DQo+ID4gPiBAQCAtMzUwOSw2ICszNTE1
LDM2IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVz
dChzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiA+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ID4gIH0NCj4g
PiA+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2NoZWNrX21pc3NlZF9yZXF1ZXN0cyhzdHJ1
Y3QgZHdjM19lcCAqZGVwKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGR3YzNfcmVxdWVzdAkq
cmVxOw0KPiA+ID4gKwlzdHJ1Y3QgZHdjM19yZXF1ZXN0CSp0bXA7DQo+ID4gPiArCWludCByZXQg
PSAwOw0KPiA+ID4gKw0KPiA+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAs
ICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkgew0KPiA+ID4gKwkJc3RydWN0IGR3YzNfdHJiICp0
cmI7DQo+ID4gPiArDQo+ID4gPiArCQl0cmIgPSByZXEtPnRyYjsNCj4gPiA+ICsJCXN3aXRjaCAo
RFdDM19UUkJfU0laRV9UUkJTVFModHJiLT5zaXplKSkgew0KPiA+ID4gKwkJY2FzZSBEV0MzX1RS
QlNUU19NSVNTRURfSVNPQzoNCj4gPiA+ICsJCQkvKiBJc29jIGVuZHBvaW50IG9ubHkgKi8NCj4g
PiA+ICsJCQlyZXQgPSAtRVhERVY7DQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiArCQljYXNlIERX
QzNfVFJCX1NUU19YRkVSX0lOX1BST0c6DQo+ID4gPiArCQkJLyogQXBwbGljYWJsZSB3aGVuIEVu
ZCBUcmFuc2ZlciB3aXRoIEZvcmNlUk09MCAqLw0KPiA+ID4gKwkJY2FzZSBEV0MzX1RSQlNUU19T
RVRVUF9QRU5ESU5HOg0KPiA+ID4gKwkJCS8qIENvbnRyb2wgZW5kcG9pbnQgb25seSAqLw0KPiA+
ID4gKwkJY2FzZSBEV0MzX1RSQlNUU19PSzoNCj4gPiA+ICsJCWRlZmF1bHQ6DQo+ID4gPiArCQkJ
cmV0ID0gMDsNCj4gPiA+ICsJCQlicmVhazsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJfQ0KPiA+ID4g
Kw0KPiA+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMg
dm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdj
M19lcCAqZGVwLA0KPiA+ID4gIAkJY29uc3Qgc3RydWN0IGR3YzNfZXZlbnRfZGVwZXZ0ICpldmVu
dCwgaW50IHN0YXR1cykNCj4gPiA+ICB7DQo+ID4gPiBAQCAtMzU2NSwyMiArMzYwMSw1MSBAQCBz
dGF0aWMgYm9vbCBkd2MzX2dhZGdldF9lbmRwb2ludF90cmJzX2NvbXBsZXRlKHN0cnVjdCBkd2Mz
X2VwICpkZXAsDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdj
Ow0KPiA+ID4gIAlib29sCQkJbm9fc3RhcnRlZF90cmIgPSB0cnVlOw0KPiA+ID4gKwl1bnNpZ25l
ZCBpbnQJCXRyYW5zZmVyX2luX2ZsaWdodCA9IDA7DQo+ID4gPiArDQo+ID4gPiArCS8qIEl0IGlz
IHBvc3NpYmxlIHRoYXQgdGhlIGludGVycnVwdCB0aHJlYWQgd2FzIGRlbGF5ZWQgYnkNCj4gPiA+
ICsJICogc2NoZWR1bGluZyBpbiB0aGUgc3lzdGVtLCBhbmQgdGhlcmVmb3IgdGhlIEhXIGhhcyBh
bHJlYWR5DQo+ID4gPiArCSAqIHJ1biBkcnkuIEluIHRoYXQgY2FzZSB0aGUgbGFzdCB0cmIgaW4g
dGhlIHF1ZXVlIGlzIGFscmVhZHkNCj4gPiA+ICsJICogaGFuZGxlZCBieSB0aGUgaHcuIEJ5IGNo
ZWNraW5nIHRoZSBIV08gYml0IHdlIGtub3cgdG8gcmVzdGFydA0KPiA+ID4gKwkgKiB0aGUgd2hv
bGUgdHJhbnNmZXIuIFRoZSBjb25kaXRpb24gdG8gYXBwZWFyIGlzIG1vcmUgbGlrZWxlbHkNCj4g
PiA+ICsJICogaWYgbm90IGV2ZXJ5IHRyYiBoYXMgdGhlIElPQyBiaXQgc2V0IGFuZCB0aGVyZWZv
ciBkb2VzIG5vdA0KPiA+ID4gKwkgKiB0cmlnZ2VyIHRoZSBpbnRlcnJ1cHQgdGhyZWFkIGZld2Vy
Lg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJaWYgKGRlcC0+bnVtYmVyICYmIHVzYl9lbmRwb2ludF94
ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgew0KPiA+ID4gKwkJc3RydWN0IGR3YzNfdHJi
ICp0cmI7DQo+ID4gPiAtCWR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3Rz
KGRlcCwgZXZlbnQsIHN0YXR1cyk7DQo+ID4gPiArCQl0cmIgPSBkd2MzX2VwX3ByZXZfdHJiKGRl
cCwgZGVwLT50cmJfZW5xdWV1ZSk7DQo+ID4gPiArCQl0cmFuc2Zlcl9pbl9mbGlnaHQgPSB0cmIt
PmN0cmwgJiBEV0MzX1RSQl9DVFJMX0hXTzsNCj4gPiA+ICsJfQ0KPiA+ID4gLQlpZiAoZGVwLT5m
bGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpDQo+ID4gPiAtCQlnb3RvIG91dDsN
Cj4gPiA+ICsJaWYgKHN0YXR1cyA9PSAtRVhERVYgfHwgIXRyYW5zZmVyX2luX2ZsaWdodCkgew0K
PiA+ID4gKwkJc3RydWN0IGR3YzNfcmVxdWVzdCAqdG1wOw0KPiA+ID4gKwkJc3RydWN0IGR3YzNf
cmVxdWVzdCAqcmVxOw0KPiA+ID4gLQlpZiAoIWRlcC0+ZW5kcG9pbnQuZGVzYykNCj4gPiA+IC0J
CXJldHVybiBub19zdGFydGVkX3RyYjsNCj4gPiA+ICsJCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0Mz
X0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4gPiA+ICsJCQlkd2MzX3N0b3BfYWN0aXZlX3Ry
YW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+ID4gPiAtCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9p
c29jKGRlcC0+ZW5kcG9pbnQuZGVzYykgJiYNCj4gPiA+IC0JCWxpc3RfZW1wdHkoJmRlcC0+c3Rh
cnRlZF9saXN0KSAmJg0KPiA+ID4gLQkJKGxpc3RfZW1wdHkoJmRlcC0+cGVuZGluZ19saXN0KSB8
fCBzdGF0dXMgPT0gLUVYREVWKSkNCj4gDQo+IEBbISFoZXJlISFdDQo+IA0KPiA+ID4gLQkJZHdj
M19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiA+ID4gLQllbHNlIGlm
IChkd2MzX2dhZGdldF9lcF9zaG91bGRfY29udGludWUoZGVwKSkNCj4gPiA+IC0JCWlmIChfX2R3
YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwKSA9PSAwKQ0KPiA+ID4gLQkJCW5vX3N0YXJ0ZWRf
dHJiID0gZmFsc2U7DQo+ID4gPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAs
ICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkgew0KPiA+ID4gKwkJCWR3YzNfZ2FkZ2V0X21vdmVf
Y2FuY2VsbGVkX3JlcXVlc3QocmVxLA0KPiA+ID4gKwkJCQkJKERXQzNfVFJCX1NJWkVfVFJCU1RT
KHJlcS0+dHJiLT5zaXplKSA9PSBEV0MzX1RSQlNUU19NSVNTRURfSVNPQykgPw0KPiA+ID4gKwkJ
CQkJRFdDM19SRVFVRVNUX1NUQVRVU19NSVNTRURfSVNPQyA6IDApOw0KPiA+ID4gKwkJfQ0KPiA+
ID4gKwl9IGVsc2Ugew0KPiA+ID4gKwkJZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRf
cmVxdWVzdHMoZGVwLCBldmVudCwgc3RhdHVzKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChkZXAt
PmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORykNCj4gPiA+ICsJCQlnb3RvIG91
dDsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICghZGVwLT5lbmRwb2ludC5kZXNjKQ0KPiA+ID4gKwkJ
CXJldHVybiBub19zdGFydGVkX3RyYjsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICh1c2JfZW5kcG9p
bnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykgJiYNCj4gPiA+ICsJCQlsaXN0X2VtcHR5
KCZkZXAtPnN0YXJ0ZWRfbGlzdCkgJiYgbGlzdF9lbXB0eSgmZGVwLT5wZW5kaW5nX2xpc3QpKQ0K
PiA+ID4gKwkJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4g
PiA+ICsJCWVsc2UgaWYgKGR3YzNfZ2FkZ2V0X2VwX3Nob3VsZF9jb250aW51ZShkZXApKQ0KPiA+
ID4gKwkJCWlmIChfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwKSA9PSAwKQ0KPiA+ID4g
KwkJCQlub19zdGFydGVkX3RyYiA9IGZhbHNlOw0KPiA+ID4gKwl9DQo+ID4gPiAgb3V0Og0KPiA+
ID4gIAkvKg0KPiA+ID4gDQo+ID4gPiBJIHdpbGwgc2VwZXJhdGUgdGhlIHdob2xlIGh1bmsgaW50
byBzbWFsbGVyIGNoYW5nZXMgYW5kIHNlbmQgYW4gdjENCj4gPiA+IHRoZSBuZXh0IGRheXMgdG8g
cmV2aWV3Lg0KPiA+ID4gDQo+IA0KPiBJIGZpbmFsbHkgc2VuZCBhIHYxIG9mIG15IHNlcmllcy4N
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0MDMwNy1kd2MzLWdh
ZGdldC1jb21wbGV0ZS1pcnEtdjEtMC00ZmU5YWMwYmEyYjdAcGVuZ3V0cm9uaXguZGUvDQo+IA0K
PiBGb3IgdGhlIHJlc3Qgb2YgdGhlIGRpc2N1c3Npb24sIEkgd291bGQgbGlrZSB0byBtb3ZlIHRo
ZSBjb252ZXJzYXRpb24gdG8NCj4gdGhlIG5ld2x5IHNlbmQgc2VyaWVzLg0KDQpJIHNhdyB5b3Vy
IHB1c2hlcy4gVGhhbmtzLiBJJ2xsIHJldmlldyBhbmQgbW92ZSB0aGUgZGlzY3Vzc2lvbiB0aGVy
ZS4NCg0KPiANCj4gPiBObywgd2Ugc2hvdWxkIG5vdCByZXNjaGVkdWxlIGZvciBldmVyeSBtaXNz
ZWQtaXNvYy4gV2Ugb25seSB3YW50IHRvDQo+ID4gdGFyZ2V0IHVuZGVycnVuIGNvbmRpdGlvbi4N
Cj4gDQo+IEFzIHlvdSBzdGF0ZWQgYWJvdmUsIHdpdGggcmVzY2hlZHVsZSB3aGF0IHlvdSBtZWFu
IGlzIGNhbGxpbmcNCj4gc3RvcF90cmFuc2ZlciBhZnRlciBhIG1pc3NlZCB0cmFuc2ZlciB3YXMg
c2Vlbj8NCj4gDQo+IElmIHNvLCB3aHkgaXMgdGhpcyBjb25kaXRpb24gaW4gdGhlcmUgYWxyZWFk
eT8gKEBbISFoZXJlISFdKQ0KPiANCg0KSXQncyBvbmx5IHRvIHJlc2NoZWR1bGUgaWYgc3RhcnRl
ZF9saXN0IGlzIGVtcHR5IF9hbmRfIGlmIHRoZXJlJ3MgZWl0aGVyDQpubyBwZW5kaW5nIHJlcXVl
c3Qgb3IgdGhlcmUncyBhIG1pc3NlZCBpc29jLiBOb3QgZm9yIGV2ZXJ5IG1pc3NlZCBpc29jLg0K
DQpCUiwNClRoaW5o

