Return-Path: <linux-kernel+bounces-36299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22623839E96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AB01F28567
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843A4684;
	Wed, 24 Jan 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X/TuN6wG";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wk0Ozbjm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ee72b8YY"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D33D8F;
	Wed, 24 Jan 2024 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062346; cv=fail; b=ikADF8ro7iJoeAsCOo4GMLyUwBP1zbNYZTmvr95O1dPvzoDUCQ0P53wu4qKpRdXIq0B8SpZwHRoZnZVLYaY5iqztmkcfCfbGF/o6DyRHiBdkpmM7NAikUJ0iE7ppbuOvK7A3Fleps5o+Z9A402rM40rqPqPMts5O8MWjtVhtc1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062346; c=relaxed/simple;
	bh=JSwNRXPsefnOkKCwYbEfiG+8Uxr+b2WeqLApzanZy3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OKEiOXfjwIO8XP2JkAqNCStB9WzHk9iY6idNPnjB5A+cUhXPdY5QyoWOhMcf94cVE7FtVP/MiU6m3Xr0sGbgc8wpIoitW0vAtcFC0J4aRffhkCWAzVxboZDXhCE/7tXIYMiKzWeB31ZO5NbetiRzPghsTKL4HKUrIYV9nS9DuLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X/TuN6wG; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wk0Ozbjm; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ee72b8YY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NNxlOZ012364;
	Tue, 23 Jan 2024 18:11:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=JSwNRXPsefnOkKCwYbEfiG+8Uxr+b2WeqLApzanZy3g=; b=
	X/TuN6wG4xH/jiCE6osaxN726giFX60Ju1fiaDNjJ6p3+rVKri3kBrAVuyX5GdJR
	v9ZF2n/jTQEPWWmsjQYZu/vsqw4MG3v9CAYAoYauXV/wecwDzKfrZWwfH/z65mF3
	2G+LS9/yKRk1eLNJDdNDrjrzUQxtPYuhUCL/u1m9uI7OxFszwGJ89hTTRMrK2nnu
	gsycA3egChMSOGgYc+V+a8Z7c0Krxkd2LATHr+GsTPGTY3b6KFSge3c9xI1pXEM+
	3QodzP37UqGYMueFUvmngfeMJWq5db4SxPmcXxJIyYe4KYp7oQRUjwX5pR3yxv7l
	E7g3lz14ffK0/NRrd/jVVw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vtmgts5eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1706062311; bh=JSwNRXPsefnOkKCwYbEfiG+8Uxr+b2WeqLApzanZy3g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Wk0OzbjmPeO9DAWY6Y98nWusPAwBZQ8Jy7KdNI5TYZSFfBho/xDNKcGx+WlMmPnJY
	 lL/w3bWEixQ1XE7DtmjaaacTyE8ursYEbYnfdOTTZDR2dL/YqN0kMeajdYb11nlIly
	 fa/K6PZq1RECk1mpLYhp20FWb9YfQpqikLjFsotvdpv2kdQ2keWgteXH3AKarCBcgP
	 /2evlyhyjpDZ93Pc65NKcM6bO/nK80nv1qq1hX/PNHpdcHjn0u9+Jni1Cio5h6f+A6
	 a6GgXKrZks0A8v0o9Fvsjtut3F8jofZjNJBSFx2I8z1MmOBgGeGQ1sjzoqaVgEzv+w
	 kutFXfqeTg2kg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6529A40453;
	Wed, 24 Jan 2024 02:11:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 919A2A00A3;
	Wed, 24 Jan 2024 02:11:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ee72b8YY;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2E392403B9;
	Wed, 24 Jan 2024 02:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3ryjQ7LmlvavD3Vd3EhlSoR+Y8ppPNSGxkjpMFiNVqAfpfXHNCt+dVt7hourWmarn7mqzKPnXdjWdH7G5woH13FxpLX/thncUl5Y7MbLBGr065qpBZXazkW/lmIP1jRTsX+U3GxJBcIZtQ8B8Kgx3UKeNHLmFhI/kmqd20Xnp8Teo7JRzK8DDsmT2SCWE6v0xmkvwzusqa5SezKzYKjRumpQKnf2P+vK/V9e205lOKefzMcSmzQivU+C+BHBsJrfZYLvUTWqBXiEvJ/gKrvAn3vnYc8gsaDR/x5otVKnq/ED5Qz+O0y/lVzHJ6SrpPbpld6MZWmwAarjLcDqQSlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSwNRXPsefnOkKCwYbEfiG+8Uxr+b2WeqLApzanZy3g=;
 b=JujYN3c0Zbjb5X81AwI9j8D5nKFfEKDnKgDi7Qujars8IVeXDWUCphdYl3cpjvm2LiEuw9zBr3me15qCDoCiqassbWzYZE4f4o0G28DO+B/JRS9Zgnkp+o2WwYxqCfeBv9Tzk82VtXRa5hTlSP0KbYC4WT8S9FGBWlHUnHSaFIe8121fxKN+MPdOgSopG7R2FGQTOnHltSyq3q/OlQm8FSMQ/vNBerwE4HzJUydoi67jKMBAkFfUIjMt4WYY1QwPcfG//O0t41fmMxSKlHTxiF6iRpZdsmCp2I25oWvjgxqwYh492SheGH6H3TxnKuVQSYxZJiBGW2QmX1mx5Xmr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSwNRXPsefnOkKCwYbEfiG+8Uxr+b2WeqLApzanZy3g=;
 b=Ee72b8YYV0QYNkiM7bNUQo7Ce6dyHcovciQTgvTTtwvdQhwS4/saA8bByIveXDL5gUgove8+PnEj1b2ZXuBUyDBbsW7nDwaqN1B3INJf6RreAtt7FBv4n8vgjK1FN2BYHTjWHh9MAfkDfiGVGqw+FHAWqTUnNcCYXu0ALQOfwfg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 02:11:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.033; Wed, 24 Jan 2024
 02:11:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "pku.leo@gmail.com" <pku.leo@gmail.com>,
        "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 3/3] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Topic: [PATCH v3 3/3] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Index: AQHaThtEELKx6BFeCEe9nhrbrvvrabDoOSEA
Date: Wed, 24 Jan 2024 02:11:44 +0000
Message-ID: <20240124021142.wacy3jntbhiis7ci@synopsys.com>
References: <20240123164241.3689109-1-Frank.Li@nxp.com>
 <20240123164241.3689109-4-Frank.Li@nxp.com>
In-Reply-To: <20240123164241.3689109-4-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8753:EE_
x-ms-office365-filtering-correlation-id: fa8b8158-75d2-4e68-d25c-08dc1c81cfdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X/UQtSU5ZRxnUgEG7UosHqyngV1wQKzrN4PxF09v9r8Y8bt7NU5UFuMPxLuHtCqVmOBV9BX1Ud8LCxtdvh5IUd+nNqyHgf0jQFl4305wFu4dt8CJWaaQyE7H7PJkbP/GfTzDtOjMxTm+HZo6FiaiEkyvZWVsB2tmXUz8/AjKVbX3jfMNW77GzO2Mv7nmiYtL4fivqTW/0jLM3iGUwzb2hLaW6WOUJ36VnTVK5apTdZVJUVcpTR/6+n14USP5yhNRYo+g1DwTAYtBE6ghgy24CKHM2KgmciohxT7eQqHs5VqbWStS2WjBjEHsqitIEPdb5lvnFYRklC7rR7/fEHOgl9hikR4NdAuZiCZEAnQiDX86/BCsOoPAKBYp7CCC7FhjDzdc91Guub47/ZbSCM+jpgOaOJGHD2RQflNA/fu68e9z1eP2lk6IOzzQBhXpYLkv9UpMjMEDn/ndDpAaZIl6NFGMvPEkoPh6a5ClQd6rFdySomMJVqhsvYJ6PDkFvRtN3G1kifNJmeVz1KoyTB7ZaDB1nxasfnfG/wQ7ZDGi8G69i7S2rnP2iAC7CdKIHI5lsmdiII4cwkvUL80u9QKhajWxV4XpkFDtFVWuNwPsmhM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(966005)(6486002)(45080400002)(71200400001)(83380400001)(1076003)(38100700002)(122000001)(8676002)(6506007)(4326008)(5660300002)(8936002)(2906002)(7416002)(26005)(66946007)(66446008)(86362001)(36756003)(6512007)(41300700001)(6916009)(2616005)(316002)(54906003)(66556008)(38070700009)(76116006)(66476007)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SkZCM1YvMm5ieE5hU0FtTzcxaElITGl5TFA0dU9GdGVqWWN1UExEa3lYK29l?=
 =?utf-8?B?MGhFMjlIS28venptSEk3cGhrOGxlM0xnREZ0SkovNDBzOWw4cnZ5RGVDcE1Y?=
 =?utf-8?B?b0JFU29QcElOVE5wNTM5b1Q4M2xRM3FEM2dmOEJaVXdCRXhJaUMzdmwwUGVR?=
 =?utf-8?B?K2hYeWxjSUV1c3dUVWlLUTNGOU1RT08wUDcyTVpjRmpzV2szQlo5QXdtWlM2?=
 =?utf-8?B?a2hRK2hMTEw5akJPZFVPQjJDMFZxeVZhNlF6L1RRYmNZNEVKUm1Ydm9RZHd4?=
 =?utf-8?B?ZnlOZ2lMYVVKUFZ1eWp0VlBTNWI2OVNFeG1UOTBmb20zNEhqYWphN2dxMWVC?=
 =?utf-8?B?SUlVdUdxMmNZR3E3RVFKV05vRHg4aG0ybUtzR1hHTmZ5dHBHSU15M2YwR3hR?=
 =?utf-8?B?K3RYZzl3YUNkVWZ1a05nZkVrUndHM2hIUFY0bjFnYjJZbDJTR0Mzei91L0hp?=
 =?utf-8?B?TC85cUVKMDI3d0RQS1BPelZIL0VTcmNOMVdVWFl3YXRRWXpNamtnbzRUYVlx?=
 =?utf-8?B?emRmUXU5N3VCZWM3Yjh2Z0t2WmJIdStHc0ZmYlFXRXhWQjJxMTZyMmc5djRs?=
 =?utf-8?B?RWZMSGprOTBlZ25SRmFQZHJ4UXg3RzBoekZsTDhDSjdFSXN2RWQyLzhhcFJT?=
 =?utf-8?B?eWJ2MncyYkZ5eUNRSTVkaHo5c0hVTDRQek1UWnpSWVhJT3g3SlpjN1dENHVs?=
 =?utf-8?B?dnB2M0cwbmpnVjdTcDI3RkNBdlQwYWRNM09KSWZ5ek9qZi9ONjRHaTlnRVZh?=
 =?utf-8?B?eUlnRDg3d3VFVER0dTl1U0dqR0s2UFR2N0g3czFsbktMVXhFZ0tZcWFkbkFD?=
 =?utf-8?B?MU12Y0d1M3ArTW5DTGxwTjF2N01YUlB3YXFXNUxlL3d3RFpOSUZXOUlsQU5R?=
 =?utf-8?B?UVlWRmRUQ1ZBWktNcThtWjJMSm1BdTcrTGJRRkloZEZ3SWFWZ0ZLeXAxUUkx?=
 =?utf-8?B?TUh3d1ZYTjAwVEszNVJXRnFlQjNGR28yRTB2Tis0YmlqOXRqcHZESDdSVEZX?=
 =?utf-8?B?ZHpWOFVvaXdUUXd5Tm5PV0tFSXFyQTdDanJNQWxaV0hxVW5XdEI3bC9OZmtW?=
 =?utf-8?B?R21aejlqQ0dZR1F3MGRweVZCcWhhYlI3NG5Vazl0cGpqb3ZwQXN2UExCZWxn?=
 =?utf-8?B?U09JaGl4RTJKSk8vQldZUFBFeXl0UGlmTm4wdWcrNTZrMEQ1cVpWRUxnb29I?=
 =?utf-8?B?RHliVlVtdkxIMWxtY0VkRTN3VHN0V2lGSlkvTTFVLzFjdHhha2syRHh1QkJJ?=
 =?utf-8?B?eVJWSXc1NnJxbWlKL2Zjam1UbUY3NElOSjlOS25VYzhQZWJndnhqeHRtR2N0?=
 =?utf-8?B?THpQaW5taHlaYno3U2pLWWwwRDNRZWllUExrSWEwM2Z5Sk15M2htRGxPLytw?=
 =?utf-8?B?ZnpmdHJXdmM0dWlRdzdNY2hIYmdNcVZsNGZ5VldmY3EyWVdQR1dvbXhvQnli?=
 =?utf-8?B?QXNHa0JsbU1sR2FZNXdncy9kbzYvbG9NRERPOVJlZFRTcW9Id3hZZXFLTkFa?=
 =?utf-8?B?MmtBUURIY2xOaGEvTlhEVEdEaU5DbUdlQ0YrWnpkV0ZjSk82bldXTk96Q25M?=
 =?utf-8?B?cFNFOVljaTUzU0ZPZjZKQ3JmK0E1SHN3VXpJZ0lMc1lEbDhnbFptWlI1YXVF?=
 =?utf-8?B?ZjJVUVJHaHJhMkxKd2pxbXl2c0RBZzRscUNGWXY3R2lFUDdFL2djQ2FkaWRI?=
 =?utf-8?B?cUU2VmpIRGZNbnJ2NU0xZXFuUDVoSjl5Y2cxam9WVG9HelpvajFZeWhXbndW?=
 =?utf-8?B?ZkN3RzltWUlzbWFvNGpjYk1tLzVvd3J0cXpxd3JhNUg3ZW9QS3oxRzZjMUZQ?=
 =?utf-8?B?T0pPQW1ERWtkbFZSV2RYYUdXeWI4MVlzdENYRldrditQOW41d3FIdllkVy9n?=
 =?utf-8?B?aWQ3RnU2R3RqTjBDeEVPR3hpcUxta2kzSlRTVEJpUm9mb2VmLzV1OUVYQkg4?=
 =?utf-8?B?bzJDLzV1ZzRNSFpaNWJiTnlWWVBBUHFyZnAzd2dsK2JQb2s3anhTNU5NdVR5?=
 =?utf-8?B?eW1nM0VXV045VUx6TVV3TDhHNmlNTnUxUXEyNzZJNzAvQUk4SjBmbG9sQllW?=
 =?utf-8?B?MEtsdE9YcW5NSG4vd1BrWE00L3JUcXVMcmg2TjdZeHZDM2lUWmJJTk4wWEFo?=
 =?utf-8?Q?z3CVwa+SDQYB1xZlbuHaOIvuz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85A654B708B8DE44B9B5FD25B5A8BA30@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+8IpVRefhluP6NcWz7FPk42X97Q+mt0jRPwNKd5pTmgPsPDdGZIiYtIpYoZMG4agT6qUKv9pAbY8VO0uk/ADMqL8WbXxxyPZgcjXVpFf8biIuARn/5qD6fBULa+Qx0Pj/6pZwAsZnAuWbNwOzCDJ+bSuQOPLh6GTtFQfD4Daz6hFjHy2CutIvsnNpUh83y/8DEcSuh+0dz70vrB6akr8O7h+NkTJoH6usOW5h/Y0dbvIETHZMp7JyQXCEYSpbsXeWl6bfoTnbEjpULMuxKkH9EusBXwg78komIb1si3IIdond5ZMpKX28aWrEkCWQRLwADV0HVbLGNOxOY+ZADr+U+oTQ+AQXwvzUvGNR/FCisphm0ZHbi0WgItKJdsd75Lux7F2oFdMNk5wJfpYELSqspI7c347VIYd/RbcIRJvAIe4250KpxujEha3W0w45f424d+JiyF7w+ih5MKZGIuXo/aos24Jk/FDiBEgNYxZUvLmxivnI4Y+dY1fUM1mxfRzQGxLlHFQTh+lUIO1mV/hEfdgg05H4MB3r0KlmJfPnuCnHdG+gAYKOjHRfrF7pggqQUDqx4wV+VN5kz09L/EKiUppaFYR6iGW0S8htvXsFFGePw2F9/gmOOLffHkDEhdjC0egyvEqHx2OnNyKD8tcyA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b8158-75d2-4e68-d25c-08dc1c81cfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 02:11:44.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBQ6uuxKkzBqhC2Q6kYbByP00d/M0vlrETYStIeLVAQKE6SXqKq8Qj3UM6zGbQ0hQOqsTObx3/e6TUJ+q45Hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
X-Proofpoint-GUID: -Tlz7jJ4EyoswK07sZ7a0tSbQ0S4NOPJ
X-Proofpoint-ORIG-GUID: -Tlz7jJ4EyoswK07sZ7a0tSbQ0S4NOPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240015

T24gVHVlLCBKYW4gMjMsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBGcm9tOiBSYW4gV2FuZyA8
cmFuLndhbmdfMUBueHAuY29tPg0KPiANCj4gV2hlbiBEV0MzIGlzIHNldCB0byBob3N0IG1vZGUg
YnkgcHJvZ3JhbW1pbmcgcmVnaXN0ZXIgRFdDM19HQ1RMLCBWQlVTDQo+IChvciBpdHMgY29udHJv
bCBzaWduYWwpIHdpbGwgYmUgdHVybmVkIG9uIGltbWVkaWF0ZWx5IG9uIHJlbGF0ZWQgUm9vdCBI
dWINCj4gcG9ydHMuIFRoZW4sIHRoZSBWQlVTIGlzIHR1cm5lZCBvZmYgZm9yIGEgbGl0dGxlIHdo
aWxlKDE1dXMpIHdoZW4gZG8geGhjaQ0KPiByZXNldCAoY29uZHVjdGVkIGJ5IHhoY2kgZHJpdmVy
KSBhbmQgYmFjayB0byBub3JtYWwgZmluYWxseSwgd2UgY2FuDQo+IG9ic2VydmUgYSBuZWdhdGl2
ZSBnbGl0Y2ggb2YgcmVsYXRlZCBzaWduYWwgaGFwcGVuLg0KPiANCj4gVGhpcyBWQlVTIGdsaXRj
aCBtaWdodCBjYXVzZSBzb21lIFVTQiBkZXZpY2VzIGVudW1lcmF0aW9uIGZhaWwgaWYga2VybmVs
DQo+IGJvb3Qgd2l0aCB0aGVtIGNvbm5lY3RlZC4gU3VjaCBhcyBMUzEwMTJBRldSWS9MUzEwNDNB
UkRCL0xYMjE2MEFRRFMNCj4gL0xTMTA4OEFSREIgd2l0aCBLaW5nc3RvbiAxNkdCIFVTQjIuMC9L
aW5nc3RvbiBVU0IzLjAvSmV0Rmxhc2ggVHJhbnNjZW5kDQo+IDRHQiBVU0IyLjAgZHJpdmVzLiBU
aGUgZmFpbCBjYXNlcyBpbmNsdWRlIGVudW1lcmF0ZWQgYXMgZnVsbC1zcGVlZCBkZXZpY2UNCj4g
b3IgcmVwb3J0IHdyb25nIGRldmljZSBkZXNjcmlwdG9yLCBldGMuDQo+IA0KPiBPbmUgU1cgd29y
a2Fyb3VuZCB3aGljaCBjYW4gZml4IHRoaXMgaXMgYnkgcHJvZ3JhbWluZyBhbGwgeGhjaSBQT1JU
U0NbUFBdDQo+IHRvIDAgdG8gdHVybiBvZmYgVkJVUyBpbW1lZGlhdGVseSBhZnRlciBzZXR0aW5n
IGhvc3QgbW9kZSBpbiBEV0MzIGRyaXZlcg0KPiAocGVyIHNpZ25hbCBtZWFzdXJlbWVudCByZXN1
bHQsIGl0IHdpbGwgYmUgdG9vIGxhdGUgdG8gZG8gaXQgaW4NCj4geGhjaS1wbGF0LmMgb3IgeGhj
aS5jKS4gVGhlbiwgYWZ0ZXIgeGhjaSByZXNldCBjb21wbGV0ZSBpbiB4aGNpIGRyaXZlciwNCj4g
UE9SVFNDW1BQXXMnIHZhbHVlIHdpbGwgYmFjayB0byAxIGF1dG9tYXRpY2FsbHkgYW5kIFZCVVMg
b24gYXQgdGhhdCB0aW1lLA0KPiBubyBnbGl0Y2ggaGFwcGVuIGFuZCBub3JtYWwgZW51bWVyYXRp
b24gcHJvY2VzcyBoYXMgbm8gaW1wYWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcg
PHJhbi53YW5nXzFAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFBldGVyIENoZW4gPHBldGVyLmNo
ZW5AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+ICAgICBDaGFuZ2UgZnJvbSB2MiB0byB2Mw0KPiAgICAg
LSByZXZlcnNlZCBjaHJpc3RtYXMgdHJlZQ0KPiAgICAgLSBwbGVhc2UgbW92ZSBtYWpvciBjaGFu
Z2UgaHVuayB0byB0aGUgdG9wDQo+ICAgICAtIFJld29yZCAiV2UgaGF2ZSB0byAuLi4iIHRvICJT
b21lIHBsYXRmb3JtcyBuZWVkIHRvIC4uLiAiDQo+ICAgICANCj4gICAgIENoYW5nZSBmcm9tIHYx
IHRvIHYyOg0KPiAgICAgLSBzcGxpdCB4aGNpLmgNCj4gICAgIExhc3QgcmV2aWV3IGF0IEp1bmUg
MDYsIDIwMTkuIEZpeGVkIGFsbCByZXZpZXcgY29tbWVudHMgYW5kIHNlbnQgYWdhaW4uDQo+ICAg
ICANCj4gICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1rZXJuZWwvQU01UFIwNDAyTUIyODY1OTc5RTI2MDE3QkM1OTM3REJCQTVGMTE3
MEBBTTVQUjA0MDJNQjI4NjUuZXVycHJkMDQucHJvZC5vdXRsb29rLmNvbS9fXzshIUE0RjJSOUdf
cGchWUVzQ3lLSy1kQzdjTURKRU5ZcFU3eEMyY2ZIaExhM1NuWG9lZFBZZ3RTM2pQMmJhcjRURjdo
QWNqMmlIWTFNcTFkcUlYY3NoQldHbWNlbzlmZGpGJCANCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyB8ICAzICsrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgMiArKw0KPiAg
ZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBpbmRleCAzZTU1ODM4YzAwMDE0Li4zYjY4ZThlNDViOGI5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBAQCAtMTYyNiw2ICsxNjI2LDkgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVy
dGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNl
X3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7
DQo+ICANCj4gKwlkd2MtPmhvc3RfdmJ1c19nbGl0Y2hlc19xdWlyayA9IGRldmljZV9wcm9wZXJ0
eV9yZWFkX2Jvb2woZGV2LA0KPiArCQkJCSJzbnBzLGhvc3QtdmJ1cy1nbGl0Y2hlcy1xdWlyayIp
Ow0KPiArDQo+ICAJZHdjLT5scG1fbnlldF90aHJlc2hvbGQgPSBscG1fbnlldF90aHJlc2hvbGQ7
DQo+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9IHR4X2RlX2VtcGhhc2lzOw0KPiAgDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IGluZGV4IGUzZWVhOTY1ZTU3YmYuLmRmNTQ0ZWM3MzBkMjIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IEBAIC0xMTMyLDYgKzExMzIsNyBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4g
ICAqCTIJLSBObyBkZS1lbXBoYXNpcw0KPiAgICoJMwktIFJlc2VydmVkDQo+ICAgKiBAZGlzX21l
dGFzdGFiaWxpdHlfcXVpcms6IHNldCB0byBkaXNhYmxlIG1ldGFzdGFiaWxpdHkgcXVpcmsuDQo+
ICsgKiBAaG9zdF92YnVzX2dsaXRjaGVzX3F1aXJrOiBzZXQgdG8gYXZvaWQgdmJ1cyBnbGl0Y2gg
ZHVyaW5nIHhoY2kgcmVzZXQuDQo+ICAgKiBAZGlzX3NwbGl0X3F1aXJrOiBzZXQgdG8gZGlzYWJs
ZSBzcGxpdCBib3VuZGFyeS4NCj4gICAqIEB3YWtldXBfY29uZmlndXJlZDogc2V0IGlmIHRoZSBk
ZXZpY2UgaXMgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cC4NCj4gICAqIEBzdXNwZW5kZWQ6
IHNldCB0byB0cmFjayBzdXNwZW5kIGV2ZW50IGR1ZSB0byBVMy9MMi4NCj4gQEAgLTEzNTMsNiAr
MTM1NCw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gIAl1bnNpZ25lZAkJdHhfZGVfZW1waGFzaXM6MjsN
Cj4gIA0KPiAgCXVuc2lnbmVkCQlkaXNfbWV0YXN0YWJpbGl0eV9xdWlyazoxOw0KPiArCXVuc2ln
bmVkCQlob3N0X3ZidXNfZ2xpdGNoZXNfcXVpcms6MTsNCj4gIA0KPiAgCXVuc2lnbmVkCQlkaXNf
c3BsaXRfcXVpcms6MTsNCj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJhY2tzOjE7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5j
DQo+IGluZGV4IDYxZjU3ZmU1YmI3ODMuLjk1MmQ3M2QwNWRmZmEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+
IEBAIC0xMSw4ICsxMSw1MiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICANCj4gKyNpbmNsdWRlICIuLi9ob3N0L3ho
Y2ktcG9ydC5oIg0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS1leHQtY2Fwcy5oIg0KPiArI2lu
Y2x1ZGUgIi4uL2hvc3QveGhjaS1jYXBzLmgiDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgDQo+
ICsjZGVmaW5lIFhIQ0lfSENTUEFSQU1TMQkJMHg0DQo+ICsjZGVmaW5lIFhIQ0lfUE9SVFNDX0JB
U0UJMHg0MDANCj4gKw0KPiArLyoNCj4gKyAqIGR3YzNfcG93ZXJfb2ZmX2FsbF9yb290aHViX3Bv
cnRzIC0gUG93ZXIgb2ZmIGFsbCBSb290IGh1YiBwb3J0cw0KPiArICogQGR3YzM6IFBvaW50ZXIg
dG8gb3VyIGNvbnRyb2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUNCj4gKyAqLw0KDQpJZiB5b3UncmUg
dHJ5aW5nIHRvIGZvbGxvdyB0aGUga2VybmVsLWRvYyBzdHlsZSwgdGhlbiBwbGVhc2UgZG8gaXQN
CnByb3Blcmx5IHdpdGggdGhlIGtlcm5lbC1kb2MgY29tbWVudCBzdHlsZS4NCg0KLyoqDQogKiAu
Lg0KICogLi4NCiAqLw0KDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3Bvd2VyX29mZl9hbGxfcm9vdGh1
Yl9wb3J0cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXZvaWQgX19pb21lbSAqeGhjaV9y
ZWdzOw0KPiArCXUzMiBvcF9yZWdzX2Jhc2U7DQo+ICsJaW50IHBvcnRfbnVtOw0KPiArCXUzMiBv
ZmZzZXQ7DQo+ICsJdTMyIHJlZzsNCj4gKwlpbnQgaTsNCj4gKw0KPiArCS8qIHhoY2kgcmVncyBp
cyBub3QgbWFwcGVkIHlldCwgZG8gaXQgdGVtcGVyYXJ5IGhlcmUgKi8NCj4gKwlpZiAoZHdjLT54
aGNpX3Jlc291cmNlc1swXS5zdGFydCkgew0KPiArCQl4aGNpX3JlZ3MgPSBpb3JlbWFwKGR3Yy0+
eGhjaV9yZXNvdXJjZXNbMF0uc3RhcnQsIERXQzNfWEhDSV9SRUdTX0VORCk7DQo+ICsJCWlmIChJ
U19FUlIoeGhjaV9yZWdzKSkgew0KPiArCQkJZGV2X2Vycihkd2MtPmRldiwgIkZhaWxlZCB0byBp
b3JlbWFwIHhoY2lfcmVnc1xuIik7DQo+ICsJCQlyZXR1cm47DQo+ICsJCX0NCj4gKw0KPiArCQlv
cF9yZWdzX2Jhc2UgPSBIQ19MRU5HVEgocmVhZGwoeGhjaV9yZWdzKSk7DQo+ICsJCXJlZyA9IHJl
YWRsKHhoY2lfcmVncyArIFhIQ0lfSENTUEFSQU1TMSk7DQo+ICsJCXBvcnRfbnVtID0gSENTX01B
WF9QT1JUUyhyZWcpOw0KPiArDQo+ICsJCWZvciAoaSA9IDE7IGkgPD0gcG9ydF9udW07IGkrKykg
ew0KPiArCQkJb2Zmc2V0ID0gb3BfcmVnc19iYXNlICsgWEhDSV9QT1JUU0NfQkFTRSArIDB4MTAg
KiAoaSAtIDEpOw0KPiArCQkJcmVnID0gcmVhZGwoeGhjaV9yZWdzICsgb2Zmc2V0KTsNCj4gKwkJ
CXJlZyAmPSB+UE9SVF9QT1dFUjsNCj4gKwkJCXdyaXRlbChyZWcsIHhoY2lfcmVncyArIG9mZnNl
dCk7DQo+ICsJCX0NCj4gKw0KPiArCQlpb3VubWFwKHhoY2lfcmVncyk7DQo+ICsJfSBlbHNlIHsN
Cj4gKwkJZGV2X2Vycihkd2MtPmRldiwgInhoY2kgYmFzZSByZWcgaW52YWxpZFxuIik7DQo+ICsJ
fQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2hvc3RfZmlsbF94aGNpX2lycV9yZXMo
c3RydWN0IGR3YzMgKmR3YywNCj4gIAkJCQkJaW50IGlycSwgY2hhciAqbmFtZSkNCj4gIHsNCj4g
QEAgLTY2LDYgKzExMCwxMyBAQCBpbnQgZHdjM19ob3N0X2luaXQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIAlpbnQJCQlyZXQsIGlycTsNCj4gIAlpbnQJCQlwcm9wX2lkeCA9IDA7DQo+ICANCj4gKwkv
Kg0KPiArCSAqIFNvbWUgcGxhdGZvcm1zIG5lZWQgdG8gcG93ZXIgb2ZmIGFsbCBSb290IGh1YiBw
b3J0cyBpbW1lZGlhdGVseSBhZnRlciBEV0MzIHNldCB0byBob3N0DQo+ICsJICogbW9kZSB0byBh
dm9pZCBWQlVTIGdsaXRjaCBoYXBwZW4gd2hlbiB4aGNpIGdldCByZXNldCBsYXRlci4NCj4gKwkg
Ki8NCj4gKwlpZiAoZHdjLT5ob3N0X3ZidXNfZ2xpdGNoZXNfcXVpcmspDQo+ICsJCWR3YzNfcG93
ZXJfb2ZmX2FsbF9yb290aHViX3BvcnRzKGR3Yyk7DQo+ICsNCj4gIAlpcnEgPSBkd2MzX2hvc3Rf
Z2V0X2lycShkd2MpOw0KPiAgCWlmIChpcnEgPCAwKQ0KPiAgCQlyZXR1cm4gaXJxOw0KPiAtLSAN
Cj4gMi4zNC4xDQo+IA0KDQpSZWdhcmRsZXNzIHdoZXRoZXIgeW91IGRlY2lkZWQgdG8gdXBkYXRl
IHJlbGF0ZWQgdGhlIGNvbW1lbnQgYWJvdmU6DQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRo
aW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

