Return-Path: <linux-kernel+bounces-156083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB378AFDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5A0B2397E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40B749A;
	Wed, 24 Apr 2024 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j+SbzD1V";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ig/bnuse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ipHNoCZh"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24363A5;
	Wed, 24 Apr 2024 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921512; cv=fail; b=IOFyH72wN7VoaiH+/lzj5XJOqg3AHnm7wNeIjvlJx8v5Svk7khdiamSn+26u/9XWwPGZQ1DQ9ivx2iexEgXY/SvhpOQFB886X+RtETMBemDHXyO9klcmuL17/HQ0keN1T8O60Wbv2jy+DV4svyTGZKHRIYxAiMqw2k5JCsI5erQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921512; c=relaxed/simple;
	bh=aNXE8zF9Lq+db3zuA7uQTIlOgnsOgaFePEu5CaSVWaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIHhpIG+dlUt1O+VWHd1dVfzHzDJAPwsQuI8xXmglif2LASNgwTosrz5jp6yznLS5sPGSyTH5ih58xVDatQefFIWkuO3RPlpXOchWp4x2We5aV0nPPejCmDFFk1OqAvwqGs2o0F1lQWpc5FlSvBy2ME2sff2Hu5lua5KwlXzqHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=j+SbzD1V; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ig/bnuse; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ipHNoCZh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0wMYG019660;
	Tue, 23 Apr 2024 18:18:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=aNXE8zF9Lq+db3zuA7uQTIlOgnsOgaFePEu5CaSVWaY=; b=
	j+SbzD1VLTYlZRVM0XxaliiAuSp6XLX2OB4R/KCvH8NOu19RvHL4JMx9pHACDqFh
	qQNnPDi3rbDILLTpK8BCtNSd0mCBuobeRAjpSG4kdzV+61GoTXpbW4AdtIyPFx5o
	/VjBaV+z+qPjzZV1bYAyD8bM4BEpuG+5dYLnqfYqh82iJC7NHQQNYXWJyP1Is+OV
	yJkPBjTNWNDlxXQvigh9LlvEowMTJ2qxWdaPEeQi591eG/9sNlf4wrN5P7DSY74V
	yH3RisxweyRKgGdusaazABaFIJk1tI1ZRznbLPOhlX7xpWADEGadlNw1dYzik1AH
	kcqxut32knBGrt2Z8rVLHQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xjdgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713921502; bh=aNXE8zF9Lq+db3zuA7uQTIlOgnsOgaFePEu5CaSVWaY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ig/bnuseFzy3kXIBxaWrM3Ljnkr5CgIfLAUmGGv3CbKD8k8iLJ2hnOErn9SL/cbx1
	 /BJpa6XuUpb2FqP1SRvpGParXxNglIyjMP40l0NQ+qAsJvsvPLTRRFv424bmx4/QJm
	 TnwMgf8yn9CtP22ImIBMlXCUR7f9UNwdjT1Ldrs6iiPesLXZyYn135rlzdPLdQ9sbJ
	 slxnzhrV5WOpTF/WGAIZqzsiIc69ygAogNxAKsX7suIaoahvEa/3LljWz/3Mkmr8pO
	 l4ghWBWgrNsxmYvJAD/7yPbYSIakDDBIw7RxfAOsugJpcd8/UZ/pI25cObb5WHmJmS
	 wLazxQooUWHrA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5F6F440359;
	Wed, 24 Apr 2024 01:18:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 130ECA0077;
	Wed, 24 Apr 2024 01:18:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ipHNoCZh;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7ACCA40360;
	Wed, 24 Apr 2024 01:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoli5yxGRaHROpFyEc7Y4kI9bIdxhSPt/g64i3FhUIotC9pKuHAl0kEw9YEpAZeU58M7jbLawyT1wbXNQxxfogYc8lc/0S1/3ROThwfKsk9US10g1fWXrTkej3zLDvnMiPbmSCS6O+M2vWbvHxRJ0OzsXkN+DNeEe11LLQlT7/JRuk7/6aBFH3foEp76G1Z45OIS8di/lf+7hlbyG7mEO9EiH3pLdJjPxQ7FOmsSmitiW6NRCsJgkKt1U5oLUObAfJKxfudFaxf+0wCjg0HqsYSjLmVoVC1ekZSeR1+c++51csr55y4t7S2TO6dlNH7Ml1UxL8/C/pqiqezkTsNyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNXE8zF9Lq+db3zuA7uQTIlOgnsOgaFePEu5CaSVWaY=;
 b=UU75c7U2yopP57ANlKto4m/lbpwcjEKV48rGk6118aKoZhaBxQJ0Z4LrJY6S2FoXSyL6Ntc0s6mNT4vuTl/EQQ4hYBy94yG4U5b2DKkdGesNko8nWfmjpTtqmrubqZhAPOiHBMtHKyF4otjybOp1uI5F8SqweqKJ4iGQsH7u5VEnWJu1slkuGEJCPpb0SySkU74zmQ2ELHtAEbpN8LUwM8DiIiOy6iJHzUnzhffaAsUMHq3S8K01XZi4uyx8mO3z7yMODwHRHRrVcGUOK36DB3TIucG6MNZ0DMGal5W6bUYYFma79STl988bi94H5gdQfORsO9S8xi3uWl0+DN6eFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNXE8zF9Lq+db3zuA7uQTIlOgnsOgaFePEu5CaSVWaY=;
 b=ipHNoCZhIYS6Di6zAEBj39duFQE+jB2KhYpKuPhhjJdVJqVBwjPNhJaC2P22/ENPnqaFDIr+1NT0tAbZBdeKmgOY2WOmeeUBWuq4AHunAj8NEPH4E3O8Apkp0W7+yMjvxQiwJKeDMVfVxtGD/mKNPmsF+EUPhGPQOjA19MuXay4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:18:13 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:18:13 +0000
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
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Topic: [PATCH v21 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Thread-Index: AQHakt5AS1ZT0mbmIUK3a0D8mMeuSrF2pM0A
Date: Wed, 24 Apr 2024 01:18:13 +0000
Message-ID: <20240424011810.4gs3vs4f2qbjxbea@synopsys.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-9-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-9-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: 2cc81e3a-92b9-4dbf-f695-08dc63fc69a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VnlRSUpqc0tDVVV4aThtd3QxUTBvd21HWERiNU52RWFSTW5oV0Y4VklyYm0x?=
 =?utf-8?B?bStKNTFtRlgyYVNZWlVrd3VHVVJBSTY4U2d6M3lMZzNKUUM5TXd0NDdCUits?=
 =?utf-8?B?K0RTazZGcWIvdUdVbWxlQkp1UVNsNnNWaWMwUW5QNnVjaC9ZTmo3czYwaDNL?=
 =?utf-8?B?aytlRUlYZjljajlVQTF2SWtjS1l0YllGa3grWEFhTkxmQU5Rb3NrMUVYcHhT?=
 =?utf-8?B?b2IzcS92Q1VlWTVOVmZKbWdUZzR4d1dzc3VjaHJTc29HdWsybW5DdUVwT2cx?=
 =?utf-8?B?aUlrWGN4alhtUUdnL3pReFJ5MVJmcTVqMlBldEI5NzU1RmFLSUpDeHV3ay91?=
 =?utf-8?B?NWgyR1JaSENibHJ1SStzS3NmeFNRQ2pPeUVPbzBOSHlkSGd3OStucFVLdFZu?=
 =?utf-8?B?SDl4Z2xPei94Wi9tN3dWYUJLMXpBcmRsK2lWYXVDSTIzMGhmZnZGV2VubXM5?=
 =?utf-8?B?YlBXVHRnZmpKQkp4SDNvY1FmdGptc1k2UnJ1dHpyRFdRbzBDbUFtYjZ0MXlG?=
 =?utf-8?B?WTBzMXlDZU9DNUMxN2hxZTJQQ0hWTlFXMy9qc1RXeDNLN24wazRiYmU5MVdB?=
 =?utf-8?B?dXU1cGg0Rk5ISFBjYWlHOEVqQWQxRmJGOTBvaWMyQmVpT0VFZUI3NTNFcG5r?=
 =?utf-8?B?VUM1SkYvNXpYTi9FWXVkRXFYbXd6cVFIVEpnNVVDTkYxendIMTZRbWx5T0Rz?=
 =?utf-8?B?NTQzV2lNTGRIemltWThLZzVtc3lDY21WQ1dJNytScm0vNUFvUWMyTzRDMHV2?=
 =?utf-8?B?SHd4bWtlZHQwcG5wZWF0aGY5ZHczY3lOTEtlMGFrUnk1cVhzVW02V0hDOGdP?=
 =?utf-8?B?ZTV0RzNOMDVSL0x6WUJNV3hEWHlxVTlvMzBLTmVId2ZiMnFNM0gvejE5WjlN?=
 =?utf-8?B?and3UFNuTUY5ZWNSRWhyQ1B5QnFGdjNyZTY3cDFYN2dBM0ZwMGovZGprYjdz?=
 =?utf-8?B?cHEzMEZQZjEvbS9aNTBHWmRRY1ZlOTJDTXFkVldUNldnSW5lL1lFUGQvSnJI?=
 =?utf-8?B?UmJlQk5TbHY0UkpsS0M3bC9pZWE0TXQ1Q1d5Q1IzVjEySzJCTmtLc0kxb3pa?=
 =?utf-8?B?a1J6eitUS3h5cW41S3U1VXBLUXpWM0RvN0R5UytmemkzdFZIanBNNGJQZFRQ?=
 =?utf-8?B?Z21Mc2JxV2RucG1BWnkzRkd3RVJGL3R4cFp5SjlKL1h1RG5ZSkhlVjdYSG9L?=
 =?utf-8?B?aEkrVkNOSkR4a29NWmZud09WT1hyL3pSV2xMbHdrWnUwTHErNVNGSnFlbmli?=
 =?utf-8?B?TURONlpRQ1RwNUNRSGdyMGRWaklCbUt3c045RWZCcHBud3RkTndiNUk3V0ht?=
 =?utf-8?B?SWR6cTRVRFhmSW5SMm84bjVNRTMyeVhGc2tnT2hJRE0zVG9TUnZhcVF4dUc1?=
 =?utf-8?B?YUtkMkdIZ1AxN21aWGdZNGhvR2RpWkppNlovbm16aUp4alFPR2FCYTVFZHBL?=
 =?utf-8?B?cGNuSzMxMW9wekoxN012Y0VyYTVvNy9MQW5WNGFaU0dDWjk1TVZhblFWQ0pT?=
 =?utf-8?B?cFRYL2xEa2loblZkTEpXYm1LNGNkQ0szYm1MNEF2QnV3c1pzL3F4TkpNMjV6?=
 =?utf-8?B?dTFMeXNKK0JBNHJHdEVjamIwMFVCc20wUENpS3Qvb2t2dGloSjJvanlEZXBD?=
 =?utf-8?B?dDhGL1RhelgvclNrblNzMHI2N3E2NmFIVVd0amxwRXBkeFhFUFBuQjR2MFdx?=
 =?utf-8?B?ME1GbW1DRmJicWVTVVlJNWdZbzZDYmJyeTN4Vjltblo4cms5NWdzNTY0TnZ0?=
 =?utf-8?B?N0V3Yy9xaHJENDlramVKZTlNcVlxNXdCTjRGSmVoYkNkUDA5TmxOTjhLZ01i?=
 =?utf-8?B?ODNDUEZXUmc4ZU8wV3F6UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NTcreVl0Y29aQnRKUWVsVWQ2S1Q5aU8wNkhvTGNqbHIvZ0o3OGQyWGJleFFR?=
 =?utf-8?B?Mlh6VE1ZT2tzSk1RcnlVdXVkU3hpc09wNDQxYmJCb3R3RlJTTEVqWlJVd1Bl?=
 =?utf-8?B?UUxtcmZveXNyTmRrcVJOaTRKa1hsNWdZZGlhaGFsU1VxcVl3QTVEbDJyYVQz?=
 =?utf-8?B?ZURwcG5Vazl4Rnloam1CZE9reW9yUUxKc3I1bUlIa1cydkZPeEFJczVGYkZP?=
 =?utf-8?B?K1FENWw1bDdPcURPYkpqOWQrOGFwSWJPR2Y0cDVKWkdPVU9MWHdURHVCRDY4?=
 =?utf-8?B?aHNRQmthSERDVFY3YVNjbGk0STRSeDhMTk5TY2RUVEErcFdwTDcyUGF3Q2dq?=
 =?utf-8?B?L1VmeHc1SWErWTdQMFZkZS9ONXJpZWlYUmNPa1NCQWtvbE1xcm0rN2JtKzdD?=
 =?utf-8?B?ejl3a0ZScXB3NkszVmVkU09uOS96TVRQUlBxUEZPVTFvdmF2N1hLalVzQzhS?=
 =?utf-8?B?dW1sVzZZb1ZYb25zNXhkT3lYOWtBTXE5eEE2ck9aMk9ZMjE2bzE3L2FoNzZX?=
 =?utf-8?B?bXRkaEpIS29CcVowcDd4NHVMT1N5SWQrYVFjMUUxM1oxVWNRd2lrUE4zUkdC?=
 =?utf-8?B?dm5MS3NWTDdzamx0Zi9mVk9lYythOXBzYnhZWW92Vm45bjlNWGRLVGVPTnkz?=
 =?utf-8?B?Rkg0UDVZUDRiQ2FmZVBYME1SWkR2ZW5QU2RtTG12Z0g0OThxU0dYMUxrbEZj?=
 =?utf-8?B?Y1RlQ3kwZUdHWVpmakM0TzVnR1F0M1VHZ1dINllYZnBza0xteXc5aU1XTjF5?=
 =?utf-8?B?eGhQRkRaYnFtM1M2bzYyMGhPRW8rRHoxVzM5SlNKK1ozcEFFR05JMlora3Vt?=
 =?utf-8?B?akxiN2x1cngrWllXYVJrdHBEOUl1clQvUFhGVW55MGZ3bjN4QlFLNTZ2MTho?=
 =?utf-8?B?OVM3Wk5YYzlqOW93aUJzWVRTQS9Ja081UXQyV21wR0JhcUQ3MUwzcDVZZm9n?=
 =?utf-8?B?SFBSZmMrU2xNU3RaTEFEVzNEVGdQaytEVG9YRWZWUnBKUEdCaDFyUExOM3g3?=
 =?utf-8?B?UHBod3FueHdkYk40dU1yK1ozZk5SVHlpTElqVmg1aHkrV2RvN0xwS3BtbXp5?=
 =?utf-8?B?ZDZVcmdHU1lWT1lvanZIME5sa3YweFNWQy8wR3QwVHU0cWFpa2JrRVVWV2Fz?=
 =?utf-8?B?SHNoOXJVZG9zZFBjRkNWd1ZCbGZKaUNETWo4TzBCVmRrcmwwVU1aWE9BZkk1?=
 =?utf-8?B?K3dpTk1EUEVEdlZWRXZlcllaeUZGcElBQnVraEp6b2FDR2FJU1NENTNMeVFD?=
 =?utf-8?B?dWYxZkllcnFVaDFER0hzWTdCRUwrTmtPazZRRU1VaVJ3UHZTV1NQVEYvekpw?=
 =?utf-8?B?MldXaWZVTjQ4MUdGUWMrSWZmVUpsbXdpYWgrMllFbmYvUnV1c3E5TTJ1NEFk?=
 =?utf-8?B?Qjg1RnhBRFM3SUdhVnBjUHpHTEl4SEYyY3FUcDQwZ1lQWldWbjNCeHM1Vjlr?=
 =?utf-8?B?b1VjYkdSUVUwWlBPbkUzd0h6WkZQQytxdTZkRXQ3ZVJzdWpOZ1RxYUsrZ3By?=
 =?utf-8?B?ZnFZcVJOT3ZuN1gzMjdQbGZPeHptZHJvZXBKc3FCek1HWitYdHI4K1d5Nlgy?=
 =?utf-8?B?YUJvTjNEVm54WkcvVmQ2U2hFSFNsOExOZXBDMUlUbCtFWnQzYU9VQ2xqdjk0?=
 =?utf-8?B?L0ZaVVJGMXo2WFdUNDN2UUN5bm5VSEV1Z0FXSE1oVTVSUDBLSVlOaWU4R2VW?=
 =?utf-8?B?bUl0NWFWTjBqQkFjVFZwcXhPNmk3aXBOU3V3VFpiMzhBaWZXdlFvMFp3UENH?=
 =?utf-8?B?V1lrVCtNVUoxa0ErbnZLMTJhVGROSVpGNXFXYnk3VzJDQTFMcXNYamhBc1Vk?=
 =?utf-8?B?RXhsbFhGcWh1aUI4czNMUyt6OUljSUtVdUo4NUIrQlNvR1JkRnozNXBmOERO?=
 =?utf-8?B?ZWZiWHJlamFjQ1B6dTEwSEhBYmhuVWVzYlVuRVdjMkNjUW5IaHpDeGlqSHg2?=
 =?utf-8?B?YlJsajI2eFY3K3kwSTAzdjQ2VVlTYWN4ZkdjNlUrczRxZ2NnNFVLZnIzSGR1?=
 =?utf-8?B?cDdyS2dENTAycERIaXJ5VkFWbUVmakx3V0ZmSm1aN0V3RVJOTlA3WStTd1l2?=
 =?utf-8?B?cXRIVlptQUp3dS9oaWMvWXNyN2MxUG9JNUV2bGx0U0hVTStHakFRV1FTZUFr?=
 =?utf-8?Q?MA9eVFr/OmG6ijWj/1Uh4/A9R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BB1E36FB4342142A7400B37D88A592D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PDpm5aB0+iw9OiU34bL38+itfM/yVDCunRjlwUdP6h35oHlr+0A8gZZlw2WP1R8UBUMTxMvKgBqocowfPXPuDk+cWU4Can6HoMFeU+3XqVn1xPqign7M0KbaPYbj/EeNi7OYTSJ9y/RxNIXtqlBYChUY5OtubhRCW+/b7OiJj0/gHQLGJ12VAzkVSvVDfZR3EgwhVGDczx56LBJqtZv9YHdTiymoN7bvMB/J/hteh4FG4gls/5QkbfWv0BXcBjjrg1oAcHdnIPxaLrwdQTNR4GOc7+sDIK3SeVHqos4mTBue7Cw6Jyu2T6cjRQlb8r3F/p0poNC5MOeYStRaQtU5Z05+x9ypclsQhA38DkS55xOZ3EJHhOAglKxt18siQuuyUXICopBpguEEeN8HDRuRIvQfbQU7iSXvNEoTxbRxtMFdOh02ACTYG6w3bz94IBPgc7uLi8GbzTg0M5apqfjilGo6jU3HoViGpDKLrnlnFireFz2POawyvhCj287j8vJmd9jh/YTYoyzGOp3iFNn/e2ztY88r7a5nA38/idFNOoJY1S9nQvq5LNKt4U2PdDrsnwkyKIYMbuUZvLpXG5vnLyc/xCFLGU8y9b0znfF5YVi3TZEEHwVtMqleAEfW4EU8pax6y2wceLfeQeLJ+rPN4A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc81e3a-92b9-4dbf-f695-08dc63fc69a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:18:13.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIqRWLByesWMikpW4tTqIYrhBH2NbjunjFDixIgw4Vf9K7GmEiTrcEKg6W/vdqwsl06Gtuhy/7R01/v7+2l+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Proofpoint-GUID: KuYGl7liiTkxTxHwLCLYoftjDMM4dVGD
X-Proofpoint-ORIG-GUID: KuYGl7liiTkxTxHwLCLYoftjDMM4dVGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240005

T24gU2F0LCBBcHIgMjAsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IERXQzMgUWNv
bSB3cmFwcGVyIGN1cnJlbnRseSBzdXBwb3J0cyBvbmx5IHdha2V1cCBjb25maWd1cmF0aW9uDQo+
IGZvciBzaW5nbGUgcG9ydCBjb250cm9sbGVycy4gUmVhZCBzcGVlZCBvZiBlYWNoIHBvcnQgY29u
bmVjdGVkDQo+IHRvIHRoZSBjb250cm9sbGVyIGFuZCBlbmFibGUgd2FrZXVwIGZvciBlYWNoIG9m
IHRoZW0gYWNjb3JkaW5nbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRp
IDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9oYW4gSG92b2xk
IDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEJqb3JuIEFuZGVyc3Nv
biA8cXVpY19iam9yYW5kZUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtcWNvbS5jIHwgNzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1xY29tLmMNCj4gaW5kZXggNWRkYjY5NGRkOGU3Li5iNmYxM2JiMTRlMmMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBAQCAtNjAsNiArNjAsNyBAQCBzdHJ1Y3QgZHdjM19x
Y29tX3BvcnQgew0KPiAgCWludAkJCWRwX2hzX3BoeV9pcnE7DQo+ICAJaW50CQkJZG1faHNfcGh5
X2lycTsNCj4gIAlpbnQJCQlzc19waHlfaXJxOw0KPiArCWVudW0gdXNiX2RldmljZV9zcGVlZAl1
c2IyX3NwZWVkOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IGR3YzNfcWNvbSB7DQo+IEBAIC03MSw3
ICs3Miw2IEBAIHN0cnVjdCBkd2MzX3Fjb20gew0KPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpy
ZXNldHM7DQo+ICAJc3RydWN0IGR3YzNfcWNvbV9wb3J0CXBvcnRzW0RXQzNfUUNPTV9NQVhfUE9S
VFNdOw0KPiAgCXU4CQkJbnVtX3BvcnRzOw0KPiAtCWVudW0gdXNiX2RldmljZV9zcGVlZAl1c2Iy
X3NwZWVkOw0KPiAgDQo+ICAJc3RydWN0IGV4dGNvbl9kZXYJKmVkZXY7DQo+ICAJc3RydWN0IGV4
dGNvbl9kZXYJKmhvc3RfZWRldjsNCj4gQEAgLTMxMCw3ICszMTAsNyBAQCBzdGF0aWMgYm9vbCBk
d2MzX3Fjb21faXNfaG9zdChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgCXJldHVybiBkd2Mt
PnhoY2k7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQgZHdjM19x
Y29tX3JlYWRfdXNiMl9zcGVlZChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiArc3RhdGljIGVu
dW0gdXNiX2RldmljZV9zcGVlZCBkd2MzX3Fjb21fcmVhZF91c2IyX3NwZWVkKHN0cnVjdCBkd2Mz
X3Fjb20gKnFjb20sIGludCBwb3J0X2luZGV4KQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2Mg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShxY29tLT5kd2MzKTsNCj4gIAlzdHJ1Y3QgdXNiX2Rldmlj
ZSAqdWRldjsNCj4gQEAgLTMyMSwxNCArMzIxLDggQEAgc3RhdGljIGVudW0gdXNiX2RldmljZV9z
cGVlZCBkd2MzX3Fjb21fcmVhZF91c2IyX3NwZWVkKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pDQo+
ICAJICovDQo+ICAJaGNkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZHdjLT54aGNpKTsNCj4gIA0K
PiAtCS8qDQo+IC0JICogSXQgaXMgcG9zc2libGUgdG8gcXVlcnkgdGhlIHNwZWVkIG9mIGFsbCBj
aGlsZHJlbiBvZg0KPiAtCSAqIFVTQjIuMCByb290IGh1YiB2aWEgdXNiX2h1Yl9mb3JfZWFjaF9j
aGlsZCgpLiBEV0MzIGNvZGUNCj4gLQkgKiBjdXJyZW50bHkgc3VwcG9ydHMgb25seSAxIHBvcnQg
cGVyIGNvbnRyb2xsZXIuIFNvDQo+IC0JICogdGhpcyBpcyBzdWZmaWNpZW50Lg0KPiAtCSAqLw0K
PiAgI2lmZGVmIENPTkZJR19VU0INCj4gLQl1ZGV2ID0gdXNiX2h1Yl9maW5kX2NoaWxkKGhjZC0+
c2VsZi5yb290X2h1YiwgMSk7DQo+ICsJdWRldiA9IHVzYl9odWJfZmluZF9jaGlsZChoY2QtPnNl
bGYucm9vdF9odWIsIHBvcnRfaW5kZXggKyAxKTsNCj4gICNlbHNlDQo+ICAJdWRldiA9IE5VTEw7
DQo+ICAjZW5kaWYNCj4gQEAgLTM1OSwyNiArMzUzLDI2IEBAIHN0YXRpYyB2b2lkIGR3YzNfcWNv
bV9kaXNhYmxlX3dha2V1cF9pcnEoaW50IGlycSkNCj4gIAlkaXNhYmxlX2lycV9ub3N5bmMoaXJx
KTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgZHdjM19xY29tX2Rpc2FibGVfaW50ZXJydXB0
cyhzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiArc3RhdGljIHZvaWQgZHdjM19xY29tX2Rpc2Fi
bGVfcG9ydF9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb21fcG9ydCAqcG9ydCkNCj4gIHsNCj4g
LQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLnF1c2IyX3BoeV9p
cnEpOw0KPiArCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocG9ydC0+cXVzYjJfcGh5X2ly
cSk7DQo+ICANCj4gLQlpZiAocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+
IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNbMF0uZG1faHNfcGh5
X2lycSk7DQo+IC0JfSBlbHNlIGlmICgocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfSElH
SCkgfHwNCj4gLQkJCShxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSkgew0KPiAt
CQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLmRwX2hzX3BoeV9p
cnEpOw0KPiArCWlmIChwb3J0LT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9MT1cpIHsNCj4gKwkJ
ZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShwb3J0LT5kbV9oc19waHlfaXJxKTsNCj4gKwl9
IGVsc2UgaWYgKChwb3J0LT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiArCQkJ
KHBvcnQtPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7DQo+ICsJCWR3YzNfcWNvbV9k
aXNhYmxlX3dha2V1cF9pcnEocG9ydC0+ZHBfaHNfcGh5X2lycSk7DQo+ICAJfSBlbHNlIHsNCj4g
LQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlf
aXJxKTsNCj4gLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5k
bV9oc19waHlfaXJxKTsNCj4gKwkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShwb3J0LT5k
cF9oc19waHlfaXJxKTsNCj4gKwkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShwb3J0LT5k
bV9oc19waHlfaXJxKTsNCj4gIAl9DQo+ICANCj4gLQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBf
aXJxKHFjb20tPnBvcnRzWzBdLnNzX3BoeV9pcnEpOw0KPiArCWR3YzNfcWNvbV9kaXNhYmxlX3dh
a2V1cF9pcnEocG9ydC0+c3NfcGh5X2lycSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIGR3
YzNfcWNvbV9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiArc3Rh
dGljIHZvaWQgZHdjM19xY29tX2VuYWJsZV9wb3J0X2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNv
bV9wb3J0ICpwb3J0KQ0KPiAgew0KPiAtCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29t
LT5wb3J0c1swXS5xdXNiMl9waHlfaXJxLCAwKTsNCj4gKwlkd2MzX3Fjb21fZW5hYmxlX3dha2V1
cF9pcnEocG9ydC0+cXVzYjJfcGh5X2lycSwgMCk7DQo+ICANCj4gIAkvKg0KPiAgCSAqIENvbmZp
Z3VyZSBEUC9ETSBsaW5lIGludGVycnVwdHMgYmFzZWQgb24gdGhlIFVTQjIgZGV2aWNlIGF0dGFj
aGVkIHRvDQo+IEBAIC0zODksMjEgKzM4MywzNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5h
YmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAkgKiBEUCBhbmQgRE0g
bGluZXMgYXMgcmlzaW5nIGVkZ2UgdG8gZGV0ZWN0IEhTL0hTL0xTIGRldmljZSBjb25uZWN0IHNj
ZW5hcmlvLg0KPiAgCSAqLw0KPiAgDQo+IC0JaWYgKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQ
RUVEX0xPVykgew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydHNb
MF0uZG1faHNfcGh5X2lycSwNCj4gKwlpZiAocG9ydC0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURf
TE9XKSB7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShwb3J0LT5kbV9oc19waHlf
aXJxLA0KPiAgCQkJCQkgICAgSVJRX1RZUEVfRURHRV9GQUxMSU5HKTsNCj4gLQl9IGVsc2UgaWYg
KChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiAtCQkJKHFjb20tPnVz
YjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7DQo+IC0JCWR3YzNfcWNvbV9lbmFibGVfd2Fr
ZXVwX2lycShxY29tLT5wb3J0c1swXS5kcF9oc19waHlfaXJxLA0KPiArCX0gZWxzZSBpZiAoKHBv
cnQtPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0hJR0gpIHx8DQo+ICsJCQkocG9ydC0+dXNiMl9z
cGVlZCA9PSBVU0JfU1BFRURfRlVMTCkpIHsNCj4gKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBf
aXJxKHBvcnQtPmRwX2hzX3BoeV9pcnEsDQo+ICAJCQkJCSAgICBJUlFfVFlQRV9FREdFX0ZBTExJ
TkcpOw0KPiAgCX0gZWxzZSB7DQo+IC0JCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29t
LT5wb3J0c1swXS5kcF9oc19waHlfaXJxLA0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9p
cnEocG9ydC0+ZHBfaHNfcGh5X2lycSwNCj4gIAkJCQkJICAgIElSUV9UWVBFX0VER0VfUklTSU5H
KTsNCj4gLQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnBvcnRzWzBdLmRtX2hz
X3BoeV9pcnEsDQo+ICsJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShwb3J0LT5kbV9oc19w
aHlfaXJxLA0KPiAgCQkJCQkgICAgSVJRX1RZUEVfRURHRV9SSVNJTkcpOw0KPiAgCX0NCj4gIA0K
PiAtCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5wb3J0c1swXS5zc19waHlfaXJx
LCAwKTsNCj4gKwlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocG9ydC0+c3NfcGh5X2lycSwg
MCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGR3YzNfcWNvbV9kaXNhYmxlX2ludGVycnVw
dHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gK3sNCj4gKwlpbnQgaTsNCj4gKw0KPiArCWZv
ciAoaSA9IDA7IGkgPCBxY29tLT5udW1fcG9ydHM7IGkrKykNCj4gKwkJZHdjM19xY29tX2Rpc2Fi
bGVfcG9ydF9pbnRlcnJ1cHRzKCZxY29tLT5wb3J0c1tpXSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIGR3YzNfcWNvbV9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tICpxY29t
KQ0KPiArew0KPiArCWludCBpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IHFjb20tPm51bV9w
b3J0czsgaSsrKQ0KPiArCQlkd2MzX3Fjb21fZW5hYmxlX3BvcnRfaW50ZXJydXB0cygmcWNvbS0+
cG9ydHNbaV0pOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3YzNfcWNvbV9zdXNwZW5kKHN0
cnVjdCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQ0KPiBAQCAtNDMwLDcgKzQ0MCw4IEBA
IHN0YXRpYyBpbnQgZHdjM19xY29tX3N1c3BlbmQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgYm9v
bCB3YWtldXApDQo+ICAJICogZnJlZXphYmxlIHdvcmtxdWV1ZS4NCj4gIAkgKi8NCj4gIAlpZiAo
ZHdjM19xY29tX2lzX2hvc3QocWNvbSkgJiYgd2FrZXVwKSB7DQo+IC0JCXFjb20tPnVzYjJfc3Bl
ZWQgPSBkd2MzX3Fjb21fcmVhZF91c2IyX3NwZWVkKHFjb20pOw0KPiArCQlmb3IgKGkgPSAwOyBp
IDwgcWNvbS0+bnVtX3BvcnRzOyBpKyspDQo+ICsJCQlxY29tLT5wb3J0c1tpXS51c2IyX3NwZWVk
ID0gZHdjM19xY29tX3JlYWRfdXNiMl9zcGVlZChxY29tLCBpKTsNCj4gIAkJZHdjM19xY29tX2Vu
YWJsZV9pbnRlcnJ1cHRzKHFjb20pOw0KPiAgCX0NCj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0K
DQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpU
aGFua3MsDQpUaGluaA==

