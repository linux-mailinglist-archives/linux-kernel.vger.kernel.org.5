Return-Path: <linux-kernel+bounces-136063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A889CFA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732421F22736
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735979FD;
	Tue,  9 Apr 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QL0IO45l";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gS2CsWZL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D4QSKiG6"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664A23A6;
	Tue,  9 Apr 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625078; cv=fail; b=FU1qkGYQvuZSlbg4JGTkEz75E9qZPaKl0/kzPUFmXeSQhW/DaD8hhHbTLwIPIJM7vk4fAPgZPCK1vhVVDGx6QYFBIncdNEGWOio9sDrOFFIk4y0Z2W2jqAg8+HlDsigM0z9Ih6NEa8AifQODg2HHvq/G8Zf/d7m2TzFFX2v0dWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625078; c=relaxed/simple;
	bh=JiWa/a0DTJFFfpjzfZytOo5mEPt85SxmrmGC7HoHRrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iK/TWS5G4dH7RT0IVsS0K3nFV6U8p4Jy+VGYYXfi5vBtCQzjETaIQPCehuaI27f9O459qhXUrU79zbETSaT0nr+hA7X4HgF/1MK4vMai5z3GAiJ/4+lb/NmnyYA+gFJhJ0DVh6ePJldeXCw6Gm+uw6xQoCuzdJptW54Rq7rkRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QL0IO45l; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gS2CsWZL; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D4QSKiG6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LA0iq016443;
	Mon, 8 Apr 2024 18:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=JiWa/a0DTJFFfpjzfZytOo5mEPt85SxmrmGC7HoHRrU=; b=
	QL0IO45lCnt8zQ4PQvjdsFS173DIFjv+mLpLuF+efOK8JNEvmTyjLlI/m01GIznS
	UGlXxkwCgjOlMzbptrgvlPvPjh5WSbINpso7IrTVinjbw27JIEApUUmmBTk6ZcpT
	ONUvJJ0CzS08CFXteuSjuJSrD3oudCBc5YX5Je9oh2TUgL0id0rPklAG4hhP2CU1
	A8D0oTQhBE/vHtjDiHWLa5Ra8kdV4WmQYcwyX5B6eABI5YLs/1AbsTQfPJNzXqa/
	/btoI6jPmk2acNBpm6ScUbH7IYcp5uGeKSWCZuCeCYze1Y7iA271d1svg8uCHOZf
	NLj26hDhU84UK/TB0vA4+w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5djqd09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712625068; bh=JiWa/a0DTJFFfpjzfZytOo5mEPt85SxmrmGC7HoHRrU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gS2CsWZLhqNEuzstyETWIAV8rwC6SxLrpbvABf8fYpkYsrwNHZsv8pnld+7I3hA8D
	 QOUpJ3HDRiBuA4GMcoiBYTyOplZ5L2XlYU/Tnq6+0bmM4HY8CSqvobw7UVK6fgV/6u
	 A78lFdhKdNFsW4ac4MgkOqFIRdjx65FjLtIJ8IYlDf4HF2QNVkEiIBdgaFTzR4eZse
	 XaijfppDRn/Rki5q9QA0EzAyz7LtU5sUnYbejxwT807qKWgvw813zUApLWTATIp07M
	 w7G/Gc2xibd1pkMfX/VkciIOyp8Wr07WJ775a8/B2OA4kytkBm4iXzoPaAZ2P96Znd
	 vHz8A5avqAgNw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60AC0404D1;
	Tue,  9 Apr 2024 01:11:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 089B3A006A;
	Tue,  9 Apr 2024 01:11:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=D4QSKiG6;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 940C14013F;
	Tue,  9 Apr 2024 01:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d97epn/xn8NCNzwLFfgyp+v0bG/vKEwbCpNfJ9+ZQwBPh/iXHjwWm2FtkdEfGdNPOSgKXm5gOMwHjFfsrkhYX5Pe/WqCWf0TdBvHJeFqAPZlroNNUxXF/irttJ+8+A39aZWZuGejWhIMC3jA/pepyUfTCrAlGnGtwvijKB9pQzSyugbxh5cPolBlg3kX/n6Ue5ueR6X1Le7idsb5VA5bK5WHrvvB4I52gBzXhtDcIRqrsI5HmugLJO7BiEzOFFcfP/IWm9svUfn7MyLFKey5suTNFDjUjHVkshHsWXpU/TO074B42W+fPv82ad9v1yMtRELhz57xQaINPAkWOR+mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiWa/a0DTJFFfpjzfZytOo5mEPt85SxmrmGC7HoHRrU=;
 b=GJIHTa1wDtfswhVZz1pa2CT590xk5tm6tLcWoLhp3d8jSzlFwT2/XjJT9TEFFditPciGR8pavEg0KarlaUSquMOTBUEQ8P8/KiwNEz3euk/9z1mkikI6K0xqmaOrYCt5E4Zlwxt+OzUboPagBom7uaB7WjDWqqoZQr4giNXslZ7h2MpdrBl12YuechwVWecRRVtumlZ26aZ9s4YAmqMGn+Tzdtm3WdSiC7wlgdYROGiS4eWHInWevTtUACl6ySaWDOWMaeOd+v0g+luNeO/cvheO4ZmxRLZs7ur/UOYn1wG2LZN1QlMf93utIkJhE/nhl0tcyFVr8hzXFSUz5q80Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiWa/a0DTJFFfpjzfZytOo5mEPt85SxmrmGC7HoHRrU=;
 b=D4QSKiG6OOFx+UNJfw5llsSIesXGhnAuPs+MteZox8u4cYxPZa+3HV921glNrJVJ4dFo94lS0pdIPO78muZEmf/DXSnLW/J3P2QaVc/7nC05kC9GjjJxPy2UN+SOMJqWTdjXTbu2vJfdJsHWgDU/HKjoJbm3GexDbpFDO3zpv9g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:11:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:11:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [PATCH v20 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHaibjrQsWFlN8oQ0+zdNhqnOxOLbFfIg4A
Date: Tue, 9 Apr 2024 01:11:01 +0000
Message-ID: <20240409011046.zgjqvhewldch3snu@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-5-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-5-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OpQ1fL7CsMYN7nbHPDhIElsF3q0Ago5KVryVMJTXMpWlcHY7s5AbkrkhvVlL76j43T7zytlzSoL4TSP0HpgVsW5E4TjnV4o7N1t7DesurUFvYvConGCCCxfeIwBrF5PEbp+MsmAqQdcsPBwjDH9gW5voN5/vKnd9hXbYrFD2PefMZ/6Jphg7x77F/yaq6FO2cZMLk1l8wU/jQYnujCSQwEUtWyPxWs6luM88/wo4dOcIeLiMJyHCUQ98E7NBUjlMgpgRkEGt/cSTJ1JS6/mrSxEapIN+sqpuZkNKwW94gJXtn4LDqEH+VVxj6X39JrKfuFJa6kLIjtguB7hZLEhcPTy1KzQQZYVNvWgIi/v448PgAHeVOLw2cVcnCXf8fnqlFwyv6QkUmV3OiVrvF1n3yWYgwgYAyaweczbYKncrVVxizvUbx/DXfJrrw7hYcuz6C3yrmppgdNuiLcHeFpMFKjCSt9T7sFFxcfLGYiVn9oAVvIqUUjIrB+dLWkjoRwtBkRdj08b10xQn1DuP7QVEjSp3I/lE3PoiVJe+391ApZhKo2Od09KAHUF7D15EKVkD1P5t2Q7uoF6yG2KltiX02oiasr184P3dG8vC7sXrOYI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bks5NkJUS0NDNlJ2RFlrU3Fka2g3UjUzZDdBOUdRN0xXTUwrOUs5ZFFXWmRS?=
 =?utf-8?B?MXp5MENES2hqVlV1cTA3R2pualZ0QVF5VXNIajlKdFhYVDdWczRCcEFYeFho?=
 =?utf-8?B?TGxaS3YzQlB2V2x5T1UrSmRQWlBMS254dHJSdUF6QUJ4R3ladWxoeU9CeFRB?=
 =?utf-8?B?NUZKWTZVRVQyUC9ZWGNESDZXZElvTEhQem9ZMFFaRVFKdmpjcFV4Y01rMFdR?=
 =?utf-8?B?dm9nTE4zMitDVm9HSGZmUmFpQXBtQ3NBaVJHYUJUWnRuQ0w5QnZzSGdRdUoy?=
 =?utf-8?B?WFJnY2lvWWRDMjFqMjlwRmFvK1hrUHZsK1RZMTUvaHFyaDVQUi9aZnVXU0VL?=
 =?utf-8?B?dkRQbStxT25KMUFGVktxTzhGbm82MjZWbzVpcGs4aDh3aU5ieXZ2QUI5cTEr?=
 =?utf-8?B?cWttUGlpc3FFeWk5UVNveE9yeUFUSUt2UXUyaVRYU0dFbTJVb2RoNU8zMmcv?=
 =?utf-8?B?T1oyODZaanIxYVpLQXJPVUxab0NqcjBiaUo5NzJQR3orMWczaG05elB6d3ZW?=
 =?utf-8?B?akpFdldPZ1NIRjdiL2I4UCtqdG5zK1pxSlk4c1hqczFRc2ZKb0hocEZPdHVD?=
 =?utf-8?B?dFpEWnFqS3FiaVBqQ09CdkFKUWlYRVQ1ODBrVzMxK0JSWVFxM2FhT0ZSV0th?=
 =?utf-8?B?RGpXR1pRYWE4a09CcU5wZWJHS2tPbGN0WFNmQXc1U0ZCb1puaTY1NFQxYTA2?=
 =?utf-8?B?dW82VnQxbFp3dHk1RnhMZ2E1V0VLbjZvMW1lNWxTc09uRnViS2UrRkIyY2R1?=
 =?utf-8?B?OFVCbTljRzFKaGxEaFNBaC85TCtHZE9CZHpIVTBOdHA4TjhYK3NtQ2EzMjkz?=
 =?utf-8?B?WCthS0daT1NVVEtTam1XUWdpZklWcmJ6Y1ovdkVGMWNKM3lhbHhsSDJxQ3hP?=
 =?utf-8?B?MHJnRDNsNWtsbmozY3hES0I1WUVZRWxkRUJORC93ZDFiMFRzdUpPaG9YQ1Rw?=
 =?utf-8?B?NUJMcHRvaWxUYTlRODh1dXhpTExya29mL0xORWxmK1hydTlQdnVSMy90bVlx?=
 =?utf-8?B?UGgzM2dUVUpYUVI3dVpTRXZUN0VjTW5RK2JkZytQUzVxenp2M2NzSWhqSHFh?=
 =?utf-8?B?QkhCNVZvNlhTRzBEV3lDb0IvQlp6SmwxYy9RMFRJT2ltaGtOaDE1c3k4WGxF?=
 =?utf-8?B?cFZjWlI4WTdxZUFhQkViRFN0elFBUVlneUF2NzdFSldBaEVTdSs5ZW8yYnRl?=
 =?utf-8?B?T2VEZVF0TWdEZlhuL2Y3d3VtajJRQ2RYWUR4SHZUWjQ3MjVFckcwZHErTEc2?=
 =?utf-8?B?ZksydVFJOW9mUGhuQ0FZMDlQMDIxUU9wYUNqdXFnVm4wNTBIWnZ5TGF4NWc0?=
 =?utf-8?B?UW9nUmozYy9mTHNpa01hOHV2RUovN21SMXpqeXdKcmdFQUpxeDNMZFVLVnRP?=
 =?utf-8?B?VmFnYmhTSDFJd1ZDbmlNRUhDQ2d5emVwNzcvYXRVS1BhU21yN0tZNmRvdVVu?=
 =?utf-8?B?ZTRrVGsxZENPRTJxOGRMbUd6TGhKTVlnb214ODVoWXdTbzZ2Unl3RkY2NHFm?=
 =?utf-8?B?WW14NVBKd09mLzJweloySDVna0FIdXVoNVJpeW5SL25YVkdmWTVaR3pQbWU1?=
 =?utf-8?B?MFVBeUZMcGpxTmlvYkVCckpmS1QzdkVHSHZOR04zSHk1UVBwVEdhUnFXaDRl?=
 =?utf-8?B?NWlwbGZPblhJdXNRbGIwRUtlSmR1K05pelBMajh4eENKZE9NV0s3UjJmUW95?=
 =?utf-8?B?VmFUT3lLWWE3UkhnaisxeC9PbnYwVWUzT1pRZmM0OUxnOUMydmxIaEtBMXZE?=
 =?utf-8?B?b1F3MVZseGN0NHVzb0FiNVBpV3EwZi9JZXUrc0I2Z2FFT3AzN1BYYTIvSVZC?=
 =?utf-8?B?N1I0UGpoc3ljMU5ybVVkNXF2SmNibjM0T3Q4VnVWUWw0UnFkcGR3WHVCVEkx?=
 =?utf-8?B?aVpzaUlRM3Myd2tqVnlHSm5KWC81V3pQT1F4Sk0xVmIrWmU0blhTU1ZhMWlR?=
 =?utf-8?B?WmVYcTkrMkZ3Z0RCaTVkN3h3WjN0L3IyVUpsR1hvT1ZFWnlUWHpoTHUrMm96?=
 =?utf-8?B?QjQrN2FnVzM2TjRpMGV0QkFBVGZ3OUdGZ0FEbXFBWW05SmsxVG5kc3JMMlVZ?=
 =?utf-8?B?c2g1YjU3YXlvOVpCa0FSbldaSDhXSm5mYXJZMkUwMmM0OCtHNno3dzM5TG5Y?=
 =?utf-8?B?dGcrN1R1MWRhcmdPa0p0V3JEYXl3WG4vL0lGdXNBOEZaN1lsWVNBc2NhV0JR?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F4794EDCF52254890BAEB90E7E3E649@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mCE8KBcGkfOavh6MoawtVDE3G24GwBUT7l0eVlIFgcVo4JIEonSUwYFJaPZXTcnKQNrZj6XKw/CfdGucXHKtaH/bmh9LJifLgo6sopSqffYF+LszLfdGZ4pHLvVl/WNhqGZ/flSrlshBAjG+zOBBbxa85CgT7wDlQ+eoG4ht1dk2cUbxYUGccfq/fQapA9eSJUwGudhE/zjwH0WoVnOc7zT/FTPnisItqWQuSCh741stLgwwXbpCZRQ/9o97ZKZ9EU2AWH6ojHs61zwZGtmzptKeOuurMraWofRAb58NHOPsAIHO8VIpUia7T4U5uo7iWmNXwcWjX2QGquSa+HJASfjh3Wh82oHEvV0w2J/6tKvNhsHVACLy1dc5AQt9hV0bS50niTG+3WyOBNpyTUZaQaoRhpBb5NpWriStdiMW4G6R//sQxwUIGUUKl3R3eqaV+EKLLOy6QOxt15P+HAyF3o0TAHaztA4XnJ2eXyquiF7Q87URIMzV/49X7VodjITbc0cHmVN9gdM6ZsC1vjrSwm7H0N0q+LuUgf4vH9l8xYKsGv64N/czqnqabRZgJpXg+5aI6UEcVC4gRR7y9FZrxMl8Qru8Ur62tLi7Op46chfPzuSZUAFz15+tBMf9+6uumbxhTv2iqVBSCeXUNYQ/bA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c338b0a5-0c46-411e-06f8-08dc5831ebc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:11:01.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jj/Bs9MkTJlYdu8RR+TM5lfNDGueC6xZzNXhETlqLNG59Kw75eKv7MpD7Vpx9dgv0lCz6+sihNWQ/LsiXzdUww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Proofpoint-GUID: PKeU2KkFI07iS54z6jzCzxtjHTnOqhDO
X-Proofpoint-ORIG-GUID: PKeU2KkFI07iS54z6jzCzxtjHTnOqhDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090003

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSB0aGUgRFdDMyBkcml2ZXIgc3VwcG9ydHMgb25seSBzaW5nbGUgcG9ydCBjb250cm9sbGVyDQo+
IHdoaWNoIHJlcXVpcmVzIGF0IGxlYXN0IG9uZSBIUyBQSFkgYW5kIGF0IG1vc3Qgb25lIFNTIFBI
WS4NCj4gDQo+IEJ1dCB0aGUgRFdDMyBVU0IgY29udHJvbGxlciBjYW4gYmUgY29ubmVjdGVkIHRv
IG11bHRpcGxlIHBvcnRzIGFuZA0KPiBlYWNoIHBvcnQgY2FuIGhhdmUgdGhlaXIgb3duIFBIWXMu
IEVhY2ggcG9ydCBvZiB0aGUgbXVsdGlwb3J0DQo+IGNvbnRyb2xsZXIgY2FuIGVpdGhlciBiZSBI
UytTUyBjYXBhYmxlIG9yIEhTIG9ubHkgY2FwYWJsZQ0KPiBQcm9wZXIgcXVhbnRpZmljYXRpb24g
b2YgdGhlbSBpcyByZXF1aXJlZCB0byBtb2RpZnkgR1VTQjJQSFlDRkcNCj4gYW5kIEdVU0IzUElQ
RUNUTCByZWdpc3RlcnMgYXBwcm9wcmlhdGVseS4NCj4gDQo+IEFkZCBzdXBwb3J0IGZvciBkZXRl
Y3RpbmcsIG9idGFpbmluZyBhbmQgY29uZmlndXJpbmcgUEhZcyBzdXBwb3J0ZWQNCj4gYnkgYSBt
dWx0aXBvcnQgY29udHJvbGxlci4gTGltaXQgc3VwcG9ydCB0byBtdWx0aXBvcnQgY29udHJvbGxl
cnMNCj4gd2l0aCB1cCB0byBmb3VyIHBvcnRzIGZvciBub3cgKGUuZy4gYXMgbmVlZGVkIGZvciBT
QzgyODBYUCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2ty
aXNrdXJhQHF1aWNpbmMuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9oYW4gSG92b2xkIDxqb2hhbits
aW5hcm9Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDI1
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaCB8ICAxNCArKy0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHJkLmMgIHwgIDE1
ICsrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOTMgaW5zZXJ0aW9ucygrKSwgODcgZGVsZXRpb25z
KC0pDQo+IA0KDQo8c25pcD4NCg0KPiBAQCAtMTkzNyw2ICsyMDIwLDEwIEBAIHN0YXRpYyBpbnQg
ZHdjM19nZXRfbnVtX3BvcnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAlpb3VubWFwKGJh
c2UpOw0KPiAgDQo+ICsJaWYgKGR3Yy0+bnVtX3VzYjJfcG9ydHMgPiBEV0MzX01BWF9QT1JUUyB8
fA0KPiArCSAgICBkd2MtPm51bV91c2IzX3BvcnRzID4gRFdDM19NQVhfUE9SVFMpDQo+ICsJCXJl
dHVybiAtRU5PTUVNOw0KDQpUaGlzIHNob3VsZCBiZSAtRUlOVkFMLg0KDQo+ICsNCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCg0KPHNuaXA+DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggMzQxZTRjNzNjYjJlLi5k
ZjJlMTExYWE4NDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0zMyw2ICszMywxMiBAQA0KPiAgDQo+
ICAjaW5jbHVkZSA8bGludXgvcG93ZXJfc3VwcGx5Lmg+DQo+ICANCj4gKy8qDQo+ICsgKiBNYXhp
bXVtIG51bWJlciBvZiBwb3J0cyBjdXJyZW50bHkgc3VwcG9ydGVkIGZvciBtdWx0aXBvcnQNCj4g
KyAqIGNvbnRyb2xsZXJzLg0KDQpUaGlzIG1hY3JvIGhlcmUgaXMgYmVpbmcgdXNlZCBwZXIgVVNC
MiB2cyBVU0IzIHBvcnRzIHJhdGhlciB0aGFuIFVTQjIgKw0KVVNCMywgdW5saWtlIHRoZSB4SENJ
IE1BWFBPUlRTLiBZb3UgY2FuIGNsYXJpZnkgaW4gdGhlIGNvbW1lbnQgYW5kDQpyZW5hbWUgdGhl
IG1hY3JvIHRvIGF2b2lkIGFueSBjb25mdXNpb24uIFlvdSBjYW4gYWxzbyBjcmVhdGUgMiBzZXBh
cmF0ZQ0KbWFjcm9zIGZvciBudW1iZXIgb2YgVVNCMiBhbmQgVVNCMyBwb3J0cyBldmVuIGlmIHRo
ZXkgc2hhcmUgdGhlIHNhbWUNCnZhbHVlLg0KDQpBcyBub3RlZFsqXSwgd2Ugc3VwcG9ydCBoYXZl
IGRpZmZlcmVudCBtYXggbnVtYmVyIG9mIHVzYjIgcG9ydHMgdnMgdXNiMw0KcG9ydHMuIEkgd291
bGQgc3VnZ2VzdCBzcGxpdHRpbmcgdGhlIG1hY3Jvcy4NCg0KWypdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXVzYi8yMDIzMDgwMTAxMzAzMS5mdDN6cG9hdGl5ZmVnbWg2QHN5bm9wc3lz
LmNvbS8NCg0KPiArICovDQo+ICsjZGVmaW5lIERXQzNfTUFYX1BPUlRTIDQNCj4gKw0KPiANCg0K
QnV0IGl0J3Mgbm90IGEgYmlnIGlzc3VlIHdoZXRoZXIgeW91IGRlY2lkZWQgdG8gcHVzaCBhIG5l
dyB2ZXJzaW9uIG9yIGENCmNyZWF0ZSBhIHNlcGFyYXRlIHBhdGNoIGZvciB0aGUgY29tbWVudHMg
YWJvdmUuIEhlcmUncyBteSBBY2s6DQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

