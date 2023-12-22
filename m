Return-Path: <linux-kernel+bounces-10074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E981CFB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241441C22CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8EA2F844;
	Fri, 22 Dec 2023 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="p3x0Ng0g";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AhWfOk5U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j5rQeQSc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F442EAF7;
	Fri, 22 Dec 2023 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4jDI011880;
	Fri, 22 Dec 2023 14:14:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=oXEg/ng4PKwYXKyNnixepLLwA5Q9AzwEpRH26PIg7x4=; b=
	p3x0Ng0gjDZl6zMDfIp6Rmzoytiq9rTCbzg+fX9rVGV/D5HGuO+3QIJ3bDo0eyxG
	UAGRDuBT1Uht5pQRwwvGq55UepSs33oVyt45gqSZEGdrVKw5cidz9rqDgd/QjPle
	xAZymVBvgpfxnAHIdNUzWafmOAhwitweoEPlNr16kKIn64utH2kh6sHnKhZB+/Eh
	VejIko+/0tMJQQkUYnC8UHXnhF9bfFD9mPR2o3nllgBDWsfm1gmw0QRCY726XVup
	magLpTaXiF28GxC7//ZfQdxsbv1V0qfgq0U9TuQzbeLL0SdGqH2Bv3+9aMl+PMic
	mjkH1iwY4kaeRiNchENJnQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpvrd5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703283247; bh=oXEg/ng4PKwYXKyNnixepLLwA5Q9AzwEpRH26PIg7x4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AhWfOk5UADwHRgVa1dxccPjINfE9mvrPvxeef10/p0QqNslwRaelfOo9tcbHa+84b
	 6PjSg0LVMe8+ngKvGUtu3w/AkHproCgWPdM3OFS886qdfjdHWeHrd8F7lJiU7z5NdG
	 xvS5X++I4zJBfjxYOzEu0ODOHGQcS+UpT0kCFnoAjvWc0NkrC8bvjOPGPl0QMy3TGR
	 jXcp6/aIHV8voSr3UmvalyY0bebZ9P5SsyndEfyiwm8rAGh5qldJFshNE5spY/27+O
	 ZWKG3QugEFSDVcoQJj1Qy/Tu0ETfZ5hBSxm9yAoIVUhybZlqg5Iw7kocWiG79+R/B0
	 y0Q+fXGlNSjCw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 04BA040542;
	Fri, 22 Dec 2023 22:14:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A65E1A007A;
	Fri, 22 Dec 2023 22:14:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=j5rQeQSc;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7BD4140356;
	Fri, 22 Dec 2023 22:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObR2axeVGi3UTuKcvRP/5S9jVQLQwl+crs9Q0ZtQPCIPWWqtP7q8AkZ/c0qPXFQ23o0BFK66GKMPGc2hpAOLh3w6YEj0arv/UDVW4sLyHMvrSmY46gXO5g7iOweNy5eRzy9ATcLAwk9DcP+FV7gj2IASjgzaZMoY7K8AHWe5WYNJlDT7Za0h8MdsnxsS745A0Z7lZNLG2jlnFwRHBU/meXBuIeCgPCElBJOd3bcckXJ0q5lei3RqnB1O3SEj7Me+RQZ5H1mVGpB0iXhn564856Q0g+7GIvKVgvWtoxsQkWVTyvdnhDyha/Dm0zRNFK9992mW/0LqAwuRbBFz1AnhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXEg/ng4PKwYXKyNnixepLLwA5Q9AzwEpRH26PIg7x4=;
 b=SdrzC8oLwqa+KH6KrzexWDbfnNw0szfMcaVFcrAsHbUoNhTWBPLOhkQCoxQFpQyQObA1hGBXXxKPM/Gpa0wgmTwBtGNEQzX+K5OgwA9Ay8ewWWq2OzEzCi6eeIDP5NIK4REJHoCFHhInhe8OGBDXw/JYSZNYBanyOA5Q3bRuSwEeWsdFEkiYnaPkOhGaHid+CVK7wXBMbNWyVh6yJY0IKFucfAQtqCDf3ic8hYFMCfEf3lOsjPL97OtV8l7LJxwyVVJqQTAw5/C9KoB+dLPOxA6LiB/al+1+QoHqEuYkw9kgxG0gZ7X/jBVhze5UrW8SgWaY0wtxE8Fmr+tQngRatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXEg/ng4PKwYXKyNnixepLLwA5Q9AzwEpRH26PIg7x4=;
 b=j5rQeQScUPwWrq4Guqxb+GBzXO0tIsHZkeP3kuYNccxLOcuslwMYf5+CMwoF6BTuutwsmZjbEd/oGIsx+vWN9OYaXRvCNZoPwcbGzq2cGuycwB1Q7sDTDolMkEgEhQ+Xgo+tp3nTm8KGRzaCXOt/KBdGogUQnhNPnANLKj+qBdg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:14:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:14:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v5 2/2] usb: dwc3: qcom: Rename hs_phy_irq to
 qusb2_phy_irq
Thread-Topic: [PATCH v5 2/2] usb: dwc3: qcom: Rename hs_phy_irq to
 qusb2_phy_irq
Thread-Index: AQHaNKFqov3w9AFGnUyji+LLKBG0wrC13xKA
Date: Fri, 22 Dec 2023 22:14:02 +0000
Message-ID: <20231222221401.ftvrkwlxdbe7zxkz@synopsys.com>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-3-quic_kriskura@quicinc.com>
In-Reply-To: <20231222063648.11193-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: a4cb4ac0-5a65-4770-c96e-08dc033b4db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 51uedNHX+O6p3uL2kLREI7TP5Hvp0FH343FFPhPPgfgTTtwEhkgG3mRYxj97gzN2CgaSVsm6dMAV+1PFtIn18m23zBAsa5kIY3hOiNNT9s9lJWNSTqXmXH7547q+0TXh7ATuIi2gkTfP6KJubCL+BILXzXssueyw6yo0I5p1EjKzX4/VfqTaKLL2CmBbC5RPYXctFEVYmJZNzsxXPlC7vDEIB6syz0yE+n959FpVby1IgaT+zFP5kdjyvo75rhG1rJAm/Nr89XYBSCURcoADIglOevSc/hkPyjVU3rfCv/umaqSMeJFR0M3bYMEs3z9zMhJxmm+IymPrNo7OqWN1pyh6KYq8/tRd0Ex3Dg17Z22YGdp/SYcywqOIW4maoQqqto7SdQqpzTCRjp9dQ7KiUvzAojLvRGA2ZN7sT+CWrFtDOxFNmZ81KkttybBZg0+lI6RNmbPRRMTvh91vW0W8Be2BVEE8ZiZzbLwIZIAIBy80B7gYKHenEhCZqPBxFNb9GPx+YDO5dqj05izCd8kSrj88mno5tSRyDiUa1UTcZZyIhxDeD0oPPFHwAHoDxFdnO++i7mQC5xzAfxXvZHXw5G+vqfLfqbNRx4Ac1VJOgvHhX9lBGtUNqlLYiZS6eeWU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(64756008)(8936002)(76116006)(66476007)(6916009)(5660300002)(54906003)(8676002)(66446008)(316002)(66556008)(2616005)(26005)(83380400001)(1076003)(66946007)(4326008)(38100700002)(122000001)(478600001)(6486002)(86362001)(2906002)(7416002)(41300700001)(38070700009)(6506007)(6512007)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWdJdjlSRnNmd1BhNXBuMm5wblNCaERuRWZhdWViQVdNR3dMZEcrTEJBazBJ?=
 =?utf-8?B?VVVrTmp2Y1FIZ2Q4b2xhVW83WWVXV2ptSmVDY3ZneTlPSFJpYnlWRWRyaEly?=
 =?utf-8?B?V1JjWUU2U3pKL0RtRlFETE9XUnlnKzN3OTQ2ZllyRVVXYXNVL01VVzF0R0VD?=
 =?utf-8?B?WWFxSHUvQmRYTVh5SzQzMGxaQnJ6MjNwMi9kY2NYYjMrNDJRVi9wM0JtSHFU?=
 =?utf-8?B?aDQwRlV5WVZaY2xkMjE3aVp1ejN3MGJsWWNjSkpNbjYzMmN0RnpWdjhpSU1E?=
 =?utf-8?B?MDR3OVJBUDlTV1dRSGcrS0I4bG1NbmFsK054b3NoRlVjQ1liWVBGNEdRU3Vm?=
 =?utf-8?B?UXo3T0NVZm5PRnFGSUpabGptaW9WdzNQN3FSVGdDb1JLTi8yQ3VBdlIrM0Za?=
 =?utf-8?B?MEtEclBpOVBxdjFoSitnNk1YVWM1c09sWmVzV1RmZWZpZFgyVEJWa0E2WDRy?=
 =?utf-8?B?WE8weFZNZDFMNnppSXIvTXFoL0IxUkVxdFBLREtUNTZ3cm91SjVTUVlQTm1y?=
 =?utf-8?B?T3BCVmNoMk41TGJkUnBBM1NNb3FyVHh1V0NoUnluWnRINi9rZmVteE82d3h0?=
 =?utf-8?B?UnRYRzlGR0l5dnhJcGRwMmF3eVFBakFRVHZkQzFlRE9tUUk3OWNwZFVPRGtI?=
 =?utf-8?B?dW9IbWRyWWt1aFJXc3l3RVdXaU5rTHVEd2IrVHRNNC9wYWkvNFZKK1NkVTVD?=
 =?utf-8?B?NkZMNmRUeEdqSmZoNnFnd29jSWZmMnJBVFEvN2ppV0lUYUN3OFc2RWlNUjhE?=
 =?utf-8?B?L1ZCOGs0NTREQzNtWHNRVDRXUTZ4Y3kwQm1IemwxYnQwZTI2QTRjaWFyVTFs?=
 =?utf-8?B?NmFBWDdsSTVsWURkVC9TUnZHbDYwQWphemdlUTZVcGVMQnJSTjFraCtYeHpw?=
 =?utf-8?B?R2VONUtJd0FxWVE0cDJWSEQ2cGpzVUM2dFVoVDdNUzBVVmFGM0tGeVBsWTlO?=
 =?utf-8?B?aXJxNHV3SUVka1hVNUhMUUFmTlh6STFHS2h4SGppeG5rWnM3ODloWjQ1REg1?=
 =?utf-8?B?Y0dUc3hBUXoxZXozdlk3T3I4QVBBSVkrZkUyV1RrL1grZ092QXA2Viswbngr?=
 =?utf-8?B?d2d2WEd4MjZiVU11SDV4bFVTLy9oRkwxN21RNVRzWmQxdnVHdk5QbXV0bG1s?=
 =?utf-8?B?cG56NjNDaEdYdlpmdi9GYVdNNjhJM2xTMmFPT1FYUW80dEdrUzF2WEFSOU5W?=
 =?utf-8?B?aXFOcVhzYlhqb280Y1RtcjBjYTQ5eXIwdllpajN6WURZdGY5L3FBRUVueSty?=
 =?utf-8?B?N1FmaVM2ZStHNEU3MitzR0ZSbzAyWHA2UkQ4U2NUYk9SUWJWSzhNdld1ZlpP?=
 =?utf-8?B?KzAvR0xhK01KeFFXdDduaS9zeDNuK1QxMWEzZ0ZwZldTTG8rN3d5cWRsSlRk?=
 =?utf-8?B?N0diM2o5enlXV2ZIM0tjRmhDWUtaUkpJRDJqaU50dkF1eGhFWUI4T2pZZ2d5?=
 =?utf-8?B?ODdOdEpOQit4VTVUYWovVk5zOERXWk9CR1JqYmVCVFJCcUJ1RUNzY0dUYVlC?=
 =?utf-8?B?U1RmaG9KZTFMQUdWRTZ2d21YbU5zeEJDL2J6WXplYzFabU1jaE0vU043MzlC?=
 =?utf-8?B?UFFLT2JFcmd0NGhmL0IrZ2FXQUdUYTQ4bEg3R3JlcjcwZlExaWxqaGFJVkpk?=
 =?utf-8?B?WG1RODlyTnAzYkdJeTNWZkpBaXpUalJvMlJtU1czZmRQTzFSK0szWWhjajMw?=
 =?utf-8?B?V1RISWRmeXNFcDYvWjZON292ZnNvTVhCMnBLcGNUMnBNZm9uQkJnK2hlT002?=
 =?utf-8?B?NFA0Z0dFcm80WUtQZk1mem5CM2toWUw2USs3eWZwT3paMXZYb1Z2NXVyUzJE?=
 =?utf-8?B?UEJ2bHlUdlFrMmNzUnVnY3diRTJpajM1Sm55ZlloeEEzYUxuZnYySi9oMy9H?=
 =?utf-8?B?OVFEbWdHOU8zd0FuaXl6ejB4dkl4Z1FtQUs1bWtUYlgrNjlOSzI4TkNiM0pF?=
 =?utf-8?B?S0xkdVdrNWU2WTVjT0hkSEFKS0kxd25hNWNFU29CZ0s1Zzg2NmY2UTdHTVZ5?=
 =?utf-8?B?RHF4QkN2YTdmWFlaUEd1VWVqOUpFVFdhN0tmVCtSRkRuUlRHR2pNVHlVcFRD?=
 =?utf-8?B?aWJYaS9ya0hWRENqa1Z0SGMwRFovb3FWNXo4ZzhGcFdKcUJFekphSFk4OU1q?=
 =?utf-8?Q?MV1NeRv4p2pv/Bx80YZV5/73C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DCCE2F94421544E852B7FA36B8474F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2qmwQlu2aV+Pl4TrEqlUm+j1YCWzLoDEHJo45sWeJ3GmAowl12CsverShVzjOlsLG5Re4mb90lqJVfMc4R5LV6jDQ1GuAepvDXnj+zBdoyR07QoWVDiDaUvLqQucLmBQ31UYI8104VxtUUfQo4tWd/PWjSCpaHQ0p/FJvhN6xcypg5BQLofTnXFrkP/93Swat6GJKpMzih2KTaHQwVS/MVM6FwHAlh+foTikOdVpYGHo6iJuHoL64swOU7gqcgDbpX8EqY2KVlPcgIz7Q3mJ8hM+xuj2zeNPiHbg7dVUpzUfG41OWKamE/0V79iIxvw0j9SLKcoWDKgr6rln1dWB5blXi24Xpl//eeM8AZEp5WDJffGAF3XpGYUxLHIoT4q0B/udFzRMS6fHZF0+6wBC/SKEilP6Sq+8lcFCQjOeTPkVCy+RAVIPIRi1R2VNuEPZtBvsF7hirrqMtlAT/ezkDDkdRZFDGGBUJ+0MzcOahP+7TwPEYAB84g40FsAnceHHk8EmQZss8I38AhGWZDzFR/r5xO3bpXyuRpu6vibvgh51mn99GRd+AfADMf58p5A9iMul0TisdZdPZ8UT/Pw6a2k/Dopq1fhY1o7dvCwv61+P4WKI3YiZwEYiIALfRITTMVsMW1AgE2cZH6Z9hDuD8Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cb4ac0-5a65-4770-c96e-08dc033b4db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:14:02.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wg3m5s/poe94NxSCKUExKKnoaxS4kxaNQubNvsE1nazTHNOG+WFU9jO87tc5Rmg9sK5ClmURGQnehbhg7zywhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
X-Proofpoint-ORIG-GUID: wsZHHh6WLyGJkJe8TAwITYGbG4RPZpgS
X-Proofpoint-GUID: wsZHHh6WLyGJkJe8TAwITYGbG4RPZpgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=825
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220163

T24gRnJpLCBEZWMgMjIsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEZvciB3YWtl
dXAgdG8gd29yaywgZHJpdmVyIG5lZWRzIHRvIGVuYWJsZSBpbnRlcnJ1cHRzIHRoYXQgZGVwaWN0
IHdoYXQgaXMNCj4gaGFwcGVuaW5nIG9uIHRoZSBEUC9ETSBsaW5lcy4gT24gUVVTQiB0YXJnZXRz
LCB0aGlzIGlzIGlkZW50aWZpZWQgYnkNCj4gcXVzYjJfcGh5IHdoZXJlYXMgb24gU29DcyB1c2lu
ZyBGZW10byBQSFksIHNlcGFyYXRlIHtkcCxkbX1faHNfcGh5X2lycSdzDQo+IGFyZSB1c2VkIGlu
c3RlYWQuDQo+IA0KPiBUaGUgaW1wbGVtZW50YXRpb24gaW5jb3JyZWN0bHkgbmFtZXMgcXVzYjJf
cGh5IGludGVycnVwdHMgYXMgImhzX3BoeV9pcnEiLg0KPiBDbGVhbiB0aGlzIHVwIHNvIHRoYXQg
ZHJpdmVyIHdvdWxkIGJlIHVzaW5nIG9ubHkgcXVzYjIvKGRwICYgZG0pIGZvciB3YWtldXANCj4g
cHVycG9zZXMuDQo+IA0KPiBGb3IgZGV2aWNlcyBydW5uaW5nIG9sZGVyIGtlcm5lbHMsIHRoaXMg
d29uJ3QgYnJlYWsgYW55IGZ1bmN0aW9uYWxpdHkNCj4gYmVjYXVzZSB0aGUgaW50ZXJydXB0IGNv
bmZpZ3VyYXRpb25zIGluIFFVU0IyIFBIWSBiYXNlZCBTb0NzIGlzIGRvbmUNCj4gYnkgY29uZmln
dXJpbmcgUVVTQjJQSFlfSU5UUl9DVFJMIHJlZ2lzdGVyIGluIFBIWSBhZGRyZXNzIHNwYWNlIGFu
ZCBpdCB3YXMNCj4gbmV2ZXIgYXJtZWQgcHJvcGVybHkgcmlnaHQgZnJvbSB0aGUgc3RhcnQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNp
bmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCAyMiArKysr
KysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gaW5kZXggZmRmNmQ1ZDNj
MmFkLi5kYmQ2YTViMmIyODkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1x
Y29tLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBAQCAtNTcsNyAr
NTcsNyBAQCBzdHJ1Y3QgZHdjM19hY3BpX3BkYXRhIHsNCj4gIAl1MzIJCQlxc2NyYXRjaF9iYXNl
X29mZnNldDsNCj4gIAl1MzIJCQlxc2NyYXRjaF9iYXNlX3NpemU7DQo+ICAJdTMyCQkJZHdjM19j
b3JlX2Jhc2Vfc2l6ZTsNCj4gLQlpbnQJCQloc19waHlfaXJxX2luZGV4Ow0KPiArCWludAkJCXF1
c2IyX3BoeV9pcnFfaW5kZXg7DQo+ICAJaW50CQkJZHBfaHNfcGh5X2lycV9pbmRleDsNCj4gIAlp
bnQJCQlkbV9oc19waHlfaXJxX2luZGV4Ow0KPiAgCWludAkJCXNzX3BoeV9pcnFfaW5kZXg7DQo+
IEBAIC03Myw3ICs3Myw3IEBAIHN0cnVjdCBkd2MzX3Fjb20gew0KPiAgCWludAkJCW51bV9jbG9j
a3M7DQo+ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wJKnJlc2V0czsNCj4gIA0KPiAtCWludAkJCWhz
X3BoeV9pcnE7DQo+ICsJaW50CQkJcXVzYjJfcGh5X2lycTsNCj4gIAlpbnQJCQlkcF9oc19waHlf
aXJxOw0KPiAgCWludAkJCWRtX2hzX3BoeV9pcnE7DQo+ICAJaW50CQkJc3NfcGh5X2lycTsNCj4g
QEAgLTM3Miw3ICszNzIsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBf
aXJxKGludCBpcnEpDQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9kaXNhYmxlX2ludGVy
cnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIHsNCj4gLQlkd2MzX3Fjb21fZGlzYWJs
ZV93YWtldXBfaXJxKHFjb20tPmhzX3BoeV9pcnEpOw0KPiArCWR3YzNfcWNvbV9kaXNhYmxlX3dh
a2V1cF9pcnEocWNvbS0+cXVzYjJfcGh5X2lycSk7DQo+ICANCj4gIAlpZiAocWNvbS0+dXNiMl9z
cGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7DQo+ICAJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9p
cnEocWNvbS0+ZG1faHNfcGh5X2lycSk7DQo+IEBAIC0zODksNyArMzg5LDcgQEAgc3RhdGljIHZv
aWQgZHdjM19xY29tX2Rpc2FibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0K
PiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3
YzNfcWNvbSAqcWNvbSkNCj4gIHsNCj4gLQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNv
bS0+aHNfcGh5X2lycSwgMCk7DQo+ICsJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20t
PnF1c2IyX3BoeV9pcnEsIDApOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBDb25maWd1cmUgRFAvRE0g
bGluZSBpbnRlcnJ1cHRzIGJhc2VkIG9uIHRoZSBVU0IyIGRldmljZSBhdHRhY2hlZCB0bw0KPiBA
QCAtNTQyLDE5ICs1NDIsMTkgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBfaXJxKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaW50IGlycTsNCj4gIAlpbnQgcmV0Ow0KPiAg
DQo+IC0JaXJxID0gZHdjM19xY29tX2dldF9pcnEocGRldiwgImhzX3BoeV9pcnEiLA0KPiAtCQkJ
CXBkYXRhID8gcGRhdGEtPmhzX3BoeV9pcnFfaW5kZXggOiAtMSk7DQo+ICsJaXJxID0gZHdjM19x
Y29tX2dldF9pcnEocGRldiwgInF1c2IyX3BoeSIsDQo+ICsJCQkJcGRhdGEgPyBwZGF0YS0+cXVz
YjJfcGh5X2lycV9pbmRleCA6IC0xKTsNCj4gIAlpZiAoaXJxID4gMCkgew0KPiAgCQkvKiBLZWVw
IHdha2V1cCBpbnRlcnJ1cHRzIGRpc2FibGVkIHVudGlsIHN1c3BlbmQgKi8NCj4gIAkJcmV0ID0g
ZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShxY29tLT5kZXYsIGlycSwgTlVMTCwNCj4gIAkJCQkJ
cWNvbV9kd2MzX3Jlc3VtZV9pcnEsDQo+ICAJCQkJCUlSUUZfT05FU0hPVCB8IElSUUZfTk9fQVVU
T0VOLA0KPiAtCQkJCQkicWNvbV9kd2MzIEhTIiwgcWNvbSk7DQo+ICsJCQkJCSJxY29tX2R3YzMg
UVVTQjIiLCBxY29tKTsNCj4gIAkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2VycihxY29tLT5kZXYs
ICJoc19waHlfaXJxIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsJCQlkZXZfZXJyKHFjb20tPmRl
diwgInF1c2IyX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gIAkJCXJldHVybiByZXQ7
DQo+ICAJCX0NCj4gLQkJcWNvbS0+aHNfcGh5X2lycSA9IGlycTsNCj4gKwkJcWNvbS0+cXVzYjJf
cGh5X2lycSA9IGlycTsNCj4gIAl9DQo+ICANCj4gIAlpcnEgPSBkd2MzX3Fjb21fZ2V0X2lycShw
ZGV2LCAiZHBfaHNfcGh5X2lycSIsDQo+IEBAIC0xMDU4LDcgKzEwNTgsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGR3YzNfYWNwaV9wZGF0YSBzZG04NDVfYWNwaV9wZGF0YSA9IHsNCj4gIAkucXNj
cmF0Y2hfYmFzZV9vZmZzZXQgPSBTRE04NDVfUVNDUkFUQ0hfQkFTRV9PRkZTRVQsDQo+ICAJLnFz
Y3JhdGNoX2Jhc2Vfc2l6ZSA9IFNETTg0NV9RU0NSQVRDSF9TSVpFLA0KPiAgCS5kd2MzX2NvcmVf
YmFzZV9zaXplID0gU0RNODQ1X0RXQzNfQ09SRV9TSVpFLA0KPiAtCS5oc19waHlfaXJxX2luZGV4
ID0gMSwNCj4gKwkucXVzYjJfcGh5X2lycV9pbmRleCA9IDEsDQo+ICAJLmRwX2hzX3BoeV9pcnFf
aW5kZXggPSA0LA0KPiAgCS5kbV9oc19waHlfaXJxX2luZGV4ID0gMywNCj4gIAkuc3NfcGh5X2ly
cV9pbmRleCA9IDINCj4gQEAgLTEwNjgsNyArMTA2OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZHdjM19hY3BpX3BkYXRhIHNkbTg0NV9hY3BpX3Vyc19wZGF0YSA9IHsNCj4gIAkucXNjcmF0Y2hf
YmFzZV9vZmZzZXQgPSBTRE04NDVfUVNDUkFUQ0hfQkFTRV9PRkZTRVQsDQo+ICAJLnFzY3JhdGNo
X2Jhc2Vfc2l6ZSA9IFNETTg0NV9RU0NSQVRDSF9TSVpFLA0KPiAgCS5kd2MzX2NvcmVfYmFzZV9z
aXplID0gU0RNODQ1X0RXQzNfQ09SRV9TSVpFLA0KPiAtCS5oc19waHlfaXJxX2luZGV4ID0gMSwN
Cj4gKwkucXVzYjJfcGh5X2lycV9pbmRleCA9IDEsDQo+ICAJLmRwX2hzX3BoeV9pcnFfaW5kZXgg
PSA0LA0KPiAgCS5kbV9oc19waHlfaXJxX2luZGV4ID0gMywNCj4gIAkuc3NfcGh5X2lycV9pbmRl
eCA9IDIsDQo+IC0tIA0KPiAyLjQyLjANCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRo
aW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

