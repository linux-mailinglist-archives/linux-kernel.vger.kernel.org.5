Return-Path: <linux-kernel+bounces-79297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3794C86207D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B55D1C218E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646D14D43B;
	Fri, 23 Feb 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U5A5G0OG";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Si7LrQ92";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wl6IKaeU"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB9604D0;
	Fri, 23 Feb 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729695; cv=fail; b=u1ld5N8p1VI7Dy51rYdB7XPIpZrcQlzE4Llja8/6YltOWMyDAdZbfvvGKOf0SqTHL2/rn/IDKLu/uzH35z/1Fii0bt2IguOJGYzVp4GiNBlseKSiWDE5COxztgsalwpbTWlUpL0CcqnAcb5einsV0cjccPSFH045Zjnb01tcCJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729695; c=relaxed/simple;
	bh=zjEpQZs5nmcwFn4NsV/4FpFxNDmwRhhe2XABs16p/js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FsS63HaQ/DJlM7LoA9li5K+3cjy4GDZtuJU6FRtSEFjxqBFHO3zrexdpAnQuNFf6yKHnl6dh9ixupN8sAx59FgYH6gk2ZLsfdgZinh6C2NP0VMEluXEkxSlU904uoBuvSSJGJl/S2TopFTHfPnxt6RjSXs8dYzzKz4K2vPuwuX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U5A5G0OG; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Si7LrQ92; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wl6IKaeU reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NMh2Ph004345;
	Fri, 23 Feb 2024 15:08:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=zjEpQZs5nmcwFn4NsV/4FpFxNDmwRhhe2XABs16p/js=; b=
	U5A5G0OGoeEnSZub3eXCDyVq4USqAtWyk/nFltMj/dR5ShRPKFv0iyhQXEap5Uwj
	VjAbNdg74Oi+gpYfkWZZLlvcvjt8+0qH7Ilqc+2fd7ZijyjCeDEIp4eG5U1HM/1r
	u6FcvspL0h3WjkpnzxAiPnGlQok+WgZnCrQp+ydFGRnHfLREuZL+t3RnJTodPcLg
	FvC4PsOwaKLLUY5xjFno4u+Hs0Zjh2WiTw/yym7+W1vB3nP7YDsZA2qPnyboseKr
	gFXw+QMommrBgjh7RwG16phRq1WGY+16qqrf3N+zX03oaYKZigT6sli0vW41EvoR
	VpREMT6BitoAp9uOZm74Dw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wd228958a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708729685; bh=zjEpQZs5nmcwFn4NsV/4FpFxNDmwRhhe2XABs16p/js=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Si7LrQ92ZPBS+aKwjzUmvBQrxKyTeTFI15pzWn0pxWbIAp+OmplyJHi4yqkuKqVZG
	 haov6MLWm73JnFb36YSj13Ub1wC4cFC0ow1FBihukA3mQfGOO4IMvaMKGS1Zc07o+S
	 nJBSNT3d02wcXOLa2/H8utLucnmkTzEMQ6JPHJ0BjhacWYn4P6WVC73Xm0hIG324xq
	 e5e/a81oqAS7PGz/h2mYxWYI4FAlEsL0tNWXsolniMiDs9ud3npqsgr5TdaoI+cDxf
	 SgdbcqnhR1rdp8jR8bjzNTqR+n59SzvZfc9HzmTm+lLIIQlsDXszoBl5SCU/2UVCTV
	 4HViDT0CTuUMA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 059204035A;
	Fri, 23 Feb 2024 23:08:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AA63CA0077;
	Fri, 23 Feb 2024 23:08:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wl6IKaeU;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5F57340235;
	Fri, 23 Feb 2024 23:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFi1spyTaOzS9Aww+lAqVqOdl5SkwHHJjZEwyJ0Edy3Ds10kf5jwlRdLFoT3Q7YUt3kDSxzmGpmBXXHwg9djAx/5IFCR+P06ERyIR9kPRHbgrHYr6WQdeDvUea99RCYDFIV2PX0vfN4LPGzPlK+5gZI4T9Kl1PY78a8GFS3KgyPRszOE27bHy7PqDUjmQ0wuVk1yCGaTWs57+sGbo3VftMi6lXSRg6Q6oCWAHDMm5xQiwhvPwlQURU2MniOSQojRG7cNzSicnNReWueKrMLb0ShYktFmrjnSQt/ZJUM4lKpc4PGwYthkL9hpjML23JzSRK0TTjH+rxD9JBJBHwpLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjEpQZs5nmcwFn4NsV/4FpFxNDmwRhhe2XABs16p/js=;
 b=SXYqoj13Rj5EA0kDRVswrc46jGjA1MseTQYiEA2tVIv9QxCL1zjx3DLDV3/q6Q7Inyas7bIdr0wFdgOuUHOv7m2muP4yf2YtCt5d6KvMwpLwMhLVl63bwgQ40D9OOGvy0BM3f6WF2ChuJgn13nAKysQhTRo83JaMtMphU4Z/ckeZsEFvgc6Q0COoNpvk/VhHTSESvpnVuTgCG/vEETILU7Vdgztp0yVwg3y4qshwzBGqFuTUA/CGRgLV5qnjUgRigGa7pc0aLz4GmVSDwzwSF6VsAthFZP9I2EJCNJrPOYh1xxE1cQ7zR4ZReeK1TEgYqN7qA9rfuBobIWcRe9jxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjEpQZs5nmcwFn4NsV/4FpFxNDmwRhhe2XABs16p/js=;
 b=wl6IKaeU9AIkWVWM7UO1hRkP6Mny/2lj1gUlnLHIjqnyC6l2NLkfu3uL+uUHoBSHZ1a19rnCoJgiHLbzTa0O0QU6PRvvPHNto43Y5hXj2zJCin4zMksjdiAPweTK/sqTLzqaUK6MUz7bD+ztFTtwAnS1oytBv9YK7S4hEE0TW80=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 23:08:00 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 23:07:59 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com"
	<git@amd.com>
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: AQHaZpDfVUYctKsozU2uHIlcC3QiPbEYiAkAgAAFHQA=
Date: Fri, 23 Feb 2024 23:07:59 +0000
Message-ID: <20240223230758.s7rodlxbsfa44frw@synopsys.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
In-Reply-To: <20240223224940.y34qflo2azxrvksy@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4306:EE_
x-ms-office365-filtering-correlation-id: db6ebb04-0765-42bd-7f08-08dc34c44795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xxSvw1Oxyc3aZ1wUBN5MK008cl2QGQHwHfQathsooFk2+l8upw9XRhJWgDtIlX2PMSoaK4YRuW81OiLB5WY/XcLzmRNDyh1ovb/a3iCC6FAefS4KKjZdxmf1TOCMEo8JQ3J8LYpR5fyFRNno+CxGzuAdYdzXiKxTPcGhHmwKQbgmMEYebyoY9JiBi0utvERqIGay810mH/pT36GpBWwtcKNQZjl7IYYQ8m0T6ZpqwkZw3aeRLAhPVF7LxqUV1h8ZGb89HVBIzDGVJcWDTm56wTHVl6z1RWyz/wenBFt2vlyf6oTtGvIGw6ORv5r5B/vmiCo/nb2QdFOoReKy04C7m5kDsEONJnvyHM9xu1lVxoupjaNnwvcXLyG8CC+fR1NTLhkCMIQfE2QZrwqHTfeETxm1fXR3JqZ2wpHJpd1tO6oC42bjK0ylo0gzKFWWANn+Cd/iUgPD74EYvaQiplt5d/r3fALf4TUAs7PpZVIgEuE1bl+mb/OfwKuzSvoRdf77E9FN/P2TKICJKwcJIvRgg2axKPNihIBb/lN3o7PlhNaYSTumRs35MsqLfAN6FVRlCl9+NuqBadUQBFRffARsHFyTmVxZwqztsbyUUzsmdlE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WWh6N2FtYk1HQVZza2dpL2M2S1B2NHpzbUxsTXRXUHZQRm9pa1ZKNDNRcStn?=
 =?utf-8?B?ZFRGM1BIN0V5ZUVoTkY4Rm90U0lBOCtYQjJieWFqdW1TWDZ2L1V6V3FGbG9G?=
 =?utf-8?B?UGdzWnBjaWthT0tOZHpadjJKWjN1YklEUFRGb0xJcmxocnJCZERXbHl2RGtM?=
 =?utf-8?B?TEV5dzU1NDVtaTZoTGhyODhtZ2Rybkw5RTJEeUdxQjNVcEYxNkhYbllJaWpT?=
 =?utf-8?B?aDd1aWFEWUU1WVJTQnN4eEo3eStTSGpJRWtibDVIZDFHUkNVdDhVV0FOdGlC?=
 =?utf-8?B?VTlqQUpCV0VwclRVWnJUREhBRS96ODF6OUlPcSsrMkxxdVVEM2JWZ2QzcFB1?=
 =?utf-8?B?K0Nvd09MYkMzSUJZVnhVbk8vS3d2VWtDQVk1NThmdHRzdFkvcjNFRVZWalpn?=
 =?utf-8?B?MXhZTFRnZkNNNEFOYlVscG5ic242bWNKN2NGOFUrd0FrbHlTSm5rZ0RQS1gw?=
 =?utf-8?B?VVhtanZEdGFyODV3Y2hVeXVDWlNjT2EyUWo1UHhkWHFxeHlWNkJYS2ZYam9E?=
 =?utf-8?B?RzA1ZCtnRm84Y2dScWhKUTJFYThkYThTdVg1V2xtS3pvWUxxWXFEelpMTUpr?=
 =?utf-8?B?Z0pMUjd4YWpiL0VockxQV3g3R0xPUFhzNlA5V1Y5VmFiSUprWExzdEtTcDlx?=
 =?utf-8?B?N2xWdzl6bjcwQXRPNWplYy9NdlQxOWZoL3JRVUNlQWc5SzdHUzY0VUNzOXha?=
 =?utf-8?B?TjhUN0hpcWZyTXh4eEZNdzdEU2l0Wm4zeURBREVwRlhkclIwaGJNNW10UFZr?=
 =?utf-8?B?RlNCVitIME5lSDlheTJiWXBZTGI3SU1JZjhSVEFvbkhFNTRpcGM4QWtQbDFH?=
 =?utf-8?B?ZFJjdWlPeU9kWjdKOTR6WTNGTitGVklXTHp6ZVYvNS9DZlpETFhhNVl2UzFa?=
 =?utf-8?B?V01abDQzbEJtcE5ST2pyUUZzV3Z3c3BYMGVZa2h5dGxXRnY4RytiS0RqU3pm?=
 =?utf-8?B?Z2VSNlZZQjhzQ1VHaWNyOVp3aDU4eURzaGtNeGZFcjFKT1pHWk9qMVRqbFZV?=
 =?utf-8?B?TTlVOWtBNDVndXlPSUNVOUsyMmp2SEltTWJCN2hUWXZHQ1pqU1lsZy9KaEZK?=
 =?utf-8?B?NVc3OERTVnpSUU02c0JjWEg2NG91cUpjOVpZeEMvMndWT3FXZ2RPMmN3VC9J?=
 =?utf-8?B?TmdxOEc2Y2FmWE1oZjRzTkdXQzM5NE9pdjFpZjJRVkRBWURCc0dnNVp0Z2Rv?=
 =?utf-8?B?NVErQTlTd3dCS2cyMUN3M01vQ2lHQjZ0djRLOXdVKzR2Q09vMGxtS0QrUmc3?=
 =?utf-8?B?YldTMkN3a0s5SlVNeit2QUszLzlCOWJualBjeDRxVG8vVXphUjVCTzhDRm1z?=
 =?utf-8?B?TU5rUVV0QnJ5WERmQjhCaWQ5NkdBOWxMZWpOMVZIRGk2blBPeXlZMGoxRW9q?=
 =?utf-8?B?aEtyU0d0TGVSWDlXQWZQV2NTRG80QVBTMW8vY040SmxpZ28yL1JEdFAvenlS?=
 =?utf-8?B?RDhBLzdkUDVhSWNDTjkzVmJxTjZtdCtkUU1GRTVlTXRmRG0reVc2a2IwU3lR?=
 =?utf-8?B?YzRzNmkrTUZsa1AwRnhiU0JpbEpIMGdkeXhmS1ZIcjNnaEdhbWRnWmFtczRL?=
 =?utf-8?B?WnBqeHhFKzhQd2tVMnA3WXhKUncxcXVKOWZFR09YK0NiWklPUDF3NUM3UjhT?=
 =?utf-8?B?dE1qSmNrNjZYaEFJOUZicjVidXdnMkEvbnJlYnRla1ZoN1hnR0pVLzJ1bHN4?=
 =?utf-8?B?cU9IK3Y0a2JqUkw0YjhOeDNCa2hTczJkcnYvWGQ5THBwbmJrMVM4d0lMa3dJ?=
 =?utf-8?B?VG1QUXlQSE9xS3FYdEV2QmNDSTM3dUNHMWUzTjM0ZUUzaXQzbVVmUy9pV0Ex?=
 =?utf-8?B?WXdISVdtczVGWUJQTzBiR3B5MzVFdnI0aFhidU9tNU1xTGE3Uk5qcnptOWc0?=
 =?utf-8?B?RFgwbSs3cHRtdnJVKzNQbVVLUUF0eXFLNnlEQk1DRE1USStYNXFjUW15Rnp5?=
 =?utf-8?B?K1d1aGxjVzNnMmVoZ1VReXRack8rMmwzSzVmWUsrbFRMMEtwWUY1V2ZUdkJF?=
 =?utf-8?B?S0RhQ09XdDhSM2phNzNzcWlRcS9VeW9mNWhDNDJHSUpyQk5PVWRyOXlhS0ZH?=
 =?utf-8?B?bnJCOTZEV2pSZ1lCM2p0a3RpMlBvNVlFRmNvRGN3SVBBZURKWlpXZUI3QkFv?=
 =?utf-8?B?elJRRkhBRTVrM1F3dmlCb0VjUmhEQmlUbkFOTXFiUFVSbzZhWWJ5U0lXRUp4?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B88A186843A9845AFB3589FD19D48A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BLDTXoeOljZi6rj58memyHX+AQ0+hH38f/ETmgx/zVOvDSLxKNk5mvTsk2Kf+QDgpivk6zpcZv6+NhvOLJwbdEGzRuE6m2McBXw5BkVTSTqWO689HpWwHv0dkl6wQsq7XMkBxkdC4/ud0R6OD904uctfbdi6ZMLMMRCpL3JquIRRUSZzVymzZghn9lro1xr5H6o3bErfthpetZpjfTMvp2bM5hCElvB3RUfpymYsrC+PPEbicW4io3+m6jByuLZEHr0L6UUuwMAVfr7r0npyd6JTGaTivNwTiAsCJBTJNYMek+U/sBRa0GiMnS80oGB+E8T13MEQ60kf7AaQxQmWZr2Q6ADN72/i0Mq+Vi6QMF5jwbLwHL6juOZt6KrVA3/1N52qJCF/c0+qkA7D+oamSXb/MhYFJYg5WxLXulV9s9ILWdAmWo0PLaa4VTLRDLblFcZY1ILFc+fP2s3tIasMI2mkDulldlzEdDiWbmzIYcFsHV8FVVjU8XDbpcOeQXInSwdaJKPsxJ2puYCpjluwwbSiwVLmSBs5Sj6ZLjxF2elmTJGOYoUTQD2fIL6/WU7DlDztUKmaLLL7OMjt4tDjwD2SnNsLNrAXoAF2nGtYuhjewqH/MxFLDdsZQXKsDQKFaa4xzYWRVyQ15c071YhyPg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6ebb04-0765-42bd-7f08-08dc34c44795
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 23:07:59.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eh1bnDisiE7ivea0GKFNOEyV11ocNTQQukoFxirmjtxTtZrYcrA71+25ts4RHXb9NK1aIhAtF0Z3xw30zSisYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-Proofpoint-GUID: 64xABTufgTo0gHCuVqhlgrXXaDEI3-Wz
X-Proofpoint-ORIG-GUID: 64xABTufgTo0gHCuVqhlgrXXaDEI3-Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=950 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230165

T24gRnJpLCBGZWIgMjMsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gU2F0LCBGZWIg
MjQsIDIwMjQsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+ID4gRnJvbTogUGl5dXNoIE1l
aHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiANCj4gPiBUaGUgR1NCVVNDRkcwIHJlZ2lz
dGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1cmUgdGhlIGNhY2hlIHR5cGUNCj4g
PiBzZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQgZGF0YSB3cml0ZS9yZWFkIHRyYW5zZmVy
cyAoQ2FjaGVhYmxlLA0KPiA+IEJ1ZmZlcmFibGUvIFBvc3RlZCkuIFdoZW4gQ0NJIGlzIGVuYWJs
ZWQgaW4gdGhlIGRlc2lnbiwgRFdDMyBjb3JlIEdTQlVTQ0ZHMA0KPiA+IGNhY2hlIGJpdHMgbXVz
dCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJIGVuYWJsZWQgdHJhbnNmZXJzIGluIFVTQi4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5w
YW5kZXlAYW1kLmNvbT4NCj4gPiAtLS0tDQo+ID4gY2hhbmdlcyBmb3IgdjI6DQo+ID4gTWFrZSBH
U0JVU0NGRzAgY29uZmlndXJhdGlvbiBzcGVjaWZpYyB0byBBTUQteGlsaW54IHBsYXRmb3JtLg0K
PiA+IFRha2VuIHJlZmVyZW5jZSBmcm9tIGV4aXN0aW5nIGNvbW1pdCBlYzVlYjQzODEzYTQgKCJ1
c2I6IGR3YzM6IGNvcmU6DQo+ID4gYWRkIHN1cHBvcnQgZm9yIHJlYWx0ZWsgU29DcyBjdXN0b20n
cyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcyIpDQoNClJlZ2FyZGluZyB0aGF0IGNoYW5n
ZSBmcm9tIFJlYWx0ZWssIGl0J3MgYSBzcGVjaWFsIGNhc2UuIEkgd2FudCB0byBhdm9pZA0KZG9p
bmcgcGxhdGZvcm0gc3BlY2lmaWMgY2hlY2tzIGluIHRoZSBjb3JlLmMgaWYgcG9zc2libGUuIEV2
ZW50dWFsbHksIEkNCndhbnQgdG8gbW92ZSB0aGF0IGxvZ2ljIGZyb20gUmVhbHRlayB0byBpdHMg
Z2x1ZSBkcml2ZXIuDQoNCkJSLA0KVGhpbmgNCg0KPiA+IA0KPiA+IHYxIGxpbms6DQo+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIz
MTAxMzA1MzQ0OC4xMTA1Ni0xLXBpeXVzaC5tZWh0YUBhbWQuY29tX187ISFBNEYyUjlHX3BnIWZm
QURsTkptUnlDYjFDMkIwejIxLThBYkpFNFlEeWlYTnhLQktCcW1obUJPU1NaQm9rSFNfcXlldEdF
cWI3Q3dhd2UwV3ZiejJhcVNael9iVGZ2UzBjWGR3WExWV3ckIA0KPiANCj4gUGxlYXNlIGNoZWNr
IHRoZSBjb21tZW50IGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtdXNiLzIwMjQwMjIzMjI0NzQ0LnZwdHZma3F6Z3F2MjRwdHpAc3lub3Bz
eXMuY29tL1QvI3QNCj4g

