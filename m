Return-Path: <linux-kernel+bounces-136065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B463389CFAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D796B1C22214
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0E79DF;
	Tue,  9 Apr 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EUT33Q2o";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a0tbJhe4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iPYvtmUl"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6DAD21;
	Tue,  9 Apr 2024 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625175; cv=fail; b=jpxjpKG8VmH74J8lU4W8sgthpiZNYWGfZVE95xhC77QWX8Qvb9G4/9AeK5LvSVmG2KsuIUUfzObuPO1zSDcQ8aezKoMH7OG3JW3r7JCesxaWFxIVU9GE2P0bZsUGZBRGMltddiQBDglSQ0plrxHUVgiH8lPIKITr/5Q2F/rpL0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625175; c=relaxed/simple;
	bh=+Wx2toEWGdd357DrDjSDILR5xIcsOUK2wXmfhEW3SS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1QZKJyulNvWN7ckQc8EaSB0B0vw6BjKGdW1nHdo6kvNu4KAWj48X10IXUMKtllwU4acje+SbpitAYf3hnv5eZxegCSIShio8RcDXRBj7PV79O6FIdycs+NiKNaPdPtaQaqqx3rg0QROYjoeEnlxCD/xgg6B4bT73hvKhnj6TIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EUT33Q2o; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=a0tbJhe4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iPYvtmUl reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438LA1H7006946;
	Mon, 8 Apr 2024 18:12:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=+Wx2toEWGdd357DrDjSDILR5xIcsOUK2wXmfhEW3SS8=; b=
	EUT33Q2oxEtAZnUcT0GzJKSe9kjWkMNOH7i/ul3xkJPLekUJAUlqvjCY3HwI3oDH
	aNfq8CL80TySBVWJx8ob0/5AddpDqi4rZ5Avz3fomnKWXwWMbXQVrShfSSsMUdDj
	TtRve87Hy6bRBu+5hccxi8jt/r2b0fmxug5c3ioK4dLqamKy59NGu7IDIiC4Gkje
	86Iaj+rk+8d83ZOieTZoLkGcrtaEQL1BOYyfmdF2nK4DMyq4XPZiv8n6iLvXcgwe
	pYiuYqjvfNKrGZcfyL6E28szV2G/YESYMp2YukYqZBXFiFZQebjOH+f22+24T5FC
	A9+z6HkyLob25C0QLXXjpg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5asfbs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712625164; bh=+Wx2toEWGdd357DrDjSDILR5xIcsOUK2wXmfhEW3SS8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=a0tbJhe4cQAIOa0nJuce0LAZtz8kiq5RMNbmHFjVj/Fl8bGa8gKsDnd74UbgkM2QY
	 8z4JWoum9VABdNPnIqHIMZvUPF/3Nh+00/SwCIy5XVumDcNkIJ1UAPxcPO+spdkVD8
	 RpI6tCx8GHYs7pa0m3XJr9b6JCNgeCeInyRSR4TJt5lebHqAGJfx5tLqceyGFPTZUf
	 GPRQ7RsQpkJsTqFQHAtkR9IqGYvmWqcfyC+1Zh6sEeQlUCzdHhIAnLzTNokkk2oEJz
	 TItkBVVJmNUHFpG1pMhueYRWHHbztNchK29EbDDQLj0n0pYFiX2VsPDCeeocpziJ9K
	 krvq0Jfj1++0Q==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BD75D401C6;
	Tue,  9 Apr 2024 01:12:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 46432A0263;
	Tue,  9 Apr 2024 01:12:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iPYvtmUl;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 400A840346;
	Tue,  9 Apr 2024 01:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/KYbz/8b2bjgEHOnQ1aCnmtk7D2ExqLlqPgzc34kTH2MywrdKG+s/CHT7Zgg3Xu46ffR4T5cQEf6ROw1ksVUkwDuZqq4hSh1MG2iBnAswKawwsejrJlpMbdn8WIKSsk9QtFNXunaj7ApsEPDyQFiVbeZkeIdxFIpCFMKqmgq4ZVNS8T1M9df8pautDjtZwHls9KV91hnP+8VEa6diVq3GV0pBzjWHdzb0sgmT9ZZrkfsQ1yckXhVzoHt+s2vnEDzqa8ia0Zny5ts97lX3QyPduFOBhajAtZ4TZnmc4X3CGLmHB/kcpBS1ehgZp1SO4yksiKcc2s9MFCBcnpT3m0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wx2toEWGdd357DrDjSDILR5xIcsOUK2wXmfhEW3SS8=;
 b=DQfAIcb3mA5exWpEeM+aCRr94B0SA7iybya6Y/o5CSKn2AQ+etqXF48uXdeqxqnBrZSIkrvRbfHIWLQOm225jHn03qopPUr2auYQVn/sjyaMY0NEJD3xtbr3zogGDwhFsnHDUHQWdwmn/NGRp581AQDMVdfBT7EtI3JsgkzW0dL+nxD/zVGcjm/jBPnivVvwwiLTlxorhgd4FhrvJ1oHa62L+QA+DXuafNdTWFeLYERK4TE8igTH3G78hECzGwut4w5+3uwBZO2K5dqUa9Klne0r+1sU3G9Ijwo+KpWlwH5VR/nO2VHCDX5GfhnCqtxV7E+R2XO1+VkTEcGfVR94VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wx2toEWGdd357DrDjSDILR5xIcsOUK2wXmfhEW3SS8=;
 b=iPYvtmUlNxFXIDKyFh+bMwuOtdKTc8EivGPR20y950J171BsieU1ZttrMg7kkCbVHdIuCxLDIbf2C4tpiLZSW+9Jyu2MiH1i6nwKtfaljXR9DSMXyUqdTZfdg4KGfo546BnJvPDqqHnRTCQkdgcOKRjbc9yF5lkbhjQzRmvl6m0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:12:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:12:40 +0000
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
Subject: Re: [PATCH v20 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Topic: [PATCH v20 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Index: AQHaibjwn0C3KIlAxk6DpopLGGSE1LFfIpKA
Date: Tue, 9 Apr 2024 01:12:40 +0000
Message-ID: <20240409011237.5lsaqtuclgmarzic@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-7-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-7-quic_kriskura@quicinc.com>
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
 PAqzM17Hl3kgSC6TA9mA/tQEqG219PdsgGO1lKi1Qvm4ZycPKEqdDx/N76Nx+amElHfvEPpXO0Oh31Rb252EI4cUFSLTCq5OgqX7ssnOYhomdvyUp5L+FpF984por2tcfJtJg+6/Tuy3hWv/9IXiN7Ts79SmZRx+Lt0b99aFQUDT0tX8DlvbOZ/VEXp9h/RmwbZbQUc/pFsnYIdInSjnfOrf1nBTjL5Jx0IZQxwEK/wwrdNvrX8RtFAiW6qdmCWP5jKuZdbuMeiYFieh8DZSJiURoF8J0291BkJeIo1LjQREPJ5We9wcDcA+gl6EMhfMlXATdcW+Nb8BiU1PZrLpcHTj2oRw/wRnKNEWjQ2s6o8Ev4h3BP8Je75kW8NofJoVpakijaGMmbK28ncFkuG4QIr4ZPgdCgr6FSDimj3yrdvVedf4nyQ8tlhWukoYFvc64qB6v/dfUhNVd4yhyOhWf5dLq7RitH4bsz0SUTV1MfOgGCvHXHCyt7ekMbRoJ6Om061CBwdDikH0WxcnRTWT3mcvSMcbYOErNxke7LcJAg2OCC2m0TTBP5SMtRZefA9QXvW3T2cCFvHarKXmRiob31YMRxAC3m8/eeg4+eJFRqRLvo47J/m2WDxTub0Pkk9KfpHkpCENs0JHJLIysMlWKnI8mW2fzl4b+JBS+pb5tsw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L21zNzhmY0hERUpaMDk0K1BzNGtmQzFWYmd6SmtXZEhtMkd1VStPdlAxWFNC?=
 =?utf-8?B?RXFIZ2NFZGxxci9UZWJkdzlMV2ZjaUFER293dWM0WmJRays0bjYxNjVmOUhN?=
 =?utf-8?B?RjlLUlZNY2g2RU55SGlsUXJLWjA4WG52cGxKa1NqTk5rQmR5VHpTaU5maWkv?=
 =?utf-8?B?UGpFYVBjdXJjRElONEJuanJaa0ZrdXdiNEJRd1B3VSs5NC9tUnM3R1BRd1NF?=
 =?utf-8?B?US9DOFl0YmdydmRnR0pmeGhRb2swSDV2VHNnZ1NyYVRrM0psU3NuY3llZEF1?=
 =?utf-8?B?cWlCc1FMTGhxcEZUWWMvZ2tDajZCWkpiVkI2WkdodXh5QmxxYTMrTEtJTlZJ?=
 =?utf-8?B?M3AzTUNWOEJlSjF2VmFLSEJvTGxPRUJMSmFDOTZ0QnZ2dTBmM0p1dXM3Q2kv?=
 =?utf-8?B?UTZ4ZnBZS3dGVG1wRlJQNDRHVWc0YWdwczdrVzZMQk1TbDdtQU44cVdOMjlz?=
 =?utf-8?B?b0ppTmlpSFJ3Vi96MjhHZkhrQXZ4SUF2eHVLdElrdTZDakVQTGtHY0JZS1c3?=
 =?utf-8?B?WnA0WVExM1VIWFExTDVNaEZxQWdMTWp6OTY3KzZwUVlIWXExQkVlYWQvc3pH?=
 =?utf-8?B?OUFCb1dHcC9RbWtMa2xjN3gyeHVYWTRVdWFRK0N5L2hoZllhT0F1OU4yckdu?=
 =?utf-8?B?eXo5R3B6TlRvTFBzOU5udi8xT1RiSVFnVzBDaVowSFl6USt0UkVYTkZqTWxh?=
 =?utf-8?B?ckhJeHN1V251cFc2R2M3TXFhSFVOVTYzM3hXeThGN0tQZlMxM2t2WC9vcitF?=
 =?utf-8?B?RDFDNnFBQlNid0VjSWNiSU50Ymt4a0l3UHh0dGhLOWtEb21mRDJLSDAzTUhW?=
 =?utf-8?B?cGhrb0dwank0ZUQ4N2wyOGZ6RjJEVmY4anc4UDkyb0EzUlZxMlhmYzZ5b2ww?=
 =?utf-8?B?YU1xdWNtN1gzS25VTGx4SDlEa0NDandzaEdZWnJOdGRjWTZRazlEQTNYNUFC?=
 =?utf-8?B?OE45M2dIbTZBNUFMNmRTeDB0V3FMalVYTUh2ZEYyQzNId3FOc0RiNXRLNXQv?=
 =?utf-8?B?T1Baa0huK3YxWGkrWFVZZkk4QjI4L3hNSFNIWFFUNnlDWW1JdzNheUZjajFJ?=
 =?utf-8?B?UEw1Q0tRWGJZakNDMHZaYjZEUVpNWlBsTzArU05IS005dEV3bDQ3WmdMRkh0?=
 =?utf-8?B?VnZ1MUZRQmpNeGY3THJZYitkNmUvRDNyMnV5Yjh4RGRxeWJLM3Njb0IySWFH?=
 =?utf-8?B?aEpzUE5EVERjeFdQZUI3c0NHN29URE5VLy84aTB6V0g2VWZtR1A0VUVBMmZT?=
 =?utf-8?B?KzJ6c2pxc2tpdGlneFRjM3ZpTVBudjNjZWg5SXJhNHpXbEhDcHlRVEE1a1JM?=
 =?utf-8?B?L2hCUnRpUkJOY3FCMWg5Nmg5UXZydFduOGorakRERWxCVk5qRmsvdDNoNSsx?=
 =?utf-8?B?THR6TXFKVEJ0UFJWSFB0cTZkSE9EMEJ6OTVIYjh2V3Ivd216UHZ2R1h2Qysy?=
 =?utf-8?B?UjB4OHhSTGFncVpNNTdmM3pVb2o4S1phT0tTYWtOMzhUQy8ybmlaRDJsSVlS?=
 =?utf-8?B?YUM0SmlFUDB0VGJOWTVHUEp2NURPS1JkZE80dDJSZjdBZmNsamtVOC9NYys2?=
 =?utf-8?B?MkpwQ21NOTNKY0NvTU05RkNaY0YwUVFYMldzeXRxa2hvY2YwdC9VOWtnWURy?=
 =?utf-8?B?Uk94NFVtMDZnYjVmS1EzRG5McitJV0VTSUYzSFI1VVF4K2NxSzIxOFlDdXdh?=
 =?utf-8?B?aWlTMlhIemljSkl0MS9LbDhYOVpCMG5zcVJxN2gxcjVBNVRSSXluOWRJNUUz?=
 =?utf-8?B?YlhLUVVUNzhNa1pHWXBWUnRPRFRTSklaVDNwSVBVdGliK05maW9mc3RWOXpF?=
 =?utf-8?B?RVJuZFI2ZHpGcVZLWGdHZWE5Z0dIM2ZteCtIWWpCLzNOOXhuRTM2dHl1aWlP?=
 =?utf-8?B?Z24rTlo3Z21wTmdCQjh0aEYvRmtmalB0ZzdjVmE1cFBVdjNaU2J1TlhvT3dB?=
 =?utf-8?B?L1Q1cXEwRm9JYytPcjhJSlNCQ2hsdkhGWGRJbW0zLzZndnFDblErb3JpdUdH?=
 =?utf-8?B?Sk9QNkZBN2ZYSjlHVURlaGZBNjhob3VlZS9UN2l0dG9Vd1lTa3Zjc2hLMkNk?=
 =?utf-8?B?VU5SRjQvWmdDa0Rrc3l3VUEzUzFuV0JZU1hNVENITi9sVGtraDM2MkMzMHA5?=
 =?utf-8?B?cGQ4QmxsM3FwSExtcTBjWTJ2emlJSERieXZJVGt0czgxaHp2T1pSOC9POUZL?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DBCF4E99057184C9844F03F22E42C0E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V2QVp53ZCnjF5jrhPQItc90StiQXAohlr4aQq9IkJcd+1xsnHnNyysfiG3x+yisqpOFr8N3FX4xOvvI5+r9rvm7KL/dXYG6Zd6jKtQL7MgdI5aMmPY6RKQxMWflLTZf3oV6IkO3836dyV8P0UAz5a4fkhrRsupTurLXfOa0DAmJT9nWMajHF0WthEBIbwfJ172IekMqA8j9C2qfvTqfg8w85ffLUBCn5a6bZcqbh5DikpzMVUHboIOTU2E0rNWwvfRqEHyhzgOP+FL0eVoA4BKxL9NPlysxMkPo+8GVFBpLWk9KTBr09nWVAUbQO11ZjCepzgelAUd6WtO1zneudfzZKjJM+oz42NWRrayJe+qmCH2SeYdYPxOxabnYYPLBFtwEaiDVrg7i9rwAxoNRd9WoQaTdjaEJy2Jrr6WG7UmENNqszYOzWIdwsmKbOrOEevQSKN/0+mJ3tKnl6lVfDWwuWt9ut3QjWm98wxQJWO16FbeQDCgAfCXs3ITTZUjUXkRfJN2jObb+EFC8DDflqmyZ9E1UwuQqkJCgwKoXul3lmRTO09vYNRNmYE4JKsvxfth9J/+1600u2Qm05XD0SxLBxav4eS7O2516z0/HbsSeZ+EN7IwyT9xqDGQjKdNIfjN6lmvSWYi2ZaImkvvKYYA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df6ff4b-df4d-479f-4440-08dc583226ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:12:40.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/J1v1bU5EB73q3Ks/TYu4VlDz6kVk54l2iyy0WwA8hikIAeES6rb/hbDAfgfGtR26qiwarnwNvrs+UWAt+V1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Proofpoint-ORIG-GUID: aTqkqmipzkI0u4xFAlsV2z0N8Bk6MtJA
X-Proofpoint-GUID: aTqkqmipzkI0u4xFAlsV2z0N8Bk6MtJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090003

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFRoZSBsb2dp
YyBmb3IgcmVxdWVzdGluZyBpbnRlcnJ1cHRzIGlzIGR1cGxpY2F0ZWQgZm9yIGVhY2ggaW50ZXJy
dXB0LiBJbg0KPiB0aGUgdXBjb21pbmcgcGF0Y2hlcyB0aGF0IGludHJvZHVjZXMgc3VwcG9ydCBm
b3IgbXVsdGlwb3J0LCBpdCB3b3VsZCBiZQ0KPiBiZXR0ZXIgdG8gY2xlYW4gdXAgdGhlIGR1cGxp
Y2F0aW9uIGJlZm9yZSByZWFkaW5nIG11bGl0cG9ydCByZWxhdGVkDQo+IGludGVycnVwdHMuDQo+
IA0KPiBSZWZhY3RvciBpbnRlcnJ1cHQgc2V0dXAgY2FsbCBieSBhZGRpbmcgYSBuZXcgaGVscGVy
IGZ1bmN0aW9uIGZvcg0KPiByZXF1ZXN0aW5nIHRoZSB3YWtldXAgaW50ZXJydXB0cy4gVG8gc2lt
cGxpZnkgaW1wbGVtZW50YXRpb24sIG1ha2UNCj4gdGhlIGRpc3BsYXkgbmFtZSBzYW1lIGFzIHRo
ZSBpbnRlcnJ1cHQgbmFtZSBleHBlY3RlZCBpbiBEVC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEty
aXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5
OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCA1MyArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBpbmRleCBmNmIyZmFiNDlkNWUuLmNhZTVk
YWI4ZmNmYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBAIC01MDEsNiArNTAxLDIyIEBA
IHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9zZWxlY3RfdXRtaV9jbGsoc3RydWN0IGR3YzNfcWNvbSAq
cWNvbSkNCj4gIAkJCSAgUElQRV9VVE1JX0NMS19ESVMpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMg
aW50IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShzdHJ1Y3QgZHdjM19xY29tICpxY29tLCBpbnQgaXJx
LA0KPiArCQkJCSBjb25zdCBjaGFyICpuYW1lKQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsNCj4g
KwkvKiBLZWVwIHdha2V1cCBpbnRlcnJ1cHRzIGRpc2FibGVkIHVudGlsIHN1c3BlbmQgKi8NCj4g
KwlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKHFjb20tPmRldiwgaXJxLCBOVUxMLA0K
PiArCQkJCQlxY29tX2R3YzNfcmVzdW1lX2lycSwNCj4gKwkJCQkJSVJRRl9PTkVTSE9UIHwgSVJR
Rl9OT19BVVRPRU4sDQo+ICsJCQkJCW5hbWUsIHFjb20pOw0KPiArCWlmIChyZXQpDQo+ICsJCWRl
dl9lcnIocWNvbS0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgaXJxICVzOiAlZFxuIiwgbmFtZSwg
cmV0KTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdj
M19xY29tX3NldHVwX2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAg
CXN0cnVjdCBkd2MzX3Fjb20gKnFjb20gPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4g
QEAgLTUwOSw1NCArNTI1LDMzIEBAIHN0YXRpYyBpbnQgZHdjM19xY29tX3NldHVwX2lycShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJaXJxID0gcGxhdGZvcm1fZ2V0X2ly
cV9ieW5hbWVfb3B0aW9uYWwocGRldiwgInF1c2IyX3BoeSIpOw0KPiAgCWlmIChpcnEgPiAwKSB7
DQo+IC0JCS8qIEtlZXAgd2FrZXVwIGludGVycnVwdHMgZGlzYWJsZWQgdW50aWwgc3VzcGVuZCAq
Lw0KPiAtCQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKHFjb20tPmRldiwgaXJxLCBO
VUxMLA0KPiAtCQkJCQlxY29tX2R3YzNfcmVzdW1lX2lycSwNCj4gLQkJCQkJSVJRRl9PTkVTSE9U
IHwgSVJRRl9OT19BVVRPRU4sDQo+IC0JCQkJCSJxY29tX2R3YzMgUVVTQjIiLCBxY29tKTsNCj4g
LQkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2VycihxY29tLT5kZXYsICJxdXNiMl9waHlfaXJxIGZh
aWxlZDogJWRcbiIsIHJldCk7DQo+ICsJCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29t
LCBpcnEsICJxdXNiMl9waHkiKTsNCj4gKwkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+
IC0JCX0NCj4gIAkJcWNvbS0+cXVzYjJfcGh5X2lycSA9IGlycTsNCj4gIAl9DQo+ICANCj4gIAlp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAiZHBfaHNfcGh5X2ly
cSIpOw0KPiAgCWlmIChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRl
ZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5VTEwsDQo+IC0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJx
LA0KPiAtCQkJCQlJUlFGX09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwNCj4gLQkJCQkJInFjb21f
ZHdjMyBEUF9IUyIsIHFjb20pOw0KPiAtCQlpZiAocmV0KSB7DQo+IC0JCQlkZXZfZXJyKHFjb20t
PmRldiwgImRwX2hzX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0ID0gZHdj
M19xY29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwgImRwX2hzX3BoeV9pcnEiKTsNCj4gKwkJaWYg
KHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0JCX0NCj4gIAkJcWNvbS0+ZHBfaHNfcGh5X2ly
cSA9IGlycTsNCj4gIAl9DQo+ICANCj4gIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9v
cHRpb25hbChwZGV2LCAiZG1faHNfcGh5X2lycSIpOw0KPiAgCWlmIChpcnEgPiAwKSB7DQo+IC0J
CXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5VTEwsDQo+
IC0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLA0KPiAtCQkJCQlJUlFGX09ORVNIT1QgfCBJUlFG
X05PX0FVVE9FTiwNCj4gLQkJCQkJInFjb21fZHdjMyBETV9IUyIsIHFjb20pOw0KPiAtCQlpZiAo
cmV0KSB7DQo+IC0JCQlkZXZfZXJyKHFjb20tPmRldiwgImRtX2hzX3BoeV9pcnEgZmFpbGVkOiAl
ZFxuIiwgcmV0KTsNCj4gKwkJcmV0ID0gZHdjM19xY29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwg
ImRtX2hzX3BoeV9pcnEiKTsNCj4gKwkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IC0J
CX0NCj4gIAkJcWNvbS0+ZG1faHNfcGh5X2lycSA9IGlycTsNCj4gIAl9DQo+ICANCj4gIAlpcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAic3NfcGh5X2lycSIpOw0K
PiAgCWlmIChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEo
cWNvbS0+ZGV2LCBpcnEsIE5VTEwsDQo+IC0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLA0KPiAt
CQkJCQlJUlFGX09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwNCj4gLQkJCQkJInFjb21fZHdjMyBT
UyIsIHFjb20pOw0KPiAtCQlpZiAocmV0KSB7DQo+IC0JCQlkZXZfZXJyKHFjb20tPmRldiwgInNz
X3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0ID0gZHdjM19xY29tX3JlcXVl
c3RfaXJxKHFjb20sIGlycSwgInNzX3BoeV9pcnEiKTsNCj4gKwkJaWYgKHJldCkNCj4gIAkJCXJl
dHVybiByZXQ7DQo+IC0JCX0NCj4gIAkJcWNvbS0+c3NfcGh5X2lycSA9IGlycTsNCj4gIAl9DQo+
ICANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmgu
Tmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

