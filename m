Return-Path: <linux-kernel+bounces-136040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28089CF46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E6283A03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44F10E6;
	Tue,  9 Apr 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D6LoIiJU";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WmqpgApb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hpf6Apkh"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278719A;
	Tue,  9 Apr 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622050; cv=fail; b=rlULKm6ZWUS32+7j8KJD4SuxRqXHfdEmjOhyKxY4IMNe/c2MxAfYxYILvcZI4f0ogsCdE7vyuXTIpl0TO+nr/O22eGfWJE6WjO0sulyA8DNXJwnq50z7Md3F+V77kXLE5GwsQl813lm1DxWXwFCFLnxyn6L4GmKRvly0EJBfrCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622050; c=relaxed/simple;
	bh=91WrhWHWQt0kCb8CJ8PAOeIa7mmFnaQNrZC2/ngLJhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rav2x6+AgeY6EBXuEEhstoAYetIX6r8UzfbxBqn76FWT3ptnYxJMF5IDl4qephvsk9q5nzaQe7CUgkUBkyELaYlACP2qV9M0LkErSWDbwnt3ZObaxFRpzxF9vPr+rci/Kqkk/iCiBiz6yUIIqWjp6V86c3mJqiYV6ukej2PEjUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D6LoIiJU; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WmqpgApb; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hpf6Apkh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LA1xS025574;
	Mon, 8 Apr 2024 17:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=91WrhWHWQt0kCb8CJ8PAOeIa7mmFnaQNrZC2/ngLJhI=; b=
	D6LoIiJUONoP+K4rDXgsHJGj/F4cBTAJgLfsB8sRoO/liGrHOeHm8PoYmkBubTEW
	O8nPg7Ds2R9/RYsQQ0cC2KF3YN3hL1NCg1/1nwhxmoa2dxlvPJZtetenU+5j5Vb8
	eRasZ+fSVHt4LhNoh3NP/iMZzRqbkft6jVImMWYySAe2+fKufKQWAIA8OsSkgRXt
	u8Hicbp1To/bke887QCkNJiAC9Sm9vs9ludUjtGfZHSRG+Pxzx7edNTB7E4d1bHl
	h02dh8Hy2DtuCUo6cpG8jKRX/K6FTcD4MdV2BnBbdFXtVwOgwsDC+c6H5BTPucuK
	5aP1GqDqHN1/qwwqrJ8TDw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3q7g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 17:20:43 -0700 (PDT)
Received: from m0297266.ppops.net (m0297266.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 4390Igft031300;
	Mon, 8 Apr 2024 17:20:43 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3q7g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712622043; bh=91WrhWHWQt0kCb8CJ8PAOeIa7mmFnaQNrZC2/ngLJhI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WmqpgApbyBz1k3kWIGC6kWQKs/VOucI1KrncumEijQrExz1IIpGnHsLmwgBxC+Pev
	 WPJP0DV6qdoWcLaQfLrBpK9YMaEj/io4RXayBJ97j3QklFWCrHcbfJeJ+xIS4Je6ZU
	 q+kHaJpncMkwPmR0ns9DGY3h1rKzlFtbi0C0YiEohWJ70AbAD1aRvMjYSKBXJ7WhwP
	 xqle2FtvOUPxPTnpfUu2tmQItY/+n8gugeTfxc1u8DE1oHH/NusTOZ/d9/3jUyh5Fk
	 w+bN0ZJ7XIEEN7MEdOiJ1sxvfCYxEupEclA2dbAW+Fq4QY7X2bQcITN1l/3q/OhSJr
	 MogbQR6seSlnQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 511094045D;
	Tue,  9 Apr 2024 00:20:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8DDA4A006D;
	Tue,  9 Apr 2024 00:20:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hpf6Apkh;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B7DD74013F;
	Tue,  9 Apr 2024 00:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlJ9feDybcUWd7Xu9YU7a68J5pXcwZRYuWA/Or+X+9ft+P4Iaqkv1l+pWPxedxi+yaE6dFurigyCXczKVaGeqxUnNEke1j9VXMBpSen9BvalmF41gBBTQiVglmPLlWVNlepuHzgZgWc0BGK9yRzS6XJ2Bv7SgYzLZSBQ+wB8/UIekNTFL7GDazBzBD4o1NM+HSYEk+jc8pMpSNhU224Vponjy1ohSFYJYsxnt7gKJmxyJC/S35xNpctFZ62FBaVEYZs1w5JX/S0x450OJBV/RD82zT84bX/b0HVowzL8s890Y1gX+QNfKnDc2aTgeTjHvFlJg4whYdn+3pGeobU6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91WrhWHWQt0kCb8CJ8PAOeIa7mmFnaQNrZC2/ngLJhI=;
 b=QeecqhOGNsIm8+sBvimXB8GjonUW3I+4ytD15wDUxsABCiqYE0T9gx6mRPcZpC0Cl7NYnnQceIyM7YpMMFjp34RcewiRSPZZVe4yBq8GC7axeusdraiHDWefALADPtF/8ezNCS/3ArlH79tvwGHHFPE4nrN/OPg7TP+ksviVZgPyu1B6B6uV/Q3WCEp0MZmF07ux+sSbrtBJ2XkbMWB8MrEpu+gGl9Qad9Q65jz4cqrDctsx6Ro1TtiEblXbN6QKEfYd/ix4Tmo0h0SVG9Y/+PFd8Awnmx+C+cTTipuHyzejp6WdmYEMPGeMoG9Pzi1FtZkNC4j0hzov5gwcSZYk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91WrhWHWQt0kCb8CJ8PAOeIa7mmFnaQNrZC2/ngLJhI=;
 b=hpf6ApkhzcnaNhCHOYh6DoiKWAMdtiCvLsnCDglYymBRFXiVFaEpzkealRTKBygQsyE6rpLbelYyf1ZF71NtrimigzkfqmovceMR/3ivdEWaA4oCVgPCR7ug+NS7BVQnzsHTb/ByxsfA/hqO90K7myadbPf2Iapi16cDdWPsMHo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 00:20:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 00:20:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andrew Ballance <andrewjballance@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: Re: [PATCH] usb/dwc3: replace of_node_put with __free
Thread-Topic: [PATCH] usb/dwc3: replace of_node_put with __free
Thread-Index: AQHah80YBLXRlpv1iUqNM3scsgVRRrFfF9oA
Date: Tue, 9 Apr 2024 00:20:37 +0000
Message-ID: <20240409002030.vvl4jiyl2jmxfqfm@synopsys.com>
References: <20240406024838.537630-1-andrewjballance@gmail.com>
In-Reply-To: <20240406024838.537630-1-andrewjballance@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fwpGI+5d/g+QZjJz65lRhU+JLgGbPRdta5/4Oj+EAKc2OvGvzgGzCbhumwxedLOdLIEho6FEVFHfcBaVPLVt3WipzmSbfdj+n2eqm2Z5Tssr4n09PdebsCXlo5s6SUgNJRrEWuHToZcbpoitaW1HhwrsrLMvLYdqVRYAgSYEz8o9NA4ta154Z7dx/Hprsj/qs7qTUE+O+7Xv+RPLajo87+OdoNtzIWw77GRQM7DqTEfBi3qD7LLGmSzMa6kErKKrnYnsN0r9EejVfoP2a3KHNKGi+18VsR7OlMhWnA3aUugP2Swr2Q2O8tmmhmy7wc6qG36RKz/W+qeVFE/T09JKmhx6U1OSfbqoFqmYHjwz/1YKCzy8Ihqh2VwHUgiCmT64Sk/LXLDEatQQ8oZVlhrW7bAj3R+jylCcxNF4z04WebAVD0XZmaPzT0PGpO7wz90WH3K6qYStScCffdtt/kCFgtiWClwwrlrPxmCl/X7nSArDDwiIIVLP8NMZRfWks0BOa5urp7Fs99UzOST7QP6y+5FkWKc/qEfzdrhMIu6CifZU1HohqvMnq64QNamlksompy/izD4+IcVbLFCCAet3/F4sBThs7uXZiT6Exuivs8LLPUmPFf75Jhq3NkqYIGlNTW2rooC0upIcMqab0CBN73zAVeZqkvMp77090Qsl9/o=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFo2SkhKUng3bWJSSWEvZ0E0RmNkR28wMTVRbFQzdzZLTDdJSDIveGd4OTBZ?=
 =?utf-8?B?OTJiWU4zOStaaWpvdXp1RUxQRXVNTUhWODhGZFdIUWQvdDZtNjcxamE1REwr?=
 =?utf-8?B?UTZ3QjJzSkQ2cjMvMEg4UE1BYkltK2FzcnJQTmY0d1FmdVdxTnpvVG1VTmZ6?=
 =?utf-8?B?MitEcWVRM0ZYbHZxbjQrQVUyOERIVjVkUkR5enNHTmtheEp2MlM0Z3BWOTAy?=
 =?utf-8?B?S3RkWGRBdXU4dmh1SDMzU3IrNkpXdXpUUGJSTEZsUzJiQ09RcUlyeU1lSEZ1?=
 =?utf-8?B?TENrWFBZTSt3U081Wm13UFdDNGtzQnBZNEk0KzlhNVVndHhFTjB4aUpoSHQw?=
 =?utf-8?B?OSt1Zm1wQXBENmlTa3lnUHpvaHFpbXgwRC9qL3Z0NmlQS3NFbjRLLzJkUUd3?=
 =?utf-8?B?THJYTkcwb0I0TkVMeFFWL0N6eDJPNW5pUVV1d1gxWnlMZmlHdElkcjVLUmkv?=
 =?utf-8?B?T1VMM05tcDEzSEtWRG9wOFNwN25zUWJMbFhBeitnWnlKaGcvYUhDcisraWQy?=
 =?utf-8?B?aHREZ1VyUzZDTjBGS1RYT3lHU2EvNGJoZGNXVitNWjNCTEdFZ1l2bGVRWGc0?=
 =?utf-8?B?QzhtME9sVVB6QkdocGhWcHZ6dmZiQXB6Ty9yR2VKUWYvVWJnYnRNR1VZeXoz?=
 =?utf-8?B?YU50c1REMGEyU25wNUgyTFlpWDNKMEFtcU1SemVWeFp5VE9hMWcwOW5YVFZ3?=
 =?utf-8?B?YXZqbTdIc1ZzYWlDbHpQSEFRYWdLRWdHNDQ4L1pqY05ZeWRYNExSZXJHcW82?=
 =?utf-8?B?TjJRckhhZ0hWQVY2Tk5uTUJEcTR0UEVzcWg3Z1drYnRLejV0WlhLTXUySk5o?=
 =?utf-8?B?dWUvNVpUNHk0S3NLTmY2K25VWmVzMG0vQzNxWFBzdlNTazdWMWtZNnpieW5a?=
 =?utf-8?B?ckllTzIyWXRadG9rd2h1YUhMRkp4ZjdKek1zWS9maUszblFlU2hDK3Z4OGor?=
 =?utf-8?B?RlMwSitVV2VhTXpFUWpDcFFEQ0VrWUF6YjBmVUFyanNadWptcVJxRnpQRHpC?=
 =?utf-8?B?LzQyUklTc3phSEUrOEdCeHlMcG9lV3VtMURkcDRkU0ZvVGVYbDQ1ZStPdmlT?=
 =?utf-8?B?WU9hczNadlhyb0dBMnlVdTF2VWVJaVpZVGQyNmRVOS9RRjVQMjAvNUZQSkJZ?=
 =?utf-8?B?TW54OHFsbWNzWUZDQ0hiSzY3LzhQUXBIdk5WK291MGhkZXFSZkZUVjN0T2Vr?=
 =?utf-8?B?OEtlV0FNbGwxVGwrOTFJK25YY2pxVytrMmJWbTBBMXpXWEtIZTd3dDcwOEll?=
 =?utf-8?B?S1psSG5EV24yanFiWnh2ZFZ2clJCbEU2NURVR3BWZTE3a0RlMmhVZ09MNHdM?=
 =?utf-8?B?Wm9saUEwWEVTblNOa1luUmdGRTNEM2xQamNYdDhWaTJUWG9FQjFGZlljY2Za?=
 =?utf-8?B?dkJ1L3dkT3YzVGYydTdMb2ovd0dCTzdHdE5uUmwxZytmcGZqZnZrcTJIblNs?=
 =?utf-8?B?V0ExTGozZG1RR1V2NXJoWmUycjBXZTJsNEo4eHZTeUdPNFhVV2xBM3lpZ0ZX?=
 =?utf-8?B?Ym5wMFkza2JzVjhKaDc2UDZVR2dObWlEQjhOUFdsMkd5WFVFZVJGNmxNdDFv?=
 =?utf-8?B?cGw3OEZsZ0FsQWVBNkoxRktyTStXN3VIeVRkZ2wyUW1odkd2NVBDZkxKdDUv?=
 =?utf-8?B?SVBCZ212SitmeGR2akJIZk1TOGRNT0k0TThhZ05TaWYxekxRb3dhVjRBd2dY?=
 =?utf-8?B?eGdGQmFna255bHE5d0FtTWlobTVOaVorS2RtTndQUmJXWjAyMFh5YWJuVDJ5?=
 =?utf-8?B?VmRGZWFWNmczQU03YW1sWmNMZnNTTEJnVjF1RXBlY3NqdHdWOHlLUnQyclgr?=
 =?utf-8?B?TElxTWRhKzNkc1B3dGlIdUxxdUJPbXZGTlhDOXJjNFFZSStRM2VHS2NIQVMw?=
 =?utf-8?B?aitsWlBLR1Y5SGEzcCsrVmtUTlRPUThrSVpoSkM5U0g3Wm5NYThqd0dDL0FD?=
 =?utf-8?B?NmFER01XUmlWTWlUcUFIbDZrVXl5OEJNWkI0UVVVcWxGTFV4dXJmYWtuNXJB?=
 =?utf-8?B?cTFxUFV1YXg5aUU0YU14V0RSK05UaExaaXhIR05HOCtDRmsybkhPdWVCWXR4?=
 =?utf-8?B?dDNIMVZMcU9NTUdBWFl0OGhXVDZTYUJldjY1akJXdWhOOUNmY2d0MWlrZWlD?=
 =?utf-8?B?WGJuTUZJbjg2dWFFeGRpQ2FhL3MrU1ZGKytlUWVnZnZlcytFU3ozaG1QUGVJ?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5294CB0E4B70A5478E0FF698781CB7A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pfV7pi17ZL/2mKtV9jZcZXYdkqbgubMtO9x8ayBc4bYwN+dclxsphofhWPs4LWaaUcrWClDXgOMvFYILn3JYsvVdhJHUwXRcfSv5AtX2aikf/JpYbnMXnvU11LRAZQg6BZA8RTltVwxOmBHHMCs4fl6mjorqJLILg0E5NOnP0+E59tk273XAatBSA0f4kIUKL7zOZNSMCeSMNa99oTcG7Z2MXAv6YOW+ixpikB0p2mXdr3IHIaeCnK3NG84AizzOU8eQ7JOfVKiyGbWceLw6CL1tqmHZZmjM1dmvsEGs0+WQNXwtm10uHxl9fShRtmC+u/0pIXdfkyjTbHFP7wwEnCX4NXHvf6evW4cUdJzaN818qygMeXvyRCeFljYsrl2qL7svXHKkxlteVs54rtF59ICHsPZGI4wpg80L1Dm1NoI99p3yo2aHtjFkJQl7Fc5UOnsCYhgbQYuE9l9kJteiq8VwtFVQy3T7XH6WJfuTuHWzPlJp4hiZSzxjSHeSE4Z3QYgl+bglQy2yCr0Dn5nUk2mXA0JC8rgDIfjOvNLYa6uxx8N3ka5fe8MZj6pYb0FGF/uF0QuTL9DI82ypBAu+c5z4kiqdFnJ3f78frOzQXW2GpO9dnzi8idVEB/BNronSng5MN2G+Z0Txe5jTWmJ3bw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4478e021-a9cc-4c09-ea4a-08dc582ae1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 00:20:37.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+HBYX16wxt/njfvfGdrr2HTw2JspQt50/JIFEPY5DA2JuAuK1PR/ECmoCpbSaEyP7PC+1wJhcSn5LEY/HAKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
X-Proofpoint-GUID: nDWjrL-zi8dBTwg6NKJbQxJWsR_7jsWR
X-Proofpoint-ORIG-GUID: XtCaVWslZviafL7zIwRXZFle139oIbUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_18,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxscore=0 mlxlogscore=889 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090000

T24gRnJpLCBBcHIgMDUsIDIwMjQsIEFuZHJldyBCYWxsYW5jZSB3cm90ZToNCj4gdGhpcyByZWxh
Y2VzIGluc3RhbmNlcyBvZiBvZl9ub2RlX3B1dCB3aXRoIF9fZnJlZShkZXZpY2Vfbm9kZSkNCg0K
dGhpcyByZWxhY2VzIC0+IFJlcGxhY2UNCg0KQWxzbywgZml4IHRoZSBwcmVmaXggdG8gdGhlICRz
dWJqZWN0IGFzICJ1c2I6IGR3YzM6IHh4eCINCg0KPiBpbiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KDQpBbnkgcGFydGljdWxhciByZWFzb24gd2h5Pw0KDQpUaGUgcmVjZW50IGNsZWFudXAgYWRk
aXRpb24gdG8gZGV2aWNlX25vZGUgdG8gaW50cm9kdWNlIHRoaXMgbmV3IGNsZWFudXANCl9fZnJl
ZSgpIGlzIGZvciBhIG1vcmUgY29tcGxleCBlcnJvciBoYW5kbGluZyBpbiBjYXNlcyBzdWNoIGFz
IGdldC9wdXQNCmluIGEgbG9vcC4gRm9yIGEgc2ltcGxlIHVzYWdlIGhlcmUsIGl0IGJyZWFrcyB0
aGUgdHlwaWNhbCBjb2RlIGZsb3cNCm1ha2luZyByZXZpZXcgbm90IG9idmlvdXMgd2hlbi93aGV0
aGVyIG9mX25vZGVfcHV0KCkgaXMgY2FsbGVkIElNTy4gU28sDQpsZXQncyBub3QgZG8gaXQgaGVy
ZS4NCg0KQlIsDQpUaGluaA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQmFsbGFuY2Ug
PGFuZHJld2piYWxsYW5jZUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCA5ICsrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDMxNjg0Y2RhYWFlMy4uNzk1YTU3
MmQ0NmNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTc2Miw3ICsxNzYyLDcgQEAgc3RhdGljIHZv
aWQgZHdjM19jaGVja19wYXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIHN0YXRpYyBzdHJ1Y3Qg
ZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJ
c3RydWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7DQo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpu
cF9waHk7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucF9waHkgX19mcmVlKGRldmljZV9ub2Rl
KTsNCj4gIAlzdHJ1Y3QgZXh0Y29uX2RldiAqZWRldiA9IE5VTEw7DQo+ICAJY29uc3QgY2hhciAq
bmFtZTsNCj4gIA0KPiBAQCAtMTc5NywxNCArMTc5NywxMiBAQCBzdGF0aWMgc3RydWN0IGV4dGNv
bl9kZXYgKmR3YzNfZ2V0X2V4dGNvbihzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCSAqLw0KPiAgCW5w
X3BoeSA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9ub2RlLCAicGh5cyIsIDApOw0KPiAgCWlm
IChvZl9ncmFwaF9pc19wcmVzZW50KG5wX3BoeSkpIHsNCj4gLQkJc3RydWN0IGRldmljZV9ub2Rl
ICpucF9jb25uOw0KPiArCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wX2Nvbm4gX19mcmVlKGRldmlj
ZV9ub2RlKTsNCj4gIA0KPiAgCQlucF9jb25uID0gb2ZfZ3JhcGhfZ2V0X3JlbW90ZV9ub2RlKG5w
X3BoeSwgLTEsIC0xKTsNCj4gIAkJaWYgKG5wX2Nvbm4pDQo+ICAJCQllZGV2ID0gZXh0Y29uX2Zp
bmRfZWRldl9ieV9ub2RlKG5wX2Nvbm4pOw0KPiAtCQlvZl9ub2RlX3B1dChucF9jb25uKTsNCj4g
IAl9DQo+IC0Jb2Zfbm9kZV9wdXQobnBfcGh5KTsNCj4gIA0KPiAgCXJldHVybiBlZGV2Ow0KPiAg
fQ0KPiBAQCAtMTkxNSwxNCArMTkxMywxMyBAQCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlkd2NfcmVzLnN0YXJ0ICs9IERXQzNfR0xPQkFM
U19SRUdTX1NUQVJUOw0KPiAgDQo+ICAJaWYgKGRldi0+b2Zfbm9kZSkgew0KPiAtCQlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnBhcmVudCA9IG9mX2dldF9wYXJlbnQoZGV2LT5vZl9ub2RlKTsNCj4gKwkJ
c3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQgX19mcmVlKGRldmljZV9ub2RlKSA9IG9mX2dldF9w
YXJlbnQoZGV2LT5vZl9ub2RlKTsNCj4gIA0KPiAgCQlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUocGFyZW50LCAicmVhbHRlayxydGQtZHdjMyIpKSB7DQo+ICAJCQlkd2NfcmVzLnN0YXJ0IC09
IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiAgCQkJZHdjX3Jlcy5zdGFydCArPSBEV0MzX1JU
S19SVERfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiAgCQl9DQo+ICANCj4gLQkJb2Zfbm9kZV9wdXQo
cGFyZW50KTsNCj4gIAl9DQo+ICANCj4gIAlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRl
diwgJmR3Y19yZXMpOw0KPiAtLSANCj4gMi40NC4wDQo+IA==

