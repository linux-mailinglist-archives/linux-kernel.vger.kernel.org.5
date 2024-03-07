Return-Path: <linux-kernel+bounces-94844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4D8745D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0561C22B00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F217EF;
	Thu,  7 Mar 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H5TSsFt1";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BOtFLE0G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hp3hrc5Q"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197129B0;
	Thu,  7 Mar 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776939; cv=fail; b=Hzf/E+Y2Khi2xnl0KPDTQCs+451teH1b3uKT+NFwNXgiF4fXUI+pvgkKOsb9CKrQBwGJmCzI7hngBFqruD1M5bBUpo7hlC2Py4ut4NqsStZ+0+25U82l3ATrfHQyMY/dlaF75EW3AZgPn3qurw9kkDLkqN+25fiW8ubwpxhkJl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776939; c=relaxed/simple;
	bh=YGkaCSIwUtNCIq4l36noSRM+d+hvirPqxnXxXk8OkyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9zLfbru2TJRI3M6vfo58FZFc1moAaedpaxxhNTPk6vHFCScChnevFSFrXilYo5+2P966NsgNDfRd1fJvuX1mKkL0MnRO6PzOVe06wzvGAyjXjsj/I9r2b2M84WgmyOz6VEvg8NEywDuvkgZjejN/Ga2P9QK/Y12m5poj393B+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=H5TSsFt1; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BOtFLE0G; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hp3hrc5Q reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426KULgk012426;
	Wed, 6 Mar 2024 18:02:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=YGkaCSIwUtNCIq4l36noSRM+d+hvirPqxnXxXk8OkyQ=; b=
	H5TSsFt18+IwNRWCz2WNyMfZBYndQkZkrbRuT8FY9kV6zAu8X93LbQ4LP7bh3wNO
	rLpxtHWABUfBqsLTwmDZrmebP+EDGSL2uEpwpVRwhpPdDg1icU/igq2m/Am6r2w/
	ekUNIiMD/Y+nVxB9o5e1MT+VsRIxoz2Aul8PIdjKky+uZuh1V3g5xk8wiOaZovZ1
	UJVwP5Y7ZfdjuVsky99UfbZcjhXM2e539VbYCIwDkGwdmqrXm0N2uK4bnJeqDunx
	o3lXGW/mkl69sxgVTGCzwRFl5nYyZbbHiC5y6btcDW1BocFvAFXlrMq0uQx5KcWY
	h+yOATMuJU5GLMGpZKfqzQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wm3mhm3aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 18:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709776920; bh=YGkaCSIwUtNCIq4l36noSRM+d+hvirPqxnXxXk8OkyQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BOtFLE0GpzZSmXCUMzI1yztPKmD3sV2XAmETOBKYraKaRduU1WzDOV0Bvy+HkVhFt
	 /gdvta34GijvLjUi5LyhmHYqLg/MOHCg6DJhnAUOikK8KZ/Cu40XhMOr3gPvMKgdIz
	 oZZ+TLILWuWSi0/zmKXTvSCor+r7YbZcghmArw+u416oKtyQjR/suGjNzCtGsPES0r
	 SKt1E9Si2dpeAjvXn3xa/xow1q0xKLcAHxm8EFCQIDAjG/RuklEBSFfpzDT9hYb8fi
	 +yjnt/1SZ+vHGGNXuDry2r2zzAf8wmnJmrX/dM8gk7YzdiDcfjd90rwsu8js5cD0tY
	 4p8+KXWusSgtw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 30CF140346;
	Thu,  7 Mar 2024 02:02:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D3676A006D;
	Thu,  7 Mar 2024 02:01:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hp3hrc5Q;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5CD17401CF;
	Thu,  7 Mar 2024 02:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJoeBZU/dbDeL6RbA4zPBGGLvznSpmndDKsw61PCTbrBfeLu8bNxVW0n3osMHMPfPgHUAIkOxQweACuBal1W7A9sPZPZ5wkBp0PrTP+JKNq4945pujNSdiObj2wvjrZfUD2IiJbfL4tPIs8O9zsAHzg9DQcJ3G5IkeG503f9kqPTMxwazPbih3Hmha4e65h0yxeKcL4gXyrfqnKdHX9jvxUMHFMC6pYP+ivhxqc03DDdn9SSbXtIq+BSDceoWn9j7FZMZUqtUxJiZBPF9lANH2KSlYL/PD2KqYGd8UHVtnd4pGNpedaorsZWcIkqfv6g9Kvx5kvBfP2S1//vT58wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGkaCSIwUtNCIq4l36noSRM+d+hvirPqxnXxXk8OkyQ=;
 b=ZemVpcLIH+mWdL4083CGIbVO4RxlwcbkCrM34e5AxCs9IG7dhIIO6rrtNXQvXCK+VoFdLnYdjUZUTYsfgnyJROWMcR6NsKuH5Zj30ufZVqjJEd8d4rgP3RC8qpNs6emZDPlL2CfaiAzIXvvPAhKFVDk6klKmyB7N6LOpyo2WWAbC6mFEzjhWKmKn8heQPTNyWo/yGHvDqGWsFpbgKxOZ5YlFK7daed/hn4MRae2059BlCHGssTAgiboaTpwlzqOblkDg7WTbb7Hs5J/XwysqK/Q+K/js8qPDXItuyJG4UkHPzM5dY9D5JZzLzDMPTISXlOLlNk1r4vL3b6TZ3HRAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGkaCSIwUtNCIq4l36noSRM+d+hvirPqxnXxXk8OkyQ=;
 b=hp3hrc5QJ+hIriyqFDTdMMt551u4fA3haSrYVv3vayIFptezRMU00uySeW2Pq9Zby9PPf364HEN18mm8NUD6MEA1O9K4wAjpb2aauzaX9P3Fm7WFkImfTH+dg49X40Ll3/J10kRS7r5FY2qGJw9tDZnZqe9VZIS2n4Hl8cw2XKI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:01:57 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 02:01:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: Add DWC31 version 2.00a controller
Thread-Topic: [PATCH] usb: dwc3: core: Add DWC31 version 2.00a controller
Thread-Index: AQHabCB8j9XA8SIM9Ue/hNFi3xoLGrEja1oAgAARaYCACBHVgA==
Date: Thu, 7 Mar 2024 02:01:57 +0000
Message-ID: <20240307020153.ll37lvuy7ftxnohx@synopsys.com>
References: <20240301213554.7850-1-quic_wcheng@quicinc.com>
 <2024030121-unfold-murky-aae1@gregkh>
 <44f00418-b09b-5ee5-c70c-d4580ffd0049@quicinc.com>
In-Reply-To: <44f00418-b09b-5ee5-c70c-d4580ffd0049@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB6069:EE_
x-ms-office365-filtering-correlation-id: 4515fa10-761a-407f-176c-08dc3e4a9196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AsmNqkOBDJ3387sFqEdJflRjD23c0pOyhZo1icpk9U7MEBd6fyvAFazMvIa4H2jjzLNxOGaWiC3Ztm1cZwoeRBGBKmKTJVtwXSRzfSwIrB9bors/j4+jYhgzOqgV44CrkgkjwAu4CIeaft7X5g4kT8gOUwe4rQj1j5E09LCBO85Arbwrl5G2t0DN0GRjLEIq+ARs+Zw2ZfyJWhV9UVpIZ4dlUQHzGbphrQysnTjdUGpfSSF3gv/qUv0cuOzxfvOlnfGNGZz0ZT9bSNnvttHWFOYCR8adA0DTqFwv4Si/KU/W5c9/S4bpFy+t0QRFiD3fNjfGfe3sLdSRk5ySwkDxzxQdBeVjpVmLwhtXaPZUfmQAMnnA/9on1kiMNcS05nJbaKT7Ylttrdp/nGAcSiHwcAvwmsKXiPxS+OgEfplaPY7E7ess3Qv3IOlQXTH2U+LRJdmzULI0Ft0cz/2BbZfeBkZFTgIhT705CxzxEE/PcWcYQYDn8nw+3Xd11a4kY4WN2uy4TI4v5ifAXdYBN2vuIbz7CBG4RpsztvEWEiUnyhAoKNW9bD3GX3+z7s2x+SuTpjC35ohsEejjSEzRWqWxm6fmwBimGRwijRpTZZS5f8AYa0HyUACK5R7q0CmROWr7EOCOsrhfMA7VIuyLtBlfk779OAEAswywzTRvhDzNctNwP+nQHgIiJyUGgCP2vNa8nfUK+rurs2dVtLs7FglcASc1CG9Gx9GylaTpVbsEPwU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c2FsOVpCTW1FTFNLTkRUNi9IWlREZGlGSDhyZWVvRWxuYldPNDRWNFQvSjZ6?=
 =?utf-8?B?cnZ6ajFwTnJoNjJ6SUlBbkNHc1REZDVjY3hhWHJnYUJJMVgrS0VMSytGN082?=
 =?utf-8?B?RElGRElaL05RS25ub2d5dUIvQWRKbVFSdDJ0d2xzWVVJK050dlVlMm11TlhT?=
 =?utf-8?B?Vm1RS1hHOU1GR3QwV2MwajdmTm53WGpydjdCY2Jta2laVEw3QlU4YURnYjJ0?=
 =?utf-8?B?eEhnWGJWNC9sZmpKc3hNQVRITzhRU2pwVVQ5eFo1NlQzRXZ6NFg2OGRwL1Zu?=
 =?utf-8?B?b290M2UvY2dLd1VQazVmQ2pRM0ZZSVdRaUxmb2QydW9ST21CY2ZHRU1nUWRO?=
 =?utf-8?B?czYyME1TV3R2MTJ4M25SdERmWU1HMjVWNnkva3VaQWNWWTU1VVVaYXQrTkxX?=
 =?utf-8?B?alFvMlc5cTg1Q3ZzTkwwL3dNRlQ2Ullzd0g2c1dOYjBWVU9zUWtSbWhKLzUv?=
 =?utf-8?B?RnRtWmk3Q3VmdW5lTEc2bktqTnF4Y21jU3kybENyYlEyWmdBMlJFQnY4NkpX?=
 =?utf-8?B?VzNkWmM5ZDhrS0lFTnN1YmkydmpKZTEzOHVYeTc4M25XZURnMnEvaEJHM3ND?=
 =?utf-8?B?Z1hGeFg1TEFoNzJYYmpoRW8ybXBvSGR5NDBLZUZDMUN6QkV3REtwVkZvYTBH?=
 =?utf-8?B?eFlDSklPNGtJUElQbnNmNUZwL2hsSHdUL2lYMWxYalZQSE5WZjhuTDRHbENs?=
 =?utf-8?B?d1hUeWtlVE1GZ1NxSE5yZFlpVkQ5TkcvNEtBemprTDh3WVUrRlhKWGFoWXU2?=
 =?utf-8?B?NWJCdnJuUXo3MWhpWDFVRUlzNmR2K1JVQnhIb0NReVBZd2ZacjFueXRoc3h2?=
 =?utf-8?B?Mnh3VndSbnRteVdUMHBFL2MxV0ZRTk1FazFNY3R6dm5PSFZhL283RVhmQ3Zj?=
 =?utf-8?B?WE51QWdhZlJvTXFmYnVySkc5K0lMWTJ1Tjg3N0JyZkxGOXFiVnZ5TFZyaVVv?=
 =?utf-8?B?cVF4bitjdS9qdWlKYWxPQ2lHdzUwRzhVYkNUYWFQWXB6YjA2U01nbUhvQXRr?=
 =?utf-8?B?ZGJrRmdtYVA4TWg2a05vTEY5Rm4vR1ZMLzRXczg2U2xDZllNQXYvZ1hZWnM0?=
 =?utf-8?B?c21TYmM4SmZmYitmSzVUODkwazE0ZEkwSlZ1bGxaZktMZDhhQ1VQcHdGU0Z1?=
 =?utf-8?B?SThiUENGU0NKTGdKWVI0Q3RPVFBtYmR2eUg5S0xoMEtIUDlnUFNXU1lqcElp?=
 =?utf-8?B?UlZ3MHloZVNsdW1zWkJZaWRVcjI5Q1NQYSthT0h5T2xMZzJMbjhJWDFvSlFR?=
 =?utf-8?B?d1JSZmt4Q2lodTI4VWN0SHlVSnljZXVSZlhrQjUzdEVrNHNZZkJVNmQ5SEhD?=
 =?utf-8?B?QTFsalJBaTBYR1ZLbk1KNXc0My92N05WaDhIM1V0ejJ3ZEZ6bmtlYjJaV1RS?=
 =?utf-8?B?bG5IRThVVzBtNzZMSEQwZFN4RWorVHRST0dGdjRlM3U0bmxNYmppZmtFaSt2?=
 =?utf-8?B?NW5UVW02dHI5OGx6WW1JM0owRWEvSTJDaEhIRUpaaWRZNFVYd0V6S2pxdSti?=
 =?utf-8?B?ckpiQ3I2MVJJRWQweVhZdWtDOEZCckRIZXdXS1BneEhWZXBYNGtqSmFoaHZv?=
 =?utf-8?B?M1N1Rjgrbit2NnhKZ3ZqWHlQRGFJVmJtbDJDMFMzSnBHMjVWMEJ4Mmx4UW9S?=
 =?utf-8?B?ZEF5aFpWOFR1MTRtOHR6UHdQbFU1cDB6Wkk4RjlFZDdWcVo5bTYyMVhsUGdI?=
 =?utf-8?B?QjVuZk5veWNIbS9GSWtVbzloYkJjbE5XY29nV1o5Rm1DQUlRVVRVNGJQcFNn?=
 =?utf-8?B?Rjk2bXNYbGdOcUx3RVA2RWg4aXVwNHVUK3Z2dGY4TFNVejNaL0MxTjlJNTVt?=
 =?utf-8?B?TTloOUF1YWpRdkFKSHlwWWZVWmF2MWIvdmtiWEI1bDlrVGdtcTFyNnBoNnM0?=
 =?utf-8?B?dERMVEVIVHlNcVRra2NqL2xwMEtsUXRBeW42THNHNlkzNi8yMUYvejBoWWZm?=
 =?utf-8?B?Zm1sYXZwV0gzQVdBUFFOZGxPcE9JT3EzR1V4KzZ5TE1wbnV6dXpzbUJYcmVn?=
 =?utf-8?B?VDlFZjRNRWRTMWlaUHd3M0YvLzZSRFRMY2xLRnc4cVNPd1BvNXN5dmEvZjNV?=
 =?utf-8?B?NEdCSndlNEZvcm1VZFdqRzJ1V0d5N3FSdXJDaUhndHcvNHZ6Z2lZeXFWVHJu?=
 =?utf-8?Q?hOVlOXZ06mgVxFFiNpXg6CYbp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <695F0E4ABA0F7749B6DF3DB515088B05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3ym722Xtg9QCJD7acKi7lkG1GbpmSSeOGk+1d/obryNAtbnVgVJsuoQbB/3MfbFez+9GzQ0d9X4/NeY+oSyMrrts5diAq31xVbp6dnVBUIGtx+u3+Kaw6+gAvflsX2MuGTXz6qcOOEzRdaO152nL02DuTQibtZYfu2CIo4qe6okq+rIztsiCcYdLcZlirO1Zgjc74tVMaVRSXFReMqbc9ftKyx7g/THXX+aMdokVdMQgTh3OUHSVo9VkxT2d8OWIEC3jXduzsrul/8dbK/mHpOFmNhjK3JCGxkbNUIMehQkQXmxrhqSA0WavrmFYE8mw7uSJ08G2jfLzv0hF/n9p++mfd+BjMyUeGVg48iFPRzbi74OtEhtryGWoGrP2YruAL9olt1HHQDE0FnXCXbRGrQw9MPT/R7hRtXtc7/05MNnaiOKluodpkRRKZyCdSfaFGuVy/k+y8EMOrc8F24NN228pYMRRQRV/SV+3ViLZBa07MiW2Plt/MFze7tHBk5Q3gF1QsVlzk1SoNrTDofUMmHFOGdXUe+FOxaYQmD2IXoktNWD4jZDEZKIwXv5UTLeOMOoQ1llaQ4p2SqkcZLP4OOeM0BBK4cczdS2faC3Ww6aoVFg1XAyLR706OnqOQmp+4vHJYUXWTPIj7pZXkQrJBw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4515fa10-761a-407f-176c-08dc3e4a9196
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:01:57.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LY6dNPeHHcGJAkpzb22Di8T9gNquW689qsqiMB9wOG15GelgiAsbLL1HoYqc3Vu0/wFgFR5TTCfK4j4WBqAkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Proofpoint-ORIG-GUID: umN0sOK5ZNz69ETsSMppIVxj9eqhErT8
X-Proofpoint-GUID: umN0sOK5ZNz69ETsSMppIVxj9eqhErT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070013

T24gRnJpLCBNYXIgMDEsIDIwMjQsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgR3JlZywNCj4g
DQo+IE9uIDMvMS8yMDI0IDE6NDUgUE0sIEdyZWcgS0ggd3JvdGU6DQo+ID4gT24gRnJpLCBNYXIg
MDEsIDIwMjQgYXQgMDE6MzU6NTRQTSAtMDgwMCwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPiA+ID4g
QWRkIHJldmlzaW9uIHZhbHVlIGZvciBpZGVudGlmeWluZyBEV0MzMSB2ZXJzaW9uIDIuMDBhIGJh
c2VkIGNvbnRyb2xsZXJzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hl
bmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIHwgMSArDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4gaW5kZXggZGY1NDRlYzczMGQyLi5mM2Ji
YmMxOTQ3YmQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+
ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+IEBAIC0xMjU5LDYgKzEyNTks
NyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ID4gPiAgICNkZWZpbmUgRFdDMzFfUkVWSVNJT05fMTcwQQkw
eDMxMzczMDJhDQo+ID4gPiAgICNkZWZpbmUgRFdDMzFfUkVWSVNJT05fMTgwQQkweDMxMzgzMDJh
DQo+ID4gPiAgICNkZWZpbmUgRFdDMzFfUkVWSVNJT05fMTkwQQkweDMxMzkzMDJhDQo+ID4gPiAr
I2RlZmluZSBEV0MzMV9SRVZJU0lPTl8yMDBBCTB4MzIzMDMwMmENCj4gPiANCj4gPiBXaGF0IGNv
ZGUgdXNlcyB0aGlzIGRlZmluZT8NCj4gPiANCj4gDQo+IERvbid0IHRoaW5rIHRoZXJlIGlzIGFu
eXRoaW5nIHdpdGhpbiB0aGUgRFdDMyBjb3JlIHRoYXQgd291bGQgYmUgZGlmZmVyZW50DQo+IHNw
ZWNpZmljYWxseSBmb3IgMi4wMGEgdmVyc3VzIHByZXZpb3VzIHJldmlzaW9ucy4gKHNvIGZhcikN
Cj4gDQo+ID4gV2h5IGFkZCBhIGRlZmluZSB0aGF0IGlzIG5vdCB1c2VkPw0KPiA+IA0KPiANCj4g
VGhlcmUgaXMgYSBydW5uaW5nIGxpc3Qgb2YgYWxsIHRoZSBEV0MzIHJldmlzaW9ucy4gIE5vdCBh
bGwgb2YgdGhlbSBhcmUNCj4gYmVpbmcgdXNlZCwgc28gbXkgdW5kZXJzdGFuZGluZyB3YXMgdGhh
dCB3ZSdyZSBqdXN0IGtlZXBpbmcgdHJhY2sgb2YgYWxsDQo+IHBvc3NpYmxlIHZlcnNpb24gdmFs
dWVzIHRoYXQgY2FuIGJlIHJlYWQgZnJvbSB0aGUgRFdDMyB2ZXJzaW9uIEhXIHJlZ2lzdGVyLg0K
PiBJZiB0aGlzIGlzIHRoZSBub3QgdGhlIGNhc2UsIG1heWJlIHdlIGNhbiBqdXN0IGxlYXZlIHRo
aXMgb3V0IHVudGlsIHdlIGZpbmQNCj4gYSBuZWVkIHRvIGFkZCBpdC4NCj4gDQoNCkdyZWcgYWxy
ZWFkeSBwaWNrZWQgdGhpcyB1cCwgc28gaXQncyBmaW5lLiBCdXQgSSB3b3VsZCBwcmVmZXIgdG8g
b25seQ0KZGVmaW5lIG5ldyBtYWNyb3Mgd2hlbiB0aGV5IGFyZSBuZWVkZWQuIFRoZXJlIGFyZSBh
IGxvdCBvZiB2ZXJzaW9ucyBhbmQNCmNvbmZpZ3VyYXRpb25zIHdlIGRvbid0IGxpc3QgaW4gZHdj
My4NCg0KVGhhbmtzLA0KVGhpbmg=

