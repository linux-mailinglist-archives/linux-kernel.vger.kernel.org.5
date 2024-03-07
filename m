Return-Path: <linux-kernel+bounces-94882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA5874649
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B39A1C21F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63D63D0;
	Thu,  7 Mar 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UUPDnqSh";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b4NH0rIU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wt7RqnKB"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072017FF;
	Thu,  7 Mar 2024 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779661; cv=fail; b=fbhhuTv20zWAZFbBOexJO70Cebf6+rFQ+KWvvCVrOcn8B6lJWE7+URLgmpV+/t3NQt0WQDQkV0lEOFsqOFDbmLSlL/qwVWqdZ/EaPTciPvWFdjO144ekm63zfQoKtGS+wNE2pByAYlKdYXTBFRMklPxAQXTQx708Y7AfrHpKYkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779661; c=relaxed/simple;
	bh=EspJPhpJrNbVOq3y9EybS/YP5C4lAVUG91N46M98k0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bcw7JP3Rir0DdGvKn9g5C//FVUXTSPRRaFLgOR5+G1++SiWya334uQdOh2uy6n4MLkGG8oGzjf25AFJ/LC6/H2w6hjawObHLQkUVxgVyeeUG9rb/TxmHw5jes9cKvbrGDPzgSjvtiWo7tdu9d55YY36qki6BQxP+gt7l7vlBTpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UUPDnqSh; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b4NH0rIU; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wt7RqnKB reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426KUJQG001916;
	Wed, 6 Mar 2024 17:44:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=EspJPhpJrNbVOq3y9EybS/YP5C4lAVUG91N46M98k0A=; b=
	UUPDnqSh/3BruRP9fAur6uVjHw5ckIjjo6bT5wSnnOzahihH0jGUULChZkP7bRpG
	C0fJBGiIeEbI6Np1fQqzjeSys/uB2CzQ0jzFeDEv7gqSTSRwFzlXOw7pL7g+inbk
	eCivLjlbqWCJiwTeoROO/NoStwFu/TajOlHBU1ccbvuPFtZjR9sydb6neIs0ULeX
	bred8cEurbaFud6QYcYs6v4qRt0oNIASs1BLLX5GCiWi/aUQusSE5d20NKLq42sM
	qhPdccLFKx3I+5mjto2sZlN23DlHTqHrrLJ/d8tEiPa3jLfQepDJD/uK+cxiRQcj
	UvLpx1eheUAVW9RDaoIsbw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wp9ca6h3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 17:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709775854; bh=EspJPhpJrNbVOq3y9EybS/YP5C4lAVUG91N46M98k0A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b4NH0rIUmu89HFJgJECHXEDYvp17LoO8vR5VKe5dSF7Wh1Mum7ufLVJijVyfVKOsQ
	 OVLTE6G9pM4pni0wTIq1EPGthDWFLM95hUufS/VKzp9FOXjUwiOLCsJU9bPDobVbOR
	 2zcS4wOsZuM1VjLDtG3JsQMcnbi18l8/ouE7ZvY3Z9PkvdJJEN8V1WuiiHypyWwHqT
	 AodX8WZdm8PBQI85Ex9RoDLcJh1Fqlo3zFgmHhcTm8ffcK5+b2wA+sCy8bVot0+cP0
	 Dfw+5KVuDcEt9BeDvd3tklb7v480P9duqSwgKWIgYhggAKxnRNg8Y+mCa2EezWXUfm
	 7HWp0syJPjUdA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C794C4035A;
	Thu,  7 Mar 2024 01:44:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 83358A0261;
	Thu,  7 Mar 2024 01:44:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Wt7RqnKB;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3BCF140346;
	Thu,  7 Mar 2024 01:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIIkQu4O1jWK0WJbzD8rgs8pGrxEredGd8xqGw5IzBCzEKKdonJzKka2/tR3t3nwyu9WwMUweu0jAssVI+WBOfDhSP46b7mMNAp4LAlmmnkBoC90kfuT7KhDSFnA4a/MNYMVVxYXTKCoxo5ckN5sIerqr5A9UIY/zSX/2KsjxZuqzfu8WpMGJ1N5HzIg5+eR0u8g2GjEKHeQFTobyrAGE9cmMSYLF/6vAvjgwg0HVbii0CODL+UxOSy5t/pslQPuOgNtfqU6f2xYwUf11R2Izytf5icIzhtLpdMtRRalU4kZRpjrbFzfzRvVzfmJxorh/a2QcKi47XQes4F0+uuddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EspJPhpJrNbVOq3y9EybS/YP5C4lAVUG91N46M98k0A=;
 b=EeuY5q3WIVs22JH7NSVJgCq3bOeELh+LrIB0sbmtkH4bosHvND/vwovXcqrgev9xlbR0L/uZQcmAE1e9fQ2gepfARsqwRmbg6MVCKIlnoqguUid/6D8Uu3Uw8meXHDSAtBidhNjm74NXk7pKw4XCajtWo/rOWIgTO/IxC/M6n9l22Q0y0q83fOXCA0FF3iDw95rg6iysautREaTBX+68ACCD661D7v6RDNhj7G086FBn4wC+Ej7QtkEtfzR7WDKaaXMl9p3vsbbO0E+sMre3VSYVTQSTfWfbYiwGXkiW+oQE6L+EcWjLIounGQTqoUl2HJ46bbzYWoFzfSyQVRlrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EspJPhpJrNbVOq3y9EybS/YP5C4lAVUG91N46M98k0A=;
 b=Wt7RqnKB3aWV1OwN9sdGkVqYLtxSzlSTIh51vixSWyaRu+mAlUvcImp9XWn/8pS8o3eFD5FS5l2MW4LbsJ2GE3c1whcRGxl+U0ZBvbUTdntrwlL611PRd5pbSAi6T/G5cjnhjrf2sDt/ZUAbBB0raUv2LmnjYJiHBGU4DrXhVzM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 01:44:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 01:44:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: AQHaZpDfVUYctKsozU2uHIlcC3QiPbEYiAkAgAAFHQCABge4gIAM/9wA
Date: Thu, 7 Mar 2024 01:44:09 +0000
Message-ID: <20240307014402.omtcsltp4pxpraf7@synopsys.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB9062:EE_
x-ms-office365-filtering-correlation-id: a88e8fae-bf11-4e5b-8665-08dc3e48156c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c9jRuiSAuBB44wB/mzC8ylKnlqdftKwskvvpiu8VedsfLFkE65s4wJkjyEB+h6dk0pSXNZNCEQSbAwkr5d6zpgzxwm2J7ekLtwbWS6X0XwtGeQKSh4PK+jbbivBrkYu2aYYKjKgQksvw7TdeU9vZchaZVEJSWFUbEZMN1LwV4S2tKP1ZbAux/TdkSH/OvFr9RamBkMRVc6hMKjyyDnSv7TknWozjIKCGVP8kBAdEcQYjraajalMA5AftZ7t/ar1hSHTHnQkiP4qas3JvDVTlzZmSgkuGVJNdhKikSy6OnkS16+RaISdhl/6nSH2VIQtPwdrN8hyXeqLCgTI3vNy7/qQR+K5vUKmG57wHGuwFSSyRrC3VtjentjK0v3SUOxE7oCsGKEdZlxvjCfLlnKS6Lu7uCFxy4nKUx1IuYyQ0wOg7cLJoeMQZNkzMkv1U/FZBjky2/dww8nd4SVDtkMsQwEAYRNsev6cJr+Oi8zO1N5fEqzVZwYMQgFuWFBSf50WXfZCo3W07bVnwS+ekOwg6SKos8BENJEuvvhNwrMrJzaXMKhN85mnT/W1k+mMiLh8UXHtvn8AjD3RRYIid0xRSR2gMeGd03tpIyavKNRPQ5TTyLKP+6mZbCnSzG7JDAgzy6UYW+7cD+VAbf5DyaSdgFX/hT8YNP29pDqIlf12h9dQPnLgZ9ZwcROMeYD+RngeCTKbTGV0MKHxYndaPgm1euL4kGOjUbn9Ej7hI+z1wNuw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TThtU01uM2wvVExBZjc5NVBxRThMUW9tTUxSUVRsV0VxMFVUcm81RVNkWUJC?=
 =?utf-8?B?V2VDVHF2UDgvRGJVbnd4QlllNXlTMHF5SGFET0VZYWgzSUduUTNrTlBjMGFS?=
 =?utf-8?B?S1lFaWgxeTdPeURQOTNLVzJXZFpPWUoxVzlLbDNTbXhMRHFlRlErKzFFTzh5?=
 =?utf-8?B?UEFOMXpqRGpPd3ZmV0RDRWlVZ2dyU29FK3hBeHE1ZUJ1djJRc1Y5V0h1K2Ex?=
 =?utf-8?B?YzluTEI3bnl3ZkIvb3hkU2JJdkFsTE5ScWkvMkNQQ3JDU2hzR3BPQWVOTnNh?=
 =?utf-8?B?aTVyaGhzZEJFQmFxUWhtVHJCeEtmUDV2QUpiWnVPNi9EakVqQW5vUnFIVW51?=
 =?utf-8?B?bXM4eHdnLy9ZNXUyN1kwWnR4RWRpVEExemhTdTZqRG1lVkdxTGwwMyt0dzVB?=
 =?utf-8?B?emgzVU9vUE1IR0JBbnYzRHhORktRdWxqR2paa3l1RHgvc3RGbU01K2VRNDFs?=
 =?utf-8?B?dHRzZ0JodnN1dzQ2SUdtZVNyWHVKTGVKSFRtT3JwcE9ROUVhOWFVcVYyNDVv?=
 =?utf-8?B?aGlzaUJ1cWt0Y0NaU2RzQ3lKOFVnb0UzeHhsR21ML2U1MDFMNGFtNThGQmd2?=
 =?utf-8?B?anhidThSQUFKakd4YXp3RnB1UlVoVkVJRk1GZmlLK3ExdW1VT1ppbGc3TWQy?=
 =?utf-8?B?SDRTSVNzZnlQelEvUHQrSzNpY0x5NTBjMUJkYzNITk4vcG5OQVkvcXk3TXEx?=
 =?utf-8?B?a2h6WWJIN0tDZHQ0SXpJU2pCR3FFa1l5cXdCWmYzVkFaMVViMzhtekRvK2lK?=
 =?utf-8?B?Vnp5SEI1Vmc0eG0reGFHdmliVVpmR2xDY25ROWhXeFN3bmxqdmdtNVExTXVw?=
 =?utf-8?B?NUpzdnRwbGV3TVF4cHlxcVB2ZTVwYVpoK3dWY3plU0p3eDhZaWZ2K0VxMnpO?=
 =?utf-8?B?eFc1QTl2NGxkdERWRWMvQ1RyZzRqUmxldjlrUEg2QThQSWYrUHdQSkYra0dM?=
 =?utf-8?B?ZW91bDVJVjl5SWtBbUwzOWhKZmozOVJwRzJWZERxZTU5eHVjbXU4VnErMC81?=
 =?utf-8?B?RnBIaVdrOXRUSmdjMU9ueHpFNDJJNXhkY3ZPWDNHU3RYOUdBcUlYQnE2aFp3?=
 =?utf-8?B?V1RnN2M2UkNYNGhwRnJRbllMNGtwYitYMG5ubW10YjltNHlCeWRrTDZIQXkx?=
 =?utf-8?B?dGFFRGh1eC81RGxyc25laUR0aVV5dzdJbFlBSGhvS3k4clRWR0Y2ZWhPemZH?=
 =?utf-8?B?cW5uUWFmcmpETHdOajNMVmE1MW9RSXRtKzJLWWsxeWlnSXN6Y0IzU1laWVh4?=
 =?utf-8?B?NVBIUXdkeVpiNUNUbXZSazJEVk9QUHFpUXZZZkZLQWtjWDhyTFlTUWZ1dzUr?=
 =?utf-8?B?L1JPZGphdEFsYjhhVW83enA5cVRJSjlJR1NsS2dNaHN5eUhaeERhejNqSjdp?=
 =?utf-8?B?Q1NKalN4MVJWdTJ5WUZnb2dtemE3MkNyZDI2R05rVHprVXlJWVplbmZxWWdL?=
 =?utf-8?B?V0NnZ0lXWCtvWEs0M25ZQTFoMGhQTjRQOG12dFRjcGNRU09ZbDdva1hkLzdG?=
 =?utf-8?B?QU9xMXl5Z05waGFLRytWTk5hWUxuTnJ1aksybE42UzJMMlliZW5ndTJ5ejNN?=
 =?utf-8?B?cXgyaGluaHF1TEE4eDJ4bWNjYzZseERHZGFjS1M2TzlaelhLajFRQ0t6NDNp?=
 =?utf-8?B?SndHbjhhT1o5V2VVTnczZnJEWFRld0M0UU9hYkFUeFZ4RGE0ck16TWtmMDk4?=
 =?utf-8?B?T3R2UDNOdERPYWFjQThTRXNLN0t3MkFUNXdkNzg4Rm40dUcxOGdvRXpVQ3RX?=
 =?utf-8?B?ckkya0xid01ZSGFLTk5rZyt0eHV3VXBlL0pwVFdVZUxKZkh0VDNsN3lSd0dH?=
 =?utf-8?B?YmxvakhPdGppb0s2MjlFckVrb3YzTXVQeWZBd1BxTSs4WmoreHlpYWhJMlcv?=
 =?utf-8?B?SHFhamxjSkxydkk5TjhWNkVNbExrV25Hdk8yZkxHdzcxL1hwTndrNEZrOXFX?=
 =?utf-8?B?bElvYVVXcCt1MmVHRmE0MFE4Q21FeitlWE9zcUptOTZqMmN5NEVZNmppMGpy?=
 =?utf-8?B?Tk1SQkxmdGlRTlhQWEhWdmNwOGpwWGpoZ3FnUC9kMHl3dGpjUDdhV0ZTSG9P?=
 =?utf-8?B?WXV6d3Jva3F0M1RiRXE2YUpGN0NiLzZ4QXowZnhQWDk4VFZPblJEMDVXdUNN?=
 =?utf-8?Q?fTq1t/OVT4lC3m1murkC7Qo3O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F0A8BA4E4AC2041B41AC29330B2D93B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DtWfkb1xGc+XZorOZYojiFzJ1xGq/hhfICgePkJKhjs0f81fa7zYMCXkCmuYhGTiOOMMd6WncN/sFmowUoi05BmzCQIkRluS9M8gDW8hLPC5YE4cw8/he85gLitwZb6DWE8dixwgXXRD6PWkNVIq/qEdeMlQeP6odiV8LaPjOiJGNF71oZuWTsA+UI+XV+KFS6mv4m7i/gr1PVlLaBniVlSS6JjOWroNHtUeoOINZv79/0xWyP90b66g2StzLZ7bOV52RV9g2HVhclY+5JgTJnnpVV1SFMo0rlq+b5ccEj7quogtv5tbzFGd9+zIpz82Z9zJU/HVXkByUxBjKKLGP5nGubhvPTCkwaL2fXsq77uaGstVqKCV9TZ4WyF5k58DRD6rG2/63vceJXelJHfm9qou7w4pKmS7znfO9JIV2V5qWD/3qOQoTkC1gIpNI4gxJlnRUJDoTmriU6BjcUrro0H/Ui7aTGTiOPgrSMzgVHGKln6XuX7A0bCIr4OP8xWKooTqKRFafhw7x2gew9eeRsLEtjvnLcKb/brKOVGtb2UOiwkMbyHmAMsgNS37ckpa9qtQ2uTymi0qYiIOi17QHfgbgCsULGFMad2qWAeTiDq8iUsaiMsU/sxwTTKU0otsLGBxOzV055v6YNJL9SW1eg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e8fae-bf11-4e5b-8665-08dc3e48156c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:44:09.7232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0M6SZG+C42ZY5chDRCgJaQ9tqE005jGhyjgFsH51iKleQqBrou2CYYZA4zXUwSuek6OY5czeOuQXSGSNYtGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
X-Proofpoint-ORIG-GUID: 4HwCL6Pn81Sp6soUHQwiAwQfAIBybFCO
X-Proofpoint-GUID: 4HwCL6Pn81Sp6soUHQwiAwQfAIBybFCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070012

SGksDQoNCk9uIFR1ZSwgRmViIDI3LCAyMDI0LCBQYW5kZXksIFJhZGhleSBTaHlhbSB3cm90ZToN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkg
MjQsIDIwMjQgNDozOCBBTQ0KPiA+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNo
eWFtLnBhbmRleUBhbWQuY29tPg0KPiA+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gdXNiOiBkd2MzOiBjb3JlOiBlbmFibGUgQ0NJIHN1cHBvcnQgZm9yIEFNRC14aWxp
bngNCj4gPiBEV0MzIGNvbnRyb2xsZXINCj4gPiANCj4gPiBPbiBGcmksIEZlYiAyMywgMjAyNCwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gU2F0LCBGZWIgMjQsIDIwMjQsIFJhZGhleSBT
aHlhbSBQYW5kZXkgd3JvdGU6DQo+ID4gPiA+IEZyb206IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1l
aHRhQGFtZC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBHU0JVU0NGRzAgcmVnaXN0ZXIgYml0
cyBbMzE6MTZdIGFyZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUgY2FjaGUgdHlwZQ0KPiA+ID4gPiBz
ZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQgZGF0YSB3cml0ZS9yZWFkIHRyYW5zZmVycyAo
Q2FjaGVhYmxlLA0KPiA+ID4gPiBCdWZmZXJhYmxlLyBQb3N0ZWQpLiBXaGVuIENDSSBpcyBlbmFi
bGVkIGluIHRoZSBkZXNpZ24sIERXQzMgY29yZQ0KPiA+IEdTQlVTQ0ZHMA0KPiA+ID4gPiBjYWNo
ZSBiaXRzIG11c3QgYmUgdXBkYXRlZCB0byBzdXBwb3J0IENDSSBlbmFibGVkIHRyYW5zZmVycyBp
biBVU0IuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5
dXNoLm1laHRhQGFtZC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQ
YW5kZXkNCj4gPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+ID4gPiAtLS0tDQo+
ID4gPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+ID4gPiBNYWtlIEdTQlVTQ0ZHMCBjb25maWd1cmF0
aW9uIHNwZWNpZmljIHRvIEFNRC14aWxpbnggcGxhdGZvcm0uDQo+ID4gPiA+IFRha2VuIHJlZmVy
ZW5jZSBmcm9tIGV4aXN0aW5nIGNvbW1pdCBlYzVlYjQzODEzYTQgKCJ1c2I6IGR3YzM6IGNvcmU6
DQo+ID4gPiA+IGFkZCBzdXBwb3J0IGZvciByZWFsdGVrIFNvQ3MgY3VzdG9tJ3MgZ2xvYmFsIHJl
Z2lzdGVyIHN0YXJ0IGFkZHJlc3MiKQ0KPiA+IA0KPiA+IFJlZ2FyZGluZyB0aGF0IGNoYW5nZSBm
cm9tIFJlYWx0ZWssIGl0J3MgYSBzcGVjaWFsIGNhc2UuIEkgd2FudCB0byBhdm9pZA0KPiA+IGRv
aW5nIHBsYXRmb3JtIHNwZWNpZmljIGNoZWNrcyBpbiB0aGUgY29yZS5jIGlmIHBvc3NpYmxlLiBF
dmVudHVhbGx5LCBJDQo+ID4gd2FudCB0byBtb3ZlIHRoYXQgbG9naWMgZnJvbSBSZWFsdGVrIHRv
IGl0cyBnbHVlIGRyaXZlci4NCj4gPiANCj4gPiBCUiwNCj4gPiBUaGluaA0KPiBUaGFua3MuIEFz
IHlvdSBzdWdnZXN0ZWQgSSB0cmllZCAidGVtcG9yYXJpbHkgbWVtb3J5IG1hcCBhbmQgdXBkYXRl
IHRoaXMgDQo+IHJlZ2lzdGVyIGluIHlvdXIgWGlsaW54IGdsdWUgZHJpdmVyLiBJdHMgdmFsdWUg
c2hvdWxkIHJldGFpbiBhZnRlciBzb2Z0IHJlc2V0Ii4NCj4gDQo+IERpZCBpb3JlbWFwIGZvciBj
b3JlIHJlZ2lzdGVyIHNwYWNlIG9uY2UgYWdhaW4gaW4gZ2x1ZSBkcml2ZXIgYnV0IGl0IHJlc3Vs
dGVkDQo+IGluIGJlbG93IGVycm9yOg0KPiBkd2MzIGZlMjAwMDAwLnVzYjogY2FuJ3QgcmVxdWVz
dCByZWdpb24gZm9yIHJlc291cmNlIFttZW0gMHhmZTIwMDAwMC0weGZlMjNmZmZmXQ0KPiBkd2Mz
LXhpbGlueCBmZjlkMDAwMC51c2I6IGVycm9yIC1FQlVTWTogZmFpbGVkIHRvIG1hcCBEV0MzIHJl
Z2lzdGVycw0KPiANCj4gU28gdG8gYXZvaWQgcmVtYXBwaW5nLCBub3cgZ2V0IHRoZSBzdHJ1Y3Qg
ZHdjMyBwbGF0Zm9ybSBkYXRhIGhhbmRsZSBpbiBnbHVlDQo+IGRyaXZlciBhbmQgcGFzcyBpdCB0
byBkd2MzX3JlYWRsL3dyaXRlbCgpIGxpa2UgdGhlIGJlbG93IHNlcXVlbmNlLiBJcyB0aGF0IGZp
bmU/IA0KPiBJZiB5ZXMgSSB3aWxsIHJlc3BpbiB2MyB3aXRoIHRoZXNlIGNoYW5nZXMgYW5kIGFs
c28gZG8gc29tZSBtb3JlIA0KPiBzYW5pdHkgdGVzdHMuDQo+IA0KPiBkcml2ZXJzL3VzYi9kd2Mz
L2R3YzMteGlsaW54LmMNCj4gI2luY2x1ZGUgImlvLmgiDQo+IA0KPiA8c25pcD4NCj4gcmV0ID0g
b2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7DQo+IGlmIChyZXQpIHsN
Cj4gCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGR3YzMgY29yZSAtICVkXG4iLCBy
ZXQpOw0KPiAgICAgZ290byBlcnJfY2xrX3B1dDsNCj4gfQ0KPiANCj4gZHdjM19ucCA9IG9mX2dl
dF9jb21wYXRpYmxlX2NoaWxkKG5wLCAic25wcyxkd2MzIik7DQo+IHByaXZfZGF0YS0+ZHdjMyA9
IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoZHdjM19ucCk7DQo+IGR3YyA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHByaXZfZGF0YS0+ZHdjMyk7DQo+IGlmIChvZl9kbWFfaXNfY29oZXJlbnQoZGV2LT5v
Zl9ub2RlKSkgew0KPiAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MgLCBEV0MzX0dTQlVTQ0ZH
MCk7DQo+IAlyZWcgfD0gRFdDM19HU0JVU0NGRzBfREFUUkRSRVFJTkZPX01BU0sgfA0KPiAgICAg
ICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RFU1JEUkVRSU5GT19NQVNLIHwNCj4gICAgICAgICAg
ICAgICBEV0MzX0dTQlVTQ0ZHMF9EQVRXUlJFUUlORk9fTUFTSyB8DQo+ICAgICAgICAgICAgICAg
RFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZPX01BU0s7DQoNCkl0J3MgYSBiaXQgb2RkIHRvIHVz
ZSAibWFzayIgYXMgdmFsdWUgaW5zdGVhZCBvZiBzb21lIGRlZmluZWQNCm1hY3Jvcy92YWx1ZXMu
DQoNCj4gCWR3YzNfd3JpdGVsKGR3Yy0+cmVncyAsIERXQzNfR1NCVVNDRkcwLCByZWcpOw0KPiB9
DQo+IA0KDQpQZXJoYXBzIGl0IG1heSBiZSBiZXR0ZXIgdG8gYWRkIGEgbmV3IGludGVyZmFjZSBm
b3IgdGhlIGNvcmUgdG8gaW50ZXJhY3QNCndpdGggdGhlIGdsdWUgZHJpdmVycy4gVGhlIGNvcmUg
Y2FuIHVzZSB0aGVzZSBjYWxsYmFja3MgdG8gcHJvcGVybHkgc2V0DQpwbGF0Zm9ybSBzcGVjaWZp
YyBjb25maWd1cmF0aW9uIGF0IHNwZWNpZmllZCBzZXF1ZW5jZSBvZiB0aGUgY29udHJvbGxlcg0K
aW5pdGlhbGl6YXRpb24uIEl0IHdpbGwgYmUgYmV0dGVyIGRlZmluZWQgYW5kIG1vcmUgcHJlZGlj
dGFibGUgdGhhbiB3aGF0DQp3ZSBoYXZlIGhlcmUuIFdoYXQgZG8geW91IHRoaW5rPw0KDQpUaGFu
a3MsDQpUaGluaA==

