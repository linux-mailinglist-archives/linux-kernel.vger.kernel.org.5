Return-Path: <linux-kernel+bounces-164786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6C8B82D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40AA1F23C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75918412D;
	Tue, 30 Apr 2024 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VDXKaAsa";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W2AokxgW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Non3wIuI"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5E1B806;
	Tue, 30 Apr 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518020; cv=fail; b=m7tBhzXMcRWQ+NVYFUnLKqAUFlUXp1Vl5S9NDnvKXUu/1opDEacVTqAb7hMPDnSlM8GhuWRPkkbNI2PNPihBUST7XQGgSCkVurPZ34+qYti7YJIp2tSODFs+BE7GT6GEEtFq7OgVyWUy7xE18nxIeaapBMj9I1djYaqU2v5CA/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518020; c=relaxed/simple;
	bh=M3WclNBBPJ+9yQJnASxtkq8hx8+gVVnFqINavmfuDWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXt0t4manyHqLxStTFkqq/1xt59ymVBtivbH5imDliBrdr2qWp8XdcQZ2npjjLdtVD7tWSexla1VIu4FAa6Jx5nxfnhBXtdHRzAYJhMXOUJXU1WzIWAu373e7nvA5H0bopJbW0PY3oJMJCS5TKqM19n7lXNdmYzE/uWl+fwKXpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VDXKaAsa; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W2AokxgW; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Non3wIuI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ULWYm9018942;
	Tue, 30 Apr 2024 16:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=M3WclNBBPJ+9yQJnASxtkq8hx8+gVVnFqINavmfuDWo=; b=
	VDXKaAsa1awJ49HCPKtTK2WpRrm49pdXIiWPwA90DBQ1LfBd26nvRPKX4BAZHFJ+
	u1hx/88SjHFAmn5IO6znwTCZ+yxUAC3jkR0dv40x+aez/VRFG+V/onr8kawtoS09
	5Iijjq3hVrLT07FtDU6TOwfFjdKGs3hwcLYMEpMmVZ+xO+5MXyoycWYYLgbGVN2B
	rQRU2Fjevs+tK8VSpzWvKbfDc7oXhKiQ3JEOTfqKl9EIp6yyb7MeheEUKznIJaFT
	4TqD5f9o3nebbbDuK9N3X7vmGq61SuMEsAwgc0Kxm1Z2ONsiZxHZJl5Wcf1XQs7L
	8+8ZcA1+fnWLEYjU3TZs6Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xu4dfsj1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1714518008; bh=M3WclNBBPJ+9yQJnASxtkq8hx8+gVVnFqINavmfuDWo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=W2AokxgWvNLma6dNzhchoD5GL2EmQO8b6WcmkjaYDdzXCM8EWto5LFtAKOzCX9YHy
	 0OR4ySIdaxPs5BHOQHleHezakaerBTMH4Ddc/GG8mwVu6BlAI77A+ZJcxCdNRHqQnR
	 s3Kl1WZ+pWuc5JVvmq+kxWLsthqxJthjUXQaXzrAIG679Z+rlCR2JSUc91MJSH5TPB
	 nVUP2UAzEoSK4aATYuP15A9MS0w/yTYqTwyL/VVWGc8okhEZyynjgzlXnOJKM0IcMz
	 QRu+8HOdZ0PFIMnL/YxZrK6MZWsIhgaMc9tPcnnnEyQ4ctyRd8omIUaK819jgzqgUt
	 UpUiIAmLoDlVQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25CE54052A;
	Tue, 30 Apr 2024 23:00:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AE602A0068;
	Tue, 30 Apr 2024 23:00:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Non3wIuI;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7EFB0404D1;
	Tue, 30 Apr 2024 23:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/6jdf5fAb1Hm7dmcBgsjztFf1Q7o5f3It8uGS2/G1b+pV01VV2k64PwYC2YEmQSrWSh77RB2D5p+8Be3KicFh2ahijuwQx6Pxs9p7fm5iusPuo08m+kYATwxVXzJ1MhmSF23zUZHS8XD8DaYSU8FrSUDDsdJP1O/Brs+Rcg3Oul1dCoBenZ3iuJx8qFz5BiBRrHGUb+Z/GWp5CYuDYuWRaPbbxLRONO1CMfG96WBoud+4ARbxCAkmEXJi2/1DE+Dwm5710NatQGDtSBHdjD4HbVNMXu2pQt9SmLECkbe25WGLwgKBSGi/pLjdKVY1rt65T5ay9pBMKD8SEdMQHnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3WclNBBPJ+9yQJnASxtkq8hx8+gVVnFqINavmfuDWo=;
 b=lBFatL4o4w4qhsKOAaXkEbJHmwO+UOxbQU0RZrs1wame6beDFoBc2MNTEqUhSk6H9sqo+8RC4UQEiOHehxmJgTKxbOd6fDERqnpC2uZp/MAK3Hb+TVg2veR/RcggLBkLGf8+fMKghkW8f7aEwV62+I/+2aFhCWNLiL4ZlogY8qKluMSOKr4Z5v+kxCJQVXUJQxJ7FH0J1PLlj8gIM9dXxvhjpsgtvGvQ7B6UXM3u613Ug/RPgHKxzoC3IcO7/2tSSewu3mDhnQLkhSGk+orWeoKCeK1v/G9QEBb3rW4X67L+tDlqdlVoK+jVqiaA3s937CUA6IbgzdLF7cdSKO4b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3WclNBBPJ+9yQJnASxtkq8hx8+gVVnFqINavmfuDWo=;
 b=Non3wIuI2d1QGUIB1+2n6IxPmjWqn70WlcDV/SieVAsyAbih9bJo9moPlfHyiggmuc66CMbrOXHVBlVn4w1SqDVAi4EPS7T3xrYDYxDmAtPpjb+6Sqhjo5CB6o0q5Si/oqF0QxlqiPytTqPcF56pyOngsA5bupTxiAxqkXodUtI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 22:59:59 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 22:59:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prashanth K
	<quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Wait unconditionally after issuing EndXfer
 command
Thread-Topic: [PATCH v2] usb: dwc3: Wait unconditionally after issuing EndXfer
 command
Thread-Index: AQHals01ikh+2ijgpkeouSgG6Gru8LF5oSQAgAdiCICAAHN1gA==
Date: Tue, 30 Apr 2024 22:59:58 +0000
Message-ID: <20240430225955.e7g53uycd35hcql3@synopsys.com>
References: <20240425045749.1493541-1-quic_prashk@quicinc.com>
 <20240425232200.kozymtwjxjs7nmoz@synopsys.com>
 <2024043022-chatroom-backwash-371e@gregkh>
In-Reply-To: <2024043022-chatroom-backwash-371e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB9394:EE_
x-ms-office365-filtering-correlation-id: f715d338-41bb-4113-8551-08dc6969426d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VVJ6MTl3MldISUpoa1VWbXpNRlovR3I1bzNudjhqbzJ4MHphNVRra0FHellM?=
 =?utf-8?B?MnZucmRFaTVhb0tkWFJITlUwNUhobjBrcmM2SE5vOXF5dHViSmJtZnMvTzVa?=
 =?utf-8?B?MTB6VFBkR0dLdlJPbDUvQ2FXUGczalc1bTVzNCtLQ1p6MXVMYXFYcDV5S1Iz?=
 =?utf-8?B?cGJOS05xMDZwRkhaYjdSN3hGTFZoZjlRQVdHajIzWUk2TnNxdWVBbEt4RXNa?=
 =?utf-8?B?ekJFb0pGREIxTVNpaW5pUmV2U1JFN1RUS3I0Z1o0U1FRSGRDYmRxUmpNSzRM?=
 =?utf-8?B?aGloRG8vTHhCaHR4bk4vdWFqZERPSlpISU9HSHhXckhEVVlWM2xKY3JyeG96?=
 =?utf-8?B?NGJCWGFkejdCbjFEdzlXVlhjYzVEQW43SDdLSCtpL0pxbWdEZFhpQTIxS2kz?=
 =?utf-8?B?M2o4ZE92c0R4RTF1czNKK0RDSHJCTGZrMTIzWEEwd0g1NGxWTVNsNERIMkxS?=
 =?utf-8?B?TmRvR0ZVQU1GbG5VTkdHWVUwYjRURE41bXhnSjllVHdlOGh6K1QzMXdVVytj?=
 =?utf-8?B?ZG1venpxRFc1SHo5SlA5am5DbGxKQkJwdzZXdDlsKzdLV3dGWFk1TWJuYmNQ?=
 =?utf-8?B?S1N1OWpmdUVVdGsxZ1hQUzV4VXdaR0FpaGo5eEZ4dWRDWlZDclpBQTFzejVy?=
 =?utf-8?B?UklhWlY4a0JjUkhQbW9qNStsRUc3YitNMEw4eFRxQk16ZHp3a0t2L0JnSGRp?=
 =?utf-8?B?NDdhRk4yQW5jdE5uQ0RRL1F2WGtnNGVISlpCR2c3TmtjeFJkNjBhcW5Cd3hP?=
 =?utf-8?B?aStOcThmajdlMmV2YzFXenRpYys0UnRsR00yU0FGb3BxSUdiQ1o4WWo5djZO?=
 =?utf-8?B?SlU3eHFXQ2JtK21OTENuQlgxZEhNMHlIQjlYczRCaTRySGJMREtORGo0WU1C?=
 =?utf-8?B?dS85YzVpcmw3eFNMY3ZDUWdEOGZZc3B6b0YxRmlJd1hYVmtIbVZSZDZvTHkw?=
 =?utf-8?B?SmZYUGpCdTUySWR2OGpZR1paYXJBTVNDbzV2TkI2MmFiZ2VHZzlnQzFRbkx0?=
 =?utf-8?B?K1RDdjlxeGhtQnZVUzlVOEFwRENST0lSU0pRYm13VTBXcjlPN2p2MWU0WmRT?=
 =?utf-8?B?a205ZnhBR09vTFFYZTVqQWVQSnZnUURXVXNWNU10Z05JT09STmR4QUpmazFH?=
 =?utf-8?B?OWRMM1BXejBVNlV4UTZIdWlLak5ycnM4RURMM0txdUUyaXQ3YmZGVHdmRTM4?=
 =?utf-8?B?anJLMkNBNDZSTm11VWdvQ3ZmL3pmaUhUUTJwNFRUYm1IQ1BaVllDR3FFSUVM?=
 =?utf-8?B?a3dtU21rRi8rMjdrUzdJajR2RjJwYkxaOXpGNFBMWUMxOS9sUmhDL3NtTE10?=
 =?utf-8?B?b1hldjZXaXRwaEwyZVhWUWYySnBiV2hOU3A1QjZzL2JzV1BaTmxJUEtONkJY?=
 =?utf-8?B?ZnIzMURFTlBrZFpPeWJLMnpwUG5mQ0JyV1MwYzVDZ2RjUWZONVNGSmtWRGtU?=
 =?utf-8?B?TzhscXYxSHVmNjhKQ0U0RVhwOUpCZ1RsMFdvZ1UvNC9qdHF4WktLUWs0Y3JG?=
 =?utf-8?B?UktMUGtLbTZhbmRodVJIREUwOUZ5UjJVYUg4QW9kenJBbEtFb1hNMnI3alJh?=
 =?utf-8?B?SWg4czkxTTNMdHJLTkZTalVmSm1vSUlnaVpzK0c0bTY4QWx5K2xZR21YaE1j?=
 =?utf-8?B?a3dHL01kVkRvSnFHcWtTUFJWZ2V4M2NDNE0wL2oxdk5XeFBCVGI3QS9hY1lP?=
 =?utf-8?B?SGVsaUs0dU0rSkp5YjBTRHE1bi91V0VLZ1JHdkRlSDIwc2tuZmFhMlFVV0Fx?=
 =?utf-8?B?RHFrZ3dBRUtGWitZUFlSb0ZSMTJwYUZFUEdrczN1Q1UwNzZzdC9ERXI5MXFL?=
 =?utf-8?B?TkxIeWVJckJkdUx5aVNRUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Vmk2ZFd2eFk1blIxWWQyL3FTVlI2b044K1pYWU1LOGpldk01MXR6VFBSQmR0?=
 =?utf-8?B?MVNUdVFRMC9McGJJczQwNUtadnBnZys0d2RXTzJYa2ZGckFJQ0lwWk0yYktP?=
 =?utf-8?B?cUsvVlhZMmN5dk5vT21kRHlCTXB3NmdxWkJUQXo3NGxJbDdjbnR0L1NWSytJ?=
 =?utf-8?B?dVE2VEcvZDFTclVzdGY3RDhWeHEwR0lEWVBHV3IrZzNScTV5czVGN3krZysw?=
 =?utf-8?B?OTNseW56ZGZTN09lUE5kS1BRY1FiTVpkRlNxdmRmZlJ3V3JEVHRVNkwzTjNV?=
 =?utf-8?B?enU3VDdHYy9HRW4raUlVQ2xBbnE4d1puRGFPb0dPMm1hMGFsKzFuSy9xTWFJ?=
 =?utf-8?B?ODBlWjRQU2xWWnhtTmJqdEpMOTZxcGQ5ODdOT2JqYzlBemhiUUZHSmhGZHM3?=
 =?utf-8?B?bloxVnp3b3M5akFqbkk1Zmw4SHd0ZXlyQk1kL1djN2Z4M0VEQXVIVit3V3Fu?=
 =?utf-8?B?Y2FkUHpRWUtrWU1ybWtSRUlJMXZvMW9GWHJQMjV5NkMzaGlmRTRUVUFBSjVm?=
 =?utf-8?B?UHp2aWpkc3FhK09ZQWhiOHZvRUNQbjBRSVdtS3hoYlBiWklicC9KSjgycWhK?=
 =?utf-8?B?ZWhTRkhkbytObVRYa2dZUkhHdE10RnNoK0NwS0lUWVgvaUpCZEE4QWc0eXdv?=
 =?utf-8?B?SGJBdExnbmxmQkx4VytCS1drSnpRTThRcjJyK1hEd0YvWlJNUkpWT2NocGZY?=
 =?utf-8?B?bTRnOWN4UWpPclVIS2JMbkZrRjZ6Q3lTRG9IZEF2d3B4Y1REVnFpRm1kZVVU?=
 =?utf-8?B?WkN5dmpuNjc1WFNkSXFWNndXSE5QbDl5SWUrb1F6cW8xWWdRSTNpcDBZaXVJ?=
 =?utf-8?B?cThhdUtaZFh3S0ZlclJtd0JWdVUrazVLZW40czVyUmRZYlJNOXRVZk5ZYkl6?=
 =?utf-8?B?TzB6NTBiWHB2bS91bWlzaGpScUlGWXFyWHFSUmVYbGZMelJxcWxNTENQUXN5?=
 =?utf-8?B?azQ0b3dxQjdiVlpLNWhQOWQ1MzJiMThHN3JzaFN6N3FZcXcyK3Z2TEJiZlpL?=
 =?utf-8?B?M3NrdDBxNHhKTlVWTFdTU2V4WXAvTlNvb0srK0hZNmRXdU1YaXJXUzhKeGxG?=
 =?utf-8?B?VDdNUTk0ZGk3NnJsT0gvYSt3dTNCOHk3bFR0ZVFOUVVzZkxpNDh6OThHU2lT?=
 =?utf-8?B?YWMwTGhSS21QYS9FblJra1o4VW1HUFc2NENwbHZOOS9PT1NlbEpkL3dBeE1t?=
 =?utf-8?B?Y2pZUUpuRjNYanllbVJZYzFHc0xjZ3RadGNLRTB0WjBUZU9yY3UvSW00eFJk?=
 =?utf-8?B?VUM1WXNUVDZTQjVXUmRUVlJQeGxQREdEeUUyZFBnMEk5U0ZRMlNycHZzMHlP?=
 =?utf-8?B?SDBQK2dZTFdvMXRGRllkZU41ZE1ESGI0MGZod1ZCUXoyV0Jxc2hwcFM2ZHg4?=
 =?utf-8?B?VTVtSHl3SkYvMDZQNVoyK3MzbjV0QUZqajhhL254NUJtTVhLdEs1blRyVmZj?=
 =?utf-8?B?UzlIREh4WXVRSUcvbDk4UEZ3Y1h0YjJ4MHhKWCtFRkt6MEF6c0Y1dklRREZE?=
 =?utf-8?B?NkVnZTVtNzVGcVgrV3RJNldJR05KODhES0w5bmtmYTBXWWJRWGtDa2NNUUdW?=
 =?utf-8?B?WVRSRWVWZ2xYRU9jV1FmN3NUeFBvVGJRbFZRUkZFSVo3VlpTVmw4NExvcUxM?=
 =?utf-8?B?bGZkazBlaVladGNpdWdkbjVpYWZJdjRFSnhLVTdzUCtsZTI0OG5FemhyUTRP?=
 =?utf-8?B?L1lFOFhaaTZkWEhpbERkZ0Z0U3hEeEM5UG94aE9sNElQbWdiMUE4ZElIV0M5?=
 =?utf-8?B?aWJSZTEvWU5xNUJ1N1JEYytucnlnbXh2NjZidFNMaDA1R3l1eVE0ekNlTitF?=
 =?utf-8?B?NWRqQ25abVlsb01UUXZHRlJlM3NMOGQydTRtWENncHJYQVNiV05iRUNyQnpu?=
 =?utf-8?B?bEFzZXNrRStuN3BzdU5FRUhzcDJLdmxQV2dPOXNUVkhDN2xSdjYzMkVTM2k5?=
 =?utf-8?B?SlhXUm8xOC9wZ2dqU3VIa0NFd29UaVRjb3ltY2c5VVM4Z0oxbHVrWUNXWGgz?=
 =?utf-8?B?QUhROGpPdkQ3TzF2bVpsRGw5L1NhK09WazI5YVNsRm9RMlNOMm41V2FKOVdz?=
 =?utf-8?B?cmt1TW43dVN1bGx5S2pMVE12akxrTDB1TmowbW9wN2h0Wm5MMGFSNEFzYm04?=
 =?utf-8?Q?mNon0JIhdh7pWhtcR0Wx0km8c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1E8339EDC7E514FB3ABAA4E200C6046@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hALHBodG1SNkpHlztx7j0KXumT0zg8dhp9RtaXtjIJmCvpRemrFk3TPNfdPrEkbKTmEctwOH79DtEt+rjxXSLARFyKt/hQ4Td4oJ4ttZjoNibEO+r5G8i1jSTWUtdIkDsn0EXGrKmYeeKII/ogJKD+BdsuuBw+nHh5ejQkYapz7GVhubcE6V7iR8mnVk2bxEfK16MFg59+rG6mcG2XDS/jOG9byIupks/suDwd0DYpyXy/CVmrx/IpFqv/BvQEyA0BNvgHMlAXv32HOmOepcROO64BfwTV1NA/ZsdP9krThCy9X5fE6sNZmI7SbPQggcbITXuJgcRsiQiA3eyj/igB3GXkN5ECTh0i/wpe5osq7AsPU7CIOkM3Hn5eBfJr/vEiW28ccbJCVbzlCeT0VYQ+M5MPLiH5BJoLaFAf6vri1yiVKI2pouHA1pEt0s1uxm2fal51N+kROCxS6vFxggH29ueLGlpTw4HF7Y4EvJAmSEvGJYd1xD0L6+7u9EI1WGB0txZ1OWre4il0TnMVC1i+J5xOPN7lBBm3+gg3O/OdQCMCPYVlQxtUgrfML8RmymJl+jXqQJDkJzMd6ldlfhG0LdMIl7NlEWpPlFe55wNsoTwVZcRYaGQJUyXp0QW7pcMsMEDDgEa5F3RIdOkXvORw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f715d338-41bb-4113-8551-08dc6969426d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 22:59:58.6276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofyE/H9GgFQVNs2YsrA+qUY1l6RQ496blw8S+fY9Ucf/Ar8yZy8UrB7FBCKw4aAt/3e1KXTgbQU+Yfbm+dzbTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
X-Proofpoint-ORIG-GUID: RrNVPmorgwHOhCOnxikZTrsDC6p-TrL1
X-Proofpoint-GUID: RrNVPmorgwHOhCOnxikZTrsDC6p-TrL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_14,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=925 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404300163

T24gVHVlLCBBcHIgMzAsIDIwMjQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gVGh1
LCBBcHIgMjUsIDIwMjQgYXQgMTE6MjI6MDhQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IE9uIFRodSwgQXByIDI1LCAyMDI0LCBQcmFzaGFudGggSyB3cm90ZToNCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiA+ID4gaW5kZXggNGRmMjY2MWY2Njc1Li42NjZlYWU5NDUyNGYgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+ID4gPiBAQCAtMTcyNCw4ICsxNzI0LDcgQEAgc3RhdGljIGludCBf
X2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3Jj
ZSwgYm9vbCBpbnQNCj4gPiA+ICAJZGVwLT5yZXNvdXJjZV9pbmRleCA9IDA7DQo+ID4gPiAgDQo+
ID4gPiAgCWlmICghaW50ZXJydXB0KSB7DQo+ID4gPiAtCQlpZiAoIURXQzNfSVBfSVMoRFdDMykg
fHwgRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMzEwQSkpDQo+ID4gPiAtCQkJbWRlbGF5KDEpOw0K
PiA+ID4gKwkJbWRlbGF5KDEpOw0KPiA+ID4gIAkJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9UUkFO
U0ZFUl9TVEFSVEVEOw0KPiA+ID4gIAl9IGVsc2UgaWYgKCFyZXQpIHsNCj4gPiA+ICAJCWRlcC0+
ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORzsNCj4gPiA+IC0tIA0KPiA+ID4g
Mi4yNS4xDQo+ID4gPiANCj4gPiANCj4gPiBBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KPiANCj4gVGhpcyBwYXRjaCBicmVha3MgdGhlIGJ1aWxkIG9u
IG15IHN5c3RlbXM6DQo+IA0KPiAgIENDIFtNXSAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQubw0K
PiBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jOiBJbiBmdW5jdGlvbiDigJhfX2R3YzNfc3RvcF9h
Y3RpdmVfdHJhbnNmZXLigJk6DQo+IGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmM6MTcwMjoyMjog
ZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhkd2PigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxl
XQ0KPiAgMTcwMiB8ICAgICAgICAgc3RydWN0IGR3YzMgKmR3YyA9IGRlcC0+ZHdjOw0KPiAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgIF5+fg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycw0KPiANCj4gc28gSSBjYW4ndCB0YWtlIGl0IDooDQoNClRoYW5rcyBH
cmVnIGZvciByZXBvcnRpbmcuDQoNCkhpIFByYXNoYW50aCwNCg0KQ2FuIHlvdSByZXNlbmQgdjMg
d2l0aCB0aGUgYnVpbGQgZml4LiBZb3UgY2FuIGtlZXAgbXkgQWNrZWQtYnkuIEFsc28sDQpwbGVh
c2UgaGVscCB0ZXN0IGFuZCBjYXRjaCB0aGVzZSBpc3N1ZXMgZWFybHkgdG8gYXZvaWQgdHVybi1h
cm91bmQgdGltZS4NCg0KVGhhbmtzLA0KVGhpbmg=

