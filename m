Return-Path: <linux-kernel+bounces-79257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7D861FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D0A1C2371C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0C14DFE0;
	Fri, 23 Feb 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZuChdq+4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RwwKkzcu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M9P5Zqe1"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583E1448E1;
	Fri, 23 Feb 2024 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727067; cv=fail; b=pHMuHs4BX9Iw5ieTFqtve+bEJtqgv2YZP02hroFiWnkvbDRn9EgwPoZxyfDXQ3BvsHCYXAfiz4kz2BNy41qHJoU3FQxgWRcMDwKU6gEGrUKJS677yNddBHBTCLXYcDlWMN1B/3jCXwuznQK6KH6lowwny/teDE83EzkuocK1Ym8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727067; c=relaxed/simple;
	bh=HAMlcCYUkaU1TdL0StYsb++efARQVPXnrLJDs08Lx0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g9WSHUtKFQCOUfgonX7LswCH9cUC8bVgd0JKGX9vTeD74C9KqCJSBDFp7Of+H4tsrbU0Px7KpMJHguI/N2+afQ0GdVNovqr2/qCTsyYeiV2odV6mp6gHc/HzjNYLeBVEMIi5zSqfT71Kl24DtPt8JQJgqF7bEKdgL4+x+nlNzvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZuChdq+4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RwwKkzcu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M9P5Zqe1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjfHD004389;
	Fri, 23 Feb 2024 14:24:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=HAMlcCYUkaU1TdL0StYsb++efARQVPXnrLJDs08Lx0o=; b=
	ZuChdq+4a9dXXMoSBzM07B0tZP+4wEijnu67ZXbtWllo8fG53M3NOa6T13zqWEiq
	R+PXWBZf5WH6WoI+xI3bJ60N31nFpSpt+1St2lRCm5Gvp14/qYPVOmvcXUt77kHQ
	n0qHpQI9FKCOZjE3FMCe1gqgCIug4JJndzdnUg1XLmqmKZM+XaQm/lxh6HbEiOI/
	yguEhrNdZBfEfN9o8FyTjTiIqWM7VIVDDZEvgvDvyL42A8DSpC32mqMIp21mLcZY
	95ioiI/rtfwKfel+O4cZUwFSGnTxwprVZ6Aw4femGfnJuGiDXJ61KPWXzRQGbUak
	LmrHP1Am3fompqqVOIswBg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wd22891t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708727050; bh=HAMlcCYUkaU1TdL0StYsb++efARQVPXnrLJDs08Lx0o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RwwKkzcuvS8ZsbOC7S5jIR8x7sIQSLy31Z4juryU/66hTzwHBAnvES1sbwaBt3ox0
	 NZoSERDPFYA8KAF4ktKfVuHQrqhLWtETzWtkDG/8/AQWvOCNiusUvoVtae07yEdpOV
	 abeXQpEFXmMLQTKJQQ7pTbjDsY+GIZGQ/ic99NAwo4ZzJWkSVDcU3KwLv/tjtYUIlf
	 K2/IhdzC+rDveH6xW1pKtzmHCnuSs2+fX/sCplL/2mYOLZvmgHmMMBVuRHoHcz7U7L
	 sGe7Un0V3SRTDn5oHdQjqhiwSzOkecHcOYyRCSaSMdwPhj9sFGpBQ1S96TDQWn0DOS
	 qXneRYXkF47tQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7FE774035A;
	Fri, 23 Feb 2024 22:24:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B03C8A008A;
	Fri, 23 Feb 2024 22:24:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=M9P5Zqe1;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 62AAF40132;
	Fri, 23 Feb 2024 22:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3k/iwsutYmP9EClQmAjAHlFPWbIx4r/JtJoI0MyB1ESPhm+1r91cT7LCEnXBnPzIQRkaCrZJErEc9U8Ohet/WsbKu3UAE2kt5AZALvpVFCjPtGExxO6CbIkFl5fqAQlop1zWO3n1+zRuqvAD7WTJZl8ZN82c9Uvam/zZm4jcQr9pa7P1A9Vl3f9rAEZeNbhz4amaIss8VZXmEW3cqgz4GRDQgPK2hJNX8m5v6HELntUkADM4LuqtBusDmrXLLQadHvUIvBpByjzNRAc0RfNslUEJoyse8Non11Oikd23R7+bglKeaojdke+sOGLVfDkvCT523RIY4BYLFoVxMBTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAMlcCYUkaU1TdL0StYsb++efARQVPXnrLJDs08Lx0o=;
 b=D77G9oCOfhZKFWZ17AuLAUkwhspfHLrvCiLW0zHiswAvL11ZOF72kmEw/Ci+tfVZPY65wudhCgoxJfSydUQhWhPHDhn8vbP1H+GcPYnvnIw/VZcMwtSVyadarFhC9ZKCmDW3JN3LOgfOyG5NQ9hAWbY0Or2q9V3zLxBbNY4Btq/A4sVEazF9SNcnT57JmsQMu5zHO7CmpbgxzWWvhdf6ZwClXURNUKIgcaw4DtuOFuRlNhE/RQerD33QIzqeCiiJ/rHM7t1iWynphVPE5ju1fCPnjLCI9ucqIDQNVX9U2pcDzIyPHHV3dYM+WKAbp8uJxA56fFimxZKQj/+Ta2quNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAMlcCYUkaU1TdL0StYsb++efARQVPXnrLJDs08Lx0o=;
 b=M9P5Zqe1WA6hXPrkR2S3iyvJmV90m0UVabF+vA+YLGzAfXnNaSKMFpXgEhZNKuVPfDmwVgCSRJfzEEbCwbmKDWRm7gRJgkcCG/8MW5os8Ymjynh0wqlUDUF4GtPTYF6MI1mpeMDb7+I+yBg3lzm+T7VQQ6cI6Gkb5w0lXJBUesw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 22:24:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:24:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "afd@ti.com" <afd@ti.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] usb: dwc3-am62: add workaround for Errata i2409
Thread-Topic: [PATCH v3 5/5] usb: dwc3-am62: add workaround for Errata i2409
Thread-Index: AQHaXysCtO00pdEKvkOQZL1bBxkAMbEYj6sA
Date: Fri, 23 Feb 2024 22:24:04 +0000
Message-ID: <20240223222402.x5g4hjcrvaa23gt2@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-5-147ec5eae18c@kernel.org>
In-Reply-To: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-5-147ec5eae18c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7220:EE_
x-ms-office365-filtering-correlation-id: b497915c-f606-42b8-d8a7-08dc34be24a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EHM+ppdkdLCR/vvZa7k4Xmj2dCGe9i31hH3fiw3BM9FDcDZSp0ldUXldSeB4P0a/CJbN3qOIK9J6HnhOi/lVC0xpSg+asWRyGL69Da/VPlgXEawUBTZTaFHC7MNIF+ZFtnmMvawcjf5clWlTTQQxzLNV2DYKXPbFdWnk8VZlALYNICR6lPpWWmHI3xm0YLCV3pWNb2h1cIx2sSVm+/9kFaHvW25Q9262QhKcBX39zK//tN6wK4bEPig67jgkeZYgcvkafVrVh+oOyLtvO4lXTo+RdArTuwNpGjhKtFRdejQSrmF9XlUWnZpygo/U+DLIfEddqLo6mWlJHA04GqEjcgNatQ/K/63/PEn/1fA2ZebDc+yvhXLRkDkGG3QPOZUQYgAx8d3/jp0Kf5oX/yxeSlFvhl8Zne/doLq2Yxfb9108GP0/B+f9OryAe303ztGIUDSgA4tKucfMuWkUZNHPBOkr7AQF45qQjnRckF0WN9xS6ecPovx1gOpRat1+OZcnGKCJivaJ3VmUBnN7ZGGTZBj3T7aOxPPmg+dacQlkHt4hLd5snEgR9yXjwq1kM4yRcQoF+2IyFbHq7yuJhn3gQzCn01F5Hxr9xMb8d0p1+ws=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dmlxemI5N1FUaEJ2cWhCMHZtU3FDRFBqc09FUXozRlhqMUk0SnA4ZE9FOE5l?=
 =?utf-8?B?LzJjT2FTNVRGNWw3bHA4TEsxZDVTdTNhUjMreTZ2eHFmVHBUMWxxdjhvdUx0?=
 =?utf-8?B?ZHh5NkdEVDR0YmsvYnZqcE1hR3JNNEx5ZjU0OWVEYlArUHBzdlU2VHA2WGtH?=
 =?utf-8?B?SGFKdGNRK0NDcWZNTXJ5VEtDdi9acHEvaW85aGJvUEJRK0VlVjZXeHluTGR4?=
 =?utf-8?B?NGFFZlpJMTNaYTNFdzBNN2V2a0F0UnRFZTlMMWNaeTJSaW0wM28xbHU2Wis2?=
 =?utf-8?B?aWZzZXBmdlk1RFVTUzlTajB5ejdkM0wydXFZU0FGZGpNWTBhR1FGVy9mVTI1?=
 =?utf-8?B?MENkR2tCb2pxblF1YlE0OHRCSU4zZjc3NXZ4Tkk2L3VGd2ZUT0dEaGJwY0ps?=
 =?utf-8?B?UTFRNVE4MDBPL1BQNk5TK0o1V1gzeXRqcDdDK2hXTE40aTJ2L2xjaDl1YjFw?=
 =?utf-8?B?OVlOZENxemNUZTFEMkRVTHZTM2ExUENtNmVLK2ZsNGRFTkFPNnhFMUpMU1dZ?=
 =?utf-8?B?Umh2Q0ZNNFlIZGg2OWYvKzM4c1JRcVBRYjNRRHUzUkRoYmpJaXJnOGJxbnc5?=
 =?utf-8?B?Qmtsb09saUpIMXFxNzJkSWdkUUFNcnZEMWRYSUN4ank2a29XWDdLQWVoUGRE?=
 =?utf-8?B?UXNRVC84N1FZWnRUMWRacXhXam9vNmpFQVNuSmR0OTBuTE13Sk5yUVVSeVlE?=
 =?utf-8?B?dE5haVZGZndZZklxZU1nc251ZWJuTEFaUHBnMnp1cW5ES1NOaUNoTk9RZ25O?=
 =?utf-8?B?cHpyRnhGRVgyUG5ldkZRREgraDdIZFc4bTlkODhwU3EwWjVsZFc1ZnlUdHRn?=
 =?utf-8?B?NnJGRkJocmhnMkMzaS9nek04dDJrbVNSYTMyVjNUeE9EcWd6eWVhcTI2djRS?=
 =?utf-8?B?NU9XVTNSb1NYdlI3Y1d1bzlaYit3YzF3ZnEvU1F0MWV1NVFvcWZONEhhMm1Z?=
 =?utf-8?B?c2UzSS82a3dBeGNqM1BCenVYNmhyMmliMVo4NWZiN3NwVTVZdUhCL3NyUWJE?=
 =?utf-8?B?UWZzR3hkWWk1ZUJiV3hKZUhwVGwyazdGZWtMWjBVdGVwYkI2ejNoYkJHUnZ1?=
 =?utf-8?B?a3ZpbUFOS0ZTc0M3Tmg1dGRXbi9QcVBkRE81cVJkYVA4b1ZxdUpxeTk0NDB1?=
 =?utf-8?B?NzZaaEsyTWVsbVl3ZmRuc3VEdWJ3R3JNV1hQWTB3MExIWVFOTkdub3cxVVF2?=
 =?utf-8?B?WEQxdWZzWmxXSkQ1K3NsRHFQYzlPR0U0MWdtOFZVdFBGRUhMMnVZZFp3Y0NR?=
 =?utf-8?B?T1ZsZEtOc1lpb1RFK3pLcE9GUk4wdWp1RUpyMmtWZTlZb1dmODd2Z0dXQTVj?=
 =?utf-8?B?QUs1c0xZRWhwODNoYnYwY3E5UVhNVXFRNXhGcG5XNjgxOUhDTU5HajV2QnBL?=
 =?utf-8?B?Q0ZYTGFDY3BHT3ZYYTNDT2pzVnZGdUZuVWFWMXJCR2loNjBEdTkzeEl0QzNy?=
 =?utf-8?B?WjdqczNIRk9lb3lFb1cvOEhNME9aTi92SUhmUGRjMlhCN2xsck4vd0tNL3dF?=
 =?utf-8?B?RHdQczgzdmZ5WGtncWQ2b3o2aExJaWFEUnRuZlowaXZtYmtoZXBEYUkyM2kx?=
 =?utf-8?B?Z2tiOElGRndUV2w2Nk5rZWowa1d5M1JOMENNeDJXMWRHVkVES3lGME9LQnJT?=
 =?utf-8?B?NmxjcGlmbFFTSE82RHRZTnFydXlqdVN4ZkdnZzAyeGVvUFBSZnduL3BQZ244?=
 =?utf-8?B?VW55ZlBUUnVSb0tkQlpocjhpWlZTbDJnQTBjWkxLQWFQTmVuc0tHTzVHWU5Z?=
 =?utf-8?B?MHh4TDM1bXI4WG1sQTUvS3o3WG0wQlBycjNaRUpsYVBzb29qcWcvNVd5by8y?=
 =?utf-8?B?SWxvVDJxdE1TSFFJc2hiTjE4VU1nZGJrVkl4RmhBcmI2MHhCbmdTb01JY3Bt?=
 =?utf-8?B?eXhtTUhXVVFkYUh4ZThqU0Y0R2tHZWRhWVdReEsrRy9iNzJzVjcyN1I4Z01H?=
 =?utf-8?B?M2d2UGRqMUM3cDREanJKM2dGSGpjbDNEcURMRmlXdUhySkZMd1MrYlRBQmJ0?=
 =?utf-8?B?UlJuelVCcGcrZGhTcCtPeGRNUXJHS21qUmgrQmNGNW1MU2MxbU9aQW0wb28x?=
 =?utf-8?B?bERjUW4raUtZay95Ry9Odld6dGdINzF2OFRibzdNdXlrbmZSOTNvQ2JKc1FT?=
 =?utf-8?Q?A4YhEo3NeTMkn8HJfqmUhIjZk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5237B92B980344EAE2FED09A3AA2CCE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZsceF4wdkiAhRniX1UM6Rnt0fGRrpegIyKOQ8M6JTH0x1nlgtVnJwlmMercYV9LAudefyf1dasieYACntcCWP60HMyuVK5iLn9KQANh0zu5IKz/4Z/KqRM6Oiy0TUV0MiNfnRtnYKvXK7oi2N6oLW/h40QDJgYVfZQrbZsSN1hjRTV75FXYhtgs4U/axb38q5gavWmf5SkcaLwAEuul/9dRbL+9qWn+7rZuf3hO1sNDc5gFxbMf0WIDLWSdVHjq86uGHtYtBsUaZ/xbKciicOtko9u9CLhoLSwRW/RGu01UVUEEwWsNtS0QR40POj02Of0yQZCctGXifpMjk1YW9vljELKNnkMCyxj2ecAAp0icvKXXWMaOhPSg/T/4aIdPMOUt3twI1sHLw0MOYrNWlW3KFprKJ8pWF1AWXIoZaA9xDYhxiD0OF+LHlccBGwrFtLGoBAvHtwdIhHQG1oGfoHjZwq2jbaRAgAigemGvfsbCCzCM98hgUCHUy5aPj/s0fJuQHeZOfyOBdN5+JPB2IAcvr7rD9NSQ0YEu6PBXHBmXLvnlvJsLdRsbL8EyLHK8cua1yNy3jrL5SR6ygtXKXjLLDvV+zIr1QsTOf74KMOP8i9wBbspnpwocpYwLRVUL0fJoc4k07XFm4kzBvuRGmAQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b497915c-f606-42b8-d8a7-08dc34be24a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:24:04.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzKWHMnVCT4cQ0Mwv6bICwZSfqSB5pfzaUtnUKHUtom4IjS5FYFZVJudJogDgHDsvcB56T6XL2fcli6m0yPWhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Proofpoint-GUID: KSWOwbCNgcqtgZ_Cz6dKoSmfJQ7hsRQB
X-Proofpoint-ORIG-GUID: KSWOwbCNgcqtgZ_Cz6dKoSmfJQ7hsRQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230160

T24gV2VkLCBGZWIgMTQsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEFsbCBBTTYyIGRl
dmljZXMgaGF2ZSBFcnJhdGEgaTI0MDkgWzFdIGR1ZSB0byB3aGljaA0KPiBVU0IyIFBIWSBtYXkg
bG9jayB1cCBkdWUgdG8gc2hvcnQgc3VzcGVuZC4NCj4gDQo+IFdvcmthcm91bmQgaW52b2x2ZXMg
c2V0dGluZyBiaXQgNSBhbmQgNCBQTExfUkVHMTINCj4gaW4gUEhZMiByZWdpc3RlciBzcGFjZSBh
ZnRlciBVU0IgY29udHJvbGxlciBpcyBicm91Z2h0DQo+IG91dCBvZiBMUFNDIHJlc2V0IGJ1dCBi
ZWZvcmUgY29udHJvbGxlciBpbml0aWFsaXphdGlvbi4NCj4gDQo+IEhhbmRsZSB0aGlzIHdvcmth
cm91bmQuDQo+IA0KPiBbMV0gLSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93
d3cudGkuY29tL2xpdC9lci9zcHJ6NDg3ZC9zcHJ6NDg3ZC5wZGZfXzshIUE0RjJSOUdfcGchZGpy
aEIzZ1c5cTlaQnp2N18xNU1Eck1xeE9lUXVPTWJyY2VSczZOc25Bek1NckVOQUdMTXJ0LXp2cTVh
dlJlaTl1QzZyM3g5a0l0d29iS3huMlZ3JCANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1
YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdlbG9nOg0KPiANCj4gdjM6
DQo+IC0gbW92ZSByZXF1ZXN0aW5nIG9mIFBIWTIgcmVnaW9uIHRvIHJpZ2h0IHdoZXJlIHdlIG5l
ZWQgaXQNCj4gDQo+IHYyOg0KPiAtIGRvbid0IGFkZCBwaHkgcmVhZC93cml0ZSBoZWxwZXJzIG9y
IGFkZCBwaHkgdG8gcHJpdmF0ZSBkYXRhDQo+IAlodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjA1MTQxMjIxLjU2MDc2LTUtcm9nZXJx
QGtlcm5lbC5vcmcvX187ISFBNEYyUjlHX3BnIWRqcmhCM2dXOXE5WkJ6djdfMTVNRHJNcXhPZVF1
T01icmNlUnM2TnNuQXpNTXJFTkFHTE1ydC16dnE1YXZSZWk5dUM2cjN4OWtJdHdvYkkwT1pEMSQg
DQo+IA0KPiB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI0MDIwMTEyMTIyMC41NTIzLTUtcm9nZXJxQGtlcm5lbC5vcmcvX187ISFB
NEYyUjlHX3BnIWRqcmhCM2dXOXE5WkJ6djdfMTVNRHJNcXhPZVF1T01icmNlUnM2TnNuQXpNTXJF
TkFHTE1ydC16dnE1YXZSZWk5dUM2cjN4OWtJdHdvZmVKU3NpMSQgDQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1hbTYyLmMNCj4gaW5kZXggYWYxY2U5MzRlN2ZiLi4xNjMyNzgwNTA1OTUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9kd2MzLWFtNjIuYw0KPiBAQCAtMTAxLDYgKzEwMSwxMSBAQA0KPiAgI2RlZmluZSBQSFlfQ09S
RV9WT0xUQUdFX01BU0sJQklUKDMxKQ0KPiAgI2RlZmluZSBQSFlfUExMX1JFRkNMS19NQVNLCUdF
Tk1BU0soMywgMCkNCj4gIA0KPiArLyogVVNCIFBIWTIgcmVnaXN0ZXIgb2Zmc2V0cyAqLw0KPiAr
I2RlZmluZQlVU0JfUEhZX1BMTF9SRUcxMgkJMHgxMzANCj4gKyNkZWZpbmUJVVNCX1BIWV9QTExf
TERPX1JFRl9FTgkJQklUKDUpDQo+ICsjZGVmaW5lCVVTQl9QSFlfUExMX0xET19SRUZfRU5fRU4J
QklUKDQpDQo+ICsNCj4gICNkZWZpbmUgRFdDM19BTTYyX0FVVE9TVVNQRU5EX0RFTEFZCTEwMA0K
PiAgDQo+ICBzdHJ1Y3QgZHdjM19hbTYyIHsNCj4gQEAgLTE4NCw4ICsxODksOSBAQCBzdGF0aWMg
aW50IGR3YzNfdGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAgCXN0cnVjdCBkd2MzX2FtNjIgKmFtNjI7DQo+IC0J
aW50IGksIHJldDsNCj4gIAl1bnNpZ25lZCBsb25nIHJhdGU7DQo+ICsJdm9pZCBfX2lvbWVtICpw
aHk7DQo+ICsJaW50IGksIHJldDsNCj4gIAl1MzIgcmVnOw0KPiAgDQo+ICAJYW02MiA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqYW02MiksIEdGUF9LRVJORUwpOw0KPiBAQCAtMjI3LDYgKzIz
MywxNyBAQCBzdGF0aWMgaW50IGR3YzNfdGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICsJLyogV29ya2Fy
b3VuZCBFcnJhdGEgaTI0MDkgKi8NCj4gKwlwaHkgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2UocGRldiwgMSk7DQo+ICsJaWYgKElTX0VSUihwaHkpKSB7DQo+ICsJCWRldl9lcnIoZGV2
LCAiY2FuJ3QgbWFwIFBIWSBJT01FTSByZXNvdXJjZS4gV29uJ3QgYXBwbHkgaTI0MDkgZml4Llxu
Iik7DQo+ICsJCXBoeSA9IE5VTEw7DQo+ICsJfSBlbHNlIHsNCj4gKwkJcmVnID0gcmVhZGwocGh5
ICsgVVNCX1BIWV9QTExfUkVHMTIpOw0KPiArCQlyZWcgfD0gVVNCX1BIWV9QTExfTERPX1JFRl9F
TiB8IFVTQl9QSFlfUExMX0xET19SRUZfRU5fRU47DQo+ICsJCXdyaXRlbChyZWcsIHBoeSArIFVT
Ql9QSFlfUExMX1JFRzEyKTsNCj4gKwl9DQo+ICsNCj4gIAkvKiBWQlVTIGRpdmlkZXIgc2VsZWN0
ICovDQo+ICAJYW02Mi0+dmJ1c19kaXZpZGVyID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChk
ZXYsICJ0aSx2YnVzLWRpdmlkZXIiKTsNCj4gIAlyZWcgPSBkd2MzX3RpX3JlYWRsKGFtNjIsIFVT
QlNTX1BIWV9DT05GSUcpOw0KPiANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA==

