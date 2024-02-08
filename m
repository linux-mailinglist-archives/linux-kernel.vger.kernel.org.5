Return-Path: <linux-kernel+bounces-58886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569884EE20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FC11C23B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A75103A;
	Thu,  8 Feb 2024 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="irLwdTg7";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TdMjvnit";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AF3c4MLv"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194284EB5E;
	Thu,  8 Feb 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436640; cv=fail; b=lQqMcgsJQjFJpxhO8vk0dHIl7bP8fv4zA/3NZuNzVFLp63CDvUHcRr+QlxTn3VUtbwj2SJPblV2vPLBDNLiPrnLOgdogKRDlLixhfwqluunQH3CXsGlaJeZnwe6IxApBRVW3uhhNQMUH5ilwPVzq1uil8OtfbhsweRPetdV0J5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436640; c=relaxed/simple;
	bh=AP9s4AmcCFb+MhWnnO8tKuqT7iwc3F3uvFK/OHBPNgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jD4RSBbTprbRViub+tRlYKEXbPYWw6zhUU8WY9iym73i43lI80K7Sh2Oe5SQPF5/jjwhUl/JQen+WkrmoLhG9opxOq7UG/9dqh572eK+9mfEPMXDBR4T0deija63ILXl8newsMWjw4ACfYg1eD17/j8MFS4BW/DloA4z2FOJNgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=irLwdTg7; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TdMjvnit; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AF3c4MLv reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418NB8TV006525;
	Thu, 8 Feb 2024 15:57:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=AP9s4AmcCFb+MhWnnO8tKuqT7iwc3F3uvFK/OHBPNgs=; b=
	irLwdTg7HRe5uu+hYd066PLRW5K9WXw6PBjBrEWwqc7nSzvNjuDRWmuZd9F6hJUr
	Xy6TiM8pctGdMd/xuZKK2Q6pyVmPPMYfZHqjS4oSl6Mri3neNquMTt+CxOxNneGu
	CEsskvIVdx7Lj0iPxtfLcTesjm+hXiHTisaKvLb990DGOk1U80D2hgmdDpUId5Ra
	LibfnZ4tJLE6agxtV93deJF/28qfpGdrh9DXSKEzal6uLrfmxdTxGR9kCJhidqZs
	4C+JWO8uMJ4WkNbCLIo6tV/iekgEoriPahax0kbOcDsQh4C3SDbPfUr5sGxyJulW
	iv9FQ6RLTeb137kN0tE08w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w1nm79214-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707436628; bh=AP9s4AmcCFb+MhWnnO8tKuqT7iwc3F3uvFK/OHBPNgs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TdMjvnitS0ZlM0NW/Ea9T4pdus7DT+u9NljGjWQfj5LGtFVOohWxAWrJuwBZp68kU
	 yMftih917E0m/TQ1BJCIvBLVisCd7fuVaDUYRIVkdFj/oJwlZT1XRqEHeswvQUzU2P
	 i/WG4so676sDoyEuqDdiWsCmpOd8CE9lBy6ml/WglbLJvyZAyUKywge83ss0VswAB1
	 XuG5xNQanJE4wZHLly78lFpbHTsQDZpov1aRpqA/vUAimJP/xf+18j4BjDckN5N0wG
	 rPBvGqLKswYxhaQ01VMmHupf/ShY2dJiI0LH3eAUc77LpQ6HfOSpPlyoDZk/YSf7bQ
	 nNHCnDkJkYWAA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A929440524;
	Thu,  8 Feb 2024 23:57:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 77585A0063;
	Thu,  8 Feb 2024 23:57:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=AF3c4MLv;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C4FA440359;
	Thu,  8 Feb 2024 23:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4pNH7rGcTdyafpYwnfxG7mQzTIHPeoajwqFm5SKiRO/dRErP3OlExhjMgqNj3YKW+9LFjgaryh86+fdxN+1daXZd3sBLEfzUWxKeU5LsYqWG77P4CGT1OZsvZJilRvDZm/4vHo9x42RM7o51rwjsKC7qUCP73fe4r/MEeLyHxOtQKOaVGet3UvV7qGgqNJvSg8S7AeIUlJ+uFrPyRkok9BbwFCSQrL5ayLtJZgrwkjt8HxoaAeZ2szFE6U1cLRxpFBIomAwYuD6GTShqPXNku6pjxZzK5PiTchUIQBxHCak0wingcreMvJ6ybn1J07C52T5b5Kyr0jZ6VEZ/YPXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP9s4AmcCFb+MhWnnO8tKuqT7iwc3F3uvFK/OHBPNgs=;
 b=CAMrKLCQfFS8lsVH5YhcsON9JVhrxd+C66g0xTLrQtp+Z0cIo0lDrg5Gz2YfTyTV8irOwEBTvV2X+MnpVmCr0P0MaKh4NKStu1KNQkhLvu50X4fpOLk7juVZxOPz9CykeGssbBwSnjZMEJiMTyY47pfDWgYB3CjrDTXFqUpbzwzy0OEuT3ppEPHn00fm72oQnqIIs27EOYeqMJPTRlQ4PdIHxvDBDZbsiVkR+S7cwVJXeJ/AhQTz/mbLfILjhirDOxBHdXa7kBNSRpK7pMnaW3NOjGaeAjcDGbrxY6b3Cs6iqRj+UIJpoo7p5HeLeDqv7riQrJA0yU2gZyknQkOuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP9s4AmcCFb+MhWnnO8tKuqT7iwc3F3uvFK/OHBPNgs=;
 b=AF3c4MLvbtDMj2xSAl8xqMoM2tj5qyi1Sw/oZq53gjOOe49KtBggp3u/mwF3Uf0fTwoi1Rc1B8t9q89i2eIEzAi/mcNBZuItRJtFMVxipzcfjG3IwB3ZhAqQUmoEJpdLVEk68/jRR2rvXCR/hN6q4yx9saCMXVnoMRyhtP5N+0U=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Thu, 8 Feb
 2024 23:57:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 8 Feb 2024
 23:57:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ran Wang <ran.wang_1@nxp.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix an IS_ERR() vs NULL check in
 dwc3_power_off_all_roothub_ports()
Thread-Topic: [PATCH] usb: dwc3: Fix an IS_ERR() vs NULL check in
 dwc3_power_off_all_roothub_ports()
Thread-Index: AQHaVBSXA7pGPDFpBE6EJ8tI3fV3m7EBLLaA
Date: Thu, 8 Feb 2024 23:57:04 +0000
Message-ID: <20240208235631.oxak7mhys2qslt55@synopsys.com>
References: <71499112-4ed3-489a-9a56-b4a8ab89cd05@moroto.mountain>
In-Reply-To: <71499112-4ed3-489a-9a56-b4a8ab89cd05@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6102:EE_
x-ms-office365-filtering-correlation-id: 1f0212e4-dd91-4a00-b85c-08dc2901a64d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rwOA9zUFlzGXQgUBMk3cXZijrkyxQurPx7HNNhFhZu/x6wqWnb53euX/ErQ360vj9V5HtP3lpPTNqa90m7zWbR3mR7spJYptnBO6nUgG/iKSWCG+Mb/p3wHiaFCnUOGQ3YusnrloLFxWCLEt/7H/ZD3suOpQPwC1RO91w8oEbRqJdGy0VRLnsUIawtuhTxOFot/GUd74l6PTTveR6Zp5uUhK7qd3Y0PNcrfnfpRQvanD+bUMfgaMM22wPMx2DSVcq16UBIYM182vGacl4XZy7+h8doR0b9d1ZrPiNXhjxWVh5xdbFmto6Nscjdye11E7aBpC17qjxMKWrfTbh82A2a8vnnB+MkTwdwK6/i+ApnZL+KauyoCJr+zmOuZ3Irj9gBB3qbh9Nsr1FdlNvYDjWC/mcz0wwmDgQpaKDGYvpJ2kIv+RG7sjzoRkitX9X5LtqB5BBl5IJFSRagWZ8CKNXRqwlGJk6OibtkjueBZ/QFvn6gLQwn/JbkdqoELX+VYoLYaSekTiFL7JqgpLz0vO8t6sRIsDFAOV2goUf3TLBahU+00n67f+U+in4zCg/itkuGonlg0LfJpGAfSAM2biS3I2rUrq79QHWVCRxGghBxjXlSjidrXLdEnhDtAnOcVL
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(76116006)(478600001)(8936002)(6512007)(4326008)(71200400001)(1076003)(26005)(86362001)(83380400001)(64756008)(66476007)(36756003)(54906003)(38100700002)(6916009)(2616005)(122000001)(66446008)(41300700001)(8676002)(38070700009)(66946007)(6486002)(6506007)(66556008)(316002)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VGZnYjNHZlREYlVDeFJrNDErTXRVeUNxYXlXMHVvUXJoM2dNeXJ0THk1VWxW?=
 =?utf-8?B?VzNWT0dtWnBqNDlkYTdSdWxudFBId2hzK2Vac0poZ0VTUzh1ajBhNzcrd1Jy?=
 =?utf-8?B?SGtWbU4xNHFSckVGOWpXREY1dDhlallqRGNlOFZzNjVrY2EzcXNIMm0vMjZE?=
 =?utf-8?B?bHpJL1ZWazJNSWxsU0VDQzkzcnRKNzVKcVZzeTlpTkUwc2lVUnVmRkh2Zjlp?=
 =?utf-8?B?S0dyeUtMTXpTUjNoQ2NWWmpkVG5ocFprVEt5NWFnVDNEbWpDZ2d6bmRRRjI0?=
 =?utf-8?B?OEJicmxkYUdMMEZwbUEwOE51R0wrRDRmYlhCUnVsS1lZeTVIcDlSVDZFdGxF?=
 =?utf-8?B?Y29lTTZSRXlmSmxwR0o2TnpHYis1dmJaRXA2ZUJMUXNHSENqRGtjTkV5YWRH?=
 =?utf-8?B?bVZLZ1NzT1RNbURSYXdsUXlrTHpGS3VqSDRBdjIrM2pndllqVTQrdEppY21L?=
 =?utf-8?B?UlI3dGZwa0xqbTlKZ1U1MVNyMkpxUUlzaGRXbWVFZnBhOGw3MzQwUGFyOG8z?=
 =?utf-8?B?azk2TExsWnBPam13UkNDeE0vbVRxbjFpR2s5cjFzSEVsa1hYWGw5YXlTb1dI?=
 =?utf-8?B?OUJXdU5zdmJoRjRkRFhQOTFyZ1NTdVRZTFNDUGFUU3dubnZodmhTUUtpTGJw?=
 =?utf-8?B?TzZtY2dtOHhGYWtnVjZUTTNFT0ozbkNtOHpadkNlVnNycGhGYjJGb0xET0Y0?=
 =?utf-8?B?U3l6elRmNnAyWkNOM29Qbmg1cjA5YXlzSGJxZ3A5WTZUOTh3bmRYOHB2R1FW?=
 =?utf-8?B?b3hpODV4Qnk4NE0yVncrVWNTSEQxa0krVGNaVWF0bnd2bi84dFhWMHZtK1I4?=
 =?utf-8?B?Z25MaG11YTV5VmtTa0VXK2VHM2pSVkppcjZONDhTd29BZTRCMXl2eURHQ3ZJ?=
 =?utf-8?B?UmNkOXczQ3hQRTFNWGhwWndpYld1cWxkcFVZMUNwL0ZUYVVQdDlTY2tjODJ5?=
 =?utf-8?B?RlJpNmMzN2lYY3dtZ3NpeGtvVmM2TVhOd3FKanZzeWJBb1FYN25FeThSaG4z?=
 =?utf-8?B?Mjhuc1pieDFiK0Zwbkt6Qlc3OW4vQjJ5RkJmR3FSNnFWelYyRmZtRW9JOXA0?=
 =?utf-8?B?bEUvM04vNzhhUUl1TURqeE5XR3I0aEl5UjVIL0Q4OUk4Q0JBdmVraGZ3bTQy?=
 =?utf-8?B?VmFQQnBQRmRVUUVLSnlvOGl2OUJoMnVFQ0pqbm1KN3Rnekp1SysrZzhpOElr?=
 =?utf-8?B?b04yZ1ZhR2o2clphR2FiczdsVnZyUURmdytVR3pFVTUraDkzMmJjTElWNk5h?=
 =?utf-8?B?VTlnSmpWVVNwa0hxY2pQb215KzVVTTg5TGFmMUlSamNsVFhVRThGYWNJMDN0?=
 =?utf-8?B?SlFhRHVQcTFocmh5UThkbGQraFRSYldjdWtlKzdmRjV6VW9yZng5OStDMU5M?=
 =?utf-8?B?UG5yUG9IWjZUdC9uYUNrekxVMXFtT3BMbXZyK3g1TlV1VzdFclpGM3ltQXBK?=
 =?utf-8?B?V3FQYUsvYUM2RlFHdlUyQlBOQTMzek1HQnlGNFgyWGNDNnJMQ29iZUNEOWdJ?=
 =?utf-8?B?dkVNMTQ4SVRmYmc1cU5iVHo4bzN0WjczQkRweDFtaSt0MDkyRTlOYVJHZUlu?=
 =?utf-8?B?OXVaaXJRWFY3dkF5OWltS2MyeG9BZzVndDlKcUdzOFExcm1pbWVLVHZ3MFov?=
 =?utf-8?B?VWx4WmJLR3dxVEp1YnZXTVlkNWpsNlBmOGZoN2xhbnIrY1hTeHczbEgza0dS?=
 =?utf-8?B?WFlSK1NOdS95eXgwSHBIZTNURjQ4ZDlQdStybkNlb2ZFTmFoQ3NNNXpIOWJz?=
 =?utf-8?B?dE5ZNEVGdE5nWlhFcXQzc2FkcjAvSHJtSE10NUtqVUl0aWVOVTFkQzAwMEgv?=
 =?utf-8?B?SkQybm1wZm5jOGZEaVNZNW02U21ENzBqZ1dLZ3UzUmhscXRHTTFOcjVMdUxw?=
 =?utf-8?B?TW9pL2dGREhKZHRMWHRVU0ZaM0dGRWxvcS9HTmRWcGJRWVlJalpNaFZVNWVy?=
 =?utf-8?B?a0xJdzkvS3J2S0s5bmZTUEVXTUtEMHUwRWdYWVpmUkJjelNyd0JUQUQrM1Uz?=
 =?utf-8?B?aTN6QUFtbDJMUE5tQVpsWlBtQkQ1MmJwT1JMM0hJcXhkeTBuc0RJRFFFZlRG?=
 =?utf-8?B?WEM0azNudkdtVVkxTUxBSDJQaGRmNTZZY0ZuSVJYMnBRU293Mnp1NkVZUytm?=
 =?utf-8?Q?nd7zn5Iz6CZ58A/QjL4DNZqlw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BDDD355308FD746B80E65EB3CEB978C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YXghmc23tkkgeHN8ZxalwQ/yffsrHKjyDgSZK9SPb/V7jvfzbE6LtJoPc5rhNNAV7Rq/yFOgPOdPqV8fFTFgPLg4eqvDC1/uXVT4iB8m1UyCLBo5a2yisx/hHCHFcYSOcMDVXOHjLpfwmcZ8PEsOzPJlL+0liLaUVLoPXY6dXBoOF+S6nBEvr1qyoEVRANcYRw7+UazqPAT2v0eCTVnQIBRNTAcbgCJOZoJyGNrnD8gz21LIF33XMgjejcI99ZO39yPwdohTrNoUp1M8sLkYmGSidjUNzG4QqoA2nyWTHT2JANncE63GgdHUOYsAfDXdwaa5V/8xlLI92lozjq1msfhvEpLWztt8N7F9eeOdD0b96nLzNYN1FynbQCmEb6an/UlNZT15tA9gJV9ODS7Pq+hNP08pMGw0nFhc2NxM7cclsSNwi9l7wMoNdULIhr7Vq+0aXVzt82VKmicVz/Ke10j33N2G78JvaGRCnPk3VIl6wJprQ0AqVDfuSaO/6P0QM/5kh0gyYpCxmszDOuK3rZogujRCLdVO6mQQHIQHKaRyLkYdyQ6rPUAf/7KMnxjsDcSKMXKG/HhtBJ22wv/kOwxMJ7pF3n+mghZzWkPf1oZgycLL7rufhmAW8mRBE/dsTqnLHDDIxYfGzj4pHHRu5Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0212e4-dd91-4a00-b85c-08dc2901a64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 23:57:04.1468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvtDan6rwfbqIFWubXllCofacjjQgebcPFY6VcOl0Vxwfab1+mtqxh8iosr4xNfs0wF4vIzQk+e1ZpwH8OARVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Proofpoint-ORIG-GUID: lEO08dVhkfEkANqe4cEKRZ_dYwlozLFX
X-Proofpoint-GUID: lEO08dVhkfEkANqe4cEKRZ_dYwlozLFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=764 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080137

T24gV2VkLCBKYW4gMzEsIDIwMjQsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoZSBpb3JlbWFw
KCkgZnVuY3Rpb24gZG9lc24ndCByZXR1cm4gZXJyb3IgcG9pbnRlcnMsIGl0IHJldHVybnMgTlVM
TCBvbg0KPiBlcnJvci4gIFVwZGF0ZSB0aGUgY2hlY2suDQo+IA0KPiBGaXhlczogMmQyYTMzNDk1
MjFkICgidXNiOiBkd2MzOiBBZGQgd29ya2Fyb3VuZCBmb3IgaG9zdCBtb2RlIFZCVVMgZ2xpdGNo
IHdoZW4gYm9vdCIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50
ZXJAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2hvc3QuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9o
b3N0LmMNCj4gaW5kZXggYWUxODliN2E0ZjhiLi40ZTYyMzlkM2EwYWMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5j
DQo+IEBAIC0zNSw3ICszNSw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfcG93ZXJfb2ZmX2FsbF9yb290
aHViX3BvcnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJLyogeGhjaSByZWdzIGlzIG5vdCBtYXBw
ZWQgeWV0LCBkbyBpdCB0ZW1wZXJhcnkgaGVyZSAqLw0KPiAgCWlmIChkd2MtPnhoY2lfcmVzb3Vy
Y2VzWzBdLnN0YXJ0KSB7DQo+ICAJCXhoY2lfcmVncyA9IGlvcmVtYXAoZHdjLT54aGNpX3Jlc291
cmNlc1swXS5zdGFydCwgRFdDM19YSENJX1JFR1NfRU5EKTsNCj4gLQkJaWYgKElTX0VSUih4aGNp
X3JlZ3MpKSB7DQo+ICsJCWlmICgheGhjaV9yZWdzKSB7DQo+ICAJCQlkZXZfZXJyKGR3Yy0+ZGV2
LCAiRmFpbGVkIHRvIGlvcmVtYXAgeGhjaV9yZWdzXG4iKTsNCj4gIAkJCXJldHVybjsNCj4gIAkJ
fQ0KPiAtLSANCj4gMi40My4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGluaA==

