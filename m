Return-Path: <linux-kernel+bounces-79356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DB862125
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381231F27082
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E601367;
	Sat, 24 Feb 2024 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="r6bCYDbp";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gPHKNDwQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OYnIVzbV"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03406639;
	Sat, 24 Feb 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734090; cv=fail; b=pWJpZ47DnOHHPrc33ptofpUcy1mgIqUegH+UYUEABn41sZQDzS4dbh7ARLuYVa4W6bD42LYk9rwYYsnvHqg1298Y0nZnyxz+oZXm8lsRJK2bKMxRcCwx3VLFlptKCue+FyMI/SNapGg8W1hgPtFIHsyoMKC/kB4sZFKdVsnm0C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734090; c=relaxed/simple;
	bh=X1va+nW5J/I0Ek0LgZebcd6rh3zjG/S9G68qYGLgF9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmomiaJMWj4xACySN8jnUkwJ90ztqVCVE6gyxUNe7qLWXGVXtHWR1bqOTBz8O+EGOCQdlc2DMkm1a6GYqTvT3wcQh7tJBGbCB63emExzshhU6eXCIrpMavv+/gqeRQCpJ3b2/iCLAjjwogGRAAPCjcJnOzx9IAL+m454LFCzjTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=r6bCYDbp; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gPHKNDwQ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OYnIVzbV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjWhr019048;
	Fri, 23 Feb 2024 14:18:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=X1va+nW5J/I0Ek0LgZebcd6rh3zjG/S9G68qYGLgF9I=; b=
	r6bCYDbptUyEkoBjQz3icojqfzNaiOb2+bU0JkjS8oNtfTvuSpSiLO2caXr9taBw
	iwaxDKTaY6JQ5e2Eso3NSFhoi5211f/zm5CpZX1LNyqq/8si70a6KkH08pKUko/h
	e9a+567hfXvqg0Yxl9R96vQCeT+2u/sreyJp17OpT/k45t000W0W2JQV1HJqbSLk
	cfmr7Pz9oAif49iadc2W95AlQlnq68okL9I4cd5sDtpqBlslWPZvnY0xomC7arVL
	TwHlEIvcQjBbUhBYGUQOxMzjwqAPwF70Vf/Gqnoq3wTf7FDmhepC+Csg08ZRm0TN
	LfZai/G0dOf7WNvJsoo8WA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd20wgwfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708726687; bh=X1va+nW5J/I0Ek0LgZebcd6rh3zjG/S9G68qYGLgF9I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gPHKNDwQWVY84+wJL7f/dFNFe8VH1RXQwF2IwrnytoQvAIWJ5COzr5jgkaaE542yr
	 mg5xFMOaHRGWvYyRpP7b2GVp+bm6akiGwoCfVRIL0Ela/AQmLisoFZq/9m7LobZ0j8
	 368TsUQR5eSsnfOUca800FKX7BdRRUX3FW/kLqVHnM3WK49o2Jron0GHgyTf1uJ2AB
	 zxOX4evbN1Xk/2nE27lKVZx6kre1xTrM6QiRO+U4jRoLcUH8Pdddr5HZaqC9FhlGmD
	 OZx/3j5ry3wJpLB7bZQn6pH5dBDJ/OkV2S0AFg+q+/e70s/DxFmJ9ye7WBWD2gxxY3
	 E5HHBJMfmc/Hw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 750184035A;
	Fri, 23 Feb 2024 22:18:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0AF97A008A;
	Fri, 23 Feb 2024 22:18:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OYnIVzbV;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B03E4044C;
	Fri, 23 Feb 2024 22:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeXThJ22bdYDMqpe7YfQZty178/u+eOhbcbyAf4MnBnjWqZGAWCYP4aNvGgGL/q4DVdgIsyzStfkwuHZXXDR1Pnk//IemlxbKbDN0sYQvwi98pGRzwoqlF9z4IhfmlHezFtDNnU5ZZzYdlc2Ze9SvXRVepWTiDNB1/shsjJmtFyydgklY7+auv/9+tn5JQlL4LHcqNfCOWYCMU4P+AHraRJ9pDlZtbMWJMccqvDq7D0ka8OEnTxZPpP2DJvcwEQ/dNONFkH+W2yVj61VhmcpkUdmkLuxaRdH+Smj4pa75txdlcaYilFNvpe5PlW9oAzPneV9fVhJsNgMJDVE1Sk3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1va+nW5J/I0Ek0LgZebcd6rh3zjG/S9G68qYGLgF9I=;
 b=bfE/TN1ZogD7PtpVOQulL4ZjHxMxDhHsUN0RbLqwoTt/m/6k9nXh7TQiVfTgamAqtXVy5afpe4q+t1cXCWQ5CNtV7D5o6cx931tCXsniLlxCQoJVTXSubtEddqihCGagnkwDDAL4Qqi6nmYT1xKD6wEtZiwEVGJSpsdXL3MflBq14bYhWCoAymD0dbpRQs3wkQ+uPWNkiH89KVpVd+vkkuYxZeQruPSymavg42lLvhegrCAccRbAbUENl1r64ksChZSvqQTLURteloLjWpsvD8UJNmein3z4JaEPUvfwZMvpmAOWk18bte0Nd8/XeEQKTIOSeqC9490hpwJy22WF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1va+nW5J/I0Ek0LgZebcd6rh3zjG/S9G68qYGLgF9I=;
 b=OYnIVzbVXOGuyvEFhDn+ralPMJUojrjszAb9pYsWWy2bc9NvscOlxQS+JnTugWQBwN+8ZfAuLRcIoJ9F4mB6q1TFj1DCdB1Lfo5LlpYOkBZFJo81/ZhLJyMNSuXOaJds4zmxDLyY+vby/hj4D+fpRyC6KHj+FwIZ6vISy1Ppj+w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 22:17:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:17:58 +0000
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
Subject: Re: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Thread-Topic: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Thread-Index: AQHaXyr9Oy4g0cdOPUmwSElfX7s6GrEYjfiA
Date: Fri, 23 Feb 2024 22:17:58 +0000
Message-ID: <20240223221757.ugoyugtdokcxzci7@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
In-Reply-To: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL3PR12MB6377:EE_
x-ms-office365-filtering-correlation-id: b9177d64-cd4a-40a9-cecc-08dc34bd4aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iC97TYAWcGqdi7arPP30SX3555zesddeZ9PW8lbBCkoDKpsA0ZYAIZXXVIYAVS00Dh98Byndh5dGj5PIwht+oriTK3H9bGCnwL485nqPwHhzF1PUzBqoNQ6JgXk1jF9rSgLFm5aOQaORdw3i4i1kqWTCiEE4hybqbfKHfRyGc6NzsmQWm7AV0rfuusAoWEYsTeiJG4rzY6BoPIr/IsQknKyp/J4ndtIoX3R8xYHxBYMlInkNj0Qxbp4JSfyvwTvgq+lNmCmWnWLVuU6PHy9YdQjbt9BmJgET7reLV529zyhXndcYpwLx3bQAvACUrwPDmu0QkdDyt9cRv1nV4bkCc4UaghLCYOofcZO7QAbfcM8Pw3LBXYyZWyfpogo9GBHWJEViSIImlrQT36xRdjHXzK4EHP9WGCfc+Pkut94G9WHlzdgE6lWm2a5lmWvybhTHBP8UQCY04AX3Jlbzt6EyyrMm1KKStxbIpqL4G7QdpH3fKUv3WC9gv/dOBkd2Q9HOCJTuHXLlPojdV6mtbMrroP3qR8Su2UfWNNY6c+cIwmfm0jWJzicsKyIjIXOyMiQf97R9oYDz23Y9XAKtdnMPMJWVIkGJY+cZiHTVvRTO5kE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OVlIK3NLelljdEtjZHBOWG85U0dCUHpQQStIZXo4QVJ5dFFJL1g4TnBVcmVQ?=
 =?utf-8?B?bVJBNGtLckYzN0poQy9VRzJ0UDVJQlF2V2lXeXdRVHBqT3JJdnBUczZ0Yith?=
 =?utf-8?B?MVVzNU1SNEtFZUNEdlQ1a1E3UVEyeHdEeFNyV0YrSk1BMWJDa1BnbWh2YlY2?=
 =?utf-8?B?Skc0NS9hdTRYMVlxZmdBZzB2alcxc3lsZWJqRCt3dGRNbk45RUdMSGhxSkpO?=
 =?utf-8?B?NkpocFF4WEpxcHBFRUhKaHcwb2MyZExPMXVJb1ZIY2V0Tk9xYlRFdlZkRTN4?=
 =?utf-8?B?K3VRMEltbzArclQzc0k3TUN0bFVRUUduc0tvdnNGYUdoeXFheTNpb2NUcHc4?=
 =?utf-8?B?ZUpyUUNKZC9OS2dXZkZmemlCQjB0bWpTdXhvVGxuSXNYVUNKcTZWSHJqalBp?=
 =?utf-8?B?TlAwbmlGZVI3aVdFSWNINlkyM2R6Y1Qva21sdUtCMGpOeWRFU3lBbW04cGJU?=
 =?utf-8?B?aW42dmtyUmptd1VRSnZrTWF3aEhkSlZxMU5WeEhaM21iVHlqc1UwNGZEQkdQ?=
 =?utf-8?B?V3Nxem5QdnkxZTRTZEFVcSs0cW1DNGhBQWk0MTdtL1hNcDdMSlRvUFBVbTJH?=
 =?utf-8?B?eVVxb3lreUpjelcxbTdpQldlMWJEamU5WjFXcjNYSk5wWElSd0sya01BOUwz?=
 =?utf-8?B?ZGR4bG5tUTNxUXJ2dWtpWFJadkoxcEt5c0hxZWJjY3gwOHVpMXpKeUJidEZ2?=
 =?utf-8?B?V25vNEkwUlZmeTMrMU92Z1RyczJIN1Zybm9HZlVzZC9CNGtWRXhwaGVQL1JQ?=
 =?utf-8?B?NU9XTDNuS21OYkx6U1l3TjVlS2VBQk9xVDNPL1BXYUlEbWhGSUpha2V6MWpv?=
 =?utf-8?B?YTl5WkpONFg2OUpvQVlqZmU5cjVOWDNmYmM1R2s5blZQL0d0cTFZOTY3THdh?=
 =?utf-8?B?d0VmcE8wWVJRRDFtV1JWbktUUk4rWXdJc0tiQ1JGYzV1dG1tZEFUcUswYUJU?=
 =?utf-8?B?SVc4NHhjY0kzSTI2bm95K1dJL2tUOVVyZ1FqTXlzYjlncTJySVBESDVCQlo4?=
 =?utf-8?B?d0NVcnFBcGJNNlVGdFh4N3NjVjBSN05TK094anppYmltU1JpQ3FCQnpraW0r?=
 =?utf-8?B?eEc4clJwMlp3eHJ2K20wWmxQVUZzZXQyL05RQlFZcDBFQ2ViZU1lbkl5b2dx?=
 =?utf-8?B?L2pIdVluemtjUkJvYkVhb2V4YVhuTk5sSGZtRFNMSi9CTlhJTUw3MGJDcnRR?=
 =?utf-8?B?bDEzdFVSSkhRQTducVE2eUVLZHF2Mm1YZXpkcVE0MElyMDUwQlI2TmNjRDVk?=
 =?utf-8?B?SEFDY3hNL0VCNStpeG9xeHpHTkxyTWRRMlBMUS9CbTQ0eE9EdmVOTldETHp1?=
 =?utf-8?B?WFUxVGttRE5Lbm1lNFYvSGFNNlM0c3VKVG10bWt3bjY5bzFGeHdlaXZnM3hk?=
 =?utf-8?B?QnROVWNUYUFzOXZZNFdoeWhoc0hhdG5xSHZUbFhkMG5LMUNleWhYbFBOQXd6?=
 =?utf-8?B?blRlZlJNeElLMzFkS2U3T2tWVkJJZ0UwbUpibEtBbUEwcmFFYVM4NzFuZjR2?=
 =?utf-8?B?MXFTS2tERHpEM2xCR0pUcTdvbE9FMW8wZTZNcCtxOUhqcXU0VVJKNXJCVitp?=
 =?utf-8?B?RC9BeXVmT0YzSS9kT1BBVzF3TFpucWhUS3A5TTBXZi83R0laT3c4RFZPNW5v?=
 =?utf-8?B?NmdNL2NyczV5U2JuTzNVLzJQVmVDR0pTMkszMXB1aEV3MmZNQXEzenNFaUk5?=
 =?utf-8?B?NFQ3TDhrNm5HSmRoVXgzbHlQZEJ4anFsdWJaT0xVenVJTWIzTDYrcWUzU0kw?=
 =?utf-8?B?ME8rbElibnZoQXZqUTZ0VjZQQTk3dWRTT3U1TUFxKzk0U2dNMzFJeWFmTlpF?=
 =?utf-8?B?eUdMZEY1VFdxMHdVZGlmdDAwT2h4QnhVKzI4RGlRZk5ZNG5oUmVIbTdjTkF6?=
 =?utf-8?B?Ui93RkRwQ28rUFI0Z0ROU1ZNcnR0OHg4WDVWdWFxQ3IxaTEvSi82V0tDZ3pL?=
 =?utf-8?B?WWQxb3hoQ2JBNzFCRUdGekhTY1RrcnFiMWZUK3EyQTU1Zkw3eEJJRDBQTDM2?=
 =?utf-8?B?SS9veW5SZWthSFlNSFVmY1VDV2pDVTlHVzBQU2l6SFhIcGNYR3JpUStFbmhs?=
 =?utf-8?B?S1JkUlluZ1VyRjhPNGxJTnpCRVh3b2daS3Ercktsd2lyQ0UvOThEUVlzbUNI?=
 =?utf-8?Q?ezwW5c8AhG7Ja0D6oKl0tVxOF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E8849A4669BD843B275E38C485DCC93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xgKLR3Otheceql8TjCAa2/CzKkKDxMQMhH5RGGcqk8YFy63/Dy4LMNjd+QksXzkCQZINPE2dgJp8RynWX8a8ByYOYPANGRPPxiKlEr42u1HtKQzuWtnMuyxCXAG7d3b8vnl2g6iok4LizDwt6/5uduYSshNuMa4LvIO72WMplYyUv6rzKZKjW+ZnFlf/II8Rm5he++Ryf4sfYLqSXDIWLehSBsPSbWJcf+3x4ON+yF+AGvBlxPNAsbirrq+LD7mEdN+iHZc7hEbnDyxzrtILQtZdAxqN1FGcAuaIC6+r184sU81qmYb/M2OFCwQipfj+LLy3vC/DFi4e1/OUQyTGEM8gy/7nJzHMkaC9z+RhI/fODy3rLgg5NjqQpSpIYbuUXOvYuRdmzOXypt/0BeDW/5P8N2+jwX3TmCyjkjziQWMfPzSwLqWeB26nIcTtsIWx7RJIx0KU8yP5Ex0aM4f2yfmx3bNPN5s7RJIEdUIP9axLK0Z9dWbU80YutBELkrl72DsMmD5BUvLgzkBIJqYriTxLsfXdW/ZebjU+LpDUrXlSd8o6XeBcHUg1ZRJm2O7Lb6RDO4/S9DNfvNSjulM06IGhzO1GcnW2NUqU55hdOOw53D5hzZg50heXvHXIi2HhbyVm8T6ziUvi32+4wuf65w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9177d64-cd4a-40a9-cecc-08dc34bd4aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:17:58.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGI0CQN9jXU1+wVKWIVnTIKBx6TzK8yGZ65SN64KPI4FbAJYbY4d/C4JNL1GKzZFmt6EACX7eB/mO3Ef7va9kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
X-Proofpoint-ORIG-GUID: QuvO0sEWsSlVWtaHNzSEqA4fwoA8BgO4
X-Proofpoint-GUID: QuvO0sEWsSlVWtaHNzSEqA4fwoA8BgO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230160

T24gV2VkLCBGZWIgMTQsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEFzIHJ1bnRpbWUg
UE0gaXMgZW5hYmxlZCwgdGhlIG1vZHVsZSBjYW4gYmUgcnVudGltZQ0KPiBzdXNwZW5kZWQgd2hl
biAucmVtb3ZlKCkgaXMgY2FsbGVkLg0KPiANCj4gRG8gYSBwbV9ydW50aW1lX2dldF9zeW5jKCkg
dG8gbWFrZSBzdXJlIG1vZHVsZSBpcyBhY3RpdmUNCj4gYmVmb3JlIGRvaW5nIGFueSByZWdpc3Rl
ciBvcGVyYXRpb25zLg0KPiANCj4gRG9pbmcgYSBwbV9ydW50aW1lX3B1dF9zeW5jKCkgc2hvdWxk
IGRpc2FibGUgdGhlIHJlZmNsaw0KPiBzbyBubyBuZWVkIHRvIGRpc2FibGUgaXQgYWdhaW4uDQo+
IA0KPiBGaXhlcyB0aGUgYmVsb3cgd2FybmluZyBhdCBtb2R1bGUgcmVtb3ZlbC4NCj4gDQo+IFsg
ICAzOS43MDUzMTBdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAg
MzkuNzEwMDA0XSBjbGs6MTYyOjMgYWxyZWFkeSBkaXNhYmxlZA0KPiBbICAgMzkuNzEzOTQxXSBX
QVJOSU5HOiBDUFU6IDAgUElEOiA5MjEgYXQgZHJpdmVycy9jbGsvY2xrLmM6MTA5MCBjbGtfY29y
ZV9kaXNhYmxlKzB4YjAvMHhiOA0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBDaGFuZ2Vsb2c6DQo+IA0KPiB2Mzogbm8gY2hh
bmdlDQo+IA0KPiB2Mjogbm8gY2hhbmdlDQo+IAlodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjA1MTQxMjIxLjU2MDc2LTMtcm9nZXJx
QGtlcm5lbC5vcmcvX187ISFBNEYyUjlHX3BnIWI3XzN2bUpwTkxPRnkzZ193RXhNUVNBemk5NDlP
NFBvSUQzZTRyTkV2QXNiZ0N2eHhrajBEaVNERkp4Rjc4NTdEWk03cXk5RE1rSDZRNUJQRC1qWCQg
DQo+IA0KPiB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI0MDIwMTEyMTIyMC41NTIzLTMtcm9nZXJxQGtlcm5lbC5vcmcvX187ISFB
NEYyUjlHX3BnIWI3XzN2bUpwTkxPRnkzZ193RXhNUVNBemk5NDlPNFBvSUQzZTRyTkV2QXNiZ0N2
eHhrajBEaVNERkp4Rjc4NTdEWk03cXk5RE1rSDZRMUNjaXlsRSQgDQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gaW5k
ZXggMWJmYzllNjc2MTRmLi42MDBiYTljZmVmZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1hbTYyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYw0K
PiBAQCAtMjczLDYgKzI3MywxMSBAQCBzdGF0aWMgdm9pZCBkd2MzX3RpX3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0cnVjdCBkd2MzX2FtNjIgKmFtNjIgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gIAl1MzIgcmVnOw0KPiAgDQo+ICsJcG1fcnVudGlt
ZV9nZXRfc3luYyhkZXYpOw0KPiArDQo+ICsJZGV2aWNlX3dha2V1cF9kaXNhYmxlKGRldik7DQo+
ICsJZGV2aWNlX3NldF93YWtldXBfY2FwYWJsZShkZXYsIGZhbHNlKTsNCj4gKw0KDQpXZSBoYXZl
IGEgbW9yZSBjb252ZW5pZW50IGZ1bmN0aW9uIHRvIGVuYWJsZS9kaXNhYmxlIHRoaXMNCihkZXZp
Y2VfaW5pdF93YWtldXAoKSkgaWYgeW91IGV2ZXIgd2FudCB0byBjbGVhbnVwIHRoZSBkcml2ZXIg
bGF0ZXIuDQoNCj4gIAlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+ICANCj4gIAkvKiBD
bGVhciBtb2RlIHZhbGlkIGJpdCAqLw0KPiBAQCAtMjgxLDcgKzI4Niw2IEBAIHN0YXRpYyB2b2lk
IGR3YzNfdGlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJZHdjM190
aV93cml0ZWwoYW02MiwgVVNCU1NfTU9ERV9DT05UUk9MLCByZWcpOw0KPiAgDQo+ICAJcG1fcnVu
dGltZV9wdXRfc3luYyhkZXYpOw0KPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShhbTYyLT51c2Iy
X3JlZmNsayk7DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICAJcG1fcnVudGltZV9z
ZXRfc3VzcGVuZGVkKGRldik7DQo+ICB9DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3Ms
DQpUaGluaA==

