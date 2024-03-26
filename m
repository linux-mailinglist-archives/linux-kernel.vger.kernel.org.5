Return-Path: <linux-kernel+bounces-118463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811D88BB45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5167B220B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D335131BB7;
	Tue, 26 Mar 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L+dQx1ur";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jtpi3bgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="REdjois9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB3A954;
	Tue, 26 Mar 2024 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438354; cv=fail; b=suxfHrWAoK4qk+Wmi0QWpZfMyf/57TBRalMO9ulISinD4hlvehhHHlf8QwkbnSQXMpbSdOQaqFKaY6gOPKZ3vHHliKFxxq0tMwKHQBZY1ZsChUbwyNTJtDznHjdrOyKUScti9WJoEG4rRSMUWRxy2SvBmYXMGujsasl6o4Yanp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438354; c=relaxed/simple;
	bh=2V5QJPxZyZeCPYTwPsHmnV2OrY+5edDwuhyRa51bNFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvW5F1UDrWxBRRmQynqZNV+TU+esITtq3wEDXbA7CwDHyC3Qgy1w6cXV+Zd79o1XMhlDD8kV3UQ9JWeyjIA2H0wWo28gtOpU6NMXZP/+eOeCiXigGsPgg6MgHUele43FtSYQgUUwyoiSQYrpbWsB+wyc9hTlh7pbG+HJ7m0aHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L+dQx1ur; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jtpi3bgw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=REdjois9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q7L3KN013841;
	Tue, 26 Mar 2024 00:31:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=2V5QJPxZyZeCPYTwPsHmnV2OrY+5edDwuhyRa51bNFM=; b=
	L+dQx1urnE5qy2x5g2pb5+EPP3/b3udsJwZw63iHlHqsOJYsWD2QYfU7zZ3FyiLw
	EOy5mRjj8K9c9NsFP4COaTVTIUQXiXHnJMdZnIZ3m4elsoEuJxR1VQuTDLOXeSly
	LRr36/BF2CkEMN2NpOkz4+9AlA2bhgOXHXsn9/624FGaT/oxoXcC+KAWSefxNwRJ
	rXz+x4xbaEMa+LQIWbThYAbO829CO86B5GmJMi+vDYuPq5rxKjTOqV920hjOaMWT
	lP+ETDIDeqUmRWHaK6ud51+zjpvK/HQEIu8RcleXBFBXkl4kSx9gAudu4aId9JIi
	KKJ465GtMwLV2fWKRzVMBg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x3b6fv9b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1711438314; bh=2V5QJPxZyZeCPYTwPsHmnV2OrY+5edDwuhyRa51bNFM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jtpi3bgwrV9Z7ZC24wVI7/Lp82W2PIKOLnhIL6gxZt1H7scrtJBB4htSBIbnpo0zK
	 OJlW6o8UTMk5QEVB6v8icMms4wSc1qISVd55SS/x8frWpLHLaMu9tLGXqV17QIDUFd
	 90CP30ry1BUTewzeg7umwWyyxS5Pxk+RnjTwkSAd9kdy4QR48z4yO30F1DEmHIvUHU
	 g0KGzCBuSjqi5nJLNFZKNwiLrPn/WxnPNd8mtFV401QRcYmRvd97zxaMXdDEg1P4Ia
	 ncx81O9mMp8KLkJwqe9AcabIBJhmvCDOzXhH9F4whJJJCSeutbWplOHpfKvV/MlgZ0
	 f2VC5MOQQJMCA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 294E34035A;
	Tue, 26 Mar 2024 07:31:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 56584A005E;
	Tue, 26 Mar 2024 07:31:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=REdjois9;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CD8F40347;
	Tue, 26 Mar 2024 07:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo9tL2duy73UKt6dYL1DjrDrGnEiL1hdkUPeIXRHTDs2B1e3YokcvERPnGGmQ7OMMrI+XAfJUeX7d/dqmyRiFBuIoDFobnR+6/IXVS+ROMP7NqzkOxAA0x8+aJpog6xRCEy7+HRqDsvjEQEYYgOEDe2G0Tj8OkMrO406g7N6jp8PRlxEQCmBT4b52BwIL1vQhrIRHxt2Sy1cmgPjWRD0WHb9bY4QBGAarqgHYMed8AI0aBtWJc7TewK5UIEzhpUbHDDtoHIDLUyswTKCvKIEHivzsyyV4kgdo7g6N/+zVYZTn6GcgAg0CEj8zzqfZhRotaQBO2nZa/7zGPBmAC5amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V5QJPxZyZeCPYTwPsHmnV2OrY+5edDwuhyRa51bNFM=;
 b=iOMAM/0YwBaikVZMlHIsEwjCwARMDrPAeqazFiwZkNXkGhZeHDN5yjn0APnpu5YjtdAvQvRwMi9USNfXzDcsL5G4X7jXe9Z2+I9b8oSAl+ZqtfhlFTaaqMnVsZrmA5RUFdpE6tBsobQorVEsFolyKDTx8KcQrVOKH/d7zUQT7wL/5CD8GcT0pFst/q4d3aMCd+ZDHkSMKHqe4WOfRAKMttlCIF3qGTwvkAwB0d4PkqSOG/PLOHT6QyLv1K2Qdt0FqSXH4dhkXt3x28YGIB9L1r7LZAzEk/C1/T5VOaXQx2Oxob74Vk6uOEYwQEnyjBI1COZUXLKGOc3KHWnGIOnlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V5QJPxZyZeCPYTwPsHmnV2OrY+5edDwuhyRa51bNFM=;
 b=REdjois9+eJ3piCHlZ2dZnmLyaEYqUiVU0h7YoE/3d7SY4w7OCof21QVolr1DPjUlEYtSOxxuTDw1Fxyl2G1tW4Sn1qh4uDix2W8RFPEXOkZIxmcbxrgY/hdSG4PwoEaDxtfU1rkwholGNTlXRGN49VNY8rNqKJh+BC9wg57Vzo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Tue, 26 Mar
 2024 07:31:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 07:31:45 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Inochi Amaoto <inochiama@outlook.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Chen Wang <unicorn_wang@outlook.com>, Liu Gui <kenneth.liu@sophgo.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] usb: dwc2: add support for Sophgo CV18XX/SG200X
 series SoC
Thread-Topic: [PATCH 2/2] usb: dwc2: add support for Sophgo CV18XX/SG200X
 series SoC
Thread-Index: AQHafyaT4XOMslNBHE2JhrZVkFDqvrFJoQAA
Date: Tue, 26 Mar 2024 07:31:45 +0000
Message-ID: <676b59ee-cf7f-03a6-78a1-197cf5a66ec6@synopsys.com>
References: 
 <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EE73DD36D5FFC81D90EDBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: 
 <IA1PR20MB4953EE73DD36D5FFC81D90EDBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH0PR12MB8007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9jv478c7X0o6s49I/cmiaPo4mIMBC0rol8BapcNPP5st07ducLFA0VCjf2Vx+yKNd1xYHM7wgouaDEXHV87xU/QSl6wTzleMeGsWl/je3Bl20dUisP0YaLIWhsSer1cj1WPtyrxl3yT1r58+LWMytr4gjXZLwvlmFEHkcZ7xzuG58oU6zYuiJTevX1v+1aSeXSbH1bhK2h9RPKuKEzr9ctaeB8/MaStJfdhStjsij8BfxTG4Cm7FNzMYb6BJ0+Bp7FZPBceEk8N/y5JFoc8V2Ej0Or+KW2BLn/VsXjR8CulYGwAe35WhzbEkeLZQcyBnlE7W3mxrPhS7EG1VBjDlwX5f407c+6kPxfq/anwaEsKyRT5+Y9gxTwfDdq6CJVtE+8RjKDgPrCNDokvk8STua7ZNo9wBm1kfVjACeKeJKcYN5LK4hSEOUHK5U930JhbiQ+ZTaJJu+deDDCoM2adZg83FB2CeeKe4YtBjrv7cTpYsIUOptZB3XeIwz772a714MGQifH88LwSlEZ9Gnw6m3yyeFs8V9TV7gcDD8ocRE9o9lvND0uKtziRjOP5Sm/bD9F0EQU/GpczuhvaNdwyzMHkETJR4nvtSdhw/a6X77ByvoOtsl4HQjo2QNeBUjtS7wbxLyCNtvdxVlzEWfymvjAcR7g+fsarVznOIf9qPAQs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U0pzMEdyNk15UHpJVFNSeWFrWHk5ZHNFcWlKK2ZVb0llWlgveFlBVjIxQmM3?=
 =?utf-8?B?ZHA3ZzYrSGdqZDc2TWFHeWtWZndsTWlPcytZTWh4SjBLK0VRY0hCc0gxTHhw?=
 =?utf-8?B?S0JiNDB0dlNoWllWMUVRZ01FTTc1VjBNd0lPUXZVYndQV1luVVpQRDdaM2ZN?=
 =?utf-8?B?UjZYelZvQnhKM1pHQTdwakloTCtjS1BRLzgyNThqa2c2M2VQZjFyWEVMczNG?=
 =?utf-8?B?TGNaaEo0KzF3MDAybDZNUUsweXVVbjF5bzZxV2t1MDF2Y3NTazZ0ZXhaSHpK?=
 =?utf-8?B?N0M2NHB4cWVhZGlIYTdXY3ppZStqdHRvMGdvaXBmN1JDNG8xVzY4QUtvY01a?=
 =?utf-8?B?TGx0UFlrWlN3d0xEMVY3emdiWGVJL0NrWk9yekgybVMwVVY3UGwyRDBla0pp?=
 =?utf-8?B?S2M1Njdkck1nLzQzVFJWRXdyemhMVVMvMzg4aVRPTWpjZlIwalJiUlRzak5P?=
 =?utf-8?B?V2IyTTdaejlHc1l0VVZIcXZ4Rk1kRnRROU5BRzZUV3gzZlBGZWRpcFBRVmRO?=
 =?utf-8?B?YmpHRG5jU1dmd3dBSUxSeGlOSFZaM0loSTFKbGYreDYzOVJoOTdMeDMxbEla?=
 =?utf-8?B?N1ZqekJuRUdRTE9VcUhaN01jZFYzUTM1STFSaDA5WHQ2VlpPMjc4Y1Zlb2ZD?=
 =?utf-8?B?K3Byd2s1eGdnSlR6V3V3eHpzR3RnVDJIOHZma09zM1JTWHM3OWxXZlcybGxR?=
 =?utf-8?B?YWJpdERNNEVuamJocXhPNTQ3Y0Z4ekJSemc2NUFPbHFuOVlhQzdnTWFzcmMw?=
 =?utf-8?B?NDE5QzlOejJOck1rcWkvczJiVHF2eFRjL3BjdzQyUTdhOVVXbTNzTnZmVzFR?=
 =?utf-8?B?bWV4TFUwYnVQMGxZN3JQZXRHTjZXWUhIaWxvcmhReG8reHRpL2VnbHpPYUkz?=
 =?utf-8?B?K0lxdDQ3ZCszVzdYSVJkUnhnMi9VMUUwRzRSZmNDdGczTmIxcEs4ZHdPYjlr?=
 =?utf-8?B?eUR1WVlpcFJGQkptVFIybHVPaWdSemtMdlZvRnNvdmxMRXI4WjJiYjIrNTkx?=
 =?utf-8?B?TStoeG9rc3U0U1EyVVY2dHgySlM4VERtbnZkMG5uVUtPeFlTSzBkdkFzMUFS?=
 =?utf-8?B?MWV6NEdXTkNwNWpIMzNiNnQvM2lpaFpLbThFdy95OVFsdHlKSW1IdzhkTkxU?=
 =?utf-8?B?dFVBWEF6QUR5SDBpaENkdnNZc1pqUitkeXVBNmt3YWs3Q0FOZFlZdmZReUZ3?=
 =?utf-8?B?c2g5amoxYkpKd3Y0a3pTTHN1V21HVGI1UXFJWWhDSUh5bkIwVlZNMWozdGNs?=
 =?utf-8?B?Qk90ZmtBdHd0U29tSmRvY0dkMUNtNmNhRW1kc1VWejhJSS9uSTROWVRmcjFL?=
 =?utf-8?B?NWJQRVdLc2tPa1dJaEtOSEMwWjlEd25xbW5OL0JZRWJ4V2UwWHJSdUl4TG0r?=
 =?utf-8?B?c2IrUWdzbE1VWXhWdDBOT1JnVGVKVHp5Ry92aE03b1dqamZkTTJBRFc3emE3?=
 =?utf-8?B?Q2FQOW1rLzc1cTZReDg1cUk5RW45bVlJL3piMVpjNE9iaXBOQzNORmY3NDYw?=
 =?utf-8?B?UGhZRnU4OGxBWGtDcmtqM0NmQm5zNC90ZzZQeFEzWlZSWnFnaUQ0U0JxbHpz?=
 =?utf-8?B?RUl5RmpYbHhCVTVBMDRzYkk2ajk0TWZzS0piN2tBanJ1cE13SHJwdTNoanlp?=
 =?utf-8?B?cnVVV2VmVzluMk5ySlZJcTYrVkhZVG5jajJTc0N0KysrZTFYVEtFR0lrYTkr?=
 =?utf-8?B?OG9USTUwOG55V05nSnplNk1CSllST3ROaXRLTWxJN2hjbW8wSUtzUHVsWGxE?=
 =?utf-8?B?c29lMGVZeHhBUTRlR2wyMmhQUzFycmM5eUxQSXVTY0VQWHZWeXgvaElVb1Nr?=
 =?utf-8?B?WERhQXg5WWtpK04zK2crRUJxOUNZT29tWWR6bEJzYnRSRmF4YU10Yk85WWQ4?=
 =?utf-8?B?NXBhenVSejV4U09NY28vaG4wNG14dFMxN1lmV2xaVXYrUDJ0NGpsYVpya3lx?=
 =?utf-8?B?NEEzSStxWjBYYmZDd3F3QjIwemtGRUZlYkxrZnhYYllEOXRJcURpVFVwWG5y?=
 =?utf-8?B?UDJKQ0NlVlRsNEhuT3JNVzhnZk80OUNuNE40elhSWE13Z0hxWFAyV3JlbzNw?=
 =?utf-8?B?WStTVmttMG8vUmdERCswWXJ0bURGM3laU2ZZdldOYi9rTGR4WnBsWjlhTnRw?=
 =?utf-8?Q?vGBE9lwvCy1oy3HIdS7G8zmKj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9F2545051AD494A9FC09ADEE57C1E0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E5ffJE6AV1p63gyd19Sz0LZnx3SEad5Qncp8YnJEfXEIqU4Q93H5xzWnhsy4yy1v7uXFpOEdsuNv74bvH8Zwm4GLEwDQ3A0T0L19XQoi+XTXnLPePeS1FLKsE6vz8AymZXTAjN4gfllEyBMucAZx11c+YyesUoTCEZdCl0Fb0rahFdIr4RywCdRxuhLl6ygw+cV+vfDFlperq+dGSVyXTK16XtePyhSYbMCVAOM3Ji5OBNZ0GRdR9D8He7aEyjnP0/gweO+HqKhx04IhsVV4y7AY0QtBvxBQMjnbVDuxGQfWEySGcJ9Ap8ErL448iDAxi3ObDp9eF1TCQhWpejT0/3doK0sLJ7oTwq7rJd6Zty11eUnGIS81x13+w8ZtQaOCtH4prGCW8kgzKW17Cu+1oRYo5po1frepn1uNeglxcEk+su4Rh6RObk980Il6PpXa0O4RQc8E3FVFa8twpr8r5y2fr6L5KNQC5uL/PO+8kHlCzdPeTyfwTbea6SQoaHA5QR1TrzCMvKXXrIw4rezzBIdhkS3hYbWWggoyDh9tGjEfH35qvdNbvi+SbpGbmC26KT+E8bLBeQzDWq4X9rBpl6/Gxd3BuB60AZtVhNeLtFuecmJuXyQDAZnU1JEfCx/f5UdL4pw5aaaLUnz5ioTkMg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2ddb9f-c3ea-44c8-93a7-08dc4d66ca5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 07:31:45.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQXd+sRqF3jcxZmx6mEp/P4QDM4ijf7y0M+02+fuTKpp2CaUpMdHdXacY1rPDitZTRFukqAoz1K1Fk/SxCwylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
X-Proofpoint-GUID: dwTKQYwTGnoQpvwtWVn_LojJ5I0GZiJT
X-Proofpoint-ORIG-GUID: dwTKQYwTGnoQpvwtWVn_LojJ5I0GZiJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260050

DQoNCk9uIDMvMjYvMjQgMDY6MzcsIElub2NoaSBBbWFvdG8gd3JvdGU6DQo+IEFkZCBwYXJhbXMg
Zm9yIERXQzIgSVAgaW4gU29waGdvIENWMThYWC9TRzIwMFggc2VyaWVzIFNvQy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IElub2NoaSBBbWFvdG8gPGlub2NoaWFtYUBvdXRsb29rLmNvbT4NCg0KQWNr
ZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lub3BzeXMuY29tPg0KDQo+IC0tLQ0K
PiAgIGRyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jDQo+
IGluZGV4IGViNjc3YzNjZmQwYi4uMTcxZmNiMzRlYjc1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MyL3BhcmFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4g
QEAgLTIwMSw2ICsyMDEsMjUgQEAgc3RhdGljIHZvaWQgZHdjMl9zZXRfYW1jY19wYXJhbXMoc3Ry
dWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAlwLT5haGJjZmcgPSBHQUhCQ0ZHX0hCU1RMRU5f
SU5DUjE2IDw8IEdBSEJDRkdfSEJTVExFTl9TSElGVDsNCj4gICB9DQo+IA0KPiArc3RhdGljIHZv
aWQgZHdjMl9zZXRfY3YxODAwX3BhcmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICt7
DQo+ICsJc3RydWN0IGR3YzJfY29yZV9wYXJhbXMgKnAgPSAmaHNvdGctPnBhcmFtczsNCj4gKw0K
PiArCXAtPm90Z19jYXBzLmhucF9zdXBwb3J0ID0gZmFsc2U7DQo+ICsJcC0+b3RnX2NhcHMuc3Jw
X3N1cHBvcnQgPSBmYWxzZTsNCj4gKwlwLT5ob3N0X2RtYSA9IGZhbHNlOw0KPiArCXAtPmdfZG1h
ID0gZmFsc2U7DQo+ICsJcC0+c3BlZWQgPSBEV0MyX1NQRUVEX1BBUkFNX0hJR0g7DQo+ICsJcC0+
cGh5X3R5cGUgPSBEV0MyX1BIWV9UWVBFX1BBUkFNX1VUTUk7DQo+ICsJcC0+cGh5X3V0bWlfd2lk
dGggPSAxNjsNCj4gKwlwLT5haGJjZmcgPSBHQUhCQ0ZHX0hCU1RMRU5fSU5DUjE2IDw8IEdBSEJD
RkdfSEJTVExFTl9TSElGVDsNCj4gKwlwLT5scG0gPSBmYWxzZTsNCj4gKwlwLT5scG1fY2xvY2tf
Z2F0aW5nID0gZmFsc2U7DQo+ICsJcC0+YmVzbCA9IGZhbHNlOw0KPiArCXAtPmhpcmRfdGhyZXNo
b2xkX2VuID0gZmFsc2U7DQo+ICsJcC0+cG93ZXJfZG93biA9IERXQzJfUE9XRVJfRE9XTl9QQVJB
TV9OT05FOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIHZvaWQgZHdjMl9zZXRfc3RtMzJmNHg5X2Zz
b3RnX3BhcmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
ZHdjMl9jb3JlX3BhcmFtcyAqcCA9ICZoc290Zy0+cGFyYW1zOw0KPiBAQCAtMjk1LDYgKzMxNCw4
IEBAIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZHdjMl9vZl9tYXRjaF90YWJsZVtdID0gew0K
PiAgIAkgIC5kYXRhID0gZHdjMl9zZXRfYW1sb2dpY19hMV9wYXJhbXMgfSwNCj4gICAJeyAuY29t
cGF0aWJsZSA9ICJhbWNjLGR3Yy1vdGciLCAuZGF0YSA9IGR3YzJfc2V0X2FtY2NfcGFyYW1zIH0s
DQo+ICAgCXsgLmNvbXBhdGlibGUgPSAiYXBtLGFwbTgyMTgxLWR3Yy1vdGciLCAuZGF0YSA9IGR3
YzJfc2V0X2FtY2NfcGFyYW1zIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJzb3BoZ28sY3YxODAw
LXVzYiIsDQo+ICsJICAuZGF0YSA9IGR3YzJfc2V0X2N2MTgwMF9wYXJhbXMgfSwNCj4gICAJeyAu
Y29tcGF0aWJsZSA9ICJzdCxzdG0zMmY0eDktZnNvdGciLA0KPiAgIAkgIC5kYXRhID0gZHdjMl9z
ZXRfc3RtMzJmNHg5X2Zzb3RnX3BhcmFtcyB9LA0KPiAgIAl7IC5jb21wYXRpYmxlID0gInN0LHN0
bTMyZjR4OS1oc290ZyIgfSwNCj4gLS0NCj4gMi40NC4wDQo+IA==

